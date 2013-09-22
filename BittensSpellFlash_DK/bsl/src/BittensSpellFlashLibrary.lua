local g = BittensGlobalTables
local c = g.GetOrMakeTable("BittensSpellFlashLibrary", 2)
local u = g.GetTable("BittensUtilities")
if u.SkipOrUpgrade(c, "MainFile", 34) then
	return
end

local s = SpellFlashAddon
local x = s.UpdatedVariables

local GetItemCount = GetItemCount
local GetNumGroupMembers = GetNumGroupMembers
local GetPowerRegen = GetPowerRegen
local GetSpecialization = GetSpecialization
local GetTime = GetTime
local GetTotemInfo = GetTotemInfo
local IsInRaid = IsInRaid
local IsItemInRange = IsItemInRange
local IsMounted = IsMounted
local UnitGetIncomingHeals = UnitGetIncomingHeals
local UnitIsDeadOrGhost = UnitIsDeadOrGhost
local UnitGroupRolesAssigned = UnitGroupRolesAssigned
local UnitHealth = UnitHealth
local UnitHealthMax = UnitHealthMax
local UnitIsUnit = UnitIsUnit
local UnitInVehicle = UnitInVehicle
local UnitPower = UnitPower
local UnitPowerMax = UnitPowerMax
local UnitPowerType = UnitPowerType
local UnitSpellHaste = UnitSpellHaste
local UnitThreatSituation = UnitThreatSituation
local math = math
local pairs = pairs
local print = print
local select = select
local string = string
local table = table
local type = type
local unpack = unpack

function c.Init(a)
	c.A = a
end

local healthstone = {
	ID = 5512,
	Type = "item",
	Continue = true,
	FlashColor = "yellow",
	CheckFirst = function(z)
		return c.GetHealthPercent("player") < 80 
			and GetItemCount(z.ID, false, true) > 0
	end,
}

local function auraCheck(spell, id, pending, func, early)
	return id 
		and (pending 
			or func(id, spell.BuffUnit, early, nil, nil, spell.UseBuffID))
end

local function spellCastable(spell)
	if spell.Type == "form" and s.Form(spell.ID) then
		return false
	end
	
	if c.GetCooldown(spell.ID, spell.NoGCD) > 0 then
		return false -- TODO: Add lag or cushion?
	end
	
	local isUsable, notEnoughPower = s.UsableSpell(spell.ID)
	if notEnoughPower then
		if not spell.NoPowerCheck then
			return false
		end
	elseif not isUsable and not spell.EvenIfNotUsable then
		return false
	end
	
	if not (spell.NoRangeCheck or spell.Melee or spell.Range) 
		and s.SpellHasRange(spell.ID) 
		and not s.SpellInRange(spell.ID) then
		
		return false
	end
	
	return true
end

local overrideColor

local function getFlashColor(spell, rotation)
	return spell.FlashColor 
		or (c.AoE and (rotation and rotation.AoEColor or c.AoeColor))
end

