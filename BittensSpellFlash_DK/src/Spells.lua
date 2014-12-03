local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local x = s.UpdatedVariables
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local GetCombatRatingBonus = GetCombatRatingBonus
local GetMasteryEffect = GetMasteryEffect
local GetSpellInfo = GetSpellInfo
local GetTime = GetTime
local GetVersatility = GetVersatility
local GetVersatilityBonus = GetVersatilityBonus
local UnitAttackPower = UnitAttackPower
local UnitBuff = UnitBuff
local UnitExists = UnitExists
local UnitLevel = UnitLevel
local UnitStat = UnitStat

local CR_VERSATILITY_DAMAGE_DONE = CR_VERSATILITY_DAMAGE_DONE
local SPELL_POWER_RUNIC_POWER = SPELL_POWER_RUNIC_POWER

local ipairs = ipairs
local max = math.max
local min = math.min
local select = select
local sort = sort
local tinsert = tinsert
local type = type
local unpack = unpack

a.Costs = {}
function a.SetCost(blood, frost, unholy, death, name, bonusRP, rime, freeWithPerk)
   a.Costs[s.SpellName(c.GetID(name))] = {
      Blood = blood,
      Frost = frost,
      Unholy = unholy,
      Death = death,
      BonusRP = bonusRP,
      Rime = rime,
      FreeWithPerk = freeWithPerk and c.GetID(freeWithPerk) or nil
   }
end

a.SetCost(1, 0, 0, 0, "Blood Boil")
a.SetCost(0, 0, 0, 0, "Bone Shield")
a.SetCost(0, 1, 0, 0, "Chains of Ice")
a.SetCost(0, 0, 1, 0, "Dark Transformation", nil, false, "Enhanced Dark Transformation")
a.SetCost(0, 0, 1, 0, "Death and Decay")
a.SetCost(0, 0, 0, 1, "Death Siphon")
a.SetCost(0, 1, 1, 0, "Death Strike")
a.SetCost(0, 0, 0, 0, "Empower Rune Weapon", 25)
a.SetCost(1, 1, 0, 0, "Festering Strike")
a.SetCost(0, 0, 0, 0, "Horn of Winter")
a.SetCost(0, 1, 0, 0, "Howling Blast", nil, true)
a.SetCost(0, 1, 0, 0, "Icy Touch", nil, true)
a.SetCost(0, 1, 1, 0, "Obliterate")
a.SetCost(0, 1, 0, 0, "Pillar of Frost", nil, false, "Empowered Pillar of Frost")
a.SetCost(0, 0, 1, 0, "Plague Strike")
a.SetCost(1, 0, 0, 0, "Rune Tap")
a.SetCost(0, 0, 1, 0, "Scourge Strike")
a.SetCost(1, 0, 0, 0, "Strangulate")


local BLOOD1 = 1
local BLOOD2 = 2
local UNHOLY1 = 3
local UNHOLY2 = 4
local FROST1 = 5
local FROST2 = 6

local function runeAvailable(runeId, delay, forbidDeath)
   if a.Runes[runeId].Delay > (delay or 0) then
      return false
   end

   if forbidDeath and a.Runes[runeId].Type == "death" then
      return false
   end

   return true
end

local function fakeConsume(runeID, delay, needed, deathAvailable)
   if runeAvailable(runeID, delay) then
      if a.Runes[runeID].Type == "death" then
         deathAvailable = deathAvailable + 1
      elseif needed > 0 then
         needed = needed - 1
      end
   end
   return needed, deathAvailable
end

local function sufficientRunes(blood, frost, unholy, death, forbidDeath, noGCD)
   local deathAvailable = a.PendingDeathRunes
   local delay = 0
   if noGCD then
      delay = -c.GetBusyTime()
   end
   blood, deathAvailable = fakeConsume(1, delay, blood, deathAvailable)
   blood, deathAvailable = fakeConsume(2, delay, blood, deathAvailable)
   frost, deathAvailable = fakeConsume(5, delay, frost, deathAvailable)
   frost, deathAvailable = fakeConsume(6, delay, frost, deathAvailable)
   unholy, deathAvailable = fakeConsume(3, delay, unholy, deathAvailable)
   unholy, deathAvailable = fakeConsume(4, delay, unholy, deathAvailable)

   -- handle macroed BT, which can maybe generate a death rune when
   -- we hit the button for this action, prior to it landing.
   if c.GetOption("BTMacro") and c.HasTalent("Blood Tap") then
      local depleted = a.FullyDepleted()
      while a.BloodCharges >= 5 and depleted > 0 do
         deathAvailable = deathAvailable + 1
         depleted = depleted - 1
      end
   end

   if forbidDeath then
      deathAvailable = 0
   end

   -- c.Debug("sufficientRunes", blood, frost, unholy, death, '=', blood+frost+unholy+death, '<=', deathAvailable, '|', blood+frost+unholy+death <= deathAvailable)
   return blood + frost + unholy + death <= deathAvailable
end

local function sufficientResources(id, noGCD)
   local name = s.SpellName(id)
   local cost = a.Costs[name]
   if cost then
      if cost.freeWithPerk and c.HasSpell(cost.freeWithPerk) then
         return true
      end

      local frost = cost.Rime and a.FreezingFog > 0 and 0 or cost.Frost
      return sufficientRunes(cost.Blood, frost, cost.Unholy, cost.Death, false, noGCD)
   else
-- c.Debug("Resources", name, s.SpellCost(name, SPELL_POWER_RUNIC_POWER), "<=", a.RP, "|", s.SpellCost(name) <= a.RP)
      return s.SpellCost(name, SPELL_POWER_RUNIC_POWER) <= a.RP
   end
end

