-- *********************************************** Start of Class Functions*******************************************
-- These are the class functions that define the Stat weights and reforge orders for each class.
-- This should eventually be its own seperate file for ease of use.  
-- If there is an issue with your class it is most likely in here.
-- if there is a "TODO" before the Class/Spec it means there is work to be done or it in not finished.

--This is now its own separate file in an attempt to make the addon more modular

-- There isn't really a "spirit" combat rating, but it will simplify
-- some things if we pretend there is one
local CR_SPIRIT = 99

-- and likewise there isn't an EP combat rating
local CR_EP = 100


-- Death Knight 0000000000000000000000000000000000000000000000000000000000000000000000000000000000
--updated 9-7 for 5.04
function Reforgenator:TwoHandFrostDKModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_HIT_RATING_SHORT"] = 2.26,
        ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 1.75,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 1.40,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 1.37,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 1.34,
    }

    model.notes = 'http://www.noxxic.com/wow/pve/death-knight/frost/dps-gear-reforging'

    model.reforgeOrder = 
	{
        {
            rating = CR_HIT_MELEE,
            cap = "MeleeHitCap"
        },
        {
            rating = CR_EXPERTISE,
            cap = "ExpertiseHardCap"
        },
        {
            rating = CR_HASTE_MELEE,
            cap = "MaximumPossible"
        },
        {
            rating = CR_CRIT_MELEE,
            cap = "MaximumPossible"
        },
		{
            rating = CR_MASTERY,
            cap = "MaximumPossible"
        },
    }

    return model
end
--updated 9-7 for 5.04

function Reforgenator:DWFrostDKModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_HIT_RATING_SHORT"] = 2.14,
        ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 2.10,
		["ITEM_MOD_MASTERY_RATING_SHORT"] = 1.51,
		["ITEM_MOD_HASTE_RATING_SHORT"] = 1.33,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 0.50,
    }

    model.notes = 'http://www.noxxic.com/wow/pve/death-knight/frost/dps-gear-reforging'

    model.reforgeOrder = 
	{
        {
            rating = CR_HIT_MELEE,
            cap = "MeleeHitCap"
        },
        {
            rating = CR_EXPERTISE,
            cap = "ExpertiseHardCap"
        },
        {
            rating = CR_MASTERY,
            cap = "MaximumPossible"
        },
		{
            rating = CR_HASTE_MELEE,
            cap = "MaximumPossible"
        },
        {
            rating = CR_CRIT_MELEE,
            cap = "MaximumPossible"
        },
    }

    return model
end
--updated 9-7 for 5.04

--[[  Unknown If needed so keeping

function Reforgenator:MasterfrostDKModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 2.32,
        ["ITEM_MOD_HIT_RATING_SHORT"] = 2.22,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 2.15,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 2.06,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 1.73,
    }

    model.notes = 'http://elitistjerks.com/f72/t125291-frost_dps_winter_discontent_4_3_a/'

    model.reforgeOrder = 
	{
        {
            rating = CR_EXPERTISE,
            cap = "ExpertiseSoftCap"
        },
        {
            rating = CR_HIT_SPELL,
            cap = "SpellHitCap"
        },
        {
            rating = CR_MASTERY,
            cap = "MaximumPossible"
        },
        {
            rating = CR_HASTE_MELEE,
            cap = "MaximumPossible"
        },
        {
            rating = CR_CRIT_MELEE,
            cap = "MaximumPossible"
        },
    }

    return model
end
]]
--updated 9-7 for 5.04

function Reforgenator:BloodDKModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 1.2,
        ["ITEM_MOD_DODGE_RATING_SHORT"] = 1,
        ["ITEM_MOD_PARRY_RATING_SHORT"] = 1,
        ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 0.4,
        ["ITEM_MOD_HIT_RATING_SHORT"] = 0.2,
    }

    model.notes = 'http://www.noxxic.com/wow/pve/death-knight/blood'

    model.reforgeOrder = 
	{
        {
            rating = CR_MASTERY,
            cap = "MaximumPossible"
		},
		--[[ --just place holders until i come back to work on it again.
		{
            rating = CR_HIT_MELEE,
            cap = "MeleeHitCap"
        },
        {
            rating = CR_HASTE_MELEE,
            cap = "MaximumPossible"
        },
        {
            rating = CR_CRIT_MELEE,
            cap = "MaximumPossible"
        },
        {
            rating = CR_MASTERY,
            cap = "MaximumPossible"
        },
        {
            rating = CR_EXPERTISE,
            cap = "ExpertiseSoftCap"
        },
		]]
    }

    return model