local function flashSingle(spell, rotation)
	if spell.RunFirst then
		spell:RunFirst()
	end
	if spell.CheckFirst and not spell:CheckFirst() then
		return false
	end
	
	if (spell.NotIfActive or spell.Cooldown) and c.IsCasting(spell.ID) then
		return false
	end
	
	if spell.Buff 
		or spell.MyDebuff 
		or spell.Debuff 
		or spell.MyBuff 
		or spell.Interrupt
		or spell.Dispel then
		
		local early = 
			c.GetBusyTime(spell.NoGCD) + math.max(0, s.CastTime(spell.ID) or 0)
		if spell.Interrupt 
			and s.GetCastingOrChanneling(nil, nil, true) - early <= 0 then
			
			return false -- TODO: Add lag or cushion?
		end
		
		if spell.Dispel 
			and not s.Buff(nil, nil, early, nil, nil, nil, spell.Dispel) then
			
			return false
		end
		
		local pending = c.IsAuraPendingFor(spell.ID)
		early = early + (spell.EarlyRefresh or 0)
		if auraCheck(spell, spell.Buff, pending, s.Buff, early) 
			or auraCheck(spell, spell.MyDebuff, pending, s.MyDebuff, early)
			or auraCheck(spell, spell.Debuff, pending, s.Debuff, early)
			or auraCheck(spell, spell.MyBuff, pending, s.MyBuff, early) then
			
			return false
		end
	end
	
	if spell.Melee and not s.MeleeDistance() then
		return false
	end
	
	if spell.Range and c.DistanceAtTheMost() > spell.Range then
		return false
	end
	
	if spell.NotWhileMoving and s.Moving("player") then
		return false
	end
	
	local flashableFunc = nil
	local castableFunc
	local flashFunc1 = s.Flash
	local flashFunc2 = nil
	if spell.Type == "item" then
		flashableFunc = s.ItemFlashable
		castableFunc = s.CheckIfItemCastable
		flashFunc1 = s.FlashItem
	elseif spell.Type == "pet" then
		castableFunc = s.CheckIfPetSpellCastable
		flashFunc2 = s.FlashPet
	elseif spell.Type == "form" then
		castableFunc = spellCastable
		flashFunc2 = s.FlashForm
	else
		flashableFunc = s.Flashable
		castableFunc = spellCastable
	end
	if spell.Override then
		castableFunc = spell.Override
	end
	local flashID = spell.FlashID or spell.ID
	if (flashableFunc and not flashableFunc(flashID))
		or not castableFunc(spell)
		or (spell.CheckLast and not spell:CheckLast()) then
		
		return false
	end
	
	local color = overrideColor or getFlashColor(spell, rotation)
	flashFunc1(flashID, color, spell.FlashSize)
	if flashFunc2 then
		flashFunc2(flashID, color, spell.FlashSize)
	end
	if spell.PredictFlashID then
		c.PredictFlash(spell.PredictFlashID)
	end
	return true
end

function c.RegisterAddon()
	c.RegisterForEvents()
	c.RegisterOptions()
	
	local a = c.A
	u.GetOrMakeTable(a, "SpecialGCDs")
	s.RegisterModuleSpamFunction(a.AddonName, function()
		c.Init(a)
		local rotation = c.GetCurrentRotation()
		if rotation == nil then
			c.DisableProcHighlights = false
			return
		end
		c.DisableProcHighlights = not c.AlwaysShowBlizHighlights
		
		local inCombat = s.InCombat()
		if (IsMounted() and not inCombat) 
			or UnitIsDeadOrGhost("player") 
			or UnitInVehicle("player") then
			
			return
		end
		
		if a.PreFlash then
			a.PreFlash()
		end
		
		if rotation.FlashAlways then
			rotation:FlashAlways()
		end
		if inCombat then
			if rotation.FlashInCombat then
				rotation:FlashInCombat()
				flashSingle(healthstone)
			end
		else
			if rotation.FlashOutOfCombat then
				rotation:FlashOutOfCombat()
			end
			if x.EnemyDetected and rotation.UsefulStats then
				c.FlashFoods(rotation.UsefulStats)
			end
		end
	end)
end

function c.GetCurrentRotation()
	for name, rotation in pairs(c.A.Rotations) do
		local optionName = "Flash" .. name
		if (rotation.CheckFirst == nil or rotation.CheckFirst())
			and rotation.Spec == GetSpecialization()
			and (not c.HasOption(optionName) or c.GetOption(optionName)) then
			
			return rotation
		end
	end
end

function c.GetSpell(name)
	if c.A.Spells then
		local spell = c.A.Spells[name]
		if spell == nil then
			spell = c.AddSpell(name)
		end
		return spell
	else
		return c.A.spells[name]
	end
end

function c.GetCooldown(name, noGCD, fullCD)
	local id = c.GetID(name)
	if not c.HasSpell(id) then
		return 9001 -- (more than 9000!)
	end
	
	if fullCD and c.IsCasting(id) then
		return fullCD
	else
		return math.max(0, s.SpellCooldown(id) - c.GetBusyTime(noGCD))
	end
end

function c.GetMinCooldown(...)
	local min
	local minName
	for i = 1, select("#", ...) do
		local name = select(i, ...)
		local cd = c.GetCooldown(name)
		if min == nil or cd < min then
			min = cd
			minName = name
		end
	end
	return min, minName
end

function c.GetIDs(...)
	local ids = {}
	for i = 1, select("#", ...) do
		local id = c.GetID(select(i, ...))
		if id then
			table.insert(ids, id)
		end
	end
	return ids
end

