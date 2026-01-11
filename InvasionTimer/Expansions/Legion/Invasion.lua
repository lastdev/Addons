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
    630, -- Azsuna
    641, -- Val'sharah
    650, -- Highmountain
    634, -- Stormheim
}
local mapAreaPoiIDs = {
    [630] = 5175, -- Azsuna
    [641] = 5210, -- Val'sharah
    [650] = 5177, -- Highmountain
    [634] = 5178, -- Stormheim
}

Core:RegisterEntry({
    type = 'timeEvent',
    expansion = 6,
    key = 'Invasion',
    title = L["Legion Invasion"],
    -- interval = 66600,
    interval = 52200, -- Remix
    duration = 21600,
    baseTime = {
        -- US = 1547614800, -- 2019-01-15 21:00 UTC-8
        -- EU = 1547586000, -- 2019-01-15 21:00 UTC+0
        -- CN = 1546844400, -- 2019-01-07 15:00 UTC+8
        -- Remix
        US = 1762421400, -- 2025-11-06 01:30 UTC-8
        EU = 1762434000, -- 2025-11-06 13:00 UTC+0
        CN = 1762450200, -- 2025-11-07 01:30 UTC+8
    },
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
})
