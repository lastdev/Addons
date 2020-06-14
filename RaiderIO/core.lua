local addonName, ns = ...

-- if we're on the developer version the addon behaves slightly different
ns.DEBUG_MODE = not not (GetAddOnMetadata(addonName, "Version") or ""):find("v202006060600", nil, true)

-- micro-optimization for more speed
local unpack = unpack
local sort = table.sort
local wipe = table.wipe
local floor = math.floor
local min = math.min
local max = math.max
local lshift = bit.lshift
local rshift = bit.rshift
local band = bit.band
local bor = bit.bor
local bxor = bit.bxor
local strbyte = string.byte
local LOOKUP_MAX_SIZE = floor(2^18-1)
local CONST_COMPLETED_FROM_ACHIEVEMENT_VALUE = 63

-- session
local uiHooks = {}
local profileCache = {}
local profileCacheTooltip = {}
local dataProviderQueue = {}
local dataProvider

-- player
local PLAYER_FACTION
local PLAYER_REGION

-- db outdated
local DB_OUTDATED = {}
local OUTDATED_DAYS = {}
local OUTDATED_HOURS = {}
local INVALID_DATA_MESSAGE_SENT = false

-- constants
local CONST_REALM_SLUGS = ns.realmSlugs
local CONST_REGION_IDS = ns.regionIDs
local CONST_SCORE_TIER = ns.scoreTiers
local CONST_SCORE_TIER_SIMPLE = ns.scoreTiersSimple
local CONST_PREVIOUS_SCORE_TIER = ns.previousScoreTiers or ns.scoreTiers
local CONST_PREVIOUS_SCORE_TIER_SIMPLE = ns.previousScoreTiersSimple or ns.scoreTiersSimple
local CONST_DUNGEONS = ns.dungeons
local CONST_AVERAGE_SCORE = ns.scoreLevelStats
local L = ns.L

-- data provider data types
local CONST_PROVIDER_DATA_MYTHICPLUS = 1
local CONST_PROVIDER_DATA_RAIDING = 2
local CONST_PROVIDER_DATA_LIST = { CONST_PROVIDER_DATA_MYTHICPLUS, CONST_PROVIDER_DATA_RAIDING }
local CONST_PROVIDER_INTERFACE = { MYTHICPLUS = CONST_PROVIDER_DATA_MYTHICPLUS, RAIDING = CONST_PROVIDER_DATA_RAIDING }
local CONST_PROVIDER_DATA_FIELDS_PER_CHARACTER = {
	24,	-- Mythic Plus
	2		-- Raiding
}

-- we size the buckets so that we never have to worry about data overlapping multiple buckets
local CONST_PROVIDER_DATA_BUCKET_MAX_SIZE = {
	floor(LOOKUP_MAX_SIZE / CONST_PROVIDER_DATA_FIELDS_PER_CHARACTER[CONST_PROVIDER_DATA_MYTHICPLUS]) * CONST_PROVIDER_DATA_FIELDS_PER_CHARACTER[CONST_PROVIDER_DATA_MYTHICPLUS],
	floor(LOOKUP_MAX_SIZE / CONST_PROVIDER_DATA_FIELDS_PER_CHARACTER[CONST_PROVIDER_DATA_RAIDING]) * CONST_PROVIDER_DATA_FIELDS_PER_CHARACTER[CONST_PROVIDER_DATA_RAIDING],
}

-- output flags used to shape the table returned by the data provider
local ProfileOutput = {
	INVALID_FLAG 		= 0x000000,
	INCLUDE_LOWBIES 	= 0x000001,
	MOD_KEY_DOWN 		= 0x000002,
	MOD_KEY_DOWN_STICKY = 0x000004,
	MYTHICPLUS 			= 0x000008,
	RAIDING 			= 0x000010,
	TOOLTIP 			= 0x000020,
	PROFILE 			= 0x000040, -- indicates data is going to be shown as part of "My Profile" window
	ADD_PADDING 		= 0x000080,
	ADD_NAME 			= 0x000100,
	ADD_FOOTER 			= 0x000200,
	ADD_HEADER 			= 0x000400,

	-- these makes the tooltip not cache the output for dynamic purposes
	ADD_LFD 			= 0x000800,
	FOCUS_DUNGEON 		= 0x001000,
	FOCUS_KEYSTONE 		= 0x002000,
}

-- default no-tooltip and default tooltip flags used as baseline in several places
ProfileOutput.DATA = bor(ProfileOutput.MYTHICPLUS, ProfileOutput.RAIDING)
ProfileOutput.DEFAULT = bor(ProfileOutput.DATA, ProfileOutput.TOOLTIP)

-- dynamic tooltip flags for specific uses
local TooltipProfileOutput = {
	DEFAULT = ProfileOutput.DEFAULT,
	PADDING = bor(ProfileOutput.DEFAULT, ProfileOutput.ADD_PADDING),
	NAME = bor(ProfileOutput.DEFAULT, ProfileOutput.ADD_NAME),
}

-- modes for what is placed in the headline of mythic plus tooltips
local MythicPlusHeadlineModes = {
	CURRENT_SEASON = 0,
	BEST_SEASON = 1,
	BEST_RUN = 2
}

local ROLE_ICONS = {
	dps = {
		full = "|TInterface\\AddOns\\RaiderIO\\icons\\roles:14:14:0:0:64:64:0:18:0:18|t",
		partial = "|TInterface\\AddOns\\RaiderIO\\icons\\roles:14:14:0:0:64:64:0:18:36:54|t"
	},
	healer = {
		full = "|TInterface\\AddOns\\RaiderIO\\icons\\roles:14:14:0:0:64:64:19:37:0:18|t",
		partial = "|TInterface\\AddOns\\RaiderIO\\icons\\roles:14:14:0:0:64:64:19:37:36:54|t"
	},
	tank = {
		full = "|TInterface\\AddOns\\RaiderIO\\icons\\roles:14:14:0:0:64:64:38:56:0:18|t",
		partial	= "|TInterface\\AddOns\\RaiderIO\\icons\\roles:14:14:0:0:64:64:38:56:36:54|t"
	}
}

-- look up the tuple of ordinals in this table and store that index to indicate the order
-- in which to show roles in addon allowing us to store just 5 bits for all the role ordinals vs 6 bits.
local ORDERED_ROLES = {
	{ },
	{ {"dps","full"}, },
	{ {"dps","full"}, {"healer","full"}, },
	{ {"dps","full"}, {"healer","full"}, {"tank","full"}, },
	{ {"dps","full"}, {"healer","full"}, {"tank","partial"}, },
	{ {"dps","full"}, {"healer","partial"}, },
	{ {"dps","full"}, {"healer","partial"}, {"tank","full"}, },
	{ {"dps","full"}, {"healer","partial"}, {"tank","partial"}, },
	{ {"dps","full"}, {"tank","full"}, },
	{ {"dps","full"}, {"tank","full"}, {"healer","full"}, },
	{ {"dps","full"}, {"tank","full"}, {"healer","partial"}, },
	{ {"dps","full"}, {"tank","partial"}, },
	{ {"dps","full"}, {"tank","partial"}, {"healer","full"}, },
	{ {"dps","full"}, {"tank","partial"}, {"healer","partial"}, },
	{ {"dps","partial"}, },
	{ {"dps","partial"}, {"healer","full"}, },
	{ {"dps","partial"}, {"healer","full"}, {"tank","full"}, },
	{ {"dps","partial"}, {"healer","full"}, {"tank","partial"}, },
	{ {"dps","partial"}, {"healer","partial"}, },
	{ {"dps","partial"}, {"healer","partial"}, {"tank","full"}, },
	{ {"dps","partial"}, {"healer","partial"}, {"tank","partial"}, },
	{ {"dps","partial"}, {"tank","full"}, },
	{ {"dps","partial"}, {"tank","full"}, {"healer","full"}, },
	{ {"dps","partial"}, {"tank","full"}, {"healer","partial"}, },
	{ {"dps","partial"}, {"tank","partial"}, },
	{ {"dps","partial"}, {"tank","partial"}, {"healer","full"}, },
	{ {"dps","partial"}, {"tank","partial"}, {"healer","partial"}, },
	{ {"healer","full"}, },
	{ {"healer","full"}, {"dps","full"}, },
	{ {"healer","full"}, {"dps","full"}, {"tank","full"}, },
	{ {"healer","full"}, {"dps","full"}, {"tank","partial"}, },
	{ {"healer","full"}, {"dps","partial"}, },
	{ {"healer","full"}, {"dps","partial"}, {"tank","full"}, },
	{ {"healer","full"}, {"dps","partial"}, {"tank","partial"}, },
	{ {"healer","full"}, {"tank","full"}, },
	{ {"healer","full"}, {"tank","full"}, {"dps","full"}, },
	{ {"healer","full"}, {"tank","full"}, {"dps","partial"}, },
	{ {"healer","full"}, {"tank","partial"}, },
	{ {"healer","full"}, {"tank","partial"}, {"dps","full"}, },
	{ {"healer","full"}, {"tank","partial"}, {"dps","partial"}, },
	{ {"healer","partial"}, },
	{ {"healer","partial"}, {"dps","full"}, },
	{ {"healer","partial"}, {"dps","full"}, {"tank","full"}, },
	{ {"healer","partial"}, {"dps","full"}, {"tank","partial"}, },
	{ {"healer","partial"}, {"dps","partial"}, },
	{ {"healer","partial"}, {"dps","partial"}, {"tank","full"}, },
	{ {"healer","partial"}, {"dps","partial"}, {"tank","partial"}, },
	{ {"healer","partial"}, {"tank","full"}, },
	{ {"healer","partial"}, {"tank","full"}, {"dps","full"}, },
	{ {"healer","partial"}, {"tank","full"}, {"dps","partial"}, },
	{ {"healer","partial"}, {"tank","partial"}, },
	{ {"healer","partial"}, {"tank","partial"}, {"dps","full"}, },
	{ {"healer","partial"}, {"tank","partial"}, {"dps","partial"}, },
	{ {"tank","full"}, },
	{ {"tank","full"}, {"dps","full"}, },
	{ {"tank","full"}, {"dps","full"}, {"healer","full"}, },
	{ {"tank","full"}, {"dps","full"}, {"healer","partial"}, },
	{ {"tank","full"}, {"dps","partial"}, },
	{ {"tank","full"}, {"dps","partial"}, {"healer","full"}, },
	{ {"tank","full"}, {"dps","partial"}, {"healer","partial"}, },
	{ {"tank","full"}, {"healer","full"}, },
	{ {"tank","full"}, {"healer","full"}, {"dps","full"}, },
	{ {"tank","full"}, {"healer","full"}, {"dps","partial"}, },
	{ {"tank","full"}, {"healer","partial"}, },
	{ {"tank","full"}, {"healer","partial"}, {"dps","full"}, },
	{ {"tank","full"}, {"healer","partial"}, {"dps","partial"}, },
	{ {"tank","partial"}, },
	{ {"tank","partial"}, {"dps","full"}, },
	{ {"tank","partial"}, {"dps","full"}, {"healer","full"}, },
	{ {"tank","partial"}, {"dps","full"}, {"healer","partial"}, },
	{ {"tank","partial"}, {"dps","partial"}, },
	{ {"tank","partial"}, {"dps","partial"}, {"healer","full"}, },
	{ {"tank","partial"}, {"dps","partial"}, {"healer","partial"}, },
	{ {"tank","partial"}, {"healer","full"}, },
	{ {"tank","partial"}, {"healer","full"}, {"dps","full"}, },
	{ {"tank","partial"}, {"healer","full"}, {"dps","partial"}, },
	{ {"tank","partial"}, {"healer","partial"}, },
	{ {"tank","partial"}, {"healer","partial"}, {"dps","full"}, },
	{ {"tank","partial"}, {"healer","partial"}, {"dps","partial"}, },
}

local ENCODER_MYTHICPLUS_FIELDS = {
	CURRENT_SCORE 				= 1, 	-- current season score
	CURRENT_ROLES 				= 2, 	-- current season roles
	PREVIOUS_SCORE 				= 3, 	-- previous season score
	PREVIOUS_ROLES 				= 4, 	-- previous season roles
	MAIN_CURRENT_SCORE 		= 5, 	-- main's current season score
	MAIN_CURRENT_ROLES		= 6, 	-- main's current season roles
	MAIN_PREVIOUS_SCORE 	= 7, 	-- main's previous season score
	MAIN_PREVIOUS_ROLES 	= 8, 	-- main's previous season roles
	DUNGEON_RUN_COUNTS 		= 9, 	-- number of runs this season for 5+, 10+, 15+, and 20+
	DUNGEON_LEVELS 				= 10, 	-- dungeon levels and stars for each dungeon completed
	DUNGEON_BEST_INDEX 		= 11 	-- best dungeon index
}

local ENCODER_MYTHICPLUS_FIELD_NAMES = {
	[1] = "CURRENT_SCORE",
	[2] = "CURRENT_ROLES",
	[3] = "PREVIOUS_SCORE",
	[4] = "PREVIOUS_ROLES",
	[5] = "MAIN_CURRENT_SCORE",
	[6] = "MAIN_CURRENT_ROLES",
	[7] = "MAIN_PREVIOUS_SCORE",
	[8] = "MAIN_PREVIOUS_ROLES",
	[9] = "DUNGEON_RUN_COUNTS",
	[10] = "DUNGEON_LEVELS",
	[11] = "DUNGEON_BEST_INDEX"
}

-- setup outdated struct
do
	for i = 1, #CONST_PROVIDER_DATA_LIST do
		local dataType = CONST_PROVIDER_DATA_LIST[i]
		DB_OUTDATED[dataType] = {}
		OUTDATED_DAYS[dataType] = {}
		OUTDATED_HOURS[dataType] = {}
	end
end

-- enum dungeons
-- the for-loop serves two purposes: localize the shortName, and populate the enums
local ENUM_DUNGEONS = {}
local KEYSTONE_INST_TO_DUNGEONID = {}
local DUNGEON_INSTANCEMAPID_TO_DUNGEONID = {}
local LFD_ACTIVITYID_TO_DUNGEONID = {}

local function UpdateConstDungeon()
	for i = 1, #CONST_DUNGEONS do
		local dungeon = CONST_DUNGEONS[i]
		dungeon.index = i

		ENUM_DUNGEONS[dungeon.shortName] = i
		KEYSTONE_INST_TO_DUNGEONID[dungeon.keystone_instance] = i
		DUNGEON_INSTANCEMAPID_TO_DUNGEONID[dungeon.instance_map_id] = i

		for _, activity_id in ipairs(dungeon.lfd_activity_ids) do
			LFD_ACTIVITYID_TO_DUNGEONID[activity_id] = i
		end

		if ns.addonConfig.useEnglishAbbreviations == true then
			dungeon.shortNameLocale = dungeon.shortName
		else
			dungeon.shortNameLocale = L["DUNGEON_SHORT_NAME_" .. dungeon.shortName] or dungeon.shortName
		end
	end
end