-- GetDelay (on a spell) can return up to 2 values: "delay" and "modDelay".
--
-- "delay" is the time until the spell is ready to flash (in seconds), or a
-- falsey value to indicate it should be skipped.  "modDelay", if present,
-- restricts the spell to only flash if "delay" <= "modDelay".
--
-- However, if the IsMinDelayDefinition flag is set, that changes things.  Then
-- "delay" is the minimum time all lower priority spells must be delayed.
-- "modDelay", if present, causes that restriction to only apply to lower
-- priority spells whose delay would otherwise be > "delay - modDelay".  So,
-- for example, "Exorcism Delay" causes any spells lower than its priority that
-- would come off cooldown .2 seconds before Exorcism to pretend they won't come
-- off cooldown until Exercism.  That causes Exorcism to flash instead, since
-- it's worth waiting those .2 seconds  (at most).
local function sortRunesByMinimumDelay(a, b)
   return a.Delay < b.Delay
end

local function getRuneDelay(count, ...)
   local runes = {...}
   sort(runes, sortRunesByMinimumDelay)

   if count <= 0 then
      return 0 -- no runes needed, so no problem
   elseif count > #runes then
      return 9001 -- you need more of these than exist?!?
   else
      return runes[count].Delay -- how long, bro?
   end
end

local function getRuneDelayForSpellCost(spell, cost)
   local blood  = cost.Blood
   local frost  = cost.Rime and a.FreezingFog > 0 and 0 or cost.Frost
   local unholy = cost.Unholy
   local death  = cost.Death
   local deathAvailable = 0

   -- first pass, directly consume the runes we want.
   for _, rune in ipairs(a.Runes) do
      if rune.Delay <= 0 then
         if blood > 0 and rune.Type == "blood" then
            blood = blood - 1
         elseif frost > 0 and rune.Type == "frost" then
            frost = frost - 1
         elseif unholy > 0 and rune.Type == "unholy" then
            unholy = unholy - 1
         elseif rune.Type == "death" then
            if death > 0 then
               death = death - 1
            else
               deathAvailable = deathAvailable + 1
            end
         end
      end
   end

   local remaining = blood + frost + unholy + death

   -- we have enough runes, right now, so we can use the spell.
   if remaining <= 0 then
      return 0
   end

   -- handle macroed BT, which can maybe generate a death rune when
   -- we hit the button for this action, prior to it landing.
   if c.GetOption("BTMacro") and c.HasTalent("Blood Tap") then
      local depleted = a.FullyDepleted()
      while a.BloodCharges >= 5 and depleted > 0 do
         deathAvailable = deathAvailable + 1
         a.BloodCharges = a.BloodCharges - 5
         depleted = depleted - 1
      end
   end

   -- we don't have enough runes, can we use death runes instead?
   if deathAvailable >= remaining and not spell.NoDeathRunes then
      return 0 -- yes
   end

   -- OK, when does this come available for use, then?
   local delay = max(
      getRuneDelay(blood,  a.Runes[1], a.Runes[2]),
      getRuneDelay(unholy, a.Runes[3], a.Runes[4]),
      getRuneDelay(frost,  a.Runes[5], a.Runes[6])
   )

   return delay
end

-- @todo danielp 2014-11-16: copied from BSFL flashing.lua
local function auraDelay(spell, aura, func, early)
   if aura then
      return func(aura, false, spell.UseBuffID, spell.ID) - early
   else
      return 0
   end
end

local function getDelayForSpell(spell)
   local cost = spell.Cost
   local delay

   if cost and cost.freeWithPerk and c.HasSpell(cost.freeWithPerk) then
      -- yay, we can just use this as much as we want.
      delay = 0
   elseif cost then
      delay = getRuneDelayForSpellCost(spell, cost)
   else
      -- runic power
      if s.SpellCost(spell.ID, SPELL_POWER_RUNIC_POWER) <= a.RP then
         delay = 0
      else
         return false
      end
   end

   -- if someone asked that we don't cast, respect that.
   if not delay then return delay end

   -- should we delay until one GCD before the other spell is ready?
   -- note: this depends on our implementation, and avoids
   local justBefore = 0
   if spell.UseJustBefore then
      local other = c.GetSpell(spell.UseJustBefore):GetDelay()
      if other then
         justBefore = max(0, other - c.LastGCD)
      end
   end

   -- Check for cooldowns and buffs.  Copied from default.  At least we get
   -- the other checks, like forms and range for free.
   --
   -- @todo danielp 2014-11-16: consider porting support for this over?
   local early = (spell.EarlyRefresh or 0) + c.GetCastTime(spell.ID)

   delay = max(
      delay,
      justBefore,
      auraDelay(spell, spell.Buff, c.GetBuffDuration, early),
      auraDelay(spell, spell.MyDebuff, c.GetMyDebuffDuration, early),
      auraDelay(spell, spell.Debuff, c.GetDebuffDuration, early),
      auraDelay(spell, spell.MyBuff, c.GetMyBuffDuration, early),
      spell.Cooldown
         and c.GetCooldown(spell.ID, spell.NoGCD, spell.Cooldown)
         or  0)

   return delay, spell.MaxWait
end

-- Use this for all spells with rune or RP costs.  Spells added this way may
-- only use the CheckFirst and NoRangeCheck attributes.  All others will be
-- ignored.  Cooldowns will NOT be checked.
local function addAttrs(name, attributes)
   attributes = attributes or {}
   attributes.Cost = attributes.Cost or a.Costs[name]
   attributes.GetDelay = attributes.GetDelay or getDelayForSpell
   attributes.Name = name
   return attributes
end

local function addDKSpell(name, tag, attributes)
   return c.AddSpell(name, tag, addAttrs(name, attributes))
end

local function addOptionalDKSpell(name, tag, attributes)
   return c.AddOptionalSpell(name, tag, addAttrs(name, attributes))
end

