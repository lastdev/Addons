local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local MVC = LibStub("LibMVC-1.0")
local Columns = MVC:GetService("AltoholicUI.TabSummaryColumns")
local Formatter = MVC:GetService("AltoholicUI.Formatter")

-- *** Utility functions ***

-- ** Keystones **
Columns.RegisterColumn("KeyName", {
	-- Header
	headerWidth = 180,
	headerLabel = format("%s  %s", Formatter.Texture18("Interface\\Icons\\inv_relics_hourglass"), L["COLUMN_KEYNAME_TITLE_SHORT"]),
	tooltipTitle = L["COLUMN_KEYNAME_TITLE"],
	tooltipSubTitle = L["COLUMN_KEYNAME_SUBTITLE"],
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("KeyName") end,
	headerSort = DataStore.GetKeystoneName,
	
	-- Content
	Width = 180,
	JustifyH = "CENTER",
	GetText = function(character) 
		return Formatter.GreyIfEmpty(DataStore:GetKeystoneName(character))
	end,
})

Columns.RegisterColumn("KeyLevel", {
	-- Header
	headerWidth = 60,
	headerLabel = L["COLUMN_LEVEL_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_KEYLEVEL_TITLE"],
	tooltipSubTitle = L["COLUMN_KEYLEVEL_SUBTITLE"],
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("KeyLevel") end,
	headerSort = DataStore.GetKeystoneLevel,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character) 
		local level = DataStore:GetKeystoneLevel(character) or 0
		local color = (level == 0) and colors.grey or colors.yellow
	
		return format("%s%d", color, level)	
	end,
})

Columns.RegisterColumn("DungeonScore", {
	-- Header
	headerWidth = 120,
	headerLabel = DUNGEON_SCORE,
	tooltipTitle = DUNGEON_SCORE,
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("DungeonScore") end,
	headerSort = DataStore.GetDungeonScore,
	
	-- Content
	Width = 120,
	JustifyH = "CENTER",
	GetText = function(character) 
		local level = DataStore:GetDungeonScore(character) or 0
		local color = (level == 0) and colors.grey or colors.yellow
	
		return format("%s%d", color, level)	
	end,
})

Columns.RegisterColumn("WeeklyBestKeyName", {
	-- Header
	headerWidth = 110,
	headerLabel = format("%s  %s", Formatter.Texture18("Interface\\Icons\\achievement_challengemode_gold"), CHALLENGE_MODE_WEEKLY_BEST),
	tooltipTitle = L["COLUMN_WEEKLYBEST_KEYNAME_TITLE"],
	tooltipSubTitle = L["COLUMN_WEEKLYBEST_KEYNAME_SUBTITLE"],
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("WeeklyBestKeyName") end,
	headerSort = DataStore.GetWeeklyBestKeystoneName,
	
	-- Content
	Width = 110,
	JustifyH = "CENTER",
	GetText = function(character) 
		return Formatter.GreyIfEmpty(DataStore:GetWeeklyBestKeystoneName(character))
	end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Stats", character) then
				return
			end
			
			local level = DataStore:GetWeeklyBestKeystoneLevel(character) or 0
			if level == 0 then return end
			
			local tt = AddonFactory_Tooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), CHALLENGE_MODE_WEEKLY_BEST)
			tt:AddLine(" ")
			
			for _, map in pairs(DataStore:GetWeeklyBestMaps(character)) do
				tt:AddDoubleLine(format("%s %s %s+%d", Formatter.Texture18(map.texture), map.name, colors.green, map.level), Formatter.Duration(map.timeInSeconds))
			end

			tt:Show()
		end,	
})

Columns.RegisterColumn("WeeklyBestKeyLevel", {
	-- Header
	headerWidth = 60,
	headerLabel = L["COLUMN_LEVEL_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_WEEKLYBEST_KEYLEVEL_TITLE"],
	tooltipSubTitle = L["COLUMN_WEEKLYBEST_KEYLEVEL_SUBTITLE"],
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("WeeklyBestKeyLevel") end,
	headerSort = DataStore.GetWeeklyBestKeystoneLevel,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character) 
		local level = DataStore:GetWeeklyBestKeystoneLevel(character) or 0
		local color = (level == 0) and colors.grey or colors.yellow
	
		return format("%s%d", color, level)	
	end,
})

