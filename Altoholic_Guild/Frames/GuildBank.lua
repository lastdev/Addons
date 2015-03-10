local addonName = "Altoholic"
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local YELLOW	= "|cFFFFFF00"
local THIS_ACCOUNT = "Default"

local ICON_GUILD = "Interface\\Icons\\Achievement_GuildPerk_Everyones a Hero_rank2"
local ICON_GUILDBANK = "Interface\\Icons\\Achievement_GuildPerk_MobileBanking"
local ICON_REMOTE_UPDATE = "Interface\\Icons\\Achievement_GuildPerk_Bartering"

local rarityIcons = {
	[0] = "Interface\\Icons\\item_cutmetagemb",
	[2] = "Interface\\Icons\\inv_misc_uncutgemnormal1",
	[3] = "Interface\\Icons\\inv_misc_uncutgemnormal2",
	[4] = "Interface\\Icons\\inv_misc_uncutgemnormal4",
	[5] = "Interface\\Icons\\inv_misc_uncutgemnormal",
	[6] = "Interface\\Icons\\inv_misc_uncutgemnormal5",
}

local NUM_GUILDBANK_ROWS = 7
local MAX_BANK_TABS = 8

local parentName = "AltoholicTabGuild"
local parent

local currentGuildKey
local currentGuildBankTab = 0

-- *** Utility functions ***
local DDM_Add = addon.Helpers.DDM_Add
local DDM_AddTitle = addon.Helpers.DDM_AddTitle
local DDM_AddCloseMenu = addon.Helpers.DDM_AddCloseMenu

local function UpdateBankTabButtons()
	if not currentGuildKey then return end
	
	local button
	for i = 1, MAX_BANK_TABS do 
		button = parent.Bank["TabButton"..i]
	
		local tabName = DataStore:GetGuildBankTabName(currentGuildKey, i)
		if tabName then
			button.Icon:SetWidth(30)
			button.Icon:SetHeight(30)
			button.Icon:SetTexture(DataStore:GetGuildBankTabIcon(currentGuildKey, i))
			button:Show()
		else
			button:Hide()
		end
	end
end

addon.Guild.Bank = {}

local ns = addon.Guild.Bank		-- ns = namespace

local function DeleteGuild_MsgBox_Handler(self, button, guildKey)
	if not button then return end
	
	local account, realm, guildName = strsplit(".", guildKey)
	local guild = addon:GetGuild(guildName, realm, account)
	wipe(guild)
	
	DataStore:DeleteGuild(guildName, realm, account)
	
	addon:Print(format( L["Guild %s successfully deleted"], guildName))
	
	if guildKey == currentGuildKey then
		currentGuildKey = nil
		currentGuildBankTab = nil
		ns:Update()
	end
end

local function OnGuildChange(self)
	currentGuildKey = self.value
	currentGuildBankTab = nil
	
	local _, _, guildName = strsplit(".", currentGuildKey)
	parent.Status:SetText(format("%s %s/", GREEN..guildName, WHITE))

	local currentGuild = GetGuildInfo("player")
	
	local menuIcons = parent.Bank.MenuIcons
	if guildName == currentGuild then
		menuIcons.UpdateIcon:Enable()
		menuIcons.UpdateIcon.Icon:SetDesaturated(false)
	else
		menuIcons.UpdateIcon:Disable()
		menuIcons.UpdateIcon.Icon:SetDesaturated(true)
	end
	
	parent.Bank.Info1:SetText("")
	parent.Bank.Info2:SetText("")
	parent.Bank.Info3:SetText("")
	
	UpdateBankTabButtons()
	
	ns:Update()
end

local function OnHideInTooltip(self)
	local account, realm, name = strsplit(".", self.value)
	local guild = addon:GetGuild(name, realm, account)
	if guild	then
		guild.hideInTooltip = not guild.hideInTooltip
	end
	
	CloseDropDownMenus()
end

local function OnGuildDelete(self)
	local guildKey = self.value

	addon:SetMsgBoxHandler(DeleteGuild_MsgBox_Handler, guildKey)
	
	local _, realm, guildName = strsplit(".", guildKey)

	AltoMsgBox_Text:SetText(format("%s\n%s%s %s(%s)", L["Delete Guild Bank?"], GREEN, guildName, WHITE, realm ))
	AltoMsgBox:Show()
	
	CloseDropDownMenus()
