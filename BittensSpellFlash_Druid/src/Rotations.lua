local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local x = s.UpdatedVariables
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")
local m = a.CatSimulator

local GetComboPoints = GetComboPoints
local GetEclipseDirection = GetEclipseDirection
local GetPowerRegen = GetPowerRegen
local GetTime = GetTime
local IsMounted = IsMounted
local SPELL_POWER_ECLIPSE = SPELL_POWER_ECLIPSE
local math = math
local select = select
local string = string
local print = print

local RIP_ACCEPTABLE_DOWNTIME = 2
local RIP_FURY_DELAY = 2
local RAKE_FURY_DELAY = 2

a.Rotations = {}

----------------------------------------------------------------------- Balance
a.Rotations.Balance = {
	Spec = 1,
	
	FlashInCombat = function()
		a.Energy = s.Power("player", SPELL_POWER_ECLIPSE)
		if c.HasBuff("Celestial Alignment") then
			a.Solar = true
			a.Lunar = true
		else
			a.Solar = c.HasBuff("Eclipse (Solar)") 
			a.Lunar = c.HasBuff("Eclipse (Lunar)")
		end
		a.GoingUp = GetEclipseDirection() ~= "moon"
		
		a.EclipsePending = false
		local info = c.GetCastingInfo()
		if info and not c.HasBuff("Celestial Alignment") then
			local bump = 0
			if c.InfoMatches(info, "Starfire") then
				if a.GoingUp then
					bump = 20
				end
			elseif c.InfoMatches(info, "Wrath") then
				if not a.GoingUp then
					bump = -15
				end
			elseif c.InfoMatches(info, "Starsurge") then
				if a.GoingUp then
					bump = 20
				else
					bump = -20
				end
			end
			if s.HasSpell(c.GetID("Euphoria"))
				and not a.Solar
				and not a.Lunar then
				
				bump = bump * 2
			end
			a.Energy = a.Energy + bump
			if a.Energy <= -100 then
				a.GoingUp = true
				a.Lunar = true
				a.EclipsePending = true
			elseif a.Energy >= 100 then
				a.GoingUp = false
				a.Solar = true
				a.EclipsePending = true
			elseif not c.HasBuff("Celestial Alignment") then
				if a.Energy >= 0 then
					a.Lunar = false
				end
				if a.Energy <= 0 then
					a.Solar = false
				end
			end
		end
		
		c.FlashAll(
			"Moonkin Form", 
			"Starfall", 
			"Force of Nature", 
			"Incarnation: Chosen of Elune",
			"Celestial Alignment",
			"Solar Beam")
		
		c.PriorityFlash(
			"Starsurge under Shooting Stars",
			"Moonfire under Eclipse",
			"Sunfire under Eclipse",
			"Moonfire",
			"Sunfire",
			"Starsurge",
			"Starfire under Celestial Alignment",
			"Wrath under Celestial Alignment",
			"Starfire",
			"Wrath")
	end,
	
	FlashOutOfCombat = function()
		c.FlashAll("Symbiosis")
	end,
	
	FlashAlways = function()
		c.FlashAll("Mark of the Wild")
	end,
	
	ExtraDebugInfo = function()
		return string.format("%d, %s, %s, %s, %s",
			a.Energy,
			tostring(a.Solar),
			tostring(a.Lunar),
			tostring(a.GoingUp),
			tostring(a.EclipsePending))
	end,
}

------------------------------------------------------------------------- Feral
local lastRipTime = 0
local lastRipDuration = 0
local pendingRipExtension = 0

local function updateRipDuration()
	local duration = s.MyDebuffDuration(c.GetID("Rip"))
	local now = GetTime()
	if duration - lastRipDuration > 4 then
		pendingRipExtension = 6
c.Debug("Rip", "Overwrite: ", duration - lastRipDuration)
	elseif duration > lastRipDuration then
		pendingRipExtension = pendingRipExtension - 2
c.Debug("Rip", "change of ", duration - lastRipDuration, " -> ", pendingRipExtension)
	end
	lastRipTime = now
	lastRipDuration = duration
	
	local busyTime = c.GetBusyTime()
	local info = c.GetQueuedInfo()
	if c.InfoMatches(info, "Rip") then
		a.Timers.Rip = 99
	elseif duration > busyTime 
		or (duration > 0 
			and pendingRipExtension > 0 
			and c.InfoMatches(info, "Shred", "Ravage", "Mangle(Cat Form)")) then
		
		a.Timers.Rip = duration - busyTime + pendingRipExtension
	else
		a.Timers.Rip = 0
	end
end

