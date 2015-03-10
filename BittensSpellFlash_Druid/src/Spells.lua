local _, a = ...
--local L = a.Localize
local s = SpellFlashAddon
local x = s.UpdatedVariables
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local GetSpellBonusHealing = GetSpellBonusHealing
local IsSpellInRange = IsSpellInRange
local UnitAttackPower = UnitAttackPower
local UnitHealthMax = UnitHealthMax
local min = math.min

local function substantialFight()
   return a.Substantial
end

local function forceOfNatureCheck(z)
   local _, _, untilMax = c.GetChargeInfo(z.ID, true)
   return untilMax < 1
end

local function setFaerieID(z)
   z.Name = nil
   if c.HasTalent("Faerie Swarm") then
      z.ID = c.GetID("Faerie Swarm")
   else
      z.ID = c.GetID("Faerie Fire")
   end
end

local function canTakeHealingTouch()
   local heal = 3.6 * GetSpellBonusHealing() * c.GetVersatility() * c.GetCritChance()

   if c.HasTalent("Dream of Cenarius") then
      heal = 1.2 * heal
   end

   return c.GetHealth("player") + heal <= UnitHealthMax("player")
end

------------------------------------------------------------------------ Common
c.AddOptionalSpell("Mark of the Wild", nil, {
   Override = function()
      return c.RaidBuffNeeded(c.STAT_BUFFS)
   end
})

c.AddSpell("Faerie Fire", nil, {
   RunFirst = setFaerieID,
   Cooldown = 6,
})

c.AddOptionalSpell("Healing Touch", nil, {
   NoRangeCheck = true,
   CheckFirst = canTakeHealingTouch,
})

c.AddOptionalSpell("Nature's Vigil", nil, {
   NoRangeCheck = true,
   NoGCD = true,
})

c.AddOptionalSpell("Renewal", nil, {
   NoGCD = true,
   Cooldown = 120,
   CheckFirst = function()
      return c.GetHealthPercent("player") < (c.IsSolo() and 70 or 50)
   end,
})

c.AddDispel("Soothe")

c.AddInterrupt("Skull Bash", nil, {
   NoGCD = true,
})

----------------------------------------------------------------------- Balance
c.AddOptionalSpell("Moonkin Form", nil, {
   Type = "form",
   CheckFirst = function()
      return x.EnemyDetected
   end,
})

c.AddOptionalSpell("Force of Nature: Balance", nil, {
   NoGCD = true,
   CheckFirst = forceOfNatureCheck,
})

c.AddOptionalSpell("Incarnation: Chosen of Elune", nil, {
   CheckFirst = function()
      return a.eclipseEnergy < 0
   end
})

c.AddOptionalSpell("Celestial Alignment", nil, {
   CheckFirst = function()
      return a.eclipseEnergy < -40
   end
})

c.AddOptionalSpell("Starfall", nil, {
   Override = function(z)
      if c.GetCooldown("Incarnation: Chosen of Elune") > 15 then
         z.FlashSize = nil
      elseif not a.GoingUp
         and (a.Energy <= -70
            or (c.GetCooldown("Starsurge") == 0 and a.Energy <= -60)) then

         z.FlashSize = s.FlashSizePercent() / 2
      else
         return false
      end
      return not c.HasBuff("Starfall")
         and (c.GetCooldown("Starfall") == 0
            or (a.EclipsePending and a.Lunar))
   end
})

c.AddSpell("Starsurge", nil, {
   NotIfActive = true,
   CheckFirst = function()
      if not c.HasBuff("Lunar Empowerment") and a.eclipseEnergy < -20 then
         return true
      end

      if not c.HasBuff("Solar Empowerment") and a.eclipseEnergy > 40 then
         return true
      end

      local charges, nextCharge = c.GetChargeInfo("Starsurge")
      return charges >= 3
         or (charges == 2 and nextCharge < 6)
   end
})

c.AddSpell("Moonfire", nil, {
   CheckFirst = function()
      if a.eclipseEnergy > 0 then
         return false
      end

      local remains = c.GetMyDebuffDuration("Moonfire")
      if remains < 4 then
         return true
      end

      if remains >= a.nextChange + 20 then
         return false
      end

      if c.HasBuff("Lunar Peak") and not c.HasTalent("Balance of Power") then
         return true
      end

      if c.HasBuff("Celestial Alignment") and c.GetBuffDuration("Celestial Alignment") <= 2 then
         return true
      end

      return false
   end
})

