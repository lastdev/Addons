local isClassic = WOW_PROJECT_ID == (WOW_PROJECT_CLASSIC or 2)
local isBCC = WOW_PROJECT_ID == (WOW_PROJECT_BURNING_CRUSADE_CLASSIC or 5)
local isWrath = WOW_PROJECT_ID == (WOW_PROJECT_WRATH_CLASSIC or 11)
local catID
if isWrath then
	catID = 5
elseif isBCC or isClassic then
	catID = 6
else--retail or cataclysm classic and later
	catID = 4
end
local mod	= DBM:NewMod("Lucifron", "DBM-Raids-Vanilla", catID)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250119115238")
mod:SetCreatureID(DBM:IsSeasonal("SeasonOfDiscovery") and 228429 or 12118)--, 12119
mod:SetEncounterID(663)
mod:SetModelID(13031)
mod:SetHotfixNoticeRev(20240724000000)
mod:SetUsedIcons(1, 2)
mod:SetZone(409)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 20604",
	"SPELL_CAST_SUCCESS 19702 19703 460931 460932",
	"SPELL_AURA_APPLIED 20604",
	"SPELL_AURA_REMOVED 20604"
)

--[[
(ability.id = 19702 or ability.id = 19703 or ability.id = 20604 or ability.id = 460931 or ability.id = 460932) and type = "cast"
--]]
local warnDoom		= mod:NewSpellAnnounce(19702, 2)
local warnCurse		= mod:NewSpellAnnounce(19703, 3)
local warnMC		= mod:NewTargetNoFilterAnnounce(20604, 4)

local specWarnMC	= mod:NewSpecialWarningYou(20604, nil, nil, nil, 1, 2)
local yellMC		= mod:NewYell(20604)

local timerCurseCD	= mod:NewVarTimer("v20.5-28", 19703, nil, nil, nil, 3, nil, DBM_COMMON_L.CURSE_ICON)--20-25 (22.6-28 on sod?)
local timerDoomCD	= mod:NewVarTimer(20, 19702, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)--20-25 (16-21 on sod)
--local timerDoom		= mod:NewCastTimer(10, 19702, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)

mod:AddSetIconOption("SetIconOnMC", 20604, true, 0, {1, 2})

mod.vb.lastIcon = 1

function mod:OnCombatStart(delay)
	self.vb.lastIcon = 1
	timerDoomCD:Start(6.5-delay)--6.5-8
	timerCurseCD:Start(12-delay)--12-15
end

function mod:MCTarget(targetname)
	if not targetname or not DBM:GetRaidRoster(targetname) then return end--Ignore junk target scans that include pets
	if not self:AntiSpam(1.5, "MC", targetname) then -- gets called for both SPELL_CAST_START and AURA_APPLIED because the former doesn't seem to exist at least on SoD
		return
	end
	if self.Options.SetIconOnMC then
		self:SetIcon(targetname, self.vb.lastIcon)
	end
	warnMC:CombinedShow(0.3, targetname)
	if targetname == UnitName("player") then
		specWarnMC:Show()
		specWarnMC:Play("targetyou")
		yellMC:Yell()
	end
	-- Up to 4 targets can be active in SoD if you mess up
	self.vb.lastIcon = self.vb.lastIcon % 4 + 1
end

function mod:SPELL_CAST_START(args)
	if args:IsSpell(20604) and args:IsSrcTypeHostile() then
		self:BossTargetScanner(args.sourceGUID, "MCTarget", 0.2, 5)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpell(20604) then
		self:MCTarget(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpell(20604) and args:IsDestTypePlayer() then
		if self.Options.SetIconOnMC then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpell(19702, 460931) then
		warnDoom:Show()
		--timerDoom:Start()
		timerDoomCD:Start(DBM:IsSeasonal("SeasonOfDiscovery") and "v16-21" or "v20-25")
	elseif args:IsSpell(19703, 460932) then
		warnCurse:Show()
		timerCurseCD:Start()
	end
end