a.CP = 0
a.Regen = 0
a.Energy = 0
a.Clearcasting = false
a.Timers = {
	Rip = 0,
	Rake = 0,
	Roar = 0,
	Berserk = 0,
	Incarnation = 0,
	TigersFuryCD = 0,
	TigersFury = 0,
}

function a.PrintState(tag, state)
	c.Debug(
		tag, 
--		s.Power("player"),
		string.format(
			"%s: %.1f %d r:%.1f p:%1f, t:(%.1f,%.1f) b:%.1f i:%.1f%s%s",
			state.Time and string.format("%.1f", state.Time) or "a",
			state.Energy,
			state.CP,
			state.Timers.Roar,
			state.Timers.Rip,
			state.Timers.TigersFury,
			state.Timers.TigersFuryCD,
			state.Timers.Berserk,
			state.Timers.Incarnation,
			state.Clearcasting and " cc" or "",
			state.Capped and " C" or ""))
end

local lastEnergy = 0
local pendingBiteDrain = 0
local biteTime = 0
local ccEaters = {
	[s.SpellName(c.GetID("Ferocious Bite"))] = true,
	[s.SpellName(c.GetID("Mangle(Cat Form)"))] = true,
	[s.SpellName(c.GetID("Rake"))] = true,
	[s.SpellName(c.GetID("Rip"))] = true,
	[s.SpellName(c.GetID("Shred"))] = true,
	[s.SpellName(c.GetID("Swipe"))] = true,
	[s.SpellName(c.GetID("Thrash"))] = true,
}

local function setInitialState()
	if s.Power("player") < lastEnergy or GetTime() - biteTime > 1 then
		pendingBiteDrain = 0
	end
	lastEnergy = s.Power("player")
	
	a.CP = GetComboPoints("player")
	a.Regen = select(2, GetPowerRegen())
	a.Energy = c.GetPower(a.Regen) - pendingBiteDrain
	a.Clearcasting = c.HasBuff("Clearcasting")
	a.Timers.Rake = c.GetMyDebuffDuration("Rake")
	a.Timers.Roar = c.GetBuffDuration("Savage Roar")
	a.Timers.Berserk = c.GetBuffDuration("Berserk")
	a.Timers.Incarnation = 
		c.GetBuffDuration("Incarnation: King of the Jungle")
	a.Timers.TigersFuryCD = c.GetCooldown("Tiger's Fury")
	a.Timers.TigersFury = c.GetBuffDuration("Tiger's Fury")
	updateRipDuration()
	
	if c.IsAuraPendingFor("Rake") then
		a.Timers.Rake = 99
	end
	
	local info = c.GetQueuedInfo()
	if info == nil then
		return
	end
	
	if ccEaters[info.Name] then
		a.Clearcasting = false
	end
	
	if c.InfoMatches(
		info, "Shred", "Rake", "Mangle(Cat Form)", "Ravage") then
		
		a.CP = math.min(5, a.CP + 1)
	elseif c.InfoMatches(info, "Rip", "Savage Roar", "Ferocious Bite") then
		a.CP = 0
		
		if c.HasTalent("Soul of the Forest") then
			a.Energy = math.min(100, a.Energy + 4 * a.CP)
		end
		if c.InfoMatches(info, "Savage Roar") then
			a.Timers.Roar = 99
		end
	elseif c.InfoMatches(info, "Tiger's Fury") then
		a.Timers.TigersFury = 6
		a.Timers.TigersFuryCD = 99
	elseif c.InfoMatches(info, "Berserk") then
		a.Timers.Berserk = 99
	elseif c.InfoMatches(info, "Incarnation: King of the Jungle") then
		a.Timers.Incarnation = 99
	end
end

local function chooseExecuteFinisher()

	---- Rip is Refreshable ----
	-- Bite if Roar will be up @ 5
	--   or Roar might make it unrefreshable
	-- Roar
	m.Reset()
	m.SimTo(5, "Ferocious Bite")
	if m.Timers.Roar > 0 then
		return "Ferocious Bite", 5, 0
	end
	
	m.Reset()
	m.SimTo(a.RoarCPs, "Savage Roar")
	m.Roar()
	m.SimTo(1, "Ferocious Bite")
	if m.Timers.Rip > .1 then
		return "Savage Roar", 
			a.RoarCPs, 
			math.min(a.Timers.Roar, m.Timers.Rip - .1)
	end
	
	-- Roar is going to fall off very soon, refresh Rip now!
	return "Ferocious Bite", 1, 0
end

