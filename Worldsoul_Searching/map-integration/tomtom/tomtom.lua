TomTomMap = setmetatable({}, { __index = MapIntegrationBase})
TomTomMap.__index = TomTomMap


function TomTomMap:new()
    local obj = setmetatable(MapIntegrationBase:new(), self)

    MetaAchievementConfigurationDB.mapIntegration.tomtom = MetaAchievementConfigurationDB.mapIntegration.tomtom or {}

    obj.settings = MetaAchievementConfigurationDB.mapIntegration.tomtom;
    obj.oldWaypointsLoaded = false

    obj.settings.waypoints = obj.settings.waypoints or {}

    return obj
end

function TomTomMap:loadOldWaypoints()
    if not self.oldWaypointsLoaded then
        C_Timer.After(1, function()
            for achiId, wps in pairs(MetaAchievementConfigurationDB.mapIntegration.tomtom.waypoints or {}) do
                local tmpWaypoints = {}
                for i, wp in pairs(wps) do
                    tmpWaypoints[#tmpWaypoints+1] = TomTom:AddWaypoint(
                        TomTomWaypoint:createFromTomTomWaypoint(wp):toArgs()
                    )
                end
                MetaAchievementConfigurationDB.mapIntegration.tomtom.waypoints[achiId] = tmpWaypoints
            end
        end)
        self.oldWaypointsLoaded = true
    end
end

function TomTomMap:OnLoaded()
    self:loadOldWaypoints()
end

function TomTomMap:OnTomTomLoaded()
    self:loadOldWaypoints()
end

function TomTomMap:ToggleWaypointsForAchievement(id, waypoints)
    if MetaAchievementConfigurationDB.mapIntegration.tomtom.waypoints[id] then
        self:RemoveWaypointsForAchievement(id)
    else
        self:AddWaypointsForAchievement(id, waypoints)
    end
end

function TomTomMap:AddWaypointsForAchievement(id, waypoints)
    local waypointIds = {}

    for _, wp in pairs(waypoints) do
        waypointIds[#waypointIds+1] = TomTom:AddWaypoint(
        TomTomWaypoint:createFromWaypoint(wp):toArgs()
    )
    end

    MetaAchievementConfigurationDB.mapIntegration.tomtom.waypoints[id] = waypointIds
end

function TomTomMap:RemoveWaypointsForAchievement(id)
    if MetaAchievementConfigurationDB.mapIntegration.tomtom.waypoints[id] ~= nil then
        if #MetaAchievementConfigurationDB.mapIntegration.tomtom.waypoints[id] > 0 then
            for _, wp in pairs(MetaAchievementConfigurationDB.mapIntegration.tomtom.waypoints[id]) do
                TomTom:RemoveWaypoint(wp)
            end

            local tmpWaypoints = {}
            for index, item in pairs(MetaAchievementConfigurationDB.mapIntegration.tomtom.waypoints) do
                if index ~= id then
                    tmpWaypoints[index] = item
                end
            end

            MetaAchievementConfigurationDB.mapIntegration.tomtom.waypoints = tmpWaypoints
        end
    end
end

function TomTomMap:RemoveAllWaypoints()
    for index, _ in pairs(MetaAchievementConfigurationDB.mapIntegration.tomtom.waypoints) do
        self:RemoveWaypointsForAchievement(index)
    end
end
