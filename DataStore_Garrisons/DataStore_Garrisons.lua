--[[	*** DataStore_Garrisons ***
Written by : Thaoky, EU-Marécages de Zangar
November 30th, 2014
--]]
if not DataStore then return end

local addonName = "DataStore_Garrisons"

_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0")

local addon = _G[addonName]

local THIS_ACCOUNT = "Default"

local AddonDB_Defaults = {
	global = {
		Reference = {
			FollowerNamesToID = {},			-- ex: ["Nat Pagle"] = 202 ... necessary because the id's do not remain constant in game, and the full list varies per character.
		},
		Options = {
			ReportUncollected = 1,			-- Report uncollected resources
		},
		Characters = {
			['*'] = {				-- ["Account.Realm.Name"] 
				lastUpdate = nil,
				lastResourceCollection = nil,
				numFollowers = 0,
				numFollowersAtLevel100 = 0,
				numFollowersAtiLevel615 = 0,
				numFollowersAtiLevel630 = 0,
				numFollowersAtiLevel645 = 0,
				numRareFollowers = 0,
				numEpicFollowers = 0,
				Buildings = {},		-- List of buildings
				Followers = {},		-- List of followers
			}
		}
	}
}

--[[
The API does not return information about the building type, even less in a localization & faction independent way, so match
the building id's with an internal string.
--]]

local BUILDING_ALCHEMY = "AlchemyLab"
local BUILDING_BARN = "Barn"
local BUILDING_BARRACKS = "Barracks"
local BUILDING_DWARVEN_BUNKER = "DwarvenBunker"
local BUILDING_ENCHANTERS_STUDY = "EnchantersStudy"
local BUILDING_ENGINEERING_WORKS = "EngineeringWorks"
local BUILDING_FISHING_SHACK = "FishingShack"
local BUILDING_GEM_BOUTIQUE = "GemBoutique"
local BUILDING_GLADIATORS_SANCTUM = "GladiatorsSanctum"
local BUILDING_GNOMISH_GEARWORKS = "GnomishGearworks"
local BUILDING_HERB_GARDEN = "HerbGarden"
local BUILDING_LUMBER_MILL = "LumberMill"
local BUILDING_LUNARFALL_EXCAVATION = "LunarfallExcavation"
local BUILDING_LUNARFALL_INN = "LunarfallInn"
local BUILDING_MAGE_TOWER = "MageTower"
local BUILDING_MENAGERIE = "Menagerie"
local BUILDING_SALVAGE_YARD = "SalvageYard"
local BUILDING_SCRIBES_QUARTERS = "ScribesQuarters"
local BUILDING_STABLES = "Stables"
local BUILDING_STOREHOUSE = "Storehouse"
local BUILDING_TAILORING_EMPORIUM = "TailoringEmporium"
local BUILDING_THE_FORGE = "TheForge"
local BUILDING_THE_TANNERY = "TheTannery"
local BUILDING_TRADING_POST = "TradingPost"

local BUILDING_TOWN_HALL = "TownHall"

