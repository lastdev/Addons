local addonName, addon = ...
local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")
local LibStub = addon.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale("TLDRMissions")
local AceEvent = LibStub("AceAddon-3.0"):GetAddon("TLDRMissions-AceEvent")

local gui = addon.LegionGUI

local nextMission
local hasNextMission
local missionCounter
local missionCounterUpper
local calculateNextMission
local setNextMissionText

local missionWaitingUserAcceptance

local alreadyUsedFollowers

local numSent
local numSkipped
local numFailed

C_Timer.After(1, function()

local function processResults(lineup, result, missionID)
    local db = addon.Legiondb
    
    if missionWaitingUserAcceptance then
        return
    end
    
    missionWaitingUserAcceptance = {
        combination = lineup,
        missionID = missionID,
    }
    
    gui:clearReportText(true)
    
    if result and (result >= 100) then
        local _, _, _, _, duration = C_Garrison.GetMissionTimes(missionID)
        if not duration then duration = 3600 end
        duration = duration/3600
        gui.NextMissionLabel:SetText(string.format(L["MissionCounter"], missionCounter, missionCounterUpper, C_Garrison.GetMissionName(missionID).." ("..string.format(COOLDOWN_DURATION_HOURS, math.floor(duration/0.5)*0.5)..")"))
        for i = 1, 3 do
            if lineup[i] then
                alreadyUsedFollowers[lineup[i]] = true
                gui["NextFollower"..i.."Label"]:SetText(C_Garrison.GetFollowerName(lineup[i]))
            else
                gui["NextFollower"..i.."Label"]:SetText(L["Empty"])
            end
        end
        
        gui:updateRewardText(missionID)
        
        gui.FailedCalcLabel:SetText()
        gui.CostLabel:Show()
        gui.CostResultLabel:SetText(((C_Garrison.GetMissionCost(missionID) or 10)).." "..WORLD_QUEST_REWARD_FILTERS_RESOURCES)
        local timeRemaining = (C_Garrison.GetBasicMissionInfo(missionID).offerEndTime or (GetTime() + 601)) - GetTime()
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
        gui:clearReportText(true)
        if hasNextMission() then
            calculateNextMission()
        else
            gui.CalculateButton:SetEnabled(true)
            if (numSkipped > 0) or (numSent > 0) then
                local numFollowersAvailable = 0
                for _, follower in pairs(C_Garrison.GetFollowers(gui.followerTypeID)) do
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
    end
end

local sacrificeStarted
local function startSacrifice()
    if sacrificeStarted then return end
    sacrificeStarted = true
    
    local missions = C_Garrison.GetAvailableMissions(gui.followerTypeID)
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
    
    local followers = C_Garrison.GetFollowers(gui.followerTypeID)
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
    if C_Garrison.IsAboveFollowerSoftCap(4) then
        print(GARRISON_MAX_FOLLOWERS_MISSION_TOOLTIP)
        return
    end

    sacrificeStarted = false
    missionWaitingUserAcceptance = nil
    
    numSent = 0
    numSkipped = 0
    numFailed = 0
    
	self:SetEnabled(false)
    
    gui:clearReportText(true)
    
    alreadyUsedFollowers = {}
    
    local db = addon.Legiondb
    
    -- get missions matching conditions set
    local missions = {}
    local excludedMissions = {}

    for _, category in pairs(db.profile.excludedRewards) do
        local missions = {}
        if category == "gold" then
            missions = gui:GetGoldMissions()
        elseif category == "resources" then
            missions = gui:GetTableResourcesMissions()
        elseif category == "follower-items" then
            missions = gui:GetFollowerItemMissions()
        elseif category == "pet-charms" then
            missions = gui:GetPetCharmMissions()
        elseif category == "gear" then
            missions = gui:GetGearMissions()
        elseif category == "reputation" then
            missions = gui:GetReputationMissions()
        elseif category == "crafting-reagents" then
            missions = gui:GetCraftingReagentMissions()
        end
        
        for _, mission in pairs(missions) do
            excludedMissions[mission.missionID] = true
        end
    end
    
    for i = 1, 12 do
        local newMissions = {}
        
        local acCategory
        if db.profile.selectedRewards[i] == "gold" then
            newMissions = gui:GetGoldMissions()
            acCategory = "Gold"
        elseif db.profile.selectedRewards[i] == "resources" then
            newMissions = gui:GetTableResourcesMissions()
            acCategory = "Resources"
        elseif db.profile.selectedRewards[i] == "follower-items" then
            newMissions = gui:GetFollowerItemMissions()
            acCategory = "FollowerItems"
        elseif db.profile.selectedRewards[i] == "pet-charms" then
            newMissions = gui:GetPetCharmMissions()
            acCategory = "PetCharms"
        elseif db.profile.selectedRewards[i] == "gear" then
            newMissions = gui:GetGearMissions()
            acCategory = "Gear"
        elseif db.profile.selectedRewards[i] == "reputation" then
            newMissions = gui:GetReputationMissions()
            acCategory = "Reputation"
        elseif db.profile.selectedRewards[i] == "crafting-reagents" then
            newMissions = gui:GetCraftingReagentMissions()
            acCategory = "CraftingReagents"
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
        local newMissions = C_Garrison.GetAvailableMissions(4)
        
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
        newMissions = gui:SortMissions(n)
        
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
    
    local followers = C_Garrison.GetFollowers(4)
    local followerLineup = {}
    local troopLineup = {}
    for _, follower in ipairs(followers) do
        if (not follower.status) and (follower.isCollected) then
            if follower.isTroop then
                table.insert(troopLineup, follower.followerID)
            else
                table.insert(followerLineup, follower.followerID)
            end
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
            gui:updateRewardText(nextMission.missionID)
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
                gui.clearReportText()
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
                gui:clearReportText()
                gui.FailedCalcLabel:SetText(L["AnimaCostLimitError"])
            end
            calculateNextMission()
            return
        end
        
        followerLineup = {}
        local troopLineup = {} 
        
        for _, follower in ipairs(followers) do
            if (not follower.status) and follower.isCollected and (not alreadyUsedFollowers[follower.followerID]) then
                if (follower.level + gui.LowerBoundLevelRestrictionSlider:GetValue()) >= nextMission.missionScalar then
                    if follower.isTroop then
                        table.insert(troopLineup, follower.followerID)
                    else
                        table.insert(followerLineup, follower.followerID)
                    end
                end
            end
        end 
    
        if table.getn(followerLineup) == 0 then
            if not missionWaitingUserAcceptance then
                gui:clearReportText(true)
                gui.FailedCalcLabel:SetText(L["RestrictedFollowersUnavailableError"])
            end
            calculateNextMission()
            return
        end
        
        local lineup, result = addon.LegionGUI:arrangeFollowerTroopCombinations(followerLineup, troopLineup, nextMission.missionID, "lowestLevel")
        processResults(lineup, result, nextMission.missionID)
    end
    
    calculateNextMission()
end)

