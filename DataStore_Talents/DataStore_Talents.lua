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
				EquippedArtifact = nil,				-- name of the currently equipped artifact
				ArtifactKnowledge = nil,
				ArtifactKnowledgeMultiplier = nil,
				Artifacts = {
					['*'] = {
						rank = 0,
						pointsRemaining = 0,
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

local function GetArtifactName()
	local info = C_ArtifactUI.GetEquippedArtifactArtInfo()
	return info.titleName
	-- return select(2, C_ArtifactUI.GetArtifactArtInfo())
end


-- *** Scanning functions ***
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

local function ScanArtifact()
	local char = addon.ThisCharacter

	local artifactName = GetArtifactName()

	-- only save the name if the item viewed is the one equipped (since you can right-click an artifact in the bags)
	if C_ArtifactUI.IsViewedArtifactEquipped() then
		char.EquippedArtifact = artifactName
	end
	
	char.ArtifactKnowledge = C_ArtifactUI.GetArtifactKnowledgeLevel()
	char.ArtifactKnowledgeMultiplier = C_ArtifactUI.GetArtifactKnowledgeMultiplier()
	
	local artifact = char.Artifacts[artifactName]
	
	artifact.rank = C_ArtifactUI.GetTotalPurchasedRanks()
	artifact.pointsRemaining = C_ArtifactUI.GetPointsRemaining()
	artifact.tier = select(13, C_ArtifactUI.GetEquippedArtifactInfo())
end

local function ScanArtifactXP()
	local char = addon.ThisCharacter
	
	-- This method provides the right data, except the name because Blizzard is "AGAIN" not consistent in the names it returns.
	-- Ex: Arcane mage: 
	--   C_ArtifactUI.GetArtifactArtInfo() => returns Aluneth, Great staff of ...
	--   C_ArtifactUI.GetEquippedArtifactInfo() => returns only "Aluneth"
	-- local _, _, artifactName, _, remaining = C_ArtifactUI.GetEquippedArtifactInfo()
	
	local _, _, _, _, remaining = C_ArtifactUI.GetEquippedArtifactInfo()
	local artifact = char.Artifacts[GetArtifactName()]
	if artifact then
		artifact.pointsRemaining = remaining
	end
end

-- *** Event Handlers ***
local function OnPlayerAlive()
	ScanTalents()
	ScanTalentReference()
end

local function OnPlayerSpecializationChanged()
	ScanTalents()
	ScanTalentReference()
end

local function OnArtifactUpdate()
	ScanArtifact()
end

local function OnArtifactXPUpdate()
	ScanArtifactXP()
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

-- ** Artifact **
local function _GetArtifactKnowledgeLevel(character)
	return character.ArtifactKnowledge or 0
end

local function _GetArtifactKnowledgeMultiplier(character)
	return character.ArtifactKnowledgeMultiplier or 0
end

local function _GetEquippedArtifact(character)
	return character.EquippedArtifact
end

local function _GetEquippedArtifactRank(character)
	local rank = 0
	
	local equippedArtifact = character.EquippedArtifact
	if equippedArtifact then
		local info = character.Artifacts[equippedArtifact]
		if info and info.rank then
			rank = info.rank
		end
	end
	
	return rank
end

local function _GetEquippedArtifactPower(character)
	local power = 0
	
	local equippedArtifact = character.EquippedArtifact
	if equippedArtifact then
		local info = character.Artifacts[equippedArtifact]
		if info and info.pointsRemaining then
			power = info.pointsRemaining
		end
	end
	
	return power
end

local function _GetEquippedArtifactTier(character)
	local tier = 0
	
	local equippedArtifact = character.EquippedArtifact
	if equippedArtifact then
		local info = character.Artifacts[equippedArtifact]
		if info and info.tier then
			tier = info.tier
		end
	end
	
	return tier
end

local function _GetKnownArtifacts(character)
	return character.Artifacts
end

local function _GetNumArtifactTraitsPurchasableFromXP(currentRank, xpToSpend, currentTier)
	-- this function is exactly the same as 
	-- MainMenuBar_GetNumArtifactTraitsPurchasableFromXP (from MainMenuBar.lua)
	-- but just in case it's not loaded or changes later.. I'll keep it here
	-- Usage: 
	--		DataStore:GetNumArtifactTraitsPurchasableFromXP(1, 945)
	--    artifact is currently at rank 1, and we have 945 points to spend
	
	local numPoints = 0
	local xpForNextPoint = C_ArtifactUI.GetCostForPointAtRank(currentRank, currentTier)

	while xpToSpend >= xpForNextPoint and xpForNextPoint > 0 do
		xpToSpend = xpToSpend - xpForNextPoint

		currentRank = currentRank + 1
		numPoints = numPoints + 1

		xpForNextPoint = C_ArtifactUI.GetCostForPointAtRank(currentRank, currentTier)
	end
	
	-- ex: with rank 1 and 945 points, we have enough points for 2 traits, and 320 / 350 in the last rank
	return numPoints, xpToSpend, xpForNextPoint
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
	GetArtifactKnowledgeLevel = _GetArtifactKnowledgeLevel,
	GetArtifactKnowledgeMultiplier = _GetArtifactKnowledgeMultiplier,
	GetEquippedArtifact = _GetEquippedArtifact,
	GetEquippedArtifactRank = _GetEquippedArtifactRank,
	GetEquippedArtifactPower = _GetEquippedArtifactPower,
	GetEquippedArtifactTier = _GetEquippedArtifactTier,
	GetKnownArtifacts = _GetKnownArtifacts,
	GetNumArtifactTraitsPurchasableFromXP = _GetNumArtifactTraitsPurchasableFromXP,
}

function addon:OnInitialize()
	addon.db = LibStub("AceDB-3.0"):New(addonName .. "DB", AddonDB_Defaults)
	addon.ref = LibStub("AceDB-3.0"):New(addonName .. "RefDB", ReferenceDB_Defaults)

	DataStore:RegisterModule(addonName, addon, PublicMethods)

	DataStore:SetCharacterBasedMethod("GetSpecializationTierChoice")
	DataStore:SetCharacterBasedMethod("GetArtifactKnowledgeLevel")
	DataStore:SetCharacterBasedMethod("GetArtifactKnowledgeMultiplier")
	DataStore:SetCharacterBasedMethod("GetEquippedArtifact")
	DataStore:SetCharacterBasedMethod("GetEquippedArtifactRank")
	DataStore:SetCharacterBasedMethod("GetEquippedArtifactPower")
	DataStore:SetCharacterBasedMethod("GetEquippedArtifactTier")
	DataStore:SetCharacterBasedMethod("GetKnownArtifacts")
end

function addon:OnEnable()
	addon:RegisterEvent("PLAYER_ALIVE", OnPlayerAlive)
	addon:RegisterEvent("PLAYER_TALENT_UPDATE", ScanTalents)
	addon:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED", OnPlayerSpecializationChanged)
	addon:RegisterEvent("ARTIFACT_UPDATE", OnArtifactUpdate)
	addon:RegisterEvent("ARTIFACT_XP_UPDATE", OnArtifactXPUpdate)
end

function addon:OnDisable()
	addon:UnregisterEvent("PLAYER_ALIVE")
	addon:UnregisterEvent("PLAYER_TALENT_UPDATE")
	addon:UnregisterEvent("PLAYER_SPECIALIZATION_CHANGED")
	addon:UnregisterEvent("ARTIFACT_UPDATE")
end
