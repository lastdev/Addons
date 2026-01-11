-- Waypoint Manager Module
-- Handles both Blizzard native waypoints and TomTom integration

local ADDON_NAME, ns = ...

local WaypointManager = {}
WaypointManager.__index = WaypointManager

local pendingDestination = nil
local eventFrame = CreateFrame("Frame")
local lastMapID = nil
local HUB_COORDS = { x = 0.5, y = 0.5 } -- Generic fallback when we only know a hub mapID
local function RegisterZoneEvents()
    if not eventFrame:IsEventRegistered("ZONE_CHANGED_NEW_AREA") then
        eventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
    end
    if not eventFrame:IsEventRegistered("ZONE_CHANGED") then
        eventFrame:RegisterEvent("ZONE_CHANGED")
    end
    if not eventFrame:IsEventRegistered("ZONE_CHANGED_INDOORS") then
        eventFrame:RegisterEvent("ZONE_CHANGED_INDOORS")
    end
    if not eventFrame:IsEventRegistered("LOADING_SCREEN_DISABLED") then
        eventFrame:RegisterEvent("LOADING_SCREEN_DISABLED")
    end
    if not eventFrame:IsEventRegistered("PLAYER_ENTERING_WORLD") then
        eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    end
end

local function UnregisterZoneEvents()
    if eventFrame then
        eventFrame:UnregisterEvent("ZONE_CHANGED_NEW_AREA")
        eventFrame:UnregisterEvent("ZONE_CHANGED")
        eventFrame:UnregisterEvent("ZONE_CHANGED_INDOORS")
        eventFrame:UnregisterEvent("LOADING_SCREEN_DISABLED")
        eventFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")
    end
end

local function GetExpansionFromMapID(mapID)
    if not mapID or mapID == 0 then return nil end
    if HousingMapIDToExpansion and HousingMapIDToExpansion[mapID] then
        return HousingMapIDToExpansion[mapID]
    end
    return nil
end

-- Get a default mapID for an expansion (used when item.mapID is missing/invalid)
local function GetDefaultMapIDForExpansion(expansionName)
    if not expansionName then return nil end
    
    -- Map of expansion names to default mapIDs (main hub zones)
    local expansionDefaults = {
        ["The War Within"] = 2339,  -- Dornogal
        ["Dragonflight"] = 2112,    -- Valdrakken
        ["Shadowlands"] = 1670,     -- Oribos
        ["Battle for Azeroth"] = 1161, -- Boralus (Alliance) / 1165 Dazar'alor (Horde)
        ["Legion"] = 627,           -- Dalaran (Broken Isles)
        ["Warlords of Draenor"] = 622, -- Stormshield (Alliance) / 624 Warspear (Horde)
        ["Mists of Pandaria"] = 390, -- Shrine of Seven Stars (Alliance) / 392 Shrine of Two Moons (Horde)
        ["Cataclysm"] = 198,        -- Mount Hyjal
        ["Wrath of the Lich King"] = 125, -- Dalaran (Northrend)
        ["The Burning Crusade"] = 111, -- Shattrath
        ["Classic"] = 84            -- Stormwind (Alliance) / 85 Orgrimmar (Horde)
    }
    
    return expansionDefaults[expansionName]
end

local function IsSpecialTravelDestination(mapID)
    -- Certain zones are not realistically reachable via normal flying between zones and benefit from hub guidance.
    -- TWW: Undermine (multiple mapIDs observed across patches/builds).
    return mapID == 2706 or mapID == 2346
end

-- Get zone name from mapID
local function GetZoneNameFromMapID(mapID)
    if not mapID or mapID == 0 then return nil end

    if C_Map and C_Map.GetMapInfo then
        local success, mapInfo = pcall(function()
            return C_Map.GetMapInfo(mapID)
        end)
        if success and mapInfo and mapInfo.name then
            return mapInfo.name
        end
    end

    return nil
end

local function GetPortalRoom()
    local faction = UnitFactionGroup("player")

    if faction == "Alliance" then
        return {
            name = "Stormwind Portal Room",
            x = 49.0,
            y = 87.0,
            mapID = 84,
            zoneName = "Stormwind City"
        }
    elseif faction == "Horde" then
        return {
            name = "Orgrimmar Portal Room",
            x = 49.0,
            y = 38.0,
            mapID = 85,
            zoneName = "Orgrimmar"
        }
    end

    return nil
end

