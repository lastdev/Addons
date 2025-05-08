local addonName, addon = ...;

addon.Achievements = addon.Achievements or {}

if not KrowiAF then 
    print("Krowi's Achievement Filter Addon not loaded!")
    return -- Exit the script
end

local KhamulsEventListenerFrame = CreateFrame("Frame")
function KhamulsEventListenerFrame:Disable() 
    self:UnregisterAllEvents()
    self:SetScript("OnEvent", nil)
    self:SetScript("OnUpdate", nil)
    self:Hide()
end

KhamulsEventListenerFrame:RegisterEvent("PLAYER_LOGIN")
KhamulsEventListenerFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
        InitializeAllAchievementsForKhamulsMetaList()
        KhamulsEventListenerFrame:Disable()
    end
end)

function InitializeAllAchievementsForKhamulsMetaList() 
    -- add all meta achievements to 
    InitializeBfA()
    InitializeSL()
    InitializeDF()
    InitializeTWW()

    local aggregatedAchievementsList = {
        971,
        {
            addon.L["Khamul's Meta-Expansion Achievement List"],
            addon.Achievements.BfA,
            addon.Achievements.SL,
            addon.Achievements.DF,
            addon.Achievements.TWW,
            {
                addon.Achievements.BfAMetaAchievementId,
                addon.Achievements.SLMetaAchievementId,
                addon.Achievements.DFMetaAchievementId,
                addon.Achievements.TWWMetaAchievementId
            }
        }
    }

    KrowiAF.CategoryData.KhamulsExpansionMetaAchievementLists = aggregatedAchievementsList
end