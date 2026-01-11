-- FactionIDs.lua
-- Optional mapping for converting faction names -> factionID (reputation ID).
-- Useful as a fallback when vendor data includes a faction name but not a numeric ID.

local _G = _G

_G.HousingVendorFactionIDs = _G.HousingVendorFactionIDs or {
    -- Classic
    ["Stormwind"] = 72,
    ["Ironforge"] = 47,
    ["Darnassus"] = 69,
    ["Gnomeregan"] = 54,
    ["Exodar"] = 930,
    ["Gilneas"] = 1134,
    ["Tushui Pandaren"] = 1353,
    ["Orgrimmar"] = 76,
    ["Thunder Bluff"] = 81,
    ["Undercity"] = 68,
    ["Darkspear Trolls"] = 530,
    ["Silvermoon City"] = 911,
    ["Bilgewater Cartel"] = 1133,
    ["Huojin Pandaren"] = 1352,
    ["Steamwheedle Cartel"] = 169,

    -- Warlords of Draenor
    ["Frostwolf Clan"] = 729,
    ["Frostwolf Orcs"] = 1445,
    ["Sha'tari Defense"] = 1710,
    ["Sha'tari Skyguard"] = 1031,
    ["Steamwheedle Preservation Society"] = 1711,
    ["Steamwheedle Draenor Expedition"] = 1732,
    ["Laughing Skull Orcs"] = 1708,
    ["Council of Exarchs"] = 1731,
    ["Wrynn's Vanguard"] = 1682,
    ["Vol'jin's Spear"] = 1681,
    ["Vol'jin's Headhunters"] = 1848,
    ["Arakkoa Outcasts"] = 1515,

    -- Legion
    ["Highmountain Tribe"] = 1828,
    ["The Nightfallen"] = 1859,
    ["Dreamweavers"] = 1883,

    -- Battle for Azeroth
    ["Zandalari Empire"] = 2103,
    ["Talanji's Expedition"] = 2156,
    ["The Honorbound"] = 2157,
    ["Proudmoore Admiralty"] = 2160,
    ["Order of Embers"] = 2161,
    ["Storm's Wake"] = 2162,
}

-- Normalized lookup to tolerate minor formatting differences (case/whitespace).
_G.HousingVendorFactionIDsNormalized = _G.HousingVendorFactionIDsNormalized or {}
for name, id in pairs(_G.HousingVendorFactionIDs) do
    local key = tostring(name):lower():gsub("%s+", " "):match("^%s*(.-)%s*$")
    _G.HousingVendorFactionIDsNormalized[key] = id
end

