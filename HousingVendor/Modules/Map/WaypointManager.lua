-- Waypoint Manager Module
-- Handles both Blizzard native waypoints and TomTom integration

local ADDON_NAME, ns = ...

local WaypointManager = {}
WaypointManager.__index = WaypointManager

local pendingDestination = nil
local lastWaypoint = nil
local activeWaypointContext = nil
local tomtomWaypointUID = nil
local eventFrame = CreateFrame("Frame")
local lastMapID = nil
local HUB_COORDS = { x = 0.5, y = 0.5 } -- Generic fallback when we only know a hub mapID

local function IsTomTomIntegrationEnabled()
    return not (HousingDB and HousingDB.settings and HousingDB.settings.useTomTomIntegration == false)
end

local function AcquireTomTom()
    local tt = _G.TomTom
    if tt then
        return tt
    end

    -- TomTom is usually loaded at login, but some clients disable it or it may be load-on-demand.
    -- Attempt a safe load before giving up.
    if C_AddOns and C_AddOns.LoadAddOn then
        local loaded = false
        if C_AddOns.IsAddOnLoaded then
            loaded = C_AddOns.IsAddOnLoaded("TomTom")
        end
        if not loaded then
            pcall(function()
                C_AddOns.LoadAddOn("TomTom")
            end)
        end
    elseif LoadAddOn then
        pcall(function()
            LoadAddOn("TomTom")
        end)
    end

    return _G.TomTom
end

local function NormalizeCoord01(v)
    if type(v) ~= "number" then
        return nil
    end
    -- Some callers/data use 0-100. TomTom expects 0-1.
    if v > 1 and v <= 100 then
        return v / 100
    end
    return v
end
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

local function BuildMapAncestry(mapID)
    local ancestry = {}
    local current = mapID
    local safety = 0
    while current and current ~= 0 and safety < 10 do
        ancestry[current] = true
        if C_Map and C_Map.GetMapInfo then
            local info = C_Map.GetMapInfo(current)
            current = info and info.parentMapID or nil
        else
            current = nil
        end
        safety = safety + 1
    end
    return ancestry
end

local function GetExpansionFromMapID(mapID)
    if not mapID or mapID == 0 then return nil end
    if HousingMapIDToExpansion and HousingMapIDToExpansion[mapID] then
        return HousingMapIDToExpansion[mapID]
    end
    if HousingMapIDToExpansion and C_Map and C_Map.GetMapInfo then
        local ancestry = BuildMapAncestry(mapID)
        for ancestorID in pairs(ancestry) do
            if HousingMapIDToExpansion[ancestorID] then
                return HousingMapIDToExpansion[ancestorID]
            end
        end
    end
    return nil
end

-- Get a default mapID for an expansion (used when item.mapID is missing/invalid)
local function GetDefaultMapIDForExpansion(expansionName)
    if not expansionName then return nil end
    
    -- Map of expansion names to default mapIDs (main hub zones)
    local expansionDefaults = {
        ["Midnight"] = 2351,        -- Razorwind Shores
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

    local ancestry = BuildMapAncestry(currentMapID)

    -- Find portals in the current zone
    local currentZonePortals = nil
    for zoneName, portals in pairs(HousingPortalData) do
        if portals and #portals > 0 then
            for _, portal in ipairs(portals) do
                local portalMapID = portal.mapID
                local portalZoneMapID = portal.zoneMapID
                if (portalMapID and ancestry[portalMapID]) or (portalZoneMapID and ancestry[portalZoneMapID]) then
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
        -- Midnight
        ["Razorwind Shores"] = true,
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

    local ancestry = BuildMapAncestry(currentMapID)

    for _, portals in pairs(HousingPortalData) do
        if portals and type(portals) == "table" then
            for _, portal in ipairs(portals) do
                local portalMapID = portal.mapID
                local portalZoneMapID = portal.zoneMapID
                local matchesZone = (portalMapID and ancestry[portalMapID]) or (portalZoneMapID and ancestry[portalZoneMapID])
                if matchesZone and (portal.destinationMapID == destinationMapID or portal.destMapID == destinationMapID) then
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

local function SetLastWaypoint(mapID, x, y, name, npcID)
    if not mapID or not x or not y then
        return
    end
    lastWaypoint = {
        mapID = mapID,
        x = x,
        y = y,
        name = name,
        npcID = npcID,
    }
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

                -- Blizzard's super-tracked waypoint arrow is zone-limited; if TomTom is available it will still guide you cross-zone.
                if (not TomTom) and playerMapID ~= mapID then
                    if _G.HousingVendorLog and _G.HousingVendorLog.Info then
                        _G.HousingVendorLog:Info(string.format(
                            "Blizzard waypoint arrow only shows in the destination zone (you are in %d, destination is %d).",
                            playerMapID or 0,
                            mapID
                        ))
                    end
                end
            end)
        end
    end)

    if not success then
        if _G.HousingVendorLog and _G.HousingVendorLog.Info then
            _G.HousingVendorLog:Info("TomTom waypoint failed: " .. tostring(err))
        end
        return false, tostring(err)
    end

    SetLastWaypoint(mapID, x, y,
        (activeWaypointContext and activeWaypointContext.name) or nil,
        (activeWaypointContext and activeWaypointContext.npcID) or nil)
    return true, nil
