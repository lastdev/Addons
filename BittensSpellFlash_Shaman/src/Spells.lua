local addonName, a = ...

local L = a.Localize
local s = SpellFlashAddon
local g = BittensGlobalTables
local c = g.GetTable("BittensSpellFlashLibrary")
local u = g.GetTable("BittensUtilities")

local GetInventoryItemID = GetInventoryItemID
local GetItemInfo = GetItemInfo
local GetTime = GetTime
local GetTotemInfo = GetTotemInfo
local IsSwimming = IsSwimming
local UnitGUID = UnitGUID
local UnitSpellHaste = UnitSpellHaste
local GetMasteryEffect = GetMasteryEffect
local GetCombatRatingBonus = GetCombatRatingBonus

local CR_MULTISTRIKE = CR_MULTISTRIKE

local math = math
local select = select

local fishingPoleType = select(17, GetAuctionItemSubClasses(1))

local function shouldFlashImbue(buffTooltipName, offhand)
   local mhID = GetInventoryItemID("player", 16)
   if mhID == nil or select(7, GetItemInfo(mhID)) == fishingPoleType then
      return false
   end

   local min
   if s.InCombat() then
      min = 0
   elseif c.IsSolo() then
      min = 2 * 60
   else
      min = 5 * 60
   end
   if offhand then
      return not s.OffHandItemBuff(L[buffTooltipName], min)
   else
      return not s.MainHandItemBuff(L[buffTooltipName], min)
   end
end

local function walkingCheck(z)
   z.CanCastWhileMoving =
      c.HasBuff("Spiritwalker's Grace", false, false, true)
      or c.GetCastTime(z.ID) == 0
end

------------------------------------------------------------------------ Common
c.AddOptionalSpell("Lightning Shield", nil, {
   Override = function()
      return c.GetBuffStack("Lightning Shield") < 2
         and c.SelfBuffNeeded("Lightning Shield")
   end
})

c.AddOptionalSpell("Earth Elemental Totem", nil, {
   CheckFirst = function()
      return c.GetCooldown("Fire Elemental Totem") > 50
   end
})

c.AddOptionalSpell("Fire Elemental Totem", nil, {
   CheckFirst = function()
      return c.IsMissingTotem(1)
   end
})

c.AddOptionalSpell("Storm Elemental Totem", nil, {
   CheckFirst = function()
      return c.IsMissingTotem(1)
   end,
})

c.AddOptionalSpell("Elemental Mastery")

c.AddSpell("Elemental Mastery", "for Elemental", {
   RunFirst = function(spell)
      c.MakeOptional(spell, s.Boss())
   end,
   CheckFirst = function()
      return c.GetCastTime("Lava Burst") >= 1.2
   end,
})

c.AddSpell("Elemental Blast", nil, {
   NotIfActive = true,
   RunFirst = walkingCheck,
})

c.AddOptionalSpell("Searing Totem", nil, {
   CheckFirst = function()
      if c.HasTalent("Liquid Magma") then
         local duration, name = c.GetTotemDuration(1)
         local searing = name == s.SpellName(c.GetID("Searing Totem"))
         return c.IsMissingTotem(1) or
            (searing and duration <= 20 and not c.HasBuff("Liquid Magma"))
      else
         return c.IsMissingTotem(1)
      end
   end
})

c.AddOptionalSpell("Liquid Magma", "for Elemental", {
   CheckFirst = function()
      local dur, name = c.GetTotemDuration(1)
      return dur >= 15 and
         (name == s.SpellName(c.GetID("Searing Totem")) or
             name == s.SpellName(c.GetID("Fire Elemental Totem")))
   end,
})

c.AddOptionalSpell("Healing Surge", "when Solo", {
   Override = function()
      return c.IsSolo() and c.GetHealthPercent("player") < 80
   end
})

c.AddOptionalSpell("Water Walking", nil, {
   Override = function()
      return IsSwimming() and c.SelfBuffNeeded("Water Walking")
   end
})

