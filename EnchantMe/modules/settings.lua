local _, addon = ...
local settings, private = addon.module('settings')
local ready = false

function settings.init()
    local category = Settings.RegisterVerticalLayoutCategory('Enchant Me')
    local defaults = addon.config.getDefaultConfig()

    -- ignore belt
    do
        local key = 'ignoreBelt'
        local setting = Settings.RegisterAddOnSetting(category, 'Ignore belt', key, 'boolean', defaults[key])
        Settings.CreateCheckbox(category, setting, 'Ignore missing Shadowed Belt Clasp\n(as it is usually very expensive and only gives a small amount of stamina)')
        private.configureSetting(key, setting)
    end

    -- indicator position
    do
        local key = 'indicatorPos'
        local setting = Settings.RegisterAddOnSetting(category, 'Indicator position', key, 'string', defaults[key])
        local options = function ()
            local container = Settings.CreateControlTextContainer()
            container:Add('TOPLEFT', 'Top left')
            container:Add('TOPRIGHT', 'Top right')
            container:Add('BOTTOMLEFT', 'Bottom left')
            container:Add('BOTTOMRIGHT', 'Bottom right')

            return container:GetData()
        end
        Settings.CreateDropdown(category, setting, options, 'Position of the missing enchant indicator on the equipment item frame')
        private.configureSetting(key, setting)
    end

    -- flag color
    do
        local key = 'flagColor'
        local setting = Settings.RegisterAddOnSetting(category, 'Flag color', key, 'string', defaults[key])
        local options = function ()
            local container = Settings.CreateControlTextContainer()
            container:Add('ffff0000', '|cffff0000Red|r')
            container:Add('ff33ff33', '|cff33ff33Green|r')
            container:Add('fffef900', '|cfffef900Yellow|r')

            return container:GetData()
        end
        Settings.CreateDropdown(category, setting, options, 'Color of the indicator flag text')
        private.configureSetting(key, setting)
    end

    Settings.RegisterAddOnCategory(category)
    ready = true
end

function private.configureSetting(key, setting)
    Settings.SetOnValueChangedCallback(key, private.onSettingChanged)
    setting:SetValue(addon.config.db[key])
end

function private.onSettingChanged(_, setting, value)
    if ready then
        addon.config.db[setting:GetVariable()] = value
        addon.main.updateHandlers()
    end
end
