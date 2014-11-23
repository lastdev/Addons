local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local g = BittensGlobalTables
local c = g.GetTable("BittensSpellFlashLibrary")
local u = g.GetTable("BittensUtilities")

local GetSpellBonusDamage = GetSpellBonusDamage
local UnitLevel = UnitLevel

local SPELL_POWER_HOLY_POWER = SPELL_POWER_HOLY_POWER

local min = math.min
local max = math.max
local select = select
local string = string
local type = type
local pairs = pairs
local ipairs = ipairs
local unpack = unpack

a.Rotations = { }

local selflessStackPending = false
local selflessClearPending = false

local HolyPowerChanges = {}
local function SetHolyPower(name, _cost, _buffs)
   if type(name) == "table" then
      for _, entry in pairs(name) do SetHolyPower(entry, _cost, _buffs) end
      return
   end

   HolyPowerChanges[s.SpellName(c.GetID(name))] = {
      cost = _cost,
      buffs = _buffs or {}
   }
end

local function PredictedHolyPower(info)
   local hp = s.Power("player", SPELL_POWER_HOLY_POWER)
   if not info then
      return hp
   end

   local data = HolyPowerChanges[info.Name]
   if not data then return 0 end

   local change = data.cost
   if type(change) == "function" then
      change = change()
   end

   -- buffs that make things free, which we can skip if this isn't gonna cost
   -- anything anyway, right?
   if change < 0 then
      for _, name in ipairs(data.buffs) do
         if s.Buff(c.GetID(name), "player") then
            change = 0
            break
         end
      end
   end

   -- Holy Avenger, any generation becomes three.
   if change > 0 and s.Buff(c.GetID("Holy Avenger"), "player") then
      change = 3
   end

   -- predict HP change, and clamp between zero and max, allowing for lower
   -- level players who only get 3 HP at once, not five.  Unlucky them, but at
   -- level 85 it seems worth the trouble of doing this as a courtesy to our
   -- poor levelling friends.
   local maxhp = UnitLevel("player") >= 85 and 5 or 3

   hp = hp + change
   return hp > maxhp and maxhp or hp < 0 and 0 or hp
end

SetHolyPower("Crusader Strike", 1)
SetHolyPower("Exorcism", 1)
SetHolyPower("Hammer of the Righteous", 1)
SetHolyPower("Holy Radiance", 1)
SetHolyPower("Holy Shock", 1)

SetHolyPower("Holy Wrath", function() return c.HasTalent("Sanctified Wrath - Prot") and 1 or 0 end)
SetHolyPower("Hammer of Wrath", function() return c.HasSpell("Sword of Light") and 1 or 0 end)
SetHolyPower("Avenger's Shield", function() return c.HasBuff("Grand Crusader") and 1 or 0 end)

SetHolyPower(
   "Judgment",
   function()
      if c.HasSpell("Templar's Verdict") or c.HasSpell("Judgments of the Wise") then
         return 1
      else
         return 0
      end
end)


SetHolyPower("Divine Storm", -3, {"Divine Purpose", "Divine Crusader"})
SetHolyPower("Final Verdict", -3, {"Divine Purpose"})
SetHolyPower("Light of Dawn", -3, {"Divine Purpose"})
SetHolyPower("Seraphim", -5) -- nothing will ever cost more than 3HP, lies!
SetHolyPower("Shield of the Righteous", -3, {"Divine Purpose"})
SetHolyPower("Templar's Verdict", -3, {"Divine Purpose"})

local function WordOfGloryCost()
   if s.Buff(c.GetID("Bastion of Power"), "player") and
      c.GetBuffStack("Bastion of Glory") >= 3
   then
      return 0
   else
      return 3
   end
end
SetHolyPower({"Word of Glory", "Eternal Flame"}, WordOfGloryCost, {"Divine Purpose", "Lawful Words"})



function a.PreFlash()
   -- @todo danielp 2014-11-08: do we also need to predict based on the
   -- casting of "Holy Radiance" here?  Used to, not sure if needed

   -- predict holy power based on spell queued
   a.HolyPower = PredictedHolyPower(c.GetQueuedInfo())

   -- selfless healer monitoring
   a.SelflessHealer = c.GetBuffStack("Selfless Healer")
   if c.HasTalent("Selfless Healer") then
      if selflessStackPending then
         a.SelflessHealer = min(3, a.SelflessHealer + 1)
      end

      if selflessClearPending then
         a.SelflessHealer = 0
      end

      if c.IsQueued("Judgment") then
         a.SelflessHealer = min(3, a.SelflessHealer + 1)
      elseif c.IsQueued("Flash of Light") then
         a.SelflessHealer = 0
      end
   end

   -- buff/cooldown timers
   a.Judgment = c.GetCooldown("Judgment", false, 6)
   if c.IsCasting("Crusader Strike", "Hammer of the Righteous") then
      a.Crusader = 4.5
   else
      a.Crusader = c.GetCooldown("Crusader Strike")
   end

   a.HoWPhase = s.HealthPercent() <= (c.HasSpell("Empowered Hammer of Wrath") and 35 or 20)
