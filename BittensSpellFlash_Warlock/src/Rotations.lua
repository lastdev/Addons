local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local x = s.UpdatedVariables
local g = BittensGlobalTables
local c = g.GetTable("BittensSpellFlashLibrary")
local u = g.GetTable("BittensUtilities")

local GetSpellBonusDamage = GetSpellBonusDamage
local GetSpellCritChance = GetSpellCritChance
local GetTime = GetTime
local MAX_POWER_PER_EMBER = MAX_POWER_PER_EMBER
local GetMastery = GetMastery
local SPELL_POWER_BURNING_EMBERS = SPELL_POWER_BURNING_EMBERS
local SPELL_POWER_DEMONIC_FURY = SPELL_POWER_DEMONIC_FURY
local SPELL_POWER_SOUL_SHARDS = SPELL_POWER_SOUL_SHARDS
local UnitGUID = UnitGUID
local UnitPower = UnitPower
local max = math.max
local pairs = pairs
local select = select
local string = string
local tostring = tostring
local unpack = unpack

a.Rotations = {}

local function flashSummon(...)
   if c.HasTalent("Grimoire of Sacrifice") then
      if not c.SelfBuffNeeded("Grimoire of Sacrifice") then
         return
      end

      if x.PetAlive then
         s.Flash(c.GetID("Grimoire of Sacrifice"), "yellow")
         return
      end
   elseif x.PetAlive then
      return
   end

--      local current = a.GetCurrentPet()
--      for i = 1, select("#", ...) do
--         if select(i, ...) == current then
--            return
--         end
--      end

   s.Flash(c.GetID("Summon Demon"), "yellow")
   for i = 1, select("#", ...) do
      s.Flash(c.GetID("Summon " .. select(i, ...)), "yellow")
   end
end

-------------------------------------------------------------------- Affliction
local empoweredSoCTarget
local agonyMiss = 0
local agonySuccess = 0
local agonyTarget
a.SwapCast = 0

