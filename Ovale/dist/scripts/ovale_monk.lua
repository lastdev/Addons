local __exports = LibStub:NewLibrary("ovale/scripts/ovale_monk", 80300)
if not __exports then return end
__exports.registerMonk = function(OvaleScripts)
    do
        local name = "sc_t25_monk_brewmaster"
        local desc = "[9.0] Simulationcraft: T25_Monk_Brewmaster"
        local code = [[
# Based on SimulationCraft profile "T25_Monk_Brewmaster".
#	class=monk
#	spec=brewmaster
#	talents=1010021

Include(ovale_common)
Include(ovale_monk_spells)

AddCheckBox(opt_interrupt l(interrupt) default specialization=brewmaster)
AddCheckBox(opt_melee_range l(not_in_melee_range) specialization=brewmaster)
AddCheckBox(opt_use_consumables l(opt_use_consumables) default specialization=brewmaster)
AddCheckBox(opt_chi_burst spellname(chi_burst) default specialization=brewmaster)

AddFunction brewmasterinterruptactions
{
 if checkboxon(opt_interrupt) and not target.isfriend() and target.casting()
 {
  if target.inrange(spear_hand_strike) and target.isinterruptible() spell(spear_hand_strike)
  if target.distance(less 5) and not target.classification(worldboss) spell(leg_sweep)
  if target.inrange(quaking_palm) and not target.classification(worldboss) spell(quaking_palm)
  if target.distance(less 5) and not target.classification(worldboss) spell(war_stomp)
  if target.inrange(paralysis) and not target.classification(worldboss) spell(paralysis)
 }
}

AddFunction brewmasteruseheartessence
{
 spell(concentrated_flame_essence)
}

AddFunction brewmasteruseitemactions
{
 item(trinket0slot text=13 usable=1)
 item(trinket1slot text=14 usable=1)
}

AddFunction brewmastergetinmeleerange
{
 if checkboxon(opt_melee_range) and not target.inrange(tiger_palm) texture(misc_arrowlup help=l(not_in_melee_range))
}

### actions.precombat

AddFunction brewmasterprecombatmainactions
{
 #chi_wave
 spell(chi_wave)
}

AddFunction brewmasterprecombatmainpostconditions
{
}

AddFunction brewmasterprecombatshortcdactions
{
 #chi_burst
 if checkboxon(opt_chi_burst) spell(chi_burst)
}

AddFunction brewmasterprecombatshortcdpostconditions
{
 spell(chi_wave)
}

AddFunction brewmasterprecombatcdactions
{
 #flask
 #food
 #augmentation
 #snapshot_stats
 #potion
 if checkboxon(opt_use_consumables) and target.classification(worldboss) item(unbridled_fury_item usable=1)
}

AddFunction brewmasterprecombatcdpostconditions
{
 checkboxon(opt_chi_burst) and spell(chi_burst) or spell(chi_wave)
}

### actions.default

AddFunction brewmaster_defaultmainactions
{
 #berserking
 spell(berserking)
 #purifying_brew,if=stagger.pct>(6*(1-(cooldown.purifying_brew.charges_fractional)))&(stagger.last_tick_damage_1>((0.02+0.001*(1-cooldown.purifying_brew.charges_fractional))*stagger.last_tick_damage_30))
 if staggerremaining() / maxhealth() * 100 > 6 * { 1 - spellcharges(purifying_brew count=0) } and staggertick(1) > { 0.02 + 0.001 * { 1 - spellcharges(purifying_brew count=0) } } * staggertick(30) spell(purifying_brew)
 #keg_smash,if=spell_targets>=2
 if enemies() >= 2 spell(keg_smash)
 #tiger_palm,if=talent.rushing_jade_wind.enabled&buff.blackout_combo.up&buff.rushing_jade_wind.up
 if hastalent(rushing_jade_wind_talent) and buffpresent(blackout_combo_buff) and buffpresent(rushing_jade_wind) spell(tiger_palm)
 #tiger_palm,if=(1|talent.special_delivery.enabled)&buff.blackout_combo.up
 if { 1 or hastalent(special_delivery_talent) } and buffpresent(blackout_combo_buff) spell(tiger_palm)
 #expel_harm,if=buff.gift_of_the_ox.stack>4
 if buffstacks(gift_of_the_ox) > 4 spell(expel_harm)
 #blackout_kick
 spell(blackout_kick)
 #keg_smash
 spell(keg_smash)
 #concentrated_flame,if=dot.concentrated_flame.remains=0
 if not target.debuffremaining(concentrated_flame) > 0 spell(concentrated_flame)
 #expel_harm,if=buff.gift_of_the_ox.stack>=3
 if buffstacks(gift_of_the_ox) >= 3 spell(expel_harm)
 #rushing_jade_wind,if=buff.rushing_jade_wind.down
 if buffexpires(rushing_jade_wind) spell(rushing_jade_wind)
 #breath_of_fire,if=buff.blackout_combo.down&(buff.bloodlust.down|(buff.bloodlust.up&&dot.breath_of_fire_dot.refreshable))
 if buffexpires(blackout_combo_buff) and { buffexpires(bloodlust) or buffpresent(bloodlust) and target.debuffrefreshable(breath_of_fire_dot_debuff) } spell(breath_of_fire)
 #chi_wave
 spell(chi_wave)
 #expel_harm,if=buff.gift_of_the_ox.stack>=2
 if buffstacks(gift_of_the_ox) >= 2 spell(expel_harm)
 #spinning_crane_kick,if=active_enemies>=3&cooldown.keg_smash.remains>gcd&(energy+(energy.regen*(cooldown.keg_smash.remains+gcd)))>=65
 if enemies() >= 3 and spellcooldown(keg_smash) > gcd() and energy() + energyregenrate() * { spellcooldown(keg_smash) + gcd() } >= 65 spell(spinning_crane_kick)
 #tiger_palm,if=!talent.blackout_combo.enabled&cooldown.keg_smash.remains>gcd&(energy+(energy.regen*(cooldown.keg_smash.remains+gcd)))>=65
 if not hastalent(blackout_combo_talent) and spellcooldown(keg_smash) > gcd() and energy() + energyregenrate() * { spellcooldown(keg_smash) + gcd() } >= 65 spell(tiger_palm)
 #rushing_jade_wind
 spell(rushing_jade_wind)
}

AddFunction brewmaster_defaultmainpostconditions
{
}

AddFunction brewmaster_defaultshortcdactions
{
 #auto_attack
 brewmastergetinmeleerange()

 unless spell(berserking)
 {
  #bag_of_tricks
  spell(bag_of_tricks)

  unless staggerremaining() / maxhealth() * 100 > 6 * { 1 - spellcharges(purifying_brew count=0) } and staggertick(1) > { 0.02 + 0.001 * { 1 - spellcharges(purifying_brew count=0) } } * staggertick(30) and spell(purifying_brew) or enemies() >= 2 and spell(keg_smash)
  {
   #celestial_brew,if=buff.blackout_combo.down&incoming_damage_1999ms>(health.max*0.1+stagger.last_tick_damage_4)&buff.elusive_brawler.stack<2
   if buffexpires(blackout_combo_buff) and incomingdamage(1.999) > message("health.max is not implemented") * 0.1 + staggertick(4) and buffstacks(elusive_brawler) < 2 spell(celestial_brew)

   unless hastalent(rushing_jade_wind_talent) and buffpresent(blackout_combo_buff) and buffpresent(rushing_jade_wind) and spell(tiger_palm) or { 1 or hastalent(special_delivery_talent) } and buffpresent(blackout_combo_buff) and spell(tiger_palm) or buffstacks(gift_of_the_ox) > 4 and spell(expel_harm) or spell(blackout_kick) or spell(keg_smash) or not target.debuffremaining(concentrated_flame) > 0 and spell(concentrated_flame) or buffstacks(gift_of_the_ox) >= 3 and spell(expel_harm) or buffexpires(rushing_jade_wind) and spell(rushing_jade_wind) or buffexpires(blackout_combo_buff) and { buffexpires(bloodlust) or buffpresent(bloodlust) and target.debuffrefreshable(breath_of_fire_dot_debuff) } and spell(breath_of_fire)
   {
    #chi_burst
    if checkboxon(opt_chi_burst) spell(chi_burst)
   }
  }
 }
}

AddFunction brewmaster_defaultshortcdpostconditions
{
 spell(berserking) or staggerremaining() / maxhealth() * 100 > 6 * { 1 - spellcharges(purifying_brew count=0) } and staggertick(1) > { 0.02 + 0.001 * { 1 - spellcharges(purifying_brew count=0) } } * staggertick(30) and spell(purifying_brew) or enemies() >= 2 and spell(keg_smash) or hastalent(rushing_jade_wind_talent) and buffpresent(blackout_combo_buff) and buffpresent(rushing_jade_wind) and spell(tiger_palm) or { 1 or hastalent(special_delivery_talent) } and buffpresent(blackout_combo_buff) and spell(tiger_palm) or buffstacks(gift_of_the_ox) > 4 and spell(expel_harm) or spell(blackout_kick) or spell(keg_smash) or not target.debuffremaining(concentrated_flame) > 0 and spell(concentrated_flame) or buffstacks(gift_of_the_ox) >= 3 and spell(expel_harm) or buffexpires(rushing_jade_wind) and spell(rushing_jade_wind) or buffexpires(blackout_combo_buff) and { buffexpires(bloodlust) or buffpresent(bloodlust) and target.debuffrefreshable(breath_of_fire_dot_debuff) } and spell(breath_of_fire) or spell(chi_wave) or buffstacks(gift_of_the_ox) >= 2 and spell(expel_harm) or enemies() >= 3 and spellcooldown(keg_smash) > gcd() and energy() + energyregenrate() * { spellcooldown(keg_smash) + gcd() } >= 65 and spell(spinning_crane_kick) or not hastalent(blackout_combo_talent) and spellcooldown(keg_smash) > gcd() and energy() + energyregenrate() * { spellcooldown(keg_smash) + gcd() } >= 65 and spell(tiger_palm) or spell(rushing_jade_wind)
}

AddFunction brewmaster_defaultcdactions
{
 brewmasterinterruptactions()
 #gift_of_the_ox,if=health<health.max*0.65
 #dampen_harm,if=incoming_damage_1500ms&buff.fortifying_brew.down
 if incomingdamage(1.5) > 0 and buffexpires(fortifying_brew) spell(dampen_harm)
 #fortifying_brew,if=incoming_damage_1500ms&(buff.dampen_harm.down|buff.diffuse_magic.down)
 if incomingdamage(1.5) > 0 and { buffexpires(dampen_harm) or buffexpires(diffuse_magic) } spell(fortifying_brew)
 #use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|debuff.conductive_ink_debuff.up&target.health.pct<31|target.time_to_die<20
 if target.debuffexpires(razor_coral) or target.debuffpresent(conductive_ink_debuff) and target.healthpercent() < 31 or target.timetodie() < 20 brewmasteruseitemactions()
 #use_items
 brewmasteruseitemactions()
 #potion
 if checkboxon(opt_use_consumables) and target.classification(worldboss) item(unbridled_fury_item usable=1)
 #blood_fury
 spell(blood_fury)

 unless spell(berserking)
 {
  #lights_judgment
  spell(lights_judgment)
  #fireblood
  spell(fireblood)
  #ancestral_call
  spell(ancestral_call)

  unless spell(bag_of_tricks)
  {
   #invoke_niuzao_the_black_ox,if=target.time_to_die>25
   if target.timetodie() > 25 spell(invoke_niuzao_the_black_ox)

   unless staggerremaining() / maxhealth() * 100 > 6 * { 1 - spellcharges(purifying_brew count=0) } and staggertick(1) > { 0.02 + 0.001 * { 1 - spellcharges(purifying_brew count=0) } } * staggertick(30) and spell(purifying_brew)
   {
    #black_ox_brew,if=cooldown.purifying_brew.charges_fractional<0.5
    if spellcharges(purifying_brew count=0) < 0.5 spell(black_ox_brew)
    #black_ox_brew,if=(energy+(energy.regen*cooldown.keg_smash.remains))<40&buff.blackout_combo.down&cooldown.keg_smash.up
    if energy() + energyregenrate() * spellcooldown(keg_smash) < 40 and buffexpires(blackout_combo_buff) and not spellcooldown(keg_smash) > 0 spell(black_ox_brew)

    unless enemies() >= 2 and spell(keg_smash) or buffexpires(blackout_combo_buff) and incomingdamage(1.999) > message("health.max is not implemented") * 0.1 + staggertick(4) and buffstacks(elusive_brawler) < 2 and spell(celestial_brew) or hastalent(rushing_jade_wind_talent) and buffpresent(blackout_combo_buff) and buffpresent(rushing_jade_wind) and spell(tiger_palm) or { 1 or hastalent(special_delivery_talent) } and buffpresent(blackout_combo_buff) and spell(tiger_palm) or buffstacks(gift_of_the_ox) > 4 and spell(expel_harm) or spell(blackout_kick) or spell(keg_smash) or not target.debuffremaining(concentrated_flame) > 0 and spell(concentrated_flame)
    {
     #heart_essence,if=!essence.the_crucible_of_flame.major
     if not azeriteessenceismajor(the_crucible_of_flame_essence_id) brewmasteruseheartessence()

     unless buffstacks(gift_of_the_ox) >= 3 and spell(expel_harm) or buffexpires(rushing_jade_wind) and spell(rushing_jade_wind) or buffexpires(blackout_combo_buff) and { buffexpires(bloodlust) or buffpresent(bloodlust) and target.debuffrefreshable(breath_of_fire_dot_debuff) } and spell(breath_of_fire) or checkboxon(opt_chi_burst) and spell(chi_burst) or spell(chi_wave) or buffstacks(gift_of_the_ox) >= 2 and spell(expel_harm) or enemies() >= 3 and spellcooldown(keg_smash) > gcd() and energy() + energyregenrate() * { spellcooldown(keg_smash) + gcd() } >= 65 and spell(spinning_crane_kick) or not hastalent(blackout_combo_talent) and spellcooldown(keg_smash) > gcd() and energy() + energyregenrate() * { spellcooldown(keg_smash) + gcd() } >= 65 and spell(tiger_palm)
     {
      #arcane_torrent,if=energy<31
      if energy() < 31 spell(arcane_torrent)
     }
    }
   }
  }
 }
}

AddFunction brewmaster_defaultcdpostconditions
{
 spell(berserking) or spell(bag_of_tricks) or staggerremaining() / maxhealth() * 100 > 6 * { 1 - spellcharges(purifying_brew count=0) } and staggertick(1) > { 0.02 + 0.001 * { 1 - spellcharges(purifying_brew count=0) } } * staggertick(30) and spell(purifying_brew) or enemies() >= 2 and spell(keg_smash) or buffexpires(blackout_combo_buff) and incomingdamage(1.999) > message("health.max is not implemented") * 0.1 + staggertick(4) and buffstacks(elusive_brawler) < 2 and spell(celestial_brew) or hastalent(rushing_jade_wind_talent) and buffpresent(blackout_combo_buff) and buffpresent(rushing_jade_wind) and spell(tiger_palm) or { 1 or hastalent(special_delivery_talent) } and buffpresent(blackout_combo_buff) and spell(tiger_palm) or buffstacks(gift_of_the_ox) > 4 and spell(expel_harm) or spell(blackout_kick) or spell(keg_smash) or not target.debuffremaining(concentrated_flame) > 0 and spell(concentrated_flame) or buffstacks(gift_of_the_ox) >= 3 and spell(expel_harm) or buffexpires(rushing_jade_wind) and spell(rushing_jade_wind) or buffexpires(blackout_combo_buff) and { buffexpires(bloodlust) or buffpresent(bloodlust) and target.debuffrefreshable(breath_of_fire_dot_debuff) } and spell(breath_of_fire) or checkboxon(opt_chi_burst) and spell(chi_burst) or spell(chi_wave) or buffstacks(gift_of_the_ox) >= 2 and spell(expel_harm) or enemies() >= 3 and spellcooldown(keg_smash) > gcd() and energy() + energyregenrate() * { spellcooldown(keg_smash) + gcd() } >= 65 and spell(spinning_crane_kick) or not hastalent(blackout_combo_talent) and spellcooldown(keg_smash) > gcd() and energy() + energyregenrate() * { spellcooldown(keg_smash) + gcd() } >= 65 and spell(tiger_palm) or spell(rushing_jade_wind)
}

### Brewmaster icons.

AddCheckBox(opt_monk_brewmaster_aoe l(aoe) default specialization=brewmaster)

AddIcon checkbox=!opt_monk_brewmaster_aoe enemies=1 help=shortcd specialization=brewmaster
{
 if not incombat() brewmasterprecombatshortcdactions()
 brewmaster_defaultshortcdactions()
}

AddIcon checkbox=opt_monk_brewmaster_aoe help=shortcd specialization=brewmaster
{
 if not incombat() brewmasterprecombatshortcdactions()
 brewmaster_defaultshortcdactions()
}

AddIcon enemies=1 help=main specialization=brewmaster
{
 if not incombat() brewmasterprecombatmainactions()
 brewmaster_defaultmainactions()
}

AddIcon checkbox=opt_monk_brewmaster_aoe help=aoe specialization=brewmaster
{
 if not incombat() brewmasterprecombatmainactions()
 brewmaster_defaultmainactions()
}

AddIcon checkbox=!opt_monk_brewmaster_aoe enemies=1 help=cd specialization=brewmaster
{
 if not incombat() brewmasterprecombatcdactions()
 brewmaster_defaultcdactions()
}

AddIcon checkbox=opt_monk_brewmaster_aoe help=cd specialization=brewmaster
{
 if not incombat() brewmasterprecombatcdactions()
 brewmaster_defaultcdactions()
}

### Required symbols
# ancestral_call
# arcane_torrent
# bag_of_tricks
# berserking
# black_ox_brew
# blackout_combo_buff
# blackout_combo_talent
# blackout_kick
# blood_fury
# bloodlust
# breath_of_fire
# breath_of_fire_dot_debuff
# celestial_brew
# chi_burst
# chi_wave
# concentrated_flame
# concentrated_flame_essence
# conductive_ink_debuff
# dampen_harm
# diffuse_magic
# elusive_brawler
# expel_harm
# fireblood
# fortifying_brew
# gift_of_the_ox
# invoke_niuzao_the_black_ox
# keg_smash
# leg_sweep
# lights_judgment
# paralysis
# purifying_brew
# quaking_palm
# razor_coral
# rushing_jade_wind
# rushing_jade_wind_talent
# spear_hand_strike
# special_delivery_talent
# spinning_crane_kick
# the_crucible_of_flame_essence_id
# tiger_palm
# unbridled_fury_item
# war_stomp
]]
        OvaleScripts:RegisterScript("MONK", "brewmaster", name, desc, code, "script")
    end
    do
        local name = "sc_t25_monk_windwalker"
        local desc = "[9.0] Simulationcraft: T25_Monk_Windwalker"
        local code = [[
# Based on SimulationCraft profile "T25_Monk_Windwalker".
#	class=monk
#	spec=windwalker
#	talents=2010012

Include(ovale_common)
Include(ovale_monk_spells)


AddFunction hold_xuen
{
 spellcooldown(invoke_xuen_the_white_tiger) > fightremains() or fightremains() < 120 and fightremains() > spellcooldown(serenity) and spellcooldown(serenity) > 10
}

AddFunction serenity_burst
{
 spellcooldown(serenity) < 1 or fightremains() < 20
}

AddFunction xuen_on_use_trinket
{
 0
}

AddCheckBox(opt_interrupt l(interrupt) default specialization=windwalker)
AddCheckBox(opt_melee_range l(not_in_melee_range) specialization=windwalker)
AddCheckBox(opt_use_consumables l(opt_use_consumables) default specialization=windwalker)
AddCheckBox(opt_touch_of_death_on_elite_only l(touch_of_death_on_elite_only) default specialization=windwalker)
AddCheckBox(opt_flying_serpent_kick spellname(flying_serpent_kick) default specialization=windwalker)
AddCheckBox(opt_touch_of_karma spellname(touch_of_karma) specialization=windwalker)
AddCheckBox(opt_chi_burst spellname(chi_burst) default specialization=windwalker)
AddCheckBox(opt_storm_earth_and_fire spellname(storm_earth_and_fire) default specialization=windwalker)

AddFunction windwalkerinterruptactions
{
 if checkboxon(opt_interrupt) and not target.isfriend() and target.casting()
 {
  if target.inrange(spear_hand_strike) and target.isinterruptible() spell(spear_hand_strike)
  if target.distance(less 5) and not target.classification(worldboss) spell(leg_sweep)
  if target.inrange(quaking_palm) and not target.classification(worldboss) spell(quaking_palm)
  if target.distance(less 5) and not target.classification(worldboss) spell(war_stomp)
  if target.inrange(paralysis) and not target.classification(worldboss) spell(paralysis)
 }
}

AddFunction windwalkeruseitemactions
{
 item(trinket0slot text=13 usable=1)
 item(trinket1slot text=14 usable=1)
}

AddFunction windwalkergetinmeleerange
{
 if checkboxon(opt_melee_range) and not target.inrange(tiger_palm) texture(misc_arrowlup help=l(not_in_melee_range))
}

### actions.st

AddFunction windwalkerstmainactions
{
 #whirling_dragon_punch
 if spellcooldown(fists_of_fury) > 0 and spellcooldown(rising_sun_kick) > 0 spell(whirling_dragon_punch)
 #spinning_crane_kick,if=combo_strike&(buff.dance_of_chiji.up|buff.dance_of_chiji_azerite.up)
 if not previousspell(spinning_crane_kick) and { buffpresent(dance_of_chiji_buff) or buffpresent(dance_of_chiji_azerite_buff) } spell(spinning_crane_kick)
 #fists_of_fury
 spell(fists_of_fury)
 #rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=cooldown.serenity.remains>1|!talent.serenity.enabled
 if spellcooldown(serenity) > 1 or not hastalent(serenity_talent) spell(rising_sun_kick)
 #rushing_jade_wind,if=buff.rushing_jade_wind.down&active_enemies>1
 if buffexpires(rushing_jade_wind) and enemies() > 1 spell(rushing_jade_wind)
 #expel_harm,if=chi.max-chi>=1+essence.conflict_and_strife.major
 if maxchi() - chi() >= 1 + azeriteessenceismajor(conflict_and_strife_essence_id) spell(expel_harm)
 #chi_wave
 spell(chi_wave)
 #tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&chi.max-chi>=2&buff.storm_earth_and_fire.down
 if not previousspell(tiger_palm) and maxchi() - chi() >= 2 and buffexpires(storm_earth_and_fire) spell(tiger_palm)
 #spinning_crane_kick,if=buff.chi_energy.stack>30-5*active_enemies&combo_strike&buff.storm_earth_and_fire.down&(cooldown.rising_sun_kick.remains>2&cooldown.fists_of_fury.remains>2|cooldown.rising_sun_kick.remains<3&cooldown.fists_of_fury.remains>3&chi>3|cooldown.rising_sun_kick.remains>3&cooldown.fists_of_fury.remains<3&chi>4|chi.max-chi<=1&energy.time_to_max<2)|buff.chi_energy.stack>10&fight_remains<7
 if buffstacks(chi_energy) > 30 - 5 * enemies() and not previousspell(spinning_crane_kick) and buffexpires(storm_earth_and_fire) and { spellcooldown(rising_sun_kick) > 2 and spellcooldown(fists_of_fury) > 2 or spellcooldown(rising_sun_kick) < 3 and spellcooldown(fists_of_fury) > 3 and chi() > 3 or spellcooldown(rising_sun_kick) > 3 and spellcooldown(fists_of_fury) < 3 and chi() > 4 or maxchi() - chi() <= 1 and timetomaxenergy() < 2 } or buffstacks(chi_energy) > 10 and fightremains() < 7 spell(spinning_crane_kick)
 #blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&(talent.serenity.enabled&cooldown.serenity.remains<3|cooldown.rising_sun_kick.remains>1&cooldown.fists_of_fury.remains>1|cooldown.rising_sun_kick.remains<3&cooldown.fists_of_fury.remains>3&chi>2|cooldown.rising_sun_kick.remains>3&cooldown.fists_of_fury.remains<3&chi>3|chi>5|buff.bok_proc.up)
 if not previousspell(blackout_kick) and { hastalent(serenity_talent) and spellcooldown(serenity) < 3 or spellcooldown(rising_sun_kick) > 1 and spellcooldown(fists_of_fury) > 1 or spellcooldown(rising_sun_kick) < 3 and spellcooldown(fists_of_fury) > 3 and chi() > 2 or spellcooldown(rising_sun_kick) > 3 and spellcooldown(fists_of_fury) < 3 and chi() > 3 or chi() > 5 or buffpresent(bok_proc_buff) } spell(blackout_kick)
 #tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&chi.max-chi>=2
 if not previousspell(tiger_palm) and maxchi() - chi() >= 2 spell(tiger_palm)
 #flying_serpent_kick,interrupt=1
 if checkboxon(opt_flying_serpent_kick) spell(flying_serpent_kick)
 #blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&cooldown.fists_of_fury.remains<3&chi=2&prev_gcd.1.tiger_palm&energy.time_to_50<1
 if not previousspell(blackout_kick) and spellcooldown(fists_of_fury) < 3 and chi() == 2 and previousgcdspell(tiger_palm) and message("energy.time_to_50 is not implemented") < 1 spell(blackout_kick)
 #blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&energy.time_to_max<2&(chi.max-chi<=1|prev_gcd.1.tiger_palm)
 if not previousspell(blackout_kick) and timetomaxenergy() < 2 and { maxchi() - chi() <= 1 or previousgcdspell(tiger_palm) } spell(blackout_kick)
}

AddFunction windwalkerstmainpostconditions
{
}

AddFunction windwalkerstshortcdactions
{
 unless spellcooldown(fists_of_fury) > 0 and spellcooldown(rising_sun_kick) > 0 and spell(whirling_dragon_punch)
 {
  #energizing_elixir,if=chi.max-chi>=2&energy.time_to_max>3|chi.max-chi>=4&(energy.time_to_max>2|!prev_gcd.1.tiger_palm)
  if maxchi() - chi() >= 2 and timetomaxenergy() > 3 or maxchi() - chi() >= 4 and { timetomaxenergy() > 2 or not previousgcdspell(tiger_palm) } spell(energizing_elixir)

  unless not previousspell(spinning_crane_kick) and { buffpresent(dance_of_chiji_buff) or buffpresent(dance_of_chiji_azerite_buff) } and spell(spinning_crane_kick) or spell(fists_of_fury) or { spellcooldown(serenity) > 1 or not hastalent(serenity_talent) } and spell(rising_sun_kick) or buffexpires(rushing_jade_wind) and enemies() > 1 and spell(rushing_jade_wind) or maxchi() - chi() >= 1 + azeriteessenceismajor(conflict_and_strife_essence_id) and spell(expel_harm)
  {
   #fist_of_the_white_tiger,target_if=min:debuff.mark_of_the_crane.remains,if=chi<3
   if chi() < 3 spell(fist_of_the_white_tiger)
   #chi_burst,if=chi.max-chi>=1
   if maxchi() - chi() >= 1 and checkboxon(opt_chi_burst) spell(chi_burst)
  }
 }
}

AddFunction windwalkerstshortcdpostconditions
{
 spellcooldown(fists_of_fury) > 0 and spellcooldown(rising_sun_kick) > 0 and spell(whirling_dragon_punch) or not previousspell(spinning_crane_kick) and { buffpresent(dance_of_chiji_buff) or buffpresent(dance_of_chiji_azerite_buff) } and spell(spinning_crane_kick) or spell(fists_of_fury) or { spellcooldown(serenity) > 1 or not hastalent(serenity_talent) } and spell(rising_sun_kick) or buffexpires(rushing_jade_wind) and enemies() > 1 and spell(rushing_jade_wind) or maxchi() - chi() >= 1 + azeriteessenceismajor(conflict_and_strife_essence_id) and spell(expel_harm) or spell(chi_wave) or not previousspell(tiger_palm) and maxchi() - chi() >= 2 and buffexpires(storm_earth_and_fire) and spell(tiger_palm) or { buffstacks(chi_energy) > 30 - 5 * enemies() and not previousspell(spinning_crane_kick) and buffexpires(storm_earth_and_fire) and { spellcooldown(rising_sun_kick) > 2 and spellcooldown(fists_of_fury) > 2 or spellcooldown(rising_sun_kick) < 3 and spellcooldown(fists_of_fury) > 3 and chi() > 3 or spellcooldown(rising_sun_kick) > 3 and spellcooldown(fists_of_fury) < 3 and chi() > 4 or maxchi() - chi() <= 1 and timetomaxenergy() < 2 } or buffstacks(chi_energy) > 10 and fightremains() < 7 } and spell(spinning_crane_kick) or not previousspell(blackout_kick) and { hastalent(serenity_talent) and spellcooldown(serenity) < 3 or spellcooldown(rising_sun_kick) > 1 and spellcooldown(fists_of_fury) > 1 or spellcooldown(rising_sun_kick) < 3 and spellcooldown(fists_of_fury) > 3 and chi() > 2 or spellcooldown(rising_sun_kick) > 3 and spellcooldown(fists_of_fury) < 3 and chi() > 3 or chi() > 5 or buffpresent(bok_proc_buff) } and spell(blackout_kick) or not previousspell(tiger_palm) and maxchi() - chi() >= 2 and spell(tiger_palm) or checkboxon(opt_flying_serpent_kick) and spell(flying_serpent_kick) or not previousspell(blackout_kick) and spellcooldown(fists_of_fury) < 3 and chi() == 2 and previousgcdspell(tiger_palm) and message("energy.time_to_50 is not implemented") < 1 and spell(blackout_kick) or not previousspell(blackout_kick) and timetomaxenergy() < 2 and { maxchi() - chi() <= 1 or previousgcdspell(tiger_palm) } and spell(blackout_kick)
}

AddFunction windwalkerstcdactions
{
}

AddFunction windwalkerstcdpostconditions
{
 spellcooldown(fists_of_fury) > 0 and spellcooldown(rising_sun_kick) > 0 and spell(whirling_dragon_punch) or { maxchi() - chi() >= 2 and timetomaxenergy() > 3 or maxchi() - chi() >= 4 and { timetomaxenergy() > 2 or not previousgcdspell(tiger_palm) } } and spell(energizing_elixir) or not previousspell(spinning_crane_kick) and { buffpresent(dance_of_chiji_buff) or buffpresent(dance_of_chiji_azerite_buff) } and spell(spinning_crane_kick) or spell(fists_of_fury) or { spellcooldown(serenity) > 1 or not hastalent(serenity_talent) } and spell(rising_sun_kick) or buffexpires(rushing_jade_wind) and enemies() > 1 and spell(rushing_jade_wind) or maxchi() - chi() >= 1 + azeriteessenceismajor(conflict_and_strife_essence_id) and spell(expel_harm) or chi() < 3 and spell(fist_of_the_white_tiger) or maxchi() - chi() >= 1 and checkboxon(opt_chi_burst) and spell(chi_burst) or spell(chi_wave) or not previousspell(tiger_palm) and maxchi() - chi() >= 2 and buffexpires(storm_earth_and_fire) and spell(tiger_palm) or { buffstacks(chi_energy) > 30 - 5 * enemies() and not previousspell(spinning_crane_kick) and buffexpires(storm_earth_and_fire) and { spellcooldown(rising_sun_kick) > 2 and spellcooldown(fists_of_fury) > 2 or spellcooldown(rising_sun_kick) < 3 and spellcooldown(fists_of_fury) > 3 and chi() > 3 or spellcooldown(rising_sun_kick) > 3 and spellcooldown(fists_of_fury) < 3 and chi() > 4 or maxchi() - chi() <= 1 and timetomaxenergy() < 2 } or buffstacks(chi_energy) > 10 and fightremains() < 7 } and spell(spinning_crane_kick) or not previousspell(blackout_kick) and { hastalent(serenity_talent) and spellcooldown(serenity) < 3 or spellcooldown(rising_sun_kick) > 1 and spellcooldown(fists_of_fury) > 1 or spellcooldown(rising_sun_kick) < 3 and spellcooldown(fists_of_fury) > 3 and chi() > 2 or spellcooldown(rising_sun_kick) > 3 and spellcooldown(fists_of_fury) < 3 and chi() > 3 or chi() > 5 or buffpresent(bok_proc_buff) } and spell(blackout_kick) or not previousspell(tiger_palm) and maxchi() - chi() >= 2 and spell(tiger_palm) or checkboxon(opt_flying_serpent_kick) and spell(flying_serpent_kick) or not previousspell(blackout_kick) and spellcooldown(fists_of_fury) < 3 and chi() == 2 and previousgcdspell(tiger_palm) and message("energy.time_to_50 is not implemented") < 1 and spell(blackout_kick) or not previousspell(blackout_kick) and timetomaxenergy() < 2 and { maxchi() - chi() <= 1 or previousgcdspell(tiger_palm) } and spell(blackout_kick)
}

### actions.serenity

AddFunction windwalkerserenitymainactions
{
 #fists_of_fury,if=buff.serenity.remains<1|active_enemies>1
 if buffremaining(serenity) < 1 or enemies() > 1 spell(fists_of_fury)
 #spinning_crane_kick,if=combo_strike&(active_enemies>2|active_enemies>1&!cooldown.rising_sun_kick.up)
 if not previousspell(spinning_crane_kick) and { enemies() > 2 or enemies() > 1 and not { not spellcooldown(rising_sun_kick) > 0 } } spell(spinning_crane_kick)
 #rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike
 if not previousspell(rising_sun_kick) spell(rising_sun_kick)
 #spinning_crane_kick,if=combo_strike&(buff.dance_of_chiji.up|buff.dance_of_chiji_azerite.up)
 if not previousspell(spinning_crane_kick) and { buffpresent(dance_of_chiji_buff) or buffpresent(dance_of_chiji_azerite_buff) } spell(spinning_crane_kick)
 #fists_of_fury,interrupt_if=gcd.remains=0
 spell(fists_of_fury)
 #blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike|!talent.hit_combo.enabled
 if not previousspell(blackout_kick) or not hastalent(hit_combo_talent) spell(blackout_kick)
 #spinning_crane_kick
 spell(spinning_crane_kick)
}

AddFunction windwalkerserenitymainpostconditions
{
}

AddFunction windwalkerserenityshortcdactions
{
 unless { buffremaining(serenity) < 1 or enemies() > 1 } and spell(fists_of_fury) or not previousspell(spinning_crane_kick) and { enemies() > 2 or enemies() > 1 and not { not spellcooldown(rising_sun_kick) > 0 } } and spell(spinning_crane_kick) or not previousspell(rising_sun_kick) and spell(rising_sun_kick) or not previousspell(spinning_crane_kick) and { buffpresent(dance_of_chiji_buff) or buffpresent(dance_of_chiji_azerite_buff) } and spell(spinning_crane_kick) or spell(fists_of_fury)
 {
  #fist_of_the_white_tiger,target_if=min:debuff.mark_of_the_crane.remains,if=chi<3
  if chi() < 3 spell(fist_of_the_white_tiger)
 }
}

AddFunction windwalkerserenityshortcdpostconditions
{
 { buffremaining(serenity) < 1 or enemies() > 1 } and spell(fists_of_fury) or not previousspell(spinning_crane_kick) and { enemies() > 2 or enemies() > 1 and not { not spellcooldown(rising_sun_kick) > 0 } } and spell(spinning_crane_kick) or not previousspell(rising_sun_kick) and spell(rising_sun_kick) or not previousspell(spinning_crane_kick) and { buffpresent(dance_of_chiji_buff) or buffpresent(dance_of_chiji_azerite_buff) } and spell(spinning_crane_kick) or spell(fists_of_fury) or { not previousspell(blackout_kick) or not hastalent(hit_combo_talent) } and spell(blackout_kick) or spell(spinning_crane_kick)
}

AddFunction windwalkerserenitycdactions
{
}

AddFunction windwalkerserenitycdpostconditions
{
 { buffremaining(serenity) < 1 or enemies() > 1 } and spell(fists_of_fury) or not previousspell(spinning_crane_kick) and { enemies() > 2 or enemies() > 1 and not { not spellcooldown(rising_sun_kick) > 0 } } and spell(spinning_crane_kick) or not previousspell(rising_sun_kick) and spell(rising_sun_kick) or not previousspell(spinning_crane_kick) and { buffpresent(dance_of_chiji_buff) or buffpresent(dance_of_chiji_azerite_buff) } and spell(spinning_crane_kick) or spell(fists_of_fury) or chi() < 3 and spell(fist_of_the_white_tiger) or { not previousspell(blackout_kick) or not hastalent(hit_combo_talent) } and spell(blackout_kick) or spell(spinning_crane_kick)
}

### actions.precombat

AddFunction windwalkerprecombatmainactions
{
 #chi_wave,if=!talent.energizing_elixer.enabled
 if not hastalent(energizing_elixer_talent) spell(chi_wave)
}

AddFunction windwalkerprecombatmainpostconditions
{
}

AddFunction windwalkerprecombatshortcdactions
{
 #variable,name=xuen_on_use_trinket,op=set,value=0
 #chi_burst,if=!talent.serenity.enabled|!talent.fist_of_the_white_tiger.enabled
 if { not hastalent(serenity_talent) or not hastalent(fist_of_the_white_tiger_talent) } and checkboxon(opt_chi_burst) spell(chi_burst)
}

AddFunction windwalkerprecombatshortcdpostconditions
{
 not hastalent(energizing_elixer_talent) and spell(chi_wave)
}

AddFunction windwalkerprecombatcdactions
{
 #flask
 #food
 #augmentation
 #snapshot_stats
 #potion
 if checkboxon(opt_use_consumables) and target.classification(worldboss) item(unbridled_fury_item usable=1)
}

AddFunction windwalkerprecombatcdpostconditions
{
 { not hastalent(serenity_talent) or not hastalent(fist_of_the_white_tiger_talent) } and checkboxon(opt_chi_burst) and spell(chi_burst) or not hastalent(energizing_elixer_talent) and spell(chi_wave)
}

### actions.opener

AddFunction windwalkeropenermainactions
{
 #expel_harm,if=talent.chi_burst.enabled
 if hastalent(chi_burst_talent) spell(expel_harm)
 #tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&chi.max-chi>=2
 if not previousspell(tiger_palm) and maxchi() - chi() >= 2 spell(tiger_palm)
 #expel_harm,if=chi.max-chi=3|chi.max-chi=1
 if maxchi() - chi() == 3 or maxchi() - chi() == 1 spell(expel_harm)
 #flying_serpent_kick,if=talent.hit_combo.enabled
 if hastalent(hit_combo_talent) and checkboxon(opt_flying_serpent_kick) spell(flying_serpent_kick)
 #tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=chi.max-chi>=2
 if maxchi() - chi() >= 2 spell(tiger_palm)
}

AddFunction windwalkeropenermainpostconditions
{
}

AddFunction windwalkeropenershortcdactions
{
 #fist_of_the_white_tiger,target_if=min:debuff.mark_of_the_crane.remains
 spell(fist_of_the_white_tiger)
}

AddFunction windwalkeropenershortcdpostconditions
{
 hastalent(chi_burst_talent) and spell(expel_harm) or not previousspell(tiger_palm) and maxchi() - chi() >= 2 and spell(tiger_palm) or { maxchi() - chi() == 3 or maxchi() - chi() == 1 } and spell(expel_harm) or hastalent(hit_combo_talent) and checkboxon(opt_flying_serpent_kick) and spell(flying_serpent_kick) or maxchi() - chi() >= 2 and spell(tiger_palm)
}

AddFunction windwalkeropenercdactions
{
}

AddFunction windwalkeropenercdpostconditions
{
 spell(fist_of_the_white_tiger) or hastalent(chi_burst_talent) and spell(expel_harm) or not previousspell(tiger_palm) and maxchi() - chi() >= 2 and spell(tiger_palm) or { maxchi() - chi() == 3 or maxchi() - chi() == 1 } and spell(expel_harm) or hastalent(hit_combo_talent) and checkboxon(opt_flying_serpent_kick) and spell(flying_serpent_kick) or maxchi() - chi() >= 2 and spell(tiger_palm)
}

### actions.cd_serenity

AddFunction windwalkercd_serenitymainactions
{
 #worldvein_resonance,if=variable.serenity_burst
 if serenity_burst() spell(worldvein_resonance)
 #blood_of_the_enemy,if=variable.serenity_burst
 if serenity_burst() spell(blood_of_the_enemy)
 #concentrated_flame,if=(cooldown.serenity.remains|cooldown.concentrated_flame.charges=2)&!dot.concentrated_flame_burn.remains&(cooldown.rising_sun_kick.remains&cooldown.fists_of_fury.remains|fight_remains<8)
 if { spellcooldown(serenity) > 0 or spellcharges(concentrated_flame) == 2 } and not target.debuffremaining(concentrated_flame_burn_debuff) and { spellcooldown(rising_sun_kick) > 0 and spellcooldown(fists_of_fury) > 0 or fightremains() < 8 } spell(concentrated_flame)
 #the_unbound_force
 spell(the_unbound_force)
 #memory_of_lucid_dreams,if=energy<40
 if energy() < 40 spell(memory_of_lucid_dreams)
 #ripple_in_space
 spell(ripple_in_space)
 #berserking,if=fight_remains>185|variable.serenity_burst
 if fightremains() > 185 or serenity_burst() spell(berserking)
 #touch_of_death
 if not checkboxon(opt_touch_of_death_on_elite_only) or not unitinraid() and target.classification(elite) or target.classification(worldboss) or not buffexpires(hidden_masters_forbidden_touch_buff) spell(touch_of_death)
}

AddFunction windwalkercd_serenitymainpostconditions
{
}

AddFunction windwalkercd_serenityshortcdactions
{
 unless serenity_burst() and spell(worldvein_resonance) or serenity_burst() and spell(blood_of_the_enemy) or { spellcooldown(serenity) > 0 or spellcharges(concentrated_flame) == 2 } and not target.debuffremaining(concentrated_flame_burn_debuff) and { spellcooldown(rising_sun_kick) > 0 and spellcooldown(fists_of_fury) > 0 or fightremains() < 8 } and spell(concentrated_flame) or spell(the_unbound_force)
 {
  #purifying_blast
  spell(purifying_blast)
  #reaping_flames,if=target.time_to_pct_20>30|target.health.pct<=20|target.time_to_die<2
  if target.timetohealthpercent(20) > 30 or target.healthpercent() <= 20 or target.timetodie() < 2 spell(reaping_flames)
  #focused_azerite_beam
  spell(focused_azerite_beam)

  unless energy() < 40 and spell(memory_of_lucid_dreams) or spell(ripple_in_space) or { fightremains() > 185 or serenity_burst() } and spell(berserking)
  {
   #bag_of_tricks,if=variable.serenity_burst
   if serenity_burst() spell(bag_of_tricks)

   unless { not checkboxon(opt_touch_of_death_on_elite_only) or not unitinraid() and target.classification(elite) or target.classification(worldboss) or not buffexpires(hidden_masters_forbidden_touch_buff) } and spell(touch_of_death)
   {
    #touch_of_karma,interval=90,pct_health=0.5
    if checkboxon(opt_touch_of_karma) spell(touch_of_karma)
    #serenity,if=cooldown.rising_sun_kick.remains<2|fight_remains<15
    if spellcooldown(rising_sun_kick) < 2 or fightremains() < 15 spell(serenity)
    #bag_of_tricks
    spell(bag_of_tricks)
   }
  }
 }
}

AddFunction windwalkercd_serenityshortcdpostconditions
{
 serenity_burst() and spell(worldvein_resonance) or serenity_burst() and spell(blood_of_the_enemy) or { spellcooldown(serenity) > 0 or spellcharges(concentrated_flame) == 2 } and not target.debuffremaining(concentrated_flame_burn_debuff) and { spellcooldown(rising_sun_kick) > 0 and spellcooldown(fists_of_fury) > 0 or fightremains() < 8 } and spell(concentrated_flame) or spell(the_unbound_force) or energy() < 40 and spell(memory_of_lucid_dreams) or spell(ripple_in_space) or { fightremains() > 185 or serenity_burst() } and spell(berserking) or { not checkboxon(opt_touch_of_death_on_elite_only) or not unitinraid() and target.classification(elite) or target.classification(worldboss) or not buffexpires(hidden_masters_forbidden_touch_buff) } and spell(touch_of_death)
}

AddFunction windwalkercd_serenitycdactions
{
 #variable,name=serenity_burst,op=set,value=cooldown.serenity.remains<1|fight_remains<20
 #invoke_xuen_the_white_tiger,if=!variable.hold_xuen|fight_remains<25
 if not hold_xuen() or fightremains() < 25 spell(invoke_xuen_the_white_tiger)
 #guardian_of_azeroth,if=fight_remains>185|variable.serenity_burst|fight_remains<35
 if fightremains() > 185 or serenity_burst() or fightremains() < 35 spell(guardian_of_azeroth)

 unless serenity_burst() and spell(worldvein_resonance) or serenity_burst() and spell(blood_of_the_enemy) or { spellcooldown(serenity) > 0 or spellcharges(concentrated_flame) == 2 } and not target.debuffremaining(concentrated_flame_burn_debuff) and { spellcooldown(rising_sun_kick) > 0 and spellcooldown(fists_of_fury) > 0 or fightremains() < 8 } and spell(concentrated_flame) or spell(the_unbound_force) or spell(purifying_blast) or { target.timetohealthpercent(20) > 30 or target.healthpercent() <= 20 or target.timetodie() < 2 } and spell(reaping_flames) or spell(focused_azerite_beam) or energy() < 40 and spell(memory_of_lucid_dreams) or spell(ripple_in_space)
 {
  #blood_fury,if=fight_remains>125|variable.serenity_burst
  if fightremains() > 125 or serenity_burst() spell(blood_fury)

  unless { fightremains() > 185 or serenity_burst() } and spell(berserking)
  {
   #arcane_torrent,if=chi.max-chi>=1
   if maxchi() - chi() >= 1 spell(arcane_torrent)
   #lights_judgment
   spell(lights_judgment)
   #fireblood,if=fight_remains>125|variable.serenity_burst
   if fightremains() > 125 or serenity_burst() spell(fireblood)
   #ancestral_call,if=fight_remains>125|variable.serenity_burst
   if fightremains() > 125 or serenity_burst() spell(ancestral_call)

   unless serenity_burst() and spell(bag_of_tricks)
   {
    #use_item,name=ashvanes_razor_coral
    windwalkeruseitemactions()
   }
  }
 }
}

AddFunction windwalkercd_serenitycdpostconditions
{
 serenity_burst() and spell(worldvein_resonance) or serenity_burst() and spell(blood_of_the_enemy) or { spellcooldown(serenity) > 0 or spellcharges(concentrated_flame) == 2 } and not target.debuffremaining(concentrated_flame_burn_debuff) and { spellcooldown(rising_sun_kick) > 0 and spellcooldown(fists_of_fury) > 0 or fightremains() < 8 } and spell(concentrated_flame) or spell(the_unbound_force) or spell(purifying_blast) or { target.timetohealthpercent(20) > 30 or target.healthpercent() <= 20 or target.timetodie() < 2 } and spell(reaping_flames) or spell(focused_azerite_beam) or energy() < 40 and spell(memory_of_lucid_dreams) or spell(ripple_in_space) or { fightremains() > 185 or serenity_burst() } and spell(berserking) or serenity_burst() and spell(bag_of_tricks) or { not checkboxon(opt_touch_of_death_on_elite_only) or not unitinraid() and target.classification(elite) or target.classification(worldboss) or not buffexpires(hidden_masters_forbidden_touch_buff) } and spell(touch_of_death) or checkboxon(opt_touch_of_karma) and spell(touch_of_karma) or { spellcooldown(rising_sun_kick) < 2 or fightremains() < 15 } and spell(serenity) or spell(bag_of_tricks)
}

### actions.cd_sef

AddFunction windwalkercd_sefmainactions
{
 #touch_of_death,if=buff.storm_earth_and_fire.down
 if buffexpires(storm_earth_and_fire) and { not checkboxon(opt_touch_of_death_on_elite_only) or not unitinraid() and target.classification(elite) or target.classification(worldboss) or not buffexpires(hidden_masters_forbidden_touch_buff) } spell(touch_of_death)
 #blood_of_the_enemy,if=cooldown.fists_of_fury.remains<2|fight_remains<12
 if spellcooldown(fists_of_fury) < 2 or fightremains() < 12 spell(blood_of_the_enemy)
 #worldvein_resonance
 spell(worldvein_resonance)
 #concentrated_flame,if=!dot.concentrated_flame_burn.remains&((!talent.whirling_dragon_punch.enabled|cooldown.whirling_dragon_punch.remains)&cooldown.rising_sun_kick.remains&cooldown.fists_of_fury.remains&buff.storm_earth_and_fire.down)|fight_remains<8
 if not target.debuffremaining(concentrated_flame_burn_debuff) and { not hastalent(whirling_dragon_punch_talent) or spellcooldown(whirling_dragon_punch) > 0 } and spellcooldown(rising_sun_kick) > 0 and spellcooldown(fists_of_fury) > 0 and buffexpires(storm_earth_and_fire) or fightremains() < 8 spell(concentrated_flame)
 #the_unbound_force
 spell(the_unbound_force)
 #memory_of_lucid_dreams,if=energy<40
 if energy() < 40 spell(memory_of_lucid_dreams)
 #ripple_in_space
 spell(ripple_in_space)
 #storm_earth_and_fire,if=cooldown.storm_earth_and_fire.charges=2|fight_remains<20|buff.seething_rage.up|(cooldown.blood_of_the_enemy.remains+1>cooldown.storm_earth_and_fire.full_recharge_time|!essence.blood_of_the_enemy.major)&cooldown.fists_of_fury.remains<10&chi>=2&cooldown.whirling_dragon_punch.remains<12
 if { spellcharges(storm_earth_and_fire) == 2 or fightremains() < 20 or buffpresent(seething_rage) or { spellcooldown(blood_of_the_enemy) + 1 > spellcooldown(storm_earth_and_fire) or not azeriteessenceismajor(blood_of_the_enemy_essence_id) } and spellcooldown(fists_of_fury) < 10 and chi() >= 2 and spellcooldown(whirling_dragon_punch) < 12 } and checkboxon(opt_storm_earth_and_fire) and not buffpresent(storm_earth_and_fire_buff) spell(storm_earth_and_fire)
 #berserking,if=fight_remains>185|buff.storm_earth_and_fire.up|fight_remains<20
 if fightremains() > 185 or buffpresent(storm_earth_and_fire) or fightremains() < 20 spell(berserking)
}

AddFunction windwalkercd_sefmainpostconditions
{
}

AddFunction windwalkercd_sefshortcdactions
{
 unless buffexpires(storm_earth_and_fire) and { not checkboxon(opt_touch_of_death_on_elite_only) or not unitinraid() and target.classification(elite) or target.classification(worldboss) or not buffexpires(hidden_masters_forbidden_touch_buff) } and spell(touch_of_death) or { spellcooldown(fists_of_fury) < 2 or fightremains() < 12 } and spell(blood_of_the_enemy) or spell(worldvein_resonance) or { not target.debuffremaining(concentrated_flame_burn_debuff) and { not hastalent(whirling_dragon_punch_talent) or spellcooldown(whirling_dragon_punch) > 0 } and spellcooldown(rising_sun_kick) > 0 and spellcooldown(fists_of_fury) > 0 and buffexpires(storm_earth_and_fire) or fightremains() < 8 } and spell(concentrated_flame) or spell(the_unbound_force)
 {
  #purifying_blast
  spell(purifying_blast)
  #reaping_flames,if=target.time_to_pct_20>30|target.health.pct<=20
  if target.timetohealthpercent(20) > 30 or target.healthpercent() <= 20 spell(reaping_flames)
  #focused_azerite_beam
  spell(focused_azerite_beam)

  unless energy() < 40 and spell(memory_of_lucid_dreams) or spell(ripple_in_space) or { spellcharges(storm_earth_and_fire) == 2 or fightremains() < 20 or buffpresent(seething_rage) or { spellcooldown(blood_of_the_enemy) + 1 > spellcooldown(storm_earth_and_fire) or not azeriteessenceismajor(blood_of_the_enemy_essence_id) } and spellcooldown(fists_of_fury) < 10 and chi() >= 2 and spellcooldown(whirling_dragon_punch) < 12 } and checkboxon(opt_storm_earth_and_fire) and not buffpresent(storm_earth_and_fire_buff) and spell(storm_earth_and_fire)
  {
   #touch_of_karma,interval=90,pct_health=0.5
   if checkboxon(opt_touch_of_karma) spell(touch_of_karma)

   unless { fightremains() > 185 or buffpresent(storm_earth_and_fire) or fightremains() < 20 } and spell(berserking)
   {
    #bag_of_tricks,if=buff.storm_earth_and_fire.down
    if buffexpires(storm_earth_and_fire) spell(bag_of_tricks)
   }
  }
 }
}

AddFunction windwalkercd_sefshortcdpostconditions
{
 buffexpires(storm_earth_and_fire) and { not checkboxon(opt_touch_of_death_on_elite_only) or not unitinraid() and target.classification(elite) or target.classification(worldboss) or not buffexpires(hidden_masters_forbidden_touch_buff) } and spell(touch_of_death) or { spellcooldown(fists_of_fury) < 2 or fightremains() < 12 } and spell(blood_of_the_enemy) or spell(worldvein_resonance) or { not target.debuffremaining(concentrated_flame_burn_debuff) and { not hastalent(whirling_dragon_punch_talent) or spellcooldown(whirling_dragon_punch) > 0 } and spellcooldown(rising_sun_kick) > 0 and spellcooldown(fists_of_fury) > 0 and buffexpires(storm_earth_and_fire) or fightremains() < 8 } and spell(concentrated_flame) or spell(the_unbound_force) or energy() < 40 and spell(memory_of_lucid_dreams) or spell(ripple_in_space) or { spellcharges(storm_earth_and_fire) == 2 or fightremains() < 20 or buffpresent(seething_rage) or { spellcooldown(blood_of_the_enemy) + 1 > spellcooldown(storm_earth_and_fire) or not azeriteessenceismajor(blood_of_the_enemy_essence_id) } and spellcooldown(fists_of_fury) < 10 and chi() >= 2 and spellcooldown(whirling_dragon_punch) < 12 } and checkboxon(opt_storm_earth_and_fire) and not buffpresent(storm_earth_and_fire_buff) and spell(storm_earth_and_fire) or { fightremains() > 185 or buffpresent(storm_earth_and_fire) or fightremains() < 20 } and spell(berserking)
}

AddFunction windwalkercd_sefcdactions
{
 #invoke_xuen_the_white_tiger,if=!variable.hold_xuen|fight_remains<25
 if not hold_xuen() or fightremains() < 25 spell(invoke_xuen_the_white_tiger)
 #arcane_torrent,if=chi.max-chi>=1
 if maxchi() - chi() >= 1 spell(arcane_torrent)

 unless buffexpires(storm_earth_and_fire) and { not checkboxon(opt_touch_of_death_on_elite_only) or not unitinraid() and target.classification(elite) or target.classification(worldboss) or not buffexpires(hidden_masters_forbidden_touch_buff) } and spell(touch_of_death) or { spellcooldown(fists_of_fury) < 2 or fightremains() < 12 } and spell(blood_of_the_enemy)
 {
  #guardian_of_azeroth
  spell(guardian_of_azeroth)

  unless spell(worldvein_resonance) or { not target.debuffremaining(concentrated_flame_burn_debuff) and { not hastalent(whirling_dragon_punch_talent) or spellcooldown(whirling_dragon_punch) > 0 } and spellcooldown(rising_sun_kick) > 0 and spellcooldown(fists_of_fury) > 0 and buffexpires(storm_earth_and_fire) or fightremains() < 8 } and spell(concentrated_flame) or spell(the_unbound_force) or spell(purifying_blast) or { target.timetohealthpercent(20) > 30 or target.healthpercent() <= 20 } and spell(reaping_flames) or spell(focused_azerite_beam) or energy() < 40 and spell(memory_of_lucid_dreams) or spell(ripple_in_space) or { spellcharges(storm_earth_and_fire) == 2 or fightremains() < 20 or buffpresent(seething_rage) or { spellcooldown(blood_of_the_enemy) + 1 > spellcooldown(storm_earth_and_fire) or not azeriteessenceismajor(blood_of_the_enemy_essence_id) } and spellcooldown(fists_of_fury) < 10 and chi() >= 2 and spellcooldown(whirling_dragon_punch) < 12 } and checkboxon(opt_storm_earth_and_fire) and not buffpresent(storm_earth_and_fire_buff) and spell(storm_earth_and_fire)
  {
   #use_item,name=ashvanes_razor_coral
   windwalkeruseitemactions()

   unless checkboxon(opt_touch_of_karma) and spell(touch_of_karma)
   {
    #blood_fury,if=fight_remains>125|buff.storm_earth_and_fire.up|fight_remains<20
    if fightremains() > 125 or buffpresent(storm_earth_and_fire) or fightremains() < 20 spell(blood_fury)

    unless { fightremains() > 185 or buffpresent(storm_earth_and_fire) or fightremains() < 20 } and spell(berserking)
    {
     #lights_judgment
     spell(lights_judgment)
     #fireblood,if=fight_remains>125|buff.storm_earth_and_fire.up|fight_remains<20
     if fightremains() > 125 or buffpresent(storm_earth_and_fire) or fightremains() < 20 spell(fireblood)
     #ancestral_call,if=fight_remains>185|buff.storm_earth_and_fire.up|fight_remains<20
     if fightremains() > 185 or buffpresent(storm_earth_and_fire) or fightremains() < 20 spell(ancestral_call)
    }
   }
  }
 }
}

AddFunction windwalkercd_sefcdpostconditions
{
 buffexpires(storm_earth_and_fire) and { not checkboxon(opt_touch_of_death_on_elite_only) or not unitinraid() and target.classification(elite) or target.classification(worldboss) or not buffexpires(hidden_masters_forbidden_touch_buff) } and spell(touch_of_death) or { spellcooldown(fists_of_fury) < 2 or fightremains() < 12 } and spell(blood_of_the_enemy) or spell(worldvein_resonance) or { not target.debuffremaining(concentrated_flame_burn_debuff) and { not hastalent(whirling_dragon_punch_talent) or spellcooldown(whirling_dragon_punch) > 0 } and spellcooldown(rising_sun_kick) > 0 and spellcooldown(fists_of_fury) > 0 and buffexpires(storm_earth_and_fire) or fightremains() < 8 } and spell(concentrated_flame) or spell(the_unbound_force) or spell(purifying_blast) or { target.timetohealthpercent(20) > 30 or target.healthpercent() <= 20 } and spell(reaping_flames) or spell(focused_azerite_beam) or energy() < 40 and spell(memory_of_lucid_dreams) or spell(ripple_in_space) or { spellcharges(storm_earth_and_fire) == 2 or fightremains() < 20 or buffpresent(seething_rage) or { spellcooldown(blood_of_the_enemy) + 1 > spellcooldown(storm_earth_and_fire) or not azeriteessenceismajor(blood_of_the_enemy_essence_id) } and spellcooldown(fists_of_fury) < 10 and chi() >= 2 and spellcooldown(whirling_dragon_punch) < 12 } and checkboxon(opt_storm_earth_and_fire) and not buffpresent(storm_earth_and_fire_buff) and spell(storm_earth_and_fire) or checkboxon(opt_touch_of_karma) and spell(touch_of_karma) or { fightremains() > 185 or buffpresent(storm_earth_and_fire) or fightremains() < 20 } and spell(berserking) or buffexpires(storm_earth_and_fire) and spell(bag_of_tricks)
}

### actions.aoe

AddFunction windwalkeraoemainactions
{
 #whirling_dragon_punch
 if spellcooldown(fists_of_fury) > 0 and spellcooldown(rising_sun_kick) > 0 spell(whirling_dragon_punch)
 #spinning_crane_kick,if=combo_strike&(buff.dance_of_chiji.up|buff.dance_of_chiji_azerite.up)
 if not previousspell(spinning_crane_kick) and { buffpresent(dance_of_chiji_buff) or buffpresent(dance_of_chiji_azerite_buff) } spell(spinning_crane_kick)
 #fists_of_fury,if=energy.time_to_max>execute_time-1|buff.storm_earth_and_fire.remains
 if timetomaxenergy() > executetime(fists_of_fury) - 1 or buffpresent(storm_earth_and_fire) spell(fists_of_fury)
 #rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=(talent.whirling_dragon_punch.enabled&cooldown.rising_sun_kick.duration>cooldown.whirling_dragon_punch.remains+3)&(cooldown.fists_of_fury.remains>3|chi>=5)
 if hastalent(whirling_dragon_punch_talent) and spellcooldownduration(rising_sun_kick) > spellcooldown(whirling_dragon_punch) + 3 and { spellcooldown(fists_of_fury) > 3 or chi() >= 5 } spell(rising_sun_kick)
 #rushing_jade_wind,if=buff.rushing_jade_wind.down
 if buffexpires(rushing_jade_wind) spell(rushing_jade_wind)
 #spinning_crane_kick,if=combo_strike&((chi>3|cooldown.fists_of_fury.remains>6)&(chi>=5|cooldown.fists_of_fury.remains>2)|energy.time_to_max<=3)
 if not previousspell(spinning_crane_kick) and { { chi() > 3 or spellcooldown(fists_of_fury) > 6 } and { chi() >= 5 or spellcooldown(fists_of_fury) > 2 } or timetomaxenergy() <= 3 } spell(spinning_crane_kick)
 #expel_harm,if=chi.max-chi>=1+essence.conflict_and_strife.major
 if maxchi() - chi() >= 1 + azeriteessenceismajor(conflict_and_strife_essence_id) spell(expel_harm)
 #tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=chi.max-chi>=2&(!talent.hit_combo.enabled|combo_strike)
 if maxchi() - chi() >= 2 and { not hastalent(hit_combo_talent) or not previousspell(tiger_palm) } spell(tiger_palm)
 #chi_wave,if=combo_strike
 if not previousspell(chi_wave) spell(chi_wave)
 #flying_serpent_kick,if=buff.bok_proc.down,interrupt=1
 if buffexpires(bok_proc_buff) and checkboxon(opt_flying_serpent_kick) spell(flying_serpent_kick)
 #blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&(buff.bok_proc.up|talent.hit_combo.enabled&prev_gcd.1.tiger_palm&(chi.max-chi>=14&energy.time_to_50<1|chi=2&cooldown.fists_of_fury.remains<3))
 if not previousspell(blackout_kick) and { buffpresent(bok_proc_buff) or hastalent(hit_combo_talent) and previousgcdspell(tiger_palm) and { maxchi() - chi() >= 14 and message("energy.time_to_50 is not implemented") < 1 or chi() == 2 and spellcooldown(fists_of_fury) < 3 } } spell(blackout_kick)
}

AddFunction windwalkeraoemainpostconditions
{
}

AddFunction windwalkeraoeshortcdactions
{
 unless spellcooldown(fists_of_fury) > 0 and spellcooldown(rising_sun_kick) > 0 and spell(whirling_dragon_punch)
 {
  #energizing_elixir,if=chi.max-chi>=2&energy.time_to_max>3|chi.max-chi>=4&(energy.time_to_max>2|!prev_gcd.1.tiger_palm)
  if maxchi() - chi() >= 2 and timetomaxenergy() > 3 or maxchi() - chi() >= 4 and { timetomaxenergy() > 2 or not previousgcdspell(tiger_palm) } spell(energizing_elixir)

  unless not previousspell(spinning_crane_kick) and { buffpresent(dance_of_chiji_buff) or buffpresent(dance_of_chiji_azerite_buff) } and spell(spinning_crane_kick) or { timetomaxenergy() > executetime(fists_of_fury) - 1 or buffpresent(storm_earth_and_fire) } and spell(fists_of_fury) or hastalent(whirling_dragon_punch_talent) and spellcooldownduration(rising_sun_kick) > spellcooldown(whirling_dragon_punch) + 3 and { spellcooldown(fists_of_fury) > 3 or chi() >= 5 } and spell(rising_sun_kick) or buffexpires(rushing_jade_wind) and spell(rushing_jade_wind) or not previousspell(spinning_crane_kick) and { { chi() > 3 or spellcooldown(fists_of_fury) > 6 } and { chi() >= 5 or spellcooldown(fists_of_fury) > 2 } or timetomaxenergy() <= 3 } and spell(spinning_crane_kick) or maxchi() - chi() >= 1 + azeriteessenceismajor(conflict_and_strife_essence_id) and spell(expel_harm)
  {
   #chi_burst,if=chi.max-chi>=1
   if maxchi() - chi() >= 1 and checkboxon(opt_chi_burst) spell(chi_burst)
   #fist_of_the_white_tiger,target_if=min:debuff.mark_of_the_crane.remains,if=chi.max-chi>=3
   if maxchi() - chi() >= 3 spell(fist_of_the_white_tiger)
  }
 }
}

AddFunction windwalkeraoeshortcdpostconditions
{
 spellcooldown(fists_of_fury) > 0 and spellcooldown(rising_sun_kick) > 0 and spell(whirling_dragon_punch) or not previousspell(spinning_crane_kick) and { buffpresent(dance_of_chiji_buff) or buffpresent(dance_of_chiji_azerite_buff) } and spell(spinning_crane_kick) or { timetomaxenergy() > executetime(fists_of_fury) - 1 or buffpresent(storm_earth_and_fire) } and spell(fists_of_fury) or hastalent(whirling_dragon_punch_talent) and spellcooldownduration(rising_sun_kick) > spellcooldown(whirling_dragon_punch) + 3 and { spellcooldown(fists_of_fury) > 3 or chi() >= 5 } and spell(rising_sun_kick) or buffexpires(rushing_jade_wind) and spell(rushing_jade_wind) or not previousspell(spinning_crane_kick) and { { chi() > 3 or spellcooldown(fists_of_fury) > 6 } and { chi() >= 5 or spellcooldown(fists_of_fury) > 2 } or timetomaxenergy() <= 3 } and spell(spinning_crane_kick) or maxchi() - chi() >= 1 + azeriteessenceismajor(conflict_and_strife_essence_id) and spell(expel_harm) or maxchi() - chi() >= 2 and { not hastalent(hit_combo_talent) or not previousspell(tiger_palm) } and spell(tiger_palm) or not previousspell(chi_wave) and spell(chi_wave) or buffexpires(bok_proc_buff) and checkboxon(opt_flying_serpent_kick) and spell(flying_serpent_kick) or not previousspell(blackout_kick) and { buffpresent(bok_proc_buff) or hastalent(hit_combo_talent) and previousgcdspell(tiger_palm) and { maxchi() - chi() >= 14 and message("energy.time_to_50 is not implemented") < 1 or chi() == 2 and spellcooldown(fists_of_fury) < 3 } } and spell(blackout_kick)
}

AddFunction windwalkeraoecdactions
{
}

AddFunction windwalkeraoecdpostconditions
{
 spellcooldown(fists_of_fury) > 0 and spellcooldown(rising_sun_kick) > 0 and spell(whirling_dragon_punch) or { maxchi() - chi() >= 2 and timetomaxenergy() > 3 or maxchi() - chi() >= 4 and { timetomaxenergy() > 2 or not previousgcdspell(tiger_palm) } } and spell(energizing_elixir) or not previousspell(spinning_crane_kick) and { buffpresent(dance_of_chiji_buff) or buffpresent(dance_of_chiji_azerite_buff) } and spell(spinning_crane_kick) or { timetomaxenergy() > executetime(fists_of_fury) - 1 or buffpresent(storm_earth_and_fire) } and spell(fists_of_fury) or hastalent(whirling_dragon_punch_talent) and spellcooldownduration(rising_sun_kick) > spellcooldown(whirling_dragon_punch) + 3 and { spellcooldown(fists_of_fury) > 3 or chi() >= 5 } and spell(rising_sun_kick) or buffexpires(rushing_jade_wind) and spell(rushing_jade_wind) or not previousspell(spinning_crane_kick) and { { chi() > 3 or spellcooldown(fists_of_fury) > 6 } and { chi() >= 5 or spellcooldown(fists_of_fury) > 2 } or timetomaxenergy() <= 3 } and spell(spinning_crane_kick) or maxchi() - chi() >= 1 + azeriteessenceismajor(conflict_and_strife_essence_id) and spell(expel_harm) or maxchi() - chi() >= 1 and checkboxon(opt_chi_burst) and spell(chi_burst) or maxchi() - chi() >= 3 and spell(fist_of_the_white_tiger) or maxchi() - chi() >= 2 and { not hastalent(hit_combo_talent) or not previousspell(tiger_palm) } and spell(tiger_palm) or not previousspell(chi_wave) and spell(chi_wave) or buffexpires(bok_proc_buff) and checkboxon(opt_flying_serpent_kick) and spell(flying_serpent_kick) or not previousspell(blackout_kick) and { buffpresent(bok_proc_buff) or hastalent(hit_combo_talent) and previousgcdspell(tiger_palm) and { maxchi() - chi() >= 14 and message("energy.time_to_50 is not implemented") < 1 or chi() == 2 and spellcooldown(fists_of_fury) < 3 } } and spell(blackout_kick)
}

### actions.default

AddFunction windwalker_defaultmainactions
{
 #call_action_list,name=serenity,if=buff.serenity.up
 if buffpresent(serenity) windwalkerserenitymainactions()

 unless buffpresent(serenity) and windwalkerserenitymainpostconditions()
 {
  #call_action_list,name=opener,if=time<5&chi<5&!pet.xuen_the_white_tiger.active
  if timeincombat() < 5 and chi() < 5 and not pet.present() windwalkeropenermainactions()

  unless timeincombat() < 5 and chi() < 5 and not pet.present() and windwalkeropenermainpostconditions()
  {
   #expel_harm,if=chi.max-chi>=1+essence.conflict_and_strife.major&(energy.time_to_max<1|cooldown.serenity.remains<2|energy.time_to_max<4&cooldown.fists_of_fury.remains<1.5)
   if maxchi() - chi() >= 1 + azeriteessenceismajor(conflict_and_strife_essence_id) and { timetomaxenergy() < 1 or spellcooldown(serenity) < 2 or timetomaxenergy() < 4 and spellcooldown(fists_of_fury) < 1.5 } spell(expel_harm)
   #tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&chi.max-chi>=2&(energy.time_to_max<1|cooldown.serenity.remains<2|energy.time_to_max<4&cooldown.fists_of_fury.remains<1.5)
   if not previousspell(tiger_palm) and maxchi() - chi() >= 2 and { timetomaxenergy() < 1 or spellcooldown(serenity) < 2 or timetomaxenergy() < 4 and spellcooldown(fists_of_fury) < 1.5 } spell(tiger_palm)
   #call_action_list,name=cd_sef,if=!talent.serenity.enabled
   if not hastalent(serenity_talent) windwalkercd_sefmainactions()

   unless not hastalent(serenity_talent) and windwalkercd_sefmainpostconditions()
   {
    #call_action_list,name=cd_serenity,if=talent.serenity.enabled
    if hastalent(serenity_talent) windwalkercd_serenitymainactions()

    unless hastalent(serenity_talent) and windwalkercd_serenitymainpostconditions()
    {
     #call_action_list,name=st,if=active_enemies<3
     if enemies() < 3 windwalkerstmainactions()

     unless enemies() < 3 and windwalkerstmainpostconditions()
     {
      #call_action_list,name=aoe,if=active_enemies>=3
      if enemies() >= 3 windwalkeraoemainactions()
     }
    }
   }
  }
 }
}

AddFunction windwalker_defaultmainpostconditions
{
 buffpresent(serenity) and windwalkerserenitymainpostconditions() or timeincombat() < 5 and chi() < 5 and not pet.present() and windwalkeropenermainpostconditions() or not hastalent(serenity_talent) and windwalkercd_sefmainpostconditions() or hastalent(serenity_talent) and windwalkercd_serenitymainpostconditions() or enemies() < 3 and windwalkerstmainpostconditions() or enemies() >= 3 and windwalkeraoemainpostconditions()
}

AddFunction windwalker_defaultshortcdactions
{
 #auto_attack
 windwalkergetinmeleerange()
 #call_action_list,name=serenity,if=buff.serenity.up
 if buffpresent(serenity) windwalkerserenityshortcdactions()

 unless buffpresent(serenity) and windwalkerserenityshortcdpostconditions()
 {
  #call_action_list,name=opener,if=time<5&chi<5&!pet.xuen_the_white_tiger.active
  if timeincombat() < 5 and chi() < 5 and not pet.present() windwalkeropenershortcdactions()

  unless timeincombat() < 5 and chi() < 5 and not pet.present() and windwalkeropenershortcdpostconditions()
  {
   #fist_of_the_white_tiger,target_if=min:debuff.mark_of_the_crane.remains,if=chi.max-chi>=3&(energy.time_to_max<1|energy.time_to_max<4&cooldown.fists_of_fury.remains<1.5)
   if maxchi() - chi() >= 3 and { timetomaxenergy() < 1 or timetomaxenergy() < 4 and spellcooldown(fists_of_fury) < 1.5 } spell(fist_of_the_white_tiger)

   unless maxchi() - chi() >= 1 + azeriteessenceismajor(conflict_and_strife_essence_id) and { timetomaxenergy() < 1 or spellcooldown(serenity) < 2 or timetomaxenergy() < 4 and spellcooldown(fists_of_fury) < 1.5 } and spell(expel_harm) or not previousspell(tiger_palm) and maxchi() - chi() >= 2 and { timetomaxenergy() < 1 or spellcooldown(serenity) < 2 or timetomaxenergy() < 4 and spellcooldown(fists_of_fury) < 1.5 } and spell(tiger_palm)
   {
    #call_action_list,name=cd_sef,if=!talent.serenity.enabled
    if not hastalent(serenity_talent) windwalkercd_sefshortcdactions()

    unless not hastalent(serenity_talent) and windwalkercd_sefshortcdpostconditions()
    {
     #call_action_list,name=cd_serenity,if=talent.serenity.enabled
     if hastalent(serenity_talent) windwalkercd_serenityshortcdactions()

     unless hastalent(serenity_talent) and windwalkercd_serenityshortcdpostconditions()
     {
      #call_action_list,name=st,if=active_enemies<3
      if enemies() < 3 windwalkerstshortcdactions()

      unless enemies() < 3 and windwalkerstshortcdpostconditions()
      {
       #call_action_list,name=aoe,if=active_enemies>=3
       if enemies() >= 3 windwalkeraoeshortcdactions()
      }
     }
    }
   }
  }
 }
}

AddFunction windwalker_defaultshortcdpostconditions
{
 buffpresent(serenity) and windwalkerserenityshortcdpostconditions() or timeincombat() < 5 and chi() < 5 and not pet.present() and windwalkeropenershortcdpostconditions() or maxchi() - chi() >= 1 + azeriteessenceismajor(conflict_and_strife_essence_id) and { timetomaxenergy() < 1 or spellcooldown(serenity) < 2 or timetomaxenergy() < 4 and spellcooldown(fists_of_fury) < 1.5 } and spell(expel_harm) or not previousspell(tiger_palm) and maxchi() - chi() >= 2 and { timetomaxenergy() < 1 or spellcooldown(serenity) < 2 or timetomaxenergy() < 4 and spellcooldown(fists_of_fury) < 1.5 } and spell(tiger_palm) or not hastalent(serenity_talent) and windwalkercd_sefshortcdpostconditions() or hastalent(serenity_talent) and windwalkercd_serenityshortcdpostconditions() or enemies() < 3 and windwalkerstshortcdpostconditions() or enemies() >= 3 and windwalkeraoeshortcdpostconditions()
}

AddFunction windwalker_defaultcdactions
{
 #spear_hand_strike,if=target.debuff.casting.react
 if target.isinterruptible() windwalkerinterruptactions()
 #variable,name=hold_xuen,op=set,value=cooldown.invoke_xuen_the_white_tiger.remains>fight_remains|fight_remains<120&fight_remains>cooldown.serenity.remains&cooldown.serenity.remains>10
 #potion,if=(buff.serenity.up|buff.storm_earth_and_fire.up)&pet.xuen_the_white_tiger.active|fight_remains<=60
 if { { buffpresent(serenity) or buffpresent(storm_earth_and_fire) } and pet.present() or fightremains() <= 60 } and checkboxon(opt_use_consumables) and target.classification(worldboss) item(unbridled_fury_item usable=1)
 #call_action_list,name=serenity,if=buff.serenity.up
 if buffpresent(serenity) windwalkerserenitycdactions()

 unless buffpresent(serenity) and windwalkerserenitycdpostconditions()
 {
  #call_action_list,name=opener,if=time<5&chi<5&!pet.xuen_the_white_tiger.active
  if timeincombat() < 5 and chi() < 5 and not pet.present() windwalkeropenercdactions()

  unless timeincombat() < 5 and chi() < 5 and not pet.present() and windwalkeropenercdpostconditions() or maxchi() - chi() >= 3 and { timetomaxenergy() < 1 or timetomaxenergy() < 4 and spellcooldown(fists_of_fury) < 1.5 } and spell(fist_of_the_white_tiger) or maxchi() - chi() >= 1 + azeriteessenceismajor(conflict_and_strife_essence_id) and { timetomaxenergy() < 1 or spellcooldown(serenity) < 2 or timetomaxenergy() < 4 and spellcooldown(fists_of_fury) < 1.5 } and spell(expel_harm) or not previousspell(tiger_palm) and maxchi() - chi() >= 2 and { timetomaxenergy() < 1 or spellcooldown(serenity) < 2 or timetomaxenergy() < 4 and spellcooldown(fists_of_fury) < 1.5 } and spell(tiger_palm)
  {
   #call_action_list,name=cd_sef,if=!talent.serenity.enabled
   if not hastalent(serenity_talent) windwalkercd_sefcdactions()

   unless not hastalent(serenity_talent) and windwalkercd_sefcdpostconditions()
   {
    #call_action_list,name=cd_serenity,if=talent.serenity.enabled
    if hastalent(serenity_talent) windwalkercd_serenitycdactions()

    unless hastalent(serenity_talent) and windwalkercd_serenitycdpostconditions()
    {
     #call_action_list,name=st,if=active_enemies<3
     if enemies() < 3 windwalkerstcdactions()

     unless enemies() < 3 and windwalkerstcdpostconditions()
     {
      #call_action_list,name=aoe,if=active_enemies>=3
      if enemies() >= 3 windwalkeraoecdactions()
     }
    }
   }
  }
 }
}

AddFunction windwalker_defaultcdpostconditions
{
 buffpresent(serenity) and windwalkerserenitycdpostconditions() or timeincombat() < 5 and chi() < 5 and not pet.present() and windwalkeropenercdpostconditions() or maxchi() - chi() >= 3 and { timetomaxenergy() < 1 or timetomaxenergy() < 4 and spellcooldown(fists_of_fury) < 1.5 } and spell(fist_of_the_white_tiger) or maxchi() - chi() >= 1 + azeriteessenceismajor(conflict_and_strife_essence_id) and { timetomaxenergy() < 1 or spellcooldown(serenity) < 2 or timetomaxenergy() < 4 and spellcooldown(fists_of_fury) < 1.5 } and spell(expel_harm) or not previousspell(tiger_palm) and maxchi() - chi() >= 2 and { timetomaxenergy() < 1 or spellcooldown(serenity) < 2 or timetomaxenergy() < 4 and spellcooldown(fists_of_fury) < 1.5 } and spell(tiger_palm) or not hastalent(serenity_talent) and windwalkercd_sefcdpostconditions() or hastalent(serenity_talent) and windwalkercd_serenitycdpostconditions() or enemies() < 3 and windwalkerstcdpostconditions() or enemies() >= 3 and windwalkeraoecdpostconditions()
}

### Windwalker icons.

AddCheckBox(opt_monk_windwalker_aoe l(aoe) default specialization=windwalker)

AddIcon checkbox=!opt_monk_windwalker_aoe enemies=1 help=shortcd specialization=windwalker
{
 if not incombat() windwalkerprecombatshortcdactions()
 windwalker_defaultshortcdactions()
}

AddIcon checkbox=opt_monk_windwalker_aoe help=shortcd specialization=windwalker
{
 if not incombat() windwalkerprecombatshortcdactions()
 windwalker_defaultshortcdactions()
}

AddIcon enemies=1 help=main specialization=windwalker
{
 if not incombat() windwalkerprecombatmainactions()
 windwalker_defaultmainactions()
}

AddIcon checkbox=opt_monk_windwalker_aoe help=aoe specialization=windwalker
{
 if not incombat() windwalkerprecombatmainactions()
 windwalker_defaultmainactions()
}

AddIcon checkbox=!opt_monk_windwalker_aoe enemies=1 help=cd specialization=windwalker
{
 if not incombat() windwalkerprecombatcdactions()
 windwalker_defaultcdactions()
}

AddIcon checkbox=opt_monk_windwalker_aoe help=cd specialization=windwalker
{
 if not incombat() windwalkerprecombatcdactions()
 windwalker_defaultcdactions()
}

### Required symbols
# ancestral_call
# arcane_torrent
# bag_of_tricks
# berserking
# blackout_kick
# blood_fury
# blood_of_the_enemy
# blood_of_the_enemy_essence_id
# bok_proc_buff
# chi_burst
# chi_burst_talent
# chi_energy
# chi_wave
# concentrated_flame
# concentrated_flame_burn_debuff
# conflict_and_strife_essence_id
# dance_of_chiji_azerite_buff
# dance_of_chiji_buff
# energizing_elixer_talent
# energizing_elixir
# expel_harm
# fireblood
# fist_of_the_white_tiger
# fist_of_the_white_tiger_talent
# fists_of_fury
# flying_serpent_kick
# focused_azerite_beam
# guardian_of_azeroth
# hidden_masters_forbidden_touch_buff
# hit_combo_talent
# invoke_xuen_the_white_tiger
# leg_sweep
# lights_judgment
# memory_of_lucid_dreams
# paralysis
# purifying_blast
# quaking_palm
# reaping_flames
# ripple_in_space
# rising_sun_kick
# rushing_jade_wind
# seething_rage
# serenity
# serenity_talent
# spear_hand_strike
# spinning_crane_kick
# storm_earth_and_fire
# the_unbound_force
# tiger_palm
# touch_of_death
# touch_of_karma
# unbridled_fury_item
# war_stomp
# whirling_dragon_punch
# whirling_dragon_punch_talent
# worldvein_resonance
]]
        OvaleScripts:RegisterScript("MONK", "windwalker", name, desc, code, "script")
    end
    do
        local name = "sc_t25_monk_windwalker_serenity"
        local desc = "[9.0] Simulationcraft: T25_Monk_Windwalker_Serenity"
        local code = [[
# Based on SimulationCraft profile "T25_Monk_Windwalker_Serenity".
#	class=monk
#	spec=windwalker
#	talents=2020013

Include(ovale_common)
Include(ovale_monk_spells)


AddFunction hold_xuen
{
 spellcooldown(invoke_xuen_the_white_tiger) > fightremains() or fightremains() < 120 and fightremains() > spellcooldown(serenity) and spellcooldown(serenity) > 10
}

AddFunction serenity_burst
{
 spellcooldown(serenity) < 1 or fightremains() < 20
}

AddFunction xuen_on_use_trinket
{
 0
}

AddCheckBox(opt_interrupt l(interrupt) default specialization=windwalker)
AddCheckBox(opt_melee_range l(not_in_melee_range) specialization=windwalker)
AddCheckBox(opt_use_consumables l(opt_use_consumables) default specialization=windwalker)
AddCheckBox(opt_touch_of_death_on_elite_only l(touch_of_death_on_elite_only) default specialization=windwalker)
AddCheckBox(opt_flying_serpent_kick spellname(flying_serpent_kick) default specialization=windwalker)
AddCheckBox(opt_touch_of_karma spellname(touch_of_karma) specialization=windwalker)
AddCheckBox(opt_chi_burst spellname(chi_burst) default specialization=windwalker)
AddCheckBox(opt_storm_earth_and_fire spellname(storm_earth_and_fire) default specialization=windwalker)

AddFunction windwalkerinterruptactions
{
 if checkboxon(opt_interrupt) and not target.isfriend() and target.casting()
 {
  if target.inrange(spear_hand_strike) and target.isinterruptible() spell(spear_hand_strike)
  if target.distance(less 5) and not target.classification(worldboss) spell(leg_sweep)
  if target.inrange(quaking_palm) and not target.classification(worldboss) spell(quaking_palm)
  if target.distance(less 5) and not target.classification(worldboss) spell(war_stomp)
  if target.inrange(paralysis) and not target.classification(worldboss) spell(paralysis)
 }
}

AddFunction windwalkeruseitemactions
{
 item(trinket0slot text=13 usable=1)
 item(trinket1slot text=14 usable=1)
}

AddFunction windwalkergetinmeleerange
{
 if checkboxon(opt_melee_range) and not target.inrange(tiger_palm) texture(misc_arrowlup help=l(not_in_melee_range))
}

### actions.st

AddFunction windwalkerstmainactions
{
 #whirling_dragon_punch
 if spellcooldown(fists_of_fury) > 0 and spellcooldown(rising_sun_kick) > 0 spell(whirling_dragon_punch)
 #spinning_crane_kick,if=combo_strike&(buff.dance_of_chiji.up|buff.dance_of_chiji_azerite.up)
 if not previousspell(spinning_crane_kick) and { buffpresent(dance_of_chiji_buff) or buffpresent(dance_of_chiji_azerite_buff) } spell(spinning_crane_kick)
 #fists_of_fury
 spell(fists_of_fury)
 #rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=cooldown.serenity.remains>1|!talent.serenity.enabled
 if spellcooldown(serenity) > 1 or not hastalent(serenity_talent) spell(rising_sun_kick)
 #rushing_jade_wind,if=buff.rushing_jade_wind.down&active_enemies>1
 if buffexpires(rushing_jade_wind) and enemies() > 1 spell(rushing_jade_wind)
 #expel_harm,if=chi.max-chi>=1+essence.conflict_and_strife.major
 if maxchi() - chi() >= 1 + azeriteessenceismajor(conflict_and_strife_essence_id) spell(expel_harm)
 #chi_wave
 spell(chi_wave)
 #tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&chi.max-chi>=2&buff.storm_earth_and_fire.down
 if not previousspell(tiger_palm) and maxchi() - chi() >= 2 and buffexpires(storm_earth_and_fire) spell(tiger_palm)
 #spinning_crane_kick,if=buff.chi_energy.stack>30-5*active_enemies&combo_strike&buff.storm_earth_and_fire.down&(cooldown.rising_sun_kick.remains>2&cooldown.fists_of_fury.remains>2|cooldown.rising_sun_kick.remains<3&cooldown.fists_of_fury.remains>3&chi>3|cooldown.rising_sun_kick.remains>3&cooldown.fists_of_fury.remains<3&chi>4|chi.max-chi<=1&energy.time_to_max<2)|buff.chi_energy.stack>10&fight_remains<7
 if buffstacks(chi_energy) > 30 - 5 * enemies() and not previousspell(spinning_crane_kick) and buffexpires(storm_earth_and_fire) and { spellcooldown(rising_sun_kick) > 2 and spellcooldown(fists_of_fury) > 2 or spellcooldown(rising_sun_kick) < 3 and spellcooldown(fists_of_fury) > 3 and chi() > 3 or spellcooldown(rising_sun_kick) > 3 and spellcooldown(fists_of_fury) < 3 and chi() > 4 or maxchi() - chi() <= 1 and timetomaxenergy() < 2 } or buffstacks(chi_energy) > 10 and fightremains() < 7 spell(spinning_crane_kick)
 #blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&(talent.serenity.enabled&cooldown.serenity.remains<3|cooldown.rising_sun_kick.remains>1&cooldown.fists_of_fury.remains>1|cooldown.rising_sun_kick.remains<3&cooldown.fists_of_fury.remains>3&chi>2|cooldown.rising_sun_kick.remains>3&cooldown.fists_of_fury.remains<3&chi>3|chi>5|buff.bok_proc.up)
 if not previousspell(blackout_kick) and { hastalent(serenity_talent) and spellcooldown(serenity) < 3 or spellcooldown(rising_sun_kick) > 1 and spellcooldown(fists_of_fury) > 1 or spellcooldown(rising_sun_kick) < 3 and spellcooldown(fists_of_fury) > 3 and chi() > 2 or spellcooldown(rising_sun_kick) > 3 and spellcooldown(fists_of_fury) < 3 and chi() > 3 or chi() > 5 or buffpresent(bok_proc_buff) } spell(blackout_kick)
 #tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&chi.max-chi>=2
 if not previousspell(tiger_palm) and maxchi() - chi() >= 2 spell(tiger_palm)
 #flying_serpent_kick,interrupt=1
 if checkboxon(opt_flying_serpent_kick) spell(flying_serpent_kick)
 #blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&cooldown.fists_of_fury.remains<3&chi=2&prev_gcd.1.tiger_palm&energy.time_to_50<1
 if not previousspell(blackout_kick) and spellcooldown(fists_of_fury) < 3 and chi() == 2 and previousgcdspell(tiger_palm) and message("energy.time_to_50 is not implemented") < 1 spell(blackout_kick)
 #blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&energy.time_to_max<2&(chi.max-chi<=1|prev_gcd.1.tiger_palm)
 if not previousspell(blackout_kick) and timetomaxenergy() < 2 and { maxchi() - chi() <= 1 or previousgcdspell(tiger_palm) } spell(blackout_kick)
}

AddFunction windwalkerstmainpostconditions
{
}

AddFunction windwalkerstshortcdactions
{
 unless spellcooldown(fists_of_fury) > 0 and spellcooldown(rising_sun_kick) > 0 and spell(whirling_dragon_punch)
 {
  #energizing_elixir,if=chi.max-chi>=2&energy.time_to_max>3|chi.max-chi>=4&(energy.time_to_max>2|!prev_gcd.1.tiger_palm)
  if maxchi() - chi() >= 2 and timetomaxenergy() > 3 or maxchi() - chi() >= 4 and { timetomaxenergy() > 2 or not previousgcdspell(tiger_palm) } spell(energizing_elixir)

  unless not previousspell(spinning_crane_kick) and { buffpresent(dance_of_chiji_buff) or buffpresent(dance_of_chiji_azerite_buff) } and spell(spinning_crane_kick) or spell(fists_of_fury) or { spellcooldown(serenity) > 1 or not hastalent(serenity_talent) } and spell(rising_sun_kick) or buffexpires(rushing_jade_wind) and enemies() > 1 and spell(rushing_jade_wind) or maxchi() - chi() >= 1 + azeriteessenceismajor(conflict_and_strife_essence_id) and spell(expel_harm)
  {
   #fist_of_the_white_tiger,target_if=min:debuff.mark_of_the_crane.remains,if=chi<3
   if chi() < 3 spell(fist_of_the_white_tiger)
   #chi_burst,if=chi.max-chi>=1
   if maxchi() - chi() >= 1 and checkboxon(opt_chi_burst) spell(chi_burst)
  }
 }
}

AddFunction windwalkerstshortcdpostconditions
{
 spellcooldown(fists_of_fury) > 0 and spellcooldown(rising_sun_kick) > 0 and spell(whirling_dragon_punch) or not previousspell(spinning_crane_kick) and { buffpresent(dance_of_chiji_buff) or buffpresent(dance_of_chiji_azerite_buff) } and spell(spinning_crane_kick) or spell(fists_of_fury) or { spellcooldown(serenity) > 1 or not hastalent(serenity_talent) } and spell(rising_sun_kick) or buffexpires(rushing_jade_wind) and enemies() > 1 and spell(rushing_jade_wind) or maxchi() - chi() >= 1 + azeriteessenceismajor(conflict_and_strife_essence_id) and spell(expel_harm) or spell(chi_wave) or not previousspell(tiger_palm) and maxchi() - chi() >= 2 and buffexpires(storm_earth_and_fire) and spell(tiger_palm) or { buffstacks(chi_energy) > 30 - 5 * enemies() and not previousspell(spinning_crane_kick) and buffexpires(storm_earth_and_fire) and { spellcooldown(rising_sun_kick) > 2 and spellcooldown(fists_of_fury) > 2 or spellcooldown(rising_sun_kick) < 3 and spellcooldown(fists_of_fury) > 3 and chi() > 3 or spellcooldown(rising_sun_kick) > 3 and spellcooldown(fists_of_fury) < 3 and chi() > 4 or maxchi() - chi() <= 1 and timetomaxenergy() < 2 } or buffstacks(chi_energy) > 10 and fightremains() < 7 } and spell(spinning_crane_kick) or not previousspell(blackout_kick) and { hastalent(serenity_talent) and spellcooldown(serenity) < 3 or spellcooldown(rising_sun_kick) > 1 and spellcooldown(fists_of_fury) > 1 or spellcooldown(rising_sun_kick) < 3 and spellcooldown(fists_of_fury) > 3 and chi() > 2 or spellcooldown(rising_sun_kick) > 3 and spellcooldown(fists_of_fury) < 3 and chi() > 3 or chi() > 5 or buffpresent(bok_proc_buff) } and spell(blackout_kick) or not previousspell(tiger_palm) and maxchi() - chi() >= 2 and spell(tiger_palm) or checkboxon(opt_flying_serpent_kick) and spell(flying_serpent_kick) or not previousspell(blackout_kick) and spellcooldown(fists_of_fury) < 3 and chi() == 2 and previousgcdspell(tiger_palm) and message("energy.time_to_50 is not implemented") < 1 and spell(blackout_kick) or not previousspell(blackout_kick) and timetomaxenergy() < 2 and { maxchi() - chi() <= 1 or previousgcdspell(tiger_palm) } and spell(blackout_kick)
}

AddFunction windwalkerstcdactions
{
}

AddFunction windwalkerstcdpostconditions
{
 spellcooldown(fists_of_fury) > 0 and spellcooldown(rising_sun_kick) > 0 and spell(whirling_dragon_punch) or { maxchi() - chi() >= 2 and timetomaxenergy() > 3 or maxchi() - chi() >= 4 and { timetomaxenergy() > 2 or not previousgcdspell(tiger_palm) } } and spell(energizing_elixir) or not previousspell(spinning_crane_kick) and { buffpresent(dance_of_chiji_buff) or buffpresent(dance_of_chiji_azerite_buff) } and spell(spinning_crane_kick) or spell(fists_of_fury) or { spellcooldown(serenity) > 1 or not hastalent(serenity_talent) } and spell(rising_sun_kick) or buffexpires(rushing_jade_wind) and enemies() > 1 and spell(rushing_jade_wind) or maxchi() - chi() >= 1 + azeriteessenceismajor(conflict_and_strife_essence_id) and spell(expel_harm) or chi() < 3 and spell(fist_of_the_white_tiger) or maxchi() - chi() >= 1 and checkboxon(opt_chi_burst) and spell(chi_burst) or spell(chi_wave) or not previousspell(tiger_palm) and maxchi() - chi() >= 2 and buffexpires(storm_earth_and_fire) and spell(tiger_palm) or { buffstacks(chi_energy) > 30 - 5 * enemies() and not previousspell(spinning_crane_kick) and buffexpires(storm_earth_and_fire) and { spellcooldown(rising_sun_kick) > 2 and spellcooldown(fists_of_fury) > 2 or spellcooldown(rising_sun_kick) < 3 and spellcooldown(fists_of_fury) > 3 and chi() > 3 or spellcooldown(rising_sun_kick) > 3 and spellcooldown(fists_of_fury) < 3 and chi() > 4 or maxchi() - chi() <= 1 and timetomaxenergy() < 2 } or buffstacks(chi_energy) > 10 and fightremains() < 7 } and spell(spinning_crane_kick) or not previousspell(blackout_kick) and { hastalent(serenity_talent) and spellcooldown(serenity) < 3 or spellcooldown(rising_sun_kick) > 1 and spellcooldown(fists_of_fury) > 1 or spellcooldown(rising_sun_kick) < 3 and spellcooldown(fists_of_fury) > 3 and chi() > 2 or spellcooldown(rising_sun_kick) > 3 and spellcooldown(fists_of_fury) < 3 and chi() > 3 or chi() > 5 or buffpresent(bok_proc_buff) } and spell(blackout_kick) or not previousspell(tiger_palm) and maxchi() - chi() >= 2 and spell(tiger_palm) or checkboxon(opt_flying_serpent_kick) and spell(flying_serpent_kick) or not previousspell(blackout_kick) and spellcooldown(fists_of_fury) < 3 and chi() == 2 and previousgcdspell(tiger_palm) and message("energy.time_to_50 is not implemented") < 1 and spell(blackout_kick) or not previousspell(blackout_kick) and timetomaxenergy() < 2 and { maxchi() - chi() <= 1 or previousgcdspell(tiger_palm) } and spell(blackout_kick)
}

### actions.serenity

AddFunction windwalkerserenitymainactions
{
 #fists_of_fury,if=buff.serenity.remains<1|active_enemies>1
 if buffremaining(serenity) < 1 or enemies() > 1 spell(fists_of_fury)
 #spinning_crane_kick,if=combo_strike&(active_enemies>2|active_enemies>1&!cooldown.rising_sun_kick.up)
 if not previousspell(spinning_crane_kick) and { enemies() > 2 or enemies() > 1 and not { not spellcooldown(rising_sun_kick) > 0 } } spell(spinning_crane_kick)
 #rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike
 if not previousspell(rising_sun_kick) spell(rising_sun_kick)
 #spinning_crane_kick,if=combo_strike&(buff.dance_of_chiji.up|buff.dance_of_chiji_azerite.up)
 if not previousspell(spinning_crane_kick) and { buffpresent(dance_of_chiji_buff) or buffpresent(dance_of_chiji_azerite_buff) } spell(spinning_crane_kick)
 #fists_of_fury,interrupt_if=gcd.remains=0
 spell(fists_of_fury)
 #blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike|!talent.hit_combo.enabled
 if not previousspell(blackout_kick) or not hastalent(hit_combo_talent) spell(blackout_kick)
 #spinning_crane_kick
 spell(spinning_crane_kick)
}

AddFunction windwalkerserenitymainpostconditions
{
}

AddFunction windwalkerserenityshortcdactions
{
 unless { buffremaining(serenity) < 1 or enemies() > 1 } and spell(fists_of_fury) or not previousspell(spinning_crane_kick) and { enemies() > 2 or enemies() > 1 and not { not spellcooldown(rising_sun_kick) > 0 } } and spell(spinning_crane_kick) or not previousspell(rising_sun_kick) and spell(rising_sun_kick) or not previousspell(spinning_crane_kick) and { buffpresent(dance_of_chiji_buff) or buffpresent(dance_of_chiji_azerite_buff) } and spell(spinning_crane_kick) or spell(fists_of_fury)
 {
  #fist_of_the_white_tiger,target_if=min:debuff.mark_of_the_crane.remains,if=chi<3
  if chi() < 3 spell(fist_of_the_white_tiger)
 }
}

AddFunction windwalkerserenityshortcdpostconditions
{
 { buffremaining(serenity) < 1 or enemies() > 1 } and spell(fists_of_fury) or not previousspell(spinning_crane_kick) and { enemies() > 2 or enemies() > 1 and not { not spellcooldown(rising_sun_kick) > 0 } } and spell(spinning_crane_kick) or not previousspell(rising_sun_kick) and spell(rising_sun_kick) or not previousspell(spinning_crane_kick) and { buffpresent(dance_of_chiji_buff) or buffpresent(dance_of_chiji_azerite_buff) } and spell(spinning_crane_kick) or spell(fists_of_fury) or { not previousspell(blackout_kick) or not hastalent(hit_combo_talent) } and spell(blackout_kick) or spell(spinning_crane_kick)
}

AddFunction windwalkerserenitycdactions
{
}

AddFunction windwalkerserenitycdpostconditions
{
 { buffremaining(serenity) < 1 or enemies() > 1 } and spell(fists_of_fury) or not previousspell(spinning_crane_kick) and { enemies() > 2 or enemies() > 1 and not { not spellcooldown(rising_sun_kick) > 0 } } and spell(spinning_crane_kick) or not previousspell(rising_sun_kick) and spell(rising_sun_kick) or not previousspell(spinning_crane_kick) and { buffpresent(dance_of_chiji_buff) or buffpresent(dance_of_chiji_azerite_buff) } and spell(spinning_crane_kick) or spell(fists_of_fury) or chi() < 3 and spell(fist_of_the_white_tiger) or { not previousspell(blackout_kick) or not hastalent(hit_combo_talent) } and spell(blackout_kick) or spell(spinning_crane_kick)
}

### actions.precombat

AddFunction windwalkerprecombatmainactions
{
 #chi_wave,if=!talent.energizing_elixer.enabled
 if not hastalent(energizing_elixer_talent) spell(chi_wave)
}

AddFunction windwalkerprecombatmainpostconditions
{
}

AddFunction windwalkerprecombatshortcdactions
{
 #variable,name=xuen_on_use_trinket,op=set,value=0
 #chi_burst,if=!talent.serenity.enabled|!talent.fist_of_the_white_tiger.enabled
 if { not hastalent(serenity_talent) or not hastalent(fist_of_the_white_tiger_talent) } and checkboxon(opt_chi_burst) spell(chi_burst)
}

AddFunction windwalkerprecombatshortcdpostconditions
{
 not hastalent(energizing_elixer_talent) and spell(chi_wave)
}

AddFunction windwalkerprecombatcdactions
{
 #flask
 #food
 #augmentation
 #snapshot_stats
 #potion
 if checkboxon(opt_use_consumables) and target.classification(worldboss) item(unbridled_fury_item usable=1)
}

AddFunction windwalkerprecombatcdpostconditions
{
 { not hastalent(serenity_talent) or not hastalent(fist_of_the_white_tiger_talent) } and checkboxon(opt_chi_burst) and spell(chi_burst) or not hastalent(energizing_elixer_talent) and spell(chi_wave)
}

### actions.opener

AddFunction windwalkeropenermainactions
{
 #expel_harm,if=talent.chi_burst.enabled
 if hastalent(chi_burst_talent) spell(expel_harm)
 #tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&chi.max-chi>=2
 if not previousspell(tiger_palm) and maxchi() - chi() >= 2 spell(tiger_palm)
 #expel_harm,if=chi.max-chi=3|chi.max-chi=1
 if maxchi() - chi() == 3 or maxchi() - chi() == 1 spell(expel_harm)
 #flying_serpent_kick,if=talent.hit_combo.enabled
 if hastalent(hit_combo_talent) and checkboxon(opt_flying_serpent_kick) spell(flying_serpent_kick)
 #tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=chi.max-chi>=2
 if maxchi() - chi() >= 2 spell(tiger_palm)
}

AddFunction windwalkeropenermainpostconditions
{
}

AddFunction windwalkeropenershortcdactions
{
 #fist_of_the_white_tiger,target_if=min:debuff.mark_of_the_crane.remains
 spell(fist_of_the_white_tiger)
}

AddFunction windwalkeropenershortcdpostconditions
{
 hastalent(chi_burst_talent) and spell(expel_harm) or not previousspell(tiger_palm) and maxchi() - chi() >= 2 and spell(tiger_palm) or { maxchi() - chi() == 3 or maxchi() - chi() == 1 } and spell(expel_harm) or hastalent(hit_combo_talent) and checkboxon(opt_flying_serpent_kick) and spell(flying_serpent_kick) or maxchi() - chi() >= 2 and spell(tiger_palm)
}

AddFunction windwalkeropenercdactions
{
}

AddFunction windwalkeropenercdpostconditions
{
 spell(fist_of_the_white_tiger) or hastalent(chi_burst_talent) and spell(expel_harm) or not previousspell(tiger_palm) and maxchi() - chi() >= 2 and spell(tiger_palm) or { maxchi() - chi() == 3 or maxchi() - chi() == 1 } and spell(expel_harm) or hastalent(hit_combo_talent) and checkboxon(opt_flying_serpent_kick) and spell(flying_serpent_kick) or maxchi() - chi() >= 2 and spell(tiger_palm)
}

### actions.cd_serenity

AddFunction windwalkercd_serenitymainactions
{
 #worldvein_resonance,if=variable.serenity_burst
 if serenity_burst() spell(worldvein_resonance)
 #blood_of_the_enemy,if=variable.serenity_burst
 if serenity_burst() spell(blood_of_the_enemy)
 #concentrated_flame,if=(cooldown.serenity.remains|cooldown.concentrated_flame.charges=2)&!dot.concentrated_flame_burn.remains&(cooldown.rising_sun_kick.remains&cooldown.fists_of_fury.remains|fight_remains<8)
 if { spellcooldown(serenity) > 0 or spellcharges(concentrated_flame) == 2 } and not target.debuffremaining(concentrated_flame_burn_debuff) and { spellcooldown(rising_sun_kick) > 0 and spellcooldown(fists_of_fury) > 0 or fightremains() < 8 } spell(concentrated_flame)
 #the_unbound_force
 spell(the_unbound_force)
 #memory_of_lucid_dreams,if=energy<40
 if energy() < 40 spell(memory_of_lucid_dreams)
 #ripple_in_space
 spell(ripple_in_space)
 #berserking,if=fight_remains>185|variable.serenity_burst
 if fightremains() > 185 or serenity_burst() spell(berserking)
 #touch_of_death
 if not checkboxon(opt_touch_of_death_on_elite_only) or not unitinraid() and target.classification(elite) or target.classification(worldboss) or not buffexpires(hidden_masters_forbidden_touch_buff) spell(touch_of_death)
}

AddFunction windwalkercd_serenitymainpostconditions
{
}

AddFunction windwalkercd_serenityshortcdactions
{
 unless serenity_burst() and spell(worldvein_resonance) or serenity_burst() and spell(blood_of_the_enemy) or { spellcooldown(serenity) > 0 or spellcharges(concentrated_flame) == 2 } and not target.debuffremaining(concentrated_flame_burn_debuff) and { spellcooldown(rising_sun_kick) > 0 and spellcooldown(fists_of_fury) > 0 or fightremains() < 8 } and spell(concentrated_flame) or spell(the_unbound_force)
 {
  #purifying_blast
  spell(purifying_blast)
  #reaping_flames,if=target.time_to_pct_20>30|target.health.pct<=20|target.time_to_die<2
  if target.timetohealthpercent(20) > 30 or target.healthpercent() <= 20 or target.timetodie() < 2 spell(reaping_flames)
  #focused_azerite_beam
  spell(focused_azerite_beam)

  unless energy() < 40 and spell(memory_of_lucid_dreams) or spell(ripple_in_space) or { fightremains() > 185 or serenity_burst() } and spell(berserking)
  {
   #bag_of_tricks,if=variable.serenity_burst
   if serenity_burst() spell(bag_of_tricks)

   unless { not checkboxon(opt_touch_of_death_on_elite_only) or not unitinraid() and target.classification(elite) or target.classification(worldboss) or not buffexpires(hidden_masters_forbidden_touch_buff) } and spell(touch_of_death)
   {
    #touch_of_karma,interval=90,pct_health=0.5
    if checkboxon(opt_touch_of_karma) spell(touch_of_karma)
    #serenity,if=cooldown.rising_sun_kick.remains<2|fight_remains<15
    if spellcooldown(rising_sun_kick) < 2 or fightremains() < 15 spell(serenity)
    #bag_of_tricks
    spell(bag_of_tricks)
   }
  }
 }
}

AddFunction windwalkercd_serenityshortcdpostconditions
{
 serenity_burst() and spell(worldvein_resonance) or serenity_burst() and spell(blood_of_the_enemy) or { spellcooldown(serenity) > 0 or spellcharges(concentrated_flame) == 2 } and not target.debuffremaining(concentrated_flame_burn_debuff) and { spellcooldown(rising_sun_kick) > 0 and spellcooldown(fists_of_fury) > 0 or fightremains() < 8 } and spell(concentrated_flame) or spell(the_unbound_force) or energy() < 40 and spell(memory_of_lucid_dreams) or spell(ripple_in_space) or { fightremains() > 185 or serenity_burst() } and spell(berserking) or { not checkboxon(opt_touch_of_death_on_elite_only) or not unitinraid() and target.classification(elite) or target.classification(worldboss) or not buffexpires(hidden_masters_forbidden_touch_buff) } and spell(touch_of_death)
}

AddFunction windwalkercd_serenitycdactions
{
 #variable,name=serenity_burst,op=set,value=cooldown.serenity.remains<1|fight_remains<20
 #invoke_xuen_the_white_tiger,if=!variable.hold_xuen|fight_remains<25
 if not hold_xuen() or fightremains() < 25 spell(invoke_xuen_the_white_tiger)
 #guardian_of_azeroth,if=fight_remains>185|variable.serenity_burst|fight_remains<35
 if fightremains() > 185 or serenity_burst() or fightremains() < 35 spell(guardian_of_azeroth)

 unless serenity_burst() and spell(worldvein_resonance) or serenity_burst() and spell(blood_of_the_enemy) or { spellcooldown(serenity) > 0 or spellcharges(concentrated_flame) == 2 } and not target.debuffremaining(concentrated_flame_burn_debuff) and { spellcooldown(rising_sun_kick) > 0 and spellcooldown(fists_of_fury) > 0 or fightremains() < 8 } and spell(concentrated_flame) or spell(the_unbound_force) or spell(purifying_blast) or { target.timetohealthpercent(20) > 30 or target.healthpercent() <= 20 or target.timetodie() < 2 } and spell(reaping_flames) or spell(focused_azerite_beam) or energy() < 40 and spell(memory_of_lucid_dreams) or spell(ripple_in_space)
 {
  #blood_fury,if=fight_remains>125|variable.serenity_burst
  if fightremains() > 125 or serenity_burst() spell(blood_fury)

  unless { fightremains() > 185 or serenity_burst() } and spell(berserking)
  {
   #arcane_torrent,if=chi.max-chi>=1
   if maxchi() - chi() >= 1 spell(arcane_torrent)
   #lights_judgment
   spell(lights_judgment)
   #fireblood,if=fight_remains>125|variable.serenity_burst
   if fightremains() > 125 or serenity_burst() spell(fireblood)
   #ancestral_call,if=fight_remains>125|variable.serenity_burst
   if fightremains() > 125 or serenity_burst() spell(ancestral_call)

   unless serenity_burst() and spell(bag_of_tricks)
   {
    #use_item,name=ashvanes_razor_coral
    windwalkeruseitemactions()
   }
  }
 }
}

AddFunction windwalkercd_serenitycdpostconditions
{
 serenity_burst() and spell(worldvein_resonance) or serenity_burst() and spell(blood_of_the_enemy) or { spellcooldown(serenity) > 0 or spellcharges(concentrated_flame) == 2 } and not target.debuffremaining(concentrated_flame_burn_debuff) and { spellcooldown(rising_sun_kick) > 0 and spellcooldown(fists_of_fury) > 0 or fightremains() < 8 } and spell(concentrated_flame) or spell(the_unbound_force) or spell(purifying_blast) or { target.timetohealthpercent(20) > 30 or target.healthpercent() <= 20 or target.timetodie() < 2 } and spell(reaping_flames) or spell(focused_azerite_beam) or energy() < 40 and spell(memory_of_lucid_dreams) or spell(ripple_in_space) or { fightremains() > 185 or serenity_burst() } and spell(berserking) or serenity_burst() and spell(bag_of_tricks) or { not checkboxon(opt_touch_of_death_on_elite_only) or not unitinraid() and target.classification(elite) or target.classification(worldboss) or not buffexpires(hidden_masters_forbidden_touch_buff) } and spell(touch_of_death) or checkboxon(opt_touch_of_karma) and spell(touch_of_karma) or { spellcooldown(rising_sun_kick) < 2 or fightremains() < 15 } and spell(serenity) or spell(bag_of_tricks)
}

### actions.cd_sef

AddFunction windwalkercd_sefmainactions
{
 #touch_of_death,if=buff.storm_earth_and_fire.down
 if buffexpires(storm_earth_and_fire) and { not checkboxon(opt_touch_of_death_on_elite_only) or not unitinraid() and target.classification(elite) or target.classification(worldboss) or not buffexpires(hidden_masters_forbidden_touch_buff) } spell(touch_of_death)
 #blood_of_the_enemy,if=cooldown.fists_of_fury.remains<2|fight_remains<12
 if spellcooldown(fists_of_fury) < 2 or fightremains() < 12 spell(blood_of_the_enemy)
 #worldvein_resonance
 spell(worldvein_resonance)
 #concentrated_flame,if=!dot.concentrated_flame_burn.remains&((!talent.whirling_dragon_punch.enabled|cooldown.whirling_dragon_punch.remains)&cooldown.rising_sun_kick.remains&cooldown.fists_of_fury.remains&buff.storm_earth_and_fire.down)|fight_remains<8
 if not target.debuffremaining(concentrated_flame_burn_debuff) and { not hastalent(whirling_dragon_punch_talent) or spellcooldown(whirling_dragon_punch) > 0 } and spellcooldown(rising_sun_kick) > 0 and spellcooldown(fists_of_fury) > 0 and buffexpires(storm_earth_and_fire) or fightremains() < 8 spell(concentrated_flame)
 #the_unbound_force
 spell(the_unbound_force)
 #memory_of_lucid_dreams,if=energy<40
 if energy() < 40 spell(memory_of_lucid_dreams)
 #ripple_in_space
 spell(ripple_in_space)
 #storm_earth_and_fire,if=cooldown.storm_earth_and_fire.charges=2|fight_remains<20|buff.seething_rage.up|(cooldown.blood_of_the_enemy.remains+1>cooldown.storm_earth_and_fire.full_recharge_time|!essence.blood_of_the_enemy.major)&cooldown.fists_of_fury.remains<10&chi>=2&cooldown.whirling_dragon_punch.remains<12
 if { spellcharges(storm_earth_and_fire) == 2 or fightremains() < 20 or buffpresent(seething_rage) or { spellcooldown(blood_of_the_enemy) + 1 > spellcooldown(storm_earth_and_fire) or not azeriteessenceismajor(blood_of_the_enemy_essence_id) } and spellcooldown(fists_of_fury) < 10 and chi() >= 2 and spellcooldown(whirling_dragon_punch) < 12 } and checkboxon(opt_storm_earth_and_fire) and not buffpresent(storm_earth_and_fire_buff) spell(storm_earth_and_fire)
 #berserking,if=fight_remains>185|buff.storm_earth_and_fire.up|fight_remains<20
 if fightremains() > 185 or buffpresent(storm_earth_and_fire) or fightremains() < 20 spell(berserking)
}

AddFunction windwalkercd_sefmainpostconditions
{
}

AddFunction windwalkercd_sefshortcdactions
{
 unless buffexpires(storm_earth_and_fire) and { not checkboxon(opt_touch_of_death_on_elite_only) or not unitinraid() and target.classification(elite) or target.classification(worldboss) or not buffexpires(hidden_masters_forbidden_touch_buff) } and spell(touch_of_death) or { spellcooldown(fists_of_fury) < 2 or fightremains() < 12 } and spell(blood_of_the_enemy) or spell(worldvein_resonance) or { not target.debuffremaining(concentrated_flame_burn_debuff) and { not hastalent(whirling_dragon_punch_talent) or spellcooldown(whirling_dragon_punch) > 0 } and spellcooldown(rising_sun_kick) > 0 and spellcooldown(fists_of_fury) > 0 and buffexpires(storm_earth_and_fire) or fightremains() < 8 } and spell(concentrated_flame) or spell(the_unbound_force)
 {
  #purifying_blast
  spell(purifying_blast)
  #reaping_flames,if=target.time_to_pct_20>30|target.health.pct<=20
  if target.timetohealthpercent(20) > 30 or target.healthpercent() <= 20 spell(reaping_flames)
  #focused_azerite_beam
  spell(focused_azerite_beam)

  unless energy() < 40 and spell(memory_of_lucid_dreams) or spell(ripple_in_space) or { spellcharges(storm_earth_and_fire) == 2 or fightremains() < 20 or buffpresent(seething_rage) or { spellcooldown(blood_of_the_enemy) + 1 > spellcooldown(storm_earth_and_fire) or not azeriteessenceismajor(blood_of_the_enemy_essence_id) } and spellcooldown(fists_of_fury) < 10 and chi() >= 2 and spellcooldown(whirling_dragon_punch) < 12 } and checkboxon(opt_storm_earth_and_fire) and not buffpresent(storm_earth_and_fire_buff) and spell(storm_earth_and_fire)
  {
   #touch_of_karma,interval=90,pct_health=0.5
   if checkboxon(opt_touch_of_karma) spell(touch_of_karma)

   unless { fightremains() > 185 or buffpresent(storm_earth_and_fire) or fightremains() < 20 } and spell(berserking)
   {
    #bag_of_tricks,if=buff.storm_earth_and_fire.down
    if buffexpires(storm_earth_and_fire) spell(bag_of_tricks)
   }
  }
 }
}

AddFunction windwalkercd_sefshortcdpostconditions
{
 buffexpires(storm_earth_and_fire) and { not checkboxon(opt_touch_of_death_on_elite_only) or not unitinraid() and target.classification(elite) or target.classification(worldboss) or not buffexpires(hidden_masters_forbidden_touch_buff) } and spell(touch_of_death) or { spellcooldown(fists_of_fury) < 2 or fightremains() < 12 } and spell(blood_of_the_enemy) or spell(worldvein_resonance) or { not target.debuffremaining(concentrated_flame_burn_debuff) and { not hastalent(whirling_dragon_punch_talent) or spellcooldown(whirling_dragon_punch) > 0 } and spellcooldown(rising_sun_kick) > 0 and spellcooldown(fists_of_fury) > 0 and buffexpires(storm_earth_and_fire) or fightremains() < 8 } and spell(concentrated_flame) or spell(the_unbound_force) or energy() < 40 and spell(memory_of_lucid_dreams) or spell(ripple_in_space) or { spellcharges(storm_earth_and_fire) == 2 or fightremains() < 20 or buffpresent(seething_rage) or { spellcooldown(blood_of_the_enemy) + 1 > spellcooldown(storm_earth_and_fire) or not azeriteessenceismajor(blood_of_the_enemy_essence_id) } and spellcooldown(fists_of_fury) < 10 and chi() >= 2 and spellcooldown(whirling_dragon_punch) < 12 } and checkboxon(opt_storm_earth_and_fire) and not buffpresent(storm_earth_and_fire_buff) and spell(storm_earth_and_fire) or { fightremains() > 185 or buffpresent(storm_earth_and_fire) or fightremains() < 20 } and spell(berserking)
}

AddFunction windwalkercd_sefcdactions
{
 #invoke_xuen_the_white_tiger,if=!variable.hold_xuen|fight_remains<25
 if not hold_xuen() or fightremains() < 25 spell(invoke_xuen_the_white_tiger)
 #arcane_torrent,if=chi.max-chi>=1
 if maxchi() - chi() >= 1 spell(arcane_torrent)

 unless buffexpires(storm_earth_and_fire) and { not checkboxon(opt_touch_of_death_on_elite_only) or not unitinraid() and target.classification(elite) or target.classification(worldboss) or not buffexpires(hidden_masters_forbidden_touch_buff) } and spell(touch_of_death) or { spellcooldown(fists_of_fury) < 2 or fightremains() < 12 } and spell(blood_of_the_enemy)
 {
  #guardian_of_azeroth
  spell(guardian_of_azeroth)

  unless spell(worldvein_resonance) or { not target.debuffremaining(concentrated_flame_burn_debuff) and { not hastalent(whirling_dragon_punch_talent) or spellcooldown(whirling_dragon_punch) > 0 } and spellcooldown(rising_sun_kick) > 0 and spellcooldown(fists_of_fury) > 0 and buffexpires(storm_earth_and_fire) or fightremains() < 8 } and spell(concentrated_flame) or spell(the_unbound_force) or spell(purifying_blast) or { target.timetohealthpercent(20) > 30 or target.healthpercent() <= 20 } and spell(reaping_flames) or spell(focused_azerite_beam) or energy() < 40 and spell(memory_of_lucid_dreams) or spell(ripple_in_space) or { spellcharges(storm_earth_and_fire) == 2 or fightremains() < 20 or buffpresent(seething_rage) or { spellcooldown(blood_of_the_enemy) + 1 > spellcooldown(storm_earth_and_fire) or not azeriteessenceismajor(blood_of_the_enemy_essence_id) } and spellcooldown(fists_of_fury) < 10 and chi() >= 2 and spellcooldown(whirling_dragon_punch) < 12 } and checkboxon(opt_storm_earth_and_fire) and not buffpresent(storm_earth_and_fire_buff) and spell(storm_earth_and_fire)
  {
   #use_item,name=ashvanes_razor_coral
   windwalkeruseitemactions()

   unless checkboxon(opt_touch_of_karma) and spell(touch_of_karma)
   {
    #blood_fury,if=fight_remains>125|buff.storm_earth_and_fire.up|fight_remains<20
    if fightremains() > 125 or buffpresent(storm_earth_and_fire) or fightremains() < 20 spell(blood_fury)

    unless { fightremains() > 185 or buffpresent(storm_earth_and_fire) or fightremains() < 20 } and spell(berserking)
    {
     #lights_judgment
     spell(lights_judgment)
     #fireblood,if=fight_remains>125|buff.storm_earth_and_fire.up|fight_remains<20
     if fightremains() > 125 or buffpresent(storm_earth_and_fire) or fightremains() < 20 spell(fireblood)
     #ancestral_call,if=fight_remains>185|buff.storm_earth_and_fire.up|fight_remains<20
     if fightremains() > 185 or buffpresent(storm_earth_and_fire) or fightremains() < 20 spell(ancestral_call)
    }
   }
  }
 }
}

AddFunction windwalkercd_sefcdpostconditions
{
 buffexpires(storm_earth_and_fire) and { not checkboxon(opt_touch_of_death_on_elite_only) or not unitinraid() and target.classification(elite) or target.classification(worldboss) or not buffexpires(hidden_masters_forbidden_touch_buff) } and spell(touch_of_death) or { spellcooldown(fists_of_fury) < 2 or fightremains() < 12 } and spell(blood_of_the_enemy) or spell(worldvein_resonance) or { not target.debuffremaining(concentrated_flame_burn_debuff) and { not hastalent(whirling_dragon_punch_talent) or spellcooldown(whirling_dragon_punch) > 0 } and spellcooldown(rising_sun_kick) > 0 and spellcooldown(fists_of_fury) > 0 and buffexpires(storm_earth_and_fire) or fightremains() < 8 } and spell(concentrated_flame) or spell(the_unbound_force) or spell(purifying_blast) or { target.timetohealthpercent(20) > 30 or target.healthpercent() <= 20 } and spell(reaping_flames) or spell(focused_azerite_beam) or energy() < 40 and spell(memory_of_lucid_dreams) or spell(ripple_in_space) or { spellcharges(storm_earth_and_fire) == 2 or fightremains() < 20 or buffpresent(seething_rage) or { spellcooldown(blood_of_the_enemy) + 1 > spellcooldown(storm_earth_and_fire) or not azeriteessenceismajor(blood_of_the_enemy_essence_id) } and spellcooldown(fists_of_fury) < 10 and chi() >= 2 and spellcooldown(whirling_dragon_punch) < 12 } and checkboxon(opt_storm_earth_and_fire) and not buffpresent(storm_earth_and_fire_buff) and spell(storm_earth_and_fire) or checkboxon(opt_touch_of_karma) and spell(touch_of_karma) or { fightremains() > 185 or buffpresent(storm_earth_and_fire) or fightremains() < 20 } and spell(berserking) or buffexpires(storm_earth_and_fire) and spell(bag_of_tricks)
}

### actions.aoe

AddFunction windwalkeraoemainactions
{
 #whirling_dragon_punch
 if spellcooldown(fists_of_fury) > 0 and spellcooldown(rising_sun_kick) > 0 spell(whirling_dragon_punch)
 #spinning_crane_kick,if=combo_strike&(buff.dance_of_chiji.up|buff.dance_of_chiji_azerite.up)
 if not previousspell(spinning_crane_kick) and { buffpresent(dance_of_chiji_buff) or buffpresent(dance_of_chiji_azerite_buff) } spell(spinning_crane_kick)
 #fists_of_fury,if=energy.time_to_max>execute_time-1|buff.storm_earth_and_fire.remains
 if timetomaxenergy() > executetime(fists_of_fury) - 1 or buffpresent(storm_earth_and_fire) spell(fists_of_fury)
 #rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=(talent.whirling_dragon_punch.enabled&cooldown.rising_sun_kick.duration>cooldown.whirling_dragon_punch.remains+3)&(cooldown.fists_of_fury.remains>3|chi>=5)
 if hastalent(whirling_dragon_punch_talent) and spellcooldownduration(rising_sun_kick) > spellcooldown(whirling_dragon_punch) + 3 and { spellcooldown(fists_of_fury) > 3 or chi() >= 5 } spell(rising_sun_kick)
 #rushing_jade_wind,if=buff.rushing_jade_wind.down
 if buffexpires(rushing_jade_wind) spell(rushing_jade_wind)
 #spinning_crane_kick,if=combo_strike&((chi>3|cooldown.fists_of_fury.remains>6)&(chi>=5|cooldown.fists_of_fury.remains>2)|energy.time_to_max<=3)
 if not previousspell(spinning_crane_kick) and { { chi() > 3 or spellcooldown(fists_of_fury) > 6 } and { chi() >= 5 or spellcooldown(fists_of_fury) > 2 } or timetomaxenergy() <= 3 } spell(spinning_crane_kick)
 #expel_harm,if=chi.max-chi>=1+essence.conflict_and_strife.major
 if maxchi() - chi() >= 1 + azeriteessenceismajor(conflict_and_strife_essence_id) spell(expel_harm)
 #tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=chi.max-chi>=2&(!talent.hit_combo.enabled|combo_strike)
 if maxchi() - chi() >= 2 and { not hastalent(hit_combo_talent) or not previousspell(tiger_palm) } spell(tiger_palm)
 #chi_wave,if=combo_strike
 if not previousspell(chi_wave) spell(chi_wave)
 #flying_serpent_kick,if=buff.bok_proc.down,interrupt=1
 if buffexpires(bok_proc_buff) and checkboxon(opt_flying_serpent_kick) spell(flying_serpent_kick)
 #blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&(buff.bok_proc.up|talent.hit_combo.enabled&prev_gcd.1.tiger_palm&(chi.max-chi>=14&energy.time_to_50<1|chi=2&cooldown.fists_of_fury.remains<3))
 if not previousspell(blackout_kick) and { buffpresent(bok_proc_buff) or hastalent(hit_combo_talent) and previousgcdspell(tiger_palm) and { maxchi() - chi() >= 14 and message("energy.time_to_50 is not implemented") < 1 or chi() == 2 and spellcooldown(fists_of_fury) < 3 } } spell(blackout_kick)
}

AddFunction windwalkeraoemainpostconditions
{
}

AddFunction windwalkeraoeshortcdactions
{
 unless spellcooldown(fists_of_fury) > 0 and spellcooldown(rising_sun_kick) > 0 and spell(whirling_dragon_punch)
 {
  #energizing_elixir,if=chi.max-chi>=2&energy.time_to_max>3|chi.max-chi>=4&(energy.time_to_max>2|!prev_gcd.1.tiger_palm)
  if maxchi() - chi() >= 2 and timetomaxenergy() > 3 or maxchi() - chi() >= 4 and { timetomaxenergy() > 2 or not previousgcdspell(tiger_palm) } spell(energizing_elixir)

  unless not previousspell(spinning_crane_kick) and { buffpresent(dance_of_chiji_buff) or buffpresent(dance_of_chiji_azerite_buff) } and spell(spinning_crane_kick) or { timetomaxenergy() > executetime(fists_of_fury) - 1 or buffpresent(storm_earth_and_fire) } and spell(fists_of_fury) or hastalent(whirling_dragon_punch_talent) and spellcooldownduration(rising_sun_kick) > spellcooldown(whirling_dragon_punch) + 3 and { spellcooldown(fists_of_fury) > 3 or chi() >= 5 } and spell(rising_sun_kick) or buffexpires(rushing_jade_wind) and spell(rushing_jade_wind) or not previousspell(spinning_crane_kick) and { { chi() > 3 or spellcooldown(fists_of_fury) > 6 } and { chi() >= 5 or spellcooldown(fists_of_fury) > 2 } or timetomaxenergy() <= 3 } and spell(spinning_crane_kick) or maxchi() - chi() >= 1 + azeriteessenceismajor(conflict_and_strife_essence_id) and spell(expel_harm)
  {
   #chi_burst,if=chi.max-chi>=1
   if maxchi() - chi() >= 1 and checkboxon(opt_chi_burst) spell(chi_burst)
   #fist_of_the_white_tiger,target_if=min:debuff.mark_of_the_crane.remains,if=chi.max-chi>=3
   if maxchi() - chi() >= 3 spell(fist_of_the_white_tiger)
  }
 }
}

AddFunction windwalkeraoeshortcdpostconditions
{
 spellcooldown(fists_of_fury) > 0 and spellcooldown(rising_sun_kick) > 0 and spell(whirling_dragon_punch) or not previousspell(spinning_crane_kick) and { buffpresent(dance_of_chiji_buff) or buffpresent(dance_of_chiji_azerite_buff) } and spell(spinning_crane_kick) or { timetomaxenergy() > executetime(fists_of_fury) - 1 or buffpresent(storm_earth_and_fire) } and spell(fists_of_fury) or hastalent(whirling_dragon_punch_talent) and spellcooldownduration(rising_sun_kick) > spellcooldown(whirling_dragon_punch) + 3 and { spellcooldown(fists_of_fury) > 3 or chi() >= 5 } and spell(rising_sun_kick) or buffexpires(rushing_jade_wind) and spell(rushing_jade_wind) or not previousspell(spinning_crane_kick) and { { chi() > 3 or spellcooldown(fists_of_fury) > 6 } and { chi() >= 5 or spellcooldown(fists_of_fury) > 2 } or timetomaxenergy() <= 3 } and spell(spinning_crane_kick) or maxchi() - chi() >= 1 + azeriteessenceismajor(conflict_and_strife_essence_id) and spell(expel_harm) or maxchi() - chi() >= 2 and { not hastalent(hit_combo_talent) or not previousspell(tiger_palm) } and spell(tiger_palm) or not previousspell(chi_wave) and spell(chi_wave) or buffexpires(bok_proc_buff) and checkboxon(opt_flying_serpent_kick) and spell(flying_serpent_kick) or not previousspell(blackout_kick) and { buffpresent(bok_proc_buff) or hastalent(hit_combo_talent) and previousgcdspell(tiger_palm) and { maxchi() - chi() >= 14 and message("energy.time_to_50 is not implemented") < 1 or chi() == 2 and spellcooldown(fists_of_fury) < 3 } } and spell(blackout_kick)
}

AddFunction windwalkeraoecdactions
{
}

AddFunction windwalkeraoecdpostconditions
{
 spellcooldown(fists_of_fury) > 0 and spellcooldown(rising_sun_kick) > 0 and spell(whirling_dragon_punch) or { maxchi() - chi() >= 2 and timetomaxenergy() > 3 or maxchi() - chi() >= 4 and { timetomaxenergy() > 2 or not previousgcdspell(tiger_palm) } } and spell(energizing_elixir) or not previousspell(spinning_crane_kick) and { buffpresent(dance_of_chiji_buff) or buffpresent(dance_of_chiji_azerite_buff) } and spell(spinning_crane_kick) or { timetomaxenergy() > executetime(fists_of_fury) - 1 or buffpresent(storm_earth_and_fire) } and spell(fists_of_fury) or hastalent(whirling_dragon_punch_talent) and spellcooldownduration(rising_sun_kick) > spellcooldown(whirling_dragon_punch) + 3 and { spellcooldown(fists_of_fury) > 3 or chi() >= 5 } and spell(rising_sun_kick) or buffexpires(rushing_jade_wind) and spell(rushing_jade_wind) or not previousspell(spinning_crane_kick) and { { chi() > 3 or spellcooldown(fists_of_fury) > 6 } and { chi() >= 5 or spellcooldown(fists_of_fury) > 2 } or timetomaxenergy() <= 3 } and spell(spinning_crane_kick) or maxchi() - chi() >= 1 + azeriteessenceismajor(conflict_and_strife_essence_id) and spell(expel_harm) or maxchi() - chi() >= 1 and checkboxon(opt_chi_burst) and spell(chi_burst) or maxchi() - chi() >= 3 and spell(fist_of_the_white_tiger) or maxchi() - chi() >= 2 and { not hastalent(hit_combo_talent) or not previousspell(tiger_palm) } and spell(tiger_palm) or not previousspell(chi_wave) and spell(chi_wave) or buffexpires(bok_proc_buff) and checkboxon(opt_flying_serpent_kick) and spell(flying_serpent_kick) or not previousspell(blackout_kick) and { buffpresent(bok_proc_buff) or hastalent(hit_combo_talent) and previousgcdspell(tiger_palm) and { maxchi() - chi() >= 14 and message("energy.time_to_50 is not implemented") < 1 or chi() == 2 and spellcooldown(fists_of_fury) < 3 } } and spell(blackout_kick)
}

### actions.default

AddFunction windwalker_defaultmainactions
{
 #call_action_list,name=serenity,if=buff.serenity.up
 if buffpresent(serenity) windwalkerserenitymainactions()

 unless buffpresent(serenity) and windwalkerserenitymainpostconditions()
 {
  #call_action_list,name=opener,if=time<5&chi<5&!pet.xuen_the_white_tiger.active
  if timeincombat() < 5 and chi() < 5 and not pet.present() windwalkeropenermainactions()

  unless timeincombat() < 5 and chi() < 5 and not pet.present() and windwalkeropenermainpostconditions()
  {
   #expel_harm,if=chi.max-chi>=1+essence.conflict_and_strife.major&(energy.time_to_max<1|cooldown.serenity.remains<2|energy.time_to_max<4&cooldown.fists_of_fury.remains<1.5)
   if maxchi() - chi() >= 1 + azeriteessenceismajor(conflict_and_strife_essence_id) and { timetomaxenergy() < 1 or spellcooldown(serenity) < 2 or timetomaxenergy() < 4 and spellcooldown(fists_of_fury) < 1.5 } spell(expel_harm)
   #tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&chi.max-chi>=2&(energy.time_to_max<1|cooldown.serenity.remains<2|energy.time_to_max<4&cooldown.fists_of_fury.remains<1.5)
   if not previousspell(tiger_palm) and maxchi() - chi() >= 2 and { timetomaxenergy() < 1 or spellcooldown(serenity) < 2 or timetomaxenergy() < 4 and spellcooldown(fists_of_fury) < 1.5 } spell(tiger_palm)
   #call_action_list,name=cd_sef,if=!talent.serenity.enabled
   if not hastalent(serenity_talent) windwalkercd_sefmainactions()

   unless not hastalent(serenity_talent) and windwalkercd_sefmainpostconditions()
   {
    #call_action_list,name=cd_serenity,if=talent.serenity.enabled
    if hastalent(serenity_talent) windwalkercd_serenitymainactions()

    unless hastalent(serenity_talent) and windwalkercd_serenitymainpostconditions()
    {
     #call_action_list,name=st,if=active_enemies<3
     if enemies() < 3 windwalkerstmainactions()

     unless enemies() < 3 and windwalkerstmainpostconditions()
     {
      #call_action_list,name=aoe,if=active_enemies>=3
      if enemies() >= 3 windwalkeraoemainactions()
     }
    }
   }
  }
 }
}

AddFunction windwalker_defaultmainpostconditions
{
 buffpresent(serenity) and windwalkerserenitymainpostconditions() or timeincombat() < 5 and chi() < 5 and not pet.present() and windwalkeropenermainpostconditions() or not hastalent(serenity_talent) and windwalkercd_sefmainpostconditions() or hastalent(serenity_talent) and windwalkercd_serenitymainpostconditions() or enemies() < 3 and windwalkerstmainpostconditions() or enemies() >= 3 and windwalkeraoemainpostconditions()
}

AddFunction windwalker_defaultshortcdactions
{
 #auto_attack
 windwalkergetinmeleerange()
 #call_action_list,name=serenity,if=buff.serenity.up
 if buffpresent(serenity) windwalkerserenityshortcdactions()

 unless buffpresent(serenity) and windwalkerserenityshortcdpostconditions()
 {
  #call_action_list,name=opener,if=time<5&chi<5&!pet.xuen_the_white_tiger.active
  if timeincombat() < 5 and chi() < 5 and not pet.present() windwalkeropenershortcdactions()

  unless timeincombat() < 5 and chi() < 5 and not pet.present() and windwalkeropenershortcdpostconditions()
  {
   #fist_of_the_white_tiger,target_if=min:debuff.mark_of_the_crane.remains,if=chi.max-chi>=3&(energy.time_to_max<1|energy.time_to_max<4&cooldown.fists_of_fury.remains<1.5)
   if maxchi() - chi() >= 3 and { timetomaxenergy() < 1 or timetomaxenergy() < 4 and spellcooldown(fists_of_fury) < 1.5 } spell(fist_of_the_white_tiger)

   unless maxchi() - chi() >= 1 + azeriteessenceismajor(conflict_and_strife_essence_id) and { timetomaxenergy() < 1 or spellcooldown(serenity) < 2 or timetomaxenergy() < 4 and spellcooldown(fists_of_fury) < 1.5 } and spell(expel_harm) or not previousspell(tiger_palm) and maxchi() - chi() >= 2 and { timetomaxenergy() < 1 or spellcooldown(serenity) < 2 or timetomaxenergy() < 4 and spellcooldown(fists_of_fury) < 1.5 } and spell(tiger_palm)
   {
    #call_action_list,name=cd_sef,if=!talent.serenity.enabled
    if not hastalent(serenity_talent) windwalkercd_sefshortcdactions()

    unless not hastalent(serenity_talent) and windwalkercd_sefshortcdpostconditions()
    {
     #call_action_list,name=cd_serenity,if=talent.serenity.enabled
     if hastalent(serenity_talent) windwalkercd_serenityshortcdactions()

     unless hastalent(serenity_talent) and windwalkercd_serenityshortcdpostconditions()
     {
      #call_action_list,name=st,if=active_enemies<3
      if enemies() < 3 windwalkerstshortcdactions()

      unless enemies() < 3 and windwalkerstshortcdpostconditions()
      {
       #call_action_list,name=aoe,if=active_enemies>=3
       if enemies() >= 3 windwalkeraoeshortcdactions()
      }
     }
    }
   }
  }
 }
}

AddFunction windwalker_defaultshortcdpostconditions
{
 buffpresent(serenity) and windwalkerserenityshortcdpostconditions() or timeincombat() < 5 and chi() < 5 and not pet.present() and windwalkeropenershortcdpostconditions() or maxchi() - chi() >= 1 + azeriteessenceismajor(conflict_and_strife_essence_id) and { timetomaxenergy() < 1 or spellcooldown(serenity) < 2 or timetomaxenergy() < 4 and spellcooldown(fists_of_fury) < 1.5 } and spell(expel_harm) or not previousspell(tiger_palm) and maxchi() - chi() >= 2 and { timetomaxenergy() < 1 or spellcooldown(serenity) < 2 or timetomaxenergy() < 4 and spellcooldown(fists_of_fury) < 1.5 } and spell(tiger_palm) or not hastalent(serenity_talent) and windwalkercd_sefshortcdpostconditions() or hastalent(serenity_talent) and windwalkercd_serenityshortcdpostconditions() or enemies() < 3 and windwalkerstshortcdpostconditions() or enemies() >= 3 and windwalkeraoeshortcdpostconditions()
}

AddFunction windwalker_defaultcdactions
{
 #spear_hand_strike,if=target.debuff.casting.react
 if target.isinterruptible() windwalkerinterruptactions()
 #variable,name=hold_xuen,op=set,value=cooldown.invoke_xuen_the_white_tiger.remains>fight_remains|fight_remains<120&fight_remains>cooldown.serenity.remains&cooldown.serenity.remains>10
 #potion,if=(buff.serenity.up|buff.storm_earth_and_fire.up)&pet.xuen_the_white_tiger.active|fight_remains<=60
 if { { buffpresent(serenity) or buffpresent(storm_earth_and_fire) } and pet.present() or fightremains() <= 60 } and checkboxon(opt_use_consumables) and target.classification(worldboss) item(unbridled_fury_item usable=1)
 #call_action_list,name=serenity,if=buff.serenity.up
 if buffpresent(serenity) windwalkerserenitycdactions()

 unless buffpresent(serenity) and windwalkerserenitycdpostconditions()
 {
  #call_action_list,name=opener,if=time<5&chi<5&!pet.xuen_the_white_tiger.active
  if timeincombat() < 5 and chi() < 5 and not pet.present() windwalkeropenercdactions()

  unless timeincombat() < 5 and chi() < 5 and not pet.present() and windwalkeropenercdpostconditions() or maxchi() - chi() >= 3 and { timetomaxenergy() < 1 or timetomaxenergy() < 4 and spellcooldown(fists_of_fury) < 1.5 } and spell(fist_of_the_white_tiger) or maxchi() - chi() >= 1 + azeriteessenceismajor(conflict_and_strife_essence_id) and { timetomaxenergy() < 1 or spellcooldown(serenity) < 2 or timetomaxenergy() < 4 and spellcooldown(fists_of_fury) < 1.5 } and spell(expel_harm) or not previousspell(tiger_palm) and maxchi() - chi() >= 2 and { timetomaxenergy() < 1 or spellcooldown(serenity) < 2 or timetomaxenergy() < 4 and spellcooldown(fists_of_fury) < 1.5 } and spell(tiger_palm)
  {
   #call_action_list,name=cd_sef,if=!talent.serenity.enabled
   if not hastalent(serenity_talent) windwalkercd_sefcdactions()

   unless not hastalent(serenity_talent) and windwalkercd_sefcdpostconditions()
   {
    #call_action_list,name=cd_serenity,if=talent.serenity.enabled
    if hastalent(serenity_talent) windwalkercd_serenitycdactions()

    unless hastalent(serenity_talent) and windwalkercd_serenitycdpostconditions()
    {
     #call_action_list,name=st,if=active_enemies<3
     if enemies() < 3 windwalkerstcdactions()

     unless enemies() < 3 and windwalkerstcdpostconditions()
     {
      #call_action_list,name=aoe,if=active_enemies>=3
      if enemies() >= 3 windwalkeraoecdactions()
     }
    }
   }
  }
 }
}

AddFunction windwalker_defaultcdpostconditions
{
 buffpresent(serenity) and windwalkerserenitycdpostconditions() or timeincombat() < 5 and chi() < 5 and not pet.present() and windwalkeropenercdpostconditions() or maxchi() - chi() >= 3 and { timetomaxenergy() < 1 or timetomaxenergy() < 4 and spellcooldown(fists_of_fury) < 1.5 } and spell(fist_of_the_white_tiger) or maxchi() - chi() >= 1 + azeriteessenceismajor(conflict_and_strife_essence_id) and { timetomaxenergy() < 1 or spellcooldown(serenity) < 2 or timetomaxenergy() < 4 and spellcooldown(fists_of_fury) < 1.5 } and spell(expel_harm) or not previousspell(tiger_palm) and maxchi() - chi() >= 2 and { timetomaxenergy() < 1 or spellcooldown(serenity) < 2 or timetomaxenergy() < 4 and spellcooldown(fists_of_fury) < 1.5 } and spell(tiger_palm) or not hastalent(serenity_talent) and windwalkercd_sefcdpostconditions() or hastalent(serenity_talent) and windwalkercd_serenitycdpostconditions() or enemies() < 3 and windwalkerstcdpostconditions() or enemies() >= 3 and windwalkeraoecdpostconditions()
}

### Windwalker icons.

AddCheckBox(opt_monk_windwalker_aoe l(aoe) default specialization=windwalker)

AddIcon checkbox=!opt_monk_windwalker_aoe enemies=1 help=shortcd specialization=windwalker
{
 if not incombat() windwalkerprecombatshortcdactions()
 windwalker_defaultshortcdactions()
}

AddIcon checkbox=opt_monk_windwalker_aoe help=shortcd specialization=windwalker
{
 if not incombat() windwalkerprecombatshortcdactions()
 windwalker_defaultshortcdactions()
}

AddIcon enemies=1 help=main specialization=windwalker
{
 if not incombat() windwalkerprecombatmainactions()
 windwalker_defaultmainactions()
}

AddIcon checkbox=opt_monk_windwalker_aoe help=aoe specialization=windwalker
{
 if not incombat() windwalkerprecombatmainactions()
 windwalker_defaultmainactions()
}

AddIcon checkbox=!opt_monk_windwalker_aoe enemies=1 help=cd specialization=windwalker
{
 if not incombat() windwalkerprecombatcdactions()
 windwalker_defaultcdactions()
}

AddIcon checkbox=opt_monk_windwalker_aoe help=cd specialization=windwalker
{
 if not incombat() windwalkerprecombatcdactions()
 windwalker_defaultcdactions()
}

### Required symbols
# ancestral_call
# arcane_torrent
# bag_of_tricks
# berserking
# blackout_kick
# blood_fury
# blood_of_the_enemy
# blood_of_the_enemy_essence_id
# bok_proc_buff
# chi_burst
# chi_burst_talent
# chi_energy
# chi_wave
# concentrated_flame
# concentrated_flame_burn_debuff
# conflict_and_strife_essence_id
# dance_of_chiji_azerite_buff
# dance_of_chiji_buff
# energizing_elixer_talent
# energizing_elixir
# expel_harm
# fireblood
# fist_of_the_white_tiger
# fist_of_the_white_tiger_talent
# fists_of_fury
# flying_serpent_kick
# focused_azerite_beam
# guardian_of_azeroth
# hidden_masters_forbidden_touch_buff
# hit_combo_talent
# invoke_xuen_the_white_tiger
# leg_sweep
# lights_judgment
# memory_of_lucid_dreams
# paralysis
# purifying_blast
# quaking_palm
# reaping_flames
# ripple_in_space
# rising_sun_kick
# rushing_jade_wind
# seething_rage
# serenity
# serenity_talent
# spear_hand_strike
# spinning_crane_kick
# storm_earth_and_fire
# the_unbound_force
# tiger_palm
# touch_of_death
# touch_of_karma
# unbridled_fury_item
# war_stomp
# whirling_dragon_punch
# whirling_dragon_punch_talent
# worldvein_resonance
]]
        OvaleScripts:RegisterScript("MONK", "windwalker", name, desc, code, "script")
    end
end
