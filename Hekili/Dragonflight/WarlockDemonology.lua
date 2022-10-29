-- WarlockDemonology.lua
-- September 2022

if UnitClassBase( "player" ) ~= "WARLOCK" then return end

local addon, ns = ...
local Hekili = _G[ addon ]
local class, state = Hekili.Class, Hekili.State

local spec = Hekili:NewSpecialization( 266 )

spec:RegisterResource( Enum.PowerType.SoulShards )
spec:RegisterResource( Enum.PowerType.Mana )

-- Talents
spec:RegisterTalents( {
    abyss_walker                         = { 71954, 389609, 1 }, --
    accrued_vitality                     = { 71953, 386613, 2 }, --
    amplify_curse                        = { 71934, 328774, 1 }, --
    antoran_armaments                    = { 72008, 387494, 1 }, --
    balespiders_burning_core             = { 72000, 387432, 2 }, --
    banish                               = { 71944, 710   , 1 }, --
    bilescourge_bombers                  = { 72021, 267211, 1 }, --
    bloodbound_imps                      = { 72001, 387349, 1 }, --
    borne_of_blood                       = { 72026, 386185, 1 }, --
    burning_rush                         = { 71949, 111400, 1 }, --
    call_dreadstalkers                   = { 72023, 104316, 1 }, --
    carnivorous_stalkers                 = { 72018, 386194, 1 }, --
    claw_of_endereth                     = { 71926, 386689, 1 }, --
    command_aura                         = { 72006, 387549, 2 }, --
    curses_of_enfeeblement               = { 71951, 386105, 1 }, --
    dark_pact                            = { 71936, 108416, 1 }, --
    darkfury                             = { 71941, 264874, 1 }, --
    demon_skin                           = { 71952, 219272, 2 }, --
    demonbolt                            = { 72024, 264178, 1 }, --
    demonic_calling                      = { 72017, 205145, 2 }, --
    demonic_circle                       = { 71933, 268358, 1 }, --
    demonic_durability                   = { 71956, 386659, 1 }, --
    demonic_embrace                      = { 71930, 288843, 1 }, --
    demonic_fortitude                    = { 71922, 386617, 1 }, --
    demonic_gateway                      = { 71955, 111771, 1 }, --
    demonic_inspiration                  = { 71928, 386858, 1 }, --
    demonic_meteor                       = { 72012, 387396, 1 }, --
    demonic_resilience                   = { 71917, 389590, 2 }, --
    demonic_strength                     = { 72021, 267171, 1 }, --
    desperate_power                      = { 71929, 386619, 2 }, --
    doom                                 = { 72028, 603   , 1 }, --
    dreadlash                            = { 72020, 264078, 1 }, --
    fel_and_steel                        = { 72016, 386200, 1 }, --
    fel_armor                            = { 71950, 386124, 2 }, --
    fel_commando                         = { 72022, 386174, 1 }, --
    fel_domination                       = { 71931, 333889, 1 }, --
    fel_might                            = { 72014, 387338, 1 }, --
    fel_sunder                           = { 72010, 387399, 1 }, --
    fel_synergy                          = { 71918, 389367, 1 }, --
    forces_of_the_horned_nightmare       = { 72004, 387541, 2 }, --
    foul_mouth                           = { 71935, 387972, 1 }, --
    frequent_donor                       = { 71937, 386686, 1 }, --
    from_the_shadows                     = { 72015, 267170, 1 }, --
    gorefiends_resolve                   = { 71916, 389623, 2 }, --
    greater_banish                       = { 71943, 386651, 1 }, --
    grim_inquisitors_dread_calling       = { 71999, 387391, 1 }, --
    grimoire_felguard                    = { 72013, 111898, 1 }, --
    grimoire_of_synergy                  = { 71924, 171975, 2 }, --
    guillotine                           = { 72005, 386833, 1 }, --
    guldans_ambition                     = { 71995, 387578, 1 }, --
    houndmasters_gambit                  = { 72011, 387488, 2 }, --
    howl_of_terror                       = { 71947, 5484  , 1 }, --
    ichor_of_devils                      = { 71937, 386664, 1 }, --
    imp_gang_boss                        = { 71998, 387445, 2 }, --
    imp_step                             = { 71948, 386110, 2 }, --
    implosion                            = { 72002, 196277, 1 }, --
    inner_demons                         = { 72027, 267216, 2 }, --
    inquisitors_gaze                     = { 71939, 386344, 1 }, --
    kazaaks_final_curse                  = { 72029, 387483, 2 }, --
    lifeblood                            = { 71940, 386646, 2 }, --
    mortal_coil                          = { 71947, 6789  , 1 }, --
    nerzhuls_volition                    = { 71996, 387526, 2 }, --
    nether_portal                        = { 71997, 267217, 1 }, --
    nightmare                            = { 71945, 386648, 2 }, --
    power_siphon                         = { 72003, 264130, 1 }, --
    quick_fiends                         = { 71932, 386113, 2 }, --
    reign_of_tyranny                     = { 71991, 390173, 1 }, --
    resolute_barrier                     = { 71915, 389359, 2 }, --
    ripped_through_the_portal            = { 72009, 387485, 2 }, --
    sacrificed_souls                     = { 71993, 267214, 2 }, --
    shadowflame                          = { 71941, 384069, 1 }, --
    shadowfury                           = { 71942, 30283 , 1 }, --
    shadows_bite                         = { 72025, 387322, 1 }, --
    soul_armor                           = { 71919, 389576, 2 }, --
    soul_conduit                         = { 71923, 215941, 2 }, --
    soul_link                            = { 71925, 108415, 1 }, --
    soul_strike                          = { 72019, 264057, 1 }, --
    soulbound_tyrant                     = { 71992, 334585, 2 }, --
    soulburn                             = { 71957, 385899, 1 }, --
    stolen_power                         = { 72007, 387602, 1 }, --
    strength_of_will                     = { 71956, 317138, 1 }, --
    summon_demonic_tyrant                = { 72030, 265187, 1 }, --
    summon_soulkeeper                    = { 71939, 386244, 1 }, --
    summon_vilefiend                     = { 72019, 264119, 1 }, --
    sweet_souls                          = { 71927, 386620, 1 }, --
    teachings_of_the_black_harvest       = { 71938, 385881, 1 }, --
    the_expendables                      = { 71994, 387600, 1 }, --
    wilfreds_sigil_of_superior_summoning = { 71991, 337020, 1 }, --
    wrathful_minion                      = { 71946, 386864, 1 }, --
} )