c.AddSpell("Sunfire", nil, {
   -- yes, this is as horrible as it sounds, but this is literally moonfire as
   -- far as all the API is concerned!
   ID = "Moonfire",
   CheckFirst = function()
      if a.eclipseEnergy < 1 then
         return false
      end

      if c.GetMyDebuffDuration("Sunfire") < 7 then
         return true
      end

      if c.HasBuff("Solar Peak") and not c.HasTalent("Balance of Power") then
         return true
      end

      return false
   end
})

c.AddSpell("Stellar Flare", nil, {
   CheckFirst = function()
      return c.GetMyDebuffDuration("Stellar Flare") < 7
   end
})

c.AddSpell("Wrath", nil, {
   CheckFirst = function()
      local ct = c.GetCastTime("Wrath")
      return (a.eclipseEnergy > 0 and a.nextChange > ct)
         or (a.eclipseEnergy <= 0 and a.nextChange <= ct)
   end
})

c.AddSpell("Starfire", nil, {
   CheckFirst = function()
      local ct = c.GetCastTime("Starfire")
      return (a.eclipseEnergy < 0 and a.nextChange > ct)
         or (a.eclipseEnergy >= 0 and a.nextChange <= ct)
   end
})

c.AddInterrupt("Solar Beam")

------------------------------------------------------------------------- Feral
c.AddSpell("Survival Instincts", "under 30", {
   NoGCD = true,
   FlashColor = "red",
   CheckFirst = function()
      return c.GetHealthPercent("player") < 30
   end
})

c.AddOptionalSpell("Maul", "for Feral", {
   Melee = true,
   NoGCD = true,
   Override = function(z)
      c.MakePredictor(z, c.GetCooldown("Maul", true) > 0)
      return true
   end,
})

c.AddOptionalSpell("Heart of the Wild: Feral", nil, {
   Melee = true,
   FlashSize = s.FlashSizePercent() / 2,
})

c.AddSpell("Thrash (Bear Form)", "for Feral", {
   FlashID = { "Thrash", "Thrash (Bear Form)", "Thrash (Cat Form)" },
   Melee = true,
   Cooldown = 6,
   CheckFirst = function()
      return (c.GetMyDebuffDuration("Thrash (Bear Form)", false, true, true)
               < 2
            and a.Substantial)
         or c.AoE
   end,
})

c.AddSpell("Thrash (Bear Form)", "for Feral AoE", {
   FlashID = { "Thrash", "Thrash (Bear Form)", "Thrash (Cat Form)" },
   Melee = true,
   Cooldown = 6,
   CheckFirst = substantialFight,
})

c.AddSpell("Mangle", "for Feral", {
   CheckFirst = function()
      return a.TimeToCap > (a.Clearcasting and 4 or 3)
   end
})

c.AddSpell("Cat Form", nil, {
   Type = "form",
})

c.AddOptionalSpell("Tiger's Fury", nil, {
   NoGCD = true,
   Cooldown = 30,
   CheckFirst = function()
      return a.MissingEnergy >= (c.HasBuff("Omen of Clarity: Cat") and 80 or 60)
   end
})

c.AddOptionalSpell("Berserk", "for Feral", {
   NoGCD = true,
   Cooldown = 180,
   CheckFirst = function()
      return c.HasBuff("Tiger's Fury")
   end
})

c.AddOptionalSpell("Incarnation: King of the Jungle", nil, {
   MyBuff = "Incarnation: King of the Jungle",
   Cooldown = 3 * 60,
   CheckFirst = function()
      return c.GetCooldown("Berserk") < 10
         and a.MissingEnergy >= a.Regen -- time to max energy > 1
   end
})

c.AddOptionalSpell("Incarnation: King of the Jungle", "pre-pull", {
   MyBuff = "Incarnation: King of the Jungle",
   Cooldown = 3 * 60,
   CheckFirst = function()
      return not c.HasBuff("Prowl")
   end
})

c.AddSpell("Healing Touch", "for Dream", {
   Override = function()
      return a.DreamStacks <= 0
         and a.Swiftness > 0
         and a.Energy + a.Regen < 100
         and c.HasTalent("Dream of Cenarius")
   end
})

