local addonName, a = ...

local s = SpellFlashAddon
local g = BittensGlobalTables
local c = g.GetTable("BittensSpellFlashLibrary")
local u = g.GetTable("BittensUtilities")
local x = s.UpdatedVariables

local GetMastery = GetMastery
local GetSpellBonusDamage = GetSpellBonusDamage
local GetSpellCritChance = GetSpellCritChance
local UnitGUID = UnitGUID

local unpack = unpack

a.Rotations = { }

a.EotE = false

local flameShockStrength = {}
function a.NextFlameShockStrength()
   return 1 +
      (c.HasBuff("Unleash Flame") and 0.4 or 0) +
      (c.GetBuffStack("Elemental Fusion") * 0.4)
end
function a.LastFlameShockStrength()
   return flameShockStrength[UnitGUID("target")] or 0
end

function a.PreFlash()
   a.Ascended = c.HasBuff("Ascendance", false, false, true)
end


--------------------------------------------------------------------- Elemental
a.Rotations.Elemental = {
   Spec = 1,

   UsefulStats = {
      "Multistrike", "Haste", "Crit", "Intellect"
   },

   SingleTargetPriorityList = {
      "Spiritwalker's Grace for Elemental with Ascendance",
      "Earth Shock at cap",
      "Flame Shock when expiring",
      "Lava Burst",
      "Unleash Flame for Unleashed Fury",
      "Flame Shock to upgrade",
      "Earth Shock for Elemental",
      "Flame Shock Early",
      "Earthquake single target",
      "Elemental Blast",
      "Flame Shock refresh for Ascendance",
      "Searing Totem",
      "Spiritwalker's Grace for Elemental",
      "Lightning Bolt"
   },

   AoEPriorityList = {
      "Earthquake for AoE",
      "Lava Beam",
      "Earth Shock at cap",
      "Thunderstorm for damage",
      "Searing Totem",
      "Chain Lightning",
      "Lightning Bolt",
   },

   FlashInCombat = function(r)
      c.FlashAll(
         "Ascendance for Elemental",
         "Fire Elemental Totem",
         "Spiritwalker's Grace",
         "Purge",
         "Wind Shear"
      )

      local rotation
      -- @todo danielp 2014-11-27: we still seem to over-estimate harm
      -- targets for ele, so maybe try this?  should be > 1.
      if c.EstimatedHarmTargets > 2 then
         rotation = r.AoEPriorityList
      else
         rotation = r.SingleTargetPriorityList
      end

      c.DelayPriorityFlash(
         -- common to both rotations
         "Elemental Mastery for Elemental",
         "Ancestral Swiftness for Elemental",
         "Storm Elemental Totem",
         "Fire Elemental Totem",
         "Ascendance for Elemental",
         "Searing Totem for Liquid Magma",
         "Liquid Magma for Elemental",
         -- this must be the last item for this to work
         unpack(rotation)
      )
   end,

   FlashOutOfCombat = function()
      c.FlashAll("Water Walking")

      if x.EnemyDetected then
         if s.Boss("target") or s.Boss("mouseover") then
            c.FlashAll("Fire Elemental Totem")
         end

         -- opening rotation, by priority.
         c.PriorityFlash(
            "Unleash Flame for Unleashed Fury",
            "Earthquake",
            "Elemental Blast",
            "Flame Shock Early",
            "Lava Burst"
         )
      end
   end,

   FlashAlways = function()
      c.FlashAll(
         "Lightning Shield",
         "Healing Surge when Solo"
      )
   end,

   PreFlash = function()
      a.EotE = c.HasBuff("Echo of the Elements Buff: Ele", false, false, true)
   end,

   CastSucceeded_FromLog = function(spellID, target, targetID)
      if spellID == c.GetID("Flame Shock") then
         local strength = a.NextFlameShockStrength()
         flameShockStrength[targetID] = strength
         c.Debug("Event", "Flame Shock cast at", target, "@", strength)
      end
   end,

   AuraApplied = function(spellID)
      if spellID == c.GetID("Liquid Magma") then
         c.Debug("Event", "Liquid Magma started")
         a.LiquidMagma = true
      end
   end,

   AuraRemoved = function(spellID)
      if spellID == c.GetID("Liquid Magma") then
         c.Debug("Event", "Liquid Magma stopped")
         a.LiquidMagma = false
      end
   end,
}

