local _, a = ...
-- local L = a.Localize
local s = SpellFlashAddon
local x = s.UpdatedVariables
local g = BittensGlobalTables
local c = g.GetTable("BittensSpellFlashLibrary")
local u = g.GetTable("BittensUtilities")

local GetComboPoints = GetComboPoints
local GetEclipseDirection = GetEclipseDirection
local GetPowerRegen = GetPowerRegen
local GetSpecialization = GetSpecialization
local GetTime = GetTime
local SPELL_POWER_ECLIPSE = SPELL_POWER_ECLIPSE
local SPELL_POWER_ENERGY = SPELL_POWER_ENERGY
local SPELL_POWER_RAGE = SPELL_POWER_RAGE
local UnitGUID = UnitGUID
local UnitPower = UnitPower
local UnitName = UnitName
local UnitPowerMax = UnitPowerMax
local format = string.format
local min = math.min
local max = math.max
local select = select
local wipe = wipe
local infinity = math.huge
local asin = math.asin
local abs = math.abs

local primalPending = 0
local primalPendingFromMangle = false

local function monitorPendPrimalRage(spellID, _, _, critical)
   if critical
      and c.IdMatches(spellID, "Auto Attack", "Mangle")
      and s.Form(c.GetID("Bear Form")) then

      primalPending = GetTime()
      primalPendingFromMangle = c.IdMatches(spellID, "Mangle")
      c.Debug("Event", "Primal Fury Rage Pending")
   end
end

local function monitorConsumePrimalRage(spellID)
   if c.IdMatches(spellID, "Primal Fury Rage") then
      primalPending = 0
      c.Debug("Event", "Primal Fury Rage Happened")
   end
end

local function calcRage()
   a.Rage = c.GetPower(0, SPELL_POWER_RAGE)
   local bump = 0
   local soulMultiplier = c.HasTalent("Soul of the Forest") and GetSpecialization() == 3
         and 1.3
         or 1
   if GetTime() - primalPending < .8 then
      bump = 15
      if primalPendingFromMangle then
         bump = bump * soulMultiplier
      end
   end
   if c.IsQueued("Mangle") then
      bump = bump + 5 * soulMultiplier
   end
   a.Rage =  min(s.MaxPower("player"), a.Rage + bump)
   a.EmptyRage = s.MaxPower("player") - a.Rage
end

a.Rotations = {}

function a.PreFlash()
   a.CatForm = s.Form(c.GetID("Cat Form"))
   a.BearForm = s.Form(c.GetID("Bear Form"))
end


----------------------------------------------------------------------- Balance
-- phase at which we hit our lunar peak, used to estimate the initial segment
-- before we get accurate timings on our eclipse cycle times.
local phi_lunar = asin(100 / 105)
local half_pi = math.pi / 2

-- the last time that we hit a power peak event.
local lastSolar = 0
local lastLunar = 0

-- initialize our various numerics statically
a.nextLunar = infinity
a.nextSolar = infinity
a.nextChange = infinity
a.eclipseEnergy = 0

a.Rotations.Balance = {
   Spec = 1,

   UsefulStats = {
      "Intellect", "Mastery", "Crit", "Haste", "Multistrike", "Versatility"
   },

   PreFlash = function()
      ------------------------------------------------------------------------
      -- eclipse prediction support, don't put anything after this
      a.eclipseEnergy = UnitPower("player", SPELL_POWER_ECLIPSE)
      local dir = GetEclipseDirection()
      if dir == "none" then
         a.nextLunar = infinity
         a.nextSolar = infinity
         a.nextChange = infinity

         lastLunar = 0
         lastSolar = 0

         return
      end

      -- one arc segment, four total for the cycle
      local segment = c.HasTalent("Euphoria") and 5 or 10
      local peak_to_flip = ((half_pi - phi_lunar) / half_pi) * segment

      -- if we just started moving, fake up timestamps for the last lunar peak
      -- a full cycle ago, and the last solar peak half a cycle ago, which
      -- would put us at zero moving toward lunar... which just so happens to
      -- be where we are.
      --
      -- this might mess stuff up if we actually live in the past or
      -- something, but whatever, we really don't.
      --
      -- @todo danielp 2015-02-15: will this be wrong if we load part way
      -- through an active cycle?  oh, yes, it will.  do I care?
      if lastLunar == 0 and lastSolar == 0 then
         local progress = (asin(abs(a.eclipseEnergy) / 105) / half_pi) * segment

         lastLunar = GetTime() - progress - segment * 3 - peak_to_flip
         lastSolar = lastLunar + segment * 2
      end

      -- figure out the timings of the next events based on our cycle time and
      -- current positions.
      a.nextLunar = a.eclipseEnergy <= -100 and 0 or (lastLunar + segment*4) - GetTime()
      a.nextSolar = a.eclipseEnergy >= 100  and 0 or (lastSolar + segment*4) - GetTime()

      -- finally, time to next swap, which is thankfully fixed in time
      a.nextChange = max(lastLunar, lastSolar) + peak_to_flip + segment - GetTime()
      if a.nextChange < 0 then
         a.nextChange = a.nextChange + segment * 2
      end
   end,

   AuraApplied = function(spellID, target)
      if target == UnitName("player") then
         if c.GetID("Solar Peak") == spellID then
            lastSolar = GetTime()
         elseif c.GetID("Lunar Peak") == spellID then
            lastLunar = GetTime()
         end
      end
   end,

   FlashInCombat = function()
      c.FlashAll(
         "Solar Beam",
         "Soothe"
      )

      c.DelayPriorityFlash(
         "Force of Nature: Balance",
         -- call_action_list,name=single_target,if=active_enemies=1
         -- call_action_list,name=aoe,if=active_enemies>1

         -- this is the single target action list

         "Starsurge",
         "Celestial Alignment",
         "Incarnation: Chosen of Elune",
         "Sunfire",
         "Stellar Flare",
         "Moonfire",
         "Wrath",
         "Starfire"
      )
   end,

   FlashOutOfCombat = function()
      c.FlashAll("Healing Touch")

      if x.EnemyDetected then
         c.DelayPriorityFlash(
            "Starfire",
            "Moonfire",
            "Sunfire"
         )
      end
   end,

   FlashAlways = function()
      c.FlashAll(
         "Mark of the Wild",
         "Moonkin Form"
      )
   end,

   ExtraDebugInfo = function()
      return format(
         "l:%.2f s:%.2f c:%.2f",
         a.nextLunar,
         a.nextSolar,
         a.nextChange
      )
   end,
}