c.AddSpell("Healing Touch", "for Bloodtalons", {
   CheckFirst = function()
      if not c.HasTalent("Bloodtalons") then return false end

      local ps = c.GetBuffDuration("Predatory Swiftness")
      return ps > 0 and (a.ComboPoints >= 4 or ps <= c.LastGCD)
   end
})

c.AddSpell("Healing Touch", "for Bloodtalons pre-pull", {
   CheckFirst = function()
      return c.HasTalent("Bloodtalons")
         and c.GetBuffDuration("Bloodtalons") <= 9
   end
})

c.AddSpell("Healing Touch", "for Vigil", {
   Override = function()
      return a.Swiftness > 0
         and a.Energy < 35
         and a.Vigil > 0
   end
})

c.AddOptionalSpell("Healing Touch", "for Feral Heal", {
   Override = function()
      return a.Swiftness > 0
         and a.TimeToCap > (a.Clearcasting and 2 or 1)
         and c.GetHealthPercent("player") < 85
         and not c.HasTalent("Dream of Cenarius")
   end
})

c.AddSpell("Savage Roar", nil, {
   Energy = 25,
   ComboPoints = 5,
   NoRangeCheck = true,
   CheckFirst = function()
      return a.SavageRoar < 12
   end
})

c.AddSpell("Savage Roar", "to refresh", {
   Energy = 25,
   ComboPoints = 1,
   NoRangeCheck = true,
   CheckFirst = function()
      return a.SavageRoar < 3
   end
})

c.AssociateTravelTimes(0, "Ferocious Bite")
c.AddSpell("Ferocious Bite", "to extend Rip", {
   Energy = 25,
   ComboPoints = 1,
   CheckFirst = function()
      return c.InExecute and c.ShouldCastToRefresh("Ferocious Bite", "Rip", 3, false)
   end
})

c.AddSpell("Ferocious Bite", "at 5", {
   Energy = 25,
   ComboPoints = 5,
   RunFirst = function(z)
      c.MakePredictor(z, a.Energy < 50)
   end
})

c.AddSpell("Rip", nil, {
   Energy = 30,
   ComboPoints = 5,
   CheckFirst = function()
      -- @todo danielp 2015-01-24: handle this on both:
      -- target.time_to_die-remains>18
      return a.Rip < 3 or a.ripWouldBeStronger(a.ComboPoints)
   end
})

c.MakePredictor(c.AddSpell("Rip", "Delay", {
   Melee = true,
   Override = function()
      return not a.InExecute
         and a.CP == 5
         and a.TimeToCap > a.Rip + 1
         and a.Substantial
   end
}))

c.AddSpell("Rake", nil, {
   Energy = 35,
   CheckFirst = function()
      if a.ComboPoints >= 5 then
         return false
      end

      if c.HasTalent("Bloodtalons") then
         return a.Rake <= 4.5
            and (
                  not c.HasBuff("Predatory Swiftness")
                  or c.HasBuff("Bloodtalons")
                  or a.rakeWouldBeStronger()
            )
            -- and ((target.time_to_die-remains>3&active_enemies<3)|target.time_to_die-remains>6)
      end

      return a.Rake <= 3 or (a.Rake <= 4.5 and a.rakeWouldBeStronger())
   end
})

c.AddSpell("Rake", "Late", {
   Energy = 35,
   CheckFirst = function()
      return a.ComboPoints < 5
         and a.rakeWouldBeStronger()
         and c.EstimatedHarmTargets <= 1
   end
})

c.AddSpell("Rake", "with stealth", {
   Energy = 35,
   CheckFirst = function()
      -- prowl and incarnation both enhance rake
      return a.rakeWouldBeStronger()
         and (c.HasBuff("Prowl")
                 or c.HasBuff("Incarnation: King of the Jungle")
                 or c.HasBuff("Shadowmeld"))
   end
})

c.AddSpell("Thrash (Cat Form)", nil, {
   FlashID = { "Thrash", "Thrash (Bear Form)", "Thrash (Cat Form)" },
   Energy = 50,
   CheckFirst = function()
      return c.HasBuff("Omen of Clarity: Cat")
         and c.GetMyDebuffDuration("Thrash (Cat Form)") < 4.5
         and (c.EstimatedHarmTargets > 1
                 or (a.ComboPoints >= 5 and not c.HasTalent("Bloodtalons")))
   end
})