-- Find the specific portal for a given expansion in the current zone
-- Filters out opposing faction portals
local function FindPortalForExpansion(currentMapID, destinationExpansion, destinationMapID)
    if not HousingPortalData or not currentMapID or not destinationExpansion then
        return nil
    end

    -- Get player faction for filtering
    local playerFaction = UnitFactionGroup("player")

    -- Find portals in the current zone
    local currentZonePortals = nil
    for zoneName, portals in pairs(HousingPortalData) do
        if portals and #portals > 0 then
            for _, portal in ipairs(portals) do
                if portal.mapID == currentMapID then
                    currentZonePortals = portals
                    break
                end
            end
            if currentZonePortals then break end
        end
    end

    if not currentZonePortals then
        return nil
    end

    -- Find portal that matches the destination expansion
    -- Prioritize specific portal names over generic "Portal Room" entries
    -- Filter out opposing faction portals
    -- If destinationMapID is provided, prioritize portals that match it
    local specificPortal = nil
    local hubPortal = nil
    local mapIDMatchedPortal = nil
    local genericPortal = nil

    -- Define expansion hub portals (main cities for each expansion)
    -- Prioritize these over specialty zone portals when routing
    local hubPortalNames = {
        -- Battle for Azeroth
        ["Boralus"] = true,
        ["Dazar'alor"] = true,
        -- Shadowlands
        ["Oribos"] = true,
        -- Dragonflight
        ["Valdrakken"] = true,
        -- The War Within
        ["Dornogal"] = true,
        -- The Burning Crusade
        ["Shattrath"] = true,
        -- Wrath of the Lich King
        ["Dalaran"] = true,
        -- Legion
        ["Azsuna"] = true,
        -- Warlords of Draenor
        ["Stormshield"] = true,
        ["Warspear"] = true,
        -- Mists of Pandaria
        ["Paw'don Village"] = true,
        ["Paw'don Glade"] = true,
        -- Cataclysm
        ["Caverns of Time"] = true
    }

    for _, portal in ipairs(currentZonePortals) do
        if portal.destinationExpansion and portal.destinationExpansion == destinationExpansion then
            -- Skip opposing faction portals
            local isOpposingFaction = false
            if playerFaction == "Alliance" and (portal.name:find("Orgrimmar") or portal.name:find("Horde") or portal.name:find("Durotar")) then
                isOpposingFaction = true
            elseif playerFaction == "Horde" and (portal.name:find("Stormwind") or portal.name:find("Alliance") or portal.name:find("Stormshield")) then
                isOpposingFaction = true
            end

            if not isOpposingFaction then
                -- If destinationMapID is provided, check if portal matches it
                if destinationMapID and portal.destinationMapID and portal.destinationMapID == destinationMapID then
                    mapIDMatchedPortal = portal
                    break  -- Found exact mapID match, use it
                end

                -- Check if this is a specific portal (not a generic "Portal Room" entry)
                if portal.name and not string.find(portal.name, "Portal Room", 1, true) then
                    -- Prioritize hub portals over specialty zone portals
                    if hubPortalNames[portal.name] then
                        hubPortal = portal
                    elseif not specificPortal then
                        specificPortal = portal
                    end
                else
                    genericPortal = portal  -- Store generic portal as fallback
                end
            end
        end
    end

    -- Return in priority order: mapID match > hub portal > specific portal > generic portal
    return mapIDMatchedPortal or hubPortal or specificPortal or genericPortal
end

-- Find a portal/transport in the current zone that directly leads to a specific destination mapID.
-- This supports same-expansion travel methods like the Deeprun Tram.
local function FindPortalToDestinationMap(currentMapID, destinationMapID)
    if not HousingPortalData or not currentMapID or not destinationMapID then
        return nil
    end

    local playerFaction = UnitFactionGroup("player")

    for _, portals in pairs(HousingPortalData) do
        if portals and type(portals) == "table" then
            for _, portal in ipairs(portals) do
                if portal.mapID == currentMapID and (portal.destinationMapID == destinationMapID or portal.destMapID == destinationMapID) then
                    if portal.name and playerFaction == "Alliance" and (portal.name:find("Orgrimmar") or portal.name:find("Horde") or portal.name:find("Durotar")) then
                        -- Skip opposing faction portals
                    elseif portal.name and playerFaction == "Horde" and (portal.name:find("Stormwind") or portal.name:find("Alliance") or portal.name:find("Elwynn")) then
                        -- Skip opposing faction portals
                    else
                        return portal
                    end
                end
            end
        end
    end

    return nil
