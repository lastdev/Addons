local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local GetTime = GetTime
local UnitPowerMax = UnitPowerMax

local format = string.format
local min = math.min
local select = select
local tostring = tostring
local unpack = unpack

local rotation = {}
local rotationName = '?'

a.Rotations = {}

a.smashPending = 0
a.smashTime = 0

-- local resetDamageOverTime = function()
--    a.InitCombatTime = -1
--    a.InitDamage = -1
-- end

-- local DamageOverTime = function()
--    if a.InitDamage ~= -1 then
--       a.DamageRate = (c.GetTime() - a.InitCombatTime) / (c.GetHealth() - a.InitDamage)
--       a.InitCombatTime = c.GetTime()
--       a.InitDamage = c.GetHealth()
--       c.Debug("Damage: ", a.DamageRate)
--    else
--       a.InitCombatTime = c.GetTime()
--       a.InitDamage = c.GetHealth()
--    end
-- end

local monitorSmashPending = function(info)
   if c.InfoMatches(info, "Colossus Smash") then
      a.smashTime = GetTime()
      a.smashPending = 1
   end
end

-- local monitorSmashApplied = function(spellID)
--    if c.IdMatches(spellID, "Colossus Smash") then
--       a.smashPending = 0
--    end
-- end

function a.PreFlash()
   if a.smashPending > 0 then
      a.smashPending = GetTime() - a.smashTime
      if a.smashPending >= 20 then
         a.smashPending = 0
      end
   end

   a.ExeIsUsable = select(1,s.UsableSpell("Execute"))
   a.Rage = c.GetPower()

   a.InExecute = s.HealthPercent() <= 20
   a.SuddenDeath = c.HasBuff("Sudden Death")
   a.Enraged = c.HasBuff("Enrage")

   if c.IsCasting("Victory Rush", "Impending Victory") then
      a.VictoriousDuration = 0
   else
      a.VictoriousDuration = c.GetBuffDuration("Victorious")
   end

   a.Bloodbath = c.HasBuff("Bloodbath", false, false, true)

   -- adjust rage estimates based on what spells are pending, so we flash the
   -- correct thing subsequently.
   if c.IsQueued("Charge") then
      a.Rage = a.Rage + (c.HasGlyph("Bull Rush") and 35 or 20)
   elseif c.IsQueued("Bloodthirst") then
      a.Rage = a.Rage + 10
   elseif c.IsQueued("Revenge") then
      a.Rage = a.Rage + 20
   elseif c.IsQueued("Berserker Rage") and c.HasSpell("Enrage") then
      a.Rage = a.Rage + 10
   end

   a.maxRage = UnitPowerMax("player")
   a.Rage = min(a.maxRage, a.Rage)
   a.EmptyRage = a.maxRage - a.Rage
end

-------------------------------------------------------------------------- Arms
local tastePending = 0
a.rendAppliedTime = 0
a.TasteStacks = 0
a.Colossus = false

