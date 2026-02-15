-- Defaults
local defaults = {
    yOffset = -40,
    color = {0, 1, 0, 0.9},  -- green
    lineLength = 10,
    lineThickness = 1,
    hideOutOfCombat = true,
}

-- S1 Season preset zones (dungeons + raids)
local s1Zones = {
    -- M+ Dungeons
    [658]   = "Pit of Saron",
    [1209]  = "Skyreach",
    [1753]  = "Seat of the Triumvirate",
    [2526]  = "Algeth'ar Academy",
    [585]   = "Magisters' Terrace",
    [16395] = "Maisara Caverns",
    [16573] = "Nexus-Point Xenas",
    [15808] = "Windrunner Spire",

    -- Raids
    [16340] = "The Voidspire",
    [16531] = "The Dreamrift",
    [16342] = "Isle of Quel'Danas",
}

-- Track current zone for change detection
local currentZoneKey = nil

-- Main frame
local frame = CreateFrame("Frame", "WheresMyFeetFrame", UIParent)
frame:SetSize(48, 48)

local hLine = frame:CreateTexture(nil, "OVERLAY")
local vLine = frame:CreateTexture(nil, "OVERLAY")

-- Forward declarations for UI elements that need updating
local ySlider, sizeSlider, combatCheck, yValue, sizeValue
local zonesContent, SetDropdownToCurrentZone, RefreshOverrideList
local enabledCheck

-- Get current zone key (instanceMapID for dungeons/raids, nil for open world)
local function GetCurrentZoneKey()
    local _, instanceType, _, _, _, _, _, instanceMapID = GetInstanceInfo()
    if instanceType == "party" or instanceType == "raid" then
        return instanceMapID
    end
    return nil  -- open world = use defaults
end

-- Get current zone name
local function GetCurrentZoneName()
    local name, instanceType = GetInstanceInfo()
    if instanceType == "party" or instanceType == "raid" then
        return name
    end
    return nil
end

-- Get effective settings (defaults merged with zone override if applicable)
local function GetEffectiveSettings()
    local db = WheresMyFeetDB
    if not db then return defaults end

    local zoneKey = GetCurrentZoneKey()

    -- Check if zone overrides are enabled and we're in a zone with an override
    if db.enableZoneOverrides and zoneKey and db.zoneOverrides and db.zoneOverrides[zoneKey] then
        local override = db.zoneOverrides[zoneKey]
        if override.enabled then
            -- Merge defaults with override
            local effective = {}
            for k, v in pairs(db.defaults) do
                effective[k] = v
            end
            -- Apply overrides
            for k, v in pairs(override) do
                if k ~= "name" and k ~= "enabled" then
                    effective[k] = v
                end
            end
            return effective
        end
    end

    return db.defaults
end

local function UpdateCrosshair()
    local settings = GetEffectiveSettings()

    frame:ClearAllPoints()
    frame:SetPoint("CENTER", UIParent, "CENTER", 0, settings.yOffset)

    hLine:SetColorTexture(unpack(settings.color))
    hLine:SetSize(settings.lineLength * 2, settings.lineThickness)
    hLine:SetPoint("CENTER", frame, "CENTER", 0, 0)

    vLine:SetColorTexture(unpack(settings.color))
    vLine:SetSize(settings.lineThickness, settings.lineLength * 2)
    vLine:SetPoint("CENTER", frame, "CENTER", 0, 0)
end

local function UpdateVisibility()
    local settings = GetEffectiveSettings()
    local optionsOpen = WheresMyFeetOptions and WheresMyFeetOptions:IsShown()

    -- Check if disabled for this character
    if WheresMyFeetCharDB and not WheresMyFeetCharDB.enabled then
        frame:Hide()
        return
    end

    if optionsOpen then
        frame:Show()
    elseif settings.hideOutOfCombat and not UnitAffectingCombat("player") then
        frame:Hide()
    else
        frame:Show()
    end
end

-- Combat events
local combatFrame = CreateFrame("Frame")
combatFrame:RegisterEvent("PLAYER_REGEN_DISABLED")  -- entering combat
combatFrame:RegisterEvent("PLAYER_REGEN_ENABLED")   -- leaving combat
combatFrame:SetScript("OnEvent", function()
    UpdateVisibility()
end)

-- Zone change handler
local function OnZoneChanged()
    local db = WheresMyFeetDB
    if not db then return end

    local newZoneKey = GetCurrentZoneKey()
    local zoneName = GetCurrentZoneName()

    -- Auto-discover zone
    if newZoneKey and zoneName then
        db.knownZones = db.knownZones or {}
        if not db.knownZones[newZoneKey] then
            db.knownZones[newZoneKey] = zoneName
        end
    end

    -- Check if zone actually changed
    if newZoneKey == currentZoneKey then return end
    currentZoneKey = newZoneKey

    -- Update crosshair with effective settings
    UpdateCrosshair()
    UpdateVisibility()

    -- Print notification
    if db.enableZoneOverrides then
        if newZoneKey and db.zoneOverrides and db.zoneOverrides[newZoneKey] then
            local override = db.zoneOverrides[newZoneKey]
            if override.enabled then
                print("|cFF00FF00WMF:|r Zone override active for " .. (override.name or zoneName or "Unknown"))
            else
                print("|cFF00FF00WMF:|r Using default settings")
            end
        elseif not newZoneKey then
            print("|cFF00FF00WMF:|r Using default settings")
        end
    end

    -- Refresh zone tab UI if visible
    if zonesContent and zonesContent:IsShown() then
        if SetDropdownToCurrentZone then
            SetDropdownToCurrentZone()
        end
        if RefreshOverrideList then
            RefreshOverrideList()
        end
    end
