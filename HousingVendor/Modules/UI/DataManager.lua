-- Data Manager for HousingVendor addon
-- Simple, efficient data aggregation - one pass, cached results

local DataManager = {}
DataManager.__index = DataManager

-- Cache global references for performance
local pairs = pairs
local ipairs = ipairs
local tonumber = tonumber
local string_format = string.format
local string_find = string.find
local string_lower = string.lower
local table_insert = table.insert
local table_sort = table.sort

-- Cache for aggregated items
local itemCache = nil
local filterOptionsCache = nil
local isInitialized = false

-- Filter result cache
local filteredResultsCache = nil
local lastFilterHash = nil

-- Faction lookup tables (pre-built for performance)
local hordeFactionKeywords = {
    "orgrimmar", "thunder bluff", "undercity", "silvermoon",
    "durotar", "mulgore", "tirisfal", "eversong"
}
local allianceFactionKeywords = {
    "stormwind", "ironforge", "darnassus", "exodar",
    "elwynn", "dun morogh", "teldrassil", "azuremyst"
}

-- Build quick lookup function
local function InferFactionFromText(text)
    local lowerText = string.lower(text)
    
    for _, keyword in ipairs(hordeFactionKeywords) do
        if string.find(lowerText, keyword) then
            return "Horde"
        end
    end
    
    for _, keyword in ipairs(allianceFactionKeywords) do
        if string.find(lowerText, keyword) then
            return "Alliance"
        end
    end
    
    return "Neutral"
end

-- Initialize data manager
function DataManager:Initialize()
    if isInitialized then return end
    itemCache = nil
    filterOptionsCache = nil
    isInitialized = true
end

-- Check if initialized
function DataManager:IsInitialized()
    return isInitialized
end