a.Rotations.Afliction = {
   Spec = 1,

   UsefulStats = { "Intellect", "Crit", "Haste", "Multistrike" },

   PreFlash = function()
      a.Shards = s.Power("player", SPELL_POWER_SOUL_SHARDS)
      if c.IsCasting("Soulburn", "Haunt") then
         a.Shards = a.Shards - 1
      end

      a.DarkSoul = c.HasBuff("Dark Soul: Misery", false, false, true)
   end,

   FlashInCombat = function()
      -- if empoweredSoCTarget ~= nil
      --    or (c.IsQueued("Seed of Corruption")
      --       and c.HasBuff("Soulburn", false, false, true)) then
      -- 
      --    a.SoCExplosionPending = true
      -- else
      --    a.SoCExplosionPending = false
      --    local now = GetTime()
      --    for _, snap in pairs(u.GetOrMakeTable(a.Snapshots, "Seed of Corruption")) do
      --       if snap.Exploded ~= nil and snap.Exploded > snap.Applied then
      --          if now - snap.Exploded < 1 then
      --             a.SoCExplosionPending = true
      --          end
      --       elseif now - snap.Applied < 20 then
      --          a.SoCExplosionPending = true
      --       end
      --    end
      -- end

      c.FlashAll(
         "Dark Soul: Misery",
         "Grimoire: Felhunter",
         "Clone Magic",
         "Devour Magic",
         "Spell Lock",
         "Optical Blast",
         "Command Spell Lock",
         "Soulshatter")

      if s.HealthPercent() <= 20 then
         c.DelayPriorityFlash(
            "Soulburn during Execute",
            "Haunt during Execute",
            "Soul Swap",
            "Life Tap for Affliction",
            "Drain Soul"
         )
      else
         c.DelayPriorityFlash(
            "Soulburn under Dark Soul: Misery",
            "Soul Swap",
            "Agony within GCD",
            "Haunt",
            "Corruption within GCD",
            "Unstable Affliction within GCD",
            "Agony Soon",
            "Unstable Affliction Soon",
            "Corruption Soon",
            "Life Tap for Affliction",
            "Drain Soul"
         )
      end
   end,

   FlashAlways = function()
      c.FlashAll(
         "Dark Intent",
         "Soulstone",
         "Dark Regeneration",
         "Unending Breath")
      flashSummon("Felhunter", "Observer")
   end,

   FlashOutOfCombat = function()
      c.FlashAll("Life Tap", "Soul Swap")

      if x.EnemyDetected then
         c.DelayPriorityFlash("Cataclysm", "Haunt", "Corruption within GCD")
      end
   end,

   -- CastStarted = function(info)
   --    if c.InfoMatches(info, "Seed of Corruption") then
   --       if c.HasBuff("Soulburn") then
   --          empoweredSoCTarget = UnitGUID(s.UnitSelection())
   --       else
   --          empoweredSoCTarget = nil
   --       end
   --       c.Debug("Event", "Seed of Corruption cast start", empoweredSoCTarget)
   --    end
   -- end,

   -- CastFailed = function(info, quiet)
   --    if not quiet and c.InfoMatches(info, "Seed of Corruption") then
   --       empoweredSoCTarget = nil
   --       c.Debug("Event", "Seed of Corruption Failed")
   --    end
   -- end,

   -- CastSucceeded = function(info)
   --    if c.InfoMatches(info, "Seed of Corruption") and empoweredSoCTarget then
   --       u.GetOrMakeTable(
   --          a.Snapshots,
   --          "Seed of Corruption",
   --          empoweredSoCTarget).Applied = GetTime()
   --       empoweredSoCTarget = nil
   --       c.Debug("Event", "Empowered SoC Applied")
   --    end
   -- end,

   -- Agony uses AuraApplied when stacking, but not when re-applying
   -- Agony SUCCESS -> Agony MISSED
   -- Agony MISSED -> Soul Swap SUCCESS

   -- CastSucceeded_FromLog = function(spellID, _, targetID)
   --    if c.IdMatches(spellID, "Agony", "Soul Swap Soulburn") then
   --       agonySuccess = GetTime()
   --       agonyTarget = targetID
   --       if c.IdMatches(spellID, "Soul Swap Soulburn") then
   --          a.SwapCast = GetTime()
   --       end
   --    end
   -- end,
   -- 
   -- SpellMissed = function(spellID)
   --    if c.IdMatches(spellID, "Agony") then
   --       agonyMiss = GetTime()
   --    end
   -- end,

   -- AuraApplied = function(spellID, _, targetID)
   --    if c.IdMatches(spellID, "Corruption", "Unstable Affliction") then
   --       recordSnapshot(spellID, nil, targetID)
   --       a.SwapCast = 0
   --    end
   -- end,

   -- AuraRemoved = function(spellID, _, targetID)
   --    if c.IdMatches(spellID, "Seed of Corruption") then
   --       local now = GetTime()
   --       local snap = u.GetFromTable(
   --          a.Snapshots, "Seed of Corruption", targetID)
   --       if snap ~= nil and now - snap.Applied < 20 then
   --          snap.Exploded = now
   --          c.Debug("Event", "Empowered SoC Exploded")
   --       end
   --    end
   -- end,

   -- LeftCombat = function()
   --    c.Debug("Event", "Left Combat")
   -- end,

   ExtraDebugInfo = function()
      return string.format("%.1f %s", a.Shards, tostring(a.SoCExplosionPending))
   end,
}

-------------------------------------------------------------------- Demonology
local furyBonuses = {
   ["Shadow Bolt"] = 25,
   ["Soul Fire"] = 30,
}

local furyCosts = {
   ["Touch of Chaos"] = 40,
   ["Doom"] = 60,
   ["Soul Fire"] = 80,
}

local furyTick = {
   ["Shadowflame"] = 2,
   ["Corruption"] = 4,
}

local function bumpFury(amount)
   if c.WearingSet(4, "T15") then
      amount = amount * 1.1
   end
   a.Fury = a.Fury + amount
end

