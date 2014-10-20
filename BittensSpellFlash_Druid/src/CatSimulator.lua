local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local GetCritChance = GetCritChance
local CR_HIT_MELEE = CR_HIT_MELEE
local math = math
local GetCombatRating = GetCombatRating
local pairs = pairs

a.CatSimulator = {}
local m = a.CatSimulator

m.Timers = {}

local miss
local crit

local function addEnergy(amount)
--c.Debug("Sim", "add", amount)
	m.Energy = math.max(0, math.min(100, m.Energy + amount))
	if m.Energy > 100 - m.Regen then
		m.Capped = true
	end
end

local function advance(elapse)
--c.Debug("Sim", "advance", elapse)
	addEnergy(elapse * m.Regen)
	if m.Energy > 100 - m.Regen then
		m.Capped = true
	end
	for k, v in pairs(m.Timers) do
		m.Timers[k] = v - elapse
	end
	m.Time = m.Time + elapse
end

local function poolTo(energy, consumeCC)
--c.Debug("Sim", "pool", energy, consumeCC)
	if consumeCC and m.Clearcasting then
		return
	end
	
	while true do
		local target = m.Timers.Berserk > 0 and energy / 2 or energy
		if m.Energy >= target then
			return
		end
		
		local elapse = (target - m.Energy) / m.Regen
		if elapse >= m.Timers.TigersFuryCD 
			and m.Energy <= 35
			and not m.Clearcasting then
			
			advance(math.max(0, m.Timers.TigersFuryCD))
			if m.Energy <= 35 then
				addEnergy(60)
				m.Timers.TigersFury = 6
				m.Timers.TigersFuryCD = 99
			end
		else
			advance(elapse)
			m.Energy = target -- to eliminate truncation errors
		end
	end
end

local function perform(energy, consumeCC, finisher)
--c.Debug("Sim", "perform", energy, consumeCC, finisher)
	if consumeCC and m.Clearcasting then
		m.Clearcasting = false
	elseif m.Timers.Berserk > 0 then
		m.Energy = m.Energy - energy / 2
	else
		m.Energy = m.Energy - energy
	end
	if finisher then
		if c.HasTalent("Soul of the Forest") then
			addEnergy(4 * m.CP)
		end
		m.CP = 0
	else
		m.CP = m.CP + 1
	end
	advance(1)
end

local function addCP()
--c.Debug("Sim", "addCP")
	for cost = 35, 45, 5 do
		poolTo(cost, true)
		local ability = a.ChooseCPGenerator(m)
		local cost = a.Costs[ability]
		if m.Timers.Berserk > 0 then
			cost = cost / 2
		end
		if m.Clearcasting or cost <= m.Energy then
			if ability == "Rake" then
				m.Timers.Rake = 99
			end
--c.Debug("Sim", "add cp with", ability)
			perform(cost, true, false)
			return
		end
	end
end

local function buildTo(cp)
--c.Debug("Sim", "build", cp)
	while m.CP < cp do
		addCP()
--a.PrintState("Sim", u)
	end
end

function m.Init()
	miss = math.max(0, .08 - GetCombatRating(CR_HIT_MELEE) / 12000)
	crit = math.max(0, GetCritChance() / 100 - .048)
end

function m.Reset()
	m.Time = 0
	m.CP = a.CP
	m.Regen = a.Regen
	m.Energy = a.Energy
	m.Clearcasting = a.Clearcasting
	for k, v in pairs(a.Timers) do
		m.Timers[k] = v
	end
	m.Capped = m.Energy > 100 - m.Regen
end

function m.SimTo(cp, ability)
--c.Debug("Sim", "vvvvvvvvvvvvvvvvvvvvvvvv", cp, ability)
--a.PrintState("Sim", u)
	buildTo(cp)
	local cost
	if ability == "Cap" then
		cost = 100 - m.Regen
	else
		cost = a.Costs[ability]
	end
	poolTo(cost, ability ~= "Savage Roar")
--a.PrintState("Sim", u)
--c.Debug("Sim", "^^^^^^^^^^^^^^^^^^^^^^^^")
end

function m.Bite()
-- Not currently called when rip can be refreshed
--	if a.InExecute and m.Timers.Rip > 0 then
--		m.Rip = 99
--	end
	perform(math.min(50, m.Energy), true, true)
end

function m.Roar()
	m.Timers.Roar = 99
	perform(25, false, true)
end
