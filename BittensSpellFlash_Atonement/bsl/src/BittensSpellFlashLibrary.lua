local g = BittensGlobalTables
local c = g.GetOrMakeTable("BittensSpellFlashLibrary", 2)
local u = g.GetTable("BittensUtilities")
if u.SkipOrUpgrade(c, "MainFile", 7) then
	return
end

local s = SpellFlashAddon

local GetNumGroupMembers = GetNumGroupMembers
local GetTime = GetTime
local IsInRaid = IsInRaid
local IsItemInRange = IsItemInRange
local IsMounted = IsMounted
local UnitIsDeadOrGhost = UnitIsDeadOrGhost
local UnitGroupRolesAssigned = UnitGroupRolesAssigned
local UnitIsUnit = UnitIsUnit
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

function c.RegisterAddon()
	c.RegisterForEvents()
	c.RegisterOptions()
	
	local a = c.A
	s.RegisterModuleSpamFunction(a.AddonName, function()
		c.Init(a)
		local rotation = c.GetCurrentRotation()
		if rotation == nil then
			c.DisableProcHighlights = false
			return
		end
		c.DisableProcHighlights = true
		
		local inCombat = s.InCombat()
		if (IsMounted() and not inCombat) or UnitIsDeadOrGhost("player") then
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
			end
		else
			if rotation.FlashOutOfCombat then
				rotation:FlashOutOfCombat()
			end
		end
	end)
end

function c.Init(a)
	c.A = a
end

function c.GetCurrentRotation()
	for name, rotation in pairs(c.A.Rotations) do
		local optionName = "Flash" .. name
		if (rotation.CheckFirst == nil or rotation.CheckFirst())
			and rotation.Spec == s.TalentMastery()
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

function c.GetCooldown(name, noGCD)
	local id = c.GetID(name)
	if s.HasSpell(id) then
		return math.max(0, s.SpellCooldown(id) - c.GetBusyTime(noGCD))
	else
		return 9001 -- (more than 9000!)
	end
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

function c.IsTanking()
	local status = UnitThreatSituation("player", "target")
	return status == 2 or status == 3
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
		return s.HasTalent(id)
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
			return math.max(
				gcd,
				math.max(
						info.GCDStart + c.LastGCD, info.CastStart + castTime)
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
	local power = s.Power("player", powerType)
	local max = s.MaxPower("player", powerType)
	local t = GetTime()
	local busy = s.GetCastingOrChanneling(nil, "player")
	
--c.Debug("Lib", power, "--------")
	local info = c.GetCastingInfo()
	if info and not powerType then
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

function c.AddInterrupt(name)
	return c.AddOptionalSpell(name, nil, { Interrupt = true }, "aqua")
end

function c.AddTaunt(name, tag, attributes)
	return c.AddOptionalSpell(name, tag, { CheckFirst = c.CheckFirstForTaunts })
end

function c.CloneSpell(sourceName, tag, attributes)
	local sourceAttributes = c.A.Spells[sourceName]
	if sourceAttributes == nil then
		print("Cannot clone", sourceName, "if it does not exist!")
		return
	end
	
	local spell = c.AddSpell(sourceName, tag, attributes)
	for k, v in pairs(sourceAttributes) do
		if spell[k] == nil then
			spell[k] = v
		end
	end
	return spell
end

local aoeColor = { r = .25, g = .25, b = 1 }
local function flashSingle(spell)
	if (spell.Override and not spell:Override())
		or (spell.CheckFirst and not spell:CheckFirst()) then
		
		return false
	end
	
	local flashableFunc = nil
	local castableFunc
	local flashFunc1
	local flashFunc2 = nil
	if spell.Type == "item" then
		flashableFunc = s.ItemFlashable
		castableFunc = s.CheckIfItemCastable
		flashFunc1 = s.FlashItem
	elseif spell.Type == "pet" then
		castableFunc = s.CheckIfPetSpellCastable
		flashFunc1 = s.Flash
		flashFunc2 = s.FlashPet
	elseif spell.Type == "form" then
		castableFunc = s.CheckIfSpellCastable
		flashFunc1 = s.Flash
		flashFunc2 = s.FlashForm
	else
		flashableFunc = s.Flashable
		castableFunc = s.CheckIfSpellCastable
		flashFunc1 = s.Flash
	end
	local flashID = spell.FlashID or spell.ID
	if (flashableFunc and not flashableFunc(flashID))
		or not castableFunc(spell)
		or (spell.CheckLast and not spell:CheckLast()) then
		
		return false
	end
	
	local color = spell.FlashColor
	if color == nil and c.AoE then
		color = aoeColor
	end
	flashFunc1(flashID, color, spell.FlashSize)
	if flashFunc2 then
		flashFunc2(flashID, color, spell.FlashSize)
	end
	return true
end

function c.PriorityFlash(...)
	local flashed = nil
	local defaultColor
	for i = 1, select("#", ...) do
		local name = select(i, ...)
		local spell = c.GetSpell(name)
		if flashSingle(spell) then
			flashed = name
			if not spell.Continue then
				break
			end
		end
	end
	local rotation = c.GetCurrentRotation()
	if rotation.ExtraDebugInfo then
		c.Debug("Flash", rotation.ExtraDebugInfo(), flashed)
	else
		c.Debug("Flash", flashed)
	end
	return flashed
end

function c.FlashAll(...)
	local flashed = false
	for i = 1, select("#", ...) do
		if s.CheckThenFlash(c.GetSpell(select(i, ...))) then
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