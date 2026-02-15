Waypoint = {}
Waypoint.__index = Waypoint

function Waypoint:new(waypointData, title)
    if not title then
        title = ""
    end
    local obj = setmetatable({}, Waypoint)

    obj.mapId = waypointData.mapId
    obj.x = waypointData.x
    obj.y = waypointData.y
    obj.title = waypointData.title or title
    obj.note = waypointData.note or ""

    return obj
end
