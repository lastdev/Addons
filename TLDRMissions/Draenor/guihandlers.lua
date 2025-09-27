-- TODO: finish clearing out guihandlers.lua then move this file back to that

local addonName, addon = ...
local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")
local LibStub = addon.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale("TLDRMissions")
local AceEvent = LibStub("AceAddon-3.0"):NewAddon("TLDRMissions-AceEvent", "AceEvent-3.0")

local gui = addon.WODGUI

local nextMission
local hasNextMission
local missionCounter
local missionCounterUpper
local calculateNextMission
local setNextMissionText

local pauseReports

local missionWaitingUserAcceptance
local calculatedMissionBacklog = {}

local alreadyUsedFollowers

local numSent
local numSkipped
local numFailed

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
                    end
                    self:SetText(L["CompleteMissionsButtonText"])
                    -- without this, the completion dialog stays on screen
                    if GarrisonMissionFrameMissions and GarrisonMissionFrameMissions.CompleteDialog and GarrisonMissionFrameMissions.CompleteDialog.BorderFrame and GarrisonMissionFrameMissions.CompleteDialog.BorderFrame.ViewButton then
                        GarrisonMissionFrameMissions.CompleteDialog.BorderFrame.ViewButton:Click()
                    end
                end)
            end
            
            C_Garrison.MarkMissionComplete(mission.missionID)
            C_Garrison.MissionBonusRoll(mission.missionID)
        end)
        i = i + 0.1
    end
end)

local rewardStrings = {
    "garrison-resources",
    "follower-items",
    --"pet-charms",
    "followerxp",
    "gear",
    "apexis",
    "oil",
    "seal",
    "archaeology",
}

-- Gold reward exists in WOD game versions only
if gui.GoldCheckButton then
    table.insert(rewardStrings, 1, "gold")
end

function addon:updateWODRewards()
    for _, label in pairs(gui.priorityLabels) do
        label:SetText()
    end
    
    for _, button in pairs(gui.checkButtons) do
        button.ExclusionLabel:Hide()
        button:SetChecked(false)
    end
    
    local db = addon.WODdb
        
    local wasSomethingChecked = false
    for i, button in pairs(gui.checkButtons) do
        for k, v in pairs(db.profile.selectedRewards) do
            if v == rewardStrings[i] then
                button:SetChecked(true)
                gui.priorityLabels[i]:SetText(k)
                wasSomethingChecked = true
                break
            end
        end
    end
    
    for k, v in pairs(db.profile.excludedRewards) do
        for i, rewardString in ipairs(rewardStrings) do
            if rewardString == v then
                gui.checkButtons[i].ExclusionLabel:Show()
            end
        end
    end
    
    if db.profile.anythingForXP or db.profile.sacrificeRemaining then
        wasSomethingChecked = true
    end
    
    if wasSomethingChecked then
        gui.CalculateButton:SetEnabled(true)
    else
        gui.CalculateButton:SetEnabled(false)
    end
end

local checkButtonHandler = function(self, name)
    local db = addon.WODdb
    if self:GetChecked() then
        for k, v in pairs(db.profile.excludedRewards) do
            if v == name then
                db.profile.excludedRewards[k] = nil
                self:SetChecked(false)
                addon:updateWODRewards()
                return
            end
        end
        
        for i = 1, 12 do
            if not db.profile.selectedRewards[i] then
                db.profile.selectedRewards[i] = name
                addon:updateWODRewards()
                return
            end
        end
    else
        for i = 1, 12 do
            if db.profile.selectedRewards[i] == name then
                for j = i, 12 do
                    if (j+1) > 12 then
                        db.profile.selectedRewards[j] = nil
                        table.insert(db.profile.excludedRewards, name)
                    else
                        db.profile.selectedRewards[j] = db.profile.selectedRewards[j+1]
                    end
                end
                addon:updateWODRewards()
                return
            end
        end
    end
    addon:updateWODRewards()
end

for i, button in pairs(gui.checkButtons) do
    button:HookScript("OnClick", function(self) checkButtonHandler(self, rewardStrings[i]) end)
end

gui.AnythingForXPCheckButton:HookScript("OnClick", function(self)
    addon.WODdb.profile.anythingForXP = self:GetChecked()
    addon:updateWODRewards()
end)

