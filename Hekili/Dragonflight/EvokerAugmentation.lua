-- EvokerAugmentation.lua
-- October 2023

if UnitClassBase( "player" ) ~= "EVOKER" then return end

local addon, ns = ...
local Hekili = _G[ addon ]
local class, state = Hekili.Class, Hekili.State

local spec = Hekili:NewSpecialization( 1473 )

local strformat = string.format


-- Resources
spec:RegisterResource( Enum.PowerType.Mana )
spec:RegisterResource( Enum.PowerType.Essence )

-- Talents
spec:RegisterTalents( {
    -- Evoker
    aerial_mastery        = { 93352, 365933, 1 }, -- Hover gains 1 additional charge.
    ancient_flame         = { 93271, 369990, 1 }, -- Casting Emerald Blossom or Verdant Embrace reduces the cast time of your next Living Flame by 40%.
    attuned_to_the_dream  = { 93292, 376930, 2 }, -- Your healing done and healing received are increased by 2%.
    blast_furnace         = { 93309, 375510, 1 }, -- Fire Breath's damage over time lasts 4 sec longer.
    bountiful_bloom       = { 93291, 370886, 1 }, -- Emerald Blossom heals 2 additional allies.
    cauterizing_flame     = { 93294, 374251, 1 }, -- Cauterize an ally's wounds, removing all Bleed, Poison, Curse, and Disease effects. Heals for 18,417 upon removing any effect.
    clobbering_sweep      = { 93296, 375443, 1 }, -- Tail Swipe's cooldown is reduced by 45 sec.
    draconic_legacy       = { 93300, 376166, 1 }, -- Your Stamina is increased by 6%.
    enkindled             = { 93295, 375554, 2 }, -- Living Flame deals 3% more damage and healing.
    extended_flight       = { 93349, 375517, 2 }, -- Hover lasts 4 sec longer.
    exuberance            = { 93299, 375542, 1 }, -- While above 75% health, your movement speed is increased by 10%.
    fire_within           = { 93345, 375577, 1 }, -- Renewing Blaze's cooldown is reduced by 30 sec.
    foci_of_life          = { 93345, 375574, 1 }, -- Renewing Blaze restores you more quickly, causing damage you take to be healed back over 4 sec.
    forger_of_mountains   = { 93270, 375528, 1 }, -- Landslide's cooldown is reduced by 30 sec, and it can withstand 200% more damage before breaking.
    heavy_wingbeats       = { 93296, 368838, 1 }, -- Wing Buffet's cooldown is reduced by 45 sec.
    inherent_resistance   = { 93355, 375544, 2 }, -- Magic damage taken reduced by 2%.
    innate_magic          = { 93302, 375520, 2 }, -- Essence regenerates 5% faster.
    instinctive_arcana    = { 93310, 376164, 2 }, -- Your Magic damage done is increased by 2%.
    leaping_flames        = { 93343, 369939, 1 }, -- Fire Breath causes your next Living Flame to strike 1 additional target per empower level.
    lush_growth           = { 93347, 375561, 2 }, -- Green spells restore 5% more health.
    obsidian_bulwark      = { 93289, 375406, 1 }, -- Obsidian Scales has an additional charge.
    oppressing_roar       = { 93298, 372048, 1 }, -- Let out a bone-shaking roar at enemies in a cone in front of you, increasing the duration of crowd controls that affect them by 50% in the next 10 sec.
    overawe               = { 93297, 374346, 1 }, -- Oppressing Roar removes 1 Enrage effect from each enemy, and its cooldown is reduced by 20 sec for each Enrage dispelled.
    panacea               = { 93348, 387761, 1 }, -- Emerald Blossom instantly heals you for 18,910 when cast.
    permeating_chill      = { 93303, 370897, 1 }, -- Your damaging Blue spells reduce the target's movement speed by 50% for 3 sec.
    potent_mana           = { 93715, 418101, 1 }, -- Source of Magic increases the target's healing and damage done by 3%.
    protracted_talons     = { 93307, 369909, 1 }, -- Azure Strike damages 1 additional enemy.
    quell                 = { 93311, 351338, 1 }, -- Interrupt an enemy's spellcasting and prevent any spell from that school of magic from being cast for 4 sec.
    recall                = { 93301, 371806, 1 }, -- You may reactivate Breath of Eons within 3 sec after landing to travel back in time to your takeoff location.
    regenerative_magic    = { 93353, 387787, 1 }, -- Your Leech is increased by 3%.
    renewing_blaze        = { 93344, 374348, 1 }, -- The flames of life surround you for 8.5 sec. While this effect is active, 100% of damage you take is healed back over 4 sec.
    rescue                = { 93288, 370665, 1 }, -- Swoop to an ally and fly with them to the target location.
    scarlet_adaptation    = { 93340, 372469, 1 }, -- Store 20% of your effective healing, up to 11,630. Your next damaging Living Flame consumes all stored healing to increase its damage dealt.
    sleep_walk            = { 93293, 360806, 1 }, -- Disorient an enemy for 20 sec, causing them to sleep walk towards you. Damage has a chance to awaken them.
    source_of_magic       = { 93354, 369459, 1 }, -- Redirect your excess magic to a friendly healer for 32.0 min. When you cast an empowered spell, you restore 0.25% of their maximum mana per empower level. Limit 1.
    tailwind              = { 93290, 375556, 1 }, -- Hover increases your movement speed by 70% for the first 4 sec.
    terror_of_the_skies   = { 93342, 371032, 1 }, -- Breath of Eons stuns enemies for 3 sec.
    time_spiral           = { 93351, 374968, 1 }, -- Bend time, allowing you and your allies within 40 yds to cast their major movement ability once in the next 10.7 sec, even if it is on cooldown.
    tip_the_scales        = { 93350, 370553, 1 }, -- Compress time to make your next empowered spell cast instantly at its maximum empower level.
    twin_guardian         = { 93287, 370888, 1 }, -- Rescue protects you and your ally from harm, absorbing damage equal to 30% of your maximum health for 5.3 sec.
    unravel               = { 93308, 368432, 1 }, -- Sunder an enemy's protective magic, dealing 27,362 Spellfrost damage to absorb shields.
    walloping_blow        = { 93286, 387341, 1 }, -- Wing Buffet and Tail Swipe knock enemies further and daze them, reducing movement speed by 70% for 4 sec.
    zephyr                = { 93346, 374227, 1 }, -- Conjure an updraft to lift you and your 4 nearest allies within 20 yds into the air, reducing damage taken from area-of-effect attacks by 20% and increasing movement speed by 30% for 8.5 sec.

    -- Augmentation
    accretion             = { 93229, 407876, 1 }, -- Eruption reduces the remaining cooldown of Upheaval by 1.0 sec.
    anachronism           = { 93223, 407869, 1 }, -- Prescience has a 35% chance to grant Essence Burst.
    aspects_favor         = { 93217, 407243, 2 }, -- Obsidian Scales activates Black Attunement, and amplifies it to increase maximum health by 12.0% for 12.8 sec. Hover activates Bronze Attunement, and amplifies it to increase movement speed by 25% for 4.3 sec.
    bestow_weyrnstone     = { 93195, 408233, 1 }, -- Conjure a pair of Weyrnstones, one for your target ally and one for yourself. Only one ally may bear your Weyrnstone at a time. A Weyrnstone can be activated by the bearer to transport them to the other Weyrnstone's location, if they are within 100 yds.
    blistering_scales     = { 93209, 360827, 1 }, -- Protect an ally with 15 explosive dragonscales, increasing their Armor by 30% of your own. Melee attacks against the target cause 1 scale to explode, dealing 1,641 Volcanic damage to enemies near them. This damage can only occur every few sec. Blistering Scales can only be placed on one target at a time. Casts on your enemy's target if they have one.
    breath_of_eons        = { 93234, 403631, 1 }, -- Fly to the targeted location, exposing Temporal Wounds on enemies in your path for 10.7 sec. Temporal Wounds accumulate 21% of damage dealt by your allies affected by Ebon Might, then critically strike for that amount as Arcane damage. Applies Ebon Might for 5 sec. Removes all root effects. You are immune to movement impairing and loss of control effects while flying.
    chrono_ward           = { 93235, 409676, 1 }, -- When allies deal damage with Temporal Wounds, they gain a shield for 100% of the damage dealt. Absorption cannot exceed 30% of your maximum health.
    defy_fate             = { 93222, 404195, 1 }, -- Fatal attacks are diverted into a nearby timeline, preventing the damage, and your death, in this one. The release of temporal energy restores 79,323 health to you, and 26,441 to 4 nearby allies, over 9 sec. Healing starts high and declines over the duration. May only occur once every 6 min.
    draconic_attunements  = { 93218, 403208, 1 }, -- Learn to attune yourself to the essence of the Black or Bronze Dragonflights: Black Attunement: You and your 4 nearest allies have 4% increased maximum health. Bronze Attunement:You and your 4 nearest allies have 10% increased movement speed.
    dream_of_spring       = { 93359, 414969, 1 }, -- Emerald Blossom no longer has a cooldown, deals 35% increased healing, and increases the duration of your active Ebon Might effects by 1 sec, but costs 3 Essence.
    ebon_might            = { 93198, 395152, 1 }, -- Increase your 4 nearest allies' primary stat by 14% of your own, and cause you to deal 14% more damage, for 10.7 sec. May only affect 4 allies at once, and prefers to imbue damage dealers. Eruption, Breath of Eons, and your empower spells extend the duration of these effects.
    echoing_strike        = { 93221, 410784, 1 }, -- Azure Strike has a 10% chance per target hit to echo, casting again.
    eruption              = { 93200, 395160, 1 }, -- Cause a violent eruption beneath an enemy's feet, dealing 10,944 Volcanic damage split between them and nearby enemies. Increases the duration of your active Ebon Might effects by 1 sec.
    essence_attunement    = { 93219, 375722, 1 }, -- Essence Burst stacks 2 times.
    essence_burst         = { 93220, 396187, 1 }, -- Your Living Flame has a 20% chance, and your Azure Strike has a 15% chance, to make your next Eruption cost no Essence. Stacks 2 times.
    expunge               = { 93306, 365585, 1 }, -- Expunge toxins affecting an ally, removing all Poison effects.
    fate_mirror           = { 93367, 412774, 1 }, -- Prescience grants the ally a chance for their spells and abilities to echo their damage or healing, dealing 15% of the amount again.
    font_of_magic         = { 93207, 408083, 1 }, -- Your empower spells' maximum level is increased by 1, and they reach maximum empower level 20% faster.
    geomancy              = { 93360, 410787, 1 }, -- Azure Strike reduces the remaining cooldown of Landslide by 1 sec per target hit.
    hoarded_power         = { 93212, 375796, 1 }, -- Essence Burst has a 20% chance to not be consumed.
    ignition_rush         = { 93230, 408775, 1 }, -- Essence Burst reduces the cast time of Eruption by 40%.
    imposing_presence     = { 93199, 371016, 1 }, -- Quell's cooldown is reduced by 20 sec.
    infernos_blessing     = { 93197, 410261, 1 }, -- Fire Breath grants the inferno's blessing for 8.5 sec to you and your allies affected by Ebon Might, giving their damaging attacks and spells a high chance to deal an additional 4,815 Fire damage.
    inner_radiance        = { 93199, 386405, 1 }, -- Your Living Flame and Emerald Blossom are 30% more effective on yourself.
    interwoven_threads    = { 93369, 412713, 1 }, -- The cooldowns of your spells are reduced by 10%.
    landslide             = { 93305, 358385, 1 }, -- Conjure a path of shifting stone towards the target location, rooting enemies for 30 sec. Damage may cancel the effect.
    molten_blood          = { 93211, 410643, 1 }, -- When cast, Blistering Scales grants the target a shield that absorbs up to 94,715 damage for 32.0 sec based on their missing health. Lower health targets gain a larger shield.
    momentum_shift        = { 93231, 408004, 1 }, -- Consuming Essence Burst grants you 5% Intellect for 6.4 sec. Stacks up to 2 times.
    motes_of_possibility  = { 93227, 409267, 1 }, -- Essence abilities have a chance to form a mote of diverted time near you. Anyone who comes in contact with the mote gains 10 seconds of reduced cooldown to their major ability.
    natural_convergence   = { 93312, 369913, 1 }, -- Disintegrate channels 20% faster and Eruption's cast time is reduced by 20%.
    obsidian_scales       = { 93304, 363916, 1 }, -- Reinforce your scales, reducing damage taken by 30%. Lasts 12.8 sec.
    overlord              = { 93213, 410260, 1 }, -- Breath of Eons casts an Eruption at the first 3 enemies struck.
    perilous_fate         = { 93235, 410253, 1 }, -- Breath of Eons reduces enemies' movement speed by 70%, and reduces their attack speed by 50%, for 10.7 sec.
    plot_the_future       = { 93226, 407866, 1 }, -- Breath of Eons grants you Fury of the Aspects for 15 sec after you land, without causing Exhaustion.
    power_nexus           = { 93201, 369908, 1 }, -- Increases your maximum Essence to 6.
    prescience            = { 93358, 409311, 1 }, -- Grant an ally the gift of foresight, increasing their critical strike chance by $410089s1% $?s412774[and occasionally copying their damage and healing spells at $412774s1% power ][]for $410089d.; Affects the nearest ally within $s2 yds, preferring damage dealers, if you do not have an ally targeted.    prolong_life          = { 93359, 410687, 1 }, -- Your effects that extend Ebon Might also extend Symbiotic Bloom.
    pupil_of_alexstrasza  = { 93221, 407814, 1 }, -- When cast at an enemy, Living Flame strikes 1 additional enemy for 100% damage.
    reactive_hide         = { 93210, 409329, 1 }, -- Each time Blistering Scales explodes it deals 10% more damage for 12.8 sec, stacking 10 times.
    regenerative_chitin   = { 93211, 406907, 1 }, -- Blistering Scales has 5 more scales, and casting Eruption restores 1 scale.
    ricocheting_pyroclast = { 93208, 406659, 1 }, -- Eruption deals 30% more damage per enemy struck, up to 150%.
    seismic_slam          = { 93205, 408543, 2 }, -- Landslide causes enemies who are mid-air to be slammed to the ground, stunning them for 2 sec.
    spatial_paradox       = { 93225, 406732, 1 }, -- Evoke a paradox for you and a friendly healer, allowing casting while moving and increasing the range of most spells by 100% for 10.7 sec. Affects the nearest healer within 60 yds, if you do not have a healer targeted.
    stretch_time          = { 93382, 410352, 1 }, -- While flying during Breath of Eons, 50% of damage you would take is instead dealt over 10 sec.
    symbiotic_bloom       = { 93215, 410685, 2 }, -- Emerald Blossom increases targets' healing received by 3% for 10.7 sec.
    tectonic_locus        = { 93202, 408002, 1 }, -- Upheaval deals 50% increased damage to the primary target, and launches them higher.
    time_skip             = { 93232, 404977, 1 }, -- Surge forward in time, causing your cooldowns to recover 1,000% faster for 2 sec.
    timelessness          = { 93368, 412710, 1 }, -- Enchant an ally to appear out of sync with the normal flow of time, reducing threat they generate by 30% for 32.0 min. Less effective on tank-specialized allies. May only be placed on one target at a time.
    tomorrow_today        = { 93369, 412723, 1 }, -- Time Skip channels for 1 sec longer.
    unyielding_domain     = { 93202, 412733, 1 }, -- Upheaval cannot be interrupted, and has an additional 10% chance to critically strike.
    upheaval              = { 93203, 396286, 1 }, -- Gather earthen power beneath your enemy's feet and send them hurtling upwards, dealing 23,531 Volcanic damage to the target and nearby enemies. Increases the duration of your active Ebon Might effects by 2 sec. Empowering expands the area of effect. I: 3 yd radius. II: 6 yd radius. III: 9 yd radius.
    verdant_embrace       = { 93341, 360995, 1 }, -- Fly to an ally and heal them for 31,661, or heal yourself for the same amount.
    volcanism             = { 93206, 406904, 1 }, -- Eruption's Essence cost is reduced by 1.
} )


