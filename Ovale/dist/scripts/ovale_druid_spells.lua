local __exports = LibStub:NewLibrary("ovale/scripts/ovale_druid_spells", 80300)
if not __exports then return end
__exports.registerDruidSpells = function(OvaleScripts)
    local name = "ovale_druid_spells"
    local desc = "[9.0] Ovale: Druid baseline spells"
    local code = [[Define(adaptive_swarm 325748)
# Command a swarm that heals 325748o1 or deals 325733o1 Shadow damage over 12 seconds to a target, and increases the effectiveness of your periodic effects on them by 325748s2.rnrnUpon expiration, jumps to a target within s2 yards, alternating between friend and foe up to s1 times.
  SpellInfo(adaptive_swarm duration=12 channel=12 max_stacks=5 gcd=0 offgcd=1 tick=2)
  # Restoring w1 health every t1 sec and healing over time from the caster increased by w2.
  SpellAddTargetDebuff(adaptive_swarm adaptive_swarm=1)
Define(barkskin 22812)
# Your skin becomes as tough as bark, reducing all damage you take by s1 and preventing damage from delaying your spellcasts. Lasts 8 seconds.rnrnUsable while stunned, frozen, incapacitated, feared, or asleep, and in all shapeshift forms.
# Rank 2: Duration increased by s1/1000 sec.
  SpellInfo(barkskin cd=60 duration=8 gcd=0 offgcd=1 tick=1)
  # All damage taken reduced by w1.
  SpellAddBuff(barkskin barkskin=1)
Define(bear_form 5487)
# Shapeshift into Bear Form, increasing armor by m4 and Stamina by 1178s2, granting protection from Polymorph effects, and increasing threat generation.rnrnThe act of shapeshifting frees you from movement impairing effects.
# Rank 2: Bear Form gives an additional s1 Stamina.rn
  SpellInfo(bear_form)
  # Armor increased by w4.rnStamina increased by 1178s2.rnImmune to Polymorph effects.
  SpellAddBuff(bear_form bear_form=1)
  # Armor increased by w4.rnStamina increased by 1178s2.rnImmune to Polymorph effects.
  SpellAddTargetDebuff(bear_form bear_form=1)
Define(berserk_0 50334)
# Go berserk for 15 seconds, reducing the cooldowns of Mangle, Thrash, Growl, and Frenzied Regeneration by s1 and the cost of Ironfur by s3.
# Rank 2: Berserk reduces the cooldowns of Mangle, Thrash, Growl, and Frenzied Regeneration by an additional s1.
  SpellInfo(berserk_0 cd=180 duration=15 gcd=0 offgcd=1)
  # Cooldowns of Mangle, Thrash, Growl, and Frenzied Regeneration are reduced by w1. Ironfur cost reduced by w3.
  SpellAddBuff(berserk_0 berserk_0=1)
Define(berserk_1 106951)
# Go berserk for 20 seconds, causing Rake and Shred to deal damage as though you were stealthed, and giving finishing moves a s1 chance per combo point spent to refund 343216s1 combo lpoint:points;.
  SpellInfo(berserk_1 cd=180 duration=20 gcd=0 offgcd=1)
  # Rake and Shred deal damage as though you were stealthed. rnrnFinishing moves have a w1 chance per combo point spent to refund 343216s1 combo lpoint:points;.
  SpellAddBuff(berserk_1 berserk_1=1)
Define(berserking 59621)
# Permanently enchant a melee weapon to sometimes increase your attack power by 59620s1, but at the cost of reduced armor. Cannot be applied to items higher than level ecix
  SpellInfo(berserking gcd=0 offgcd=1)
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
Define(bloodtalons 319439)
# When you use s2 different combo point-generating abilities within s1 sec, the damage of your next 145152n Rips or Ferocious Bites is increased by 145152s1.
  SpellInfo(bloodtalons channel=0 gcd=0 offgcd=1 talent=bloodtalons_talent)
  SpellAddBuff(bloodtalons bloodtalons=1)
Define(brutal_slash 202028)
# Strikes up to s3 nearby enemies with a massive slash, inflicting s2 Physical damage.rnrn|cFFFFFFFFAwards s1 combo lpoint:points;.|r
  SpellInfo(brutal_slash energy=25 cd=8 gcd=1 combopoints=-1 talent=brutal_slash_talent)
Define(cat_form 768)
# Shapeshift into Cat Form, increasing auto-attack damage by (25 of Spell Power), movement speed by 113636s1, granting protection from Polymorph effects, and reducing falling damage.rnrnThe act of shapeshifting frees you from movement impairing effects.
  SpellInfo(cat_form)
  # Autoattack damage increased by w4.rnImmune to Polymorph effects.rnMovement speed increased by 113636s1 and falling damage reduced.
  SpellAddBuff(cat_form cat_form=1)
Define(celestial_alignment 194223)
# Celestial bodies align, maintaining both Eclipses and granting s1 haste for 20 seconds.
  SpellInfo(celestial_alignment cd=180 duration=20 gcd=0 offgcd=1)
  # Both Eclipses active. Haste increased by w1.
  SpellAddBuff(celestial_alignment celestial_alignment=1)
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

Define(convoke_the_spirits 323764)
# Call upon the Night Fae for an eruption of energy, channeling a rapid flurry of s2 Druid spells and abilities over 4 seconds.rnrnYou will cast ?a24858|a197625[Starsurge, Starfall,]?a768[Ferocious Bite, Shred, Tiger's Fury,]?a5487[Mangle, Ironfur,][Wild Growth, Swiftmend,] Moonfire, Wrath, Regrowth, Rejuvenation, Rake and Thrash on appropriate nearby targets, favoring your current shapeshift form.
  SpellInfo(convoke_the_spirits cd=120 duration=4 channel=4 max_stacks=99 tick=0.333)
  # Every t1.2 sec, casting ?a24858|a197625[Starsurge, Starfall,]?a768[Ferocious Bite, Shred, Tiger's Fury,]?a5487[Mangle, Ironfur,][Wild Growth, Swiftmend,] Moonfire, Wrath, Regrowth, Rejuvenation, Rake or Thrash on appropriate nearby targets.
  SpellAddBuff(convoke_the_spirits convoke_the_spirits=1)
Define(eclipse_lunar 48518)
# Casting s1 lStarfire:Starfires; empowers Wrath for 15 seconds. Casting s1 lWrath:Wraths; empowers Starfire for 15 seconds. These Eclipses occur in alternation.rnrn@spellicon48517 @spellname48517rnWrath cast time reduced 48517s1 and damage increased 48517s2.rnrn@spellicon48518 @spellname48518rnStarfire cast time reduced 48518s1 and critical strike chance increased 48518s2.
  SpellInfo(eclipse_lunar duration=15 channel=15 gcd=0 offgcd=1)
  # Starfire cast time reduced w1?<w5>0>[, area effect damage increased w5,][] and critical strike chance increased w2.
  SpellAddBuff(eclipse_lunar eclipse_lunar=1)
Define(eclipse_solar 48517)
# Casting s1 lStarfire:Starfires; empowers Wrath for 15 seconds. Casting s1 lWrath:Wraths; empowers Starfire for 15 seconds. These Eclipses occur in alternation.rnrn@spellicon48517 @spellname48517rnWrath cast time reduced 48517s1 and damage increased 48517s2.rnrn@spellicon48518 @spellname48518rnStarfire cast time reduced 48518s1 and critical strike chance increased 48518s2.
  SpellInfo(eclipse_solar duration=15 channel=15 gcd=0 offgcd=1)
  # Wrath cast time reduced w1?<w5>0>[, Astral Power generation increased w5,][] and damage increased w2.
  SpellAddBuff(eclipse_solar eclipse_solar=1)
Define(empower_bond_0 326446)
# Empower the bond for 10 seconds:rnrn?c3[|cFFFFFFFFTank|rrnProtect your bonded partner, redirecting s1 of damage they take to you, unless you fall below s3 health.]?c4[|cFFFFFFFFHealer|rrnFocus on your bonded partner, replicating 327148s1 of all healing you deal onto them.][|cFFFFFFFFDamager|rrnEnergize your bonded partner, granting them 327139s1 of your damage as additional Arcane damage, healing, or absorption.]rnrn|cFFFFFFFFDamager Partner|rrnThey energize you, granting you 327139s1 of their damage as additional Arcane damage, healing, or absorption.
  SpellInfo(empower_bond_0 cd=60 gcd=0 offgcd=1)
Define(empower_bond_1 326462)
# Empower the bond for 10 seconds:rnrn?c3[|cFFFFFFFFTank|rrnProtect your bonded partner, redirecting s1 of damage they take to you, unless you fall below s3 health.]?c4[|cFFFFFFFFHealer|rrnFocus on your bonded partner, replicating 327148s1 of all healing you deal onto them.][|cFFFFFFFFDamager|rrnEnergize your bonded partner, granting them 327139s1 of your damage as additional Arcane damage, healing, or absorption.]rnrn|cFFFFFFFFTank Partner|rrnThey protect you, redirecting 327037s1 of damage you take to them, for 10 seconds or until they fall below 327037s3 health.
  SpellInfo(empower_bond_1 cd=60 gcd=0 offgcd=1)
Define(empower_bond_2 326647)
# Empower the bond for 10 seconds:rnrn?c3[|cFFFFFFFFTank|rrnProtect your bonded partner, redirecting s1 of damage they take to you, unless you fall below s3 health.]?c4[|cFFFFFFFFHealer|rrnFocus on your bonded partner, replicating 327148s1 of all healing you deal onto them.][|cFFFFFFFFDamager|rrnEnergize your bonded partner, granting them 327139s1 of your damage as additional Arcane damage, healing, or absorption.]rnrn|cFFFFFFFFHealer Partner|rrnThey focus on you, replicating 327148s2 of all healing they deal onto you.
  SpellInfo(empower_bond_2 cd=60 gcd=0 offgcd=1)
Define(feral_frenzy 274837)
# Unleash a furious frenzy, clawing your target m2 times for 274838s1*m2 Physical damage and an additional m2*274838s3*6 seconds/274838t3 Bleed damage over 6 seconds.rnrn|cFFFFFFFFAwards s1 combo points.|r
  SpellInfo(feral_frenzy energy=25 cd=45 duration=1 gcd=1 tick=0.2 talent=feral_frenzy_talent)
  SpellAddBuff(feral_frenzy feral_frenzy=1)
Define(ferocious_bite 22568)
# Finishing move that causes Physical damage per combo point and consumes up to ?a102543[s2*(1+(25 of Spell Power)/100)][s2] additional Energy to increase damage by up to 100.rnrn?s202031[Ferocious Bite will also refresh the duration of your Rip on your target.rnrn][]   1 point  : m1*1/5 damagern   2 points: m1*2/5 damagern   3 points: m1*3/5 damagern   4 points: m1*4/5 damagern   5 points: m1*5/5 damage
  SpellInfo(ferocious_bite energy=25 combopoints=1 gcd=1)
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
Define(force_of_nature 205636)
# Summons a stand of s1 Treants for 10 seconds which immediately taunt and attack enemies in the targeted area.rnrn|cFFFFFFFFGenerates m5/10 Astral Power.|r
  SpellInfo(force_of_nature cd=60 lunarpower=-20 talent=force_of_nature_talent)
  # Granting s5/10*d Astral Power over d.
  SpellAddBuff(force_of_nature force_of_nature=1)

Define(full_moon_0 202771)
# Deals m1 Arcane damage to the target and reduced damage to all other nearby enemies, and resets Full Moon to become New Moon.rnrn|cFFFFFFFFGenerates m2/10 Astral Power.|r
  SpellInfo(full_moon_0 cd=15 lunarpower=-40)
Define(full_moon_1 274283)
# Deals m1 Astral damage to the target and nearby enemies, and resets Full Moon to become New Moon. Deals reduced damage to secondary targets.rnrn|cFFFFFFFFGenerates m2/10 Astral Power.|r
  SpellInfo(full_moon_1 cd=25 lunarpower=-40)
Define(fury_of_elune 202770)
# Calls down a beam of pure celestial energy that follows the enemy, dealing up to <dmg> Astral damage over 8 seconds within its area. Damage reduced on secondary targets.rnrn|cFFFFFFFFGenerates m3/10/t3*8 seconds Astral Power over its duration.|r
  SpellInfo(fury_of_elune cd=60 duration=8 tick=0.5 talent=fury_of_elune_talent)
  # Generating m3/10/t3*d Astral Power over d.
  SpellAddBuff(fury_of_elune fury_of_elune=1)
Define(galactic_guardian 203964)
# Your damage has a h chance to trigger a free automatic Moonfire on that target. rnrnWhen this occurs, the next Moonfire you cast generates 213708m1/10 Rage, and deals 213708s3 increased direct damage.
  SpellInfo(galactic_guardian channel=0 gcd=0 offgcd=1 talent=galactic_guardian_talent)
  SpellAddBuff(galactic_guardian galactic_guardian=1)
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

Define(half_moon_0 202768)
# Deals m1 Arcane damage to the target and empowers Half Moon to become Full Moon.rnrn|cFFFFFFFFGenerates m3/10 Astral Power.|r
  SpellInfo(half_moon_0 cd=15 lunarpower=-20)
Define(half_moon_1 274282)
# Deals (150 of Spell Power) Astral damage to the target and empowers Half Moon to become Full Moon.rnrn|cFFFFFFFFGenerates m3/10 Astral Power.|r
  SpellInfo(half_moon_1 cd=25 lunarpower=-20)
Define(heart_of_the_wild_0 108291)
# Abilities associated with your chosen Affinity are substantially empowered for 45 seconds.?s197492[rnrn|cFFFFFFFFRestoration:|r Healing of your Restoration spells increased by 108294s1, and mana costs reduced by 108294s3.]?s197490|s202155|s202157[rnrn|cFFFFFFFFFeral:|r Damage of your Feral abilities increased by 108292s1, and critical strikes with attacks that generate a combo point generate an additional combo point.]?s197632|s197488[rnrn|cFFFFFFFFBalance:|r Damage of your Balance abilities increased by 108291s1, and Starsurge is instant.]?s217615|s197491[rnrn|cFFFFFFFFGuardian:|r Bear Form gives an additional 108293s1 Stamina, multiple uses of Ironfur may overlap, and Frenzied Regeneration has 108293s3+1 charges.][]rn
  SpellInfo(heart_of_the_wild_0 cd=300 duration=45)
  # Damage of your Balance spells increased by s1, and Starsurge is instant.
  SpellAddBuff(heart_of_the_wild_0 heart_of_the_wild_0=1)
Define(heart_of_the_wild_1 108292)
# Abilities associated with your chosen Affinity are substantially empowered for 45 seconds.?s197492[rnrn|cFFFFFFFFRestoration:|r Healing of your Restoration spells increased by 108294s1, and mana costs reduced by 108294s3.]?s197490|s202155|s202157[rnrn|cFFFFFFFFFeral:|r Damage of your Feral abilities increased by 108292s1, and critical strikes with attacks that generate a combo point generate an additional combo point.]?s197632|s197488[rnrn|cFFFFFFFFBalance:|r Damage of your Balance abilities increased by 108291s1, and Starsurge is instant.]?s217615|s197491[rnrn|cFFFFFFFFGuardian:|r Bear Form gives an additional 108293s1 Stamina, multiple uses of Ironfur may overlap, and Frenzied Regeneration has 108293s3+1 charges.][]rn
  SpellInfo(heart_of_the_wild_1 cd=300 duration=45)
  # Damage of your Feral abilities increased by s1, and critical strikes with attacks that generate a combo point generate an additional combo point.
  SpellAddBuff(heart_of_the_wild_1 heart_of_the_wild_1=1)
Define(heart_of_the_wild_2 108293)
# Abilities associated with your chosen Affinity are substantially empowered for 45 seconds.?s197492[rnrn|cFFFFFFFFRestoration:|r Healing of your Restoration spells increased by 108294s1, and mana costs reduced by 108294s3.]?s197490|s202155|s202157[rnrn|cFFFFFFFFFeral:|r Damage of your Feral abilities increased by 108292s1, and critical strikes with attacks that generate a combo point generate an additional combo point.]?s197632|s197488[rnrn|cFFFFFFFFBalance:|r Damage of your Balance abilities increased by 108291s1, and Starsurge is instant.]?s217615|s197491[rnrn|cFFFFFFFFGuardian:|r Bear Form gives an additional 108293s1 Stamina, multiple uses of Ironfur may overlap, and Frenzied Regeneration has 108293s3+1 charges.][]rn
  SpellInfo(heart_of_the_wild_2 cd=300 duration=45)
  # Bear Form gives an additional s1 Stamina, multiple uses of Ironfur may overlap, and Frenzied Regeneration gains an extra charge.
  SpellAddBuff(heart_of_the_wild_2 heart_of_the_wild_2=1)
Define(heart_of_the_wild_3 108294)
# Abilities associated with your chosen Affinity are substantially empowered for 45 seconds.?s197492[rnrn|cFFFFFFFFRestoration:|r Healing of your Restoration spells increased by 108294s1, and mana costs reduced by 108294s3.]?s197490|s202155|s202157[rnrn|cFFFFFFFFFeral:|r Damage of your Feral abilities increased by 108292s1, and critical strikes with attacks that generate a combo point generate an additional combo point.]?s197632|s197488[rnrn|cFFFFFFFFBalance:|r Damage of your Balance abilities increased by 108291s1, and Starsurge is instant.]?s217615|s197491[rnrn|cFFFFFFFFGuardian:|r Bear Form gives an additional 108293s1 Stamina, multiple uses of Ironfur may overlap, and Frenzied Regeneration has 108293s3+1 charges.][]rn
  SpellInfo(heart_of_the_wild_3 cd=300 duration=45)
  # Healing of your Restoration spells increased by s1, and mana costs reduced by s3.
  SpellAddBuff(heart_of_the_wild_3 heart_of_the_wild_3=1)
Define(heart_of_the_wild_4 319454)
# Abilities associated with your chosen Affinity are substantially empowered for 45 seconds.?s197492[rnrn|cFFFFFFFFRestoration:|r Healing of your Restoration spells increased by 108294s1, and mana costs reduced by 108294s3.]?s197490|s202155|s202157[rnrn|cFFFFFFFFFeral:|r Damage of your Feral abilities increased by 108292s1, and critical strikes with attacks that generate a combo point generate an additional combo point.]?s197632|s197488[rnrn|cFFFFFFFFBalance:|r Damage of your Balance abilities increased by 108291s1, and Starsurge is instant.]?s217615|s197491[rnrn|cFFFFFFFFGuardian:|r Bear Form gives an additional 108293s1 Stamina, multiple uses of Ironfur may overlap, and Frenzied Regeneration has 108293s3+1 charges.][]rn
  SpellInfo(heart_of_the_wild_4 cd=300 duration=45 talent=heart_of_the_wild_talent)
  # Abilities associated with your chosen Affinity are substantially empowered.
  SpellAddBuff(heart_of_the_wild_4 heart_of_the_wild_4=1)
Define(incapacitating_roar 99)
# Shift into Bear Form and invoke the spirit of Ursol to let loose a deafening roar, incapacitating all enemies within A1 yards for 3 seconds. Damage will cancel the effect.
  SpellInfo(incapacitating_roar cd=30 duration=3)
  # Incapacitated.
  SpellAddTargetDebuff(incapacitating_roar incapacitating_roar=1)
Define(incarnation 117679)
# Activates a superior shapeshifting form appropriate to your specialization for 30 seconds.  You may freely shapeshift in and out of this form for its duration.
  SpellInfo(incarnation duration=30 gcd=0 offgcd=1)
  # Incarnation: Tree of Life activated.
  SpellAddBuff(incarnation incarnation=1)
Define(incarnation_guardian_of_ursoc 102558)
# An improved Bear Form that grants the benefits of Berserk, causes Mangle to hit up to (25 of Spell Power) targets, and increases maximum health by s5.rnrnLasts 30 seconds. You may freely shapeshift in and out of this improved Bear Form for its duration.
  SpellInfo(incarnation_guardian_of_ursoc cd=180 duration=30 gcd=0 offgcd=1 talent=incarnation_guardian_of_ursoc_talent)
  # Cooldowns of Mangle, Thrash, Growl, and Frenzied Regeneration are reduced by w1.rnIronfur cost reduced by w3.rnMangle hits up to w6 targets.rnHealth increased by w5.
  SpellAddBuff(incarnation_guardian_of_ursoc incarnation_guardian_of_ursoc=1)
Define(incarnation_king_of_the_jungle 102543)
# An improved Cat Form that grants the benefits of Berserk, reduces the Energy cost of all Cat Form abilities by (25 of Spell Power), and allows the use of Prowl once while in combat.rnrnLasts 30 seconds. You may shapeshift in and out of this improved Cat Form for its duration.
  SpellInfo(incarnation_king_of_the_jungle cd=180 duration=30 gcd=0 offgcd=1 talent=incarnation_king_of_the_jungle_talent)
  # Rake and Shred deal damage as though you were stealthed.rnrnFinishing moves have a w1 chance per combo point spent to refund 343216s1 combo lpoint:points;.rnrnEnergy costs reduced by w2.
  SpellAddBuff(incarnation_king_of_the_jungle incarnation_king_of_the_jungle=1)
Define(iron_jaws 276026)
# Ferocious Bite has a s2 chance per combo point to increase the damage of your next Maim by s1 per combo point.
  SpellInfo(iron_jaws duration=30 channel=30 gcd=0 offgcd=1)
  # Your next Maim will deal an additional w1 damage per combo point.
  SpellAddBuff(iron_jaws iron_jaws=1)

Define(ironfur 192081)
# Increases armor by s1*AGI/100 for 7 seconds.?a231070[ Multiple uses of this ability may overlap.][]
# Rank 2: Multiple uses of Ironfur may overlap.rn
  SpellInfo(ironfur rage=40 cd=0.5 duration=7 max_stacks=1 gcd=0 offgcd=1)
  # Armor increased by w1*AGI/100.
  SpellAddBuff(ironfur ironfur=1)
Define(kindred_spirits 56315)
# Increases your maximum Focus and your pet's maximum Focus by (25 of Spell Power).
  SpellInfo(kindred_spirits channel=0 gcd=0 offgcd=1)
  SpellAddBuff(kindred_spirits kindred_spirits=1)
Define(lunar_inspiration 155580)
# Moonfire is usable in Cat Form, costs 155625c energy, and generates 155625s3 combo lpoint:points;.
  SpellInfo(lunar_inspiration channel=0 gcd=0 offgcd=1 talent=lunar_inspiration_talent)
  SpellAddBuff(lunar_inspiration lunar_inspiration=1)
Define(lycaras_fleeting_glimpse 340060)
# Every s1 sec while in combat, cast a spell based on your form:rnrnNo Form: @spellname48438rnCat Form: @spellname285381rnBear Form: @spellname22812rnMoonkin Form: @spellname191034rnTravel Form: @spellname77764
  SpellInfo(lycaras_fleeting_glimpse duration=5 gcd=0 offgcd=1 tick=1)
  # You feel Lycara's inspiration arriving.
  SpellAddBuff(lycaras_fleeting_glimpse lycaras_fleeting_glimpse=1)
Define(maim 22570)
# Finishing move that causes Physical damage and stuns the target. Damage and duration increased per combo point:rnrn   1 point  : s2*1 damage, 1 secrn   2 points: s2*2 damage, 2 secrn   3 points: s2*3 damage, 3 secrn   4 points: s2*4 damage, 4 secrn   5 points: s2*5 damage, 5 sec
  SpellInfo(maim energy=30 combopoints=1 cd=20 gcd=1)
  # Stunned.
  SpellAddBuff(maim maim=1)
Define(mangle 33917)
# Mangle the target for s2 Physical damage.?a231064[ Deals s3 additional damage against bleeding targets.][]rnrn|cFFFFFFFFGenerates m4/10 Rage.|r
# Rank 2: Mangle deals 33917s3 additional damage against bleeding targets.
  SpellInfo(mangle cd=6 rage=-10)
Define(maul 6807)
# Maul the target for s2 Physical damage.
  SpellInfo(maul rage=40)
Define(memory_of_lucid_dreams_0 299300)
# Infuse your Heart of Azeroth with Memory of Lucid Dreams.
  SpellInfo(memory_of_lucid_dreams_0)
Define(memory_of_lucid_dreams_1 299302)
# Infuse your Heart of Azeroth with Memory of Lucid Dreams.
  SpellInfo(memory_of_lucid_dreams_1)
Define(memory_of_lucid_dreams_2 299304)
# Infuse your Heart of Azeroth with Memory of Lucid Dreams.
  SpellInfo(memory_of_lucid_dreams_2)
Define(mighty_bash 5211)
# Invokes the spirit of Ursoc to stun the target for 4 seconds. Usable in all shapeshift forms.
  SpellInfo(mighty_bash cd=60 duration=4 talent=mighty_bash_talent)
  # Stunned.
  SpellAddTargetDebuff(mighty_bash mighty_bash=1)
Define(moonfire 8921)
# A quick beam of lunar light burns the enemy for (20 of Spell Power) Arcane damage and then an additional 164812o2 Arcane damage over 12 seconds.?s197911[rnrn|cFFFFFFFFGenerates m3/10 Astral Power.|r][]
# Rank 3: Moonfire and Sunfire duration increased by s1/1000 sec.
  SpellInfo(moonfire rage=0 lunarpower=0)
Define(moonkin_form 24858)
# Shapeshift into ?s114301[Astral Form][Moonkin Form], increasing the damage of your spells by s9 and your armor by m3, and granting protection from Polymorph effects.?a231042[rnrnWhile in this form, single-target attacks against you have a h chance to make your next Starfire instant.][]rnrnThe act of shapeshifting frees you from movement impairing effects.
# Rank 2: While in Moonkin Form, single-target attacks against you have a s1 chance make your next Starfire instant.rn
  SpellInfo(moonkin_form)
  # Spell damage increased by s9.rnImmune to Polymorph effects.?w3>0[rnArmor increased by w3.][]
  SpellAddBuff(moonkin_form moonkin_form=1)
Define(new_moon 274281)
# Deals m1 Astral damage to the target and empowers New Moon to become Half Moon. rnrn|cFFFFFFFFGenerates m3/10 Astral Power.|r
  SpellInfo(new_moon cd=25 gcd=1 lunarpower=-10 talent=new_moon_talent)
Define(oath_of_the_elder_druid 338643)
# Effects of Thick Hide, Astral Influence, Feline Swiftness, and Ysera's Gift increased by s1.rnrnWhen you shift into your Affinity's form, you gain Heart of the Wild for s2 sec, once every 60 seconds.
  SpellInfo(oath_of_the_elder_druid duration=60 gcd=0 offgcd=1)
  # You have recently gained Heart of the Wild from Oath of the Elder Druid.
  SpellAddBuff(oath_of_the_elder_druid oath_of_the_elder_druid=1)
Define(oneths_clear_vision 339797)
# Starsurge has a s1 chance to make Starfall free. Starfall has a s2 chance to make Starsurge free.
  SpellInfo(oneths_clear_vision duration=30 gcd=0 offgcd=1)
  # Your next Starsurge costs no Astral Power.
  SpellAddBuff(oneths_clear_vision oneths_clear_vision=1)
Define(oneths_perception 339800)
# Starsurge has a s1 chance to make Starfall free. Starfall has a s2 chance to make Starsurge free.
  SpellInfo(oneths_perception duration=30 gcd=0 offgcd=1)
  # Your next Starfall costs no Astral Power.
  SpellAddBuff(oneths_perception oneths_perception=1)
Define(primal_wrath 285381)
# Finishing move that deals instant damage and applies Rip to all enemies within A1 yards. Lasts longer per combo point.rnrn   1 point  : s1*2 plus Rip for s2*2 secrn   2 points: s1*3 plus Rip for s2*3 secrn   3 points: s1*4 plus Rip for s2*4 secrn   4 points: s1*5 plus Rip for s2*5 secrn   5 points: s1*6 plus Rip for s2*6 sec
  SpellInfo(primal_wrath energy=20 combopoints=1 gcd=1 talent=primal_wrath_talent)
Define(primordial_arcanic_pulsar 338825)
# Every s1 Astral Power spent grants Celestial Alignment for s2 sec.
  SpellInfo(primordial_arcanic_pulsar max_stacks=10 gcd=0 offgcd=1)
  # w1~ Arcane Power collected by Primordial Arcanic Pulsar.
  SpellAddBuff(primordial_arcanic_pulsar primordial_arcanic_pulsar=1)
Define(prowl_0 5215)
# Shift into Cat Form and enter stealth.
  SpellInfo(prowl_0 cd=6 gcd=0 offgcd=1)
  # Stealthed.
  SpellAddBuff(prowl_0 prowl_0=1)
  # Stealthed.
  SpellAddTargetDebuff(prowl_0 prowl_0=1)
Define(prowl_1 24450)
# Puts your pet in stealth mode, but slows its movement speed by s2. The first attack from stealth receives a (25 of Spell Power) bonus to damage.  Lasts until cancelled.
  SpellInfo(prowl_1 cd=10 gcd=0 offgcd=1)
  # Stealthed.rnMovement speed slowed by s2.
  SpellAddBuff(prowl_1 prowl_1=1)
Define(prowl_2 102547)
# Allows the Druid to vanish from sight, entering an improved stealth mode.  Lasts until cancelled.
  SpellInfo(prowl_2 cd=6 gcd=0 offgcd=1)
  # Stealthed.
  SpellAddBuff(prowl_2 prowl_2=1)
Define(pulverize 80313)
# A devastating blow that consumes s3 stacks of your Thrash on the target to deal s1 Physical damage and reduce the damage they deal to you by s2 for 10 seconds.
  SpellInfo(pulverize cd=45 duration=10 talent=pulverize_talent)
  # Dealing w2 reduced damage to @auracaster.
  SpellAddTargetDebuff(pulverize pulverize=1)
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
Define(rake 1822)
# Rake the target for s1 Bleed damage and an additional 155722o1 Bleed damage over 15 seconds.?s48484[ Reduces the target's movement speed by 58180s1 for 12 seconds.][]?a231052[ rnrnWhile stealthed, Rake will also stun the target for 4 seconds, and deal s4 increased damage.][]rnrn|cFFFFFFFFAwards s2 combo lpoint:points;.|r
# Rank 2: While stealthed, Rake will also stun the target for 4 seconds, and deal 1822s4 increased damage.
  SpellInfo(rake energy=35 gcd=1 combopoints=-1)
  # Bleeding for w1 damage every t1 seconds.
  SpellAddTargetDebuff(rake rake_debuff=1)
Define(rake_debuff 155722)
# Rake the target for s1 Bleed damage and an additional 155722o1 Bleed damage over 15 seconds.?s48484[ Reduces the target's movement speed by 58180s1 for 12 seconds.][]?a231052[ rnrnWhile stealthed, Rake will also stun the target for 4 seconds, and deal s4 increased damage.][]rnrn|cFFFFFFFFAwards s2 combo lpoint:points;.|r
  SpellInfo(rake_debuff duration=15 gcd=0 offgcd=1 tick=3)
  # Bleeding for w1 damage every t1 seconds.
  SpellAddTargetDebuff(rake_debuff rake_debuff=1)
Define(ravenous_frenzy_0 323546)
# For 20 seconds, Druid spells you cast increase your damage and healing by s1, and haste by s3, stacking.rnrnIf you spend s9/10 sec idle, the Frenzy overcomes you, consuming s3 of your health per stack, stunning you for 1 second, and ending.
  SpellInfo(ravenous_frenzy_0 cd=180 duration=20 max_stacks=99 gcd=0 offgcd=1 tick=0.1)
  # ?<w6<1>[Damage and healing increased by w1 and haste increased by w3.rnrnIf you spend s9~/10 sec idle, the Frenzy consumes w3 of your health and ends.][Damage and healing increased by w6 and haste increased by w8.]
  SpellAddBuff(ravenous_frenzy_0 ravenous_frenzy_0=1)
  # ?<w6<1>[Damage and healing increased by w1 and haste increased by w3.rnrnIf you spend s9~/10 sec idle, the Frenzy consumes w3 of your health and ends.][Damage and healing increased by w6 and haste increased by w8.]
  SpellAddTargetDebuff(ravenous_frenzy_0 ravenous_frenzy_0=1)
Define(ravenous_frenzy_1 323557)
# For 20 seconds, Druid spells you cast increase your damage and healing by s1, and haste by s3, stacking.rnrnIf you spend s9/10 sec idle, the Frenzy overcomes you, consuming s3 of your health per stack, stunning you for 1 second, and ending.
  SpellInfo(ravenous_frenzy_1 duration=1 gcd=0 offgcd=1)
  # Stunned.
  SpellAddBuff(ravenous_frenzy_1 ravenous_frenzy_1=1)
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
Define(rip 1079)
# Finishing move that causes Bleed damage over time. Lasts longer per combo point.rnrn   1 point  : o1*2 over 4 seconds*2 secrn   2 points: o1*3 over 4 seconds*3 secrn   3 points: o1*4 over 4 seconds*4 secrn   4 points: o1*5 over 4 seconds*5 secrn   5 points: o1*6 over 4 seconds*6 sec
  SpellInfo(rip energy=20 combopoints=1 duration=4 gcd=1 tick=2)
  # Bleeding for w1 damage every t1 sec.
  SpellAddTargetDebuff(rip rip=1)
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
Define(savage_combatant_buff 340613)
# Mangle increases the damage of your next Maul by |cFFFFFFFFs1.1|r, stacking up to 340613u.
  SpellInfo(savage_combatant_buff duration=15 max_stacks=3 gcd=0 offgcd=1)
  # Your next Maul deals w1 increased damage.
  SpellAddBuff(savage_combatant_buff savage_combatant_buff=1)
Define(savage_roar 52610)
# Finishing move that increases damage by 62071s1 and energy regeneration rate by (25 of Spell Power) while in Cat Form. Lasts longer per combo point:rnrn   1 point  : 12 secondsrn   2 points: 18 secondsrn   3 points: 24 secondsrn   4 points: 30 secondsrn   5 points: 36 seconds
  SpellInfo(savage_roar energy=25 combopoints=1 duration=6 channel=6 gcd=1 tick=2 talent=savage_roar_talent)
  # Damage increased 62071s1 while in Cat Form.rnEnergy regeneration increased by 62071s3.
  SpellAddBuff(savage_roar savage_roar=1)
Define(shadowmeld 58984)
# Activate to slip into the shadows, reducing the chance for enemies to detect your presence. Lasts until cancelled or upon moving. Any threat is restored versus enemies still in combat upon cancellation of this effect.
  SpellInfo(shadowmeld cd=120 channel=-0.001 gcd=0 offgcd=1)
  # Shadowmelded.
  SpellAddBuff(shadowmeld shadowmeld=1)
Define(shred_0 231057)
# While stealthed, Shred deals 5221s3 increased damage, and has double the chance to critically strike.
  SpellInfo(shred_0 channel=0 gcd=0 offgcd=1)
  SpellAddBuff(shred_0 shred_0=1)
Define(shred_1 231063)
# Shred deals 5221s4 increased damage against bleeding targets.
  SpellInfo(shred_1 channel=0 gcd=0 offgcd=1)
  SpellAddBuff(shred_1 shred_1=1)
Define(shred_2 343232)
# While stealthed, Shred generates s1 additional combo lpoint:points;.
  SpellInfo(shred_2 channel=0 gcd=0 offgcd=1)
  SpellAddBuff(shred_2 shred_2=1)
Define(skull_bash 106839)
# You charge and bash the target's skull, interrupting spellcasting and preventing any spell in that school from being cast for 4 seconds.
  SpellInfo(skull_bash cd=15 gcd=0 offgcd=1)
Define(solar_beam 78675)
# Summons a beam of solar light over an enemy target's location, interrupting the target and silencing all enemies within the beam.  Lasts 8 seconds.
  SpellInfo(solar_beam cd=60 duration=8 gcd=0 offgcd=1)
  # Silenced.
  SpellAddBuff(solar_beam solar_beam=1)

Define(solstice_buff 343648)
# During the first 6 seconds of every Eclipse, Shooting Stars fall 343648s1 more often.
  SpellInfo(solstice_buff duration=6 gcd=0 offgcd=1)
  # Shooting Stars fall w1 more often.
  SpellAddBuff(solstice_buff solstice_buff=1)
Define(starfall 191034)
# Calls down waves of falling stars upon enemies within 50286A1 yds, dealing <damage> Astral damage over 8 seconds.?s327541[rnrnExtends the duration of active Moonfires and Sunfires by 327541s1 sec.][]
# Rank 2: Casting Starfall extends the duration of active Moonfires and Sunfires by s1 sec.
  SpellInfo(starfall lunarpower=50 duration=8 tick=8)
  # Calling down falling stars on nearby enemies.
  SpellAddBuff(starfall starfall=1)
Define(starfire 194153)
# Call down a burst of energy, causing (76.5 of Spell Power) Arcane damage to the target, and m1*m3/100 Arcane damage to all other enemies within A1 yards.rnrn|cFFFFFFFFGenerates m2/10 Astral Power.|r
  SpellInfo(starfire lunarpower=-8)
Define(starsurge 78674)
# Launch a surge of stellar energies at the target, dealing (206.99999999999997 of Spell Power) Astral damage, and empowering the damage bonus of any active Eclipse for its duration.
# Rank 2: Starsurge further empowers the damage bonus of any active Eclipse.
  SpellInfo(starsurge lunarpower=30)
Define(stellar_flare 202347)
# Burns the target for (12.5 of Spell Power) Astral damage, and then an additional o2 damage over 24 seconds.rnrn|cFFFFFFFFGenerates m3/10 Astral Power.|r
  SpellInfo(stellar_flare duration=24 lunarpower=-8 tick=2 talent=stellar_flare_talent)
  # Suffering w2 Astral damage every t2 sec.
  SpellAddTargetDebuff(stellar_flare stellar_flare=1)
Define(sudden_ambush_buff 340698)
# Finishing moves have a |cFFFFFFFFs1.1|r chance per combo point spent to make your next Rake or Shred deal damage as though you were stealthed. 
  SpellInfo(sudden_ambush_buff duration=15 max_stacks=1 gcd=0 offgcd=1)
  # Your next Rake or Shred will deal damage as though you were stealthed.
  SpellAddBuff(sudden_ambush_buff sudden_ambush_buff=1)
Define(sunfire 93402)
# A quick beam of solar light burns the enemy for (20 of Spell Power) Nature damage and then an additional 164815o2 Nature damage over 12 seconds?s231050[ to the primary target and all enemies within 164815A2 yards][].?s137013[rnrn|cFFFFFFFFGenerates m3/10 Astral Power.|r][]
# Rank 2: Sunfire now applies its damage over time effect to all enemies within 164815A2 yards.
  SpellInfo(sunfire lunarpower=0)
  # Suffering w2 Nature damage every t2 sec.
  SpellAddBuff(sunfire sunfire=1)
Define(swipe 213764)
# Swipe nearby enemies, inflicting Physical damage. Damage varies by shapeshift form.
# Rank 2: Swipe deals 106785s2 increased damage against bleeding targets.
  SpellInfo(swipe gcd=1)
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
Define(thorns 305496)
# Sprout thorns for 12 seconds on the friendly target. When victim to melee attacks, thorns deals (120 of Spell Power) Nature damage back to the attacker.rnrnAttackers also have their movement speed reduced by 232559s1 for 4 seconds.
# Rank 1: When struck in combat you have a chance to inflict 15438s1 Arcane damage to the attacker.
  SpellInfo(thorns cd=0.5 channel=0 gcd=0 offgcd=1)
  # Deals Nature damage to attackers when hit by melee attacks and reduces their movement speed.
  SpellAddBuff(thorns thorns=1)
Define(tigers_fury 5217)
# Instantly restores s2 Energy, and increases the damage of all your attacks by s1 for their full duration. Lasts 10 seconds.
# Rank 2: Tiger's Fury generates an additional s1 energy.
  SpellInfo(tigers_fury cd=30 duration=10 gcd=0 offgcd=1 energy=-20)
  # Attacks deal s1 additional damage for their full duration.
  SpellAddBuff(tigers_fury tigers_fury=1)
Define(tooth_and_claw_buff 135286)
# Autoattacks have a s1 chance to empower your next Maul, stacking up to 135286u times.rnrnEmpowered Maul deals 135286s1 increased damage and reduces the target's damage to you by 135601s2 for 6 seconds.
  SpellInfo(tooth_and_claw_buff duration=15 channel=15 max_stacks=2 gcd=0 offgcd=1)
  # Your next Maul deals s1 more damage and reduces the target's damage to you by 135601s1~ for 135601d.
  SpellAddBuff(tooth_and_claw_buff tooth_and_claw_buff=1)
Define(typhoon 132469)
# Blasts targets within 61391a1 yards in front of you with a violent Typhoon, knocking them back and dazing them for 6 seconds. Usable in all shapeshift forms.
  SpellInfo(typhoon cd=30)

Define(war_stomp 20549)
# Stuns up to i enemies within A1 yds for 2 seconds.
  SpellInfo(war_stomp cd=90 duration=2 gcd=0 offgcd=1)
  # Stunned.
  SpellAddTargetDebuff(war_stomp war_stomp=1)
Define(warrior_of_elune 202425)
# Your next n Starfires are instant cast and generate s2 increased Astral Power.
  SpellInfo(warrior_of_elune cd=45 channel=-0.001 gcd=0 offgcd=1 talent=warrior_of_elune_talent)
  # Starfire is instant cast and generates s2 increased Astral Power.
  SpellAddBuff(warrior_of_elune warrior_of_elune=1)
Define(wild_charge_0 16979)
# Charge to an enemy, immobilizing them for 4 seconds.
  SpellInfo(wild_charge_0 cd=15 gcd=0 offgcd=1)
  # Immobilized.
  SpellAddBuff(wild_charge_0 wild_charge_0=1)

Define(wild_charge_1 49376)
# Leap behind an enemy, dazing them for 3 seconds.
  SpellInfo(wild_charge_1 cd=15 channel=0 gcd=0 offgcd=1)
  # Dazed.
  SpellAddBuff(wild_charge_1 wild_charge_1=1)

Define(wild_charge_2 102383)
# Bound backward away from your enemies.
  SpellInfo(wild_charge_2 cd=15 gcd=0 offgcd=1)
Define(wild_charge_3 102417)
# Leap forward s2 yards.
  SpellInfo(wild_charge_3 cd=15 channel=0 gcd=0 offgcd=1)
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
Define(wrath 190984)
# Hurl a ball of energy at the target, dealing (60 of Spell Power) Nature damage.?a197911[rnrn|cFFFFFFFFGenerates m2/10 Astral Power.|r][]
  SpellInfo(wrath lunarpower=0)
SpellList(full_moon full_moon_0 full_moon_1)
SpellList(half_moon half_moon_0 half_moon_1)
SpellList(ravenous_frenzy ravenous_frenzy_0 ravenous_frenzy_1)
SpellList(berserk berserk_0 berserk_1)
SpellList(blood_of_the_enemy blood_of_the_enemy_0 blood_of_the_enemy_1 blood_of_the_enemy_2 blood_of_the_enemy_3)
SpellList(clearcasting clearcasting_0 clearcasting_1 clearcasting_2)
SpellList(concentrated_flame concentrated_flame_0 concentrated_flame_1 concentrated_flame_2 concentrated_flame_3 concentrated_flame_4 concentrated_flame_5 concentrated_flame_6)
SpellList(focused_azerite_beam focused_azerite_beam_0 focused_azerite_beam_1 focused_azerite_beam_2 focused_azerite_beam_3)
SpellList(guardian_of_azeroth guardian_of_azeroth_0 guardian_of_azeroth_1 guardian_of_azeroth_2 guardian_of_azeroth_3 guardian_of_azeroth_4 guardian_of_azeroth_5)
SpellList(memory_of_lucid_dreams memory_of_lucid_dreams_0 memory_of_lucid_dreams_1 memory_of_lucid_dreams_2)
SpellList(prowl prowl_0 prowl_1 prowl_2)
SpellList(purifying_blast purifying_blast_0 purifying_blast_1 purifying_blast_2 purifying_blast_3 purifying_blast_4 purifying_blast_5)
SpellList(razor_coral razor_coral_0 razor_coral_1 razor_coral_2 razor_coral_3 razor_coral_4)
SpellList(reaping_flames reaping_flames_0 reaping_flames_1 reaping_flames_2 reaping_flames_3 reaping_flames_4)
SpellList(reckless_force_buff reckless_force_buff_0 reckless_force_buff_1)
SpellList(ripple_in_space ripple_in_space_0 ripple_in_space_1 ripple_in_space_2 ripple_in_space_3)
SpellList(shred shred_0 shred_1 shred_2)
SpellList(the_unbound_force the_unbound_force_0 the_unbound_force_1 the_unbound_force_2 the_unbound_force_3)
SpellList(wild_charge wild_charge_0 wild_charge_1 wild_charge_2 wild_charge_3)
SpellList(worldvein_resonance worldvein_resonance_0 worldvein_resonance_1 worldvein_resonance_2 worldvein_resonance_3)
SpellList(empower_bond empower_bond_0 empower_bond_1 empower_bond_2)
SpellList(heart_of_the_wild heart_of_the_wild_0 heart_of_the_wild_1 heart_of_the_wild_2 heart_of_the_wild_3 heart_of_the_wild_4)
Define(balance_affinity_talent 7) #22163
# You gain:rnrn@spellicon197524 @spellname197524rnIncreases the range of all of your abilities by s1 yards.rnrnYou also learn:rnrn@spellicon197625 @spellname197625rn@spellicon197626 @spellname197626rn@spellicon197628 @spellname197628rn@spellicon197630 @spellname197630rn@spellicon132469@spellname132469
Define(bloodtalons_talent 20) #21649
# When you use s2 different combo point-generating abilities within s1 sec, the damage of your next 145152n Rips or Ferocious Bites is increased by 145152s1.
Define(brambles_talent 1) #22419
# Sharp brambles protect you, absorbing and reflecting up to <shield> damage from each attack.rnrnWhile Barkskin is active, the brambles also deal 213709s1 Nature damage to all nearby enemies every 22812t3 sec.
Define(brutal_slash_talent 17) #21711
# Strikes up to s3 nearby enemies with a massive slash, inflicting s2 Physical damage.rnrn|cFFFFFFFFAwards s1 combo lpoint:points;.|r
Define(feral_affinity_talent_guardian 8) #22156
# You gain:rnrn@spellicon131768 @spellname131768rnIncreases your movement speed by (25 of Spell Power).rnrnYou also learn:rnrn@spellicon1822 @spellname1822rn@spellicon1079 @spellname1079rn@spellicon22570 @spellname22570rnrnYour energy regeneration is increased by s2.
Define(feral_frenzy_talent 21) #21653
# Unleash a furious frenzy, clawing your target m2 times for 274838s1*m2 Physical damage and an additional m2*274838s3*6 seconds/274838t3 Bleed damage over 6 seconds.rnrn|cFFFFFFFFAwards s1 combo points.|r
Define(force_of_nature_talent 3) #22387
# Summons a stand of s1 Treants for 10 seconds which immediately taunt and attack enemies in the targeted area.rnrn|cFFFFFFFFGenerates m5/10 Astral Power.|r
Define(fury_of_elune_talent 20) #21193
# Calls down a beam of pure celestial energy that follows the enemy, dealing up to <dmg> Astral damage over 8 seconds within its area. Damage reduced on secondary targets.rnrn|cFFFFFFFFGenerates m3/10/t3*8 seconds Astral Power over its duration.|r
Define(galactic_guardian_talent 14) #21707
# Your damage has a h chance to trigger a free automatic Moonfire on that target. rnrnWhen this occurs, the next Moonfire you cast generates 213708m1/10 Rage, and deals 213708s3 increased direct damage.
Define(heart_of_the_wild_talent 12) #18577
# Abilities associated with your chosen Affinity are substantially empowered for 45 seconds.?s197492[rnrn|cFFFFFFFFRestoration:|r Healing of your Restoration spells increased by 108294s1, and mana costs reduced by 108294s3.]?s197490|s202155|s202157[rnrn|cFFFFFFFFFeral:|r Damage of your Feral abilities increased by 108292s1, and critical strikes with attacks that generate a combo point generate an additional combo point.]?s197632|s197488[rnrn|cFFFFFFFFBalance:|r Damage of your Balance abilities increased by 108291s1, and Starsurge is instant.]?s217615|s197491[rnrn|cFFFFFFFFGuardian:|r Bear Form gives an additional 108293s1 Stamina, multiple uses of Ironfur may overlap, and Frenzied Regeneration has 108293s3+1 charges.][]rn
Define(incarnation_guardian_of_ursoc_talent 15) #22388
# An improved Bear Form that grants the benefits of Berserk, causes Mangle to hit up to (25 of Spell Power) targets, and increases maximum health by s5.rnrnLasts 30 seconds. You may freely shapeshift in and out of this improved Bear Form for its duration.
Define(incarnation_king_of_the_jungle_talent 15) #21704
# An improved Cat Form that grants the benefits of Berserk, reduces the Energy cost of all Cat Form abilities by (25 of Spell Power), and allows the use of Prowl once while in combat.rnrnLasts 30 seconds. You may shapeshift in and out of this improved Cat Form for its duration.
Define(lunar_inspiration_talent 3) #22365
# Moonfire is usable in Cat Form, costs 155625c energy, and generates 155625s3 combo lpoint:points;.
Define(mighty_bash_talent 10) #21778
# Invokes the spirit of Ursoc to stun the target for 4 seconds. Usable in all shapeshift forms.
Define(new_moon_talent 21) #21655
# Deals m1 Astral damage to the target and empowers New Moon to become Half Moon. rnrn|cFFFFFFFFGenerates m3/10 Astral Power.|r
Define(primal_wrath_talent 18) #22370
# Finishing move that deals instant damage and applies Rip to all enemies within A1 yards. Lasts longer per combo point.rnrn   1 point  : s1*2 plus Rip for s2*2 secrn   2 points: s1*3 plus Rip for s2*3 secrn   3 points: s1*4 plus Rip for s2*4 secrn   4 points: s1*5 plus Rip for s2*5 secrn   5 points: s1*6 plus Rip for s2*6 sec
Define(pulverize_talent 21) #22425
# A devastating blow that consumes s3 stacks of your Thrash on the target to deal s1 Physical damage and reduce the damage they deal to you by s2 for 10 seconds.
Define(sabertooth_talent 2) #22364
# Ferocious Bite deals s1 increased damage and increases the duration of Rip on your target by s2 sec per combo point spent.
Define(savage_roar_talent 14) #18579
# Finishing move that increases damage by 62071s1 and energy regeneration rate by (25 of Spell Power) while in Cat Form. Lasts longer per combo point:rnrn   1 point  : 12 secondsrn   2 points: 18 secondsrn   3 points: 24 secondsrn   4 points: 30 secondsrn   5 points: 36 seconds
Define(soul_of_the_forest_talent 13) #18580
# Eclipse increases Wrath's Astral power generation s1, and increases Starfire's area effect damage by s2.
Define(starlord_talent 14) #21706
# Starsurge and Starfall grant you 279709s1 Haste for 15 seconds.rnrnStacks up to 279709u times. Gaining a stack does not refresh the duration.
Define(stellar_drift_talent 16) #22389
# Increases Starfall's duration by s1/1000 sec, its damage by s2, and allows you to cast while moving while it is active.
Define(stellar_flare_talent 18) #22165
# Burns the target for (12.5 of Spell Power) Astral damage, and then an additional o2 damage over 24 seconds.rnrn|cFFFFFFFFGenerates m3/10 Astral Power.|r
Define(twin_moons_talent 17) #21712
# Moonfire deals s2 increased damage and also hits another nearby enemy within s1 yds of the target.
Define(warrior_of_elune_talent 2) #22386
# Your next n Starfires are instant cast and generate s2 increased Astral Power.
Define(wild_fleshrending_trait 279527)
    ]]
    code = code .. [[
    SpellInfo(berserk_0 replaced_by=incarnation_guardian_of_ursoc talent=incarnation_guardian_of_ursoc_talent specialization=guardian)
Define(frenzied_regeneration 22842)
    SpellInfo(frenzied_regeneration duration=3)
    SpellInfo(frenzied_regeneration max_charges=2 charge_cd=30 specialization=guardian)
    SpellInfo(frenzied_regeneration cd=30 specialization=!guardian)
    SpellAddBuff(frenzied_regeneration frenzied_regeneration=1)
    SpellRequire(frenzied_regeneration unusable 1=stance,!druid_bear_form)
    
    SpellRequire(incapacitating_roar unusable 1=stance,!druid_bear_form)
Define(thrash_bear 77758)
    SpellAddBuff(thrash_bear earthwarden_buff=1 talent=earthwarden_talent)
    SpellAddTargetDebuff(thrash_bear thrash_bear_debuff=1)
Define(thrash_bear_debuff 192090)
    SpellInfo(thrash_bear_debuff duration=15 max_stacks=3)
    SpellRequire(pulverize unusable 1=target_debuff,!thrash_bear_debuff,2)
    SpellAddTargetDebuff(pulverize thrash_bear_debuff=-2)
    ]]
    OvaleScripts:RegisterScript("DRUID", nil, name, desc, code, "include")
end
