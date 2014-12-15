local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local x = s.UpdatedVariables
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local GetTime = GetTime
local math = math

------------------------------------------------------------------------ Common
local bothShouts = { c.GetID("Battle Shout"), c.GetID("Commanding Shout") }

local function chooseShout(z, fail)
  if fail then
    return false
  end
  
  local ap = s.Buff(c.ATTACK_POWER_BUFFS, "player")
  local sta = s.Buff(c.STAMINA_BUFFS, "player")
  local battleID = c.GetID("Battle Shout")
  local commandID = c.GetID("Commanding Shout")
  if s.MyBuff(battleID, "player") then
    return false --z.FlashID = battleID
  elseif s.MyBuff(commandID, "player") then
    return false --z.FlashID = commandID
  elseif ap and sta then
    z.FlashID = bothShouts
  elseif ap then
    return false --z.FlashID = commandID
  elseif sta then  
    return false --z.FlashID = battleID
  else
    z.FlashID = bothShouts
  end
  return true
end

local function noRoomForShoutRage()
  if c.HasGlyph("Hoarse Voice") then
    return a.EmptyRage < 15
  else
    return a.EmptyRage < 30
  end
end

local function rageAfterHeroicStrike()
  if c.GetCooldown("Heroic Strike", false, 1.5) == 0 then
    return a.Rage - 30
  else
    return a.Rage
  end
end

c.AddSpell("Shout", nil, {
  ID = "Battle Shout",
  CheckFirst = chooseShout
})

c.AddSpell("Shout", "for Rage", {
  ID = "Battle Shout",
  CheckFirst = function(z)
    return chooseShout(z, noRoomForShoutRage())
  end
})

c.AddOptionalSpell("Shout", "for Buff", {
  ID = "Battle Shout",
  CheckFirst = function(z)
    if not x.EnemyDetected then
      return false
    end
    
    local ap = c.RaidBuffNeeded(c.ATTACK_POWER_BUFFS)
    local sta = c.RaidBuffNeeded(c.STAMINA_BUFFS)
    local battleID = c.GetID("Battle Shout")
    local commandID = c.GetID("Commanding Shout")
    if s.MyBuff(battleID, "player") then
      z.FlashID = battleID
      return ap
    elseif s.MyBuff(commandID, "player") then
      z.FlashID = commandID
      return sta
    elseif ap and sta then
      z.FlashID = bothShouts
    elseif ap then
      z.FlashID = battleID
    elseif sta then
      z.FlashID = commandID
    else
      return false
    end
    return true
  end,
})

--TALENT
--You become a whirling storm of destructive force, striking 
--all targets within 8 yards for 120% weapon damage every 1 sec 
--for 6 sec.
--During a Bladestorm, you can continue to dodge, block, and parry, 
--and are immune to movement impairing and loss of control effects. 
--However, you can only perform shout abilities.
c.AddSpell("Bladestorm", nil, {
  Melee = true,
})

--TALENT
--Sends a wave of force in a frontal cone before you, 
--causing (75 / 100 * Attack power) damage and stunning 
--all enemy targets within 10 yards for 4 sec.
--Causing damage to 3 or more targets lowers the cooldown 
--of the next Shockwave by 20 sec.
c.AddSpell("Shockwave", nil, {
  Melee = true,
  CheckFirst = function()
     return s.HealthPercent() > 20 and not c.HasTalent("Unquenchable Thirst")
  end
})

--SPELL:
--Leap through the air towards a targeted location, slamming 
--down with destructive force to deal 1 (+ 50% of Attack power) 
--Physical damage to all enemies within 8 yards.
c.MakeMini(c.AddOptionalSpell("Heroic Leap", nil, {
  NoGCD = true,
--  CheckFirst = function()
--    return a.Smash > 0 and not c.IsSolo()
--  end
}))