function c.GetID(name)
	if type(name) == "number" or type(name) == "table" then
		return name
	end
	
	local id
	if c.A.SpellIDs == nil then
		local spell = c.A.spells[name]
		if spell ~= nil then
			id = spell.ID
		end
	else
		id = c.A.SpellIDs[name]
	end
	if id then
		return id
   	else
  	  	print("No spell defined (or no ID attribute):", name)
  	end
end

local tankingByTarget = {
	[60143] = true, -- Gara'jal the Spiritbinder
	[2938] = true, -- lost name.  a scenario "boss".
}

function c.IsTanking()
	
	-- Gara'jal (the Spiritbinder) does not attack his primary threat target
	-- most of the time.  Instead he attacks the person he put the voodoo thing
	-- on.
	local _, targetID = s.UnitInfo()
	if tankingByTarget[targetID] then 
		return UnitIsUnit("targettarget", "player")
	else
		local status = UnitThreatSituation("player", "target")
		return status == 2 or status == 3
	end
end

function c.CheckFirstForTaunts(z)
	local primaryTarget = s.GetPrimaryThreatTarget()
	if not primaryTarget or UnitIsUnit(primaryTarget, "player") then
		return false
	end
	
	if UnitGroupRolesAssigned(primaryTarget) == "TANK" then
		z.FlashSize = s.FlashSizePercent() / 2
		z.FlashColor = "yellow"
	else
		z.FlashSize = nil
		z.FlashColor = "red"
	end
	return true
end

function c.WearingSet(number, name)
	local count = 0
	for slot, piece in pairs(c.A.EquipmentSets[name]) do
		if s.Equipped(piece, slot) then
			count = count + 1
		end
	end
	return count >= number
end

function c.HasTalent(name)
	local id = c.A.TalentIDs[name]
	if id == nil then
		print('No talent defined:', name)
	else
		return not not s.HasTalent(id)
	end
end

function c.GetTalentRank(name)
	local id = c.A.TalentIDs[name]
	if id == nil then
		print('No talent defined:', name)
	else
		return s.TalentRank(id)
	end
end

function c.HasGlyph(name)
	local id = c.A.GlyphIDs[name]
	if id == nil then
		print('No glyph defined:', name)
	else
		return s.HasGlyph(id)
	end
end

function c.GetCastTime(spellName)
	return s.CastTime(s.SpellName(c.GetID(spellName)))
end

function c.GetCost(spellName)
	return s.SpellCost(s.SpellName(c.GetID(spellName)))
end

local fullChannels = {}

function c.RegisterForFullChannels(name, unhastedChannelTime)
	fullChannels[s.SpellName(c.GetID(name))] = unhastedChannelTime
end

function c.GetBusyTime(noGCD)
	local info = c.GetQueuedInfo()
	local gcd, _ = s.GlobalCooldown()
	if info then
		local castTime = fullChannels[info.Name]
		if castTime ~= nil then
			castTime = c.GetHastedTime(castTime)
		else
			castTime = s.CastTime(info.Name)
		end
		if noGCD then
			return math.max(0, info.CastStart + castTime - GetTime())
		else
			local nextGcd = c.A.SpecialGCDs[info.Name]
			if nextGcd == nil then
				nextGcd = c.LastGCD
			elseif nextGcd == "hasted" then
				nextGcd = math.max(1, c.GetHastedTime(1.5))
			end
--c.Debug("GetBusyTime", gcd, nextGcd, castTime)
			return math.max(
				gcd,
				math.max(
						info.GCDStart + nextGcd, info.CastStart + castTime)
					- GetTime())
		end
	end
	
	local remaining
	if fullChannels[s.ChannelingName(nil, "player")] then
		remaining = s.GetChanneling(nil, "player")
	else
		remaining = s.GetCasting(nil, "player")
	end
	if noGCD then
		return remaining
	else
		return math.max(remaining, gcd)
	end
end

-- If you supply a powerType it will not consider any currently casting spell.
-- But that should be OK, since I can only think of instant cast spells that use
-- secondary power.
function c.GetPower(regen, powerType)
	local power = UnitPower("player", powerType)
	local max = UnitPowerMax("player", powerType)
	local t = GetTime()
	local busy = s.GetCastingOrChanneling(nil, "player")
	if not regen then
		regen = select(2, GetPowerRegen())
	end
	
