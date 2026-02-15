local ADDON, NS = ...
NS.UI = NS.UI or {}

local View = NS.UI.Viewer
if not View then return end

local Render = View.Render
if not Render then return end

local LAYOUT = {
    ROW_GAP = 8,
    LIST_H = 84,
    LIST_GAP = 6,
    PAD_TOP = 10,
    PAD_BOTTOM = 12,
    TILE = {
        MIN_W = 175,
        MAX_W = 260,
        MIN_COLS = 2,
        MAX_COLS = 6,
        GAP = 10,
        ASPECT = 1.10,
        ICON_RATIO = 0.36,
        FIXED_HEIGHT = 300
    },
    ICON = {
        MIN = 66,
        MAX = 96
    }
}

local D = View.Data
local U = View.Util
local S = View.Search
local R = View.Requirements

local Systems = NS.Systems or {}
local FiltersSys = Systems.Filters
local Collection = Systems.Collection

local UI = NS.UI or {}
local TT = UI.Tooltips
local Favorite = UI.FavoriteStar
local StatusIcon = UI.StatusIcon
local ProgressBar = UI.ProgressBar
local DropPanel = UI.DropPanel
local HeaderCtrl = UI.HeaderController
local RS = UI.RowStyles
local IA = UI.ItemInteractions

local C_Timer = _G.C_Timer
local CreateFrame = _G.CreateFrame
local GameTooltip = _G.GameTooltip
local GetTime = _G.GetTime
local C_HousingCatalog = _G.C_HousingCatalog
local C_CurrencyInfo = _G.C_CurrencyInfo

local floor = math.floor
local function Pixel(v) return v and floor(v + 0.5) or 0 end
local function clamp(v, min, max) return v < min and min or (v > max and max or v) end

local function wipeTable(t)
    if type(t) ~= "table" then return end
    for k in pairs(t) do t[k] = nil end
end

local DyeableCache = {}
local CategoryBreadcrumbCache = {}

local function IsItemDyeable(decorID)
    if not decorID then return false end
    if DyeableCache[decorID] ~= nil then return DyeableCache[decorID] end

    if C_HousingCatalog and C_HousingCatalog.GetCatalogEntryInfoByRecordID then
        local ok, info = pcall(C_HousingCatalog.GetCatalogEntryInfoByRecordID, 1, decorID, true)
        if ok and info then
            DyeableCache[decorID] = info.canCustomize == true
            return DyeableCache[decorID]
        end
    end

    DyeableCache[decorID] = false
    return false
end
local VENDOR_CLASS_LABEL = {
    [103693] = "Hunter",
    [105986] = "Rogue",
    [112318] = "Shaman",
    [112323] = "Druid",
	[93550] = "Death Knight", 
	[100196] = "Paladin", 
    [112338] = "Monk",
    [112392] = "Warrior",
    [112401] = "Priest",
    [112407] = "Demon Hunter",
    [112434] = "Warlock",
    [112440] = "Mage",
}

local function GetClassLabelForVendor(it)
    if not it then return nil end
    local vid = it.npcID
    if not vid and it.source then vid = it.source.npcID or it.source.id end
    if not vid and it.vendor and it.vendor.source then vid = it.vendor.source.id end
    vid = tonumber(vid)
    return vid and VENDOR_CLASS_LABEL[vid] or nil
end

local function GetDyeableOrClassLabel(it)
    local classLabel = GetClassLabelForVendor(it)
    local isDyeable = IsItemDyeable(it and it.decorID)
    if isDyeable and classLabel then return "Dyeable - " .. classLabel end
    if isDyeable then return "Dyeable" end
    return classLabel
end


local function GetDecorCategoryBreadcrumb(decorID)
    if not decorID then return "" end
    
    if CategoryBreadcrumbCache[decorID] then 
        return CategoryBreadcrumbCache[decorID] 
    end

    if C_HousingCatalog and C_HousingCatalog.GetCatalogEntryInfoByRecordID then
        local ok, info = pcall(C_HousingCatalog.GetCatalogEntryInfoByRecordID, 1, decorID, true)
        if ok and info then
            local breadcrumb = ""

            local categoryName = info.categoryName
            if not categoryName or categoryName == "" then
                if info.categoryID and C_HousingCatalog.GetCatalogCategoryInfo then
                    local catOk, catInfo = pcall(C_HousingCatalog.GetCatalogCategoryInfo, info.categoryID)
                    if catOk and catInfo and catInfo.name then
                        categoryName = catInfo.name
                    end
                end
            end
            local subcategoryName = info.subcategoryName
            if not subcategoryName or subcategoryName == "" then
                if info.subcategoryID and C_HousingCatalog.GetCatalogSubcategoryInfo then
                    local subOk, subInfo = pcall(C_HousingCatalog.GetCatalogSubcategoryInfo, info.subcategoryID)
                    if subOk and subInfo and subInfo.name then
                        subcategoryName = subInfo.name
                    end
                end
            end

            if categoryName and categoryName ~= "" then
                breadcrumb = categoryName
                if subcategoryName and subcategoryName ~= "" then
                    breadcrumb = breadcrumb .. " > " .. subcategoryName
                end
            elseif subcategoryName and subcategoryName ~= "" then
                breadcrumb = subcategoryName
            end
            
            CategoryBreadcrumbCache[decorID] = breadcrumb
            return breadcrumb
        end
    end

    CategoryBreadcrumbCache[decorID] = ""
    return ""
end

local function GetCurrencyInfo(it)
    if not it or not it.source then return nil, nil, nil, nil end

    local s = it.source
    local goldCost = tonumber(s.cost or it.cost)
    local currencyAmount = tonumber(s.currency or s.currencyText or s.costText)
    local currencyTypeID = s.currencytype or s.currencyType or s.currencyID
    local currencyName, iconFileID

    if currencyAmount and currencyTypeID then
        if type(currencyTypeID) == "string" and not tonumber(currencyTypeID) then
            currencyName = currencyTypeID
        elseif C_CurrencyInfo and C_CurrencyInfo.GetCurrencyInfo then
            local numericID = tonumber(currencyTypeID)
            if numericID then
                local ok, info = pcall(C_CurrencyInfo.GetCurrencyInfo, numericID)
                if ok and info then
                    currencyName = info.name
                    iconFileID = info.iconFileID
                end
            end
        end
        currencyName = currencyName or "Currency"
    end

    return goldCost, currencyAmount, currencyName, iconFileID
end

local function CalculateTileHeight(it, baseHeight)
    return LAYOUT.TILE.FIXED_HEIGHT
end