local function victoryHealable()
  if a.VictoriousDuration > 4 
    and c.HasGlyph("Victory Rush") 
    and not c.HasTalent("Impending Victory") then
    
    return c.GetHealthPercent("player") < 70
  else
    return c.GetHealthPercent("player") < 80
  end
end

--TALENTS:
--Instantly attack the target, causing (200% of Attack power) 
--damage and healing you for 15% of your maximum health.
--Killing an enemy that yields experience or honor resets 
--the cooldown of Impending Victory.
--Replaces Victory Rush.
c.AddSpell("Impending Victory", nil, {
  Melee = true,
})

c.AddSpell("Impending Victory", "for Heals", {
  Melee = true,
  CheckFirst = victoryHealable,
})

c.AddSpell("Impending Victory", "for Free", {
  Melee = true, 
  CheckFirst = function()
    return a.VictoriousDuration > 0
  end
})

c.AddSpell("Impending Victory", "unless Execute", {
  Melee = true, 
  CheckFirst = function()
    return not a.InExecute or a.VictoriousDuration > 0
  end
})

c.AddOptionalSpell("Impending Victory", "for Heals, Optional", {
  Melee = true,
  CheckFirst = victoryHealable,
})

c.AddSpell("Victory Rush", nil, {
  Melee = true,
  CheckFirst = function()
    return a.VictoriousDuration > 0
  end,
})

c.AddSpell("Victory Rush", "for Heals", {
  Melee = true,
  CheckFirst = function()
    return a.VictoriousDuration > 0 and victoryHealable()
  end,
})

c.AddOptionalSpell("Victory Rush", "for Heals, Optional", {
  Melee = true,
  CheckFirst = function()
    return a.VictoriousDuration > 0 and victoryHealable()
  end,
})

--TALENT:
--Instantly heals you for 10% of your maximum health, 
--and an additional 20% over 5 sec.  Usable while stunned.
--c.AddOptionalSpell("Enraged Regeneration", nil, {
--  NoGCD = true,
--  NoPowerCheck = true,
--  CheckFirst = function()
--    return a.Enraged and c.GetHealthPercent("player") < 80
--  end,
--})

--TALENT:
--Every 30 rage that you spend reduces the remaining cooldown 
--of several of your abilities by 1 sec:
--  Avatar
--  Bloodbath
--  Bladestorm
--  Storm Bolt
--  Shockwave
--  Dragon Roar
--  Mocking Banner
--  Heroic Leap
--  Recklessness
--  Die by the Sword
c.AddOptionalSpell("Anger Management", nil, {
  NoGCD = true,
})

--TALENT:  Associated Buff: Avatar
--Transform into a colossus for 24 sec, dealing 20% 
--increased damage and removing all roots and snares.
c.AddOptionalSpell("Avatar", nil, {
  NoGCD = true,
  CheckFirst = function()
    local reckCd = c.GetCooldown("Recklessness", true, 180)
    return reckCd > 42 or reckCd < 6
  end
})

c.AddOptionalSpell("Sunder Armor", nil, {
  CheckFirst = function()
    return not c.IsSolo()
      and (c.GetDebuffStack(c.ARMOR_DEBUFFS) < 3
        or c.GetDebuffDuration(c.ARMOR_DEBUFFS) < 3)
  end
})

c.AddInterrupt("Pummel")
c.AddInterrupt("Disrupting Shout")

-------------------------------------------------------------------------- Arms
local rendUpTime = 0

local function getRendUptime(time)
   if rendUpTime == 0 then
      rendUpTime = GetTime()
    return true
   elseif (GetTime() - rendUpTime) >= 17 then
      rendUpTime = 0
    return true
   else
      return false
   end

end

-- A vicious strike that deals 225% Physical damage and costs 20 rage.
-- Costs 20 rage.
c.AddSpell("Mortal Strike", nil, {
  Melee = true,
  CheckLast = function()
     return not a.InExecute and a.MSIsUsable
  end
})

