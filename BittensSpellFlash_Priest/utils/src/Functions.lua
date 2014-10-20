local u = BittensGlobalTables.GetTable("BittensUtilities")
if u.SkipOrUpgrade(u, "Functions", 1) then
	return
end

local unpack = unpack

function u.Call(func, ...)
	if func then
		return func(...)
	end
end

function u.NoOp() end

function u.WrapFunction(func, ...)
	local args = { ... }
	return function()
		func(unpack(args))
	end
end