-- defined constants
local MAX_LEVEL = MAX_PLAYER_LEVEL_TABLE[LE_EXPANSION_BATTLE_FOR_AZEROTH]
local DATA_STALE_SECONDS = 86400 * 3 -- number of seconds before we start warning about stale data
local DATA_EXPIRED_SECONDS = 86400 * 7 -- number of seconds before we hide the data
local CURRENT_SEASON_ID = 4
local FACTION
local REGIONS
local REGIONS_RESET_TIME
local KEYSTONE_AFFIX_SCHEDULE
local KEYSTONE_LEVEL_TO_BASE_SCORE
local RAID_DIFFICULTY_SUFFIXES
local RAID_DIFFICULTY_NAMES
local RAID_DIFFICULTY_COLORS
local RAIDERIO_ADDON_DOWNLOAD_URL = "https://rio.gg/addon"
local TEXT_COLOR_START_RAIDERIO = "|cffffbd0a"
local TEXT_COLOR_CLOSE = "|r"
do
	FACTION = {
		["Alliance"] = 1,
		["Horde"] = 2,
	}

	REGIONS = {
		"us",
		"kr",
		"eu",
		"tw",
		"cn"
	}

	REGIONS_RESET_TIME = {
		1135695600,
		1135810800,
		1135753200,
		1135810800,
		1135810800,
	}

	KEYSTONE_AFFIX_SCHEDULE = {
		9, -- Fortified
		10, -- Tyrannical
		-- {  6,  4,  9 },
		-- {  7,  2, 10 },
		-- {  5,  3,  9 },
		-- {  8, 12, 10 },
		-- {  7, 13,  9 },
		-- { 11, 14, 10 },
		-- {  6,  3,  9 },
		-- {  5, 13, 10 },
		-- {  7, 12,  9 },
		-- {  8,  4, 10 },
		-- { 11,  2,  9 },
		-- {  5, 14, 10 },
	}

	KEYSTONE_LEVEL_TO_BASE_SCORE = {
		[2] = 20,
		[3] = 30,
		[4] = 40,
		[5] = 50,
		[6] = 60,
		[7] = 70,
		[8] = 80,
		[9] = 90,
		[10] = 100,
		[11] = 110,
		[12] = 121,
		[13] = 133,
		[14] = 146,
		[15] = 161,
		[16] = 177,
		[17] = 195,
		[18] = 214,
		[19] = 236,
		[20] = 259,
		[21] = 285,
		[22] = 314,
		[23] = 345,
		[24] = 380,
		[25] = 418,
		[26] = 459,
		[27] = 505,
		[28] = 556,
		[29] = 612,
		[30] = 673,
	}

	RAID_DIFFICULTY_SUFFIXES = {
		[1] = L.RAID_DIFFICULTY_SUFFIX_NORMAL,
		[2] = L.RAID_DIFFICULTY_SUFFIX_HEROIC,
		[3] = L.RAID_DIFFICULTY_SUFFIX_MYTHIC,
	}

	RAID_DIFFICULTY_NAMES = {
		[1] = L.RAID_DIFFICULTY_NAME_NORMAL,
		[2] = L.RAID_DIFFICULTY_NAME_HEROIC,
		[3] = L.RAID_DIFFICULTY_NAME_MYTHIC,
	}

	RAID_DIFFICULTY_COLORS = {
		[1] = { 0.12, 1.00, 0.00, 'ff1eff00' },
		[2] = { 0.00, 0.44, 0.87, 'ff0070dd' },
		[3] = { 0.64, 0.21, 0.93, 'ffa335ee' }
	}
end

-- easter
local EGG = {
	["eu"] = {
		["Ravencrest"] = {
			["Voidzone"] = "Raider.IO AddOn Author",
		},
		["Sargeras"] = {
			["Isak"] = "Raider.IO Contributor"
		}
	},
	["us"] = {
		["Skullcrusher"] = {
			["Aspyrox"] = "Raider.IO Creator",
			["Ulsoga"] = "Raider.IO Creator",
			["Fittlewak"] = "Raider.IO Contributor"
		},
		["Thrall"] = {
			["Firstclass"] = "Author of mythicpl.us"
		},
		["Tichondrius"] = {
			["Johnsamdi"] = "Raider.IO Developer"
		}
	},
}

-- create the addon core frame
local addon = CreateFrame("Frame")

-- namespace addon frame reference
ns.addon = addon

-- dynamic tooltip flags for specific uses (replaces the flags with functions that when called also combines the modifier logic)
do
	for k, v in pairs(TooltipProfileOutput) do
		TooltipProfileOutput[k] = function(forceMod) return bor(v, (forceMod or addon:IsModifierKeyDown()) and ProfileOutput.MOD_KEY_DOWN or 0) end
	end
end

-- utility functions
local RoundNumber
local CompareDungeon
local DecodeBits2
local DecodeBits3
local DecodeBits4
local DecodeBits5
local DecodeBits6
local GetDungeonWithData
local GetTimezoneOffset
local GetRegion
local GetKeystoneLevel
local GetLFDStatus
local GetInstanceStatus
local GetRealmSlug
local GetNameAndRealm
local GetFaction
local IsUnitMaxLevel
local GetWeeklyAffix
local GetStarsForUpgrades
local GetFormattedScore
local GetTooltipScore
local GetFormattedRunCount
do
	-- bracket can be 10, 100, 0.1, 0.01, and so on
	function RoundNumber(v, bracket)
		bracket = bracket or 1
		return floor(v/bracket + ((v >= 0 and 1) or -1 )* 0.5) * bracket
	end

	-- Find the dungeon in CONST_DUNGEONS corresponding to the data in argument
	function GetDungeonWithData(dataName, dataValue)
		for i = 1, #CONST_DUNGEONS do
			if CONST_DUNGEONS[i][dataName] == dataValue then
				return CONST_DUNGEONS[i]
			end
		end
	end

	function DecodeBits6(value)
		if value < 10 then
			return value
		else
			return 10 + (value - 10) * 5
		end
	end

	local CONST_DECODE_BITS5_TABLE = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 25, 30, 35, 40, 45, 50,60, 70, 80, 90, 100 }
	function DecodeBits5(value)
		return CONST_DECODE_BITS5_TABLE[1 + value] or 0
	end

	local CONST_DECODE_BITS4_TABLE = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20, 25, 50, 100 }
	function DecodeBits4(value)
		return CONST_DECODE_BITS4_TABLE[1 + value] or 0
	end

	local CONST_DECODE_BITS3_TABLE = { 0, 1, 2, 3, 4, 5, 10, 20 }
	function DecodeBits3(value)
		return CONST_DECODE_BITS3_TABLE[1 + value] or 0
	end

	local CONST_DECODE_BITS2_TABLE = { 0, 1, 2, 5 }
	function DecodeBits2(value)
		return CONST_DECODE_BITS2_TABLE[1 + value] or 0
	end

	-- Compare two dungeon first by the keyLevel, then by their short name
	function CompareDungeon(a, b)
		if not a then
			return false
		end

		if not b then
			return true
		end

		if a.keyLevel > b.keyLevel then
			return true
		elseif a.keyLevel < b.keyLevel then
			return false
		end

		if a.fractionalTime > b.fractionalTime then
			return false
		elseif a.fractionalTime < b.fractionalTime then
			return true
		end

		if a.shortName > b.shortName then
			return false
		elseif a.shortName < b.shortName then
			return true
		end

		return false
	end

	-- get timezone offset between local and UTC+0 time
	function GetTimezoneOffset(ts)
		local u = date("!*t", ts)
		local l = date("*t", ts)
		l.isdst = false
		return difftime(time(l), time(u))
	end

	-- gets the current region name and index
	function GetRegion()
		-- use the player GUID to find the serverID and check the map for the region we are playing on
		local guid = UnitGUID("player")
		local server
		if guid then
			server = tonumber(strmatch(guid, "^Player%-(%d+)") or 0) or 0
			local i = CONST_REGION_IDS[server]
			if i then
				return REGIONS[i], i
			end
		end
		-- alert the user to report this to the devs
		DEFAULT_CHAT_FRAME:AddMessage(format(L.UNKNOWN_SERVER_FOUND, addonName, guid or "N/A", GetNormalizedRealmName() or "N/A"), 1, 1, 0)
		-- fallback logic that might be wrong, but better than nothing...
		local i = GetCurrentRegion()
		return REGIONS[i], i
	end

	-- the kind of strings we might want to interpret as keystone levels in title and descriptions
	local KEYSTONE_LEVEL_PATTERNS = { "(%d+)%+", "%+%s*(%d+)", "(%d+)%s*%+", "(%d+)" }

	-- attempts to extract the keystone level from the provided strings
	function GetKeystoneLevel(raw)
		if type(raw) ~= "string" then
			return
		end
		local level
		for _, pattern in ipairs(KEYSTONE_LEVEL_PATTERNS) do
			level = raw:match(pattern)
			if level then
				level = tonumber(level)
				if level and level < 32 then
					break
				end
			end
		end
		if not level or level < 2 then
			return
		end
		return level
	end

	-- returns the LFD status (returns the info based on what we are hosting a group for, or what we queued up for)
	function GetLFDStatus()
		local temp = {}

		-- hosting a keystone group
		local activityInfo = C_LFGList.GetActiveEntryInfo()

		if activityInfo then
			local activityID = activityInfo.activityID
			local name = activityInfo.name -- unusable (broken by blizzard)
			local comment = activityInfo.comment -- unusable (broken by blizzard)

			if activityID then
				local index = LFD_ACTIVITYID_TO_DUNGEONID[activityID]
				if index then
					temp.dungeon = CONST_DUNGEONS[index]
					temp.level = 0 or GetKeystoneLevel(name) or GetKeystoneLevel(comment) or 0
					return true, temp
				end
			end
		end

		-- applying for a keystone group
		local applications = C_LFGList.GetApplications()
		local j = 1
		for i = 1, #applications do
			local resultID = applications[i]
			local searchResultInfo = C_LFGList.GetSearchResultInfo(resultID)

			if searchResultInfo then
				local activityID = searchResultInfo.activityID
				local name = searchResultInfo.name -- unusable (broken by blizzard)
				local comment = searchResultInfo.comment -- unusable (broken by blizzard)
				local isDelisted = searchResultInfo.isDelisted

				if activityID and not isDelisted then
					local _, appStatus, pendingStatus = C_LFGList.GetApplicationInfo(resultID)
					if not pendingStatus and (appStatus == "applied" or appStatus == "invited") then
						local index = LFD_ACTIVITYID_TO_DUNGEONID[activityID]
						if index then
							temp[j] = { dungeon = CONST_DUNGEONS[index], level = 0 or GetKeystoneLevel(name) or GetKeystoneLevel(comment) or 0, resultID = resultID }
							j = j + 1
						end
					end
				end
			end
		end
		return j - 1, temp
	end

	-- detect what instance we are in
	function GetInstanceStatus()
		local _, instanceType, _, _, _, _, _, instanceMapID = GetInstanceInfo()
		if instanceType ~= "party" then
			return
		end
		local index = DUNGEON_INSTANCEMAPID_TO_DUNGEONID[instanceMapID]
		if not index then
			return
		end
		return CONST_DUNGEONS[index]
	end

	-- retrieves the url slug for a given realm name
	function GetRealmSlug(realm)
		return CONST_REALM_SLUGS[realm] or realm
	end

	-- returns the name, realm and possibly unit
	function GetNameAndRealm(arg1, arg2)
		local name, realm, unit
		if UnitExists(arg1) then
			unit = arg1
			if UnitIsPlayer(arg1) then
				name, realm = UnitName(arg1)
				realm = realm and realm ~= "" and realm or GetNormalizedRealmName()
			end
		elseif type(arg1) == "string" and arg1 ~= "" then
			if arg1:find("-", nil, true) then
				name, realm = ("-"):split(arg1)
			else
				name = arg1 -- assume this is the name
			end
			if not realm or realm == "" then
				if type(arg2) == "string" and arg2 ~= "" then
					realm = arg2
				else
					realm = GetNormalizedRealmName() -- assume they are on our realm
				end
			end
		end
		return name, realm, unit
	end

	-- returns 1 or 2 if the unit is Alliance or Horde, nil if neutral
	function GetFaction(unit)
		if UnitExists(unit) and UnitIsPlayer(unit) then
			local faction = UnitFactionGroup(unit)
			if faction then
				return FACTION[faction]
			end
		end
	end

	-- returns true if we know the unit is max level or if we don't know (unit is invalid) we return using fallback value
	function IsUnitMaxLevel(unit, fallback)
		if UnitExists(unit) and UnitIsPlayer(unit) then
			local level = UnitLevel(unit)
			if level then
				return level >= MAX_LEVEL
			end
		end
		return fallback
	end

	-- returns affix ID based on the week
	function GetWeeklyAffix(weekOffset)
		local timestamp = (time() - GetTimezoneOffset()) + 604800 * (weekOffset or 0)
		local timestampWeeklyReset = REGIONS_RESET_TIME[PLAYER_REGION]
		local diff = difftime(timestamp, timestampWeeklyReset)
		local index = floor(diff / 604800) % #KEYSTONE_AFFIX_SCHEDULE + 1
		return KEYSTONE_AFFIX_SCHEDULE[index]
	end

	function GetStarsForUpgrades(upgrades, skipPadding)
		local stars = ""
		for q = 1, 3 do
			if 3 - q < upgrades then
				stars = stars .. "+"
			elseif not skipPadding then
				stars = stars .. " "
			end
		end
		if upgrades > 0 then
			return "|cffffcf40" .. stars .. "|r"
		else
			return stars
		end
	end

	-- returns score formatted for current or prev season
	function GetFormattedScore(score)
		return score
	end

	-- returns score with role
	function GetTooltipScore(score, isApproximated)
		if not ns.addonConfig.showRoleIcons then
			return score.score
		end

		local inversedRole = {}

		local roles = {
			["tank"] = 0,
			["heal"] = 0,
			["dps"] = 0,
		}

		local icons = ""

		for i = 1, #score.roles do
			icons = icons .. ROLE_ICONS[score.roles[i][1]][score.roles[i][2]]
		end

		return icons .. " " .. (isApproximated and "±" or "") .. score.score
	end

	-- run counts are packed so we print it as a range (with "+" suffix after a certain number)
	function GetFormattedRunCount(count, pluralAt)
		if count >= pluralAt then
			return count .. "+"
		else
			return count
		end
	end
end

