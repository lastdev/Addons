local _, addon = ...
local settings, private = addon.module('settings')

function settings.init()
    local category = Settings.RegisterVerticalLayoutCategory('Enchant Me')
    local defaults = addon.config.getDefaultConfig()

    local function addSetting(key, title, type, initializer)
        local variable = 'EnchantMe_' .. key
        local setting = Settings.RegisterAddOnSetting(category, variable, key, addon.config.db, type, title, defaults[key])

        initializer(setting)
        Settings.SetOnValueChangedCallback(variable, private.onSettingChanged)
    end

    -- indicator position
    addSetting('indicatorPos', 'Indicator position', 'string', function (setting)
        local options = function ()
            local container = Settings.CreateControlTextContainer()
            container:Add('TOPLEFT', 'Top left')
            container:Add('TOPRIGHT', 'Top right')
            container:Add('BOTTOMLEFT', 'Bottom left')
            container:Add('BOTTOMRIGHT', 'Bottom right')

            return container:GetData()
        end

        Settings.CreateDropdown(category, setting, options, 'Position of the missing enchant indicator on the equipment item frame')
    end)

    -- flag color
    addSetting('flagColor', 'Flag color', 'string', function (setting)
        local options = function ()
            local container = Settings.CreateControlTextContainer()
            container:Add('ffff0000', '|cffff0000Red|r')
            container:Add('ff33ff33', '|cff33ff33Green|r')
            container:Add('fffef900', '|cfffef900Yellow|r')

            return container:GetData()
        end

        Settings.CreateDropdown(category, setting, options, 'Color of the indicator flag text')
    end)

    Settings.RegisterAddOnCategory(category)
end

function private.onSettingChanged(_, setting, value)
    addon.main.updateHandlers()
end
