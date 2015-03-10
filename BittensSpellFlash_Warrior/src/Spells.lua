local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local x = s.UpdatedVariables
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local min = math.min
local max = math.max

------------------------------------------------------------------------ Common
c.AddSpell("Defensive Stance", nil, {
   Type = "form"
})

c.AddSpell("Battle Stance", nil, {
   Type = "form"
})

c.AddSpell("Battle Shout", nil, {
   NoRangeCheck = true,
   CheckFirst = function(z)
      if s.InRaidOrParty() then
         c.MakeOptional(z, false)
         return c.RaidBuffNeeded(c.ATTACK_POWER_BUFFS)
      else
         c.MakeOptional(z, c.HasMyBuff("Commanding Shout"))
         return c.SelfBuffNeeded(c.ATTACK_POWER_BUFFS)
      end
   end
})

c.AddSpell("Commanding Shout", nil, {
   NoRangeCheck = true,
   CheckFirst = function(z)
      if s.InRaidOrParty() then
         if s.Buff(c.ATTACK_POWER_BUFFS, "raid|all|range|player") then
            return false -- my own ap buff on all
         else
            c.MakeOptional(z, not c.RaidBuffNeeded(c.ATTACK_POWER_BUFFS))
            return c.RaidBuffNeeded(c.STAMINA_BUFFS)
         end
      else
         return false
      end
   end
})

c.AddOptionalSpell("Charge")

c.AddSpell("Bladestorm", nil, {
   Melee = true,
   Cooldown = 60,
})

c.AddSpell("Bladestorm", "if Enraged", {
   Melee = true,
   Cooldown = 60,
   CheckFirst = function()
      return a.Enraged
   end
})

c.AddSpell("Bladestorm", "if Enraged for duration", {
   Melee = true,
   Cooldown = 60,
   CheckFirst = function()
      return a.Enraged and c.GetBuffDuration("Enrage") >= 6
   end
})

c.AddSpell("Bladestorm", "with Colossus Smash", {
   Melee = true,
   Cooldown = 60,
   CheckFirst = function()
      return a.Colossus
         and a.Rage < 70
   end
})

c.AddSpell("Shockwave", nil, {
   CheckFirst = function()
       return not c.HasTalent("Unquenchable Thirst")
   end
})

-- c.MakeMini(c.AddOptionalSpell("Heroic Leap", nil, {
--    NoGCD = true,
-- --   CheckFirst = function()
-- --      return a.Smash > 0 and not c.IsSolo()
-- --   end
-- }))

local function victoryHealable()
   local heal = 15
   if a.VictoriousDuration > 4 then
      if c.HasGlyph("Victory Rush") and not c.HasTalent("Impending Victory") then
         heal = heal * 1.5
      end
   end

   return c.GetHealthPercent("player") + heal < (c.IsSolo() and 102 or 70)
end

c.AddSpell("Impending Victory", nil, {
   Rage = 10,
   Cooldown = 30,
   CheckFirst = function()
      return c.GetHealthPercent("target") > 20
         and not c.HasTalent("Unquenchable Thirst")
   end
})

c.AddSpell("Impending Victory", "for Heals", {
   Rage = 10,
   Cooldown = 30,
   CheckFirst = victoryHealable,
})

c.AddSpell("Victory Rush", "for Heals", {
   Melee = true,
   CheckFirst = function()
      return a.VictoriousDuration > 0 and victoryHealable()
   end,
})

c.AddOptionalSpell("Avatar", nil, {
   NoGCD = true,
   Cooldown = 3 * 60,
   CheckFirst = function()
      return c.HasBuff("Recklessness")
         or c.GetHealthPercent("target") < 5
   end
})

c.AddOptionalSpell("Siegebreaker", nil, {
   Cooldown = 45
})

c.AddOptionalSpell("Storm Bolt", nil, {
   Cooldown = 30,
})

c.AddOptionalSpell("Dragon Roar", nil, {
   Melee = true,
   Cooldown = 60,
   CheckFirst = function()
      return a.Bloodbath or not c.HasTalent("Bloodbath")
   end
})

c.AddSpell("Execute", nil, {
   Rage = function()
      return s.Spec(1) and 10 or 30
   end,
   CheckFirst = function()
      return a.InExecute
   end
})

