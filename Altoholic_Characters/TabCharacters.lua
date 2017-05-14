local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local parentName = "AltoholicTabCharacters"
local parent

local currentCategory = 1	-- current category (characters, equipment, rep, currencies, etc.. )
local currentView = 0		-- current view in the characters category
local currentProfession

local currentAlt = UnitName("player")

-- ** Icons Menus **
local VIEW_BAGS = 1
local VIEW_QUESTS = 2
local VIEW_TALENTS = 3
local VIEW_AUCTIONS = 4
local VIEW_BIDS = 5
local VIEW_MAILS = 6
local VIEW_COMPANIONS = 7
local VIEW_SPELLS = 8
local VIEW_PROFESSION = 9
local VIEW_GARRISONS = 10

-- Second mini easter egg, the bag icon changes depending on the amount of chars at level max (on the current realm), or based on the time of the year
local BAG_ICONS = {
	"Interface\\Icons\\INV_MISC_BAG_09",			-- mini pouch
	"Interface\\Icons\\INV_MISC_BAG_10_BLUE",		-- small bag
	"Interface\\Icons\\INV_Misc_Bag_12",			-- larger bag
	"Interface\\Icons\\INV_Misc_Bag_19",			-- bag 14
	"Interface\\Icons\\INV_Misc_Bag_08",			-- bag 16
	"Interface\\Icons\\INV_Misc_Bag_23_Netherweave",	-- 18
	"Interface\\Icons\\INV_Misc_Bag_EnchantedMageweave",	-- 20
	"Interface\\Icons\\INV_Misc_Bag_25_Mooncloth",
	"Interface\\Icons\\INV_Misc_Bag_26_Spellfire",
	"Interface\\Icons\\INV_Misc_Bag_33",
	"Interface\\Icons\\inv_misc_basket_05",
}

local ICON_BAGS_HALLOWSEND = "Interface\\Icons\\INV_Misc_Bag_28_Halloween"
local ICON_VIEW_BAGS = "Interface\\Icons\\INV_MISC_BAG_09"

-- ** Left menu **
local ICON_CHARACTERS = "Interface\\Icons\\Achievement_GuildPerk_Everyones a Hero_rank2"

addon.Tabs.Characters = {}

local ns = addon.Tabs.Characters		-- ns = namespace

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

local function HideAll()
	AltoholicFrameContainers:Hide()
	AltoholicFrameTalents:Hide()
	AltoholicFrameMail:Hide()
	AltoholicFrameQuests:Hide()
	AltoholicFramePets:Hide()
	AltoholicFrameAuctions:Hide()
	AltoholicFrameRecipes:Hide()
	-- AltoholicTabCharacters.Recipes:Hide()
	AltoholicFrameSpellbook:Hide()
	AltoholicFrameGarrisonMissions:Hide()
end

local function EnableIcon(frame)
	frame:Enable()
	frame.Icon:SetDesaturated(false)
end

local DDM_Add = addon.Helpers.DDM_Add
local DDM_AddTitle = addon.Helpers.DDM_AddTitle
local DDM_AddCloseMenu = addon.Helpers.DDM_AddCloseMenu

function ns:OnShow()
	if currentView == 0 then
		StartAutoCastShine(parent.Characters)
		ns:ViewCharInfo(VIEW_BAGS)
	end
end

function ns:MenuItem_OnClick(frame, button)
	HideAll()
	DropDownList1:Hide()		-- hide any right-click menu that could be open
	
	StopAutoCastShine()
	StartAutoCastShine(frame)
	
	local id = frame:GetID()
	currentCategory = id

	local menuIcons = parent.MenuIcons
	menuIcons.CharactersIcon:Show()
	menuIcons.BagsIcon:Show()
	menuIcons.QuestsIcon:Show()
	menuIcons.TalentsIcon:Show()
	menuIcons.AuctionIcon:Show()
	menuIcons.MailIcon:Show()
	menuIcons.SpellbookIcon:Show()
	menuIcons.ProfessionsIcon:Show()
	menuIcons.GarrisonIcon:Show()
end

function ns:ViewCharInfo(index)
	index = index or self.value
	
	currentView = index
	HideAll()
	ns:SetMode(index)
	ns:ShowCharInfo(index)
end

