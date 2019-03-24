if not (_G.UnifiedTankFrames_Sources and type(_G.UnifiedTankFrames_Sources) == "table") then
	_G.UnifiedTankFrames_Sources = {}
end

source = {
	name = "Self",
	description = "Show Yourself (e.g. to Test Settings)",
	default = false,
	enabled = false,
	onEnable = function(self, addon)
		self.enabled = true
		addon:AddTank(UnitName("player"), "Self")
		return true
	end,
	onDisable = function(self, addon)
		self.enabled = false
		addon:ClearTanks(self.name)
		return true
	end,
	onInit = function(self, addon)
		return true
	end,
	events = {},
	config = nil,
}

if _G.UnifiedTankFrames_Sources[source.name] == nil then
	_G.UnifiedTankFrames_Sources[source.name] = source
else
	error("A UnifiedTankFrames module with name '"..source.name.."' already exists!")
end
