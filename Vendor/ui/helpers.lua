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


-- Add table.forEach
if (type(table.forEach) ~= "function") then
	table.forEach = function(t, c, ...) 
		assert(type(t) == "table");
        assert(type(c) == "function");
        if (t and table.getn(t)) then
			for k, v in pairs(t) do
                xpcall(c, CallErrorHandler, v, k, ...);
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
		if (not t) then
			return nil;
		end

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
		local f = {};
		if (not t) then
			return f;
		end

		assert(type(t) == "table");
		assert(type(p) == "function");
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