local __exports = LibStub:NewLibrary("ovale/scripts/ovale_warrior", 80300)
if not __exports then return end
__exports.registerWarrior = function(OvaleScripts)
    do
        local name = "sc_t25_warrior_arms"
        local desc = "[9.0] Simulationcraft: T25_Warrior_Arms"
        local code = [[
# Based on SimulationCraft profile "T25_Warrior_Arms".
#	class=warrior
#	spec=arms
#	talents=3122211

Include(ovale_common)
Include(ovale_warrior_spells)

AddCheckBox(opt_interrupt l(interrupt) default specialization=arms)
AddCheckBox(opt_melee_range l(not_in_melee_range) specialization=arms)

AddFunction armsinterruptactions
{
 if checkboxon(opt_interrupt) and not target.isfriend() and target.casting()
 {
  if target.inrange(pummel) and target.isinterruptible() spell(pummel)
  if target.distance(less 10) and not target.classification(worldboss) spell(shockwave)
  if target.inrange(storm_bolt) and not target.classification(worldboss) spell(storm_bolt)
  if target.inrange(quaking_palm) and not target.classification(worldboss) spell(quaking_palm)
  if target.distance(less 5) and not target.classification(worldboss) spell(war_stomp)
  if target.inrange(intimidating_shout) and not target.classification(worldboss) spell(intimidating_shout)
 }
}

AddFunction armsuseitemactions
{
 item(trinket0slot text=13 usable=1)
 item(trinket1slot text=14 usable=1)
}

AddFunction armsgetinmeleerange
{
 if checkboxon(opt_melee_range) and not inflighttotarget(charge) and not inflighttotarget(heroic_leap) and not target.inrange(pummel)
 {
  if target.inrange(charge) spell(charge)
  if spellcharges(charge) == 0 and target.distance(atleast 8) and target.distance(atmost 40) spell(heroic_leap)
  texture(misc_arrowlup help=l(not_in_melee_range))
 }
}

### actions.single_target

AddFunction armssingle_targetmainactions
{
 #rend,if=remains<=duration*0.3
 if buffremaining(rend) <= baseduration(rend) * 0.3 spell(rend)
 #skullsplitter,if=rage<60&buff.deadly_calm.down&buff.memory_of_lucid_dreams.down|rage<20
 if rage() < 60 and buffexpires(deadly_calm) and buffexpires(memory_of_lucid_dreams) or rage() < 20 spell(skullsplitter)
 #mortal_strike,if=dot.deep_wounds.remains<=duration*0.3&(spell_targets.whirlwind=1|!talent.cleave.enabled)
 if target.debuffremaining(deep_wounds) <= baseduration(mortal_strike) * 0.3 and { enemies() == 1 or not hastalent(cleave_talent) } spell(mortal_strike)
 #cleave,if=spell_targets.whirlwind>2&dot.deep_wounds.remains<=duration*0.3
 if enemies() > 2 and target.debuffremaining(deep_wounds) <= baseduration(cleave) * 0.3 spell(cleave)
 #execute,if=buff.sudden_death.react
 if buffpresent(sudden_death) spell(execute)
 #mortal_strike,if=spell_targets.whirlwind=1|!talent.cleave.enabled
 if enemies() == 1 or not hastalent(cleave_talent) spell(mortal_strike)
 #cleave,if=spell_targets.whirlwind>2
 if enemies() > 2 spell(cleave)
 #whirlwind,if=(((buff.memory_of_lucid_dreams.up)|(debuff.colossus_smash.up)|(buff.deadly_calm.up))&talent.fervor_of_battle.enabled)|((buff.memory_of_lucid_dreams.up|rage>89)&debuff.colossus_smash.up&buff.test_of_might.down&!talent.fervor_of_battle.enabled)
 if { buffpresent(memory_of_lucid_dreams) or target.debuffpresent(colossus_smash) or buffpresent(deadly_calm) } and hastalent(fervor_of_battle_talent) or { buffpresent(memory_of_lucid_dreams) or rage() > 89 } and target.debuffpresent(colossus_smash) and buffexpires(test_of_might_buff) and not hastalent(fervor_of_battle_talent) spell(whirlwind)
 #slam,if=!talent.fervor_of_battle.enabled&(buff.memory_of_lucid_dreams.up|debuff.colossus_smash.up)
 if not hastalent(fervor_of_battle_talent) and { buffpresent(memory_of_lucid_dreams) or target.debuffpresent(colossus_smash) } spell(slam)
 #overpower
 spell(overpower)
 #whirlwind,if=talent.fervor_of_battle.enabled&(buff.test_of_might.up|debuff.colossus_smash.down&buff.test_of_might.down&rage>60)
 if hastalent(fervor_of_battle_talent) and { buffpresent(test_of_might_buff) or target.debuffexpires(colossus_smash) and buffexpires(test_of_might_buff) and rage() > 60 } spell(whirlwind)
 #slam,if=!talent.fervor_of_battle.enabled
 if not hastalent(fervor_of_battle_talent) spell(slam)
}

AddFunction armssingle_targetmainpostconditions
{
}

AddFunction armssingle_targetshortcdactions
{
 unless buffremaining(rend) <= baseduration(rend) * 0.3 and spell(rend)
 {
  #deadly_calm
  spell(deadly_calm)

  unless { rage() < 60 and buffexpires(deadly_calm) and buffexpires(memory_of_lucid_dreams) or rage() < 20 } and spell(skullsplitter)
  {
   #ravager,if=(cooldown.colossus_smash.remains<2|(talent.warbreaker.enabled&cooldown.warbreaker.remains<2))
   if spellcooldown(colossus_smash) < 2 or hastalent(warbreaker_talent) and spellcooldown(warbreaker) < 2 spell(ravager)

   unless target.debuffremaining(deep_wounds) <= baseduration(mortal_strike) * 0.3 and { enemies() == 1 or not hastalent(cleave_talent) } and spell(mortal_strike) or enemies() > 2 and target.debuffremaining(deep_wounds) <= baseduration(cleave) * 0.3 and spell(cleave)
   {
    #colossus_smash,if=!essence.condensed_lifeforce.enabled&!talent.massacre.enabled&(target.time_to_pct_20>10|target.time_to_die>50)|essence.condensed_lifeforce.enabled&!talent.massacre.enabled&(target.time_to_pct_20>10|target.time_to_die>80)|talent.massacre.enabled&(target.time_to_pct_35>10|target.time_to_die>50)
    if not azeriteessenceisenabled(condensed_lifeforce_essence_id) and not hastalent(massacre_talent_arms) and { target.timetohealthpercent(20) > 10 or target.timetodie() > 50 } or azeriteessenceisenabled(condensed_lifeforce_essence_id) and not hastalent(massacre_talent_arms) and { target.timetohealthpercent(20) > 10 or target.timetodie() > 80 } or hastalent(massacre_talent_arms) and { target.timetohealthpercent(35) > 10 or target.timetodie() > 50 } spell(colossus_smash)

    unless buffpresent(sudden_death) and spell(execute)
    {
     #bladestorm,if=cooldown.mortal_strike.remains&debuff.colossus_smash.down&(!talent.deadly_calm.enabled|buff.deadly_calm.down)&((debuff.colossus_smash.up&!azerite.test_of_might.enabled)|buff.test_of_might.up)&buff.memory_of_lucid_dreams.down&rage<40
     if spellcooldown(mortal_strike) > 0 and target.debuffexpires(colossus_smash) and { not hastalent(deadly_calm_talent) or buffexpires(deadly_calm) } and { target.debuffpresent(colossus_smash) and not hasazeritetrait(test_of_might_trait) or buffpresent(test_of_might_buff) } and buffexpires(memory_of_lucid_dreams) and rage() < 40 spell(bladestorm)
    }
   }
  }
 }
}

AddFunction armssingle_targetshortcdpostconditions
{
 buffremaining(rend) <= baseduration(rend) * 0.3 and spell(rend) or { rage() < 60 and buffexpires(deadly_calm) and buffexpires(memory_of_lucid_dreams) or rage() < 20 } and spell(skullsplitter) or target.debuffremaining(deep_wounds) <= baseduration(mortal_strike) * 0.3 and { enemies() == 1 or not hastalent(cleave_talent) } and spell(mortal_strike) or enemies() > 2 and target.debuffremaining(deep_wounds) <= baseduration(cleave) * 0.3 and spell(cleave) or buffpresent(sudden_death) and spell(execute) or { enemies() == 1 or not hastalent(cleave_talent) } and spell(mortal_strike) or enemies() > 2 and spell(cleave) or { { buffpresent(memory_of_lucid_dreams) or target.debuffpresent(colossus_smash) or buffpresent(deadly_calm) } and hastalent(fervor_of_battle_talent) or { buffpresent(memory_of_lucid_dreams) or rage() > 89 } and target.debuffpresent(colossus_smash) and buffexpires(test_of_might_buff) and not hastalent(fervor_of_battle_talent) } and spell(whirlwind) or not hastalent(fervor_of_battle_talent) and { buffpresent(memory_of_lucid_dreams) or target.debuffpresent(colossus_smash) } and spell(slam) or spell(overpower) or hastalent(fervor_of_battle_talent) and { buffpresent(test_of_might_buff) or target.debuffexpires(colossus_smash) and buffexpires(test_of_might_buff) and rage() > 60 } and spell(whirlwind) or not hastalent(fervor_of_battle_talent) and spell(slam)
}

AddFunction armssingle_targetcdactions
{
}

AddFunction armssingle_targetcdpostconditions
{
 buffremaining(rend) <= baseduration(rend) * 0.3 and spell(rend) or spell(deadly_calm) or { rage() < 60 and buffexpires(deadly_calm) and buffexpires(memory_of_lucid_dreams) or rage() < 20 } and spell(skullsplitter) or { spellcooldown(colossus_smash) < 2 or hastalent(warbreaker_talent) and spellcooldown(warbreaker) < 2 } and spell(ravager) or target.debuffremaining(deep_wounds) <= baseduration(mortal_strike) * 0.3 and { enemies() == 1 or not hastalent(cleave_talent) } and spell(mortal_strike) or enemies() > 2 and target.debuffremaining(deep_wounds) <= baseduration(cleave) * 0.3 and spell(cleave) or { not azeriteessenceisenabled(condensed_lifeforce_essence_id) and not hastalent(massacre_talent_arms) and { target.timetohealthpercent(20) > 10 or target.timetodie() > 50 } or azeriteessenceisenabled(condensed_lifeforce_essence_id) and not hastalent(massacre_talent_arms) and { target.timetohealthpercent(20) > 10 or target.timetodie() > 80 } or hastalent(massacre_talent_arms) and { target.timetohealthpercent(35) > 10 or target.timetodie() > 50 } } and spell(colossus_smash) or buffpresent(sudden_death) and spell(execute) or spellcooldown(mortal_strike) > 0 and target.debuffexpires(colossus_smash) and { not hastalent(deadly_calm_talent) or buffexpires(deadly_calm) } and { target.debuffpresent(colossus_smash) and not hasazeritetrait(test_of_might_trait) or buffpresent(test_of_might_buff) } and buffexpires(memory_of_lucid_dreams) and rage() < 40 and spell(bladestorm) or { enemies() == 1 or not hastalent(cleave_talent) } and spell(mortal_strike) or enemies() > 2 and spell(cleave) or { { buffpresent(memory_of_lucid_dreams) or target.debuffpresent(colossus_smash) or buffpresent(deadly_calm) } and hastalent(fervor_of_battle_talent) or { buffpresent(memory_of_lucid_dreams) or rage() > 89 } and target.debuffpresent(colossus_smash) and buffexpires(test_of_might_buff) and not hastalent(fervor_of_battle_talent) } and spell(whirlwind) or not hastalent(fervor_of_battle_talent) and { buffpresent(memory_of_lucid_dreams) or target.debuffpresent(colossus_smash) } and spell(slam) or spell(overpower) or hastalent(fervor_of_battle_talent) and { buffpresent(test_of_might_buff) or target.debuffexpires(colossus_smash) and buffexpires(test_of_might_buff) and rage() > 60 } and spell(whirlwind) or not hastalent(fervor_of_battle_talent) and spell(slam)
}

### actions.precombat

AddFunction armsprecombatmainactions
{
 #worldvein_resonance
 spell(worldvein_resonance)
 #memory_of_lucid_dreams
 spell(memory_of_lucid_dreams)
}

AddFunction armsprecombatmainpostconditions
{
}

AddFunction armsprecombatshortcdactions
{
}

AddFunction armsprecombatshortcdpostconditions
{
 spell(worldvein_resonance) or spell(memory_of_lucid_dreams)
}

AddFunction armsprecombatcdactions
{
 #flask
 #food
 #augmentation
 #snapshot_stats
 #use_item,name=azsharas_font_of_power
 armsuseitemactions()

 unless spell(worldvein_resonance) or spell(memory_of_lucid_dreams)
 {
  #guardian_of_azeroth
  spell(guardian_of_azeroth)
 }
}

AddFunction armsprecombatcdpostconditions
{
 spell(worldvein_resonance) or spell(memory_of_lucid_dreams)
}

### actions.execute

AddFunction armsexecutemainactions
{
 #rend,if=remains<=duration*0.3
 if buffremaining(rend) <= baseduration(rend) * 0.3 spell(rend)
 #skullsplitter,if=rage<52&buff.memory_of_lucid_dreams.down|rage<20
 if rage() < 52 and buffexpires(memory_of_lucid_dreams) or rage() < 20 spell(skullsplitter)
 #mortal_strike,if=dot.deep_wounds.remains<=duration*0.3&(spell_targets.whirlwind=1|!spell_targets.whirlwind>1&!talent.cleave.enabled)
 if target.debuffremaining(deep_wounds) <= baseduration(mortal_strike) * 0.3 and { enemies() == 1 or not enemies() > 1 and not hastalent(cleave_talent) } spell(mortal_strike)
 #cleave,if=(spell_targets.whirlwind>2&dot.deep_wounds.remains<=duration*0.3)|(spell_targets.whirlwind>3)
 if enemies() > 2 and target.debuffremaining(deep_wounds) <= baseduration(cleave) * 0.3 or enemies() > 3 spell(cleave)
 #execute,if=buff.memory_of_lucid_dreams.up|buff.deadly_calm.up|debuff.colossus_smash.up|buff.test_of_might.up
 if buffpresent(memory_of_lucid_dreams) or buffpresent(deadly_calm) or target.debuffpresent(colossus_smash) or buffpresent(test_of_might_buff) spell(execute)
 #slam,if=buff.crushing_assault.up&buff.memory_of_lucid_dreams.down
 if buffpresent(crushing_assault_buff) and buffexpires(memory_of_lucid_dreams) spell(slam)
 #overpower
 spell(overpower)
 #execute
 spell(execute)
}

AddFunction armsexecutemainpostconditions
{
}

AddFunction armsexecuteshortcdactions
{
 unless buffremaining(rend) <= baseduration(rend) * 0.3 and spell(rend)
 {
  #deadly_calm
  spell(deadly_calm)

  unless { rage() < 52 and buffexpires(memory_of_lucid_dreams) or rage() < 20 } and spell(skullsplitter)
  {
   #ravager,,if=cooldown.colossus_smash.remains<2|(talent.warbreaker.enabled&cooldown.warbreaker.remains<2)
   if spellcooldown(colossus_smash) < 2 or hastalent(warbreaker_talent) and spellcooldown(warbreaker) < 2 spell(ravager)
   #colossus_smash,if=!essence.memory_of_lucid_dreams.major|(buff.memory_of_lucid_dreams.up|cooldown.memory_of_lucid_dreams.remains>10)
   if not azeriteessenceismajor(memory_of_lucid_dreams_essence_id) or buffpresent(memory_of_lucid_dreams) or spellcooldown(memory_of_lucid_dreams) > 10 spell(colossus_smash)
   #warbreaker,if=!essence.memory_of_lucid_dreams.major|(buff.memory_of_lucid_dreams.up|cooldown.memory_of_lucid_dreams.remains>10)
   if not azeriteessenceismajor(memory_of_lucid_dreams_essence_id) or buffpresent(memory_of_lucid_dreams) or spellcooldown(memory_of_lucid_dreams) > 10 spell(warbreaker)

   unless target.debuffremaining(deep_wounds) <= baseduration(mortal_strike) * 0.3 and { enemies() == 1 or not enemies() > 1 and not hastalent(cleave_talent) } and spell(mortal_strike) or { enemies() > 2 and target.debuffremaining(deep_wounds) <= baseduration(cleave) * 0.3 or enemies() > 3 } and spell(cleave)
   {
    #bladestorm,if=!buff.memory_of_lucid_dreams.up&buff.test_of_might.up&rage<30&!buff.deadly_calm.up
    if not buffpresent(memory_of_lucid_dreams) and buffpresent(test_of_might_buff) and rage() < 30 and not buffpresent(deadly_calm) spell(bladestorm)
   }
  }
 }
}

AddFunction armsexecuteshortcdpostconditions
{
 buffremaining(rend) <= baseduration(rend) * 0.3 and spell(rend) or { rage() < 52 and buffexpires(memory_of_lucid_dreams) or rage() < 20 } and spell(skullsplitter) or target.debuffremaining(deep_wounds) <= baseduration(mortal_strike) * 0.3 and { enemies() == 1 or not enemies() > 1 and not hastalent(cleave_talent) } and spell(mortal_strike) or { enemies() > 2 and target.debuffremaining(deep_wounds) <= baseduration(cleave) * 0.3 or enemies() > 3 } and spell(cleave) or { buffpresent(memory_of_lucid_dreams) or buffpresent(deadly_calm) or target.debuffpresent(colossus_smash) or buffpresent(test_of_might_buff) } and spell(execute) or buffpresent(crushing_assault_buff) and buffexpires(memory_of_lucid_dreams) and spell(slam) or spell(overpower) or spell(execute)
}

AddFunction armsexecutecdactions
{
}

AddFunction armsexecutecdpostconditions
{
 buffremaining(rend) <= baseduration(rend) * 0.3 and spell(rend) or spell(deadly_calm) or { rage() < 52 and buffexpires(memory_of_lucid_dreams) or rage() < 20 } and spell(skullsplitter) or { spellcooldown(colossus_smash) < 2 or hastalent(warbreaker_talent) and spellcooldown(warbreaker) < 2 } and spell(ravager) or { not azeriteessenceismajor(memory_of_lucid_dreams_essence_id) or buffpresent(memory_of_lucid_dreams) or spellcooldown(memory_of_lucid_dreams) > 10 } and spell(colossus_smash) or { not azeriteessenceismajor(memory_of_lucid_dreams_essence_id) or buffpresent(memory_of_lucid_dreams) or spellcooldown(memory_of_lucid_dreams) > 10 } and spell(warbreaker) or target.debuffremaining(deep_wounds) <= baseduration(mortal_strike) * 0.3 and { enemies() == 1 or not enemies() > 1 and not hastalent(cleave_talent) } and spell(mortal_strike) or { enemies() > 2 and target.debuffremaining(deep_wounds) <= baseduration(cleave) * 0.3 or enemies() > 3 } and spell(cleave) or not buffpresent(memory_of_lucid_dreams) and buffpresent(test_of_might_buff) and rage() < 30 and not buffpresent(deadly_calm) and spell(bladestorm) or { buffpresent(memory_of_lucid_dreams) or buffpresent(deadly_calm) or target.debuffpresent(colossus_smash) or buffpresent(test_of_might_buff) } and spell(execute) or buffpresent(crushing_assault_buff) and buffexpires(memory_of_lucid_dreams) and spell(slam) or spell(overpower) or spell(execute)
}

### actions.default

AddFunction arms_defaultmainactions
{
 #charge
 if checkboxon(opt_melee_range) and target.inrange(charge) and not target.inrange(pummel) spell(charge)
 #berserking,if=buff.memory_of_lucid_dreams.up|(!essence.memory_of_lucid_dreams.major&debuff.colossus_smash.up)
 if buffpresent(memory_of_lucid_dreams) or not azeriteessenceismajor(memory_of_lucid_dreams_essence_id) and target.debuffpresent(colossus_smash) spell(berserking)
 #blood_of_the_enemy,if=buff.test_of_might.up|(debuff.colossus_smash.up&!azerite.test_of_might.enabled)
 if buffpresent(test_of_might_buff) or target.debuffpresent(colossus_smash) and not hasazeritetrait(test_of_might_trait) spell(blood_of_the_enemy)
 #ripple_in_space,if=!debuff.colossus_smash.up&!buff.test_of_might.up
 if not target.debuffpresent(colossus_smash) and not buffpresent(test_of_might_buff) spell(ripple_in_space)
 #worldvein_resonance,if=!debuff.colossus_smash.up&!buff.test_of_might.up
 if not target.debuffpresent(colossus_smash) and not buffpresent(test_of_might_buff) spell(worldvein_resonance)
 #concentrated_flame,if=!debuff.colossus_smash.up&!buff.test_of_might.up&dot.concentrated_flame_burn.remains=0
 if not target.debuffpresent(colossus_smash) and not buffpresent(test_of_might_buff) and not target.debuffremaining(concentrated_flame_burn_debuff) > 0 spell(concentrated_flame)
 #the_unbound_force,if=buff.reckless_force.up
 if buffpresent(reckless_force_buff) spell(the_unbound_force)
 #memory_of_lucid_dreams,if=!talent.warbreaker.enabled&cooldown.colossus_smash.remains<gcd&(target.time_to_die>150|target.health.pct<20)
 if not hastalent(warbreaker_talent) and spellcooldown(colossus_smash) < gcd() and { target.timetodie() > 150 or target.healthpercent() < 20 } spell(memory_of_lucid_dreams)
 #memory_of_lucid_dreams,if=talent.warbreaker.enabled&cooldown.warbreaker.remains<gcd&(target.time_to_die>150|target.health.pct<20)
 if hastalent(warbreaker_talent) and spellcooldown(warbreaker) < gcd() and { target.timetodie() > 150 or target.healthpercent() < 20 } spell(memory_of_lucid_dreams)
 #run_action_list,name=execute,if=(talent.massacre.enabled&target.health.pct<35)|target.health.pct<20
 if hastalent(massacre_talent_arms) and target.healthpercent() < 35 or target.healthpercent() < 20 armsexecutemainactions()

 unless { hastalent(massacre_talent_arms) and target.healthpercent() < 35 or target.healthpercent() < 20 } and armsexecutemainpostconditions()
 {
  #run_action_list,name=single_target
  armssingle_targetmainactions()
 }
}

AddFunction arms_defaultmainpostconditions
{
 { hastalent(massacre_talent_arms) and target.healthpercent() < 35 or target.healthpercent() < 20 } and armsexecutemainpostconditions() or armssingle_targetmainpostconditions()
}

AddFunction arms_defaultshortcdactions
{
 unless checkboxon(opt_melee_range) and target.inrange(charge) and not target.inrange(pummel) and spell(charge)
 {
  #auto_attack
  armsgetinmeleerange()

  unless { buffpresent(memory_of_lucid_dreams) or not azeriteessenceismajor(memory_of_lucid_dreams_essence_id) and target.debuffpresent(colossus_smash) } and spell(berserking)
  {
   #bag_of_tricks,if=debuff.colossus_smash.down&buff.memory_of_lucid_dreams.down&cooldown.mortal_strike.remains
   if target.debuffexpires(colossus_smash) and buffexpires(memory_of_lucid_dreams) and spellcooldown(mortal_strike) > 0 spell(bag_of_tricks)
   #avatar,if=!essence.memory_of_lucid_dreams.major|(buff.memory_of_lucid_dreams.up|cooldown.memory_of_lucid_dreams.remains>45)
   if not azeriteessenceismajor(memory_of_lucid_dreams_essence_id) or buffpresent(memory_of_lucid_dreams) or spellcooldown(memory_of_lucid_dreams) > 45 spell(avatar)
   #sweeping_strikes,if=spell_targets.whirlwind>1&(cooldown.bladestorm.remains>10|cooldown.colossus_smash.remains>8|azerite.test_of_might.enabled)
   if enemies() > 1 and { spellcooldown(bladestorm) > 10 or spellcooldown(colossus_smash) > 8 or hasazeritetrait(test_of_might_trait) } spell(sweeping_strikes)

   unless { buffpresent(test_of_might_buff) or target.debuffpresent(colossus_smash) and not hasazeritetrait(test_of_might_trait) } and spell(blood_of_the_enemy)
   {
    #purifying_blast,if=!debuff.colossus_smash.up&!buff.test_of_might.up
    if not target.debuffpresent(colossus_smash) and not buffpresent(test_of_might_buff) spell(purifying_blast)

    unless not target.debuffpresent(colossus_smash) and not buffpresent(test_of_might_buff) and spell(ripple_in_space) or not target.debuffpresent(colossus_smash) and not buffpresent(test_of_might_buff) and spell(worldvein_resonance)
    {
     #focused_azerite_beam,if=!debuff.colossus_smash.up&!buff.test_of_might.up
     if not target.debuffpresent(colossus_smash) and not buffpresent(test_of_might_buff) spell(focused_azerite_beam)
     #reaping_flames,if=!debuff.colossus_smash.up&!buff.test_of_might.up
     if not target.debuffpresent(colossus_smash) and not buffpresent(test_of_might_buff) spell(reaping_flames)

     unless not target.debuffpresent(colossus_smash) and not buffpresent(test_of_might_buff) and not target.debuffremaining(concentrated_flame_burn_debuff) > 0 and spell(concentrated_flame) or buffpresent(reckless_force_buff) and spell(the_unbound_force) or not hastalent(warbreaker_talent) and spellcooldown(colossus_smash) < gcd() and { target.timetodie() > 150 or target.healthpercent() < 20 } and spell(memory_of_lucid_dreams) or hastalent(warbreaker_talent) and spellcooldown(warbreaker) < gcd() and { target.timetodie() > 150 or target.healthpercent() < 20 } and spell(memory_of_lucid_dreams)
     {
      #run_action_list,name=execute,if=(talent.massacre.enabled&target.health.pct<35)|target.health.pct<20
      if hastalent(massacre_talent_arms) and target.healthpercent() < 35 or target.healthpercent() < 20 armsexecuteshortcdactions()

      unless { hastalent(massacre_talent_arms) and target.healthpercent() < 35 or target.healthpercent() < 20 } and armsexecuteshortcdpostconditions()
      {
       #run_action_list,name=single_target
       armssingle_targetshortcdactions()
      }
     }
    }
   }
  }
 }
}

AddFunction arms_defaultshortcdpostconditions
{
 checkboxon(opt_melee_range) and target.inrange(charge) and not target.inrange(pummel) and spell(charge) or { buffpresent(memory_of_lucid_dreams) or not azeriteessenceismajor(memory_of_lucid_dreams_essence_id) and target.debuffpresent(colossus_smash) } and spell(berserking) or { buffpresent(test_of_might_buff) or target.debuffpresent(colossus_smash) and not hasazeritetrait(test_of_might_trait) } and spell(blood_of_the_enemy) or not target.debuffpresent(colossus_smash) and not buffpresent(test_of_might_buff) and spell(ripple_in_space) or not target.debuffpresent(colossus_smash) and not buffpresent(test_of_might_buff) and spell(worldvein_resonance) or not target.debuffpresent(colossus_smash) and not buffpresent(test_of_might_buff) and not target.debuffremaining(concentrated_flame_burn_debuff) > 0 and spell(concentrated_flame) or buffpresent(reckless_force_buff) and spell(the_unbound_force) or not hastalent(warbreaker_talent) and spellcooldown(colossus_smash) < gcd() and { target.timetodie() > 150 or target.healthpercent() < 20 } and spell(memory_of_lucid_dreams) or hastalent(warbreaker_talent) and spellcooldown(warbreaker) < gcd() and { target.timetodie() > 150 or target.healthpercent() < 20 } and spell(memory_of_lucid_dreams) or { hastalent(massacre_talent_arms) and target.healthpercent() < 35 or target.healthpercent() < 20 } and armsexecuteshortcdpostconditions() or armssingle_targetshortcdpostconditions()
}

AddFunction arms_defaultcdactions
{
 armsinterruptactions()

 unless checkboxon(opt_melee_range) and target.inrange(charge) and not target.inrange(pummel) and spell(charge)
 {
  #blood_fury,if=buff.memory_of_lucid_dreams.remains<5|(!essence.memory_of_lucid_dreams.major&debuff.colossus_smash.up)
  if buffremaining(memory_of_lucid_dreams) < 5 or not azeriteessenceismajor(memory_of_lucid_dreams_essence_id) and target.debuffpresent(colossus_smash) spell(blood_fury)

  unless { buffpresent(memory_of_lucid_dreams) or not azeriteessenceismajor(memory_of_lucid_dreams_essence_id) and target.debuffpresent(colossus_smash) } and spell(berserking)
  {
   #arcane_torrent,if=cooldown.mortal_strike.remains>1.5&buff.memory_of_lucid_dreams.down&rage<50
   if spellcooldown(mortal_strike) > 1.5 and buffexpires(memory_of_lucid_dreams) and rage() < 50 spell(arcane_torrent)
   #lights_judgment,if=debuff.colossus_smash.down&buff.memory_of_lucid_dreams.down&cooldown.mortal_strike.remains
   if target.debuffexpires(colossus_smash) and buffexpires(memory_of_lucid_dreams) and spellcooldown(mortal_strike) > 0 spell(lights_judgment)
   #fireblood,if=buff.memory_of_lucid_dreams.remains<5|(!essence.memory_of_lucid_dreams.major&debuff.colossus_smash.up)
   if buffremaining(memory_of_lucid_dreams) < 5 or not azeriteessenceismajor(memory_of_lucid_dreams_essence_id) and target.debuffpresent(colossus_smash) spell(fireblood)
   #ancestral_call,if=buff.memory_of_lucid_dreams.remains<5|(!essence.memory_of_lucid_dreams.major&debuff.colossus_smash.up)
   if buffremaining(memory_of_lucid_dreams) < 5 or not azeriteessenceismajor(memory_of_lucid_dreams_essence_id) and target.debuffpresent(colossus_smash) spell(ancestral_call)

   unless target.debuffexpires(colossus_smash) and buffexpires(memory_of_lucid_dreams) and spellcooldown(mortal_strike) > 0 and spell(bag_of_tricks)
   {
    #use_item,name=ashvanes_razor_coral,if=!debuff.razor_coral_debuff.up|(target.health.pct<20.1&buff.memory_of_lucid_dreams.up&cooldown.memory_of_lucid_dreams.remains<117)|(target.health.pct<30.1&debuff.conductive_ink_debuff.up&!essence.memory_of_lucid_dreams.major)|(!debuff.conductive_ink_debuff.up&!essence.memory_of_lucid_dreams.major&debuff.colossus_smash.up)|target.time_to_die<30
    if not target.debuffpresent(razor_coral) or target.healthpercent() < 20.1 and buffpresent(memory_of_lucid_dreams) and spellcooldown(memory_of_lucid_dreams) < 117 or target.healthpercent() < 30.1 and target.debuffpresent(conductive_ink_debuff) and not azeriteessenceismajor(memory_of_lucid_dreams_essence_id) or not target.debuffpresent(conductive_ink_debuff) and not azeriteessenceismajor(memory_of_lucid_dreams_essence_id) and target.debuffpresent(colossus_smash) or target.timetodie() < 30 armsuseitemactions()

    unless { not azeriteessenceismajor(memory_of_lucid_dreams_essence_id) or buffpresent(memory_of_lucid_dreams) or spellcooldown(memory_of_lucid_dreams) > 45 } and spell(avatar) or enemies() > 1 and { spellcooldown(bladestorm) > 10 or spellcooldown(colossus_smash) > 8 or hasazeritetrait(test_of_might_trait) } and spell(sweeping_strikes) or { buffpresent(test_of_might_buff) or target.debuffpresent(colossus_smash) and not hasazeritetrait(test_of_might_trait) } and spell(blood_of_the_enemy) or not target.debuffpresent(colossus_smash) and not buffpresent(test_of_might_buff) and spell(purifying_blast) or not target.debuffpresent(colossus_smash) and not buffpresent(test_of_might_buff) and spell(ripple_in_space) or not target.debuffpresent(colossus_smash) and not buffpresent(test_of_might_buff) and spell(worldvein_resonance) or not target.debuffpresent(colossus_smash) and not buffpresent(test_of_might_buff) and spell(focused_azerite_beam) or not target.debuffpresent(colossus_smash) and not buffpresent(test_of_might_buff) and spell(reaping_flames) or not target.debuffpresent(colossus_smash) and not buffpresent(test_of_might_buff) and not target.debuffremaining(concentrated_flame_burn_debuff) > 0 and spell(concentrated_flame) or buffpresent(reckless_force_buff) and spell(the_unbound_force)
    {
     #guardian_of_azeroth,if=cooldown.colossus_smash.remains<10
     if spellcooldown(colossus_smash) < 10 spell(guardian_of_azeroth)

     unless not hastalent(warbreaker_talent) and spellcooldown(colossus_smash) < gcd() and { target.timetodie() > 150 or target.healthpercent() < 20 } and spell(memory_of_lucid_dreams) or hastalent(warbreaker_talent) and spellcooldown(warbreaker) < gcd() and { target.timetodie() > 150 or target.healthpercent() < 20 } and spell(memory_of_lucid_dreams)
     {
      #run_action_list,name=execute,if=(talent.massacre.enabled&target.health.pct<35)|target.health.pct<20
      if hastalent(massacre_talent_arms) and target.healthpercent() < 35 or target.healthpercent() < 20 armsexecutecdactions()

      unless { hastalent(massacre_talent_arms) and target.healthpercent() < 35 or target.healthpercent() < 20 } and armsexecutecdpostconditions()
      {
       #run_action_list,name=single_target
       armssingle_targetcdactions()
      }
     }
    }
   }
  }
 }
}

AddFunction arms_defaultcdpostconditions
{
 checkboxon(opt_melee_range) and target.inrange(charge) and not target.inrange(pummel) and spell(charge) or { buffpresent(memory_of_lucid_dreams) or not azeriteessenceismajor(memory_of_lucid_dreams_essence_id) and target.debuffpresent(colossus_smash) } and spell(berserking) or target.debuffexpires(colossus_smash) and buffexpires(memory_of_lucid_dreams) and spellcooldown(mortal_strike) > 0 and spell(bag_of_tricks) or { not azeriteessenceismajor(memory_of_lucid_dreams_essence_id) or buffpresent(memory_of_lucid_dreams) or spellcooldown(memory_of_lucid_dreams) > 45 } and spell(avatar) or enemies() > 1 and { spellcooldown(bladestorm) > 10 or spellcooldown(colossus_smash) > 8 or hasazeritetrait(test_of_might_trait) } and spell(sweeping_strikes) or { buffpresent(test_of_might_buff) or target.debuffpresent(colossus_smash) and not hasazeritetrait(test_of_might_trait) } and spell(blood_of_the_enemy) or not target.debuffpresent(colossus_smash) and not buffpresent(test_of_might_buff) and spell(purifying_blast) or not target.debuffpresent(colossus_smash) and not buffpresent(test_of_might_buff) and spell(ripple_in_space) or not target.debuffpresent(colossus_smash) and not buffpresent(test_of_might_buff) and spell(worldvein_resonance) or not target.debuffpresent(colossus_smash) and not buffpresent(test_of_might_buff) and spell(focused_azerite_beam) or not target.debuffpresent(colossus_smash) and not buffpresent(test_of_might_buff) and spell(reaping_flames) or not target.debuffpresent(colossus_smash) and not buffpresent(test_of_might_buff) and not target.debuffremaining(concentrated_flame_burn_debuff) > 0 and spell(concentrated_flame) or buffpresent(reckless_force_buff) and spell(the_unbound_force) or not hastalent(warbreaker_talent) and spellcooldown(colossus_smash) < gcd() and { target.timetodie() > 150 or target.healthpercent() < 20 } and spell(memory_of_lucid_dreams) or hastalent(warbreaker_talent) and spellcooldown(warbreaker) < gcd() and { target.timetodie() > 150 or target.healthpercent() < 20 } and spell(memory_of_lucid_dreams) or { hastalent(massacre_talent_arms) and target.healthpercent() < 35 or target.healthpercent() < 20 } and armsexecutecdpostconditions() or armssingle_targetcdpostconditions()
}

### Arms icons.

AddCheckBox(opt_warrior_arms_aoe l(aoe) default specialization=arms)

AddIcon checkbox=!opt_warrior_arms_aoe enemies=1 help=shortcd specialization=arms
{
 if not incombat() armsprecombatshortcdactions()
 arms_defaultshortcdactions()
}

AddIcon checkbox=opt_warrior_arms_aoe help=shortcd specialization=arms
{
 if not incombat() armsprecombatshortcdactions()
 arms_defaultshortcdactions()
}

AddIcon enemies=1 help=main specialization=arms
{
 if not incombat() armsprecombatmainactions()
 arms_defaultmainactions()
}

AddIcon checkbox=opt_warrior_arms_aoe help=aoe specialization=arms
{
 if not incombat() armsprecombatmainactions()
 arms_defaultmainactions()
}

AddIcon checkbox=!opt_warrior_arms_aoe enemies=1 help=cd specialization=arms
{
 if not incombat() armsprecombatcdactions()
 arms_defaultcdactions()
}

AddIcon checkbox=opt_warrior_arms_aoe help=cd specialization=arms
{
 if not incombat() armsprecombatcdactions()
 arms_defaultcdactions()
}

### Required symbols
# ancestral_call
# arcane_torrent
# avatar
# bag_of_tricks
# berserking
# bladestorm
# blood_fury
# blood_of_the_enemy
# charge
# cleave
# cleave_talent
# colossus_smash
# concentrated_flame
# concentrated_flame_burn_debuff
# condensed_lifeforce_essence_id
# conductive_ink_debuff
# crushing_assault_buff
# deadly_calm
# deadly_calm_talent
# deep_wounds
# execute
# fervor_of_battle_talent
# fireblood
# focused_azerite_beam
# guardian_of_azeroth
# heroic_leap
# intimidating_shout
# lights_judgment
# massacre_talent_arms
# memory_of_lucid_dreams
# memory_of_lucid_dreams_essence_id
# mortal_strike
# overpower
# pummel
# purifying_blast
# quaking_palm
# ravager
# razor_coral
# reaping_flames
# reckless_force_buff
# rend
# ripple_in_space
# shockwave
# skullsplitter
# slam
# storm_bolt
# sudden_death
# sweeping_strikes
# test_of_might_buff
# test_of_might_trait
# the_unbound_force
# war_stomp
# warbreaker
# warbreaker_talent
# whirlwind
# worldvein_resonance
]]
        OvaleScripts:RegisterScript("WARRIOR", "arms", name, desc, code, "script")
    end
    do
        local name = "sc_t25_warrior_fury"
        local desc = "[9.0] Simulationcraft: T25_Warrior_Fury"
        local code = [[
# Based on SimulationCraft profile "T25_Warrior_Fury".
#	class=warrior
#	spec=fury
#	talents=2133123

Include(ovale_common)
Include(ovale_warrior_spells)

AddCheckBox(opt_interrupt l(interrupt) default specialization=fury)
AddCheckBox(opt_melee_range l(not_in_melee_range) specialization=fury)

AddFunction furyinterruptactions
{
 if checkboxon(opt_interrupt) and not target.isfriend() and target.casting()
 {
  if target.inrange(pummel) and target.isinterruptible() spell(pummel)
  if target.distance(less 10) and not target.classification(worldboss) spell(shockwave)
  if target.inrange(storm_bolt) and not target.classification(worldboss) spell(storm_bolt)
  if target.inrange(quaking_palm) and not target.classification(worldboss) spell(quaking_palm)
  if target.distance(less 5) and not target.classification(worldboss) spell(war_stomp)
  if target.inrange(intimidating_shout) and not target.classification(worldboss) spell(intimidating_shout)
 }
}

AddFunction furyuseitemactions
{
 item(trinket0slot text=13 usable=1)
 item(trinket1slot text=14 usable=1)
}

AddFunction furygetinmeleerange
{
 if checkboxon(opt_melee_range) and not inflighttotarget(charge) and not inflighttotarget(heroic_leap) and not target.inrange(pummel)
 {
  if target.inrange(charge) spell(charge)
  if spellcharges(charge) == 0 and target.distance(atleast 8) and target.distance(atmost 40) spell(heroic_leap)
  texture(misc_arrowlup help=l(not_in_melee_range))
 }
}

### actions.single_target

AddFunction furysingle_targetmainactions
{
 #rampage,if=(buff.recklessness.up|buff.memory_of_lucid_dreams.up)|(buff.enrage.remains<gcd|rage>90)
 if buffpresent(recklessness) or buffpresent(memory_of_lucid_dreams) or enrageremaining() < gcd() or rage() > 90 spell(rampage)
 #execute
 spell(execute)
 #bloodthirst,if=buff.enrage.down|azerite.cold_steel_hot_blood.rank>1
 if not isenraged() or azeritetraitrank(cold_steel_hot_blood_trait) > 1 spell(bloodthirst)
 #onslaught
 spell(onslaught)
 #raging_blow,if=charges=2
 if charges(raging_blow) == 2 spell(raging_blow)
 #bloodthirst
 spell(bloodthirst)
 #raging_blow
 spell(raging_blow)
 #whirlwind
 spell(whirlwind)
}

AddFunction furysingle_targetmainpostconditions
{
}

AddFunction furysingle_targetshortcdactions
{
 #siegebreaker
 spell(siegebreaker)

 unless { buffpresent(recklessness) or buffpresent(memory_of_lucid_dreams) or enrageremaining() < gcd() or rage() > 90 } and spell(rampage) or spell(execute)
 {
  #bladestorm,if=prev_gcd.1.rampage
  if previousgcdspell(rampage) spell(bladestorm)

  unless { not isenraged() or azeritetraitrank(cold_steel_hot_blood_trait) > 1 } and spell(bloodthirst) or spell(onslaught)
  {
   #dragon_roar,if=buff.enrage.up
   if isenraged() spell(dragon_roar)
  }
 }
}

AddFunction furysingle_targetshortcdpostconditions
{
 { buffpresent(recklessness) or buffpresent(memory_of_lucid_dreams) or enrageremaining() < gcd() or rage() > 90 } and spell(rampage) or spell(execute) or { not isenraged() or azeritetraitrank(cold_steel_hot_blood_trait) > 1 } and spell(bloodthirst) or spell(onslaught) or charges(raging_blow) == 2 and spell(raging_blow) or spell(bloodthirst) or spell(raging_blow) or spell(whirlwind)
}

AddFunction furysingle_targetcdactions
{
}

AddFunction furysingle_targetcdpostconditions
{
 spell(siegebreaker) or { buffpresent(recklessness) or buffpresent(memory_of_lucid_dreams) or enrageremaining() < gcd() or rage() > 90 } and spell(rampage) or spell(execute) or previousgcdspell(rampage) and spell(bladestorm) or { not isenraged() or azeritetraitrank(cold_steel_hot_blood_trait) > 1 } and spell(bloodthirst) or spell(onslaught) or isenraged() and spell(dragon_roar) or charges(raging_blow) == 2 and spell(raging_blow) or spell(bloodthirst) or spell(raging_blow) or spell(whirlwind)
}

### actions.precombat

AddFunction furyprecombatmainactions
{
 #worldvein_resonance
 spell(worldvein_resonance)
 #memory_of_lucid_dreams
 spell(memory_of_lucid_dreams)
}

AddFunction furyprecombatmainpostconditions
{
}

AddFunction furyprecombatshortcdactions
{
 unless spell(worldvein_resonance) or spell(memory_of_lucid_dreams)
 {
  #recklessness
  spell(recklessness)
 }
}

AddFunction furyprecombatshortcdpostconditions
{
 spell(worldvein_resonance) or spell(memory_of_lucid_dreams)
}

AddFunction furyprecombatcdactions
{
 #flask
 #food
 #augmentation
 #snapshot_stats
 #use_item,name=azsharas_font_of_power
 furyuseitemactions()

 unless spell(worldvein_resonance) or spell(memory_of_lucid_dreams)
 {
  #guardian_of_azeroth
  spell(guardian_of_azeroth)
 }
}

AddFunction furyprecombatcdpostconditions
{
 spell(worldvein_resonance) or spell(memory_of_lucid_dreams) or spell(recklessness)
}

### actions.movement

AddFunction furymovementmainactions
{
 #heroic_leap
 if checkboxon(opt_melee_range) and target.distance(atleast 8) and target.distance(atmost 40) spell(heroic_leap)
}

AddFunction furymovementmainpostconditions
{
}

AddFunction furymovementshortcdactions
{
}

AddFunction furymovementshortcdpostconditions
{
 checkboxon(opt_melee_range) and target.distance(atleast 8) and target.distance(atmost 40) and spell(heroic_leap)
}

AddFunction furymovementcdactions
{
}

AddFunction furymovementcdpostconditions
{
 checkboxon(opt_melee_range) and target.distance(atleast 8) and target.distance(atmost 40) and spell(heroic_leap)
}

### actions.default

AddFunction fury_defaultmainactions
{
 #charge
 if checkboxon(opt_melee_range) and target.inrange(charge) and not target.inrange(pummel) spell(charge)
 #run_action_list,name=movement,if=movement.distance>5
 if target.distance() > 5 furymovementmainactions()

 unless target.distance() > 5 and furymovementmainpostconditions()
 {
  #heroic_leap,if=(raid_event.movement.distance>25&raid_event.movement.in>45)
  if target.distance() > 25 and 600 > 45 and checkboxon(opt_melee_range) and target.distance(atleast 8) and target.distance(atmost 40) spell(heroic_leap)
  #rampage,if=cooldown.recklessness.remains<3&talent.reckless_abandon.enabled
  if spellcooldown(recklessness) < 3 and hastalent(reckless_abandon_talent) spell(rampage)
  #blood_of_the_enemy,if=(buff.recklessness.up|cooldown.recklessness.remains<1)&(rage>80&(buff.meat_cleaver.up&buff.enrage.up|spell_targets.whirlwind=1)|dot.noxious_venom.remains)
  if { buffpresent(recklessness) or spellcooldown(recklessness) < 1 } and { rage() > 80 and { buffpresent(meat_cleaver) and isenraged() or enemies() == 1 } or target.debuffremaining(noxious_venom) } spell(blood_of_the_enemy)
  #ripple_in_space,if=!buff.recklessness.up&!buff.siegebreaker.up
  if not buffpresent(recklessness) and not buffpresent(siegebreaker) spell(ripple_in_space)
  #worldvein_resonance,if=!buff.recklessness.up&!buff.siegebreaker.up
  if not buffpresent(recklessness) and not buffpresent(siegebreaker) spell(worldvein_resonance)
  #concentrated_flame,if=!buff.recklessness.up&!buff.siegebreaker.up&dot.concentrated_flame_burn.remains=0
  if not buffpresent(recklessness) and not buffpresent(siegebreaker) and not target.debuffremaining(concentrated_flame_burn_debuff) > 0 spell(concentrated_flame)
  #the_unbound_force,if=buff.reckless_force.up
  if buffpresent(reckless_force_buff) spell(the_unbound_force)
  #memory_of_lucid_dreams,if=!buff.recklessness.up
  if not buffpresent(recklessness) spell(memory_of_lucid_dreams)
  #whirlwind,if=spell_targets.whirlwind>1&!buff.meat_cleaver.up
  if enemies() > 1 and not buffpresent(meat_cleaver) spell(whirlwind)
  #berserking,if=buff.recklessness.up
  if buffpresent(recklessness) spell(berserking)
  #run_action_list,name=single_target
  furysingle_targetmainactions()
 }
}

AddFunction fury_defaultmainpostconditions
{
 target.distance() > 5 and furymovementmainpostconditions() or furysingle_targetmainpostconditions()
}

AddFunction fury_defaultshortcdactions
{
 #auto_attack
 furygetinmeleerange()

 unless checkboxon(opt_melee_range) and target.inrange(charge) and not target.inrange(pummel) and spell(charge)
 {
  #run_action_list,name=movement,if=movement.distance>5
  if target.distance() > 5 furymovementshortcdactions()

  unless target.distance() > 5 and furymovementshortcdpostconditions() or target.distance() > 25 and 600 > 45 and checkboxon(opt_melee_range) and target.distance(atleast 8) and target.distance(atmost 40) and spell(heroic_leap) or spellcooldown(recklessness) < 3 and hastalent(reckless_abandon_talent) and spell(rampage) or { buffpresent(recklessness) or spellcooldown(recklessness) < 1 } and { rage() > 80 and { buffpresent(meat_cleaver) and isenraged() or enemies() == 1 } or target.debuffremaining(noxious_venom) } and spell(blood_of_the_enemy)
  {
   #purifying_blast,if=!buff.recklessness.up&!buff.siegebreaker.up
   if not buffpresent(recklessness) and not buffpresent(siegebreaker) spell(purifying_blast)

   unless not buffpresent(recklessness) and not buffpresent(siegebreaker) and spell(ripple_in_space) or not buffpresent(recklessness) and not buffpresent(siegebreaker) and spell(worldvein_resonance)
   {
    #focused_azerite_beam,if=!buff.recklessness.up&!buff.siegebreaker.up
    if not buffpresent(recklessness) and not buffpresent(siegebreaker) spell(focused_azerite_beam)
    #reaping_flames,if=!buff.recklessness.up&!buff.siegebreaker.up
    if not buffpresent(recklessness) and not buffpresent(siegebreaker) spell(reaping_flames)

    unless not buffpresent(recklessness) and not buffpresent(siegebreaker) and not target.debuffremaining(concentrated_flame_burn_debuff) > 0 and spell(concentrated_flame) or buffpresent(reckless_force_buff) and spell(the_unbound_force) or not buffpresent(recklessness) and spell(memory_of_lucid_dreams)
    {
     #recklessness,if=gcd.remains=0&(!essence.condensed_lifeforce.major&!essence.blood_of_the_enemy.major|cooldown.guardian_of_azeroth.remains>1|buff.guardian_of_azeroth.up|buff.blood_of_the_enemy.up)
     if not gcdremaining() > 0 and { not azeriteessenceismajor(condensed_lifeforce_essence_id) and not azeriteessenceismajor(blood_of_the_enemy_essence_id) or spellcooldown(guardian_of_azeroth) > 1 or buffpresent(guardian_of_azeroth_buff) or buffpresent(blood_of_the_enemy) } spell(recklessness)

     unless enemies() > 1 and not buffpresent(meat_cleaver) and spell(whirlwind) or buffpresent(recklessness) and spell(berserking)
     {
      #bag_of_tricks,if=buff.recklessness.down&debuff.siegebreaker.down&buff.enrage.up
      if buffexpires(recklessness) and target.debuffexpires(siegebreaker) and isenraged() spell(bag_of_tricks)
      #run_action_list,name=single_target
      furysingle_targetshortcdactions()
     }
    }
   }
  }
 }
}

AddFunction fury_defaultshortcdpostconditions
{
 checkboxon(opt_melee_range) and target.inrange(charge) and not target.inrange(pummel) and spell(charge) or target.distance() > 5 and furymovementshortcdpostconditions() or target.distance() > 25 and 600 > 45 and checkboxon(opt_melee_range) and target.distance(atleast 8) and target.distance(atmost 40) and spell(heroic_leap) or spellcooldown(recklessness) < 3 and hastalent(reckless_abandon_talent) and spell(rampage) or { buffpresent(recklessness) or spellcooldown(recklessness) < 1 } and { rage() > 80 and { buffpresent(meat_cleaver) and isenraged() or enemies() == 1 } or target.debuffremaining(noxious_venom) } and spell(blood_of_the_enemy) or not buffpresent(recklessness) and not buffpresent(siegebreaker) and spell(ripple_in_space) or not buffpresent(recklessness) and not buffpresent(siegebreaker) and spell(worldvein_resonance) or not buffpresent(recklessness) and not buffpresent(siegebreaker) and not target.debuffremaining(concentrated_flame_burn_debuff) > 0 and spell(concentrated_flame) or buffpresent(reckless_force_buff) and spell(the_unbound_force) or not buffpresent(recklessness) and spell(memory_of_lucid_dreams) or enemies() > 1 and not buffpresent(meat_cleaver) and spell(whirlwind) or buffpresent(recklessness) and spell(berserking) or furysingle_targetshortcdpostconditions()
}

AddFunction fury_defaultcdactions
{
 furyinterruptactions()

 unless checkboxon(opt_melee_range) and target.inrange(charge) and not target.inrange(pummel) and spell(charge)
 {
  #run_action_list,name=movement,if=movement.distance>5
  if target.distance() > 5 furymovementcdactions()

  unless target.distance() > 5 and furymovementcdpostconditions() or target.distance() > 25 and 600 > 45 and checkboxon(opt_melee_range) and target.distance(atleast 8) and target.distance(atmost 40) and spell(heroic_leap) or spellcooldown(recklessness) < 3 and hastalent(reckless_abandon_talent) and spell(rampage) or { buffpresent(recklessness) or spellcooldown(recklessness) < 1 } and { rage() > 80 and { buffpresent(meat_cleaver) and isenraged() or enemies() == 1 } or target.debuffremaining(noxious_venom) } and spell(blood_of_the_enemy) or not buffpresent(recklessness) and not buffpresent(siegebreaker) and spell(purifying_blast) or not buffpresent(recklessness) and not buffpresent(siegebreaker) and spell(ripple_in_space) or not buffpresent(recklessness) and not buffpresent(siegebreaker) and spell(worldvein_resonance) or not buffpresent(recklessness) and not buffpresent(siegebreaker) and spell(focused_azerite_beam) or not buffpresent(recklessness) and not buffpresent(siegebreaker) and spell(reaping_flames) or not buffpresent(recklessness) and not buffpresent(siegebreaker) and not target.debuffremaining(concentrated_flame_burn_debuff) > 0 and spell(concentrated_flame) or buffpresent(reckless_force_buff) and spell(the_unbound_force)
  {
   #guardian_of_azeroth,if=!buff.recklessness.up&(target.time_to_die>195|target.health.pct<20)
   if not buffpresent(recklessness) and { target.timetodie() > 195 or target.healthpercent() < 20 } spell(guardian_of_azeroth)

   unless not buffpresent(recklessness) and spell(memory_of_lucid_dreams) or not gcdremaining() > 0 and { not azeriteessenceismajor(condensed_lifeforce_essence_id) and not azeriteessenceismajor(blood_of_the_enemy_essence_id) or spellcooldown(guardian_of_azeroth) > 1 or buffpresent(guardian_of_azeroth_buff) or buffpresent(blood_of_the_enemy) } and spell(recklessness) or enemies() > 1 and not buffpresent(meat_cleaver) and spell(whirlwind)
   {
    #use_item,name=ashvanes_razor_coral,if=target.time_to_die<20|!debuff.razor_coral_debuff.up|(target.health.pct<30.1&debuff.conductive_ink_debuff.up)|(!debuff.conductive_ink_debuff.up&buff.memory_of_lucid_dreams.up|prev_gcd.2.guardian_of_azeroth|prev_gcd.2.recklessness&(!essence.memory_of_lucid_dreams.major&!essence.condensed_lifeforce.major))
    if target.timetodie() < 20 or not target.debuffpresent(razor_coral) or target.healthpercent() < 30.1 and target.debuffpresent(conductive_ink_debuff) or not target.debuffpresent(conductive_ink_debuff) and buffpresent(memory_of_lucid_dreams) or previousgcdspell(guardian_of_azeroth count=2) or previousgcdspell(recklessness count=2) and not azeriteessenceismajor(memory_of_lucid_dreams_essence_id) and not azeriteessenceismajor(condensed_lifeforce_essence_id) furyuseitemactions()
    #blood_fury,if=buff.recklessness.up
    if buffpresent(recklessness) spell(blood_fury)

    unless buffpresent(recklessness) and spell(berserking)
    {
     #lights_judgment,if=buff.recklessness.down&debuff.siegebreaker.down
     if buffexpires(recklessness) and target.debuffexpires(siegebreaker) spell(lights_judgment)
     #fireblood,if=buff.recklessness.up
     if buffpresent(recklessness) spell(fireblood)
     #ancestral_call,if=buff.recklessness.up
     if buffpresent(recklessness) spell(ancestral_call)

     unless buffexpires(recklessness) and target.debuffexpires(siegebreaker) and isenraged() and spell(bag_of_tricks)
     {
      #run_action_list,name=single_target
      furysingle_targetcdactions()
     }
    }
   }
  }
 }
}

AddFunction fury_defaultcdpostconditions
{
 checkboxon(opt_melee_range) and target.inrange(charge) and not target.inrange(pummel) and spell(charge) or target.distance() > 5 and furymovementcdpostconditions() or target.distance() > 25 and 600 > 45 and checkboxon(opt_melee_range) and target.distance(atleast 8) and target.distance(atmost 40) and spell(heroic_leap) or spellcooldown(recklessness) < 3 and hastalent(reckless_abandon_talent) and spell(rampage) or { buffpresent(recklessness) or spellcooldown(recklessness) < 1 } and { rage() > 80 and { buffpresent(meat_cleaver) and isenraged() or enemies() == 1 } or target.debuffremaining(noxious_venom) } and spell(blood_of_the_enemy) or not buffpresent(recklessness) and not buffpresent(siegebreaker) and spell(purifying_blast) or not buffpresent(recklessness) and not buffpresent(siegebreaker) and spell(ripple_in_space) or not buffpresent(recklessness) and not buffpresent(siegebreaker) and spell(worldvein_resonance) or not buffpresent(recklessness) and not buffpresent(siegebreaker) and spell(focused_azerite_beam) or not buffpresent(recklessness) and not buffpresent(siegebreaker) and spell(reaping_flames) or not buffpresent(recklessness) and not buffpresent(siegebreaker) and not target.debuffremaining(concentrated_flame_burn_debuff) > 0 and spell(concentrated_flame) or buffpresent(reckless_force_buff) and spell(the_unbound_force) or not buffpresent(recklessness) and spell(memory_of_lucid_dreams) or not gcdremaining() > 0 and { not azeriteessenceismajor(condensed_lifeforce_essence_id) and not azeriteessenceismajor(blood_of_the_enemy_essence_id) or spellcooldown(guardian_of_azeroth) > 1 or buffpresent(guardian_of_azeroth_buff) or buffpresent(blood_of_the_enemy) } and spell(recklessness) or enemies() > 1 and not buffpresent(meat_cleaver) and spell(whirlwind) or buffpresent(recklessness) and spell(berserking) or buffexpires(recklessness) and target.debuffexpires(siegebreaker) and isenraged() and spell(bag_of_tricks) or furysingle_targetcdpostconditions()
}

### Fury icons.

AddCheckBox(opt_warrior_fury_aoe l(aoe) default specialization=fury)

AddIcon checkbox=!opt_warrior_fury_aoe enemies=1 help=shortcd specialization=fury
{
 if not incombat() furyprecombatshortcdactions()
 fury_defaultshortcdactions()
}

AddIcon checkbox=opt_warrior_fury_aoe help=shortcd specialization=fury
{
 if not incombat() furyprecombatshortcdactions()
 fury_defaultshortcdactions()
}

AddIcon enemies=1 help=main specialization=fury
{
 if not incombat() furyprecombatmainactions()
 fury_defaultmainactions()
}

AddIcon checkbox=opt_warrior_fury_aoe help=aoe specialization=fury
{
 if not incombat() furyprecombatmainactions()
 fury_defaultmainactions()
}

AddIcon checkbox=!opt_warrior_fury_aoe enemies=1 help=cd specialization=fury
{
 if not incombat() furyprecombatcdactions()
 fury_defaultcdactions()
}

AddIcon checkbox=opt_warrior_fury_aoe help=cd specialization=fury
{
 if not incombat() furyprecombatcdactions()
 fury_defaultcdactions()
}

### Required symbols
# ancestral_call
# bag_of_tricks
# berserking
# bladestorm
# blood_fury
# blood_of_the_enemy
# blood_of_the_enemy_essence_id
# bloodthirst
# charge
# cold_steel_hot_blood_trait
# concentrated_flame
# concentrated_flame_burn_debuff
# condensed_lifeforce_essence_id
# conductive_ink_debuff
# dragon_roar
# execute
# fireblood
# focused_azerite_beam
# guardian_of_azeroth
# guardian_of_azeroth_buff
# heroic_leap
# intimidating_shout
# lights_judgment
# meat_cleaver
# memory_of_lucid_dreams
# memory_of_lucid_dreams_essence_id
# noxious_venom
# onslaught
# pummel
# purifying_blast
# quaking_palm
# raging_blow
# rampage
# razor_coral
# reaping_flames
# reckless_abandon_talent
# reckless_force_buff
# recklessness
# ripple_in_space
# shockwave
# siegebreaker
# storm_bolt
# the_unbound_force
# war_stomp
# whirlwind
# worldvein_resonance
]]
        OvaleScripts:RegisterScript("WARRIOR", "fury", name, desc, code, "script")
    end
end
