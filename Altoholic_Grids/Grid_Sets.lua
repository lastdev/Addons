local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors
local icons = addon.Icons

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local bAnd = bit.band

local view
local isViewValid
local currentTier

local OPTION_PVE = "UI.Tabs.Grids.Sets.IncludePVE"
local OPTION_PVP = "UI.Tabs.Grids.Sets.IncludePVP"
local OPTION_XPACK = "UI.Tabs.Grids.Sets.CurrentXPack"
local OPTION_PVPDESC_PREFIX = "UI.Tabs.Grids.Sets.PVP."

local TEXTURE_FONT = "|T%s:%s:%s|t"

local xPacks = {
	EXPANSION_NAME0,	-- "Classic"
	EXPANSION_NAME1,	-- "The Burning Crusade"
	EXPANSION_NAME2,	-- "Wrath of the Lich King"
	EXPANSION_NAME3,	-- "Cataclysm"
	EXPANSION_NAME4,	-- "Mists of Pandaria"
	EXPANSION_NAME5,	-- "Warlords of Draenor"
	EXPANSION_NAME6,	-- "Legion"
	L["All-in-one"],
}

local CAT_ALLINONE = #xPacks

local classMasks = {
	[1] = "WARRIOR",
	[2] = "PALADIN",
	[4] = "HUNTER",
	[8] = "ROGUE",
	[16] = "PRIEST",
	[32] = "DEATHKNIGHT",
	[64] = "SHAMAN",
	[128] = "MAGE",
	[256] = "WARLOCK",
	[512] = "MONK",
	[1024] = "DRUID",
	[2048] = "DEMONHUNTER"
}	

local function FormatSetDescription(setInfo)
	local line1 = format("%s%s", colors.white, setInfo.label)
	local line2 = ""
	local description = (setInfo.description) and format("%s - %s", colors.cyan, setInfo.description) or ""

	if setInfo.requiredFaction then
		local icon = icons[setInfo.requiredFaction]
		line1 = format("%s %s", line1, format(TEXTURE_FONT, icon, 18, 18))
	end

	if setInfo.tier then
		line2 = format("%s%s %s%s%s", colors.gold, "Tier", colors.green, setInfo.tier, description)
	end

	return format("%s\n%s", line1, line2)
end

local function IsPVPDescriptionChecked(description)
	local optionName = format("%s%s", OPTION_PVPDESC_PREFIX, description)
	local option = addon:GetOption(optionName)
	
	if type(option) == "nil" then		-- if the option does not exist (first use), then initialize it to true
		addon:SetOption(optionName, true)
		option = true
	end

	return option
end

