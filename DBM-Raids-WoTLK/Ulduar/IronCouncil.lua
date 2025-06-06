local mod	= DBM:NewMod("IronCouncil", "DBM-Raids-WoTLK", 5)
local L		= mod:GetLocalizedStrings()

if not mod:IsClassic() then--on classic, it's normal10,normal25, defined in toc, only retail overrides to flex/timewalking
	mod.statTypes = "normal,timewalker"
end

mod:SetRevision("20250408170354")
mod:SetCreatureID(32867, 32927, 32857)
mod:SetEncounterID(1140)
if mod:IsPostCata() then
	mod:SetEncounterID(1140)
	mod:DisableEEKillDetection()--Fires for first one dying not last
else
	mod:SetEncounterID(748)
end
mod:SetModelID(28344)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetBossHPInfoToHighest()
mod:SetHotfixNoticeRev(20230122000000)
mod:SetZone(603)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 61920 63479 61879 61903 63493 62274 63489 62273",
	"SPELL_CAST_SUCCESS 63490 62269 64321 61974 61869 63481",
	"SPELL_AURA_APPLIED 61903 63493 62269 63490 62277 63967 64637 61888 63486 61887 61912 63494 63483 61915",
	"SPELL_AURA_REMOVED 64637 61888 63483 61915 61912 63494",
	"UNIT_DIED"
)

--TODO, see if EE is fixed for encounter
--[[
(ability.id = 61920 or ability.id = 63479 or ability.id = 63479 or ability.id = 63479 or ability.id = 63479 or ability.id = 63479 or ability.id = 63479 or ability.id = 62273) and type = "begincast"
 or (ability.id = 63490 or ability.id = 62269 or ability.id = 64321 or ability.id = 61974 or ability.id = 61869 or ability.id = 63481) and type = "cast"
 or (ability.id = 62277 or ability.id = 63967 or ability.id = 63486 or ability.id = 61887) and type = "applybuff"
 or (ability.id = 63486 or ability.id = 61887) and type = "removebuff"
 or (target.id = 32867 or target.id = 32927 or target.id = 32857) and type = "death"
--]]
local warnSupercharge			= mod:NewSpellAnnounce(61920, 3)

local enrageTimer				= mod:NewBerserkTimer(900)

-- Stormcaller Brundir
-- High Voltage ... 63498
mod:AddTimerLine(L.StormcallerBrundir)
local warnChainlight			= mod:NewSpellAnnounce(64215, 2, nil, false, 2)

local specwarnLightningTendrils	= mod:NewSpecialWarningRun(63486, nil, nil, nil, 4, 2)
local specwarnOverload			= mod:NewSpecialWarningRun(63481, nil, nil, nil, 4, 2)
local specWarnLightningWhirl	= mod:NewSpecialWarningInterrupt(63483, "HasInterrupt", nil, nil, 1, 2)

