-- Data Enrichment Module
-- Enhances HousingAllItems with information from HousingItemTrackerDB
-- Maps decorID to itemID and enriches vendor data, prices, materials, etc.

if not HousingDataEnrichment then
    HousingDataEnrichment = {}
end

local DataEnrichment = {}
DataEnrichment.__index = DataEnrichment

-- Create reverse mapping: decorID -> itemID
local decorIDToItemID = {}
local enrichmentData = {}
local materialsLookup = {}

-- Initialize the enrichment data
function DataEnrichment:Initialize()
    if not HousingAllItems then
        return false
    end

    -- Build decorID -> itemID mapping from HousingAllItems
    decorIDToItemID = {}
    for itemID, decorData in pairs(HousingAllItems) do
        local itemIDNum = tonumber(itemID)
        local decorID = decorData[1]  -- Index 1 = decorID (HousingItemFields.DECOR_ID)
        if itemIDNum and decorID then
            if not decorIDToItemID[decorID] then
                decorIDToItemID[decorID] = {}
            end
            table.insert(decorIDToItemID[decorID], itemIDNum)
        end
    end
    
    -- Load enrichment data from HousingItemTrackerDB if available
    if HousingItemTrackerDB and HousingItemTrackerDB.items then
        local trackerData = HousingItemTrackerDB.items
        
        -- Process decorItems
        if trackerData.decorItems then
            for decorID, itemData in pairs(trackerData.decorItems) do
                local decorIDNum = tonumber(decorID)
                if decorIDNum and decorIDToItemID[decorIDNum] then
                    -- Store enrichment data keyed by decorID
                    enrichmentData[decorIDNum] = {
                        category = itemData.category,
                        subcategory = itemData.subcategory,
                        decorCost = itemData.decorCost,
                        sources = itemData.sources,
                        vendors = itemData.vendors,
                        quest = itemData.quest,
                        questId = itemData.questId,
                        materials = itemData.materials,
                        achievement = itemData.achievement,
                        achievementId = itemData.achievementId
                    }
                end
            end
        end
        
        -- Process materials lookup
        if trackerData.materials then
            materialsLookup = trackerData.materials
        end
    end
    
    return true
end

-- Get enriched data for an item by itemID
function DataEnrichment:GetEnrichedData(itemID)
    if not itemID then return nil end
    
    local itemIDNum = tonumber(itemID)
    if not itemIDNum or not HousingAllItems[itemIDNum] then
        return nil
    end

    local decorData = HousingAllItems[itemIDNum]
    local decorID = decorData[1]  -- Index 1 = decorID (HousingItemFields.DECOR_ID)
    if not decorID then return nil end
    
    local enriched = enrichmentData[decorID]
    if not enriched then return nil end
    
    -- Return enriched data
    return {
        category = enriched.category,
        subcategory = enriched.subcategory,
        decorCost = enriched.decorCost,
        sources = enriched.sources,
        vendors = enriched.vendors,
        quest = enriched.quest,
        questId = enriched.questId,
        materials = enriched.materials,
        achievement = enriched.achievement,
        achievementId = enriched.achievementId
    }
end

-- Get vendor information for an item
function DataEnrichment:GetVendorInfo(itemID)
    local enriched = self:GetEnrichedData(itemID)
    if not enriched or not enriched.vendors then
        return nil
    end
    
    return enriched.vendors
end

-- Get crafting materials for an item
function DataEnrichment:GetMaterials(itemID)
    local enriched = self:GetEnrichedData(itemID)
    if not enriched or not enriched.materials then
        return nil
    end
    
    return enriched.materials
end

-- Check if an itemID is a crafting material
function DataEnrichment:IsMaterial(itemID)
    if not materialsLookup then return false end
    local itemIDNum = tonumber(itemID)
    return itemIDNum and materialsLookup[itemIDNum] == true
end

-- Get quest information for an item
function DataEnrichment:GetQuestInfo(itemID)
    local enriched = self:GetEnrichedData(itemID)
    if not enriched then return nil end
    
    if enriched.questId then
        return {
            quest = enriched.quest,
            questId = enriched.questId
        }
    end
    
    return nil
end

-- Get achievement information for an item
function DataEnrichment:GetAchievementInfo(itemID)
    local enriched = self:GetEnrichedData(itemID)
    if not enriched then return nil end
    
    if enriched.achievementId then
        return {
            achievement = enriched.achievement,
            achievementId = enriched.achievementId
        }
    end
    
    return nil
end

-- Get category and subcategory for an item
function DataEnrichment:GetCategories(itemID)
    local enriched = self:GetEnrichedData(itemID)
    if not enriched then return nil, nil end
    
    return enriched.category, enriched.subcategory
end

-- Get all itemIDs that use a specific material
function DataEnrichment:GetItemsUsingMaterial(materialItemID)
    local materialIDNum = tonumber(materialItemID)
    if not materialIDNum then return {} end
    
    local items = {}
    for decorID, enriched in pairs(enrichmentData) do
        if enriched.materials then
            for _, material in ipairs(enriched.materials) do
                if material.id == materialIDNum then
                    -- Find itemIDs for this decorID
                    local itemIDs = decorIDToItemID[decorID]
                    if itemIDs then
                        for _, itemID in ipairs(itemIDs) do
                            table.insert(items, itemID)
                        end
                    end
                    break
                end
            end
        end
    end
    
    return items
end

-- Enhance an existing item record with enrichment data
function DataEnrichment:EnhanceItemRecord(itemRecord)
    if not itemRecord or not itemRecord.itemID then
        return itemRecord
    end
    
    local enriched = self:GetEnrichedData(itemRecord.itemID)
    if not enriched then
        return itemRecord
    end
    
    -- Add category/subcategory
    if enriched.category then
        itemRecord._enrichedCategory = enriched.category
    end
    if enriched.subcategory then
        itemRecord._enrichedSubcategory = enriched.subcategory
    end
    
    -- Add decor cost
    if enriched.decorCost then
        itemRecord._enrichedDecorCost = enriched.decorCost
    end
    
    -- Add sources
    if enriched.sources then
        itemRecord._enrichedSources = enriched.sources
    end
    
    -- Add vendor information (enhanced with prices, currencies, map textures)
    if enriched.vendors then
        itemRecord._enrichedVendors = enriched.vendors
    end
    
    -- Add quest information
    if enriched.questId then
        itemRecord._enrichedQuest = enriched.quest
        itemRecord._enrichedQuestId = enriched.questId
    end
    
    -- Add achievement information
    if enriched.achievementId then
        itemRecord._enrichedAchievement = enriched.achievement
        itemRecord._enrichedAchievementId = enriched.achievementId
    end
    
    -- Add materials
    if enriched.materials then
        itemRecord._enrichedMaterials = enriched.materials
    end
    
    return itemRecord
end

-- Initialize on load
HousingDataEnrichment = DataEnrichment

-- Initialize when both HousingAllItems and HousingItemTrackerDB are available
local function TryInitialize()
    if HousingAllItems then
        HousingDataEnrichment:Initialize()
    end
end

-- Try to initialize immediately if data is available
TryInitialize()

-- Also try to initialize after a delay (in case HousingItemTrackerDB loads later)
C_Timer.After(1, TryInitialize)
C_Timer.After(3, TryInitialize)

return DataEnrichment

