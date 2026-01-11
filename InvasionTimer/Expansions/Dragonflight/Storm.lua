---@type InvasionTimer, table<string, string>
local IT, L = unpack((select(2, ...)))
local Core = IT.Core

-- Lua functions
local ipairs, pairs, tinsert = ipairs, pairs, tinsert

-- WoW API / Variables
local C_AreaPoiInfo_GetAreaPOIInfo = C_AreaPoiInfo.GetAreaPOIInfo
local C_Map_GetMapInfo = C_Map.GetMapInfo
local GetAchievementInfo = GetAchievementInfo

local WrapTextInColorCode = WrapTextInColorCode

local atlas = {
    '|A:elementalstorm-lesser-air:0:0|a',
    '|A:elementalstorm-lesser-earth:0:0|a',
    '|A:elementalstorm-lesser-fire:0:0|a',
    '|A:elementalstorm-lesser-water:0:0|a',
}

-- { air, earth, fire, water }
local stormPoiIDs = {
    -- The Waking Shores
    [2022] = {
        -- Dragonbane Keep
        {7249, 7250, 7251, 7252},
        -- Slagmire
        {7253, 7254, 7255, 7256},
        -- Scalecracker Keep
        {7257, 7258, 7259, 7260},
    },
    -- Ohn'ahran Plains
    [2023] = {
        -- Nokhudon Hold
        {7221, 7222, 7223, 7224},
        -- Ohn'iri Springs
        {7225, 7226, 7227, 7228},
    },
    -- The Azure Span
    [2024] = {
        -- Brackenhide Hollow
        {7229, 7230, 7231, 7232},
        -- Cobalt Assembly
        {7233, 7234, 7235, 7236},
        -- Imbu
        {7237, 7238, 7239, 7240},
    },
    -- Thaldraszus
    [2025] = {
        -- Tyrhold
        {7245, 7246, 7247, 7248},
        -- Primalist Future
        {7298, 7299, 7300, 7301},
    },
}

-- { air, earth, fire, water }
local achievementIDs = {
    -- The Waking Shores
    [2022] = {16463, 16465, 16466, 16467},
    -- Ohn'ahran Plains
    [2023] = {16475, 16477, 16478, 16479},
    -- The Azure Span
    [2024] = {16480, 16481, 16482, 16483},
    -- Thaldraszus
    [2025] = {16485, 16486, 16487, 16488},
}

Core:RegisterEntry({
    type = 'timeEvent',
    expansion = 9,
    key = 'Storm',
    title = L["Elemental Storm"],
    interval = 10800,
    duration = 7200,
    baseTime = {
        US = 1736154000, -- 2025-01-06 01:00 UTC-8
        EU = 1736157600, -- 2025-01-06 10:00 UTC+0
        CN = 1736150400, -- 2025-01-06 16:00 UTC+8
    },
    getCurrentNames = function()
        ---@type string[]
        local currentNames = {}

        for uiMapID, mapStormGroups in pairs(stormPoiIDs) do
            for _, stormGroup in ipairs(mapStormGroups) do
                for index, areaPoiID in ipairs(stormGroup) do
                    local data = C_AreaPoiInfo_GetAreaPOIInfo(uiMapID, areaPoiID)
                    if data then
                        local mapInfo = C_Map_GetMapInfo(uiMapID)
                        local _, _, _, completed = GetAchievementInfo(achievementIDs[uiMapID][index])
                        tinsert(currentNames, atlas[index] .. WrapTextInColorCode(mapInfo.name, completed and 'ffffffff' or 'ffff2020'))
                    end
                end
            end
        end

        return currentNames
    end,
})
