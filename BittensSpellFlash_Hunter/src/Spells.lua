local addonName, a = ...
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local GetPowerRegen = GetPowerRegen
local GetTime = GetTime
local IsMounted = IsMounted
local UnitExists = UnitExists
local UnitGroupRolesAssigned = UnitGroupRolesAssigned
local UnitInParty = UnitInParty
local UnitInRaid = UnitInRaid
local UnitIsDead = UnitIsDead
local UnitIsUnit = UnitIsUnit
local floor = math.floor

c.AssociateTravelTimes(
   .5,
   "Explosive Shot",
   "Black Arrow",
   "Cobra Shot",
   "Arcane Shot",
   "Kill Shot",
   "Steady Shot",
   "Chimaera Shot",
   "Aimed Shot",
   "Tranquilizing Shot",
   "Multi-Shot")

local function sufficientResources(z)
   return c.GetCost(z.ID) <= a.Focus
end

local function modSpell(spell)
   spell.EvenIfNotUsable = true
   spell.NoPowerCheck = true
   spell.CheckLast = sufficientResources
end

local function addSpell(name, tag, attributes)
   modSpell(c.AddSpell(name, tag, attributes))
end

local function addOptionalSpell(name, tag, attributes)
   modSpell(c.AddOptionalSpell(name, tag, attributes))
end

local function avoidCapping(spell, padding)
   local castTime = c.GetCastTime(spell)
   local added = a.FocusAdded(spell, c.GetBusyTime() + castTime)
   local regen = castTime * a.Regen
   return (a.EmptyFocus - added - regen) >= padding
end

------------------------------------------------------------------------ Common
c.AddOptionalSpell("Call Pet", nil, {
   ID = "Call Pet 1",
   FlashID = {
      "Call Pet",
      "Call Pet 1",
      "Call Pet 2",
      "Call Pet 3",
      "Call Pet 4",
      "Call Pet 5",
   },
   CheckFirst = function()
      return not UnitExists("pet")
   end
})

c.AddOptionalSpell("Revive Pet", nil, {
   CheckFirst = function()
      return UnitIsDead("pet")
   end
})

c.AddOptionalSpell("Dismiss Pet", nil, {
   CheckFirst = function()
      return UnitExists("pet")
   end
})

c.AddOptionalSpell("Exhilaration", nil, {
   NoGCD = true,
   NoRangeCheck = true,
   CheckFirst = function(z)
      local forMe = c.GetHealthPercent("player") < 70
      local forPet = c.GetHealthPercent("pet") < 25
      c.MakeMini(z, not (forMe and forPet))
      if forPet then
         z.FlashColor = "red"
      else
         z.FlashColor = "yellow"
      end
      return forMe or forPet
   end,
})

addOptionalSpell("A Murder of Crows", nil, {
   MyDebuff = "A Murder of Crows",
})

addOptionalSpell("Powershot", nil, {
   Cooldown = 45,
   CechkFirst = function(z)
      c.MakeOptional(z, s.Moving("player"))
      return s.EmptyFocus > a.Regen * c.GetCastTime("Powershot")
   end,
})

addOptionalSpell("Powershot", "for AoE", {
   Cooldown = 45,
   CechkFirst = function(z)
      c.MakeOptional(z, s.Moving("player"))
      return c.EstimatedHarmTargets > 1
         and s.EmptyFocus > a.Regen * c.GetCastTime("Powershot")
   end,
})

addOptionalSpell("Barrage", nil, {
   Cooldown = 30,
})

addOptionalSpell("Barrage", "for BM", {
   Cooldown = 30,
   CheckFirst = function()
      local frenzy = s.BuffStack(c.GetID("Frenzy"), "pet")
      local ff = c.HasBuff("Focus Fire")

      -- if we are not under focus fire, delay if we are at four stacks so
      -- that we can combine the two and improve barrage a bit.
      return ff or frenzy < 4
   end,
})

addOptionalSpell("Barrage", "for AoE", {
   Cooldown = 30,
   CheckFirst = function()
      return c.EstimatedHarmTargets > 1
   end,
})

c.RegisterForFullChannels("Barrage", 3)

c.AddOptionalSpell("Dire Beast", nil, {
   CheckFirst = function()
      return a.EmptyFocus > a.Regen
   end
})

c.AddSpell("Arcane Shot", "under Thrill of the Hunt", {
   CheckFirst = function()
      local stacks = c.GetBuffStack("Thrill of the Hunt")
      if c.IsCasting("Arcane Shot") or c.IsCasting("Multi-Shot") then
         stacks = stacks - 1
      end
      return stacks > 0 and a.Focus > 35
   end
})

c.AddSpell("Arcane Shot", "under Bestial Wrath", {
   CheckFirst = function()
      return c.HasBuff("Bestial Wrath")
   end
})

c.AddOptionalSpell("Rapid Fire", nil, {
   CheckFirst = function()
      return not s.Buff(c.BLOODLUST_BUFFS, "player")
         and not c.HasBuff("Rapid Fire")
   end,
})