end
local function SetTomTomWaypoint(mapID, x, y, title)
    if not IsTomTomIntegrationEnabled() then
        return false, nil
    end

    local tt = AcquireTomTom()
    if not tt then
        return false, "TomTom addon not installed"
    end

    if not tt.AddWaypoint then
        return false, "TomTom.AddWaypoint not available"
    end

    mapID = tonumber(mapID)
    x = NormalizeCoord01(x)
    y = NormalizeCoord01(y)
    if not mapID or not x or not y then
        return false, "Invalid TomTom waypoint parameters"
    end

    local success, err = pcall(function()
        -- Ensure we only keep one active TomTom waypoint from HousingVendor, otherwise minimap fills with old vendor icons.
        if tomtomWaypointUID and tt.RemoveWaypoint then
            pcall(function()
                tt:RemoveWaypoint(tomtomWaypointUID)
            end)
            tomtomWaypointUID = nil
        end

        local waypointUID = tt:AddWaypoint(mapID, x, y, {
            title = title,
            persistent = false,
            minimap = true,
            world = true,
            crazy = (tt.SetCrazyArrow ~= nil), -- Enable the "Crazy Arrow" when available
            silent = true,
            from = ADDON_NAME,
        })

        if not waypointUID then
            error("TomTom:AddWaypoint returned nil")
        end

        tomtomWaypointUID = waypointUID
    end)

    if not success then
        return false, tostring(err)
    end

    SetLastWaypoint(mapID, x, y,
        (activeWaypointContext and activeWaypointContext.name) or title,
        (activeWaypointContext and activeWaypointContext.npcID) or nil)
    return true, nil
