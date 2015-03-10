local addonName = "Altoholic"
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local GOLD		= "|cFFFFD700"
local THIS_ACCOUNT = "Default"

local ICON_PARTIAL = "Interface\\RaidFrame\\ReadyCheck-Waiting"
local CHARS_PER_FRAME = 11

local parentName = "AltoholicTabGrids"
local parent

local currentCategory	-- current category ( equipment, rep, currencies, etc.. )

local currentRealm = GetRealmName()
local currentAccount = THIS_ACCOUNT

local DDM_Add = addon.Helpers.DDM_Add
local DDM_AddTitle = addon.Helpers.DDM_AddTitle
local DDM_AddCloseMenu = addon.Helpers.DDM_AddCloseMenu

addon.Tabs.Grids = {}

local ns = addon.Tabs.Grids		-- ns = namespace

-- *** Utility functions ***
local lastButton

local function StartAutoCastShine(button)
	AutoCastShine_AutoCastStart(button.Shine);
	lastButton = button
end

local function StopAutoCastShine()
	-- stop autocast shine on the last button that was clicked
	if lastButton then
		AutoCastShine_AutoCastStop(lastButton.Shine)
	end
end

local function EnableIcon(frame)
	frame:Enable()
	frame.Icon:SetDesaturated(false)
end

local function DisableIcon(frame)
	frame:Disable()
	frame.Icon:SetDesaturated(true)
end

local function UpdateMenuIcons()
	if DataStore_Inventory then
		EnableIcon(parent.Equipment)
	else
		DisableIcon(parent.Equipment)
	end

	if DataStore_Reputations then
		EnableIcon(parent.Factions)
	else
		DisableIcon(parent.Factions)
	end
	
	if DataStore_Currencies then
		EnableIcon(parent.Tokens)
	else
		DisableIcon(parent.Tokens)
	end
	
	if DataStore_Pets then
		EnableIcon(parent.Pets)
	else
		DisableIcon(parent.Pets)
	end
	
	if DataStore_Achievements then
		EnableIcon(parent.Tabards)
	else
		DisableIcon(parent.Tabards)
	end

	if DataStore_Quests then
		EnableIcon(parent.Dailies)
	else
		DisableIcon(parent.Dailies)
	end
	
	if DataStore_Agenda then
		EnableIcon(parent.Dungeons)
	else
		DisableIcon(parent.Dungeons)
	end
	
	if DataStore_Garrisons then
		EnableIcon(parent.GarrisonArchitect)
		EnableIcon(parent.GarrisonFollowers)
		EnableIcon(parent.FollowerAbilities)
	else
		DisableIcon(parent.GarrisonArchitect)
		DisableIcon(parent.GarrisonFollowers)
		DisableIcon(parent.FollowerAbilities)
	end
end

local function UpdateClassIcons()
	local key = addon:GetOption(format("Tabs.Grids.%s.%s.Column1", currentAccount, currentRealm))
	if not key then	-- first time this realm is displayed, or reset by player
	
		local index = 1

		-- add the first 11 keys found on this realm
		for characterName, characterKey in pairs(DataStore:GetCharacters(currentRealm, currentAccount)) do	
			-- ex: : ["Tabs.Grids.Default.MyRealm.Column4"] = "Account.realm.alt7"

			addon:SetOption(format("Tabs.Grids.%s.%s.Column%d", currentAccount, currentRealm, index), characterKey)
			
			index = index + 1
			if index > CHARS_PER_FRAME then
				break
			end
		end
		
		while index <= CHARS_PER_FRAME do
			addon:SetOption(format("Tabs.Grids.%s.%s.Column%d", currentAccount, currentRealm, index), nil)
			index = index + 1
		end
	end
	
	local itemName, itemButton
	local class, _
	
	local frame = parent.ClassIcons
	
	for i = 1, CHARS_PER_FRAME do
		itemButton = frame["Icon"..i]
		
		key = addon:GetOption(format("Tabs.Grids.%s.%s.Column%d", currentAccount, currentRealm, i))
		if key then
			_, class = DataStore:GetCharacterClass(key)
		end
		
		if key and class then
			local tc = CLASS_ICON_TCOORDS[class]
		
			itemButton.Icon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes");
			itemButton.Icon:SetTexCoord(tc[1], tc[2], tc[3], tc[4])
	
			if DataStore:GetCharacterFaction(key) == "Alliance" then
				itemButton.IconBorder:SetVertexColor(0.1, 0.25, 1, 0.5)
			else
				itemButton.IconBorder:SetVertexColor(1, 0, 0, 0.5)
			end

		else	-- no key ? display a question mark icon
			itemButton.Icon:SetTexture(ICON_PARTIAL)
			itemButton.Icon:SetTexCoord(0, 1, 0, 1)
			
			itemButton.IconBorder:SetVertexColor(0, 1, 0, 0.5)
		end
		
		itemButton.Icon:SetWidth(33)
		itemButton.Icon:SetHeight(33)
		itemButton.Icon:SetAllPoints(itemButton)
		
		itemButton.IconBorder:Show()
		itemButton:SetWidth(34)
		itemButton:SetHeight(34)
		itemButton:Show()
	end
