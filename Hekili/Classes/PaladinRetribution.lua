-- PaladinRetribution.lua
-- May 2018

local addon, ns = ...
local Hekili = _G[ addon ]

local class = Hekili.Class
local state = Hekili.State


local PTR = ns.PTR


-- Conduits
-- [x] expurgation
-- [-] templars_vindication
-- [x] truths_wake
-- [x] virtuous_command


if UnitClassBase( "player" ) == "PALADIN" then
    local spec = Hekili:NewSpecialization( 70 )

    spec:RegisterResource( Enum.PowerType.HolyPower )
    spec:RegisterResource( Enum.PowerType.Mana )

    -- Talents
    spec:RegisterTalents( {
        zeal = 22590, -- 269569
        righteous_verdict = 22557, -- 267610
        execution_sentence = 23467, -- 343527

        fires_of_justice = 22319, -- 203316
        blade_of_wrath = 22592, -- 231832
        empyrean_power = 23466, -- 326732

        fist_of_justice = 22179, -- 234299
        repentance = 22180, -- 20066
        blinding_light = 21811, -- 115750

        unbreakable_spirit = 22433, -- 114154
        cavalier = 22434, -- 230332
        eye_for_an_eye = 22183, -- 205191

        divine_purpose = 17597, -- 223817
        holy_avenger = 17599, -- 105809
        seraphim = 17601, -- 152262

        selfless_healer = 23167, -- 85804
        justicars_vengeance = 22483, -- 215661
        healing_hands = 23086, -- 326734

        sanctified_wrath = 23456, -- 317866
        crusade = 22215, -- 231895
        final_reckoning = 22634, -- 343721
    } )

    -- PvP Talents
    spec:RegisterPvpTalents( {
        aura_of_reckoning = 756, -- 247675
        blessing_of_sanctuary = 752, -- 210256
        divine_punisher = 755, -- 204914
        judgments_of_the_pure = 5422, -- 355858
        jurisdiction = 757, -- 204979
        law_and_order = 858, -- 204934
        lawbringer = 754, -- 246806
        luminescence = 81, -- 199428
        ultimate_retribution = 753, -- 355614
        unbound_freedom = 641, -- 305394
        vengeance_aura = 751, -- 210323
    } )

    -- Auras
    spec:RegisterAuras( {
        avenging_wrath = {
            id = 31884,
            duration = function () return ( azerite.lights_decree.enabled and 25 or 20 ) * ( talent.sanctified_wrath.enabled and 1.25 or 1 ) end,
            max_stack = 1,
        },

        avenging_wrath_autocrit = {
            id = 294027,
            duration = 20,
            max_stack = 1,
            copy = "avenging_wrath_crit"
        },

        blade_of_wrath = {
            id = 281178,
            duration = 10,
            max_stack = 1,
        },

        blessing_of_freedom = {
            id = 1044,
            duration = 8,
            type = "Magic",
            max_stack = 1,
        },

        blessing_of_protection = {
            id = 1022,
            duration = 10,
            type = "Magic",
            max_stack = 1,
        },

        blinding_light = {
            id = 115750,
            duration = 6,
            type = "Magic",
            max_stack = 1,
        },

        concentration_aura = {
            id = 317920,
            duration = 3600,
            max_stack = 1,
        },

        consecration = {
            id = 26573,
            duration = 12,
            max_stack = 1,
            generate = function( c, type )
                local dropped, expires

                c.count = 0
                c.expires = 0
                c.applied = 0
                c.caster = "unknown"

                for i = 1, 5 do
                    local up, name, start, duration = GetTotemInfo( i )

                    if up and name == class.abilities.consecration.name then
                        dropped = start
                        expires = dropped + duration
                        break
                    end
                end

                if dropped and expires > query_time then
                    c.expires = expires
                    c.applied = dropped
                    c.count = 1
                    c.caster = "player"
                end
            end
        },

        crusade = {
            id = 231895,
            duration = 25,
            type = "Magic",
            max_stack = 10,
        },

        crusader_aura = {
            id = 32223,
            duration = 3600,
            max_stack = 1,
        },

        devotion_aura = {
            id = 465,
            duration = 3600,
            max_stack = 1,
        },

        divine_purpose = {
            id = 223819,
            duration = 12,
            max_stack = 1,
        },

        divine_shield = {
            id = 642,
            duration = 8,
            type = "Magic",
            max_stack = 1,
        },

        -- Check racial for aura ID.
        divine_steed = {
            id = 221885,
            duration = function () return 3 * ( 1 + ( conduit.lights_barding.mod * 0.01 ) ) end,
            max_stack = 1,
            copy = { 221886 },
        },

        empyrean_power = {
            id = 326733,
            duration = 15,
            max_stack = 1,
        },

        execution_sentence = {
            id = 343527,
            duration = 8,
            max_stack = 1,
        },

        eye_for_an_eye = {
            id = 205191,
            duration = 10,
            max_stack = 1,
        },

        final_reckoning = {
            id = 343721,
            duration = 8,
            max_stack = 1,
        },

        fires_of_justice = {
            id = 209785,
            duration = 15,
            max_stack = 1,
            copy = "the_fires_of_justice" -- backward compatibility
        },

        forbearance = {
            id = 25771,
            duration = 30,
            max_stack = 1,
        },

        hammer_of_justice = {
            id = 853,
            duration = 6,
            type = "Magic",
            max_stack = 1,
        },

        hand_of_hindrance = {
            id = 183218,
            duration = 10,
            type = "Magic",
            max_stack = 1,
        },

        hand_of_reckoning = {
            id = 62124,
            duration = 3,
            max_stack = 1,
        },

        holy_avenger = {
            id = 105809,
            duration = 20,
            max_stack = 1,
        },

        inquisition = {
            id = 84963,
            duration = 45,
            max_stack = 1,
        },

        judgment = {
            id = 197277,
            duration = 15,
            max_stack = 1,
        },

        retribution_aura = {
            id = 183435,
            duration = 3600,
            max_stack = 1,
        },

        righteous_verdict = {
            id = 267611,
            duration = 6,
            max_stack = 1,
        },

        selfless_healer = {
            id = 114250,
            duration = 15,
            max_stack = 4,
        },

        seraphim = {
            id = 152262,
            duration = 15,
            max_stack = 1,
        },

        shield_of_the_righteous = {
            id = 132403,
            duration = 4.5,
            max_stack = 1,
        },

        shield_of_vengeance = {
            id = 184662,
            duration = 15,
            max_stack = 1,
        },

        the_magistrates_judgment = {
            id = 337682,
            duration = 15,
            max_stack = 1,
        },

        -- what is the undead/demon stun?
        wake_of_ashes = { -- snare.
            id = 255937,
            duration = 5,
            max_stack = 1,
        },

        zeal = {
            id = 269571,
            duration = 20,
            max_stack = 3,
        },


        -- Generic Aura to cover any Aura.
        paladin_aura = {
            alias = { "concentration_aura", "crusader_aura", "devotion_aura", "retribution_aura" },
            aliasMode = "first",
            aliasType = "buff",
            duration = 3600,
        },


        -- Azerite Powers
        empyreal_ward = {
            id = 287731,
            duration = 60,
            max_stack = 1,
        },


        -- PvP
        reckoning = {
            id = 247677,
            max_stack = 30,
            duration = 30
        },


        -- Legendaries
        blessing_of_dawn = {
            id = 337767,
            duration = 12,
            max_stack = 1
        },

        blessing_of_dusk = {
            id = 337757,
            duration = 12,
            max_stack = 1
        },

        final_verdict = {
            id = 337228,
            duration = 15,
            type = "Magic",
            max_stack = 1,
        },

        relentless_inquisitor = {
            id = 337315,
            duration = 12,
            max_stack = 20
        },


        -- Conduits
        expurgation = {
            id = 344067,
            duration = 6,
            max_stack = 1
        }
    } )

    -- Tier 28
    spec:RegisterSetBonuses( "tier28_2pc", 363677, "tier28_4pc", 364370 )
    -- 2-Set - Ashes to Ashes - When you benefit from Art of War, you gain Seraphim for 3 sec.
    -- 4-Set - Ashes to Ashes - Art of War has a 50% chance to reset the cooldown of Wake of Ashes instead of Blade of Justice.
    -- 2/13/22:  No mechanics that can be proactively modeled.

    spec:RegisterGear( "tier19", 138350, 138353, 138356, 138359, 138362, 138369 )
    spec:RegisterGear( "tier20", 147160, 147162, 147158, 147157, 147159, 147161 )
        spec:RegisterAura( "sacred_judgment", {
            id = 246973,
            duration = 8
        } )

    spec:RegisterGear( "tier21", 152151, 152153, 152149, 152148, 152150, 152152 )
        spec:RegisterAura( "hidden_retribution_t21_4p", {
            id = 253806,
            duration = 15
        } )

    spec:RegisterGear( "class", 139690, 139691, 139692, 139693, 139694, 139695, 139696, 139697 )
    spec:RegisterGear( "truthguard", 128866 )
    spec:RegisterGear( "whisper_of_the_nathrezim", 137020 )
        spec:RegisterAura( "whisper_of_the_nathrezim", {
            id = 207633,
            duration = 3600
        } )

    spec:RegisterGear( "justice_gaze", 137065 )
    spec:RegisterGear( "ashes_to_dust", 51745 )
        spec:RegisterAura( "ashes_to_dust", {
            id = 236106,
            duration = 6
        } )

    spec:RegisterGear( "aegisjalmur_the_armguards_of_awe", 140846 )
    spec:RegisterGear( "chain_of_thrayn", 137086 )
        spec:RegisterAura( "chain_of_thrayn", {
            id = 236328,
            duration = 3600
        } )

    spec:RegisterGear( "liadrins_fury_unleashed", 137048 )
        spec:RegisterAura( "liadrins_fury_unleashed", {
            id = 208410,
            duration = 3600,
        } )

    spec:RegisterGear( "soul_of_the_highlord", 151644 )
    spec:RegisterGear( "pillars_of_inmost_light", 151812 )
    spec:RegisterGear( "scarlet_inquisitors_expurgation", 151813 )
        spec:RegisterAura( "scarlet_inquisitors_expurgation", {
            id = 248289,
            duration = 3600,
            max_stack = 3
        } )

    spec:RegisterHook( "prespend", function( amt, resource, overcap )
        if resource == "holy_power" and amt < 0 and buff.holy_avenger.up then
            return amt * 3, resource, overcap
        end
    end )


    spec:RegisterHook( "spend", function( amt, resource )
        if amt > 0 and resource == "holy_power" then
            if talent.crusade.enabled and buff.crusade.up then
                addStack( "crusade", buff.crusade.remains, amt )
            end
            if talent.fist_of_justice.enabled then
                setCooldown( "hammer_of_justice", max( 0, cooldown.hammer_of_justice.remains - 2 * amt ) )
            end
            if legendary.uthers_devotion.enabled then
                setCooldown( "blessing_of_freedom", max( 0, cooldown.blessing_of_freedom.remains - 1 ) )
                setCooldown( "blessing_of_protection", max( 0, cooldown.blessing_of_protection.remains - 1 ) )
                setCooldown( "blessing_of_sacrifice", max( 0, cooldown.blessing_of_sacrifice.remains - 1 ) )
                setCooldown( "blessing_of_spellwarding", max( 0, cooldown.blessing_of_spellwarding.remains - 1 ) )
            end
            if legendary.relentless_inquisitor.enabled then
                if buff.relentless_inquisitor.stack < 6 then
                    stat.haste = stat.haste + 0.01
                end
                addStack( "relentless_inquisitor" )
            end
            if legendary.of_dusk_and_dawn.enabled and holy_power.current == 0 then applyBuff( "blessing_of_dusk" ) end
        end
    end )

    spec:RegisterHook( "gain", function( amt, resource, overcap )
        if legendary.of_dusk_and_dawn.enabled and amt > 0 and resource == "holy_power" and holy_power.current == 5 then
            applyBuff( "blessing_of_dawn" )
        end
    end )

    spec:RegisterStateExpr( "time_to_hpg", function ()
        return max( gcd.remains, min( cooldown.judgment.true_remains, cooldown.crusader_strike.true_remains, cooldown.blade_of_justice.true_remains, ( state:IsUsable( "hammer_of_wrath" ) and cooldown.hammer_of_wrath.true_remains or 999 ), cooldown.wake_of_ashes.true_remains, ( race.blood_elf and cooldown.arcane_torrent.true_remains or 999 ), ( covenant.kyrian and cooldown.divine_toll.true_remains or 999 ) ) )
    end )

    spec:RegisterHook( "reset_precast", function ()
        if buff.divine_resonance.up then
            state:QueueAuraEvent( "divine_toll", class.abilities.judgment.handler, buff.divine_resonance.expires, "AURA_PERIODIC" )
            if buff.divine_resonance.remains > 5 then state:QueueAuraEvent( "divine_toll", class.abilities.judgment.handler, buff.divine_resonance.expires - 5, "AURA_PERIODIC" ) end
            if buff.divine_resonance.remains > 10 then state:QueueAuraEvent( "divine_toll", class.abilities.judgment.handler, buff.divine_resonance.expires - 10, "AURA_PERIODIC" ) end
        end
    end )


    spec:RegisterStateFunction( "apply_aura", function( name )
        removeBuff( "concentration_aura" )
        removeBuff( "crusader_aura" )
        removeBuff( "devotion_aura" )
        removeBuff( "retribution_aura" )

        if name then applyBuff( name ) end
    end )

    spec:RegisterStateFunction( "foj_cost", function( amt )
        if buff.fires_of_justice.up then return max( 0, amt - 1 ) end
        return amt
    end )


    -- Abilities
    spec:RegisterAbilities( {
        avenging_wrath = {
            id = 31884,
            cast = 0,
            cooldown = function () return ( essence.vision_of_perfection.enabled and 0.87 or 1 ) * ( level > 42 and 120 or 180 ) end,
            gcd = "off",

            toggle = "cooldowns",
            notalent = "crusade",

            startsCombat = true,
            texture = 135875,

            nobuff = "avenging_wrath",

            handler = function ()
                applyBuff( "avenging_wrath" )
                applyBuff( "avenging_wrath_crit" )
            end,
        },


        blade_of_justice = {
            id = 184575,
            cast = 0,
            cooldown = function () return 12 * haste end,
            gcd = "spell",

            spend = -2,
            spendType = "holy_power",

            startsCombat = true,
            texture = 1360757,

            handler = function ()
                removeBuff( "blade_of_wrath" )
                removeBuff( "sacred_judgment" )
            end,
        },


        blessing_of_freedom = {
            id = 1044,
            cast = 0,
            charges = 1,
            cooldown = 25,
            recharge = 25,
            gcd = "spell",

            spend = 0.07,
            spendType = "mana",

            startsCombat = false,
            texture = 135968,

            handler = function ()
                applyBuff( "blessing_of_freedom" )
            end,
        },


        blessing_of_protection = {
            id = 1022,
            cast = 0,
            charges = 1,
            cooldown = 300,
            recharge = 300,
            gcd = "spell",

            spend = 0.15,
            spendType = "mana",

            startsCombat = false,
            texture = 135964,

            readyTime = function () return debuff.forbearance.remains end,

            handler = function ()
                applyBuff( "blessing_of_protection" )
                applyDebuff( "player", "forbearance" )

                if talent.liadrins_fury_reborn.enabled then
                    gain( 5, "holy_power" )
                end
            end,
        },


        blinding_light = {
            id = 115750,
            cast = 0,
            cooldown = 90,
            gcd = "spell",

            spend = 0.06,
            spendType = "mana",

            talent = "blinding_light",

            startsCombat = true,
            texture = 571553,

            handler = function ()
                applyDebuff( "target", "blinding_light", 6 )
                active_dot.blinding_light = active_enemies
            end,
        },


        cleanse_toxins = {
            id = 213644,
            cast = 0,
            cooldown = 8,
            gcd = "spell",

            spend = 0.06,
            spendType = "mana",

            startsCombat = false,
            texture = 135953,

            usable = function ()
                return buff.dispellable_poison.up or buff.dispellable_disease.up, "requires poison or disease"
            end,

            handler = function ()
                removeBuff( "dispellable_poison" )
                removeBuff( "dispellable_disease" )
            end,
        },


        concentration_aura = {
            id = 317920,
            cast = 0,
            cooldown = 0,
            gcd = "spell",

            startsCombat = false,
            texture = 135933,

            nobuff = "paladin_aura",

            handler = function ()
                apply_aura( "concentration_aura" )
            end,
        },


        consecration = {
            id = 26573,
            cast = 0,
            cooldown = 20,
            gcd = "spell",

            startsCombat = true,
            texture = 135926,

            handler = function ()
                applyBuff( "consecration" )
            end,
        },


        crusade = {
            id = 231895,
            cast = 0,
            cooldown = 120,
            gcd = "off",

            talent = "crusade",
            toggle = "cooldowns",

            startsCombat = false,
            texture = 236262,

            nobuff = "crusade",

            handler = function ()
                applyBuff( "crusade" )
            end,
        },


        crusader_aura = {
            id = 32223,
            cast = 0,
            cooldown = 0,
            gcd = "spell",

            startsCombat = false,
            texture = 135890,

            nobuff = "paladin_aura",

            handler = function ()
                apply_aura( "crusader_aura" )
            end,
        },


        crusader_strike = {
            id = 35395,
            cast = 0,
            charges = 2,
            cooldown = function () return 6 * ( talent.fires_of_justice.enabled and 0.85 or 1 ) * haste end,
            recharge = function () return 6 * ( talent.fires_of_justice.enabled and 0.85 or 1 ) * haste end,
            gcd = "spell",

            spend = 0.09,
            spendType = "mana",

            startsCombat = true,
            texture = 135891,

            handler = function ()
                gain( buff.holy_avenger.up and 3 or 1, "holy_power" )
            end,
        },


        devotion_aura = {
            id = 465,
            cast = 0,
            cooldown = 0,
            gcd = "spell",

            startsCombat = false,
            texture = 135893,

            nobuff = "paladin_aura",

            handler = function ()
                apply_aura( "devotion_aura" )
            end,
        },


        divine_shield = {
            id = 642,
            cast = 0,
            cooldown = function () return 300 * ( talent.unbreakable_spirit.enabled and 0.7 or 1 ) end,
            gcd = "spell",

            startsCombat = false,
            texture = 524354,

            readyTime = function () return debuff.forbearance.remains end,

            handler = function ()
                applyBuff( "divine_shield" )
                applyDebuff( "player", "forbearance" )

                if talent.liadrins_fury_reborn.enabled then
                    gain( 5, "holy_power" )
                end
            end,
        },


        divine_steed = {
            id = 190784,
            cast = 0,
            charges = function () return talent.cavalier.enabled and 2 or nil end,
            cooldown = function () return level > 48 and 30 or 45 end,
            recharge = function () return level > 48 and 30 or 45 end,
            gcd = "spell",

            startsCombat = false,
            texture = 1360759,

            handler = function ()
                applyBuff( "divine_steed" )
            end,
        },


        divine_storm = {
            id = 53385,
            cast = 0,
            cooldown = 0,
            gcd = "spell",

            spend = function ()
                if buff.divine_purpose.up then return 0 end
                if buff.empyrean_power.up then return 0 end
                return 3 - ( buff.fires_of_justice.up and 1 or 0 ) - ( buff.hidden_retribution_t21_4p.up and 1 or 0 ) - ( buff.the_magistrates_judgment.up and 1 or 0 )
            end,
            spendType = "holy_power",

            startsCombat = true,
            texture = 236250,

            handler = function ()
                removeDebuff( "target", "judgment" )

                if buff.empyrean_power.up or buff.divine_purpose.up then
                    removeBuff( "divine_purpose" )
                    removeBuff( "empyrean_power" )
                else
                    removeBuff( "fires_of_justice" )
                    removeBuff( "hidden_retribution_t21_4p" )
                end

                if buff.avenging_wrath_crit.up then removeBuff( "avenging_wrath_crit" ) end
            end,
        },


        execution_sentence = {
            id = 343527,
            cast = 0,
            cooldown = 60,
            gcd = "spell",

            spend = function ()
                if buff.divine_purpose.up then return 0 end
                return 3 - ( buff.fires_of_justice.up and 1 or 0 ) - ( buff.hidden_retribution_t21_4p.up and 1 or 0 ) - ( buff.the_magistrates_judgment.up and 1 or 0 )
            end,
            spendType = "holy_power",

            talent = "execution_sentence",

            startsCombat = true,
            texture = 613954,

            handler = function ()
                if buff.divine_purpose.up then removeBuff( "divine_purpose" )
                else
                    removeBuff( "fires_of_justice" )
                    removeBuff( "hidden_retribution_t21_4p" )
                end
                applyDebuff( "target", "execution_sentence" )
            end,
        },


        eye_for_an_eye = {
            id = 205191,
            cast = 0,
            cooldown = 60,
            gcd = "spell",

            talent = "eye_for_an_eye",

            startsCombat = false,
            texture = 135986,

            handler = function ()
                applyBuff( "eye_for_an_eye" )
            end,
        },


        final_reckoning = {
            id = 343721,
            cast = 0,
            cooldown = 60,
            gcd = "spell",

            talent = "final_reckoning",

            startsCombat = true,
            texture = 135878,

            toggle = "cooldowns",

            handler = function ()
                applyDebuff( "target", "final_reckoning" )
            end,
        },


        flash_of_light = {
            id = 19750,
            cast = function () return ( 1.5 - ( buff.selfless_healer.stack * 0.5 ) ) * haste end,
            cooldown = 0,
            gcd = "spell",

            spend = 0.22,
            spendType = "mana",

            startsCombat = false,
            texture = 135907,

            handler = function ()
                removeBuff( "selfless_healer" )
            end,
        },


        hammer_of_justice = {
            id = 853,
            cast = 0,
            cooldown = 60,
            gcd = "spell",

            spend = 0.04,
            spendType = "mana",

            startsCombat = true,
            texture = 135963,

            handler = function ()
                applyDebuff( "target", "hammer_of_justice" )
            end,
        },


        hammer_of_reckoning = {
            id = 247675,
            cast = 0,
            cooldown = 60,
            gcd = "spell",

            startsCombat = true,
            -- texture = ???,

            pvptalent = "hammer_of_reckoning",

            usable = function () return buff.reckoning.stack >= 50 end,
            handler = function ()
                removeStack( "reckoning", 50 )
                if talent.crusade.enabled then
                    applyBuff( "crusade", 12 )
                else
                    applyBuff( "avenging_wrath", 6 )
                end
            end,
        },


        hammer_of_wrath = {
            id = 24275,
            cast = 0,
            charges = function () return legendary.vanguards_momentum.enabled and 2 or nil end,
            cooldown = function () return 7.5 * haste end,
            recharge = function () return legendary.vanguards_momentum.enabled and ( 7.5 * haste ) or nil end,
            gcd = "spell",

            spend = -1,
            spendType = "holy_power",

            startsCombat = true,
            texture = 613533,

            usable = function () return target.health_pct < 20 or ( level > 57 and ( buff.avenging_wrath.up or buff.crusade.up ) ) or buff.final_verdict.up or buff.hammer_of_wrath_hallow.up or buff.negative_energy_token_proc.up end,
            handler = function ()
                removeBuff( "final_verdict" )

                if legendary.the_mad_paragon.enabled then
                    if buff.avenging_wrath.up then buff.avenging_wrath.expires = buff.avenging_wrath.expires + 1 end
                    if buff.crusade.up then buff.crusade.expires = buff.crusade.expires + 1 end
                end

                if legendary.vanguards_momentum.enabled then
                    addStack( "vanguards_momentum" )
                end
            end,

            auras = {
                vanguards_momentum = {
                    id = 345046,
                    duration = 10,
                    max_stack = 3
                },

                -- Power: 335069
                negative_energy_token_proc = {
                    id = 345693,
                    duration = 5,
                    max_stack = 1,
                },
            }
        },


        hand_of_hindrance = {
            id = 183218,
            cast = 0,
            cooldown = 30,
            gcd = "spell",

            spend = 0.1,
            spendType = "mana",

            startsCombat = true,
            texture = 1360760,

            handler = function ()
                applyDebuff( "target", "hand_of_hindrance" )
            end,
        },


        hand_of_reckoning = {
            id = 62124,
            cast = 0,
            cooldown = 8,
            gcd = "spell",

            spend = 0.03,
            spendType = "mana",

            startsCombat = true,
            texture = 135984,

            handler = function ()
                applyDebuff( "target", "hand_of_reckoning" )
            end,
        },


        holy_avenger = {
            id = 105809,
            cast = 0,
            cooldown = 180,
            gcd = "off",

            toggle = "cooldowns",
            talent = "holy_avenger",

            startsCombat = true,
            texture = 571555,

            handler = function ()
                applyBuff( "holy_avenger" )
            end,
        },


        judgment = {
            id = 20271,
            cast = 0,
            charges = 1,
            cooldown = function () return 12 * haste end,
            gcd = "spell",

            startsCombat = true,
            texture = 135959,

            handler = function ()
                applyDebuff( "target", "judgment" )
                gain( buff.holy_avenger.up and 3 or 1, "holy_power" )
                if talent.zeal.enabled then applyBuff( "zeal", 20, 3 ) end
                if set_bonus.tier20_2pc > 0 then applyBuff( "sacred_judgment" ) end
                if set_bonus.tier21_4pc > 0 then applyBuff( "hidden_retribution_t21_4p", 15 ) end
                if talent.sacred_judgment.enabled then applyBuff( "sacred_judgment" ) end
                if conduit.virtuous_command.enabled then applyBuff( "virtuous_command" ) end
            end,

            auras = {
                virtuous_command = {
                    id = 339664,
                    duration = 6,
                    max_stack = 1
                }
            }
        },


        justicars_vengeance = {
            id = 215661,
            cast = 0,
            cooldown = 0,
            gcd = "spell",

            spend = function ()
                if buff.divine_purpose.up then return 0 end
                return 5 - ( buff.fires_of_justice.up and 1 or 0 ) - ( buff.hidden_retribution_t21_4p.up and 1 or 0 ) - ( buff.the_magistrates_judgment.up and 1 or 0 )
            end,
            spendType = "holy_power",

            startsCombat = true,
            texture = 135957,

            handler = function ()
                if buff.divine_purpose.up then removeBuff( "divine_purpose" )
                else
                    removeBuff( "fires_of_justice" )
                    removeBuff( "hidden_retribution_t21_4p" )
                end
            end,
        },


        lay_on_hands = {
            id = 633,
            cast = 0,
            cooldown = function () return 600 * ( talent.unbreakable_spirit.enabled and 0.7 or 1 ) end,
            gcd = "off",

            startsCombat = false,
            texture = 135928,

            readyTime = function () return debuff.forbearance.remains end,

            handler = function ()
                gain( health.max, "health" )
                applyDebuff( "player", "forbearance", 30 )

                if talent.liadrins_fury_reborn.enabled then
                    gain( 5, "holy_power" )
                end

                if azerite.empyreal_ward.enabled then applyBuff( "empyreal_ward" ) end
            end,
        },


        rebuke = {
            id = 96231,
            cast = 0,
            cooldown = 15,
            gcd = "off",

            toggle = "interrupts",

            startsCombat = true,
            texture = 523893,

            debuff = "casting",
            readyTime = state.timeToInterrupt,

            handler = function ()
                interrupt()
            end,
        },


        redemption = {
            id = 7328,
            cast = function () return 10 * haste end,
            cooldown = 0,
            gcd = "spell",

            spend = 0.04,
            spendType = "mana",

            startsCombat = true,
            texture = 135955,

            handler = function ()
            end,
        },


        repentance = {
            id = 20066,
            cast = function () return 1.7 * haste end,
            cooldown = 15,
            gcd = "spell",

            spend = 0.06,
            spendType = "mana",

            startsCombat = false,
            texture = 135942,

            handler = function ()
                interrupt()
                applyDebuff( "target", "repentance", 60 )
            end,
        },


        retribution_aura = {
            id = 183435,
            cast = 0,
            cooldown = 0,
            gcd = "spell",

            startsCombat = false,
            texture = 135889,

            nobuff = "paladin_aura",

            handler = function ()
                apply_aura( "retribution_aura" )
            end,
        },


        seraphim = {
            id = 152262,
            cast = 0,
            cooldown = 45,
            gcd = "spell",

            spend = function () return 3 - ( buff.the_magistrates_judgment.up and 1 or 0 ) end,
            spendType = "holy_power",

            talent = "seraphim",

            startsCombat = false,
            texture = 1030103,

            handler = function ()
                applyBuff( "seraphim" )
            end,
        },


        shield_of_the_righteous = {
            id = 53600,
            cast = 0,
            cooldown = 1,
            gcd = "spell",

            spend = function () return 3  - ( buff.the_magistrates_judgment.up and 1 or 0 ) end,
            spendType = "holy_power",

            startsCombat = true,
            texture = 236265,

            usable = function() return false end,
            handler = function ()
                applyBuff( "shield_of_the_righteous" )
                -- TODO: Detect that we're wearing a shield.
                -- Can probably use the same thing for Stormstrike requiring non-daggers, etc.
            end,
        },


        shield_of_vengeance = {
            id = 184662,
            cast = 0,
            cooldown = 120,
            gcd = "spell",

            startsCombat = true,
            texture = 236264,

            usable = function () return incoming_damage_3s > 0.2 * health.max, "incoming damage over 3s is less than 20% of max health" end,
            handler = function ()
                applyBuff( "shield_of_vengeance" )
            end,
        },


        templars_verdict = {
            id = 85256,
            flash = { 85256, 336872 },
            cast = 0,
            cooldown = 0,
            gcd = "spell",

            spend = function ()
                if buff.divine_purpose.up then return 0 end
                return 3 - ( buff.fires_of_justice.up and 1 or 0 ) - ( buff.hidden_retribution_t21_4p.up and 1 or 0 ) - ( buff.the_magistrates_judgment.up and 1 or 0 )
            end,
            spendType = "holy_power",

            startsCombat = true,
            texture = 461860,

            handler = function ()
                removeDebuff( "target", "judgment" )

                if buff.divine_purpose.up then removeBuff( "divine_purpose" )
                else
                    removeBuff( "fires_of_justice" )
                    removeBuff( "hidden_retribution_t21_4p" )
                end
                if buff.vanquishers_hammer.up then removeBuff( "vanquishers_hammer" ) end
                if buff.avenging_wrath_crit.up then removeBuff( "avenging_wrath_crit" ) end
                if talent.righteous_verdict.enabled then applyBuff( "righteous_verdict" ) end
                if talent.divine_judgment.enabled then addStack( "divine_judgment", 15, 1 ) end

                removeStack( "vanquishers_hammer" )
            end,

            copy = { "final_verdict", 336872 }
        },


        vanquishers_hammer = {
            id = 328204,
            cast = 0,
            cooldown = 30,
            gcd = "spell",

            spend = function () return 1 - ( buff.the_magistrates_judgment.up and 1 or 0 ) end,
            spendType = "holy_power",

            startsCombat = true,
            texture = 3578228,

			handler = function ()
				applyBuff( "vanquishers_hammer" )
            end,

            auras = {
                vanquishers_hammer = {
                    id = 328204,
                    duration = 20,
                    max_stack = 1,
                }
            }
        },


        wake_of_ashes = {
            id = 255937,
            cast = 0,
            cooldown = 45,
            gcd = "spell",

            spend = -3,
            spendType = "holy_power",

            startsCombat = true,
            texture = 1112939,

            usable = function ()
                if settings.check_wake_range and not ( target.exists and target.within12 ) then return false, "target is outside of 12 yards" end
                return true
            end,

            handler = function ()
                if target.is_undead or target.is_demon then applyDebuff( "target", "wake_of_ashes" ) end
                if talent.divine_judgment.enabled then addStack( "divine_judgment", 15, 1 ) end
                if conduit.truths_wake.enabled then applyDebuff( "target", "truths_wake" ) end
            end,
        },


        --[[ wartime_ability = {
            id = 264739,
            cast = 0,
            cooldown = 0,
            gcd = "spell",

            startsCombat = true,
            texture = 1518639,

            handler = function ()
            end,
        }, ]]


        word_of_glory = {
            id = 85673,
            cast = 0,
            cooldown = 0,
            gcd = "spell",

            spend = function ()
                if buff.divine_purpose.up then return 0 end
                return 3 - ( buff.fires_of_justice.up and 1 or 0 ) - ( buff.hidden_retribution_t21_4p.up and 1 or 0 ) - ( buff.the_magistrates_judgment.up and 1 or 0 )
            end,
            spendType = "holy_power",

            startsCombat = false,
            texture = 133192,

            handler = function ()
                if buff.divine_purpose.up then removeBuff( "divine_purpose" )
                else
                    removeBuff( "fires_of_justice" )
                    removeBuff( "hidden_retribution_t21_4p" )
                end
                gain( 1.33 * stat.spell_power * 8, "health" )

                if conduit.shielding_words.enabled then applyBuff( "shielding_words" ) end
            end,
        },
    } )


    spec:RegisterOptions( {
        enabled = true,

        aoe = 3,

        nameplates = true,
        nameplateRange = 8,

        damage = true,
        damageExpiration = 8,

        potion = "spectral_strength",

        package = "Retribution",
    } )


    spec:RegisterSetting( "check_wake_range", false, {
        name = "Check |T1112939:0|t Wake of Ashes Range",
        desc = "If checked, when your target is outside of |T1112939:0|t Wake of Ashes' range, it will not be recommended.",
        type = "toggle",
        width = 1.5
    } )


    spec:RegisterPack( "Retribution", 20220911, [[Hekili:T3ZIUnsoY9TyCaAS2BIoRxESVyzGK9oeSdUmj48fKaee1QTAkP(CRU11pShhyOV9uf7xKSzXMDl5zUn7Ify2rnlwSy9MfFmlhV8VS8bp3u2YVm5QjtU62XJhnE8KpT8H0xpWw(Wb31p5Uf(lHU7H)8pZsJ9Fml1pkeB71GixpedjrzXRH2x(WJz(bP)u4Yh1H2RNpdG9aB9YV8PRw(WoFppwoOSK1sy)4Q)D3axp)WJF(b2Hu2(hzXhxnE8hpUcr4XpF8Z)4o3WTSKF)Xp)pCC1pfMY2gdd4XvHSxoU6qSFuSF6RhxLCiWp94QnXr7pU6b)9)4iEh(xDFcG9bwS7HD(qlVef)0XvpYstXb6f)0DhxfLUd)Xp(hsoUknA72aMh8XnBYXWFik8daIFXnbh19mp)S9)Ua34TSIUGZcVx9d3cKdWgHVKfgWsG)VF6hG)0fgVi8NB83UlTGSIIHU769xZss3Zct5JCj1LtvCCNSl6fa9jSdU4So41rG8ioAJFaif(n)MJR0ZlXwO4NyB18u8xDMVw0PtK3wGLZp)TK86npgztURrEAYOdXS1r7F0nDXHioxUzl)2f)UhrccirNOnojz73dZ5wHZnlnBVf47f)WuBWxci0aMKw42aWTBDS7M0p6Vzbygh8OFO3OdaRjlG5WIZoGD6T3QA65Oa3uqnZjjk4zG7PhVUXRDdzoPrXXamiUtDdG)2On(HUboaKpffcu1iwOlqREdkAoPqPP876XEYoFwGho3akylZnCnRud(p(v26SuuzI9mlg0tt93dsBqBde5Rb6b0oqDJND9dWryu1iSiM9ygO4w(ByCE2n2hb6JO3VfBIb62171p(SBqgBXL7IcE15q0lS47xmBaoo3DZBVj(1PdUe)89lGVdU9ccCsr930KrE(p7d8NeGG2F)IjdwhbZexGb80RWqgoCi8LOapqbCKlohrr5lGw4UrXS9U(Hj3VDThFmbESZUdBxC1GlVqHj(2BpMbwuv80SddbGID99CyOOBKRNxYi2x9tstE7n1VNDO538dVF2vis4iwHYWoup7xm)T3QMd7CrvFUsR4KORCfAzdlrw2WPV1XzjUESrijuZpl)AjJC8vf8PYgssbVjGWtG(jKbJ58c9A2c9wvNxCKRzyJ8yB8x7NcsY8zzJ(55NWnkgoG7rZPep3mGMnE3CrM2AxaS8F6eaI9CMxjHM0oOaFgmdoaDaii0S(u1NU7wTAztroBbJLXnPr6ib(jdm2RfMnBRK7E3Tg5kV9MEX2G2KA3DBd2VTSn8ZpZ(ycezED6IXi7ZJXv90mnq2vrRQus2H2hXTSqWShMRjIbTQK0fbTqsGYuwYMi7WGM2il4MoqiwzgYDtMRzebknaHkX5VM5TDFrubzrKcaGlG3EZA9lqR5tZ1P2PNy24d(7dII84AXNety4Glivvjg8toS7h5b)r4C83JjhbzOGQuvFDBq0JUbsFsCOOdJlsNAc0MB0toFfC7zW2C(evJOXe6mMsGIco1eOOGtnbkYXvjbkr4Ysyo(q(0fwDGkua2fiFdhqdlj1Xn(rFYrrU3XfJ36OGa3d8rFdmvIzjitppMla8HuxE4bu)u2WJIjkpmUHrE()VmphiGtaBDUpI27w9ukXFRFWzW1HIxJRSHkyHBIGLAgNaoYZcD2cPxci97eXaqcikfdk783YGevY2dm1N9xFoiinowNAfvbjnf)YowWECy5Pw4So(vaXNdzMgQYoTop34N2hbod8G4yophf7c56867dfzN0BV7A3hJbpG7ySuN9zj(R)EsoBCZcsFfm(ZqVs7zUjGLp3WVWzBXy1GsobvfpmPzmsi4FpjHfytFsEkl4j0a8fBDkg7VhMwESVAd07z7JIFfDdEWL7Rj0kVtjWI0zoaxl1zxu0tw1f3GND3c(b3aIEqX0D)Ha)n(25RElSEKuNOy8hHGaY5aZn2k(hW28sw7g7a2OPq2OHe5ii3lEQkGwgKcRNZo3qpqeSgIoV5JRFDn4(PifQ8SkVWlIRUaXI26ghhLYgL6V(jlLxPrmNNczqoRhIJ27Nyf9b6DWW4SnZ3dZsOWnOn9e5fjO8EdwLLymvxmd5nS6GEKG4mJu)3kNsR3HaJy2dMPH84Q20pqwNUd8D4Yne83Fa6In9Bh2XY8dsEXnEF9KSHlNbxOyOBZiSfR0hpVFNhD92EIbIUN7sRkJoILbptCP(QlVEMvcc6eN6s65dnpujNoZq)aiJoofRP4qZ1xCiCnlzHmiTMTGzkm937UfwHdQPxVuOHY9DYG6U8SB42m3yVeN9riOz7hqvrIIVZXeNMzX1R3v8RLsVfIf4OUSsTxYJQAovQgCfHSPGdJ8mByz5CmcPaeipe8ngee9IEieNI8Askv)S6r6oGbtQZjhnEWLuA(luRReOFsKEabVrH9sPx9RfD8DUOJ1shX64SOQcc6B)3svAgqS6dQQXjYk9iTxuWNsR(rglc0GljAQuXcKwJ27(12MW0lMFy1ORTavdOBuHei5qf0skSIxsyahC)TSCoMtUmLe0xGaY8kaaqRWE52008Y2zL)aWPQ96wq4WAZJcD519405uMfuZhqp6dOfHK8QhHmf4mlCFWkwY66OqVmFephYI3YthcnEPhxr(7urlrGDtp0Iva8IM68dK8YnEq7HhvIospYTyr2tfRoXJLyz9Lfr2pfNE0mI8GsX8ePf21lv4K3ipA0bFJToUibAvWk2VGfLbfuD8DcBIYDlqtZPTd49LaiKrtFlFzJXKg2QHLAdhqYrjKJaIf8pwVbeMBVEIsigA3mGmWuthN2K48DI5nRskn9UxLLUqoe09xrHh7SPCJPrulXosyPopgfMLalLMfp5gNzhwtJSoB4x31oA5tYjmi9LT9ZD8lNeBzBJGvidmseb5yZna8ip6tZf9rFhUpnsZU6ejvzeIPs(dsDdsN1YEvdxfFrQDdk(IEGi85y1MlM7bO7MU93M0AXjnGnpugIcTz2X1ozx1Nr)VNnpQMeler2QemlKpjcGVM1Uj89eO4WiqNuhM89L1ERYNhpZI98xNwn7IXflYIYskBzOX8eNu4rMT)WRXm3WCXlVCsAY0kFnvfiaY57quICLMQMMQQbTTuXXMkk045N0bN48fkxi8SXCV7YAy5Rxv7zDGNJFZL8QvH9YZtoadBUhHk7868ohcxuNOjRTUGDLyajKFwD(BU8IsB6rBko0xV9w(SN(q50ZtLJe3uegKpwrgcEvkSzBM3eFLtx2y3Iiz8NjVXC8CT9GoBG4A1M3IHxDXgl9(yt85MzxOx6YsuKUAqPGa(e01uzsMGRbhIMfycnwm)7G2DpQE8DfHP56Rsay96gu9EDZq9go4XIia3KOIyKszQ8T1u4g7b9Ajb9S))KU(nwcxhyb)ItxxmDZ6ZZ3IoV49l1vwzXfEnCGyAGvv3RM0vMq6ilYLYlw(WS0xFmkl0ZHVFFKBKKHssRDhuUHGGmwBG8Aj65GNU)Tr8LiuKcgMB2Uxfe4I7SuLA3eXuIKg2EujHbTLpnTZRHeuHqAHnPbTvD98Uvo8tXlv6Uu(wmuNPw9dm5Qw8GRO00Ek)TM)P514yk4LKO6By9WnROkmqlUsPC(2wDMoQJmPnDKATXkcOXUlpxW6TyB7o9G5AeGTRY0)OM60xAvfS7Uf6u0dC3KTk2fXGz7EmruA0UyKyxiGoqN2qtwWmVmxxz0oMBai3oSofSLkxYB7NdfQQ5qkEfkxfNtj(bu8zCVGPq6VCkyCxeV9ueyhtMakQ9JJKcw(aSKi88nwCvCVzY4Lp8IBm67jz5d)N)t)5V8tF5F53FC1Xv)f8sY5V)qumEXoXRk3hQr7hoUkMbP3fJ3TUKi8s15MLgT3LFz7wNFXrhD8Z)jqF64Qjac)XOqyO5n)HcVI)xFi)Uww97Y75h89lN81HK9VoKxfke(KiwglGLPNfSmVhZLPc9)6Zcv8PEtfh)Clczy5s4zp(9xcBs201(3hPYe74hvx10UXruLZv31MkAQ(luZQEIdxG2)J)B)PkK16uS0HyhnR7HqtL0Yr0S(npph4qpb1h1jX(pgTh(pctYoGSzefLN6u(9o2hVS6)3WFT5DV5)5F84ka14DvUSce1y92tKSMCRvKvJJ8TjIA6n9GOMjA6RIa79ikgJy24Eqhskq93hwRgyvjj0ndStDkP2F75SJne91gQyYz03UQLTn9)6t0y(A7KRIN7PUjA7dt9C6HsT)2RAm5DpzMUIflftf7IF3Kt9XeCQbLxRNB6dmn(QEqpsiOpwtLzo(t7lJB8P6ag4sHq(1Yha24UO4LpGV)llFG)D85aQk7c4hFH)edvG6L)ZqJX416W3fFRG0Te4JRE7TJRuwg8Xvdu(gVYdhxTa5qfDH)yVmO49EPSkkhxDhy7nhO115lhk)MVVmfwpejLz8APFC19WOojFqVa0T0wSR8MBwWlO3aZCU(MZoutNkJksWtjj4ll4oNhU5qoaWuRq1qtrYkPIkYT60WJe6mAol1DDVeJ5em59uVEGfVx7c4vTdsawEt5x(WybkV6Y4lcB(9NhbeMpZnX4THpLpRSOQJC115tkLbkQYGQZybvznxpFKAVgP2syESXfOxCMaq)jkOZVg9kqFdf05xMEfOVLKs4xPEfOhFLcBgl3YYhOVBy142amiIv9bv2n6BCVOm(IcJfP7EFUeTPRgu(Kt3gqostQEFY7KMfiWHw10VCgOCR8FhDVQXR6vLuTkvGuSQpGskw)n4)7eHtqmi9RAZxs)(Kx6)3X5GHyBtRMmgOmCcDnXeI(9c47ZeQ2cYaLHtOprmH0)ud89zYuRQrqv4e5gIjIMxOGV3ZcDKeofULykO9vnqX5Ar0ZsktkKzJ5H1wd6hzmTp9HzuFlee0NuBbrIAiLCKi94iieOw6Zy3179V(Psqi0w93WoQgiOqS08vtqqnstJiQu9qxmfKFjfeMeknGOq1jzbkOEzfeqgjiiAvDvvWD0(MliWP03oIqvxf5iS5tXqnY00gIivt1Cer(6maA6Ippd4QHeYhIUtIMhKpMdCcs1WRiGSAb94lFqVIFS2NUbHKK03oIqQ8QiFWg0LwL5x3H2T4RcxqpQiTQ3It3lar98qBRiY0BfQ7zHqiXhDTIiJktPMVwe6yFAcaKV4nfxNLePgSIebv6oQpOeN7aq3lebQLd7aF9pZMRaRY5EOaOkFgQKpoxPYeY0kn6)AThAXczqQs1h17bFUEUw9OyWhBv3AsZ26TCphnZ4ds(dRkUA1CcrfQPCOUSeW7RaS9JVuDkad1J7jCCB6E(vJIbvjyOEYBKs0OagPt6OiomE6p55rvv4ePAc04fTTSSr2quKN4jo)8kUUvPavw)GlvvJnulvpfrAT8uWrzUYgoQZUsCr)IhDsrAbbKUYGcVXeLS2bYKZDvAbTyosLCzEpP9IKpQ6nOBnM0ezrJOkdFMtx5X2n3UXoZTfvqsFIFenMuo)C8z5qznFdEL3U2RIkBk4SWGiptG6tAQSTuxkXAPGNO0RZumtnP7iYJxuzvu7jq)dmYPX1fw6KSNHLyYcpuCwnwwwy96K0WhVAflmv1SiijGeMqkjLhoE8VfKX(v1VFv9d1jCkwbDXnMGhlPpQssEorAwwGQlZTX6C6kKcZu7ZuCS(aY2fWL4u6krJ1YNYBCIGsxoFH8sMqxG)B4F3K87oEO3A5u5n7HhAHi1w1JYy(U1vGG69RlT9964CzmaZIBnAQmvu(zXoSmW(ny5wR4XsjqqQ2mWgTM8XKuKBPCsAxTrzL6czQLvMEnIYNxKx1cWWM)cLlvSclOlS1N5PasvywJiP(OMMhPR6u41iwxXo4QjwxDPvAztVMsbT2n9Agf0A30R5KuIUn9IweE(2Q0QmkQ3PtnsjH0VBxLNiAQqI)shuzC8K26qDBDPeJjvsJW45iqFCYlRuXfVLa6cSoR0YKdTMBbNqijLBcNL62vNgmDzLjvshYllxNx)4GUSZ0gwlZnIX4vVGF6snOE(qEz7ud6wKfcQ1U71yL0(0C574EnNiwodLKH0fkuVct9cj1(c)ue(P18nKsEOrIncz1lDNRmhVvpzEHE96V155keKMkYFxt(I(FUlSp3Sj6t6Rn9FnQ92Lh9CHHRvLe(X3OnDfbG0svc6scxXtZHsmQZOUuUX8g6sv6u9PwSadbkv8umrh35YgUMBKPTOLqR3(N61g(d5e0PPRpPB666TanxsV5kEefwnCxvPTkx42u26QjGLw6wzkB2kWAJU(7zMUO46R(HTLI)o5kXBFMd01ZvZLQKp8QgotfZmv2ObhGgNaRwCHO3aFSu26QrMLt)TXXGIo8xB0UXthzJBHzHJeXYny7oSu9Xg3ktj9j7LRnoRusSD1RpyBlDL79vGmeVmGPAoytIArYMjgUuNfHkgHNK1MHrk8rRZ190(56wFA79btI9r96G2iGHaBuMLW5Ku7JyhK80bdBk5nitLwBLkPQyXjDOmvwMMYAQL2kh5BvktETA1ZknlvR9IfAsFwmZ3lftmjp4XZ5V4pA3nVgVDEn2zrJgsvAEuw7gth)c5fuw)66jw7oHh2lZRn0MqDDj)Y3Lq2f68LW(UM3sJXQvXzZCv6rsGZiscSOKMCNh2KKyJu8WojkK18S(jw0uZWrilgsLr14C34nln5CIyG2LAtzoUMltWVW3PG8XSX7uvEpZ5KM3gHtDNekLwnn4mxgfDVoHsE(0(gfwoNLy1Ap7Ngf)LrPN(U6KPCuUUFDBwJKWVVUaLw4RcbZ0ckh0DsQrUuTRrwU)ssAKgE94eukpZ2tuIdB6JrzHTmzBgOEWH7LnVqEosvLwlHlbHONFb7OkVPkf5UhHaOIZOT(vCDEZLc9NvolUPFD7ATkOZ6McQLJvp0r)7pVaQ8zB6ZzHjBZa1do8VC8cu7cq9HBnF1KsBOS62)wFttvwTQvvsQ2Np1UdAyBigiUTIM2S)Tf)7EKvb6RwDRf(JgkrJeBV)ataOHm7tLlK2bDXnIqwOiT15A2)qzO76EHrlmKzdTiQekn0fsBbR6wbl5R68jdStnjFjA2qDdStvYqPVP3kjQknFP18UbAlkOSZYkH8qZf91y5Z(7NT8I6c(zV5MDhL77Kl9BdXQH6731QTtFCm6YofmPd7uW0ouJZzwxJZXZTUgNYh)QoEKuoZPbHIiLG2T3PVLvOZeb2Nk71gBR1AR9owyn9f8QN5JOlswNZ8QpUyOlqhFyeo1igJOBSKr2CLDODi0Jme0DOE6vCVo6FSJbMme2WoVJM2Ay5fg)RBQhDueZHiTW5TTlfxX74P75IWhe5lFI9UfKJr3sCxAFiQQmZiJpNACdXFhdI(nmuyB0)zjAgLoH1z8K)Fl))(]] )


end