end
local function RequiresPortalTravel(currentMapID, destinationMapID)
    if not currentMapID or not destinationMapID then return false end
    if currentMapID == destinationMapID then return false end

    local currentExpansion = GetExpansionFromMapID(currentMapID)
    local destExpansion = GetExpansionFromMapID(destinationMapID)

    if not currentExpansion or not destExpansion then
        return false  -- If expansion unknown, assume no portal needed
    end

    -- Different expansions always need portals
    if currentExpansion ~= destExpansion then
        return true
    end

    -- Same expansion - check if portal data exists between these specific zones
    if not HousingPortalData then
        return false
    end

    -- Look for any portal from currentMapID that goes to destinationMapID
    for zoneName, portals in pairs(HousingPortalData) do
        if portals and type(portals) == "table" then
            for _, portal in ipairs(portals) do
                -- Check if this portal is in the current zone
                if portal.mapID == currentMapID then
                    -- Check if this portal goes to the destination zone
                    if portal.destinationMapID == destinationMapID or portal.destMapID == destinationMapID then
                        return true
                    end
                end
            end
        end
    end

    return false
end
local function FindNearestPortal(currentMapID, destinationMapID, currentX, currentY)
    if not HousingPortalData then return nil end

    local currentExpansion = GetExpansionFromMapID(currentMapID)
    local destinationExpansion = GetExpansionFromMapID(destinationMapID)

    if currentExpansion == destinationExpansion then
        return nil
    end

    local currentZonePortals = nil

    for zoneName, portals in pairs(HousingPortalData) do
        if portals and #portals > 0 then
            for _, portal in ipairs(portals) do
                if portal.mapID == currentMapID then
                    currentZonePortals = portals
                    break
                end
            end
            if currentZonePortals then break end
        end
    end

    if not currentZonePortals then return nil end

    local nearestPortal = nil
    local minDistance = math.huge

    for _, portal in ipairs(currentZonePortals) do
        if portal.mapID == currentMapID then
            local dx = (portal.x - currentX) * (portal.x - currentX)
            local dy = (portal.y - currentY) * (portal.y - currentY)
            local distance = math.sqrt(dx + dy)

            if distance < minDistance then
                minDistance = distance
                nearestPortal = portal
            end
        end
    end

    return nearestPortal
end
-- Invalidate player position cache
local function InvalidatePlayerPosition()
    playerPositionValid = false
end

local function GetPlayerPosition()
    -- Return cached position if valid
    if playerPositionValid and cachedPlayerMapID then
        return cachedPlayerMapID, cachedPlayerX, cachedPlayerY
    end
    
    -- Fetch fresh position
    local currentMapID = nil
    local currentX = nil
    local currentY = nil

    if C_Map and C_Map.GetBestMapForUnit then
        local success, mapID = pcall(function()
            return C_Map.GetBestMapForUnit("player")
        end)
        if success and mapID then
            currentMapID = mapID
        end
    end

    if C_Map and C_Map.GetPlayerMapPosition and currentMapID then
        local success, position = pcall(function()
            return C_Map.GetPlayerMapPosition(currentMapID, "player")
        end)
        if success and position then
            currentX, currentY = position:GetXY()
        end
    end

    -- Cache the result
    cachedPlayerMapID = currentMapID
    cachedPlayerX = currentX
    cachedPlayerY = currentY
    playerPositionValid = true

    return currentMapID, currentX, currentY
end
local function GetNearestFlightPoint(destinationMapID, destX, destY)
    if not C_TaxiMap or not C_TaxiMap.GetTaxiNodesForMap then
        return nil
    end

    local success, taxiNodes = pcall(function()
        return C_TaxiMap.GetTaxiNodesForMap(destinationMapID)
    end)

    if not success or not taxiNodes or #taxiNodes == 0 then
        return nil
    end

    local nearestNode = nil
    local minDistance = math.huge

    for _, node in ipairs(taxiNodes) do
        if node.position then
            local nodeX, nodeY = node.position:GetXY()
            local dx = (nodeX - destX) * (nodeX - destX)
            local dy = (nodeY - destY) * (nodeY - destY)
            local distance = math.sqrt(dx + dy)

            if distance < minDistance then
                minDistance = distance
                nearestNode = {
                    name = node.name,
                    x = nodeX * 100,
                    y = nodeY * 100,
                    mapID = destinationMapID,
                    nodeID = node.nodeID
                }
            end
        end
    end

    return nearestNode
end

local function SetBlizzardWaypoint(mapID, x, y)
    if not C_Map or not C_Map.SetUserWaypoint then
        return false, "Blizzard map API not available"
    end

    -- Get current player map for debugging
    local playerMapID = C_Map.GetBestMapForUnit("player")

    local success, err = pcall(function()
        C_Map.ClearUserWaypoint()
        local point = UiMapPoint.CreateFromCoordinates(mapID, x, y)
        C_Map.SetUserWaypoint(point)

        -- Enable super-tracking for the waypoint arrow
        if C_SuperTrack and C_SuperTrack.SetSuperTrackedUserWaypoint then
            -- Small delay to ensure waypoint exists before super-tracking
            C_Timer.After(0.1, function()
                C_SuperTrack.SetSuperTrackedUserWaypoint(true)

                -- Debug: Check if super-tracking succeeded
                if playerMapID ~= mapID then
                    print(string.format("|cFFF2CC8FHousingVendor:|r Arrow won't show - you're in zone %d, waypoint is in zone %d. Follow the route messages!",
                        playerMapID or 0, mapID))
                end
            end)
        end
    end)

    if not success then
        return false, tostring(err)
    end

    return true, nil
