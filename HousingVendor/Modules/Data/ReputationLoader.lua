-- Reputation Data Loader
-- Builds lookup tables from HousingReputations data

-- Build reverse lookup: itemID -> factionID
HousingVendorItemToFaction = {}

if HousingReputations then
    for factionID, factionData in pairs(HousingReputations) do
        if factionData.rewards then
            for _, reward in ipairs(factionData.rewards) do
                HousingVendorItemToFaction[reward.itemID] = {
                    factionID = factionID,
                    requiredStanding = reward.requiredStanding,
                    faction = factionData.faction,
                    rep = factionData.rep,
                }
            end
        end
    end
end