-- Lookup table for crafted items (from user-provided list)
local CRAFTED_ITEMS_LOOKUP = {}
do
    local craftedItemNames = {
        "Arcan'dor Cutting Fountain", "Beloved Raptor Plushie", "Schmancy Goblin String Lights",
        "Boulder Springs Hot Tub", "Ardenweald Lamppost", "Loch Modan Bearskin Rug",
        "Dornic Mine and Cheese Platter", "Joybuzz's Joyful Wall of Trains", "Beloved Elekk Plushie",
        "Draenethyst String Lights", "Boralus-Style Lobster Platter", "Heart of the Forest Banner",
        "Suramar Fence", "Halfhill Cookpot", "Nightspire Fountain", "Bruffalon Rib Platter",
        "Apothecary's Worktable", "Jade Temple Dragon Fountain", "Draconic Nesting Bed",
        "Algari Fence", "Hungry Human's Platter", "Bejeweled Venthyr Chalice",
        "Verdant Valdrakken Vase", "Gilnean Postbox", "Literature of the Red Dragonflight",
        "Mushan Dumpling Stack", "Valdrakken Fence", "Sintallow Candles",
        "Mark of the Mages' Eye", "Gilnean Problem Solver", "Dornic Sliced Mineloaf",
        "Pandaren Stone Wall", "Stampwhistle's Postal Portal", "Literature of the Blue Dragonflight",
        "Lorewalker's Bookcase", "Earthen Hospitality Cheese-Like Brick", "Small Gilnean Windmill",
        "Pyrewood Glass Bottle", "Ancestral Signal Brazier", "Drake Kebab Platter",
        "Undermine Bean Bag Chair", "San'layn Blood Orb", "Gilnean Rocking Chair",
        "Pandaren Fireplace", "Gilnean Cauldron", "Ardenweald Hanging Baskets",
        "Draconic Scribe's Basin", "Stranglekelp Sack", "Orcish Fence",
        "Draenei Holo-Dais", "Gilnean Map", "Hollow Night Fae Shrine",
        "Zuldazar Fence", "Suramar Dresser", "Wise Pandaren's Bed",
        "Kharanos Bookcase", "Pandaren Alchemist's Kit", "Tauren Soup Pot",
        "Glazed Sin'dorei Vial", "Kaheti Predator's Assortment", "Kirin Tor Glass Table",
        "Well-Lit Incontinental Couch", "Suramar Jeweler's Assortment", "\"Unity of Thorns\" Tapestry",
        "Darkmaster's Mystical Brazier", "Venthyr Anima Bottle", "Dornogal Bookcase",
        "Draenethyst Sconce", "Aldor Bookcase", "Dalaran Sun Sconce",
        "Draenei Holo-Path", "Aspirant's Meditation Pool", "Icecrown Plague Canister",
        "Literature of the Green Dragonflight", "Caramel Mint Noodle Dish", "Dalaran Sewer Gate",
        "Gilded Dalaran Banner", "Thaldraszus Telescope", "Draenei Stargazer's Telescope",
        "Replica Awakening Machine Stasis Pod", "Kyrian Floating Lamp", "Kirin Tor Sun Chandelier",
        "Wingrest Signal Brazier", "Tapestry of the Five Flights", "Arakkoa Decoy Scarecrow",
        "Blackrock Weapon Rack", "Tauren Leather Fence", "Octagonal Ochre Window",
        "Five Flights' Grimoire", "Valdrakken Gilded Throne", "Brill Coffin",
        "Arakkoan Alchemist's Bottle", "Dornogal Hanging Sconce", "Camp Narache Rug",
        "Valdrakken Blossomfruit Platter", "Argussian Circular Rug", "Stormsong Stove",
        "Tirisfal Hollow Campfire", "Draenei Crystal Chandelier", "Blackrock Bunkbed",
        "Frostwall Forge", "Veil-Secured Animacone", "Starry Scrying Pool",
        "Gnomish Tesla Mega-Coil", "Dalaran Runic Anvil", "Dalaran Scholar's Bookcase",
        "Elder Rise Rug", "Hanging Paper Lanterns", "Suramar Containment Cell",
        "Dragon's Elixir Bottle", "Gilnean Green Potion", "Orcish Felblood Cauldron",
        "Maldraxxian Runic Tablet", "Aldor Stellar Console", "Kirin Tor Skyline Banner",
        "Valdrakken Hanging Cauldron", "Boralus Bottle Lamp", "Wolvar Postbag",
        "Karabor Bed", "Shaded Suramar Window", "Stoppered Black Potion",
        "Smoke Lamp", "Dark Iron Table Saw", "Pandaren Meander Rug",
        "Pandaren Fishing Net", "Mechagon Miniature Artificial Sun", "Wine Barrel",
        "Dwarven District Banner", "Dalaran Auto-Hammer", "Small Mask of Bwonsamdi, Loa of Graves",
        "Red Dazar'alor Rug", "Nerubian Alchemist's Retort", "Deactivated Atomic Recalibrator",
        "Gnomish Steam-Powered Bed", "Standing Smoke Lamp", "Zandalari Bottle Shipment",
        "Draenei Transmitter", "Tome of Maldraxxian Rituals", "Pandaren Table Lamp",
        "Gilnean Spare Saddle", "Reconstructed Mogu Lightning Drill", "Aspirant's Ringed Banner",
        "Surwich Expedition Tent", "Brennadam Grinder", "Dornogal Framed Rug",
        "Shadowforge Sconce", "Zhevra-Stripe Rug", "Titanic Tyrhold Fountain",
        "Home Defense Gadget", "Dalaran Display Shelves", "Serenity Peak Tent",
        "Pandaren Signal Brazier", "Algari Fencepost", "Silvermoon Spire Fountain",
        "Blackrock Lamppost", "Tauren Fencepost", "Smoke Sconce",
        "Grand Drape of the Exiles", "Freywold Table", "Suramar Fencepost",
        "Scaled Twilight Mosaic", "Intense Mogu Brazier", "Draenei Crystal Forge",
        "Dalaran Street Sign", "Frostwall Architect's Table", "Zandalari Skullfire Lamp",
        "Large Revendreth Storage Crate", "Draenei Weaver's Loom", "Draconic Circular Rug",
        "Cartel Xy Capture Crate", "Draenei Smith's Anvil", "Resizable All-Purpose Gear",
        "Pandaren Wooden Table", "Frostwall Elevated Brazier", "Boralus Bookshelf",
        "Shattrath Lamppost", "Ironforge Chandelier", "Outland Mag'har Banner",
        "Shadow Council Torch", "Replica Rumbling Wastes Drill Pod", "Valdrakken Fencepost",
        "Tempest Keep Cryo-Pod", "Gilnean Pitchfork", "Square Pandaren Table",
        "Tidesage's Totem", "Draenic Basin", "Rolled Scarab Rug",
        "Brill Coffin Lid", "Gundargaz Candelabra", "Gilnean Wall Shelf",
        "Kyrian Anima Barrel", "Thunder Bluff Totem", "Arakkoan Alchemist's Concoction",
        "Nightborne Jeweler's Table", "Steel Ironforge Emblem", "Lucky Traveler's Bench",
        "Aspiring Soul's Chair", "Circular Shal'dorei Rug", "Shredderwheel Storage Chest",
        "Covered Square Suramar Table", "Ren'dorei Postal Repository", "Ren'dorei Stargazer",
        "Ren'dorei Void Projector", "Ren'dorei Warp Orb", "Replica Haranir Mural",
        "Resplendent Highborne Statue", "Restful Bronze Bench", "Riftstone",
        "Rootbound Vat", "Rootflame Campfire", "Rusting Bolted Bench",
        "Sandfury Diplomat's Banner", "Self-Pouring Thalassian Sunwine", "Shal'dorei Open-Air Tent",
        "Shattrath Sconce", "Shining Sin'dorei Hourglass", "Silver Dalaran Bench",
        "Silvermoon Curtains", "Simple Haranir Table", "Sin'dorei Phoenix Quill",
        "Small Telogrus Lamp", "Snowfall Tribe Scare-Totem", "Spellbound Tome of Thalassian Magics",
        "Stitched Haranir Rug", "Sturdy Ren'dorei Cask", "Sunsmoke Censer",
        "Suramar Storage Crate", "Talon King's Totem", "Tauren Storage Chest",
        "Tenebrous Ren'dorei Armillary", "Twilight Fire Canister", "Valdrakken Banded Barrel",
        "Valdrakken Storage Crate", "Valdrakken Wall Shelf", "Voidstrider Saddlebag",
        "Wild Hanging Scroll", "Wooden Ironforge Table", "Wooden Shipping Crate",
        "Zanchuli Tapestry", "Zandalari Ritual Drum", "Zuldazar Fencepost"
    }
    
    for _, name in ipairs(craftedItemNames) do
        CRAFTED_ITEMS_LOOKUP[string.lower(name)] = true
    end