c.AddSpell("Thrash (Cat Form)", "AoE delay", {
   FlashID = { "Thrash", "Thrash (Bear Form)", "Thrash (Cat Form)" },
   Energy = 50,
   MaxWait = 1,
   CheckFirst = function()
      return c.GetMyDebuffDuration("Thrash (Cat Form)") < 4.5
         and c.EstimatedHarmTargets > 1
   end
})

c.AddSpell("Thrash (Cat Form)", "at 5", {
   FlashID = { "Thrash", "Thrash (Bear Form)", "Thrash (Cat Form)" },
   ComboPoints = 5,
   CheckFirst = function()
      return c.HasTalent("Bloodtalons")
         and c.GetMyDebuffDuration("Thrash (Cat Form)") < 4.5
         and c.HasBuff("Omen of Clarity: Cat")
   end
})


c.AddSpell("Shred", nil, {
   Energy = 40,
})

c.AddSpell("Swipe", nil, {
   Energy = 45,
   CheckFirst = function()
      return c.EstimatedHarmTargets >= 3
   end
})

c.AddSpell("Mangle", nil, {
   Cooldown = 6,
})

c.AddOptionalSpell("Prowl", nil, {
   MyBuff = "Prowl",
   Cooldown = 10,
   CheckFirst = function()
      return not c.HasBuff("Incarnation: King of the Jungle")
         and not c.HasBuff("Prowl")
   end
})

c.AddSpell("Force of Nature: Feral", nil, {
   NoGCD = true,
   CheckFirst = function(z)
      local charges, _, tilCap = c.GetChargeInfo("Force of Nature: Feral")

      -- avoid capping, and burn if we have a trinket proc of some sort
      --
      -- @todo danielp 2015-01-24: we have no way of detecting that right now,
      -- so lets just leave it up to the user -- optional if not capping.
      local capping = (charges >= 3 or tilCap <= 3 * c.LastGCD)
      c.MakeMini(z, not capping)
      return true
   end
})

c.AddOptionalSpell("Wild Charge: Cat", nil, {
   FlashID = { "Wild Charge", "Wild Charge: Cat" },
   Cooldown = 15,
   CheckFirst = function()
      -- work around a SpellFlash core / Blizzard bug -- spellflash uses the
      -- full and sub names for IsSpellInRange, but Blizzard demands only the
      -- base name of the spell.  "Wild Charge(Talent)" == fail, basically.
      return IsSpellInRange(s.SpellName(c.GetID("Wild Charge: Cat"), true), "target") == 1
   end
})

c.AddOptionalSpell("Shadowmeld", "for Feral", {
   Cooldown = 120,
   CheckFirst = function()
      return a.Rake < 4.5
         and a.Energy >= 35
         and a.rakeWouldBeStronger(2)
         and (c.HasBuff("Bloodtalons") or not c.HasTalent("Bloodtalons"))
         and c.GetCooldown("Incarnation: King of the Jungle") > 15
         and not c.HasBuff("Incarnation: King of the Jungle")
   end
})

c.AddSpell("Moonfire", "for Feral", {
   Energy = 30,
   CheckFirst = function()
      return c.HasTalent("Lunar Inspiration")
         and a.ComboPoints < 5
         and c.GetMyDebuffDuration("Moonfire") < 4.2
         and c.EstimatedHarmTargets < 6
         -- and target.time_to_die-remains>tick_time*5
   end
})



---------------------------------------------------------------------- Guardian
c.AddOptionalSpell("Bear Form", nil, {
   Type = "form",
   CheckFirst = function()
      return x.EnemyDetected
   end
})

c.AddSpell("Healing Touch", "Mitigation Delay", {
   NoRangeCheck = true,
   CheckFirst = function()
      return c.HasBuff("Dream of Cenarius - Guardian")
   end,
   ShouldHold = function()
      return true
   end,
})

c.AddOptionalSpell("Healing Touch", "for Guardian", {
   NoRangeCheck = true,
   CheckFirst = function()
      return c.HasBuff("Dream of Cenarius - Guardian")
         and canTakeHealingTouch()
   end,
})

