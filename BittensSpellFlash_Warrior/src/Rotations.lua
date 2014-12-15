local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local GetPowerRegen = GetPowerRegen
local GetTime = GetTime
local UnitPowerMax = UnitPowerMax
local math = math
local select = select
local string = string
local tostring = tostring

a.Rotations = {}

local function t15RageBump(amount)
  if c.WearingSet(4, "ProtT15") 
    and s.Debuff(c.GetID("Demoralizing Shout")) then
    
    a.Rage = a.Rage + 1.5 * amount
  else
    a.Rage = a.Rage + amount
  end
end

a.smashPending = 0
a.smashTime = 0

local resetDamageOverTime = function()
  a.InitCombatTime = -1
  a.InitDamage = -1
end

local DamageOverTime = function()
  if a.InitDamage ~= -1 then
    a.DamageRate = (c.GetTime() - a.InitCombatTime) / (c.GetHealth() - a.InitDamage)
    a.InitCombatTime = c.GetTime()
    a.InitDamage = c.GetHealth()
    c.Debug("Damage: ", a.DamageRate)
  else
    a.InitCombatTime = c.GetTime()
    a.InitDamage = c.GetHealth()
  end
end

local monitorSmashPending = function(info) 
  if c.InfoMatches(info, "Colossus Smash") then	
    a.smashTime = GetTime()
	a.smashPending = 1
  end
end

local monitorSmashApplied = function(spellID)
  if c.IdMatches(spellID, "Colossus Smash") then
    a.smashPending = 0
  end
end

function a.PreFlash()
  if a.smashPending > 0 then
    a.smashPending = GetTime() - a.smashTime
	if a.smashPending >= 20 then
      a.smashPending = 0
    end
  end
  
  a.freeExecute = false
  a.CSIsUsable = select(1, s.UsableSpell("Colossus Smash")) and a.smashPending == 0
  a.ExeIsUsable = select(1,s.UsableSpell("Execute"))
  a.MSIsUsable = select(1, s.UsableSpell("Mortal Strike")) and c.GetCooldown("Mortal Strike") == 0
  a.Rage = c.GetPower(0)
  a.InExecute = s.HealthPercent() <= 20 and a.Rage > 30 and a.ExeIsUsable
  if c.HasBuff("Sudden Death") then
     a.freeExecute = a.ExeIsUsable
  elseif a.ExeIsUsable then
     a.freeExecute = true
  end
  a.Enraged = false
  if c.HasBuff("Enrage") then
     a.Enraged = true
  end
  if c.IsQueued("Berserker Rage") then
    a.Rage = a.Rage + 10
    a.Enraged = true
  end
  if c.IsQueued("Charge") then
    t15RageBump(20)
  end   
  if c.IsQueued("Bloodthirst", "Mortal Strike") then
    a.Rage = a.Rage + 10
  elseif c.IsQueued("Battle Shout", "Commanding Shout") then
    a.Rage = a.Rage + 20
  elseif c.IsQueued("Shield Slam") then
    if s.Buff(c.GetID("Sword and Board"), "player") then
      t15RageBump(25)
    else
      t15RageBump(20)
    end
  elseif c.IsQueued("Revenge") then
    t15RageBump(15)
  end
  local max = UnitPowerMax("player")
  a.maxPower = UnitPowerMax("player")
  a.Rage = math.min(max, a.Rage)
  a.EmptyRage = max - a.Rage
  
  if c.IsCasting("Victory Rush", "Impending Victory") then
    a.VictoriousDuration = 0
  else
    a.VictoriousDuration = c.GetBuffDuration("Victorious")
  end
  
  a.Bloodbath = c.HasBuff("Bloodbath", false, false, true)
end

-------------------------------------------------------------------------- Arms
local tastePending = 0
a.rendAppliedTime = 0

