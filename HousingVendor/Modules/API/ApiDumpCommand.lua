-- Experimental API dump command
-- Usage:
--   /hvdump all            (dump all items from HousingDecorData, batched)
--   /hvdump start          (same as 'all')
--   /hvdump stop           (stop an in-progress dump)
--   /hvdump status         (show progress)
--   /hvdump <itemID>       (dump a single item)

local _G = _G
local tostring = tostring
local tonumber = tonumber
local pairs = pairs
local type = type
local pcall = pcall
local ipairs = ipairs
local table_insert = table.insert
local string_lower = string.lower
local string_match = string.match

-- Avoid using generic globals like `_G.Housing` (can collide with Blizzard UI / other addons).
local Housing = _G.HousingVendorAddon or {}
_G.HousingVendorAddon = Housing

Housing._apiDumpState = Housing._apiDumpState or {
    running = false,
    index = 1,
    total = 0,
    ids = nil,
    batchSize = 25,
    wrote = 0,
    startedAt = 0,
}

local function SafeCopy(value, depth, visited)
    if depth <= 0 then return "<max depth>" end
    local valueType = type(value)
    if valueType == "nil" or valueType == "number" or valueType == "string" or valueType == "boolean" then
        return value
    end
    if valueType ~= "table" then
        return "<" .. valueType .. ">"
    end

    visited = visited or {}
    if visited[value] then
        return "<cycle>"
    end
    visited[value] = true

    local out = {}
    for k, v in pairs(value) do
        local keyType = type(k)
        local key = (keyType == "number" or keyType == "string") and k or ("<" .. keyType .. ">")
        out[key] = SafeCopy(v, depth - 1, visited)
    end

    visited[value] = nil
    return out
end

local function FormatVendorCost(vendorInfo)
    if not vendorInfo or not vendorInfo.cost or type(vendorInfo.cost) ~= "table" then
        return nil
    end

    local lines = {}
    for _, entry in ipairs(vendorInfo.cost) do
        if type(entry) == "table" then
            local amount = tonumber(entry.amount) or 0
            if entry.currencyID == 0 then
                if _G.GetCoinTextureString then
                    table_insert(lines, _G.GetCoinTextureString(amount))
                else
                    table_insert(lines, tostring(amount) .. " copper")
                end
            elseif entry.currencyID then
                local currencyName = nil
                if _G.C_CurrencyInfo and _G.C_CurrencyInfo.GetCurrencyInfo then
                    local ok, currencyInfo = pcall(_G.C_CurrencyInfo.GetCurrencyInfo, entry.currencyID)
                    if ok and currencyInfo and currencyInfo.name then
                        currencyName = currencyInfo.name
                    end
                end
                if not currencyName and _G.HousingCurrencyTypes and _G.HousingCurrencyTypes[entry.currencyID] then
                    currencyName = _G.HousingCurrencyTypes[entry.currencyID]
                end
                currencyName = currencyName or ("Currency #" .. tostring(entry.currencyID))
                table_insert(lines, tostring(amount) .. " " .. currencyName)
            elseif entry.itemID then
                table_insert(lines, tostring(amount) .. "x Item #" .. tostring(entry.itemID))
            end
        end
    end
    return lines
end

