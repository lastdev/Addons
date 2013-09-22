local g = BittensGlobalTables
local u = g.GetTable("BittensUtilities")
if u.SkipOrUpgrade(u, "Scheduling", 2) then
	return
end

local GetTime = GetTime
local unpack = unpack

-- { Time = number, Func = function, Args = table }

local heap = u.CreateHeap(function(a, b)
	return a.Time - b.Time
end)

local frame = CreateFrame("Frame")
frame:SetScript("OnUpdate", function()
	local head = heap.Peek()
	if head and head.Time <= GetTime() then
		heap.Pop().Func(unpack(head.Args))
		if heap.IsEmpty() then
			frame:Hide()
		end
	end
end)

function u.Schedule(delay, func, ...)
	heap.Push({ Time = GetTime() + delay, Func = func, Args = { ... } })
	frame:Show()
end