-- Wounds the target, causing (579.6% of Attack Power) bleed damage over 18 seconds and abilities
-- final burst (222.5% of Attack Power) bleed damage when the effect expires.
-- Costs 5 rage. 
c.AddSpell("Rend", nil, { 
  CheckFirst = function()
    return not c.HasMyDebuff("Rend")
  end
})
c.AddOptionalSpell("Recklessness", "for Arms", {
  CheckFirst = function(z)
    z.FlashSize = nil
    
    if c.IsSolo() or c.WearingSet(4, "DpsT14") then
      return true
    end
    
    if not a.InExecute then
      z.FlashSize = s.FlashSizePercent() / 2
    end
    return a.Bloodbath --or hasSmashFor(5)
  end
})

c.AddOptionalSpell("Bloodbath", "for Arms", {
  NoGCD = true,
  CheckFirst = function()
    return a.Rage >= 70 and a.smashPending > 0
  end
})

c.AddOptionalSpell("Berserker Rage", "for Arms", {
  NoGCD = true,
  CheckFirst = function()
    return not a.Enraged and a.EmptyRage >= 10
  end
})

c.AddOptionalSpell("Heroic Strike", "for Arms", {
  NoGCD = true,
  CheckFirst = function()
    return (a.EmptyRage < 15 and not a.InExecute)
      or (a.smashPending > 0 and a.Rage > 60 and c.WearingSet(2, "DpsT16"))
  end
})

c.AddOptionalSpell("Sweeping Strikes", nil, {
  NoGCD = true,
})

-- Hurls your weapon at an enemy, causing 60% Physical damage and stunning for 4 seconds.
-- Deals quadruple damage to targets permanently immune to stuns.
c.AddSpell("Storm Bolt", "for Arms", {
  CheckFirst = function()
    return a.smashPending > 0
  end
})

-- Roar explosively, dealing (156% of Attack Power) damage to all enemies within 8 yards
-- and knocking them back and down for 0.50 seconds.  Damage ignores all armor and is 
-- always a critical strike.
c.AddSpell("Dragon Roar", "for Arms", {
  Melee = true,
})

-- Smashes a target for 150% Physical damage and causes your attacks to bypass all of their 
-- armor for 6 seconds.  Bypasses less armor on players.
c.AddSpell("Colossus Smash", "for Arms", {
  Melee = true,
  Override = function()
    return a.CSIsUsable
  end
})

-- Attempt to finish off a wounded foe, causing 320% Physical damage. 
-- Only usable on enemies that have less than 20% health.
-- Costs 30 Rage
c.AddSpell("Execute", "for Arms", {
  CheckFirst = function()
    return a.InExecute or a.freeExecute
  end
})

-- Slam an opponent, causing 150% Physical damage.  Each consecutive use of Slam increases
-- the damage dealt by 50% and the Rage cost by 100%, stacking up to 2 times for 2 sec.
-- Costs 10 Rage.
c.AddSpell("Slam", nil, {
  CheckFirst = function(z)
      if c.GetBuffStack("Slam") == 1 then
       z.FlashSize = s.FlashSizePercent() * 0.75
    elseif c.GetBuffStack("Slam") == 2 then
       z.FlashSize = s.FlashSizePercent() * 1.5
    end
    return true
  end
})

c.AddSpell("Thunder Clap", nil, {
  Melee = true,
})

-- In a whirlwind of steel you attack all enemies within 8 yards, 
-- causing 100% Physical damage with your main-hand weapon to each enemy.
-- Costs 20 Rage.
c.AddSpell("Whirlwind", "for Arms", {
  Melee = true,
  CheckFirst = function()
    return a.Rage >= 20
  end,
})

-------------------------------------------------------------------------- Fury
-- 

local function shouldFlashBloodthirst()
  return (not a.InExecute)
    and not c.IsCasting("Bloodthirst")
end

