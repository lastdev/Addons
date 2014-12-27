local addonName, a = ...
local s = SpellFlashAddon
local x = s.UpdatedVariables
local g = BittensGlobalTables
local c = g.GetTable("BittensSpellFlashLibrary")
local u = g.GetTable("BittensUtilities")

local UnitLevel = UnitLevel
local GetPowerRegen = GetPowerRegen
local GetSpellBookItemName = GetSpellBookItemName
local GetTime = GetTime
local IsSwimming = IsSwimming
local SPELL_POWER_BURNING_EMBERS = SPELL_POWER_BURNING_EMBERS
local SPELL_POWER_SOUL_SHARDS = SPELL_POWER_SOUL_SHARDS
local UnitExists = UnitExists
local UnitGUID = UnitGUID
local UnitBuff = UnitBuff
local max = math.max
local min = math.min
local select = select

local baseLengths = {
   ["Agony"] = 24,
   ["Corruption"] = 18,
   ["Unstable Affliction"] = 14,
   ["Doom"] = 60,
   ["Immolate"] = 15,
}

local function getDoTDuration(name)
   local duration = c.GetMyDebuffDuration(name)
   if name == "Immolate" then
      duration = max(duration, c.GetMyDebuffDuration("Immolate AoE"))
   end

   if c.IsCastingOrInAir(name)
      or c.IsCasting("Soul Swap")
      or GetTime() - a.SwapCast < .8
      or (name == "Corruption" and a.SocExplosionPending) then

      local base = baseLengths[name]
      return min(1.5 * base, duration + base)
   else
      return duration
   end
end

local function gcdCheck(name, padding)
   local time = max(1, c.GetHastedTime(1.5))
   if padding ~= nil then
      time = time + padding
   end
   return getDoTDuration(name) < time
end

local function soonCheck(name, considerCastTime)
   -- @todo danielp 2014-11-09: clearly horribly wrong.
   do return false end

   local time = nil
   -- local time = u.GetFromTable(
   --    a.Snapshots, name, UnitGUID(s.UnitSelection()), "Tick")
   -- if time == nil then
   --    return false -- this is UA, and it is casting
   -- end

   if considerCastTime then
      time = time + c.GetCastTime(name)
   end
   return getDoTDuration(name) < time
end

local function doDarkSoul(z, easyCheck, hardCheck)
   if c.HasBuff(z.ID, false, false, true) then
      return false
   end

   if c.HasTalent("Archimonde's Darkness") then
      local charges, tilNext, tilMax = c.GetChargeInfo(z.ID)
      if tilMax == 0 then
         return easyCheck
      elseif charges > 0 then
         return hardCheck
      end
   else
      return easyCheck and c.GetCooldown(z.ID, false, 120) == 0
   end
end

------------------------------------------------------------------------ Common
local petIdentifiers = {
   [s.SpellName(c.GetID("Firebolt"), true)] = "Imp",
   [s.SpellName(c.GetID("Felbolt"), true)] = "Fel Imp",
   [s.SpellName(c.GetID("Torment"), true)] = "Voidwalker",
   [s.SpellName(c.GetID("Tongue Lash"), true)] = "Observer",
   [s.SpellName(c.GetID("Shadow Bite"), true)] = "Felhunter",
   [s.SpellName(c.GetID("Lash of Pain"), true)] = "Succubus",
}

function a.GetCurrentPet()
   for i = 1, 10000 do
      local spell = GetSpellBookItemName(i, "pet")
      if spell == nil then
         return nil
      end

      local pet = petIdentifiers[spell]
      if pet ~= nil then
         return pet
      end
   end
end

c.AddOptionalSpell("Dark Intent", nil, {
   Override = function()
      return c.RaidBuffNeeded(c.SPELL_POWER_BUFFS)
   end
})

c.AddOptionalSpell("Soulstone", nil, {
   NoRangeCheck = true,
   CheckFirst = function()
      return x.EnemyDetected
         and c.SelfBuffNeeded("Soulstone")
         and c.IsSolo(true)
   end
})

