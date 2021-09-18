local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local MVC = LibStub("LibMVC-1.0")
local Options = MVC:GetService("AltoholicUI.Options")
local Equipment = MVC:GetService("AltoholicUI.Equipment")

local tab		-- small shortcut to easily address the frame (set in OnBind)
local currentPanelKey = "Search"

local searchType, searchSubType, searchedValue

local OPTION_LOCATION = "UI.Tabs.Search.CurrentLocation"
local OPTION_RARITY = "UI.Tabs.Search.CurrentRarity"
local OPTION_EQUIPMENT = "UI.Tabs.Search.CurrentSlot"
local OPTION_PROFESSION = "UI.Tabs.Search.CurrentProfession"
local OPTION_NO_MIN_LEVEL = "UI.Tabs.Search.IncludeNoMinLevel"
local OPTION_MAILBOXES = "UI.Tabs.Search.IncludeMailboxItems"
local OPTION_GUILD_BANKS = "UI.Tabs.Search.IncludeGuildBankItems"
local OPTION_RECIPES = "UI.Tabs.Search.IncludeKnownRecipes"
local OPTION_COLORED_ALTS = "UI.Tabs.Search.UseColorsForAlts"
local OPTION_COLORED_REALMS = "UI.Tabs.Search.UseColorsForRealms"

local function OnSearchLocationChange(frame)
	Options.Set(OPTION_LOCATION, frame.value)
	tab:Update()
end

local function OnSearchRarityChange(frame)
	Options.Set(OPTION_RARITY, frame.value)
	
	if searchedValue then
		tab:Find(searchedValue)
		tab:Update()
	end
end

local function OnSearchEquipmentSlotChange(frame, itemType, itemSubType)
	Options.Set(OPTION_EQUIPMENT, frame.value)
	
	if frame.value == 0 then
		searchType = nil
		searchSubType = nil
	end
	
	-- Only overwrite existing filters if values are actually passed as argument
	if itemType then 
		searchType = GetItemClassInfo(itemType)
		
		if itemSubType then
			searchSubType = GetItemSubClassInfo(itemType, itemSubType) 	
		end
	else
		searchType = nil
		searchSubType = nil
	end
	
	if searchedValue then
		tab:Find(searchedValue)
		tab:Update()
	end
end

local function OnSearchProfessionChange(frame)
	Options.Set(OPTION_PROFESSION, frame.value)
	tab:Update()
end

local function OnSearchOptionsChange(frame)
	Options.Toggle(nil, frame.value)
	tab:Update()
end

-- ** Menu Icons **
local function LocationIcon_Initialize(frame, level)
	local option = Options.Get(OPTION_LOCATION)

	frame:AddTitle(L["FILTER_SEARCH_LOCATION"])
	frame:AddButton(L["This character"], 1, OnSearchLocationChange, nil, (option == 1))
	frame:AddButton(format("%s %s(%s)", L["This realm"], colors.green, L["This faction"]), 2, OnSearchLocationChange, nil, (option == 2))
	frame:AddButton(format("%s %s(%s)", L["This realm"], colors.green, L["Both factions"]), 3, OnSearchLocationChange, nil, (option == 3))
	frame:AddButton(L["All realms"], 4, OnSearchLocationChange, nil, (option == 4))
	frame:AddButton(L["All accounts"], 5, OnSearchLocationChange, nil, (option == 5))
	frame:AddCloseMenu()
end

local function RarityIcon_Initialize(frame, level)
	local option = Options.Get(OPTION_RARITY)

	frame:AddTitle(L["FILTER_SEARCH_RARITY"])
	
	for i = 0, Enum.ItemQuality.Heirloom do		-- Quality: 0 = poor .. 5 = legendary ..
		local quality = format("|c%s%s", select(4, GetItemQualityColor(i)), _G[format("ITEM_QUALITY%d_DESC", i)])
		
		frame:AddButton(quality, i, OnSearchRarityChange, nil, (option == i))
	end
	
	frame:AddCloseMenu()
end

