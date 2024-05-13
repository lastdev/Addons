local AddonName, Addon = ...

local Features = {}
local compMgr = Addon.ComponentManager

--[[ Gets a property or calls a function on the specified featuire ]]
local function GetFeatureValue(feature, property, funcName)
    local func = feature[funcName]
    if (type(func) == "function") then
        return func(feature)
    end

    local prop = feature[property]
    if (type(prop) ~= "nil") then
        return prop
    end

    return nil
end

--[[ Checks if the feature is a beta feature or not ]]
local function IsBetaFeature(feature)
    local beta = GetFeatureValue(feature, "BETA", "GetIsBeta")
    return (type(beta) == "boolean") and beta == true
end

--[[ Retreives the enables state of a beta feature ]]
local function GetBetaFeatureState(name)
    local beta = Addon:GetAccountSetting("BetaFeatures", {})
    name = string.lower(name)

    if (type(beta[name]) == "boolean") then
        return (beta[name] ~= false)
    end

    return true
end

function Features:InitializeFeature(name, feature)

    local instance = feature

    -- In debug we create a proxy to the feature so that we can 
    -- catch typo's
    if (Addon.IsDebug) then
        instance = setmetatable({}, {
            __metatable = "feature:" .. name,
            __index = function(_self, member)
                local field = rawget(feature, member)
                if (type(field) ~= nil and type(field) ~= "function") then
                    return field;
                end

                if (type(field) ~= 'function') then
                    error(string.format("The feature '%s' does not have a method '%s'", name, member))
                end

                return function(_, ...)
                        local result = { xpcall(field, CallErrorHandler, feature, ...) }

                        table.remove(result, 1)
                        return unpack(result)
                    end
            end,
            __newindex = function(_, name, value)
                rawset(feature, name, value)
            end
        })
        rawset(instance, "#FEATURE#", feature)
    end

    -- Merge the locale into the table
    if (type(feature.Locale) == "table") then
        for locale, strings in pairs(feature.Locale) do


            local loc = Addon:FindLocale(locale);
            if (loc) then
                loc:Add(strings)
            end
        end
    end

    -- Call Initiaize on the feature
    -- We should have 2 core events:
    --      OnInitialize
    --      OnTerminate
    local init = feature.OnInitialize
    if (type(init) == "function") then

        local success = xpcall(init, CallErrorHandler, instance)


        if (not success) then
            return
        end
    end

    -- Check for events (move to GetEvents)
    local events = GetFeatureValue(feature, "EVENTS", "GetEvents")
    if (type(events) == "table") then
        Addon:GenerateEvents(events)
    end

    Addon.RegisterForEvents(instance, feature)
    self.features[string.lower(name)] = instance;
    Addon:RaiseEvent("OnFeatureReady", name, instance)
    Addon:RaiseEvent("OnFeatureEnabled", name, instance)
end

function Features:TerminateFeature(name, feature)


    name = string.lower(name)
    if (self.features[name]) then
        local term = feature.OnTerminate
        if (type(term) == "function") then

            local success = xpcall(term, CallErrorHandler, self.features[name])

        end

        Addon.UnregisterFromEvents(self.features[name], feature)
        self.features[string.lower(name)] = nil;
        Addon:RaiseEvent("OnFeatureDisabled", name, feature)
    end
end

function Features:CreateComponent(name, feature)


    local featureDeps = GetFeatureValue(feature, "DEPENDENCIES", "GetDependencies") or {}
    table.insert(featureDeps, "event:loaded" );
    table.insert(featureDeps, "core:systems" );
    table.insert(featureDeps, "event:PLAYER_ENTERING_WORLD" );

    local fs = self
    return {
        Type = "feature",
        Name = name,
        Beta = IsBetaFeature(feature),
        OnInitialize = function() Features.InitializeFeature(fs, name, feature) end,
        OnTerminate = function() Features.TerminateFeature(fs, name, feature) end,
        Dependencies = featureDeps
    }
end

function Features:GetDependencies() 
    return { "system:savedvariables", "system:accountsettings", "system:profile" }
end

--[[ Startup our features ]]
function Features:Startup(register)

    self.features = {}

    local deps = { }
    
    for name, feature in pairs(Addon.Features or {}) do
        local enable = true
        local optional = false

        if (IsBetaFeature(feature)) then
            if (not GetBetaFeatureState(name)) then

                enable = false
            end
            optional = true
        end

        if (not optional and type(feature.OPTIONAL) == "boolean") then
            optional = feature.OPTIONAL == true
        end

        if (enable) then
            if (not optional) then
                table.insert(deps, "feature:" .. name)
            end

            compMgr:Create(self:CreateComponent(name, feature));
        end
    end

    compMgr:Create({
        Name = "features",
        Type = "core",
        Dependencies = deps,
        OnInitialize = function(self)

            Addon:RaiseEvent("OnFeaturesReady")
        end
    })

    register({
        "GetFeature", 
        "IsFeatureEnabled", 
        "EnableFeature", 
        "DisableFeature",  
        "WithFeature", 
        "GetBetaFeatures",
        "SetBetaFeatureState"
    })
end

--[[ Called to handle shutting down the features ]]
function Features:Shutdown()
    self.features = {}
end

--[[ Returns all the beta features ]]
function Features:GetBetaFeatures()
    local beta = {}
    for name, feature in pairs(Addon.Features or {}) do
        if (IsBetaFeature(feature)) then
            table.insert(beta, {
                id = string.lower(name),
                name = feature.NAME or name,
                description = feature.DESCRIPTION or "",
                eanbled = self.features[string.lower(name)] ~= nil
            })
        end
    end
    return beta
end

--[[ Change the state of a beta feature ]]
function Features:SetBetaFeatureState(name, state)
    local beta = Addon:GetAccountSetting("BetaFeatures", {})
    beta[string.lower(name)] = state or false
    Addon:SetAccountSetting("BetaFeatures", beta)

end

function Features:GetFeature(feature)
    return self.features[string.lower(feature)]
end

function Features:IsFeatureEnabled(name)
    return self.features[string.lower(name)] ~= nil
end

function Features:EnableFeature(name)

    local component = compMgr:Get("feature:" .. string.lower(name))
    if (component ~= nil) then
        return
    end

    name = string.lower(name)
    for fname, feature in pairs(Addon.Features) do
        if (string.lower(fname) == name) then
            compMgr:Create(self:CreateComponent(name, feature))
            compMgr:InitializeComponents()
            break;
        end
    end
end

function Features:DisableFeature(name)

    local componentName = "feature:" .. string.lower(name)
    local component = compMgr:Remove(componentName)
end

function Features:WithFeature(name, callback)
    local feature = self.features[string.lower(name)]
    if (not feature) then
        error("There is no feature '" .. tostring(name) .. "'")
    end

    -- todo handle enabled
    if (feature) then
        callback(feature)
    else
        feature.onready = feature.onready or {}
        table.insert(feature.onready, callback)
    end
end


Addon.Features = {}
Addon.Systems.Features = Features
Addon:GenerateEvents({ "OnFeatureDisabled", "OnFeatureEnabled", "OnFeatureReady", "OnFeaturesReady" })