function ns:ShowCharInfo(view)
	if view == VIEW_BAGS then
		addon.Containers:SetView(addon:GetOption("UI.Tabs.Characters.ViewBagsAllInOne"))
		AltoholicFrameContainers:Show()
		addon.Containers:Update()
		
	elseif view == VIEW_QUESTS then
		AltoholicFrameQuests:Show()
		addon.Quests:InvalidateView()
		addon.Quests:Update()
		
	elseif view == VIEW_TALENTS then
		AltoholicFrameTalents:Update()
	
	elseif view == VIEW_AUCTIONS then
		addon.AuctionHouse:SetListType("Auctions")
		AltoholicFrameAuctions:Show()
		addon.AuctionHouse:InvalidateView()
		addon.AuctionHouse:Update()
	elseif view == VIEW_BIDS then
		addon.AuctionHouse:SetListType("Bids")
		AltoholicFrameAuctions:Show()
		addon.AuctionHouse:InvalidateView()
		addon.AuctionHouse:Update()
	elseif view == VIEW_MAILS then
		AltoholicFrameMail:Show()
		addon.Mail:BuildView()
		addon.Mail:Update()
		
	elseif view == VIEW_SPELLS then
		AltoholicFrameSpellbook:Update()

	elseif view == VIEW_COMPANIONS then
		addon.Pets:SetSinglePetView("CRITTER")
		addon.Pets:UpdatePets()

	elseif view == VIEW_PROFESSION then
		AltoholicFrameRecipes:Show()
		addon.TradeSkills.Recipes:InvalidateView()
		addon.TradeSkills.Recipes:Update()
		-- AltoholicTabCharacters.Recipes:Update()
				
	elseif view == VIEW_GARRISONS then
		AltoholicFrameGarrisonMissions:Update()
	end
end

function ns:SetMode(mode)
	if not mode then return end		-- called without parameter for professions

	local showButtons = false
	
	if mode == VIEW_MAILS then
		parent.SortButtons:SetButton(1, MAIL_SUBJECT_LABEL, 220, function(self) addon.Mail:Sort(self, "name") end)
		parent.SortButtons:SetButton(2, FROM, 140, function(self) addon.Mail:Sort(self, "from") end)
		parent.SortButtons:SetButton(3, L["Expiry:"], 200, function(self) addon.Mail:Sort(self, "expiry") end)
		showButtons = true
		
	elseif mode == VIEW_AUCTIONS then
		parent.SortButtons:SetButton(1, HELPFRAME_ITEM_TITLE, 220, function(self) addon.AuctionHouse:Sort(self, "name", "Auctions") end)
		parent.SortButtons:SetButton(2, HIGH_BIDDER, 160, function(self) addon.AuctionHouse:Sort(self, "highBidder", "Auctions") end)
		parent.SortButtons:SetButton(3, CURRENT_BID, 170, function(self) addon.AuctionHouse:Sort(self, "buyoutPrice", "Auctions") end)
		showButtons = true
	
	elseif mode == VIEW_BIDS then
		parent.SortButtons:SetButton(1, HELPFRAME_ITEM_TITLE, 220, function(self) addon.AuctionHouse:Sort(self, "name", "Bids") end)
		parent.SortButtons:SetButton(2, NAME, 160, function(self) addon.AuctionHouse:Sort(self, "owner", "Bids") end)
		parent.SortButtons:SetButton(3, CURRENT_BID, 170, function(self) addon.AuctionHouse:Sort(self, "buyoutPrice", "Bids") end)
		showButtons = true
	end
	
	if showButtons then
		parent.SortButtons:ShowChildFrames()
	else
		parent.SortButtons:HideChildFrames()
	end
end

function ns:SetCurrentProfession(prof)
	currentProfession = prof

	if currentProfession then
		addon.TradeSkills.Recipes:SetCurrentProfession(currentProfession)
		ns:ViewCharInfo(VIEW_PROFESSION)
	end
end

-- ** DB / Get **
function ns:GetAccount()
	local account, realm = parent.SelectRealm:GetCurrentRealm()
	return account
end

function ns:GetRealm()
	local account, realm = parent.SelectRealm:GetCurrentRealm()
	return realm, account
end


function ns:GetAlt()
	local account, realm = parent.SelectRealm:GetCurrentRealm()
	return currentAlt, realm, account
end