c.AddOptionalSpell("Dark Regeneration", nil, {
   CheckFirst = function(z)
      if s.HealthPercent("player") < 70 then
         z.FlashSize = nil
         return true
      end

      if UnitExists("pet") and s.HealthPercent("pet") < 70 then
         z.FlashSize = s.FlashSizePercent() / 2
         return true
      end
   end
})

c.AddOptionalSpell("Unending Breath", nil, {
   Override = function()
      return IsSwimming() and c.SelfBuffNeeded("Unending Breath")
   end
})

c.AddOptionalSpell("Life Tap", nil, {
   CheckFirst = function()
      local powerBefore = s.Power("player")
      local powerAfter = 100 * ((powerBefore + .15 * s.MaxHealth("player")) / s.MaxPower("player"))
      local healthBefore = s.HealthPercent("player")
      return powerBefore <= 40 and powerAfter <= 100
         and ((healthBefore - 15 > powerAfter) or (healthBefore > 90 and s.InRaidOrParty()))
   end
})

c.AddOptionalSpell("Soulshatter", nil, {
   FlashColor = "red",
   CheckFirst = function()
      return s.InRaidOrParty() and c.IsTanking()
   end
})

c.AddOptionalSpell("Clone Magic", nil, {
   Type = "pet",
   FlashColor = "aqua",
   CheckFirst = function()
      local unit = s.UnitSelection()
      if unit == nil or not s.Enemy(unit) then
         return false
      end

      for i = 1, 10000 do
         local _, _, _, _, _, _, _, _, isStealable, _, spellID = UnitBuff(unit, i)
         if spellID == nil then
            return false
         elseif isStealable then
            return true
         end
      end
   end
})

c.AddDispel("Devour Magic", nil, "Magic", {
   Type = "pet",
})

c.AddInterrupt("Spell Lock", nil, {
   NoGCD = true,
})

c.AddInterrupt("Command Spell Lock", nil, {
   NoGCD = true,
})

c.AddInterrupt("Optical Blast", nil, {
   NoGCD = true,
})


c.AddOptionalSpell("Mannoroth's Fury", nil, {
   Buff = "Mannoroth's Fury",
   Cooldown = 60,
})

c.AddOptionalSpell("Summon Doomguard", nil, {
   Cooldown = 10 * 60,
   CheckFirst = function()
      -- @todo danielp 2014-11-09: check aff
      return c.EstimatedHarmTargets < 5 and not c.HasTalent("Demonic Servitude")
   end,
})

c.AddOptionalSpell("Summon Infernal", nil, {
   Cooldown = 10 * 60,
   CheckFirst = function()
      -- @todo danielp 2014-11-09: check aff
      return c.EstimatedHarmTargets >= 5 and not c.HasTalent("Demonic Servitude")
   end,
})

c.AddSpell("Cataclysm", nil, {
   Cooldown = 60,
})

c.AddSpell("Cataclysm", "with Metamorphosis", {
   Cooldown = 60,
   CheckFirst = function()
      return a.Morphed
   end
})

-------------------------------------------------------------------- Affliction
local function getCorruptionWithMiseryDuration()
   -- if u.GetFromTable(
   --    a.Snapshots,
   --    "Corruption",
   --    UnitGUID(s.UnitSelection()),
   --    "Miserable") then
   -- 
   --    return getDoTDuration("Corruption")
   -- else
      return 0
   -- end
end

local function getMinUntilMisery()
   if not c.HasTalent("Archimonde's Darkness") then
      return c.GetCooldown("Dark Soul: Misery", false, 120)
   end

   local min
   local charges, tilNext, tilMax = c.GetChargeInfo("Dark Soul: Misery")
   if charges > 0 then
      min = 0
   else
      min = tilNext
   end
   min = max(min, getCorruptionWithMiseryDuration())
   return min
end

local function getMaxUntilMisery()
   if not c.HasTalent("Archimonde's Darkness") then
      return c.GetCooldown("Dark Soul: Misery", false, 120)
   end

   local charges, tilNext, tilMax = c.GetChargeInfo("Dark Soul: Misery")
   return tilMax
end

