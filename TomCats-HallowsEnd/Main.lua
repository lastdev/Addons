local _, addon = ...
local D = addon.TomCatsLibs.Data
local tcl = addon.TomCatsLibs
local tour
local groupID
local side = 1
local currentPosition
local arrow
-- todo: Activate only during hallow's end
tcl.Events.RegisterEvent("PLAYER_LOGIN", addon)
local function announceRoute()
    if (tour and #tour > 0) then
        print("|cffff0000[|cfff48cbaTomCat|cffff0000] yells: Next stop on the tour is |cffffffff" .. C_Map.GetMapInfo(tour[1]["Map ID"]).name .. "|cffff0000. All aboard!")
    end
end
local function findLocationGroupID(mapID)
    if (mapID == 0) then return end
    for _, locationGroup in pairs(D["Location Groups"].records) do
        if (mapID == locationGroup["Group ID"]) then
            return mapID
        end
    end
    local mapInfo = C_Map.GetMapInfo(mapID)
    return findLocationGroupID(mapInfo.parentMapID)
end
local function isLocationActive(location)
    if (IsQuestFlaggedCompleted(location["Quest ID"])) then return false end
    if (location["Faction"]) then
        local _, _, standingID = GetFactionInfoByID(location["Faction"])
        if (not standingID or (standingID < 4)) then return false end
    end
    if (location["Prerequisite"]) then
        if (not IsQuestFlaggedCompleted(location["Prerequisite"])) then return false end
    end
    return true
end
local function calculateDistance(location)
    local distance = CreateVector2D(currentPosition:GetXY())
    distance:Subtract(location["Group Position"])
    return distance:GetLength()
end
local function updateTour()
    currentPosition = C_Map.GetPlayerMapPosition(groupID, "player")
    local updatedTour = {}
    for i = 1, #tour do
        if (isLocationActive(tour[i])) then
            table.insert(updatedTour,tour[i])
        end
    end
    if (#updatedTour == 0) then tour = nil return end
    local nearestLocationDistance
    local nearestLocationIndex
    for i = 1, #updatedTour do
        local distance = calculateDistance(updatedTour[i])
        if (not nearestLocationDistance or (distance < nearestLocationDistance)) then
            nearestLocationDistance = distance
            nearestLocationIndex = i
        end
    end
    for i = 1, nearestLocationIndex - 1 do
        local location = table.remove(updatedTour, 1)
        table.insert(updatedTour,location)
    end
    tour = updatedTour
    announceRoute()
end
local function switchTour(newGroupID)
    if (IsInInstance()) then
        tour = nil
        return
    end
    if (newGroupID == groupID) then return end
    groupID = newGroupID
    if (not groupID) then
        tour = nil
    else
        tour = {}
        for i = 1, #D["Tours"][side][groupID] do
            local location = D["Locations"][D["Tours"][side][groupID][i]]
            table.insert(tour, location)
        end
        updateTour()
    end
end
local function setupArrow(location)
    if (arrow and (not tour)) then
        arrow:ClearTarget()
        return
    end
    if (tour) then
        if (not arrow) then
            arrow = tcl.Arrows:CreateArrow("ORANGERED")
        end
        arrow:SetTarget(tour[1]["Group Position"], groupID)
    end
end
local function zoneChanged()
    local mapID = C_Map.GetBestMapForUnit("player")
    if (mapID) then
        switchTour(findLocationGroupID(C_Map.GetBestMapForUnit("player")))
    else
        tour = nil
    end
    setupArrow()
end
local function checkTreats()
    for bagId = 0, 4 do
        for slot = 1, GetContainerNumSlots(bagId) do
            local itemLink = GetContainerItemLink(bagId, slot)
            if (itemLink) then
                local itemId = GetItemInfoInstant(itemLink)
                if (itemId == 37586) then
                    UseContainerItem(bagId, slot)
                    return true
                end
            end
        end
    end
    return false
end
local function questComplete(event, ...)
    if (QuestInfoRewardsFrameQuestInfoItem1IconTexture and QuestInfoRewardsFrameQuestInfoItem1IconTexture:GetTexture() == 132940) then
        if (not checkTreats()) then
            GetQuestReward(0)
        end
    end
end
local function questLogUpdate(event, ...)
    if (tour) then
        if (IsQuestFlaggedCompleted(tour[1]["Quest ID"])) then
            table.remove(tour,1)
            if (#tour == 0) then
                tour = nil
            else
                announceRoute()
            end
            setupArrow()
        end
    end
end
local function bagUpdate()
    questComplete()
    questLogUpdate()
end
function addon:PLAYER_LOGIN(event, ...)
    tcl.Events.UnregisterEvent("PLAYER_LOGIN", self)
    tcl.Events.RegisterEvent("ZONE_CHANGED", zoneChanged)
    tcl.Events.RegisterEvent("ZONE_CHANGED_INDOORS", zoneChanged)
    tcl.Events.RegisterEvent("ZONE_CHANGED_NEW_AREA", zoneChanged)
    tcl.Events.RegisterEvent("QUEST_COMPLETE", questComplete)
    tcl.Events.RegisterEvent("QUEST_LOG_UPDATE", questLogUpdate)
    tcl.Events.RegisterEvent("BAG_UPDATE", bagUpdate)
    if (UnitFactionGroup("player") == "Horde") then
        side = 2
    end
    for _, location in pairs(D["Locations"].records) do
        location["Group ID"] = findLocationGroupID(location["Map ID"])
        -- todo: handle this in the data lib via type definitions
        location["Map Position"] = CreateVector2D(location["Map Position"][1], location["Map Position"][2])
        local continentID, worldPosition = C_Map.GetWorldPosFromMapPos(location["Map ID"], location["Map Position"])
        local oid, mapPosition = C_Map.GetMapPosFromWorldPos(continentID, worldPosition, location["Group ID"])
        location["Group Position"] = mapPosition
    end
    switchTour(findLocationGroupID(C_Map.GetBestMapForUnit("player")))
    setupArrow()
end
if (TomCats and TomCats.Register) then
    TomCats:Register(
        {
            name = "Hallow's End",
            version = "1.3.3"
        }
    )
end