-- Mage set id's are used as reference for tier data
local TransmogSets = {
	-- each entry will be enriched with extra data
	-- ["WARRIOR"] = set id (for all classes), description, label, requiredFaction

	{	-- [1] Classic
		{ setID = 910, tier = 1 },				-- Molten Core
		{ setID = 909, tier = 2 },				-- Blackwing Lair
		{ setID = 908, tier = 2.5 },			-- Temple of Ahn'Qiraj 
		{ setID = 907, tier = 3 },				-- Naxxramas
		{ setID = 855 },							-- Darkmoon Faire
	},
	{	-- [2] The Burning Crusade
		{ setID = 898, tier = 4 },				-- Gruul's Lair
		{ setID = 905, tier = 5 },				-- Serpentshrine Cavern
		{ setID = 904, tier = 6 },				-- Black Temple
		{ setID = 903, tier = 6 },				-- Sunwell Plateau
		{ setID = 975, tier = 1, isPVP = true },		-- Season 1
		{ setID = 967, tier = 2, isPVP = true },		-- Season 2
		{ setID = 959, tier = 3, isPVP = true },		-- Season 3
		{ setID = 951, tier = 4, isPVP = true },		-- Season 4
	},
	{	-- [3] Wrath of the Lich King
		{ setID = 726, tier = 7 },				-- Naxxramas
		{ setID = 727, tier = 7 },				-- Naxxramas
		{ setID = 724, tier = 8 },				-- Ulduar
		{ setID = 725, tier = 8 },				-- Ulduar
		{ setID = 722, tier = 9 },				-- Trial of the Crusader
		{ setID = 723, tier = 9 },				-- Trial of the Crusader
		{ setID = 719, tier = 10 },			-- Icecrown Citadel
		{ setID = 720, tier = 10 },			-- Icecrown Citadel
		{ setID = 721, tier = 10 },			-- Icecrown Citadel
		{ setID = 811, tier = 5, isPVP = true },		-- Season 5
		{ setID = 802, tier = 5, isPVP = true },		-- Season 5
		{ setID = 793, tier = 5, isPVP = true },		-- Season 5
		{ setID = 784, tier = 6, isPVP = true },		-- Season 6
		{ setID = 775, tier = 7, isPVP = true },		-- Season 7
		{ setID = 766, tier = 8, isPVP = true },		-- Season 8
	},
	{	-- [4] Cataclysm
		{ setID = 717, tier = 11 },			-- The Bastion of Twilight
		{ setID = 718, tier = 11 },			-- The Bastion of Twilight
		{ setID = 715, tier = 12 },			-- Firelands
		{ setID = 716, tier = 12 },			-- Firelands
		{ setID = 713, tier = 13 },			-- Dragon Soul
		{ setID = 712, tier = 13 },			-- Dragon Soul
		{ setID = 714, tier = 13 },			-- Dragon Soul
		{ setID = 1198, tier = 9, isPVP = true },		-- Season 9
		{ setID = 753, tier = 9, isPVP = true },		-- Season 9
		{ setID = 754, tier = 9, isPVP = true },		-- Season 9
		{ setID = 618, tier = 10, isPVP = true },		-- Season 10
		{ setID = 619, tier = 10, isPVP = true },		-- Season 10
		{ setID = 598, tier = 11, isPVP = true },		-- Season 11
		{ setID = 599, tier = 11, isPVP = true },		-- Season 11
	},
	{	-- [5] Mists of Pandaria
		{ setID = 531, tier = 14 },			-- Heart of Fear
		{ setID = 529, tier = 14 },			-- Heart of Fear
		{ setID = 530, tier = 14 },			-- Heart of Fear
		{ setID = 528, tier = 15 },			-- Throne of Thunder
		{ setID = 526, tier = 15 },			-- Throne of Thunder
		{ setID = 527, tier = 15 },			-- Throne of Thunder
		{ setID = 525, tier = 16 },			-- Siege of Orgrimmar
		{ setID = 523, tier = 16 },			-- Siege of Orgrimmar
		{ setID = 524, tier = 16 },			-- Siege of Orgrimmar
		{ setID = 197, tier = 12, isPVP = true },		-- Season 12
		{ setID = 276, tier = 12, isPVP = true },		-- Season 12
		{ setID = 1057, tier = 12, isPVP = true },	-- Season 12
		{ setID = 275, tier = 13, isPVP = true },		-- Season 13 A
		{ setID = 264, tier = 13, isPVP = true },		-- Season 13 H
		{ setID = 1016, tier = 13, isPVP = true },	-- Season 13 A
		{ setID = 1017, tier = 13, isPVP = true },	-- Season 13 H
		{ setID = 219, tier = 14, isPVP = true },		-- Season 14 A
		{ setID = 209, tier = 14, isPVP = true },		-- Season 14 H
		{ setID = 1036, tier = 14, isPVP = true },	-- Season 14 A
		{ setID = 1037, tier = 14, isPVP = true },	-- Season 14 H
		{ setID = 242, tier = 15, isPVP = true },		-- Season 15 A
		{ setID = 253, tier = 15, isPVP = true },		-- Season 15 H
		{ setID = 1079, tier = 15, isPVP = true },	-- Season 15 A
		{ setID = 1080, tier = 15, isPVP = true },	-- Season 15 H
	},
	{	-- [6] Warlords of Draenor
		{ setID = 520, tier = 17 },			-- Blackrock Foundry
		{ setID = 521, tier = 17 },			-- Blackrock Foundry
		{ setID = 522, tier = 17 },			-- Blackrock Foundry
		{ setID = 581, tier = 18 },			-- Hellfire Citadel LFR (multi-class)
		{ setID = 517, tier = 18 },			-- Hellfire Citadel
		{ setID = 519, tier = 18 },			-- Hellfire Citadel
		{ setID = 518, tier = 18 },			-- Hellfire Citadel
		{ setID = 78, tier = 16, isPVP = true },		-- Warlords Season 1 A
		{ setID = 77, tier = 16, isPVP = true },		-- Warlords Season 1 H
		{ setID = 144, tier = 16, isPVP = true },		-- Warlords Season 1 A
		{ setID = 143, tier = 16, isPVP = true },		-- Warlords Season 1 H
		{ setID = 1144, tier = 16, isPVP = true },	-- Warlords Season 1 A
		{ setID = 1145, tier = 16, isPVP = true },	-- Warlords Season 1 H
		{ setID = 29, tier = 17, isPVP = true },		-- Warlords Season 2 A
		{ setID = 30, tier = 17, isPVP = true },		-- Warlords Season 2 H
		{ setID = 100, tier = 17, isPVP = true },		-- Warlords Season 2 A
		{ setID = 99, tier = 17, isPVP = true },		-- Warlords Season 2 H
		{ setID = 1179, tier = 17, isPVP = true },	-- Warlords Season 2 A
		{ setID = 1180, tier = 17, isPVP = true },	-- Warlords Season 2 H
		{ setID = 53, tier = 18, isPVP = true },		-- Warlords Season 3 A
		{ setID = 54, tier = 18, isPVP = true },		-- Warlords Season 3 H
		{ setID = 100, tier = 18, isPVP = true },		-- Warlords Season 3 A
		{ setID = 99, tier = 18, isPVP = true },		-- Warlords Season 3 H
		{ setID = 1179, tier = 18, isPVP = true },	-- Warlords Season 3 A
		{ setID = 1180, tier = 18, isPVP = true },	-- Warlords Season 3 H
	},
	{	-- [7] Legion
		{ setID = 160 },							-- Legion Invasions
		{ setID = 516 },							-- Legion Order Hall
		{ setID = 989, tier = 19 },			-- The Nighthold
		{ setID = 986, tier = 19 },			-- The Nighthold
		{ setID = 987, tier = 19 },			-- The Nighthold
		{ setID = 988, tier = 19 },			-- The Nighthold
		{ setID = 174, tier = "/" },			-- Trial of Valor
		{ setID = 172, tier = "/" },			-- Trial of Valor
		{ setID = 171, tier = "/" },			-- Trial of Valor
		{ setID = 173, tier = "/" },			-- Trial of Valor
		{ setID = 1323, tier = 20 },			-- Tomb of Sargeras
		{ setID = 1321, tier = 20 },			-- Tomb of Sargeras
		{ setID = 1324, tier = 20 },			-- Tomb of Sargeras
		{ setID = 1322, tier = 20 },			-- Tomb of Sargeras
		{ setID = 1137, tier = "19+20", isPVP = true,
			["DEATHKNIGHT"] = 1163,				-- Manual fix, this set has no proper label in the table returned by the game
		},		-- Legion Season 1 and 2 A
		{ setID = 1159, tier = "19+20", isPVP = true },		-- Legion Season 1 and 2 H
		{ setID = 1094, tier = "19+20", isPVP = true },		-- Legion Season 1 and 2 A
		{ setID = 1093, tier = "19+20", isPVP = true },		-- Legion Season 1 and 2 H
		{ setID = 1096, tier = "19+20", isPVP = true },		-- Legion Season 1 and 2 A
		{ setID = 1095, tier = "19+20", isPVP = true },		-- Legion Season 1 and 2 H
		{ setID = 1284, tier = "21+22", isPVP = true },		-- Legion Season 3 and 4 A
		{ setID = 1283, tier = "21+22", isPVP = true },		-- Legion Season 3 and 4 H
		{ setID = 1249, tier = "21+22", isPVP = true },		-- Legion Season 3 and 4 A
		{ setID = 1250, tier = "21+22", isPVP = true },		-- Legion Season 3 and 4 H
		{ setID = 1251, tier = "21+22", isPVP = true },		-- Legion Season 3 and 4 A
		{ setID = 1252, tier = "21+22", isPVP = true },		-- Legion Season 3 and 4 H
	},
}

