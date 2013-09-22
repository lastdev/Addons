local g = BittensGlobalTables
local u = g.GetTable("BittensUtilities")
if u.SkipOrUpgrade(u, "Event Handlers", 1) then
	return
end

local CreateFrame = CreateFrame

local eventToCustom = { }
local customToEvent = { }
local customFilters = { }

local function registerCustomEvent(customName, eventName, filter)
	eventToCustom[eventName] = customName
	customToEvent[customName] = eventName
	customFilters[customName] = filter
end

registerCustomEvent(
	"MY_ADDON_LOADED", 
	"ADDON_LOADED", 
	function(addonName, loadedAddonName)
		return addonName == loadedAddonName
	end)
registerCustomEvent(
	"MY_SPECIALIZATION_CHANGED", 
	"PLAYER_SPECIALIZATION_CHANGED",
	function(addonName, unit)
		return unit == "player"
	end)

-- "addonName" is only needed if using the special MY_ADDON_LOADED event.
function u.RegisterEventHandler(handler, addonName)
	local frame = CreateFrame("frame")
	for event in u.Keys(handler) do
		local translated = customToEvent[event]
		if translated then
			if not handler[translated] then
				frame:RegisterEvent(translated)
			end
		else
			frame:RegisterEvent(event)
		end
	end
	frame:SetScript("OnEvent", function(self, event, ...)
		u.Call(handler[event], ...)
		local custom = eventToCustom[event]
		if custom and customFilters[custom](addonName, ...) then
			u.Call(handler[custom], ...)
		end
	end)
end