local BuildingTypes = {
	[76] = BUILDING_ALCHEMY,
	[119] = BUILDING_ALCHEMY,
	[120] = BUILDING_ALCHEMY,
	[24] = BUILDING_BARN,
	[25] = BUILDING_BARN,
	[133] = BUILDING_BARN,
	[26] = BUILDING_BARRACKS,
	[27] = BUILDING_BARRACKS,
	[28] = BUILDING_BARRACKS,
	[8] = BUILDING_DWARVEN_BUNKER,
	[9] = BUILDING_DWARVEN_BUNKER,
	[10] = BUILDING_DWARVEN_BUNKER,
	[93] = BUILDING_ENCHANTERS_STUDY,
	[125] = BUILDING_ENCHANTERS_STUDY,
	[126] = BUILDING_ENCHANTERS_STUDY,
	[91] = BUILDING_ENGINEERING_WORKS,
	[123] = BUILDING_ENGINEERING_WORKS,
	[124] = BUILDING_ENGINEERING_WORKS,
	[64] = BUILDING_FISHING_SHACK,
	[134] = BUILDING_FISHING_SHACK,
	[135] = BUILDING_FISHING_SHACK,
	[96] = BUILDING_GEM_BOUTIQUE,
	[131] = BUILDING_GEM_BOUTIQUE,
	[132] = BUILDING_GEM_BOUTIQUE,
	[159] = BUILDING_GLADIATORS_SANCTUM,
	[160] = BUILDING_GLADIATORS_SANCTUM,
	[161] = BUILDING_GLADIATORS_SANCTUM,
	[162] = BUILDING_GNOMISH_GEARWORKS,
	[163] = BUILDING_GNOMISH_GEARWORKS,
	[164] = BUILDING_GNOMISH_GEARWORKS,
	[29] = BUILDING_HERB_GARDEN,
	[136] = BUILDING_HERB_GARDEN,
	[137] = BUILDING_HERB_GARDEN,
	[40] = BUILDING_LUMBER_MILL,
	[41] = BUILDING_LUMBER_MILL,
	[138] = BUILDING_LUMBER_MILL,
	[61] = BUILDING_LUNARFALL_EXCAVATION,
	[62] = BUILDING_LUNARFALL_EXCAVATION,
	[63] = BUILDING_LUNARFALL_EXCAVATION,
	[34] = BUILDING_LUNARFALL_INN,
	[35] = BUILDING_LUNARFALL_INN,
	[36] = BUILDING_LUNARFALL_INN,
	[37] = BUILDING_MAGE_TOWER,
	[38] = BUILDING_MAGE_TOWER,
	[39] = BUILDING_MAGE_TOWER,
	[42] = BUILDING_MENAGERIE,
	[167] = BUILDING_MENAGERIE,
	[168] = BUILDING_MENAGERIE,
	[52] = BUILDING_SALVAGE_YARD,
	[140] = BUILDING_SALVAGE_YARD,
	[141] = BUILDING_SALVAGE_YARD,
	[95] = BUILDING_SCRIBES_QUARTERS,
	[129] = BUILDING_SCRIBES_QUARTERS,
	[130] = BUILDING_SCRIBES_QUARTERS,
	[65] = BUILDING_STABLES,
	[66] = BUILDING_STABLES,
	[67] = BUILDING_STABLES,
	[51] = BUILDING_STOREHOUSE,
	[142] = BUILDING_STOREHOUSE,
	[143] = BUILDING_STOREHOUSE,
	[94] = BUILDING_TAILORING_EMPORIUM,
	[127] = BUILDING_TAILORING_EMPORIUM,
	[128] = BUILDING_TAILORING_EMPORIUM,
	[60] = BUILDING_THE_FORGE,
	[117] = BUILDING_THE_FORGE,
	[118] = BUILDING_THE_FORGE,
	[90] = BUILDING_THE_TANNERY,
	[121] = BUILDING_THE_TANNERY,
	[122] = BUILDING_THE_TANNERY,
	[111] = BUILDING_TRADING_POST,
	[144] = BUILDING_TRADING_POST,
	[145] = BUILDING_TRADING_POST,
}

-- *** Utility functions ***
local function GetOption(option)
	return addon.db.global.Options[option]
end

local function GetNumUncollectedResources(from)
	-- no known collection time (alt never logged in) .. return 0
	if not from then return 0 end
	
	local age = time() - from
	local resources = math.floor(age / 600)		-- 10 minutes = 1 resource
	
	-- cap at 500
	if resources > 500 then
		resources = 500
	end
	return resources
end

local function CheckUncollectedResources()
	local account, realm, name
	local num
	
	for key, character in pairs(addon.db.global.Characters) do
		account, realm, name = strsplit(".", key)
		num = GetNumUncollectedResources(character.lastResourceCollection)
		if name and num >= 400 then
			addon:Print(format("%s has %s uncollected resources", name, num))
		end
	end
end

-- *** Scanning functions ***
local function ScanBuildings()
	local plots = C_Garrison.GetPlots()

	-- to avoid deleting previously saved data when the game is not ready to deliver information
	-- exit if no data is available
	if not plots or #plots == 0 then return end

	local buildings = addon.ThisCharacter.Buildings
	wipe(buildings)
	
	-- Scan Town Hall
	local level = C_Garrison.GetGarrisonInfo()
	
	buildings[BUILDING_TOWN_HALL] = { id = 0, rank = level }
	
	local ref = addon.db.global.Reference
	
	-- Scan other buildings
	for i = 1, #plots do
		local plot = plots[i]
		
		-- local id, name, texPrefix, icon, rank, isBuilding, timeStart, buildTime, canActivate, canUpgrade, isPrebuilt = C_Garrison.GetOwnedBuildingInfoAbbrev(plot.id);
		local id, _, _, _, rank = C_Garrison.GetOwnedBuildingInfoAbbrev(plot.id)
		if id then
			local info = {}
			
			info.id = id
			info.rank = rank

			buildings[BuildingTypes[id]] = info
		end
	end
end
	