local function EquipmentIcon_Initialize(frame, level)
	local option = Options.Get(OPTION_EQUIPMENT)

	frame:AddTitle(L["FILTER_SEARCH_SLOT"])
	frame:AddButton(L["Any"], 0, OnSearchEquipmentSlotChange, nil, (option == 0))
	
	local e = Enum.InventoryType
	
	frame:AddTitle()
	frame:AddTitle(ARMOR)
	frame:AddButton(INVTYPE_HEAD, e.IndexHeadType, OnSearchEquipmentSlotChange, nil, (option == e.IndexHeadType))
	frame:AddButton(INVTYPE_SHOULDER, e.IndexShoulderType, OnSearchEquipmentSlotChange, nil, (option == e.IndexShoulderType))
	frame:AddButton(INVTYPE_CHEST, e.IndexChestType, OnSearchEquipmentSlotChange, nil, (option == e.IndexChestType))
	frame:AddButton(INVTYPE_WAIST, e.IndexWaistType, OnSearchEquipmentSlotChange, nil, (option == e.IndexWaistType))
	frame:AddButton(INVTYPE_LEGS, e.IndexLegsType, OnSearchEquipmentSlotChange, nil, (option == e.IndexLegsType))
	frame:AddButton(INVTYPE_FEET, e.IndexFeetType, OnSearchEquipmentSlotChange, nil, (option == e.IndexFeetType))
	frame:AddButton(INVTYPE_WRIST, e.IndexWristType, OnSearchEquipmentSlotChange, nil, (option == e.IndexWristType))
	frame:AddButton(INVTYPE_HAND, e.IndexHandType, OnSearchEquipmentSlotChange, nil, (option == e.IndexHandType))

	frame:AddTitle()
	frame:AddTitle(MISCELLANEOUS)
	
	frame:AddButton(INVTYPE_NECK, e.IndexNeckType, OnSearchEquipmentSlotChange, nil, (option == e.IndexNeckType))
	frame:AddButtonWithArgs(INVTYPE_CLOAK, e.IndexCloakType, OnSearchEquipmentSlotChange,LE_ITEM_CLASS_ARMOR, LE_ITEM_ARMOR_CLOTH, (option == e.IndexCloakType))
	frame:AddButton(INVTYPE_FINGER, e.IndexFingerType, OnSearchEquipmentSlotChange, nil, (option == e.IndexFingerType))
	frame:AddButton(INVTYPE_TRINKET, e.IndexTrinketType, OnSearchEquipmentSlotChange, nil, (option == e.IndexTrinketType))
	
	-- Note, use negative values for special cases, to avoid filtering on item slot (for shields, only type & subtype are needed)
	frame:AddButtonWithArgs(GetItemSubClassInfo(LE_ITEM_CLASS_ARMOR, LE_ITEM_ARMOR_SHIELD), -1, 
		OnSearchEquipmentSlotChange, LE_ITEM_CLASS_ARMOR, LE_ITEM_ARMOR_SHIELD, (option == -1))
	frame:AddButtonWithArgs(INVTYPE_HOLDABLE, "INVTYPE_HOLDABLE", 
		OnSearchEquipmentSlotChange, LE_ITEM_CLASS_ARMOR, LE_ITEM_ARMOR_GENERIC, (option == "INVTYPE_HOLDABLE"))
	
	frame:AddTitle()
	-- frame:AddTitle(AUCTION_CATEGORY_WEAPONS)
	
	frame:AddCloseMenu()
end

local function ProfessionsIcon_Initialize(frame, level)
	local option = Options.Get(OPTION_PROFESSION)

	-- frame:AddTitle(L["FILTER_SEARCH_SLOT"])
	-- frame:AddButton(L["Any"], 0, OnSearchProfessionChange, nil, (option == i))
	-- frame:AddCloseMenu()
end

local function SearchOptionsIcon_Initialize(frame, level)
	frame:AddTitle(L["FILTER_SEARCH_OPTIONS"])
	frame:AddButton(L["Include items without level requirement"], OPTION_NO_MIN_LEVEL, OnSearchOptionsChange, nil, (Options.Get(OPTION_NO_MIN_LEVEL) == true))
	frame:AddButton(L["Include mailboxes"], OPTION_MAILBOXES, OnSearchOptionsChange, nil, (Options.Get(OPTION_MAILBOXES) == true))
	frame:AddButton(L["Include guild banks"], OPTION_GUILD_BANKS, OnSearchOptionsChange, nil, (Options.Get(OPTION_GUILD_BANKS) == true))
	frame:AddButton(L["Include known recipes"], OPTION_RECIPES, OnSearchOptionsChange, nil, (Options.Get(OPTION_RECIPES) == true))
	
	frame:AddTitle()
	frame:AddButton(L["USE_CLASS_COLOR"], OPTION_COLORED_ALTS, OnSearchOptionsChange, nil, (Options.Get(OPTION_COLORED_ALTS) == true))
	frame:AddButton(L["USE_FACTION_COLOR"], OPTION_COLORED_REALMS, OnSearchOptionsChange, nil, (Options.Get(OPTION_COLORED_REALMS) == true))
	frame:AddTitle()
	frame:AddButtonWithArgs(HELP_LABEL, 30, addon.ShowOptionsPanel, 13)
	
	frame:AddCloseMenu()
