--[[	*** DataStore_Pets ***
Written by : Thaoky, EU-Marécages de Zangar
June 22st, 2009
--]]
if not DataStore then return end

local addonName = "DataStore_Pets"

_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0")

local addon = _G[addonName]

local AddonDB_Defaults = {
	global = {
		Reference = {
			Spells = {},			-- spell ids are unique, so both mounts & pets are in the same table
			CompanionGUIDs = {},	-- updated for the new API, testing to see if this works -- TechnoHunter
		},
		Characters = {
			['*'] = {				-- ["Account.Realm.Name"] 
				lastUpdate = nil,
				CRITTER = {},		-- companion types are used as table names
				MOUNT = {},
			}
		}
	}
}

local INVALID_COMPANION_TYPE = "Invalid companionType passed, must be \"CRITTER\" or \"MOUNT\""

local CompanionTypes = {
	["CRITTER"] = {
		GetNum = function(self)
				return select(2, C_PetJournal.GetNumPets())
			end,
		GetReference = function(self, spellID)
				local modelID = addon.db.global.Reference.CompanionGUIDs[spellID]
				local name, icon
				
				if modelID then
					local info = C_PetJournal.GetPetInfoTableByPetID(spellID)
					if info then
						name = info.name
						icon = info.icon
					end
				end
				
				return modelID, name, icon
			end,
		GetInfo = function(self, index)
				-- CRITTERs use C_PetJournal.GetPetInfoByIndex(index) which has return values of 
				--     petID, speciesID, owned, customName, level, favorite, isRevoked, speciesName, 
				--     icon, petType, companionID, tooltip, description, isWild, canBattle, isTradeable,
				--     isUnique, obtainable = C_PetJournal.GetPetInfoByIndex(index)
				
				local petID = C_PetJournal.GetPetInfoByIndex(index)
				if petID then
					local info = C_PetJournal.GetPetInfoTableByPetID(petID)
					if info then
						return info.creatureID, petID
					end
				end
			end,
	},
	["MOUNT"] = {
		GetNum = function(self)
				return C_MountJournal.GetNumDisplayedMounts()
			end,
		GetReference = function(self, spellID)
				local modelID = addon.db.global.Reference.Spells[spellID]
				local name, icon

				if modelID then
					name, _, icon = C_MountJournal.GetMountInfoByID(modelID)
				end
				
				return modelID, name, icon
			end,
		GetInfo = function(self, index)
				-- MOUNTs use C_MountJournal.GetMountInfoByID(mountID) which has return values of 
				--     name, spellID, icon, isActive, isUsable, sourceType, isFavorite, isFactionSpecific,
				--     faction, shouldHideOnChar, isCollected, mountID = C_MountJournal.GetMountInfoByID(mountID)
				--     = C_MountJournal.GetDisplayedMountInfo(displayIndex)
				
				local mountID = C_MountJournal.GetDisplayedMountID(index)
				if mountID then
					local _, spellID = C_MountJournal.GetMountInfoByID(mountID)
					if spellID then
						return spellID, mountID
					end
				end
			end,
	}
}

-- *** Utility functions ***
local function GetPetReference(spellID, companionType)
	assert(companionType == "CRITTER" or "MOUNT", INVALID_COMPANION_TYPE)
	
	local Companion = CompanionTypes[companionType]
	return Companion:GetReference(spellID)
end

-- *** Scanning functions ***
local function ScanCompanions(companionType)
	assert(companionType == "CRITTER" or "MOUNT", INVALID_COMPANION_TYPE)
	
	local list = addon.ThisCharacter[companionType]
	local refSpells = addon.db.global.Reference.Spells
	local refGUID = addon.db.global.Reference.CompanionGUIDs
	local Companion = CompanionTypes[companionType]

	wipe(list)
	
	for index = 1, Companion:GetNum() do
		if companionType == "CRITTER" then
			local modelID, petGUID = Companion:GetInfo(index)
			
			if modelID and petGUID then
				refGUID[petGUID] = modelID
				list[index] = petGUID
			end
			
		elseif companionType == "MOUNT" then
			local spellID, mountID = Companion:GetInfo(index)
			
			if spellID and mountID then
				refSpells[spellID] = mountID
				list[index] = spellID
			end
		end
	end

	addon.ThisCharacter.lastUpdate = time()