local function chooseFinisher()
	if a.InExecute then
		m.Reset()
		m.SimTo(1, "Ferocious Bite")
		if m.Timers.Rip > .1 then
			return chooseExecuteFinisher()
		end
	end
	
	---- Rip is not Refreshable ----
	-- Roar if it might fall off before next finisher
	-- Bite if can then Rip before Roar falls off
	--   or can then Roar and Rip without much gap
	-- Rip
	
	m.Reset()
	m.SimTo(5, "Ferocious Bite")
	if m.Timers.Roar < .1 then
		m.Reset()
		m.SimTo(a.RoarCPs, "Savage Roar")
		m.SimTo(0, "Cap")
		return "Savage Roar", a.RoarCPs, math.min(a.Timers.Roar, m.Time)
	end
	
	for cp = 5, math.max(1, a.CP), -1 do
		m.Reset()
		m.SimTo(cp, "Ferocious Bite")
		m.Bite()
		m.SimTo(5, "Rip")
		if m.Timers.Roar > .1 
			and m.Time < a.Timers.Rip + RIP_ACCEPTABLE_DOWNTIME then
			
			return "Ferocious Bite", cp, 0
		end
		
		m.Reset()
		m.SimTo(cp, "Ferocious Bite")
		m.Bite()
		m.SimTo(1, "Savage Roar")
		m.Roar()
		m.SimTo(5, "Rip")
		if m.Timers.Roar > .1 
			and m.Time < a.Timers.Rip + RIP_ACCEPTABLE_DOWNTIME then
			
			return "Ferocious Bite", cp, 0
		end
	end
	
	m.Reset()
	m.SimTo(5, "Rip")
	local roarOff = a.Timers.Roar
	local furyUp = a.Timers.TigersFuryCD
	local earliestRip = math.max(a.Timers.Rip - 3, m.Time)
	local latestRip = math.max(earliestRip, a.Timers.Rip)
	if furyUp + .1 < roarOff and latestRip + RIP_FURY_DELAY > furyUp then
		earliestRip = math.max(earliestRip, furyUp)
	end
	if a.Timers.Roar < earliestRip + .1 then
		m.Reset()
		m.SimTo(a.RoarCPs, "Savage Roar")
		m.SimTo(0, "Cap")
		return "Savage Roar", 0, math.min(a.Timers.Roar, m.Time)
	else
		return "Rip", 5, earliestRip
	end
end	

-- TODO: currently possible to report, e.g., Shred, but then for shred to not
-- be available by the time we have 40 energy, in which case we only needed to
-- pool to 35.
function a.ChooseCPGenerator(state)
	if state.Timers.Rake < 3 
		and (state.Timers.Berserk > 0 
			or state.Timers.TigersFury > 0 
			or state.Timers.TigersFuryCD > RAKE_FURY_DELAY) then
		
		return "Rake"
	elseif state.Timers.Incarnation > 0 then
		return "Ravage"
	elseif not (a.NoShred[s.UnitInfo()] or c.IsTanking())
		or (c.HasGlyph("Shred") 
			and (state.Timers.TigersFury > 0 or state.Timers.Berserk > 0)) then
--			and math.max(state.Timers.TigersFury, state.Timers.Berserk) 
--				> m.TimeToPool(40, state, true)) then
		
		return "Shred"
	else
		return "Mangle(Cat Form)"
	end
end

local function prepFlash(ability)
	s.Flash(c.GetID(ability), "green", s.FlashSizePercent() / 2)
end

local function flash(ability)
	local cost = a.Costs[ability]
	if a.Clearcasting and ability ~= "Savage Roar" then
		cost = 0
	elseif a.Timers.Berserk > 0 then
		cost = cost / 2
	end
	if a.Energy + .1 * a.Regen >= cost then
		s.Flash(c.GetID(ability))
	else
		prepFlash(ability)
	end 
end

