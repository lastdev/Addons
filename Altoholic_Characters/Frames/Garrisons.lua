local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local view = {}

local modes = {
	[1] = {	-- available missions
		GetName = function() return GARRISON_LANDING_AVAILABLE end,
		GetMissions = function(c) return DataStore:GetAvailableMissions(c, Enum.GarrisonFollowerType.FollowerType_6_0) end,
		GetNumMissions = function(c) return DataStore:GetNumAvailableMissions(c, Enum.GarrisonFollowerType.FollowerType_6_0) end,
	},
	[2] = {	-- active missions
		GetName = function() return GARRISON_LANDING_IN_PROGRESS end,
		GetMissions = function(c) return DataStore:GetActiveMissions(c, Enum.GarrisonFollowerType.FollowerType_6_0) end,
		GetNumMissions = function(c) return DataStore:GetNumActiveMissions(c, Enum.GarrisonFollowerType.FollowerType_6_0) end,
	},
	[3] = {	-- available missions
		GetName = function() return GARRISON_LANDING_AVAILABLE end,
		GetMissions = function(c) return DataStore:GetAvailableMissions(c, Enum.GarrisonFollowerType.FollowerType_7_0) end,
		GetNumMissions = function(c) return DataStore:GetNumAvailableMissions(c, Enum.GarrisonFollowerType.FollowerType_7_0) end,
	},
	[4] = {	-- active missions
		GetName = function() return GARRISON_LANDING_IN_PROGRESS end,
		GetMissions = function(c) return DataStore:GetActiveMissions(c, Enum.GarrisonFollowerType.FollowerType_7_0) end,
		GetNumMissions = function(c) return DataStore:GetNumActiveMissions(c, Enum.GarrisonFollowerType.FollowerType_7_0) end,
	},
	[5] = {	-- available missions
		GetName = function() return GARRISON_LANDING_AVAILABLE end,
		GetMissions = function(c) return DataStore:GetAvailableMissions(c, Enum.GarrisonFollowerType.FollowerType_8_0) end,
		GetNumMissions = function(c) return DataStore:GetNumAvailableMissions(c, Enum.GarrisonFollowerType.FollowerType_8_0) end,
	},
	[6] = {	-- active missions
		GetName = function() return GARRISON_LANDING_IN_PROGRESS end,
		GetMissions = function(c) return DataStore:GetActiveMissions(c, Enum.GarrisonFollowerType.FollowerType_8_0) end,
		GetNumMissions = function(c) return DataStore:GetNumActiveMissions(c, Enum.GarrisonFollowerType.FollowerType_8_0) end,
	},
    [7] = {	-- available missions
		GetName = function() return GARRISON_LANDING_AVAILABLE end,
		GetMissions = function(c) return DataStore:GetAvailableMissions(c, Enum.GarrisonFollowerType.FollowerType_9_0) end,
		GetNumMissions = function(c) return DataStore:GetNumAvailableMissions(c, Enum.GarrisonFollowerType.FollowerType_9_0) end,
	},
	[8] = {	-- active missions
		GetName = function() return GARRISON_LANDING_IN_PROGRESS end,
		GetMissions = function(c) return DataStore:GetActiveMissions(c, Enum.GarrisonFollowerType.FollowerType_9_0) end,
		GetNumMissions = function(c) return DataStore:GetNumActiveMissions(c, Enum.GarrisonFollowerType.FollowerType_9_0) end,
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
	
	if mode == 2 or mode == 4 or mode == 6 then
		table.sort(view, function(a,b) 
				local remainingA = select(2, DataStore:GetActiveMissionInfo(character, a)) or 0
				local remainingB = select(2, DataStore:GetActiveMissionInfo(character, b)) or 0
				return remainingA < remainingB
			end)
	end
end

local ns = {}
function ns:Update(frame)
    frame = frame or AltoholicFrameGarrisonMissions
	local character = addon.Tabs.Characters:GetAltKey()
	local mode = addon:GetOption("UI.Tabs.Characters.GarrisonMissions")
	local api = modes[mode]
	
	if AltoholicFrameGarrisonMissions:IsVisible() then
        AltoholicTabCharacters.Status:SetText(format("%s|r / %s", DataStore:GetColoredCharacterName(character),
		  format(api.GetName(), api.GetNumMissions(character))))
    end

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
              if info then
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
	end
      
      for rowIndex = numRows, 18 do
          scrollFrame:GetRow(rowIndex):Hide()
      end
	
	scrollFrame:Update(#view)
end

addon:Controller("AltoholicUI.GarrisonMissionsPanel", {
	OnBind = function(frame)
		local function OnGarrisonMissionListUpdate()
			if frame:IsVisible() then
				frame:Update()
			end
		end
	
		addon:RegisterEvent("GARRISON_MISSION_LIST_UPDATE", OnGarrisonMissionListUpdate)
        AltoholicFrame:RegisterResizeEvent("AltoholicFrameGarrisonMissions", 8, ns)
	end,
	Update = function(frame)
        ns:Update(frame)
        frame:Show()
	end,
})

