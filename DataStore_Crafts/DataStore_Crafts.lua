--[[	*** DataStore_Crafts ***
Written by : Thaoky, EU-Marécages de Zangar
June 23rd, 2009
--]]
if not DataStore then return end

local addonName = "DataStore_Crafts"

_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0", "AceComm-3.0", "AceSerializer-3.0", "AceTimer-3.0")

local addon = _G[addonName]

local THIS_ACCOUNT = "Default"

local SECONDSPERDAY = 86400
local THREEOCLOCK = 10800

local AddonDB_Defaults = {
	global = {
		Guilds = {
			['*'] = {			-- ["Account.Realm.Name"] 
				Members = {
					['*'] = {				-- ["MemberName"] 
						lastUpdate = nil,
						Version = nil,
						Professions = {},		-- 3 profession links : [1] & [2] for the 2 primary professions, [3] for cooking ([4] for archaeology ? wait & see)
					}
				}
			},
		},
		Characters = {
			['*'] = {				-- ["Account.Realm.Name"] 
				lastUpdate = nil,
				Professions = {
					['*'] = {
						FullLink = nil,		-- Tradeskill link
						Rank = 0,
						MaxRank = 0,
						Icon = nil,
						Crafts = {},
						Cooldowns = { ['*'] = nil },		-- list of active cooldowns
					}
				},
				ArcheologyItems = {},
			}
		}
	}
}

local ReferenceDB_Defaults = {
	global = {
		Reagents = {},		-- [recipeID] = "itemID1,count1 | itemID2,count2 | ..."
		ResultItems = {}	-- [recipeID] = itemID
	}
}


local SPELL_ID_ALCHEMY = 2259
local SPELL_ID_BLACKSMITHING = 3100
local SPELL_ID_ENCHANTING = 7411
local SPELL_ID_ENGINEERING = 4036
local SPELL_ID_INSCRIPTION = 45357
local SPELL_ID_JEWELCRAFTING = 25229
local SPELL_ID_LEATHERWORKING = 2108
local SPELL_ID_TAILORING = 3908
local SPELL_ID_SKINNING = 8613
local SPELL_ID_MINING = 2575
local SPELL_ID_HERBALISM = 2366
local SPELL_ID_SMELTING = 2656
local SPELL_ID_COOKING = 2550
local SPELL_ID_FIRSTAID = 3273
local SPELL_ID_FISHING = 131474
local SPELL_ID_ARCHAEOLOGY = 78670

local ProfessionSpellID = {
	-- GetSpellInfo with this value will return localized spell name
	["Alchemy"] = SPELL_ID_ALCHEMY,
	["Blacksmithing"] = SPELL_ID_BLACKSMITHING,
	["Enchanting"] = SPELL_ID_ENCHANTING,
	["Engineering"] = SPELL_ID_ENGINEERING,
	["Inscription"] = SPELL_ID_INSCRIPTION,
	["Jewelcrafting"] = SPELL_ID_JEWELCRAFTING,
	["Leatherworking"] = SPELL_ID_LEATHERWORKING,
	["Tailoring"] = SPELL_ID_TAILORING,
	["Skinning"] = SPELL_ID_SKINNING,
	["Mining"] = SPELL_ID_MINING,
	["Herbalism"] = SPELL_ID_HERBALISM,
	["Smelting"] = SPELL_ID_SMELTING,

	["Cooking"] = SPELL_ID_COOKING,
	["First Aid"] = SPELL_ID_FIRSTAID,
	["Fishing"] = SPELL_ID_FISHING,
}

-- *** Utility functions ***
local bAnd = bit.band
local LShift = bit.lshift
local RShift = bit.rshift

local function GetOption(option)
	return addon.db.global.Options[option]
end

local function GetProfessionID(profession)
	-- profession = localized profession name "Cooking" or "Cuisine", "Alchemy"...
	-- note: we're not using a reverse lookup table because of the localization issue.
	
	if ProfessionSpellID[profession] then
		return ProfessionSpellID[profession]
	end

	for _, id in pairs( ProfessionSpellID ) do
		if profession == GetSpellInfo(id) then		-- profession found ?
			ProfessionSpellID[profession] = id		-- cache the result to speed up future searches
			return id
		end
	end
end

local function GetThisGuild()
	local key = DataStore:GetThisGuildKey()
	return key and addon.db.global.Guilds[key] 
end

local function GetVersion()
	local _, version = GetBuildInfo()
	return tonumber(version)