gui.SacrificeCheckButton:HookScript("OnClick", function(self)
    addon.WODdb.profile.sacrificeRemaining = self:GetChecked()
    addon:updateWODRewards()
end)

local function clearReportText()
    gui.FailedCalcLabel:SetText()
    gui.NextMissionLabel:SetText()
    for i = 1, 3 do
        gui["NextFollower"..i.."Label"]:SetText()
    end
    gui.RewardsDetailLabel:SetText()
    gui.LowTimeWarningLabel:SetText()
end

local function updateRewardText(mission)
    local text = ""
    if mission.sacrifice then
        text = L["SacrificeMissionReport"]:format(mission.xp)
    else
        local rewards = C_Garrison.GetMissionRewardInfo(mission.missionID)
        if rewards then
            for _, reward in pairs(rewards) do
                if reward.currencyID and (reward.currencyID == 0) then
                    text = text..GetCoinTextureString(reward.quantity).."; "
                elseif reward.followerXP then
                    text = text..reward.followerXP.." "..L["BonusFollowerXP"].."; "
                elseif reward.itemID then
                    local _, itemLink = addon:GetItemInfo(reward.itemID)
                    itemLink = itemLink or "[item: "..reward.itemID.."]"
                    text = text..itemLink.." x"..reward.quantity.."; "
                elseif reward.currencyID and (reward.currencyID ~= 0) then
                    local info = C_CurrencyInfo.GetCurrencyInfo(reward.currencyID)
                    text = text..info.name.." x"..reward.quantity.."; "
                end
            end
        end
    end
    gui.RewardsDetailLabel:SetText(text)
end

local function processResults(results)
    local db = addon.WODdb
    
    if not results.counter then results.counter = missionCounter end
    
    if missionWaitingUserAcceptance then
        if results.successChance and (results.successChance >= 100) then
            local problem
            if missionWaitingUserAcceptance and (missionWaitingUserAcceptance.missionID == results.missionID) then
                problem = true
            end
            
            for _, r in pairs(calculatedMissionBacklog) do
                if r.missionID == results.missionID then
                    problem = true
                    break
                end
            end
            
            if not problem then
                table.insert(calculatedMissionBacklog, results)
                for i = 1, 3 do
                    if results.combination[i] then
                        alreadyUsedFollowers[results.combination[i]] = true
                    end
                end
            end
        end
        calculateNextMission()
        return
    end
    
    missionWaitingUserAcceptance = results
    
    clearReportText()
    
    if results.successChance and (results.successChance >= 100) then
        local _, _, _, _, duration = C_Garrison.GetMissionTimes(results.missionID)
        if not duration then duration = 3600 end
        duration = duration/3600
        gui.NextMissionLabel:SetText(string.format(L["MissionCounter"], results.counter or missionCounter, missionCounterUpper, C_Garrison.GetMissionName(results.missionID).." ("..string.format(COOLDOWN_DURATION_HOURS, math.floor(duration/0.5)*0.5)..")"))
        for i = 1, 3 do
            if results.combination[i] then
                alreadyUsedFollowers[results.combination[i]] = true
                gui["NextFollower"..i.."Label"]:SetText(C_Garrison.GetFollowerName(results.combination[i]))
            else
                gui["NextFollower"..i.."Label"]:SetText(L["Empty"])
            end
        end
        
        updateRewardText(results)
        
        gui.FailedCalcLabel:SetText()
        gui.CostLabel:Show()
        gui.CostResultLabel:SetText(((C_Garrison.GetMissionCost(missionWaitingUserAcceptance.missionID) or 10)).." "..WORLD_QUEST_REWARD_FILTERS_RESOURCES)
        local timeRemaining = (C_Garrison.GetBasicMissionInfo(results.missionID).offerEndTime or (GetTime() + 601)) - GetTime()
        if timeRemaining < 600 then
            gui.LowTimeWarningLabel:SetText(string.format(L["LowTimeWarning"], math.floor(timeRemaining/60), math.floor(mod(timeRemaining, 60))))
        end
        
        if db.profile.autoStart then
            gui.StartMissionButton:SetEnabled(true)
            gui.StartMissionButton:Click()
        else
            gui.StartMissionButton:SetEnabled(true)
            gui.SkipMissionButton:SetEnabled(true)
            calculateNextMission()
        end
    else
        numFailed = numFailed + 1
        missionWaitingUserAcceptance = nil
        clearReportText()
        if hasNextMission() then
            calculateNextMission()
        else
            gui.CalculateButton:SetEnabled(true)
            if (numSkipped > 0) or (numSent > 0) then
                local numFollowersAvailable = 0
                for _, follower in pairs(C_Garrison.GetFollowers(1)) do
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
                gui.FailedCalcLabel:SetText(L["AllSimsFailedError"])
                AceEvent:SendMessage("TLDRMISSIONS_SENT_FAILURE")
                if WeakAuras then
                    WeakAuras.ScanEvents("TLDRMISSIONS_SENT_FAILURE")
                end
            end
        end
        
        if table.getn(calculatedMissionBacklog) > 0 then
            processResults(table.remove(calculatedMissionBacklog, 1))
        end
    end
