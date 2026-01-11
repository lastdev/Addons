-- DataConstants.lua
-- Numeric codes for repeated string values
-- Reduces file size and memory usage by replacing strings with numbers

_G.HousingDataConstants = {
    -- Item Types
    TYPE = {
        ACHIEVEMENT = 1,
        VENDOR = 2,
        PROFESSION = 3,
        QUEST = 4,
        MISSING = 5,
        REPUTATION = 6,
    },

    -- Expansions
    EXPANSION = {
        CLASSIC = 1,
        BURNING_CRUSADE = 2,
        WRATH_OF_THE_LICH_KING = 3,
        CATACLYSM = 4,
        MISTS_OF_PANDARIA = 5,
        WARLORDS_OF_DRAENOR = 6,
        LEGION = 7,
        BATTLE_FOR_AZEROTH = 8,
        SHADOWLANDS = 9,
        DRAGONFLIGHT = 10,
        THE_WAR_WITHIN = 11,
        MIDNIGHT = 12,
    },

    -- Factions
    FACTION = {
        NEUTRAL = 0,
        ALLIANCE = 1,
        HORDE = 2,
    },
}

-- Reverse lookups (number -> string)
_G.HousingDataConstants.TYPE_NAMES = {}
for name, code in pairs(_G.HousingDataConstants.TYPE) do
    _G.HousingDataConstants.TYPE_NAMES[code] = name:lower():gsub("_", " ")
end

_G.HousingDataConstants.EXPANSION_NAMES = {
    [1] = "Classic",
    [2] = "The Burning Crusade",
    [3] = "Wrath of the Lich King",
    [4] = "Cataclysm",
    [5] = "Mists of Pandaria",
    [6] = "Warlords of Draenor",
    [7] = "Legion",
    [8] = "Battle for Azeroth",
    [9] = "Shadowlands",
    [10] = "Dragonflight",
    [11] = "The War Within",
    [12] = "Midnight",
}

_G.HousingDataConstants.FACTION_NAMES = {
    [0] = "Neutral",
    [1] = "Alliance",
    [2] = "Horde",
}

-- Helper functions to convert between codes and names
function HousingGetTypeName(code)
    return _G.HousingDataConstants.TYPE_NAMES[code]
end

function HousingGetExpansionName(code)
    return _G.HousingDataConstants.EXPANSION_NAMES[code]
end

function HousingGetFactionName(code)
    return _G.HousingDataConstants.FACTION_NAMES[code]
end