function ns:GetAltKey()
	local account, realm = parent.SelectRealm:GetCurrentRealm()
	
	if currentAlt and realm and account then
		return format("%s.%s.%s", account, realm, currentAlt)
	end
end

-- ** DB / Set **
function ns:SetAlt(alt, realm, account)
	currentAlt = alt
	parent.SelectRealm:SetCurrentRealm(realm, account)
end

function ns:SetAltKey(key)
	local account, realm, char = strsplit(".", key)
	ns:SetAlt(char, realm, account)
end

-- ** Icon events **
local function OnCharacterChange(self)
	local oldAlt = currentAlt
	local _, _, newAlt = strsplit(".", self.value)
	currentAlt = newAlt
	
	local menuIcons = parent.MenuIcons
	EnableIcon(menuIcons.BagsIcon)
	EnableIcon(menuIcons.QuestsIcon)
	EnableIcon(menuIcons.TalentsIcon)
	EnableIcon(menuIcons.AuctionIcon)
	EnableIcon(menuIcons.MailIcon)
	EnableIcon(menuIcons.SpellbookIcon)
	EnableIcon(menuIcons.ProfessionsIcon)
	EnableIcon(menuIcons.GarrisonIcon)
	
	if (not oldAlt) or (oldAlt == newAlt) then return end

	currentProfession = nil
	
	if currentView ~= VIEW_SPELLS and currentView ~= VIEW_PROFESSION then
		ns:ShowCharInfo(currentView)		-- this will show the same info from another alt (ex: containers/mail/ ..)
	else
		HideAll()
		parent.Status:SetText(format("%s|r /", DataStore:GetColoredCharacterName(self.value)))
	end
end

local function OnContainerChange(self)
	if self.value == 1 then
		addon:ToggleOption(nil, "UI.Tabs.Characters.ViewBags")
	elseif self.value == 2 then
		addon:ToggleOption(nil, "UI.Tabs.Characters.ViewBank")
	elseif self.value == 3 then
		addon:ToggleOption(nil, "UI.Tabs.Characters.ViewVoidStorage")
	elseif self.value == 4 then
		addon:ToggleOption(nil, "UI.Tabs.Characters.ViewReagentBank")
	elseif self.value == 5 then
		addon:ToggleOption(nil, "UI.Tabs.Characters.ViewBagsAllInOne")
	end
	
	ns:ViewCharInfo(VIEW_BAGS)
end

local function OnRarityChange(self)
	addon:SetOption("UI.Tabs.Characters.ViewBagsRarity", self.value)
	addon.Containers:Update()
end

local function OnTalentChange(self)
	CloseDropDownMenus()
	
	ns:ViewCharInfo(VIEW_TALENTS)
end

local function OnSpellTabChange(self)
	CloseDropDownMenus()
	
	if self.value then
		AltoholicFrameSpellbook:SetSchool(self.value)
		ns:ViewCharInfo(VIEW_SPELLS)
	end
end

local function OnProfessionChange(self)
	CloseDropDownMenus()
	ns:SetCurrentProfession(self.value)
end

local function OnProfessionColorChange(self)
	CloseDropDownMenus()
	
	if self.value then
		addon.TradeSkills.Recipes:SetCurrentColor(self.value)
		ns:ViewCharInfo(VIEW_PROFESSION)
	end
end

local function OnProfessionSlotChange(self)
	CloseDropDownMenus()
	
	if self.value then
		addon.TradeSkills.Recipes:SetCurrentSlots(self.value)
		ns:ViewCharInfo(VIEW_PROFESSION)
	end
end

local function OnProfessionSubClassChange(self)
	CloseDropDownMenus()
	
	if self.value then
		addon.TradeSkills.Recipes:SetCurrentSubClass(self.value)
		ns:ViewCharInfo(VIEW_PROFESSION)
	end
end

local function OnGarrisonMenuChange(self)
	addon:SetOption("UI.Tabs.Characters.GarrisonMissions", self.value)
	CloseDropDownMenus()
	ns:ViewCharInfo(VIEW_GARRISONS)
end

local function OnViewChange(self)
	if self.value then
		ns:ViewCharInfo(self.value)
	end
end

