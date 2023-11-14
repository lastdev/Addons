-- MageFrost.lua
-- October 2023

if UnitClassBase( "player" ) ~= "MAGE" then return end

local addon, ns = ...
local Hekili = _G[ addon ]
local class, state = Hekili.Class, Hekili.State

local strformat = string.format

local spec = Hekili:NewSpecialization( 64 )

-- spec:RegisterResource( Enum.PowerType.ArcaneCharges )
spec:RegisterResource( Enum.PowerType.Mana )

-- Talents
spec:RegisterTalents( {
    -- Mage
    accumulative_shielding   = { 62093, 382800, 1 }, -- Your barrier's cooldown recharges 30% faster while the shield persists.
    alter_time               = { 62115, 342245, 1 }, -- Alters the fabric of time, returning you to your current location and health when cast a second time, or after 10 sec. Effect negated by long distance or death.
    arcane_warding           = { 62114, 383092, 2 }, -- Reduces magic damage taken by 3%.
    blast_wave               = { 62103, 157981, 1 }, -- Causes an explosion around yourself, dealing 1,149 Fire damage to all enemies within 8 yds, knocking them back, and reducing movement speed by 70% for 6 sec.
    cryofreeze               = { 62107, 382292, 2 }, -- While inside Ice Block, you heal for 40% of your maximum health over the duration.
    displacement             = { 62095, 389713, 1 }, -- Teleports you back to where you last Blinked and heals you for 11,036 health. Only usable within 8 sec of Blinking.
    diverted_energy          = { 62101, 382270, 2 }, -- Your Barriers heal you for 10% of the damage absorbed.
    dragons_breath           = { 62091, 31661 , 1 }, -- Enemies in a cone in front of you take 1,417 Fire damage and are disoriented for 4 sec. Damage will cancel the effect.
    energized_barriers       = { 62100, 386828, 1 }, -- When your barrier receives melee attacks, you have a 10% chance to be granted Fingers of Frost. Casting your barrier removes all snare effects.
    flow_of_time             = { 62096, 382268, 2 }, -- The cooldowns of Blink and Shimmer are reduced by 2 sec.
    freezing_cold            = { 62087, 386763, 1 }, -- Enemies hit by Cone of Cold are frozen in place for 5 sec instead of snared. When your roots expire or are dispelled, your target is snared by 90%, decaying over 3 sec.
    frigid_winds             = { 62128, 235224, 2 }, -- All of your snare effects reduce the target's movement speed by an additional 10%.
    greater_invisibility     = { 93524, 110959, 1 }, -- Makes you invisible and untargetable for 20 sec, removing all threat. Any action taken cancels this effect. You take 60% reduced damage while invisible and for 3 sec after reappearing.
    ice_block                = { 62122, 45438 , 1 }, -- Encases you in a block of ice, protecting you from all attacks and damage for 10 sec, but during that time you cannot attack, move, or cast spells. While inside Ice Block, you heal for 40% of your maximum health over the duration. Causes Hypothermia, preventing you from recasting Ice Block for 30 sec.
    ice_cold                 = { 62085, 414659, 1 }, -- Ice Block now reduces all damage taken by 70% for 6 sec but no longer grants Immunity, prevents movement, attacks, or casting spells. Does not incur the Global Cooldown.
    ice_floes                = { 62105, 108839, 1 }, -- Makes your next Mage spell with a cast time shorter than 10 sec castable while moving. Unaffected by the global cooldown and castable while casting.
    ice_nova                 = { 62126, 157997, 1 }, -- Causes a whirl of icy wind around the enemy, dealing 2,918 Frost damage to the target and reduced damage to all other enemies within 8 yds, and freezing them in place for 2 sec.
    ice_ward                 = { 62086, 205036, 1 }, -- Frost Nova now has 2 charges.
    improved_frost_nova      = { 62108, 343183, 1 }, -- Frost Nova duration is increased by 2 sec.
    incantation_of_swiftness = { 62112, 382293, 2 }, -- Invisibility increases your movement speed by 40% for 6 sec.
    incanters_flow           = { 62118, 1463  , 1 }, -- Magical energy flows through you while in combat, building up to 10% increased damage and then diminishing down to 2% increased damage, cycling every 10 sec.
    mass_barrier             = { 62092, 414660, 1 }, -- Cast Ice Barrier on yourself and 4 nearby allies.
    mass_invisibility        = { 62092, 414664, 1 }, -- You and your allies within 40 yards instantly become invisible for 12 sec. Taking any action will cancel the effect. Does not affect allies in combat.
    mass_polymorph           = { 62106, 383121, 1 }, -- Transforms all enemies within 10 yards into sheep, wandering around incapacitated for 1 min. While affected, the victims cannot take actions but will regenerate health very quickly. Damage will cancel the effect. Only works on Beasts, Humanoids and Critters.
    mass_slow                = { 62109, 391102, 1 }, -- Slow applies to all enemies within 5 yds of your target.
    master_of_time           = { 62102, 342249, 1 }, -- Reduces the cooldown of Alter Time by 10 sec. Alter Time resets the cooldown of Blink and Shimmer when you return to your original location.
    mirror_image             = { 62124, 55342 , 1 }, -- Creates 3 copies of you nearby for 40 sec, which cast spells and attack your enemies. While your images are active damage taken is reduced by 20%. Taking direct damage will cause one of your images to dissipate.
    overflowing_energy       = { 62120, 390218, 1 }, -- Your spell critical strike damage is increased by 10%. When your direct damage spells fail to critically strike a target, your spell critical strike chance is increased by 2%, up to 10% for 8 sec. When your spells critically strike Overflowing Energy is reset.
    quick_witted             = { 62104, 382297, 1 }, -- Successfully interrupting an enemy with Counterspell reduces its cooldown by 4 sec.
    reabsorption             = { 62125, 382820, 1 }, -- You are healed for 5% of your maximum health whenever a Mirror Image dissipates due to direct damage.
    reduplication            = { 62125, 382569, 1 }, -- Mirror Image's cooldown is reduced by 10 sec whenever a Mirror Image dissipates due to direct damage.
    remove_curse             = { 62116, 475   , 1 }, -- Removes all Curses from a friendly target.
    rigid_ice                = { 62110, 382481, 1 }, -- Frost Nova can withstand 80% more damage before breaking.
    ring_of_frost            = { 62088, 113724, 1 }, -- Summons a Ring of Frost for 10 sec at the target location. Enemies entering the ring are incapacitated for 10 sec. Limit 10 targets. When the incapacitate expires, enemies are slowed by 65% for 4 sec.
    shifting_power           = { 62113, 382440, 1 }, -- Draw power from the Night Fae, dealing 5,161 Nature damage over 3.2 sec to enemies within 18 yds. While channeling, your Mage ability cooldowns are reduced by 12 sec over 3.2 sec.
    shimmer                  = { 62105, 212653, 1 }, -- Teleports you 20 yds forward, unless something is in the way. Unaffected by the global cooldown and castable while casting.
    slow                     = { 62097, 31589 , 1 }, -- Reduces the target's movement speed by 60% for 15 sec.
    spellsteal               = { 62084, 30449 , 1 }, -- Steals a beneficial magic effect from the target. This effect lasts a maximum of 2 min.
    tempest_barrier          = { 62111, 382289, 2 }, -- Gain a shield that absorbs 3% of your maximum health for 15 sec after you Blink.
    temporal_velocity        = { 62099, 382826, 2 }, -- Increases your movement speed by 5% for 3 sec after casting Blink and 20% for 6 sec after returning from Alter Time.
    temporal_warp            = { 62094, 386539, 1 }, -- While you have Temporal Displacement or other similar effects, you may use Time Warp to grant yourself 30% Haste for 40 sec.
    time_anomaly             = { 62094, 383243, 1 }, -- At any moment, you have a chance to gain Icy Veins for 8 sec, Fingers of Frost, or Time Warp for 6 sec.
    time_manipulation        = { 62129, 387807, 1 }, -- Casting Ice Lance on Frozen targets reduces the cooldown of your loss of control abilities by 2 sec.
    tome_of_antonidas        = { 62098, 382490, 1 }, -- Increases Haste by 2%.
    tome_of_rhonin           = { 62127, 382493, 1 }, -- Increases Critical Strike chance by 2%.
    volatile_detonation      = { 62089, 389627, 1 }, -- Greatly increases the effect of Blast Wave's knockback. Blast Wave's cooldown is reduced by 5 sec.
    winters_protection       = { 62123, 382424, 2 }, -- The cooldown of Ice Block is reduced by 30 sec.

    -- Frost
    bone_chilling            = { 62167, 205027, 1 }, -- Whenever you attempt to chill a target, you gain Bone Chilling, increasing spell damage you deal by 0.5% for 8 sec, stacking up to 10 times.
    brain_freeze             = { 62179, 190447, 1 }, -- Frostbolt has a 25% chance to reset the remaining cooldown on Flurry and cause your next Flurry to deal 50% increased damage.
    chain_reaction           = { 62163, 278309, 1 }, -- Your Ice Lances against frozen targets increase the damage of your Ice Lances by 2% for 10 sec, stacking up to 5 times.
    cold_front               = { 62185, 382110, 1 }, -- Casting 30 Frostbolts or Flurries calls down a Frozen Orb toward your target. Hitting an enemy player counts as double.
    coldest_snap             = { 62155, 417493, 1 }, -- Cone of Cold's cooldown is increased to 45 sec and if Cone of Cold hits 3 or more enemies it resets the cooldown of Frozen Orb and Comet Storm. In addition, Cone of Cold applies Winter's Chill to all enemies hit. Cone of Cold's cooldown can no longer be reduced by your cooldown reduction effects.
    comet_storm              = { 62182, 153595, 1 }, -- Calls down a series of 7 icy comets on and around the target, that deals up to 9,440 Frost damage to all enemies within 6 yds of its impacts.
    cryopathy                = { 62152, 417491, 1 }, -- Each time you consume Fingers of Frost the damage of your next Ray of Frost is increased by 5%, stacking up to 50%. Icy Veins grants 10 stacks instantly.
    deep_shatter             = { 62159, 378749, 2 }, -- Your Frostbolt deals 40% additional damage to Frozen targets.
    everlasting_frost        = { 81468, 385167, 1 }, -- Frozen Orb deals an additional 30% damage and its duration is increased by 2 sec.
    fingers_of_frost         = { 62164, 112965, 1 }, -- Frostbolt has a 15% chance and Frozen Orb damage has a 10% to grant a charge of Fingers of Frost. Fingers of Frost causes your next Ice Lance to deal damage as if the target were frozen. Maximum 2 charges.
    flash_freeze             = { 62168, 379993, 1 }, -- Each of your Icicles deals 10% additional damage, and when an Icicle deals damage you have a 5% chance to gain the Fingers of Frost effect.
    flurry                   = { 62178, 44614 , 1 }, -- Unleash a flurry of ice, striking the target 3 times for a total of 2,195 Frost damage. Each hit reduces the target's movement speed by 80% for 1 sec and applies Winter's Chill to the target. Winter's Chill causes the target to take damage from your spells as if it were frozen.
    fractured_frost          = { 62184, 378448, 2 }, -- Your Frostbolt has a 20% chance to hit up to 2 additional targets.
    freezing_rain            = { 62150, 270233, 1 }, -- Frozen Orb makes Blizzard instant cast and increases its damage done by 60% for 12 sec.
    freezing_winds           = { 62151, 382103, 1 }, -- While Frozen Orb is active, you gain Fingers of Frost every 3 sec.
    frostbite                = { 81467, 378756, 1 }, -- Gives your Chill effects a 10% chance to freeze the target for 4 sec.
    frozen_orb               = { 62177, 84714 , 1 }, -- Launches an orb of swirling ice up to 40 yds forward which deals up to 8,682 Frost damage to all enemies it passes through over 15 sec. Deals reduced damage beyond 8 targets. Grants 1 charge of Fingers of Frost when it first damages an enemy. Enemies damaged by the Frozen Orb are slowed by 40% for 3 sec.
    frozen_touch             = { 62180, 205030, 1 }, -- Frostbolt grants you Fingers of Frost 25% more often and Brain Freeze 20% more often.
    glacial_assault          = { 62183, 378947, 1 }, -- Your Comet Storm now increases the damage enemies take from you by 6% for 6 sec and Flurry has a 25% chance each hit to call down an icy comet, crashing into your target and nearby enemies for 704 Frost damage.
    glacial_spike            = { 62157, 199786, 1 }, -- Conjures a massive spike of ice, and merges your current Icicles into it. It impales your target, dealing 10,416 damage plus all of the damage stored in your Icicles, and freezes the target in place for 4 sec. Damage may interrupt the freeze effect. Requires 5 Icicles to cast. Passive: Ice Lance no longer launches Icicles.
    hailstones               = { 62158, 381244, 2 }, -- Casting Ice Lance on Frozen targets has a 100% chance to generate an Icicle.
    ice_barrier              = { 62117, 11426 , 1 }, -- Shields you with ice, absorbing 13,077 damage for 1 min. Melee attacks against you reduce the attacker's movement speed by 60%.
    ice_caller               = { 62169, 236662, 1 }, -- Each time Blizzard deals damage, the cooldown of Frozen Orb is reduced by 0.5 sec.
    ice_lance                = { 62176, 30455 , 1 }, -- Quickly fling a shard of ice at the target, dealing 930 Frost damage. Ice Lance damage is tripled against frozen targets.
    icy_veins                = { 62171, 12472 , 1 }, -- Accelerates your spellcasting for 25 sec, granting 20% haste and preventing damage from delaying your spellcasts. Activating Icy Veins summons a water elemental to your side for its duration. The water elemental's abilities grant you Frigid Empowerment increasing the Frost damage you deal by 3%, up to 15%.
    lonely_winter            = { 62173, 205024, 1 }, -- Frostbolt, Ice Lance, and Flurry deal 15% increased damage.
    perpetual_winter         = { 62181, 378198, 1 }, -- Flurry now has 2 charges.
    piercing_cold            = { 62166, 378919, 1 }, -- Frostbolt and Icicle critical strike damage increased by 20%.
    ray_of_frost             = { 62153, 205021, 1 }, -- Channel an icy beam at the enemy for 4.0 sec, dealing 4,793 Frost damage every 0.8 sec and slowing movement by 70%. Each time Ray of Frost deals damage, its damage and snare increases by 10%. Generates 2 charges of Fingers of Frost over its duration.
    shatter                  = { 62165, 12982 , 1 }, -- Multiplies the critical strike chance of your spells against frozen targets by 1.5, and adds an additional 50% critical strike chance.
    slick_ice                = { 62156, 382144, 1 }, -- While Icy Veins is active, each Frostbolt you cast reduces the cast time of Frostbolt by 4% and increases its damage by 4%, stacking up to 5 times.
    snowstorm                = { 62170, 381706, 2 }, -- Blizzard has an 30% chance to increase the damage of your next Cone of Cold by 8%, stacking up to 15 times.
    splintering_cold         = { 62162, 379049, 2 }, -- Frostbolt and Flurry have a 30% chance to generate 2 Icicles.
    splintering_ray          = { 62152, 418733, 1 }, -- Ray of Frost deals 25% of its damage to 5 nearby enemies.
    splitting_ice            = { 62161, 56377 , 1 }, -- Your Ice Lance and Icicles now deal 5% increased damage, and hit a second nearby target for 80% of their damage. Your Glacial Spike also hits a second nearby target for 100% of its damage.
    subzero                  = { 62160, 380154, 2 }, -- Your Frost spells deal 20% more damage to targets that are rooted and frozen.
    thermal_void             = { 62154, 155149, 1 }, -- Icy Veins' duration is increased by 5 sec. Your Ice Lances against frozen targets extend your Icy Veins by an additional 0.5 sec.
    winters_blessing         = { 62174, 417489, 1 }, -- Your Haste is increased by 8%. You gain 10% more of the Haste stat from all sources.
    wintertide               = { 62172, 378406, 2 }, -- Increases Frostbolt damage by 5%. Fingers of Frost empowered Ice Lances deal 10% increased damage to Frozen targets.
} )


