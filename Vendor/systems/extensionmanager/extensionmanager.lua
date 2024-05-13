--[[
    Info System

    This populates information and properties for all systems to use or make available to other
    systems. 
]]

local _, Addon = ...
local L = Addon:GetLocale()


local ExtensionManager = {}

function ExtensionManager:GetDependencies()
    return {
        "info",
        "rules",
        "interop",
        "lists",
     --   "features"
    }
end

function ExtensionManager:Startup(register)

    -- Load all extensions for addons which may have already been loaded prior to our addon loading.

    local extensions = self:GetAllAddonNamesForInternalExtensions()

    for i, v in pairs(extensions) do

        self:RegisterInternalExtension(v)
    end

    -- Register event to handle addons which load after we do.
    --Addon:RegisterEvent("ADDON_LOADED", self.OnAddonLoaded)

    register({
        -- Eventually add external extension registration here when it is migrated.
        })
end

function ExtensionManager:Shutdown()
end

-- For addons that load after we do, if one of them is an internal extension, register it.
function ExtensionManager.ON_ADDON_LOADED(addonName)
    if ExtensionManager:GetInternalExtension(addonName) then
        ExtensionManager:RegisterInternalExtension(addonName)
    end
end


Addon.Systems.ExtensionManager = ExtensionManager