-- PvP Talents
spec:RegisterPvpTalents( {
    born_in_flame        = 5612, -- (414937) Casting Ebon Might grants $s3 charges of Burnout, reducing the cast time of Living Flame by $375802s1%.
    chrono_loop          = 5564, -- (383005) Trap the enemy in a time loop for 5 sec. Afterwards, they are returned to their previous location and health. Cannot reduce an enemy's health below 20%.
    divide_and_conquer   = 5557, -- (384689) Breath of Eons forms curtains of fire, preventing line of sight to enemies outside its walls and burning enemies who walk through them for 39,401 Fire damage. Lasts 6 sec.
    dream_catcher        = 5613, -- (410962) Sleep Walk no longer has a cooldown, but its cast time is increased by 0.2 sec.
    dream_projection     = 5559, -- (377509) Summon a flying projection of yourself that heals allies you pass through for 12,103. Detonating your projection dispels all nearby allies of Magical effects, and heals for 59,908 over 20 sec.
    dreamwalkers_embrace = 5615, -- (415651) Verdant Embrace tethers you to an ally, increasing movement speed by 40% and slowing and siphoning 6,840 life from enemies who come in contact with the tether. The tether lasts up to 10 sec or until you move more than 30 yards away from your ally.
    nullifying_shroud    = 5558, -- (378464) Wreathe yourself in arcane energy, preventing the next 3 full loss of control effects against you. Lasts 30 sec.
    obsidian_mettle      = 5563, -- (378444) While Obsidian Scales is active you gain immunity to interrupt, silence, and pushback effects.
    scouring_flame       = 5561, -- (378438) Fire Breath burns away 1 beneficial Magic effect per empower level from all targets.
    swoop_up             = 5562, -- (370388) Grab an enemy and fly with them to the target location.
    time_stop            = 5619, -- (378441) Freeze an ally's timestream for 5 sec. While frozen in time they are invulnerable, cannot act, and auras do not progress. You may reactivate Time Stop to end this effect early.
    unburdened_flight    = 5560, -- (378437) Hover makes you immune to movement speed reduction effects.
} )