------------------------------------------------------------------------ common
function a.BothRunesAvailable(runeName, delay)
   if runeName == "blood" then
      return runeAvailable(BLOOD1, delay) and runeAvailable(BLOOD2, delay)
   elseif runeName == "frost" then
      return runeAvailable(FROST1, delay) and runeAvailable(FROST2, delay)
   elseif runeName == "unholy" then
      return runeAvailable(UNHOLY1, delay) and runeAvailable(UNHOLY2, delay)
   end
   print("Bad rune name: ", runeName)
end

local allRuneTypes = {"blood", "frost", "unholy"}
function a.FullyDepleted(...)
   local count = 0

   for _, runeName in ipairs(... and {...} or allRuneTypes) do
      if runeName == "blood" then
         if a.Runes[BLOOD1].Delay > 0 and a.Runes[BLOOD2].Delay > 0 then
            count = count + 1
         end
      elseif runeName == "frost" then
         if a.Runes[FROST1].Delay > 0 and a.Runes[FROST2].Delay > 0 then
            count = count + 1
         end
      elseif runeName == "unholy" then
         if a.Runes[UNHOLY1].Delay > 0 and a.Runes[UNHOLY2].Delay > 0 then
            count = count + 1
         end
      else
         print("Bad rune name: ", runeName)
      end
   end

   return count
end

local function hasFrostFever(earlyRefresh)
   if c.IsCasting("Plague Leech") then
      return false
   end

   if c.HasTalent("Necrotic Plague") then
      return c.GetMyDebuffDuration("Necrotic Plague") > earlyRefresh
      or c.IsAuraPendingFor("Outbreak")
      or c.IsAuraPendingFor("Plague Strike")
      or c.IsAuraPendingFor("Icy Touch")
      or c.IsAuraPendingFor("Howling Blast")
      or c.HasBuff("Unholy Blight")
      or c.IsCasting("Unholy Blight")
      or (c.HasSpell("Ebon Plaguebringer")
         and c.IsAuraPendingFor("Plague Strike"))
   end

   return c.GetMyDebuffDuration("Frost Fever") > earlyRefresh
      or c.IsAuraPendingFor("Outbreak")
      or c.IsAuraPendingFor("Icy Touch")
      or c.IsAuraPendingFor("Howling Blast")
      or c.HasBuff("Unholy Blight")
      or c.IsCasting("Unholy Blight")
      or (c.HasSpell("Ebon Plaguebringer")
         and c.IsAuraPendingFor("Plague Strike"))
   -- @todo danielp 2014-10-18: check blood DK rules
end

local function hasBloodPlague(earlyRefresh)
   if c.IsCasting("Plague Leech") then
      return false
   end

   if c.HasTalent("Necrotic Plague") then
      return c.GetMyDebuffDuration("Necrotic Plague") > earlyRefresh
      or c.IsAuraPendingFor("Outbreak")
      or c.IsAuraPendingFor("Plague Strike")
      or c.IsAuraPendingFor("Icy Touch")
      or c.IsAuraPendingFor("Howling Blast")
      or c.HasBuff("Unholy Blight")
      or c.IsCasting("Unholy Blight")
      or (c.HasSpell("Ebon Plaguebringer")
         and c.IsAuraPendingFor("Plague Strike"))
   end

   return c.GetMyDebuffDuration("Blood Plague") > earlyRefresh
      or c.IsAuraPendingFor("Outbreak")
      or c.IsAuraPendingFor("Plague Strike")
      or GetTime() - a.BloodPlagueRefreshPending < .8
      or c.HasBuff("Unholy Blight")
      or c.IsCasting("Unholy Blight")
   -- @todo danielp 2014-10-18: check blood DK rules
end

local function hasBothDiseases(earlyRefresh)
   return hasFrostFever(earlyRefresh) and hasBloodPlague(earlyRefresh)
end

local function soulReaperIsUsable()
   if not a.InExecute or not s.MeleeDistance() then
      return false
   end

   -- @todo danielp 2014-11-15: this is a proxy for "will it land, and be
   -- worth it", which is probably not a great tool for the job.
   if c.GetHealth("target") < 20000 then
      return false
   end

   return true
end

addOptionalDKSpell("Empower Rune Weapon", "for Death Strike", {
   NoGCD = true,
   Cooldown = 5 * 60,
   CheckFirst = function()
      -- don't burn this just for saving the shield
      local count = 0
      for i = 1,6 do
         if a.Runes[i].Type ~= "blood" and a.Runes[i].Delay <= 0 then
            count = count + 1
         end
      end

      return count == 0
         and a.PendingDeathRunes == 0
         and a.ShouldDeathStrikeForHealth()
   end
})

addOptionalDKSpell("Empower Rune Weapon", nil, {
   NoGCD = true,
   Cooldown = 5 * 60,
   FlashSize = s.FlashSizePercent() / 2,
   CheckFirst = function()
      -- don't burn this just for saving the shield
      local count = 0
      for i = 1,6 do
         if a.Runes[i].Delay <= 0 then
            count = count + 1
         end
      end

      return count == 0
         and a.PendingDeathRunes == 0
         and a.RP < 32
   end
})

local function canManuallyBloodTap(charges)
   if c.GetOption("BTMacro") then -- user wants it automagical
      return false
   end

   return a.BloodCharges >= (charges or 5) and a.FullyDepleted() > 0
end

addOptionalDKSpell("Blood Tap", nil, {
   NoGCD = true,
   CheckFirst = function()
      return canManuallyBloodTap()
   end
})

addOptionalDKSpell("Blood Tap", "at 11", {
   NoGCD = true,
   CheckFirst = function()
      return canManuallyBloodTap(11)
   end
})

addOptionalDKSpell("Blood Tap", "for Defile", {
   NoGCD = true,
   CheckFirst = function()
      return c.GetCooldown("Defile", false, 30) == 0 and canManuallyBloodTap(5)
   end
})

addOptionalDKSpell("Death Siphon", nil, {
   CheckFirst = function()
      return c.GetHealthPercent("player") < 80
   end
})

