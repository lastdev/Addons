local g = BittensGlobalTables
local c = g.GetTable("BittensSpellFlashLibrary")
local u = g.GetTable("BittensUtilities")
if u.SkipOrUpgrade(c, "Flashing", tonumber("20141220081111") or time()) then
   return
end

local CalendarGetDate = CalendarGetDate
local GetItemCount = GetItemCount
local GetZoneText = GetZoneText
local max = math.max
local pairs = pairs
local select = select
local type = type
local format = string.format

local s = SpellFlashAddon
local x = s.UpdatedVariables

local overrideColor

c.AoeColor = { r = .25, g = .25, b = 1 }
c.MovementColor = "orange"

local function auraCheck(spell, id, pending, func, early)
   return id
      and (pending
         or func(id, spell.BuffUnit, early, nil, nil, spell.UseBuffID))
end

local function spellCastable(spell)
   if spell.Type == "form" and s.Form(spell.ID) then
      return false
   end

   if c.GetCooldown(spell.ID, spell.NoGCD) > 0 then
      return false -- TODO: Add lag or cushion?
   end

   local isUsable, notEnoughPower = s.UsableSpell(spell.ID)
   if notEnoughPower then
      if not spell.NoPowerCheck then
         return false
      end
   elseif not isUsable and not spell.EvenIfNotUsable then
      return false
   end

   if not (spell.NoRangeCheck or spell.Melee or spell.Range)
      and s.SpellHasRange(spell.ID)
      and not s.SpellInRange(spell.ID)
   then
      return false
   end

   return true
end

local function getFlashColor(spell, rotation)
   return spell.FlashColor
      or (c.AoE and (rotation and rotation.AoEColor or c.AoeColor))
end

local function flashable(spell)
   if spell.RunFirst then
      spell:RunFirst()
   end
   if spell.CheckFirst and not spell:CheckFirst() then
      return false
   end

   if (spell.NotIfActive or spell.Cooldown) and c.IsCasting(spell.ID) then
      return false
   end

   if spell.Buff
      or spell.MyDebuff
      or spell.Debuff
      or spell.MyBuff
      or spell.Interrupt
      or spell.Dispel
   then

      local early =
         c.GetBusyTime(spell.NoGCD) + max(0, c.GetCastTime(spell.ID) or 0)
      if spell.Interrupt
         and s.GetCastingOrChanneling(nil, nil, true) - early <= 0 then

         return false -- TODO: Add lag or cushion?
      end

      if spell.Dispel
         and not s.Buff(nil, nil, early, nil, nil, nil, spell.Dispel) then

         return false
      end

      local pending = c.IsAuraPendingFor(spell.ID)
      early = early + (spell.EarlyRefresh or 0)
      if auraCheck(spell, spell.Buff, pending, s.Buff, early)
         or auraCheck(spell, spell.MyDebuff, pending, s.MyDebuff, early)
         or auraCheck(spell, spell.Debuff, pending, s.Debuff, early)
         or auraCheck(spell, spell.MyBuff, pending, s.MyBuff, early) then

         return false
      end
   end

   if spell.Melee and not s.MeleeDistance() then
      return false
   end

   if spell.Range and c.DistanceAtTheMost() > spell.Range then
      return false
   end

   if spell.NotWhileMoving and s.Moving("player") then
      return false
   end

   local flashableFunc = nil
   local castableFunc
   if spell.Type == "item" then
      flashableFunc = s.ItemFlashable
      castableFunc = s.CheckIfItemCastable
   elseif spell.Type == "pet" then
      castableFunc = s.CheckIfPetSpellCastable
   elseif spell.Type == "form" then
      castableFunc = spellCastable
   else
      flashableFunc = s.Flashable
      castableFunc = spellCastable
   end

   if spell.Override then
      castableFunc = spell.Override
   end
   local flashID = spell.FlashID or spell.ID
   if (flashableFunc and not flashableFunc(flashID))
      or not castableFunc(spell)
      or (spell.CheckLast and not spell:CheckLast())
   then
      return false
   end

   return true
end

