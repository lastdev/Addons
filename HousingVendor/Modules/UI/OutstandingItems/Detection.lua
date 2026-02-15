
local _G = _G
local OutstandingItemsUI = _G["HousingOutstandingItemsUI"]
if not OutstandingItemsUI then return end

local function NormalizeFaction(value)
    if value == nil then
        return nil
    end
    if type(value) == "number" then
        if value == 1 then
            return "Alliance"
        elseif value == 2 then
            return "Horde"
        elseif value == 0 then
            return "Neutral"
        end
    end
    return value
end

local function VendorMatchesPlayerFaction(vendor)
    if not vendor then
        return true
    end
    local vendorFaction = NormalizeFaction(vendor.faction)
    if not vendorFaction or vendorFaction == "" or vendorFaction == "None" then
        return true
    end
    if vendorFaction == "Neutral" then
        return true
    end
    local playerFaction = UnitFactionGroup("player")
    return vendorFaction == playerFaction
end

local function GetBestZoneMapID()
    if not (C_Map and C_Map.GetBestMapForUnit) then
        return nil
    end

    local mapID = C_Map.GetBestMapForUnit("player")
    if not mapID then
        return nil
    end

    -- Refine to a child zone mapID when the best map is a parent.
    if C_Map.GetPlayerMapPosition and C_Map.GetMapInfoAtPosition then
        local posOk, pos = pcall(C_Map.GetPlayerMapPosition, mapID, "player")
        if not posOk then pos = nil end
        if pos and pos.x and pos.y and not (pos.x == 0 and pos.y == 0) then
            local ok, mapInfo = pcall(function()
                return C_Map.GetMapInfoAtPosition(mapID, pos)
            end)
            if ok and mapInfo and mapInfo.mapID then
                mapID = mapInfo.mapID
            end
        end
    end

    return mapID
end