local function sizeForDarkSoul(z, ...)
   if a.Shards == 0 or a.DarkSoul then
      z.FlashSize = nil
      return
   end

   local untilMisery = getMaxUntilMisery()
   for i = 1, select("#", ...) do
      local name = select(i, ...)
      if c.GetMyDebuffDuration(name) < untilMisery then
         z.FlashSize = nil
         return
      end
   end
   z.FlashSize = s.FlashSizePercent() / 2
end

c.AssociateTravelTimes(.8, "Haunt")

local function burnable()
   return soonCheck("Agony")
      or soonCheck("Unstable Affliction")
      or soonCheck("Corruption")
end

c.AddOptionalSpell("Dark Soul: Misery", nil, {
   NextFlashID = {
      "Soulburn", "Soul Swap", "Soul Swap Soulburn", "Soul Swap Exhale" },
   Override = function(z)
      if burnable() then
         z.PredictFlashID = z.NextFlashID
      else
         z.PredictFlashID = nil
      end
      return getMinUntilMisery() == 0
         and doDarkSoul(
            z,
            a.Shards > 0,
            a.Shards >= 3 and c.HasMyDebuff("Haunt", false, false, true))
   end
})

c.AddSpell("Soulburn", "under Dark Soul: Misery", {
   PredictFlashID = { "Soul Swap", "Soul Swap Soulburn", "Soul Swap Exhale" },
   CheckFirst = function(z)
      return a.DarkSoul
         and burnable()
         and not c.HasBuff("Soulburn", false, false, true)
   end
})

c.AddSpell("Soulburn", "during Execute", {
   PredictFlashID = { "Soul Swap", "Soul Swap Soulburn", "Soul Swap Exhale" },
   CheckFirst = function(z)
      if c.HasBuff("Soulburn", false, false, true) then
         return false
      end

      sizeForDarkSoul(z, "Agony", "Corruption", "Unstable Affliction")

      if gcdCheck("Agony", .3)
         or gcdCheck("Unstable Affliction")
         or gcdCheck("Corruption") then

         z.FlashColor = nil
         z.Continue = nil
         return true
      end
   end
})

c.AddSpell("Soul Swap", nil, {
   FlashID = { "Soul Swap", "Soul Swap Exhale", "Soul Swap Soulburn" },
   CheckFirst = function()
      return c.HasBuff("Soulburn", false, false, true)
         and not c.IsCasting("Soul Swap")
   end
})

c.AddOptionalSpell("Grimoire: Felhunter")

c.AddSpell("Drain Soul")

c.AddSpell("Haunt", nil, {
   CheckFirst = function(z)
      if a.Shards == 0 or not c.ShouldCastToRefresh("Haunt", "Haunt", 0, true) then
         return false
      end

      if a.Shards >= (c.HasTalent("Archimonde's Darkness") and 4 or 3)
         or a.DarkSoul
         or getCorruptionWithMiseryDuration() > 6 then

         z.FlashColor = nil
         z.Continue = nil
         z.FlashSize = nil
         return true
      end

      z.Continue = true
      z.FlashColor = "yellow"
      c.MakeMini(z, getMinUntilMisery() < 35)
      return true
   end
})

c.AddSpell("Haunt", "during Execute", {
   CheckFirst = function(z)
      return a.Shards > 0
         and c.ShouldCastToRefresh("Haunt", "Haunt", 0, true)
   end
})

c.AddSpell("Agony", "within GCD", {
   CheckFirst = function(z)
      sizeForDarkSoul(z, "Unstable Affliction")
      return gcdCheck("Agony", .3)
   end
})

c.AddSpell("Agony", "Soon", {
   CheckFirst = function(z)
      sizeForDarkSoul(z, "Agony")
      return soonCheck("Agony")
   end
})

c.AddSpell("Corruption", "within GCD", {
   CheckFirst = function(z)
      sizeForDarkSoul(z, "Corruption")
      return gcdCheck("Corruption")
   end
})

c.AddSpell("Corruption", "Soon", {
   CheckFirst = function(z)
      sizeForDarkSoul(z, "Corruption")
      return soonCheck("Corruption")
   end
})