addDKSpell("Outbreak", nil, {
   -- @todo danielp 2014-11-16: necrotic plague?
   Applies = { "Blood Plague", "Frost Fever" },
   Cooldown = 60,
   CheckFirst = function()
      return not hasBothDiseases(0)
   end
})

addDKSpell("Outbreak", "at 3", {
   Applies = { "Blood Plague", "Frost Fever" },
   Cooldown = 60,
   CheckFirst = function()
      return not hasBothDiseases(3)
   end
})

addDKSpell("Unholy Blight", nil, {
   Melee = true,
   Cooldown = 90,
   CheckFirst = function()
      return not hasBothDiseases(0)
   end
})

addDKSpell("Unholy Blight", "unconditionally", {
   Melee = true,
   Cooldown = 90,
})

addDKSpell("Unholy Blight", "for Unholy", {
   Melee = true,
   Cooldown = 90,
   CheckFirst = function()
      if not hasBothDiseases(0) then
         return false
      end

      if c.HasTalent("Necrotic Plague") then
         return not hasBothDiseases(1)
      else
         return not hasBothDiseases(3)
      end
   end
})

addDKSpell("Unholy Blight", "at 2", {
   Melee = true,
   Cooldown = 90,
   CheckFirst = function()
      return not hasBothDiseases(2)
   end
})

addDKSpell("Unholy Blight", "at 3", {
   Melee = true,
   Cooldown = 90,
   CheckFirst = function()
      return not hasBothDiseases(3)
   end
})

local function canPlagueLeech()
   if not hasBothDiseases(0) then
      return false
   end

   if s.Spec(3) then -- unholy spec
      return a.FullyDepleted("blood", "frost") > 0
   else -- blood or frost spec
      return a.FullyDepleted("frost", "unholy") > 0
   end
end

addDKSpell("Plague Leech", nil, {
   Cooldown = 25,
   CheckFirst = canPlagueLeech,
})

addDKSpell("Plague Leech", "for Death Strike", {
   Cooldown = 25,
   CheckFirst = function()
      return canPlagueLeech() and
         (a.ShouldDeathStrikeForHealth() or a.shouldDeathStrikeForShield())
   end
})

addDKSpell("Plague Leech", "at 1", {
   Cooldown = 25,
   CheckFirst = function()
      return canPlagueLeech() and not hasBothDiseases(1)
   end
})

addDKSpell("Plague Leech", "at 2", {
   Cooldown = 25,
   CheckFirst = function()
      return canPlagueLeech() and not hasBothDiseases(2)
   end
})

addDKSpell("Plague Leech", "at 3", {
   Cooldown = 25,
   CheckFirst = function()
      return canPlagueLeech() and not hasBothDiseases(3)
   end
})

addDKSpell("Plague Leech", "if Outbreak", {
   Cooldown = 25,
   CheckFirst = function()
      return canPlagueLeech() and c.GetCooldown("Outbreak", false, 60) < 1
   end
})

addDKSpell("Plague Strike", "for Blood Plague", {
   Applies = { "Blood Plague" },
   CheckFirst = function()
      return not hasBloodPlague(0)
   end
})

addOptionalDKSpell("Raise Dead", nil, {
   NoRangeCheck = 1,
   CheckFirst = function()
      return not UnitExists("pet")
   end
})

addDKSpell("Death and Decay", nil, {
   NoRangeCheck = true,
   Cooldown = 30,
})

addOptionalDKSpell("Horn of Winter", "for Buff, Optional", {
   Cooldown = 20,
   CheckFirst = function()
      return c.RaidBuffNeeded(c.ATTACK_POWER_BUFFS)
   end
})

c.AddInterrupt("Mind Freeze", nil, {
   NoGCD = true,
})

c.AddInterrupt("Asphyxiate")

c.AddInterrupt("Strangulate", nil, {
   NoGCD = true,
})

addOptionalDKSpell("Defile", nil, {
   Melee = true, -- @todo danielp 2014-11-16: really?
   Cooldown = 30,
})

------------------------------------------------------------------------- Blood
local function canBloodTapForDeathStrike()
   local frost = 0
   local unholy = 0
   local death = a.PendingDeathRunes
   if runeAvailable(FROST1) then
      if a.Runes[5].Type == "death" then
         death = death + 1
      else
         frost = frost + 1
      end
   end
   if runeAvailable(FROST2) then
      if a.Runes[6].Type == "death" then
         death = death + 1
      else
         frost = frost + 1
      end
   end
   if runeAvailable(UNHOLY1) then
      if a.Runes[3].Type == "death" then
         death = death + 1
      else
         unholy = unholy + 1
      end
   end
   if runeAvailable(UNHOLY2) then
      if a.Runes[4].Type == "death" then
         death = death + 1
      else
         unholy = unholy + 1
      end
   end
   return (frost + unholy + death == 1)
      or (death == 0 and (
            (frost == 0 and unholy > 0)
         or (unholy == 0 and frost > 0)))
end

-- Estimated amount of Blood Shield
-- Based on http://forums.wowace.com/showpost.php?p=329939&postcount=2
-- Uses data from http://us.battle.net/wow/en/forum/topic/13087818929#2
-- ItemScaling value by player level:
local item_scaling = {
   -- ten levels per line
     3,   3,   4,   4,   5,   6,   6,   7,   7,   8,
     8,   9,   9,  10,  10,  11,  11,  12,  12,  13,
    13,  14,  14,  15,  15,  16,  16,  17,  17,  18,
    18,  19,  19,  20,  20,  21,  21,  22,  22,  23,
    23,  24,  24,  25,  25,  26,  26,  27,  27,  28,
    28,  29,  29,  30,  30,  31,  31,  32,  32,  32,
    35,  37,  39,  39,  40,  40,  41,  44,  44,  44,
    44,  44,  45,  46,  49,  49,  50,  50,  51,  51,
    52,  52,  54,  56,  57,  60,  61,  62,  64,  67,
   101, 118, 139, 162, 190, 225, 234, 242, 252, 261}