local function AddToFlat(out, seen, it)
    if type(it) ~= "table" then return end

    local id = it.decorID or (it.source and (it.source.id or it.source.itemID or it.source.itemId)) or it.itemID
    if not id then return end

    local key = ((it.source and it.source.type) or "") .. ":" .. tostring(id)
    if seen[key] then return end

    seen[key] = true
    out[#out + 1] = it
end

local function BuildFlatResults(ui, db, scopeKey)
    if not scopeKey or scopeKey == "" then return {} end

    local out, seen = {}, {}
    local data = NS.Data or {}

    local function scanNode(node, exp, zone, vendorCtx)
        if type(node) ~= "table" then return end

        if node.decorID then
            local it = node
            if vendorCtx and D and D.AttachVendorCtx then
                it = D.AttachVendorCtx(node, vendorCtx) or node
            end
            if exp and not it._expansion then it._expansion = exp end
            if zone and not it._navZoneKey then it._navZoneKey = zone end
            if not FiltersSys or not FiltersSys.Passes or FiltersSys:Passes(it, ui, db) then
                AddToFlat(out, seen, it)
            end
            return
        end

        if node.items and type(node.items) == "table" then
            for _, leaf in ipairs(node.items) do
                scanNode(leaf, exp, zone, node)
            end
            return
        end

        if node[1] then
            for _, child in ipairs(node) do
                scanNode(child, exp, zone, vendorCtx)
            end
            return
        end

        for _, v in pairs(node) do
            scanNode(v, exp, zone, vendorCtx)
        end
    end

    local function scanCategory(catKey)
        local catTbl = data[catKey]
        if type(catTbl) ~= "table" then return end
        for exp, expTbl in pairs(catTbl) do
            if type(expTbl) == "table" then
                for zone, items in pairs(expTbl) do
                    if type(items) == "table" then
                        scanNode(items, exp, zone, nil)
                    end
                end
            end
        end
    end

    if scopeKey == "GLOBAL" then
        for k, v in pairs(data) do
            if type(k) == "string" and type(v) == "table" and k ~= "Events" then
                scanCategory(k)
            end
        end
    else
        scanCategory(scopeKey)
    end

    table.sort(out, function(a, b)
        return tostring(a.title or ""):lower() < tostring(b.title or ""):lower()
    end)

    return out
end

local function CountItems(items, vendorCtx)
    local total, collected = 0, 0

    local function countOne(it, vctx)
        if not it then return end
        local rit = it
        if vctx and D and D.AttachVendorCtx then D.AttachVendorCtx(rit, vctx) end
        if U and U.Passes and U.Passes(rit) then
            total = total + 1
            if U.IsCollectedSafe and U.IsCollectedSafe(rit) then
                collected = collected + 1
            end
        end
    end

    if vendorCtx then
        for _, it in ipairs(items or {}) do countOne(it, vendorCtx) end
        return collected, total
    end

    for _, it in ipairs(items or {}) do
        local src = it and it.source
        if type(it) == "table" and src and src.type == "vendor" and type(it.items) == "table" then
            for _, leaf in ipairs(it.items) do countOne(leaf, it) end
        else
            countOne(it, nil)
        end
    end

    return collected, total
end

local function FindFirstVisible(entries, y)
    if not entries then return 1 end
    local lo, hi = 1, #entries
    local res = hi + 1
    while lo <= hi do
        local mid = floor((lo + hi) / 2)
        local e = entries[mid]
        local bottom = (e.y or 0) + (e.h or 0)
        if bottom >= y then
            res = mid
            hi = mid - 1
        else
            lo = mid + 1
        end
    end
    return res
end

local function ApplyFactionBadge(fr, it, size)
    if not (fr and it and fr.factionIcon) then return end

    local fac = it.faction or (it.source and it.source.faction)
    local icon = (fac == "Alliance" and D.TEX_ALLI) or (fac == "Horde" and D.TEX_HORDE) or nil

    fr.factionIcon:ClearAllPoints()
    if fr._kind == "tile" then
        fr.factionIcon:SetPoint("TOPRIGHT", (fr.media or fr), "TOPRIGHT", -8, -8)
    else
        fr.factionIcon:SetPoint("TOPRIGHT", (fr.iconBG or fr), "TOPRIGHT", -2, -2)
    end

    if fr.factionIcon.SetSize then fr.factionIcon:SetSize(size or 16, size or 16) end

    if icon and fr.factionIcon.SetTexture then
        fr.factionIcon:SetTexture(icon)
        fr.factionIcon:Show()
    else
        fr.factionIcon:Hide()
    end

    if fr._statusIcon and fr._statusIcon.GetTexture then
        local t = fr._statusIcon:GetTexture()
        if t == D.TEX_ALLI or t == D.TEX_HORDE then
            fr._statusIcon:Hide()
        end
    end
end

local function SetupFavoriteHover(btn)
    if not btn or not btn.HookScript or btn.favHoverBound then return end
    btn.favHoverBound = true
    btn:HookScript("OnEnter", function(b)
        if b.SetAlpha then b:SetAlpha(1.0) end
        if b.SetScale then b:SetScale(1.12) end
    end)
    btn:HookScript("OnLeave", function(b)
        if b.SetAlpha then b:SetAlpha(0.85) end
        if b.SetScale then b:SetScale(1.0) end
    end)
end

local function ReqEnter(btn)
    local row = btn and btn:GetParent()
    local req = row and row.req and row.req._req
    if not req then return end
    if row.req and R.BuildReqDisplay then
        row.req:SetText(R.BuildReqDisplay(req, true))
    end
    if TT and TT.ShowRequirement then
        TT:ShowRequirement(btn, req)
    end
end

local function ReqLeave(btn)
    local row = btn and btn:GetParent()
    local req = row and row.req and row.req._req
    if not req then return end
    if row.req and R.BuildReqDisplay then
        row.req:SetText(R.BuildReqDisplay(req, false))
    end
    if GameTooltip then GameTooltip:Hide() end
end

local function ReqClick(btn)
    local row = btn and btn:GetParent()
    local req = row and row.req and row.req._req
    if not req or not R.ShowWowheadLinks then return end

    local url = (req.kind == "quest" and R.BuildWowheadQuestURL(req.id)) or R.BuildWowheadAchievementURL(req.id)
    R.ShowWowheadLinks({ { label = "Link", url = url } })
end

local function BindReqButton(btn)
    if btn and not btn.reqScriptsBound then
        btn.reqScriptsBound = true
        btn:SetScript("OnEnter", ReqEnter)
        btn:SetScript("OnLeave", ReqLeave)
        btn:SetScript("OnClick", ReqClick)
    end
end

local function HeaderClick(self)
    local f = self and self._owner
    if not f then return end

    local entry = self._entry
    if not entry or not entry.payload or not entry.payload.key then return end

    if entry.payload.vendor then
        entry.payload.vendor._uiOpen = not entry.payload.vendor._uiOpen
        if f.Render then f:Render(true) end
        return
    end

    if entry.payload.event then
        entry.payload.event._uiOpen = not entry.payload.event._uiOpen
        local db = U and U.DB and U.DB()
        if db then
            if not db.eventHeaderStates then db.eventHeaderStates = {} end
            db.eventHeaderStates[entry.payload.key] = entry.payload.event._uiOpen
        end
        if f.Render then f:Render(true) end
        return
    end

    local sf = f._scrollFrame
    local content = f._scrollContent
    if not sf or not content then return end

    local preScroll = sf:GetVerticalScroll() or 0
    local anchorY = entry.y or 0
    local anchorOff = anchorY - preScroll

    if not HeaderCtrl or not HeaderCtrl.Toggle then return end

    local kind = entry.clickKind
    if kind then
        kind = tostring(kind):lower()
        if kind:find("vendor", 1, true) then kind = "vendor"
        elseif kind:find("zone", 1, true) then kind = "zone"
        elseif kind:find("event", 1, true) then kind = "event"
        else kind = "exp" end
    end

    HeaderCtrl:Toggle(kind, entry.payload.key)
    if f.Render then f:Render(true) end

    local newY = anchorY
    if f._headerYByKey and f._headerYByKey[entry.payload.key] then
        newY = f._headerYByKey[entry.payload.key]
    end

    if U and U.ClampScroll then
        sf:SetVerticalScroll(U.ClampScroll(sf, content, newY - anchorOff))
    end
end

local GridCache = {}

local function ComputeGrid(indent, contentWidth)
    local avail = math.max(0, contentWidth - indent - 8)
    if GridCache.lastAvail and GridCache.lastIndent == indent and 
       math.abs(avail - GridCache.lastAvail) < 4 then
        return GridCache.cols, GridCache.startX, GridCache.tileW, GridCache.tileH, GridCache.iconSize
    end

    local t = LAYOUT.TILE
    local est = floor((avail + t.GAP) / (t.MIN_W + t.GAP))
    local cols = clamp(est, t.MIN_COLS, t.MAX_COLS)
    local w = floor((avail - (cols - 1) * t.GAP) / cols)
    w = clamp(w, t.MIN_W, t.MAX_W)

    while cols < t.MAX_COLS do
        local w2 = floor((avail - cols * t.GAP) / (cols + 1))
        if w2 >= t.MIN_W then
            cols = cols + 1
            w = clamp(w2, t.MIN_W, t.MAX_W)
        else
            break
        end
    end

    local tileW = w
    local tileH = t.FIXED_HEIGHT
    local iconSize = clamp(floor(tileW * t.ICON_RATIO), LAYOUT.ICON.MIN, LAYOUT.ICON.MAX)
    local startX = indent

    GridCache = {
        lastAvail = avail,
        lastIndent = indent,
        cols = cols,
        startX = startX,
        tileW = tileW,
        tileH = tileH,
        iconSize = iconSize
    }

    return cols, startX, tileW, tileH, iconSize
end

local function RebuildEntries(f, content)
    local db = U and U.DB and U.DB()
    if not db then
        f.entries = {}
        return
    end

    local ui = db.ui or {}
    if FiltersSys and FiltersSys.EnsureDefaults then
        FiltersSys:EnsureDefaults(db)
    end

    local cat = ui.activeCategory or "Achievements"

    if f._lastCategory and f._lastCategory ~= cat then
        if HeaderCtrl and HeaderCtrl.Reset then HeaderCtrl:Reset() end
    end
    f._lastCategory = cat

    local entries = {}
    f.entries = entries

    local headerY = {}
    f._headerYByKey = headerY

    local y = LAYOUT.PAD_TOP
    local viewMode = ui.viewMode or "Icon"
    local contentW = content:GetWidth() or 0

    local function addHeader(indent, height, label, cur, max, expanded, clickKind, payload)
        cur = cur or 0
        max = max or 0
        if max <= 0 then return end

        local y0 = y
        entries[#entries + 1] = {
            kind = "header",
            clickKind = clickKind,
            payload = payload,
            indent = indent,
            x = indent,
            y = y0,
            w = contentW - indent - 8,
            h = height,
            label = label,
            cur = cur,
            max = max,
            expanded = expanded or false,
            timerText = payload and payload.timerText or nil
        }

        if payload and payload.key then headerY[payload.key] = y0 end
        y = y0 + height + LAYOUT.ROW_GAP
    end

    local function addListItem(indent, it, nav)
        entries[#entries + 1] = {
            kind = "list",
            x = indent,
            y = y,
            w = contentW - indent - 8,
            h = LAYOUT.LIST_H,
            indent = indent,
            it = it,
            nav = nav
        }
        y = y + LAYOUT.LIST_H + LAYOUT.LIST_GAP
    end

    local function addTile(indent, it, nav, col, startX, tileW, tileH)
        local h = CalculateTileHeight(it, tileH)
        entries[#entries + 1] = {
            kind = "tile",
            x = startX + col * (tileW + LAYOUT.TILE.GAP),
            y = y,
            w = tileW,
            h = h,
            indent = indent,
            it = it,
            nav = nav
        }
    end

    local q = U and U.trim and U.trim(ui.search) or (ui.search or "")
    local fdb = db.filters or {}
    local flatMode = (q ~= "") or
        (fdb and ((fdb.subcategory and fdb.subcategory ~= "ALL") or
                  (fdb.category and fdb.category ~= "ALL")))

    if flatMode then
        if HeaderCtrl and HeaderCtrl.Reset then HeaderCtrl:Reset() end

        local scope = (cat == "Search" or cat == "ALL" or cat == "All" or cat == "Everything") and "GLOBAL" or
                      (D and D.CATEGORY_MAP and D.CATEGORY_MAP[cat]) or cat
        if cat == "PvP" or cat == "PVP" then scope = "PvP" end

        local results = (cat == "Search" and S and S.BuildGlobalSearchResults and S.BuildGlobalSearchResults(ui, db)) or
                        BuildFlatResults(ui, db, scope) or {}

        if viewMode == "Icon" then
            local cols, startX, tileW, tileH = ComputeGrid(12, contentW)
            local col = 0
            for _, it in ipairs(results) do
                local h = CalculateTileHeight(it, tileH)
                addTile(12, it, it and (it.vendor or it.source) or nil, col, startX, tileW, tileH)
                col = col + 1
                if col >= cols then
                    col = 0
                    y = y + h + LAYOUT.TILE.GAP
                end
            end
            if col > 0 then y = y + LAYOUT.TILE.FIXED_HEIGHT + LAYOUT.TILE.GAP end
        else
            for _, it in ipairs(results) do
                addListItem(12, it, it and (it.vendor or it.source) or nil)
            end
        end

        f.totalHeight = y + LAYOUT.PAD_BOTTOM
        return
    end

    if cat == "Saved Items" then
        if HeaderCtrl and HeaderCtrl.Reset then HeaderCtrl:Reset() end

        local favs = S and S.CollectAllFavorites and S.CollectAllFavorites(db) or {}

        if viewMode == "Icon" then
            local cols, startX, tileW, tileH = ComputeGrid(12, contentW)
            local col = 0
            for _, it in ipairs(favs) do
                if not FiltersSys or not FiltersSys.Passes or FiltersSys:Passes(it, ui, db) then
                    local h = CalculateTileHeight(it, tileH)
                    addTile(12, it, it and (it.vendor or it.source) or nil, col, startX, tileW, tileH)
                    col = col + 1
                    if col >= cols then
                        col = 0
                        y = y + h + LAYOUT.TILE.GAP
                    end
                end
            end
            if col > 0 then y = y + LAYOUT.TILE.FIXED_HEIGHT + LAYOUT.TILE.GAP end
        else
            for _, it in ipairs(favs) do
                if not FiltersSys or not FiltersSys.Passes or FiltersSys:Passes(it, ui, db) then
                    addListItem(12, it, it and (it.vendor or it.source) or nil)
                end
            end
        end

        f.totalHeight = y + LAYOUT.PAD_BOTTOM
        return
    end

    if cat == "Events" then
        local Ev = Systems.Events
        local list = (Ev and Ev.GetActive and Ev:GetActive()) or
                     (NS.Data and type(NS.Data.Events) == "table" and NS.Data.Events) or {}

        if #list == 0 then
            addListItem(0, {
                title = "No active events",
                decorType = "Event items will appear here while active",
                source = { type = "event", icon = "Interface\\Icons\\INV_Misc_PocketWatch_01" }
            }, nil)
            f.totalHeight = y + LAYOUT.PAD_BOTTOM
            return
        end

        for _, ev in ipairs(list) do
            local eTitle = ev.title or ev.name or "Event"
            local evKey = "event:" .. tostring(ev.id or ev.key or eTitle)
            
            if not db.eventHeaderStates then db.eventHeaderStates = {} end
            local savedOpen = db.eventHeaderStates[evKey]
            
            local open
            if savedOpen ~= nil then
                open = savedOpen
            elseif ev._uiOpen ~= nil then
                open = ev._uiOpen
            else
                open = false  
            end

            ev._uiOpen = open

            local group = {}
            local cEv, tEv = 0, 0

            if type(ev.items) == "table" then
                for _, it0 in ipairs(ev.items) do
                    if type(it0) == "table" then
                        local it = U and U.copyShallow and U.copyShallow(it0) or it0
                        it._isEventTimed = true
                        it._eventTitle = eTitle

                        if not FiltersSys or not FiltersSys.Passes or FiltersSys:Passes(it, ui, db) then
                            if U and U.Passes and U.Passes(it) then
                                tEv = tEv + 1
                                if U.IsCollectedSafe and U.IsCollectedSafe(it) then
                                    cEv = cEv + 1
                                end
                            end
                            group[#group + 1] = it
                        end
                    end
                end
            end

            local timerText = nil
            if Ev and Ev.GetEventTimeText then
                timerText = Ev:GetEventTimeText(ev, _G.time and _G.time() or 0)
            end

            addHeader(12, 44, eTitle, cEv, tEv, open, "event", { key = evKey, event = ev, timerText = timerText })

            if open and #group > 0 then
                if viewMode == "Icon" then
                    local cols, startX, tileW, tileH = ComputeGrid(28, contentW)
                    local col = 0
                    for _, it in ipairs(group) do
                        local h = CalculateTileHeight(it, tileH)
                        addTile(28, it, ev, col, startX, tileW, tileH)
                        col = col + 1
                        if col >= cols then
                            col = 0
                            y = y + h + LAYOUT.TILE.GAP
                        end
                    end
                    if col > 0 then y = y + LAYOUT.TILE.FIXED_HEIGHT + LAYOUT.TILE.GAP end
                else
                    for _, it in ipairs(group) do
                        addListItem(28, it, ev)
                    end
                end
            end
        end

        f.totalHeight = y + LAYOUT.PAD_BOTTOM
        return
    end

    local data = D and D.GetActiveData and D.GetActiveData(ui)
    if not data then
        f.totalHeight = y + LAYOUT.PAD_BOTTOM
        return
    end

    local expOrder = D and D.GetExpansionOrder and D.GetExpansionOrder(data) or {}
    for _, exp in ipairs(expOrder) do
        local zones = D and D.NormalizeExpansionNode and D.NormalizeExpansionNode(data[exp]) or {}
        local eC, eT = 0, 0

        for _, items in pairs(zones) do
            local c, t = CountItems(items)
            eC, eT = eC + c, eT + t
        end

        local eKey = D and D.KeyExp and D.KeyExp(cat, exp) or (cat .. ":" .. tostring(exp))
        local expOpen = HeaderCtrl and HeaderCtrl.IsOpen and HeaderCtrl:IsOpen("exp", eKey) or false

        addHeader(12, 44, exp, eC, eT, expOpen, "exp", { key = eKey })

        if expOpen then
            for zone, items in pairs(zones) do
                local zC, zT = CountItems(items)
                local zKey = D and D.KeyZone and D.KeyZone(cat, exp, zone) or (cat .. ":" .. tostring(exp) .. ":" .. tostring(zone))
                local zoneOpen = HeaderCtrl and HeaderCtrl.IsOpen and HeaderCtrl:IsOpen("zone", zKey) or false

                addHeader(28, 36, zone, zC, zT, zoneOpen, "zone", { key = zKey })

                if zoneOpen then
                    if viewMode == "Icon" then

                        for _, it in ipairs(items) do
                            if it.source and it.source.type == "vendor" and it.items then
                                local vC, vT = CountItems(it.items, it)
                                local vendorKeyId = (it.source and it.source.id) or it.npcID or it.id or 0
                                local vKey = D and D.KeyVendor and D.KeyVendor(cat, exp, zone, vendorKeyId) or tostring(vendorKeyId)
                                local vTitle = (D and D.ResolveVendorTitle and D.ResolveVendorTitle(it)) or it.title
                                if not vTitle or vTitle == "" then
                                    local vid = (it.source and it.source.id) or it.npcID or it.id
                                    vTitle = vid and ("Vendor #" .. tostring(vid)) or "Vendor"
                                end

                                addHeader(44, 30, "[Vendor] " .. vTitle, vC, vT, (it._uiOpen and true or false), "vendor", { key = vKey, vendor = it })

                                if it._uiOpen then
                                    local vCols, vStartX, vTileW, vTileH = ComputeGrid(60, contentW)
                                    local vCol = 0
                                    for _, vit in ipairs(it.items) do
                                        local rit = vit
                                        rit.source = rit.source or {}
                                        rit._expansion = exp
                                        rit._navZoneKey = zone
                                        if D and D.AttachVendorCtx then D.AttachVendorCtx(rit, it) end

                                        if U and U.Passes and U.Passes(rit) then
                                            local h = CalculateTileHeight(rit, vTileH)
                                            addTile(60, rit, it, vCol, vStartX, vTileW, vTileH)
                                            vCol = vCol + 1
                                            if vCol >= vCols then
                                                vCol = 0
                                                y = y + h + LAYOUT.TILE.GAP
                                            end
                                        end
                                    end
                                    if vCol > 0 then y = y + LAYOUT.TILE.FIXED_HEIGHT + LAYOUT.TILE.GAP end
                                end
                            end
                        end

                        local cols, startX, tileW, tileH = ComputeGrid(44, contentW)
                        local col = 0
                        for _, it in ipairs(items) do
                            if not (it.source and it.source.type == "vendor" and it.items) then
                                local rit = it
                                rit.source = rit.source or {}
                                rit._expansion = exp
                                rit._navZoneKey = zone

                                if U and U.Passes and U.Passes(rit) then
                                    local h = CalculateTileHeight(rit, tileH)
                                    addTile(44, rit, rit.vendor, col, startX, tileW, tileH)
                                    col = col + 1
                                    if col >= cols then
                                        col = 0
                                        y = y + h + LAYOUT.TILE.GAP
                                    end
                                end
                            end
                        end
                        if col > 0 then y = y + LAYOUT.TILE.FIXED_HEIGHT + LAYOUT.TILE.GAP end
                    else

                        for _, it in ipairs(items) do
                            if it.source and it.source.type == "vendor" and it.items then
                                local vC, vT = CountItems(it.items, it)
                                local vendorKeyId = (it.source and it.source.id) or it.npcID or it.id or 0
                                local vKey = D and D.KeyVendor and D.KeyVendor(cat, exp, zone, vendorKeyId) or tostring(vendorKeyId)
                                local vTitle = (D and D.ResolveVendorTitle and D.ResolveVendorTitle(it)) or it.title
                                if not vTitle or vTitle == "" then
                                    local vid = (it.source and it.source.id) or it.npcID or it.id
                                    vTitle = vid and ("Vendor #" .. tostring(vid)) or "Vendor"
                                end

                                addHeader(44, 30, "[Vendor] " .. vTitle, vC, vT, (it._uiOpen and true or false), "vendor", { key = vKey, vendor = it })

                                if it._uiOpen then
                                    for _, vit in ipairs(it.items) do
                                        local rit = vit
                                        rit.source = rit.source or {}
                                        rit._expansion = exp
                                        rit._navZoneKey = zone
                                        if D and D.AttachVendorCtx then D.AttachVendorCtx(rit, it) end
                                        if U and U.Passes and U.Passes(rit) then
                                            addListItem(60, rit, it)
                                        end
                                    end
                                end
                            end
                        end

                        for _, it in ipairs(items) do
                            if not (it.source and it.source.type == "vendor" and it.items) then
                                local rit = it
                                rit.source = rit.source or {}
                                rit._expansion = exp
                                rit._navZoneKey = zone
                                if U and U.Passes and U.Passes(rit) then
                                    addListItem(28, rit, rit.vendor)
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    f.totalHeight = y + LAYOUT.PAD_BOTTOM
end

function Render:Create(parent)
    local f = CreateFrame("Frame", nil, parent)
    f:SetAllPoints()
    f._suspendRender = false

    f:SetScript("OnSizeChanged", function(self, width, height)
        if self._suspendRender then return end
        GridCache = {}
        if self.Render then self:Render(false) end
    end)

    parent:HookScript("OnDragStart", function() f._suspendRender = true end)
    parent:HookScript("OnDragStop", function()
        f._suspendRender = false
        if f.Render then f:RequestRender(true) end
    end)

    local sf = CreateFrame("ScrollFrame", nil, f, "ScrollFrameTemplate")
    if UI.Controls and UI.Controls.SkinScrollFrame then
        UI.Controls:SkinScrollFrame(sf)
    end
    sf:SetPoint("TOPLEFT", 8, -52)
    sf:SetPoint("BOTTOMRIGHT", -28, 8)

    local content = CreateFrame("Frame", nil, sf)
    content:SetPoint("TOPLEFT", 0, 0)
    sf:SetScrollChild(content)

    f._scrollFrame = sf
    f._scrollContent = content

    sf:SetScript("OnSizeChanged", function(_, w)
        content:SetWidth((w or 0) - 18)
        GridCache = {}
        if f.Render then f:RequestRender(true) end
    end)

    sf:SetScript("OnVerticalScroll", function()
        if f.UpdateVisible then f:UpdateVisible() end
    end)

    if Collection and Collection.OnChange then
        local lastFull = 0
        Collection:OnChange(function(payload)
            if not f or not f:IsShown() then return end
            local now = GetTime and GetTime() or 0

            if payload and payload.decorID and f.RefreshDecor then
                f:RefreshDecor(payload.decorID)
            end

            if (now - lastFull) > 1.0 then
                lastFull = now
                C_Timer.After(0.35, function()
                    if f and f:IsShown() and f.RequestRender then
                        f:RequestRender(true)
                    end
                end)
            end
        end)
    end

    if C_Timer and C_Timer.NewTicker then
        f._eventTimerTicker = C_Timer.NewTicker(60, function()
            if not f or not f:IsShown() then return end
            local db = U and U.DB and U.DB()
            if not db then return end
            local ui = db.ui or {}
            if ui.activeCategory ~= "Events" then return end

            for i = 1, #f._active do
                local fr = f._active[i]
                local e = fr and fr._entry
                if e and e.kind == "header" and e.payload and e.payload.event and e.timerText then
                    local Ev = Systems.Events
                    if Ev and Ev.GetEventTimeText then
                        local newTimerText = Ev:GetEventTimeText(e.payload.event, _G.time and _G.time() or 0)
                        if newTimerText and newTimerText ~= e.timerText then
                            if f.RequestRender then
                                f:RequestRender(true)
                            end
                            break
                        end
                    end
                end
            end
        end)
    end

    f._poolHeader, f._poolList, f._poolTile, f._active = {}, {}, {}, {}

    local Frames = View.Frames

    local function Acquire(kind)
        local fr
        if kind == "header" then
            fr = table.remove(f._poolHeader) or Frames.CreateHeader(content)
        elseif kind == "tile" then
            fr = table.remove(f._poolTile) or Frames.CreateTile(content)
        else
            fr = table.remove(f._poolList) or Frames.CreateListRow(content)
        end
        fr._owner = f
        fr:Show()
        f._active[#f._active + 1] = fr
        return fr
    end

    local function ReleaseFrame(frame)
        if not frame then return end
        frame:Hide()
        frame:ClearAllPoints()
        frame._entry = nil
    end

    function f:ReleaseAll()
        for i = 1, #self._active do
            local fr = self._active[i]
            ReleaseFrame(fr)
            if fr._kind == "header" then
                self._poolHeader[#self._poolHeader + 1] = fr
            elseif fr._kind == "tile" then
                self._poolTile[#self._poolTile + 1] = fr
            else
                self._poolList[#self._poolList + 1] = fr
            end
        end
        wipeTable(self._active)
    end

    function f:UpdateVisible()
        if self._suspendRender or not self.entries then return end

        local db = U and U.DB and U.DB()
        local ui = (db and db.ui) or {}
        local viewMode = ui.viewMode or "Icon"
        local scrollY = sf:GetVerticalScroll() or 0

        self._lastScrollY, self._lastCount, self._lastViewMode = scrollY, #self.entries, viewMode

        self:ReleaseAll()

        local viewH = sf:GetHeight() or 0
        local top = scrollY - 200
        local bottom = scrollY + viewH + 200

        local entries = self.entries
        local startIdx = FindFirstVisible(entries, top)

        for i = startIdx, #entries do
            local e = entries[i]
            if (e.y or 0) > bottom then break end

            local eBottom = (e.y or 0) + (e.h or 0)
            if eBottom >= top then
                local fr = Acquire(e.kind)
                fr._entry = e
                fr:ClearAllPoints()
                fr:SetPoint("TOPLEFT", Pixel(e.x), -Pixel(e.y))
                fr:SetSize(Pixel(e.w), Pixel(e.h))

                if e.kind == "header" then
                    if fr.text then fr.text:SetText(e.label or "") end

                    if fr.chevron then
                        if e.expanded then
                            fr.chevron:SetTexture("Interface\\Buttons\\UI-MinusButton-UP")
                        else
                            fr.chevron:SetTexture("Interface\\Buttons\\UI-PlusButton-UP")
                        end
                        fr.chevron:Show()
                    elseif fr.icon then
                        if e.expanded then
                            fr.icon:SetRotation(math.pi / 2) 
                        else
                            fr.icon:SetRotation(0)
                        end
                    end

                    if fr.count then
                        if e.timerText and e.timerText ~= "" then
                            fr.count:SetText("|cffFFD100" .. e.timerText .. "|r")
                            if fr.count.SetFont then
                                fr.count:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE")
                            end
                        else
                            fr.count:SetText((e.cur or 0) .. " / " .. (e.max or 0))
                            if fr.count.SetFont then
                                fr.count:SetFont("Fonts\\FRIZQT__.TTF", 13, "")
                            end
                        end
                    end

                    local complete = (e.max and e.max > 0 and (e.cur or 0) >= (e.max or 0))
                    if fr.check then
                        if complete then fr.check:Show() else fr.check:Hide() end
                    end

                    if ProgressBar and e.max and e.max > 0 then
                        if not fr.bar then
                            fr.bar = ProgressBar:Create(fr, 140)
                            fr.bar:SetPoint("BOTTOMLEFT", fr, "BOTTOMLEFT", 14, 5)
                        end
                        fr.bar:Show()
                        fr.bar:SetProgress(e.cur or 0, e.max or 0)
                    elseif fr.bar then
                        fr.bar:Hide()
                    end

                    if not fr.headerScriptsBound then
                        fr.headerScriptsBound = true
                        fr:SetScript("OnClick", HeaderClick)
                    end

                elseif e.kind == "tile" then
                    local it = D and D.ResolveAchievementDecor and D.ResolveAchievementDecor(e.it) or e.it
                    local state = U and U.GetStateSafe and U.GetStateSafe(it)
                    local w, h = e.w or GridCache.tileW, e.h or GridCache.tileH

                    if fr.media then
                        fr.media:SetHeight(floor(h * 0.52))
                        if fr.icon then
                            local iconSize = GridCache.iconSize or LAYOUT.ICON.MIN
                            fr.icon:SetSize(iconSize, iconSize)
                            local tex = (it and it.source and it.source.icon) or
                                       (it and it.decorID and D and D.GetDecorIcon and D.GetDecorIcon(it.decorID)) or
                                       "Interface\\Icons\\INV_Misc_QuestionMark"
                            fr.icon:SetTexture(tex)
                            if fr.icon.SetTexCoord then fr.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92) end
                        end

                        if fr.div then
                            fr.div:ClearAllPoints()
                            fr.div:SetPoint("TOPLEFT", fr.media, "BOTTOMLEFT", 0, -6)
                            fr.div:SetPoint("TOPRIGHT", fr.media, "BOTTOMRIGHT", 0, -6)
                            fr.div:SetHeight(1)
                            fr.div:Show()
                        end

                        if fr.textBg and fr.div then
                            fr.textBg:ClearAllPoints()
                            fr.textBg:SetPoint("TOPLEFT", fr.div, "BOTTOMLEFT", -8, -2)
                            fr.textBg:SetPoint("BOTTOMRIGHT", -8, 8)
                            fr.textBg:Show()
                        end
                    end

                    local textArea = fr.textArea or fr
                    if fr.label then
                        fr.label:ClearAllPoints()
                        fr.label:SetPoint("TOPLEFT", textArea, "TOPLEFT", 0, -2)
                        fr.label:SetPoint("TOPRIGHT", textArea, "TOPRIGHT", 0, 0)
                        local name = it and (it.title or (it.decorID and D and D.GetDecorName and D.GetDecorName(it.decorID)))
                        if not name or name == "" then
                            name = "Decor #" .. tostring(it and (it.decorID or it.itemID) or "?")
                        end
                        fr.label:SetText(name)
                        if fr.label.SetWidth then fr.label:SetWidth(math.max(0, w - 20)) end
						if fr.label.SetMaxLines then fr.label:SetMaxLines(3) end
                        if fr.label.SetHeight then fr.label:SetHeight(20) end
                    end

                    if fr.note then
                        local noteText = (it and it.source and type(it.source.note) == "string" and it.source.note ~= "" and it.source.note) or nil
                        if noteText then
                            fr.note:ClearAllPoints()
                            fr.note:SetPoint("TOPLEFT", fr.label, "BOTTOMLEFT", 0, -2)
                            fr.note:SetPoint("TOPRIGHT", fr.label, "BOTTOMRIGHT", 0, -2)
                            fr.note:SetText("|cff9fb0c5" .. noteText .. "|r")
                            fr.note:Show()
                        else
                            fr.note:Hide()
                        end
                    end

                    if fr.titleDiv and fr.label then
                        fr.titleDiv:ClearAllPoints()
                        local anchor = (fr.note and fr.note:IsShown()) and fr.note or fr.label
                        fr.titleDiv:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -4)
                        fr.titleDiv:SetPoint("TOPRIGHT", anchor, "BOTTOMRIGHT", 0, -4)
                        fr.titleDiv:SetHeight(1)
                        fr.titleDiv:Show()
                    end

                    if fr.meta then
                        if it and (not it.decorTypeBreadcrumb or it.decorTypeBreadcrumb == "") then
                            if D and D.ApplyDecorBreadcrumb then
                                D.ApplyDecorBreadcrumb(it)
                            end
                            if (not it.decorTypeBreadcrumb or it.decorTypeBreadcrumb == "") and it.decorID then
                                local breadcrumb = GetDecorCategoryBreadcrumb(it.decorID)
                                if breadcrumb and breadcrumb ~= "" then
                                    it.decorTypeBreadcrumb = breadcrumb
                                end
                            end
                        end
                        local metaText = it and (it.decorTypeBreadcrumb or "Uncategorized") or "Uncategorized"
                        fr.meta:ClearAllPoints()
                        if metaText ~= "" then
                            local anchor = (fr.titleDiv and fr.titleDiv:IsShown()) and fr.titleDiv or fr.label
                            fr.meta:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -6)
                            local maxWidth = math.max(0, w - 24)
                            if fr.meta.SetWidth then fr.meta:SetWidth(maxWidth) end
                            fr.meta:SetText("|cff9aa0a6" .. metaText .. "|r")
                            fr.meta:Show()
                        else
                            fr.meta:Hide()
                        end
                    end

                    local req = R and R.GetRequirementLink and R.GetRequirementLink(it)
                    if fr.req and fr.reqBtn and fr.reqRow and R.BuildReqDisplay then
                        if fr.secReq then fr.secReq:Hide() end

                        if req then
                            fr.req._req = req
                            fr.req:SetText(R.BuildReqDisplay(req, false))
                        else
                            fr.req._req = nil
                            fr.req:SetText("|cff8c959fNo quest or achievement required|r")
                        end
                        fr.req:Show()

                        local textHeight = fr.req:GetStringHeight() or 0
                        local rowHeight = math.max(32, textHeight + 16)
                        fr.reqRow:SetHeight(rowHeight)
                        fr.reqRow:Show()

                        if req then
                            fr.reqBtn:ClearAllPoints()
                            fr.reqBtn:SetPoint("TOPLEFT", fr.reqRow, "TOPLEFT", 0, 0)
                            fr.reqBtn:SetPoint("BOTTOMRIGHT", fr.reqRow, "BOTTOMRIGHT", 0, 0)
                            fr.reqBtn:Show()
                            BindReqButton(fr.reqBtn)
                        else
                            fr.reqBtn:Hide()
                        end
                    else
                        if fr.secReq then fr.secReq:Hide() end
                        if fr.reqRow then fr.reqRow:Hide() end
                        if fr.req then fr.req:Hide() end
                        if fr.reqBtn then fr.reqBtn:Hide() end
                    end

                    local rep = R and R.GetRepRequirement and R.GetRepRequirement(it)
                    if fr.rep and fr.repRow and R.BuildRepDisplay then
                        if fr.secRep then fr.secRep:Hide() end

                        if rep then
                            fr.rep:SetText(R.BuildRepDisplay(rep, false))
                        else
                            fr.rep:SetText("|cff8c959fNo reputation required|r")
                        end
                        fr.rep:Show()

                        local textHeight = fr.rep:GetStringHeight() or 0
                        local rowHeight = math.max(32, textHeight + 16)
                        fr.repRow:SetHeight(rowHeight)
                        fr.repRow:Show()
                    else
                        if fr.secRep then fr.secRep:Hide() end
                        if fr.repRow then fr.repRow:Hide() end
                        if fr.rep then fr.rep:Hide() end
                    end

                    if fr.textArea and fr.reqRow and fr.reqRow:IsShown() then
                        fr.reqRow:ClearAllPoints()
                        fr.reqRow:SetPoint("TOPLEFT", fr.textArea, "BOTTOMLEFT", 0, -2)
                        fr.reqRow:SetPoint("TOPRIGHT", fr.textArea, "BOTTOMRIGHT", 0, -2)
                    end

                    if fr.textArea and fr.repRow and fr.repRow:IsShown() then
                        fr.repRow:ClearAllPoints()
                        if fr.reqRow and fr.reqRow:IsShown() then
                            local reqH = fr.reqRow:GetHeight() or 32
                            fr.repRow:SetPoint("TOPLEFT", fr.textArea, "BOTTOMLEFT", 0, -(reqH + 4))
                            fr.repRow:SetPoint("TOPRIGHT", fr.textArea, "BOTTOMRIGHT", 0, -(reqH + 4))
                        else
                            fr.repRow:SetPoint("TOPLEFT", fr.textArea, "BOTTOMLEFT", 0, -2)
                            fr.repRow:SetPoint("TOPRIGHT", fr.textArea, "BOTTOMRIGHT", 0, -2)
                        end
                    end

                    if fr.dyePaletteFrame then
    local label = GetDyeableOrClassLabel(it)
    if label and label ~= "" then
        if fr.dyePaletteFrame.text then fr.dyePaletteFrame.text:SetText(label) end
        fr.dyePaletteFrame:Show()
    else
        fr.dyePaletteFrame:Hide()
    end
end

                    if StatusIcon and StatusIcon.Attach then StatusIcon:Attach(fr, state, it) end
                    ApplyFactionBadge(fr, it, 24)

                    if Favorite and Favorite.Attach then
                        local id = U and U.GetItemID and U.GetItemID(it)
                        if fr._fav and fr._fav.SetItemID then
                            fr._fav:SetItemID(id)
                        else
                            if fr._fav then fr._fav:Hide() end
                            fr._fav = Favorite:Attach(fr, id, function() f:RequestRender(false) end)
                        end
                        if fr._fav then
                            fr._fav:ClearAllPoints()
                            fr._fav:SetPoint("TOPLEFT", (fr.media or fr), "TOPLEFT", 8, -8)
                            if fr._fav.SetSize then fr._fav:SetSize(20, 20) end
                            if fr._fav.SetFrameLevel then fr._fav:SetFrameLevel((fr:GetFrameLevel() or 1) + 20) end
                            if fr._fav.SetAlpha then fr._fav:SetAlpha(0.85) end
                            SetupFavoriteHover(fr._fav)
                        end
                    end

                    if TT and TT.Attach then TT:Attach(fr, it) end

                    local db = U and U.DB and U.DB()
                    local ui = (db and db.ui) or {}
                    local showDropsBadge = (ui.activeCategory == "Drops") or ((it and it.source and it.source.type) == "drop")
                    if showDropsBadge and DropPanel and DropPanel.AttachBadge then
                        DropPanel:AttachBadge(fr, it, "tile")
                    elseif fr._dropBadge then
                        fr._dropBadge:Hide()
                    end

                    fr:SetScript("OnMouseUp", function(_, btn)
                        if IA and IA.HandleMouseUp then
                            IA:HandleMouseUp(it, btn, e.nav)
                        end
                    end)

                elseif e.kind == "list" then
                    local it = D and D.ResolveAchievementDecor and D.ResolveAchievementDecor(e.it) or e.it
                    local state = U and U.GetStateSafe and U.GetStateSafe(it)
                    local maxW = (e.w or 0) - 84

                    if fr.icon then
                        local tex = (it and it.source and it.source.icon) or
                                   (it and it.decorID and D and D.GetDecorIcon and D.GetDecorIcon(it.decorID)) or
                                   "Interface\\Icons\\INV_Misc_QuestionMark"
                        fr.icon:SetTexture(tex)
                        if fr.icon.SetTexCoord then fr.icon:SetTexCoord(0.20, 0.80, 0.20, 0.80) end
                    end

                    if fr.text then
                        local title = it and (it.title or (it.decorID and D and D.GetDecorName and D.GetDecorName(it.decorID)))
                        if not title or title == "" then
                            title = "Decor #" .. tostring(it and (it.decorID or it.itemID) or "?")
                        end
                        fr.text:SetText(title)
                        fr.text:SetWidth(maxW)
                    end

                    local collected = (state and ((type(state) == "table" and state.collected) or state == true))
                    if fr.check then
                        if collected then fr.check:Show() else fr.check:Hide() end
                    end

                    if fr.meta then
                        if it and (not it.decorTypeBreadcrumb or it.decorTypeBreadcrumb == "") then

                            if D and D.ApplyDecorBreadcrumb then
                                D.ApplyDecorBreadcrumb(it)
                            end

                            if (not it.decorTypeBreadcrumb or it.decorTypeBreadcrumb == "") and it.decorID then
                                local breadcrumb = GetDecorCategoryBreadcrumb(it.decorID)
                                if breadcrumb and breadcrumb ~= "" then
                                    it.decorTypeBreadcrumb = breadcrumb
                                end
                            end
                        end
                        local metaText = it and (it.decorTypeBreadcrumb or it.decorType or it.subcategory or "Uncategorized") or "Uncategorized"
                        fr.meta:ClearAllPoints()
                        if metaText ~= "" then
                            fr.meta:SetPoint("TOPLEFT", fr.text, "BOTTOMLEFT", 0, -4)
                            fr.meta:SetWidth(maxW)
                            fr.meta:SetHeight(16)
                            fr.meta:SetText("|cff9aa0a6" .. metaText .. "|r")
                            fr.meta:Show()
                        else
                            fr.meta:Hide()
                        end
                    end

                    local anchor = (fr.meta and fr.meta:IsShown()) and fr.meta or fr.text
                    if fr.div then
                        local req = R and R.GetRequirementLink and R.GetRequirementLink(it)
                        local rep = R and R.GetRepRequirement and R.GetRepRequirement(it)
                        if (fr.meta and fr.meta:IsShown()) or req or rep then
                            fr.div:ClearAllPoints()
                            fr.div:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -6)
                            fr.div:SetPoint("TOPRIGHT", anchor, "BOTTOMRIGHT", 0, -6)
                            fr.div:SetHeight(1)
                            fr.div:Show()
                        else
                            fr.div:Hide()
                        end
                    end

                    local req = R and R.GetRequirementLink and R.GetRequirementLink(it)
                    if req and fr.req and fr.reqBtn and R.BuildReqDisplay then
                        fr.req:Show()
                        fr.req:ClearAllPoints()
                        fr.req:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -12)
                        fr.req:SetWidth(maxW)
                        fr.req:SetHeight(18)
                        fr.req._req = req
                        fr.req:SetText(R.BuildReqDisplay(req, false))

                        fr.reqBtn:ClearAllPoints()
                        fr.reqBtn:SetPoint("TOPLEFT", fr.req, "TOPLEFT", -2, 2)
                        fr.reqBtn:SetPoint("BOTTOMRIGHT", fr.req, "BOTTOMRIGHT", 2, -2)
                        fr.reqBtn:Show()
                        BindReqButton(fr.reqBtn)
                    else
                        if fr.req then fr.req:Hide() end
                        if fr.reqBtn then fr.reqBtn:Hide() end
                    end

                    local rep = R and R.GetRepRequirement and R.GetRepRequirement(it)
                    if rep and fr.rep and R.BuildRepDisplay then
                        fr.rep:Show()
                        fr.rep:ClearAllPoints()
                        if req and fr.req and fr.req:IsShown() then
                            fr.rep:SetPoint("TOPLEFT", fr.req, "BOTTOMLEFT", 0, -3)
                        else
                            fr.rep:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -12)
                        end
                        fr.rep:SetWidth(maxW)
                        fr.rep:SetHeight(18)
                        fr.rep:SetText(R.BuildRepDisplay(rep, false))
                    else
                        if fr.rep then fr.rep:Hide() end
                    end

                    if fr.dyePaletteFrame then
    local label = GetDyeableOrClassLabel(it)
    if label and label ~= "" then
        if fr.dyePaletteFrame.text then fr.dyePaletteFrame.text:SetText(label) end
        fr.dyePaletteFrame:Show()
    else
        fr.dyePaletteFrame:Hide()
    end