a.Rotations.Demonology = {
   Spec = 2,

   UsefulStats = { "Intellect", "Multistrike", "Crit", "Haste" },

   PreFlash = function()
      a.Fury = s.Power("player", SPELL_POWER_DEMONIC_FURY)
      a.DarkSoul = c.GetBuffDuration("Dark Soul: Knowledge", false, false, true)
      a.Morphed = s.Form(c.GetID("Metamorphosis"))
      if a.Morphed then
         for name, cost in pairs(furyCosts) do
            if c.IsCasting(name) then
               a.Fury = a.Fury - cost
            end
         end
      else
         for name, bonus in pairs(furyBonuses) do
            if c.IsCasting(name) then
               bumpFury(bonus)
            end
         end
      end
   end,

   FlashInCombat = function()
      -- local busy = c.GetBusyTime()
      -- for name, bonus in pairs(furyTick) do
      --    local dur = c.GetMyDebuffDuration(name)
      --    local tick = u.GetFromTable(
      --       a.Snapshots, name, UnitGUID(s.UnitSelection()), "Tick")
      --    if dur > 0 and tick ~= nil and busy > dur % tick then
      --       bumpFury(bonus)
      --    end
      -- end

      -- @todo danielp 2014-11-11: simcraft branches on "DemonBolt enabled" in
      -- the middle, we should also support that.

      c.DelayPriorityFlash(
         "Mannoroth's Fury",
         -- dark_soul,if=talent.demonbolt.enabled&(charges=2|target.time_to_die<buff.demonbolt.remains|(!buff.demonbolt.remains&demonic_fury>=790))
         "Dark Soul: Knowledge",
         "Imp Swarm",
         "Felstorm",
         "Wrathstorm",
         "Hand of Gul'dan",
         -- hand_of_guldan,if=!in_flight&dot.shadowflame.remains<travel_time+3&buff.demonbolt.remains<gcd*2&charges>=2&action.dark_soul.charges>=1
         -- service_pet,if=talent.grimoire_of_service.enabled&!talent.demonbolt.enabled
         "Summon Doomguard",
         "Summon Infernal",
         -- call_action_list,name=db,if=talent.demonbolt.enabled
         "Cataclysm with Metamorphosis",
         "Doom",
         "Corruption for Demonology",
         "Metamorphosis Cancel",
         "Chaos Wave",
         "Soul Fire with Metamorphosis",
         "Touch of Chaos",
         "Metamorphosis",
         "Metamorphosis Cancel Unconditionally",
         "Soul Fire with Molten Core",
         "Life Tap",
         "Shadow Bolt"
      )
   end,

   FlashAlways = function()
      c.FlashAll(
         "Dark Intent",
         "Soulstone",
         "Dark Regeneration",
         "Unending Breath")
      flashSummon("Felguard", "Wrathguard")
   end,

   FlashOutOfCombat = function()
      c.FlashAll("Life Tap")

      if x.EnemyDetected then
         c.DelayPriorityFlash("Soul Fire")
      end
   end,

   ExtraDebugInfo = function()
      return string.format("%s %s", tostring(a.Fury), tostring(a.Morphed))
   end,
}

------------------------------------------------------------------- Destruction
local lastEmbers = nil
local pendingEmberBump = 0
local pendingEmberDrop = 0

a.RoFCast = 0
a.Embers = 0
a.Backdraft = 0

function a.T15EmberCost()
   return c.WearingSet(2, "T15") and 0.8 or 1
end

-- @todo danielp 2014-11-09: implement shadowburn *without* charred_remains.
-- @todo danielp 2014-11-10: implement havoc O_o
-- @todo danielp 2014-11-10: sync with icy-veins and other guides, since SimC
-- is... kinda shitty, and missed some core things.
local DestructionSingleTarget = {
   -- /Shadowburn,if=talent.charred_remains.enabled&(burning_ember>=2.5|target.time_to_die<20|trinket.proc.intellect.react|(trinket.stacking_proc.intellect.remains<cast_time*4&trinket.stacking_proc.intellect.remains>cast_time))
   "Cataclysm",
   "Immolate",
   "Conflagrate at Cap",
   -- /chaos_bolt,if=set_bonus.tier17_4pc=1&buff.chaotic_infusion.react
   -- /chaos_bolt,if=set_bonus.tier17_2pc=1&buff.backdraft.stack<3&(burning_ember>=2.5|(trinket.proc.intellect.react&trinket.proc.intellect.remains>cast_time)|buff.dark_soul.up)
   -- /chaos_bolt,if=talent.charred_remains.enabled&buff.backdraft.stack<3&(burning_ember>=2.5|(trinket.proc.intellect.react&trinket.proc.intellect.remains>cast_time)|buff.dark_soul.up)
   "Chaos Bolt",
   "Immolate to extend",
   "Rain of Fire Single Target",
   "Conflagrate Single Target",
   "Incinerate"
}

local DestructionAoE = {
   "Cataclysm",
   "Fire and Brimstone",
   "Immolate",
   "Conflagrate at Cap",
   "Chaos Bolt",
   "Immolate to extend",
   "Rain of Fire",
   "Conflagrate",
   "Incinerate"
}