end

-- Zone event frame
local zoneFrame = CreateFrame("Frame")
zoneFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
zoneFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
zoneFrame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_ENTERING_WORLD" then
        -- Delay slightly for login/reload to ensure instance info is ready
        C_Timer.After(0.5, OnZoneChanged)
    else
        OnZoneChanged()
    end
end)

-- Options panel
local options = CreateFrame("Frame", "WheresMyFeetOptions", UIParent, "BackdropTemplate")
options:SetSize(260, 400)
options:SetPoint("CENTER")
options:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 32,
    insets = {left = 8, right = 8, top = 8, bottom = 8}
})
options:SetMovable(true)
options:EnableMouse(true)
options:RegisterForDrag("LeftButton")
options:SetScript("OnDragStart", options.StartMoving)
options:SetScript("OnDragStop", options.StopMovingOrSizing)
options:SetScript("OnShow", function() UpdateVisibility() end)
options:SetScript("OnHide", function() UpdateVisibility() end)
options:Hide()

local title = options:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
title:SetPoint("TOP", 0, -15)
title:SetText("Where's My Feet")

-- Close button
local closeBtn = CreateFrame("Button", nil, options, "UIPanelCloseButton")
closeBtn:SetPoint("TOPRIGHT", -5, -5)

-- Enable checkbox (per-character)
enabledCheck = CreateFrame("CheckButton", "WMFEnabledCheck", options, "UICheckButtonTemplate")
enabledCheck:SetPoint("TOPLEFT", 15, -35)
enabledCheck.text = enabledCheck:CreateFontString(nil, "OVERLAY", "GameFontNormal")
enabledCheck.text:SetPoint("LEFT", enabledCheck, "RIGHT", 5, 0)
enabledCheck.text:SetText("Enabled for this character")
enabledCheck:SetScript("OnClick", function(self)
    if WheresMyFeetCharDB then
        WheresMyFeetCharDB.enabled = self:GetChecked()
        UpdateVisibility()
    end
end)

-- Tab system
local tabFrame = CreateFrame("Frame", nil, options)
tabFrame:SetPoint("TOPLEFT", 15, -60)
tabFrame:SetSize(230, 25)

local defaultsTab, zonesTab
local defaultsContent

-- Current tab state
local activeTab = "defaults"

-- Create tab buttons
local function CreateTabButton(name, label, anchorTo, offsetX)
    local tab = CreateFrame("Button", nil, tabFrame)
    tab:SetSize(105, 22)
    if anchorTo then
        tab:SetPoint("LEFT", anchorTo, "RIGHT", offsetX or 5, 0)
    else
        tab:SetPoint("LEFT", 0, 0)
    end

    tab.text = tab:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    tab.text:SetPoint("CENTER")
    tab.text:SetText(label)

    tab.bg = tab:CreateTexture(nil, "BACKGROUND")
    tab.bg:SetAllPoints()
    tab.bg:SetColorTexture(0.2, 0.2, 0.2, 0.8)

    tab:SetScript("OnEnter", function(self)
        if activeTab ~= name then
            self.bg:SetColorTexture(0.3, 0.3, 0.3, 0.8)
        end
    end)
    tab:SetScript("OnLeave", function(self)
        if activeTab ~= name then
            self.bg:SetColorTexture(0.2, 0.2, 0.2, 0.8)
        end
    end)

    return tab
end

defaultsTab = CreateTabButton("defaults", "Defaults", nil)
zonesTab = CreateTabButton("zones", "Zone Overrides", defaultsTab, 10)

-- Content containers
defaultsContent = CreateFrame("Frame", nil, options)
defaultsContent:SetPoint("TOPLEFT", 15, -90)
defaultsContent:SetSize(230, 295)

zonesContent = CreateFrame("Frame", nil, options)
zonesContent:SetPoint("TOPLEFT", 15, -90)
zonesContent:SetSize(230, 295)
zonesContent:Hide()

-- Tab switching logic
local function SetActiveTab(tabName)
    activeTab = tabName

    if tabName == "defaults" then
        defaultsTab.bg:SetColorTexture(0.4, 0.4, 0.6, 0.9)
        zonesTab.bg:SetColorTexture(0.2, 0.2, 0.2, 0.8)
        defaultsContent:Show()
        zonesContent:Hide()
    else
        zonesTab.bg:SetColorTexture(0.4, 0.4, 0.6, 0.9)
        defaultsTab.bg:SetColorTexture(0.2, 0.2, 0.2, 0.8)
        zonesContent:Show()
        defaultsContent:Hide()
    end
end

defaultsTab:SetScript("OnClick", function() SetActiveTab("defaults") end)
zonesTab:SetScript("OnClick", function() SetActiveTab("zones") end)

-- ============================================================
-- DEFAULTS TAB CONTENT
-- ============================================================

