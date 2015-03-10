local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local g = BittensGlobalTables
local c = g.GetTable("BittensSpellFlashLibrary")
local u = g.GetTable("BittensUtilities")

local GetSpellCharges = GetSpellCharges
local GetTime = GetTime
local IsMounted = IsMounted
local SPELL_POWER_CHI = SPELL_POWER_CHI
local SPELL_POWER_ENERGY = SPELL_POWER_ENERGY
local UnitGUID = UnitGUID
local UnitHealth = UnitHealth
local UnitHealthMax = UnitHealthMax
local UnitInRange = UnitInRange
local UnitIsDeadOrGhost = UnitIsDeadOrGhost
local UnitIsUnit = UnitIsUnit
local UnitPowerMax = UnitPowerMax
local UnitStagger = UnitStagger
local max = math.max
local min = math.min

local spellCosts = {}

local function setCost(name, energy, chi, freeBuff)
   spellCosts[s.SpellName(c.GetID(name))] = {
      Energy = energy,
      Chi = chi,
      FreeBuff = freeBuff and c.GetID(freeBuff),
   }
end

local function nameMatches(localizedName, name)
   return s.SpellName(c.GetID(name), true) == localizedName
end

function a.GetEnergyCost(localizedName)
   return spellCosts[localizedName] and spellCosts[localizedName].Energy
end

function a.GetChiCost(localizedName)
   local cost = spellCosts[localizedName]
   if cost == nil then
      return nil
   end


   if cost.FreeBuff and s.Buff(cost.FreeBuff, "player") then
      return 0
   end

   local cost = cost.Chi
   if nameMatches(localizedName, "Jab")
      or nameMatches(localizedName, "Expel Harm")
   then
      if s.Form(c.GetID("Stance of the Fierce Tiger")) then
         cost = cost - 1
         if nameMatches(localizedName, "Jab")
            and c.HasBuff("Power Strikes")
         then
            cost = cost - 1
         end
      end
   elseif nameMatches(localizedName, "Tiger Palm") then
      if a.Ox then
         cost = 0
      end
   end
   return cost
end

setCost("Blackout Kick", 0, 2, "Combo Breaker: Blackout Kick")
setCost("Breath of Fire", 0, 2)
setCost("Chi Explosion: BM", 0, 1)
setCost("Chi Explosion: MW", 0, 1)
setCost("Chi Explosion: WW", 0, 1, "Combo Breaker: Chi Explosion")
setCost("Enveloping Mist", 0, 3)
setCost("Expel Harm", 40, -1)
setCost("Fists of Fury", 0, 3)
setCost("Guard", 0, 2)
setCost("Jab", 40, -1)
setCost("Keg Smash", 40, -2)
setCost("Purifying Brew", 0, 1, "Purifier")
setCost("Renewing Mist", 0, -1)
setCost("Rising Sun Kick", 0, 2)
setCost("Rushing Jade Wind", 40, -1)
setCost("Spinning Crane Kick", 40, -1)
setCost("Surging Mist", 0, -1)
setCost("Tiger Palm", 0, 1, "Combo Breaker: Tiger Palm")
setCost("Touch of Death", 0, 3)
setCost("Uplift", 0, 2)

local function avoidCapping(time)
   return a.Power + (a.Regen * c.GetHastedTime(time))
      < UnitPowerMax("player", SPELL_POWER_ENERGY)
end

local function poolEnergy(time, amount)
   return a.Power + (a.Regen * c.GetHastedTime(time))
      >= (amount or UnitPowerMax("player", SPELL_POWER_ENERGY))
end

------------------------------------------------------------------------ Common
local function modSpell(spell)
   local localizedName = s.SpellName(spell.ID)
   local cost = spellCosts[localizedName]
   if cost then
      spell.EvenIfNotUsable = true
      spell.NoPowerCheck = true
      spell.CheckLast = function()
         -- c.Debug("Flash", "CheckLast", s.SpellName(spell.ID),
         --         "E:", a.Power, ">=", cost.Energy, a.Power >= cost.Energy,
         --         "C:", a.Chi, ">=", a.GetChiCost(localizedName),
         --         a.Chi >= a.GetChiCost(localizedName))
         return a.Power >= cost.Energy
            and a.Chi >= a.GetChiCost(localizedName)
      end
   end
end