end

function Reforgenator:UnholyDKModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_HIT_RATING_SHORT"] = 3.0,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 1.89,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 1.85,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 1.55,
        ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 0.99,
    }

    model.notes = 'http://elitistjerks.com/f72/t125292-unholy_dps_my_friend_misery_4_3_0_a/'

    model.reforgeOrder = 
	{
        {
            rating = CR_HIT_MELEE,
            cap = "MeleeHitCap"
        },
        {
            rating = CR_HASTE_MELEE,
            cap = "MaximumPossible"
        },
        {
            rating = CR_CRIT_MELEE,
            cap = "MaximumPossible"
        },
        {
            rating = CR_MASTERY,
            cap = "MaximumPossible"
        },
        {
            rating = CR_EXPERTISE,
            cap = "ExpertiseSoftCap"
        },
    }

    return model
end

-- End Death Knight 0000000000000000000000000000000000000000000000000000000000000000000000000000000000
 
-- Druid  111111111111111111111111111111111111111111111111111111111111111111111

-- TODO
function Reforgenator:GuardianModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_DODGE_RATING_SHORT"] = 0.98,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 0.42,
        ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 0.25,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 0.22,
        ["ITEM_MOD_HIT_RATING_SHORT"] = 0.13,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 0.02,
    }

    model.notes = 'http://elitistjerks.com/f73/t127444-feral_bear_cataclysm_4_3_dragon_soul/'

    model.reforgeOrder = 
	{
        {
            rating = CR_DODGE,
            cap = "MaximumPossible"
        },
        {
            rating = CR_MASTERY,
            cap = "MaximumPossible"
        },
    }

    return model
end

function Reforgenator:BalanceModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_SPIRIT_SHORT"] = 2.4,
        ["ITEM_MOD_HIT_RATING_SHORT"] = 2.4,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 2.15,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 1.45,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 0.87,
    }

    model.notes = 'http://elitistjerks.com/f73/t110353-balance_cataclysm_4_3_dragon_soul/'

    model.reforgeOrder = {
        {
            rating = CR_HIT_SPELL,
            cap = "SpellHitCap"
        },
        {
            rating = CR_HASTE_SPELL,
            cap = "MaximumPossible",
        },
        {
            rating = CR_MASTERY,
            cap = "MaximumPossible"
        },
        {
            rating = CR_CRIT_SPELL,
            cap = "MaximumPossible",
        },
    }

    return model
end

function Reforgenator:FeralModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 1.291,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 1.291,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 1.291,
        ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 1.24,
        ["ITEM_MOD_HIT_RATING_SHORT"] = 1.24,
    }

    model.notes = 'http://elitistjerks.com/f73/t127445-feral_cat_cataclysm_4_3_dragon_soul/'

    model.reforgeOrder = 
	{
		{
            rating = CR_HIT_MELEE,
            cap = "MeleeHitCap"
        },

		{
            rating = CR_HASTE_MELEE,
            cap = "MaximumPossible"
        },
		{
            rating = CR_CRIT_MELEE,
            cap = "MaximumPossible"
        },
		{
            rating = CR_MASTERY,
            cap = "MaximumPossible"
        },
		{
            rating = CR_EXPERTISE,
            cap = "ExpertiseSoftCap"
        },
    }

    return model
end

function Reforgenator:RestoDruidModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_SPIRIT_SHORT"] = 0.75,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 0.65,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 0.60,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 0.50,
    }

    model.notes = 'http://elitistjerks.com/f73/t110354-resto_cataclysm_4_3_dragon_soul/'

    model.reforgeOrder = 
	{
        {
            rating = CR_MASTERY,
            cap = "Maintain",
        },
        {
            rating = CR_HASTE_SPELL,
            cap = "Fixed",
            userdata = { 916, 2005 },
        },
        {
            rating = CR_SPIRIT,
            cap = "MaximumPossible",
        },
        {
            rating = CR_MASTERY,
            cap = "MaximumPossible"
        },
    }

    return model
end

-- End Druid 111111111111111111111111111111111111111111111111111111111111111111111

