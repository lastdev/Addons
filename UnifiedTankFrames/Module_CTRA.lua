if not (_G.UnifiedTankFrames_Sources and type(_G.UnifiedTankFrames_Sources) == "table") then
	_G.UnifiedTankFrames_Sources = {}
end

local source = {
	name = "CTRA",
	description = "Show CTRA and oRA2 Tanks",
	default = true,
	enabled = false,
	onEnable = function(self, addon)
		self.enabled = true
		self.raid = 0
		if RegisterAddonMessagePrefix then
			RegisterAddonMessagePrefix("CTRA")
		end
		addon:RegisterEventHandlers(self, self.events)
		local func = self.events["GROUP_ROSTER_UPDATE"]
		func(self, addon, "GROUP_ROSTER_UPDATE")
		return true
	end,
	onDisable = function(self, addon)
		self.enabled = false
		addon:UnregisterEventHandlers(self, self.events)
		addon:ClearTanks(self.name)
		self.raid = 0
		return true
	end,
	onInit = function(self, addon)
		return true
	end,
	onReSync = function(self, addon)
		addon:ClearTanks(self.name)
		self.raid = 0
		local func = self.events["GROUP_ROSTER_UPDATE"]
		func(self, addon, "GROUP_ROSTER_UPDATE")
		return true
	end,
	events = {
		["CHAT_MSG_ADDON"] = function(self, addon, event, prefix, message, distribution, sender)
			if prefix == "CTRA" then
				local _,_,num,name = string.find(message, "^SET (%d+) (.+)$")
				if name then
					local name = UnitName(name)
					addon:AddTank(name, "CTRA", num)
					return
				end
				_,_,name = string.find(message, "^R (.+)$")
				if name then
					local name = UnitName(name)
					addon:RemoveTank(name, "CTRA")
					return
				end
			end
		end,
		["GROUP_ROSTER_UPDATE"] = function(self, addon) 
			local n = GetNumGroupMembers()
			if self.raid == 0 and n > 1 then
				C_ChatInfo.SendAddonMessage("oRA", "GETMT", "RAID")
			end
			self.raid = n
		end,
	},
	raid = 0,
	config = nil,
}

if _G.UnifiedTankFrames_Sources[source.name] == nil then
	_G.UnifiedTankFrames_Sources[source.name] = source
else
	error("A UnifiedTankFrames module with name '"..source.name.."' already exists!")
end