end

local function OnGuildBankTabChange(self)
	currentGuildBankTab = self.value
	ns:Update()
end

local function OnBankTabRemoteUpdate(self)
	local tabName = DataStore:GetGuildBankTabName(currentGuildKey, currentGuildBankTab)
	local member = self.value
	
	addon:Print(format(L["Requesting %s information from %s"], tabName, member ))
	DataStore:RequestGuildMemberBankTab(member, tabName)
end

local function OnRarityChange(self)
	local rarity = self.value

	addon:SetOption("UI.Tabs.Guild.BankItemsRarity", rarity)
	
	local icon = parent.Bank.MenuIcons.RarityIcon.Icon
	icon:SetWidth(30)
	icon:SetHeight(30)
	icon:SetTexture(rarityIcons[rarity])

	ns:Update()
end

function ns:Update()
	local frame = parent.Bank

	if not currentGuildKey or not currentGuildBankTab then		-- no tab found ? exit
		for rowIndex = 1, NUM_GUILDBANK_ROWS do
			frame["Entry"..rowIndex]:Hide()
		end
		return 
	end
	
	local tab = DataStore:GetGuildBankTab(currentGuildKey, currentGuildBankTab)
	if not tab.name then return end		-- tab not yet scanned ? exit
	
	local _, _, guildName = strsplit(".", currentGuildKey)
	parent.Status:SetText(format("%s %s/ %s", GREEN..guildName, WHITE, tab.name))

	frame.Info1:SetText(format(L["Last visit: %s by %s"], GREEN..tab.ClientDate..WHITE, GREEN..tab.visitedBy))
	local localTime, realmTime
	localTime = format("%s%02d%s:%s%02d", GREEN, tab.ClientHour, WHITE, GREEN, tab.ClientMinute )
	realmTime = format("%s%02d%s:%s%02d", GREEN, tab.ServerHour, WHITE, GREEN, tab.ServerMinute )
	frame.Info2:SetText(format(L["Local Time: %s   %sRealm Time: %s"], localTime, WHITE, realmTime))
	
	local money = DataStore:GetGuildBankMoney(currentGuildKey)
	frame.Info3:SetText(MONEY .. ": " .. addon:GetMoneyString(money or 0, WHITE))
	
	local rarity = addon:GetOption("UI.Tabs.Guild.BankItemsRarity")
	
	local rowFrame
	local itemButton
	
	for rowIndex = 1, NUM_GUILDBANK_ROWS do
		rowFrame = frame["Entry"..rowIndex]
	
		local from = mod(rowIndex, NUM_GUILDBANK_ROWS)
		if from == 0 then from = NUM_GUILDBANK_ROWS end
	
		for columnIndex = 14, 1, -1 do
			itemButton = rowFrame["Item" .. columnIndex]
			itemButton.IconBorder:Hide()
			itemButton.Icon:SetDesaturated(false)
			
			local itemIndex = from + ((columnIndex - 1) * NUM_GUILDBANK_ROWS)
			
			local itemID, itemLink, itemCount = DataStore:GetSlotInfo(tab, itemIndex)
			
			if itemID then
				itemButton.Icon:SetTexture(GetItemIcon(itemID))
				
				if rarity ~= 0 then
					local _, _, itemRarity = GetItemInfo(itemID)
					if itemRarity and itemRarity == rarity then
						local r, g, b = GetItemQualityColor(itemRarity)
						itemButton.IconBorder:SetVertexColor(r, g, b, 0.5)
						itemButton.IconBorder:Show()
					else
						itemButton.Icon:SetDesaturated(true)
					end
				end
			else
				itemButton.Icon:SetTexture("Interface\\PaperDoll\\UI-Backpack-EmptySlot")
			end
			
			itemButton.id = itemID
			itemButton.link = itemLink
			itemButton:SetScript("OnEnter", function(self) 
					addon:Item_OnEnter(self)
				end)
			
			if not itemCount or (itemCount < 2) then
				itemButton.Count:Hide();
			else
				itemButton.Count:SetText(itemCount);
				itemButton.Count:Show();
			end
		
			itemButton:Show()
		end
		rowFrame:Show()
	end