end

-- Aggregate all items from vendorData in a single pass
function DataManager:GetAllItems()
    -- Return cached data if available
    if itemCache then
        return itemCache
    end
    
    local allItems = {}
    local filterOptions = {
        expansions = {},
        vendors = {},
        zones = {},
        types = {},
        categories = {},
        factions = {},
        sources = {}  -- Achievement, Quest, Drop, Vendor, Crafted, Wishlist
    }
    
    -- List of non-expansion category names to exclude from expansion filter
    local nonExpansionCategories = {
        ["Achievement Items"] = true,
        ["Drop Items"] = true,
        ["Quest Items"] = true,
        ["Replica Items"] = true,
        ["Miscellaneous Items"] = true,
        ["Event Rewards"] = true,
        ["Collection Items"] = true,
        ["Crafted Items"] = true
    }
    
    -- Single pass through all data
    for expansionName, expansionData in pairs(HousingData.vendorData) do
        -- Track expansion (exclude non-expansion categories)
        if not nonExpansionCategories[expansionName] then
            filterOptions.expansions[expansionName] = true
        end
        
        for zoneName, vendors in pairs(expansionData) do
            -- Track zone
            filterOptions.zones[zoneName] = true
            
            for _, vendor in ipairs(vendors) do
                -- Track vendor
                local vendorName = vendor.name or "Unknown Vendor"
                filterOptions.vendors[vendorName] = true
                
                if vendor.items then
                    for _, item in ipairs(vendor.items) do
                        local itemName = item.name or "Unknown Item"
                        
                        -- Skip [DNT] items
                        if not string.find(itemName, "%[DNT%]") then
                            -- Determine faction (check item first, then infer from location)
                            local itemFaction = item.faction or "Neutral"
                            
                            -- If not set in item data, infer from zone/vendor using pre-built lookup
                            if itemFaction == "Neutral" then
                                local zoneFaction = InferFactionFromText(zoneName)
                                if zoneFaction ~= "Neutral" then
                                    itemFaction = zoneFaction
                                else
                                    itemFaction = InferFactionFromText(vendorName)
                                end
                            end
                            
                            -- Determine if this is a profession/crafted item (for source tracking)
                            local isProfessionItem = false
                            
                            -- Check if item name is in the crafted items lookup table
                            if itemName and CRAFTED_ITEMS_LOOKUP[string.lower(itemName)] then
                                isProfessionItem = true
                            -- Check vendor type
                            elseif vendor.type == "Profession Trainer" then
                                isProfessionItem = true
                            -- Check expansion name
                            elseif expansionName == "Crafted Items" then
                                isProfessionItem = true
                            -- Check vendor name for crafting-related keywords
                            elseif vendorName and (
                                string.find(string.lower(vendorName), "crafter") or
                                string.find(string.lower(vendorName), "crafticus") or
                                string.find(string.lower(vendorName), "jewelcrafter") or
                                string.find(string.lower(vendorName), "trainer")
                            ) then
                                isProfessionItem = true
                            -- Check item name for crafting-related keywords
                            elseif itemName and (
                                string.find(string.lower(itemName), "crafter") or
                                string.find(string.lower(itemName), "craft") or
                                string.find(string.lower(itemName), "jewelcrafter")
                            ) then
                                isProfessionItem = true
                            end
                            
                            -- Create item record (preserve all fields)
                            local itemRecord = {
                                -- Basic info
                                name = itemName,
                                itemID = item.itemID or "",
                                type = item.type or "Uncategorized",
                                category = item.category or "Miscellaneous",
                                price = item.price or 0,
                                faction = itemFaction,
                                
                                -- Model data
                                modelFileID = item.modelFileID or "",
                                thumbnailFileID = item.thumbnailFileID or "",
                                
                                -- Vendor info
                                vendorName = vendorName,
                                vendorType = vendor.type or "Zone Specific",
                                vendorCoords = vendor.coordinates or {x = 0, y = 0},
                                
                                -- Location
                                zoneName = zoneName,
                                expansionName = expansionName,
                                mapID = item.mapID or 0,
                                
                                -- Achievement/Quest/Drop requirements (preserve all)
                                achievementRequired = item.achievementRequired or nil,
                                questRequired = item.questRequired or nil,
                                dropSource = item.dropSource or nil,
                                
                                -- Cost information (preserve currency field)
                                currency = item.currency or nil,
                                
                                -- Additional vendor field (from item data, not vendor structure)
                                vendor = item.vendor or nil,
                                
                                -- Pre-computed lowercase for filtering
                                _lowerName = string.lower(itemName),
                                _lowerType = string.lower(item.type or ""),
                                _lowerCategory = string.lower(item.category or ""),
                                _lowerVendor = string.lower(vendorName),
                                _lowerZone = string.lower(zoneName),
                                
                                -- Flag for profession/crafted items
                                _isProfessionItem = isProfessionItem,
                                
                                -- Original data reference
                                _itemData = item,
                                _vendorData = vendor
                            }
                            
                            table.insert(allItems, itemRecord)
                            
                            -- Track filter options
                            filterOptions.types[itemRecord.type] = true
                            filterOptions.categories[itemRecord.category] = true
                            filterOptions.factions[itemFaction] = true
                            
                            -- Track source type (Achievement, Quest, Drop, Vendor, Profession/Crafted, or Wishlist)
                            if isProfessionItem then
                                filterOptions.sources["Crafted"] = true
                            elseif item.achievementRequired and item.achievementRequired ~= "" then
                                filterOptions.sources["Achievement"] = true
                            elseif item.questRequired and item.questRequired ~= "" then
                                filterOptions.sources["Quest"] = true
                            elseif item.dropSource and item.dropSource ~= "" then
                                filterOptions.sources["Drop"] = true
                            else
                                filterOptions.sources["Vendor"] = true
                            end
                            
                            -- Always track Crafted and Wishlist as source options
                            filterOptions.sources["Crafted"] = true
                            filterOptions.sources["Wishlist"] = true
                        end
                    end
                end
            end
        end
    end
    
    -- Always ensure Crafted and Wishlist are in sources (even if no items match)
    filterOptions.sources["Crafted"] = true
    filterOptions.sources["Wishlist"] = true
    
    -- Convert filter options to sorted arrays
    filterOptionsCache = {
        expansions = self:_SortKeys(filterOptions.expansions),
        vendors = self:_SortKeys(filterOptions.vendors),
        zones = self:_SortKeys(filterOptions.zones),
        types = self:_SortKeys(filterOptions.types),
        categories = self:_SortKeys(filterOptions.categories),
        factions = self:_SortKeys(filterOptions.factions),
        sources = self:_SortKeys(filterOptions.sources)
    }
    
    -- Cache results
    itemCache = allItems
    
    return allItems