local function flashSingle(spell, name, rotation)
   if not flashable(spell) then
      return false
   end

   local flashFunc1 = s.Flash
   local flashFunc2 = nil
   if spell.Type == "item" then
      flashFunc1 = s.FlashItem
   elseif spell.Type == "pet" then
      flashFunc2 = s.FlashPet
   elseif spell.Type == "form" then
      flashFunc2 = s.FlashForm
   end

   local flashID = spell.FlashID or spell.ID
   local color = overrideColor or getFlashColor(spell, rotation)
   flashFunc1(flashID, color, spell.FlashSize)
   if flashFunc2 then
      flashFunc2(flashID, color, spell.FlashSize)
   end
   if spell.PredictFlashID then
      c.PredictFlash(spell.PredictFlashID)
   end
   if name then
      c.Flashing[name] = true
   end
   return true
end

function c.Flashable(name)
   return flashable(c.GetSpell(name))
end

function c.PredictFlash(name)
   s.Flash(c.GetID(name), "green", s.FlashSizePercent() / 2)
end

function c.PriorityFlash(...)
   local flashed = nil
   local moving = s.Moving("player")
   local rotation = c.GetCurrentRotation()
   local movementFallthrough =
      not overrideColor and rotation.MovementFallthrough
   for i = 1, select("#", ...) do
      local name = select(i, ...)
      local spell = c.GetSpell(name)
      local canCastWhileMoving = spell.CanCastWhileMoving
      if canCastWhileMoving == nil then
         canCastWhileMoving = c.GetCastTime(spell.ID) == 0
      end
      if (canCastWhileMoving or not moving or overrideColor == nil)
         and flashSingle(spell, name, rotation) then

         flashed = name
         if not spell.Continue then
            if moving and movementFallthrough and not canCastWhileMoving then
               overrideColor = c.MovementColor
            else
               movementFallthrough = nil
               break
            end
         end
      end
   end
   if c.DebugLastFlashedSpell ~= flashed then
      local targets = format("T:%d/%d", c.EstimatedHarmTargets, c.EstimatedHealTargets)

      if rotation.ExtraDebugInfo then
         c.Debug("Flash", targets, rotation.ExtraDebugInfo(), flashed)
      else
         c.Debug("Flash", targets, flashed)
      end
      c.DebugLastFlashedSpell = flashed
   end
   if movementFallthrough and overrideColor then
      rotation:MovementFallthrough()
   end
   overrideColor = nil
   return flashed
end

local function auraDelay(spell, aura, func, early)
   if aura then
      return func(aura, false, spell.UseBuffID, spell.ID) - early
   else
      return 0
   end
end

local function getDelay(spell)
   if spell.RunFirst then
      spell:RunFirst()
   end

   if spell.CheckFirst and not spell:CheckFirst() then
      return false
   end

   if spell.Melee then
      if not s.MeleeDistance() then
         return nil
      end
   elseif not spell.NoRangeCheck
      and s.SpellHasRange(spell.ID)
      and not s.SpellInRange(spell.ID) then

      return false
   end

   if spell.Type == "form" and c.IsCasting(spell.ID) then
      return false
   end

   if spell.Range and c.DistanceAtTheMost() > spell.Range then
      return nil
   end

   -- TODO support items? forms? pet spells?
   if not s.Flashable(spell.FlashID or spell.ID) then
      return nil
   end

   if spell.GetDelay then
      return spell:GetDelay()
   end

   local early = (spell.EarlyRefresh or 0) + c.GetCastTime(spell.ID)
   return max(
      auraDelay(spell, spell.Buff, c.GetBuffDuration, early),
      auraDelay(spell, spell.MyDebuff, c.GetMyDebuffDuration, early),
      auraDelay(spell, spell.Debuff, c.GetDebuffDuration, early),
      auraDelay(spell, spell.MyBuff, c.GetMyBuffDuration, early),
      spell.Cooldown
         and c.GetCooldown(spell.ID, spell.NoGCD, spell.Cooldown)
         or 0)
end

local function delayFlash(spell, delay, minDelay, rotation)
   if minDelay > 0 or delay + (spell.WhiteFlashOffset or 0) > 0 then
--c.Debug("delayFlash", s.SpellName(spell.ID), delay, minDelay, "green")
      s.Flash(spell.FlashID or spell.ID, "green", s.FlashSizePercent() / 2)
      return true
   else
