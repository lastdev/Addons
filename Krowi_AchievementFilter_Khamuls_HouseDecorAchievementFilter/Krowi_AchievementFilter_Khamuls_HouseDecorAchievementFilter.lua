local addonName, addon = ...;

addon.Achievements = addon.Achievements or {}

if not KrowiAF then 
    print("Krowi's Achievement Filter Addon not loaded!")
    return -- Exit the script
end

local KhamulsHousingDecorEventListenerFrame = CreateFrame("Frame")
function KhamulsHousingDecorEventListenerFrame:Disable() 
    self:UnregisterAllEvents()
    self:SetScript("OnEvent", nil)
    self:SetScript("OnUpdate", nil)
    self:Hide()
end

KhamulsHousingDecorEventListenerFrame:RegisterEvent("PLAYER_LOGIN")
KhamulsHousingDecorEventListenerFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
        InitializeAllAchievementsForKhamulsHouseDecorList()
        KhamulsHousingDecorEventListenerFrame:Disable()
    end
end)

function InitializeAllAchievementsForKhamulsHouseDecorList() 
    -- add all housing achievements to 
    InitializeHousingTWW()
    InitializeHousingDF()
    InitializeHousingSL()
    InitializeHousingBfA()
    InitializeHousingLegacy()
    InitializeHousingPvP()

    local aggregatedAchievementsList = {
        971,
        {
            addon.L["Khamul's House Decor Achievement List"],
            addon.Achievements.HousingLegacy,
            addon.Achievements.HousingBfA,
            addon.Achievements.HousingSL,
            addon.Achievements.HousingDF,
            addon.Achievements.HousingTWW,
            addon.Achievements.HousingPvP
        }
    }

    KrowiAF.CategoryData.KhamulsHousingDecorAchievementLists = aggregatedAchievementsList
end