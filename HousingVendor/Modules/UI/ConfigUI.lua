-- Config UI Module
-- Settings for scale, font size, etc.

local ADDON_NAME, ns = ...
local L = ns.L

local ConfigUI = {}
ConfigUI.__index = ConfigUI

local configFrame = nil
local blizzardSettingsCategory = nil
local currentSettings = {
    uiScale = 1.0,
    fontSize = 12,
}

-- Initialize config with saved settings
function ConfigUI:Initialize()
    if not HousingDB then
        HousingDB = {}
    end
    if not HousingDB.settings then
        HousingDB.settings = {}
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
    
    -- Get Midnight theme colors
    local GetTheme = _G["GetHousingTheme"] or function() return {Colors = {}} end
    local theme = GetTheme()
    local colors = theme.Colors or {}
    
    local bgPrimary = HousingTheme.Colors.bgPrimary
    local bgSecondary = HousingTheme.Colors.bgSecondary
    local bgTertiary = HousingTheme.Colors.bgTertiary
    local bgHover = HousingTheme.Colors.bgHover
    local borderPrimary = HousingTheme.Colors.borderPrimary
    local accentPrimary = HousingTheme.Colors.accentPrimary
    local textPrimary = HousingTheme.Colors.textPrimary
    local textSecondary = HousingTheme.Colors.textSecondary
    
    local frame = CreateFrame("Frame", "HousingVendorConfigFrame", UIParent, "BackdropTemplate")
    frame:SetSize(500, 680)
    frame:SetPoint("CENTER")
    frame:SetFrameStrata("DIALOG")
    frame:Hide()

    -- Match the main UI scale.
    if HousingDB and HousingDB.uiScale then
        frame:SetScale(HousingDB.uiScale)
    end
    
    -- Make movable
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetClampedToScreen(true)
    
    -- Modern Midnight backdrop
    frame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    frame:SetBackdropColor(bgPrimary[1], bgPrimary[2], bgPrimary[3], bgPrimary[4])
    frame:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])
    
    -- Drag handlers
    frame:SetScript("OnDragStart", function(self)
        self:StartMoving()
    end)
    frame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
    end)
    
    -- Header with gradient
    local headerBg = frame:CreateTexture(nil, "BACKGROUND")
    headerBg:SetTexture("Interface\\Buttons\\WHITE8x8")
    headerBg:SetPoint("TOPLEFT", 0, 0)
    headerBg:SetPoint("TOPRIGHT", 0, 0)
    headerBg:SetHeight(60)
    headerBg:SetGradient("VERTICAL", 
        CreateColor(0.15, 0.10, 0.22, 0.8), 
        CreateColor(0.10, 0.07, 0.15, 0.6))
    
    local title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("LEFT", headerBg, "LEFT", 20, 0)
    title:SetText(L["BUTTON_SETTINGS"] or "Settings")
    title:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    
    -- Close button (modern style)
    local closeBtn = CreateFrame("Button", nil, frame, "BackdropTemplate")
    closeBtn:SetSize(32, 32)
    closeBtn:SetPoint("TOPRIGHT", -10, -10)
    closeBtn:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false, edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    closeBtn:SetBackdropColor(bgSecondary[1], bgSecondary[2], bgSecondary[3], 0.8)
    closeBtn:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.6)
    
    local closeX = closeBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    closeX:SetPoint("CENTER")
    closeX:SetText(L["BUTTON_CLOSE_X"] or "X")
    closeX:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    
    closeBtn:SetScript("OnEnter", function(self)
        self:SetBackdropColor(0.3, 0.1, 0.1, 1)
        self:SetBackdropBorderColor(0.8, 0.2, 0.2, 1)
    end)
    closeBtn:SetScript("OnLeave", function(self)
        self:SetBackdropColor(bgSecondary[1], bgSecondary[2], bgSecondary[3], 0.8)
        self:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.6)
    end)
    closeBtn:SetScript("OnClick", function()
        frame:Hide()
    end)
    
    -- Scrollable content area (for growing settings list)
    local scrollFrame = CreateFrame("ScrollFrame", "HousingVendorConfigScrollFrame", frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, -60)
    scrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -28, 12)
    scrollFrame:EnableMouseWheel(true)
    scrollFrame:SetScript("OnMouseWheel", function(self, delta)
        local step = 30
        local current = self:GetVerticalScroll()
        local max = self:GetVerticalScrollRange()
        local nextScroll = current - (delta * step)
        if nextScroll < 0 then nextScroll = 0 end
        if nextScroll > max then nextScroll = max end
        self:SetVerticalScroll(nextScroll)
    end)

    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetPoint("TOPLEFT")
    content:SetSize(1, 1)
    scrollFrame:SetScrollChild(content)

    local contentY = -30

    -- Helper function to create section headers
    local function CreateSectionHeader(text, yOffset)
        local header = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        header:SetPoint("TOPLEFT", 20, yOffset)
        header:SetText(text)
        header:SetTextColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)

        -- Add divider line below header
        local divider = content:CreateTexture(nil, "ARTWORK")
        divider:SetTexture("Interface\\Buttons\\WHITE8x8")
        divider:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 0, -4)
        divider:SetSize(440, 1)
        divider:SetVertexColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.5)

        return header, divider
    end

    -- APPEARANCE SECTION
    CreateSectionHeader(L["SETTINGS_SECTION_APPEARANCE"] or "APPEARANCE", contentY)
    contentY = contentY - 35

    -- UI Scale slider
    local scaleLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    scaleLabel:SetPoint("TOPLEFT", 30, contentY)
    scaleLabel:SetText(L["SETTINGS_UI_SCALE"] or "UI Scale")
    scaleLabel:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    
    local scaleValue = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    scaleValue:SetPoint("LEFT", scaleLabel, "RIGHT", 10, 0)
    scaleValue:SetTextColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
    scaleValue:SetText(string.format("%.2f", currentSettings.uiScale))
    
    local scaleSlider = CreateFrame("Slider", "HousingVendorScaleSlider", content, "OptionsSliderTemplate")
    scaleSlider:SetPoint("TOPLEFT", scaleLabel, "BOTTOMLEFT", 0, -15)
    scaleSlider:SetWidth(420)
    scaleSlider:SetMinMaxValues(0.5, 1.5)
    scaleSlider:SetValueStep(0.01)
    scaleSlider:SetObeyStepOnDrag(false)
    scaleSlider:EnableMouse(true)
    scaleSlider:EnableMouseWheel(true)
    
    -- Ensure initial value is set correctly
    local initialValue = math.max(0.5, math.min(1.5, currentSettings.uiScale))
    scaleSlider:SetValue(initialValue)
    
    -- Slider labels with theme colors
    _G[scaleSlider:GetName() .. "Low"]:SetText("0.5")
    _G[scaleSlider:GetName() .. "Low"]:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)
    _G[scaleSlider:GetName() .. "High"]:SetText("1.5")
    _G[scaleSlider:GetName() .. "High"]:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)
    _G[scaleSlider:GetName() .. "Text"]:SetText("")
    
    -- Mouse wheel support
    scaleSlider:SetScript("OnMouseWheel", function(self, delta)
        local currentValue = self:GetValue()
        local step = self:GetValueStep()
        local minVal, maxVal = self:GetMinMaxValues()
        local newValue = currentValue + (delta * step)
        newValue = math.max(minVal, math.min(newValue, maxVal))
        self:SetValue(newValue)
    end)
    
    scaleSlider:SetScript("OnValueChanged", function(self, value)
        -- Round to 2 decimal places for display and storage
        value = math.floor((value * 100) + 0.5) / 100
        value = math.max(0.5, math.min(1.5, value))
        
        currentSettings.uiScale = value
        scaleValue:SetText(string.format("%.2f", value))
        
        -- Auto-save to DB
        HousingDB.uiScale = value
        
        -- Apply immediately to main frame
        if HousingUINew and HousingUINew.ApplyScale then
            HousingUINew:ApplyScale(value)
        end
    end)
    
    contentY = contentY - 90

    -- Theme Selector
    local themeLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    themeLabel:SetPoint("TOPLEFT", 30, contentY)
    themeLabel:SetText(L["SETTINGS_UI_THEME"] or "UI Theme")
    themeLabel:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    
    local currentThemeName = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    currentThemeName:SetPoint("LEFT", themeLabel, "RIGHT", 10, 0)
    currentThemeName:SetTextColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
    currentThemeName:SetText(HousingTheme.ActiveThemeName or "Sleek Black")
    
    -- Theme buttons container
    local themeBtnY = -25
    local themeButtons = {}
    local themeNames = {"Midnight", "Alliance", "Horde", "Sleek Black"}
    
    local function CreateThemeButton(themeName, index)
        local btn = CreateFrame("Button", nil, content, "BackdropTemplate")
        btn:SetSize(100, 32)
        btn:SetPoint("TOPLEFT", themeLabel, "BOTTOMLEFT", (index - 1) * 105, themeBtnY)
        btn:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8x8",
            edgeFile = "Interface\\Buttons\\WHITE8x8",
            tile = false, edgeSize = 1,
            insets = { left = 0, right = 0, top = 0, bottom = 0 }
        })
        
        local isActive = HousingTheme.ActiveThemeName == themeName
        if isActive then
            btn:SetBackdropColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 0.3)
            btn:SetBackdropBorderColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
        else
            btn:SetBackdropColor(bgSecondary[1], bgSecondary[2], bgSecondary[3], 0.6)
            btn:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.8)
        end
        
        local btnText = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        btnText:SetPoint("CENTER")
        btnText:SetText(themeName)
        btnText:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
        
        btn:SetScript("OnEnter", function(self)
            if HousingTheme.ActiveThemeName ~= themeName then
                self:SetBackdropColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 0.2)
                self:SetBackdropBorderColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 0.6)
            end
            
            -- Show theme description tooltip
            local theme = HousingTheme.Themes[themeName]
            if theme then
                GameTooltip:SetOwner(self, "ANCHOR_TOP")
                GameTooltip:SetText(themeName, 1, 1, 1)
                GameTooltip:AddLine(theme.description, 0.8, 0.8, 0.8, true)
                GameTooltip:Show()
            end
        end)
        
        btn:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
            local isActive = HousingTheme.ActiveThemeName == themeName
            if isActive then
                self:SetBackdropColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 0.3)
                self:SetBackdropBorderColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
            else
                self:SetBackdropColor(bgSecondary[1], bgSecondary[2], bgSecondary[3], 0.6)
                self:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.8)
            end
        end)
        
        btn:SetScript("OnClick", function(self)
            -- Set new theme
            local success = HousingTheme:SetTheme(themeName)
            if success then
                currentThemeName:SetText(themeName)
                
                -- Update all theme buttons to show active state
                for _, themeBtn in pairs(themeButtons) do
                    local btnThemeName = themeBtn.themeName
                    local isActive = HousingTheme.ActiveThemeName == btnThemeName
                    -- Get fresh color references from new theme
                    local currentColors = HousingTheme.Colors
                    if isActive then
                        themeBtn:SetBackdropColor(currentColors.accentPrimary[1], currentColors.accentPrimary[2], currentColors.accentPrimary[3], 0.3)
                        themeBtn:SetBackdropBorderColor(currentColors.accentPrimary[1], currentColors.accentPrimary[2], currentColors.accentPrimary[3], 1)
                    else
                        themeBtn:SetBackdropColor(currentColors.bgSecondary[1], currentColors.bgSecondary[2], currentColors.bgSecondary[3], 0.6)
                        themeBtn:SetBackdropBorderColor(currentColors.borderPrimary[1], currentColors.borderPrimary[2], currentColors.borderPrimary[3], 0.8)
                    end
                end
                
                -- Apply theme to main UI immediately
                if HousingUINew and HousingUINew.ApplyTheme then
                    HousingUINew:ApplyTheme()
                end

                -- Apply theme to config frame
                ConfigUI:ApplyThemeToConfigFrame()
            end
        end)
        
        btn.themeName = themeName
        themeButtons[themeName] = btn
        return btn
    end
    
    -- Create theme buttons
    for i, themeName in ipairs(themeNames) do
        CreateThemeButton(themeName, i)
    end
    
    contentY = contentY - 70
    
    -- Font Size slider
    local fontLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    fontLabel:SetPoint("TOPLEFT", 30, contentY)
    fontLabel:SetText(L["SETTINGS_FONT_SIZE"] or "Font Size")
    fontLabel:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    
    local fontValue = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    fontValue:SetPoint("LEFT", fontLabel, "RIGHT", 10, 0)
    fontValue:SetTextColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
    fontValue:SetText(tostring(currentSettings.fontSize) .. "px")
    
    local fontSlider = CreateFrame("Slider", "HousingVendorFontSlider", content, "OptionsSliderTemplate")
    fontSlider:SetPoint("TOPLEFT", fontLabel, "BOTTOMLEFT", 0, -15)
    fontSlider:SetWidth(420)
    fontSlider:SetMinMaxValues(10, 18)
    fontSlider:SetValue(currentSettings.fontSize)
    fontSlider:SetValueStep(1)
    fontSlider:SetObeyStepOnDrag(true)
    
    -- Slider labels with theme colors
    _G[fontSlider:GetName() .. "Low"]:SetText("10")
    _G[fontSlider:GetName() .. "Low"]:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)
    _G[fontSlider:GetName() .. "High"]:SetText("18")
    _G[fontSlider:GetName() .. "High"]:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)
    _G[fontSlider:GetName() .. "Text"]:SetText("")
    
    fontSlider:SetScript("OnValueChanged", function(self, value)
        currentSettings.fontSize = value
        fontValue:SetText(tostring(value) .. "px")
        
        -- Auto-save to DB
        HousingDB.fontSize = value
        
        -- Apply immediately across the addon UI
        if HousingUINew and HousingUINew.ApplyFontSize then
            HousingUINew:ApplyFontSize(value)
        elseif HousingItemList and HousingItemList.ApplyFontSize then
            -- Fallback for older UI versions
            HousingItemList:ApplyFontSize(value)
        end
    end)
    
    contentY = contentY - 90

    -- MAP PINS SECTION
    CreateSectionHeader(L["SETTINGS_SECTION_MAP_PINS"] or "MAP PINS", contentY)
    contentY = contentY - 35

    -- Map Pin Size Slider
    local mapPinSizeLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    mapPinSizeLabel:SetPoint("TOPLEFT", 30, contentY)
    mapPinSizeLabel:SetText(L["SETTINGS_MAP_PIN_SIZE"] or "Map Pin Size")
    mapPinSizeLabel:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)

    -- Get current map pin size from settings or default to 20
    local currentMapPinSize = (HousingDB and HousingDB.mapPinSize) or 20

    local mapPinSizeValue = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    mapPinSizeValue:SetPoint("LEFT", mapPinSizeLabel, "RIGHT", 10, 0)
    mapPinSizeValue:SetTextColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
    mapPinSizeValue:SetText(tostring(currentMapPinSize) .. "px")

    local mapPinSizeSlider = CreateFrame("Slider", "HousingVendorMapPinSizeSlider", content, "OptionsSliderTemplate")
    mapPinSizeSlider:SetPoint("TOPLEFT", mapPinSizeLabel, "BOTTOMLEFT", 0, -15)
    mapPinSizeSlider:SetWidth(420)
    mapPinSizeSlider:SetMinMaxValues(12, 32)
    mapPinSizeSlider:SetValue(currentMapPinSize)
    mapPinSizeSlider:SetValueStep(2)
    mapPinSizeSlider:SetObeyStepOnDrag(true)

    -- Slider labels
    _G[mapPinSizeSlider:GetName() .. "Low"]:SetText("12")
    _G[mapPinSizeSlider:GetName() .. "Low"]:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)
    _G[mapPinSizeSlider:GetName() .. "High"]:SetText("32")
    _G[mapPinSizeSlider:GetName() .. "High"]:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)
    _G[mapPinSizeSlider:GetName() .. "Text"]:SetText("")

    mapPinSizeSlider:SetScript("OnValueChanged", function(self, value)
        value = math.floor(value + 0.5) -- Round to nearest integer
        mapPinSizeValue:SetText(tostring(value) .. "px")

        -- Auto-save to DB
        HousingDB.mapPinSize = value

        -- Apply immediately to map pins
        if _G.HousingVendorMapPins and _G.HousingVendorMapPins.RefreshPinSize then
            _G.HousingVendorMapPins:RefreshPinSize(value)
        end
    end)

    local mapPinSizeDesc = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    mapPinSizeDesc:SetPoint("TOPLEFT", mapPinSizeLabel, "BOTTOMLEFT", 0, -50)
    mapPinSizeDesc:SetWidth(420)
    mapPinSizeDesc:SetJustifyH("LEFT")
    mapPinSizeDesc:SetText(L["SETTINGS_MAP_PIN_SIZE_DESC"] or "Size of vendor pins on the world map and minimap")
    mapPinSizeDesc:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)

    contentY = contentY - 110

    -- ZONE POPUPS SECTION
    CreateSectionHeader(L["SETTINGS_SECTION_ZONE_POPUPS"] or "ZONE POPUPS", contentY)
    contentY = contentY - 35

    -- Zone Popup Toggle Checkbox
    local zonePopupLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    zonePopupLabel:SetPoint("TOPLEFT", 30, contentY)
    zonePopupLabel:SetText(L["SETTINGS_ZONE_POPUPS"] or "Zone Popups")
    zonePopupLabel:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    
    local zonePopupCheckbox = CreateFrame("CheckButton", "HousingZonePopupCheckbox", content, "UICheckButtonTemplate")
    zonePopupCheckbox:SetPoint("LEFT", zonePopupLabel, "RIGHT", 10, 0)
    zonePopupCheckbox:SetSize(24, 24)
    -- Default to true if not set, but respect explicit false values
    local popupEnabled = true
    if HousingDB and HousingDB.settings and HousingDB.settings.showOutstandingPopup ~= nil then
        popupEnabled = HousingDB.settings.showOutstandingPopup
    end
    zonePopupCheckbox:SetChecked(popupEnabled)
    
    local zonePopupDesc = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    zonePopupDesc:SetPoint("TOPLEFT", zonePopupLabel, "BOTTOMLEFT", 0, -8)
    zonePopupDesc:SetWidth(420)
    zonePopupDesc:SetJustifyH("LEFT")
    zonePopupDesc:SetText(L["SETTINGS_ZONE_POPUPS_DESC"] or "Show outstanding items popup when entering a new zone")
    zonePopupDesc:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)
    
    zonePopupCheckbox:SetScript("OnClick", function(self)
        local isChecked = self:GetChecked()
        if HousingDB and HousingDB.settings then
            HousingDB.settings.showOutstandingPopup = isChecked
            if isChecked then
                print("|cFFFF0000Housing|r|cFF0066FFVendor|r: Zone popups enabled")
                -- Start event handlers when setting is enabled
                if HousingOutstandingItemsUI and HousingOutstandingItemsUI.StartEventHandlers then
                    HousingOutstandingItemsUI:StartEventHandlers()
                end
            else
                print("|cFFFF0000Housing|r|cFF0066FFVendor|r: Zone popups disabled")
                -- Stop event handlers when setting is disabled
                if HousingOutstandingItemsUI and HousingOutstandingItemsUI.StopEventHandlers then
                    HousingOutstandingItemsUI:StopEventHandlers()
                end
            end
        end
    end)

    contentY = contentY - 60

    -- Permanent Zone Popup Toggle Checkbox
    local permanentPopupLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    permanentPopupLabel:SetPoint("TOPLEFT", 30, contentY)
    permanentPopupLabel:SetText(L["SETTINGS_PERMANENT_ZONE_POPUP"] or "Permanent Zone Popup")
    permanentPopupLabel:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    
    local permanentPopupCheckbox = CreateFrame("CheckButton", "HousingPermanentPopupCheckbox", content, "UICheckButtonTemplate")
    permanentPopupCheckbox:SetPoint("LEFT", permanentPopupLabel, "RIGHT", 10, 0)
    permanentPopupCheckbox:SetSize(24, 24)
    
    local permanentPopupEnabled = false
    if HousingDB and HousingDB.settings and HousingDB.settings.permanentZonePopup ~= nil then
        permanentPopupEnabled = HousingDB.settings.permanentZonePopup
    end
    permanentPopupCheckbox:SetChecked(permanentPopupEnabled)
    
    local permanentPopupDesc = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    permanentPopupDesc:SetPoint("TOPLEFT", permanentPopupLabel, "BOTTOMLEFT", 0, -8)
    permanentPopupDesc:SetWidth(420)
    permanentPopupDesc:SetJustifyH("LEFT")
    permanentPopupDesc:SetText(L["SETTINGS_PERMANENT_ZONE_POPUP_DESC"] or "Keep zone popup visible while in the same zone (requires Zone Popups to be enabled)")
    permanentPopupDesc:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)
    
    permanentPopupCheckbox:SetScript("OnClick", function(self)
        local isChecked = self:GetChecked()
        if HousingDB and HousingDB.settings then
            HousingDB.settings.permanentZonePopup = isChecked
            if isChecked then
                print("|cFFFF0000Housing|r|cFF0066FFVendor|r: Permanent zone popup enabled")
                -- Trigger immediate zone check to show popup
                if HousingOutstandingItemsUI and HousingOutstandingItemsUI.OnZoneChanged then
                    HousingOutstandingItemsUI:OnZoneChanged()
                end
            else
                print("|cFFFF0000Housing|r|cFF0066FFVendor|r: Permanent zone popup disabled")
                -- Hide popup if currently shown
                if HousingOutstandingItemsUI and HousingOutstandingItemsUI._popupFrame and HousingOutstandingItemsUI._popupFrame:IsShown() then
                    HousingOutstandingItemsUI._popupFrame:Hide()
                end
            end
        end
    end)

    contentY = contentY - 60

    -- Muted Vendors Section
    local mutedVendorsLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    mutedVendorsLabel:SetPoint("TOPLEFT", 30, contentY)
    mutedVendorsLabel:SetText(L["SETTINGS_MUTED_VENDORS"] or "Muted Vendors")
    mutedVendorsLabel:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)

    contentY = contentY - 25

    local mutedVendorsDesc = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    mutedVendorsDesc:SetPoint("TOPLEFT", 30, contentY)
    mutedVendorsDesc:SetWidth(420)
    mutedVendorsDesc:SetJustifyH("LEFT")
    mutedVendorsDesc:SetText(L["SETTINGS_MUTED_VENDORS_DESC"] or "Vendors you've muted will not appear in zone popups. Click the × button next to a vendor in the popup to mute them.")
    mutedVendorsDesc:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)

    contentY = contentY - 35

    -- Create scrollable list of muted vendors
    local mutedScrollFrame = CreateFrame("ScrollFrame", nil, content, "UIPanelScrollFrameTemplate, BackdropTemplate")
    mutedScrollFrame:SetPoint("TOPLEFT", 30, contentY)
    mutedScrollFrame:SetSize(420, 100)
    mutedScrollFrame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false, edgeSize = 1,
        insets = { left = 1, right = 1, top = 1, bottom = 1 }
    })
    mutedScrollFrame:SetBackdropColor(bgSecondary[1], bgSecondary[2], bgSecondary[3], 0.5)
    mutedScrollFrame:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.5)

    -- Add tooltip to muted vendors scroll frame
    mutedScrollFrame:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(L["SETTINGS_MUTED_VENDORS"] or "Muted Vendors", 1, 1, 1)
        GameTooltip:AddLine(L["SETTINGS_MUTED_VENDORS_TOOLTIP"] or "Vendors in this list are hidden from zone popups. Click 'Unmute' to show them again, or click the × button in zone popups to mute additional vendors.", 0.9, 0.9, 0.9, true)
        GameTooltip:Show()
    end)
    mutedScrollFrame:SetScript("OnLeave", function() GameTooltip:Hide() end)

    local mutedContentFrame = CreateFrame("Frame", nil, mutedScrollFrame)
    mutedContentFrame:SetSize(400, 100)
    mutedScrollFrame:SetScrollChild(mutedContentFrame)

    local function RefreshMutedVendorsList()
        -- Clear existing
        for _, child in ipairs({mutedContentFrame:GetChildren()}) do
            child:Hide()
            child:SetParent(nil)
        end

        local yPos = -5
        local mutedVendors = HousingDB and HousingDB.mutedVendors or {}
        local count = 0

        for vendorKey, isMuted in pairs(mutedVendors) do
            if isMuted then
                count = count + 1
                local vendorRow = CreateFrame("Frame", nil, mutedContentFrame, "BackdropTemplate")
                vendorRow:SetPoint("TOPLEFT", 5, yPos)
                vendorRow:SetSize(380, 20)
                vendorRow:SetBackdrop({
                    bgFile = "Interface\\Buttons\\WHITE8x8",
                    edgeFile = "Interface\\Buttons\\WHITE8x8",
                    tile = false, edgeSize = 1,
                    insets = { left = 0, right = 0, top = 0, bottom = 0 }
                })
                vendorRow:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], 0.3)
                vendorRow:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.3)

                -- Vendor name
                local vendorText = vendorRow:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
                vendorText:SetPoint("LEFT", 5, 0)
                vendorText:SetWidth(320)
                vendorText:SetJustifyH("LEFT")
                vendorText:SetText(vendorKey)
                vendorText:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)

                -- Unmute button
                local unmuteBtn = CreateFrame("Button", nil, vendorRow, "BackdropTemplate")
                unmuteBtn:SetPoint("RIGHT", -5, 0)
                unmuteBtn:SetSize(50, 16)
                unmuteBtn:SetBackdrop({
                    bgFile = "Interface\\Buttons\\WHITE8x8",
                    edgeFile = "Interface\\Buttons\\WHITE8x8",
                    tile = false, edgeSize = 1,
                    insets = { left = 0, right = 0, top = 0, bottom = 0 }
                })
                unmuteBtn:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], 0.8)
                unmuteBtn:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 1)

                local unmuteBtnText = unmuteBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
                unmuteBtnText:SetPoint("CENTER")
                unmuteBtnText:SetText("Unmute")
                unmuteBtnText:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)

                unmuteBtn:SetScript("OnClick", function()
                    if HousingDB and HousingDB.mutedVendors then
                        HousingDB.mutedVendors[vendorKey] = nil
                        print("|cFF8A7FD4HousingVendor:|r Unmuted vendor: " .. vendorKey)
                        RefreshMutedVendorsList()
                    end
                end)

                unmuteBtn:SetScript("OnEnter", function(btn)
                    btn:SetBackdropColor(bgHover[1], bgHover[2], bgHover[3], 1)
                end)

                unmuteBtn:SetScript("OnLeave", function(btn)
                    btn:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], 0.8)
                end)

                yPos = yPos - 22
            end
        end

        if count == 0 then
            local emptyText = mutedContentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            emptyText:SetPoint("TOPLEFT", 5, -5)
            emptyText:SetWidth(380)
            emptyText:SetJustifyH("LEFT")
            emptyText:SetText(L["SETTINGS_NO_MUTED_VENDORS"] or "No muted vendors. Click the × button in zone popups to mute vendors.")
            emptyText:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 0.7)
            yPos = yPos - 40
        end

        mutedContentFrame:SetHeight(math.abs(yPos) + 10)
    end

    RefreshMutedVendorsList()

    contentY = contentY - 110

    -- Popup Filters Section
    local popupFiltersLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    popupFiltersLabel:SetPoint("TOPLEFT", 30, contentY)
    popupFiltersLabel:SetText(L["SETTINGS_POPUP_FILTERS"] or "Popup Filters")
    popupFiltersLabel:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)

    contentY = contentY - 25

    local popupFiltersDesc = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    popupFiltersDesc:SetPoint("TOPLEFT", 30, contentY)
    popupFiltersDesc:SetWidth(420)
    popupFiltersDesc:SetJustifyH("LEFT")
    popupFiltersDesc:SetText(L["SETTINGS_POPUP_FILTERS_DESC"] or "Hide specific item types from zone popups")
    popupFiltersDesc:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)

    contentY = contentY - 30

    -- Initialize popup filters if not exist
    if HousingDB and not HousingDB.popupFilters then
        HousingDB.popupFilters = {
            showQuests = true,
            showAchievements = true,
            showDrops = true,
            showProfessions = true
        }
    end

    -- Quests checkbox
    local questsLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    questsLabel:SetPoint("TOPLEFT", 50, contentY)
    questsLabel:SetText(L["SETTINGS_SHOW_QUESTS"] or "Show Quest Items")
    questsLabel:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)

    local questsCheckbox = CreateFrame("CheckButton", "HousingPopupQuestsCheckbox", content, "UICheckButtonTemplate")
    questsCheckbox:SetPoint("LEFT", questsLabel, "RIGHT", 10, 0)
    questsCheckbox:SetSize(20, 20)
    questsCheckbox:SetChecked(HousingDB.popupFilters.showQuests ~= false)

    questsCheckbox:SetScript("OnClick", function(self)
        HousingDB.popupFilters.showQuests = self:GetChecked()
    end)

    questsCheckbox:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(L["SETTINGS_SHOW_QUESTS"] or "Show Quest Items", 1, 1, 1)
        GameTooltip:AddLine(L["SETTINGS_SHOW_QUESTS_TOOLTIP"] or "When enabled, items obtained through quests will appear in zone popups", 0.9, 0.9, 0.9, true)
        GameTooltip:Show()
    end)
    questsCheckbox:SetScript("OnLeave", function() GameTooltip:Hide() end)

    contentY = contentY - 25

    -- Achievements checkbox
    local achievementsLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    achievementsLabel:SetPoint("TOPLEFT", 50, contentY)
    achievementsLabel:SetText(L["SETTINGS_SHOW_ACHIEVEMENTS"] or "Show Achievement Items")
    achievementsLabel:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)

    local achievementsCheckbox = CreateFrame("CheckButton", "HousingPopupAchievementsCheckbox", content, "UICheckButtonTemplate")
    achievementsCheckbox:SetPoint("LEFT", achievementsLabel, "RIGHT", 10, 0)
    achievementsCheckbox:SetSize(20, 20)
    achievementsCheckbox:SetChecked(HousingDB.popupFilters.showAchievements ~= false)

    achievementsCheckbox:SetScript("OnClick", function(self)
        HousingDB.popupFilters.showAchievements = self:GetChecked()
    end)

    achievementsCheckbox:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(L["SETTINGS_SHOW_ACHIEVEMENTS"] or "Show Achievement Items", 1, 1, 1)
        GameTooltip:AddLine(L["SETTINGS_SHOW_ACHIEVEMENTS_TOOLTIP"] or "When enabled, items obtained through achievements will appear in zone popups", 0.9, 0.9, 0.9, true)
        GameTooltip:Show()
    end)
    achievementsCheckbox:SetScript("OnLeave", function() GameTooltip:Hide() end)

    contentY = contentY - 25

    -- Drops checkbox
    local dropsLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    dropsLabel:SetPoint("TOPLEFT", 50, contentY)
    dropsLabel:SetText(L["SETTINGS_SHOW_DROPS"] or "Show Drop Items")
    dropsLabel:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)

    local dropsCheckbox = CreateFrame("CheckButton", "HousingPopupDropsCheckbox", content, "UICheckButtonTemplate")
    dropsCheckbox:SetPoint("LEFT", dropsLabel, "RIGHT", 10, 0)
    dropsCheckbox:SetSize(20, 20)
    dropsCheckbox:SetChecked(HousingDB.popupFilters.showDrops ~= false)

    dropsCheckbox:SetScript("OnClick", function(self)
        HousingDB.popupFilters.showDrops = self:GetChecked()
    end)

    dropsCheckbox:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(L["SETTINGS_SHOW_DROPS"] or "Show Drop Items", 1, 1, 1)
        GameTooltip:AddLine(L["SETTINGS_SHOW_DROPS_TOOLTIP"] or "When enabled, items that drop from enemies will appear in zone popups", 0.9, 0.9, 0.9, true)
        GameTooltip:Show()
    end)
    dropsCheckbox:SetScript("OnLeave", function() GameTooltip:Hide() end)

    contentY = contentY - 25

    -- Professions checkbox
    local professionsLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    professionsLabel:SetPoint("TOPLEFT", 50, contentY)
    professionsLabel:SetText(L["SETTINGS_SHOW_PROFESSIONS"] or "Show Profession Items")
    professionsLabel:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)

    local professionsCheckbox = CreateFrame("CheckButton", "HousingPopupProfessionsCheckbox", content, "UICheckButtonTemplate")
    professionsCheckbox:SetPoint("LEFT", professionsLabel, "RIGHT", 10, 0)
    professionsCheckbox:SetSize(20, 20)
    professionsCheckbox:SetChecked(HousingDB.popupFilters.showProfessions ~= false)

    professionsCheckbox:SetScript("OnClick", function(self)
        HousingDB.popupFilters.showProfessions = self:GetChecked()
    end)

    professionsCheckbox:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(L["SETTINGS_SHOW_PROFESSIONS"] or "Show Profession Items", 1, 1, 1)
        GameTooltip:AddLine(L["SETTINGS_SHOW_PROFESSIONS_TOOLTIP"] or "When enabled, items crafted through professions will appear in zone popups", 0.9, 0.9, 0.9, true)
        GameTooltip:Show()
    end)
    professionsCheckbox:SetScript("OnLeave", function() GameTooltip:Hide() end)

    contentY = contentY - 40

    -- GENERAL SETTINGS SECTION
    CreateSectionHeader(L["SETTINGS_SECTION_GENERAL"] or "GENERAL", contentY)
    contentY = contentY - 35

    -- Hide Minimap Button Checkbox
    local minimapButtonLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    minimapButtonLabel:SetPoint("TOPLEFT", 30, contentY)
    minimapButtonLabel:SetText(L["SETTINGS_HIDE_MINIMAP_BUTTON"] or "Hide Minimap Button")
    minimapButtonLabel:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)

    local minimapButtonCheckbox = CreateFrame("CheckButton", "HousingMinimapButtonCheckbox", content, "UICheckButtonTemplate")
    minimapButtonCheckbox:SetPoint("LEFT", minimapButtonLabel, "RIGHT", 10, 0)
    minimapButtonCheckbox:SetSize(24, 24)
    local minimapHidden = false
    if HousingDB and HousingDB.minimapButton and HousingDB.minimapButton.hide ~= nil then
        minimapHidden = HousingDB.minimapButton.hide
    end
    minimapButtonCheckbox:SetChecked(minimapHidden)

    local minimapButtonDesc = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    minimapButtonDesc:SetPoint("TOPLEFT", minimapButtonLabel, "BOTTOMLEFT", 0, -8)
    minimapButtonDesc:SetWidth(420)
    minimapButtonDesc:SetJustifyH("LEFT")
    minimapButtonDesc:SetText(L["SETTINGS_HIDE_MINIMAP_BUTTON_DESC"] or "Hide the minimap button. Use /hv command to open the addon")
    minimapButtonDesc:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)

    minimapButtonCheckbox:SetScript("OnClick", function(self)
        local isChecked = self:GetChecked()
        if HousingDB and HousingDB.minimapButton then
            HousingDB.minimapButton.hide = isChecked
            if _G.HousingMinimap then
                if isChecked then
                    _G.HousingMinimap:HideButton()
                    print("|cFFFF0000Housing|r|cFF0066FFVendor|r: Minimap button hidden. Use /hv to open")
                else
                    _G.HousingMinimap:ShowButton()
                    print("|cFFFF0000Housing|r|cFF0066FFVendor|r: Minimap button shown")
                end
            end
        end
    end)

    contentY = contentY - 60

    -- Hide Visited Vendors Checkbox
    local hideVisitedLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    hideVisitedLabel:SetPoint("TOPLEFT", 30, contentY)
    hideVisitedLabel:SetText(L["SETTINGS_HIDE_VISITED_VENDORS"] or "Hide Visited Vendors")
    hideVisitedLabel:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)

    local hideVisitedCheckbox = CreateFrame("CheckButton", "HousingConfigHideVisitedCheckbox", content, "UICheckButtonTemplate")
    hideVisitedCheckbox:SetPoint("LEFT", hideVisitedLabel, "RIGHT", 10, 0)
    hideVisitedCheckbox:SetSize(24, 24)
    -- Get current value from filters
    local hideVisitedEnabled = false
    if HousingFilters and HousingFilters.GetFilters then
        local filters = HousingFilters:GetFilters()
        hideVisitedEnabled = filters.hideVisited or false
    end
    hideVisitedCheckbox:SetChecked(hideVisitedEnabled)

    local hideVisitedDesc = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    hideVisitedDesc:SetPoint("TOPLEFT", hideVisitedLabel, "BOTTOMLEFT", 0, -8)
    hideVisitedDesc:SetWidth(420)
    hideVisitedDesc:SetJustifyH("LEFT")
    hideVisitedDesc:SetText(L["SETTINGS_HIDE_VISITED_VENDORS_DESC"] or "Hide vendors you have already visited from the item list")
    hideVisitedDesc:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)

    hideVisitedCheckbox:SetScript("OnClick", function(self)
        local isChecked = self:GetChecked()
        if HousingFilters and HousingFilters.GetFilters then
            local filters = HousingFilters:GetFilters()
            filters.hideVisited = isChecked
            if HousingFilters.ApplyFilters then
                HousingFilters:ApplyFilters()
            end
        end
    end)

    contentY = contentY - 60

    -- Auto-Filter by Zone Toggle Checkbox
    local autoFilterLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    autoFilterLabel:SetPoint("TOPLEFT", 30, contentY)
    autoFilterLabel:SetText(L["SETTINGS_AUTO_FILTER_BY_ZONE"] or "Auto-Filter by Zone")
    autoFilterLabel:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    
    local autoFilterCheckbox = CreateFrame("CheckButton", "HousingAutoFilterCheckbox", content, "UICheckButtonTemplate")
    autoFilterCheckbox:SetPoint("LEFT", autoFilterLabel, "RIGHT", 10, 0)
    autoFilterCheckbox:SetSize(24, 24)
    -- Default to false if not set, but respect explicit true values
    local autoFilterEnabled = false
    if HousingDB and HousingDB.settings and HousingDB.settings.autoFilterByZone ~= nil then
        autoFilterEnabled = HousingDB.settings.autoFilterByZone
    end
    autoFilterCheckbox:SetChecked(autoFilterEnabled)
    
    local autoFilterDesc = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    autoFilterDesc:SetPoint("TOPLEFT", autoFilterLabel, "BOTTOMLEFT", 0, -8)
    autoFilterDesc:SetWidth(420)
    autoFilterDesc:SetJustifyH("LEFT")
    autoFilterDesc:SetText(L["SETTINGS_AUTO_FILTER_BY_ZONE_DESC"] or "Automatically filter items by your current zone when opening addon")
    autoFilterDesc:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)
    
    autoFilterCheckbox:SetScript("OnClick", function(self)
        local isChecked = self:GetChecked()
        if HousingDB and HousingDB.settings then
            HousingDB.settings.autoFilterByZone = isChecked
            if isChecked then
                print("|cFFFF0000Housing|r|cFF0066FFVendor|r: Auto-filter by zone enabled")
                -- Apply filter immediately if addon is open
                if HousingOutstandingItemsUI and HousingOutstandingItemsUI.ApplyInitialAutoFilter then
                    HousingOutstandingItemsUI:ApplyInitialAutoFilter()
                end
            else
                print("|cFFFF0000Housing|r|cFF0066FFVendor|r: Auto-filter by zone disabled")
                -- Clear zone filter
                if HousingFilters and HousingFilters.ShowAutoFilterIndicator then
                    HousingFilters:ShowAutoFilterIndicator(nil)
                end
            end
        end
    end)

    -- TomTom Integration Toggle
    local tomtomLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    tomtomLabel:SetPoint("TOPLEFT", autoFilterDesc, "BOTTOMLEFT", 0, -30)
    tomtomLabel:SetText(L["SETTINGS_TOMTOM_INTEGRATION"] or "TomTom Integration")
    tomtomLabel:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)

    local tomtomCheckbox = CreateFrame("CheckButton", "HousingTomTomIntegrationCheckbox", content, "UICheckButtonTemplate")
    tomtomCheckbox:SetPoint("LEFT", tomtomLabel, "RIGHT", 10, 0)
    tomtomCheckbox:SetSize(24, 24)

    local tomtomEnabled = true
    if HousingDB and HousingDB.settings and HousingDB.settings.useTomTomIntegration ~= nil then
        tomtomEnabled = HousingDB.settings.useTomTomIntegration
    end
    tomtomCheckbox:SetChecked(tomtomEnabled)

    local tomtomDesc = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    tomtomDesc:SetPoint("TOPLEFT", tomtomLabel, "BOTTOMLEFT", 0, -8)
    tomtomDesc:SetWidth(420)
    tomtomDesc:SetJustifyH("LEFT")
    tomtomDesc:SetText(L["SETTINGS_TOMTOM_INTEGRATION_DESC"] or "Also create a TomTom waypoint (Crazy Arrow) when setting a waypoint.")
    tomtomDesc:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)

    tomtomCheckbox:SetScript("OnClick", function(self)
        local isChecked = self:GetChecked()
        if HousingDB and HousingDB.settings then
            HousingDB.settings.useTomTomIntegration = isChecked
            if isChecked then
                print("|cFFFF0000Housing|r|cFF0066FFVendor|r: TomTom integration enabled")
            else
                print("|cFFFF0000Housing|r|cFF0066FFVendor|r: TomTom integration disabled")
            end
        end
    end)

    -- Vendor Marker Toggle
    local vendorMarkerLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    vendorMarkerLabel:SetPoint("TOPLEFT", tomtomDesc, "BOTTOMLEFT", 0, -30)
    vendorMarkerLabel:SetText(L["SETTINGS_VENDOR_MARKER"] or "Vendor Marker")
    vendorMarkerLabel:SetTextColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)

    local vendorMarkerCheckbox = CreateFrame("CheckButton", "HousingVendorMarkerCheckbox", content, "ChatConfigCheckButtonTemplate")
    vendorMarkerCheckbox:SetPoint("LEFT", vendorMarkerLabel, "RIGHT", 8, 0)
    vendorMarkerCheckbox:SetSize(24, 24)

    local vendorMarkerEnabled = false
    if HousingDB and HousingDB.settings and HousingDB.settings.enableVendorMarker ~= nil then
        vendorMarkerEnabled = HousingDB.settings.enableVendorMarker
    end
    vendorMarkerCheckbox:SetChecked(vendorMarkerEnabled)

    local vendorMarkerDesc = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    vendorMarkerDesc:SetPoint("TOPLEFT", vendorMarkerLabel, "BOTTOMLEFT", 0, -8)
    vendorMarkerDesc:SetWidth(420)
    vendorMarkerDesc:SetJustifyH("LEFT")
    vendorMarkerDesc:SetText(L["SETTINGS_VENDOR_MARKER_DESC"] or "Highlight vendor NPCs with colored nameplate borders (use /hv mark)")
    vendorMarkerDesc:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)

    vendorMarkerCheckbox:SetScript("OnClick", function(self)
        local isChecked = self:GetChecked()
        if HousingDB and HousingDB.settings then
            HousingDB.settings.enableVendorMarker = isChecked
            if isChecked then
                print("|cFFFF0000Housing|r|cFF0066FFVendor|r: Vendor marker enabled")
            else
                print("|cFFFF0000Housing|r|cFF0066FFVendor|r: Vendor marker disabled")
                if HousingVendorMarker and HousingVendorMarker.StopNameplateTracking then
                    HousingVendorMarker:StopNameplateTracking()
                end
            end
        end
    end)

    local distanceUnitLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    distanceUnitLabel:SetPoint("TOPLEFT", vendorMarkerDesc, "BOTTOMLEFT", 0, -10)
    distanceUnitLabel:SetText(L["SETTINGS_VENDOR_MARKER_DISTANCE_UNIT"] or "Vendor marker distance unit")
    distanceUnitLabel:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)

    local distanceUnitCheckbox = CreateFrame("CheckButton", "HousingVendorMarkerUnitCheckbox", content, "UICheckButtonTemplate")
    distanceUnitCheckbox:SetPoint("LEFT", distanceUnitLabel, "RIGHT", 10, 0)
    distanceUnitCheckbox:SetSize(24, 24)

    local useMeters = false
    if HousingDB and HousingDB.settings and HousingDB.settings.vendorMarkerUseMeters ~= nil then
        useMeters = HousingDB.settings.vendorMarkerUseMeters
    end
    distanceUnitCheckbox:SetChecked(useMeters)

    local distanceUnitDesc = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    distanceUnitDesc:SetPoint("TOPLEFT", distanceUnitLabel, "BOTTOMLEFT", 0, -8)
    distanceUnitDesc:SetWidth(420)
    distanceUnitDesc:SetJustifyH("LEFT")
    distanceUnitDesc:SetText(L["SETTINGS_VENDOR_MARKER_DISTANCE_UNIT_DESC"] or "Use meters instead of yards in the marker popup")
    distanceUnitDesc:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)

    distanceUnitCheckbox:SetScript("OnClick", function(self)
        local isChecked = self:GetChecked()
        if HousingDB and HousingDB.settings then
            HousingDB.settings.vendorMarkerUseMeters = isChecked
        end
        if HousingVendorMarker and HousingVendorMarker.UpdateDistanceDisplay then
            HousingVendorMarker:UpdateDistanceDisplay()
        end
    end)

    local function UpdateScrollLayout()
        local availableWidth = scrollFrame:GetWidth() - 20
        if availableWidth < 1 then availableWidth = 1 end
        content:SetWidth(availableWidth)

        local top = content:GetTop()
        local bottom = distanceUnitDesc:GetBottom()
        if top and bottom then
            local neededHeight = (top - bottom) + 24
            if neededHeight < 1 then neededHeight = 1 end
            content:SetHeight(neededHeight)
        end
    end

    frame:HookScript("OnShow", function()
        -- Refresh slider values from saved settings
        if scaleSlider and HousingDB and HousingDB.uiScale then
            local savedValue = math.max(0.5, math.min(1.5, HousingDB.uiScale))
            scaleSlider:SetValue(savedValue)
            currentSettings.uiScale = savedValue
            scaleValue:SetText(string.format("%.2f", savedValue))
        end
        
        if _G.C_Timer and _G.C_Timer.After then
            _G.C_Timer.After(0, UpdateScrollLayout)
        else
            UpdateScrollLayout()
        end
    end)

    frame:HookScript("OnSizeChanged", function()
        if _G.C_Timer and _G.C_Timer.After then
            _G.C_Timer.After(0, UpdateScrollLayout)
        else
            UpdateScrollLayout()
        end
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

-- Apply current theme to config frame
function ConfigUI:ApplyThemeToConfigFrame()
    if not configFrame then return end
    
    local colors = HousingTheme.Colors
    
    -- Update frame colors
    configFrame:SetBackdropColor(colors.bgPrimary[1], colors.bgPrimary[2], colors.bgPrimary[3], colors.bgPrimary[4])
    configFrame:SetBackdropBorderColor(colors.borderPrimary[1], colors.borderPrimary[2], colors.borderPrimary[3], colors.borderPrimary[4])
end

-- Register with Blizzard Settings (ESC -> Interface -> AddOns)
function ConfigUI:RegisterBlizzardSettings()
    if not Settings or not Settings.RegisterCanvasLayoutCategory then
        -- Pre-Dragonflight or Settings API unavailable
        return
    end
    
    if blizzardSettingsCategory then
        -- Already registered
        return
    end
    
    -- Create the config frame (without showing it as a standalone dialog)
    if not configFrame then
        self:CreateConfigFrame()
    end
    
    -- Make the frame suitable for embedding in Blizzard Settings
    configFrame:SetParent(nil)
    configFrame:Hide()
    configFrame:ClearAllPoints()
    configFrame:SetPoint("TOPLEFT")
    configFrame:SetPoint("BOTTOMRIGHT")
    configFrame:SetMovable(false)
    configFrame:EnableMouse(false)
    configFrame:SetScript("OnDragStart", nil)
    configFrame:SetScript("OnDragStop", nil)
    
    -- Register with Blizzard Settings panel
    local category, layout = Settings.RegisterCanvasLayoutCategory(configFrame, "Housing Vendor")
    Settings.RegisterAddOnCategory(category)
    blizzardSettingsCategory = category
    
    -- Store reference so slash command can open Blizzard settings to this panel
    ConfigUI.blizzardCategory = category
end

-- Open Blizzard Settings to this addon's panel
function ConfigUI:OpenBlizzardSettings()
    if blizzardSettingsCategory and Settings and Settings.OpenToCategory then
        Settings.OpenToCategory(blizzardSettingsCategory:GetID())
    elseif SettingsPanel and SettingsPanel:IsShown() then
        -- Already open; try to navigate
        if blizzardSettingsCategory and Settings and Settings.OpenToCategory then
            Settings.OpenToCategory(blizzardSettingsCategory:GetID())
        end
    else
        -- Fallback: show standalone config frame
        self:Show()
    end
end

-- Show settings embedded in main UI (replaces item list area)
function ConfigUI:ShowEmbedded()
    local mainFrame = _G["HousingFrameNew"]
    if not mainFrame then return end
    
    -- Hide other views (with safety checks)
    if HousingAchievementsUI and HousingAchievementsUI.Hide then
        pcall(function() HousingAchievementsUI:Hide() end)
    end
    if HousingReputationUI and HousingReputationUI.Hide then
        pcall(function() HousingReputationUI:Hide() end)
    end
    if HousingStatisticsUI and HousingStatisticsUI.Hide then
        pcall(function() HousingStatisticsUI:Hide() end)
    end
    if HousingAuctionHouseUI and HousingAuctionHouseUI.Hide then
        pcall(function() HousingAuctionHouseUI:Hide() end)
    end
    
    -- Hide item list scroll frame directly
    if _G["HousingItemListScrollFrame"] then
        _G["HousingItemListScrollFrame"]:Hide()
    end
    
    -- Hide filter frame
    if _G["HousingFilterFrame"] then
        _G["HousingFilterFrame"]:Hide()
    end
    
    -- Keep preview panel visible (don't hide it)
    -- if _G["HousingPreviewFrame"] then
    --     _G["HousingPreviewFrame"]:Hide()
    -- end
    
    -- Show back button (reposition to top-left of main frame)
    local backBtn = _G["HousingBackButton"]
    if backBtn then
        -- Reparent to main frame so it stays visible when filter frame is hidden
        backBtn:SetParent(mainFrame)
        backBtn:ClearAllPoints()
        backBtn:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", 20, -70)
        backBtn:Show()
        -- Update back button click to hide settings
        backBtn:SetScript("OnClick", function()
            if HousingConfigUI and HousingConfigUI.HideEmbedded then
                HousingConfigUI:HideEmbedded()
            end
        end)
    end
    
    -- Create embedded settings container if it doesn't exist
    if not self._settingsContainer then
        local container = CreateFrame("ScrollFrame", "HousingSettingsContainer", mainFrame, "UIPanelScrollFrameTemplate")
        container:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", 20, -70)
        container:SetPoint("BOTTOMRIGHT", mainFrame, "BOTTOMRIGHT", -30, 52)
        
        -- Create settings content (reuse config frame content)
        if not configFrame then
            self:CreateConfigFrame()
        end
        
        -- Create a new content frame for embedded view (don't reparent the standalone one)
        local content = CreateFrame("Frame", nil, container)
        content:SetSize(750, 1500)  -- Wide enough for settings, tall enough for scroll
        container:SetScrollChild(content)
        
        -- Copy all settings from the standalone config to embedded container
        local standaloneScroll = _G["HousingVendorConfigScrollFrame"]
        if standaloneScroll and standaloneScroll:GetScrollChild() then
            local standaloneContent = standaloneScroll:GetScrollChild()
            -- Clone all children from standalone to embedded
            local children = { standaloneContent:GetChildren() }
            for _, child in ipairs(children) do
                if child:GetObjectType() ~= "ScrollFrame" then
                    -- Recreate controls by copying their properties
                    -- This is a simplified approach; the settings will still work from standalone frame
                end
            end
            -- Alternative: Just make the standalone content show in both places
            -- by temporarily reparenting it when embedded
            standaloneContent:SetParent(container)
            container:SetScrollChild(standaloneContent)
        end
        
        container:EnableMouseWheel(true)
        container:SetScript("OnMouseWheel", function(self, delta)
            local step = 30
            local current = self:GetVerticalScroll()
            local max = self:GetVerticalScrollRange()
            local nextScroll = current - (delta * step)
            if nextScroll < 0 then nextScroll = 0 end
            if nextScroll > max then nextScroll = max end
            self:SetVerticalScroll(nextScroll)
        end)
        
        self._settingsContainer = container
    end
    
    self._settingsContainer:Show()
end

-- Hide embedded settings and return to main UI
function ConfigUI:HideEmbedded()
    if self._settingsContainer then
        self._settingsContainer:Hide()
    end
    
    -- Hide back button and restore its original position/parent
    local backBtn = _G["HousingBackButton"]
    if backBtn then
        backBtn:Hide()
        -- Restore to filter frame parent and original position
        local filterFrame = _G["HousingFilterFrame"]
        if filterFrame then
            backBtn:SetParent(filterFrame)
            backBtn:ClearAllPoints()
            backBtn:SetPoint("TOPRIGHT", -130, -18)
        end
        -- Restore original back button behavior (refresh display mode)
        backBtn:SetScript("OnClick", function()
            if HousingUINew and HousingDB and HousingDB.settings and HousingDB.settings.displayMode then
                HousingUINew:RefreshDisplay(HousingDB.settings.displayMode)
                backBtn:Hide()
            end
        end)
    end
    
    -- Show item list scroll frame
    if _G["HousingItemListScrollFrame"] then
        _G["HousingItemListScrollFrame"]:Show()
    end
    
    -- Show filter frame
    if _G["HousingFilterFrame"] then
        _G["HousingFilterFrame"]:Show()
    end
    
    -- Preview panel stays visible (already visible, no need to show again)
end

-- Make globally accessible
_G["HousingConfigUI"] = ConfigUI

return ConfigUI
