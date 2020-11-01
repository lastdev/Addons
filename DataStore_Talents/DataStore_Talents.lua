--[[	*** DataStore_Talents ***
Written by : Thaoky, EU-Marécages de Zangar
June 23rd, 2009
--]]
if not DataStore then return end

local addonName = "DataStore_Talents"

_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0")

local addon = _G[addonName]

local AddonDB_Defaults = {
	global = {
		Characters = {
			['*'] = {				-- ["Account.Realm.Name"] 
				lastUpdate = nil,
				Class = nil,							-- englishClass
				Specializations = {},
				AzeriteEssences = {
					['*'] = {
						rankCollected = 0,
					}
				},
			}
		}
	}
}

-- This table saved reference data required to rebuild a talent tree for a class when logged in under another class.
-- The API does not provide that ability, but saving and reusing is fine
local ReferenceDB_Defaults = {
	global = {
		['*'] = {							-- "englishClass" like "MAGE", "DRUID" etc..
			Version = nil,					-- build number under which this class ref was saved
			Locale = nil,					-- locale under which this class ref was saved
			Specializations = {
				['*'] = {					-- tree name
					id = nil,
					icon = nil,
					name = nil,
					talents = {},			-- name, icon, max rank etc..for talent x in this tree
				},
			}
		},
	}
}

--[[
Source : http://www.icy-veins.com/
Last update : 23/09/2016 (7.0)

Note: The priorities come from Icy Veins, although I have not respected them 100%, based on my own experience, view, and discussions with guild mates.
They are meant to be an indication for classes you do not play too often, 
and I do not wish to enter religious discussions about who is right or wrong, or about which stat is actually better :)

ex: in some cases, Icy Veins indicated that the primary stat (STR, INT, ..) has a lesser priority than mastery or crit .. 
well, I still kept the primary stat as #1 in the list, because in most cases, you WILL have this stat on each item.

And if you reach the point where this difference matters, then you probably don't need the information any more, 
because you supposedly already know your class well enough.
--]]