-- Auras
spec:RegisterAuras( {
    -- The cast time of your next Living Flame is reduced by $w1%.
    ancient_flame = {
        id = 375583,
        duration = 3600,
        max_stack = 1,
    },
    -- Black Attunement grants $w1% additional health.
    black_aspects_favor = {
        id = 407254,
        duration = function() return 12.0 * ( 1 + 1.25 * stat.mastery_value ) end,
        max_stack = 1,
    },
    -- Maximum health increased by $w1%.
    black_attunement = {
        id = 403264,
        duration = 3600,
        tick_time = 2.0,
        max_stack = 1,
    },
    -- $?$w1>0[Armor increased by $w1.][Armor increased by $w2%.] Melee attacks against you have a chance to cause an explosion of Volcanic damage.
    blistering_scales = {
        id = 360827,
        duration = function() return 600.0 * ( 1 + 1.25 * stat.mastery_value ) end,
        max_stack = function() return 15 + talent.regenerative_chitin.rank * 5 end,
        dot = "buff",
        friendly = true,
        no_ticks = true
    },
    -- Exposing Temporal Wounds on enemies in your path. Immune to crowd control.
    breath_of_eons = {
        id = 403631,
        duration = 6.0,
        max_stack = 1,
    },
    -- Bronze Attunement's grants $w1% additional movement speed.
    bronze_aspects_favor = {
        id = 407244,
        duration = function() return 4.0 * ( 1 + 1.25 * stat.mastery_value ) end,
        max_stack = 1,
    },
    bronze_attunement = {
        id = 403265,
        duration = 3600,
        tick_time = 2.0,
        max_stack = 1,
    },
    -- Next Living Flame's cast time is reduced by $w1%.
    burnout = {
        id = 375802,
        duration = 15.0,
        max_stack = 2,
    },
    -- Trapped in a time loop.
    chrono_loop = {
        id = 383005,
        duration = 5.0,
        max_stack = 1,
    },
    -- Absorbing $w1 damage.
    chrono_ward = {
        id = 409678,
        duration = function() return 20.0 * ( 1 + 1.25 * stat.mastery_value ) end,
        max_stack = 1,
        dot = "buff",
        friendly = true,
        no_ticks = true
    },
    -- Suffering $w1 Volcanic damage every $t1 sec.
    deep_breath = {
        id = 353759,
        duration = 1.0,
        tick_time = 0.5,
        max_stack = 1,
    },
    -- Healing $w1 every $t1 sec.
    defy_fate = {
        id = 404381,
        duration = 9.0,
        max_stack = 1,
        dot = "buff",
        friendly = true
    },
    -- Suffering $w1 Spellfrost damage every $t1 sec.
    disintegrate = {
        id = 356995,
        duration = function() return 3.0 * ( talent.natural_convergence.enabled and 0.8 or 1 ) * haste end,
        tick_time = function() return ( talent.natural_convergence.enabled and 0.8 or 1 ) * haste end,
        max_stack = 1,
    },
    -- Burning for $s1 every $t1 sec.
    divide_and_conquer = {
        id = 403516,
        duration = 6.0,
        tick_time = 3.0,
        max_stack = 1,
    },
    -- Tethered with an ally, causing enemies who touch the tether to be damaged and slowed.
    dreamwalkers_embrace = {
        id = 415516,
        duration = 10.0,
        tick_time = 0.5,
        max_stack = 1,
        dot = "buff",
        friendly = true
    },
    -- Your Ebon Might is active on allies.; Your damage done is increased by $w1%.
    ebon_might = {
        id = 395296,
        duration = function() return 10.0 * ( 1 + 1.25 * stat.mastery_value ) end,
        tick_time = 1.0,
        pandemic = true,
        max_stack = 1,
        dot = "buff",
        friendly = true,
        no_ticks = true
    },
    -- Your next Eruption $?s414969[or Emerald Blossom ][]costs no Essence.
    essence_burst = {
        id = 392268,
        duration = function() return 15.0 * ( 1 + 1.25 * stat.mastery_value ) end,
        max_stack = function() return 1 + ( talent.essence_attunement.enabled and 1 or 0 ) end,
    },
    -- Movement speed increased by $w2%.; Evoker spells may be cast while moving. Does not affect empowered spells.$?e9[; Immune to movement speed reduction effects.][]
    hover = {
        id = 358267,
        duration = function() return ( 6.0 + ( talent.extended_flight.enabled and 4 or 0 ) ) end,
        tick_time = 1.0,
        max_stack = 1,
    },
    -- Granted the inferno's blessing by $@auracaster, giving your damaging attacks and spells a high chance to deal additional Fire damage.
    infernos_blessing = {
        id = 410263,
        duration = function() return 8.0 * ( 1 + 1.25 * stat.mastery_value ) end,
        max_stack = 1,
        dot = "buff",
        friendly = true,
        no_ticks = true
    },
    -- Rooted.
    landslide = {
        id = 355689,
        duration = 30.0,
        max_stack = 1,
    },
    -- Absorbing $w1 damage.; Immune to interrupts and silence effects.
    lava_shield = {
        id = 405295,
        duration = function() return 15.0 * ( 1 + 1.25 * stat.mastery_value ) end,
        max_stack = 1,
        dot = "buff",
        friendly = true,
        no_ticks = true
    },
    -- Your next Living Flame will strike $w1 additional $?$w1=1[target][targets].
    leaping_flames = {
        id = 370901,
        duration = function() return 30.0 * ( 1 + 1.25 * stat.mastery_value ) end,
        max_stack = 1,
    },
    -- Healing for $w2 every $t2 sec.
    living_flame = {
        id = 361509,
        duration = 12.0,
        max_stack = 1,
        dot = "buff",
        friendly = true
    },
    -- Absorbing $w1 damage.
    molten_blood = {
        id = 410651,
        duration = function() return 30.0 * ( 1 + 1.25 * stat.mastery_value ) end,
        max_stack = 1,
        dot = "buff",
        friendly = true,
        no_ticks = true
    },
    -- Intellect increased by $w1%.
    momentum_shift = {
        id = 408005,
        duration = function() return 6.0 * ( 1 + 1.25 * stat.mastery_value ) end,
        max_stack = 1,
        dot = "buff",
        friendly = true,
        no_ticks = true
    },
    -- Your next Emerald Blossom will restore an additional $406054s1% of maximum health to you.
    nourishing_sands = {
        id = 406043,
        duration = function() return 20.0 * ( 1 + 1.25 * stat.mastery_value ) end,
        max_stack = 1,
    },
    -- Warded against full loss of control effects.
    nullifying_shroud = {
        id = 378464,
        duration = 30.0,
        max_stack = 3,
    },
    -- Damage taken reduced by $w1%.$?$w2=1[; Immune to interrupt and silence effects.][]
    obsidian_scales = {
        id = 363916,
        duration = function() return 12.0 * ( 1 + 1.25 * stat.mastery_value ) end,
        max_stack = 1,
    },
    -- The duration of incoming crowd control effects are increased by $s2%.
    oppressing_roar = {
        id = 372048,
        duration = 10.0,
        max_stack = 1,
    },
    -- Movement speed reduced by $w1%.
    permeating_chill = {
        id = 370898,
        duration = 3.0,
        max_stack = 1,
    },
    -- $?$W1>0[$@auracaster is increasing your critical strike chance by $w1%.][]$?e0&e1[; ][]$?e1[Your abilities have a chance to echo $412774s1% of their damage and healing.][]
    prescience = {
        id = 410089,
        duration = function() return 18.0 * ( 1 + 1.25 * stat.mastery_value ) end,
        max_stack = 1,
        dot = "buff",
        friendly = true
    },
    prescience_applied = {
        duration = function() return 18.0 * ( 1 + 1.25 * stat.mastery_value ) end,
        max_stack = 1,
    },
    -- Blistering Scales deals $w1% increased damage.
    reactive_hide = {
        id = 410256,
        duration = function() return 12.0 * ( 1 + 1.25 * stat.mastery_value ) end,
        max_stack = 1,
    },
    recall = {
        id = 403760,
        duration = 3,
        max_stack = 1
    },
    -- Restoring $w1 health every $t1 sec.
    renewing_blaze = {
        id = 374349,
        duration = function() return ( 8.0 - ( talent.foci_of_life.enabled and 4 or 0 ) ) * ( 1 + 1.25 * stat.mastery_value ) end,
        max_stack = 1,
    },
    -- About to be picked up!
    rescue = {
        id = 370665,
        duration = 1.0,
        max_stack = 1,
    },
    -- Versatility increased by ${$W1}.1%. Cast by $@auracaster.
    shifting_sands = {
        id = 413984,
        duration = function() return 10.0 * ( 1 + 1.25 * stat.mastery_value ) end,
        tick_time = 1.0,
        max_stack = 1,
        dot = "buff",
        no_ticks = true,
        friendly = true
    },
    -- Asleep.
    sleep_walk = {
        id = 360806,
        duration = 20.0,
        max_stack = 1,
    },
    -- $@auracaster is restoring mana to you when they cast an empowered spell.$?$w2>0[; Healing and damage done increased by $w2%.][]
    source_of_magic = {
        id = 369459,
        duration = function() return 3600.0 * ( 1 + 1.25 * stat.mastery_value ) end,
        max_stack = 1,
        dot = "buff",
        no_ticks = true,
        friendly = true
    },
    -- Able to cast spells while moving and range increased by $s5%. Cast by $@auracaster.
    spatial_paradox = {
        id = 406789,
        duration = function() return 10.0 * ( 1 + 1.25 * stat.mastery_value ) end,
        tick_time = 1.0,
        max_stack = 1,
        dot = "buff",
        no_ticks = true,
        friendly = true
    },
    -- $w1% of damage is being delayed and dealt to you over time.
    stretch_time = {
        id = 410355,
        duration = 10.0,
        max_stack = 1,
    },
    -- About to be grabbed!
    swoop_up = {
        id = 370388,
        duration = 1.0,
        max_stack = 1,
    },
    -- Healing received increased by $w1%.
    symbiotic_bloom = {
        id = 410686,
        duration = function() return 10.0 * ( 1 + 1.25 * stat.mastery_value ) end,
        max_stack = 1,
        dot = "buff",
        no_ticks = true,
        friendly = true
    },
    -- Accumulating damage from $@auracaster's allies who are affected by Ebon Might.$?$w2<0[; Movement speed reduced by $w2%.; Attack speed reduced by $w3%.][]
    temporal_wound = {
        id = 409560,
        duration = function() return 10.0 * ( 1 + 1.25 * stat.mastery_value ) end,
        tick_time = 1.0,
        max_stack = 1,
    },
    -- Stunned.
    terror_of_the_skies = {
        id = 372245,
        duration = 3.0,
        max_stack = 1,
    },
    -- Surging forward in time, causing your cooldowns to recover $s1% faster.
    time_skip = {
        id = 404977,
        duration = function() return 2.0 + ( talent.tomorrow_today.enabled and 1 or 0 ) end,
        max_stack = 1,
    },
    -- May use Hover once, without incurring its cooldown.
    time_spiral = {
        id = 375234,
        duration = function() return 10.0 * ( 1 + 1.25 * stat.mastery_value ) end,
        max_stack = 1,
    },
    -- Frozen in time, incapacitated and invulnerable.
    time_stop = {
        id = 378441,
        duration = 5.0,
        max_stack = 1,
    },
    -- Threat generation reduced by $w1%. Cast by $@auracaster.
    timelessness = {
        id = 412710,
        duration = function() return 1800.0 * ( 1 + 1.25 * stat.mastery_value ) end,
        max_stack = 1,
        dot = "buff",
        no_ticks = true,
        friendly = true
    },
    -- Your next empowered spell casts instantly at its maximum empower level.
    tip_the_scales = {
        id = 370553,
        duration = 3600,
        max_stack = 1,
        onRemove = function()
            setCooldown( "tip_the_scales", action.tip_the_scales.cooldown )
        end,
    },
    -- Absorbing $w1 damage.
    twin_guardian = {
        id = 370889,
        duration = function() return 5.0 * ( 1 + 1.25 * stat.mastery_value ) end,
        max_stack = 1,
        dot = "buff",
        no_ticks = true,
        friendly = true
    },
    -- Damage taken from area-of-effect attacks reduced by $w1%.; Movement speed increased by $w2%.
    zephyr = {
        id = 374227,
        duration = function() return 8.0 * ( 1 + 1.25 * stat.mastery_value ) end,
        max_stack = 1,
        dot = "buff",
        no_ticks = true,
        friendly = true
    },
} )

