local __exports = LibStub:NewLibrary("ovale/scripts/ovale_warrior_spells", 80300)
if not __exports then return end
__exports.registerWarriorSpells = function(OvaleScripts)
    local name = "ovale_warrior_spells"
    local desc = "[9.0] Ovale: Warrior spells"
    local code = [[Define(ancestral_call 274738)
# Invoke the spirits of your ancestors, granting you a random secondary stat for 15 seconds.
  SpellInfo(ancestral_call cd=120 duration=15 gcd=0 offgcd=1)
  SpellAddBuff(ancestral_call ancestral_call=1)
Define(arcane_torrent_0 25046)
# Remove s1 beneficial effect from all enemies within A1 yards and restore m2 Energy.
  SpellInfo(arcane_torrent_0 cd=120 gcd=1 energy=-15)
Define(arcane_torrent_1 28730)
# Remove s1 beneficial effect from all enemies within A1 yards and restore s2 of your Mana.
  SpellInfo(arcane_torrent_1 cd=120)
Define(arcane_torrent_2 50613)
# Remove s1 beneficial effect from all enemies within A1 yards and restore m2/10 Runic Power.
  SpellInfo(arcane_torrent_2 cd=120 runicpower=-20)
Define(arcane_torrent_3 69179)
# Remove s1 beneficial effect from all enemies within A1 yards and increase your Rage by m2/10.rn
  SpellInfo(arcane_torrent_3 cd=120 rage=-15)
Define(arcane_torrent_4 80483)
# Remove s1 beneficial effect from all enemies within A1 yards and restore s2 of your Focus.
  SpellInfo(arcane_torrent_4 cd=120 focus=-15)
Define(arcane_torrent_5 129597)
# Remove s1 beneficial effect from all enemies within A1 yards and restore ?s137025[s2 Chi][]?s137024[s3 of your mana][]?s137023[s4 Energy][].
  SpellInfo(arcane_torrent_5 cd=120 gcd=1 chi=-1 energy=-15)
Define(arcane_torrent_6 155145)
# Remove s1 beneficial effect from all enemies within A1 yards and restore s2 Holy Power.
  SpellInfo(arcane_torrent_6 cd=120 holypower=-1)
Define(arcane_torrent_7 202719)
# Remove s1 beneficial effect from all enemies within A1 yards and generate ?s203513[m3/10 Pain][m2 Fury].
  SpellInfo(arcane_torrent_7 cd=120 fury=-15 pain=-15)
Define(arcane_torrent_8 232633)
# Remove s1 beneficial effect from all enemies within A1 yards and restore ?s137033[s3/100 Insanity][s2 of your mana].
  SpellInfo(arcane_torrent_8 cd=120 insanity=-1500)
Define(avatar 107574)
# Transform into a colossus for 20 seconds, causing you to deal s1 increased damage and removing all roots and snares.rnrn|cFFFFFFFFGenerates s5/10 Rage.|r
# Rank 2: Generates s1/10 more Rage.
  SpellInfo(avatar cd=90 duration=20 gcd=0 offgcd=1 rage=-20 talent=avatar_talent)
  # Damage done increased by s1.
  SpellAddBuff(avatar avatar=1)
Define(bag_of_tricks 312411)
# Pull your chosen trick from the bag and use it on target enemy or ally. Enemies take <damage> damage, while allies are healed for <healing>. 
  SpellInfo(bag_of_tricks cd=90)
Define(berserking 59621)
# Permanently enchant a melee weapon to sometimes increase your attack power by 59620s1, but at the cost of reduced armor. Cannot be applied to items higher than level ecix
  SpellInfo(berserking gcd=0 offgcd=1)
Define(bladestorm 46924)
# Become an unstoppable storm of destructive force, striking up to s1 nearby targets for <dmg> Physical damage over 4 seconds.rnrnYou are immune to movement impairing and loss of control effects, but can use defensive abilities and avoid attacks.rnrn|cFFFFFFFFGenerates o4/10 Rage over the duration.|r
# Rank 1: You attack all nearby enemies for 9 seconds causing weapon damage plus an additional (100 of Spell Power) every t1 sec.
  SpellInfo(bladestorm cd=60 duration=4 tick=1 talent=bladestorm_talent)
  # Dealing damage to all nearby enemies every t1 sec.rnImmune to crowd control.
  SpellAddBuff(bladestorm bladestorm=1)
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
Define(bloodthirst 23881)
# Assault the target in a bloodthirsty craze, dealing s1 Physical damage and restoring 117313s1 of your health.rnrn|cFFFFFFFFGenerates s2/10 Rage.|r
# Rank 2: Damage increased by s1.
  SpellInfo(bloodthirst cd=4.5 rage=-8)
Define(charge_0 100)
# Charge to an enemy, dealing 126664s2 Physical damage, rooting it for 1 second?s103828[, and stunning it for 7922d][].rnrn|cFFFFFFFFGenerates /10;s2 Rage.|r
# Rank 2: Generates s1/10 more Rage.
  SpellInfo(charge_0 cd=1.5 charge_cd=20 gcd=0 offgcd=1 rage=-10)
Define(charge_1 126664)
# Charge to an enemy, dealing 126664s2 Physical damage, rooting it for 1 second?s103828[, and stunning it for 7922d][].rnrn|cFFFFFFFFGenerates /10;s2 Rage.|r
  SpellInfo(charge_1 gcd=0 offgcd=1)
Define(cleave 845)
# Strikes up to s2 enemies in front of you for s1 Physical damage, inflicting Deep Wounds. Cleave will consume your Overpower effect to deal increased damage.
  SpellInfo(cleave rage=20 cd=6 talent=cleave_talent)
Define(colossus_smash 167105)
# Smashes the enemy's armor, dealing s1 Physical damage, and increasing damage you deal to them by 208086s1 for 10 seconds.
# Rank 2: Cooldown reduced by s1/-1000 sec.
  SpellInfo(colossus_smash cd=90)
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
Define(conductive_ink_debuff 302597)
# Your damaging abilities against enemies above M3 health have a very high chance to apply Conductive Ink. When an enemy falls below M3 health, Conductive Ink inflicts s1*(1+@versadmg) Nature damage per stack.
  SpellInfo(conductive_ink_debuff channel=0 gcd=0 offgcd=1)

Define(crushing_assault_buff 278824)
# Your melee abilities have a chance to increase the damage of your next Slam by s1 and reduce its Rage cost by s2/10.
  SpellInfo(crushing_assault_buff channel=-0.001 gcd=0 offgcd=1)

Define(deadly_calm 262228)
# Reduces the Rage cost of your next n abilities by s1.rnrn|cFFFFFFFFPassive:|r Your maximum Rage is increased by 314522s1/10.
  SpellInfo(deadly_calm cd=60 duration=20 gcd=0 offgcd=1 talent=deadly_calm_talent)
  # Your abilities cost s1 less Rage.
  SpellAddBuff(deadly_calm deadly_calm=1)
Define(deep_wounds 115768)
# Your ?s236279[Devastator][Devastate] and Revenge also cause the enemy to bleed for 115767o1 Physical damage over 15 seconds.
  SpellInfo(deep_wounds channel=0 gcd=0 offgcd=1)

Define(dragon_roar 118000)
# Roar explosively, dealing s1 Physical damage to all enemies within A1 yds. Dragon Roar critically strikes for 3 times normal damage.rnrn|cFFFFFFFFGenerates s2/10 Rage.|r
  SpellInfo(dragon_roar cd=30 rage=-10 talent=dragon_roar_talent_protection)
Define(execute_0 231830)
# If your foe survives, 163201s2 of the Rage spent is refunded.
  SpellInfo(execute_0 channel=0 gcd=0 offgcd=1)
  SpellAddBuff(execute_0 execute_0=1)
Define(execute_1 316405)
# Execute no longer has a cooldown.
  SpellInfo(execute_1 channel=0 gcd=0 offgcd=1)
  SpellAddBuff(execute_1 execute_1=1)
Define(fireblood_0 265221)
# Removes all poison, disease, curse, magic, and bleed effects and increases your ?a162700[Agility]?a162702[Strength]?a162697[Agility]?a162698[Strength]?a162699[Intellect]?a162701[Intellect][primary stat] by 265226s1*3 and an additional 265226s1 for each effect removed. Lasts 8 seconds. ?s195710[This effect shares a 30 sec cooldown with other similar effects.][]
  SpellInfo(fireblood_0 cd=120 gcd=0 offgcd=1)
Define(fireblood_1 265226)
# Increases ?a162700[Agility]?a162702[Strength]?a162697[Agility]?a162698[Strength]?a162699[Intellect]?a162701[Intellect][primary stat] by s1.
  SpellInfo(fireblood_1 duration=8 max_stacks=6 gcd=0 offgcd=1)
  # Increases ?a162700[Agility]?a162702[Strength]?a162697[Agility]?a162698[Strength]?a162699[Intellect]?a162701[Intellect][primary stat] by w1.
  SpellAddBuff(fireblood_1 fireblood_1=1)
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
  SpellAddBuff(guardian_of_azeroth_5 guardian_of_azeroth_buff=1)
Define(guardian_of_azeroth_buff 303349)
  SpellInfo(guardian_of_azeroth_buff gcd=0 offgcd=1)

Define(heroic_leap 6544)
# Leap through the air toward a target location, slamming down with destructive force to deal 52174s1 Physical damage to all enemies within 52174a1 yards?c3[, and resetting the remaining cooldown on Taunt][].
  SpellInfo(heroic_leap cd=0.8 charge_cd=45 gcd=0 offgcd=1)
Define(intimidating_shout_0 5246)
# ?s275338[Causes the targeted enemy and up to s1 additional enemies within 5246A3 yards to cower in fear.][Causes the targeted enemy to cower in fear, and up to s1 additional enemies within 5246A3 yards to flee.] Targets are disoriented for 8 seconds.
  SpellInfo(intimidating_shout_0 cd=90 duration=8)
  # Disoriented.
  SpellAddTargetDebuff(intimidating_shout_0 intimidating_shout_0=1)
Define(intimidating_shout_1 316593)
# Cause the targeted enemy to cower in fear. All other nearby enemies are knocked away, and then forced to cower in fear. Targets are disoriented for 15 seconds.
  SpellInfo(intimidating_shout_1 cd=90 duration=15)

  # Disoriented.
  SpellAddTargetDebuff(intimidating_shout_1 intimidating_shout_1=1)
Define(lights_judgment 255647)
# Call down a strike of Holy energy, dealing <damage> Holy damage to enemies within A1 yards after 3 sec.
  SpellInfo(lights_judgment cd=150)

Define(meat_cleaver 280392)
# Whirlwind deals s1 more damage and now affects your next s2+s3 single-target melee attacks, instead of the next s3 attacks.
  SpellInfo(meat_cleaver channel=0 gcd=0 offgcd=1 talent=meat_cleaver_talent)
  SpellAddBuff(meat_cleaver meat_cleaver=1)
Define(memory_of_lucid_dreams_0 299300)
# Infuse your Heart of Azeroth with Memory of Lucid Dreams.
  SpellInfo(memory_of_lucid_dreams_0)
Define(memory_of_lucid_dreams_1 299302)
# Infuse your Heart of Azeroth with Memory of Lucid Dreams.
  SpellInfo(memory_of_lucid_dreams_1)
Define(memory_of_lucid_dreams_2 299304)
# Infuse your Heart of Azeroth with Memory of Lucid Dreams.
  SpellInfo(memory_of_lucid_dreams_2)
Define(mortal_strike 12294)
# A vicious strike that deals s1 Physical damage and reduces the effectiveness of healing on the target by 115804s1 for 10 seconds.
# Rank 2: Damage increased by s1.
  SpellInfo(mortal_strike rage=30 cd=6)
Define(noxious_venom 267410)
  SpellInfo(noxious_venom duration=4 channel=4 max_stacks=3 gcd=0 offgcd=1 tick=1)
  # Inflicts w1 Nature damage every t1 sec.
  SpellAddTargetDebuff(noxious_venom noxious_venom=1)
Define(onslaught 315720)
# Brutally attack an enemy for s1 Physical damage. Requires Enrage.rnrn|cFFFFFFFFGenerates m2/10 Rage.|r
  SpellInfo(onslaught cd=12 rage=-15 talent=onslaught_talent)
Define(overpower 7384)
# Overpower the enemy, dealing s1 Physical damage. Cannot be blocked, dodged, or parried.?s316440&s845[rnrnIncreases the damage of your next Mortal Strike or Cleave by s2]?s316440[rnrnIncreases the damage of your next Mortal Strike by s2][]?(s316440&!s316441)[.][]?s316441[, stacking up to u times.][]
# Rank 3: Overpower's bonus to Mortal Strike can stack up to s1+1 times.
  SpellInfo(overpower cd=12 duration=15 max_stacks=1)
  # Your next Mortal Strike ?s845[or Cleave ][]will deal w2 increased damage.
  SpellAddBuff(overpower overpower=1)
Define(pummel 6552)
# Pummels the target, interrupting spellcasting and preventing any spell in that school from being cast for 4 seconds.
# Rank 1: Pummel the target for s2 damage and interrupt the spell being cast for 5 seconds.
  SpellInfo(pummel cd=15 duration=4 gcd=0 offgcd=1 interrupt=1)
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
Define(quaking_palm 107079)
# Strikes the target with lightning speed, incapacitating them for 4 seconds, and turns off your attack.
  SpellInfo(quaking_palm cd=120 duration=4 gcd=1)
  # Incapacitated.
  SpellAddTargetDebuff(quaking_palm quaking_palm=1)
Define(raging_blow 85288)
# A mighty blow with both weapons that deals a total of <damage> Physical damage.?s316452[rnrnRaging Blow has a s1 chance to instantly reset its own cooldown.][]rnrn|cFFFFFFFFGenerates m2/10 Rage.|r
# Rank 3: Raging Blow has s1+1 charges.
  SpellInfo(raging_blow cd=8 rage=-12)

Define(rampage 184367)
# ?s316412[Enrages you and unleashes][Unleashes] a series of s1 brutal strikes for a total of <damage> Physical damage.
# Rank 3: Damage increased by s1.
  SpellInfo(rampage rage=80)

Define(ravager 152277)
# Throws a whirling weapon at the target location that chases nearby enemies, inflicting <damage> Physical damage and applying Deep Wounds to up to 156287s2 enemies over 12 seconds.rnrn|cFFFFFFFFGenerates 248439s1/10 Rage each time it deals damage.|r
  SpellInfo(ravager cd=45 duration=12 tick=2 talent=ravager_talent)
  # Ravager is currently active.
  SpellAddBuff(ravager ravager=1)
Define(razor_coral_0 303564)
# ?a303565[Remove Razor Coral from your target, granting you 303573s1 Critical Strike per stack for 20 seconds.][Deal 304877s1*(1+@versadmg) Physical damage and apply Razor Coral to your target, giving your damaging abilities against the target a high chance to deal 304877s1*(1+@versadmg) Physical damage and add a stack of Razor Coral.rnrnReactivating this ability will remove Razor Coral from your target, granting you 303573s1 Critical Strike per stack for 20 seconds.]
  SpellInfo(razor_coral_0 cd=20 channel=0 gcd=0 offgcd=1)
Define(razor_coral_1 303565)
# ?a303565[Remove Razor Coral from your target, granting you 303573s1 Critical Strike per stack for 20 seconds.][Deal 304877s1*(1+@versadmg) Physical damage and apply Razor Coral to your target, giving your damaging abilities against the target a high chance to deal 304877s1*(1+@versadmg) Physical damage and add a stack of Razor Coral.rnrnReactivating this ability will remove Razor Coral from your target, granting you 303573s1 Critical Strike per stack for 20 seconds.]rn
  SpellInfo(razor_coral_1 duration=120 max_stacks=100 gcd=0 offgcd=1)
  SpellAddBuff(razor_coral_1 razor_coral_1=1)
Define(razor_coral_2 303568)
# ?a303565[Remove Razor Coral from your target, granting you 303573s1 Critical Strike per stack for 20 seconds.][Deal 304877s1*(1+@versadmg) Physical damage and apply Razor Coral to your target, giving your damaging abilities against the target a high chance to deal 304877s1*(1+@versadmg) Physical damage and add a stack of Razor Coral.rnrnReactivating this ability will remove Razor Coral from your target, granting you 303573s1 Critical Strike per stack for 20 seconds.]rn
  SpellInfo(razor_coral_2 duration=120 max_stacks=100 gcd=0 offgcd=1)
  # Withdrawing the Razor Coral will grant w1 Critical Strike.
  SpellAddTargetDebuff(razor_coral_2 razor_coral_2=1)
Define(razor_coral_3 303570)
# ?a303565[Remove Razor Coral from your target, granting you 303573s1 Critical Strike per stack for 20 seconds.][Deal 304877s1*(1+@versadmg) Physical damage and apply Razor Coral to your target, giving your damaging abilities against the target a high chance to deal 304877s1*(1+@versadmg) Physical damage and add a stack of Razor Coral.rnrnReactivating this ability will remove Razor Coral from your target, granting you 303573s1 Critical Strike per stack for 20 seconds.]rn
  SpellInfo(razor_coral_3 duration=20 channel=20 max_stacks=100 gcd=0 offgcd=1)
  # Critical Strike increased by w1.
  SpellAddBuff(razor_coral_3 razor_coral_3=1)
Define(razor_coral_4 303572)
# ?a303565[Remove Razor Coral from your target, granting you 303573s1 Critical Strike per stack for 20 seconds.][Deal 304877s1*(1+@versadmg) Physical damage and apply Razor Coral to your target, giving your damaging abilities against the target a high chance to deal 304877s1*(1+@versadmg) Physical damage and add a stack of Razor Coral.rnrnReactivating this ability will remove Razor Coral from your target, granting you 303573s1 Critical Strike per stack for 20 seconds.]rn
  SpellInfo(razor_coral_4 channel=0 gcd=0 offgcd=1)
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
Define(recklessness 1719)
# Go berserk, increasing all Rage generation by s4?a202751[, greatly empowering Bloodthirst and Raging Blow,][] and granting your abilities s1 increased critical strike chance for 10 seconds.?a202751[rnrn|cFFFFFFFFGenerates s3/10 Rage.|r][]
# Rank 2: Duration increased by s1/1000 sec.
  SpellInfo(recklessness cd=90 duration=10 gcd=0 offgcd=1 rage=0)
  # Rage generation increased by s5.rnCritical strike chance of all abilities increased by w1.?a202751[rnBloodthirst and Raging Blow upgraded to @spellname335096 and @spellname335097.][]
  SpellAddBuff(recklessness recklessness=1)
Define(rend 772)
# Wounds the target, causing s1 Physical damage instantly and an additional o2 Bleed damage over 15 seconds.rnrnIncreases critical damage you deal to the enemy by s3.
  SpellInfo(rend rage=30 duration=15 tick=3 talent=rend_talent)
  # Bleeding for w2 damage every t2 sec. Taking w3 increased critical damage from @auracaster.
  SpellAddTargetDebuff(rend rend=1)
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
Define(shockwave 46968)
# Sends a wave of force in a frontal cone, causing s2 damage and stunning all enemies within a1 yards for 2 seconds.
  SpellInfo(shockwave cd=40)
  # Stunned.
  SpellAddBuff(shockwave shockwave=1)
Define(siegebreaker 280772)
# Break the enemy's defenses, dealing s1 Physical damage, and increasing your damage done to the target by 280773s1 for 10 seconds.rnrn|cFFFFFFFFGenerates m2/10 Rage.|r
  SpellInfo(siegebreaker cd=30 rage=-10 talent=siegebreaker_talent)
Define(skullsplitter 260643)
# Bash an enemy's skull, dealing s1 Physical damage.rnrn|cFFFFFFFFGenerates s2/10 Rage.|r
  SpellInfo(skullsplitter cd=21 rage=-20 talent=skullsplitter_talent)
Define(slam_0 261901)
# Damage increased by s1.
  SpellInfo(slam_0 channel=0 gcd=0 offgcd=1)
  SpellAddBuff(slam_0 slam_0=1)
Define(slam_1 316534)
# Damage increased by s1.
  SpellInfo(slam_1 channel=0 gcd=0 offgcd=1)
  SpellAddBuff(slam_1 slam_1=1)
Define(storm_bolt 107570)
# Hurls your weapon at an enemy, causing s1 Physical damage and stunning for 4 seconds.
  SpellInfo(storm_bolt cd=30 talent=storm_bolt_talent_fury)
  # Stunned.
  SpellAddBuff(storm_bolt storm_bolt=1)
Define(sudden_death 29725)
# Your attacks have a chance to make your next ?a317320[Condemn][Execute] cost no Rage, be usable on any target regardless of their health, and deal damage as if you spent s1 Rage.
  SpellInfo(sudden_death channel=0 gcd=0 offgcd=1 talent=sudden_death_talent)
  SpellAddBuff(sudden_death sudden_death=1)
Define(sweeping_strikes 260708)
# For 12 seconds your single-target damaging abilities hit s1 additional Ltarget:targets; within 8 yds for s2 damage.
# Rank 3: Duration increased by s1/1000 sec.
  SpellInfo(sweeping_strikes cd=45 duration=12 gcd=0.75)
  # Your single-target damaging abilities hit s1 additional Ltarget:targets; within 8 yds for s2 damage.
  SpellAddBuff(sweeping_strikes sweeping_strikes=1)
Define(test_of_might_buff 275531)
# When ?s262161[Warbreaker][Colossus Smash] expires, your Strength is increased by s1 for every s2 Rage you spent during ?s262161[Warbreaker][Colossus Smash]. Lasts 12 seconds.
  SpellInfo(test_of_might_buff channel=-0.001 gcd=0 offgcd=1)

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
Define(war_stomp 20549)
# Stuns up to i enemies within A1 yds for 2 seconds.
  SpellInfo(war_stomp cd=90 duration=2 gcd=0 offgcd=1)
  # Stunned.
  SpellAddTargetDebuff(war_stomp war_stomp=1)
Define(warbreaker 262161)
# Smash the ground and shatter the armor of all enemies within A1 yds, dealing s1 Physical damage and increasing damage you deal to them by 208086s1 for 10 seconds.
  SpellInfo(warbreaker cd=45 talent=warbreaker_talent)
Define(whirlwind 190411)
# Unleashes a whirlwind of steel, striking up to s3 nearby enemies for <damage> Physical damage.?s12950[rnrnCauses your next 85739u single-target melee lattack:attacks; to strike up to 85739s1 additional targets for 85739s3 damage.][]?s316435[rnrn|cFFFFFFFFGenerates s1 Rage, plus an additional s2 per target hit.|r][]
# Rank 2: Whirlwind no longer costs Rage. Instead it generates 190411s1 Rage, plus an additional 190411s2 per target hit. Maximum <maxRage> Rage.
  SpellInfo(whirlwind rage=30)

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
SpellList(arcane_torrent arcane_torrent_0 arcane_torrent_1 arcane_torrent_2 arcane_torrent_3 arcane_torrent_4 arcane_torrent_5 arcane_torrent_6 arcane_torrent_7 arcane_torrent_8)
SpellList(blood_fury blood_fury_0 blood_fury_1 blood_fury_2 blood_fury_3)
SpellList(blood_of_the_enemy blood_of_the_enemy_0 blood_of_the_enemy_1 blood_of_the_enemy_2 blood_of_the_enemy_3)
SpellList(charge charge_0 charge_1)
SpellList(concentrated_flame concentrated_flame_0 concentrated_flame_1 concentrated_flame_2 concentrated_flame_3 concentrated_flame_4 concentrated_flame_5 concentrated_flame_6)
SpellList(execute execute_0 execute_1)
SpellList(fireblood fireblood_0 fireblood_1)
SpellList(focused_azerite_beam focused_azerite_beam_0 focused_azerite_beam_1 focused_azerite_beam_2 focused_azerite_beam_3)
SpellList(guardian_of_azeroth guardian_of_azeroth_0 guardian_of_azeroth_1 guardian_of_azeroth_2 guardian_of_azeroth_3 guardian_of_azeroth_4 guardian_of_azeroth_5)
SpellList(intimidating_shout intimidating_shout_0 intimidating_shout_1)
SpellList(memory_of_lucid_dreams memory_of_lucid_dreams_0 memory_of_lucid_dreams_1 memory_of_lucid_dreams_2)
SpellList(purifying_blast purifying_blast_0 purifying_blast_1 purifying_blast_2 purifying_blast_3 purifying_blast_4 purifying_blast_5)
SpellList(razor_coral razor_coral_0 razor_coral_1 razor_coral_2 razor_coral_3 razor_coral_4)
SpellList(reaping_flames reaping_flames_0 reaping_flames_1 reaping_flames_2 reaping_flames_3 reaping_flames_4)
SpellList(reckless_force_buff reckless_force_buff_0 reckless_force_buff_1)
SpellList(ripple_in_space ripple_in_space_0 ripple_in_space_1 ripple_in_space_2 ripple_in_space_3)
SpellList(slam slam_0 slam_1)
SpellList(the_unbound_force the_unbound_force_0 the_unbound_force_1 the_unbound_force_2 the_unbound_force_3)
SpellList(worldvein_resonance worldvein_resonance_0 worldvein_resonance_1 worldvein_resonance_2 worldvein_resonance_3)
Define(avatar_talent 17) #22397
# Transform into a colossus for 20 seconds, causing you to deal s1 increased damage and removing all roots and snares.rnrn|cFFFFFFFFGenerates s5/10 Rage.|r
Define(bladestorm_talent 18) #22400
# Become an unstoppable storm of destructive force, striking up to s1 nearby targets for <dmg> Physical damage over 4 seconds.rnrnYou are immune to movement impairing and loss of control effects, but can use defensive abilities and avoid attacks.rnrn|cFFFFFFFFGenerates o4/10 Rage over the duration.|r
Define(cleave_talent 15) #22362
# Strikes up to s2 enemies in front of you for s1 Physical damage, inflicting Deep Wounds. Cleave will consume your Overpower effect to deal increased damage.
Define(deadly_calm_talent 18) #22399
# Reduces the Rage cost of your next n abilities by s1.rnrn|cFFFFFFFFPassive:|r Your maximum Rage is increased by 314522s1/10.
Define(dragon_roar_talent_protection 9) #23260
# Roar explosively, dealing s1 Physical damage to all enemies within A1 yds. Dragon Roar critically strikes for 3 times normal damage.rnrn|cFFFFFFFFGenerates s2/10 Rage.|r
Define(fervor_of_battle_talent 8) #22489
# Whirlwind also Slams your primary target.
Define(massacre_talent_arms 7) #22380
# ?a317320[Condemn][Execute] is now usable on targets below s2 health.
Define(meat_cleaver_talent 16) #22396
# Whirlwind deals s1 more damage and now affects your next s2+s3 single-target melee attacks, instead of the next s3 attacks.
Define(onslaught_talent 9) #23372
# Brutally attack an enemy for s1 Physical damage. Requires Enrage.rnrn|cFFFFFFFFGenerates m2/10 Rage.|r
Define(ravager_talent 21) #21667
# Throws a whirling weapon at the target location that chases nearby enemies, inflicting <damage> Physical damage and applying Deep Wounds to up to 156287s2 enemies over 12 seconds.rnrn|cFFFFFFFFGenerates 248439s1/10 Rage each time it deals damage.|r
Define(reckless_abandon_talent 20) #22402
# Recklessness generates s1/10 Rage and greatly empowers Bloodthirst and Raging Blow.
Define(rend_talent 9) #19138
# Wounds the target, causing s1 Physical damage instantly and an additional o2 Bleed damage over 15 seconds.rnrnIncreases critical damage you deal to the enemy by s3.
Define(siegebreaker_talent 21) #16037
# Break the enemy's defenses, dealing s1 Physical damage, and increasing your damage done to the target by 280773s1 for 10 seconds.rnrn|cFFFFFFFFGenerates m2/10 Rage.|r
Define(skullsplitter_talent 3) #22371
# Bash an enemy's skull, dealing s1 Physical damage.rnrn|cFFFFFFFFGenerates s2/10 Rage.|r
Define(storm_bolt_talent_fury 6) #23093
# Hurls your weapon at an enemy, causing s1 Physical damage and stunning for 4 seconds.
Define(sudden_death_talent 2) #22360
# Your attacks have a chance to make your next ?a317320[Condemn][Execute] cost no Rage, be usable on any target regardless of their health, and deal damage as if you spent s1 Rage.
Define(warbreaker_talent 14) #22391
# Smash the ground and shatter the armor of all enemies within A1 yds, dealing s1 Physical damage and increasing damage you deal to them by 208086s1 for 10 seconds.
Define(test_of_might_trait 275529)
Define(cold_steel_hot_blood_trait 288080)
Define(condensed_lifeforce_essence_id 14)
Define(memory_of_lucid_dreams_essence_id 27)
Define(blood_of_the_enemy_essence_id 23)
    ]]
    OvaleScripts:RegisterScript("WARRIOR", nil, name, desc, code, "include")
end
