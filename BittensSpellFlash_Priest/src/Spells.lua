local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local CheckInteractDistance = CheckInteractDistance
local GetTime = GetTime
local IsItemInRange = IsItemInRange
local min = math.min
local max = math.max
local pairs = pairs

local function mendingIsDown()
   return not s.MyBuff(
      c.GetID("Prayer of Mending"),
      a.PrayerOfMendingTarget,
      c.GetBusyTime())
end

------------------------------------------------------------------------ Common
c.AddOptionalSpell("Power Word: Fortitude", nil, {
   NoRangeCheck = true,
   CheckFirst = function()
      return c.RaidBuffNeeded(c.STAMINA_BUFFS)
   end
})

c.AddOptionalSpell("Power Infusion", nil, {
   NoGCD = true,
   NoRangeCheck = true,
})

c.AddOptionalSpell("Flash Heal", "under Surge of Light", {
   NoRangeCheck = true,
   CheckFirst = function()
      return c.HasBuff("Surge of Light")
   end
})

c.AddOptionalSpell("Mindbender", "for Mana", {
   Cooldown = 60,
   CheckFirst = function()
      return s.PowerPercent("player") < 82
   end
})

c.AddOptionalSpell("Desperate Prayer", nil, {
   Override = function()
      return c.GetHealthPercent("player") < 70
         and c.GetCooldown("Desperate Prayer") == 0
   end
})

c.AddOptionalSpell("Binding Heal", nil, {
   NoRangeCheck = true,
   CheckFirst = function()
      return c.GetHealthPercent("player") < 85
   end
})

c.AddDispel("Dispel Magic", nil, "Magic")

-------------------------------------------------------------------- Discipline
c.RegisterForFullChannels("Penance", 2)

c.AddOptionalSpell("Power Word: Shield", "under Divine Insight", {
   FlashID = { "Power Word: Shield", "Power Word: Shield w/ Insight" },
   NoRangeCheck = true,
   CheckFirst = function()
      return c.HasBuff("Divine Insight")
   end
})

c.AddOptionalSpell("Archangel", nil, {
   CheckFirst = function(z)
      local dur = c.GetBuffDuration("Evangelism")
      local stack = c.GetBuffStack("Evangelism")
      if c.IsCasting("Penance", "Smite", "Holy Fire") then
         if dur > 0 then
            stack = min(5, stack + 1)
         else
            stack = 1
         end
         dur = 20
      end

      if dur == 0 or dur > 5 then
         return false
      end

      if stack < 5 then
         z.FlashSize = s.FlashSizePercent() / 2
      else
         z.FlashSize = nil
      end
      if dur < 1 then
         z.FlashColor = "red"
      else
         z.FlashColor = "yellow"
      end
      return true
   end
})

c.AddOptionalSpell("Prayer of Mending", "for Discipline", {
   NoRangeCheck = true,
   CheckFirst = mendingIsDown,
})

-------------------------------------------------------------------------- Holy
c.AddOptionalSpell("Chakra", nil, {
   ID = "Chakra: Sanctuary",
   FlashID = { "Chakra", "Chakra: Sanctuary", "Chakra: Serenity" },
   CheckFirst = function()
      return not c.HasBuff("Chakra: Sanctuary")
         and not c.HasBuff("Chakra: Serenity")
         and not c.HasBuff("Chakra: Chastise")
   end
})

c.AddOptionalSpell("Lightwell", nil, {
   NoRangeCheck = true,
   NotIfActive = true,
   CheckFirst = function()
      return not c.HasGlyph("Lightspring")
   end,
})

local function serendipityCheck(z)
   local stacks = c.GetBuffStack("Serendipity")
   if stacks < 2 and c.IsCasting("Binding Heal", "Flash Heal") then
      stacks = stacks + 1
   elseif c.IsCasting("Heal", "Prayer of Healing") then
      stacks = 0
   end

   c.MakeMini(z, stacks == 1)
   return stacks > 0
end

c.AddOptionalSpell("Heal", "under Serendipity", {
   NoRangeCheck = true,
   CheckFirst = serendipityCheck,
})

c.AddOptionalSpell("Prayer of Healing", "under Serendipity", {
   NoRangeCheck = true,
   CheckFirst = serendipityCheck,
})

c.AddOptionalSpell("Prayer of Mending", "for Holy", {
   NoRangeCheck = true,
   Override = function(z)
      local normalCheck = mendingIsDown()
         and c.GetCooldown("Prayer of Mending") == 0
      if c.HasTalent("Divine Insight") then
         local insight = c.HasBuff("Divine Insight")
         c.MakeMini(z, not insight)
         return insight or normalCheck
      else
         return normalCheck
      end
   end,
})

