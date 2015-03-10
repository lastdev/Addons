local _, a = ...
local s = SpellFlashAddon
local x = s.UpdatedVariables
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")
-- local u = BittensGlobalTables.GetTable("BittensUtilities")

local GetPowerRegen = GetPowerRegen
local GetTime = GetTime
local SPELL_POWER_FOCUS = SPELL_POWER_FOCUS
local select = select
local string = string
local unpack = unpack
local max = math.max

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
      -- this starts a steady focus pattern
      a.startedSteadyFocus = true
   elseif c.InfoMatches(info, "Kill Command") then
      -- no change, ignored for steady focus
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

   a.BestialWrath = c.HasBuff("Bestial Wrath")

   a.TotH = c.GetBuffStack("Thrill of the Hunt")
   if c.IsCasting("Arcane Shot")
      or c.IsCasting("Arcane Shot")
      or c.IsCasting("Multi-Shot")
   then
      a.TotH = max(a.TotH - 1, 0)
   end
end

-- This is a workaround for a bug in 6.0.3, see
-- http://us.battle.net/wow/en/forum/topic/15699089759?page=1
--
-- note: the root of the problem seems to be the API that takes only
-- spellbook, or spell name, references, and the fact that the perk replaces
-- Kill Shot with a different spell ID -- but we can't get *that* one, we get
-- the first one when we call in.
--
-- Consider updating SpellFlash to support cooldowns, etc, by spell ID using
-- the same "translate to spellbook references" hack that libspellcooldown etc
-- did to make this work better.
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
a.KillCommandFailed = false

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
         "Mend Pet in combat",
         "Counter Shot",
         "Tranquilizing Shot"
      )

      c.DelayPriorityFlash(
         "Focus Fire",
         "Stampede",
         "Bestial Wrath",
         "Barrage for AoE",
         "Multi-Shot for BM",
         "Kill Shot",
         "Kill Command",
         "Barrage for BM",
         "Arcane Shot during BW",
         "Glaive Toss",
         "Powershot",
         "A Murder of Crows",
         "Dire Beast",
         "Explosive Trap",
         -- dump excess focus
         "Arcane Shot for BM",
         -- build focus
         "Focusing Shot",
         "Cobra Shot",
         "Steady Shot"
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
      killShotBugWorkaround()

      if c.InfoMatches(info, "Kill Command") then
         c.Debug("Event", "Kill Command cast was a success")
         a.KillCommandFailed = false
      end
   end,

   CastFailed = function(info)
      if c.InfoMatches(info, "Kill Command") then
         c.Debug("Event", "Kill Command cast was a failure")
         a.KillCommandFailed = true
      end
   end,

   ExtraDebugInfo = function()
      return string.format("%.1f", a.Focus)
   end
}

------------------------------------------------------------------ Marksmanship
a.Rotations.Marksmanship = {
   Spec = 2,

   UsefulStats = { "Agility", "Crit", "Multistrike", "Versatility", "Haste", "Mastery" },

   CarefulAimRotation = {
      "Glaive Toss for AoE",
      "Powershot for AoE",
      "Barrage for AoE",
      "Aimed Shot",
      "Focusing Shot",
      "Steady Shot"
   },

   NormalRotation = {
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
      "Mend Pet",
      "Focusing Shot",
      "Steady Shot"
   },

   FlashInCombat = function()
      -- flash
      c.FlashAll(
         "Exhilaration",
         "Heart of the Phoenix",
         "Growl",
         "Last Stand",
         "Bullheaded",
         "Mend Pet in combat",
         "Counter Shot",
         "Tranquilizing Shot"
      )

      local useCarefulAim = not c.GetOption("NoCarefulAim")
         and (c.HasBuff("Rapid Fire") or c.GetHealthPercent("target") >= 80)

      c.DelayPriorityFlash(
         "Steady Shot for Steady Focus",
         "Chimaera Shot",
         "Kill Shot",
         "Rapid Fire",
         "Stampede for MM",
         -- must be the last line for this to work.
         unpack(useCarefulAim
                   and a.Rotations.Marksmanship.CarefulAimRotation
                    or a.Rotations.Marksmanship.NormalRotation)
      )
   end,

   FlashOutOfCombat = function()
      c.FlashAll("Mend Pet")

      if x.EnemyDetected then
         c.PriorityFlash(
            "Glaive Toss",
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
         "Mend Pet in combat",
         "Counter Shot",
         "Tranquilizing Shot"
      )

      c.DelayPriorityFlash(
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
         "Steady Shot"
      )
   end,

   FlashOutOfCombat = function()
      c.FlashAll("Mend Pet")

      if x.EnemyDetected then
         c.DelayPriorityFlash(
            "A Murder of Crows",
            "Explosive Shot",
            "Black Arrow",
            "Arcane Shot for Survival",
            "Focusing Shot",
            "Cobra Shot",
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

   ExtraDebugInfo = function()
      return string.format("%.1f", a.Focus)
   end,
}
