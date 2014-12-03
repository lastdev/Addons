local addonName, a = ...
local s = SpellFlashAddon
local x = s.UpdatedVariables
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")
local u = BittensGlobalTables.GetTable("BittensUtilities")

local GetPowerRegen = GetPowerRegen
local GetTime = GetTime
local SPELL_POWER_FOCUS = SPELL_POWER_FOCUS
local math = math
local pairs = pairs
local select = select
local string = string
local tostring = tostring

local warning = "|cFFFF0000WARNING: The Hunter %s rotation works to level 90, but has not been updated to level 100.  I can't promise when this will happen, but this will happen.  Help is absolutely welcome.|r -- SlippyCheeze"

local printedOnce = {}
local function printOnce(msg, ...)
   if a.printedOnce[msg] then return end
   a.printedOnce[msg] = true
   print(format(msg, ...))
end

function a.FocusAdded(delay)
   if s.Buff(c.GetID("Steady Focus"), "player", delay) then
      return 21
   else
      return 14
   end
end

local function castQueued(info)
   -- adjust focus costs
   if c.InfoMatches(info, "Cobra Shot", "Steady Shot") then
      info.Cost[SPELL_POWER_FOCUS] = -a.FocusAdded(
         info.CastStart + s.CastTime(info.Name) - GetTime())

      -- this starts a steady focus pattern
      a.startedSteadyFocus = true
   else
      -- and this breaks it.
      a.startedSteadyFocus = false
   end
end

a.Rotations = { }

function a.PreFlash()
   a.Regen = select(2, GetPowerRegen())
   a.Focus = c.GetPower(a.Regen, SPELL_POWER_FOCUS)
   a.EmptyFocus = s.MaxPower("player") - a.Focus
end

----------------------------------------------------------------- Beast Mastery
a.LastMultiShot = 0

a.Rotations.BeastMastery = {
   Spec = 1,

   UsefulStats = {
      "Agility", "Multistrike", "Crit", "Versatility", "Mastery", "Haste"
   },

   FlashInCombat = function()
      c.FlashAll(
         "Exhilaration",
         "Heart of the Phoenix",
         "Growl",
         "Last Stand",
         "Bullheaded",
         "Mend Pet at 50",
         "Counter Shot",
         "Tranquilizing Shot"
      )

      c.PriorityFlash(
         "Cobra Shot for Steady Focus",
         "Dire Beast",
         "Focus Fire",
         "Stampede",
         "Explosive Trap",
         "Bestial Wrath",
         "A Murder of Crows",
         "Kill Shot",
         "Multi-Shot",
         "Barrage for AoE",
         "Kill Command",
         "Arcane Shot under Thrill of the Hunt",
         "Arcane Shot under Bestial Wrath",
         "Barrage for BM",
         "Glaive Toss",
         "Powershot",
         "Arcane Shot for BM",
         "Focusing Shot",
         "Cobra Shot",
         "Steady Shot for Leveling"
      )

      if c.Flashing["Bestial Wrath"] and c.Flashing["Cobra Shot"] then
         c.PredictFlash("Arcane Shot")
      end
   end,

   FlashOutOfCombat = function()
      c.FlashAll("Mend Pet")

      if x.EnemyDetected then
         c.PriorityFlash(
            "Dire Beast",
            "Bestial Wrath",
            "Kill Command",
            "A Murder of Crows",
            "Barrage for BM",
            "Cobra Shot"
         )
      end
   end,

   FlashAlways = function()
      c.FlashAll("Call Pet", "Revive Pet")
   end,

   CastQueued = castQueued,

   CastSucceeded = function(info)
      if c.InfoMatches(info, "Multi-Shot") then
         a.LastMultiShot = GetTime()
         c.Debug("Event", "Multi Shot")
      end
   end,

   ExtraDebugInfo = function()
      return string.format("%.1f", a.Focus)
   end
}