local timerOverloadCD			= mod:NewCDTimer(70, 63481, nil, nil, nil, 3)
local timerOverload				= mod:NewCastTimer(6, 63481, nil, nil, nil, 2)
local timerLightningWhirl		= mod:NewCastTimer(5, 63483, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerLightningTendrilsCD	= mod:NewCDTimer(70, 63486, nil, nil, nil, 3)
local timerLightningTendrils	= mod:NewBuffActiveTimer(27, 63486, nil, nil, nil, 6)
mod:AddBoolOption("AlwaysWarnOnOverload", false, "announce", nil, nil, nil, 63481)

-- Steelbreaker
-- High Voltage ... don't know what to show here - 63498
mod:AddTimerLine(L.Steelbreaker)
local warnFusionPunch			= mod:NewSpellAnnounce(61903, 4)

local warnOverwhelmingPower		= mod:NewTargetNoFilterAnnounce(61888, 2)
local warnStaticDisruption		= mod:NewTargetAnnounce(63494, 3)

local timerFusionPunchCast		= mod:NewCastTimer(3, 61903, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON..DBM_COMMON_L.MAGIC_ICON)
local timerFusionPunchActive	= mod:NewTargetTimer(4, 61903, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON..DBM_COMMON_L.MAGIC_ICON)
local timerOverwhelmingPower	= mod:NewTargetTimer(25, 61888, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
mod:AddSetIconOption("SetIconOnOverwhelmingPower", 61888, false, 0, {8})
mod:AddSetIconOption("SetIconOnStaticDisruption", 63494, false, 0, {1, 2, 3, 4, 5, 6, 7})

-- Runemaster Molgeim
-- Lightning Blast ... don't know, maybe 63491
mod:AddTimerLine(L.RunemasterMolgeim)

local warnRuneofPower			= mod:NewTargetNoFilterAnnounce(64320, 2)
local warnRuneofDeath			= mod:NewSpellAnnounce(63490, 2)
local warnShieldofRunes			= mod:NewSpellAnnounce(63489, 2)
local warnRuneofSummoning		= mod:NewSpellAnnounce(62273, 3)

local specwarnRuneofDeath		= mod:NewSpecialWarningMove(63490, nil, nil, nil, 1, 2)
local specWarnRuneofShields		= mod:NewSpecialWarningDispel(63489, "MagicDispeller", nil, nil, 1, 2)

local timerRuneofShieldsCD		= mod:NewCDTimer(15, 63967, nil, nil, nil, 5)
local timerRuneofDeathCD		= mod:NewCDTimer(47.3, 63490, nil, nil, nil, 3)
local timerRuneofPowerCD		= mod:NewCDTimer(32.3, 64320, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerRuneofSummoningCD	= mod:NewCDTimer(24.1, 62273, nil, nil, nil, 1)

local disruptTargets = {}
mod.vb.disruptIcon = 7
mod.vb.stealbreakerDead = false
mod.vb.molgeimDead = false
mod.vb.brundirDead = false

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.stealbreakerDead = false
	self.vb.molgeimDead = false
	self.vb.brundirDead = false
	enrageTimer:Start(-delay)
	table.wipe(disruptTargets)
	self.vb.disruptIcon = 7
	timerRuneofPowerCD:Start("v16.7-29.2")--17-29.2, extremely variable
	timerOverloadCD:Start("v25.4-35")--probably 25-35, extremely variable
end

function mod:RuneTarget(targetname, uId)
	if not targetname then return end
	warnRuneofPower:Show(targetname)
end

local function warnStaticDisruptionTargets(self)
	warnStaticDisruption:Show(table.concat(disruptTargets, "<, >"))
	table.wipe(disruptTargets)
	self.vb.disruptIcon = 7
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 61920 then -- Supercharge
		warnSupercharge:Show()
	elseif args:IsSpellID(63479, 61879) then	-- Chain light
		warnChainlight:Show()
	elseif args:IsSpellID(61903, 63493) then	-- Fusion Punch
		warnFusionPunch:Show()
		timerFusionPunchCast:Start()
	elseif args:IsSpellID(62274, 63489) then	-- Shield of Runes
		warnShieldofRunes:Show()
	elseif args.spellId == 62273 then			-- Rune of Summoning
		warnRuneofSummoning:Show()
		timerRuneofSummoningCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(63490, 62269) then		-- Rune of Death
		warnRuneofDeath:Show()
		timerRuneofDeathCD:Start(self:IsClassic() and 30 or 45)
	elseif args:IsSpellID(64321, 61974) then	-- Rune of Power
		self:BossTargetScanner(32927, "RuneTarget", 0.1, 16, false, true)--Scan only boss unitIDs, scan only hostile targets
		timerRuneofPowerCD:Start()
	elseif args:IsSpellID(61869, 63481) then	-- Overload
		if self:GetStage(3, 3) then--In P3 timer no longer reliable, it's stopped as soon as 2 bosses are dead
			timerOverloadCD:Start()
		end
		timerOverload:Start()
		if self.Options.AlwaysWarnOnOverload or self:CheckBossDistance(args.sourceGUID, self:IsClassic() and false or true, 21519, 23) then
			specwarnOverload:Show()
			specwarnOverload:Play("justrun")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(61903, 63493) then		-- Fusion Punch
		timerFusionPunchActive:Start(args.destName)
	elseif args:IsSpellID(62269, 63490) then	-- Rune of Death - move away from it
		if args:IsPlayer() then
			specwarnRuneofDeath:Show()
			specwarnRuneofDeath:Play("runaway")
		end
	elseif args:IsSpellID(62277, 63967) and not args:IsDestTypePlayer() then		-- Shield of Runes
		specWarnRuneofShields:Show(args.destName)
		specWarnRuneofShields:Play("dispelboss")
	elseif args:IsSpellID(64637, 61888) then	-- Overwhelming Power
		warnOverwhelmingPower:Show(args.destName)
		if self:IsClassic() and self:IsDifficulty("normal10") then
			timerOverwhelmingPower:Start(60, args.destName)
		else
			timerOverwhelmingPower:Start(self:IsClassic() and 25 or 35, args.destName)
		end
		if self.Options.SetIconOnOverwhelmingPower then
			self:SetIcon(args.destName, 8)
		end
	elseif args:IsSpellID(63486, 61887) then	-- Lightning Tendrils
		timerLightningTendrils:Start()
		specwarnLightningTendrils:Show()
		specwarnLightningTendrils:Play("justrun")
	elseif args:IsSpellID(61912, 63494) then	-- Static Disruption (Hard Mode)
		disruptTargets[#disruptTargets + 1] = args.destName
		if self.Options.SetIconOnStaticDisruption and self.vb.disruptIcon > 0 then
			self:SetIcon(args.destName, self.vb.disruptIcon, 20)
		end
		self.vb.disruptIcon = self.vb.disruptIcon - 1
		self:Unschedule(warnStaticDisruptionTargets)
		self:Schedule(0.3, warnStaticDisruptionTargets, self)
	elseif args:IsSpellID(63483, 61915) then	-- LightningWhirl
		timerLightningWhirl:Start()
		if self:CheckInterruptFilter(args.destGUID, false, true) then
			specWarnLightningWhirl:Show(args.destName)
			specWarnLightningWhirl:Play("kickcast")
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(64637, 61888) then	-- Overwhelming Power
		if self.Options.SetIconOnOverwhelmingPower then
			self:SetIcon(args.destName, 0)
		end
		timerOverwhelmingPower:Stop(args.destName)
	elseif args:IsSpellID(63483, 61915) then	-- LightningWhirl
		timerLightningWhirl:Stop()
	elseif args:IsSpellID(61912, 63494) then	-- Static Disruption (Hard Mode)
		if self.Options.SetIconOnStaticDisruption then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 32867 or cid == 32927 or cid == 32857 then
		self:SetStage(0)
		if cid == 32867 then		--Steelbreaker
			self.vb.stealbreakerDead = true
			timerFusionPunchCast:Stop()
		elseif cid == 32927 then	--Runemaster
			self.vb.molgeimDead = true
			timerRuneofDeathCD:Stop()
			timerRuneofPowerCD:Stop()
		elseif cid == 32857 then	--Stormcaller
			self.vb.brundirDead = true
			timerOverload:Stop()
			timerOverloadCD:Stop()
			timerLightningWhirl:Stop()
		end
		if self:IsClassic() or DBM.Options.DebugMode then--Not verified on retail so not enabling there right now
			if self:GetStage(2) then--First kill
				--if not self.vb.stealbreakerDead then
				--
				--end
				if not self.vb.molgeimDead then
					timerRuneofDeathCD:Start(30.4)
					timerRuneofShieldsCD:Start(42.5)
				end
				--if not self.vb.brundirDead then
				--
				--end
			elseif self:GetStage(3) then--Second Kill
				--if not self.vb.stealbreakerDead then
				--
				--end
				--if not self.vb.molgeimDead then
				--
				--end
				if not self.vb.brundirDead then
					timerOverloadCD:Stop()
					timerLightningTendrilsCD:Start(61.4)
				end
			end
		end
	end
end