------------------------------------------------------------------------ Shadow
c.AddOptionalSpell("Shadowform", nil, {
   Type = "form",
})

c.AddOptionalSpell("Shadowfiend", nil, {
   Cooldown = 3 * 60,
   CheckFirst = function()
      return not a.Insanity
   end
})

c.AddOptionalSpell("Mindbender", nil, {
   Cooldown = 60,
   CheckFirst = function()
      return not a.Insanity
   end
})

c.AddOptionalSpell("Vampiric Embrace", nil, {
   CheckFirst = function()
      return c.IsSolo() and c.GetHealthPercent("player") < 50
   end
})

c.AddInterrupt("Silence", nil, {
   NoGCD = true,
})

c.AddSpell("Mind Blast", nil, {
   GetDelay = function()
      return a.Orbs < a.maxOrbs and c.GetCooldown("Mind Blast", false, 0)
   end
})

c.AddSpell("Mind Blast", "with Shadowy Insight", {
   GetDelay = function()
      return c.HasBuff("Shadowy Insight")
         and c.GetCooldown("Mind Blast", false, 0)
   end
})

c.AddSpell("Mind Blast", "for three orbs", {
   GetDelay = function()
      return a.Orbs <= 2
         and a.canMindHarvest()
         and c.GetCooldown("Mind Blast", false, 0)
   end
})

c.AddSpell("Mind Blast", "<= 5 targets", {
   GetDelay = function()
      return c.EstimatedHarmTargets <= 5 and c.GetCooldown("Mind Blast", false, 0)
   end
})

c.AddSpell("Mind Blast", "Delay", {
   IsMinDelayDefinition = true,
   GetDelay = function()
      return a.Orbs < a.maxOrbs and c.GetCooldown("Mind Blast", false, 9), .5
   end,
})

c.AddSpell("Shadow Word: Death", nil, {
   GetDelay = function()
      if not a.InExecute then
         return false
      end

      return c.GetCooldown("Shadow Word: Death", false, 8)
   end,
})

c.AddSpell("Shadow Word: Death", "for Orb", {
   GetDelay = function()
      if not a.InExecute or a.Orbs >= 5 then
         return false
      end

      if a.swdGivesOrb() then
         return c.GetCooldown("Shadow Word: Death", false, 8)
      else
         return 8 - a.SinceSWD
      end
   end,
})

c.AddSpell("Shadow Word: Death", "without Orb", {
   CheckFirst = function()
      return a.InExecute and not a.swdGivesOrb() and a.SinceSWD < 3
   end
})

c.MakePredictor(c.AddSpell("Shadow Word: Death", "Delay", {
   IsMinDelayDefinition = true,
   GetDelay = function()
      if not a.InExecute or a.Orbs >= a.maxOrbs then
         return false
      end

      if a.swdGivesOrb() then
         return c.GetCooldown("Shadow Word: Death", false, 8), .5
      else
         return 6 - a.SinceSWD, .5
      end
   end,
}))

c.AddSpell("Mind Flay", nil, {
   CanCastWhileMoving = false,
   GetDelay = function(z)
      -- local delay = c.GetMyDebuffDuration("Mind Flay (Insanity)")
      -- if delay > 0 then
      --    z.WhiteFlashOffset = 0
      --    return delay
      -- end
      -- 
      -- z.WhiteFlashOffset = -a.FlayTick
      return s.GetChanneling(z.ID, "player") - c.GetBusyTime()
   end
})

c.AddSpell("Mind Flay", "for CoP and Insanity", {
   CanCastWhileMoving = false,
   CheckFirst = function()
      return c.WearingSet(2, "T17")
         and c.HasMyDebuff("Shadow Word: Pain")
         and c.HasMyDebuff("Vampiric Touch")
         and c.GetCooldown("Mind Blast", false, 6) > 0.9 * c.LastGCD
   end,
   GetDelay = function(z)
      return s.GetChanneling(z.ID, "player") - c.GetBusyTime()
   end
})

c.AddSpell("Insanity", nil, {
   CanCastWhileMoving = false,
   FlashID = { "Insanity", "Mind Flay" },
   CheckFirst = function()
      return a.Insanity
   end,
   GetDelay = function(z)
      -- if a.Insanity == 0 then
      --    z.WhiteFlashOffset = 0
      --    return 0
      -- end
      -- 
      -- if a.Insanity - a.FlayTick > plague - .5 then
      --    z.WhiteFlashOffset = -2 * a.FlayTick
      -- else
      --    z.WhiteFlashOffset = -a.FlayTick
      -- end
      -- return a.Insanity
      return s.GetChanneling(z.ID, "player") - c.GetBusyTime()
   end,
})
c.RegisterInitiatingSpell("Insanity", "Insanity")

