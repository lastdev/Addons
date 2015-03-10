local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local x = s.UpdatedVariables
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local IsMounted = IsMounted
local UnitBuff = UnitBuff
local UnitLevel = UnitLevel
local UnitGUID = UnitGUID
local GetTime = GetTime
local max = math.max
local select = select
local pairs = pairs

local function getRuneDuration()
   if c.IsCasting("Rune of Power") then
      return 60
   end

   local t1 = c.GetTotemDuration(1)
   local t2 = c.GetTotemDuration(2)
   return max(t1, t2)
end

local function movementCheck(z)
   z.CanCastWhileMoving = a.Presence or a.FloesStack > 0
end

------------------------------------------------------------------------ Common
c.AddOptionalSpell("Mirror Image", nil, {
   Cooldown = 2 * 60,
})

c.AddOptionalSpell("Mirror Image", "without Heating Up", {
   Cooldown = 2 * 60,
   CheckFirst = function()
      return not a.HeatingProc and not a.FireballInFlight
   end,
})


c.AddOptionalSpell("Arcane Brilliance", nil, {
   NoRangeCheck = 1,
   CheckFirst = function()
      return c.RaidBuffNeeded(c.SPELL_POWER_BUFFS)
         or c.RaidBuffNeeded(c.CRIT_BUFFS)
   end
})

c.AddOptionalSpell("Dalaran Brilliance", nil, {
   NoRangeCheck = 1,
   CheckFirst = function()
      return c.RaidBuffNeeded(c.SPELL_POWER_BUFFS)
         or c.RaidBuffNeeded(c.CRIT_BUFFS)
   end
})

c.AddInterrupt("Counterspell")

c.AddOptionalSpell("Spellsteal", nil, {
   FlashColor = "aqua",
   CheckFirst = function()
      local unit = s.UnitSelection()
      if unit == nil or not s.Enemy(unit) then
         return false
      end

      for i = 1, 10000 do
         local _, _, _, _, _, _, _, _, isStealable, _, spellID = UnitBuff(unit, i)
         if spellID == nil then
            return false
         elseif isStealable then
            return true
         end
      end
   end
})

local function netherTempestActiveElsewhere()
   local now = GetTime()
   local target = UnitGUID("target")
   for who, when in pairs(a.NetherTempests) do
      if now - when < (12 - c.LastGCD) then
         if not target or who ~= target then
            return true
         end
      end
   end
   return false
end

c.ManageDotRefresh("Nether Tempest", 1)
c.AssociateTravelTimes(.5, "Nether Tempest")
c.AddOptionalSpell("Nether Tempest", "Early", {
   EarlyRefresh = 4,
   MyDebuff = "Nether Tempest",
   RunFirst = function(z)
      -- c.MakeOptional(z, c.IsSolo() or not s.Boss("target"))
      c.MakeMini(z, netherTempestActiveElsewhere())
   end,
   CheckFirst = function()
      return a.ChargeStacks >= 4 and not a.TargettingCrystal
         and c.ShouldCastToRefresh(
            "Nether Tempest", "Nether Tempest",
            (c.HasTalent("Arcane Orb") and 10 or 7) * a.SpellHaste,
            true)
   end
})

c.AddOptionalSpell("Nether Tempest", "with 4 Arcane Charges", {
   EarlyRefresh = 4,
   MyDebuff = "Nether Tempest",
   RunFirst = function(z)
      -- c.MakeOptional(z, c.IsSolo() or not s.Boss("target"))
      c.MakeMini(z, netherTempestActiveElsewhere())
   end,
   CheckFirst = function()
      return a.ChargeStacks >= 4 and not a.TargettingCrystal
   end
})