end

-- Get filter options (expansions, vendors, zones, etc.)
function DataManager:GetFilterOptions()
    if not filterOptionsCache then
        self:GetAllItems() -- This will populate filterOptionsCache
    end

    return filterOptionsCache
end

-- Helper function to check cache (shared with ItemList)
local function IsItemCached(itemID)
    if not HousingDB or not HousingDB.collectedDecor then
        return false
    end
    return HousingDB.collectedDecor[itemID] == true
end

-- Helper function to cache item (shared with ItemList)
local function CacheItemAsCollected(itemID)
    if not HousingDB then
        HousingDB = {}
    end
    if not HousingDB.collectedDecor then
        HousingDB.collectedDecor = {}
    end
    if HousingDB and HousingDB.collectedDecor then
        HousingDB.collectedDecor[itemID] = true
    end
end

local function IsItemCollected(itemID)
    if not itemID or itemID == "" then
        return false
    end

    local numericItemID = tonumber(itemID)
    if not numericItemID then
        return false
    end

    -- Check cache first (AllTheThings approach - avoid repeated API calls)
    if IsItemCached(numericItemID) then
        return true
    end

    local isCollected = false

    -- Method 1: Use C_Housing.IsDecorCollected (correct API for housing decor)
    if C_Housing and C_Housing.IsDecorCollected then
        local success, collected = pcall(function()
            return C_Housing.IsDecorCollected(numericItemID)
        end)
        if success and collected ~= nil then
            isCollected = collected
            if isCollected then
                CacheItemAsCollected(numericItemID)
            end
        end
    end

    -- Method 2: AllTheThings approach - Check numStored + numPlaced from catalog
    if not isCollected and C_HousingCatalog and C_HousingCatalog.GetCatalogEntryInfoByItem then
        local success, state = pcall(function()
            return C_HousingCatalog.GetCatalogEntryInfoByItem(numericItemID, true)
        end)
        if success and state then
            local sum = (state.numStored or 0) + (state.numPlaced or 0)
            if sum > 0 and sum < 1000000 then
                isCollected = true
                CacheItemAsCollected(numericItemID)
            end
        end
    end

    -- Method 3: Fallback to housing catalog API (alternative method)
    if not isCollected and C_HousingCatalog and C_HousingCatalog.GetCatalogEntryByItemID then
        local success, entryInfo = pcall(function()
            return C_HousingCatalog.GetCatalogEntryByItemID(numericItemID)
        end)
        if success and entryInfo then
            if entryInfo.isCollected ~= nil then
                isCollected = entryInfo.isCollected
                if isCollected then
                    CacheItemAsCollected(numericItemID)
                end
            elseif entryInfo.collected ~= nil then
                isCollected = entryInfo.collected
                if isCollected then
                    CacheItemAsCollected(numericItemID)
                end
            end
        end
    end

    -- Method 4: Fallback to generic item collection API (for non-decor items)
    if not isCollected and C_PlayerInfo and C_PlayerInfo.IsItemCollected then
        local success, collected = pcall(function()
            return C_PlayerInfo.IsItemCollected(numericItemID)
        end)
        if success and collected ~= nil then
            isCollected = collected
            if isCollected then
                CacheItemAsCollected(numericItemID)
            end
        end
    end

    return isCollected