local pvpSortedDescriptions = {}

local function InitTransmogSetsInfo(sets)
	if not sets then return end

	function SetMatchesRefenceSet(set, referenceSet)
		-- we will be trying to find sets that have the same properties as the reference set
		-- ex:	
		--		["description"] = "Combatant",
		-- 	["label"] = "Warlords Season 2",
		-- 	["expansionID"] = 5,
		-- 	["requiredFaction"] = "Alliance",
		-- Note : Do not use ["uiOrder"], it may differ for sets of the same tier (blizzard bug I guess)

		-- if any basic property does not match, exit
		if set.description ~= referenceSet.description or
			set.label ~= referenceSet.label or
			set.expansionID ~= referenceSet.expansionID  then
			return false
		end

		-- if a required faction is defined, and it does not match, exit
		if set.requiredFaction and referenceSet.requiredFaction and
			set.requiredFaction ~= referenceSet.requiredFaction then
			return false
		end

		-- everything matches, we found a matching set
		return true
	end

	local setIndexes = {}

	-- determine indexes for sets: [set id 13] = position 1
	for index, set in ipairs(sets) do
		setIndexes[set.setID] = index
	end

	local pvpDescriptions = {}
	
	-- browse tracked sets
	for xpackIndex, xpack in ipairs(TransmogSets) do
		for setInfoIndex, setInfo in ipairs(xpack) do
			local setID = setInfo.setID
			local refSet = sets[setIndexes[setID]]	-- reference set : mage

			local matchCount = 0
			
			-- browse all sets
			for _, set in ipairs(sets) do
				-- attempt to match current set with the reference (ie: part of the same tier ?)
				if SetMatchesRefenceSet(set, refSet) then
					-- some sets are for multiple classes ..
					for classMask, class in pairs(classMasks) do
						-- check if the bit for that class is set ..
						if bAnd(set.classMask, classMask) ~= 0 then
							setInfo[class] = set.setID		-- .. if yes, apply the set id
						end
					end

					setInfo.label = set.label
					setInfo.description = set.description
					setInfo.requiredFaction = set.requiredFaction
				
					-- keep track of pvp descriptions
					if set.description and setInfo.isPVP then
						pvpDescriptions[set.description] = true
					end
				
					-- save some cpu cycles, when 12 sets are found matching the reference, break the loop
					matchCount = matchCount + 1
					if matchCount == 12 then break end
				end
			end
		end
	end
	
	for desc, _ in pairs(pvpDescriptions) do
		table.insert(pvpSortedDescriptions, desc)
	end
	table.sort(pvpSortedDescriptions)