function Housing:_DumpSingleItemToDB(itemID)
    _G.HousingDB = _G.HousingDB or {}
    _G.HousingDB.apiDump = _G.HousingDB.apiDump or {}
    _G.HousingDB.apiDumpByFaction = _G.HousingDB.apiDumpByFaction or {}

    local factionKey = (_G.UnitFactionGroup and _G.UnitFactionGroup("player")) or "Unknown"
    _G.HousingDB.apiDumpByFaction[factionKey] = _G.HousingDB.apiDumpByFaction[factionKey] or {}

    local decorData = _G.HousingDecorData[itemID]

    local baseInfo = nil
    local vendorInfo = nil
    local unlockInfo = nil
    local catalogData = nil

    if _G.HousingAPI then
        baseInfo = _G.HousingAPI:GetDecorItemInfoFromItemID(itemID)
        if baseInfo and baseInfo.decorID then
            vendorInfo = _G.HousingAPI:GetDecorVendorInfo(baseInfo.decorID)
            unlockInfo = _G.HousingAPI:GetDecorUnlockRequirements(baseInfo.decorID)
        end
        catalogData = _G.HousingAPI:GetCatalogData(itemID)
    end

    local itemInfo = nil
    if _G.C_Item and _G.C_Item.GetItemInfo then
        local ok, name, link, quality, itemLevel, minLevel, classID, subclassID, maxStack, equipLoc, texture, sellPrice =
            pcall(_G.C_Item.GetItemInfo, itemID)
        if ok then
            itemInfo = {
                name = name,
                link = link,
                quality = quality,
                itemLevel = itemLevel,
                minLevel = minLevel,
                classID = classID,
                subclassID = subclassID,
                maxStack = maxStack,
                equipLoc = equipLoc,
                texture = texture,
                sellPrice = sellPrice,
            }
        end
    end

    local dump = {
        ts = (_G.GetServerTime and _G.GetServerTime()) or (_G.GetTime and _G.GetTime()) or 0,
        itemID = itemID,
        faction = factionKey,
        decorData = SafeCopy(decorData, 5),
        apis = {
            housingAvailable = (_G.HousingAPI and _G.HousingAPI.IsHousingAvailable and _G.HousingAPI:IsHousingAvailable()) or false,
            catalogAvailable = (_G.HousingAPI and _G.HousingAPI.IsAvailable and _G.HousingAPI:IsAvailable()) or false,
        },
        itemInfo = SafeCopy(itemInfo, 4),
        baseInfo = SafeCopy(baseInfo, 6),
        vendorInfo = SafeCopy(vendorInfo, 6),
        vendorCostFormatted = FormatVendorCost(vendorInfo),
        unlockInfo = SafeCopy(unlockInfo, 6),
        catalogData = SafeCopy(catalogData, 6),
    }

    _G.HousingDB.apiDump[itemID] = dump
    _G.HousingDB.apiDumpByFaction[factionKey][itemID] = dump
    return dump
end

function Housing:DumpItemApiData(itemIDText)
    local itemID = tonumber(itemIDText)
    if not itemID then
        print("|cFFFF4040HousingVendor:|r Usage: /hvdump <itemID>")
        return
    end

    if not _G.HousingDecorData or not _G.HousingDecorData[itemID] then
        print("|cFFFF4040HousingVendor:|r ItemID " .. tostring(itemID) .. " not found in HousingDecorData")
        return
    end

    local dump = self:_DumpSingleItemToDB(itemID)

    local vendorName = dump.vendorInfo and dump.vendorInfo.name or nil
    local zoneName = dump.vendorInfo and dump.vendorInfo.zone or nil
    if vendorName and vendorName ~= "" then
        print("|cFF00FF00HousingVendor:|r API dump saved for " .. tostring(itemID) .. " (Vendor: " .. vendorName .. (zoneName and (" / " .. zoneName) or "") .. ")")
    else
        print("|cFFFFD100HousingVendor:|r API dump saved for " .. tostring(itemID) .. " (no vendor returned by API)")
    end
end