local function getRagingBlowStacks(noGCD)
  local stacks = c.GetBuffStack("Raging Blow!", noGCD)
  if c.IsCasting("Enrage") then
    stacks = stacks + 1
  end
  if c.IsCasting("Raging Blow") then
    stacks = stacks - 1
  end
--  local str = tostring(math.min(math.max(0, stacks), 2))
  return math.min(math.max(0, stacks), 2) 
end

c.AddOptionalSpell("Berserker Rage", "for Fury", {
  NoGCD = true,
  CheckFirst = function()
     return not a.Enraged or (c.HasTalent("Unquenchable Thirst") and getRagingBlowStacks(true) < 2)
  end
})

c.AddOptionalSpell("Bloodbath", "for Fury", {
  NoGCD = true,
  CheckFirst = function() 
    return c.HasTalent("Bloodbath")
  end
})

-- Instantly strike the target for 50% Physical damage, generating 10 Rage, 
-- and restoring 1% of your health.
-- Bloodthirst has an additional 30% chance to be a critical strike.
-- Replaces Heroic Strike.
-- 4.5 sec. cooldown and instant cast, no cost
c.AddOptionalSpell("Bloodthirst", "early", {
  CheckFirst = function()
    return a.Rage < 80 and not c.HasTalent("Unquenchable Thirst")
  end
})

-- If it is up late in rotation, use it
c.AddOptionalSpell("Bloodthirst", "late", {
})

-- Deals 1,371 damage to all enemies within 8 yards and knocking 
-- them back and down for .5 sec.  Damage ignores all armor and is 
-- always a critical strike.
-- Cooldown is 1 min. and is an instant cast, no cost.
c.AddSpell("Dragon Roar", "for Fury", {
  Melee = true,
  NoGCD = false,
  CheckFirst = function()
    return a.Bloodbath or not c.HasTalent("Bloodbath")
  end
})

-- Attempt to finish off a wounded foe, causing 3,237 Physical damage 
-- with main-hand and 969 Physical damage with off-hand.  Only usable on 
-- enemies with less than 20% health. Cost is 30 rage unless Sudden Death is up.
-- Not using as optional spell, if this is ready, need to use it.
c.AddSpell("Execute", "for Fury", {
  CheckFirst = function()
    return a.InExecute or a.freeExecute
  end
})

c.AddOptionalSpell("Heroic Leap", "for Fury", {
  NoGCD = true,
--  CheckFirst = function()
--    return a.Smash > 0 and not c.IsSolo()
--  end
})

-- Throw your weapon at the enemy, causing 50% Physical damage.  Generates high threat.
-- Cast is instant with a 6 sec. cooldown.  Range is 8-30 yards
c.AddOptionalSpell("Heroic Throw", "for Fury", {
  NoGCD = false,
--  NoRangeCheck = false,
--  CheckFirst = function()
--    return a.EmptyRage <= 10
--      or (not a.InExecute and a.Rage >= 40 and a.smashPending > 0)
--  end
})

--Instantly attack the target, causing (200% of Attack power) damage and healing 
-- you for 15% of your maximum health.  Killing an enemy that yields experience or 
-- honor resets the cooldown of Impending Victory.  Replaces Victory Rush.
-- Cast is instant and cost is 10 rage with a 30 sec. cooldown.
c.AddOptionalSpell("Impending Victory", "for Fury", {
  Melee = true,
  NoGCD = false,
  CheckFirst = function()
    local usable, pwr = s.UsableSpell("Impending Victory")
    return usable and s.HealthPercent() >= 20 and not c.HasTalent("Unquenchable Thirst")
  end
})

-- A mighty blow that deals 200% Physical damage with your main-hand weapon and deals 200% 
-- Physical damage with your off-hand weapon.
-- Becoming Enraged enables one charge of Raging Blow.  Limit 2 charges.
-- Cost 10 rage and is instant cast
-- When Raging Blow is available, less than two charges
c.AddOptionalSpell("Raging Blow", nil, {
  Melee = true,
  NoGCD = false,
--  CheckFirst = function()
--    local usable, nuffpwer = s.UsableSpell("Raging Blow")
--    return usable
--  end
})

