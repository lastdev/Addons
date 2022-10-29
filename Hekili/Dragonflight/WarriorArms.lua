-- WarriorArms.lua
-- October 2022
-- Updated for PTR Build 46181
-- Last Modified 10/20/2022 18:15 UTC

if UnitClassBase( "player" ) ~= "WARRIOR" then return end

local addon, ns = ...
local Hekili = _G[ addon ]
local class, state = Hekili.Class, Hekili.State
local FindPlayerAuraByID = ns.FindPlayerAuraByID

local spec = Hekili:NewSpecialization( 71 )

-- Conduits (Patch 10.0) : In all cases, talents override and disable conduits they share effects with.
-- Talents override:

-- Fueled by Violence
-- Piercing Verdict
-- Cacophonous Roar
-- Inspiring Presence
-- Merciless Bonegrinder
-- Ashen Juggernaut

-- Conduits that need modeled.
-- [X] Indelible Victory
-- [X] Stalwart Guardian
-- [X] Disturb the Peace

local base_rage_gen, arms_rage_mult = 1.75, 4.000

spec:RegisterResource( Enum.PowerType.Rage, {
    mainhand = {
        swing = "mainhand",

        last = function ()
            local swing = state.swings.mainhand
            local t = state.query_time
            if state.mainhand_speed == 0 then
                return 0
            else
                return swing + floor( ( t - swing ) / state.mainhand_speed ) * state.mainhand_speed
            end
        end,

        interval = "mainhand_speed",

        stop = function () return state.swings.mainhand == 0 end,
        value = function ()
            return ( state.talent.war_machine.enabled and 1.1 or 1 ) * base_rage_gen * arms_rage_mult * state.mainhand_speed / state.haste
        end,
    },

    conquerors_banner = {
        aura = "conquerors_banner",

        last = function ()
            local app = state.buff.conquerors_banner.applied
            local t = state.query_time

            return app + floor( t - app )
        end,

        interval = 1,
        value = 4,
    },
} )

-- Talents
spec:RegisterTalents( {
    anger_management                = { 90289, 152278, 1 }, --
    armored_to_the_teeth            = { 90366, 384124, 2 }, --
    avatar                          = { 90365, 107574, 1 }, --
    barbaric_training               = { 92221, 383082, 1 }, --
    battle_stance                   = { 90327, 386164, 1 }, --
    battlelord                      = { 90436, 386630, 1 }, --
    berserker_rage                  = { 90372, 18499 , 1 }, --
    berserker_shout                 = { 90348, 384100, 1 }, --
    bitter_immunity                 = { 90356, 383762, 1 }, --
    blademasters_torment            = { 90363, 390138, 1 }, --
    bladestorm                      = { 90441, 227847, 1 }, --
    blood_and_thunder               = { 90342, 384277, 1 }, --
    bloodborne                      = { 90283, 383287, 2 }, --
    bloodletting                    = { 90438, 383154, 1 }, --
    bloodsurge                      = { 90277, 384361, 1 }, --
    blunt_instruments               = { 90287, 383442, 1 }, --
    bounding_stride                 = { 90355, 202163, 1 }, --
    cacophonous_roar                = { 90383, 382954, 1 }, --
    cleave                          = { 90293, 845   , 1 }, --
    collateral_damage               = { 90267, 334779, 1 }, --
    colossus_smash                  = { 90290, 167105, 1 }, --
    concussive_blows                = { 90333, 383115, 1 }, --
    crackling_thunder               = { 90342, 203201, 1 }, --
    critical_thinking               = { 90444, 389306, 2 }, --
    cruel_strikes                   = { 90381, 392777, 2 }, --
    crushing_force                  = { 90347, 382764, 2 }, --
    dance_of_death                  = { 90263, 390713, 1 }, --
    defensive_stance                = { 90330, 386208, 1 }, --
    deft_experience                 = { 90437, 389308, 2 }, --
    die_by_the_sword                = { 90276, 118038, 1 }, --
    double_time                     = { 90382, 103827, 1 }, --
    dreadnaught                     = { 90285, 262150, 1 }, --
    elysian_might                   = { 90323, 386285, 1 }, --
    endurance_training              = { 90338, 382940, 1 }, --
    executioners_precision          = { 90445, 386634, 1 }, --
    exhilarating_blows              = { 90286, 383219, 1 }, --
    fast_footwork                   = { 90371, 382260, 1 }, --
    fatality                        = { 90439, 383703, 1 }, --
    fervor_of_battle                = { 90272, 202316, 1 }, --
    frothing_berserker              = { 90352, 392792, 1 }, --
    fueled_by_violence              = { 90275, 383103, 1 }, --
    furious_blows                   = { 90336, 390354, 1 }, --
    heroic_leap                     = { 90346, 6544  , 1 }, --
    honed_reflexes                  = { 90354, 382461, 1 }, --
    hurricane                       = { 90440, 390563, 1 }, --
    impale                          = { 90292, 383430, 1 }, --
    impending_victory               = { 90326, 202168, 1 }, --
    improved_execute                = { 90273, 316405, 1 }, --
    improved_mortal_strike          = { 90443, 385573, 1 }, --
    improved_overpower              = { 90279, 385571, 1 }, --
    in_for_the_kill                 = { 90288, 248621, 1 }, --
    inspiring_presence              = { 90332, 382310, 1 }, --
    intervene                       = { 90329, 3411  , 1 }, --
    intimidating_shout              = { 90384, 5246  , 1 }, --
    juggernaut                      = { 90446, 383292, 1 }, --
    leeching_strikes                = { 90344, 382258, 1 }, --
    martial_prowess                 = { 90278, 316440, 1 }, --
    massacre                        = { 90291, 281001, 1 }, --
    menace                          = { 90383, 275338, 1 }, --
    merciless_bonegrinder           = { 90266, 383317, 1 }, --
    mortal_strike                   = { 90270, 12294 , 1 }, --
    overpower                       = { 90271, 7384  , 1 }, --
    overwhelming_rage               = { 90378, 382767, 2 }, --
    pain_and_gain                   = { 90353, 382549, 1 }, --
    piercing_howl                   = { 90348, 12323 , 1 }, --
    piercing_verdict                = { 90379, 382948, 1 }, --
    rallying_cry                    = { 90331, 97462 , 1 }, --
    reaping_swings                  = { 90294, 383293, 1 }, --
    reinforced_plates               = { 90368, 382939, 1 }, --
    rend                            = { 90284, 772   , 1 }, --
    rumbling_earth                  = { 90374, 275339, 1 }, --
    second_wind                     = { 90332, 29838 , 1 }, --
    seismic_reverberation           = { 90340, 382956, 1 }, --
    sharpened_blades                = { 90447, 383341, 1 }, --
    shattering_throw                = { 90351, 64382 , 1 }, --
    shockwave                       = { 90375, 46968 , 1 }, --
    sidearm                         = { 90333, 384404, 1 }, --
    skullsplitter                   = { 90281, 260643, 1 }, --
    sonic_boom                      = { 90321, 390725, 1 }, --
    spear_of_bastion                = { 90380, 376079, 1 }, --
    spell_reflection                = { 90385, 23920 , 1 }, --
    storm_bolt                      = { 90337, 107570, 1 }, --
    storm_of_swords                 = { 90267, 385512, 1 }, --
    storm_wall                      = { 90269, 388807, 1 }, --
    sudden_death                    = { 90274, 29725 , 1 }, --
    sweeping_strikes                = { 90268, 260708, 1 }, --
    tactician                       = { 90282, 184783, 1 }, --
    test_of_might                   = { 90288, 385008, 1 }, --
    thunder_clap                    = { 92224, 6343,  1  }, -- TODO: is 396719 in BETA Build for Arms/Fury
    thunderous_roar                 = { 90359, 384318, 1 }, --
    thunderous_words                = { 90358, 384969, 1 }, --
    tide_of_blood                   = { 90280, 386357, 1 }, --
    titanic_throw                   = { 90341, 384090, 1 }, --
    twohanded_weapon_specialization = { 90322, 382896, 1 }, --
    unhinged                        = { 90440, 386628, 1 }, --
    uproar                          = { 90357, 391572, 1 }, --
    valor_in_victory                = { 90442, 383338, 2 }, --
    war_machine                     = { 90328, 262231, 1 }, --
    warbreaker                      = { 90287, 262161, 1 }, --
    warlords_torment                = { 90363, 390140, 1 }, --
    wild_strikes                    = { 90360, 382946, 2 }, --
    wrecking_throw                  = { 90351, 384110, 1 }, --
} )