a.Rotations.Destruction = {
   Spec = 3,

   UsefulStats = { "Intellect", "Multistrike", "Crit", "Haste" },

   PreFlash = function()
      a.Embers = UnitPower("player", SPELL_POWER_BURNING_EMBERS, true) / MAX_POWER_PER_EMBER
      a.DarkSoul = c.GetBuffDuration("Dark Soul: Instability", false, false, true)

      if lastEmbers ~= nil then
         if a.Embers > lastEmbers then
            pendingEmberBump = max(0, pendingEmberBump - (a.Embers - lastEmbers))
            c.Debug("Flash", "Ember bump occurred")
         elseif a.Embers < lastEmbers then
            pendingEmberDrop = 0
            c.Debug("Flash", "Ember drop occurred")
         end
      end
      lastEmbers = a.Embers
      a.Embers = a.Embers + pendingEmberBump - pendingEmberDrop

      if c.IsCasting("Incinerate", "Conflagrate") then
         a.Embers = a.Embers + .1
      elseif c.IsCasting("Chaos Bolt", "Shadowburn") then
         a.Embers = a.Embers - a.T15EmberCost()
      elseif c.IsCasting("Fire and Brimstone") then
         a.Embers = a.Embers - 1
      end

      a.Backdraft = c.GetBuffStack("Backdraft")
      if a.Backdraft > 0 and c.IsCasting("Incinerate") then
         a.Backdraft = a.Backdraft - 1
      elseif c.IsCasting("Conflagrate") then
         a.Backdraft = a.Backdraft + 3
      end
   end,

   FlashAlways = function()
      c.FlashAll(
         "Dark Intent",
         "Soulstone",
         "Dark Regeneration",
         "Unending Breath")

      -- @todo danielp 2014-11-09: handle Demonic Servitude
      flashSummon("Felhunter", "Observer")
   end,

   FlashOutOfCombat = function()
      if not x.EnemyDetected then return end
      c.DelayPriorityFlash(
         "Chaos Bolt",
         "Incinerate"
      )
   end,

   FlashInCombat = function()
      c.FlashAll(
         "Dark Soul: Instability",
         "Grimoire: Felhunter",
         "Ember Tap",
         "Clone Magic",
         "Devour Magic",
         "Spell Lock",
         "Optical Blast",
         "Command Spell Lock",
         "Soulshatter")

      c.DelayPriorityFlash(
         "Mannoroth's Fury",
         "Dark Soul: Instability",
         "Summon Doomguard",
         "Summon Infernal",
         -- 'unpack' must be the last argument if this is to work.
         unpack(c.EstimatedHarmTargets > 3 and DestructionAoE or DestructionSingleTarget)
      )

   end,

   CastSucceeded = function(info)
      if c.InfoMatches(
         info,
         "Incinerate",
         "Conflagrate",
         "Incinerate AoE",
         "Conflagrate AoE") then

         pendingEmberBump = pendingEmberBump + .1
         c.Debug("Event", "Ember bump pending:", info.Name)
      elseif c.InfoMatches(info, "Chaos Bolt", "Shadowburn") then
         pendingEmberDrop = a.T15EmberCost()
         c.Debug("Event", "Ember drop pending:", info.Name)
      elseif c.InfoMatches(info, "Fire and Brimstone") then
         pendingEmberDrop = 1
         c.Debug("Event", "Ember drop pending:", info.Name)
      elseif c.InfoMatches(info, "Rain of Fire") then
         a.RoFCast = GetTime()
      end
   end,

   SpellDamage = function(spellID, target, _, critical)
--c.Debug("Event", "Damage:", spellID, s.SpellName(spellID), target, amount, critical)
      if critical
         and (spellID == c.GetID("Incinerate")
            or spellID == c.GetID("Conflagrate")
            or spellID == c.GetID("Immolate")
            or spellID == c.GetID("Incinerate AoE")
            or spellID == c.GetID("Conflagrate AoE")
            or spellID == c.GetID("Immolate AoE")) then

         pendingEmberBump = pendingEmberBump + .1
         c.Debug("Event", "Ember bump pending from crit")
      end
   end,

   AuraApplied = function(spellId, _, targetId)
      if c.IdMatches(spellId, "Rain of Fire") then
         a.RoFCast = 0
      -- else
      --    if spellId == c.GetID("Immolate AoE") then
      --       spellId = c.GetID("Immolate")
      --    end
      --    -- recordSnapshot(spellId, _, targetId)
      end
   end,

   LeftCombat = function()
      lastEmbers = nil
      pendingEmberBump = 0
      pendingEmberDrop = 0
      c.Debug("Event", "Left combat")
   end,

   ExtraDebugInfo = function()
      return string.format("%.1f %d %.1f %d m:%d",
         a.Embers,
         a.Backdraft,
         pendingEmberBump,
         pendingEmberDrop,
         c.GetPowerPercent())
   end,
}