-- When Raging Blow has two charges
c.AddSpell("Raging Blow", "Prime", {
  Melee = true,
  NoGCD = false,
  CheckFirst = function()
    return not a.InExecute
      and getRagingBlowStacks() == 2
  end
})

c.AddSpell("Raging Blow", "AoE", {
  Melee = true,
  NoGCD = false,
  CheckFirst = function()
    local now = GetTime()
    if c.IsCasting("Raging Blow") or now - a.CleaverDumpPending < .8 then
      return false
    end
    
    local stack = c.GetBuffStack("Meat Cleaver")
    if GetTime() - a.CleaverPending < .8 then
      stack = stack + 1
    end
    return stack >= 3
  end
})

-- Grants your special attacks an additional 15% chance to critically strike and 
-- increases your critical strike damage by 10%. Lasts 10 sec. Using this ability 
-- in Defensive Stance activates Battle Stance.  Has 3 min. Cooldown.  If this is available,
-- I am gonna flash it
c.AddOptionalSpell("Recklessness", "for Fury", {
  NoGCD = true,
--  CheckFirst = function()
--     return s.HealthPercent() >= 96     -- Beginning of fight
--           or (a.InExecute and select(1,s.UsableSpell("Recklessness")))  -- Use before Execute
--           or (s.HealthPercent() < 20 and (c.HasTalent("Bloodbath") and c.HasBuff("Bloodbath"))) -- Boosts melee near end of fight
--           or  c.HasTalent("Anger Management") -- I don't know about this yet
--  end
})

-- Sends a wave of force in a frontal cone, causing (125% of Attack power) damage and stunning 
-- all enemies within 10 yards for 4 sec.  Cooldown reduced by 20 sec if it strikes at least 3 targets.
-- Cooldown is 40 sec and cast is instant
c.AddSpell("Shockwave", "for Fury", {
  NoGCD = false,
  CheckFirst = function()
     return not c.HasTalent("Unquenchable Thirst")
  end
})

-- Hurls your weapon at an enemy, causing 60% Physical damage and stunning for 4 sec.  
-- Deals quadruple damage to targets permanently immune to stuns.
-- Cast is instant with a 30 sec. cooldown.
c.AddSpell("Storm Bolt", "for Fury", { 
  NoGCD = false, 
 -- CheckLast = function()
 --   return select(1, s.UsableSpell("Storm Bolt"))
 -- end
})

-- In a whirlwind of steel you attack all enemies within 8 yards 
-- causing 100% Physical damage with main-hand to each enemy.
-- Cost is 20 rage and cast is instant
c.AddOptionalSpell("Whirlwind", "for Fury", {
  Melee = true,
  NoGCD = false,
  CheckFirst = function()
    return a.Rage >= a.maxPower - 20
  end,
})

-- A quick strike with your off-hand weapon that deals 375% Physical damage and 
-- reduces the effectiveness of healing on the target for 10 sec.  
-- Bloodthirst has a 20% chance of granting 2 charges of Wild Strike that cost no Rage.
-- Cost 45 rage and is instant
c.AddOptionalSpell("Wild Strike", "for Fury", {  
  NoPowerCheck = false,
  NoGCD = false,
  CheckLast = function()
    return a.Rage >= 110 and s.HealthPercent() > 20
  end
})

-- Bloodsurge is up so cost is zero, fire away ...
c.AddSpell("Wild Strike", "with Bloodsurge for Fury", {  
  NoPowerCheck = true,
  NoGCD = false,
  CheckFirst = function()
    return c.HasBuff("Bloodsurge")
  end
})

-- Enraged, so this would be a rage dump.
c.AddOptionalSpell("Wild Strike", "with Enrage for Fury", {  
  NoPowerCheck = true,
  CheckFirst = function()
    return a.Enraged and s.HealthPercent() > 20
  end
})

