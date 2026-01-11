------------------------------------------------------------
-- PREVIEW PANEL - Core Module
-- Coordinates UI creation and data display
------------------------------------------------------------

local AddonName, HousingVendor = ...
local L = _G["HousingVendorL"] or {}

local PreviewPanel = {}
PreviewPanel.__index = PreviewPanel

local previewFrame = nil

function PreviewPanel:Initialize(parent)
    self:CreateUI(parent)
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
