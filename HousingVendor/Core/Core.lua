local Housing = {}

Housing.version = " 07.12.25.65"

-- Make Housing globally available
_G.Housing = Housing

-- Debug function to test map data integration (development only)
function Housing:TestMapData()
    if not HousingDebugPrint then return end
    
    HousingDebugPrint("Testing map data integration...")
    
    -- Check if HousingMapIDToExpansion is loaded
    if HousingMapIDToExpansion then
        local mapCount = 0
        for _ in pairs(HousingMapIDToExpansion) do
            mapCount = mapCount + 1
        end
        HousingDebugPrint("Map ID to Expansion mapping loaded with " .. mapCount .. " entries")
    else
        HousingDebugPrint("Map ID to Expansion mapping not loaded")
    end
    
    -- Test a specific expansion
    local testExpansion = "Classic"
    if HousingData and HousingData.vendorData and HousingData.vendorData[testExpansion] then
        local zoneCount = 0
        local itemCount = 0
        
        for zoneName, vendors in pairs(HousingData.vendorData[testExpansion]) do
            zoneCount = zoneCount + 1
            for _, vendor in ipairs(vendors) do
                if vendor and vendor.items then
                    for _, item in ipairs(vendor.items) do
                        itemCount = itemCount + 1
                    end
                end
            end
            if zoneCount >= 3 then break end
        end
        
        HousingDebugPrint(testExpansion .. " expansion has " .. zoneCount .. " zones with " .. itemCount .. " items")
    else
        HousingDebugPrint("Expansion " .. testExpansion .. " not found")
    end
end

-- Command to test map data (development only)
SLASH_HOUSING_TEST_MAP1 = "/hvtestmap"
SlashCmdList["HOUSING_TEST_MAP"] = function(msg)
    if Housing and Housing.TestMapData then
        Housing:TestMapData()
    end
end

-- Command to integrate map data (manual trigger - development only)
SLASH_HOUSING_MAP_INTEGRATE1 = "/hvmapintegrate"
SlashCmdList["HOUSING_MAP_INTEGRATE"] = function(msg)
    if HousingDebugPrint then
        HousingDebugPrint("Manual map integration triggered")
    end
end

-- Existing Housing commands
SLASH_HOUSING1 = "/hv"
SlashCmdList["HOUSING"] = function(msg)
    local _, _, cmd, args = string.find(msg, "%s?(%w+)%s?(.*)")
    
    if cmd == "version" then
        print("Version: " .. Housing.version)
    elseif cmd == "test" then
        print("HousingVendor addon is working!")
        print("Module status:")
        print("  HousingDataManager: " .. tostring(HousingDataManager ~= nil))
        print("  HousingIcons: " .. tostring(HousingIcons ~= nil))
        print("  HousingUINew: " .. tostring(HousingUINew ~= nil))
        print("  HousingItemList: " .. tostring(HousingItemList ~= nil))
        print("  HousingFilters: " .. tostring(HousingFilters ~= nil))
        print("  HousingPreviewPanel: " .. tostring(HousingPreviewPanel ~= nil))
        if HousingDataManager then
            local items = HousingDataManager:GetAllItems()
            print("  Items loaded: " .. #items)
        end
    elseif cmd == "models" then
        -- Test model mapping
        if HousingModelMapping then
            local count = 0
            for k,v in pairs(HousingModelMapping) do
                count = count + 1
            end
            
            print("HousingVendor Model Mapping Test:")
            print("  Total model mappings: " .. count)
            
            -- Test a few sample mappings
            local sampleItems = {"235523", "245275", "11454"}
            for _, itemId in ipairs(sampleItems) do
                local modelId = HousingModelMapping[itemId]
                if modelId then
                    print("  Item " .. itemId .. " -> Model ID: " .. modelId)
                else
                    print("  Item " .. itemId .. " -> No model mapping found")
                end
            end
        else
            print("HousingVendor Model Mapping Test: No model mapping data available")
        end
    elseif cmd == "portals" then
        -- Test portal data
        local portalData = HousingPortalData
        
        if portalData then
            local count = 0
            local zoneCount = 0
            for zoneName, portals in pairs(portalData) do
                zoneCount = zoneCount + 1
                count = count + #portals
            end
            
            print("HousingVendor Portal Data Test:")
            print("  Total zones with portals: " .. zoneCount)
            print("  Total portal locations: " .. count)
            
            -- Test finding a portal for a specific zone
            local testZone = "Stormwind City"
            if portalData[testZone] then
                print("  Portals available for " .. testZone .. ": " .. #portalData[testZone])
                for i, portal in ipairs(portalData[testZone]) do
                    print("    " .. i .. ". " .. portal.name .. " at (" .. portal.x .. ", " .. portal.y .. ") on map " .. (portal.mapID or "unknown"))
                end
            else
                print("  No portal data for " .. testZone)
            end
        else
            print("HousingVendor Portal Data Test: No portal data available")
        end
    elseif cmd == "config" then
        print("Configuration panel - coming soon")
    else
        -- Toggle new UI
        if HousingUINew and HousingUINew.Toggle then
            HousingUINew:Toggle()
        else
            print("HousingVendor UI not available - modules may not be loaded")
            print("  Run /hv test to check module status")
        end
    end
end

-- NOTE: All initialization is handled by Events.lua to avoid duplication
-- The OnInitialize, OnEnable, OnDisable, and PLAYER_LOGIN functions have been removed
-- as they duplicated logic in Events.lua and created conflicting defaults