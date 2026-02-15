local addonName, AddonTbl = ...

--- Addon master-table containing references to all components.
---@class DelveCompanion
---@field Logger Logger
---@field Config Config
---@field Lockit Lockit
---@field Definitions Definitions
---@field Variables Variables
---@field AddonSettings AddonSettings
---@field EJExtension EJExtension
---@field DelvesDashboard DelvesDashboard
local DelveCompanion = {}
AddonTbl.DelveCompanion = DelveCompanion

--- Init Delves runtime data.
---@param self DelveCompanion
function DelveCompanion:InitDelvesData()
    -- self.Logger.Log("Initing Delves data...")

    ---@type table<integer, DelveData[]>
    local delvesData = {}

    for expansion, delveConfigs in pairs(self.Config.DELVES_CONFIG) do
        ---@type DelveData[]
        local expansionDelves = {}

        for _, delveConfig in ipairs(delveConfigs) do
            local delveMap = C_Map.GetMapInfo(delveConfig.uiMapID)

            --- Shared table containing runtime Delve data.
            ---@class (exact) DelveData
            ---@field config DelveConfig [DelveConfig](lua://DelveConfig) table associated with the Delve.
            ---@field poiID number? Current [areaPoiID](https://wago.tools/db2/areapoi) of the Delve.
            ---@field tomtom table? Reference to TomTom waypoint set for the Delve. `nil` if not set.
            ---@field parentMapName string Localized name of the map this Delve located in.
            ---@field delveName string Localized name of the Delve.
            ---@field storyVariant string Localized label of the current story of the Delve.
            ---@field isStoryCompleted boolean Whether player has completed the current storyVariant.
            ---@field isBountiful boolean Whether this Delve is bountiful now.
            local data = {
                config = delveConfig,
                poiID = nil,
                tomtom = nil,
                parentMapName = C_Map.GetMapInfo(delveMap.parentMapID).name,
                delveName = delveMap.name,
                storyVariant = nil,
                isStoryCompleted = false,
                isBountiful = false
            }

            table.insert(expansionDelves, data)
        end

        table.insert(delvesData, expansion, expansionDelves)
    end

    self.Variables.delvesData = delvesData
end

--- Iterate through all Delves of the selected expansion and update their runtime data.
---@param self DelveCompanion
---@param expansionLevel number LE_EXPANSION enum number of the expansion
function DelveCompanion:UpdateDelvesData(expansionLevel)
    -- self.Logger.Log("Start updating Delves data for expansion: %d...", expansionLevel)

    for _, delveData in pairs(self.Variables.delvesData[expansionLevel]) do
        local delveConfig = delveData.config
        local parentMapID = C_Map.GetMapInfo(delveConfig.uiMapID).parentMapID

        local poiIDs = delveConfig.poiIDs
        -- Bountiful
        if poiIDs.bountiful and tContains(C_AreaPoiInfo.GetDelvesForMap(parentMapID), poiIDs.bountiful) then
            delveData.poiID = poiIDs.bountiful
            delveData.isBountiful = true
        else
            delveData.poiID = poiIDs.regular
            delveData.isBountiful = false
        end

        local delvePoiInfo = C_AreaPoiInfo.GetAreaPOIInfo(parentMapID, delveData.poiID)
        -- Active story
        if delvePoiInfo and delvePoiInfo.tooltipWidgetSet then
            local tooltipWidgets = C_UIWidgetManager.GetAllWidgetsBySetID(delvePoiInfo.tooltipWidgetSet)

            if tooltipWidgets then
                for _, widgetInfo in ipairs(tooltipWidgets) do
                    if widgetInfo.widgetType == Enum.UIWidgetVisualizationType.TextWithState then
                        local visInfo = C_UIWidgetManager.GetTextWithStateWidgetVisualizationInfo(widgetInfo.widgetID)

                        if visInfo and visInfo.orderIndex == 0 then
                            delveData.storyVariant = visInfo.text

                            -- Some story variants are not included into the achievement (as they were added with content updates during the expansion).
                            -- The primary goal here is to highlight achievement completion, so such variants are marked as "completed". The addon doesn't track whether players have completed them.
                            local isVariantInAchievement = false
                            local achID = delveData.config.achievements.story

                            for index = 1, GetAchievementNumCriteria(achID), 1 do
                                local criteriaString, _, completed = GetAchievementCriteriaInfo(achID, index)

                                if string.find(string.lower(delveData.storyVariant), string.lower(criteriaString)) then
                                    delveData.isStoryCompleted = completed
                                    isVariantInAchievement = true
                                    break
                                end
                            end

                            if not isVariantInAchievement then
                                delveData.isStoryCompleted = true
                            end
                        end
                    end
                end
            end
        end
    end

    -- Logger.Log("Finished updating Delves data")
end

--- Check whether information about `Gilded Stash` can be retrieved.
---@param self DelveCompanion
---@return boolean
function DelveCompanion:CanRetrieveDelveWidgetIDInfo()
    local currentMap = C_Map.GetBestMapForUnit("player")
    if not (currentMap and MapUtil.IsMapTypeZone(currentMap)) then
        return false
    end

    local continent = DelveCompanion:GetContinentMapIDForMap(currentMap)
    return continent ~= nil and continent == self.Config.KHAZ_ALGAR_MAP_ID
end

--- Cache number of consumables (Keys, Shards, etc.) player has collected.
---@param self DelveCompanion
function DelveCompanion:CacheCollectedConsumables()
    -- [Restored Coffer Keys](https://www.wowhead.com/currency=3028/restored-coffer-key) player has got from Caches this week.
    do
        local keysCollected = 0
        for _, questId in ipairs(self.Config.BOUNTIFUL_KEY_QUESTS_DATA) do
            if C_QuestLog.IsQuestFlaggedCompleted(questId) then
                keysCollected = keysCollected + 1
            end
        end

        self.Variables.keysCollected = keysCollected
    end

    -- [Coffer Key Shards](https://www.wowhead.com/item=245653/coffer-key-shard) player has got from Caches this week.
    do
        local shardsCollected = 0
        for _, questId in ipairs(self.Config.KEY_SHARD_QUESTS_DATA) do
            if C_QuestLog.IsQuestFlaggedCompleted(questId) then
                shardsCollected = shardsCollected + 1
            end
        end

        self.Variables.shardsCollected = shardsCollected * DelveCompanion.Config.KEY_SHARDS_PER_CACHE
    end
end

--- Try to retrieve `uiMapID` of the parent map with `Enum.UIMapType.Continent` for the given [uiMapID](https://warcraft.wiki.gg/wiki/UiMapID).
---@param self DelveCompanion
---@param mapID number [uiMapID](https://warcraft.wiki.gg/wiki/UiMapID) for which the Continent is retrieved.
---@return number|nil # Retrieved `uiMapID` of the Continent, or `nil` otherwise.
function DelveCompanion:GetContinentMapIDForMap(mapID)
    if not mapID then
        return nil
    end

    local mapInfo = C_Map.GetMapInfo(mapID)
    while mapInfo and mapInfo.mapType ~= Enum.UIMapType.Continent do
        mapInfo = C_Map.GetMapInfo(mapInfo.parentMapID)
    end

    if mapInfo then
        return mapInfo.mapID
    end

    return nil
end

--- Init [SavedVariables](https://warcraft.wiki.gg/wiki/TOC_format#SavedVariables). The [default config](lua://DelveCompanionAccountData) is used to either init them (e.g. the 1st addon load) or populate with missing fields (e.g. after addon update).
---@param self DelveCompanion
function DelveCompanion:InitAccountSave()
    -- DelveCompanion.Logger.Log("Init AccountSave start...")

    if not DelveCompanionAccountData then
        ---@type DelveCompanionAccountData
        DelveCompanionAccountData = CopyTable(self.Config.DEFAULT_ACCOUNT_DATA)
    else
        for key, value in pairs(self.Config.DEFAULT_ACCOUNT_DATA) do
            if DelveCompanionAccountData[key] == nil then
                DelveCompanionAccountData[key] = value
            end
        end

        if (DelveCompanionAccountData.trackingType == self.Definitions.WaypointTrackingType.tomtom and not self.Variables.tomTomAvailable)
            or (DelveCompanionAccountData.trackingType == self.Definitions.WaypointTrackingType.mpe and not self.Variables.mpeAvailable)
        then
            DelveCompanionAccountData.trackingType = self.Definitions.WaypointTrackingType.superTrack
        end
    end
end

--- Init [SavedVariablesPerCharacter](https://warcraft.wiki.gg/wiki/TOC_format#SavedVariablesPerCharacter). The [default config](lua://DelveCompanionCharacterData) is used to either init them (e.g. the 1st addon load) or populate with missing fields (e.g. after addon update).
---@param self DelveCompanion
function DelveCompanion:InitCharacterSave()
    -- DelveCompanion.Logger.Log("Init CharacterSave start...")

    if not DelveCompanionCharacterData then
        ---@type DelveCompanionCharacterData
        DelveCompanionCharacterData = CopyTable(self.Config.DEFAULT_CHARACTER_DATA)
    else
        for key, value in pairs(self.Config.DEFAULT_CHARACTER_DATA) do
            if DelveCompanionCharacterData[key] == nil then
                DelveCompanionCharacterData[key] = value
            end
        end
    end
end