end

local function selflessTriggerMonitor(info)
   if c.HasTalent("Selfless Healer") then
      if c.InfoMatches(info, "Judgment") then
         selflessStackPending = true
         c.Debug("Event", "Selfless Healer stack pending")
      elseif c.InfoMatches(info, "Flash of Light") then
         selflessClearPending = true
         c.Debug("Event", "Selfless Healer clear pending")
      end
   end
end

local function clearSelflessPending(spellID, applicableSpell)
   if spellID == c.GetID(applicableSpell)
      and c.HasTalent("Selfless Healer") then

      selflessStackPending = false
      c.Debug("Event", "Selfless Healer stack applied (or failed)")
   end
end

local function clearSelflessMonitor(spellID)
   if c.HasTalent("Selfless Healer") then
      if spellID == c.GetID("Selfless Healer") then
         selflessClearPending = false
         c.Debug("Event", "Selfless Healer cleared")
      end
   end
end

local function flashRaidBuffs()
   local duration = 0
   if not s.InCombat() then
      if s.InRaidOrParty() then
         duration = 5 * 60
      else
         duration = 2 * 60
      end
   end

   -- if I have my own kings, make sure everyone else does too
   if s.MyBuff(c.GetID("Blessing of Kings"), "player") then
      if not s.Buff(c.STAT_BUFFS, "raid|all|range", duration) then
         c.FlashAll("Blessing of Kings")
      end
      return
   end

   -- if I have my own might, make sure everyone else does too
   if s.MyBuff(c.GetID("Blessing of Might"), "player") then
      if not s.Buff(c.MASTERY_BUFFS, "raid|all|range", duration) then
         c.FlashAll("Blessing of Might")
      end
      return
   end

   -- check the raid for both kings and might
   if not s.Buff(c.STAT_BUFFS, "raid|all|range", duration) then
      c.FlashAll("Blessing of Kings")
   end
   if not s.Buff(c.MASTERY_BUFFS, "raid|all|range", duration) then
      c.FlashAll("Blessing of Might")
   end
end

-------------------------------------------------------------------------- Holy
a.Rotations.Holy = {
   Spec = 1,

   UsefulStats = { "Intellect", "Spirit", "Crit", "Haste" },

   FlashInCombat = function()
      c.FlashAll(
         "Sacred Shield for Holy",
         "Word of Glory for Holy",
         "Light of Dawn for Holy",
         "Holy Shock under 5 with Daybreak",
         "Save Selfless Healer",
         "Consume Selfless Healer",
         "Rebuke")
   end,

   FlashAlways = function()
      c.FlashAll("Seal of Insight", "Beacon of Light")
      flashRaidBuffs()
   end,

   CastSucceeded = selflessTriggerMonitor,

   SpellMissed = function(spellID)
      clearSelflessPending(spellID, "Judgment")
   end,

   AuraApplied = function(spellID)
      if c.IdMatches(spellID, "Sacred Shield") then
         a.SacredShieldPower = GetSpellBonusDamage(2)
         c.Debug("Event", "Sacred Shield applied at", a.SacredShieldPower)
      end
   end,

   AuraRemoved = clearSelflessMonitor,

   AuraApplied = function(spellID, target)
      if c.IdMatches(spellID, "Beacon of Light") then
         a.BeaconTarget = target
         c.Debug("Event", "Beacon target:", target)
      elseif c.IdMatches(spellID, "Sacred Shield") then
         a.SacredShieldTarget = target
         c.Debug("Event", "Sacred Shield target:", target)
      else
         clearSelflessPending(spellID, "Selfless Healer")
      end
   end,
}

-------------------------------------------------------------------------- Prot
a.SacredShieldPower = 0

