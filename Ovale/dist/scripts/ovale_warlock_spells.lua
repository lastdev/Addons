local __exports = LibStub:NewLibrary("ovale/scripts/ovale_warlock_spells", 80300)
if not __exports then return end
__exports.registerWarlockSpells = function(OvaleScripts)
    local name = "ovale_warlock_spells"
    local desc = "[9.0] Ovale: Warlock spells"
    local code = [[Define(agony 980)
# Inflicts increasing agony on the target, causing up to ((1.1199999999999999 of Spell Power)+0.1)*18 seconds/t1*u Shadow damage over 18 seconds. Damage starts low and increases over the duration. Refreshing Agony maintains its current damage level.rnrn|cFFFFFFFFAgony damage sometimes generates 1 Soul Shard.|r
# Rank 2: Agony may now ramp up to s1+6 stacks.
  SpellInfo(agony duration=18 max_stacks=6 tick=2)
  # Suffering w1 Shadow damage every t1 sec. Damage increases over time.
  SpellAddTargetDebuff(agony agony=1)
Define(backdraft 196406)
# Conflagrate reduces the cast time of your next Incinerate or Chaos Bolt by 117828s1. Maximum ?s267115[s2][s1] charges.
  SpellInfo(backdraft channel=0 gcd=0 offgcd=1)
  SpellAddBuff(backdraft backdraft=1)
Define(berserking 59621)
# Permanently enchant a melee weapon to sometimes increase your attack power by 59620s1, but at the cost of reduced armor. Cannot be applied to items higher than level ecix
  SpellInfo(berserking gcd=0 offgcd=1)
Define(bilescourge_bombers 267211)
# Tear open a portal to the nether above the target location, from which several Bilescourge will pour out of and crash into the ground over 6 seconds, dealing (23 of Spell Power) Shadow damage to all enemies within 267213A1 yards.
  SpellInfo(bilescourge_bombers soulshards=2 cd=30 duration=6 talent=bilescourge_bombers_talent)
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
Define(call_dreadstalkers 104316)
# Summons s1 ferocious Dreadstalkers to attack the target for 12 seconds.
# Rank 2: Reduces the cast time of Call Dreadstalkers by 0.5 sec, and teaches your Dreadstalkers how to pursue targets faster.
  SpellInfo(call_dreadstalkers soulshards=2 cd=20)
Define(cataclysm 152108)
# Calls forth a cataclysm at the target location, dealing (180 of Spell Power) Shadowflame damage to all enemies within A1 yards and afflicting them with ?s980[Agony and Unstable Affliction][]?s104315[Corruption][]?s348[Immolate][]?!s980&!s104315&!s348[Agony, Unstable Affliction, Corruption, or Immolate][].
  SpellInfo(cataclysm cd=30 talent=cataclysm_talent)
Define(channel_demonfire 196447)
# Launches s1 bolts of felfire over 3 seconds at random targets afflicted by your Immolate within 196449A1 yds. Each bolt deals (19.36 of Spell Power) Fire damage to the target and (7.7 of Spell Power) Fire damage to nearby enemies.
  SpellInfo(channel_demonfire cd=25 duration=3 channel=3 tick=0.2 talent=channel_demonfire_talent)
  SpellAddBuff(channel_demonfire channel_demonfire=1)
Define(chaos_bolt 116858)
# Unleashes a devastating blast of chaos, dealing a critical strike for 2*(120 of Spell Power) Chaos damage. Damage is further increased by your critical strike chance.
  SpellInfo(chaos_bolt soulshards=2)
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
Define(conflagrate 17962)
# Triggers an explosion on the target, dealing (100 of Spell Power) Fire damage.?s196406[rnrnReduces the cast time of your next Incinerate or Chaos Bolt by 117828s1 for 10 seconds.][]rnrn|cFFFFFFFFGenerates 245330s1 Soul Shard Fragments.|r
# Rank 2: Conflagrate has s1+1 charges.
  SpellInfo(conflagrate cd=12.96)
Define(corruption_0 317031)
# Corruption is now instant.
  SpellInfo(corruption_0 channel=0 gcd=0 offgcd=1)
  # Corruption is now instant.
  SpellAddBuff(corruption_0 corruption_0=1)
Define(corruption_1 334342)
# Corruption now instantly deals (12 of Spell Power) damage.
  SpellInfo(corruption_1 channel=0 gcd=0 offgcd=1)
  SpellAddBuff(corruption_1 corruption_1=1)
Define(corruption_debuff 146739)
# Corrupts the target, causing?s334342[ (12 of Spell Power) Shadow damage and an additional][] 146739o1 Shadow damage over 14 seconds.
  SpellInfo(corruption_debuff duration=14 channel=14 gcd=0 offgcd=1 tick=2)
  # Suffering w1 Shadow damage every t1 sec.
  SpellAddTargetDebuff(corruption_debuff corruption_debuff=1)
Define(dark_soul_instability 113858)
# Infuses your soul with unstable power, increasing your critical strike chance by 113858s1 for 20 seconds.?s56228[rnrn|cFFFFFFFFPassive:|rrnIncreases your critical strike chance by 113858m1/56228m1. This effect is disabled while on cooldown.][]
  SpellInfo(dark_soul_instability cd=120 charge_cd=120 duration=20 gcd=0 offgcd=1 talent=dark_soul_instability_talent)
  # Critical strike chance increased by w1.
  SpellAddBuff(dark_soul_instability dark_soul_instability=1)
Define(dark_soul_misery 113860)
# Infuses your soul with the misery of fallen foes, increasing haste by (25 of Spell Power) for 20 seconds.
  SpellInfo(dark_soul_misery cd=120 duration=20 gcd=0 offgcd=1 talent=dark_soul_misery_talent)
  # Haste increased by s1.
  SpellAddBuff(dark_soul_misery dark_soul_misery=1)
Define(demonbolt 264178)
# Send the fiery soul of a fallen demon at the enemy, causing (73.4 of Spell Power) Shadowflame damage.?c2[rnrn|cFFFFFFFFGenerates 2 Soul Shards.|r][]
  SpellInfo(demonbolt)
Define(demonic_core 267102)
# When your Wild Imps expend all of their energy or are imploded, you have a s1 chance to absorb their life essence, granting you a stack of Demonic Core. rnrnWhen your summoned Dreadstalkers fade away, you have a s2 chance to absorb their life essence, granting you a stack of Demonic Core.rnrnDemonic Core reduces the cast time of Demonbolt by 264173s1. Maximum 264173u stacks.
  SpellInfo(demonic_core channel=0 gcd=0 offgcd=1)
  SpellAddBuff(demonic_core demonic_core=1)
Define(demonic_strength 267171)
# Infuse your Felguard with demonic strength and command it to charge your target and unleash a Felstorm that will deal s2 increased damage.
  SpellInfo(demonic_strength cd=60 duration=20 talent=demonic_strength_talent)
  # Your next Felstorm will deal s2 increased damage.
  SpellAddBuff(demonic_strength demonic_strength=1)
Define(doom 603)
# Inflicts impending doom upon the target, causing o1 Shadow damage after 20 seconds.rnrn|cFFFFFFFFDoom damage generates 1 Soul Shard.|r
  SpellInfo(doom duration=20 tick=20 talent=doom_talent)
  # Doomed to take w1 Shadow damage.
  SpellAddTargetDebuff(doom doom=1)
Define(drain_life 234153)
# ?a334320[Drains life from the target, causing o1 * 334320s1 Shadow damage over 5 seconds, and healing you for e1*100 of the damage done.][Drains life from the target, causing o1 Shadow damage over 5 seconds, and healing you for e1*100 of the damage done.]
  SpellInfo(drain_life duration=5 channel=5 tick=1)
  # Suffering s1 Shadow damage every t1 seconds.rnRestoring health to the Warlock.
  SpellAddTargetDebuff(drain_life drain_life=1)
Define(drain_soul 198590)
# Drains the target's soul, causing o1 Shadow damage over 5 seconds.rnrnDamage is increased by s2 against enemies below s3 health.rnrn|cFFFFFFFFGenerates 1 Soul Shard if the target dies during this effect.|r
  SpellInfo(drain_soul duration=5 channel=5 tick=1 talent=drain_soul_talent)
  # Suffering w1 Shadow damage every t1 seconds.
  SpellAddTargetDebuff(drain_soul drain_soul=1)
Define(eradication 196412)
# Chaos Bolt increases the damage you deal to the target by 196414s1 for 7 seconds.
  SpellInfo(eradication channel=0 gcd=0 offgcd=1 talent=eradication_talent)

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
Define(grimoire_felguard 111898)
# Summons a Felguard who attacks the target for 17 seconds that deals 216187s1 increased damage.rnrnThis Felguard will stun their target when summoned.
  SpellInfo(grimoire_felguard soulshards=1 cd=120 duration=17 talent=grimoire_felguard_talent)
Define(grimoire_of_sacrifice_0 108503)
# Sacrifices your demon pet for power, gaining its command demon ability, and causing your spells to sometimes also deal (43.75 of Spell Power) additional Shadow damage.rnrnLasts 3600 seconds or until you summon a demon pet.
  SpellInfo(grimoire_of_sacrifice_0 cd=30 talent=grimoire_of_sacrifice_talent)

Define(grimoire_of_sacrifice_1 196100)
# Sacrifices your demon pet for power, gaining its command demon ability, and causing your spells to sometimes also deal (43.75 of Spell Power) additional Shadow damage.rnrnLasts 3600 seconds or until you summon a demon pet.
  SpellInfo(grimoire_of_sacrifice_1 gcd=0 offgcd=1)
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

Define(hand_of_guldan 105174)
# Calls down a demonic meteor full of Wild Imps which burst forth to attack the target.rnrnDeals up to m1*86040m1 Shadowflame damage on impact to all enemies within 86040A1 yds of the target?s196283[, applies Doom to each target,][] and summons up to m1*104317m2 Wild Imps, based on Soul Shards consumed.
  SpellInfo(hand_of_guldan soulshards=1)
Define(haunt 48181)
# A ghostly soul haunts the target, dealing (68.75 of Spell Power) Shadow damage and increasing your damage dealt to the target by s2 for 18 seconds.rnrnIf the target dies, Haunt's cooldown is reset.
  SpellInfo(haunt cd=15 duration=18 talent=haunt_talent)
  # Taking s2 increased damage from the Warlock. Haunt's cooldown will be reset on death.
  SpellAddTargetDebuff(haunt haunt=1)
Define(havoc 80240)
# Marks a target with Havoc for 10 seconds, causing your single target spells to also strike the Havoc victim for s1 of normal initial damage.
# Rank 2: Havoc lasts s1/1000 seconds longer.
  SpellInfo(havoc cd=30 duration=10 channel=10 max_stacks=1)
  # Spells cast by the Warlock also hit this target for s1 of normal initial damage.
  SpellAddTargetDebuff(havoc havoc=1)
Define(immolate 348)
# Burns the enemy, causing (40 of Spell Power) Fire damage immediately and an additional 157736o1 Fire damage over 18 seconds.rnrn|cFFFFFFFFPeriodic damage generates 1 Soul Shard Fragment and has a s2 chance to generate an additional 1 on critical strikes.|r
  SpellInfo(immolate)
Define(incinerate 29722)
# Draws fire toward the enemy, dealing (64.1 of Spell Power) Fire damage.rnrn|cFFFFFFFFGenerates 244670s1 Soul Shard Fragments and an additional 1 on critical strikes.|r
  SpellInfo(incinerate max_stacks=5)
  SpellInfo(shadow_bolt_0 replaced_by=incinerate)
Define(inevitable_demise_buff 273522)
# Damaging an enemy with Agony increases the damage of your next Drain Life by s1. This effect stacks up to 273525u times.
  SpellInfo(inevitable_demise_buff channel=-0.001 gcd=0 offgcd=1)
  SpellAddBuff(inevitable_demise_buff inevitable_demise_buff=1)
Define(inner_demons 267216)
# You passively summon a Wild Imp to fight for you every t1 sec, and have a s1 chance to also summon an additional Demon to fight for you for s2 sec.
  SpellInfo(inner_demons channel=0 gcd=0 offgcd=1 tick=12 talent=inner_demons_talent)
  SpellAddBuff(inner_demons inner_demons=1)
Define(malefic_rapture 324536)
# Your damaging periodic effects erupt on all targets, causing <damage> Shadow damage per effect.
  SpellInfo(malefic_rapture soulshards=1)
Define(memory_of_lucid_dreams_0 299300)
# Infuse your Heart of Azeroth with Memory of Lucid Dreams.
  SpellInfo(memory_of_lucid_dreams_0)
Define(memory_of_lucid_dreams_1 299302)
# Infuse your Heart of Azeroth with Memory of Lucid Dreams.
  SpellInfo(memory_of_lucid_dreams_1)
Define(memory_of_lucid_dreams_2 299304)
# Infuse your Heart of Azeroth with Memory of Lucid Dreams.
  SpellInfo(memory_of_lucid_dreams_2)
Define(nether_portal 267217)
# Tear open a portal to the Twisting Nether for 15 seconds. Every time you spend Soul Shards, you will also command demons from the Nether to come out and fight for you.
  SpellInfo(nether_portal soulshards=1 cd=180 duration=15 talent=nether_portal_talent)
Define(phantom_singularity_0 205179)
# Places a phantom singularity above the target, which consumes the life of all enemies within 205246A2 yards, dealing 8*(22.5 of Spell Power) damage over 16 seconds, healing you for 205246e2*100 of the damage done.
  SpellInfo(phantom_singularity_0 cd=45 duration=16 tick=2 talent=phantom_singularity_talent)
  # Dealing damage to all nearby targets every t1 sec and healing the casting Warlock.
  SpellAddTargetDebuff(phantom_singularity_0 phantom_singularity_0=1)
Define(phantom_singularity_1 205246)
# Places a phantom singularity above the target, which consumes the life of all enemies within 205246A2 yards, dealing 8*(22.5 of Spell Power) damage over 16 seconds, healing you for 205246e2*100 of the damage done.
  SpellInfo(phantom_singularity_1 gcd=0 offgcd=1)
Define(power_siphon 264130)
# Instantly sacrifice up to s1 Wild Imps, generating s1 charges of Demonic Core that cause Demonbolt to deal 334581s1 additional damage.
  SpellInfo(power_siphon cd=30 channel=0 talent=power_siphon_talent)
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
Define(rain_of_fire 5740)
# Calls down a rain of hellfire, dealing 42223m1*8 Fire damage over 8 seconds to enemies in the area.
# Rank 2: Rain of Fire deals s1 additional damage.
  SpellInfo(rain_of_fire soulshards=3 duration=8 tick=1)
  # 42223s1 Fire damage every 5740t2 sec.
  SpellAddBuff(rain_of_fire rain_of_fire=1)
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
Define(seed_of_corruption 27243)
# Embeds a demon seed in the enemy target that will explode after 12 seconds, dealing (40 of Spell Power) Shadow damage to all enemies within 27285A1 yards and applying Corruption to them.rnrnThe seed will detonate early if the target is hit by other detonations, or takes SPS*s1/100 damage from your spells.
  SpellInfo(seed_of_corruption soulshards=1 duration=12 tick=12)
  # Embeded with a demon seed that will soon explode, dealing Shadow damage to the caster's enemies within 27285A1 yards, and applying Corruption to them.rnrnThe seed will detonate early if the target is hit by other detonations, or takes w3 damage from your spells.
  SpellAddTargetDebuff(seed_of_corruption seed_of_corruption=1)
Define(shadow_bolt_0 686)
# Sends a shadowy bolt at the enemy, causing (34.5 of Spell Power) Shadow damage.?c2[rnrn|cFFFFFFFFGenerates 1 Soul Shard.|r][]?a32388[rnrnApplies Shadow Embrace, increasing your damage dealt to the target by 32390s1 for 12 seconds. Stacks up to 32390u times.][] 
  SpellInfo(shadow_bolt_0)
Define(shadow_bolt_1 288546)
# Deals s1 Shadow damage.
  SpellInfo(shadow_bolt_1 energy=1 gcd=0 offgcd=1)
Define(shadow_bolt_2 317791)
# Deals s1 Shadow damage.
  SpellInfo(shadow_bolt_2 energy=1 gcd=0 offgcd=1)
Define(shadowburn 17877)
# Blasts a target for (130 of Spell Power) Shadowflame damage, gaining s3 critical strike chance on targets that have 20 or less health.rnrn|cFFFFFFFFRestores 245731s1/10 Soul Shard if the target dies within 5 seconds.|r
  SpellInfo(shadowburn soulshards=1 cd=12 duration=5 talent=shadowburn_talent)
  # If the target dies and yields experience or honor, Shadowburn restores 245731s1/10 Soul Shard.
  SpellAddTargetDebuff(shadowburn shadowburn=1)
Define(siphon_life 63106)
# Siphons the target's life essence, dealing o1 Shadow damage over 15 seconds and healing you for e1*100 of the damage done.
  SpellInfo(siphon_life duration=15 tick=3 talent=siphon_life_talent)
  # Suffering w1 Shadow damage every t1 sec and siphoning life to the casting Warlock.
  SpellAddTargetDebuff(siphon_life siphon_life=1)
Define(soul_fire 6353)
# Burns the enemy's soul, dealing (420 of Spell Power) Fire damage and applying Immolate.rnrn|cFFFFFFFFGenerates 281490s1/10 Soul Shard.|r
  SpellInfo(soul_fire cd=45 talent=soul_fire_talent)
Define(soul_strike 264057)
# Command your Felguard to strike into the soul of its enemy, dealing <damage> Shadow damage.?c2[rnrn|cFFFFFFFFGenerates 1 Soul Shard.|r][]
  SpellInfo(soul_strike cd=10 talent=soul_strike_talent)
Define(summon_darkglare 205180)
# Summons a Darkglare from the Twisting Nether that extends the duration of your damage over time effects on all enemies by s2 sec.rnrnThe Darkglare will serve you for 20 seconds, blasting its target for (32 of Spell Power) Shadow damage, increased by s3 for every damage over time effect you have active on any target.
  SpellInfo(summon_darkglare cd=180 duration=20 channel=20)
  # Summons a Darkglare from the Twisting Nether that blasts its target for Shadow damage, dealing increased damage for every damage over time effect you have active on any target.
  SpellAddBuff(summon_darkglare summon_darkglare=1)
Define(summon_demonic_tyrant 265187)
# Summon a Demonic Tyrant to increase the duration of all of your current lesser demons by 265273m3/1000 sec, and increase the damage of all of your other demons by 265273s2, while damaging your target.?s334585[rnrn|cFFFFFFFFGenerates s2/10 Soul Shards.|r][]
# Rank 2: Summoning your Demonic Tyrant instantly generates s1 Soul Shards.
  SpellInfo(summon_demonic_tyrant cd=90 duration=15 soulshards=0)
Define(summon_felguard 30146)
# Summons a Felguard under your command as a powerful melee combatant.
  SpellInfo(summon_felguard soulshards=1)
Define(summon_imp 688)
# Summons an Imp under your command that casts ranged Firebolts.
  SpellInfo(summon_imp soulshards=1)
Define(summon_infernal 1122)
# Summons an Infernal from the Twisting Nether, impacting for (60 of Spell Power) Fire damage and stunning all enemies in the area for 2 seconds.rnrnThe Infernal will serve you for 30 seconds, dealing (50 of Spell Power)*(100+137046s3)/100 damage to all nearby enemies every 19483t1 sec and generating 264365s1 Soul Shard Fragment every 264364t1 sec.
# Rank 2: Your Infernal Awakening deals s1 additional damage on impact.
  SpellInfo(summon_infernal cd=180 duration=0.25 channel=0.25)

Define(summon_vilefiend 264119)
# Summon a Vilefiend to fight for you for the next 15 seconds.
  SpellInfo(summon_vilefiend soulshards=1 cd=45 duration=15 talent=summon_vilefiend_talent)
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
Define(unstable_affliction 316099)
# Afflicts one target with o2 Shadow damage over 16 seconds. rnrnIf dispelled, deals m2*s1/100 damage to the dispeller and silences them for 4 seconds.rnrn|cFFFFFFFFGenerates 231791m1 Soul LShard:Shards; if the target dies while afflicted.|r
# Rank 3: Unstable Affliction's duration is increased by 5 seconds.
  SpellInfo(unstable_affliction duration=16 max_stacks=1 tick=2)
  # Suffering w2 Shadow damage every t2 sec. If dispelled, will cause w2*s1/100 damage to the dispeller and silence them for 196364d.
  SpellAddTargetDebuff(unstable_affliction unstable_affliction=1)
Define(vile_taint 278350)
# Unleashes a vile explosion at the target location, dealing o1 Shadow damage over 10 seconds to all enemies within a1 yds and reducing their movement speed by s2.
  SpellInfo(vile_taint soulshards=1 cd=20 duration=10 tick=2 talent=vile_taint_talent)
  # Suffering w1 Shadow damage every t1 sec.rnMovement slowed by s2.
  SpellAddTargetDebuff(vile_taint vile_taint=1)
Define(wild_imp_0 104317)
# Calls down a demonic meteor full of Wild Imps which burst forth to attack the target.rnrnDeals up to m1*86040m1 Shadowflame damage on impact to all enemies within 86040A1 yds of the target?s196283[, applies Doom to each target,][] and summons up to m1*104317m2 Wild Imps, based on Soul Shards consumed.
  SpellInfo(wild_imp_0 duration=20 gcd=0 offgcd=1)
Define(wild_imp_1 279910)
# Calls down a demonic meteor full of Wild Imps which burst forth to attack the target.rnrnDeals up to m1*86040m1 Shadowflame damage on impact to all enemies within 86040A1 yds of the target?s196283[, applies Doom to each target,][] and summons up to m1*104317m2 Wild Imps, based on Soul Shards consumed.
  SpellInfo(wild_imp_1 duration=20 gcd=0 offgcd=1)
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
SpellList(blood_fury blood_fury_0 blood_fury_1 blood_fury_2 blood_fury_3)
SpellList(blood_of_the_enemy blood_of_the_enemy_0 blood_of_the_enemy_1 blood_of_the_enemy_2 blood_of_the_enemy_3)
SpellList(concentrated_flame concentrated_flame_0 concentrated_flame_1 concentrated_flame_2 concentrated_flame_3 concentrated_flame_4 concentrated_flame_5 concentrated_flame_6)
SpellList(corruption corruption_0 corruption_1)
SpellList(fireblood fireblood_0 fireblood_1)
SpellList(focused_azerite_beam focused_azerite_beam_0 focused_azerite_beam_1 focused_azerite_beam_2 focused_azerite_beam_3)
SpellList(grimoire_of_sacrifice grimoire_of_sacrifice_0 grimoire_of_sacrifice_1)
SpellList(guardian_of_azeroth guardian_of_azeroth_0 guardian_of_azeroth_1 guardian_of_azeroth_2 guardian_of_azeroth_3 guardian_of_azeroth_4 guardian_of_azeroth_5)
SpellList(memory_of_lucid_dreams memory_of_lucid_dreams_0 memory_of_lucid_dreams_1 memory_of_lucid_dreams_2)
SpellList(phantom_singularity phantom_singularity_0 phantom_singularity_1)
SpellList(purifying_blast purifying_blast_0 purifying_blast_1 purifying_blast_2 purifying_blast_3 purifying_blast_4 purifying_blast_5)
SpellList(reaping_flames reaping_flames_0 reaping_flames_1 reaping_flames_2 reaping_flames_3 reaping_flames_4)
SpellList(reckless_force_buff reckless_force_buff_0 reckless_force_buff_1)
SpellList(ripple_in_space ripple_in_space_0 ripple_in_space_1 ripple_in_space_2 ripple_in_space_3)
SpellList(shadow_bolt shadow_bolt_0 shadow_bolt_1 shadow_bolt_2)
SpellList(the_unbound_force the_unbound_force_0 the_unbound_force_1 the_unbound_force_2 the_unbound_force_3)
SpellList(worldvein_resonance worldvein_resonance_0 worldvein_resonance_1 worldvein_resonance_2 worldvein_resonance_3)
SpellList(wild_imp wild_imp_0 wild_imp_1)
Define(bilescourge_bombers_talent 2) #22048
# Tear open a portal to the nether above the target location, from which several Bilescourge will pour out of and crash into the ground over 6 seconds, dealing (23 of Spell Power) Shadow damage to all enemies within 267213A1 yards.
Define(cataclysm_talent 12) #23143
# Calls forth a cataclysm at the target location, dealing (180 of Spell Power) Shadowflame damage to all enemies within A1 yards and afflicting them with ?s980[Agony and Unstable Affliction][]?s104315[Corruption][]?s348[Immolate][]?!s980&!s104315&!s348[Agony, Unstable Affliction, Corruption, or Immolate][].
Define(channel_demonfire_talent 20) #23144
# Launches s1 bolts of felfire over 3 seconds at random targets afflicted by your Immolate within 196449A1 yds. Each bolt deals (19.36 of Spell Power) Fire damage to the target and (7.7 of Spell Power) Fire damage to nearby enemies.
Define(dark_soul_instability_talent 21) #23092
# Infuses your soul with unstable power, increasing your critical strike chance by 113858s1 for 20 seconds.?s56228[rnrn|cFFFFFFFFPassive:|rrnIncreases your critical strike chance by 113858m1/56228m1. This effect is disabled while on cooldown.][]
Define(dark_soul_misery_talent 21) #19293
# Infuses your soul with the misery of fallen foes, increasing haste by (25 of Spell Power) for 20 seconds.
Define(demonic_consumption_talent 20) #22479
# Your Demon Commander now drains 267971s2 of the life from your demon servants to empower himself.
Define(demonic_strength_talent 3) #23138
# Infuse your Felguard with demonic strength and command it to charge your target and unleash a Felstorm that will deal s2 increased damage.
Define(doom_talent 6) #23158
# Inflicts impending doom upon the target, causing o1 Shadow damage after 20 seconds.rnrn|cFFFFFFFFDoom damage generates 1 Soul Shard.|r
Define(drain_soul_talent 3) #23141
# Drains the target's soul, causing o1 Shadow damage over 5 seconds.rnrnDamage is increased by s2 against enemies below s3 health.rnrn|cFFFFFFFFGenerates 1 Soul Shard if the target dies during this effect.|r
Define(eradication_talent 2) #22090
# Chaos Bolt increases the damage you deal to the target by 196414s1 for 7 seconds.
Define(fire_and_brimstone_talent 11) #22043
# Incinerate now also hits all enemies near your target for s1 damage and generates s2 Soul Shard LFragment:Fragments; for each additional enemy hit.
Define(flashover_talent 1) #22038
# Conflagrate deals s3 increased damage and grants an additional charge of Backdraft.
Define(grimoire_of_sacrifice_talent 18) #19295
# Sacrifices your demon pet for power, gaining its command demon ability, and causing your spells to sometimes also deal (43.75 of Spell Power) additional Shadow damage.rnrnLasts 3600 seconds or until you summon a demon pet.
Define(grimoire_felguard_talent 18) #21717
# Summons a Felguard who attacks the target for 17 seconds that deals 216187s1 increased damage.rnrnThis Felguard will stun their target when summoned.
Define(haunt_talent 17) #23159
# A ghostly soul haunts the target, dealing (68.75 of Spell Power) Shadow damage and increasing your damage dealt to the target by s2 for 18 seconds.rnrnIf the target dies, Haunt's cooldown is reset.
Define(inferno_talent 10) #22480
# Rain of Fire damage is increased by s2 and has a s1 chance to generate a Soul Shard Fragment.
Define(inner_demons_talent 17) #23146
# You passively summon a Wild Imp to fight for you every t1 sec, and have a s1 chance to also summon an additional Demon to fight for you for s2 sec.
Define(internal_combustion_talent 5) #21695
# Chaos Bolt consumes up to s1 sec of Immolate's damage over time effect on your target, instantly dealing that much damage.
Define(nether_portal_talent 21) #23091
# Tear open a portal to the Twisting Nether for 15 seconds. Every time you spend Soul Shards, you will also command demons from the Nether to come out and fight for you.
Define(phantom_singularity_talent 11) #19292
# Places a phantom singularity above the target, which consumes the life of all enemies within 205246A2 yards, dealing 8*(22.5 of Spell Power) damage over 16 seconds, healing you for 205246e2*100 of the damage done.
Define(power_siphon_talent 5) #21694
# Instantly sacrifice up to s1 Wild Imps, generating s1 charges of Demonic Core that cause Demonbolt to deal 334581s1 additional damage.
Define(shadowburn_talent 6) #23157
# Blasts a target for (130 of Spell Power) Shadowflame damage, gaining s3 critical strike chance on targets that have 20 or less health.rnrn|cFFFFFFFFRestores 245731s1/10 Soul Shard if the target dies within 5 seconds.|r
Define(siphon_life_talent 6) #22089
# Siphons the target's life essence, dealing o1 Shadow damage over 15 seconds and healing you for e1*100 of the damage done.
Define(soul_fire_talent 3) #22040
# Burns the enemy's soul, dealing (420 of Spell Power) Fire damage and applying Immolate.rnrn|cFFFFFFFFGenerates 281490s1/10 Soul Shard.|r
Define(soul_strike_talent 11) #22042
# Command your Felguard to strike into the soul of its enemy, dealing <damage> Shadow damage.?c2[rnrn|cFFFFFFFFGenerates 1 Soul Shard.|r][]
Define(summon_vilefiend_talent 12) #23160
# Summon a Vilefiend to fight for you for the next 15 seconds.
Define(vile_taint_talent 12) #22046
# Unleashes a vile explosion at the target location, dealing o1 Shadow damage over 10 seconds to all enemies within a1 yds and reducing their movement speed by s2.
    ]]
    code = code .. [[
Define(vilefiend 135816)
  ]]
    OvaleScripts:RegisterScript("WARLOCK", nil, name, desc, code, "include")
end