local lastEssenceTick = 0

do
    local previous = 0

    spec:RegisterUnitEvent( "UNIT_POWER_UPDATE", "player", nil, function( event, unit, power )
        if power == "ESSENCE" then
            local value, cap = UnitPower( "player", Enum.PowerType.Essence ), UnitPowerMax( "player", Enum.PowerType.Essence )

            if value == cap then
                lastEssenceTick = 0

            elseif lastEssenceTick == 0 and value < cap or lastEssenceTick ~= 0 and value > previous then
                lastEssenceTick = GetTime()
            end

            previous = value
        end
    end )
end


spec:RegisterStateExpr( "empowerment_level", function()
    return buff.tip_the_scales.down and args.empower_to or max_empower
end )

-- This deserves a better fix; when args.empower_to = "maximum" this will cause that value to become max_empower (i.e., 3 or 4).
spec:RegisterStateExpr( "maximum", function()
    return max_empower
end )


spec:RegisterHook( "runHandler", function( action )
    local ability = class.abilities[ action ]
    local color = ability.color

    if color then
        if color == "red" and buff.iridescence_red.up then removeStack( "iridescence_red" )
        elseif color == "blue" and buff.iridescence_blue.up then removeStack( "iridescence_blue" ) end
    end

    if talent.power_swell.enabled and ability.empowered then
        applyBuff( "power_swell" ) -- TODO: Modify Essence regen rate.
    end

    empowerment.active = false
end )


spec:RegisterGear( "tier29", 200381, 200383, 200378, 200380, 200382 )
spec:RegisterGear( "tier30", 202491, 202489, 202488, 202487, 202486 )
spec:RegisterGear( "tier31", 207225, 207226, 207227, 207228, 207230, 217178, 217180, 217176, 217177, 217179 )
spec:RegisterAuras( {
    t31_2pc_proc = {
        duration = 3600,
        max_stack = 1
    },
    t31_2pc_stacks = {
        duration = 3600,
        max_stack = 3
    },
    trembling_earth = {
        id = 424368,
        duration = 3600,
        max_stack = 5
    }
} )


spec:RegisterHook( "reset_precast", function()
    max_empower = talent.font_of_magic.enabled and 4 or 3

    if essence.current < essence.max and lastEssenceTick > 0 then
        local partial = min( 0.95, ( query_time - lastEssenceTick ) * essence.regen )
        gain( partial, "essence" )
        if Hekili.ActiveDebug then Hekili:Debug( "Essence increased to %.2f from passive regen.", partial ) end
    end

    local prescience_remains = action.prescience.lastCast + class.auras.prescience.duration - query_time
    if prescience_remains > 0 then
        applyBuff( "prescience_applied", prescience_remains )
    end
end )


spec:RegisterStateTable( "evoker", setmetatable( {},{
    __index = function( t, k )
        if k == "use_early_chaining" then k = "use_early_chain" end
        local val = state.settings[ k ]
        if val ~= nil then return val end
        return false
    end
} ) )


local empowered_cast_time

do
    local stages = {
        1,
        1.75,
        2.5,
        3.25
    }

    empowered_cast_time = setfenv( function()
        if buff.tip_the_scales.up then return 0 end
        local power_level = args.empower_to or max_empower

        if settings.fire_breath_fixed > 0 then
            power_level = min( settings.fire_breath_fixed, max_empower )
        end

        return stages[ power_level ] * ( talent.font_of_magic.enabled and 0.8 or 1 ) * haste
    end, state )
end