local function getDeathStrikeHeal(forceUseScentStacks)
   --Death strike tooltip heal without versatility multiplier
   local baseAP, plusAP, minusAP = UnitAttackPower("player")
   local base_heal = (baseAP + plusAP - minusAP) * 5

   --Clean versatility value from items
   local mastery = 0.01 * GetMasteryEffect("player")

   --versatility as % multiplier; calculation based on "damage done",
   --which is currently == to "healing done", and this is stolen from
   --PaperDollFrame.lua from the Blizzard FrameXML code.
   local versatility = 1 + (
      0.01 * (GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE) +
            GetVersatilityBonus(CR_VERSATILITY_DAMAGE_DONE)))


   --Scent of Blood multiplier
   local SoB = 1 + (c.GetBuffStack("Scent of Blood") * 0.2)
   if not forceUseScentStacks and c.IsCasting("Death Strike") then
      SoB = 1
   end

   --Base resolve out of combat
   local stamina = UnitStat("player",3)
   local resolve_base = stamina / 250.0 / (item_scaling[UnitLevel("Player")] or 1)
   local resolve_buff = select(17, UnitBuff("player", GetSpellInfo(c.GetID("Resolve")))) or 0

   --Resolve: http://us.battle.net/wow/en/forum/topic/13087818929#2
   local resolve = 1 + (resolve_buff / stamina / 60 * 0.25 + resolve_base)

   -- Dark Succor doubles DS healing...
   local dark_succor = c.HasBuff("Dark Succor") and 2 or 1

   -- finally, our healing estimate.
   return (((((base_heal * versatility) * SoB) * mastery) * resolve) * dark_succor)
end

function a.ShouldDeathStrikeForHealth()
   local health = c.GetHealth("player") + getDeathStrikeHeal()
   if c.IsCasting("Death Strike") then
      health = health + getDeathStrikeHeal(true)
   end

   -- allow up to 2.5 percent max health overheal
   return health <= (s.MaxHealth("player") * 1.025)
end

function a.shouldDeathStrikeForShield()
   return c.GetBuffDuration("Blood Shield") < 2 and
      not c.IsCasting("Death Strike")
end

addOptionalDKSpell("Blood Presence", nil, {
   Type = "form"
})

addDKSpell("Death Strike")

addDKSpell("Death Strike", "for Health", {
   CheckFirst = a.ShouldDeathStrikeForHealth,
   GetDelay = function(spell)
      a.DebugThisSpell = true
      local delay = getDelayForSpell(spell)
      a.DebugThisSpell = false
      return delay
   end,
})

addOptionalDKSpell("Death Strike", "with Dark Succor", {
   CheckFirst = function()
      return c.HasBuff("Dark Succor") and a.ShouldDeathStrikeForHealth()
   end
})

addDKSpell("Death Strike", "to Save Shield", {
    CheckFirst = a.shouldDeathStrikeForShield
})

addDKSpell("Death Strike", "if Two Available", {
   -- @todo danielp 2014-11-16: can we optimize this?
   CheckFirst = function()
      local avail = a.PendingDeathRunes
      if a.Runes[BLOOD1].Type == "death" and runeAvailable(BLOOD1, 1) then
         avail = avail + 1
      end
      if a.Runes[BLOOD2].Type == "death" and runeAvailable(BLOOD2, 1) then
         avail = avail + 1
      end
      if runeAvailable(FROST1, 1) then
         avail = avail + 1
      end
      if runeAvailable(FROST2, 1) then
         avail = avail + 1
      end
      if runeAvailable(UNHOLY1, 1) then
         avail = avail + 1
      end
      if runeAvailable(UNHOLY2, 1) then
         avail = avail + 1
      end
      return avail >= 4
   end
})

addOptionalDKSpell("Blood Tap", "for Death Strike", {
   NoGCD = true,
   Melee = true,
   CheckFirst = function()
      return a.BloodCharges >= 5
         and (a.ShouldDeathStrikeForHealth() or a.shouldDeathStrikeForShield())
         and canBloodTapForDeathStrike()
   end
})

addDKSpell("Death Siphon", "for Health", {
   CheckFirst = function()
      -- use the same criteria as for Death Strike, so we know Death Siphon
      -- is only used when Death Strike cannot be
      return a.ShouldDeathStrikeForHealth()
   end
})

addDKSpell("Outbreak", "Early", {
   Applies = { "Blood Plague", "Frost Fever" },
   Cooldown = 60,
   CheckFirst = function()
      return not hasBothDiseases(5)
   end
})

addDKSpell("Outbreak", "Early, Glyphed", {
   Applies = { "Blood Plague", "Frost Fever" },
   Cooldown = 60,
   CheckFirst = function()
      return c.HasGlyph("Outbreak") and not hasBothDiseases(5)
   end
})

addDKSpell("Death Coil")

addDKSpell("Death Coil", "1 Rune to cap", {
    CheckFirst = function() return a.RP > 90 end
})

addDKSpell("Death Coil", "2 Runes to cap", {
    CheckFirst = function() return a.RP > 80 end
})

addDKSpell("Death and Decay", "Free", {
   NoRangeCheck = true,
   Cooldown = 30,
   Costs = {
      Blood = 0,
      Frost = 0,
      Unholy = 0,
      Death = 0,
   },
   CheckFirst = function()
      return a.CrimsonScourge
   end
})

addDKSpell("Blood Boil", "BB", {
   Melee = true,
   CheckFirst = function()
      -- blood runes only, forbid death runes
      return sufficientRunes(2, 0, 0, 0, true)
   end
})

addDKSpell("Blood Boil", "FFDD", {
   Melee = true,
   CheckFirst = function()
      -- two frost and two death
      return (sufficientRunes(0, 2, 0, 2) and sufficientRunes(0, 0, 2, 0, true))
   end
})