-- PvP Talents
spec:RegisterPvpTalents( {
    bane_of_fragility     = 3505, -- 199954
    bonds_of_fel          = 5545, -- 353753
    call_fel_lord         = 162 , -- 212459
    call_felhunter        = 156 , -- 212619
    call_observer         = 165 , -- 201996
    casting_circle        = 3626, -- 221703
    essence_drain         = 3625, -- 221711
    fel_obelisk           = 5400, -- 353601
    gateway_mastery       = 3506, -- 248855
    master_summoner       = 1213, -- 212628
    nether_ward           = 3624, -- 212295
    pleasure_through_pain = 158 , -- 212618
    precognition          = 5505, -- 377360
    shadow_rift           = 5394, -- 353294
} )


-- Auras
spec:RegisterAuras( {
    abyss_walker = {
        id = 389614,
        duration = 10,
        max_stack = 1
    },
    amplify_curse = {
        id = 328774,
        duration = 15,
        max_stack = 1
    },
    balespiders_burning_core = {
        id = 387437,
        duration = 20,
        max_stack = 4
    },
    bane_of_fragility = {
        id = 199954,
        duration = 10,
        max_stack = 1
    },
    banish = {
        id = 710,
        duration = 30,
        max_stack = 1
    },
    bilescourge_bombers = { -- TODO: Virtual aura; model from successful cast.
        id = 267211,
        duration = 6,
        max_stack = 1
    },
    bonds_of_fel = {
        id = 353807,
        duration = 6,
        max_stack = 1
    },
    burning_rush = {
        id = 111400,
        duration = 3600,
        tick_time = 1,
        max_stack = 1
    },
    butchers_bone_fragments = {
        id = 336908,
        duration = 12,
        max_stack = 6
    },
    call_fel_lord = { -- TODO: Is a totem.
        id = 212459,
        duration = 15,
        max_stack = 1
    },
    call_observer = { -- TODO: Virtual aura; model from successful cast.
        id = 201996,
        duration = 20,
        max_stack = 1
    },
    casting_circle = { -- TODO: Virtual aura; model from successful cast.
        id = 221705,
        duration = 12,
        max_stack = 1
    },
    corruption = {
        id = 146739,
        duration = 14,
        tick_time = 2,
        max_stack = 1
    },
    curse_of_exhaustion = {
        id = 334275,
        duration = 12,
        max_stack = 1
    },
    dark_pact = {
        id = 108416,
        duration = 20,
        max_stack = 1
    },
    demonic_calling = {
        id = 205146,
        duration = 20,
        max_stack = 1
    },
    demonic_circle = {
        id = 48018,
        duration = 1500,
        max_stack = 1
    },
    demonic_inspiration = {
        id = 386861,
        duration = 8,
        max_stack = 1
    },
    demonic_strength = {
        id = 267171,
        duration = 20,
        max_stack = 1
    },
    doom = {
        id = 603,
        duration = 20,
        tick_time = 20,
        max_stack = 1
    },
    drain_life = {
        id = 234153,
        duration = 5,
        tick_time = 1,
        max_stack = 1
    },
    eye_of_kilrogg = {
        id = 126,
        duration = 45,
        max_stack = 1
    },
    fel_domination = {
        id = 333889,
        duration = 15,
        max_stack = 1
    },
    fel_obelisk = { -- TODO: Is a totem.
        id = 353601,
        duration = 15,
        max_stack = 1
    },
    grimoire_felguard = { -- TODO: Is a totem.
        id = 111898,
        duration = 17,
        max_stack = 1
    },
    health_funnel = {
        id = 755,
        duration = 5,
        tick_time = 1,
        max_stack = 1
    },
    howl_of_terror = {
        id = 5484,
        duration = 20,
        max_stack = 1
    },
    inquisitors_gaze = {
        id = 388068,
        duration = 3600,
        max_stack = 1
    },
    lifeblood = {
        id = 386647,
        duration = 20,
        max_stack = 1
    },
    mortal_coil = {
        id = 6789,
        duration = 3,
        max_stack = 1
    },
    nether_portal = {
        id = 267218,
        duration = 15,
        max_stack = 1
    },
    nether_ward = {
        id = 212295,
        duration = 3,
        max_stack = 1
    },
    shadow_rift = {
        id = 353293,
        duration = 2,
        max_stack = 1
    },
    shadowflame = {
        id = 384069,
        duration = 6,
        max_stack = 1
    },
    shadowfury = {
        id = 30283,
        duration = 3,
        max_stack = 1
    },
    soulburn = {
        id = 387626,
        duration = 3600,
        max_stack = 1
    },
    soulstone = {
        id = 20707,
        duration = 900,
        max_stack = 1
    },
    subjugate_demon = {
        id = 1098,
        duration = 300,
        max_stack = 1
    },
    summon_demonic_tyrant = { -- TODO: Is a totem?
        id = 265187,
        duration = 15,
        max_stack = 1
    },
    summon_vilefiend = { -- TODO: Is a totem.
        id = 264119,
        duration = 15,
        max_stack = 1
    },
    tormented_soul = { -- TODO: This isn't a visible aura; instead it sets the count on the Summon Soulkeeper spell.
        id = 386251,
        duration = 3600,
        max_stack = 10
    },
    unending_breath = {
        id = 5697,
        duration = 600,
        max_stack = 1
    },
    unending_resolve = {
        id = 104773,
        duration = 8,
        max_stack = 1
    },
    wrathful_minion = {
        id = 386865,
        duration = 8,
        max_stack = 1
    },
} )