a.Rotations.Arms = {
  Spec = 1,
  
  UsefulStats = { "Strength", "Melee Hit", "Crit", "Haste" },
  
  FlashInCombat = function()
    a.TasteStacks = c.GetBuffStack("Taste for Blood")
    if c.IsCasting("Mortal Strike") or GetTime() - tastePending < .8 then
      a.TasteStacks = a.TasteStacks + 2
    end
    
    c.FlashAll(
      "Recklessness for Arms",
      "Avatar",
      "Bloodbath",
      "Berserker Rage for Arms",
      "Heroic Leap",
      "Impending Victory for Heals, Optional",
      "Victory Rush for Heals, Optional",
--      "Enraged Regeneration",
      "Sunder Armor",
      "Pummel",
      "Disrupting Shout")
    if c.AoE then
      c.FlashAll("Cleave for Arms", "Sweeping Strikes")
      c.PriorityFlash(
        "Mortal Strike",
        "Bladestorm",
        "Shockwave",
        "Dragon Roar for Arms",
        "Thunder Clap",
        "Whirlwind for Arms",
        "Colossus Smash",
--        "Overpower AoE",
        "Shout for Rage",
--        "Storm Bolt",
        "Heroic Throw")
    else
	  a.PreFlash()
      c.FlashAll("Rend" )
      c.PriorityFlash(  
        "Colossus Smash for Arms",        
        "Execute for Arms",
        "Storm Bolt for Arms",
        "Dragon Roar for Arms",
        "Shockwave",
        "Slam",
        "Mortal Strike",
        "Rend",
        "Whirlwind for Arms")
    end
  end,
  
  FlashAlways = function()
    c.FlashAll("Dps Stance", "Shout for Buff")
  end,
  
  CastSucceeded = function(info)
    if c.InfoMatches(info, "Rend") then
      if a.rendAppliedTime == 0 then
        a.rendAppliedTime = GetTime()
      end
    else
      monitorSmashPending(info)
    end
  end,
  
-- Taste for Blood, each time Rend deals damage, you gain 3 rage.
  AuraApplied = function(spellID)
    if c.IdMatches(spellID, "Rend") then
      if (GetTime() - a.rendAppliedTime) >= 17 then
        a.rendAppliedTime = 0
      end
    end
  end,
    
  ExtraDebugInfo = function()
--  print("Rend: ", s.ShowBuffs("target", "harmful"))
--	print("[CS: ", a.CSIsUsable, " CS Pending: ", a.smashPending, " Rend: ", c.HasMyDebuff("Rend", false,false), " RUse: ", s.UsableSpell("Rend"), "]")
  end,
}

-------------------------------------------------------------------------- Fury

a.Rotations.Fury = {
  Spec = 2,
  
  -- Foods not added for Multistrike and Versatility as yet.
  -- UsefulStats = {"Multistrike", "Strength", "Crit", "Mastery", "Haste", "Versatility"},
  UsefulStats = {"Strength", "Crit", "Mastery", "Haste"},
  
  FlashOutOfCombat = function()
     c.PriorityFlash(
       "Heroic Throw for Fury"
     )
  end,
  
  FlashInCombat = function()
    c.FlashAll(
      "Shout"
--      "Berserker Rage for Fury",
--      "Recklessness for Fury",
--      "Avatar",
--      "Bloodbath for Fury",
----      "Impending Victory for Heals, Optional",
----      "Victory Rush for Heals, Optional",
--      "Impending Victory for Fury",
--      "Enraged Regeneration",
----      "Sunder Armor",
--      "Pummel"
----      "Disrupting Shout"
    )
    if c.AoE then
      c.FlashAll("Bloodthirst")
      c.PriorityFlash(
        "Dragon Roar for Fury",
        "Shockwave",
        "Bladestorm",
        "Bloodthirst",
        "Raging Blow AoE",
        "Whirlwind",
        "Shout for Rage",
        "Storm Bolt for Fury",
        "Heroic Throw")
    else
      c.FlashAll( 
 --       "Bloodbath for Fury", "Recklessness for Fury", "Bloodthirst early", "Execute for Fury", "Dragon Roar for Fury","Raging Blow", "Storm Bolt for Fury"
      )
      c.PriorityFlash(
        "Bloodbath for Fury",
        "Recklessness for Fury", 
        "Wild Strike for Fury",       
        "Bloodthirst early",
        "Execute for Fury",  
        "Storm Bolt for Fury",
        "Wild Strike with Bloodsurge for Fury",
        "Execute for Fury",      
        "Dragon Roar for Fury",
        "Raging Blow", 
        "Wild Strike with Enrage for Fury",       
        "Shockwave for Fury",
        "Impending Victory for Fury",
        "Bloodthirst late"
		    )
    end
  end,
  

--  FlashAlways = function()
--    c.FlashAll("Dps Stance", "Shout for Buff")
--  end,
--  
--  CastSucceeded = function(info)
--    if c.InfoMatches(info, "Whirlwind") then
--      a.CleaverPending = GetTime()
--    end
--  end,
--  
--  AuraApplied = function(spellID)
--    if c.IdMatches(spellID, "Meat Cleaver") then
--      a.CleaverPending = 0
--    end
--  end,
--  
--  AuraRemoved = function(spellID)
--    if c.IdMatches(spellID, "Meat Cleaver") then
--      a.CleaverDumpPending = 0
--    end
--  end,
  
  ExtraDebugInfo = function()
--    s.ShowBuffs() --"target", "harmful")
--    print("BloodBath-> ", c.HasTalent("Bloodbath"))
--    print("Recklessness-> TH>96: ", s.HealthPercent() >= 96, ", IE: ", a.InExecute, ", Rdy: ", select(1, s.UsableSpell("Recklessness")))
--    print("              TH<20: ", s.HealthPercent() < 20, ", BBT: ", c.HasTalent("Bloodbath"), ", BBB: ", c.HasBuff("Bloodbath"))
--    print("              AM: ", c.HasTalent("Anger Management"))
 --   print("Bloodthirst-> Rdy: ", select(1,s.UsableSpell("Bloodthirst")), ", Enraged: ", a.Enraged, ", UTT: ", c.HasTalent("Unquenchable Thirst"), ", Rage: ", a.Rage < 80)
