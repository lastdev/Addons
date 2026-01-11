---@type InvasionTimer, table<string, string>
local IT, L = unpack((select(2, ...)))
local Core = IT.Core

-- Lua functions

-- WoW API / Variables
local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo

local WrapTextInColorCode = WrapTextInColorCode

Core:RegisterEntry({
    type = 'timeEvent',
    expansion = 8,
    key = 'Tormentor',
    title = L["Tormentor of Torghast"],
    interval = 7200,
    duration = 7200,
    baseTime = {
        US = 1670389200, -- 2022-12-06 21:00 UTC-8
        EU = 1670360400, -- 2022-12-06 21:00 UTC+0
        CN = 1626786000, -- 2021-07-20 21:00 UTC+8
    },
    rotation = {
        1,  -- Versya the Damned
        6,  -- Zul'gath the Flayer
        15, -- Golmak The Monstrosity
        4,  -- Sentinel Pyrophus
        7,  -- Mugrem the Soul Devourer
        11, -- Kazj The Sentinel
        3,  -- Promathiz
        10, -- Sentinel Shakorzeth
        12, -- Intercessor Razzra
        5,  -- Gruukuuek the Elder
        9,  -- Algel the Haunter
        13, -- Malleus Grakizz
        2,  -- Gralebboih
        8,  -- The Mass of Souls
        14, -- Manifestation of Pain
    },
    getRotationName = function(rotationID)
        local criteriaString, _, completed = GetAchievementCriteriaInfo(15054, rotationID)
        return WrapTextInColorCode(criteriaString, completed and 'ffffffff' or 'ffff2020')
    end,
})
