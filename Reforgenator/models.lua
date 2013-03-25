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


-- Death Knight 

function Reforgenator:TwoHandFrostDKModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 2.15,
		["ITEM_MOD_HIT_RATING_SHORT"] = 2.17,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 1.67,
		["ITEM_MOD_CRIT_RATING_SHORT"] = 1.44,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 1.02,        
    }

    model.notes = 'http://www.noxxic.com/wow/pve/death-knight/frost/dps-gear-reforging'

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

function Reforgenator:DWFrostDKModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 2.74,
		["ITEM_MOD_HIT_RATING_SHORT"] = 2.29,
		["ITEM_MOD_MASTERY_RATING_SHORT"] = 1.60,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 1.39,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 1.34,
    }

    model.notes = 'http://www.noxxic.com/wow/pve/death-knight/frost/dps-gear-reforging'

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
        ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 1.2,
        ["ITEM_MOD_HIT_RATING_SHORT"] = 1.5,
		["ITEM_MOD_HASTE_RATING_SHORT"] = 0.75,
    }

    model.notes = 'http://www.noxxic.com/wow/pve/death-knight/blood/reforging-gear'

    model.reforgeOrder = 
	{
        {
            rating = CR_MASTERY,
            cap = "MaximumPossible"
		},
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
    }

    return model
end

function Reforgenator:UnholyDKModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_HIT_RATING_SHORT"] = 2.29,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 1.63,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 1.61,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 1.15,
        ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 2.42,
    }

    model.notes = 'http://www.noxxic.com/wow/pve/death-knight/unholy/reforging-gear'

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

-- End Death Knight 
 
-- Druid  

-- TODO
function Reforgenator:GuardianModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_DODGE_RATING_SHORT"] = 0.0252,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 0.011,
        ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 0.018,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 0.043,
        ["ITEM_MOD_HIT_RATING_SHORT"] = 0.018,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 0.02,
    }

    model.notes = 'http://www.noxxic.com/wow/pve/druid/guardian/reforging-gear'

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
        ["ITEM_MOD_SPIRIT_SHORT"] = 3.06,
        ["ITEM_MOD_HIT_RATING_SHORT"] = 3.06,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 1.57,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 1.65,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 1.76,
    }

    model.notes = 'http://www.noxxic.com/wow/pve/druid/balance/reforging-gear'

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
            rating = CR_CRIT_SPELL,
            cap = "MaximumPossible",
        },
        {
            rating = CR_MASTERY,
            cap = "MaximumPossible"
        },
        
    }

    return model
end

function Reforgenator:FeralModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 1.76,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 1.60,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 1.29,
        ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 2.0,
        ["ITEM_MOD_HIT_RATING_SHORT"] = 2.0,
    }

    model.notes = 'http://www.noxxic.com/wow/pve/druid/feral/reforging-gear'

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

function Reforgenator:ManaRestoDruidModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_SPIRIT_SHORT"] = 2.75,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 2,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 1.95,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 0.50,
    }

    model.notes = 'http://www.noxxic.com/wow/pve/druid/restoration/reforging-gear'

    model.reforgeOrder = 
	{
		{
            rating = CR_SPIRIT,
            cap = "Fixed",
            userdata = {8500},
        },
		{
            rating = CR_HASTE_SPELL,
            cap = "Fixed",
            userdata = {3043},
        },
        {
            rating = CR_MASTERY,
            cap = "MaximumPossible",
        },
    }

    return model
end

function Reforgenator:RestoDruidModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
        ["ITEM_MOD_SPIRIT_SHORT"] = 2.75,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 2,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 1.95,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 0.50,
    }

    model.notes = 'http://www.noxxic.com/wow/pve/druid/restoration/reforging-gear'

    model.reforgeOrder = 
	{
		{
            rating = CR_SPIRIT,
            cap = "Fixed",
            userdata = {6000},
        },
		{
            rating = CR_HASTE_SPELL,
            cap = "Fixed",
            userdata = {3043},
        },
        {
            rating = CR_MASTERY,
            cap = "MaximumPossible",
        },
		{
            rating = CR_HASTE_SPELL,
            cap = "Fixed",
            userdata = {4717},
        },
    }

    return model
