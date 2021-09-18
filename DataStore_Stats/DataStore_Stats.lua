--[[	*** DataStore_Stats ***
Written by : Thaoky, EU-Marécages de Zangar
July 18th, 2009
--]]
if not DataStore then return end

local addonName = "DataStore_Stats"

_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0")

local addon = _G[addonName]

local AddonDB_Defaults = {
	global = {
		Characters = {
			['*'] = {				-- ["Account.Realm.Name"] 
				lastUpdate = nil,
				Stats = {},
				SeasonBestMaps = {},
				SeasonBestMapsOvertime = {},
				WeeklyBestMaps = {},
				WeeklyBestKeystone = {},
				
				dungeonScore = 0,					-- Mythic+ dungeon score
			}
		}
	}
}

-- *** Scanning functions ***
local function ScanStats()
	local stats = addon.ThisCharacter.Stats
	wipe(stats)
	
	stats["HealthMax"] = UnitHealthMax("player")
	-- info on power types here : http://www.wowwiki.com/API_UnitPowerType
	stats["MaxPower"] = UnitPowerType("player") .. "|" .. UnitPowerMax("player")
	
	local t = {}

	-- *** base stats ***
	for i = 1, 4 do
		t[i] = UnitStat("player", i)
		-- stat, effectiveStat, posBuff, negBuff = UnitStat("player", statIndex);
	end
	t[5] = UnitArmor("player")
	stats["Base"] = table.concat(t, "|")	--	["Base"] = "strength | agility | stamina | intellect | spirit | armor"
	
	-- *** melee stats ***
	local minDmg, maxDmg = UnitDamage("player")
	t[1] = floor(minDmg) .."-" ..ceil(maxDmg)				-- Damage "215-337"
	t[2] = UnitAttackSpeed("player")
	t[3] = UnitAttackPower("player")
	t[4] = GetCombatRating(CR_HIT_MELEE)
	t[5] = GetCritChance()
	t[6] = GetExpertise()
	stats["Melee"] = table.concat(t, "|")	--	["Melee"] = "Damage | Speed | Power | Hit rating | Crit chance | Expertise"
	
	-- *** ranged stats ***
	local speed
	speed, minDmg, maxDmg = UnitRangedDamage("player")
	t[1] = floor(minDmg) .."-" ..ceil(maxDmg)
	t[2] = speed
	t[3] = UnitRangedAttackPower("player")
	t[4] = GetCombatRating(CR_HIT_RANGED)
	t[5] = GetRangedCritChance()
	t[6] = nil
	stats["Ranged"] = table.concat(t, "|")	--	["Ranged"] = "Damage | Speed | Power | Hit rating | Crit chance"
	
	-- *** spell stats ***
	t[1] = GetSpellBonusDamage(2)			-- 2, since 1 = physical damage
	t[2] = GetSpellBonusHealing()
	t[3] = GetCombatRating(CR_HIT_SPELL)
	t[4] = GetSpellCritChance(2)
	t[5] = GetCombatRating(CR_HASTE_SPELL)
	t[6] = floor(GetManaRegen() * 5.0)
	stats["Spell"] = table.concat(t, "|")	--	["Spell"] = "+Damage | +Healing | Hit | Crit chance | Haste | Mana Regen"
		
	-- *** defenses stats ***
	t[1] = UnitArmor("player")
	-- t[2] = UnitDefense("player")	deprecated in 8.0
	t[2] = 0
	t[3] = GetDodgeChance()
	t[4] = GetParryChance()
	t[5] = GetBlockChance()
	t[6] = GetCombatRating(COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN)
	stats["Defense"] = table.concat(t, "|")	--	["Defense"] = "Armor | Defense | Dodge | Parry | Block | Resilience"

	-- *** PVP Stats ***
	t[1], t[2] = GetPVPLifetimeStats()
	t[3] = nil
	t[4] = nil
	t[5] = nil
	t[6] = nil
	stats["PVP"] = table.concat(t, "|")	--	["PVP"] = "honorable kills | dishonorable kills"
	
	-- *** Arena Teams ***
	--[[
	for i = 1, MAX_ARENA_TEAMS do
		local teamName, teamSize = GetArenaTeam(i)
		if teamName then
			stats["Arena"..teamSize] = table.concat({ GetArenaTeam(i) }, "|")
			-- more info here : http://www.wowwiki.com/API_GetArenaTeam
		end
	end
	--]]
	
	addon.ThisCharacter.lastUpdate = time()
end

