local mod	= DBM:NewMod(154, "DBM-Raids-Cata", 3, 75)
local L		= mod:GetLocalizedStrings()
local Anshal	= DBM:EJ_GetSectionInfo(3166)
local Nezir		= DBM:EJ_GetSectionInfo(3178)
local Rohash	= DBM:EJ_GetSectionInfo(3172)

mod:SetRevision("20241103125714")
mod:SetCreatureID(45870, 45871, 45872)
mod:SetEncounterID(1035)
mod:SetZone(754)
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 86205 86192",
	"SPELL_CAST_SUCCESS 85422 86082 84638 84643 84644 93059 86281 84645 86193",
	"SPELL_AURA_APPLIED 86182 84651",
	"SPELL_AURA_APPLIED_DOSE 84651",
	"SPELL_AURA_REMOVED 84638 84643 84644",
	"SPELL_DAMAGE 86111",
	"SPELL_MISSED 86111",
	"UNIT_POWER_UPDATE boss1 boss2 boss3",
	"RAID_BOSS_EMOTE"
)

--TODO, if cata classic happens, the tech on this should be redone to start all timers but use fading by distance, not just omit timers if you forget to target boss (bad obsolete tech)
--TODO, if boss unit ids work and apis for checking distance to boss work. deprecate warn for my target and instead do warnings based on boss proximity
local warnNurture			= mod:NewSpellAnnounce(85422, 3)
local warnSoothingBreeze	= mod:NewTargetNoFilterAnnounce(86207, 3)	-- using a spellID here with a better description of the spell
local warnSummonTornados	= mod:NewSpellAnnounce(86192, 3)
local warnWindBlast			= mod:NewSpellAnnounce(86193, 3)
--local warnStormShield		= mod:NewSpellAnnounce(93059, 3)
local warnPoisonToxic	 	= mod:NewSpellAnnounce(86281, 3)
local warnGatherStrength	= mod:NewTargetNoFilterAnnounce(86307, 4)
local warnSpecialSoon		= mod:NewAnnounce("warnSpecialSoon", 2, "132866")--Hurricane/Sleet Storm/Zephyr in single announce

local specWarnSpecial		= mod:NewSpecialWarning("specWarnSpecial", nil, nil, nil, 2, 2)
local specWarnShield		= mod:NewSpecialWarningSpell(93059, nil, nil, nil, 1, 2)
local specWarnWindBlast		= mod:NewSpecialWarningDodge(86193, nil, nil, nil, 2, 16)
local specWarnGTFO			= mod:NewSpecialWarningGTFO(86111, nil, nil, nil, 1, 8)

