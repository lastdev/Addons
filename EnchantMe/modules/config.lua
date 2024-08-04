local _, addon = ...
local config, private = addon.module('config')
local latestVersion = 1

function config.init()
    if EnchantMeAddonConfig then
        -- try to load and migrate existing config
        config.db = EnchantMeAddonConfig

        local success, result = pcall(private.migrateConfiguration)

        if not success then
            -- reset config on migration error
            private.loadDefaultConfig()
            CallErrorHandler(result)
        end
    else
        -- no config data yet - load default
        private.loadDefaultConfig()
    end
end

function config.getDefaultConfig()
    return {
        version = latestVersion,
        indicatorPos = 'TOPLEFT',
        flagColor = 'ffff0000',
        ignoreBelt = false,
    }
end

function private.loadDefaultConfig()
    EnchantMeAddonConfig = config.getDefaultConfig()
    config.db = EnchantMeAddonConfig
end

function private.migrateConfiguration()
    for to = config.db.version + 1, latestVersion do
        private.migrations[to]()
    end

    config.db.version = latestVersion
end

private.migrations = {
    -- none for now
}