end


-- ** Menu Icons **
function ns:TabIcon_OnEnter(frame)
	local tabName = DataStore:GetGuildBankTabName(currentGuildKey, frame:GetID())
	if not tabName then return end

	AltoTooltip:ClearLines()
	AltoTooltip:SetOwner(frame, "ANCHOR_RIGHT")
	AltoTooltip:AddLine(tabName)
	AltoTooltip:Show()
end

function ns:TabIcon_OnClick(frame, button)
	currentGuildBankTab = frame:GetID()
	ns:Update()
end

local function GuildIcon_Initialize(self, level)
	local info = UIDropDownMenu_CreateInfo()
	if level == 1 then
		for account in pairs(DataStore:GetAccounts()) do
			for realm in pairs(DataStore:GetRealms(account)) do
				for guildName, guild in pairs(DataStore:GetGuilds(realm, account)) do
					-- this test is not necessary, if a guild key is in the db, there's essentially data.
					-- local money = DataStore:GetGuildBankMoney(guild)
					-- if money then
						local text = format("%s / %s", WHITE..realm, GREEN..guildName)

						if account ~= "Default" then
							text = format("%s %s(%s)", text, YELLOW, account)
						end
					
						info.text = text
						info.hasArrow = 1
						info.checked = (guild == currentGuildKey) and true or nil
						info.value = guild		-- guild key
						info.func = OnGuildChange
						UIDropDownMenu_AddButton(info, level)
					-- end
				end
			end
		end
		
	elseif level == 2 then
		local account, realm, name = strsplit(".", UIDROPDOWNMENU_MENU_VALUE)
		local guild = addon:GetGuild(name, realm, account)
	
		info.text = WHITE ..  L["Hide this guild in the tooltip"]
		info.value = UIDROPDOWNMENU_MENU_VALUE
		info.checked = guild.hideInTooltip
		info.func = OnHideInTooltip
		UIDropDownMenu_AddButton(info, level)
		
		info.text = WHITE .. DELETE
		info.value = UIDROPDOWNMENU_MENU_VALUE
		info.checked = nil
		info.func = OnGuildDelete
		UIDropDownMenu_AddButton(info, level)
	end
end

local function TabsIcon_Initialize(self, level)
	DDM_AddTitle(L["Guild Bank Tabs"])
	
	for i = 1, MAX_BANK_TABS do 
		local tabName = DataStore:GetGuildBankTabName(currentGuildKey, i)
		if tabName then
			DDM_Add(tabName, i, OnGuildBankTabChange, DataStore:GetGuildBankTabIcon(currentGuildKey, i), (currentGuildBankTab == i))
		end
	end
	DDM_AddCloseMenu()
end

local function UpdateIcon_Initialize(self, level)
	if not currentGuildKey or not currentGuildBankTab or currentGuildBankTab == 0 then return end
	
	local tabName = DataStore:GetGuildBankTabName(currentGuildKey, currentGuildBankTab)
	if not tabName then return end
	
	local player = UnitName("player")
	local myClientTime = DataStore:GetGuildMemberBankTabInfo(player, tabName)
	
	local older = {}
	local newer = {}
	
	DDM_AddTitle(L["Update current tab from"])
	for member in pairs(DataStore:GetGuildBankTabSuppliers()) do
		if member ~= player then	-- skip current player
			local clientTime = DataStore:GetGuildMemberBankTabInfo(member, tabName)
				
			if clientTime then	-- if there's data, we can add this member in the view for the current bank tab
				if clientTime > myClientTime then
					table.insert(newer, { name = member, timeStamp = clientTime } )
				else
					table.insert(older, { name = member, timeStamp = clientTime } )
				end
			end
		end
	end
	
	if #newer > 0 then
		DDM_AddTitle(" ")
		DDM_AddTitle(YELLOW..L["Newer data"])
		
		table.sort(newer, function(a,b) return a.timeStamp > b.timeStamp end)
		
		for _, member in ipairs(newer) do
			local clientTime, serverHour, serverMinute = DataStore:GetGuildMemberBankTabInfo(member.name, tabName)
		
			DDM_Add(format("%s %s", WHITE..member.name, GREEN..date("%m/%d/%Y %H:%M", clientTime)), member.name, OnBankTabRemoteUpdate)
		end
	end

	if #older > 0 then
		DDM_AddTitle(" ")
		DDM_AddTitle(YELLOW..L["Older data"])
		
		table.sort(older, function(a,b) return a.timeStamp > b.timeStamp end)
		
		for _, member in ipairs(older) do
			local clientTime, serverHour, serverMinute = DataStore:GetGuildMemberBankTabInfo(member.name, tabName)
		
			DDM_Add(format("%s %s", WHITE..member.name, GREEN..date("%m/%d/%Y %H:%M", clientTime)), member.name, OnBankTabRemoteUpdate)
		end
	end

	DDM_AddCloseMenu()