end

local sacrificeStarted
local function startSacrifice()
    if sacrificeStarted then return end
    sacrificeStarted = true
    
    local missions = C_Garrison.GetAvailableMissions(1)
    local excludedMissions = {}
    
    for _, category in pairs(db.profile.excludedRewards) do
        local missions = {}
        if category == "gold" then
            missions = addon:GetGoldMissions()
        elseif category == "followerxp" then
            missions = addon:GetFollowerXPMissions()
        elseif category == "followerxp-items" then
            missions = addon:GetFollowerXPItemMissions()
        elseif category == "anima" then
            missions = addon:GetAnimaMissions()
        elseif category == "pet-charms" then
            missions = addon:GetPetCharmMissions()
        elseif category == "augment-runes" then
            missions = addon:GetAugmentRuneMissions()
        elseif category == "reputation" then
            missions = addon:GetReputationMissions()
        elseif category == "crafting-cache" then
            missions = addon:GetCraftingCacheMissions()
        elseif category == "runecarver" then
            missions = addon:GetRunecarverMissions()    
        elseif category == "campaign" then
            missions = addon:GetCampaignMissions()
        elseif category == "gear" then
            missions = addon:GetGearMissions()
        elseif category == "sanctum" then
            missions = addon:GetSanctumFeatureMissions()
        end
        
        for _, mission in pairs(missions) do
            excludedMissions[mission.missionID] = true
        end
    end
    
    local m = {}
    for _, mission in pairs(missions) do
        local animaCost = C_Garrison.GetMissionCost(mission.missionID)
        if animaCost and (gui.AnimaCostLimitSlider:GetValue() >= animaCost) then
            local _, _, _, _, duration = C_Garrison.GetMissionTimes(mission.missionID)
            duration = duration/3600
            local d = db.profile.durationLower
            if d <= 1 then d = 0 end
            if (duration >= d) and (duration <= db.profile.durationHigher) and (not excludedMissions[mission.missionID]) then
                table.insert(m, mission)
            end
        end
    end
    
    missions = m
    
    table.sort(missions, function(a, b)
        if a.xp == b.xp then
            if a.durationSeconds == b.durationSeconds then
                return a.missionID < b.missionID
            end
            return a.durationSeconds < b.durationSeconds
        end
        return a.xp > b.xp
    end)
    
    local followers = C_Garrison.GetFollowers(1)
    local again
    repeat
        again = false
        for k, v in pairs(followers) do
            if v.status or alreadyUsedFollowers[v.followerID] or (v.level >= 60) then
                table.remove(followers, k)
                again = true
                break
            end
        end
    until not again
            
    local numFollowers = #followers
    if numFollowers == 0 then return end
    local combinations = {}
    while numFollowers > 0 do
        table.insert(combinations, {followers[numFollowers], followers[numFollowers-1], followers[numFollowers-2], followers[numFollowers-3], followers[numFollowers-4]})
        numFollowers = numFollowers - 5
    end
    
    for _, mission in ipairs(missions) do
        if #combinations < 1 then return end
        
        local combination = table.remove(combinations, 1)
        local c = {}
        for _, follower in pairs(combination) do
            table.insert(c, follower.followerID)
        end
        processResults({sacrifice = true, defeats = 0, victories = 1, incompletes = 0, ["combination"] = c, missionID = mission.missionID, xp = mission.xp})
    end
end

