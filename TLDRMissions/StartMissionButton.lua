local addonName, addon = ...
local LibStub = addon.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale("TLDRMissions")

local function startMissionButtonHandler(self)
    self:SetEnabled(false)
    local gui = self:GetParent():GetParent()
    
    local missionWaitingUserAcceptance = gui.missionWaitingUserAcceptance
    
    if not missionWaitingUserAcceptance then
        print("Error: mission awaiting user acceptance not found")
        return
    end
    
    local missions = C_Garrison.GetAvailableMissions(gui.followerTypeID)
    do
        local found = false
        for _, mission in pairs(missions) do
            if mission.missionID == missionWaitingUserAcceptance.missionID then
                found = true
                break
            end
        end
        if not found then
            if gui:hasNextMission() then
                gui:calculateNextMission()
            end
            return
        end
    end
    
    local animaCost = C_Garrison.GetMissionCost(missionWaitingUserAcceptance.missionID)
    local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(gui.RESOURCE_CURRENCY_ID)
	local amountOwned = currencyInfo.quantity;
	if (amountOwned < animaCost) then
		gui:clearReportText(true)
        gui.FailedCalcLabel:SetText(L["NotEnoughAnimaError"])
        gui.SkipMissionButton:SetEnabled(true)
        self:SetEnabled(true)
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
            gui.numSent = gui.numSent + 1
        end)
    end
end

function addon.BaseGUIMixin:InitStartMissionButton()
    self.StartMissionButton:SetScript("OnClick", startMissionButtonHandler)
    
    RunNextFrame(function()
        hooksecurefunc(addon, "garrisonMissionStartedHandler", function(_, garrFollowerTypeID, missionID)
            if garrFollowerTypeID ~= self.followerTypeID then return end
            if not self.missionWaitingUserAcceptance then return end
            if missionID ~= self.missionWaitingUserAcceptance.missionID then
                print("Error: The server sent back confirmation for a different mission")
            end
            
            self:clearReportText(true)
            self:setNextMissionText()
            self.missionWaitingUserAcceptance = nil
            
            if self:hasNextMission() then
                self:calculateNextMission()
            else
                self.EstimateLabel:SetText()
                self:clearReportText(true)
                if self.numSkipped > 0 then
                    local numFollowersAvailable = 0
                    for _, follower in pairs(C_Garrison.GetFollowers(self.followerTypeID)) do
                        if (not follower.status) and (follower.isCollected) then
                            numFollowersAvailable = numFollowersAvailable + 1
                        end
                    end
                    self.FailedCalcLabel:SetText(L["MissionsSentPartial"]:format(self.numSent, self.numSkipped, self.numFailed, numFollowersAvailable))
                else
                    self.NextMissionLabel:SetText(L["MissonsSentSuccess"])
                end
                self.CalculateButton:SetEnabled(true)
            end
        end)
    end)
end