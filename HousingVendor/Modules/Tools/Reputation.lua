-- Reputation tracking and checking module for HousingVendor
local addonName, addon = ...

local HVRep = {}
addon.Reputation = HVRep

-- Saved variables
HousingVendorRepDB = HousingVendorRepDB or {}

-------------------------------------------------------
-- Initialize Settings
-------------------------------------------------------
local function EnsureSettings()
    HousingVendorRepDB = HousingVendorRepDB or {}
    
    local settings = HousingVendorRepDB.settings
    if not settings then
        settings = {
            accountWide = true,
            trackCompleted = true
        }
        HousingVendorRepDB.settings = settings
    end
    
    -- Account-wide cache of purchased items
    HousingVendorRepDB.purchasedItems = HousingVendorRepDB.purchasedItems or {}
    
    -- Character reputation snapshots
    HousingVendorRepDB.chars = HousingVendorRepDB.chars or {}
end

EnsureSettings()

-------------------------------------------------------
-- Character Key Helper
-------------------------------------------------------
local function GetCharKey()
    local name, realm = UnitName("player"), GetRealmName()
    return string.format("%s-%s", name or "Unknown", realm or "Unknown")
end

-------------------------------------------------------
-- Reputation Snapshot (Account-wide tracking)
-------------------------------------------------------
function HVRep.SnapshotReputation()
    if not HousingReputations then
        return
    end
    
    EnsureSettings()
    local key = GetCharKey()
    local entry = HousingVendorRepDB.chars[key] or {}
    entry.faction = UnitFactionGroup("player")
    entry.lastSeen = time()
    entry.reps = entry.reps or {}
    
    for factionID, cfg in pairs(HousingReputations) do
        local rec = entry.reps[factionID] or { rep = cfg.rep }
        
        if cfg.rep == "renown" then
            -- Renown-based reputation (Dragonflight, TWW)
            if C_MajorFactions and C_MajorFactions.GetMajorFactionData then
                local data = C_MajorFactions.GetMajorFactionData(factionID)
                if data then
                    rec.renownLevel = data.renownLevel or 0
                end
            end
            
        elseif cfg.rep == "friendship" then
            -- Friendship reputation (Tillers, etc.)
            if C_GossipInfo and C_GossipInfo.GetFriendshipReputation then
                local info = C_GossipInfo.GetFriendshipReputation(factionID)
                if info then
                    rec.standing = info.standing or info.friendshipReaction or 0
                    rec.reactionText = info.reaction or info.friendshipText
                end
            end
            
        else
            -- Standard faction reputation (Classic, TBC, etc.)
            if C_Reputation and C_Reputation.GetFactionDataByID then
                local data = C_Reputation.GetFactionDataByID(factionID)
                if data then
                    rec.reaction = data.reaction or 0
                    rec.current = data.currentStanding or 0
                    rec.currentThreshold = data.currentReactionThreshold or 0
                    rec.nextThreshold = data.nextReactionThreshold or 0
                end
            end
        end
        
        entry.reps[factionID] = rec
    end
    
    HousingVendorRepDB.chars[key] = entry
end

-------------------------------------------------------
-- Get Best Reputation Across Account
-------------------------------------------------------
local function CompareRepRecords(cfg, a, b)
    if not a then return false end
    if not b then return true end
    
    if cfg.rep == "renown" then
        return (a.renownLevel or 0) > (b.renownLevel or 0)
    elseif cfg.rep == "friendship" then
        return (a.standing or 0) > (b.standing or 0)
    else
        local ra, rb = a.reaction or 0, b.reaction or 0
        if ra ~= rb then
            return ra > rb
        end
        return (a.current or 0) > (b.current or 0)
    end
end

function HVRep.GetBestRepRecord(factionID)
    if not HousingVendorRepDB or not HousingVendorRepDB.chars then
        return nil, nil
    end
    
    local cfg = HousingReputations and HousingReputations[factionID]
    if not cfg then
        return nil, nil
    end
    
    local bestRec, bestCharKey
    
    for charKey, data in pairs(HousingVendorRepDB.chars) do
        local rec = data.reps and data.reps[factionID]
        if rec and CompareRepRecords(cfg, rec, bestRec) then
            bestRec = rec
            bestCharKey = charKey
        end
    end
    
    return bestRec, bestCharKey
end

-------------------------------------------------------
-- Check If Item is Unlocked (Rep Requirement Met)
-------------------------------------------------------
local REACTION_FROM_NAME = {
    Neutral = 4,
    Friendly = 5,
    Honored = 6,
    Revered = 7,
    Exalted = 8
}

local function ParseRenownRequired(requiredStanding)
    if not requiredStanding then return nil end
    local num = requiredStanding:match("Renown%s+(%d+)")
    return num and tonumber(num) or nil
end