gui.CalculateButton:SetScript("OnClick", function (self, button)
    if C_Garrison.IsAboveFollowerSoftCap(1) then
        print(GARRISON_MAX_FOLLOWERS_MISSION_TOOLTIP)
        return
    end

    sacrificeStarted = false
    missionWaitingUserAcceptance = nil
    wipe(calculatedMissionBacklog)
    
    numSent = 0
    numSkipped = 0
    numFailed = 0
    
	self:SetEnabled(false)
    
    clearReportText()
    
    alreadyUsedFollowers = {}
    
    local db = addon.WODdb
    
    -- get missions matching conditions set
    local missions = {}
    local excludedMissions = {}

    for _, category in pairs(db.profile.excludedRewards) do
        local missions = {}
        if category == "gold" then
            missions = addon:GetWODGoldMissions()
        elseif category == "garrison-resources" then
            missions = addon:GetWODGarrisonResourcesMissions()
        elseif category == "follower-items" then
            missions = addon:GetWODFollowerItemMissions()
        elseif category == "followerxp" then
            missions = addon:GetWODFollowerXPMissions()
        elseif category == "gear" then
            missions = addon:GetWODGearMissions()
        elseif category == "apexis" then
            missions = addon:GetWODApexisMissions()
        elseif category == "oil" then
            missions = addon:GetWODOilMissions()
        elseif category == "seal" then
            missions = addon:GetWODSealMissions()
        elseif category == "archaeology" then
            missions = addon:GetWODArchaeologyMissions()
        end
        
        for _, mission in pairs(missions) do
            excludedMissions[mission.missionID] = true
        end
    end
    
    for i = 1, 12 do
        local newMissions = {}
        
        local acCategory
        if db.profile.selectedRewards[i] == "gold" then
            newMissions = addon:GetWODGoldMissions()
            acCategory = "Gold"
        elseif db.profile.selectedRewards[i] == "garrison-resources" then
            newMissions = addon:GetWODGarrisonResourcesMissions()
            acCategory = "GarrisonResources"
        elseif db.profile.selectedRewards[i] == "follower-items" then
            newMissions = addon:GetWODFollowerItemMissions()
            acCategory = "FollowerItems"
        elseif db.profile.selectedRewards[i] == "followerxp" then
            newMissions = addon:GetWODFollowerXPMissions()
            acCategory = "FollowerXP"
        elseif db.profile.selectedRewards[i] == "gear" then
            newMissions = addon:GetWODGearMissions()
            acCategory = "Gear"
        elseif db.profile.selectedRewards[i] == "apexis" then
            newMissions = addon:GetWODApexisMissions()
            acCategory = "Apexis"
        elseif db.profile.selectedRewards[i] == "oil" then
            newMissions = addon:GetWODOilMissions()
            acCategory = "Oil"
        elseif db.profile.selectedRewards[i] == "seal" then
            newMissions = addon:GetWODSealMissions()
            acCategory = "Seal"
        elseif db.profile.selectedRewards[i] == "archaeology" then
            newMissions = addon:GetWODArchaeologyMissions()
            acCategory = "Archaeology"
        end
        
        for _, mission in ipairs(newMissions) do
            local exists = false
            for _, mission2 in pairs(missions) do
                if mission.missionID == mission2.missionID then
                    exists = true
                    break
                end
            end
            if (not exists) and (not excludedMissions[mission.missionID]) then
                local animaCost = C_Garrison.GetMissionCost(mission.missionID)
                if not animaCost then animaCost = 1 end
                if      ( gui.AnimaCostLimitSlider:GetValue() >= animaCost ) and
                        (
                          ( (animaCost < 25) and db.profile.animaCosts[acCategory]["10-24"] ) or
                          ( (animaCost < 30) and (animaCost > 24) and db.profile.animaCosts[acCategory]["25-29"] ) or
                          ( (animaCost < 50) and (animaCost > 29) and db.profile.animaCosts[acCategory]["30-49"] ) or
                          ( (animaCost < 100) and (animaCost > 49) and db.profile.animaCosts[acCategory]["50-99"] ) or 
                          ( (animaCost > 99) and db.profile.animaCosts[acCategory]["100+"] )
                        ) then
                    local _, _, _, _, duration = C_Garrison.GetMissionTimes(mission.missionID)
                    duration = duration/3600
                    
                    -- support 1 minute missions under a minimum of 1 hour setting
                    local d = db.profile.durationLower
                    if d <= 1 then d = 0 end
                    if (duration >= d) and (duration <= db.profile.durationHigher) then
                        table.insert(missions, mission)
                    end
                end
            end
        end
    end
    
    if db.profile.anythingForXP then
        local newMissions = C_Garrison.GetAvailableMissions(1)
        
        -- filter out missions already in the queue
        for key, mission in pairs(newMissions) do
            local exists = false
            for _, mission2 in pairs(missions) do
                if mission.missionID == mission2.missionID then
                    exists = true
                    break
                end
            end
            
            if exists then
                newMissions[key] = nil
            end
        end
        
        local n = {}
        for k, v in pairs(newMissions) do
            table.insert(n, v)
        end
        newMissions = n
        
        table.sort(newMissions, function(a, b)
            if a.xp == b.xp then
                return a.missionID < b.missionID
            end
            return a.xp > b.xp
        end)
        
        for _, mission in ipairs(newMissions) do
            local animaCost = C_Garrison.GetMissionCost(mission.missionID)
            if not animaCost then animaCost = 1 end
            local acCategory = "AnythingForXP"
            if      ( gui.AnimaCostLimitSlider:GetValue() >= animaCost ) and
                    (
                        ( (animaCost < 25) and db.profile.animaCosts[acCategory]["10-24"] ) or
                        ( (animaCost < 30) and (animaCost > 24) and db.profile.animaCosts[acCategory]["25-29"] ) or
                        ( (animaCost < 50) and (animaCost > 29) and db.profile.animaCosts[acCategory]["30-49"] ) or
                        ( (animaCost < 100) and (animaCost > 49) and db.profile.animaCosts[acCategory]["50-99"] ) or 
                        ( (animaCost > 99) and db.profile.animaCosts[acCategory]["100+"] )
                    ) then
                local _, _, _, _, duration = C_Garrison.GetMissionTimes(mission.missionID)
                duration = duration/3600
                
                local d = db.profile.durationLower
                if d <= 1 then d = 0 end
                if (duration >= d) and (duration <= db.profile.durationHigher) then
                    mission.useSpecialTreatment = true
                    table.insert(missions, mission)
                end
            end
        end
    end
    
    if (table.getn(missions) == 0) and (not db.profile.sacrificeRemaining) then
        gui.FailedCalcLabel:SetText(L["MissionsAboveRestrictionsError"])
        gui.CalculateButton:SetEnabled(true)
        if WeakAuras then WeakAuras.ScanEvents("TLDRMISSIONS_SENT_NONE") end
        return
    end
    
    local followers = C_Garrison.GetFollowers(1)
    local followerLineup = {}
    for _, follower in ipairs(followers) do
        if (not follower.status) and (follower.isCollected) then
            table.insert(followerLineup, follower.followerID)
        end
    end 
    
    if table.getn(followerLineup) == 0 then
        gui.FailedCalcLabel:SetText(L["FollowersUnavailableError"])
        gui.CalculateButton:SetEnabled(true)
        return
    end 
    
    setNextMissionText = function()
        if nextMission then
            gui.FailedCalcLabel:SetText()
            local _, _, _, _, duration = C_Garrison.GetMissionTimes(nextMission.missionID)
            if not duration then duration = 3600 end
            duration = duration/3600
            gui.NextMissionLabel:SetText(string.format(L["MissionCounter"], (missionCounter>0) and missionCounter or 1, missionCounterUpper, nextMission.name).." ("..string.format(COOLDOWN_DURATION_HOURS, math.floor(duration/0.5)*0.5)..")")
            gui.NextFollower1Label:SetText(L["Calculating"])
            updateRewardText(nextMission)
            return true
        end
    end
    
    hasNextMission = function()
        return (table.getn(missions) > 0) or db.profile.sacrificeRemaining
    end
    
    missionCounter = 0
    missionCounterUpper = table.getn(missions)
    
    calculateNextMission = function()
        nextMission = table.remove(missions, 1)
        
        if (not missionWaitingUserAcceptance) then
            missionCounter = missionCounter + 1
            if not setNextMissionText() then
                gui.NextMissionLabel:SetText()
                for i = 1, 3 do
                    gui["NextFollower"..i.."Label"]:SetText()
                end
                gui.RewardsDetailLabel:SetText()
                gui.LowTimeWarningLabel:SetText()
                gui.CalculateButton:SetEnabled(true)
            end
            missionCounter = missionCounter - 1
        end
        
        if (not nextMission) and db.profile.sacrificeRemaining then
            startSacrifice()
        end
        if not nextMission then
            return
        end
        
        missionCounter = missionCounter + 1
        
        if nextMission.missionScalar > 60 then
            nextMission.missionScalar = 60
        end
        
        local cost = C_Garrison.GetMissionCost(nextMission.missionID)
        if not cost then cost = 1 end
        if not nextMission.offerEndTime then nextMission.offerEndTime = GetTime() + 601 end
        if (nextMission.offerEndTime < GetTime()) or (gui.AnimaCostLimitSlider:GetValue() < cost) then
            if (not missionWaitingUserAcceptance) then
                clearReportText()
                gui.FailedCalcLabel:SetText(L["AnimaCostLimitError"])
            end
            calculateNextMission()
            return
        end
        
        followerLineup = {}
        
        local useSpecialTreatment = false
        if gui.FollowerXPSpecialTreatmentCheckButton:GetChecked() then
            if nextMission.useSpecialTreatment then
                useSpecialTreatment = true
            else
                local rewards = C_Garrison.GetMissionRewardInfo(nextMission.missionID)
                if rewards then
                    for _, reward in pairs(rewards) do
                        if reward.followerXP then
                            useSpecialTreatment = true
                            break
                        end
                    end
                end
            end
        end
        
        if useSpecialTreatment then
            if (db.profile.followerXPSpecialTreatmentAlgorithm == 1) or (db.profile.followerXPSpecialTreatmentAlgorithm == 2) then -- "All low level followers, lowest level first"
                for _, follower in ipairs(followers) do
                    if (not follower.status) and follower.isCollected and (not alreadyUsedFollowers[follower.followerID]) and (follower.level < 40) then
                        table.insert(followerLineup, follower.followerID)
                    end
                end
            else -- "Followers required to level troops only"
                local numFollowers = #followers
                if numFollowers > 0 then
                    local median = numFollowers/2
                    median = math.floor(median)
                    median = median + 1
                    
                    table.sort(followers, function(a, b)
                        if a.level == b.level then
                            if a.xp == b.xp then
                                return a.garrFollowerID < b.garrFollowerID
                            end
                            return a.xp > b.xp
                        end
                        return a.level > b.level
                    end)
                    
                    for i = 1, median do
                        if (not followers[i].status) and followers[i].isCollected and (not alreadyUsedFollowers[followers[i].followerID]) and (followers[i].level < 40) then
                            table.insert(followerLineup, followers[i].followerID)
                        end
                    end
                end
            end
            
            if (table.getn(followerLineup) < tonumber(db.profile.followerXPSpecialTreatmentMinimum)) then
                if not missionWaitingUserAcceptance then
                    clearReportText()
                    gui.FailedCalcLabel:SetText(L["RestrictedFollowersUnavailableError"])
                end
                calculateNextMission()
                return
            end
            
            if (db.profile.followerXPSpecialTreatmentAlgorithm == 1) or (db.profile.followerXPSpecialTreatmentAlgorithm == 1) then
                addon:arrangeWODFollowerCombinations(followerLineup, nextMission.missionID, processResults, "lowestLevel")
            elseif db.profile.followerXPSpecialTreatmentAlgorithm == 2 then
                addon:arrangeWODFollowerCombinations(followerLineup, nextMission.missionID, processResults, "highestLevel")
            else
                addon:arrangeWODFollowerCombinations(followerLineup, nextMission.missionID, processResults, "lowestLevel")
            end
        else
            for _, follower in ipairs(followers) do
                if (not follower.status) and follower.isCollected and (not alreadyUsedFollowers[follower.followerID]) then
                    if (follower.level + gui.LowerBoundLevelRestrictionSlider:GetValue()) >= nextMission.missionScalar then
                        table.insert(followerLineup, follower.followerID)
                    end
                end
            end 
        
            if table.getn(followerLineup) == 0 then
                if not missionWaitingUserAcceptance then
                    clearReportText()
                    gui.FailedCalcLabel:SetText(L["RestrictedFollowersUnavailableError"])
                end
                calculateNextMission()
                return
            end
            
            addon:arrangeWODFollowerCombinations(followerLineup, nextMission.missionID, processResults, "lowestLevel")
        end
    end
    
    calculateNextMission()
end)

