local _, addon = ...
local TCL = addon.TomCatsLibs
local D = TCL.Data
local function QUEST_COMPLETE()
    local itemlink = GetQuestItemLink("reward", 1)
    if (itemlink) then
        local itemid = GetItemInfoFromHyperlink(itemlink)
        if (itemid == 21100) then
            GetQuestReward(0)
        end
    end
end
local function GOSSIP_SHOW()
    local targetGUID = UnitGUID("target")
    if (targetGUID) then
        local guidParts = {}
        for guidPart in string.gmatch(targetGUID, "[^-]+") do
            table.insert(guidParts, guidPart)
        end
        if ("Creature" == guidParts[1] and D["Quest NPC Lookup"][tonumber(guidParts[6])]) then
            if (GetNumGossipAvailableQuests() ~= 0) then
                SelectGossipAvailableQuest(1)
            end
        end
    end
end
local function BAG_UPDATE()
    local origState = GetCVar("autoLootDefault")
    for bagId = 0, 4 do
        for slot = 1, GetContainerNumSlots(bagId) do
            local itemLink = GetContainerItemLink(bagId, slot)
            if (itemLink) then
                local itemId = GetItemInfoInstant(itemLink)
                if (itemId == 21746) then
                    if (origState == "0") then
                        SetCVar("autoLootDefault","1")
                    end
                    UseContainerItem(bagId, slot)
                    if (not (GetCVar("autoLootDefault") == origState)) then
                        SetCVar("autoLootDefault", origState)
                    end
                    return
                end
            end
        end
    end
end
local function ADDON_LOADED(_, event, ...)
    local var1 = select(1, ...)
    if (var1 == addon.name) then
        TCL.Events.UnregisterEvent("ADDON_LOADED", ADDON_LOADED)
        TCL.Events.RegisterEvent("QUEST_COMPLETE", QUEST_COMPLETE)
        --        tcl.Events.RegisterEvent("QUEST_LOG_UPDATE", questLogUpdate)
        TCL.Events.RegisterEvent("BAG_UPDATE", BAG_UPDATE)
        TCL.Events.RegisterEvent("GOSSIP_SHOW", GOSSIP_SHOW)
    end
end
TCL.Events.RegisterEvent("ADDON_LOADED", ADDON_LOADED)