c.AddSpell("Execute", "with Sudden Death", {
   CheckFirst = function()
      return a.SuddenDeath
   end
})

c.AddSpell("Whirlwind", nil, {
   Melee = true,
   Rage = 30,
})

c.AddSpell("Whirlwind", "near cap", {
   Melee = true,
   Rage = 30,
   CheckFirst = function()
      return a.EmptyRage <= 30
   end
})


c.AddInterrupt("Pummel")
c.AddInterrupt("Disrupting Shout")

-------------------------------------------------------------------------- Arms
c.AddSpell("Execute", "with Colossus Smash", {
   Rage = 10,
   CheckFirst = function()
      if not a.InExecute then
         return false
      end

      if a.Colossus then
         return true
      end

      if c.GetHealthPercent("target") < (s.Boss() and 2 or 20) then
         return true
      end

      return (a.Rage > 60 or c.EstimatedHarmTargets == 2)
         and c.GetCooldown("Colossus Smash") >= c.LastGCD
   end
})

c.AddSpell("Mortal Strike", nil, {
   Rage = 20,
   Cooldown = 6,
   CheckFirst = function()
      return c.GetCooldown("Colossus Smash") > 1
         and not a.InExecute
   end
})

c.AddSpell("Mortal Strike", "with two targets", {
   Rage = 20,
   Cooldown = 6,
   CheckFirst = function()
      return c.GetCooldown("Colossus Smash") > 1.5
         and not a.InExecute
         and c.EstimatedHarmTargets == 2
   end
})

c.AddSpell("Rend", nil, {
   Rage = 5,
   MyDebuff = "Rend",
   CheckFirst = function()
      return not c.HasMyDebuff("Rend")
   end
})

c.AssociateTravelTimes(0, "Rend")
c.AddSpell("Rend", "early", {
   Rage = 5,
   MyDebuff = "Rend",
   CheckFirst = function()
      return c.ShouldCastToRefresh("Rend", "Rend", 6, true)
   end
})

c.AddSpell("Rend", "early without Colossus Smash", {
   Rage = 5,
   MyDebuff = "Rend",
   CheckFirst = function()
      return c.ShouldCastToRefresh("Rend", "Rend", 5.4, true)
         and not a.Colossus
   end
})

c.AddOptionalSpell("Recklessness", "for Arms", {
   Cooldown = 3 * 60,
   CheckFirst = function()
      local hp = c.GetHealthPercent("target")
      local boss = s.Boss("target")

      -- if target.time_to_die<10 then return true

      if not c.HasMyDebuff("Rend") then
         return false
      end

      if hp > 20 and not boss then
         return false
      end

      if c.HasTalent("Bloodbath") then
         return a.Bloodbath
      elseif c.GetMyDebuffDuration("Colossus Smash") >= 5 then
         return 0
      else
         return c.GetCooldown("Colossus Smash") - 2, 0.35
      end
   end
})

c.AddOptionalSpell("Bloodbath", "for Arms", {
   NoGCD = true,
   Cooldown = 60,
   CheckFirst = function()
      return c.HasMyDebuff("Rend")
         and c.GetCooldown("Colossus Smash") < 5
   end
})

c.AddOptionalSpell("Sweeping Strikes", nil, {
   NoGCD = true,
   Rage = 10,
})

c.AddSpell("Dragon Roar", "for Arms", {
   Melee = true,
   Cooldown = 60,
   CheckFirst = function()
      return c.GetCooldown("Colossus Smash") > c.LastGCD
         and not a.Colossus
   end
})

-- @todo danielp 2015-01-22: not sure this actually makes sense, but there was
-- definitely existing code tracking it, so maybe we should assume it sticks?
--
-- should test, once >= 81, if this is a buff, debuff, and on what, and if
-- there is a travel time delay between the cast and the buff.
c.AssociateTravelTimes(0, "Colossus Smash")
c.AddSpell("Colossus Smash", nil, {
   Cooldown = 20,
   CheckFirst = function()
      return not c.IsCastingOrInAir("Colossus Smash")
         and not a.Colossus
   end
})

c.AddSpell("Colossus Smash", "with Rend", {
   Cooldown = 20,
   CheckFirst = function()
      return not c.IsCastingOrInAir("Colossus Smash")
         and c.HasMyDebuff("Rend")
         and not a.Colossus
   end
})