------------------------------------------------------------------ Marksmanship
local nextSSIsImproved
local ssUnimprovers = {
   "Arcane Shot",
   "Chimera Shot",
   "Aimed Shot",
   "Glaive Toss", -- guess
   "Powershot", -- guess
   "Barrage", -- guess
   "A Murder of Crows",
   "Dire Beast",
   "Serpent Sting",
   "Multi-Shot",
   "Tranquilizing Shot",
-- Perhaps the below are not worth including, since they are not part of the
-- rotation
--      "Distracting Shot",
--      "Silencing Shot",
--      "Wyvern Sting",
--      "Binding Shot",
}
-- Things that do NOT break SS pairs:
-- Traps
-- Things not on the GCD
-- Deterrence
-- Disengage
-- Feign Death
-- Flare
-- Mend Pet

local function getImprovedStatus(info, curValue)
   if info then
      if c.InfoMatches(info, "Steady Shot") then
         return not curValue
      elseif c.InfoMatches(info, ssUnimprovers) then
         return false
      end
   end
   return curValue
end

a.Rotations.Marksmanship = {
   Spec = 2,

   UsefulStats = { "Agility", "Melee Hit", "Crit", "Haste" },

   FlashInCombat = function()

      -- adjust resources/cooldowns to reflect casting & queued spells
      local casting = c.GetCastingInfo()
      local queued = c.GetQueuedInfo()
      a.NextSSIsImproved = getImprovedStatus(casting, nextSSIsImproved)
      a.NextSSIsImproved = getImprovedStatus(queued, a.NextSSIsImproved)
      a.CSCool = c.GetCooldown("Chimera Shot", false, 9)

      -- flash
      c.FlashAll(
         "Exhilaration",
         "Heart of the Phoenix",
         "Growl",
         "Last Stand",
         "Bullheaded",
         "Mend Pet at 50",
         "Counter Shot",
         "Tranquilizing Shot")
      c.PriorityFlash(
         "Steady Shot 2",
         "Chimera Shot to save Serpent Sting",
         "Serpent Sting",
         "Stampede for Marksmanship",
         "A Murder of Crows",
         "Dire Beast",
         "Chimera Shot",
         "Kill Shot",
         "Glaive Toss",
         "Rapid Fire",
         "Steady Shot Opportunistic",
         "Arcane Shot under Thrill of the Hunt",
         "Powershot",
         "Aimed Shot",
         "Arcane Shot for Marksmanship",
         "Barrage",
         "Mend Pet",
         "Steady Shot")
   end,

   FlashOutOfCombat = function()
      printOnce(warning, "MM")
      c.FlashAll("Mend Pet")
   end,

   FlashAlways = function()
      c.FlashAll("Call Pet", "Revive Pet")
   end,

   CastQueued = castQueued,

   CastSucceeded = function(info)
      nextSSIsImproved = getImprovedStatus(info, nextSSIsImproved)
   end,

   ExtraDebugInfo = function()
      return string.format("%.1f %s %.1f",
         a.Focus, tostring(a.NextSSIsImproved), a.CSCool)
   end,
}

---------------------------------------------------------------------- Survival
a.Rotations.Survival = {
   Spec = 3,

   UsefulStats = { "Agility", "Melee Hit", "Crit", "Haste" },

   FlashInCombat = function()
      c.FlashAll(
         "Exhilaration",
         "Heart of the Phoenix",
         "Growl",
         "Last Stand",
         "Bullheaded",
         "Mend Pet at 50",
         "Counter Shot",
         "Tranquilizing Shot")
      c.PriorityFlash(
         "Serpent Sting",
         "Cobra Shot for Serpent Sting",
         "Stampede",
         "A Murder of Crows",
         "Black Arrow",
         "Dire Beast",
         "Kill Shot",
         "Explosive Shot",
         "Glaive Toss",
         "Arcane Shot under Thrill of the Hunt",
         "Powershot",
         "Arcane Shot for Survival",
         "Rapid Fire",
         "Barrage",
         "Mend Pet",
         "Cobra Shot",
         "Steady Shot for Leveling")
   end,

   FlashOutOfCombat = function()
      printOnce(warning, "SV")
      c.FlashAll("Mend Pet")
   end,

   FlashAlways = function()
      c.FlashAll("Call Pet", "Revive Pet")
   end,

   CastQueued = castQueued,

   ExtraDebugInfo = function()
      return string.format("%.1f", a.Focus)
   end,
}