a.Rotations.Feral = {
	Spec = 2,
	
	FlashInCombat = function()
		a.InExecute = s.HealthPercent() < 25
		if c.HasGlyph("Savagery") then
			a.RoarCPs = 0
			a.SpellIDs["Savage Roar"] = a.SpellIDs["Savage Roar Glyphed"]
		else
			a.RoarCPs = 1
			a.SpellIDs["Savage Roar"] = a.SpellIDs["Savage Roar Unglyphed"]
		end
		setInitialState()
--a.PrintState("Flash", a)
		
		-- Not on the GCD
		c.FlashAll(
			"Cat Form",
			"Survival Instincts under 30", 
			"Barkskin under 30",
			"Tiger's Fury",
			"Berserk",
			"Incarnation: King of the Jungle",
			"Faerie Fire for Debuff",
			"Skull Bash")
		
		local finisher, cpNeeded, delay = chooseFinisher()
		if a.CP >= cpNeeded and (delay <= .1 or a.Timers.Berserk > 0) then
c.Debug("Flash", "Time for", finisher, cpNeeded, delay)
			flash(finisher)
			return
		end
		
		if a.CP >= cpNeeded	and delay < 1 then
c.Debug("Flash", "Waiting for", finisher, cpNeeded, delay, "- Coming soon!")
			prepFlash(finisher)
			return
		end
		
		---- Generate CP if ----
		-- combo needed and
		--   clearcasting
		--   nearing delay
		-- or
		--   berserk
		--   tiger's fury up
		--   cap danger (including near-future use of Tiger's Fury)
		local ability = a.ChooseCPGenerator(a)
		if (a.CP < cpNeeded and a.Clearcasting) 
			or a.Timers.Berserk > 0
			or a.Timers.TigersFury > 0
			or (ability == "Rake" and a.Timers.Rake < 3) then
			
c.Debug("Flash", "Working to", finisher, cpNeeded, delay, "- Use", ability)
			flash(ability)
			return
		end
		
		m.Reset()
		m.SimTo(cpNeeded, finisher)
		if m.Time + 1 > delay
			or m.Capped
			or (m.Timers.TigersFuryCD <= 0 
				and m.Energy + 60 > 100 - m.Regen) then
			
c.Debug("Flash", "Hurrying for", finisher, cpNeeded, delay, "- Use", ability)
			flash(ability)
			return
		end
		
c.Debug("Flash", "Waiting before", finisher, cpNeeded, delay)
		if a.CP < cpNeeded then
			prepFlash(ability)
		else
			prepFlash(finisher)
		end
		delay = delay - math.max(0, cpNeeded - a.CP)
		if delay >= 1 then
			if not c.PriorityFlash("Faerie Fire Early") and delay >= 1.5 then
				c.PriorityFlash("Force of Nature", "Healing Touch for Feral")
			end
		end
	end,
	
	FlashOutOfCombat = function()
		c.FlashAll("Symbiosis")
	end,
	
	FlashAlways = function()
		c.FlashAll("Mark of the Wild")
	end,
	
	CastQueued = function(info)
		if c.InfoMatches(info, "Ferocious Bite") then
			local _, regen = GetPowerRegen()
			local cost = s.SpellCost(info.Name)
			local energy = s.Power("player") + s.UpdatedVariables.Lag * regen
			info.Cost = cost + math.min(25, energy - cost)
			c.Debug("Event", "FB will cost", info.Cost)
		end
	end,
	
	CastSucceeded = function(info)
		if c.InfoMatches(info, "Ferocious Bite") then
			lastEnergy = s.Power("player")
			pendingBiteDrain = math.min(25, lastEnergy)
			biteTime = GetTime()
			c.Debug("Event", "FB will still cost", pendingBiteDrain)
		end
	end,
}

---------------------------------------------------------------------- Guardian
local uncontrolledMitigationCooldowns = {
	"Feint",
	"Spell Reflection",
	"Tooth and Claw",
}

a.Rotations.Guardian = {
	Spec = 3,
	
	FlashInCombat = function()
		a.Rage = c.GetPower(select(2, GetPowerRegen()))
		local info = c.GetQueuedInfo()
		if c.InfoMatches(info, "Mangle(Bear Form)") then
			if c.HasTalent("Soul of the Forest") then
				a.Rage = a.Rage + 10
			else
				a.Rage = a.Rage + 5
			end
			a.Rage =  math.min(s.MaxPower("player"), a.Rage)
		end
		a.EmptyRage = s.MaxPower("player") - a.Rage
		
		c.FlashMitigationBuffs(
			1,
			uncontrolledMitigationCooldowns,
			"Cenarion Ward",
			"Nature's Swiftness for Guardian",
--			"Bone Shield",
			"Barkskin",
			"Renewal",
			"Survival Instincts Glyphed",
			"Might of Ursoc at 2 mins",
			"Survival Instincts Unglyphed",
			"Might of Ursoc above 2 mins")
		c.FlashAll(
			"Bear Form",
			"Frenzied Regeneration",
			"Savage Defense",
			"Maul",
			"Skull Bash",
			"Growl")
		c.PriorityFlash(
			"Thrash for Weakened Blows",
			"Healing Touch for Guardian",
			"Rejuvenation for Guardian",
			"Mangle(Bear Form)",
			"Rejuvenation Refresh for Guardian",
			"Thrash for Bleed",
			"Faerie Fire for Debuff for Guardian",
			"Enrage",
			"Lacerate",
			"Faerie Fire",
			"Thrash")
	end,
	
	FlashOutOfCombat = function()
		c.FlashAll("Symbiosis")
	end,
	
	FlashAlways = function()
		c.FlashAll("Mark of the Wild")
	end,
	
	ExtraDebugInfo = function()
		return a.Rage
	end,
}