-- PvP Talents
spec:RegisterPvpTalents( {
    death_sentence         = 3522, -- 198500
    demolition             = 5372, -- 329033
    disarm                 = 3534, -- 236077
    duel                   = 34  , -- 236273
    master_and_commander   = 28  , -- 235941
    rebound                = 5547, -- 213915
    shadow_of_the_colossus = 29  , -- 198807
    sharpen_blade          = 33  , -- 198817
    storm_of_destruction   = 31  , -- 236308
    war_banner             = 32  , -- 236320
    warbringer             = 5376, -- 356353
} )


-- Auras
spec:RegisterAuras( {
    avatar = {
        id = 107574,
        duration = 20,
        max_stack = 1
    },
    battle_shout = {
        id = 6673,
        duration = 3600,
        max_stack = 1
    },
    battle_stance = {
        id = 386164,
        duration = 3600,
        max_stack = 1
    },
    battlelord =  {
        id = 386631,
        duration = 10,
        max_stack = 1
    },
    berserker_rage = {
        id = 18499,
        duration = 6,
        max_stack = 1
    },
    berserker_shout = {
        id = 384100,
        duration = 6,
        max_stack = 1
    },
    bladestorm = {
        id = 227847,
        duration = function () return (6 + (buff.dance_of_death.up and 3 or 0)) * haste end,
        max_stack = 1,
        onCancel = function()
            setCooldown( "global_cooldown", 0 )
        end,
    },
    bounding_stride = {
        id = 202164,
        duration = 3,
        max_stack = 1
    },
    charge = {
        id = 105771,
        duration = 1,
        max_stack = 1
    },
    collateral_damage = {
        id = 334783,
        duration = 30,
        max_stack = 20
    },
    colossus_smash = {
        id = 208086,
        duration = function () return 10 + ( talent.blunt_instruments.enabled and 3 or 0 ) end,
        max_stack = 1,
    },
    crushing_force = {
        id = 382764
    },
    dance_of_death = {
        id = 390714,
        duration = 180,
        max_stack = 1,
    },
    deep_wounds = {
        id = 262115,
        duration = function() return 12 + (talent.bloodletting.enabled and 6 or 0) end,
        tick_time = 3,
        max_stack = 1
    },
    defensive_stance = {
        id = 386208,
        duration = 3600,
        max_stack = 1
    },
    die_by_the_sword = {
        id = 118038,
        duration = 8,
        max_stack = 1
    },
    disarm = {
        id = 236077,
        duration = 6,
        max_stack = 1
    },
    duel = {
        id = 236273,
        duration = 8,
        max_stack = 1
    },
    elysian_might = {
        id = 386286,
        duration = 8,
        max_stack = 1
    },
    executioners_precision = {
        id = 386633,
        duration = 30,
        max_stack = 2
    },
    exploiter = { -- Shadowlands Legendary
        id = 335452,
        duration = 30,
        max_stack = 1
    },
    fatal_mark = {
        id = 383704,
        duration = 60,
        max_stack = 999
    },
    hamstring = {
        id = 1715,
        duration = 15,
        max_stack = 1
    },
    hurricane = {
        id = 390581,
        duration = 6,
        max_stack = 6,
    },
    fatality = {
        id = 383703
    },
    honed_reflexes = {
        id = 382461
    },
    improved_overpower = {
        id = 385571,
    },
    in_for_the_kill = {
        id = 248622,
        duration = 10,
        max_stack = 1,
    },
    indelible_victory = {
        id = 336642,
        duration = 8,
        max_stack = 1
    },
    intimidating_shout = {
        id = function () return talent.menace.enabled and 316593 or 5246 end,
        duration = function () return talent.menace.enabled and 15 or 8 end,
        max_stack = 1
    },
    merciless_bonegrinder = {
        id = 383316,
        duration = 9,
        max_stack = 1,
    },
    mortal_wounds = {
        id = 115804,
        duration = 10,
        max_stack = 1
    },
    juggernaut = {
        id = 383290,
        duration = 12,
        max_stack = 12
    },
    overpower = {
        id = 7384,
        duration = 15,
        max_stack = function() return 1 + ( talent.martial_prowess.enabled and 1 or 0 ) end,
    },
    piercing_howl = {
        id = 12323,
        duration = 8,
        max_stack = 1
    },
    rallying_cry = {
        id = 97463,
        duration = function () return 10 + ( talent.inspiring_presence.enabled and 3 or 0 ) end,
        max_stack = 1,
    },
    recklessness = {
        id = 1719,
        duration = 4,
        max_stack = 1
    },
    rend = {
        id = 388539,
        duration = function() return 15 + ( talent.bloodletting.enabled and 6 or 0 ) end,
        tick_time = 3,
        max_stack = 1,
        copy = 772
    },
    sharpen_blade = {
        id = 198817,
        duration = 3600,
        max_stack = 1
    },
    spear_of_bastion = {
        id = 376080,
        duration = function() return talent.elysian_might.enabled and 6 or 4 end,
        tick_time = 1,
        max_stack = 1
    },
    spell_reflection = {
        id = 23920,
        duration = function () return legendary.misshapen_mirror.enabled and 8 or 5 end,
        max_stack = 1
    },
    spell_reflection_defense = {
        id = 385391,
        duration = 5,
        max_stack = 1
    },
    storm_bolt = {
        id = 107570,
        duration = 4,
        max_stack = 1
    },
    sweeping_strikes = {
        id = 260708,
        duration = 15,
        max_stack = 1
    },
    sudden_death = {
        id = 52437,
        duration = 10,
        max_stack = 1
    },
    taunt = {
        id = 355,
        duration = 3,
        max_stack = 1
    },
    test_of_might = {
        id = 385013,
        duration = 12,
        max_stack = 1, -- TODO: Possibly implement fake stacks to track the Strength % increase gained from the buff
    },
    thunder_clap = {
        id = 6343,
        duration = 10,
        max_stack = 1
    },
    thunderous_roar = {
        id = 384318,
        duration = function () return 8 + (talent.thunderous_words.enabled and 2 or 0) + (talent.bloodletting.enabled and 6 or 0) end,
        tick_time = 2,
        max_stack = 1
    },
    vicious_warbanner = {
        id = 320707,
        duration = 15,
        max_stack = 1
    },
    victorious = {
        id = 32216,
        duration = 20,
        max_stack = 1
    },
    war_machine = {
        id = 262232,
        duration = 8,
        max_stack = 1
    },
    wild_strikes = {
        id = 392778,
        duration = 10,
        max_stack = 1
    },
} )

