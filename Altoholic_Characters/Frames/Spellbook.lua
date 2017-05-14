local addonName = "Altoholic"
local addon = _G[addonName]

local SPELLS_PER_PAGE = 12

local currentSchool
local currentPage

local function _Update(frame)
	local character = addon.Tabs.Characters:GetAltKey()
	AltoholicTabCharacters.Status:SetText(format("%s|r / %s / %s", DataStore:GetColoredCharacterName(character), SPELLBOOK, currentSchool))
	
	local itemName, itemButton
	local spellID, availableAt

	local maxSpells = DataStore:GetNumSpells(character, currentSchool)
	local offset = (currentPage-1) * SPELLS_PER_PAGE
	local spellIndex = offset + 1
	
	local index = 1
	while index <= SPELLS_PER_PAGE do
		spellID, availableAt = DataStore:GetSpellInfo(character, currentSchool, spellIndex)
		
		if spellID then
			frame["SpellIcon" .. index]:SetSpell(spellID, availableAt)
			frame["SpellIcon" .. index]:Show()
			index = index + 1
		end
		
		spellIndex = spellIndex + 1
	
		if spellIndex > maxSpells then
			break
		end
	end
	
	while index <= SPELLS_PER_PAGE do
		itemButton = frame["SpellIcon" .. index]
		itemButton:Hide()
		index = index + 1
	end
	
	frame:Show()
end

local function SetPage(frame, pageNum)
	currentPage = pageNum
	
	local character = addon.Tabs.Characters:GetAltKey()
	
	if currentPage == 1 then
		frame.PrevPage:Disable()
	else
		frame.PrevPage:Enable()
	end
	
	local maxPages = 1

	if currentSchool then
		maxPages = ceil(DataStore:GetNumSpells(character, currentSchool) / SPELLS_PER_PAGE)
	end
	
	if maxPages == 0 then
		maxPages = 1
	end
	
	if currentPage == maxPages then
		frame.NextPage:Disable()
	else
		frame.NextPage:Enable()
	end

	frame.PageNumber:SetText(format(PAGE_NUMBER, currentPage))	
	
	if currentSchool then _Update(frame) end
end

local function _GoToPreviousPage(frame)
	SetPage(frame, currentPage - 1)
end

local function _GoToNextPage(frame)
	SetPage(frame, currentPage + 1)
end

local function _SetSchool(frame, school)
	currentSchool = school
	SetPage(frame, 1)
end

addon:RegisterClassExtensions("AltoSpellbookPanel", {
	Update = _Update,
	GoToPreviousPage = _GoToPreviousPage,
	GoToNextPage = _GoToNextPage,
	SetSchool = _SetSchool,
})