function OutstandingItemsUI:GetOutstandingItemsForZone(mapID, zoneName)
    if (not mapID and not zoneName) or not HousingDataManager then
        return nil
    end

    -- Ensure vendor data is processed (populates HousingVendorPool and HousingItemVendorIndex)
    if _G.HousingDataAggregator and _G.HousingDataAggregator.ProcessPendingData then
        _G.HousingDataAggregator:ProcessPendingData()
    end

    -- CRASH FIX: Check if we can safely query collection status via Housing APIs.
    -- If not safe, we'll still show the zone popup but mark everything as "uncollected".
    local canCheckCollection = true
    local apiDisabled = HousingDB and HousingDB.settings and HousingDB.settings.disableApiCalls == true
    local catalogNotReady = not _G.HousingCatalogSafeToCall
    if apiDisabled or catalogNotReady then
        -- During early login (before the post-login delay), don't query Housing APIs.
        -- This prevents crashes.
        canCheckCollection = false
    end

    local ids = nil
    if HousingDataManager.GetAllItemIDs then
        ids = HousingDataManager:GetAllItemIDs()
    end
    if not ids or #ids == 0 then
        if HousingDataManager.GetAllItems then
            local allItems = HousingDataManager:GetAllItems()
            ids = {}
            for _, item in ipairs(allItems or {}) do
                local idNum = item and tonumber(item.itemID)
                if idNum then
                    ids[#ids + 1] = idNum
                end
            end
        end
    end
    if not ids or #ids == 0 then
        return nil
    end

    local outstanding = {
        total = 0,
        vendors = {},
        quests = {},
        achievements = {},
        drops = {},
        professions = {},
    }

    local function IsCollected(itemID)
        -- CRASH FIX: If we can't safely check collection status, assume not collected.
        -- This prevents calling Housing APIs before they're ready (which causes crashes),
        -- but keeps zone popups showing all potentially relevant items (vendors/quests/drops/etc).
        if not canCheckCollection then
            return false
        end

        -- Avoid placed-decor scans in popup context to prevent taint.
        if HousingCollectionAPI and HousingCollectionAPI.IsItemCollectedViaHousingAPI then
            return HousingCollectionAPI:IsItemCollectedViaHousingAPI(itemID)
        end
        if HousingCollectionAPI and HousingCollectionAPI.IsItemCollected then
            return HousingCollectionAPI:IsItemCollected(itemID)
        end
        -- Fallback to DataManager
        if HousingDataManager and HousingDataManager.IsItemCollected then
            return HousingDataManager:IsItemCollected(itemID)
        end
        -- Fallback to CompletionTracker
        if HousingCompletionTracker and HousingCompletionTracker.IsCollected then
            return HousingCompletionTracker:IsCollected(itemID)
        end
        return false
    end

    -- Import the availability check function
    local function IsItemAvailableByID(itemID)
        local idNum = tonumber(itemID)
        if not idNum then return false end

        -- DNT / DO NOT USE items should never appear in the addon UI.
        if _G.HousingDNTItems and _G.HousingDNTItems[idNum] then
            return false
        end

        -- Treat explicit "not released" flags as unavailable (these are curated by the addon).
        if _G.HousingNotReleased and _G.HousingNotReleased[idNum] then
            return false
        end

        -- Catalog validation: hide items whose decorID isn't in the current game catalog.
        if _G.HousingCatalogValidation and _G.HousingCatalogValidation.IsScanComplete
           and _G.HousingCatalogValidation:IsScanComplete()
           and not _G.HousingCatalogValidation:IsItemInCatalog(idNum) then
            return false
        end

        -- Items in HousingAllItems are assumed to exist; WoW item APIs can be uncached/unreliable
        -- and should not blank the UI.
        return true
    end

    for _, idNum in ipairs(ids) do
        -- Apply availability filter (same as main UI)
        if not IsItemAvailableByID(idNum) then
            -- Skip items that aren't currently available in game
        else
            local record = HousingDataManager.GetItemRecord and HousingDataManager:GetItemRecord(idNum) or nil
            if record then
                -- Get vendor's actual zone and coords using VendorHelper for accuracy
                local recordZone = nil
                local vendorMapID = nil
                local matchedVendor = nil
                
                -- Check VendorPool exists and is not empty before iterating
                -- This is the primary method for finding vendors in the current zone
                if mapID and record._vendorIndices and _G.HousingVendorPool and next(_G.HousingVendorPool) ~= nil then
                    for _, idx in ipairs(record._vendorIndices) do
                        local v = _G.HousingVendorPool[idx]
                        if v and v.coords and v.coords.mapID and v.coords.mapID == mapID and VendorMatchesPlayerFaction(v) then
                            matchedVendor = v
                            vendorMapID = v.coords.mapID
                            recordZone = v.location
                            break
                        end
                    end
                end
                
                -- Secondary: Use VendorHelper for zone-specific lookups (passes mapID for filtering)
                if _G.HousingVendorHelper and not matchedVendor then
                    recordZone = _G.HousingVendorHelper.GetZoneName and _G.HousingVendorHelper:GetZoneName(record, nil, mapID)
                    local vendorCoords = _G.HousingVendorHelper.GetVendorCoords and _G.HousingVendorHelper:GetVendorCoords(record, nil, nil, mapID)
                    if vendorCoords and vendorCoords.mapID then
                        vendorMapID = vendorCoords.mapID
                    end
                end
                
                -- Fallback if VendorHelper unavailable
                -- IMPORTANT: Only use record.mapID fallback if no vendor-specific mapID was found
                -- This prevents items from showing in wrong zones when they have multiple vendor locations
                if not recordZone then
                    recordZone = record._apiZone or record.zoneName
                end
                -- Only use record.mapID as fallback if we didn't find any vendor-specific mapID
                -- This prevents cross-zone pollution for multi-vendor items
                if not vendorMapID and not matchedVendor then
                    vendorMapID = record.mapID
                end
                
                local matchesZone = false
                -- Prioritize mapID matching for accuracy (prevents cross-zone pollution)
                if mapID and vendorMapID and vendorMapID ~= 0 then
                    -- Only match if mapIDs are exactly the same
                    if vendorMapID == mapID then
                        matchesZone = true
                    end
                elseif zoneName and recordZone then
                    -- Fallback to zone name matching when:
                    -- 1. Player mapID unavailable, OR
                    -- 2. Vendor mapID unavailable/zero (legacy data)
                    -- Note: This will fail with non-English clients if data is English,
                    -- but it's better than showing nothing for legacy items without mapID
                    if recordZone == zoneName then
                        matchesZone = true
                    end
                end
                
                if matchesZone then
                    local itemID = tonumber(record.itemID) or idNum
                    local isItemCollected = IsCollected(itemID)
                    
                    -- For quest/achievement items, also check if they're complete
                    local isQuestComplete = false
                    local isAchievementComplete = false
                    local src = record._sourceType or record.sourceType or "Vendor"
                    
                    if src == "Quest" then
                        local questID = record._questId or record.questRequired
                        if questID then
                            local numericQuestID = tonumber(questID)
                            -- If questID is text, try to extract numeric ID
                            if not numericQuestID and type(questID) == "string" then
                                numericQuestID = tonumber(string.match(questID, "%d+"))
                            end
                            if numericQuestID and C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted then
                                -- Wrap in pcall to handle invalid quest IDs gracefully
                                local ok, result = pcall(C_QuestLog.IsQuestFlaggedCompleted, numericQuestID)
                                if ok then
                                    isQuestComplete = result
                                end
                            end
                        end
                    elseif src == "Achievement" then
                        local achievementID = record._achievementId or record.achievementRequired
                        if achievementID then
                            local numericAchievementID = tonumber(achievementID)
                            -- If achievementID is text, try to extract numeric ID
                            if not numericAchievementID and type(achievementID) == "string" then
                                numericAchievementID = tonumber(string.match(achievementID, "%d+"))
                            end
                            if numericAchievementID and C_AchievementInfo and C_AchievementInfo.GetAchievementInfo then
                                -- Wrap in pcall to handle invalid achievement IDs gracefully
                                local ok, achievementInfo = pcall(C_AchievementInfo.GetAchievementInfo, numericAchievementID)
                                if ok and achievementInfo then
                                    isAchievementComplete = achievementInfo.completed or false
                                end
                            end
                        end
                    end
                    
                    -- Item is outstanding if it's not collected AND (if quest/achievement) not yet completed
                    local isOutstanding = not isItemCollected
                    if src == "Quest" and isQuestComplete then
                        isOutstanding = false  -- Quest is complete, item is obtainable
                    elseif src == "Achievement" and isAchievementComplete then
                        isOutstanding = false  -- Achievement is complete, item is obtainable
                    end
                    
                    if isOutstanding then
                        -- Categorize by source type (use _sourceType as authoritative)
                        if src == "Quest" then
                            table.insert(outstanding.quests, record)
                            outstanding.total = outstanding.total + 1
                        elseif src == "Achievement" then
                            table.insert(outstanding.achievements, record)
                            outstanding.total = outstanding.total + 1
                        elseif src == "Drop" then
                            table.insert(outstanding.drops, record)
                            outstanding.total = outstanding.total + 1
                        elseif src == "Profession" then
                            table.insert(outstanding.professions, record)
                            outstanding.total = outstanding.total + 1
                        else
                            -- Default to Vendor (includes items with _sourceType = "Vendor" or no _sourceType)
                            local vendorName = nil
                            local vendorCoords = nil
                            if matchedVendor then
                                vendorName = matchedVendor.name
                                vendorCoords = matchedVendor.coords
                            elseif _G.HousingVendorHelper then
                                vendorName = _G.HousingVendorHelper:GetVendorName(record, nil, nil, mapID)
                                vendorCoords = _G.HousingVendorHelper:GetVendorCoords(record, nil, nil, mapID)
                            else
                                vendorName = record.vendorName or record._apiVendor
                                vendorCoords = record.vendorCoords
                            end
                            
                            -- Use "Unknown Vendor" as fallback if no vendor name found
                            if not vendorName or vendorName == "" then
                                vendorName = "Unknown Vendor"
                            end
                            
                            local vendorKey = vendorName
                            if vendorMapID and vendorMapID ~= 0 then
                                vendorKey = vendorName .. "@" .. tostring(vendorMapID)
                            elseif record.npcID then
                                vendorKey = vendorName .. "#npc" .. tostring(record.npcID)
                            end
                            
                            -- Check if vendor is muted
                            local isMuted = false
                            if HousingDB and HousingDB.mutedVendors and HousingDB.mutedVendors[vendorKey] then
                                isMuted = true
                            end
                            
                            if not isMuted then
                                outstanding.total = outstanding.total + 1
                                local displayName = vendorName
                                if recordZone and recordZone ~= "" and vendorName ~= "Unknown Vendor" then
                                    displayName = vendorName .. " (" .. recordZone .. ")"
                                end
                                local entry = outstanding.vendors[vendorKey]
                                if not entry then
                                    entry = { name = displayName, baseName = vendorName, coords = vendorCoords, mapID = vendorMapID, npcID = record.npcID, items = {} }
                                    outstanding.vendors[vendorKey] = entry
                                end
                                table.insert(entry.items, record)
                            end
                        end
                    end
                end
            end
        end
    end

    return outstanding
end

-- Debug function to check a specific item's vendor data
function OutstandingItemsUI:DebugItem(itemID)
    local idNum = tonumber(itemID)
    if not idNum then
        print("|cFFFF4040HousingVendor:|r Invalid itemID")
        return
    end

    -- Ensure vendor data is processed
    if _G.HousingDataAggregator and _G.HousingDataAggregator.ProcessPendingData then
        _G.HousingDataAggregator:ProcessPendingData()
    end

    print("|cFF8A7FD4HousingVendor:|r Debugging item " .. idNum)

    -- Check HousingItemVendorIndex directly
    local vendorIndices = _G.HousingItemVendorIndex and _G.HousingItemVendorIndex[idNum]
    print("  HousingItemVendorIndex[" .. idNum .. "] = " .. (vendorIndices and (#vendorIndices .. " indices") or "nil"))

    if vendorIndices then
        for i, idx in ipairs(vendorIndices) do
            local v = _G.HousingVendorPool and _G.HousingVendorPool[idx]
            if v then
                print(string.format("    [%d] idx=%d name=%s mapID=%s faction=%s",
                    i, idx, tostring(v.name), tostring(v.coords and v.coords.mapID), tostring(v.faction)))
            else
                print(string.format("    [%d] idx=%d - NOT FOUND in VendorPool", i, idx))
            end
        end
    end

    -- Check record from DataManager
    if HousingDataManager then
        local record = HousingDataManager:GetItemRecord(idNum)
        if record then
            print("  DataManager record exists: name=" .. tostring(record.name))
            print("    _vendorIndices = " .. (record._vendorIndices and (#record._vendorIndices .. " indices") or "nil"))
            print("    _sourceType = " .. tostring(record._sourceType))
        else
            print("  DataManager record = nil")
        end
    end
end

-- Debug function to check why specific items aren't showing for a vendor
function OutstandingItemsUI:DebugVendorItems(vendorName, targetMapID)
    if not HousingDataManager then
        print("|cFFFF4040HousingVendor:|r DebugVendorItems: DataManager not available")
        return
    end

    -- Ensure vendor data is processed
    if _G.HousingDataAggregator and _G.HousingDataAggregator.ProcessPendingData then
        _G.HousingDataAggregator:ProcessPendingData()
    end

    local ids = HousingDataManager.GetAllItemIDs and HousingDataManager:GetAllItemIDs() or {}
    local matchCount = 0
    local collectedCount = 0
    local zoneMatchCount = 0

    print("|cFF8A7FD4HousingVendor:|r Checking items for vendor: " .. tostring(vendorName) .. " in mapID " .. tostring(targetMapID))

    -- Import the availability check function for debug functions
    local function IsItemAvailableByID(itemID)
        local idNum = tonumber(itemID)
        if not idNum then return false end

        -- DNT / DO NOT USE items should never appear in the addon UI.
        if _G.HousingDNTItems and _G.HousingDNTItems[idNum] then
            return false
        end

        -- Treat explicit "not released" flags as unavailable (these are curated by the addon).
        if _G.HousingNotReleased and _G.HousingNotReleased[idNum] then
            return false
        end

        -- Catalog validation: hide items whose decorID isn't in the current game catalog.
        if _G.HousingCatalogValidation and _G.HousingCatalogValidation.IsScanComplete
           and _G.HousingCatalogValidation:IsScanComplete()
           and not _G.HousingCatalogValidation:IsItemInCatalog(idNum) then
            return false
        end

        -- Items in HousingAllItems are assumed to exist; WoW item APIs can be uncached/unreliable
        -- and should not blank the UI.
        return true
    end

    for _, idNum in ipairs(ids) do
        -- Apply availability filter (same as main UI)
        if not IsItemAvailableByID(idNum) then
            -- Skip items that aren't currently available in game
        else
            local record = HousingDataManager:GetItemRecord(idNum)
            if record and record._vendorIndices and _G.HousingVendorPool then
                for _, idx in ipairs(record._vendorIndices) do
                    local v = _G.HousingVendorPool[idx]
                    if v and v.name and v.name:find(vendorName) then
                        matchCount = matchCount + 1
                        local vendorMapID = v.coords and v.coords.mapID or 0
                        local isCollected = false
                        if HousingCollectionAPI and HousingCollectionAPI.IsItemCollected then
                            local ok, result = pcall(HousingCollectionAPI.IsItemCollected, HousingCollectionAPI, idNum)
                            if ok then isCollected = result end
                        end
                        if isCollected then
                            collectedCount = collectedCount + 1
                        end
                        local matchesZone = (vendorMapID == targetMapID)
                        if matchesZone then
                            zoneMatchCount = zoneMatchCount + 1
                        end
                        if matchCount <= 10 then
                            print(string.format("  item=%d mapID=%d collected=%s zoneMatch=%s",
                                idNum, vendorMapID, isCollected and "yes" or "no", matchesZone and "yes" or "no"))
                        end
                        break
                    end
                end
            end
        end
    end

    print(string.format("|cFF8A7FD4Result:|r total=%d zoneMatch=%d collected=%d uncollected=%d",
        matchCount, zoneMatchCount, collectedCount, matchCount - collectedCount))
end

function OutstandingItemsUI:DebugZoneSummary(mapID, zoneName, sampleLimit)
    if (not mapID and not zoneName) or not HousingDataManager then
        print("|cFFFF4040HousingVendor:|r Zone debug: missing mapID/zone or DataManager")
        return
    end

    local ids = nil
    if HousingDataManager.GetAllItemIDs then
        ids = HousingDataManager:GetAllItemIDs()
    end
    if not ids or #ids == 0 then
        print("|cFFFF4040HousingVendor:|r Zone debug: no item IDs available")
        return
    end

    local function IsCollected(itemID)
        if HousingCollectionAPI and HousingCollectionAPI.IsItemCollected then
            return HousingCollectionAPI:IsItemCollected(itemID)
        end
        if HousingDataManager and HousingDataManager.IsItemCollected then
            return HousingDataManager:IsItemCollected(itemID)
        end
        return false
    end

    local total = 0
    local matchedZone = 0
    local collected = 0
    local outstanding = 0
    local sample = {}
    local limit = tonumber(sampleLimit) or 5

    for _, idNum in ipairs(ids) do
        total = total + 1
        -- Apply availability filter (same as main UI)
        if not IsItemAvailableByID(idNum) then
            -- Skip items that aren't currently available in game
        else
            local record = HousingDataManager.GetItemRecord and HousingDataManager:GetItemRecord(idNum) or nil
            if record then
                local recordZone = nil
                local vendorMapID = nil
                local matchedVendor = nil
                
                -- Check VendorPool exists and is not empty before iterating
                if mapID and record._vendorIndices and _G.HousingVendorPool and next(_G.HousingVendorPool) ~= nil then
                    for _, idx in ipairs(record._vendorIndices) do
                        local v = _G.HousingVendorPool[idx]
                        if v and v.coords and v.coords.mapID and v.coords.mapID == mapID and VendorMatchesPlayerFaction(v) then
                            matchedVendor = v
                            vendorMapID = v.coords.mapID
                            recordZone = v.location
                            break
                        end
                    end
                end
                
                if _G.HousingVendorHelper and not matchedVendor then
                    recordZone = _G.HousingVendorHelper.GetZoneName and _G.HousingVendorHelper:GetZoneName(record, nil, mapID)
                    local vendorCoords = _G.HousingVendorHelper.GetVendorCoords and _G.HousingVendorHelper:GetVendorCoords(record, nil, nil, mapID)
                    if vendorCoords and vendorCoords.mapID then
                        vendorMapID = vendorCoords.mapID
                    end
                end
                
                if not recordZone then
                    recordZone = record._apiZone or record.zoneName
                end
                -- Only use record.mapID as fallback if we didn't find any vendor-specific mapID
                if not vendorMapID and not matchedVendor then
                    vendorMapID = record.mapID
                end
                
                local matchesZone = false
                if mapID and vendorMapID and vendorMapID ~= 0 then
                    if vendorMapID == mapID then
                        matchesZone = true
                    end
                elseif zoneName and recordZone then
                    if recordZone == zoneName then
                        matchesZone = true
                    end
                end
                
                if matchesZone then
                    matchedZone = matchedZone + 1
                    local itemID = tonumber(record.itemID) or idNum
                    local isCollected = IsCollected(itemID)
                    if isCollected then
                        collected = collected + 1
                    else
                        outstanding = outstanding + 1
                    end
                    
                    if #sample < limit then
                        local vendorName = nil
                        if matchedVendor then
                            vendorName = matchedVendor.name
                        elseif _G.HousingVendorHelper then
                            vendorName = _G.HousingVendorHelper:GetVendorName(record, nil, nil, mapID)
                        else
                            vendorName = record.vendorName or record._apiVendor
                        end
                        sample[#sample + 1] = {
                            itemID = itemID,
                            vendor = vendorName or "Unknown",
                            mapID = vendorMapID or 0,
                            zone = recordZone or "Unknown",
                            collected = isCollected and "yes" or "no",
                        }
                    end
                end
            end
        end
    end
    
    print(string.format("|cFF8A7FD4HousingVendor Zone Debug:|r total=%d matched=%d outstanding=%d collected=%d",
        total, matchedZone, outstanding, collected))
    for _, s in ipairs(sample) do
        print(string.format("  item=%s vendor=%s mapID=%s zone=%s collected=%s",
            tostring(s.itemID), tostring(s.vendor), tostring(s.mapID), tostring(s.zone), tostring(s.collected)))
    end
end

return OutstandingItemsUI
