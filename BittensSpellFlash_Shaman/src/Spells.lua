local AddonName, a = ...
if a.BuildFail(50000) then return end

local L = a.Localize
local s = SpellFlashAddon
local c = BittensSpellFlashLibrary

local GetTime = GetTime
local GetTotemInfo = GetTotemInfo
local math = math

c.Init(a)

local function shouldFlashShield(name, noncombatTime)
	local duration = c.GetBuffDuration(name)
	local stacks = c.GetBuffStack(name)
	if s.InCombat() then
		return duration == 0
	elseif stacks > 1 then
		return duration < 15
	else
		return duration < noncombatTime
	end
end

local function shouldFlashImbue(buffTooltipName, offhand)
	local min
	if s.InCombat() then
		min = 0
	else
		min = 5 * 60
	end
	if offhand then
		return not s.OffHandItemBuff(L[buffTooltipName], min)
	else
		return not s.MainHandItemBuff(L[buffTooltipName], min)
	end
end

local function getFireTotemDuration()
	local haveTotem, name, startTime, duration, icon = GetTotemInfo(1)
	duration = startTime + duration - GetTime() - c.GetBusyTime()
	return math.max(0, duration), name
end

------------------------------------------------------------------------ Common
c.AddOptionalSpell("Lightning Shield", nil, {
	Override = function()
		return shouldFlashShield("Lightning Shield", 5 * 60)
	end
})

c.AddOptionalSpell("Ancestral Swiftness", nil, {
	CheckFirst = function()
		return not c.HasBuff("Ascendance")
	end
})

c.AddOptionalSpell("Earth Elemental Totem", nil, {
	CheckFirst = function()
		return c.GetCooldown("Fire Elemental Totem") > 60
	end
})

c.AddOptionalSpell("Fire Elemental Totem", nil, {
	CheckFirst = function()
		return getFireTotemDuration() == 0
	end
})

c.AddOptionalSpell("Elemental Mastery")

c.AddSpell("Unleash Elements", nil, {
	NotIfActive = true,
	CheckFirst = function()
		return not c.HasBuff("Ascendance")
	end
})

c.AddSpell("Searing Totem", nil, {
	CheckFirst = function()
		return getFireTotemDuration() == 0
	end
})

c.AddInterrupt("Wind Shear")

--------------------------------------------------------------------- Elemental
c.AddSpell("Flame Shock", nil, {
	MyDebuff = "Flame Shock",
	NotIfActive = true,
})
c.ManageDotRefresh("Flame Shock", 3)

c.AddSpell("Lava Burst", nil, {
	CheckFirst = function()
		return (c.GetMyDebuffDuration("Flame Shock")
					> c.GetCastTime("Lava Burst") + .1
				or c.IsAuraPendingFor("Flame Shock"))
			and (not c.IsCasting("Lava Burst") or c.HasBuff("Ascendance"))
	end
})

c.AddSpell("Earth Shock", "for Fulmination", {
	CheckFirst = function()
        local remaining = c.GetMyDebuffDuration("Flame Shock")
        local stacks = s.BuffStack(c.GetID("Lightning Shield"), "player")
        return remaining > 5 and (stacks > 5 or (remaining < 7 and stacks > 4))
	end
})

c.AddOptionalSpell("Thunderstorm", nil, {
	CheckFirst = function()
		return s.PowerPercent("player") < 85
	end
})

c.AddOptionalSpell("Flametongue Weapon", nil, {
	FlashID = { "Flametongue Weapon", "Weapon Imbues" },
	Override = function()
		return shouldFlashImbue("Flametongue")
	end
})

----------------------------------------------------------------------- Enhance
c.AddOptionalSpell("Windfury Weapon", nil, {
	FlashID = { "Windfury Weapon", "Weapon Imbues" },
	Override = function()
		return shouldFlashImbue("Windfury")
	end
})

c.AddOptionalSpell("Flametongue Weapon", "Offhand", {
	FlashID = { "Flametongue Weapon", "Weapon Imbues" },
	Override = function()
		return shouldFlashImbue("Flametongue", true)
	end
})

c.AddSpell("Lightning Bolt", "at 5", {
	CheckFirst = function()
		return a.Maelstrom == 5
	end
})

c.AddSpell("Lightning Bolt", "at 4", {
	NotWhileMoving = true,
	CheckFirst = function()
		return a.Maelstrom > 3
	end
})

c.AddSpell("Lightning Bolt", "at 2", {
	NotWhileMoving = true,
	CheckFirst = function()
		return a.Maelstrom > 1
	end
})

c.AddSpell("Lightning Bolt", "under Ancestral Swiftness", {
	CheckFirst = function()
		return c.HasBuff("Ancestral Swiftness")
	end
})

-- c.AddSpell("Lava Lash", nil, {
	-- CheckFirst = function()
		-- return c.GetBuffStack("Searing Flame") == 5
	-- end
-- })

c.AddOptionalSpell("Ancestral Swiftness", "under 3", {
	CheckFirst = function()
		return c.GetBuffStack("Maelstrom Weapon") < 3
	end
})

c.AddSpell("Flame Shock", "under Unleash Flame", {
	MyDebuff = "Flame Shock",
	CheckFirst = function()
		return c.HasBuff("Unleash Flame")
	end
})
c.ManageDotRefresh("Flame Shock", 3)

c.AddOptionalSpell("Feral Spirit", nil, {
	NoRangeCheck = true,
})

c.AddSpell("Searing Totem", "Early", {
	CheckFirst = function()
		local duration, name = getFireTotemDuration()
		return duration < 10 and name ~= s.SpellName(c.GetID("Fire Elemental Totem"))
	end
})

------------------------------------------------------------------------- Resto
--c.AddSpell("Earthliving Weapon", nil, {
--	ID = 51730,
--	FlashColor = "yellow",
--	Override = function()
--		return shouldFlashImbue("Earthliving")
--	end
--})
--
--c.AddSpell("Water Shield", nil, {
--	ID = 52127,
--	FlashColor = "yellow",
--	Override = function()
--		return shouldFlashShield(52127, 3, 5 * 60)
--	end
--})
--
--c.AddSpell("Earth Shield", nil, {
--	ID = 974,
--	FlashColor = "yellow",
--	Override = function()
--		if not s.InRaidOrParty() then
--			return false
--		end
--		
--		if not a.EarthShieldTarget then
--			return true
--		end
--		
--		if s.InCombat() then
--			return not s.MyBuff(974, a.EarthShieldTarget)
--		else
--			return s.MyBuffDuration(974, a.EarthShieldTarget) < 2 * 60
--				or s.MyBuffStack(974, a.EarthShieldTarget) < 9
--		end
--	end
--})