c.AddSpell("Slam", nil, {
   Rage = function()
      return 10 + (c.GetBuffStack("Slam") * 10)
   end,
   CheckFirst = function()
      return (a.Rage > 20 or c.GetCooldown("Colossus Smash") > c.LastGCD)
         and not a.InExecute
         and c.GetCooldown("Colossus Smash") > 1
         and c.GetCooldown("Mortal Strike") > 1
   end
})

c.AddSpell("Whirlwind", "for Arms ST", {
   Melee = true,
   Rage = 20,
   CheckFirst = function()
      return not c.HasTalent("Slam")
         and not a.InExecute
         and (a.Rage >= 40 or c.WearingSet(4, "T17") or a.Colossus)
         and c.GetCooldown("Colossus Smash") > 1
         and c.GetCooldown("Mortal Strike") > 1
   end,
})

c.AddSpell("Whirlwind", "for Arms AoE", {
   Melee = true,
   Rage = 20,
   CheckFirst = function()
      return c.GetCooldown("Colossus Smash") > 1.5
         and (a.InExecute or c.EstimatedHarmTargets > 3)
   end,
})

c.AddOptionalSpell("Ravager", "with Colossus Smash", {
   Cooldown = 60,
   GetDelay = function()
      -- sync with colossus smash
      return max(c.GetCooldown("Colossus Smash") - 4,
                 c.GetCooldown("Ravager"))
   end
})

c.AddOptionalSpell("Ravager", "sync with Bloodbath", {
   Cooldown = 60,
   GetDelay = function()
      if c.HasTalent("Bloodbath") then
         return max(c.GetCooldown("Bloodbath"), c.GetCooldown("Ravager"))
      else
         return c.GetCooldown("Ravager")
      end
   end
})

c.AddOptionalSpell("Storm Bolt", "with Colossus Smash", {
   Cooldown = 30,
   CheckFirst = function()
      if a.Rage >= 90 then
         return false
      end

      return a.Colossus
         or c.GetCooldown("Colossus Smash") > 4
   end
})

c.AddSpell("Impending Victory", "for Arms", {
   Rage = 10,
   Cooldown = 30,
   CheckFirst = function()
      return a.Rage < 40
         and not a.InExecute
         and c.GetCooldown("Colossus Smash") > 1
         and c.GetCooldown("Mortal Strike") > 1
   end
})

------------------------------------------------------------------------- Fury

local function getRagingBlowStacks(noGCD)
   local stacks = c.GetBuffStack("Raging Blow!", noGCD)
   if c.IsCasting("Enrage") then
      stacks = stacks + 1
   end
   if c.IsCasting("Raging Blow") then
      stacks = stacks - 1
   end
--   local str = tostring(min(max(0, stacks), 2))
   return min(max(0, stacks), 2)
end

c.AddOptionalSpell("Berserker Rage", "for Fury", {
   NoGCD = true,
   Cooldown = 30,
   CheckFirst = function()
      return not a.Enraged
         or (c.HasTalent("Unquenchable Thirst") and getRagingBlowStacks(true) < 0)
   end
})

c.AddOptionalSpell("Bloodbath", nil, {
   NoGCD = true,
   Cooldown = 60
})


c.AddSpell("Bloodthirst", "early", {
   Cooldown = 4.5,
   CheckFirst = function()
      return (a.Rage < 80 and not c.HasTalent("Unquenchable Thirst"))
         or not a.Enraged
   end
})

c.AddSpell("Bloodthirst", nil, {
   Cooldown = 4.5,
})

c.AddSpell("Bloodthirst", "during cleave", {
   Cooldown = 4.5,
   CheckFirst = function()
      return not a.Enraged
         or getRagingBlowStacks() <= 0
         or a.Rage < 50
   end
})

c.AddSpell("Execute", "when Enraged", {
   Rage = 30,
   CheckFirst = function()
      -- @todo danielp 2015-01-18: actually TTD < 12
      return a.InExecute and (a.Enraged or c.GetHealthPercent("target") < 2)
   end
})

-- Throw your weapon at the enemy, causing 50% Physical damage.   Generates high threat.
-- Cast is instant with a 6 sec. cooldown.   Range is 8-30 yards
c.AddOptionalSpell("Heroic Throw", "for Fury", {
--   NoRangeCheck = false,
--   CheckFirst = function()
--      return a.EmptyRage <= 10
--         or (not a.InExecute and a.Rage >= 40 and a.smashPending > 0)
--   end
})