--    print("Execute-> IE: ", a.InExecute, " Free: ", a.freeExecute)
--    print("Dragon Roar-> BB: ", a.Bloodbath, ", BBT: ", c.HasTalent("Bloodbath"))
--    print("Raging Blow-> RB: ", s.UsableSpell("Raging Blow"))
--    print("Wild Strike-> Rage>110: ", a.Rage >= 55, " TgtH>20: ", s.HealthPercent() > 20, " BDB: ", c.HasBuff("Bloodsurge"), ", Enraged: ", a.Enraged)
--    print("Storm Bolt-> Usable: ", a.SBUsable, ", SBPwr: ", a.SBPwr)
  end,
}

-------------------------------------------------------------------- Protection
local uncontrolledMitigationCooldowns = {
  "Spell Reflection",
}

a.Rotations.Protection = {
  Spec = 3,
  
-- New Stat for Protection: Stamina > Versatility > Bonus Armor > Armor > Mastery > Haste > Crit > Multistrike > Strength
-- The following list suggests the consumables to augment your warrior stats
  UsefulStats = { "Stamina", "Strength", "Mastery" },  --, "Armor" },
  
  FlashOutOfCombat = function()
     c.PriorityFlash(
       "Heroic Throw for Prot"
     )
  end,
  
  FlashInCombat = function()
    c.FlashMitigationBuffs(
      1,
      uncontrolledMitigationCooldowns,
      c.COMMON_TANKING_BUFFS,
      "No Mitigation if Victory Available",
      "Demoralizing Shout for Prot",
      "Enraged Regeneration for Prot",
      "Shield Wall under 3 min",
      "Last Stand for Prot",
      "Shield Block for Prot",
      "Shield Barrier for Prot",
      "Shield Wall 3+ min"
    )
    c.FlashAll(
      "Shield Block for Prot",
      "Shield Barrier for Prot",
      "Sunder Armor",
      "Disrupting Shout",
      "Pummel"
    )
--    c.DelayPriorityFlash(
    c.PriorityFlash(
      "Berserker Rage for Prot",
      "Bloodbath for Prot",
      "Execute for Prot",      
      "Heroic Strike for Prot",
      "Shield Slam for Prot",
      "Revenge for Prot",
      "Ravager for Prot",
      "Storm Bolt for Prot",
      "Dragon Roar for Prot",
      "Impending Victory for Prot",
      "Devastate for Prot"       
    )
  end,
 
  ExtraDebugInfo = function()
  end,
}