local function addSpell(name, tag, attributes)
   modSpell(c.AddSpell(name, tag, attributes))
end

local function addOptionalSpell(name, tag, attributes)
   modSpell(c.AddOptionalSpell(name, tag, attributes))
end

-- while levelling, just use these whatever.
addSpell("Jab")
addSpell("Tiger Palm")

addOptionalSpell("Roll", nil, {
   FlashID = { "Roll", "Chi Torpedo" },
   FlashSize = s.FlashSizePercent() / 2,
   CheckFirst = function(z)
      if IsMounted() or not s.Moving("player") then
         return false
      end

      if not c.HasTalent("Momentum") then
         return true
      end

      local duration = c.GetBuffDuration("Momentum")
      if duration > 0 then
         return duration < 1
      end

      local charges, _, start, duration = GetSpellCharges(c.GetID("Roll"))
      if start + duration - GetTime() < 9 then
         charges = charges + 1
      end
      return charges >= 2
   end
})

addOptionalSpell("Legacy of the Emperor", nil, {
   NoRangeCheck = 1,
   CheckFirst = function()
      return c.RaidBuffNeeded(c.STAT_BUFFS)
   end
})

addOptionalSpell("Touch of Death", nil, {
   Cooldown = 90,
   CheckFirst = function()
      return s.Health() < max(s.MaxHealth("player"), s.MaxHealth("target") / 10)
   end
})

addSpell("Chi Burst", "for WW", {
   NotWhileMoving = true,
   NotIfActive = true,
   Cooldown = 30,
   CheckFirst = function()
      return avoidCapping(1) and not a.Serenity
   end
})

c.AddSpell("Zen Sphere", "for WW", {
   NoRangeCheck = true,
   MyBuff = "Zen Sphere",
   BuffUnit = "player",
   Cooldown = 10,
   CheckFirst = function()
      return avoidCapping(2) and not a.Serenity
   end
})

c.AddSpell("Zen Sphere", "for BM", {
   NoRangeCheck = true,
   MyBuff = "Zen Sphere",
   BuffUnit = "player",
   Cooldown = 10,
   EarlyRefresh = 0,
   CheckFirst = function()
      return avoidCapping(1)
   end
})

c.AddSpell("Zen Sphere", "for WW AoE", {
   NoRangeCheck = true,
   MyBuff = "Zen Sphere",
   BuffUnit = "player",
   Cooldown = 10,
})

addOptionalSpell("Invoke Xuen, the White Tiger", nil, {
   NoGCD = true,
   Cooldown = 3 * 60,
})


c.RegisterForFullChannels("Spinning Crane Kick", 2.25, true)
u.RegisterEventHandler({
   ["SPELLS_CHANGED"] = function()
      local time = c.HasSpell("Empowered Spinning Crane Kick")
         and 1.125 or 2.25
      c.RegisterForFullChannels("Spinning Crane Kick", time, true)
   end
})

addSpell("Spinning Crane Kick", nil, {
   Melee = true,
   CheckFirst = function()
      return not c.HasTalent("Rushing Jade Wind")
   end
})

addSpell("Rushing Jade Wind", nil, {
   Melee = true,
   Buff = "Rushing Jade Wind",
   BuffUnit = "player",
})

c.AddInterrupt("Spear Hand Strike")

-------------------------------------------------------------------- Brewmaster
c.AddOptionalSpell("Summon Black Ox Statue", nil, {
   NoRangeCheck = true,
   CheckFirst = function()
      return c.IsMissingTotem(1) and not c.IsSolo()
   end
})

addOptionalSpell("Invoke Xuen, the White Tiger", "for BM", {
   NoGCD = true,
   Cooldown = 3 * 60,
   CheckFirst = function()
      return a.Shuffle >= 3 and not a.Serenity
   end
})

addOptionalSpell("Fortifying Brew", nil, {
   NoGCD = true,
   ShouldHold = function()
      if c.HasGlyph("Fortifying Brew") then
         return c.GetHealthPercent("player") > 90
      else
         return c.GetHealthPercent("player") > 80
      end
   end
})

addOptionalSpell("Elusive Brew", nil, {
   NoGCD = true,
   -- @todo danielp 2015-01-03: was set in the custom IsUp function, and I
   -- don't understand why.  Research needed, but for now, just emulate.
   UseBuffID = true,
   ShouldHold = function()
      if c.HasBuff("Healing Elixirs") and c.GetHealthPercent("player") > 85 then
         return true
      end

      if a.ElusiveStacks < 9 and c.GetHealthPercent("player") > 80 then
         return true
      end

      return false
   end,
})