addDKSpell("Blood Boil", "B, if safe", {
   Melee = true,
   CheckFirst = function()
      -- Blood runes only, forbid death runes
      if not sufficientRunes(1, 0, 0, 0, true) then
         return false
      end

      -- only if we are not using RE, for which we should keep our
      -- second B rune active at all times.
      if c.HasTalent("Runic Empowerment") then
         return false
      end

      -- If we are in execute range, we want to hold our B for SR,
      -- too, so ensure that we will have a B rune ready by the time
      -- SR rolls around.
      --
      -- @todo danielp 2014-11-16:
      -- sanity check: is this gonna get messed up if things regen
      -- as death runes, which we don't want to spend on SR?
      -- I think we are actually safe on that front.
      if not a.InExecute then
         return true
      end

      -- @todo danielp 2014-11-16: restore this by using GetDelay on SR.
      -- if not soulReaperIsReady(max(a.Runes[1].Delay, a.Runes[2].Delay)) then
      --    return false
      -- end

      -- wow, everything passed!
      return true
   end
})

addDKSpell("Blood Boil", "for diseases", {
   Melee = true,
   CheckFirst = function()
      return hasBothDiseases(0) and not hasBothDiseases(3)
   end
})

addDKSpell("Blood Boil", "Free", {
   Melee = true,
   CheckFirst = function()
      return a.CrimsonScourge
   end
})

addDKSpell("Soul Reaper - Blood", "B", {
   Cooldown = 6,
   MyDebuff = "Soul Reaper Debuff",
   CheckFirst = function()
      return soulReaperIsUsable() and sufficientRunes(1, 0, 0, 0, true)
   end
})

addOptionalDKSpell("Rune Tap", nil, {
   NoGCD = true,
   Score = 3,
})

addOptionalDKSpell("Rune Tap", "with more than one charge", {
   NoGCD = true,
   Score = 3,
   CheckFirst = function()
      return c.GetChargeInfo("Rune Tap") > 1
   end
})

addOptionalDKSpell("Dancing Rune Weapon", nil, {
   NoGCD = true,
   Melee = true,
   Cooldown = 90,
   CheckFirst = function()
      return not c.WearingSet(4, "BloodT16")
   end,
})

addOptionalDKSpell("Dancing Rune Weapon", "Prime", {
   NoGCD = true,
   Melee = true,
   Cooldown = 90,
   CheckFirst = function()
      return (c.WearingSet(4, "BloodT16")
            and (not (runeAvailable(BLOOD1)  or runeAvailable(BLOOD2) or
                      runeAvailable(UNHOLY1) or runeAvailable(UNHOLY2))))
         or c.InDamageMode()
   end,
})

addOptionalDKSpell("Bone Shield", nil, {
   Cooldown = 60,
   CheckFirst = function()
      if s.InCombat() then
         return not c.HasBuff("Bone Shield")
      elseif x.EnemyDetected then
         return c.GetBuffDuration("Bone Shield") < 60
            or s.BuffStack(c.GetID("Bone Shield"), "player") < 6
      end
   end
})

addOptionalDKSpell("Vampiric Blood", nil, {
   NoGCD = true,
   Cooldown = 60,
   CheckFirst = function()
      return not c.IsSolo() or sufficientResources(c.GetID("Death Strike"))
   end,
   ShouldHold = function()
      -- if we would self-heal, this is probably appropriate.
      return not a.ShouldDeathStrikeForHealth()
   end,
})

addOptionalDKSpell("Death Pact", nil, {
   NoRangeCheck = 1,
   Cooldown = 2 * 60,
   ShouldHold = function()
      return c.GetHealthPercent("player") > 45
   end
})

addOptionalDKSpell("Conversion", nil, {
   NoGCD = true,
   Buff = "Conversion",
   CheckFirst = function()
      return a.RP > 50 and not c.HasBuff("Conversion")
   end,
   ShouldHold = function()
      return c.GetHealthPercent("player") > 80
   end
})

addOptionalDKSpell("Conversion", "Cancel", {
   NoGCD = true,
   FlashColor = "red",
   CheckFirst = function()
      return c.HasBuff("Conversion", true)
         and not a.ShouldDeathStrikeForHealth()
   end
})

addOptionalDKSpell("Icebound Fortitude", "Unglyphed", {
   Score = 2,
   NoGCD = true,
   Cooldown = 180,
   Enabled = function()
      return not c.HasGlyph("Icebound Fortitude")
   end,
})

addOptionalDKSpell("Icebound Fortitude", "Glyphed", {
   Score = 2,
   NoGCD = true,
   Cooldown = 90,
   Enabled = function()
      return c.HasGlyph("Icebound Fortitude")
   end,
})

c.AddTaunt("Dark Command", nil, {
   NoGCD = true,
   Cooldown = 8,
})

c.AddTaunt("Death Grip", nil, {
   NoGCD = true,
   Cooldown = 8,
})

------------------------------------------------------------------------- Frost
addOptionalDKSpell("Frost Presence", nil, { Type = "form" })

addOptionalDKSpell("Pillar of Frost", nil, {
   NoGCD = true,
   Cooldown = 60,
})

addDKSpell("Frost Strike", nil, {
   Melee = true,
})

addDKSpell("Frost Strike", "when not pooling", {
   Melee = true,
   CheckFirst = function()
      return c.GetHealth("target") < (2 * s.MaxHealth("player"))
   end,
})

addDKSpell("Frost Strike", "under KM", {
   Melee = true,
   CheckFirst = function()
      return a.KillingMachine
   end
})

addDKSpell("Frost Strike", "for RE", {
   Melee = true,
   CheckFirst = function()
      return c.HasTalent("Runic Empowerment") and
         a.FullyDepleted() > 0 and
         (not a.Killing_machine or not sufficientResources(c.GetID("Obliterate"), false))
   end
})