end
local function SetTomTomWaypoint(mapID, x, y, title)
    if not TomTom then
        return false, "TomTom addon not installed"
    end

    if not TomTom.AddWaypoint then
        return false, "TomTom.AddWaypoint not available"
    end

    local success, err = pcall(function()
        local waypointUID = TomTom:AddWaypoint(mapID, x, y, {
            title = title,
            persistent = false,
            minimap = true,
            world = true,
            crazy = true  -- Enable the "Crazy Arrow" for navigation
        })

        if not waypointUID then
            error("TomTom:AddWaypoint returned nil")
        end
    end)

    if not success then
        return false, tostring(err)
    end

    return true, nil
end
function WaypointManager:SetWaypoint(item)
    if not item then
        print("|cFFE63946HousingVendor:|r No item data provided")
        return false
    end

    if not item.coords or not item.coords.x or not item.coords.y then
        print("|cFFE63946HousingVendor:|r No valid coordinates for waypoint")
        return false
    end

    -- Handle missing or invalid mapID - use expansion name as fallback
    local effectiveMapID = item.mapID
    if not effectiveMapID or effectiveMapID == 0 then
        -- Try to get default mapID from expansion name
        if item.expansionName then
            effectiveMapID = GetDefaultMapIDForExpansion(item.expansionName)
            if effectiveMapID then
                print("|cFFF2CC8FHousingVendor:|r Using default mapID for " .. item.expansionName .. " (item mapID missing)")
            else
                print("|cFFE63946HousingVendor:|r No valid map ID for waypoint and no expansion name available")
                return false
            end
        else
            print("|cFFE63946HousingVendor:|r No valid map ID for waypoint")
            return false
        end
    end

    local x = item.coords.x / 100
    local y = item.coords.y / 100

    if x < 0 or x > 1 or y < 0 or y > 1 then
        print("|cFFE63946HousingVendor:|r Invalid coordinates: " .. tostring(x) .. ", " .. tostring(y))
        return false
    end

    local currentMapID, currentX, currentY = GetPlayerPosition()
    
    -- Verify we got valid player position
    if not currentMapID then
        print("|cFFE63946HousingVendor:|r Unable to detect current location. Please ensure you're in a valid game zone.")
        -- Try to set waypoint anyway as fallback
        -- Use VendorHelper for faction-aware vendor selection
        local vendorName = nil
        if _G.HousingVendorHelper then
            local Filters = _G.HousingFilters
            local filterVendor = Filters and Filters.currentFilters and Filters.currentFilters.vendor
            vendorName = _G.HousingVendorHelper:GetVendorName(item, filterVendor)
        else
            vendorName = item.vendorName or item._apiVendor  -- Prioritize hardcoded data over API
        end

        local blizzardSuccess = SetBlizzardWaypoint(effectiveMapID, x, y, vendorName)
        local tomtomSuccess = SetTomTomWaypoint(effectiveMapID, x, y, vendorName or locationName)

        if blizzardSuccess or tomtomSuccess then
            print(string.format("|cFF8A7FD4HousingVendor:|r Waypoint set to |cFF00FF00%s|r at %s",
                vendorName or "destination",
                coords))
            return true
        end
        return false
    end

    -- Use VendorHelper for faction-aware vendor and zone selection
    local vendorName = nil
    local zoneName = nil
    if _G.HousingVendorHelper then
        local Filters = _G.HousingFilters
        local filterVendor = Filters and Filters.currentFilters and Filters.currentFilters.vendor
        local filterZone = Filters and Filters.currentFilters and Filters.currentFilters.zone
        vendorName = _G.HousingVendorHelper:GetVendorName(item, filterVendor)
        zoneName = _G.HousingVendorHelper:GetZoneName(item, filterZone)
    else
        vendorName = item.vendorName or item._apiVendor  -- Prioritize hardcoded data over API
        zoneName = item.zoneName or item._apiZone  -- Prioritize hardcoded data over API
    end

    local locationName = vendorName or item.name or zoneName or "location"
    local currentExpansion = GetExpansionFromMapID(currentMapID)
    
    -- Try to get expansion from mapID first, fallback to item.expansionName
    local destinationExpansion = GetExpansionFromMapID(effectiveMapID)
    if not destinationExpansion and item.expansionName then
        destinationExpansion = item.expansionName
        if effectiveMapID ~= item.mapID then
            print("|cFFF2CC8FHousingVendor:|r Using expansion name '" .. destinationExpansion .. "' for portal routing")
        end
    end
    
    local destinationZoneName = GetZoneNameFromMapID(effectiveMapID) or zoneName or "Unknown Zone"
    local currentZoneName = GetZoneNameFromMapID(currentMapID) or "Unknown Location"
    local coords = string.format("%.1f, %.1f", item.coords.x, item.coords.y)

    -- Check if destination is in Stormwind/Orgrimmar (portal room cities)
    local portalRoom = GetPortalRoom()
    local isDestinationPortalCity = false
    if portalRoom and effectiveMapID == portalRoom.mapID then
        isDestinationPortalCity = true
    end

    -- Portal routing logic:
    -- 1) If PortalPathfinder can find a first portal, use it (regardless of expansion).
    -- 2) If destination is in another expansion, guide via portal room logic.
    -- 3) If destination is a special travel zone (e.g. Undermine), guide via hub inside the expansion.
    -- 4) Check if destination is a sub-zone that requires parent zone routing (SAME expansion only)
    local needsPortalTravel = false
    local isDifferentMap = (currentMapID ~= effectiveMapID)

    -- Determine if cross-expansion travel is needed
    if isDifferentMap and currentExpansion and destinationExpansion and currentExpansion ~= destinationExpansion then
        needsPortalTravel = true
    end

    -- Check for parent map relationships (sub-zones within zones)
    -- ONLY handle this if we're in the SAME expansion (otherwise portal routing takes priority)
    if isDifferentMap and not needsPortalTravel and HousingMapParents and HousingMapParents[effectiveMapID] then
        local parentMapID = HousingMapParents[effectiveMapID]
        -- If we're not in the parent zone, route to parent first
        if currentMapID ~= parentMapID then
            local parentZoneName = GetZoneNameFromMapID(parentMapID) or "parent zone"

            -- Check if there's a specific entrance location defined
            local entranceX, entranceY = 0.5, 0.5
            local entranceName = destinationZoneName

            if HousingMapEntrances and HousingMapEntrances[effectiveMapID] then
                -- Use specific entrance coordinates
                entranceX = HousingMapEntrances[effectiveMapID].x / 100
                entranceY = HousingMapEntrances[effectiveMapID].y / 100
                entranceName = destinationZoneName .. " entrance"
            else
                -- Fallback to portal room or zone center
                if parentMapID == 85 then  -- Orgrimmar - set to portal room area
                    entranceX, entranceY = 0.49, 0.38
                elseif parentMapID == 84 then  -- Stormwind - set to portal room area
                    entranceX, entranceY = 0.49, 0.87
                end
            end

            print(string.format("|cFF8A7FD4HousingVendor:|r Route to |cFF00FF00%s|r: Go to %s in %s",
                vendorName or locationName,
                entranceName,
                parentZoneName))

            SetBlizzardWaypoint(parentMapID, entranceX, entranceY, nil)
            SetTomTomWaypoint(parentMapID, entranceX, entranceY, entranceName)

            pendingDestination = {
                item = item,
                locationName = locationName,
            }
            RegisterZoneEvents()
            return true
        end
        -- If we ARE in the parent zone, continue to set waypoint normally (fall through)
    end

    if isDifferentMap and ns.PortalPathfinder and HousingPortalData then
        local pathfinder = ns.PortalPathfinder
        local firstPortal = pathfinder:GetFirstPortalInPath(
            currentMapID,
            effectiveMapID,
            item.coords.x,
            item.coords.y
        )

        if firstPortal and firstPortal.name and firstPortal.x and firstPortal.y and firstPortal.mapID then
            print(string.format("|cFF8A7FD4HousingVendor:|r Route to |cFF00FF00%s|r: Use |cFFFFFF00%s|r > %s",
                vendorName or locationName,
                firstPortal.name,
                destinationZoneName))

            local portalX = firstPortal.x / 100
            local portalY = firstPortal.y / 100

            SetBlizzardWaypoint(firstPortal.mapID, portalX, portalY, nil)
            SetTomTomWaypoint(firstPortal.mapID, portalX, portalY, firstPortal.name)

            pendingDestination = {
                item = item,
                locationName = locationName,
            }
            RegisterZoneEvents()
            return true
        end
    end

    -- If there's a direct portal/transport from the current zone to the destination map,
    -- guide the user to that (works even within the same expansion, e.g. Deeprun Tram).
    if isDifferentMap and HousingPortalData then
        local directPortal = FindPortalToDestinationMap(currentMapID, effectiveMapID)
        if directPortal and directPortal.mapID and directPortal.x and directPortal.y and directPortal.name then
            print(string.format("|cFF8A7FD4HousingVendor:|r Route to |cFF00FF00%s|r: Use |cFFFFFF00%s|r > %s",
                vendorName or locationName,
                directPortal.name,
                destinationZoneName))

            local portalX = directPortal.x / 100
            local portalY = directPortal.y / 100

            SetBlizzardWaypoint(directPortal.mapID, portalX, portalY, nil)
            SetTomTomWaypoint(directPortal.mapID, portalX, portalY, directPortal.name)

            pendingDestination = {
                item = item,
                locationName = locationName,
            }
            RegisterZoneEvents()
            return true
        end
    end

    -- Special routing for Undermine: ALWAYS route through Dornogal (regardless of expansion)
    -- Undermine is accessed via portal in Dornogal, not SW/Org portal rooms
    if isDifferentMap and destinationExpansion == "The War Within" and IsSpecialTravelDestination(effectiveMapID) then
        local hubMapID = 2339 -- Dornogal
        if currentMapID ~= hubMapID then
            -- If we're not in TWW zones, guide to Dornogal first
            if currentExpansion ~= "The War Within" then
                -- Go to Dornogal via portal room
                local underminePortalRoom = GetPortalRoom()
                if underminePortalRoom and currentMapID ~= underminePortalRoom.mapID then
                    -- Not in portal room yet, go there first
                    print(string.format("|cFF8A7FD4HousingVendor:|r Route to |cFF00FF00%s|r: Go to %s, use Portal to Dornogal",
                        vendorName or locationName,
                        underminePortalRoom.name))

                    pendingDestination = {
                        item = item,
                        locationName = locationName,
                    }
                    RegisterZoneEvents()

                    local portalX = underminePortalRoom.x / 100
                    local portalY = underminePortalRoom.y / 100
                    SetBlizzardWaypoint(underminePortalRoom.mapID, portalX, portalY, nil)
                    SetTomTomWaypoint(underminePortalRoom.mapID, portalX, portalY, underminePortalRoom.name)
                    return true
                else
                    -- In portal room, find and set waypoint to Portal to Dornogal
                    local dornogalPortal = FindPortalForExpansion(currentMapID, "The War Within", 2339)

                    if dornogalPortal and dornogalPortal.x and dornogalPortal.y then
                        print(string.format("|cFF8A7FD4HousingVendor:|r Route to |cFF00FF00%s|r: Use |cFFFFFF00%s|r, then continue to %s",
                            vendorName or locationName,
                            dornogalPortal.name,
                            destinationZoneName))

                        pendingDestination = {
                            item = item,
                            locationName = locationName,
                        }
                        RegisterZoneEvents()

                        local portalX = dornogalPortal.x / 100
                        local portalY = dornogalPortal.y / 100
                        SetBlizzardWaypoint(dornogalPortal.mapID, portalX, portalY, nil)
                        SetTomTomWaypoint(dornogalPortal.mapID, portalX, portalY, dornogalPortal.name)
                        return true
                    else
                        -- Fallback if portal not found
                        print(string.format("|cFF8A7FD4HousingVendor:|r Route to |cFF00FF00%s|r: Use Portal to Dornogal, then continue to %s",
                            vendorName or locationName,
                            destinationZoneName))

                        pendingDestination = {
                            item = item,
                            locationName = locationName,
                        }
                        RegisterZoneEvents()
                        return true
                    end
                end
            else
                -- Already in TWW but different zone, go to Dornogal hub
                print(string.format("|cFF8A7FD4HousingVendor:|r Route to |cFF00FF00%s|r: Go to |cFFFFFF00Dornogal|r first, then continue to %s",
                    vendorName or locationName,
                    destinationZoneName))

                pendingDestination = {
                    item = item,
                    locationName = locationName,
                    nextMapID = hubMapID,
                }

                RegisterZoneEvents()
                SetBlizzardWaypoint(hubMapID, HUB_COORDS.x, HUB_COORDS.y, "Dornogal")
                SetTomTomWaypoint(hubMapID, HUB_COORDS.x, HUB_COORDS.y, "Dornogal")
                return true
            end
        end
    end

    if needsPortalTravel then
        if portalRoom then
            -- Check if we're already in the portal room city
            local isInPortalCity = (currentMapID == portalRoom.mapID)

            if isDestinationPortalCity then
                -- Destination IS Stormwind/Orgrimmar - just set waypoint
                -- Continue to set waypoint below
            elseif isInPortalCity then
                -- We're in portal city, destination is another expansion - find and use specific portal
                local specificPortal = FindPortalForExpansion(currentMapID, destinationExpansion, effectiveMapID)

                if specificPortal and (specificPortal.x or specificPortal.worldX) then
                    print(string.format("|cFF8A7FD4HousingVendor:|r Route to |cFF00FF00%s|r: Use portal |cFFFFFF00%s|r",
                        vendorName or locationName,
                        specificPortal.name))

                    pendingDestination = {
                        item = item,
                        locationName = locationName
                    }

                    RegisterZoneEvents()

                    -- Set waypoint to the specific portal location
                    -- Some portals only have worldX/worldY (GPS coords), skip waypoint if so
                    if specificPortal.x and specificPortal.y then
                        local portalX = specificPortal.x / 100
                        local portalY = specificPortal.y / 100
                        SetBlizzardWaypoint(specificPortal.mapID, portalX, portalY, nil)
                        SetTomTomWaypoint(specificPortal.mapID, portalX, portalY, specificPortal.name)
                    end

                    return true
                else
                    -- Fallback to generic portal room message if specific portal not found
                    print(string.format("|cFF8A7FD4HousingVendor:|r Route to |cFF00FF00%s|r: Find portal to %s",
                        vendorName or locationName,
                        destinationExpansion or destinationZoneName))

                    pendingDestination = {
                        item = item,
                        locationName = locationName
                    }

                    RegisterZoneEvents()
                    return true
                end
            else
                -- We're not in portal city - check if current zone has portal to portal city (Stormwind/Orgrimmar)
                local currentZonePortal = FindPortalForExpansion(currentMapID, "Classic")

                if currentZonePortal and (currentZonePortal.x or currentZonePortal.worldX) then
                    -- Found portal in current zone to Stormwind/Orgrimmar
                    print(string.format("|cFF8A7FD4HousingVendor:|r Route to |cFF00FF00%s|r: Use |cFFFFFF00%s|r > %s",
                        vendorName or locationName,
                        currentZonePortal.name,
                        portalRoom.zoneName))

                    pendingDestination = {
                        item = item,
                        locationName = locationName
                    }

                    RegisterZoneEvents()

                    -- Set waypoint to the portal in CURRENT zone
                    if currentZonePortal.x and currentZonePortal.y then
                        local portalX = currentZonePortal.x / 100
                        local portalY = currentZonePortal.y / 100

                        SetBlizzardWaypoint(currentZonePortal.mapID, portalX, portalY, nil)
                        SetTomTomWaypoint(currentZonePortal.mapID, portalX, portalY, currentZonePortal.name)
                    end

                    return true
                else
                    -- No portal in current zone - navigate to portal city first
                    local specificPortal = FindPortalForExpansion(portalRoom.mapID, destinationExpansion, effectiveMapID)
                    
                    if specificPortal then
                        print(string.format("|cFF8A7FD4HousingVendor:|r Route to |cFF00FF00%s|r: Go to %s, use |cFFFFFF00%s|r",
                            vendorName or locationName,
                            portalRoom.name,
                            specificPortal.name))

                        pendingDestination = {
                            item = item,
                            locationName = locationName
                        }

                        RegisterZoneEvents()

                        -- Set waypoint to the PORTAL ROOM (not the specific portal)
                        local portalX = portalRoom.x / 100
                        local portalY = portalRoom.y / 100
                        
                        local blizzardSuccess, blizzardError = SetBlizzardWaypoint(portalRoom.mapID, portalX, portalY, nil)
                        local tomtomSuccess, tomtomError = SetTomTomWaypoint(portalRoom.mapID, portalX, portalY, portalRoom.name)

                        return true
                    else
                        -- Fallback to generic portal room if specific portal not found
                        print(string.format("|cFF8A7FD4HousingVendor:|r Route to |cFF00FF00%s|r: Go to %s, find portal to %s",
                            vendorName or locationName,
                            portalRoom.name,
                            destinationExpansion or destinationZoneName))

                        pendingDestination = {
                            item = item,
                            locationName = locationName
                        }

                        RegisterZoneEvents()

                        local portalX = portalRoom.x / 100
                        local portalY = portalRoom.y / 100
                        SetBlizzardWaypoint(portalRoom.mapID, portalX, portalY, nil)
                        SetTomTomWaypoint(portalRoom.mapID, portalX, portalY, portalRoom.name)

                        return true
                    end
                end
            end
        end
    end

    if pendingDestination and pendingDestination.item then
        local pendingItem = pendingDestination.item
        pendingDestination = nil
        UnregisterZoneEvents()
        return self:SetWaypoint(pendingItem)
    end

    -- Try to set both waypoints and capture results
    local blizzardSuccess, blizzardError = SetBlizzardWaypoint(effectiveMapID, x, y)
    local tomtomSuccess, tomtomError = SetTomTomWaypoint(effectiveMapID, x, y, locationName)

    -- Report results
    if blizzardSuccess or tomtomSuccess then
        local methods = {}
        if blizzardSuccess then table.insert(methods, "Blizzard") end
        if tomtomSuccess then table.insert(methods, "TomTom") end
        
        -- Show vendor name if available, otherwise just location
        local vendorInfoDisplay = ""
        if vendorName and vendorName ~= locationName then
            vendorInfoDisplay = string.format(" - |cFF00FF00%s|r", vendorName)
        end
        
        print(string.format("|cFF8A7FD4HousingVendor:|r Waypoint set to %s%s (%s)",
            locationName, vendorInfoDisplay, table.concat(methods, " + ")))
        
        -- Show errors for failed methods (only if one failed)
        if not blizzardSuccess and blizzardError and tomtomSuccess then
            -- Don't spam if Blizzard failed but TomTom worked
        end
        if not tomtomSuccess and tomtomError and blizzardSuccess then
            -- Don't spam if TomTom failed but Blizzard worked
        end
        
        return true
    else
        -- Both failed - show errors
        print("|cFFE63946HousingVendor:|r Failed to set waypoint to " .. locationName)
        if blizzardError then
            print("|cFFFF4040  - Blizzard:|r " .. blizzardError)
        end
        if tomtomError then
            print("|cFFFF4040  - TomTom:|r " .. tomtomError)
        end
        return false
    end