c.AddSpell("Unstable Affliction", "within GCD", {
   CheckFirst = function(z)
      sizeForDarkSoul(z, "Unstable Affliction")
      return gcdCheck(
         "Unstable Affliction", c.GetCastTime("Unstable Affliction"))
   end
})

c.AddSpell("Unstable Affliction", "Soon", {
   CheckFirst = function(z)
      sizeForDarkSoul(z, "Unstable Affliction")
      return soonCheck("Unstable Affliction", a.Shards == 0 or not a.DarkSoul)
   end
})

c.AddOptionalSpell("Life Tap", "for Affliction", {
   CheckFirst = function()
      if a.DarkSoul or c.HasBuff(c.BLOODLUST_BUFFS) then
         return false
      end

      if s.HealthPercent() <= 20 then
         return s.PowerPercent("player") < 10
      else
         return s.PowerPercent("player") < 50
      end
   end
})

-------------------------------------------------------------------- Demonology
local function hasFuryFor(amount)
   if c.WearingSet(2, "T15") then
      amount = amount * .7
   end
   return a.Fury >= amount
end

local function getRange(normal, mannoroth)
   if c.HasBuff("Mannoroth's Fury", false, false, true) then
      return normal
   else
      return mannoroth or normal * 5
   end
end

c.AddOptionalSpell("Dark Soul: Knowledge", nil, {
   Cooldown = 120,
   CheckFirst = function(z)
      if c.GetChargeInfo("Dark Soul: Knowledge") >= 2 then
         return true
      end

      local hp = c.GetHealthPercent()

      if c.HasGlyph("Dark Soul") and hp < 5 then -- time_to_die <= 10
         return true
      elseif hp < 10 then -- time_to_die <= 20
         return true
      elseif hp < 30 and a.Fury > 400 then -- time_to_die <= 60
         return true
      end

      -- if (trinket.proc.any.react&demonic_fury>400) then return true end

      return false
   end,
})

c.AddSpell("Imp Swarm", nil, {
   Cooldown = 120,
   CheckFirst = function()
      -- @todo danielp 2014-11-11: SimCraft forced this only after 3 seconds
      -- since start of combat, why did they do that?
      return a.DarkSoul > 0 or
         c.GetCooldown("Dark Soul: Knowledge") > c.GetHastedTime(120) or
         c.GetHealthPercent() < 20 -- time_to_die <= 32
   end
})

c.AddOptionalSpell("Grimoire: Felguard")

c.AddOptionalSpell("Felstorm", nil, {
   GetDelay = function()
      return s.SpellCooldown(c.GetID("Felstorm"))
   end
})

c.AddOptionalSpell("Wrathstorm", nil, {
   GetDelay = function()
      return s.SpellCooldown(c.GetID("Wrathstorm"))
   end
})

c.AddOptionalSpell("Metamorphosis", nil, {
   Type = "form",
   CheckFirst = function()
      if c.Morphed then
         return false           -- duh!
      end

      if a.DarkSoul > c.LastGCD and (a.Fury > 300 or not c.HasGlyph("Dark Soul")) then
         return true
      end

      local _, nextDarkSoul, _ = c.GetChargeInfo("Dark Soul: Knowledge")

      -- (trinket.proc.any.react|trinket.stacking_proc.any.react>6|buff.demonic_synergy.up)&demonic_fury>400&action.dark_soul.recharge_time>=10
      if c.HasBuff("Demonic Synergy") and a.Fury > 400 and nextDarkSoul >= 10 then
         return true
      end

      if c.GetCooldown("Cataclysm") == 0 then
         return true
      end

      -- !dot.doom.ticking&target.time_to_die>=30%(1%spell_haste)&demonic_fury>300
      if not c.HasMyDebuff("Doom") and c.GetHealthPercent() >= 30 and a.Fury > 300 then
         return true
      end

      local chargesHand, _, _ = c.GetChargeInfo("Hand of Gul'dan")
      if a.Fury > 750 and chargesHand == 0 then
         return true
      end

      if a.Fury > 750 and not c.HasMyDebuff("Shadowflame") and not c.IsAuraPendingFor("Hand of Gul'dan") then
         return true
      end

      if c.GetHealthPercent() < 30 and nextDarkSoul >= 10 then
         return true
      end

      return false
   end
})