--c.Debug("Lib", power, "--------")
	local info = c.GetCastingInfo()
	if info and (not powerType or powerType == UnitPowerType("player")) then
		power = math.min(max, power + busy * regen)
		power = math.min(max, power - info.Cost)
		t = t + busy
--c.Debug("Lib", power, info.Name, "cast", busy)
	end
	
	info = c.GetQueuedInfo()
	if info then
		local castTime = s.CastTime(info.Name)
		local busy = castTime + (info.CastStart - t)
		power = math.min(max, power + busy * regen)
		power = math.min(
			max, power - (info.Cost or s.SpellCost(info.Name, powerType)))
		t = t + busy
--c.Debug("Lib", power, info.Name, "queue", busy)
		
		busy = math.max(0, info.GCDStart + c.LastGCD - t)
		power = math.min(max, power + busy * regen)
--c.Debug("Lib", power, "gcd", busy)
	else
		local gcd = s.GlobalCooldown()
		busy = math.max(0, gcd - busy)
		power = math.min(max, power + busy * regen)
--c.Debug("Lib", power, "gcd", busy)
	end
	return power
end

local function convertToIDs(attributes, key, ...)
	if string.find(key, "Use") then
		return
	end
	for i = 1, select("#", ...) do
		local pattern = select(i, ...)
		local _, last = string.find(key, pattern)
		if last == #key then
			local value = attributes[key]
			if type(value) == "table" then
				attributes[key] = c.GetIDs(unpack(value))
			else
				attributes[key] = c.GetID(value)
			end
		end
	end
end

function c.AddSpell(spellName, tag, attributes)
	local name = spellName
	if tag then
		name = name .. " " .. tag
	end
	if c.A.Spells == nil then
		c.A.Spells = { }
		c.A.AurasToSpells = { }
	elseif c.A.Spells[name] then
		print("Warning:", name, "is already defined")
	end
	if attributes == nil then
		attributes = { }
	end
	for k, v in pairs(attributes) do
		convertToIDs(attributes, k, "ID", "Debuff%d*", "Buff%d*")
	end
	if attributes.ID == nil then
		attributes.ID = c.GetID(spellName)
	end
	c.A.Spells[name] = attributes
	
	if attributes.Applies then
		for _, aura in pairs(attributes.Applies) do
			u.GetOrMakeTable(c.A.AurasToSpells, c.GetID(aura))[attributes.ID] = 
				true
		end
	end
	
	local localizedName = s.SpellName(attributes.ID, true)
	if attributes.SpecialGCD then
		u.GetOrMakeTable(c.A, "SpecialGCDs")[localizedName] 
			= attributes.SpecialGCD
	elseif attributes.NoGCD then
		u.GetOrMakeTable(c.A, "SpecialGCDs")[localizedName] = 0
	end
	
	if attributes.Tick then
		attributes.EarlyRefresh = attributes.Tick
		c.ManageDotRefresh(name, attributes.Tick, attributes.ID)
	end
	
	return attributes
end

function c.AddOptionalSpell(name, tag, attributes, color)
	local spell = c.AddSpell(name, tag, attributes)
	spell.Continue = true
	if color ~= nil then
		spell.FlashColor = color
	elseif spell.FlashColor == nil then
		spell.FlashColor = "yellow"
	end
	return spell
end

function c.AddInterrupt(name, tag, attributes)
	local spell = c.AddOptionalSpell(name, tag, attributes)
	spell.Interrupt = true
	spell.FlashColor = "aqua"
	return spell
end

function c.AddDispel(name, tag, type, attributes)
	local spell = c.AddOptionalSpell(name, tag, attributes)
	spell.Dispel = type
	spell.FlashColor = "aqua"
	return spell
end

function c.AddTaunt(name, tag, attributes)
	local spell = c.AddOptionalSpell(name, tag, attributes)
	spell.CheckFirst = c.CheckFirstForTaunts
	return spell
end

c.AoeColor = { r = .25, g = .25, b = 1 }
c.MovementColor = "orange"

function c.PredictFlash(name)
	s.Flash(c.GetID(name), "green", s.FlashSizePercent() / 2)
end