end

-- Public method to check if an item is collected (for use by other modules)
function DataManager:IsItemCollected(itemID)
    return IsItemCollected(itemID)
end

-- Generate hash key from filter values
local function GetFilterHash(filters)
    return string.format("%s|%s|%s|%s|%s|%s|%s|%s|%s",
        filters.searchText or "",
        filters.expansion or "",
        filters.vendor or "",
        filters.zone or "",
        filters.type or "",
        filters.category or "",
        filters.faction or "",
        filters.source or "",
        filters.collection or "")
end

function DataManager:FilterItems(items, filters)
    if not items or #items == 0 then
        return {}
    end
    
    -- Check cache first
    local filterHash = GetFilterHash(filters)
    if filteredResultsCache and lastFilterHash == filterHash then
        return filteredResultsCache
    end
    
    local filtered = {}
    local searchText = string.lower(filters.searchText or "")
    
    for _, item in ipairs(items) do
        local show = true
        
        -- Search filter
        if searchText ~= "" then
            if not string.find(item._lowerName, searchText) and
               not string.find(item._lowerType, searchText) and
               not string.find(item._lowerCategory, searchText) and
               not string.find(item._lowerVendor, searchText) and
               not string.find(item._lowerZone, searchText) then
                show = false
            end
        end
        
        -- Expansion filter
        if show and filters.expansion and filters.expansion ~= "All Expansions" then
            if item.expansionName ~= filters.expansion then
                show = false
            end
        end
        
        -- Vendor filter
        if show and filters.vendor and filters.vendor ~= "All Vendors" then
            if item.vendorName ~= filters.vendor then
                show = false
            end
        end
        
        -- Zone filter
        if show and filters.zone and filters.zone ~= "All Zones" then
            if item.zoneName ~= filters.zone then
                show = false
            end
        end
        
        -- Type filter
        if show and filters.type and filters.type ~= "All Types" then
            if item.type ~= filters.type then
                show = false
            end
        end
        
        -- Category filter
        if show and filters.category and filters.category ~= "All Categories" then
            if item.category ~= filters.category then
                show = false
            end
        end
        
        -- Faction filter
        -- When a specific faction is selected (Alliance or Horde), also show Neutral items
        if show and filters.faction and filters.faction ~= "All Factions" then
            local itemFaction = item.faction or "Neutral"
            if itemFaction ~= filters.faction and itemFaction ~= "Neutral" then
                show = false
            end
        end
        
        -- Source filter (Achievement, Quest, Drop, Vendor, Profession, Wishlist)
        if show and filters.source and filters.source ~= "All Sources" then
            if filters.source == "Wishlist" then
                -- Check if item is in wishlist
                local itemID = tonumber(item.itemID)
                if not itemID or not HousingDB or not HousingDB.wishlist or not HousingDB.wishlist[itemID] then
                    show = false
                end
            elseif filters.source == "Crafted" then
                -- Check if item is a profession/crafted item using the stored flag
                if not item._isProfessionItem then
                    show = false
                end
            else
                local itemSource = "Vendor"
                -- Check for other source types
                if item.achievementRequired and item.achievementRequired ~= "" then
                    itemSource = "Achievement"
                elseif item.questRequired and item.questRequired ~= "" then
                    itemSource = "Quest"
                elseif item.dropSource and item.dropSource ~= "" then
                    itemSource = "Drop"
                end

                if itemSource ~= filters.source then
                    show = false
                end
            end
        end

        -- Collection filter
        if show and filters.collection and filters.collection ~= "All" then
            local isCollected = IsItemCollected(item.itemID)
            if filters.collection == "Uncollected" and isCollected then
                show = false
            elseif filters.collection == "Collected" and not isCollected then
                show = false
            end
        end

        if show then
            table.insert(filtered, item)
        end
    end

    -- Cache results
    filteredResultsCache = filtered
    lastFilterHash = filterHash

    return filtered
end

-- Helper: Convert hash table keys to sorted array
function DataManager:_SortKeys(hashTable)
    local keys = {}
    for key in pairs(hashTable) do
        table.insert(keys, key)
    end
    table.sort(keys)
    return keys
end

-- Clear cache (call when data changes)
function DataManager:ClearCache()
    itemCache = nil
    filterOptionsCache = nil
    filteredResultsCache = nil
    lastFilterHash = nil
end

-- Make globally accessible
_G["HousingDataManager"] = DataManager

return DataManager

