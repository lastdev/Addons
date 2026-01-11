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
        return value
    end

    if type(value) ~= "string" or value == "" then
        return nil
    end

    -- Generated data sometimes stores reagents as a Python-ish string like:
    -- "[{'id': 251764, 'amount': 25}, {'id': 61981, 'amount': 8}]"
    local parsed = {}
    for chunk in value:gmatch("{[^}]*}") do
        local id = chunk:match("['\"]id['\"]%s*:%s*(%d+)")
        local amount = chunk:match("['\"]amount['\"]%s*:%s*(%d+)")
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
    if isLoaded then
        return professionReagents
    end
    
    if not (_G.HousingProfessionData and type(_G.HousingProfessionData) == "table") then
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

-- Intentionally do not preload at login: reagent parsing can be memory-heavy and isn't needed
-- unless the user opens the Preview Panel (or another UI that queries reagents).
