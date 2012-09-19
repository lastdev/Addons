local AddonName, a = ...
if a.BuildFail(50000) then return end
local L = a.Localize
local s = SpellFlashAddon
local c = BittensSpellFlashLibrary

local GetRuneCooldown = GetRuneCooldown
local GetTime = GetTime
local UnitIsUnit = UnitIsUnit
local math = math
local select = select

local rpBumped = 0
local rpBumpExpires = 0
local suppressKM = false
a.Runes = { 0, 0, 0, 0, 0, 0 }
a.PendingDeathRunes = 0

local function getBump(name, freezingFog)
	local cost = a.Costs[name]
	if cost == nil then
		return 0
	end
	
	local bump = cost.BonusRP or 0
	if not cost.Rime or freezingFog == 0 then
		bump = bump + math.max(0, 10 * (cost.Blood + cost.Frost + cost.Unholy))
	end
	if c.HasBuff("Frost Presence") then
		bump = bump * 1.2
	end
	return bump
end

local function consumeRune(runeID, mustBeDeath)
	local start, duration = GetRuneCooldown(runeID)
	if start + duration < GetTime() then
		a.Runes[runeID] = 100
		return true
	end
end

local function consumeRunes(toConsume, rune1, rune2, deathNeeded)
	if toConsume == 0 or consumeRune(rune1) or consumeRune(rune2) then
		return deathNeeded
	else
		return deathNeeded + 1
	end
end

local function consumeDeathRunes(deathNeeded)
	for i = 1, 6 do
		if deathNeeded == 0 then
			return
		elseif a.IsDeathRune(i) and consumeRune(i, true) then
			deathNeeded = deathNeeded - 1
		end
	end
end

local function consumesKM(info)
	return c.InfoMatches(info, "Obliterate", "Frost Strike")
end

local function adjustResourcesForSuccessfulCast(info)
	local cost = s.SpellCost(info.Name)
	if cost == 0 and not c.InfoMatches(info, "Blood Boil") then
		local bump = getBump(
			info.Name, s.BuffStack(c.GetID("Freezing Fog"), "player"))
		if bump > 0 then
			rpBumped = s.Power("player") + bump
			rpBumpExpires = GetTime() + .8
		end
--c.Debug("Resources", info.Name, "bump", bump, "->", rpBumped)
	elseif GetTime() < rpBumpExpires then
		rpBumped = rpBumped - cost
	end
end

a.Rotations = {}
c.RegisterForEvents(a)
a.SetSpamFunction(function()
	
	-- grab RP	
	a.RP = s.Power("player")
	if rpBumpExpires > 0 then
		if a.RP < rpBumped and GetTime() < rpBumpExpires then
			a.RP = rpBumped
		else
			rpBumped = 0
			rpBumpExpires = 0
		end
	end
	
	-- grab rune state
	local busyTime = c.GetBusyTime()
	for i = 1, 6 do
		local start, duration = GetRuneCooldown(i)
		a.Runes[i] = start + duration - GetTime() - busyTime
	end
	
	-- grab KM
	a.KillingMachine = not suppressKM and c.HasBuff("Killing Machine")
	
	-- grab Freezing Fog
	a.FreezingFog = c.GetBuffStack("Freezing Fog")
	
	-- adjust resources for queued spell
	local info = c.GetQueuedInfo()
	a.PendingDeathRunes = 0
	if info then
--c.Debug("Queued", info.Name)
		local cost = s.SpellCost(info.Name)
		if cost > 0 then
			a.RP = a.RP - cost
		else
			a.RP = a.RP + getBump(info.Name, a.FreezingFog)
		end
		local cost = a.Costs[info.Name]
		if cost then
			local deathNeeded = cost.Death
			local frostNeeded = s.If(
				cost.Rime and a.FreezingFog > 0, 0, cost.Frost)
			deathNeeded = consumeRunes(cost.Blood, 1, 2, deathNeeded)
			deathNeeded = consumeRunes(frostNeeded, 5, 6, deathNeeded)
			deathNeeded = consumeRunes(cost.Unholy, 3, 4, deathNeeded)
			consumeDeathRunes(deathNeeded)
		end
		if consumesKM(info) then
			a.KillingMachine = false
		elseif a.FreezingFog > 0
			and c.InfoMatches(info, "Howling Blast", "Icy Touch") then
			
			a.FreezingFog = a.FreezingFog - 1
		elseif c.InfoMatches(info, "Blood Tap", "Plague Leech") then
			a.PendingDeathRunes = 1
		end
	end
	
	-- flash
	c.Flash(a)
end)

