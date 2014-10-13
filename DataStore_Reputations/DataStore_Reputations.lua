--[[	*** DataStore_Reputations ***
Written by : Thaoky, EU-Marécages de Zangar
June 22st, 2009
--]]
if not DataStore then return end

local addonName = "DataStore_Reputations"

_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0")

local addon = _G[addonName]


local THIS_ACCOUNT = "Default"

local AddonDB_Defaults = {
	global = {
		Characters = {
			['*'] = {				-- ["Account.Realm.Name"] 
				lastUpdate = nil,
				guildName = nil,		-- nil = not in a guild, as returned by GetGuildInfo("player")
				guildRep = nil,
				Factions = {},
			}
		}
	}
}

-- ** Reference tables **
local BottomLevelNames = {
	[-42000] = FACTION_STANDING_LABEL1,	 -- "Hated"
	[-6000] = FACTION_STANDING_LABEL2,	 -- "Hostile"
	[-3000] = FACTION_STANDING_LABEL3,	 -- "Unfriendly"
	[0] = FACTION_STANDING_LABEL4,		 -- "Neutral"
	[3000] = FACTION_STANDING_LABEL5,	 -- "Friendly"
	[9000] = FACTION_STANDING_LABEL6,	 -- "Honored"
	[21000] = FACTION_STANDING_LABEL7,	 -- "Revered"
	[42000] = FACTION_STANDING_LABEL8,	 -- "Exalted"
}

local BottomLevels = { -42000, -6000, -3000, 0, 3000, 9000, 21000, 42000 }

--[[	*** Faction UIDs ***
These UIDs have 2 purposes: 
- avoid saving numerous copies of the same string (the faction name)
- minimize the amount of data sent across the network when sharing accounts (since both sides have the same reference table)

Note: Let the system manage the ids, DO NOT delete entries from this table, if a faction is removed from the game, mark it as OLD_ or whatever.
--]]
local FactionUIDs = {
	69,	-- "Darnassus"
	930,	-- "Exodar"
	54,	-- "Gnomeregan"
	47,	-- "Ironforge"
	72,	-- "Stormwind"
	530,	-- "Darkspear Trolls"
	76,	-- "Orgrimmar"
	81,	-- "Thunder Bluff"
	68,	-- "Undercity"
	911,	-- "Silvermoon City"
	509,	-- "The League of Arathor"
	890,	-- "Silverwing Sentinels"
	730,	-- "Stormpike Guard"
	510,	-- "The Defilers"
	889,	-- "Warsong Outriders"
	729,	-- "Frostwolf Clan"
	21,	-- "Booty Bay"
	577,	-- "Everlook"
	369,	-- "Gadgetzan"
	470,	-- "Ratchet"
	529,	-- "Argent Dawn"
	87,	-- "Bloodsail Buccaneers"
	910,	-- "Brood of Nozdormu"
	609,	-- "Cenarion Circle"
	909,	-- "Darkmoon Faire"
	92,	-- "Gelkis Clan Centaur"
	749,	-- "Hydraxian Waterlords"
	93,	-- "Magram Clan Centaur"
	349,	-- "Ravenholdt"
	809,	-- "Shen'dralar"
	70,	-- "Syndicate"
	59,	-- "Thorium Brotherhood"
	576,	-- "Timbermaw Hold"
	922,	-- "Tranquillien"
	589,	-- "Wintersaber Trainers"
	270,	-- "Zandalar Tribe"
	1012,	-- "Ashtongue Deathsworn"
	942,	-- "Cenarion Expedition"
	933,	-- "The Consortium"
	946,	-- "Honor Hold"
	978,	-- "Kurenai"
	941,	-- "The Mag'har"
	1015,	-- "Netherwing"
	1038,	-- "Ogri'la"
	970,	-- "Sporeggar"
	947,	-- "Thrallmar"
	1011,	-- "Lower City"
	1031,	-- "Sha'tari Skyguard"
	1077,	-- "Shattered Sun Offensive"
	932,	-- "The Aldor"
	934,	-- "The Scryers"
	935,	-- "The Sha'tar"
	989,	-- "Keepers of Time"
	990,	-- "The Scale of the Sands"
	967,	-- "The Violet Eye"
	1106,	-- "Argent Crusade"
	1090,	-- "Kirin Tor"
	1073,	-- "The Kalu'ak"
	1091,	-- "The Wyrmrest Accord"
	1098,	-- "Knights of the Ebon Blade"
	1119,	-- "The Sons of Hodir"
	1156,	-- "The Ashen Verdict"
	1037,	-- "Alliance Vanguard"
	1068,	-- "Explorers' League"
	1126,	-- "The Frostborn"
	1094,	-- "The Silver Covenant"
	1050,	-- "Valiance Expedition"
	1052,	-- "Horde Expedition"
	1067,	-- "The Hand of Vengeance"
	1124,	-- "The Sunreavers"
	1064,	-- "The Taunka"
	1085,	-- "Warsong Offensive"
	1104,	-- "Frenzyheart Tribe"
	1105,	-- "The Oracles"
	469,	-- "Alliance"
	67,	-- "Horde"
	1134,	-- "Gilneas"
	1133,	-- "Bilgewater Cartel"

	-- cataclysm
	1158,	-- "Guardians of Hyjal"
	1135,	-- "The Earthen Ring"
	1171,	-- "Therazane"
	1174,	-- "Wildhammer Clan"
	1173,	-- "Ramkahen"
	1177,	-- "Baradin's Wardens"
	1172,	-- "Dragonmaw Clan"
	1178,	-- "Hellscream's Reach"
	1204,	-- "Avengers of Hyjal"

	-- pandaria
	1277,	-- "Chee Chee"
	1275,	-- "Ella"
	1283,	-- "Farmer Fung"
	1282,	-- "Fish Fellreed"
	1228,	-- "Forest Hozen"
	1281,	-- "Gina Mudclaw"
	1269,	-- "Golden Lotus"
	1279,	-- "Haohan Mudclaw"
	1273,	-- "Jogu the Drunk"
	1358,	-- "Nat Pagle"
	1276,	-- "Old Hillpaw"
	1271,	-- "Order of the Cloud Serpent"
	1242,	-- "Pearlfin Jinyu"
	1270,	-- "Shado-Pan"
	1216,	-- "Shang Xi's Academy"
	1278,	-- "Sho"
	1302,	-- "The Anglers"
	1341,	-- "The August Celestials"
	1359,	-- "The Black Prince"
	1351,	-- "The Brewmasters"
	1337,	-- "The Klaxxi"
	1345,	-- "The Lorewalkers"
	1272,	-- "The Tillers"
	1280,	-- "Tina Mudclaw"
	1353,	-- "Tushui Pandaren"
	1352,	-- "Huojin Pandaren"

	1376,	-- "Operation: Shieldwall"
	1387,	-- "Kirin Tor Offensive"
	1416,	-- "Akama's Trust"
	1375,	-- "Dominance Offensive"
	1388,	-- "Sunreaver Onslaught"
	1435,	-- "Shado-Pan Assault"
	1440,	-- "Darkspear Rebellion"	
	1492, -- "Emperor Shaohao"
}

