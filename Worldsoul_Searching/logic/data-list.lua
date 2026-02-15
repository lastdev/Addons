DataList = {}
DataList.__index = DataList

NODE_ICON_COMPLETED = "Interface\\Buttons\\UI-CheckBox-Check"
NODE_ICON_NOT_COMPLETED = "Interface\\Buttons\\UI-StopButton"

local function scanData(inputData, depth, colapsedItems)
    local tmpItems = {}
    for _, item in ipairs(inputData or {}) do
        local achiObj = Achievement:new(item)

        local tmpItem = {
            id = item.id,
            data = achiObj,
            completedIcon = achiObj.completed and NODE_ICON_COMPLETED or NODE_ICON_NOT_COMPLETED,
            colapsed = colapsedItems[item.id] or false,
            children = scanData(item.children or {}, depth + 1, colapsedItems),
            allChildrenCompleted = achiObj.chidrenCompleted,
            depth = depth,
            waypoints = item.waypoints
        }

        tmpItems[#tmpItems+1] = tmpItem
    end

    return tmpItems
end

function DataList:new(achievementItems)
    local obj = setmetatable({}, DataList)

    obj.topAchievementId = achievementItems[1].id or nil
    obj.achievements = achievementItems

    obj.colapsedItems = {}
    if MetaAchievementConfigurationDB.mapIntegration
        and MetaAchievementConfigurationDB.mapIntegration[obj.topAchievementId]
        and MetaAchievementConfigurationDB.mapIntegration[obj.topAchievementId].colapsedItems
    then
        obj.colapsedItems = MetaAchievementConfigurationDB.mapIntegration[obj.topAchievementId].colapsedItems
    end

    obj.items = scanData(obj.achievements, 0, obj.colapsedItems)

    return obj
end

function DataList:rescanData()
    self.items = scanData(self.achievements, 0, self.colapsedItems)
end

local function flatData(input)
    local tmpItems = {}

    for _, item in ipairs(input) do
        if not (item.allChildrenCompleted and MetaAchievementConfigurationDB.hideCompleted) then
            tmpItems[#tmpItems+1] = item

            if item.colapsed == false then
                for _, tmpItem in ipairs(flatData(item.children)) do
                    tmpItems[#tmpItems+1] = tmpItem
                end
            end
        end
    end

    return tmpItems
end

function DataList:getFlatData()
    return flatData(self.items)
end

function DataList:toggleColapsed(id)
    if self.colapsedItems[id] then
        local tmpColapsed = {}
        for key, _ in pairs(self.colapsedItems) do
            if key ~= id then
                tmpColapsed[key] = true
            end
        end
        self.colapsedItems = tmpColapsed
    else
        self.colapsedItems[id] = true
    end

    if not MetaAchievementConfigurationDB["mapIntegration"] then
        MetaAchievementConfigurationDB["mapIntegration"] = {}
    end
    if not MetaAchievementConfigurationDB["mapIntegration"][self.topAchievementId] then
        MetaAchievementConfigurationDB["mapIntegration"][self.topAchievementId] = {}
    end
    MetaAchievementConfigurationDB["mapIntegration"][self.topAchievementId].colapsedItems = self.colapsedItems
end