a.Rotations.Arms = {
   Spec = 1,

   UsefulStats = { "Strength", "Crit", "Multistrike", "Mastery", "Versatility", "Haste" },

   PreFlash = function()
      a.TasteStacks = c.GetBuffStack("Taste for Blood")
      if c.IsCasting("Mortal Strike") or GetTime() - tastePending < .8 then
         a.TasteStacks = a.TasteStacks + 2
      end

      a.Colossus = c.HasMyDebuff("Colossus Smash")
   end,

   RotationAoE = {
      "Sweeping Strikes",
      "Rend early",
      "Ravager sync with Bloodbath",
      "Bladestorm",
      "Colossus Smash with Rend",
      "Mortal Strike with two targets",
      "Execute with Colossus Smash",
      "Dragon Roar for Arms",
      "Whirlwind for Arms AoE",
      "Rend",
      "Siegebreaker",
      "Storm Bolt with Colossus Smash",
      "Shockwave",
      "Execute with Sudden Death"
   },

   RotationST = {
      "Rend",
      "Ravager with Colossus Smash",
      "Colossus Smash",
      "Bladestorm with Colossus Smash",
      "Mortal Strike",
      "Storm Bolt with Colossus Smash",
      "Siegebreaker",
      "Dragon Roar for Arms",
      "Rend early without Colossus Smash",
      "Execute with Colossus Smash",
      "Execute with Sudden Death",
      "Impending Victory for Arms",
      "Slam",
      "Whirlwind for Arms ST",
      "Shockwave"
   },

   FlashInCombat = function()
      c.FlashAll(
         "Pummel",
         "Disrupting Shout"
      )

      if c.EstimatedHarmTargets > 1 then
         rotation = a.Rotations.Arms.RotationAoE
         rotationName = "AoE"
      else
         rotation = a.Rotations.Arms.RotationST
         rotationName = "ST"
      end

      c.DelayPriorityFlash(
         "Impending Victory for Heals",
         "Victory Rush for Heals",
         "Charge",
         "Recklessness for Arms",
         "Bloodbath for Arms",
         "Avatar",
         unpack(rotation) -- must be last line
      )
   end,

   FlashAlways = function()
      c.FlashAll(
         "Battle Stance",
         "Battle Shout",
         "Commanding Shout"
      )
   end,

   CastSucceeded = function(info)
      if c.InfoMatches(info, "Rend") then
         if a.rendAppliedTime == 0 then
            a.rendAppliedTime = GetTime()
         end
      else
         monitorSmashPending(info)
      end
   end,

   -- Taste for Blood, each time Rend deals damage, you gain 3 rage.
   AuraApplied = function(spellID)
      if c.IdMatches(spellID, "Rend") then
         if (GetTime() - a.rendAppliedTime) >= 17 then
            a.rendAppliedTime = 0
         end
      end
   end,

   ExtraDebugInfo = function()
      return format(
         "%s: cs:%s tob:%d",
         rotationName,
         tostring(a.Colossus),
         a.TasteStacks
      )
   end,
}

-------------------------------------------------------------------------- Fury