local statPriority = {
	-- Cloth
	["MAGE"] = {
		{ SPELL_STAT4_NAME, STAT_VERSATILITY, STAT_CRITICAL_STRIKE, SPELL_HASTE, STAT_MASTERY }, -- Arcane
		{ SPELL_STAT4_NAME, STAT_CRITICAL_STRIKE, STAT_MASTERY, STAT_VERSATILITY, SPELL_HASTE }, -- Fire
		{ SPELL_STAT4_NAME, SPELL_HASTE, STAT_CRITICAL_STRIKE, STAT_VERSATILITY, STAT_MASTERY }, -- Frost
	},
	["PRIEST"] = {
		{ SPELL_STAT4_NAME, SPELL_HASTE, STAT_CRITICAL_STRIKE, STAT_MASTERY, STAT_VERSATILITY }, -- Discipline
		{ SPELL_STAT4_NAME, STAT_MASTERY, STAT_CRITICAL_STRIKE, SPELL_HASTE, STAT_VERSATILITY }, -- Holy
		{ SPELL_STAT4_NAME, STAT_CRITICAL_STRIKE, SPELL_HASTE, STAT_MASTERY, STAT_VERSATILITY }, -- Shadow
	},	
	["WARLOCK"] = {
		{ SPELL_STAT4_NAME, STAT_MASTERY, STAT_CRITICAL_STRIKE, SPELL_HASTE, STAT_VERSATILITY }, -- Affliction
		{ SPELL_STAT4_NAME, SPELL_HASTE, STAT_CRITICAL_STRIKE, STAT_MASTERY, STAT_VERSATILITY }, -- Demonology
		{ SPELL_STAT4_NAME, SPELL_HASTE, STAT_CRITICAL_STRIKE, STAT_VERSATILITY, STAT_MASTERY }, -- Destruction
	},	
	
	-- Leather
	["DEMONHUNTER"] = {
		{ SPELL_STAT2_NAME, STAT_CRITICAL_STRIKE, STAT_VERSATILITY, SPELL_HASTE, STAT_MASTERY }, -- Havoc
		{ SPELL_STAT2_NAME, STAT_MASTERY, STAT_CRITICAL_STRIKE, STAT_VERSATILITY, SPELL_HASTE }, -- Vengeance
	},
	["ROGUE"] = {
		{ SPELL_STAT2_NAME, STAT_VERSATILITY, STAT_CRITICAL_STRIKE, STAT_MASTERY, SPELL_HASTE }, -- Assassination
		{ SPELL_STAT2_NAME, STAT_VERSATILITY, STAT_CRITICAL_STRIKE, STAT_MASTERY, SPELL_HASTE }, -- Outlaw
		{ SPELL_STAT2_NAME, STAT_VERSATILITY, STAT_MASTERY, STAT_CRITICAL_STRIKE, SPELL_HASTE }, -- Subtlety
	},
	["DRUID"] = {
		{ SPELL_STAT4_NAME, SPELL_HASTE, STAT_CRITICAL_STRIKE, STAT_VERSATILITY, STAT_MASTERY }, -- Balance
		{ SPELL_STAT2_NAME, STAT_MASTERY, STAT_CRITICAL_STRIKE, STAT_VERSATILITY, SPELL_HASTE }, -- Feral
		{ SPELL_STAT2_NAME, STAT_VERSATILITY, STAT_MASTERY, SPELL_HASTE, STAT_CRITICAL_STRIKE }, -- Guardian
		{ SPELL_STAT4_NAME, SPELL_HASTE, STAT_CRITICAL_STRIKE, STAT_MASTERY, STAT_VERSATILITY }, -- Restoration
	},
	["MONK"] = {
		{ SPELL_STAT2_NAME, SPELL_HASTE, STAT_CRITICAL_STRIKE, STAT_MASTERY, STAT_VERSATILITY }, -- Brewmaster
		{ SPELL_STAT4_NAME, STAT_VERSATILITY, STAT_CRITICAL_STRIKE, SPELL_HASTE, STAT_MASTERY }, -- Mistweaver
		{ SPELL_STAT2_NAME, STAT_MASTERY, STAT_VERSATILITY, STAT_CRITICAL_STRIKE, SPELL_HASTE }, -- Windwalker
	},
	
	-- Mail
	["HUNTER"] = {
		{ SPELL_STAT2_NAME, STAT_MASTERY, SPELL_HASTE, STAT_CRITICAL_STRIKE, STAT_VERSATILITY }, -- Beast Mastery
		{ SPELL_STAT2_NAME, STAT_MASTERY, SPELL_HASTE, STAT_CRITICAL_STRIKE, STAT_VERSATILITY }, -- Marksmanship
		{ SPELL_STAT2_NAME, STAT_VERSATILITY, STAT_CRITICAL_STRIKE, STAT_MASTERY, SPELL_HASTE }, -- Survival
	},
	["SHAMAN"] = {
		{ SPELL_STAT4_NAME, STAT_CRITICAL_STRIKE, SPELL_HASTE, STAT_VERSATILITY, STAT_MASTERY }, -- Elemental
		{ SPELL_STAT2_NAME, STAT_MASTERY, SPELL_HASTE, STAT_CRITICAL_STRIKE, STAT_VERSATILITY }, -- Enhancement
		{ SPELL_STAT4_NAME, STAT_MASTERY, STAT_CRITICAL_STRIKE, SPELL_HASTE, STAT_VERSATILITY }, -- Restoration
	},	
	
	-- Plate
	["DEATHKNIGHT"] = {
		{ SPELL_STAT1_NAME, SPELL_HASTE, STAT_MASTERY, STAT_CRITICAL_STRIKE, STAT_VERSATILITY }, -- Blood
		{ SPELL_STAT1_NAME, STAT_CRITICAL_STRIKE, SPELL_HASTE, STAT_MASTERY, STAT_VERSATILITY }, -- Frost
		{ SPELL_STAT1_NAME, SPELL_HASTE, STAT_MASTERY, STAT_CRITICAL_STRIKE, STAT_VERSATILITY }, -- Unholy
	},
	["WARRIOR"] = {
		{ SPELL_STAT1_NAME, STAT_MASTERY, STAT_VERSATILITY, SPELL_HASTE, STAT_CRITICAL_STRIKE }, -- Arms
		{ SPELL_STAT1_NAME, SPELL_HASTE, STAT_MASTERY, STAT_VERSATILITY, STAT_CRITICAL_STRIKE }, -- Fury
		{ SPELL_STAT1_NAME, STAT_VERSATILITY, STAT_MASTERY, SPELL_HASTE, STAT_CRITICAL_STRIKE }, -- Protection
	},
	["PALADIN"] = {
		{ SPELL_STAT4_NAME, STAT_CRITICAL_STRIKE, STAT_VERSATILITY, STAT_MASTERY, SPELL_HASTE }, -- Holy
		{ SPELL_STAT1_NAME, STAT_VERSATILITY, SPELL_HASTE, STAT_MASTERY, STAT_CRITICAL_STRIKE }, -- Protection
		{ SPELL_STAT1_NAME, SPELL_HASTE, STAT_CRITICAL_STRIKE, STAT_VERSATILITY, STAT_MASTERY }, -- Retribution
	},
}