Columns.RegisterColumn("WeeklyBestKeyTime", {
	-- Header
	headerWidth = 90,
	headerLabel = format("%s  %s", Formatter.Texture18("Interface\\Icons\\spell_holy_borrowedtime"), BEST),
	tooltipTitle = L["COLUMN_WEEKLYBEST_KEYTIME_TITLE"],
	tooltipSubTitle = L["COLUMN_WEEKLYBEST_KEYTIME_SUBTITLE"],
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("WeeklyBestKeyTime") end,
	headerSort = DataStore.GetWeeklyBestKeystoneTime,

	-- Content
	Width = 90,
	JustifyH = "CENTER",
	GetText = function(character) 
		local seconds = DataStore:GetWeeklyBestKeystoneTime(character) or 0
		return Formatter.Duration(seconds)
	end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Stats", character) then
				return
			end
			
			local level = DataStore:GetWeeklyBestKeystoneLevel(character) or 0
			if level == 0 then return end
			
			local tt = AddonFactory_Tooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), MYTHIC_PLUS_SEASON_BEST)
			tt:AddLine(" ")
			
			for _, map in pairs(DataStore:GetSeasonBestMaps(character)) do
				tt:AddDoubleLine(format("%s %s %s+%d", Formatter.Texture18(map.texture), map.name, colors.green, map.level), Formatter.Duration(map.timeInSeconds))
			end
			
			
			local maps = DataStore:GetSeasonBestMapsOvertime(character)

			if DataStore:GetHashSize(maps) > 0 then
				tt:AddLine(" ")
				tt:AddLine(MYTHIC_PLUS_OVERTIME_SEASON_BEST, 1, 1, 1)
				tt:AddLine(" ")
			
				for _, map in pairs(maps) do
					tt:AddDoubleLine(format("%s %s %s+%d", Formatter.Texture18(map.texture), map.name, colors.green, map.level), Formatter.Duration(map.timeInSeconds))
				end			
			end

			tt:Show()
		end,	
})


-- ** Weekly Rewards **

Columns.RegisterColumn("RewardMythic", {
	-- Header
	headerWidth = 120,
	headerLabel = CHALLENGES,
	tooltipTitle = CHALLENGES,
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("RewardMythic") end,
	headerSort = DataStore.GetWeeklyMythicPlusReward,
	
	-- Content
	Width = 120,
	JustifyH = "CENTER",
	GetText = function(character) 
		local level = DataStore:GetWeeklyMythicPlusReward(character) or 0
		local color = (level == 0) and colors.grey or colors.white
		
		return format("%s%s%s/%s%s", color, level, colors.white, colors.yellow, 8)
	end,
})

Columns.RegisterColumn("RewardRaid", {
	-- Header
	headerWidth = 80,
	headerLabel = RAIDS,
	tooltipTitle = RAIDS,
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("RewardRaid") end,
	headerSort = DataStore.GetWeeklyRaidReward,
	
	-- Content
	Width = 80,
	JustifyH = "CENTER",
	GetText = function(character) 
		local level = DataStore:GetWeeklyRaidReward(character) or 0
		local color = (level == 0) and colors.grey or colors.white
		
		return format("%s%s%s/%s%s", color, level, colors.white, colors.yellow, 8)
	end,
})

Columns.RegisterColumn("RewardPvP", {
	-- Header
	headerWidth = 120,
	headerLabel = PLAYER_V_PLAYER,
	tooltipTitle = PLAYER_V_PLAYER,
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("RewardPvP") end,
	headerSort = DataStore.GetWeeklyRankedPvPReward,
	
	-- Content
	Width = 120,
	JustifyH = "CENTER",
	GetText = function(character) 
		local level = DataStore:GetWeeklyRankedPvPReward(character) or 0
		local color = (level == 0) and colors.grey or colors.white
		
		return format("%s%s%s/%s%s", color, level, colors.white, colors.yellow, 5500)
	end,
})