-- PvP Talents
spec:RegisterPvpTalents( {
    concentrated_coolness      = 632 , -- (198148) Frozen Orb's damage is increased by 10% and is now castable at a location with a 40 yard range but no longer moves.
    ethereal_blink             = 5600, -- (410939) Blink and Shimmer apply Slow at 100% effectiveness to all enemies you Blink through. For each enemy you Blink through, the cooldown of Blink and Shimmer are reduced by 1 sec, up to 5 sec.
    frost_bomb                 = 5496, -- (390612) Places a Frost Bomb on the target. After 5 sec, the bomb explodes, dealing 7,816 Frost damage to the target and 3,908 Frost damage to all other enemies within 10 yards. All affected targets are slowed by 80% for 4 sec. If Frost Bomb is dispelled before it explodes, gain a charge of Brain Freeze.
    ice_form                   = 634 , -- (198144) Your body turns into Ice, increasing your Frostbolt damage done by 30% and granting immunity to stun and knockback effects. Lasts 12 sec.
    ice_wall                   = 5390, -- (352278) Conjures an Ice Wall 30 yards long that obstructs line of sight. The wall has 40% of your maximum health and lasts up to 15 sec.
    icy_feet                   = 66  , -- (407581) When your Frost Nova or Water Elemental's Freeze is dispelled or removed, become immune to snares for 3 sec. This effect can only occur once every 10 sec.
    improved_mass_invisibility = 5622, -- (415945) The cooldown of Mass Invisibility is reduced by 4 min and can affect allies in combat.
    master_shepherd            = 5581, -- (410248) While an enemy player is affected by your Polymorph or Mass Polymorph, your movement speed is increased by 25% and your Versatility is increased by 6%. Additionally, Polymorph and Mass Polymorph no longer heal enemies.
    ring_of_fire               = 5490, -- (353082) Summons a Ring of Fire for 8 sec at the target location. Enemies entering the ring burn for 24% of their total health over 6 sec.
    snowdrift                  = 5497, -- (389794) Summon a strong Blizzard that surrounds you for 6 sec that slows enemies by 80% and deals 423 Frost damage every 1 sec. Enemies that are caught in Snowdrift for 3 sec consecutively become Frozen in ice, stunned for 4 sec.
} )