end

local menuIconCallbacks = {
	LocationIcon_Initialize,
	RarityIcon_Initialize,
	EquipmentIcon_Initialize,
	ProfessionsIcon_Initialize,
	SearchOptionsIcon_Initialize,
}

addon:Controller("AltoholicUI.TabSearch", { 
	"AltoholicUI.Options", "AltoholicUI.ItemFilters", "AltoholicUI.DataBrowser", "AltoholicUI.SearchResults",
	function(Options, ItemFilters, DataBrowser, Results)

	return {
		OnBind = function(frame)
			tab = frame
			
			local hc = frame.HeaderContainer
		
			hc:SetButton(1, RARITY, 60, function() frame:SortBy("rarity", 1) end)
			hc:SetButton(2, NAME, 240, function() frame:SortBy("name", 2) end)
			hc:SetButton(3, "iLvl", 50, function() frame:SortBy("level", 3) end)
			hc:SetButton(4, format("%s/%s", PLAYER, BANK), 140, function() frame:SortBy("source", 4) end)
			hc:SetButton(5, "Realm" , 140, function() frame:SortBy("realm", 5) end)
		end,
		Reset_OnClick = function(frame)
			-- Note: do not auto reset, let the user choose with the reset button

			searchType = nil
			searchSubType = nil
			searchedValue = nil
			
			Options.Set(OPTION_RARITY, 0)
			Options.Set(OPTION_EQUIPMENT, 0)
			
			-- reset also min max
			frame.MinLevel:SetText("")
			frame.MaxLevel:SetText("")
			AltoholicFrame.SearchBox:SetText("")
			ItemFilters.Clear()
			Results.Clear()
			frame:Update()
			frame:SetStatus("")
			collectgarbage()
		end,
		FilterIcon_OnEnter = function(frame, icon)
			local currentMenuID = icon:GetID()
			
			local menu = frame.ContextualMenu
			
			menu:Initialize(menuIconCallbacks[currentMenuID], "LIST")
			menu:Close()
			menu:Toggle(icon, 0, 0)
		end,
		RegisterPanel = function(frame, key, panel)
			-- a simple list of all the child frames
			frame.Panels = frame.Panels or {}
			frame.Panels[key] = panel
		end,
		HideAllPanels = function(frame)
			for _, panel in pairs(frame.Panels) do
				panel:Hide()
			end
		end,
		ShowPanel = function(frame, panelKey)
			if not panelKey then return end
			
			currentPanelKey = panelKey
			
			frame:HideAllPanels()
			
			local panel = frame.Panels[currentPanelKey]
			
			panel:Show()
			if panel.PreUpdate then
				panel:PreUpdate()
			end
			panel:Update()
		end,
		SetStatus = function(frame, text)
			frame.Status:SetText(text)
		end,
		SortBy = function(frame, columnName, buttonIndex)
			Options.Toggle(nil, "UI.Tabs.Search.SortAscending")
			
			-- Sort the whole view by a given column
			local hc = frame.HeaderContainer
			local sortOrder = Options.Get("UI.Tabs.Search.SortAscending")		
			
			hc.SortButtons[buttonIndex]:DrawArrow(sortOrder)
			
			Results.Sort(columnName, sortOrder)
			frame:Update()
		end,
		Update = function(frame)
			frame:ShowPanel(currentPanelKey)
		end,

		Find = function(frame, value)
			searchedValue = value
			
			-- Set Filters
			ItemFilters.Clear()
			ItemFilters.EnableFilter("Existence")	-- should be first in the list !
			
			if value ~= "" then
				ItemFilters.SetFilterValue("itemName", strlower(value))
				ItemFilters.EnableFilter("Name")
			end
			
			if searchType then
				ItemFilters.SetFilterValue("itemType", searchType)
				ItemFilters.EnableFilter("Type")
			end

			if searchSubType then
				ItemFilters.SetFilterValue("itemSubType", searchSubType)
				ItemFilters.EnableFilter("SubType")
			end
				
			local itemMinLevel = frame.MinLevel:GetNumber()
			ItemFilters.SetFilterValue("itemMinLevel", itemMinLevel)
			ItemFilters.EnableFilter("MinLevel")
			
			local itemMaxLevel = frame.MaxLevel:GetNumber()	
			if itemMaxLevel ~= 0 then			-- enable the filter only if a max level has been set
				ItemFilters.SetFilterValue("itemMaxLevel", itemMaxLevel)
				ItemFilters.EnableFilter("Maxlevel")
			end	
			
			local itemSlot = Options.Get(OPTION_EQUIPMENT)
			
			if itemSlot then
				if type(itemSlot) == "string" then			-- for special inventory types, like INVTYPE_HOLDABLE (off-hands)
					ItemFilters.SetFilterValue("itemSlot", itemSlot)
					ItemFilters.EnableFilter("EquipmentSlotText")

				-- don't apply filter if = 0, it means we take them all
				elseif type(itemSlot) == "number" and itemSlot > 0 then
					ItemFilters.SetFilterValue("itemSlot", itemSlot)
					ItemFilters.EnableFilter("EquipmentSlot")				
				end
			end
			
			local itemRarity = Options.Get(OPTION_RARITY)
			if itemRarity and itemRarity > 0 then	-- don't apply filter if = 0, it means we take them all
				ItemFilters.SetFilterValue("itemRarity", itemRarity)
				ItemFilters.EnableFilter("Rarity")
			end
			
			-- print(ItemFilters.GetFiltersString())
			DataBrowser.Find()		-- The actual search happens in here
			
			frame:Update()
		end,
	}
end})