end

InitTransmogSetsInfo(C_TransmogSets.GetAllSets())

local function BuildView()
	view = view or {}
	wipe(view)

	local includePVE = addon:GetOption(OPTION_PVE)
	local includePVP = addon:GetOption(OPTION_PVP)
	local includeAlliance = addon:GetOption(format("%s%s", OPTION_PVPDESC_PREFIX, FACTION_ALLIANCE))
	local includeHorde = addon:GetOption(format("%s%s", OPTION_PVPDESC_PREFIX, FACTION_HORDE))
	local currentXPack = addon:GetOption(OPTION_XPACK)
	
	local activePVPTypes = {}
	
	for _, pvpDescription in ipairs(pvpSortedDescriptions) do
		if IsPVPDescriptionChecked(pvpDescription) then
			activePVPTypes[pvpDescription] = true
		end
	end

	-- Parse set data
	for xpackIndex, xpack in ipairs(TransmogSets) do
		for _, setInfo in ipairs(xpack) do
			local isPVP = setInfo.isPVP
			local factionOK = true	-- will remain true if no "requiredFaction" is set
			local descOK = false

			-- For PVP sets only: check is the description is one we want to show (ex: hide all "Elite" sets)
			if isPVP and setInfo.description then
				descOK = activePVPTypes[setInfo.description]
			end
			
			local faction = setInfo.requiredFaction
			if faction then
				if ((faction == FACTION_ALLIANCE) and not includeAlliance) or
					((faction == FACTION_HORDE) and not includeHorde) then
					factionOK = false
				end
			end

			if (not isPVP and includePVE and factionOK) or		-- it is a PVE set, and we want it
				(isPVP and includePVP and descOK and factionOK) then		-- it is a PVP set, and we want it, and it's description is OK

				if (currentXPack == CAT_ALLINONE) or (currentXPack == xpackIndex) then
					table.insert(view, setInfo)	-- insert the table pointer
				end
			end
		end
	end
	
	isViewValid = true
