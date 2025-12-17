-- Profession Reagents Data Loader
-- Loads profession reagent data from HousingProfessions

local AddonName, HousingVendor = ...

-- Module initialization
local ProfessionReagents = {}
HousingVendor.ProfessionReagents = ProfessionReagents

-- Cache for loaded professions data
local professionReagents = {}
local isLoaded = false

-- Load professions data from HousingProfessions global
function ProfessionReagents:LoadProfessionsData()
    if isLoaded then
        return professionReagents
    end
    
    -- Check if HousingProfessions data is available
    if not HousingProfessions or type(HousingProfessions) ~= "table" then
        return {}
    end
    
    -- Build reagent lookup by itemID
    local count = 0
    for _, item in ipairs(HousingProfessions) do
        if item.itemID and item.reagents and #item.reagents > 0 then
            professionReagents[item.itemID] = {
                profession = item.profession,
                skill = item.skill,
                skillNeeded = item.skillNeeded,
                spellID = item.spellID,
                recipeID = item.recipeID,
                reagents = item.reagents
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

-- Initialize on addon load
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_LOGIN" then
        C_Timer.After(2, function()
            ProfessionReagents:LoadProfessionsData()
        end)
    end
end)