addOptionalSpell("Guard", nil, {
   NoGCD = true,
   CheckFirst = function()
      local charges, tilNext = c.GetChargeInfo("Guard")

      -- actions.st+=/guard,if=incoming_damage_10s>=health.max*0.5
      return (charges > 0 and c.GetHealthPercent("player") < 75)
         or (charges == 1 and tilNext < 5)
         or charges == 2
   end
})

local function PurifyingBrewWillOverheal()
   local heal = 0
   local max = UnitHealthMax("player")

   if c.HasBuff("Healing Elixirs") then
      heal = heal + .15 * max
   end

   if c.WearingSet(4, "BrewmasterT16") then
      heal = heal + .15 * UnitStagger("player")
   end

   return heal > 0 and UnitHealth("player") + heal > max
end

addOptionalSpell("Purifying Brew", "no Chi Explosion, Heavy Stagger", {
   NoGCD = true,
   Cooldown = 1,
   NotIfActive = true,
   CheckFirst = function()
      return a.Stagger == "heavy" and not a.HasChiExplosion
   end
})

addOptionalSpell("Purifying Brew", "no Chi Explosion, Moderate Stagger", {
   NoGCD = true,
   Cooldown = 1,
   NotIfActive = true,
   CheckFirst = function()
      return a.Stagger == "moderate"
         and a.Shuffle >= 6
         and not a.HasChiExplosion
   end
})

addOptionalSpell("Purifying Brew", "with Serenity", {
   NoGCD = true,
   Cooldown = 1,
   NotIfActive = true,
   CheckFirst = function()
      return a.Serenity and (a.Stagger or not PurifyingBrewWillOverheal())
   end
})

addOptionalSpell("Chi Brew", "for BM", {
   CheckFirst = function(z)
      if not c.HasTalent("Chi Brew") then
         return false
      end

      -- @todo danielp 2015-01-03: should we account for "are we tanking"
      -- here? gonna trust the player to figure that one out for now.
      if a.Chi < 1 and a.Stagger == "heavy" then
         return true
      end

      if a.Chi < 2 and not a.Shuffle then
         return true
      end

      local charges, tilNext, tilMax = c.GetChargeInfo("Chi Brew")

      if a.MissingChi >= 2
         and a.ElusiveStacks <= 10
         and (charges >= 2 or (charges == 1 and tilNext < 5))
      then
         return true
      end

      return false
   end
})

addOptionalSpell("Diffuse Magic")
addOptionalSpell("Dampen Harm")

c.AddOptionalSpell("Stance of the Sturdy Ox", nil, {
   Type = "form",
})

addSpell("Blackout Kick")

addSpell("Blackout Kick", "for Shuffle", {
   Applies = { "Shuffle" },
   CheckFirst = function(z)
      return a.Shuffle < c.LastGCD
         and not c.IsAuraPendingFor("Blackout Kick")
         and a.Ox
   end
})

addSpell("Blackout Kick", "to extended Shuffle", {
   Applies = { "Shuffle" },
   CheckFirst = function(z)
      if a.Chi >= 4 or a.Serenity then
         return true
      end

      if a.Shuffle <= 3 and c.GetCooldown("Keg Smash", false, 8) >= c.LastGCD then
         return true
      end

      return false
   end
})

addSpell("Blackout Kick", "for AoE", {
   CheckFirst = function(z)
      return (a.Shuffle < 2 or a.MissingChi <= 1)
         and a.Ox
         and not c.InDamageMode()
   end
})

addSpell("Keg Smash", nil, {
   Melee = true,
   Cooldown = 8,
   Applies = { "Dizzying Haze" },
   CheckFirst = function()
      return a.MissingChi >= 1 and not a.Serenity
   end
})