--c.Debug("delayFlash", s.SpellName(spell.ID), delay, minDelay, "white")
      s.Flash(
         spell.FlashID or spell.ID,
         getFlashColor(spell, rotation),
         spell.FlashSize)
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
function c.DelayPriorityFlash(...)
   local minDelay = 0
   local nextDelay = 9999
   local nextSpell
   local nextSpellName
   local nextSpellMinDelay
   local rotation = c.GetCurrentRotation()
   local continuers = { }
   local continuerMinDelays = { }
   local pusherMins = { }
   local pusherGoals = { }
   for i = 1, select("#", ...) do
      if nextDelay > minDelay then
         local name = select(i, ...)
         local spell = c.GetSpell(name)
         local delay, modDelay = getDelay(spell)
--c.Debug("DelayPriorityFlash", name, delay, modDelay)
         if delay then
            if spell.IsMinDelayDefinition then
               if modDelay then
                  pusherMins[spell] = delay - modDelay
                  pusherGoals[spell] = delay
               else
                  minDelay = max(minDelay, delay)
               end
            else
               delay = max(delay, minDelay)
               for k, pusherMin in pairs(pusherMins) do
                  if delay > pusherMin then
                     delay = max(delay, pusherGoals[k])
                  end
               end
               if delay < nextDelay and (not modDelay or delay <= modDelay) then
--c.Debug("DelayPriorityFlash", "  ^ use it", delay)
                  if spell.Continue then
                     continuers[spell] = delay
                     continuerMinDelays[spell] = minDelay
                  else
                     nextDelay = delay
                     nextSpell = spell
                     nextSpellName = name
                     nextSpellMinDelay = minDelay
                  end
               end
            end
         end
      end
   end
   for spell, delay in pairs(continuers) do
      if delay <= nextDelay then
         delayFlash(spell, delay, continuerMinDelays[spell], rotation)
      end
   end
   if nextSpell then
      if c.DebugLastFlashedSpell ~= nextSpellName then
         local targets = format("T:%d/%d", c.EstimatedHarmTargets, c.EstimatedHealTargets)
         if rotation.ExtraDebugInfo then
            c.Debug("Flash", targets, rotation.ExtraDebugInfo(), nextSpellName, nextDelay)
         else
            c.Debug("Flash", targets, nextSpellName, nextDelay)
         end
         c.DebugLastFlashedSpell = nextSpellName
      end
      return nextSpellName, delayFlash(nextSpell, nextDelay, nextSpellMinDelay, rotation)
   end
end

function c.FlashAll(...)
   local flashed = false
   for i = 1, select("#", ...) do
      local name = select(i, ...)
      if flashSingle(c.GetSpell(name), name) then
         flashed = true
      end
   end
   return flashed
end

local healthstone = {
   ID = 5512,
   Type = "item",
   FlashColor = "yellow",
   CheckFirst = function(z)
      return c.GetHealthPercent("player") < 80
         and GetItemCount(z.ID, false, true) > 0
   end,
}

local function makeBuffItem(id, buffId)
   return {
      Type = "item",
      ID = id,
      Buff = buffId,
      BuffUnit = "player",
      FlashColor = "yellow",
      CheckFirst = function()
         return GetItemCount(id, false, true) > 0
      end,
   }
end

local bookOfTheAges = makeBuffItem(103642, 147226)
local singingCrystal = makeBuffItem(103641, 147055)
local dewOfEternalMorning = makeBuffItem(103643, 147476)
local celebrationPackage = makeBuffItem(90918, 132700)

function c.FlashCommonInCombat()
   flashSingle(healthstone)
end

function c.FlashCommonOutOfCombat(rotation)
   if x.EnemyDetected and rotation.UsefulStats then
      c.FlashFoods(rotation.UsefulStats)
   end
   if GetZoneText() == "Timeless Isle" then
      flashSingle(bookOfTheAges)
      flashSingle(singingCrystal)
      flashSingle(dewOfEternalMorning)
   end

   local _, month, day, year = CalendarGetDate()
   if (((month == 11 and day >= 18) or (month == 12 and day <= 2))
      and year == 2013) then

      flashSingle(celebrationPackage)
   end
end
