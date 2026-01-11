---@type InvasionTimer, table<string, string>
local IT, L = unpack((select(2, ...)))
---@class InvasionTimerConfig
local Config = {}
IT.Config = Config

-- Lua functions
local _G = _G
local ipairs = ipairs

-- WoW API / Variables
local Settings_CreateCheckbox = Settings.CreateCheckbox
local Settings_CreateElementInitializer = Settings.CreateElementInitializer
local Settings_RegisterAddOnCategory = Settings.RegisterAddOnCategory
local Settings_RegisterAddOnSetting = Settings.RegisterAddOnSetting
local Settings_RegisterVerticalLayoutCategory = Settings.RegisterVerticalLayoutCategory
local Settings_RegisterVerticalLayoutSubcategory = Settings.RegisterVerticalLayoutSubcategory

function Config:Initialize()
    local category = Settings_RegisterVerticalLayoutCategory("Invasion Timer")

    local use12HourClock = Settings_RegisterAddOnSetting(category, 'InvasionTimer_use12HourClock', 'use12HourClock', IT.db.settings, 'boolean', L["Use 12-hour clock"], false)
    Settings_CreateCheckbox(category, use12HourClock)
    local useDDMMFormat = Settings_RegisterAddOnSetting(category, 'InvasionTimer_useDDMMFormat', 'useDDMMFormat', IT.db.settings, 'boolean', L["Use DD/MM format"], false)
    Settings_CreateCheckbox(category, useDDMMFormat)

    local currentExpansion = -1
    local displayCategory, displayLayout = Settings_RegisterVerticalLayoutSubcategory(category, L["Display"])
    local displayEntries = IT.Core:GetAllEntries()
    for _, entry in ipairs(displayEntries) do
        if currentExpansion ~= entry.expansion then
            local initializer = Settings_CreateElementInitializer('SettingsListSectionHeaderTemplate', {name = _G['EXPANSION_NAME' .. entry.expansion]})
            displayLayout:AddInitializer(initializer)

            currentExpansion = entry.expansion
        end

        local settingKey = entry.expansion .. '_' .. entry.key
        local setting = Settings_RegisterAddOnSetting(displayCategory, 'InvasionTimer_' .. settingKey, settingKey, IT.db.settings.displayEntry, 'boolean', entry.title, true)
        Settings_CreateCheckbox(displayCategory, setting)
    end

    Settings_RegisterAddOnCategory(category)
end