-- @todo danielp 2014-12-20: check travel time for LB.
c.AssociateTravelTimes(0, "Living Bomb")
c.AddSpell("Living Bomb", nil, {
   SpecialGCD = 1,
   MyDebuff = "Living Bomb",
   RunFirst = function(z)
      c.MakeOptional(z, c.IsSolo() or not s.Boss("target"))
   end,
   CheckFirst = function()
      if a.TargettingCrystal
         or c.GetHealthPercent("target") <= 1 -- cheap "12 seconds to live"
      then
         return false
      end

      -- should recast at peak, or if we are just about to start to rise, but
      -- we don't track IF direction yet, so...
      -- if c.HasTalent("Incanter's Flow") then
      --    |incanters_flow_dir<0|buff.incanters_flow.stack=5)&remains<3.6)
      --          or ((incanters_flow_dir>0|buff.incanters_flow.stack=1)&remains<gcd.max)
      -- else
      return c.ShouldCastToRefresh("Living Bomb", "Living Bomb", 3.6, true)
       -- end
   end,
})
c.ManageDotRefresh("Living Bomb", 3)

c.AddSpell("Frost Bomb", "for Frozen Orb", {
   MyDebuff = { "Frost Bomb" },
   EarlyRefresh = 10,
   RunFirst = function(z)
      c.MakeOptional(z, c.IsSolo())
   end,
   CheckFirst = function()
      return not a.HasPrismaticCrystal
         and c.GetCooldown("Frozen Orb") < c.LastGCD
   end,
})

-- @todo danielp 2014-12-20: is this right?  how to measure?
c.AssociateTravelTimes(0, "Frost Bomb")
c.AddSpell("Frost Bomb", "Single Target", {
   MyDebuff = { "Frost Bomb" },
   RunFirst = function(z)
      c.MakeOptional(z, c.IsSolo())
   end,
   CheckFirst = function()
      if not c.ShouldCastToRefresh("Frost Bomb", "Frost Bomb", 0.7, true) then
         return false
      end

      if a.FingerCount <= 0 then
         return false
      end

      return a.FingerCount >= 2
         or c.HasTalent("Thermal Void")
         or c.GetBuffDuration("Fingers of Frost") < (c.LastGCD * 2)
   end,
})

c.AddSpell("Frost Bomb", "AoE", {
   MyDebuff = { "Frost Bomb" },
   RunFirst = function(z)
      c.MakeOptional(z, c.IsSolo())
   end,
   CheckFirst = function()
      if not c.ShouldCastToRefresh("Frost Bomb", "Frost Bomb", 0.7, true) then
         return false
      end

      return c.GetCooldown("Frozen Orb") < (c.LastCGD or 1.5) or a.FingerCount >= 2
   end,
})

c.AddSpell("Frost Bomb", "before Crystal", {
   MyDebuff = { "Frost Bomb" },
   CheckFirst = function()
      return c.EstimatedHarmTargets < 2
         and not a.TargettingCrystal
         and c.ShouldCastToRefresh("Frost Bomb", "Frost Bomb", 10, true)
   end,
})

c.AddSpell("Frost Bomb", "on Crystal", {
   MyDebuff = { "Frost Bomb" },
   CheckFirst = function()
      return a.TargettingCrystal
         and c.EstimatedHarmTargets > 1
         and not a.frostBombActive
   end,
})


c.AddOptionalSpell("Presence of Mind", nil, {
   Cooldown = 90,
   NoGCD = true,
})

c.AddOptionalSpell("Presence of Mind", ">= 96", {
   Cooldown = 90,
   NoGCD = true,
   CheckFirst = function()
      return a.ManaPercent >= 96
   end
})

c.AddOptionalSpell("Presence of Mind", "low priority", {
   NoGCD = true,
   CheckFirst = function()
      return a.ChargeStacks < 2
   end
})

c.AddOptionalSpell("Evocation", nil, {
   CheckFirst = function()
      return a.ManaPercent <= 10
   end
})

c.AddOptionalSpell("Rune of Power", nil, {
   NoRangeCheck = true,
   NotIfActive = true,
   CheckFirst = function()
      return not c.HasBuff("Rune of Power", false, false, true)
         or getRuneDuration() <= c.GetCastTime("Rune of Power")
   end
})

c.AddOptionalSpell("Rune of Power", "at 5", {
   NoRangeCheck = true,
   CheckFirst = function()
      return not a.AlterTime
         and getRuneDuration() < 5 + c.GetCastTime("Rune of Power")
         and not c.IsSolo()
   end
})

c.AddSpell("Fire Blast", nil, {
   NotIfActive = true,
})

