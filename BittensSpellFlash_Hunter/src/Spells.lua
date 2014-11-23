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
local math = math

c.AssociateTravelTimes(
   .5,
   "Serpent Sting",
   "Explosive Shot",
   "Black Arrow",
   "Cobra Shot",
   "Arcane Shot",
   "Kill Shot",
   "Steady Shot",
   "Chimera Shot",
   "Aimed Shot",
   "Tranquilizing Shot")

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

local function generatorWillCap(padding)
   if c.GetCooldown("Fervor") < 3 then
      padding = padding + 50
   end
   local castTime = c.GetCastTime("Cobra Shot")
   return a.EmptyFocus
         - a.FocusAdded(c.GetBusyTime() + castTime)
         - castTime * a.Regen
      < padding
end

------------------------------------------------------------------------ Common
addOptionalSpell("Serpent Sting", nil, {
   Applies = { "Serpent Sting Debuff", "Improved Serpent Sting" },
   CheckFirst = function(z)
      return c.ShouldCastToRefresh(
         "Serpent Sting", "Serpent Sting", 0, true,
         "Cobra Shot", "Chimera Shot")
   end
})

c.AddOptionalSpell("Aspect of the Hawk", nil, {
   Type = "form",
   NotWhileMoving = true,
})

c.AddOptionalSpell("Aspect of the Iron Hawk", nil, {
   Type = "form",
   NotWhileMoving = true,
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

c.AddOptionalSpell("Fervor", nil, {
   CheckFirst = function()
      return not c.HasBuff("Fervor")
         and a.EmptyFocus > 55
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

addSpell("Powershot", nil, {
   Cooldown = 45,
   CechkFirst = function(z)
      c.MakeOptional(z, s.Moving("player"))
      return s.EmptyFocus > a.Regen * c.GetCastTime("Powershot")
   end,
})

addSpell("Barrage", nil, {
   Cooldown = 30,
})
c.RegisterForFullChannels("Barrage", 3)

c.AddSpell("Dire Beast", nil, {
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
      return stacks > 0
   end
})

c.AddOptionalSpell("Lynx Rush", nil, {
   CheckFirst = function()
      return c.GetMyDebuffDuration("Lynx Rush") < 3
   end,
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

c.AddSpell("Cobra Shot", "for Serpent Sting", {
   CheckFirst = function()
      return c.ShouldCastToRefresh(
         "Cobra Shot", "Serpent Sting", 4, false, "Serpent Sting")
   end,
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

c.AddOptionalSpell("Bullheaded", nil, {
   Type = "pet",
   CheckFirst = function()
      return c.IsTanking("pet")
   end,
})

c.AddOptionalSpell("Cower", nil, {
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

c.AddOptionalSpell("Rabid", nil, {
   Type = "pet",
})

c.AddDispel("Tranquilizing Shot", nil, "")

c.AddInterrupt("Counter Shot", nil, {
   NoGCD = true,
})

----------------------------------------------------------------- Beast Mastery
c.AddOptionalSpell("Focus Fire", nil, {
   CheckFirst = function()
      return s.BuffStack(c.GetID("Frenzy"), "pet") == 5
         and not c.HasBuff("Focus Fire")
   end
})

addSpell("Kill Command", nil, {
   Cooldown = 6,
})

addSpell("Arcane Shot", "for BM", {
   CheckFirst = function()
      return generatorWillCap(25) or c.HasBuff("The Beast Within")
   end
})

c.AddOptionalSpell("Bestial Wrath", nil, {
   CheckFirst = function()
      return a.Focus > 60 and not c.HasBuff("The Beast Within")
   end
})

c.AddOptionalSpell("Rapid Fire", "for BM", {
   CheckFirst = function()
      return not c.HasBuff("Rapid Fire")
   end
})

local function doMiniAoE()
   return GetTime() - a.LastMultiShot < 10
end

c.AddOptionalSpell("Explosive Trap", "for Mini-AoE", {
   FlashSize = s.FlashSizePercent() / 2,
   FlashID = { "Explosive Trap", "Explosive Trap Launched" },
   NoRangeCheck = true,
   CheckFirst = function()
      return doMiniAoE()
   end,
})

addOptionalSpell("Multi-Shot", "for Mini-AoE", {
   FlashSize = s.FlashSizePercent() / 2,
   CheckFirst = function()
      return doMiniAoE()
         and GetTime() - a.LastMultiShot
            + c.GetBusyTime() + c.GetCastTime("Multi-Shot") > 3.5
   end,
})

------------------------------------------------------------------ Marksmanship
local function underCarefulAim()
   return s.HealthPercent() > 90 and not c.GetOption("NoCarefulAim")
end

local function nextMMCooldown()
   return math.min(
      c.GetCooldown("Chimera Shot"),
      s.HealthPercent() < 20 and c.GetCooldown("Kill Shot") or 9001,
      c.GetCooldown("Glaive Toss"),
      c.GetCooldown("Dire Beast"),
      c.GetCooldown("A Murder of Crows"),
      c.GetCooldown("Stampede"),
      c.GetCooldown("Lynx Rush"),
      c.GetCooldown("Fervor"))
end

c.AddSpell("Steady Shot", "2", {
   CheckFirst = function()
      return a.NextSSIsImproved and c.GetBuffDuration("Steady Focus") < 5
   end
})

c.AddSpell("Steady Shot", "Opportunistic", {
   CheckFirst = function()
      local time = c.GetCastTime("Steady Shot")
      if c.GetBuffDuration("Steady Focus") < time + 1
         and not c.IsCasting("Steady Shot") then

         return true
      end

      local gain = 17 + time * a.Regen
      if not a.NextSSIsImproved then
         time = time * 2
         gain = gain * 2
      end
      time = time - .5 -- we're ok with a little waste
      return a.Focus + gain < 100 and nextMMCooldown() > time
   end,
})

addSpell("Chimera Shot", nil, {
   Cooldown = 9,
})

addSpell("Chimera Shot", "to save Serpent Sting", {
   CheckFirst = function()
      return c.ShouldCastToRefresh(
         "Chimera Shot", "Serpent Sting", 1, false, "Serpent Sting")
   end,
})

addOptionalSpell("Stampede", "for Marksmanship", {
   FlashSize = s.FlashSizePercent() / 2,
   CheckFirst = function()
      return (c.HasBuff("Rapid Fire") or c.HasBuff(c.BLOODLUST_BUFFS))
         and c.HasBuff("Steady Focus")
   end,
})

addSpell("Aimed Shot", nil, {
   FlashID = { "Aimed Shot", "Aimed Shot!" },
   Override = function(z)
      local instant = c.HasBuff("Fire!")
      c.MakeOptional(
         z,
         not instant and s.Moving("player") and not c.HasGlyph("Aimed Shot"))
      return (instant and not c.IsQueued("Aimed Shot"))
         or (a.Focus >= 50
            and (underCarefulAim() or c.GetCastTime("Aimed Shot") < 1.4))
   end,
})

addSpell("Arcane Shot", "for Marksmanship", {
   CheckFirst = function()
      return (not underCarefulAim()
            or (s.Moving("player") and not c.HasGlyph("Aimed Shot")))
         and (a.Focus >= 60
            or (a.Focus >= 43 and a.CSCool >= c.GetCastTime("Steady Shot")))
   end,
})

---------------------------------------------------------------------- Survival
addSpell("Explosive Shot", nil, {
   CheckFirst = function()
      return not c.IsCasting("Explosive Shot") or c.HasBuff("Lock and Load")
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
   CheckFirst = function()
      return generatorWillCap(a.Regen * 2) -- room for 2 surprise explosive shots
   end
})
