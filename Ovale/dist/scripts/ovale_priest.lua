local __exports = LibStub:NewLibrary("ovale/scripts/ovale_priest", 80300)
if not __exports then return end
__exports.registerPriest = function(OvaleScripts)
    do
        local name = "sc_t25_priest_discipline"
        local desc = "[9.0] Simulationcraft: T25_Priest_Discipline"
        local code = [[
# Based on SimulationCraft profile "T25_Priest_Discipline".
#	class=priest
#	spec=discipline
#	talents=3020110

Include(ovale_common)
Include(ovale_priest_spells)

AddFunction disciplineuseitemactions
{
 item(trinket0slot text=13 usable=1)
 item(trinket1slot text=14 usable=1)
}

### actions.precombat

AddFunction disciplineprecombatmainactions
{
}

AddFunction disciplineprecombatmainpostconditions
{
}

AddFunction disciplineprecombatshortcdactions
{
}

AddFunction disciplineprecombatshortcdpostconditions
{
}

AddFunction disciplineprecombatcdactions
{
}

AddFunction disciplineprecombatcdpostconditions
{
}

### actions.boon

AddFunction disciplineboonmainactions
{
 #ascended_blast
 spell(ascended_blast)
 #ascended_nova
 spell(ascended_nova)
}

AddFunction disciplineboonmainpostconditions
{
}

AddFunction disciplineboonshortcdactions
{
}

AddFunction disciplineboonshortcdpostconditions
{
 spell(ascended_blast) or spell(ascended_nova)
}

AddFunction disciplinebooncdactions
{
}

AddFunction disciplinebooncdpostconditions
{
 spell(ascended_blast) or spell(ascended_nova)
}

### actions.default

AddFunction discipline_defaultmainactions
{
 #berserking
 spell(berserking)
 #purge_the_wicked,if=!ticking
 if not target.debuffpresent(purge_the_wicked_debuff) spell(purge_the_wicked)
 #shadow_word_pain,if=!ticking&!talent.purge_the_wicked.enabled
 if not buffpresent(shadow_word_pain) and not hastalent(purge_the_wicked_talent) spell(shadow_word_pain)
 #schism
 spell(schism)
 #mind_blast
 spell(mind_blast)
 #penance
 spell(penance)
 #purge_the_wicked,if=remains<(duration*0.3)
 if target.debuffremaining(purge_the_wicked_debuff) < baseduration(purge_the_wicked_debuff) * 0.3 spell(purge_the_wicked)
 #shadow_word_pain,if=remains<(duration*0.3)&!talent.purge_the_wicked.enabled
 if buffremaining(shadow_word_pain) < baseduration(shadow_word_pain) * 0.3 and not hastalent(purge_the_wicked_talent) spell(shadow_word_pain)
 #power_word_solace
 spell(power_word_solace)
 #divine_star,if=mana.pct>80
 if manapercent() > 80 spell(divine_star)
 #smite
 spell(smite)
 #shadow_word_pain
 spell(shadow_word_pain)
}

AddFunction discipline_defaultmainpostconditions
{
}

AddFunction discipline_defaultshortcdactions
{
 #mindbender,if=talent.mindbender.enabled
 if hastalent(mindbender_talent) spell(mindbender)

 unless spell(berserking)
 {
  #bag_of_tricks
  spell(bag_of_tricks)
  #shadow_covenant
  spell(shadow_covenant)

  unless not target.debuffpresent(purge_the_wicked_debuff) and spell(purge_the_wicked) or not buffpresent(shadow_word_pain) and not hastalent(purge_the_wicked_talent) and spell(shadow_word_pain)
  {
   #shadow_word_death
   spell(shadow_word_death)
  }
 }
}

AddFunction discipline_defaultshortcdpostconditions
{
 spell(berserking) or not target.debuffpresent(purge_the_wicked_debuff) and spell(purge_the_wicked) or not buffpresent(shadow_word_pain) and not hastalent(purge_the_wicked_talent) and spell(shadow_word_pain) or spell(schism) or spell(mind_blast) or spell(penance) or target.debuffremaining(purge_the_wicked_debuff) < baseduration(purge_the_wicked_debuff) * 0.3 and spell(purge_the_wicked) or buffremaining(shadow_word_pain) < baseduration(shadow_word_pain) * 0.3 and not hastalent(purge_the_wicked_talent) and spell(shadow_word_pain) or spell(power_word_solace) or manapercent() > 80 and spell(divine_star) or spell(smite) or spell(shadow_word_pain)
}

AddFunction discipline_defaultcdactions
{
 #use_item,slot=trinket2
 disciplineuseitemactions()

 unless hastalent(mindbender_talent) and spell(mindbender)
 {
  #shadowfiend,if=!talent.mindbender.enabled
  if not hastalent(mindbender_talent) spell(shadowfiend)
  #blood_fury
  spell(blood_fury)

  unless spell(berserking)
  {
   #arcane_torrent
   spell(arcane_torrent)
   #lights_judgment
   spell(lights_judgment)
   #fireblood
   spell(fireblood)
   #ancestral_call
   spell(ancestral_call)
  }
 }
}

AddFunction discipline_defaultcdpostconditions
{
 hastalent(mindbender_talent) and spell(mindbender) or spell(berserking) or spell(bag_of_tricks) or spell(shadow_covenant) or not target.debuffpresent(purge_the_wicked_debuff) and spell(purge_the_wicked) or not buffpresent(shadow_word_pain) and not hastalent(purge_the_wicked_talent) and spell(shadow_word_pain) or spell(shadow_word_death) or spell(schism) or spell(mind_blast) or spell(penance) or target.debuffremaining(purge_the_wicked_debuff) < baseduration(purge_the_wicked_debuff) * 0.3 and spell(purge_the_wicked) or buffremaining(shadow_word_pain) < baseduration(shadow_word_pain) * 0.3 and not hastalent(purge_the_wicked_talent) and spell(shadow_word_pain) or spell(power_word_solace) or manapercent() > 80 and spell(divine_star) or spell(smite) or spell(shadow_word_pain)
}

### Discipline icons.

AddCheckBox(opt_priest_discipline_aoe l(aoe) default specialization=discipline)

AddIcon checkbox=!opt_priest_discipline_aoe enemies=1 help=shortcd specialization=discipline
{
 if not incombat() disciplineprecombatshortcdactions()
 discipline_defaultshortcdactions()
}

AddIcon checkbox=opt_priest_discipline_aoe help=shortcd specialization=discipline
{
 if not incombat() disciplineprecombatshortcdactions()
 discipline_defaultshortcdactions()
}

AddIcon enemies=1 help=main specialization=discipline
{
 if not incombat() disciplineprecombatmainactions()
 discipline_defaultmainactions()
}

AddIcon checkbox=opt_priest_discipline_aoe help=aoe specialization=discipline
{
 if not incombat() disciplineprecombatmainactions()
 discipline_defaultmainactions()
}

AddIcon checkbox=!opt_priest_discipline_aoe enemies=1 help=cd specialization=discipline
{
 if not incombat() disciplineprecombatcdactions()
 discipline_defaultcdactions()
}

AddIcon checkbox=opt_priest_discipline_aoe help=cd specialization=discipline
{
 if not incombat() disciplineprecombatcdactions()
 discipline_defaultcdactions()
}

### Required symbols
# ancestral_call
# arcane_torrent
# ascended_blast
# ascended_nova
# bag_of_tricks
# berserking
# blood_fury
# divine_star
# fireblood
# lights_judgment
# mind_blast
# mindbender
# mindbender_talent
# penance
# power_word_solace
# purge_the_wicked
# purge_the_wicked_debuff
# purge_the_wicked_talent
# schism
# shadow_covenant
# shadow_word_death
# shadow_word_pain
# shadowfiend
# smite
]]
        OvaleScripts:RegisterScript("PRIEST", "discipline", name, desc, code, "script")
    end
    do
        local name = "sc_t25_priest_shadow"
        local desc = "[9.0] Simulationcraft: T25_Priest_Shadow"
        local code = [[
# Based on SimulationCraft profile "T25_Priest_Shadow".
#	class=priest
#	spec=shadow
#	talents=1123122

Include(ovale_common)
Include(ovale_priest_spells)


AddFunction pi_or_vf_sync_condition
{
 { message("priest.self_power_infusion is not implemented") or message("runeforge.twins_of_the_sun_priestess.equipped is not implemented") } and level() >= 58 and not spellcooldown(power_infusion) > 0 or { level() < 58 or not message("priest.self_power_infusion is not implemented") and not message("runeforge.twins_of_the_sun_priestess.equipped is not implemented") } and not spellcooldown(void_eruption) > 0
}

AddFunction searing_nightmare_cutoff
{
 enemies() > 3
}

AddFunction all_dots_up
{
 target.debuffpresent(shadow_word_pain) and target.debuffpresent(vampiric_touch) and target.debuffpresent(devouring_plague)
}

AddFunction dots_up
{
 target.debuffpresent(shadow_word_pain) and target.debuffpresent(vampiric_touch)
}

AddFunction mind_sear_cutoff
{
 1
}

AddCheckBox(opt_interrupt l(interrupt) default specialization=shadow)
AddCheckBox(opt_use_consumables l(opt_use_consumables) default specialization=shadow)

AddFunction shadowinterruptactions
{
 if checkboxon(opt_interrupt) and not target.isfriend() and target.casting()
 {
  if target.inrange(silence) and target.isinterruptible() spell(silence)
  if target.inrange(mind_bomb) and not target.classification(worldboss) and target.remainingcasttime() > 2 spell(mind_bomb)
  if target.inrange(quaking_palm) and not target.classification(worldboss) spell(quaking_palm)
  if target.distance(less 5) and not target.classification(worldboss) spell(war_stomp)
 }
}

AddFunction shadowuseitemactions
{
 item(trinket0slot text=13 usable=1)
 item(trinket1slot text=14 usable=1)
}

### actions.precombat

AddFunction shadowprecombatmainactions
{
 #shadowform,if=!buff.shadowform.up
 if not buffpresent(shadowform) spell(shadowform)
 #variable,name=mind_sear_cutoff,op=set,value=1
 #vampiric_touch
 spell(vampiric_touch)
}

AddFunction shadowprecombatmainpostconditions
{
}

AddFunction shadowprecombatshortcdactions
{
}

AddFunction shadowprecombatshortcdpostconditions
{
 not buffpresent(shadowform) and spell(shadowform) or spell(vampiric_touch)
}

AddFunction shadowprecombatcdactions
{
 #flask
 #food
 #augmentation
 #snapshot_stats
 #potion
 if checkboxon(opt_use_consumables) and target.classification(worldboss) item(unbridled_fury_item usable=1)

 unless not buffpresent(shadowform) and spell(shadowform)
 {
  #use_item,name=azsharas_font_of_power
  shadowuseitemactions()
 }
}

AddFunction shadowprecombatcdpostconditions
{
 not buffpresent(shadowform) and spell(shadowform) or spell(vampiric_touch)
}

### actions.main

AddFunction shadowmainmainactions
{
 #shadow_word_pain,if=buff.fae_guardians.up&!debuff.wrathful_faerie.up
 if buffpresent(fae_guardians) and not target.debuffpresent(wrathful_faerie) spell(shadow_word_pain)
 #call_action_list,name=cds
 shadowcdsmainactions()

 unless shadowcdsmainpostconditions()
 {
  #mind_sear,target_if=talent.searing_nightmare.enabled&spell_targets.mind_sear>(variable.mind_sear_cutoff+1)&!dot.shadow_word_pain.ticking&!cooldown.mindbender.up
  if hastalent(searing_nightmare_talent) and enemies() > mind_sear_cutoff() + 1 and not target.debuffpresent(shadow_word_pain) and not { not spellcooldown(mindbender) > 0 } spell(mind_sear)
  #void_bolt,if=insanity<=85&((talent.hungering_void.enabled&spell_targets.mind_sear<5)|spell_targets.mind_sear=1)
  if insanity() <= 85 and { hastalent(hungering_void_talent) and enemies() < 5 or enemies() == 1 } spell(void_bolt)
  #devouring_plague,target_if=(refreshable|insanity>75)&!variable.pi_or_vf_sync_condition&(!talent.searing_nightmare.enabled|(talent.searing_nightmare.enabled&!variable.searing_nightmare_cutoff))
  if { target.refreshable(devouring_plague) or insanity() > 75 } and not pi_or_vf_sync_condition() and { not hastalent(searing_nightmare_talent) or hastalent(searing_nightmare_talent) and not searing_nightmare_cutoff() } spell(devouring_plague)
  #void_bolt,if=spell_targets.mind_sear<(4+conduit.dissonant_echoes.enabled)&insanity<=85
  if enemies() < 4 + message("conduit.dissonant_echoes.enabled is not implemented") and insanity() <= 85 spell(void_bolt)
  #mind_sear,target_if=spell_targets.mind_sear>variable.mind_sear_cutoff&buff.dark_thoughts.up,chain=1,interrupt_immediate=1,interrupt_if=ticks>=2
  if enemies() > mind_sear_cutoff() and buffpresent(dark_thoughts) spell(mind_sear)
  #mind_flay,if=buff.dark_thoughts.up&variable.dots_up,chain=1,interrupt_immediate=1,interrupt_if=ticks>=2&cooldown.void_bolt.up
  if buffpresent(dark_thoughts) and dots_up() spell(mind_flay)
  #mind_blast,if=variable.dots_up&raid_event.movement.in>cast_time+0.5&spell_targets.mind_sear<4
  if dots_up() and 600 > casttime(mind_blast) + 0.5 and enemies() < 4 spell(mind_blast)
  #vampiric_touch,target_if=refreshable&target.time_to_die>6|(talent.misery.enabled&dot.shadow_word_pain.refreshable)|buff.unfurling_darkness.up
  if target.refreshable(vampiric_touch) and target.timetodie() > 6 or hastalent(misery_talent) and target.debuffrefreshable(shadow_word_pain) or buffpresent(unfurling_darkness_buff) spell(vampiric_touch)
  #shadow_word_pain,if=refreshable&target.time_to_die>4&!talent.misery.enabled&talent.psychic_link.enabled&spell_targets.mind_sear>2
  if target.refreshable(shadow_word_pain) and target.timetodie() > 4 and not hastalent(misery_talent) and hastalent(psychic_link_talent) and enemies() > 2 spell(shadow_word_pain)
  #shadow_word_pain,target_if=refreshable&target.time_to_die>4&!talent.misery.enabled&!(talent.searing_nightmare.enabled&spell_targets.mind_sear>(variable.mind_sear_cutoff+1))&(!talent.psychic_link.enabled|(talent.psychic_link.enabled&spell_targets.mind_sear<=2))
  if target.refreshable(shadow_word_pain) and target.timetodie() > 4 and not hastalent(misery_talent) and not { hastalent(searing_nightmare_talent) and enemies() > mind_sear_cutoff() + 1 } and { not hastalent(psychic_link_talent) or hastalent(psychic_link_talent) and enemies() <= 2 } spell(shadow_word_pain)
  #mind_sear,target_if=spell_targets.mind_sear>variable.mind_sear_cutoff,chain=1,interrupt_immediate=1,interrupt_if=ticks>=2
  if enemies() > mind_sear_cutoff() spell(mind_sear)
  #mind_flay,chain=1,interrupt_immediate=1,interrupt_if=ticks>=2&cooldown.void_bolt.up
  spell(mind_flay)
  #shadow_word_pain
  spell(shadow_word_pain)
 }
}

AddFunction shadowmainmainpostconditions
{
 shadowcdsmainpostconditions()
}

AddFunction shadowmainshortcdactions
{
 #void_eruption,if=variable.pi_or_vf_sync_condition&insanity>=40
 if pi_or_vf_sync_condition() and insanity() >= 40 spell(void_eruption)

 unless buffpresent(fae_guardians) and not target.debuffpresent(wrathful_faerie) and spell(shadow_word_pain)
 {
  #call_action_list,name=cds
  shadowcdsshortcdactions()

  unless shadowcdsshortcdpostconditions() or hastalent(searing_nightmare_talent) and enemies() > mind_sear_cutoff() + 1 and not target.debuffpresent(shadow_word_pain) and not { not spellcooldown(mindbender) > 0 } and spell(mind_sear)
  {
   #damnation,target_if=!variable.all_dots_up
   if not all_dots_up() spell(damnation)

   unless insanity() <= 85 and { hastalent(hungering_void_talent) and enemies() < 5 or enemies() == 1 } and spell(void_bolt) or { target.refreshable(devouring_plague) or insanity() > 75 } and not pi_or_vf_sync_condition() and { not hastalent(searing_nightmare_talent) or hastalent(searing_nightmare_talent) and not searing_nightmare_cutoff() } and spell(devouring_plague) or enemies() < 4 + message("conduit.dissonant_echoes.enabled is not implemented") and insanity() <= 85 and spell(void_bolt)
   {
    #shadow_word_death,target_if=(target.health.pct<20&spell_targets.mind_sear<4)|(pet.fiend.active&runeforge.shadowflame_prism.equipped)
    if target.healthpercent() < 20 and enemies() < 4 or pet.present() and message("runeforge.shadowflame_prism.equipped is not implemented") spell(shadow_word_death)
    #surrender_to_madness,target_if=target.time_to_die<25&buff.voidform.down
    if target.timetodie() < 25 and buffexpires(voidform_buff) spell(surrender_to_madness)
    #mindbender,if=dot.vampiric_touch.ticking&((talent.searing_nightmare.enabled&spell_targets.mind_sear>(variable.mind_sear_cutoff+1))|dot.shadow_word_pain.ticking)
    if target.debuffpresent(vampiric_touch) and { hastalent(searing_nightmare_talent) and enemies() > mind_sear_cutoff() + 1 or target.debuffpresent(shadow_word_pain) } spell(mindbender)
    #void_torrent,target_if=variable.dots_up&target.time_to_die>4&buff.voidform.down&spell_targets.mind_sear<(5+(6*talent.twist_of_fate.enabled))
    if dots_up() and target.timetodie() > 4 and buffexpires(voidform_buff) and enemies() < 5 + 6 * talentpoints(twist_of_fate_talent_shadow) spell(void_torrent)
    #shadow_word_death,if=runeforge.painbreaker_psalm.equipped&variable.dots_up&target.time_to_pct_20>(cooldown.shadow_word_death.duration+gcd)
    if message("runeforge.painbreaker_psalm.equipped is not implemented") and dots_up() and target.timetohealthpercent(20) > spellcooldownduration(shadow_word_death) + gcd() spell(shadow_word_death)
    #shadow_crash,if=spell_targets.shadow_crash=1&(cooldown.shadow_crash.charges=3|debuff.shadow_crash_debuff.up|action.shadow_crash.in_flight|target.time_to_die<cooldown.shadow_crash.full_recharge_time)&raid_event.adds.in>30
    if enemies() == 1 and { spellcharges(shadow_crash) == 3 or target.debuffpresent(shadow_crash_debuff) or inflighttotarget(shadow_crash) or target.timetodie() < spellcooldown(shadow_crash) } and 600 > 30 spell(shadow_crash)
    #shadow_crash,if=raid_event.adds.in>30&spell_targets.shadow_crash>1
    if 600 > 30 and enemies() > 1 spell(shadow_crash)

    unless enemies() > mind_sear_cutoff() and buffpresent(dark_thoughts) and spell(mind_sear) or buffpresent(dark_thoughts) and dots_up() and spell(mind_flay) or dots_up() and 600 > casttime(mind_blast) + 0.5 and enemies() < 4 and spell(mind_blast) or { target.refreshable(vampiric_touch) and target.timetodie() > 6 or hastalent(misery_talent) and target.debuffrefreshable(shadow_word_pain) or buffpresent(unfurling_darkness_buff) } and spell(vampiric_touch) or target.refreshable(shadow_word_pain) and target.timetodie() > 4 and not hastalent(misery_talent) and hastalent(psychic_link_talent) and enemies() > 2 and spell(shadow_word_pain) or target.refreshable(shadow_word_pain) and target.timetodie() > 4 and not hastalent(misery_talent) and not { hastalent(searing_nightmare_talent) and enemies() > mind_sear_cutoff() + 1 } and { not hastalent(psychic_link_talent) or hastalent(psychic_link_talent) and enemies() <= 2 } and spell(shadow_word_pain) or enemies() > mind_sear_cutoff() and spell(mind_sear) or spell(mind_flay)
    {
     #shadow_word_death
     spell(shadow_word_death)
    }
   }
  }
 }
}

AddFunction shadowmainshortcdpostconditions
{
 buffpresent(fae_guardians) and not target.debuffpresent(wrathful_faerie) and spell(shadow_word_pain) or shadowcdsshortcdpostconditions() or hastalent(searing_nightmare_talent) and enemies() > mind_sear_cutoff() + 1 and not target.debuffpresent(shadow_word_pain) and not { not spellcooldown(mindbender) > 0 } and spell(mind_sear) or insanity() <= 85 and { hastalent(hungering_void_talent) and enemies() < 5 or enemies() == 1 } and spell(void_bolt) or { target.refreshable(devouring_plague) or insanity() > 75 } and not pi_or_vf_sync_condition() and { not hastalent(searing_nightmare_talent) or hastalent(searing_nightmare_talent) and not searing_nightmare_cutoff() } and spell(devouring_plague) or enemies() < 4 + message("conduit.dissonant_echoes.enabled is not implemented") and insanity() <= 85 and spell(void_bolt) or enemies() > mind_sear_cutoff() and buffpresent(dark_thoughts) and spell(mind_sear) or buffpresent(dark_thoughts) and dots_up() and spell(mind_flay) or dots_up() and 600 > casttime(mind_blast) + 0.5 and enemies() < 4 and spell(mind_blast) or { target.refreshable(vampiric_touch) and target.timetodie() > 6 or hastalent(misery_talent) and target.debuffrefreshable(shadow_word_pain) or buffpresent(unfurling_darkness_buff) } and spell(vampiric_touch) or target.refreshable(shadow_word_pain) and target.timetodie() > 4 and not hastalent(misery_talent) and hastalent(psychic_link_talent) and enemies() > 2 and spell(shadow_word_pain) or target.refreshable(shadow_word_pain) and target.timetodie() > 4 and not hastalent(misery_talent) and not { hastalent(searing_nightmare_talent) and enemies() > mind_sear_cutoff() + 1 } and { not hastalent(psychic_link_talent) or hastalent(psychic_link_talent) and enemies() <= 2 } and spell(shadow_word_pain) or enemies() > mind_sear_cutoff() and spell(mind_sear) or spell(mind_flay) or spell(shadow_word_pain)
}

AddFunction shadowmaincdactions
{
 unless pi_or_vf_sync_condition() and insanity() >= 40 and spell(void_eruption) or buffpresent(fae_guardians) and not target.debuffpresent(wrathful_faerie) and spell(shadow_word_pain)
 {
  #call_action_list,name=cds
  shadowcdscdactions()
 }
}

AddFunction shadowmaincdpostconditions
{
 pi_or_vf_sync_condition() and insanity() >= 40 and spell(void_eruption) or buffpresent(fae_guardians) and not target.debuffpresent(wrathful_faerie) and spell(shadow_word_pain) or shadowcdscdpostconditions() or hastalent(searing_nightmare_talent) and enemies() > mind_sear_cutoff() + 1 and not target.debuffpresent(shadow_word_pain) and not { not spellcooldown(mindbender) > 0 } and spell(mind_sear) or not all_dots_up() and spell(damnation) or insanity() <= 85 and { hastalent(hungering_void_talent) and enemies() < 5 or enemies() == 1 } and spell(void_bolt) or { target.refreshable(devouring_plague) or insanity() > 75 } and not pi_or_vf_sync_condition() and { not hastalent(searing_nightmare_talent) or hastalent(searing_nightmare_talent) and not searing_nightmare_cutoff() } and spell(devouring_plague) or enemies() < 4 + message("conduit.dissonant_echoes.enabled is not implemented") and insanity() <= 85 and spell(void_bolt) or { target.healthpercent() < 20 and enemies() < 4 or pet.present() and message("runeforge.shadowflame_prism.equipped is not implemented") } and spell(shadow_word_death) or target.timetodie() < 25 and buffexpires(voidform_buff) and spell(surrender_to_madness) or target.debuffpresent(vampiric_touch) and { hastalent(searing_nightmare_talent) and enemies() > mind_sear_cutoff() + 1 or target.debuffpresent(shadow_word_pain) } and spell(mindbender) or dots_up() and target.timetodie() > 4 and buffexpires(voidform_buff) and enemies() < 5 + 6 * talentpoints(twist_of_fate_talent_shadow) and spell(void_torrent) or message("runeforge.painbreaker_psalm.equipped is not implemented") and dots_up() and target.timetohealthpercent(20) > spellcooldownduration(shadow_word_death) + gcd() and spell(shadow_word_death) or enemies() == 1 and { spellcharges(shadow_crash) == 3 or target.debuffpresent(shadow_crash_debuff) or inflighttotarget(shadow_crash) or target.timetodie() < spellcooldown(shadow_crash) } and 600 > 30 and spell(shadow_crash) or 600 > 30 and enemies() > 1 and spell(shadow_crash) or enemies() > mind_sear_cutoff() and buffpresent(dark_thoughts) and spell(mind_sear) or buffpresent(dark_thoughts) and dots_up() and spell(mind_flay) or dots_up() and 600 > casttime(mind_blast) + 0.5 and enemies() < 4 and spell(mind_blast) or { target.refreshable(vampiric_touch) and target.timetodie() > 6 or hastalent(misery_talent) and target.debuffrefreshable(shadow_word_pain) or buffpresent(unfurling_darkness_buff) } and spell(vampiric_touch) or target.refreshable(shadow_word_pain) and target.timetodie() > 4 and not hastalent(misery_talent) and hastalent(psychic_link_talent) and enemies() > 2 and spell(shadow_word_pain) or target.refreshable(shadow_word_pain) and target.timetodie() > 4 and not hastalent(misery_talent) and not { hastalent(searing_nightmare_talent) and enemies() > mind_sear_cutoff() + 1 } and { not hastalent(psychic_link_talent) or hastalent(psychic_link_talent) and enemies() <= 2 } and spell(shadow_word_pain) or enemies() > mind_sear_cutoff() and spell(mind_sear) or spell(mind_flay) or spell(shadow_word_death) or spell(shadow_word_pain)
}

### actions.essences

AddFunction shadowessencesmainactions
{
 #memory_of_lucid_dreams
 spell(memory_of_lucid_dreams)
 #blood_of_the_enemy
 spell(blood_of_the_enemy)
 #concentrated_flame,line_cd=6,if=time<=10|full_recharge_time<gcd|target.time_to_die<5
 if timesincepreviousspell(concentrated_flame) > 6 and { timeincombat() <= 10 or spellfullrecharge(concentrated_flame) < gcd() or target.timetodie() < 5 } spell(concentrated_flame)
 #ripple_in_space
 spell(ripple_in_space)
 #worldvein_resonance
 spell(worldvein_resonance)
 #the_unbound_force
 spell(the_unbound_force)
}

AddFunction shadowessencesmainpostconditions
{
}

AddFunction shadowessencesshortcdactions
{
 unless spell(memory_of_lucid_dreams) or spell(blood_of_the_enemy)
 {
  #focused_azerite_beam,if=spell_targets.mind_sear>=2|raid_event.adds.in>60
  if enemies() >= 2 or 600 > 60 spell(focused_azerite_beam)
  #purifying_blast,if=spell_targets.mind_sear>=2|raid_event.adds.in>60
  if enemies() >= 2 or 600 > 60 spell(purifying_blast)

  unless timesincepreviousspell(concentrated_flame) > 6 and { timeincombat() <= 10 or spellfullrecharge(concentrated_flame) < gcd() or target.timetodie() < 5 } and spell(concentrated_flame) or spell(ripple_in_space)
  {
   #reaping_flames
   spell(reaping_flames)
  }
 }
}

AddFunction shadowessencesshortcdpostconditions
{
 spell(memory_of_lucid_dreams) or spell(blood_of_the_enemy) or timesincepreviousspell(concentrated_flame) > 6 and { timeincombat() <= 10 or spellfullrecharge(concentrated_flame) < gcd() or target.timetodie() < 5 } and spell(concentrated_flame) or spell(ripple_in_space) or spell(worldvein_resonance) or spell(the_unbound_force)
}

AddFunction shadowessencescdactions
{
 unless spell(memory_of_lucid_dreams) or spell(blood_of_the_enemy)
 {
  #guardian_of_azeroth
  spell(guardian_of_azeroth)
 }
}

AddFunction shadowessencescdpostconditions
{
 spell(memory_of_lucid_dreams) or spell(blood_of_the_enemy) or { enemies() >= 2 or 600 > 60 } and spell(focused_azerite_beam) or { enemies() >= 2 or 600 > 60 } and spell(purifying_blast) or timesincepreviousspell(concentrated_flame) > 6 and { timeincombat() <= 10 or spellfullrecharge(concentrated_flame) < gcd() or target.timetodie() < 5 } and spell(concentrated_flame) or spell(ripple_in_space) or spell(reaping_flames) or spell(worldvein_resonance) or spell(the_unbound_force)
}

### actions.cwc

AddFunction shadowcwcmainactions
{
 #searing_nightmare,use_while_casting=1,target_if=(variable.searing_nightmare_cutoff&!variable.pi_or_vf_sync_condition)|(dot.shadow_word_pain.refreshable&spell_targets.mind_sear>1)
 if searing_nightmare_cutoff() and not pi_or_vf_sync_condition() or target.debuffrefreshable(shadow_word_pain) and enemies() > 1 spell(searing_nightmare)
 #searing_nightmare,use_while_casting=1,target_if=talent.searing_nightmare.enabled&dot.shadow_word_pain.refreshable&spell_targets.mind_sear>2
 if hastalent(searing_nightmare_talent) and target.debuffrefreshable(shadow_word_pain) and enemies() > 2 spell(searing_nightmare)
 #mind_blast,only_cwc=1
 spell(mind_blast)
}

AddFunction shadowcwcmainpostconditions
{
}

AddFunction shadowcwcshortcdactions
{
}

AddFunction shadowcwcshortcdpostconditions
{
 { searing_nightmare_cutoff() and not pi_or_vf_sync_condition() or target.debuffrefreshable(shadow_word_pain) and enemies() > 1 } and spell(searing_nightmare) or hastalent(searing_nightmare_talent) and target.debuffrefreshable(shadow_word_pain) and enemies() > 2 and spell(searing_nightmare) or spell(mind_blast)
}

AddFunction shadowcwccdactions
{
}

AddFunction shadowcwccdpostconditions
{
 { searing_nightmare_cutoff() and not pi_or_vf_sync_condition() or target.debuffrefreshable(shadow_word_pain) and enemies() > 1 } and spell(searing_nightmare) or hastalent(searing_nightmare_talent) and target.debuffrefreshable(shadow_word_pain) and enemies() > 2 and spell(searing_nightmare) or spell(mind_blast)
}

### actions.cds

AddFunction shadowcdsmainactions
{
 #call_action_list,name=essences
 shadowessencesmainactions()
}

AddFunction shadowcdsmainpostconditions
{
 shadowessencesmainpostconditions()
}

AddFunction shadowcdsshortcdactions
{
 #call_action_list,name=essences
 shadowessencesshortcdactions()
}

AddFunction shadowcdsshortcdpostconditions
{
 shadowessencesshortcdpostconditions()
}

AddFunction shadowcdscdactions
{
 #silence,target_if=runeforge.sephuzs_proclamation.equipped&(target.is_add|target.debuff.casting.react)
 if message("runeforge.sephuzs_proclamation.equipped is not implemented") and { not target.classification(worldboss) or target.isinterruptible() } shadowinterruptactions()
 #call_action_list,name=essences
 shadowessencescdactions()

 unless shadowessencescdpostconditions()
 {
  #use_items
  shadowuseitemactions()
 }
}

AddFunction shadowcdscdpostconditions
{
 shadowessencescdpostconditions()
}

### actions.default

AddFunction shadow_defaultmainactions
{
 #variable,name=dots_up,op=set,value=dot.shadow_word_pain.ticking&dot.vampiric_touch.ticking
 #variable,name=all_dots_up,op=set,value=dot.shadow_word_pain.ticking&dot.vampiric_touch.ticking&dot.devouring_plague.ticking
 #variable,name=searing_nightmare_cutoff,op=set,value=spell_targets.mind_sear>3
 #variable,name=pi_or_vf_sync_condition,op=set,value=(priest.self_power_infusion|runeforge.twins_of_the_sun_priestess.equipped)&level>=58&cooldown.power_infusion.up|(level<58|!priest.self_power_infusion&!runeforge.twins_of_the_sun_priestess.equipped)&cooldown.void_eruption.up
 #call_action_list,name=cwc
 shadowcwcmainactions()

 unless shadowcwcmainpostconditions()
 {
  #run_action_list,name=main
  shadowmainmainactions()
 }
}

AddFunction shadow_defaultmainpostconditions
{
 shadowcwcmainpostconditions() or shadowmainmainpostconditions()
}

AddFunction shadow_defaultshortcdactions
{
 #variable,name=dots_up,op=set,value=dot.shadow_word_pain.ticking&dot.vampiric_touch.ticking
 #variable,name=all_dots_up,op=set,value=dot.shadow_word_pain.ticking&dot.vampiric_touch.ticking&dot.devouring_plague.ticking
 #variable,name=searing_nightmare_cutoff,op=set,value=spell_targets.mind_sear>3
 #variable,name=pi_or_vf_sync_condition,op=set,value=(priest.self_power_infusion|runeforge.twins_of_the_sun_priestess.equipped)&level>=58&cooldown.power_infusion.up|(level<58|!priest.self_power_infusion&!runeforge.twins_of_the_sun_priestess.equipped)&cooldown.void_eruption.up
 #call_action_list,name=cwc
 shadowcwcshortcdactions()

 unless shadowcwcshortcdpostconditions()
 {
  #run_action_list,name=main
  shadowmainshortcdactions()
 }
}

AddFunction shadow_defaultshortcdpostconditions
{
 shadowcwcshortcdpostconditions() or shadowmainshortcdpostconditions()
}

AddFunction shadow_defaultcdactions
{
 #potion,if=buff.bloodlust.react|target.time_to_die<=80|target.health.pct<35
 if { buffpresent(bloodlust) or target.timetodie() <= 80 or target.healthpercent() < 35 } and checkboxon(opt_use_consumables) and target.classification(worldboss) item(unbridled_fury_item usable=1)
 #variable,name=dots_up,op=set,value=dot.shadow_word_pain.ticking&dot.vampiric_touch.ticking
 #variable,name=all_dots_up,op=set,value=dot.shadow_word_pain.ticking&dot.vampiric_touch.ticking&dot.devouring_plague.ticking
 #variable,name=searing_nightmare_cutoff,op=set,value=spell_targets.mind_sear>3
 #variable,name=pi_or_vf_sync_condition,op=set,value=(priest.self_power_infusion|runeforge.twins_of_the_sun_priestess.equipped)&level>=58&cooldown.power_infusion.up|(level<58|!priest.self_power_infusion&!runeforge.twins_of_the_sun_priestess.equipped)&cooldown.void_eruption.up
 #call_action_list,name=cwc
 shadowcwccdactions()

 unless shadowcwccdpostconditions()
 {
  #run_action_list,name=main
  shadowmaincdactions()
 }
}

AddFunction shadow_defaultcdpostconditions
{
 shadowcwccdpostconditions() or shadowmaincdpostconditions()
}

### Shadow icons.

AddCheckBox(opt_priest_shadow_aoe l(aoe) default specialization=shadow)

AddIcon checkbox=!opt_priest_shadow_aoe enemies=1 help=shortcd specialization=shadow
{
 if not incombat() shadowprecombatshortcdactions()
 shadow_defaultshortcdactions()
}

AddIcon checkbox=opt_priest_shadow_aoe help=shortcd specialization=shadow
{
 if not incombat() shadowprecombatshortcdactions()
 shadow_defaultshortcdactions()
}

AddIcon enemies=1 help=main specialization=shadow
{
 if not incombat() shadowprecombatmainactions()
 shadow_defaultmainactions()
}

AddIcon checkbox=opt_priest_shadow_aoe help=aoe specialization=shadow
{
 if not incombat() shadowprecombatmainactions()
 shadow_defaultmainactions()
}

AddIcon checkbox=!opt_priest_shadow_aoe enemies=1 help=cd specialization=shadow
{
 if not incombat() shadowprecombatcdactions()
 shadow_defaultcdactions()
}

AddIcon checkbox=opt_priest_shadow_aoe help=cd specialization=shadow
{
 if not incombat() shadowprecombatcdactions()
 shadow_defaultcdactions()
}

### Required symbols
# blood_of_the_enemy
# bloodlust
# concentrated_flame
# damnation
# dark_thoughts
# devouring_plague
# fae_guardians
# focused_azerite_beam
# guardian_of_azeroth
# hungering_void_talent
# memory_of_lucid_dreams
# mind_blast
# mind_bomb
# mind_flay
# mind_sear
# mindbender
# misery_talent
# power_infusion
# psychic_link_talent
# purifying_blast
# quaking_palm
# reaping_flames
# ripple_in_space
# searing_nightmare
# searing_nightmare_talent
# shadow_crash
# shadow_crash_debuff
# shadow_word_death
# shadow_word_pain
# shadowform
# silence
# surrender_to_madness
# the_unbound_force
# twist_of_fate_talent_shadow
# unbridled_fury_item
# unfurling_darkness_buff
# vampiric_touch
# void_bolt
# void_eruption
# void_torrent
# voidform_buff
# war_stomp
# worldvein_resonance
# wrathful_faerie
]]
        OvaleScripts:RegisterScript("PRIEST", "shadow", name, desc, code, "script")
    end
end