local rageSpent = 0
local gloryRage = 0

spec:RegisterStateExpr( "rage_spent", function ()
    return rageSpent
end )

spec:RegisterStateExpr( "glory_rage", function ()
    return gloryRage
end )

spec:RegisterHook( "spend", function( amt, resource )
    if resource == "rage" then
        if talent.anger_management.enabled then
            rage_spent = rage_spent + amt
            local reduction = floor( rage_spent / 20 )
            rage_spent = rage_spent % 20

            if reduction > 0 then
                cooldown.colossus_smash.expires = cooldown.colossus_smash.expires - reduction
                cooldown.bladestorm.expires = cooldown.bladestorm.expires - reduction
                cooldown.warbreaker.expires = cooldown.warbreaker.expires - reduction
            end
        end

        if legendary.glory.enabled and buff.conquerors_banner.up then
            glory_rage = glory_rage + amt
            local reduction = floor( glory_rage / 20 ) * 0.5
            glory_rage = glory_rage % 20

            buff.conquerors_banner.expires = buff.conquerors_banner.expires + reduction
        end
    end
end )

local last_cs_target = nil
local collateralDmgStacks = 0

local TriggerCollateralDamage = setfenv( function()
    addStack( "collateral_damage", nil, collateralDmgStacks )
    collateralDmgStacks = 0
end, state )

local TriggerTier29Crit = setfenv( function()
    applyBuff( "strike_vulnerabilities" )
end, state )

