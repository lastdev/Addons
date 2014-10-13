local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local GetRuneCooldown = GetRuneCooldown
local GetTime = GetTime
local OffhandHasWeapon = OffhandHasWeapon
local UnitGUID = UnitGUID
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
a.Rotations = { }

local function getBump(name, freezingFog, crimsonScourge)
	local cost = a.Costs[name]
	if cost == nil then
		return 0
	end
	
	local bump = cost.BonusRP or 0
	if (not cost.Rime or freezingFog == 0)
		and (name ~= s.SpellName(c.GetID("Blood Boil")) 
			or not crimsonScourge) then
		
		bump = bump + math.max(0, 10 * (cost.Blood + cost.Frost + cost.Unholy))
	end
	if c.HasBuff("Frost Presence") then
		bump = bump * 1.2
	end
	return bump
end

local function consumeRune(runeID, needed, forbidDeath)
	if needed == 0 or (forbidDeath and a.IsDeathRune(runeID)) then
		return needed
	end
	
	local start, duration = GetRuneCooldown(runeID)
	if start + duration < GetTime() then
		a.Runes[runeID] = 100
		return needed - 1
	else
		return needed
	end
end

local function consumesKM(info)
	return c.InfoMatches(info, "Obliterate", "Frost Strike")
end

a.LastSoulReaper = 0
local function adjustResourcesForSuccessfulCast(info)
	if c.InfoMatches(info, "Blood Boil") then
		return -- Blood Boil's RP return is before the cast succeeds
	end
	
	local cost = s.SpellCost(info.Name)
	if cost == 0 then
		local bump = getBump(
			info.Name, 
			s.BuffStack(c.GetID("Freezing Fog"), "player"), 
			s.Buff(c.GetID("Crimson Scourge"), "player"))
		if bump > 0 then
			rpBumped = s.Power("player") + bump
			rpBumpExpires = GetTime() + .8
		end
		if c.InfoMatches(
			info, 
			"Soul Reaper - Frost", 
			"Soul Reaper - Unholy", 
			"Soul Reaper - Blood") then
			
			a.LastSoulReaper = info.GCDStart
			c.Debug("Event", "Soul Reaper Cast", info.GCDStart, GetTime())
		end
--c.Debug("Resources", info.Name, "bump", bump, "->", rpBumped)
	elseif GetTime() < rpBumpExpires then
		rpBumped = rpBumped - cost
	end
end

local function getGenericDebugInfo()
	return string.format(
		"b:%.1f r:%d %s:%.1f %s:%.1f %s:%.1f %s:%.1f %s:%.1f %s:%.1f d:%d b:%d c:%s",
		c.GetBusyTime(),
		a.RP,
		a.IsDeathRune(1) and "d" or "b",
		math.max(0, math.min(9.9, a.Runes[1])),
		a.IsDeathRune(2) and "d" or "b",
		math.max(0, math.min(9.9, a.Runes[2])),
		a.IsDeathRune(5) and "d" or "f",
		math.max(0, math.min(9.9, a.Runes[5])),
		a.IsDeathRune(6) and "d" or "f",
		math.max(0, math.min(9.9, a.Runes[6])),
		a.IsDeathRune(3) and "d" or "u",
		math.max(0, math.min(9.9, a.Runes[3])),
		a.IsDeathRune(4) and "d" or "u",
		math.max(0, math.min(9.9, a.Runes[4])),
		a.PendingDeathRunes,
		a.BloodCharges,
		tostring(a.CrimsonScourge))
end

local spellIfCapped
local function flashNoCap(...)
	local flashed
	for i = 1, select("#", ...) do
		local name = select(i, ...)
		if c.Flashable(name) then
			local spell = c.GetSpell(name)
			local bump = getBump(
				s.SpellName(spell.ID), a.FreezingFog, a.CrimsonScourge)
			if bump == 0 or a.RP + bump <= s.MaxPower("player") then
				local color = spell.FlashColor
				if c.AoE and color == nil then
					color = "purple"
				end
				s.Flash(spell.ID, color, spell.FlashSize)
				if spell.Continue then
					flashed = name
				else
					c.Debug("Flash", getGenericDebugInfo(), name)
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

local function flashInterrupts()
	if c.FlashAll("Mind Freeze") then
		return
	end
	if c.HasSpell("Asphyxiate") then
		c.FlashAll("Asphyxiate")
	else
		c.FlashAll("Strangulate")
	end
end

function a.HornOfWinterBonus()
	if c.HasGlyph("Loud Horn") then
		return 20
	else
		return 10
	end
end