-- Y Offset slider
ySlider = CreateFrame("Slider", "WMFYSlider", defaultsContent, "OptionsSliderTemplate")
ySlider:SetPoint("TOP", 0, -15)
ySlider:SetMinMaxValues(-300, 100)
ySlider:SetValueStep(5)
ySlider:SetObeyStepOnDrag(true)
ySlider:SetWidth(180)
WMFYSliderText:SetText("Y Offset")
WMFYSliderLow:SetText("-300")
WMFYSliderHigh:SetText("100")

yValue = defaultsContent:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
yValue:SetPoint("TOP", ySlider, "BOTTOM", 0, -2)

ySlider:SetScript("OnValueChanged", function(self, value)
    if WheresMyFeetDB and WheresMyFeetDB.defaults then
        WheresMyFeetDB.defaults.yOffset = value
        yValue:SetText(math.floor(value))
        UpdateCrosshair()
    end
end)

-- Size slider
sizeSlider = CreateFrame("Slider", "WMFSizeSlider", defaultsContent, "OptionsSliderTemplate")
sizeSlider:SetPoint("TOP", 0, -75)
sizeSlider:SetMinMaxValues(5, 50)
sizeSlider:SetValueStep(1)
sizeSlider:SetObeyStepOnDrag(true)
sizeSlider:SetWidth(180)
WMFSizeSliderText:SetText("Size")
WMFSizeSliderLow:SetText("5")
WMFSizeSliderHigh:SetText("50")

sizeValue = defaultsContent:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
sizeValue:SetPoint("TOP", sizeSlider, "BOTTOM", 0, -2)

sizeSlider:SetScript("OnValueChanged", function(self, value)
    if WheresMyFeetDB and WheresMyFeetDB.defaults then
        WheresMyFeetDB.defaults.lineLength = value
        sizeValue:SetText(math.floor(value))
        UpdateCrosshair()
    end
end)

-- Color label and swatch
local colorLabel = defaultsContent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
colorLabel:SetPoint("TOP", 0, -130)
colorLabel:SetText("Color")

-- Color preview swatch for defaults
local defaultSwatchBg = defaultsContent:CreateTexture(nil, "ARTWORK")
defaultSwatchBg:SetSize(20, 20)
defaultSwatchBg:SetPoint("TOP", 50, -128)
defaultSwatchBg:SetColorTexture(0, 1, 0, 1)

local function UpdateDefaultSwatch()
    if WheresMyFeetDB and WheresMyFeetDB.defaults and WheresMyFeetDB.defaults.color then
        defaultSwatchBg:SetColorTexture(unpack(WheresMyFeetDB.defaults.color))
    end
end

local colors = {
    {name = "Green", color = {0, 1, 0, 0.9}},
    {name = "Red", color = {1, 0, 0, 0.9}},
    {name = "White", color = {1, 1, 1, 0.9}},
    {name = "Yellow", color = {1, 1, 0, 0.9}},
    {name = "Cyan", color = {0, 1, 1, 0.9}},
}

local colorBtns = {}
for i, c in ipairs(colors) do
    local btn = CreateFrame("Button", nil, defaultsContent, "UIPanelButtonTemplate")
    btn:SetSize(40, 22)
    btn:SetText(c.name:sub(1, 1))
    btn:SetPoint("TOP", colorLabel, "BOTTOM", (i - 3) * 42, -15)
    btn:SetScript("OnClick", function()
        if WheresMyFeetDB and WheresMyFeetDB.defaults then
            WheresMyFeetDB.defaults.color = {unpack(c.color)}
            UpdateDefaultSwatch()
            UpdateCrosshair()
        end
    end)
    colorBtns[i] = btn
end

-- Custom color picker button
local customBtn = CreateFrame("Button", nil, defaultsContent, "UIPanelButtonTemplate")
customBtn:SetSize(70, 22)
customBtn:SetText("Custom")
customBtn:SetPoint("TOP", colorLabel, "BOTTOM", 0, -45)
customBtn:SetScript("OnClick", function()
    if not WheresMyFeetDB or not WheresMyFeetDB.defaults then return end
    local r, g, b, a = unpack(WheresMyFeetDB.defaults.color)

    local function OnColorChanged()
        local newR, newG, newB = ColorPickerFrame:GetColorRGB()
        local newA = ColorPickerFrame:GetColorAlpha()
        WheresMyFeetDB.defaults.color = {newR, newG, newB, newA}
        UpdateDefaultSwatch()
        UpdateCrosshair()
    end

    local function OnCancel()
        WheresMyFeetDB.defaults.color = {r, g, b, a}
        UpdateDefaultSwatch()
        UpdateCrosshair()
    end

    ColorPickerFrame:SetupColorPickerAndShow({
        r = r, g = g, b = b, opacity = a,
        hasOpacity = true,
        swatchFunc = OnColorChanged,
        opacityFunc = OnColorChanged,
        cancelFunc = OnCancel,
    })
end)

-- Hide out of combat checkbox
combatCheck = CreateFrame("CheckButton", "WMFCombatCheck", defaultsContent, "UICheckButtonTemplate")
combatCheck:SetPoint("TOPLEFT", defaultsContent, "TOPLEFT", 10, -210)
combatCheck.text = combatCheck:CreateFontString(nil, "OVERLAY", "GameFontNormal")
combatCheck.text:SetPoint("LEFT", combatCheck, "RIGHT", 5, 0)
combatCheck.text:SetText("Hide out of combat")
combatCheck:SetScript("OnClick", function(self)
    if WheresMyFeetDB and WheresMyFeetDB.defaults then
        WheresMyFeetDB.defaults.hideOutOfCombat = self:GetChecked()
        UpdateVisibility()
    end
end)

