local mod	= DBM:NewMod("ICCTrash", "DBM-Raids-WoTLK", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241103133102")
mod:SetModelID(30459)
mod:SetUsedIcons(1, 2, 8)
mod:SetZone(631)
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_AURA_APPLIED 69483 71127 70451 70432 70645 71785 71298",
	"SPELL_AURA_APPLIED_DOSE 71127",
	"SPELL_AURA_REMOVED 70451 70432 70645 71785 71298 69483",
	"SPELL_CAST_START 71022",
	"SPELL_SUMMON 71159 71123 71088",
	"SPELL_DAMAGE 70305",
	"SPELL_MISSED 70305",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_YELL"
)

--Lower Spire
local warnDarkReckoning			= mod:NewTargetNoFilterAnnounce(69483, 3)
--Plagueworks
local warnZombies				= mod:NewSpellAnnounce(71159, 2)
local warnMortalWound			= mod:NewStackAnnounce(71127, 2, nil, "Tank|Healer")
local warnDecimateSoon			= mod:NewSoonAnnounce(71123, 3)
--Crimson Hall
local warnBloodMirror			= mod:NewTargetNoFilterAnnounce(70451, 3, nil, "Healer|Tank")
local warnBloodSap				= mod:NewTargetNoFilterAnnounce(70432, 4, nil, "Healer|Tank")
local warnChainsofShadow		= mod:NewTargetNoFilterAnnounce(70645, 3, nil, false)
--Frostwing Hall
local warnConflag				= mod:NewTargetNoFilterAnnounce(71785, 4, nil, false)
local warnBanish				= mod:NewTargetNoFilterAnnounce(71298, 3, nil, false)

--Lower Spire
local specWarnDisruptingShout	= mod:NewSpecialWarningCast(71022, "SpellCaster", nil, 2, 1, 2)
local specWarnDarkReckoning		= mod:NewSpecialWarningMoveAway(69483, nil, nil, nil, 1, 2)
local specWarnTrapL				= mod:NewSpecialWarning("SpecWarnTrapL")
--Plagueworks
local specWarnDecimate			= mod:NewSpecialWarningSpell(71123, nil, nil, nil, 2, 2)
local specWarnMortalWound		= mod:NewSpecialWarningStack(71127, "Tank|Healer", 6, nil, nil, 1, 6)
local specWarnTrapP				= mod:NewSpecialWarning("SpecWarnTrapP")
local specWarnBlightBomb		= mod:NewSpecialWarningSpell(71088, nil, nil, nil, 2, 2)--Recheck sound
--Frostwing Hall
local specWarnGosaEvent			= mod:NewSpecialWarning("SpecWarnGosaEvent")
local specWarnBlade				= mod:NewSpecialWarningGTFO(70305, nil, nil, nil, 1, 8)

--Lower Spire
local timerDisruptingShout		= mod:NewCastTimer(3, 71022, nil, nil, nil, 2)
local timerDarkReckoning		= mod:NewTargetTimer(8, 69483, nil, nil, nil, 5)
--Plagueworks
local timerZombies				= mod:NewNextTimer(20, 71159, nil, nil, nil, 1)
local timerMortalWound			= mod:NewTargetTimer(15, 71127, nil, nil, nil, 5)
local timerDecimate				= mod:NewNextTimer(33, 71123, nil, nil, nil, 2)
local timerBlightBomb			= mod:NewCastTimer(5, 71088, nil, nil, nil, 3)
--Crimson Hall
local timerBloodMirror			= mod:NewTargetTimer(30, 70451, nil, "Healer|Tank", nil, 5)
local timerBloodSap				= mod:NewTargetTimer(8, 70432, nil, "Healer|Tank", nil, 5)
local timerChainsofShadow		= mod:NewTargetTimer(10, 70645, nil, false, nil, 3)
--Frostwing Hall
local timerConflag				= mod:NewTargetTimer(10, 71785, nil, false, nil, 3)
local timerBanish				= mod:NewTargetTimer(6, 71298, nil, false, nil, 3)

