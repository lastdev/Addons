local AddonName, a = ...
if a.BuildFail(50000) then return end
local L = a.Localize
local s = SpellFlashAddon
local c = BittensSpellFlashLibrary

local GetCritChance = GetCritChance
local CR_HIT_MELEE = CR_HIT_MELEE
local math = math
local GetCombatRating = GetCombatRating
local pairs = pairs

a.CatSimulator = {}
local u = a.CatSimulator

u.Timers = {}

local miss
local crit

local function addEnergy(amount)
--c.Debug("Sim", "add", amount)
	u.Energy = math.max(0, math.min(100, u.Energy + amount))
	if u.Energy > 100 - u.Regen then
		u.Capped = true
	end
end

local function advance(elapse)
--c.Debug("Sim", "advance", elapse)
	addEnergy(elapse * u.Regen)
	if u.Energy > 100 - u.Regen then
		u.Capped = true
	end
	for k, v in pairs(u.Timers) do
		u.Timers[k] = v - elapse
	end
	u.Time = u.Time + elapse
end

local function poolTo(energy, consumeCC)
--c.Debug("Sim", "pool", energy, consumeCC)
	if consumeCC and u.Clearcasting then
		return
	end
	
	while true do
		local target = u.Timers.Berserk > 0 and energy / 2 or energy
		if u.Energy >= target then
			return
		end
		
		local elapse = (target - u.Energy) / u.Regen
		if elapse >= u.Timers.TigersFuryCD 
			and u.Energy <= 35
			and not u.Clearcasting then
			
			advance(math.max(0, u.Timers.TigersFuryCD))
			if u.Energy <= 35 then
				addEnergy(60)
				u.Timers.TigersFury = 6
				u.Timers.TigersFuryCD = 99
				if c.WearingSet(4, "FeralT13") then
					u.Clearcasting = true
				end
			end
		else
			advance(elapse)
			u.Energy = target -- to eliminate truncation errors
		end
	end
end

local function perform(energy, consumeCC, finisher)
--c.Debug("Sim", "perform", energy, consumeCC, finisher)
	if consumeCC and u.Clearcasting then
		u.Clearcasting = false
	elseif u.Timers.Berserk > 0 then
		u.Energy = u.Energy - energy / 2
	else
		u.Energy = u.Energy - energy
	end
	if finisher then
		if c.HasTalent("Soul of the Forest") then
			addEnergy(4 * u.CP)
		end
		u.CP = 0
	else
		u.CP = u.CP + 1
	end
	advance(1)
end

local function addCP()
--c.Debug("Sim", "addCP")
	for cost = 35, 45, 5 do
		poolTo(cost, true)
		local ability = a.ChooseCPGenerator(u)
		local cost = a.Costs[ability]
		if u.Timers.Berserk > 0 then
			cost = cost / 2
		end
		if u.Clearcasting or cost <= u.Energy then
			if ability == "Rake" then
				u.Timers.Rake = 99
			end
--c.Debug("Sim", "add cp with", ability)
			perform(cost, true, false)
			return
		end
	end
end

local function buildTo(cp)
--c.Debug("Sim", "build", cp)
	while u.CP < cp do
		addCP()
--a.PrintState("Sim", u)
	end
end

function u.Init()
	miss = math.max(0, .08 - GetCombatRating(CR_HIT_MELEE) / 12000)
	crit = math.max(0, GetCritChance() / 100 - .048)
end

function u.Reset()
	u.Time = 0
	u.CP = a.CP
	u.Regen = a.Regen
	u.Energy = a.Energy
	u.Clearcasting = a.Clearcasting
	for k, v in pairs(a.Timers) do
		u.Timers[k] = v
	end
	u.Capped = u.Energy > 100 - u.Regen
end

function u.SimTo(cp, ability)
--c.Debug("Sim", "vvvvvvvvvvvvvvvvvvvvvvvv", cp, ability)
--a.PrintState("Sim", u)
	buildTo(cp)
	local cost
	if ability == "Cap" then
		cost = 100 - u.Regen
	else
		cost = a.Costs[ability]
	end
	poolTo(cost, ability ~= "Savage Roar")
--a.PrintState("Sim", u)
--c.Debug("Sim", "^^^^^^^^^^^^^^^^^^^^^^^^")
end

function u.Bite()
-- Not currently called when rip can be refreshed
--	if a.InExecute and u.Timers.Rip > 0 then
--		u.Rip = 99
--	end
	perform(math.min(50, u.Energy), true, true)
end

function u.Roar()
	u.Timers.Roar = 99
	perform(25, false, true)
end