-- Abilities
spec:RegisterAbilities( {
    amplify_curse = {
        id = 328774,
        cast = 0,
        cooldown = 30,
        gcd = "off",

        talent = "amplify_curse",
        startsCombat = false,
        texture = 136132,

        handler = function ()
        end,
    },


    bane_of_fragility = {
        id = 199954,
        cast = 0,
        cooldown = 45,
        gcd = "spell",

        spend = 0.01,
        spendType = "mana",

        pvptalent = "bane_of_fragility",
        startsCombat = false,
        texture = 132097,

        handler = function ()
        end,
    },


    banish = {
        id = 710,
        cast = 1.5,
        cooldown = 0,
        gcd = "spell",

        spend = 0.02,
        spendType = "mana",

        talent = "banish",
        startsCombat = false,
        texture = 136135,

        handler = function ()
        end,
    },


    bilescourge_bombers = {
        id = 267211,
        cast = 0,
        cooldown = 30,
        gcd = "spell",

        spend = 2,
        spendType = "soul_shards",

        talent = "bilescourge_bombers",
        startsCombat = false,
        texture = 132182,

        handler = function ()
        end,
    },


    bonds_of_fel = {
        id = 353753,
        cast = 1.5,
        cooldown = 30,
        gcd = "spell",

        spend = 0.02,
        spendType = "mana",

        pvptalent = "bonds_of_fel",
        startsCombat = false,
        texture = 1117883,

        handler = function ()
        end,
    },


    burning_rush = {
        id = 111400,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        talent = "burning_rush",
        startsCombat = false,
        texture = 538043,

        handler = function ()
        end,
    },


    call_dreadstalkers = {
        id = 104316,
        cast = 2,
        cooldown = 20,
        gcd = "spell",

        spend = 2,
        spendType = "soul_shards",

        talent = "call_dreadstalkers",
        startsCombat = false,
        texture = 1378282,

        handler = function ()
        end,
    },


    call_fel_lord = {
        id = 212459,
        cast = 0,
        cooldown = 120,
        gcd = "spell",

        spend = 2,
        spendType = "soul_shards",

        pvptalent = "call_fel_lord",
        startsCombat = false,
        texture = 1113433,

        toggle = "cooldowns",

        handler = function ()
        end,
    },


    call_felhunter = {
        id = 212619,
        cast = 0,
        cooldown = 30,
        gcd = "off",

        spend = 0.01,
        spendType = "mana",

        pvptalent = "call_felhunter",
        startsCombat = true,
        texture = 136174,

        handler = function ()
        end,
    },


    call_observer = {
        id = 201996,
        cast = 0,
        cooldown = 90,
        gcd = "spell",

        spend = 0.01,
        spendType = "mana",

        pvptalent = "call_observer",
        startsCombat = false,
        texture = 538445,

        toggle = "cooldowns",

        handler = function ()
        end,
    },


    casting_circle = {
        id = 221703,
        cast = 0.5,
        cooldown = 60,
        gcd = "spell",

        spend = 0.02,
        spendType = "mana",

        pvptalent = "casting_circle",
        startsCombat = false,
        texture = 1392953,

        toggle = "cooldowns",

        handler = function ()
        end,
    },


    corruption = {
        id = 172,
        cast = 2,
        cooldown = 0,
        gcd = "spell",

        spend = 0.01,
        spendType = "mana",

        startsCombat = true,
        texture = 136118,

        handler = function ()
        end,
    },


    create_healthstone = {
        id = 6201,
        cast = 3,
        cooldown = 0,
        gcd = "spell",

        spend = 0.02,
        spendType = "mana",

        startsCombat = false,
        texture = 538745,

        handler = function ()
        end,
    },


    create_soulwell = {
        id = 29893,
        cast = 3,
        cooldown = 120,
        gcd = "spell",

        spend = 0.05,
        spendType = "mana",

        startsCombat = true,
        texture = 136194,

        toggle = "cooldowns",

        handler = function ()
        end,
    },


    curse_of_exhaustion = {
        id = 334275,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        startsCombat = false,
        texture = 136162,

        handler = function ()
        end,
    },


    dark_pact = {
        id = 108416,
        cast = 0,
        cooldown = 60,
        gcd = "off",

        talent = "dark_pact",
        startsCombat = false,
        texture = 136146,

        toggle = "cooldowns",

        handler = function ()
        end,
    },


    demonbolt = {
        id = 264178,
        cast = 4.5,
        cooldown = 0,
        gcd = "spell",

        spend = 0.02,
        spendType = "mana",

        talent = "demonbolt",
        startsCombat = false,
        texture = 2032588,

        handler = function ()
        end,
    },


    demonic_circle = {
        id = 48018,
        cast = 0.5,
        cooldown = 10,
        gcd = "spell",

        spend = 0.02,
        spendType = "mana",

        startsCombat = false,
        texture = 237559,

        handler = function ()
        end,
    },


    demonic_circle_teleport = {
        id = 48020,
        cast = 0,
        cooldown = 30,
        gcd = "spell",

        spend = 0.03,
        spendType = "mana",

        startsCombat = false,
        texture = 237560,

        handler = function ()
        end,
    },


    demonic_gateway = {
        id = 111771,
        cast = 2,
        cooldown = 10,
        gcd = "spell",

        spend = 0.2,
        spendType = "mana",

        talent = "demonic_gateway",
        startsCombat = false,
        texture = 607512,

        handler = function ()
        end,
    },


    demonic_strength = {
        id = 267171,
        cast = 0,
        cooldown = 60,
        gcd = "spell",

        talent = "demonic_strength",
        startsCombat = false,
        texture = 236292,

        toggle = "cooldowns",

        handler = function ()
        end,
    },


    doom = {
        id = 603,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = 0.01,
        spendType = "mana",

        talent = "doom",
        startsCombat = false,
        texture = 136122,

        handler = function ()
        end,
    },


    drain_life = {
        id = 234153,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = 0,
        spendType = "mana",

        startsCombat = true,
        texture = 136169,

        handler = function ()
        end,
    },


    eye_of_kilrogg = {
        id = 126,
        cast = 2,
        cooldown = 0,
        gcd = "spell",

        spend = 0.03,
        spendType = "mana",

        startsCombat = false,
        texture = 136155,

        handler = function ()
        end,
    },


    fear = {
        id = 5782,
        cast = 1.7,
        cooldown = 0,
        gcd = "spell",

        spend = 0.05,
        spendType = "mana",

        startsCombat = true,
        texture = 136183,

        handler = function ()
        end,
    },


    fel_domination = {
        id = 333889,
        cast = 0,
        cooldown = 180,
        gcd = "off",

        talent = "fel_domination",
        startsCombat = false,
        texture = 237564,

        toggle = "cooldowns",

        handler = function ()
        end,
    },


    fel_obelisk = {
        id = 353601,
        cast = 0,
        cooldown = 45,
        gcd = "spell",

        pvptalent = "fel_obelisk",
        startsCombat = false,
        texture = 1718002,

        handler = function ()
        end,
    },


    grimoire_felguard = {
        id = 111898,
        cast = 0,
        cooldown = 120,
        gcd = "spell",

        spend = 1,
        spendType = "soul_shards",

        talent = "grimoire_felguard",
        startsCombat = false,
        texture = 136216,

        toggle = "cooldowns",

        handler = function ()
        end,
    },


    guillotine = {
        id = 386833,
        cast = 0,
        cooldown = 45,
        gcd = "spell",

        talent = "guillotine",
        startsCombat = false,
        texture = 1109118,

        handler = function ()
        end,
    },


    hand_of_guldan = {
        id = 105174,
        cast = 1.5,
        cooldown = 0,
        gcd = "spell",

        spend = 3,
        spendType = "soul_shards",

        startsCombat = true,
        texture = 535592,

        handler = function ()
        end,
    },


    health_funnel = {
        id = 755,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        startsCombat = false,
        texture = 136168,

        handler = function ()
        end,
    },


    howl_of_terror = {
        id = 5484,
        cast = 0,
        cooldown = 40,
        gcd = "spell",

        talent = "howl_of_terror",
        startsCombat = false,
        texture = 607852,

        handler = function ()
        end,
    },


    implosion = {
        id = 196277,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = 0.02,
        spendType = "mana",

        talent = "implosion",
        startsCombat = false,
        texture = 2065588,

        handler = function ()
        end,
    },


    inquisitors_gaze = {
        id = 386344,
        cast = 0,
        cooldown = 10,
        gcd = "spell",

        talent = "inquisitors_gaze",
        startsCombat = false,
        texture = 1387707,

        handler = function ()
        end,
    },


    mortal_coil = {
        id = 6789,
        cast = 0,
        cooldown = 45,
        gcd = "spell",

        spend = 0.02,
        spendType = "mana",

        talent = "mortal_coil",
        startsCombat = false,
        texture = 607853,

        handler = function ()
        end,
    },


    nether_portal = {
        id = 267217,
        cast = 1.5,
        cooldown = 180,
        gcd = "spell",

        spend = 1,
        spendType = "soul_shards",

        talent = "nether_portal",
        startsCombat = false,
        texture = 2065615,

        toggle = "cooldowns",

        handler = function ()
        end,
    },


    nether_ward = {
        id = 212295,
        cast = 0,
        cooldown = 45,
        gcd = "off",

        spend = 0.01,
        spendType = "mana",

        pvptalent = "nether_ward",
        startsCombat = false,
        texture = 135796,

        handler = function ()
        end,
    },


    power_siphon = {
        id = 264130,
        cast = 0,
        cooldown = 30,
        gcd = "spell",

        talent = "power_siphon",
        startsCombat = false,
        texture = 236290,

        handler = function ()
        end,
    },


    ritual_of_doom = {
        id = 342601,
        cast = 0,
        cooldown = 3600,
        gcd = "spell",

        spend = 1,
        spendType = "soul_shards",

        startsCombat = false,
        texture = 538538,

        toggle = "cooldowns",

        handler = function ()
        end,
    },


    ritual_of_summoning = {
        id = 698,
        cast = 0,
        cooldown = 120,
        gcd = "spell",

        spend = 0,
        spendType = "mana",

        startsCombat = true,
        texture = 136223,

        toggle = "cooldowns",

        handler = function ()
        end,
    },


    shadow_bolt = {
        id = 686,
        cast = 2,
        cooldown = 0,
        gcd = "spell",

        spend = 0.02,
        spendType = "mana",

        startsCombat = true,
        texture = 136197,

        handler = function ()
        end,
    },


    shadow_bulwark = {
        id = 119907,
        cast = 0,
        cooldown = 0,
        gcd = "off",

        startsCombat = true,
        texture = 136121,

        handler = function ()
        end,
    },


    shadow_rift = {
        id = 353294,
        cast = 0,
        cooldown = 60,
        gcd = "spell",

        spend = 0.01,
        spendType = "mana",

        pvptalent = "shadow_rift",
        startsCombat = false,
        texture = 4067372,

        toggle = "cooldowns",

        handler = function ()
        end,
    },


    shadowflame = {
        id = 384069,
        cast = 0,
        cooldown = 15,
        gcd = "spell",

        talent = "shadowflame",
        startsCombat = false,
        texture = 236302,

        handler = function ()
        end,
    },


    shadowfury = {
        id = 30283,
        cast = 1.5,
        cooldown = 60,
        gcd = "spell",

        spend = 0.01,
        spendType = "mana",

        talent = "shadowfury",
        startsCombat = false,
        texture = 607865,

        toggle = "cooldowns",

        handler = function ()
        end,
    },


    soul_strike = {
        id = 264057,
        cast = 0,
        cooldown = 10,
        gcd = "spell",

        talent = "soul_strike",
        startsCombat = false,
        texture = 1452864,

        handler = function ()
        end,
    },


    soulburn = {
        id = 385899,
        cast = 0,
        cooldown = 0,
        gcd = "off",

        spend = 1,
        spendType = "soul_shards",

        talent = "soulburn",
        startsCombat = false,
        texture = 463286,

        handler = function ()
        end,
    },


    soulstone = {
        id = 20707,
        cast = 3,
        cooldown = 600,
        gcd = "spell",

        spend = 0.01,
        spendType = "mana",

        startsCombat = false,
        texture = 136210,

        toggle = "cooldowns",

        handler = function ()
        end,
    },


    subjugate_demon = {
        id = 1098,
        cast = 3,
        cooldown = 0,
        gcd = "spell",

        spend = 0.02,
        spendType = "mana",

        startsCombat = true,
        texture = 136154,

        handler = function ()
        end,
    },


    summon_demonic_tyrant = {
        id = 265187,
        cast = 2,
        cooldown = 90,
        gcd = "spell",

        spend = 0.02,
        spendType = "mana",

        talent = "summon_demonic_tyrant",
        startsCombat = false,
        texture = 2065628,

        toggle = "cooldowns",

        handler = function ()
        end,
    },


    summon_vilefiend = {
        id = 264119,
        cast = 2,
        cooldown = 45,
        gcd = "spell",

        spend = 1,
        spendType = "soul_shards",

        talent = "summon_vilefiend",
        startsCombat = false,
        texture = 1616211,

        handler = function ()
        end,
    },


    unending_breath = {
        id = 5697,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = 0.02,
        spendType = "mana",

        startsCombat = false,
        texture = 136148,

        handler = function ()
        end,
    },


    unending_resolve = {
        id = 104773,
        cast = 0,
        cooldown = 180,
        gcd = "off",

        spend = 0.02,
        spendType = "mana",

        startsCombat = false,
        texture = 136150,

        toggle = "cooldowns",

        handler = function ()
        end,
    },
} )

spec:RegisterPriority( "Demonology", 20220918,
-- Notes
[[

]],
-- Priority
[[

]] )