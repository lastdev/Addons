local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local x = s.UpdatedVariables
local g = BittensGlobalTables
local c = g.GetTable("BittensSpellFlashLibrary")

local GetShapeshiftFormID = GetShapeshiftFormID
local GetPowerRegen = GetPowerRegen
local SPELL_POWER_CHI = SPELL_POWER_CHI
local SPELL_POWER_ENERGY = SPELL_POWER_ENERGY
local select = select
local format = string.format
local tostring = tostring
local wipe = wipe
local unpack = unpack

local lastPowerStrike = 0

local function setCost(info)
   info.Cost[SPELL_POWER_ENERGY] = a.GetEnergyCost(info.Name)
   info.Cost[SPELL_POWER_CHI] = a.GetChiCost(info.Name)
end

a.Rotations = { }

function a.PreFlash()
   a.Regen = select(2, GetPowerRegen())
   a.Power = c.GetPower(a.Regen, SPELL_POWER_ENERGY)
   a.Chi = c.GetPower(0, SPELL_POWER_CHI)
   a.MissingChi = s.MaxPower("player", SPELL_POWER_CHI) - a.Chi

   a.Serenity = c.HasBuff("Serenity")

   a.HasChiExplosion = c.HasTalent("Chi Explosion: WW")
      or c.HasTalent("Chi Explosion: BM")
      or c.HasTalent("Chi Explosion: MW")

   a.Ox = GetShapeshiftFormID() == 23 -- ox stance

--c.Debug("Power Calcs", a.Chi, a.Power, a.Regen,
--c.HasBuff("Combo Breaker: Blackout Kick"), c.HasBuff("Combo Breaker: Tiger Palm"))
end

-------------------------------------------------------------------------- Noob
a.Rotations.Noob = {
   FlashInCombat = function()
      c.DelayPriorityFlash(
         "Tiger Palm for Tiger Power",
         "Blackout Kick",
         "Tiger Palm",
         "Jab"
      )
   end,

   FlashOutOfCombat = function()
      if x.EnemyDetected then
         c.DelayPriorityFlash(
            "Tiger Palm for Tiger Power",
            "Blackout Kick",
            "Tiger Palm",
            "Jab"
         )
      end
   end,

   FlashAlways = function()
      c.FlashAll("Roll")
   end,

   CastQueued = setCost,
}