------------------------------------------------------------------- Enhancement
a.FSStats = {}

function a.GetFSStats(hasUnleashFlame)
   local critMultiplier = 2
   local tick = c.GetHastedTime(3)
   return (266.2 + .2385 * GetSpellBonusDamage(3))
      * (1 + .02 * GetMastery())
      * (1 + (critMultiplier - 1) * GetSpellCritChance(3) / 100)
      * (hasUnleashFlame and 1.3 or 1)
      / tick,
   tick
end

a.Rotations.Enhancement = {
   Spec = 2,

   UsefulStats = { "Agility", "Multistrike", "Crit", "Haste" },

   FlashInCombat = function()
      if c.IsCasting("Lightning Bolt")
      and not c.HasBuff("Ancestral Swiftness") then

         a.Maelstrom = 0
      else
         a.Maelstrom = c.GetBuffStack("Maelstrom Weapon")
      end

      c.FlashAll(
         "Elemental Mastery",
         "Fire Elemental Totem",
         "Searing Totem",
         "Ascendance for Enhancement",
         "Purge",
         "Wind Shear")
      c.PriorityFlash(
         "Unleash Elements with Unleashed Fury",
         "Elemental Blast for Enhance",
         "Lightning Bolt at 5",
         "Feral Spirit 4pT15",
         "Flame Shock Empowered Apply",
         "Stormblast",
         "Stormstrike",
         "Lava Lash",
         "Lightning Bolt 2pT15",
         "Unleash Elements",
         "Lightning Bolt at 3",
         "Ancestral Swiftness under 2",
         "Lightning Bolt under Ancestral Swiftness",
         "Flame Shock Apply",
         "Earth Shock",
         "Feral Spirit",
         "Earth Elemental Totem",
         "Lightning Bolt at 2",
         "Searing Totem Refresh")
   end,

   FlashOutOfCombat = function()
      c.FlashAll("Water Walking")
   end,

   FlashAlways = function()
      c.FlashAll(
         "Lightning Shield",
         "Healing Surge when Solo")
   end,

   AuraApplied = function(spellID, _, targetID)
      if c.IdMatches(spellID, "Flame Shock") then
         local snap = u.GetOrMakeTable(a.FSStats, targetID)
         snap.Dps, snap.Tick = a.GetFSStats(
            s.Buff(c.GetID("Unleash Flame"), "player"))
         c.Debug("Event", "Flame Shock ticking at", snap.Dps, "dps")
      end
   end,

   LeftCombat = function()
      a.FSStats = {}
      c.Debug("Event", "Left Combat")
   end,

   ExtraDebugInfo = function()
      return a.Maelstrom
   end,
}

------------------------------------------------------------------- Restoration
a.Rotations.Restoration = {
   Spec = 3,

   UsefulStats = { "Intellect", "Spirit", "Crit", "Multistrike", "Haste" },

   FlashInCombat = function()
      c.FlashAll(
         "Healing Stream Totem",
         "Lightning Bolt for Mana",
         "Purge",
         "Wind Shear")
   end,

   FlashOutOfCombat = function()
      c.FlashAll("Water Walking")
   end,

   FlashAlways = function()
      c.FlashAll(
         "Earth Shield",
         "Water Shield")
   end,

   CastSucceeded = function(info)
      if c.InfoMatches(info, "Earth Shield") then
         a.EarthShieldTarget = info.Target
         c.Debug("Event", "Earth Shield target:", a.EarthShieldTarget)
      end
   end,
}