addSpell("Jab", "for BM", {
   CheckFirst = function()
      -- gen unless we can wait and get better use out of expel harm/keg smash
      local need = 40
      need = need + max(0, 40 - c.GetCooldown("Keg Smash") * a.Regen)
      need = need + max(0, 40 - c.GetCooldown("Expel Harm") * a.Regen)
      if c.EstimatedHarmTargets >= 3 and c.HasTalent("Rushing Jade Wind") then
         need = need + max(0, 40 - c.GetCooldown("Rushing Jade Wind") * a.Regen)
      end

      -- since Tiger Palm hurts more, use it if we are not going to generate
      -- Chi from this Jab (eg: are capped.)
      return a.MissingChi >= 1 and a.Power >= need
   end
})

addSpell("Expel Harm", "for BM", {
   Cooldown = 15,
   CheckFirst = function()
      local kegCD = c.GetCooldown("Keg Smash", false, 8)

      return a.MissingChi >= 1
         and kegCD >= c.LastGCD
         and poolEnergy(kegCD, 80)
   end
})

c.AddSpell("Tiger Palm", "for BM", {
   Melee = true,
   CheckFirst = function()
      return a.Ox
   end
})

addSpell("Chi Burst", "for BM", {
   NotWhileMoving = true,
   NotIfActive = true,
   Cooldown = 30,
   CheckFirst = function()
      return avoidCapping(1)
   end
})

addSpell("Chi Wave", "for BM", {
   Cooldown = 15,
   CheckFirst = function()
      return avoidCapping(1)
   end
})

addSpell("Chi Explosion: BM", nil, {
   CheckFirst = function()
      return a.Chi >= (c.EstimatedHarmTargets >= 3 and 4 or 3)
   end
})

addSpell("Breath of Fire", nil, {
   Melee = true,
   MyDebuff = "Breath of Fire",
   Tick = 2,
   CheckFirst = function()
      return c.EstimatedHarmTargets >= 3
         and (a.Chi >= 3 or a.Serenity)
         and a.Shuffle >= 6
         and not a.HasChiExplosion
         and (c.HasSpell("Improved Breath of Fire")
                 or c.HasMyDebuff("Dizzying Haze", nil, nil, "Keg Smash"))
   end,
})

addSpell("Rushing Jade Wind", "for BM", {
   Melee = true,
   Buff = "Rushing Jade Wind",
   BuffUnit = "player",
   CheckFirst = function()
      return c.EstimatedHarmTargets >= 3
         and a.MissingChi >= 1
         and not a.Serenity
         and c.HasTalent("Rushing Jade Wind")
   end
})

c.AddTaunt("Provoke", nil, { NoGCD = true })

addSpell("Serenity", "for BM", {
   Cooldown = 90,
   CheckFirst = function()
      return c.GetCooldown("Keg Smash", false, 8) >= 6
   end
})

-------------------------------------------------------------------- Mistweaver
c.AddOptionalSpell("Stance of the Wise Serpent", nil, {
   Type = "form",
})

c.AddOptionalSpell("Summon Jade Serpent Statue", nil, {
   NoRangeCheck = true,
   CheckFirst = function()
      return c.IsMissingTotem(1) and not c.IsSolo()
   end
})

c.AddOptionalSpell("Mana Tea", nil, {
   Override = function(z)
      local stack = c.GetBuffStack("Mana Tea")
      if c.HasGlyph("Mana Tea") then
         z.FlashColor = "yellow"
         return stack >= 2
            and s.PowerPercent("player") < 92
            and c.GetCooldown("Mana Tea") == 0
      end

      if s.PowerPercent("player") > 86 then
         if c.IsCasting("Mana Tea") then
            z.FlashColor = "red"
            return true
         else
            z.FlashColor = "yellow"
            return false
         end
      end

      z.FlashColor = nil
      local dur = c.GetBuffDuration("Mana Tea")
      return dur > 0 and (dur < 10 or stack == 20)
   end
})

local function checkChiBrew(z, chiPad)
   local charges, tilNext, tilMax = c.GetChargeInfo("Chi Brew")
   if charges == 0 or a.MissingChi < 2 + chiPad then
      return false
   end

   c.MakeMini(z, tilMax > 0)
   return true
end

addOptionalSpell("Chi Brew", "for Mistweaver", {
   CheckFirst = function(z)
      return checkChiBrew(z, 1) and c.GetBuffStack("Mana Tea") < 16
   end
})

c.AddOptionalSpell("Surging Mist", nil, {
   Override = function()
      if a.SoothDamage > 50 then
         return true
      end

      if a.MissingChi > 0 and c.GetBuffStack("Vital Mists") == 5 then
         for member in c.GetGroupMembers() do
            if c.GetHealthPercent(member) < 80
               and (UnitInRange(member) or UnitIsUnit(member, "player"))
               and not UnitIsDeadOrGhost(member) then

               return true
            end
         end
      end
   end
})

