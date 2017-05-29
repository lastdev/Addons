local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local function _SetName(frame, missionID, duration)
	frame.Name:SetText(format("%s%s |r(%s)", colors.white, C_Garrison.GetMissionName(missionID), SecondsToTime(duration)))
end

local function _SetType(frame, missionType)
	local icon = frame.MissionType.Icon

	if missionType then
		icon:Show()
		icon:SetAtlas(missionType)
	else
		icon:Hide()
	end
end

local function _SetLevel(frame, level, iLevel)
	local color = colors.white
	
	if iLevel ~= 0 then
		level = iLevel
		
		if iLevel >= 700 then
			color = colors.yellow
		elseif iLevel >= 645 then
			color = colors.epic
		elseif iLevel >= 630 then
			color = colors.rare
		elseif iLevel >= 615 then
			color = colors.green
		end
	end
	
	local count = frame.MissionType.Count
	
	count:SetText(format("%s%s", color, level))
	count:Show()
end

local function _SetCost(frame, cost)
	if cost and cost > 0 then
		frame.CostIcon:Show()
		frame.Cost:SetText(cost)
		frame.Cost:Show()
	else
		frame.CostIcon:Hide()
		frame.Cost:SetText("")
		frame.Cost:Hide()
	end
end

local function _SetSuccessChance(frame, successChance)
	if not successChance then
		frame.Success:Hide()
		return
	end
	
	local color
	if successChance >= 75 then
		color = colors.green
	elseif successChance >= 50 then
		color = colors.yellow
	else
		color = colors.red
	end
	frame.Success:SetText(format("%s%s%%", color, successChance))
	frame.Success:Show()
end

local function _SetRemainingTime(frame, remainingTime)
	if not remainingTime then
		frame.Remaining:Hide()
		return
	end
	
	if remainingTime == 0 then
		frame.Remaining:SetText(format("%s%s", colors.green, GARRISON_MISSION_COMPLETE))
	else
		frame.Remaining:SetText(SecondsToTime(remainingTime, true))
	end
	frame.Remaining:Show()
end

local function _SetFollowers(frame, followers, missionID, character)
	frame.Follower1:Hide()
	frame.Follower2:Hide()
	frame.Follower3:Hide()

	-- 'followers' could be nil for the list of available missions
	-- nevertheless, we want to show empty portraits
	local numFollowers = C_Garrison.GetMissionMaxFollowers(missionID)

	for i = 1, numFollowers do
		local followerFrame = frame["Follower"..i]
		
		if followers then
			local followerID = followers[i]
		
			followerFrame:SetPortrait(followerID)
			followerFrame:SetInfo(character, followerID)
		else
			followerFrame:SetPortrait()
			followerFrame:SetInfo()
		end
		followerFrame:Show()
	end
end

local function _SetRewards(frame, rewards)
	frame.Reward1:Hide()
	frame.Reward2:Hide()
	
	local index = 2
	for id, reward in pairs(rewards) do
		local button = frame["Reward" ..index]
		button:SetReward(reward)
		index = index - 1
	end
end

addon:RegisterClassExtensions("AltoGarrisonMissionRow", {
	SetName = _SetName,
	SetType = _SetType,
	SetLevel = _SetLevel,
	SetCost = _SetCost,
	SetSuccessChance = _SetSuccessChance,
	SetRemainingTime = _SetRemainingTime,
	SetFollowers = _SetFollowers,
	SetRewards = _SetRewards,
})