c.AddSpell("Insanity", "Delay", {
   IsMinDelayDefinition = true,
   GetDelay = function()
      return c.GetBuffDuration("Shadow Word: Insanity")
   end,
})

c.AddSpell("Shadow Word: Pain", nil, {
   MyDebuff = "Shadow Word: Pain",
   Tick = 3,
})

c.AddSpell("Shadow Word: Pain", "Early", {
   MyDebuff = "Shadow Word: Pain",
   Tick = 3,
   EarlyRefresh = 18 * 0.3,
})

c.AddSpell("Shadow Word: Pain", "for Insanity", {
   MyDebuff = "Shadow Word: Pain",
   Tick = 3,
   EarlyRefresh = 9, -- 3 ticks
   CheckFirst = function()
      return a.Orbs >= 2 and c.HasTalent("Insanity")
   end,
})

c.AddSpell("Shadow Word: Pain", "for CoP and Insanity", {
   MyDebuff = "Shadow Word: Pain",
   Tick = 3,
--   EarlyRefresh = 9, -- 3 ticks
   CheckFirst = function()
      if a.Orbs == 4
         and c.WearingSet(2, "T17")
         and not c.HasMyDebuff("Shadow Word: Pain")
         and not c.HasMyDebuff("Devouring Plague")
         and c.GetCooldown("Mind Blast", false, 6) < 1.2 * c.LastGCD
         and c.GetCooldown("Mind Blast", false, 6) > 0.2 * c.LastGCD
      then
         return true
      end

      if a.Orbs >= 5
         and not c.HasMyDebuff("Devouring Plague")
         and not c.HasMyDebuff("Shadow Word: Pain")
      then
         return true
      end

      return false
   end,
})

c.AddSpell("Shadow Word: Pain", "Moving", {
   MyDebuff = "Shadow Word: Pain",
   EarlyRefresh = 15,
})

c.AddSpell("Vampiric Touch", nil, {
   MyDebuff = "Vampiric Touch",
   Tick = 3,
})

c.AddSpell("Vampiric Touch", "Early", {
   MyDebuff = "Vampiric Touch",
   Tick = 3,
   EarlyRefresh = 15 * 0.3,
})

c.AddSpell("Vampiric Touch", "for Insanity", {
   MyDebuff = "Vampiric Touch",
   Tick = 3,
   EarlyRefresh = 3 * 3.5, -- 3.5 ticks
   CheckFirst = function()
      return a.Orbs >= 2 and c.HasTalent("Insanity")
   end,
})

c.AddSpell("Vampiric Touch", "for CoP and Insanity", {
   MyDebuff = "Vampiric Touch",
   Tick = 3,
   -- EarlyRefresh = 3 * 3.5, -- 3.5 ticks
   CheckFirst = function()
      return a.Orbs >= 5
         and not c.HasMyDebuff("Devouring Plague")
         and not c.HasMyDebuff("Vampiric Touch")
   end,
})

c.AddSpell("Mind Spike")

c.AddSpell("Mind Spike", "Surge of Darkness Cap", {
   CheckFirst = function()
      return c.EstimatedHarmTargets <= 5 and a.Surges >= 3
   end
})

c.AddSpell("Mind Spike", "under Surge of Darkness", {
   CheckFirst = function()
      return c.EstimatedHarmTargets <= 5 and a.Surges > 0
   end
})

c.AddSpell("Mind Spike", "without Devouring Plague", {
   CheckFirst = function()
      return not c.HasMyDebuff("Devouring Plague")
   end
})

c.AddSpell("Mind Spike", "for CoP and Insanity", {
   CheckFirst = function()
      if a.Orbs > 2 or c.GetCooldown("Mind Blast", false, 6) < 0.5 * c.LastGCD then
         return false
      end

      local vt = c.HasMyDebuff("Vampiric Touch")
      local swp = c.HasMyDebuff("Shadow Word: Pain")

      return (vt and not swp) or (swp and not vt)
   end
})

c.AddSpell("Devouring Plague", nil, {
   MyDebuff = "Devouring Plague",
   Tick = 1,
   CheckFirst = function()
      if a.Orbs >= 5 then
         return true
      end

      if a.Orbs < 3 then
         return false
      end

      return c.GetCooldown("Mind Blast", false, 9) < c.LastGCD
         or (a.InExecute and c.GetCooldown("Shadow Word: Death", false, 8) < c.LastGCD)
         or c.ShouldCastToRefresh(
            "Devouring Plague", "Void Entropy", 2 * c.LastGCD, false)
   end,
})

