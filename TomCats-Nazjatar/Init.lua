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
    ["Vignette MapID"] = tonumber("1355"),
    ["Map Name"] = "Nazjatar",
    ["Timer Delay"] = 5,
    ["Minimap Icon"] = "Interface\\AddOns\\TomCats\\images\\00008",
    ["Icon BGColor"] = addon.split("0,0,0,1.0",","),
    ["Title Line 1"] = "Rares of Nazjatar",
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
    return addon.playerFaction
end
addon.TomCatsLibs.Data["Map Canvases"] = { "WorldMapFrame", "BattlefieldMapFrame" }