function HVRep.IsItemUnlocked(itemID)
    if not itemID or not HousingVendorItemToFaction then
        return true -- No rep requirement
    end
    
    local repInfo = HousingVendorItemToFaction[itemID]
    if not repInfo then
        return true -- No rep requirement
    end
    
    local factionID = repInfo.factionID
    local requiredStanding = repInfo.requiredStanding
    local cfg = HousingReputations[factionID]
    
    if not cfg then
        return true
    end
    
    -- Get best rep (account-wide or current char)
    local useAccountWide = HousingVendorRepDB.settings and HousingVendorRepDB.settings.accountWide
    local bestRec
    
    if useAccountWide then
        bestRec = HVRep.GetBestRepRecord(factionID)
    else
        -- Use current character only
        local charKey = GetCharKey()
        local charData = HousingVendorRepDB.chars[charKey]
        bestRec = charData and charData.reps and charData.reps[factionID]
    end
    
    if not bestRec then
        return false
    end
    
    -- Check based on reputation type
    if cfg.rep == "renown" then
        local requiredRenown = ParseRenownRequired(requiredStanding) or 0
        return (bestRec.renownLevel or 0) >= requiredRenown
        
    elseif cfg.rep == "friendship" then
        return (bestRec.standing or 0) > 0
        
    else
        -- Standard reputation
        local requiredReaction = REACTION_FROM_NAME[requiredStanding] or 8
        return (bestRec.reaction or 0) >= requiredReaction
    end
end

-------------------------------------------------------
-- Get Reputation Progress String
-------------------------------------------------------
function HVRep.GetRepProgress(itemID)
    if not itemID or not HousingVendorItemToFaction then
        return nil, nil
    end
    
    local repInfo = HousingVendorItemToFaction[itemID]
    if not repInfo then
        return nil, nil
    end
    
    local factionID = repInfo.factionID
    local requiredStanding = repInfo.requiredStanding
    local cfg = HousingReputations[factionID]
    
    if not cfg then
        return nil, nil
    end
    
    local current = "Unknown"
    
    if cfg.rep == "renown" then
        if C_MajorFactions and C_MajorFactions.GetMajorFactionData then
            local data = C_MajorFactions.GetMajorFactionData(factionID)
            if data and data.renownLevel then
                current = string.format("Renown %d", data.renownLevel)
            end
        end
        
    elseif cfg.rep == "friendship" then
        if C_GossipInfo and C_GossipInfo.GetFriendshipReputation then
            local info = C_GossipInfo.GetFriendshipReputation(factionID)
            if info then
                current = info.reaction or info.friendshipText or "Unknown"
            end
        end
        
    else
        if C_Reputation and C_Reputation.GetFactionDataByID then
            local data = C_Reputation.GetFactionDataByID(factionID)
            if data and data.reaction then
                current = _G["FACTION_STANDING_LABEL" .. data.reaction] or "Unknown"
            end
        end
    end
    
    return current, requiredStanding
end

-------------------------------------------------------
-- Collection Tracking via C_HousingCatalog
-------------------------------------------------------
local housingCatalogPrimed = false

local function PrimeHousingCatalog()
    if housingCatalogPrimed or not C_HousingCatalog then
        return
    end
    
    if C_HousingCatalog.CreateCatalogSearcher then
        pcall(C_HousingCatalog.CreateCatalogSearcher)
    end
    
    housingCatalogPrimed = true
end

function HVRep.IsItemCollected(itemID)
    if not itemID or itemID <= 0 then
        return nil, nil
    end
    
    EnsureSettings()
    local purchasedItems = HousingVendorRepDB.purchasedItems
    
    -- Check cache first
    if purchasedItems[itemID] then
        return true, nil
    end
    
    -- Query housing catalog
    if not C_HousingCatalog or not C_HousingCatalog.GetCatalogEntryInfoByItem then
        return nil, nil
    end
    
    PrimeHousingCatalog()
    
    local ok, state = pcall(C_HousingCatalog.GetCatalogEntryInfoByItem, itemID, true)
    if not ok or not state then
        return nil, nil
    end
    
    local stored = state.numStored or 0
    local placed = state.numPlaced or 0
    local sum = stored + placed
    
    -- Guard against overflow
    if sum > 0 and sum < 1000000 then
        purchasedItems[itemID] = true
        return true, sum
    elseif sum == 0 then
        return false, 0
    end
    
    return nil, nil
end

function HVRep.MarkItemCollected(itemID)
    if not itemID or itemID <= 0 then
        return
    end
    
    EnsureSettings()
    HousingVendorRepDB.purchasedItems[itemID] = true
end

-------------------------------------------------------
-- Get Reputation Info for Item
-------------------------------------------------------
function HVRep.GetItemRepInfo(itemID)
    if not itemID or not HousingVendorItemToFaction then
        return nil
    end
    
    local repInfo = HousingVendorItemToFaction[itemID]
    if not repInfo then
        return nil
    end
    
    local cfg = HousingVendorRepData[repInfo.factionID]
    if not cfg then
        return nil
    end
    
    return {
        factionID = repInfo.factionID,
        factionName = cfg.label,
        requiredStanding = repInfo.requiredStanding,
        faction = cfg.faction,
        rep = cfg.rep,
        expansion = cfg.expansion,
        vendor = cfg.vendor
    }
end

-------------------------------------------------------
-- Events
-------------------------------------------------------
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:RegisterEvent("PLAYER_LOGOUT")

eventFrame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_LOGIN" or event == "PLAYER_ENTERING_WORLD" then
        EnsureSettings()
        HVRep.SnapshotReputation()
        
    elseif event == "PLAYER_LOGOUT" then
        HVRep.SnapshotReputation()
    end
end)
