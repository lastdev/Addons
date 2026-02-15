-- Profession Reagents Data Loader
-- Loads profession reagent data from HousingProfessionData

local AddonName, HousingVendor = ...

-- Module initialization
local ProfessionReagents = {}
HousingVendor.ProfessionReagents = ProfessionReagents

-- Cache for loaded professions data
local professionReagents = {}
local isLoaded = false

local function ParseReagents(value)
    if type(value) == "table" then
        -- Normalize table format: support both {id, amount} and {itemID, count}
        local normalized = {}
        for _, reagent in ipairs(value) do
            if type(reagent) == "table" then
                local id = reagent.id or reagent.itemID
                local amount = reagent.amount or reagent.count
                if id and amount then
                    table.insert(normalized, {
                        id = tonumber(id),
                        amount = tonumber(amount),
                        itemName = reagent.itemName  -- Preserve name if available
                    })
                end
            end
        end
        return #normalized > 0 and normalized or nil
    end

    if type(value) ~= "string" or value == "" then
        return nil
    end

    -- Generated data sometimes stores reagents as a Python-ish string like:
    -- "[{'id': 251764, 'amount': 25}, {'id': 61981, 'amount': 8}]"
    local parsed = {}
    for chunk in value:gmatch("{[^}]*}") do
        local id = chunk:match("['\"]id['\"]%s*:%s*(%d+)") or chunk:match("['\"]itemID['\"]%s*:%s*(%d+)")
        local amount = chunk:match("['\"]amount['\"]%s*:%s*(%d+)") or chunk:match("['\"]count['\"]%s*:%s*(%d+)")
        id = id and tonumber(id) or nil
        amount = amount and tonumber(amount) or nil
        if id and amount then
            table.insert(parsed, { id = id, amount = amount })
        end
    end

    if #parsed > 0 then
        return parsed
    end

    return nil
end

-- Load professions data from HousingProfessionData global
function ProfessionReagents:LoadProfessionsData()
    -- Ensure DataAggregator has processed pending data (populates HousingProfessionData)
    if _G.HousingDataAggregator and _G.HousingDataAggregator.ProcessPendingData then
        _G.HousingDataAggregator:ProcessPendingData()
    end

    -- If already loaded with data, return cached results
    -- If loaded but empty, check if HousingProfessionData now has data and reload
    if isLoaded and next(professionReagents) ~= nil then
        return professionReagents
    end

    if not (_G.HousingProfessionData and type(_G.HousingProfessionData) == "table") then
        return {}
    end

    -- Check if there's actually data to process
    if next(_G.HousingProfessionData) == nil then
        return {}
    end
    
    -- Build reagent lookup by itemID
    local count = 0
    for itemID, item in pairs(_G.HousingProfessionData) do
        local reagents = item and ParseReagents(item.reagents) or nil
        if itemID and item and reagents and #reagents > 0 then
            professionReagents[itemID] = {
                profession = item.profession,
                skill = item.skill,
                skillNeeded = item.skillNeeded,
                spellID = item.spellID,
                recipeID = item.recipeID,
                reagents = reagents
            }
            count = count + 1
        end
    end
    
    isLoaded = true
    return professionReagents
end

-- Get reagents for a specific item
function ProfessionReagents:GetReagents(itemID)
    if not isLoaded then
        self:LoadProfessionsData()
    end
    
    return professionReagents[itemID]
end

-- Check if item has reagents
function ProfessionReagents:HasReagents(itemID)
    if not isLoaded then
        self:LoadProfessionsData()
    end
    
    return professionReagents[itemID] ~= nil
end

-- Returns true/false if known, or nil if unknown/unavailable.
function ProfessionReagents:IsRecipeKnown(itemID)
    local id = tonumber(itemID)
    if not id then return nil end

    if not isLoaded then
        self:LoadProfessionsData()
    end

    local data = professionReagents[id]
    if not data then
        return nil
    end

    local recipeID = tonumber(data.recipeID)
    if recipeID and _G.C_TradeSkillUI and _G.C_TradeSkillUI.GetRecipeInfo then
        local ok, info = pcall(_G.C_TradeSkillUI.GetRecipeInfo, recipeID)
        if ok and info and info.learned ~= nil then
            return info.learned == true
        end
    end

    local spellID = tonumber(data.spellID)
    if spellID then
        if _G.IsPlayerSpell then
            local ok, known = pcall(_G.IsPlayerSpell, spellID)
            if ok then return known == true end
        end
        if _G.IsSpellKnown then
            local ok, known = pcall(_G.IsSpellKnown, spellID)
            if ok then return known == true end
        end
    end

    return nil
end

-- Intentionally do not preload at login: reagent parsing can be memory-heavy and isn't needed
-- unless the user opens the Preview Panel (or another UI that queries reagents).
