local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local view
local isViewValid
local OPTION_TOKEN = "UI.Tabs.Grids.Currencies.CurrentTokenType"

local function HashToSortedArray(hash)
	local array = {}		-- order them
	for k, _ in pairs(hash) do
		table.insert(array, k)
	end
	table.sort(array)
	return array
end

local function GetUsedHeaders()
	local account, realm = AltoholicTabGrids:GetRealm()
	
	local usedHeaders = {}
	local isHeader, name, num

	for _, character in pairs(DataStore:GetCharacters(realm, account)) do	-- all alts on this realm
		num = DataStore:GetNumCurrencies(character) or 0
		
		for i = 1, num do
			isHeader, name = DataStore:GetCurrencyInfo(character, i)	-- save ech header found in the table
			if isHeader then
				usedHeaders[name] = true
			end
		end
	end
	
	return HashToSortedArray(usedHeaders)
end

local function GetUsedTokens(header)
	-- get the list of tokens found under a specific header, across all alts

	local account, realm = AltoholicTabGrids:GetRealm()
	
	local tokens = {}
	local useData				-- use data for a specific header or not

	for _, character in pairs(DataStore:GetCharacters(realm, account)) do	-- all alts on this realm
		local num = DataStore:GetNumCurrencies(character) or 0
		for i = 1, num do
			local isHeader, name = DataStore:GetCurrencyInfo(character, i)
			
			if isHeader then
				if header and name ~= header then -- if a specific header (filter) was set, and it's not the one we chose, skip
					useData = nil
				else
					useData = true		-- we'll use data in this category
				end
			else
				if useData then		-- mark it as used
					tokens[name] = true
				end
			end
		end
	end
	
	return HashToSortedArray(tokens)
end

local function BuildView()
	view = GetUsedTokens(addon:GetOption(OPTION_TOKEN))
	isViewValid = true
end

local function OnTokenChange(self, header)
	addon:SetOption(OPTION_TOKEN, header)
	AltoholicTabGrids:SetViewDDMText(header)

	isViewValid = nil
	AltoholicTabGrids:Update()
end

local function OnTokensAllInOne(self)
	addon:SetOption(OPTION_TOKEN, nil)
	AltoholicTabGrids:SetViewDDMText(L["All-in-one"])

	isViewValid = nil
	AltoholicTabGrids:Update()
end

local function DropDown_Initialize(frame)
	for _, header in ipairs(GetUsedHeaders()) do		-- and add them to the DDM
		frame:AddButtonWithArgs(header, nil, OnTokenChange, header, nil, (addon:GetOption(OPTION_TOKEN) == header))
	end
	frame:AddButtonWithArgs(L["All-in-one"], nil, OnTokensAllInOne, nil, nil, (addon:GetOption(OPTION_TOKEN) == nil))
	frame:AddCloseMenu()
end

local callbacks = {
	OnUpdate = function() 
			if not isViewValid then
				BuildView()
			end
			
			AltoholicTabGrids:SetStatus(addon:GetOption(OPTION_TOKEN) or L["All-in-one"])
		end,
	GetSize = function() return #view end,
	RowSetup = function(self, rowFrame, dataRowID)
			local token = view[dataRowID]

			if token then
				rowFrame.Name.Text:SetText(colors.white .. token)
				rowFrame.Name.Text:SetJustifyH("LEFT")
			end
		end,
	RowOnEnter = function()	end,
	RowOnLeave = function() end,
	ColumnSetup = function(self, button, dataRowID, character)
			button.Name:SetFontObject("NumberFontNormalSmall")
			button.Name:SetJustifyH("CENTER")
			button.Name:SetPoint("BOTTOMRIGHT", 5, 0)
			button.Background:SetDesaturated(false)
			button.Background:SetTexCoord(0, 1, 0, 1)

			local token = view[dataRowID]
			local _, _, count, icon = DataStore:GetCurrencyInfoByName(character, token)
			button.count = count
		
			if count then 
				button.Background:SetTexture(icon)
				button.Background:SetVertexColor(0.5, 0.5, 0.5);	-- greyed out
				button.key = character
				
				if count >= 100000 then
					count = format("%2.1fM", count/1000000)
				elseif count >= 10000 then
					count = format("%2.0fk", count/1000)
				elseif count >= 1000 then
					count = format("%2.1fk", count/1000)
				end
				
				button.Name:SetText(colors.green..count)
				button:SetID(dataRowID)
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
			
			AltoTooltip:SetOwner(frame, "ANCHOR_LEFT")
			AltoTooltip:ClearLines()
			AltoTooltip:AddLine(DataStore:GetColoredCharacterName(character))
			-- AltoTooltip:AddLine(view[frame:GetParent():GetID()], 1, 1, 1)
			AltoTooltip:AddLine(view[frame:GetID()], 1, 1, 1)
			AltoTooltip:AddLine(colors.green..frame.count)
			AltoTooltip:Show()
		end,
	OnClick = nil,
	OnLeave = function(frame)
			AltoTooltip:Hide() 
		end,
	InitViewDDM = function(frame, title) 
			frame:Show()
			title:Show()
			
			frame:SetMenuWidth(100) 
			frame:SetButtonWidth(20)
			frame:SetText(addon:GetOption(OPTION_TOKEN) or L["All-in-one"])
			frame:Initialize(DropDown_Initialize, "MENU_NO_BORDERS")
		end,
}

local headers = GetUsedHeaders()

AltoholicTabGrids:RegisterGrid(3, callbacks)
