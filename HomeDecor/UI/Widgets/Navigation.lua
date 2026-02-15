local ADDON, NS = ...

local Nav = {}
NS.UI = NS.UI or {}
NS.UI.Navigation = Nav

local function ParseWorldMapLink(str)
    if type(str) ~= "string" then return end
    local mapID, x, y = str:match("^(%d+):(%d+):(%d+)$")
    if not mapID then return end
    return {
        mapID = tonumber(mapID),
        x     = tonumber(x) / 10000,
        y     = tonumber(y) / 10000,
    }
end

local function ResolveCoords(item, context)
    if item and item.mapID and item.x and item.y then
        return { mapID = item.mapID, x = item.x, y = item.y, title = item.title }
    end
    if context and context.mapID and context.x and context.y then
        return { mapID = context.mapID, x = context.x, y = context.y, title = item and item.title }
    end

    local src = (context and context.source) or (item and item.source)
    if src and src.worldmap then
        local parsed = ParseWorldMapLink(src.worldmap)
        if parsed then
            parsed.title = item and item.title
            return parsed
        end
    end

    if src and src.location and src.location.mapID and src.location.x and src.location.y then
        return { mapID = src.location.mapID, x = src.location.x, y = src.location.y, title = item and item.title }
    end
end

local function CanWaypoint(mapID)
    return C_Map and C_Map.CanSetUserWaypointOnMap and C_Map.CanSetUserWaypointOnMap(mapID)
end

local function PromoteMapForWaypoint(mapID)
    if not C_Map or not C_Map.GetMapInfo then return mapID end

    local info = C_Map.GetMapInfo(mapID)
    while info do
        if CanWaypoint(info.mapID) then
            return info.mapID
        end
        if not info.parentMapID then break end
        info = C_Map.GetMapInfo(info.parentMapID)
    end

    return mapID
end

local function TransformCoords(fromMapID, toMapID, x, y)
    if not (
        C_Map
        and C_Map.GetWorldPosFromMapPos
        and C_Map.GetMapPosFromWorldPos
        and C_Map.GetMapInfo
        and CreateVector2D
    ) then
        return
    end

    local worldPos = C_Map.GetWorldPosFromMapPos(fromMapID, CreateVector2D(x, y))
    if not worldPos then return end

    local info = C_Map.GetMapInfo(toMapID)
    local continentID = info and info.continentMapID
    if not continentID then return end

    local mapPos = C_Map.GetMapPosFromWorldPos(continentID, worldPos, toMapID)
    if not mapPos then return end

    local nx, ny = mapPos:GetXY()
    if not nx or not ny then return end

    return nx, ny
end

local function ResolveWaypointTarget(mapID, x, y)
    if CanWaypoint(mapID) then
        return mapID, x, y
    end

    local targetMapID = PromoteMapForWaypoint(mapID)
    if targetMapID == mapID then
        return
    end
    if not CanWaypoint(targetMapID) then
        return
    end

    local tx, ty = TransformCoords(mapID, targetMapID, x, y)
    if not tx or not ty then
        return
    end

    return targetMapID, tx, ty
end

local function AddBlizzardWaypoint(fromMapID, x, y)
    if not (UiMapPoint and C_Map and C_SuperTrack and C_Map.SetUserWaypoint) then return end

    local mapID, nx, ny = ResolveWaypointTarget(fromMapID, x, y)
    if not mapID then return end

    local point = UiMapPoint.CreateFromCoordinates(mapID, nx, ny)
    if not point then return end

    C_Map.SetUserWaypoint(point)
    C_SuperTrack.SetSuperTrackedUserWaypoint(true)
end

local function PrintCoords(src)
    if not src or not src.mapID or not src.x or not src.y then return end

    PrintCoords(src)
    local name = nil
    if C_Map and C_Map.GetMapInfo then
        local info = C_Map.GetMapInfo(src.mapID)
        name = info and info.name
    end
    local x = math.floor((src.x or 0) * 10000 + 0.5) / 100
    local y = math.floor((src.y or 0) * 10000 + 0.5) / 100
    local msg = string.format("HomeDecor: %s (%.2f, %.2f)%s", name or ("MapID "..tostring(src.mapID)), x, y, src.title and (" - "..tostring(src.title)) or "")
    if DEFAULT_CHAT_FRAME and DEFAULT_CHAT_FRAME.AddMessage then
        DEFAULT_CHAT_FRAME:AddMessage(msg)
    else
        print(msg)
    end
end

function Nav:AddWaypoint(item, context)
    local src = ResolveCoords(item, context)
    if not src or not src.mapID or not src.x or not src.y then return end

    if C_Map and C_Map.OpenWorldMap then
        C_Map.OpenWorldMap(src.mapID)
    elseif WorldMapFrame then
        WorldMapFrame:SetShown(true)
        if WorldMapFrame.SetMapID then
            WorldMapFrame:SetMapID(src.mapID)
        end
    end

    if C_Timer and C_Timer.After then
        C_Timer.After(0, function()
            AddBlizzardWaypoint(src.mapID, src.x, src.y)
        end)
    else
        AddBlizzardWaypoint(src.mapID, src.x, src.y)
    end

    if TomTom
        and TomTom.AddWaypoint
        and TomTom.SetCrazyArrow
        and NS.db
        and NS.db.profile
        and NS.db.profile.useTomTom ~= false then

        local uid = TomTom:AddWaypoint(
            src.mapID,
            src.x,
            src.y,
            {
                title      = src.title or (item and item.title) or "Waypoint",
                persistent = false,
                minimap    = true,
                world      = true,
            }
        )

        if uid then
            TomTom:SetCrazyArrow(
                uid,
                TomTom.profile.arrow.arrival,
                src.title or (item and item.title) or "Waypoint"
            )
        end
    end
end

function Nav:HandleClick(item, context)
    if IsControlKeyDown() then
        self:AddWaypoint(item, context)
        return true
    end
end

return Nav