local function OnClearAHEntries(self)
	local character = ns:GetAltKey()
	
	local listType
	if currentView == VIEW_AUCTIONS then
		listType = "Auctions"
	elseif currentView == VIEW_BIDS then
		listType = "Bids"
	end
	
	if (self.value == 1) or (self.value == 3) then	-- clean this faction's data
		DataStore:ClearAuctionEntries(character, listType, 0)
	end
	
	if (self.value == 2) or (self.value == 3) then	-- clean goblin AH
		DataStore:ClearAuctionEntries(character, listType, 1)
	end
	
	addon.AuctionHouse:InvalidateView()
end

local function OnClearMailboxEntries(self)
	local character = ns:GetAltKey()
	DataStore:ClearMailboxEntries(character)
	addon.Mail:Update()
end

local function GetCharacterLoginText(character)
	local last = DataStore:GetLastLogout(character)
	local _, _, name = strsplit(".", character)
	
	if last then
		if name == UnitName("player") then
			last = colors.green..GUILD_ONLINE_LABEL
		else
			last = format("%s: %s", LASTONLINE, colors.yellow..date("%m/%d/%Y %H:%M", last))
		end
	else
		last = format("%s: %s", LASTONLINE, RED..L["N/A"])
	end
	return format("%s %s(%s%s)", DataStore:GetColoredCharacterName(character), colors.white, last, colors.white)
end

-- ** Menu Icons **
local function CharactersIcon_Initialize(self, level)
	local account, realm = parent.SelectRealm:GetCurrentRealm()
	
	DDM_AddTitle(L["Characters"])
	local nameList = {}		-- we want to list characters alphabetically
	for _, character in pairs(DataStore:GetCharacters(realm, account)) do
		table.insert(nameList, character)	-- we can add the key instead of just the name, since they will all be like account.realm.name, where account & realm are identical
	end
	table.sort(nameList)
	
	local currentCharacterKey = ns:GetAltKey()
	for _, character in ipairs(nameList) do
		DDM_Add(GetCharacterLoginText(character), character, OnCharacterChange, nil, (currentCharacterKey == character))
	end

	DDM_AddCloseMenu()
end

local function BagsIcon_Initialize(self, level)
	local currentCharacterKey = ns:GetAltKey()
	if not currentCharacterKey then return end

	DDM_AddTitle(format("%s / %s", L["Containers"], DataStore:GetColoredCharacterName(currentCharacterKey)))
	DDM_Add(L["View"], nil, function() ns:ViewCharInfo(VIEW_BAGS) end)
	DDM_Add(L["Bags"], 1, OnContainerChange, nil, addon:GetOption("UI.Tabs.Characters.ViewBags"))
	DDM_Add(L["Bank"], 2, OnContainerChange, nil, addon:GetOption("UI.Tabs.Characters.ViewBank"))
	DDM_Add(VOID_STORAGE, 3, OnContainerChange, nil, addon:GetOption("UI.Tabs.Characters.ViewVoidStorage"))
	DDM_Add(REAGENT_BANK , 4, OnContainerChange, nil, addon:GetOption("UI.Tabs.Characters.ViewReagentBank"))
	DDM_Add(L["All-in-one"], 5, OnContainerChange, nil, addon:GetOption("UI.Tabs.Characters.ViewBagsAllInOne"))
		
	DDM_AddTitle(" ")
	DDM_AddTitle("|r" ..RARITY)
	local rarity = addon:GetOption("UI.Tabs.Characters.ViewBagsRarity")
	DDM_Add(L["Any"], 0, OnRarityChange, nil, (rarity == 0))
	
	for i = LE_ITEM_QUALITY_UNCOMMON, LE_ITEM_QUALITY_HEIRLOOM do		-- Quality: 0 = poor .. 5 = legendary
		DDM_Add(format("|c%s%s", select(4, GetItemQualityColor(i)), _G["ITEM_QUALITY"..i.."_DESC"]), i, OnRarityChange, nil, (rarity == i))
	end
	
	DDM_AddCloseMenu()
end

local function QuestsIcon_Initialize(self, level)
	local currentCharacterKey = ns:GetAltKey()
	if not currentCharacterKey then return end
	
	DDM_AddTitle(format("%s / %s", QUESTS_LABEL, DataStore:GetColoredCharacterName(currentCharacterKey)))
	DDM_Add(QUEST_LOG, VIEW_QUESTS, OnViewChange, nil, (currentView == VIEW_QUESTS))
	
	DDM_AddTitle("|r ")
	DDM_AddTitle(GAMEOPTIONS_MENU)
	if DataStore_Quests then
		DDM_Add("DataStore Quests", nil, function() Altoholic:ToggleUI(); InterfaceOptionsFrame_OpenToCategory("DataStore_Quests") end)
	end
	DDM_AddCloseMenu()