-- *** Utility functions ***
local bAnd = bit.band

local function GetVersion()
	local _, version = GetBuildInfo()
	return tonumber(version)
end

local function LeftShift(value, numBits)
	return value * (2 ^ numBits)
end

local function RightShift(value, numBits)
	-- for bits beyond bit 31
	return math.floor(value / 2^numBits)
end

-- *** Scanning functions ***
local function ScanAzeriteEssences()
    local char = addon.ThisCharacter
    wipe(char.AzeriteEssences)
    
    local essences = C_AzeriteEssence.GetEssences()
    if not essences then return	end
    
    for i, essence in ipairs(essences) do
        char.AzeriteEssences[essence.name] = essence
    end
end

local function ScanTalents()
	local level = UnitLevel("player")
	if not level or level < 15 then return end		-- don't scan anything for low level characters

	local char = addon.ThisCharacter
	local _, englishClass = UnitClass("player")
	char.Class = englishClass
	
	local ref = addon.ref.global[englishClass]
	ref.Version = GetVersion()
	ref.Locale = GetLocale()
	
	local attrib = 0
	local offset = 0
	
	for tier = 1, GetMaxTalentTier() do
		for column = 1, 3 do
			local _, _, _, isSelected = GetTalentInfo(tier, column, 1)		-- param 3 = spec group, always 1 since 7.0
			
			if isSelected then
				-- basically save each tier on 2 bits : 00 = no talent on this tier, 01 = column 1, 10 = column 2, 11 = column 3
				attrib = attrib + LeftShift(column, offset)
				
				break		-- selected talent found on this line, quit this inner-loop
			end
		end
		
		offset = offset + 2		-- each rank takes 2 bits (values 0 to 3)
	end
	
	char.Specializations[GetSpecialization()] = attrib
	char.lastUpdate = time()
end

local function ScanTalentReference()
	local level = UnitLevel("player")
	if not level or level < 15 then return end		-- don't scan anything for low level characters
	
	local _, englishClass = UnitClass("player")
	local ref = addon.ref.global[englishClass]		-- point to global.["MAGE"]
	
	ref.Version = GetVersion()
	ref.Locale = GetLocale()
	
	local specialization = GetSpecialization()
	local specRef = ref.Specializations[specialization]
	
	specRef.id = GetSpecializationInfo(specialization)
	
	wipe(specRef.talents)
	
	for tier = 1, GetMaxTalentTier() do
		for column = 1, 3 do
			local talentID = GetTalentInfo(tier, column, 1)		-- param 3 = spec group, always 1 since 7.0
			-- Retrieve info with : GetTalentInfoByID(talentID)
			
			table.insert(specRef.talents, talentID)
		end
	end
end

-- *** Event Handlers ***
local function OnPlayerAlive()
	ScanTalents()
	ScanTalentReference()
    ScanAzeriteEssences()
end