local afterConfirmationEvent
RunNextFrame(function()
    hooksecurefunc(addon, "garrisonMissionStartedHandler", function(self, garrFollowerTypeID, missionID)
        if garrFollowerTypeID ~= 1 then return end
        if afterConfirmationEvent then
            afterConfirmationEvent(missionID)
        end
    end)
end)

gui.StartMissionButton:SetScript("OnClick", function(self, button)
    self:SetEnabled(false)
    
    if not missionWaitingUserAcceptance then
        print("Error: mission awaiting user acceptance not found")
        return
    end
    
    local missions = C_Garrison.GetAvailableMissions(1)
    local found = false
    for _, mission in pairs(missions) do
        if mission.missionID == missionWaitingUserAcceptance.missionID then
            found = true
            break
        end
    end
    if not found then
        if table.getn(calculatedMissionBacklog) > 0 then
            processResults(table.remove(calculatedMissionBacklog, 1), true)
        end
        return
    end
    
    local animaCost = C_Garrison.GetMissionCost(missionWaitingUserAcceptance.missionID)
    local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(824)
	local amountOwned = currencyInfo.quantity;
	if (amountOwned < animaCost) then
		clearReportText()
        gui.FailedCalcLabel:SetText(L["NotEnoughAnimaError"])
        gui.SkipMissionButton:SetEnabled(true)
        self:SetEnabled(true)
        AceEvent:SendMessage("TLDRMISSIONS_NOT_ENOUGH_ANIMA")
        if WeakAuras then
            WeakAuras.ScanEvents("TLDRMISSIONS_NOT_ENOUGH_ANIMA")
        end
        return
	end
    
    -- remove any followers already pending for this mission
    local lineup =  C_Garrison.GetBasicMissionInfo(missionWaitingUserAcceptance.missionID).followers
    if lineup then
        for _, followerID in pairs(lineup) do
            C_Garrison.RemoveFollowerFromMission(missionWaitingUserAcceptance.missionID, followerID)
        end
    end
    
    local success = true
    -- results.combination : combination will be in the order frontleft, frontmid, frontright, backleft, backright
    if missionWaitingUserAcceptance.combination[1] then
        if not C_Garrison.AddFollowerToMission(missionWaitingUserAcceptance.missionID, missionWaitingUserAcceptance.combination[1], 1) then
            success = false
        end
    end
    if missionWaitingUserAcceptance.combination[2] then
        if not C_Garrison.AddFollowerToMission(missionWaitingUserAcceptance.missionID, missionWaitingUserAcceptance.combination[2], 2) then
            success = false
        end
    end
    if missionWaitingUserAcceptance.combination[3] then
        if not C_Garrison.AddFollowerToMission(missionWaitingUserAcceptance.missionID, missionWaitingUserAcceptance.combination[3], 3) then
            success = false
        end
    end
    
    -- check the pending followers are correct, incase a slot was taken or something
    local lineup = C_Garrison.GetBasicMissionInfo(missionWaitingUserAcceptance.missionID).followers
    if not lineup then success = false end
    for i = 1, 3 do
        if missionWaitingUserAcceptance.combination[i] then
            local found = false
            for _, followerID in pairs(lineup) do
                if missionWaitingUserAcceptance.combination[i] == followerID then
                    found = true
                end
            end
            if not found then success = false end
        end
    end
    
    if not success then
        print("Error: something went wrong with mission "..missionWaitingUserAcceptance.missionID.."; one or more followers were not correctly added")
        return
    else
        C_Timer.After(0.4, function()
            if not missionWaitingUserAcceptance then return end
            lineup = C_Garrison.GetBasicMissionInfo(missionWaitingUserAcceptance.missionID).followers
            if not lineup then success = false end
            for i = 1, 3 do
                if missionWaitingUserAcceptance.combination[i] then
                    local found = false
                    for _, followerID in pairs(lineup) do
                        if missionWaitingUserAcceptance.combination[i] == followerID then
                            found = true
                        end
                    end
                    if not found then success = false end
                end
            end
            
            if not success then
                print("Error: something went wrong with mission "..missionWaitingUserAcceptance.missionID.."; one or more followers were not correctly added")
                return
            end
            
            C_Garrison.StartMission(missionWaitingUserAcceptance.missionID)
            AceEvent:SendMessage("TLDRMISSIONS_START_MISSION", missionWaitingUserAcceptance.missionID, C_AddOns.GetAddOnMetadata(addonName, "Version"))
            numSent = numSent + 1
        end)
    end
    
    afterConfirmationEvent = function(missionID)
        if not missionWaitingUserAcceptance then return end
        if missionID ~= missionWaitingUserAcceptance.missionID then
            print("Error: Blizzard sent back confirmation for a different mission")
        end
        
        clearReportText()
        setNextMissionText()
        missionWaitingUserAcceptance = nil
        afterConfirmationEvent = nil
        
        if table.getn(calculatedMissionBacklog) > 0 then
            processResults(table.remove(calculatedMissionBacklog, 1), true)
        else
            gui.EstimateLabel:SetText()
            if hasNextMission() then
                calculateNextMission()
            end
            clearReportText()
            if numSkipped > 0 then
                local numFollowersAvailable = 0
                for _, follower in pairs(C_Garrison.GetFollowers(1)) do
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
                gui.NextMissionLabel:SetText(L["MissonsSentSuccess"])
                -- two different ways to "listen" for this addon announcing the missions have been sent.
                AceEvent:SendMessage("TLDRMISSIONS_SENT_SUCCESS")
                if WeakAuras then
                    WeakAuras.ScanEvents("TLDRMISSIONS_SENT_SUCCESS")
                end
            end
            gui.CalculateButton:SetEnabled(true)
        end
    end
end)

