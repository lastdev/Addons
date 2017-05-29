local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local view = {}

local modes = {
	[1] = {	-- available missions
		GetName = function() return GARRISON_LANDING_AVAILABLE end,
		GetMissions = function(c) return DataStore:GetAvailableMissions(c, LE_FOLLOWER_TYPE_GARRISON_6_0) end,
		GetNumMissions = function(c) return DataStore:GetNumAvailableMissions(c, LE_FOLLOWER_TYPE_GARRISON_6_0) end,
	},
	[2] = {	-- active missions
		GetName = function() return GARRISON_LANDING_IN_PROGRESS end,
		GetMissions = function(c) return DataStore:GetActiveMissions(c, LE_FOLLOWER_TYPE_GARRISON_6_0) end,
		GetNumMissions = function(c) return DataStore:GetNumActiveMissions(c, LE_FOLLOWER_TYPE_GARRISON_6_0) end,
	},
	[3] = {	-- available missions
		GetName = function() return GARRISON_LANDING_AVAILABLE end,
		GetMissions = function(c) return DataStore:GetAvailableMissions(c, LE_FOLLOWER_TYPE_GARRISON_7_0) end,
		GetNumMissions = function(c) return DataStore:GetNumAvailableMissions(c, LE_FOLLOWER_TYPE_GARRISON_7_0) end,
	},
	[4] = {	-- active missions
		GetName = function() return GARRISON_LANDING_IN_PROGRESS end,
		GetMissions = function(c) return DataStore:GetActiveMissions(c, LE_FOLLOWER_TYPE_GARRISON_7_0) end,
		GetNumMissions = function(c) return DataStore:GetNumActiveMissions(c, LE_FOLLOWER_TYPE_GARRISON_7_0) end,
	},
}

local function BuildView()
	wipe(view)

	local character = addon.Tabs.Characters:GetAltKey()
	local mode = addon:GetOption("UI.Tabs.Characters.GarrisonMissions")

	local api = modes[mode]
	local missions = api.GetMissions(character)
	if not missions then return end
	
	for _, id in pairs(missions) do
		table.insert(view, id)
	end
	
	if mode == 2 or mode == 4 then
		table.sort(view, function(a,b) 
				local remainingA = select(2, DataStore:GetActiveMissionInfo(character, a)) or 0
				local remainingB = select(2, DataStore:GetActiveMissionInfo(character, b)) or 0
				return remainingA < remainingB
			end)
	end
end

local function OnGarrisonMissionListUpdate()
	if AltoholicFrameGarrisonMissions:IsVisible() then
		AltoholicFrameGarrisonMissions:Update()
	end
end

local function _Init(frame)
	addon:RegisterEvent("GARRISON_MISSION_LIST_UPDATE", OnGarrisonMissionListUpdate)
end

local function _Update(frame)

	local character = addon.Tabs.Characters:GetAltKey()
	local mode = addon:GetOption("UI.Tabs.Characters.GarrisonMissions")
	local api = modes[mode]
	
	AltoholicTabCharacters.Status:SetText(format("%s|r / %s", DataStore:GetColoredCharacterName(character),
		format(api.GetName(), api.GetNumMissions(character))))

	BuildView()

	local scrollFrame = frame.ScrollFrame
	local numRows = scrollFrame.numRows
	local offset = scrollFrame:GetOffset()
	
	for rowIndex = 1, numRows do
		local rowFrame = scrollFrame:GetRow(rowIndex)
		local line = rowIndex + offset
	
		rowFrame:Hide()
		
		if line <= #view then
			local missionID = view[line]
			local info = DataStore:GetMissionInfo(missionID)
			local followers, remainingTime, successChance = DataStore:GetActiveMissionInfo(character, missionID)
			
			rowFrame:SetName(missionID, info.durationSeconds)
			rowFrame:SetType(info.typeAtlas)
			rowFrame:SetLevel(info.level, info.iLevel)
			rowFrame:SetRemainingTime(remainingTime)
			rowFrame:SetSuccessChance(successChance)
			rowFrame:SetCost(info.cost)
			rowFrame:SetFollowers(followers, missionID, character)
			rowFrame:SetRewards(info.rewards)
			rowFrame:Show()
		end
	end
	
	scrollFrame:Update(#view)
	frame:Show()
end

addon:RegisterClassExtensions("AltoGarrisonMissionsPanel", {
	Init = _Init,
	Update = _Update,
})