local function ScanMythicPlusBestForMapInfo()
	local char = addon.ThisCharacter
	wipe(char.WeeklyBestMaps)
	wipe(char.WeeklyBestKeystone)
	wipe(char.SeasonBestMaps)
	wipe(char.SeasonBestMapsOvertime)
	
	-- Get the dungeons
	local maps = C_ChallengeMode.GetMapTable()
	if not maps then return end

	local bestTime = 999999
	local bestLevel = 0
	local bestMapID
	
	-- Loop through maps
	for i = 1, #maps do
		local mapID = maps[i]
		local name, _, _, texture = C_ChallengeMode.GetMapUIInfo(mapID)
		
		-- Weekly Best
		local durationSec, level = C_MythicPlus.GetWeeklyBestForMap(mapID)
		
		if level then
			-- save this map's info
			char.WeeklyBestMaps[mapID] = {}
			local mapInfo = char.WeeklyBestMaps[mapID]

			mapInfo.name = name
			mapInfo.level = level
			mapInfo.timeInSeconds = durationSec
			mapInfo.texture = texture
			
			-- Is it the best ?
			if (level > bestLevel) or ((level == bestLevel) and (durationSec < bestTime)) then
				bestTime = durationSec
				bestLevel = level
				bestMapID = mapID
			end
		end

		-- Season Best
		local intimeInfo, overtimeInfo = C_MythicPlus.GetSeasonBestForMap(mapID)
		if intimeInfo and intimeInfo.level then
			char.SeasonBestMaps[mapID] = {}
			local mapInfo = char.SeasonBestMaps[mapID]

			mapInfo.name = name
			mapInfo.level = intimeInfo.level
			mapInfo.timeInSeconds = intimeInfo.durationSec
			mapInfo.texture = texture
		end
		
		if overtimeInfo and overtimeInfo.level then
			char.SeasonBestMapsOvertime[mapID] = {}
			local mapInfo = char.SeasonBestMapsOvertime[mapID]

			mapInfo.name = name
			mapInfo.level = overtimeInfo.level
			mapInfo.timeInSeconds = overtimeInfo.durationSec
			mapInfo.texture = texture
		end
		
	end
	
	-- Save the best map info
	if bestMapID then
		local name = C_ChallengeMode.GetMapUIInfo(bestMapID)
		local keyInfo = char.WeeklyBestKeystone
		
		keyInfo.name = name
		keyInfo.level = bestLevel
		keyInfo.timeInSeconds = bestTime
	end

	char.lastUpdate = time()
	
	char.dungeonScore = C_ChallengeMode.GetOverallDungeonScore()
end

-- *** Event Handlers ***
local function OnPlayerAlive()
	ScanStats()
	
	-- This call will trigger the "CHALLENGE_MODE_MAPS_UPDATE" event
	-- It is necessary to ensure that the proper best times are read, because when logging on a character, it could still
	-- show the best times of the previous alt until the event is triggered. So clearly, on alt can read another alt's data.
	-- To avoid this, trigger the event from here (not before PLAYER_ALIVE, it's too soon)
	C_MythicPlus.RequestMapInfo()
end

local function OnWeeklyRewardsUpdate()
	ScanMythicPlusBestForMapInfo()
end

local function OnChallengeModeMapsUpdate()
	ScanMythicPlusBestForMapInfo()
end

-- ** Mixins **
local function _GetStats(character, statType)
	local data = character.Stats[statType]
	if not data then return end
	
	return strsplit("|", data)
	
	-- if there's a need to automate the tonumber of each var, do this ( improve it), since most of the time, these data will be used for display purposes, strings are acceptable
	-- local var1, var2, var3, var4, var5, var6 = strsplit("|", data)
	-- return tonumber(var1), tonumber(var2), tonumber(var3), tonumber(var4), tonumber(var5), tonumber(var6)
end

local function _GetWeeklyBestKeystoneName(character)
	return character.WeeklyBestKeystone.name or ""
end

local function _GetWeeklyBestKeystoneLevel(character)
	return character.WeeklyBestKeystone.level or 0
end

local function _GetWeeklyBestKeystoneTime(character)
	return character.WeeklyBestKeystone.timeInSeconds or 0
end

local function _GetWeeklyBestMaps(character)
	return character.WeeklyBestMaps
end

local function _GetSeasonBestMaps(character)
	return character.SeasonBestMaps
end

local function _GetSeasonBestMapsOvertime(character)
	return character.SeasonBestMapsOvertime
end

local function _GetDungeonScore(character)
	return character.dungeonScore
end

local PublicMethods = {
	GetStats = _GetStats,
	GetWeeklyBestKeystoneName = _GetWeeklyBestKeystoneName,
	GetWeeklyBestKeystoneLevel = _GetWeeklyBestKeystoneLevel,
	GetWeeklyBestKeystoneTime = _GetWeeklyBestKeystoneTime,
	GetWeeklyBestMaps = _GetWeeklyBestMaps,
	GetSeasonBestMaps = _GetSeasonBestMaps,
	GetSeasonBestMapsOvertime = _GetSeasonBestMapsOvertime,
	GetDungeonScore = _GetDungeonScore,
}

function addon:OnInitialize()
	addon.db = LibStub("AceDB-3.0"):New(addonName .. "DB", AddonDB_Defaults)

	DataStore:RegisterModule(addonName, addon, PublicMethods)
	DataStore:SetCharacterBasedMethod("GetStats")
	DataStore:SetCharacterBasedMethod("GetWeeklyBestKeystoneName")
	DataStore:SetCharacterBasedMethod("GetWeeklyBestKeystoneLevel")
	DataStore:SetCharacterBasedMethod("GetWeeklyBestKeystoneTime")
	DataStore:SetCharacterBasedMethod("GetWeeklyBestMaps")
	DataStore:SetCharacterBasedMethod("GetSeasonBestMaps")
	DataStore:SetCharacterBasedMethod("GetSeasonBestMapsOvertime")
	DataStore:SetCharacterBasedMethod("GetDungeonScore")
end

function addon:OnEnable()
	addon:RegisterEvent("PLAYER_ALIVE", OnPlayerAlive)
	addon:RegisterEvent("UNIT_INVENTORY_CHANGED", ScanStats)
	addon:RegisterEvent("WEEKLY_REWARDS_UPDATE", OnWeeklyRewardsUpdate)
	addon:RegisterEvent("CHALLENGE_MODE_MAPS_UPDATE", OnChallengeModeMapsUpdate)
end

function addon:OnDisable()
	addon:UnregisterEvent("PLAYER_ALIVE")
	addon:UnregisterEvent("UNIT_INVENTORY_CHANGED")
	addon:UnregisterEvent("WEEKLY_REWARDS_UPDATE")
	addon:UnregisterEvent("CHALLENGE_MODE_MAPS_UPDATE")
end
