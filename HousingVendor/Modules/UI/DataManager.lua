-- Data Manager
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

-- String interning - reuse common strings to save memory
local INTERNED_STRINGS = {}
local function InternString(str)
    if not str then return str end
    if not INTERNED_STRINGS[str] then
        INTERNED_STRINGS[str] = str
    end
    return INTERNED_STRINGS[str]
end

-- Pre-intern common source types to avoid duplicates
INTERNED_STRINGS["Vendor"] = "Vendor"
INTERNED_STRINGS["Reputation"] = "Reputation"
INTERNED_STRINGS["Drop"] = "Drop"
INTERNED_STRINGS["Profession"] = "Profession"
INTERNED_STRINGS["Achievement"] = "Achievement"
INTERNED_STRINGS["Quest"] = "Quest"
INTERNED_STRINGS["Neutral"] = "Neutral"
INTERNED_STRINGS["Alliance"] = "Alliance"
INTERNED_STRINGS["Horde"] = "Horde"

-- Cache for aggregated items
local itemCache = nil
local filterOptionsCache = nil
local isInitialized = false

-- Filter result cache
local filteredResultsCache = nil
local lastFilterHash = nil

-- Batch loading state
local batchLoadInProgress = false

-- Helper function to get API data cache (stored in HousingDB for persistence)
local function GetApiDataCache()
    if not HousingDB then
        HousingDB = {}
    end
    if not HousingDB.apiDataCache then
        HousingDB.apiDataCache = {}
    end
    return HousingDB.apiDataCache
end

-- Quality names lookup (from Enum.ItemQuality)
local QUALITY_NAMES = {
    [0] = "Poor",
    [1] = "Common",
    [2] = "Uncommon",
    [3] = "Rare",
    [4] = "Epic",
    [5] = "Legendary",
    [6] = "Artifact",
    [7] = "Heirloom"
}

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
            return INTERNED_STRINGS["Horde"]
        end
    end
    
    for _, keyword in ipairs(allianceFactionKeywords) do
        if string.find(lowerText, keyword) then
            return INTERNED_STRINGS["Alliance"]
        end
    end
    
    return INTERNED_STRINGS["Neutral"]
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

-- Normalize expansion names to avoid duplicates
local function NormalizeExpansionName(expansion)
    if not expansion or expansion == "" then
        return expansion
    end

    local normalized = expansion:gsub(" ", "")

    local expansionMap = {
        ["TheBurningCrusade"] = "TheBurningCrusade",
        ["BurningCrusade"] = "TheBurningCrusade",
        ["WrathoftheLichKing"] = "WrathoftheLichKing",
        ["Wrath"] = "WrathoftheLichKing",
        ["MistsofPandaria"] = "MistsofPandaria",
        ["MistofPandaria"] = "MistsofPandaria",
        ["WarlordsofDraenor"] = "WarlordsofDraenor",
        ["BattleforAzeroth"] = "BattleforAzeroth",
        ["TheWarWithin"] = "TheWarWithin"
    }

    return expansionMap[normalized] or normalized
end

-- Get localized display name for expansion
local function GetLocalizedExpansionName(expansion)
    if not expansion or expansion == "" then
        return expansion
    end

    local L = _G.HousingVendorL or {}
    local key = "EXPANSION_" .. expansion:upper():gsub(" ", "")

    return L[key] or expansion
end

-- Get localized faction name
local function GetLocalizedFactionName(faction)
    if not faction or faction == "" then
        return faction
    end

    local L = _G.HousingVendorL or {}
    local key = "FACTION_" .. faction:upper():gsub(" ", "")

    return L[key] or faction
end

-- Get localized source type name
local function GetLocalizedSourceName(source)
    if not source or source == "" then
        return source
    end

    local L = _G.HousingVendorL or {}
    local key = "SOURCE_" .. source:upper():gsub(" ", "")

    return L[key] or source
end

-- Get localized quality name
local function GetLocalizedQualityName(quality)
    if not quality or quality == "" then
        return quality
    end

    local L = _G.HousingVendorL or {}
    local key = "QUALITY_" .. quality:upper():gsub(" ", "")

    return L[key] or quality
end

-- Get localized collection status
local function GetLocalizedCollectionStatus(status)
    if not status or status == "" then
        return status
    end

    local L = _G.HousingVendorL or {}
    local key = "COLLECTION_" .. status:upper():gsub(" ", "")

    return L[key] or status
end

-- Get localized requirement type
local function GetLocalizedRequirementName(requirement)
    if not requirement or requirement == "" then
        return requirement
    end

    local L = _G.HousingVendorL or {}
    local key = "REQUIREMENT_" .. requirement:upper():gsub(" ", "")

    return L[key] or requirement
end

-- Get localized category name
local function GetLocalizedCategoryName(category)
    if not category or category == "" then
        return category
    end

    local L = _G.HousingVendorL or {}
    local key = "CATEGORY_" .. category:upper():gsub(" ", "")

    return L[key] or category
end

-- Get localized type name
local function GetLocalizedTypeName(itemType)
    if not itemType or itemType == "" then
        return itemType
    end

    local L = _G.HousingVendorL or {}
    local key = "TYPE_" .. itemType:upper():gsub(" ", "")

    return L[key] or itemType
end

