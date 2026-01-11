local addonName, addon = ...
local LibStub = addon.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale("TLDRMissions")

function addon.BaseGUIMixin:processResults(lineup, result, missionID)
    local db = self.db
    
    if self.missionWaitingUserAcceptance then
        return
    end
    
    self:clearReportText(true)
    
    if result and (result >= 100) then
        self.missionWaitingUserAcceptance = {
            combination = lineup,
            missionID = missionID,
        }
        
        local _, _, _, _, duration = C_Garrison.GetMissionTimes(missionID)
        if not duration then duration = 3600 end
        duration = duration/3600
        self.NextMissionLabel:SetText(string.format(L["MissionCounter"], self.missionCounter, self.missionCounterUpper, C_Garrison.GetMissionName(missionID).." ("..string.format(COOLDOWN_DURATION_HOURS, math.floor(duration/0.5)*0.5)..")"))
        for i = 1, 3 do
            if lineup[i] then
                self["NextFollower"..i.."Label"]:SetText(C_Garrison.GetFollowerName(lineup[i]))
            else
                self["NextFollower"..i.."Label"]:SetText(L["Empty"])
            end
        end
        
        self:updateRewardText(missionID)
        
        self.CostLabel:Show()
        self.CostResultLabel:SetText(((C_Garrison.GetMissionCost(missionID) or 10)).." "..WORLD_QUEST_REWARD_FILTERS_RESOURCES)
        local timeRemaining = (C_Garrison.GetBasicMissionInfo(missionID).offerEndTime or (GetTime() + 601)) - GetTime()
        if timeRemaining < 600 then
            self.LowTimeWarningLabel:SetText(string.format(L["LowTimeWarning"], math.floor(timeRemaining/60), math.floor(mod(timeRemaining, 60))))
        end
        
        self.StartMissionButton:SetEnabled(true)
        if db.profile.autoStart then
            self.StartMissionButton:Click()
        else
            self.SkipMissionButton:SetEnabled(true)
        end
    else
        self.numFailed = self.numFailed + 1
        self:clearReportText(true)
        if self:hasNextMission() then
            self:calculateNextMission()
        else
            self.CalculateButton:SetEnabled(true)
            if (self.numSkipped > 0) or (self.numSent > 0) then
                local numFollowersAvailable = 0
                for _, follower in pairs(C_Garrison.GetFollowers(self.followerTypeID)) do
                    if (not follower.status) and (follower.isCollected) then
                        numFollowersAvailable = numFollowersAvailable + 1
                    end
                end
                self.FailedCalcLabel:SetText(L["MissionsSentPartial"]:format(self.numSent, self.numSkipped, self.numFailed, self.numFollowersAvailable))
            else
                self.FailedCalcLabel:SetText(L["AllSimsFailedError"])
            end
        end
    end
end

function addon.BaseGUIMixin:setNextMissionText()
    if self.nextMission then
        self.FailedCalcLabel:SetText()
        local _, _, _, _, duration = C_Garrison.GetMissionTimes(self.nextMission.missionID)
        if not duration then duration = 3600 end
        duration = duration/3600
        self.NextMissionLabel:SetText(string.format(L["MissionCounter"], (self.missionCounter > 0) and self.missionCounter or 1, self.missionCounterUpper, self.nextMission.name).." ("..string.format(COOLDOWN_DURATION_HOURS, math.floor(duration/0.5)*0.5)..")")
        self.NextFollower1Label:SetText(L["Calculating"])
        self:updateRewardText(self.nextMission.missionID)
        return true
    end
end

function addon.BaseGUIMixin:hasNextMission()
    return (table.getn(self.missions) > 0) or self.db.profile.sacrificeRemaining
end

function addon.BaseGUIMixin:calculateNextMission()
    if self.missionWaitingUserAcceptance then
        return
    end
    
    self.nextMission = table.remove(self.missions, 1)
    local nextMission = self.nextMission
    
    self.missionCounter = self.missionCounter + 1
    if not self:setNextMissionText() then
        self:clearReportText()
    end
    self.missionCounter = self.missionCounter - 1
    
    if (not nextMission) and self.db.profile.sacrificeRemaining then
        startSacrifice()
    end
    if not nextMission then
        return
    end
    
    self.missionCounter = self.missionCounter + 1
    
    if nextMission.missionScalar > 60 then
        nextMission.missionScalar = 60
    end
    
    local cost = C_Garrison.GetMissionCost(nextMission.missionID)
    if not cost then cost = 1 end
    if not nextMission.offerEndTime then nextMission.offerEndTime = GetTime() + 601 end
    if (nextMission.offerEndTime < GetTime()) or (self.AnimaCostLimitSlider:GetValue() < cost) then
        self:clearReportText(true)
        self.FailedCalcLabel:SetText(L["AnimaCostLimitError"])
        self:calculateNextMission()
        return
    end
    
    local followers = C_Garrison.GetFollowers(self.followerTypeID)
    
    if table.getn(followers) == 0 then
        self.FailedCalcLabel:SetText(L["FollowersUnavailableError"])
        self.CalculateButton:SetEnabled(true)
        return
    end
    
    self.followerLineup = {}
    self.troopLineup = {}
    local followerLineup = self.followerLineup
    local troopLineup = self.troopLineup
    
    for _, follower in ipairs(followers) do
        if (not follower.status) and follower.isCollected then
            if (follower.level + self.LowerBoundLevelRestrictionSlider:GetValue()) >= nextMission.missionScalar then
                if follower.isTroop then
                    table.insert(troopLineup, follower.followerID)
                else
                    table.insert(followerLineup, follower.followerID)
                end
            end
        end
    end 

    if table.getn(followerLineup) == 0 then
        if not self.missionWaitingUserAcceptance then
            self:clearReportText(true)
            self.FailedCalcLabel:SetText(L["RestrictedFollowersUnavailableError"])
        end
        self:calculateNextMission()
        return
    end
    
    local lineup, result
    if self == addon.WODGUI then
        lineup, result = self:arrangeFollowerCombinations(followerLineup, nextMission.missionID, "lowestLevel")
    else
        lineup, result = self:arrangeFollowerTroopCombinations(followerLineup, troopLineup, nextMission.missionID, "lowestLevel")
    end
    self:processResults(lineup, result, nextMission.missionID)