local function OnPlayerSpecializationChanged()
	ScanTalents()
	ScanTalentReference()
end

local function OnAzeriteEssenceChanged()
    ScanAzeriteEssences()
end

-- ** Mixins **
local function _GetReferenceTable()
	return addon.ref.global
end

local function	_GetClassReference(class)
	if type(class) == "string" then
		return addon.ref.global[class]
	end
end

local function _GetSpecializationReference(class, spec)
	assert(type(class) == "string")
	assert(type(spec) == "number")
	
	return addon.ref.global[class].Specializations[spec]
end

local function _GetSpecializationInfo(class, specialization)
	local spec = _GetSpecializationReference(class, specialization)
	if spec and spec.id then 
		return GetSpecializationInfoByID(spec.id)
	end
end

local function _GetStatPriority(class, specialization)
	if statPriority[class] then
		return statPriority[class][specialization]
	end
end

local function _IsClassKnown(class)
	class = class or ""	-- if by any chance nil is passed, trap it to make sure the function does not fail, but returns nil anyway
	
	local ref = _GetClassReference(class)
	if ref.Locale then		-- if the Locale field is not nil, we have data for this class
		return true
	end
end

local function _ImportClassReference(class, data)
	assert(type(class) == "string")
	assert(type(data) == "table")
	
	addon.ref.global[class] = data
end

local function _GetTalentInfo(class, specialization, row, column)
	local spec = _GetSpecializationReference(class, specialization)
	if not spec then return end
	
	local index = ((row - 1) * 3) + column		-- ex: row 2, column 1 = index 4
	local talentID = spec.talents[index]
	
	if talentID then
		-- id, name, texture, ...
		return GetTalentInfoByID(talentID)
	end
end

local function _GetSpecializationTierChoice(character, specialization, row)
	local attrib = character.Specializations[specialization]
	
	if attrib then
		return bAnd(RightShift(attrib, (row-1)*2), 3)
	end
end

-- ** Essences **
local function _GetAzeriteEssences(character)
	return character.AzeriteEssences
end

local function _GetAzeriteEssenceInfo(character, name)
	return character.AzeriteEssence[name]
end

local PublicMethods = {
	GetReferenceTable = _GetReferenceTable,
	GetClassReference = _GetClassReference,
	GetSpecializationInfo = _GetSpecializationInfo,
	GetStatPriority = _GetStatPriority,
	IsClassKnown = _IsClassKnown,
	ImportClassReference = _ImportClassReference,
	GetTalentInfo = _GetTalentInfo,
	GetSpecializationTierChoice = _GetSpecializationTierChoice,
    GetAzeriteEssences = _GetAzeriteEssences,
    GetAzeriteEssenceInfo = _GetAzeriteEssenceInfo,
}

function addon:OnInitialize()
	addon.db = LibStub("AceDB-3.0"):New(addonName .. "DB", AddonDB_Defaults)
	addon.ref = LibStub("AceDB-3.0"):New(addonName .. "RefDB", ReferenceDB_Defaults)

	DataStore:RegisterModule(addonName, addon, PublicMethods)

	DataStore:SetCharacterBasedMethod("GetSpecializationTierChoice")

	DataStore:SetCharacterBasedMethod("GetAzeriteEssences")
	DataStore:SetCharacterBasedMethod("GetAzeriteEssenceInfo")
end

function addon:OnEnable()
	addon:RegisterEvent("PLAYER_ALIVE", OnPlayerAlive)
	addon:RegisterEvent("PLAYER_TALENT_UPDATE", ScanTalents)
	addon:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED", OnPlayerSpecializationChanged)
    addon:RegisterEvent("AZERITE_ESSENCE_CHANGED", OnAzeriteEssenceChanged)
end

function addon:OnDisable()
	addon:UnregisterEvent("PLAYER_ALIVE")
	addon:UnregisterEvent("PLAYER_TALENT_UPDATE")
	addon:UnregisterEvent("PLAYER_SPECIALIZATION_CHANGED")
    addon:UnregisterEvent("AZERITE_ESSENCE_CHANGED")
end
