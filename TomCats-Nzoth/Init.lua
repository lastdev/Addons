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
    ["Vignette MapID 1"] = tonumber("1527"),
    ["Vignette MapID 2"] = tonumber("1530"),
    ["Map Name 1"] = "Uldum",
    ["Map Name 2"] = "Vale of Eternal Blossoms",
    ["Timer Delay"] = 5,
    ["Minimap Icon"] = "Interface\\AddOns\\TomCats\\images\\00018",
    ["Icon BGColor"] = addon.split("0,0,0,1.0",","),
    ["Title Line 1"] = "Rares of Visions of N'zoth",
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
local azerothPOIs
local azerothPOIsExpiration = 0
local function refreshAzerothPOIs()
    local currentTime = time()
    if (currentTime > azerothPOIsExpiration) then
        azerothPOIs = C_AreaPoiInfo.GetAreaPOIForMap(947)
        azerothPOIsExpiration = currentTime + 1;
    end
end
local poi1 = { [6486] = 1, [6488] = 2, [6487] = 3 }
local locationIndex1
local locationIndex1Expiration = 0
function addon.getLocationIndex1()
    local currentTime = time()
    if (currentTime > locationIndex1Expiration) then
        refreshAzerothPOIs()
        for k, v in ipairs(azerothPOIs) do
            if (poi1[v]) then
                local timeLeft = C_AreaPoiInfo.GetAreaPOISecondsLeft(poi1[v]) or 30
                locationIndex1 = poi1[v]
                locationIndex1Expiration = currentTime + timeLeft;
                return poi1[v]
            end
        end
        locationIndex1 = 4
        locationIndex1Expiration = currentTime + 1;
        return 4
    else
        return locationIndex1
    end
end
local poi2 = { [6489] = 1, [6491] = 2, [6490] = 3 }
local locationIndex2
local locationIndex2Expiration = 0
function addon.getLocationIndex2()
    local currentTime = time()
    if (currentTime > locationIndex2Expiration) then
        refreshAzerothPOIs()
        for k, v in ipairs(azerothPOIs) do
            if (poi2[v]) then
                local timeLeft = C_AreaPoiInfo.GetAreaPOISecondsLeft(poi2[v]) or 30
                locationIndex2 = poi2[v]
                locationIndex2Expiration = currentTime + timeLeft;
                return poi2[v]
            end
        end
        locationIndex2 = 4
        locationIndex2Expiration = currentTime + 1;
        return 4
    else
        return locationIndex2
    end
end
addon.TomCatsLibs.Data["Map Canvases"] = { "WorldMapFrame", "BattlefieldMapFrame" }