c.AddOptionalSpell("Ice Barrier", nil, {
   CheckFirst = function(z)
      if not c.IsSolo() then
         return false
      elseif s.InCombat() then
         return not c.HasBuff("Ice Barrier")
      elseif x.EnemyDetected then
         if c.GetBuffDuration("Ice Barrier") < 15 then
            return true
         end

         local val = select(15, UnitBuff("player", s.SpellName(z.ID)))
         return val < (UnitLevel("player") - 29) * 50
      end
   end,
})

c.AddOptionalSpell("Cold Snap", "if health <= 30", {
   CheckFirst = function()
      return c.GetHealthPercent("Player") <= 30
   end
})

c.AddOptionalSpell("Cold Snap", nil, {
   CheckFirst = function()
      return c.GetHealthPercent("Player") < 70
   end
})

c.AddOptionalSpell("Cold Snap", "for Presence of Mind", {
   CheckFirst = function()
      return c.HasSpell("Presence of Mind")
         and not c.HasBuff("Presence of Mind")
         and c.GetCooldown("Presence of Mind") >= 75
   end
})

c.AddOptionalSpell("Cold Snap", "for Dragon's Breath", {
   CheckFirst = function()
      return c.HasGlyph("Dragon's Breath")
         and c.GetCooldown("Dragon's Breath") > c.GetBusyTime()
   end
})

c.AddSpell("Ice Floes", nil, {
   NoGCD = true,
   FlashColor = c.MovementColor,
   Override = function()
      local charges = c.GetChargeInfo("Ice Floes", true)
      return charges > 0 and a.FloesStack == 0
   end,
})

c.AddSpell("Cone of Cold", "Glyphed", {
   Cooldown = 12,
   CheckFirst = function()
      return c.HasGlyph("Cone of Cold")
   end,
})

------------------------------------------------------------------------ Arcane
local function arcanePowerReady()
   if a.ChargeStacks < 4 then
      return false
   end

   if a.HasPrismaticCrystal then
      local cd = c.GetCooldown("Prismatic Crystal")
      return cd <= (c.LastGCD * 2) or cd >= 15
   else
      return true
   end
end

c.AddSpell("Prismatic Crystal", "for Arcane", {
   Cooldown = 90,
   NoRangeCheck = true,
   RunFirst = function(z)
      c.MakeOptional(z, c.IsSolo() or not s.Boss("target"))
   end,
   CheckFirst = function()
      return a.ChargeStacks >= 4
         and (a.ArcanePowerCD < 0.5 or a.ArcanePowerCD > 45)
   end,
})

c.RegisterForFullChannels("Arcane Missiles", 2)

c.AddOptionalSpell("Arcane Power", nil, {
   NoGCD = true,
   Cooldown = 90,
   CheckFirst = arcanePowerReady,
})

c.AddOptionalSpell("Presence of Mind", "before AT", {
   NoGCD = true,
   CheckFirst = function(z)
      if c.GetCastTime("Arcane Blast") < 1.2
         or (not a.ArcanePower
            and (a.ArcanePowerCD > 0 or not arcanePowerReady())) then

         return false
      end

      c.MakePredictor(z, not a.ArcanePower, "yellow")
      return (a.ArcanePower or (a.ArcanePowerCD == 0 and arcanePowerReady()))
         and c.GetCastTime("Arcane Blast") > 1.2
   end
})

c.AddOptionalSpell("Presence of Mind", "before AB", {
   NoGCD = true,
   CheckFirst = function()
      return c.GetCastTime("Arcane Blast") > 1.2
         and c.GetCooldown("Alter Time", false, 180) > 30
   end
})

c.AddOptionalSpell("Presence of Mind", "before Flamestrike", {
   NoGCD = true,
   CheckFirst = function()
      return c.GetCastTime("Flamestrike") > 1.2
         and c.GetCooldown("Alter Time", false, 180) > 30
   end
})

c.AddOptionalSpell("Alter Time", "for Arcane", {
   CheckFirst = function(z)
      if not a.ArcanePower and (not arcanePowerReady() or a.ArcanePowerCD > 0) then
         return false
      end

      c.MakePredictor(
         z,
         not a.ArcanePower
            or (not c.HasBuff("Presence of Mind", false, false, true)
               and c.GetCooldown("Presence of Mind") == 0),
         "yellow")
      return true
   end
})

