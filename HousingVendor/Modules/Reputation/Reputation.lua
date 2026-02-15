-- Reputation Handler
-- Manages reputation/renown scanning and multi-character caching

local ReputationHandler = {}
ReputationHandler.__index = ReputationHandler

-- Reputation standing levels (standard factions)
local STANDING_LEVELS = {
    [1] = "Hated",
    [2] = "Hostile",
    [3] = "Unfriendly",
    [4] = "Neutral",
    [5] = "Friendly",
    [6] = "Honored",
    [7] = "Revered",
    [8] = "Exalted",
}

-- Standing requirements for items
local STANDING_REQUIREMENTS = {
    ["Friendly"] = 5,
    ["Honored"] = 6,
    ["Revered"] = 7,
    ["Exalted"] = 8,
}

-- Friendship level mapping
local FRIENDSHIP_LEVEL_FROM_NAME = {
    Stranger = 1,
    Acquaintance = 2,
    Buddy = 3,
    Friend = 4,
    ["Good Friend"] = 5,
    ["Best Friend"] = 6,
}

-- Reaction name mapping
local REACTION_FROM_NAME = {
    Neutral = 4,
    Friendly = 5,
    Honored = 6,
    Revered = 7,
    Exalted = 8,
}

-- Cached reputation data per character
-- Format: HousingDB.reputations[characterKey] = { [factionID] = { ... } }
local cachedData = {}
local currentCharacterKey = nil

-- List of unique factions with housing items
local factionList = {}

-- Removed: PrimeHousingCatalog (dead code; catalog priming handled by CollectionAPI).

-- Decor Collection Tracking
-- Delegates to HousingCollectionAPI (single source of truth).
function ReputationHandler:IsDecorCollected(itemID)
    if not itemID or itemID <= 0 then
        return false
    end
    if _G.HousingCollectionAPI and _G.HousingCollectionAPI.IsItemCollected then
        local ok, collected = pcall(_G.HousingCollectionAPI.IsItemCollected, _G.HousingCollectionAPI, itemID)
        if ok then
            return collected
        end
    end
    return false
end