c.AddDispel("Purge", nil, "Magic")

c.AddInterrupt("Wind Shear")

--------------------------------------------------------------------- Elemental
local function burstCheck(z)
   walkingCheck(z)
   return a.Ascended
      or (c.GetCooldown("Lava Burst") == 0
             and (not c.IsCasting("Lava Burst") or c.EotE))
      or (c.HasBuff("Lava Surge") and not c.IsQueued("Lava Burst"))
end

c.AddOptionalSpell("Spiritwalker's Grace", "for Elemental with Ascendance", {
   CheckFirst = function()
      return s.Moving("player") and a.Ascended
   end
})

c.AddOptionalSpell("Spiritwalker's Grace", "for Elemental", {
   CheckFirst = function()
      return s.Moving("player") and
         (c.GetCooldown("Elemental Blast") == 0 or
             (c.GetCooldown("Lava Burst") == 0 and not c.HasBuff("Lava Surge")))
   end
})

c.AddOptionalSpell("Ancestral Swiftness", "for Elemental", {
   CheckFirst = function()
      return c.GetCastTime("Lightning Bolt") > 1.2 and not a.Ascended
   end
})

c.AddOptionalSpell("Ascendance", "for Elemental", {
   Buff = "Ascendance",
   BuffUnit = "player",
   CheckFirst = function(z)
      if c.EstimatedHarmTargets > 1 then
         z.PredictFlashID = nil
         return true
      end

      z.PredictFlashID = c.GetID("Lava Burst")
      return (c.GetCooldown("Lava Burst") > 0 or c.IsCasting("Lava Burst"))
         and c.GetMyDebuffDuration("Flame Shock") > 15
   end
})

c.AddSpell("Unleash Flame", "for Unleashed Fury", {
   Cooldown = 15,
   NoRangeCheck = true,
   CheckFirst = function()
      return c.HasTalent("Unleashed Fury: Elemental")
         and not a.Ascended
         and c.GetCooldown("Unleash Flame") <= 0
   end,
})

c.AddSpell("Flame Shock", "Prime for Elemental", {
   NotIfActive = true,
   CheckFirst = function()
      return c.GetMyDebuffDuration("Flame Shock")
         <= c.GetCastTime("Lava Burst") + .2
   end,
})

c.AddSpell("Flame Shock", "for Elemental", {
   Tick = 3,
   NotIfActive = true,
   CheckFirst = function(z)
      local duration = c.GetMyDebuffDuration("Flame Shock")
      if c.HasBuff("Elemental Mastery") or c.HasBuff(c.BLOODLUST_BUFFS) then
         return duration <= 2 * z.EarlyRefresh
      else
         return duration <= z.EarlyRefresh
      end
   end
})

c.AddSpell("Flame Shock", "refresh for Ascendance", {
   CheckFirst = function(z)
      local duration = c.GetMyDebuffDuration("Flame Shock")
      return duration <= 15 and (c.GetCooldown("Ascendance") + 15) < duration
   end
})

c.AddSpell("Flame Shock", "Early", {
   MyDebuff = "Flame Shock",
   EarlyRefresh = 9,
})

c.AddSpell("Lava Burst", nil, {
   EvenIfNotUsable = true,
   CheckFirst = function (z)
      -- either the target has flame shock when the spell lands, or they are
      -- far enough away that we can cast it on them before LB hits, or we
      -- can't cast Flame Shock right now.
      return burstCheck(z)
         and ((c.GetMyDebuffDuration("Flame Shock") > c.GetCastTime("Lava Burst"))
               or c.DistanceAtTheLeast(20)
               or c.GetCooldown("Flame Shock") > 0)
   end
})

c.AddSpell("Earth Shock", "for Elemental", {
   CheckFirst = function()
      local stacks = c.GetBuffStack("Lightning Shield")
      if c.WearingSet(4, "T17") then
         return stacks >= 15 or c.HasBuff("Lava Surge")
      else
         return stacks > 15
      end
   end
})