c.AddOptionalSpell("Evocation", "for Arcane", {
   NotIfActive = true,
   CheckFirst = function()
      return a.ManaPercent < 50
   end
})

c.AddOptionalSpell("Evocation", "Interrupt", {
   FlashColor = "red",
   CheckFirst = function()
      return c.IsCasting("Evocation") and a.ManaPercent > 92
   end
})

c.AddSpell("Arcane Missiles", "with 3 Arcane Missiles", {
   RunFirst = movementCheck,
   CheckFirst = function()
      if a.MissilesStacks >= 3 then
         return true
      end

      if a.MissilesStacks > 0
         and c.HasTalent("Overpowered")
         and a.ArcanePower
         and a.ArcanePowerDuration < c.GetCastTime("Arcane Blast")
      then
         return true
      end

      if a.MissilesStacks > 0
         and c.WearingSet(4, "T17")
         and c.GetBuffDuration("Arcane Instability") < c.GetCastTime("Arcane Blast")
      then
         return true
      end

      return false
   end
})

c.AddSpell("Arcane Missiles", "with 4 Arcane Charges", {
   RunFirst = movementCheck,
   CheckFirst = function()
      return a.MissilesStacks > 0
         and a.ChargeStacks >= 4
         and (a.ArcanePowerCD > 10 * a.SpellHaste or not c.HasTalent("Overpowered"))
   end
})

c.AddSpell("Arcane Barrage", "with 4 Arcane Charges", {
   Cooldown = 3,
   CheckFirst = function()
      return a.ChargeStacks == 4
   end
})

c.AddSpell("Arcane Barrage", "when Moving", {
   Cooldown = 3,
})



c.AddSpell("Arcane Blast", nil, {
   RunFirst = movementCheck,
})

c.AddSpell("Arcane Blast", "at 4 stacks", {
   RunFirst = movementCheck,
   CheckFirst = function()
      return a.ChargeStacks >= 4 and a.ManaPercent >= 93
   end,
})

c.AddSpell("Arcane Blast", "with Profound Magic", {
   RunFirst = movementCheck,
   CheckFirst = function()
      local stack = c.GetBuffStack("Profound Magic")
      if c.IsQueued("Arcane Missiles") then
         stack = stack + 1
      elseif c.IsCasting("Arcane Blast") then
         stack = stack - 1
      end
      return stack > 0
         and not a.AlterTime
         and a.MissilesStacks < 2
         and a.ManaPercent > 93
   end,
})

c.AddOptionalSpell("Flamestrike", nil, {
   MyDebuff = "Flamestrike",
   EarlyRefresh = 2.4,
   RunFirst = movementCheck,
   CheckFirst = function()
      return a.ManaPercent > 10
   end
})

c.AddSpell("Arcane Explosion")

c.AddSpell("Supernova", nil, {
   CheckFirst = function()
      return c.GetChargeInfo("Supernova") > 0
   end
})

c.AddSpell("Supernova", "High Priority", {
   CheckFirst = function()
      -- time_to_die < 8 or...
      return c.GetChargeInfo("Supernova") > 0
         and a.ChargeStacks >= 2
         and (a.ArcanePower or a.ArcanePowerCD > 0)
         and (c.GetCooldown("Prismatic Crystal") > 8
                 or not a.HasPrismaticCrystal)
   end
})

c.AddSpell("Supernova", "Low Priority", {
   CheckFirst = function()
      local charges, recharge = c.GetChargeInfo("Supernova")
      if charges <= 0 then
         return false
      end

      return a.ManaPercent < 96
         and (a.MissilesStacks < 2 or a.ChargeStacks >= 4)
         and (a.ArcanePower or (charges == 1 and a.ArcanePowerCD > recharge))
         and (not a.HasPrismaticCrystal
                 or a.TargettingCrystal
                 or (charges == 1 and
                        c.GetCooldown("Prismatic Crystal") > recharge + 8))
   end,
})

c.AddSpell("Supernova", "on Prismatic Crystal", {
   CheckFirst = function()
      local charges, _ = c.GetChargeInfo("Supernova")

      return charges > 0 and a.TargettingCrystal
   end,
})