end

local function ClearExpiredProfessions()
	-- this function will clear all the guild profession links that were saved with a build number anterior to the current one (they're invalid after a patch anyway)
	
	local thisGuild = GetThisGuild()
	if not thisGuild then return end
		
	local version = GetVersion()
	
	for name, member in pairs(thisGuild.Members) do
		if member.Version ~= version then
			thisGuild.Members[name] = nil		-- clear this member's entry if version is outdated
		end
	end
end

local function LocalizeProfessionSpellIDs()
	-- this function adds localized entries in the ProfessionSpellID table
	
	local localizedSpells = {}		-- avoid infinite loop by storing in a temp table first
	local localizedName
	for englishName, spellID in pairs(ProfessionSpellID) do
		localizedName = GetSpellInfo(spellID)
		localizedSpells[localizedName] = spellID
	end
	
	for name, id in pairs(localizedSpells) do
		ProfessionSpellID[name] = id
	end
end

-- *** Scanning functions ***

local function ScanCooldowns()
	-- Updated by RGriedel
	local tradeskillName = C_TradeSkillUI.GetTradeSkillLine()
	local char = addon.ThisCharacter
	local profession = char.Professions[tradeskillName]

	local serverClock = time()
	-- local locYear, locMonth, locDay, locHour, locMinute, locSecond = string.match(date("%Y %m %d %H %M %S"), "(%d*) (%d*) (%d*) (%d*) (%d*) (%d*)")
	local hour, minute, second = string.match(date("%H %M %S"), "(%d*) (%d*) (%d*)")
	local serverDate = floor ( serverClock / SECONDSPERDAY ) * SECONDSPERDAY
	local serverTime = serverClock - serverDate
	local localTime = second + ( minute + ( hour * 60 )) * 60
	local timediff = localTime - serverTime
	
	wipe(profession.Cooldowns)
	for i = 1, GetNumTradeSkills() do
		local skillName, skillType = GetTradeSkillInfo(i)
		
		if skillType ~= "header" then
			local cooldown = GetTradeSkillCooldown(i)
			if cooldown then
				local cooldownTime = localTime + cooldown
				if math.abs (( cooldownTime < THREEOCLOCK and SECONDSPERDAY or 0 ) + cooldownTime - SECONDSPERDAY ) < 300 then
					if serverTime > THREEOCLOCK then
						table.insert(profession.Cooldowns, skillName .. "|" .. THREEOCLOCK .. "|" .. serverDate - timediff + SECONDSPERDAY)
					else
						table.insert(profession.Cooldowns, skillName .. "|" .. THREEOCLOCK .. "|" .. serverDate - timediff)
					end
				else
					table.insert(profession.Cooldowns, skillName .. "|" .. cooldown .. "|" .. serverClock)
				end
			end
		end
	end
end

local function ScanProfessionInfo(index, mainIndex)
	local char = addon.ThisCharacter

	if char and mainIndex and not index then
		char["Prof"..mainIndex] = nil			-- profession may have been cleared, nil it
	end

	if not char or not index then return end
	
	local profName, texture, rank, maxRank = GetProfessionInfo(index);
	local profession = char.Professions[profName]
	profession.Rank = rank
	profession.MaxRank = maxRank
	
	local profLink = select(2, GetSpellLink(profName))
	if profLink then	-- sometimes a nil value may be returned, so keep the old one if nil
		profession.FullLink = profLink
	end
	
	if mainIndex then
		char["Prof"..mainIndex] = profName
	end
end

local function ScanProfessionLinks()
	local prof1, prof2, arch, fish, cook, firstAid = GetProfessions()

	ScanProfessionInfo(cook)
	ScanProfessionInfo(firstAid)
	ScanProfessionInfo(fish)
	ScanProfessionInfo(arch)
	ScanProfessionInfo(prof1, 1)
	ScanProfessionInfo(prof2, 2)
	
	addon.ThisCharacter.lastUpdate = time()
end

local SkillTypeToColor = {
	["trivial"] = 0,		-- grey
	["easy"] = 1,			-- green
	["medium"] = 2,		-- yellow
	["optimal"] = 3,		-- orange
}

local function ScanRecipes()
	local _, tradeskillName = C_TradeSkillUI.GetTradeSkillLine()
	if not tradeskillName or tradeskillName == "UNKNOWN" then return end	-- may happen after a patch, or under extreme lag, so do not save anything to the db !

	local char = addon.ThisCharacter
	local profession = char.Professions[tradeskillName]
	local crafts = profession.Crafts
	wipe(crafts)
	
	local recipes = C_TradeSkillUI.GetAllRecipeIDs()
	if not recipes or (#recipes == 0) then return end
	
	local categoryCount = 0
	local categoryID = -1
	
	local resultItems = addon.ref.global.ResultItems
	local reagentsDB = addon.ref.global.Reagents
	local reagentsInfo = {}
	
	for i, recipeID in pairs(recipes) do
		local info = C_TradeSkillUI.GetRecipeInfo(recipeID)
		
		-- scan reagents for all recipes (even unlearned)
		wipe(reagentsInfo)
		
		local numReagents = C_TradeSkillUI.GetRecipeNumReagents(recipeID)
		for reagentIndex = 1, numReagents do
			local _, _, count = C_TradeSkillUI.GetRecipeReagentInfo(recipeID, reagentIndex)
			local link = C_TradeSkillUI.GetRecipeReagentItemLink(recipeID, reagentIndex)
			
			if link and count then
				local itemID = tonumber(link:match("item:(%d+)"))
				if itemID then
					table.insert(reagentsInfo, format("%s,%s", itemID, count))
				end
			end
		end
		
		reagentsDB[recipeID] = table.concat(reagentsInfo, "|")

		-- Resulting item ID
		local itemLink = C_TradeSkillUI.GetRecipeItemLink(recipeID)
		if itemLink then
			resultItems[recipeID] = tonumber(itemLink:match("item:(%d+)"))
		end
		
		if info.learned then
			
			-- save the category
			if categoryID ~= info.categoryID then	-- if it's not the same id as the previous recipe ..
				categoryID = info.categoryID			-- .. set the id ..
		
				local category = C_TradeSkillUI.GetCategoryInfo(categoryID)
				
				-- code is working, but don't save parent at the moment
				-- if category.parentCategoryID then
					-- local parentCategory = C_TradeSkillUI.GetCategoryInfo(category.parentCategoryID)
					-- table.insert(crafts, format("%s|%s", parentCategory.numIndents, parentCategory.name))
				-- end
				
				table.insert(crafts, format("%s|%s", category.numIndents, category.name))
			end
		
			-- save the recipe
			table.insert(crafts, SkillTypeToColor[info.difficulty] + LShift(recipeID, 2))
		end
	end
	
	addon:SendMessage("DATASTORE_RECIPES_SCANNED", char, tradeskillName)
end

local function ScanTradeSkills()
	ScanRecipes()
	-- ScanCooldowns()
	
	addon.ThisCharacter.lastUpdate = time()
end

local function ScanArcheologyItems()
	local items = addon.ThisCharacter.ArcheologyItems
	wipe(items)
	
	local names = {}
	local spellName
	local numArtifactsByRace
	
	for raceIndex = 1, GetNumArchaeologyRaces() do
		wipe(names)
		
		numArtifactsByRace = GetNumArtifactsByRace(raceIndex)
		
		if numArtifactsByRace > 0 and addon.artifactDB[raceIndex] then
			-- Create a table where ["Artifact Name"] = associated spell id 
			-- this is necessary because the archaeology API does not return any other way to match artifacts with either spell ID or item ID
			for index, artifact in pairs(addon.artifactDB[raceIndex]) do
				spellName = GetSpellInfo(artifact.spellID)
				names[spellName] = artifact.spellID
			end
			
			for artifactIndex = 1, GetNumArtifactsByRace(raceIndex) do
				local artifactName, _, _, _, _,  _, _, _, completionCount = GetArtifactInfoByRace(raceIndex, artifactIndex)

				if names[artifactName] and completionCount > 0 then
					items[names[artifactName]] = true
				end
			end
		end
	end
end

-- *** Event Handlers ***
local function OnPlayerAlive()
	ScanProfessionLinks()
end

local function OnTradeSkillClose()
	addon:UnregisterEvent("TRADE_SKILL_CLOSE")
	addon:UnregisterEvent("TRADE_SKILL_UPDATE")
	addon.isOpen = nil
end

local updateCooldowns

local function OnTradeSkillUpdate()
	-- The hook in DoTradeSkill will set this flag so that we only update skills once.
	if updateCooldowns then
		ScanCooldowns()	-- only cooldowns need to be refreshed
		updateCooldowns = nil
	end
end

local function OnTradeSkillShow()
	if C_TradeSkillUI.IsTradeSkillLinked() or C_TradeSkillUI.IsTradeSkillGuild() or C_TradeSkillUI.IsNPCCrafting() then return end
	
	addon:RegisterEvent("TRADE_SKILL_CLOSE", OnTradeSkillClose)
	-- we are not interested in this event if the TS pane is not shown.
	addon:RegisterEvent("TRADE_SKILL_UPDATE", OnTradeSkillUpdate)	
	addon.isOpen = true
end

local function OnArtifactHistoryReady()
	ScanArcheologyItems()
end

local function OnArtifactComplete()
	ScanArcheologyItems()
end

-- this turns
--	"Your skill in %s has increased to %d."
-- into
--	"Your skill in (.+) has increased to (%d+)."
local arg1pattern, arg2pattern
if GetLocale() == "deDE" then		
	-- ERR_SKILL_UP_SI = "Eure Fertigkeit '%1$s' hat sich auf %2$d erhöht.";
	arg1pattern = "'%%1%$s'"
	arg2pattern = "%%2%$d"
else
	arg1pattern = "%%s"
	arg2pattern = "%%d"
end

local skillUpMsg = gsub(ERR_SKILL_UP_SI, arg1pattern, "(.+)")
skillUpMsg = gsub(skillUpMsg, arg2pattern, "(%%d+)")

local function OnChatMsgSkill(self, msg)
	if msg and addon.isOpen then	-- point gained while ts window is open ? rescan
		local skill = msg:match(skillUpMsg)
		if skill and skill == C_TradeSkillUI.GetTradeSkillLine() then	-- if we gained a skill point in the currently opened profession pane, rescan
			ScanTradeSkills()
		end
	end
	ScanProfessionLinks() -- added to update skills upon firing of skillup event 
end


local unlearnMsg = gsub(ERR_SPELL_UNLEARNED_S, arg1pattern, "(.+)")

local function OnChatMsgSystem(self, msg)
	if msg then
		local skillLink = msg:match(unlearnMsg)
		if skillLink then
			local skillName = skillLink:match("%[(.+)%]")
			if skillName then		-- clear the list of recipes
				local char = addon.ThisCharacter
				wipe(char.Professions[skillName])
				char.Professions[skillName] = nil
			end
			
			-- this won't help, as GetProfessions does not return the right values right after the profession has been abandonned.
			-- The problem of listing Prof1 & Prof2 with potentially the same value fixes itself after the next logon though.
			-- Until I find more time to work around this issue, we will live with it .. it's not like players are abandonning professions 100x / day :)
			-- ScanProfessionLinks()	
		end
	end
end

local function OnDataSourceChanged(self)
	if C_TradeSkillUI.IsTradeSkillLinked() or C_TradeSkillUI.IsTradeSkillGuild() or C_TradeSkillUI.IsNPCCrafting() then return end
	
	ScanTradeSkills()
end


-- ** Mixins **
local function _GetProfession(character, name)
	if name then
		return character.Professions[name]
	end
end
	
local function _GetProfessions(character)
	return character.Professions
end

local function _GetProfessionInfo(profession)
	-- accepts either a pointer (type == table)to the profession table, as returned by addon:GetProfession()
	-- or a link (type == string)
	
	local rank, maxRank, spellID, _
	local link

	if type(profession) == "table" then
		rank = profession.Rank
		maxRank = profession.MaxRank 
		link = profession.FullLink
	elseif type(profession) == "string" then
		link = profession
	end
	
	if link then
		-- _, spellID, rank, maxRank = link:match("trade:(%w+):(%d+):(%d+):(%d+):")
		_, spellID = link:match("trade:(%w+):(%d+)")		-- Fix 5.4, rank no longer in the profession link
	end
	
	return tonumber(rank) or 0, tonumber(maxRank) or 0, tonumber(spellID)
end

local function _GetNumCraftLines(profession)
	return #profession.Crafts
end
	
local function _GetCraftLineInfo(profession, index)
	local craft = profession.Crafts[index]
	if type(craft) == "string" then	-- headers are stored as strings
		local indent, header = strsplit("|", craft)
		return true, nil, header, indent
	end
	
	local color = bAnd(craft, 3)	-- first 2 bits = color
	local recipeID = RShift(craft, 2)	-- other bits = recipeID
	
	return false, color, recipeID
end

local function _GetCraftCooldownInfo(profession, index)
	local cooldown = profession.Cooldowns[index]
	local name, reset, lastCheck = strsplit("|", cooldown)
	
	reset = tonumber(reset)
	lastCheck = tonumber(lastCheck)
	local expiresIn = reset - (time() - lastCheck)
	
	return name, expiresIn, reset, lastCheck
end

local function _GetNumActiveCooldowns(profession)
	assert(type(profession) == "table")		-- this is the pointer to a profession table, obtained through addon:GetProfession()
	return #profession.Cooldowns
end

local function _ClearExpiredCooldowns(profession)
	assert(type(profession) == "table")		-- this is the pointer to a profession table, obtained through addon:GetProfession()
	
	for i = #profession.Cooldowns, 1, -1 do		-- from last to first, to avoid messing up indexes when removing entries
		local _, expiresIn = _GetCraftCooldownInfo(profession, i)
		if expiresIn <= 0 then		-- already expired ? remove it
			table.remove(profession.Cooldowns, i)
		end
	end
end

local function _GetNumRecipesByColor(profession)
	-- counts the number of orange, yellow, green and grey recipes.
	local counts = { [0] = 0, [1] = 0, [2] = 0, [3] = 0 }
	
	for i = 1, _GetNumCraftLines(profession) do
		local isHeader, color = _GetCraftLineInfo(profession, i)
		
		if not isHeader then
			counts[color] = counts[color] + 1
		end
	end
	return counts[3], counts[2], counts[1], counts[0]		-- orange, yellow, green, grey
end

local function _IsCraftKnown(profession, spellID)
	-- returns true if a given spell ID is known in the profession passed as first argument
	for i = 1, _GetNumCraftLines(profession) do
		local isHeader, _, info = _GetCraftLineInfo(profession, i)
		
		if not isHeader then
			if info == spellID then
				return true
			end
		end
	end
end

local function _GetGuildCrafters(guild)
	return guild.Members
end

local function _GetGuildMemberProfession(guild, member, index)
	local m = guild.Members[member]
	local profession = m.Professions[index]
	
	if type(profession) == "string" then
		local spellID = profession:match("trade:(%d+):")
		return tonumber(spellID), profession, m.lastUpdate	-- return the profession spell ID + full link
	elseif type(profession) == "number" then
		return profession, nil, m.lastUpdate					-- return the profession spell ID
	end
end

local function _GetProfessionSpellID(name)
	-- name can be either the english name or the localized name
	return ProfessionSpellID[name]
end

local function _GetProfession1(character)
	local profession = _GetProfession(character, character.Prof1)
	if profession then
		local rank, maxRank, spellID = _GetProfessionInfo(profession)
		return rank or 0, maxRank or 0, spellID, character.Prof1
	end
	return 0, 0, nil, nil
end

local function _GetProfession2(character)
	local profession = _GetProfession(character, character.Prof2)
	if profession then
		local rank, maxRank, spellID = _GetProfessionInfo(profession)
		return rank or 0, maxRank or 0, spellID, character.Prof2
	end
	return 0, 0, nil, nil
end

local function _GetFirstAidRank(character)
	local profession = _GetProfession(character, GetSpellInfo(SPELL_ID_FIRSTAID))
	if profession then
		return _GetProfessionInfo(profession)
	end
end

local function _GetCookingRank(character)
	local profession = _GetProfession(character, GetSpellInfo(SPELL_ID_COOKING))
	if profession then
		return _GetProfessionInfo(profession)
	end
end

local function _GetFishingRank(character)
	local profession = _GetProfession(character, GetSpellInfo(SPELL_ID_FISHING))
	if profession then
		return _GetProfessionInfo(profession)
	end
end

local function _GetArchaeologyRank(character)
	local profession = _GetProfession(character, GetSpellInfo(SPELL_ID_ARCHAEOLOGY))
	if profession then
		return _GetProfessionInfo(profession)
	end
end

local function _GetArchaeologyRaceArtifacts(race)
	return addon.artifactDB[race]
end

local function _GetRaceNumArtifacts(race)
	return #addon.artifactDB[race]
end

local function _GetArtifactInfo(race, index)
	return addon.artifactDB[race][index]
end

local function _IsArtifactKnown(character, spellID)
	return character.ArcheologyItems[spellID]
end

local function _GetCraftReagents(recipeID)
	return addon.ref.global.Reagents[recipeID]
end

local function _GetCraftResultItem(recipeID)
	return addon.ref.global.ResultItems[recipeID]
end


local PublicMethods = {
	GetProfession = _GetProfession,
	GetProfessions = _GetProfessions,
	GetProfessionInfo = _GetProfessionInfo,
	GetNumCraftLines = _GetNumCraftLines,
	GetCraftLineInfo = _GetCraftLineInfo,
	GetCraftCooldownInfo = _GetCraftCooldownInfo,
	GetNumActiveCooldowns = _GetNumActiveCooldowns,
	ClearExpiredCooldowns = _ClearExpiredCooldowns,
	GetNumRecipesByColor = _GetNumRecipesByColor,
	IsCraftKnown = _IsCraftKnown,
	GetGuildCrafters = _GetGuildCrafters,
	GetGuildMemberProfession = _GetGuildMemberProfession,
	GetProfessionSpellID = _GetProfessionSpellID,
	GetProfession1 = _GetProfession1,
	GetProfession2 = _GetProfession2,
	GetFirstAidRank = _GetFirstAidRank,
	GetCookingRank = _GetCookingRank,
	GetFishingRank = _GetFishingRank,
	GetArchaeologyRank = _GetArchaeologyRank,
	GetArchaeologyRaceArtifacts = _GetArchaeologyRaceArtifacts,
	GetRaceNumArtifacts = _GetRaceNumArtifacts,
	GetArtifactInfo = _GetArtifactInfo,
	IsArtifactKnown = _IsArtifactKnown,
	GetCraftReagents = _GetCraftReagents,
	GetCraftResultItem = _GetCraftResultItem,
}

function addon:OnInitialize()
	addon.db = LibStub("AceDB-3.0"):New(addonName .. "DB", AddonDB_Defaults)
	addon.ref = LibStub("AceDB-3.0"):New(addonName .. "RefDB", ReferenceDB_Defaults)

	DataStore:RegisterModule(addonName, addon, PublicMethods)
	DataStore:SetCharacterBasedMethod("GetProfession")
	DataStore:SetCharacterBasedMethod("GetProfessions")
	
	DataStore:SetCharacterBasedMethod("GetProfession1")
	DataStore:SetCharacterBasedMethod("GetProfession2")
	DataStore:SetCharacterBasedMethod("GetFirstAidRank")
	DataStore:SetCharacterBasedMethod("GetCookingRank")
	DataStore:SetCharacterBasedMethod("GetFishingRank")
	DataStore:SetCharacterBasedMethod("GetArchaeologyRank")
	DataStore:SetCharacterBasedMethod("IsArtifactKnown")
	
	DataStore:SetGuildBasedMethod("GetGuildCrafters")
	DataStore:SetGuildBasedMethod("GetGuildMemberProfession")
end

function addon:OnEnable()
	addon:RegisterEvent("PLAYER_ALIVE", OnPlayerAlive)
	addon:RegisterEvent("TRADE_SKILL_SHOW", OnTradeSkillShow)
	addon:RegisterEvent("CHAT_MSG_SKILL", OnChatMsgSkill)
	addon:RegisterEvent("CHAT_MSG_SYSTEM", OnChatMsgSystem)
	addon:RegisterEvent("TRADE_SKILL_DATA_SOURCE_CHANGED", OnDataSourceChanged)
		
	local _, _, arch = GetProfessions()

	if arch then
		addon:RegisterEvent("ARTIFACT_HISTORY_READY", OnArtifactHistoryReady)
		addon:RegisterEvent("ARTIFACT_COMPLETE", OnArtifactComplete)
		RequestArtifactCompletionHistory()		-- this will trigger ARTIFACT_HISTORY_READY
	end
	
--	addon:SetupOptions()
	ClearExpiredProfessions()	-- automatically cleanup guild profession links that are from an older version
	LocalizeProfessionSpellIDs()
end

function addon:OnDisable()
	addon:UnregisterEvent("PLAYER_ALIVE")
	addon:UnregisterEvent("TRADE_SKILL_SHOW")
	addon:UnregisterEvent("CHAT_MSG_SKILL")
	addon:UnregisterEvent("CHAT_MSG_SYSTEM")
	addon:UnregisterEvent("TRADE_SKILL_DATA_SOURCE_CHANGED")
end

function addon:IsTradeSkillWindowOpen()
	-- note : maybe there's a function in the WoW API to test this, but I did not find it :(
	return addon.isOpen
end

-- *** Hooks ***
-- Disabled 7.0
-- hooksecurefunc("DoTradeSkill", function(index, repeatCount, ...)
	-- updateCooldowns = true
-- end)