end

-- *** Event Handlers ***
local function OnPlayerAlive()
	ScanCompanions("CRITTER")
end

local function OnCompanionUpdate()
	-- COMPANION_UPDATE is triggered very often, but after the very first call, pets & mounts can be scanned automatically. After that, we only need to track COMPANION_LEARNED
	addon:UnregisterEvent("COMPANION_UPDATE")
	ScanCompanions("CRITTER")
end

local function OnCompanionLearned()
	ScanCompanions("CRITTER")
end

-- ** Mixins **
local function _GetPets(character, companionType)
	return character[companionType]
end

local function _GetNumPets(pets)
	assert(type(pets) == "table")		-- this is the pointer to a pet table, obtained through GetPets()
	return #pets
end

local function _GetPetInfo(pets, index, companionType)
	local spellID = pets[index]
	if spellID then
		local modelID, name, icon = GetPetReference(spellID, companionType)
		return modelID, name, spellID, icon
	end
end

local function _IsPetKnown(character, companionType, spellID)
	local pets = _GetPets(character, companionType)
	for i = 1, #pets do
		local _, _, id = _GetPetInfo(pets, i, companionType)
		
		if companionType == "CRITTER" then
			local petName = GetSpellInfo(spellID)
			if petName then
				local _, petID = C_PetJournal.FindPetIDByName(petName)
				if petID then
					spellID = petID
				end
			end
		end
		
		if id == spellID then
			return true			-- returns true if a given spell ID is a known pet or mount
		end
	end
end

local function _GetCompanionList()
	return addon.CompanionList
end

local function _GetCompanionSpellID(itemID)
	-- returns nil if  id is not in the DB, returns the spellID otherwise
	return addon.CompanionToSpellID[itemID]
end

local function _GetCompanionLink(spellID)
	local name = GetSpellInfo(spellID)
	return format("|cff71d5ff|Hspell:%s|h[%s]|h|r", spellID, name)
end

local function _GetBattlePetInfoFromLink(link)
	if not link then return end

	local speciesID, level, breedQuality, maxHealth, power, speed = link:match("|Hbattlepet:(%d+):(%d+):(%d+):(%d+):(%d+):(%d+)")
	if speciesID then
		local name = link:match("%[(.+)%]")
		return tonumber(speciesID), tonumber(level), tonumber(breedQuality), tonumber(maxHealth), tonumber(power), tonumber(speed), name
	end
end

local PublicMethods = {
	GetPets = _GetPets,
	GetNumPets = _GetNumPets,
	GetPetInfo = _GetPetInfo,
	IsPetKnown = _IsPetKnown,
	GetCompanionList = _GetCompanionList,
	GetCompanionSpellID = _GetCompanionSpellID,
	GetCompanionLink = _GetCompanionLink,
	GetBattlePetInfoFromLink = _GetBattlePetInfoFromLink,
}

function addon:OnInitialize()
	addon.db = LibStub("AceDB-3.0"):New(addonName .. "DB", AddonDB_Defaults)

	DataStore:RegisterModule(addonName, addon, PublicMethods)
	DataStore:SetCharacterBasedMethod("GetPets")
	DataStore:SetCharacterBasedMethod("IsPetKnown")
end

function addon:OnEnable()
	addon:RegisterEvent("PLAYER_ALIVE", OnPlayerAlive)
	addon:RegisterEvent("COMPANION_UPDATE", OnCompanionUpdate)
	addon:RegisterEvent("COMPANION_LEARNED", OnCompanionLearned)
end

function addon:OnDisable()
	addon:UnregisterEvent("PLAYER_ALIVE")
	addon:UnregisterEvent("COMPANION_LEARNED")
end
