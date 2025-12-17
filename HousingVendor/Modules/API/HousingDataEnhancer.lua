-- Enhances static data with live API data
HousingDataEnhancer = {}

-- Utility function to deep copy a table
local function CopyTable(t)
    if type(t) ~= "table" then return t end
    local meta = getmetatable(t)
    local target = {}
    for k, v in pairs(t) do
        if type(v) == "table" then
            target[k] = CopyTable(v)
        else
            target[k] = v
        end
    end
    setmetatable(target, meta)
    return target
end

-- Check if model mapping data is available
function HousingDataEnhancer:IsModelMappingAvailable()
    local available = HousingDecorData ~= nil
    if HousingDebugPrint then
        HousingDebugPrint("HousingDecorData available: " .. tostring(available))
        if available then
            local count = 0
            for k,v in pairs(HousingDecorData) do
                count = count + 1
            end
            HousingDebugPrint("HousingDecorData entries: " .. count)
        end
    end
    return available
end

-- Check if we can enhance data with live APIs
function HousingDataEnhancer:IsEnhancementAvailable()
    return HousingAPI and HousingAPI:IsAvailable()
end

-- Enhance item data with live information
function HousingDataEnhancer:EnhanceItemData(itemData)
    -- Create a copy of the item data to avoid modifying original
    local enhancedData = CopyTable(itemData)
    
    -- Preserve thumbnailFileID if it exists
    if itemData.thumbnailFileID then
        enhancedData.thumbnailFileID = itemData.thumbnailFileID
    elseif itemData.ThumbnailFileDataID then
        enhancedData.thumbnailFileID = itemData.ThumbnailFileDataID
    end
    
    -- PRIORITY: Try to enhance with model data from HousingDecorData FIRST
    -- This ensures we always have model data if it exists in our data
    if self:IsModelMappingAvailable() and itemData.itemID then
        -- Try numeric key format (HousingDecorData uses numeric keys)
        local numericItemID = tonumber(itemData.itemID)
        local decorData = numericItemID and HousingDecorData[numericItemID]
        
        if decorData and decorData.modelFileID then
            local modelFileID = tonumber(decorData.modelFileID)
            if modelFileID then
                enhancedData.modelFileID = modelFileID
                enhancedData.displayInfoID = modelFileID  -- Set both for compatibility
                if HousingDebugPrint then
                    HousingDebugPrint("Added modelFileID/displayInfoID " .. tostring(modelFileID) .. " for itemID " .. tostring(numericItemID))
                end
            end
        end
    end
    
    -- If no live APIs available, return early with model data only
    if not self:IsEnhancementAvailable() then
        return enhancedData
    end    
    -- Try to enhance with catalog entry info if we have an entry ID
    if itemData.catalogEntryID then
        local catalogInfo = HousingCatalogAPI:GetCatalogEntryInfo(itemData.catalogEntryID)
        if catalogInfo then
            -- Enhance with live data
            if catalogInfo.iconFileID then
                enhancedData.liveIcon = catalogInfo.iconFileID
            end
            
            if catalogInfo.cost then
                enhancedData.livePrice = catalogInfo.cost
            end
            
            if catalogInfo.availability then
                enhancedData.availability = catalogInfo.availability
            end
            
            if catalogInfo.restrictions then
                enhancedData.restrictions = catalogInfo.restrictions
            end
            
            -- IMPORTANT: Capture displayInfoID for 3D model preview
            if catalogInfo.displayInfoID then
                enhancedData.displayInfoID = catalogInfo.displayInfoID
            end
        end
    end
    
    -- Try to enhance with basic decor info if we have a decor ID
    if itemData.decorID then
        local decorInfo = HousingCatalogAPI:GetBasicDecorInfo(itemData.decorID)
        if decorInfo then
            if decorInfo.name and decorInfo.name ~= "" then
                enhancedData.liveName = decorInfo.name
            end
            
            if decorInfo.description and decorInfo.description ~= "" then
                enhancedData.liveDescription = decorInfo.description
            end
            
            if decorInfo.iconFileID then
                enhancedData.liveIcon = decorInfo.iconFileID
            end
            
            -- IMPORTANT: Capture displayInfoID for 3D model preview
            if decorInfo.displayInfoID then
                enhancedData.displayInfoID = decorInfo.displayInfoID
            end
        end
    end
    
    return enhancedData
