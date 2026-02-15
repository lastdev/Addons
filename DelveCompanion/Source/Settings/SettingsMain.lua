local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Lockit
local Lockit = DelveCompanion.Lockit
---@type Config
local Config = DelveCompanion.Config
---@type Definitions
local Definitions = DelveCompanion.Definitions

--#region Constants

---@type string
local ADDON_SETTING_PREFIX = tostring(addonName) .. "_"
--#endregion

--- Class for managing addon settings.
---@class (exact) AddonSettings
---@field mainCategory table
---@field settingsCategory table
local AddonSettings = {}
DelveCompanion.AddonSettings = AddonSettings

--- Used in `TOC` file for [AddonCompartmentFuncOnEnter](https://warcraft.wiki.gg/wiki/TOC_format#AddonCompartmentFuncOnEnter).
---@param addonName string
---@param menuButtonFrame table
function DelveCompanionCompartmentOnEnter(addonName, menuButtonFrame)
    local tooltip = GameTooltip

    tooltip:SetOwner(menuButtonFrame, "ANCHOR_NONE")
    tooltip:SetPoint("TOPRIGHT", menuButtonFrame, "TOPLEFT")
    GameTooltip_SetTitle(tooltip, Lockit.UI_ADDON_NAME, nil, true)
    GameTooltip_AddBlankLineToTooltip(tooltip)
    GameTooltip_AddNormalLine(tooltip, Lockit.UI_COMPARTMENT_DESCRIPTION_LEFT_CLICK, true)
    GameTooltip_AddNormalLine(tooltip, Lockit.UI_COMPARTMENT_DESCRIPTION_RIGHT_CLICK, true)

    tooltip:Show()
end

--- Used in `TOC` file for [AddonCompartmentFuncOnLeave](https://warcraft.wiki.gg/wiki/TOC_format#AddonCompartmentFuncOnLeave).
---@param addonName string
---@param menuButtonFrame table
function DelveCompanionCompartmentOnLeave(addonName, menuButtonFrame)
    GameTooltip:Hide()
end

--- Global function to open addon settings. Used in `TOC` file for [AddonCompartmentFunc](https://warcraft.wiki.gg/wiki/TOC_format#AddonCompartmentFunc).
---@param addonName string
---@param buttonName string
function DelveCompanionCompartmentOnClick(addonName, buttonName)
    if not (Settings and Settings.OpenToCategory) then
        return
    end

    local id = ""

    if buttonName == Definitions.ButtonAlias.leftClick then
        id = AddonSettings.mainCategory:GetID()
    elseif buttonName == Definitions.ButtonAlias.rightClick then
        id = AddonSettings.settingsCategory:GetID()
    end

    Settings.OpenToCategory(id)
end

--- This callback will be invoked whenever a setting is modified.
local function OnSettingChanged(setting, value)
    -- Logger.Log("OnChanged registered...")

    local variableName = gsub(setting:GetVariable(), ADDON_SETTING_PREFIX, "")

    -- Logger.Log("Firing changed var `%s` with value: %s", variableName, tostring(value))
    EventRegistry:TriggerEvent(DelveCompanion.Definitions.Events.SETTING_CHANGE, variableName, value)
end

--- Create and register an addon Setting.
---@param category any
---@param varKey string
---@param varTbl DelveCompanionAccountData|DelveCompanionCharacterData
---@param defaultValue any
---@param displayText string
---@param onChangedCallback function
---@return unknown|nil
local function RegisterSetting(category, varKey, varTbl, defaultValue, displayText, onChangedCallback)
    if varTbl[varKey] == nil then
        Logger.Log(Lockit.DEBUG_SAVED_VARIABLE_CONFLICT, varTbl, varKey)
        return nil
    end

    local setting = Settings.RegisterAddOnSetting(
        category, ADDON_SETTING_PREFIX .. varKey,
        varKey, varTbl,
        type(defaultValue), displayText, defaultValue)
    setting:SetValueChangedCallback(onChangedCallback)

    return setting
end

--- Accound-wide settings.
---@param category any
---@param layout any
local function PrepareAccountSettings(category, layout)
    ---@type DelveCompanionAccountData
    local savedVarTbl = DelveCompanionAccountData

    --- Section header
    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(Lockit.UI_SETTINGS_SECTION_TITLE_ACCOUNT))

    do
        local savedVarKey = "delveProgressWidgetsEnabled"

        local setting = RegisterSetting(category, savedVarKey, savedVarTbl,
            Config.DEFAULT_ACCOUNT_DATA.delveProgressWidgetsEnabled,
            Lockit.UI_SETTING_DELVE_PROGRESS_WIDGETS_NAME, OnSettingChanged)

        local tooltip = Lockit.UI_SETTING_DELVE_PROGRESS_WIDGETS_TOOLTIP
        Settings.CreateCheckbox(category, setting, tooltip)
    end

    do
        local savedVarKey = "trackingType"

        local setting = RegisterSetting(category, savedVarKey, savedVarTbl,
            Config.DEFAULT_ACCOUNT_DATA.trackingType,
            Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_NAME, OnSettingChanged)

        local function GetDropdownOptions()
            local container = Settings.CreateControlTextContainer()
            container:Add(DelveCompanion.Definitions.WaypointTrackingType.superTrack,
                Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_BLIZZARD_NAME,
                Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_BLIZZARD_DESCRIPTION)
            if DelveCompanion.Variables.tomTomAvailable then
                container:Add(DelveCompanion.Definitions.WaypointTrackingType.tomtom,
                    Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_TOMTOM_NAME,
                    Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_TOMTOM_DESCRIPTION)
            end
            if DelveCompanion.Variables.mpeAvailable then
                container:Add(DelveCompanion.Definitions.WaypointTrackingType.mpe,
                    Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_MPE_NAME,
                    Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_MPE_DESCRIPTION)
            end
            return container:GetData()
        end

        local function tooltip()
            local tooltipLineStart = _G["NORMAL_FONT_COLOR"]:WrapTextInColorCode(
                Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_START)
            local tooltipLineBlizzard = _G["NORMAL_FONT_COLOR"]:WrapTextInColorCode(
                Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_BLIZZARD)
            local tooltipLineTomTom = Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_TOMTOM
            local tooltipLineMPE = Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_MPE

            if DelveCompanion.Variables.tomTomAvailable then
                tooltipLineTomTom = _G["NORMAL_FONT_COLOR"]:WrapTextInColorCode(tooltipLineTomTom)
            else
                local unavailableLine = format(Lockit.UI_COMMON_MISSING_ADDON_TITLE,
                    Definitions.DependencyAddonName.tomtom)
                tooltipLineTomTom = format(
                    Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_TOMTOM_UNAVAILABLE_FORMAT,
                    _G["DISABLED_FONT_COLOR"]:WrapTextInColorCode(tooltipLineTomTom),
                    _G["WARNING_FONT_COLOR"]:WrapTextInColorCode(unavailableLine))
            end

            if DelveCompanion.Variables.mpeAvailable then
                tooltipLineMPE = _G["NORMAL_FONT_COLOR"]:WrapTextInColorCode(tooltipLineMPE)
            else
                local unavailableLine = format(Lockit.UI_COMMON_MISSING_ADDON_TITLE,
                    Definitions.DependencyAddonName.mpe)
                tooltipLineMPE = format(
                    Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_TOMTOM_UNAVAILABLE_FORMAT,
                    _G["DISABLED_FONT_COLOR"]:WrapTextInColorCode(tooltipLineMPE),
                    _G["WARNING_FONT_COLOR"]:WrapTextInColorCode(unavailableLine))
            end


            return string.join("\n",
                tooltipLineStart,
                tooltipLineBlizzard,
                tooltipLineTomTom,
                tooltipLineMPE)
        end

        Settings.CreateDropdown(category, setting, GetDropdownOptions, tooltip)
    end
end

--- Character-wide settings.
---@param category any
---@param layout any
local function PrepareCharacterSettings(category, layout)
    ---@type DelveCompanionCharacterData
    local savedVarTbl = DelveCompanionCharacterData

    --- Section header
    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(Lockit.UI_SETTINGS_SECTION_TITLE_CHARACTER))

    do
        local savedVarKey = "keysCapTooltipEnabled"

        local setting = RegisterSetting(category, savedVarKey, savedVarTbl,
            Config.DEFAULT_CHARACTER_DATA.keysCapTooltipEnabled,
            Lockit.UI_SETTING_TOOLTIP_EXTENSION_NAME, OnSettingChanged)

        local tooltip = Lockit.UI_SETTING_TOOLTIP_EXTENSION_TOOLTIP
        Settings.CreateCheckbox(category, setting, tooltip)
    end

    do
        local controlSavedVarKey = "displayCompanionConfig"
        local dropdownSavedVarKey = "companionConfigLayout"

        local settingName = Lockit.UI_SETTING_COMPANION_CONFIG_NAME

        local controlSetting = RegisterSetting(category, controlSavedVarKey, savedVarTbl,
            Config.DEFAULT_CHARACTER_DATA.displayCompanionConfig,
            settingName, OnSettingChanged)

        local dropdownSetting = RegisterSetting(category, dropdownSavedVarKey, savedVarTbl,
            Config.DEFAULT_CHARACTER_DATA.companionConfigLayout,
            settingName, OnSettingChanged)

        local function GetOptions()
            local container = Settings.CreateControlTextContainer()
            container:Add(DelveCompanion.Definitions.CompanionWidgetLayout.horizontal,
                Lockit.UI_SETTING_COMPANION_CONFIG_OPTION_HORIZONTAL_NAME,
                Lockit.UI_SETTING_COMPANION_CONFIG_OPTION_HORIZONTAL_DESCRIPTION)
            container:Add(DelveCompanion.Definitions.CompanionWidgetLayout.vertical,
                Lockit.UI_SETTING_COMPANION_CONFIG_OPTION_VERTICAL_NAME,
                Lockit.UI_SETTING_COMPANION_CONFIG_OPTION_VERTICAL_DESCRIPTION)

            return container:GetData()
        end
        local controlTooltip = Lockit.UI_SETTING_COMPANION_CONFIG_TOOLTIP
        local dropdownTooltip = Lockit.UI_SETTING_COMPANION_CONFIG_TOOLTIP

        local initializer = CreateSettingsCheckboxDropdownInitializer(
            controlSetting, settingName, controlTooltip,
            dropdownSetting, GetOptions, settingName, dropdownTooltip)
        layout:AddInitializer(initializer)
    end

    do
        local savedVarKey = "gvDetailsEnabled"

        local setting = RegisterSetting(category, savedVarKey, savedVarTbl,
            Config.DEFAULT_CHARACTER_DATA.gvDetailsEnabled,
            Lockit.UI_SETTING_GV_DETAILS_NAME, OnSettingChanged)

        local tooltip = Lockit.UI_SETTING_GV_DETAILS_TOOLTIP
        Settings.CreateCheckbox(category, setting, tooltip)
    end

    do
        local savedVarKey = "dashOverviewEnabled"

        local setting = RegisterSetting(category, savedVarKey, savedVarTbl,
            Config.DEFAULT_CHARACTER_DATA.dashOverviewEnabled,
            Lockit.UI_SETTING_DASHBOARD_OVERVIEW_NAME, OnSettingChanged)

        local tooltip = Lockit.UI_SETTING_DASHBOARD_OVERVIEW_TOOLTIP
        Settings.CreateCheckbox(category, setting, tooltip)
    end
end

function AddonSettings:Init()
    -- Logger.Log("Start initing Settings...")

    do
        local settingsFrame = CreateFrame("Frame", "$parent.DelveCompanionSettings", nil,
            "DelveCompanionSettingsFrameTemplate")
        local category, _ = Settings.RegisterCanvasLayoutCategory(settingsFrame, Lockit.UI_ADDON_NAME)
        Settings.RegisterAddOnCategory(category)
        AddonSettings.mainCategory = category
    end

    do
        local category, layout = Settings.RegisterVerticalLayoutSubcategory(AddonSettings.mainCategory, _G["OPTIONS"])
        AddonSettings.settingsCategory = category

        PrepareAccountSettings(category, layout)
        PrepareCharacterSettings(category, layout)

        Settings.RegisterAddOnCategory(category)
    end

    -- Logger.Log("Settings inited")
end
