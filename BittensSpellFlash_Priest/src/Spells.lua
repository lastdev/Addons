local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local CheckInteractDistance = CheckInteractDistance
local GetTime = GetTime
local IsItemInRange = IsItemInRange
local math = math
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
            stack = math.min(5, stack + 1)
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
   Override = function()
      return c.GetCooldown("Shadowfiend") == 0
   end
})

c.AddOptionalSpell("Mindbender", nil, {
   Override = function()
      return c.GetCooldown("Mindbender") == 0
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
      return a.Orbs < 3 and c.GetCooldown("Mind Blast", false, 0)
   end
})

c.AddSpell("Mind Blast", "Delay", {
   IsMinDelayDefinition = true,
   GetDelay = function()
      return a.Orbs < 3 and c.GetCooldown("Mind Blast", false, 9), .5
   end,
})

c.AddSpell("Shadow Word: Death", nil, {
   GetDelay = function()
      if not a.InExecute then
         return false
      end

      if a.SWDinARow == 1 then
         return 0
      end

      return c.GetCooldown("Shadow Word: Death", false, 8)
   end,
})

c.AddSpell("Shadow Word: Death", "for Orb", {
   GetDelay = function()
      if not a.InExecute or a.Orbs >= 3 then
         return false
      end

      if a.SWDinARow == 1 then
         return 9 - a.SinceSWD
      else
         return c.GetCooldown("Shadow Word: Death", false, 8)
      end
   end,
})

c.AddSpell("Shadow Word: Death", "without Orb", {
   CheckFirst = function()
      return a.InExecute and a.SWDinARow == 1 and a.SinceSWD < 3
   end
})

c.MakePredictor(c.AddSpell("Shadow Word: Death", "Delay", {
   IsMinDelayDefinition = true,
   GetDelay = function()
      if not a.InExecute or a.Orbs >= 3 then
         return false
      end

      if a.SWDInARow == 1 then
         return 6 - a.SinceSWD, .5
      else
         return c.GetCooldown("Shadow Word: Death", false, 8), .5
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

c.AddSpell("Insanity", nil, {
   CanCastWhileMoving = false,
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

-- c.AddSpell("Mind Flay", "(Insanity) Delay", {
--    IsMinDelayDefinition = true,
--    GetDelay = function()
--       return a.Insanity
--    end,
-- })

c.AddSpell("Shadow Word: Pain", nil, {
   MyDebuff = "Shadow Word: Pain",
   Tick = 3,
})

c.AddSpell("Shadow Word: Pain", "Application", {
   MyDebuff = "Shadow Word: Pain",
})

c.AddSpell("Shadow Word: Pain", "Early", {
   MyDebuff = "Shadow Word: Pain",
   Tick = 6,
   CheckFirst = function()
      return a.InExecute and c.HasTalent("Insanity")
   end
})

c.AddSpell("Shadow Word: Pain", "Moving", {
   MyDebuff = "Shadow Word: Pain",
   EarlyRefresh = 15,
})

c.AddSpell("Vampiric Touch", nil, {
   MyDebuff = "Vampiric Touch",
   Tick = 3,
})

c.AddSpell("Vampiric Touch", "Application", {
   MyDebuff = "Vampiric Touch",
})

c.AddSpell("Vampiric Touch", "Early", {
   MyDebuff = "Vampiric Touch",
   Tick = 6,
   CheckFirst = function()
      return a.InExecute and c.HasTalent("Insanity")
   end
})

c.AddSpell("Mind Spike", "under Surge of Darkness", {
   CheckFirst = function()
      return a.Surges > 0
   end
})

c.AddSpell("Devouring Plague", nil, {
   MyDebuff = "Devouring Plague",
   Tick = 1,
   CheckFirst = function()
      return a.Orbs >= 3
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
