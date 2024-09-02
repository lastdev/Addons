--------------------------------------------------------------------------------
--[[ achievements.lua - A collection of utilities handling achievements. ]]--
--
-- by erglo <erglo.coder+WAU@gmail.com>
--
-- Copyright (C) 2023-2024  Erwin D. Glockner (aka erglo)
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see http://www.gnu.org/licenses.
--
-- Further reading:
-- ================
-- REF.: <https://www.townlong-yak.com/framexml/live/AchievementUtil.lua>
-- REF.: <https://www.townlong-yak.com/framexml/live/Blizzard_APIDocumentationGenerated/AchievementInfoDocumentation.lua>
-- REF.: <https://wowpedia.fandom.com/wiki/World_of_Warcraft_API#Achievements>
-- REF.: <https://wowpedia.fandom.com/wiki/API_GetAchievementNumCriteria>
-- REF.: <https://wowpedia.fandom.com/wiki/API_GetAchievementCriteriaInfo>
--
-- REF.: <https://www.townlong-yak.com/framexml/live/TableUtil.lua>
-- REF.: <https://wowpedia.fandom.com/wiki/Lua_functions#Table_Functions>
--
-- (see also the function comments section for more)
--
--------------------------------------------------------------------------------

local AddonID, ns = ...

local utils = ns.utils or {}
ns.utils = utils

local LocalAchievementUtil = {}
utils.achieve = LocalAchievementUtil

----- Constants ----------------------------------------------------------------

-- -- Achievements IDs
-- LocalAchievementUtil.achievementIDs = {
-- -- local INVASION_OBLITERATION_ID = 12026  -- Legion Invasion Point Generals
-- -- local DEFENDER_OF_THE_BROKEN_ISLES_ID = 11544
-- -- local FRONTLINE_WARRIOR_ALLIANCE_ASSAULTS_ID = 13283  -- BfA Faction Assaults
-- -- local FRONTLINE_WARRIOR_HORDE_ASSAULTS_ID = 13284  -- BfA Faction Assaults
-- -- local UNITED_FRONT_ID = 15000  -- Shadowlands threat in The Maw 
-- -- local DEAD_MEN_TELL_SOME_TALES_ID = 15647  -- Shadowlands Covenant Campaign

-- -- local DRAGON_RIDING_ACCOUNT_ACHIEVEMENT_ID = 15794
-- 	GLYPH_HUNTER_WAKING_SHORES_ID = 16575,
-- 	GLYPH_HUNTER_OHNAHRAN_PLAINS_ID = 16576,
-- 	GLYPH_HUNTER_AZURE_SPAN_ID = 16577,
-- 	GLYPH_HUNTER_THALDRASZUS_ID = 16578,
-- 	GLYPH_HUNTER_ZARALEK_CAVERN_ID = 18150,
-- }

----- Wrapper ------------------------------------------------------------------

local tInsert = table.insert

local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo
local GetAchievementInfo = GetAchievementInfo
local GetAchievementNumCriteria = GetAchievementNumCriteria
-- local GetAchievementCategory = GetAchievementCategory
-- local GetCategoryInfo = GetCategoryInfo
-- local GetLatestCompletedAchievements = GetLatestCompletedAchievements