c.AddSpell("Raging Blow", nil, {
   Rage = 10,
   CheckFirst = function()
      -- Blizzard, why couldn't this just be normal spell charges?
      return getRagingBlowStacks() > 0
   end
})

c.AddSpell("Raging Blow", "with Meat Cleaver", {
   Rage = 10,
   CheckFirst = function()
      -- Blizzard, why couldn't this just be normal spell charges?
      return getRagingBlowStacks() > 0
         and c.GetBuffStack("Meat Cleaver") > 0
   end
})

c.AddSpell("Raging Blow", "with 2x Meat Cleaver", {
   Rage = 10,
   CheckFirst = function()
      -- Blizzard, why couldn't this just be normal spell charges?
      return getRagingBlowStacks() > 0
         and c.GetBuffStack("Meat Cleaver") >= 2
   end
})

c.AddSpell("Raging Blow", "with 3x Meat Cleaver", {
   Rage = 10,
   CheckFirst = function()
      -- Blizzard, why couldn't this just be normal spell charges?
      return getRagingBlowStacks() > 0
         and c.GetBuffStack("Meat Cleaver") >= 3
   end
})
c.AddSpell("Raging Blow", "with 3x Meat Cleaver and Enraged", {
   Rage = 10,
   CheckFirst = function()
      -- Blizzard, why couldn't this just be normal spell charges?
      return getRagingBlowStacks() > 0
         and c.GetBuffStack("Meat Cleaver") >= 3
         and a.Enraged
   end
})

c.AddOptionalSpell("Recklessness", "for Fury", {
   NoGCD = true,
   Cooldown = 3 * 60,
   CheckFirst = function()
      local hp = c.GetHealthPercent("target")

      -- @todo danielp 2015-01-18: should be "or TTD <= 12"
      if c.HasTalent("Anger Management") or hp <= 5 then
         return true
      end

      -- @todo danielp 2015-01-18: should be "TTD >= 190 or hp <= 20" here.
      return (s.Boss("target") or hp <= 20)
         and (a.Bloodbath or not c.HasTalent("Bloodbath"))
   end
})

c.AddSpell("Shockwave", "for Fury", {
   CheckFirst = function()
       return not c.HasTalent("Unquenchable Thirst")
   end
})

c.AddSpell("Whirlwind", "for Meat Cleaver", {
   Melee = true,
   Rage = 20,
   CheckFirst = function()
      return not c.HasBuff("Meat Cleaver")
   end
})

local function wildStrikeCost()
   if c.HasBuff("Bloodsurge") then
      return 0
   elseif c.HasTalent("Furious Strikes") then
      return 20
   else
      return 45
   end
end

c.AddSpell("Wild Strike", "at Cap", {
   Rage = wildStrikeCost,
   SpecialGCD = 1,
   CheckFirst = function()
      return a.EmptyRage <= 10 and s.HealthPercent() > 20
   end
})

-- Bloodsurge is up so cost is zero, fire away ...
c.AddSpell("Wild Strike", "with Bloodsurge", {
   Rage = wildStrikeCost,
   SpecialGCD = 1,
   CheckFirst = function()
      return c.HasBuff("Bloodsurge")
   end
})

c.AddSpell("Wild Strike", "if Enraged", {
   Rage = wildStrikeCost,
   SpecialGCD = 1,
   CheckFirst = function()
      return a.Enraged
   end
})

c.AddSpell("Wild Strike", "with Bloodsurge to avoid cap", {
   Rage = wildStrikeCost,
   SpecialGCD = 1,
   CheckFirst = function()
      return c.HasBuff("Bloodsurge")
         and a.Rage > 75
   end
})

c.AddOptionalSpell("Ravager", "for Fury", {
   Cooldown = 60,
   GetDelay = function()
      -- delay until BB comes off cooldown, to sync them, unless that is more
      -- than ten seconds wait.  given they are both on a one minute CD, most
      -- people will likely macro the two and all, so we def. want this to
      -- flash as soon as it is usable, since they may not even have BB on
      -- their bars to flash at them, just macro'ed into this.
      local cd = c.GetCooldown("Bloodbath")
      if a.Bloodbath or cd > 10 or c.GetHealthPercent("target") < 5 then
         return 0
      else
         return cd
      end
   end
})

