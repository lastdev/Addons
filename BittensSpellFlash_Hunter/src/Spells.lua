local _, a = ...
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local GetTime = GetTime
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
   "Multi-Shot"
)

local function avoidCapping(spell, padding)
   local castTime = c.GetCastTime(spell)
   local added = a.FocusAdded(spell, c.GetBusyTime() + castTime)
   local regen = castTime * a.Regen
   return (a.EmptyFocus - added - regen) >= (padding or 0)
end

------------------------------------------------------------------------ Common
c.AddSpell("Focusing Shot", nil, {
   FlashID = { "Focusing Shot", "Cobra Shot", "Steady Shot" },
})

c.AddSpell("Cobra Shot", nil, {
   FlashID = { "Cobra Shot", "Steady Shot" },
   CheckFirst = function()
      -- focusing shot replaces cobra shot
      return not c.HasTalent("Focusing Shot")
   end
})

c.AddSpell("Steady Shot")

c.AddSpell("Cobra Shot", "for Steady Focus", {
   FlashID = { "Cobra Shot", "Steady Shot" },
   CheckFirst = function()
      return c.HasTalent("Steady Focus")
         and a.startedSteadyFocus
         and avoidCapping("Cobra Shot")
         and not c.HasTalent("Focusing Shot")
      -- @todo danielp 2014-11-29: no padding here, which might be
      -- a mistake.  consider if we end up focus capping regularly here.
   end
})

c.AddSpell("Steady Shot", "for Steady Focus", {
   CheckFirst = function()
      return c.HasTalent("Steady Focus")
         and a.startedSteadyFocus
         and avoidCapping("Steady Shot")
         and not c.HasTalent("Focusing Shot")
   end
})


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

c.AddOptionalSpell("A Murder of Crows", nil, {
   MyDebuff = "A Murder of Crows",
   Focus = 30,
})

c.AddOptionalSpell("Powershot", nil, {
   Cooldown = 45,
   Focus = function()
      return a.BestialWrath and 7.5 or 15
   end,
   CheckFirst = function(z)
      c.MakeOptional(z, s.Moving("player"))
      return avoidCapping("Powershot")
   end,
})

c.AddOptionalSpell("Powershot", "for AoE", {
   Cooldown = 45,
   Focus = function()
      return a.BestialWrath and 7.5 or 15
   end,
   CheckFirst = function(z)
      c.MakeOptional(z, s.Moving("player"))
      return c.EstimatedHarmTargets > 1
         and avoidCapping("Powershot")
   end,
})

c.RegisterForFullChannels("Barrage", 3)
c.AddOptionalSpell("Barrage", nil, {
   Cooldown = 30,
   Focus = 60,
})

c.AddOptionalSpell("Dire Beast", nil, {
   CheckFirst = function()
      return a.EmptyFocus > a.Regen
   end
})