local afterConfirmationEvent
RunNextFrame(function()
    hooksecurefunc(addon, "garrisonMissionStartedHandler", function(self, garrFollowerTypeID, missionID)
        if garrFollowerTypeID ~= 4 then return end
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
    
    local missions = C_Garrison.GetAvailableMissions(4)
    local found = false
    for _, mission in pairs(missions) do
        if mission.missionID == missionWaitingUserAcceptance.missionID then
            found = true
            break
        end
    end
    if not found then
        if hasNextMission() then
            calculateNextMission()
        end
        return
    end
    
    local animaCost = C_Garrison.GetMissionCost(missionWaitingUserAcceptance.missionID)
    local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(1220)
	local amountOwned = currencyInfo.quantity;
	if (amountOwned < animaCost) then
		gui:clearReportText()
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
    -- results.combination : combination will be in the order left, mid, right
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
    
    -- check the pending followers are correct, in case a slot was taken or something
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
        
        gui:clearReportText(true)
        setNextMissionText()
        missionWaitingUserAcceptance = nil
        afterConfirmationEvent = nil
        
        if hasNextMission() then
            calculateNextMission()
        else
            gui.EstimateLabel:SetText()
            gui:clearReportText(true)
            if numSkipped > 0 then
                local numFollowersAvailable = 0
                for _, follower in pairs(C_Garrison.GetFollowers(gui.followerTypeID)) do
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
                AceEvent:SendMessage("TLDRMISSIONS_SENT_SUCCESS")
            end
            gui.CalculateButton:SetEnabled(true)
        end
    end
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
    
    gui:clearReportText(true)
    gui.EstimateLabel:SetText()
    gui.CalculateButton:SetEnabled(true)
    
    local numFollowersAvailable = 0
    for _, follower in pairs(C_Garrison.GetFollowers(gui.followerTypeID)) do
        if (not follower.status) and (follower.isCollected) then
            numFollowersAvailable = numFollowersAvailable + 1
        end
    end
    gui.FailedCalcLabel:SetText(L["MissionsSentPartial"]:format(numSent, numSkipped, numFailed, numFollowersAvailable))
    AceEvent:SendMessage("TLDRMISSIONS_SENT_PARTIAL", numSent, numSkipped, numFailed, numFollowersAvailable)
    if WeakAuras then
        WeakAuras.ScanEvents("TLDRMISSIONS_SENT_PARTIAL", numSent, numSkipped, numFailed, numFollowersAvailable)
    end
end)

end)