------------------------------------------------------------------------- Feral
local function commonBleed()
   return 1
      * (c.HasBuff("Savage Roar") and 1.4 or 1)
      * (c.HasBuff("Tiger's Fury") and 1.15 or 1)
      * (c.HasBuff("Bloodtalons") and 1.3 or 1)
end

-- tracking the damage multipliers for targets
local rip = {}
local function registerRipBleed(id, cp)
   local data = u.GetOrMakeTable(rip, id)
   data.cp = cp
   data.strength = commonBleed()
   c.Debug("Event", format("Rip %d@%d on %s", data.cp, data.strength, id))
end

local function removeRipBleed(id)
   local data = rip[id]
   if data then
      data.cp = 0
      data.strength = 0
   end
end

function a.ripWouldBeStronger(cp)
   local guid = UnitGUID("target")
   if not guid then
      return false
   end

   local current = rip[guid]
   if not current then
      return false
   end

   -- less combo points == weaker damage, so no overwrite.
   if current.cp < cp then
      return false
   end

   local strength = commonBleed()

   return strength > current.strength
      or (strength == current.strength and a.Rip <= 7.2)
end


local rake = {}
local function registerRakeBleed(id)
   local stealth = c.HasSpell("Improved Rake")
      and (c.HasBuff("Prowl")
              or c.HasBuff("Shadowmeld")
              or c.HasBuff("Incarnation: King of the Jungle"))

   local strength = commonBleed() * (stealth and 2 or 1)

   if id then
      rake[id] = strength
      c.Debug("Event", format("Rake @%d on %s", strength, id))
   end

   return strength
end

local function removeRakeBleed(id)
   rake[id] = 0
end

function a.rakeWouldBeStronger(bonus)
   local guid = UnitGUID("target")
   if not guid then return false end

   local current = rake[guid] or 0
   local strength = registerRakeBleed() * (bonus or 1)

   return strength > current
      or (strength == current and a.Rake <= 4.5)
end