end
function WaypointManager:SetWaypoint(item)
    if not item then
        print("|cFFE63946HousingVendor:|r No item data provided")
        return false
    end

    local Filters = _G.HousingFilters
    local filterVendor = Filters and Filters.currentFilters and Filters.currentFilters.vendor
    local filterZone = Filters and Filters.currentFilters and Filters.currentFilters.zone
    local filterMapID = Filters and Filters.currentFilters and Filters.currentFilters.zoneMapID

    local resolvedCoords = nil
    if _G.HousingVendorHelper and _G.HousingVendorHelper.GetVendorCoords then
        resolvedCoords = _G.HousingVendorHelper:GetVendorCoords(item, filterVendor, filterZone, filterMapID)
    end
    resolvedCoords = resolvedCoords or item.coords or item.vendorCoords

    if not resolvedCoords or not resolvedCoords.x or not resolvedCoords.y then
        print("|cFFE63946HousingVendor:|r No valid coordinates for waypoint")
        return false
    end

    -- Clear any stale pending destination from a previous waypoint request.
    -- This prevents old pending routes from triggering duplicate messages
    -- when a new waypoint is requested before the previous route was completed.
    if pendingDestination then
        pendingDestination = nil
        UnregisterZoneEvents()
    end

    -- Handle missing or invalid mapID - use expansion name as fallback
    local effectiveMapID = (resolvedCoords and resolvedCoords.mapID) or item.mapID or nil
    if not effectiveMapID or effectiveMapID == 0 then
        -- Try to get default mapID from expansion name
        if item.expansionName then
            effectiveMapID = GetDefaultMapIDForExpansion(item.expansionName)
            if effectiveMapID then
                if _G.HousingVendorLog and _G.HousingVendorLog.Info then
                    _G.HousingVendorLog:Info("Using default mapID for " .. item.expansionName .. " (item mapID missing)")
                end
            else
                print("|cFFE63946HousingVendor:|r No valid map ID for waypoint and no expansion name available")
                return false
            end
        else
            print("|cFFE63946HousingVendor:|r No valid map ID for waypoint")
            return false
        end
    end

    -- Coordinates are expected in percentage format (0-100).
    -- Some data sources store world-space coordinates (e.g. negative or >1000).
    -- If so, attempt to convert world coords -> map percent using Blizzard APIs.
    local xPct = resolvedCoords.x
    local yPct = resolvedCoords.y

    if xPct < 0 or xPct > 100 or yPct < 0 or yPct > 100 then
        local converted = false

        if C_Map and C_Map.GetMapPosFromWorldPos and CreateVector2D then
            local ok, pos = pcall(function()
                return C_Map.GetMapPosFromWorldPos(effectiveMapID, CreateVector2D(xPct, yPct))
            end)
            if ok and pos and pos.x and pos.y then
                xPct = pos.x * 100
                yPct = pos.y * 100
                converted = true
            end
        end

        if not converted and HousingVendor and HousingVendor.ConvertAbsoluteToPercent then
            local ok, cx, cy = pcall(function()
                return HousingVendor:ConvertAbsoluteToPercent(xPct, yPct, effectiveMapID)
            end)
            if ok and cx and cy then
                xPct = cx
                yPct = cy
                converted = true
            end
        end

        if not converted then
            print("|cFFE63946HousingVendor:|r Coordinates appear to be world-space and could not be converted for this map.")
            return false
        end
    end

    -- Convert percent to 0-1 for Blizzard API
    local x = xPct / 100
    local y = yPct / 100
    local coords = string.format("%.1f, %.1f", xPct, yPct)

    if x < 0 or x > 1 or y < 0 or y > 1 then
        print("|cFFE63946HousingVendor:|r Invalid coordinates: " .. tostring(xPct) .. ", " .. tostring(yPct))
        return false
    end

    local currentMapID, currentX, currentY = GetPlayerPosition()

    -- Debug: Log current position
    if _G.HousingVendorLog and _G.HousingVendorLog.Info then
        _G.HousingVendorLog:Info(string.format(
            "SetWaypoint: Player at mapID=%s, x=%.2f, y=%.2f | Destination: mapID=%s",
            tostring(currentMapID or "nil"),
            currentX or 0,
            currentY or 0,
            tostring(effectiveMapID)
        ))
    end

    -- Verify we got valid player position
    if not currentMapID then
        print("|cFFE63946HousingVendor:|r Unable to detect current location. Please ensure you're in a valid game zone.")
        -- Try to set waypoint anyway as fallback
        -- Use VendorHelper for faction-aware vendor selection
        local vendorName = nil
        local npcID = tonumber(item.npcID)
        if _G.HousingVendorHelper then
            local Filters = _G.HousingFilters
            local filterVendor = Filters and Filters.currentFilters and Filters.currentFilters.vendor
            local filterZone = Filters and Filters.currentFilters and Filters.currentFilters.zone
            local filterMapID = Filters and Filters.currentFilters and Filters.currentFilters.zoneMapID
            vendorName = _G.HousingVendorHelper:GetVendorName(item, filterVendor, filterZone, filterMapID)
            if _G.HousingVendorHelper.GetVendorNPCID then
                npcID = _G.HousingVendorHelper:GetVendorNPCID(item, filterVendor, filterZone, filterMapID)
            end
        else
            vendorName = item.vendorName or item._apiVendor  -- Prioritize hardcoded data over API
        end

        activeWaypointContext = { name = vendorName or locationName, npcID = npcID }
        local blizzardSuccess = SetBlizzardWaypoint(effectiveMapID, x, y, vendorName)
        local tomtomSuccess = SetTomTomWaypoint(effectiveMapID, x, y, vendorName or locationName)

        if blizzardSuccess or tomtomSuccess then
            print("|cFF8A7FD4HousingVendor:|r " .. string.format("Waypoint set to %s at %s", vendorName or "destination", coords))
            return true
        end
        return false
    end

    -- Use VendorHelper for faction-aware vendor and zone selection
    local vendorName = nil
    local zoneName = nil
    local npcID = tonumber(item.npcID)
    if _G.HousingVendorHelper then
        local Filters = _G.HousingFilters
        local filterVendor = Filters and Filters.currentFilters and Filters.currentFilters.vendor
        local filterZone = Filters and Filters.currentFilters and Filters.currentFilters.zone
        local filterMapID = Filters and Filters.currentFilters and Filters.currentFilters.zoneMapID
        vendorName = _G.HousingVendorHelper:GetVendorName(item, filterVendor, filterZone, filterMapID)
        zoneName = _G.HousingVendorHelper:GetZoneName(item, filterZone, filterMapID)
        if _G.HousingVendorHelper.GetVendorNPCID then
            npcID = _G.HousingVendorHelper:GetVendorNPCID(item, filterVendor, filterZone, filterMapID)
        end
    else
        vendorName = item.vendorName or item._apiVendor  -- Prioritize hardcoded data over API
        zoneName = item.zoneName or item._apiZone  -- Prioritize hardcoded data over API
    end

    local locationName = vendorName or item.name or zoneName or "location"
    activeWaypointContext = { name = vendorName or locationName, npcID = npcID }
    local currentExpansion = GetExpansionFromMapID(currentMapID)
    
    -- Try to get expansion from mapID first, fallback to item.expansionName
    local destinationExpansion = GetExpansionFromMapID(effectiveMapID)
    if not destinationExpansion and item.expansionName then
        destinationExpansion = item.expansionName
        if effectiveMapID ~= item.mapID then
            if _G.HousingVendorLog and _G.HousingVendorLog.Info then
                _G.HousingVendorLog:Info("Using expansion name '" .. destinationExpansion .. "' for portal routing")
            end
        end
    end
    
    local destinationZoneName = GetZoneNameFromMapID(effectiveMapID) or zoneName or "Unknown Zone"
    local currentZoneName = GetZoneNameFromMapID(currentMapID) or "Unknown Location"
    -- `coords` string already computed from resolved coordinates above.

    -- Consistent route message: Vendor @ Zone (Expansion) - Action
    local function PrintRoute(action)
        local vName = vendorName or locationName
        local expStr = destinationExpansion and (" (" .. destinationExpansion .. ")") or ""
        print("|cFF8A7FD4HousingVendor:|r " .. vName .. " @ " .. destinationZoneName .. expStr .. " - " .. action)
    end

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

    -- Check if the PLAYER is in a child/instanced zone whose parent is the destination zone.
    -- Example: player is in garrison (mapID 582), destination is outdoor Shadowmoon Valley (539).
    -- HousingMapParents[582] = 539, so the player is already in the right area.
    -- In this case, clear isDifferentMap so we fall through to set the waypoint directly.
    -- The child-map adjustment at the end of SetWaypoint (lines 1191-1199) will remap the
    -- waypoint onto the player's current mapID so the Blizzard arrow works correctly.
    if isDifferentMap and not needsPortalTravel and HousingMapParents and HousingMapParents[currentMapID] then
        local playerParent = HousingMapParents[currentMapID]
        if playerParent == effectiveMapID then
            isDifferentMap = false
        end
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

            PrintRoute("Go to " .. entranceName .. " in " .. parentZoneName)

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
            resolvedCoords.x,
            resolvedCoords.y
        )

        if firstPortal and firstPortal.name and firstPortal.x and firstPortal.y and firstPortal.mapID then
            PrintRoute("Portal: " .. firstPortal.name)

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
            PrintRoute("Portal: " .. directPortal.name)

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

    -- Same-expansion fallback: if the destination has a known portal in the Stormwind/Orgrimmar portal room,
    -- guide the user there even when expansions match (useful for nested maps like Founder's Point vs Dornogal).
    if isDifferentMap and (not needsPortalTravel) and HousingPortalData then
        local portalRoom = GetPortalRoom()
        if portalRoom then
            local portalFromRoom = FindPortalForExpansion(portalRoom.mapID, destinationExpansion, effectiveMapID)
            if portalFromRoom and portalFromRoom.name then
                if currentMapID == portalRoom.mapID then
                    if portalFromRoom.x and portalFromRoom.y then
                        PrintRoute("Portal: " .. portalFromRoom.name)

                        pendingDestination = { item = item, locationName = locationName }
                        RegisterZoneEvents()

                        local portalX = portalFromRoom.x / 100
                        local portalY = portalFromRoom.y / 100
                        SetBlizzardWaypoint(portalFromRoom.mapID, portalX, portalY, nil)
                        SetTomTomWaypoint(portalFromRoom.mapID, portalX, portalY, portalFromRoom.name)
                        return true
                    end
                else
                    local currentZonePortal = FindPortalForExpansion(currentMapID, "Classic")
                    if currentZonePortal and currentZonePortal.name and currentZonePortal.x and currentZonePortal.y then
                        PrintRoute("Portal: " .. currentZonePortal.name .. " > " .. portalRoom.zoneName)

                        pendingDestination = { item = item, locationName = locationName }
                        RegisterZoneEvents()

                        local portalX = currentZonePortal.x / 100
                        local portalY = currentZonePortal.y / 100
                        SetBlizzardWaypoint(currentZonePortal.mapID, portalX, portalY, nil)
                        SetTomTomWaypoint(currentZonePortal.mapID, portalX, portalY, currentZonePortal.name)
                        return true
                    end

                    PrintRoute("Go to " .. portalRoom.name .. " > " .. portalFromRoom.name)

                    pendingDestination = { item = item, locationName = locationName }
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
                    PrintRoute("Go to " .. underminePortalRoom.name .. " > Portal to Dornogal")

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
                        PrintRoute("Portal: " .. dornogalPortal.name .. " > " .. destinationZoneName)

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
                        PrintRoute("Portal to Dornogal > " .. destinationZoneName)

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
                PrintRoute("Go to Dornogal > " .. destinationZoneName)

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
            -- Check if we're already in the portal room city or a sub-zone of it
            -- Build ancestry to handle cases where player is in a phased/instanced version
            local ancestry = BuildMapAncestry(currentMapID)
            local isInPortalCity = (currentMapID == portalRoom.mapID) or ancestry[portalRoom.mapID]

            -- Debug: Log portal room detection
            if _G.HousingVendorLog and _G.HousingVendorLog.Info then
                _G.HousingVendorLog:Info(string.format(
                    "Portal routing: isInPortalCity=%s (currentMapID=%s, portalRoom.mapID=%s)",
                    tostring(isInPortalCity),
                    tostring(currentMapID),
                    tostring(portalRoom.mapID)
                ))
            end

            if isDestinationPortalCity then
                -- Destination IS Stormwind/Orgrimmar - just set waypoint
                -- Continue to set waypoint below
            elseif isInPortalCity then
                -- We're in portal city, destination is another expansion - find and use specific portal
                -- Always search using the base portal room mapID, not a potential sub-zone
                local searchMapID = portalRoom.mapID
                local specificPortal = FindPortalForExpansion(searchMapID, destinationExpansion, effectiveMapID)

                -- Debug: Log portal search result
                if _G.HousingVendorLog and _G.HousingVendorLog.Info then
                    if specificPortal then
                        _G.HousingVendorLog:Info(string.format(
                            "Found portal: name=%s, x=%s, y=%s, mapID=%s, worldX=%s, worldY=%s",
                            specificPortal.name or "nil",
                            tostring(specificPortal.x),
                            tostring(specificPortal.y),
                            tostring(specificPortal.mapID),
                            tostring(specificPortal.worldX),
                            tostring(specificPortal.worldY)
                        ))
                    else
                        _G.HousingVendorLog:Info("No portal found for destination")
                    end
                end

                if specificPortal and (specificPortal.x or specificPortal.worldX) then
                    PrintRoute("Portal: " .. specificPortal.name)

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
                        -- Use the portal's mapID (should be the base portal room mapID)
                        local waypointMapID = specificPortal.mapID or portalRoom.mapID

                        if _G.HousingVendorLog and _G.HousingVendorLog.Info then
                            _G.HousingVendorLog:Info(string.format(
                                "Setting waypoint to portal at %.2f, %.2f on mapID %s (currentMapID: %s)",
                                portalX * 100,
                                portalY * 100,
                                tostring(waypointMapID),
                                tostring(currentMapID)
                            ))
                        end

                        local blizzSuccess, blizzErr = SetBlizzardWaypoint(waypointMapID, portalX, portalY, nil)
                        local tomSuccess, tomErr = SetTomTomWaypoint(waypointMapID, portalX, portalY, specificPortal.name)

                        if not blizzSuccess and not tomSuccess then
                            print("|cFFE63946HousingVendor:|r Warning: Failed to set waypoint to " .. (specificPortal.name or "portal"))
                            if blizzErr then
                                if _G.HousingVendorLog and _G.HousingVendorLog.Warn then
                                    _G.HousingVendorLog:Warn("Blizzard waypoint error: " .. tostring(blizzErr))
                                end
                            end
                            if tomErr and not TomTom then
                                print("|cFFFFAA00Tip:|r Install TomTom addon for better cross-zone navigation arrows")
                            end
                        end
                    else
                        -- Portal only has GPS coordinates, can't set visual waypoint
                        if _G.HousingVendorLog and _G.HousingVendorLog.Warn then
                            _G.HousingVendorLog:Warn(string.format(
                                "Portal '%s' only has GPS coordinates, cannot set visual waypoint",
                                specificPortal.name or "unknown"
                            ))
                        end
                    end

                    return true
                else
                    -- Fallback to generic portal room message if specific portal not found
                    PrintRoute("Find portal to " .. (destinationExpansion or destinationZoneName))

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
                    PrintRoute("Portal: " .. currentZonePortal.name .. " > " .. portalRoom.zoneName)

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
                        -- Check if player is already very close to portal room coordinates
                        -- This handles cases where detection might be slightly off
                        local distanceToPortalRoom = nil
                        if currentX and currentY then
                            local dx = (currentX * 100) - portalRoom.x
                            local dy = (currentY * 100) - portalRoom.y
                            distanceToPortalRoom = math.sqrt(dx * dx + dy * dy)
                        end

                        -- If player is within 5 yards of portal room, consider them already there
                        -- and skip directly to setting portal waypoint
                        if distanceToPortalRoom and distanceToPortalRoom < 5 then
                            if _G.HousingVendorLog and _G.HousingVendorLog.Info then
                                _G.HousingVendorLog:Info(string.format(
                                    "Player is already at portal room (distance: %.1f), setting portal waypoint directly",
                                    distanceToPortalRoom
                                ))
                            end

                            PrintRoute("Portal: " .. specificPortal.name)

                            pendingDestination = {
                                item = item,
                                locationName = locationName
                            }

                            RegisterZoneEvents()

                            -- Set waypoint to the specific portal (not the portal room)
                            if specificPortal.x and specificPortal.y then
                                local portalX = specificPortal.x / 100
                                local portalY = specificPortal.y / 100
                                SetBlizzardWaypoint(specificPortal.mapID, portalX, portalY, nil)
                                SetTomTomWaypoint(specificPortal.mapID, portalX, portalY, specificPortal.name)
                            end

                            return true
                        end

                        PrintRoute("Go to " .. portalRoom.name .. " > " .. specificPortal.name)

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
                        PrintRoute("Go to " .. portalRoom.name .. " > find portal to " .. (destinationExpansion or destinationZoneName))

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
        if _G.HousingVendorLog and _G.HousingVendorLog.Info then
            _G.HousingVendorLog:Info("SetWaypoint: Found pending destination, clearing and recursively calling SetWaypoint")
        end

        local pendingItem = pendingDestination.item
        pendingDestination = nil
        UnregisterZoneEvents()
        return self:SetWaypoint(pendingItem)
    end

    -- If you're on a child map of the destination zone (e.g. Founder's Point inside Dornogal),
    -- prefer placing the waypoint on your current child map so the Blizzard arrow can appear.
    local waypointMapID = effectiveMapID
    if C_Map and C_Map.GetMapInfo then
        local info = C_Map.GetMapInfo(currentMapID)
        if info and info.parentMapID and info.parentMapID == effectiveMapID then
            waypointMapID = currentMapID
        end
    end

    -- Try to set both waypoints and capture results
    -- If we're adjusting mapID for the Blizzard arrow, keep TomTom aligned to the same mapID too.
    if _G.HousingVendorLog and _G.HousingVendorLog.Info then
        _G.HousingVendorLog:Info(string.format(
            "SetWaypoint: Setting final waypoint to %s at %.1f, %.1f on mapID %s",
            locationName or "destination",
            x * 100,
            y * 100,
            tostring(waypointMapID)
        ))
    end

    local tomtomSuccess, tomtomError = SetTomTomWaypoint(waypointMapID, x, y, locationName)
    local blizzardSuccess, blizzardError = SetBlizzardWaypoint(waypointMapID, x, y)

    -- Report results
    if blizzardSuccess or tomtomSuccess then
        PrintRoute("Waypoint set")
        
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
        print("|cFFE63946HousingVendor:|r " .. (vendorName or locationName) .. " @ " .. destinationZoneName .. " \xe2\x80\x94 Waypoint failed")
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
        lastWaypoint = nil
        activeWaypointContext = nil

        if TomTom and tomtomWaypointUID and TomTom.RemoveWaypoint then
            pcall(function()
                TomTom:RemoveWaypoint(tomtomWaypointUID)
            end)
            tomtomWaypointUID = nil
        end

        if C_Map and C_Map.ClearUserWaypoint then
            pcall(function()
                C_Map.ClearUserWaypoint()
            end)
        end

        if C_SuperTrack and C_SuperTrack.SetSuperTrackedUserWaypoint then
            pcall(function()
                C_SuperTrack.SetSuperTrackedUserWaypoint(false)
            end)
        end
        UnregisterZoneEvents()
        return true
    end

    return false