c.AddOptionalSpell("Stampede", nil, {
   FlashSize = s.FlashSizePercent() / 2,
   CheckFirst = function()
      return c.HasBuff("Rapid Fire") or c.HasBuff(c.BLOODLUST_BUFFS)
   end,
})

c.AddSpell("Cobra Shot", nil, {
   CheckFirst = function()
      -- focusing shot replaces cobra shot
      return avoidCapping("Cobra Shot", 0) and not c.HasTalent("Focusing Shot")
   end
})

c.AddSpell("Focusing Shot", nil, {
   CheckFirst = function()
      local castTime = c.GetCastTime("Focusing Shot")
      -- we are out of other things, allow some overcap.
      return (a.EmptyFocus - 50 - (castTime * a.Regen)) >= -10
   end
})

c.AddSpell("Cobra Shot", "for Steady Focus", {
   CheckFirst = function()
      return c.HasTalent("Steady Focus")
         and a.startedSteadyFocus
         and avoidCapping("Cobra Shot", 0)
         and not c.HasTalent("Focusing Shot")
      -- @todo danielp 2014-11-29: no padding here, which might be
      -- a mistake.  consider if we end up focus capping regularly here.
   end
})

c.AddSpell("Steady Shot", "for Leveling", {
   CheckFirst = function()
      -- encourage people to swap Cobra Shot onto their bars as soon as they
      -- get the spell
      return not c.HasSpell("Cobra Shot")
   end,
})

addSpell("Glaive Toss", nil, {
   Cooldown = 15,
})

addSpell("Glaive Toss", "for AoE", {
   Cooldown = 15,
   CheckFirst = function()
      return c.EstimatedHarmTargets > 2
   end
})

c.AddOptionalSpell("Bullheaded", nil, {
   Type = "pet",
   CheckFirst = function()
      return c.IsTanking("pet")
   end,
})

c.AddOptionalSpell("Growl", nil, {
   Type = "pet",
   FlashColor = "red",
   CheckFirst = function(z)
      local primaryTarget = s.GetPrimaryThreatTarget()
      return primaryTarget
         and (UnitIsUnit(primaryTarget, "player")
            or UnitInRaid(primaryTarget)
            or UnitInParty(primaryTarget))
         and UnitGroupRolesAssigned(primaryTarget) ~= "TANK"
   end,
})

c.AddOptionalSpell("Heart of the Phoenix", nil, {
   Type = "pet",
   NoRangeCheck = true,
   Override = function()
      return UnitIsDead("pet")
         and c.GetCooldown("Heart of the Phoenix", true) == 0
   end,
})

c.AddOptionalSpell("Last Stand", nil, {
   FlashColor = "red",
   CheckFirst = function()
      return c.GetHealthPercent("pet") < 25
   end,
})

c.AddOptionalSpell("Mend Pet", nil, {
   Buff = "Mend Pet",
   BuffUnit = "pet",
   EarlyRefresh = 2,
   CheckFirst = function()
      return c.GetHealthPercent("pet") < 80
   end,
})

c.AddOptionalSpell("Mend Pet", "at 50", {
   Buff = "Mend Pet",
   BuffUnit = "pet",
   EarlyRefresh = 2,
   CheckFirst = function()
      return c.GetHealthPercent("pet") < 50
   end,
})

c.AddDispel("Tranquilizing Shot", nil, "")

c.AddInterrupt("Counter Shot", nil, {
   NoGCD = true,
})

c.AddSpell("Kill Shot", nil, {
   Cooldown = 10,
   -- This is required because IsUsableSpell is buggy in 6.0.3;
   -- see http://us.battle.net/wow/en/forum/topic/15700039856#1
   -- also http://us.battle.net/wow/en/forum/topic/15699089759#1
   EvenIfNotUsable = true,
   CheckFirst = function()
      local execute = c.HasSpell("Enhanced Kill Shot") and 35 or 20

      -- nasty work-around for the second bug in KS cooldown
      if a.ForceKillShotCooldown > GetTime() then
         return false
      end

      -- avoidCapping("Kill Shot", -10)
      -- c.GetCooldown("Kill Shot", false, 10) <= c.GetBusyTime()
      return c.GetHealthPercent("target") <= execute
   end,
})

----------------------------------------------------------------- Beast Mastery
c.AddOptionalSpell("Focus Fire", nil, {
   CheckFirst = function()
      local wrath = c.GetBuffDuration("Bestial Wrath")
      return s.BuffStack(c.GetID("Frenzy"), "pet") >= 5
         and not c.HasBuff("Focus Fire")
         and (wrath <= 0 or wrath >= 3)
   end
})

addSpell("Kill Command", nil, {
   Cooldown = 6,
   CheckFirst = function()
      return c.EstimatedHarmTargets < 8
   end
})