end

local function TalentsIcon_Initialize(self, level)
	
	local currentCharacterKey = ns:GetAltKey()
	if not currentCharacterKey then return end
	
	DDM_AddTitle(format("%s / %s", TALENTS, DataStore:GetColoredCharacterName(currentCharacterKey)))
	DDM_AddTitle(" ")
	DDM_Add(TALENTS, 1, OnTalentChange, nil, nil)
	-- DDM_Add(TALENT_SPEC_SECONDARY, 2, OnTalentChange, nil, nil)
	DDM_AddCloseMenu()
end

local function AuctionIcon_Initialize(self, level)
	local currentCharacterKey = ns:GetAltKey()
	if not currentCharacterKey then return end
	
	DDM_AddTitle(format("%s / %s", BUTTON_LAG_AUCTIONHOUSE, DataStore:GetColoredCharacterName(currentCharacterKey)))
	
	local last = DataStore:GetModuleLastUpdateByKey("DataStore_Auctions", currentCharacterKey)
	if DataStore_Auctions and last then
		local numAuctions = DataStore:GetNumAuctions(currentCharacterKey) or 0
		local numBids = DataStore:GetNumBids(currentCharacterKey) or 0
		
		DDM_Add(format(L["Auctions %s(%d)"], colors.green, numAuctions), VIEW_AUCTIONS, OnViewChange, nil, (currentView == VIEW_AUCTIONS))
		DDM_Add(format(L["Bids %s(%d)"], colors.green, numBids), VIEW_BIDS, OnViewChange, nil, (currentView == VIEW_BIDS))
	else
		DDM_Add(format(L["Auctions %s(%d)"], colors.grey, 0), nil, nil)
		DDM_Add(format(L["Bids %s(%d)"], colors.grey, 0), nil, nil)
	end
	
	-- actions
	DDM_AddTitle(" ")
	DDM_Add(colors.white .. L["Clear your faction's entries"], 1, OnClearAHEntries)
	DDM_Add(colors.white .. L["Clear goblin AH entries"], 2, OnClearAHEntries)
	DDM_Add(colors.white .. L["Clear all entries"], 3, OnClearAHEntries)
	
	DDM_AddTitle("|r ")
	DDM_AddTitle(GAMEOPTIONS_MENU)
	if DataStore_Auctions then
		DDM_Add("DataStore Auctions", nil, function() Altoholic:ToggleUI(); InterfaceOptionsFrame_OpenToCategory("DataStore_Auctions") end)
	end
	DDM_AddCloseMenu()
end

local function MailIcon_Initialize(self, level)
	local currentCharacterKey = ns:GetAltKey()
	if not currentCharacterKey then return end
		
	DDM_AddTitle(format("%s / %s", MINIMAP_TRACKING_MAILBOX, DataStore:GetColoredCharacterName(currentCharacterKey)))

	local last = DataStore:GetModuleLastUpdateByKey("DataStore_Mails", currentCharacterKey)
	if DataStore_Mails and last then
		local numMails = DataStore:GetNumMails(currentCharacterKey) or 0
		DDM_Add(format(L["Mails %s(%d)"], colors.green, numMails), VIEW_MAILS, OnViewChange, nil, (currentView == VIEW_MAILS))
	else
		DDM_Add(format(L["Mails %s(%d)"], colors.grey, 0), nil, nil)
	end

	DDM_Add(colors.white .. L["Clear all entries"], nil, OnClearMailboxEntries)
	DDM_AddTitle("|r ")
	DDM_AddTitle(GAMEOPTIONS_MENU)
	DDM_Add(MAIL_LABEL, nil, function() Altoholic:ToggleUI(); InterfaceOptionsFrame_OpenToCategory(AltoholicMailOptions) end)
	if DataStore_Mails then
		DDM_Add("DataStore Mails", nil, function() Altoholic:ToggleUI(); InterfaceOptionsFrame_OpenToCategory(DataStoreMailOptions) end)
	end
	
	DDM_AddCloseMenu()
end