-- Abilities
spec:RegisterAbilities( {
    -- Conjure a pair of Weyrnstones, one for your target ally and one for yourself. Only one ally may bear your Weyrnstone at a time.; A Weyrnstone can be activated by the bearer to transport them to the other Weyrnstone's location, if they are within 100 yds.
    bestow_weyrnstone = {
        id = 408233,
        color = "bronze",
        cast = 3.0,
        cooldown = 60.0,
        gcd = "spell",

        talent = "bestow_weyrnstone",
        startsCombat = false,

        usable = function() return not solo, "requires allies" end,

        handler = function()
        end,
    },

    -- Attune to Black magic, granting you and your $403208s2 nearest allies $s1% increased maximum health.
    black_attunement = {
        id = 403264,
        color = "black",
        cast = 0.0,
        cooldown = function() return 3 * ( talent.interwoven_threads.enabled and 0.9 or 1 ) end,
        gcd = "off",

        startsCombat = false,
        disabled = function() return not settings.manage_attunement, "manage_attunement setting not enabled" end,

        function()
            applyBuff( "black_attunement" )
            removeBuff( "bronze_attunement" )
            setCooldown( "bronze_attunement", action.bronze_attunement.cooldown )
        end,
    },

    -- Protect an ally with $n explosive dragonscales, increasing their Armor by $<perc>% of your own.; Melee attacks against the target cause 1 scale to explode, dealing $<dmg> Volcanic damage to enemies near them. This damage can only occur every few sec.; Blistering Scales can only be placed on one target at a time. Casts on your enemy's target if they have one.
    blistering_scales = {
        id = 360827,
        color = "black",
        cast = 0.0,
        charges = function() return talent.regenerative_chitin.enabled and 2 or nil end,
        cooldown = 30.0,
        recharge = function() return talent.regenerative_chitin.enabled and 30 or nil end,
        gcd = "spell",

        talent = "blistering_scales",
        startsCombat = false,

        handler = function()
            applyBuff( "blistering_scales", nil, class.auras.blistering_scales.max_stack )
            if talent.molten_blood.enabled then applyBuff( "molten_blood" ) end
        end
    },

    -- Fly to the targeted location, exposing Temporal Wounds on enemies in your path for $409560d.; Temporal Wounds accumulate $409560s1% of damage dealt by your allies affected by Ebon Might, then critically strike for that amount as Arcane damage.$?s395153[; Applies Ebon Might for ${$395153s3/1000} sec.][]; Removes all root effects. You are immune to movement impairing and loss of control effects while flying.
    breath_of_eons = {
        id = 403631,
        color = "bronze",
        cast = 4.0,
        channeled = true,
        cooldown = 120.0,
        gcd = "spell",

        talent = "breath_of_eons",
        startsCombat = false,
        toggle = "cooldowns",

        start = function()
            applyBuff( "breath_of_eons" )
            if buff.ebon_might.up then buff.ebon_might.expires = buff.ebon_might.expires + 5
            else applyBuff( "ebon_might", 5 ) end
        end,

        finish = function()
            removeBuff( "breath_of_eons" )
        end,
    },

    -- Attune to Bronze magic...
    bronze_attunement = {
        id = 403265,
        color = "bronze",
        cast = 0.0,
        cooldown = function() return 3 * ( talent.interwoven_threads.enabled and 0.9 or 1 ) end,
        gcd = "off",

        startsCombat = false,
        disabled = function() return not settings.manage_attunement, "manage_attunement setting not enabled" end,

        function()
            applyBuff( "black_attunement" )
            removeBuff( "bronze_attunement" )
            setCooldown( "black_attunement", action.black_attunement.cooldown )
        end,
    },

    -- Trap the enemy in a time loop for $d. Afterwards, they are returned to their previous location and health. Cannot reduce an enemy's health below $s1%.
    chrono_loop = {
        id = 383005,
        cast = 0.0,
        cooldown = 45.0,
        gcd = "spell",

        spend = 0.020,
        spendType = "mana",

        startsCombat = true,

        handler = function()
            applyDebuff( "target", "time_loop" )
        end
    },

    -- Increase your $i nearest allies' primary stat by $s1% of your own, and cause you to deal $395296s1% more damage, for $d.; May only affect $i allies at once, and prefers to imbue damage dealers.; Eruption, $?s403631[Breath of Eons][Deep Breath], and your empower spells extend the duration of these effects.
    ebon_might = {
        id = 395152,
        color = "black",
        cast = 1.5,
        cooldown = 30.0,
        gcd = "spell",

        spend = 0.010,
        spendType = "mana",

        talent = "ebon_might",
        startsCombat = false,

        handler = function()
            applyBuff( "ebon_might" )
            active_dot.ebon_might = min( group_members, 5 )
            if pvptalent.born_in_flame.enabled then addStack( "burnout", nil, 2 ) end
        end,
    },

    -- Cause a violent eruption beneath an enemy's feet, dealing $s1 Volcanic damage split between them and nearby enemies.$?s395153[; Increases the duration of your active Ebon Might effects by ${$395153s1/1000} sec.][]
    eruption = {
        id = 395160,
        color = "black",
        cast = function() return 2.5 * ( talent.ignition_rush.enabled and buff.essence_burst.up and 0.6 or 1 ) * ( talent.natural_convergence.enabled and 0.8 or 1 ) end,
        cooldown = 0.0,
        gcd = "spell",

        spend = function()
            if buff.essence_burst.up then return 0 end
            return 3 - ( talent.volcanism.enabled and 1 or 0 )
        end,
        spendType = "essence",

        talent = "eruption",
        startsCombat = true,

        handler = function()
            removeBuff( "essence_burst" )
            removeBuff( "trembling_earth" )
            if buff.ebon_might.up then
                buff.ebon_might.expires = buff.ebon_might.expires + 1 + ( set_bonus.tier31_4pc > 0 and ( active_dot.prescience * 0.2 ) or 0 )
            end
            if talent.regenerative_chitin.enabled and buff.blistering_scales.up then addStack( "blistering_scales" ) end
        end
    },

    -- Form a protective barrier of molten rock around an ally, absorbing up to $<shield> damage. While the barrier holds, your ally cannot be interrupted or silenced.
    lava_shield = {
        id = 405295,
        color = "black",
        cast = 0.0,
        cooldown = 30.0,
        gcd = "spell",

        startsCombat = false,
        toggle = "defensives",

        handler = function()
            applyBuff( "lava_shield" )
            active_dot.lava_shield = 1
        end,

        -- Effects:
        -- #0: { 'type': APPLY_AURA, 'subtype': SCHOOL_ABSORB, 'sp_bonus': 12.0, 'value': 127, 'schools': ['physical', 'holy', 'fire', 'nature', 'frost', 'shadow', 'arcane'], 'value1': 10, 'target': TARGET_UNIT_TARGET_ALLY, }
        -- #1: { 'type': APPLY_AURA, 'subtype': MECHANIC_IMMUNITY, 'target': TARGET_UNIT_TARGET_ALLY, 'mechanic': 26, }
        -- #2: { 'type': APPLY_AURA, 'subtype': MECHANIC_IMMUNITY, 'target': TARGET_UNIT_TARGET_ALLY, 'mechanic': 9, }
        -- #0: { 'type': APPLY_AURA, 'subtype': SCHOOL_ABSORB, 'ap_bonus': 0.075, 'value': 127, 'schools': ['physical', 'holy', 'fire', 'nature', 'frost', 'shadow', 'arcane'], 'value1': 10, 'target': TARGET_UNIT_TARGET_ALLY, }

        -- Affected by:
        -- mastery_timewalker[406380] #1: { 'type': APPLY_AURA, 'subtype': ADD_PCT_MODIFIER, 'sp_bonus': 0.5, 'target': TARGET_UNIT_CASTER, 'modifies': BUFF_DURATION, }
        -- hover[358267] #4: { 'type': APPLY_AURA, 'subtype': CAST_WHILE_WALKING, 'target': TARGET_UNIT_CASTER, }
        -- spatial_paradox[406732] #2: { 'type': APPLY_AURA, 'subtype': CAST_WHILE_WALKING, 'target': TARGET_UNIT_CASTER, }
        -- spatial_paradox[406789] #2: { 'type': APPLY_AURA, 'subtype': CAST_WHILE_WALKING, 'target': TARGET_UNIT_TARGET_ALLY, }
        -- spatial_paradox[415305] #2: { 'type': APPLY_AURA, 'subtype': CAST_WHILE_WALKING, 'target': TARGET_UNIT_CASTER, }
    },

    -- Wreathe yourself in arcane energy, preventing the next $s1 full loss of control effects against you. Lasts $d.
    nullifying_shroud = {
        id = 378464,
        cast = 1.5,
        cooldown = 90.0,
        gcd = "spell",

        spend = 0.009,
        spendType = "mana",

        pvptalent = "nullifying_shroud",
        startsCombat = false,
        toggle = "defensives",

        handler = function()
            applyBuff( "nullifying_shroud" )
        end,
    },

    -- Grant an ally the gift of foresight, increasing their critical strike chance by $410089s1% $?s412774[and occasionally copying their damage and healing spells at $412774s1% power ][]for $410089d.; Affects the nearest ally within $s2 yds, preferring damage dealers, if you do not have an ally targeted.
    prescience = {
        id = 409311,
        color = "bronze",
        cast = 0,
        cooldown = 12,
        charges = 2,
        recharge = 12,
        gcd = "spell",

        talent = "prescience",
        startsCombat = false,

        handler = function()
            applyBuff( "prescience_applied" )
            active_dot.prescience = min( group_members, active_dot.prescience + 1 )

            if set_bonus.tier31_4pc > 0 then addStack( "trembling_earth" ) end
        end,
    },

    -- Evoke a paradox for you and a friendly healer, allowing casting while moving and increasing the range of most spells by $s4% for $d.; Affects the nearest healer within $407497A1 yds, if you do not have a healer targeted.
    spatial_paradox = {
        id = 406732,
        color = "bronze",
        cast = 0.0,
        cooldown = 120.0,
        gcd = "off",
        icd = 0.5,

        talent = "spatial_paradox",
        startsCombat = false,
        toggle = "interrupts", -- Utility CD...

        handler = function()
            applyBuff( "spatial_paradox" )
            if not solo then active_dot.spatial_paradox = 2 end
        end
    },

    -- Surge forward in time, causing your cooldowns to recover $s1% faster for $d.
    time_skip = {
        id = 404977,
        color = "bronze",
        cast = function() return 2.0 + ( talent.tomorrow_today.enabled and 1 or 0 ) end,
        channeled = true,
        cooldown = 180.0,
        gcd = "spell",

        talent = "time_skip",
        notalent = "interwoven_threads",
        startsCombat = false,
        toggle = "cooldowns",

        start = function()
            applyBuff( "time_skip" )
        end,

        finish = function()
            removeBuff( "time_skip" )
        end,
    },

    -- Enchant an ally to appear out of sync with the normal flow of time, reducing threat they generate by $s1% for $d. Less effective on tank-specialized allies. ; May only be placed on one target at a time.
    timelessness = {
        id = 412710,
        color = "bronze",
        cast = 0.0,
        cooldown = 0.0,
        gcd = "spell",

        talent = "timelessness",
        startsCombat = false,

        handler = function()
            applyBuff( "timelessness" )
            active_dot.timelessness = 1
        end,
    },

    -- Gather earthen power beneath your enemy's feet and send them hurtling upwards, dealing $396288s2 Volcanic damage to the target and nearby enemies.$?s395153[; Increases the duration of your active Ebon Might effects by ${$395153s2/1000} sec.][]; Empowering expands the area of effect.; I:   $<radiusI> yd radius.; II:  $<radiusII> yd radius.; III: $<radiusIII> yd radius.
    upheaval = {
        id = function() return talent.font_of_magic.enabled and 408092 or 396286 end,
        color = "black",
        cast = empowered_cast_time,
        empowered = true,
        cooldown = 40.0,
        gcd = "spell",

        talent = "upheaval",
        startsCombat = true,

        handler = function()
            if buff.ebon_might.up then buff.ebon_might.expires = buff.ebon_might.expires + 2 end
        end,

        copy = { 396286, 408092 }
    },
} )