spec:RegisterCombatLogEvent( function( _, subtype, _,  sourceGUID, sourceName, _, _, destGUID, destName, destFlags, _, spellID, spellName, _, _, _, _, critical_swing, _, _, critical_spell )
    if sourceGUID == state.GUID then
        if subtype == "SPELL_CAST_SUCCESS" then
            if ( spellName == class.abilities.colossus_smash.name or spellName == class.abilities.warbreaker.name ) then
                last_cs_target = destGUID
            end

            if state.talent.collateral_damage.enabled and state.buff.sweeping_strikes.up then
                collateralDmgStacks = collateralDmgStacks + 1
            end
        elseif state.set_bonus.tier28_2pc > 0 and subtype == "SPELL_DAMAGE" and UnitGUID( "target" ) == destGUID and critical_spell then
            if spellName == class.abilities.cleave.name or spellName == class.abilities.mortal_strike.name or spellName == class.abilities.execute.name then
                -- Critical boolean is the 21st parameter in SPELL_DAMAGE within CLEU (Ref: https://wowpedia.fandom.com/wiki/COMBAT_LOG_EVENT#Payload)
                TriggerTier29Crit()
            end
        elseif subtype == "SPELL_AURA_REMOVED" and state.talent.collateral_damage.enabled and spellName == class.abilities.sweeping_strikes.name then
            TriggerCollateralDamage()
        end
    end
end )


local RAGE = Enum.PowerType.Rage
local lastRage = -1

spec:RegisterUnitEvent( "UNIT_POWER_FREQUENT", "player", nil, function( event, unit, powerType )
    if powerType == "RAGE" then
        local current = UnitPower( "player", RAGE )

        if current < lastRage - 3 then -- Spent Rage, -3 is used as a Hack to avoid Rage decaying

            if state.talent.anger_management.enabled then
                rageSpent = ( rageSpent + lastRage - current ) % 20
            end

            if state.legendary.glory.enabled and FindPlayerAuraByID( 324143 ) then
                gloryRage = ( gloryRage + lastRage - current ) % 20
            end
        end
        lastRage = current
    end
end )


spec:RegisterHook( "TimeToReady", function( wait, action )
    local id = class.abilities[ action ].id
    if buff.bladestorm.up and ( id < -99 or id > 0 ) then
        wait = max( wait, buff.bladestorm.remains )
    end
    return wait
end )

local cs_actual

local ExpireBladestorm = setfenv( function()
    applyBuff( "merciless_bonegrinder" )
end, state )

local TriggerHurricane = setfenv( function()
    addStack( "hurricane", nil, 1 )
end, state )

local TriggerTestOfMight = setfenv( function()
    addStack( "test_of_might", nil, 1 )
end, state )

spec:RegisterHook( "reset_precast", function ()
    rage_spent = nil
    glory_rage = nil

    if not cs_actual then cs_actual = cooldown.colossus_smash end

    if talent.warbreaker.enabled and cs_actual then
        cooldown.colossus_smash = cooldown.warbreaker
    else
        cooldown.colossus_smash = cs_actual
    end

    if buff.bladestorm.up and talent.merciless_bonegrinder.enabled then
        state:QueueAuraExpiration( "bladestorm_merciless_bonegrinder", ExpireBladestorm, buff.bladestorm.expires )
    end

    if prev_gcd[1].colossus_smash and time - action.colossus_smash.lastCast < 1 and last_cs_target == target.unit and debuff.colossus_smash.down then
        -- Apply Colossus Smash early because its application is delayed for some reason.
        applyDebuff( "target", "colossus_smash" )
    elseif prev_gcd[1].warbreaker and time - action.warbreaker.lastCast < 1 and last_cs_target == target.unit and debuff.colossus_smash.down then
        applyDebuff( "target", "colossus_smash" )
    end

    if debuff.colossus_smash.up and talent.test_of_might.enabled then state:QueueAuraExpiration( "test_of_might", TriggerTestOfMight, debuff.colossus_smash.expires ) end

    if buff.bladestorm.up and talent.hurricane.enabled then
        local next_hu = query_time + (1 * state.haste) - ( ( query_time - buff.bladestorm.applied ) % (1 * state.haste) )

        while ( next_hu <= buff.bladestorm.expires ) do
            state:QueueAuraEvent( "bladestorm_hurricane", TriggerHurricane, next_hu, "AURA_PERIODIC" )
            next_hu = next_hu + (1 * state.haste)
        end

    end

    if talent.collateral_damage.enabled and buff.sweeping_strikes.up then
        state:QueueAuraExpiration( "sweeping_strikes_collateral_dmg", TriggerCollateralDamage, buff.sweeping_strikes.expires )
    end
end )

spec:RegisterStateExpr( "cycle_for_execute", function ()
    if active_enemies == 1 or target.health_pct < ( talent.massacre.enabled and 35 or 20 ) or not settings.cycle or buff.execute_ineligible.down or buff.sudden_death.up then return false end
    return Hekili:GetNumTargetsBelowHealthPct( talent.massacre.enabled and 35 or 20, false, max( settings.cycle_min, offset + delay ) ) > 0
end )

-- Tier 28
spec:RegisterGear( 'tier28', 188942, 188941, 188940, 188938, 188937 )
spec:RegisterSetBonuses( "tier28_2pc", 364553, "tier28_4pc", 363913 )
-- 2-Set - Pile On - Colossus Smash / Warbreaker lasts 3 sec longer and increases your damage dealt to affected enemies by an additional 5%.
-- 4-Set - Pile On - Tactician has a 50% increased chance to proc against enemies with Colossus Smash and causes your next Overpower to grant 2% Strength, up to 20% for 15 sec.
spec:RegisterAuras( {
    pile_on_ready = {
        id = 363917,
        duration = 15,
        max_stack = 1,
    },
    pile_on_str = {
        id = 366769,
        duration = 15,
        max_stack = 4,
        copy = "pile_on"
    }
})

spec:RegisterSetBonuses( "tier29_2pc", 393705, "tier29_4pc", 393706 )
--(2) Set Bonus: Mortal Strike and Cleave damage and chance to critically strike increased by 10%.
--(4) Set Bonus: Mortal Strike, Cleave, & Execute critical strikes increase your damage and critical strike chance by 5% for 6 seconds.
    spec:RegisterAura( "strike_vulnerabilities", {
        id = 394173,
        duration = 6,
        max_stack = 1
    })
------------------------------------------------------------

-- Abilities
spec:RegisterAbilities( {
    avatar = {
        id = 107574,
        cast = 0,
        cooldown = 90,
        gcd = "off",

        spend = -15,
        spendType = "rage",

        talent = "avatar",
        startsCombat = false,
        texture = 613534,

        toggle = "cooldowns",

        handler = function ()
            applyBuff( "avatar" )
            if talent.blademasters_torment.enabled then applyBuff ( "bladestorm", 4) end
            if talent.warlords_torment.enabled then applyBuff ( "recklessness" ) end
        end,
    },


    battle_shout = {
        id = 6673,
        cast = 0,
        cooldown = 15,
        gcd = "spell",

        startsCombat = false,
        texture = 132333,

        nobuff = "battle_shout",
        essential = true,

        handler = function ()
            applyBuff( "battle_shout" )
        end,
    },


    battle_stance = {
        id = 386164,
        cast = 0,
        cooldown = 3,
        gcd = "off",

        talent = "battle_stance",
        startsCombat = false,
        texture = 132349,
        essential = true,

        handler = function ()
            applyBuff( "battle_stance" )
            removeBuff( "defensive_stance" )
        end,
    },


    berserker_rage = {
        id = 18499,
        cast = 0,
        cooldown = 60,
        gcd = "off",

        talent = "berserker_rage",
        startsCombat = false,
        texture = 136009,

        toggle = "cooldowns",

        handler = function ()
            applyBuff( "berserker_rage" )
        end,
    },


    berserker_shout = {
        id = 384100,
        cast = 0,
        cooldown = 60,
        gcd = "off",

        talent = "berserker_shout",
        startsCombat = false,
        texture = 136009,

        toggle = "cooldowns",

        handler = function ()
            applyBuff( "berserker_shout" )
        end,
    },


    bitter_immunity = {
        id = 383762,
        cast = 0,
        cooldown = 180,
        gcd = "off",

        talent = "bitter_immunity",
        startsCombat = false,
        texture = 136088,

        toggle = "cooldowns",

        handler = function ()
            gain( 0.2 * health.max, "health" )
        end,
    },


    bladestorm = {
        id = 227847,
        cast = 0,
        cooldown = 90,
        gcd = "spell",

        talent = "bladestorm",
        startsCombat = true,
        texture = 236303,
        range = 8,

        --[[ generates 20 rage in beta 46144 currently, but not in PTR
        spend = -20,
        spendType = "rage",
        ]]

        toggle = "cooldowns",

        handler = function ()
            applyBuff( "bladestorm" )
            setCooldown( "global_cooldown", class.auras.bladestorm.duration )
            if talent.blademasters_torment.enabled then applyBuff("avatar", 4) end

            if talent.merciless_bonegrinder.enabled then
                state:QueueAuraExpiration( "bladestorm_merciless_bonegrinder", ExpireBladestorm, buff.bladestorm.expires )
            end
        end,
    },


    charge = {
        id = 100,
        cast = 0,
        charges  = function () return talent.double_time.enabled and 2 or 1 end,
        cooldown = function () return talent.double_time.enabled and 17 or 20 end,
        recharge = function () return talent.double_time.enabled and 17 or 20 end,
        gcd = "off",

        spend = -20,
        spentType = "rage",

        startsCombat = true,
        texture = 132337,

        usable = function () return target.distance > 8 and ( query_time - action.charge.lastCast > gcd.execute ) end,
        handler = function ()
            setDistance( 5 )
            applyDebuff( "target", "charge" )
        end,
    },


    cleave = {
        id = 845,
        cast = 0,
        cooldown = function () return 6 - (talent.reaping_swings.enabled and 3 or 0) end,
        gcd = "spell",

        spend = function() return 20 - (buff.battlelord.up and 10 or 0) end,
        spendType = "rage",

        talent = "cleave",
        startsCombat = false,
        texture = 132338,

        handler = function ()
            applyDebuff ( "target" , "deep_wounds" )
            active_dot.deep_wounds = max( active_dot.deep_wounds, active_enemies )
            if buff.overpower.up then removeBuff ( "overpower" ) end
        end,
    },


    colossus_smash = {
        id = 167105,
        cast = 0,
        cooldown = 45,
        gcd = "spell",

        talent = "colossus_smash",
        notalent = "warbreaker",
        startsCombat = false,
        texture = 464973,

        handler = function ()
            applyDebuff( "target", "colossus_smash" )
            applyDebuff( "target", "deep_wounds" )
            if talent.in_for_the_kill.enabled and buff.in_for_the_kill.down then
                applyBuff( "in_for_the_kill" )
                stat.haste = stat.haste + ( target.health.pct < 35 and 0.2 or 0.1 )
            end
            if talent.test_of_might.enabled then
                state:QueueAuraExpiration( "test_of_might", TriggerTestOfMight, debuff.colossus_smash.expires )
            end
        end,
    },


    defensive_stance = {
        id = 386208,
        cast = 0,
        cooldown = 3,
        gcd = "off",

        talent = "defensive_stance",
        startsCombat = false,
        texture = 132341,

        handler = function ()
            removeBuff( "battle_stance" )
            applyBuff( "defensive_stance" )
        end,
    },


    die_by_the_sword = {
        id = 118038,
        cast = 0,
        cooldown = function () return 120 - ( talent.valor_in_victory.rank * 15 ) - ( conduit.stalwart_guardian.enabled and 20 or 0 ) end,
        gcd = "off",

        talent = "die_by_the_sword",
        startsCombat = false,
        texture = 132336,

        toggle = "defensives",

        handler = function ()
            applyBuff ( "die_by_the_sword" )
        end,
    },


    disarm = {
        id = 236077,
        cast = 0,
        cooldown = 45,
        gcd = "spell",

        pvptalent = "disarm",
        startsCombat = false,
        texture = 132343,

        handler = function ()
            applyDebuff( "target", "disarm")
        end,
    },


    duel = {
        id = 236273,
        cast = 0,
        cooldown = 60,
        gcd = "spell",

        pvptalent = "duel",
        startsCombat = false,
        texture = 1455893,

        toggle = "cooldowns",

        handler = function ()
            applyDebuff ( "target", "duel" )
            applyBuff ( "duel" )
        end,
    },


    execute = {
        id = function () return talent.massacre.enabled and 281000 or 163201 end,
        known = 163201,
        copy = { 163201, 281000 },
        noOverride = 317485,
        cast = 0,
        cooldown = function () return ( talent.improved_execute.enabled and 0 or 6 ) end,
        gcd = "spell",
        hasteCD = true,

        spend = 0,
        spendType = "rage",

        startsCombat = true,
        texture = 135358,

        usable = function ()
            if buff.sudden_death.up or buff.stone_heart.up then return true end
            if cycle_for_execute then return true end
           return target.health_pct < ( talent.massacre.enabled and 35 or 20 ), "requires < " .. ( talent.massacre.enabled and 35 or 20 ) .. "% health"
        end,

        cycle = "execute_ineligible",

        indicator = function () if cycle_for_execute then return "cycle" end end,

        timeToReady = function()
            -- Instead of using regular resource requirements, we'll use timeToReady to support the spend system.
            if rage.current >= 20 then return 0 end
            return rage.time_to_20
        end,
        handler = function ()
            if not buff.sudden_death.up and not buff.stone_heart.up then
                local cost = min( rage.current, 40 )
                spend( cost, "rage", nil, true )
                if talent.improved_execute.enabled then
                    gain( cost * 0.2, "rage" ) -- Regain 20% for target not dying
                end
                if talent.critical_thinking.enabled then
                    gain( cost * (talent.critical_thinking.rank * 0.1), "rage") -- Regain up to another 20% for critical thinking
                end
            end
            removeBuff( "sudden_death" )
            if talent.executioners_precision.enabled then applyBuff ( "executioners_precision" ) end
            if legendary.exploiter.enabled then applyDebuff( "target", "exploiter", nil, min( 2, debuff.exploiter.stack + 1 ) ) end
            if talent.juggernaut.enabled then addStack( "juggernaut", nil, 1 ) end
        end,

        auras = {
            -- Legendary
            exploiter = {
                id = 335452,
                duration = 30,
                max_stack = 2,
            },
            -- Target Swapping
            execute_ineligible = {
                duration = 3600,
                max_stack = 1,
                generate = function( t, auraType )
                    if buff.sudden_death.down and buff.stone_heart.down and target.health_pct > ( talent.massacre.enabled and 35 or 20 ) then
                        t.count = 1
                        t.expires = query_time + 3600
                        t.applied = query_time
                        t.duration = 3600
                        t.caster = "player"
                        return
                    end
                    t.count = 0
                    t.expires = 0
                    t.applied = 0
                    t.caster = "nobody"
                end
            }
        }
    },

    hamstring = {
        id = 1715,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = 10,
        spendType = "rage",

        startsCombat = true,
        texture = 132316,

        handler = function ()
            applyDebuff ( "target", "hamstring" )
        end,
    },


    heroic_leap = {
        id = 6544,
        cast = 0,
        cooldown = function () return 45 + (talent.bounding_stride.enabled and -15 or 0) end,
        charges = function () return legendary.leaper.enabled and 3 or nil end,
            recharge = function () return legendary.leaper.enabled and ( talent.bounding_stride.enabled and 30 or 45 ) or nil end,
        gcd = "off",

        talent = "heroic_leap",
        startsCombat = false,
        texture = 236171,

        handler = function ()
            if talent.bounding_stride.enabled then applyBuff( "bounding_stride" ) end
        end,
    },


    heroic_throw = {
        id = 57755,
        cast = 0,
        cooldown = 6,
        gcd = "spell",

        startsCombat = true,
        texture = 132453,

        handler = function ()
        end,
    },


    impending_victory = {
        id = 202168,
        cast = 0,
        cooldown = 25,
        gcd = "spell",

        spend = 10,
        spendType = "rage",

        talent = "impending_victory",
        startsCombat = false,
        texture = 589768,

        handler = function ()
            gain( health.max * 0.3, "health" )
            if conduit.indelible_victory.enabled then applyBuff( "indelible_victory" ) end
        end,
    },


    intervene = {
        id = 3411,
        cast = 0,
        cooldown = 30,
        gcd = "off",

        talent = "intervene",
        startsCombat = false,
        texture = 132365,

        handler = function ()
        end,
    },


    intimidating_shout = {
        id = function () return talent.menace.enabled and 316593 or 5246 end,
        copy = { 316593, 5246 },
        cast = 0,
        cooldown = 90,
        gcd = "spell",

        talent = "intimidating_shout",
        startsCombat = true,
        texture = 132154,

        toggle = "cooldowns",

        handler = function ()
            applyDebuff( "target", "intimidating_shout" )
            active_dot.intimidating_shout = max( active_dot.intimidating_shout, active_enemies )
        end,
    },


    mortal_strike = {
        id = 12294,
        cast = 0,
        cooldown = 6,
        gcd = "spell",
        hasteCD = true,

        spend = function() return 30 - (buff.battlelord.up and 10 or 0) end,
        spendType = "rage",

        talent = "mortal_strike",
        startsCombat = true,
        texture = 132355,

        handler = function ()
            if buff.overpower.up then removeBuff ( "overpower" ) end
            if buff.executioners_precision.up then removeBuff( "executioners_precision" ) end
            if buff.battlelord.up then removeBuff ( "battlelord" ) end
        end,
    },


    overpower = {
        id = 7384,
        cast = 0,
        charges = function () return 1 + (talent.dreadnaught.enabled and 1 or 0) end,
        cooldown = function () return 12 - (talent.honed_reflexes.enabled and 1 or 0) end,
        recharge = function () return 12 - (talent.honed_reflexes.enabled and 1 or 0) end,
        gcd = "spell",

        talent = "overpower",
        startsCombat = true,
        texture = 132223,

        handler = function ()
            if talent.martial_prowess.enabled then applyBuff ( "overpower" ) end

            --Tier28
            if buff.pile_on_ready.up then
                addStack( "pile_on_str", nil, 1 )
                removeBuff( "pile_on_ready" )
            end
        end,
    },


    piercing_howl = {
        id = 12323,
        cast = 0,
        cooldown = function () return 30 - ( conduit.disturb_the_peace.enabled and 5 or 0 ) end,
        gcd = "spell",

        talent = "piercing_howl",
        startsCombat = false,
        texture = 136147,

        handler = function ()
            applyDebuff( "target", "piercing_howl" )
            active_dot.piercing_howl = max( active_dot.piercing_howl, active_enemies )
        end,
    },


    pummel = {
        id = 6552,
        cast = 0,
        cooldown = function () return 15 - (talent.concussive_blows.enabled and 1 or 0) - (talent.honed_reflexes.enabled and 1 or 0) end,
        gcd = "off",

        startsCombat = true,
        texture = 132938,

        toggle = "interrupts",

        debuff = "casting",
        readyTime = state.timeToInterrupt,

        handler = function ()
            if talent.concussive_blows.enabled then
                applyDebuff( "target", "concussive_blows" )
            end
        end,
    },


    rallying_cry = {
        id = 97462,
        cast = 0,
        cooldown = 180,
        gcd = "spell",

        talent = "rallying_cry",
        startsCombat = false,
        texture = 132351,

        toggle = "cooldowns",
        shared = "player",

        handler = function ()
            applyBuff( "rallying_cry" )
            gain( (talent.inspiring_presence.enabled and 0.25 or 0.15) * health.max, "health" )
        end,
    },


    rend = {
        id = 772,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = 30,
        spendType = "rage",

        talent = "rend",
        startsCombat = true,
        texture = 132155,

        handler = function ()
            applyDebuff ( "target", "rend" )
        end,
    },


    sharpen_blade = {
        id = 198817,
        cast = 0,
        cooldown = 25,
        gcd = "off",

        pvptalent = "sharpen_blade",
        startsCombat = false,
        texture = 1380678,

        handler = function ()
            applyBuff ("sharpened_blades")
        end,
    },


    shattering_throw = {
        id = 64382,
        cast = 1.5,
        cooldown = function () return (pvptalent.demolition.enabled and 90 or 180) end,
        gcd = "spell",

        talent = "shattering_throw",
        startsCombat = true,
        texture = 311430,

        toggle = "cooldowns",

        handler = function ()
        end,
    },


    shockwave = {
        id = 46968,
        cast = 0,
        cooldown = function () return ( ( talent.rumbling_earth.enabled and active_enemies >= 3 ) and 25 or 40 ) end,
        gcd = "spell",

        talent = "shockwave",
        startsCombat = true,
        texture = 236312,

        toggle = "interrupts",
        debuff = function () return settings.shockwave_interrupt and "casting" or nil end,
        readyTime = function () return settings.shockwave_interrupt and timeToInterrupt() or nil end,

        usable = function () return not target.is_boss end,

        handler = function ()
            applyDebuff( "target", "shockwave" )
            active_dot.shockwave = max( active_dot.shockwave, active_enemies )
            if not target.is_boss then interrupt() end
        end,
    },


    skullsplitter = {
        id = 260643,
        cast = 0,
        cooldown = 30,
        gcd = "spell",

        spend = -20,
        spendType = "rage",

        talent = "skullsplitter",
        startsCombat = false,
        texture = 2065621,

        handler = function ()
            gain(30,"rage")
            if talent.tide_of_blood.enabled then
                removeDebuff("target","rend")
                removeDebuff("target","deep_wounds")
            end
        end,
    },


    slam = {
        id = 1464,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = function() return 20 + (talent.barbaric_training.enabled and 5 or 0) end,
        spendType = "rage",

        startsCombat = true,
        texture = 132340,

        handler = function ()
        end,
    },


    spear_of_bastion = {
        id = 376079,
        cast = 0,
        cooldown = 90,
        gcd = "spell",

        spend = function () return (-25 * ( talent.piercing_verdict.enabled and 2 or 1 ) ) end,
        spendType = "rage",

        talent = "spear_of_bastion",
        startsCombat = false,
        texture = 3565453,

        toggle = "cooldowns",

        handler = function ()
            applyDebuff ("target", "spear_of_bastion" )
        end,
    },


    spell_reflection = {
        id = 23920,
        cast = 0,
        charges = 1,
        cooldown = 25,
        recharge = 25,
        gcd = "off",

        talent = "spell_reflection",
        startsCombat = false,
        texture = 132361,
        toggle = "interrupts",

        handler = function ()
            applyBuff( "spell_reflection" )
        end,
    },


    storm_bolt = {
        id = 107570,
        cast = 0,
        cooldown = 30,
        gcd = "spell",

        talent = "storm_bolt",
        startsCombat = true,
        texture = 613535,

        handler = function ()
            applyDebuff( "target", "storm_bolt" )
        end,
    },


    sweeping_strikes = {
        id = 260708,
        cast = 0,
        cooldown = 30,
        gcd = "off",
        icd = 0.75,


        talent = "sweeping_strikes",
        startsCombat = false,
        texture = 132306,

        handler = function ()
            setCooldown( "global_cooldown", 0.75 )
            applyBuff( "sweeping_strikes" )

            if talent.collateral_damage.enabled then
                state:QueueAuraExpiration( "sweeping_strikes_collateral_dmg", TriggerCollateralDamage, buff.sweeping_strikes.expires )
            end
        end,
    },


    taunt = {
        id = 355,
        cast = 0,
        cooldown = 8,
        gcd = "off",

        startsCombat = true,
        texture = 136080,

        handler = function ()
            applyDebuff( "target", "taunt" )
        end,
    },


    thunder_clap = {
        id = 6343,
        cast = 0,
        cooldown = 6,
        hasteCD = true,
        gcd = "spell",

        spend = function() return 30 + ( talent.blood_and_thunder.enabled and 10 or 0 ) end,
        spendType = "rage",

        talent = "thunder_clap",
        startsCombat = true,
        texture = 136105,

        handler = function ()
            applyDebuff( "target", "thunder_clap" )
            active_dot.thunder_clap = max( active_dot.thunder_clap, active_enemies )

            if talent.blood_and_thunder.enabled and talent.rend.enabled then -- Blood and Thunder now directly applies Rend to 5 nearby targets
                applyDebuff( "target", "rend" )
                active_dot.rend = min( active_enemies, 5 )
            end
        end,
    },


    thunderous_roar = {
        id = 384318,
        cast = 0,
        cooldown = function() return 90 - (talent.uproar.enabled and 30 or 0 ) end,
        gcd = "spell",

        spend = -10,
        spendType = "rage",

        talent = "thunderous_roar",
        startsCombat = true,
        texture = 642418,

        toggle = "cooldowns",

        handler = function ()
            applyDebuff ("target", "thunderous_roar" )
            active_dot.thunderous_roar = max( active_dot.thunderous_roar, active_enemies )
        end,
    },


    titanic_throw = {
        id = 384090,
        cast = 0,
        cooldown = 6,
        gcd = "spell",

        talent = "titanic_throw",
        startsCombat = true,
        texture = 132453,

        handler = function ()
        end,
    },


    victory_rush = {
        id = 34428,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        startsCombat = true,
        texture = 132342,

        buff = "victorious",
        handler = function ()
            removeBuff( "victorious" )
            gain( 0.2 * health.max, "health" )
            if conduit.indelible_victory.enabled then applyBuff( "indelible_victory" ) end
        end,
    },


    war_banner = {
        id = 236320,
        cast = 0,
        cooldown = 90,
        gcd = "off",

        pvptalent = "war_banner",
        startsCombat = false,
        texture = 603532,

        toggle = "cooldowns",

        handler = function ()
            applyBuff ("war_banner")
        end,
    },


    warbreaker = {
        id = 262161,
        cast = 0,
        cooldown = 45,
        gcd = "spell",

        talent = "warbreaker",
        startsCombat = false,
        texture = 2065633,
        range = 8,

        handler = function ()
            if talent.in_for_the_kill.enabled and buff.in_for_the_kill.down then
                applyBuff( "in_for_the_kill" )
                stat.haste = stat.haste + ( target.health.pct < 35 and 0.2 or 0.1 )
            end
            applyDebuff( "target", "colossus_smash" )
            active_dot.colossus_smash = max( active_dot.colossus_smash, active_enemies )

            if talent.test_of_might.enabled then
                state:QueueAuraExpiration( "test_of_might", TriggerTestOfMight, debuff.colossus_smash.expires )
            end
        end,
    },


    whirlwind = {
        id = 1680,
        cast = 0,
        cooldown = function () return (talent.storm_of_steel.enabled and 14 or 0) end,
        gcd = "spell",

        spend = function() return 30 + (talent.barbaric_training.enabled and 5 or 0 ) + (talent.storm_of_swords.enabled and 30 or 0) end,
        spendType = "rage",

        startsCombat = false,
        texture = 132369,

        handler = function ()
            removeBuff ( "collateral_damage" )
            collateralDmgStacks = 0
        end,
    },


    wrecking_throw = {
        id = 384110,
        cast = 0,
        cooldown = function () return (pvptalent.demolition.enabled and 45 * 0.5 or 45) end,
        gcd = "spell",

        talent = "wrecking_throw",
        startsCombat = false,
        texture = 460959,

        handler = function ()
        end,
    },
} )

spec:RegisterSetting( "shockwave_interrupt", true, {
    name = "Only |T236312:0|t Shockwave as Interrupt (when Talented)",
    desc = "If checked, |T236312:0|t Shockwave will only be recommended when your target is casting.",
    type = "toggle",
    width = "full"
} )

spec:RegisterSetting( "heroic_charge", false, {
    name = "Use Heroic Charge Combo",
    desc = "If checked, the default priority will check |cFFFFD100settings.heroic_charge|r to determine whether to use Heroic Leap + Charge together.\n\n" ..
        "This is generally a DPS increase but the erratic movement can be disruptive to smooth gameplay.",
    type = "toggle",
    width = "full",
} )


spec:RegisterOptions( {
    enabled = true,

    aoe = 2,

    nameplates = true,
    nameplateRange = 8,

    damage = true,
    damageDots = false,
    damageExpiration = 8,

    potion = "spectral_strength",

    package = "Arms",
} )


spec:RegisterPack( "Arms", 20221026, [[Hekili:fRvBVnoUr4FlbhG3n3TvXYXoj72ydC9AXHeuSfOElUcC4SfTeTTUql5srTzdGH(T3HK6fskskNBx0(HDJJeNHdhoZZmZJZQWvFA1YeedV6Jtgpzs44j3eeE34RhpB1s2lhXRwEef)eAh8Hm0b4))r6Hc(dFHKJs4cxKxsJHxSNXow8HRUAxkBF5MG48dxvKEOKGyP5zXu0wg)3JVA1YnLPe2dzR2yBNdND9QLOs2(C6QLlBvWpXvaSjPjjyPK4IyP1uf9liknnNw94KBQI(hXS8nyAvexRvrVnCBYM7M8(lRES6XhYszPisv0FLI2LNTLKUBpRkk9WXCkly1ssAbRqCOsZ2rWRzi6omdEWhf(jCgAdbNS6VSAzmnLHPPOvlP4dO0mWkUFEv0U4eW6J5wm)nzjRyWXZPSWYdALheFCNWOpJGDNl(1CXB1j88DyQQ(GLmvDjpJOBOy0t9w1m1vfNtYlkklwxCavS3yL340IJ3ZDjsRDsN2Y)mMEm)zSWGV1TVQmdVnhuqa4AkPGtE9gs(Zb1lUk60PQOUfTbXyemjNMOVInLB3g0ULbfmieTkAHUjDaUsrK1fmA6tyUzDNtZsOVIsEO16emIThUua1O6SYsWhY4A59)X1c(l44sMWwch72hb3Vbj4TPXPqO5IQOPZ6urXtLesXrskJj91HEcmbfbrLvrxRewTHGGmhwo9Gq6jQHeDxI6rdHArG6(vJvo9mstQIGRErsDv03dX8bx3pLjCMtfvCeti1zMfbpVpLsEonlr4QcvUYiy0NL(A3rZWbbNXc2IPFoNUoF7AzeNE0MVnC6WlbWGgvhYw8mgFKh0lDEfbj5pNPK42iNWQDNfDrv0GgoSLVfsLeHaGrmBS0qtWcdrp5pO8O8TxOM85id9sLGrcIhfX4GXBrLeRaLCCAA6rPe)nzgaOgmeR9cCospagiBp8FGwbi8OuiebW4sjCneOCFkaEAHtBE8XYdhWeJWWRpFaxHNYUxPDDG)7oPdAlVEXA1q5jkjNhZf)Sbp2Qb46cqndnppz92s6lTy2VcnPA03OOumTatFcUohaEppNWdkd0YY10AyWmHtRfEzMAvlAmkdQBMtHmzM)Ib2pa8DxOF)Ms3wkQHxS(3lt2DOEpDJ0pS7FBkflUc8d2pSIqzXaqlfS8yeHmaO)3iFXg0ooya824NkgO8GxC0gaK2nURUHEWWmzIrnEuD3j2rlma)6Q)4dAg8dfOyQoYM0Od2JreOk7XyMSmxRTy7TtQraJHQCziqZWpy7FH6sH8K(grEbkMSgqfxxxb38XnThSKF0I5NlfCl4YFT8xwZBVu2K5AzZ0QDe4g0IIstwJ52BakjPOfUEGkHVwJzpk2An82AZLzoLvVFzrnHJummdauxQTQqBkgbxSpw2qVkUnRZH0icpROElu6C5vgqpVjG2o6VADYBRJH0kC2u(goqpbMErg8pXLWLQEwiDNSMVUvVUw(DwzX9WaUB)eqnGUp)9YDqwygmfLWmBS)EVuD7a7QgQbQ7NYSSyu2t9AYQRVy3L8()HHPKyPn1J9XNCxp0C4UMaMUwW6M2sdIQf40v957BBE8mvKY7nuYLQyy8oQG6VRtsLbWHt63D9TQUeNJlEN6Q8oUO7YKDTtwKUldZevNGuy4aJtwZ7hPWwpRDZ)iAXAOExhPKWoDSYmI9NgtpPTl81tT5ZzK3VQ6Sj5m4aJpU(58YmaF3i636mnUbyCRTMqy9HS9mjU95SN3mtt9fc(lhj58DxFbTkqzkE1(J6nFU3kG9IjSFl6z(ZM2v9poT7(TBvqtNeAtlbfa3wcNMsPlTlI2ABYgtHFJAMMZPWVvpFSULd91OLZ2acAwKLxO3pLwn28nJ94RChcEoGFHoRUniW00ZgyYZ0tdKLylPt7AYE7iMGR2R34E(enZWKMepejOMy1GY)En3K8uyeU4g0Z12udf7hXsyODLiL7DtwHpea3HK1QkbcisGQ(qZs91NoIS7Wt)NTbPXtfVzG2X8EpP28)aDpDUSkQ1RJxI6(da50rpLbGcymGck4lQLkFr6BgV((QL)Yp(p)4dF8N)qvuv0N4u9i5BhA6Lt4ZB0MD4naIj()ucdHdrrf5C2HGE8YpGeSgbLIZGsXbvp(3tZGxDlOZFkpd2DXRFthE8)guelx)rnrmVH)Tc8Ll)gRLWVw1u94aoQ6B6xNl69FLwv9HBY3g1m7Runvp(P9CgcpsZ3MsWs6cpKwWJHaNr5rf)1oCgKcfdQfAV5jEZxC)6dmPqIPtH(qt42bBpI1Yj5r(3Lukd(uAwmPmH36hoLTht)ayar)PQOF9FvG5AcFO43ExveKyeVxD1OSx621QOSCUYHUK4TVq60Bc)t1SF2SP)5Qi(xKLCB(KufGF734knr9rtu25NtjeLtuTkznlv4nepkR8WgSmUHaq4vp(GiaJ)GzcgyfvBeFlyWlf9Ugdv0c5tZlC4Rw(DFxvKX36g)rd9nVXxJ)V9n(QKwqrql3b)W8R6ylqONQOxnjYT6DUSv(2Fh0UK)yTNiyX9DPBNRmQ(8XJ8Y36I7oDsBe(7HPwuuAhPUCf7CsgvjAzS1TenB(nQcQtblxy)ShUimy2iEhF3pBSQEm4v1TvWv9ObiowrVTeSEUEcDIupxP0Oc9BMXBwqNRyhd4TiC0B9qF6IWzNozN20lv3rtk7EhNnS51LcENKJV5HC7WbJPJ6rU59xl2AZNoz8PtMSJ2x4f3XxMjJOQpQU)OHpeWCiAhG(8CE6KtNRQ6nyMuQDT2kubxQnzHz1sANuMURjpxSZdhPJm8wE2ZIBbNQ4dZgpYgDHxAZcKJ(0dSPhyYyRMV0rZL2fhBJ8YV29WMoYlVAk(zLnUj67)5BCDII1xbf(ebr17a3Ho6Tx4KCTrdmK69tBtp9jCFw5UF6LJ6Zf3IWj2S6oXTFbRAzdecCguTjJuBisbkrD6KlOurfHftHirhdGynCUDqcrzhjVzZTEWLZe6h(0XuM8GhBQud8wG47qEEObKRANbS6dSbRxZNmYoBxZNulGglxdDvPFlyB1AST0iZ9tTUwDulXc5y5xyNDQE16TD)55a4bqqfLfa3NB)qCZyTvPHcouszOPO2sGKVXvYt9BBJ)8fLykvNN28n9qMQFSjQudNoF)4GRh5KicRgR5t7fV7sDqwU7mPrxyLLgZntlZ2nzm9Ve0lrz16CrvVHUmR6CgoUEIm4MO5uD6e6ff2YQVsgGwdiZTvFYXA)bN9f4wGEXFMlWwII5ACLYyUUHG5nxFVivNyV2(B)ZoI8cFByVWop37MY(AIzmL1kGxds)cv0BtjTGHFTNRBlrIED6EcCmIlvbO84GhU8TNqXMfPGL46VKn3tam19RM4azv83tJ7lpcs48VyatQUF)zJD39KwXxTq8lf8LU6)c]] )