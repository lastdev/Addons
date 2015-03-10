local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local x = s.UpdatedVariables
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")
local u = BittensGlobalTables.GetTable("BittensUtilities")

local GetTime = GetTime
local SPELL_POWER_SHADOW_ORBS = SPELL_POWER_SHADOW_ORBS
local min = math.min
local max = math.max
local string = string
local wipe = wipe
local UnitGUID = UnitGUID

a.Rotations = {}

local function monitorMending(spellID, target)
   if spellID == c.GetID("Prayer of Mending Buff") then
      a.PrayerOfMendingTarget = target
      c.Debug("Event", "Prayer of Mending target:", a.PrayerOfMendingTarget)
   end
end

-------------------------------------------------------------------- Discipline
a.Rotations.Discipline = {
   Spec = 1,

   UsefulStats = { "Intellect", "Spirit", "Crit", "Haste", "Multistrike" },

   FlashInCombat = function()
      c.FlashAll(
         "Archangel",
         "Prayer of Mending for Discipline",
         "Flash Heal under Surge of Light",
         "Mindbender for Mana",
         "Desperate Prayer",
         "Dispel Magic",
         "Silence"
      )
   end,

   FlashAlways = function()
      c.FlashAll(
         "Power Word: Fortitude"
      )
   end,

   AuraApplied = monitorMending,
}

-------------------------------------------------------------------------- Holy
a.Rotations.Holy = {
   Spec = 2,

   UsefulStats = { "Multistrike", "Haste", "Intellect", "Spirit", "Crit" },

   FlashInCombat = function()
      c.FlashAll(
         "Lightwell",
         "Prayer of Mending for Holy",
         "Heal under Serendipity",
         "Prayer of Healing under Serendipity",
         "Flash Heal under Surge of Light",
         "Binding Heal",
         "Mindbender for Mana",
         "Desperate Prayer",
         "Dispel Magic"
      )
   end,

   FlashAlways = function()
      c.FlashAll(
         "Power Word: Fortitude",
         "Chakra"
      )
   end,

   CastSucceeded = monitorMending,
}

------------------------------------------------------------------------ Shadow
local lastSWDCast = 0
local lastSWDCD = 0
local swdGivesOrb = true

function a.swdGivesOrb()
   if c.HasSpell("Enhanced Shadow Word: Death") then
      return true
   else
      return swdGivesOrb
   end
end

local mindHarvested = {}

function a.canMindHarvest()
   return c.HasGlyph("Mind Harvest") and not mindHarvested[UnitGUID("target")]
end

