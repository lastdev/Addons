-- Housing Tooltip Scanner
-- Centralized tooltip scanning utility
-- Consolidates tooltip parsing logic from ItemList.lua, ItemButtonTooltip.lua, and TooltipInfoExtractor.lua

local HousingTooltipScanner = {}
HousingTooltipScanner.__index = HousingTooltipScanner

-- Create shared tooltip scanner frame
local scanner = CreateFrame("GameTooltip", "HousingTooltipScannerFrame", UIParent, "GameTooltipTemplate")
scanner:SetOwner(UIParent, "ANCHOR_NONE")

-- Cache global references for performance
local _G = _G
local tonumber = tonumber
local tostring = tostring
local string_find = string.find
local string_match = string.match
local string_format = string.format
local pairs = pairs

-- Reusable callback to avoid closure creation
local scanCallback
local pendingScans = {}

-----------------------------------------------------------
-- Process tooltip data from scanner frame
-----------------------------------------------------------
local function ProcessTooltipLines(tooltipData)
    local numLines = scanner:NumLines()

    for i = 1, numLines do
        local leftText = _G[string_format("HousingTooltipScannerFrameTextLeft%d", i)]
        local rightText = _G[string_format("HousingTooltipScannerFrameTextRight%d", i)]
        local leftTexture = _G[string_format("HousingTooltipScannerFrameTexture%d", i)]
        local rightTexture = _G[string_format("HousingTooltipScannerFrameTexture%dRight", i)]

        if leftText then
            local text = leftText:GetText()
            if text then
                -- Line 1 is always item name
                if i == 1 then
                    tooltipData.itemName = text
                end

                -- Extract weight (housing-specific)
                local weight = string_match(text, "Weight:%s*(%d+)")
                if weight then
                    tooltipData.weight = tonumber(weight)
                end

                -- Extract binding info
                if string_find(text, "Binds") then
                    tooltipData.binding = text
                end

                -- Extract "Use:" text
                if string_find(text, "Use:") then
                    tooltipData.useText = text
                end

                -- Extract collection bonus
                if string_find(text, "Collection Bonus") or string_find(text, "First%-Time") then
                    tooltipData.collectionBonus = text
                end

                -- Extract item level
                local itemLevel = string_match(text, "Item Level (%d+)")
                if itemLevel then
                    tooltipData.itemLevel = tonumber(itemLevel)
                end

                -- Extract required level
                local reqLevel = string_match(text, "Requires Level (%d+)")
                if reqLevel then
                    tooltipData.requiredLevel = tonumber(reqLevel)
                end

                -- Extract class requirements
                if string_find(text, "Requires") and
                   (string_find(text, "Class:") or
                    string_find(text, "Warrior") or string_find(text, "Paladin") or
                    string_find(text, "Hunter") or string_find(text, "Rogue") or
                    string_find(text, "Priest") or string_find(text, "Death Knight") or
                    string_find(text, "Shaman") or string_find(text, "Mage") or
                    string_find(text, "Warlock") or string_find(text, "Monk") or
                    string_find(text, "Druid") or string_find(text, "Demon Hunter") or
                    string_find(text, "Evoker")) then
                    tooltipData.requiredClass = text
                end

                -- Extract description (italic font)
                local font = tostring(leftText:GetFont() or "")
                if string_find(font, "Italic") and not tooltipData.description then
                    tooltipData.description = text
                end
            end
        end

        if rightText then
            local text = rightText:GetText()
            if text then
                -- Right text usually contains sell price, stack size, etc.
                -- Can be extended as needed
            end
        end

        -- Extract textures (for house icons)
        if leftTexture and leftTexture:IsShown() then
            local texture = leftTexture:GetTexture()
            if texture and texture ~= "" then
                local textureStr = tostring(texture)

                -- Look for house icon (exclude weapon/armor icons)
                if not string_find(textureStr, "INV_Weapon") and
                   not string_find(textureStr, "INV_Sword") and
                   not string_find(textureStr, "INV_Axe") and
                   not string_find(textureStr, "INV_Mace") and
                   not string_find(textureStr, "INV_Shield") and
                   not string_find(textureStr, "INV_Misc_QuestionMark") and
                   not string_find(textureStr, "INV_Helmet") and
                   not string_find(textureStr, "INV_Armor") then
                    if not tooltipData.houseIcon then
                        tooltipData.houseIcon = texture
                    end
                end
            end
        end

        if rightTexture and rightTexture:IsShown() then
            local texture = rightTexture:GetTexture()
            if texture and texture ~= "" then
                local textureStr = tostring(texture)

                -- Check right texture for house icon
                if not string_find(textureStr, "INV_Weapon") and
                   not string_find(textureStr, "INV_Sword") and
                   not string_find(textureStr, "INV_Axe") and
                   not string_find(textureStr, "INV_Mace") and
                   not string_find(textureStr, "INV_Shield") and
                   not string_find(textureStr, "INV_Misc_QuestionMark") and
                   not string_find(textureStr, "INV_Helmet") and
                   not string_find(textureStr, "INV_Armor") then
                    if not tooltipData.houseIcon then
                        tooltipData.houseIcon = texture
                    end
                end
            end
        end
    end
end

-----------------------------------------------------------
-- Public API: Scan item tooltip for data
-- @param itemID number The item ID to scan
-- @param callback function Optional callback(tooltipData) called when scan completes
-- @return table tooltipData if no callback provided (synchronous mode)
-----------------------------------------------------------
function HousingTooltipScanner:ScanItem(itemID, callback)
    local numericItemID = tonumber(itemID)
    if not numericItemID then
        local emptyData = {
            weight = nil,
            houseIcon = nil,
            description = nil,
            itemName = nil,
            itemLevel = nil,
            binding = nil,
            useText = nil,
            collectionBonus = nil,
            requiredLevel = nil,
            requiredClass = nil,
        }
        if callback then
            callback(emptyData)
        end
        return emptyData
    end

    -- Initialize tooltip data
    local tooltipData = {
        weight = nil,
        houseIcon = nil,
        description = nil,
        itemName = nil,
        itemLevel = nil,
        binding = nil,
        useText = nil,
        collectionBonus = nil,
        requiredLevel = nil,
        requiredClass = nil,
    }

    -- Set tooltip to item
    scanner:ClearLines()
    scanner:SetItemByID(numericItemID)

    if callback then
        -- Asynchronous mode (for batch scanning)
        -- Create reusable callback if needed
        if not scanCallback then
            scanCallback = function()
                for id, data in pairs(pendingScans) do
                    ProcessTooltipLines(data.tooltipData)
                    if data.callback then
                        data.callback(data.tooltipData)
                    end
                    pendingScans[id] = nil
                end
            end
        end

        -- Store pending scan
        pendingScans[numericItemID] = {
            tooltipData = tooltipData,
            callback = callback
        }

        -- Schedule processing (batched)
        C_Timer.After(0.1, scanCallback)
    else
        -- Synchronous mode (immediate processing)
        ProcessTooltipLines(tooltipData)
        return tooltipData
    end
end

-----------------------------------------------------------
-- Public API: Get tooltip scanner frame
-- @return GameTooltip The shared scanner frame
-----------------------------------------------------------
function HousingTooltipScanner:GetScanner()
    return scanner
end

-----------------------------------------------------------
-- Public API: Clear pending scans
-----------------------------------------------------------
function HousingTooltipScanner:ClearPendingScans()
    for k in pairs(pendingScans) do
        pendingScans[k] = nil
    end
end

-- Make globally accessible
_G["HousingTooltipScanner"] = HousingTooltipScanner

return HousingTooltipScanner