end

function WaypointManager:ClearWaypoint()
    pendingDestination = nil
    lastWaypoint = nil
    activeWaypointContext = nil

    if TomTom and tomtomWaypointUID and TomTom.RemoveWaypoint then
        pcall(function()
            TomTom:RemoveWaypoint(tomtomWaypointUID)
        end)
        tomtomWaypointUID = nil
    end

    if C_Map and C_Map.ClearUserWaypoint then
        pcall(function()
            C_Map.ClearUserWaypoint()
        end)
    end

    if C_SuperTrack and C_SuperTrack.SetSuperTrackedUserWaypoint then
        pcall(function()
            C_SuperTrack.SetSuperTrackedUserWaypoint(false)
        end)
    end
    UnregisterZoneEvents()
end

function WaypointManager:HasPendingDestination()
    return pendingDestination ~= nil
end

function WaypointManager:GetActiveWaypointInfo()
    return lastWaypoint
end

function WaypointManager:GetActiveWaypointDistance()
    if not lastWaypoint or not lastWaypoint.mapID then
        return nil, "No waypoint"
    end

    if not (C_Map and C_Map.GetBestMapForUnit and C_Map.GetPlayerMapPosition) then
        return nil, "No map"
    end

    local playerMapID = C_Map.GetBestMapForUnit("player")
    if not playerMapID then
        return nil, "No map"
    end

    if playerMapID ~= lastWaypoint.mapID then
        -- Check if player is in a sub-zone (like a Garrison) of the waypoint's zone
        if HousingMapParents and HousingMapParents[playerMapID] == lastWaypoint.mapID then
            -- Player is in an instanced sub-zone, show helpful exit message
            local zoneName = GetZoneNameFromMapID(lastWaypoint.mapID)
            return nil, "Exit to " .. (zoneName or "parent zone")
        end
        return nil, "Different zone"
    end

    local posOk, pos = pcall(C_Map.GetPlayerMapPosition, lastWaypoint.mapID, "player")
    if not posOk then pos = nil end
    if not pos or not pos.x or not pos.y or (pos.x == 0 and pos.y == 0) then
        return nil, "Unknown"
    end

    local px, py = pos.x * 100, pos.y * 100
    local tx, ty = lastWaypoint.x * 100, lastWaypoint.y * 100
    local dx = px - tx
    local dy = py - ty
    return math.sqrt(dx * dx + dy * dy) * 1.25