end

local function calculateButtonHandler(self)
    local gui = self:GetParent():GetParent()
    
    if C_Garrison.IsAboveFollowerSoftCap(gui.followerTypeID) then
        print(GARRISON_MAX_FOLLOWERS_MISSION_TOOLTIP)
        return
    end

    gui.sacrificeStarted = false
    gui.missionWaitingUserAcceptance = nil
    gui.numSent = 0
    gui.numSkipped = 0
    gui.numFailed = 0
    
	self:SetEnabled(false)
    
    gui:clearReportText(true)
  
    local db = gui.db
    
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
        elseif category == "followerxp" then
            missions = gui:GetFollowerXPMissions()
        elseif category == "apexis" then
            missions = gui:GetApexisMissions()
        elseif category == "oil" then
            missions = gui:GetOilMissions()
        elseif category == "seal" then
            missions = gui:GetSealMissions()
        elseif category == "archaeology" then
            missions = gui:GetArchaeologyMissions()
        elseif category == "reputation" then
            missions = gui:GetReputationMissions()
        elseif category == "crafting-reagents" then
            missions = gui:GetCraftingReagentMissions()
        elseif category == "artifact-power" then
            missions = gui:GetArtifactPowerMissions()
        elseif category == "augment-runes" then
            missions = addon:GetAugmentRuneMissions()
        end
        
        for _, mission in pairs(missions) do
            excludedMissions[mission.missionID] = true
        end
    end
    
    local missions = {}
    
    for i = 1, 12 do
        local newMissions = {}
        
        local acCategory
        local selectedReward = db.profile.selectedRewards[i]
        if selectedReward == "gold" then
            newMissions = gui:GetGoldMissions()
            acCategory = "Gold"
        elseif selectedReward == "resources" then
            newMissions = gui:GetTableResourcesMissions()
            acCategory = "Resources"
        elseif selectedReward == "follower-items" then
            newMissions = gui:GetFollowerItemMissions()
            acCategory = "FollowerItems"
        elseif selectedReward == "pet-charms" then
            newMissions = gui:GetPetCharmMissions()
            acCategory = "PetCharms"
        elseif selectedReward == "gear" then
            newMissions = gui:GetGearMissions()
            acCategory = "Gear"
        elseif selectedReward == "reputation" then
            newMissions = gui:GetReputationMissions()
            acCategory = "Reputation"
        elseif selectedReward == "crafting-reagents" then
            newMissions = gui:GetCraftingReagentMissions()
            acCategory = "CraftingReagents"
        elseif selectedReward == "artifact-power" then
            newMissions = gui:GetArtifactPowerMissions()
            acCategory = "ArtifactPower"
        elseif selectedReward == "followerxp" then
            newMissions = gui:GetFollowerXPMissions()
            acCategory = "FollowerXP"
        elseif selectedReward == "apexis" then
            newMissions = gui:GetApexisMissions()
            acCategory = "Apexis"
        elseif selectedReward == "oil" then
            newMissions = gui:GetOilMissions()
            acCategory = "Oil"
        elseif selectedReward == "seal" then
            newMissions = gui:GetSealMissions()
            acCategory = "Seal"
        elseif selectedReward == "archaeology" then
            newMissions = gui:GetArchaeologyMissions()
            acCategory = "Archaeology"
        elseif selectedReward == "augment-runes" then
            newMissions = gui:GetAugmentRuneMissions()
            acCategory = "AugmentRunes"
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
                local missionCost = C_Garrison.GetMissionCost(mission.missionID)
                if not missionCost then missionCost = 1 end
                if      ( gui.AnimaCostLimitSlider:GetValue() >= missionCost ) and
                        (
                          ( (missionCost < 25) and db.profile.animaCosts[acCategory]["10-24"] ) or
                          ( (missionCost < 30) and (missionCost > 24) and db.profile.animaCosts[acCategory]["25-29"] ) or
                          ( (missionCost < 50) and (missionCost > 29) and db.profile.animaCosts[acCategory]["30-49"] ) or
                          ( (missionCost < 100) and (missionCost > 49) and db.profile.animaCosts[acCategory]["50-99"] ) or 
                          ( (missionCost > 99) and db.profile.animaCosts[acCategory]["100+"] )
                        ) then
                    local _, _, _, _, duration = C_Garrison.GetMissionTimes(mission.missionID)
                    duration = duration/3600
                    
                    -- support really long missions under a 24 hour max setting
                    if duration > 24 then
                        duration = 24
                    end
                    
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
        local newMissions = C_Garrison.GetAvailableMissions(gui.followerTypeID)
        
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
        for _, v in pairs(newMissions) do
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
        return
    end
    
    gui.missionCounter = 0
    gui.missionCounterUpper = table.getn(missions)
    gui.missions = missions

    gui:calculateNextMission()
end

function addon.BaseGUIMixin.InitCalculateButton(gui)
    gui.CalculateButton:SetScript("OnClick", calculateButtonHandler)
end