local addon = select(2, ...)
local D = addon.getLocalVars()
local playerFaction = addon.playerFaction
local STATUS = {
    COMPLETE = 0,
    HIDDEN = 1,
    UNAVAILABLE = 2,
    LOOT_ELIGIBLE = 3,
    BONUS_ROLL_ELIGIBLE = 4,
    WORLD_QUEST_AVAILABLE = 5
}
addon.STATUS = STATUS
local function refreshStatusForCreature(creature, locationIndex)
    -- default to complete status
    local status = STATUS.COMPLETE
    if (creature[playerFaction .. " React"] == 1) then
        -- hide if friendly
        status = STATUS.HIDDEN
    elseif (not creature["Locations"][locationIndex]) then
        -- otherwise if there is no location, it is unavailable
        status = STATUS.UNAVAILABLE
    else
        -- everything else
        if (not IsQuestFlaggedCompleted(creature[playerFaction .. " Tracking ID"])) then
            status = STATUS.LOOT_ELIGIBLE
        end
        if (creature["Type"] == "Boss") then
            -- world boss has extra statuses
            if (not IsQuestFlaggedCompleted(creature["World Quest ID"])) then
                status = STATUS.WORLD_QUEST_AVAILABLE
            elseif (status ~= STATUS.LOOT_ELIGIBLE and (not IsQuestFlaggedCompleted(creature["Bonus Roll Tracking ID"]))) then
                -- status is bonus roll eligible only if already looted
                status = STATUS.BONUS_ROLL_ELIGIBLE
            end
        end
    end
    creature["Status"] = status
end
function addon.refreshStatusForAllCreatures()
    local locationIndex1 = addon.getLocationIndex1();
    for _, creature in pairs(D["Creatures_1"].records) do
        refreshStatusForCreature(creature, locationIndex1)
    end
    local locationIndex2 = addon.getLocationIndex2();
    for _, creature in pairs(D["Creatures_2"].records) do
        refreshStatusForCreature(creature, locationIndex2)
    end
end
addon.refreshStatusForAllCreatures()
function addon.CreaturesStatus_AfterUpdate(record)
    addon.addOrUpdateVignetteInfo(record)
    if addon.raresLog1 then
        addon.raresLog1.updated = true
    end
    if addon.raresLog2 then
        addon.raresLog2.updated = true
    end
end
D["Creatures_1"]:SetAfterUpdate("Status", addon.CreaturesStatus_AfterUpdate)
D["Creatures_2"]:SetAfterUpdate("Status", addon.CreaturesStatus_AfterUpdate)