-- Get friendship tier from label (for Tillers, Brawler's Guild)
local function GetFriendshipTierFromLabel(label)
    if type(label) ~= "string" then
        return 0
    end
    -- Support Brawler-style ranks ("Rank 3")
    local rank = label:match("[Rr]ank%s*(%d+)")
    if rank then
        return tonumber(rank) or 0
    end
    return FRIENDSHIP_LEVEL_FROM_NAME[label] or 0
end

-- Initialize
function ReputationHandler:Initialize()
    -- Get current character key
    local name = UnitName("player")
    local realm = GetRealmName()
    currentCharacterKey = name .. "-" .. realm

    -- Ensure DB structure exists
    if not HousingDB then
        HousingDB = {}
    end
    if not HousingDB.reputations then
        HousingDB.reputations = {}
    end

    -- Load cached data for current character
    cachedData = HousingDB.reputations[currentCharacterKey] or {}

    print("|cFF8A7FD4HousingVendor:|r Reputation handler initialized for " .. currentCharacterKey)

    -- Check if we need to auto-scan (no cached data or data is stale)
    local shouldAutoScan = false
    if not cachedData or not next(cachedData) then
        -- No cached data at all - first time for this character
        shouldAutoScan = true
        print("|cFF8A7FD4HousingVendor:|r No reputation data found for " .. currentCharacterKey .. ", will auto-scan on first UI open")
    else
        -- Check if data is stale (older than 7 days)
        local oldestTimestamp = nil
        for _, repData in pairs(cachedData) do
            if repData.lastUpdated then
                if not oldestTimestamp or repData.lastUpdated < oldestTimestamp then
                    oldestTimestamp = repData.lastUpdated
                end
            end
        end

        if oldestTimestamp then
            local daysSinceUpdate = (time() - oldestTimestamp) / 86400  -- 86400 seconds in a day
            if daysSinceUpdate > 7 then
                shouldAutoScan = true
                print("|cFF8A7FD4HousingVendor:|r Reputation data is " .. math.floor(daysSinceUpdate) .. " days old, will refresh on first UI open")
            end
        end
    end

    -- Store flag for auto-scan
    self._shouldAutoScan = shouldAutoScan
end

-- Get current character key
function ReputationHandler:GetCurrentCharacter()
    return currentCharacterKey
end

-- Get list of all cached characters
function ReputationHandler:GetCachedCharacters()
    if not HousingDB or not HousingDB.reputations then
        return {}
    end

    local characters = {}
    for charKey, _ in pairs(HousingDB.reputations) do
        table.insert(characters, charKey)
    end

    -- Sort with current character first
    table.sort(characters, function(a, b)
        if a == currentCharacterKey then return true end
        if b == currentCharacterKey then return false end
        return a < b
    end)

    return characters
end

-- Load faction list from reputation data
local function LoadFactionsFromData()
    if not HousingVendorItemToFaction or not HousingReputations then
        return 0
    end

    local factionMap = {}
    local count = 0

    -- Get unique factions from item->faction mapping (SAME as info panel)
    for itemID, repInfo in pairs(HousingVendorItemToFaction) do
        local factionID = tonumber(repInfo.factionID)
        if factionID and not factionMap[factionID] then
            -- Get faction config from HousingReputations (SAME as info panel)
            local cfg = HousingReputations[factionID]
            if cfg then
                factionMap[factionID] = {
                    factionID = factionID,
                    label = cfg.label or "Unknown",
                    expansion = cfg.expansion or "Unknown",
                    category = cfg.category or "Unknown",
                    rep = cfg.rep or "standard",
                }
                count = count + 1
            end
        end
    end

    -- Convert to list
    factionList = {}
    for factionID, info in pairs(factionMap) do
        table.insert(factionList, info)
    end

    -- Sort by expansion, then by name
    table.sort(factionList, function(a, b)
        if a.expansion ~= b.expansion then
            return a.expansion > b.expansion  -- Newest first
        end
        return a.label < b.label
    end)

    return count
end

-- Scan reputation for current character
function ReputationHandler:ScanReputations(callback)
    if not currentCharacterKey then
        if callback then
            callback(false, "Character not initialized")
        end
        return
    end

    -- Ensure data is processed
    if HousingDataAggregator and HousingDataAggregator.ProcessPendingData then
        HousingDataAggregator:ProcessPendingData()
    end

    -- Rebuild reputation loader mapping
    if HousingReputationLoader and HousingReputationLoader.Rebuild then
        HousingReputationLoader:Rebuild()
    end

    -- Load faction list if empty
    if #factionList == 0 then
        local count = LoadFactionsFromData()
        if count == 0 then
            if callback then
                callback(false, "No reputation data found")
            end
            return
        end
    end

    -- Scan each faction from our housing vendor list
    -- Use the SAME method as the main UI info panel for consistency
    local scannedData = {}
    local scannedCount = 0
    local reactionNames = {"Hated", "Hostile", "Unfriendly", "Neutral", "Friendly", "Honored", "Revered", "Exalted"}

    for _, factionInfo in ipairs(factionList) do
        local factionID = factionInfo.factionID
        local isRenown = (factionInfo.rep == "renown")

        local standing = "Not Discovered"
        local currentValue = 0
        local maxValue = 1
        local standingLevel = nil

        -- Use C_ReputationInfo.GetFactionDataByID (same as main UI info panel)
        if C_ReputationInfo and C_ReputationInfo.GetFactionDataByID then
            local ok, fd = pcall(C_ReputationInfo.GetFactionDataByID, factionID)
            if ok and fd then
                if isRenown then
                    -- Renown system
                    if fd.renownLevel then
                        standing = "Renown " .. fd.renownLevel
                        currentValue = fd.renownLevel
                        maxValue = fd.renownLevelThreshold or fd.renownLevel
                    end
                else
                    -- Standard reputation
                    local standingID = tonumber(fd.reaction or fd.standingID)
                    if standingID then
                        standingLevel = standingID
                        standing = reactionNames[standingID] or "Unknown"

                        -- Get progress values
                        if fd.currentReactionThreshold and fd.nextReactionThreshold and fd.currentStanding then
                            maxValue = tonumber(fd.nextReactionThreshold) - tonumber(fd.currentReactionThreshold)
                            currentValue = tonumber(fd.currentStanding) - tonumber(fd.currentReactionThreshold)
                        elseif fd.barMin and fd.barMax and fd.barValue then
                            maxValue = tonumber(fd.barMax) - tonumber(fd.barMin)
                            currentValue = tonumber(fd.barValue) - tonumber(fd.barMin)
                        end

                        -- Handle Exalted (max level)
                        if standingLevel == 8 and maxValue == 0 then
                            maxValue = 1
                            currentValue = 1
                        end
                    end
                end
            end
        end

        -- Always add the faction, even if not discovered yet
        scannedData[factionID] = {
            factionID = factionID,
            label = factionInfo.label,
            expansion = factionInfo.expansion,
            category = factionInfo.category or "Unknown",
            rep = factionInfo.rep,
            standing = standing,
            standingLevel = standingLevel,
            currentValue = currentValue,
            maxValue = maxValue,
            isRenown = isRenown,
            lastUpdated = time(),
        }
        scannedCount = scannedCount + 1
    end

    -- Save to cache
    cachedData = scannedData
    if not HousingDB.reputations then
        HousingDB.reputations = {}
    end
    HousingDB.reputations[currentCharacterKey] = scannedData

    print("|cFF8A7FD4HousingVendor:|r Scanned " .. scannedCount .. " reputations for " .. currentCharacterKey)

    if callback then
        callback(true, scannedCount)
    end
end

-- Get reputation list for current character
-- Gets LIVE data using C_ReputationInfo API (EXACT same method as info panel)
function ReputationHandler:GetReputations(characterKey)
    -- Use HousingReputations directly (same as info panel)
    if not HousingReputations then
        return {}
    end

    local list = {}
    local reactionNames = {"Hated", "Hostile", "Unfriendly", "Neutral", "Friendly", "Honored", "Revered", "Exalted"}

    -- Loop through all factions with housing items
    -- HousingReputations stores each faction with BOTH string and numeric keys
    -- Only process numeric keys to avoid duplicates
    for factionID, cfg in pairs(HousingReputations) do
        -- ONLY process if the key is a number type (skip string keys)
        if type(factionID) == "number" and cfg then
            local numericFactionID = factionID
            local standing = "Not Discovered"
            local currentValue = 0
            local maxValue = 1
            local standingLevel = nil
            local isRenown = (cfg.rep == "renown")

            -- Additional metadata
            local extraData = {}

            -- Get live reputation data
            if isRenown then
                -- Renown system (Dragonflight/TWW major factions)
                if C_MajorFactions and C_MajorFactions.GetMajorFactionData then
                    local ok, mf = pcall(C_MajorFactions.GetMajorFactionData, numericFactionID)
                    if ok and mf then
                        local lvl = tonumber(mf.renownLevel) or 0
                        local cur = tonumber(mf.renownReputationEarned) or 0
                        local max = tonumber(mf.renownLevelThreshold) or 1
                        standing = "Renown " .. lvl
                        currentValue = cur
                        maxValue = max

                        -- Check if weekly renown capped (NEW API)
                        if C_MajorFactions.IsWeeklyRenownCapped then
                            extraData.isWeeklyCapped = C_MajorFactions.IsWeeklyRenownCapped(numericFactionID)
                        end

                        -- Check if maximum renown reached (NEW API)
                        if C_MajorFactions.HasMaximumRenown then
                            extraData.hasMaxRenown = C_MajorFactions.HasMaximumRenown(numericFactionID)
                        end
                    end
                end
            else
                -- Standard reputation - use C_Reputation.GetFactionDataByID (WoW 11.x)
                if C_Reputation and C_Reputation.GetFactionDataByID then
                    local factionData = C_Reputation.GetFactionDataByID(numericFactionID)
                    if factionData then
                        standingLevel = factionData.reaction
                        if standingLevel then
                            standing = reactionNames[standingLevel] or "Unknown"

                            -- Get current/max reputation values
                            currentValue = (factionData.currentStanding or 0) - (factionData.currentReactionThreshold or 0)
                            maxValue = (factionData.nextReactionThreshold or 0) - (factionData.currentReactionThreshold or 0)

                            -- Handle Exalted (max level)
                            if standingLevel == 8 and maxValue == 0 then
                                maxValue = 1
                                currentValue = 1
                            end

                            -- Check if this is a paragon faction (NEW API)
                            if C_Reputation.IsFactionParagon and C_Reputation.IsFactionParagon(numericFactionID) then
                                extraData.isParagon = true
                                -- Get paragon progress (NEW API)
                                if C_Reputation.GetFactionParagonInfo then
                                    local paragonValue, paragonThreshold, paragonRewardID, hasRewardPending = C_Reputation.GetFactionParagonInfo(numericFactionID)
                                    extraData.paragonValue = paragonValue or 0
                                    extraData.paragonThreshold = paragonThreshold or 1
                                    extraData.paragonRewardID = paragonRewardID
                                    extraData.hasParagonReward = hasRewardPending or false
                                end
                            end
                        end
                    end
                end
            end

            -- Add to list (one entry per faction)
            local entry = {
                factionID = numericFactionID,
                label = cfg.label or "Unknown",
                expansion = cfg.expansion or "Unknown",
                category = cfg.category or "Unknown",
                rep = cfg.rep or "standard",
                standing = standing,
                standingLevel = standingLevel,
                currentValue = currentValue,
                maxValue = maxValue,
                isRenown = isRenown,
            }

            -- Merge extra data if available
            for k, v in pairs(extraData) do
                entry[k] = v
            end

            table.insert(list, entry)
        end
    end

    -- Sort by expansion, then by name
    table.sort(list, function(a, b)
        if a.expansion ~= b.expansion then
            return a.expansion > b.expansion  -- Newest first
        end
        return a.label < b.label
    end)

    return list
end

-- Get specific faction reputation for a character
function ReputationHandler:GetFactionReputation(factionID, characterKey)
    local charKey = characterKey or currentCharacterKey

    if not HousingDB or not HousingDB.reputations or not HousingDB.reputations[charKey] then
        return nil
    end

    return HousingDB.reputations[charKey][factionID]
end

-- Check if a character meets reputation requirement for an item
function ReputationHandler:MeetsRequirement(itemID, characterKey)
    local charKey = characterKey or currentCharacterKey

    if not HousingVendorItemToFaction or not HousingVendorItemToFaction[itemID] then
        return true  -- No reputation requirement
    end

    local repInfo = HousingVendorItemToFaction[itemID]
    local factionID = tonumber(repInfo.factionID)
    local requiredStanding = repInfo.requiredStanding

    if not factionID or not requiredStanding then
        return true
    end

    local charRepData = self:GetFactionReputation(factionID, charKey)
    if not charRepData then
        return false  -- No data for this faction
    end

    -- Handle renown requirements
    if charRepData.isRenown then
        -- Extract renown level from requirement string (e.g., "Renown 5" -> 5)
        local requiredRenown = requiredStanding:match("Renown (%d+)")
        if requiredRenown then
            local currentRenown = charRepData.standing:match("Renown (%d+)")
            return currentRenown and tonumber(currentRenown) >= tonumber(requiredRenown)
        end
        return false
    end

    -- Handle standard reputation requirements
    local requiredLevel = STANDING_REQUIREMENTS[requiredStanding]
    if not requiredLevel then
        return false
    end

    -- Get current standing level
    for level, name in pairs(STANDING_LEVELS) do
        if name == charRepData.standing then
            return level >= requiredLevel
        end
    end

    return false
end

-- Check if a specific reward is unlocked for current character
function ReputationHandler:IsRewardUnlocked(factionID, reward)
    if not factionID or not reward then
        return false
    end

    local cfg = HousingReputations and HousingReputations[factionID]
    if not cfg then
        return false
    end

    local requiredStanding = reward.requiredStanding
    if not requiredStanding then
        return true
    end

    -- Renown-style
    if cfg.rep == "renown" or (requiredStanding and requiredStanding:match("^Renown")) then
        local requiredRenown = requiredStanding:match("Renown%s+(%d+)")
        if not requiredRenown then
            return false
        end
        requiredRenown = tonumber(requiredRenown)

        if not C_MajorFactions or not C_MajorFactions.GetMajorFactionData then
            return false
        end

        local data = C_MajorFactions.GetMajorFactionData(factionID)
        if not data or not data.renownLevel then
            return false
        end

        return data.renownLevel >= requiredRenown
    end

    -- Friendship-style (Tillers, Brawler's Guild)
    if cfg.rep == "friendship" then
        if not C_GossipInfo or not C_GossipInfo.GetFriendshipReputation then
            return false
        end

        local info = C_GossipInfo.GetFriendshipReputation(factionID)
        if not info then
            return false
        end

        -- Get required tier
        local requiredTier = FRIENDSHIP_LEVEL_FROM_NAME[requiredStanding] or 0
        -- Support Brawler ranks
        local rank = requiredStanding:match("[Rr]ank%s*(%d+)")
        if rank then
            requiredTier = tonumber(rank) or 0
        end

        -- Get current tier
        local tier = 0
        if info.friendshipFactionID and C_GossipInfo.GetFriendshipReputationRanks then
            local ranks = C_GossipInfo.GetFriendshipReputationRanks(info.friendshipFactionID)
            tier = (ranks and ranks.currentLevel) or 0
        end

        -- Fallback: label map
        if tier == 0 then
            tier = GetFriendshipTierFromLabel(info.reaction or info.friendshipText or info.text)
        end

        return tier >= requiredTier
    end

    -- Standard reputation
    if not C_Reputation or not C_Reputation.GetFactionDataByID then
        return false
    end

    local data = C_Reputation.GetFactionDataByID(factionID)
    if not data then
        return false
    end

    local reaction = data.reaction or 0
    local requiredReaction = REACTION_FROM_NAME[requiredStanding] or 8

    return reaction >= requiredReaction
end

-- Get all rewards for a faction
function ReputationHandler:GetFactionRewards(factionID)
    local cfg = HousingReputations and HousingReputations[factionID]
    if not cfg or not cfg.rewards then
        return {}
    end
    return cfg.rewards
end

-- Get renown rewards for a specific level (NEW API - Dragonflight+)
function ReputationHandler:GetRenownRewardsForLevel(factionID, renownLevel)
    if not C_MajorFactions or not C_MajorFactions.GetRenownRewardsForLevel then
        return {}
    end

    local rewards = C_MajorFactions.GetRenownRewardsForLevel(factionID, renownLevel)
    if not rewards then
        return {}
    end

    -- Filter for housing items if needed
    local housingRewards = {}
    for _, reward in ipairs(rewards) do
        -- Check if reward has an itemID and is a housing item
        if reward.itemID and reward.itemID > 0 then
            table.insert(housingRewards, {
                itemID = reward.itemID,
                renownLevel = renownLevel,
                rewardType = reward.rewardType,
                icon = reward.icon,
                name = reward.name,
            })
        end
    end

    return housingRewards
end

-- Get current renown level (NEW API - quick helper)
function ReputationHandler:GetCurrentRenownLevel(factionID)
    if not C_MajorFactions or not C_MajorFactions.GetCurrentRenownLevel then
        return 0
    end

    local level = C_MajorFactions.GetCurrentRenownLevel(factionID)
    return level or 0
end

-- Check if faction is complete (all rewards collected)
function ReputationHandler:IsFactionComplete(factionID)
    local cfg = HousingReputations and HousingReputations[factionID]
    if not cfg or not cfg.rewards or #cfg.rewards == 0 then
        return false
    end

    for _, reward in ipairs(cfg.rewards) do
        local itemID = reward.itemID
        if itemID and itemID > 0 then
            local collected = self:IsDecorCollected(itemID)
            if not collected then
                return false
            end
        end
    end

    return true
end

-- Get statistics
function ReputationHandler:GetStatistics(characterKey)
    local charKey = characterKey or currentCharacterKey

    if not HousingDB or not HousingDB.reputations or not HousingDB.reputations[charKey] then
        return {
            totalFactions = 0,
            scannedFactions = 0,
        }
    end

    local data = HousingDB.reputations[charKey]
    local scannedCount = 0
    for _ in pairs(data) do
        scannedCount = scannedCount + 1
    end

    return {
        totalFactions = #factionList,
        scannedFactions = scannedCount,
    }
end

-- Get items locked by reputation for a character
function ReputationHandler:GetLockedItems(characterKey)
    local charKey = characterKey or currentCharacterKey

    if not HousingVendorItemToFaction then
        return {}
    end

    local locked = {}
    for itemID, repInfo in pairs(HousingVendorItemToFaction) do
        if not self:MeetsRequirement(itemID, charKey) then
            table.insert(locked, {
                itemID = itemID,
                factionID = repInfo.factionID,
                requiredStanding = repInfo.requiredStanding,
            })
        end
    end

    return locked
end

-- Check if auto-scan should be triggered
function ReputationHandler:ShouldAutoScan()
    return self._shouldAutoScan or false
end

-- Clear auto-scan flag (called after auto-scan completes)
function ReputationHandler:ClearAutoScanFlag()
    self._shouldAutoScan = false
end

-- Make globally accessible
_G.HousingReputationHandler = ReputationHandler

-- Debug command
SLASH_HOUSINGREPDBG1 = "/hrepdbg"
SlashCmdList["HOUSINGREPDBG"] = function(msg)
    if msg == "count" then
        local count = 0
        local factions = {}
        for factionID, cfg in pairs(HousingReputations or {}) do
            count = count + 1
            local label = cfg.label or "?"
            factions[label] = (factions[label] or 0) + 1
        end
        print("Total HousingReputations entries: " .. count)
        for label, num in pairs(factions) do
            if num > 1 then
                print("  DUPLICATE: " .. label .. " appears " .. num .. " times")
            end
        end
    elseif msg == "test" then
        -- Test C_Reputation.GetFactionDataByID for Bilgewater Cartel (1133)
        if C_Reputation and C_Reputation.GetFactionDataByID then
            local fd = C_Reputation.GetFactionDataByID(1133)
            print("C_Reputation.GetFactionDataByID(1133):")
            if fd then
                print("  name=" .. tostring(fd.name))
                print("  reaction=" .. tostring(fd.reaction))
                print("  currentStanding=" .. tostring(fd.currentStanding))
                print("  currentReactionThreshold=" .. tostring(fd.currentReactionThreshold))
                print("  nextReactionThreshold=" .. tostring(fd.nextReactionThreshold))
            else
                print("  RETURNED NIL")
            end
        else
            print("C_Reputation.GetFactionDataByID NOT AVAILABLE")
        end
    end
end

return ReputationHandler