end

-- Get enhanced item list
function HousingDataEnhancer:GetEnhancedItemList(staticItems)
    -- Always enhance items with model mapping, even if live APIs aren't available
    if not staticItems or type(staticItems) ~= "table" then
        if HousingDebugPrint then
            HousingDebugPrint("Invalid staticItems parameter")
        end
        return {}
    end
    
    local enhancedItems = {}
    
    for i, item in ipairs(staticItems) do
        if item and type(item) == "table" then
            local success, enhancedItem = pcall(function()
                return self:EnhanceItemData(item)
            end)
            
            if success and enhancedItem then
                table.insert(enhancedItems, enhancedItem)
            else
                -- If enhancement fails, use original item
                if HousingDebugPrint then
                    HousingDebugPrint("Enhancement failed for item " .. (item.itemName or "unknown") .. ", using original data")
                end
                table.insert(enhancedItems, item)
            end
        else
            -- Skip invalid items silently
        end
    end
    
    return enhancedItems
end

-- Refresh live market data
function HousingDataEnhancer:RefreshMarketData()
    if not self:IsEnhancementAvailable() or not HousingCatalogAPI then
        return false
    end
    
    -- Request market info refresh
    local success = false
    if HousingCatalogAPI.RequestHousingMarketInfoRefresh then
        local ok, result = pcall(function()
            return HousingCatalogAPI:RequestHousingMarketInfoRefresh()
        end)
        success = ok and (result ~= nil) and result ~= false
    end
    
    if success then
        -- Schedule a follow-up to update our data after refresh
        C_Timer.After(2.0, function()
            self:OnMarketDataRefreshed()
        end)
    end
    
    return success
end

-- Callback when market data has been refreshed
function HousingDataEnhancer:OnMarketDataRefreshed()
    -- Notify UI to update
    if HousingWidgets and HousingWidgets.PopulateItemList then
        HousingWidgets:PopulateItemList()
    end
end

-- Get featured items from live API
function HousingDataEnhancer:GetFeaturedItems()
    if not self:IsEnhancementAvailable() then
        return {}
    end
    
    local featured = HousingCatalogAPI:GetFeaturedDecor()
    local enhancedFeatured = {}
    
    for _, item in ipairs(featured) do
        -- Convert live API data to our format
        local convertedItem = {
            itemName = item.name or "Unknown Item",
            itemType = "Featured",
            itemCategory = "Special",
            itemPrice = item.cost or 0,
            catalogEntryID = item.entryID,
            decorID = item.decorID,
            isFeatured = true
        }
        
        table.insert(enhancedFeatured, self:EnhanceItemData(convertedItem))
    end
    
    return enhancedFeatured
end

-- Get filter tag groups from live API
function HousingDataEnhancer:GetFilterTagGroups()
    if not self:IsEnhancementAvailable() then
        return {}
    end
    
    local tagGroups = HousingCatalogAPI:GetAllFilterTagGroups()
    return tagGroups or {}
end

-- Get hovered decor info
function HousingDataEnhancer:GetHoveredDecorInfo()
    if not self:IsEnhancementAvailable() then
        return nil
    end
    
    return HousingDecorAPI:GetHoveredDecorInfo()
end

-- Get selected decor info
function HousingDataEnhancer:GetSelectedDecorInfo()
    if not self:IsEnhancementAvailable() then
        return nil
    end
    
    return HousingDecorAPI:GetSelectedDecorInfo()
end

-- Search catalog categories
function HousingDataEnhancer:SearchCatalogCategories(searchParams)
    if not self:IsEnhancementAvailable() then
        return {}
    end
    
    local categories = HousingCatalogAPI:SearchCatalogCategories(searchParams)
    return categories or {}
end

-- Initialize the module
function HousingDataEnhancer:Initialize()
    if self:IsEnhancementAvailable() then
        -- Set up periodic market data refresh
        self.refreshTimer = C_Timer.NewTicker(300, function() -- Every 5 minutes
            self:RefreshMarketData()
        end)
    end
end

-- Clean up timers
function HousingDataEnhancer:Shutdown()
    if self.refreshTimer then
        self.refreshTimer:Cancel()
        self.refreshTimer = nil
    end
end