function c.PriorityFlash(...)
	local flashed = nil
	local moving = s.Moving("player")
	local rotation = c.GetCurrentRotation()
	local movementFallthrough = 
		not overrideColor and rotation.MovementFallthrough
	for i = 1, select("#", ...) do
		local name = select(i, ...)
		local spell = c.GetSpell(name)
		local canCastWhileMoving = spell.CanCastWhileMoving
		if canCastWhileMoving == nil then
			canCastWhileMoving = c.GetCastTime(spell.ID) == 0
		end
		if (canCastWhileMoving or not moving or overrideColor == nil)
			and flashSingle(spell, rotation) then
			
			flashed = name
			if not spell.Continue then
				if moving and movementFallthrough and not canCastWhileMoving then
					overrideColor = c.MovementColor
				else
					movementFallthrough = nil
					break
				end
			end
		end
	end
	if rotation.ExtraDebugInfo then
		c.Debug("Flash", rotation.ExtraDebugInfo(), flashed)
	else
		c.Debug("Flash", flashed)
	end
	if movementFallthrough and overrideColor then
		rotation:MovementFallthrough()
	end
	overrideColor = nil
	return flashed
end

local function auraDelay(spell, aura, func, early)
	if aura then
		return func(aura, false, spell.UseBuffID, spell.ID) - early
	else
		return 0
	end
end

local function getDelay(spell)
	if spell.RunFirst then
		spell:RunFirst()
	end
	
	if spell.CheckFirst and not spell:CheckFirst() then
		return false
	end
	
	if spell.Melee then
		if not s.MeleeDistance() then
			return nil
		end
	elseif not spell.NoRangeCheck 
		and s.SpellHasRange(spell.ID) 
		and not s.SpellInRange(spell.ID) then
		
		return false
	end
	
	if spell.Range and c.DistanceAtTheMost() > spell.Range then
		return nil
	end
	
	-- TODO support items? forms? pet spells?
	if not s.Flashable(spell.FlashID or spell.ID) then
		return nil
	end
	
	if spell.GetDelay then
		return spell:GetDelay()
	end
	
	local early = (spell.EarlyRefresh or 0) + c.GetCastTime(spell.ID)
	return math.max(
		auraDelay(spell, spell.Buff, c.GetBuffDuration, early),
		auraDelay(spell, spell.MyDebuff, c.GetMyDebuffDuration, early),
		auraDelay(spell, spell.Debuff, c.GetDebuffDuration, early),
		auraDelay(spell, spell.MyBuff, c.GetMyBuffDuration, early),
		spell.Cooldown 
			and c.GetCooldown(spell.ID, spell.NoGCD, spell.Cooldown) 
			or 0)
end

local function delayFlash(spell, delay, minDelay, rotation)
	if minDelay > 0 or delay + (spell.WhiteFlashOffset or 0) > 0 then
--c.Debug("delayFlash", s.SpellName(spell.ID), delay, minDelay, "green")
		s.Flash(spell.FlashID or spell.ID, "green", s.FlashSizePercent() / 2)
	else
--c.Debug("delayFlash", s.SpellName(spell.ID), delay, minDelay, "white")
		s.Flash(
			spell.FlashID or spell.ID, 
			getFlashColor(spell, rotation), 
			spell.FlashSize)
	end
end

function c.DelayPriorityFlash(...)
	local minDelay = 0
	local nextDelay = 9999
	local nextSpell
	local nextSpellName
	local nextSpellMinDelay
	local rotation = c.GetCurrentRotation()
	local continuers = { }
	local continuerMinDelays = { }
	local pusherMins = { }
	local pusherGoals = { }
	for i = 1, select("#", ...) do
		if nextDelay > minDelay then
			local name = select(i, ...)
			local spell = c.GetSpell(name)
			local delay, modDelay = getDelay(spell)
--c.Debug("DelayPriorityFlash", name, delay, modDelay)
			if delay then
				if spell.IsMinDelayDefinition then
					if modDelay then
						pusherMins[spell] = delay - modDelay
						pusherGoals[spell] = delay
					else
						minDelay = math.max(minDelay, delay)
					end
				else
					delay = math.max(delay, minDelay)
					for k, pusherMin in pairs(pusherMins) do
						if delay > pusherMin then
							delay = math.max(delay, pusherGoals[k])
						end
					end
					if delay < nextDelay 
						and (not modDelay or delay <= modDelay) then
						