-------------------------------------------------------------------- Brewmaster
local uncontrolledMitigationBuffs = {
   "Diffuse Magic",
   "Staggering", -- 2pT15
}
a.Rotations.Brewmaster = {
   Spec = 1,

   Warning = "The Windwalker rotation is updated for WoD, but only tested to level 80.",

   UsefulStats = {
      "Agility", "Haste", "Mastery", "Versatility", "Multistrike", "Crit"
   },

   PreFlash = function()
      a.Shuffle = c.GetBuffDuration("Shuffle")
      if c.IsQueued("Blackout Kick") then
         a.Shuffle = a.Shuffle + 6
      end

      a.ElusiveStacks = c.GetBuffStack("Elusive Brew Stacker", true, true)

      -- stagger level.  note: we might later change this to non-blizzard
      -- definitions, in which case this allows us to change in one place, not
      -- many, how that is determined.
      if s.Debuff(c.GetID("Heavy Stagger"), "player") then
         a.Stagger = "heavy"
      elseif s.Debuff(c.GetID("Moderate Stagger"), "player") then
         a.Stagger = "moderate"
      elseif s.Debuff(c.GetID("Light Stagger"), "player") then
         a.Stagger = "light"
      else
         a.Stagger = nil
      end
   end,

   FlashInCombat = function()
      c.FlashAll(
         "Chi Brew for BM",
         "Summon Black Ox Statue",
         "Spear Hand Strike",
         "Provoke"
      )

      c.FlashMitigationBuffs(
         1,
         uncontrolledMitigationBuffs,
         c.COMMON_TANKING_BUFFS,
         "Elusive Brew",
         "Diffuse Magic",
         "Dampen Harm",
         "Fortifying Brew"
      )

      c.DelayPriorityFlash(
         "Invoke Xuen, the White Tiger for BM",
         "Serenity for BM",
         "Purifying Brew no Chi Explosion, Heavy Stagger",
         "Blackout Kick for Shuffle",
         "Purifying Brew with Serenity",
         "Purifying Brew no Chi Explosion, Moderate Stagger",
         "Guard",
         "Breath of Fire",
         "Keg Smash",
         "Rushing Jade Wind for BM",
         "Chi Burst for BM",
         "Chi Wave for BM",
         "Zen Sphere for BM",
         "Chi Explosion: BM",
         "Touch of Death",
         "Blackout Kick to extended Shuffle",
         "Expel Harm for BM",
         "Jab for BM",
         "Tiger Palm for BM"
      )
   end,

   FlashOutOfCombat = function()
      if x.EnemyDetected then
         c.DelayPriorityFlash(
            "Keg Smash",
            "Blackout Kick to extended Shuffle",
            "Expel Harm for BM",
            "Jab for BM",
            "Tiger Palm for BM"
         )
      end
   end,

   FlashAlways = function()
      c.FlashAll(
         "Stance of the Sturdy Ox",
         "Legacy of the Emperor",
         "Roll"
      )
   end,

   CastQueued = setCost,

   ExtraDebugInfo = function()
      return format(
         "c:%d e:%.1f s:%.1f b:%.1f E:%d S:%s",
         a.Chi, a.Power, a.Shuffle, c.GetBusyTime(),
         a.ElusiveStacks, a.Shuffle
      )
   end,
}

-------------------------------------------------------------------- Mistweaver
a.Rotations.Mistweaver = {
   Spec = 2,
   AoEColor = "orange",

   Warning = "The Mistweaver rotations (either healing or fistweaving) have not been updated since MoP.  This is a work in progress, and will happen, but is not available yet.",

   UsefulStats = { "Intellect", "Spirit", "Crit", "Haste" },

   FlashInCombat = function()
      if c.IsCasting("Soothing Mist") or c.IsQueued("Soothing Mist") then
         a.SoothDamage = s.HealthDamagePercent(a.SoothTarget)
      else
         a.SoothDamage = 0
      end

      c.FlashAll(
         "Spear Hand Strike",
         "Chi Brew for Mistweaver",
         "Mana Tea",
         "Enveloping Mist",
         "Surging Mist",
         "Uplift",
         "Summon Jade Serpent Statue")

      if not c.HasSpell("Muscle Memory") then
         return
      end

      if c.IsCasting("Tiger Palm", "Blackout Kick") then
         a.MuscleMemory = false
      elseif c.IsCasting(
         "Jab", "Spinning Crane Kick", "Rushing Jade Wind") then

         a.MuscleMemory = true
      else
         a.MuscleMemory = c.HasBuff("Muscle Memory")
      end
      if a.MuscleMemory
         or s.PowerPercent("player") > c.GetOption("MeleeCutoff")
         or c.IsSolo() then

         c.PriorityFlash(
            "Touch of Death for Mistweaver",
            "Blackout Kick for Serpent's Zeal",
            "Chi Wave for Mistweaver",
            "Expel Harm for Mistweaver",
            "Tiger Palm for Mistweaver",
            "Rushing Jade Wind for Mistweaver",
            "Spinning Crane Kick for Mistweaver",
            "Jab for Mistweaver",
            "Crackling Jade Lightning")
      end
   end,

   FlashAlways = function()
      c.FlashAll(
         "Stance of the Wise Serpent", "Legacy of the Emperor", "Roll")
   end,

   CastQueued = function(info)
      setCost(info)
      if c.InfoMatches(info, "Soothing Mist") then
         a.SoothTarget = info.Target
         c.Debug("Event", "Soothing Mist cast at", a.SoothTarget)
      end
   end,

   ExtraDebugInfo = function()
      return format("c:%d m:%s s:%s d:%.1f",
         a.Chi,
         tostring(a.MuscleMemory),
         a.SoothTarget or "none",
         a.SoothDamage or 0)
   end,
}

