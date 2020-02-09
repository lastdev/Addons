local addon = select(2, ...)
local D, _, P = addon.getLocalVars()
local dataMineTooltipName = ("%sDatamineTooltip"):format(addon.name)
local dataMineTooltip = _G.CreateFrame("GameTooltip", dataMineTooltipName, UIParent, "GameTooltipTemplate")
local dataMineTitleText = _G[("%sDatamineTooltipTextLeft1"):format(addon.name)]
local isCreatureNamesLoaded, getRareNameByCreatureID
function addon.getRareNameByCreatureID(creatureID)
    local creature = D["Creatures_1"][creatureID] or D["Creatures_2"][creatureID]
    if (not creature) then return end
    if (not creature["Name"]) then
        dataMineTooltip:SetOwner(UIParent, "ANCHOR_NONE")
        dataMineTooltip:SetHyperlink(("unit:Creature-0-0-0-0-%d"):format(creatureID))
        local name = dataMineTitleText:GetText()
        if (name) then
            creature["Name"] = name
            return name
        end
        return
    end
    return creature["Name"]
end
function isCreatureNamesLoaded()
    if(addon.creatureNamesLoaded) then return true end
    for _, creature in pairs(D["Creatures_1"].records) do
        if (not creature["Name"]) then
            return false
        end
    end
    for _, creature in pairs(D["Creatures_2"].records) do
        if (not creature["Name"]) then
            return false
        end
    end
    addon.creatureNamesLoaded = true
    return true
end
function addon.loadCreatureNames()
    for k in pairs(D["Creatures_1"].records) do
        addon.getRareNameByCreatureID(k)
    end
    for k in pairs(D["Creatures_2"].records) do
        addon.getRareNameByCreatureID(k)
    end
    return isCreatureNamesLoaded()
end
local ticker
ticker = C_Timer.NewTicker(0.2,
        function()
            local success = addon.loadCreatureNames()
            if success then
                addon.raresLog1.updated = true
                addon.raresLog1.isSorted = nil
                addon.raresLog2.updated = true
                addon.raresLog2.isSorted = nil
                ticker:Cancel()
            end
        end
)
local function CreaturesName_AfterUpdate(record)
    if (record["Vignette Info"]) then
        record["Vignette Info"].name = record["Name"]
        for _, mapcanvasName in pairs(D["Map Canvases"]) do
            local mapcanvas = _G[mapcanvasName]
            if (mapcanvas and (mapcanvas:GetMapID() == P["Vignette MapID 1"] or mapcanvas:GetMapID() == P["Vignette MapID 2"]) ) then
                mapcanvas:OnEvent("VIGNETTES_UPDATED")
            end
        end
    end
end
D["Creatures_1"]:SetAfterUpdate("Name", CreaturesName_AfterUpdate)
D["Creatures_2"]:SetAfterUpdate("Name", CreaturesName_AfterUpdate)