c.AddOptionalSpell("Metamorphosis", "Cancel", {
   Type = "form",
   FlashColor = "red",
   CheckFirst = function()
      -- @todo danielp 2014-11-11: simc had more complex trinket, ttd conditions.
      if not a.Morphed then
         return false
      end

      if a.Fury < (c.HasGlyph("Dark Soul") and 450 or 650) then
         return true
      end

      if c.GetChargeInfo("Hand of Gul'dan") >= 3 and
         (a.DarkSoul > c.LastGCD or c.GetCooldown("Metamorphosis") < c.LastGCD)
      then
         return true
      end

      return false
   end,
})

c.AddSpell("Metamorphosis", "Cancel Unconditionally", {
   Type = "form",
   FlashColor = "red",
   CheckFirst = function()
      return a.Morphed
   end,
})

c.AddOptionalSpell("Metamorphosis", "AoE", {
   Type = "form",
   CheckFirst = function()
      if not hasFuryFor(40) then
         return false
      end
      return a.Fury > 950 or a.DarkSoul > 0
   end
})

c.AddOptionalSpell("Metamorphosis", "Cancel AoE", {
   Type = "form",
   FlashColor = "red",
   Override = function(z)
      return a.Fury < 650
         and not c.HasBuff("Immolation Aura")
         and a.DarkSoul == 0
   end
})

c.AddSpell("Corruption", "for Demonology", {
   FlashID = { "Corruption", "Doom" },
   MyDebuff = "Corruption",
   EarlyRefresh = 18 * 0.3,
   CheckFirst = function()
      return not a.Morphed
   end,
})

c.AddSpell("Doom", nil, {
   FlashID = { "Corruption", "Doom" },
   MyDebuff = "Doom",
   EarlyRefresh = 18,
   CheckFirst = function()
      -- @todo danielp 2014-11-11: SimC used TTD >= c.GetHastedTime(30)
      return a.Morphed and (not (a.DarkSoul > 0) or not c.HasGlyph("Dark Soul"))
         -- (remains<cooldown.cataclysm.remains|!talent.cataclysm.enabled)
   end,
})

c.AddSpell("Hand of Gul'dan", nil, {
   Applies = { "Shadowflame" },
   CheckFirst = function()
      if c.HasMyDebuff("Shadowflame") or c.IsAuraPendingFor("Hand of Gul'dan") then
         return false
      end

      -- @todo danielp 2014-11-11: get a real estimate here!
      local travel_time = 0.2

      local duration = c.GetMyDebuffDuration("Shadowflame")
      if duration > (c.GetCastTime("Shadow Bolt") + travel_time) then
         return false
      end


      local charges, recharge, cap = c.GetChargeInfo("Hand of Gul'dan")

      -- if any of these are true, cast
      if c.WearingSet(2, "T17") then
         if charges >= 3 or (charges == 2 and recharge < (13.8 - (travel_time * 2))) then
            return 0
         end
      else
         if charges == 1 and recharge <= 4 or charges >= 2 then
            return 0
         end
      end

      -- @todo danielp 2014-11-11: from SimCraft, but I wonder about this?
      -- I think it might be to try and get a double-dot tick at the end, but
      -- really uncertain.  Should research more.
      return duration > travel_time
   end
})

c.AddSpell("Chaos Wave", nil, {
   GetDelay = function()
      if not a.Morphed then
         return false
      end

      local charges, recharge, cap = c.GetChargeInfo("Chaos Wave")
      -- time to cap, no matter how many charges we get from set bonus, etc. :)
      return cap
   end,
})

c.AddSpell("Touch of Chaos", nil, {
   FlashID = { "Touch of Chaos", "Shadow Bolt" },
   CheckFirst = function()
      return a.Morphed
   end
})

c.AddSpell("Touch of Chaos", "to Save Corruption", {
   FlashID = { "Touch of Chaos", "Shadow Bolt" },
   Override = function()
      local duration = c.GetMyDebuffDuration("Corruption")
      return hasFuryFor(40) and duration > 0 and duration < 1.7
   end
})