addDKSpell("Frost Strike", "for BT", {
   Melee = true,
   CheckFirst = function()
      return c.HasTalent("Blood Tap") and
         a.BloodCharges <= 10 and
         (not a.Killing_machine or not sufficientResources(c.GetID("Obliterate"), false))
   end
})

addDKSpell("Frost Strike", "for OB cap", {
   Melee = true,
   CheckFirst = function()
      return a.RP > 76 and
         sufficientResources(c.GetID("Obliterate"), false)
   end
})

addDKSpell("Frost Strike", "for HB cap", {
   Melee = true,
   UseJustBefore = "Howling Blast",
   CheckFirst = function()
      return a.RP > 88
   end
})

addDKSpell("Frost Strike", "for PS cap", {
   Melee = true,
   UseJustBefore = "Plague Strike for Blood Plague",
   CheckFirst = function()
      return a.RP > 88
   end
})

addDKSpell("Soul Reaper - Frost", nil, {
   Cooldown = 6,
   MyDebuff = "Soul Reaper Debuff",
   CheckFirst = soulReaperIsUsable,
})

addDKSpell("Blood Tap", "for Soul Reaper - Frost", {
   NoGCD = true,
   Melee = true,
   FlashID = { "Blood Tap", "Soul Reaper - Frost" },
   CheckFirst = function()
      return soulReaperIsUsable()
         and a.BloodCharges >= 5
         and a.FullyDepleted() > 0
   end
})

addDKSpell("Blood Tap", "for OB KM", {
   NoGCD = true,
   Melee = true,
   FlashID = { "Blood Tap", "Obliterate" },
   CheckFirst = function()
      return a.KillingMachine
         and a.BloodCharges >= 5
         and (a.PendingDeathRunes > 0
            or runeAvailable(BLOOD1)
            or runeAvailable(BLOOD2)
            or runeAvailable(FROST1)
            or runeAvailable(FROST2)
            or runeAvailable(UNHOLY1)
            or runeAvailable(UNHOLY2))
   end
})

addOptionalDKSpell("Blood Tap", "at 8 or Non-Execute", {
   NoGCD = true,
   CheckFirst = function()
      if a.FullyDepleted() <= 0 then
         return false
      end

      if a.BloodCharges >= 8 then
         return true
      end

      return a.BloodCharges >= 5 and not a.InExecute
   end
})

addDKSpell("Howling Blast")

addDKSpell("Howling Blast", "for Frost Fever", {
   Applies = { "Frost Fever" },
   CheckFirst = function()
      return not hasFrostFever(0)
   end
})

addDKSpell("Howling Blast", "under Freezing Fog", {
   CheckFirst = function()
      return a.FreezingFog > 0
   end
})

addDKSpell("Obliterate")

local function checkObliterateUnholyWithoutKillingMachine()
   return (runeAvailable(UNHOLY1, nil, true) or runeAvailable(UNHOLY2, nil, true)) and
      not a.KillingMachine
end

addDKSpell("Obliterate", "U w/out KM", {
   GetDelay = function()
      if a.KillingMachine then
         return false
      end

      local runes = {}
      if a.Runes[UNHOLY1].Type ~= "death" then
         tinsert(runes, a.Runes[UNHOLY1])
      end
      if a.Runes[UNHOLY2].Type ~= "death" then
         tinsert(runes, a.Runes[UNHOLY2])
      end

      if #runes > 0 then
         return getRuneDelay(1, unpack(runes))
      else
         return false
      end
   end,
})

addDKSpell("Frost Strike", "for Oblit cap no KM", {
   Melee = true,
   UseJustBefore = "Obliterate U w/out KM",
   CheckFirst = function()
      return a.RP > 76
   end
})


addDKSpell("Obliterate", "under KM", {
   CheckFirst = function()
      return a.KillingMachine
   end
})

addDKSpell("Obliterate", "BB or FF or UU", {
   CheckFirst = function()
      return (a.BothRunesAvailable("blood", 1)
            or a.BothRunesAvailable("frost", 1)
            or a.BothRunesAvailable("unholy", 1))
   end
})

addDKSpell("Death and Decay", "U", {
   NoRangeCheck = true,
   Cooldown = 30,
   CheckFirst = function()
      return sufficientRunes(0, 0, 1, 0, true)
   end
})

addOptionalDKSpell("Death and Decay", "U, optional", {
   NoRangeCheck = true,
   Cooldown = 30,
   CheckFirst = function()
      return sufficientRunes(0, 0, 1, 0, true)
   end
})

addDKSpell("Plague Strike", "U", {
   CheckFirst = function()
      return sufficientRunes(0, 0, 1, 0, true)
   end
})

addDKSpell("Plague Strike", "UU", {
   CheckFirst = function()
      return sufficientRunes(0, 0, 2, 0, true)
   end
})

------------------------------------------------------------------------ Unholy
addOptionalDKSpell("Unholy Presence", nil, {
   Type = "form",
})

addDKSpell("Soul Reaper - Unholy", nil, {
   Cooldown = 6,
   MyDebuff = "Soul Reaper Debuff",
   CheckFirst = soulReaperIsUsable,
})

addDKSpell("Blood Tap", "for Soul Reaper - Unholy", {
--      NoGCD = true,
   Melee = true,
   FlashID = { "Blood Tap", "Soul Reaper - Unholy" },
   CheckFirst = function()
      return soulReaperIsUsable()
         and a.BloodCharges >= 5
         and a.FullyDepleted() > 0
   end
})

addDKSpell("Plague Strike", "for Diseases", {
   CheckFirst = function()
      return not hasBothDiseases(0)
   end
})

addOptionalDKSpell("Summon Gargoyle", nil, {
   Cooldown = 180,
})