c.AddOptionalSpell("Tooth and Claw", nil, {
   NoGCD = true,
   IsUp = function()
      return c.HasMyDebuff("Tooth and Claw", true)
   end,
})

c.AddOptionalSpell("Cenarion Ward", "for Guardian", {
   NoRangeCheck = true,
   Cooldown = 30,
})

c.AddOptionalSpell("Barkskin", nil, {
   NoGCD = true,
   Cooldown = 60,
   ShouldHold = function()
      return not c.HasBuff("Bristling Fur")
   end,
})

c.AddOptionalSpell("Bristling Fur", nil, {
   NoGCD = true,
   Cooldown = 60,
   MyBuff = "Bristling Fur",
   ShouldHold = function()
      return not c.HasBuff("Barkskin")
         and not c.HasBuff("Savage Defense")
   end,
})

c.AddOptionalSpell("Renewal", "for Guardian", {
   NoGCD = true,
   ShouldHold = function()
      return c.GetHealthPercent("player") > 70
   end,
})

c.AddOptionalSpell("Survival Instincts", "Unglyphed", {
   NoGCD = true,
   Enabled = function()
      return not c.HasGlyph("Survival Instincts")
   end,
   CheckFirst = function()
      return a.Rage > 90 or not c.HasBuff("Frenzied Regeneration", true)
   end,
})

c.AddOptionalSpell("Survival Instincts", "Glyphed", {
   NoGCD = true,
   Enabled = function()
      return c.HasGlyph("Survival Instincts")
   end,
   CheckFirst = function()
      return a.Rage > 90 or not c.HasBuff("Frenzied Regeneration", true)
   end,
})

c.AddOptionalSpell("Incarnation: Son of Ursoc", nil, {
   ShouldHold = function()
      return c.GetCooldown("Mangle") < .5
   end,
})

c.AddOptionalSpell("Frenzied Regeneration", nil, {
   NoGCD = true,
   Cooldown = 1.5,
   CheckFirst = function()
      if a.Rage <= 0 then
         return false
      end

      local heal = 6
         * UnitAttackPower("player")
         * c.GetResolve()
         * c.GetVersatility()
         * c.GetCritChance()
         * min(1, a.Rage / 60)

      return c.GetHealth("player") + heal <= UnitHealthMax("player")
   end,
})

c.AddOptionalSpell("Savage Defense", nil, {
   NoGCD = true,
   Melee = true,
   Cooldown = 1.5,
   Rage = 60,
   CheckFirst = function()
      return c.IsTanking() and not c.HasBuff("Barkskin")
   end
})

c.AddOptionalSpell("Berserk", "for Guardian", {
   NoGCD = true,
   Cooldown = 180,
   CheckFirst = function()
      return c.GetBuffDuration("Pulverize") > 10
         or not c.HasTalent("Pulverize")
   end
})

c.AddOptionalSpell("Pulverize", nil, {
   GetDelay = function()
      return c.GetBuffDuration("Pulverize") - 3.6, 0.5
         and c.GetMyDebuffStack("Lacerate") >= 3
   end
})

local bleeds = c.GetIDs(
   "Lacerate",
   "Thrash (Bear Form)",
   "Thrash (Cat Form)",
   "Rake",
   "Rip",
   "Pounce Bleed",
   "Deep Wounds",
   "Rupture",
   "Hemorrhage",
   "Garrote"
)

c.AddOptionalSpell("Maul", "for Guardian", {
   NoGCD = true,
   Cooldown = 3,
   Rage = 20,
   CheckFirst = function()
      return (a.EmptyRage < 10 and (c.HasBuff("Tooth and Claw", true) or not c.IsTanking()))
         or (c.InDamageMode() and c.HasDebuff(bleeds))
   end,
})

c.AddTaunt("Growl", nil, {
   NoGCD = true,
})

c.AddSpell("Thrash (Bear Form)", "if down", {
   FlashID = { "Thrash", "Thrash (Bear Form)", "Thrash (Cat Form)" },
   MyDebuff = "Thrash (Bear Form)"
})

c.AddSpell("Thrash (Bear Form)", "early", {
   FlashID = { "Thrash", "Thrash (Bear Form)", "Thrash (Cat Form)" },
   MyDebuff = "Thrash (Bear Form)",
   EarlyRefresh = 4.8,
})