end

-- End Druid 

--Pally  

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

    model.notes = 'http://www.noxxic.com/wow/pve/paladin/protection/reforging-gear'

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

    model.notes = 'http://www.noxxic.com/wow/pve/paladin/retribution/reforging-gear'

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
            cap = "MaximumPossible"
        },
        {
            rating = CR_CRIT_MELEE,
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

    model.notes = 'http://www.noxxic.com/wow/pve/paladin/holy/reforging-gear'

    model.reforgeOrder = 
	{
        {
            rating = CR_SPIRIT,
            cap = "MaximumPossible"
        },
		{
            rating = CR_MASTERY,
            cap = "MaximumPossible"
        },
        {
            rating = CR_HASTE_SPELL,
            cap = "MaximumPossible"
        },
		{
			rating = CR_CRIT_SPELL,
			cap = "MaximumPossible"
		},
    }

    return model
end


-- End Pally 

--Hunter  

-- updated 9/8  for 5.04
function Reforgenator:BeastMasterHunterModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
	    ["ITEM_MOD_HIT_RATING_SHORT"] = 2.89,
        ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 2.98,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 1.45,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 1.25,
		["ITEM_MOD_MASTERY_RATING_SHORT"] = 1.32,

    }

    model.notes = 'http://www.noxxic.com/wow/pve/hunter/beast-mastery/reforging-gear'

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

-- updated for 5.05
function Reforgenator:MarksmanshipHunterModel()
    local model = ReforgeModel:new()
    model.readOnly = true
    model.statWeights = 
	{
		["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 3.19,
        ["ITEM_MOD_HIT_RATING_SHORT"] = 3.27,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 1.42,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 1.19,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 0.92,
    }

    model.notes = 'http://www.noxxic.com/wow/pve/hunter/marksmanship/reforging-gear'

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
            rating = CR_HASTE_RANGED,
            cap = "MaximumPossible"
        },
        {
            rating = CR_CRIT_RANGED,
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
		["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 2.89,
		["ITEM_MOD_HIT_RATING_SHORT"] = 2.94,
        ["ITEM_MOD_CRIT_RATING_SHORT"] = 1.34,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = -6.83,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = -7.11,
    }

    model.notes = 'http://www.noxxic.com/wow/pve/hunter/survival/reforging-gear'

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

-- End Hunter 

--Warrior  

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

    model.notes = 'http://www.noxxic.com/wow/pve/warrior/fury/reforging-gear'

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

    model.notes = 'http://www.noxxic.com/wow/pve/warrior/arms/reforging-gear'

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
            rating = CR_HASTE_MELEE,
            cap = "MaximumPossible",
        },
		{
            rating = CR_MASTERY,
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
    
    model.notes = 'http://www.noxxic.com/wow/pve/warrior/protection/reforging-gear'

    model.reforgeOrder = 
	{
        {
            rating = CR_MASTERY,
            cap = "MaximumPossible"
        },
		{
            rating = CR_HIT_MELEE,
            cap = "MeleeHitCap",
        },
        {
            rating = CR_EXPERTISE,
            cap = "ExpertiseSoftCap",
        },
		{
			rating = CR_PARRY,
			cap ="maximumPossible"
        },
		{
			rating = CR_DODGE,
			cap = "MaximumPossible"
		},
        {
            rating = CR_HASTE_MELEE,
            cap = "MaximumPossible",
        },

    }

    return model
end

-- end Warrior 

--Rogue 

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

    model.notes = 'http://www.noxxic.com/wow/pve/rogue/assassination/reforging-gear'

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
        },{
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

    model.notes = 'http://www.noxxic.com/wow/pve/rogue/subtlety/reforging-gear'

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

-- End Rogue  

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

-- End Warlock 


--Mage 

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

--end Mage 

--Priest  

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
			
            cap = "SpellHitCap",
			preferSpirit = true
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


-- End Priest 

--Shamman 

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

    model.notes = 'http://www.noxxic.com/wow/pve/shaman/elemental/reforging-gear'

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

    model.notes = 'http://www.noxxic.com/wow/pve/shaman/enhancement/reforging-gear/'

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
            rating = CR_HASTE_SPELL,
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

    model.notes = 'http://www.noxxic.com/wow/pve/shaman/restoration/reforging-gear'

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
            cap = "MaximumPossible",
        },
    }

    return model