function a.PreFlash()
	
	a.Costs[s.SpellName(c.GetID("Horn of Winter"))].BonusRP = 
		a.HornOfWinterBonus()
	
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
	
	-- grab Crimson Scourge
	a.CrimsonScourge = c.HasBuff("Crimson Scourge")
	
	-- grab Blood Charge
	a.BloodCharges = c.GetBuffStack("Blood Charge")
	if c.IsCasting("Blood Tap") then
		a.BloodCharges = a.BloodCharges - 5
	end
	if c.IsCasting("Rune Strike", "Death Coil", "Frost Strike") then
		a.BloodCharges = a.BloodCharges + 2
	end
	
	-- adjust resources for queued spell
	local info = c.GetQueuedInfo()
	a.PendingDeathRunes = 0
	if info then
		local cost = s.SpellCost(info.Name)
		if cost > 0 then
			a.RP = a.RP - cost
		else
			a.RP = a.RP + getBump(info.Name, a.FreezingFog, a.CrimsonScourge)
		end
		if c.IsQueued("Empower Rune Weapon") then
			for i = 1, 6 do
				a.Runes[i] = 0
			end
		else
			if c.IsQueued("Blood Tap") then
				a.PendingDeathRunes = a.PendingDeathRunes + 1
			end
			if c.IsQueued("Plague Leech") then
				a.PendingDeathRunes = a.PendingDeathRunes + 2
			end
		end
		local cost = a.Costs[info.Name]
		if s.Buff(c.GetID("Crimson Scourge"), "player") 
			and c.InfoMatches(info, "Blood Boil", "Death and Decay") then
			
			a.CrimsonScourge = false
		elseif cost then
			local blood = cost.Blood
			local frost = cost.Rime and a.FreezingFog > 0 and 0 or cost.Frost
			local unholy = cost.Unholy
			
			-- consume colored runes
			blood = consumeRune(1, blood, true)
			blood = consumeRune(2, blood, true)
			frost = consumeRune(5, frost, true)
			frost = consumeRune(6, frost, true)
			unholy = consumeRune(3, unholy, true)
			unholy = consumeRune(4, unholy, true)
			
			-- consume matching-color death runes
			blood = consumeRune(1, blood)
			blood = consumeRune(2, blood)
			frost = consumeRune(5, frost)
			frost = consumeRune(6, frost)
			unholy = consumeRune(3, unholy)
			unholy = consumeRune(4, unholy)
			
			-- consume death runes indiscriminately
			local death = cost.Death + blood + frost + unholy
			death = consumeRune(1, death)
			death = consumeRune(2, death)
			death = consumeRune(5, death)
			death = consumeRune(6, death)
			death = consumeRune(3, death)
			death = consumeRune(4, death)
			a.PendingDeathRunes = a.PendingDeathRunes - death
		end
		if consumesKM(info) then
			a.KillingMachine = false
		end
		if a.FreezingFog > 0
			and c.IsQueued("Howling Blast", "Icy Touch") then
			
			a.FreezingFog = a.FreezingFog - 1
		end
	end
	
	a.InExecute = s.HealthPercent() < (c.WearingSet(4, "DpsT15") and 45 or 35)
end

------------------------------------------------------------------------- Blood
local uncontrolledMitigationBuffs = {
	"Anti-Magic Shell",
}

a.BloodPlagueRefreshPending = 0