a.Rotations.Protection = {
   Spec = 2,

   UsefulStats = {
      "Stamina", "Haste", "Armor", "Crit", "Multistrike"
   },

   FlashInCombat = function()
      a.BastionOfPower = c.GetBuffDuration("Bastion of Power", false, false, true)
      a.DivinePurpose = c.GetBuffDuration("Divine Purpose", false, false, true)
      a.GrandCrusader = c.GetBuffDuration("Grand Crusader", false, false, true)

      c.FlashMitigationBuffs(
         1,
         "Shield of the Righteous",
         c.COMMON_TANKING_BUFFS,
         "Divine Protection Glyphed",
         "Holy Avenger",
         "Guardian of Ancient Kings",
         "Ardent Defender 2pT14",
         "Ardent Defender"
         -- ...and these are from the old list, not on Theck's balanced list.
         -- "Divine Shield",
         -- "Holy Avenger Damage Mode",
         -- "Holy Prism for Prot",
         -- "Hand of Purity",
         -- -- "Light's Hammer for Prot",
         -- "Execution Sentence for Prot",
      )

      local flashing, delay = c.DelayPriorityFlash(
         "Holy Avenger",
         "Seraphim",
         "Eternal Flame Refresh",
         "Eternal Flame with Bastion of Power",
         "Shield of the Righteous with Divine Purpose",
         -- would be nice to do this instead of the mitigation buffs above...
         -- /shield_of_the_righteous,if=(holy_power>=5|incoming_damage_1500ms>=health.max*0.3)&(!talent.seraphim.enabled|cooldown.seraphim.remains>5)
         -- /shield_of_the_righteous,if=buff.holy_avenger.remains>time_to_hpg&(!talent.seraphim.enabled|cooldown.seraphim.remains>time_to_hpg)

         "Seal of Insight for Uther's Insight",
         "Seal of Righteousness for Liadrin's Righteousness",
         "Seal of Truth for Maraad's Truth",
         "Avenger's Shield under Grand Crusader and multiple targets",
         "Hammer of the Righteous with 3 targets",
         "Crusader Strike",
         "Crusader Strike Delay",
         "Judgment",
         "Judgment Delay",
         "Avenger's Shield with multiple targets",
         "Holy Wrath with Sanctified Wrath",
         "Avenger's Shield under Grand Crusader",
         "Sacred Shield at 2",
         "Holy Wrath with Final Wrath",
         "Avenger's Shield",
         "Light's Hammer",
         "Holy Prism",
         "Consecration with 3 targets",
         "Execution Sentence",
         "Hammer of Wrath",
         "Sacred Shield at 8",
         "Consecration",
         "Holy Wrath",
         -- /seal_of_insight,if=talent.empowered_seals.enabled&!seal.insight&buff.uthers_insight.remains<=buff.liadrins_righteousness.remains&buff.uthers_insight.remains<=buff.maraads_truth.remains
         -- /seal_of_righteousness,if=talent.empowered_seals.enabled&!seal.righteousness&buff.liadrins_righteousness.remains<=buff.uthers_insight.remains&buff.liadrins_righteousness.remains<=buff.maraads_truth.remains
         -- /seal_of_truth,if=talent.empowered_seals.enabled&!seal.truth&buff.maraads_truth.remains<buff.uthers_insight.remains&buff.maraads_truth.remains<buff.liadrins_righteousness.remains
         "Sacred Shield",
         "Flash of Light for Prot"
      )

      -- @todo danielp 2014-11-09: revisit the logic below, enable again?
      do return end

      if not flashing then
         return
      end

      local bump = 0
      if flashing == "Judgment under Sanctified Wrath" then
         bump = 2
      elseif u.StartsWith(flashing, "Crusader Strike")
         or u.StartsWith(flashing, "Hammer of the Righteous")
         or u.StartsWith(flashing, "Judgment")
         or u.StartsWith(flashing, "Judgment")
         or flashing == "Avenger's Shield under Grand Crusader" then

         bump = 1
      end
      if bump == 1 and c.HasBuff("Holy Avenger", false, true) then
         bump = 3
      end
      if a.HolyPower + bump > 5 then
         if delay then
            c.FlashAll("Shield of the Righteous Predictor")
         else
            c.FlashAll("Shield of the Righteous")
         end
      end
   end,

   FlashAlways = function()
      c.FlashAll("Righteous Fury", "Seal of Insight for Prot")
      flashRaidBuffs()
   end,

   CastSucceeded = selflessTriggerMonitor,

   SpellMissed = function(spellID)
      clearSelflessPending(spellID, "Judgment")
   end,

   AuraApplied = function(spellID)
      if c.IdMatches(spellID, "Sacred Shield") then
         a.SacredShieldPower = GetSpellBonusDamage(2)
         c.Debug("Event", "Sacred Shield applied at", a.SacredShieldPower)
      else
         clearSelflessPending(spellID, "Selfless Healer")
      end
   end,

   AuraRemoved = clearSelflessMonitor,

   ExtraDebugInfo = function()
      return string.format("%s %s", a.HolyPower, a.SelflessHealer)
   end,
}

--------------------------------------------------------------------------- Ret

