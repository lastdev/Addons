local addonName = ...
local addon = _G[addonName]
local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")
local LibStub = addon.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale("TLDRMissions")
local AceEvent = LibStub("AceAddon-3.0"):NewAddon("TLDRMissions-AceEvent", "AceEvent-3.0")

local gui = addon.WODGUI

gui.SkipMissionButton:SetScript("OnClick", function(self, button)
    numSkipped = numSkipped + 1
    self:SetEnabled(false)
    gui.CostLabel:Hide()
    gui.CostResultLabel:SetText("")
    gui.StartMissionButton:SetEnabled(false)
    
    if not missionWaitingUserAcceptance then
        print("Error: mission awaiting user acceptance not found")
        return
    end
    
    missionWaitingUserAcceptance = nil
    
    if table.getn(calculatedMissionBacklog) > 0 then
        processResults(table.remove(calculatedMissionBacklog, 1), true)
    else
        clearReportText()
        gui.EstimateLabel:SetText()
        if addon:isCurrentWorkBatchEmpty() then
            gui.CalculateButton:SetEnabled(true)
            gui.AbortButton:SetEnabled(false)
            gui.SkipCalculationButton:SetEnabled(false)
            
            local numFollowersAvailable = 0
            for _, follower in pairs(C_Garrison.GetFollowers(123)) do
                if (not follower.status) and (follower.isCollected) then
                    numFollowersAvailable = numFollowersAvailable + 1
                end
            end
            gui.FailedCalcLabel:SetText(L["MissionsSentPartial"]:format(numSent, numSkipped, numFailed, numFollowersAvailable))
            AceEvent:SendMessage("TLDRMISSIONS_SENT_PARTIAL", numSent, numSkipped, numFailed, numFollowersAvailable)
            if WeakAuras then
                WeakAuras.ScanEvents("TLDRMISSIONS_SENT_PARTIAL", numSent, numSkipped, numFailed, numFollowersAvailable)
            end
        else
            setNextMissionText()
        end
    end
end)

local oncePerLogin = true
local lastBlockCompletionReason

-- Not going to deal with stackable existing items and such
-- Player shouldn't run with almost-full bags to avoid this error
-- Or just turn this option off
local function areBagsFull()
    local numItemRewards = 0
    for _, mission in pairs(C_Garrison.GetCompleteMissions(123)) do
        for _, reward in pairs(mission.rewards) do
            if reward.itemID then
                numItemRewards = numItemRewards + 1
            end
        end
    end
    
    local freeSlots = 0
    for i = 0, 4 do
        freeSlots = freeSlots + C_Container.GetContainerNumFreeSlots(i)
    end
    return freeSlots < numItemRewards
end

local function isOnQuest()
    return C_QuestLog.IsOnQuest(61981) or C_QuestLog.IsOnQuest(61982) or C_QuestLog.IsOnQuest(61983) or C_QuestLog.IsOnQuest(61984)
end

local function isQuestPreviouslyFinished()
    return C_QuestLog.IsQuestFlaggedCompleted(61981) or C_QuestLog.IsQuestFlaggedCompleted(61982) or C_QuestLog.IsQuestFlaggedCompleted(61983) or C_QuestLog.IsQuestFlaggedCompleted(61984)
end

gui.CompleteMissionsButton:SetScript("OnClick", function(self, button)
    local i = 0
    local missions = C_Garrison.GetCompleteMissions(1)
    
    if table.getn(missions) == 0 then
        self:SetText(L["NotYet"])
        C_Timer.After(5, function()
            self:SetText(L["CompleteMissionsButtonText"])
        end)
        return
    end
    
    local size = table.getn(missions)
    for _, mission in pairs(missions) do
        self:SetText(size)
        C_Timer.After(i, function()
            size = size - 1
            self:SetText(size)
            if size < 1 then
                self:SetText(DONE.."!")
                AceEvent:SendMessage("TLDRMISSIONS_COMPLETE_MISSIONS_FINISHED")
                if WeakAuras then
                    WeakAuras.ScanEvents("TLDRMISSIONS_COMPLETE_MISSIONS_FINISHED")
                end
                C_Timer.After(2, function()
                    if #C_Garrison.GetCompleteMissions(1) == 0 then
                        self:Hide()
                    elseif oncePerLogin then
                        oncePerLogin = false
                        gui.CompleteMissionsButton:Click()
                        return
                    end
                    self:SetText(L["CompleteMissionsButtonText"])
                end)
            end
            
            C_Garrison.MarkMissionComplete(mission.missionID)
            C_Garrison.MissionBonusRoll(mission.missionID)
        end)
        i = i + 0.1
    end
end)

gui.MinimumTroopsSlider:SetScript("OnValueChanged", function(self, value, userInput)
    TLDRMissionsFrameMinimumTroopsSliderText:SetText(value)
    addon.db.profile.minimumTroops = value
end)