--Pally  222222222222222222222222222222222222222222222222222222222222222222222222

function Reforgenator:ProtPallyModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_DODGE_RATING_SHORT"] = 1.0,
        ["ITEM_MOD_PARRY_RATING_SHORT"] = 1.0,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 1.0,
        ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 0.04,
        ["ITEM_MOD_HIT_RATING_SHORT"] = 0.02,
    }

    model.notes = 'http://elitistjerks.com/f76/t126438-prot_4_3_send_me_my_way/'

    model.reforgeOrder = 
	{
        {
            rating = CR_MASTERY,
            cap = "MaximumPossible"
        },
    }

    return model
end

function Reforgenator:RetPallyModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_HIT_RATING_SHORT"] = 1.77,
        ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 1.30,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 1.13,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 0.98,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 0.79,
    }

    model.notes = 'http://www.noxxic.com/pve/paladin/retribution/stat-priority-and-reforging-strats'

    model.reforgeOrder = 
	{
        {
            rating = CR_HIT_MELEE,
            cap = "MeleeHitCap"
        },
        {
            rating = CR_EXPERTISE,
            cap = "ExpertiseSoftCap"
        },
        {
            rating = CR_MASTERY,
            cap = "MaximumPossible"
        },
        {
            rating = CR_CRIT_MELEE,
            cap = "MaximumPossible"
        },
        {
            rating = CR_HASTE_MELEE,
            cap = "MaximumPossible"
        },
    }

    return model
end

-- TODO
function Reforgenator:HolyPallyModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_SPIRIT_SHORT"] = 0.75,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 0.40,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 0.35,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 0.30,
    }

    model.notes = 'http://elitistjerks.com/f76/t110847-%5Bholy%5Dcataclysm_holy_compendium/ http://www.bandagespec.com/2011/02/on-haste-crit-and-other-secondary-stats.html'

    model.reforgeOrder = 
	{
        {
            rating = CR_SPIRIT,
            cap = "MaximumPossible"
        },
        {
            rating = CR_HASTE_SPELL,
            cap = "MaximumPossible"
        },
        {
            rating = CR_MASTERY,
            cap = "MaximumPossible"
        },
	{
	    rating = CR_CRIT_SPELL,
            cap = "MaximumPossible"
	},
    }

    return model
end


-- End Pally 222222222222222222222222222222222222222222222222222222222222222222222222

--Hunter  3333333333333333333333333333333333333333333333333333333333333333333333333333333333

-- updated 9/8  for 5.04
function Reforgenator:BeastMasterHunterModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
	    ["ITEM_MOD_HIT_RATING_SHORT"] = 1.77,
        ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 1.30,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 0.99,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 0.79,
		["ITEM_MOD_MASTERY_RATING_SHORT"] = 0.55,

    }

    model.notes = 'http://www.noxxic.com/wow/pve/hunter/beast-mastery/dps-gear-reforging'

    model.reforgeOrder = 
	{
        {
            rating = CR_HIT_RANGED,
            cap = "RangedHitCap"
        },
		{
            rating = CR_EXPERTISE,
            cap = "ExpertiseHardCap"
        },
        {
            rating = CR_CRIT_RANGED,
            cap = "MaximumPossible"
        },
        {
            rating = CR_HASTE_RANGED,
            cap = "MaximumPossible"
        },
        {
            rating = CR_MASTERY,
            cap = "MaximumPossible"
        },
    }

    return model
end

-- updated for 5.05
function Reforgenator:MarksmanshipHunterModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
		["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 3.49,
        ["ITEM_MOD_HIT_RATING_SHORT"] = 3.49,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 2.65,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 1.61,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 1.38,
    }

    model.notes = 'http://www.noxxic.com/wow/pve/hunter/marksmanship/dps-gear-reforging'

    model.reforgeOrder = 
	{
		{
            rating = CR_EXPERTISE,
            cap = "ExpertiseSoftCap"
        },
        {
            rating = CR_HIT_RANGED,
            cap = "RangedHitCap"
        },
        {
            rating = CR_CRIT_RANGED,
            cap = "MaximumPossible"
        },
        {
            rating = CR_HASTE_RANGED,
            cap = "MaximumPossible"
        },
        {
            rating = CR_MASTERY,
            cap = "MaximumPossible"
        },
    }

    return model