c.AddSpell("Touch of Chaos", "to Extend Corruption", {
   FlashID = { "Touch of Chaos", "Shadow Bolt" },
   Override = function()
      local duration = c.GetMyDebuffDuration("Corruption")
      return hasFuryFor(40) and duration > 0 and duration < 20
   end
})

c.AddSpell("Soul Fire")

c.AddSpell("Soul Fire", "with Metamorphosis", {
   CheckFirst = function()
      return a.Morphed and c.HasBuff("Molten Core") and
         (a.DarkSoul > 0 or c.GetHealthPercent() <= 25)
   end,
})

c.AddSpell("Soul Fire", "with Molten Core", {
   CheckFirst = function()
      if not c.HasBuff("Molten Core") then
         return false
      end

      if c.GetHealthPercent() <= 35 and a.DarkSoul >= 30 then
         return true
      end

      if c.GetBuffStack("Molten Core") < 4 or c.GetHealthPercent() > 25 then
         return false
      end

      if a.DarkSoul > c.GetCastTime("Shadow Bolt") or a.DarkSoul < c.GetCastTime("Soul Fire") then
         return false
      end

      return true
   end,
})

c.AddSpell("Shadow Bolt", nil, {
   FlashID = { "Touch of Chaos", "Shadow Bolt" },
})

c.AddSpell("Immolation Aura", nil, {
   FlashID = { "Hellfire", "Immolation Aura" },
   RunFirst = function(z)
      z.Range = getRange(10, 20)
   end,
   Override = function()
      return not c.HasBuff("Immolation Aura")
   end
})

c.AddSpell("Hellfire", nil, {
   FlashID = { "Hellfire", "Immolation Aura" },
   RunFirst = function(z)
      z.Range = getRange(10, 20)
   end,
})

c.AddSpell("Hellfire", "Out of Range", {
   FlashColor = "red",
   FlashID = { "Hellfire", "Immolation Aura" },
})

-- c.AddInterrupt("Axe Toss", nil, {
--    NoGCD = true,
-- })

c.AddInterrupt("Super Axe Toss", nil, {
   NoGCD = true,
})

------------------------------------------------------------------- Destruction
local function getIncinerateCastTime()
   local cast = c.GetCastTime("Incinerate")
   local realDraft = s.Buff(c.GetID("Backdraft"), "player")
   if a.Backdraft > 0 and not realDraft then
      return cast / 1.3
   elseif a.Backdraft == 0 and realDraft then
      return cast * 1.3
   else
      return cast
   end
end

c.AddOptionalSpell("Dark Soul: Instability", nil, {
   CheckFirst = function(z)
      return doDarkSoul(z, true, a.Embers > 3.5 or s.HealthPercent() <= 10)
   end,
   GetDelay = function()
      return c.GetCooldown("Dark Soul: Instability", false, c.HasGlyph("Dark Soul") and 60 or 120)
   end,
})

c.AddOptionalSpell("Grimoire: Imp")

c.AddSpell("Shadowburn", nil, {
   CheckFirst = function(z)
      if a.Embers < 1 then
         return false
      end

      local optional = a.Embers <= 3.5 and a.DarkSoul == 0
      c.MakeOptional(z, optional)
--         c.MakeMini(z, optional)
      return true
   end,
})

c.AddSpell("Shadowburn", "Last Resort")

c.AddSpell("Immolate", nil, {
   FlashID = { "Immolate", "Immolate AoE" },
   Range = 40,
   CheckFirst = function()
      return
         not c.IsCasting("Immolate") and
         not c.IsCasting("Immolate AoE")
   end,
   GetDelay = function()
      return max(c.GetMyDebuffDuration("Immolate"), c.GetMyDebuffDuration("Immolate AoE"))
   end,
})

c.AddSpell("Immolate", "to extend", {
   FlashID = { "Immolate", "Immolate AoE" },
   Range = 40,
   CheckFirst = function()
      return
         not c.IsCasting("Immolate") and
         not c.IsCasting("Immolate AoE")
   end,
   GetDelay = function()
      -- 4.5 seconds is the new "pandemic"-alike window.
      local delay = max(c.GetMyDebuffDuration("Immolate"), c.GetMyDebuffDuration("Immolate AoE")) -
         (c.GetCastTime("Immolate") + 4.5)
      return max(0, delay)
   end
})

