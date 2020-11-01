local __exports = LibStub:NewLibrary("ovale/scripts/ovale_mage_spells", 80300)
if not __exports then return end
__exports.registerMageSpells = function(OvaleScripts)
    local name = "ovale_mage_spells"
    local desc = "[9.0] Ovale: Mage spells"
    local code = [[Define(alexstraszas_fury 235870)
# Dragon's Breath always critically strikes for s2 increased critical strike damage and contributes to Hot Streak. rnrnAdditionally, damage done by your next Pyroblast or Flamestrike is increased by 334277s1.
  SpellInfo(alexstraszas_fury cd=45 channel=0 gcd=0 offgcd=1 talent=alexstraszas_fury_talent)
  SpellAddBuff(alexstraszas_fury alexstraszas_fury=1)
Define(ancestral_call 274738)
# Invoke the spirits of your ancestors, granting you a random secondary stat for 15 seconds.
  SpellInfo(ancestral_call cd=120 duration=15 gcd=0 offgcd=1)
  SpellAddBuff(ancestral_call ancestral_call=1)
Define(arcane_barrage 44425)
# Launches bolts of arcane energy at the enemy target, causing (72.8 of Spell Power) Arcane damage. rnrnFor each Arcane Charge, deals 36032s2 additional damage?a321526[, grants you 321526s1 of your maximum mana,][]?a231564[ and hits 36032s3 additional nearby Ltarget:targets; for s2 of its damage][].rnrn|cFFFFFFFFConsumes all Arcane Charges.|r
# Rank 3: Arcane Barrage grants you s1 of your maximum mana per Arcane Charge spent.
  SpellInfo(arcane_barrage cd=3)
Define(arcane_blast 30451)
# Blasts the target with energy, dealing (45.7 of Spell Power) Arcane damage.rnrnEach Arcane Charge increases damage by 36032s1 and mana cost by 36032s5, and reduces cast time by 36032s4.rnrn|cFFFFFFFFGenerates 1 Arcane Charge.|r
  SpellInfo(arcane_blast arcanecharges=-1)
Define(arcane_charge_buff_0 36032)
# @spelldesc114664
  SpellInfo(arcane_charge_buff_0 max_stacks=4 gcd=0 offgcd=1)
  # Increases the damage of Arcane Blast, Arcane Missiles, Arcane Explosion, and Arcane Barrage by 36032w1.rnrnIncreases the mana cost of Arcane Blast by 36032w2?w5<0[, and reduces the cast time of Arcane Blast by w5.][.]rnrnIncreases the number of targets hit by Arcane Barrage for 50 damage by 36032w3.
  SpellAddBuff(arcane_charge_buff_0 arcane_charge_buff_0=1)
Define(arcane_charge_buff_1 195302)
  SpellInfo(arcane_charge_buff_1 max_stacks=4 gcd=0 offgcd=1)
  # Increases the mana cost of Arcane Blast by 36032w2?w5<0[, and reduces the cast time of Arcane Blast by w5.][.]rnrnIncreases the number of targets hit by Arcane Barrage for 50 damage by 36032w3.
  SpellAddBuff(arcane_charge_buff_1 arcane_charge_buff_1=1)
Define(arcane_explosion 1449)
# Causes an explosion of magic around the caster, dealing (54.6 of Spell Power) Arcane damage to all enemies within A2 yards.?a137021[rnrn|cFFFFFFFFGenerates s1 Arcane Charge if any targets are hit.|r][]
# Rank 2: Damage increased by s1.
  SpellInfo(arcane_explosion arcanecharges=-1)
Define(arcane_familiar 205022)
# Summon a Familiar that attacks your enemies and increases your maximum mana by 210126s1 for 3600 seconds.
  SpellInfo(arcane_familiar cd=10 duration=3600 talent=arcane_familiar_talent)

  SpellAddTargetDebuff(arcane_familiar arcane_familiar=1)
Define(arcane_intellect 1459)
# Infuses the target with brilliance, increasing their Intellect by s1 for 3600 seconds.  rnrnIf target is in your party or raid, all party and raid members will be affected.
  SpellInfo(arcane_intellect duration=3600)
  # Intellect increased by w1.
  SpellAddTargetDebuff(arcane_intellect arcane_intellect=1)
Define(arcane_missiles 5143)
# Launches five waves of Arcane Missiles at the enemy over 2.5 seconds, causing a total of 5*(40.5 of Spell Power) Arcane damage.
  SpellInfo(arcane_missiles duration=2.5 channel=2.5 tick=0.625)
  SpellAddBuff(arcane_missiles arcane_missiles=1)
  SpellAddTargetDebuff(arcane_missiles arcane_missiles=1)
Define(arcane_orb 153626)
# Launches an Arcane Orb forward from your position, traveling up to 40 yards, dealing (109.2 of Spell Power) Arcane damage to enemies it passes through.rnrn|cFFFFFFFFGrants 1 Arcane Charge when cast and every time it deals damage.|r
  SpellInfo(arcane_orb cd=20 duration=2.5 arcanecharges=-1 talent=arcane_orb_talent)
Define(arcane_power 12042)
# For 10 seconds, you deal s1 more spell damage?a343208[ and your spells cost s2 less mana][].
# Rank 2: Arcane Power reduces your spells cost by 12042s2.
  SpellInfo(arcane_power cd=120 duration=10 gcd=0 offgcd=1)
  # Spell damage increased by w1.rn?a343208[Mana costs of your damaging spells reduced by w2.][]
  SpellAddBuff(arcane_power arcane_power=1)
Define(bag_of_tricks 312411)
# Pull your chosen trick from the bag and use it on target enemy or ally. Enemies take <damage> damage, while allies are healed for <healing>. 
  SpellInfo(bag_of_tricks cd=90)
Define(berserking 59621)
# Permanently enchant a melee weapon to sometimes increase your attack power by 59620s1, but at the cost of reduced armor. Cannot be applied to items higher than level ecix
  SpellInfo(berserking gcd=0 offgcd=1)
Define(blaster_master_buff 274597)
# Scorch increases the damage the target takes from your Fire Blast by s1 for 30 seconds.
  SpellInfo(blaster_master_buff channel=-0.001 gcd=0 offgcd=1)

Define(blizzard 190356)
# Ice shards pelt the target area, dealing 190357m1*8 Frost damage over 8 seconds and reducing movement speed by 12486s1 for 3 seconds.?a236662[rnrnEach time Blizzard deals damage, the cooldown of Frozen Orb is reduced by 236662s1/100.1 sec.][]
# Rank 3: Damage increased by s1.
  SpellInfo(blizzard cd=8 duration=8)
Define(blood_fury_0 20572)
# Increases your attack power by s1 for 15 seconds.
  SpellInfo(blood_fury_0 cd=120 duration=15 gcd=0 offgcd=1)
  # Attack power increased by w1.
  SpellAddBuff(blood_fury_0 blood_fury_0=1)
Define(blood_fury_1 24571)
# Instantly increases your rage by 300/10.
  SpellInfo(blood_fury_1 gcd=0 offgcd=1 rage=-30)
Define(blood_fury_2 33697)
# Increases your attack power and Intellect by s1 for 15 seconds.
  SpellInfo(blood_fury_2 cd=120 duration=15 gcd=0 offgcd=1)
  # Attack power and Intellect increased by w1.
  SpellAddBuff(blood_fury_2 blood_fury_2=1)
Define(blood_fury_3 33702)
# Increases your Intellect by s1 for 15 seconds.
  SpellInfo(blood_fury_3 cd=120 duration=15 gcd=0 offgcd=1)
  # Intellect increased by w1.
  SpellAddBuff(blood_fury_3 blood_fury_3=1)
Define(blood_of_the_enemy_0 297969)
# Infuse your Heart of Azeroth with Blood of the Enemy.
  SpellInfo(blood_of_the_enemy_0)
Define(blood_of_the_enemy_1 297970)
# Infuse your Heart of Azeroth with Blood of the Enemy.
  SpellInfo(blood_of_the_enemy_1)
Define(blood_of_the_enemy_2 297971)
# Infuse your Heart of Azeroth with Blood of the Enemy.
  SpellInfo(blood_of_the_enemy_2)
Define(blood_of_the_enemy_3 299039)
# Infuse your Heart of Azeroth with Blood of the Enemy.
  SpellInfo(blood_of_the_enemy_3)
Define(brain_freeze_0 190447)
# Frostbolt has a m1 chance to empower your next Flurry to be instant cast?a231584[,][ and] deal 190446s2 increased damage?a231584[, and apply Winter's Chill to the target. rnrnWinter's Chill causes the target to take damage from your spells as if it were frozen][].
  SpellInfo(brain_freeze_0 channel=0 gcd=0 offgcd=1)
  SpellAddBuff(brain_freeze_0 brain_freeze_0=1)
Define(brain_freeze_1 231584)
# Brain Freeze causes your next Flurry to  apply Winter's Chill to the target. rnrnWinter's Chill causes the target to take damage from your spells as if it were frozen.
  SpellInfo(brain_freeze_1 channel=0 gcd=0 offgcd=1)
  SpellAddBuff(brain_freeze_1 brain_freeze_1=1)
Define(clearcasting_0 79684)
# For each c*100/s1 mana you spend, you have a 1 chance to gain Clearcasting, making your next Arcane Missiles or Arcane Explosion free and channel 277726s1 faster.?a321758[rnrnArcane Missiles fires 321758s2 additional missile.][]
  SpellInfo(clearcasting_0 channel=0 gcd=0 offgcd=1)
  SpellAddBuff(clearcasting_0 clearcasting_0=1)
Define(clearcasting_1 321420)
# Clearcasting can stack up to s1 additional times.
  SpellInfo(clearcasting_1 channel=0 gcd=0 offgcd=1)
  SpellAddBuff(clearcasting_1 clearcasting_1=1)
Define(clearcasting_2 321758)
# When Clearcast, Arcane Missiles fires s2 additional lmissile:missiles;.
  SpellInfo(clearcasting_2 channel=0 gcd=0 offgcd=1)
  SpellAddBuff(clearcasting_2 clearcasting_2=1)
Define(combustion 190319)
# Engulfs you in flames for 10 seconds, increasing your spells' critical strike chance by s1 and granting you Mastery equal to s3 your Critical Strike stat. Castable while casting other spells.
# Rank 2: Duration increased by s1/1000 sec.
  SpellInfo(combustion cd=120 duration=10 gcd=0 offgcd=1 tick=0.5)
  # Critical Strike chance of your spells increased by w1.?a231630[rnMastery increased by w2.][]
  SpellAddBuff(combustion combustion=1)
Define(comet_storm 153595)
# Calls down a series of 7 icy comets on and around the target, that deals up to 7*(40 of Spell Power) Frost damage to all enemies within 228601A1 yds of its impacts.
  SpellInfo(comet_storm cd=30 talent=comet_storm_talent)
Define(concentrated_flame_0 295368)
# Blast your target with a ball of concentrated flame, dealing 295365s2*(1+@versadmg) Fire damage to an enemy or healing an ally for 295365s2*(1+@versadmg)?a295377[, then burn the target for an additional 295377m1 of the damage or healing done over 6 seconds][]. rnrnEach cast of Concentrated Flame deals s3 increased damage or healing. This bonus resets after every third cast.
  SpellInfo(concentrated_flame_0 duration=6 channel=6 gcd=0 offgcd=1 tick=2)
  # Suffering w1 damage every t1 sec.
  SpellAddTargetDebuff(concentrated_flame_0 concentrated_flame_0=1)
Define(concentrated_flame_1 295373)
# Blast your target with a ball of concentrated flame, dealing 295365s2*(1+@versadmg) Fire damage to an enemy or healing an ally for 295365s2*(1+@versadmg)?a295377[, then burn the target for an additional 295377m1 of the damage or healing done over 6 seconds][]. rnrnEach cast of Concentrated Flame deals s3 increased damage or healing. This bonus resets after every third cast.
  SpellInfo(concentrated_flame_1 cd=30 channel=0)
  SpellAddTargetDebuff(concentrated_flame_1 concentrated_flame_3=1)
Define(concentrated_flame_2 295374)
# Blast your target with a ball of concentrated flame, dealing 295365s2*(1+@versadmg) Fire damage to an enemy or healing an ally for 295365s2*(1+@versadmg)?a295377[, then burn the target for an additional 295377m1 of the damage or healing done over 6 seconds][]. rnrnEach cast of Concentrated Flame deals s3 increased damage or healing. This bonus resets after every third cast.
  SpellInfo(concentrated_flame_2 channel=0 gcd=0 offgcd=1)
Define(concentrated_flame_3 295376)
# Blast your target with a ball of concentrated flame, dealing 295365s2*(1+@versadmg) Fire damage to an enemy or healing an ally for 295365s2*(1+@versadmg)?a295377[, then burn the target for an additional 295377m1 of the damage or healing done over 6 seconds][]. rnrnEach cast of Concentrated Flame deals s3 increased damage or healing. This bonus resets after every third cast.
  SpellInfo(concentrated_flame_3 channel=0 gcd=0 offgcd=1)
Define(concentrated_flame_4 295380)
# Concentrated Flame gains an enhanced appearance.
  SpellInfo(concentrated_flame_4 channel=0 gcd=0 offgcd=1)
  SpellAddBuff(concentrated_flame_4 concentrated_flame_4=1)
Define(concentrated_flame_5 299349)
# Blast your target with a ball of concentrated flame, dealing 295365s2*(1+@versadmg) Fire damage to an enemy or healing an ally for 295365s2*(1+@versadmg), then burn the target for an additional 295377m1 of the damage or healing done over 6 seconds.rnrnEach cast of Concentrated Flame deals s3 increased damage or healing. This bonus resets after every third cast.
  SpellInfo(concentrated_flame_5 cd=30 channel=0 gcd=1)
  SpellAddTargetDebuff(concentrated_flame_5 concentrated_flame_3=1)
Define(concentrated_flame_6 299353)
# Blast your target with a ball of concentrated flame, dealing 295365s2*(1+@versadmg) Fire damage to an enemy or healing an ally for 295365s2*(1+@versadmg), then burn the target for an additional 295377m1 of the damage or healing done over 6 seconds.rnrnEach cast of Concentrated Flame deals s3 increased damage or healing. This bonus resets after every third cast.rn|cFFFFFFFFMax s1 Charges.|r
  SpellInfo(concentrated_flame_6 cd=30 channel=0 gcd=1)
  SpellAddTargetDebuff(concentrated_flame_6 concentrated_flame_3=1)
Define(conjure_mana_gem 759)
# Conjures a Mana Gem that can be used to instantly restore 5405s1 mana, and holds up to s2 charges.rnrn@spellname118812rnConjured items disappear if logged out for more than 15 minutes.
  SpellInfo(conjure_mana_gem)
Define(counterspell 2139)
# Counters the enemy's spellcast, preventing any spell from that school of magic from being cast for 6 seconds?s12598[ and silencing the target for 55021d][].
  SpellInfo(counterspell cd=24 duration=6 gcd=0 offgcd=1 interrupt=1)
Define(deathborne 324220)
# Transform into a powerful skeletal mage for 20 seconds. rnrnWhile in the form of a skeletal mage, your Frostbolt, Fireball, and Arcane Blast hit up to s4 enemies near your target and your spell damage is increased by s2.
  SpellInfo(deathborne cd=180 duration=20)
  # Transformed into a powerful skeletal mage, greatly enhancing your Frostbolt, Fireball, and Arcane Blast and increasing your spell damage by s2.
  SpellAddBuff(deathborne deathborne=1)
Define(disciplinary_command 327371)
# Casting a Frost, Fire and Arcane spell within 10 seconds of each other increases your Critical Strike damage of all your spells by 327371s1. This effect can only occur once every 327371s2 sec.
  SpellInfo(disciplinary_command cd=30 duration=20 gcd=0 offgcd=1)
  # Critical Strike damage increased by w1.
  SpellAddBuff(disciplinary_command disciplinary_command=1)
Define(dragons_breath 31661)
# Enemies in a cone in front of you take (58.25 of Spell Power) Fire damage and are disoriented for 4 seconds. Damage will cancel the effect.
# Rank 2: Cooldown reduced by s1/-1000 sec.
  SpellInfo(dragons_breath cd=20 duration=4)
  # Disoriented.
  SpellAddTargetDebuff(dragons_breath dragons_breath=1)
Define(ebonbolt 257537)
# Launch a bolt of ice at the enemy, dealing (200 of Spell Power) Frost damage and granting you Brain Freeze.
  SpellInfo(ebonbolt cd=45 talent=ebonbolt_talent)
Define(evocation 12051)
# Increases your mana regeneration by s1 for 6 seconds.
# Rank 2: Evocation's cooldown is reduced by s1.
  SpellInfo(evocation cd=180 duration=6 channel=6 tick=1)
  # Mana regeneration increased by s1.
  SpellAddBuff(evocation evocation=1)
Define(expanded_potential_buff 327495)
# Your Fireball, Frostbolt and Arcane Blast have a chance to give you Expanded Potential, which causes your next Hot Streak, Brain Freeze or Clearcasting to not be consumed.
  SpellInfo(expanded_potential_buff duration=300 gcd=0 offgcd=1)
  # Your next Hot Streak, Brain Freeze or Clearcasting will not be consumed.
  SpellAddBuff(expanded_potential_buff expanded_potential_buff=1)
Define(fingers_of_frost 112965)
# Frostbolt has a s1 chance and Frozen Orb damage has a s2 to grant a charge of Fingers of Frost.rnrnFingers of Frost causes your next Ice Lance to deal damage as if the target were frozen.rnrnMaximum 44544s1 charges.
  SpellInfo(fingers_of_frost channel=0 gcd=0 offgcd=1)
  SpellAddBuff(fingers_of_frost fingers_of_frost=1)
  SpellAddTargetDebuff(fingers_of_frost fingers_of_frost=1)
Define(fire_blast 108853)
# Blasts the enemy for (79.2 of Spell Power) Fire damage. rnrn|cFFFFFFFFFire:|r Castable while casting other spells.?a231568[ Always deals a critical strike.][]
# Rank 2: Fire Blast always deals a critical strike.
  SpellInfo(fire_blast cd=0.5 charge_cd=12 gcd=0 offgcd=1)
Define(fireball 133)
# Throws a fiery ball that causes (65 of Spell Power) Fire damage.?a157642[rnrnEach time your Fireball fails to critically strike a target, it gains a stacking 157644s1 increased critical strike chance. Effect ends when Fireball critically strikes.][]
# Rank 3: Increases Fireball damage by s1.
  SpellInfo(fireball)
Define(fireblood_0 265221)
# Removes all poison, disease, curse, magic, and bleed effects and increases your ?a162700[Agility]?a162702[Strength]?a162697[Agility]?a162698[Strength]?a162699[Intellect]?a162701[Intellect][primary stat] by 265226s1*3 and an additional 265226s1 for each effect removed. Lasts 8 seconds. ?s195710[This effect shares a 30 sec cooldown with other similar effects.][]
  SpellInfo(fireblood_0 cd=120 gcd=0 offgcd=1)
Define(fireblood_1 265226)
# Increases ?a162700[Agility]?a162702[Strength]?a162697[Agility]?a162698[Strength]?a162699[Intellect]?a162701[Intellect][primary stat] by s1.
  SpellInfo(fireblood_1 duration=8 max_stacks=6 gcd=0 offgcd=1)
  # Increases ?a162700[Agility]?a162702[Strength]?a162697[Agility]?a162698[Strength]?a162699[Intellect]?a162701[Intellect][primary stat] by w1.
  SpellAddBuff(fireblood_1 fireblood_1=1)
Define(firestorm_buff 333100)
# When Hot Streak activates, you have a low chance to cause all Pyroblasts and Flamestrikes to have no cast time and be guaranteed critical strikes for 5 seconds.
  SpellInfo(firestorm_buff duration=5 channel=5 gcd=0 offgcd=1)
  # Pyroblast and Flamestrike have no cast time and are guaranteed to critically strike.
  SpellAddBuff(firestorm_buff firestorm_buff=1)
Define(flamestrike 2120)
# Calls down a pillar of fire, burning all enemies within the area for (66.13 of Spell Power) Fire damage and reducing their movement speed by s2 for 8 seconds.
# Rank 2: Flamestrike cast time is reduced by s1/-1000.1 sec.
  SpellInfo(flamestrike duration=8)
  # Movement speed slowed by s2.
  SpellAddTargetDebuff(flamestrike flamestrike=1)
Define(flurry 44614)
# Unleash a flurry of ice, striking the target s1 times for a total of (31.6 of Spell Power)*m1 Frost damage. Each hit reduces the target's movement speed by 228354s1 for 1 second.?a231584[rnrnWhile Brain Freeze is active, Flurry applies Winter's Chill, causing your target to take damage from your spells as if it were frozen.][]
  SpellInfo(flurry)

Define(focused_azerite_beam_0 295258)
# Focus excess Azerite energy into the Heart of Azeroth, then expel that energy outward, dealing m1*10 Fire damage to all enemies in front of you over 3 seconds.?a295263[ Castable while moving.][]
  SpellInfo(focused_azerite_beam_0 cd=90 duration=3 channel=3 tick=0.33)
  SpellAddBuff(focused_azerite_beam_0 focused_azerite_beam_0=1)
  SpellAddBuff(focused_azerite_beam_0 focused_azerite_beam_1=1)
Define(focused_azerite_beam_1 295261)
# Focus excess Azerite energy into the Heart of Azeroth, then expel that energy outward, dealing m1*10 Fire damage to all enemies in front of you over 3 seconds.?a295263[ Castable while moving.][]
  SpellInfo(focused_azerite_beam_1 cd=90)
Define(focused_azerite_beam_2 299336)
# Focus excess Azerite energy into the Heart of Azeroth, then expel that energy outward, dealing m1*10 Fire damage to all enemies in front of you over 3 seconds.
  SpellInfo(focused_azerite_beam_2 cd=90 duration=3 channel=3 tick=0.33)
  SpellAddBuff(focused_azerite_beam_2 focused_azerite_beam_0=1)
  SpellAddBuff(focused_azerite_beam_2 focused_azerite_beam_1=1)
Define(focused_azerite_beam_3 299338)
# Focus excess Azerite energy into the Heart of Azeroth, then expel that energy outward, dealing m1*10 Fire damage to all enemies in front of you over 3 seconds. Castable while moving.
  SpellInfo(focused_azerite_beam_3 cd=90 duration=3 channel=3 tick=0.33)
  SpellAddBuff(focused_azerite_beam_3 focused_azerite_beam_0=1)
  SpellAddBuff(focused_azerite_beam_3 focused_azerite_beam_1=1)
Define(freezing_rain_buff 270232)
# Frozen Orb makes Blizzard instant cast and increases its damage done by 270232s2 for 12 seconds.
  SpellInfo(freezing_rain_buff duration=12 gcd=0 offgcd=1)
  # Blizzard is instant cast and deals s2 increased damage.
  SpellAddBuff(freezing_rain_buff freezing_rain_buff=1)
Define(freezing_winds 327478)
# While Frozen Orb is active, you gain Fingers of Frost every 327478t1 sec.
  SpellInfo(freezing_winds duration=30 gcd=0 offgcd=1 tick=2)
  # Gaining Fingers of Frost every t1 sec.
  SpellAddBuff(freezing_winds freezing_winds=1)
Define(frost_nova 122)
# Blasts enemies within A2 yds of you for (4.4775 of Spell Power) Frost damage and freezes them in place for 8 seconds. Damage may interrupt the freeze effect.
# Rank 2: Frost Nova duration is increased by s1/1000 sec.
  SpellInfo(frost_nova cd=30 duration=8)
  # Frozen in place?a333393[ and damage taken from @auracaster's Arcane and Fire spells increased by 333393s2][].
  SpellAddTargetDebuff(frost_nova frost_nova=1)
Define(frostbolt 116)
# Launches a bolt of frost at the enemy, causing (51.1 of Spell Power) Frost damage and slowing movement speed by 205708s1 for 8 seconds.
# Rank 2: Increases Frostbolt damage by s1.
  SpellInfo(frostbolt)

Define(frozen 174955)
# Deals m2 Frost damage, and Stuns targets for 30 seconds (8 sec PvP).
  SpellInfo(frozen duration=30 channel=30 gcd=0 offgcd=1)
  # Frozen.
  SpellAddTargetDebuff(frozen frozen=1)
Define(frozen_orb 84714)
# Launches an orb of swirling ice up to s1 yards forward which deals up to 20*(16.27 of Spell Power) Frost damage to 84721s2 enemies it passes through. Grants 1 charge of Fingers of Frost when it first damages an enemy.rnrnEnemies damaged by the Frozen Orb are slowed by 289308s1 for 3 seconds.
  SpellInfo(frozen_orb cd=60 duration=15 channel=15)
Define(glacial_spike 199786)
# Conjures a massive spike of ice, and merges your current Icicles into it. It impales your target, dealing (297 of Spell Power) damage plus all of the damage stored in your Icicles, and freezes the target in place for 4 seconds. Damage may interrupt the freeze effect.rnrnRequires 5 Icicles to cast.rnrn|cFFFFFFFFPassive:|r Ice Lance no longer launches Icicles.
  SpellInfo(glacial_spike talent=glacial_spike_talent)
  # Frozen in place.
  SpellAddBuff(glacial_spike glacial_spike=1)
Define(gladiators_badge_0 277185)
# Increases primary stat by s1 for 15 seconds.rn
  SpellInfo(gladiators_badge_0 cd=120 duration=15 channel=15 gcd=0 offgcd=1)
  # Primary stat increased by s4.
  SpellAddBuff(gladiators_badge_0 gladiators_badge_0=1)
Define(gladiators_badge_1 345228)
# Increases primary stat by s1 for 15 seconds.rn
  SpellInfo(gladiators_badge_1 cd=120 duration=15 channel=15 gcd=0 offgcd=1)
  # Primary stat increased by s1.
  SpellAddBuff(gladiators_badge_1 gladiators_badge_1=1)
Define(guardian_of_azeroth_0 295840)
# Call upon Azeroth to summon a Guardian of Azeroth for 30 seconds who impales your target with spikes of Azerite every s1/10.1 sec that deal 295834m1*(1+@versadmg) Fire damage.?a295841[ Every 303347t1 sec, the Guardian launches a volley of Azerite Spikes at its target, dealing 295841s1 Fire damage to all nearby enemies.][]?a295843[rnrnEach time the Guardian of Azeroth casts a spell, you gain 295855s1 Haste, stacking up to 295855u times. This effect ends when the Guardian of Azeroth despawns.][]rn
  SpellInfo(guardian_of_azeroth_0 cd=180 duration=30)
  SpellAddBuff(guardian_of_azeroth_0 guardian_of_azeroth_0=1)
Define(guardian_of_azeroth_1 295855)
# Each time the Guardian of Azeroth casts a spell, you gain 295855s1 Haste, stacking up to 295855u times. This effect ends when the Guardian of Azeroth despawns.
  SpellInfo(guardian_of_azeroth_1 duration=60 max_stacks=5 gcd=0 offgcd=1)
  # Haste increased by s1.
  SpellAddBuff(guardian_of_azeroth_1 guardian_of_azeroth_1=1)
Define(guardian_of_azeroth_2 299355)
# Call upon Azeroth to summon a Guardian of Azeroth for 30 seconds who impales your target with spikes of Azerite every 295840s1/10.1 sec that deal 295834m1*(1+@versadmg)*(1+(295836m1/100)) Fire damage. Every 303347t1 sec, the Guardian launches a volley of Azerite Spikes at its target, dealing 295841s1 Fire damage to all nearby enemies.
  SpellInfo(guardian_of_azeroth_2 cd=180 duration=30 gcd=1)
  SpellAddBuff(guardian_of_azeroth_2 guardian_of_azeroth_2=1)
Define(guardian_of_azeroth_3 299358)
# Call upon Azeroth to summon a Guardian of Azeroth for 30 seconds who impales your target with spikes of Azerite every 295840s1/10.1 sec that deal 295834m1*(1+@versadmg)*(1+(295836m1/100)) Fire damage. Every 303347t1 sec, the Guardian launches a volley of Azerite Spikes at its target, dealing 295841s1 Fire damage to all nearby enemies.rnrnEach time the Guardian of Azeroth casts a spell, you gain 295855s1 Haste, stacking up to 295855u times. This effect ends when the Guardian of Azeroth despawns.
  SpellInfo(guardian_of_azeroth_3 cd=180 duration=20 gcd=1)
  SpellAddBuff(guardian_of_azeroth_3 guardian_of_azeroth_3=1)
Define(guardian_of_azeroth_4 300091)
# Call upon Azeroth to summon a Guardian of Azeroth to aid you in combat for 30 seconds.
  SpellInfo(guardian_of_azeroth_4 cd=300 duration=30 gcd=1)
Define(guardian_of_azeroth_5 303347)
  SpellInfo(guardian_of_azeroth_5 gcd=0 offgcd=1 tick=8)

Define(heating_up 48107)
# Scored a spell critical. A second spell critical in a row will make your next Pyroblast or Flamestrike spell instant cast, and cause double the normal Ignite damage.
  SpellInfo(heating_up duration=10 channel=10 max_stacks=2 gcd=0 offgcd=1)
  # Scored a spell critical. A second spell critical in a row will make your next Pyroblast or Flamestrike spell instant cast, and cause double the normal Ignite damage.
  SpellAddBuff(heating_up heating_up=1)
Define(hot_streak 195283)
# Getting two direct-damage critical strikes in a row with Fire spells will make your next Pyroblast or Flamestrike spell instant cast, and cause double the normal Ignite damage.
  SpellInfo(hot_streak channel=0 max_stacks=1 gcd=0 offgcd=1)
  # Your next Pyroblast or Flamestrike spell is instant cast, and causes double the normal Ignite damage.
  SpellAddBuff(hot_streak hot_streak=1)
Define(ice_floes 108839)
# Makes your next Mage spell with a cast time shorter than s2 sec castable while moving. Unaffected by the global cooldown and castable while casting.
  SpellInfo(ice_floes cd=20 duration=15 max_stacks=3 gcd=0 offgcd=1 talent=ice_floes_talent)
  # Able to move while casting spells.
  SpellAddBuff(ice_floes ice_floes=1)
Define(ice_lance 30455)
# Quickly fling a shard of ice at the target, dealing (42 of Spell Power) Frost damage?s56377[, and (42 of Spell Power)*56377m2/100 Frost damage to a second nearby target][].rnrnIce Lance damage is tripled against frozen targets.
# Rank 2: Increases Ice Lance damage by s1.
  SpellInfo(ice_lance)
Define(ice_nova 157997)
# Causes a whirl of icy wind around the enemy, dealing (180 of Spell Power) Frost damage to the target and reduced damage to all other enemies within a2 yards, and freezing them in place for 2 seconds.
  SpellInfo(ice_nova cd=25 duration=2 talent=ice_nova_talent)
  # Frozen.
  SpellAddTargetDebuff(ice_nova ice_nova=1)
Define(icy_veins 12472)
# Accelerates your spellcasting for 20 seconds, granting m1 haste and preventing damage from delaying your spellcasts.
# Rank 2: Duration increased by s1/1000 sec.
  SpellInfo(icy_veins cd=180 duration=20 gcd=0 offgcd=1)
  # Haste increased by w1 and immune to pushback.
  SpellAddBuff(icy_veins icy_veins=1)
Define(ignite 12654)
# Your target burns for an additional (75 of Spell Power).1 over 9 seconds of the total direct damage caused by your Fireball, Fire Blast, Scorch, Pyroblast?s153561[, Meteor][]?s257541[, Phoenix Flames][]?s198929[, Cinderstorm][], and Flamestrike. If this effect is reapplied, any remaining damage will be added to the new Ignite.rnrnPhoenix Flames causes your Ignites to spread to s4 nearby enemies.
  SpellInfo(ignite duration=9 channel=9 gcd=0 offgcd=1 tick=1)
  # Deals w1 Fire damage every t1 sec.?w3>0[rnMovement speed reduced by w3.][]
  SpellAddTargetDebuff(ignite ignite=1)
Define(infernal_cascade 336832)
# While Combustion is active, your Fire Blast grants you |cFFFFFFFFs1.1 |r increased Fire damage for 5 seconds, stacking up to 336832u times.
  SpellInfo(infernal_cascade duration=5 max_stacks=2 gcd=0 offgcd=1)
  # Fire Damage increased by w1.
  SpellAddBuff(infernal_cascade infernal_cascade=1)
Define(lights_judgment 255647)
# Call down a strike of Holy energy, dealing <damage> Holy damage to enemies within A1 yards after 3 sec.
  SpellInfo(lights_judgment cd=150)

Define(living_bomb 44457)
# The target becomes a Living Bomb, taking 217694o1 Fire damage over 4 seconds, and then exploding to deal an additional (14.000000000000002 of Spell Power) Fire damage to the target and reduced damage to all other enemies within 44461A2 yards.rnrnOther enemies hit by this explosion also become a Living Bomb, but this effect cannot spread further.
  SpellInfo(living_bomb cd=12 talent=living_bomb_talent)
  # Causes w1 Fire damage every t1 sec. After d, the target explodes, causing w2 Fire damage to the target and all other enemies within 44461A2 yards?w3>0[, and spreading Living Bomb][].
  SpellAddBuff(living_bomb living_bomb=1)
Define(memory_of_lucid_dreams_0 299300)
# Infuse your Heart of Azeroth with Memory of Lucid Dreams.
  SpellInfo(memory_of_lucid_dreams_0)
Define(memory_of_lucid_dreams_1 299302)
# Infuse your Heart of Azeroth with Memory of Lucid Dreams.
  SpellInfo(memory_of_lucid_dreams_1)
Define(memory_of_lucid_dreams_2 299304)
# Infuse your Heart of Azeroth with Memory of Lucid Dreams.
  SpellInfo(memory_of_lucid_dreams_2)
Define(meteor 153561)
# Calls down a meteor which lands at the target location after 3 seconds, dealing (260 of Spell Power) Fire damage, split evenly between all targets within 8 yards, and burns the ground, dealing 8*(8.25 of Spell Power) Fire damage over 8.5 seconds to all enemies in the area. 
  SpellInfo(meteor cd=45 talent=meteor_talent)
Define(mirror_image 55342)
# Creates s2 copies of you nearby for 40 seconds, which cast spells and attack your enemies.rnrnWhile your images are active damage taken is reduced by s3, taking direct damage will cause one of your images to dissipate.
  SpellInfo(mirror_image cd=120 duration=40)
  # Damage taken is reduced by s3 while your images are active.
  SpellAddBuff(mirror_image mirror_image=1)
Define(mirrors_of_torment 314793)
# Conjure n mirrors to torment the enemy for 25 seconds. Whenever the target attacks, casts a spell, or uses an ability, a mirror is consumed to inflict (60 of Spell Power) Shadow damage and their movement and cast speed are slowed by 320035s3. This effect cannot be triggered more often than once per 6 seconds.rnrnThe final mirror will instead inflict (151 of Spell Power) Shadow damage to the enemy, Rooting and Silencing them for 4 seconds.rnrnWhenever a mirror is consumed ?c1[you gain 345417s1 mana][]?c2[your Fire Blast cooldown is reduced by s2 sec][]?c3[you gain Brain Freeze][].
  SpellInfo(mirrors_of_torment cd=90 duration=25)
  # Attacking, casting a spell or ability, consumes a mirror to inflict Shadow damage and reduce cast and movement speed by 320035s3. rnrnYour final mirror will instead Root and Silence you for 317589d.
  SpellAddTargetDebuff(mirrors_of_torment mirrors_of_torment=1)
Define(nether_tempest 114923)
# Places a Nether Tempest on the target which deals 114923o1 Arcane damage over 12 seconds to the target and nearby enemies within 10 yards. Limit 1 target. Deals reduced damage to secondary targets.rnrnDamage increased by 36032s1 per Arcane Charge.
  SpellInfo(nether_tempest duration=12 tick=1 talent=nether_tempest_talent)
  # Deals w1 Arcane damage and an additional w1 Arcane damage to all enemies within 114954A1 yards every t sec.
  SpellAddTargetDebuff(nether_tempest nether_tempest=1)
Define(phoenix_flames 257541)
# Hurls a Phoenix that deals (90 of Spell Power) Fire damage to the target and reduced damage to other nearby enemies.
# Rank 2: Phoenix Flames gains s1 additional charge.
  SpellInfo(phoenix_flames cd=25)

Define(presence_of_mind 205025)
# Causes your next n Arcane Blasts to be instant cast.
# Rank 2: Arcane Blast can be cast instantly s1 additional time.
  SpellInfo(presence_of_mind cd=60 gcd=0 offgcd=1)
  # Arcane Blast is instant cast.
  SpellAddBuff(presence_of_mind presence_of_mind=1)
Define(purifying_blast_0 295337)
# Call down a purifying beam upon the target area, dealing 295293s3*(1+@versadmg)*s2 Fire damage over 6 seconds.?a295364[ Has a low chance to immediately annihilate any specimen deemed unworthy by MOTHER.][]?a295352[rnrnWhen an enemy dies within the beam, your damage is increased by 295354s1 for 8 seconds.][]rnrnAny Aberration struck by the beam is stunned for 3 seconds.
  SpellInfo(purifying_blast_0 cd=60 duration=6)
Define(purifying_blast_1 295338)
# Call down a purifying beam upon the target area, dealing 295293s3*(1+@versadmg)*s2 Fire damage over 6 seconds.?a295364[ Has a low chance to immediately annihilate any specimen deemed unworthy by MOTHER.][]?a295352[rnrnWhen an enemy dies within the beam, your damage is increased by 295354s1 for 8 seconds.][]rnrnAny Aberration struck by the beam is stunned for 3 seconds.
  SpellInfo(purifying_blast_1 channel=0 gcd=0 offgcd=1)
Define(purifying_blast_2 295354)
# When an enemy dies within the beam, your damage is increased by 295354s1 for 8 seconds.
  SpellInfo(purifying_blast_2 duration=8 gcd=0 offgcd=1)
  # Damage dealt increased by s1.
  SpellAddBuff(purifying_blast_2 purifying_blast_2=1)
Define(purifying_blast_3 295366)
# Call down a purifying beam upon the target area, dealing 295293s3*(1+@versadmg)*s2 Fire damage over 6 seconds.?a295364[ Has a low chance to immediately annihilate any specimen deemed unworthy by MOTHER.][]?a295352[rnrnWhen an enemy dies within the beam, your damage is increased by 295354s1 for 8 seconds.][]rnrnAny Aberration struck by the beam is stunned for 3 seconds.
  SpellInfo(purifying_blast_3 duration=3 gcd=0 offgcd=1)
  # Stunned.
  SpellAddTargetDebuff(purifying_blast_3 purifying_blast_3=1)
Define(purifying_blast_4 299345)
# Call down a purifying beam upon the target area, dealing 295293s3*(1+@versadmg)*s2 Fire damage over 6 seconds. Has a low chance to immediately annihilate any specimen deemed unworthy by MOTHER.?a295352[rnrnWhen an enemy dies within the beam, your damage is increased by 295354s1 for 8 seconds.][]rnrnAny Aberration struck by the beam is stunned for 3 seconds.
  SpellInfo(purifying_blast_4 cd=60 duration=6 channel=6 gcd=1)
Define(purifying_blast_5 299347)
# Call down a purifying beam upon the target area, dealing 295293s3*(1+@versadmg)*s2 Fire damage over 6 seconds. Has a low chance to immediately annihilate any specimen deemed unworthy by MOTHER.rnrnWhen an enemy dies within the beam, your damage is increased by 295354s1 for 8 seconds.rnrnAny Aberration struck by the beam is stunned for 3 seconds.
  SpellInfo(purifying_blast_5 cd=60 duration=6 gcd=1)
Define(pyroblast 11366)
# Hurls an immense fiery boulder that causes (136.3 of Spell Power) Fire damage?a321711[ and an additional 321712o2 Fire damage over 6 seconds][].
# Rank 2: Deals an additional 321712o2 Fire damage over 6 seconds.
  SpellInfo(pyroblast)
Define(pyroclasm 269650)
# Consuming Hot Streak has a s1 chance to make your next non-instant Pyroblast cast within 15 seconds deal 269651s1 additional damage.rnrnMaximum 269651u stacks.
  SpellInfo(pyroclasm channel=0 gcd=0 offgcd=1 talent=pyroclasm_talent)
  SpellAddBuff(pyroclasm pyroclasm=1)
Define(quaking_palm 107079)
# Strikes the target with lightning speed, incapacitating them for 4 seconds, and turns off your attack.
  SpellInfo(quaking_palm cd=120 duration=4 gcd=1)
  # Incapacitated.
  SpellAddTargetDebuff(quaking_palm quaking_palm=1)
Define(radiant_spark 307443)
# Conjure a radiant spark that causes (76 of Spell Power) Arcane damage instantly, and an additional o2 damage over 10 seconds.rnrnThe target takes 307454s1 increased damage from your direct damage spells, stacking each time they are struck. This effect ends after 307454u spells.rn
  SpellInfo(radiant_spark cd=30 duration=10 interrupt=1 tick=2)
  # Damage taken from @auracaster  increased by w1.
  SpellAddBuff(radiant_spark radiant_spark_vulnerability=1)
  # Suffering w2 Arcane damage every t2 sec.
  SpellAddTargetDebuff(radiant_spark radiant_spark=1)
Define(radiant_spark_vulnerability 307454)
# Conjure a radiant spark that causes (76 of Spell Power) Arcane damage instantly, and an additional o2 damage over 10 seconds.rnrnThe target takes 307454s1 increased damage from your direct damage spells, stacking each time they are struck. This effect ends after 307454u spells.rn
  SpellInfo(radiant_spark_vulnerability duration=8 max_stacks=4 gcd=0 offgcd=1)
  # Damage taken from @auracaster  increased by w1.
  SpellAddTargetDebuff(radiant_spark_vulnerability radiant_spark_vulnerability=1)
Define(ray_of_frost 205021)
# Channel an icy beam at the enemy for 5 seconds, dealing (120 of Spell Power) Frost damage every t2 sec and slowing movement by s4. Each time Ray of Frost deals damage, its damage and snare increases by 208141s1.rnrnGenerates s3 charges of Fingers of Frost over its duration.
  SpellInfo(ray_of_frost cd=75 duration=5 channel=5 tick=1 talent=ray_of_frost_talent)
  # Movement slowed by w1.rnTaking w2 Frost damage every t2 sec.
  SpellAddTargetDebuff(ray_of_frost ray_of_frost=1)
Define(reaping_flames_0 310690)
# Burn your target with a bolt of Azerite, dealing 310712s3 Fire damage. If the target has less than s2 health?a310705[ or more than 310705s1 health][], the cooldown is reduced by s3 sec.?a310710[rnrnIf Reaping Flames kills an enemy, its cooldown is lowered to 310710s2 sec and it will deal 310710s1 increased damage on its next use.][]
  SpellInfo(reaping_flames_0 cd=45 channel=0)
Define(reaping_flames_1 311194)
# Burn your target with a bolt of Azerite, dealing 310712s3 Fire damage. If the target has less than s2 health or more than 310705s1 health, the cooldown is reduced by m3 sec.
  SpellInfo(reaping_flames_1 cd=45 channel=0)
Define(reaping_flames_2 311195)
# Burn your target with a bolt of Azerite, dealing 310712s3 Fire damage. If the target has less than s2 health or more than 310705s1 health, the cooldown is reduced by m3 sec.rnrnIf Reaping Flames kills an enemy, its cooldown is lowered to 310710s2 sec and it will deal 310710s1 increased damage on its next use. 
  SpellInfo(reaping_flames_2 cd=45 channel=0)
Define(reaping_flames_3 311202)
# Burn your target with a bolt of Azerite, dealing 310712s3 Fire damage. If the target has less than s2 health?a310705[ or more than 310705s1 health][], the cooldown is reduced by s3 sec.?a310710[rnrnIf Reaping Flames kills an enemy, its cooldown is lowered to 310710s2 sec and it will deal 310710s1 increased damage on its next use.][]
  SpellInfo(reaping_flames_3 duration=30 gcd=0 offgcd=1)
  # Damage of next Reaping Flames increased by w1.
  SpellAddBuff(reaping_flames_3 reaping_flames_3=1)
Define(reaping_flames_4 311947)
  SpellInfo(reaping_flames_4 duration=2 gcd=0 offgcd=1)
  SpellAddTargetDebuff(reaping_flames_4 reaping_flames_4=1)
Define(reckless_force_buff_0 298409)
# When an ability fails to critically strike, you have a high chance to gain Reckless Force. When Reckless Force reaches 302917u stacks, your critical strike is increased by 302932s1 for 4 seconds.
  SpellInfo(reckless_force_buff_0 max_stacks=5 gcd=0 offgcd=1 tick=10)
  # Gaining unstable Azerite energy.
  SpellAddBuff(reckless_force_buff_0 reckless_force_buff_0=1)
Define(reckless_force_buff_1 304038)
# When an ability fails to critically strike, you have a high chance to gain Reckless Force. When Reckless Force reaches 302917u stacks, your critical strike is increased by 302932s1 for 4 seconds.
  SpellInfo(reckless_force_buff_1 channel=-0.001 gcd=0 offgcd=1)
  SpellAddBuff(reckless_force_buff_1 reckless_force_buff_1=1)
Define(ripple_in_space_0 299306)
# Infuse your Heart of Azeroth with Ripple in Space.
  SpellInfo(ripple_in_space_0)
Define(ripple_in_space_1 299307)
# Infuse your Heart of Azeroth with Ripple in Space.
  SpellInfo(ripple_in_space_1)
Define(ripple_in_space_2 299309)
# Infuse your Heart of Azeroth with Ripple in Space.
  SpellInfo(ripple_in_space_2)
Define(ripple_in_space_3 299310)
# Infuse your Heart of Azeroth with Ripple in Space.
  SpellInfo(ripple_in_space_3)
Define(rule_of_threes 264354)
# When you gain your third Arcane Charge, the cost of your next Arcane Blast or Arcane Missiles is reduced by 264774s1.
  SpellInfo(rule_of_threes channel=0 gcd=0 offgcd=1 talent=rule_of_threes_talent)
  SpellAddBuff(rule_of_threes rule_of_threes=1)
Define(rune_of_power 116011)
# Places a Rune of Power on the ground for 15 seconds which increases your spell damage by 116014s1 while you stand within 8 yds.rnrnCasting ?a137021[Arcane Power]?a137019[Combustion][Icy Veins] will also create a Rune of Power at your location.
  SpellInfo(rune_of_power cd=10 charge_cd=45 duration=15 talent=rune_of_power_talent)
Define(scorch 2948)
# Scorches an enemy for (17.7 of Spell Power) Fire damage. Castable while moving.
  SpellInfo(scorch)
Define(shifting_power 314791)
# Draw power from the ground beneath, dealing (47.36 of Spell Power)*4 seconds/t Nature damage over 4 seconds to enemies within 325130A1 yds. rnrnWhile channeling, your Mage ability cooldowns are reduced by -s2/1000*4 seconds/t sec over 4 seconds.
  SpellInfo(shifting_power cd=45 duration=4 channel=4 tick=1)
  # Every t1 sec, deal 325130s1 Nature damage to enemies within 325130A1 yds and reduce the remaining cooldown of your abilities by -s2/1000 sec.
  SpellAddBuff(shifting_power shifting_power=1)
Define(summon_water_elemental 31687)
# Summons a Water Elemental to follow and fight for you.
  SpellInfo(summon_water_elemental cd=30)
Define(supernova 157980)
# Pulses arcane energy around the target enemy or ally, dealing (30 of Spell Power) Arcane damage to all enemies within A2 yards, and knocking them upward. A primary enemy target will take s1 increased damage.
  SpellInfo(supernova cd=25 talent=supernova_talent)
Define(the_unbound_force_0 299321)
# Infuse your Heart of Azeroth with The Unbound Force.
  SpellInfo(the_unbound_force_0)
Define(the_unbound_force_1 299322)
# Infuse your Heart of Azeroth with The Unbound Force.
  SpellInfo(the_unbound_force_1)
Define(the_unbound_force_2 299323)
# Infuse your Heart of Azeroth with The Unbound Force.
  SpellInfo(the_unbound_force_2)
Define(the_unbound_force_3 299324)
# Infuse your Heart of Azeroth with The Unbound Force.
  SpellInfo(the_unbound_force_3)
Define(time_warp 80353)
# Warp the flow of time, increasing haste by (25 of Spell Power) ?a320919[and time rate by s4 ][]for all party and raid members for 40 seconds.rnrnAllies will be unable to benefit from Bloodlust, Heroism, or Time Warp again for 600 seconds.?a320920[rnrnWhen the effect ends, you die.][]
  SpellInfo(time_warp cd=300 duration=40 channel=40 gcd=0 offgcd=1)
  # Haste increased by w1. ?W4>0[Time rate increased by w4.][]?W3=1[rnrnWhen the effect ends, you die.][]
  SpellAddBuff(time_warp time_warp=1)
Define(touch_of_the_magi 321507)
# Applies Touch of the Magi to your current target, accumulating s1 of the damage you deal to the target for 8 seconds, and then exploding for that amount of Arcane damage to the target and reduced damage to all nearby enemies.?a343215[rnrn|cFFFFFFFFGenerates s2 Arcane Charges.|r][]
# Rank 2: Touch of the Magi generates 321507s2 Arcane Charges.
  SpellInfo(touch_of_the_magi cd=45 max_stacks=1 arcanecharges=-4)

Define(winters_chill 228358)
# Unleash a flurry of ice, striking the target s1 times for a total of (31.6 of Spell Power)*m1 Frost damage. Each hit reduces the target's movement speed by 228354s1 for 1 second.?a231584[rnrnWhile Brain Freeze is active, Flurry applies Winter's Chill, causing your target to take damage from your spells as if it were frozen.][]
  SpellInfo(winters_chill duration=6 max_stacks=2 gcd=0 offgcd=1)
  # Taking damage from the Mage's spells as if frozen.
  SpellAddTargetDebuff(winters_chill winters_chill=1)
Define(worldvein_resonance_0 298606)
# Infuse your Heart of Azeroth with Worldvein Resonance.
  SpellInfo(worldvein_resonance_0)
Define(worldvein_resonance_1 298607)
# Infuse your Heart of Azeroth with Worldvein Resonance.
  SpellInfo(worldvein_resonance_1)
Define(worldvein_resonance_2 298609)
# Infuse your Heart of Azeroth with Worldvein Resonance.
  SpellInfo(worldvein_resonance_2)
Define(worldvein_resonance_3 298611)
# Infuse your Heart of Azeroth with Worldvein Resonance.
  SpellInfo(worldvein_resonance_3)
SpellList(arcane_charge_buff arcane_charge_buff_0 arcane_charge_buff_1)
SpellList(blood_fury blood_fury_0 blood_fury_1 blood_fury_2 blood_fury_3)
SpellList(blood_of_the_enemy blood_of_the_enemy_0 blood_of_the_enemy_1 blood_of_the_enemy_2 blood_of_the_enemy_3)
SpellList(clearcasting clearcasting_0 clearcasting_1 clearcasting_2)
SpellList(concentrated_flame concentrated_flame_0 concentrated_flame_1 concentrated_flame_2 concentrated_flame_3 concentrated_flame_4 concentrated_flame_5 concentrated_flame_6)
SpellList(fireblood fireblood_0 fireblood_1)
SpellList(focused_azerite_beam focused_azerite_beam_0 focused_azerite_beam_1 focused_azerite_beam_2 focused_azerite_beam_3)
SpellList(guardian_of_azeroth guardian_of_azeroth_0 guardian_of_azeroth_1 guardian_of_azeroth_2 guardian_of_azeroth_3 guardian_of_azeroth_4 guardian_of_azeroth_5)
SpellList(memory_of_lucid_dreams memory_of_lucid_dreams_0 memory_of_lucid_dreams_1 memory_of_lucid_dreams_2)
SpellList(purifying_blast purifying_blast_0 purifying_blast_1 purifying_blast_2 purifying_blast_3 purifying_blast_4 purifying_blast_5)
SpellList(reaping_flames reaping_flames_0 reaping_flames_1 reaping_flames_2 reaping_flames_3 reaping_flames_4)
SpellList(ripple_in_space ripple_in_space_0 ripple_in_space_1 ripple_in_space_2 ripple_in_space_3)
SpellList(the_unbound_force the_unbound_force_0 the_unbound_force_1 the_unbound_force_2 the_unbound_force_3)
SpellList(worldvein_resonance worldvein_resonance_0 worldvein_resonance_1 worldvein_resonance_2 worldvein_resonance_3)
SpellList(gladiators_badge gladiators_badge_0 gladiators_badge_1)
SpellList(brain_freeze brain_freeze_0 brain_freeze_1)
SpellList(reckless_force_buff reckless_force_buff_0 reckless_force_buff_1)
Define(alexstraszas_fury_talent 11) #22465
# Dragon's Breath always critically strikes for s2 increased critical strike damage and contributes to Hot Streak. rnrnAdditionally, damage done by your next Pyroblast or Flamestrike is increased by 334277s1.
Define(amplification_talent 1) #22458
# When Clearcast, Arcane Missiles fires s2 additional lmissile:missiles;.
Define(arcane_echo_talent 11) #22467
# Direct damage you deal to enemies affected by Touch of the Magi, causes an explosion that deals (10.92 of Spell Power) Arcane damage to s1 nearby enemies.
Define(arcane_familiar_talent 3) #22464
# Summon a Familiar that attacks your enemies and increases your maximum mana by 210126s1 for 3600 seconds.
Define(arcane_orb_talent 17) #22449
# Launches an Arcane Orb forward from your position, traveling up to 40 yards, dealing (109.2 of Spell Power) Arcane damage to enemies it passes through.rnrn|cFFFFFFFFGrants 1 Arcane Charge when cast and every time it deals damage.|r
Define(comet_storm_talent 18) #22473
# Calls down a series of 7 icy comets on and around the target, that deals up to 7*(40 of Spell Power) Frost damage to all enemies within 228601A1 yds of its impacts.
Define(ebonbolt_talent 12) #22469
# Launch a bolt of ice at the enemy, dealing (200 of Spell Power) Frost damage and granting you Brain Freeze.
Define(enlightened_talent 21) #21145
# Arcane damage dealt while above s1 mana is increased by 321388s1, Mana Regen while below s1 is increased by 321390s1.
Define(firestarter_talent 1) #22456
# Your Fireball and Pyroblast spells always deal a critical strike when the target is above s1 health.
Define(flame_on_talent 10) #22450
# Reduces the cooldown of Fire Blast by s3 seconds and increases the maximum number of charges by s1.
Define(flame_patch_talent 16) #22451
# Flamestrike leaves behind a patch of flames which burns enemies within it for 8*(6 of Spell Power) Fire damage over 8 seconds. 
Define(from_the_ashes_talent 12) #22468
# Increases Mastery by s3 for each charge of Phoenix Flames off cooldown and your direct-damage critical strikes reduce its cooldown by s2/-1000 sec.
Define(glacial_spike_talent 21) #21634
# Conjures a massive spike of ice, and merges your current Icicles into it. It impales your target, dealing (297 of Spell Power) damage plus all of the damage stored in your Icicles, and freezes the target in place for 4 seconds. Damage may interrupt the freeze effect.rnrnRequires 5 Icicles to cast.rnrn|cFFFFFFFFPassive:|r Ice Lance no longer launches Icicles.
Define(ice_floes_talent 6) #23073
# Makes your next Mage spell with a cast time shorter than s2 sec castable while moving. Unaffected by the global cooldown and castable while casting.
Define(ice_nova_talent 3) #22463
# Causes a whirl of icy wind around the enemy, dealing (180 of Spell Power) Frost damage to the target and reduced damage to all other enemies within a2 yards, and freezing them in place for 2 seconds.
Define(kindling_talent 19) #21631
# Your Fireball, Pyroblast, Fire Blast, and Phoenix Flames critical strikes reduce the remaining cooldown on Combustion by <cdr> sec.
Define(living_bomb_talent 18) #22472
# The target becomes a Living Bomb, taking 217694o1 Fire damage over 4 seconds, and then exploding to deal an additional (14.000000000000002 of Spell Power) Fire damage to the target and reduced damage to all other enemies within 44461A2 yards.rnrnOther enemies hit by this explosion also become a Living Bomb, but this effect cannot spread further.
Define(meteor_talent 21) #21633
# Calls down a meteor which lands at the target location after 3 seconds, dealing (260 of Spell Power) Fire damage, split evenly between all targets within 8 yards, and burns the ground, dealing 8*(8.25 of Spell Power) Fire damage over 8.5 seconds to all enemies in the area. 
Define(nether_tempest_talent 12) #22470
# Places a Nether Tempest on the target which deals 114923o1 Arcane damage over 12 seconds to the target and nearby enemies within 10 yards. Limit 1 target. Deals reduced damage to secondary targets.rnrnDamage increased by 36032s1 per Arcane Charge.
Define(pyroclasm_talent 20) #22220
# Consuming Hot Streak has a s1 chance to make your next non-instant Pyroblast cast within 15 seconds deal 269651s1 additional damage.rnrnMaximum 269651u stacks.
Define(ray_of_frost_talent 20) #22309
# Channel an icy beam at the enemy for 5 seconds, dealing (120 of Spell Power) Frost damage every t2 sec and slowing movement by s4. Each time Ray of Frost deals damage, its damage and snare increases by 208141s1.rnrnGenerates s3 charges of Fingers of Frost over its duration.
Define(resonance_talent 10) #22453
# Arcane Barrage deals s1 increased damage per target it hits.
Define(rule_of_threes_talent 2) #22461
# When you gain your third Arcane Charge, the cost of your next Arcane Blast or Arcane Missiles is reduced by 264774s1.
Define(rune_of_power_talent 9) #22447
# Places a Rune of Power on the ground for 15 seconds which increases your spell damage by 116014s1 while you stand within 8 yds.rnrnCasting ?a137021[Arcane Power]?a137019[Combustion][Icy Veins] will also create a Rune of Power at your location.
Define(searing_touch_talent 3) #22462
# Scorch deals s2 increased damage and is a guaranteed Critical Strike when the target is below s1 health.
Define(supernova_talent 18) #22474
# Pulses arcane energy around the target enemy or ally, dealing (30 of Spell Power) Arcane damage to all enemies within A2 yards, and knocking them upward. A primary enemy target will take s1 increased damage.
Define(focused_resolve_item 168506)
Define(ancient_knot_of_wisdom_item 166793)
Define(azsharas_font_of_power_item 169314)
Define(azurethos_singed_plumage_item 161377)
Define(balefire_branch_item 159630)
Define(gladiators_medallion_item 184268)
Define(hyperthread_wristwraps_item 168989)
Define(ignition_mages_fuse_item 159615)
Define(manifesto_of_madness_item 174103)
Define(neural_synapse_enhancer_item 168973)
Define(shockbiters_fang_item 169318)
Define(superior_battle_potion_of_intellect_item 168498)
Define(tzanes_barkspines_item 161411)
Define(blaster_master_trait 274596)
Define(vision_of_perfection_essence_id 22)
    ]]
    OvaleScripts:RegisterScript("MAGE", nil, name, desc, code, "include")
end