-------------------------------------------------------------------- Windwalker
a.SefTargets = { }

a.Rotations.Windwalker = {
   Spec = 3,

   Warning = "The Windwalker rotation is updated for WoD, but only tested to level 80.",

   UsefulStats = { "Agility", "Multistrike", "Crit", "Haste", "Versatility", "Mastery" },

   RotationST = {
      "Fists of Fury",
      "Touch of Death",
      "Hurricane Strike",
      "Energizing Brew",
      "Rising Sun Kick without Chi Explosion",
      "Chi Wave for WW",
      "Chi Burst for WW",
      "Zen Sphere for WW",
      "Blackout Kick under Combo Breaker",
      "Blackout Kick under Serenity",
      "Chi Explosion: WW under Combo Breaker",
      "Tiger Palm under Combo Breaker",
      "Blackout Kick near cap",
      "Chi Explosion: WW at 3",
      "Expel Harm for WW",
      "Jab for WW",
      "Crackling Jade Lightning"
   },

   RotationAoE = {
      "Chi Explosion: WW at 4",
      "Rushing Jade Wind",
      "Rising Sun Kick without Rushing Jade Wind",
      "Fists of Fury for AoE",
      "Touch of Death",
      "Hurricane Strike for AoE",
      "Zen Sphere for WW AoE",
      "Chi Wave for WW",
      "Chi Burst for WW",
      "Blackout Kick under Combo Breaker with RJW",
      "Blackout Kick under Serenity with RJW",
      "Tiger Palm under Combo Breaker with RJW",
      "Blackout Kick near cap with RJW",
      "Spinning Crane Kick",
      "Jab for WW with RJW"
   },

   FlashInCombat = function()
      if not c.HasBuff("Storm, Earth, and Fire") then
         wipe(a.SefTargets)
      end

      local rotation = c.EstimatedHarmTargets < 3
         and a.Rotations.Windwalker.RotationST
         or a.Rotations.Windwalker.RotationAoE

      c.FlashAll(
         "Spear Hand Strike",
         "Fortifying Brew for WW",
         "Surging Mist for WW"
      )

      c.DelayPriorityFlash(
         "Invoke Xuen, the White Tiger",
         -- maybe advise using the chi sphere now?
         "Chi Brew for WW",
         "Tiger Palm if expiring",
         "Tigereye Brew",
         "Rising Sun Kick for Debuff",
         "Tiger Palm for Tiger Power",
         "Serenity for WW",
         unpack(rotation)       -- must remain last line.
      )
   end,

   FlashOutOfCombat = function()
      if x.EnemyDetected then
         c.DelayPriorityFlash(
            "Rising Sun Kick for Debuff",
            "Tiger Palm for Tiger Power",
            "Jab for WW",
            "Crackling Jade Lightning"
         )
      end
   end,

   FlashAlways = function()
      c.FlashAll(
         "Stance of the Fierce Tiger",
         "Legacy of the Emperor",
         "Legacy of the White Tiger",
         "Roll"
      )
   end,

   CastQueued = setCost,

   CastSucceeded = function(info)
      if info.TargetID and c.InfoMatches(info, "Storm, Earth, and Fire") then
         a.SefTargets[info.TargetID] = true
         c.Debug("Event", "Storm, Earth, and Fire on", info.Target, info.TargetID)
      end
   end,

   UncastSpellFailed = function(info)
      if info.TargetID and c.InfoMatches(info, "Storm, Earth, and Fire") then
         a.SefTargets[info.TargetID] = nil
         c.Debug("Event", "Storm, Earth, and Fire removed from",
                 info.Target, info.TargetID)
      end
   end,

   ExtraDebugInfo = function()
      return format("c:%d p:%.1f", a.Chi, a.Power)
   end,
}