function Housing:DumpAllApiData(options)
    options = options or {}

    if not _G.HousingDecorData then
        print("|cFFFF4040HousingVendor:|r HousingDecorData not loaded")
        return
    end

    if self._apiDumpState.running then
        print("|cFFFFD100HousingVendor:|r Dump already running. Use /hvdump status or /hvdump stop.")
        return
    end

    _G.HousingDB = _G.HousingDB or {}
    _G.HousingDB.apiDump = _G.HousingDB.apiDump or {}

    local ids = {}
    for itemID in pairs(_G.HousingDecorData) do
        if type(itemID) == "number" then
            table_insert(ids, itemID)
        else
            local numeric = tonumber(itemID)
            if numeric then table_insert(ids, numeric) end
        end
    end
    table.sort(ids)

    self._apiDumpState.running = true
    self._apiDumpState.index = 1
    self._apiDumpState.total = #ids
    self._apiDumpState.ids = ids
    self._apiDumpState.batchSize = tonumber(options.batchSize) or self._apiDumpState.batchSize or 25
    self._apiDumpState.wrote = 0
    self._apiDumpState.startedAt = (_G.GetTime and _G.GetTime()) or 0

    print("|cFF8A7FD4HousingVendor:|r Starting API dump for " .. tostring(#ids) .. " items (batch " .. tostring(self._apiDumpState.batchSize) .. ").")

    local function ProcessBatch()
        if not Housing._apiDumpState.running then return end

        local startIndex = Housing._apiDumpState.index
        local endIndex = math.min(startIndex + Housing._apiDumpState.batchSize - 1, Housing._apiDumpState.total)

        for i = startIndex, endIndex do
            local itemID = Housing._apiDumpState.ids[i]
            if _G.HousingDecorData[itemID] then
                Housing:_DumpSingleItemToDB(itemID)
                Housing._apiDumpState.wrote = Housing._apiDumpState.wrote + 1
            end
        end

        Housing._apiDumpState.index = endIndex + 1

        if Housing._apiDumpState.index > Housing._apiDumpState.total then
            Housing._apiDumpState.running = false
            local elapsed = ((_G.GetTime and _G.GetTime()) or 0) - (Housing._apiDumpState.startedAt or 0)
            print("|cFF00FF00HousingVendor:|r API dump complete. Wrote " .. tostring(Housing._apiDumpState.wrote) .. " items in " .. string.format("%.1fs", elapsed) .. ".")
            return
        end

        if _G.C_Timer and _G.C_Timer.After then
            _G.C_Timer.After(0.05, ProcessBatch)
        else
            -- Fallback: continue immediately (may hitch)
            ProcessBatch()
        end
    end

    ProcessBatch()
end

function Housing:DumpStatus()
    local s = self._apiDumpState
    if not s.running then
        local totalDumped = _G.HousingDB and _G.HousingDB.apiDump and (function()
            local count = 0
            for _ in pairs(_G.HousingDB.apiDump) do count = count + 1 end
            return count
        end)() or 0
        print("|cFF8A7FD4HousingVendor:|r Dump not running. Saved dumps: " .. tostring(totalDumped) .. ".")
        return
    end

    print("|cFF8A7FD4HousingVendor:|r Dump running: " .. tostring(s.wrote) .. "/" .. tostring(s.total) .. " saved.")
end

function Housing:DumpStop()
    if self._apiDumpState.running then
        self._apiDumpState.running = false
        print("|cFFFFD100HousingVendor:|r Dump stopped at " .. tostring(self._apiDumpState.wrote) .. "/" .. tostring(self._apiDumpState.total) .. ".")
    else
        print("|cFF8A7FD4HousingVendor:|r No dump running.")
    end
end

SLASH_HOUSINGVENDORAPIDUMP1 = "/hvdump"
SlashCmdList["HOUSINGVENDORAPIDUMP"] = function(msg)
    local raw = tostring(msg or ""):match("^%s*(.-)%s*$") or ""
    local cmd, rest = string_match(raw, "^(%S+)%s*(.-)$")
    cmd = cmd and string_lower(cmd) or ""

    if cmd == "" then
        print("|cFFFFD100HousingVendor:|r Usage: /hvdump all | start | stop | status | <itemID>")
        return
    end

    if cmd == "all" or cmd == "start" then
        local batch = tonumber(rest)
        Housing:DumpAllApiData({ batchSize = batch })
        return
    end

    if cmd == "stop" then
        Housing:DumpStop()
        return
    end

    if cmd == "status" then
        Housing:DumpStatus()
        return
    end

    Housing:DumpItemApiData(cmd)
end