c.AddOptionalSpell("Enveloping Mist", nil, {
   Override = function(z)
      return a.Chi >= 3
         and a.SoothDamage > 30
         and not s.MyBuff(
            c.GetID("Enveloping Mist"), a.SoothTarget, c.GetBusyTime())
   end
})

c.AddOptionalSpell("Uplift", nil, {
   Override = function()
      if a.Chi < 2 and not c.HasGlyph("Uplift") then
         return false
      end

      local mistId = c.GetID("Renewing Mist")
      local busy = c.GetBusyTime()
      local damage = 0
      for member in c.GetGroupMembers() do
         if s.MyBuff(mistId, member, busy) then
            damage = damage + min(15, s.HealthDamagePercent(member))
         end
      end
      return damage > 60
   end
})

c.AddOptionalSpell("Touch of Death", "for Mistweaver", {
   FlashSize = s.FlashSizePercent() / 2,
   Melee = true,
   Override = function()
      return a.Chi >= 3
         and s.Health() < s.MaxHealth("player")
         and c.GetCooldown("Touch of Death") == 0
   end
})

c.AddSpell("Blackout Kick", "for Serpent's Zeal", {
   FlashSize = s.FlashSizePercent() / 2,
   Melee = true,
   Buff = "Serpent's Zeal",
   BuffUnit = "player",
   EarlyRefresh = 1,
   Override = function()
      return (a.MissingChi == 0 or (a.Chi >= 2 and a.MuscleMemory))
         and not c.IsMissingTotem(1)
   end
})

c.AddSpell("Chi Wave", "for Mistweaver", {
   FlashSize = s.FlashSizePercent() / 2,
   Cooldown = 15,
})

c.AddSpell("Tiger Palm", "for Mistweaver", {
   FlashSize = s.FlashSizePercent() / 2,
   Melee = true,
   Override = function()
      return (a.MissingChi == 0 and not c.AoE)
         or (a.Chi >= 1
            and a.MuscleMemory
            and (c.HasBuff("Serpent's Zeal", false, false, "Blackout Kick")
               or c.IsMissingTotem(1)))
   end
})

c.AddSpell("Expel Harm", "for Mistweaver", {
   FlashSize = s.FlashSizePercent() / 2,
   Override = function()
      return c.GetHealthPercent("player") < 80
         and s.MeleeDistance()
         and c.GetCooldown("Expel Harm") == 0
   end
})

c.AddSpell("Jab", "for Mistweaver", {
   FlashSize = s.FlashSizePercent() / 2,
})

c.AddSpell("Crackling Jade Lightning", nil, {
   FlashSize = s.FlashSizePercent() / 2,
})

c.AddSpell("Spinning Crane Kick", "for Mistweaver", {
   Melee = true,
   EvenIfNotUsable = true,
   CheckFirst = function()
      return c.AoE
   end,
})

c.AddSpell("Rushing Jade Wind", "for Mistweaver", {
   Melee = true,
   Buff = "Rushing Jade Wind",
   BuffUnit = "player",
   EvenIfNotUsable = true,
   CheckFirst = function()
      return c.AoE
   end,
})

-------------------------------------------------------------------- Windwalker
c.AddOptionalSpell("Stance of the Fierce Tiger", nil, {
   Type = "form",
})

c.AddOptionalSpell("Legacy of the White Tiger", nil, {
   NoRangeCheck = 1,
   CheckFirst = function()
      return c.RaidBuffNeeded(c.CRIT_BUFFS)
   end
})

c.AddSpell("Storm, Earth, and Fire", nil, {
   CheckFirst = function(z)
      if a.SefTargets[UnitGUID(s.UnitSelection())] then
         z.FlashColor = "red"
         return true
      elseif c.AoE and c.GetBuffStack("Storm, Earth, and Fire") < 2 then
         z.FlashColor = "yellow"
         return true
      end
   end
})

addOptionalSpell("Energizing Brew", nil, {
   Cooldown = 60,
   CheckFirst = function()
      return c.GetCooldown("Fists of Fury") > 6
         and (UnitPowerMax("player") - a.Power) / a.Regen < 5
         and ((c.GetCooldown("Serenity") > 4 and not a.Serenity)
               or not c.HasTalent("Serenity"))
   end
})

