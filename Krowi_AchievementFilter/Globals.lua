local addonName, addon = ...;

function addon.GetFirstAchievementId(id)
    local firstId;
	while id do
		firstId = id;
		id = GetPreviousAchievement(id);
	end
    return firstId;
end

function addon.InGuildView()
    return AchievementFrame.Header.Title:GetText() == GUILD_ACHIEVEMENTS_TITLE;
end

function addon.GetActiveCovenant()
    return C_Covenants.GetActiveCovenantID() + 1; -- 1 offset since Covenant Enum is 1 based (lua) and Covenant Database Table 0 based
end

function addon.GetAchievementsInZone(mapID, getAll)
    addon.Diagnostics.Trace("addon.GetAchievementsInZone");

    -- Differentiate between 10 and 25 man raids and Normal and Heroic raids
    local player10 = GetDifficultyInfo(3); -- 10 player
    local player10Hc = GetDifficultyInfo(5); -- 10 player
    local player25 = GetDifficultyInfo(4); -- 25 player
    local player25Hc = GetDifficultyInfo(6); -- 25 player
    local _, _, _, difficulty = GetInstanceInfo();

    local achievements = {};
    if addon.Data.Maps[mapID] == nil then
        return achievements;
    else
        addon.Util.ConcatTables(achievements, addon.Data.Maps[mapID].Achievements);
    end

    if difficulty ~= "" then -- Need to add 10 and 25 when doing it from the map
        if difficulty == player10 or difficulty == player10Hc then
            addon.Util.ConcatTables(achievements, addon.Data.Maps[mapID].Achievements10);
        elseif difficulty == player25 or difficulty == player25Hc then
            addon.Util.ConcatTables(achievements, addon.Data.Maps[mapID].Achievements25);
        end
    elseif getAll then
        addon.Util.ConcatTables(achievements, addon.Data.Maps[mapID].Achievements10);
        addon.Util.ConcatTables(achievements, addon.Data.Maps[mapID].Achievements25);
    end

    return achievements;
end

function addon.GetAchievementNumbers(_filters, achievement, numOfAch, numOfCompAch, numOfNotObtAch) -- , numOfIncompAch
    if achievement.AlwaysVisible then
        return numOfAch, numOfCompAch, numOfNotObtAch; -- , numOfIncompAch
    end
    local filters = addon.Filters;
	if filters and filters.Validate(_filters, achievement, true) > 0 then -- If set to false we lag the game
		numOfAch = numOfAch + 1;
		local _, _, _, completed = addon.GetAchievementInfo(achievement.Id);
        local state;
        if achievement.TemporaryObtainable then
            state = achievement.TemporaryObtainable.Obtainable();
        end
		if completed then
			numOfCompAch = numOfCompAch + 1;
		-- else
		-- 	numOfIncompAch = numOfIncompAch + 1;
        elseif state and (state == false or state == "Past" or state == "Future") then
			numOfNotObtAch = numOfNotObtAch + 1;
		end
	end

	return numOfAch, numOfCompAch, numOfNotObtAch; -- , numOfIncompAch
end

local function AddCategoriesTree(category, achievement, extraFunc)
    local categories = achievement.Category:GetTree();
    for _, cat in next, categories do
        local alreadyAdded;
        if category.Children then
            for _, child in next, category.Children do
                if child.Name == cat.Name then
                    alreadyAdded = true;
                    category = child;
                end
            end
        end
        if alreadyAdded == nil then
            local newCategory = addon.Objects.Category:New(cat.Name);
            extraFunc(newCategory);
            category = category:AddCategory(newCategory);
        end
        alreadyAdded = nil;
    end
    return category;
end

local function AddWatchListCategoriesTree(watchListCategory, achievement)
    if not addon.Options.db.Categories.WatchList.ShowSubCategories then
        return watchListCategory;
    end
    return AddCategoriesTree(watchListCategory, achievement, function(newCategory)
        newCategory.IsWatchList = true;
    end);
end