local FactionUIDsRev = {}

for k, v in pairs(FactionUIDs) do
	local name = GetFactionInfoByID(v)
	FactionUIDsRev[name] = k	-- ex : ["Darnassus"] = 1
end

-- *** Utility functions ***
local headersState = {}
local inactive = {}

local function SaveHeaders()
	local headerCount = 0		-- use a counter to avoid being bound to header names, which might not be unique.
	
	for i = GetNumFactions(), 1, -1 do		-- 1st pass, expand all categories
		local name, _, _, _, _, _, _,	_, isHeader, isCollapsed = GetFactionInfo(i)
		if isHeader then
			headerCount = headerCount + 1
			if isCollapsed then
				ExpandFactionHeader(i)
				headersState[headerCount] = true
			end
		end
	end
	
	-- code disabled until I can find the other addon that conflicts with this and slows down the machine.
	
	-- If a header faction, like alliance or horde, has all child factions set to inactive, it will not be visible, so activate it, and deactivate it after the scan (thanks Zaphon for this)
	-- for i = GetNumFactions(), 1, -1 do
		-- if IsFactionInactive(i) then
			-- local name = GetFactionInfo(i)
			-- inactive[name] = true
			-- SetFactionActive(i)
		-- end
	-- end
end

local function RestoreHeaders()
	local headerCount = 0
	for i = GetNumFactions(), 1, -1 do
		local name, _, _, _, _, _, _,	_, isHeader = GetFactionInfo(i)
		
		-- if inactive[name] then
			-- SetFactionInactive(i)
		-- end
		
		if isHeader then
			headerCount = headerCount + 1
			if headersState[headerCount] then
				CollapseFactionHeader(i)
			end
		end
	end
	wipe(headersState)
end

local function GetLimits(earned)
	-- return the bottom & top values of a given rep level based on the amount of earned rep
	local top = 43000
	local index = #BottomLevels
	
	while (earned < BottomLevels[index]) do
		top = BottomLevels[index]
		index = index - 1
	end
	
	return BottomLevels[index], top
end

local function GetEarnedRep(character, faction)
	local earned 
	if character.guildName and faction == character.guildName then
		return character.guildRep
	end
	return character.Factions[FactionUIDsRev[faction]]
end

-- *** Scanning functions ***
local currentGuildName

local function ScanReputations()
	SaveHeaders()
	local factions = addon.ThisCharacter.Factions
	wipe(factions)
	
	for i = 1, GetNumFactions() do		-- 2nd pass, data collection
		local name, _, _, _, _, earned = GetFactionInfo(i)
		if (earned and earned > 0) then		-- new in 3.0.2, headers may have rep, ex: alliance vanguard + horde expedition
			if FactionUIDsRev[name] then		-- is this a faction we're tracking ?
				factions[FactionUIDsRev[name]] = earned
			end
		end
	end

	RestoreHeaders()
	addon.ThisCharacter.lastUpdate = time()