--c.Debug("DelayPriorityFlash", "  ^ use it", delay)
						if spell.Continue then
							continuers[spell] = delay
							continuerMinDelays[spell] = minDelay
						else
							nextDelay = delay
							nextSpell = spell
							nextSpellName = name
							nextSpellMinDelay = minDelay
						end
					end
				end
			end
		end
	end
	for spell, delay in pairs(continuers) do
		if delay <= nextDelay then
			delayFlash(spell, delay, continuerMinDelays[spell], rotation)
		end
	end
	if nextSpell then
		delayFlash(nextSpell, nextDelay, nextSpellMinDelay, rotation)
		
		if rotation.ExtraDebugInfo then
			c.Debug("Flash", 
				rotation.ExtraDebugInfo(), nextSpellName, nextDelay)
		else
			c.Debug("Flash", nextSpellName, nextDelay)
		end
	end
	return nextSpellName
end

function c.FlashAll(...)
	local flashed = false
	for i = 1, select("#", ...) do
		if flashSingle(c.GetSpell(select(i, ...))) then
			flashed = true
		end
	end
	return flashed
end

function c.GetGroupMembers()
	local last = 0
	local max = math.max(1, GetNumGroupMembers())
	local type
	if IsInRaid() then
		type = "raid"
	else
		type = "party"
	end
	return function()
		last = last + 1
		if last < max then
			return type .. last
		elseif last == max and type ~= "raid" then
			return "player"
		end
	end
end

function c.GetHastedTime(unhastedTime)
	return unhastedTime / (1 + UnitSpellHaste("player") / 100)
end

local itemRanges = {
	[32321] = 10, -- Sparrowhawk Net
	[46722] = 15, -- Grol'dom Net
	[10645] = 20, -- Gnomish Death Ray
	[24268] = 25, -- Netherweave Net
	[835] = 30, -- Large Rope Net
	[41509] = 35, -- Frostweave Net
	[28767] = 40, -- The Decapitator
	[32698] = 45, -- Wrangling Rope
--	[35278] = 80, -- Reinforced Net
--	[89163] = ?, -- Requisitioned Firework Launcher
}

-- pre-fetch whatever wow needs to cache for the items
for id, _ in pairs(itemRanges) do
	IsItemInRange(id)
end

function c.DistanceAtTheLeast()
	local target = s.UnitSelection()
	if not s.Enemy(target) then
		return 0
	end
	
	local max = 0
	for itemId, range in pairs(itemRanges) do
		if range > max and IsItemInRange(itemId, target) == 0 then
			max = range
		end
	end
	return max
end

function c.DistanceAtTheMost()
	local min = 1000
	local target = s.UnitSelection()
	for itemId, range in pairs(itemRanges) do
		if range < min and IsItemInRange(itemId, target) == 1 then
			min = range
		end
	end
	return min
end

function c.IdMatches(id, ...)
	for i = 1, select('#', ...) do
		if id == c.GetID(select(i, ...)) then
			return true
		end
	end
	return false
end

function c.IsMissingTotem(slot)
	return c.GetTotemDuration(slot) == 0
end

function c.GetTotemDuration(slot)
	local _, name, startTime, duration, _ = GetTotemInfo(slot)
	return math.max(0, startTime + duration - GetTime() - c.GetBusyTime()),
		name
end

function c.GetHealth(unit)
	unit = s.UnitSelection(unit)
	return math.min(
		UnitHealthMax(unit), 
		UnitHealth(unit) + (UnitGetIncomingHeals(unit) or 0))
end

function c.GetHealthPercent(unit)
	unit = s.UnitSelection(unit)
	local max = UnitHealthMax(unit)
	if max == 0 then -- happens when unit is dead (at least sometimes)
		return 0
	else
		return 100 * c.GetHealth(unit) / max
	end
end

function c.MakeMini(spell, condition)
	if condition ~= false then
		spell.FlashSize = s.FlashSizePercent() / 2
	else
		spell.FlashSize = nil
	end
end

function c.MakeOptional(spell, condition)
	if condition ~= false then
		spell.FlashColor = "yellow"
		spell.Continue = true
	else
		spell.FlashColor = nil
		spell.Continue = nil
	end
end

function c.MakePredictor(spell, condition, normalColor)
	c.MakeMini(spell, condition)
	if condition ~= false then
		spell.FlashColor = "green"
	else
		spell.FlashColor = normalColor
	end
end

function c.HasSpell(name)
	return s.HasSpell(c.GetID(name))
end
