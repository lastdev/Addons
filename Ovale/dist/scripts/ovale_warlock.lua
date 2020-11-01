local __exports = LibStub:NewLibrary("ovale/scripts/ovale_warlock", 80300)
if not __exports then return end
__exports.registerWarlock = function(OvaleScripts)
    do
        local name = "sc_t25_warlock_affliction"
        local desc = "[9.0] Simulationcraft: T25_Warlock_Affliction"
        local code = [[
# Based on SimulationCraft profile "T25_Warlock_Affliction".
#	class=warlock
#	spec=affliction
#	talents=3302023
#	pet=imp

Include(ovale_common)
Include(ovale_warlock_spells)

AddFunction afflictionuseitemactions
{
 item(trinket0slot text=13 usable=1)
 item(trinket1slot text=14 usable=1)
}

### actions.precombat

AddFunction afflictionprecombatmainactions
{
 #flask
 #food
 #augmentation
 #summon_pet
 if not pet.present() spell(summon_imp)
 #seed_of_corruption,if=spell_targets.seed_of_corruption_aoe>=3&!equipped.169314
 if enemies() >= 3 and not hasequippeditem(169314) spell(seed_of_corruption)
 #haunt
 spell(haunt)
 #shadow_bolt,if=!talent.haunt.enabled&spell_targets.seed_of_corruption_aoe<3&!equipped.169314
 if not hastalent(haunt_talent) and enemies() < 3 and not hasequippeditem(169314) spell(shadow_bolt)
}

AddFunction afflictionprecombatmainpostconditions
{
}

AddFunction afflictionprecombatshortcdactions
{
 unless not pet.present() and spell(summon_imp)
 {
  #grimoire_of_sacrifice,if=talent.grimoire_of_sacrifice.enabled
  if hastalent(grimoire_of_sacrifice_talent) and pet.present() spell(grimoire_of_sacrifice)
 }
}

AddFunction afflictionprecombatshortcdpostconditions
{
 not pet.present() and spell(summon_imp) or enemies() >= 3 and not hasequippeditem(169314) and spell(seed_of_corruption) or spell(haunt) or not hastalent(haunt_talent) and enemies() < 3 and not hasequippeditem(169314) and spell(shadow_bolt)
}

AddFunction afflictionprecombatcdactions
{
 unless not pet.present() and spell(summon_imp) or hastalent(grimoire_of_sacrifice_talent) and pet.present() and spell(grimoire_of_sacrifice)
 {
  #snapshot_stats
  #potion
  #use_item,name=azsharas_font_of_power
  afflictionuseitemactions()
 }
}

AddFunction afflictionprecombatcdpostconditions
{
 not pet.present() and spell(summon_imp) or hastalent(grimoire_of_sacrifice_talent) and pet.present() and spell(grimoire_of_sacrifice) or enemies() >= 3 and not hasequippeditem(169314) and spell(seed_of_corruption) or spell(haunt) or not hastalent(haunt_talent) and enemies() < 3 and not hasequippeditem(169314) and spell(shadow_bolt)
}

### actions.darkglare_prep

AddFunction afflictiondarkglare_prepmainactions
{
 #vile_taint
 spell(vile_taint)
 #berserking
 spell(berserking)
}

AddFunction afflictiondarkglare_prepmainpostconditions
{
}

AddFunction afflictiondarkglare_prepshortcdactions
{
}

AddFunction afflictiondarkglare_prepshortcdpostconditions
{
 spell(vile_taint) or spell(berserking)
}

AddFunction afflictiondarkglare_prepcdactions
{
 unless spell(vile_taint)
 {
  #dark_soul
  spell(dark_soul_misery)
  #potion
  #use_items
  afflictionuseitemactions()
  #fireblood
  spell(fireblood)
  #blood_fury
  spell(blood_fury)

  unless spell(berserking)
  {
   #summon_darkglare
   spell(summon_darkglare)
  }
 }
}

AddFunction afflictiondarkglare_prepcdpostconditions
{
 spell(vile_taint) or spell(berserking)
}

### actions.cooldowns

AddFunction afflictioncooldownsmainactions
{
 #worldvein_resonance
 spell(worldvein_resonance)
 #memory_of_lucid_dreams
 spell(memory_of_lucid_dreams)
 #blood_of_the_enemy
 spell(blood_of_the_enemy)
 #ripple_in_space
 spell(ripple_in_space)
 #concentrated_flame
 spell(concentrated_flame)
 #the_unbound_force,if=buff.reckless_force.remains
 if buffpresent(reckless_force_buff) spell(the_unbound_force)
}

AddFunction afflictioncooldownsmainpostconditions
{
}

AddFunction afflictioncooldownsshortcdactions
{
 unless spell(worldvein_resonance) or spell(memory_of_lucid_dreams) or spell(blood_of_the_enemy) or spell(ripple_in_space)
 {
  #focused_azerite_beam
  spell(focused_azerite_beam)
  #purifying_blast
  spell(purifying_blast)
  #reaping_flames
  spell(reaping_flames)
 }
}

AddFunction afflictioncooldownsshortcdpostconditions
{
 spell(worldvein_resonance) or spell(memory_of_lucid_dreams) or spell(blood_of_the_enemy) or spell(ripple_in_space) or spell(concentrated_flame) or buffpresent(reckless_force_buff) and spell(the_unbound_force)
}

AddFunction afflictioncooldownscdactions
{
 unless spell(worldvein_resonance) or spell(memory_of_lucid_dreams) or spell(blood_of_the_enemy)
 {
  #guardian_of_azeroth
  spell(guardian_of_azeroth)
 }
}

AddFunction afflictioncooldownscdpostconditions
{
 spell(worldvein_resonance) or spell(memory_of_lucid_dreams) or spell(blood_of_the_enemy) or spell(ripple_in_space) or spell(focused_azerite_beam) or spell(purifying_blast) or spell(reaping_flames) or spell(concentrated_flame) or buffpresent(reckless_force_buff) and spell(the_unbound_force)
}

### actions.default

AddFunction affliction_defaultmainactions
{
 #vile_taint,if=soul_shard>1
 if soulshards() > 1 spell(vile_taint)
 #siphon_life,if=refreshable
 if target.refreshable(siphon_life) spell(siphon_life)
 #agony,if=refreshable
 if target.refreshable(agony) spell(agony)
 #unstable_affliction,if=refreshable
 if target.refreshable(unstable_affliction) spell(unstable_affliction)
 #corruption,if=refreshable
 if target.refreshable(corruption_debuff) spell(corruption)
 #haunt
 spell(haunt)
 #call_action_list,name=darkglare_prep,if=cooldown.summon_darkglare.remains<2&(dot.phantom_singularity.remains>2|!talent.phantom_singularity.enabled)
 if spellcooldown(summon_darkglare) < 2 and { target.debuffremaining(phantom_singularity) > 2 or not hastalent(phantom_singularity_talent) } afflictiondarkglare_prepmainactions()

 unless spellcooldown(summon_darkglare) < 2 and { target.debuffremaining(phantom_singularity) > 2 or not hastalent(phantom_singularity_talent) } and afflictiondarkglare_prepmainpostconditions()
 {
  #call_action_list,name=cooldowns
  afflictioncooldownsmainactions()

  unless afflictioncooldownsmainpostconditions()
  {
   #malefic_rapture,if=dot.vile_taint.ticking
   if target.debuffpresent(vile_taint) spell(malefic_rapture)
   #malefic_rapture,if=!talent.vile_taint.enabled
   if not hastalent(vile_taint_talent) spell(malefic_rapture)
   #drain_life,if=buff.inevitable_demise.stack>30
   if buffstacks(inevitable_demise_buff) > 30 spell(drain_life)
   #drain_soul
   spell(drain_soul)
   #shadow_bolt
   spell(shadow_bolt)
  }
 }
}

AddFunction affliction_defaultmainpostconditions
{
 spellcooldown(summon_darkglare) < 2 and { target.debuffremaining(phantom_singularity) > 2 or not hastalent(phantom_singularity_talent) } and afflictiondarkglare_prepmainpostconditions() or afflictioncooldownsmainpostconditions()
}

AddFunction affliction_defaultshortcdactions
{
 #phantom_singularity
 spell(phantom_singularity)

 unless soulshards() > 1 and spell(vile_taint) or target.refreshable(siphon_life) and spell(siphon_life) or target.refreshable(agony) and spell(agony) or target.refreshable(unstable_affliction) and spell(unstable_affliction) or target.refreshable(corruption_debuff) and spell(corruption) or spell(haunt)
 {
  #call_action_list,name=darkglare_prep,if=cooldown.summon_darkglare.remains<2&(dot.phantom_singularity.remains>2|!talent.phantom_singularity.enabled)
  if spellcooldown(summon_darkglare) < 2 and { target.debuffremaining(phantom_singularity) > 2 or not hastalent(phantom_singularity_talent) } afflictiondarkglare_prepshortcdactions()

  unless spellcooldown(summon_darkglare) < 2 and { target.debuffremaining(phantom_singularity) > 2 or not hastalent(phantom_singularity_talent) } and afflictiondarkglare_prepshortcdpostconditions()
  {
   #call_action_list,name=cooldowns
   afflictioncooldownsshortcdactions()
  }
 }
}

AddFunction affliction_defaultshortcdpostconditions
{
 soulshards() > 1 and spell(vile_taint) or target.refreshable(siphon_life) and spell(siphon_life) or target.refreshable(agony) and spell(agony) or target.refreshable(unstable_affliction) and spell(unstable_affliction) or target.refreshable(corruption_debuff) and spell(corruption) or spell(haunt) or spellcooldown(summon_darkglare) < 2 and { target.debuffremaining(phantom_singularity) > 2 or not hastalent(phantom_singularity_talent) } and afflictiondarkglare_prepshortcdpostconditions() or afflictioncooldownsshortcdpostconditions() or target.debuffpresent(vile_taint) and spell(malefic_rapture) or not hastalent(vile_taint_talent) and spell(malefic_rapture) or buffstacks(inevitable_demise_buff) > 30 and spell(drain_life) or spell(drain_soul) or spell(shadow_bolt)
}

AddFunction affliction_defaultcdactions
{
 unless spell(phantom_singularity) or soulshards() > 1 and spell(vile_taint) or target.refreshable(siphon_life) and spell(siphon_life) or target.refreshable(agony) and spell(agony) or target.refreshable(unstable_affliction) and spell(unstable_affliction) or target.refreshable(corruption_debuff) and spell(corruption) or spell(haunt)
 {
  #call_action_list,name=darkglare_prep,if=cooldown.summon_darkglare.remains<2&(dot.phantom_singularity.remains>2|!talent.phantom_singularity.enabled)
  if spellcooldown(summon_darkglare) < 2 and { target.debuffremaining(phantom_singularity) > 2 or not hastalent(phantom_singularity_talent) } afflictiondarkglare_prepcdactions()

  unless spellcooldown(summon_darkglare) < 2 and { target.debuffremaining(phantom_singularity) > 2 or not hastalent(phantom_singularity_talent) } and afflictiondarkglare_prepcdpostconditions()
  {
   #dark_soul,if=cooldown.summon_darkglare.remains>time_to_die
   if spellcooldown(summon_darkglare) > target.timetodie() spell(dark_soul_misery)
   #call_action_list,name=cooldowns
   afflictioncooldownscdactions()
  }
 }
}

AddFunction affliction_defaultcdpostconditions
{
 spell(phantom_singularity) or soulshards() > 1 and spell(vile_taint) or target.refreshable(siphon_life) and spell(siphon_life) or target.refreshable(agony) and spell(agony) or target.refreshable(unstable_affliction) and spell(unstable_affliction) or target.refreshable(corruption_debuff) and spell(corruption) or spell(haunt) or spellcooldown(summon_darkglare) < 2 and { target.debuffremaining(phantom_singularity) > 2 or not hastalent(phantom_singularity_talent) } and afflictiondarkglare_prepcdpostconditions() or afflictioncooldownscdpostconditions() or target.debuffpresent(vile_taint) and spell(malefic_rapture) or not hastalent(vile_taint_talent) and spell(malefic_rapture) or buffstacks(inevitable_demise_buff) > 30 and spell(drain_life) or spell(drain_soul) or spell(shadow_bolt)
}

### Affliction icons.

AddCheckBox(opt_warlock_affliction_aoe l(aoe) default specialization=affliction)

AddIcon checkbox=!opt_warlock_affliction_aoe enemies=1 help=shortcd specialization=affliction
{
 if not incombat() afflictionprecombatshortcdactions()
 affliction_defaultshortcdactions()
}

AddIcon checkbox=opt_warlock_affliction_aoe help=shortcd specialization=affliction
{
 if not incombat() afflictionprecombatshortcdactions()
 affliction_defaultshortcdactions()
}

AddIcon enemies=1 help=main specialization=affliction
{
 if not incombat() afflictionprecombatmainactions()
 affliction_defaultmainactions()
}

AddIcon checkbox=opt_warlock_affliction_aoe help=aoe specialization=affliction
{
 if not incombat() afflictionprecombatmainactions()
 affliction_defaultmainactions()
}

AddIcon checkbox=!opt_warlock_affliction_aoe enemies=1 help=cd specialization=affliction
{
 if not incombat() afflictionprecombatcdactions()
 affliction_defaultcdactions()
}

AddIcon checkbox=opt_warlock_affliction_aoe help=cd specialization=affliction
{
 if not incombat() afflictionprecombatcdactions()
 affliction_defaultcdactions()
}

### Required symbols
# 169314
# agony
# berserking
# blood_fury
# blood_of_the_enemy
# concentrated_flame
# corruption
# corruption_debuff
# dark_soul_misery
# drain_life
# drain_soul
# fireblood
# focused_azerite_beam
# grimoire_of_sacrifice
# grimoire_of_sacrifice_talent
# guardian_of_azeroth
# haunt
# haunt_talent
# inevitable_demise_buff
# malefic_rapture
# memory_of_lucid_dreams
# phantom_singularity
# phantom_singularity_talent
# purifying_blast
# reaping_flames
# reckless_force_buff
# ripple_in_space
# seed_of_corruption
# shadow_bolt
# siphon_life
# summon_darkglare
# summon_imp
# the_unbound_force
# unstable_affliction
# vile_taint
# vile_taint_talent
# worldvein_resonance
]]
        OvaleScripts:RegisterScript("WARLOCK", "affliction", name, desc, code, "script")
    end
    do
        local name = "sc_t25_warlock_demonology"
        local desc = "[9.0] Simulationcraft: T25_Warlock_Demonology"
        local code = [[
# Based on SimulationCraft profile "T25_Warlock_Demonology".
#	class=warlock
#	spec=demonology
#	talents=3302032
#	pet=felguard

Include(ovale_common)
Include(ovale_warlock_spells)

AddFunction tyrant_ready
{
 1
 not spellcooldown(summon_demonic_tyrant) == 0
 0
}

AddFunction demonologyuseitemactions
{
 item(trinket0slot text=13 usable=1)
 item(trinket1slot text=14 usable=1)
}

### actions.tyrant_prep

AddFunction demonologytyrant_prepmainactions
{
 #doom,line_cd=30
 if timesincepreviousspell(doom) > 30 spell(doom)
 #call_dreadstalkers
 spell(call_dreadstalkers)
 #demonbolt,if=buff.demonic_core.up&soul_shard<4&(talent.demonic_consumption.enabled|buff.nether_portal.down)
 if buffpresent(demonic_core) and soulshards() < 4 and { hastalent(demonic_consumption_talent) or buffexpires(nether_portal) } spell(demonbolt)
 #shadow_bolt,if=soul_shard<5-4*buff.nether_portal.up
 if soulshards() < 5 - 4 * buffpresent(nether_portal) spell(shadow_bolt)
 #variable,name=tyrant_ready,value=1
 #hand_of_guldan
 spell(hand_of_guldan)
}

AddFunction demonologytyrant_prepmainpostconditions
{
}

AddFunction demonologytyrant_prepshortcdactions
{
 unless timesincepreviousspell(doom) > 30 and spell(doom)
 {
  #demonic_strength,if=!talent.demonic_consumption.enabled
  if not hastalent(demonic_consumption_talent) spell(demonic_strength)
  #summon_vilefiend
  spell(summon_vilefiend)
 }
}

AddFunction demonologytyrant_prepshortcdpostconditions
{
 timesincepreviousspell(doom) > 30 and spell(doom) or spell(call_dreadstalkers) or buffpresent(demonic_core) and soulshards() < 4 and { hastalent(demonic_consumption_talent) or buffexpires(nether_portal) } and spell(demonbolt) or soulshards() < 5 - 4 * buffpresent(nether_portal) and spell(shadow_bolt) or spell(hand_of_guldan)
}

AddFunction demonologytyrant_prepcdactions
{
 unless timesincepreviousspell(doom) > 30 and spell(doom) or not hastalent(demonic_consumption_talent) and spell(demonic_strength)
 {
  #nether_portal
  spell(nether_portal)
  #grimoire_felguard
  spell(grimoire_felguard)
 }
}

AddFunction demonologytyrant_prepcdpostconditions
{
 timesincepreviousspell(doom) > 30 and spell(doom) or not hastalent(demonic_consumption_talent) and spell(demonic_strength) or spell(summon_vilefiend) or spell(call_dreadstalkers) or buffpresent(demonic_core) and soulshards() < 4 and { hastalent(demonic_consumption_talent) or buffexpires(nether_portal) } and spell(demonbolt) or soulshards() < 5 - 4 * buffpresent(nether_portal) and spell(shadow_bolt) or spell(hand_of_guldan)
}

### actions.summon_tyrant

AddFunction demonologysummon_tyrantmainactions
{
 #hand_of_guldan,if=soul_shard=5,line_cd=20
 if soulshards() == 5 and timesincepreviousspell(hand_of_guldan) > 20 spell(hand_of_guldan)
 #demonbolt,if=buff.demonic_core.up&(talent.demonic_consumption.enabled|buff.nether_portal.down),line_cd=20
 if buffpresent(demonic_core) and { hastalent(demonic_consumption_talent) or buffexpires(nether_portal) } and timesincepreviousspell(demonbolt) > 20 spell(demonbolt)
 #shadow_bolt,if=buff.wild_imps.stack+incoming_imps<4&(talent.demonic_consumption.enabled|buff.nether_portal.down),line_cd=20
 if demons(wild_imp) + demons(wild_imp_inner_demons) + message("incoming_imps is not implemented") < 4 and { hastalent(demonic_consumption_talent) or buffexpires(nether_portal) } and timesincepreviousspell(shadow_bolt) > 20 spell(shadow_bolt)
 #call_dreadstalkers
 spell(call_dreadstalkers)
 #hand_of_guldan
 spell(hand_of_guldan)
 #demonbolt,if=buff.demonic_core.up&buff.nether_portal.up&((buff.vilefiend.remains>5|!talent.summon_vilefiend.enabled)&(buff.grimoire_felguard.remains>5|buff.grimoire_felguard.down))
 if buffpresent(demonic_core) and buffpresent(nether_portal) and { demonduration(vilefiend) > 5 or not hastalent(summon_vilefiend_talent) } and { buffremaining(grimoire_felguard) > 5 or buffexpires(grimoire_felguard) } spell(demonbolt)
 #shadow_bolt,if=buff.nether_portal.up&((buff.vilefiend.remains>5|!talent.summon_vilefiend.enabled)&(buff.grimoire_felguard.remains>5|buff.grimoire_felguard.down))
 if buffpresent(nether_portal) and { demonduration(vilefiend) > 5 or not hastalent(summon_vilefiend_talent) } and { buffremaining(grimoire_felguard) > 5 or buffexpires(grimoire_felguard) } spell(shadow_bolt)
 #shadow_bolt
 spell(shadow_bolt)
}

AddFunction demonologysummon_tyrantmainpostconditions
{
}

AddFunction demonologysummon_tyrantshortcdactions
{
 unless soulshards() == 5 and timesincepreviousspell(hand_of_guldan) > 20 and spell(hand_of_guldan) or buffpresent(demonic_core) and { hastalent(demonic_consumption_talent) or buffexpires(nether_portal) } and timesincepreviousspell(demonbolt) > 20 and spell(demonbolt) or demons(wild_imp) + demons(wild_imp_inner_demons) + message("incoming_imps is not implemented") < 4 and { hastalent(demonic_consumption_talent) or buffexpires(nether_portal) } and timesincepreviousspell(shadow_bolt) > 20 and spell(shadow_bolt) or spell(call_dreadstalkers) or spell(hand_of_guldan) or buffpresent(demonic_core) and buffpresent(nether_portal) and { demonduration(vilefiend) > 5 or not hastalent(summon_vilefiend_talent) } and { buffremaining(grimoire_felguard) > 5 or buffexpires(grimoire_felguard) } and spell(demonbolt) or buffpresent(nether_portal) and { demonduration(vilefiend) > 5 or not hastalent(summon_vilefiend_talent) } and { buffremaining(grimoire_felguard) > 5 or buffexpires(grimoire_felguard) } and spell(shadow_bolt)
 {
  #variable,name=tyrant_ready,value=!cooldown.summon_demonic_tyrant.ready
  #summon_demonic_tyrant
  spell(summon_demonic_tyrant)
 }
}

AddFunction demonologysummon_tyrantshortcdpostconditions
{
 soulshards() == 5 and timesincepreviousspell(hand_of_guldan) > 20 and spell(hand_of_guldan) or buffpresent(demonic_core) and { hastalent(demonic_consumption_talent) or buffexpires(nether_portal) } and timesincepreviousspell(demonbolt) > 20 and spell(demonbolt) or demons(wild_imp) + demons(wild_imp_inner_demons) + message("incoming_imps is not implemented") < 4 and { hastalent(demonic_consumption_talent) or buffexpires(nether_portal) } and timesincepreviousspell(shadow_bolt) > 20 and spell(shadow_bolt) or spell(call_dreadstalkers) or spell(hand_of_guldan) or buffpresent(demonic_core) and buffpresent(nether_portal) and { demonduration(vilefiend) > 5 or not hastalent(summon_vilefiend_talent) } and { buffremaining(grimoire_felguard) > 5 or buffexpires(grimoire_felguard) } and spell(demonbolt) or buffpresent(nether_portal) and { demonduration(vilefiend) > 5 or not hastalent(summon_vilefiend_talent) } and { buffremaining(grimoire_felguard) > 5 or buffexpires(grimoire_felguard) } and spell(shadow_bolt) or spell(shadow_bolt)
}

AddFunction demonologysummon_tyrantcdactions
{
}

AddFunction demonologysummon_tyrantcdpostconditions
{
 soulshards() == 5 and timesincepreviousspell(hand_of_guldan) > 20 and spell(hand_of_guldan) or buffpresent(demonic_core) and { hastalent(demonic_consumption_talent) or buffexpires(nether_portal) } and timesincepreviousspell(demonbolt) > 20 and spell(demonbolt) or demons(wild_imp) + demons(wild_imp_inner_demons) + message("incoming_imps is not implemented") < 4 and { hastalent(demonic_consumption_talent) or buffexpires(nether_portal) } and timesincepreviousspell(shadow_bolt) > 20 and spell(shadow_bolt) or spell(call_dreadstalkers) or spell(hand_of_guldan) or buffpresent(demonic_core) and buffpresent(nether_portal) and { demonduration(vilefiend) > 5 or not hastalent(summon_vilefiend_talent) } and { buffremaining(grimoire_felguard) > 5 or buffexpires(grimoire_felguard) } and spell(demonbolt) or buffpresent(nether_portal) and { demonduration(vilefiend) > 5 or not hastalent(summon_vilefiend_talent) } and { buffremaining(grimoire_felguard) > 5 or buffexpires(grimoire_felguard) } and spell(shadow_bolt) or spell(summon_demonic_tyrant) or spell(shadow_bolt)
}

### actions.precombat

AddFunction demonologyprecombatmainactions
{
 #flask
 #food
 #augmentation
 #summon_pet
 if not pet.present() spell(summon_felguard)
 #inner_demons,if=talent.inner_demons.enabled
 if hastalent(inner_demons_talent) spell(inner_demons)
 #snapshot_stats
 #potion
 #demonbolt
 spell(demonbolt)
}

AddFunction demonologyprecombatmainpostconditions
{
}

AddFunction demonologyprecombatshortcdactions
{
}

AddFunction demonologyprecombatshortcdpostconditions
{
 not pet.present() and spell(summon_felguard) or hastalent(inner_demons_talent) and spell(inner_demons) or spell(demonbolt)
}

AddFunction demonologyprecombatcdactions
{
}

AddFunction demonologyprecombatcdpostconditions
{
 not pet.present() and spell(summon_felguard) or hastalent(inner_demons_talent) and spell(inner_demons) or spell(demonbolt)
}

### actions.off_gcd

AddFunction demonologyoff_gcdmainactions
{
 #berserking,if=pet.demonic_tyrant.active
 if demonduration(demonic_tyrant) > 0 spell(berserking)
}

AddFunction demonologyoff_gcdmainpostconditions
{
}

AddFunction demonologyoff_gcdshortcdactions
{
}

AddFunction demonologyoff_gcdshortcdpostconditions
{
 demonduration(demonic_tyrant) > 0 and spell(berserking)
}

AddFunction demonologyoff_gcdcdactions
{
 unless demonduration(demonic_tyrant) > 0 and spell(berserking)
 {
  #potion,if=buff.berserking.up|pet.demonic_tyrant.active&!race.troll
  #blood_fury,if=pet.demonic_tyrant.active
  if demonduration(demonic_tyrant) > 0 spell(blood_fury)
  #fireblood,if=pet.demonic_tyrant.active
  if demonduration(demonic_tyrant) > 0 spell(fireblood)
 }
}

AddFunction demonologyoff_gcdcdpostconditions
{
 demonduration(demonic_tyrant) > 0 and spell(berserking)
}

### actions.essences

AddFunction demonologyessencesmainactions
{
 #worldvein_resonance
 spell(worldvein_resonance)
 #memory_of_lucid_dreams
 spell(memory_of_lucid_dreams)
 #blood_of_the_enemy
 spell(blood_of_the_enemy)
 #ripple_in_space
 spell(ripple_in_space)
 #concentrated_flame
 spell(concentrated_flame)
 #the_unbound_force,if=buff.reckless_force.remains
 if buffpresent(reckless_force_buff) spell(the_unbound_force)
}

AddFunction demonologyessencesmainpostconditions
{
}

AddFunction demonologyessencesshortcdactions
{
 unless spell(worldvein_resonance) or spell(memory_of_lucid_dreams) or spell(blood_of_the_enemy) or spell(ripple_in_space)
 {
  #focused_azerite_beam
  spell(focused_azerite_beam)
  #purifying_blast
  spell(purifying_blast)
  #reaping_flames
  spell(reaping_flames)
 }
}

AddFunction demonologyessencesshortcdpostconditions
{
 spell(worldvein_resonance) or spell(memory_of_lucid_dreams) or spell(blood_of_the_enemy) or spell(ripple_in_space) or spell(concentrated_flame) or buffpresent(reckless_force_buff) and spell(the_unbound_force)
}

AddFunction demonologyessencescdactions
{
 unless spell(worldvein_resonance) or spell(memory_of_lucid_dreams) or spell(blood_of_the_enemy)
 {
  #guardian_of_azeroth
  spell(guardian_of_azeroth)
 }
}

AddFunction demonologyessencescdpostconditions
{
 spell(worldvein_resonance) or spell(memory_of_lucid_dreams) or spell(blood_of_the_enemy) or spell(ripple_in_space) or spell(focused_azerite_beam) or spell(purifying_blast) or spell(reaping_flames) or spell(concentrated_flame) or buffpresent(reckless_force_buff) and spell(the_unbound_force)
}

### actions.default

AddFunction demonology_defaultmainactions
{
 #call_action_list,name=off_gcd
 demonologyoff_gcdmainactions()

 unless demonologyoff_gcdmainpostconditions()
 {
  #call_action_list,name=essences
  demonologyessencesmainactions()

  unless demonologyessencesmainpostconditions()
  {
   #run_action_list,name=tyrant_prep,if=cooldown.summon_demonic_tyrant.remains<5&!variable.tyrant_ready
   if spellcooldown(summon_demonic_tyrant) < 5 and not tyrant_ready() demonologytyrant_prepmainactions()

   unless spellcooldown(summon_demonic_tyrant) < 5 and not tyrant_ready() and demonologytyrant_prepmainpostconditions()
   {
    #run_action_list,name=summon_tyrant,if=variable.tyrant_ready
    if tyrant_ready() demonologysummon_tyrantmainactions()

    unless tyrant_ready() and demonologysummon_tyrantmainpostconditions()
    {
     #call_dreadstalkers
     spell(call_dreadstalkers)
     #doom,if=refreshable
     if target.refreshable(doom) spell(doom)
     #hand_of_guldan,if=soul_shard=5|buff.nether_portal.up
     if soulshards() == 5 or buffpresent(nether_portal) spell(hand_of_guldan)
     #hand_of_guldan,if=soul_shard>=3&cooldown.summon_demonic_tyrant.remains>20&(cooldown.summon_vilefiend.remains>5|!talent.summon_vilefiend.enabled)&cooldown.call_dreadstalkers.remains>2
     if soulshards() >= 3 and spellcooldown(summon_demonic_tyrant) > 20 and { spellcooldown(summon_vilefiend) > 5 or not hastalent(summon_vilefiend_talent) } and spellcooldown(call_dreadstalkers) > 2 spell(hand_of_guldan)
     #demonbolt,if=buff.demonic_core.react&soul_shard<4
     if buffpresent(demonic_core) and soulshards() < 4 spell(demonbolt)
     #soul_strike
     spell(soul_strike)
     #shadow_bolt
     spell(shadow_bolt)
    }
   }
  }
 }
}

AddFunction demonology_defaultmainpostconditions
{
 demonologyoff_gcdmainpostconditions() or demonologyessencesmainpostconditions() or spellcooldown(summon_demonic_tyrant) < 5 and not tyrant_ready() and demonologytyrant_prepmainpostconditions() or tyrant_ready() and demonologysummon_tyrantmainpostconditions()
}

AddFunction demonology_defaultshortcdactions
{
 #call_action_list,name=off_gcd
 demonologyoff_gcdshortcdactions()

 unless demonologyoff_gcdshortcdpostconditions()
 {
  #call_action_list,name=essences
  demonologyessencesshortcdactions()

  unless demonologyessencesshortcdpostconditions()
  {
   #run_action_list,name=tyrant_prep,if=cooldown.summon_demonic_tyrant.remains<5&!variable.tyrant_ready
   if spellcooldown(summon_demonic_tyrant) < 5 and not tyrant_ready() demonologytyrant_prepshortcdactions()

   unless spellcooldown(summon_demonic_tyrant) < 5 and not tyrant_ready() and demonologytyrant_prepshortcdpostconditions()
   {
    #run_action_list,name=summon_tyrant,if=variable.tyrant_ready
    if tyrant_ready() demonologysummon_tyrantshortcdactions()

    unless tyrant_ready() and demonologysummon_tyrantshortcdpostconditions()
    {
     #summon_vilefiend,if=cooldown.summon_demonic_tyrant.remains>40|time_to_die<cooldown.summon_demonic_tyrant.remains+25
     if spellcooldown(summon_demonic_tyrant) > 40 or target.timetodie() < spellcooldown(summon_demonic_tyrant) + 25 spell(summon_vilefiend)

     unless spell(call_dreadstalkers) or target.refreshable(doom) and spell(doom)
     {
      #demonic_strength
      spell(demonic_strength)
      #bilescourge_bombers
      spell(bilescourge_bombers)

      unless { soulshards() == 5 or buffpresent(nether_portal) } and spell(hand_of_guldan) or soulshards() >= 3 and spellcooldown(summon_demonic_tyrant) > 20 and { spellcooldown(summon_vilefiend) > 5 or not hastalent(summon_vilefiend_talent) } and spellcooldown(call_dreadstalkers) > 2 and spell(hand_of_guldan) or buffpresent(demonic_core) and soulshards() < 4 and spell(demonbolt)
      {
       #power_siphon,if=buff.wild_imps.stack>1&buff.demonic_core.stack<3
       if demons(wild_imp) + demons(wild_imp_inner_demons) > 1 and buffstacks(demonic_core) < 3 spell(power_siphon)
      }
     }
    }
   }
  }
 }
}

AddFunction demonology_defaultshortcdpostconditions
{
 demonologyoff_gcdshortcdpostconditions() or demonologyessencesshortcdpostconditions() or spellcooldown(summon_demonic_tyrant) < 5 and not tyrant_ready() and demonologytyrant_prepshortcdpostconditions() or tyrant_ready() and demonologysummon_tyrantshortcdpostconditions() or spell(call_dreadstalkers) or target.refreshable(doom) and spell(doom) or { soulshards() == 5 or buffpresent(nether_portal) } and spell(hand_of_guldan) or soulshards() >= 3 and spellcooldown(summon_demonic_tyrant) > 20 and { spellcooldown(summon_vilefiend) > 5 or not hastalent(summon_vilefiend_talent) } and spellcooldown(call_dreadstalkers) > 2 and spell(hand_of_guldan) or buffpresent(demonic_core) and soulshards() < 4 and spell(demonbolt) or spell(soul_strike) or spell(shadow_bolt)
}

AddFunction demonology_defaultcdactions
{
 #call_action_list,name=off_gcd
 demonologyoff_gcdcdactions()

 unless demonologyoff_gcdcdpostconditions()
 {
  #call_action_list,name=essences
  demonologyessencescdactions()

  unless demonologyessencescdpostconditions()
  {
   #run_action_list,name=tyrant_prep,if=cooldown.summon_demonic_tyrant.remains<5&!variable.tyrant_ready
   if spellcooldown(summon_demonic_tyrant) < 5 and not tyrant_ready() demonologytyrant_prepcdactions()

   unless spellcooldown(summon_demonic_tyrant) < 5 and not tyrant_ready() and demonologytyrant_prepcdpostconditions()
   {
    #run_action_list,name=summon_tyrant,if=variable.tyrant_ready
    if tyrant_ready() demonologysummon_tyrantcdactions()

    unless tyrant_ready() and demonologysummon_tyrantcdpostconditions() or { spellcooldown(summon_demonic_tyrant) > 40 or target.timetodie() < spellcooldown(summon_demonic_tyrant) + 25 } and spell(summon_vilefiend) or spell(call_dreadstalkers) or target.refreshable(doom) and spell(doom) or spell(demonic_strength) or spell(bilescourge_bombers) or { soulshards() == 5 or buffpresent(nether_portal) } and spell(hand_of_guldan) or soulshards() >= 3 and spellcooldown(summon_demonic_tyrant) > 20 and { spellcooldown(summon_vilefiend) > 5 or not hastalent(summon_vilefiend_talent) } and spellcooldown(call_dreadstalkers) > 2 and spell(hand_of_guldan) or buffpresent(demonic_core) and soulshards() < 4 and spell(demonbolt)
    {
     #grimoire_felguard,if=cooldown.summon_demonic_tyrant.remains+cooldown.summon_demonic_tyrant.duration>time_to_die|time_to_die<cooldown.dummon_demonic_tyrant.remains+15
     if spellcooldown(summon_demonic_tyrant) + spellcooldownduration(summon_demonic_tyrant) > target.timetodie() or target.timetodie() < spellcooldown(summon_demonic_tyrant) + 15 spell(grimoire_felguard)
     #use_items
     demonologyuseitemactions()
    }
   }
  }
 }
}

AddFunction demonology_defaultcdpostconditions
{
 demonologyoff_gcdcdpostconditions() or demonologyessencescdpostconditions() or spellcooldown(summon_demonic_tyrant) < 5 and not tyrant_ready() and demonologytyrant_prepcdpostconditions() or tyrant_ready() and demonologysummon_tyrantcdpostconditions() or { spellcooldown(summon_demonic_tyrant) > 40 or target.timetodie() < spellcooldown(summon_demonic_tyrant) + 25 } and spell(summon_vilefiend) or spell(call_dreadstalkers) or target.refreshable(doom) and spell(doom) or spell(demonic_strength) or spell(bilescourge_bombers) or { soulshards() == 5 or buffpresent(nether_portal) } and spell(hand_of_guldan) or soulshards() >= 3 and spellcooldown(summon_demonic_tyrant) > 20 and { spellcooldown(summon_vilefiend) > 5 or not hastalent(summon_vilefiend_talent) } and spellcooldown(call_dreadstalkers) > 2 and spell(hand_of_guldan) or buffpresent(demonic_core) and soulshards() < 4 and spell(demonbolt) or demons(wild_imp) + demons(wild_imp_inner_demons) > 1 and buffstacks(demonic_core) < 3 and spell(power_siphon) or spell(soul_strike) or spell(shadow_bolt)
}

### Demonology icons.

AddCheckBox(opt_warlock_demonology_aoe l(aoe) default specialization=demonology)

AddIcon checkbox=!opt_warlock_demonology_aoe enemies=1 help=shortcd specialization=demonology
{
 if not incombat() demonologyprecombatshortcdactions()
 demonology_defaultshortcdactions()
}

AddIcon checkbox=opt_warlock_demonology_aoe help=shortcd specialization=demonology
{
 if not incombat() demonologyprecombatshortcdactions()
 demonology_defaultshortcdactions()
}

AddIcon enemies=1 help=main specialization=demonology
{
 if not incombat() demonologyprecombatmainactions()
 demonology_defaultmainactions()
}

AddIcon checkbox=opt_warlock_demonology_aoe help=aoe specialization=demonology
{
 if not incombat() demonologyprecombatmainactions()
 demonology_defaultmainactions()
}

AddIcon checkbox=!opt_warlock_demonology_aoe enemies=1 help=cd specialization=demonology
{
 if not incombat() demonologyprecombatcdactions()
 demonology_defaultcdactions()
}

AddIcon checkbox=opt_warlock_demonology_aoe help=cd specialization=demonology
{
 if not incombat() demonologyprecombatcdactions()
 demonology_defaultcdactions()
}

### Required symbols
# berserking
# bilescourge_bombers
# blood_fury
# blood_of_the_enemy
# call_dreadstalkers
# concentrated_flame
# demonbolt
# demonic_consumption_talent
# demonic_core
# demonic_strength
# doom
# fireblood
# focused_azerite_beam
# grimoire_felguard
# guardian_of_azeroth
# hand_of_guldan
# inner_demons
# inner_demons_talent
# memory_of_lucid_dreams
# nether_portal
# power_siphon
# purifying_blast
# reaping_flames
# reckless_force_buff
# ripple_in_space
# shadow_bolt
# soul_strike
# summon_demonic_tyrant
# summon_felguard
# summon_vilefiend
# summon_vilefiend_talent
# the_unbound_force
# vilefiend
# wild_imp
# wild_imp_inner_demons
# worldvein_resonance
]]
        OvaleScripts:RegisterScript("WARLOCK", "demonology", name, desc, code, "script")
    end
    do
        local name = "sc_t25_warlock_destruction"
        local desc = "[9.0] Simulationcraft: T25_Warlock_Destruction"
        local code = [[
# Based on SimulationCraft profile "T25_Warlock_Destruction".
#	class=warlock
#	spec=destruction
#	talents=2103023
#	pet=imp

Include(ovale_common)
Include(ovale_warlock_spells)

AddFunction pool_soul_shards
{
 enemies() > 1 and spellcooldown(havoc) <= 10 or spellcooldown(summon_infernal) <= 15 and hastalent(dark_soul_instability_talent) and spellcooldown(dark_soul_instability) <= 15 or hastalent(dark_soul_instability_talent) and spellcooldown(dark_soul_instability) <= 15 and { spellcooldown(summon_infernal) > target.timetodie() or spellcooldown(summon_infernal) + spellcooldownduration(summon_infernal) > target.timetodie() }
}

AddFunction destructionuseitemactions
{
 item(trinket0slot text=13 usable=1)
 item(trinket1slot text=14 usable=1)
}

### actions.precombat

AddFunction destructionprecombatmainactions
{
 #flask
 #food
 #augmentation
 #summon_pet
 if not pet.present() spell(summon_imp)
 #incinerate,if=!talent.soul_fire.enabled
 if not hastalent(soul_fire_talent) spell(incinerate)
}

AddFunction destructionprecombatmainpostconditions
{
}

AddFunction destructionprecombatshortcdactions
{
 unless not pet.present() and spell(summon_imp)
 {
  #grimoire_of_sacrifice,if=talent.grimoire_of_sacrifice.enabled
  if hastalent(grimoire_of_sacrifice_talent) and pet.present() spell(grimoire_of_sacrifice)
  #snapshot_stats
  #potion
  #soul_fire
  spell(soul_fire)
 }
}

AddFunction destructionprecombatshortcdpostconditions
{
 not pet.present() and spell(summon_imp) or not hastalent(soul_fire_talent) and spell(incinerate)
}

AddFunction destructionprecombatcdactions
{
}

AddFunction destructionprecombatcdpostconditions
{
 not pet.present() and spell(summon_imp) or hastalent(grimoire_of_sacrifice_talent) and pet.present() and spell(grimoire_of_sacrifice) or spell(soul_fire) or not hastalent(soul_fire_talent) and spell(incinerate)
}

### actions.havoc

AddFunction destructionhavocmainactions
{
 #conflagrate,if=buff.backdraft.down&soul_shard>=1&soul_shard<=4
 if buffexpires(backdraft) and soulshards() >= 1 and soulshards() <= 4 spell(conflagrate)
 #immolate,if=talent.internal_combustion.enabled&remains<duration*0.5|!talent.internal_combustion.enabled&refreshable
 if hastalent(internal_combustion_talent) and buffremaining(immolate) < baseduration(immolate) * 0.5 or not hastalent(internal_combustion_talent) and target.refreshable(immolate) spell(immolate)
 #chaos_bolt,if=cast_time<havoc_remains
 if casttime(chaos_bolt) < debuffremainingonany(havoc) spell(chaos_bolt)
 #shadowburn
 spell(shadowburn)
 #incinerate,if=cast_time<havoc_remains
 if casttime(incinerate) < debuffremainingonany(havoc) spell(incinerate)
}

AddFunction destructionhavocmainpostconditions
{
}

AddFunction destructionhavocshortcdactions
{
 unless buffexpires(backdraft) and soulshards() >= 1 and soulshards() <= 4 and spell(conflagrate)
 {
  #soul_fire
  spell(soul_fire)
 }
}

AddFunction destructionhavocshortcdpostconditions
{
 buffexpires(backdraft) and soulshards() >= 1 and soulshards() <= 4 and spell(conflagrate) or { hastalent(internal_combustion_talent) and buffremaining(immolate) < baseduration(immolate) * 0.5 or not hastalent(internal_combustion_talent) and target.refreshable(immolate) } and spell(immolate) or casttime(chaos_bolt) < debuffremainingonany(havoc) and spell(chaos_bolt) or spell(shadowburn) or casttime(incinerate) < debuffremainingonany(havoc) and spell(incinerate)
}

AddFunction destructionhavoccdactions
{
}

AddFunction destructionhavoccdpostconditions
{
 buffexpires(backdraft) and soulshards() >= 1 and soulshards() <= 4 and spell(conflagrate) or spell(soul_fire) or { hastalent(internal_combustion_talent) and buffremaining(immolate) < baseduration(immolate) * 0.5 or not hastalent(internal_combustion_talent) and target.refreshable(immolate) } and spell(immolate) or casttime(chaos_bolt) < debuffremainingonany(havoc) and spell(chaos_bolt) or spell(shadowburn) or casttime(incinerate) < debuffremainingonany(havoc) and spell(incinerate)
}

### actions.essences

AddFunction destructionessencesmainactions
{
 #worldvein_resonance
 spell(worldvein_resonance)
 #memory_of_lucid_dreams
 spell(memory_of_lucid_dreams)
 #blood_of_the_enemy
 spell(blood_of_the_enemy)
 #ripple_in_space
 spell(ripple_in_space)
 #concentrated_flame
 spell(concentrated_flame)
 #the_unbound_force,if=buff.reckless_force.remains
 if buffpresent(reckless_force_buff) spell(the_unbound_force)
}

AddFunction destructionessencesmainpostconditions
{
}

AddFunction destructionessencesshortcdactions
{
 unless spell(worldvein_resonance) or spell(memory_of_lucid_dreams) or spell(blood_of_the_enemy) or spell(ripple_in_space)
 {
  #focused_azerite_beam
  spell(focused_azerite_beam)
  #purifying_blast
  spell(purifying_blast)
  #reaping_flames
  spell(reaping_flames)
 }
}

AddFunction destructionessencesshortcdpostconditions
{
 spell(worldvein_resonance) or spell(memory_of_lucid_dreams) or spell(blood_of_the_enemy) or spell(ripple_in_space) or spell(concentrated_flame) or buffpresent(reckless_force_buff) and spell(the_unbound_force)
}

AddFunction destructionessencescdactions
{
 unless spell(worldvein_resonance) or spell(memory_of_lucid_dreams) or spell(blood_of_the_enemy)
 {
  #guardian_of_azeroth
  spell(guardian_of_azeroth)
 }
}

AddFunction destructionessencescdpostconditions
{
 spell(worldvein_resonance) or spell(memory_of_lucid_dreams) or spell(blood_of_the_enemy) or spell(ripple_in_space) or spell(focused_azerite_beam) or spell(purifying_blast) or spell(reaping_flames) or spell(concentrated_flame) or buffpresent(reckless_force_buff) and spell(the_unbound_force)
}

### actions.cds

AddFunction destructioncdsmainactions
{
 #potion,if=pet.infernal.active
 #berserking,if=pet.infernal.active
 if demonduration(infernal) > 0 spell(berserking)
}

AddFunction destructioncdsmainpostconditions
{
}

AddFunction destructioncdsshortcdactions
{
}

AddFunction destructioncdsshortcdpostconditions
{
 demonduration(infernal) > 0 and spell(berserking)
}

AddFunction destructioncdscdactions
{
 #summon_infernal
 spell(summon_infernal)
 #dark_soul_instability
 spell(dark_soul_instability)

 unless demonduration(infernal) > 0 and spell(berserking)
 {
  #blood_fury,if=pet.infernal.active
  if demonduration(infernal) > 0 spell(blood_fury)
  #fireblood,if=pet.infernal.active
  if demonduration(infernal) > 0 spell(fireblood)
  #use_items,if=pet.infernal.active|target.time_to_die<20
  if demonduration(infernal) > 0 or target.timetodie() < 20 destructionuseitemactions()
 }
}

AddFunction destructioncdscdpostconditions
{
 demonduration(infernal) > 0 and spell(berserking)
}

### actions.aoe

AddFunction destructionaoemainactions
{
 #rain_of_fire,if=pet.infernal.active&(!cooldown.havoc.ready|active_enemies>3)
 if demonduration(infernal) > 0 and { not spellcooldown(havoc) == 0 or enemies() > 3 } spell(rain_of_fire)
 #channel_demonfire,if=dot.immolate.remains>cast_time
 if target.debuffremaining(immolate) > casttime(channel_demonfire) spell(channel_demonfire)
 #immolate,cycle_targets=1,if=remains<5&(!talent.cataclysm.enabled|cooldown.cataclysm.remains>remains)
 if buffremaining(immolate) < 5 and { not hastalent(cataclysm_talent) or spellcooldown(cataclysm) > buffremaining(immolate) } spell(immolate)
 #call_action_list,name=cds
 destructioncdsmainactions()

 unless destructioncdsmainpostconditions()
 {
  #call_action_list,name=essences
  destructionessencesmainactions()

  unless destructionessencesmainpostconditions()
  {
   #rain_of_fire
   spell(rain_of_fire)
   #incinerate,if=talent.fire_and_brimstone.enabled&buff.backdraft.up&soul_shard<5-0.2*active_enemies
   if hastalent(fire_and_brimstone_talent) and buffpresent(backdraft) and soulshards() < 5 - 0.2 * enemies() spell(incinerate)
   #conflagrate,if=buff.backdraft.down
   if buffexpires(backdraft) spell(conflagrate)
   #shadowburn,if=target.health.pct<20
   if target.healthpercent() < 20 spell(shadowburn)
   #incinerate
   spell(incinerate)
  }
 }
}

AddFunction destructionaoemainpostconditions
{
 destructioncdsmainpostconditions() or destructionessencesmainpostconditions()
}

AddFunction destructionaoeshortcdactions
{
 unless demonduration(infernal) > 0 and { not spellcooldown(havoc) == 0 or enemies() > 3 } and spell(rain_of_fire) or target.debuffremaining(immolate) > casttime(channel_demonfire) and spell(channel_demonfire) or buffremaining(immolate) < 5 and { not hastalent(cataclysm_talent) or spellcooldown(cataclysm) > buffremaining(immolate) } and spell(immolate)
 {
  #call_action_list,name=cds
  destructioncdsshortcdactions()

  unless destructioncdsshortcdpostconditions()
  {
   #call_action_list,name=essences
   destructionessencesshortcdactions()

   unless destructionessencesshortcdpostconditions()
   {
    #havoc,cycle_targets=1,if=!(target=self.target)&active_enemies<4
    if not false(target_is_target) and enemies() < 4 and enemies() > 1 spell(havoc)

    unless spell(rain_of_fire)
    {
     #havoc,cycle_targets=1,if=!(self.target=target)
     if not player.guid() == target.guid() and enemies() > 1 spell(havoc)

     unless hastalent(fire_and_brimstone_talent) and buffpresent(backdraft) and soulshards() < 5 - 0.2 * enemies() and spell(incinerate)
     {
      #soul_fire
      spell(soul_fire)
     }
    }
   }
  }
 }
}

AddFunction destructionaoeshortcdpostconditions
{
 demonduration(infernal) > 0 and { not spellcooldown(havoc) == 0 or enemies() > 3 } and spell(rain_of_fire) or target.debuffremaining(immolate) > casttime(channel_demonfire) and spell(channel_demonfire) or buffremaining(immolate) < 5 and { not hastalent(cataclysm_talent) or spellcooldown(cataclysm) > buffremaining(immolate) } and spell(immolate) or destructioncdsshortcdpostconditions() or destructionessencesshortcdpostconditions() or spell(rain_of_fire) or hastalent(fire_and_brimstone_talent) and buffpresent(backdraft) and soulshards() < 5 - 0.2 * enemies() and spell(incinerate) or buffexpires(backdraft) and spell(conflagrate) or target.healthpercent() < 20 and spell(shadowburn) or spell(incinerate)
}

AddFunction destructionaoecdactions
{
 unless demonduration(infernal) > 0 and { not spellcooldown(havoc) == 0 or enemies() > 3 } and spell(rain_of_fire) or target.debuffremaining(immolate) > casttime(channel_demonfire) and spell(channel_demonfire) or buffremaining(immolate) < 5 and { not hastalent(cataclysm_talent) or spellcooldown(cataclysm) > buffremaining(immolate) } and spell(immolate)
 {
  #call_action_list,name=cds
  destructioncdscdactions()

  unless destructioncdscdpostconditions()
  {
   #call_action_list,name=essences
   destructionessencescdactions()
  }
 }
}

AddFunction destructionaoecdpostconditions
{
 demonduration(infernal) > 0 and { not spellcooldown(havoc) == 0 or enemies() > 3 } and spell(rain_of_fire) or target.debuffremaining(immolate) > casttime(channel_demonfire) and spell(channel_demonfire) or buffremaining(immolate) < 5 and { not hastalent(cataclysm_talent) or spellcooldown(cataclysm) > buffremaining(immolate) } and spell(immolate) or destructioncdscdpostconditions() or destructionessencescdpostconditions() or not false(target_is_target) and enemies() < 4 and enemies() > 1 and spell(havoc) or spell(rain_of_fire) or not player.guid() == target.guid() and enemies() > 1 and spell(havoc) or hastalent(fire_and_brimstone_talent) and buffpresent(backdraft) and soulshards() < 5 - 0.2 * enemies() and spell(incinerate) or spell(soul_fire) or buffexpires(backdraft) and spell(conflagrate) or target.healthpercent() < 20 and spell(shadowburn) or spell(incinerate)
}

### actions.default

AddFunction destruction_defaultmainactions
{
 #call_action_list,name=havoc,if=havoc_active&active_enemies<5-talent.inferno.enabled+(talent.inferno.enabled&talent.internal_combustion.enabled)
 if debuffcountonany(havoc) > 0 and enemies() < 5 - talentpoints(inferno_talent) + { hastalent(inferno_talent) and hastalent(internal_combustion_talent) } destructionhavocmainactions()

 unless debuffcountonany(havoc) > 0 and enemies() < 5 - talentpoints(inferno_talent) + { hastalent(inferno_talent) and hastalent(internal_combustion_talent) } and destructionhavocmainpostconditions()
 {
  #call_action_list,name=aoe,if=active_enemies>2
  if enemies() > 2 destructionaoemainactions()

  unless enemies() > 2 and destructionaoemainpostconditions()
  {
   #immolate,cycle_targets=1,if=refreshable&(!talent.cataclysm.enabled|cooldown.cataclysm.remains>remains)
   if target.refreshable(immolate) and { not hastalent(cataclysm_talent) or spellcooldown(cataclysm) > buffremaining(immolate) } spell(immolate)
   #immolate,if=talent.internal_combustion.enabled&action.chaos_bolt.in_flight&remains<duration*0.5
   if hastalent(internal_combustion_talent) and inflighttotarget(chaos_bolt) and buffremaining(immolate) < baseduration(immolate) * 0.5 spell(immolate)
   #call_action_list,name=cds
   destructioncdsmainactions()

   unless destructioncdsmainpostconditions()
   {
    #call_action_list,name=essences
    destructionessencesmainactions()

    unless destructionessencesmainpostconditions()
    {
     #channel_demonfire
     spell(channel_demonfire)
     #variable,name=pool_soul_shards,value=active_enemies>1&cooldown.havoc.remains<=10|cooldown.summon_infernal.remains<=15&talent.dark_soul_instability.enabled&cooldown.dark_soul_instability.remains<=15|talent.dark_soul_instability.enabled&cooldown.dark_soul_instability.remains<=15&(cooldown.summon_infernal.remains>target.time_to_die|cooldown.summon_infernal.remains+cooldown.summon_infernal.duration>target.time_to_die)
     #conflagrate,if=buff.backdraft.down&soul_shard>=1.5-0.3*talent.flashover.enabled&!variable.pool_soul_shards
     if buffexpires(backdraft) and soulshards() >= 1.5 - 0.3 * talentpoints(flashover_talent) and not pool_soul_shards() spell(conflagrate)
     #chaos_bolt,if=buff.dark_soul_instability.up
     if buffpresent(dark_soul_instability) spell(chaos_bolt)
     #chaos_bolt,if=buff.backdraft.up&!variable.pool_soul_shards&!talent.eradication.enabled
     if buffpresent(backdraft) and not pool_soul_shards() and not hastalent(eradication_talent) spell(chaos_bolt)
     #chaos_bolt,if=!variable.pool_soul_shards&talent.eradication.enabled&(debuff.eradication.remains<cast_time|buff.backdraft.up)
     if not pool_soul_shards() and hastalent(eradication_talent) and { target.debuffremaining(eradication) < casttime(chaos_bolt) or buffpresent(backdraft) } spell(chaos_bolt)
     #shadowburn,if=!variable.pool_soul_shards|soul_shard>=4.5
     if not pool_soul_shards() or soulshards() >= 4.5 spell(shadowburn)
     #chaos_bolt,if=(soul_shard>=4.5-0.2*active_enemies)
     if soulshards() >= 4.5 - 0.2 * enemies() spell(chaos_bolt)
     #conflagrate,if=charges>1
     if charges(conflagrate) > 1 spell(conflagrate)
     #incinerate
     spell(incinerate)
    }
   }
  }
 }
}

AddFunction destruction_defaultmainpostconditions
{
 debuffcountonany(havoc) > 0 and enemies() < 5 - talentpoints(inferno_talent) + { hastalent(inferno_talent) and hastalent(internal_combustion_talent) } and destructionhavocmainpostconditions() or enemies() > 2 and destructionaoemainpostconditions() or destructioncdsmainpostconditions() or destructionessencesmainpostconditions()
}

AddFunction destruction_defaultshortcdactions
{
 #call_action_list,name=havoc,if=havoc_active&active_enemies<5-talent.inferno.enabled+(talent.inferno.enabled&talent.internal_combustion.enabled)
 if debuffcountonany(havoc) > 0 and enemies() < 5 - talentpoints(inferno_talent) + { hastalent(inferno_talent) and hastalent(internal_combustion_talent) } destructionhavocshortcdactions()

 unless debuffcountonany(havoc) > 0 and enemies() < 5 - talentpoints(inferno_talent) + { hastalent(inferno_talent) and hastalent(internal_combustion_talent) } and destructionhavocshortcdpostconditions()
 {
  #cataclysm,if=!(pet.infernal.active&dot.immolate.remains+1>pet.infernal.remains)|spell_targets.cataclysm>1
  if not { demonduration(infernal) > 0 and target.debuffremaining(immolate) + 1 > demonduration(infernal) } or enemies() > 1 spell(cataclysm)
  #call_action_list,name=aoe,if=active_enemies>2
  if enemies() > 2 destructionaoeshortcdactions()

  unless enemies() > 2 and destructionaoeshortcdpostconditions()
  {
   #soul_fire,cycle_targets=1,if=refreshable&soul_shard<=4&(!talent.cataclysm.enabled|cooldown.cataclysm.remains>remains)
   if target.refreshable(soul_fire) and soulshards() <= 4 and { not hastalent(cataclysm_talent) or spellcooldown(cataclysm) > buffremaining(soul_fire) } spell(soul_fire)

   unless target.refreshable(immolate) and { not hastalent(cataclysm_talent) or spellcooldown(cataclysm) > buffremaining(immolate) } and spell(immolate) or hastalent(internal_combustion_talent) and inflighttotarget(chaos_bolt) and buffremaining(immolate) < baseduration(immolate) * 0.5 and spell(immolate)
   {
    #call_action_list,name=cds
    destructioncdsshortcdactions()

    unless destructioncdsshortcdpostconditions()
    {
     #call_action_list,name=essences
     destructionessencesshortcdactions()

     unless destructionessencesshortcdpostconditions() or spell(channel_demonfire)
     {
      #havoc,cycle_targets=1,if=!(target=self.target)&(dot.immolate.remains>dot.immolate.duration*0.5|!talent.internal_combustion.enabled)
      if not false(target_is_target) and { target.debuffremaining(immolate) > target.debuffduration(immolate) * 0.5 or not hastalent(internal_combustion_talent) } and enemies() > 1 spell(havoc)
     }
    }
   }
  }
 }
}

AddFunction destruction_defaultshortcdpostconditions
{
 debuffcountonany(havoc) > 0 and enemies() < 5 - talentpoints(inferno_talent) + { hastalent(inferno_talent) and hastalent(internal_combustion_talent) } and destructionhavocshortcdpostconditions() or enemies() > 2 and destructionaoeshortcdpostconditions() or target.refreshable(immolate) and { not hastalent(cataclysm_talent) or spellcooldown(cataclysm) > buffremaining(immolate) } and spell(immolate) or hastalent(internal_combustion_talent) and inflighttotarget(chaos_bolt) and buffremaining(immolate) < baseduration(immolate) * 0.5 and spell(immolate) or destructioncdsshortcdpostconditions() or destructionessencesshortcdpostconditions() or spell(channel_demonfire) or buffexpires(backdraft) and soulshards() >= 1.5 - 0.3 * talentpoints(flashover_talent) and not pool_soul_shards() and spell(conflagrate) or buffpresent(dark_soul_instability) and spell(chaos_bolt) or buffpresent(backdraft) and not pool_soul_shards() and not hastalent(eradication_talent) and spell(chaos_bolt) or not pool_soul_shards() and hastalent(eradication_talent) and { target.debuffremaining(eradication) < casttime(chaos_bolt) or buffpresent(backdraft) } and spell(chaos_bolt) or { not pool_soul_shards() or soulshards() >= 4.5 } and spell(shadowburn) or soulshards() >= 4.5 - 0.2 * enemies() and spell(chaos_bolt) or charges(conflagrate) > 1 and spell(conflagrate) or spell(incinerate)
}

AddFunction destruction_defaultcdactions
{
 #call_action_list,name=havoc,if=havoc_active&active_enemies<5-talent.inferno.enabled+(talent.inferno.enabled&talent.internal_combustion.enabled)
 if debuffcountonany(havoc) > 0 and enemies() < 5 - talentpoints(inferno_talent) + { hastalent(inferno_talent) and hastalent(internal_combustion_talent) } destructionhavoccdactions()

 unless debuffcountonany(havoc) > 0 and enemies() < 5 - talentpoints(inferno_talent) + { hastalent(inferno_talent) and hastalent(internal_combustion_talent) } and destructionhavoccdpostconditions() or { not { demonduration(infernal) > 0 and target.debuffremaining(immolate) + 1 > demonduration(infernal) } or enemies() > 1 } and spell(cataclysm)
 {
  #call_action_list,name=aoe,if=active_enemies>2
  if enemies() > 2 destructionaoecdactions()

  unless enemies() > 2 and destructionaoecdpostconditions() or target.refreshable(soul_fire) and soulshards() <= 4 and { not hastalent(cataclysm_talent) or spellcooldown(cataclysm) > buffremaining(soul_fire) } and spell(soul_fire) or target.refreshable(immolate) and { not hastalent(cataclysm_talent) or spellcooldown(cataclysm) > buffremaining(immolate) } and spell(immolate) or hastalent(internal_combustion_talent) and inflighttotarget(chaos_bolt) and buffremaining(immolate) < baseduration(immolate) * 0.5 and spell(immolate)
  {
   #call_action_list,name=cds
   destructioncdscdactions()

   unless destructioncdscdpostconditions()
   {
    #call_action_list,name=essences
    destructionessencescdactions()
   }
  }
 }
}

AddFunction destruction_defaultcdpostconditions
{
 debuffcountonany(havoc) > 0 and enemies() < 5 - talentpoints(inferno_talent) + { hastalent(inferno_talent) and hastalent(internal_combustion_talent) } and destructionhavoccdpostconditions() or { not { demonduration(infernal) > 0 and target.debuffremaining(immolate) + 1 > demonduration(infernal) } or enemies() > 1 } and spell(cataclysm) or enemies() > 2 and destructionaoecdpostconditions() or target.refreshable(soul_fire) and soulshards() <= 4 and { not hastalent(cataclysm_talent) or spellcooldown(cataclysm) > buffremaining(soul_fire) } and spell(soul_fire) or target.refreshable(immolate) and { not hastalent(cataclysm_talent) or spellcooldown(cataclysm) > buffremaining(immolate) } and spell(immolate) or hastalent(internal_combustion_talent) and inflighttotarget(chaos_bolt) and buffremaining(immolate) < baseduration(immolate) * 0.5 and spell(immolate) or destructioncdscdpostconditions() or destructionessencescdpostconditions() or spell(channel_demonfire) or not false(target_is_target) and { target.debuffremaining(immolate) > target.debuffduration(immolate) * 0.5 or not hastalent(internal_combustion_talent) } and enemies() > 1 and spell(havoc) or buffexpires(backdraft) and soulshards() >= 1.5 - 0.3 * talentpoints(flashover_talent) and not pool_soul_shards() and spell(conflagrate) or buffpresent(dark_soul_instability) and spell(chaos_bolt) or buffpresent(backdraft) and not pool_soul_shards() and not hastalent(eradication_talent) and spell(chaos_bolt) or not pool_soul_shards() and hastalent(eradication_talent) and { target.debuffremaining(eradication) < casttime(chaos_bolt) or buffpresent(backdraft) } and spell(chaos_bolt) or { not pool_soul_shards() or soulshards() >= 4.5 } and spell(shadowburn) or soulshards() >= 4.5 - 0.2 * enemies() and spell(chaos_bolt) or charges(conflagrate) > 1 and spell(conflagrate) or spell(incinerate)
}

### Destruction icons.

AddCheckBox(opt_warlock_destruction_aoe l(aoe) default specialization=destruction)

AddIcon checkbox=!opt_warlock_destruction_aoe enemies=1 help=shortcd specialization=destruction
{
 if not incombat() destructionprecombatshortcdactions()
 destruction_defaultshortcdactions()
}

AddIcon checkbox=opt_warlock_destruction_aoe help=shortcd specialization=destruction
{
 if not incombat() destructionprecombatshortcdactions()
 destruction_defaultshortcdactions()
}

AddIcon enemies=1 help=main specialization=destruction
{
 if not incombat() destructionprecombatmainactions()
 destruction_defaultmainactions()
}

AddIcon checkbox=opt_warlock_destruction_aoe help=aoe specialization=destruction
{
 if not incombat() destructionprecombatmainactions()
 destruction_defaultmainactions()
}

AddIcon checkbox=!opt_warlock_destruction_aoe enemies=1 help=cd specialization=destruction
{
 if not incombat() destructionprecombatcdactions()
 destruction_defaultcdactions()
}

AddIcon checkbox=opt_warlock_destruction_aoe help=cd specialization=destruction
{
 if not incombat() destructionprecombatcdactions()
 destruction_defaultcdactions()
}

### Required symbols
# backdraft
# berserking
# blood_fury
# blood_of_the_enemy
# cataclysm
# cataclysm_talent
# channel_demonfire
# chaos_bolt
# concentrated_flame
# conflagrate
# dark_soul_instability
# dark_soul_instability_talent
# eradication
# eradication_talent
# fire_and_brimstone_talent
# fireblood
# flashover_talent
# focused_azerite_beam
# grimoire_of_sacrifice
# grimoire_of_sacrifice_talent
# guardian_of_azeroth
# havoc
# immolate
# incinerate
# inferno_talent
# internal_combustion_talent
# memory_of_lucid_dreams
# purifying_blast
# rain_of_fire
# reaping_flames
# reckless_force_buff
# ripple_in_space
# shadowburn
# soul_fire
# soul_fire_talent
# summon_imp
# summon_infernal
# the_unbound_force
# worldvein_resonance
]]
        OvaleScripts:RegisterScript("WARLOCK", "destruction", name, desc, code, "script")
    end
end