c.AddSpell("Supernova", "with mana < 96", {
   CheckFirst = function()
      local charges, _ = c.GetChargeInfo("Supernova")
      return charges > 0 and a.ManaPercent < 96
   end,
})

c.AddSpell("Arcane Orb", nil, {
   NoRangeCheck = true,
   Cooldown = 15,
   CheckFirst = function()
      return a.ChargeStacks < 2
   end
})

-------------------------------------------------------------------------- Fire
c.AssociateTravelTimes(.5, "Fireball", "Pyroblast", "Frostfire Bolt")
c.AssociateTravelTimes(.2, "Scorch", "Inferno Blast")

c.AddSpell("Prismatic Crystal", "for Fire", {
   Cooldown = 90,
   NoRangeCheck = true,
   RunFirst = function(z)
      c.MakeOptional(z, c.IsSolo() or not s.Boss("target"))
   end,
})

c.AddSpell("Fireball")

c.AddSpell("Fireball", "for DoT", {
   CheckFirst = function()
      -- the debuff comes from mastery, so this never triggers for lowbies.
      return UnitLevel("player") >= 80
         and not c.HasMyDebuff("Ignite")
         and not a.FireballInFlight
   end
})

c.AddOptionalSpell("Combustion")

c.AddOptionalSpell("Alter Time", "for Fire", {
   CheckFirst = function(z)
      c.MakePredictor(
         z,
         not c.HasBuff("Presence of Mind", false, false, true)
            and c.GetCooldown("Presence of Mind") == 0,
         "yellow")
      return a.PyroProc
   end
})

c.AddOptionalSpell("Presence of Mind", "for Fire", {
   NoGCD = true,
   Override = function()
      if c.GetCooldown("Presence of Mind", false, 90) > 0 then
         return false
      end

      local at = c.GetCooldown("Alter Time", true, 90)
      if at > 60
         or (at == 0
            and c.GetSpell("Alter Time for Fire"):CheckFirst()) then

         s.Flash(c.GetID("Pyroblast"), "green", s.FlashSizePercent() / 2)
         return true
      end
   end
})

c.AddOptionalSpell("Rune of Power", "for Fire", {
   NoRangeCheck = true,
   CheckFirst = function()
      return getRuneDuration() < (c.GetCastTime("Fireball") + c.LastGCD)
         and not a.HeatingProc
         and not a.FireballInFlight
   end
})

c.AddSpell("Pyroblast", "with Prismatic Crystal", {
   CanCastWhileMoving = true,
   CheckFirst = function()
      if not a.PrismaticCrystal then
         return false
      end

      return c.GetCastTime("Pyroblast") > 0
         and a.PrismaticCrystalRemains < c.LastGCD + 0.5
         and a.PrismaticCrystalRemains > 0.5
   end
})

c.AddSpell("Pyroblast", "before expiration", {
   CanCastWhileMoving = true,
   CheckFirst = function()
      return a.PyroProc
         and c.GetBuffDuration("Pyroblast!") < c.GetCastTime("Fireball")
   end
})

c.AddSpell("Pyroblast", "for T14 4PC", {
   CanCastWhileMoving = true,
   CheckFirst = function()
      return c.HasBuff("Pyromaniac")
   end
})

c.AddSpell("Pyroblast", "when stacked", {
   CanCastWhileMoving = true,
   CheckFirst = function()
      return a.PyroProc and a.HeatingProc and a.FireballInFlight
   end
})

c.AddSpell("Pyroblast", "when solo", {
   CanCastWhileMoving = true,
   CheckFirst = function()
      return a.PyroProc and c.IsSolo() and not s.Boss()
   end
})

c.AddSpell("Pyroblast", "with Pyroblast! or Pyromaniac", {
   CanCastWhileMoving = true,
   CheckFirst = function()
      return a.PyroProc or c.HasBuff("Pyromaniac")
   end
})

c.AddSpell("Pyroblast", "when down", {
   CanCastWhileMoving = false,
   CheckFirst = function()
      return not c.HasMyDebuff("Pyroblast")
         and not c.IsCastingOrInAir("Pyroblast")
   end
})