addSpell("Multi-Shot", nil, {
   CheckFirst = function()
      -- five targets, or if beast cleave is down
      local cleave = s.Buff(c.GetID("Beast Cleave"), "pet")
      return c.EstimatedHarmTargets >= (cleave and 5 or 2)
   end
})

addSpell("Arcane Shot", "for BM", {
   CheckFirst = function()
      return a.Focus >= 64
   end
})

c.AddOptionalSpell("Bestial Wrath", nil, {
   CheckFirst = function()
      -- delay, if necessary, to ensure we fit two Kill Commands in the window
      -- of this buff.
      return a.Focus > 60
         and not c.HasBuff("Bestial Wrath")
         and c.GetCooldown("Kill Command", nil, 6) <= 2
   end
})

c.AddOptionalSpell("Rapid Fire", "for BM", {
   CheckFirst = function()
      return not c.HasBuff("Rapid Fire")
   end
})

c.AddOptionalSpell("Explosive Trap", nil, {
--   FlashSize = s.FlashSizePercent() / 2,  @todo danielp 2014-11-29: yes/no?
   FlashID = { "Explosive Trap", "Explosive Trap Launched" },
   NoRangeCheck = true,
   CheckFirst = function()
      return c.EstimatedHarmTargets > 1
   end,
})

------------------------------------------------------------------ Marksmanship
addSpell("Chimaera Shot", nil, {
   Cooldown = 9,
})

addOptionalSpell("Stampede", "for Marksmanship", {
   FlashSize = s.FlashSizePercent() / 2,
   CheckFirst = function()
      return (c.HasBuff("Rapid Fire") or c.HasBuff(c.BLOODLUST_BUFFS))
         and c.HasBuff("Steady Focus")
   end,
})

addSpell("Aimed Shot", nil, {
   CheckFirst = function(z)
      return a.Focus >= 50
   end,
})

addSpell("Aimed Shot", "under Thrill of the Hunt", {
   CheckFirst = function(z)
      return a.Focus >= 50 and c.HasBuff("Thrill of the Hunt")
   end,
})

addSpell("Steady Shot")

addSpell("Steady Shot", "for Steady Focus", {
   CheckFirst = function()
      return c.HasTalent("Steady Focus")
         and a.startedSteadyFocus
         and avoidCapping("Steady Shot", 0)
         and not c.HasTalent("Focusing Shot")
   end
})

local function shouldCastToPool(spell)
   local rf = c.GetCooldown("Rapid Fire")
   local ct = c.GetCastTime(spell)
   local focus_per_cast = a.FocusAdded(spell, c.GetBusyTime() + ct)
   -- roughly rounded to reduce over-capping.
   local casts_needed = floor((a.EmptyFocus / focus_per_cast) + 0.25)

   -- if we are at or below the point we need to spam this to cap before we
   -- use our cooldown, then trigger.
   return rf <= (casts_needed * ct)
end

addSpell("Steady Shot", "to pool", {
   CheckFirst = function()
      return shouldCastToPool("Steady Shot")
         and not c.HasTalent("Focusing Shot")
         and avoidCapping("Steady Shot", -10)
   end
})

c.AddSpell("Focusing Shot", "to pool", {
   CheckFirst = function()
      return shouldCastToPool("Focusing Shot")
         and c.HasTalent("Focusing Shot")
         and avoidCapping("Focusing Shot", -20)
   end
})

addSpell("Multi-Shot", "for MM", {
   EarlyRefresh = 1,
   CheckFirst = function(z)
      return c.EstimatedHarmTargets >= 7
         and s.HealthPercent("target") < 80
         and not c.HasBuff("Rapid Fire")
   end
})

---------------------------------------------------------------------- Survival
addSpell("Explosive Shot", nil, {
   CheckFirst = function()
      return not c.IsCasting("Explosive Shot") and
         (c.EstimatedHarmTargets < 7 or c.HasBuff("Lock and Load"))
   end,
})

addSpell("Black Arrow", nil, {
   EarlyRefresh = 1,
   CheckFirst = function(z)
      return c.ShouldCastToRefresh(
         "Black Arrow", "Black Arrow", z.EarlyRefresh, true)
   end
})
c.ManageDotRefresh("Black Arrow", 2)

addSpell("Arcane Shot", "for Survival", {
   EarlyRefresh = 1,
   CheckFirst = function(z)
      return avoidCapping("Arcane Shot", a.Regen * 2)
         or c.ShouldCastToRefresh(
            "Arcane Shot", "Serpent Sting", z.EarlyRefresh, true)
   end
})

addSpell("Multi-Shot", "for SV", {
   EarlyRefresh = 1,
   CheckFirst = function(z)
      if c.EstimatedHarmTargets <= 1 then
         return false
      end

      if c.EstimatedHarmTargets <= 4 then
         return c.ShouldCastToRefresh(
            "Multi-Shot", "Serpent Sting", z.EarlyRefresh, true)
      else
         return true
      end
   end
})

