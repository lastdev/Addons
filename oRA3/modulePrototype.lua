local addon = LibStub("AceAddon-3.0"):GetAddon("oRA3")

local prototype = {}

function prototype:OnInitialize()
	if type(self.OnRegister) == "function" then
		self:OnRegister()
		self.OnRegister = nil
	end
end

function prototype:OnDisable()
	if type(self.OnModuleDisable) == "function" then
		self:OnModuleDisable()
	end
	self:UnregisterAllEvents()
end

addon:SetDefaultModulePrototype(prototype)

prototype.RegisterEvent = addon.RegisterEvent
prototype.UnregisterEvent = addon.UnregisterEvent
prototype.UnregisterAllEvents = addon.UnregisterAllEvents
prototype.SendComm = addon.SendComm
prototype.UnitName = addon.UnitName

do
	local raidList = {
		"raid1", "raid2", "raid3", "raid4", "raid5", "raid6", "raid7", "raid8", "raid9", "raid10",
		"raid11", "raid12", "raid13", "raid14", "raid15", "raid16", "raid17", "raid18", "raid19", "raid20",
		"raid21", "raid22", "raid23", "raid24", "raid25", "raid26", "raid27", "raid28", "raid29", "raid30",
		"raid31", "raid32", "raid33", "raid34", "raid35", "raid36", "raid37", "raid38", "raid39", "raid40"
	}
	local partyList = {"player", "party1", "party2", "party3", "party4"}
	local GetNumGroupMembers, IsInRaid = GetNumGroupMembers, IsInRaid
	--- Iterate over your group.
	-- Automatically uses "party" or "raid" tokens depending on your group type.
	-- @return iterator
	function prototype:IterateGroup()
		local num = GetNumGroupMembers() or 0
		local i = 0
		local size = num > 0 and num+1 or 2
		local function iter(t)
			i = i + 1
			if i < size then
				return t[i]
			end
		end
		return iter, IsInRaid() and raidList or partyList
	end
end

do
	local UnitAura = C_UnitAuras.GetAuraDataByIndex
	--- Get the buff info of a unit.
	-- @string unit unit token or unit name
	-- @string list the table full of buff names to scan for
	-- @return spellName, expirationTime, spellId
	function prototype:UnitBuffByNames(unit, list)
		local num = #list
		for i = 1, 100 do
			local aura = UnitAura(unit, i, "HELPFUL")
			if not aura then return end

			for j = 1, num do
				if list[j] == aura.name then
					return aura.name, aura.expirationTime, aura.spellId
				end
			end
		end
	end

	--- Get the buff info of a unit.
	-- @string unit unit token or unit name
	-- @string list the table full of spell IDs to scan for
	-- @return spellName, expirationTime, spellId
	function prototype:UnitBuffByIDs(unit, list)
		local num = #list
		for i = 1, 100 do
			local aura = UnitAura(unit, i, "HELPFUL")
			if not aura then return end

			for j = 1, num do
				if list[j] == aura.spellId then
					return aura.name, aura.expirationTime, aura.spellId
				end
			end
		end
	end
end