local lastPrismaticCrystalInfernoBlastCount = 0
c.AddOptionalSpell("Inferno Blast", "with Prismatic Crystal", {
   CheckFirst = function()
      if not a.PrismaticCrystal then
         -- reset our tracking
         lastPrismaticCrystalInfernoBlastCount = 0
         return false
      end

      if c.GetChargeInfo("Inferno Blast") <= 0 then
         return false
      end

      if not c.HasMyDebuff("Combustion") then
         -- can't spread if we don't have the buff, now.
         return false
      end

      -- how many targets do we think we have, and is it more than last cast?
      if c.EstimatedHarmTargets > lastPrismaticCrystalInfernoBlastCount then
         lastPrismaticCrystalInfernoBlastCount = c.EstimatedHarmTargets
         return true
      end

      -- otherwise just assume they have it, or the user overrides us
      return false
   end
})


local lastLivingBombInfernoBlastCount = 0
c.AddOptionalSpell("Inferno Blast", "with Living Bomb", {
   CheckFirst = function()
      if not c.HasMyDebuff("Living Bomb") then
         -- reset our tracking
         lastLivingBombInfernoBlastCount = 0
         return false
      end

      if c.GetChargeInfo("Inferno Blast") <= 0 then
         return false
      end

      -- how many targets do we think we have, and is it more than last cast?
      if c.EstimatedHarmTargets > lastLivingBombInfernoBlastCount then
         lastLivingBombInfernoBlastCount = c.EstimatedHarmTargets
         return true
      end

      -- otherwise just assume they have it, or the user overrides us
      return false
   end
})

c.AddSpell("Inferno Blast", "without Pyroblast!", {
   CheckFirst = function()
      return c.GetChargeInfo("Inferno Blast") > 0
         and a.HeatingProc
         and not a.PyroProc
   end
})

c.AddSpell("Inferno Blast", "with Pyroblast!", {
   CheckFirst = function()
      return c.GetChargeInfo("Inferno Blast") > 0
         and a.PyroProc
         and not a.HeatingProc
         and not a.FireballInFlight
   end
})

c.AddSpell("Inferno Blast", "with Meteor", {
   CheckFirst = function()
      return c.GetChargeInfo("Inferno Blast") > 0
         and c.HasTalent("Meteor")
         and c.GetCooldown("Meteor") < c.LastGCD * 3
   end
})

c.AddSpell("Frostfire Bolt", nil, {
   Continue = true,
   CheckFirst = function()
      return c.HasGlyph("Frostfire Bolt")
   end
})

c.AddOptionalSpell("Meteor", nil, {
   Cooldown = 45,
   CheckFirst = function()
      if c.EstimatedHarmTargets >= 5 then
         return true
      end

      return c.HasGlyph("Combustion")
         and (c.GetBuffStack("Incanter's Flow") >= 4
                 or not c.HasTalent("Incanter's Flow"))
         and (c.GetCooldown("Meteor") - c.GetCooldown("Combustion")) < 10
   end,
})

c.AddOptionalSpell("Meteor", "Unconditionally")

c.AddOptionalSpell("Blast Wave", nil, {
   CheckFirst = function()
      local charges, recharge = c.GetChargeInfo("Blast Wave")
      if charges <= 0 then
         return false
      end

      if c.HasTalent("Incanter's Flow") and c.GetBuffStack("Incanter's Flow") < 4 then
         return false
      end

      return c.GetHealthPercent("target") < 2
         or not a.HasPrismaticCrystal
         or charges == 2
         or a.TargettingCrystal
         or (charges == 1 and c.GetCooldown("Prismatic Crystal") > recharge)
   end
})

c.AddSpell("Dragon's Breath", nil, {
   Cooldown = 20,
   CheckFirst = function()
      return c.HasGlyph("Dragon's Breath")
   end
})

------------------------------------------------------------------------- Frost
c.AssociateTravelTimes(.7, "Frostbolt")

c.AddOptionalSpell("Summon Water Elemental", nil, {
   FlashColor = "yellow",
   CheckFirst = function()
      return not s.UpdatedVariables.PetAlive
         and not IsMounted()
   end
})

c.AddOptionalSpell("Frozen Orb", nil, {
   NoRangeCheck = true,
   Cooldown = 60,
   CheckFirst = function()
      return not a.HasPrismaticCrystal
         and a.FingerCount < 2
         and a.VeinsCD > 45
   end
})