end

local function OnPVEClicked(self)
	addon:ToggleOption(nil, OPTION_PVE)
	isViewValid = nil
	AltoholicTabGrids:Update()
end

local function OnPVPClicked(self)
	addon:ToggleOption(nil, OPTION_PVP)
	isViewValid = nil
	AltoholicTabGrids:Update()
end

local function OnXPackChange(self)
	local currentXPack = self.value
	
	addon:SetOption(OPTION_XPACK, currentXPack)
	isViewValid = nil

	AltoholicTabGrids:SetViewDDMText(xPacks[currentXPack])
	AltoholicTabGrids:Update()
end

local function OnPVPFilterChanged(frame)
	frame:GetParent():Close()

	local description = frame.value
	local optionName = format("%s%s", OPTION_PVPDESC_PREFIX, description)
	
	addon:ToggleOption(nil, optionName)
	isViewValid = nil
	AltoholicTabGrids:Update()
end

local function DropDown_Initialize(frame, level)
	if not level then return end
	
	
	if level == 1 then
		frame:AddButton(TRANSMOG_SET_PVE, nil, OnPVEClicked, nil, addon:GetOption(OPTION_PVE), level)
		
		local info = frame:CreateInfo()
		info.text = TRANSMOG_SET_PVP
		info.func = OnPVPClicked
		info.hasArrow = 1
		info.checked = addon:GetOption(OPTION_PVP)
		info.value = nil
		frame:AddButtonInfo(info, level)
		frame:AddTitle(" ")

		local currentXPack = addon:GetOption(OPTION_XPACK)
		for i, xpack in pairs(xPacks) do
			frame:AddButton(xpack, i, OnXPackChange, nil, (i==currentXPack), level)
		end
		
		frame:AddCloseMenu()
	elseif level == 2 then
		frame:AddButton(FACTION_ALLIANCE, FACTION_ALLIANCE, OnPVPFilterChanged, nil, IsPVPDescriptionChecked(FACTION_ALLIANCE), level)
		frame:AddButton(FACTION_HORDE, FACTION_HORDE, OnPVPFilterChanged, nil, IsPVPDescriptionChecked(FACTION_HORDE), level)
		frame:AddTitle(" ", nil, 2)
	
		for _, pvpDescription in ipairs(pvpSortedDescriptions) do
			frame:AddButton(pvpDescription, pvpDescription, OnPVPFilterChanged, nil, IsPVPDescriptionChecked(pvpDescription), level)
		end
	end
end

