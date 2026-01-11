-- OutstandingItems Sub-module: Detection logic
-- Part of HousingOutstandingItemsUI

local _G = _G
local OutstandingItemsUI = _G["HousingOutstandingItemsUI"]
if not OutstandingItemsUI then return end

function OutstandingItemsUI:GetCurrentZone()
    local mapID = C_Map and C_Map.GetBestMapForUnit and C_Map.GetBestMapForUnit("player") or nil
    if mapID and C_Map and C_Map.GetMapInfo then
        local mapInfo = C_Map.GetMapInfo(mapID)
        if mapInfo and mapInfo.name and mapInfo.name ~= "" then
            return mapID, mapInfo.name
        end
    end

    local fallbackName = _G.GetRealZoneText and _G.GetRealZoneText() or nil
    if fallbackName and fallbackName ~= "" then
        return nil, fallbackName
    end

    return nil, nil
end

function OutstandingItemsUI:GetOutstandingItemsForZone(mapID, zoneName)
    if (not mapID and not zoneName) or not HousingDataManager then
        return nil
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
        -- Use HousingCollectionAPI which has robust multi-method collection detection
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

    for _, idNum in ipairs(ids) do
        local record = HousingDataManager.GetItemRecord and HousingDataManager:GetItemRecord(idNum) or nil
        if record then
            -- Get vendor's actual zone and coords using VendorHelper for accuracy
            local recordZone = nil
            local vendorMapID = nil

            if _G.HousingVendorHelper then
                recordZone = _G.HousingVendorHelper.GetZoneName and _G.HousingVendorHelper:GetZoneName(record, nil)
                local vendorCoords = _G.HousingVendorHelper.GetVendorCoords and _G.HousingVendorHelper:GetVendorCoords(record, nil)
                if vendorCoords and vendorCoords.mapID then
                    vendorMapID = vendorCoords.mapID
                end
            end

            -- Fallback if VendorHelper unavailable
            -- Prefer _apiZone (localized) over zoneName (English) for zone matching
            if not recordZone then
                recordZone = record._apiZone or record.zoneName
            end
            if not vendorMapID then
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
                            isQuestComplete = C_QuestLog.IsQuestFlaggedCompleted(numericQuestID)
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
                            local achievementInfo = C_AchievementInfo.GetAchievementInfo(numericAchievementID)
                            if achievementInfo then
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
                    outstanding.total = outstanding.total + 1

                    -- Categorize by source type (use _sourceType as authoritative)
                    if src == "Quest" then
                        table.insert(outstanding.quests, record)
                    elseif src == "Achievement" then
                        table.insert(outstanding.achievements, record)
                    elseif src == "Drop" then
                        table.insert(outstanding.drops, record)
                    elseif src == "Profession" then
                        table.insert(outstanding.professions, record)
                    else
                        -- Default to Vendor (includes items with _sourceType = "Vendor" or no _sourceType)
                        local vendorName = nil
                        local vendorCoords = nil
                        if _G.HousingVendorHelper then
                            vendorName = _G.HousingVendorHelper:GetVendorName(record, nil)
                            vendorCoords = _G.HousingVendorHelper:GetVendorCoords(record, nil)
                        else
                            vendorName = record.vendorName or record._apiVendor
                            vendorCoords = record.vendorCoords
                        end

                        if vendorName and vendorName ~= "" then
                            local entry = outstanding.vendors[vendorName]
                            if not entry then
                                entry = { name = vendorName, coords = vendorCoords, items = {} }
                                outstanding.vendors[vendorName] = entry
                            end
                            table.insert(entry.items, record)
                        end
                    end
                end
            end
        end
    end

    return outstanding
end

return OutstandingItemsUI

