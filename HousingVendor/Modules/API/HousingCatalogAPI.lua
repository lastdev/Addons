-- Housing Catalog API Integration
local HousingCatalogAPI = {}
HousingCatalogAPI.__index = HousingCatalogAPI

-- Check if housing catalog APIs are available
function HousingCatalogAPI:IsAvailable()
    return C_HousingCatalog ~= nil
end

-- Get catalog entry info
function HousingCatalogAPI:GetCatalogEntryInfo(entryID)
    if not self:IsAvailable() then
        return nil
    end
    
    local success, info = pcall(function()
        return C_HousingCatalog.GetCatalogEntryInfo(entryID)
    end)
    
    if success and info then
        return info
    else
        return nil
    end
end

-- Get all filter tag groups
function HousingCatalogAPI:GetAllFilterTagGroups()
    if not self:IsAvailable() then
        return {}
    end
    
    local success, groups = pcall(function()
        return C_HousingCatalog.GetAllFilterTagGroups()
    end)
    
    if success and groups then
        return groups
    else
        return {}
    end
end

-- Search catalog categories
function HousingCatalogAPI:SearchCatalogCategories(searchParams)
    if not self:IsAvailable() then
        return {}
    end
    
    local success, categories = pcall(function()
        return C_HousingCatalog.SearchCatalogCategories(searchParams)
    end)
    
    if success and categories then
        return categories
    else
        return {}
    end
end

-- Get featured decor
function HousingCatalogAPI:GetFeaturedDecor()
    if not self:IsAvailable() then
        return {}
    end
    
    local success, decor = pcall(function()
        return C_HousingCatalog.GetFeaturedDecor()
    end)
    
    if success and decor then
        return decor
    else
        return {}
    end
end

-- Get basic decor info
function HousingCatalogAPI:GetBasicDecorInfo(decorID)
    if not self:IsAvailable() then
        return nil
    end
    
    local success, info = pcall(function()
        return C_HousingCatalog.GetBasicDecorInfo(decorID)
    end)
    
    if success and info then
        return info
    else
        return nil
    end
end

-- Search for catalog entry by itemID using Blizzard API
function HousingCatalogAPI:GetCatalogEntryByItemID(itemID)
    if not self:IsAvailable() or not itemID then
        return nil
    end
    
    local numericItemID = tonumber(itemID)
    if not numericItemID then
        return nil
    end
    
    -- Try to get item info first - items may have catalogEntryID
    local itemInfo = C_Item.GetItemInfo(numericItemID)
    if itemInfo then
        -- Check if itemInfo has catalogEntryID or decorID
        -- This depends on the actual API structure
    end
    
    -- Try searching catalog categories
    -- NOTE: SearchCatalogCategories parameters need to be verified against API docs
    -- Common patterns: {itemID = number} or {itemIDs = {number}} or different structure
    local success, results = pcall(function()
        -- Try different possible parameter formats
        local searchParams = {itemID = numericItemID}
        local results1 = C_HousingCatalog.SearchCatalogCategories(searchParams)
        if results1 and #results1 > 0 then
            return results1
        end
        
        -- Try alternative format if first didn't work
        searchParams = {itemIDs = {numericItemID}}
        local results2 = C_HousingCatalog.SearchCatalogCategories(searchParams)
        if results2 and #results2 > 0 then
            return results2
        end
        
        return nil
    end)
    
    if success and results and #results > 0 then
        -- Get the entry info from the first result
        -- Structure may vary: results[1].entryID or results[1].catalogEntryID
        local entryID = results[1].entryID or results[1].catalogEntryID
        if entryID then
            return self:GetCatalogEntryInfo(entryID)
        end
    end
    
    return nil
end

-- Request housing market info refresh
function HousingCatalogAPI:RequestHousingMarketInfoRefresh()
    if not self:IsAvailable() then
        return false
    end
    
    local success = pcall(function()
        C_HousingCatalog.RequestHousingMarketInfoRefresh()
    end)
    
    return success
end

-- Initialize the module
function HousingCatalogAPI:Initialize()
    if self:IsAvailable() then
        -- Live API access available (silent)
    else
        -- Live API not available (silent)
    end
end