end

local function RarityIcon_Initialize(self, level)
	local rarity = addon:GetOption("UI.Tabs.Guild.BankItemsRarity")
	DDM_AddTitle("|r" ..RARITY)
	DDM_Add(L["Any"], 0, OnRarityChange, nil, (rarity == 0))

	for i = 2, 6 do		-- Quality: 0 = poor .. 5 = legendary
		DDM_Add(ITEM_QUALITY_COLORS[i].hex .. _G["ITEM_QUALITY"..i.."_DESC"], i, OnRarityChange, nil, (rarity == i))
	end
	DDM_AddCloseMenu()
end

local menuIconCallbacks = {
	GuildIcon_Initialize,
	TabsIcon_Initialize,
	UpdateIcon_Initialize,
	RarityIcon_Initialize,
}

function ns:Icon_OnEnter(frame)
	local currentMenuID = frame:GetID()
	
	addon:DDM_Initialize(parent.Bank.ContextualMenu, menuIconCallbacks[currentMenuID])
	
	-- hide all
	CloseDropDownMenus()

	-- show current
	ToggleDropDownMenu(1, nil, parent.Bank.ContextualMenu, "AltoholicTabGuildBank_MenuIcons", (currentMenuID-1)*42, -5)
end

function ns:OnLoad()
	parent = _G[parentName]

	local rarity = addon:GetOption("UI.Tabs.Guild.BankItemsRarity")
	local menuIcons = parent.Bank.MenuIcons
	local icon = menuIcons.RarityIcon.Icon
	icon:SetWidth(30)
	icon:SetHeight(30)
	icon:SetTexture(rarityIcons[rarity])
	
	icon = menuIcons.GuildIcon.Icon
	icon:SetWidth(30)
	icon:SetHeight(30)
	icon:SetTexture(ICON_GUILD)
	
	icon = menuIcons.TabsIcon.Icon
	icon:SetWidth(30)
	icon:SetHeight(30)
	icon:SetTexture(ICON_GUILDBANK)
	
	icon = menuIcons.UpdateIcon.Icon
	icon:SetWidth(30)
	icon:SetHeight(30)
	icon:SetTexture(ICON_REMOTE_UPDATE)
		
	-- load the drop down with a guild
	local currentRealm = GetRealmName()
	local currentGuild = GetGuildInfo("player")
	
	-- if the player is not in a guild, set the drop down to the first available guild on this realm, if any.
	if not currentGuild then
		-- if the guild that will be displayed is not the one the current player is in, then disable the button
		parent.Bank.UpdateIcon:Disable()
		parent.Bank.UpdateIcon.Icon:SetDesaturated(true)
	
		for guildName, guild in pairs(DataStore:GetGuilds(currentRealm, THIS_ACCOUNT)) do
			local money = DataStore:GetGuildBankMoney(guild)
			if money then		-- if money is not nil, the guild bank has been populated
				currentGuild = guildName
				break	-- if there's at least one guild, let's set the right value and break immediately
			end
		end
	end
	
	-- if the current guild or at least a guild on this realm was found..set the right values
	if currentGuild then
		currentGuildKey = format("%s.%s.%s", THIS_ACCOUNT, currentRealm, currentGuild)

		-- pick the first available tab
		for i = 1, MAX_BANK_TABS do 
			local tabName = DataStore:GetGuildBankTabName(currentGuildKey, i)
			if tabName then
				currentGuildBankTab = i
				break
			end
		end
	end
	
	UpdateBankTabButtons()
end