local function ScanFollowers()
	local followersList = C_Garrison.GetFollowers()
	if not followersList then return end

	local followers = addon.ThisCharacter.Followers
	wipe(followers)
	
	-- = C_Garrison.GetFollowerNameByID(id)
	
	local ref = addon.db.global.Reference
	local name		-- follower name
	local link		-- follower link
	local id			-- follower id
	
	local numFollowers = 0	-- number of followers
	local num100 = 0	-- number of followers at level 100
	local num615 = 0	-- number of followers at iLevel 615+
	local num630 = 0	-- number of followers at iLevel 630+
	local num645 = 0	-- number of followers at iLevel 645+
	local numRare = 0	-- number of rare followers (blue)
	local numEpic = 0	-- number of epic followers (violet)
	
	for k, follower in pairs(followersList) do
		name = follower.name
		id = follower.followerID		-- by default, the id should be this one (numeric)

		if follower.isCollected then
			-- if the follower is collected, the id will be a GUID (string)
			-- therefore, it has to be extracted from the link
			-- also, the link is only valid for collected followers, otherwise it is nil
			link = C_Garrison.GetFollowerLink(follower.followerID)
			id = link:match("garrfollower:(%d+)")
			id = tonumber(id)
			
			local info = {}
			
			info.xp = follower.xp
			info.levelXP = follower.levelXP
			info.link = link
			followers[name] = info
			
			-- Stats
			numFollowers = numFollowers + 1
			
			if link then
				local _, rarity, level, iLevel = link:match("garrfollower:(%d+):(%d+):(%d+):(%d+)")
				
				rarity = tonumber(rarity)
				level = tonumber(level)
				iLevel = tonumber(iLevel)
				
				if level == 100 then num100 = num100 + 1 end
				if iLevel >= 615 then num615 = num615 + 1	end
				if iLevel >= 630 then num630 = num630 + 1	end
				if iLevel >= 645 then num645 = num645 + 1	end
				if rarity == 3 then numRare = numRare + 1 end
				if rarity == 4 then numEpic = numEpic + 1	end
			end
		end
		
		ref.FollowerNamesToID[name] = id	-- ["Nat Pagle"] = 202
	end
	
	local c = addon.ThisCharacter
	
	c.numFollowers = numFollowers
	c.numFollowersAtLevel100 = num100
	c.numFollowersAtiLevel615 = num615
	c.numFollowersAtiLevel630 = num630
	c.numFollowersAtiLevel645 = num645
	c.numRareFollowers = numRare
	c.numEpicFollowers = numEpic
	
	addon.ThisCharacter.lastUpdate = time()
end

local function ScanResourceCollectionTime()
	addon.ThisCharacter.lastResourceCollection = time()
end

-- *** Event Handlers ***
local function OnFollowerAdded()
	ScanFollowers()
end

local function OnFollowerListUpdate()
	ScanFollowers()
end

local function OnFollowerRemoved()
	ScanFollowers()
end

local function OnGarrisonBuildingActivated()
	ScanBuildings()
end

local function OnGarrisonBuildingUpdate()
	ScanBuildings()
end

local function OnGarrisonBuildingRemoved()
	ScanBuildings()
end

local function OnShowLootToast(event, lootType, link, quantity)
	if lootType ~= "currency" then return end
	
	-- make sure it is garrison resources
	if link and link:match("currency:824") then	
		ScanResourceCollectionTime()
	end
end

local function OnAddonLoaded(event, addonName)
	if addonName == "Blizzard_GarrisonUI" then
		ScanBuildings()
		ScanFollowers()
	end
end

-- ** Mixins **
local function _GetFollowers(character)
	return character.Followers
end

local function _GetFollowerInfo(character, name)
	local follower = character.Followers[name]
	if not follower then return end
	
	local link = follower.link
	if not link then return end
	
	local id, rarity, level, iLevel = link:match("garrfollower:(%d+):(%d+):(%d+):(%d+)")

	return id, tonumber(rarity), tonumber(level), tonumber(iLevel), follower.xp, follower.levelXP
end

local function _GetFollowerLink(character, name)
	local follower = character.Followers[name]
	if not follower then return end
	
	return follower.link
end

local function _GetFollowerID(name)
	return addon.db.global.Reference.FollowerNamesToID[name]
end

local function _GetNumFollowers(character)
	return character.numFollowers or 0
end

local function _GetNumFollowersAtLevel100(character)
	return character.numFollowersAtLevel100 or 0
end

local function _GetNumFollowersAtiLevel615(character)
	return character.numFollowersAtiLevel615 or 0
end

