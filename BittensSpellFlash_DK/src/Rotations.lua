local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local GetRuneCooldown = GetRuneCooldown
local GetTime = GetTime
local OffhandHasWeapon = OffhandHasWeapon
local UnitIsUnit = UnitIsUnit
local math = math
local select = select
local string = string
local tostring = tostring

local rpBumped = 0
local rpBumpExpires = 0
local suppressKM = false
a.Runes = { 0, 0, 0, 0, 0, 0 }
a.PendingDeathRunes = 0
a.Rotations = {}

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

a.LastSoulReaper = 0
local function adjustResourcesForSuccessfulCast(info)
	local cost = s.SpellCost(info.Name)
	if cost == 0 and not c.InfoMatches(info, "Blood Boil") then
		local bump = getBump(
			info.Name, s.BuffStack(c.GetID("Freezing Fog"), "player"))
		if bump > 0 then
			rpBumped = s.Power("player") + bump
			rpBumpExpires = GetTime() + .8
		end
		if c.InfoMatches(
			info, "Soul Reaper - Frost", "Soul Reaper - Unholy") then
			
			a.LastSoulReaper = info.GCDStart
		end
--c.Debug("Resources", info.Name, "bump", bump, "->", rpBumped)
	elseif GetTime() < rpBumpExpires then
		rpBumped = rpBumped - cost
	end
end

local spellIfCapped
local function flashNoCap(...)
	local flashed
	for i = 1, select("#", ...) do
		local name = select(i, ...)
		local spell = c.GetSpell(name)
		if s.Flashable(spell.ID) and s.Castable(spell) then
			local bump = getBump(s.SpellName(spell.ID), a.FreezingFog)
			if bump == 0 or a.RP + bump <= s.MaxPower("player") then
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

local function getGenericDebugInfo()
	return string.format(
		"%d %.1f %.1f %.1f %.1f %.1f %.1f %d %d",
		a.RP,
		math.max(0, math.min(9.9, a.Runes[1])),
		math.max(0, math.min(9.9, a.Runes[2])),
		math.max(0, math.min(9.9, a.Runes[5])),
		math.max(0, math.min(9.9, a.Runes[6])),
		math.max(0, math.min(9.9, a.Runes[3])),
		math.max(0, math.min(9.9, a.Runes[4])),
		a.PendingDeathRunes,
		a.BloodCharges)
end

function a.PreFlash()
	
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
	
	-- grab Blood Charge
	a.BloodCharges = c.GetBuffStack("Blood Charge")
	if c.IsCasting("Blood Charge") then
		a.BloodCharges = a.BloodCharges - 5
	end
	
	-- adjust resources for queued spell
	local info = c.GetQueuedInfo()
	a.PendingDeathRunes = 0
	if info then
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
end

------------------------------------------------------------------------- Blood
local uncontrolledMitigationBuffs = {
	"Anti-Magic Shell",
	"Anti-Magic Zone",
}

a.Rotations.Blood = {
	Spec = 1,
	
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
			"Death Pact",
			"Dancing Rune Weapon",
			"Bone Shield",
			"Vampiric Blood",
			"Icebound Fortitude Glyphed",
			"Raise Dead for Death Pact",
			"Conversion",
			"Icebound Fortitude Unglyphed")
		if c.IsSolo() then
			spellIfCapped = "Rune Strike"
			c.FlashAll("Blood Tap")
			if c.AoE then
				if a.ShouldDeathStrikeForHealth() then
					flashNoCap(
						"Death Strike",
						"Death and Decay Free",
						"Blood Boil for AoE B or Free",
						"Heart Strike B",
						"Rune Strike unless DRW",
						"Horn of Winter")
				else
					flashNoCap(
						"Death and Decay",
						"Outbreak",
						"Blood Boil for AoE",
						"Heart Strike",
						"Death Strike",
						"Rune Strike unless DRW",
						"Horn of Winter")
				end
			else
				flashNoCap(
					"Outbreak",
					"Unholy Blight",
					"Icy Touch for Frost Fever",
					"Plague Strike for Blood Plague",
					"Death Strike",
					"Heart Strike BB",
					"Blood Boil for Runic Power",
					"Rune Strike for Resources unless DRW",
					"Heart Strike",
					"Rune Strike unless DRW",
					"Horn of Winter")
			end
		else
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
				"Heart Strike for Runic Power unless AoE",
				"Blood Boil for Runic Power",
				"Horn of Winter for Runic Power",
				"Outbreak Early")
		end
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
	
	ExtraDebugInfo = getGenericDebugInfo,
}