-------------------------------------------------------------------- Protection
c.AddSpell("Shield Block", nil, {
   Rage = 60,
})

c.AddSpell("Shield Barrier", nil, {
   Rage = 60,
   ShouldHold = function()
      if a.Rage >= 85 then
         return false
      end

      local charges, tilNext = c.GetChargeInfo("Shield Block")
      if charges == 0 and tilNext > 9 then
         return false
      end

      return true
   end
})

c.AddSpell("Demoralizing Shout", nil, {
   Cooldown = 60,
   ShouldHold = function()
      -- incoming_damage_2500ms>health.max*0.1
      return c.GetHealthPercent("player") > 90
   end
})

c.AddSpell("Enraged Regeneration", nil, {
   Cooldown = 60,
   ShouldHold = function()
      -- incoming_damage_2500ms>health.max*0.1
      return c.GetHealthPercent("player") > 90
   end
})

c.AddSpell("Shield Wall", nil, {
   Cooldown = 3 * 60,
   ShouldHold = function()
      -- incoming_damage_2500ms>health.max*0.1
      return c.GetHealthPercent("player") > 90
   end
})

c.AddSpell("Last Stand", nil, {
   Cooldown = 3 * 60,
   ShouldHold = function()
      -- incoming_damage_2500ms>health.max*0.1
      return c.GetHealthPercent("player") > 90
   end
})



c.AddOptionalSpell("Berserker Rage", "for Prot", {
   NoGCD = true,
   CheckFirst = function()
      return (c.IsTanking() or c.InDamageMode()) and c.GetCooldown("Berserker Rage") == 0
   end,
})

c.AddOptionalSpell("Bloodbath", "for Prot", {
   NoGCD = true,
   Cooldown = 60,
   CheckFirst = function()
      if c.HasTalent("Dragon Roar") then
         return c.GetCooldown("Dragon Roar") <= c.LastGCD
      elseif c.HasTalent("Storm Bolt") then
         return c.GetCooldown("Storm Bolt") <= c.LastGCD
      else -- shockwave
         return true
      end
   end
})

c.AddOptionalSpell("Avatar", "for Prot", {
   NoGCD = true,
   Cooldown = 3 * 60,
   CheckFirst = function()
      if c.HasTalent("Ravager") and c.GetCooldown("Ravager") > c.LastGCD then
         return false
      end

      if c.HasTalent("Dragon Roar") and c.GetCooldown("Dragon Roar") > c.LastGCD then
         return false
      end

      if c.HasTalent("Storm Bolt") and c.GetCooldown("Storm Bolt") > c.LastGCD then
         return false
      end

      return true
   end
})

c.AddOptionalSpell("Ravager", nil, {
   Cooldown = 60,
})

c.AddSpell("Devastate", "for Prot", {
   Melee = true,
   CheckFirst = function()
       return c.GetBuffStack("Unyielding Strikes") <= 5
   end,
})

-- Deals (165% of Attack Power) damage to all enemies within 8 yards and knocking
-- them back and down for 0.5 sec.   Damage ignores all armor and is
-- always a critical strike.
-- Cooldown is 1 min. and is an instant cast, no cost with GCD of 1.5 sec.
c.AddSpell("Dragon Roar", "for Prot", {
   Melee = true,
   CheckFirst = function()
      if c.HasTalent("Bloodbath") then
         return c.HasBuff("Bloodbath") or c.GetCooldown("Bloodbath") > 10
      end

      return true
   end
})

c.AddSpell("Execute", "for Prot", {
   CheckFirst = function()
      return a.InExecute and a.EmptyRage < 30
   end
})

c.AddOptionalSpell("Heroic Strike", nil, {
   NoGCD = true,
   FlashColor = "white",
   Rage = function()
      if c.HasBuff("Ultimatum") then
         return 0
      else
         return max(0, 30 - (5 * c.GetBuffStack("Unyielding Strikes")))
      end
   end,
   CheckFirst = function()
      return c.HasBuff("Ultimatum")
         or (c.HasTalent("Unyielding Strikes") and c.GetBuffStack("Unyielding Strikes") >= 6)
      or a.EmptyRage < 10
   end,
})

