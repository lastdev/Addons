MapIntegrationBase = {}
MapIntegrationBase.__index = MapIntegrationBase

MapIntegrationOptions = {
    tomtom = "tomtom"
}

function MapIntegrationBase:new()
    local obj = setmetatable({}, self)

    obj.integrations = {}
    obj.activeIntegration = nil

    return obj
end

function MapIntegrationBase:GetIntegrationIfActive(integration)
    if integration == self.activeIntegration then
        return self.integrations[integration]
    end
    return nil
end

function MapIntegrationBase:OnLoaded()
    if self:HasActiveIntegration() then
        self.integrations[self.activeIntegration]:OnLoaded()
    end
end

function MapIntegrationBase:RegisterMapIntegration(name, integration)
    self.integrations[name] = integration
end

function MapIntegrationBase:SetActiveIntegration(name)
    self.activeIntegration = name
end

function MapIntegrationBase:HasActiveIntegration()
    return self.activeIntegration ~= nil
end

function MapIntegrationBase:ToggleWaypointsForAchievement(id, waypoints)
    if self:HasActiveIntegration() then
        self.integrations[self.activeIntegration]:ToggleWaypointsForAchievement(id, waypoints)
    end
end

function MapIntegrationBase:AddWaypointsForAchievement(id, waypoints)
    if self:HasActiveIntegration() then
        self.integrations[self.activeIntegration]:AddWaypointsForAchievement(id, waypoints)
    end
end

function MapIntegrationBase:RemoveWaypointsForAchievement(id)
    if self:HasActiveIntegration() then
        self.integrations[self.activeIntegration]:RemoveWaypointsForAchievement(id)
    end
end

function MapIntegrationBase:RemoveAllWaypoints()
    if self:HasActiveIntegration() then
        self.integrations[self.activeIntegration]:RemoveAllWaypoints()
    end
end