end

local gridCallbacks = {}

function ns:RegisterGrid(category, callbacks)
	gridCallbacks[category] = callbacks
end

function ns:OnShow()
	if not currentCategory then
		StartAutoCastShine(parent.Equipment)
		currentCategory = 1
	end

	UpdateMenuIcons()
	ns:Update()
end

function ns:MenuItem_OnClick(frame, button)
	DropDownList1:Hide()		-- hide any right-click menu that could be open
	
	StopAutoCastShine()
	StartAutoCastShine(frame)
	
	currentCategory = frame:GetID()

	local obj = gridCallbacks[currentCategory]	-- point to the callbacks of the current object (equipment, tabards, ..)
	obj.InitViewDDM(parent.SelectView, parent.TextView)
	
	ns:Update()
end

function ns:Update()
	UpdateClassIcons()

	local numRows = 8
	local frame = AltoholicFrameGrids
	frame:Show()
		
	local offset = FauxScrollFrame_GetOffset(frame.ScrollFrame)
	
	ns:SetStatus("")
	
	local obj = gridCallbacks[currentCategory]	-- point to the callbacks of the current object (equipment, tabards, ..)
	obj:OnUpdate()
	
	local size = obj:GetSize()
	local itemButton
	
	for rowIndex = 1, numRows do
		local rowFrame = frame["Entry"..rowIndex]
		local dataRowID = rowIndex + offset
		if dataRowID <= size then	-- if the row is visible

			obj:RowSetup(rowFrame, dataRowID)
			itemButton = rowFrame.Name
			itemButton:SetScript("OnEnter", obj.RowOnEnter)
			itemButton:SetScript("OnLeave", obj.RowOnLeave)
			
			for colIndex = 1, CHARS_PER_FRAME do
				itemButton = rowFrame["Item"..colIndex]
				itemButton.IconBorder:Hide()
				
				character = addon:GetOption(format("Tabs.Grids.%s.%s.Column%d", currentAccount, currentRealm, colIndex))
				if character then
					itemButton:SetScript("OnEnter", obj.OnEnter)
					itemButton:SetScript("OnClick", obj.OnClick)
					itemButton:SetScript("OnLeave", obj.OnLeave)
					
					itemButton:Show()	-- note: this Show() must remain BEFORE the next call, if the button has to be hidden, it's done in ColumnSetup
					obj:ColumnSetup(itemButton, dataRowID, character)
				else
					itemButton.id = nil
					itemButton:Hide()
				end
			end

			rowFrame:Show()
		else
			rowFrame:Hide()
		end
	end

	FauxScrollFrame_Update(frame.ScrollFrame, size, numRows, 41)
end

function ns:GetRealm()
	return currentRealm, currentAccount
end

function ns:SetStatus(text)
	parent.Status:SetText(text or "")
end

function ns:SetViewDDMText(text)
	UIDropDownMenu_SetText(parent.SelectView, text)
end


-- ** realm selection **
local function OnRealmChange(self, account, realm)
	local oldAccount = currentAccount
	local oldRealm = currentRealm

	currentAccount = account
	currentRealm = realm

	UIDropDownMenu_ClearAll(parent.SelectRealm);
	UIDropDownMenu_SetSelectedValue(parent.SelectRealm, account .."|".. realm)
	UIDropDownMenu_SetText(parent.SelectRealm, GREEN .. account .. ": " .. WHITE.. realm)
	
	if oldRealm and oldAccount then	-- clear the "select char" drop down if realm or account has changed
		if (oldRealm ~= realm) or (oldAccount ~= account) then
			parent.Status:SetText("")
			ns:Update()
		end
	end
end

