local addonName = "Altoholic"
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local RED		= "|cFFFF0000"

local parentName = "AltoholicTabSearch"
local parent

local view
local highlightIndex

addon.Tabs.Search = {}

local ns = addon.Tabs.Search		-- ns = namespace

local function BuildView()
	view = view or {}
	wipe(view)
	
	local itemClasses =  { GetAuctionItemClasses() };
	local classNum = 1
	for _, itemClass in pairs(itemClasses) do
		table.insert(view, { name = itemClass, isCollapsed = true } )
		table.insert(view, L["Any"] )
		
		local itemSubClasses =  { GetAuctionItemSubClasses(classNum) };
		for _, itemSubClass in pairs(itemSubClasses) do
			table.insert(view, itemSubClass )
		end
		
		classNum = classNum + 1
	end
end

local function Header_OnClick(frame)
	local header = view[frame.itemTypeIndex]
	header.isCollapsed = not header.isCollapsed
	
	-- if header.isCollapsed == true then
		-- header.isCollapsed = false
	-- else
		-- header.isCollapsed = true
	-- end
	ns:Update()
end

local function Item_OnClick(frame)
	local itemType = frame.itemTypeIndex
	local itemSubType = frame.itemSubTypeIndex

	highlightIndex = itemSubType
	ns:Update()
	
	-- around 5-7 ms on the current realm, 25-40 ms in the loot tables
	if view[itemSubType] == L["Any"] then
		addon.Search:FindItem(view[itemType].name)
	else
		addon.Search:FindItem(view[itemType].name, view[itemSubType])
	end
end

function ns:OnLoad()
	parent = _G[parentName]
	AltoholicTabSearch_Sort1:SetText(L["Item / Location"])
	AltoholicTabSearch_Sort2:SetText(L["Character"])
	AltoholicTabSearch_Sort3:SetText(L["Realm"])
	parent.Slot:SetText(L["Equipment Slot"])
	parent.Location:SetText(L["Location"])
end

