local _, Addon = ...;

-- Check if the character is a space
local function isspace(c)
    return (c == '\n') or (c == '\t') or (c == '\r') or (c == ' ');
end

-- Trim the front of a string
if (type(string.ltrim) ~= "function") then
    string.ltrim = function(str)
        local s = 1;
        local l = string.len(str);

        while (isspace(string.sub(str, s, s)) and s <= l) do
            s = s + 1;
        end

        return string.sub(str, s, l);
    end
end

-- Trim the end of a string
if (type(string.rtrim) ~= "function") then
    string.rtrim = function(str)
        local e = string.len(str);
        while (isspace(string.sub(str, e, e)) and (e >= 1)) do
            e = e - 1;
        end
        return string.sub(str, 1, e);
    end
end

-- Trim both the front and end of a string.
if (type(string.trim) ~= "function") then
    string.trim = function(str) 
        return string.ltrim(string.rtrim(str));
    end
end

-- Add string splitting based on the specified delimiter.
if (type(string.split) ~= "function") then
    string.split = function(str, delim) 
        local result = {};
        for match in (str .. delim):gmatch("(.-)" .. delim) do
            table.insert(result, match);
        end
        return result;
    end
end

-- Add table.forEach
if (type(table.forEach) ~= "function") then
    table.forEach = function(t, c, ...) 
        if (t) then
            assert(type(t) == "table");
            assert(type(c) == "function");
            if (t and table.getn(t)) then
                for k, v in pairs(t) do
                    xpcall(c, CallErrorHandler, v, k, ...);
                end
            end
        end
    end;
end

-- Add table.hasKey
if (type(table.hasKey) ~= "function") then
    table.hasKey = function(t, k)
        return (t[k] ~= nil);
    end
end

-- Add table.find
if (type(table.find) ~= "function") then
    table.find = function(t, p, ...)
        assert(type(t) == "table");
        assert(type(p) == "function");
        for k, v in pairs(t) do
            local r, f = xpcall(p, CallErrorHandler, v, k, ...);
            if (r and f) then
                return v, k
            end
        end
        return nil;
    end
end

-- Add table.filter
if (type(table.filter) ~= "function") then
    table.filter = function(t, p, ...)
        assert(type(t) == "table");
        assert(type(p) == "function");
        local f = {};
        for k, v in pairs(t) do
            local r, f = xpcall(p, CallErrorHandler, v, k, ...);
            if (r and f) then
                f[k] = v;
            end
        end
        return f;
    end
end

-- Add table.copy
if (type(table.copy) ~= "function") then
    table.copy = function(t)
        assert(type(t) == "table");
        return Addon.DeepTableCopy(t);
    end
end

-- Add table.merge
if (type(table.merge) ~= "function") then
    table.merge = function(...)
        local r = {};
        local args = { ... };
        for _, s in ipairs(args) do 
            if (type(s) == "table") then
                for k, v in pairs(s) do
                    r[k] = v;
                end
            end
        end
        return r;
    end
end

-- Gets character name with spaces for pretty-printing.
local characterName = nil
function Addon:GetCharacterFullName()
    if not characterName then
        local name, server = UnitFullName("player")
        characterName = string.format("%s - %s", name, server)
    end
    return characterName
end

-- Helper function for invoking a method on the specified object,
-- if the function doesn't exist this does nothing, otherwise it
-- invokes the function and wraps it.
function Addon.Invoke(object, method, ...)
    if (type(object) == "table") then
        local fn = object[method];
        if (type(fn) == "function") then
            local results = { xpcall(fn, CallErrorHandler, object, ...) };
            if (results[1]) then
                table.remove(results, 1);
                return unpack(results);
            elseif (not results[1] and results[2]) then
                Addon:Debug("errors", "Failed to invoke '%s': %s", method, results[2]);            
            end
        end 
    end
	return nil;
end