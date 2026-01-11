-- Portal Pathfinder Module
-- Implements Dijkstra's shortest path algorithm for optimal portal routing
-- Adapted from PortalHelper's pathfinding logic

local ADDON_NAME, ns = ...
local L = ns.L

local PortalPathfinder = {}
PortalPathfinder.__index = PortalPathfinder

-- Calculate shortest portal path using Dijkstra's algorithm
-- @param startMapID: Starting map ID
-- @param startX: Starting X coordinate (world coords)
-- @param startY: Starting Y coordinate (world coords)
-- @param destMapID: Destination map ID  
-- @param destX: Destination X coordinate (world coords)
-- @param destY: Destination Y coordinate (world coords)
-- @return: table with path steps or nil
function PortalPathfinder:FindShortestPortalPath(startMapID, startX, startY, destMapID, destX, destY)
    if not HousingPortalData then
        return nil
    end
    
    -- Create nodes for Dijkstra's algorithm
    local nodes = {}
    local visited = {}
    
    -- Node structure:
    -- {
    --   coord = {mapID, x, y},
    --   dist = distance from start,
    --   prev = previous node index,
    --   portal = portal data,
    --   isPortal = true if this path uses a portal
    -- }
    
    -- Create starting node
    nodes[1] = {
        coord = {startMapID, startX, startY},
        dist = 0,
        prev = nil,
        portal = {name = "Start", from = "Current Location", to = ""},
        isPortal = false,
        nodeNum = 1
    }
    
    -- Create destination node
    nodes[2] = {
        coord = {destMapID, destX, destY},
        dist = math.huge,
        prev = nil,
        portal = {name = "Destination", from = "", to = "Vendor"},
        isPortal = false,
        nodeNum = 2
    }
    
    -- Add portal nodes from HousingPortalData
    local nodeCount = 2
    for zoneName, portals in pairs(HousingPortalData) do
        if portals and type(portals) == "table" then
            for _, portal in ipairs(portals) do
                if portal.mapID and portal.worldX and portal.worldY then
                    nodeCount = nodeCount + 1
                    
                    -- Add portal entrance node
                    nodes[nodeCount] = {
                        coord = {portal.mapID, portal.worldX, portal.worldY},
                        dist = math.huge,
                        prev = nil,
                        portal = portal,
                        isPortal = false,
                        nodeNum = nodeCount
                    }
                    
                    -- If portal has destination, add exit node
                    if portal.destMapID and portal.destWorldX and portal.destWorldY then
                        nodeCount = nodeCount + 1
                        nodes[nodeCount] = {
                            coord = {portal.destMapID, portal.destWorldX, portal.destWorldY},
                            dist = math.huge,
                            prev = nil,
                            portal = portal,
                            isPortal = true,
                            nodeNum = nodeCount
                        }
                    end
                end
            end
        end
    end
    
    -- Dijkstra's algorithm
    while #nodes > 0 do
        -- Add current node to visited
        visited[#visited + 1] = nodes[1]
        local current = table.remove(nodes, 1)
        
        -- Stop if we reached destination
        if current.nodeNum == 2 then
            break
        end
        
        -- Check all neighbors
        for _, neighbor in ipairs(nodes) do
            local alt = math.huge
            
            -- Only calculate distance if on same map
            if current.coord[1] == neighbor.coord[1] then
                local dx = current.coord[2] - neighbor.coord[2]
                local dy = current.coord[3] - neighbor.coord[3]
                local distance = math.sqrt(dx * dx + dy * dy)
                
                -- Add portal travel time if using a portal (approximate)
                if neighbor.isPortal then
                    distance = distance + 100 -- Portal travel time penalty
                end
                
                alt = current.dist + distance
            end
            
            -- Update if this is a shorter path
            if alt < neighbor.dist then
                neighbor.dist = alt
                neighbor.prev = current.nodeNum
            end
        end
        
        -- Sort nodes by distance (priority queue)
        table.sort(nodes, function(a, b) return a.dist < b.dist end)
    end
    
    -- Reconstruct path
    local path = {}
    local pathNode = visited[#visited]
    
    -- Check if we found a path to destination
    if not pathNode or pathNode.nodeNum ~= 2 or pathNode.dist >= math.huge then
        return nil -- No path found
    end
    
    -- Backtrack from destination to start
    while pathNode and pathNode.prev do
        table.insert(path, 1, pathNode)
        
        -- Find previous node
        local foundPrev = false
        for i = 1, #visited do
            if visited[i].nodeNum == pathNode.prev then
                pathNode = visited[i]
                foundPrev = true
                break
            end
        end
        
        if not foundPrev then
            break
        end
    end
    
    return path
end

-- Get the first portal in the optimal path
-- @param startMapID: Starting map ID
-- @param destMapID: Destination map ID
-- @param destX: Destination X coordinate (0-100 scale)
-- @param destY: Destination Y coordinate (0-100 scale)
-- @return: portal data or nil
function PortalPathfinder:GetFirstPortalInPath(startMapID, destMapID, destX, destY)
    -- Get player position
    local playerPosition = C_Map.GetPlayerMapPosition(startMapID, "player")
    if not playerPosition then
        return nil
    end
    
    local playerX, playerY = playerPosition:GetXY()
    
    -- Convert destination coords to world coords (approximate)
    local destWorldX = destX * 100
    local destWorldY = destY * 100
    
    -- Find shortest path
    local path = self:FindShortestPortalPath(
        startMapID, playerX * 10000, playerY * 10000,
        destMapID, destWorldX, destWorldY
    )
    
    if not path or #path == 0 then
        return nil
    end
    
    -- Return first portal in path
    for _, step in ipairs(path) do
        if step.portal and step.portal.name and step.portal.name ~= "Start" then
            return step.portal
        end
    end
    
    return nil
end

-- Get user-friendly directions for portal path
-- @param path: Path table from FindShortestPortalPath
-- @return: string with directions
function PortalPathfinder:GetPathDirections(path)
    if not path or #path == 0 then
        return "No portal path needed - fly directly to destination."
    end
    
    local directions = {}
    
    for i, step in ipairs(path) do
        if step.portal and step.isPortal then
            local direction = string.format("%d. Use %s portal to %s",
                i,
                step.portal.name or "portal",
                step.portal.destinationExpansion or "destination"
            )
            table.insert(directions, direction)
        end
    end
    
    if #directions == 0 then
        return "No portals needed - fly directly to destination."
    end
    
    return table.concat(directions, "\n")
end

-- Check if a portal path exists between two maps
-- @param startMapID: Starting map ID
-- @param destMapID: Destination map ID
-- @return: boolean
function PortalPathfinder:PortalPathExists(startMapID, destMapID)
    if not startMapID or not destMapID then
        return false
    end
    
    -- Same map = no portal needed
    if startMapID == destMapID then
        return true
    end
    
    -- Check if we have portal data
    if not HousingPortalData then
        return false
    end
    
    -- Simple check: do we have any portals that connect these expansions?
    local startExpansion = HousingMapIDToExpansion and HousingMapIDToExpansion[startMapID]
    local destExpansion = HousingMapIDToExpansion and HousingMapIDToExpansion[destMapID]
    
    if not startExpansion or not destExpansion then
        return false
    end
    
    if startExpansion == destExpansion then
        return true -- Same expansion, can fly
    end
    
    -- Different expansions - check if portals exist
    for zoneName, portals in pairs(HousingPortalData) do
        for _, portal in ipairs(portals) do
            if portal.destinationExpansion == destExpansion then
                return true
            end
        end
    end
    
    return false
end

-- Export module
ns.PortalPathfinder = PortalPathfinder

return PortalPathfinder
