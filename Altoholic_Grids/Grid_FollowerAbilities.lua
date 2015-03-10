local addonName = "Altoholic"
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local GREY		= "|cFF808080"

local OPTION_STATS = "UI.Tabs.Grids.Garrisons.CurrentStats"

local view
local viewItems
local isViewValid
local counters = {}

local KEY_ABILITIES = "Abilities"
local KEY_TRAITS = "Traits"
local KEY_COUNTERS = "AbilityCounters"

local statTypes = {
	{ label = GARRISON_RECRUIT_ABILITIES, key = KEY_ABILITIES },
	{ label = GARRISON_RECRUIT_TRAITS, key = KEY_TRAITS },
	{ label = L["Counters"], key = KEY_COUNTERS },
}

local currentKey

local DDM_Add = addon.Helpers.DDM_Add
local DDM_AddCloseMenu = addon.Helpers.DDM_AddCloseMenu

local function SortByAbility(a, b)
	local nameA = C_Garrison.GetFollowerAbilityName(a)
	local nameB = C_Garrison.GetFollowerAbilityName(b)
	return nameA < nameB
end

local function SortByCounter(a, b)
	local _, nameA = C_Garrison.GetFollowerAbilityCounterMechanicInfo(a)
	local _, nameB = C_Garrison.GetFollowerAbilityCounterMechanicInfo(b)
	
	return nameA < nameB
end

local function AddIDToView(id, isCounter)
	if not id or id == 0 then return end
	
	if isCounter then
		local counterID = C_Garrison.GetFollowerAbilityCounterMechanicInfo(id)
		
		if not counters[counterID] then	-- if this counter does not exist yet
			counters[counterID] = true		-- add it
			viewItems[id] = true				-- and add this ability to the view (any ability with that counter, it's the counter that matters anyway)
		end
	else
		viewItems[id] = true
	end
end

local function BuildView()
	local followers
	view = {}
	viewItems = {}
	wipe(counters)
	
	local realm, account = addon.Tabs.Grids:GetRealm()
	
	local currentStats = addon:GetOption(OPTION_STATS)
	
	-- Get a list of all collected followers across all alts on this realm
	for characterKey, character in pairs(DataStore:GetCharacters(realm, account)) do
		followers = DataStore:GetFollowers(character)
		
		if followers then
			for id, _ in pairs(followers) do
				local _, _, _, ab1, ab2, ab3, ab4, tr1, tr2, tr3, tr4 = DataStore:GetFollowerInfo(character, id)
				
				-- save known abilities only (id <> 0)
				if currentKey == KEY_ABILITIES then
					AddIDToView(ab1)
					AddIDToView(ab2)
					AddIDToView(ab3)
					AddIDToView(ab4)
				elseif currentKey == KEY_TRAITS then
					AddIDToView(tr1)
					AddIDToView(tr2)
					AddIDToView(tr3)
					AddIDToView(tr4)
				elseif currentKey == KEY_COUNTERS then
					AddIDToView(ab1, true)
					AddIDToView(ab2, true)
					AddIDToView(ab3, true)
					AddIDToView(ab4, true)
				end
			end
		end
	end
	
	-- fill the view with view items
	for k, _ in pairs(viewItems) do
		table.insert(view, k)
	end

	-- Now sort the view
	if currentKey == KEY_COUNTERS then
		table.sort(view, SortByCounter)
	else	-- abilities & traits use the same function
		table.sort(view, SortByAbility)
	end
	
	isViewValid = true
end

local function OnStatsFilterChange(self)
	local currentStats = self.value
	
	addon:SetOption(OPTION_STATS, currentStats)
	currentKey = statTypes[currentStats].key

	addon.Tabs.Grids:SetViewDDMText(statTypes[currentStats].label)
	
	isViewValid = nil
	addon.Tabs.Grids:Update()
end

local function DropDown_Initialize()
	local currentStats = addon:GetOption(OPTION_STATS)
	
	for i = 1, #statTypes do
		DDM_Add(statTypes[i].label, i, OnStatsFilterChange, nil, (i==currentStats))
	end
	DDM_AddCloseMenu()
end

local callbacks = {
	OnUpdate = function() 
			if not isViewValid then
				BuildView()
			end
		end,
	GetSize = function() return #view end,
	RowSetup = function(self, rowFrame, dataRowID)
			local id = view[dataRowID]
			local name, _
	
			if currentKey == KEY_COUNTERS then
				_, name = C_Garrison.GetFollowerAbilityCounterMechanicInfo(id)
			else
				name = C_Garrison.GetFollowerAbilityName(id)
			end
	
			if name then
				rowFrame.Name.Text:SetText(WHITE .. name)
				rowFrame.Name.Text:SetJustifyH("LEFT")
			end
		end,
	RowOnEnter = function()	end,
	RowOnLeave = function() end,
	ColumnSetup = function(self, button, dataRowID, character)
			local id = view[dataRowID]
			local icon, counterID, _ 

			if currentKey == KEY_COUNTERS then
				counterID, _, icon = C_Garrison.GetFollowerAbilityCounterMechanicInfo(id)
				id = counterID
			else
				icon = C_Garrison.GetFollowerAbilityIcon(id)
			end

			local numFollowers = DataStore:GetFollowerSpellCounters(character, currentKey, id) or 0

			button.Name:SetFontObject("NumberFontNormal")
			button.Name:SetJustifyH("CENTER")
			button.Name:SetPoint("BOTTOMRIGHT", 5, 0)
			button.Background:SetDesaturated(false)
			button.Background:SetTexCoord(0, 1, 0, 1)
			
			if numFollowers > 0 then
				-- button.key = character
				button.IconBorder:Hide()
				button.Background:SetTexture(icon)
				button.Background:SetVertexColor(0.5, 0.5, 0.5)
				button.Name:SetText(WHITE .. numFollowers)
				button:Show()
			else
				-- button.key = nil
				button:Hide()
			end
		end,
	OnEnter = function(frame) 
			-- local character = frame.key
			-- if not character then return end

		end,
	OnClick = function(frame, button)
			-- local character = frame.key
			-- if not character then return end
			
		end,
	OnLeave = function(self)
		end,
	InitViewDDM = function(frame, title)
			frame:Show()
			title:Show()

			local currentStats = addon:GetOption(OPTION_STATS)
			currentKey = statTypes[currentStats].key
			
			UIDropDownMenu_SetWidth(frame, 100) 
			UIDropDownMenu_SetButtonWidth(frame, 20)
			UIDropDownMenu_SetText(frame, statTypes[currentStats].label)
			addon:DDM_Initialize(frame, DropDown_Initialize)
		end,
}

addon.Tabs.Grids:RegisterGrid(12, callbacks)