end

-- updated for 5.04
function Reforgenator:SurvivalHunterModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
		["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 3.19,
		["ITEM_MOD_HIT_RATING_SHORT"] = 3.19,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 1.37,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 1.33,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 1.27,
    }

    model.notes = 'http://www.noxxic.com/wow/pve/hunter/survival/dps-gear-reforging'

    model.reforgeOrder = 
	{
        {
            rating = CR_HIT_RANGED,
            cap = "RangedHitCap"
        },
        {
            rating = CR_EXPERTISE,
            cap = "ExpertiseSoftCap"
        },
		{
            rating = CR_CRIT_RANGED,
            cap = "MaximumPossible"
        },
        {
            rating = CR_HASTE_RANGED,
            cap = "MaximumPossible"
        },
        {
            rating = CR_MASTERY,
            cap = "MaximumPossible"
        },
    }

    return model
end

-- End Hunter 3333333333333333333333333333333333333333333333333333333333333333333333333333333333

--Warrior  44444444444444444444444444444444444444444444444444444444444444444444444444444444

--Fix this whole class ************************<---<---<---<---<---<---<---<---<---<---<---<---<---<---<---<---<---<---<---<--- 

function Reforgenator:FuryModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 2.47,
        ["ITEM_MOD_HIT_RATING_SHORT"] = 2.47,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 1.98,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 1.57,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 1.37,
    }

    model.notes = 'http://www.noxxic.com/wow/pve/warrior/fury/dps-gear-reforging'

    model.reforgeOrder = 
	{
        {
            rating = CR_EXPERTISE,
            cap = "ExpertiseSoftCap"
        },
		{
            rating = CR_HIT_MELEE,
            cap = "MeleeHitCap"
        },
        {
            rating = CR_CRIT_MELEE,
            cap = "MaximumPossible"
        },
        {
            rating = CR_HIT_MELEE,
            cap = "DWHitCap"
        },
        {
            rating = CR_MASTERY,
            cap = "MaximumPossible"
        },
        {
            rating = CR_HASTE_MELEE,
            cap = "MaximumPossible"
        },
    }

    return model
end

function Reforgenator:SMFuryModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_HIT_RATING_SHORT"] = 3.2,
        ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 2.29,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 2.02,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 1.33,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 1.24,
    }

    model.notes = 'http://elitistjerks.com/f81/t110350-cataclysm_warrior_faq_4_2_read_while_patching_before_posting/'

    model.reforgeOrder = 
	{
        {
            rating = CR_HIT_MELEE,
            cap = "MeleeHitCap"
        },
        {
            rating = CR_EXPERTISE,
            cap = "ExpertiseSoftCap"
        },
        {
            rating = CR_CRIT_MELEE,
            cap = "MaximumPossible"
        },
        {
            rating = CR_HIT_MELEE,
            cap = "DWHitCap"
        },
        {
            rating = CR_HASTE_MELEE,
            cap = "MaximumPossible"
        },
        {
            rating = CR_MASTERY,
            cap = "MaximumPossible"
        },
    }

    return model
end

--TODO  Needs fixing Outdated ***************************************************************** <---<---<---<---<---<---

function Reforgenator:ArmsModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_HIT_RATING_SHORT"] = 2,
        ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 1.46,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 1.34,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 0.9,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 0.8,
    }

    model.notes = 'http://www.noxxic.com/pve/warrior/arms/stat-priority-and-reforging-strats'

    model.reforgeOrder = 
	{
        {
            rating = CR_HIT_MELEE,
            cap = "MeleeHitCap",
        },
        {
            rating = CR_EXPERTISE,
            cap = "ExpertiseSoftCap",
        },
        {
            rating = CR_CRIT_MELEE,
            cap = "MaximumPossible",
        },
        {
            rating = CR_MASTERY,
            cap = "MaximumPossible",
        },
        {
            rating = CR_HASTE_MELEE,
            cap = "MaximumPossible",
        },
    }

    return model
end

function Reforgenator:ProtWarriorModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_PARRY_RATING_SHORT"] = 1.03,
        ["ITEM_MOD_DODGE_RATING_SHORT"] = 1.00,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 1.00,
        ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 0.04,
        ["ITEM_MOD_HIT_RATING_SHORT"] = 0.02,
    }
    
    model.notes = 'http://elitistjerks.com/f81/t110350-cataclysm_warrior_faq_4_2_read_while_patching_before_posting/'

    model.reforgeOrder = 
	{
        {
            rating = CR_MASTERY,
            cap = "MaximumPossible"
        },
    }

    return model
