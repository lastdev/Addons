local addon = select(2,...)
local D = addon.TomCatsLibs.Data
addon.playerFaction = UnitFactionGroup("player")
-- work-around to allow new neutral Pandaren characters to load the addon without throwing errors
if addon.playerFaction == "Neutral" then addon.playerFaction = "Alliance" end
function addon.split(inputstr, delimiter)
    local t={}
    delimiter = delimiter or "."
    for str in string.gmatch(inputstr, "([^" .. delimiter .. "]+)") do
        table.insert(t, str)
    end
    return t
end
addon.params = {
    ["Vignette MapID"] = tonumber("62"),
    ["Map Name"] = "Darkshore",
    ["Timer Delay"] = 5,
    ["Minimap Icon"] = "Interface\\AddOns\\TomCats\\images\\00006",
    ["Icon BGColor"] = addon.split("0.267,0.133,0.267,0.8",","),
    ["Title Line 1"] = "Rares of Darkshore",
    ["Title Line 2"] = ""
}
function addon.getLocalVars()
    return addon.TomCatsLibs.Data, addon.TomCatsLibs.Locales, addon.params
end
if (addon.playerFaction == "Horde") then
    addon.enemyFaction, addon.embassyContinentMapID = "Alliance", 875
else
    addon.enemyFaction, addon.embassyContinentMapID = "Horde", 876
end
function addon.getWarfrontPhase()
    local contributionCollectorID = D.ContributionCollectorIDs[addon.playerFaction]
    local state = C_ContributionCollector.GetState(contributionCollectorID)
    if (state <= 2) then
        return addon.enemyFaction
    else
        return addon.playerFaction
    end
end
addon.TomCatsLibs.Data["Map Canvases"] = { "WorldMapFrame", "BattlefieldMapFrame" }
