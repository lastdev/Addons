-- Waypoint Manager Module for HousingVendor addon
-- Handles both Blizzard native waypoints and TomTom integration

local WaypointManager = {}
WaypointManager.__index = WaypointManager

local pendingDestination = nil
local eventFrame = CreateFrame("Frame")
local lastMapID = nil
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
local function FindPortalForExpansion(currentMapID, destinationExpansion)
    if not HousingPortalData or not currentMapID or not destinationExpansion then
        return nil
    end

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
    local specificPortal = nil
    local genericPortal = nil
    
    for _, portal in ipairs(currentZonePortals) do
        if portal.destinationExpansion and portal.destinationExpansion == destinationExpansion then
            -- Check if this is a specific portal (not a generic "Portal Room" entry)
            if portal.name and not string.find(portal.name, "Portal Room", 1, true) then
                specificPortal = portal
                break  -- Found specific portal, use it
            else
                genericPortal = portal  -- Store generic portal as fallback
            end
        end
    end
    
    -- Return specific portal if found, otherwise return generic portal
    return specificPortal or genericPortal
end
local function RequiresPortalTravel(currentMapID, destinationMapID)
    if not currentMapID or not destinationMapID then return false end
    if currentMapID == destinationMapID then return false end

    local currentExpansion = GetExpansionFromMapID(currentMapID)
    local destExpansion = GetExpansionFromMapID(destinationMapID)

    if not currentExpansion or not destExpansion then
        return false  -- If expansion unknown, assume no portal needed
    end

    return currentExpansion ~= destExpansion
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

    local success, err = pcall(function()
        C_Map.ClearUserWaypoint()
        local point = UiMapPoint.CreateFromCoordinates(mapID, x, y)
        C_Map.SetUserWaypoint(point)

        if C_SuperTrack and C_SuperTrack.SetSuperTrackedUserWaypoint then
            C_SuperTrack.SetSuperTrackedUserWaypoint(true)
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
            world = true
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
        print("|cFFFF4040HousingVendor:|r No item data provided")
        return false
    end

    if not item.vendorCoords or not item.vendorCoords.x or not item.vendorCoords.y then
        print("|cFFFF4040HousingVendor:|r No valid coordinates for waypoint")
        return false
    end

    -- Handle missing or invalid mapID - use expansion name as fallback
    local effectiveMapID = item.mapID
    if not effectiveMapID or effectiveMapID == 0 then
        -- Try to get default mapID from expansion name
        if item.expansionName then
            effectiveMapID = GetDefaultMapIDForExpansion(item.expansionName)
            if effectiveMapID then
                print("|cFFFFAA00HousingVendor:|r Using default mapID for " .. item.expansionName .. " (item mapID missing)")
            else
                print("|cFFFF4040HousingVendor:|r No valid map ID for waypoint and no expansion name available")
                return false
            end
        else
            print("|cFFFF4040HousingVendor:|r No valid map ID for waypoint")
            return false
        end
    end

    local x = item.vendorCoords.x / 100
    local y = item.vendorCoords.y / 100

    if x < 0 or x > 1 or y < 0 or y > 1 then
        print("|cFFFF4040HousingVendor:|r Invalid coordinates: " .. tostring(x) .. ", " .. tostring(y))
        return false
    end

    local currentMapID, currentX, currentY = GetPlayerPosition()
    local locationName = item.vendorName or item.name or item.zoneName or "location"
    local currentExpansion = GetExpansionFromMapID(currentMapID)
    
    -- Try to get expansion from mapID first, fallback to item.expansionName
    local destinationExpansion = GetExpansionFromMapID(effectiveMapID)
    if not destinationExpansion and item.expansionName then
        destinationExpansion = item.expansionName
        if effectiveMapID ~= item.mapID then
            print("|cFFFFAA00HousingVendor:|r Using expansion name '" .. destinationExpansion .. "' for portal routing")
        end
    end
    
    local destinationZoneName = GetZoneNameFromMapID(effectiveMapID) or item.zoneName or "Unknown Zone"
    local currentZoneName = GetZoneNameFromMapID(currentMapID) or "Unknown Location"
    local coords = string.format("%.1f, %.1f", item.vendorCoords.x, item.vendorCoords.y)

    -- Debug: Show expansion detection
    if not currentExpansion and currentMapID then
        print("|cFFFF4040HousingVendor Debug:|r Current mapID " .. currentMapID .. " has no expansion mapping")
    end
    if not destinationExpansion then
        print("|cFFFF4040HousingVendor Debug:|r Could not determine destination expansion (mapID: " .. tostring(effectiveMapID) .. ", expansionName: " .. tostring(item.expansionName) .. ")")
    end

    -- Check if destination is in Stormwind/Orgrimmar (portal room cities)
    local portalRoom = GetPortalRoom()
    local isDestinationPortalCity = false
    if portalRoom and effectiveMapID == portalRoom.mapID then
        isDestinationPortalCity = true
    end

    -- Portal routing logic - use expansion comparison if we have both expansions
    local needsPortalTravel = false
    if currentMapID and destinationExpansion and currentExpansion then
        -- Both expansions known - compare them
        needsPortalTravel = (currentExpansion ~= destinationExpansion)
    elseif currentMapID and effectiveMapID then
        -- Fallback to mapID comparison
        needsPortalTravel = RequiresPortalTravel(currentMapID, effectiveMapID)
    end
    
    if needsPortalTravel then
        if portalRoom then
            -- Check if we're already in the portal room city
            local isInPortalCity = (currentMapID == portalRoom.mapID)

            if isDestinationPortalCity then
                -- Destination IS Stormwind/Orgrimmar - just set waypoint
                print("|cFF00FF00HousingVendor:|r Current: |cFFFFD100" .. currentZoneName .. "|r Destination: |cFFFFD100" .. destinationZoneName .. "|r")
                -- Continue to set waypoint below
            elseif isInPortalCity then
                -- We're in portal city, destination is another expansion - find and use specific portal
                local specificPortal = FindPortalForExpansion(currentMapID, destinationExpansion)
                
                if specificPortal then
                    print("|cFFFFAA00=== HousingVendor: Portal Routing ===|r")
                    print("|cFF00FF00Current:|r " .. currentZoneName)
                    print("|cFF00FF00Destination:|r " .. destinationZoneName .. " (" .. (destinationExpansion or "Unknown") .. ")")
                    print("|cFFFFD100Step:|r Use |cFF00FF00" .. specificPortal.name .. "|r")
                    print("|cFFFFD100Info:|r Waypoint will update when you arrive!")
                    print("|cFFFFAA00=============================|r")

                    pendingDestination = {
                        item = item,
                        locationName = locationName
                    }

                    -- Set waypoint to the specific portal location
                    local portalX = specificPortal.x / 100
                    local portalY = specificPortal.y / 100
                    SetBlizzardWaypoint(specificPortal.mapID, portalX, portalY)
                    SetTomTomWaypoint(specificPortal.mapID, portalX, portalY, specificPortal.name)

                    return true
                else
                    -- Fallback to generic portal room message if specific portal not found
                    print("|cFFFFAA00=== HousingVendor: Portal Routing ===|r")
                    print("|cFF00FF00Current:|r " .. currentZoneName)
                    print("|cFF00FF00Destination:|r " .. destinationZoneName .. " (" .. (destinationExpansion or "Unknown") .. ")")
                    print("|cFFFFD100Step:|r Use portal to |cFF00FF00" .. (destinationExpansion or destinationZoneName) .. "|r")
                    print("|cFFFFD100Info:|r Waypoint will update when you arrive!")
                    print("|cFFFFAA00=============================|r")

                    pendingDestination = {
                        item = item,
                        locationName = locationName
                    }

                    return true
                end
            else
                -- We're not in portal city - navigate there first, then use specific portal
                local specificPortal = FindPortalForExpansion(portalRoom.mapID, destinationExpansion)
                
                if specificPortal then
                    print("|cFFFFAA00=== HousingVendor: Portal Routing ===|r")
                    print("|cFF00FF00Current:|r " .. currentZoneName)
                    print("|cFF00FF00Destination:|r " .. destinationZoneName .. " (" .. (destinationExpansion or "Unknown") .. ")")
                    print("|cFFFFD100Step 1:|r Navigate to " .. portalRoom.name)
                    print("|cFFFFD100Step 2:|r Use |cFF00FF00" .. specificPortal.name .. "|r")
                    print("|cFFFFD100Step 3:|r Waypoint will update when you arrive!")
                    print("|cFFFFAA00=============================|r")

                    pendingDestination = {
                        item = item,
                        locationName = locationName
                    }

                    -- Set waypoint to the specific portal location (not the generic portal room)
                    local portalX = specificPortal.x / 100
                    local portalY = specificPortal.y / 100
                    SetBlizzardWaypoint(specificPortal.mapID, portalX, portalY)
                    SetTomTomWaypoint(specificPortal.mapID, portalX, portalY, specificPortal.name)

                    return true
                else
                    -- Fallback to generic portal room if specific portal not found
                    print("|cFFFFAA00=== HousingVendor: Portal Routing ===|r")
                    print("|cFF00FF00Current:|r " .. currentZoneName)
                    print("|cFF00FF00Destination:|r " .. destinationZoneName .. " (" .. (destinationExpansion or "Unknown") .. ")")
                    print("|cFFFFD100Step 1:|r Navigate to " .. portalRoom.name)
                    print("|cFFFFD100Step 2:|r Use portal to |cFF00FF00" .. (destinationExpansion or destinationZoneName) .. "|r")
                    print("|cFFFFD100Step 3:|r Waypoint will update when you arrive!")
                    print("|cFFFFAA00=============================|r")

                    pendingDestination = {
                        item = item,
                        locationName = locationName
                    }

                    local portalX = portalRoom.x / 100
                    local portalY = portalRoom.y / 100
                    SetBlizzardWaypoint(portalRoom.mapID, portalX, portalY)
                    SetTomTomWaypoint(portalRoom.mapID, portalX, portalY, portalRoom.name)

                    return true
                end
            end
        end
    end

    if pendingDestination and pendingDestination.item then
        local pendingItem = pendingDestination.item
        pendingDestination = nil
        return self:SetWaypoint(pendingItem)
    end

    SetBlizzardWaypoint(effectiveMapID, x, y)
    SetTomTomWaypoint(effectiveMapID, x, y, locationName)

    print("|cFF00FF00HousingVendor:|r Waypoint set to " .. locationName .. " at |cFFFFD100" .. coords .. "|r")

    return true
end
function WaypointManager:ClearPendingDestination()
    if pendingDestination then
        print("|cFF00FF00HousingVendor:|r Cleared pending destination")
        pendingDestination = nil
        return true
    end
    return false
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
        C_Timer.After(1.5, function()
            if pendingDestination and pendingDestination.item then
                local item = pendingDestination.item
                pendingDestination = nil
                WaypointManager:SetWaypoint(item)
            end
        end)
    end
end
-- Single event handler function (avoids creating closures)
local function OnEventHandler(self, event, ...)
    InvalidatePlayerPosition()  -- Invalidate cached position on any zone change
    OnZoneChanged()
end

eventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")  -- Most reliable single event for zone changes
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
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

    print("|cFF00FF00HousingVendor:|r Waypoint Manager initialized with automatic portal routing")
end

_G["HousingWaypointManager"] = WaypointManager

return WaypointManager