local timerNurture			= mod:NewNextTimer(35, 85422, nil, nil, nil, 1)--This this is typically 35 seconds after a special has ended.
local timerWindChill		= mod:NewNextTimer(10.5, 84645, nil, false, nil, 2)
local timerSlicingGale		= mod:NewBuffFadesTimer(45, 86182, nil, false, nil, 2)
local timerWindBlast		= mod:NewBuffActiveTimer(11.5, 86193, nil, nil, nil, 6)
local timerWindBlastCD		= mod:NewCDTimer(60, 86193, nil, nil, nil, 3)-- Cooldown: 1st->2nd = 22sec || 2nd->3rd = 60sec || 3rd->4th = 60sec ?
local timerStormShieldCD	= mod:NewCDTimer(35, 93059, nil, nil, nil, 5, nil, DBM_COMMON_L.HEROIC_ICON)--Heroic ability, seems to have a 35-40second cd and no longer syncs up to nurture since the windblast change. No longer consistent.
local timerGatherStrength	= mod:NewTargetTimer(60, 86307, nil, nil, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerPoisonToxic		= mod:NewBuffActiveTimer(5, 86281, nil, nil, nil, 5)
local timerPoisonToxicCD	= mod:NewCDTimer(21, 86281, nil, nil, nil, 2)--is this a CD or a next timer?
local timerPermaFrostCD		= mod:NewCDTimer(10, 86081, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerSoothingBreezeCD	= mod:NewNextTimer(32.5, 86205, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerSpecial			= mod:NewTimer(95, "timerSpecial", "132866", nil, nil, 6)--hurricane/Sleet storm/Zephyr share CD. Shortened cause sometimes slipstreams end early, even though cd is a little longer
local timerSpecialActive	= mod:NewTimer(15, "timerSpecialActive", "132866", nil, nil, 6)

local enrageTimer			= mod:NewBerserkTimer(480) -- Both normal and heroic mode

mod:AddBoolOption("OnlyWarnforMyTarget", false, "announce")--Default off due to targeting dependance (not great for healers who don't set focus). Has ability to filter all timers/warnings for bosses you are not targeting or focusing.

mod.vb.windBlastCounter = 0
mod.vb.poisonCounter = 0
mod.vb.breezeCounter = 0
local scansDone = 0
local deadBoss = {}

function mod:OnCombatStart(delay)
	self.vb.windBlastCounter = 0
	self.vb.breezeCounter = 0
	self.vb.poisonCounter = 0
	scansDone = 0
	table.wipe(deadBoss)
	warnSpecialSoon:Schedule(80-delay)
	timerSpecial:Start(90-delay)
	enrageTimer:Start(-delay)
	--Anshal and his flowers
	timerSoothingBreezeCD:Start(16-delay)
	timerNurture:Start(30-delay)
	--Rohash
	timerWindBlastCD:Start(30-delay)
	if self:IsDifficulty("heroic10", "heroic25") then
		timerStormShieldCD:Start(30-delay)
	end
	--Nezir
	timerPermaFrostCD:Start(-delay)
end

function mod:BreezeTarget()
	scansDone = scansDone + 1
	local targetname, uId = self:GetBossTarget(45870)
	if targetname and uId then
		if UnitIsFriend("player", uId) then--He's targeting a friendly unit, he doesn't cast this on players, so it's wrong target.
			if scansDone < 15 then--Make sure no infinite loop.
				self:ScheduleMethod(0.1, "BreezeTarget")--Check multiple times to find a target that isn't a player.
			end
		else--He's not targeting a player, it's definitely breeze target.
			warnSoothingBreeze:Show(targetname)
		end
	else--target was nil, lets schedule a rescan here too.
		if scansDone < 15 then--Make sure not to infinite loop here as well.
			self:ScheduleMethod(0.1, "BreezeTarget")
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 86205 then
		self.vb.breezeCounter = self.vb.breezeCounter + 1
		scansDone = 0
		if self:GetUnitCreatureId("target") == 45870 or self:GetUnitCreatureId("focus") == 45870 or self:GetUnitCreatureId("target") == 45812 or not self.Options.OnlyWarnforMyTarget then--Anshal and his flowers
			self:BreezeTarget()
--			warnSoothingBreeze:Show()--possibly change to target scanning and announce whether he's casting it on himself or one of his flowers.
			if self.vb.breezeCounter < 3 then--Make sure it doesn't start another bar just before special.
				timerSoothingBreezeCD:Start()
			end
		end
	elseif args.spellId == 86192 then
		if self:GetUnitCreatureId("target") == 45872 or self:GetUnitCreatureId("focus") == 45872 or not self.Options.OnlyWarnforMyTarget then
			warnSummonTornados:Show()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 85422 then
		if self:GetUnitCreatureId("target") == 45870 or self:GetUnitCreatureId("focus") == 45870 or self:GetUnitCreatureId("target") == 45812 or not self.Options.OnlyWarnforMyTarget then--Anshal and his flowers
			warnNurture:Show()
		end
		if self:IsDifficulty("heroic10", "heroic25") then
			timerPoisonToxicCD:Start()
		end
	elseif args.spellId == 86082 then -- 93233 removed in mop, it seems that replaced with 86082
		timerPermaFrostCD:Start()
	elseif args:IsSpellID(84638, 84643, 84644) and self:AntiSpam(3, 4) then
		specWarnSpecial:Show()
		specWarnSpecial:Play("specialsoon")
		timerSpecialActive:Start()
		self.vb.poisonCounter = 0
		self.vb.breezeCounter = 0
		timerPermaFrostCD:Start(15)--This is gonna slap you in face the instance special ends.
	elseif args.spellId == 93059 then-- Storm Shield Warning (Heroic mode skill)
		if self:GetUnitCreatureId("target") == 45872 or self:GetUnitCreatureId("focus") == 45872 or not self.Options.OnlyWarnforMyTarget then--Rohash
			specWarnShield:Show()
			specWarnShield:Play("attackshield")
		end
	elseif args.spellId == 86281 and self:AntiSpam(3, 3) then-- Poison Toxic Warning (at Heroic, Poison Toxic damage is too high, so warning needed)
		if self:GetUnitCreatureId("target") == 45870 or self:GetUnitCreatureId("focus") == 45870 or self:GetUnitCreatureId("target") == 45812 or not self.Options.OnlyWarnforMyTarget then
			warnPoisonToxic:Show()
		end
		timerPoisonToxic:Start()
		timerPoisonToxicCD:Start()
		if self.vb.poisonCounter < 1 then
			self.vb.poisonCounter = 1
		end
	elseif args.spellId == 84645 then
		timerWindChill:Start()
	elseif args.spellId == 86193 then
		self.vb.windBlastCounter = self.vb.windBlastCounter + 1
		if self:GetUnitCreatureId("target") == 45872 or self:GetUnitCreatureId("focus") == 45872 or not self.Options.OnlyWarnforMyTarget then--Rohash
			if self.Options.SpecWarn86193dodge then
				specWarnWindBlast:Show()
				specWarnWindBlast:Play("frontal")
			else
				warnWindBlast:Show()
			end
		end
		timerWindBlast:Start()
		if self.vb.windBlastCounter == 1 then
			timerWindBlastCD:Start(82)
		else
			timerWindBlastCD:Start()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 86182 then
		if args:IsPlayer() then
			timerSlicingGale:Start()
		end
	elseif args.spellId == 84651 and args:GetDestCreatureID() == 45870 and self:AntiSpam(3, 1) then--Zephyr stacks on Anshal
		if (args.amount or 1) >= 15 then--Special has ended when he's at 15 stacks.
			warnSpecialSoon:Cancel()
			warnSpecialSoon:Schedule(85)
			timerSpecial:Start()
			if not deadBoss[Anshal] then--Anshal and his flowers
				timerSoothingBreezeCD:Start(16)
				timerNurture:Start()
			end
			if self:IsDifficulty("heroic10", "heroic25") and not deadBoss[Rohash] then--Rohash
				timerStormShieldCD:Start()
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(84638, 84643, 84644) and self:AntiSpam(3, 1) then--Sleet Storm, Hurricane.
		warnSpecialSoon:Cancel()
		warnSpecialSoon:Schedule(85)
		timerSpecial:Start()
		if not deadBoss[Anshal] then--Anshal and his flowers
			timerSoothingBreezeCD:Start(16)
			timerNurture:Start()
		end
		if self:IsDifficulty("heroic10", "heroic25") and not deadBoss[Rohash] then--Rohash
			timerStormShieldCD:Start()
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 86111 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

-- Posion Toxic can do casts during stun, so if Poison Toxic cancelled, Next Poision Toxic timer known by boss`s power.
function mod:UNIT_POWER_UPDATE(uId)
	if self:GetUnitCreatureId(uId) == 45870 and UnitPower(uId) == 62 and self.vb.poisonCounter == 0 and self:IsDifficulty("heroic10", "heroic25") then
		timerPoisonToxicCD:Start(10)
	elseif self:GetUnitCreatureId(uId) == 45870 and UnitPower(uId) == 79 and self:IsDifficulty("heroic10", "heroic25") then
		timerPoisonToxicCD:Cancel()
	end
end

function mod:RAID_BOSS_EMOTE(msg, boss)
	if msg == L.gatherstrength or msg:find(L.gatherstrength) then
		self:SendSync("GatherStrength", boss)
	end
end

local function bossRevive(boss)
	if not boss then return end
	deadBoss[boss] = false
end

function mod:OnSync(msg, boss)
	if msg == "GatherStrength" and self:IsInCombat() then
		deadBoss[boss or ""] = true
		warnGatherStrength:Show(boss)
		if self:IsDifficulty("heroic10", "heroic25") then
			timerGatherStrength:Start(60, boss)
			self:Schedule(60, bossRevive, boss)
		else
			timerGatherStrength:Start(120, boss)--2 minutes on normal as of 4.2
			self:Schedule(120, bossRevive, boss)
		end
	end
end
