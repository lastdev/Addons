-- Profession Trainers Lookup
-- Provides a simple API for finding profession trainers by profession/expansion/faction.

local _, HousingVendor = ...

local ProfessionTrainers = {}
HousingVendor.ProfessionTrainers = ProfessionTrainers

local EXPANSION_KEY_BY_NAME = {
    ["Classic"] = "Classic",
    ["The Burning Crusade"] = "TBC",
    ["Burning Crusade"] = "TBC",
    ["TBC"] = "TBC",
    ["Outland"] = "TBC",
    ["Wrath of the Lich King"] = "WotLK",
    ["WotLK"] = "WotLK",
    ["Northrend"] = "WotLK",
    ["Cataclysm"] = "Cataclysm",
    ["Mists of Pandaria"] = "MoP",
    ["MoP"] = "MoP",
    ["Pandaria"] = "MoP",
    ["Warlords of Draenor"] = "WoD",
    ["WoD"] = "WoD",
    ["Draenor"] = "WoD",
    ["Legion"] = "Legion",
    ["Broken Isles"] = "Legion",
    ["Battle for Azeroth"] = "BfA",
    ["BfA"] = "BfA",
    ["Kul Tiran"] = "BfA",
    ["Zandalari"] = "BfA",
    ["Junkyard"] = "BfA",
    ["Mechagon"] = "BfA",
    ["Shadowlands"] = "Shadowlands",
    ["Dragonflight"] = "Dragonflight",
    ["Dragon Isles"] = "Dragonflight",
    ["The War Within"] = "TWW",
    ["TWW"] = "TWW",
    ["Khaz Algar"] = "TWW",
}

local function NormalizeExpansionKey(value)
    if not value or value == "" then
        return nil
    end

    local direct = EXPANSION_KEY_BY_NAME[value]
    if direct then
        return direct
    end

    -- Try simple substring matches from a skill string like "Dragonflight Alchemy".
    local s = tostring(value)
    for needle, key in pairs(EXPANSION_KEY_BY_NAME) do
        if s:find(needle, 1, true) then
            return key
        end
    end

    return nil
end

local function GetFactionKey()
    local f = _G.UnitFactionGroup and _G.UnitFactionGroup("player") or nil
    if f == "Alliance" then return "Alliance" end
    if f == "Horde" then return "Horde" end
    return "Both"
end

local EXPANSION_PREFERENCE = {
    "TWW",
    "Dragonflight",
    "Shadowlands",
    "BfA",
    "Legion",
    "WoD",
    "MoP",
    "Cataclysm",
    "WotLK",
    "TBC",
    "Classic",
}

local function PickBestExpansionKeyForProfession(professionName)
    local all = _G.HousingProfessionTrainers
    local prof = all and all[professionName] or nil
    local expansions = prof and prof.expansions or nil
    if type(expansions) ~= "table" then
        return nil
    end

    for _, key in ipairs(EXPANSION_PREFERENCE) do
        if expansions[key] ~= nil then
            return key
        end
    end

    -- Fallback to any available key (stable order not guaranteed)
    for k in pairs(expansions) do
        if type(k) == "string" and k ~= "" then
            return k
        end
    end
    return nil
end

function ProfessionTrainers:GetAll()
    return _G.HousingProfessionTrainers
end

function ProfessionTrainers:GetTrainer(professionName, expansionKey, factionKey)
    if type(professionName) ~= "string" or professionName == "" then
        return nil
    end

    local all = _G.HousingProfessionTrainers
    local prof = all and all[professionName] or nil
    local expansions = prof and prof.expansions or nil
    if type(expansions) ~= "table" then
        return nil
    end

    local key = NormalizeExpansionKey(expansionKey) or expansionKey
    local exp = key and expansions[key] or nil
    if type(exp) ~= "table" then
        return nil
    end

    local faction = factionKey or GetFactionKey()
    return exp[faction] or exp.Both or exp.Alliance or exp.Horde or nil
end

function ProfessionTrainers:GetTrainerForItem(itemID, itemRecord)
    local id = tonumber(itemID) or tonumber(itemRecord and itemRecord.itemID)
    if not id then
        return nil
    end

    local profData = _G.HousingProfessionData and _G.HousingProfessionData[id] or nil
    local professionName = (profData and profData.profession) or (itemRecord and itemRecord.profession) or nil
    if not professionName or professionName == "" then
        return nil
    end

    local expansionName = nil
    if profData and profData.skill then
        expansionName = profData.skill
    end
    expansionName = expansionName or (itemRecord and (itemRecord._apiExpansion or itemRecord.expansionName)) or nil

    local expansionKey = NormalizeExpansionKey(expansionName)
    expansionKey = expansionKey or PickBestExpansionKeyForProfession(professionName)
    if not expansionKey then
        return nil
    end

    return self:GetTrainer(professionName, expansionKey)
end

return ProfessionTrainers