-- ============================================================
-- ZONE OVERRIDES TAB CONTENT
-- ============================================================

-- Master toggle
local zoneToggle = CreateFrame("CheckButton", "WMFZoneToggle", zonesContent, "UICheckButtonTemplate")
zoneToggle:SetPoint("TOPLEFT", 10, 0)
zoneToggle.text = zoneToggle:CreateFontString(nil, "OVERLAY", "GameFontNormal")
zoneToggle.text:SetPoint("LEFT", zoneToggle, "RIGHT", 5, 0)
zoneToggle.text:SetText("Enable zone overrides")
zoneToggle:SetScript("OnClick", function(self)
    if WheresMyFeetDB then
        WheresMyFeetDB.enableZoneOverrides = self:GetChecked()
        OnZoneChanged()
    end
end)

-- Zone picker dropdown
local pickerLabel = zonesContent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
pickerLabel:SetPoint("TOPLEFT", 15, -35)
pickerLabel:SetText("Add Override For:")

local zonePicker = CreateFrame("Frame", "WMFZonePicker", zonesContent, "UIDropDownMenuTemplate")
zonePicker:SetPoint("TOPLEFT", pickerLabel, "BOTTOMLEFT", -15, -2)
UIDropDownMenu_SetWidth(zonePicker, 140)

local addOverrideBtn = CreateFrame("Button", nil, zonesContent, "UIPanelButtonTemplate")
addOverrideBtn:SetSize(50, 22)
addOverrideBtn:SetText("Add")
addOverrideBtn:SetPoint("LEFT", zonePicker, "RIGHT", -10, 2)

-- Override list scroll frame
local listLabel = zonesContent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
listLabel:SetPoint("TOPLEFT", 15, -95)
listLabel:SetText("Configured Overrides:")

local scrollFrame = CreateFrame("ScrollFrame", "WMFOverrideScroll", zonesContent, "UIPanelScrollFrameTemplate")
scrollFrame:SetPoint("TOPLEFT", listLabel, "BOTTOMLEFT", 0, -5)
scrollFrame:SetSize(200, 160)

local scrollChild = CreateFrame("Frame", nil, scrollFrame)
scrollChild:SetSize(200, 1)
scrollFrame:SetScrollChild(scrollChild)

local overrideButtons = {}

-- Currently editing override
local editingZoneKey = nil

-- Override editor (shown when editing)
local editorFrame = CreateFrame("Frame", "WMFOverrideEditor", UIParent, "BackdropTemplate")
editorFrame:SetSize(260, 280)
editorFrame:SetPoint("CENTER")
editorFrame:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 32,
    insets = {left = 8, right = 8, top = 8, bottom = 8}
})
editorFrame:SetMovable(true)
editorFrame:EnableMouse(true)
editorFrame:RegisterForDrag("LeftButton")
editorFrame:SetScript("OnDragStart", editorFrame.StartMoving)
editorFrame:SetScript("OnDragStop", editorFrame.StopMovingOrSizing)
editorFrame:SetFrameStrata("DIALOG")
editorFrame:Hide()

local editorTitle = editorFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
editorTitle:SetPoint("TOP", 0, -15)
editorTitle:SetText("Edit Override")

local editorCloseBtn = CreateFrame("Button", nil, editorFrame, "UIPanelCloseButton")
editorCloseBtn:SetPoint("TOPRIGHT", -5, -5)

-- Editor Y Offset slider
local editorYSlider = CreateFrame("Slider", "WMFEditorYSlider", editorFrame, "OptionsSliderTemplate")
editorYSlider:SetPoint("TOP", 0, -55)
editorYSlider:SetMinMaxValues(-300, 100)
editorYSlider:SetValueStep(5)
editorYSlider:SetObeyStepOnDrag(true)
editorYSlider:SetWidth(180)
WMFEditorYSliderText:SetText("Y Offset")
WMFEditorYSliderLow:SetText("-300")
WMFEditorYSliderHigh:SetText("100")

local editorYValue = editorFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
editorYValue:SetPoint("TOP", editorYSlider, "BOTTOM", 0, -2)

-- Editor Size slider
local editorSizeSlider = CreateFrame("Slider", "WMFEditorSizeSlider", editorFrame, "OptionsSliderTemplate")
editorSizeSlider:SetPoint("TOP", 0, -115)
editorSizeSlider:SetMinMaxValues(5, 50)
editorSizeSlider:SetValueStep(1)
editorSizeSlider:SetObeyStepOnDrag(true)
editorSizeSlider:SetWidth(180)
WMFEditorSizeSliderText:SetText("Size")
WMFEditorSizeSliderLow:SetText("5")
WMFEditorSizeSliderHigh:SetText("50")

local editorSizeValue = editorFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
editorSizeValue:SetPoint("TOP", editorSizeSlider, "BOTTOM", 0, -2)

-- Editor Color label and swatch
local editorColorLabel = editorFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
editorColorLabel:SetPoint("TOP", 0, -165)
editorColorLabel:SetText("Color")