end

                    if StatusIcon and StatusIcon.Attach then StatusIcon:Attach(fr, state, it) end
                    ApplyFactionBadge(fr, it, 16)

                    if Favorite and Favorite.Attach then
                        local id = U and U.GetItemID and U.GetItemID(it)
                        if fr._fav and fr._fav.SetItemID then
                            fr._fav:SetItemID(id)
                        else
                            if fr._fav then fr._fav:Hide() end
                            fr._fav = Favorite:Attach(fr, id, function() f:RequestRender(false) end)
                        end
                        if fr._fav then
                            fr._fav:ClearAllPoints()
                            fr._fav:SetPoint("TOPRIGHT", (fr.media or fr), "TOPRIGHT", -8, -8)
                            if fr._fav.SetFrameLevel then fr._fav:SetFrameLevel((fr:GetFrameLevel() or 1) + 20) end
                            if fr._fav.SetAlpha then fr._fav:SetAlpha(0.85) end
                            SetupFavoriteHover(fr._fav)
                        end
                    end

                    if TT and TT.Attach then TT:Attach(fr, it) end

                    local db = U and U.DB and U.DB()
                    local ui = (db and db.ui) or {}
                    local showDropsBadge = (ui.activeCategory == "Drops") or ((it and it.source and it.source.type) == "drop")
                    if showDropsBadge and DropPanel and DropPanel.AttachBadge then
                        DropPanel:AttachBadge(fr, it, "list")
                    elseif fr._dropBadge then
                        fr._dropBadge:Hide()
                    end

                    fr:SetScript("OnMouseUp", function(_, btn)
                        if IA and IA.HandleMouseUp then
                            IA:HandleMouseUp(it, btn, e.nav)
                        end
                    end)
                end
            end
        end

        content:SetHeight(self.totalHeight or 0)
    end

    function f:Render(full)
        if self._suspendRender then return end
        if full ~= false then
            RebuildEntries(self, content)
        end
        self:UpdateVisible()
    end

    function f:RequestRender(full)
        if self._suspendRender then return end

        if full ~= false then
            self:Render(true)
        else
            self:Render(false)
        end
    end

    function f:RefreshDecor(decorID)
        if not decorID then return end
        for i = 1, #self._active do
            local fr = self._active[i]
            local e = fr and fr._entry
            if e and e.kind ~= "header" then
                local it = D and D.ResolveAchievementDecor and D.ResolveAchievementDecor(e.it) or e.it
                if it and it.decorID == decorID then
                    local state = U and U.GetStateSafe and U.GetStateSafe(it)
                    if StatusIcon and StatusIcon.Attach then
                        StatusIcon:Attach(fr, state, it)
                    end
                    ApplyFactionBadge(fr, it, 16)
                end
            end
        end
    end

    f.scrollFrame = sf
    f.content = content
    return f
end

View.Create = function(self, parent) return Render:Create(parent) end
return Render