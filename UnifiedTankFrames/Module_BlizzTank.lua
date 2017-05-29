if not (_G.UnifiedTankFrames_Sources and type(_G.UnifiedTankFrames_Sources) == "table") then
	_G.UnifiedTankFrames_Sources = {}
end

local source = {
	name = "BlizzTank",
	description = "Show Blizzard Tanks",
	default = true,
	enabled = false,
	onEnable = function(self, addon)
		self.enabled = true
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
		self.list = {}
		return true
	end,
	onInit = function(self, addon, db)
		for key,val in pairs(self.config) do
			if db[key] == nil then
				db[key] = val
			end
		end
		self.config = db
		return true
	end,
	onReSync = function(self, addon)
		addon:ClearTanks(self.name)
		self.list = {}
		local func = self.events["GROUP_ROSTER_UPDATE"]
		func(self, addon, "GROUP_ROSTER_UPDATE")
		return true
	end,
	events = {
		["GROUP_ROSTER_UPDATE"] = function(self, addon)
			local num = 0
			local new = {}
			for i=1, MAX_RAID_MEMBERS do
				--local name, rank, subgroup, level, class, fileName, zone, online, isDead, role = GetRaidRosterInfo(i);
				local name, _, _, _, _, _, _, _, _, role = GetRaidRosterInfo(i);
				--local name, realm = UnitName("raid"..i)
				if (self.config.mainTank and role == "MAINTANK") or (self.config.mainAssist and role == "MAINASSIST") then
					num = num + 1
					new[name] = role
					if self.list[name] == nil then
						addon:AddTank(name, "BlizzTank", num)
					end
				end
			end
			for n,p in pairs(self.list) do
				if new[n] == nil then
					addon:RemoveTank(n, "BlizzTank")
				end
			end
			self.list = new;
		end,
	},
	list = {},
	config = {
		mainTank = true,
		mainAssist = true,
		--roleSort = true,
	},
	L = {
		mainTank = MAIN_TANK,
		mainAssist = MAIN_ASSIST,
	},
}

if _G.UnifiedTankFrames_Sources[source.name] == nil then
	_G.UnifiedTankFrames_Sources[source.name] = source
else
	error("A UnifiedTankFrames module with name '"..source.name.."' already exists!")
end