a.Rotations.Feral = {
   Spec = 2,

   UsefulStats = { "Agility", "Multistrike", "Crit", "Haste", "Versatility" },

   PreFlash = function()
      a.Regen = select(2, GetPowerRegen())
      a.Energy = UnitPower("player", SPELL_POWER_ENERGY)
      a.MaxEnergy = UnitPowerMax("player", SPELL_POWER_ENERGY)
      a.MissingEnergy = a.MaxEnergy - a.Energy

      -- @todo danielp 2015-01-24: GetUnitPower("player", 4) ??
      a.ComboPoints = GetComboPoints("player", "target")

      a.Rake = c.GetMyDebuffDuration("Rake Bleed")
      a.Rip = c.GetMyDebuffDuration("Rip")
      a.SavageRoar = c.GetBuffDuration("Savage Roar")

      a.InExecute = c.GetHealthPercent("target") <= 25
   end,

   FlashInCombat = function()
      c.FlashAll(
         "Force of Nature: Feral",
         "Renewal",
         "Soothe",
         "Skull Bash",
         "Survival Instincts under 30"
      )

      -- if you ain't in it, we can't do much more. :)
      if c.FlashAll("Cat Form") then
         return
      end

      c.DelayPriorityFlash(
         "Wild Charge: Cat",
         -- displacer_beast,if=movement.distance>10
         -- dash,if=movement.distance&buff.displacer_beast.down&buff.wild_charge_movement.down
         "Rake with stealth",
         "Tiger's Fury",
         "Incarnation: King of the Jungle",
         "Berserk for Feral",
         "Shadowmeld for Feral",
         "Ferocious Bite to extend Rip",
         "Healing Touch for Bloodtalons",
         "Savage Roar to refresh",
         "Thrash (Cat Form)",
         "Thrash (Cat Form) AoE delay",

         -- finisher
         "Rip",
         "Savage Roar",
         "Thrash (Cat Form) at 5",
         "Ferocious Bite at 5",

         -- maintain
         "Rake",
         "Moonfire for Feral",
         "Rake Late",

         -- generate
         "Swipe",
         "Shred"
      )
   end,

   FlashOutOfCombat = function()
      c.FlashAll(
         "Healing Touch"
      )

      if x.EnemyDetected then
         c.DelayPriorityFlash(
            "Healing Touch for Bloodtalons pre-pull",
            "Cat Form",
            "Prowl",
            "Incarnation: King of the Jungle pre-pull",
            "Wild Charge: Cat",
            "Rake with stealth",
            "Swipe",
            "Shred"
         )
      end
   end,

   FlashAlways = function()
      c.FlashAll("Mark of the Wild")
   end,

   LeftCombat = function()
      wipe(rip)
      wipe(rake)
   end,

   CastSucceeded_FromLog = function(spellID, _, targetID)
      if c.IdMatches(spellID, "Rip") then
         -- 4 is the combo points magic number
         registerRipBleed(targetID, UnitPower("player", 4))
      elseif c.IdMatches(spellID, "Rake") then
         registerRakeBleed(targetID)
      end
   end,

   AuraRemoved = function(spellID, _, targetID)
      if c.IdMatches(spellID, "Rip") then
         removeRipBleed(targetID)
      elseif c.IdMatches(spellID, "Rake") then
         removeRakeBleed(targetID)
      end
   end,

   -- ExtraDebugInfo = function()
   --    return format(
   --       "b:%.1f r:%.1f e:%.1f c:%d c:%s s:%.1f d:%d b:%.1f t:%.1f k:%.1f r:%.1f r:%.1f x:%s",
   --       c.GetBusyTime(),
   --       a.Rage,
   --       a.Energy,
   --       a.CP,
   --       tostring(not not a.Clearcasting),
   --       a.Swiftness,
   --       a.DreamStacks,
   --       a.Berserk,
   --       a.TigersFury,
   --       a.King,
   --       a.Rip,
   --       a.Roar,
   --       tostring(not not a.InExecute))
   -- end,
}

---------------------------------------------------------------------- Guardian
a.Rotations.Guardian = {
   Spec = 3,
   -- AoEColor = "aqua",

   UsefulStats = {
      "Stamina", "Bonus Armor", "Mastery", "Versatility", "Multistrike", "Haste", "Crit"
   },

   FlashInCombat = function()
      calcRage()

      c.FlashMitigationBuffs(
         1,
         "Tooth and Claw",
         c.COMMON_TANKING_BUFFS,
         "Healing Touch Mitigation Delay",
         "Cenarion Ward for Guardian",
         "Bristling Fur",
         "Barkskin",
         "Renewal for Guardian",
         "Survival Instincts Glyphed",
         "Incarnation: Son of Ursoc",
         "Survival Instincts Unglyphed"
      )

      c.FlashAll(
         "Frenzied Regeneration",
         "Savage Defense",
         "Maul for Guardian",
         "Skull Bash",
         "Growl"
      )

      c.DelayPriorityFlash(
         "Berserk for Guardian",
         "Heart of the Wild: Guardian",
         "Rejuvenation for Guardian",
         "Nature's Vigil",
         "Healing Touch for Guardian",
         "Pulverize",
         "Lacerate for Pulverize",
         -- incarnation
         "Lacerate for Debuff",
         "Thrash (Bear Form) if down",
         "Mangle",
         "Thrash (Bear Form) early",
         "Lacerate"
      )
   end,

   FlashOutOfCombat = function()
      c.FlashAll("Healing Touch")
   end,

   FlashAlways = function()
      c.FlashAll("Mark of the Wild", "Bear Form")
   end,

   SpellDamage = monitorPendPrimalRage,

   AutoAttack = monitorPendPrimalRage,

   Energized = monitorConsumePrimalRage,

   ExtraDebugInfo = function()
      return format("r:%.1f b:%.2f", a.Rage, c.GetBusyTime())
   end,
}

------------------------------------------------------------------- Restoration
a.Rotations.Restoration = {
   Spec = 4,

   UsefulStats = { "Intellect", "Spirit", "Crit", "Haste" },

   FlashInCombat = function()
      c.FlashAll(
         "Force of Nature: Restoration",
         "Lifebloom",
         "Healing Touch for Restoration",
         "Regrowth",
         "Wild Mushroom: Restoration",
         "Renewal",
         "Cenarion Ward for Restoration",
         "Soothe")
   end,

   FlashAlways = function()
      c.FlashAll("Mark of the Wild")
   end,

   AuraApplied = function(spellID, target)
      if c.IdMatches(spellID, "Lifebloom") then
         a.LifebloomTarget = target
         c.Debug("Event", "Lifebloom on", target)
      end
   end,
}
