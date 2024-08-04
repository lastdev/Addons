local _, IE = ...;
local currentLocale = GetLocale();

local L = {};

L["ruRU"] = {
    EXPANSION = "Дополнение";
    EXP_LIST = {
        "Классика",
        "Burning Crusade",
        "Король Лич",
        "Катаклизм",
        "Пандария",
        "Дренор",
        "Легион",
        "Битва за Азерот",
        "Темные Земли",
        "Dragonflight",
        "The War Within"
    };
};

L["enUS"] = {
    EXPANSION = "Expansion";
    EXP_LIST = {
        "Classic",
        "Burning Crusade",
        "Wrath of the Lich King",
        "Cataclysm",
        "Mists of Pandaria",
        "Warlords of Draenor",
        "Legion",
        "Battle for Azeroth",
        "Shadowlands",
        "Dragonflight",
        "The War Within"
    };
};

IE.loc = L[currentLocale] or L["enUS"];