-- Color preview swatch (positioned to the right of center)
local swatchBg = editorFrame:CreateTexture(nil, "ARTWORK")
swatchBg:SetSize(20, 20)
swatchBg:SetPoint("TOP", 50, -163)
swatchBg:SetColorTexture(0, 1, 0, 1)

-- Editor color buttons row
local editorColorBtns = {}
for i, c in ipairs(colors) do
    local btn = CreateFrame("Button", nil, editorFrame, "UIPanelButtonTemplate")
    btn:SetSize(40, 22)
    btn:SetText(c.name:sub(1, 1))
    btn:SetPoint("TOP", editorColorLabel, "BOTTOM", (i - 3) * 42, -5)
    btn.colorData = c.color
    editorColorBtns[i] = btn
end

-- Editor custom color button
local editorCustomBtn = CreateFrame("Button", nil, editorFrame, "UIPanelButtonTemplate")
editorCustomBtn:SetSize(70, 22)
editorCustomBtn:SetText("Custom")
editorCustomBtn:SetPoint("TOP", editorColorLabel, "BOTTOM", 0, -35)

-- Editor hide out of combat checkbox
local editorCombatCheck = CreateFrame("CheckButton", nil, editorFrame, "UICheckButtonTemplate")
editorCombatCheck:SetPoint("TOP", editorCustomBtn, "BOTTOM", -60, -10)
editorCombatCheck.text = editorCombatCheck:CreateFontString(nil, "OVERLAY", "GameFontNormal")
editorCombatCheck.text:SetPoint("LEFT", editorCombatCheck, "RIGHT", 5, 0)
editorCombatCheck.text:SetText("Hide out of combat")

-- Done button (changes auto-save)
local editorDoneBtn = CreateFrame("Button", nil, editorFrame, "UIPanelButtonTemplate")
editorDoneBtn:SetSize(80, 25)
editorDoneBtn:SetText("Done")
editorDoneBtn:SetPoint("TOP", editorCombatCheck, "BOTTOM", 60, -10)

-- Temporary editor values
local editorValues = {}

-- Update swatch color
local function UpdateEditorSwatch()
    if editorValues.color then
        swatchBg:SetColorTexture(unpack(editorValues.color))
    end
end

-- Auto-save current override settings
local function SaveCurrentOverride()
    if not editingZoneKey then return end
    local db = WheresMyFeetDB
    if not db then return end

    db.zoneOverrides = db.zoneOverrides or {}
    local override = db.zoneOverrides[editingZoneKey] or {}

    -- Get zone name
    local zoneName = s1Zones[editingZoneKey] or (db.knownZones and db.knownZones[editingZoneKey]) or "Zone " .. editingZoneKey
    override.name = zoneName
    if override.enabled == nil then
        override.enabled = true
    end

    -- Save all values
    override.yOffset = editorValues.yOffset
    override.lineLength = editorValues.lineLength
    override.color = editorValues.color and {unpack(editorValues.color)} or nil
    override.hideOutOfCombat = editorCombatCheck:GetChecked()

    db.zoneOverrides[editingZoneKey] = override
end

-- Editor slider callbacks
editorYSlider:SetScript("OnValueChanged", function(self, value)
    editorValues.yOffset = value
    editorYValue:SetText(math.floor(value))
    if editingZoneKey then
        SaveCurrentOverride()
        UpdateCrosshair()
    end
end)

editorSizeSlider:SetScript("OnValueChanged", function(self, value)
    editorValues.lineLength = value
    editorSizeValue:SetText(math.floor(value))
    if editingZoneKey then
        SaveCurrentOverride()
        UpdateCrosshair()
    end
end)

-- Editor color button callbacks
for _, btn in ipairs(editorColorBtns) do
    btn:SetScript("OnClick", function(self)
        editorValues.color = {unpack(self.colorData)}
        UpdateEditorSwatch()
        if editingZoneKey then
            SaveCurrentOverride()
            UpdateCrosshair()
        end
    end)
end

editorCustomBtn:SetScript("OnClick", function()
    local r, g, b, a = unpack(editorValues.color or {0, 1, 0, 0.9})

    local function OnColorChanged()
        local newR, newG, newB = ColorPickerFrame:GetColorRGB()
        local newA = ColorPickerFrame:GetColorAlpha()
        editorValues.color = {newR, newG, newB, newA}
        UpdateEditorSwatch()
        if editingZoneKey then
            SaveCurrentOverride()
            UpdateCrosshair()
        end
    end

    local function OnCancel()
        editorValues.color = {r, g, b, a}
        UpdateEditorSwatch()
        if editingZoneKey then
            SaveCurrentOverride()
            UpdateCrosshair()
        end
    end

    ColorPickerFrame:SetupColorPickerAndShow({
        r = r, g = g, b = b, opacity = a,
        hasOpacity = true,
        swatchFunc = OnColorChanged,
        opacityFunc = OnColorChanged,
        cancelFunc = OnCancel,
    })
end)

-- Editor combat checkbox callback
editorCombatCheck:SetScript("OnClick", function()
    if editingZoneKey then
        SaveCurrentOverride()
        UpdateVisibility()
    end
end)

