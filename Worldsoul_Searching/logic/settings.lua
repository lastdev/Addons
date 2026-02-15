function DefaultSettings()
    return {
        hideCompleted = false,
        colouredHightlight = false,
        removeCompletedWaypoints = false,
        addWpsOnlyForUncompletedAchis = true,
        mapIntegration = {},
        mainFrame = {
            closed = false,
            height = nil,
            width = nil,
            anchor = nil,
            x = nil,
            y = nil
        },
        dataList = {},
        tmp1 = {}
    }
end

function UpdateSettings()
    for key, value in pairs(DefaultSettings()) do
        if MetaAchievementConfigurationDB[key] == nil then
            MetaAchievementConfigurationDB[key] = value
        end
    end
end