end

-- End Shaman 

-- Monk

function Reforgenator:BrewMasterMonkModel()
	local model = ReforgeModel:new()
	model.readOnly = true
	model.statWeights =
	{
		["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 2.5,
		["ITEM_MOD_HIT_RATING_SHORT"] = 2.45,
		["ITEM_MOD_CRIT_RATING_SHORT"] = 1.75,
		["ITEM_MOD_HASTE_RATING_SHORT"] = 1.7,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 1,
	}
	
	model.notes = 'http://www.noxxic.com/wow/pve/monk/brewmaster/reforging-gear'
	
	model.reforgeOrder = 
	{
		{
            rating = CR_EXPERTISE,
            cap = "ExpertiseHardCap"
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
function Reforgenator:MistWeaverMonkModel()
	local model = ReforgeModel:new()
	model.readOnly = true
	model.statWeights =
	{
	--add weights
		["ITEM_MOD_SPIRIT_SHORT"] = 2.5,
        ["ITEM_MOD_HASTE_RATING_SHORT"] = 1.75,
		["ITEM_MOD_CRIT_RATING_SHORT"] = 1.5,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = 1.05,
	}
	
	model.notes = 'http://www.noxxic.com/wow/pve/monk/mistweaver/reforging-gear'
	
	model.reforgeOrder = 
	{
		{
            rating = CR_SPIRIT,
            cap = "MaximumPossible"
        },
        {
            rating = CR_HASTE_SPELL,
            cap = "1SecGCD"
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
--[[
        [1] = "ITEM_MOD_CRIT_RATING_SHORT",
        [2] = "ITEM_MOD_DODGE_RATING_SHORT",
        [3] = "ITEM_MOD_EXPERTISE_RATING_SHORT",
        [4] = "ITEM_MOD_HASTE_RATING_SHORT",
        [5] = "ITEM_MOD_HIT_RATING_SHORT",
        [6] = "ITEM_MOD_MASTERY_RATING_SHORT",
        [7] = "ITEM_MOD_PARRY_RATING_SHORT",
        [8] = "ITEM_MOD_SPIRIT_SHORT",
		]]
function Reforgenator:TwoHandWindWalkerMonkModel()
	local model = ReforgeModel:new()
	model.readOnly = true
	model.statWeights =
	{
		["ITEM_MOD_HIT_RATING_SHORT"] = 2.5,
        ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 1.75,
		["ITEM_MOD_CRIT_RATING_SHORT"] = 1.15,
		["ITEM_MOD_HASTE_RATING_SHORT"] = 1.0,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = .75,
	}
	
	model.notes = 'http://www.noxxic.com/wow/pve/monk/windwalker/reforging-gear'
	
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
function Reforgenator:DWWindWalkerMonkModel()
	local model = ReforgeModel:new()
	model.readOnly = true
	model.statWeights =
	{
		["ITEM_MOD_HIT_RATING_SHORT"] = 2.5,
        ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 1.75,
		["ITEM_MOD_HASTE_RATING_SHORT"] = 1.15,
		["ITEM_MOD_CRIT_RATING_SHORT"] = 1.0,
        ["ITEM_MOD_MASTERY_RATING_SHORT"] = .75,
	}
	
	model.notes = 'http://www.noxxic.com/wow/pve/monk/windwalker/reforging-gear'
	
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
--End Monk