c.AddSpell("Conflagrate", "Single Target", {
   CheckFirst = function(z)
      if c.GetChargeInfo("Conflagrate") == 0 or c.Flashing["Shadowburn"] or c.Flashing["Chaos Bolt"] then
         return false
      end

      -- if c.IsCasting("Immolate") then return false end

      local optional = a.DarkSoul == 0 and (a.Backdraft > 0)
      c.MakeOptional(z, optional)
--         c.MakeMini(z, optional)
      return true
   end,
   GetDelay = function()
      local charges, nextCharge, _ = c.GetChargeInfo("Conflagrate")
      if charges > 0 then
         return 0
      else
         return nextCharge, 0.35
      end
   end,
})

c.AddSpell("Conflagrate", "at Cap", {
   CheckFirst = function()
      local charges = c.GetChargeInfo("Conflagrate")
      return charges >= 2
   end,
   GetDelay = function()
      local _, _, tilMax = c.GetChargeInfo("Conflagrate")
      return tilMax, 0.35
   end,
})

c.AddSpell("Conflagrate", "AoE", {
   CheckFirst = function()
      return c.GetChargeInfo("Conflagrate") == 0
         or (a.Backdraft == 0
            and (c.IsCasting("Incinerate")
                    or c.IsCasting("Incinerate AoE")))
   end
})

c.AddSpell("Chaos Bolt", nil, {
   GetDelay = function(z)
      if a.Embers < a.T15EmberCost() or a.Backdraft >= 3 or c.Flashing["Shadowburn"] then
         return false
      end

      local optional = a.Embers <= 3.5 and a.DarkSoul < c.GetCastTime("Chaos Bolt")
      c.MakeOptional(z, optional)
--         c.MakeMini(z, optional)
      return 0
   end,
})

c.AddSpell("Chaos Bolt", "Last Resort")

c.AddSpell("Incinerate", nil, {
   FlashID = { "Incinerate", "Incinerate AoE" },
   Range = 40,
})

c.AddOptionalSpell("Ember Tap", nil, {
   CheckFirst = function()
      if c.HasGlyph("Ember Tap") then
         return s.HealthPercent("player") < 72
      else
         return s.HealthPercent("player") < 79
      end
   end
})

local function rofIsNotActive()
   return not ((c.HasBuff("Rain of Fire") and c.HasMyDebuff("Rain of Fire"))
      or c.IsCasting("Rain of Fire")
      or GetTime() - a.RoFCast < .8)
end

c.AddOptionalSpell("Rain of Fire", nil, {
   NoRangeCheck = true,
   CheckFirst = rofIsNotActive,
   GetDelay = function()
      if c.HasBuff("Mannoroth's Fury") and c.GetBuffDuration("Mannoroth's Fury") < 2 then
         return 0               -- now, before MF expires!
      end

      if c.HasSpell("Aftermath") then
         return c.GetBuffDuration("Rain of Fire") - (c.GetHastedTime(8) * .3)
      else
         return c.GetBuffDuration("Rain of Fire") - (c.GetHastedTime(6) * .3)
      end
   end
})

c.AddOptionalSpell("Rain of Fire", "Single Target", {
   NoRangeCheck = true,
   CheckFirst = function()
      local has_mf = c.HasBuff("Mannoroth's Fury")
      return c.GetPowerPercent() > 50 and
         (rofIsNotActive() or (has_mf and c.GetBuffDuration("Mannoroth's Fury") < 2)) and
         (has_mf or not c.HasBuff("Backdraft"))
   end
})

c.AddOptionalSpell("Fire and Brimstone", nil, {
   Buff = "Fire and Brimstone",
   BuffUnit = "player",
   NoGCD = true,
   CheckFirst = function()
      return a.Embers >= 2
   end
})

c.AddOptionalSpell("Fire and Brimstone", "Cancel", {
   FlashColor = "red",
   NoGCD = true,
   Override = function()
      return a.Embers >= 1 and c.HasBuff("Fire and Brimstone")
   end
})
