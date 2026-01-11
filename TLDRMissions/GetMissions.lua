local addonName, addon = ...

function addon.BaseGUIMixin:GetMissionsMatchingFilter(rewardFilter)
    local missions = C_Garrison.GetAvailableMissions(self.followerTypeID)
    local lineup = {}
    
    for _, mission in pairs(missions) do
        for _, reward in pairs(mission.rewards) do
            if rewardFilter(reward) then
                table.insert(lineup, mission)
                break
            end
        end
    end
    
    return lineup
end

local function goldFilter(reward)
    return reward.currencyID and (reward.currencyID == 0)
end
function addon.BaseGUIMixin:GetGoldMissions()
    return self:GetMissionsMatchingFilter(goldFilter)
end

local tableResourceCurrencyIDs = {
    [824] = true,
    [1220] = true,
    [1560] = true,
}
local function TableResourceFilter(reward)
    return reward.currencyID and tableResourceCurrencyIDs[reward.currencyID]
end
function addon.BaseGUIMixin:GetTableResourcesMissions()
    return self:GetMissionsMatchingFilter(TableResourceFilter)
end

local followerItemIDs = {
    -- Legion
    [139812] = true, -- potion of triton
    [152447] = true, -- lightburst charge
    [152437] = true, -- Viscid Demon Blood
    [152932] = true, -- Runewarded Lightblade
    
    -- WOD
    [120301] = true, -- armor enhancement token
    [114081] = true, -- blackrock weaponry
    [114806] = true, -- blackrock armor set
    [120302] = true, -- weapon enhancement token
    [118474] = true, -- Supreme Manual of Dance
    [123858] = true, -- Follower Retraining Scroll Case
    [152442] = true, -- Impervious Shadoweave Hood
    [152927] = true, -- Serrated Stone Axe 
    
    -- BFA
    [152439] = true, -- Pit lord tusk
    [139809] = true, -- Elixir of plenty
}
local function followerItemFilter(reward)
    return reward.itemID and followerItemIDs[reward.itemID]
end
function addon.BaseGUIMixin:GetFollowerItemMissions()
    return self:GetMissionsMatchingFilter(followerItemFilter)
end

local function petcharmItemFilter(reward)
    return reward.itemID and ((reward.itemID == 116415) or (reward.itemID == 163036))
end
function addon.BaseGUIMixin:GetPetCharmMissions()
    return self:GetMissionsMatchingFilter(petcharmItemFilter)
end

local gearCacheItemIDs = {
    -- WOD
    [118529] = true, -- Cache of Highmaul Treasures (normal)
    [118530] = true, -- Cache of Highmaul Treasures (heroic)
    [118531] = true, -- Cache of Highmaul Treasures (mythic)
    [122486] = true, -- blackrock foundry spoils (mythic)
    [122485] = true, -- blackrock foundry spoils (heroic)
    [122484] = true, -- blackrock foundry spoils (normal)
    
    -- Legion
    [152325] = true, -- Sanguine Argunite (LFR)
    [152326] = true, -- Sanguine Argunite (normal)
    [152327] = true, -- Sanguine Argunite (heroic)
    [152328] = true, -- Sanguine Argunite (mythic)
    [147509] = true, -- Seal of the Deceiver (LFR)
    [147510] = true, -- Seal of the Deceiver (normal)
    [147511] = true, -- Seal of the Deceiver (heroic)
    [147512] = true, -- Seal of the Deceiver (mythic)
}
local function gearFilter(reward)
    return reward.itemID and (gearCacheItemIDs[reward.itemID] or C_Item.IsEquippableItem(reward.itemID))
end
function addon.BaseGUIMixin:GetGearMissions()
    return self:GetMissionsMatchingFilter(gearFilter)
end

local reputationCurrencyIDs = {
    [1579] = true, -- Champion's of Azeroth
    [1595] = true, -- Talanji's Expedition
    [1596] = true, -- Vol'dun
    [1597] = true, -- Zandalari
    [1600] = true, -- Honorbound
}
local reputationItemIDs = {
    [146941] = true, -- Valarjar
    [139020] = true, -- Valarjar
    [146935] = true, -- Valarjar
    [146939] = true, -- Wardens
    [146945] = true, -- Wardens
    [152955] = true, -- Army of the light
    [152957] = true, -- Army of the light
    [152958] = true, -- Army of the light
    [152956] = true, -- Army of the light
    [146946] = true, -- Nightfallen
    [146940] = true, -- Nightfallen
    [152960] = true, -- Argussian Reach
    [152959] = true, -- Argussian Reach
}
local function reputationFilter(reward)
    return (reward.currencyID and reputationCurrencyIDs[reward.currencyID]) or (reward.itemID and reputationItemIDs[reward.itemID])
end
function addon.BaseGUIMixin:GetReputationMissions()
    return self:GetMissionsMatchingFilter(reputationFilter)
end

local reagentItemIDs = {
    [124124] = true, -- Blood of Sargeras
    [151568] = true, -- Primal Sargerite
    
    [168327] = true, -- Chain Ignitercoil (mechagon)
}
local function reagentFilter(reward)
    return reward.itemID and reagentItemIDs[reward.itemID]
end
function addon.BaseGUIMixin:GetCraftingReagentMissions()
    return self:GetMissionsMatchingFilter(reagentFilter)
end

local function artifactPowerFilter(reward)
    return reward.currencyID == 1553
end
function addon.BaseGUIMixin:GetArtifactPowerMissions()
    return self:GetMissionsMatchingFilter(artifactPowerFilter)
end

local function apexisFilter(reward)
    return reward.currencyID and (reward.currencyID == 823)
end

function addon.BaseGUIMixin:GetApexisMissions()
    return self:GetMissionsMatchingFilter(apexisFilter)
end

local function oilFilter(reward)
    return reward.currencyID and (reward.currencyID == 1101)
end

function addon.BaseGUIMixin:GetOilMissions()
    return self:GetMissionsMatchingFilter(oilFilter)
end

local function sealFilter(reward)
    return reward.currencyID and (reward.currencyID == 994)
end

function addon.BaseGUIMixin:GetSealMissions()
    return self:GetMissionsMatchingFilter(sealFilter)
end

local archaeologyCurrencyIDs = {
    [829] = true,
    [821] = true,
    [828] = true,
}

local archaeologyItemIDs = {
    [109585] = true,
    [108439] = true,
    [109584] = true,
}

local function archaeologyFilter(reward)
    if reward.currencyID then
        return archaeologyCurrencyIDs[reward.currencyID]
    elseif reward.itemID then
        return archaeologyItemIDs[reward.itemID]
    end
end

function addon.BaseGUIMixin:GetArchaeologyMissions()
    return self:GetMissionsMatchingFilter(archaeologyFilter)
end

local function followerXPFilter(reward)
    return reward.followerXP
end

function addon.BaseGUIMixin:GetFollowerXPMissions()
    return self:GetMissionsMatchingFilter(followerXPFilter)
end

local augmentRuneItemIDs = {
    [140587] = true,
    [160053] = true,
}

local function augmentRuneFilter(reward)
    return reward.itemID and augmentRuneItemIDs[reward.itemID]
end

function addon.BaseGUIMixin:GetAugmentRuneMissions()
    return self:GetMissionsMatchingFilter(augmentRuneFilter)
end