spec:RegisterSetting( "use_unravel", false, {
    name = strformat( "Use %s", Hekili:GetSpellLinkWithTexture( 368432 ) ),
    type = "toggle",
    desc = strformat( "If checked, %s may be recommended if your target has an absorb shield applied.  By default, your Interrupts toggle must also be active.",
    Hekili:GetSpellLinkWithTexture( 368432 ) ),
    width = "full",
} )

spec:RegisterSetting( "use_hover", nil, {
    name = strformat( "Use %s", Hekili:GetSpellLinkWithTexture( 358267 ) ),
    type = "toggle",
    desc = strformat( "If checked, %s may be recommended.  In the default priority, this occurs when you are moving and you have charges available.", Hekili:GetSpellLinkWithTexture( 358267 ) ),
    get = function()
        return not Hekili.DB.profile.specs[ 1473 ].abilities.hover.disabled
    end,
    set = function()
        Hekili.DB.profile.specs[ 1473 ].abilities.hover.disabled = not Hekili.DB.profile.specs[ 1473 ].abilities.hover.disabled
    end,
} )

spec:RegisterSetting( "use_verdant_embrace", false, {
    name = strformat( "Use %s with %s", Hekili:GetSpellLinkWithTexture( 360995 ), Hekili:GetSpellLinkWithTexture( spec.talents.ancient_flame[2] ) ),
    type = "toggle",
    desc = strformat( "If checked, %s may be recommended to cause %s.", Hekili:GetSpellLinkWithTexture( 360995 ), spec.auras.ancient_flame.name ),
    width = "full"
} )

--[[ spec:RegisterSetting( "skip_boe", false, {
    name = strformat( "%s: Skip %s", Hekili:GetSpellLinkWithTexture( spec.abilities.time_skip.id ), Hekili:GetSpellLinkWithTexture( spec.abilities.breath_of_eons.id ) ),
    type = "toggle",
    desc = strformat( "If checked, %s may be recommended without %s on cooldown.  This setting will waste cooldown recovery, but may be useful to you.",
        Hekili:GetSpellLinkWithTexture( spec.abilities.time_skip.id ), Hekili:GetSpellLinkWithTexture( spec.abilities.breath_of_eons.id ) ),
    width = "full",
} ) ]]

spec:RegisterSetting( "manage_attunement", false, {
    name = strformat( "Manage %s", Hekili:GetSpellLinkWithTexture( spec.talents.draconic_attunements[2] ) ),
    type = "toggle",
    desc = strformat( "If checked, %s may be recommended when out-of-combat, resuming %s if no one else is supplying the aura or otherwise switching to %s.\n\n"
        .. "This option can be distracting as some abilities can swap your attunement in combat.", Hekili:GetSpellLinkWithTexture( spec.talents.draconic_attunements[2] ),
        spec.abilities.black_attunement.name, spec.abilities.bronze_attunement.name ),
    width = "full"
} )

spec:RegisterSetting( "manage_source_of_magic", false, {
    name = strformat( "Manage %s", Hekili:GetSpellLinkWithTexture( spec.talents.source_of_magic[2] ) ),
    type = "toggle",
    desc = strformat( "If checked, %s may be recommended when out-of-combat when you are in a group and none of your allies appear to have your aura applied.\n\n"
        .. "This option can be distracting because some groups may not have a healer.", Hekili:GetSpellLinkWithTexture( spec.talents.source_of_magic[2] ) ),
    width = "full"
} )

--[[ spec:RegisterSetting( "upheaval_rank_1", true, {
    name = strformat( "%s: Rank 1 Only", Hekili:GetSpellLinkWithTexture( spec.abilities.upheaval.id ) ),
    type = "toggle",
    desc = strformat( "If checked, %s will only be recommended at Rank 1, which is the default.\n\n"
        .. "Otherwise, %s may be recommended at higher ranks when more targets are detected which can help ensure they are caught in its radius.",
        Hekili:GetSpellLinkWithTexture( spec.abilities.upheaval.id ), spec.abilities.upheaval.name ),
    width = "full",
} ) ]]

local devastation = class.specs[ 1467 ]

spec:RegisterSetting( "fire_breath_fixed", 0, {
    name = strformat( "%s: Empowerment", Hekili:GetSpellLinkWithTexture( devastation.abilities.fire_breath.id ) ),
    type = "range",
    desc = strformat( "If set to |cffffd1000|r, %s will be recommended at different empowerment levels based on the action priority list.\n\n"
        .. "To force %s to be used at a specific level, set this to 1, 2, 3 or 4.\n\n"
        .. "If the selected empowerment level exceeds your maximum, the maximum level will be used instead.", Hekili:GetSpellLinkWithTexture( devastation.abilities.fire_breath.id ),
        devastation.abilities.fire_breath.name ),
    min = 0,
    max = 4,
    step = 1,
    width = "full"
} )

spec:RegisterSetting( "use_early_chain", false, {
    name = strformat( "%s: Chain Channel", Hekili:GetSpellLinkWithTexture( 356995 ) ),
    type = "toggle",
    desc = strformat( "If checked, %s may be recommended while already channeling it, extending the channel.",
        Hekili:GetSpellLinkWithTexture( 356995 ) ),
    width = "full"
} )

spec:RegisterSetting( "use_clipping", false, {
    name = strformat( "%s: Clip Channel", Hekili:GetSpellLinkWithTexture( 356995 ) ),
    type = "toggle",
    desc = strformat( "If checked, other abilities may be recommended during %s, breaking its channel.", Hekili:GetSpellLinkWithTexture( 356995 ) ),
    width = "full",
} )


spec:RegisterRanges( "azure_strike" )

spec:RegisterOptions( {
    enabled = true,

    aoe = 3,
    gcdSync = false,

    nameplates = false,
    nameplateRange = 30,

    damage = true,
    damageDots = true,
    damageOnScreen = true,
    damageExpiration = 8,

    package = "Augmentation",
} )

