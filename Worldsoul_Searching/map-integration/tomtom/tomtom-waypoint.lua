TomTomWaypoint = setmetatable({}, { __index = TomTomWaypoint})
TomTomWaypoint.__index = TomTomWaypoint

function TomTomWaypoint:new(mapId, x, y, title)
    local obj = setmetatable({}, TomTomWaypoint)

    obj.mapId = mapId
    obj.x = x
    obj.y = y
    obj.options = {
        title = title,
        persistent = false,
        from = MetaAchievementTitle
    }

    return obj
end

function TomTomWaypoint:createFromWaypoint(waypoint)
    return TomTomWaypoint:new(
        waypoint.mapId,
        waypoint.x / 100,
        waypoint.y /100,
        waypoint.title .. " - " .. waypoint.note or waypoint.title
    )
end

function TomTomWaypoint:createFromTomTomWaypoint(tomtomWaypoint)
    return TomTomWaypoint:new(
        tomtomWaypoint[1],
        tomtomWaypoint[2],
        tomtomWaypoint[3],
        tomtomWaypoint.title
    )
end

function TomTomWaypoint:toArgs()
    return self.mapId, self.x, self.y, self.options
end