gui.AnimaCostLimitSlider:SetScript("OnValueChanged", function(self, value, userInput)
    TLDRMissionsWODFrameAnimaCostSliderText:SetText(value)
    addon.WODdb.profile.AnimaCostLimit = value
end)

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
        gui.CalculateButton:SetEnabled(true)
        
        local numFollowersAvailable = 0
        for _, follower in pairs(C_Garrison.GetFollowers(1)) do
            if (not follower.status) and (follower.isCollected) then
                numFollowersAvailable = numFollowersAvailable + 1
            end
        end
        gui.FailedCalcLabel:SetText(L["MissionsSentPartial"]:format(numSent, numSkipped, numFailed, numFollowersAvailable))
        AceEvent:SendMessage("TLDRMISSIONS_SENT_PARTIAL", numSent, numSkipped, numFailed, numFollowersAvailable)
        if WeakAuras then
            WeakAuras.ScanEvents("TLDRMISSIONS_SENT_PARTIAL", numSent, numSkipped, numFailed, numFollowersAvailable)
        end
    end
end)

gui.LowerBoundLevelRestrictionSlider:SetScript("OnValueChanged", function(self, value, userInput)
    TLDRMissionsWODFrameSliderText:SetText(value)
    addon.WODdb.profile.LevelRestriction = value
end)