local function SpellbookIcon_Initialize(self, level)
	local currentCharacterKey = ns:GetAltKey()
	if not currentCharacterKey then return end
	
	DDM_AddTitle(format("%s / %s", SPELLBOOK, DataStore:GetColoredCharacterName(currentCharacterKey)))
	
	for index, spellTab in ipairs(DataStore:GetSpellTabs(currentCharacterKey)) do
		DDM_Add(spellTab, spellTab, OnSpellTabChange)
	end
	
	DDM_AddTitle(" ")
	
	local last = DataStore:GetModuleLastUpdateByKey("DataStore_Pets", currentCharacterKey)
	if DataStore_Pets and last then
		local pets = DataStore:GetPets(currentCharacterKey, "CRITTER")
		local numPets = DataStore:GetNumPets(pets) or 0

		DDM_Add(format(COMPANIONS .. " %s(%d)", colors.green, numPets), VIEW_COMPANIONS, OnViewChange, nil, (currentView == VIEW_COMPANIONS))
	else
		DDM_Add(format(COMPANIONS .. " %s(%d)", colors.grey, numPets), nil, nil)
	end
	DDM_AddCloseMenu()
end

local function ProfessionsIcon_Initialize(self, level)
	if not DataStore_Crafts then return end
	
	local currentCharacterKey = ns:GetAltKey()
	if not currentCharacterKey then return end
	
	if level == 1 then
		DDM_AddTitle(format("%s / %s", TRADE_SKILLS, DataStore:GetColoredCharacterName(currentCharacterKey)))

		local last = DataStore:GetModuleLastUpdateByKey("DataStore_Crafts", currentCharacterKey)

		local rank

		-- Cooking
		rank = DataStore:GetCookingRank(currentCharacterKey)
		if last and rank then
			DDM_Add(format("%s %s(%s)", PROFESSIONS_COOKING, colors.green, rank ), PROFESSIONS_COOKING, OnProfessionChange, nil, (PROFESSIONS_COOKING == (currentProfession or "")))
		else
			DDM_Add(colors.grey..PROFESSIONS_COOKING, nil, nil)
		end
		
		-- First Aid
		rank = DataStore:GetFirstAidRank(currentCharacterKey)
		if last and rank then
			DDM_Add(format("%s %s(%s)", PROFESSIONS_FIRST_AID, colors.green, rank ), PROFESSIONS_FIRST_AID, OnProfessionChange, nil, (PROFESSIONS_FIRST_AID == (currentProfession or "")))
		else
			DDM_Add(colors.grey..PROFESSIONS_FIRST_AID, nil, nil)
		end
		
		-- rank = DataStore:GetArchaeologyRank(currentCharacterKey)
		
		-- Profession 1
		local rank, professionName, _
		rank, _, _, professionName = DataStore:GetProfession1(currentCharacterKey)
		if last and rank and professionName then
			DDM_Add(format("%s %s(%s)", professionName, colors.green, rank ), professionName, OnProfessionChange, nil, (professionName == (currentProfession or "")))
		elseif professionName then
			DDM_Add(colors.grey..professionName, nil, nil)
		end
		
		-- Profession 2
		rank, _, _, professionName = DataStore:GetProfession2(currentCharacterKey)
		if last and rank and professionName then
			DDM_Add(format("%s %s(%s)", professionName, colors.green, rank ), professionName, OnProfessionChange, nil, (professionName == (currentProfession or "")))
		elseif professionName then
			DDM_Add(colors.grey..professionName, nil, nil)
		end
		
		DDM_AddTitle(" ")
		DDM_AddTitle(FILTERS)
		
		if currentProfession then		-- if a profession is visible, display filters
			local info = UIDropDownMenu_CreateInfo()

			info.text = colors.white..COLOR
			info.hasArrow = 1
			info.checked = nil
			info.value = 1
			info.func = nil
			UIDropDownMenu_AddButton(info, level)

			info.text = colors.white..SLOT_ABBR
			info.hasArrow = 1
			info.checked = nil
			info.value = 2
			info.func = nil
			UIDropDownMenu_AddButton(info, level)

			info.text = colors.white..SUBCATEGORY
			info.hasArrow = 1
			info.checked = nil
			info.value = 3
			info.func = nil
			UIDropDownMenu_AddButton(info, level)
			
		else		-- grey out filters
			DDM_Add(colors.grey..COLOR, nil, nil)
			DDM_Add(colors.grey..SLOT_ABBR, nil, nil)
			DDM_Add(colors.grey..SUBCATEGORY, nil, nil)
		end

		DDM_AddCloseMenu()
		
	elseif level == 2 then	-- ** filters **
		local info = UIDropDownMenu_CreateInfo()

		if UIDROPDOWNMENU_MENU_VALUE == 1 then		-- colors
			for index = 0, 3 do 
				info.text = addon.TradeSkills.Recipes:GetRecipeColorName(index)
				info.value = index
				info.checked = (addon.TradeSkills.Recipes:GetCurrentColor() == index)
				info.func = OnProfessionColorChange
				UIDropDownMenu_AddButton(info, level)
			end

			info.text = L["Any"]
			info.value = 4
			info.checked = (addon.TradeSkills.Recipes:GetCurrentColor() == 4)
			info.func = OnProfessionColorChange
			UIDropDownMenu_AddButton(info, level)
			
		elseif UIDROPDOWNMENU_MENU_VALUE == 2 then	-- slots
			info.text = ALL_INVENTORY_SLOTS
			info.value = ALL_INVENTORY_SLOTS
			info.checked = (addon.TradeSkills.Recipes:GetCurrentSlots() == ALL_INVENTORY_SLOTS)
			info.func = OnProfessionSlotChange
			UIDropDownMenu_AddButton(info, level)
			
			local invSlots = {}
			local profession = DataStore:GetProfession(currentCharacterKey, currentProfession)
				
			for index = 1, DataStore:GetNumCraftLines(profession) do
				local isHeader, _, recipeID = DataStore:GetCraftLineInfo(profession, index)
				
				if not isHeader then		-- NON header !!
					local itemID = DataStore:GetCraftResultItem(recipeID)
					
					if itemID then
						local _, _, _, _, _, itemType, _, _, itemEquipLoc = GetItemInfo(itemID)
						
						if itemEquipLoc and strlen(itemEquipLoc) > 0 then
							local slot = Altoholic.Equipment:GetInventoryTypeName(itemEquipLoc)
							if slot then
								invSlots[slot] = itemEquipLoc
							end
						end
					end
				end
			end
			
			for k, v in pairs(invSlots) do		-- add all the slots found
				info.text = k
				info.value = v
				info.checked = (addon.TradeSkills.Recipes:GetCurrentSlots() == v)
				info.func = OnProfessionSlotChange
				UIDropDownMenu_AddButton(info, level)
			end

			--NONEQUIPSLOT = "Created Items"; -- Items created by enchanting
			info.text = NONEQUIPSLOT
			info.value = NONEQUIPSLOT
			info.checked = (addon.TradeSkills.Recipes:GetCurrentSlots() == NONEQUIPSLOT)
			info.func = OnProfessionSlotChange
			UIDropDownMenu_AddButton(info, level)
			
		elseif UIDROPDOWNMENU_MENU_VALUE == 3 then	-- subclass
		
			info.text = ALL
			info.value = ALL
			info.checked = (addon.TradeSkills.Recipes:GetCurrentSubClass() == ALL)
			info.func = OnProfessionSubClassChange
			UIDropDownMenu_AddButton(info, level)
		
			local profession = DataStore:GetProfession(currentCharacterKey, currentProfession)
			for index = 1, DataStore:GetNumCraftLines(profession) do
				local isHeader, _, name = DataStore:GetCraftLineInfo(profession, index)
				
				if isHeader then
					info.text = name
					info.value = name
					info.checked = (addon.TradeSkills.Recipes:GetCurrentSubClass() == name)
					info.func = OnProfessionSubClassChange
					UIDropDownMenu_AddButton(info, level)
				end
			end
		end
	end
