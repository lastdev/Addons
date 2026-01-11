---@type InvasionTimer, table<string, string>
local IT, L = unpack((select(2, ...)))
local Core = IT.Core

-- Lua functions
local ipairs = ipairs

-- WoW API / Variables
local C_AreaPoiInfo_GetAreaPOISecondsLeft = C_AreaPoiInfo.GetAreaPOISecondsLeft
local C_Map_GetMapInfo = C_Map.GetMapInfo

local UNKNOWN = UNKNOWN

local maps = {
    862, -- Zuldazar
    863, -- Nazmir
    864, -- Vol'dun
    896, -- Drustvar
    942, -- Stormsong Valley
    895, -- Tiragarde Sound
}
local mapAreaPoiIDs = {
    [862] = 5973, -- Zuldazar
    [863] = 5969, -- Nazmir
    [864] = 5970, -- Vol'dun
    [896] = 5964, -- Drustvar
    [942] = 5966, -- Stormsong Valley
    [895] = 5896, -- Tiragarde Sound
}

Core:RegisterEntry({
    type = 'timeEvent',
    expansion = 7,
    key = 'Assault',
    title = L["Faction Assault"],
    interval = 68400,
    duration = 25200,
    baseTime = {
        US = 1548032400, -- 2019-01-20 17:00 UTC-8
        EU = 1548000000, -- 2019-01-20 16:00 UTC+0
        CN = 1546743600, -- 2019-01-06 11:00 UTC+8
    },
    rotation = {896, 862, 895, 863, 942, 864},
    getCurrentNames = function()
        ---@type string
        local uiMapName = UNKNOWN

        for _, uiMapID in ipairs(maps) do
            local areaPoiID = mapAreaPoiIDs[uiMapID]
            local seconds = C_AreaPoiInfo_GetAreaPOISecondsLeft(areaPoiID)
            if seconds and seconds > 0 then
                uiMapName = C_Map_GetMapInfo(uiMapID).name
                break
            end
        end

        return { uiMapName }
    end,
    getRotationName = function(rotationID)
        return C_Map_GetMapInfo(rotationID).name
    end,
})