-- Override GetEffectiveSettings when editing to show preview
local originalGetEffectiveSettings = GetEffectiveSettings
GetEffectiveSettings = function()
    -- If editing and we're in the zone being edited, show preview
    if editingZoneKey and editorFrame:IsShown() then
        local currentZone = GetCurrentZoneKey()
        if currentZone == editingZoneKey or not currentZone then
            -- Build preview settings from editor values
            local preview = {
                yOffset = editorValues.yOffset,
                lineLength = editorValues.lineLength,
                lineThickness = WheresMyFeetDB.defaults.lineThickness,
                color = editorValues.color,
                hideOutOfCombat = editorCombatCheck:GetChecked(),
            }
            return preview
        end
    end
    return originalGetEffectiveSettings()
end

-- Open editor for a zone
local function OpenEditor(zoneKey, zoneName)
    editingZoneKey = zoneKey
    local db = WheresMyFeetDB

    editorTitle:SetText("Edit: " .. (zoneName or "Unknown"))

    -- Load existing override or defaults
    local override = db.zoneOverrides and db.zoneOverrides[zoneKey]
    local defs = db.defaults

    -- Initialize editor values from override or defaults
    editorValues = {}

    if override then
        -- Load from existing override
        editorValues.yOffset = override.yOffset or defs.yOffset
        editorValues.lineLength = override.lineLength or defs.lineLength
        editorValues.color = override.color and {unpack(override.color)} or {unpack(defs.color)}
        editorCombatCheck:SetChecked(override.hideOutOfCombat ~= nil and override.hideOutOfCombat or defs.hideOutOfCombat)
    else
        -- New override - start with defaults
        editorValues.yOffset = defs.yOffset
        editorValues.lineLength = defs.lineLength
        editorValues.color = {unpack(defs.color)}
        editorCombatCheck:SetChecked(defs.hideOutOfCombat)
    end

    -- Set UI values
    editorYSlider:SetValue(editorValues.yOffset)
    editorSizeSlider:SetValue(editorValues.lineLength)
    UpdateEditorSwatch()

    editorFrame:Show()
    UpdateCrosshair()
end

-- Close editor (changes are auto-saved)
local function CloseEditor()
    editingZoneKey = nil
    editorFrame:Hide()
    UpdateCrosshair()
    UpdateVisibility()

    -- Refresh the override list
    if zonesContent:IsShown() then
        zonesContent:GetScript("OnShow")(zonesContent)
    end
end

editorDoneBtn:SetScript("OnClick", CloseEditor)
editorCloseBtn:SetScript("OnClick", CloseEditor)

-- Refresh override list
RefreshOverrideList = function()
    local db = WheresMyFeetDB
    if not db then return end

    -- Clear existing buttons
    for _, btn in ipairs(overrideButtons) do
        btn:Hide()
        btn:SetParent(nil)
    end
    wipe(overrideButtons)

    local overrides = db.zoneOverrides or {}
    local yPos = 0

    for zoneKey, override in pairs(overrides) do
        local row = CreateFrame("Frame", nil, scrollChild)
        row:SetSize(190, 24)
        row:SetPoint("TOPLEFT", 0, -yPos)

        -- Enable checkbox
        local enableCheck = CreateFrame("CheckButton", nil, row, "UICheckButtonTemplate")
        enableCheck:SetPoint("LEFT", 0, 0)
        enableCheck:SetChecked(override.enabled)
        enableCheck:SetScript("OnClick", function(self)
            override.enabled = self:GetChecked()
            OnZoneChanged()
        end)

        -- Zone name
        local nameText = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        nameText:SetPoint("LEFT", enableCheck, "RIGHT", 5, 0)
        nameText:SetText(override.name or ("Zone " .. zoneKey))
        nameText:SetWidth(100)
        nameText:SetJustifyH("LEFT")

        -- Edit button
        local editBtn = CreateFrame("Button", nil, row, "UIPanelButtonTemplate")
        editBtn:SetSize(35, 20)
        editBtn:SetText("Edit")
        editBtn:SetPoint("LEFT", nameText, "RIGHT", 5, 0)
        editBtn:SetScript("OnClick", function()
            OpenEditor(zoneKey, override.name)
        end)

        -- Delete button
        local delBtn = CreateFrame("Button", nil, row, "UIPanelButtonTemplate")
        delBtn:SetSize(20, 20)
        delBtn:SetText("X")
        delBtn:SetPoint("LEFT", editBtn, "RIGHT", 2, 0)
        delBtn:SetScript("OnClick", function()
            db.zoneOverrides[zoneKey] = nil
            OnZoneChanged()
            RefreshOverrideList()
        end)

        table.insert(overrideButtons, row)
        yPos = yPos + 26
    end

    scrollChild:SetHeight(math.max(yPos, 1))
end