-- Auras
spec:RegisterAuras( {
    active_blizzard = {
        duration = function () return 8 * haste end,
        max_stack = 1,
        generate = function( t )
            if query_time - action.blizzard.lastCast < 8 * haste then
                t.count = 1
                t.applied = action.blizzard.lastCast
                t.expires = t.applied + ( 8 * haste )
                t.caster = "player"
                return
            end

            t.count = 0
            t.applied = 0
            t.expires = 0
            t.caster = "nobody"
        end,
    },
    active_comet_storm = {
        duration = 2.6,
        max_stack = 1,
        generate = function( t )
            if query_time - action.comet_storm.lastCast < 2.6 then
                t.count = 1
                t.applied = action.comet_storm.lastCast
                t.expires = t.applied + 2.6
                t.caster = "player"
                return
            end

            t.count = 0
            t.applied = 0
            t.expires = 0
            t.caster = "nobody"
        end,
    },
    arcane_power = {
        id = 12042,
        duration = 15,
        type = "Magic",
        max_stack = 1,
    },
    -- Talent: Movement speed reduced by $s2%.
    -- https://wowhead.com/beta/spell=157981
    blast_wave = {
        id = 157981,
        duration = 6,
        type = "Magic",
        max_stack = 1
    },
    -- Blinking.
    -- https://wowhead.com/beta/spell=1953
    blink = {
        id = 1953,
        duration = 0.3,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Movement speed reduced by $w1%.
    -- https://wowhead.com/beta/spell=12486
    blizzard = {
        id = 12486,
        duration = 3,
        mechanic = "snare",
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Spell damage done increased by ${$W1}.1%.
    -- https://wowhead.com/beta/spell=205766
    bone_chilling = {
        id = 205766,
        duration = 8,
        max_stack = 10
    },
    brain_freeze = {
        id = 190446,
        duration = 15,
        max_stack = 1,
    },
    chain_reaction = {
        id = 278310,
        duration = 10,
        max_stack = 5,
    },
    -- Movement speed reduced by $w1%.
    -- https://wowhead.com/beta/spell=205708
    chilled = {
        id = 205708,
        duration = 8,
        max_stack = 1
    },
    -- Movement speed reduced by $s1%.
    -- https://wowhead.com/beta/spell=212792
    cone_of_cold = {
        id = 212792,
        duration = 5,
        max_stack = 1
    },
    cryopathy = {
        id = 417492,
        duration = 60,
        max_stack = 16,
    },
    -- Talent: Disoriented.
    -- https://wowhead.com/beta/spell=31661
    dragons_breath = {
        id = 31661,
        duration = 4,
        type = "Magic",
        max_stack = 1
    },
    fingers_of_frost = {
        id = 44544,
        duration = 15,
        max_stack = 2,
    },
    -- Talent: Movement slowed by $w1%.
    -- https://wowhead.com/beta/spell=228354
    flurry = {
        id = 228354,
        duration = 1,
        type = "Magic",
        max_stack = 1
    },
    focus_magic = {
        id = 321358,
        duration = 1800,
        max_stack = 1,
        friendly = true,
    },
    focus_magic_buff = {
        id = 321363,
        duration = 10,
        max_stack = 1,
    },
    -- Talent: Blizzard is instant cast and deals $s2% increased damage.
    -- https://wowhead.com/beta/spell=270232
    freezing_rain = {
        id = 270232,
        duration = 12,
        max_stack = 1
    },
    freeze = {
        id = 33395,
        duration = 8,
        max_stack = 1,
        shared = "pet"
    },
    frigid_empowerment = {
        id = 417488,
        duration = 60,
        max_stack = 5
    },
    -- Frozen in place.
    -- https://wowhead.com/beta/spell=122
    frost_nova = {
        id = 122,
        duration = 10,
        type = "Magic",
        max_stack = 1,
        copy = 235235
    },
    -- Talent: Frozen.
    -- https://wowhead.com/beta/spell=378760
    frostbite = {
        id = 378760,
        duration = 4,
        mechanic = "root",
        type = "Magic",
        max_stack = 1
    },
    frostbolt = {
        id = 59638,
        duration = 4,
        type = "Magic",
        max_stack = 1,
    },
    frozen_orb = {
        duration = function() return 10 + 2 * talent.everlasting_frost.rank end,
        max_stack = 1,
        generate = function( t )
            if query_time - action.frozen_orb.lastCast < t.duration then
                t.count = 1
                t.applied = action.frozen_orb.lastCast
                t.expires = t.applied + t.duration
                t.caster = "player"
                return
            end

            t.count = 0
            t.applied = 0
            t.expires = 0
            t.caster = "nobody"
        end,
    },
    -- Talent: Movement speed reduced by $w1%.
    -- https://wowhead.com/beta/spell=289308
    frozen_orb_snare = {
        id = 289308,
        duration = 3,
        max_stack = 1,
    },
    -- Talent: Frozen in place.
    -- https://wowhead.com/beta/spell=228600
    glacial_spike = {
        id = 228600,
        duration = 4,
        type = "Magic",
        max_stack = 1
    },
    glacial_spike_usable = {
        id = 199844,
        duration = 60,
        max_stack = 1
    },
    -- Talent: Absorbs $w1 damage.  Melee attackers slowed by $205708s1%.$?s235297[  Armor increased by $s3%.][]
    -- https://wowhead.com/beta/spell=11426
    ice_barrier = {
        id = 11426,
        duration = 60,
        type = "Magic",
        max_stack = 1
    },
    -- Frostbolt damage done increased by $m1%. Immune to stun and knockback effects.
    -- https://wowhead.com/beta/spell=198144
    ice_form = {
        id = 198144,
        duration = 12,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Frozen.
    -- https://wowhead.com/beta/spell=157997
    ice_nova = {
        id = 157997,
        duration = 2,
        type = "Magic",
        max_stack = 1
    },
    icicles = {
        id = 205473,
        duration = 60,
        max_stack = 5,
    },
    -- Talent: Haste increased by $w1% and immune to pushback.
    -- https://wowhead.com/beta/spell=12472
    icy_veins = {
        id = 12472,
        duration = function() return talent.thermal_void.enabled and 30 or 25 end,
        type = "Magic",
        max_stack = 1
    },
    incanters_flow = {
        id = 116267,
        duration = 3600,
        max_stack = 5,
        meta = {
            stack = function() return state.incanters_flow_stacks end,
            stacks = function() return state.incanters_flow_stacks end,
        }
    },
    preinvisibility = {
        id = 66,
        duration = 3,
        max_stack = 1,
    },
    invisibility = {
        id = 32612,
        duration = 20,
        max_stack = 1
    },
    -- Talent: Incapacitated. Cannot attack or cast spells.  Increased health regeneration.
    -- https://wowhead.com/beta/spell=383121
    mass_polymorph = {
        id = 383121,
        duration = 60,
        mechanic = "polymorph",
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Movement speed reduced by $w1%.
    -- https://wowhead.com/beta/spell=391104
    mass_slow = {
        id = 391104,
        duration = 15,
        mechanic = "snare",
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Damage taken is reduced by $s3% while your images are active.
    -- https://wowhead.com/beta/spell=55342
    mirror_image = {
        id = 55342,
        duration = 40,
        max_stack = 3,
        generate = function ()
            local mi = buff.mirror_image

            if action.mirror_image.lastCast > 0 and query_time < action.mirror_image.lastCast + 40 then
                mi.count = 1
                mi.applied = action.mirror_image.lastCast
                mi.expires = mi.applied + 40
                mi.caster = "player"
                return
            end

            mi.count = 0
            mi.applied = 0
            mi.expires = 0
            mi.caster = "nobody"
        end,
    },
    numbing_blast = {
        id = 417490,
        duration = 6,
        max_stack = 1
    },
    polymorph = {
        id = 118,
        duration = 60,
        max_stack = 1
    },
    -- Talent: Movement slowed by $w1%.  Taking $w2 Frost damage every $t2 sec.
    -- https://wowhead.com/beta/spell=205021
    ray_of_frost = {
        id = 205021,
        duration = 5,
        type = "Magic",
        max_stack = 1
    },
    shatter = {
        id = 12982,
    },
    -- Talent: Every $t1 sec, deal $382445s1 Nature damage to enemies within $382445A1 yds and reduce the remaining cooldown of your abilities by ${-$s2/1000} sec.
    -- https://wowhead.com/beta/spell=382440
    shifting_power = {
        id = 382440,
        duration = 4,
        tick_time = 1,
        type = "Magic",
        max_stack = 1,
        copy = 314791
    },
    -- Talent: Shimmering.
    -- https://wowhead.com/beta/spell=212653
    shimmer = {
        id = 212653,
        duration = 0.65,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Cast time of Frostbolt reduced by $s1% and its damage is increased by $s2%.
    -- https://wowhead.com/beta/spell=382148
    slick_ice = {
        id = 382148,
        duration = 60,
        max_stack = 5,
        copy = 327509
    },
    -- Talent: Movement speed reduced by $w1%.
    -- https://wowhead.com/beta/spell=31589
    slow = {
        id = 31589,
        duration = 15,
        mechanic = "snare",
        type = "Magic",
        max_stack = 1
    },
    slow_fall = {
        id = 130,
        duration = 30,
        max_stack = 1,
    },
    -- Talent: The damage of your next Cone of Cold is increased by $w1%.
    -- https://wowhead.com/beta/spell=381522
    snowstorm = {
        id = 381522,
        duration = 30,
        max_stack = 15
    },
    -- Talent: Absorbs $w1 damage.
    -- https://wowhead.com/beta/spell=382290
    tempest_barrier = {
        id = 382290,
        duration = 15,
        type = "Magic",
        max_stack = 1
    },
    winters_chill = {
        id = 228358,
        duration = 6,
        type = "Magic",
        max_stack = 2,
    },

    frozen = {
        duration = 1,

        meta = {
            spell = function( t )
                if debuff.winters_chill.up and remaining_winters_chill > 0 then return debuff.winters_chill end
                local spell = debuff.frost_nova

                if debuff.frostbite.remains     > spell.remains then spell = debuff.frostbite     end
                if debuff.freeze.remains        > spell.remains then spell = debuff.freeze        end
                if debuff.glacial_spike.remains > spell.remains then spell = debuff.glacial_spike end

                return spell
            end,

            up = function( t )
                return t.spell.up
            end,
            down = function( t )
                return t.spell.down
            end,
            applied = function( t )
                return t.spell.applied
            end,
            expires = function( t )
                return t.spell.expires
            end,
            remains = function( t )
                return t.spell.remains
            end,
            count = function(t )
                return t.spell.count
            end,
            stack = function( t )
                return t.spell.stack
            end,
            stacks = function( t )
                return t.spell.stacks
            end,
        }
    },

    -- Azerite Powers (overrides)
    frigid_grasp = {
        id = 279684,
        duration = 20,
        max_stack = 1,
    },
    overwhelming_power = {
        id = 266180,
        duration = 25,
        max_stack = 25,
    },
    tunnel_of_ice = {
        id = 277904,
        duration = 300,
        max_stack = 3
    },

    -- Legendaries
    cold_front = {
        id = 327327,
        duration = 30,
        max_stack = 30
    },
    cold_front_ready = {
        id = 327330,
        duration = 30,
        max_stack = 1
    },
    expanded_potential = {
        id = 327495,
        duration = 300,
        max_stack = 1
    },
    freezing_winds = {
        id = 382106,
        duration = 30,
        max_stack = 1,
        copy = 327478
    },
} )


spec:RegisterPet( "water_elemental", 208441, "icy_veins", function() return talent.thermal_void.enabled and 30 or 25 end )


spec:RegisterStateExpr( "fingers_of_frost_active", function ()
    return false
end )

spec:RegisterStateFunction( "fingers_of_frost", function( active )
    fingers_of_frost_active = active
end )

spec:RegisterStateExpr( "remaining_winters_chill", function ()
    local wc = debuff.winters_chill.stack

    if wc == 0 then return 0 end

    local projectiles = 0

    if prev_gcd[1].ice_lance and state:IsInFlight( "ice_lance" ) then projectiles = projectiles + 1 end
    if prev_gcd[1].frostbolt and state:IsInFlight( "frostbolt" ) then projectiles = projectiles + 1 end
    if prev_gcd[1].glacial_spike and state:IsInFlight( "glacial_spike" ) then projectiles = projectiles + 1 end

    return max( 0, wc - projectiles )
end )


spec:RegisterStateTable( "ground_aoe", {
    frozen_orb = setmetatable( {}, {
        __index = setfenv( function( t, k )
            if k == "remains" then
                return buff.frozen_orb.remains
            end
        end, state )
    } ),

    blizzard = setmetatable( {}, {
        __index = setfenv( function( t, k )
            if k == "remains" then return buff.active_blizzard.remains end
        end, state )
    } )
} )


spec:RegisterStateExpr( "freezable", function ()
    return not target.is_boss or target.level < level + 3
end )


spec:RegisterStateTable( "frost_info", {
    last_target_actual = "nobody",
    last_target_virtual = "nobody",
    watching = true,

    -- real_brain_freeze = false,
    -- virtual_brain_freeze = false
} )


local brain_freeze_removed = 0

local lastCometCast = 0
local lastAutoComet = 0

spec:RegisterHook( "COMBAT_LOG_EVENT_UNFILTERED", function( _, subtype, _, sourceGUID, sourceName, _, _, destGUID, destName, destFlags, _, spellID, spellName )
    if sourceGUID == GUID then
        if subtype == "SPELL_CAST_SUCCESS" then
            if spellID == 116 then
                frost_info.last_target_actual = destGUID
            end

            --[[ if spellID == 44614 then
                frost_info.real_brain_freeze = FindUnitBuffByID( "player", 190446 ) ~= nil
            end ]]
        elseif subtype == "SPELL_AURA_REMOVED" and spellID == 190446 then
            brain_freeze_removed = GetTime()
        end

        if state.talent.glacial_spike.enabled and ( spellID == 205473 or spellID == 199844 ) and ( subtype == "SPELL_AURA_APPLIED" or subtype == "SPELL_AURA_REMOVED" or subtype == "SPELL_AURA_REFRESH" or subtype == "SPELL_AURA_APPLIED_DOSE" or subtype == "SPELL_AURA_REMOVED_DOSE" ) then
            Hekili:ForceUpdate( "ICICLES_CHANGED", true )
        end

        if ( spellID == 153595 or spellID == 153596 ) then
            local t = GetTime()

            if subtype == "SPELL_CAST_SUCCESS" then
                lastCometCast = t
            elseif subtype == "SPELL_DAMAGE" and t - lastCometCast > 3 and t - lastAutoComet > 3 then
                -- TODO:  Revisit strategy for detecting auto comets.
                lastAutoComet = t
            end
        end
    end
end, false )

spec:RegisterStateExpr( "brain_freeze_active", function ()
    return buff.brain_freeze.up -- frost_info.virtual_brain_freeze
end )


spec:RegisterStateTable( "rotation", setmetatable( {},
{
    __index = function( t, k )
        if k == "standard" then return true end
        return false
    end,
} ) )


spec:RegisterStateTable( "incanters_flow", {
    changed = 0,
    count = 0,
    direction = 0,

    startCount = 0,
    startTime = 0,
    startIndex = 0,

    values = {
        [0] = { 0, 1 },
        { 1, 1 },
        { 2, 1 },
        { 3, 1 },
        { 4, 1 },
        { 5, 0 },
        { 5, -1 },
        { 4, -1 },
        { 3, -1 },
        { 2, -1 },
        { 1, 0 }
    },

    f = CreateFrame( "Frame" ),
    fRegistered = false,

    reset = setfenv( function ()
        if talent.incanters_flow.enabled then
            if not incanters_flow.fRegistered then
                Hekili:ProfileFrame( "Incanters_Flow_Frost", incanters_flow.f )
                -- One-time setup.
                incanters_flow.f:RegisterUnitEvent( "UNIT_AURA", "player" )
                incanters_flow.f:SetScript( "OnEvent", function ()
                    -- Check to see if IF changed.
                    if state.talent.incanters_flow.enabled then
                        local flow = state.incanters_flow
                        local name, _, count = FindUnitBuffByID( "player", 116267, "PLAYER" )
                        local now = GetTime()

                        if name then
                            if count ~= flow.count then
                                if count == 1 then flow.direction = 0
                                elseif count == 5 then flow.direction = 0
                                else flow.direction = ( count > flow.count ) and 1 or -1 end

                                flow.changed = now
                                flow.count = count
                            end
                        else
                            flow.count = 0
                            flow.changed = now
                            flow.direction = 0
                        end
                    end
                end )

                incanters_flow.fRegistered = true
            end

            if now - incanters_flow.changed >= 1 then
                if incanters_flow.count == 1 and incanters_flow.direction == 0 then
                    incanters_flow.direction = 1
                    incanters_flow.changed = incanters_flow.changed + 1
                elseif incanters_flow.count == 5 and incanters_flow.direction == 0 then
                    incanters_flow.direction = -1
                    incanters_flow.changed = incanters_flow.changed + 1
                end
            end

            if incanters_flow.count == 0 then
                incanters_flow.startCount = 0
                incanters_flow.startTime = incanters_flow.changed + floor( now - incanters_flow.changed )
                incanters_flow.startIndex = 0
            else
                incanters_flow.startCount = incanters_flow.count
                incanters_flow.startTime = incanters_flow.changed + floor( now - incanters_flow.changed )
                incanters_flow.startIndex = 0

                for i, val in ipairs( incanters_flow.values ) do
                    if val[1] == incanters_flow.count and val[2] == incanters_flow.direction then incanters_flow.startIndex = i; break end
                end
            end
        else
            incanters_flow.count = 0
            incanters_flow.changed = 0
            incanters_flow.direction = 0
        end
    end, state ),
} )


spec:RegisterStateExpr( "bf_flurry", function () return false end )
spec:RegisterStateExpr( "comet_storm_remains", function () return buff.active_comet_storm.remains end )



spec:RegisterGear( "tier31", 207288, 207289, 207290, 207291, 207293 )

spec:RegisterGear( "tier30", 202554, 202552, 202551, 202550, 202549 )

spec:RegisterGear( "tier29", 200318, 200320, 200315, 200317, 200319 )
spec:RegisterAura( "touch_of_ice", {
    id = 394994,
    duration = 6,
    max_stack = 1
} )


spec:RegisterHook( "reset_precast", function ()
    if pet.rune_of_power.up then applyBuff( "rune_of_power", pet.rune_of_power.remains )
    else removeBuff( "rune_of_power" ) end

    frost_info.last_target_virtual = frost_info.last_target_actual
    -- frost_info.virtual_brain_freeze = frost_info.real_brain_freeze

    if now - action.flurry.lastCast < gcd.execute and debuff.winters_chill.stack < 2 then applyDebuff( "target", "winters_chill", nil, 2 ) end

    -- Icicles take a second to get used.
    if not state.talent.glacial_spike.enabled and now - action.ice_lance.lastCast < gcd.max then removeBuff( "icicles" ) end

    incanters_flow.reset()

    if Hekili.ActiveDebug then
        Hekili:Debug( "Ice Lance in-flight?  %s\nWinter's Chill Actual Stacks?  %d\nremaining_winters_chill:  %d", state:IsInFlight( "ice_lance" ) and "Yes" or "No", state.debuff.winters_chill.stack, state.remaining_winters_chill )
    end

    if buff.icy_veins.up then summonPet( "water_elemental", buff.icy_veins.remains ) end
end )

spec:RegisterHook( "runHandler", function( action )
    if buff.ice_floes.up then
        local ability = class.abilities[ action ]
        if ability and ability.cast > 0 and ability.cast < 10 then removeStack( "ice_floes" ) end
    end
end )


Hekili:EmbedDisciplinaryCommand( spec )

-- Abilities
spec:RegisterAbilities( {
    -- Ice shards pelt the target area, dealing 986 Frost damage over 7.1 sec and reducing movement speed by 60% for 3 sec. Each time Blizzard deals damage, the cooldown of Frozen Orb is reduced by 0.50 sec.
    blizzard = {
        id = 190356,
        cast = function () return buff.freezing_rain.up and 0 or 2 * haste end,
        cooldown = 8,
        gcd = "spell",
        school = "frost",

        spend = 0.02,
        spendType = "mana",

        startsCombat = true,

        velocity = 20,

        handler = function ()
            applyDebuff( "target", "blizzard" )
            applyBuff( "active_blizzard" )
        end,
    },

    -- Resets the cooldown of your Ice Barrier, Frost Nova, $?a417493[][Cone of Cold, ]Ice Cold, and Ice Block.
    cold_snap = {
        id = 235219,
        cast = 0,
        cooldown = 300,
        gcd = "off",
        school = "physical",

        startsCombat = false,
        toggle = "cooldowns",

        handler = function ()
            setCooldown( "ice_barrier", 0 )
            setCooldown( "frost_nova", 0 )
            if not talent.coldest_snap.enabled then setCooldown( "cone_of_cold", 0 ) end
            setCooldown( "ice_cold", 0 )
            setCooldown( "ice_block", 0 )
        end,
    },

    -- Calls down a series of 7 icy comets on and around the target, that deals up to 3,625 Frost damage to all enemies within 6 yds of its impacts.
    comet_storm = {
        id = 153595,
        cast = 0,
        cooldown = 30,
        gcd = "spell",
        school = "frost",

        spend = 0.01,
        spendType = "mana",

        talent = "comet_storm",
        startsCombat = false,

        handler = function ()
            applyBuff( "active_comet_storm" )
        end,
    },


    -- Targets in a cone in front of you take 383 Frost damage and have movement slowed by 70% for 5 sec.
    cone_of_cold = {
        id = 120,
        cast = 0,
        cooldown = function() return talent.coldest_snap.enabled and 45 or 12 end,
        gcd = "spell",
        school = "frost",

        spend = 0.04,
        spendType = "mana",

        startsCombat = true,

        usable = function () return target.distance <= 12, "target must be nearby" end,
        handler = function ()
            applyDebuff( "target", talent.freezing_cold.enabled and "freezing_cold" or "cone_of_cold" )
            active_dot.cone_of_cold = max( active_enemies, active_dot.cone_of_cold )
            removeDebuffStack( "target", "winters_chill" )

            if talent.coldest_snap.enabled then
                setCooldown( "frozen_orb", 0 )
                setCooldown( "comet_storm", 0 )
                applyDebuff( "target", "winters_chill" )
                active_dot.winters_chill = max( active_enemies, active_dot.winters_chill )
            end

            removeBuff( "snowstorm" )
            if talent.bone_chilling.enabled then addStack( "bone_chilling" ) end
        end,
    },

    -- Unleash a flurry of ice, striking the target 3 times for a total of 1,462 Frost damage. Each hit reduces the target's movement speed by 80% for 1 sec and applies Winter's Chill to the target. Winter's Chill causes the target to take damage from your spells as if it were frozen.
    flurry = {
        id = 44614,
        cast = 0,
        charges = function() return talent.perpetual_winter.enabled and 2 or nil end,
        cooldown = 30,
        recharge = function() return talent.perpetual_winter.enabled and 30 or nil end,
        gcd = "spell",
        school = "frost",

        spend = 0.01,
        spendType = "mana",

        talent = "flurry",
        startsCombat = true,
        flightTime = 1,

        handler = function ()
            removeBuff( "brain_freeze" )
            removeBuff( "cold_front_ready" )
            applyDebuff( "target", "winters_chill", nil, 2 )
            applyDebuff( "target", "flurry" )

            if buff.expanded_potential.up then removeBuff( "expanded_potential" )
            elseif legendary.sinful_delight.enabled then gainChargeTime( "mirrors_of_torment", 4 )
            end


            if talent.cold_front.enabled or legendary.cold_front.enabled then
                addStack( "cold_front" )
                if buff.cold_front.stack == 15 then
                    removeBuff( "cold_front" )
                    applyBuff( "cold_front_ready" )
                end
            end

            applyDebuff( "target", "flurry" )
            addStack( "icicles" )
            if talent.glacial_spike.enabled and buff.icicles.stack == buff.icicles.max_stack then
                applyBuff( "glacial_spike_usable" )
            end

            if talent.bone_chilling.enabled then addStack( "bone_chilling" ) end
            removeBuff( "ice_floes" )
        end,

        impact = function()
            Hekili:Debug( "Winter's Chill applied by Flurry." )
            applyDebuff( "target", "winters_chill", nil, 2 )
            applyDebuff( "target", "flurry" )
        end,

        copy = 228354 -- ID of the Flurry impact.
    },

    -- Places a Frost Bomb on the target. After 5 sec, the bomb explodes, dealing 2,713 Frost damage to the target and 1,356 Frost damage to all other enemies within 10 yards. All affected targets are slowed by 80% for 4 sec.
    frost_bomb = {
        id = 390612,
        cast = 1.33,
        cooldown = 15,
        gcd = "spell",
        school = "frost",

        spend = 0.01,
        spendType = "mana",

        pvptalent = "frost_bomb",
        startsCombat = false,
        texture = 609814,

        handler = function ()
            if talent.bone_chilling.enabled then addStack( "bone_chilling" ) end
        end,
    },

    -- Launches a bolt of frost at the enemy, causing 890 Frost damage and slowing movement speed by 60% for 8 sec.
    frostbolt = {
        id = 116,
        cast = function () return 2 * ( 1 - 0.04 * buff.slick_ice.stack ) * haste end,
        cooldown = 0,
        gcd = "spell",
        school = "frost",

        spend = 0.02,
        spendType = "mana",

        startsCombat = true,
        velocity = 35,

        handler = function ()
            addStack( "icicles" )
            if talent.glacial_spike.enabled and buff.icicles.stack == buff.icicles.max_stack then
                applyBuff( "glacial_spike_usable" )
            end

            removeBuff( "ice_floes" )
            removeBuff( "cold_front_ready" )

            if talent.bone_chilling.enabled then addStack( "bone_chilling" ) end
            if talent.slick_ice.enabled or legendary.slick_ice.enabled then addStack( "slick_ice" ) end

            if talent.cold_front.enabled or legendary.cold_front.enabled then
                addStack( "cold_front" )
                if buff.cold_front.stack == 15 then
                    removeBuff( "cold_front" )
                    applyBuff( "cold_front_ready" )
                end
            end

            if azerite.tunnel_of_ice.enabled then
                if frost_info.last_target_virtual == target.unit then
                    addStack( "tunnel_of_ice" )
                else
                    removeBuff( "tunnel_of_ice" )
                end
                frost_info.last_target_virtual = target.unit
            end
        end,

        impact = function ()
            applyDebuff( "target", "chilled" )
            --[[ if debuff.winters_chill.stack > 0 and action.frostbolt.lastCast > action.flurry.lastCast then
                removeDebuffStack( "target", "winters_chill" )
            end ]]
        end,

        copy = 228597
    },

    -- Launches an orb of swirling ice up to 40 yards forward which deals up to 5,687 Frost damage to all enemies it passes through. Deals reduced damage beyond 8 targets. Grants 1 charge of Fingers of Frost when it first damages an enemy. While Frozen Orb is active, you gain Fingers of Frost every 2 sec. Enemies damaged by the Frozen Orb are slowed by 40% for 3 sec.
    frozen_orb = {
        id = 84714,
        cast = 0,
        cooldown = 60,
        gcd = "spell",
        school = "frost",

        spend = 0.01,
        spendType = "mana",

        talent = "frozen_orb",
        startsCombat = true,

        toggle = "cooldowns",
        velocity = 20,

        handler = function ()
            if talent.freezing_rain.enabled then applyBuff( "freezing_rain" ) end
            applyBuff( "frozen_orb" )
        end,

        --[[ Not modeling because you can throw it off in a random direction and get no procs.  Just react.
        impact = function ()
            addStack( "fingers_of_frost" )
            applyDebuff( "target", "frozen_orb_snare" )
        end, ]]

        copy = 198149
    },

    -- Conjures a massive spike of ice, and merges your current Icicles into it. It impales your target, dealing 3,833 damage plus all of the damage stored in your Icicles, and freezes the target in place for 4 sec. Damage may interrupt the freeze effect. Requires 5 Icicles to cast. Passive: Ice Lance no longer launches Icicles.
    glacial_spike = {
        id = 199786,
        cast = 2.75,
        cooldown = 0,
        gcd = "spell",
        school = "frost",

        spend = 0.01,
        spendType = "mana",

        talent = "glacial_spike",
        startsCombat = true,
        velocity = 40,

        usable = function() return buff.icicles.stack == 5 or buff.glacial_spike_usable.up, "requires 5 icicles or glacial_spike!" end,

        handler = function ()
            removeBuff( "icicles" )
            removeBuff( "glacial_spike_usable" )

            if talent.bone_chilling.enabled then addStack( "bone_chilling" ) end
            if talent.thermal_void.enabled and buff.icy_veins.up then buff.icy_veins.expires = buff.icy_veins.expires + ( debuff.frozen.up and 4 or 1 ) end
        end,

        impact = function()
            applyDebuff( "target", "glacial_spike" )
            removeDebuffStack( "target", "winters_chill" )
        end,

        copy = 228600
    },

    -- Shields you with ice, absorbing 5,674 damage for 1 min. Melee attacks against you reduce the attacker's movement speed by 60%.
    ice_barrier = {
        id = 11426,
        cast = 0,
        cooldown = 25,
        gcd = "spell",
        school = "frost",

        spend = 0.03,
        spendType = "mana",

        talent = "ice_barrier",
        startsCombat = false,

        handler = function ()
            applyBuff( "ice_barrier" )
            if legendary.triune_ward.enabled then
                applyBuff( "blazing_barrier" )
                applyBuff( "prismatic_barrier" )
            end
        end,
    },

    -- Quickly fling a shard of ice at the target, dealing 477 Frost damage. Ice Lance damage is tripled against frozen targets.
    ice_lance = {
        id = 30455,
        cast = 0,
        cooldown = 0,
        gcd = "spell",
        school = "frost",

        spend = 0.01,
        spendType = "mana",

        talent = "ice_lance",
        startsCombat = true,
        velocity = 47,

        start = function ()
            applyDebuff( "target", "chilled" )

            if buff.fingers_of_frost.up or debuff.frozen.up then
                if talent.chain_reaction.enabled then addStack( "chain_reaction" ) end
                if talent.thermal_void.enabled and buff.icy_veins.up then buff.icy_veins.expires = buff.icy_veins.expires + 0.5 end
            end

            if not talent.glacial_spike.enabled then removeStack( "icicles" ) end
            if talent.bone_chilling.enabled then addStack( "bone_chilling" ) end

            if azerite.whiteout.enabled then
                cooldown.frozen_orb.expires = max( 0, cooldown.frozen_orb.expires - 0.5 )
            end
        end,

        impact = function ()
            if ( buff.fingers_of_frost.up or debuff.frozen.up ) and talent.hailstones.rank == 2 then
                addStack( "icicles" )
                if talent.glacial_spike.enabled and buff.icicles.stack == buff.icicles.max_stack then
                    applyBuff( "glacial_spike_usable" )
                end
            end

            removeDebuffStack( "target", "winters_chill" )

            if buff.fingers_of_frost.up then
                removeStack( "fingers_of_frost" )
                if talent.cryopathy.enabled then addStack( "cryopathy" ) end
                if set_bonus.tier29_4pc > 0 then applyBuff( "touch_of_ice" ) end
            end
        end,

        copy = 228598
    },

    -- Talent: Causes a whirl of icy wind around the enemy, dealing 1,226 Frost damage to the target and reduced damage to all other enemies within 8 yards, and freezing them in place for 2 sec.
    ice_nova = {
        id = 157997,
        cast = 0,
        cooldown = 25,
        gcd = "spell",
        school = "frost",

        talent = "ice_nova",
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "ice_nova" )
            removeDebuffStack( "target", "winters_chill" )
        end,
    },

    -- Conjures an Ice Wall 30 yards long that obstructs line of sight. The wall has 40% of your maximum health and lasts up to 15 sec.
    ice_wall = {
        id = 352278,
        cast = 1.33,
        cooldown = 90,
        gcd = "spell",
        school = "frost",

        spend = 0.08,
        spendType = "mana",

        pvptalent = "ice_wall",
        startsCombat = false,
        texture = 4226156,

        toggle = "interrupts",

        handler = function ()
        end,
    },

    -- Accelerates your spellcasting for 25 sec, granting 30% haste and preventing damage from delaying your spellcasts. Activating Icy Veins grants a charge of Brain Freeze and Fingers of Frost.
    icy_veins = {
        id = function ()
            return pvptalent.ice_form.enabled and 198144 or 12472
        end,
        cast = 0,
        cooldown = function () return ( essence.vision_of_perfection.enabled and 0.87 or 1 ) * 180 end,
        gcd = "off",
        school = "frost",

        toggle = "cooldowns",

        startsCombat = false,

        handler = function ()
            summonPet( "water_elemental" )

            if talent.bone_chilling.enabled then addStack( "bone_chilling" ) end
            if talent.cryopathy.enabled then addStack( "cryopathy", nil, 10 ) end
            if talent.rune_of_power.enabled then applyBuff( "rune_of_power" ) end

            if pvptalent.ice_form.enabled then applyBuff( "ice_form" )
            else
                applyBuff( "icy_veins" )
                stat.haste = stat.haste + 0.30

                if talent.snap_freeze.enabled then
                    if talent.flurry.enabled then gainCharges( "flurry", 1 ) end
                    addStack( "brain_freeze" )
                    addStack( "fingers_of_frost" )
                end
            end

            if azerite.frigid_grasp.enabled then
                applyBuff( "frigid_grasp", 10 )
                addStack( "fingers_of_frost" )
            end
        end,

        copy = { 12472, 198144, "ice_form" }
    },

    -- Channel an icy beam at the enemy for 4.4 sec, dealing 1,479 Frost damage every 0.9 sec and slowing movement by 70%. Each time Ray of Frost deals damage, its damage and snare increases by 10%. Generates 2 charges of Fingers of Frost over its duration.
    ray_of_frost = {
        id = 205021,
        cast = 5,
        channeled = true,
        cooldown = 60,
        gcd = "spell",
        school = "frost",

        spend = 0.02,
        spendType = "mana",

        talent = "ray_of_frost",
        startsCombat = true,
        texture = 1698700,

        toggle = "cooldowns",

        start = function ()
            applyDebuff( "target", "ray_of_frost" )
            if talent.bone_chilling.enabled then addStack( "bone_chilling" ) end
        end,
    },

    -- Summons a Ring of Frost for 10 sec at the target location. Enemies entering the ring are incapacitated for 10 sec. Limit 10 targets. When the incapacitate expires, enemies are slowed by 65% for 4 sec.
    ring_of_frost = {
        id = 113724,
        cast = 2,
        cooldown = 45,
        gcd = "spell",
        school = "frost",

        spend = 0.08,
        spendType = "mana",

        talent = "ring_of_frost",
        startsCombat = false,

        handler = function ()
        end,
    },

    -- Talent: Draw power from the Night Fae, dealing 2,168 Nature damage over 3.6 sec to enemies within 18 yds. While channeling, your Mage ability cooldowns are reduced by 12 sec over 3.6 sec.
    shifting_power = {
        id = function() return talent.shifting_power.enabled and 382440 or 314791 end,
        cast = function() return 4 * haste end,
        channeled = true,
        cooldown = 60,
        gcd = "spell",
        school = "nature",

        spend = 0.05,
        spendType = "mana",

        startsCombat = true,

        cdr = function ()
            return - action.shifting_power.execute_time / action.shifting_power.tick_time * ( -3 + conduit.discipline_of_the_grove.time_value )
        end,

        full_reduction = function ()
            return - action.shifting_power.execute_time / action.shifting_power.tick_time * ( -3 + conduit.discipline_of_the_grove.time_value )
        end,

        start = function ()
            applyBuff( "shifting_power" )
        end,

        tick  = function ()
            local seen = {}
            for _, a in pairs( spec.abilities ) do
                if not seen[ a.key ] and ( not talent.coldest_snap.enabled or a.key ~= "cone_of_cold" ) then
                    reduceCooldown( a.key, 3 )
                    seen[ a.key ] = true
                end
            end
        end,

        finish = function ()
            removeBuff( "shifting_power" )
        end,

        copy = { 382440, 314791 }
    },

    -- Summon a strong Blizzard that surrounds you for 6 sec that slows enemies by 80% and deals 246 Frost damage every 1 sec. Enemies that are caught in Snowdrift for 3 sec consecutively become Frozen in ice, stunned for 4 sec.
    snowdrift = {
        id = 389794,
        cast = 1.33,
        cooldown = 60,
        gcd = "spell",
        school = "frost",

        spend = 0.02,
        spendType = "mana",

        pvptalent = "snowdrift",
        startsCombat = false,
        texture = 135783,

        toggle = "cooldowns",

        handler = function ()
            applyBuff( "snowdrift" )
            if talent.bone_chilling.enabled then addStack( "bone_chilling" ) end
        end,
    },

    --[[ Summons a Water Elemental to follow and fight for you.
    water_elemental = {
        id = 31687,
        cast = 1.5,
        cooldown = 30,
        gcd = "spell",
        school = "frost",

        spend = 0.03,
        spendType = "mana",

        startsCombat = false,

        notalent = "lonely_winter",
        nomounted = true,

        usable = function () return not pet.alive, "must not have a pet" end,
        handler = function ()
            summonPet( "water_elemental" )
        end,

        copy = "summon_water_elemental"
    }, ]]

    -- Water Elemental Abilities
    freeze = {
        id = 33395,
        known = true,
        cast = 0,
        cooldown = 25,
        gcd = "off",
        school = "frost",

        startsCombat = true,

        usable = function () return pet.water_elemental.alive, "requires water elemental" end,
        handler = function ()
            applyDebuff( "target", "freeze" )
        end
    },

    water_jet = {
        id = 135029,
        known = true,
        cast = 0,
        cooldown = 45,
        gcd = "off",
        school = "frost",

        startsCombat = true,
        usable = function ()
            if not settings.manual_water_jet then return false, "requires manual water jet setting" end
            return pet.water_elemental.alive, "requires a living water elemental"
        end,
        handler = function()
            addStack( "brain_freeze" )
            gainCharges( "flurry", 1 )
        end
    }
} )


spec:RegisterOptions( {
    enabled = true,

    aoe = 3,

    nameplates = false,
    nameplateRange = 8,

    damage = true,
    damageExpiration = 6,

    potion = "phantom_fire",

    package = "Frost Mage",
} )


--[[ spec:RegisterSetting( "ignore_freezing_rain_st", true, {
    name = "Ignore |T629077:0|t Freezing Rain in Single-Target",
    desc = "If checked, the default action list will not recommend using |T135857:0|t Blizzard in single-target due to the |T629077:0|t Freezing Rain talent proc.",
    type = "toggle",
    width = "full",
} ) ]]

--[[ spec:RegisterSetting( "limit_ice_lance", false, {
    name = strformat( "Limit %s", Hekili:GetSpellLinkWithTexture( spec.abilities.ice_lance.id ) ),
    desc = strformat( "If checked, %s will recommended less often when %s, %s, and %s are talented.", Hekili:GetSpellLinkWithTexture( spec.abilities.ice_lance.id ),
        Hekili:GetSpellLinkWithTexture( spec.talents.slick_ice[2] ),
        Hekili:GetSpellLinkWithTexture( spec.talents.frozen_touch[2] ),
        Hekili:GetSpellLinkWithTexture( spec.talents.deep_shatter[2] ) ),
    type = "toggle",
    width = "full",
} )

spec:RegisterStateExpr( "limited_ice_lance", function()
    return settings.limit_ice_lance and talent.slick_ice.enabled and talent.frozen_touch.enabled and talent.deep_shatter.enabled
end ) ]]

--[[ spec:RegisterSetting( "manual_water_jet", false, {
    name = strformat( "%s: Manual Control", Hekili:GetSpellLinkWithTexture( spec.abilities.water_jet.id ) ),
    desc = strformat( "If checked, your pet's %s may be recommended for manual use instead of auto-cast by your pet.  "
        .. "This ability is available when your pet is summoned by %s.\n\n"
        .. "You will need to disable its auto-cast before using this feature.", Hekili:GetSpellLinkWithTexture( spec.abilities.water_jet.id ),
        Hekili:GetSpellLinkWithTexture( spec.abilities.icy_veins.id ) ),
    type = "toggle",
    width = "full",
} ) ]]

spec:RegisterSetting( "check_explosion_range", true, {
    name = strformat( "%s: Range Check", Hekili:GetSpellLinkWithTexture( 1449 ) ),
    desc = strformat( "If checked, %s will not be recommended when you are more than 10 yards from your target.", Hekili:GetSpellLinkWithTexture( 1449 ) ),
    type = "toggle",
    width = "full"
} )


spec:RegisterPack( "Frost Mage", 20231110, [[Hekili:TZr)VTnU1)w8DaU2ynUwoXn5UfhGB3Dd4kU1na3T9BwwwI2wlYsEIsj1fg6V99EK6dsksA50KE72kArtJe57l((Mp7fol(WI5bEzKfVFY4jx644mE04BU8MXtwmp7WEYI5798V3Bd8FI92b)7FonHMvS8VWE0EVdrjEbimOj5P(WJ2MLTN(9V5nBcZ2MVAKFYU3qd3Lh5LfMe7N6Tod)D)3Sy(Q8WOSFjEXk9eGZI5E5zBtsxmFE4UFeGCyqaHVCc1FXCC5x44CHZ4VVyzXYFbGozhjoZlQyjUJIL57rapQ4DfVRAXJVMT4)MxM)2ILaUM0EzJVPAz)qu4M4ILFiChPy5)0lDFXYhb(cqM)HIL)dsymvyBxFXKjSTjI9ILRtslwgtESy5RwNsiFYBve5vfljFCFkHsbPYFSyz2JeV7HnUnCDwy8gGatEKaBleW(p8x)zjK4Cfdj)us8RYmSL5Fa(5AaRjzBzVlKwSmL4ffbKDcSGF8NKbPJIuXz0unYLRVymNb)7uGVciRYxVEefwtWO89Lm6hi72NKINbO8syZtVWPCZLYL57tcJa6klnm(EsM0shFJWsH1SonzhxUccROWDHaoDd9jUrEX(eKrbX7Ap)SKuAPiik0)E8GcERh8ShjrrYOqMAyepJZBw0LxmHth)qqa7aJKgwPHLShvOl3x2wacFteCCwIXFfjRVPyjQJhmAbqm0mkAMaN5GjXkVm4xEpZ4diAaqWpt99IjUHXzaLs8ZwmNeJQkbl(tlYaJdCTnpzUFkidsd94a4bIljMSleLv3nRyjOv3hilViGAhHYjF4SNKoQeaflpEeelA24Lne0QOWp9jV0ae7x2zSFlI9gGSgDxSkjkBb(hWYDTxEuBM3pjh47u6EG3pbJxVfGJC5)IlkE5czxUxk)a65r2iVFntO1RyjLK5UkjoNoklKKE5y3j79TiYSlRbxJGgoCE(ENgIpnp2iT7LqqA)Qot71N3k0TJ7v797go9JiEpWq7udIBB7MwE6wcLQdxTepya8G7g)aWqBDuEA6bUGv4X(jGzqYAx)KOarnKDa3rbd8D20k4WueH(jaCsEm2f8)5NXKtdy)vKsQ0szVM5wl0peyh6OYDvEqpSf1UjYZp0lYLUp8Ec)TdSccdi42ILtzV0FRx6gc1DDkNNqNn8tya5db(5aSn3mCrGlfqsRrpVsAu7HuuGuQPkr4nog6x7y)XqMjPR)2qW1jkcns8a9DvZlxdHCWncNHmblFv6PCvT8A1nVd17xK4Hq8EHXacCLipgj4OhfQA0naZaRmTsjHtmL6PJuvKWJAJKZWgwrsqJe0BTtq6fFmnKjvuwVAhoIckz37v0R8s4umvIcH38jsSBs6kK8U2i5vIs0WKag)0yV9sko1yuWyTbH3HXxLxxdI1TmBN18vO1DSOpdbpjaNDtNDP2PyOnVLLxhsOPablTaPZk6(igJGRePjPv2LJuU(HeYWeVSezAO(45FNrjrhpBK4lXJB9QG2uig(mQu3asPfh6FW9bw261ReTMg3iCOLPr7UhZIgfroJpB)gwS5DuJiA1fTv)aCDf7HGmy6O3bPZ5LB5vYeFCYdEmOCPycDn59jNnNJjh(wtNBxYdSs74PzGjiznhJt5NAGs(g16MTIU3yeOyJQvLFOzxpMfXN8SShw(tzDJM8zBor3Ni4fDwyotuRaVTxcDhhkUjAKAO6EWHofVyYu7WryLJvoLKsQ0CMc1siXeK4uttMrsCR50ReIhaLTQXRP9ZRtjS4fLxdzAMhwh8SwVyN3hDlFPuQaaJEISuKfgv6ajRxZiAoe0yN9LHxGDHOdEcZhVJe3j6VYCAopp8hFRgZH53c2N5uUwayoBOZgVM97DEjAKLMtCFEZ2qliFgs5WeCnK3H8YVL7jILsxc20iGAwhUzBM7lA(jYotRCXl5GSu55CYKrkCGSTJMAV7zO(YAI4u2vmbSMAKXJGr3iRVZBgG9uCE60iBfRWSWD5ofgjuzypRfdBImnhh3kWqekhus8mnl17bsKBgRl2wZoSDsP6sz7ePhQPUN2X563HyLQzNy0vUJ5a36OWRBGsqQ3MKyQ7kqqMTLblZX925f7nApRvoqTvMRava(Ln1L8X9rjyR(zy46oLOSQ75NqIYyxqTMOmtJH8XTE5uwNoWIj7xFSKv2kF3hXo5lE0X18JsscIGDkLbKuSYA)FQngRYTyjcv99HnZXzSqnVNAhS61VPXdSfVQxjNciAvWyqDzPx79LDvfOzxmjkdC(KtBhVS9AC35rHLCOUiDJlClUWkEZK0L9C5dL63XnUVJ1yeRy6bWCVcrdAHljcvgv4RgwDlG6eiwldXMAHLdR3kecCFswPfKPAidaR4DRcJdiPUalTdPVSTe3nO1TlR0xrAcyFY)opC)EsWO4d7YHak5XmFLORrWzuCqzCmHOrwwyPUNQQj7(q4ITUqGAQdPUOmsusAk8pu2UO5X8wsTyEoLujDz3ZahDMxVKqazmn5auS8cqDAKZjpKMwLqvTs4uDfquZfG3L1HPeWPleIzR2CcLs1QYRuf0pnfHzovkcuqM9(BYWGXUlQE1w1HTVr0HETYTId9VtCr45fG1DQlINuxTKcTlDxNJxOH8YKU8SvGjnj9EqxuDztexwekMOU)R8GnSqekRvU9nGiJHDTTVPo6gKHand9qG6vYlnJDTq)wCvqwtT709u2(TF80V6O2DwsDF6sLStx40jB5GHccUQkpSZptvZE6pjX8sD9sE6sE1CUR20eeVPwXlIYApISw11xVnjtkkF92KQ54))42K(AtEErBYJfxfwADJvFf9)CUXjTUL)92vov)BwtOPAvJca4WhmnMoJKvt892tAP8CL4UokbozrvmzUN986yWTKlYmV54FDTBgcz8QRBgtvtB0DvKhv9m4TQKA5vEkNXiSlS8uCrLdd64RxmhQ(e1RGuL)aoMDHyrPzLdE3RkhOSxHkGqTCPO9mnbtJ3lplzhoBIS2fck24OA(RHXWRU87lw(JjXaUyV(vT8kdGllr3lQCAalyGZhhYMvqnuv9u(DE01KxA6YlHCEuKJEksmMTcnPlCEdvDcOw7rVfqBfnqfMx9IqPt1dvj)FkGvBIVDeU1nkvbMTAGQk8(UxajQbykgGubO6cV26S3Wb1tM1nbWpJZiT2o(b0NfBhPUQPqxA746jOl6ZJtMpdXLvNQF2W9TViQHx)I4U4MNrh4wHOuw7kavB5dDeUQ1uOAmAOKJoc9pZZSFp4KtVRd2CrFEMPF1C6RMtF1CQ4D)cZscb21vTqd)earZqtfShYjRdBgCn6O6uV)dZEJ6hPMI3PBvvDY41HRNjxa0DZM0VLQ1XJQl6s9WTUE02a(2ztqERCxZe)0Vu)uacQfO(AS00zqIiIls5dMbFnqI(VM)XozMJo(66(909HCrdV1waCsKZD31gTG0u3NqLtcpAMGWAeWAOOrOzCiM04vP)a9d55XJAhWZ(9ARMpufTnlhrAptTe54XEntTGciev3EsaqG(ScJ(d6PrQC8OLPoRVLEPE3KPM3B5kgRrGH3MbsN18t)2JpzdPkZbvpTUiaPZofjMn(IFD4Yt02mLhwpnBTyIQERiZg90mwGs6CVu0x)YlO9whD6NLt43NdT2VNHU59LHjuTTpl4Qcm5EQIG7u9K(oNXIMoc(nozVNHToSzVIH2e2SXomJ7wyD67R8TtgF8i2p5(s9sgESkNlDKwlhL6y8SP9nooG3vngaQQyS7VI55Pr)s(2S63Z24Zz1gP1G9DNZOBARMxtdNhInCnRG3wl9)wR7aw)lRfQ634XJANjV7eMhVJhnDTuwCbPgJ(QgvUAdI(ADOkgwPfBjplCAZAqDlQneg3uvFLV7YX9pjaQZrQLpaTP(u1GDX8bG0HG1xpgx1NjsJ1wvwmsnyH7WsEqRkvoBnPshpoO08Pzq0uSaN54GMM2xfKs5nOvUgl4ReJEY5QQXePmpO2dDvJ7rRtFwjzzBYZ0kmypR9eN1hL23n2cuFGpLzvwCcZxw5MuNTSwSoFAVq(Z0bIgr4BhBxc2H5VcX4Gtpwy97YiHbNZYh(tStEMMxRxlmEx885himZwvoQVy8ihTsLPd5hytpb29KgvkPqLkZJfhE6X2KwNbnERXTnt1TaRyi5D0mGGgOy4fF73wS8N)iOGZM(BuPIcfiMsyFRxGFhq8qY9yzJRouW)(zWliauO4FBqWEW(iVd43ygGpm8Bsd)Tjj43Rfy1PqPtB2q4FZoSdwjOoJbJIomIJyfYLHlWniNACrIHltzjDafGUoVY9it7x(X8HF5SG7k87AcutdouO572XZSP0yt9vLWxg2nZwwR3upozQVrzcYADoxn0yQVqEoXKCEZkvSDrnTgnmPe)ftqudSk13K(OoYnBuYwyWaDdKv)25jb1bp0wPhd0Ufna6wiHRwP4mBYWHAyJM0m0WjAlxY4KvPHsGSgSK6IgYr0fGokYqImZC0aRULA6a((0pXugZCsNOuUSDl89TtoV03lD6PdNDPdf2gXjSmeBLJdV2KiVDIxxQHapZ(E1xx)qfY8uPxM91lglZhwEMJ002jDs0Uvk3tRkUNCbCNQ2nTHfpl7GZ11Gf17(wA40jlerc7gRfrV1NAs(nwjDop)QNXINCWLnjnS6nuh6g4Oq7UQNDgbbT4u2yCtiVQNooZYFMOfkndnJrkG)TCLGWGM98eZKbhJvtB2)I5inNtmv1oXkU22vPBncS24HAJ61Xs9PsY(VOHCzOwkCB3cVY2xNCP85hALM9LnSAPc))DgsL(eUgPFZcNYi2Ufk9)T6kA3npS5f4Lk6knR7rwPz6JQYnsSgrf)O7r8x8(3EfBElx8F(d]] )