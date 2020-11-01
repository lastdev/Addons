--[[	*** LibCraftCategories ***
Author: Teelo
21 July 2020

This library contains a database of profession categories

Database extracted from: https://wow.tools/dbc/?dbc=tradeskillcategory
Converted to Lua using: https://github.com/teelolws/Altoholic-Retail/blob/master/Utils/MakeWoWLibraries/src/mains/MakeLibCraftCategories.java

--]]

local LIB_VERSION_MAJOR, LIB_VERSION_MINOR = "LibCraftCategories-1.0", 1
local lib = LibStub:NewLibrary(LIB_VERSION_MAJOR, LIB_VERSION_MINOR)

if not lib then return end -- No upgrade needed

local GAME_LOCALE = GetLocale()

local function initialize()
    table.sort(lib.enUS, function(k1, k2)
            return tonumber(k1.OrderIndex) < tonumber(k2.OrderIndex)
        end)
    if GAME_LOCALE ~= "enUS" then
        table.sort(lib[GAME_LOCALE], function(k1, k2)
                return tonumber(k1.OrderIndex) < tonumber(k2.OrderIndex)
            end)
    end
end
C_Timer.After(1, initialize)

--	*** API ***
local outputErrorOnce = false
-- pass in localized category name, get the expansionID
function lib.categoryNameToExpansionID(categoryName)
    if not categoryName then return end
    
    local expansionID = GetClientDisplayExpansionLevel() + 1
    local professionCategoryTable = lib[GAME_LOCALE]

    for k, v in pairs(professionCategoryTable) do
        if (((type(categoryName) == "string") and ((v.Name_lang == categoryName) or (v.HordeName_lang == categoryName))) 
                or ((type(categoryName) == "number") and (v.ID == categoryName))) then
            if v.ParentTradeSkillCategoryID ~= 0 then
                return lib.categoryNameToExpansionID(v.ParentTradeSkillCategoryID)
            end
            for k2, v2 in ipairs(lib.enUS) do
                if k == k2 then
                    if not string.match(v2.Name_lang, "- Header") then
                        return 0
                    end
                    return expansionID
                end
                if (v.SkillLineID == v2.SkillLineID) and (v2.ParentTradeSkillCategoryID == 0) and string.match(v2.Name_lang, "- Header") then
                    expansionID = expansionID - 1
                end
            end
        end 
    end

    if outputErrorOnce then return end
    print("Error in LibCraftCategories: failed to find category name:", categoryName)
    outputErrorOnce = true
end