c.AddOptionalSpell("Rejuvenation", "for Guardian", {
   NoRangeCheck = true,
   GetDelay = function()
      return c.HasBuff("Heart of the Wild: Guardian")
         and not c.InDamageMode()
         and c.GetMyBuffDuration("Rejuvenation") - 3.6, 0
   end,
})

c.AddSpell("Mangle", "for Guardian", {
   RunFirst = function(z)
      if c.HasBuff("Berserk") or c.HasBuff("Incarnation: Son of Ursoc") then
         z.Cooldown = 0
      else
         z.Cooldown = 6
      end
   end,
})

c.AddSpell("Mangle", "Delay", {
   IsMinDelayDefinition = true,
   GetDelay = function()
      return c.GetCooldown("Mangle", false, 6), .5
   end
})

c.AddSpell("Lacerate", "for Pulverize", {
   CheckFirst = function()
      return c.HasTalent("Pulverize")
         and not c.HasBuff("Berzerk")
         and c.GetBuffDuration("Pulverize") <= (c.LastGCD * (3 - c.GetMyDebuffStack("Lacerate"))) + 0.5
   end
})

c.AddSpell("Lacerate", "for Debuff", {
   MyDebuff = "Lacerate"
})

c.AddSpell("Lacerate")

c.AddOptionalSpell("Heart of the Wild: Guardian", nil, {
   Melee = true,
   FlashSize = s.FlashSizePercent() / 2,
   CheckFirst = function()
      return not c.IsTanking()
         or c.InDamageMode()
   end,
})


------------------------------------------------------------------- Restoration
c.RegisterForFullChannels("Tranquility")

c.AddOptionalSpell("Force of Nature: Restoration", nil, {
   NoRangeCheck = true,
   NoGCD = true,
   CheckFirst = forceOfNatureCheck,
})

c.AddSpell("Lifebloom", nil, {
   NoRangeCheck = true,
   Tick = 1,
   CheckFirst = function(z)
--         if c.HasBuff("Incarnation: Tree of Life", false, false, true) then
--            c.MakeMini(z, false)
--            return true
--         end

      local dur = s.MyBuffDuration(z.ID, a.LifebloomTarget)
      if dur > 0
         and c.IsCastingAt(
            a.LifebloomTarget, "Regrowth", "Healing Touch")
         and c.GetBusyTime(true) < dur then

         return false
      end

      dur = dur - c.GetBusyTime()
      local rgCast = c.GetCastTime("Regrowth")
      local htCast = c.GetCastTime("Healing Touch")
      if dur < rgCast then
         z.FlashColor = "red"
         c.MakeMini(z, dur > z.EarlyRefresh)
         return true
      elseif dur < rgCast + z.EarlyRefresh then
         z.FlashColor = "yellow"
         c.MakeMini(z, false)
         return true
      elseif dur < htCast then
         return false
      elseif dur < htCast + z.EarlyRefresh then
         z.FlashColor = "yellow"
         c.MakeMini(z, true)
         return true
      end
   end,
})

local function harmonyNeeded()
   return not c.HasBuff("Harmony")
      and not c.IsCasting("Healing Touch", "Regrowth")
end

local function doHTandRG(z)
   local h = harmonyNeeded()
   local cc = c.HasBuff("Clearcasting")
      and not c.IsCasting("Healing Touch", "Regrowth")
   c.MakeMini(z, h and not cc)
   return h or cc
end

c.AddOptionalSpell("Healing Touch", "for Restoration", {
   Override = function(z)
      local dur = c.GetBuffDuration("Sage Mender")
      if dur > 0 then
         if dur < 2 then
            z.FlashColor = "red"
            return true
         elseif c.GetBuffStack("Sage Mender") == 5 then
            z.FlashColor = "yellow"
            return true
         else
            return false
         end
      end

      z.FlashColor = "yellow"
      return doHTandRG(z)
   end,
})

c.AddOptionalSpell("Regrowth", nil, {
   Override = doHTandRG,
})

c.AddOptionalSpell("Cenarion Ward", "for Restoration", {
   NoRangeCheck = true,
})

c.AddOptionalSpell("Wild Mushroom: Restoration", nil, {
   NoRangeCheck = true,
   CheckFirst = function()
      return c.IsMissingTotem(1)
   end,
})