a.Rotations.Fury = {
   Spec = 2,

   UsefulStats = {"Multistrike", "Strength", "Crit", "Mastery", "Haste", "Versatility"},

   RotationAoE = {
      "Ravager for Fury",
      "Raging Blow with 3x Meat Cleaver and Enraged",
      "Bloodthirst during cleave",
      "Raging Blow with 3x Meat Cleaver",
      "Bladestorm if Enraged for duration",
      "Whirlwind",
      "Execute with Sudden Death",
      "Dragon Roar",
      "Bloodthirst",
      "Wild Strike with Bloodsurge"
   },

   ThreeTargets = {
      "Ravager for Fury",
      "Bladestorm if Enraged",
      "Bloodthirst during cleave",
      "Raging Blow with 2x Meat Cleaver",
      "Execute",
      "Execute with Sudden Death",
      "Dragon Roar",
      "Whirlwind",
      "Bloodthirst",
      "Wild Strike with Bloodsurge"
   },

   TwoTargets = {
      "Ravager for Fury",
      "Dragon Roar",
      "Bladestorm if Enraged",
      "Bloodthirst during cleave",
      "Execute",
      "Execute with Sudden Death",
      "Raging Blow with Meat Cleaver",
      "Whirlwind for Meat Cleaver",
      "Wild Strike with Bloodsurge to avoid cap",
      "Bloodthirst",
      "Whirlwind near cap",
      "Wild Strike with Bloodsurge"
   },

   RotationST = {
      "Wild Strike at Cap",
      "Bloodthirst early",
      "Ravager for Fury",
      "Execute with Sudden Death",
      "Siegebreaker",
      "Storm Bolt",
      "Wild Strike with Bloodsurge",
      "Execute when Enraged",
      "Dragon Roar",
      "Raging Blow",
      "Wild Strike if Enraged",
      "Bladestorm",
      "Shockwave",
      "Impending Victory",
      "Bloodthirst"
   },

   FlashInCombat = function()
      -- @todo danielp 2015-01-18: revisit this and consider if it should be
      -- one "spell", or multiple of them, to make this work.
      c.FlashAll(
         "Pummel",
         "Disrupting Shout"
      )

      -- @todo danielp 2015-01-18: handle other rotation decisions here
      if c.EstimatedHarmTargets > 3 then
         rotation = a.Rotations.Fury.RotationAoE
         rotationName = 'a'
      elseif c.EstimatedHarmTargets == 3 then
         rotation = a.Rotations.Fury.ThreeTargets
         rotationName = '3'
      elseif c.EstimatedHarmTargets == 2 then
         rotation = a.Rotations.Fury.TwoTargets
         rotationName = '2'
      else
         rotation = a.Rotations.Fury.RotationST
         rotationName = 's'
      end

      c.DelayPriorityFlash(
         "Impending Victory for Heals",
         "Victory Rush for Heals",
         "Charge",
         -- call_action_list,name=movement,if=movement.distance>5
         "Berserker Rage for Fury",
         -- heroic_leap,if=<moving>
         "Recklessness for Fury",
         "Avatar",
         "Bloodbath",
         unpack(rotation) -- must remain last line
      )
   end,


   FlashAlways = function()
      c.FlashAll(
         "Battle Stance",
         "Battle Shout",
         "Commanding Shout"
      )
   end,

   FlashOutOfCombat = function()
      c.PriorityFlash(
         "Heroic Throw for Fury",
         "Charge"
      )
   end,

   ExtraDebugInfo = function()
      return format(
         "%s: r:%d ut:%s bs:%s",
         rotationName,
         a.Rage,
         tostring(c.HasTalent("Unquenchable Thirst")),
         tostring(c.HasBuff("Bloodsurge"))
      )
   end,
}

-------------------------------------------------------------------- Protection
a.Rotations.Protection = {
   Spec = 3,

   UsefulStats = { "Mastery", "Crit", "Versatility", "Haste", "Multistrike" },

   FlashInCombat = function()
      c.FlashMitigationBuffs(
         1,
         "Spell Reflection",
         c.COMMON_TANKING_BUFFS,
         "Ravager",
         "Shield Block",
         "Shield Barrier",
         "Demoralizing Shout",
         "Enraged Regeneration",
         "Shield Wall",
         "Last Stand"
      )

      c.FlashAll(
         "Disrupting Shout",
         "Pummel"
      )

      if c.EstimatedHarmTargets > 3 then
         c.DelayPriorityFlash(
            "Bloodbath for Prot",
            "Avatar for Prot",
            "Thunder Clap for Debuff",
            "Heroic Strike",
            "Shield Slam with Shield Block",
            "Ravager for Prot",
            "Dragon Roar for Prot",
            "Shockwave",
            "Revenge",
            "Thunder Clap",
            "Bladestorm",
            "Shield Slam",
            "Storm Bolt",
            "Execute with Sudden Death",
            "Devastate"
         )
      else
         c.DelayPriorityFlash(
            "Heroic Strike",
            "Bloodbath for Prot",
            "Avatar for Prot",
            "Shield Slam",
            "Revenge",
            "Execute for Prot",
            "Execute with Sudden Death",
            "Storm Bolt",
            "Dragon Roar",
            "Impending Victory for Prot",
            "Victory Rush for Prot",
            "Devastate"
         )
      end
   end,

   FlashOutOfCombat = function()
      c.PriorityFlash(
         "Heroic Throw for Prot"
      )
   end,

   FlashAlways = function()
      c.FlashAll(
         "Defensive Stance",
         "Battle Shout",
         "Commanding Shout"
      )
   end,
}
