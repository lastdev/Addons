-- Config UI Module for HousingVendor addon
-- Settings for scale, font size, etc.

local ConfigUI = {}
ConfigUI.__index = ConfigUI

local configFrame = nil
local currentSettings = {
    uiScale = 1.0,
    fontSize = 12,
}

-- Initialize config with saved settings
function ConfigUI:Initialize()
    if not HousingDB then
        HousingDB = {}
    end
    
    -- Load saved settings or use defaults
    currentSettings.uiScale = HousingDB.uiScale or 1.0
    currentSettings.fontSize = HousingDB.fontSize or 12
end

-- Create config frame
function ConfigUI:CreateConfigFrame()
    if configFrame then
        return configFrame
    end
    
    local frame = CreateFrame("Frame", "HousingVendorConfigFrame", UIParent, "BackdropTemplate")
    frame:SetSize(400, 300)
    frame:SetPoint("CENTER")
    frame:SetFrameStrata("DIALOG")
    frame:Hide()
    
    -- Make movable
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetClampedToScreen(true)
    
    -- Backdrop
    frame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 32,
        insets = { left = 11, right = 12, top = 12, bottom = 11 }
    })
    frame:SetBackdropColor(0, 0, 0, 0.85)
    frame:SetBackdropBorderColor(0.8, 0.6, 0.2, 1)
    
    -- Drag handlers
    frame:SetScript("OnDragStart", function(self)
        self:StartMoving()
    end)
    frame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
    end)
    
    -- Header
    local headerBg = frame:CreateTexture(nil, "BACKGROUND")
    headerBg:SetTexture("Interface\\Buttons\\WHITE8x8")
    headerBg:SetPoint("TOPLEFT", 12, -12)
    headerBg:SetPoint("TOPRIGHT", -12, -12)
    headerBg:SetHeight(40)
    headerBg:SetGradient("HORIZONTAL", CreateColor(0.15, 0.10, 0.25, 0.9), CreateColor(0.05, 0.05, 0.15, 0.9))
    
    local title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("LEFT", headerBg, "LEFT", 15, 0)
    title:SetText("HousingVendor Settings")
    title:SetTextColor(1, 0.82, 0, 1)
    
    -- Close button
    local closeBtn = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", -8, -8)
    closeBtn:SetScript("OnClick", function()
        frame:Hide()
    end)
    
    -- Content area
    local contentY = -70
    
    -- UI Scale slider
    local scaleLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    scaleLabel:SetPoint("TOPLEFT", 30, contentY)
    scaleLabel:SetText("UI Scale")
    scaleLabel:SetTextColor(1, 1, 1, 1)
    
    local scaleValue = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    scaleValue:SetPoint("LEFT", scaleLabel, "RIGHT", 10, 0)
    scaleValue:SetTextColor(1, 0.82, 0, 1)
    scaleValue:SetText(string.format("%.2f", currentSettings.uiScale))
    
    local scaleSlider = CreateFrame("Slider", "HousingVendorScaleSlider", frame, "OptionsSliderTemplate")
    scaleSlider:SetPoint("TOPLEFT", scaleLabel, "BOTTOMLEFT", 0, -10)
    scaleSlider:SetWidth(340)
    scaleSlider:SetMinMaxValues(0.5, 1.5)
    scaleSlider:SetValue(currentSettings.uiScale)
    scaleSlider:SetValueStep(0.05)
    scaleSlider:SetObeyStepOnDrag(true)
    
    -- Slider labels
    _G[scaleSlider:GetName() .. "Low"]:SetText("0.5")
    _G[scaleSlider:GetName() .. "High"]:SetText("1.5")
    _G[scaleSlider:GetName() .. "Text"]:SetText("")
    
    scaleSlider:SetScript("OnValueChanged", function(self, value)
        currentSettings.uiScale = value
        scaleValue:SetText(string.format("%.2f", value))
        
        -- Apply immediately to main frame
        if HousingUINew and HousingUINew.ApplyScale then
            HousingUINew:ApplyScale(value)
        end
    end)
    
    contentY = contentY - 70
    
    -- Font Size slider
    local fontLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    fontLabel:SetPoint("TOPLEFT", 30, contentY)
    fontLabel:SetText("Font Size")
    fontLabel:SetTextColor(1, 1, 1, 1)
    
    local fontValue = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    fontValue:SetPoint("LEFT", fontLabel, "RIGHT", 10, 0)
    fontValue:SetTextColor(1, 0.82, 0, 1)
    fontValue:SetText(tostring(currentSettings.fontSize) .. "px")
    
    local fontSlider = CreateFrame("Slider", "HousingVendorFontSlider", frame, "OptionsSliderTemplate")
    fontSlider:SetPoint("TOPLEFT", fontLabel, "BOTTOMLEFT", 0, -10)
    fontSlider:SetWidth(340)
    fontSlider:SetMinMaxValues(10, 18)
    fontSlider:SetValue(currentSettings.fontSize)
    fontSlider:SetValueStep(1)
    fontSlider:SetObeyStepOnDrag(true)
    
    -- Slider labels
    _G[fontSlider:GetName() .. "Low"]:SetText("10")
    _G[fontSlider:GetName() .. "High"]:SetText("18")
    _G[fontSlider:GetName() .. "Text"]:SetText("")
    
    fontSlider:SetScript("OnValueChanged", function(self, value)
        currentSettings.fontSize = value
        fontValue:SetText(tostring(value) .. "px")
        
        -- Apply immediately to item list only (statistics UI uses fixed font size)
        if HousingItemList and HousingItemList.ApplyFontSize then
            HousingItemList:ApplyFontSize(value)
        end
    end)

    -- Save button
    local saveBtn = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    saveBtn:SetSize(100, 30)
    saveBtn:SetPoint("BOTTOM", -55, 20)
    saveBtn:SetText("Save")
    saveBtn:SetScript("OnClick", function()
        -- Save to DB
        HousingDB.uiScale = currentSettings.uiScale
        HousingDB.fontSize = currentSettings.fontSize

        print("|cFFFFD100HousingVendor:|r Settings saved!")
        frame:Hide()
    end)
    
    -- Reset button
    local resetBtn = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    resetBtn:SetSize(100, 30)
    resetBtn:SetPoint("BOTTOM", 55, 20)
    resetBtn:SetText("Reset")
    resetBtn:SetScript("OnClick", function()
        -- Reset to defaults
        currentSettings.uiScale = 1.0
        currentSettings.fontSize = 12

        scaleSlider:SetValue(1.0)
        fontSlider:SetValue(12)

        -- Apply defaults
        if HousingUINew and HousingUINew.ApplyScale then
            HousingUINew:ApplyScale(1.0)
        end
        if HousingItemList and HousingItemList.ApplyFontSize then
            HousingItemList:ApplyFontSize(12)
        end
        -- Statistics UI uses fixed font size and is not affected by font slider

        print("|cFFFFD100HousingVendor:|r Settings reset to defaults")
    end)
    
    configFrame = frame
    return frame
end

-- Show config UI
function ConfigUI:Show()
    if not configFrame then
        self:CreateConfigFrame()
    end
    configFrame:Show()
end

-- Hide config UI
function ConfigUI:Hide()
    if configFrame then
        configFrame:Hide()
    end
end

-- Toggle config UI
function ConfigUI:Toggle()
    if configFrame and configFrame:IsVisible() then
        self:Hide()
    else
        self:Show()
    end
end

-- Get current settings
function ConfigUI:GetSettings()
    return currentSettings
end

-- Make globally accessible
_G["HousingConfigUI"] = ConfigUI

return ConfigUI