c.AddOptionalSpell("Frozen Orb", "for Crystal", {
   NoRangeCheck = true,
   Cooldown = 60
})

c.AddOptionalSpell("Icy Veins", nil, {
   Cooldown = 3 * 60,
   CheckFirst = function()
      return c.EstimatedHarmTargets >= 4
         or not a.HasPrismaticCrystal
         or c.GetCooldown("Prismatic Crystal") > 15
   end,
})

c.AddOptionalSpell("Presence of Mind", "for Frost", {
   NoGCD = true,
   CheckFirst = function(z)
      c.MakePredictor(
         z, c.HasGlyph("Icy Veins") and a.VeinsCD == 0, "yellow")
      local at = c.GetCooldown("Alter Time")
      return not a.AlterTime
         and (at > 15
            or (at == 0
               and c.GetSpell("Alter Time for Frost"):CheckFirst()))
         and (not c.HasGlyph("Icy Veins")
            or a.VeinsCD > 15
            or (a.VeinsCD == 0
               and c.GetSpell("Icy Veins"):CheckFirst()))
         and c.GetCastTime("Frostbolt") > 1
   end
})

c.AddOptionalSpell("Alter Time", "for Frost", {
   CheckFirst = function(z)
      local hasVeins = c.HasBuff("Icy Veins", false, false, true)
      c.MakePredictor(
         z,
         (not hasVeins and a.VeinsCD == 0)
            or (not c.HasBuff("Presence of Mind")
               and c.GetCooldown("Presence of Mind") == 0),
         "yellow")
      return (a.VeinsCD == 0 or hasVeins or a.VeinsCD > 45)
         and (a.BrainFreeze or a.FingerCount > 0)
   end
})

c.AddOptionalSpell("Freeze", nil, {
   Type = "pet",
   NoRangeCheck = 1,
   NoGCD = true,
   CheckFirst = function()
      if s.SpellCooldown(c.GetID("Freeze")) > 0 then
         return false
      elseif c.AoE and c.HasTalent("Frost Bomb") then
         local dur = s.MyDebuffDuration(c.GetID("Frost Bomb"));
      return dur > .5 and dur < 1.5
      elseif s.Boss() then
         return false
      elseif c.AoE then
         return a.FingerCount == 0
      elseif c.IsSolo() and c.GetCooldown("Deep Freeze") < 25 then
         return a.FingerCount == 0
            and not a.BrainFreeze
            and c.GetCooldown("Deep Freeze") == 0
            and s.SpellInRange(c.GetID("Deep Freeze"))
      else
         return a.FingerCount < 2 and not c.HasMyDebuff("Deep Freeze")
      end
   end
})

c.AddOptionalSpell("Water Jet", nil, {
   Type = "pet",
   NoRangeCheck = 1,
   NoGCD = true,
   Cooldown = 25,
   CheckFirst = function()
      return a.FingerCount <= 0 and not c.HasMyDebuff("Frozen Orb")
   end
})

c.AddOptionalSpell("Water Jet", "on pull", {
   Type = "pet",
   NoRangeCheck = 1,
   NoGCD = true,
   Cooldown = 25,
   CheckFirst = function()
      return a.CombatTime <= 3
         and c.EstimatedHarmTargets < 4
         and not (c.HasTalent("Ice Nova") and c.HasTalent("Prismatic Crystal"))
   end
})

c.AddOptionalSpell("Deep Freeze", nil, {
   CheckFirst = function()
      if s.Boss() or c.GetCooldown("Frozen Orb") > 50 then
         return false
      elseif c.IsSolo() and c.GetCooldown("Freeze", true, 25) == 0 then
         return a.FingerCount == 0
      else
         return a.FingerCount < 2
      end
   end
})

c.AddSpell("Frostfire Bolt", "for Brain Freeze expiration", {
   RunFirst = movementCheck,
   CheckFirst = function()
      return c.HasBuff("Brain Freeze")
         and c.GetBuffDuration("Brain Freeze") < c.GetCastTime("Frostbolt")
   end
})

c.AddSpell("Frostfire Bolt", "with Brain Freeze", {
   RunFirst = movementCheck,
   CheckFirst = function()
      return c.HasBuff("Brain Freeze")
   end
})

