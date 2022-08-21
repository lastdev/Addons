local UnitExists, UnitName, IsInRaid = UnitExists, UnitName, IsInRaid
local UnitGroupRolesAssigned, UnitGetAvailableRoles, UnitHealthMax = UnitGroupRolesAssigned, UnitGetAvailableRoles, UnitHealthMax
local GetNumGroupMembers, GetPartyAssignment = GetNumGroupMembers, GetPartyAssignment
local _G, format = _G, format

function MDH:ClearTarget(button)
	if button == "LeftButton" then
		self.db.profile.target = nil
		self.db.profile.name = nil
	else
		self.db.profile.target2 = nil
		self.db.profile.name2 = nil
	end
	self:MDHEditMacro()
	self:MDHShowToolTip()
end

function MDH:ToT(button)
	if button == "LeftButton" then
		self.db.profile.target = "targettarget"
		self.db.profile.name = self:validateTarget("targettarget")
	else
		self.db.profile.target2 = "targettarget"
		self.db.profile.name2 = self:validateTarget("targettarget")
	end
	self:MDHEditMacro()
	self:MDHShowToolTip()
end

function MDH:PlayerPet(button)
	if UnitExists("pet") then self:MDHgetpet() end
	if button == "LeftButton" then
		self.db.profile.target = "pet"
		self.db.profile.name = self.db.profile.petname
	else
		self.db.profile.target2 = "pet"
		self.db.profile.name2 = self.db.profile.petname
	end
	self:MDHEditMacro()
	self:MDHShowToolTip()
end

function MDH:PartyTank(button)
	self:MDHtank(button)
	self:MDHEditMacro()
	self:MDHShowToolTip()
end

function MDH:MDHfocus(button)
	if button == "LeftButton" then
		self.db.profile.target = "focus"
		self.db.profile.name = self:validateTarget("focus")
	else
		self.db.profile.target2 = "focus"
		self.db.profile.name2 = self:validateTarget("focus")
	end
	self:MDHEditMacro()
	self:MDHShowToolTip()
end

function MDH:MDHtarget(button)
	if button == "LeftButton" then
		self.db.profile.target = self:validateTarget("target")
		self.db.profile.name = self:validateTarget("target")
	else
		self.db.profile.target2 = self:validateTarget("target")
		self.db.profile.name2 = self:validateTarget("target")
	end
	self:MDHEditMacro()
	self:MDHShowToolTip()
end

function MDH:MDHHover()
	MDH.db.profile.target3 = not MDH.db.profile.target3
	MDH:MDHEditMacro()
	MDH:MDHShowToolTip()
end
		
function MDH:MDHtank(button)
	local members = GetNumGroupMembers()
	local mt, mth, canBeTank, maxHealth
	local prefix = IsInRaid() and "raid" or "party"
	if members == 0 then return end
	for member = 1, _G.MAX_RAID_MEMBERS do
		local unit = format("%s%d", prefix, member)
		local name = UnitName(unit)
		if name then
			local tank = GetPartyAssignment("MAINTANK", unit) or (UnitGroupRolesAssigned(unit) == "TANK")
			if not tank then canBeTank = UnitGetAvailableRoles(unit)
				if canBeTank then maxHealth = UnitHealthMax(unit)
					if maxHealth > (mth or 0) then
						mth = maxHealth
						mt = name
					end
				end
			else
				mt = name
				break
			end
		end
	end
	if mt then
		--print("Tank found:", mt)
		if button == "LeftButton" then
			self.db.profile.target = mt
			self.db.profile.name = mt
		else
			self.db.profile.target2 = mt
			self.db.profile.name2 = mt
		end
	else --print("No tank found")
	end
end