-- provider
local AddProvider
local GetScoreColor
local GetPreviousScoreColor
local GetRaidDifficultyColor
local GetPlayerProfile
local HasPlayerProfile
do
	-- search for the index of a name in the given sorted list
	local function BinarySearchForName(list, name, startIndex, endIndex)
		local minIndex = startIndex
		local maxIndex = endIndex
		local mid, current

		while minIndex <= maxIndex do
			mid = floor((maxIndex + minIndex) / 2)
			current = list[mid]
			if current == name then
				return mid
			elseif current < name then
				minIndex = mid + 1
			else
				maxIndex = mid - 1
			end
		end
	end

	local function Split64BitNumber(dword)
		-- 0x100000000 == (1 << 32). Meaning, shift to get the hi-word.
		-- WoW lua bit operators seem to only work on the lo-word (?)
		local lo = band(dword, 0xfffffffff)
		return lo, (dword - lo) / 0x100000000
	end

	-- read given number of bits from the chosen offset with max of 52 bits
	-- assumed that lo contains 32 bits and hi contains 20 bits
	local function ReadBits(lo, hi, offset, bits)
		if offset < 32 and (offset + bits) > 32 then
			-- reading across boundary
			local mask = lshift(1, (offset + bits) - 32) - 1
			local p1 = rshift(lo, offset)
			local p2 = lshift(band(hi, mask), 32 - offset)
			return p1 + p2, offset + bits
		else
			local mask = lshift(1, bits) - 1
			if offset < 32 then
				-- standard read from loword
				return band(rshift(lo, offset), mask), offset + bits
			else
				-- standard read from hiword
				return band(rshift(hi, offset - 32), mask), offset + bits
			end
		end
	end

	-- Params:
	-- str = string to read from
	-- strIndex = character offset to start reading from
	-- bitOffset = number of bits after strIndex to read from
	-- totalBitsToRead = number of bits to read
	--
	-- Returns:
	-- value: of the `numBits` from the given offset
	-- offset: new bit offset after reading this field
	function ReadBitsFromString(str, bitOffset, totalBitsToRead)
		local value = 0
		local readOffset = 0
		local firstByteShift = bitOffset % 8
		local bytesToRead = ceil((totalBitsToRead + firstByteShift) / 8)

		while readOffset < totalBitsToRead do
			local byte = strbyte(str, 1 + floor((bitOffset + readOffset) / 8))
			local bitsRead = 0
			if readOffset == 0 then
				if bytesToRead == 1 then
					local availableBits = totalBitsToRead - readOffset
					value = band(rshift(byte, firstByteShift), ((lshift(1, availableBits)) - 1))
					bitsRead = totalBitsToRead
				else
					value = rshift(byte, firstByteShift)
					bitsRead = 8 - firstByteShift
				end
			else
				local availableBits = totalBitsToRead - readOffset
				if availableBits < 8 then
					value = value + lshift(band(byte, (lshift(1, availableBits) - 1)), readOffset)
					bitsRead = bitsRead + availableBits;
				else
					value = value + lshift(byte, readOffset)
					bitsRead = bitsRead + min(8, totalBitsToRead)
				end
			end
			readOffset = readOffset + bitsRead
		end

		if readOffset ~= totalBitsToRead then
			DEFAULT_CHAT_FRAME:AddMessage('Read an improper number of bits. Expected ' .. totalBitsToRead .. ' got ' .. readOffset, 0, 0, 1)
		end

		return value, bitOffset + readOffset
	end

	local function UnpackMythicPlusCharacterData(encodingOrder, bucket, baseOffset)
		local results = {}
		local bitOffset = (baseOffset - 1) * 8
		local value
	
		for encoderIndex = 1, #encodingOrder do
			local field = encodingOrder[encoderIndex]
			if field == ENCODER_MYTHICPLUS_FIELDS.CURRENT_SCORE then
				results.currentScore, bitOffset = ReadBitsFromString(bucket, bitOffset, 13)
			elseif field == ENCODER_MYTHICPLUS_FIELDS.CURRENT_ROLES then
				value, bitOffset = ReadBitsFromString(bucket, bitOffset, 7)
				results.currentRoleOrdinalIndex = 1 + value -- indexes are one-based
			elseif field == ENCODER_MYTHICPLUS_FIELDS.PREVIOUS_SCORE then
				results.previousScore, bitOffset = ReadBitsFromString(bucket, bitOffset, 12)
				results.previousScoreSeason, bitOffset = ReadBitsFromString(bucket, bitOffset, 2)
			elseif field == ENCODER_MYTHICPLUS_FIELDS.PREVIOUS_ROLES then
				value, bitOffset = ReadBitsFromString(bucket, bitOffset, 7)
				results.previousRoleOrdinalIndex = 1 + value -- indexes are one-based
			elseif field == ENCODER_MYTHICPLUS_FIELDS.MAIN_CURRENT_SCORE then
				results.mainCurrentScore, bitOffset = ReadBitsFromString(bucket, bitOffset, 13)
			elseif field == ENCODER_MYTHICPLUS_FIELDS.MAIN_CURRENT_ROLES then
				value, bitOffset = ReadBitsFromString(bucket, bitOffset, 7)
				results.mainCurrentRoleOrdinalIndex = 1 + value -- indexes are one-based
			elseif field == ENCODER_MYTHICPLUS_FIELDS.MAIN_PREVIOUS_SCORE then
				value, bitOffset = ReadBitsFromString(bucket, bitOffset, 9)
				results.mainPreviousScore = 10 * value
				results.mainPreviousScoreSeason, bitOffset = ReadBitsFromString(bucket, bitOffset, 2)
			elseif field == ENCODER_MYTHICPLUS_FIELDS.MAIN_PREVIOUS_ROLES then
				value, bitOffset = ReadBitsFromString(bucket, bitOffset, 7)
				results.mainPreviousRoleOrdinalIndex = 1 + value -- indexes are one-based
			elseif field == ENCODER_MYTHICPLUS_FIELDS.DUNGEON_RUN_COUNTS then
				value, bitOffset = ReadBitsFromString(bucket, bitOffset, 6)
				results.keystoneFivePlus = DecodeBits6(value)
		
				value, bitOffset = ReadBitsFromString(bucket, bitOffset, 6)
				results.keystoneTenPlus = DecodeBits6(value)
	
				value, bitOffset = ReadBitsFromString(bucket, bitOffset, 6)
				results.keystoneFifteenPlus = DecodeBits6(value)
	
				value, bitOffset = ReadBitsFromString(bucket, bitOffset, 6)
				results.keystoneTwentyPlus = DecodeBits6(value)
			elseif field == ENCODER_MYTHICPLUS_FIELDS.DUNGEON_LEVELS then
				results.dungeons = {}
				results.dungeonUpgrades = {}
				results.dungeonTimes = {}
		
				for i = 1, 12 do
						results.dungeons[i], bitOffset = ReadBitsFromString(bucket, bitOffset, 5)
	
						results.dungeonUpgrades[i], bitOffset = ReadBitsFromString(bucket, bitOffset, 2)
	
					-- this is just set so that dungeons will be sorted by key level and number of stars.
					-- it may be overridden by client data.
					results.dungeonTimes[i] = 3 - results.dungeonUpgrades[i]
				end
			elseif field == ENCODER_MYTHICPLUS_FIELDS.DUNGEON_BEST_INDEX then
				-- since we do not store score in addon, we need an explicit value indicating which dungeon was the best run
				-- note: stored as zero-based, so offset it here on load
				value, bitOffset = ReadBitsFromString(bucket, bitOffset, 4)
				results.maxDungeonIndex = 1 + value
			else
				DEFAULT_CHAT_FRAME:AddMessage('Unexpected field ' .. field, 0, 1, 0)
			end
		end
	
		-- Post processing
		if results.maxDungeonIndex > #results.dungeons then
			results.maxDungeonIndex = 1
		end
		results.maxDungeonLevel = results.dungeons[results.maxDungeonIndex]
	
		return results
	end

	local function UnpackRaidingCharacterData(dataProviderGroup, data1, data2)
		local results = {
			progress = {},
			previousProgress = nil,
			mainProgress = nil
		}

		local currentNumBosses = dataProviderGroup.currentRaid.bossCount
		local value

		do
			local lo, hi = Split64BitNumber(data1)
			local offset = 0
			local prog

			for bucketIndex = 1, 2 do
				prog = { progressCount = 0 }

				prog.difficulty, offset = ReadBits(lo, hi, offset, 2)

				prog.killsPerBoss = {}
				for i = 1, currentNumBosses do
					value, offset = ReadBits(lo, hi, offset, 2)
					prog.killsPerBoss[i] = DecodeBits2(value)
					if prog.killsPerBoss[i] > 0 then
						prog.progressCount = prog.progressCount + 1
					end
				end

				if prog.progressCount > 0 then
					results.progress[#results.progress + 1] = prog
				end
			end
		end

		do
			local lo, hi = Split64BitNumber(data2)
			local offset = 0
			local prog

			-- final difficulty
			do
				prog = { progressCount = 0 }

				prog.difficulty, offset = ReadBits(lo, hi, offset, 2)

				prog.killsPerBoss = {}
				for i = 1, currentNumBosses do
					value, offset = ReadBits(lo, hi, offset, 2)
					prog.killsPerBoss[i] = DecodeBits2(value)
					if prog.killsPerBoss[i] > 0 then
						prog.progressCount = prog.progressCount + 1
					end
				end

				if prog.difficulty ~= 0 and prog.progressCount > 0 then
					results.progress[#results.progress + 1] = prog
				end
			end

			-- progress in top two difficulties for previous raid
			for i = 1, 2 do
				prog = {}

				prog.difficulty, offset = ReadBits(lo, hi, offset, 2)

				prog.progressCount, offset = ReadBits(lo, hi, offset, 4)

				if prog.progressCount > 0 then
					if not results.previousProgress then
						results.previousProgress = {}
					end
					results.previousProgress[#results.previousProgress + 1] = prog
				end
			end

			-- main's top two progress
			for i = 1, 2 do
				prog = {}

				prog.difficulty, offset = ReadBits(lo, hi, offset, 2)

				prog.progressCount, offset = ReadBits(lo, hi, offset, 4)

				if prog.progressCount > 0 then
					if not results.mainProgress then
						results.mainProgress = {}
					end
					results.mainProgress[#results.mainProgress + 1] = prog
				end
			end

		end

		return results
	end

	-- caches the profile table and returns one using keys
	local function CacheMythicPlusProviderData(dataProviderGroup, name, realm, faction, index, bucket, baseOffset)
		local cache = profileCache[index]

		-- prefer to re-use cached profiles
		if cache then
			return cache
		end

		if dataProviderGroup.recordSizeInBytes ~= CONST_PROVIDER_DATA_FIELDS_PER_CHARACTER[1] then
			-- some type of mismatch, so return nothing
			if ns.DEBUG_MODE then
				DEFAULT_CHAT_FRAME:AddMessage(format('Raider.IO Addon received mismatched MythicPlus recordSizeInBytes. Got %i expected %i. Skipping.',
					dataProviderGroup.recordSizeInBytes, CONST_PROVIDER_DATA_FIELDS_PER_CHARACTER[1]), 1, 0, 0)
			end
			return nil
		end

		-- unpack the payloads into these tables
		local payload = UnpackMythicPlusCharacterData(dataProviderGroup.encodingOrder, bucket, baseOffset)

		-- TODO: can we make this table read-only? raw methods will bypass metatable restrictions we try to enforce
		-- build this custom table in order to avoid users tainting the provider database
		cache = {
			-- provider information
			region = dataProviderGroup.region,
			date = dataProviderGroup.date,
			dataType = dataProviderGroup.data,
			-- basic information about the character
			name = name,
			realm = realm,
			faction = faction,
			-- current and last season overall score
			mplusCurrent = {
				score = payload.currentScore,
				roles = ORDERED_ROLES[payload.currentRoleOrdinalIndex] or ORDERED_ROLES[1]
			},
			mplusPrevious = {
				score = payload.previousScore,
				roles = ORDERED_ROLES[payload.previousRoleOrdinalIndex] or ORDERED_ROLES[1],
				season = 1 + payload.previousScoreSeason
			},
			mplusMainCurrent = {
				score = payload.mainCurrentScore,
				roles = ORDERED_ROLES[payload.mainCurrentRoleOrdinalIndex] or ORDERED_ROLES[1]
			},
			mplusMainPrevious = {
				score = payload.mainPreviousScore,
				roles = ORDERED_ROLES[payload.mainPreviousRoleOrdinalIndex] or ORDERED_ROLES[1],
				season = 1 + payload.mainPreviousScoreSeason
			},
			-- dungeons they have completed
			dungeons = payload.dungeons,
			dungeonUpgrades = payload.dungeonUpgrades,
			dungeonTimes = payload.dungeonTimes,
			-- best dungeon completed (or highest 10/15 achievement)
			maxDungeon = CONST_DUNGEONS[payload.maxDungeonIndex],
			maxDungeonLevel = payload.maxDungeonLevel,
			keystoneFivePlus = payload.keystoneFivePlus,
			keystoneTenPlus = payload.keystoneTenPlus,
			keystoneFifteenPlus = payload.keystoneFifteenPlus,
			keystoneTwentyPlus = payload.keystoneTwentyPlus
		}

		-- client related data populates these fields
		do

			-- has been enhanced with client data
			cache.isEnhanced = false

			-- number of keystone upgrades per dungeon
			cache.maxDungeonUpgrades = 0

			-- if character exists in the clientCharacters list then override some data with higher precision
			-- TODO: only do this if the clientCharacters data isn't too old compared to regular addon date?
			if false and ns.CLIENT_CHARACTERS and ns.addonConfig.enableClientEnhancements then
				local nameAndRealm = name .. "-" .. realm
				local clientData = ns.CLIENT_CHARACTERS[nameAndRealm]

				if clientData then
					local keystoneData = clientData.mythic_keystone
					cache.isEnhanced = true
					cache.mplusCurrent.score = keystoneData.all.score

					local maxDungeonIndex = 0
					local maxDungeonTime = 999
					local maxDungeonLevel = 0
					local maxDungeonUpgrades = 0

					for i = 1, #keystoneData.all.runs do
						local run = keystoneData.all.runs[i]
						cache.dungeons[i] = run.level
						cache.dungeonUpgrades[i] = run.upgrades
						cache.dungeonTimes[i] = run.fraction

						if run.level > maxDungeonLevel or (run.level == maxDungeonLevel and run.fraction < maxDungeonTime) then
							maxDungeonIndex = i
							maxDungeonTime = run.fraction
							maxDungeonLevel = run.level
							maxDungeonUpgrades = run.upgrades
						end
					end

					if maxDungeonIndex > 0 then
						cache.maxDungeon = CONST_DUNGEONS[maxDungeonIndex]
						cache.maxDungeonLevel = maxDungeonLevel
						cache.maxDungeonUpgrades = maxDungeonUpgrades
					end
				end
			end

		end

		-- store it in the profile cache
		profileCache[index] = cache

		-- return the freshly generated table
		return cache
	end

	-- caches the profile table and returns one using keys
	local function CacheRaidingProviderData(dataProviderGroup, name, realm, faction, index, data1, data2)
		local cache = profileCache[index]

		-- prefer to re-use cached profiles
		if cache then
			return cache

		end

		-- unpack the payloads into these tables
		local payload = UnpackRaidingCharacterData(dataProviderGroup, data1, data2)

		-- TODO: can we make this table read-only? raw methods will bypass metatable restrictions we try to enforce
		-- build this custom table in order to avoid users tainting the provider database
		cache = {
			-- provider information
			region = dataProviderGroup.region,
			date = dataProviderGroup.date,
			dataType = dataProviderGroup.data,
			currentRaid = dataProviderGroup.currentRaid,
			previousRaid = dataProviderGroup.previousRaid,
			-- basic information about the character
			name = name,
			realm = realm,
			faction = faction,
			-- data
			progress = payload.progress,
			previousProgress = payload.previousProgress,
			mainProgress = payload.mainProgress
		}

		-- store it in the profile cache
		profileCache[index] = cache

		-- return the freshly generated table
		return cache
	end

	-- returns the profile of a given character
	--   faction is optional but recommended for quicker lookups
	--   region is optional as well, and will default to the player's region
	local function GetProviderData(dataType, name, realm, faction, region)
		if region == nil then
			region = PLAYER_REGION
		end

		-- shorthand for data provider group table
		local dataProviderGroup = dataProvider[region] and dataProvider[region][dataType]
		-- if the provider isn't loaded we don't try and search for the data
		if not dataProviderGroup then return end
		-- figure out what faction tables we want to iterate
		local a, b = 1, 2
		if faction == 1 or faction == 2 then
				a, b = faction, faction
		end
		-- iterate through the data
		local numFieldsPerCharacter = CONST_PROVIDER_DATA_FIELDS_PER_CHARACTER[dataType]
		local lookupMaxSize = CONST_PROVIDER_DATA_BUCKET_MAX_SIZE[dataType]
		local db, lu, r, d, base, bucketID, bucket
		for i = a, b do
			db, lu = dataProviderGroup["db" .. i], dataProviderGroup["lookup" .. i]
			-- sanity check that the data exists and is loaded, because it might not be for the requested faction
			if db and lu then
				r = db[realm]

				if r then
					d = BinarySearchForName(r, name, 2, #r)
					if d then
						if dataType == CONST_PROVIDER_DATA_MYTHICPLUS then
							-- `r[1]` = offset for this realm's characters in lookup table
							-- `d` = index of found character in realm list. note: this is offset by two because first index in `r` is an offset, and because lua is 1-base.
							-- `bucketID` = the index in the lookup table that contains that characters data
							base = 1 + r[1] + (d - 2) * dataProviderGroup.recordSizeInBytes
							bucketID = 1
							bucket = lu[bucketID]
							if bucket then
								return CacheMythicPlusProviderData(dataProviderGroup, name, realm, i, i .. "-" .. base, bucket, base)
							end
						elseif dataType == CONST_PROVIDER_DATA_RAIDING then
							-- `r[1]` = offset for this realm's characters in lookup table
							-- `d` = index of found character in realm list. note: this is offset by two because first index in `r` is an offset, and because lua is 1-base.
							-- `bucketID` = the index in the lookup table that contains that characters data
							base = r[1] + (d - 2) * numFieldsPerCharacter
							bucketID = 1 + floor(base / lookupMaxSize)
							bucket = lu[bucketID]
							base = 1 + base - (bucketID - 1) * lookupMaxSize
							if bucket then
								return CacheRaidingProviderData(dataProviderGroup, name, realm, i, i .. "-" .. bucketID .. "-" .. base, bucket[base], bucket[base + 1])
							end
						end
					end
				end
			end
		end
	end

	function AddProvider(data)
		assert(type(data) == "table", "Raider.IO has been requested to load an invalid database.")
		if type(data.data) == "nil" then
			-- when this isn't set we assume this is an old pre BFA S1 dataset, so we want to ignore it
			if not INVALID_DATA_MESSAGE_SENT then
				DEFAULT_CHAT_FRAME:AddMessage(format(L.API_INVALID_DATABASE, data.name or "<UNKNOWN>"), 1, 1, 0)
				INVALID_DATA_MESSAGE_SENT = true
			end
			return
		end
		-- make sure the object is what we expect it to be like
		assert(type(data.name) == "string" and type(data.data) == "number" and type(data.region) == "string" and type(data.faction) == "number", "Raider.IO has been requested to load a database that isn't supported.")
		-- queue it for later inspection
		dataProviderQueue[#dataProviderQueue + 1] = data
	end

	-- returns score color using item colors
	local function GetScoreColorFromTable(score, tbl, tblSimple)
		if score == 0 or ns.addonConfig.disableScoreColors then
			return 1, 1, 1
		end
		local r, g, b = 0.62, 0.62, 0.62
		if type(score) == "number" then
			if not ns.addonConfig.showSimpleScoreColors then
				for i = 1, #tbl do
					local tier = tbl[i]
					if score >= tier.score then
						local color = tier.color
						r, g, b = color[1], color[2], color[3]
						break
					end
				end
			else
				local qualityColor = 1
				for i = 1, #tblSimple do
					local tier = tblSimple[i]
					if score >= tier.score then
						qualityColor = tier.quality
						break
					end
				end
				r, g, b = GetItemQualityColor(qualityColor)
			end
		end
		return r, g, b
	end

	-- returns score color using item colors
	function GetScoreColor(score)
		return GetScoreColorFromTable(score, CONST_SCORE_TIER, CONST_SCORE_TIER_SIMPLE)
	end

	-- returns score color using item colors with scale from previous tier
	function GetPreviousScoreColor(score)
		return GetScoreColorFromTable(score, CONST_PREVIOUS_SCORE_TIER, CONST_PREVIOUS_SCORE_TIER_SIMPLE)
	end

	-- returns score color using item colors
	function GetRaidDifficultyColor(difficulty)
		return ns.RAID_DIFFICULTY_COLORS[difficulty]
	end

	local function SortScoresByRole(a, b)
		return a[2] > b[2]
	end

	local function getBestRunLines(profile, isProfile, addLFD, focusDungeon, focusKeystone, ...)
		local lines = {}

		local best = { dungeon = nil, level = 0, text = nil }			-- dungeon best
		local overallBest = { dungeon = profile.maxDungeon, level = profile.dungeons[profile.maxDungeon.index] }	-- overall best

		if addLFD or focusDungeon then
			local hasArgs, dungeonIndex = ...
			if hasArgs == true then
				best.dungeon = CONST_DUNGEONS[dungeonIndex] or best.dungeon
			end
		end

		if focusKeystone then
			local hasArgs, arg1, arg2 = ...
			if hasArgs == true then
				if ns.DEBUG_MODE then -- TODO
					table.insert(lines, "focusKeystone arg1 = " .. tostring(arg1))
					table.insert(lines, "focusKeystone arg2 = " .. tostring(arg2))
				end
			end
		end

		-- if we don't have a best dungeon focused by this point, try to find one based on our queue or current instance
		if not best.dungeon and addLFD then
			local numSigned, status = GetLFDStatus()
			if numSigned then
				if numSigned == true then
					best.dungeon = status.dungeon
					best.level = status.level or 0
				elseif numSigned > 0 then
					local highestDungeon
					for j = 1, numSigned do
						local d = status[j]
						if not highestDungeon or d.level > highestDungeon.level then
							highestDungeon = d
						end
					end
					best.dungeon = highestDungeon
					best.level = highestDungeon.level or 0
				end
			end
			if not best.dungeon then
				best.dungeon = GetInstanceStatus()
			end
		end

		-- if we have a dungeon, but no level assigned to it, try to read one from our profile
		if best.dungeon and (not best.level or best.level < 1) then
			best.level = profile.dungeons[best.dungeon.index] or 0
		end

		-- if no dungeon, or the level is undefined or 0, drop showing both as it's irrelevant information
		if not best.dungeon or (best.level and best.level < 1) then
			best.dungeon, best.level = nil, 0
		end

		if not best.text and (not best.dungeon or overallBest.dungeon.index ~= best.dungeon.index) and overallBest.level > 0 then
			local bestRunLabel = (isProfile or ns.addonConfig.mplusHeadlineMode ~= MythicPlusHeadlineModes.BEST_RUN) and L.BEST_RUN or L.RAIDERIO_BEST_RUN
			local lineColor = (isProfile or ns.addonConfig.mplusHeadlineMode ~= MythicPlusHeadlineModes.BEST_RUN) and {1, 1, 1} or {1, 0.85, 0}
			table.insert(lines, {bestRunLabel, GetStarsForUpgrades(profile.dungeonUpgrades[overallBest.dungeon.index]) .. "|cFFFFFFFF" .. overallBest.level .. "|r " .. overallBest.dungeon.shortNameLocale, lineColor[1], lineColor[2], lineColor[3], GetScoreColor(profile.mplusCurrent.score)})
		end

		if best.dungeon and best.level > 0 then
			if best.dungeon == profile.maxDungeon then
				local bestRunLabel = (isProfile or ns.addonConfig.mplusHeadlineMode ~= MythicPlusHeadlineModes.BEST_RUN) and L.BEST_FOR_DUNGEON or L.RAIDERIO_BEST_RUN
				local lineColor = (isProfile or ns.addonConfig.mplusHeadlineMode ~= MythicPlusHeadlineModes.BEST_RUN) and {0, 1, 0} or {1, 0.85, 0}
				table.insert(lines, {bestRunLabel, GetStarsForUpgrades(profile.dungeonUpgrades[best.dungeon.index]) .. "|cFFFFFFFF" .. best.level .. "|r " .. best.dungeon.shortNameLocale, lineColor[1], lineColor[2], lineColor[3], GetScoreColor(profile.mplusCurrent.score)})
			else
				table.insert(lines, {L.BEST_FOR_DUNGEON, GetStarsForUpgrades(profile.dungeonUpgrades[best.dungeon.index]) .. "|cFFFFFFFF" ..best.level .. "|r " .. best.dungeon.shortNameLocale, 1, 1, 1, GetScoreColor(profile.mplusCurrent.score)})
			end
		elseif best.text then
			local bestRunLabel = (isProfile or ns.addonConfig.mplusHeadlineMode ~= MythicPlusHeadlineModes.BEST_RUN) and L.BEST_RUN or L.RAIDERIO_BEST_RUN
			local lineColor = (isProfile or ns.addonConfig.mplusHeadlineMode ~= MythicPlusHeadlineModes.BEST_RUN) and {1, 1, 1} or {1, 0.85, 0}
			table.insert(lines, {bestRunLabel, best.text, lineColor[1], lineColor[2], lineColor[3], 1, 1, 1})
		end

		return lines
	end

	local function insertToOutput(output, outputLength, linesToInsert)
		for i=1, #linesToInsert do
			output[outputLength + i - 1] = linesToInsert[i]
		end

		return output
	end

	local function GenerateScoreSeasonLabel(label, season)
		return format(label, format(L["SEASON_LABEL_" .. season], season))
	end

	local function GetScoreLines(profile, isProfile, hasRunLines)
		local lines = {}

		if isProfile then
			if profile.mplusCurrent.score > 0 then
				table.insert(lines, {
					GenerateScoreSeasonLabel(L.CURRENT_SCORE, CURRENT_SEASON_ID),
					GetTooltipScore(profile.mplusCurrent),
					1, 1, 1,
					GetScoreColor(profile.mplusCurrent.score)
				})
			end

			if profile.mplusPrevious.score > profile.mplusCurrent.score then
				table.insert(lines, {
					GenerateScoreSeasonLabel(L.PREVIOUS_SCORE, profile.mplusPrevious.season),
					GetTooltipScore(profile.mplusPrevious, true),
					1, 1, 1,
					GetPreviousScoreColor(profile.mplusPrevious.score)
				})
			end
		else
			if ns.addonConfig.mplusHeadlineMode == MythicPlusHeadlineModes.CURRENT_SEASON then
				-- headline
				table.insert(lines, {
					GenerateScoreSeasonLabel(L.RAIDERIO_MP_SCORE, CURRENT_SEASON_ID),
					GetTooltipScore(profile.mplusCurrent),
					1, 0.85, 0,
					GetScoreColor(profile.mplusCurrent.score)
				})

				if profile.mplusPrevious.score > profile.mplusCurrent.score then
					table.insert(lines, {
						GenerateScoreSeasonLabel(L.PREVIOUS_SCORE, profile.mplusPrevious.season),
						GetTooltipScore(profile.mplusPrevious, true),
						1, 1, 1,
						GetPreviousScoreColor(profile.mplusPrevious.score)
					})
				end
			elseif ns.addonConfig.mplusHeadlineMode == MythicPlusHeadlineModes.BEST_SEASON then
				if profile.mplusPrevious.score > profile.mplusCurrent.score then
					-- headline
					table.insert(lines, {
						GenerateScoreSeasonLabel(L.RAIDERIO_MP_BEST_SCORE, profile.mplusPrevious.season),
						GetTooltipScore(profile.mplusPrevious, true),
						1, 0.85, 0,
						GetPreviousScoreColor(profile.mplusPrevious.score)
					})

					if profile.mplusCurrent.score > 0 then
						table.insert(lines, {
							GenerateScoreSeasonLabel(L.CURRENT_SCORE, CURRENT_SEASON_ID),
							GetTooltipScore(profile.mplusCurrent),
							1, 1, 1,
							GetScoreColor(profile.mplusCurrent.score)
						})
					end
				else
					table.insert(lines, {
						GenerateScoreSeasonLabel(L.RAIDERIO_MP_SCORE, CURRENT_SEASON_ID),
						GetTooltipScore(profile.mplusCurrent),
						1, 0.85, 0,
						GetScoreColor(profile.mplusCurrent.score)
					})
				end
			elseif ns.addonConfig.mplusHeadlineMode == MythicPlusHeadlineModes.BEST_RUN then
				local keyColor = hasRunLines and { 1, 1, 1 } or { 1, 0.85, 0 }
				-- headline would have been added previously, so just add the scores without any color highlights
				if profile.mplusCurrent.score > 0 then
					table.insert(lines, {
						GenerateScoreSeasonLabel(L.CURRENT_SCORE, CURRENT_SEASON_ID),
						GetTooltipScore(profile.mplusCurrent),
						keyColor[1], keyColor[2], keyColor[3],
						GetScoreColor(profile.mplusCurrent.score)
					})
				end

				if profile.mplusPrevious.score > profile.mplusCurrent.score then
					table.insert(lines, {
						GenerateScoreSeasonLabel(L.PREVIOUS_SCORE, profile.mplusPrevious.season),
						GetTooltipScore(profile.mplusPrevious, true),
						keyColor[1], keyColor[2], keyColor[3],
						GetPreviousScoreColor(profile.mplusPrevious.score)
					})
				end
			end
		end

		return lines
	end

	-- reads the profile and formats the output using the provided output flags
	local function ShapeProfileData(dataType, profile, outputFlag, ...)
		local output = { dataType = dataType, profile = profile, outputFlag = outputFlag, length = 0 }
		local addTooltip = band(outputFlag, ProfileOutput.TOOLTIP) == ProfileOutput.TOOLTIP
		local isProfile = band(outputFlag, ProfileOutput.PROFILE) == ProfileOutput.PROFILE

		if addTooltip then
			local i = 1

			local isModKeyDown = band(outputFlag, ProfileOutput.MOD_KEY_DOWN) == ProfileOutput.MOD_KEY_DOWN
			local isModKeyDownSticky = band(outputFlag, ProfileOutput.MOD_KEY_DOWN_STICKY) == ProfileOutput.MOD_KEY_DOWN_STICKY
			local addPadding = band(outputFlag, ProfileOutput.ADD_PADDING) == ProfileOutput.ADD_PADDING
			local addName = band(outputFlag, ProfileOutput.ADD_NAME) == ProfileOutput.ADD_NAME
			local addLFD = band(outputFlag, ProfileOutput.ADD_LFD) == ProfileOutput.ADD_LFD
			local addFooter = band(outputFlag, ProfileOutput.ADD_FOOTER) == ProfileOutput.ADD_FOOTER
			local addHeader = band(outputFlag, ProfileOutput.ADD_HEADER) == ProfileOutput.ADD_HEADER
			local focusDungeon = band(outputFlag, ProfileOutput.FOCUS_DUNGEON) == ProfileOutput.FOCUS_DUNGEON
			local focusKeystone = band(outputFlag, ProfileOutput.FOCUS_KEYSTONE) == ProfileOutput.FOCUS_KEYSTONE

			if addPadding then
				output[i] = " "
				i = i + 1
			end

			if addName then
				output[i] = format("%s (%s)", profile.name, profile.realm)
				i = i + 1
			end

			if addHeader then
				if dataType == CONST_PROVIDER_DATA_RAIDING then
					output[i] = L.RAIDING_DATA_HEADER
					i = i + 1
				end
			end

			if dataType == CONST_PROVIDER_DATA_MYTHICPLUS then
				local bestRunLines = getBestRunLines(profile, isProfile, addLFD, focusDungeon, focusKeystone, ...)

				if ns.addonConfig.mplusHeadlineMode == MythicPlusHeadlineModes.BEST_RUN then
					output = insertToOutput(output, i, bestRunLines)
					i = i + #bestRunLines
				end

				local scoreLines = GetScoreLines(profile, isProfile, #bestRunLines > 0)
				output = insertToOutput(output, i, scoreLines)
				i = i + #scoreLines

				if ns.addonConfig.showMainsScore then
					if not ns.addonConfig.showMainBestScore then
						-- show current season
						if profile.mplusMainCurrent.score > profile.mplusCurrent.score then
							output[i] = {L.MAINS_SCORE, GetTooltipScore(profile.mplusMainCurrent), 1, 1, 1, GetScoreColor(profile.mplusMainCurrent.score)}
							i = i + 1
						end
					else
						-- show best season and current
						if profile.mplusMainCurrent.score > profile.mplusCurrent.score or profile.mplusMainPrevious.score > profile.mplusCurrent.score then
							local displayedPreviousSeason = false
							if profile.mplusMainCurrent.score < profile.mplusMainPrevious.score then
								displayedPreviousSeason = true
								output[i] = {
									format(L.MAINS_BEST_SCORE_BEST_SEASON, L["SEASON_LABEL_" .. profile.mplusMainPrevious.season]),
									GetTooltipScore(profile.mplusMainPrevious, true),
									1, 1, 1,
									GetPreviousScoreColor(profile.mplusMainPrevious.score)
								}
								i = i + 1
							end

							-- Show current score on modifier (or if previous wasn't shown)
							if profile.mplusMainCurrent.score ~= 0 and (not displayedPreviousSeason or isModKeyDown or isModKeyDownSticky) then
								output[i] = {
									L.CURRENT_MAINS_SCORE,
									GetTooltipScore(profile.mplusMainCurrent),
									1, 1, 1,
									GetScoreColor(profile.mplusMainCurrent.score)
								}
								i = i + 1
							end
						end
					end
				end

				if ns.addonConfig.mplusHeadlineMode ~= MythicPlusHeadlineModes.BEST_RUN then
					output = insertToOutput(output, i, bestRunLines)
					i = i + #bestRunLines
				end

				do
					local timedRunsStartLine = i		-- used to prevent showing more than 2 "Timed Runs" lines

					if profile.keystoneTwentyPlus > 0 then
						output[i] = {L.TIMED_20_RUNS, GetFormattedRunCount(profile.keystoneTwentyPlus, 10), 1, 1, 1, 1, 1, 1}
						i = i + 1
					end

					if profile.keystoneFifteenPlus > 0 then
						output[i] = {L.TIMED_15_RUNS, GetFormattedRunCount(profile.keystoneFifteenPlus, 5), 1, 1, 1, 1, 1, 1}
						i = i + 1
					end

					if profile.keystoneTenPlus > 0 and (i - timedRunsStartLine < 1 or (isModKeyDown or isModKeyDownSticky)) then
						output[i] = {L.TIMED_10_RUNS, GetFormattedRunCount(profile.keystoneTenPlus, 5), 1, 1, 1, 1, 1, 1}
						i = i + 1
					end

					if profile.keystoneFivePlus > 0 and (i - timedRunsStartLine < 1 or (isModKeyDown or isModKeyDownSticky)) then
						output[i] = {L.TIMED_5_RUNS, GetFormattedRunCount(profile.keystoneFivePlus, 5), 1, 1, 1, 1, 1, 1}
						i = i + 1
					end
				end
			end

			if dataType == CONST_PROVIDER_DATA_RAIDING then
				local startOffset = i

				-- current raid progress
				for progIndex = 1, 2 do
					local prog = profile.progress[progIndex]
					if prog then
						-- if they have cleared the raid we show only one line for progress (their best), otherwise we show their 2nd best too
						if progIndex == 1 or isModKeyDown or isModKeyDownSticky or profile.progress[progIndex - 1].progressCount < profile.currentRaid.bossCount then
							output[i] = {
								format("%s %s", profile.currentRaid.shortName, RAID_DIFFICULTY_NAMES[prog.difficulty]),
								format("|c%s%s|r %d/%d", RAID_DIFFICULTY_COLORS[prog.difficulty][4], RAID_DIFFICULTY_SUFFIXES[prog.difficulty], prog.progressCount, profile.currentRaid.bossCount),
								1, 1, 1,
								1, 1, 1
							}

							i = i + 1
						end
					end
				end

				-- main's current raid progress
				if ns.addonConfig.showMainsScore and profile.mainProgress then
					local mainProg = profile.mainProgress[1]
					local bestProg = profile.progress[1]
					if mainProg and bestProg and ((mainProg.difficulty > bestProg.difficulty) or (mainProg.progressCount > bestProg.progressCount)) then
						output[i] = {
							L.MAINS_RAID_PROGRESS,
							format("|c%s%s|r %d/%d", RAID_DIFFICULTY_COLORS[mainProg.difficulty][4], RAID_DIFFICULTY_SUFFIXES[mainProg.difficulty], mainProg.progressCount, profile.currentRaid.bossCount),
							1, 1, 1, 1, 1, 1}
						i = i + 1
					end
				end

				-- previous raid progress
				if i - startOffset == 0 or isModKeyDown or isModKeyDownSticky then
					for progIndex = 1, 2 do
						local prog = profile.previousProgress and profile.previousProgress[progIndex]
						if prog then
							-- for previous progress, only show both if the mod key is down
							if progIndex == 1 or isModKeyDown or isModKeyDownSticky then
								output[i] = {
									format("%s %s", profile.previousRaid.shortName, RAID_DIFFICULTY_NAMES[prog.difficulty]),
									format("|c%s%s|r %d/%d", RAID_DIFFICULTY_COLORS[prog.difficulty][4], RAID_DIFFICULTY_SUFFIXES[prog.difficulty], prog.progressCount, profile.previousRaid.bossCount),
									1, 1, 1,
									1, 1, 1
								}

								i = i + 1
							end
						end
					end
				end
			end

			if addFooter then
				local t = EGG[profile.region]
				if t then

					t = t[profile.realm]
					if t then
						t = t[profile.name]
						if t then
							output[i] = " "
							i = i + 1

							output[i] = {t, "", 0.9, 0.8, 0.5, 1, 1, 1, false}
							i = i + 1
						end
					end
				end

				local expiredType = DB_OUTDATED[dataType][profile.faction]
				if expiredType == "stale" then
					local expiresInHours = floor((DATA_EXPIRED_SECONDS / 60 / 60) - OUTDATED_HOURS[dataType][profile.faction])

					output[i] = " "
					i = i + 1

					local message = ""
					if expiresInHours >= 48 then
						message = format(L.OUTDATED_EXPIRES_IN_DAYS, floor(expiresInHours / 24))
					else
						message = format(L.OUTDATED_EXPIRES_IN_HOURS, expiresInHours)
					end

					output[i] = {message, "", 1, 0.85, 0, 1, 1, 1, false}
					i = i + 1

					message = format(L.OUTDATED_DOWNLOAD_LINK, TEXT_COLOR_START_RAIDERIO .. RAIDERIO_ADDON_DOWNLOAD_URL .. TEXT_COLOR_CLOSE)
					output[i] = {message, "", 1, 1, 1, 1, 1, 1, false}
					i = i + 1

				end
			end

			output.length = i - 1

		end

		return output
	end

	-- Parse input of "GetPlayerProfile"
	-- Can be either :
	-- - name, realm, (faction, (region))
	-- - name, faction
	-- - name
	-- Each of these option above can be followed by either :
	-- - boolean, arg1, arg2, ...
	-- - {boolean, arg1, arg2, ...}}
	local function GetInputPlayerProfile(...)
		local args = {...}
		local queryName, queryRealm, queryFaction, queryRegion, passThroughArg

		for i, arg in pairs(args) do
			local typeArg = type(arg)

			-- if boolean or table, this means that these are the additional arguments
			if typeArg == "boolean" then
				passThroughArg = {select(i, ...)}
				break
			elseif typeArg == "table" then
				passThroughArg = arg
				break
			end

			if typeArg == "string" then
				if i == 1 then
					queryName = arg
				elseif i == 2 then
					queryRealm = arg
				elseif i == 4 then
					queryRegion = arg
				end
			end

			-- Number is always faction
			if typeArg == "number" then
				queryFaction = arg
			end
		end

		return queryName, queryRealm, queryFaction, queryRegion, type(passThroughArg) == "table" and passThroughArg or {}
	end

	-- retrieves the complete player profile from all providers
	function GetPlayerProfile(outputFlag, ...)
		if not dataProvider then
			return
		end

		-- must be a number 0 or larger
		if type(outputFlag) ~= "number" or outputFlag < 1 then
			outputFlag = ProfileOutput.DATA
		end

		local queryName, queryRealm, queryFaction, queryRegion, passThroughArg = GetInputPlayerProfile(...)

		-- lookup name, realm and potentially unit identifier
		local name, realm, unit = GetNameAndRealm(queryName, queryRealm)
		if name and realm then

			-- global flag to avoid caching LFD/instance flagged tooltips everywhere
			if not ns.enableTooltipCaching and band(outputFlag, ProfileOutput.ADD_LFD) ~= ProfileOutput.ADD_LFD then
				outputFlag = bor(outputFlag, ProfileOutput.ADD_LFD)
			end

			-- what modules are we looking into?
			local reqMythicPlus = band(outputFlag, ProfileOutput.MYTHICPLUS) == ProfileOutput.MYTHICPLUS
			local reqRaiding = band(outputFlag, ProfileOutput.RAIDING) == ProfileOutput.RAIDING

			-- profile GUID for this particular request
			local profileGUID = realm .. "-" .. name .. "-" .. outputFlag

			-- return cached table if it exists, and if we are capable of caching this particular tooltip
			local canCacheProfile = band(outputFlag, ProfileOutput.ADD_LFD) ~= ProfileOutput.ADD_LFD and band(outputFlag, ProfileOutput.FOCUS_DUNGEON) ~= ProfileOutput.FOCUS_DUNGEON and band(outputFlag, ProfileOutput.FOCUS_KEYSTONE) ~= ProfileOutput.FOCUS_KEYSTONE and true or false
			if canCacheProfile then
				local cachedProfile = profileCacheTooltip[profileGUID]
				if cachedProfile then
					return cachedProfile, true, true, reqMythicPlus and reqRaiding
				end
			end

			-- unless the flag to specifically ignore the level check, do make sure we only query max level players
			if not IsUnitMaxLevel(unit, true) and band(outputFlag, ProfileOutput.INCLUDE_LOWBIES) ~= ProfileOutput.INCLUDE_LOWBIES then
				return
			end

			-- establish faction for the lookups
			local faction = type(queryFaction) == "number" and queryFaction or GetFaction(unit)

			local isPlayer = queryName == "player"

			if not isPlayer and (DB_OUTDATED[CONST_PROVIDER_DATA_MYTHICPLUS][faction] == "expired" or DB_OUTDATED[CONST_PROVIDER_DATA_RAIDING][faction] == "expired") then
				return
			end

			-- retrieve data from the various data types
			local profile = {}
			local hasData = false
			local localOutputFlag = outputFlag
			local validProviders = {}
			for i = 1, #CONST_PROVIDER_DATA_LIST do
				local dataType = CONST_PROVIDER_DATA_LIST[i]
				if (dataType == CONST_PROVIDER_DATA_MYTHICPLUS and reqMythicPlus) or (dataType == CONST_PROVIDER_DATA_RAIDING and reqRaiding) then
					local data = GetProviderData(dataType, name, realm, faction, queryRegion)
					if data then
						validProviders[#validProviders + 1] = data
					end
				end
			end

			for i = 1, #validProviders do
				local data = validProviders[i]
				local dataType = data.dataType

				hasData = true

				if i == 1 then
					localOutputFlag = bor(localOutputFlag, ProfileOutput.ADD_HEADER)
				else
					-- we don't want padding or names to show between providers when rendering multiple providers
					-- if band(localOutputFlag, ProfileOutput.ADD_PADDING) == ProfileOutput.ADD_PADDING then
					-- 	localOutputFlag = bxor(localOutputFlag, ProfileOutput.ADD_PADDING)
					-- end

					if band(localOutputFlag, ProfileOutput.ADD_NAME) == ProfileOutput.ADD_NAME then
						localOutputFlag = bxor(localOutputFlag, ProfileOutput.ADD_NAME)
					end
				end

				if i == #validProviders then
					-- add the footer to the last provider we render
					localOutputFlag = bor(localOutputFlag, ProfileOutput.ADD_FOOTER)
				end

				profile[dataType] = ShapeProfileData(dataType, data, localOutputFlag, unpack(passThroughArg))
			end

			-- if we only requested specific mythic+ or raiding data we only return that specific table
			if reqMythicPlus and not reqRaiding then
				profile = profile[CONST_PROVIDER_DATA_MYTHICPLUS]
			elseif not reqMythicPlus and reqRaiding then
				profile = profile[CONST_PROVIDER_DATA_RAIDING]
			end

			-- cache profile before returning, if we are allowed to cache this particular tooltip
			if canCacheProfile then
				profileCacheTooltip[profileGUID] = profile

				-- if the unit exists we try to store the fact they don't have a profile
				if _G.RaiderIO_MissingCharacters and not hasData and UnitExists(unit) then
					local realmSlug = GetRealmSlug(realm)
					_G.RaiderIO_MissingCharacters[format("%s-%s-%s", PLAYER_REGION or "", name or "", realmSlug or "")] = true
				end
			end

			return profile, hasData, canCacheProfile, reqMythicPlus and reqRaiding
		end
	end

	-- checks if the player has a profile in any data provider
	function HasPlayerProfile(queryName, queryRealm, queryFaction, queryRegion)
		local name, realm, unit = GetNameAndRealm(queryName, queryRealm)
		if name and realm then
			local faction = type(queryFaction) == "number" and queryFaction or GetFaction(unit)
			local region = (queryRegion ~= nil and queryRegion ~= "" and type(queryRegion) == "string") and queryRegion or nil

			for i = 1, #CONST_PROVIDER_DATA_LIST do
				if GetProviderData(CONST_PROVIDER_DATA_LIST[i], name, realm, faction, region) then
					return true
				end
			end
			return false
		end
	end
end

-- tooltips
local ShowTooltip
local ShowTooltipRegion
local FlushTooltipCache
local UpdateTooltips
do
	-- tooltip related hooks and storage
	local tooltipArgs = {}
	local tooltipHooks = { Wipe = function(tooltip) wipe(tooltipArgs[tooltip]) end }

	-- draws the tooltip based on the returned profile data from the data providers
	local function AppendTooltipLines(tooltip, profile, multipleProviders)
		local added
		if multipleProviders then
			-- iterate the data returned from the modules
			for i = 1, #CONST_PROVIDER_DATA_LIST do
				local output = profile[CONST_PROVIDER_DATA_LIST[i]]
				if output then
					-- iterate everything if this is the last module output, otherwise limit ourselves to the defined length
					for j = 1, output.length do
						-- the line can be a table, thus a double line, or a left aligned line
						local line = output[j]
						if type(line) == "table" then
							tooltip:AddDoubleLine(line[1], line[2], line[3], line[4], line[5], line[6], line[7], line[8], line[9], line[10])
						else
							tooltip:AddLine(line)
						end
						-- we know the tooltip was build successfully
						added = true
					end
				end
			end
		else
			-- only one provider so we have only one table to iterate
			for i = 1, #profile do
				-- the line can be a table, thus a double line, or a left aligned line
				local line = profile[i]
				if type(line) == "table" then
					tooltip:AddDoubleLine(line[1], line[2], line[3], line[4], line[5], line[6], line[7], line[8], line[9], line[10])
				else
					tooltip:AddLine(line)
				end
				-- we know the tooltip was build successfully
				added = true
			end
		end
		return added
	end

	-- shows data on the provided tooltip widget for the particular player
	function ShowTooltip(tooltip, outputFlag, unitOrNameOrNameAndRealm, realmOrNil, factionOrNil, arg1, ...)
		return ShowTooltipRegion(tooltip, outputFlag, unitOrNameOrNameAndRealm, realmOrNil, factionOrNil, nil, arg1, ...)
	end

	function ShowTooltipRegion(tooltip, outputFlag, unitOrNameOrNameAndRealm, realmOrNil, factionOrNil, regionOrNil, arg1, ...)
		-- setup tooltip hook
		if not tooltipHooks[tooltip] then
			tooltipHooks[tooltip] = true
			tooltip:HookScript("OnTooltipCleared", tooltipHooks.Wipe)
			tooltip:HookScript("OnHide", tooltipHooks.Wipe)
			-- setup the re-usable table for this tooltips args cache for future updates
			tooltipArgs[tooltip] = {}
		end

		local name, realm, unit = GetNameAndRealm(unitOrNameOrNameAndRealm, realmOrNil)
		local faction = type(factionOrNil) == "number" and factionOrNil or GetFaction(unit)
		if faction and (DB_OUTDATED[CONST_PROVIDER_DATA_RAIDING][faction] == "expired" or DB_OUTDATED[CONST_PROVIDER_DATA_MYTHICPLUS][faction] == "expired") then
			tooltip:AddLine(" ", 1, 1, 1, false)
			tooltip:AddLine(L.OUTDATED_EXPIRED_TITLE, 1, 0, 0, false)

			local message = format(L.OUTDATED_DOWNLOAD_LINK, TEXT_COLOR_START_RAIDERIO .. RAIDERIO_ADDON_DOWNLOAD_URL .. TEXT_COLOR_CLOSE)
			tooltip:AddLine(message, 1, 1, 1, false)

			if unitOrNameOrNameAndRealm ~= "player" then
				tooltip:Show()
				return true
			end

			-- fall through, means it is the current player who can still see their own tooltip
		end

		-- get the player profile
		local profile, hasProfile, isCached, multipleProviders = GetPlayerProfile(outputFlag, unitOrNameOrNameAndRealm, realmOrNil, factionOrNil, regionOrNil, arg1, ...)
		-- sanity check
		if hasProfile and AppendTooltipLines(tooltip, profile, multipleProviders) then
			-- store tooltip args for refresh purposes
			local tooltipCache = tooltipArgs[tooltip]
			if isCached then
				tooltipCache[1], tooltipCache[2], tooltipCache[3], tooltipCache[4], tooltipCache[5], tooltipCache[6], tooltipCache[7], tooltipCache[8], tooltipCache[9] = true, tooltip, outputFlag, unitOrNameOrNameAndRealm, realmOrNil, factionOrNil, regionOrNil, arg1, ...
			else
				tooltipCache[1], tooltipCache[2], tooltipCache[3], tooltipCache[4], tooltipCache[5], tooltipCache[6], tooltipCache[7], tooltipCache[8], tooltipCache[9] = false, {tooltip, outputFlag, unitOrNameOrNameAndRealm, realmOrNil, factionOrNil, regionOrNil, arg1, ...}
			end
			-- resize tooltip to fit the new contents
			tooltip:Show()
			return true
		end
		return false
	end

	-- updates the visible tooltip
	local function UpdateTooltip(tooltipCache)
		-- unpack the args
		local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 = tooltipCache[1], tooltipCache[2], tooltipCache[3], tooltipCache[4], tooltipCache[5], tooltipCache[6], tooltipCache[7], tooltipCache[8], tooltipCache[9]
		local tooltip
		if arg1 == true then
			tooltip = arg2
		elseif arg1 == false then
			tooltip = arg2[1]
		end
		-- sanity check
		if not tooltip or not tooltip:GetOwner() then return end
		-- units only need to SetUnit to re-draw the tooltip properly
		local _, unit = tooltip:GetUnit()
		if unit then
			tooltip:SetUnit(unit)
			return
		end
		-- gather tooltip information
		local o1, o2, o3, o4 = tooltip:GetOwner()
		local p1, p2, p3, p4, p5 = tooltip:GetPoint(1)
		local a1, a2, a3 = tooltip:GetAnchorType()
		-- try to run the OnEnter handler to simulate the user hovering over and triggering the tooltip
		if o1 then
			local oe = o1:GetScript("OnEnter")
			if oe then
				tooltip:Hide()
				oe(o1)
				return
			end
		end
		-- if nothing else worked, attempt to hide, then show the tooltip again in the same place
		tooltip:Hide()
		if o1 then
			o2 = a1
			if p4 then
				o3 = p4
			end
			if p5 then
				o4 = p5
			end
			tooltip:SetOwner(o1, o2, o3, o4)
		end
		if p1 then
			tooltip:SetPoint(p1, p2, p3, p4, p5)
		end
		if not o1 and a1 then
			tooltip:SetAnchorType(a1, a2, a3)
		end
		-- we need to handle the modifier bit or we'll just re-draw the same one if we've toggled the modifier
		local modBit, modBitIsArg
		if arg1 == true then
			modBit, modBitIsArg = arg3, true
		elseif arg1 == false then
			modBit, modBitIsArg = arg2[2], false
		end
		if modBit then
			if band(modBit, ProfileOutput.MOD_KEY_DOWN) == ProfileOutput.MOD_KEY_DOWN then
				if not addon:IsModifierKeyDown() then
					modBit = bxor(modBit, ProfileOutput.MOD_KEY_DOWN)
				end
			elseif addon:IsModifierKeyDown() then
				modBit = bor(modBit, ProfileOutput.MOD_KEY_DOWN)
			end
			if modBitIsArg then
				arg3 = modBit
			else
				arg2[2] = modBit
			end
		end
		-- finalize by calling the show tooltip API with the same arguments as earlier
		if arg1 == true then
			ShowTooltipRegion(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
		elseif arg1 == false then
			ShowTooltipRegion(unpack(arg2))
		end
	end

	function UpdateTooltips()
		for tooltip, tooltipCache in pairs(tooltipArgs) do
			if tooltip:IsShown() then
				UpdateTooltip(tooltipCache)
			end
		end
		ns.PROFILE_UI.UpdateTooltip()
	end

	function FlushTooltipCache()
		wipe(profileCache)
		wipe(profileCacheTooltip)
	end
end

-- addon events
do
	-- apply hooks to interface elements
	local function ApplyHooks()
		-- iterate backwards, removing hooks as they complete
		for i = #uiHooks, 1, -1 do
			local func = uiHooks[i]
			-- if the function returns true our hook succeeded, we then remove it from the table
			if func() then
				table.remove(uiHooks, i)
			end
		end
	end

	-- an addon has loaded, is it ours? is it some LOD addon we can hook?
	function addon:ADDON_LOADED(event, name)
		-- the addon savedvariables are loaded and we can initialize the addon
		if name == addonName then
			ns.CONFIG.Init()

			-- purge cache after zoning
			ns.addon:RegisterEvent("PLAYER_ENTERING_WORLD")

			-- detect toggling of the modifier keys (additional events to try self-correct if we locked the mod key by using ALT-TAB)
			ns.addon:RegisterEvent("MODIFIER_STATE_CHANGED")

			-- update our state when we enter new places or our LFD activity changes
			ns.addon.LFG_LIST_ACTIVE_ENTRY_UPDATE = addon.CheckLfdAndCurrentInstanceState
			ns.addon.GROUP_ROSTER_UPDATE = addon.CheckLfdAndCurrentInstanceState
			ns.addon.ZONE_CHANGED = addon.CheckLfdAndCurrentInstanceState
			ns.addon.ZONE_CHANGED_NEW_AREA = addon.CheckLfdAndCurrentInstanceState
			ns.addon:RegisterEvent("LFG_LIST_ACTIVE_ENTRY_UPDATE")
			ns.addon:RegisterEvent("GROUP_ROSTER_UPDATE")
			ns.addon:RegisterEvent("ZONE_CHANGED")
			ns.addon:RegisterEvent("ZONE_CHANGED_NEW_AREA")

			-- purge missing players cache at login
			_G.RaiderIO_MissingCharacters = wipe(_G.RaiderIO_MissingCharacters or {})
		end

		-- apply hooks to interface elements
		ApplyHooks()
	end

	-- checks and calculates if the provider is outdated or not, and by how many hours and days
	local function IsProviderOutdated(provider)
		local year, month, day, hours, minutes, seconds = provider.date:match("^(%d+)%-(%d+)%-(%d+)T(%d+):(%d+):(%d+).*Z$")
		-- parse the ISO timestamp to unix time
		local ts = time({ year = year, month = month, day = day, hour = hours, min = minutes, sec = seconds })
		-- calculate the timezone offset between the user and UTC+0
		local offset = GetTimezoneOffset(ts)
		-- find elapsed seconds since database update and account for the timezone offset
		local diff = time() - ts - offset
		-- figure out of the DB is outdated or not by comparing to our threshold
		local outdated = false
		if diff >= DATA_EXPIRED_SECONDS then
			outdated = 'expired'
		elseif diff >= DATA_STALE_SECONDS then
			outdated = 'stale'
		end
		local outdatedHours = floor(diff/ 3600 + 0.5)
		local outdatedDays = floor(diff / 86400 + 0.5)
		return outdated, outdatedHours, outdatedDays
	end

	-- we have logged in and character data is available
	function addon:PLAYER_LOGIN()
		-- do not allow second calls if already called
		if ns.dataProvider then return end

		-- store our faction for later use
		PLAYER_FACTION = GetFaction("player")
		PLAYER_REGION = GetRegion()

		-- share the faction and region with the other modules
		ns.PLAYER_FACTION = PLAYER_FACTION
		ns.PLAYER_REGION = PLAYER_REGION

		-- Now that the config is loaded, update the dungeon's abbreviation locale
		UpdateConstDungeon()

		-- we can now create the empty table that contains all providers and provider groups
		dataProvider = {}

		-- for notification purposes after we're done iterating the provider queue
		local isAnyProviderDesynced
		local isAnyProviderOutdated
		local neededProviderLoaded = 0

		-- pick the data provider that suits the players region
		for i = #dataProviderQueue, 1, -1 do
			local data = dataProviderQueue[i]
			local dataType = data.data

			-- is this provider relevant? (when in debug mode, provider for region different than yours are authorized)
			if data.region == PLAYER_REGION or ns.addonConfig.debugMode == true then
				if dataProvider[data.region] == nil then
					dataProvider[data.region] = {}
				end

				local dataProviderGroup = dataProvider[data.region][dataType]

				if data.region == PLAYER_REGION then
					-- is the provider up to date?
					local dbOutdated, outdatedHours, outdatedDays = IsProviderOutdated(data)
					DB_OUTDATED[dataType][data.faction] = dbOutdated
					OUTDATED_HOURS[dataType][data.faction] = outdatedHours
					OUTDATED_DAYS[dataType][data.faction] = outdatedDays

					-- update the outdated counter with the largest count
					if isOutdated then
						isAnyProviderOutdated = isAnyProviderOutdated and max(isAnyProviderOutdated, outdatedDays) or outdatedDays
					end
				end

				-- Check if our faction is loaded
				if PLAYER_REGION == data.region and PLAYER_FACTION == data.faction then
					neededProviderLoaded = neededProviderLoaded + 1
				end

				-- append provider to the group
				if dataProviderGroup then
					if dataProviderGroup.faction == data.faction and dataProviderGroup.date ~= data.date then
						isAnyProviderDesynced = true
					end
					if not dataProviderGroup.db1 then
						dataProviderGroup.db1 = data.db1
					end
					if not dataProviderGroup.db2 then
						dataProviderGroup.db2 = data.db2
					end
					if not dataProviderGroup.lookup1 then
						dataProviderGroup.lookup1 = data.lookup1
					end
					if not dataProviderGroup.lookup2 then
						dataProviderGroup.lookup2 = data.lookup2
					end

					if dataType == CONST_PROVIDER_DATA_RAIDING then
						if not dataProviderGroup.currentRaid then
							dataProviderGroup.currentRaid = data.currentRaid
						end

						if not dataProviderGroup.previousRaid then
							dataProviderGroup.previousRaid = data.previousRaid
						end
					end
				else
					dataProviderGroup = data
					dataProvider[data.region][dataType] = dataProviderGroup
				end
			else
				-- disable the provider addon from loading in the future
				DisableAddOn(data.name)
				-- wipe the table to free up memory
				wipe(data)
			end

			-- remove reference from the queue
			dataProviderQueue[i] = nil
		end

		if isAnyProviderDesynced then
			DEFAULT_CHAT_FRAME:AddMessage(format(L.OUT_OF_SYNC_DATABASE_S, addonName), 1, 1, 0)
		elseif isAnyProviderOutdated then
			DEFAULT_CHAT_FRAME:AddMessage(format(L.OUTDATED_EXPIRED_ALERT, addonName, RAIDERIO_ADDON_DOWNLOAD_URL), 1, 1, 0)
		end

		if neededProviderLoaded == 0 then
			local _, localizedFaction = UnitFactionGroup("player")

			DEFAULT_CHAT_FRAME:AddMessage(format(L.PROVIDER_NOT_LOADED, addonName, localizedFaction), 1, 1, 0)
		end

		-- hide the provider functions from the public API
		_G.RaiderIO.AddProvider = nil

		-- search.lua needs this for querying
		ns.dataProvider = dataProvider

		-- init the profiler now that the addon is fully loaded
		ns.PROFILE_UI.Init()

		if ns.addonConfig.debugMode == true then
			DEFAULT_CHAT_FRAME:AddMessage(format(L.WARNING_DEBUG_MODE_ENABLE, addonName), 1, 1, 0)
		end
	end

	-- we enter the world (after a loading screen, int/out of instances)
	function addon:PLAYER_ENTERING_WORLD()
		-- we wipe the cached profiles in between loading screens, this seems like a good way get rid of memory use over time
		FlushTooltipCache()
		-- store the character we're logged on (used by the client to queue an update, once we log out from the game of course)
		local name, realm = GetNameAndRealm("player")
		local realmSlug = GetRealmSlug(realm)
		_G.RaiderIO_LastCharacter = format("%s-%s-%s", PLAYER_REGION or "", name or "", realmSlug or "")
		-- force an update when we enter the world
		addon:CheckLfdAndCurrentInstanceState()
	end

	-- modifier key is toggled, update the tooltip if needed
	function addon:MODIFIER_STATE_CHANGED(skipUpdatingTooltip)
		-- if we always draw the full tooltip then this part of the code shouldn't be running at all
		if ns.addonConfig.alwaysExtendTooltip and not ns.addonConfig.enableProfileModifier then
			return
		end
		-- check if the mod state has changed, and only then run the update function
		local m = IsModifierKeyDown()
		local l = addon.modKey
		addon.modKey = m
		if m ~= l and skipUpdatingTooltip ~= true then
			UpdateTooltips()
		end
	end

	-- if the modifier is down, or if the config option makes it always down, this is the func to call to check the state
	function addon:IsModifierKeyDown(skipConfig)
		if skipConfig then
			return IsModifierKeyDown()
		end
		return ns.addonConfig.alwaysExtendTooltip or IsModifierKeyDown()
	end

	-- we relocate and need to check our current state and if we wanna cache tooltips or not
	function addon:CheckLfdAndCurrentInstanceState()
		local numSigned = GetLFDStatus()
		if numSigned == true then
			ns.enableTooltipCaching = false
		elseif numSigned and numSigned > 0 then
			ns.enableTooltipCaching = false
		else
			ns.enableTooltipCaching = not GetInstanceStatus()
		end
		UpdateTooltips()
	end
end

-- ui hooks
do
	-- extract character name and realm from BNet friend
	local function GetNameAndRealmForBNetFriend(bnetIDAccount)
		local index = BNGetFriendIndex(bnetIDAccount)
		if index then
			local numGameAccounts = BNGetNumFriendGameAccounts(index)
			for i = 1, numGameAccounts do
				local _, characterName, client, realmName, _, faction, _, _, _, _, level = BNGetFriendGameAccountInfo(index, i)
				if client == BNET_CLIENT_WOW then
					if realmName then
						characterName = characterName .. "-" .. realmName:gsub("%s+", "")
					end
					return characterName, FACTION[faction], tonumber(level)
				end
			end
		end
	end

	-- copy profile link from dropdown menu
	local function CopyURLForNameAndRealm(...)
		local name, realm = GetNameAndRealm(...)
		local realmSlug = GetRealmSlug(realm)
		local url = format("https://raider.io/characters/%s/%s/%s?utm_source=addon", PLAYER_REGION, realmSlug, name)
		if IsModifiedClick("CHATLINK") then
			local editBox = ChatFrame_OpenChat(url, DEFAULT_CHAT_FRAME)
			editBox:HighlightText()
		else
			StaticPopup_Show("RAIDERIO_COPY_URL", format("%s (%s)", name, realm), url)
		end
	end

	_G.StaticPopupDialogs["RAIDERIO_COPY_URL"] = {
		text = "%s",
		button2 = CLOSE,
		hasEditBox = true,
		hasWideEditBox = true,
		editBoxWidth = 350,
		preferredIndex = 3,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		OnShow = function(self)
			self:SetWidth(420)
			local editBox = _G[self:GetName() .. "WideEditBox"] or _G[self:GetName() .. "EditBox"]
			editBox:SetText(self.text.text_arg2)
			editBox:SetFocus()
			editBox:HighlightText(false)
			local button = _G[self:GetName() .. "Button2"]
			button:ClearAllPoints()
			button:SetWidth(200)
			button:SetPoint("CENTER", editBox, "CENTER", 0, -30)
		end,
		EditBoxOnEscapePressed = function(self)
			self:GetParent():Hide()
		end,
		OnHide = nil,
		OnAccept = nil,
		OnCancel = nil
	}

	-- GameTooltip
	uiHooks[#uiHooks + 1] = function()
		local function OnTooltipSetUnit(self)
			if not ns.addonConfig.enableUnitTooltips then
				return
			end
			if not ns.addonConfig.showScoreInCombat and InCombatLockdown() then
				return
			end
			-- TODO: summoning portals don't always trigger OnTooltipSetUnit properly, leaving the unit tooltip on the portal object
			local _, unit = self:GetUnit()
			ShowTooltipRegion(self, TooltipProfileOutput.PADDING(), unit, nil, GetFaction(unit))
		end
		GameTooltip:HookScript("OnTooltipSetUnit", OnTooltipSetUnit)
		return 1
	end

	-- LFG
	uiHooks[#uiHooks + 1] = function()
		if _G.LFGListApplicationViewerScrollFrameButton1 then
			local hooked = {}
			local OnEnter, OnLeave
			-- application queue
			function OnEnter(self)
				if not ns.addonConfig.enableLFGTooltips then
					return
				end
				if self.applicantID and self.Members then
					for i = 1, #self.Members do
						local b = self.Members[i]
						if not hooked[b] then
							hooked[b] = 1
							b:HookScript("OnEnter", OnEnter)
							b:HookScript("OnLeave", OnLeave)
						end
					end
				elseif self.memberIdx then
					local fullName = C_LFGList.GetApplicantMemberInfo(self:GetParent().applicantID, self.memberIdx)
					if fullName then
						local hasOwner = GameTooltip:GetOwner()
						if not hasOwner then
							GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
						end
						local _, activityID, _, title, description = C_LFGList.GetActiveEntryInfo()
						local keystoneLevel = GetKeystoneLevel(title) or GetKeystoneLevel(description) or 0
						ShowTooltipRegion(GameTooltip, bor(TooltipProfileOutput.PADDING(), ProfileOutput.ADD_LFD), fullName, nil, PLAYER_FACTION, nil, true, LFD_ACTIVITYID_TO_DUNGEONID[activityID], keystoneLevel)
						ns.PROFILE_UI.ShowProfile(fullName, nil, PLAYER_FACTION, PLAYER_REGION, GameTooltip, nil, activityID, keystoneLevel)
					end
				end
			end
			function OnLeave(self)
				if self.applicantID or self.memberIdx then
					GameTooltip:Hide()
				end
			end
			-- search results
			local function SetSearchEntryTooltip(tooltip, resultID, autoAcceptOption)
				if not ns.addonConfig.enableLFGTooltips then
					return
				end
				local results = C_LFGList.GetSearchResultInfo(resultID)
				if not results then
					return
				end
				local activityID = results.activityID
				local leaderName = results.leaderName
				if leaderName then
					local keystoneLevel = 0 -- GetKeystoneLevel(title) or GetKeystoneLevel(description) or 0
					-- Update game tooltip with player info
					ShowTooltip(tooltip, bor(TooltipProfileOutput.PADDING(), ProfileOutput.ADD_LFD), leaderName, nil, PLAYER_FACTION, true, LFD_ACTIVITYID_TO_DUNGEONID[activityID], keystoneLevel)
					ns.PROFILE_UI.ShowProfile(leaderName, nil, PLAYER_FACTION, nil, tooltip, nil, activityID, keystoneLevel)
				end
			end
			hooksecurefunc("LFGListUtil_SetSearchEntryTooltip", SetSearchEntryTooltip)
			-- execute delayed hooks
			for i = 1, 14 do
				local b = _G["LFGListApplicationViewerScrollFrameButton" .. i]
				b:HookScript("OnEnter", OnEnter)
				b:HookScript("OnLeave", OnLeave)
			end
			-- UnempoweredCover blocking removal
			do
				local f = LFGListFrame.ApplicationViewer.UnempoweredCover
				f:EnableMouse(false)
				f:EnableMouseWheel(false)
				f:SetToplevel(false)
			end
			return 1
		end
	end

	-- WhoFrame
	uiHooks[#uiHooks + 1] = function()
		local function OnEnter(self)
			if not ns.addonConfig.enableWhoTooltips then
				return
			end
			if self.index then
                 local info = C_FriendList.GetWhoInfo(self.index)
                 if info and info.fullName and info.level and info.level >= MAX_LEVEL then
					local hasOwner = GameTooltip:GetOwner()
					if not hasOwner then
						GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
					end
					if not ShowTooltip(GameTooltip, bor(TooltipProfileOutput.DEFAULT(), hasOwner and ProfileOutput.ADD_PADDING or 0), info.fullName, nil, PLAYER_FACTION) and not hasOwner then
						GameTooltip:Hide()
					end
				end
			end
		end
		local function OnLeave(self)
			if self.whoIndex then
				GameTooltip:Hide()
			end
		end
		for _, button in pairs(WhoListScrollFrame.buttons) do
			button:HookScript("OnEnter", OnEnter)
			button:HookScript("OnLeave", OnLeave)
		end
		return 1
	end

	-- FriendsFrame
	uiHooks[#uiHooks + 1] = function()
		local function OnEnter(self)
			if not ns.addonConfig.enableFriendsTooltips then
				return
			end
			local fullName, faction, level
			if self.buttonType == FRIENDS_BUTTON_TYPE_BNET then
				local bnetIDAccount = BNGetFriendInfo(self.id)
				if bnetIDAccount then
					fullName, faction, level = GetNameAndRealmForBNetFriend(bnetIDAccount)
				end
			elseif self.buttonType == FRIENDS_BUTTON_TYPE_WOW then
				fullName, level = GetFriendInfo(self.id)
				faction = PLAYER_FACTION
			end
			if fullName and level and level >= MAX_LEVEL then
				GameTooltip:SetOwner(FriendsTooltip, "ANCHOR_BOTTOMRIGHT", -FriendsTooltip:GetWidth(), -4)
				if not ShowTooltip(GameTooltip, TooltipProfileOutput.DEFAULT(), fullName, nil, faction) then
					GameTooltip:Hide()
				end
			else
				GameTooltip:Hide()
			end
		end
		local function FriendTooltip_Hide()
			if not ns.addonConfig.enableFriendsTooltips then
				return
			end
			GameTooltip:Hide()
		end
		local buttons = FriendsListFrameScrollFrame.buttons
		for i = 1, #buttons do
			local button = buttons[i]
			button:HookScript("OnEnter", OnEnter)
		end
		--hooksecurefunc("FriendsFrameTooltip_Show", OnEnter)
		hooksecurefunc(FriendsTooltip, "Hide", FriendTooltip_Hide)
		return 1
	end

	-- Blizzard_GuildUI
	uiHooks[#uiHooks + 1] = function()
		if _G.GuildFrame then
			local function OnEnter(self)
				if not ns.addonConfig.enableGuildTooltips then
					return
				end
				if self.guildIndex then
					local fullName, _, _, level = GetGuildRosterInfo(self.guildIndex)
					if fullName and level >= MAX_LEVEL then
						GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
						if not ShowTooltip(GameTooltip, TooltipProfileOutput.PADDING(), fullName, nil, PLAYER_FACTION) then
							GameTooltip:Hide()
						end
					end
				end
			end
			local function OnLeave(self)
				if self.guildIndex then
					GameTooltip:Hide()
				end
			end
			for i = 1, 16 do
				local b = _G["GuildRosterContainerButton" .. i]
				b:HookScript("OnEnter", OnEnter)
				b:HookScript("OnLeave", OnLeave)
			end
			return 1
		end
	end

	-- Blizzard_Communities
	uiHooks[#uiHooks + 1] = function()
		if _G.CommunitiesFrame then
			local function OnEnter(self)
				if not ns.addonConfig.enableGuildTooltips then
					return
				end
				local info = self:GetMemberInfo()
				if not info or (info.clubType ~= Enum.ClubType.Guild and info.clubType ~= Enum.ClubType.Character) then
					return
				end
				if info.name and (info.level or MAX_LEVEL) >= MAX_LEVEL then
					local hasOwner = GameTooltip:GetOwner()
					if not hasOwner then
						GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
					end
					if not ShowTooltip(GameTooltip, bor(TooltipProfileOutput.DEFAULT(), hasOwner and ProfileOutput.ADD_PADDING or 0), info.name, nil, PLAYER_FACTION) and not hasOwner then
						GameTooltip:Hide()
					end
				end
			end
			local function OnLeave(self)
				GameTooltip:Hide()
			end
			local hooked = {}
			local completed
			local function HookButtons()
				if completed then
					return
				end
				local buttons = _G.CommunitiesFrame.MemberList.ListScrollFrame.buttons
				if not buttons then
					return
				end
				for _, b in pairs(buttons) do
					if not hooked[b] then
						hooked[b] = true
						b:HookScript("OnEnter", OnEnter)
						b:HookScript("OnLeave", OnLeave)
					end
				end
				if next(hooked) then
					completed = true -- one pass seems to create all the buttons
				end
			end
			HookButtons()
			hooksecurefunc(_G.CommunitiesFrame.MemberList, "RefreshLayout", HookButtons)
			return 1
		end
	end

	-- ChatFrame (Who Results)
	uiHooks[#uiHooks + 1] = function()
		local function pattern(pattern)
			pattern = pattern:gsub("%%", "%%%%")
			pattern = pattern:gsub("%.", "%%%.")
			pattern = pattern:gsub("%?", "%%%?")
			pattern = pattern:gsub("%+", "%%%+")
			pattern = pattern:gsub("%-", "%%%-")
			pattern = pattern:gsub("%(", "%%%(")
			pattern = pattern:gsub("%)", "%%%)")
			pattern = pattern:gsub("%[", "%%%[")
			pattern = pattern:gsub("%]", "%%%]")
			pattern = pattern:gsub("%%%%s", "(.-)")
			pattern = pattern:gsub("%%%%d", "(%%d+)")
			pattern = pattern:gsub("%%%%%%[%d%.%,]+f", "([%%d%%.%%,]+)")
			return pattern
		end
		local FORMAT_GUILD = "^" .. pattern(WHO_LIST_GUILD_FORMAT) .. "$"
		local FORMAT = "^" .. pattern(WHO_LIST_FORMAT) .. "$"
		local nameLink, name, level, race, class, guild, zone
		local repl, text, profile
		local function score(profile)
			text = ""

			if profile.mplusCurrent.score > 0 then
				text = text .. (L.RAIDERIO_MP_SCORE .. ": "):gsub("%.", "|cffFFFFFF|r.") .. profile.mplusCurrent.score .. ". "
			end

			-- show the mains season score
			if ns.addonConfig.showMainsScore and profile.mplusMainCurrent.score > profile.mplusCurrent.score then
				text = text .. "(" .. L.MAINS_SCORE .. ": " .. profile.mplusMainCurrent.score .. "). "
			end

			return text
		end
		local function filter(self, event, text, ...)
			if ns.addonConfig.enableWhoMessages and event == "CHAT_MSG_SYSTEM" then
				nameLink, name, level, race, class, guild, zone = text:match(FORMAT_GUILD)
				if not zone then
					guild = nil
					nameLink, name, level, race, class, zone = text:match(FORMAT)
				end
				if level then
					level = tonumber(level) or 0
					if level >= MAX_LEVEL then
						if guild then
							repl = format(WHO_LIST_GUILD_FORMAT, nameLink, name, level, race, class, guild, zone)
						else
							repl = format(WHO_LIST_FORMAT, nameLink, name, level, race, class, zone)
						end
						profile = GetPlayerProfile(ProfileOutput.MYTHICPLUS, nameLink, nil, PLAYER_FACTION)
						if profile then
							repl = repl .. " - " .. score(profile.profile)
						end
						return false, repl, ...
					end
				end
			end
			return false
		end
		ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", filter)
		return 1
	end

	-- DropDownMenu (Units and LFD)
	uiHooks[#uiHooks + 1] = function()
		local function CanCopyURL(which, unit, name, bnetIDAccount)
			if UnitExists(unit) then
				return UnitIsPlayer(unit) and UnitLevel(unit) >= MAX_LEVEL,
					GetUnitName(unit, true) or name,
					"UNIT"
			elseif which and which:find("^BN_") then
				local charName, charFaction, charLevel
				if bnetIDAccount then
					charName, charFaction, charLevel = GetNameAndRealmForBNetFriend(bnetIDAccount)
				end
				return charName and charLevel and charLevel >= MAX_LEVEL,
					bnetIDAccount,
					"BN",
					charName,
					charFaction
			elseif name then
				return true,
					name,
					"NAME"
			end
			return false
		end
		local function ShowCopyURLPopup(kind, query, bnetChar, bnetFaction)
			CopyURLForNameAndRealm(bnetChar or query)
		end
		-- TODO: figure out the type of menus we don't really need to show our copy link button
		local supportedTypes = {
			-- SELF = 1, -- do we really need this? can always target self anywhere else and copy our own url
			PARTY = 1,
			PLAYER = 1,
			RAID_PLAYER = 1,
			RAID = 1,
			FRIEND = 1,
			BN_FRIEND = 1,
			GUILD = 1,
			GUILD_OFFLINE = 1,
			CHAT_ROSTER = 1,
			TARGET = 1,
			ARENAENEMY = 1,
			FOCUS = 1,
			WORLD_STATE_SCORE = 1,
			COMMUNITIES_WOW_MEMBER = 1,
			COMMUNITIES_GUILD_MEMBER = 1,
			SELF = 1
		}
		local OFFSET_BETWEEN = -5 -- default UI makes this offset look nice
		local reskinDropDownList
		do
			local addons = {
				{ -- Aurora
					name = "Aurora",
					func = function(list)
						local F = _G.Aurora[1]
						local menu = _G[list:GetName() .. "MenuBackdrop"]
						local backdrop = _G[list:GetName() .. "Backdrop"]
						if not backdrop.reskinned then
							F.CreateBD(menu)
							F.CreateBD(backdrop)
							backdrop.reskinned = true
						end
						OFFSET_BETWEEN = -1 -- need no gaps so the frames align with this addon
						return 1
					end
				},
			}
			local skinned = {}
			function reskinDropDownList(list)
				if skinned[list] then
					return skinned[list]
				end
				for i = 1, #addons do
					local addon = addons[i]
					if IsAddOnLoaded(addon.name) then
						skinned[list] = addon.func(list)
						break
					end
				end
			end
		end
		local custom
		local function CustomOnShow(self) -- UIDropDownMenuTemplates.xml#257
			local p = self:GetParent() or self
			local w = p:GetWidth()
			local h = 32
			for i = 1, #self.buttons do
				local b = self.buttons[i]
				if b:IsShown() then
					b:SetWidth(w - 32) -- anchor offsets for left/right
					h = h + 16
				end
			end
			self:SetHeight(h)
			return h
		end
		do
			local function CopyOnClick()
				ShowCopyURLPopup(custom.kind, custom.query, custom.bnetChar, custom.bnetFaction)
				CloseDropDownMenus()
			end
			local function UpdateCopyButton()
				local copy = custom.copy
				local copyName = copy:GetName()
				local text = _G[copyName .. "NormalText"]
				text:SetText(L.COPY_RAIDERIO_PROFILE_URL)
				text:Show()
				copy:SetScript("OnClick", CopyOnClick)
				copy:Show()
			end
			local function CustomOnShow(self) -- UIDropDownMenuTemplates.xml#257
				local p = self:GetParent() or self
				local w = p:GetWidth()
				local h = 32
				for i = 1, #self.buttons do
					local b = self.buttons[i]
					if b:IsShown() then
						b:SetWidth(w - 32) -- anchor offsets for left/right
						h = h + 16
					end
				end
				self:SetHeight(h)
			end
			local function CustomButtonOnEnter(self) -- UIDropDownMenuTemplates.xml#155
				_G[self:GetName() .. "Highlight"]:Show()
			end
			local function CustomButtonOnLeave(self) -- UIDropDownMenuTemplates.xml#178
				_G[self:GetName() .. "Highlight"]:Hide()
			end
			custom = CreateFrame("Button", addonName .. "_CustomDropDownList", UIParent, "UIDropDownListTemplate")
			custom:Hide()
			-- attempt to reskin using popular frameworks
			-- skinType = nil : not skinned
			-- skinType = 1 : skinned, apply further visual modifications (the addon does a good job, but we need to iron out some issues)
			-- skinType = 2 : skinned, no need to apply further visual modifications (the addon handles it flawlessly)
			local skinType = reskinDropDownList(custom)
			-- cleanup and modify the default template
			do
				custom:SetScript("OnClick", nil)
				custom:SetScript("OnUpdate", nil)
				custom:SetScript("OnShow", CustomOnShow)
				custom:SetScript("OnHide", nil)
				_G[custom:GetName() .. "Backdrop"]:Hide()
				custom.buttons = {}
				for i = 1, UIDROPDOWNMENU_MAXBUTTONS do
					local b = _G[custom:GetName() .. "Button" .. i]
					if not b then
						break
					end
					custom.buttons[i] = b
					b:Hide()
					b:SetScript("OnClick", nil)
					b:SetScript("OnEnter", CustomButtonOnEnter)
					b:SetScript("OnLeave", CustomButtonOnLeave)
					b:SetScript("OnEnable", nil)
					b:SetScript("OnDisable", nil)
					b:SetPoint("TOPLEFT", custom, "TOPLEFT", 16, -16 * i)
					local t = _G[b:GetName() .. "NormalText"]
					t:ClearAllPoints()
					t:SetPoint("TOPLEFT", b, "TOPLEFT", 0, 0)
					t:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", 0, 0)
					_G[b:GetName() .. "Check"]:SetAlpha(0)
					_G[b:GetName() .. "UnCheck"]:SetAlpha(0)
					_G[b:GetName() .. "Icon"]:SetAlpha(0)
					_G[b:GetName() .. "ColorSwatch"]:SetAlpha(0)
					_G[b:GetName() .. "ExpandArrow"]:SetAlpha(0)
					_G[b:GetName() .. "InvisibleButton"]:SetAlpha(0)
				end
				custom.copy = custom.buttons[1]
				UpdateCopyButton()
			end
		end
		local function ShowCustomDropDown(list, dropdown, name, unit, which, bnetIDAccount)
			local show, query, kind, bnetChar, bnetFaction = CanCopyURL(which, unit, name, bnetIDAccount)
			if not show then
				return custom:Hide()
			end
			-- assign data for use with the copy function
			custom.query = query
			custom.kind = kind
			custom.bnetChar = bnetChar
			custom.bnetFaction = bnetFaction
			-- set positioning under the active dropdown
			custom:SetParent(list)
			custom:SetFrameStrata(list:GetFrameStrata())
			custom:SetFrameLevel(list:GetFrameLevel() + 2)
			custom:ClearAllPoints()
			local dw, dh = list:GetSize()
			local cw, ch = custom:GetSize()
			cw = dw
			if ch < 1 then
				ch = CustomOnShow(custom)
			end
			list:SetHeight(dh + ch + OFFSET_BETWEEN)
			custom:SetPoint("BOTTOMLEFT", list, "BOTTOMLEFT", 0, 0)
			custom:SetPoint("BOTTOMRIGHT", list, "BOTTOMRIGHT", 0, 0)
			--[=[
			if list:GetBottom() >= 50 then
				custom:SetPoint("TOPLEFT", list, "BOTTOMLEFT", 0, OFFSET_BETWEEN)
				custom:SetPoint("TOPRIGHT", list, "BOTTOMRIGHT", 0, OFFSET_BETWEEN)
			else
				custom:SetPoint("BOTTOMLEFT", list, "TOPLEFT", 0, OFFSET_BETWEEN)
				custom:SetPoint("BOTTOMRIGHT", list, "TOPRIGHT", 0, OFFSET_BETWEEN)
			end
			--]=]
			custom:Show()
		end
		local function HideCustomDropDown()
			custom:Hide()
		end
		local function OnShow(self)
			local dropdown = self.dropdown
			if not dropdown then
				return
			end
			if dropdown.Button == _G.LFGListFrameDropDownButton then -- LFD
				if ns.addonConfig.enableLFGDropdown then
					ShowCustomDropDown(self, dropdown, dropdown.menuList[2].arg1)
				end
			elseif dropdown.which and supportedTypes[dropdown.which] then -- UnitPopup
				if ns.addonConfig.showDropDownCopyURL then
					local dropdownFullName
					if dropdown.name then
						if dropdown.server and not dropdown.name:find("-") then
							dropdownFullName = dropdown.name .. "-" .. dropdown.server
						else
							dropdownFullName = dropdown.name
						end
					end
					ShowCustomDropDown(self, dropdown, dropdown.chatTarget or dropdownFullName, dropdown.unit, dropdown.which, dropdown.bnetIDAccount)
				end
			end
		end
		local function OnHide()
			HideCustomDropDown()
		end
		DropDownList1:HookScript("OnShow", OnShow)
		DropDownList1:HookScript("OnHide", OnHide)
		--[=[
		-- https://github.com/Gethe/wow-ui-source/commit/356d028f9d245f6e75dc8a806deb3c38aa0aa77f#diff-4c5ca6424de48e2c9b959163c421d767R1145
		local originalFunction = UIDropDownMenu_HandleGlobalMouseEvent
		UIDropDownMenu_HandleGlobalMouseEvent = function (button, event)
			if event == "GLOBAL_MOUSE_DOWN" and (button == "LeftButton" or button == "RightButton") then
				if custom:IsShown() and custom:IsMouseOver() then
					return
				end
			end
			originalFunction(button, event)
		end
		--]=]
		return 1
	end

	-- Keystone Info
	uiHooks[#uiHooks + 1] = function()
		local KEYSTONE_PATTERNS = {
			"keystone:%d+:(.-):(.-):(.-):(.-):(.-)",
			"item:158923:.-:.-:.-:.-:.-:.-:.-:.-:.-:.-:.-:.-:(.-):(.-):(.-):(.-):(.-):(.-)"
		}
		local function SortByLevelDesc(a, b)
			if a[2] == b[2] then
				if a[3] == b[3] then
					return a[1] < b[1]
				end
				return a[3] < b[3]
			end
			return a[2] > b[2]
		end
		local function OnSetItem(tooltip)
			if not ns.addonConfig.enableKeystoneTooltips then return end

			local _, link = tooltip:GetItem()
			if type(link) ~= "string" then return end

			local inst, lvl, a1, a2, a3, a4
			for i = 1, #KEYSTONE_PATTERNS do
				inst, lvl, a1, a2, a3, a4 = link:match(KEYSTONE_PATTERNS[i])
				if inst and lvl then
					inst, lvl, a1, a2, a3, a4 = tonumber(inst) or 0, tonumber(lvl) or 0, tonumber(a1) or 0, tonumber(a2) or 0, tonumber(a3) or 0, tonumber(a4) or 0
					if inst > 0 and lvl > 0 then
						break
					end
				end
				inst, lvl, a1, a2, a3, a4 = nil
			end
			if not lvl then return end

			local baseScore = KEYSTONE_LEVEL_TO_BASE_SCORE[lvl]
			if not baseScore then return end

			tooltip:AddLine(" ")
			tooltip:AddDoubleLine(L.RAIDERIO_MP_BASE_SCORE, baseScore, 1, 0.85, 0, 1, 1, 1)

			if ns.addonConfig.showAverageScore then
				local avgScore = CONST_AVERAGE_SCORE[lvl]
				if avgScore then
					tooltip:AddDoubleLine(format(L.RAIDERIO_AVERAGE_PLAYER_SCORE, lvl), avgScore, 1, 1, 1, GetScoreColor(avgScore))
				end
			end

			if not inst then tooltip:Show() return end

			local index = KEYSTONE_INST_TO_DUNGEONID[inst]
			if not index then tooltip:Show() return end

			local n = GetNumGroupMembers()
			if n > 5 then tooltip:Show() return end

			local t = {}
			local j = 0

			for i = 0, n do
				local unit = i == 0 and "player" or "party" .. i
				local playerData = GetPlayerProfile(ProfileOutput.MYTHICPLUS, unit)
				if playerData then
					local profile = playerData.profile
					if profile then
						local level = profile.dungeons[index]
						if level > 0 then
							local dungeon = CONST_DUNGEONS[index]
							j = j + 1
							t[j]= { UnitName(unit), level, dungeon and " " .. dungeon.shortNameLocale or "" }
						end
					end
				end
			end

			if j > 0 then
				table.sort(t, SortByLevelDesc)
				for i = 1, j do
					local name, level, dungeonName = t[i][1], t[i][2], t[i][3]
					tooltip:AddDoubleLine(name, "+" .. level .. dungeonName, 1, 1, 1, 1, 1, 1)
				end
			end

			tooltip:Show()
		end
		GameTooltip:HookScript("OnTooltipSetItem", OnSetItem)
		ItemRefTooltip:HookScript("OnTooltipSetItem", OnSetItem)
		return 1
	end

	-- My Profile
	uiHooks[#uiHooks + 1] = function()
		if _G.PVEFrame then
			local function Show()
				if not ns.addonConfig.showRaiderIOProfile then return end
				ns.PROFILE_UI.ShowProfile("player", nil, PLAYER_FACTION)
			end
			local function Hide()
				ns.PROFILE_UI.HideProfile()
			end
			PVEFrame:HookScript("OnShow", Show)
			PVEFrame:HookScript("OnHide", Hide)
			return 1
		end
	end

	-- Guild Weekly Best
	uiHooks[#uiHooks + 1] = function()
		if _G.ChallengesFrame and _G.PVEFrame then
			local function Refresh()
				if not ns.addonConfig.showClientGuildBest then ns.GUILD_BEST_FRAME:Hide() return end
				ns.GUILD_BEST_FRAME:Refresh()
			end
			ChallengesFrame:HookScript("OnShow", Refresh)
			PVEFrame:HookScript("OnShow", Refresh)
			return 1
		end
	end
end

-- private API
do
	ns.LFD_ACTIVITYID_TO_DUNGEONID = LFD_ACTIVITYID_TO_DUNGEONID
	ns.CONST_DUNGEONS = CONST_DUNGEONS
	ns.DB_OUTDATED = DB_OUTDATED
	ns.OUTDATED_DAYS = OUTDATED_DAYS
	ns.OUTDATED_HOURS = OUTDATED_HOURS
	ns.RAID_DIFFICULTY_NAMES = RAID_DIFFICULTY_NAMES
	ns.RAID_DIFFICULTY_SUFFIXES = RAID_DIFFICULTY_SUFFIXES
	ns.RAID_DIFFICULTY_COLORS = RAID_DIFFICULTY_COLORS
	ns.GetRaidDifficultyColor = GetRaidDifficultyColor
	ns.CompareDungeon = CompareDungeon
	ns.GetDungeonWithData = GetDungeonWithData
	ns.GetNameAndRealm = GetNameAndRealm
	ns.GetFaction = GetFaction
	ns.GetRealmSlug = GetRealmSlug
	ns.GetStarsForUpgrades = GetStarsForUpgrades
	ns.ProfileOutput = ProfileOutput
	ns.TooltipProfileOutput = TooltipProfileOutput
	ns.MythicPlusHeadlineModes = MythicPlusHeadlineModes
	ns.GetPlayerProfile = GetPlayerProfile
	ns.HasPlayerProfile = HasPlayerProfile
	ns.ShowTooltip = ShowTooltip
	ns.ShowTooltipRegion = ShowTooltipRegion
	ns.FlushTooltipCache = FlushTooltipCache
	ns.UpdateConstDungeon = UpdateConstDungeon
end

-- mirror certain data exposed in the public API to avoid external users changing our internal data
local EXTERNAL_ProfileOutput
local EXTERNAL_TooltipProfileOutput
local EXTERNAL_CONST_PROVIDER_INTERFACE
do
	local function CloneTable(t)
		local n = {}
		for k, v in pairs(t) do
			n[k] = v
		end
		return n
	end

	EXTERNAL_ProfileOutput = CloneTable(ProfileOutput)
	EXTERNAL_TooltipProfileOutput = CloneTable(TooltipProfileOutput)
	EXTERNAL_CONST_PROVIDER_INTERFACE = CloneTable(CONST_PROVIDER_INTERFACE)
end

-- deprecated warning system with user notification for the first call
local WrapDeprecatedFunc
do
	local notified = {}

	-- case insensitive pattern returns the probably path to addon and file, along with the line of the caused error
	local function GetAddOnNameAndFile(raw)
		if type(raw) ~= "string" then return end
		return (raw:match("^\s*[Ii][Nn][Tt][Ee][Rr][Ff][Aa][Cc][Ee][\\/]+[Aa][Dd][Dd][Oo][Nn][Ss][\\/]+(.-\:%d+)\:"))
	end

	-- attempts to extract the error from the first six error lines (first one always blames this function so we ignore it)
	local function GetCallingAddOnName(stack)
		local _, c1, c2, c3, c4, c5, c6 = ("[\r\n]+"):split(stack)
		c1, c2, c3, c4, c5, c6 = GetAddOnNameAndFile(c1), GetAddOnNameAndFile(c2), GetAddOnNameAndFile(c3), GetAddOnNameAndFile(c4), GetAddOnNameAndFile(c5), GetAddOnNameAndFile(c6)
		local file = c1 or c2 or c3 or c4 or c5 or c6
		return file and file:match("^%s*(.-)%s*[%\\%/]") or L.API_DEPRECATED_UNKNOWN_ADDON, file or L.API_DEPRECATED_UNKNOWN_FILE
	end

	-- writes a notification about the particular API call but only once per session
	local function Notify(funcName, newFuncName, stack)
		if notified[funcName] then return end
		local addon, file = GetCallingAddOnName(stack)
		if not addon then return end
		notified[funcName] = true
		DEFAULT_CHAT_FRAME:AddMessage(format(L[newFuncName and "API_DEPRECATED_WITH" or "API_DEPRECATED"], addon, funcName, addon, newFuncName or file or "?", file or "?"), 1, 1, 0)
	end

	-- wraps the deprecated function and calls the new API with the appropriate arguments
	function WrapDeprecatedFunc(funcName, newFuncName)
		return function(...)
			Notify(funcName, newFuncName, debugstack())
			local d = GetPlayerProfile(ProfileOutput.DATA, ...)
			local output = { mythicPlus = nil, raiding = nil }
			if d then
				local r

				r = d[CONST_PROVIDER_DATA_MYTHICPLUS]
				if r then output.mythicPlus = r.profile end

				r = d[CONST_PROVIDER_DATA_RAIDING]
				if r then output.raiding = r.profile end
			end
			return output
		end
	end
end

-- public API
_G.RaiderIO = {

	-- This collection of API is used with GetPlayerProfile to properly output the data you wish to see:
	--
	-- ProfileOutput
	--   A collection of bit fields you can use to combine different types of data you wish to retrieve, or customize the tooltip drawn on the specific GameTooltip widget.
	-- TooltipProfileOutput
	--   A collection of functions you can call to dynamically build a combination of bit fields used in ProfileOutput that also respect the modifier key usage and config.
	-- DataProvider
	--   A collection of different ID's that are the supported data providers. The profile function if multiple data types are queried will return a group back with dataType properties defined.
	-- HasPlayerProfile
	--   A function that can be used to figure out if Raider.IO knows about a specific unit or player, or not. If true it means there is data that can be queried using the profile function.
	-- GetPlayerProfile
	--   A function that returns a table with different data types, based on the type of query specified. Use the explanations above to build the query you need.
	--
	-- RaiderIO.HasPlayerProfile(unitOrNameOrNameRealm, realmOrNil, factionOrNil, [regionOrNil]) => true | false
	--   unitOrNameOrNameRealm = "player", "target", "raid1", "Joe" or "Joe-ArgentDawn"
	--   realmOrNil            = "ArgentDawn" or nil. Can be nil if realm is part of unitOrNameOrNameRealm, or if it's the same realm as the currently logged in character
	--   factionOrNil          = 1 for Alliance, 2 for Horde, or nil for automatic (looks up both factions, first found is used)
	--   regionOrNil           = "eu", "us", "kr", "tw", or nil for automatic (default to current region) - only useful when debugMode is enable
	--
	-- RaiderIO.GetPlayerProfile(outputFlag, unitOrNameOrNameRealm, realmOrNil, factionOrNil, regionOrNil, ...) => nil | profile, hasData, isCached, hasDataFromMultipleProviders
	--   outputFlag  = a number generated by one of the functions in TooltipProfileOutput, or a bit.bor you create using ProfileOutput as described above.
	--
	-- RaiderIO.GetPlayerProfile(0, "target")
	-- RaiderIO.GetPlayerProfile(0, "Joe")
	-- RaiderIO.GetPlayerProfile(0, "Joe-ArgentDawn")
	-- RaiderIO.GetPlayerProfile(0, "Joe", "ArgentDawn")
	-- RaiderIO.GetPlayerProfile(0, "Joe", "ArgentDawn", nil, "eu")
	--
	ProfileOutput = EXTERNAL_ProfileOutput,
	TooltipProfileOutput = EXTERNAL_TooltipProfileOutput,
	DataProvider = EXTERNAL_CONST_PROVIDER_INTERFACE,
	HasPlayerProfile = HasPlayerProfile,
	GetPlayerProfile = GetPlayerProfile,

	-- Use this to draw on a specific GameTooltip widget the same way Raider.IO draws its own tooltips.
	-- ShowTooltip(GameTooltip, outputFlag, ...) => true | false
	--   Use the same API as used in GetPlayerProfile, with the exception of the first two arguments:
	--     GameTooltip = the tooltip widget you wish to work with
	--     outputFlag  = a number generated by one of the functions in TooltipProfileOutput, or a bit.bor you create using ProfileOutput as described above.
	-- RaiderIO.ShowTooltip(GameTooltip, RaiderIO.TooltipProfileOutput.DEFAULT(), "target")
	ShowTooltip = ShowTooltip,

	-- Returns a table containing the RGB values for the specified score.
	-- RaiderIO.GetScoreColor(5000) => { 1, 0.5, 0 }
	GetScoreColor = GetScoreColor,

	-- Returns a table containing the RGB values for the specified raid difficulty (1 = normal, 2 = heroic, 3 = mythic)
	GetRaidDifficultyColor = GetRaidDifficultyColor,

	-- DEPRECATED: use the new API above instead
	GetScore = WrapDeprecatedFunc("GetScore", "GetPlayerProfile"),
	GetProfile = WrapDeprecatedFunc("GetProfile", "GetPlayerProfile"),

}

-- PLEASE DO NOT USE (we need it public for the sake of the database modules)
_G.RaiderIO.AddProvider = AddProvider

-- register events and wait for the addon load event to fire
addon:SetScript("OnEvent", function(_, event, ...) addon[event](addon, event, ...) end)
addon:RegisterEvent("ADDON_LOADED")

-- DOESN'T DO ANYTHING AND WILL BE REMOVED ONCE SERVER SIDE IS PATCHED
_G.RaiderIO.AddClientCharacters = function() end
_G.RaiderIO.AddClientGuilds = function() end