local function shouldDT()
   if s.Buff(c.GetID("Dark Transformation"), "pet")
      or c.IsAuraPendingFor("Dark Transformation") then

      return false
   end

   local stacks = s.BuffStack(c.GetID("Shadow Infusion"), "pet")
   if a.ShadowInfusionPending or c.IsCasting("Death Coil") then
      stacks = stacks + 1
   end
   return stacks >= 5
end

addDKSpell("Dark Transformation", nil, {
   CheckFirst = shouldDT,
})

addDKSpell("Blood Tap", "for Dark Transformation", {
--      NoGCD = true,
   FlashID = { "Blood Tap", "Dark Transformation" },
   CheckFirst = function()
      return a.BloodCharges >= 5
         and a.FullyDepleted() > 0
         and shouldDT()
   end
})

addDKSpell("Death and Decay", "UU", {
   NoRangeCheck = true,
   Cooldown = 30,
   CheckFirst = function()
      return a.BothRunesAvailable("unholy", 1)
   end
})

addDKSpell("Death and Decay", "unless Soul Reaper", {
   NoRangeCheck = true,
   Cooldown = 30,
   CheckFirst = function()
      return not a.InExecute
      -- @todo danielp 2014-11-16: fix is usable for delay
         or not soulReaperIsUsable(1)
         or sufficientRunes(0, 0, 2, 0, false)
   end
})

addOptionalDKSpell("Blood Tap", "for D&D", {
--      NoGCD = true,
   FlashID = { "Blood Tap", "Death and Decay" },
   CheckFirst = function()
      return canManuallyBloodTap()
         and c.GetCooldown("Death and Decay") == 0
         and not c.IsCasting("Death and Decay")
   end
})

addOptionalDKSpell("Blood Tap", "for D&D UU", {
--      NoGCD = true,
   FlashID = { "Blood Tap", "Death and Decay" },
   CheckFirst = function()
      return canManuallyBloodTap()
         and c.GetCooldown("Death and Decay") == 0
         and not c.IsCasting("Death and Decay")
         and a.BothRunesAvailable("unholy")
   end
})

addDKSpell("Scourge Strike", "UU", {
   CheckFirst = function()
      return a.BothRunesAvailable("unholy", 1)
   end
})

addDKSpell("Scourge Strike", nil, {
   CheckFirst = function()
      -- !(target.health.pct-3*(target.health.pct%target.time_to_die)<=45)
      -- aims to predict just ahead of the execute window.

      -- two death, or one unholy and one death
      return sufficientRunes(0, 0, 0, 2)
         or (sufficientRunes(0, 0, 1, 1) and sufficientRunes(0, 0, 1, 0, true))
   end
})
addDKSpell("Scourge Strike", "one unholy only", {
   CheckFirst = function()
      return sufficientRunes(0, 0, 1, 0, true)
         and not a.BothRunesAvailable("unholy", 1)
   end
})

addDKSpell("Festering Strike")

addDKSpell("Festering Strike", "BBFF", {
   CheckFirst = function()
      return a.BothRunesAvailable("blood", 1)
         and a.BothRunesAvailable("frost", 1)
   end
})

addDKSpell("Death Coil", "under Sudden Doom or for Dark Transformation", {
   CheckFirst = function()
      if c.HasBuff("Sudden Doom") and not c.IsCasting("Death Coil") then
         return true
      end

      -- @todo danielp 2014-11-28: do we still need this delay?  the value
      -- feels like an artifact of the server processing events across actors
      -- in a batch every 600ms, which has gone away now in WoD.
      if GetTime() - a.DTCast < .8
         or s.BuffDuration(c.GetID("Dark Transformation"), "pet") > c.GetBusyTime()
         or c.IsCasting("Dark Transformation")
      then
         return false
      end

      -- death_coil,if=buff.dark_transformation.down&rune.unholy<=1
      if runeAvailable(UNHOLY1, 1) and runeAvailable(UNHOLY2, 1) then
         return false
      end

      return true

      -- @todo danielp 2014-11-28: should this still apply?
      -- make sure unholy runes stay on cooldown?
      -- local runes = a.PendingDeathRunes
      -- if runeAvailable(BLOOD1, 1) and a.Runes[1].Type == "death" then
      --    runes = runes + 1
      -- end
      -- if runeAvailable(BLOOD2, 1) and a.Runes[2].Type == "death" then
      --    runes = runes + 1
      -- end
      -- if runeAvailable(FROST1, 1) and a.Runes[5].Type == "death" then
      --    runes = runes + 1
      -- end
      -- if runeAvailable(FROST2, 1) and a.Runes[6].Type == "death" then
      --    runes = runes + 1
      -- end
      -- if runeAvailable(UNHOLY1, 1) then
      --    runes = runes + 1
      -- end
      -- if runeAvailable(UNHOLY2, 1) then
      --    runes = runes + 1
      -- end
      -- return runes <= 1
   end
})

addDKSpell("Death Coil", "unless Gargoyle or Dark Transformation", {
   CheckFirst = function()
      local dt
      if c.IsAuraPendingFor("Dark Transformation") then
         dt = 30
      else
         dt = s.BuffDuration(c.GetID("Dark Transformation"), "pet")
            - c.GetBusyTime()
         if dt <= 0 then
            return true
         end
      end

      return dt > 8
         and (c.GetCooldown("Summon Gargoyle") > 8
            or c.IsCasting("Summon Gargoyle"))
   end
})

addOptionalDKSpell("Blood Tap", "at 10 with 30 RP", {
   NoGCD = true,
   CheckFirst = function()
      return canManuallyBloodTap(10) and a.RP >= 30
   end
})

addOptionalDKSpell("Blood Tap", "at 10", {
   NoGCD = true,
   CheckFirst = function()
      return canManuallyBloodTap(10)
   end
})

addOptionalDKSpell("Blood Tap", "for DC cap", {
   NoGCD = true,
   UseJustBefore = "Death Coil under Sudden Doom or for Dark Transformation",
   CheckFirst = function()
      return canManuallyBloodTap(10)
   end
})