gui.LowerBoundLevelRestrictionSlider:SetScript("OnValueChanged", function(self, value, userInput)
    TLDRMissionsFrameSliderText:SetText(value)
    addon.db.profile.LevelRestriction = value
end)

gui.AnimaCostLimitSlider:SetScript("OnValueChanged", function(self, value, userInput)
    TLDRMissionsFrameAnimaCostSliderText:SetText(value)
    addon.db.profile.AnimaCostLimit = value
end)

gui.SimulationsPerFrameSlider:SetScript("OnValueChanged", function(self, value, userInput)
    TLDRMissionsFrameSimulationsSliderText:SetText(value)
    addon.db.profile.workPerFrame = value
end)

-- the reputation submenu dropdown
function gui.ReputationDropDown:OnSelect(factionID, arg2, checked)
    addon.db.profile.reputations[factionID] = checked
end

-- the crafting cache submenu dropdown
function gui.CraftingCacheDropDown:OnSelect(categoryIndex, itemQuality, checked)
    addon.db.profile.craftingCacheTypes[categoryIndex][itemQuality] = checked
end

function gui.RunecarverDropDown:OnSelect(currencyID, arg2, checked)
    addon.db.profile.runecarver[currencyID] = checked
end

function gui.AnimaDropDown:OnSelect(itemQuality, arg2, checked)
    addon.db.profile.animaItemQualities[itemQuality] = checked
end

function gui.FollowerXPItemsDropDown:OnSelect(itemQuality, arg2, checked)
    addon.db.profile.followerXPItemsItemQualities[itemQuality] = checked
end

gui.DurationLowerSlider:SetScript("OnValueChanged", function(self, value, userInput)
    if not userInput then return end
    addon.db.profile.durationLower = value
    if tonumber(addon.db.profile.durationLower) > tonumber(addon.db.profile.durationHigher) then
        local a = addon.db.profile.durationLower
        addon.db.profile.durationLower = addon.db.profile.durationHigher
        addon.db.profile.durationHigher = a
        gui.DurationLowerSlider:SetValue(addon.db.profile.durationLower)
        gui.DurationHigherSlider:SetValue(addon.db.profile.durationHigher)
    end
    TLDRMissionsFrameDurationLowerSliderText:SetText(L["DurationTimeSelectedLabel"]:format(addon.db.profile.durationLower, addon.db.profile.durationHigher))
end)

gui.DurationHigherSlider:SetScript("OnValueChanged", function(self, value, userInput)
    if not userInput then return end
    addon.db.profile.durationHigher = value
    if tonumber(addon.db.profile.durationLower) > tonumber(addon.db.profile.durationHigher) then
        local a = addon.db.profile.durationLower
        addon.db.profile.durationLower = addon.db.profile.durationHigher
        addon.db.profile.durationHigher = a
        gui.DurationLowerSlider:SetValue(addon.db.profile.durationLower)
        gui.DurationHigherSlider:SetValue(addon.db.profile.durationHigher)
    end
    TLDRMissionsFrameDurationLowerSliderText:SetText(L["DurationTimeSelectedLabel"]:format(addon.db.profile.durationLower, addon.db.profile.durationHigher))
end)

function gui.GearDropDown:OnSelect(goldCategory, arg2, checked)
    addon.db.profile.gearGoldCategories[goldCategory] = checked
end

function gui.CampaignDropDown:OnSelect(campaignCategory, arg2, checked)
    addon.db.profile.campaignCategories[campaignCategory] = checked
end

function gui.SanctumFeatureDropDown:OnSelect(category, arg2, checked)
    for categoryName, c in pairs(addon.sanctumFeatureItems) do
        if category == categoryName then
            -- if any of them are checked, deselect them all. if none of them are checked, select them all
            local isAnyChecked = false
            for itemID in pairs(c) do
                if addon.db.profile.sanctumFeatureCategories[itemID] then
                    isAnyChecked = true
                end
            end
            for currencyID in pairs(addon.sanctumFeatureCurrencies[categoryName]) do
                if addon.db.profile.sanctumFeatureCategories[currencyID] then
                    isAnyChecked = true
                end
            end
            isAnyChecked = not isAnyChecked
            for itemID in pairs(c) do
                addon.db.profile.sanctumFeatureCategories[itemID] = isAnyChecked
            end
            for currencyID in pairs(addon.sanctumFeatureCurrencies[categoryName]) do
                addon.db.profile.sanctumFeatureCategories[currencyID] = isAnyChecked
            end
            LibDD:ToggleDropDownMenu(nil, nil, TLDRMissionsSanctumFeatureDropDown)
            LibDD:ToggleDropDownMenu(nil, nil, TLDRMissionsSanctumFeatureDropDown)
            return
        end
    end
    addon.db.profile.sanctumFeatureCategories[category] = checked
end

function gui.AnythingForXPDropDown:OnSelect(category, arg2, checked)
    addon.db.profile.anythingForXPCategories[category] = checked
end