local callbacks = {
	OnUpdate = function() 
			if not isViewValid then
				BuildView()
			end
		end,
	GetSize = function() return #view end,
	RowSetup = function(self, rowFrame, dataRowID)
			currentTier = view[dataRowID]
			rowFrame.Name.Text:SetText(FormatSetDescription(currentTier))
			rowFrame.Name.Text:SetJustifyH("LEFT")
		end,
	RowOnEnter = function()	end,
	RowOnLeave = function() end,
	ColumnSetup = function(self, button, dataRowID, character)
			local _, englishClass = DataStore:GetCharacterClass(character)
			local setID = currentTier[englishClass]

			button.Name:SetFontObject("GameFontNormalSmall")
			button.Name:SetJustifyH("CENTER")
			button.Name:SetPoint("BOTTOMRIGHT", 5, 0)
			button.Background:SetDesaturated(false)

			if setID then
				button.Background:SetTexture(DataStore:GetSetIcon(setID))
				button.Background:SetTexCoord(0, 1, 0, 1)

				if DataStore:IsSetCollected(setID) then
					button.Background:SetVertexColor(1, 1, 1)
					button.Name:SetText(icons.ready)
				else
					button.Name:SetFontObject("NumberFontNormalSmall")
					button.Name:SetJustifyH("RIGHT")
					button.Name:SetPoint("BOTTOMRIGHT", 0, 0)

					local numCollected, numTotal = DataStore:GetCollectedSetInfo(setID)
					local text = icons.notReady
					if numCollected ~= 0 then
						text = format("%s%s/%s", colors.green, numCollected, numTotal)
					end

					button.Background:SetVertexColor(0.3, 0.3, 0.3)	-- greyed out
					button.Name:SetText(text)
				end
				
				button.key = character		
				button:SetID(setID)
				button:Show()
			else
				button.key = nil
				button:SetID(0)
				button:Hide()
			end
		end,
		
	OnEnter = function(frame) 
			local character = frame.key
			if not character then return end
			
			local setID = frame:GetID()
			if not setID then return end

			local class, englishClass = DataStore:GetCharacterClass(character)
			local classColor = DataStore:GetClassColor(englishClass)
			local numCollected, numTotal = DataStore:GetCollectedSetInfo(setID)


			local info = C_TransmogSets.GetSetInfo(setID)
			local setName = info.name or format("Set %s", setID)
			local setTier = info.label or format("Set %s", setID)

			local tt = AltoTooltip
			tt:SetOwner(frame, "ANCHOR_LEFT");
			tt:ClearLines();
			tt:AddDoubleLine(setName, format("%s%s", classColor, class))
			tt:AddDoubleLine(
				format("%s%s", colors.white, setTier), 
				format("%s%s/%s", colors.green, numCollected, numTotal))
			tt:AddLine(" ",1,1,1)

			local sources = C_TransmogSets.GetSetSources(setID)
			local isComplete = DataStore:IsSetCollected(setID)
			
			local itemsMissing = false

			for sourceID, _ in pairs(sources) do
				local icon = icons.notReady
				
				if isComplete or DataStore:IsSetItemCollected(setID, sourceID) then
					icon = icons.ready
				end

				local info = C_TransmogCollection.GetSourceInfo(sourceID)

				-- GetItemInfo may not be able to return all info immediately
				-- so alleviate the impact on the UI by warning the user
				local itemName, _, itemRarity = GetItemInfo(info.itemID)
				if itemName and itemRarity then
					local _, _, _, hex = GetItemQualityColor(itemRarity)
					tt:AddLine(format("%s %s |c%s%s|r", icon, format(TEXTURE_FONT, GetItemIcon(info.itemID), 18, 18), hex, itemName)) 
				else
					itemsMissing = true
				end
			end
			
			if itemsMissing then
				tt:AddLine("Fetching item information ..", 1,0,0)	
			end

			AltoTooltip:Show()
		end,
	OnClick = function() end,
	OnLeave = function(self)
			AltoTooltip:Hide() 
		end,
	InitViewDDM = function(frame, title) 
			frame:Show()
			title:Show()
			
			frame:SetMenuWidth(100) 
			frame:SetButtonWidth(20)
			frame:SetText(xPacks[addon:GetOption(OPTION_XPACK)])
			frame:Initialize(DropDown_Initialize, "MENU_NO_BORDERS")
		end,
}

AltoholicTabGrids:RegisterGrid(13, callbacks)