end

-- end Earrior 44444444444444444444444444444444444444444444444444444444444444444444444444444444

--Rogue 55555555555555555555555555555555555555555555555555555555555555555555555555555555555

function Reforgenator:CombatRogueModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_HIT_RATING_SHORT"] = 2.46,
        ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 2.13,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 1.87,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 1.51,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 1.18,
    }

    model.notes = 'http://www.noxxic.com/wow/pve/rogue/combat/dps-gear-reforging'
-- Agility > Melee Hit (7.5%) >= Expertise (7.5%) > Haste >= Mastery > Crit
    model.reforgeOrder = 
	{
        {
            rating = CR_HIT_MELEE,
            cap = "MeleeHitCap"
        },
		{
            rating = CR_EXPERTISE,
            cap = "ExpertiseSoftCap"
        },
        {
            rating = CR_HASTE_MELEE,
            cap = "MaximumPossible"
        },
        {
            rating = CR_MASTERY,
            cap = "MaximumPossible",
        },
        {
            rating = CR_CRIT_MELEE,
            cap = "MaximumPossible"
        },
    }

    return model
end

function Reforgenator:AssassinationRogueModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_HIT_RATING_SHORT"] = 1.75,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 1.30,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 1.20,
        ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 1.1,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 0.9,
    }

    model.notes = 'http://elitistjerks.com/f78/t110134-assassination_guide_cata_12_01_2011_a/'

    model.reforgeOrder = 
	{
        {
            rating = CR_HIT_SPELL,
            cap = "SpellHitCap"
        },
        {
            rating = CR_MASTERY,
            cap = "MaximumPossible"
        },
        {
            rating = CR_HASTE_MELEE,
            cap = "MaximumPossible"
        },
        {
            rating = CR_EXPERTISE,
            cap = "ExpertiseSoftCap"
        },
        {
            rating = CR_HIT_MELEE,
            cap = "DWHitCap"
        },
        {
            rating = CR_CRIT_MELEE,
            cap = "MaximumPossible"
        },
    }

    return model
end

-- TODO
function Reforgenator:SubtletyRogueModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_HIT_RATING_SHORT"] = 1.40,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 1.35,
        ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 1.15,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 1.1,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 0.9,
    }

    model.notes = 'http://elitistjerks.com/f78/t119013-cataclysm_subtlety_compendium/'

    model.reforgeOrder = 
	{
        {
            rating = CR_HIT_MELEE,
            cap = "MeleeHitCap"
        },
        {
            rating = CR_HASTE_MELEE,
            cap = "MaximumPossible"
        },
        {
            rating = CR_EXPERTISE,
            cap = "ExpertiseSoftCap"
        },
        {
            rating = CR_CRIT_MELEE,
            cap = "MaximumPossible"
        },
        {
            rating = CR_HIT_SPELL,
            cap = "SpellHitCap"
        },
        {
            rating = CR_MASTERY,
            cap = "MaximumPossible"
        },
        {
            rating = CR_HIT_MELEE,
            cap = "DWHitCap"
        },
    }

    return model
end

-- End Rogue  55555555555555555555555555555555555555555555555555555555555555555555555555555555555

--updated 9/8 for 5.04
function Reforgenator:AffWarlockModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_HIT_RATING_SHORT"] = 2.78,
		["ITEM_MOD_MASTERY_RATING_SHORT"] = 2.32,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 1.79,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 1.24,
        
    }

    model.notes = 'http://www.noxxic.com/wow/pve/warlock/affliction/dps-gear-reforging'

    model.reforgeOrder = 
	{
        {
            rating = CR_HIT_SPELL,
            cap = "SpellHitCap"
        },
		{
            rating = CR_MASTERY,
            cap = "MaximumPossible"
        },
        {
            rating = CR_HASTE_SPELL,
            cap = "MaximumPossible",
        },
        {
            rating = CR_CRIT_SPELL,
            cap = "MaximumPossible"
        },
        
    }

    return model
end