-- Throw your weapon at the enemy, causing 50% Physical damage.   Generates high threat.
-- Cast is instant with a 6 sec. cooldown.   Range is 8-30 yards
c.AddOptionalSpell("Heroic Throw", "for Prot", {
   EnemyTargetNeeded = true,
   CheckFirst = function()
      return c.GetCooldown("Heroic Throw") == 0
   end,
})

c.AddSpell("Impending Victory", "for Prot", {
   Rage = 10,
   Cooldown = 30,
   CheckFirst = function()
      -- since we are prot, allow some overheal on this, and don't waste rage
      -- that can be used defensively if we won't benefit significantly from
      -- the healing provided.
      return c.GetCooldown("Shield Slam") <= c.LastGCD
         and c.GetHealthPercent("player") < 90
   end,
})

c.AddSpell("Victory Rush", "for Prot", {
   CheckFirst = function()
      -- since we are prot, allow some overheal on this, and don't waste rage
      -- that can be used defensively if we won't benefit significantly from
      -- the healing provided.
      return c.GetCooldown("Shield Slam") <= c.LastGCD
         and c.GetHealthPercent("player") < (c.HasGlyph("Victory Rush") and 82.5 or 90)
   end,
})

c.AddOptionalSpell("Ravager", "for Prot", {
   Cooldown = 60,
   CheckFirst = function()
      if c.HasTalent("Bloodbath") then
         return c.HasBuff("Bloodbath") or c.GetCooldown("Bloodbath") > 10
      end

      return true
   end,
})

-- Instantly attack an enemy and two additional enemies, dealing (300% of Attack power)
-- damage to the primary target and 50% damage to the secondary targets, and generating 20 Rage.
-- Your successful dodges and parries reset the cooldown on Revenge.
-- Cooldown is 9 sec and GCD = 1.5 sec.
c.AddSpell("Revenge", nil, {
   Cooldown = 9,
})

c.AddSpell("Shield Slam", nil, {
   Cooldown = 6,
})

c.AddSpell("Shield Slam", "with Shield Block", {
   Cooldown = 6,
   CheckFirst = function()
      return c.HasBuff("Shield Block")
   end
})

-- Hurls your weapon at an enemy, causing 60% Physical damage and stunning for 4 sec.
-- Deals quadruple damage to targets permanently immune to stuns.
-- Cast is instant with a 30 sec. cooldown.
c.AddSpell("Storm Bolt", "for Prot", {
   CheckFirst = function()
      return c.HasTalent("Storm Bolt") and c.GetCooldown("Storm Bolt") == 0
   end
})

c.AssociateTravelTimes(0, "Thunder Clap")
c.AddSpell("Thunder Clap", "for Debuff", {
   Rage = 10,
   Cooldown = 6,
   MyDebuff = "Deep Wounds",
   CheckFirst = function()
      return c.ShouldCastToRefresh("Thunder Clap", "Deep Wounds", 15 * .3, true)
   end,
})

c.AddSpell("Thunder Clap", nil, {
   Rage = 10,
   Cooldown = 6,
})

c.AddSpell("Delay for Prot Rage Generator", nil, {
   ID = "Battle Shout",
   IsMinDelayDefinition = true,
   GetDelay = function()
      return min(
            c.GetCooldown("Shield Slam", false, 6),
            c.GetCooldown("Revenge", false, 9),
            c.GetCooldown("Battle Shout", false, 60)),
         c.InDamageMode() and .2 or .5
   end,
})

c.AddTaunt("Heroic Throw", nil, {
   NoGCD = true,
   CheckFirst = function()
      return c.GetCooldown("Heroic Throw") == 0
   end
})

-- Throw down a war banner within 30 yards that forces all enemies
-- within 15 yards of the banner to focus attacks on the Warrior for 6 sec.
-- Lasts 30 sec. with a 3 min. Cooldown
-- You can Intervene to your war banner.
c.AddTaunt("Mocking Banner", nil, {
   NoGCD = true,
   CheckFirst = function()
      return c.GetCooldown("Mocking Banner") == 0
   end
})

c.AddTaunt("Taunt", nil, {
   NoGCD = true,
   CheckFirst = function()
      return (c.HasTalent("Vigilance") and c.HasBuff("Vigilance")) or c.GetCooldown("Taunt") == 0
   end,
})