--Lower Spire
mod:AddSetIconOption("SetIconOnDarkReckoning", 69483, false)
--Crimson Hall
mod:AddSetIconOption("BloodMirrorIcon", 70451, false)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 69483 then
		warnDarkReckoning:Show(args.destName)
		timerDarkReckoning:Start(args.destName)
		if args:IsPlayer() then
			specWarnDarkReckoning:Show()
			specWarnDarkReckoning:Play("runout")
		end
		if self.Options.SetIconOnDarkReckoning then
			self:SetIcon(args.destName, 8)
		end
	elseif args.spellId == 71127 then
		local amount = args.amount or 1
		timerMortalWound:Start(args.destName)
		if amount % 2 == 0 then
			warnMortalWound:Show(args.destName, amount)
			if args:IsPlayer() and amount > 5 then
				specWarnMortalWound:Show(amount)
				specWarnMortalWound:Play("stackhigh")
			end
		end
	elseif args.spellId == 70451 and args:IsDestTypePlayer() then
		warnBloodMirror:CombinedShow(0.3, args.destName)
		timerBloodMirror:Start(args.destName)
		if self.Options.BloodMirrorIcon then
			self:SetSortedIcon("roster", 0.3, args.destName, 2, 2, true)
		end
	elseif args.spellId == 70432 then
		warnBloodSap:Show(args.destName)
		timerBloodSap:Start(args.destName)
	elseif args.spellId == 70645 and args:IsDestTypePlayer() then
		warnChainsofShadow:Show(args.destName)
		timerChainsofShadow:Start(args.destName)
	elseif args.spellId == 71785 then
		warnConflag:Show(args.destName)
		timerConflag:Start(args.destName)
	elseif args.spellId == 71298 then
		warnBanish:Show(args.destName)
		timerBanish:Start(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 70451 then
		timerBloodMirror:Cancel(args.destName)
		self:SetIcon(args.destName, 0)
	elseif args.spellId == 70432 then
		timerBloodSap:Cancel(args.destName)
	elseif args.spellId == 70645 then
		timerChainsofShadow:Cancel(args.destName)
	elseif args.spellId == 71785 then
		timerConflag:Cancel(args.destName)
	elseif args.spellId == 71298 then
		timerBanish:Cancel(args.destName)
	elseif args.spellId == 69483 then
		if self.Options.SetIconOnDarkReckoning then
			self:SetIcon(args.destName, 8, 0)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 71022 then
		specWarnDisruptingShout:Show()
		specWarnDisruptingShout:Play("stopcast")
		timerDisruptingShout:Start()
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 71159 and self:AntiSpam(5) then
		warnZombies:Show()
		timerZombies:Start()
	elseif args.spellId == 71123 then
		specWarnDecimate:Show()
		specWarnDecimate:Play("stilldanger")
		warnDecimateSoon:Cancel()	-- in case the first 1 is inaccurate, you wont have an invalid soon warning
		warnDecimateSoon:Schedule(28)
		timerDecimate:Start()
	elseif args.spellId == 71088 then
		specWarnBlightBomb:Show()
		specWarnBlightBomb:Play("watchstep")
		timerBlightBomb:Start()
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 70305 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnBlade:Show()
		specWarnBlade:Play("watchfeet")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 37025 then
		warnDecimateSoon:Cancel()
		timerDecimate:Cancel()
	elseif cid == 37217 then
		timerZombies:Cancel()
		warnDecimateSoon:Cancel()
		timerDecimate:Cancel()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == L.WarderTrap1 or msg == L.WarderTrap2 or msg == L.WarderTrap3) and self:LatencyCheck() then
		self:SendSync("WarderTrap")
	elseif (msg == L.FleshreaperTrap1 or msg == L.FleshreaperTrap2 or msg == L.FleshreaperTrap3) and self:LatencyCheck() then
		self:SendSync("FleshTrap")
	elseif msg == L.SindragosaEvent and self:LatencyCheck() then
		self:SendSync("GauntletStart")
	end
end

function mod:OnSync(msg, arg)
	if msg == "WarderTrap" then
		specWarnTrapL:Show()
	elseif msg == "FleshTrap" then
		specWarnTrapP:Show()
	elseif msg == "GauntletStart" then
		specWarnGosaEvent:Show()
	end
end
