local __exports = LibStub:NewLibrary("ovale/scripts/ovale_rogue", 80300)
if not __exports then return end
__exports.registerRogue = function(OvaleScripts)
    do
        local name = "sc_t25_rogue_assassination"
        local desc = "[9.0] Simulationcraft: T25_Rogue_Assassination"
        local code = [[
# Based on SimulationCraft profile "T25_Rogue_Assassination".
#	class=rogue
#	spec=assassination
#	talents=2210021

Include(ovale_common)
Include(ovale_rogue_spells)


AddFunction single_target
{
 enemies() < 2
}

AddFunction energy_regen_combined
{
 energyregenrate() + { debuffcountonany(rupture_debuff) + debuffcountonany(garrote_debuff) + talent(internal_bleeding_talent) * debuffcountonany(internal_bleeding_debuff) } * 7 / { 2 * { 100 / { 100 + spellcastspeedpercent() } } }
}

AddFunction ss_vanish_condition
{
 hasazeritetrait(shrouded_suffocation_trait) and { enemies() - debuffcountonany(garrote_debuff) >= 1 or enemies() == 3 } and { 0 == 0 or enemies() >= 6 }
}

AddFunction vendetta_font_condition
{
 not hasequippeditem(azsharas_font_of_power_item) or hasazeritetrait(shrouded_suffocation_trait) or target.debuffexpires(razor_coral) or buffremaining(trinket_ashvanes_razor_coral_cooldown_buff) < 10 and { spellcooldown(shiv) < 1 or target.debuffpresent(shiv) }
}

AddFunction vendetta_nightstalker_condition
{
 not hastalent(nightstalker_talent) or not hastalent(exsanguinate_talent) or spellcooldown(exsanguinate) < 5 - 2 * talentpoints(deeper_stratagem_talent)
}

AddFunction vendetta_subterfuge_condition
{
 not hastalent(subterfuge_talent) or not hasazeritetrait(shrouded_suffocation_trait) or target.debuffpersistentmultiplier(garrote) > 1 and { enemies() < 6 or not { not spellcooldown(vanish) > 0 } }
}

AddFunction use_filler
{
 combopointsdeficit() > 1 or energydeficit() <= 25 + energy_regen_combined() or not single_target()
}

AddFunction skip_rupture
{
 target.debuffpresent(vendetta) and { target.debuffpresent(shiv) or buffremaining(master_assassin_buff) > 0 } and target.debuffremaining(rupture) > 2
}

AddFunction skip_cycle_rupture
{
 checkboxon(opt_priority_rotation) and enemies() > 3 and { target.debuffpresent(shiv) or debuffcountonany(rupture_debuff) + debuffcountonany(garrote_debuff) + talent(internal_bleeding_talent) * debuffcountonany(internal_bleeding_debuff) > 5 and not hasazeritetrait(scent_of_blood_trait) }
}

AddFunction skip_cycle_garrote
{
 checkboxon(opt_priority_rotation) and enemies() > 3 and { target.debuffremaining(garrote) < spellcooldownduration(garrote) or debuffcountonany(rupture_debuff) + debuffcountonany(garrote_debuff) + talent(internal_bleeding_talent) * debuffcountonany(internal_bleeding_debuff) > 5 }
}

AddFunction reaping_delay
{
 if azeriteessenceismajor(breath_of_the_dying_essence_id) target.timetodie()
}

AddCheckBox(opt_priority_rotation l(opt_priority_rotation) default specialization=assassination)
AddCheckBox(opt_interrupt l(interrupt) default specialization=assassination)
AddCheckBox(opt_melee_range l(not_in_melee_range) specialization=assassination)
AddCheckBox(opt_use_consumables l(opt_use_consumables) default specialization=assassination)
AddCheckBox(opt_vanish spellname(vanish) default specialization=assassination)

AddFunction assassinationinterruptactions
{
 if checkboxon(opt_interrupt) and not target.isfriend() and target.casting()
 {
  if target.inrange(kick) and target.isinterruptible() spell(kick)
  if target.inrange(cheap_shot) and not target.classification(worldboss) spell(cheap_shot)
  if target.inrange(kidney_shot) and not target.classification(worldboss) and combopoints() >= 1 spell(kidney_shot)
  if target.inrange(quaking_palm) and not target.classification(worldboss) spell(quaking_palm)
 }
}

AddFunction assassinationuseitemactions
{
 item(trinket0slot text=13 usable=1)
 item(trinket1slot text=14 usable=1)
}

AddFunction assassinationgetinmeleerange
{
 if checkboxon(opt_melee_range) and not target.inrange(kick)
 {
  spell(shadowstep)
  texture(misc_arrowlup help=l(not_in_melee_range))
 }
}

### actions.stealthed

AddFunction assassinationstealthedmainactions
{
 #crimson_tempest,if=talent.nightstalker.enabled&spell_targets>=3&combo_points>=4&target.time_to_die-remains>6
 if hastalent(nightstalker_talent) and enemies() >= 3 and combopoints() >= 4 and target.timetodie() - buffremaining(crimson_tempest) > 6 spell(crimson_tempest)
 #rupture,if=talent.nightstalker.enabled&combo_points>=4&target.time_to_die-remains>6
 if hastalent(nightstalker_talent) and combopoints() >= 4 and target.timetodie() - buffremaining(rupture) > 6 spell(rupture)
 #pool_resource,for_next=1
 #garrote,if=azerite.shrouded_suffocation.enabled&buff.subterfuge.up&buff.subterfuge.remains<1.3&!ss_buffed
 if hasazeritetrait(shrouded_suffocation_trait) and buffpresent(subterfuge) and buffremaining(subterfuge) < 1.3 and not false(ss_buffed) spell(garrote)
 unless hasazeritetrait(shrouded_suffocation_trait) and buffpresent(subterfuge) and buffremaining(subterfuge) < 1.3 and not false(ss_buffed) and spellusable(garrote) and spellcooldown(garrote) < timetoenergyfor(garrote)
 {
  #pool_resource,for_next=1
  #garrote,target_if=min:remains,if=talent.subterfuge.enabled&(remains<12|pmultiplier<=1)&target.time_to_die-remains>2
  if hastalent(subterfuge_talent) and { buffremaining(garrote) < 12 or persistentmultiplier(garrote) <= 1 } and target.timetodie() - buffremaining(garrote) > 2 spell(garrote)
  unless hastalent(subterfuge_talent) and { buffremaining(garrote) < 12 or persistentmultiplier(garrote) <= 1 } and target.timetodie() - buffremaining(garrote) > 2 and spellusable(garrote) and spellcooldown(garrote) < timetoenergyfor(garrote)
  {
   #rupture,if=talent.subterfuge.enabled&azerite.shrouded_suffocation.enabled&!dot.rupture.ticking&variable.single_target
   if hastalent(subterfuge_talent) and hasazeritetrait(shrouded_suffocation_trait) and not target.debuffpresent(rupture) and single_target() spell(rupture)
   #pool_resource,for_next=1
   #garrote,target_if=min:remains,if=talent.subterfuge.enabled&azerite.shrouded_suffocation.enabled&(active_enemies>1|!talent.exsanguinate.enabled)&target.time_to_die>remains&(remains<18|!ss_buffed)
   if hastalent(subterfuge_talent) and hasazeritetrait(shrouded_suffocation_trait) and { enemies() > 1 or not hastalent(exsanguinate_talent) } and target.timetodie() > buffremaining(garrote) and { buffremaining(garrote) < 18 or not false(ss_buffed) } spell(garrote)
   unless hastalent(subterfuge_talent) and hasazeritetrait(shrouded_suffocation_trait) and { enemies() > 1 or not hastalent(exsanguinate_talent) } and target.timetodie() > buffremaining(garrote) and { buffremaining(garrote) < 18 or not false(ss_buffed) } and spellusable(garrote) and spellcooldown(garrote) < timetoenergyfor(garrote)
   {
    #pool_resource,for_next=1
    #garrote,if=talent.subterfuge.enabled&talent.exsanguinate.enabled&active_enemies=1&buff.subterfuge.remains<1.3
    if hastalent(subterfuge_talent) and hastalent(exsanguinate_talent) and enemies() == 1 and buffremaining(subterfuge) < 1.3 spell(garrote)
   }
  }
 }
}

AddFunction assassinationstealthedmainpostconditions
{
}

AddFunction assassinationstealthedshortcdactions
{
}

AddFunction assassinationstealthedshortcdpostconditions
{
 hastalent(nightstalker_talent) and enemies() >= 3 and combopoints() >= 4 and target.timetodie() - buffremaining(crimson_tempest) > 6 and spell(crimson_tempest) or hastalent(nightstalker_talent) and combopoints() >= 4 and target.timetodie() - buffremaining(rupture) > 6 and spell(rupture) or hasazeritetrait(shrouded_suffocation_trait) and buffpresent(subterfuge) and buffremaining(subterfuge) < 1.3 and not false(ss_buffed) and spell(garrote) or not { hasazeritetrait(shrouded_suffocation_trait) and buffpresent(subterfuge) and buffremaining(subterfuge) < 1.3 and not false(ss_buffed) and spellusable(garrote) and spellcooldown(garrote) < timetoenergyfor(garrote) } and { hastalent(subterfuge_talent) and { buffremaining(garrote) < 12 or persistentmultiplier(garrote) <= 1 } and target.timetodie() - buffremaining(garrote) > 2 and spell(garrote) or not { hastalent(subterfuge_talent) and { buffremaining(garrote) < 12 or persistentmultiplier(garrote) <= 1 } and target.timetodie() - buffremaining(garrote) > 2 and spellusable(garrote) and spellcooldown(garrote) < timetoenergyfor(garrote) } and { hastalent(subterfuge_talent) and hasazeritetrait(shrouded_suffocation_trait) and not target.debuffpresent(rupture) and single_target() and spell(rupture) or hastalent(subterfuge_talent) and hasazeritetrait(shrouded_suffocation_trait) and { enemies() > 1 or not hastalent(exsanguinate_talent) } and target.timetodie() > buffremaining(garrote) and { buffremaining(garrote) < 18 or not false(ss_buffed) } and spell(garrote) or not { hastalent(subterfuge_talent) and hasazeritetrait(shrouded_suffocation_trait) and { enemies() > 1 or not hastalent(exsanguinate_talent) } and target.timetodie() > buffremaining(garrote) and { buffremaining(garrote) < 18 or not false(ss_buffed) } and spellusable(garrote) and spellcooldown(garrote) < timetoenergyfor(garrote) } and hastalent(subterfuge_talent) and hastalent(exsanguinate_talent) and enemies() == 1 and buffremaining(subterfuge) < 1.3 and spell(garrote) } }
}

AddFunction assassinationstealthedcdactions
{
}

AddFunction assassinationstealthedcdpostconditions
{
 hastalent(nightstalker_talent) and enemies() >= 3 and combopoints() >= 4 and target.timetodie() - buffremaining(crimson_tempest) > 6 and spell(crimson_tempest) or hastalent(nightstalker_talent) and combopoints() >= 4 and target.timetodie() - buffremaining(rupture) > 6 and spell(rupture) or hasazeritetrait(shrouded_suffocation_trait) and buffpresent(subterfuge) and buffremaining(subterfuge) < 1.3 and not false(ss_buffed) and spell(garrote) or not { hasazeritetrait(shrouded_suffocation_trait) and buffpresent(subterfuge) and buffremaining(subterfuge) < 1.3 and not false(ss_buffed) and spellusable(garrote) and spellcooldown(garrote) < timetoenergyfor(garrote) } and { hastalent(subterfuge_talent) and { buffremaining(garrote) < 12 or persistentmultiplier(garrote) <= 1 } and target.timetodie() - buffremaining(garrote) > 2 and spell(garrote) or not { hastalent(subterfuge_talent) and { buffremaining(garrote) < 12 or persistentmultiplier(garrote) <= 1 } and target.timetodie() - buffremaining(garrote) > 2 and spellusable(garrote) and spellcooldown(garrote) < timetoenergyfor(garrote) } and { hastalent(subterfuge_talent) and hasazeritetrait(shrouded_suffocation_trait) and not target.debuffpresent(rupture) and single_target() and spell(rupture) or hastalent(subterfuge_talent) and hasazeritetrait(shrouded_suffocation_trait) and { enemies() > 1 or not hastalent(exsanguinate_talent) } and target.timetodie() > buffremaining(garrote) and { buffremaining(garrote) < 18 or not false(ss_buffed) } and spell(garrote) or not { hastalent(subterfuge_talent) and hasazeritetrait(shrouded_suffocation_trait) and { enemies() > 1 or not hastalent(exsanguinate_talent) } and target.timetodie() > buffremaining(garrote) and { buffremaining(garrote) < 18 or not false(ss_buffed) } and spellusable(garrote) and spellcooldown(garrote) < timetoenergyfor(garrote) } and hastalent(subterfuge_talent) and hastalent(exsanguinate_talent) and enemies() == 1 and buffremaining(subterfuge) < 1.3 and spell(garrote) } }
}

### actions.precombat

AddFunction assassinationprecombatmainactions
{
 #stealth
 spell(stealth)
 #slice_and_dice,precombat_seconds=1
 spell(slice_and_dice)
}

AddFunction assassinationprecombatmainpostconditions
{
}

AddFunction assassinationprecombatshortcdactions
{
 #apply_poison
 #flask
 #augmentation
 #food
 #snapshot_stats
 #marked_for_death,precombat_seconds=5,if=raid_event.adds.in>15
 if 600 > 15 spell(marked_for_death)
}

AddFunction assassinationprecombatshortcdpostconditions
{
 spell(stealth) or spell(slice_and_dice)
}

AddFunction assassinationprecombatcdactions
{
 unless 600 > 15 and spell(marked_for_death) or spell(stealth) or spell(slice_and_dice)
 {
  #use_item,name=azsharas_font_of_power
  assassinationuseitemactions()
  #guardian_of_azeroth,if=talent.exsanguinate.enabled
  if hastalent(exsanguinate_talent) spell(guardian_of_azeroth)
 }
}

AddFunction assassinationprecombatcdpostconditions
{
 600 > 15 and spell(marked_for_death) or spell(stealth) or spell(slice_and_dice)
}

### actions.essences

AddFunction assassinationessencesmainactions
{
 #concentrated_flame,if=energy.time_to_max>1&!debuff.vendetta.up&(!dot.concentrated_flame_burn.ticking&!action.concentrated_flame.in_flight|full_recharge_time<gcd.max)
 if timetomaxenergy() > 1 and not target.debuffpresent(vendetta) and { not target.debuffpresent(concentrated_flame_burn_debuff) and not inflighttotarget(concentrated_flame) or spellfullrecharge(concentrated_flame) < gcd() } spell(concentrated_flame)
 #blood_of_the_enemy,if=debuff.vendetta.up&(exsanguinated.garrote|debuff.shiv.up&combo_points.deficit<=1|debuff.vendetta.remains<=10)|target.time_to_die<=10
 if target.debuffpresent(vendetta) and { message("exsanguinated.garrote is not implemented") or target.debuffpresent(shiv) and combopointsdeficit() <= 1 or target.debuffremaining(vendetta) <= 10 } or target.timetodie() <= 10 spell(blood_of_the_enemy)
 #the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<10
 if buffpresent(reckless_force_buff) or buffstacks(reckless_force_counter) < 10 spell(the_unbound_force)
 #ripple_in_space
 spell(ripple_in_space)
 #worldvein_resonance
 spell(worldvein_resonance)
 #memory_of_lucid_dreams,if=energy<50&!cooldown.vendetta.up
 if energy() < 50 and not { not spellcooldown(vendetta) > 0 } spell(memory_of_lucid_dreams)
}

AddFunction assassinationessencesmainpostconditions
{
}

AddFunction assassinationessencesshortcdactions
{
 unless timetomaxenergy() > 1 and not target.debuffpresent(vendetta) and { not target.debuffpresent(concentrated_flame_burn_debuff) and not inflighttotarget(concentrated_flame) or spellfullrecharge(concentrated_flame) < gcd() } and spell(concentrated_flame) or { target.debuffpresent(vendetta) and { message("exsanguinated.garrote is not implemented") or target.debuffpresent(shiv) and combopointsdeficit() <= 1 or target.debuffremaining(vendetta) <= 10 } or target.timetodie() <= 10 } and spell(blood_of_the_enemy)
 {
  #focused_azerite_beam,if=spell_targets.fan_of_knives>=2|raid_event.adds.in>60&energy<70
  if enemies() >= 2 or 600 > 60 and energy() < 70 spell(focused_azerite_beam)
  #purifying_blast,if=spell_targets.fan_of_knives>=2|raid_event.adds.in>60
  if enemies() >= 2 or 600 > 60 spell(purifying_blast)

  unless { buffpresent(reckless_force_buff) or buffstacks(reckless_force_counter) < 10 } and spell(the_unbound_force) or spell(ripple_in_space) or spell(worldvein_resonance) or energy() < 50 and not { not spellcooldown(vendetta) > 0 } and spell(memory_of_lucid_dreams)
  {
   #cycling_variable,name=reaping_delay,op=min,if=essence.breath_of_the_dying.major,value=target.time_to_die
   #reaping_flames,target_if=target.time_to_die<1.5|((target.health.pct>80|target.health.pct<=20)&(active_enemies=1|variable.reaping_delay>29))|(target.time_to_pct_20>30&(active_enemies=1|variable.reaping_delay>44))
   if target.timetodie() < 1.5 or { target.healthpercent() > 80 or target.healthpercent() <= 20 } and { enemies() == 1 or reaping_delay() > 29 } or target.timetohealthpercent(20) > 30 and { enemies() == 1 or reaping_delay() > 44 } spell(reaping_flames)
  }
 }
}

AddFunction assassinationessencesshortcdpostconditions
{
 timetomaxenergy() > 1 and not target.debuffpresent(vendetta) and { not target.debuffpresent(concentrated_flame_burn_debuff) and not inflighttotarget(concentrated_flame) or spellfullrecharge(concentrated_flame) < gcd() } and spell(concentrated_flame) or { target.debuffpresent(vendetta) and { message("exsanguinated.garrote is not implemented") or target.debuffpresent(shiv) and combopointsdeficit() <= 1 or target.debuffremaining(vendetta) <= 10 } or target.timetodie() <= 10 } and spell(blood_of_the_enemy) or { buffpresent(reckless_force_buff) or buffstacks(reckless_force_counter) < 10 } and spell(the_unbound_force) or spell(ripple_in_space) or spell(worldvein_resonance) or energy() < 50 and not { not spellcooldown(vendetta) > 0 } and spell(memory_of_lucid_dreams)
}

AddFunction assassinationessencescdactions
{
 unless timetomaxenergy() > 1 and not target.debuffpresent(vendetta) and { not target.debuffpresent(concentrated_flame_burn_debuff) and not inflighttotarget(concentrated_flame) or spellfullrecharge(concentrated_flame) < gcd() } and spell(concentrated_flame) or { target.debuffpresent(vendetta) and { message("exsanguinated.garrote is not implemented") or target.debuffpresent(shiv) and combopointsdeficit() <= 1 or target.debuffremaining(vendetta) <= 10 } or target.timetodie() <= 10 } and spell(blood_of_the_enemy)
 {
  #guardian_of_azeroth,if=cooldown.vendetta.remains<3|debuff.vendetta.up|target.time_to_die<30
  if spellcooldown(vendetta) < 3 or target.debuffpresent(vendetta) or target.timetodie() < 30 spell(guardian_of_azeroth)
  #guardian_of_azeroth,if=floor((target.time_to_die-30)%cooldown)>floor((target.time_to_die-30-cooldown.vendetta.remains)%cooldown)
  if { target.timetodie() - 30 } / spellcooldown(guardian_of_azeroth) > { target.timetodie() - 30 - spellcooldown(vendetta) } / spellcooldown(guardian_of_azeroth) spell(guardian_of_azeroth)
 }
}

AddFunction assassinationessencescdpostconditions
{
 timetomaxenergy() > 1 and not target.debuffpresent(vendetta) and { not target.debuffpresent(concentrated_flame_burn_debuff) and not inflighttotarget(concentrated_flame) or spellfullrecharge(concentrated_flame) < gcd() } and spell(concentrated_flame) or { target.debuffpresent(vendetta) and { message("exsanguinated.garrote is not implemented") or target.debuffpresent(shiv) and combopointsdeficit() <= 1 or target.debuffremaining(vendetta) <= 10 } or target.timetodie() <= 10 } and spell(blood_of_the_enemy) or { enemies() >= 2 or 600 > 60 and energy() < 70 } and spell(focused_azerite_beam) or { enemies() >= 2 or 600 > 60 } and spell(purifying_blast) or { buffpresent(reckless_force_buff) or buffstacks(reckless_force_counter) < 10 } and spell(the_unbound_force) or spell(ripple_in_space) or spell(worldvein_resonance) or energy() < 50 and not { not spellcooldown(vendetta) > 0 } and spell(memory_of_lucid_dreams) or { target.timetodie() < 1.5 or { target.healthpercent() > 80 or target.healthpercent() <= 20 } and { enemies() == 1 or reaping_delay() > 29 } or target.timetohealthpercent(20) > 30 and { enemies() == 1 or reaping_delay() > 44 } } and spell(reaping_flames)
}

### actions.dot

AddFunction assassinationdotmainactions
{
 #variable,name=skip_cycle_garrote,value=priority_rotation&spell_targets.fan_of_knives>3&(dot.garrote.remains<cooldown.garrote.duration|poisoned_bleeds>5)
 #variable,name=skip_cycle_rupture,value=priority_rotation&spell_targets.fan_of_knives>3&(debuff.shiv.up|(poisoned_bleeds>5&!azerite.scent_of_blood.enabled))
 #variable,name=skip_rupture,value=debuff.vendetta.up&(debuff.shiv.up|master_assassin_remains>0)&dot.rupture.remains>2
 #garrote,if=talent.exsanguinate.enabled&!exsanguinated.garrote&dot.garrote.pmultiplier<=1&cooldown.exsanguinate.remains<2&spell_targets.fan_of_knives=1&raid_event.adds.in>6&dot.garrote.remains*0.5<target.time_to_die
 if hastalent(exsanguinate_talent) and not message("exsanguinated.garrote is not implemented") and target.debuffpersistentmultiplier(garrote) <= 1 and spellcooldown(exsanguinate) < 2 and enemies() == 1 and 600 > 6 and target.debuffremaining(garrote) * 0.5 < target.timetodie() spell(garrote)
 #rupture,if=talent.exsanguinate.enabled&(combo_points>=cp_max_spend&cooldown.exsanguinate.remains<1&dot.rupture.remains*0.5<target.time_to_die)
 if hastalent(exsanguinate_talent) and combopoints() >= maxcombopoints() and spellcooldown(exsanguinate) < 1 and target.debuffremaining(rupture) * 0.5 < target.timetodie() spell(rupture)
 #pool_resource,for_next=1
 #garrote,if=refreshable&combo_points.deficit>=1+3*(azerite.shrouded_suffocation.enabled&cooldown.vanish.up)&(pmultiplier<=1|remains<=tick_time&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&(!exsanguinated|remains<=tick_time*2&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&!ss_buffed&(target.time_to_die-remains)>4&(master_assassin_remains=0|!ticking&azerite.shrouded_suffocation.enabled)
 if target.refreshable(garrote) and combopointsdeficit() >= 1 + 3 * { hasazeritetrait(shrouded_suffocation_trait) and not spellcooldown(vanish) > 0 } and { persistentmultiplier(garrote) <= 1 or buffremaining(garrote) <= currentticktime(garrote) and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and { not target.debuffpresent(exsanguinated) or buffremaining(garrote) <= currentticktime(garrote) * 2 and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and not false(ss_buffed) and target.timetodie() - buffremaining(garrote) > 4 and { buffremaining(master_assassin_buff) == 0 or not buffpresent(garrote) and hasazeritetrait(shrouded_suffocation_trait) } spell(garrote)
 unless target.refreshable(garrote) and combopointsdeficit() >= 1 + 3 * { hasazeritetrait(shrouded_suffocation_trait) and not spellcooldown(vanish) > 0 } and { persistentmultiplier(garrote) <= 1 or buffremaining(garrote) <= currentticktime(garrote) and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and { not target.debuffpresent(exsanguinated) or buffremaining(garrote) <= currentticktime(garrote) * 2 and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and not false(ss_buffed) and target.timetodie() - buffremaining(garrote) > 4 and { buffremaining(master_assassin_buff) == 0 or not buffpresent(garrote) and hasazeritetrait(shrouded_suffocation_trait) } and spellusable(garrote) and spellcooldown(garrote) < timetoenergyfor(garrote)
 {
  #pool_resource,for_next=1
  #garrote,cycle_targets=1,if=!variable.skip_cycle_garrote&target!=self.target&refreshable&combo_points.deficit>=1+3*(azerite.shrouded_suffocation.enabled&cooldown.vanish.up)&(pmultiplier<=1|remains<=tick_time&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&(!exsanguinated|remains<=tick_time*2&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&!ss_buffed&(target.time_to_die-remains)>12&(master_assassin_remains=0|!ticking&azerite.shrouded_suffocation.enabled)
  if not skip_cycle_garrote() and not false(target_is_target) and target.refreshable(garrote) and combopointsdeficit() >= 1 + 3 * { hasazeritetrait(shrouded_suffocation_trait) and not spellcooldown(vanish) > 0 } and { persistentmultiplier(garrote) <= 1 or buffremaining(garrote) <= currentticktime(garrote) and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and { not target.debuffpresent(exsanguinated) or buffremaining(garrote) <= currentticktime(garrote) * 2 and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and not false(ss_buffed) and target.timetodie() - buffremaining(garrote) > 12 and { buffremaining(master_assassin_buff) == 0 or not buffpresent(garrote) and hasazeritetrait(shrouded_suffocation_trait) } spell(garrote)
  unless not skip_cycle_garrote() and not false(target_is_target) and target.refreshable(garrote) and combopointsdeficit() >= 1 + 3 * { hasazeritetrait(shrouded_suffocation_trait) and not spellcooldown(vanish) > 0 } and { persistentmultiplier(garrote) <= 1 or buffremaining(garrote) <= currentticktime(garrote) and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and { not target.debuffpresent(exsanguinated) or buffremaining(garrote) <= currentticktime(garrote) * 2 and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and not false(ss_buffed) and target.timetodie() - buffremaining(garrote) > 12 and { buffremaining(master_assassin_buff) == 0 or not buffpresent(garrote) and hasazeritetrait(shrouded_suffocation_trait) } and spellusable(garrote) and spellcooldown(garrote) < timetoenergyfor(garrote)
  {
   #crimson_tempest,if=spell_targets>=2&remains<2+(spell_targets>=5)&combo_points>=4
   if enemies() >= 2 and buffremaining(crimson_tempest) < 2 + { enemies() >= 5 } and combopoints() >= 4 spell(crimson_tempest)
   #rupture,if=!variable.skip_rupture&(combo_points>=4&refreshable|!ticking&(time>10|combo_points>=2))&(pmultiplier<=1|remains<=tick_time&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&(!exsanguinated|remains<=tick_time*2&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&target.time_to_die-remains>4
   if not skip_rupture() and { combopoints() >= 4 and target.refreshable(rupture) or not buffpresent(rupture) and { timeincombat() > 10 or combopoints() >= 2 } } and { persistentmultiplier(rupture) <= 1 or buffremaining(rupture) <= currentticktime(rupture) and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and { not target.debuffpresent(exsanguinated) or buffremaining(rupture) <= currentticktime(rupture) * 2 and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and target.timetodie() - buffremaining(rupture) > 4 spell(rupture)
   #rupture,cycle_targets=1,if=!variable.skip_cycle_rupture&!variable.skip_rupture&target!=self.target&combo_points>=4&refreshable&(pmultiplier<=1|remains<=tick_time&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&(!exsanguinated|remains<=tick_time*2&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&target.time_to_die-remains>4
   if not skip_cycle_rupture() and not skip_rupture() and not false(target_is_target) and combopoints() >= 4 and target.refreshable(rupture) and { persistentmultiplier(rupture) <= 1 or buffremaining(rupture) <= currentticktime(rupture) and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and { not target.debuffpresent(exsanguinated) or buffremaining(rupture) <= currentticktime(rupture) * 2 and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and target.timetodie() - buffremaining(rupture) > 4 spell(rupture)
   #crimson_tempest,if=spell_targets=1&combo_points>=(cp_max_spend-1)&refreshable&!exsanguinated&!debuff.shiv.up&master_assassin_remains=0&!azerite.twist_the_knife.enabled&target.time_to_die-remains>4
   if enemies() == 1 and combopoints() >= maxcombopoints() - 1 and target.refreshable(crimson_tempest) and not target.debuffpresent(exsanguinated) and not target.debuffpresent(shiv) and buffremaining(master_assassin_buff) == 0 and not hasazeritetrait(twist_the_knife_trait) and target.timetodie() - buffremaining(crimson_tempest) > 4 spell(crimson_tempest)
   #sepsis
   spell(sepsis)
  }
 }
}

AddFunction assassinationdotmainpostconditions
{
}

AddFunction assassinationdotshortcdactions
{
}

AddFunction assassinationdotshortcdpostconditions
{
 hastalent(exsanguinate_talent) and not message("exsanguinated.garrote is not implemented") and target.debuffpersistentmultiplier(garrote) <= 1 and spellcooldown(exsanguinate) < 2 and enemies() == 1 and 600 > 6 and target.debuffremaining(garrote) * 0.5 < target.timetodie() and spell(garrote) or hastalent(exsanguinate_talent) and combopoints() >= maxcombopoints() and spellcooldown(exsanguinate) < 1 and target.debuffremaining(rupture) * 0.5 < target.timetodie() and spell(rupture) or target.refreshable(garrote) and combopointsdeficit() >= 1 + 3 * { hasazeritetrait(shrouded_suffocation_trait) and not spellcooldown(vanish) > 0 } and { persistentmultiplier(garrote) <= 1 or buffremaining(garrote) <= currentticktime(garrote) and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and { not target.debuffpresent(exsanguinated) or buffremaining(garrote) <= currentticktime(garrote) * 2 and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and not false(ss_buffed) and target.timetodie() - buffremaining(garrote) > 4 and { buffremaining(master_assassin_buff) == 0 or not buffpresent(garrote) and hasazeritetrait(shrouded_suffocation_trait) } and spell(garrote) or not { target.refreshable(garrote) and combopointsdeficit() >= 1 + 3 * { hasazeritetrait(shrouded_suffocation_trait) and not spellcooldown(vanish) > 0 } and { persistentmultiplier(garrote) <= 1 or buffremaining(garrote) <= currentticktime(garrote) and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and { not target.debuffpresent(exsanguinated) or buffremaining(garrote) <= currentticktime(garrote) * 2 and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and not false(ss_buffed) and target.timetodie() - buffremaining(garrote) > 4 and { buffremaining(master_assassin_buff) == 0 or not buffpresent(garrote) and hasazeritetrait(shrouded_suffocation_trait) } and spellusable(garrote) and spellcooldown(garrote) < timetoenergyfor(garrote) } and { not skip_cycle_garrote() and not false(target_is_target) and target.refreshable(garrote) and combopointsdeficit() >= 1 + 3 * { hasazeritetrait(shrouded_suffocation_trait) and not spellcooldown(vanish) > 0 } and { persistentmultiplier(garrote) <= 1 or buffremaining(garrote) <= currentticktime(garrote) and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and { not target.debuffpresent(exsanguinated) or buffremaining(garrote) <= currentticktime(garrote) * 2 and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and not false(ss_buffed) and target.timetodie() - buffremaining(garrote) > 12 and { buffremaining(master_assassin_buff) == 0 or not buffpresent(garrote) and hasazeritetrait(shrouded_suffocation_trait) } and spell(garrote) or not { not skip_cycle_garrote() and not false(target_is_target) and target.refreshable(garrote) and combopointsdeficit() >= 1 + 3 * { hasazeritetrait(shrouded_suffocation_trait) and not spellcooldown(vanish) > 0 } and { persistentmultiplier(garrote) <= 1 or buffremaining(garrote) <= currentticktime(garrote) and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and { not target.debuffpresent(exsanguinated) or buffremaining(garrote) <= currentticktime(garrote) * 2 and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and not false(ss_buffed) and target.timetodie() - buffremaining(garrote) > 12 and { buffremaining(master_assassin_buff) == 0 or not buffpresent(garrote) and hasazeritetrait(shrouded_suffocation_trait) } and spellusable(garrote) and spellcooldown(garrote) < timetoenergyfor(garrote) } and { enemies() >= 2 and buffremaining(crimson_tempest) < 2 + { enemies() >= 5 } and combopoints() >= 4 and spell(crimson_tempest) or not skip_rupture() and { combopoints() >= 4 and target.refreshable(rupture) or not buffpresent(rupture) and { timeincombat() > 10 or combopoints() >= 2 } } and { persistentmultiplier(rupture) <= 1 or buffremaining(rupture) <= currentticktime(rupture) and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and { not target.debuffpresent(exsanguinated) or buffremaining(rupture) <= currentticktime(rupture) * 2 and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and target.timetodie() - buffremaining(rupture) > 4 and spell(rupture) or not skip_cycle_rupture() and not skip_rupture() and not false(target_is_target) and combopoints() >= 4 and target.refreshable(rupture) and { persistentmultiplier(rupture) <= 1 or buffremaining(rupture) <= currentticktime(rupture) and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and { not target.debuffpresent(exsanguinated) or buffremaining(rupture) <= currentticktime(rupture) * 2 and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and target.timetodie() - buffremaining(rupture) > 4 and spell(rupture) or enemies() == 1 and combopoints() >= maxcombopoints() - 1 and target.refreshable(crimson_tempest) and not target.debuffpresent(exsanguinated) and not target.debuffpresent(shiv) and buffremaining(master_assassin_buff) == 0 and not hasazeritetrait(twist_the_knife_trait) and target.timetodie() - buffremaining(crimson_tempest) > 4 and spell(crimson_tempest) or spell(sepsis) } }
}

AddFunction assassinationdotcdactions
{
}

AddFunction assassinationdotcdpostconditions
{
 hastalent(exsanguinate_talent) and not message("exsanguinated.garrote is not implemented") and target.debuffpersistentmultiplier(garrote) <= 1 and spellcooldown(exsanguinate) < 2 and enemies() == 1 and 600 > 6 and target.debuffremaining(garrote) * 0.5 < target.timetodie() and spell(garrote) or hastalent(exsanguinate_talent) and combopoints() >= maxcombopoints() and spellcooldown(exsanguinate) < 1 and target.debuffremaining(rupture) * 0.5 < target.timetodie() and spell(rupture) or target.refreshable(garrote) and combopointsdeficit() >= 1 + 3 * { hasazeritetrait(shrouded_suffocation_trait) and not spellcooldown(vanish) > 0 } and { persistentmultiplier(garrote) <= 1 or buffremaining(garrote) <= currentticktime(garrote) and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and { not target.debuffpresent(exsanguinated) or buffremaining(garrote) <= currentticktime(garrote) * 2 and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and not false(ss_buffed) and target.timetodie() - buffremaining(garrote) > 4 and { buffremaining(master_assassin_buff) == 0 or not buffpresent(garrote) and hasazeritetrait(shrouded_suffocation_trait) } and spell(garrote) or not { target.refreshable(garrote) and combopointsdeficit() >= 1 + 3 * { hasazeritetrait(shrouded_suffocation_trait) and not spellcooldown(vanish) > 0 } and { persistentmultiplier(garrote) <= 1 or buffremaining(garrote) <= currentticktime(garrote) and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and { not target.debuffpresent(exsanguinated) or buffremaining(garrote) <= currentticktime(garrote) * 2 and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and not false(ss_buffed) and target.timetodie() - buffremaining(garrote) > 4 and { buffremaining(master_assassin_buff) == 0 or not buffpresent(garrote) and hasazeritetrait(shrouded_suffocation_trait) } and spellusable(garrote) and spellcooldown(garrote) < timetoenergyfor(garrote) } and { not skip_cycle_garrote() and not false(target_is_target) and target.refreshable(garrote) and combopointsdeficit() >= 1 + 3 * { hasazeritetrait(shrouded_suffocation_trait) and not spellcooldown(vanish) > 0 } and { persistentmultiplier(garrote) <= 1 or buffremaining(garrote) <= currentticktime(garrote) and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and { not target.debuffpresent(exsanguinated) or buffremaining(garrote) <= currentticktime(garrote) * 2 and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and not false(ss_buffed) and target.timetodie() - buffremaining(garrote) > 12 and { buffremaining(master_assassin_buff) == 0 or not buffpresent(garrote) and hasazeritetrait(shrouded_suffocation_trait) } and spell(garrote) or not { not skip_cycle_garrote() and not false(target_is_target) and target.refreshable(garrote) and combopointsdeficit() >= 1 + 3 * { hasazeritetrait(shrouded_suffocation_trait) and not spellcooldown(vanish) > 0 } and { persistentmultiplier(garrote) <= 1 or buffremaining(garrote) <= currentticktime(garrote) and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and { not target.debuffpresent(exsanguinated) or buffremaining(garrote) <= currentticktime(garrote) * 2 and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and not false(ss_buffed) and target.timetodie() - buffremaining(garrote) > 12 and { buffremaining(master_assassin_buff) == 0 or not buffpresent(garrote) and hasazeritetrait(shrouded_suffocation_trait) } and spellusable(garrote) and spellcooldown(garrote) < timetoenergyfor(garrote) } and { enemies() >= 2 and buffremaining(crimson_tempest) < 2 + { enemies() >= 5 } and combopoints() >= 4 and spell(crimson_tempest) or not skip_rupture() and { combopoints() >= 4 and target.refreshable(rupture) or not buffpresent(rupture) and { timeincombat() > 10 or combopoints() >= 2 } } and { persistentmultiplier(rupture) <= 1 or buffremaining(rupture) <= currentticktime(rupture) and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and { not target.debuffpresent(exsanguinated) or buffremaining(rupture) <= currentticktime(rupture) * 2 and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and target.timetodie() - buffremaining(rupture) > 4 and spell(rupture) or not skip_cycle_rupture() and not skip_rupture() and not false(target_is_target) and combopoints() >= 4 and target.refreshable(rupture) and { persistentmultiplier(rupture) <= 1 or buffremaining(rupture) <= currentticktime(rupture) and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and { not target.debuffpresent(exsanguinated) or buffremaining(rupture) <= currentticktime(rupture) * 2 and enemies() >= 3 + hasazeritetrait(shrouded_suffocation_trait) } and target.timetodie() - buffremaining(rupture) > 4 and spell(rupture) or enemies() == 1 and combopoints() >= maxcombopoints() - 1 and target.refreshable(crimson_tempest) and not target.debuffpresent(exsanguinated) and not target.debuffpresent(shiv) and buffremaining(master_assassin_buff) == 0 and not hasazeritetrait(twist_the_knife_trait) and target.timetodie() - buffremaining(crimson_tempest) > 4 and spell(crimson_tempest) or spell(sepsis) } }
}

### actions.direct

AddFunction assassinationdirectmainactions
{
 #envenom,if=(combo_points>=4+talent.deeper_stratagem.enabled|combo_points=animacharged_cp)&(debuff.vendetta.up|debuff.shiv.up|energy.deficit<=25+variable.energy_regen_combined|!variable.single_target)&(!talent.exsanguinate.enabled|cooldown.exsanguinate.remains>2)
 if { combopoints() >= 4 + talentpoints(deeper_stratagem_talent) or combopoints() == message("animacharged_cp is not implemented") } and { target.debuffpresent(vendetta) or target.debuffpresent(shiv) or energydeficit() <= 25 + energy_regen_combined() or not single_target() } and { not hastalent(exsanguinate_talent) or spellcooldown(exsanguinate) > 2 } spell(envenom)
 #variable,name=use_filler,value=combo_points.deficit>1|energy.deficit<=25+variable.energy_regen_combined|!variable.single_target
 #serrated_bone_spike,cycle_targets=1,if=buff.slice_and_dice.up&!dot.serrated_bone_spike_dot.ticking|fight_remains<=5|cooldown.serrated_bone_spike.charges_fractional>=2.75
 if buffpresent(slice_and_dice) and not target.debuffpresent(serrated_bone_spike_dot_debuff) or fightremains() <= 5 or spellcharges(serrated_bone_spike count=0) >= 2.75 spell(serrated_bone_spike)
 #fan_of_knives,if=variable.use_filler&azerite.echoing_blades.enabled&spell_targets.fan_of_knives>=2+(debuff.vendetta.up*(1+(azerite.echoing_blades.rank=1)))
 if use_filler() and hasazeritetrait(echoing_blades_trait) and enemies() >= 2 + target.debuffpresent(vendetta) * { 1 + { azeritetraitrank(echoing_blades_trait) == 1 } } spell(fan_of_knives)
 #fan_of_knives,if=variable.use_filler&(buff.hidden_blades.stack>=19|(!priority_rotation&spell_targets.fan_of_knives>=4+(azerite.double_dose.rank>2)+stealthed.rogue))
 if use_filler() and { buffstacks(hidden_blades) >= 19 or not checkboxon(opt_priority_rotation) and enemies() >= 4 + { azeritetraitrank(double_dose_trait) > 2 } + stealthed() } spell(fan_of_knives)
 #fan_of_knives,target_if=!dot.deadly_poison_dot.ticking,if=variable.use_filler&spell_targets.fan_of_knives>=3
 if not target.debuffpresent(deadly_poison_dot_debuff) and use_filler() and enemies() >= 3 spell(fan_of_knives)
 #ambush,if=variable.use_filler
 if use_filler() spell(ambush)
 #mutilate,target_if=!dot.deadly_poison_dot.ticking,if=variable.use_filler&spell_targets.fan_of_knives=2
 if not target.debuffpresent(deadly_poison_dot_debuff) and use_filler() and enemies() == 2 spell(mutilate)
 #mutilate,if=variable.use_filler
 if use_filler() spell(mutilate)
}

AddFunction assassinationdirectmainpostconditions
{
}

AddFunction assassinationdirectshortcdactions
{
 unless { combopoints() >= 4 + talentpoints(deeper_stratagem_talent) or combopoints() == message("animacharged_cp is not implemented") } and { target.debuffpresent(vendetta) or target.debuffpresent(shiv) or energydeficit() <= 25 + energy_regen_combined() or not single_target() } and { not hastalent(exsanguinate_talent) or spellcooldown(exsanguinate) > 2 } and spell(envenom) or { buffpresent(slice_and_dice) and not target.debuffpresent(serrated_bone_spike_dot_debuff) or fightremains() <= 5 or spellcharges(serrated_bone_spike count=0) >= 2.75 } and spell(serrated_bone_spike) or use_filler() and hasazeritetrait(echoing_blades_trait) and enemies() >= 2 + target.debuffpresent(vendetta) * { 1 + { azeritetraitrank(echoing_blades_trait) == 1 } } and spell(fan_of_knives) or use_filler() and { buffstacks(hidden_blades) >= 19 or not checkboxon(opt_priority_rotation) and enemies() >= 4 + { azeritetraitrank(double_dose_trait) > 2 } + stealthed() } and spell(fan_of_knives) or not target.debuffpresent(deadly_poison_dot_debuff) and use_filler() and enemies() >= 3 and spell(fan_of_knives)
 {
  #echoing_reprimand,if=variable.use_filler
  if use_filler() spell(echoing_reprimand)
 }
}

AddFunction assassinationdirectshortcdpostconditions
{
 { combopoints() >= 4 + talentpoints(deeper_stratagem_talent) or combopoints() == message("animacharged_cp is not implemented") } and { target.debuffpresent(vendetta) or target.debuffpresent(shiv) or energydeficit() <= 25 + energy_regen_combined() or not single_target() } and { not hastalent(exsanguinate_talent) or spellcooldown(exsanguinate) > 2 } and spell(envenom) or { buffpresent(slice_and_dice) and not target.debuffpresent(serrated_bone_spike_dot_debuff) or fightremains() <= 5 or spellcharges(serrated_bone_spike count=0) >= 2.75 } and spell(serrated_bone_spike) or use_filler() and hasazeritetrait(echoing_blades_trait) and enemies() >= 2 + target.debuffpresent(vendetta) * { 1 + { azeritetraitrank(echoing_blades_trait) == 1 } } and spell(fan_of_knives) or use_filler() and { buffstacks(hidden_blades) >= 19 or not checkboxon(opt_priority_rotation) and enemies() >= 4 + { azeritetraitrank(double_dose_trait) > 2 } + stealthed() } and spell(fan_of_knives) or not target.debuffpresent(deadly_poison_dot_debuff) and use_filler() and enemies() >= 3 and spell(fan_of_knives) or use_filler() and spell(ambush) or not target.debuffpresent(deadly_poison_dot_debuff) and use_filler() and enemies() == 2 and spell(mutilate) or use_filler() and spell(mutilate)
}

AddFunction assassinationdirectcdactions
{
}

AddFunction assassinationdirectcdpostconditions
{
 { combopoints() >= 4 + talentpoints(deeper_stratagem_talent) or combopoints() == message("animacharged_cp is not implemented") } and { target.debuffpresent(vendetta) or target.debuffpresent(shiv) or energydeficit() <= 25 + energy_regen_combined() or not single_target() } and { not hastalent(exsanguinate_talent) or spellcooldown(exsanguinate) > 2 } and spell(envenom) or { buffpresent(slice_and_dice) and not target.debuffpresent(serrated_bone_spike_dot_debuff) or fightremains() <= 5 or spellcharges(serrated_bone_spike count=0) >= 2.75 } and spell(serrated_bone_spike) or use_filler() and hasazeritetrait(echoing_blades_trait) and enemies() >= 2 + target.debuffpresent(vendetta) * { 1 + { azeritetraitrank(echoing_blades_trait) == 1 } } and spell(fan_of_knives) or use_filler() and { buffstacks(hidden_blades) >= 19 or not checkboxon(opt_priority_rotation) and enemies() >= 4 + { azeritetraitrank(double_dose_trait) > 2 } + stealthed() } and spell(fan_of_knives) or not target.debuffpresent(deadly_poison_dot_debuff) and use_filler() and enemies() >= 3 and spell(fan_of_knives) or use_filler() and spell(echoing_reprimand) or use_filler() and spell(ambush) or not target.debuffpresent(deadly_poison_dot_debuff) and use_filler() and enemies() == 2 and spell(mutilate) or use_filler() and spell(mutilate)
}

### actions.cds

AddFunction assassinationcdsmainactions
{
 #flagellation_cleanse,if=debuff.flagellation.remains<2|debuff.flagellation.stack>=40
 if target.debuffremaining(flagellation) < 2 or target.debuffstacks(flagellation) >= 40 spell(flagellation_cleanse)
 #call_action_list,name=essences,if=!stealthed.all&dot.rupture.ticking&master_assassin_remains=0
 if not stealthed() and target.debuffpresent(rupture) and buffremaining(master_assassin_buff) == 0 assassinationessencesmainactions()

 unless not stealthed() and target.debuffpresent(rupture) and buffremaining(master_assassin_buff) == 0 and assassinationessencesmainpostconditions()
 {
  #variable,name=ss_vanish_condition,value=azerite.shrouded_suffocation.enabled&(non_ss_buffed_targets>=1|spell_targets.fan_of_knives=3)&(ss_buffed_targets_above_pandemic=0|spell_targets.fan_of_knives>=6)
  #pool_resource,for_next=1,extra_amount=45
  #vanish,if=talent.subterfuge.enabled&!stealthed.rogue&cooldown.garrote.up&(variable.ss_vanish_condition|!azerite.shrouded_suffocation.enabled&(dot.garrote.refreshable|debuff.vendetta.up&dot.garrote.pmultiplier<=1))&combo_points.deficit>=((1+2*azerite.shrouded_suffocation.enabled)*spell_targets.fan_of_knives)>?4&raid_event.adds.in>12
  unless hastalent(subterfuge_talent) and not stealthed() and not spellcooldown(garrote) > 0 and { ss_vanish_condition() or not hasazeritetrait(shrouded_suffocation_trait) and { target.debuffrefreshable(garrote) or target.debuffpresent(vendetta) and target.debuffpersistentmultiplier(garrote) <= 1 } } and combopointsdeficit() >= { 1 + 2 * hasazeritetrait(shrouded_suffocation_trait) } * enemies() >? 4 and 600 > 12 and checkboxon(opt_vanish) and spellusable(vanish) and spellcooldown(vanish) < timetoenergy(45)
  {
   #shiv,if=level>=58&dot.rupture.ticking&(!equipped.azsharas_font_of_power|cooldown.vendetta.remains>10)
   if level() >= 58 and target.debuffpresent(rupture) and { not hasequippeditem(azsharas_font_of_power_item) or spellcooldown(vendetta) > 10 } spell(shiv)
   #berserking,if=debuff.vendetta.up
   if target.debuffpresent(vendetta) spell(berserking)
  }
 }
}

AddFunction assassinationcdsmainpostconditions
{
 not stealthed() and target.debuffpresent(rupture) and buffremaining(master_assassin_buff) == 0 and assassinationessencesmainpostconditions()
}

AddFunction assassinationcdsshortcdactions
{
 #flagellation
 spell(flagellation)

 unless { target.debuffremaining(flagellation) < 2 or target.debuffstacks(flagellation) >= 40 } and spell(flagellation_cleanse)
 {
  #call_action_list,name=essences,if=!stealthed.all&dot.rupture.ticking&master_assassin_remains=0
  if not stealthed() and target.debuffpresent(rupture) and buffremaining(master_assassin_buff) == 0 assassinationessencesshortcdactions()

  unless not stealthed() and target.debuffpresent(rupture) and buffremaining(master_assassin_buff) == 0 and assassinationessencesshortcdpostconditions()
  {
   #marked_for_death,target_if=min:target.time_to_die,if=raid_event.adds.up&(target.time_to_die<combo_points.deficit*1.5|combo_points.deficit>=cp_max_spend)
   if false(raid_event_adds_exists) and { target.timetodie() < combopointsdeficit() * 1.5 or combopointsdeficit() >= maxcombopoints() } spell(marked_for_death)
   #marked_for_death,if=raid_event.adds.in>30-raid_event.adds.duration&combo_points.deficit>=cp_max_spend
   if 600 > 30 - 10 and combopointsdeficit() >= maxcombopoints() spell(marked_for_death)
   #variable,name=ss_vanish_condition,value=azerite.shrouded_suffocation.enabled&(non_ss_buffed_targets>=1|spell_targets.fan_of_knives=3)&(ss_buffed_targets_above_pandemic=0|spell_targets.fan_of_knives>=6)
   #pool_resource,for_next=1,extra_amount=45
   #vanish,if=talent.subterfuge.enabled&!stealthed.rogue&cooldown.garrote.up&(variable.ss_vanish_condition|!azerite.shrouded_suffocation.enabled&(dot.garrote.refreshable|debuff.vendetta.up&dot.garrote.pmultiplier<=1))&combo_points.deficit>=((1+2*azerite.shrouded_suffocation.enabled)*spell_targets.fan_of_knives)>?4&raid_event.adds.in>12
   unless hastalent(subterfuge_talent) and not stealthed() and not spellcooldown(garrote) > 0 and { ss_vanish_condition() or not hasazeritetrait(shrouded_suffocation_trait) and { target.debuffrefreshable(garrote) or target.debuffpresent(vendetta) and target.debuffpersistentmultiplier(garrote) <= 1 } } and combopointsdeficit() >= { 1 + 2 * hasazeritetrait(shrouded_suffocation_trait) } * enemies() >? 4 and 600 > 12 and checkboxon(opt_vanish) and spellusable(vanish) and spellcooldown(vanish) < timetoenergy(45)
   {
    #exsanguinate,if=!stealthed.rogue&(!dot.garrote.refreshable&dot.rupture.remains>4+4*cp_max_spend|dot.rupture.remains*0.5>target.time_to_die)&target.time_to_die>4
    if not stealthed() and { not target.debuffrefreshable(garrote) and target.debuffremaining(rupture) > 4 + 4 * maxcombopoints() or target.debuffremaining(rupture) * 0.5 > target.timetodie() } and target.timetodie() > 4 spell(exsanguinate)
   }
  }
 }
}

AddFunction assassinationcdsshortcdpostconditions
{
 { target.debuffremaining(flagellation) < 2 or target.debuffstacks(flagellation) >= 40 } and spell(flagellation_cleanse) or not stealthed() and target.debuffpresent(rupture) and buffremaining(master_assassin_buff) == 0 and assassinationessencesshortcdpostconditions() or not { hastalent(subterfuge_talent) and not stealthed() and not spellcooldown(garrote) > 0 and { ss_vanish_condition() or not hasazeritetrait(shrouded_suffocation_trait) and { target.debuffrefreshable(garrote) or target.debuffpresent(vendetta) and target.debuffpersistentmultiplier(garrote) <= 1 } } and combopointsdeficit() >= { 1 + 2 * hasazeritetrait(shrouded_suffocation_trait) } * enemies() >? 4 and 600 > 12 and checkboxon(opt_vanish) and spellusable(vanish) and spellcooldown(vanish) < timetoenergy(45) } and { level() >= 58 and target.debuffpresent(rupture) and { not hasequippeditem(azsharas_font_of_power_item) or spellcooldown(vendetta) > 10 } and spell(shiv) or target.debuffpresent(vendetta) and spell(berserking) }
}

AddFunction assassinationcdscdactions
{
 unless spell(flagellation) or { target.debuffremaining(flagellation) < 2 or target.debuffstacks(flagellation) >= 40 } and spell(flagellation_cleanse)
 {
  #use_item,name=azsharas_font_of_power,if=!stealthed.all&master_assassin_remains=0&(cooldown.vendetta.remains<?(cooldown.shiv.remains*equipped.ashvanes_razor_coral))<10+10*equipped.ashvanes_razor_coral&!debuff.vendetta.up&!debuff.shiv.up
  if not stealthed() and buffremaining(master_assassin_buff) == 0 and spellcooldown(vendetta) <? spellcooldown(shiv) * hasequippeditem(ashvanes_razor_coral_item) < 10 + 10 * hasequippeditem(ashvanes_razor_coral_item) and not target.debuffpresent(vendetta) and not target.debuffpresent(shiv) assassinationuseitemactions()
  #call_action_list,name=essences,if=!stealthed.all&dot.rupture.ticking&master_assassin_remains=0
  if not stealthed() and target.debuffpresent(rupture) and buffremaining(master_assassin_buff) == 0 assassinationessencescdactions()

  unless not stealthed() and target.debuffpresent(rupture) and buffremaining(master_assassin_buff) == 0 and assassinationessencescdpostconditions() or false(raid_event_adds_exists) and { target.timetodie() < combopointsdeficit() * 1.5 or combopointsdeficit() >= maxcombopoints() } and spell(marked_for_death) or 600 > 30 - 10 and combopointsdeficit() >= maxcombopoints() and spell(marked_for_death)
  {
   #variable,name=vendetta_subterfuge_condition,value=!talent.subterfuge.enabled|!azerite.shrouded_suffocation.enabled|dot.garrote.pmultiplier>1&(spell_targets.fan_of_knives<6|!cooldown.vanish.up)
   #variable,name=vendetta_nightstalker_condition,value=!talent.nightstalker.enabled|!talent.exsanguinate.enabled|cooldown.exsanguinate.remains<5-2*talent.deeper_stratagem.enabled
   #variable,name=variable,name=vendetta_font_condition,value=!equipped.azsharas_font_of_power|azerite.shrouded_suffocation.enabled|debuff.razor_coral_debuff.down|trinket.ashvanes_razor_coral.cooldown.remains<10&(cooldown.shiv.remains<1|debuff.shiv.up)
   #vendetta,if=!stealthed.rogue&dot.rupture.ticking&!debuff.vendetta.up&variable.vendetta_subterfuge_condition&variable.vendetta_nightstalker_condition&variable.vendetta_font_condition
   if not stealthed() and target.debuffpresent(rupture) and not target.debuffpresent(vendetta) and vendetta_subterfuge_condition() and vendetta_nightstalker_condition() and vendetta_font_condition() spell(vendetta)
   #vanish,if=talent.exsanguinate.enabled&talent.nightstalker.enabled&combo_points>=cp_max_spend&cooldown.exsanguinate.remains<1
   if hastalent(exsanguinate_talent) and hastalent(nightstalker_talent) and combopoints() >= maxcombopoints() and spellcooldown(exsanguinate) < 1 and checkboxon(opt_vanish) spell(vanish)
   #vanish,if=talent.nightstalker.enabled&!talent.exsanguinate.enabled&combo_points>=cp_max_spend&(debuff.vendetta.up|essence.vision_of_perfection.enabled)
   if hastalent(nightstalker_talent) and not hastalent(exsanguinate_talent) and combopoints() >= maxcombopoints() and { target.debuffpresent(vendetta) or azeriteessenceisenabled(vision_of_perfection_essence_id) } and checkboxon(opt_vanish) spell(vanish)
   #variable,name=ss_vanish_condition,value=azerite.shrouded_suffocation.enabled&(non_ss_buffed_targets>=1|spell_targets.fan_of_knives=3)&(ss_buffed_targets_above_pandemic=0|spell_targets.fan_of_knives>=6)
   #pool_resource,for_next=1,extra_amount=45
   #vanish,if=talent.subterfuge.enabled&!stealthed.rogue&cooldown.garrote.up&(variable.ss_vanish_condition|!azerite.shrouded_suffocation.enabled&(dot.garrote.refreshable|debuff.vendetta.up&dot.garrote.pmultiplier<=1))&combo_points.deficit>=((1+2*azerite.shrouded_suffocation.enabled)*spell_targets.fan_of_knives)>?4&raid_event.adds.in>12
   if hastalent(subterfuge_talent) and not stealthed() and not spellcooldown(garrote) > 0 and { ss_vanish_condition() or not hasazeritetrait(shrouded_suffocation_trait) and { target.debuffrefreshable(garrote) or target.debuffpresent(vendetta) and target.debuffpersistentmultiplier(garrote) <= 1 } } and combopointsdeficit() >= { 1 + 2 * hasazeritetrait(shrouded_suffocation_trait) } * enemies() >? 4 and 600 > 12 and checkboxon(opt_vanish) spell(vanish)
   unless hastalent(subterfuge_talent) and not stealthed() and not spellcooldown(garrote) > 0 and { ss_vanish_condition() or not hasazeritetrait(shrouded_suffocation_trait) and { target.debuffrefreshable(garrote) or target.debuffpresent(vendetta) and target.debuffpersistentmultiplier(garrote) <= 1 } } and combopointsdeficit() >= { 1 + 2 * hasazeritetrait(shrouded_suffocation_trait) } * enemies() >? 4 and 600 > 12 and checkboxon(opt_vanish) and spellusable(vanish) and spellcooldown(vanish) < timetoenergy(45)
   {
    #vanish,if=(talent.master_assassin.enabled|runeforge.mark_of_the_master_assassin.equipped)&!stealthed.all&master_assassin_remains<=0&!dot.rupture.refreshable&dot.garrote.remains>3&(debuff.vendetta.up&debuff.shiv.up&(!essence.blood_of_the_enemy.major|debuff.blood_of_the_enemy.up)|essence.vision_of_perfection.enabled)
    if { hastalent(master_assassin_talent) or message("runeforge.mark_of_the_master_assassin.equipped is not implemented") } and not stealthed() and buffremaining(master_assassin_buff) <= 0 and not target.debuffrefreshable(rupture) and target.debuffremaining(garrote) > 3 and { target.debuffpresent(vendetta) and target.debuffpresent(shiv) and { not azeriteessenceismajor(blood_of_the_enemy_essence_id) or target.debuffpresent(blood_of_the_enemy) } or azeriteessenceisenabled(vision_of_perfection_essence_id) } and checkboxon(opt_vanish) spell(vanish)
    #shadowmeld,if=!stealthed.all&azerite.shrouded_suffocation.enabled&dot.garrote.refreshable&dot.garrote.pmultiplier<=1&combo_points.deficit>=1
    if not stealthed() and hasazeritetrait(shrouded_suffocation_trait) and target.debuffrefreshable(garrote) and target.debuffpersistentmultiplier(garrote) <= 1 and combopointsdeficit() >= 1 spell(shadowmeld)

    unless not stealthed() and { not target.debuffrefreshable(garrote) and target.debuffremaining(rupture) > 4 + 4 * maxcombopoints() or target.debuffremaining(rupture) * 0.5 > target.timetodie() } and target.timetodie() > 4 and spell(exsanguinate) or level() >= 58 and target.debuffpresent(rupture) and { not hasequippeditem(azsharas_font_of_power_item) or spellcooldown(vendetta) > 10 } and spell(shiv)
    {
     #potion,if=buff.bloodlust.react|debuff.vendetta.up
     if { buffpresent(bloodlust) or target.debuffpresent(vendetta) } and checkboxon(opt_use_consumables) and target.classification(worldboss) item(unbridled_fury_item usable=1)
     #blood_fury,if=debuff.vendetta.up
     if target.debuffpresent(vendetta) spell(blood_fury)

     unless target.debuffpresent(vendetta) and spell(berserking)
     {
      #fireblood,if=debuff.vendetta.up
      if target.debuffpresent(vendetta) spell(fireblood)
      #ancestral_call,if=debuff.vendetta.up
      if target.debuffpresent(vendetta) spell(ancestral_call)
      #use_item,name=galecallers_boon,if=(debuff.vendetta.up|(!talent.exsanguinate.enabled&cooldown.vendetta.remains>45|talent.exsanguinate.enabled&(cooldown.exsanguinate.remains<6|cooldown.exsanguinate.remains>20&fight_remains>65)))&!exsanguinated.rupture
      if { target.debuffpresent(vendetta) or not hastalent(exsanguinate_talent) and spellcooldown(vendetta) > 45 or hastalent(exsanguinate_talent) and { spellcooldown(exsanguinate) < 6 or spellcooldown(exsanguinate) > 20 and fightremains() > 65 } } and not message("exsanguinated.rupture is not implemented") assassinationuseitemactions()
      #use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|target.time_to_die<20
      if target.debuffexpires(razor_coral) or target.timetodie() < 20 assassinationuseitemactions()
      #use_item,name=ashvanes_razor_coral,if=(!talent.exsanguinate.enabled|!talent.subterfuge.enabled)&debuff.vendetta.remains>10-4*equipped.azsharas_font_of_power
      if { not hastalent(exsanguinate_talent) or not hastalent(subterfuge_talent) } and target.debuffremaining(vendetta) > 10 - 4 * hasequippeditem(azsharas_font_of_power_item) assassinationuseitemactions()
      #use_item,name=ashvanes_razor_coral,if=(talent.exsanguinate.enabled&talent.subterfuge.enabled)&debuff.vendetta.up&(exsanguinated.garrote|azerite.shrouded_suffocation.enabled&dot.garrote.pmultiplier>1)
      if hastalent(exsanguinate_talent) and hastalent(subterfuge_talent) and target.debuffpresent(vendetta) and { message("exsanguinated.garrote is not implemented") or hasazeritetrait(shrouded_suffocation_trait) and target.debuffpersistentmultiplier(garrote) > 1 } assassinationuseitemactions()
      #use_item,effect_name=cyclotronic_blast,if=master_assassin_remains=0&!debuff.vendetta.up&!debuff.shiv.up&buff.memory_of_lucid_dreams.down&energy<80&dot.rupture.remains>4
      if buffremaining(master_assassin_buff) == 0 and not target.debuffpresent(vendetta) and not target.debuffpresent(shiv) and buffexpires(memory_of_lucid_dreams) and energy() < 80 and target.debuffremaining(rupture) > 4 assassinationuseitemactions()
      #use_item,name=lurkers_insidious_gift,if=debuff.vendetta.up
      if target.debuffpresent(vendetta) assassinationuseitemactions()
      #use_item,name=lustrous_golden_plumage,if=debuff.vendetta.up
      if target.debuffpresent(vendetta) assassinationuseitemactions()
      #use_item,effect_name=gladiators_medallion,if=debuff.vendetta.up
      if target.debuffpresent(vendetta) assassinationuseitemactions()
      #use_item,effect_name=gladiators_badge,if=debuff.vendetta.up
      if target.debuffpresent(vendetta) assassinationuseitemactions()
      #use_items
      assassinationuseitemactions()
     }
    }
   }
  }
 }
}

AddFunction assassinationcdscdpostconditions
{
 spell(flagellation) or { target.debuffremaining(flagellation) < 2 or target.debuffstacks(flagellation) >= 40 } and spell(flagellation_cleanse) or not stealthed() and target.debuffpresent(rupture) and buffremaining(master_assassin_buff) == 0 and assassinationessencescdpostconditions() or false(raid_event_adds_exists) and { target.timetodie() < combopointsdeficit() * 1.5 or combopointsdeficit() >= maxcombopoints() } and spell(marked_for_death) or 600 > 30 - 10 and combopointsdeficit() >= maxcombopoints() and spell(marked_for_death) or not { hastalent(subterfuge_talent) and not stealthed() and not spellcooldown(garrote) > 0 and { ss_vanish_condition() or not hasazeritetrait(shrouded_suffocation_trait) and { target.debuffrefreshable(garrote) or target.debuffpresent(vendetta) and target.debuffpersistentmultiplier(garrote) <= 1 } } and combopointsdeficit() >= { 1 + 2 * hasazeritetrait(shrouded_suffocation_trait) } * enemies() >? 4 and 600 > 12 and checkboxon(opt_vanish) and spellusable(vanish) and spellcooldown(vanish) < timetoenergy(45) } and { not stealthed() and { not target.debuffrefreshable(garrote) and target.debuffremaining(rupture) > 4 + 4 * maxcombopoints() or target.debuffremaining(rupture) * 0.5 > target.timetodie() } and target.timetodie() > 4 and spell(exsanguinate) or level() >= 58 and target.debuffpresent(rupture) and { not hasequippeditem(azsharas_font_of_power_item) or spellcooldown(vendetta) > 10 } and spell(shiv) or target.debuffpresent(vendetta) and spell(berserking) }
}

### actions.default

AddFunction assassination_defaultmainactions
{
 #stealth
 spell(stealth)
 #variable,name=energy_regen_combined,value=energy.regen+poisoned_bleeds*7%(2*spell_haste)
 #variable,name=single_target,value=spell_targets.fan_of_knives<2
 #call_action_list,name=stealthed,if=stealthed.rogue
 if stealthed() assassinationstealthedmainactions()

 unless stealthed() and assassinationstealthedmainpostconditions()
 {
  #call_action_list,name=cds,if=(!talent.master_assassin.enabled|dot.garrote.ticking)
  if not hastalent(master_assassin_talent) or target.debuffpresent(garrote) assassinationcdsmainactions()

  unless { not hastalent(master_assassin_talent) or target.debuffpresent(garrote) } and assassinationcdsmainpostconditions()
  {
   #call_action_list,name=dot
   assassinationdotmainactions()

   unless assassinationdotmainpostconditions()
   {
    #slice_and_dice,if=spell_targets.fan_of_knives<=(5-runeforge.dashing_scoundrel.equipped)&buff.slice_and_dice.remains<fight_remains&buff.slice_and_dice.remains<(1+combo_points)*1.8
    if enemies() <= 5 - message("runeforge.dashing_scoundrel.equipped is not implemented") and buffremaining(slice_and_dice) < fightremains() and buffremaining(slice_and_dice) < { 1 + combopoints() } * 1.8 spell(slice_and_dice)
    #call_action_list,name=direct
    assassinationdirectmainactions()
   }
  }
 }
}

AddFunction assassination_defaultmainpostconditions
{
 stealthed() and assassinationstealthedmainpostconditions() or { not hastalent(master_assassin_talent) or target.debuffpresent(garrote) } and assassinationcdsmainpostconditions() or assassinationdotmainpostconditions() or assassinationdirectmainpostconditions()
}

AddFunction assassination_defaultshortcdactions
{
 unless spell(stealth)
 {
  #variable,name=energy_regen_combined,value=energy.regen+poisoned_bleeds*7%(2*spell_haste)
  #variable,name=single_target,value=spell_targets.fan_of_knives<2
  #call_action_list,name=stealthed,if=stealthed.rogue
  if stealthed() assassinationstealthedshortcdactions()

  unless stealthed() and assassinationstealthedshortcdpostconditions()
  {
   #call_action_list,name=cds,if=(!talent.master_assassin.enabled|dot.garrote.ticking)
   if not hastalent(master_assassin_talent) or target.debuffpresent(garrote) assassinationcdsshortcdactions()

   unless { not hastalent(master_assassin_talent) or target.debuffpresent(garrote) } and assassinationcdsshortcdpostconditions()
   {
    #call_action_list,name=dot
    assassinationdotshortcdactions()

    unless assassinationdotshortcdpostconditions() or enemies() <= 5 - message("runeforge.dashing_scoundrel.equipped is not implemented") and buffremaining(slice_and_dice) < fightremains() and buffremaining(slice_and_dice) < { 1 + combopoints() } * 1.8 and spell(slice_and_dice)
    {
     #call_action_list,name=direct
     assassinationdirectshortcdactions()

     unless assassinationdirectshortcdpostconditions()
     {
      #bag_of_tricks
      spell(bag_of_tricks)
     }
    }
   }
  }
 }
}

AddFunction assassination_defaultshortcdpostconditions
{
 spell(stealth) or stealthed() and assassinationstealthedshortcdpostconditions() or { not hastalent(master_assassin_talent) or target.debuffpresent(garrote) } and assassinationcdsshortcdpostconditions() or assassinationdotshortcdpostconditions() or enemies() <= 5 - message("runeforge.dashing_scoundrel.equipped is not implemented") and buffremaining(slice_and_dice) < fightremains() and buffremaining(slice_and_dice) < { 1 + combopoints() } * 1.8 and spell(slice_and_dice) or assassinationdirectshortcdpostconditions()
}

AddFunction assassination_defaultcdactions
{
 assassinationinterruptactions()

 unless spell(stealth)
 {
  #variable,name=energy_regen_combined,value=energy.regen+poisoned_bleeds*7%(2*spell_haste)
  #variable,name=single_target,value=spell_targets.fan_of_knives<2
  #call_action_list,name=stealthed,if=stealthed.rogue
  if stealthed() assassinationstealthedcdactions()

  unless stealthed() and assassinationstealthedcdpostconditions()
  {
   #call_action_list,name=cds,if=(!talent.master_assassin.enabled|dot.garrote.ticking)
   if not hastalent(master_assassin_talent) or target.debuffpresent(garrote) assassinationcdscdactions()

   unless { not hastalent(master_assassin_talent) or target.debuffpresent(garrote) } and assassinationcdscdpostconditions()
   {
    #call_action_list,name=dot
    assassinationdotcdactions()

    unless assassinationdotcdpostconditions() or enemies() <= 5 - message("runeforge.dashing_scoundrel.equipped is not implemented") and buffremaining(slice_and_dice) < fightremains() and buffremaining(slice_and_dice) < { 1 + combopoints() } * 1.8 and spell(slice_and_dice)
    {
     #call_action_list,name=direct
     assassinationdirectcdactions()

     unless assassinationdirectcdpostconditions()
     {
      #arcane_torrent,if=energy.deficit>=15+variable.energy_regen_combined
      if energydeficit() >= 15 + energy_regen_combined() spell(arcane_torrent)
      #arcane_pulse
      spell(arcane_pulse)
      #lights_judgment
      spell(lights_judgment)
     }
    }
   }
  }
 }
}

AddFunction assassination_defaultcdpostconditions
{
 spell(stealth) or stealthed() and assassinationstealthedcdpostconditions() or { not hastalent(master_assassin_talent) or target.debuffpresent(garrote) } and assassinationcdscdpostconditions() or assassinationdotcdpostconditions() or enemies() <= 5 - message("runeforge.dashing_scoundrel.equipped is not implemented") and buffremaining(slice_and_dice) < fightremains() and buffremaining(slice_and_dice) < { 1 + combopoints() } * 1.8 and spell(slice_and_dice) or assassinationdirectcdpostconditions() or spell(bag_of_tricks)
}

### Assassination icons.

AddCheckBox(opt_rogue_assassination_aoe l(aoe) default specialization=assassination)

AddIcon checkbox=!opt_rogue_assassination_aoe enemies=1 help=shortcd specialization=assassination
{
 if not incombat() assassinationprecombatshortcdactions()
 assassination_defaultshortcdactions()
}

AddIcon checkbox=opt_rogue_assassination_aoe help=shortcd specialization=assassination
{
 if not incombat() assassinationprecombatshortcdactions()
 assassination_defaultshortcdactions()
}

AddIcon enemies=1 help=main specialization=assassination
{
 if not incombat() assassinationprecombatmainactions()
 assassination_defaultmainactions()
}

AddIcon checkbox=opt_rogue_assassination_aoe help=aoe specialization=assassination
{
 if not incombat() assassinationprecombatmainactions()
 assassination_defaultmainactions()
}

AddIcon checkbox=!opt_rogue_assassination_aoe enemies=1 help=cd specialization=assassination
{
 if not incombat() assassinationprecombatcdactions()
 assassination_defaultcdactions()
}

AddIcon checkbox=opt_rogue_assassination_aoe help=cd specialization=assassination
{
 if not incombat() assassinationprecombatcdactions()
 assassination_defaultcdactions()
}

### Required symbols
# ambush
# ancestral_call
# arcane_pulse
# arcane_torrent
# ashvanes_razor_coral_item
# azsharas_font_of_power_item
# bag_of_tricks
# berserking
# blood_fury
# blood_of_the_enemy
# blood_of_the_enemy_essence_id
# bloodlust
# breath_of_the_dying_essence_id
# cheap_shot
# concentrated_flame
# concentrated_flame_burn_debuff
# crimson_tempest
# deadly_poison_dot_debuff
# deeper_stratagem_talent
# double_dose_trait
# echoing_blades_trait
# echoing_reprimand
# envenom
# exsanguinate
# exsanguinate_talent
# exsanguinated
# fan_of_knives
# fireblood
# flagellation
# flagellation_cleanse
# focused_azerite_beam
# garrote
# garrote_debuff
# guardian_of_azeroth
# hidden_blades
# internal_bleeding_debuff
# internal_bleeding_talent
# kick
# kidney_shot
# lights_judgment
# marked_for_death
# master_assassin_buff
# master_assassin_talent
# memory_of_lucid_dreams
# mutilate
# nightstalker_talent
# purifying_blast
# quaking_palm
# razor_coral
# reaping_flames
# reckless_force_buff
# reckless_force_counter
# ripple_in_space
# rupture
# rupture_debuff
# scent_of_blood_trait
# sepsis
# serrated_bone_spike
# serrated_bone_spike_dot_debuff
# shadowmeld
# shadowstep
# shiv
# shrouded_suffocation_trait
# slice_and_dice
# stealth
# subterfuge
# subterfuge_talent
# the_unbound_force
# trinket_ashvanes_razor_coral_cooldown_buff
# twist_the_knife_trait
# unbridled_fury_item
# vanish
# vendetta
# vision_of_perfection_essence_id
# worldvein_resonance
]]
        OvaleScripts:RegisterScript("ROGUE", "assassination", name, desc, code, "script")
    end
    do
        local name = "sc_t25_rogue_outlaw"
        local desc = "[9.0] Simulationcraft: T25_Rogue_Outlaw"
        local code = [[
# Based on SimulationCraft profile "T25_Rogue_Outlaw".
#	class=rogue
#	spec=outlaw
#	talents=2020022

Include(ovale_common)
Include(ovale_rogue_spells)


AddFunction blade_flurry_sync
{
 enemies() < 2 and 600 > 20 or buffpresent(blade_flurry)
}

AddFunction ambush_condition
{
 combopointsdeficit() >= 2 + 2 * { hastalent(ghostly_strike_talent) and spellcooldown(ghostly_strike) < 1 } + buffpresent(broadside) and energy() > 60 and not buffpresent(skull_and_crossbones) and not buffpresent(keep_your_wits_about_you_buff)
}

AddFunction rtb_reroll
{
 0
}

AddFunction reaping_delay
{
 if azeriteessenceismajor(breath_of_the_dying_essence_id) target.timetodie()
}

AddCheckBox(opt_interrupt l(interrupt) default specialization=outlaw)
AddCheckBox(opt_melee_range l(not_in_melee_range) specialization=outlaw)
AddCheckBox(opt_use_consumables l(opt_use_consumables) default specialization=outlaw)
AddCheckBox(opt_blade_flurry spellname(blade_flurry) default specialization=outlaw)

AddFunction outlawinterruptactions
{
 if checkboxon(opt_interrupt) and not target.isfriend() and target.casting()
 {
  if target.inrange(kick) and target.isinterruptible() spell(kick)
  if target.inrange(cheap_shot) and not target.classification(worldboss) spell(cheap_shot)
  if target.inrange(between_the_eyes) and not target.classification(worldboss) and combopoints() >= 1 spell(between_the_eyes)
  if target.inrange(quaking_palm) and not target.classification(worldboss) spell(quaking_palm)
  if target.inrange(gouge) and not target.classification(worldboss) spell(gouge)
 }
}

AddFunction outlawuseitemactions
{
 item(trinket0slot text=13 usable=1)
 item(trinket1slot text=14 usable=1)
}

AddFunction outlawgetinmeleerange
{
 if checkboxon(opt_melee_range) and not target.inrange(kick)
 {
  spell(shadowstep)
  texture(misc_arrowlup help=l(not_in_melee_range))
 }
}

### actions.stealth

AddFunction outlawstealthmainactions
{
 #cheap_shot,target_if=min:debuff.prey_on_the_weak.remains,if=talent.prey_on_the_weak.enabled&!target.is_boss
 if hastalent(prey_on_the_weak_talent) and not target.classification(worldboss) spell(cheap_shot)
 #ambush
 spell(ambush)
}

AddFunction outlawstealthmainpostconditions
{
}

AddFunction outlawstealthshortcdactions
{
}

AddFunction outlawstealthshortcdpostconditions
{
 hastalent(prey_on_the_weak_talent) and not target.classification(worldboss) and spell(cheap_shot) or spell(ambush)
}

AddFunction outlawstealthcdactions
{
}

AddFunction outlawstealthcdpostconditions
{
 hastalent(prey_on_the_weak_talent) and not target.classification(worldboss) and spell(cheap_shot) or spell(ambush)
}

### actions.precombat

AddFunction outlawprecombatmainactions
{
 #stealth,if=(!equipped.pocketsized_computation_device|!cooldown.cyclotronic_blast.duration|raid_event.invulnerable.exists)
 if not hasequippeditem(pocketsized_computation_device_item) or not spellcooldownduration(cyclotronic_blast) or message("raid_event.invulnerable.exists is not implemented") spell(stealth)
 #slice_and_dice,precombat_seconds=2
 spell(slice_and_dice)
}

AddFunction outlawprecombatmainpostconditions
{
}

AddFunction outlawprecombatshortcdactions
{
 #apply_poison
 #flask
 #augmentation
 #food
 #snapshot_stats
 #marked_for_death,precombat_seconds=5,if=raid_event.adds.in>40
 if 600 > 40 spell(marked_for_death)

 unless { not hasequippeditem(pocketsized_computation_device_item) or not spellcooldownduration(cyclotronic_blast) or message("raid_event.invulnerable.exists is not implemented") } and spell(stealth)
 {
  #roll_the_bones,precombat_seconds=1
  spell(roll_the_bones)
 }
}

AddFunction outlawprecombatshortcdpostconditions
{
 { not hasequippeditem(pocketsized_computation_device_item) or not spellcooldownduration(cyclotronic_blast) or message("raid_event.invulnerable.exists is not implemented") } and spell(stealth) or spell(slice_and_dice)
}

AddFunction outlawprecombatcdactions
{
 unless 600 > 40 and spell(marked_for_death) or { not hasequippeditem(pocketsized_computation_device_item) or not spellcooldownduration(cyclotronic_blast) or message("raid_event.invulnerable.exists is not implemented") } and spell(stealth) or spell(roll_the_bones) or spell(slice_and_dice)
 {
  #use_item,name=azsharas_font_of_power
  outlawuseitemactions()
  #use_item,effect_name=cyclotronic_blast,if=!raid_event.invulnerable.exists
  if not message("raid_event.invulnerable.exists is not implemented") outlawuseitemactions()
 }
}

AddFunction outlawprecombatcdpostconditions
{
 600 > 40 and spell(marked_for_death) or { not hasequippeditem(pocketsized_computation_device_item) or not spellcooldownduration(cyclotronic_blast) or message("raid_event.invulnerable.exists is not implemented") } and spell(stealth) or spell(roll_the_bones) or spell(slice_and_dice)
}

### actions.finish

AddFunction outlawfinishmainactions
{
 #slice_and_dice,if=buff.slice_and_dice.remains<fight_remains&buff.slice_and_dice.remains<(1+combo_points)*1.8
 if buffremaining(slice_and_dice) < fightremains() and buffremaining(slice_and_dice) < { 1 + combopoints() } * 1.8 spell(slice_and_dice)
 #dispatch
 spell(dispatch)
}

AddFunction outlawfinishmainpostconditions
{
}

AddFunction outlawfinishshortcdactions
{
 #between_the_eyes
 spell(between_the_eyes)
}

AddFunction outlawfinishshortcdpostconditions
{
 buffremaining(slice_and_dice) < fightremains() and buffremaining(slice_and_dice) < { 1 + combopoints() } * 1.8 and spell(slice_and_dice) or spell(dispatch)
}

AddFunction outlawfinishcdactions
{
}

AddFunction outlawfinishcdpostconditions
{
 spell(between_the_eyes) or buffremaining(slice_and_dice) < fightremains() and buffremaining(slice_and_dice) < { 1 + combopoints() } * 1.8 and spell(slice_and_dice) or spell(dispatch)
}

### actions.essences

AddFunction outlawessencesmainactions
{
 #concentrated_flame,if=energy.time_to_max>1&!buff.blade_flurry.up&(!dot.concentrated_flame_burn.ticking&!action.concentrated_flame.in_flight|full_recharge_time<gcd.max)
 if timetomaxenergy() > 1 and not buffpresent(blade_flurry) and { not target.debuffpresent(concentrated_flame_burn_debuff) and not inflighttotarget(concentrated_flame) or spellfullrecharge(concentrated_flame) < gcd() } spell(concentrated_flame)
 #blood_of_the_enemy,if=variable.blade_flurry_sync&cooldown.between_the_eyes.up&(spell_targets.blade_flurry>=2|raid_event.adds.in>45)
 if blade_flurry_sync() and not spellcooldown(between_the_eyes) > 0 and { enemies() >= 2 or 600 > 45 } spell(blood_of_the_enemy)
 #the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<10
 if buffpresent(reckless_force_buff) or buffstacks(reckless_force_counter) < 10 spell(the_unbound_force)
 #ripple_in_space
 spell(ripple_in_space)
 #worldvein_resonance
 spell(worldvein_resonance)
 #memory_of_lucid_dreams,if=energy<45
 if energy() < 45 spell(memory_of_lucid_dreams)
}

AddFunction outlawessencesmainpostconditions
{
}

AddFunction outlawessencesshortcdactions
{
 unless timetomaxenergy() > 1 and not buffpresent(blade_flurry) and { not target.debuffpresent(concentrated_flame_burn_debuff) and not inflighttotarget(concentrated_flame) or spellfullrecharge(concentrated_flame) < gcd() } and spell(concentrated_flame) or blade_flurry_sync() and not spellcooldown(between_the_eyes) > 0 and { enemies() >= 2 or 600 > 45 } and spell(blood_of_the_enemy)
 {
  #focused_azerite_beam,if=spell_targets.blade_flurry>=2|raid_event.adds.in>60&!buff.adrenaline_rush.up
  if enemies() >= 2 or 600 > 60 and not buffpresent(adrenaline_rush) spell(focused_azerite_beam)
  #purifying_blast,if=spell_targets.blade_flurry>=2|raid_event.adds.in>60
  if enemies() >= 2 or 600 > 60 spell(purifying_blast)

  unless { buffpresent(reckless_force_buff) or buffstacks(reckless_force_counter) < 10 } and spell(the_unbound_force) or spell(ripple_in_space) or spell(worldvein_resonance) or energy() < 45 and spell(memory_of_lucid_dreams)
  {
   #cycling_variable,name=reaping_delay,op=min,if=essence.breath_of_the_dying.major,value=target.time_to_die
   #reaping_flames,target_if=target.time_to_die<1.5|((target.health.pct>80|target.health.pct<=20)&(active_enemies=1|variable.reaping_delay>29))|(target.time_to_pct_20>30&(active_enemies=1|variable.reaping_delay>44))
   if target.timetodie() < 1.5 or { target.healthpercent() > 80 or target.healthpercent() <= 20 } and { enemies() == 1 or reaping_delay() > 29 } or target.timetohealthpercent(20) > 30 and { enemies() == 1 or reaping_delay() > 44 } spell(reaping_flames)
  }
 }
}

AddFunction outlawessencesshortcdpostconditions
{
 timetomaxenergy() > 1 and not buffpresent(blade_flurry) and { not target.debuffpresent(concentrated_flame_burn_debuff) and not inflighttotarget(concentrated_flame) or spellfullrecharge(concentrated_flame) < gcd() } and spell(concentrated_flame) or blade_flurry_sync() and not spellcooldown(between_the_eyes) > 0 and { enemies() >= 2 or 600 > 45 } and spell(blood_of_the_enemy) or { buffpresent(reckless_force_buff) or buffstacks(reckless_force_counter) < 10 } and spell(the_unbound_force) or spell(ripple_in_space) or spell(worldvein_resonance) or energy() < 45 and spell(memory_of_lucid_dreams)
}

AddFunction outlawessencescdactions
{
 unless timetomaxenergy() > 1 and not buffpresent(blade_flurry) and { not target.debuffpresent(concentrated_flame_burn_debuff) and not inflighttotarget(concentrated_flame) or spellfullrecharge(concentrated_flame) < gcd() } and spell(concentrated_flame) or blade_flurry_sync() and not spellcooldown(between_the_eyes) > 0 and { enemies() >= 2 or 600 > 45 } and spell(blood_of_the_enemy)
 {
  #guardian_of_azeroth
  spell(guardian_of_azeroth)
 }
}

AddFunction outlawessencescdpostconditions
{
 timetomaxenergy() > 1 and not buffpresent(blade_flurry) and { not target.debuffpresent(concentrated_flame_burn_debuff) and not inflighttotarget(concentrated_flame) or spellfullrecharge(concentrated_flame) < gcd() } and spell(concentrated_flame) or blade_flurry_sync() and not spellcooldown(between_the_eyes) > 0 and { enemies() >= 2 or 600 > 45 } and spell(blood_of_the_enemy) or { enemies() >= 2 or 600 > 60 and not buffpresent(adrenaline_rush) } and spell(focused_azerite_beam) or { enemies() >= 2 or 600 > 60 } and spell(purifying_blast) or { buffpresent(reckless_force_buff) or buffstacks(reckless_force_counter) < 10 } and spell(the_unbound_force) or spell(ripple_in_space) or spell(worldvein_resonance) or energy() < 45 and spell(memory_of_lucid_dreams) or { target.timetodie() < 1.5 or { target.healthpercent() > 80 or target.healthpercent() <= 20 } and { enemies() == 1 or reaping_delay() > 29 } or target.timetohealthpercent(20) > 30 and { enemies() == 1 or reaping_delay() > 44 } } and spell(reaping_flames)
}

### actions.cds

AddFunction outlawcdsmainactions
{
 #call_action_list,name=essences,if=!stealthed.all
 if not stealthed() outlawessencesmainactions()

 unless not stealthed() and outlawessencesmainpostconditions()
 {
  #flagellation_cleanse,if=debuff.flagellation.remains<2|debuff.flagellation.stack>=40
  if target.debuffremaining(flagellation) < 2 or target.debuffstacks(flagellation) >= 40 spell(flagellation_cleanse)
  #sepsis,if=!stealthed.all
  if not stealthed() spell(sepsis)
  #berserking
  spell(berserking)
 }
}

AddFunction outlawcdsmainpostconditions
{
 not stealthed() and outlawessencesmainpostconditions()
}

AddFunction outlawcdsshortcdactions
{
 #call_action_list,name=essences,if=!stealthed.all
 if not stealthed() outlawessencesshortcdactions()

 unless not stealthed() and outlawessencesshortcdpostconditions()
 {
  #flagellation
  spell(flagellation)

  unless { target.debuffremaining(flagellation) < 2 or target.debuffstacks(flagellation) >= 40 } and spell(flagellation_cleanse)
  {
   #roll_the_bones,if=buff.roll_the_bones.remains<=3|variable.rtb_reroll
   if buffremaining(roll_the_bones_buff) <= 3 or rtb_reroll() spell(roll_the_bones)
   #marked_for_death,target_if=min:target.time_to_die,if=raid_event.adds.up&(target.time_to_die<combo_points.deficit|!stealthed.rogue&combo_points.deficit>=cp_max_spend-1)
   if false(raid_event_adds_exists) and { target.timetodie() < combopointsdeficit() or not stealthed() and combopointsdeficit() >= maxcombopoints() - 1 } spell(marked_for_death)
   #marked_for_death,if=raid_event.adds.in>30-raid_event.adds.duration&!stealthed.rogue&combo_points.deficit>=cp_max_spend-1
   if 600 > 30 - 10 and not stealthed() and combopointsdeficit() >= maxcombopoints() - 1 spell(marked_for_death)
   #blade_flurry,if=spell_targets>=2&!buff.blade_flurry.up&(!raid_event.adds.exists|raid_event.adds.remains>8|raid_event.adds.in>(2-cooldown.blade_flurry.charges_fractional)*25)
   if enemies() >= 2 and not buffpresent(blade_flurry) and { not false(raid_event_adds_exists) or message("raid_event.adds.remains is not implemented") > 8 or 600 > { 2 - spellcharges(blade_flurry count=0) } * 25 } and checkboxon(opt_blade_flurry) spell(blade_flurry)
   #blade_flurry,if=spell_targets=1&raid_event.adds.in>(2-cooldown.blade_flurry.charges_fractional)*25
   if enemies() == 1 and 600 > { 2 - spellcharges(blade_flurry count=0) } * 25 and checkboxon(opt_blade_flurry) spell(blade_flurry)
   #ghostly_strike,if=combo_points.deficit>=1+buff.broadside.up
   if combopointsdeficit() >= 1 + buffpresent(broadside) spell(ghostly_strike)
   #blade_rush,if=variable.blade_flurry_sync&energy.time_to_max>2
   if blade_flurry_sync() and timetomaxenergy() > 2 spell(blade_rush)
   #dreadblades,if=!stealthed.all&combo_points<=1
   if not stealthed() and combopoints() <= 1 spell(dreadblades)
  }
 }
}

AddFunction outlawcdsshortcdpostconditions
{
 not stealthed() and outlawessencesshortcdpostconditions() or { target.debuffremaining(flagellation) < 2 or target.debuffstacks(flagellation) >= 40 } and spell(flagellation_cleanse) or not stealthed() and spell(sepsis) or spell(berserking)
}

AddFunction outlawcdscdactions
{
 #call_action_list,name=essences,if=!stealthed.all
 if not stealthed() outlawessencescdactions()

 unless not stealthed() and outlawessencescdpostconditions() or spell(flagellation) or { target.debuffremaining(flagellation) < 2 or target.debuffstacks(flagellation) >= 40 } and spell(flagellation_cleanse)
 {
  #adrenaline_rush,if=!buff.adrenaline_rush.up&(!equipped.azsharas_font_of_power|cooldown.latent_arcana.remains>20)
  if not buffpresent(adrenaline_rush) and { not hasequippeditem(azsharas_font_of_power_item) or spellcooldown(latent_arcana) > 20 } and energydeficit() > 1 spell(adrenaline_rush)

  unless { buffremaining(roll_the_bones_buff) <= 3 or rtb_reroll() } and spell(roll_the_bones) or false(raid_event_adds_exists) and { target.timetodie() < combopointsdeficit() or not stealthed() and combopointsdeficit() >= maxcombopoints() - 1 } and spell(marked_for_death) or 600 > 30 - 10 and not stealthed() and combopointsdeficit() >= maxcombopoints() - 1 and spell(marked_for_death) or enemies() >= 2 and not buffpresent(blade_flurry) and { not false(raid_event_adds_exists) or message("raid_event.adds.remains is not implemented") > 8 or 600 > { 2 - spellcharges(blade_flurry count=0) } * 25 } and checkboxon(opt_blade_flurry) and spell(blade_flurry) or enemies() == 1 and 600 > { 2 - spellcharges(blade_flurry count=0) } * 25 and checkboxon(opt_blade_flurry) and spell(blade_flurry) or combopointsdeficit() >= 1 + buffpresent(broadside) and spell(ghostly_strike)
  {
   #killing_spree,if=variable.blade_flurry_sync&energy.time_to_max>2
   if blade_flurry_sync() and timetomaxenergy() > 2 spell(killing_spree)

   unless blade_flurry_sync() and timetomaxenergy() > 2 and spell(blade_rush)
   {
    #vanish,if=!stealthed.all&variable.ambush_condition
    if not stealthed() and ambush_condition() spell(vanish)

    unless not stealthed() and combopoints() <= 1 and spell(dreadblades)
    {
     #shadowmeld,if=!stealthed.all&variable.ambush_condition
     if not stealthed() and ambush_condition() spell(shadowmeld)

     unless not stealthed() and spell(sepsis)
     {
      #potion,if=buff.bloodlust.react|buff.adrenaline_rush.up
      if { buffpresent(bloodlust) or buffpresent(adrenaline_rush) } and checkboxon(opt_use_consumables) and target.classification(worldboss) item(unbridled_fury_item usable=1)
      #blood_fury
      spell(blood_fury)

      unless spell(berserking)
      {
       #fireblood
       spell(fireblood)
       #ancestral_call
       spell(ancestral_call)
       #use_item,effect_name=cyclotronic_blast,if=!stealthed.all&buff.adrenaline_rush.down&buff.memory_of_lucid_dreams.down&energy.time_to_max>4&rtb_buffs<5
       if not stealthed() and buffexpires(adrenaline_rush) and buffexpires(memory_of_lucid_dreams) and timetomaxenergy() > 4 and buffcount(roll_the_bones_buff) < 5 outlawuseitemactions()
       #use_item,name=azsharas_font_of_power,if=!buff.adrenaline_rush.up&!buff.blade_flurry.up&cooldown.adrenaline_rush.remains<15
       if not buffpresent(adrenaline_rush) and not buffpresent(blade_flurry) and spellcooldown(adrenaline_rush) < 15 outlawuseitemactions()
       #use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|debuff.conductive_ink_debuff.up&target.health.pct<32&target.health.pct>=30|!debuff.conductive_ink_debuff.up&(debuff.razor_coral_debuff.stack>=20-10*debuff.blood_of_the_enemy.up|target.time_to_die<60)&buff.adrenaline_rush.remains>18
       if target.debuffexpires(razor_coral) or target.debuffpresent(conductive_ink_debuff) and target.healthpercent() < 32 and target.healthpercent() >= 30 or not target.debuffpresent(conductive_ink_debuff) and { target.debuffstacks(razor_coral) >= 20 - 10 * target.debuffpresent(blood_of_the_enemy) or target.timetodie() < 60 } and buffremaining(adrenaline_rush) > 18 outlawuseitemactions()
       #use_items,if=buff.bloodlust.react|fight_remains<=20|combo_points.deficit<=2
       if buffpresent(bloodlust) or fightremains() <= 20 or combopointsdeficit() <= 2 outlawuseitemactions()
      }
     }
    }
   }
  }
 }
}

AddFunction outlawcdscdpostconditions
{
 not stealthed() and outlawessencescdpostconditions() or spell(flagellation) or { target.debuffremaining(flagellation) < 2 or target.debuffstacks(flagellation) >= 40 } and spell(flagellation_cleanse) or { buffremaining(roll_the_bones_buff) <= 3 or rtb_reroll() } and spell(roll_the_bones) or false(raid_event_adds_exists) and { target.timetodie() < combopointsdeficit() or not stealthed() and combopointsdeficit() >= maxcombopoints() - 1 } and spell(marked_for_death) or 600 > 30 - 10 and not stealthed() and combopointsdeficit() >= maxcombopoints() - 1 and spell(marked_for_death) or enemies() >= 2 and not buffpresent(blade_flurry) and { not false(raid_event_adds_exists) or message("raid_event.adds.remains is not implemented") > 8 or 600 > { 2 - spellcharges(blade_flurry count=0) } * 25 } and checkboxon(opt_blade_flurry) and spell(blade_flurry) or enemies() == 1 and 600 > { 2 - spellcharges(blade_flurry count=0) } * 25 and checkboxon(opt_blade_flurry) and spell(blade_flurry) or combopointsdeficit() >= 1 + buffpresent(broadside) and spell(ghostly_strike) or blade_flurry_sync() and timetomaxenergy() > 2 and spell(blade_rush) or not stealthed() and combopoints() <= 1 and spell(dreadblades) or not stealthed() and spell(sepsis) or spell(berserking)
}

### actions.build

AddFunction outlawbuildmainactions
{
 #serrated_bone_spike,cycle_targets=1,if=buff.slice_and_dice.up&!dot.serrated_bone_spike_dot.ticking|fight_remains<=5|cooldown.serrated_bone_spike.charges_fractional>=2.75
 if buffpresent(slice_and_dice) and not target.debuffpresent(serrated_bone_spike_dot_debuff) or fightremains() <= 5 or spellcharges(serrated_bone_spike count=0) >= 2.75 spell(serrated_bone_spike)
 #pistol_shot,if=(talent.quick_draw.enabled|azerite.keep_your_wits_about_you.rank<2)&buff.opportunity.up&(buff.keep_your_wits_about_you.stack<14|energy<45)
 if { hastalent(quick_draw_talent) or azeritetraitrank(keep_your_wits_about_you_trait) < 2 } and buffpresent(opportunity) and { buffstacks(keep_your_wits_about_you_buff) < 14 or energy() < 45 } spell(pistol_shot)
 #pistol_shot,if=buff.opportunity.up&(buff.deadshot.up|buff.greenskins_wickers.up|buff.concealed_blunderbuss.up)
 if buffpresent(opportunity) and { buffpresent(deadshot_buff) or buffpresent(greenskins_wickers) or buffpresent(concealed_blunderbuss) } spell(pistol_shot)
 #sinister_strike
 spell(sinister_strike)
}

AddFunction outlawbuildmainpostconditions
{
}

AddFunction outlawbuildshortcdactions
{
 #echoing_reprimand
 spell(echoing_reprimand)
}

AddFunction outlawbuildshortcdpostconditions
{
 { buffpresent(slice_and_dice) and not target.debuffpresent(serrated_bone_spike_dot_debuff) or fightremains() <= 5 or spellcharges(serrated_bone_spike count=0) >= 2.75 } and spell(serrated_bone_spike) or { hastalent(quick_draw_talent) or azeritetraitrank(keep_your_wits_about_you_trait) < 2 } and buffpresent(opportunity) and { buffstacks(keep_your_wits_about_you_buff) < 14 or energy() < 45 } and spell(pistol_shot) or buffpresent(opportunity) and { buffpresent(deadshot_buff) or buffpresent(greenskins_wickers) or buffpresent(concealed_blunderbuss) } and spell(pistol_shot) or spell(sinister_strike)
}

AddFunction outlawbuildcdactions
{
}

AddFunction outlawbuildcdpostconditions
{
 spell(echoing_reprimand) or { buffpresent(slice_and_dice) and not target.debuffpresent(serrated_bone_spike_dot_debuff) or fightremains() <= 5 or spellcharges(serrated_bone_spike count=0) >= 2.75 } and spell(serrated_bone_spike) or { hastalent(quick_draw_talent) or azeritetraitrank(keep_your_wits_about_you_trait) < 2 } and buffpresent(opportunity) and { buffstacks(keep_your_wits_about_you_buff) < 14 or energy() < 45 } and spell(pistol_shot) or buffpresent(opportunity) and { buffpresent(deadshot_buff) or buffpresent(greenskins_wickers) or buffpresent(concealed_blunderbuss) } and spell(pistol_shot) or spell(sinister_strike)
}

### actions.default

AddFunction outlaw_defaultmainactions
{
 #stealth
 spell(stealth)
 #variable,name=rtb_reroll,value=0
 #variable,name=ambush_condition,value=combo_points.deficit>=2+2*(talent.ghostly_strike.enabled&cooldown.ghostly_strike.remains<1)+buff.broadside.up&energy>60&!buff.skull_and_crossbones.up&!buff.keep_your_wits_about_you.up
 #variable,name=blade_flurry_sync,value=spell_targets.blade_flurry<2&raid_event.adds.in>20|buff.blade_flurry.up
 #call_action_list,name=stealth,if=stealthed.all
 if stealthed() outlawstealthmainactions()

 unless stealthed() and outlawstealthmainpostconditions()
 {
  #call_action_list,name=cds
  outlawcdsmainactions()

  unless outlawcdsmainpostconditions()
  {
   #run_action_list,name=finish,if=combo_points>=cp_max_spend-(buff.broadside.up+buff.opportunity.up)*(talent.quick_draw.enabled&(!talent.marked_for_death.enabled|cooldown.marked_for_death.remains>1))*(azerite.ace_up_your_sleeve.rank<2|!cooldown.between_the_eyes.up)|combo_points=animacharged_cp
   if combopoints() >= maxcombopoints() - { buffpresent(broadside) + buffpresent(opportunity) } * { hastalent(quick_draw_talent) and { not hastalent(marked_for_death_talent) or spellcooldown(marked_for_death) > 1 } } * { azeritetraitrank(ace_up_your_sleeve_trait) < 2 or not { not spellcooldown(between_the_eyes) > 0 } } or combopoints() == message("animacharged_cp is not implemented") outlawfinishmainactions()

   unless { combopoints() >= maxcombopoints() - { buffpresent(broadside) + buffpresent(opportunity) } * { hastalent(quick_draw_talent) and { not hastalent(marked_for_death_talent) or spellcooldown(marked_for_death) > 1 } } * { azeritetraitrank(ace_up_your_sleeve_trait) < 2 or not { not spellcooldown(between_the_eyes) > 0 } } or combopoints() == message("animacharged_cp is not implemented") } and outlawfinishmainpostconditions()
   {
    #call_action_list,name=build
    outlawbuildmainactions()
   }
  }
 }
}

AddFunction outlaw_defaultmainpostconditions
{
 stealthed() and outlawstealthmainpostconditions() or outlawcdsmainpostconditions() or { combopoints() >= maxcombopoints() - { buffpresent(broadside) + buffpresent(opportunity) } * { hastalent(quick_draw_talent) and { not hastalent(marked_for_death_talent) or spellcooldown(marked_for_death) > 1 } } * { azeritetraitrank(ace_up_your_sleeve_trait) < 2 or not { not spellcooldown(between_the_eyes) > 0 } } or combopoints() == message("animacharged_cp is not implemented") } and outlawfinishmainpostconditions() or outlawbuildmainpostconditions()
}

AddFunction outlaw_defaultshortcdactions
{
 unless spell(stealth)
 {
  #variable,name=rtb_reroll,value=0
  #variable,name=ambush_condition,value=combo_points.deficit>=2+2*(talent.ghostly_strike.enabled&cooldown.ghostly_strike.remains<1)+buff.broadside.up&energy>60&!buff.skull_and_crossbones.up&!buff.keep_your_wits_about_you.up
  #variable,name=blade_flurry_sync,value=spell_targets.blade_flurry<2&raid_event.adds.in>20|buff.blade_flurry.up
  #call_action_list,name=stealth,if=stealthed.all
  if stealthed() outlawstealthshortcdactions()

  unless stealthed() and outlawstealthshortcdpostconditions()
  {
   #call_action_list,name=cds
   outlawcdsshortcdactions()

   unless outlawcdsshortcdpostconditions()
   {
    #run_action_list,name=finish,if=combo_points>=cp_max_spend-(buff.broadside.up+buff.opportunity.up)*(talent.quick_draw.enabled&(!talent.marked_for_death.enabled|cooldown.marked_for_death.remains>1))*(azerite.ace_up_your_sleeve.rank<2|!cooldown.between_the_eyes.up)|combo_points=animacharged_cp
    if combopoints() >= maxcombopoints() - { buffpresent(broadside) + buffpresent(opportunity) } * { hastalent(quick_draw_talent) and { not hastalent(marked_for_death_talent) or spellcooldown(marked_for_death) > 1 } } * { azeritetraitrank(ace_up_your_sleeve_trait) < 2 or not { not spellcooldown(between_the_eyes) > 0 } } or combopoints() == message("animacharged_cp is not implemented") outlawfinishshortcdactions()

    unless { combopoints() >= maxcombopoints() - { buffpresent(broadside) + buffpresent(opportunity) } * { hastalent(quick_draw_talent) and { not hastalent(marked_for_death_talent) or spellcooldown(marked_for_death) > 1 } } * { azeritetraitrank(ace_up_your_sleeve_trait) < 2 or not { not spellcooldown(between_the_eyes) > 0 } } or combopoints() == message("animacharged_cp is not implemented") } and outlawfinishshortcdpostconditions()
    {
     #call_action_list,name=build
     outlawbuildshortcdactions()

     unless outlawbuildshortcdpostconditions()
     {
      #bag_of_tricks
      spell(bag_of_tricks)
     }
    }
   }
  }
 }
}

AddFunction outlaw_defaultshortcdpostconditions
{
 spell(stealth) or stealthed() and outlawstealthshortcdpostconditions() or outlawcdsshortcdpostconditions() or { combopoints() >= maxcombopoints() - { buffpresent(broadside) + buffpresent(opportunity) } * { hastalent(quick_draw_talent) and { not hastalent(marked_for_death_talent) or spellcooldown(marked_for_death) > 1 } } * { azeritetraitrank(ace_up_your_sleeve_trait) < 2 or not { not spellcooldown(between_the_eyes) > 0 } } or combopoints() == message("animacharged_cp is not implemented") } and outlawfinishshortcdpostconditions() or outlawbuildshortcdpostconditions()
}

AddFunction outlaw_defaultcdactions
{
 outlawinterruptactions()

 unless spell(stealth)
 {
  #variable,name=rtb_reroll,value=0
  #variable,name=ambush_condition,value=combo_points.deficit>=2+2*(talent.ghostly_strike.enabled&cooldown.ghostly_strike.remains<1)+buff.broadside.up&energy>60&!buff.skull_and_crossbones.up&!buff.keep_your_wits_about_you.up
  #variable,name=blade_flurry_sync,value=spell_targets.blade_flurry<2&raid_event.adds.in>20|buff.blade_flurry.up
  #call_action_list,name=stealth,if=stealthed.all
  if stealthed() outlawstealthcdactions()

  unless stealthed() and outlawstealthcdpostconditions()
  {
   #call_action_list,name=cds
   outlawcdscdactions()

   unless outlawcdscdpostconditions()
   {
    #run_action_list,name=finish,if=combo_points>=cp_max_spend-(buff.broadside.up+buff.opportunity.up)*(talent.quick_draw.enabled&(!talent.marked_for_death.enabled|cooldown.marked_for_death.remains>1))*(azerite.ace_up_your_sleeve.rank<2|!cooldown.between_the_eyes.up)|combo_points=animacharged_cp
    if combopoints() >= maxcombopoints() - { buffpresent(broadside) + buffpresent(opportunity) } * { hastalent(quick_draw_talent) and { not hastalent(marked_for_death_talent) or spellcooldown(marked_for_death) > 1 } } * { azeritetraitrank(ace_up_your_sleeve_trait) < 2 or not { not spellcooldown(between_the_eyes) > 0 } } or combopoints() == message("animacharged_cp is not implemented") outlawfinishcdactions()

    unless { combopoints() >= maxcombopoints() - { buffpresent(broadside) + buffpresent(opportunity) } * { hastalent(quick_draw_talent) and { not hastalent(marked_for_death_talent) or spellcooldown(marked_for_death) > 1 } } * { azeritetraitrank(ace_up_your_sleeve_trait) < 2 or not { not spellcooldown(between_the_eyes) > 0 } } or combopoints() == message("animacharged_cp is not implemented") } and outlawfinishcdpostconditions()
    {
     #call_action_list,name=build
     outlawbuildcdactions()

     unless outlawbuildcdpostconditions()
     {
      #arcane_torrent,if=energy.deficit>=15+energy.regen
      if energydeficit() >= 15 + energyregenrate() spell(arcane_torrent)
      #arcane_pulse
      spell(arcane_pulse)
      #lights_judgment
      spell(lights_judgment)
     }
    }
   }
  }
 }
}

AddFunction outlaw_defaultcdpostconditions
{
 spell(stealth) or stealthed() and outlawstealthcdpostconditions() or outlawcdscdpostconditions() or { combopoints() >= maxcombopoints() - { buffpresent(broadside) + buffpresent(opportunity) } * { hastalent(quick_draw_talent) and { not hastalent(marked_for_death_talent) or spellcooldown(marked_for_death) > 1 } } * { azeritetraitrank(ace_up_your_sleeve_trait) < 2 or not { not spellcooldown(between_the_eyes) > 0 } } or combopoints() == message("animacharged_cp is not implemented") } and outlawfinishcdpostconditions() or outlawbuildcdpostconditions() or spell(bag_of_tricks)
}

### Outlaw icons.

AddCheckBox(opt_rogue_outlaw_aoe l(aoe) default specialization=outlaw)

AddIcon checkbox=!opt_rogue_outlaw_aoe enemies=1 help=shortcd specialization=outlaw
{
 if not incombat() outlawprecombatshortcdactions()
 outlaw_defaultshortcdactions()
}

AddIcon checkbox=opt_rogue_outlaw_aoe help=shortcd specialization=outlaw
{
 if not incombat() outlawprecombatshortcdactions()
 outlaw_defaultshortcdactions()
}

AddIcon enemies=1 help=main specialization=outlaw
{
 if not incombat() outlawprecombatmainactions()
 outlaw_defaultmainactions()
}

AddIcon checkbox=opt_rogue_outlaw_aoe help=aoe specialization=outlaw
{
 if not incombat() outlawprecombatmainactions()
 outlaw_defaultmainactions()
}

AddIcon checkbox=!opt_rogue_outlaw_aoe enemies=1 help=cd specialization=outlaw
{
 if not incombat() outlawprecombatcdactions()
 outlaw_defaultcdactions()
}

AddIcon checkbox=opt_rogue_outlaw_aoe help=cd specialization=outlaw
{
 if not incombat() outlawprecombatcdactions()
 outlaw_defaultcdactions()
}

### Required symbols
# ace_up_your_sleeve_trait
# adrenaline_rush
# ambush
# ancestral_call
# arcane_pulse
# arcane_torrent
# azsharas_font_of_power_item
# bag_of_tricks
# berserking
# between_the_eyes
# blade_flurry
# blade_rush
# blood_fury
# blood_of_the_enemy
# bloodlust
# breath_of_the_dying_essence_id
# broadside
# cheap_shot
# concealed_blunderbuss
# concentrated_flame
# concentrated_flame_burn_debuff
# conductive_ink_debuff
# cyclotronic_blast
# deadshot_buff
# dispatch
# dreadblades
# echoing_reprimand
# fireblood
# flagellation
# flagellation_cleanse
# focused_azerite_beam
# ghostly_strike
# ghostly_strike_talent
# gouge
# greenskins_wickers
# guardian_of_azeroth
# keep_your_wits_about_you_buff
# keep_your_wits_about_you_trait
# kick
# killing_spree
# latent_arcana
# lights_judgment
# marked_for_death
# marked_for_death_talent
# memory_of_lucid_dreams
# opportunity
# pistol_shot
# pocketsized_computation_device_item
# prey_on_the_weak_talent
# purifying_blast
# quaking_palm
# quick_draw_talent
# razor_coral
# reaping_flames
# reckless_force_buff
# reckless_force_counter
# ripple_in_space
# roll_the_bones
# roll_the_bones_buff
# sepsis
# serrated_bone_spike
# serrated_bone_spike_dot_debuff
# shadowmeld
# shadowstep
# sinister_strike
# skull_and_crossbones
# slice_and_dice
# stealth
# the_unbound_force
# unbridled_fury_item
# vanish
# worldvein_resonance
]]
        OvaleScripts:RegisterScript("ROGUE", "outlaw", name, desc, code, "script")
    end
    do
        local name = "sc_t25_rogue_subtlety"
        local desc = "[9.0] Simulationcraft: T25_Rogue_Subtlety"
        local code = [[
# Based on SimulationCraft profile "T25_Rogue_Subtlety".
#	class=rogue
#	spec=subtlety
#	talents=1120031

Include(ovale_common)
Include(ovale_rogue_spells)


AddFunction stealth_threshold
{
 25 + talentpoints(vigor_talent) * 20 + talentpoints(master_of_shadows_talent) * 20 + talentpoints(shadow_focus_talent) * 25 + talentpoints(alacrity_talent) * 20 + 25 * { enemies() >= 4 }
}

AddFunction use_priority_rotation
{
 checkboxon(opt_priority_rotation) and enemies() >= 2
}

AddFunction snd_condition
{
 buffpresent(slice_and_dice) or enemies() >= 6
}

AddFunction reaping_delay
{
 if azeriteessenceismajor(breath_of_the_dying_essence_id) target.timetodie()
}

AddFunction skip_rupture
{
 buffremaining(master_assassin_buff) > 0 or not hastalent(nightstalker_talent) and hastalent(dark_shadow_talent) and buffpresent(shadow_dance) or enemies() >= 6
}

AddFunction shd_combo_points
{
 if use_priority_rotation() combopointsdeficit() <= 1
 combopointsdeficit() >= 4
}

AddFunction shd_threshold
{
 spellcharges(shadow_dance count=0) >= 1.75
}

AddCheckBox(opt_priority_rotation l(opt_priority_rotation) default specialization=subtlety)
AddCheckBox(opt_interrupt l(interrupt) default specialization=subtlety)
AddCheckBox(opt_melee_range l(not_in_melee_range) specialization=subtlety)
AddCheckBox(opt_use_consumables l(opt_use_consumables) default specialization=subtlety)

AddFunction subtletyinterruptactions
{
 if checkboxon(opt_interrupt) and not target.isfriend() and target.casting()
 {
  if target.inrange(kick) and target.isinterruptible() spell(kick)
  if target.inrange(cheap_shot) and not target.classification(worldboss) spell(cheap_shot)
  if target.inrange(kidney_shot) and not target.classification(worldboss) and combopoints() >= 1 spell(kidney_shot)
  if target.inrange(quaking_palm) and not target.classification(worldboss) spell(quaking_palm)
 }
}

AddFunction subtletyuseitemactions
{
 item(trinket0slot text=13 usable=1)
 item(trinket1slot text=14 usable=1)
}

AddFunction subtletygetinmeleerange
{
 if checkboxon(opt_melee_range) and not target.inrange(kick)
 {
  spell(shadowstep)
  texture(misc_arrowlup help=l(not_in_melee_range))
 }
}

### actions.stealthed

AddFunction subtletystealthedmainactions
{
 #shadowstrike,if=(buff.stealth.up|buff.vanish.up)
 if buffpresent(stealth) or buffpresent(vanish) spell(shadowstrike)
 #call_action_list,name=finish,if=buff.shuriken_tornado.up&combo_points.deficit<=2
 if buffpresent(shuriken_tornado) and combopointsdeficit() <= 2 subtletyfinishmainactions()

 unless buffpresent(shuriken_tornado) and combopointsdeficit() <= 2 and subtletyfinishmainpostconditions()
 {
  #call_action_list,name=finish,if=spell_targets.shuriken_storm=4&combo_points>=4
  if enemies() == 4 and combopoints() >= 4 subtletyfinishmainactions()

  unless enemies() == 4 and combopoints() >= 4 and subtletyfinishmainpostconditions()
  {
   #call_action_list,name=finish,if=combo_points.deficit<=1-(talent.deeper_stratagem.enabled&buff.vanish.up)
   if combopointsdeficit() <= 1 - { hastalent(deeper_stratagem_talent) and buffpresent(vanish) } subtletyfinishmainactions()

   unless combopointsdeficit() <= 1 - { hastalent(deeper_stratagem_talent) and buffpresent(vanish) } and subtletyfinishmainpostconditions()
   {
    #shadowstrike,cycle_targets=1,if=debuff.find_weakness.remains<1&spell_targets.shuriken_storm<=3&target.time_to_die-remains>6
    if target.debuffremaining(find_weakness) < 1 and enemies() <= 3 and target.timetodie() - buffremaining(shadowstrike) > 6 spell(shadowstrike)
    #shadowstrike,if=!talent.deeper_stratagem.enabled&azerite.blade_in_the_shadows.rank=3&spell_targets.shuriken_storm=3
    if not hastalent(deeper_stratagem_talent) and azeritetraitrank(blade_in_the_shadows_trait) == 3 and enemies() == 3 spell(shadowstrike)
    #shadowstrike,if=variable.use_priority_rotation&(debuff.find_weakness.remains<1|talent.weaponmaster.enabled&spell_targets.shuriken_storm<=4|azerite.inevitability.enabled&buff.symbols_of_death.up&spell_targets.shuriken_storm<=3+azerite.blade_in_the_shadows.enabled)
    if use_priority_rotation() and { target.debuffremaining(find_weakness) < 1 or hastalent(weaponmaster_talent) and enemies() <= 4 or hasazeritetrait(inevitability_trait) and buffpresent(symbols_of_death) and enemies() <= 3 + hasazeritetrait(blade_in_the_shadows_trait) } spell(shadowstrike)
    #shuriken_storm,if=spell_targets>=3+(buff.premeditation.up|buff.the_rotten.up|runeforge.akaaris_soul_fragment.equipped&conduit.deeper_daggers.rank>=7)
    if enemies() >= 3 + { buffpresent(premeditation) or buffpresent(the_rotten_buff) or message("runeforge.akaaris_soul_fragment.equipped is not implemented") and message("conduit.deeper_daggers.rank is not implemented") >= 7 } spell(shuriken_storm)
    #shadowstrike,if=debuff.find_weakness.remains<=1|cooldown.symbols_of_death.remains<18&debuff.find_weakness.remains<cooldown.symbols_of_death.remains
    if target.debuffremaining(find_weakness) <= 1 or spellcooldown(symbols_of_death) < 18 and target.debuffremaining(find_weakness) < spellcooldown(symbols_of_death) spell(shadowstrike)
    #pool_resource,for_next=1
    #gloomblade,if=!runeforge.akaaris_soul_fragment.equipped&buff.perforated_veins.stack>=3&conduit.perforated_veins.rank>=13-(9*conduit.deeper_dagger.enabled+conduit.deeper_dagger.rank)
    if not message("runeforge.akaaris_soul_fragment.equipped is not implemented") and buffstacks(perforated_veins_buff) >= 3 and message("conduit.perforated_veins.rank is not implemented") >= 13 - { 9 * message("conduit.deeper_dagger.enabled is not implemented") + message("conduit.deeper_dagger.rank is not implemented") } spell(gloomblade)
    unless not message("runeforge.akaaris_soul_fragment.equipped is not implemented") and buffstacks(perforated_veins_buff) >= 3 and message("conduit.perforated_veins.rank is not implemented") >= 13 - { 9 * message("conduit.deeper_dagger.enabled is not implemented") + message("conduit.deeper_dagger.rank is not implemented") } and spellusable(gloomblade) and spellcooldown(gloomblade) < timetoenergyfor(gloomblade)
    {
     #gloomblade,if=runeforge.akaaris_soul_fragment.equipped&buff.perforated_veins.stack>=3&(conduit.perforated_veins.rank+conduit.deeper_dagger.rank)>=16
     if message("runeforge.akaaris_soul_fragment.equipped is not implemented") and buffstacks(perforated_veins_buff) >= 3 and message("conduit.perforated_veins.rank is not implemented") + message("conduit.deeper_dagger.rank is not implemented") >= 16 spell(gloomblade)
     #shadowstrike
     spell(shadowstrike)
    }
   }
  }
 }
}

AddFunction subtletystealthedmainpostconditions
{
 buffpresent(shuriken_tornado) and combopointsdeficit() <= 2 and subtletyfinishmainpostconditions() or enemies() == 4 and combopoints() >= 4 and subtletyfinishmainpostconditions() or combopointsdeficit() <= 1 - { hastalent(deeper_stratagem_talent) and buffpresent(vanish) } and subtletyfinishmainpostconditions()
}

AddFunction subtletystealthedshortcdactions
{
 unless { buffpresent(stealth) or buffpresent(vanish) } and spell(shadowstrike)
 {
  #call_action_list,name=finish,if=buff.shuriken_tornado.up&combo_points.deficit<=2
  if buffpresent(shuriken_tornado) and combopointsdeficit() <= 2 subtletyfinishshortcdactions()

  unless buffpresent(shuriken_tornado) and combopointsdeficit() <= 2 and subtletyfinishshortcdpostconditions()
  {
   #call_action_list,name=finish,if=spell_targets.shuriken_storm=4&combo_points>=4
   if enemies() == 4 and combopoints() >= 4 subtletyfinishshortcdactions()

   unless enemies() == 4 and combopoints() >= 4 and subtletyfinishshortcdpostconditions()
   {
    #call_action_list,name=finish,if=combo_points.deficit<=1-(talent.deeper_stratagem.enabled&buff.vanish.up)
    if combopointsdeficit() <= 1 - { hastalent(deeper_stratagem_talent) and buffpresent(vanish) } subtletyfinishshortcdactions()
   }
  }
 }
}

AddFunction subtletystealthedshortcdpostconditions
{
 { buffpresent(stealth) or buffpresent(vanish) } and spell(shadowstrike) or buffpresent(shuriken_tornado) and combopointsdeficit() <= 2 and subtletyfinishshortcdpostconditions() or enemies() == 4 and combopoints() >= 4 and subtletyfinishshortcdpostconditions() or combopointsdeficit() <= 1 - { hastalent(deeper_stratagem_talent) and buffpresent(vanish) } and subtletyfinishshortcdpostconditions() or target.debuffremaining(find_weakness) < 1 and enemies() <= 3 and target.timetodie() - buffremaining(shadowstrike) > 6 and spell(shadowstrike) or not hastalent(deeper_stratagem_talent) and azeritetraitrank(blade_in_the_shadows_trait) == 3 and enemies() == 3 and spell(shadowstrike) or use_priority_rotation() and { target.debuffremaining(find_weakness) < 1 or hastalent(weaponmaster_talent) and enemies() <= 4 or hasazeritetrait(inevitability_trait) and buffpresent(symbols_of_death) and enemies() <= 3 + hasazeritetrait(blade_in_the_shadows_trait) } and spell(shadowstrike) or enemies() >= 3 + { buffpresent(premeditation) or buffpresent(the_rotten_buff) or message("runeforge.akaaris_soul_fragment.equipped is not implemented") and message("conduit.deeper_daggers.rank is not implemented") >= 7 } and spell(shuriken_storm) or { target.debuffremaining(find_weakness) <= 1 or spellcooldown(symbols_of_death) < 18 and target.debuffremaining(find_weakness) < spellcooldown(symbols_of_death) } and spell(shadowstrike) or not message("runeforge.akaaris_soul_fragment.equipped is not implemented") and buffstacks(perforated_veins_buff) >= 3 and message("conduit.perforated_veins.rank is not implemented") >= 13 - { 9 * message("conduit.deeper_dagger.enabled is not implemented") + message("conduit.deeper_dagger.rank is not implemented") } and spell(gloomblade) or not { not message("runeforge.akaaris_soul_fragment.equipped is not implemented") and buffstacks(perforated_veins_buff) >= 3 and message("conduit.perforated_veins.rank is not implemented") >= 13 - { 9 * message("conduit.deeper_dagger.enabled is not implemented") + message("conduit.deeper_dagger.rank is not implemented") } and spellusable(gloomblade) and spellcooldown(gloomblade) < timetoenergyfor(gloomblade) } and { message("runeforge.akaaris_soul_fragment.equipped is not implemented") and buffstacks(perforated_veins_buff) >= 3 and message("conduit.perforated_veins.rank is not implemented") + message("conduit.deeper_dagger.rank is not implemented") >= 16 and spell(gloomblade) or spell(shadowstrike) }
}

AddFunction subtletystealthedcdactions
{
 unless { buffpresent(stealth) or buffpresent(vanish) } and spell(shadowstrike)
 {
  #call_action_list,name=finish,if=buff.shuriken_tornado.up&combo_points.deficit<=2
  if buffpresent(shuriken_tornado) and combopointsdeficit() <= 2 subtletyfinishcdactions()

  unless buffpresent(shuriken_tornado) and combopointsdeficit() <= 2 and subtletyfinishcdpostconditions()
  {
   #call_action_list,name=finish,if=spell_targets.shuriken_storm=4&combo_points>=4
   if enemies() == 4 and combopoints() >= 4 subtletyfinishcdactions()

   unless enemies() == 4 and combopoints() >= 4 and subtletyfinishcdpostconditions()
   {
    #call_action_list,name=finish,if=combo_points.deficit<=1-(talent.deeper_stratagem.enabled&buff.vanish.up)
    if combopointsdeficit() <= 1 - { hastalent(deeper_stratagem_talent) and buffpresent(vanish) } subtletyfinishcdactions()
   }
  }
 }
}

AddFunction subtletystealthedcdpostconditions
{
 { buffpresent(stealth) or buffpresent(vanish) } and spell(shadowstrike) or buffpresent(shuriken_tornado) and combopointsdeficit() <= 2 and subtletyfinishcdpostconditions() or enemies() == 4 and combopoints() >= 4 and subtletyfinishcdpostconditions() or combopointsdeficit() <= 1 - { hastalent(deeper_stratagem_talent) and buffpresent(vanish) } and subtletyfinishcdpostconditions() or target.debuffremaining(find_weakness) < 1 and enemies() <= 3 and target.timetodie() - buffremaining(shadowstrike) > 6 and spell(shadowstrike) or not hastalent(deeper_stratagem_talent) and azeritetraitrank(blade_in_the_shadows_trait) == 3 and enemies() == 3 and spell(shadowstrike) or use_priority_rotation() and { target.debuffremaining(find_weakness) < 1 or hastalent(weaponmaster_talent) and enemies() <= 4 or hasazeritetrait(inevitability_trait) and buffpresent(symbols_of_death) and enemies() <= 3 + hasazeritetrait(blade_in_the_shadows_trait) } and spell(shadowstrike) or enemies() >= 3 + { buffpresent(premeditation) or buffpresent(the_rotten_buff) or message("runeforge.akaaris_soul_fragment.equipped is not implemented") and message("conduit.deeper_daggers.rank is not implemented") >= 7 } and spell(shuriken_storm) or { target.debuffremaining(find_weakness) <= 1 or spellcooldown(symbols_of_death) < 18 and target.debuffremaining(find_weakness) < spellcooldown(symbols_of_death) } and spell(shadowstrike) or not message("runeforge.akaaris_soul_fragment.equipped is not implemented") and buffstacks(perforated_veins_buff) >= 3 and message("conduit.perforated_veins.rank is not implemented") >= 13 - { 9 * message("conduit.deeper_dagger.enabled is not implemented") + message("conduit.deeper_dagger.rank is not implemented") } and spell(gloomblade) or not { not message("runeforge.akaaris_soul_fragment.equipped is not implemented") and buffstacks(perforated_veins_buff) >= 3 and message("conduit.perforated_veins.rank is not implemented") >= 13 - { 9 * message("conduit.deeper_dagger.enabled is not implemented") + message("conduit.deeper_dagger.rank is not implemented") } and spellusable(gloomblade) and spellcooldown(gloomblade) < timetoenergyfor(gloomblade) } and { message("runeforge.akaaris_soul_fragment.equipped is not implemented") and buffstacks(perforated_veins_buff) >= 3 and message("conduit.perforated_veins.rank is not implemented") + message("conduit.deeper_dagger.rank is not implemented") >= 16 and spell(gloomblade) or spell(shadowstrike) }
}

### actions.stealth_cds

AddFunction subtletystealth_cdsmainactions
{
 #sepsis
 spell(sepsis)
 #pool_resource,for_next=1,extra_amount=40
 #shadowmeld,if=energy>=40&energy.deficit>=10&!variable.shd_threshold&combo_points.deficit>1&debuff.find_weakness.remains<1
 unless energy() >= 40 and energydeficit() >= 10 and not shd_threshold() and combopointsdeficit() > 1 and target.debuffremaining(find_weakness) < 1 and spellusable(shadowmeld) and spellcooldown(shadowmeld) < timetoenergy(40)
 {
  #variable,name=shd_combo_points,value=combo_points.deficit>=4
  #variable,name=shd_combo_points,value=combo_points.deficit<=1,if=variable.use_priority_rotation
  #shadow_dance,if=variable.shd_combo_points&(variable.shd_threshold|buff.symbols_of_death.remains>=1.2|spell_targets.shuriken_storm>=4&cooldown.symbols_of_death.remains>10)
  if shd_combo_points() and { shd_threshold() or buffremaining(symbols_of_death) >= 1.2 or enemies() >= 4 and spellcooldown(symbols_of_death) > 10 } spell(shadow_dance)
  #shadow_dance,if=variable.shd_combo_points&fight_remains<cooldown.symbols_of_death.remains
  if shd_combo_points() and fightremains() < spellcooldown(symbols_of_death) spell(shadow_dance)
 }
}

AddFunction subtletystealth_cdsmainpostconditions
{
}

AddFunction subtletystealth_cdsshortcdactions
{
}

AddFunction subtletystealth_cdsshortcdpostconditions
{
 spell(sepsis) or not { energy() >= 40 and energydeficit() >= 10 and not shd_threshold() and combopointsdeficit() > 1 and target.debuffremaining(find_weakness) < 1 and spellusable(shadowmeld) and spellcooldown(shadowmeld) < timetoenergy(40) } and { shd_combo_points() and { shd_threshold() or buffremaining(symbols_of_death) >= 1.2 or enemies() >= 4 and spellcooldown(symbols_of_death) > 10 } and spell(shadow_dance) or shd_combo_points() and fightremains() < spellcooldown(symbols_of_death) and spell(shadow_dance) }
}

AddFunction subtletystealth_cdscdactions
{
 #variable,name=shd_threshold,value=cooldown.shadow_dance.charges_fractional>=1.75
 #vanish,if=(!variable.shd_threshold|!talent.nightstalker.enabled&talent.dark_shadow.enabled)&combo_points.deficit>1&!runeforge.mark_of_the_master_assassin.equipped
 if { not shd_threshold() or not hastalent(nightstalker_talent) and hastalent(dark_shadow_talent) } and combopointsdeficit() > 1 and not message("runeforge.mark_of_the_master_assassin.equipped is not implemented") spell(vanish)

 unless spell(sepsis)
 {
  #pool_resource,for_next=1,extra_amount=40
  #shadowmeld,if=energy>=40&energy.deficit>=10&!variable.shd_threshold&combo_points.deficit>1&debuff.find_weakness.remains<1
  if energy() >= 40 and energydeficit() >= 10 and not shd_threshold() and combopointsdeficit() > 1 and target.debuffremaining(find_weakness) < 1 spell(shadowmeld)
 }
}

AddFunction subtletystealth_cdscdpostconditions
{
 spell(sepsis) or not { energy() >= 40 and energydeficit() >= 10 and not shd_threshold() and combopointsdeficit() > 1 and target.debuffremaining(find_weakness) < 1 and spellusable(shadowmeld) and spellcooldown(shadowmeld) < timetoenergy(40) } and { shd_combo_points() and { shd_threshold() or buffremaining(symbols_of_death) >= 1.2 or enemies() >= 4 and spellcooldown(symbols_of_death) > 10 } and spell(shadow_dance) or shd_combo_points() and fightremains() < spellcooldown(symbols_of_death) and spell(shadow_dance) }
}

### actions.precombat

AddFunction subtletyprecombatmainactions
{
 #apply_poison
 #flask
 #augmentation
 #food
 #snapshot_stats
 #stealth
 spell(stealth)
 #slice_and_dice,precombat_seconds=1
 spell(slice_and_dice)
}

AddFunction subtletyprecombatmainpostconditions
{
}

AddFunction subtletyprecombatshortcdactions
{
 unless spell(stealth)
 {
  #marked_for_death,precombat_seconds=15
  spell(marked_for_death)
 }
}

AddFunction subtletyprecombatshortcdpostconditions
{
 spell(stealth) or spell(slice_and_dice)
}

AddFunction subtletyprecombatcdactions
{
 unless spell(stealth) or spell(marked_for_death) or spell(slice_and_dice)
 {
  #shadow_blades,if=runeforge.mark_of_the_master_assassin.equipped
  if message("runeforge.mark_of_the_master_assassin.equipped is not implemented") spell(shadow_blades)
  #use_item,name=azsharas_font_of_power
  subtletyuseitemactions()
 }
}

AddFunction subtletyprecombatcdpostconditions
{
 spell(stealth) or spell(marked_for_death) or spell(slice_and_dice)
}

### actions.finish

AddFunction subtletyfinishmainactions
{
 #slice_and_dice,if=spell_targets.shuriken_storm<6&!buff.shadow_dance.up&buff.slice_and_dice.remains<fight_remains&buff.slice_and_dice.remains<(1+combo_points)*1.8
 if enemies() < 6 and not buffpresent(shadow_dance) and buffremaining(slice_and_dice) < fightremains() and buffremaining(slice_and_dice) < { 1 + combopoints() } * 1.8 spell(slice_and_dice)
 #variable,name=skip_rupture,value=master_assassin_remains>0|!talent.nightstalker.enabled&talent.dark_shadow.enabled&buff.shadow_dance.up|spell_targets.shuriken_storm>=6
 #rupture,if=!variable.skip_rupture&target.time_to_die-remains>6&refreshable
 if not skip_rupture() and target.timetodie() - buffremaining(rupture) > 6 and target.refreshable(rupture) spell(rupture)
 #rupture,cycle_targets=1,if=!variable.skip_rupture&!variable.use_priority_rotation&spell_targets.shuriken_storm>=2&target.time_to_die>=(5+(2*combo_points))&refreshable
 if not skip_rupture() and not use_priority_rotation() and enemies() >= 2 and target.timetodie() >= 5 + 2 * combopoints() and target.refreshable(rupture) spell(rupture)
 #rupture,if=!variable.skip_rupture&remains<cooldown.symbols_of_death.remains+10&cooldown.symbols_of_death.remains<=5&target.time_to_die-remains>cooldown.symbols_of_death.remains+5
 if not skip_rupture() and buffremaining(rupture) < spellcooldown(symbols_of_death) + 10 and spellcooldown(symbols_of_death) <= 5 and target.timetodie() - buffremaining(rupture) > spellcooldown(symbols_of_death) + 5 spell(rupture)
 #eviscerate
 spell(eviscerate)
}

AddFunction subtletyfinishmainpostconditions
{
}

AddFunction subtletyfinishshortcdactions
{
 unless enemies() < 6 and not buffpresent(shadow_dance) and buffremaining(slice_and_dice) < fightremains() and buffremaining(slice_and_dice) < { 1 + combopoints() } * 1.8 and spell(slice_and_dice) or not skip_rupture() and target.timetodie() - buffremaining(rupture) > 6 and target.refreshable(rupture) and spell(rupture)
 {
  #secret_technique
  spell(secret_technique)
 }
}

AddFunction subtletyfinishshortcdpostconditions
{
 enemies() < 6 and not buffpresent(shadow_dance) and buffremaining(slice_and_dice) < fightremains() and buffremaining(slice_and_dice) < { 1 + combopoints() } * 1.8 and spell(slice_and_dice) or not skip_rupture() and target.timetodie() - buffremaining(rupture) > 6 and target.refreshable(rupture) and spell(rupture) or not skip_rupture() and not use_priority_rotation() and enemies() >= 2 and target.timetodie() >= 5 + 2 * combopoints() and target.refreshable(rupture) and spell(rupture) or not skip_rupture() and buffremaining(rupture) < spellcooldown(symbols_of_death) + 10 and spellcooldown(symbols_of_death) <= 5 and target.timetodie() - buffremaining(rupture) > spellcooldown(symbols_of_death) + 5 and spell(rupture) or spell(eviscerate)
}

AddFunction subtletyfinishcdactions
{
}

AddFunction subtletyfinishcdpostconditions
{
 enemies() < 6 and not buffpresent(shadow_dance) and buffremaining(slice_and_dice) < fightremains() and buffremaining(slice_and_dice) < { 1 + combopoints() } * 1.8 and spell(slice_and_dice) or not skip_rupture() and target.timetodie() - buffremaining(rupture) > 6 and target.refreshable(rupture) and spell(rupture) or spell(secret_technique) or not skip_rupture() and not use_priority_rotation() and enemies() >= 2 and target.timetodie() >= 5 + 2 * combopoints() and target.refreshable(rupture) and spell(rupture) or not skip_rupture() and buffremaining(rupture) < spellcooldown(symbols_of_death) + 10 and spellcooldown(symbols_of_death) <= 5 and target.timetodie() - buffremaining(rupture) > spellcooldown(symbols_of_death) + 5 and spell(rupture) or spell(eviscerate)
}

### actions.essences

AddFunction subtletyessencesmainactions
{
 #concentrated_flame,if=energy.time_to_max>1&!buff.symbols_of_death.up&(!dot.concentrated_flame_burn.ticking&!action.concentrated_flame.in_flight|full_recharge_time<gcd.max)
 if timetomaxenergy() > 1 and not buffpresent(symbols_of_death) and { not target.debuffpresent(concentrated_flame_burn_debuff) and not inflighttotarget(concentrated_flame) or spellfullrecharge(concentrated_flame) < gcd() } spell(concentrated_flame)
 #blood_of_the_enemy,if=!cooldown.shadow_blades.up&cooldown.symbols_of_death.up|fight_remains<=10
 if not { not spellcooldown(shadow_blades) > 0 } and not spellcooldown(symbols_of_death) > 0 or fightremains() <= 10 spell(blood_of_the_enemy)
 #the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<10
 if buffpresent(reckless_force_buff) or buffstacks(reckless_force_counter) < 10 spell(the_unbound_force)
 #ripple_in_space
 spell(ripple_in_space)
 #worldvein_resonance,if=cooldown.symbols_of_death.remains<5|fight_remains<18
 if spellcooldown(symbols_of_death) < 5 or fightremains() < 18 spell(worldvein_resonance)
 #memory_of_lucid_dreams,if=energy<40&buff.symbols_of_death.up
 if energy() < 40 and buffpresent(symbols_of_death) spell(memory_of_lucid_dreams)
}

AddFunction subtletyessencesmainpostconditions
{
}

AddFunction subtletyessencesshortcdactions
{
 unless timetomaxenergy() > 1 and not buffpresent(symbols_of_death) and { not target.debuffpresent(concentrated_flame_burn_debuff) and not inflighttotarget(concentrated_flame) or spellfullrecharge(concentrated_flame) < gcd() } and spell(concentrated_flame) or { not { not spellcooldown(shadow_blades) > 0 } and not spellcooldown(symbols_of_death) > 0 or fightremains() <= 10 } and spell(blood_of_the_enemy)
 {
  #focused_azerite_beam,if=(spell_targets.shuriken_storm>=2|raid_event.adds.in>60)&!cooldown.symbols_of_death.up&!buff.symbols_of_death.up&energy.deficit>=30
  if { enemies() >= 2 or 600 > 60 } and not { not spellcooldown(symbols_of_death) > 0 } and not buffpresent(symbols_of_death) and energydeficit() >= 30 spell(focused_azerite_beam)
  #purifying_blast,if=spell_targets.shuriken_storm>=2|raid_event.adds.in>60
  if enemies() >= 2 or 600 > 60 spell(purifying_blast)

  unless { buffpresent(reckless_force_buff) or buffstacks(reckless_force_counter) < 10 } and spell(the_unbound_force) or spell(ripple_in_space) or { spellcooldown(symbols_of_death) < 5 or fightremains() < 18 } and spell(worldvein_resonance) or energy() < 40 and buffpresent(symbols_of_death) and spell(memory_of_lucid_dreams)
  {
   #cycling_variable,name=reaping_delay,op=min,if=essence.breath_of_the_dying.major,value=target.time_to_die
   #reaping_flames,target_if=target.time_to_die<1.5|((target.health.pct>80|target.health.pct<=20)&(active_enemies=1|variable.reaping_delay>29))|(target.time_to_pct_20>30&(active_enemies=1|variable.reaping_delay>44))
   if target.timetodie() < 1.5 or { target.healthpercent() > 80 or target.healthpercent() <= 20 } and { enemies() == 1 or reaping_delay() > 29 } or target.timetohealthpercent(20) > 30 and { enemies() == 1 or reaping_delay() > 44 } spell(reaping_flames)
  }
 }
}

AddFunction subtletyessencesshortcdpostconditions
{
 timetomaxenergy() > 1 and not buffpresent(symbols_of_death) and { not target.debuffpresent(concentrated_flame_burn_debuff) and not inflighttotarget(concentrated_flame) or spellfullrecharge(concentrated_flame) < gcd() } and spell(concentrated_flame) or { not { not spellcooldown(shadow_blades) > 0 } and not spellcooldown(symbols_of_death) > 0 or fightremains() <= 10 } and spell(blood_of_the_enemy) or { buffpresent(reckless_force_buff) or buffstacks(reckless_force_counter) < 10 } and spell(the_unbound_force) or spell(ripple_in_space) or { spellcooldown(symbols_of_death) < 5 or fightremains() < 18 } and spell(worldvein_resonance) or energy() < 40 and buffpresent(symbols_of_death) and spell(memory_of_lucid_dreams)
}

AddFunction subtletyessencescdactions
{
 unless timetomaxenergy() > 1 and not buffpresent(symbols_of_death) and { not target.debuffpresent(concentrated_flame_burn_debuff) and not inflighttotarget(concentrated_flame) or spellfullrecharge(concentrated_flame) < gcd() } and spell(concentrated_flame) or { not { not spellcooldown(shadow_blades) > 0 } and not spellcooldown(symbols_of_death) > 0 or fightremains() <= 10 } and spell(blood_of_the_enemy)
 {
  #guardian_of_azeroth
  spell(guardian_of_azeroth)
 }
}

AddFunction subtletyessencescdpostconditions
{
 timetomaxenergy() > 1 and not buffpresent(symbols_of_death) and { not target.debuffpresent(concentrated_flame_burn_debuff) and not inflighttotarget(concentrated_flame) or spellfullrecharge(concentrated_flame) < gcd() } and spell(concentrated_flame) or { not { not spellcooldown(shadow_blades) > 0 } and not spellcooldown(symbols_of_death) > 0 or fightremains() <= 10 } and spell(blood_of_the_enemy) or { enemies() >= 2 or 600 > 60 } and not { not spellcooldown(symbols_of_death) > 0 } and not buffpresent(symbols_of_death) and energydeficit() >= 30 and spell(focused_azerite_beam) or { enemies() >= 2 or 600 > 60 } and spell(purifying_blast) or { buffpresent(reckless_force_buff) or buffstacks(reckless_force_counter) < 10 } and spell(the_unbound_force) or spell(ripple_in_space) or { spellcooldown(symbols_of_death) < 5 or fightremains() < 18 } and spell(worldvein_resonance) or energy() < 40 and buffpresent(symbols_of_death) and spell(memory_of_lucid_dreams) or { target.timetodie() < 1.5 or { target.healthpercent() > 80 or target.healthpercent() <= 20 } and { enemies() == 1 or reaping_delay() > 29 } or target.timetohealthpercent(20) > 30 and { enemies() == 1 or reaping_delay() > 44 } } and spell(reaping_flames)
}

### actions.cds

AddFunction subtletycdsmainactions
{
 #shadow_dance,use_off_gcd=1,if=!buff.shadow_dance.up&buff.shuriken_tornado.up&buff.shuriken_tornado.remains<=3.5
 if not buffpresent(shadow_dance) and buffpresent(shuriken_tornado) and buffremaining(shuriken_tornado) <= 3.5 spell(shadow_dance)
 #flagellation_cleanse,if=debuff.flagellation.remains<2|debuff.flagellation.stack>=40
 if target.debuffremaining(flagellation) < 2 or target.debuffstacks(flagellation) >= 40 spell(flagellation_cleanse)
 #call_action_list,name=essences,if=!stealthed.all&variable.snd_condition|essence.breath_of_the_dying.major&time>=2
 if not stealthed() and snd_condition() or azeriteessenceismajor(breath_of_the_dying_essence_id) and timeincombat() >= 2 subtletyessencesmainactions()

 unless { not stealthed() and snd_condition() or azeriteessenceismajor(breath_of_the_dying_essence_id) and timeincombat() >= 2 } and subtletyessencesmainpostconditions()
 {
  #pool_resource,for_next=1,if=!talent.shadow_focus.enabled
  unless not hastalent(shadow_focus_talent)
  {
   #serrated_bone_spike,cycle_targets=1,if=variable.snd_condition&!dot.serrated_bone_spike_dot.ticking|fight_remains<=5
   if snd_condition() and not target.debuffpresent(serrated_bone_spike_dot_debuff) or fightremains() <= 5 spell(serrated_bone_spike)
   #shadow_dance,if=!buff.shadow_dance.up&fight_remains<=8+talent.subterfuge.enabled
   if not buffpresent(shadow_dance) and fightremains() <= 8 + talentpoints(subterfuge_talent) spell(shadow_dance)
   #berserking,if=buff.symbols_of_death.up
   if buffpresent(symbols_of_death) spell(berserking)
  }
 }
}

AddFunction subtletycdsmainpostconditions
{
 { not stealthed() and snd_condition() or azeriteessenceismajor(breath_of_the_dying_essence_id) and timeincombat() >= 2 } and subtletyessencesmainpostconditions()
}

AddFunction subtletycdsshortcdactions
{
 unless not buffpresent(shadow_dance) and buffpresent(shuriken_tornado) and buffremaining(shuriken_tornado) <= 3.5 and spell(shadow_dance)
 {
  #symbols_of_death,use_off_gcd=1,if=buff.shuriken_tornado.up&buff.shuriken_tornado.remains<=3.5
  if buffpresent(shuriken_tornado) and buffremaining(shuriken_tornado) <= 3.5 spell(symbols_of_death)
  #flagellation,if=variable.snd_condition&!stealthed.mantle
  if snd_condition() and not message("stealthed.mantle is not implemented") spell(flagellation)

  unless { target.debuffremaining(flagellation) < 2 or target.debuffstacks(flagellation) >= 40 } and spell(flagellation_cleanse)
  {
   #call_action_list,name=essences,if=!stealthed.all&variable.snd_condition|essence.breath_of_the_dying.major&time>=2
   if not stealthed() and snd_condition() or azeriteessenceismajor(breath_of_the_dying_essence_id) and timeincombat() >= 2 subtletyessencesshortcdactions()

   unless { not stealthed() and snd_condition() or azeriteessenceismajor(breath_of_the_dying_essence_id) and timeincombat() >= 2 } and subtletyessencesshortcdpostconditions()
   {
    #pool_resource,for_next=1,if=!talent.shadow_focus.enabled
    unless not hastalent(shadow_focus_talent)
    {
     #shuriken_tornado,if=energy>=60&variable.snd_condition&cooldown.symbols_of_death.up&cooldown.shadow_dance.charges>=1
     if energy() >= 60 and snd_condition() and not spellcooldown(symbols_of_death) > 0 and spellcharges(shadow_dance) >= 1 spell(shuriken_tornado)

     unless { snd_condition() and not target.debuffpresent(serrated_bone_spike_dot_debuff) or fightremains() <= 5 } and spell(serrated_bone_spike)
     {
      #symbols_of_death,if=variable.snd_condition&!cooldown.shadow_blades.up&(talent.enveloping_shadows.enabled|cooldown.shadow_dance.charges>=1)&(!talent.shuriken_tornado.enabled|talent.shadow_focus.enabled|cooldown.shuriken_tornado.remains>2)&(!runeforge.the_rotten.equipped|combo_points<=2)&(!essence.blood_of_the_enemy.major|cooldown.blood_of_the_enemy.remains>2)
      if snd_condition() and not { not spellcooldown(shadow_blades) > 0 } and { hastalent(enveloping_shadows_talent) or spellcharges(shadow_dance) >= 1 } and { not hastalent(shuriken_tornado_talent) or hastalent(shadow_focus_talent) or spellcooldown(shuriken_tornado) > 2 } and { not message("runeforge.the_rotten.equipped is not implemented") or combopoints() <= 2 } and { not azeriteessenceismajor(blood_of_the_enemy_essence_id) or spellcooldown(blood_of_the_enemy) > 2 } spell(symbols_of_death)
      #marked_for_death,target_if=min:target.time_to_die,if=raid_event.adds.up&(target.time_to_die<combo_points.deficit|!stealthed.all&combo_points.deficit>=cp_max_spend)
      if false(raid_event_adds_exists) and { target.timetodie() < combopointsdeficit() or not stealthed() and combopointsdeficit() >= maxcombopoints() } spell(marked_for_death)
      #marked_for_death,if=raid_event.adds.in>30-raid_event.adds.duration&combo_points.deficit>=cp_max_spend
      if 600 > 30 - 10 and combopointsdeficit() >= maxcombopoints() spell(marked_for_death)
      #echoing_reprimand,if=variable.snd_condition&combo_points.deficit>=3&spell_targets.shuriken_storm<=4
      if snd_condition() and combopointsdeficit() >= 3 and enemies() <= 4 spell(echoing_reprimand)
      #shuriken_tornado,if=talent.shadow_focus.enabled&variable.snd_condition&buff.symbols_of_death.up
      if hastalent(shadow_focus_talent) and snd_condition() and buffpresent(symbols_of_death) spell(shuriken_tornado)
     }
    }
   }
  }
 }
}

AddFunction subtletycdsshortcdpostconditions
{
 not buffpresent(shadow_dance) and buffpresent(shuriken_tornado) and buffremaining(shuriken_tornado) <= 3.5 and spell(shadow_dance) or { target.debuffremaining(flagellation) < 2 or target.debuffstacks(flagellation) >= 40 } and spell(flagellation_cleanse) or { not stealthed() and snd_condition() or azeriteessenceismajor(breath_of_the_dying_essence_id) and timeincombat() >= 2 } and subtletyessencesshortcdpostconditions() or not { not hastalent(shadow_focus_talent) } and { { snd_condition() and not target.debuffpresent(serrated_bone_spike_dot_debuff) or fightremains() <= 5 } and spell(serrated_bone_spike) or not buffpresent(shadow_dance) and fightremains() <= 8 + talentpoints(subterfuge_talent) and spell(shadow_dance) or buffpresent(symbols_of_death) and spell(berserking) }
}

AddFunction subtletycdscdactions
{
 unless not buffpresent(shadow_dance) and buffpresent(shuriken_tornado) and buffremaining(shuriken_tornado) <= 3.5 and spell(shadow_dance) or buffpresent(shuriken_tornado) and buffremaining(shuriken_tornado) <= 3.5 and spell(symbols_of_death) or snd_condition() and not message("stealthed.mantle is not implemented") and spell(flagellation) or { target.debuffremaining(flagellation) < 2 or target.debuffstacks(flagellation) >= 40 } and spell(flagellation_cleanse)
 {
  #vanish,if=(runeforge.mark_of_the_master_assassin.equipped&combo_points.deficit<=3|runeforge.deathly_shadows.equipped&combo_points<1)&buff.symbols_of_death.up&buff.shadow_dance.up&master_assassin_remains=0&buff.deathly_shadows.down
  if { message("runeforge.mark_of_the_master_assassin.equipped is not implemented") and combopointsdeficit() <= 3 or message("runeforge.deathly_shadows.equipped is not implemented") and combopoints() < 1 } and buffpresent(symbols_of_death) and buffpresent(shadow_dance) and buffremaining(master_assassin_buff) == 0 and buffexpires(deathly_shadows_buff) spell(vanish)
  #call_action_list,name=essences,if=!stealthed.all&variable.snd_condition|essence.breath_of_the_dying.major&time>=2
  if not stealthed() and snd_condition() or azeriteessenceismajor(breath_of_the_dying_essence_id) and timeincombat() >= 2 subtletyessencescdactions()

  unless { not stealthed() and snd_condition() or azeriteessenceismajor(breath_of_the_dying_essence_id) and timeincombat() >= 2 } and subtletyessencescdpostconditions()
  {
   #pool_resource,for_next=1,if=!talent.shadow_focus.enabled
   unless not hastalent(shadow_focus_talent)
   {
    unless energy() >= 60 and snd_condition() and not spellcooldown(symbols_of_death) > 0 and spellcharges(shadow_dance) >= 1 and spell(shuriken_tornado) or { snd_condition() and not target.debuffpresent(serrated_bone_spike_dot_debuff) or fightremains() <= 5 } and spell(serrated_bone_spike) or snd_condition() and not { not spellcooldown(shadow_blades) > 0 } and { hastalent(enveloping_shadows_talent) or spellcharges(shadow_dance) >= 1 } and { not hastalent(shuriken_tornado_talent) or hastalent(shadow_focus_talent) or spellcooldown(shuriken_tornado) > 2 } and { not message("runeforge.the_rotten.equipped is not implemented") or combopoints() <= 2 } and { not azeriteessenceismajor(blood_of_the_enemy_essence_id) or spellcooldown(blood_of_the_enemy) > 2 } and spell(symbols_of_death) or false(raid_event_adds_exists) and { target.timetodie() < combopointsdeficit() or not stealthed() and combopointsdeficit() >= maxcombopoints() } and spell(marked_for_death) or 600 > 30 - 10 and combopointsdeficit() >= maxcombopoints() and spell(marked_for_death)
    {
     #shadow_blades,if=variable.snd_condition&combo_points.deficit>=2
     if snd_condition() and combopointsdeficit() >= 2 spell(shadow_blades)

     unless snd_condition() and combopointsdeficit() >= 3 and enemies() <= 4 and spell(echoing_reprimand) or hastalent(shadow_focus_talent) and snd_condition() and buffpresent(symbols_of_death) and spell(shuriken_tornado) or not buffpresent(shadow_dance) and fightremains() <= 8 + talentpoints(subterfuge_talent) and spell(shadow_dance)
     {
      #potion,if=buff.bloodlust.react|buff.symbols_of_death.up&(buff.shadow_blades.up|cooldown.shadow_blades.remains<=10)
      if { buffpresent(bloodlust) or buffpresent(symbols_of_death) and { buffpresent(shadow_blades_buff) or spellcooldown(shadow_blades) <= 10 } } and checkboxon(opt_use_consumables) and target.classification(worldboss) item(unbridled_fury_item usable=1)
      #blood_fury,if=buff.symbols_of_death.up
      if buffpresent(symbols_of_death) spell(blood_fury)

      unless buffpresent(symbols_of_death) and spell(berserking)
      {
       #fireblood,if=buff.symbols_of_death.up
       if buffpresent(symbols_of_death) spell(fireblood)
       #ancestral_call,if=buff.symbols_of_death.up
       if buffpresent(symbols_of_death) spell(ancestral_call)
       #use_item,effect_name=cyclotronic_blast,if=!stealthed.all&variable.snd_condition&!buff.symbols_of_death.up&energy.deficit>=30
       if not stealthed() and snd_condition() and not buffpresent(symbols_of_death) and energydeficit() >= 30 subtletyuseitemactions()
       #use_item,name=azsharas_font_of_power,if=!buff.shadow_dance.up&cooldown.symbols_of_death.remains<10
       if not buffpresent(shadow_dance) and spellcooldown(symbols_of_death) < 10 subtletyuseitemactions()
       #use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|debuff.conductive_ink_debuff.up&target.health.pct<32&target.health.pct>=30|!debuff.conductive_ink_debuff.up&(debuff.razor_coral_debuff.stack>=25-10*debuff.blood_of_the_enemy.up|fight_remains<40)&buff.symbols_of_death.remains>8
       if target.debuffexpires(razor_coral) or target.debuffpresent(conductive_ink_debuff) and target.healthpercent() < 32 and target.healthpercent() >= 30 or not target.debuffpresent(conductive_ink_debuff) and { target.debuffstacks(razor_coral) >= 25 - 10 * target.debuffpresent(blood_of_the_enemy) or fightremains() < 40 } and buffremaining(symbols_of_death) > 8 subtletyuseitemactions()
       #use_item,name=mydas_talisman
       subtletyuseitemactions()
       #use_items,if=buff.symbols_of_death.up|fight_remains<20
       if buffpresent(symbols_of_death) or fightremains() < 20 subtletyuseitemactions()
      }
     }
    }
   }
  }
 }
}

AddFunction subtletycdscdpostconditions
{
 not buffpresent(shadow_dance) and buffpresent(shuriken_tornado) and buffremaining(shuriken_tornado) <= 3.5 and spell(shadow_dance) or buffpresent(shuriken_tornado) and buffremaining(shuriken_tornado) <= 3.5 and spell(symbols_of_death) or snd_condition() and not message("stealthed.mantle is not implemented") and spell(flagellation) or { target.debuffremaining(flagellation) < 2 or target.debuffstacks(flagellation) >= 40 } and spell(flagellation_cleanse) or { not stealthed() and snd_condition() or azeriteessenceismajor(breath_of_the_dying_essence_id) and timeincombat() >= 2 } and subtletyessencescdpostconditions() or not { not hastalent(shadow_focus_talent) } and { energy() >= 60 and snd_condition() and not spellcooldown(symbols_of_death) > 0 and spellcharges(shadow_dance) >= 1 and spell(shuriken_tornado) or { snd_condition() and not target.debuffpresent(serrated_bone_spike_dot_debuff) or fightremains() <= 5 } and spell(serrated_bone_spike) or snd_condition() and not { not spellcooldown(shadow_blades) > 0 } and { hastalent(enveloping_shadows_talent) or spellcharges(shadow_dance) >= 1 } and { not hastalent(shuriken_tornado_talent) or hastalent(shadow_focus_talent) or spellcooldown(shuriken_tornado) > 2 } and { not message("runeforge.the_rotten.equipped is not implemented") or combopoints() <= 2 } and { not azeriteessenceismajor(blood_of_the_enemy_essence_id) or spellcooldown(blood_of_the_enemy) > 2 } and spell(symbols_of_death) or false(raid_event_adds_exists) and { target.timetodie() < combopointsdeficit() or not stealthed() and combopointsdeficit() >= maxcombopoints() } and spell(marked_for_death) or 600 > 30 - 10 and combopointsdeficit() >= maxcombopoints() and spell(marked_for_death) or snd_condition() and combopointsdeficit() >= 3 and enemies() <= 4 and spell(echoing_reprimand) or hastalent(shadow_focus_talent) and snd_condition() and buffpresent(symbols_of_death) and spell(shuriken_tornado) or not buffpresent(shadow_dance) and fightremains() <= 8 + talentpoints(subterfuge_talent) and spell(shadow_dance) or buffpresent(symbols_of_death) and spell(berserking) }
}

### actions.build

AddFunction subtletybuildmainactions
{
 #shuriken_storm,if=spell_targets>=2+(talent.gloomblade.enabled&azerite.perforate.rank>=2&position_back)
 if enemies() >= 2 + { hastalent(gloomblade_talent) and azeritetraitrank(perforate_trait) >= 2 and true(position_back) } spell(shuriken_storm)
 #serrated_bone_spike,if=cooldown.serrated_bone_spike.charges_fractional>=2.75
 if spellcharges(serrated_bone_spike count=0) >= 2.75 spell(serrated_bone_spike)
 #gloomblade
 spell(gloomblade)
 #backstab
 spell(backstab)
}

AddFunction subtletybuildmainpostconditions
{
}

AddFunction subtletybuildshortcdactions
{
}

AddFunction subtletybuildshortcdpostconditions
{
 enemies() >= 2 + { hastalent(gloomblade_talent) and azeritetraitrank(perforate_trait) >= 2 and true(position_back) } and spell(shuriken_storm) or spellcharges(serrated_bone_spike count=0) >= 2.75 and spell(serrated_bone_spike) or spell(gloomblade) or spell(backstab)
}

AddFunction subtletybuildcdactions
{
}

AddFunction subtletybuildcdpostconditions
{
 enemies() >= 2 + { hastalent(gloomblade_talent) and azeritetraitrank(perforate_trait) >= 2 and true(position_back) } and spell(shuriken_storm) or spellcharges(serrated_bone_spike count=0) >= 2.75 and spell(serrated_bone_spike) or spell(gloomblade) or spell(backstab)
}

### actions.default

AddFunction subtlety_defaultmainactions
{
 #stealth
 spell(stealth)
 #variable,name=snd_condition,value=buff.slice_and_dice.up|spell_targets.shuriken_storm>=6
 #call_action_list,name=cds
 subtletycdsmainactions()

 unless subtletycdsmainpostconditions()
 {
  #run_action_list,name=stealthed,if=stealthed.all
  if stealthed() subtletystealthedmainactions()

  unless stealthed() and subtletystealthedmainpostconditions()
  {
   #slice_and_dice,if=spell_targets.shuriken_storm<6&fight_remains>6&buff.slice_and_dice.remains<gcd.max&combo_points>=4-(time<10)*2
   if enemies() < 6 and fightremains() > 6 and buffremaining(slice_and_dice) < gcd() and combopoints() >= 4 - { timeincombat() < 10 } * 2 spell(slice_and_dice)
   #variable,name=use_priority_rotation,value=priority_rotation&spell_targets.shuriken_storm>=2
   #call_action_list,name=stealth_cds,if=variable.use_priority_rotation
   if use_priority_rotation() subtletystealth_cdsmainactions()

   unless use_priority_rotation() and subtletystealth_cdsmainpostconditions()
   {
    #variable,name=stealth_threshold,value=25+talent.vigor.enabled*20+talent.master_of_shadows.enabled*20+talent.shadow_focus.enabled*25+talent.alacrity.enabled*20+25*(spell_targets.shuriken_storm>=4)
    #call_action_list,name=stealth_cds,if=energy.deficit<=variable.stealth_threshold
    if energydeficit() <= stealth_threshold() subtletystealth_cdsmainactions()

    unless energydeficit() <= stealth_threshold() and subtletystealth_cdsmainpostconditions()
    {
     #call_action_list,name=finish,if=runeforge.deathly_shadows.equipped&dot.sepsis.ticking&dot.sepsis.remains<=2&combo_points>=2
     if message("runeforge.deathly_shadows.equipped is not implemented") and target.debuffpresent(sepsis) and target.debuffremaining(sepsis) <= 2 and combopoints() >= 2 subtletyfinishmainactions()

     unless message("runeforge.deathly_shadows.equipped is not implemented") and target.debuffpresent(sepsis) and target.debuffremaining(sepsis) <= 2 and combopoints() >= 2 and subtletyfinishmainpostconditions()
     {
      #call_action_list,name=finish,if=cooldown.symbols_of_death.remains<=2&combo_points>=2&runeforge.the_rotten.equipped
      if spellcooldown(symbols_of_death) <= 2 and combopoints() >= 2 and message("runeforge.the_rotten.equipped is not implemented") subtletyfinishmainactions()

      unless spellcooldown(symbols_of_death) <= 2 and combopoints() >= 2 and message("runeforge.the_rotten.equipped is not implemented") and subtletyfinishmainpostconditions()
      {
       #call_action_list,name=finish,if=combo_points=animacharged_cp
       if combopoints() == message("animacharged_cp is not implemented") subtletyfinishmainactions()

       unless combopoints() == message("animacharged_cp is not implemented") and subtletyfinishmainpostconditions()
       {
        #call_action_list,name=finish,if=combo_points.deficit<=1|fight_remains<=1&combo_points>=3
        if combopointsdeficit() <= 1 or fightremains() <= 1 and combopoints() >= 3 subtletyfinishmainactions()

        unless { combopointsdeficit() <= 1 or fightremains() <= 1 and combopoints() >= 3 } and subtletyfinishmainpostconditions()
        {
         #call_action_list,name=finish,if=spell_targets.shuriken_storm=4&combo_points>=4
         if enemies() == 4 and combopoints() >= 4 subtletyfinishmainactions()

         unless enemies() == 4 and combopoints() >= 4 and subtletyfinishmainpostconditions()
         {
          #call_action_list,name=build,if=energy.deficit<=variable.stealth_threshold
          if energydeficit() <= stealth_threshold() subtletybuildmainactions()
         }
        }
       }
      }
     }
    }
   }
  }
 }
}

AddFunction subtlety_defaultmainpostconditions
{
 subtletycdsmainpostconditions() or stealthed() and subtletystealthedmainpostconditions() or use_priority_rotation() and subtletystealth_cdsmainpostconditions() or energydeficit() <= stealth_threshold() and subtletystealth_cdsmainpostconditions() or message("runeforge.deathly_shadows.equipped is not implemented") and target.debuffpresent(sepsis) and target.debuffremaining(sepsis) <= 2 and combopoints() >= 2 and subtletyfinishmainpostconditions() or spellcooldown(symbols_of_death) <= 2 and combopoints() >= 2 and message("runeforge.the_rotten.equipped is not implemented") and subtletyfinishmainpostconditions() or combopoints() == message("animacharged_cp is not implemented") and subtletyfinishmainpostconditions() or { combopointsdeficit() <= 1 or fightremains() <= 1 and combopoints() >= 3 } and subtletyfinishmainpostconditions() or enemies() == 4 and combopoints() >= 4 and subtletyfinishmainpostconditions() or energydeficit() <= stealth_threshold() and subtletybuildmainpostconditions()
}

AddFunction subtlety_defaultshortcdactions
{
 unless spell(stealth)
 {
  #variable,name=snd_condition,value=buff.slice_and_dice.up|spell_targets.shuriken_storm>=6
  #call_action_list,name=cds
  subtletycdsshortcdactions()

  unless subtletycdsshortcdpostconditions()
  {
   #run_action_list,name=stealthed,if=stealthed.all
   if stealthed() subtletystealthedshortcdactions()

   unless stealthed() and subtletystealthedshortcdpostconditions() or enemies() < 6 and fightremains() > 6 and buffremaining(slice_and_dice) < gcd() and combopoints() >= 4 - { timeincombat() < 10 } * 2 and spell(slice_and_dice)
   {
    #variable,name=use_priority_rotation,value=priority_rotation&spell_targets.shuriken_storm>=2
    #call_action_list,name=stealth_cds,if=variable.use_priority_rotation
    if use_priority_rotation() subtletystealth_cdsshortcdactions()

    unless use_priority_rotation() and subtletystealth_cdsshortcdpostconditions()
    {
     #variable,name=stealth_threshold,value=25+talent.vigor.enabled*20+talent.master_of_shadows.enabled*20+talent.shadow_focus.enabled*25+talent.alacrity.enabled*20+25*(spell_targets.shuriken_storm>=4)
     #call_action_list,name=stealth_cds,if=energy.deficit<=variable.stealth_threshold
     if energydeficit() <= stealth_threshold() subtletystealth_cdsshortcdactions()

     unless energydeficit() <= stealth_threshold() and subtletystealth_cdsshortcdpostconditions()
     {
      #call_action_list,name=finish,if=runeforge.deathly_shadows.equipped&dot.sepsis.ticking&dot.sepsis.remains<=2&combo_points>=2
      if message("runeforge.deathly_shadows.equipped is not implemented") and target.debuffpresent(sepsis) and target.debuffremaining(sepsis) <= 2 and combopoints() >= 2 subtletyfinishshortcdactions()

      unless message("runeforge.deathly_shadows.equipped is not implemented") and target.debuffpresent(sepsis) and target.debuffremaining(sepsis) <= 2 and combopoints() >= 2 and subtletyfinishshortcdpostconditions()
      {
       #call_action_list,name=finish,if=cooldown.symbols_of_death.remains<=2&combo_points>=2&runeforge.the_rotten.equipped
       if spellcooldown(symbols_of_death) <= 2 and combopoints() >= 2 and message("runeforge.the_rotten.equipped is not implemented") subtletyfinishshortcdactions()

       unless spellcooldown(symbols_of_death) <= 2 and combopoints() >= 2 and message("runeforge.the_rotten.equipped is not implemented") and subtletyfinishshortcdpostconditions()
       {
        #call_action_list,name=finish,if=combo_points=animacharged_cp
        if combopoints() == message("animacharged_cp is not implemented") subtletyfinishshortcdactions()

        unless combopoints() == message("animacharged_cp is not implemented") and subtletyfinishshortcdpostconditions()
        {
         #call_action_list,name=finish,if=combo_points.deficit<=1|fight_remains<=1&combo_points>=3
         if combopointsdeficit() <= 1 or fightremains() <= 1 and combopoints() >= 3 subtletyfinishshortcdactions()

         unless { combopointsdeficit() <= 1 or fightremains() <= 1 and combopoints() >= 3 } and subtletyfinishshortcdpostconditions()
         {
          #call_action_list,name=finish,if=spell_targets.shuriken_storm=4&combo_points>=4
          if enemies() == 4 and combopoints() >= 4 subtletyfinishshortcdactions()

          unless enemies() == 4 and combopoints() >= 4 and subtletyfinishshortcdpostconditions()
          {
           #call_action_list,name=build,if=energy.deficit<=variable.stealth_threshold
           if energydeficit() <= stealth_threshold() subtletybuildshortcdactions()

           unless energydeficit() <= stealth_threshold() and subtletybuildshortcdpostconditions()
           {
            #bag_of_tricks
            spell(bag_of_tricks)
           }
          }
         }
        }
       }
      }
     }
    }
   }
  }
 }
}

AddFunction subtlety_defaultshortcdpostconditions
{
 spell(stealth) or subtletycdsshortcdpostconditions() or stealthed() and subtletystealthedshortcdpostconditions() or enemies() < 6 and fightremains() > 6 and buffremaining(slice_and_dice) < gcd() and combopoints() >= 4 - { timeincombat() < 10 } * 2 and spell(slice_and_dice) or use_priority_rotation() and subtletystealth_cdsshortcdpostconditions() or energydeficit() <= stealth_threshold() and subtletystealth_cdsshortcdpostconditions() or message("runeforge.deathly_shadows.equipped is not implemented") and target.debuffpresent(sepsis) and target.debuffremaining(sepsis) <= 2 and combopoints() >= 2 and subtletyfinishshortcdpostconditions() or spellcooldown(symbols_of_death) <= 2 and combopoints() >= 2 and message("runeforge.the_rotten.equipped is not implemented") and subtletyfinishshortcdpostconditions() or combopoints() == message("animacharged_cp is not implemented") and subtletyfinishshortcdpostconditions() or { combopointsdeficit() <= 1 or fightremains() <= 1 and combopoints() >= 3 } and subtletyfinishshortcdpostconditions() or enemies() == 4 and combopoints() >= 4 and subtletyfinishshortcdpostconditions() or energydeficit() <= stealth_threshold() and subtletybuildshortcdpostconditions()
}

AddFunction subtlety_defaultcdactions
{
 subtletyinterruptactions()

 unless spell(stealth)
 {
  #variable,name=snd_condition,value=buff.slice_and_dice.up|spell_targets.shuriken_storm>=6
  #call_action_list,name=cds
  subtletycdscdactions()

  unless subtletycdscdpostconditions()
  {
   #run_action_list,name=stealthed,if=stealthed.all
   if stealthed() subtletystealthedcdactions()

   unless stealthed() and subtletystealthedcdpostconditions() or enemies() < 6 and fightremains() > 6 and buffremaining(slice_and_dice) < gcd() and combopoints() >= 4 - { timeincombat() < 10 } * 2 and spell(slice_and_dice)
   {
    #variable,name=use_priority_rotation,value=priority_rotation&spell_targets.shuriken_storm>=2
    #call_action_list,name=stealth_cds,if=variable.use_priority_rotation
    if use_priority_rotation() subtletystealth_cdscdactions()

    unless use_priority_rotation() and subtletystealth_cdscdpostconditions()
    {
     #variable,name=stealth_threshold,value=25+talent.vigor.enabled*20+talent.master_of_shadows.enabled*20+talent.shadow_focus.enabled*25+talent.alacrity.enabled*20+25*(spell_targets.shuriken_storm>=4)
     #call_action_list,name=stealth_cds,if=energy.deficit<=variable.stealth_threshold
     if energydeficit() <= stealth_threshold() subtletystealth_cdscdactions()

     unless energydeficit() <= stealth_threshold() and subtletystealth_cdscdpostconditions()
     {
      #call_action_list,name=finish,if=runeforge.deathly_shadows.equipped&dot.sepsis.ticking&dot.sepsis.remains<=2&combo_points>=2
      if message("runeforge.deathly_shadows.equipped is not implemented") and target.debuffpresent(sepsis) and target.debuffremaining(sepsis) <= 2 and combopoints() >= 2 subtletyfinishcdactions()

      unless message("runeforge.deathly_shadows.equipped is not implemented") and target.debuffpresent(sepsis) and target.debuffremaining(sepsis) <= 2 and combopoints() >= 2 and subtletyfinishcdpostconditions()
      {
       #call_action_list,name=finish,if=cooldown.symbols_of_death.remains<=2&combo_points>=2&runeforge.the_rotten.equipped
       if spellcooldown(symbols_of_death) <= 2 and combopoints() >= 2 and message("runeforge.the_rotten.equipped is not implemented") subtletyfinishcdactions()

       unless spellcooldown(symbols_of_death) <= 2 and combopoints() >= 2 and message("runeforge.the_rotten.equipped is not implemented") and subtletyfinishcdpostconditions()
       {
        #call_action_list,name=finish,if=combo_points=animacharged_cp
        if combopoints() == message("animacharged_cp is not implemented") subtletyfinishcdactions()

        unless combopoints() == message("animacharged_cp is not implemented") and subtletyfinishcdpostconditions()
        {
         #call_action_list,name=finish,if=combo_points.deficit<=1|fight_remains<=1&combo_points>=3
         if combopointsdeficit() <= 1 or fightremains() <= 1 and combopoints() >= 3 subtletyfinishcdactions()

         unless { combopointsdeficit() <= 1 or fightremains() <= 1 and combopoints() >= 3 } and subtletyfinishcdpostconditions()
         {
          #call_action_list,name=finish,if=spell_targets.shuriken_storm=4&combo_points>=4
          if enemies() == 4 and combopoints() >= 4 subtletyfinishcdactions()

          unless enemies() == 4 and combopoints() >= 4 and subtletyfinishcdpostconditions()
          {
           #call_action_list,name=build,if=energy.deficit<=variable.stealth_threshold
           if energydeficit() <= stealth_threshold() subtletybuildcdactions()

           unless energydeficit() <= stealth_threshold() and subtletybuildcdpostconditions()
           {
            #arcane_torrent,if=energy.deficit>=15+energy.regen
            if energydeficit() >= 15 + energyregenrate() spell(arcane_torrent)
            #arcane_pulse
            spell(arcane_pulse)
            #lights_judgment
            spell(lights_judgment)
           }
          }
         }
        }
       }
      }
     }
    }
   }
  }
 }
}

AddFunction subtlety_defaultcdpostconditions
{
 spell(stealth) or subtletycdscdpostconditions() or stealthed() and subtletystealthedcdpostconditions() or enemies() < 6 and fightremains() > 6 and buffremaining(slice_and_dice) < gcd() and combopoints() >= 4 - { timeincombat() < 10 } * 2 and spell(slice_and_dice) or use_priority_rotation() and subtletystealth_cdscdpostconditions() or energydeficit() <= stealth_threshold() and subtletystealth_cdscdpostconditions() or message("runeforge.deathly_shadows.equipped is not implemented") and target.debuffpresent(sepsis) and target.debuffremaining(sepsis) <= 2 and combopoints() >= 2 and subtletyfinishcdpostconditions() or spellcooldown(symbols_of_death) <= 2 and combopoints() >= 2 and message("runeforge.the_rotten.equipped is not implemented") and subtletyfinishcdpostconditions() or combopoints() == message("animacharged_cp is not implemented") and subtletyfinishcdpostconditions() or { combopointsdeficit() <= 1 or fightremains() <= 1 and combopoints() >= 3 } and subtletyfinishcdpostconditions() or enemies() == 4 and combopoints() >= 4 and subtletyfinishcdpostconditions() or energydeficit() <= stealth_threshold() and subtletybuildcdpostconditions() or spell(bag_of_tricks)
}

### Subtlety icons.

AddCheckBox(opt_rogue_subtlety_aoe l(aoe) default specialization=subtlety)

AddIcon checkbox=!opt_rogue_subtlety_aoe enemies=1 help=shortcd specialization=subtlety
{
 if not incombat() subtletyprecombatshortcdactions()
 subtlety_defaultshortcdactions()
}

AddIcon checkbox=opt_rogue_subtlety_aoe help=shortcd specialization=subtlety
{
 if not incombat() subtletyprecombatshortcdactions()
 subtlety_defaultshortcdactions()
}

AddIcon enemies=1 help=main specialization=subtlety
{
 if not incombat() subtletyprecombatmainactions()
 subtlety_defaultmainactions()
}

AddIcon checkbox=opt_rogue_subtlety_aoe help=aoe specialization=subtlety
{
 if not incombat() subtletyprecombatmainactions()
 subtlety_defaultmainactions()
}

AddIcon checkbox=!opt_rogue_subtlety_aoe enemies=1 help=cd specialization=subtlety
{
 if not incombat() subtletyprecombatcdactions()
 subtlety_defaultcdactions()
}

AddIcon checkbox=opt_rogue_subtlety_aoe help=cd specialization=subtlety
{
 if not incombat() subtletyprecombatcdactions()
 subtlety_defaultcdactions()
}

### Required symbols
# alacrity_talent
# ancestral_call
# arcane_pulse
# arcane_torrent
# backstab
# bag_of_tricks
# berserking
# blade_in_the_shadows_trait
# blood_fury
# blood_of_the_enemy
# blood_of_the_enemy_essence_id
# bloodlust
# breath_of_the_dying_essence_id
# cheap_shot
# concentrated_flame
# concentrated_flame_burn_debuff
# conductive_ink_debuff
# dark_shadow_talent
# deathly_shadows_buff
# deeper_stratagem_talent
# echoing_reprimand
# enveloping_shadows_talent
# eviscerate
# find_weakness
# fireblood
# flagellation
# flagellation_cleanse
# focused_azerite_beam
# gloomblade
# gloomblade_talent
# guardian_of_azeroth
# inevitability_trait
# kick
# kidney_shot
# lights_judgment
# marked_for_death
# master_assassin_buff
# master_of_shadows_talent
# memory_of_lucid_dreams
# nightstalker_talent
# perforate_trait
# perforated_veins_buff
# premeditation
# purifying_blast
# quaking_palm
# razor_coral
# reaping_flames
# reckless_force_buff
# reckless_force_counter
# ripple_in_space
# rupture
# secret_technique
# sepsis
# serrated_bone_spike
# serrated_bone_spike_dot_debuff
# shadow_blades
# shadow_blades_buff
# shadow_dance
# shadow_focus_talent
# shadowmeld
# shadowstep
# shadowstrike
# shuriken_storm
# shuriken_tornado
# shuriken_tornado_talent
# slice_and_dice
# stealth
# subterfuge_talent
# symbols_of_death
# the_rotten_buff
# the_unbound_force
# unbridled_fury_item
# vanish
# vigor_talent
# weaponmaster_talent
# worldvein_resonance
]]
        OvaleScripts:RegisterScript("ROGUE", "subtlety", name, desc, code, "script")
    end
end