-- Aggregate all items from HousingDecorData and enrich with API
function DataManager:GetAllItems()
    -- Return cached data if available
    if itemCache then
        return itemCache
    end

    -- Reset batch loading state
    batchLoadInProgress = false

    local allItems = {}
    local filterOptions = {
        expansions = {},
        vendors = {},
        zones = {},
        types = {},
        categories = {},
        factions = {},
        sources = {},
        qualities = {},
        requirements = {}
    }

    -- Load from HousingDecorData and enrich with API
    if not HousingDecorData then
        print("|cFFFF4040HousingVendor:|r ERROR: HousingDecorData not loaded!")
        return {}
    end

    -- Iterate through all items in HousingDecorData
    for itemID, decorData in pairs(HousingDecorData) do
        local itemIDNum = tonumber(itemID)
        if itemIDNum then
            local itemName = decorData.name or "Unknown Item"

            -- Skip [DNT] items
            if not string.find(itemName, "%[DNT%]") then
                -- Create simplified item record (removed lowercase duplicates - compute on-demand)
                local itemRecord = {
                    name = itemName,
                    itemID = tostring(itemIDNum),
                    decorID = decorData.decorID,
                    modelFileID = decorData.modelFileID or "",
                    thumbnailFileID = decorData.iconFileID or "",

                    -- Core data
                    faction = "Neutral",
                    vendorName = nil,
                    vendorCoords = {x = 0, y = 0},
                    zoneName = nil,
                    expansionName = nil,
                    mapID = 0,

                    -- API data fields (lazy loaded)
                    _apiExpansion = nil,
                    _apiCategory = nil,
                    _apiSubcategory = nil,
                    _apiVendor = nil,
                    _apiZone = nil,
                    _apiQuality = nil,
                    _apiNumStored = 0,
                    _apiNumPlaced = 0,
                    _apiAchievement = nil,
                    _apiSourceText = nil,
                    _apiDataLoaded = false,

                    -- Source type (determined after enrichment)
                    _sourceType = "Vendor",
                    _isProfessionItem = false
                }

                -- Try to get cached API data
                local apiDataCache = GetApiDataCache()
                if apiDataCache[itemIDNum] then
                    local apiData = apiDataCache[itemIDNum]
                    itemRecord._apiExpansion = apiData.expansion
                    itemRecord._apiCategory = apiData.category
                    itemRecord._apiSubcategory = apiData.subcategory
                    itemRecord._apiVendor = apiData.vendor
                    itemRecord._apiZone = apiData.zone
                    itemRecord._apiQuality = apiData.quality
                    itemRecord._apiNumStored = apiData.numStored or 0
                    itemRecord._apiNumPlaced = apiData.numPlaced or 0
                    itemRecord._apiAchievement = apiData.achievement
                    itemRecord._apiSourceText = apiData.sourceText
                    itemRecord._sourceType = apiData.sourceType or "Vendor"
                    itemRecord._apiDataLoaded = true

                    -- Update vendor location data
                    if apiData.coords then itemRecord.vendorCoords = apiData.coords end
                    if apiData.mapID then itemRecord.mapID = apiData.mapID end
                    if apiData.vendor then itemRecord.vendorName = apiData.vendor end
                    if apiData.zone then itemRecord.zoneName = apiData.zone end
                    if apiData.expansion then
                        local normalized = NormalizeExpansionName(apiData.expansion)
                        itemRecord.expansionName = normalized
                    end

                    -- Update filter options from cached data
                    if apiData.expansion then
                        local normalized = NormalizeExpansionName(apiData.expansion)
                        filterOptions.expansions[normalized] = true
                    end
                    if apiData.category then filterOptions.categories[apiData.category] = true end
                    if apiData.subcategory then
                        filterOptions.types[apiData.subcategory] = true
                        -- Also add subcategory to categories for easier filtering
                        filterOptions.categories[apiData.subcategory] = true
                    end
                    if apiData.vendor then filterOptions.vendors[apiData.vendor] = true end
                    if apiData.zone then filterOptions.zones[apiData.zone] = true end
                    if apiData.sourceType then filterOptions.sources[apiData.sourceType] = true end
                    if apiData.qualityName then filterOptions.qualities[apiData.qualityName] = true end
                    -- Add to requirements filter, but skip "Profession" (already in Sources)
                    if apiData.requirementType and apiData.requirementType ~= "Profession" then 
                        filterOptions.requirements[apiData.requirementType] = true 
                    end
                end
                
                -- COMPREHENSIVE ENRICHMENT: Check ALL data files
                
                -- 1. VendorLocations - All expansion vendor data
                if HousingVendorLocations then
                    local expansions = {"Classic", "TheBurningCrusade", "WrathoftheLichKing", "Cataclysm",
                                       "MistsofPandaria", "WarlordsofDraenor", "Legion", "BattleforAzeroth",
                                       "Shadowlands", "Dragonflight", "TheWarWithin", "Midnight"}

                    -- Apply version filter to hide unavailable expansions (e.g., Midnight on live client)
                    if HousingVersionFilter then
                        local availableExpansions = {}
                        for _, expansion in ipairs(expansions) do
                            if HousingVersionFilter:ShouldShowExpansion(expansion) then
                                table.insert(availableExpansions, expansion)
                            end
                        end
                        expansions = availableExpansions
                    end

                    local vendorFound = false
                    for _, expansion in ipairs(expansions) do
                        if not vendorFound then
                            local expData = HousingVendorLocations[expansion]
                            if expData then
                                for zoneName, vendors in pairs(expData) do
                                    if not vendorFound then
                                        for _, vendorData in ipairs(vendors) do
                                            if not vendorFound and vendorData.items then
                                                for _, itemData in ipairs(vendorData.items) do
                                                    if itemData.itemID == itemIDNum then
                                                        -- Set vendor and zone info
                                                        if vendorData.vendorName then
                                                            itemRecord.vendorName = vendorData.vendorName
                                                            filterOptions.vendors[vendorData.vendorName] = true
                                                        end
                                                        
                                                        itemRecord.zoneName = zoneName
                                                        filterOptions.zones[zoneName] = true
                                                        
                                                        -- Set coordinates
                                                        if vendorData.coords then
                                                            itemRecord.vendorCoords = vendorData.coords
                                                            if vendorData.coords.mapID then
                                                                itemRecord.mapID = vendorData.coords.mapID
                                                            end
                                                        end
                                                        
                                                        -- Set expansion
                                                        local normalized = NormalizeExpansionName(expansion)
                                                        itemRecord.expansionName = normalized
                                                        filterOptions.expansions[normalized] = true
                                                        
                                                        -- Set faction (including Neutral)
                                                        if vendorData.faction then
                                                            itemRecord.faction = vendorData.faction
                                                            filterOptions.factions[vendorData.faction] = true
                                                        end
                                                        
                                                        -- Mark source type
                                                        if not itemRecord._sourceType then
                                                            itemRecord._sourceType = INTERNED_STRINGS["Vendor"]
                                                            filterOptions.sources[INTERNED_STRINGS["Vendor"]] = true
                                                        end
                                                        
                                                        vendorFound = true
                                                        break
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                
                -- 2. HousingReputations - Faction reputation rewards
                if HousingReputations then
                    for factionID, factionData in pairs(HousingReputations) do
                        if factionData.rewards then
                            for _, reward in ipairs(factionData.rewards) do
                                if reward.itemID == itemIDNum then
                                    itemRecord._sourceType = INTERNED_STRINGS["Reputation"]
                                    filterOptions.sources[INTERNED_STRINGS["Reputation"]] = true
                                    
                                    if factionData.vendor then
                                        if factionData.vendor.name then
                                            itemRecord.vendorName = factionData.vendor.name
                                            filterOptions.vendors[factionData.vendor.name] = true
                                        end
                                        if factionData.vendor.zone then
                                            itemRecord.zoneName = factionData.vendor.zone
                                            filterOptions.zones[factionData.vendor.zone] = true
                                        end
                                        if factionData.vendor.coords then
                                            itemRecord.vendorCoords = { x = factionData.vendor.coords.x, y = factionData.vendor.coords.y }
                                            if factionData.vendor.coords.mapID then
                                                itemRecord.mapID = factionData.vendor.coords.mapID
                                            end
                                        end
                                    end
                                    
                                    if factionData.expansion then
                                        local normalized = NormalizeExpansionName(factionData.expansion)
                                        itemRecord.expansionName = normalized
                                        filterOptions.expansions[normalized] = true
                                    end
                                    
                                    if factionData.faction then
                                        itemRecord.faction = factionData.faction
                                        filterOptions.factions[factionData.faction] = true
                                    end
                                    break
                                end
                            end
                        end
                    end
                end
                
                -- 2. HousingDrops - NPC/Boss drops
                if HousingDrops then
                    for _, dropData in ipairs(HousingDrops) do
                        if dropData.itemID == itemIDNum and dropData.sources and #dropData.sources > 0 then
                            itemRecord._sourceType = INTERNED_STRINGS["Drop"]
                            filterOptions.sources[INTERNED_STRINGS["Drop"]] = true
                            
                            local firstSource = dropData.sources[1]
                            if firstSource.npcName then
                                itemRecord.vendorName = firstSource.npcName or "Unknown"
                                filterOptions.vendors[itemRecord.vendorName] = true
                            end
                            
                            if dropData.zone then
                                itemRecord.zoneName = dropData.zone
                                filterOptions.zones[dropData.zone] = true
                            end
                            if firstSource.coords then
                                itemRecord.vendorCoords = { x = firstSource.coords.x, y = firstSource.coords.y }
                                if firstSource.coords.mapID then
                                    itemRecord.mapID = firstSource.coords.mapID
                                end
                            end
                            break
                        end
                    end
                end
                
                -- 3. HousingProfessions - Crafted items
                if HousingProfessions then
                    for _, profData in ipairs(HousingProfessions) do
                        if profData.itemID == itemIDNum then
                            itemRecord._sourceType = INTERNED_STRINGS["Profession"]
                            itemRecord._isProfessionItem = true
                            
                            -- Add specific profession name to sources (e.g., "Tailoring", "Cooking")
                            if profData.profession then
                                filterOptions.sources[profData.profession] = true
                                itemRecord.profession = profData.profession
                                itemRecord.vendorName = profData.profession
                                filterOptions.vendors[profData.profession] = true
                            end
                            
                            -- Store skill requirement
                            if profData.skill then
                                itemRecord.professionSkill = profData.skill
                                itemRecord.zoneName = profData.skill
                                filterOptions.zones[profData.skill] = true
                            end
                            
                            -- Store skill level needed
                            if profData.skillNeeded then
                                itemRecord.professionSkillNeeded = profData.skillNeeded
                            end
                            
                            -- Store spell and recipe IDs
                            if profData.spellID then
                                itemRecord.professionSpellID = profData.spellID
                            end
                            if profData.recipeID then
                                itemRecord.professionRecipeID = profData.recipeID
                            end
                            
                            break
                        end
                    end
                end
                
                -- 4. HousingAchievementRewards and HousingQuestRewards - Achievement/Quest rewards
                local collectionTables = {
                    {table = HousingAchievementRewards, type = "achievement"},
                    {table = HousingQuestRewards, type = "quest"},
                }
                
                for _, collSource in ipairs(collectionTables) do
                    if collSource.table then
                        for _, collData in ipairs(collSource.table) do
                            local matchFound = false
                            
                            -- Check single ID
                            if collData.itemID and collData.itemID == itemIDNum then
                                matchFound = true
                            end
                            
                            -- Check multiple IDs
                            if collData.itemIDs then
                                for _, id in ipairs(collData.itemIDs) do
                                    if id == itemIDNum then
                                        matchFound = true
                                        break
                                    end
                                end
                            end
                            
                            if matchFound then
                                if collSource.type == "achievement" then
                                    itemRecord._sourceType = INTERNED_STRINGS["Achievement"]
                                    filterOptions.sources[INTERNED_STRINGS["Achievement"]] = true
                                elseif collSource.type == "quest" then
                                    itemRecord._sourceType = INTERNED_STRINGS["Quest"]
                                    filterOptions.sources[INTERNED_STRINGS["Quest"]] = true
                                end
                                
                                if collData.category then
                                    local normalized = NormalizeExpansionName(collData.category)
                                    itemRecord.expansionName = normalized
                                    filterOptions.expansions[normalized] = true
                                end
                                
                                if collData.faction then
                                    itemRecord.faction = collData.faction
                                    filterOptions.factions[collData.faction] = true
                                end
                                break
                            end
                        end
                    end
                end
                
                -- 5. HousingMissingItems - New items from live API
                if HousingMissingItems then
                    local missingData = nil
                    local missingCategory = nil

                    for _, category in pairs({"vendor", "quest", "achievement", "profession", "miscellaneous"}) do
                        if HousingMissingItems[category] and HousingMissingItems[category][itemIDNum] then
                            missingData = HousingMissingItems[category][itemIDNum]
                            missingCategory = category
                            break
                        end
                    end

                    if missingData then
                        -- Set source type based on which category it came from
                        if missingCategory == "vendor" then
                            itemRecord._sourceType = INTERNED_STRINGS["Vendor"]
                            filterOptions.sources[INTERNED_STRINGS["Vendor"]] = true
                        elseif missingCategory == "quest" then
                            itemRecord._sourceType = INTERNED_STRINGS["Quest"]
                            filterOptions.sources[INTERNED_STRINGS["Quest"]] = true
                        elseif missingCategory == "achievement" then
                            itemRecord._sourceType = INTERNED_STRINGS["Achievement"]
                            filterOptions.sources[INTERNED_STRINGS["Achievement"]] = true
                        elseif missingCategory == "profession" then
                            itemRecord._sourceType = INTERNED_STRINGS["Profession"]
                            -- Add specific profession name to sources if available
                            if missingData.profession then
                                filterOptions.sources[missingData.profession] = true
                            end
                        elseif missingCategory == "miscellaneous" then
                            itemRecord._sourceType = "Miscellaneous"
                            filterOptions.sources["Miscellaneous"] = true
                        end

                        if missingData.vendors and #missingData.vendors > 0 then
                            local firstVendor = missingData.vendors[1]
                            if firstVendor.name then
                                itemRecord.vendorName = firstVendor.name
                                filterOptions.vendors[firstVendor.name] = true
                            end
                            if firstVendor.zone then
                                itemRecord.zoneName = firstVendor.zone
                                filterOptions.zones[firstVendor.zone] = true
                            end
                        end

                        if missingData.coordinates then
                            if missingData.coordinates.mapID then
                                itemRecord.mapID = missingData.coordinates.mapID
                            end
                            if missingData.coordinates.x and missingData.coordinates.y then
                                itemRecord.vendorCoords = {x = missingData.coordinates.x, y = missingData.coordinates.y}
                            end
                        end

                        if missingData.quality then
                            local qualityName = QUALITY_NAMES[missingData.quality] or "Common"
                            itemRecord._apiQuality = qualityName
                            filterOptions.qualities[qualityName] = true
                        end

                        if missingData.subcategoryNames and #missingData.subcategoryNames > 0 then
                            local subcat = missingData.subcategoryNames[1]
                            itemRecord._apiSubcategory = subcat
                            filterOptions.types[subcat] = true
                            filterOptions.categories[subcat] = true
                        end

                        itemRecord._fromMissingItems = true
                    end
                end
                
                -- 6. HousingMiscellaneous - Catch-all for other sources
                if HousingMiscellaneous and not itemRecord._sourceType then
                    for _, miscData in ipairs(HousingMiscellaneous) do
                        if miscData.itemID == itemIDNum then
                            itemRecord._sourceType = "Miscellaneous"
                            filterOptions.sources["Miscellaneous"] = true
                            break
                        end
                    end
                end

                table.insert(allItems, itemRecord)
            end
        end
    end

    -- Always ensure Wishlist is available
    filterOptions.sources["Wishlist"] = true

    -- Convert filter options to sorted arrays
    -- Special handling for expansions: ensure "The War Within" and "Midnight" are clearly separated
    local sortedExpansions = self:_SortKeys(filterOptions.expansions)
    -- Add visual indicator for Midnight (not yet released)
    for i, exp in ipairs(sortedExpansions) do
        if exp == "Midnight" then
            sortedExpansions[i] = "Midnight (Not Yet Released)"
        end
    end
    
    filterOptionsCache = {
        expansions = sortedExpansions,
        vendors = self:_SortKeys(filterOptions.vendors),
        zones = self:_SortKeys(filterOptions.zones),
        types = self:_SortKeys(filterOptions.types),
        categories = self:_SortKeys(filterOptions.categories),
        factions = self:_SortKeys(filterOptions.factions),
        sources = self:_SortKeys(filterOptions.sources),
        qualities = self:_SortKeys(filterOptions.qualities),
        requirements = self:_SortKeys(filterOptions.requirements)
    }
    
    -- Cache results
    itemCache = allItems

    -- Start batch loading API data for items that need it
    if HousingAPICache and not batchLoadInProgress then
        batchLoadInProgress = true
        C_Timer.After(0.1, function()
            DataManager:BatchLoadAPIData(allItems, filterOptions)
        end)
    end

    return allItems