addOptionalSpell("Tigereye Brew", nil, {
   NoGCD = true,
   CheckFirst = function(z)
      if c.HasBuff("Tigereye Brew", false, true) then
         return false
      end

      local stacks = c.GetBuffStack("Tigereye Brew Stacker", false, true)

      if stacks >= 20 then
         return true
      end

      if stacks >= 16
         and a.Chi >= 2
         and c.HasMyDebuff("Rising Sun Kick")
         and c.HasBuff("Tiger Power")
      then
         return true
      end

      if stacks >= 10 then
         if c.IsSolo() and not s.Boss() then
            return true
         end

         if a.Serenity then
            return true
         end

         if (c.GetCooldown("Fists of Fury", false, 25) <= 0
             or c.GetCooldown("Hurricane Strike", false, 45) <= 0)
            and a.Chi >= 3
            and c.HasMyDebuff("Rising Sun Kick")
            and c.HasBuff("Tiger Power")
         then
            return true
         end
      end

      return false
   end
})

addOptionalSpell("Chi Brew", "for WW", {
   CheckFirst = function(z)
      local charges, tilNext, tilMax = c.GetChargeInfo("Chi Brew")
      if charges <= 0 then
         return false
      end

      return a.MissingChi >= 2
         and c.GetBuffStack("Tigereye Brew Stacker", false, true) <= 16
         and (charges == 2 or (charges == 1 and tilNext <= 10))
   end
})

addSpell("Rising Sun Kick")

addSpell("Rising Sun Kick", "without Chi Explosion", {
   CheckFirst = function()
      return not a.HasChiExplosion
   end
})

addSpell("Rising Sun Kick", "without Rushing Jade Wind", {
   CheckFirst = function()
      return not c.HasTalent("Rushing Jade Wind")
         and a.MissingChi <= 0
   end
})

addSpell("Rising Sun Kick", "for Debuff", {
   MyDebuff = "Rising Sun Kick",
   EarlyRefresh = 3,
})

addOptionalSpell("Hurricane Strike", nil, {
   Cooldown = 45,
   CheckFirst = function()
      local castTime = c.GetHastedTime(2)

      return not c.HasBuff("Energizing Brew")
         and avoidCapping(2)
         and c.GetBuffDuration("Tiger Power") > castTime
         and c.GetMyDebuffDuration("Rising Sun Kick") > castTime
   end
})

addOptionalSpell("Hurricane Strike", "for AoE", {
   Cooldown = 45,
   CheckFirst = function()
      local castTime = c.GetHastedTime(2)

      return c.HasTalent("Rushing Jade Wind")
         and avoidCapping(2)
         and not c.HasBuff("Energizing Brew")
         and c.GetBuffDuration("Tiger Power") > castTime
         and c.GetMyDebuffDuration("Rising Sun Kick") > castTime
   end
})

addSpell("Tiger Palm", "if expiring", {
   CheckFirst = function()
      return c.GetBuffDuration("Tiger Power") <= 3
   end
})

addSpell("Tiger Palm", "for Tiger Power", {
   MyBuff = "Tiger Power",
   NotIfActive = true,
   CheckFirst = function()
      return (c.HasMyDebuff("Rising Sun Kick") or not c.HasSpell("Rising Sun Kick"))
         and avoidCapping(1)
   end
})

addSpell("Tiger Palm", "under Combo Breaker", {
   NotIfActive = true,
   CheckFirst = function()
      return c.HasBuff("Combo Breaker: Tiger Palm")
         and c.GetBuffDuration("Combo Breaker: Tiger Palm") <= 2
   end
})

addSpell("Tiger Palm", "under Combo Breaker with RJW", {
   NotIfActive = true,
   CheckFirst = function()
      return c.HasTalent("Rushing Jade Wind")
         and c.HasBuff("Combo Breaker: Tiger Palm")
         and c.GetBuffDuration("Combo Breaker: Tiger Palm") <= 2
   end
})

c.RegisterForFullChannels("Fists of Fury", 4)