end

local function OnZoneChanged()
    if not pendingDestination or not pendingDestination.item then
        if _G.HousingVendorLog and _G.HousingVendorLog.Info then
            _G.HousingVendorLog:Info("OnZoneChanged: No pending destination")
        end
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
        if _G.HousingVendorLog and _G.HousingVendorLog.Info then
            _G.HousingVendorLog:Info("OnZoneChanged: Could not get current mapID")
        end
        return
    end

    if lastMapID == currentMapID then
        if _G.HousingVendorLog and _G.HousingVendorLog.Info then
            _G.HousingVendorLog:Info(string.format("OnZoneChanged: Same mapID (%s), skipping", tostring(currentMapID)))
        end
        return
    end

    if _G.HousingVendorLog and _G.HousingVendorLog.Info then
        _G.HousingVendorLog:Info(string.format(
            "OnZoneChanged: Moved from mapID %s to %s",
            tostring(lastMapID or "nil"),
            tostring(currentMapID)
        ))
    end

    lastMapID = currentMapID

    -- Intermediate step support (e.g. guide to a hub first)
    if pendingDestination.nextMapID and currentMapID == pendingDestination.nextMapID then
        if _G.HousingVendorLog and _G.HousingVendorLog.Info then
            _G.HousingVendorLog:Info(string.format(
                "OnZoneChanged: Reached intermediate hub (mapID %s), setting next waypoint in 1.0s",
                tostring(currentMapID)
            ))
        end

        C_Timer.After(1.0, function()
            if pendingDestination and pendingDestination.item then
                if _G.HousingVendorLog and _G.HousingVendorLog.Info then
                    _G.HousingVendorLog:Info("OnZoneChanged: Setting next waypoint after intermediate hub")
                end

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

    if _G.HousingVendorLog and _G.HousingVendorLog.Info then
        _G.HousingVendorLog:Info(string.format(
            "OnZoneChanged: currentExp=%s, destExp=%s, pendingMapID=%s, locationName=%s",
            tostring(currentExpansion or "nil"),
            tostring(destinationExpansion or "nil"),
            tostring(pendingMapID or "nil"),
            tostring(pendingDestination.locationName or "nil")
        ))
    end

    if currentExpansion and destinationExpansion and currentExpansion == destinationExpansion then
        -- Arrived in destination expansion - set final waypoint
        if _G.HousingVendorLog and _G.HousingVendorLog.Info then
            _G.HousingVendorLog:Info("OnZoneChanged: Arrived in destination expansion! Setting final waypoint in 1.5s")
        end

        C_Timer.After(1.5, function()
            if pendingDestination and pendingDestination.item then
                if _G.HousingVendorLog and _G.HousingVendorLog.Info then
                    _G.HousingVendorLog:Info("OnZoneChanged: Timer fired, setting final waypoint now")
                end

                local item = pendingDestination.item
                pendingDestination = nil
                UnregisterZoneEvents()
                WaypointManager:SetWaypoint(item)
            else
                if _G.HousingVendorLog and _G.HousingVendorLog.Warn then
                    _G.HousingVendorLog:Warn("OnZoneChanged: Timer fired but no pending destination!")
                end
            end
        end)
    elseif currentExpansion == "Classic" and (currentMapID == 84 or currentMapID == 85) then
        -- Arrived in Stormwind/Orgrimmar portal room - set waypoint to expansion portal
        if _G.HousingVendorLog and _G.HousingVendorLog.Info then
            _G.HousingVendorLog:Info("OnZoneChanged: Arrived in portal room! Setting portal waypoint in 1.5s")
        end

        C_Timer.After(1.5, function()
            if pendingDestination and pendingDestination.item then
                if _G.HousingVendorLog and _G.HousingVendorLog.Info then
                    _G.HousingVendorLog:Info("OnZoneChanged: Timer fired, setting portal waypoint now")
                end

                local item = pendingDestination.item
                pendingDestination = nil
                UnregisterZoneEvents()
                WaypointManager:SetWaypoint(item)
            else
                if _G.HousingVendorLog and _G.HousingVendorLog.Warn then
                    _G.HousingVendorLog:Warn("OnZoneChanged: Timer fired but no pending destination!")
                end
            end
        end)
    else
        if _G.HousingVendorLog and _G.HousingVendorLog.Info then
            _G.HousingVendorLog:Info("OnZoneChanged: Not in destination yet, waiting for more zone changes")
        end
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