local spellIfCapped
local function flashNoCap(...)
	local flashed
	for i = 1, select("#", ...) do
		local name = select(i, ...)
		local spell = c.GetSpell(name)
		if s.Flashable(spell.ID) and s.Castable(spell) then
			local bump = getBump(s.SpellName(spell.ID), a.FreezingFog)
			if bump == 0 or a.RP + bump < s.MaxPower("player") then
				local color = spell.FlashColor
				if c.AoE and color == nil then
					color = "purple"
				end
				s.Flash(spell.ID, color, spell.FlashSize)
				if spell.Continue then
					flashed = name
				else
					return name
				end
			elseif spellIfCapped ~= nil then
				s.Flash(c.GetID(spellIfCapped))
				return spellIfCapped .. " pre-cap " .. name
			end
		end
	end
	return flashed
end

local function debugPrint(flashing)
	c.Debug("Flashing",
		a.RP, 
		string.format(
			"%.1f %.1f %.1f %.1f %.1f %.1f",
			math.max(0, math.min(9.9, a.Runes[1])),
			math.max(0, math.min(9.9, a.Runes[2])),
			math.max(0, math.min(9.9, a.Runes[5])),
			math.max(0, math.min(9.9, a.Runes[6])),
			math.max(0, math.min(9.9, a.Runes[3])),
			math.max(0, math.min(9.9, a.Runes[4]))),
		a.PendingDeathRunes,
		a.KillingMachine or "KM" and "",
		a.FreezingFog > 0 or "FF" .. a.FreezingFog and "",
		"==>", flashing)
end

------------------------------------------------------------------------- Blood
local uncontrolledMitigationBuffs = {
	"Master Tactician LFR",
	"Master Tactician",
	"Master Tactician Heroic",
}

a.Rotations.Blood = {
	Spec = 1,
	OffSwitch = "blood_off",
	
	FlashInCombat = function()
		c.FlashAll(
			"Rune Tap", 
			"Mind Freeze", 
			"Dark Command", 
			"Death Grip",
			"Conversion Cancel")
		c.FlashMitigationBuffs(
			2,
			uncontrolledMitigationBuffs,
			"Dancing Rune Weapon",
			"Bone Shield",
			"Vampiric Blood",
			"Fire of the Deep",
			"Death Pact",
			"Conversion",
			"Icebound Fortitude")
--debugPrint(
		c.PriorityFlash(
			"Death Strike for Health",
			"Death Strike to Save Shield",
			"Blood Tap for Death Strike",
			"Death Siphon for Health",
			"Outbreak for Blood Plague",
			"Plague Strike for Blood Plague",
			"Rune Strike for Resources if Capped",
			"Death Strike if Two Available",
			"Blood Boil for Blood Plague",
			"Rune Strike for Resources",
			"Horn of Winter for Buff",
			"Heart Strike for Runic Power",
			"Blood Boil for Runic Power",
			"Horn of Winter for Runic Power",
			"Outbreak Early")
--)
	end,
	
	FlashOutOfCombat = function()
		c.FlashAll("Bone Shield")
	end,
	
	FlashAlways = function()
		c.FlashAll("Blood Presence")
	end,
	
	CastSucceeded = function(info)
		adjustResourcesForSuccessfulCast(info)
		if c.InfoMatches(info, "Blood Boil") 
			and s.MyDebuff(c.GetID("Blood Plague")) then
			
			a.BloodPlagueRefreshPending = true
			c.Debug("Event", "Blood Plague refresh pending")
		end
	end,
	
	AuraApplied = function(spellID)
		if spellID == c.GetID("Blood Plague") then
			a.BloodPlagueRefreshPending = nil
			c.Debug("Event", "Blood Plague applied")
		elseif spellID == c.GetID("Scent of Blood") then
			c.Debug("Event", "Scent of Blood")
		end
	end,
}