c.AddOptionalSpell("Rapid Fire", nil, {
   Cooldown = 120,
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

c.AddSpell("Glaive Toss", nil, {
   Cooldown = 15,
   Focus = function()
      return a.BestialWrath and 7.5 or 15
   end,
})

c.AddSpell("Glaive Toss", "for AoE", {
   Cooldown = 15,
   Focus = function()
      return a.BestialWrath and 7.5 or 15
   end,
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
   CheckFirst = function()
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

c.AddOptionalSpell("Mend Pet", "in combat", {
   Buff = "Mend Pet",
   BuffUnit = "pet",
   EarlyRefresh = 2,
   CheckFirst = function()
      return c.GetHealthPercent("pet") < (c.IsSolo() and 80 or 50)
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

      return c.GetHealthPercent("target") <= execute
         and avoidCapping("Kill Shot")
   end,
})

----------------------------------------------------------------- Beast Mastery
c.AddSpell("Focusing Shot", "for AoE", {
   FlashID = { "Focusing Shot", "Cobra Shot", "Steady Shot" },
   CheckFirst = function()
      return c.EstimatedHarmTargets > 5
   end
})

c.AddSpell("Cobra Shot", "for AoE", {
   FlashID = { "Cobra Shot", "Steady Shot" },
   CheckFirst = function()
      return c.EstimatedHarmTargets > 5
   end
})

c.AddOptionalSpell("Focus Fire", nil, {
   GetDelay = function()
      return c.GetBuffDuration("Focus Fire")
   end,
   CheckFirst = function()
      local stacks = c.GetBuffStack("Frenzy")
      if stacks <= 0 then
         return false
      end

      if c.GetBuffDuration("Frenzy") < 3 * c.LastGCD then
         -- don't waste it, regardless of number of stacks.
         return true
      end

      if c.GetCooldown("Bestial Wrath") < c.LastGCD then
         -- use early if we are about to enter bestial wrath
         return stacks > 0
      end

      -- otherwise wait to cap
      return stacks >= 5
   end
})

c.AddSpell("Kill Command", nil, {
   Cooldown = 6,
   MaxWait = 1,
   Focus = function() return a.BestialWrath and 20 or 40 end,
   RunFirst = function(z)
      c.MakeOptional(z, a.KillCommandFailed)

      if c.GetCooldown("Kill Command", false, 6) < c.GetCooldown("Barrage", false, 20) then
         z.MaxWait = 1
      else
         z.MaxWait = 0
      end
   end,
   CheckFirst = function()
      return c.EstimatedHarmTargets < 8
   end
})

c.AddSpell("Multi-Shot", "for BM", {
   Focus = function()
      if a.BestialWrath then
         return a.TotH > 0 and 10 or 20
      end
      return a.TotH > 0 and 20 or 40
   end,
   CheckFirst = function()
      return c.EstimatedHarmTargets > 1
   end,
   GetDelay = function()
      if c.EstimatedHarmTargets > 5 then
         return 0
      end

      -- hold this until beast cleave drops.
      return s.BuffDuration(c.GetID("Beast Cleave"), "pet") - 0.5, 0.5
   end
})

c.AddOptionalSpell("Barrage", "for AoE", {
   Cooldown = 30,
   Focus = function()
      return a.BestialWrath and 30 or 60
   end,
   CheckFirst = function()
      return c.EstimatedHarmTargets > 1
   end,
})


c.AddSpell("Focusing Shot", "for BM", {
   FlashID = { "Focusing Shot", "Cobra Shot", "Steady Shot" },
   Focus = function() return c.HasBuff("Steady Focus") and -75 or -50 end,
})

c.AddSpell("Cobra Shot", "for BM", {
   FlashID = { "Focusing Shot", "Cobra Shot", "Steady Shot" },
   Focus = function() return c.HasBuff("Steady Focus") and -21 or -14 end,
})


c.AddOptionalSpell("Barrage", "for BM", {
   Cooldown = 30,
   Focus = function()
      return a.BestialWrath and 30 or 60
   end,
   CheckFirst = function()
      local frenzy = c.GetBuffStack("Frenzy")
      local ff = c.HasBuff("Focus Fire")

      -- if we are not under focus fire, delay if we are at four stacks so
      -- that we can combine the two and improve barrage a bit.
      return (ff or frenzy < 4)
   end,
})

c.AddSpell("Arcane Shot", "for BM", {
   Focus = function()
      local cost = (a.TotH > 0 and 10 or 30)
      if a.BestialWrath then
         cost = cost / 2
      end
      return cost
   end,
   CheckFirst = function()
      -- @todo danielp 2015-02-22: this can be more sophisticated, accounting
      -- for the higher priority spenders, in future, but for now...
      return a.Focus >= 120
         - (c.HasTalent("Focusing Shot") and 50 or 14)
         - (c.GetBusyTime() * a.Regen)
   end
})

c.AddSpell("Arcane Shot", "during BW", {
   Focus = function()
      local cost = (a.TotH > 0 and 10 or 30)
      if a.BestialWrath then
         cost = cost / 2
      end
      return cost
   end,
   CheckFirst = function()
      return c.HasBuff("Bestial Wrath")
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

c.AddOptionalSpell("Explosive Trap", nil, {
--   FlashSize = s.FlashSizePercent() / 2,  @todo danielp 2014-11-29: yes/no?
   FlashID = { "Explosive Trap", "Explosive Trap Launched" },
   NoRangeCheck = true,
   CheckFirst = function()
      return c.EstimatedHarmTargets > 1
   end,
})

------------------------------------------------------------------ Marksmanship
c.AddSpell("Chimaera Shot", nil, {
   Cooldown = 9,
   Focus = 35,
})

c.AddOptionalSpell("Stampede", "for MM", {
   FlashSize = s.FlashSizePercent() / 2,
   CheckFirst = function()
      return (c.HasBuff("Rapid Fire") or c.HasBuff(c.BLOODLUST_BUFFS))
   end,
})

c.AddSpell("Aimed Shot", nil, {
   Focus = function()
      return a.TotH > 0 and 25 or 50
   end,
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

c.AddSpell("Steady Shot", "to pool", {
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

c.AddSpell("Multi-Shot", "for MM", {
   Focus = function()
      return a.TotH > 0 and 20 or 40
   end,
   CheckFirst = function()
      return c.EstimatedHarmTargets >= 7
         and s.HealthPercent("target") < 80
         and not c.HasBuff("Rapid Fire")
   end
})

---------------------------------------------------------------------- Survival
c.AddSpell("Explosive Shot", nil, {
   Focus = 15,
   Cooldown = 6,
   CheckFirst = function()
      return c.EstimatedHarmTargets < 7
         or c.HasBuff("Lock and Load")
   end,
})

c.AddSpell("Black Arrow", nil, {
   Focus = 35,
   CheckFirst = function()
      return c.ShouldCastToRefresh("Black Arrow", "Black Arrow", 1, true)
   end
})
c.ManageDotRefresh("Black Arrow", 2)

c.AddSpell("Arcane Shot", "for Survival", {
   Focus = 30,
   CheckFirst = function()
      return avoidCapping("Arcane Shot", a.Regen * 2)
         or c.ShouldCastToRefresh("Arcane Shot", "Serpent Sting", 1, true)
   end
})

c.AddSpell("Arcane Shot", "under Thrill of the Hunt", {
   Focus = 10,
   CheckFirst = function()
      return avoidCapping("Arcane Shot", a.Regen * 2)
         and c.HasBuff("Thrill of the Hunt")
   end,
})

c.AddSpell("Multi-Shot", "for SV", {
   Focus = 40,
   CheckFirst = function()
      if c.EstimatedHarmTargets <= 1 then
         return false
      end

      if c.EstimatedHarmTargets <= 4 then
         return c.ShouldCastToRefresh("Multi-Shot", "Serpent Sting", 1, true)
      else
         return true
      end
   end
})