c.AddSpell("Earth Shock", nil, {
   CheckFirst = function()
      return c.GetBuffStack("Lightning Shield") >= 7
   end
})

c.AddOptionalSpell("Searing Totem", "for Elemental", {
   CheckFirst = function()
      return c.IsMissingTotem(1)
         and c.GetCooldown("Fire Elemental Totem") > 15
   end
})

c.AddOptionalSpell("Thunderstorm", nil, {
   NotIfActive = true,
   CheckFirst = function()
      return s.PowerPercent("player") < 85
   end
})

c.AddOptionalSpell("Thunderstorm", "for damage", {
   NotIfActive = true,
   CheckFirst = function()
      return c.EstimatedHarmTargets >= 10
   end
})

c.AddSpell("Lightning Bolt")

c.AddSpell("Lava Beam", nil, {
   FlashID = { "Chain Lightning", "Lava Beam" },
   Override = function()
      return a.Ascended
   end,
})

c.AddSpell("Chain Lightning", nil, {
   FlashID = { "Chain Lightning", "Lava Beam" },
   RunFirst = walkingCheck,
   CheckFirst = function()
      return c.EstimatedHarmTargets >= 2 and s.PowerPercent("player") > 10
   end
})

c.AddOptionalSpell("Earthquake", "for AoE", {
   CheckFirst = function()
      return (c.HasBuff("Enhanced Chain Lightning") or
                 not c.HasSpell("Enhanced Chain Lightning"))
   end
})

c.AddOptionalSpell("Earthquake", "single target", {
   CheckFirst = function()
      -- return c.GetCooldown("Earthquake") > 1

      -- @todo danielp 2014-11-18: this is a cheap "time to die" > 10
      if c.GetHealth("target") < 2 * s.MaxHealth("player") then
         return false
      end

      -- buffs that change the state of play
      local em = c.GetBuffDuration("Elemental Mastery")
      local bloodlust = s.MyBuffDuration(c.BLOODLUST_BUFFS)

      -- how effective our earthquake is going to be
      local spellhaste = 1 + (UnitSpellHaste("player") / 100)
      local mastery = 1 + ((GetMasteryEffect("player") / 100) * 2 / 4.5)
      local effect = spellhaste * mastery

      -- how much damage it needs to do to be worth the casting time
      local multistrike = (GetCombatRatingBonus(CR_MULTISTRIKE) / 100)
      -- 1.875, * 1.3 if we have UF talent
      local required = c.HasTalent("Unleashed Fury: Elemental") and 2.4375 or 1.875

      -- math thanks to SimCraft 603-9 / theorycrafting
      required = required + ((1.25 * 0.226305) + 1.25 * (2 * 0.226305 * multistrike))


      if (em == 0 and bloodlust == 0) or em >= 10 or bloodlust >= 10 then
         return effect >= required
      end

      if em > 0 or bloodlust > 0 then
         return effect >= 1.3 * required
      end

      return false
   end,
})

----------------------------------------------------------------------- Enhance
c.AddOptionalSpell("Ascendance", "for Enhancement", {
   CheckFirst = function()
      return c.GetCooldown("Stormstrike") > 3
         and not a.Ascended
   end
})

c.AddSpell("Unleash Elements", "with Unleashed Fury", {
   NoRangeCheck = true,
   CheckFirst = function()
      return c.HasTalent("Unleashed Fury: Enhancement") and not a.Ascended
   end
})

c.AddSpell("Elemental Blast", "for Enhance", {
   Cooldown = 12,
   CheckFirst = function(z)
      c.MakeOptional(z, s.Moving("player") and a.Maelstrom < 5)
      return a.Maelstrom > 0
   end,
})

c.AddSpell("Stormblast", nil, {
   FlashID = { "Stormblast", "Stormstrike" },
})