end
function WaypointManager:ClearPendingDestination()
    if pendingDestination then
        pendingDestination = nil
        UnregisterZoneEvents()
        return true
    end

    return false
end

function WaypointManager:ClearWaypoint()
    pendingDestination = nil
    UnregisterZoneEvents()
end

function WaypointManager:HasPendingDestination()
    return pendingDestination ~= nil
end

local function OnZoneChanged()
    if not pendingDestination or not pendingDestination.item then
        return
    end

    local currentMapID = nil
    if C_Map and C_Map.GetBestMapForUnit then
        local success, mapID = pcall(function()
            return C_Map.GetBestMapForUnit("player")
        end)
        if success and mapID then
            currentMapID = mapID
        end
    end

    if not currentMapID then
        return
    end

    if lastMapID == currentMapID then
        return
    end

    lastMapID = currentMapID

    -- Intermediate step support (e.g. guide to a hub first)
    if pendingDestination.nextMapID and currentMapID == pendingDestination.nextMapID then
        C_Timer.After(1.0, function()
            if pendingDestination and pendingDestination.item then
                local item = pendingDestination.item
                pendingDestination = nil
                UnregisterZoneEvents()
                WaypointManager:SetWaypoint(item)
            end
        end)
        return
    end

    local currentExpansion = GetExpansionFromMapID(currentMapID)
    
    -- Get effective mapID and expansion for pending destination
    local pendingMapID = pendingDestination.item.mapID
    if not pendingMapID or pendingMapID == 0 then
        pendingMapID = GetDefaultMapIDForExpansion(pendingDestination.item.expansionName)
    end
    
    local destinationExpansion = GetExpansionFromMapID(pendingMapID)
    if not destinationExpansion and pendingDestination.item.expansionName then
        destinationExpansion = pendingDestination.item.expansionName
    end

    if currentExpansion and destinationExpansion and currentExpansion == destinationExpansion then
        -- Arrived in destination expansion - set final waypoint
        C_Timer.After(1.5, function()
            if pendingDestination and pendingDestination.item then
                local item = pendingDestination.item
                pendingDestination = nil
                UnregisterZoneEvents()
                WaypointManager:SetWaypoint(item)
            end
        end)
    elseif currentExpansion == "Classic" and (currentMapID == 84 or currentMapID == 85) then
        -- Arrived in Stormwind/Orgrimmar portal room - set waypoint to expansion portal
        C_Timer.After(1.5, function()
            if pendingDestination and pendingDestination.item then
                local item = pendingDestination.item
                pendingDestination = nil
                UnregisterZoneEvents()
                WaypointManager:SetWaypoint(item)
            end
        end)
    end
end
-- Single event handler function (avoids creating closures)
local function OnEventHandler(self, event, ...)
    InvalidatePlayerPosition()  -- Invalidate cached position on any zone change

    -- Some travel methods (portals/hearth) update map state slightly after the event fires.
    if event == "LOADING_SCREEN_DISABLED" or event == "PLAYER_ENTERING_WORLD" then
        C_Timer.After(0.5, OnZoneChanged)
    else
        OnZoneChanged()
    end
    
end

eventFrame:SetScript("OnEvent", OnEventHandler)

function WaypointManager:Initialize()
    if C_Map and C_Map.GetBestMapForUnit then
        local success, mapID = pcall(function()
            return C_Map.GetBestMapForUnit("player")
        end)
        if success and mapID then
            lastMapID = mapID
        end
    end

    -- Silently initialize - no chat spam
end

_G["HousingWaypointManager"] = WaypointManager

return WaypointManager
