------------------------------------------------------------
-- PREVIEW PANEL - Core Module
-- Coordinates UI creation and data display
------------------------------------------------------------

local AddonName, HousingVendor = ...
local L = _G["HousingVendorL"] or {}

local PreviewPanel = {}
PreviewPanel.__index = PreviewPanel

local previewFrame = nil
local listenerKey = "HousingPreviewPanel_AH"

local function TryRegisterAuctionListener()
    local api = _G.HousingAuctionHouseAPI
    local panel = _G.HousingPreviewPanel
    if not (api and api.RegisterListener and panel and panel._ahListenerRegistered ~= true) then
        return false
    end

    api:UnregisterListener(listenerKey)
    api:RegisterListener(listenerKey, function(event, ...)
        if event ~= "price_updated" then
            return
        end
        local itemID = tonumber(select(1, ...))
        if not itemID or not previewFrame or not previewFrame._currentItem then
            return
        end
        local currentID = tonumber(previewFrame._currentItem.itemID)
        if currentID ~= itemID then
            return
        end

        local dataModule = HousingVendor and HousingVendor.PreviewPanelData
        if dataModule and dataModule.DisplayVendorInfo then
            local catalog = previewFrame._currentItem._catalogData or dataModule:GetCatalogData(itemID)
            dataModule:DisplayVendorInfo(previewFrame, previewFrame._currentItem, catalog or {})
        end

        -- Also refresh reagent AH price display (reagent itemIDs differ from the decor itemID).
        if dataModule and dataModule.DisplayReagents then
            pcall(dataModule.DisplayReagents, dataModule, previewFrame, previewFrame._currentItem)
        end
    end)

    panel._ahListenerRegistered = true
    return true
end

function PreviewPanel:Initialize(parent)
    self:CreateUI(parent)

    if TryRegisterAuctionListener() then
        return
    end
    if _G.C_Timer and _G.C_Timer.After then
        _G.C_Timer.After(0.5, function()
            TryRegisterAuctionListener()
        end)
    end
end

function PreviewPanel:GetFrame()
    return previewFrame
end

function PreviewPanel:CreateUI(parent)
    previewFrame = CreateFrame("Frame", "HousingPreviewFrame", parent, "BackdropTemplate")
    
    local uiModule = HousingVendor.PreviewPanelUI
    if uiModule then
        uiModule:CreateUI(parent, previewFrame)
    end
end

function PreviewPanel:ShowItem(item)
    local dataModule = HousingVendor.PreviewPanelData
    if dataModule then
        dataModule:ShowItem(previewFrame, item)
    end
end

function PreviewPanel:GetCatalogData(itemID)
    local dataModule = HousingVendor.PreviewPanelData
    if dataModule then
        return dataModule:GetCatalogData(itemID)
    end
    return {}
end

function PreviewPanel:GatherAllItemInfo(item)
    local dataModule = HousingVendor.PreviewPanelData
    if dataModule then
        return dataModule:GatherAllItemInfo(item)
    end
    return {}
end

function PreviewPanel:ScanTooltip(itemID)
    local dataModule = HousingVendor.PreviewPanelData
    if dataModule then
        return dataModule:ScanTooltip(itemID, previewFrame)
    end
    return {}
end

_G["HousingPreviewPanel"] = PreviewPanel

return PreviewPanel