-------------------------------------------------------------------- Protection
local function shouldDumpProt()
  return c.HasBuff("Ultimatum", true) 
    or c.HasBuff("Incite", true)
    or (c.HasGlyph("Incite") and c.IsCasting("Demoralizing Shout"))
    or (a.EmptyRage < 20 and not c.IsTanking())
    or c.InDamageMode()
end

--You go berserk, removing and granting immunity to Fear,
--Sap, and Incapacitate effects for 6 sec.  Has a 30 sec. Cooldown.
c.AddOptionalSpell("Berserker Rage", "for Prot", {
  NoGCD = true,
  CheckFirst = function()
    return (c.IsTanking() or c.InDamageMode()) and c.GetCooldown("Berserker Rage") == 0
  end,
})

--  For the next 12 sec, your melee damage abilities and their multistrikes 
-- deal 30% additional  damage as a bleed over 6 sec. While bleeding, 
-- targets move 50% slower.  Has a 60 sec Cooldown
c.AddOptionalSpell("Bloodbath", "for Prot", {
  NoGCD = true,
  CheckFirst = function()
     return c.GetCooldown("Bloodbath")  == 0
  end,
})

c.AddOptionalSpell("Defensive Stance", nil, {
  Type = "form",
})

c.AddSpell("No Mitigation if Victory Available", nil, {
  ID = 0,
  RunFirst = function(z)
    z.ID = c.HasTalent("Impending Victory")
      and c.GetID("Impending Victory")
      or c.GetID("Victory Rush")
  end,
  ShouldHold = function()
    return true
  end
})

--10122014 rdh: Added Cooldown
--Demoralizes all enemies within 10 yards, reducing the
--damage they do to you by 20% for 8 sec.
c.AddOptionalSpell("Demoralizing Shout", "for Prot", {
  NoGCD = true,
  Melee = true,
  IsUp = function()
    return c.HasMyDebuff("Demoralizing Shout", true)
  end,
  CheckFirst = function(z)
    return not z.IsUp()
  end,
})

-- Deals 200% Physical damage, and has a 30% chance to reset the cooldown on 
-- Shield Slam and cause it to generate 5 more Rage.  GCD is 1.5 sec.
c.AddSpell("Devastate", "for Prot", {
  Melee = true,
  CheckFirst = function()
     return c.GetBuffStack("Unyielding Strikes") <= 5
  end,
})

-- Deals (165% of Attack Power) damage to all enemies within 8 yards and knocking 
-- them back and down for 0.5 sec.  Damage ignores all armor and is 
-- always a critical strike.
-- Cooldown is 1 min. and is an instant cast, no cost with GCD of 1.5 sec.
c.AddSpell("Dragon Roar", "for Prot", {
  Melee = true,
  CheckFirst = function()
    return c.HasTalent("Dragon Roar") and c.GetCooldown("Dragon Roar") == 0
  end
})

-- Instantly heals for 10% of your maximum health, and an additional
-- 20% over 5 sec.  Usable while stunned.
c.AddOptionalSpell("Enraged Regeneration", "for Prot", {
  NoGCD = true,
  NoPowerCheck = true,
--  CheckFirst = function()
--    return a.Enraged
--  end,
  ShouldHold = function()
    return c.GetHealthPercent("player") < 50
  end,
})

-- Attempt to finish off a wounded foe, causing
-- 3,237 Physical damage with main-hand and 969 
-- Physical damage with off-hand.  Only usable on 
-- enemies with less than 20% health.
c.AddSpell("Execute", "for Prot", {
  CheckFirst = function()
    return a.freeExecute or a.InExecute
  end
})

