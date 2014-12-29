local VERSION = 1
local g = BittensGlobalTables
if g == nil then
	g = { Tables = { }, Versions = { }, Proxies = { } }
	BittensGlobalTables = g
elseif g.Version >= VERSION then
	return
end
g.Version = VERSION

local setmetatable = setmetatable

local tables = g.Tables
local versions = g.Versions
local proxies = g.Proxies
local proxyMetaTable = {
	__index = function(t, k)
		return tables[t.Name][k]
	end,
	
	__newindex = function(t, k, v)
		tables[t.Name][k] = v
	end
}

function g.GetTable(name)
	return proxies[name]
end

-- If the table didn't exist, returns:
--   new table
-- If it did, and no update is necessary, returns:
--   nil
-- If it did, and an update is necessary, returns:
--   new table, old table, old version
function g.MakeTable(name, version)
	local oldTable = tables[name]
	if not oldTable then
		--print("creating", name, version)
		local proxy = { Name = name }
		setmetatable(proxy, proxyMetaTable)
		tables[name] = { }
		versions[name] = version
		proxies[name] = proxy
		return proxy
	elseif versions[name] < version then
		--print("upgrading", name, "from", versions[name], "to", version)
		local oldVersion = versions[name]
		tables[name] = { }
		versions[name] = version
		return proxies[name], oldTable, oldVersion
	end
	--print("skipping", name, "from", versions[name], "to", version)
end

-- If the table didn't exist, returns:
--   new table
-- If it did, and no update is necessary, returns:
--   old table
-- If it did, and an update is necessary, returns:
--   new table, old table, old version
function g.GetOrMakeTable(name, version)
	local table, oldTable, oldVersion = g.MakeTable(name, version)
	if table then
		return table, oldTable, oldVersion
	else
		return g.GetTable(name)
	end
end
