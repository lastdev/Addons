--[[	*** DataStore_Pets ***
Written by : Thaoky, EU-Marécages de Zangar
June 22st, 2009
--]]
if not DataStore then return end

local addonName, addon = ...
local thisCharacter
local petGUIDs

local C_PetJournal, GetSpellInfo, tonumber, format = C_PetJournal, GetSpellInfo, tonumber, format

-- *** Utility functions ***
--[[
local function GetPetReference(guid)
	local modelID = petGUIDs[guid]
	local name, icon
	
	if modelID then
		local info = C_PetJournal.GetPetInfoTableByPetID(guid)
		if info then
			name = info.name
			icon = info.icon
		end
	end
	
	return modelID, name, icon	
end
--]]

-- *** Scanning functions ***
local function ScanCritters()
	local char = thisCharacter
	-- char.Critters = char.Critters or {}
	-- wipe(char.Critters)

	-- https://wowpedia.fandom.com/wiki/API_C_PetJournal.GetNumPets
	local numPets, numOwned = C_PetJournal.GetNumPets()

	for index = 1, numOwned do
		local petID = C_PetJournal.GetPetInfoByIndex(index)
		
		if petID then
			local info = C_PetJournal.GetPetInfoTableByPetID(petID)
			
			if info then
				local modelID = info.creatureID
				
				if modelID and petID then
					petGUIDs[petID] = modelID
					-- char.Critters[index] = petID
				end
			end
		end
	end

	char.lastUpdate = time()
end


-- ** Mixins **
--[[
local function _GetPets(character)
	return character.Critters
end

local function _GetPetInfo(pets, index)
	local guid = pets[index]
	if guid then
		local modelID, name, icon = GetPetReference(guid)
		return modelID, name, guid, icon
	end
end
--]]

local function _IsPetKnown(spellID)
	
	-- Find the pet name
	local petName = GetSpellInfo(spellID)
	if not petName then return end
	
	-- Find the pet ID
	local _, petID = C_PetJournal.FindPetIDByName(petName)
	if not petID then return end
	
	return petGUIDs[petID] and true or false
end

local function _GetBattlePetInfoFromLink(link)
	if not link then return end

	local speciesID, level, breedQuality, maxHealth, power, speed = link:match("|Hbattlepet:(%d+):(%d+):(%d+):(%d+):(%d+):(%d+)")
	if speciesID then
		local name = link:match("%[(.+)%]")
		return tonumber(speciesID), tonumber(level), tonumber(breedQuality), tonumber(maxHealth), tonumber(power), tonumber(speed), name
	end
end

DataStore:OnAddonLoaded(addonName, function() 
	DataStore:RegisterModule({
		addon = addon,
		addonName = addonName,
		rawTables = {
			"DataStore_Pets_GUIDs"			-- ["petGUID"] = modelID
		},
		characterTables = {
			["DataStore_Pets_Characters"] = {
				-- GetPets = _GetPets,
			},
		}
	})
	
	-- DataStore:RegisterMethod(addon, "GetPetInfo", _GetPetInfo)
	DataStore:RegisterMethod(addon, "IsPetKnown", _IsPetKnown)
	DataStore:RegisterMethod(addon, "GetBattlePetInfoFromLink", _GetBattlePetInfoFromLink)
	
	DataStore:RegisterMethod(addon, "GetCompanionLink", function(spellID)
		local name = GetSpellInfo(spellID)
		return format("|cff71d5ff|Hspell:%s|h[%s]|h|r", spellID, name)
	end)
	
	DataStore:RegisterMethod(addon, "GetCompanionList", function() return addon.CompanionList end)
	DataStore:RegisterMethod(addon, "GetCompanionSpellID", function(itemID)
		-- returns spellID if itemID is known, nil otherwise
		return addon.CompanionToSpellID[itemID]
	end)
	
	thisCharacter = DataStore:GetCharacterDB("DataStore_Pets_Characters", true)
	petGUIDs = DataStore_Pets_GUIDs
end)

DataStore:OnPlayerLogin(function() 
	addon:ListenTo("PLAYER_ALIVE", ScanCritters)
	addon:ListenTo("COMPANION_LEARNED", ScanCritters)
	addon:ListenTo("COMPANION_UPDATE", function()
		-- COMPANION_UPDATE is triggered very often, but after the very first call, pets & mounts can be scanned automatically.
		-- After that, we only need to track COMPANION_LEARNED
		addon:StopListeningTo("COMPANION_UPDATE")
		
		ScanCritters()
	end)
end)