gui.DurationLowerSlider:SetScript("OnValueChanged", function(self, value, userInput)
    if not userInput then return end
    addon.WODdb.profile.durationLower = value
    if tonumber(addon.WODdb.profile.durationLower) > tonumber(addon.WODdb.profile.durationHigher) then
        local a = addon.WODdb.profile.durationLower
        addon.WODdb.profile.durationLower = addon.WODdb.profile.durationHigher
        addon.WODdb.profile.durationHigher = a
        gui.DurationLowerSlider:SetValue(addon.WODdb.profile.durationLower)
        gui.DurationHigherSlider:SetValue(addon.WODdb.profile.durationHigher)
    end
    TLDRMissionsWODFrameDurationLowerSliderText:SetText(L["DurationTimeSelectedLabel"]:format(addon.WODdb.profile.durationLower, addon.WODdb.profile.durationHigher))
end)

gui.DurationHigherSlider:SetScript("OnValueChanged", function(self, value, userInput)
    if not userInput then return end
    local db = addon.WODdb
    db.profile.durationHigher = value
    if tonumber(db.profile.durationLower) > tonumber(db.profile.durationHigher) then
        local a = db.profile.durationLower
        db.profile.durationLower = db.profile.durationHigher
        db.profile.durationHigher = a
        gui.DurationLowerSlider:SetValue(db.profile.durationLower)
        gui.DurationHigherSlider:SetValue(db.profile.durationHigher)
    end
    TLDRMissionsFrameDurationLowerSliderText:SetText(L["DurationTimeSelectedLabel"]:format(db.profile.durationLower, db.profile.durationHigher))
end)