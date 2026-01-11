---@type InvasionTimer, table<string, string>
local IT, L = unpack((select(2, ...)))
local Core = IT.Core

-- Lua functions
local floor = floor

-- WoW API / Variables
local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo

local WrapTextInColorCode = WrapTextInColorCode

Core:RegisterEntry({
    type = 'timeEvent',
    expansion = 9,
    key = 'Daycare',
    title = L["Little Scales Daycare"],
    interval = 86400,
    duration = 86400,
    baseTime = {
        US = 1690038000, -- 2023-07-22 07:00 UTC-8
        EU = 1689998400, -- 2023-07-22 04:00 UTC+0
        CN = 1736722800, -- 2025-01-13 07:00 UTC+8
    },
    rotation = {
        11, -- A Wealth of Whelp Snacks / Dignified Disguises / Runaway Rusziona
        22, -- Appetizing Aftermath / Scanning the Stacks / Zhoomsa
        33, -- Hoard Behavior / Cozy Camouflage / Zaleth on the Go
        44, -- Arts and Crafts and Baths / Eternal Escapades / Pole Position Posidriss
        55, -- Off the Page / Obsidian Obfuscation / Blistering Belastrasza
        61, -- Fowl Runic Scribblings / Dignified Disguises / Runaway Rusziona
        12, -- A Wealth of Whelp Snacks / Scanning the Stacks / Zhoomsa
        23, -- Appetizing Aftermath / Cozy Camouflage / Zaleth on the Go
        34, -- Hoard Behavior / Eternal Escapades / Pole Position Posidriss
        45, -- Arts and Crafts and Baths / Obsidian Obfuscation / Blistering Belastrasza
        51, -- Off the Page / Dignified Disguises / Runaway Rusziona
        62, -- Fowl Runic Scribblings / Scanning the Stacks / Zhoomsa
        13, -- A Wealth of Whelp Snacks / Cozy Camouflage / Zaleth on the Go
        24, -- Appetizing Aftermath / Eternal Escapades / Pole Position Posidriss
        35, -- Hoard Behavior / Obsidian Obfuscation / Blistering Belastrasza
        41, -- Arts and Crafts and Baths / Dignified Disguises / Runaway Rusziona
        52, -- Off the Page / Scanning the Stacks / Zhoomsa
        63, -- Fowl Runic Scribblings / Cozy Camouflage / Zaleth on the Go
        14, -- A Wealth of Whelp Snacks / Eternal Escapades / Pole Position Posidriss
        25, -- Appetizing Aftermath / Obsidian Obfuscation / Blistering Belastrasza
        31, -- Hoard Behavior / Dignified Disguises / Runaway Rusziona
        42, -- Arts and Crafts and Baths / Scanning the Stacks / Zhoomsa
        53, -- Off the Page / Cozy Camouflage / Zaleth on the Go
        64, -- Fowl Runic Scribblings / Eternal Escapades / Pole Position Posidriss
        15, -- A Wealth of Whelp Snacks / Obsidian Obfuscation / Blistering Belastrasza
        21, -- Appetizing Aftermath / Dignified Disguises / Runaway Rusziona
        32, -- Hoard Behavior / Scanning the Stacks / Zhoomsa
        43, -- Arts and Crafts and Baths / Cozy Camouflage / Zaleth on the Go
        54, -- Off the Page / Eternal Escapades / Pole Position Posidriss
        65, -- Fowl Runic Scribblings / Obsidian Obfuscation / Blistering Belastrasza
    },
    getRotationName = function(rotationID)
        local rotation1Index = floor(rotationID / 10)
        local rotation2Index = rotationID % 10

        local rotation1String, _, rotation1Completed = GetAchievementCriteriaInfo(18384, rotation1Index)
        local rotation1Text = WrapTextInColorCode(rotation1String, rotation1Completed and 'ffffffff' or 'ffff2020')

        local rotation2DailyString, _, rotation2DailyCompleted = GetAchievementCriteriaInfo(18384, rotation2Index + 6)
        local rotation2DailyText = WrapTextInColorCode(rotation2DailyString, rotation2DailyCompleted and 'ffffffff' or 'ffff2020')

        local rotation2RaceString, _, rotation2RaceCompleted = GetAchievementCriteriaInfo(18384, rotation2Index + 11)
        local rotation2RaceText = WrapTextInColorCode(rotation2RaceString, rotation2RaceCompleted and 'ffffffff' or 'ffff2020')

        return rotation1Text .. ' / ' .. rotation2DailyText .. ' / ' .. rotation2RaceText
    end,
})
