
local _, Addon = ...
local L = Addon:GetLocale()


local ExtensionManager = Addon.Systems.ExtensionManager

local internalExtensions = {}

function ExtensionManager:GetAllAddonNamesForInternalExtensions()
    local list = {}
    for k, v in pairs(internalExtensions) do

        table.insert(list, v.addonName)
    end
    return list
end

function ExtensionManager:GetInternalExtension(addonName)
    if internalExtensions[addonName] then
        return internalExtensions[addonName]
    else
        return nil
    end
end

-- Adds extension definition that will be loaded if addonName is present.
function ExtensionManager:AddInternalExtension(addonName, extensionDefinition)
    if internalExtensions[addonName] then

        return true
    end

    local extension = {}
    extension.addonName = addonName
    extension.definition = extensionDefinition
    extension.enabled = false
    internalExtensions[addonName] = extension

end

-- Register the extension for a particular addon.
function ExtensionManager:RegisterInternalExtension(addonName)


    local ext = internalExtensions[addonName]
    if not ext then

        return false
    end

    -- Ensure valid definition these will be stripped out of release.




    -- For idempotency we shall not error here, just do nothing.
    if ext.enabled then

        return true
    end

    -- Verify the Addon is actually present
    local addonInfo = {Addon:GetAddOnInfo(addonName)}
    -- 1 = name (folder)
    -- 2 = title
    -- 3 = description
    -- 4 = loadable
    -- 5 = reason (if 4 is false)
    -- 6 = security (always insecure)
    -- 7 = not used

    if not addonInfo[4] then

        return false
    end

    -- Register the extension with Vendor

    local success, result =  xpcall(Addon.RegisterExtension, CallErrorHandler, Addon, ext.definition)
    if not success then

        return false
    end

    -- Some extensions have bi-directional registration.
    if ext.definition.Register and type(ext.definition.Register) == "function" then
        success, result = xpcall(ext.definition.Register, CallErrorHandler, nil)
        if not success then

            return false
        else

        end
    end

    return true
end