-- our aoe vs non-aoe rotations.  these follow the common component in the
-- function below.
local RetributionAoE = {
   "Divine Storm at 5",
   "Exorcism with Blazing Contempt",
   "Hammer of the Righteous",
   "Judgment for Liadrin's Righteousness",
   -- /hammer_of_wrath -- I *think* this is the right spell.
   "Hammer of Wrath for Ret",
   "Divine Storm",
   "Exorcism with Mass Exorcism",
   "Judgment",
   "Judgment Delay",
   "Exorcism",
   "Exorcism Delay",
   "Holy Prism",
}

local RetributionCleave = {
   "Final Verdict for buff at 5",
   "Divine Storm at 5 with Final Verdict",
   "Divine Storm at 5 without Final Verdict talent",
   "Exorcism with Blazing Contempt",
   -- /hammer_of_wrath -- I *think* this is the right spell.
   "Hammer of Wrath for Ret",
   "Judgment for Liadrin's Righteousness < 5",
   "Divine Storm without Final Verdict talent",
   "Crusader Strike",
   "Crusader Strike Delay",
   "Divine Storm with Final Verdict",
   "Judgment",
   "Judgment Delay",
   "Exorcism",
   "Exorcism Delay",
   "Holy Prism",
}

local RetributionSingleTarget = {
   "Divine Storm at 5 with Divine Crusader and Final Verdict",
   "Divine Storm at 5 with Divine Crusader or Final Verdict, and Two Targets",
   "Divine Storm at 5 with Divine Crusader and Seraphim",
   "Templar's Verdict at 5",
   "Templar's Verdict with Divine Purpose < 4",
   "Final Verdict at 5",
   "Final Verdict with Holy Avenger",
   "Final Verdict with Divine Purpose < 4",
   "Hammer of Wrath for Ret",
   "Judgment for Maraad's Truth",
   "Judgment for Liadrin's Righteousness",
   "Exorcism with Blazing Contempt",
   "Seal of Truth for Maraad's Truth",
   "Divine Storm with Divine Crusader and Final Verdict",
   "Final Verdict with Divine Purpose",
   "Templar's Verdict with Avenging Wrath",
   "Templar's Verdict with Divine Purpose Talent",
   "Divine Storm with Divine Purpose talent, and Divine Crusader, without Final Verdict talent",
   "Crusader Strike",
   "Crusader Strike Delay",
   "Final Verdict",
   "Seal of Righteousness for Liadrin's Righteousness",
   "Judgment",
   "Judgment Delay",
   "Divine Storm with Divine Crusader, without Final Verdict talent",
   "Templar's Verdict at 4, no Seraphim",
   "Exorcism",
   "Exorcism Delay",
   "Templar's Verdict at 3, no Seraphim",
   "Holy Prism",
}

a.Rotations.Retribution = {
   Spec = 3,

   UsefulStats = { "Strength", "Haste", "Crit", "Multistrike" },

   FlashInCombat = function()
      a.Exorcism = c.GetCooldown(
         c.HasGlyph("Mass Exorcism") and "Glyphed Exorcism" or "Exorcism", false, 15)

      a.AvengingWrath = c.GetBuffDuration("Avenging Wrath", false, false, true)
      a.HolyAvenger = c.GetBuffDuration("Holy Avenger", false, false, true)
      a.DivinePurpose = c.GetBuffDuration("Divine Purpose", false, false, true)
      a.DivineCrusader = c.HasBuff("Divine Crusader") and not c.IsCasting("Divine Storm")
      -- hope that is the right buff name; hard to verify on wowhead.
      a.FinalVerdict = c.HasBuff("Final Verdict") and not c.IsCasting("Divine Storm")

      c.FlashAll("Lay on Hands", "Rebuke")

      local list                -- how AoE are we?
      if c.EstimatedHarmTargets >= 5 then
         list = RetributionAoE
      elseif c.EstimatedHarmTargets >= 3 then
         list = RetributionCleave
      else
         list = RetributionSingleTarget
      end

      c.DelayPriorityFlash(
         "Execution Sentence",
         "Light's Hammer",
         "Holy Avenger",
         "Avenging Wrath",
         "Seraphim",
         -- NOTE: this only works if it is the *last* argument!
         unpack(list)
      )
   end,

   FlashAlways = function()
      c.FlashAll("Seal of Truth", "Flash of Light for Ret", "Word of Glory for Ret")
      flashRaidBuffs()
   end,

   ExtraDebugInfo = function()
      return string.format(
         "h:%d j:%.1f, c:%.1f e:%.1f a:%.1f h:%.1f d:%s c:%s",
         a.HolyPower,
         a.Judgment,
         a.Crusader,
         a.Exorcism,
         a.AvengingWrath,
         a.HolyAvenger,
         a.DivinePurpose and "t" or "f",
         a.DivineCrusader and "t" or "f")
   end,
}