-- A key-value wrapper for `GetAchievementInfo`.
---@param achievementID number  The achievement identification number
---@param raw boolean|nil  Return non-wrapped data directly from `GetAchievementInfo` instead
---@return table|nil achievementInfo
--
-- REF.: [Wowpedia - API_GetAchievementInfo](https://wowpedia.fandom.com/wiki/API_GetAchievementInfo)
--
function LocalAchievementUtil.GetWrappedAchievementInfo(achievementID, raw)
	-- Default return values for GetAchievementInfo(): 
	-- 1:achievementID, 2:name, 3:points, 4:completed, 5:month, 6:day, 7:year,
	-- 8:description, 9:flags, 10:icon, 11:rewardText, 12:isGuild,
	-- 13:wasEarnedByMe, 14:earnedBy, 15:isStatistic
	local data = SafePack(GetAchievementInfo(achievementID))
	if not data then return end
	if raw then return SafeUnpack(data) end
	local achievementInfo = {
		achievementID = data[1], ---@type number  The achievement identification number.
		name = data[2], ---@type string  The name of the achievement.
		points = data[3], ---@type number  Points awarded for completing this achievement.
		completed = data[4], ---@type boolean  Returns true/false depending if you've completed this achievement on any character.
		month = data[5], ---@type number  The month this was completed. Returns nil if `completed` is false.
		day = data[6], ---@type number  The day this was completed. Returns nil if `completed` is false.
		year = data[7], ---@type number  The year this was completed. Returns nil if `completed` is false. Returns number of years since 2000.
		description = data[8], ---@type string  The description of the achievement.
		flags = data[9], ---@type number  A bit field that indicates achievement properties.
		icon = data[10], ---@type number  The fileDataID of the icon used for this achievement.
		rewardText = data[11], ---@type string  A text describing the reward you get for completing this achievement.
		isGuild = data[12], ---@type boolean  Returns true/false depending if this is a guild achievement.
		wasEarnedByMe = data[13], ---@type boolean  Returns true/false depending if you've completed this achievement on this character.
		earnedBy = data[14], ---@type string  Your character name if you've completed this achievement, or the name of the first character to complete this achievement.
		isStatistic = data[15], ---@type boolean  Returns true/false depending if this is a statistic.
	}
	return achievementInfo
end

-- A key-value wrapper for `GetAchievementCriteriaInfo`.
---@param achievementID number  The achievement identification number
---@param criteriaIndex number  The position index of the criteria
---@param raw boolean|nil  Return non-wrapped data directly from `GetAchievementCriteriaInfo` instead
---@return table|nil criteriaInfo
--
-- REF.: [Wowpedia - API_GetAchievementCriteriaInfo](https://wowpedia.fandom.com/wiki/API_GetAchievementCriteriaInfo)
--
function LocalAchievementUtil.GetWrappedAchievementCriteriaInfo(achievementID, criteriaIndex, raw)
	-- Default return values for GetAchievementCriteriaInfo():
	-- 1:criteriaString, 2:criteriaType, 3:completed, 4:quantity, 5:reqQuantity, 6:charName,
	-- 7:flags, 8:assetID, 9:quantityString, 10:criteriaID, 11:eligible,
	-- [12:duration], [13:elapsed]
	local data = SafePack(GetAchievementCriteriaInfo(achievementID, criteriaIndex))
	if not data then return end
	if raw then return SafeUnpack(data) end
	local criteriaInfo = {
		criteriaString = data[1], ---@type  string  The name of the criteria.
		criteriaType = data[2], ---@type  number  Criteria type; specifies the meaning of the assetID.
		completed = data[3], ---@type  boolean  True if you've completed this criteria; false otherwise.
		quantity = data[4], ---@type  number  Quantity requirement imposed by some criteriaType.
		reqQuantity = data[5], ---@type  number  The required quantity for the criteria. Used mostly in achievements with progress bars. Usually 0.
		charName = data[6], ---@type  string  The name of the character that completed this achievement.
		flags = data[7], ---@type  number  A bit field that indicates criteria properties.
		assetID = data[8], ---@type  number  Criteria data whose meaning depends on the type.
		quantityString = data[9], ---@type  string  The string used to display the current quantity. Usually the string form of the quantity return.
		criteriaID = data[10], ---@type  number  Unique criteria ID.
		eligible = data[11], ---@type  boolean  True if the criteria is eligible to be completed; false otherwise. Used to determine whether to show the criteria line in the objectives tracker in red or not.
		duration = data[12], ---@type  number
		elapsed = data[13], ---@type  number
	}

	return criteriaInfo
end

-- Retrieve the total and optionally the completed criteria number for given achievement.
---@param achievementID number  The achievement identification number
---@param includeCompleted boolean|nil  Whether to include the number of completed criteria
---@return number numCriteria
---@return number|nil numCompleted
--
-- REF.: [Wowpedia - API_GetAchievementNumCriteria](https://wowpedia.fandom.com/wiki/API_GetAchievementNumCriteria)
--
function LocalAchievementUtil.GetWrappedAchievementNumCriteria(achievementID, includeCompleted)
	local numCriteria = GetAchievementNumCriteria(achievementID)
	if not includeCompleted then return numCriteria end
	-- Filter criteriaType 														--> TODO - Add filter criteria ???
	-- local criteriaTypeMap = {
	-- 	["killNPC"] = 0,  --> assetID == creatureID
	-- 	["questType"] = 27,	--> assetID == questID
	-- 	["factionType"] = 46, --> assetID == factionID 
	-- }
	-- Count completed criteria
	local numCompleted = 0
	for criteriaIndex=1, numCriteria do
		local criteriaInfo = LocalAchievementUtil.GetWrappedAchievementCriteriaInfo(achievementID, criteriaIndex)
		if (criteriaInfo and criteriaInfo.completed) then
			numCompleted = numCompleted + 1
		end
	end

	return numCriteria, numCompleted
end

-- Generate an achievement hyperlink with an icon in front of it for given wrapped achievement.
---@param achievementInfo any
---@return string achievementLink
--
-- REF.: [Wowpedia - API_GetAchievementLink](https://wowpedia.fandom.com/wiki/API_GetAchievementLink)<br>
-- REF.: [WoWWiki - UI_escape_sequences#Links](https://wowwiki-archive.fandom.com/wiki/UI_escape_sequences#Links)
--
function LocalAchievementUtil.GetAchievementLinkWithIcon(achievementInfo)
	local ACHIEVEMENT_NAME_FORMAT = "|T%d:16:16:0:0|t %s"
    local hyperLink = GetAchievementLink(achievementInfo.achievementID)
    return ACHIEVEMENT_NAME_FORMAT:format(achievementInfo.icon, hyperLink)
end

----- Conditions ---------------------------------------------------------------

-- Check whether given achievement has been completed.
---@param achievementID number  The achievement identification number
---@return boolean isCompleted
--
function LocalAchievementUtil.IsAchievementCompleted(achievementID)
	-- Default return values (index:name) for GetAchievementInfo(): 
	-- 1:id, 2:name, 3:points, 4:completed, 5:month, 6:day, 7:year,
	-- 8:description, 9:flags, 10:icon, 11:rewardText, 12:isGuild,
	-- 13:wasEarnedByMe, 14:earnedBy, 15:isStatistic
	return select(4, GetAchievementInfo(achievementID))
end

-- Check if the criteria of given asset has been completed for given achievement.
---@param achievementID number  The achievement identification number
---@param assetID number  Criteria data whose meaning depends on the criteriaType
---@return boolean isCompleted 
--
function LocalAchievementUtil.IsAssetCriteriaCompleted(achievementID, assetID)
	local numCriteria = GetAchievementNumCriteria(achievementID)
	for criteriaIndex=1, numCriteria do
		local criteriaInfo = LocalAchievementUtil.GetWrappedAchievementCriteriaInfo(achievementID, criteriaIndex)
		-- The assetID can be anything depending on the criteriaType, eg. a creatureID, questID, etc.
		if (criteriaInfo and criteriaInfo.assetID == assetID) then
			return criteriaInfo.completed
		end
	end
	return false
end

----- Data ---------------------------------------------------------------------

-- Retrieve all wrapped criteriaInfo for given achievement.
---@param achievementID number  The achievement identification number
---@return table criteriaInfoList
--
function LocalAchievementUtil.GetAchievementCriteriaInfoList(achievementID)
	local criteriaInfoList = {}
	local numCriteria = GetAchievementNumCriteria(achievementID)
	for criteriaIndex=1, numCriteria do
		local criteriaInfo = LocalAchievementUtil.GetWrappedAchievementCriteriaInfo(achievementID, criteriaIndex)
		tInsert(criteriaInfoList, criteriaInfo)
	end
	return criteriaInfoList
end

----- Categories -----

-- Retrieve a list of wrapped categoryInfo of the main achievement categories.
---@return table mainCategoryInfoList
--
-- REF.: [WarCraft.wiki.gg - API_GetCategoryList](https://warcraft.wiki.gg/wiki/API_GetCategoryList)<br>
-- REF.: [WarCraft.wiki.gg - API_GetCategoryInfo](https://warcraft.wiki.gg/wiki/API_GetCategoryInfo)
--
function LocalAchievementUtil.GetMainCategoryInfoList()
	local categoryIDs = GetCategoryList()
	local mainCategoryInfoList = {}

	for i, cID in ipairs(categoryIDs) do
		local cName, cParentID, cFlags = GetCategoryInfo(cID)
		if (cParentID == -1) then
			local categoryInfo = {
				categoryIndex = i,  ---@type number  The index number from `GetCategoryList()`.
				categoryID = cID,   ---@type number  The category identification number.
				categoryName = cName,  ---@type string  The name of the category.
				parentCategoryID = cParentID,  ---@type number  The identification number of the category's parent.
				flags = cFlags,   ---@type number  The category flags.
			}
			tInsert(mainCategoryInfoList, categoryInfo)
		end
	end

	return mainCategoryInfoList
end