c.AddSpell("Devouring Plague", "at three orbs", {
   MyDebuff = "Devouring Plague",
   Tick = 1,
   CheckFirst = function()
      if a.Orbs < 3 then
         return false
      end

      return c.GetCooldown("Mind Blast", false, 9) < c.LastGCD
         or (a.InExecute and c.GetCooldown("Shadow Word: Death", false, 8) < c.LastGCD)
   end,
})

c.AddSpell("Devouring Plague", "at five orbs", {
   MyDebuff = "Devouring Plague",
   Tick = 1,
   CheckFirst = function()
      if a.Orbs < 5 then
         return false
      end
   end,
})

-- as far as I can tell, zero travel time involved.
c.AssociateTravelTimes(0, "Devouring Plague")
c.AddSpell("Devouring Plague", "Late", {
   MyDebuff = "Devouring Plague",
   Tick = 1,
   CheckFirst = function()
      return not c.HasTalent("Void Entropy")
         and a.Orbs >= 3
         and c.ShouldCastToRefresh("Devouring Plague", "Devouring Plague", 1, true)
   end,
})

c.AddSpell("Devouring Plague", "for CoP and Insanity", {
   MyDebuff = "Devouring Plague",
   Tick = 1,
   CheckFirst = function()
      if a.Orbs < 3 then
         return false
      end

      local vt = c.HasMyDebuff("Vampiric Touch")
      local swp = c.HasMyDebuff("Shadow Word: Pain")

      if vt and swp and a.Orbs >= 5 then
         return true
      end

      -- T17 4PC
      local mi = c.GetBuffDuration("Mental Instincts")
      if mi > 0 and mi < c.LastGCD then
         return true
      end

      if vt and swp and not a.Insanity
         and c.GetCooldown("Mind Blast", false, 6) > 0.4 * c.LastGCD
      then
         return true
      end

      return false
   end,
})

c.AddOptionalSpell("Cascade", nil, {
   NoRangeCheck = true,
   GetDelay = function(z)
      local dist = c.DistanceAtTheLeast()
      if dist >= 40 then
         return false
      elseif dist >= 30 then
         z.FlashColor = "green"
      elseif dist >= 20 then
         z.FlashColor = "yellow"
      else
         z.FlashColor = "red"
      end
      return c.GetCooldown("Cascade", false, 25)
   end
})

c.AddOptionalSpell("Divine Star", nil, {
   NoRangeCheck = true,
   GetDelay = function(z)
      local dist = c.DistanceAtTheMost()
      if dist > 24 then
         z.FlashColor = "red"
      else
         z.FlashColor = "yellow"
      end
      return c.GetCooldown("Divine Star", false, 15)
   end
})

c.AddOptionalSpell("Halo", nil, {
   NoRangeCheck = true,
   GetDelay = function(z)
      z.FlashSize = nil
      local dist = c.DistanceAtTheLeast()
      if dist >= 25 then
         z.FlashColor = "red"
      elseif dist >= 20 then
         if not CheckInteractDistance(s.UnitSelection(), 1) then
            z.FlashSize = s.FlashSizePercent() / 2
         end
         z.FlashColor = "green"
      elseif dist >= 15 then
         z.FlashColor = "yellow"
      else
         z.FlashColor = "red"
      end
      return c.GetCooldown("Halo", false, 40)
   end
})

c.AddOptionalSpell("Dispersion", nil, {
   CheckFirst = function()
      return s.PowerPercent("player") < 64
   end
})

c.AddOptionalSpell("Power Word: Shield", "for Shadow", {
   NoRangeCheck = true,
   CheckFirst = function(z)
      local health = c.GetHealthPercent("player")

      z.FlashColor = (health <= 75) and "red" or "yellow"

      return health <= 95
         and c.GetCooldown("Power Word: Shield", false, 6) <= 0
         and not s.Debuff(c.GetID("Weakened Soul"), "player")
   end
})

c.AddOptionalSpell("Mind Sear", "for AoE", {
   CheckFirst = function(z)
      return c.EstimatedHarmTargets >= 4
   end,
})

c.AssociateTravelTimes(0, "Void Entropy")
c.AddSpell("Void Entropy", nil, {
   MyDebuff = "Void Entropy",
   Tick = 3,
   CheckFirst = function(z)
      return a.Orbs >= 3 and not c.HasMyDebuff("Void Entropy")
   end,
})
