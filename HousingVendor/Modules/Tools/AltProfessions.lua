-- AltProfessions.lua
-- Tracks profession skills and known recipes across all characters

local ADDON_NAME, ns = ...

local AltProfessions = {}
AltProfessions.__index = AltProfessions

local function EnsureDB()
    if not _G.HousingDB then
        return nil
    end
    _G.HousingDB.altProfessions = _G.HousingDB.altProfessions or {}
    local db = _G.HousingDB.altProfessions
    db.characters = db.characters or {}
    return db
end

local function GetCurrentCharKey()
    local name, realm = nil, nil
    if _G.UnitFullName then
        name, realm = _G.UnitFullName("player")
    end
    if not realm or realm == "" then
        realm = (_G.GetRealmName and _G.GetRealmName()) or "UnknownRealm"
    end
    name = name or (_G.UnitName and _G.UnitName("player")) or "Unknown"
    return tostring(name) .. "-" .. tostring(realm)
end

local function GetCharacterDisplayName(charKey)
    -- Format: "Name-Realm" -> "Name"
    if type(charKey) ~= "string" then
        return "Unknown"
    end
    local name = charKey:match("^([^%-]+)")
    return name or charKey
end

-- Scan current character's professions and known recipes
function AltProfessions:ScanCurrentCharacter()
    local db = EnsureDB()
    if not db then
        return
    end

    local charKey = GetCurrentCharKey()
    db.characters[charKey] = db.characters[charKey] or {}
    local charData = db.characters[charKey]
    charData.professions = {}
    charData.lastScan = _G.time and _G.time() or 0
    charData.class = (_G.UnitClass and select(2, _G.UnitClass("player"))) or "UNKNOWN"
    charData.level = (_G.UnitLevel and _G.UnitLevel("player")) or 0

    -- Get profession indexes
    local prof1, prof2, archaeology, fishing, cooking = nil, nil, nil, nil, nil
    if _G.GetProfessions then
        prof1, prof2, archaeology, fishing, cooking = _G.GetProfessions()
    end

    local profIndexes = { prof1, prof2, cooking }
    
    for _, profIndex in ipairs(profIndexes) do
        if profIndex and _G.GetProfessionInfo then
            local name, icon, skillLevel, maxSkillLevel, numAbilities, spelloffset, skillLine, skillModifier, specializationIndex, specializationOffset = _G.GetProfessionInfo(profIndex)
            
            if name and skillLine then
                charData.professions[name] = {
                    skillLine = skillLine,
                    skillLevel = skillLevel or 0,
                    maxSkillLevel = maxSkillLevel or 0,
                    knownRecipes = {},
                }

                -- Scan known recipes for this profession using HousingProfessionData
                local profData = charData.professions[name]
                if _G.HousingProfessionData and type(_G.HousingProfessionData) == "table" then
                    for itemID, itemData in pairs(_G.HousingProfessionData) do
                        if itemData.profession == name then
                            local spellID = tonumber(itemData.spellID)
                            local recipeID = tonumber(itemData.recipeID)
                            local isKnown = false

                            -- Check if recipe is known
                            if recipeID and _G.C_TradeSkillUI and _G.C_TradeSkillUI.GetRecipeInfo then
                                local ok, info = pcall(_G.C_TradeSkillUI.GetRecipeInfo, recipeID)
                                if ok and info and info.learned == true then
                                    isKnown = true
                                end
                            end

                            if not isKnown and spellID then
                                if _G.IsPlayerSpell then
                                    local ok, known = pcall(_G.IsPlayerSpell, spellID)
                                    if ok and known == true then
                                        isKnown = true
                                    end
                                end
                                if not isKnown and _G.IsSpellKnown then
                                    local ok, known = pcall(_G.IsSpellKnown, spellID)
                                    if ok and known == true then
                                        isKnown = true
                                    end
                                end
                            end

                            if isKnown then
                                profData.knownRecipes[tonumber(itemID)] = true
                            end
                        end
                    end
                end
            end
        end
    end
end

-- Get list of characters who know a specific recipe (by itemID)
-- Returns: { {name="Name", charKey="Name-Realm", isCurrent=bool, profession="Alchemy"}, ... }
function AltProfessions:GetCharsWithRecipe(itemID)
    local id = tonumber(itemID)
    if not id then
        return {}
    end

    local db = EnsureDB()
    if not db then
        return {}
    end

    local currentCharKey = GetCurrentCharKey()
    local result = {}

    -- Check current character first
    local currentChar = db.characters[currentCharKey]
    if currentChar and currentChar.professions then
        for profName, profData in pairs(currentChar.professions) do
            if profData.knownRecipes and profData.knownRecipes[id] then
                table.insert(result, {
                    name = GetCharacterDisplayName(currentCharKey),
                    charKey = currentCharKey,
                    isCurrent = true,
                    profession = profName,
                    skillLevel = profData.skillLevel or 0,
                    maxSkillLevel = profData.maxSkillLevel or 0,
                })
                break
            end
        end
    end

    -- Check all alts
    for charKey, charData in pairs(db.characters) do
        if charKey ~= currentCharKey and charData.professions then
            for profName, profData in pairs(charData.professions) do
                if profData.knownRecipes and profData.knownRecipes[id] then
                    table.insert(result, {
                        name = GetCharacterDisplayName(charKey),
                        charKey = charKey,
                        isCurrent = false,
                        profession = profName,
                        skillLevel = profData.skillLevel or 0,
                        maxSkillLevel = profData.maxSkillLevel or 0,
                        class = charData.class,
                        level = charData.level,
                    })
                    break
                end
            end
        end
    end

    -- Sort: current character first, then alphabetically
    table.sort(result, function(a, b)
        if a.isCurrent ~= b.isCurrent then
            return a.isCurrent
        end
        return a.name < b.name
    end)

    return result
end

-- Get summary of which profession this item belongs to
function AltProfessions:GetRecipeProfession(itemID)
    local id = tonumber(itemID)
    if not id then
        return nil
    end

    if _G.HousingProfessionData and _G.HousingProfessionData[id] then
        return _G.HousingProfessionData[id].profession
    end

    return nil
end

-- Get all professions for a specific character
function AltProfessions:GetCharacterProfessions(charKey)
    local db = EnsureDB()
    if not db then
        return {}
    end

    local charData = db.characters[charKey]
    if not charData or not charData.professions then
        return {}
    end

    local result = {}
    for profName, profData in pairs(charData.professions) do
        table.insert(result, {
            name = profName,
            skillLevel = profData.skillLevel or 0,
            maxSkillLevel = profData.maxSkillLevel or 0,
            recipeCount = (function()
                local count = 0
                for _ in pairs(profData.knownRecipes or {}) do
                    count = count + 1
                end
                return count
            end)(),
        })
    end

    table.sort(result, function(a, b)
        return a.name < b.name
    end)

    return result
end

-- Get all tracked characters
function AltProfessions:GetAllCharacters()
    local db = EnsureDB()
    if not db then
        return {}
    end

    local result = {}
    for charKey, charData in pairs(db.characters) do
        table.insert(result, {
            charKey = charKey,
            name = GetCharacterDisplayName(charKey),
            lastScan = charData.lastScan or 0,
            class = charData.class,
            level = charData.level,
            professionCount = (function()
                local count = 0
                for _ in pairs(charData.professions or {}) do
                    count = count + 1
                end
                return count
            end)(),
        })
    end

    table.sort(result, function(a, b)
        return a.name < b.name
    end)

    return result
end

ns.AltProfessions = AltProfessions
_G.HousingAltProfessions = AltProfessions

return AltProfessions