a.Rotations.Blood = {
	Spec = 1,
	
	UsefulStats = { 
		"Stamina", "Strength", "Dodge", "Parry", "Melee Hit", "Haste" 
	},
	
	FlashInCombat = function()
		flashInterrupts()
		a.SetCost(1, 0, 0, 0, "Soul Reaper - Blood")
		c.FlashAll(
			"Rune Tap", 
			"Dark Command", 
			"Death Grip",
			"Conversion Cancel",
			"Horn of Winter for Buff, Optional")
		c.FlashMitigationBuffs(
			2,
			uncontrolledMitigationBuffs,
			c.COMMON_TANKING_BUFFS,
			"Death Pact",
			"Dancing Rune Weapon Prime",
			"Bone Shield",
			"Vampiric Blood",
			"Dancing Rune Weapon",
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
						"Soul Reaper - Blood B",
						"Heart Strike B",
						"Rune Strike",
						"Horn of Winter")
				else
					flashNoCap(
						"Death and Decay",
						"Outbreak",
						"Blood Boil for AoE or Free",
						"Soul Reaper - Blood",
						"Heart Strike",
						"Death Strike",
						"Rune Strike",
						"Horn of Winter")
				end
			else
				flashNoCap(
					"Outbreak",
					"Unholy Blight",
					"Icy Touch for Frost Fever",
					"Plague Strike for Blood Plague",
					"Death Strike",
					"Soul Reaper - Blood BB",
					"Heart Strike BB",
					"Blood Boil Free",
					"Rune Strike for Resources",
					"Soul Reaper - Blood",
					"Heart Strike",
					"Rune Strike",
					"Horn of Winter")
			end
		else
			c.PriorityFlash(
				"Death Strike for Health",
				"Death Strike to Save Shield",
				"Blood Tap for Death Strike",
				"Death Siphon for Health",
				"Outbreak for Weakened Blows",
				"Plague Strike for Weakened Blows",
				"Rune Strike for Resources if Capped",
				"Death Strike if Two Available",
				"Blood Boil for Weakened Blows",
				"Rune Strike for Resources",
				"Horn of Winter for Buff",
				"Soul Reaper - Blood for Runic Power unless AoE",
				"Heart Strike for Runic Power unless AoE",
				"Blood Boil for Runic Power",
				"Horn of Winter for Runic Power",
				"Rune Strike for Runic Corruption",
				"Plague Leech if Outbreak",
				"Death and Decay without Consequence",
				"Blood Boil Free",
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
			
			a.BloodPlagueRefreshPending = GetTime()
			c.Debug("Event", "Blood Plague refresh pending")
		end
	end,
	
	SpellMissed = function(spellID, _, targetID)
		if c.IdMatches(spellID, "Blood Boil") then
			if targetID == UnitGUID("target") then
				a.BloodPlagueRefreshPending = 0
				c.Debug("Event", "Blood Plague refresh missed")
			end
		end
	end,
	
	AuraApplied = function(spellID, _, targetID)
		if spellID == c.GetID("Blood Plague") then
			if targetID == UnitGUID("target") then
				a.BloodPlagueRefreshPending = 0
				c.Debug("Event", "Blood Plague applied")
			end
		elseif spellID == c.GetID("Scent of Blood") then
			c.Debug("Event", "Scent of Blood")
		end
	end,
	
	ExtraDebugInfo = getGenericDebugInfo,
}

------------------------------------------------------------------------- Frost
a.Rotations.Frost = {
	Spec = 2,
	
	UsefulStats = { "Strength", "Melee Hit", "Crit", "Haste" },
	
	FlashInCombat = function()
		a.SetCost(0, 1, 0, 0, "Soul Reaper - Frost")
		flashInterrupts()
		c.FlashAll(
			"Pillar of Frost", 
			"Raise Dead",
			"Death Siphon",
			"Horn of Winter for Buff, Optional")
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
				"Plague Leech",
				"Horn of Winter")
		elseif OffhandHasWeapon() then
			flashing = c.PriorityFlash(
				"Frost Strike under KM",
				"Frost Strike at 88",
				"Soul Reaper - Frost",
				"Blood Tap for Soul Reaper - Frost",
				"Howling Blast BB or FF",
				"Unholy Blight",
				"Howling Blast for Frost Fever",
				"Plague Strike for Blood Plague",
				"Howling Blast under Freezing Fog",
				"Frost Strike at 76",
				"Obliterate U w/out KM",
				"Howling Blast",
				"Frost Strike for Runic Empowerment",
				"Blood Tap at 8 or Non-Execute",
				"Frost Strike at 40",
				"Horn of Winter",
				"Death Coil at 60",
				"Blood Tap",
				"Plague Leech",
				"Empower Rune Weapon",
				"Death and Decay U",
				"Plague Strike U")
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
		return string.format("%s k:%s f:%d",
			getGenericDebugInfo(),
			tostring(a.KillingMachine),
			a.FreezingFog)
	end
}

------------------------------------------------------------------------ Unholy
--a.LastPestilence = 0
a.DTCast = 0

a.Rotations.Unholy = {
	Spec = 3,
	
	UsefulStats = { "Strength", "Melee Hit", "Crit", "Haste" },
	
	FlashInCombat = function()
		a.SetCost(0, 0, 1, 0, "Soul Reaper - Unholy")
		flashInterrupts()
		c.FlashAll(
			"Unholy Frenzy",
			"Death Siphon",
			"Horn of Winter for Buff, Optional")
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
		elseif c.InfoMatches(info, "Dark Transformation") then
			a.DTCast = GetTime()
			c.Debug("Event", "Dark Transformation Cast")
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
		return string.format("%s i:%d i:%s",
			getGenericDebugInfo(),
			s.BuffStack(c.GetID("Shadow Infusion"), "pet"),
			tostring(a.ShadowInfusionPending))
	end,
}