------------------------------------------------------------------------- Frost
a.Rotations.Frost = {
	Spec = 2,
	OffSwitch = "frost_off",
	
	FlashInCombat = function()
		if s.MeleeDistance() then
			spellIfCapped = "Frost Strike"
		else
			spellIfCapped = "Death Coil"
		end
		
		c.FlashAll(
			"Pillar of Frost", 
			"Blood Tap for Frost", 
			"Empower Rune Weapon when low",
			"Mind Freeze")
debugPrint(
		flashNoCap(
			"Frost Strike under KM",
			"Outbreak",
			"Howling Blast for FF",
			"Plague Strike for BP unless Outbreak",
			"Plague Leech for Frost",
			"Obliterate KM UU",
			"Howling Blast Freezing Fog",
			"Obliterate UU",
			"Frost Strike for Resources",
			"Howling Blast",
			"Horn of Winter")
)
	end,
	
	FlashAlways = function()
		c.FlashAll("Frost Presence")
	end,
	
	CastSucceeded = function(info)
		adjustResourcesForSuccessfulCast(info)
		if s.Buff(c.GetID("Killing Machine"), "player")
			and consumesKM(info) then
			
			suppressKM = true
			c.Debug("Event", info.Name, "to consume KM")
		end
	end,
	
	AuraApplied = function(spellID, target, spellSchool)
		if spellID == c.GetID("Killing Machine") then
			suppressKM = false
			c.Debug("Event", "New KM")
		end
	end,
	
	AuraRemoved = function(spellID, target, spellSchool)
		if spellID == c.GetID("Killing Machine") then
			suppressKM = false
			c.Debug("Event", "KM is really gone")
		end
	end,
}

------------------------------------------------------------------------ Unholy
--a.LastPestilence = 0

a.Rotations.Unholy = {
	Spec = 3,
	OffSwitch = "unholy_off",
	
	FlashInCombat = function()
		spellIfCapped = "Death Coil"
		c.FlashAll(
			"Unholy Frenzy",
			"Empower Rune Weapon when low",
			"Mind Freeze")
--		if c.AoE then
--			flashNoCap(
--				"Outbreak Refresh",
--				"Icy Touch Refresh",
--				"Plague Strike Refresh",
--				"Pestilence",
--				"Dark Transformation",
--				"Death Coil for Shadow Infusion",
--				"Death and Decay",
--				"Blood Boil",
--				"Scourge Strike UU",
--				"Death Coil under Sudden Doom if DCisOK",
--				"Icy Touch")
--		else
debugPrint(
			flashNoCap(
				"Outbreak Refresh",
				"Unholy Blight Refresh",
				"Icy Touch for FF",
				"Plague Strike for BP",
				"Plague Leech for Unholy",
				"Summon Gargoyle",
				"Dark Transformation",
				"Death and Decay DB or DF or UU",
				"Scourge Strike DB or DF or UU",
				"Festering Strike BBFF",
				"Death Coil under Sudden Doom",
				"Blood Tap for Unholy",
				"Death and Decay",
				"Scourge Strike",
				"Festering Strike",
				"Death Coil unless Gargoyle",
				"Horn of Winter")
)
--		end
	end,
	
	FlashOutOfCombat = function()
		c.FlashAll("Dark Transformation")
	end,
	
	FlashAlways = function()
		c.FlashAll("Raise Dead", "Unholy Presence")
	end,
	
	CastSucceeded = function(info)
		adjustResourcesForSuccessfulCast(info)
		if c.InfoMatches(info, "Death Coil") then
			a.ShadowInfusionPending = true
			c.Debug("Event", "Shadow Infusion pending")
--		elseif c.InfoMatches(info, "Pestilence") then
--			a.LastPestilence = GetTime()
--			c.Debug("Event", "Pestilence cast")
		end
	end,
	
	SpellMissed = function(spellID, target, spellSchool)
		if spellID == c.GetID("Death Coil") then
			a.ShadowInfusionPending = false
			c.Debug("Event", "Death Coil missed")
		end
	end,
	
	AuraApplied = function(spellID, target, spellSchool)
		if spellID == c.GetID("Shadow Infusion") 
			and UnitIsUnit(target, "player") then
			
			a.ShadowInfusionPending = false
			c.Debug("Event", "Shadow Infusion connected", target)
		end
	end,
	
--	LeftCombat = function()
--		a.LastPestilence = 0
--		c.Debug("Event", "Left combat")
--	end
}