spec:RegisterPack( "Augmentation", 20240508, [[Hekili:T3tAZnUnY(BXvQilnJTSiT9Kjzh5TsMzZUtQCS1ZZ(2VjkkriB(gksU8WA8uQ0V9x3a8aaeaKuh5yRKQIhBcWUB0xO7gGaZSM9Hz375MrM9Z2tSVzYTtE9ylB7xDJ9S7ZEoMm7(y3LF09b4xcDxd)8BZFynjmZnZpkeB85GixpeiPr5jlHo8ywwC63C1vB2SzS)YNV8jIFy64LrRVAt0MRC5E9ljpf9rsYLXprU0lo9YKOINVmkkWlAty6LUl8d8Z8jPZUFrUFq27dNTqn9ceqmz5SF26MV6AGi898iS(ssxo7ESVxo52lN86Vz3879x)2DZZJrWmE3pS7hyTE9Lw2qR)KFyuYU5P(Rl7tAzNGEyDP91qN(2GnUpNUB(k)q)0h3n3nC38)v8Je3NCd2nNSooAdjbhOcVQfI9FkkHSBE2gI7hbaKfvsp4V5(uKV3U5HrxMqwc0WssOBIFKibyDlaLDZ)Geee7Znum9eHhdXaOs8ZEwSNwuO9pta(KpjCjrGsw6gh7h(a83XXbGyG1ymqDrRx4MbphE0gsqGamN81uywZqsCd)4U5w7MhfJcy41aXJ3Fz38F0)jk4)(aq5c43PGM2U5pIqD5JUHpq8qap)YDZFl9pfj0IURIEJcd4gNt(6lTzCTFmAZLfIhaR(OO47siUzGmmA5Y8eC48ibOWFK4gxtAWJ9trbdmKZCdablJYQa)Kxrb))dznLPhftcrmin(w6MMvWdDd8FaqZgFe1)7iaPUa9)qUVhHdWVMPXwkl)GFm82pc)29lbQif1qbklSw2IQIEsqNFyYb7V6sRxvRjXlUcIEWFjJm9xhNqr9kqTfjFca90mkF)jqVCU7YSC8DkE2Mh9diuHxYdWihq3LvQ8u(gA0aVd8epKYzQtY6LiTXKxF)3Dvd6cLeRqB0x(bFKRE)h9JVausEpivs2aulmY)WJWW1lTwra1H(BHP5iL4kl6l0iiEmreihizvw3cs6VIzAbEa88eHst6KsJHG)mLeg6pZlve0xxd67PUtb6FfW)CPWJ3Sdnhx6YmM8xX0bCrdn)klM3ffEo0v6lbUIay(pasaiP1OLIk1b7s0JmIAEBPEuLHcGV)wuyAP5Cjc)E)pPQtlJc98zu6WfUPiSXF)VTa)5p5)WJar(23nQekFR3)xokc(UaFqBlHA(uPTxBWVa(x4zP4a0lp0ZL5RTIoefWuJIAb0A3pvOJw6frKrW8j((qGSXUdgbbKQPTaCxpkEpmd3)lod35LgVZUhj8uCkr)mYA8x(z6SSGV8fbeVzF3S7bda60NzWW7JKmlyYRGOm()opL4eTALZdl9Wx)(LGbcWmCND)zGHhmPacRXf93XYzr(QvaVyWU5QBFTBi1mf6WqUo45Ugg8oL9R2lYuQ7AwVvbr7smUDRYwjFAzqUhWDhX6srlJZShxo7(4eYAx)Wu9DWlpPGJdKZekSakcyj1V6DqdJzuQIrDe0xh0IMfhqIFmJV)(vmhd4pjmbjWWRic0ul6jqyMsnQWr6fL9aD(gb)mH9Av06U5)scZumK4ZAVDOTiIAQWdNzzqKnMvxSLuxS7R6IDlQl27J6ITj1flJQlw6vxSAtDX6OPUyZPUacHR7Tn7FAJwX0vpa1zo(VqBHqeg)YF)TVRcpPuJHBA1y4pv2nY351RLDCGA63Zcw1zLFqajr10vrXWlsYQ59L4a)TGCs9dgxalpsGlWPU7VYrpRHOPwNV2HVl6eEf9zPxk0VmYsiStksCyjHkacfom3BcgIEWYeIKDk0oI06xOBdrHMnyne(86CsQtEyI7tKaiOjNui9fpKqQrFLYZcAyrWmgoeieTALT3a6sxxMPVEqc0XTs0rnsqk6jIdq9RPjmY8srvJPjamoop2paXn8NFknlXn9ZUJlbv1akGM5KZkmXjeHVcryzJUFgIJ3bEx)ps4jdQ6ShzLBEqwLIC5l9FYH8uf7DdfN6HbivZaciDmo1AbpOgwLpOuLO85lDZX3)Z1KUi(KfFAW3JSa1bdAiDsAeWdybomM2Yyuiw)mjPj2ynfrFbvsS2vD9iuWNHzhL4g4SjcIZUuzHxxf7bR1kjLYX4Q8GahiFeAG3oz0emqvoCkAAi5Vau)y6kfArErG(cxg)mFDd4IxIaPr4SgZIqunMhM3upiRbgsQFLwsDybVvf4VKLLyXayedFY9U2)8lWyoUHnS0cZ7MYgZrcJio0GVDAuqu9qPUF4q51Ahk68ndKvnWsYdDy)UdM(cljgrxrfZpa46R1Il1Qmyrkg0CWNhZjxIO)laCRjNExCLZEZnXQF6yTiqD8IYbIjfH0bcq7QWdgYPTVcYQ1Hn0ehsf6xvDmVix3g9AKO5Jo2eODynPmKcJs1JkB0(yZgb5YOonHMv75ORWKAFdUxphvtS6cGxvC41sdWf3tyIGJT4vxyqMRT8QQHmsJ1zzldnN9acxrI6r3uNscRJPw0UuSrOWib7u7Mf9GUcPCNQzOKsqdLYTNATbPCFtLONszlnszRFZKYw6LYwMKY6sKPvJ)MzI2tPSnvkRl3D8nCE0fItP4T4EG(sOiwbbPylMm(vQYMTQKsBiUXGNvkzPp6VIcqJvmVH0SIvIbc4K(r)4s1GIaQRFEbSR0GyT7xv(zNmw1NBgU9sxi0mDbaSAbL8LJGSky4cDmakpVmacSddVllLYflgyozrsPcXnIR1rzzjGVnBqLf545tOZgXfk0lrUUTs1z(5V4EJbNwUiYC0h17qXPW1fWQMieRnq1WySUL2kw5FhYtiL66b0gUGa1TYQub5)K7hht8mnJQGgN2(jApypH9EcgMWOcI0Asdpdh4e6NKieky9rPmNVQhhJQ14fJAIk)1NkbvIgWworwsHPLQEkJRJpSy5SGT0hMVjxidBQFieP31v(3L7g5t(0LSCu)CviNHWFOCvCm4wyTfKtKrWLG5q6FPXq55BToH2XQsVEeZc96B5c1P0rhLiLd7TMil875bK2AuvpnMkc49oY4PPPi6HGxssZ4IqPYSlngaamgc4nG10QvPxxkODdXHwgt)xmwfv(jr4wqnJ9iR8x6NvwYGAxRcuBAM7Yps7JIgHP4Dk6WGwCGFhxUvdRPVmOdlO(JiUjG8TaAG8JT1x4KELX(vuoHBfgnfUzfmdjRjqmLEolca3wrRPct9LZYK2p5tKL5zeUcnOHjQwIxh)3jMbZn2tYJlRxGTUG9wuTaYoP01pwiMUKO8yN1G4HKuywxQ5Xv6PgGqPNewb3A4qdPn9r8DMAv464re195T6k6aqrjbWSzUEUXSvMwtKlMSG1BPnOItiukxZkG6ll8VgJx9JKHDIFG6WqgCUmZnRj4)vAvBMx8ejb3bcoG(uIlR2I2Yre2LsTvvJTmAPkzB3JzAwsgW3HU63wwz2kNR1Lf)Elvf(UJWt9A4ub6jZ2R1i5PESerThnUHLVr2C8ajnQNCLLxvX8O7hfRQQ9DqoPCXLeftYQNTZledIpjFXZoBEKee7Kc)mqvG(BE0pnM5)0pemFdDHPz8xg1SEbqNZbBhsq6hZdsDwbwrz5jepu5njtzseKGmishGutDOHKcracH(eLQQZpHt8qx0PuaEu)5p6c(Tv1xivEW)a2NfbWCtoEjUpaib9)lSOhY1ir1ck0dMQDhyQ29HPA3pMQDFyQ29GPAVhmvBEMQCop9GPAoDtPc38Z0(X2FHGNx2oSJ4DbUb8yL17F4YEnvAbSs)PA5r6b9AoBw1CQAe3yPtAhZtupye2jmnkn(EcwPnytJAX2oyLQ(iwYoCo)YP412SKr(VknAAJWiuv1oRSQsqrZAqznp7b302m3uUzjR7FvA002Brn3CFmLQ5MAIuWFL55DRfmPphUSZlzKOURI94ZxcrBIvzJLh2OcrOd4zhn2gFBLm1szLA7j1B3o1BRH6vUZW6j1RjYKUs9Lv3Bwp2qE9y8jUShDtP00cNmsQEiAOGwzYxTZWYMmIUwfdXQHDlnQvTgASTGHPEublfKmQ3q7XiAo1d7GQ9vcDOZ0TS72M0TchYAOBRA6M1dlkKAq9(bpfq3(h8ozOpBeDCyvKU4Ogk5wvQ42kRwChvX1SLeLkT4bTNeL9HshEy6Wn4dMCjZCKAKfOjQoKfimA4XRXk93dV)CLQRnpdggFuPSqeKVlkFra)Q)Dj(bl5hL5)zc(9eKbH0djJ1ChNdWITLVyXGEb9JhH(5FapDdWo8XnbgDZNhgLSw6J05HC3exa4qRyX6yXVMKayAC5UkkDCv5eE50RkhrxGQvt1OvDru8uQa5cQCBQ9f1IZPwxu9zDmTKPBMNFH)Qo2ZTBl7x)JiQ2KqtypA0g1VLMOfvAb(PMGOgs2bKcolsIc)mrAR2PUtTSua0crYxHjSUJSVLseoRzF6ptf2Swsn3sD8lgaywxUzz5H0VKLgKUyZDPAYSHNmmRRqAduwmoptx7q6He(1ytc8kl2BJHPubBlla9BQ2ptUglVRiJUzjKPvMB1cvLKtXMqtCTDC9Ewz9J5xWVm)yQUtf60(XGWb7zcRDMTQfxRM4KwCtSY39DbYQxhzDLlqvDaBLWVUVe(Rpj0TUTyTw6(M(s33Wxw7vrHzvMYcv0wXQCPzSvT4lIQpSvmtvzeBDmTNYIJejx6NOBcmDfA)3qlKot7Ybc2kTB1BA)vNkAxocUwPDC9(k(BZJc17LHcNVA)mvecBKoEBUwqQxINYC06W6dvfmO46wpHlKYIzy2VVacoldfR(DntwENHqNMOSrtFFealeIPmf7h7iu4AlWEyJBsiapiM9pGbz6J7yXSIpH5Z9XVJ1ZXV0wqVG(vsNgHklU5zrRDPFs4SVwF8Zz(h9XpPs8lO9TrHaMOnFEDKFY7mWZzXWEUQSBR7YqRpn6eb8(a2YmtnbxU(0xQUxGVcW2AaCZDHzd4QSlcu9Xf49bSAzgQ7tFP6Eb(kaFD7cXEO6jr1hxG3hW2lfV(t19c8va(M2fI9q1tIQpUaVpGTxkE9NQ7f4Ph7bk84l8j)0pp)3ktI6NZRIeBFAXAgHs6TyPT7hLAnrl30uzhuWyBP7ItdOdRMlkIctNJcwBL4)d4yTdZ0MhBYxeT1Jpm7c04xCafGtQ5EtJ9y(Jtl0BhUwJJtIwcrb)SJxCQj)A66x3O)UJhHfNOb87qmhk0qKB94dZUanJADnAU30ypMj90c92HRDh1g03VUr)DhpM16AerG0xZY5IZX24RCPRaS52xtcY63FBnqHMqe2FAwdapM08R0ih1)jYOt)S65T(11CE7OV15JpOPV1H1wNp(qM(2UHJALLLrsuQPOnnaUg1BHATibAL7m5Uc4M7AzjORFBn3vuCCymASHoCgJgaFmzmAqXbYyuMPr1YOEEVY1OrsYhDpuNE)2g9bjVZvv76rrV6ok0UXxvJltDV7i1WgOvnAn)cDhXAl9UgN6g6E3rQUT0RACAO3DhLg2zWQXQ5xqaXFLP5VAvJvxV6ok6UgBRDV7iTpASD4f6oI7UgBRDV7iTZAST17UJY(OX2HxqaXV(3I48(6FlcZRLSrl33EkgAsn3hOsxxn)Y9HLgy3OthDmCiu)A8qyo5zt0EDxoYq)qOBOTuikUa)mJ0Uy3oby5qgdpIChtuFzhoQq(qOyCnXnrWfTFmH7EqU9YntRDxeR6xEkJUzA0CFGAlob00PJogoeQxNJaLD5id9dHUn5aqB3oby5qgdQDgOOdhviFiuSs3bnB)yc39GC7LBMw7Uiwp2Rm7Pg(AHCeKbcTlPSBvGZ1T94hm0ec(YV0YEY0jJkjM9ekfaPMABuQNkPB78HoSzgo6WxlKBNpB3GdPabTYN7guAWN1x6x04BFxHs9vcWiuBzfO0tR7Nm7ud)Ua5UU6qDBvOoC8Gkr6xfkZAlDkyLwch6iGbTZy0byFaHdDWqV309(oNWPg(DbYDtFSRR5)HJN9tVVh1cyp177bg2d9Nw1m7q1goyOVh0n(LjQaAfpUBqXwnuS7euAmR(zAd8PtZuZpV3GMWQ67mE72ZK4ELV1OTB1JjZbfW1OGzWOxmCY4BFPg3uV4ADTaVNMVz4rJUBO5ab1zsktlwAPfRwPf23bm0I1lfOguWFPKIWOV0AYKrJQI76pWY5R(DKC(QF3jNVQqoxBYByXb6HJdDqPFoX(nz9c0I1Eemwlt7DeWG2Pp0d7EXZAT7DdR9yI89KN1dm0BEwRkoNi9SEH1w7EbwPB3JvrbbrB8Px6PGVNu8i8gVkbZP35F4C60pdF2NA1U54xim(9ALv2p6De6k8KENV3EEyN9CZCXlpWVP4MkelVLM9zYQfN3RnyIMT)HWxxAfJrrBDC7VSpFraNY9ZLgyFe)AdEpD8Ja)vIsDCao7EyC)yuYS7V3LeaZvbVy1vc5O)c7M3fpkhJagx1h3UPdJHQpRWlk(MgMAHhed0Z8VD)q7VVQZPWkaubZjDbucGGDgqunvQs04VA6zA3vrNcm(YQwLPJJbzWF6jUNSW6iokIFRyuj4(uElMiD(xODxHi1pdBJd5tudD78cP(PB3si1ndBVH(WJS1WJuUnCQjbZ7CgP(1jEK5DNIu)ANh12waz3p8fLN7lTF2d2hgA5zsOkDoTZg2heyRgbMNUTpiG7GiSah9YQZ(WE9Ie4AW(4duQojovrzXBOix0dLT9u96kQS9hX3vzlyOeJuK5OvDMJNcfavCiBnCivXUZBMONdz3chsEfov2IooKDto0Xudgt1u(OuYI)OucsRL7WusBze4u00Uiq9HYSpykRrDmmS8u9HY69bq1Hu7L9Q0l7tLxmvGnnldJunpuz)Wv4JMgqDSomMk3MMcLlrzQ89XrznD(15QYivugXAV1fLQd9WnBOwLlfsDfoBzu8DtfhqQ9drblnCG)8GKtV73J)bjxx0Jo4bLzsyGjJ8JXKwdoZKXQPahq(9WUnk6kXmAGEZk9wgAS3xO8y3dPA6yuDZSZQoLWt601dbe9q6BqX56JIdOpDXvkFe3Xrukoo(0ad5ZbVAGO8a4BGAea0)zQBbp290r(sh)DC0VYZzV3ynHNl1OxiFQcvacOxjZ8pOqvbXJQlGz(U24QwMVr6TECdOqF6a2vQmJnvFDkxW2sACvkZdwjxcvx7Xf(amEHjZdN6R9hKgBEVn9MPfxXGV46TB5yO1V30jdQM0U5P6v97FdpAR7i1MMsSnF5lRooWg9MPY9PmaGxmz8nB3Qbc3nLHtLxLXB3IxJX8KL0fIIqnyy1Bej3kVc8L65UjcSv6Lim2zD38MdKP48yb1pqjbpSRyKGXzGQ4(QVbDFZ0Rh0rNMndsTCoMPwD1HQbyydHNoSIAvCBJ9MPGKSQdY32yqRJg0YG9oWS)mTS8dNnyFeydwJukOXRb0YPOTeuZAFAPY6RmyOUXUHedoREeXX7hmmw59662TXnVtxhPqBgMzTtzWiM2dp)TIAkeUkgdCmv(qSuMPWDtfpscBtiyRuiyBi2G9qiyjleSo5cbRwtJKNv2hHG9iEXx3ecFXxajz8T4Pe4U54zN8hjflWZV83F77QtMaI6)9Ee3GGNXCgW0baMAG3U5liy(i13l)O39ID8cWQcO3TM01eJ9w4)N6VooaZmXfxzSuczDklPJhbJymBe6sN5VK4sZ8XZFfbY8GcDeSV7FE)yKURZdHEQecQr8h2HcEMXo4S0ZXY6glQyvHqPQaHd0Oku9oAsUzQLQyzT1MIyLX4itgDQlPqtI1UNeRTHaVnLp7itkNyI4GC59RW0rrvLOqsZmtXRLAiYlpSk3USt4Ylk7bMoAe8Ze2RvHaqFeEKpa4qIpR92H2Ii8Apveo)GSstLVh8xkU2NH02AmDqFstPE(GwLdNeLgLTv6cy6Krd4UiRVBYyRMZwYzpSxSmB1SSU49Uvw2jr1vzB9ILzZZYaRa6T)DiQ9j7kvpd9)U16urYDrn7)UvSurYk0KKVh51h)eIw6vzVK9jw(coL4QmdNm(vIPtlERoZsbA1c89vFCmZL0a)DQ(a5tTPbDypbGJMIaQUq4GHgga1NG0SrJIRdAGB34QG(UQmoF5KX2nIsRKFu1Rbh1rJyIs00ThAmHDfztJbsQyCzD7GMx274thEw7xW716LA7sdD57MApz7wHiiFZ1t6AXvp551bmUO00bY0Nq(E8Nw2vfXQXDY(aLPjlwIG9XozOMRt87SUgYgq9Li(OFxzBCWJGk7hQPGPYr8sTLIOULytx65JUB613ku2lXlQyUThK0MmRGriDFMZnfs1MZcvDv8uRIASkFYTdje204E7wPRz7Ptk9b08k0EQIgQU(SnvkW7Ubqod7kVnYFPMBI8rVz6Tvui4bqqAwE)BxzkPaV83Q4kgQQ41SSGpbSabpZnkQTSrvzb)lVEWVdeRCfHTbaAy)G0rlkGN1uFyGQtvTbApm0QMiswjwTkyzD5lUvcMAjuxBXRV6JfbQMqgQHW3UfVygUBk7szyKrcwzjJz1kMBfgglue5g1V30UnuOiZ)1QhRDBpk)I87DWJn9CPvpHOWgzSCFES)u9rTk56rJ8C2Y6d4eBA3jV6blF5I41vwTGonf)LrJWiOXD5KP1sGbnUxHFMABvECecF5oRUmPC73slDJEUUD651)kso30o5CZavBH9MtY2GilMDPXDo0OUrADItDauXGZowmXJLo2rJGS6ab9QFnjii0bvKK6y4fCuOZb1qLZ3joTgw9FnZ(PiEsywWH9YTxHMvJ4pvq9c3rq41c0S)))]] )