-- Zone picker dropdown initialization
local function InitZonePicker(self, level)
    local db = WheresMyFeetDB
    if not db then return end

    local info = UIDropDownMenu_CreateInfo()

    -- Current zone (if in instance) - always shown at top with ID
    local currentKey = GetCurrentZoneKey()
    local currentName = GetCurrentZoneName()
    if currentKey and currentName then
        info.text = currentName .. " (" .. currentKey .. ") *"
        info.value = currentKey
        info.func = function()
            UIDropDownMenu_SetSelectedValue(zonePicker, currentKey)
            UIDropDownMenu_SetText(zonePicker, currentName .. " (" .. currentKey .. ")")
        end
        UIDropDownMenu_AddButton(info, level)

        -- Separator
        info = UIDropDownMenu_CreateInfo()
        info.text = ""
        info.disabled = true
        info.notCheckable = true
        UIDropDownMenu_AddButton(info, level)
    end

    -- S1 Zones
    for id, name in pairs(s1Zones) do
        info = UIDropDownMenu_CreateInfo()
        info.text = name
        info.value = id
        if db.zoneOverrides and db.zoneOverrides[id] then
            info.text = name .. " (configured)"
        end
        info.func = function()
            UIDropDownMenu_SetSelectedValue(zonePicker, id)
            UIDropDownMenu_SetText(zonePicker, name)
        end
        UIDropDownMenu_AddButton(info, level)
    end

    -- Known zones (non-S1, with overrides)
    local hasKnown = false
    if db.knownZones then
        for id, name in pairs(db.knownZones) do
            if not s1Zones[id] then
                if not hasKnown then
                    info = UIDropDownMenu_CreateInfo()
                    info.text = ""
                    info.disabled = true
                    info.notCheckable = true
                    UIDropDownMenu_AddButton(info, level)
                    hasKnown = true
                end

                info = UIDropDownMenu_CreateInfo()
                info.text = name
                if db.zoneOverrides and db.zoneOverrides[id] then
                    info.text = name .. " (configured)"
                end
                info.value = id
                info.func = function()
                    UIDropDownMenu_SetSelectedValue(zonePicker, id)
                    UIDropDownMenu_SetText(zonePicker, name)
                end
                UIDropDownMenu_AddButton(info, level)
            end
        end
    end

    -- Search option
    info = UIDropDownMenu_CreateInfo()
    info.text = ""
    info.disabled = true
    info.notCheckable = true
    UIDropDownMenu_AddButton(info, level)

    info = UIDropDownMenu_CreateInfo()
    info.text = "Enter Zone ID..."
    info.value = "search"
    info.func = function()
        StaticPopup_Show("WMF_ZONE_ID_INPUT")
    end
    UIDropDownMenu_AddButton(info, level)
end

UIDropDownMenu_Initialize(zonePicker, InitZonePicker)

-- Function to set dropdown to current zone
SetDropdownToCurrentZone = function()
    local currentKey = GetCurrentZoneKey()
    local currentName = GetCurrentZoneName()
    if currentKey and currentName then
        UIDropDownMenu_SetSelectedValue(zonePicker, currentKey)
        UIDropDownMenu_SetText(zonePicker, currentName .. " (" .. currentKey .. ")")
    else
        UIDropDownMenu_SetSelectedValue(zonePicker, nil)
        UIDropDownMenu_SetText(zonePicker, "Select Zone")
    end
end

SetDropdownToCurrentZone()

-- Add Override button click handler
addOverrideBtn:SetScript("OnClick", function()
    local zoneKey = UIDropDownMenu_GetSelectedValue(zonePicker)
    if not zoneKey or zoneKey == "search" then
        print("|cFF00FF00WMF:|r Select a zone first")
        return
    end

    local zoneName = s1Zones[zoneKey]
    if not zoneName then
        local db = WheresMyFeetDB
        zoneName = db.knownZones and db.knownZones[zoneKey]
    end
    zoneName = zoneName or ("Zone " .. zoneKey)

    OpenEditor(zoneKey, zoneName)
end)