--updated 9/8 for 5.04
function Reforgenator:DestroWarlockModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_HIT_RATING_SHORT"] = 2.83,
		["ITEM_MOD_MASTERY_RATING_SHORT"] = 2.08,
		["ITEM_MOD_CRIT_RATING_SHORT"] = 1.40,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 1.40,
        }

    model.notes = 'http://www.noxxic.com/wow/pve/warlock/destruction/dps-stat-priority-and-details'

    model.reforgeOrder = 
	{
        {
            rating = CR_HIT_SPELL,
            cap = "SpellHitCap"
        },
		{
            rating = CR_MASTERY,
            cap = "MaximumPossible"
        },
		{
            rating = CR_CRIT_SPELL,
            cap = "MaximumPossible"
        },
        {
            rating = CR_HASTE_SPELL,
            cap = "MaximumPossible"
        },
        
    }

    return model
end

function Reforgenator:DemoWarlockModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_HIT_RATING_SHORT"] = 3.74,
		["ITEM_MOD_MASTERY_RATING_SHORT"] = 2.97,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 2.37,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 2.05,
        
    }

    model.notes = 'http://www.noxxic.com/wow/pve/warlock/demonology'

    model.reforgeOrder = 
	{
        {
            rating = CR_HIT_SPELL,
            cap = "SpellHitCap"
        },
		{
            rating = CR_MASTERY,
            cap = "MaximumPossible"
        },
		{
            rating = CR_CRIT_SPELL,
            cap = "MaximumPossible"
        },
                {
            rating = CR_HASTE_SPELL,
            cap = "MaximumPossible"
        },
    }

    return model
end

-- End Warlock 66666666666666666666666666666666666666666666666666666666666666666666666666666666666


--Mage 77777777777777777777777777777777777777777777777777777777777777777777777777777

-- TODO
function Reforgenator:ArcaneMageModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_HIT_RATING_SHORT"] = 3.21,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 1.4,
		["ITEM_MOD_MASTERY_RATING_SHORT"] = 1.4,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 1.34,
        
    }

	model.notes = 'http://www.noxxic.com/wow/pve/mage/arcane/dps-gear-reforging'
		
    model.reforgeOrder = 
	{
        {
            rating = CR_HIT_SPELL,
            cap = "SpellHitCap"
        },
		{
            rating = CR_HASTE_SPELL,
            cap = "MaximumPossible"
        },
        {
            rating = CR_MASTERY,
            cap = "MaximumPossible"
        },
        {
            rating = CR_CRIT_SPELL,
            cap = "MaximumPossible"
        },
        
    }

    return model
end

-- TODO
function Reforgenator:FrostMageModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_HIT_RATING_SHORT"] = 3.08,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 2.05,
		["ITEM_MOD_CRIT_RATING_SHORT"] = 1.97,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 1.43,
    }

    model.notes = 'http://www.noxxic.com/wow/pve/mage/frost/dps-gear-reforging'

    model.reforgeOrder = 
	{
        {
            rating = CR_HIT_SPELL,
            cap = "SpellHitCap"
        },
        {
            rating = CR_HASTE_SPELL,
            cap = "MaximumPossible"
        },
		{
            rating = CR_CRIT_SPELL,
            cap = "23.34% Crit"
        },
        {
            rating = CR_MASTERY,
            cap = "MaximumPossible"
        },
    }

    return model
end

-- TODO
function Reforgenator:FireMageModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_HIT_RATING_SHORT"] = 3.44,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 2.21,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 2.01,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 1.42,
    }

    model.notes = 'http://www.noxxic.com/wow/pve/mage/fire/dps-gear-reforging'

    model.reforgeOrder = 
	{
        {
            rating = CR_HIT_SPELL,
            cap = "SpellHitCap"
        },
        {
            rating = CR_CRIT_SPELL,
            cap = "MaximumPossible"
        },
		{
            rating = CR_HASTE_SPELL,
            cap = "15% Haste"
        },
        {
            rating = CR_MASTERY,
            cap = "MaximumPossible"
        },
    }

    return model
end

--end Mage 77777777777777777777777777777777777777777777777777777777777777777777777777777

--Priest  88888888888888888888888888888888888888888888888888888888888888888888

