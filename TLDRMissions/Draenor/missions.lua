local addonName, addon = ...

local followerItemIDs = {
    [120301] = true, -- armor enhancement token
    [114081] = true, -- blackrock weaponry
    [114806] = true, -- blackrock armor set
    [120302] = true, -- weapon enhancement token
    [118474] = true, -- Supreme Manual of Dance
}

local gearCacheItemIDs = {
    [118529] = true, -- Cache of Highmaul Treasures (normal)
    [118530] = true, -- Cache of Highmaul Treasures (heroic)
    [118531] = true, -- Cache of Highmaul Treasures (mythic)
    [122486] = true, -- blackrock foundry spoils (mythic)
    [122485] = true, -- blackrock foundry spoils (heroic)
    [122484] = true, -- blackrock foundry spoils (normal)
}

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

local function sort_func(a, b)
    if a.missionScalar == b.missionScalar then
        return a.missionID < b.missionID
    end
    return a.missionScalar < b.missionScalar
end

function addon:GetAllWODMissionsMatchingFilter(rewardFilter)
    local missions = C_Garrison.GetAvailableMissions(1)
    local missionLineup = {}
    
    for _, mission in pairs(missions) do
        local rewards = mission.rewards
        local include = false
        for _, reward in pairs(rewards) do
            if rewardFilter(reward) then
                include = true
                break
            end

            --if (rewardFilter == "augment-runes") and (reward.itemID == 181468) then
            --    include = true
            --end
        end
        
        if include then
            table.insert(missionLineup, mission)
        end
    end
    
    table.sort(missionLineup, sort_func)
    
    return missionLineup
end

local function goldFilter(reward)
    return reward.currencyID and (reward.currencyID == 0)
end

function addon:GetWODGoldMissions()
    return addon:GetAllWODMissionsMatchingFilter(goldFilter)
end

local function followerXPFilter(reward)
    return reward.followerXP
end

function addon:GetWODFollowerXPMissions()
    return addon:GetAllWODMissionsMatchingFilter(followerXPFilter)
end

local function followerItemFilter(reward)
    return reward.itemID and followerItemIDs[reward.itemID]
end

function addon:GetWODFollowerItemMissions()
    return addon:GetAllWODMissionsMatchingFilter(followerItemFilter)
end

local function garrisonResourceFilter(reward)
    return reward.currencyID and (reward.currencyID == 824)
end

function addon:GetWODGarrisonResourcesMissions()
    return addon:GetAllWODMissionsMatchingFilter(garrisonResourceFilter)
end

--function addon:GetWODPetCharmMissions()
--    return addon:GetAllWODMissionsMatchingFilter("pet-charms")
--end

local function apexisFilter(reward)
    return reward.currencyID and (reward.currencyID == 823)
end

function addon:GetWODApexisMissions()
    return addon:GetAllWODMissionsMatchingFilter(apexisFilter)
end

local function gearFilter(reward)
    return reward.itemID and (gearCacheItemIDs[reward.itemID] or C_Item.IsEquippableItem(reward.itemID))
end

function addon:GetWODGearMissions()
    return addon:GetAllWODMissionsMatchingFilter(gearFilter)
end

local function oilFilter(reward)
    return reward.currencyID and (reward.currencyID == 1101)
end

function addon:GetWODOilMissions()
    return addon:GetAllWODMissionsMatchingFilter(oilFilter)
end

local function sealFilter(reward)
    return reward.currencyID and (reward.currencyID == 994)
end

function addon:GetWODSealMissions()
    return addon:GetAllWODMissionsMatchingFilter(sealFilter)
end

local function archaeologyFilter(reward)
    if reward.currencyID then
        return archaeologyCurrencyIDs[reward.currencyID]
    elseif reward.itemID then
        return archaeologyItemIDs[reward.itemID]
    end
end

function addon:GetWODArchaeologyMissions()
    return addon:GetAllWODMissionsMatchingFilter(archaeologyFilter)
end