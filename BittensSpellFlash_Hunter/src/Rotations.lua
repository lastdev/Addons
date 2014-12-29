local addonName, a = ...
local s = SpellFlashAddon
local x = s.UpdatedVariables
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")
local u = BittensGlobalTables.GetTable("BittensUtilities")

local GetPowerRegen = GetPowerRegen
local GetTime = GetTime
local SPELL_POWER_FOCUS = SPELL_POWER_FOCUS
local select = select
local string = string
local unpack = unpack

local focusAdded = {
   ["Focusing Shot"] = 50,
   ["Steady Shot"] = 14,
   ["Cobra Shot"] = 14,
}

function a.FocusAdded(spell, delay)
   local focus = focusAdded[spell] or 0
   local steady = s.Buff(c.GetID("Steady Focus"), "player", delay)

   return focus * (steady and 1.5 or 1)
end

local function castQueued(info)
   -- adjust focus costs
   if c.InfoMatches(info, "Cobra Shot", "Steady Shot") then
      info.Cost[SPELL_POWER_FOCUS] = -a.FocusAdded(
         info.Name,
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

-- This is a workaround for a bug in 6.0.3, see
-- http://us.battle.net/wow/en/forum/topic/15699089759?page=1
a.ForceKillShotCooldown = 0
a.LastKillShot = 0

local function killShotBugWorkaround(info)
   if c.InfoMatches(info, "Kill Shot") then
      local now = GetTime()
      if (a.LastKillShot + 10) > now then
         -- we just used our CD reset
         a.ForceKillShotCooldown = now + 10
      end
      a.LastKillShot = now
   end
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

      killShotBugWorkaround(info)
   end,

   ExtraDebugInfo = function()
      return string.format("%.1f", a.Focus)
   end
}

------------------------------------------------------------------ Marksmanship
local MMCarefulAimRotation = {
   "Glaive Toss for AoE",
   "Powershot for AoE",
   "Barrage for AoE",
   "Aimed Shot",
   "Focusing Shot",
   "Steady Shot"
}

local MMNormalRotation = {
         -- rapid fire rotation here
         "Explosive Trap",
         "A Murder of Crows",
         "Dire Beast",
         "Glaive Toss",
         "Powershot",
         "Barrage",
         -- pool max focus for rapid fire so we can spam AimedShot with Careful Aim buff
         "Steady Shot to pool",
         "Focusing Shot to pool",
         "Multi-Shot for MM",
         "Aimed Shot",
         "Aimed Shot under Thrill of the Hunt",
         "Mend Pet",
         "Focusing Shot",
         "Steady Shot"
}

a.Rotations.Marksmanship = {
   Spec = 2,

   UsefulStats = { "Agility", "Crit", "Multistrike", "Versatility", "Haste", "Mastery" },

   FlashInCombat = function()
      a.CarefulAim =
         (c.HasBuff("Rapid Fire") or s.HealthPercent("target") >= 80)
         and not c.GetOption("NoCarefulAim")

      -- flash
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
         "Steady Shot for Steady Focus",
         "Chimaera Shot",
         "Kill Shot",
         "Rapid Fire",
         "Stampede for Marksmanship",
         -- must be the last line for this to work.
         unpack(a.CarefulAim and MMCarefulAimRotation or MMNormalRotation)
      )
   end,

   FlashOutOfCombat = function()
      c.FlashAll("Mend Pet")

      if x.EnemyDetected then
         c.PriorityFlash(
            "Glaive Toss",
            "A Murder of Crows",
            "Chimaera Shot",
            "Aimed Shot",
            "Focusing Shot",
            "Steady Shot"
         )
      end
   end,

   FlashAlways = function()
      if c.HasTalent("Lone Wolf") then
         c.FlashAll("Dismiss Pet")
      else
         c.FlashAll("Call Pet", "Revive Pet")
      end
   end,

   CastQueued = castQueued,
   CastSucceeded = killShotBugWorkaround,

   ExtraDebugInfo = function()
      return string.format("%.1f", a.Focus)
   end,
}

---------------------------------------------------------------------- Survival
a.Rotations.Survival = {
   Spec = 3,

   UsefulStats = { "Agility", "Multistrike", "Crit", "Haste" },

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
         "Black Arrow",
         "Explosive Shot",
         "Stampede",
         "A Murder of Crows",
         "Dire Beast",
         "Glaive Toss",
         "Barrage",
         "Powershot",
         "Arcane Shot under Thrill of the Hunt",
         "Multi-Shot for SV",
         "Arcane Shot for Survival",
         "Mend Pet",
         "Focusing Shot",
         "Cobra Shot",
         "Steady Shot for Leveling")
   end,

   FlashOutOfCombat = function()
      c.FlashAll("Mend Pet")
   end,

   FlashAlways = function()
      if c.HasTalent("Lone Wolf") then
         c.FlashAll("Dismiss Pet")
      else
         c.FlashAll("Call Pet", "Revive Pet")
      end
   end,

   CastQueued = castQueued,

   ExtraDebugInfo = function()
      return string.format("%.1f", a.Focus)
   end,
}