-- Instantly deals 105% Physical damage.  This ability is not on the global cooldown.
-- Costs 30 rage with 1.5 sec cooldown
c.AddSpell("Heroic Strike", "for Prot", {
  Continue = false,
  NotIfActive = true,
  CheckFirst = function()
    return c.HasBuff("Ultimatum") 
      or (c.HasTalent("Unyielding Strikes") and c.GetBuffStack("Unyielding Strikes") >= 5)
       or a.Rage >= a.maxPower - 30     
  end,
})

-- Throw your weapon at the enemy, causing 50% Physical damage.  Generates high threat.
-- Cast is instant with a 6 sec. cooldown.  Range is 8-30 yards
c.AddOptionalSpell("Heroic Throw", "for Prot", {
  EnemyTargetNeeded = true,
  CheckFirst = function()
    return c.GetCooldown("Heroic Throw") == 0
  end,
})

-- Instantly attack the target, causing (200% of Attack power) 
-- damage and healing you for 15% of your maximum health.
-- Killing an enemy that yields experience or honor resets 
-- the cooldown of Impending Victory.  Has a 30 sec Cooldown and 
-- costs 10 rage.  GCD is 1.5 sec.
c.AddSpell("Impending Victory", "for Prot", {
  Melee = true,
  CheckFirst = function()
    return c.HasTalent("Impending Victory") and c.GetCooldown("Impending Victory") == 0
  end,
})

--Increases Current and Maximum health by 30% for 15 sec.
c.AddOptionalSpell("Last Stand", "for Prot", {
  NoGCD = true,
  ShouldHold = function()
    return s.HealthPercent("player") > 70
  end
})

-- Throw a whirling axe at the target location that inflicts (82.5% of Attack power) 
-- damage to enemies within 6 yards every 1 sec. Lasts 10 sec.  Has a 60 sec. Cooldown.
c.AddOptionalSpell("Ravager", "for Prot", {
  CheckFirst = function() 
    return c.HasTalent("Ravager") and c.GetCooldown("Ravager") == 0
  end,
})

-- Instantly attack an enemy and two additional enemies, dealing (300% of Attack power) 
-- damage to the primary target and 50% damage to the secondary targets, and generating 20 Rage. 
-- Your successful dodges and parries reset the cooldown on Revenge.
-- Cooldown is 9 sec and GCD = 1.5 sec.
c.AddSpell("Revenge", "for Prot", {
  NotIfActive = true,
  CheckFirst = function() 
    return c.GetCooldown("Revenge") == 0
  end,
})

-- Raise our shield absorbing  899 damage for the next 6 seconds.
-- Consumes up to 40 additional Rage to increase the damage taken.
-- Note: WoD allows this on ALL Warriors. Confused how this works 
--      with Fury and Arms.
c.AddOptionalSpell("Shield Barrier", "for Prot", {
  NoGCD = true,
  CheckFirst = function(z)
--    return c.IsTanking()
--      and not c.HasBuff("Shield Barrier", true) 
--      and not c.HasBuff("Shield Block", true)
--      and not c.InDamageMode()
    if a.Rage > 60 
      and not c.HasBuff("Shield Barrier", true) 
      and not c.HasBuff("Shield Block", true)
      and not c.InDamageMode() then
        z.FlashSize = s.FlashSizePercent() / 2
    end
    return a.Rage > 60 
      and not c.HasBuff("Shield Barrier", true) 
      and not c.HasBuff("Shield Block", true)
      and not c.InDamageMode()
  end,
})

-- Raise your shield blocking every melee attack for the next 6 seconds.
-- These can be critical blocks.  Maximum 2 charges.
-- Cost is 60 rage and has a Cooldown of 1.5 seconds
c.AddOptionalSpell("Shield Block", "for Prot", {
  NoGCD = true,
  Melee = true,
  CheckFirst = function()
    return not (c.HasDebuff("Demoralizing Shout")
             or c.HasBuff("Ravager")
             or c.HasBuff("Shield Wall")
             or c.HasBuff("Last Stand")
             or c.HasBuff("Enraged Regeneration")
             or c.HasBuff("Shield Block"))
--  CheckFirst = function(z)
--    if not (a.Rage > 60)
--      and not c.HasBuff("Shield Barrier", true)
--      and not c.InDamageMode() then
--        z.FlashSize = s.FlashSizePercent() / 2
--    end
--    return a.Rage > 60
--      and not c.HasBuff("Shield Barrier", true)
--      and not c.InDamageMode()
  end,
})