------------------------------------------------------------------------- Frost
a.Rotations.Frost = {
	Spec = 2,
	
	FlashInCombat = function()
		a.SetCost(0, 1, 0, 0, "Soul Reaper - Frost")
		c.FlashAll(
			"Pillar of Frost", 
			"Raise Dead",
			"Mind Freeze",
			"Death Siphon")
		local flashing
		if c.AoE then
			flashing = c.PriorityFlash(
				"Frost Strike under KM",
				"Frost Strike at 88",
				"Death and Decay UU",
				"Howling Blast BB or FF or DU",
				"Plague Strike UU",
				"Death and Decay",
				"Howling Blast",
				"Frost Strike for Resources",
				"Plague Strike unless RE",
				"Blood Tap",
				"Plague Leech")
		elseif OffhandHasWeapon() then
			flashing = c.PriorityFlash(
				"Frost Strike under KM",
				"Frost Strike at 88",
				"Plague Leech at 2",
				"Outbreak at 2",
				"Unholy Blight at 2",
				"Soul Reaper - Frost",
				"Blood Tap for Soul Reaper - Frost",
				"Howling Blast for Frost Fever",
				"Plague Strike for Blood Plague",
				"Howling Blast under Freezing Fog",
				"Frost Strike at 76",
				"Obliterate UU",
				"Howling Blast BB or FF",
				"Plague Leech if Outbreak",
				"Horn of Winter",
				"Obliterate U",
				"Howling Blast",
				"Frost Strike for Resources except Blood Charge",
				"Blood Tap at 8 or Non-Execute",
				"Death and Decay",
				"Frost Strike at 40",
				"Death Coil at 60",
				"Empower Rune Weapon")
		else
			flashing = c.PriorityFlash(
				"Plague Leech at 1",
				"Outbreak",
				"Unholy Blight",
				"Soul Reaper - Frost",
				"Blood Tap for Soul Reaper - Frost",
				"Howling Blast for Frost Fever",
				"Plague Strike for Blood Plague",
				"Howling Blast under Freezing Fog",
				"Obliterate under KM",
				"Blood Tap for OB KM",
				"Frost Strike at 76",
				"Obliterate BB or FF or UU",
				"Plague Leech at 3",
				"Outbreak at 3",
				"Unholy Blight at 3",
				"Horn of Winter",
				"Frost Strike for Resources",
				"Obliterate",
				"Frost Strike",
				"Death Coil at 60",
				"Plague Leech",
				"Empower Rune Weapon")
		end
		if flashing then
			local id = c.GetSpell(flashing).ID
			if id == c.GetID("Frost Strike") or id == c.GetID("Death Coil") then
				c.FlashAll("Blood Tap at 11")
			end
		end
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
	
	AuraApplied = function(spellID)
		if spellID == c.GetID("Killing Machine") then
			suppressKM = false
			c.Debug("Event", "New KM")
		end
	end,
	
	AuraRemoved = function(spellID)
		if spellID == c.GetID("Killing Machine") then
			suppressKM = false
			c.Debug("Event", "KM is really gone")
		end
	end,
	
	ExtraDebugInfo = function()
		return string.format("%s %s %d",
			getGenericDebugInfo(),
			tostring(a.KillingMachine),
			a.FreezingFog)
	end
}

------------------------------------------------------------------------ Unholy
--a.LastPestilence = 0

a.Rotations.Unholy = {
	Spec = 3,
	
	FlashInCombat = function()
		a.SetCost(0, 0, 1, 0, "Soul Reaper - Unholy")
		c.FlashAll(
			"Unholy Frenzy",
			"Mind Freeze",
			"Death Siphon")
		local flashing
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
			flashing = c.PriorityFlash(
				"Outbreak",
				"Unholy Blight",
				"Soul Reaper - Unholy",
				"Blood Tap for Soul Reaper - Unholy",
				"Plague Strike for Both Diseases",
				"Summon Gargoyle",
				"Dark Transformation",
				"Blood Tap for Dark Transformation",
				"Death Coil at 90",
				"Death and Decay UU",
				"Scourge Strike UU",
				"Festering Strike BBFF",
				"Death and Decay unless Soul Reaper",
				"Blood Tap for D&D",
				"Death Coil under Sudden Doom or for Dark Transformation",
				"Scourge Strike unless Soul Reaper",
				"Plague Leech if Outbreak",
				"Festering Strike",
				"Horn of Winter",
				"Death Coil unless Gargoyle or Dark Transformation",
				"Blood Tap at 8 or for Dark Transformation",
				"Empower Rune Weapon")
--		end
		if flashing and c.GetSpell(flashing).ID == c.GetID("Death Coil") then
			c.FlashAll("Blood Tap at 11")
		end
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
	
	SpellMissed = function(spellID)
		if spellID == c.GetID("Death Coil") then
			a.ShadowInfusionPending = false
			c.Debug("Event", "Death Coil missed")
		end
	end,
	
	AuraApplied = function(spellID, target)
		if spellID == c.GetID("Shadow Infusion") 
			and UnitIsUnit(target, "pet") then
			
			a.ShadowInfusionPending = false
			c.Debug("Event", "Shadow Infusion connected", target)
		end
	end,
	
--	LeftCombat = function()
--		a.LastPestilence = 0
--		c.Debug("Event", "Left combat")
--	end,
	
	ExtraDebugInfo = function()
		return string.format("%s %d %s %s",
			getGenericDebugInfo(),
			s.BuffStack(c.GetID("Shadow Infusion"), "pet"),
			tostring(a.ShadowInfusionPending),
tostring(not not c.IsAuraPendingFor("Plague Strike")))
	end,
}