end

local function ScanGuildReputation()
	SaveHeaders()
	for i = 1, GetNumFactions() do		-- 2nd pass, data collection
		local name, _, _, _, _, earned = GetFactionInfo(i)
		if name and name == currentGuildName then
			addon.ThisCharacter.guildRep = earned
		end
	end
	RestoreHeaders()
end

-- *** Event Handlers ***
local function OnPlayerAlive()
	ScanReputations()
end

local function OnPlayerGuildUpdate()
	-- at login this event is called between OnEnable and PLAYER_ALIVE, where GetGuildInfo returns a wrong value
	-- however, the value returned here is correct
	if IsInGuild() and not currentGuildName then		-- the event may be triggered multiple times, and GetGuildInfo may return incoherent values in subsequent calls, so only save if we have no value.
		currentGuildName = GetGuildInfo("player")
		if currentGuildName then	
			addon.ThisCharacter.guildName = currentGuildName
			ScanGuildReputation()
		end
	end
end

local function OnFactionChange(event, messageType, faction, amount)
	if messageType ~= "FACTION" then return end
	
	if faction == GUILD then
		ScanGuildReputation()
		return
	end
	
	local bottom, top, earned = DataStore:GetRawReputationInfo(DataStore:GetCharacter(), faction)
	if not earned then 	-- faction not in the db, scan all
		ScanReputations()	
		return 
	end
	
	local newValue = earned + amount
	if newValue >= top then	-- rep status increases (to revered, etc..)
		ScanReputations()					-- so scan all
	else
		addon.ThisCharacter.Factions[FactionUIDsRev[faction]] = newValue
		addon.ThisCharacter.lastUpdate = time()
	end
end


-- ** Mixins **
local function _GetReputationInfo(character, faction)
	local earned = GetEarnedRep(character, faction)
	if not earned then return end

	local bottom, top = GetLimits(earned)
	local rate = (earned - bottom) / (top - bottom) * 100

	-- ex: "Revered", 15400, 21000, 73%
	return BottomLevelNames[bottom], (earned - bottom), (top - bottom), rate 
end

local function _GetRawReputationInfo(character, faction)
	-- same as GetReputationInfo, but returns raw values
	
	local earned = GetEarnedRep(character, faction)
	if not earned then return end

	local bottom, top = GetLimits(earned)
	return bottom, top, earned
end

local function _GetReputations(character)
	return character.Factions
end

local function _GetGuildReputation(character)
	return character.guildRep or 0
end

local function _GetReputationLevels()
	return BottomLevels
end

local function _GetReputationLevelText(bottom)
	return BottomLevelNames[bottom]
end

local PublicMethods = {
	GetReputationInfo = _GetReputationInfo,
	GetRawReputationInfo = _GetRawReputationInfo,
	GetReputations = _GetReputations,
	GetGuildReputation = _GetGuildReputation,
	GetReputationLevels = _GetReputationLevels,
	GetReputationLevelText = _GetReputationLevelText,
}

function addon:OnInitialize()
	addon.db = LibStub("AceDB-3.0"):New(addonName .. "DB", AddonDB_Defaults)

	DataStore:RegisterModule(addonName, addon, PublicMethods)
	DataStore:SetCharacterBasedMethod("GetReputationInfo")
	DataStore:SetCharacterBasedMethod("GetRawReputationInfo")
	DataStore:SetCharacterBasedMethod("GetReputations")
	DataStore:SetCharacterBasedMethod("GetGuildReputation")
end

function addon:OnEnable()
	addon:RegisterEvent("PLAYER_ALIVE", OnPlayerAlive)
	addon:RegisterEvent("COMBAT_TEXT_UPDATE", OnFactionChange)
	addon:RegisterEvent("PLAYER_GUILD_UPDATE", OnPlayerGuildUpdate)				-- for gkick, gquit, etc..
end

function addon:OnDisable()
	addon:UnregisterEvent("PLAYER_ALIVE")
	addon:UnregisterEvent("COMBAT_TEXT_UPDATE")
	addon:UnregisterEvent("PLAYER_GUILD_UPDATE")
end

-- *** Utility functions ***
local PT = LibStub("LibPeriodicTable-3.1")

function addon:GetSource(searchedID)
	-- returns the faction where a given item ID can be obtained, as well as the level
	local level, repData = PT:ItemInSet(searchedID, "Reputation.Reward")
	if level and repData then
		local _, _, faction = strsplit(".", repData)		-- ex: "Reputation.Reward.Sporeggar"
	
		-- level = 7,  29150:7 where 7 means revered
		return faction, _G["FACTION_STANDING_LABEL"..level]
	end
end
