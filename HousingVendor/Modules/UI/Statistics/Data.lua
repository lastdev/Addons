-- Statistics Sub-module: Data computation
-- Part of HousingStatisticsUI

local _G = _G
local StatisticsUI = _G["HousingStatisticsUI"]
if not StatisticsUI then return end

function StatisticsUI:CalculateStats()
    if not HousingDataManager then
        return nil
    end

    local allItems = HousingDataManager:GetAllItems()

    local stats = {
        total = #allItems,
        collected = 0,
        missing = 0,

        -- By Source with collected/total
        bySource = {
            Achievement = {total = 0, collected = 0, missing = 0, free = 0, goldCost = 0, currencyCost = 0},
            Quest = {total = 0, collected = 0, missing = 0, free = 0, goldCost = 0, currencyCost = 0},
            Drop = {total = 0, collected = 0, missing = 0, free = 0, goldCost = 0, currencyCost = 0},
            Vendor = {total = 0, collected = 0, missing = 0, free = 0, goldCost = 0, currencyCost = 0},
            Profession = {total = 0, collected = 0, missing = 0}
        },

        -- By Expansion with collected/total split by source
        byExpansion = {},

        -- By Category with collected/total split by source
        byCategory = {},

        -- By Faction with collected/total
        byFaction = {
            Horde = {total = 0, collected = 0, missing = 0},
            Alliance = {total = 0, collected = 0, missing = 0},
            Neutral = {total = 0, collected = 0, missing = 0}
        },

        -- By Profession
        byProfession = {},

        -- By Quality/Rarity
        byQuality = {},

        -- Housing inventory stats (from API)
        housingInventory = {
            totalStored = 0,
            totalPlaced = 0,
            itemsWithData = 0
        },

        -- Travel statistics
        travelStats = {
            uniqueLocations = 0,
            locationsByZone = {},
            totalVendors = 0,
            vendorsByExpansion = {}
        },

        -- Vendor-level breakdown (vendor items only)
        byVendor = {},

        -- Price statistics
        totalValue = {gold = 0, items = 0},
        collectedValue = {gold = 0, items = 0},
        missingValue = {gold = 0, items = 0},
        priceRanges = {
            free = {total = 0, collected = 0},
            cheap = {total = 0, collected = 0, min = 1, max = 100},      -- 1-100g
            moderate = {total = 0, collected = 0, min = 101, max = 1000},  -- 101-1000g
            expensive = {total = 0, collected = 0, min = 1001, max = 10000}, -- 1001-10000g
            luxury = {total = 0, collected = 0, min = 10001}               -- 10000g+
        },

        -- Currency statistics
        byCurrency = {},

        -- Most expensive uncollected items
        expensiveMissing = {},

        -- Easy wins (free/cheap uncollected items)
        easyWins = {},

        -- Achievement tracking statistics
        achievementStats = {
            totalAchievements = 0,
            achievementsCompleted = 0,
            achievementsIncomplete = 0,
            totalPoints = 0,
            earnedPoints = 0,
            itemsFromAchievements = 0,
            byExpansion = {}
        },

        -- Quest tracking statistics
        questStats = {
            totalQuests = 0,
            questsCompleted = 0,
            questsIncomplete = 0,
            itemsFromQuests = 0,
            byExpansion = {}
        },

        -- "Unlocked" but not collected yet (requirements met via quest/achievement)
        readyMissing = 0,
        lockedMissing = 0,
        readyBy = {Achievement = 0, Quest = 0},
        readyItems = {}
    }

    local achievementCompletion = {}
    local achievementInfoCache = {}
    local questCompletion = {}

    local function FormatAchievementDate(month, day, year)
        month = tonumber(month)
        day = tonumber(day)
        year = tonumber(year)
        if not month or not day or not year then return nil end
        if month < 1 or month > 12 then return nil end
        if day < 1 or day > 31 then return nil end
        if year > 0 and year < 100 then
            year = 2000 + year
        end
        if year < 1900 then return nil end
        return string.format("%02d/%02d/%04d", month, day, year)
    end

    local function GetAchievementDateText(achInfo)
        if type(achInfo) ~= "table" then return nil end
        if achInfo.dateCompleted and type(achInfo.dateCompleted) == "string" and achInfo.dateCompleted ~= "" then
            return achInfo.dateCompleted
        end
        return FormatAchievementDate(achInfo.month, achInfo.day, achInfo.year)
    end

    local function GetAchievementInfoCached(achievementID)
        local cached = achievementInfoCache[achievementID]
        if cached ~= nil then
            return cached
        end

        local info = nil
        if C_AchievementInfo and C_AchievementInfo.GetAchievementInfo then
            local ok, result = pcall(C_AchievementInfo.GetAchievementInfo, achievementID)
            if ok then
                info = result
            end
        end

        achievementInfoCache[achievementID] = info
        return info
    end

    local function IsAchievementCompleted(achievementID)
        local cached = achievementCompletion[achievementID]
        if cached ~= nil then
            local info = GetAchievementInfoCached(achievementID)
            local dateText = nil
            if cached then
                dateText = GetAchievementDateText(info)
            end
            return cached, info, dateText
        end

        local completed = false
        local info = GetAchievementInfoCached(achievementID)
        if type(info) == "table" and info.completed ~= nil then
            completed = info.completed and true or false
        end

        achievementCompletion[achievementID] = completed
        local dateText = nil
        if completed then
            dateText = GetAchievementDateText(info)
        end
        return completed, info, dateText
    end

    local function IsQuestCompleted(questID)
        local cached = questCompletion[questID]
        if cached ~= nil then
            return cached
        end

        local completed = false
        if C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted then
            local ok, isCompleted = pcall(C_QuestLog.IsQuestFlaggedCompleted, questID)
            if ok then
                completed = isCompleted and true or false
            end
        end

        questCompletion[questID] = completed
        return completed
    end
    
    for _, item in ipairs(allItems) do
        local itemID = tonumber(item.itemID)
        local isCollected = false
        
        -- First check: Do we have quantity data showing ownership? (owned = collected)
        local numStored = item._apiNumStored or 0
        local numPlaced = item._apiNumPlaced or 0
        local totalOwned = numStored + numPlaced
        
        if totalOwned > 0 then
            isCollected = true
        elseif itemID and HousingCollectionAPI then
            -- Fallback: Check via HousingCollectionAPI (for items without quantity data yet)
            isCollected = HousingCollectionAPI:IsItemCollected(itemID)
        end
        
        if isCollected then
            stats.collected = stats.collected + 1
        else
            stats.missing = stats.missing + 1
        end
        
        -- Determine source type
        local sourceType = "Vendor"
        if item._isProfessionItem then
            sourceType = "Profession"
        elseif item.achievementRequired and item.achievementRequired ~= "" then
            sourceType = "Achievement"
        elseif item.questRequired and item.questRequired ~= "" then
            sourceType = "Quest"
        elseif item.dropSource and item.dropSource ~= "" then
            sourceType = "Drop"
        end

        local goldValue = (item.price and item.price > 0) and item.price or 0

        -- Determine whether the item is "unlocked" (requirements met) even if not collected yet.
        -- This is intentionally separate from "collected", because some requirements are account-wide.
        local hasRequirement = false
        local isUnlocked = true
        local unlockedByAchievement = nil
        local unlockedByQuest = nil
        local unlockedAchievementDate = nil

        if item._achievementId then
            hasRequirement = true
            local completed, _, dateText = IsAchievementCompleted(item._achievementId)
            unlockedByAchievement = completed
            unlockedAchievementDate = dateText
            isUnlocked = isUnlocked and unlockedByAchievement
        end
        if item._questId then
            hasRequirement = true
            unlockedByQuest = IsQuestCompleted(item._questId)
            isUnlocked = isUnlocked and unlockedByQuest
        end
        if not hasRequirement then
            isUnlocked = true
        end

        -- Update source stats
        local sourceStats = stats.bySource[sourceType]
        if sourceStats then
            sourceStats.total = sourceStats.total + 1
            if isCollected then
                sourceStats.collected = sourceStats.collected + 1
            else
                sourceStats.missing = sourceStats.missing + 1
            end

            -- Count by cost type for this source (only for sources that track cost breakdown)
            if sourceStats.free then
                if item.currency and item.currency ~= "" then
                    sourceStats.currencyCost = sourceStats.currencyCost + 1
                elseif item.price and item.price > 0 then
                    sourceStats.goldCost = sourceStats.goldCost + 1
                else
                    sourceStats.free = sourceStats.free + 1
                end
            end
        end
        
        -- Track by expansion
        local expName = item.expansionName or "Other"
        if not stats.byExpansion[expName] then
            stats.byExpansion[expName] = {
                total = 0, collected = 0, missing = 0,
                bySource = {
                    Achievement = {total = 0, collected = 0},
                    Quest = {total = 0, collected = 0},
                    Drop = {total = 0, collected = 0},
                    Vendor = {total = 0, collected = 0},
                    Profession = {total = 0, collected = 0}
                }
            }
        end
        stats.byExpansion[expName].total = stats.byExpansion[expName].total + 1
        if stats.byExpansion[expName].bySource[sourceType] then
            stats.byExpansion[expName].bySource[sourceType].total = stats.byExpansion[expName].bySource[sourceType].total + 1
        end

        if isCollected then
            stats.byExpansion[expName].collected = stats.byExpansion[expName].collected + 1
            if stats.byExpansion[expName].bySource[sourceType] then
                stats.byExpansion[expName].bySource[sourceType].collected = stats.byExpansion[expName].bySource[sourceType].collected + 1
            end
        else
            stats.byExpansion[expName].missing = stats.byExpansion[expName].missing + 1
        end
        
        -- Track by category
        local catName = item.category or "Uncategorized"
        if not stats.byCategory[catName] then
            stats.byCategory[catName] = {
                total = 0, collected = 0, missing = 0,
                bySource = {
                    Achievement = {total = 0, collected = 0},
                    Quest = {total = 0, collected = 0},
                    Drop = {total = 0, collected = 0},
                    Vendor = {total = 0, collected = 0},
                    Profession = {total = 0, collected = 0}
                }
            }
        end
        stats.byCategory[catName].total = stats.byCategory[catName].total + 1
        if stats.byCategory[catName].bySource[sourceType] then
            stats.byCategory[catName].bySource[sourceType].total = stats.byCategory[catName].bySource[sourceType].total + 1
        end

        if isCollected then
            stats.byCategory[catName].collected = stats.byCategory[catName].collected + 1
            if stats.byCategory[catName].bySource[sourceType] then
                stats.byCategory[catName].bySource[sourceType].collected = stats.byCategory[catName].bySource[sourceType].collected + 1
            end
        else
            stats.byCategory[catName].missing = stats.byCategory[catName].missing + 1
        end
        
        -- Track by faction
        local faction = item.faction or "Neutral"
        if faction == "Horde" or faction == "Alliance" or faction == "Neutral" then
            local factionStats = stats.byFaction[faction]
            factionStats.total = factionStats.total + 1
            if isCollected then
                factionStats.collected = factionStats.collected + 1
            else
                factionStats.missing = factionStats.missing + 1
            end
        end
        
        -- Track by profession (for profession items)
        if item._isProfessionItem and item.profession then
            local profName = item.profession
            if not stats.byProfession[profName] then
                stats.byProfession[profName] = {total = 0, collected = 0, missing = 0}
            end
            stats.byProfession[profName].total = stats.byProfession[profName].total + 1
            if isCollected then
                stats.byProfession[profName].collected = stats.byProfession[profName].collected + 1
            else
                stats.byProfession[profName].missing = stats.byProfession[profName].missing + 1
            end
        end

        -- Track by quality (from API data)
        if item.quality then
            local qualityName = item.qualityName or "Unknown"
            if not stats.byQuality[qualityName] then
                stats.byQuality[qualityName] = {total = 0, collected = 0, missing = 0, quality = item.quality}
            end
            stats.byQuality[qualityName].total = stats.byQuality[qualityName].total + 1
            if isCollected then
                stats.byQuality[qualityName].collected = stats.byQuality[qualityName].collected + 1
            else
                stats.byQuality[qualityName].missing = stats.byQuality[qualityName].missing + 1
            end
        end

        -- Track housing inventory data (from API)
        if item._apiNumStored or item._apiNumPlaced then
            stats.housingInventory.itemsWithData = stats.housingInventory.itemsWithData + 1
            if item._apiNumStored then
                stats.housingInventory.totalStored = stats.housingInventory.totalStored + (item._apiNumStored or 0)
            end
            if item._apiNumPlaced then
                stats.housingInventory.totalPlaced = stats.housingInventory.totalPlaced + (item._apiNumPlaced or 0)
            end
        end

        -- Track travel statistics (unique vendor locations)
        -- Use VendorHelper for faction-aware vendor/zone selection
        local zoneName = nil
        local vendorName = nil
        if _G.HousingVendorHelper then
            zoneName = _G.HousingVendorHelper:GetZoneName(item, nil)
            vendorName = _G.HousingVendorHelper:GetVendorName(item, nil)
        else
            zoneName = item.zoneName or item._apiZone  -- Prioritize hardcoded data over API
            vendorName = item.vendorName or item._apiVendor  -- Prioritize hardcoded data over API
        end

        if zoneName and zoneName ~= "" then
            -- Initialize zone if not exists
            if not stats.travelStats.locationsByZone[zoneName] then
                stats.travelStats.locationsByZone[zoneName] = {
                    locations = {},
                    total = 0,
                    collected = 0,
                    vendors = {}
                }
            end

            -- Track unique locations by vendor name and coordinates
            local locationKey = zoneName
            if vendorName and vendorName ~= "" then
                locationKey = locationKey .. "_" .. vendorName
                -- Track unique vendors
                if not stats.travelStats.locationsByZone[zoneName].vendors[vendorName] then
                    stats.travelStats.locationsByZone[zoneName].vendors[vendorName] = true
                    stats.travelStats.totalVendors = stats.travelStats.totalVendors + 1
                end
            end
            if item.vendorCoords then
                -- Convert coords to string if it's a table
                local coordsStr = ""
                if type(item.vendorCoords) == "table" then
                    coordsStr = tostring(item.vendorCoords.x or item.vendorCoords[1] or "") .. "_" .. tostring(item.vendorCoords.y or item.vendorCoords[2] or "")
                elseif type(item.vendorCoords) == "string" and item.vendorCoords ~= "" then
                    coordsStr = item.vendorCoords
                end
                if coordsStr ~= "" and coordsStr ~= "_" then
                    locationKey = locationKey .. "_" .. coordsStr
                end
            end

            -- Track unique location (minimal memory footprint)
            if not stats.travelStats.locationsByZone[zoneName].locations[locationKey] then
                stats.travelStats.locationsByZone[zoneName].locations[locationKey] = true
                stats.travelStats.uniqueLocations = stats.travelStats.uniqueLocations + 1
            end

            -- Count total/collected items for this zone
            stats.travelStats.locationsByZone[zoneName].total = stats.travelStats.locationsByZone[zoneName].total + 1
            if isCollected then
                stats.travelStats.locationsByZone[zoneName].collected = stats.travelStats.locationsByZone[zoneName].collected + 1
            end

            -- Track by expansion
            if expName then
                if not stats.travelStats.vendorsByExpansion[expName] then
                    stats.travelStats.vendorsByExpansion[expName] = {
                        zones = {},
                        vendorCount = 0,
                        locationCount = 0
                    }
                end
                if not stats.travelStats.vendorsByExpansion[expName].zones[zoneName] then
                    stats.travelStats.vendorsByExpansion[expName].zones[zoneName] = true
                end
            end
        end

        -- Track vendor-level stats (vendor items only)
        if sourceType == "Vendor" and zoneName and zoneName ~= "" and vendorName and vendorName ~= "" then
            local vendorKey = zoneName .. "||" .. vendorName
            local vendorStats = stats.byVendor[vendorKey]
            if not vendorStats then
                vendorStats = {
                    vendor = vendorName,
                    zone = zoneName,
                    total = 0,
                    collected = 0,
                    missing = 0,
                    missingValue = 0,
                    freeMissing = 0,
                    cheapMissing = 0
                }
                stats.byVendor[vendorKey] = vendorStats
            end

            vendorStats.total = vendorStats.total + 1
            if isCollected then
                vendorStats.collected = vendorStats.collected + 1
            else
                vendorStats.missing = vendorStats.missing + 1
                vendorStats.missingValue = vendorStats.missingValue + goldValue
                if goldValue == 0 then
                    vendorStats.freeMissing = vendorStats.freeMissing + 1
                elseif goldValue <= 50 then
                    vendorStats.cheapMissing = vendorStats.cheapMissing + 1
                end
            end
        end

        -- Track "ready to collect" vs "locked" for items you don't own yet.
        if not isCollected and hasRequirement then
            if isUnlocked then
                stats.readyMissing = stats.readyMissing + 1
                if unlockedByAchievement then
                    stats.readyBy.Achievement = stats.readyBy.Achievement + 1
                end
                if unlockedByQuest then
                    stats.readyBy.Quest = stats.readyBy.Quest + 1
                end

                if #stats.readyItems < 30 then
                    local itemZoneName = nil
                    if _G.HousingVendorHelper then
                        itemZoneName = _G.HousingVendorHelper:GetZoneName(item, nil)
                    else
                        itemZoneName = item._apiZone or item.zoneName
                    end

                    local reason = nil
                    if unlockedByAchievement and unlockedByQuest then
                        reason = "Achievement + Quest"
                    elseif unlockedByAchievement then
                        reason = "Achievement"
                    elseif unlockedByQuest then
                        reason = "Quest"
                    else
                        reason = "Unlocked"
                    end

                    table.insert(stats.readyItems, {
                        name = item.name,
                        source = sourceType,
                        zone = itemZoneName,
                        price = goldValue,
                        currency = item.currency,
                        reason = reason,
                        achievementDate = unlockedAchievementDate,
                    })
                end
            else
                stats.lockedMissing = stats.lockedMissing + 1
            end
        end

        -- Track by currency type
        if item.currency and item.currency ~= "" then
            local currencyName = item.currency
            if not stats.byCurrency[currencyName] then
                stats.byCurrency[currencyName] = {total = 0, collected = 0, missing = 0}
            end
            stats.byCurrency[currencyName].total = stats.byCurrency[currencyName].total + 1
            if isCollected then
                stats.byCurrency[currencyName].collected = stats.byCurrency[currencyName].collected + 1
            else
                stats.byCurrency[currencyName].missing = stats.byCurrency[currencyName].missing + 1
            end
        end

        -- Track value and price ranges
        if goldValue > 0 then
            stats.totalValue.gold = stats.totalValue.gold + goldValue
            stats.totalValue.items = stats.totalValue.items + 1

            -- Price range tracking
            local priceRange
            if goldValue == 0 then
                priceRange = "free"
            elseif goldValue <= 100 then
                priceRange = "cheap"
            elseif goldValue <= 1000 then
                priceRange = "moderate"
            elseif goldValue <= 10000 then
                priceRange = "expensive"
            else
                priceRange = "luxury"
            end

            if stats.priceRanges[priceRange] then
                stats.priceRanges[priceRange].total = stats.priceRanges[priceRange].total + 1
                if isCollected then
                    stats.priceRanges[priceRange].collected = stats.priceRanges[priceRange].collected + 1
                end
            end

            if isCollected then
                stats.collectedValue.gold = stats.collectedValue.gold + goldValue
                stats.collectedValue.items = stats.collectedValue.items + 1
            else
                stats.missingValue.gold = stats.missingValue.gold + goldValue
                stats.missingValue.items = stats.missingValue.items + 1

                -- Track expensive missing items
                if goldValue >= 100 then
                    -- Use faction-aware zone name
                    local itemZoneName = nil
                    if _G.HousingVendorHelper then
                        itemZoneName = _G.HousingVendorHelper:GetZoneName(item, nil)
                    else
                        itemZoneName = item._apiZone or item.zoneName
                    end

                    table.insert(stats.expensiveMissing, {
                        name = item.name,
                        price = goldValue,
                        source = sourceType,
                        zone = itemZoneName
                    })
                end
            end
        else
            -- Free items
            stats.priceRanges.free.total = stats.priceRanges.free.total + 1
            if isCollected then
                stats.priceRanges.free.collected = stats.priceRanges.free.collected + 1
            end
        end
        
        -- Track easy wins (free or cheap uncollected items)
        if not isCollected then
            if goldValue == 0 or goldValue <= 50 then
                -- Use faction-aware zone name
                local itemZoneName = nil
                if _G.HousingVendorHelper then
                    itemZoneName = _G.HousingVendorHelper:GetZoneName(item, nil)
                else
                    itemZoneName = item._apiZone or item.zoneName
                end

                table.insert(stats.easyWins, {
                    name = item.name,
                    price = goldValue,
                    source = sourceType,
                    zone = itemZoneName,
                    currency = item.currency
                })
            end
        end

        -- Track achievement statistics
        if item._achievementId then
            local achievementID = item._achievementId
            
            -- Check if we've already counted this achievement
            if not stats.achievementStats[achievementID] then
                stats.achievementStats[achievementID] = true
                stats.achievementStats.totalAchievements = stats.achievementStats.totalAchievements + 1
                
                -- Get achievement info from API
                do
                    local achInfo = GetAchievementInfoCached(achievementID)
                    if achInfo then
                        -- Track points
                        if achInfo.points then
                            stats.achievementStats.totalPoints = stats.achievementStats.totalPoints + achInfo.points
                            if achInfo.completed then
                                stats.achievementStats.earnedPoints = stats.achievementStats.earnedPoints + achInfo.points
                            end
                        end
                        
                        -- Track completion
                        if achInfo.completed then
                            stats.achievementStats.achievementsCompleted = stats.achievementStats.achievementsCompleted + 1
                        else
                            stats.achievementStats.achievementsIncomplete = stats.achievementStats.achievementsIncomplete + 1
                        end
                        
                        -- Track by expansion
                        local expName = item.expansionName or "Other"
                        if not stats.achievementStats.byExpansion[expName] then
                            stats.achievementStats.byExpansion[expName] = {
                                total = 0,
                                completed = 0,
                                points = 0,
                                earnedPoints = 0
                            }
                        end
                        stats.achievementStats.byExpansion[expName].total = stats.achievementStats.byExpansion[expName].total + 1
                        if achInfo.completed then
                            stats.achievementStats.byExpansion[expName].completed = stats.achievementStats.byExpansion[expName].completed + 1
                        end
                        if achInfo.points then
                            stats.achievementStats.byExpansion[expName].points = stats.achievementStats.byExpansion[expName].points + achInfo.points
                            if achInfo.completed then
                            stats.achievementStats.byExpansion[expName].earnedPoints = stats.achievementStats.byExpansion[expName].earnedPoints + achInfo.points
                            end
                        end
                    end
                end
            end
            
            -- Count items from achievements
            stats.achievementStats.itemsFromAchievements = stats.achievementStats.itemsFromAchievements + 1
        end

        -- Track quest statistics
        if item._questId then
            local questID = item._questId
            
            -- Check if we've already counted this quest
            if not stats.questStats[questID] then
                stats.questStats[questID] = true
                stats.questStats.totalQuests = stats.questStats.totalQuests + 1
                
                -- Check quest completion
                local isCompleted = IsQuestCompleted(questID)
                if isCompleted then
                    stats.questStats.questsCompleted = stats.questStats.questsCompleted + 1
                else
                    stats.questStats.questsIncomplete = stats.questStats.questsIncomplete + 1
                end
                
                -- Track by expansion
                local expName = item.expansionName or "Other"
                if not stats.questStats.byExpansion[expName] then
                    stats.questStats.byExpansion[expName] = {
                        total = 0,
                        completed = 0
                    }
                end
                stats.questStats.byExpansion[expName].total = stats.questStats.byExpansion[expName].total + 1
                if isCompleted then
                    stats.questStats.byExpansion[expName].completed = stats.questStats.byExpansion[expName].completed + 1
                end
            end
            
            -- Count items from quests
            stats.questStats.itemsFromQuests = stats.questStats.itemsFromQuests + 1
        end
    end
    
    -- Sort expensive missing items
    table.sort(stats.expensiveMissing, function(a, b) return a.price > b.price end)
    
    -- Sort easy wins by source type, then price
    table.sort(stats.easyWins, function(a, b)
        if a.price == b.price then
            return a.source < b.source
        end
        return a.price < b.price
    end)
    
    return stats
end


return StatisticsUI