function ns:Update()
	if not view then
		BuildView()
	end
	
	local numRows = 15

	local itemTypeIndex				-- index of the item type in the menu table
	local itemTypeCacheIndex		-- index of the item type in the cache table
	local MenuCache = {}
	
	for k, v in pairs (view) do		-- rebuild the cache
		if type(v) == "table" then		-- header
			itemTypeIndex = k
			table.insert(MenuCache, { linetype=1, nameIndex=k } )
			itemTypeCacheIndex = #MenuCache
		else
			if view[itemTypeIndex].isCollapsed == false then
				table.insert(MenuCache, { linetype=2, nameIndex=k, parentIndex=itemTypeIndex } )
				
				if (highlightIndex) and (highlightIndex == k) then
					MenuCache[#MenuCache].needsHighlight = true
					MenuCache[itemTypeCacheIndex].needsHighlight = true
				end
			end
		end
	end
	
	local buttonWidth = 156
	if #MenuCache > 15 then
		buttonWidth = 136
	end
	
	local frame = AltoholicTabSearch
	local scrollFrame = AltoholicSearchMenuScrollFrame
	local offset = FauxScrollFrame_GetOffset(scrollFrame)
	local menuButton
	
	for rowIndex = 1, numRows do
		menuButton = frame["MenuItem"..rowIndex]
		
		local line = rowIndex + offset
		
		if line > #MenuCache then
			menuButton:Hide()
		else
			local p = MenuCache[line]
			
			menuButton:SetWidth(buttonWidth)
			menuButton.Text:SetWidth(buttonWidth - 21)
			if p.needsHighlight then
				menuButton:LockHighlight()
			else
				menuButton:UnlockHighlight()
			end			
			
			if p.linetype == 1 then
				menuButton.Text:SetText(WHITE .. view[p.nameIndex].name)
				menuButton:SetScript("OnClick", Header_OnClick)
				menuButton.itemTypeIndex = p.nameIndex
			elseif p.linetype == 2 then
				menuButton.Text:SetText("|cFFBBFFBB   " .. view[p.nameIndex])
				menuButton:SetScript("OnClick", Item_OnClick)
				menuButton.itemTypeIndex = p.parentIndex
				menuButton.itemSubTypeIndex = p.nameIndex
			end

			menuButton:Show()
		end
	end
	
	FauxScrollFrame_Update( scrollFrame, #MenuCache, numRows, 20)
end

function ns:Reset()
	AltoholicFrame_SearchEditBox:SetText("")
	parent.MinLevel:SetText("")
	parent.MaxLevel:SetText("")
	parent.Status:SetText("")				-- .. the search results
	AltoholicFrameSearch:Hide()
	addon.Search:ClearResults()
	collectgarbage()
	
	if view then
		for k, v in pairs(view) do			-- rebuild the cache
			if type(v) == "table" then		-- header
				v.isCollapsed = true
			end
		end
	end
	highlightIndex = nil
	
	for i = 1, 8 do 
		_G[ "AltoholicTabSearch_Sort"..i ]:Hide()
		_G[ "AltoholicTabSearch_Sort"..i ].ascendingSort = nil
	end
	ns:Update()
end

function ns:DropDownRarity_Initialize()
	local info = UIDropDownMenu_CreateInfo(); 

	for i = 0, NUM_ITEM_QUALITIES do		-- Quality: 0 = poor .. 5 = legendary
		info.text = ITEM_QUALITY_COLORS[i].hex .. _G["ITEM_QUALITY"..i.."_DESC"]
		info.value = i
		info.func = function(self)	
			UIDropDownMenu_SetSelectedValue(parent.SelectRarity, self.value);
		end
		info.checked = nil; 
		info.icon = nil; 
		UIDropDownMenu_AddButton(info, 1); 
	end
end 

local slotNames = {		-- temporary workaround
	[1] = BI["Head"],			-- "INVTYPE_HEAD" 
	[2] = BI["Shoulder"],	-- "INVTYPE_SHOULDER"
	[3] = BI["Chest"],		-- "INVTYPE_CHEST",  "INVTYPE_ROBE"
	[4] = BI["Wrist"],		-- "INVTYPE_WRIST"
	[5] = BI["Hands"],		-- "INVTYPE_HAND"
	[6] = BI["Waist"],		-- "INVTYPE_WAIST"
	[7] = BI["Legs"],			-- "INVTYPE_LEGS"
	[8] = BI["Feet"],			-- "INVTYPE_FEET"
	
	[9] = BI["Neck"],			-- "INVTYPE_NECK"
	[10] = BI["Back"],		-- "INVTYPE_CLOAK"
	[11] = BI["Ring"],		-- "INVTYPE_FINGER"
	[12] = BI["Trinket"],	-- "INVTYPE_TRINKET"
	[13] = BI["One-Hand"],	-- "INVTYPE_WEAPON"
	[14] = BI["Two-Hand"],	-- "INVTYPE_2HWEAPON"
	[15] = BI["Main Hand"],	-- "INVTYPE_WEAPONMAINHAND"
	[16] = BI["Off Hand"],	-- "INVTYPE_WEAPONOFFHAND", "INVTYPE_HOLDABLE"
	[17] = BI["Shield"],		-- "INVTYPE_SHIELD"
	[18] = BI["Ranged"]		-- "INVTYPE_RANGED",  "INVTYPE_THROWN", "INVTYPE_RANGEDRIGHT", "INVTYPE_RELIC"
}

function ns:DropDownSlot_Initialize()
	local function SetSearchSlot(self) 
		UIDropDownMenu_SetSelectedValue(parent.SelectSlot, self.value);
	end
	
	local info = UIDropDownMenu_CreateInfo(); 
	info.text = L["Any"]
	info.value = 0
	info.func = SetSearchSlot
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 	
	
	for i = 1, 18 do
		--info.text = addon.Equipment:GetSlotName(i)
		info.text = slotNames[i]		-- temporary workaround
		info.value = i
		info.func = SetSearchSlot
		info.checked = nil; 
		info.icon = nil; 
		UIDropDownMenu_AddButton(info, 1); 
	end
end 

function ns:DropDownLocation_Initialize()
	local info = UIDropDownMenu_CreateInfo();
	local text = {
		L["This character"],
		format("%s %s(%s)", L["This realm"], GREEN, L["This faction"]),
		format("%s %s(%s)", L["This realm"], GREEN, L["Both factions"]),
		L["All realms"],
		L["All accounts"],
		L["Loot tables"]
	}
	
	for i = 1, #text do
		info.text = text[i]
		info.value = i
		info.func = function(self) 
				UIDropDownMenu_SetSelectedValue(parent.SelectLocation, self.value)
			end
		info.checked = nil; 
		info.icon = nil; 
		UIDropDownMenu_AddButton(info, 1); 		
	end
end

function ns:SetMode(mode)

	local Columns = addon.Tabs.Columns
	Columns:Init()
	
	-- sets the search mode, and prepares the frame accordingly (search update callback, column sizes, headers, etc..)
	if mode == "realm" then
		addon.Search:SetUpdateHandler("Realm_Update")
		
		Columns:Add(L["Item / Location"], 240, function(self) addon.Search:SortResults(self, "name") end)
		Columns:Add(L["Character"], 160, function(self) addon.Search:SortResults(self, "char") end)
		Columns:Add(L["Realm"], 150, function(self) addon.Search:SortResults(self, "realm") end)

		AltoholicTabSearch_Sort2:SetPoint("LEFT", AltoholicTabSearch_Sort1, "RIGHT", 5, 0)
		AltoholicTabSearch_Sort3:SetPoint("LEFT", AltoholicTabSearch_Sort2, "RIGHT", 5, 0)
	
	elseif mode == "loots" then
		addon.Search:SetUpdateHandler("Loots_Update")
		
		Columns:Add(L["Item / Location"], 240, function(self) addon.Search:SortResults(self, "item") end)
		Columns:Add(L["Source"], 160, function(self) addon.Search:SortResults(self, "bossName") end)
		Columns:Add(L["Item Level"], 150, function(self) addon.Search:SortResults(self, "iLvl") end)
		
		AltoholicTabSearch_Sort2:SetPoint("LEFT", AltoholicTabSearch_Sort1, "RIGHT", 5, 0)
		AltoholicTabSearch_Sort3:SetPoint("LEFT", AltoholicTabSearch_Sort2, "RIGHT", 5, 0)
		
	elseif mode == "upgrade" then
		addon.Search:SetUpdateHandler("Upgrade_Update")

		Columns:Add(L["Item / Location"], 200, function(self) addon.Search:SortResults(self, "item") end)
		
		for i=1, 6 do 
			local text = select(i, strsplit("|", addon.Equipment.FormatStats[addon.Search:GetClass()]))
			
			if text then
				Columns:Add(string.sub(text, 1, 3), 50, function(self)
					addon.Search:SortResults(self, "stat") -- use a getID to know which stat
				end)
			else
				Columns:Add(nil)
			end
		end
		
		AltoholicTabSearch_Sort2:SetPoint("LEFT", AltoholicTabSearch_Sort1, "RIGHT", 0, 0)
		AltoholicTabSearch_Sort3:SetPoint("LEFT", AltoholicTabSearch_Sort2, "RIGHT", 0, 0)

		Columns:Add("iLvl", 50, function(self) addon.Search:SortResults(self, "iLvl") end)
	end
end

function ns:TooltipStats(frame)
	AltoTooltip:ClearLines();
	AltoTooltip:SetOwner(frame, "ANCHOR_RIGHT");
	
	AltoTooltip:AddLine(STATS_LABEL)
	AltoTooltip:AddLine(" ");
	
	local s = addon.Search:GetResult(frame:GetID())

	for i=1, 6 do
		local text = select(i, strsplit("|", addon.Equipment.FormatStats[addon.Search:GetClass()]))
		if text then 
			local color
			local diff = select(2, strsplit("|", s["stat"..i]))
			diff = tonumber(diff)

			if diff < 0 then
				color = RED
			elseif diff > 0 then 
				color = GREEN
				diff = "+" .. diff
			else
				color = WHITE
			end
			AltoTooltip:AddLine(format("%s%s %s", color, diff, text))
		end
	end
	AltoTooltip:Show()
end