end

local function GarrisonIcon_Initialize(self, level)
	if not DataStore_Garrisons then return end
	
	local currentCharacterKey = ns:GetAltKey()
	if not currentCharacterKey then return end
	
	local currentMenu = addon:GetOption("UI.Tabs.Characters.GarrisonMissions")
	
	DDM_AddTitle(GARRISON_MISSIONS_TITLE)
	DDM_Add(format(GARRISON_LANDING_AVAILABLE, DataStore:GetNumAvailableMissions(currentCharacterKey, LE_FOLLOWER_TYPE_GARRISON_6_0)), 
				1, OnGarrisonMenuChange, nil, (currentMenu == 1))
	DDM_Add(format(GARRISON_LANDING_IN_PROGRESS, DataStore:GetNumActiveMissions(currentCharacterKey, LE_FOLLOWER_TYPE_GARRISON_6_0)), 
				2, OnGarrisonMenuChange, nil, (currentMenu == 2))
	DDM_AddTitle(" ")
	DDM_AddTitle(ORDER_HALL_MISSIONS)
	DDM_Add(format(GARRISON_LANDING_AVAILABLE, DataStore:GetNumAvailableMissions(currentCharacterKey, LE_FOLLOWER_TYPE_GARRISON_7_0)), 
				3, OnGarrisonMenuChange, nil, (currentMenu == 3))
	DDM_Add(format(GARRISON_LANDING_IN_PROGRESS, DataStore:GetNumActiveMissions(currentCharacterKey, LE_FOLLOWER_TYPE_GARRISON_7_0)), 
				4, OnGarrisonMenuChange, nil, (currentMenu == 4))
	
	DDM_AddCloseMenu()
