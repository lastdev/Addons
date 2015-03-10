local g = BittensGlobalTables
local u = g.GetOrMakeTable("BittensUtilities", 6)

local function skipOrUpgrade(table, feature, version)
	local vName = feature .. "Version"
	if table[vName] and table[vName] >= version then
		return "Skip"
	else
		table[vName] = version
	end
end 

if skipOrUpgrade(u, "Table Management", 1) then
	return
end

local next = next
local pairs = pairs
local print = print
local select = select
local wipe = wipe

function u.SkipOrUpgrade(table, feature, version)
	return skipOrUpgrade(table, feature, version)
end

function u.GetFromTable(outerTable, ...)
	for i = 1, select("#", ...) do
		if outerTable == nil then
			return nil
		end
		local key = select(i, ...)
		outerTable = outerTable[key]
	end
	return outerTable
end

function u.GetOrMakeTable(outerTable, ...)
	for i = 1, select("#", ...) do
		local key = select(i, ...)
		if outerTable[key] == nil then
			outerTable[key] = {}
		end
		outerTable = outerTable[key]
	end
	return outerTable
end

function u.MagicallyIncrement(table, variable)
	local val = (table[variable] or 0) + 1
	table[variable] = val
	return val
end

function u.ShallowCopy(source, dest)
	if dest then
		wipe(dest)
	else
		dest = { }
	end
	for k, v in pairs(source) do
		dest[k] = v
	end
	return dest
end

function u.Pairs(table)
	if not table then
		return u.NoOp
	end
	
	local k, v
	return function()
		k, v = next(table, k)
		return k, v
	end
end

function u.Keys(table)
	local iterator = u.Pairs(table)
	return function()
		local k, v = iterator()
		return k
	end
end

function u.Values(table)
	local iterator = u.Pairs(table)
	return function()
		local k, v = iterator()
		return v
	end
end

function u.PrintTable(table)
	if not table then
		print("table is nil")
		return
	end
	
	local empty = true
	for k, v in pairs(table) do
		print(k, v)
		empty = false
	end
	
	if empty then
		print("table is empty")
	end
end

function u.Size(table)
	local size = 0
	for _, _ in pairs(table) do
		size = size + 1
	end
	return size
end
