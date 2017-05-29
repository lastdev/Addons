if not (_G.UnifiedTankFrames_Sources and type(_G.UnifiedTankFrames_Sources) == "table") then
	_G.UnifiedTankFrames_Sources = {}
end

local source = {
	name = "BlizzRole",
	description = "Show Blizzard Tank Roles",
	default = true,
	enabled = false,
	onEnable = function(self, addon)
		self.enabled = true
		self.raid = 0
		self.party = 0
		self.list = {}
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
		self.party = 0
		self.list = {}
		return true
	end,
	onInit = function(self, addon)
		return true
	end,
	onReSync = function(self, addon)
		addon:ClearTanks(self.name)
		self.raid = 0
		self.party = 0
		self.list = {}
		local func = self.events["GROUP_ROSTER_UPDATE"]
		func(self, addon, "GROUP_ROSTER_UPDATE")
		return true
	end,
	GetUnitNameEx = function(self, unit)
		local name, realm = UnitName(unit)
		-- check if we are in a party group and if the given player is a cross realm player
		if self.raid == 0 and self.party > 0 and name and realm then
			-- ok we are in a party but not a raid and its a cross realm player, so append the realm name
			name = name.."-"..realm
		end
		return name
	end,
	CheckPartyRoles = function(self, addon) 
		if self.party > 0 then
			local new = {}
			local role = UnitGroupRolesAssigned("player")
			local name = UnitName("player")
			if name then
				if role == "TANK" then
					new[name] = role
					if self.list[name] == nil then
						addon:AddTank(name, "BlizzRole")
					end
				end
			end
			for i=1, MAX_PARTY_MEMBERS do
				role = UnitGroupRolesAssigned("party"..i)
				local name = self:GetUnitNameEx("party"..i)
				if name then
					if role == "TANK" then
						new[name] = role
						if self.list[name] == nil then
							addon:AddTank(name, "BlizzRole")
						end
					end
				end
			end
			for n,p in pairs(self.list) do
				if new[n] == nil then
					addon:RemoveTank(n, "BlizzRole")
				end
			end
			self.list = new;
		end
	end,
	CheckRaidRoles = function(self, addon) 
		if self.raid > 0 then
			for i=1, MAX_RAID_MEMBERS do
				local role = UnitGroupRolesAssigned("raid"..i)
				local name = UnitName("raid"..i)
				if name then
					if role == "TANK" then
						addon:AddTank(name, "BlizzRole")
					end
				end
			end
		end
	end,
	events = {
		["ROLE_CHANGED_INFORM"] = function(self, addon, event, target, source, old, new)
			local name = self:GetUnitNameEx(target)
			if name then
				if new == "TANK" then
					addon:AddTank(name, "BlizzRole")
					self.list[name] = "TANK"
				elseif old == "TANK" then
					addon:RemoveTank(name, "BlizzRole")
					self.list[name] = nil
				end
			end
		end,
		["GROUP_ROSTER_UPDATE"] = function(self, addon, event) 
            local n = GetNumGroupMembers()
            self.party = n
            if self.raid == 0 and self.party == 0 then
                addon:ClearTanks("BlizzRole")
                self.list = {};
            elseif self.raid == 0 then
                self:CheckPartyRoles(addon)
            end
		end,
	},
	list = {},
	raid = 0,
	party = 0,
	config = nil,
}

if _G.UnifiedTankFrames_Sources[source.name] == nil then
	_G.UnifiedTankFrames_Sources[source.name] = source
else
	error("A UnifiedTankFrames module with name '"..source.name.."' already exists!")
end