-- Slam the target with your shield, causing [(Attack power * 0.36)] damage and 
-- generating 20 Rage.  Critical strikes with Shield Slam cause your next 
-- Heroic Strike to cost no Rage and be a critical strike.
-- Cooldown is 6 sec and GCD is 1.5 sec.
c.AddSpell("Shield Slam", "for Prot", {
  NotIfActive= true,
--  CheckFirst = function() 
--    return c.GetCooldown("Shield Slam") == 0
--  end,
})

--Reduces all damage taken by 40% for 8 sec.
c.AddOptionalSpell("Shield Wall", "under 3 min", {
  NoGCD = true,
  Enabled = function()
    return not c.HasGlyph("Shield Wall")
  end,
})

--Reduces all damage taken by 40% for 8 sec.
c.AddOptionalSpell("Shield Wall", "3+ min", {
  NoGCD = true,
  Enabled = function()
    return c.HasGlyph("Shield Wall")
  end,
})

-- Hurls your weapon at an enemy, causing 60% Physical damage and stunning for 4 sec.  
-- Deals quadruple damage to targets permanently immune to stuns.
-- Cast is instant with a 30 sec. cooldown.
c.AddSpell("Storm Bolt", "for Prot", { 
  NoGCD = false, 
  CheckLast = function()
    return c.HasTalent("Storm Bolt") and c.GetCooldown("Storm Bolt") == 0
  end
})

--10122014 rdh: Removed Weakend_Blows and changed cooldown from 6 to 5.54
c.AddSpell("Thunder Clap", "for Debuff", {
  Melee = true,
  CheckFirst = function()
--    local debuffNeeded = not c.HasDebuff(c.WEAKENED_BLOWS_DEBUFFS)
    local damageMode = c.InDamageMode()
    if c.AoE then
--      return debuffNeeded or damageMode
      return damageMode
    else
--      return debuffNeeded and not damageMode
            return not damageMode
    end
  end,
})

c.AddSpell("Thunder Clap", "for Refresh", {
  Melee = true,
  CheckFirst = function()
--    return c.GetDebuffDuration(c.WEAKENED_BLOWS_DEBUFFS) < 4 or c.AoE
       return c.AoE
  end,
})

c.AddSpell("Delay for Prot Rage Generator", nil, {
  ID = "Battle Shout",
  IsMinDelayDefinition = true,
  GetDelay = function()
    return math.min(
        c.GetCooldown("Shield Slam", false, 6), 
        c.GetCooldown("Revenge", false, 9),
        c.GetCooldown("Battle Shout", false, 60)), 
      c.InDamageMode() and .2 or .5
  end,
})

c.AddTaunt("Heroic Throw", nil, {
  NoGCD = true,
  CheckFirst = function()
    return c.GetCooldown("Heroic Throw") == 0
  end
})

-- Throw down a war banner within 30 yards that forces all enemies 
-- within 15 yards of the banner to focus attacks on the Warrior for 6 sec. 
-- Lasts 30 sec. with a 3 min. Cooldown
-- You can Intervene to your war banner.
c.AddTaunt("Mocking Banner", nil, {
  NoGCD = true,
  CheckFirst = function()
    return c.GetCooldown("Mocking Banner") == 0
  end
})

c.AddTaunt("Taunt", nil, {
  NoGCD = true,
  CheckFirst = function()
    return (c.HasTalent("Vigilance") and c.HasBuff("Vigilance")) or c.GetCooldown("Taunt") == 0 
  end,
})