end

local menuIconCallbacks = {
	CharactersIcon_Initialize,
	BagsIcon_Initialize,
	QuestsIcon_Initialize,
	TalentsIcon_Initialize,
	AuctionIcon_Initialize,
	MailIcon_Initialize,
	SpellbookIcon_Initialize,
	ProfessionsIcon_Initialize,
	GarrisonIcon_Initialize,
}

function ns:Icon_OnEnter(frame)
	-- local currentMenuID = frame:GetID()
	
	-- local menu = frame:GetParent():GetParent().ContextualMenu
	
	-- menu:Initialize(menuIconCallbacks[currentMenuID], "LIST")
	-- menu:Close()
	-- menu:Toggle(frame, 0, 0)



	local currentMenuID = frame:GetID()
	
	addon:DDM_Initialize(parent.ContextualMenu, menuIconCallbacks[currentMenuID])
	
	CloseDropDownMenus()

	ToggleDropDownMenu(1, nil, parent.ContextualMenu, AltoholicTabCharacters_MenuIcons, (currentMenuID-1)*42, -5)
end

function ns:OnLoad()
	parent = _G[parentName]

	-- Left Menu
	parent.Text1:SetText(L["Realm"])
	
	parent.SelectRealm:RegisterClassEvent("RealmChanged", function() 
			parent.Status:SetText("")
			currentAlt = nil
			currentProfession = nil
			HideAll()
		end)
	
	-- Menu Icons
	-- mini easter egg, change the character icon depending on the time of year :)
	-- if you find this code, please don't spoil it :)

	local day = (tonumber(date("%m")) * 100) + tonumber(date("%d"))	-- ex: dec 15 = 1215, for easy tests below
	local bagIcon = ICON_VIEW_BAGS

	-- bag icon gets better with more chars at lv max
	local LVMax = 110
	local numLvMax = 0
	for _, character in pairs(DataStore:GetCharacters()) do
		if DataStore:GetCharacterLevel(character) >= LVMax then
			numLvMax = numLvMax + 1
		end
	end

	if numLvMax > 0 then
		bagIcon = BAG_ICONS[numLvMax]
	end
	
	if (day >= 1018) and (day <= 1031) then		-- hallow's end
		bagIcon = ICON_BAGS_HALLOWSEND
	end
	
	local menuIcons = parent.MenuIcons
	menuIcons.CharactersIcon.Icon:SetTexture(addon:GetCharacterIcon())
	menuIcons.BagsIcon.Icon:SetTexture(bagIcon)
	
	-- ** Characters / Equipment / Reputations / Currencies **
	parent.Characters.Icon:SetTexture(ICON_CHARACTERS)
	parent.Characters.text = L["Characters"]
	
	addon:RegisterMessage("DATASTORE_RECIPES_SCANNED")
	addon:RegisterMessage("DATASTORE_QUESTLOG_SCANNED")
end

function addon:DATASTORE_RECIPES_SCANNED(event, sender, tradeskillName)
	addon.TradeSkills.Recipes:InvalidateView()
end

function addon:DATASTORE_QUESTLOG_SCANNED(event, sender)
	addon.Quests:InvalidateView()
	addon.Quests:Update()
end