end

-- Batch load API data for all items (50 items at a time)
function DataManager:BatchLoadAPIData(allItems, filterOptions)
    local itemsToLoad = {}

    -- Collect items that need API data loaded
    local apiDataCache = GetApiDataCache()
    for _, item in ipairs(allItems) do
        if item.itemID and item.itemID ~= "" and not item._apiDataLoaded then
            local itemID = tonumber(item.itemID)
            if itemID and not apiDataCache[itemID] then
                table_insert(itemsToLoad, {itemID = itemID, itemRecord = item})
            end
        end
    end

    if #itemsToLoad == 0 then
        batchLoadInProgress = false
        return
    end

    -- Silently load API data in background
    -- print("|cFF8A7FD4HousingVendor:|r Loading API data for " .. #itemsToLoad .. " items...")

    -- Process in batches of 50
    local batchSize = 50
    local currentBatch = 1

    local function ProcessBatch(startIndex)
        local endIndex = math.min(startIndex + batchSize - 1, #itemsToLoad)
        local apiDataCache = GetApiDataCache()

        for i = startIndex, endIndex do
            local entry = itemsToLoad[i]
            local itemID = entry.itemID
            local itemRecord = entry.itemRecord

            -- Use HousingAPICache for all API calls
            local apiExpansion = HousingAPICache:GetExpansion(itemID)
            local catalogData = HousingAPICache:GetCatalogData(itemID)
            local apiVendor = nil
            local apiZone = nil

            -- Get vendor info through cache
            local apiCost = nil
            local apiCoords = nil
            local apiMapID = nil
            local baseInfo = HousingAPI and HousingAPI:GetDecorItemInfoFromItemID(itemID)
            if baseInfo and baseInfo.decorID then
                local vendorInfo = HousingAPICache:GetVendorInfo(baseInfo.decorID)
                if vendorInfo then
                    apiVendor = vendorInfo.name
                    apiZone = vendorInfo.zone
                    -- Store cost data from API
                    if vendorInfo.cost and #vendorInfo.cost > 0 then
                        apiCost = vendorInfo.cost
                    end
                    -- Store coordinates from API
                    if vendorInfo.coords and vendorInfo.coords.x and vendorInfo.coords.y then
                        apiCoords = vendorInfo.coords
                    end
                    -- Store mapID from API
                    if vendorInfo.mapID then
                        apiMapID = vendorInfo.mapID
                    end
                end
            end

            -- Determine requirement type from catalog data
            local requirementType = "None"
            if catalogData then
                if catalogData.achievement or catalogData.achievementID then
                    requirementType = "Achievement"
                elseif catalogData.quest or catalogData.questID then
                    requirementType = "Quest"
                elseif catalogData.reputation then
                    requirementType = "Reputation"
                elseif catalogData.renown then
                    requirementType = "Renown"
                elseif catalogData.profession then
                    requirementType = "Profession"
                elseif catalogData.event then
                    requirementType = "Event"
                elseif catalogData.class then
                    requirementType = "Class"
                elseif catalogData.race then
                    requirementType = "Race"
                end
            end

            -- Get quality name
            local qualityValue = catalogData and catalogData.quality
            local qualityName = qualityValue and QUALITY_NAMES[qualityValue] or nil

            -- Cache the aggregated API data (including all rich fields)
            apiDataCache[itemID] = {
                expansion = apiExpansion,
                category = catalogData and catalogData.categoryNames and catalogData.categoryNames[1] or nil,
                subcategory = catalogData and catalogData.subcategoryNames and catalogData.subcategoryNames[1] or nil,
                vendor = apiVendor,
                zone = apiZone,
                cost = apiCost,
                coords = apiCoords,  -- Vendor coordinates from API
                mapID = apiMapID,    -- Map ID from API
                -- Additional rich data from API
                asset = catalogData and catalogData.asset or nil,
                quality = qualityValue,
                qualityName = qualityName,
                requirementType = requirementType,
                numStored = catalogData and catalogData.numStored or 0,
                numPlaced = catalogData and catalogData.numPlaced or 0,
                achievement = catalogData and catalogData.achievement or nil,
                sourceText = catalogData and catalogData.sourceText or nil,
                recordID = catalogData and catalogData.recordID or nil,
                entryType = catalogData and catalogData.entryType or nil
            }

            -- Update item record with all rich API data
            if itemRecord then
                local apiData = apiDataCache[itemID]
                itemRecord._apiExpansion = apiData.expansion
                itemRecord._apiCategory = apiData.category
                itemRecord._apiSubcategory = apiData.subcategory
                itemRecord._apiVendor = apiData.vendor
                itemRecord._apiZone = apiData.zone
                itemRecord._apiCost = apiData.cost
                -- Store additional rich data
                itemRecord._apiAsset = apiData.asset
                itemRecord._apiQuality = apiData.quality
                itemRecord._apiQualityName = apiData.qualityName
                itemRecord._apiRequirementType = apiData.requirementType
                itemRecord._apiNumStored = apiData.numStored
                itemRecord._apiNumPlaced = apiData.numPlaced
                itemRecord._apiAchievement = apiData.achievement
                itemRecord._apiSourceText = apiData.sourceText
                itemRecord._apiRecordID = apiData.recordID
                itemRecord._apiEntryType = apiData.entryType
                itemRecord._apiDataLoaded = true

                -- Update vendor location data on item record
                if apiData.coords then
                    itemRecord.vendorCoords = apiData.coords
                end
                if apiData.mapID then
                    itemRecord.mapID = apiData.mapID
                end
                if apiData.vendor then
                    itemRecord.vendorName = apiData.vendor
                end
                if apiData.zone then
                    itemRecord.zoneName = apiData.zone
                end
                if apiData.expansion then
                    local normalized = NormalizeExpansionName(apiData.expansion)
                    itemRecord.expansionName = normalized
                end

                -- Update filter options with API data
                if apiData.expansion then
                    local normalized = NormalizeExpansionName(apiData.expansion)
                    filterOptions.expansions[normalized] = true
                end
                if apiData.category then
                    filterOptions.categories[apiData.category] = true
                    -- Also add category to types for easier filtering
                    filterOptions.types[apiData.category] = true
                end
                if apiData.subcategory then
                    filterOptions.types[apiData.subcategory] = true
                    -- Also add subcategory to categories for easier filtering
                    filterOptions.categories[apiData.subcategory] = true
                end
                if apiData.vendor then
                    filterOptions.vendors[apiData.vendor] = true
                end
                if apiData.zone then
                    filterOptions.zones[apiData.zone] = true
                end
                if apiData.qualityName then
                    filterOptions.qualities[apiData.qualityName] = true
                end
                if apiData.requirementType then
                    filterOptions.requirements[apiData.requirementType] = true
                end
            end
        end

        -- Schedule next batch or complete
        if endIndex < #itemsToLoad then
            currentBatch = currentBatch + 1
            C_Timer.After(0, function()
                ProcessBatch(endIndex + 1)
            end)
        else
            -- All batches complete - refresh filter options and UI
            batchLoadInProgress = false

            -- Update filter options cache with new API data
            filterOptionsCache = {
                expansions = DataManager:_SortKeys(filterOptions.expansions),
                vendors = DataManager:_SortKeys(filterOptions.vendors),
                zones = DataManager:_SortKeys(filterOptions.zones),
                types = DataManager:_SortKeys(filterOptions.types),
                categories = DataManager:_SortKeys(filterOptions.categories),
                factions = DataManager:_SortKeys(filterOptions.factions),
                sources = DataManager:_SortKeys(filterOptions.sources),
                qualities = DataManager:_SortKeys(filterOptions.qualities),
                requirements = DataManager:_SortKeys(filterOptions.requirements)
            }

            -- Invalidate filter cache to force refresh
            filteredResultsCache = nil
            lastFilterHash = nil

            -- Silently refresh filters
            -- print("|cFF8A7FD4HousingVendor:|r API data loaded, refreshing filters...")

            -- Refresh filters
            C_Timer.After(0.1, function()
                if HousingFilters then
                    HousingFilters:ApplyFilters()
                end
            end)
        end
    end

    -- Start processing first batch
    ProcessBatch(1)
end

-- Get filter options (expansions, vendors, zones, etc.)
function DataManager:GetFilterOptions()
    if not filterOptionsCache then
        self:GetAllItems() -- This will populate filterOptionsCache
    end

    return filterOptionsCache
end

-- Get localized expansion name for display
function DataManager:GetLocalizedExpansionName(expansion)
    return GetLocalizedExpansionName(expansion)
end

-- Get localized faction name for display
function DataManager:GetLocalizedFactionName(faction)
    return GetLocalizedFactionName(faction)
end

-- Get localized source name for display
function DataManager:GetLocalizedSourceName(source)
    return GetLocalizedSourceName(source)
end

-- Get localized quality name for display
function DataManager:GetLocalizedQualityName(quality)
    return GetLocalizedQualityName(quality)
end

-- Get localized collection status for display
function DataManager:GetLocalizedCollectionStatus(status)
    return GetLocalizedCollectionStatus(status)
end

-- Get localized requirement name for display
function DataManager:GetLocalizedRequirementName(requirement)
    return GetLocalizedRequirementName(requirement)
end

-- Get localized category name for display
function DataManager:GetLocalizedCategoryName(category)
    return GetLocalizedCategoryName(category)
end

-- Get localized type name for display
function DataManager:GetLocalizedTypeName(itemType)
    return GetLocalizedTypeName(itemType)
end

-- Public method to check if an item is collected (for use by other modules)
-- Uses centralized CollectionAPI
function DataManager:IsItemCollected(itemID)
    if CollectionAPI then
        return CollectionAPI:IsItemCollected(itemID)
    end
    return false
end

-- Generate hash key from filter values
local function GetFilterHash(filters)
    return string.format("%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s",
        filters.searchText or "",
        filters.expansion or "",
        filters.vendor or "",
        filters.zone or "",
        filters.type or "",
        filters.category or "",
        filters.faction or "",
        filters.source or "",
        filters.collection or "",
        filters.quality or "",
        filters.requirement or "")
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
    
    -- Debug counters
    local debugCounts = {
        total = #items,
        searchFiltered = 0,
        expansionFiltered = 0,
        vendorFiltered = 0,
        zoneFiltered = 0,
        typeFiltered = 0,
        categoryFiltered = 0,
        factionFiltered = 0,
        sourceFiltered = 0,
        collectionFiltered = 0,
        qualityFiltered = 0,
        requirementFiltered = 0,
        visitedFiltered = 0
    }
    
    for _, item in ipairs(items) do
        local show = true
        
        -- Search filter - compute lowercase on-demand (memory optimization)
        if searchText ~= "" then
            local searchMatch = false
            
            -- Check core fields (convert to lowercase on-demand)
            if string.find(string.lower(item.name or ""), searchText) or
               string.find(string.lower(item.zoneName or ""), searchText) or
               string.find(string.lower(item.vendorName or ""), searchText) then
                searchMatch = true
            end
            
            -- Check API data if available
            if not searchMatch and item._apiDataLoaded then
                if (item._apiExpansion and string.find(string.lower(item._apiExpansion), searchText)) or
                   (item._apiCategory and string.find(string.lower(item._apiCategory), searchText)) or
                   (item._apiSubcategory and string.find(string.lower(item._apiSubcategory), searchText)) or
                   (item._apiVendor and string.find(string.lower(item._apiVendor), searchText)) or
                   (item._apiZone and string.find(string.lower(item._apiZone), searchText)) then
                    searchMatch = true
                end
            end
            
            if not searchMatch then
                show = false
                debugCounts.searchFiltered = debugCounts.searchFiltered + 1
            end
        end
        
        -- Expansion filter (check API data first, then fallback to static data)
        if show and filters.expansion and filters.expansion ~= "All Expansions" then
            -- Handle "Midnight (Not Yet Released)" filter label - match against "Midnight" expansion name
            local filterExpansion = filters.expansion
            if filterExpansion == "Midnight (Not Yet Released)" then
                filterExpansion = "Midnight"
            end
            
            local itemExpansion = item._apiExpansion or item.expansionName
            if itemExpansion ~= filterExpansion then
                show = false
                debugCounts.expansionFiltered = debugCounts.expansionFiltered + 1
            end
        end
        
        -- Vendor filter (check API data first, then fallback to static data)
        if show and filters.vendor and filters.vendor ~= "All Vendors" then
            local itemVendor = item._apiVendor or item.vendorName
            if itemVendor ~= filters.vendor then
                show = false
                debugCounts.vendorFiltered = debugCounts.vendorFiltered + 1
            end
        end
        
        -- Zone filter (check API data first, then fallback to static data)
        if show and filters.zone and filters.zone ~= "All Zones" then
            local itemZone = item._apiZone or item.zoneName
            if itemZone ~= filters.zone then
                show = false
                debugCounts.zoneFiltered = debugCounts.zoneFiltered + 1
            end
        end
        
        -- Type filter (check API subcategory, API category, then fallback to static type)
        if show and filters.type and filters.type ~= "All Types" then
            local matchesType = false
            -- Check API subcategory first (specific: Beds, Chairs, Tables, etc.)
            if item._apiSubcategory and item._apiSubcategory == filters.type then
                matchesType = true
            end
            -- Check API category (high-level: Furniture, Structural, etc.)
            if not matchesType and item._apiCategory and item._apiCategory == filters.type then
                matchesType = true
            end
            -- Fallback to static type
            if not matchesType and item.type and item.type == filters.type then
                matchesType = true
            end
            
            if not matchesType then
                show = false
                debugCounts.typeFiltered = debugCounts.typeFiltered + 1
            end
        end
        
        -- Category filter (check API category AND subcategory, then fallback to static category)
        if show and filters.category and filters.category ~= "All Categories" then
            local matchesCategory = false
            -- Check API category (high-level: Furniture, Structural, etc.)
            if item._apiCategory and item._apiCategory == filters.category then
                matchesCategory = true
            end
            -- Check API subcategory (specific: Beds, Chairs, Tables, etc.)
            if not matchesCategory and item._apiSubcategory and item._apiSubcategory == filters.category then
                matchesCategory = true
            end
            -- Fallback to static category
            if not matchesCategory and item.category and item.category == filters.category then
                matchesCategory = true
            end
            
            if not matchesCategory then
                show = false
                debugCounts.categoryFiltered = debugCounts.categoryFiltered + 1
            end
        end
        
        -- Faction filter
        -- When a specific faction is selected (Alliance or Horde), also show Neutral items
        if show and filters.faction and filters.faction ~= "All Factions" then
            local itemFaction = item.faction or "Neutral"
            if itemFaction ~= filters.faction and itemFaction ~= "Neutral" then
                show = false
                debugCounts.factionFiltered = debugCounts.factionFiltered + 1
            end
        end
        
        -- Source filter (Achievement, Quest, Drop, Vendor, Profession, Wishlist)
        if show and filters.source and filters.source ~= "All Sources" then
            if filters.source == "Wishlist" then
                -- Check if item is in wishlist
                local itemID = tonumber(item.itemID)
                if not itemID or not HousingDB or not HousingDB.wishlist or not HousingDB.wishlist[itemID] then
                    show = false
                    debugCounts.sourceFiltered = debugCounts.sourceFiltered + 1
                end
            elseif filters.source == "Crafted" then
                -- Check if item is a profession/crafted item using the stored flag
                if not item._isProfessionItem then
                    show = false
                    debugCounts.sourceFiltered = debugCounts.sourceFiltered + 1
                end
            else
                -- Check if filter is a specific profession name (Cooking, Tailoring, etc.)
                local isProfessionFilter = item._isProfessionItem and item.profession == filters.source
                
                -- Check item's source type
                local itemSource = item._sourceType or "Vendor"
                
                -- Show if either: exact source type match OR specific profession match
                if itemSource ~= filters.source and not isProfessionFilter then
                    show = false
                    debugCounts.sourceFiltered = debugCounts.sourceFiltered + 1
                end
            end
        end

        -- Collection filter (check quantity data first, then CollectionAPI - same logic as item bar)
        if show and filters.collection and filters.collection ~= "All" then
            local isCollected = false
            
            -- First check: Do we have quantity data showing ownership? (owned = collected)
            local numStored = item._apiNumStored or 0
            local numPlaced = item._apiNumPlaced or 0
            local totalOwned = numStored + numPlaced
            
            if totalOwned > 0 then
                isCollected = true
            else
                -- Fallback: Check via CollectionAPI (for items without quantity data yet)
                local itemID = tonumber(item.itemID)
                if itemID and CollectionAPI then
                    isCollected = CollectionAPI:IsItemCollected(itemID)
                end
            end
            
            if filters.collection == "Uncollected" and isCollected then
                show = false
                debugCounts.collectionFiltered = debugCounts.collectionFiltered + 1
            elseif filters.collection == "Collected" and not isCollected then
                show = false
                debugCounts.collectionFiltered = debugCounts.collectionFiltered + 1
            end
        end

        -- Quality filter (API data required)
        if show and filters.quality and filters.quality ~= "All Qualities" then
            local itemQuality = item._apiQuality
            if itemQuality then
                -- Map quality number to quality name
                local qualityNames = {
                    [0] = "Poor",
                    [1] = "Common",
                    [2] = "Uncommon",
                    [3] = "Rare",
                    [4] = "Epic",
                    [5] = "Legendary"
                }
                local qualityName = qualityNames[itemQuality]
                
                -- API data loaded - apply filter
                if qualityName ~= filters.quality then
                    show = false
                    debugCounts.qualityFiltered = debugCounts.qualityFiltered + 1
                end
            else
                -- No API data - hide item (filter requires API data)
                show = false
                debugCounts.qualityFiltered = debugCounts.qualityFiltered + 1
            end
        end

        -- Requirement filter (check if item has any requirements)
        if show and filters.requirement and filters.requirement ~= "All Requirements" then
            local itemRequirement = "None"
            
            -- Check HousingVendorItemToFaction lookup for reputation/renown items
            if HousingVendorItemToFaction then
                local repInfo = HousingVendorItemToFaction[tonumber(item.itemID)]
                if repInfo then
                    if repInfo.rep == "renown" then
                        itemRequirement = "Renown"
                    elseif repInfo.rep == "standard" or repInfo.rep == "friendship" then
                        itemRequirement = "Reputation"
                    end
                end
            end
            
            -- Check other requirement types if not reputation/renown
            if itemRequirement == "None" then
                if item._apiAchievement and item._apiAchievement ~= "" then
                    itemRequirement = "Achievement"
                elseif item._sourceType == INTERNED_STRINGS["Quest"] then
                    itemRequirement = "Quest"
                elseif item.professionSkillNeeded and item.professionSkillNeeded > 0 then
                    itemRequirement = "Profession"
                elseif item._apiRequirementType and item._apiRequirementType ~= "None" then
                    itemRequirement = item._apiRequirementType
                end
            end
            
            if itemRequirement ~= filters.requirement then
                show = false
                debugCounts.requirementFiltered = debugCounts.requirementFiltered + 1
            end
        end

        -- Hide Visited Vendors filter
        if show and filters.hideVisited and HousingCompletionTracker then
            -- Check if this vendor has been visited
            if item.npcID and HousingCompletionTracker:IsVendorVisited(item.npcID) then
                show = false
                debugCounts.visitedFiltered = debugCounts.visitedFiltered + 1
            end
        end

        -- Hide items with no valid data (question mark icons or missing tooltip info)
        if show then
            local itemID = item.itemID and tonumber(item.itemID) or nil
            
            -- Hide items with no itemID
            if not itemID or itemID == 0 then
                show = false
            else
                -- Check if icon cache explicitly has a question mark (definitely no data)
                local hasQuestionMark = false
                if HousingDB and HousingDB.iconCache then
                    local cacheKey = tostring(itemID)
                    local cachedIcon = HousingDB.iconCache[cacheKey]
                    if cachedIcon and (
                        cachedIcon == "Interface\\Icons\\INV_Misc_QuestionMark" or
                        string.find(cachedIcon, "INV_Misc_QuestionMark")
                    ) then
                        hasQuestionMark = true
                    end
                end
                
                -- Check if we can get item info (tooltip data available)
                local hasTooltipData = false
                if C_Item and C_Item.GetItemInfo then
                    local itemInfo = C_Item.GetItemInfo(itemID)
                    if itemInfo and itemInfo.iconFileID and itemInfo.iconFileID > 0 then
                        hasTooltipData = true
                    end
                end
                
                -- If we have API data loaded, assume item has valid data (even if icon not loaded yet)
                if item._apiDataLoaded then
                    hasTooltipData = true
                end
                
                -- Hide item if it has a question mark icon in cache AND no tooltip data
                if hasQuestionMark and not hasTooltipData then
                    show = false
                end
            end
        end

        if show then
            table.insert(filtered, item)
        end
    end

    -- Silently return filtered results
    -- Debug output removed to reduce chat spam

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
    apiDataCache = {}  -- Clear API data cache
end

-- Invalidate filter cache (call when collection status changes)
function DataManager:InvalidateFilterCache()
    filteredResultsCache = nil
    lastFilterHash = nil
end

-- Make globally accessible
_G["HousingDataManager"] = DataManager

return DataManager

