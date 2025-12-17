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
    [139812] = true, -- potion of triton
    [152447] = true, -- lightburst charge
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
    [118529] = true, -- Cache of Highmaul Treasures (normal)
    [118530] = true, -- Cache of Highmaul Treasures (heroic)
    [118531] = true, -- Cache of Highmaul Treasures (mythic)
    [122486] = true, -- blackrock foundry spoils (mythic)
    [122485] = true, -- blackrock foundry spoils (heroic)
    [122484] = true, -- blackrock foundry spoils (normal)
}
local function gearFilter(reward)
    return reward.itemID and (gearCacheItemIDs[reward.itemID] or C_Item.IsEquippableItem(reward.itemID))
end
function addon.BaseGUIMixin:GetGearMissions()
    return self:GetMissionsMatchingFilter(gearFilter)
end

local reputationCurrencyIDs = {
    [1597] = true, -- Zandalari
}
local reputationItemIDs = {
    [146941] = true, -- Valarjar
    [139020] = true, -- Valarjar
    [146935] = true, -- Valarjar
    [146939] = true, -- Wardens
    [146945] = true, -- Wardens
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