c.AddSpell("Ice Lance", "before FoF expiration", {
   CheckFirst = function()
      return c.HasBuff("Fingers of Frost")
         and c.GetBuffDuration("Fingers of Frost") < c.GetCastTime("Frostbolt")
   end
})

c.AddSpell("Ice Lance", "with 2 Fingers or Frozen Orb", {
   CheckFirst = function()
      return a.FingerCount >= 2
         or (a.FingerCount > 0 and c.HasMyDebuff("Frozen Orb"))
   end
})

c.AddSpell("Ice Lance", "with 2 Fingers and Water Jet", {
   CheckFirst = function()
      return a.FingerCount >= 2
         and c.HasMyDebuff("Water Jet")
         and c.IsCastingOrInAir("Frostbolt")
   end
})

-- approximate travel time max is .5 seconds, + 0.1 for slop :)
c.AddSpell("Ice Lance", "with Frost Bomb", {
   CheckFirst = function()
      return c.HasTalent("Frost Bomb")
         and a.FingerCount > 0
         and s.MyDebuffDuration(c.GetID("Frost Bomb")) > 0.6
         and (c.GetCooldown("Icy Veins") > 8 or not c.HasTalent("Thermal Void"))
   end
})

c.AddSpell("Ice Lance", "without Frost Bomb", {
   CheckFirst = function()
      return not c.HasTalent("Frost Bomb")
         and a.FingerCount > 0
         and (c.GetCooldown("Icy Veins") > 8 or not c.HasTalent("Thermal Void"))
   end
})

c.AddSpell("Ice Lance", "on Crystal", {
   CheckFirst = function()
      return a.TargettingCrystal and a.FingerCount > 0
   end
})

c.AddSpell("Frostbolt", nil, {
   RunFirst = movementCheck,
})

c.AddSpell("Frostbolt", "right after Water Jet", {
   RunFirst = movementCheck,
   CheckFirst = function()
      return a.castWaterJet
   end
})

c.AddSpell("Frostbolt", "during Water Jet", {
   RunFirst = movementCheck,
   CheckFirst = function()
      return c.CanLandWithin("Frostbolt", c.GetMyDebuffDuration("Water Jet"))
   end
})

c.AddOptionalSpell("Ice Nova", "with 2 charges", {
   FlashID = { "Ice Nova", "Frost Nova" },
   CheckFirst = function()
      return c.HasTalent("Ice Nova")
         and c.GetChargeInfo("Ice Nova") >= 2
         and (c.GetCooldown("Prismatic Crystal") > 0 or not a.HasPrismaticCrystal)
   end
})

c.AddOptionalSpell("Ice Nova", "with 1 charge", {
   FlashID = { "Ice Nova", "Frost Nova" },
   CheckFirst = function()
      local charges, nextCharge = c.GetChargeInfo("Ice Nova")
      if charges <= 0 then
         return false
      end

      return c.HasTalent("Ice Nova")
         and ((charges == 1 and c.GetCooldown("Prismatic Crystal") > nextCharge
                  and c.GetBuffStack("Incanter's Flow") > 3)
               or not a.HasPrismaticCrystal)
         and (c.HasBuff("Icy Veins") or (charges == 1 and a.VeinsCD > nextCharge))
   end
})

c.AddOptionalSpell("Ice Nova", nil, {
   FlashID = { "Ice Nova", "Frost Nova" },
})

c.AddOptionalSpell("Comet Storm", nil, {
   Cooldown = 30
})

c.AddSpell("Blizzard")

c.AddSpell("Blizzard", "on Crystal", {
   CheckFirst = function()
      if c.EstimatedHarmTargets < 5 then
         return false
      end

      if c.GetCooldown("Frozen Orb") <= c.LastGCD then
         return false
      end

      if c.HasTalent("Frost Bomb") and c.FingerCount >= 2 then
         return false
      end

      return true
   end
})

c.AddSpell("Prismatic Crystal", "for Frost", {
   Cooldown = 90,
   NoRangeCheck = true,
   RunFirst = function(z)
      c.MakeOptional(z, c.IsSolo() or not s.Boss("target"))
   end,
})

