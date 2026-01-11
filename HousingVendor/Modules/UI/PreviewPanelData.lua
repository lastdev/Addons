------------------------------------------------------------
-- PREVIEW PANEL DATA - Data Display Module
------------------------------------------------------------

local AddonName, HousingVendor = ...
local L = _G["HousingVendorL"] or {}

local PreviewPanelData = HousingVendor.PreviewPanelData or {}
PreviewPanelData.__index = PreviewPanelData

PreviewPanelData.Util = PreviewPanelData.Util or {}

-- Register globally EARLY so sub-modules can access it
HousingVendor.PreviewPanelData = PreviewPanelData
_G["HousingPreviewPanelData"] = PreviewPanelData

-- API-only vendor mode - static vendor enrichment disabled for accuracy with new content
local USE_STATIC_VENDOR_ENRICHMENT = false

local tooltipScanner = CreateFrame("GameTooltip", "HousingPreviewTooltipScanner", UIParent, "GameTooltipTemplate")
tooltipScanner:SetOwner(UIParent, "ANCHOR_NONE")

function PreviewPanelData:ScanTooltip(itemID, previewFrame)
    local result = {
        description = nil,
        useText = nil,
        collectionBonus = nil,
        sellPrice = nil,
        binding = nil,
        weight = nil,
        houseIcon = nil
    }
    
    local id = tonumber(itemID)
    if not id then return result end
    
    tooltipScanner:ClearLines()
    tooltipScanner:SetItemByID(id)
    
    C_Timer.After(0.25, function()
        if not previewFrame or not previewFrame:IsShown() then return end
        
        for i = 1, tooltipScanner:NumLines() do
            local leftText = _G["HousingPreviewTooltipScannerTextLeft" .. i]
            local leftTexture = _G["HousingPreviewTooltipScannerTexture" .. i]
            local rightTexture = _G["HousingPreviewTooltipScannerTexture" .. i .. "Right"]
            
        if leftText then
            local text = leftText:GetText()
            if text then
                    local weight = text:match("Weight:%s*(%d+)")
                if weight then
                        result.weight = tonumber(weight)
                        if previewFrame.weightValue and previewFrame.SetFieldValue then
                            previewFrame.SetFieldValue(previewFrame.weightValue, tostring(result.weight), previewFrame.weightValue.label)
                        end
                    end
                    
                    local font = leftText:GetFont()
                    if font and tostring(font):find("Italic") then
                        if not result.description then
                            result.description = text
                        end
                    end
                    
                    if text:match("^Use:") then
                        result.useText = text
                    end
                    
                    if text:match("Collection Bonus") or text:match("First%-Time") then
                        result.collectionBonus = text
                    end
                    
                    if text:match("Sell Price:") then
                        result.sellPrice = text
                    end
                    
                    if text:match("Binds") then
                        result.binding = text
                end
            end
        end

            if leftTexture then
            local texture = leftTexture:GetTexture()
                if texture and texture ~= "" then
                    local textureStr = tostring(texture)
                    if not textureStr:find("INV_Weapon") and
                       not textureStr:find("INV_Sword") and
                       not textureStr:find("INV_Axe") and
                       not textureStr:find("INV_Mace") and
                       not textureStr:find("INV_Shield") and
                       not textureStr:find("INV_Helmet") and
                       not textureStr:find("INV_Armor") and
                       not textureStr:find("INV_Misc_QuestionMark") and
                       not textureStr:find("INV_Boots") and
                       not textureStr:find("INV_Gauntlets") and
                       not textureStr:find("INV_Shoulder") and
                       not textureStr:find("INV_Chest") then
                        if not result.houseIcon then
                            result.houseIcon = texture
                            if previewFrame.houseIconValue then
                                if not previewFrame.houseIconTexture then
                                    local iconTex = previewFrame.details:CreateTexture(nil, "OVERLAY")
                                    iconTex:SetSize(20, 20)
                                    iconTex:SetPoint("LEFT", previewFrame.houseIconValue, "RIGHT", 5, 0)
                                    previewFrame.houseIconTexture = iconTex
                                end
                                previewFrame.houseIconTexture:SetTexture(texture)
                                previewFrame.houseIconTexture:Show()
                                if previewFrame.SetFieldValue then
                                    previewFrame.SetFieldValue(previewFrame.houseIconValue, "Yes", previewFrame.houseIconValue.label)
                                else
                                    previewFrame.houseIconValue:SetText("Yes")
                                end
            end
        end
    end
                end
            end
            
            if rightTexture then
                local texture = rightTexture:GetTexture()
                if texture and texture ~= "" then
                    local textureStr = tostring(texture)
                    if not textureStr:find("INV_Weapon") and
                       not textureStr:find("INV_Sword") and
                       not textureStr:find("INV_Axe") and
                       not textureStr:find("INV_Mace") and
                       not textureStr:find("INV_Shield") and
                       not textureStr:find("INV_Helmet") and
                       not textureStr:find("INV_Armor") and
                       not textureStr:find("INV_Misc_QuestionMark") and
                       not textureStr:find("INV_Boots") and
                       not textureStr:find("INV_Gauntlets") and
                       not textureStr:find("INV_Shoulder") and
                       not textureStr:find("INV_Chest") then
                        if not result.houseIcon then
                            result.houseIcon = texture
                            if previewFrame.houseIconValue then
                                if not previewFrame.houseIconTexture then
                                    local iconTex = previewFrame.details:CreateTexture(nil, "OVERLAY")
                                    iconTex:SetSize(20, 20)
                                    iconTex:SetPoint("LEFT", previewFrame.houseIconValue, "RIGHT", 5, 0)
                                    previewFrame.houseIconTexture = iconTex
                                end
                                previewFrame.houseIconTexture:SetTexture(texture)
                                previewFrame.houseIconTexture:Show()
                                if previewFrame.SetFieldValue then
                                    previewFrame.SetFieldValue(previewFrame.houseIconValue, "Yes", previewFrame.houseIconValue.label)
                                else
                                    previewFrame.houseIconValue:SetText("Yes")
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
    
    return result
end

function PreviewPanelData:GetCatalogData(itemID)
    local id = tonumber(itemID)
    if not id then return {} end

    if HousingAPICache and HousingAPICache.GetCatalogData then
        local ok, data = pcall(function()
            return HousingAPICache:GetCatalogData(id)
        end)
        if ok and type(data) == "table" then
            return data
        end
    end

    if HousingAPI and HousingAPI.GetCatalogData then
        local ok, data = pcall(function()
            return HousingAPI:GetCatalogData(id)
        end)
        if ok and type(data) == "table" then
            return data
        end
    end

    return {}
end

function PreviewPanelData:GatherAllItemInfo(item)
    if not item or not item.itemID then
        return {}
    end
    
    local allInfo = {
        itemInfo = nil,
        catalogInfo = nil,
        decorInfo = nil
    }
    
    local itemID = tonumber(item.itemID)
    if not itemID then
        return allInfo
    end
    
    if HousingAPI then
        local catalogData = HousingAPI:GetCatalogData(itemID)
        if catalogData and type(catalogData) == "table" then
            allInfo.catalogInfo = catalogData
        end
        
        local decorInfo = HousingAPI:GetDecorItemInfoFromItemID(itemID)
        if decorInfo and type(decorInfo) == "table" then
            allInfo.decorInfo = decorInfo
        end
    end
    
    if C_Item and C_Item.GetItemInfo then
        if C_Item.RequestLoadItemDataByID then
            C_Item.RequestLoadItemDataByID(itemID)
        end
        
        local ok, itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType = pcall(C_Item.GetItemInfo, itemID)
        if ok and itemName then
            allInfo.itemInfo = {
                itemName = itemName,
                itemLink = itemLink,
                itemQuality = itemQuality,
                itemLevel = itemLevel,
                itemMinLevel = itemMinLevel,
                itemType = itemType,
                itemSubType = itemSubType
            }
        end
    end
    
    return allInfo
end

function PreviewPanelData:ShowItem(previewFrame, item)
    if not previewFrame then return end
    if not item or not item.itemID then return end

    previewFrame:Show()
    
    previewFrame._currentItem = item
    
    local numericItemID = tonumber(item.itemID)
    local catalogData = self:GetCatalogData(numericItemID)
    
    if catalogData and catalogData.cost then
        item._catalogCost = catalogData.cost
    end
    
    item._catalogData = catalogData
    
    if previewFrame.wishlistButton then
        local itemID = tonumber(item.itemID)
        local isInWishlist = itemID and HousingDB and HousingDB.wishlist and HousingDB.wishlist[itemID]
        if isInWishlist then
            previewFrame.wishlistButton.icon:SetTexture("Interface\\Icons\\INV_ValentinesCandy")
            previewFrame.wishlistButton.icon:SetDesaturated(false)
        else
            previewFrame.wishlistButton.icon:SetTexture("Interface\\Icons\\INV_ValentinesCandy")
            previewFrame.wishlistButton.icon:SetDesaturated(true)
        end
    end
    
    local tooltipData = self:ScanTooltip(item.itemID, previewFrame)

    self:DisplayNameAndIcon(previewFrame, item, catalogData)
    self:DisplayCollectionStatus(previewFrame, item, catalogData)
    self:DisplayExpansionAndFaction(previewFrame, item, catalogData)
    self:DisplayVendorInfo(previewFrame, item, catalogData)
    self:DisplayProfessionInfo(previewFrame, item, catalogData)
    self:DisplayRequirements(previewFrame, item, catalogData)
    self:Display3DModel(previewFrame, item, catalogData)

    -- Cost/vendor info can be delayed right after login/reload; retry briefly for the currently displayed item.
    if C_Timer and C_Timer.After and numericItemID then
        local maxAttempts = 3
        local function NeedsVendorCostRetry()
            if not previewFrame or not previewFrame.IsShown or not previewFrame:IsShown() then return false end
            if not previewFrame._currentItem or tonumber(previewFrame._currentItem.itemID) ~= numericItemID then return false end

            local vendorMissing = (previewFrame.vendorValue and (not previewFrame.vendorValue:IsShown() or previewFrame.vendorValue:GetText() == ""))
            local costMissing = (previewFrame.costValue and (not previewFrame.costValue:IsShown() or previewFrame.costValue:GetText() == ""))
            return vendorMissing or costMissing
        end

        local function Retry(attempt)
            if attempt > maxAttempts then return end
            if not NeedsVendorCostRetry() then return end

            local refreshed = self:GetCatalogData(numericItemID)
            item._catalogData = refreshed
            self:DisplayVendorInfo(previewFrame, item, refreshed)

            if NeedsVendorCostRetry() then
                C_Timer.After(0.8, function()
                    Retry(attempt + 1)
                end)
            end
        end

        if NeedsVendorCostRetry() then
            C_Timer.After(0.8, function()
                Retry(1)
            end)
        end
    end
end

