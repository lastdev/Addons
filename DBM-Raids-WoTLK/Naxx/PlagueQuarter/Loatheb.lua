local mod	= DBM:NewMod("Loatheb", "DBM-Raids-WoTLK", 8)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241103133102")
mod:SetCreatureID(16011)
mod:SetEncounterID(1115)
mod:SetModelID(16110)
mod:SetZone(533)

mod:RegisterCombat("combat")--Maybe change to a yell later so pull detection works if you chain pull him from tash gauntlet

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 29234 29204 30281 55052 55593",
	"UNIT_DIED"
)

local warnSporeNow			= mod:NewCountAnnounce(29234, 2, "134530")
local warnSporeSoon			= mod:NewSoonAnnounce(29234, 1, "134530")
local warnDoomNow			= mod:NewCountAnnounce(29204, 3)
local warnRemoveCurse		= mod:NewSpellAnnounce(30281, 3)
local warnHealSoon			= mod:NewAnnounce("WarningHealSoon", 4, 55593, nil, nil, nil, 55593)
local warnHealNow			= mod:NewAnnounce("WarningHealNow", 1, 55593, false, nil, nil, 55593)

local timerSpore			= mod:NewNextCountTimer(36, 29234, nil, nil, nil, 5, "134530", DBM_COMMON_L.DAMAGE_ICON)
local timerDoom				= mod:NewNextCountTimer(180, 29204, nil, nil, nil, 2)
--local timerRemoveCurseCD	= mod:NewNextTimer(30.8, 30281, nil, nil, nil, 5)
local timerAura				= mod:NewBuffActiveTimer(17, 55593, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)

mod.vb.doomCounter	= 0
mod.vb.sporeTimer	= 35.5
mod.vb.sporeCounter = 0

function mod:OnCombatStart(delay)
	self.vb.doomCounter = 0
	self.vb.sporeCounter = 0
--	timerRemoveCurseCD:Start(3 - delay)
	if self:IsDifficulty("normal25") then
		self.vb.sporeTimer = 16
		timerDoom:Start(90 - delay, 1)
	else
		self.vb.sporeTimer = 35.5
		timerDoom:Start(120 - delay, 1)
	end
	timerSpore:Start(self.vb.sporeTimer - delay, 1)
	warnSporeSoon:Schedule(self.vb.sporeTimer - 5 - delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 29234 then
		self.vb.sporeCounter = self.vb.sporeCounter + 1
		timerSpore:Start(self.vb.sporeTimer, self.vb.sporeCounter+1)
		warnSporeNow:Show(self.vb.sporeCounter)
		warnSporeSoon:Schedule(self.vb.sporeTimer - 5)
	elseif args:IsSpellID(29204, 55052) then
		self.vb.doomCounter = self.vb.doomCounter + 1
		local timer = 29
		if self.vb.doomCounter >= 7 then
			if self.vb.doomCounter % 2 == 0 then
				timer = 17
			else
				timer = 12
			end
		end
		warnDoomNow:Show(self.vb.doomCounter)
		timerDoom:Start(timer, self.vb.doomCounter + 1)
	elseif args.spellId == 30281 then
		warnRemoveCurse:Show()
--		timerRemoveCurseCD:Start()
	elseif args.spellId == 55593 then
		timerAura:Start()
		warnHealSoon:Schedule(14)
		warnHealNow:Schedule(17)
	end
end

--because in all likelyhood, pull detection failed (cause 90s like to charge in there trash and all and pull it
--We unschedule the pre warnings on death as a failsafe
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 16011 then
		warnSporeSoon:Cancel()
--		warnHealSoon:Cancel()
--		warnHealNow:Cancel()
	end
end