local function categoriesList_OnClick(categoryData)
	tab.ContextualMenu:Close()
	
	-- If we filter by category, the search box will be deleted
	AltoholicFrame.SearchBox:SetText("")

	searchType = GetItemClassInfo(categoryData.itemType)
	searchSubType = GetItemSubClassInfo(categoryData.itemType, categoryData.subType) 
	Options.Set(OPTION_EQUIPMENT, categoryData.slot)

	tab:Find("")
	tab:Update()
end

local function GetCategoryName(category)
	return format("%s%s", colors.gold, category)
end

addon:Controller("AltoholicUI.TabSearchCategoriesList", {
	OnBind = function(frame)
		local classIDs = {
			LE_ITEM_CLASS_CONTAINER,
			LE_ITEM_CLASS_GEM,
			LE_ITEM_CLASS_ITEM_ENHANCEMENT,
			LE_ITEM_CLASS_CONSUMABLE,
			LE_ITEM_CLASS_GLYPH,
			LE_ITEM_CLASS_TRADEGOODS,
			LE_ITEM_CLASS_RECIPE,
			-- LE_ITEM_CLASS_BATTLEPET,
		}
	
		-- info : https://wowpedia.fandom.com/wiki/ItemType
	
		local categories = {
			{ text = GetCategoryName(AUCTION_CATEGORY_WEAPONS), subMenu = {
				{ text = AUCTION_SUBCATEGORY_ONE_HANDED, subMenu = {
					{ itemType = LE_ITEM_CLASS_WEAPON, subType = LE_ITEM_WEAPON_AXE1H },
					{ itemType = LE_ITEM_CLASS_WEAPON, subType = LE_ITEM_WEAPON_MACE1H },
					{ itemType = LE_ITEM_CLASS_WEAPON, subType = LE_ITEM_WEAPON_SWORD1H },
					{ itemType = LE_ITEM_CLASS_WEAPON, subType = LE_ITEM_WEAPON_WARGLAIVE },
					{ itemType = LE_ITEM_CLASS_WEAPON, subType = LE_ITEM_WEAPON_DAGGER },
					{ itemType = LE_ITEM_CLASS_WEAPON, subType = LE_ITEM_WEAPON_UNARMED },
					{ itemType = LE_ITEM_CLASS_WEAPON, subType = LE_ITEM_WEAPON_WAND },
				}},
				{ text = AUCTION_SUBCATEGORY_TWO_HANDED, subMenu = {
					{ itemType = LE_ITEM_CLASS_WEAPON, subType = LE_ITEM_WEAPON_AXE2H },
					{ itemType = LE_ITEM_CLASS_WEAPON, subType = LE_ITEM_WEAPON_MACE2H },
					{ itemType = LE_ITEM_CLASS_WEAPON, subType = LE_ITEM_WEAPON_SWORD2H },
					{ itemType = LE_ITEM_CLASS_WEAPON, subType = LE_ITEM_WEAPON_POLEARM },
					{ itemType = LE_ITEM_CLASS_WEAPON, subType = LE_ITEM_WEAPON_STAFF },
				}},
				{ text = AUCTION_SUBCATEGORY_RANGED, subMenu = {
					{ itemType = LE_ITEM_CLASS_WEAPON, subType = LE_ITEM_WEAPON_BOWS },
					{ itemType = LE_ITEM_CLASS_WEAPON, subType = LE_ITEM_WEAPON_CROSSBOW },
					{ itemType = LE_ITEM_CLASS_WEAPON, subType = LE_ITEM_WEAPON_GUNS },
					{ itemType = LE_ITEM_CLASS_WEAPON, subType = LE_ITEM_WEAPON_THROWN },
				}},
				{ text = AUCTION_SUBCATEGORY_MISCELLANEOUS, subMenu = {
					{ itemType = LE_ITEM_CLASS_WEAPON, subType = LE_ITEM_WEAPON_FISHINGPOLE },
					{ itemType = LE_ITEM_CLASS_WEAPON, subType = LE_ITEM_WEAPON_GENERIC },
				}},
			}},
			{ text = GetCategoryName(AUCTION_CATEGORY_ARMOR), subMenu = {
				{ text = GetItemSubClassInfo(LE_ITEM_CLASS_ARMOR, LE_ITEM_ARMOR_PLATE), subMenu = {
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_PLATE, slot = Enum.InventoryType.IndexHeadType },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_PLATE, slot = Enum.InventoryType.IndexShoulderType },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_PLATE, slot = Enum.InventoryType.IndexChestType },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_PLATE, slot = Enum.InventoryType.IndexWaistType },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_PLATE, slot = Enum.InventoryType.IndexLegsType },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_PLATE, slot = Enum.InventoryType.IndexFeetType },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_PLATE, slot = Enum.InventoryType.IndexWristType },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_PLATE, slot = Enum.InventoryType.IndexHandType },
				}},
				{ text = GetItemSubClassInfo(LE_ITEM_CLASS_ARMOR, LE_ITEM_ARMOR_MAIL), subMenu = {
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_MAIL, slot = Enum.InventoryType.IndexHeadType },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_MAIL, slot = Enum.InventoryType.IndexShoulderType },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_MAIL, slot = Enum.InventoryType.IndexChestType },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_MAIL, slot = Enum.InventoryType.IndexWaistType },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_MAIL, slot = Enum.InventoryType.IndexLegsType },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_MAIL, slot = Enum.InventoryType.IndexFeetType },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_MAIL, slot = Enum.InventoryType.IndexWristType },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_MAIL, slot = Enum.InventoryType.IndexHandType },
				}},
				{ text = GetItemSubClassInfo(LE_ITEM_CLASS_ARMOR, LE_ITEM_ARMOR_LEATHER), subMenu = {
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_LEATHER, slot = Enum.InventoryType.IndexHeadType },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_LEATHER, slot = Enum.InventoryType.IndexShoulderType },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_LEATHER, slot = Enum.InventoryType.IndexChestType },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_LEATHER, slot = Enum.InventoryType.IndexWaistType },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_LEATHER, slot = Enum.InventoryType.IndexLegsType },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_LEATHER, slot = Enum.InventoryType.IndexFeetType },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_LEATHER, slot = Enum.InventoryType.IndexWristType },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_LEATHER, slot = Enum.InventoryType.IndexHandType },
				}},
				{ text = GetItemSubClassInfo(LE_ITEM_CLASS_ARMOR, LE_ITEM_ARMOR_CLOTH), subMenu = {
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_CLOTH, slot = Enum.InventoryType.IndexHeadType },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_CLOTH, slot = Enum.InventoryType.IndexShoulderType },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_CLOTH, slot = Enum.InventoryType.IndexChestType },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_CLOTH, slot = Enum.InventoryType.IndexWaistType },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_CLOTH, slot = Enum.InventoryType.IndexLegsType },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_CLOTH, slot = Enum.InventoryType.IndexFeetType },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_CLOTH, slot = Enum.InventoryType.IndexWristType },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_CLOTH, slot = Enum.InventoryType.IndexHandType },
				}},
				{ text = GetItemSubClassInfo(LE_ITEM_CLASS_ARMOR, LE_ITEM_ARMOR_GENERIC), subMenu = {
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_GENERIC, slot = Enum.InventoryType.IndexNeckType },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_CLOTH, slot = Enum.InventoryType.IndexCloakType },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_GENERIC, slot = Enum.InventoryType.IndexFingerType },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_GENERIC, slot = Enum.InventoryType.IndexTrinketType },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_GENERIC, slot = "INVTYPE_HOLDABLE" },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_SHIELD },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_GENERIC, slot = Enum.InventoryType.IndexBodyType },
					{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_GENERIC, slot = Enum.InventoryType.IndexHeadType },
				}},
				{ itemType = LE_ITEM_CLASS_ARMOR, subType = LE_ITEM_ARMOR_COSMETIC },
			}},
			{ text = GetCategoryName(AUCTION_CATEGORY_CONTAINERS), subMenu = {} },
			{ text = GetCategoryName(AUCTION_CATEGORY_GEMS), subMenu = {} },
			{ text = GetCategoryName(AUCTION_CATEGORY_ITEM_ENHANCEMENT), subMenu = {} },
			{ text = GetCategoryName(AUCTION_CATEGORY_CONSUMABLES), subMenu = {} },
			{ text = GetCategoryName(AUCTION_CATEGORY_GLYPHS), subMenu = {} },
			{ text = GetCategoryName(AUCTION_CATEGORY_TRADE_GOODS), subMenu = {} },
			{ text = GetCategoryName(AUCTION_CATEGORY_RECIPES), subMenu = {} },
			-- { text = GetCategoryName(AUCTION_CATEGORY_BATTLE_PETS), subMenu = {} },
			{ itemType = LE_ITEM_CLASS_QUESTITEM, subType = 0 },
			{ text = GetCategoryName(AUCTION_CATEGORY_MISCELLANEOUS), subMenu = {
				{ itemType = LE_ITEM_CLASS_MISCELLANEOUS, subType = LE_ITEM_MISCELLANEOUS_JUNK },
				{ itemType = LE_ITEM_CLASS_MISCELLANEOUS, subType = LE_ITEM_MISCELLANEOUS_REAGENT },
				{ itemType = LE_ITEM_CLASS_MISCELLANEOUS, subType = LE_ITEM_MISCELLANEOUS_COMPANION_PET },
				{ itemType = LE_ITEM_CLASS_MISCELLANEOUS, subType = LE_ITEM_MISCELLANEOUS_HOLIDAY },
				{ itemType = LE_ITEM_CLASS_MISCELLANEOUS, subType = LE_ITEM_MISCELLANEOUS_OTHER },
				{ itemType = LE_ITEM_CLASS_MISCELLANEOUS, subType = LE_ITEM_MISCELLANEOUS_MOUNT },
				{ itemType = LE_ITEM_CLASS_MISCELLANEOUS, subType = LE_ITEM_MISCELLANEOUS_MOUNT_EQUIPMENT },
			}},
		}

		-- Dynamically fill these categories
		for i, classID in ipairs(classIDs) do
			local menu = categories[i + 2].subMenu
			
			for _, subClassID in ipairs(C_AuctionHouse.GetAuctionItemSubClasses(classID)) do
				table.insert(menu, { 
					text = GetItemSubClassInfo(classID, subClassID),
					itemType = classID,
					subType = subClassID
				})
			end
		end
		
		-- Initialize categories (auto-fill .callback)
		frame:IterateCategories(categories, function(category) 
			-- if no text has been set, get one from the available data
			if not category.text then
				if category.slot then
					if type(category.slot) == "string" then
						category.text = _G[category.slot]		-- "INVTYPE_HOLDABLE" => "Held In Off-hand"
					else
						category.text = GetItemInventorySlotInfo(category.slot)
					end
				elseif category.itemType and category.subType then
					category.text = GetItemSubClassInfo(category.itemType, category.subType)
				end
			end
			
			-- set the onClick callback, if there is no submenu, we are at the lowest level
			if not category.subMenu then
				category.callback = categoriesList_OnClick
			end
		end)
		
		frame:SetCategories(categories)
	end,

})