-- TODO
function Reforgenator:ShadowPriestModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_HIT_RATING_SHORT"] = 2,
		["ITEM_MOD_HASTE_RATING_SHORT"] = 1.95,
        ["ITEM_MOD_SPIRIT_SHORT"] = 1.95,        
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 1.70,
		["ITEM_MOD_MASTERY_RATING_SHORT"] = 1.60,
        
    }

    model.notes = 'http://www.noxxic.com/wow/pve/priest/shadow/dps-gear-reforging'

    model.reforgeOrder = 
	{
        {
            rating = CR_HIT_SPELL,
            cap = "SpellHitCap"
        },
        {
            rating = CR_HASTE_SPELL,
            cap = "MaximumPossible"
        },
        {
            rating = CR_CRIT_SPELL,
            cap = "MaximumPossible"
        },
		{
            rating = CR_MASTERY,
            cap = "MaximumPossible"
        },
        
    }

    return model
end

-- TODO
function Reforgenator:DiscPriestModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_SPIRIT_SHORT"] = 0.80,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 0.60,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 0.50,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 0.40,
    }

    model.notes = 'http://www.noxxic.com/wow/pve/priest/discipline/heal-gear-reforging'

    model.reforgeOrder = 
	{
        {
            rating = CR_SPIRIT,
            cap = "MaimumPossible"
			--cap = "Fixed",
            --userdata = 3241
        },
        {
            rating = CR_MASTERY,
            cap = "MaximumPossible"
        },
    }

    return model
end

-- TODO
function Reforgenator:HolyPriestModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_SPIRIT_SHORT"] = 0.80,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 0.75,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 0.70,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 0.50,
    }

    model.notes = 'http://www.noxxic.com/wow/pve/priest/holy/heal-gear-reforging'

    model.reforgeOrder = 
	{
        {
            rating = CR_SPIRIT,
            cap = "MaximumPossible"
        },
        {
            rating = CR_HASTE_SPELL,
            cap = "12.5% Haste",
        },
        {
            rating = CR_MASTERY,
            cap = "MaximumPossible"
        },
        {
            rating = CR_HASTE_SPELL,
            cap = "MaximumPossible"
        },
    }

    return model
end


-- End Priest 88888888888888888888888888888888888888888888888888888888888888888888

--Shamman 9999999999999999999999999999999999999999999999999999999999

function Reforgenator:ElementalModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_SPIRIT_SHORT"] = 2.70,
        ["ITEM_MOD_HIT_RATING_SHORT"] = 2.70,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 1.73,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 1.62,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 1.11,
    }

    model.notes = 'http://www.noxxic.com/pve/shaman/elemental/stat-priority-and-reforging-strats'

    model.reforgeOrder = 
	{
        {
            rating = CR_HIT_SPELL,
            cap = "SpellHitCap"
        },
		{
            rating = CR_SPIRIT,
            cap = "SpellHitCap"
        },
        {
            rating = CR_HASTE_SPELL,
            cap = "1SecGCD"
        },
        {
            rating = CR_MASTERY,
            cap = "MaximumPossible"
        },
    }

    return model
end

function Reforgenator:EnhancementModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_HIT_RATING_SHORT"] = 4.0,
        ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 2.80,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 2.35,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 1.54,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 1.37,
    }

    model.notes = 'http://elitistjerks.com/f79/t127416-enhancement_4_3_least_your_old_axe_good_transmog/'

    model.reforgeOrder = 
	{
        {
            rating = CR_HIT_MELEE,
            cap = "MeleeHitCap"
        },
        {
            rating = CR_EXPERTISE,
            cap = "ExpertiseSoftCap"
        },
        {
            rating = CR_HIT_SPELL,
            cap = "SpellHitCap"
        },
        {
            rating = CR_MASTERY,
            cap = "MaximumPossible"
        },
    }

    return model
end

function Reforgenator:RestoShamanModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_SPIRIT_SHORT"] = 0.65,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 0.60,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 0.55,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 0.40,
    }

    model.notes = 'http://elitistjerks.com/f79/t121202-resto_raiding_4_1_updating_4_3_a/'

    model.reforgeOrder = 
	{
        {
            rating = CR_SPIRIT,
            cap = "MaimumPossible"
        },
        {
            rating = CR_HASTE_SPELL,
            cap = "12.5% Haste",
        },
        {
            rating = CR_MASTERY,
            cap = "MaximumPossible",
        },
    }

    return model
end

-- End Shaman 9999999999999999999999999999999999999999999999999999999999