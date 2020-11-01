local __exports = LibStub:NewLibrary("ovale/scripts/ovale_shaman_spells", 80300)
if not __exports then return end
__exports.registerShamanSpells = function(OvaleScripts)
    local name = "ovale_shaman_spells"
    local desc = "[9.0] Ovale: Shaman spells"
    local code = [[Define(ancestral_call 274738)
# Invoke the spirits of your ancestors, granting you a random secondary stat for 15 seconds.
  SpellInfo(ancestral_call cd=120 duration=15 gcd=0 offgcd=1)
  SpellAddBuff(ancestral_call ancestral_call=1)
Define(ascendance 114050)
# Transform into a Flame Ascendant for 15 seconds, replacing Chain Lightning with Lava Beam, removing the cooldown on Lava Burst, and increasing the damage of Lava Burst by an amount equal to your critical strike chance.rnrnWhen you transform into the Flame Ascendant, instantly cast a Lava Burst at all enemies affected by your Flame Shock, and refresh your Flame Shock durations to 18 seconds.
  SpellInfo(ascendance cd=180 duration=15 talent=ascendance_talent)
  # Transformed into a powerful Fire ascendant. Chain Lightning is transformed into Lava Beam.
  SpellAddBuff(ascendance ascendance=1)
Define(ascendance_enhancement 114051)
# Transform into an Air Ascendant for 15 seconds, immediately dealing 344548s1 Nature damage to any enemy within 344548A1 yds, reducing the cooldown and cost of Stormstrike by s4, and transforming your auto attack and Stormstrike into Wind attacks which bypass armor and have a s1 yd range.
  SpellInfo(ascendance_enhancement cd=180 duration=15 talent=ascendance_talent_enhancement)
  # Transformed into a powerful Air ascendant. Auto attacks have a 114089r yard range. Stormstrike is empowered and has a 114089r yard range.
  SpellAddBuff(ascendance_enhancement ascendance_enhancement=1)
Define(bag_of_tricks 312411)
# Pull your chosen trick from the bag and use it on target enemy or ally. Enemies take <damage> damage, while allies are healed for <healing>. 
  SpellInfo(bag_of_tricks cd=90)
Define(berserking 59621)
# Permanently enchant a melee weapon to sometimes increase your attack power by 59620s1, but at the cost of reduced armor. Cannot be applied to items higher than level ecix
  SpellInfo(berserking gcd=0 offgcd=1)
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
Define(bloodlust 2825)
# Increases haste by (25 of Spell Power) for all party and raid members for 40 seconds.rnrnAllies receiving this effect will become Sated and unable to benefit from Bloodlust or Time Warp again for 600 seconds.
  SpellInfo(bloodlust cd=300 duration=40 channel=40 gcd=0 offgcd=1)
  # Haste increased by w1.
  SpellAddBuff(bloodlust bloodlust=1)
Define(capacitor_totem 192058)
# Summons a totem at the target location that gathers electrical energy from the surrounding air and explodes after s2 sec, stunning all enemies within 118905A1 yards for 3 seconds.
  SpellInfo(capacitor_totem cd=60 duration=3 gcd=1)
Define(chain_harvest 320674)
# Send a wave of anima at the target, which then jumps to additional nearby targets. Deals (204.99999999999997 of Spell Power) Shadow damage to up to 5 enemies, and restores (315 of Spell Power) health to up to 5 allies.rnrnFor each target critically struck, the cooldown of Chain Harvest is reduced by 5 sec.
  SpellInfo(chain_harvest cd=90)
Define(chain_lightning_0 231722)
# Chain Lightning jumps to s1 additional targets.
  SpellInfo(chain_lightning_0 channel=0 gcd=0 offgcd=1)
  SpellAddBuff(chain_lightning_0 chain_lightning_0=1)
Define(chain_lightning_1 334308)
# Each target hit by Chain Lightning reduces the cooldown of Crash Lightning by m1/1000.1 sec.
  SpellInfo(chain_lightning_1 channel=0 gcd=0 offgcd=1)
  SpellAddBuff(chain_lightning_1 chain_lightning_1=1)
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
Define(crash_lightning 187874)
# Electrocutes all enemies in front of you, dealing s1*<CAP>/AP Nature damage. Hitting 2 or more targets enhances your weapons for 10 seconds, causing Stormstrike and Lava Lash to also deal 195592s1*<CAP>/AP Nature damage to all targets in front of you.  rnrnEach target hit by Crash Lightning increases the damage of your next Stormstrike by s2.
  SpellInfo(crash_lightning cd=9)
  # Stormstrike and Lava Lash deal an additional 195592s1 damage to all targets in front of you.
  SpellAddBuff(crash_lightning crash_lightning=1)
Define(earth_elemental_0 188616)
# Calls forth a Greater Earth Elemental to protect you and your allies for 60 seconds.
  SpellInfo(earth_elemental_0 duration=60 gcd=0 offgcd=1)
Define(earth_elemental_1 198103)
# Calls forth a Greater Earth Elemental to protect you and your allies for 60 seconds.
  SpellInfo(earth_elemental_1 cd=300)
Define(earth_shock 8042)
# Instantly shocks the target with concussive force, causing (210 of Spell Power) Nature damage.?a190493[rnrnEarth Shock will consume all stacks of Fulmination to deal extra Nature damage to your target.][]
  SpellInfo(earth_shock maelstrom=60)
Define(earthen_spike 188089)
# Summons an Earthen Spike under an enemy, dealing s1 Physical damage and increasing Physical and Nature damage you deal to the target by s2 for 10 seconds.
  SpellInfo(earthen_spike cd=20 duration=10 talent=earthen_spike_talent)
  # Suffering s2 increased Nature and Physical damage from the Shaman.
  SpellAddTargetDebuff(earthen_spike earthen_spike=1)
Define(earthquake 61882)
# Causes the earth within a1 yards of the target location to tremble and break, dealing <damage> Physical damage over 6 seconds and sometimes knocking down enemies.
  SpellInfo(earthquake maelstrom=60 duration=6 tick=1)
  SpellAddBuff(earthquake earthquake=1)
Define(echoes_of_great_sundering_buff 336217)
# When you cast Earth Shock, your next Earthquake will deal 336217s2 additional damage.
  SpellInfo(echoes_of_great_sundering_buff duration=15 gcd=0 offgcd=1)
  # Your next Earthquake will deal s2 additional damage.
  SpellAddBuff(echoes_of_great_sundering_buff echoes_of_great_sundering_buff=1)
Define(echoing_shock 320125)
# Shock the target for (65 of Spell Power) Elemental damage and create an ancestral echo, causing your next damage or healing spell to be cast a second time s2/1000.1 sec later for free.
  SpellInfo(echoing_shock cd=30 duration=8 talent=echoing_shock_talent)
  # Your next damage or healing spell will be cast a second time s2/1000.1 sec later for free.
  SpellAddBuff(echoing_shock echoing_shock=1)
Define(elemental_blast 117014)
# Harnesses the raw power of the elements, dealing (140 of Spell Power) Elemental damage and increasing your Critical Strike or Haste by 118522s1 or Mastery by 173184s1*168534bc1 for 10 seconds.?a343725[rnrn|cFFFFFFFFGenerates 343725s10 Maelstrom.|r][]
  SpellInfo(elemental_blast cd=12 talent=elemental_blast_talent_elemental)
Define(fae_transfusion_0 328923)
# Transfer the life force of up to 328928I enemies in the targeted area, dealing (94 of Spell Power)*3 seconds/t2 Nature damage evenly split to each enemy target over 3 seconds. ?a137041[rnrnFully channeling Fae Transfusion generates s4 Lstack:stacks; of Maelstrom Weapon.][]rnrnPressing Fae Transfusion again within 20 seconds will release s1 of all damage from Fae Transfusion, healing up to 328930s2 allies near yourself.
  SpellInfo(fae_transfusion_0 cd=120 duration=3 channel=3 tick=0.5)
  SpellAddBuff(fae_transfusion_0 fae_transfusion_0=1)
Define(fae_transfusion_1 328928)
# Transfer the life force of up to 328928I enemies in the targeted area, dealing (94 of Spell Power)*3 seconds/t2 Nature damage evenly split to each enemy target over 3 seconds. ?a137041[rnrnFully channeling Fae Transfusion generates s4 Lstack:stacks; of Maelstrom Weapon.][]rnrnPressing Fae Transfusion again within 20 seconds will release s1 of all damage from Fae Transfusion, healing up to 328930s2 allies near yourself.
  SpellInfo(fae_transfusion_1 gcd=0 offgcd=1)
Define(fae_transfusion_2 328930)
# Transfer the life force of up to 328928I enemies in the targeted area, dealing (94 of Spell Power)*3 seconds/t2 Nature damage evenly split to each enemy target over 3 seconds. ?a137041[rnrnFully channeling Fae Transfusion generates s4 Lstack:stacks; of Maelstrom Weapon.][]rnrnPressing Fae Transfusion again within 20 seconds will release s1 of all damage from Fae Transfusion, healing up to 328930s2 allies near yourself.
  SpellInfo(fae_transfusion_2)
Define(feral_lunge 196884)
# Lunge at your enemy as a ghostly wolf, biting them to deal 215802s1 Physical damage.
  SpellInfo(feral_lunge cd=30 gcd=0.5 talent=feral_lunge_talent)

Define(feral_spirit 51533)
# Summons two Spirit ?s147783[Raptors][Wolves] that aid you in battle for 15 seconds. They are immune to movement-impairing effects.rnrnFeral Spirit generates one stack of Maelstrom Weapon immediately, and one stack every 333957t1 sec for 15 seconds.
  SpellInfo(feral_spirit cd=120)
Define(fire_elemental 198067)
# Calls forth a Greater Fire Elemental to rain destruction on your enemies for 30 seconds. rnrnWhile the Fire Elemental is active, Flame Shock deals damage 188592s2 faster?a343226[, and newly applied Flame Shocks last 343226s1 longer][].
  SpellInfo(fire_elemental cd=150)
Define(fire_nova 333974)
# Erupt a burst of fiery damage from all targets affected by your Flame Shock, dealing 333977s1 Fire damage to up to 333977I targets within 333977A1 yds of your Flame Shock targets.
  SpellInfo(fire_nova cd=15 talent=fire_nova_talent)
Define(fireblood_0 265221)
# Removes all poison, disease, curse, magic, and bleed effects and increases your ?a162700[Agility]?a162702[Strength]?a162697[Agility]?a162698[Strength]?a162699[Intellect]?a162701[Intellect][primary stat] by 265226s1*3 and an additional 265226s1 for each effect removed. Lasts 8 seconds. ?s195710[This effect shares a 30 sec cooldown with other similar effects.][]
  SpellInfo(fireblood_0 cd=120 gcd=0 offgcd=1)
Define(fireblood_1 265226)
# Increases ?a162700[Agility]?a162702[Strength]?a162697[Agility]?a162698[Strength]?a162699[Intellect]?a162701[Intellect][primary stat] by s1.
  SpellInfo(fireblood_1 duration=8 max_stacks=6 gcd=0 offgcd=1)
  # Increases ?a162700[Agility]?a162702[Strength]?a162697[Agility]?a162698[Strength]?a162699[Intellect]?a162701[Intellect][primary stat] by w1.
  SpellAddBuff(fireblood_1 fireblood_1=1)
Define(flame_shock 188389)
# Sears the target with fire, causing (19.5 of Spell Power) Fire damage and then an additional o2 Fire damage over 18 seconds.
  SpellInfo(flame_shock cd=6 duration=18 tick=2)
  # Suffering w2 Fire damage every t2 sec.
  SpellAddTargetDebuff(flame_shock flame_shock=1)
Define(flametongue_weapon 318038)
# Imbue your ?s33757[off-hand ][]weapon with the element of Fire for 3600 seconds, causing each of your ?s33757[off-hand ][]attacks to deal max((<coeff>*AP),1) additional Fire damage.
  SpellInfo(flametongue_weapon)
  # Each of your ?s33757[off-hand ][]weapon attacks causes up to max((<coeff>*AP),1) additional Fire damage.
  SpellAddBuff(flametongue_weapon flametongue_weapon=1)
Define(frost_shock 196840)
# Chills the target with frost, causing (45 of Spell Power) Frost damage and reducing the target's movement speed by s2 for 6 seconds.?s33757[rnrnFrost Shock shares a cooldown with Flame Shock.][]
  SpellInfo(frost_shock duration=6)
  # Movement speed reduced by s2.
  SpellAddTargetDebuff(frost_shock frost_shock=1)
Define(hailstorm 334195)
# Each stack of Maelstrom Weapon consumed increases the damage of your next Frost Shock by 334196s1, and causes your next Frost Shock to hit 334196m2 additional target per Maelstrom Weapon stack consumed.
  SpellInfo(hailstorm channel=0 gcd=0 offgcd=1 talent=hailstorm_talent)
  SpellAddBuff(hailstorm hailstorm=1)
Define(heroism 32182)
# Increases haste by (25 of Spell Power) for all party and raid members for 40 seconds.rnrnAllies receiving this effect will become Exhausted and unable to benefit from Heroism or Time Warp again for 600 seconds.
  SpellInfo(heroism cd=300 duration=40 channel=40 gcd=0 offgcd=1)
  # Haste increased by w1.
  SpellAddBuff(heroism heroism=1)
Define(hot_hand_buff 215785)
# Melee auto-attacks with Flametongue Weapon active have a h chance to reduce the cooldown of Lava Lash by 215785m2/4 and increase the damage of Lava Lash by 215785m1 for 8 seconds.
  SpellInfo(hot_hand_buff duration=8 gcd=0 offgcd=1)
  # Lava Lash damage increased by s1 and cooldown reduced by s2/4.
  SpellAddBuff(hot_hand_buff hot_hand_buff=1)
Define(ice_strike 342240)
# Strike your target with an icy blade, dealing s1 Frost damage and snaring them by s2 for 6 seconds.rnrnSuccessful Ice Strikes reset the cooldown of your Flame Shock and Frost Shock spells.
  SpellInfo(ice_strike cd=15 duration=6 talent=ice_strike_talent)
  # Movement speed reduced by s2.
  SpellAddTargetDebuff(ice_strike ice_strike=1)
Define(icefury 210714)
# Hurls frigid ice at the target, dealing (82.5 of Spell Power) Frost damage and causing your next n Frost Shocks to deal s2 increased damage and generate 343725s7 Maelstrom.rnrn|cFFFFFFFFGenerates 343725s8 Maelstrom.|r
  SpellInfo(icefury cd=30 duration=15 maelstrom=0 talent=icefury_talent)
  # Frost Shock damage increased by s2.
  SpellAddBuff(icefury icefury=1)
Define(lava_burst 51505)
# Hurls molten lava at the target, dealing (108 of Spell Power) Fire damage.?a231721[ Lava Burst will always critically strike if the target is affected by Flame Shock.][]?a343725[rnrn|cFFFFFFFFGenerates 343725s3 Maelstrom.|r][]
# Rank 2: Lava Burst will always critically strike if the target is affected by Flame Shock.
  SpellInfo(lava_burst cd=8 maelstrom=0)

Define(lava_lash 60103)
# Charges your off-hand weapon with lava and burns your target, dealing s1 Fire damage.rnrnDamage is increased by s2 if your offhand weapon is imbued with Flametongue Weapon.
# Rank 2: Lava Lash cooldown reduced by m1/-1000.1 sec.
  SpellInfo(lava_lash cd=18)
Define(lava_surge 77756)
# Your Flame Shock damage over time has a <chance> chance to reset the remaining cooldown on Lava Burst and cause your next Lava Burst to be instant.
  SpellInfo(lava_surge channel=0 gcd=0 offgcd=1)
  SpellAddBuff(lava_surge lava_surge=1)
Define(lightning_bolt 188196)
# Hurls a bolt of lightning at the target, dealing (95 of Spell Power) Nature damage.?a343725[rnrn|cFFFFFFFFGenerates 343725s1 Maelstrom.|r][]
# Rank 2: Reduces the cast time of Lightning Bolt by m1/-1000.1 sec.
  SpellInfo(lightning_bolt)
Define(lightning_lasso_0 305483)
# Grips the target in lightning, stunning and dealing 305485o1 Nature damage over 5 seconds while the target is lassoed. Can move while channeling.
  SpellInfo(lightning_lasso_0 cd=30)
Define(lightning_lasso_1 305485)
# Grips the target in lightning, stunning and dealing 305485o1 Nature damage over 5 seconds while the target is lassoed. Can move while channeling.
  SpellInfo(lightning_lasso_1 duration=5 channel=5 gcd=0 offgcd=1 tick=1)
  # Stunned. Suffering w1 Nature damage every t1 sec.
  SpellAddTargetDebuff(lightning_lasso_1 lightning_lasso_1=1)
Define(lightning_shield 192106)
# Surround yourself with a shield of lightning for 1800 seconds.rnrnMelee attackers have a h chance to suffer (3.5999999999999996 of Spell Power) Nature damage?a137041[ and have a s3 chance to generate a stack of Maelstrom Weapon]?a137040[ and have a s4 chance to generate s5 Maelstrom][].rnrnOnly one Elemental Shield can be active on the Shaman at a time.
  SpellInfo(lightning_shield duration=1800 channel=1800)
  # Chance to deal 192109s1 Nature damage when you take melee damage.
  SpellAddBuff(lightning_shield lightning_shield=1)
Define(liquid_magma_totem 192222)
# Summons a totem at the target location for 15 seconds that hurls liquid magma at a random nearby target every 192226t1 sec, dealing (15 of Spell Power)*(1+(137040s3/100)) Fire damage to all enemies within 192223A1 yards.
  SpellInfo(liquid_magma_totem cd=60 duration=15 gcd=1 talent=liquid_magma_totem_talent)
Define(maelstrom_weapon 187880)
# When you deal damage with a melee weapon, you have a chance to gain Maelstrom Weapon, stacking up to 344179u times. Each stack of Maelstrom Weapon reduces the cast time of your next damage or healing spell by 187881s1 and increase the damage or healing of your next spell by 187881s3. A maximum of s2 stacks of Maelstrom Weapon can be consumed at a time.
  SpellInfo(maelstrom_weapon channel=0 gcd=0 offgcd=1)
  SpellAddBuff(maelstrom_weapon maelstrom_weapon=1)
Define(primordial_wave_0 326059)
# Blast your target with a Primordial Wave, dealing (65 of Spell Power) Shadow damage and apply Flame Shock to an enemy, or ?a137039[heal an ally for (65 of Spell Power) and apply Riptide to them][heal an ally for (65 of Spell Power)].rnrnYour next ?a137040[Lava Burst]?a137041[Lightning Bolt][Healing Wave] will also hit all targets affected by your ?a137040|a137041[Flame Shock][Riptide] for ?a137039[s2]?a137040[s3][s4] of normal ?a137039[healing][damage].
  SpellInfo(primordial_wave_0 cd=45)

Define(primordial_wave_1 327162)
# Blast your target with a Primordial Wave, dealing (65 of Spell Power) Shadow damage and apply Flame Shock to an enemy, or ?a137039[heal an ally for (65 of Spell Power) and apply Riptide to them][heal an ally for (65 of Spell Power)].rnrnYour next ?a137040[Lava Burst]?a137041[Lightning Bolt][Healing Wave] will also hit all targets affected by your ?a137040|a137041[Flame Shock][Riptide] for ?a137039[s2]?a137040[s3][s4] of normal ?a137039[healing][damage].
  SpellInfo(primordial_wave_1 channel=0 gcd=0 offgcd=1)
Define(primordial_wave_2 327163)
# Blast your target with a Primordial Wave, dealing (65 of Spell Power) Shadow damage and apply Flame Shock to an enemy, or ?a137039[heal an ally for (65 of Spell Power) and apply Riptide to them][heal an ally for (65 of Spell Power)].rnrnYour next ?a137040[Lava Burst]?a137041[Lightning Bolt][Healing Wave] will also hit all targets affected by your ?a137040|a137041[Flame Shock][Riptide] for ?a137039[s2]?a137040[s3][s4] of normal ?a137039[healing][damage].
  SpellInfo(primordial_wave_2 channel=0 gcd=0 offgcd=1)
Define(primordial_wave_3 327164)
# Blast your target with a Primordial Wave, dealing (65 of Spell Power) Shadow damage and apply Flame Shock to an enemy, or ?a137039[heal an ally for (65 of Spell Power) and apply Riptide to them][heal an ally for (65 of Spell Power)].rnrnYour next ?a137040[Lava Burst]?a137041[Lightning Bolt][Healing Wave] will also hit all targets affected by your ?a137040|a137041[Flame Shock][Riptide] for ?a137039[s2]?a137040[s3][s4] of normal ?a137039[healing][damage].
  SpellInfo(primordial_wave_3 duration=15 gcd=0 offgcd=1)
  # Your next ?a137040[Lava Burst]?a137041[Lightning Bolt][Healing Wave] will also hit all targets affected by your ?a137040|a137041[Flame Shock][Riptide].
  SpellAddBuff(primordial_wave_3 primordial_wave_3=1)
Define(quaking_palm 107079)
# Strikes the target with lightning speed, incapacitating them for 4 seconds, and turns off your attack.
  SpellInfo(quaking_palm cd=120 duration=4 gcd=1)
  # Incapacitated.
  SpellAddTargetDebuff(quaking_palm quaking_palm=1)
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
Define(spiritwalkers_grace 79206)
# Calls upon the guidance of the spirits for 15 seconds, permitting movement while casting Shaman spells. Castable while casting.?a192088[ Increases movement speed by 192088s2.][]
  SpellInfo(spiritwalkers_grace cd=120 duration=15 gcd=0 offgcd=1)
  # Able to move while casting all Shaman spells.
  SpellAddBuff(spiritwalkers_grace spiritwalkers_grace=1)
Define(storm_elemental 192249)
# Calls forth a Greater Storm Elemental to hurl gusts of wind that damage the Shaman's enemies for 30 seconds.rnrnWhile the Storm Elemental is active, each time you cast Lightning Bolt or Chain Lightning, the cast time of Lightning Bolt and Chain Lightning is reduced by 263806s1, stacking up to 263806u times.
  SpellInfo(storm_elemental cd=150 talent=storm_elemental_talent)
Define(stormkeeper 191634)
# Charge yourself with lightning, causing your next n Lightning Bolts to deal s2 more damage, and also causes your next n Lightning Bolts or Chain Lightnings to be instant cast and trigger an Elemental Overload on every target.
  SpellInfo(stormkeeper cd=60 duration=15 talent=stormkeeper_talent)
  # Your next Lightning Bolt will deal s2 increased damage, and your next Lightning Bolt or Chain Lightning will be instant cast and cause an Elemental Overload to trigger on every target hit.
  SpellAddBuff(stormkeeper stormkeeper=1)
Define(stormkeeper_enhancement 320137)
# Charge yourself with lightning, causing your next n Lightning Bolts or Chain Lightnings to deal s2 more damage and be instant cast.
  SpellInfo(stormkeeper_enhancement cd=60 duration=15 talent=stormkeeper_talent_enhancement)
  # Your next Lightning Bolt or Chain Lightning will deal s2 increased damage and be instant cast.
  SpellAddBuff(stormkeeper_enhancement stormkeeper_enhancement=1)
Define(stormstrike 17364)
# Energizes both your weapons with lightning and delivers a massive blow to your target, dealing a total of 32175sw1+32176sw1 Physical damage.
  SpellInfo(stormstrike cd=7.5)


Define(sundering 197214)
# Shatters a line of earth in front of you with your main hand weapon, causing s1 Flamestrike damage and Incapacitating any enemy hit for 2 seconds.
  SpellInfo(sundering cd=40 duration=2 talent=sundering_talent)
  # Incapacitated.
  SpellAddTargetDebuff(sundering sundering=1)
Define(vesper_totem_0 324386)
# Summon a totem at the target location for 30 seconds. Your next s2 damage spells or abilities will cause the totem to radiate (64 of Spell Power) Arcane damage to up to 324520I enemies near the totem, and your next s4 healing spells will heal up to s6 allies near the totem for (73 of Spell Power) health.rnrnCasting this ability again while the totem is active will relocate the totem.
  SpellInfo(vesper_totem_0 cd=60 duration=30)
  SpellAddBuff(vesper_totem_0 vesper_totem_0=1)
Define(vesper_totem_1 324519)
# Summon a totem at the target location for 30 seconds. Your next s2 damage spells or abilities will cause the totem to radiate (64 of Spell Power) Arcane damage to up to 324520I enemies near the totem, and your next s4 healing spells will heal up to s6 allies near the totem for (73 of Spell Power) health.rnrnCasting this ability again while the totem is active will relocate the totem.
  SpellInfo(vesper_totem_1 cd=3 gcd=0 offgcd=1)
Define(vesper_totem_2 324520)
# Summon a totem at the target location for 30 seconds. Your next s2 damage spells or abilities will cause the totem to radiate (64 of Spell Power) Arcane damage to up to 324520I enemies near the totem, and your next s4 healing spells will heal up to s6 allies near the totem for (73 of Spell Power) health.rnrnCasting this ability again while the totem is active will relocate the totem.
  SpellInfo(vesper_totem_2 channel=0 gcd=0 offgcd=1)
Define(vesper_totem_3 324522)
# Summon a totem at the target location for 30 seconds. Your next s2 damage spells or abilities will cause the totem to radiate (64 of Spell Power) Arcane damage to up to 324520I enemies near the totem, and your next s4 healing spells will heal up to s6 allies near the totem for (73 of Spell Power) health.rnrnCasting this ability again while the totem is active will relocate the totem.
  SpellInfo(vesper_totem_3 channel=0 gcd=0 offgcd=1)
Define(war_stomp 20549)
# Stuns up to i enemies within A1 yds for 2 seconds.
  SpellInfo(war_stomp cd=90 duration=2 gcd=0 offgcd=1)
  # Stunned.
  SpellAddTargetDebuff(war_stomp war_stomp=1)
Define(wind_shear 57994)
# Disrupts the target's concentration with a burst of wind, interrupting spellcasting and preventing any spell in that school from being cast for 3 seconds.
  SpellInfo(wind_shear cd=12 duration=3 gcd=0 offgcd=1 interrupt=1)
Define(windfury_totem 8512)
# Summons a Windfury Totem with s1 health at the feet of the caster for 120 seconds.  Party members within s2 yds have a 327942h chance when they auto-attack to swing an extra time.
# Rank 2: Windfury Totem has an additional s1 chance to grant party members an extra swing.
  SpellInfo(windfury_totem duration=120 gcd=1)
Define(windfury_weapon 33757)
# Imbue your main-hand weapon with the element of Wind for 3600 seconds. Each main-hand attack has a 319773h chance to trigger two extra attacks, dealing 25504sw1 Physical damage each.
  SpellInfo(windfury_weapon)
Define(windstrike 115356)
# Hurl a staggering blast of wind at an enemy, dealing a total of 115357sw1+115360sw1 Physical damage, bypassing armor.
  SpellInfo(windstrike cd=9)

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
SpellList(chain_lightning chain_lightning_0 chain_lightning_1)
SpellList(fae_transfusion fae_transfusion_0 fae_transfusion_1 fae_transfusion_2)
SpellList(fireblood fireblood_0 fireblood_1)
SpellList(lightning_lasso lightning_lasso_0 lightning_lasso_1)
SpellList(primordial_wave primordial_wave_0 primordial_wave_1 primordial_wave_2 primordial_wave_3)
SpellList(vesper_totem vesper_totem_0 vesper_totem_1 vesper_totem_2 vesper_totem_3)
SpellList(earth_elemental earth_elemental_0 earth_elemental_1)
SpellList(concentrated_flame concentrated_flame_0 concentrated_flame_1 concentrated_flame_2 concentrated_flame_3 concentrated_flame_4 concentrated_flame_5 concentrated_flame_6)
SpellList(ripple_in_space ripple_in_space_0 ripple_in_space_1 ripple_in_space_2 ripple_in_space_3)
SpellList(worldvein_resonance worldvein_resonance_0 worldvein_resonance_1 worldvein_resonance_2 worldvein_resonance_3)
Define(ascendance_talent_enhancement 21) #21972
# Transform into an Air Ascendant for 15 seconds, immediately dealing 344548s1 Nature damage to any enemy within 344548A1 yds, reducing the cooldown and cost of Stormstrike by s4, and transforming your auto attack and Stormstrike into Wind attacks which bypass armor and have a s1 yd range.
Define(ascendance_talent 21) #21675
# Transform into a Flame Ascendant for 15 seconds, replacing Chain Lightning with Lava Beam, removing the cooldown on Lava Burst, and increasing the damage of Lava Burst by an amount equal to your critical strike chance.rnrnWhen you transform into the Flame Ascendant, instantly cast a Lava Burst at all enemies affected by your Flame Shock, and refresh your Flame Shock durations to 18 seconds.
Define(earthen_spike_talent 20) #22977
# Summons an Earthen Spike under an enemy, dealing s1 Physical damage and increasing Physical and Nature damage you deal to the target by s2 for 10 seconds.
Define(echoing_shock_talent 5) #23460
# Shock the target for (65 of Spell Power) Elemental damage and create an ancestral echo, causing your next damage or healing spell to be cast a second time s2/1000.1 sec later for free.
Define(elemental_blast_talent_elemental 6) #23190
# Harnesses the raw power of the elements, dealing (140 of Spell Power) Elemental damage and increasing your Critical Strike or Haste by 118522s1 or Mastery by 173184s1*168534bc1 for 10 seconds.?a343725[rnrn|cFFFFFFFFGenerates 343725s10 Maelstrom.|r][]
Define(feral_lunge_talent 14) #22149
# Lunge at your enemy as a ghostly wolf, biting them to deal 215802s1 Physical damage.
Define(fire_nova_talent 12) #22171
# Erupt a burst of fiery damage from all targets affected by your Flame Shock, dealing 333977s1 Fire damage to up to 333977I targets within 333977A1 yds of your Flame Shock targets.
Define(hailstorm_talent 11) #23090
# Each stack of Maelstrom Weapon consumed increases the damage of your next Frost Shock by 334196s1, and causes your next Frost Shock to hit 334196m2 additional target per Maelstrom Weapon stack consumed.
Define(ice_strike_talent 6) #23109
# Strike your target with an icy blade, dealing s1 Frost damage and snaring them by s2 for 6 seconds.rnrnSuccessful Ice Strikes reset the cooldown of your Flame Shock and Frost Shock spells.
Define(icefury_talent 18) #23111
# Hurls frigid ice at the target, dealing (82.5 of Spell Power) Frost damage and causing your next n Frost Shocks to deal s2 increased damage and generate 343725s7 Maelstrom.rnrn|cFFFFFFFFGenerates 343725s8 Maelstrom.|r
Define(liquid_magma_totem_talent 12) #19273
# Summons a totem at the target location for 15 seconds that hurls liquid magma at a random nearby target every 192226t1 sec, dealing (15 of Spell Power)*(1+(137040s3/100)) Fire damage to all enemies within 192223A1 yards.
Define(master_of_the_elements_talent 10) #19271
# Casting Lava Burst increases the damage of your next Nature, Physical, or Frost spell by 260734s1.
Define(storm_elemental_talent 11) #19272
# Calls forth a Greater Storm Elemental to hurl gusts of wind that damage the Shaman's enemies for 30 seconds.rnrnWhile the Storm Elemental is active, each time you cast Lightning Bolt or Chain Lightning, the cast time of Lightning Bolt and Chain Lightning is reduced by 263806s1, stacking up to 263806u times.
Define(stormkeeper_talent_enhancement 17) #22352
# Charge yourself with lightning, causing your next n Lightning Bolts or Chain Lightnings to deal s2 more damage and be instant cast.
Define(stormkeeper_talent 20) #22153
# Charge yourself with lightning, causing your next n Lightning Bolts to deal s2 more damage, and also causes your next n Lightning Bolts or Chain Lightnings to be instant cast and trigger an Elemental Overload on every target.
Define(sundering_talent 18) #22351
# Shatters a line of earth in front of you with your main hand weapon, causing s1 Flamestrike damage and Incapacitating any enemy hit for 2 seconds.
    ]]
    code = code .. [[Define(hex 51514)]]
    OvaleScripts:RegisterScript("SHAMAN", nil, name, desc, code, "include")
end