c.AddSpell("Stormstrike", nil, {
   Melee = true,
   FlashID = { "Stormblast", "Stormstrike" },
})

c.AddSpell("Lightning Bolt", "at 5", {
   CheckFirst = function()
      return a.Maelstrom == 5
   end
})

c.AddSpell("Lightning Bolt", "at 3", {
   CheckFirst = function()
      return a.Maelstrom >= 3
         and not a.Ascended
         and (not s.Moving("player"))
   end
})

c.AddSpell("Lightning Bolt", "at 2", {
   CheckFirst = function()
      return a.Maelstrom >= 2
         and not a.Ascended
         and c.GetMinCooldown(
               "Lava Lash",
               "Unleash Elements",
               "Feral Spirit",
               "Stormstrike", -- reports on cooldown w/ stormblast
               "Ascendance", -- resets stormblast cooldown
               "Elemental Blast")
            > .5
   end
})

c.AddSpell("Lightning Bolt", "2pT15", {
   CheckFirst = function()
      return a.Maelstrom >= 4
         and not a.Ascended
         and c.WearingSet(2, "EnhanceT15")
   end
})

c.AddSpell("Lightning Bolt", "under Ancestral Swiftness", {
   CheckFirst = function()
      return c.HasBuff("Ancestral Swiftness")
   end
})

c.AddOptionalSpell("Ancestral Swiftness", "under 2", {
   CheckFirst = function()
      return c.GetBuffStack("Maelstrom Weapon") < 2
   end
})

c.AddSpell("Flame Shock", "Apply", {
   CheckFirst = function()
      return not c.HasMyDebuff("Flame Shock")
   end
})

c.AddSpell("Flame Shock", "Empowered Apply", {
   CheckFirst = function()
      return c.HasBuff("Unleash Flame") and not c.HasMyDebuff("Flame Shock")
   end
})

c.AddOptionalSpell("Feral Spirit", nil, {
   NoRangeCheck = true,
})

c.AddOptionalSpell("Feral Spirit", "4pT15", {
   NoRangeCheck = true,
   CheckFirst = function()
      return c.WearingSet(4, "EnhanceT15")
   end
})

c.AddSpell("Searing Totem", "Refresh", {
   CheckFirst = function(z)
      local dur, name = c.GetTotemDuration(1)
      return name == s.SpellName(z.ID)
         and dur < 30
         and c.GetMinCooldown(
               "Lava Lash",
               "Unleash Elements",
               "Feral Spirit",
               "Stormstrike", -- reports on cooldown w/ stormblast
               "Ascendance", -- resets stormblast cooldown
               "Elemental Blast")
            > c.LastGCD
   end
})

------------------------------------------------------------------------- Resto
c.AddOptionalSpell("Water Shield", nil, {
   Override = function()
      return c.SelfBuffNeeded("Water Shield")
   end
})

c.AddOptionalSpell("Spiritwalker's Grace", "for Resto", {
   CheckFirst = function()
      return s.Moving("player")
   end
})

c.AddOptionalSpell("Earth Shield", nil, {
   Override = function(z)
      if c.IsSolo() then
         return false
      end

      if not a.EarthShieldTarget then
         return true
      end

      if s.InCombat() then
         return not s.MyBuff(z.ID, a.EarthShieldTarget)
      else
         return s.MyBuffDuration(z.ID, a.EarthShieldTarget) < 2 * 60
            or s.MyBuffStack(z.ID, a.EarthShieldTarget) < 9
      end
   end
})

c.AddOptionalSpell("Healing Stream Totem", nil, {
   CheckFirst = function()
      return c.IsMissingTotem(3) or c.HasTalent("Totemic Persistence")
   end
})

c.AddOptionalSpell("Lightning Bolt", "for Mana", {
   Override = function()
      return c.HasGlyph("Telluric Currents")
         and s.PowerPercent("player") < 95
         and s.HealthPercent("raid|range") > 90
   end
})