function ns:DropDownRealm_Initialize()
	if not currentAccount or not currentRealm then return end

	-- this account first ..
	DDM_AddTitle(GOLD..L["This account"])
	for realm in pairs(DataStore:GetRealms()) do
		local info = UIDropDownMenu_CreateInfo()

		info.text = WHITE..realm
		info.value = format("%s|%s", THIS_ACCOUNT, realm)
		info.checked = nil
		info.func = OnRealmChange
		info.arg1 = THIS_ACCOUNT
		info.arg2 = realm
		UIDropDownMenu_AddButton(info, 1)
	end

	-- .. then all other accounts
	local accounts = DataStore:GetAccounts()
	local count = 0
	for account in pairs(accounts) do
		if account ~= THIS_ACCOUNT then
			count = count + 1
		end
	end
	
	if count > 0 then
		DDM_AddTitle(" ")
		DDM_AddTitle(GOLD..OTHER)
		for account in pairs(accounts) do
			if account ~= THIS_ACCOUNT then
				for realm in pairs(DataStore:GetRealms(account)) do
					local info = UIDropDownMenu_CreateInfo()

					info.text = format("%s: %s", GREEN..account, WHITE..realm)
					info.value = format("%s|%s", account, realm)
					info.checked = nil
					info.func = OnRealmChange
					info.arg1 = account
					info.arg2 = realm
					UIDropDownMenu_AddButton(info, 1)
				end
			end
		end
	end
end


-- ** Icon events **
local function OnCharacterChange(self, id)
	if not id then return end		-- no icon id ? exit
	
	local key = self.value		-- key is either a datastore character key, or nil (if "None" is selected by the player for this column)

	if key == "empty" then		-- if the keyword "empty" is passed, save a nil value in the options
		key = nil
	end

	addon:SetOption(format("Tabs.Grids.%s.%s.Column%d", currentAccount, currentRealm, id), key)
	ns:Update()
end

-- ** Menu Icons **
function ns:Icon_OnEnter(frame)
	local currentMenuID = frame:GetID()
	parent.ContextualMenu.menuID = currentMenuID

	-- hide all
	CloseDropDownMenus()

	-- show current
	ToggleDropDownMenu(1, nil, parent.ContextualMenu, "AltoholicTabGrids_ClassIcons", (currentMenuID-1)*39, 0)
	
	local key = addon:GetOption(format("Tabs.Grids.%s.%s.Column%d", currentAccount, currentRealm, currentMenuID))
	if key then
		addon:DrawCharacterTooltip(frame, key)
	end
end

local function ClassIcon_Initialize(self, level)
	local id = self.menuID
	
	DDM_AddTitle(L["Characters"])
	local nameList = {}		-- we want to list characters alphabetically
	for _, character in pairs(DataStore:GetCharacters(currentRealm, currentAccount)) do
		table.insert(nameList, character)	-- we can add the key instead of just the name, since they will all be like account.realm.name, where account & realm are identical
	end
	table.sort(nameList)
	
	-- get the key associated with this button
	local key = addon:GetOption(format("Tabs.Grids.%s.%s.Column%d", currentAccount, currentRealm, id)) or ""
	
	for _, character in ipairs(nameList) do
		local info = UIDropDownMenu_CreateInfo(); 
		
		info.text		= DataStore:GetColoredCharacterName(character)
		info.value		= character
		info.func		= OnCharacterChange
		info.checked	= (key == character)
		info.arg1		= id
		UIDropDownMenu_AddButton(info, 1)
	end
	
	DDM_AddTitle(" ")
	
	local info = UIDropDownMenu_CreateInfo()
	info.text		= (id == 1) and RESET or NONE
	info.value		= "empty"
	info.func		= OnCharacterChange
	info.checked	= (key == "")
	info.arg1		= id
	UIDropDownMenu_AddButton(info, 1)

	DDM_AddCloseMenu()
end

function ns:OnLoad()
	parent = _G[parentName]
	addon:DDM_Initialize(parent.ContextualMenu, ClassIcon_Initialize)
	
	-- ** Left Menu **
	parent.Label1:SetText(L["Realm"])

	parent.Equipment.text = L["Equipment"]
	parent.Factions.text = L["Reputations"]
	parent.Tabards.text = "Tabards"
	parent.Archeology.text = GetSpellInfo(78670)
	parent.Dailies.text = "Daily Quests"
	parent.FollowerAbilities.text = format("%s/%s", GARRISON_RECRUIT_ABILITIES, GARRISON_RECRUIT_TRAITS)
end
