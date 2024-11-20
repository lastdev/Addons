if not (_G.UnifiedTankFrames_Sources and type(_G.UnifiedTankFrames_Sources) == "table") then
	_G.UnifiedTankFrames_Sources = {}
end

local source = nil

local function updateTanks(event, tanks)
	if not source.enabled then return end
	local new = {}
	for i, name in pairs(tanks) do
		new[name] = i
		if source.list[name] == nil then
			source.addon:AddTank(name, "oRA3", num)
		end
	end
		
	for n,p in pairs(source.list) do
		if new[n] == nil then
			source.addon:RemoveTank(n, "oRA3")
		end
	end
	source.list = new;
end

source = {
	name = "oRA3",
	description = "Show oRA3 Tanks",
	default = false,
	enabled = false,
	onEnable = function(self, addon)
		self.enabled = true
		self.list = {}
		if (oRA3) then
			oRA3.RegisterCallback(self, "OnTanksUpdated", updateTanks)
			updateTanks(nil, oRA3:GetSortedTanks())
		end
		return true
	end,
	onDisable = function(self, addon)
		self.enabled = false
		addon:ClearTanks(self.name)
		self.list = {}
		if (oRA3) then
			oRA3.UnregisterCallback(self, "OnTanksUpdated")
		end
		return true
	end,
	onInit = function(self, addon)
		self.addon = addon
		return true
	end,
	onReSync = function(self, addon)
		addon:ClearTanks(self.name)
		self.list = {}
		if (oRA3) then
			updateTanks(nil, oRA3:GetSortedTanks())
		end
		return true
	end,
	events = {},
	list = {},
	config = nil,
}

if _G.UnifiedTankFrames_Sources[source.name] == nil then
	_G.UnifiedTankFrames_Sources[source.name] = source
else
	error("A UnifiedTankFrames module with name '"..source.name.."' already exists!")
end