addOptionalSpell("Fists of Fury", nil, {
   Melee = true,
   NoRangeCheck = true,
   Cooldown = 25,
   CheckFirst = function(z)
      z.NotWhileMoving = not c.HasGlyph("Floating Butterfly")
--      c.MakeMini(z, c.GetCooldown("Energizing Brew") == 0)

      local castTime = c.GetHastedTime(4)
      return not c.HasBuff("Energizing Brew")
         and avoidCapping(3)    -- allow a little over-capping on energy
         and c.GetBuffDuration("Tiger Power") > castTime
         and c.GetMyDebuffDuration("Rising Sun Kick") > castTime
   end
})

addOptionalSpell("Fists of Fury", "for AoE", {
   Melee = true,
   NoRangeCheck = true,
   Cooldown = 25,
   CheckFirst = function(z)
      z.NotWhileMoving = not c.HasGlyph("Floating Butterfly")

      local castTime = c.GetHastedTime(4)
      return c.HasTalent("Rushing Jade Wind")
         and avoidCapping(4)
         and c.GetBuffDuration("Tiger Power") > castTime
         and c.GetMyDebuffDuration("Rising Sun Kick") > castTime
         and not a.Serenity
   end
})

c.AddSpell("Chi Wave", "for WW", {
   Cooldown = 15,
   CheckFirst = function()
      return avoidCapping(2) and not a.Serenity
   end
})

addSpell("Blackout Kick", "under Combo Breaker", {
   NotIfActive = true,
   CheckFirst = function()
      return c.HasBuff("Combo Breaker: Blackout Kick")
         and not a.HasChiExplosion
   end
})

addSpell("Blackout Kick", "under Combo Breaker with RJW", {
   NotIfActive = true,
   CheckFirst = function()
      return c.HasTalent("Rushing Jade Wind")
         and c.HasBuff("Combo Breaker: Blackout Kick")
         and not a.HasChiExplosion
   end
})

addSpell("Blackout Kick", "under Serenity", {
   NotIfActive = true,
   CheckFirst = function()
      return a.Serenity
         and not a.HasChiExplosion
   end
})

addSpell("Blackout Kick", "under Serenity with RJW", {
   NotIfActive = true,
   CheckFirst = function()
      return c.HasTalent("Rushing Jade Wind")
         and a.Serenity
         and not a.HasChiExplosion
   end
})

addSpell("Blackout Kick", "near cap", {
   CheckFirst = function()
      return a.MissingChi < 2
         and not a.HasChiExplosion
   end
})

addSpell("Blackout Kick", "near cap with RJW", {
   CheckFirst = function()
      return c.HasTalent("Rushing Jade Wind")
         and a.MissingChi < 2
         and not a.HasChiExplosion
   end
})

addOptionalSpell("Expel Harm", "for WW", {
   Cooldown = 15,
   CheckFirst = function()
      return c.GetHealthPercent("player") < 80
         and a.Chi + 2 <= UnitPowerMax("player", SPELL_POWER_CHI)
   end
})

addSpell("Jab", "for WW", {
   CheckFirst = function()
      return a.MissingChi >= 2
   end
})

addSpell("Jab", "for WW with RJW", {
   CheckFirst = function()
      return a.MissingChi >= 2 and c.HasTalent("Rushing Jade Wind")
   end
})

addSpell("Serenity", "for WW", {
   Cooldown = 90,
   CheckFirst = function()
      return a.Chi >= 2
         and c.HasBuff("Tiger Power")
         and c.HasMyDebuff("Rising Sun Kick")
         and c.GetBuffStack("Tigereye Brew Stacker", false, true) >= 10
   end
})

addSpell("Chi Explosion: WW", "under Combo Breaker", {
   CheckFirst = function()
      return a.Chi >= 3
         and c.HasBuff("Combo Breaker: Chi Explosion")
   end
})

addSpell("Chi Explosion: WW", "at 3", {
   CheckFirst = function()
      return a.Chi >= 3
   end
})

addSpell("Chi Explosion: WW", "at 4", {
   CheckFirst = function()
      return a.Chi >= 4
   end
})

addOptionalSpell("Fortifying Brew", "for WW", {
   CheckFirst = function()
      return c.GetHealthPercent("player") < (c.IsSolo() and 80 or 50)
   end
})

addOptionalSpell("Surging Mist", "for WW", {
   CheckFirst = function()
      return a.Power >= 30
         and c.GetHealthPercent("player") < (c.IsSolo() and 80 or 50)
   end
})