local function AddTrackingAchievementsCategoriesTree(trackingAchievementsCategory, achievement)
    if not addon.Options.db.Categories.TrackingAchievements.ShowSubCategories or achievement.Category == nil then
        return trackingAchievementsCategory;
    end
    return AddCategoriesTree(trackingAchievementsCategory, achievement, function(newCategory)
        newCategory.IsTracking = true;
    end);
end

local function AddExcludedCategoriesTree(excludedCategory, achievement)
    if not addon.Options.db.Categories.Excluded.ShowSubCategories then
        return excludedCategory;
    end
    return AddCategoriesTree(excludedCategory, achievement, function(newCategory)
        newCategory.Excluded = true;
    end);
end

local function ClearTree(categories)
    for i = #categories, 1, -1 do
        if categories[i].Achievements == nil or #categories[i].Achievements == 0 then -- No more achievements
            if categories[i].Children == nil or #categories[i].Children == 0 then -- And no more children
                if categories[i].Parent.TabName == nil then -- Do not remove the special category
                    categories[i].Parent:RemoveCategory(categories[i]);
                end
            end
        end
    end
end

function addon.ClearWatchAchievement(achievement, update)
    achievement:ClearWatch();
    local numWatchListCategories = achievement.WatchListCategories and #achievement.WatchListCategories or 0;
    for i = 1, numWatchListCategories do
        achievement.WatchListCategories[i]:RemoveWatchedAchievement(achievement);
    end
    if addon.Options.db.Categories.WatchList.ShowSubCategories then
        for i = 1, numWatchListCategories do
            ClearTree(achievement.WatchListCategories[i]:GetTree());
        end
    end
    achievement.WatchListCategories = nil;
    if update ~= false then
        addon.GUI.RefreshView();
        -- addon.GUI.SummaryFrame:Achievements_Update("KROWIAF_FORCE_UPDATE");
    end
    for i = 1, #addon.Data.WatchListCategories do
        if (addon.Data.WatchListCategories[i].Achievements and #addon.Data.WatchListCategories[i].Achievements == 0) or (addon.Data.WatchListCategories[i].Children and #addon.Data.WatchListCategories[i].Children == 0) then
            KrowiAF_SavedData.WatchedAchievements = nil;
            addon.Data.WatchListCategories[i].Achievements = nil;
        end
    end
end

function addon.WatchAchievement(achievement, update)
    achievement:Watch();
    for i = 1, #addon.Data.WatchListCategories do
        if addon.Options.db.AdjustableCategories.WatchList[i] then
            local watchListCategory = AddWatchListCategoriesTree(addon.Data.WatchListCategories[i], achievement);
            watchListCategory:AddWatchedAchievement(achievement);
        end
	end
    if update ~= false then
        addon.GUI.RefreshView();
        -- addon.GUI.SummaryFrame:Achievements_Update("KROWIAF_FORCE_UPDATE");
    end
end

function addon.AddToTrackingAchievementsCategories(achievement, update)
    for i = 1, #addon.Data.TrackingAchievementsCategories do
        if addon.Options.db.AdjustableCategories.TrackingAchievements[i] then
            local trackingAchievementsCategory = AddTrackingAchievementsCategoriesTree(addon.Data.TrackingAchievementsCategories[i], achievement);
            trackingAchievementsCategory:AddAchievement(achievement);
        end
    end
    if update ~= false then
        addon.GUI.CategoriesFrame:Update(true);
        addon.GUI.AchievementsFrame:ForceUpdate();
    end
end

function addon.IncludeAchievement(achievement, update)
    achievement:Include();
    local numExcludedCategories = achievement.ExcludedCategories and #achievement.ExcludedCategories or 0;
    for i = 1, numExcludedCategories do
        achievement.ExcludedCategories[i]:RemoveExcludedAchievement(achievement);
    end
    if addon.Options.db.Categories.Excluded.ShowSubCategories then
        for i = 1, numExcludedCategories do
            ClearTree(achievement.ExcludedCategories[i]:GetTree());
        end
    end
    achievement.ExcludedCategories = nil;
    if update ~= false then
        addon.GUI.RefreshView();
    end
    for i = 1, #addon.Data.ExcludedCategories do
        if (addon.Data.ExcludedCategories[i].Achievements and #addon.Data.ExcludedCategories[i].Achievements == 0) or (addon.Data.ExcludedCategories[i].Children and #addon.Data.ExcludedCategories[i].Children == 0) then
            KrowiAF_SavedData.ExcludedAchievements = nil;
            addon.Data.ExcludedCategories[i].Achievements = nil;
        end
    end
end

function addon.ExcludeAchievement(achievement, update)
    achievement:Exclude();
    if addon.Options.db.Categories.Excluded.Show then
        for i = 1, #addon.Data.ExcludedCategories do
            if addon.Options.db.AdjustableCategories.Excluded[i] then
                local excludedCategory = AddExcludedCategoriesTree(addon.Data.ExcludedCategories[i], achievement);
                excludedCategory:AddExcludedAchievement(achievement);
            end
        end
        if update ~= false then
            addon.GUI.RefreshView();
        end
    else
        addon.GUI.RefreshView();
    end
end

local criteriaCache, characterPoints;
local function AddCharToSavedData(playerGUID)
    if not KrowiAF_SavedData.Characters then
        KrowiAF_SavedData.Characters = {};
    end
    local character = KrowiAF_SavedData.Characters[playerGUID];
    local excludeFromHeaderTooltip, excludeFromEarnedByAchievementTooltip, excludeFromMostProgressAchievementTooltip, ignore;
    if character then
        excludeFromHeaderTooltip = character.ExcludeFromHeaderTooltip;
        excludeFromEarnedByAchievementTooltip = character.ExcludeFromEarnedByAchievementTooltip;
        excludeFromMostProgressAchievementTooltip = character.ExcludeFromMostProgressAchievementTooltip;
        ignore = character.Ignore;
    end

    KrowiAF_SavedData.Characters[playerGUID] = {
        Name = (UnitFullName("player")),
        Realm = (select(2, UnitFullName("player"))),
        Class = (select(2, UnitClass("player"))),
        Faction = (UnitFactionGroup("player")),
        CompletedAchievements = {},
        NotCompletedAchievements = {},
        ExcludeFromHeaderTooltip = excludeFromHeaderTooltip,
        ExcludeFromEarnedByAchievementTooltip = excludeFromEarnedByAchievementTooltip,
        ExcludeFromMostProgressAchievementTooltip = excludeFromMostProgressAchievementTooltip,
        Ignore = ignore
    };
end

local function SetCharPoints(playerGUID, points)
    KrowiAF_SavedData.Characters[playerGUID].Points = points;
end

local function AddCharCompletedAchievement(playerGUID, achievementId, year, month, day, hour, min, sec)
    KrowiAF_SavedData.Characters[playerGUID].CompletedAchievements[achievementId] = --[[ cachedCompletedAchievements[achievementId] or ]] time{
        year = 2000 + year,
        month = month,
        day = day,
        -- hour = hour or 0,
        -- min = min or 0,
        -- sec = sec or 0
    };
end

local function CheckDecFlags(flags, flag)
    return (flags / flag) % 2 >= 1;
end

local function IncrementCharacterPoints(playerGUID, id, points, flags, isGuild, wasEarnedByMe, isStatistic, exists, year, month, day, hour, min, sec)
    if KrowiAF_SavedData.Characters[playerGUID].Ignore then
        return;
    end
    if wasEarnedByMe and points >= 0 and not isStatistic and not isGuild and not flags.IsTracking and exists then
        characterPoints = characterPoints + points;
        AddCharCompletedAchievement(playerGUID, id, year, month, day, hour, min, sec);
    end
end

addon.TrackingAchievements = {};
local function AddToCriteriaCache(playerGUID, id, points, flags, isGuild, wasEarnedByMe, isStatistic, exists)
    if isStatistic or isGuild then
        return;
    end
    if flags.IsTracking and not addon.Options.db.Categories.TrackingAchievements.DoLoad then
        return;
    end
    if exists then
        addon.Data.AddAchievementIfNil(id, points);
    elseif addon.Data.Achievements[id] then
        addon.Data.Achievements[id].DoesNotExist = true;
        return;
    else
        return; -- Can this be reached?
    end
    if flags.IsTracking then
        addon.TrackingAchievements[id] = true;
        addon.Data.Achievements[id].IsTracking = true;
        return;
    end
    local numCriteria = GetAchievementNumCriteria(id);
    if numCriteria <= 0 then
        return;
    end
    if not wasEarnedByMe and not flags.IsAccountWide then
        KrowiAF_SavedData.Characters[playerGUID].NotCompletedAchievements[id] = {};
    end
    for j = 1, numCriteria do
        local _, criteriaType, criteriaIsCompleted, quantity, _, _, _, assetID, _, _, _, hasValueProgress = addon.GetAchievementCriteriaInfo(id, j);
        if criteriaType == 8 then -- See https://wowpedia.fandom.com/wiki/API_GetAchievementCriteriaInfo for all criteria types
            tinsert(criteriaCache, {AchievementId = assetID, RequiredForId = id});
        end
        if not wasEarnedByMe and not flags.IsAccountWide then
            KrowiAF_SavedData.Characters[playerGUID].NotCompletedAchievements[id][j] = hasValueProgress and quantity or criteriaIsCompleted;
        end
    end
end

function addon.BuildCache()
    if criteriaCache ~= nil then -- Build cache the first time
        return criteriaCache, characterPoints;
    end

    local playerGUID = UnitGUID("player");
    criteriaCache = {};
    characterPoints = 0;
    local gapSize, i = 0, 1;
    AddCharToSavedData(playerGUID);
    local highestId = addon.Data.AchievementIds[#addon.Data.AchievementIds];
    while gapSize < 500 or i < highestId do -- Biggest gap is 209 in 9.0.5 as of 2021-05-03
        local id, name, points, _, month, day, year, _, flags, _, _, isGuild, wasEarnedByMe, _, isStatistic, exists = addon.GetAchievementInfo(i);
        if id then
            IncrementCharacterPoints(playerGUID, id, points, flags, isGuild, wasEarnedByMe, isStatistic, exists, year, month, day);
            AddToCriteriaCache(playerGUID, id, points, flags, isGuild, wasEarnedByMe, isStatistic, exists);
            -- CacheAchievement(id, name);
        end
        if id and exists then
            gapSize = 0;
        else
            gapSize = gapSize + 1;
        end
        i = i + 1;
    end
    addon.Data.SortAchievementIds(); -- Achievements are added to the back so we need to make sure the list is sorted again
    SetCharPoints(playerGUID, characterPoints);
    return criteriaCache, characterPoints;
end

function addon.ResetCache()
    criteriaCache = nil;
end

local function RemoveFromNotCompletedAchievements(playerGUID, achievementId)
    if not KrowiAF_SavedData.Characters[playerGUID] or KrowiAF_SavedData.Characters[playerGUID].Ignore or not KrowiAF_SavedData.Characters[playerGUID].NotCompletedAchievements then
        return;
    end

    KrowiAF_SavedData.Characters[playerGUID].NotCompletedAchievements[achievementId] = nil;
end

function addon.OnAchievementEarned(achievementId)
    if criteriaCache == nil then
        return; -- Achievement window is not opened yet
    end

    local id, _, points, _, month, day, year, _, flags, _, _, isGuild, wasEarnedByMe, _, isStatistic, exists = addon.GetAchievementInfo(achievementId);
    if not id then
        return;
    end
    local playerGUID = UnitGUID("player");
    local dateTable = date("*t", time());
    IncrementCharacterPoints(playerGUID, id, points, flags, isGuild, wasEarnedByMe, isStatistic, exists, year, month, day, dateTable.hour, dateTable.min, dateTable.sec);
    SetCharPoints(playerGUID, characterPoints);
    RemoveFromNotCompletedAchievements(playerGUID, achievementId);
    addon.AchievementEarnedUpdateCategoriesFrameOnNextShow = true;
    addon.AchievementEarnedUpdateAchievementsFrameOnNextShow = true;
    local achievement = addon.Data.Achievements[achievementId];
    if achievement then
        achievement.IsTracked = nil;
    end
end

function addon.OverwriteFunctions()
    AchievementFrame_ToggleAchievementFrame = function(toggleStatFrame, toggleGuildView)
        -- if addon.IsDragonflightRetail then
        --     ClearSelectedCategories();
        -- end

        AchievementFrameComparison:Hide();
        AchievementFrameTab_OnClick = AchievementFrameBaseTab_OnClick;

        if not toggleStatFrame then
            if AchievementFrame:IsShown() and AchievementFrame.selectedTab == 1 then
                AchievementFrame:Hide();
            else
                AchievementFrame_SetTabs();
                AchievementFrame:Show();
                if toggleGuildView then
                    AchievementFrameTab_OnClick(2);
                else
                    AchievementFrameTab_OnClick(1);
                end
            end
            return;
        end
        if AchievementFrame:IsShown() and AchievementFrame.selectedTab == (addon.IsWrathClassic and 2 or 3) then
            AchievementFrame:Hide();
        else
            AchievementFrame:Show();
            AchievementFrame_SetTabs();
            AchievementFrameTab_OnClick(addon.IsWrathClassic and 2 or 3);
        end
    end

    AchievementFrame_DisplayComparison = function(unit)
        -- if addon.IsDragonflightRetail then
            -- ClearSelectedCategories();
        -- else
        if not addon.IsDragonflightRetail then
            AchievementFrame.wasShown = nil;
        end

        AchievementFrameTab_OnClick = AchievementFrameComparisonTab_OnClick;
        AchievementFrameTab_OnClick(1);
        if addon.IsDragonflightRetail then
            AchievementFrame_SetComparisonTabs();
        end
        AchievementFrame:Show();
        if addon.IsDragonflightRetail then
            AchievementFrame_ShowSubFrame(AchievementFrameComparison, AchievementFrameComparison.AchievementContainer);
        end
        AchievementFrameComparison_SetUnit(unit);
        AchievementFrameComparison_ForceUpdate();
    end

    AchievementFrame_SetTabs = addon.GUI.ShowHideTabs;

    AchievementFrame_SelectAchievement = function(id)
        KrowiAF_SelectAchievementFromID(id);
    end

    if addon.IsWrathClassic then
        hooksecurefunc("PanelTemplates_SetTab", AchievementFrame_SetTabs);
    end
end

-- function addon.HookSelectAchievement()
--     hooksecurefunc("AchievementFrame_SelectAchievement", function(id, forceSelect, isComparison)
--         KrowiAF_SelectAchievementFromID(id);
--     end);
-- end

function addon.HookAchievementFrameOnShow()
    hooksecurefunc(AchievementFrame, "Show", function()
        addon.Data.GetCurrentZoneAchievements();
    end);

    -- local funcName = addon.IsWrathClassic and "PanelTemplates_SetTab" or "AchievementFrame_SetTabs";
    -- if addon.IsWrathClassic then
    --     hooksecurefunc("PanelTemplates_SetTab", AchievementFrame_SetTabs);
    -- end
end

local function MakeStatic(frame, rememberLastPositionOption, target)
    if not frame or not frame.ClearAllPoints or not frame:IsMovable() then
        return;
    end

    if rememberLastPositionOption then
        addon.GUI.SetFrameToLastPosition(target or frame, rememberLastPositionOption);
    end

    frame:SetMovable(false);
    frame:EnableMouse(false);
    frame:SetScript("OnMouseDown", function(frame, button)
    end);
    frame:SetScript("OnMouseUp", function(frame, button)
    end);
end

function addon.MakeWindowStatic()
    if not IsAddOnLoaded("Blizzard_AchievementUI") then
        return;
    end
    MakeStatic(AchievementFrame, "AchievementWindow");
    MakeStatic(AchievementFrame.Header, "AchievementWindow", AchievementFrame);
    MakeStatic(addon.GUI.Calendar.Frame, "Calendar");
    MakeStatic(addon.GUI.DataManagerFrame, "DataManager");
end

local function MakeMovable(frame, rememberLastPositionOption, target)
    if not frame or not frame.ClearAllPoints or frame:IsMovable() then -- Do not make it movable multiple times if another addon already did it
        return;
    end

    if not target then
        addon.GUI.SetFrameToLastPosition(frame, rememberLastPositionOption);
    end

    target = target or frame;

    frame:SetMovable(true);
    frame:EnableMouse(true);
    frame:SetScript("OnMouseDown", function(frame, button)
        if button == "LeftButton" then
            target:StartMoving();
        end
    end);
    frame:SetScript("OnMouseUp", function(frame, button)
        target:StopMovingOrSizing();
        if addon.Options.db.Window.RememberLastPosition[rememberLastPositionOption] then
            KrowiAF_SavedData.RememberLastPosition = KrowiAF_SavedData.RememberLastPosition or {};
            KrowiAF_SavedData.RememberLastPosition[rememberLastPositionOption] = {
                X = target:GetLeft(),
                Y = target:GetTop() - UIParent:GetTop()
            };
        end
    end);
end

function addon.MakeWindowMovable()
    if not IsAddOnLoaded("Blizzard_AchievementUI") then
        return;
    end
    MakeMovable(AchievementFrame, "AchievementWindow");
    MakeMovable(AchievementFrame.Header, "AchievementWindow", AchievementFrame);
    MakeMovable(addon.GUI.Calendar.Frame, "Calendar");
    MakeMovable(addon.GUI.DataManagerFrame, "DataManager");
end

function addon.GetSecondsSince(date)
    date.day = date.monthDay;
    date.monthDay = nil;
    date.wday = date.weekday;
    date.weekday = nil;
    date.min = date.minute;
    date.minute = nil;
    return time(date);
end

function addon.ReplaceVarsWithReloadReq(str, vars)
    if not vars then
        vars = type(str) == "table" and str or {str};
        str = vars[1];
    end
    vars["reloadRequired"] = addon.L["Requires a reload"];
    return addon.Util.ReplaceVars(str, vars);
end

string["InjectAddonName"] = function(str)
    return str:ReplaceVars{addonName = addon.MetaData.Title};
end

function addon.GetAchievementInfo(achievementID) -- Returns an additional bool indicating if the achievement is added to the game yet or not
    local id, name, points, completed, month, day, year, description, flags, icon, rewardText, isGuild, wasEarnedByMe, earnedBy, isStatistic = GetAchievementInfo(achievementID);
    if id then
        flags = addon.Objects.Flags:New(flags);
        return id, name, points, completed, month, day, year, description, flags, icon, rewardText, isGuild, wasEarnedByMe, earnedBy, isStatistic, true;
    else
        flags = addon.Objects.Flags:New(0);
        return achievementID, " * Placeholder for " .. achievementID .. " * ", 0, false, nil, nil, nil,
        " * This is the placeholder for " .. achievementID .. " until it's available next patch.", flags, 134400, "", false, false, "", false, false;
    end
end

function addon.GetNextAchievement(achievement)
    if achievement.NextAchievements then
        for _, nextAchievement in next, achievement.NextAchievements do
            local _, _, _, completed, _, _, _, _, _, _, _, _, _, earnedBy, _ = addon.GetAchievementInfo(nextAchievement.Id);
            if earnedBy ~= nil then -- Will be nil if the achievement is for the other faction
                return nextAchievement, completed;
            end
        end
    end
    return nil, false;
end

function addon.GetAchievementCriteriaInfo(achievementId, criteriaIndex, countHidden)
    local criteriaString, criteriaType, completed, quantity, reqQuantity, charName, flags, assetID, quantityString, criteriaID, eligible;
    if type(addon.Data.CustomCriteria[achievementId]) == "function" then
        criteriaString, criteriaType, completed, quantity, reqQuantity, charName, flags, assetID, quantityString, criteriaID, eligible = addon.Data.CustomCriteria[achievementId](criteriaIndex);
    else
        criteriaString, criteriaType, completed, quantity, reqQuantity, charName, flags, assetID, quantityString, criteriaID, eligible = GetAchievementCriteriaInfo(achievementId, criteriaIndex, countHidden);
    end
    local hasValueProgress = (quantity ~= nil and reqQuantity ~= nil and not (quantity == 0 and (reqQuantity == 0 or reqQuantity == 1))) or achievementId == 17335;
    return criteriaString, criteriaType, completed, quantity, reqQuantity, charName, flags, assetID, quantityString, criteriaID, eligible, hasValueProgress;
end

function addon.GetAchievementNumCriteria(achievementId)
    if type(addon.Data.CustomCriteria[achievementId]) == "function" then
        return addon.Data.CustomCriteria[achievementId]();
    else
        return GetAchievementNumCriteria(achievementId);
    end
end

function addon.GetUsableSets(transmogSets)
    local usableTransmogSets = {};
    local _, _, classId = UnitClass("player");
    for _, transmogSet in next, transmogSets do
        if CheckDecFlags(transmogSet.ClassMask, math.pow(2, classId - 1)) then
            tinsert(usableTransmogSets, transmogSet);
            -- addon.Diagnostics.Debug("Usable set " .. tostring(transmogSet.Id) .. " added");
        end
    end
    return usableTransmogSets;
end

function addon.GetVariantSetIDs(baseSetIds)
    if not IsAddOnLoaded("Blizzard_Collections") then
        LoadAddOn("Blizzard_Collections");
    end
    local setIDs = {};
    for _, baseSetId in next, baseSetIds do
        local variantSets = WardrobeSetsDataProviderMixin:GetVariantSets(baseSetId);
        if #variantSets ~= 0 then
            for _, set in next, variantSets do
                tinsert(setIDs, set.setID);
            end
        else
            tinsert(setIDs, baseSetId);
        end
    end
    return setIDs;
end

function addon.ChangeAchievementMicroButtonOnClick()
    addon.GUI.TabsOrderGetActiveKeys(); -- Cleanup unused tabs
    if addon.Options.db.MicroButtonTab > #KrowiAF_SavedData.Tabs then
        for i, _ in next, KrowiAF_SavedData.Tabs do
            if KrowiAF_SavedData.Tabs[i].AddonName == addonName and KrowiAF_SavedData.Tabs[i].Name == "Achievements" then
                addon.Options.db.MicroButtonTab = i;
            end
        end
    end
    local tab = KrowiAF_SavedData.Tabs[addon.Options.db.MicroButtonTab];
    if tab.AddonName == "Blizzard_AchievementUI" then
        return;
    end
    AchievementMicroButton:SetScript("OnClick", function(self)
        addon.GUI.ToggleAchievementFrame(tab.AddonName, tab.Name);
    end);
end

addon.DelayObjects = {};
function addon.DelayFunction(delayObjectName, delayTime, func, ...)
    if addon.DelayObjects[delayObjectName] ~= nil then
        -- print("skipping")
        return;
    end
    -- print("start timer")
    local args = {...};
    addon.DelayObjects[delayObjectName] = C_Timer.NewTimer(delayTime, function()
        -- print("run func")
        func(unpack(args));
        addon.DelayObjects[delayObjectName] = nil;
    end);
end

addon.Modifiers = {
    addon.L["None"],
    addon.L["Alt"],
    addon.L["Ctrl"],
    addon.L["Shift"],
    addon.L["Right Alt"],
    addon.L["Right Ctrl"],
    addon.L["Right Shift"],
    addon.L["Left Alt"],
    addon.L["Left Ctrl"],
    addon.L["Left Shift"]
};

function addon.IsCustomModifierKeyDown(modifier)
    if modifier == 1 then
        return;
    elseif modifier == 2 then
        return IsAltKeyDown();
    elseif modifier == 3 then
        return IsControlKeyDown();
    elseif modifier == 4 then
        return IsShiftKeyDown();
    elseif modifier == 5 then
        return IsRightAltKeyDown();
    elseif modifier == 6 then
        return IsRightControlKeyDown();
    elseif modifier == 7 then
        return IsRightShiftKeyDown();
    elseif modifier == 8 then
        return IsLeftAltKeyDown();
    elseif modifier == 9 then
        return IsLeftControlKeyDown();
    elseif modifier == 10 then
        return IsLeftShiftKeyDown();
    end
end