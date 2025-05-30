local mod	= DBM:NewMod("GrobbulusVanilla", "DBM-Raids-Vanilla", 1)
local L		= mod:GetLocalizedStrings()

if DBM:IsSeasonal("SeasonOfDiscovery") then
	mod.statTypes = "normal,heroic,mythic"
else
	mod.statTypes = "normal"
end

mod:SetRevision("20241222110740")
mod:SetCreatureID(15931)
mod:SetEncounterID(1111)
mod:SetUsedIcons(1, 2, 3, 4)
mod:SetZone(533)

mod:RegisterCombat("combat")
--mod:SetModelID(16035)--Renders too close

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 28169",
	"SPELL_AURA_REMOVED 28169",
	"SPELL_CAST_SUCCESS 28240"
)

local warnInjection		= mod:NewTargetNoFilterAnnounce(28169, 2)
local warnCloud			= mod:NewSpellAnnounce(28240, 2)

local specWarnInjection	= mod:NewSpecialWarningYou(28169, nil, nil, nil, 1, 2)
local yellInjection		= mod:NewYell(28169, nil, false)

local timerInjection	= mod:NewTargetTimer(10, 28169, nil, nil, nil, 3)
local timerCloud		= mod:NewCDTimer(15, 28240, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local enrageTimer		= mod:NewBerserkTimer(720)

mod:AddSetIconOption("SetIconOnInjectionTarget", 28169, false, 0, {1, 2, 3, 4})

local mutateIcons = {}

local function addIcon(self)
	for i, j in ipairs(mutateIcons) do
		local icon = 0 + i
		self:SetIcon(j, icon)
	end
end

local function removeIcon(self, target)
	for i, j in ipairs(mutateIcons) do
		if j == target then
			table.remove(mutateIcons, i)
			self:SetIcon(target, 0)
		end
	end
	addIcon(self)
end

function mod:OnCombatStart(delay)
	table.wipe(mutateIcons)
	enrageTimer:Start(720-delay)
end

function mod:OnCombatEnd()
    for _, j in ipairs(mutateIcons) do
       self:SetIcon(j, 0)
    end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpell(28169) then
		timerInjection:Start(args.destName)
		if self.Options.SetIconOnInjectionTarget then
			table.insert(mutateIcons, args.destName)
			addIcon(self)
		end
		if args:IsPlayer() then
			specWarnInjection:Show()
			specWarnInjection:Play("runout")
			yellInjection:Yell()
		else
			warnInjection:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpell(28169) then
		timerInjection:Stop(args.destName)--Cancel timer if someone is dumb and dispels it.
		if self.Options.SetIconOnInjectionTarget then
			removeIcon(self, args.destName)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpell(28240) then
		warnCloud:Show()
		timerCloud:Start()
	end
end
