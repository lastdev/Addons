-- The list of available rare tracker addons.
local rare_tracker_addons = {
	"RareTrackerCore", 
	"RareTrackerMechagon", 
	"RareTrackerNazjatar", 
	"RareTrackerUldum", 
	"RareTrackerVale", 
	"RareTrackerWorldBosses", 
	"RareTrackerMaw"
}

-- Simply check whether all addons are installed. If not, warn the user!
for _, addon_name in pairs(rare_tracker_addons) do
	local _, _, _, _, reason, _, _ = GetAddOnInfo(addon_name)
	if reason == "MISSING" then
		-- print("Missing the module", addon_name)
	end
end