-- Zone ID input popup
StaticPopupDialogs["WMF_ZONE_ID_INPUT"] = {
    text = "Enter zone ID (number):",
    button1 = "Add",
    button2 = "Cancel",
    hasEditBox = true,
    OnAccept = function(self)
        local text = self.editBox:GetText()
        local zoneId = tonumber(text)
        if zoneId then
            local db = WheresMyFeetDB
            db.knownZones = db.knownZones or {}
            local zoneName = db.knownZones[zoneId] or s1Zones[zoneId] or ("Zone " .. zoneId)
            OpenEditor(zoneId, zoneName)
        else
            print("|cFF00FF00WMF:|r Invalid zone ID")
        end
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

-- Refresh list when zones tab shown
zonesContent:SetScript("OnShow", function()
    RefreshOverrideList()
    zoneToggle:SetChecked(WheresMyFeetDB and WheresMyFeetDB.enableZoneOverrides)
    SetDropdownToCurrentZone()
end)

-- ============================================================
-- INITIALIZATION
-- ============================================================

local function MigrateSettings()
    local db = WheresMyFeetDB

    -- Check if already migrated (has defaults table)
    if db.defaults then return end

    -- Migrate flat structure to nested
    local oldSettings = {}
    for k, v in pairs(defaults) do
        if db[k] ~= nil then
            oldSettings[k] = db[k]
            db[k] = nil
        else
            oldSettings[k] = v
        end
    end

    db.defaults = oldSettings
    db.zoneOverrides = db.zoneOverrides or {}
    db.enableZoneOverrides = db.enableZoneOverrides or false
    db.knownZones = db.knownZones or {}

    print("|cFF00FF00WMF:|r Settings migrated to new format")
end

-- Initialize on load
local loader = CreateFrame("Frame")
loader:RegisterEvent("ADDON_LOADED")
loader:SetScript("OnEvent", function(self, event, addon)
    if addon == "WheresMyFeet" then
        -- Initialize DB if needed
        if not WheresMyFeetDB then
            WheresMyFeetDB = {
                defaults = CopyTable(defaults),
                zoneOverrides = {},
                enableZoneOverrides = false,
                knownZones = {},
            }
        else
            -- Migrate old settings
            MigrateSettings()
        end

        -- Initialize per-character DB if needed (defaults to enabled)
        if not WheresMyFeetCharDB then
            WheresMyFeetCharDB = {
                enabled = true,
            }
        end
        -- Ensure enabled key exists (for existing characters)
        if WheresMyFeetCharDB.enabled == nil then
            WheresMyFeetCharDB.enabled = true
        end

        -- Ensure all default keys exist
        for k, v in pairs(defaults) do
            if WheresMyFeetDB.defaults[k] == nil then
                WheresMyFeetDB.defaults[k] = v
            end
        end

        UpdateCrosshair()
        UpdateVisibility()

        -- Initialize UI
        ySlider:SetValue(WheresMyFeetDB.defaults.yOffset)
        sizeSlider:SetValue(WheresMyFeetDB.defaults.lineLength)
        combatCheck:SetChecked(WheresMyFeetDB.defaults.hideOutOfCombat)
        enabledCheck:SetChecked(WheresMyFeetCharDB.enabled)
        UpdateDefaultSwatch()

        -- Set initial tab
        SetActiveTab("defaults")
    end
end)

-- Slash commands
SLASH_WHERESYMFEET1 = "/wmf"
SlashCmdList["WHERESYMFEET"] = function(msg)
    local args = {}
    for word in msg:gmatch("%S+") do
        table.insert(args, word)
    end

    local cmd = args[1] and args[1]:lower()

    if cmd == "addzone" then
        local zoneId = tonumber(args[2])
        if not zoneId then
            print("|cFF00FF00WMF:|r Usage: /wmf addzone <id> [name]")
            return
        end

        local zoneName = table.concat(args, " ", 3) or ("Zone " .. zoneId)
        if zoneName == "" then zoneName = "Zone " .. zoneId end

        WheresMyFeetDB.knownZones = WheresMyFeetDB.knownZones or {}
        WheresMyFeetDB.knownZones[zoneId] = zoneName
        print("|cFF00FF00WMF:|r Added zone: " .. zoneName .. " (ID: " .. zoneId .. ")")
    elseif cmd == "zone" then
        -- Debug: show current zone info
        local name, instanceType, _, _, _, _, _, instanceMapID = GetInstanceInfo()
        print("|cFF00FF00WMF:|r Current zone: " .. name)
        print("|cFF00FF00WMF:|r Instance type: " .. instanceType)
        print("|cFF00FF00WMF:|r Instance map ID: " .. tostring(instanceMapID))
        print("|cFF00FF00WMF:|r Zone key type: " .. type(instanceMapID))
    elseif cmd == "debug" then
        -- Debug: show override info
        local db = WheresMyFeetDB
        local zoneKey = GetCurrentZoneKey()
        print("|cFF00FF00WMF:|r === Debug Info ===")
        print("|cFF00FF00WMF:|r enableZoneOverrides: " .. tostring(db.enableZoneOverrides))
        print("|cFF00FF00WMF:|r Current zone key: " .. tostring(zoneKey) .. " (type: " .. type(zoneKey) .. ")")
        if db.zoneOverrides then
            print("|cFF00FF00WMF:|r Stored overrides:")
            for k, v in pairs(db.zoneOverrides) do
                print("  - Key: " .. tostring(k) .. " (type: " .. type(k) .. "), Name: " .. tostring(v.name) .. ", Enabled: " .. tostring(v.enabled))
                if v.color then
                    print("    Color: " .. table.concat(v.color, ", "))
                end
            end
        else
            print("|cFF00FF00WMF:|r No overrides stored")
        end
        -- Show effective settings
        local eff = GetEffectiveSettings()
        print("|cFF00FF00WMF:|r Effective color: " .. table.concat(eff.color, ", "))
    elseif cmd == "enable" then
        WheresMyFeetCharDB.enabled = true
        enabledCheck:SetChecked(true)
        UpdateVisibility()
        print("|cFF00FF00WMF:|r Enabled for this character")
    elseif cmd == "disable" then
        WheresMyFeetCharDB.enabled = false
        enabledCheck:SetChecked(false)
        UpdateVisibility()
        print("|cFF00FF00WMF:|r Disabled for this character")
    elseif cmd == "reset" then
        WheresMyFeetDB = {
            defaults = CopyTable(defaults),
            zoneOverrides = {},
            enableZoneOverrides = false,
            knownZones = {},
        }
        WheresMyFeetCharDB = {
            enabled = true,
        }
        UpdateCrosshair()
        UpdateVisibility()
        ySlider:SetValue(WheresMyFeetDB.defaults.yOffset)
        sizeSlider:SetValue(WheresMyFeetDB.defaults.lineLength)
        combatCheck:SetChecked(WheresMyFeetDB.defaults.hideOutOfCombat)
        enabledCheck:SetChecked(WheresMyFeetCharDB.enabled)
        print("|cFF00FF00WMF:|r Settings reset to defaults")
    else
        if options:IsShown() then
            options:Hide()
        else
            options:Show()
        end
    end
end
