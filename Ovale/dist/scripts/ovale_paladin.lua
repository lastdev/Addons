local __exports = LibStub:NewLibrary("ovale/scripts/ovale_paladin", 80300)
if not __exports then return end
__exports.registerPaladin = function(OvaleScripts)
    do
        local name = "sc_t25_paladin_protection"
        local desc = "[9.0] Simulationcraft: T25_Paladin_Protection"
        local code = [[
# Based on SimulationCraft profile "T25_Paladin_Protection".
#	class=paladin
#	spec=protection
#	talents=3200003

Include(ovale_common)
Include(ovale_paladin_spells)

AddCheckBox(opt_melee_range l(not_in_melee_range) specialization=protection)

AddFunction protectiongetinmeleerange
{
 if checkboxon(opt_melee_range) and not target.inrange(rebuke) texture(misc_arrowlup help=l(not_in_melee_range))
}

### Protection icons.

AddCheckBox(opt_paladin_protection_aoe l(aoe) default specialization=protection)

### Required symbols
# rebuke
]]
        OvaleScripts:RegisterScript("PALADIN", "protection", name, desc, code, "script")
    end
    do
        local name = "sc_t25_paladin_retribution"
        local desc = "[9.0] Simulationcraft: T25_Paladin_Retribution"
        local code = [[
# Based on SimulationCraft profile "T25_Paladin_Retribution".
#	class=paladin
#	spec=retribution
#	talents=3303103

Include(ovale_common)
Include(ovale_paladin_spells)


AddFunction ds_castable
{
 enemies() >= 2 or buffpresent(empyrean_power_buff) and target.debuffexpires(judgment) and buffexpires(divine_purpose) or enemies() >= 2 and buffpresent(crusade) and buffstacks(crusade) < 10
}

AddCheckBox(opt_interrupt l(interrupt) default specialization=retribution)
AddCheckBox(opt_melee_range l(not_in_melee_range) specialization=retribution)
AddCheckBox(opt_shield_of_vengeance spellname(shield_of_vengeance) specialization=retribution)

AddFunction retributioninterruptactions
{
 if checkboxon(opt_interrupt) and not target.isfriend() and target.casting()
 {
  if target.inrange(rebuke) and target.isinterruptible() spell(rebuke)
  if target.inrange(hammer_of_justice) and not target.classification(worldboss) spell(hammer_of_justice)
  if target.distance(less 5) and not target.classification(worldboss) spell(war_stomp)
 }
}

AddFunction retributionuseitemactions
{
 item(trinket0slot text=13 usable=1)
 item(trinket1slot text=14 usable=1)
}

AddFunction retributiongetinmeleerange
{
 if checkboxon(opt_melee_range) and not target.inrange(rebuke) texture(misc_arrowlup help=l(not_in_melee_range))
}

AddFunction retributiontimetohpg
{
 spellcooldown(crusader_strike exorcism hammer_of_wrath hammer_of_wrath_empowered judgment usable=1)
}

### actions.precombat

AddFunction retributionprecombatmainactions
{
}

AddFunction retributionprecombatmainpostconditions
{
}

AddFunction retributionprecombatshortcdactions
{
}

AddFunction retributionprecombatshortcdpostconditions
{
}

AddFunction retributionprecombatcdactions
{
 #flask
 #food
 #augmentation
 #snapshot_stats
 #potion
 #arcane_torrent
 spell(arcane_torrent)
}

AddFunction retributionprecombatcdpostconditions
{
}

### actions.generators

AddFunction retributiongeneratorsmainactions
{
 #call_action_list,name=finishers,if=holy_power>=5|buff.holy_avenger.up|debuff.final_reckoning.up|debuff.execution_sentence.up|buff.memory_of_lucid_dreams.up|buff.seething_rage.up
 if holypower() >= 5 or buffpresent(holy_avenger) or target.debuffpresent(final_reckoning) or target.debuffpresent(execution_sentence) or buffpresent(memory_of_lucid_dreams) or buffpresent(seething_rage) retributionfinishersmainactions()

 unless { holypower() >= 5 or buffpresent(holy_avenger) or target.debuffpresent(final_reckoning) or target.debuffpresent(execution_sentence) or buffpresent(memory_of_lucid_dreams) or buffpresent(seething_rage) } and retributionfinishersmainpostconditions()
 {
  #blade_of_justice,if=holy_power<=3
  if holypower() <= 3 spell(blade_of_justice)
  #hammer_of_wrath,if=holy_power<=4
  if holypower() <= 4 spell(hammer_of_wrath)
  #judgment,if=!debuff.judgment.up&(holy_power<=2|holy_power<=4&cooldown.blade_of_justice.remains>gcd*2)
  if not target.debuffpresent(judgment) and { holypower() <= 2 or holypower() <= 4 and spellcooldown(blade_of_justice) > gcd() * 2 } spell(judgment)
  #call_action_list,name=finishers,if=(target.health.pct<=20|buff.avenging_wrath.up|buff.crusade.up|buff.empyrean_power.up)
  if target.healthpercent() <= 20 or buffpresent(avenging_wrath) or buffpresent(crusade) or buffpresent(empyrean_power_buff) retributionfinishersmainactions()

  unless { target.healthpercent() <= 20 or buffpresent(avenging_wrath) or buffpresent(crusade) or buffpresent(empyrean_power_buff) } and retributionfinishersmainpostconditions()
  {
   #crusader_strike,if=cooldown.crusader_strike.charges_fractional>=1.75&(holy_power<=2|holy_power<=3&cooldown.blade_of_justice.remains>gcd*2|holy_power=4&cooldown.blade_of_justice.remains>gcd*2&cooldown.judgment.remains>gcd*2)
   if spellcharges(crusader_strike count=0) >= 1.75 and { holypower() <= 2 or holypower() <= 3 and spellcooldown(blade_of_justice) > gcd() * 2 or holypower() == 4 and spellcooldown(blade_of_justice) > gcd() * 2 and spellcooldown(judgment) > gcd() * 2 } spell(crusader_strike)
   #call_action_list,name=finishers
   retributionfinishersmainactions()

   unless retributionfinishersmainpostconditions()
   {
    #crusader_strike,if=holy_power<=4
    if holypower() <= 4 spell(crusader_strike)
    #consecration,if=time_to_hpg>gcd
    if retributiontimetohpg() > gcd() spell(consecration)
   }
  }
 }
}

AddFunction retributiongeneratorsmainpostconditions
{
 { holypower() >= 5 or buffpresent(holy_avenger) or target.debuffpresent(final_reckoning) or target.debuffpresent(execution_sentence) or buffpresent(memory_of_lucid_dreams) or buffpresent(seething_rage) } and retributionfinishersmainpostconditions() or { target.healthpercent() <= 20 or buffpresent(avenging_wrath) or buffpresent(crusade) or buffpresent(empyrean_power_buff) } and retributionfinishersmainpostconditions() or retributionfinishersmainpostconditions()
}

AddFunction retributiongeneratorsshortcdactions
{
 #call_action_list,name=finishers,if=holy_power>=5|buff.holy_avenger.up|debuff.final_reckoning.up|debuff.execution_sentence.up|buff.memory_of_lucid_dreams.up|buff.seething_rage.up
 if holypower() >= 5 or buffpresent(holy_avenger) or target.debuffpresent(final_reckoning) or target.debuffpresent(execution_sentence) or buffpresent(memory_of_lucid_dreams) or buffpresent(seething_rage) retributionfinishersshortcdactions()

 unless { holypower() >= 5 or buffpresent(holy_avenger) or target.debuffpresent(final_reckoning) or target.debuffpresent(execution_sentence) or buffpresent(memory_of_lucid_dreams) or buffpresent(seething_rage) } and retributionfinishersshortcdpostconditions()
 {
  #divine_toll,if=!debuff.judgment.up&(!raid_event.adds.exists|raid_event.adds.in>30)&(holy_power<=2|holy_power<=4&(cooldown.blade_of_justice.remains>gcd*2|debuff.execution_sentence.up|debuff.final_reckoning.up))&(!talent.final_reckoning.enabled|cooldown.final_reckoning.remains>gcd*10)&(!talent.execution_sentence.enabled|cooldown.execution_sentence.remains>gcd*10)
  if not target.debuffpresent(judgment) and { not false(raid_event_adds_exists) or 600 > 30 } and { holypower() <= 2 or holypower() <= 4 and { spellcooldown(blade_of_justice) > gcd() * 2 or target.debuffpresent(execution_sentence) or target.debuffpresent(final_reckoning) } } and { not hastalent(final_reckoning_talent) or spellcooldown(final_reckoning) > gcd() * 10 } and { not hastalent(execution_sentence_talent) or spellcooldown(execution_sentence) > gcd() * 10 } spell(divine_toll)
  #wake_of_ashes,if=(holy_power=0|holy_power<=2&(cooldown.blade_of_justice.remains>gcd*2|debuff.execution_sentence.up|debuff.final_reckoning.up))&(!raid_event.adds.exists|raid_event.adds.in>20)&(!talent.execution_sentence.enabled|cooldown.execution_sentence.remains>15)&(!talent.final_reckoning.enabled|cooldown.final_reckoning.remains>15)
  if { holypower() == 0 or holypower() <= 2 and { spellcooldown(blade_of_justice) > gcd() * 2 or target.debuffpresent(execution_sentence) or target.debuffpresent(final_reckoning) } } and { not false(raid_event_adds_exists) or 600 > 20 } and { not hastalent(execution_sentence_talent) or spellcooldown(execution_sentence) > 15 } and { not hastalent(final_reckoning_talent) or spellcooldown(final_reckoning) > 15 } spell(wake_of_ashes)

  unless holypower() <= 3 and spell(blade_of_justice) or holypower() <= 4 and spell(hammer_of_wrath) or not target.debuffpresent(judgment) and { holypower() <= 2 or holypower() <= 4 and spellcooldown(blade_of_justice) > gcd() * 2 } and spell(judgment)
  {
   #call_action_list,name=finishers,if=(target.health.pct<=20|buff.avenging_wrath.up|buff.crusade.up|buff.empyrean_power.up)
   if target.healthpercent() <= 20 or buffpresent(avenging_wrath) or buffpresent(crusade) or buffpresent(empyrean_power_buff) retributionfinishersshortcdactions()

   unless { target.healthpercent() <= 20 or buffpresent(avenging_wrath) or buffpresent(crusade) or buffpresent(empyrean_power_buff) } and retributionfinishersshortcdpostconditions() or spellcharges(crusader_strike count=0) >= 1.75 and { holypower() <= 2 or holypower() <= 3 and spellcooldown(blade_of_justice) > gcd() * 2 or holypower() == 4 and spellcooldown(blade_of_justice) > gcd() * 2 and spellcooldown(judgment) > gcd() * 2 } and spell(crusader_strike)
   {
    #call_action_list,name=finishers
    retributionfinishersshortcdactions()
   }
  }
 }
}

AddFunction retributiongeneratorsshortcdpostconditions
{
 { holypower() >= 5 or buffpresent(holy_avenger) or target.debuffpresent(final_reckoning) or target.debuffpresent(execution_sentence) or buffpresent(memory_of_lucid_dreams) or buffpresent(seething_rage) } and retributionfinishersshortcdpostconditions() or holypower() <= 3 and spell(blade_of_justice) or holypower() <= 4 and spell(hammer_of_wrath) or not target.debuffpresent(judgment) and { holypower() <= 2 or holypower() <= 4 and spellcooldown(blade_of_justice) > gcd() * 2 } and spell(judgment) or { target.healthpercent() <= 20 or buffpresent(avenging_wrath) or buffpresent(crusade) or buffpresent(empyrean_power_buff) } and retributionfinishersshortcdpostconditions() or spellcharges(crusader_strike count=0) >= 1.75 and { holypower() <= 2 or holypower() <= 3 and spellcooldown(blade_of_justice) > gcd() * 2 or holypower() == 4 and spellcooldown(blade_of_justice) > gcd() * 2 and spellcooldown(judgment) > gcd() * 2 } and spell(crusader_strike) or retributionfinishersshortcdpostconditions() or holypower() <= 4 and spell(crusader_strike) or retributiontimetohpg() > gcd() and spell(consecration)
}

AddFunction retributiongeneratorscdactions
{
 #call_action_list,name=finishers,if=holy_power>=5|buff.holy_avenger.up|debuff.final_reckoning.up|debuff.execution_sentence.up|buff.memory_of_lucid_dreams.up|buff.seething_rage.up
 if holypower() >= 5 or buffpresent(holy_avenger) or target.debuffpresent(final_reckoning) or target.debuffpresent(execution_sentence) or buffpresent(memory_of_lucid_dreams) or buffpresent(seething_rage) retributionfinisherscdactions()

 unless { holypower() >= 5 or buffpresent(holy_avenger) or target.debuffpresent(final_reckoning) or target.debuffpresent(execution_sentence) or buffpresent(memory_of_lucid_dreams) or buffpresent(seething_rage) } and retributionfinisherscdpostconditions() or not target.debuffpresent(judgment) and { not false(raid_event_adds_exists) or 600 > 30 } and { holypower() <= 2 or holypower() <= 4 and { spellcooldown(blade_of_justice) > gcd() * 2 or target.debuffpresent(execution_sentence) or target.debuffpresent(final_reckoning) } } and { not hastalent(final_reckoning_talent) or spellcooldown(final_reckoning) > gcd() * 10 } and { not hastalent(execution_sentence_talent) or spellcooldown(execution_sentence) > gcd() * 10 } and spell(divine_toll) or { holypower() == 0 or holypower() <= 2 and { spellcooldown(blade_of_justice) > gcd() * 2 or target.debuffpresent(execution_sentence) or target.debuffpresent(final_reckoning) } } and { not false(raid_event_adds_exists) or 600 > 20 } and { not hastalent(execution_sentence_talent) or spellcooldown(execution_sentence) > 15 } and { not hastalent(final_reckoning_talent) or spellcooldown(final_reckoning) > 15 } and spell(wake_of_ashes) or holypower() <= 3 and spell(blade_of_justice) or holypower() <= 4 and spell(hammer_of_wrath) or not target.debuffpresent(judgment) and { holypower() <= 2 or holypower() <= 4 and spellcooldown(blade_of_justice) > gcd() * 2 } and spell(judgment)
 {
  #call_action_list,name=finishers,if=(target.health.pct<=20|buff.avenging_wrath.up|buff.crusade.up|buff.empyrean_power.up)
  if target.healthpercent() <= 20 or buffpresent(avenging_wrath) or buffpresent(crusade) or buffpresent(empyrean_power_buff) retributionfinisherscdactions()

  unless { target.healthpercent() <= 20 or buffpresent(avenging_wrath) or buffpresent(crusade) or buffpresent(empyrean_power_buff) } and retributionfinisherscdpostconditions() or spellcharges(crusader_strike count=0) >= 1.75 and { holypower() <= 2 or holypower() <= 3 and spellcooldown(blade_of_justice) > gcd() * 2 or holypower() == 4 and spellcooldown(blade_of_justice) > gcd() * 2 and spellcooldown(judgment) > gcd() * 2 } and spell(crusader_strike)
  {
   #call_action_list,name=finishers
   retributionfinisherscdactions()

   unless retributionfinisherscdpostconditions() or holypower() <= 4 and spell(crusader_strike)
   {
    #arcane_torrent,if=holy_power<=4
    if holypower() <= 4 spell(arcane_torrent)
   }
  }
 }
}

AddFunction retributiongeneratorscdpostconditions
{
 { holypower() >= 5 or buffpresent(holy_avenger) or target.debuffpresent(final_reckoning) or target.debuffpresent(execution_sentence) or buffpresent(memory_of_lucid_dreams) or buffpresent(seething_rage) } and retributionfinisherscdpostconditions() or not target.debuffpresent(judgment) and { not false(raid_event_adds_exists) or 600 > 30 } and { holypower() <= 2 or holypower() <= 4 and { spellcooldown(blade_of_justice) > gcd() * 2 or target.debuffpresent(execution_sentence) or target.debuffpresent(final_reckoning) } } and { not hastalent(final_reckoning_talent) or spellcooldown(final_reckoning) > gcd() * 10 } and { not hastalent(execution_sentence_talent) or spellcooldown(execution_sentence) > gcd() * 10 } and spell(divine_toll) or { holypower() == 0 or holypower() <= 2 and { spellcooldown(blade_of_justice) > gcd() * 2 or target.debuffpresent(execution_sentence) or target.debuffpresent(final_reckoning) } } and { not false(raid_event_adds_exists) or 600 > 20 } and { not hastalent(execution_sentence_talent) or spellcooldown(execution_sentence) > 15 } and { not hastalent(final_reckoning_talent) or spellcooldown(final_reckoning) > 15 } and spell(wake_of_ashes) or holypower() <= 3 and spell(blade_of_justice) or holypower() <= 4 and spell(hammer_of_wrath) or not target.debuffpresent(judgment) and { holypower() <= 2 or holypower() <= 4 and spellcooldown(blade_of_justice) > gcd() * 2 } and spell(judgment) or { target.healthpercent() <= 20 or buffpresent(avenging_wrath) or buffpresent(crusade) or buffpresent(empyrean_power_buff) } and retributionfinisherscdpostconditions() or spellcharges(crusader_strike count=0) >= 1.75 and { holypower() <= 2 or holypower() <= 3 and spellcooldown(blade_of_justice) > gcd() * 2 or holypower() == 4 and spellcooldown(blade_of_justice) > gcd() * 2 and spellcooldown(judgment) > gcd() * 2 } and spell(crusader_strike) or retributionfinisherscdpostconditions() or holypower() <= 4 and spell(crusader_strike) or retributiontimetohpg() > gcd() and spell(consecration)
}

### actions.finishers

AddFunction retributionfinishersmainactions
{
 #divine_storm,if=variable.ds_castable&!buff.vanquishers_hammer.up&((!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)&(!talent.execution_sentence.enabled|cooldown.execution_sentence.remains>gcd*3|spell_targets.divine_storm>=3)|spell_targets.divine_storm>=2&(talent.holy_avenger.enabled&cooldown.holy_avenger.remains<gcd*3|buff.crusade.up&buff.crusade.stack<10))
 if ds_castable() and not buffpresent(vanquishers_hammer) and { { not hastalent(crusade_talent) or spellcooldown(crusade) > gcd() * 3 } and { not hastalent(execution_sentence_talent) or spellcooldown(execution_sentence) > gcd() * 3 or enemies() >= 3 } or enemies() >= 2 and { hastalent(holy_avenger_talent) and spellcooldown(holy_avenger) < gcd() * 3 or buffpresent(crusade) and buffstacks(crusade) < 10 } } spell(divine_storm)
 #templars_verdict,if=(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)&(!talent.execution_sentence.enabled|cooldown.execution_sentence.remains>gcd*3&spell_targets.divine_storm<=3)&(!talent.final_reckoning.enabled|cooldown.final_reckoning.remains>gcd*3)&(!covenant.necrolord.enabled|cooldown.vanquishers_hammer.remains>gcd)|talent.holy_avenger.enabled&cooldown.holy_avenger.remains<gcd*3|buff.holy_avenger.up|buff.crusade.up&buff.crusade.stack<10|buff.vanquishers_hammer.up
 if { not hastalent(crusade_talent) or spellcooldown(crusade) > gcd() * 3 } and { not hastalent(execution_sentence_talent) or spellcooldown(execution_sentence) > gcd() * 3 and enemies() <= 3 } and { not hastalent(final_reckoning_talent) or spellcooldown(final_reckoning) > gcd() * 3 } and { not covenant(necrolord) or spellcooldown(vanquishers_hammer) > gcd() } or hastalent(holy_avenger_talent) and spellcooldown(holy_avenger) < gcd() * 3 or buffpresent(holy_avenger) or buffpresent(crusade) and buffstacks(crusade) < 10 or buffpresent(vanquishers_hammer) spell(templars_verdict)
}

AddFunction retributionfinishersmainpostconditions
{
}

AddFunction retributionfinishersshortcdactions
{
 #variable,name=ds_castable,value=spell_targets.divine_storm>=2|buff.empyrean_power.up&debuff.judgment.down&buff.divine_purpose.down|spell_targets.divine_storm>=2&buff.crusade.up&buff.crusade.stack<10
 #seraphim,if=((!talent.crusade.enabled&buff.avenging_wrath.up|cooldown.avenging_wrath.remains>25)|(buff.crusade.up|cooldown.crusade.remains>25))&(!talent.final_reckoning.enabled|cooldown.final_reckoning.remains<10)&(!talent.execution_sentence.enabled|cooldown.execution_sentence.remains<10)&time_to_hpg=0
 if { not hastalent(crusade_talent) and buffpresent(avenging_wrath) or spellcooldown(avenging_wrath) > 25 or buffpresent(crusade) or spellcooldown(crusade) > 25 } and { not hastalent(final_reckoning_talent) or spellcooldown(final_reckoning) < 10 } and { not hastalent(execution_sentence_talent) or spellcooldown(execution_sentence) < 10 } and retributiontimetohpg() == 0 spell(seraphim)
 #vanquishers_hammer,if=(!talent.final_reckoning.enabled|cooldown.final_reckoning.remains>gcd*10|debuff.final_reckoning.up)&(!talent.execution_sentence.enabled|cooldown.execution_sentence.remains>gcd*10|debuff.execution_sentence.up)|spell_targets.divine_storm>=2
 if { not hastalent(final_reckoning_talent) or spellcooldown(final_reckoning) > gcd() * 10 or target.debuffpresent(final_reckoning) } and { not hastalent(execution_sentence_talent) or spellcooldown(execution_sentence) > gcd() * 10 or target.debuffpresent(execution_sentence) } or enemies() >= 2 spell(vanquishers_hammer)
 #execution_sentence,if=spell_targets.divine_storm<=3&((!talent.crusade.enabled|buff.crusade.down&cooldown.crusade.remains>10)|buff.crusade.stack>=3|cooldown.avenging_wrath.remains>10|debuff.final_reckoning.up)&time_to_hpg=0
 if enemies() <= 3 and { not hastalent(crusade_talent) or buffexpires(crusade) and spellcooldown(crusade) > 10 or buffstacks(crusade) >= 3 or spellcooldown(avenging_wrath) > 10 or target.debuffpresent(final_reckoning) } and retributiontimetohpg() == 0 spell(execution_sentence)
}

AddFunction retributionfinishersshortcdpostconditions
{
 ds_castable() and not buffpresent(vanquishers_hammer) and { { not hastalent(crusade_talent) or spellcooldown(crusade) > gcd() * 3 } and { not hastalent(execution_sentence_talent) or spellcooldown(execution_sentence) > gcd() * 3 or enemies() >= 3 } or enemies() >= 2 and { hastalent(holy_avenger_talent) and spellcooldown(holy_avenger) < gcd() * 3 or buffpresent(crusade) and buffstacks(crusade) < 10 } } and spell(divine_storm) or { { not hastalent(crusade_talent) or spellcooldown(crusade) > gcd() * 3 } and { not hastalent(execution_sentence_talent) or spellcooldown(execution_sentence) > gcd() * 3 and enemies() <= 3 } and { not hastalent(final_reckoning_talent) or spellcooldown(final_reckoning) > gcd() * 3 } and { not covenant(necrolord) or spellcooldown(vanquishers_hammer) > gcd() } or hastalent(holy_avenger_talent) and spellcooldown(holy_avenger) < gcd() * 3 or buffpresent(holy_avenger) or buffpresent(crusade) and buffstacks(crusade) < 10 or buffpresent(vanquishers_hammer) } and spell(templars_verdict)
}

AddFunction retributionfinisherscdactions
{
}

AddFunction retributionfinisherscdpostconditions
{
 { not hastalent(crusade_talent) and buffpresent(avenging_wrath) or spellcooldown(avenging_wrath) > 25 or buffpresent(crusade) or spellcooldown(crusade) > 25 } and { not hastalent(final_reckoning_talent) or spellcooldown(final_reckoning) < 10 } and { not hastalent(execution_sentence_talent) or spellcooldown(execution_sentence) < 10 } and retributiontimetohpg() == 0 and spell(seraphim) or { { not hastalent(final_reckoning_talent) or spellcooldown(final_reckoning) > gcd() * 10 or target.debuffpresent(final_reckoning) } and { not hastalent(execution_sentence_talent) or spellcooldown(execution_sentence) > gcd() * 10 or target.debuffpresent(execution_sentence) } or enemies() >= 2 } and spell(vanquishers_hammer) or enemies() <= 3 and { not hastalent(crusade_talent) or buffexpires(crusade) and spellcooldown(crusade) > 10 or buffstacks(crusade) >= 3 or spellcooldown(avenging_wrath) > 10 or target.debuffpresent(final_reckoning) } and retributiontimetohpg() == 0 and spell(execution_sentence) or ds_castable() and not buffpresent(vanquishers_hammer) and { { not hastalent(crusade_talent) or spellcooldown(crusade) > gcd() * 3 } and { not hastalent(execution_sentence_talent) or spellcooldown(execution_sentence) > gcd() * 3 or enemies() >= 3 } or enemies() >= 2 and { hastalent(holy_avenger_talent) and spellcooldown(holy_avenger) < gcd() * 3 or buffpresent(crusade) and buffstacks(crusade) < 10 } } and spell(divine_storm) or { { not hastalent(crusade_talent) or spellcooldown(crusade) > gcd() * 3 } and { not hastalent(execution_sentence_talent) or spellcooldown(execution_sentence) > gcd() * 3 and enemies() <= 3 } and { not hastalent(final_reckoning_talent) or spellcooldown(final_reckoning) > gcd() * 3 } and { not covenant(necrolord) or spellcooldown(vanquishers_hammer) > gcd() } or hastalent(holy_avenger_talent) and spellcooldown(holy_avenger) < gcd() * 3 or buffpresent(holy_avenger) or buffpresent(crusade) and buffstacks(crusade) < 10 or buffpresent(vanquishers_hammer) } and spell(templars_verdict)
}

### actions.cooldowns

AddFunction retributioncooldownsmainactions
{
 #crusade,if=(holy_power>=4&time<5|holy_power>=3&time>5|talent.holy_avenger.enabled&cooldown.holy_avenger.remains=0)&time_to_hpg=0
 if { holypower() >= 4 and timeincombat() < 5 or holypower() >= 3 and timeincombat() > 5 or hastalent(holy_avenger_talent) and not spellcooldown(holy_avenger) > 0 } and retributiontimetohpg() == 0 spell(crusade)
 #the_unbound_force,if=time<=2|buff.reckless_force.up
 if timeincombat() <= 2 or buffpresent(reckless_force_buff) spell(the_unbound_force)
 #worldvein_resonance,if=cooldown.avenging_wrath.remains<gcd&holy_power>=3|talent.crusade.enabled&cooldown.crusade.remains<gcd&holy_power>=4|cooldown.avenging_wrath.remains>=45|cooldown.crusade.remains>=45
 if spellcooldown(avenging_wrath) < gcd() and holypower() >= 3 or hastalent(crusade_talent) and spellcooldown(crusade) < gcd() and holypower() >= 4 or spellcooldown(avenging_wrath) >= 45 or spellcooldown(crusade) >= 45 spell(worldvein_resonance)
 #memory_of_lucid_dreams,if=(buff.avenging_wrath.up|buff.crusade.up&buff.crusade.stack=10)&holy_power<=3
 if { buffpresent(avenging_wrath) or buffpresent(crusade) and buffstacks(crusade) == 10 } and holypower() <= 3 spell(memory_of_lucid_dreams)
}

AddFunction retributioncooldownsmainpostconditions
{
}

AddFunction retributioncooldownsshortcdactions
{
 unless { holypower() >= 4 and timeincombat() < 5 or holypower() >= 3 and timeincombat() > 5 or hastalent(holy_avenger_talent) and not spellcooldown(holy_avenger) > 0 } and retributiontimetohpg() == 0 and spell(crusade)
 {
  #final_reckoning,if=holy_power>=3&cooldown.avenging_wrath.remains>gcd&time_to_hpg=0&(!talent.seraphim.enabled|buff.seraphim.up)
  if holypower() >= 3 and spellcooldown(avenging_wrath) > gcd() and retributiontimetohpg() == 0 and { not hastalent(seraphim_talent) or buffpresent(seraphim) } spell(final_reckoning)

  unless { timeincombat() <= 2 or buffpresent(reckless_force_buff) } and spell(the_unbound_force) or { spellcooldown(avenging_wrath) < gcd() and holypower() >= 3 or hastalent(crusade_talent) and spellcooldown(crusade) < gcd() and holypower() >= 4 or spellcooldown(avenging_wrath) >= 45 or spellcooldown(crusade) >= 45 } and spell(worldvein_resonance)
  {
   #focused_azerite_beam,if=(!raid_event.adds.exists|raid_event.adds.in>30|spell_targets.divine_storm>=2)&!(buff.avenging_wrath.up|buff.crusade.up)&(cooldown.blade_of_justice.remains>gcd*3&cooldown.judgment.remains>gcd*3)
   if { not false(raid_event_adds_exists) or 600 > 30 or enemies() >= 2 } and not { buffpresent(avenging_wrath) or buffpresent(crusade) } and spellcooldown(blade_of_justice) > gcd() * 3 and spellcooldown(judgment) > gcd() * 3 spell(focused_azerite_beam)

   unless { buffpresent(avenging_wrath) or buffpresent(crusade) and buffstacks(crusade) == 10 } and holypower() <= 3 and spell(memory_of_lucid_dreams)
   {
    #purifying_blast,if=(!raid_event.adds.exists|raid_event.adds.in>30|spell_targets.divine_storm>=2)
    if not false(raid_event_adds_exists) or 600 > 30 or enemies() >= 2 spell(purifying_blast)
   }
  }
 }
}

AddFunction retributioncooldownsshortcdpostconditions
{
 { holypower() >= 4 and timeincombat() < 5 or holypower() >= 3 and timeincombat() > 5 or hastalent(holy_avenger_talent) and not spellcooldown(holy_avenger) > 0 } and retributiontimetohpg() == 0 and spell(crusade) or { timeincombat() <= 2 or buffpresent(reckless_force_buff) } and spell(the_unbound_force) or { spellcooldown(avenging_wrath) < gcd() and holypower() >= 3 or hastalent(crusade_talent) and spellcooldown(crusade) < gcd() and holypower() >= 4 or spellcooldown(avenging_wrath) >= 45 or spellcooldown(crusade) >= 45 } and spell(worldvein_resonance) or { buffpresent(avenging_wrath) or buffpresent(crusade) and buffstacks(crusade) == 10 } and holypower() <= 3 and spell(memory_of_lucid_dreams)
}

AddFunction retributioncooldownscdactions
{
 #lights_judgment,if=spell_targets.lights_judgment>=2|(!raid_event.adds.exists|raid_event.adds.in>75)
 if enemies() >= 2 or not false(raid_event_adds_exists) or 600 > 75 spell(lights_judgment)
 #fireblood,if=buff.avenging_wrath.up|buff.crusade.up&buff.crusade.stack=10
 if buffpresent(avenging_wrath) or buffpresent(crusade) and buffstacks(crusade) == 10 spell(fireblood)
 #shield_of_vengeance
 if checkboxon(opt_shield_of_vengeance) spell(shield_of_vengeance)
 #use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|(buff.avenging_wrath.remains>=20|buff.crusade.stack=10&buff.crusade.remains>15)&(cooldown.guardian_of_azeroth.remains>90|target.time_to_die<30|!essence.condensed_lifeforce.major)
 if target.debuffexpires(razor_coral) or { buffremaining(avenging_wrath) >= 20 or buffstacks(crusade) == 10 and buffremaining(crusade) > 15 } and { spellcooldown(guardian_of_azeroth) > 90 or target.timetodie() < 30 or not azeriteessenceismajor(condensed_lifeforce_essence_id) } retributionuseitemactions()
 #avenging_wrath,if=(holy_power>=4&time<5|holy_power>=3&time>5|talent.holy_avenger.enabled&cooldown.holy_avenger.remains=0)&time_to_hpg=0
 if { holypower() >= 4 and timeincombat() < 5 or holypower() >= 3 and timeincombat() > 5 or hastalent(holy_avenger_talent) and not spellcooldown(holy_avenger) > 0 } and retributiontimetohpg() == 0 spell(avenging_wrath)

 unless { holypower() >= 4 and timeincombat() < 5 or holypower() >= 3 and timeincombat() > 5 or hastalent(holy_avenger_talent) and not spellcooldown(holy_avenger) > 0 } and retributiontimetohpg() == 0 and spell(crusade)
 {
  #holy_avenger,if=time_to_hpg=0&((buff.avenging_wrath.up|buff.crusade.up)|(buff.avenging_wrath.down&cooldown.avenging_wrath.remains>40|buff.crusade.down&cooldown.crusade.remains>40))
  if retributiontimetohpg() == 0 and { buffpresent(avenging_wrath) or buffpresent(crusade) or buffexpires(avenging_wrath) and spellcooldown(avenging_wrath) > 40 or buffexpires(crusade) and spellcooldown(crusade) > 40 } spell(holy_avenger)

  unless holypower() >= 3 and spellcooldown(avenging_wrath) > gcd() and retributiontimetohpg() == 0 and { not hastalent(seraphim_talent) or buffpresent(seraphim) } and spell(final_reckoning) or { timeincombat() <= 2 or buffpresent(reckless_force_buff) } and spell(the_unbound_force)
  {
   #guardian_of_azeroth,if=!talent.crusade.enabled&(cooldown.avenging_wrath.remains<5&holy_power>=3|cooldown.avenging_wrath.remains>=45)|(talent.crusade.enabled&cooldown.crusade.remains<gcd&holy_power>=4|cooldown.crusade.remains>=45)
   if not hastalent(crusade_talent) and { spellcooldown(avenging_wrath) < 5 and holypower() >= 3 or spellcooldown(avenging_wrath) >= 45 } or hastalent(crusade_talent) and spellcooldown(crusade) < gcd() and holypower() >= 4 or spellcooldown(crusade) >= 45 spell(guardian_of_azeroth)
  }
 }
}

AddFunction retributioncooldownscdpostconditions
{
 { holypower() >= 4 and timeincombat() < 5 or holypower() >= 3 and timeincombat() > 5 or hastalent(holy_avenger_talent) and not spellcooldown(holy_avenger) > 0 } and retributiontimetohpg() == 0 and spell(crusade) or holypower() >= 3 and spellcooldown(avenging_wrath) > gcd() and retributiontimetohpg() == 0 and { not hastalent(seraphim_talent) or buffpresent(seraphim) } and spell(final_reckoning) or { timeincombat() <= 2 or buffpresent(reckless_force_buff) } and spell(the_unbound_force) or { spellcooldown(avenging_wrath) < gcd() and holypower() >= 3 or hastalent(crusade_talent) and spellcooldown(crusade) < gcd() and holypower() >= 4 or spellcooldown(avenging_wrath) >= 45 or spellcooldown(crusade) >= 45 } and spell(worldvein_resonance) or { not false(raid_event_adds_exists) or 600 > 30 or enemies() >= 2 } and not { buffpresent(avenging_wrath) or buffpresent(crusade) } and spellcooldown(blade_of_justice) > gcd() * 3 and spellcooldown(judgment) > gcd() * 3 and spell(focused_azerite_beam) or { buffpresent(avenging_wrath) or buffpresent(crusade) and buffstacks(crusade) == 10 } and holypower() <= 3 and spell(memory_of_lucid_dreams) or { not false(raid_event_adds_exists) or 600 > 30 or enemies() >= 2 } and spell(purifying_blast)
}

### actions.default

AddFunction retribution_defaultmainactions
{
 #call_action_list,name=cooldowns
 retributioncooldownsmainactions()

 unless retributioncooldownsmainpostconditions()
 {
  #call_action_list,name=generators
  retributiongeneratorsmainactions()
 }
}

AddFunction retribution_defaultmainpostconditions
{
 retributioncooldownsmainpostconditions() or retributiongeneratorsmainpostconditions()
}

AddFunction retribution_defaultshortcdactions
{
 #auto_attack
 retributiongetinmeleerange()
 #call_action_list,name=cooldowns
 retributioncooldownsshortcdactions()

 unless retributioncooldownsshortcdpostconditions()
 {
  #call_action_list,name=generators
  retributiongeneratorsshortcdactions()
 }
}

AddFunction retribution_defaultshortcdpostconditions
{
 retributioncooldownsshortcdpostconditions() or retributiongeneratorsshortcdpostconditions()
}

AddFunction retribution_defaultcdactions
{
 #rebuke
 retributioninterruptactions()
 #call_action_list,name=cooldowns
 retributioncooldownscdactions()

 unless retributioncooldownscdpostconditions()
 {
  #call_action_list,name=generators
  retributiongeneratorscdactions()
 }
}

AddFunction retribution_defaultcdpostconditions
{
 retributioncooldownscdpostconditions() or retributiongeneratorscdpostconditions()
}

### Retribution icons.

AddCheckBox(opt_paladin_retribution_aoe l(aoe) default specialization=retribution)

AddIcon checkbox=!opt_paladin_retribution_aoe enemies=1 help=shortcd specialization=retribution
{
 if not incombat() retributionprecombatshortcdactions()
 retribution_defaultshortcdactions()
}

AddIcon checkbox=opt_paladin_retribution_aoe help=shortcd specialization=retribution
{
 if not incombat() retributionprecombatshortcdactions()
 retribution_defaultshortcdactions()
}

AddIcon enemies=1 help=main specialization=retribution
{
 if not incombat() retributionprecombatmainactions()
 retribution_defaultmainactions()
}

AddIcon checkbox=opt_paladin_retribution_aoe help=aoe specialization=retribution
{
 if not incombat() retributionprecombatmainactions()
 retribution_defaultmainactions()
}

AddIcon checkbox=!opt_paladin_retribution_aoe enemies=1 help=cd specialization=retribution
{
 if not incombat() retributionprecombatcdactions()
 retribution_defaultcdactions()
}

AddIcon checkbox=opt_paladin_retribution_aoe help=cd specialization=retribution
{
 if not incombat() retributionprecombatcdactions()
 retribution_defaultcdactions()
}

### Required symbols
# arcane_torrent
# avenging_wrath
# blade_of_justice
# condensed_lifeforce_essence_id
# consecration
# crusade
# crusade_talent
# crusader_strike
# divine_purpose
# divine_storm
# divine_toll
# empyrean_power_buff
# execution_sentence
# execution_sentence_talent
# exorcism
# final_reckoning
# final_reckoning_talent
# fireblood
# focused_azerite_beam
# guardian_of_azeroth
# hammer_of_justice
# hammer_of_wrath
# holy_avenger
# holy_avenger_talent
# judgment
# lights_judgment
# memory_of_lucid_dreams
# necrolord
# purifying_blast
# razor_coral
# rebuke
# reckless_force_buff
# seething_rage
# seraphim
# seraphim_talent
# shield_of_vengeance
# templars_verdict
# the_unbound_force
# vanquishers_hammer
# wake_of_ashes
# war_stomp
# worldvein_resonance
]]
        OvaleScripts:RegisterScript("PALADIN", "retribution", name, desc, code, "script")
    end
end