local function _GetNumFollowersAtiLevel630(character)
	return character.numFollowersAtiLevel630 or 0
end

local function _GetNumFollowersAtiLevel645(character)
	return character.numFollowersAtiLevel645 or 0
end

local function _GetNumRareFollowers(character)
	return character.numRareFollowers or 0
end

local function _GetNumEpicFollowers(character)
	return character.numEpicFollowers or 0
end

local function _GetBuildingInfo(character, name)
	local building = character.Buildings[name]
	if not building then return end
	
	return building.id, building.rank
end

local function _GetUncollectedResources(character)
	return GetNumUncollectedResources(character.lastResourceCollection)
end

local PublicMethods = {
	GetFollowers = _GetFollowers,
	GetFollowerInfo = _GetFollowerInfo,
	GetFollowerLink = _GetFollowerLink,
	GetFollowerID = _GetFollowerID,
	GetNumFollowers = _GetNumFollowers,
	GetNumFollowersAtLevel100 = _GetNumFollowersAtLevel100,
	GetNumFollowersAtiLevel615 = _GetNumFollowersAtiLevel615,
	GetNumFollowersAtiLevel630 = _GetNumFollowersAtiLevel630,
	GetNumFollowersAtiLevel645 = _GetNumFollowersAtiLevel645,
	GetNumRareFollowers = _GetNumRareFollowers,
	GetNumEpicFollowers = _GetNumEpicFollowers,
	GetBuildingInfo = _GetBuildingInfo,
	GetUncollectedResources = _GetUncollectedResources,
}

function addon:OnInitialize()
	addon.db = LibStub("AceDB-3.0"):New(addonName .. "DB", AddonDB_Defaults)

	DataStore:RegisterModule(addonName, addon, PublicMethods)
	DataStore:SetCharacterBasedMethod("GetFollowers")
	DataStore:SetCharacterBasedMethod("GetFollowerInfo")
	DataStore:SetCharacterBasedMethod("GetFollowerLink")
	DataStore:SetCharacterBasedMethod("GetNumFollowers")
	DataStore:SetCharacterBasedMethod("GetNumFollowersAtLevel100")
	DataStore:SetCharacterBasedMethod("GetNumFollowersAtiLevel615")
	DataStore:SetCharacterBasedMethod("GetNumFollowersAtiLevel630")
	DataStore:SetCharacterBasedMethod("GetNumFollowersAtiLevel645")
	DataStore:SetCharacterBasedMethod("GetNumRareFollowers")
	DataStore:SetCharacterBasedMethod("GetNumEpicFollowers")
	DataStore:SetCharacterBasedMethod("GetBuildingInfo")
	DataStore:SetCharacterBasedMethod("GetUncollectedResources")
end

function addon:OnEnable()
	-- addon:RegisterEvent("PLAYER_ALIVE", OnPlayerAlive)
	addon:RegisterEvent("GARRISON_FOLLOWER_ADDED", OnFollowerAdded)
	addon:RegisterEvent("GARRISON_FOLLOWER_LIST_UPDATE", OnFollowerListUpdate)
	addon:RegisterEvent("GARRISON_FOLLOWER_REMOVED", OnFollowerRemoved)
	addon:RegisterEvent("ADDON_LOADED", OnAddonLoaded)
	
	-- addon:RegisterEvent("GARRISON_UPDATE", OnGarrisonUpdate)
	addon:RegisterEvent("GARRISON_BUILDING_ACTIVATED", OnGarrisonBuildingActivated)
	addon:RegisterEvent("GARRISON_BUILDING_UPDATE", OnGarrisonBuildingUpdate)
	addon:RegisterEvent("GARRISON_BUILDING_REMOVED", OnGarrisonBuildingRemoved)
	addon:RegisterEvent("SHOW_LOOT_TOAST", OnShowLootToast)
	
	addon:SetupOptions()
	if GetOption("ReportUncollected") == 1 then
		CheckUncollectedResources()
	end
end

function addon:OnDisable()
	addon:UnregisterEvent("PLAYER_ALIVE")
	addon:UnregisterEvent("GARRISON_FOLLOWER_ADDED")
	addon:UnregisterEvent("GARRISON_FOLLOWER_LIST_UPDATE")
	addon:UnregisterEvent("GARRISON_FOLLOWER_REMOVED")
	addon:UnregisterEvent("GARRISON_BUILDING_ACTIVATED")
	addon:UnregisterEvent("GARRISON_BUILDING_UPDATE")
	addon:UnregisterEvent("GARRISON_BUILDING_REMOVED")
	addon:UnregisterEvent("ADDON_LOADED")
end
