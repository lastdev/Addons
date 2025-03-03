-- Useful helper functions prior to other files loading. Ideally this is the first file loaded after Localization, right before Config
local AddonName, Addon = ...

function Addon:IsShadowlands()
    return Addon.Systems.Info.Build.InterfaceVersion >= 90000
end

-- Gets the version of the addon
function Addon:GetVersion()
    local version = Addon:GetAddOnMetadata(AddonName, "version")
    if (Addon.IsDebug) then
        if version == "6.1.2-67-g761b8f9" then
            version = "Debug"
        else
            version = "Debug "..version
        end
    end
    return version
end

-- Counts size of the table
function Addon:TableSize(T)
    local count = 0
    if (T) then
        for _ in pairs(T) do count = count + 1 end
    end
    return count
end

-- Merges the contents of source into dest, source can be nil
function Addon:MergeTable(dest, source)
    if source then
        for key, value in pairs(source) do
            rawset(dest, key, value)
        end
    end
end

-- Table deep copy, as seen on StackOverflow
-- https://stackoverflow.com/questions/640642/how-do-you-copy-a-lua-table-by-value
function Addon.DeepTableCopy(obj, seen)
    if type(obj) ~= 'table' then return obj end
    if seen and seen[obj] then return seen[obj] end

    local s = seen or {}

    local res = {}
    if (type(getmetatable(obj)) == "table") then
        setmetatable({}, getmetatable(obj))
    end

    s[obj] = res
    for k, v in pairs(obj) do res[Addon.DeepTableCopy(k, s)] = Addon.DeepTableCopy(v, s) end
    return res
end

-- Deep Table Copy without copying the metatable
function Addon.DeepTableCopyNoMeta(obj, seen)
    if type(obj) ~= 'table' then return obj end
    if seen and seen[obj] then return seen[obj] end

    local s = seen or {}
    local res = {}
    s[obj] = res
    for k, v in pairs(obj) do res[Addon.DeepTableCopy(k, s)] = Addon.DeepTableCopy(v, s) end
    return res
end


local TypeInformation = {};

--[[===========================================================================
   | Create a new "class" which may or may not raise events.  
   ==========================================================================]]
function Addon.object(typeName, instance, API, events)
    local fullName = string.format("%s.%s", AddonName, typeName);
    local fullApi = rawget(TypeInformation, fullName);

    if (type(instance) ~= "table") then
        instance = {}
    end

    if (not fullApi) then
        if (type(events) == "table") then
            fullApi = CreateFromMixins(CallbackRegistryMixin)
        else
            fullApi = {}
        end

        -- Copy the functions over the API
        for name, value in pairs(API) do
            if (type(value) == "function" and string.find(name, "__") ~= 0) then
                fullApi[name] = value;
            else

            end
        end

        rawset(TypeInformation, fullName, fullApi);
    end

    -- If the object has events, then register them
    if (type(events) == "table") then
        CallbackRegistryMixin.OnLoad(instance);
        CallbackRegistryMixin.SetUndefinedEventsAllowed(instance, false);
        CallbackRegistryMixin.GenerateCallbackEvents(instance, events);
    end
    
    local object = nil
    if (Addon.IsDebug) then
        local thunk = {};
        object = setmetatable(thunk, {
            __metatable = fullName,
            __index = function(self, key)
                -- Check for a member function
                local member = rawget(fullApi, key);
                if (type(member) == "function") then
                    return function(...) 
                            return member(...);
                        end;
                else
                    member = rawget(instance, key);
                    if (member ~= nil) then
                        return member;
                    end

                    error(string.format("Type '%s' has no member '%s'", typeName, key));
                end
            end,
            __newindex = function(self, key, value)
                -- Don't allow new fields/members that didn't exist when
                -- we were created.
                if (rawget(instance, key) == nil) then
                    error(string.format("New members are not allowed on '%s' attempted to set '%s'", typeName, key));                
                else
                    rawset(instance, key, value);
                end
            end,
        })
    else
        object = setmetatable(instance, {
            __metatable = fullName,
            __index = fullApi,
        });
    end

    local ctor = rawget(API, "__construct")
    if (type(ctor) == "function") then
        ctor(instance)
    end

    return object
end