a.FlayTick = 1
a.Rotations.Shadow = {
   Spec = 3,

   UsefulStats = {
      "Intellect", "Spell Hit", "Hit from Spirit", "Crit", "Haste"
   },

   PreFlash = function()
      a.maxOrbs = c.HasSpell("Enhanced Shadow Orbs") and 5 or 3

      a.SinceSWD = GetTime() - lastSWDCast
      local swdcd = c.GetCooldown("Shadow Word: Death", false, 8)
      if a.SinceSWD < 9 and swdcd < lastSWDCD then
         swdGivesOrb = false
      else
         swdGivesOrb = true
      end

      a.Orbs = s.Power("player", SPELL_POWER_SHADOW_ORBS)
      if c.IsCasting("Mind Blast") then
         a.Orbs = min(a.maxOrbs, a.Orbs + (a.canMindHarvest() and 1 or 3))
      elseif c.IsCasting("Devouring Plague") then
         a.Orbs = max(0, a.Orbs - 3)
      elseif c.IsCasting("Shadow Word: Death")
         and s.HealthPercent() <= 20
         and a.swdGivesOrb()
      then
         a.Orbs = min(a.maxOrbs, a.Orbs + 1)
      end

      a.Surges = c.GetBuffStack("Surge of Darkness")
      if c.IsCasting("Mind Spike") then
         a.Surges = a.Surges - 1
      end

      a.InExecute = s.HealthPercent() <= 20

      a.Insanity = c.HasBuff("Shadow Word: Insanity")
   end,

   FlashInCombat = function()
      c.FlashAll(
         "Power Word: Shield for Shadow",
         "Power Infusion",
         "Mindbender",
         "Shadowfiend",
         "Desperate Prayer",
         "Vampiric Embrace",
         "Dispel Magic",
         "Silence"
      )

      local cop = c.HasTalent("Clarity of Power")
      local ins = c.HasTalent("Insanity")

      if cop and ins and not a.InExecute and c.EstimatedHarmTargets <= 5 then
         -- SimCraft cop_dotweave
         c.DelayPriorityFlash(
            "Power Infusion",
            "Devouring Plague for CoP and Insanity",
            "Mind Blast for three orbs",
            "Mind Blast <= 5 targets",
            "Mindbender",
            "Shadowfiend",
            "Shadow Word: Pain for CoP and Insanity",
            "Vampiric Touch for CoP and Insanity",
            "Insanity",
            "Insanity Delay",
            -- dots if we had bloodlust and stuff.
            "Halo",
            "Cascade",
            "Divine Star",
            -- dots on non-primary target.
            "Mind Spike for CoP and Insanity",
            "Mind Flay for CoP and Insanity",
            "Mind Spike"
         )
      elseif cop and ins and a.InExecute then
         -- SimCraft cop_mfi
         c.DelayPriorityFlash(
            "Power Infusion",
            "Devouring Plague at five orbs",
            "Mind Blast for three orbs",
            "Mind Blast <= 5 targets",
            "Shadow Word: Death",
            "Devouring Plague at three orbs",
            "Mindbender",
            "Shadowfiend",
            -- dots on non-primary targets
            "Insanity",
            "Insanity Delay",
            "Halo",
            "Cascade",
            "Divine Star",
            "Mind Sear for AoE",
            "Mind Spike"
         )
      elseif cop then
         -- SimCraft cop
         c.DelayPriorityFlash(
            "Power Infusion",
            "Devouring Plague at three orbs",
            "Mind Blast for three orbs",
            "Mind Blast for three orbs",
            "Mind Blast <= 5 targets",
            "Shadow Word: Death",
            "Mindbender",
            "Shadowfiend",
            "Halo",
            "Cascade",
            "Divine Star",
            -- maybe throw dots on non-primary target.
            "Mind Spike under Surge of Darkness",
            "Mind Sear for AoE",
            "Mind Spike without Devouring Plague",
            "Mind Flay"
         )
      elseif c.HasTalent("Void Entropy") then
         -- SimCraft vent
         c.DelayPriorityFlash(
            "Power Infusion",
            "Mindbender",
            "Shadowfiend",
            "Void Entropy",
            "Devouring Plague",
            "Halo",
            "Cascade",
            "Divine Star",
            "Mind Blast for three orbs",
            "Mind Blast <= 5 targets",
            "Shadow Word: Death for Orb",
            -- actions.vent+=/shadow_word_pain,if=shadow_orb=4&remains<(18*0.50)&set_bonus.tier17_2pc&cooldown.mind_blast.remains<1.2*gcd&cooldown.mind_blast.remains>0.2*gcd
            "Insanity",
            "Insanity Delay",
            "Mind Spike Surge of Darkness Cap",
            "Shadow Word: Pain Early",
            "Vampiric Touch Early",
            "Mind Blast Delay",
            "Mind Spike under Surge of Darkness",
            "Mind Sear for AoE",
            "Shadow Word: Pain for Insanity",
            "Vampiric Touch for Insanity",
            "Mind Flay"
         )
      else
         -- SimCraft main
         c.DelayPriorityFlash(
            "Power Infusion",
            "Mindbender",
            "Shadowfiend",
            "Shadow Word: Death for Orb",
            "Devouring Plague",
            "Mind Blast for three orbs",
            "Mind Blast <= 5 targets",
            "Insanity",
            "Insanity Delay",
            "Halo",
            "Cascade",
            "Divine Star",
            "Shadow Word: Pain Early",
            "Vampiric Touch Early",
            "Devouring Plague Late",
            "Mind Spike Surge of Darkness Cap",
            "Shadow Word: Death Delay",
            "Mind Blast Delay",
            "Mind Spike under Surge of Darkness",
            "Mind Sear for AoE",
            "Shadow Word: Pain for Insanity",
            "Vampiric Touch for Insanity",
            "Mind Flay"
         )
      end
   end,

   MovementFallthrough = function()
      c.PriorityFlash(
         "Mind Blast with Shadowy Insight",
         "Divine Star",
         "Cascade",
         "Shadow Word: Death",
         "Shadow Word: Pain Moving"
      )
   end,

   FlashOutOfCombat = function()
      c.FlashAll("Dispersion")

      if x.EnemyDetected then
         c.FlashAll("Mind Spike")
      end
   end,

   FlashAlways = function()
      c.FlashAll(
         "Power Word: Fortitude",
         "Shadowform"
      )
   end,

   LeftCombat = function()
      wipe(mindHarvested)
   end,

   SpellDamage = function(spellID, _, targetID)
      if c.IdMatches(spellID, "Mind Blast") then
         mindHarvested[targetID] = true
      end
   end,

   CastSucceeded = function(info)
      if c.InfoMatches(info, "Shadow Word: Death") then
         lastSWDCast = GetTime()
         lastSWDCD = c.GetCooldown("Shadow Word: Death")
         c.Debug("Event", "Shadow Word: Death cast",
                 "cast", lastSWDCast, "cd", lastSWDCD)
      end
   end,

   AuraApplied = function(spellID)
      if c.IdMatches(spellID, "Mind Flay", "Insanity") then
         a.FlayTick = c.GetHastedTime(1)
         c.Debug("Event", "Mind Flay ticks every", a.FlayTick)
      end
   end,

   ExtraDebugInfo = function()
      return string.format(
         "o:%d s:%d s:%d s:%.1f b:%.1f",
         a.Orbs, a.Surges, a.swdGivesOrb(), a.SinceSWD, c.GetBusyTime()
      )
   end,
}
