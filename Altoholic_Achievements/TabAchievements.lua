local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local ICON_NOT_STARTED = "Interface\\RaidFrame\\ReadyCheck-NotReady" 
local ICON_PARTIAL = "Interface\\RaidFrame\\ReadyCheck-Waiting"
local ICON_COMPLETED = "Interface\\RaidFrame\\ReadyCheck-Ready" 

local view
local highlightIndex
local currentPage
local MAX_PAGES = 12	-- good for 144 alts, should be enough, 1 page per class is even possible

local function BuildView()
	view = view or {}
	wipe(view)
	
	local cats = GetCategoryList()
	for _, categoryID in ipairs(cats) do
		local _, parentID = GetCategoryInfo(categoryID)
		
		if parentID == -1 then		-- add categories, followed by their respective sub-categories
			table.insert(view, { id = categoryID, isCollapsed = true } )
			
			for _, subCatID in ipairs(cats) do
				local _, subCatParentID = GetCategoryInfo(subCatID)
				if subCatParentID == categoryID then
					table.insert(view, subCatID )
				end
			end
		end
	end
end

local function ShowCategory(frame, id)
	local tab = frame:GetParent()
	
	tab:Update()
	tab:Show()
	tab.Achievements:SetCategory(id)
	tab.Achievements:Update()
end

local function Header_OnClick(frame)
	highlightIndex = frame.categoryIndex
	local header = view[highlightIndex]
	header.isCollapsed = not header.isCollapsed

	ShowCategory(frame, header.id)
end

local function Item_OnClick(frame)
	highlightIndex = frame.subCategoryIndex
	ShowCategory(frame, view[highlightIndex])
end

local function OnAchievementEarned(event, id)
	if id then
		AltoholicTabAchievements.Achievements:Update()
	end
end

addon:Controller("AltoholicUI.TabAchievements", {
	OnBind = function(frame)
		currentPage = 1
		frame.PageNumber:SetText(format(MERCHANT_PAGE_NUMBER, currentPage, MAX_PAGES))
	
		frame.SelectRealm:RegisterClassEvent("RealmChanged", function(self, account, realm) 
				frame.ClassIcons:Update(account, realm, 1)	-- page 1 when changing realm
				frame.Status:SetText("")
				frame.Achievements:Update()
			end)
			
		frame.SelectRealm:RegisterClassEvent("DropDownInitialized", function(self) 
				self:AddTitle()
				self:AddTitle(format("%s%s", colors.gold, L["Not started"]), ICON_NOT_STARTED)
				self:AddTitle(format("%s%s", colors.gold, L["Started"]), ICON_PARTIAL)
				self:AddTitle(format("%s%s", colors.gold, COMPLETE), ICON_COMPLETED)
			end)
			
		frame.ClassIcons.OnCharacterChanged = function(self)
				local account, realm = frame.SelectRealm:GetCurrentRealm()
				self:Update(account, realm, currentPage)
				frame.Achievements:Update()
			end
			
		addon:RegisterEvent("ACHIEVEMENT_EARNED", OnAchievementEarned)
		
		-- test new menu view
		
		
		-- local view = frame.LeftMenu:CreateView(frame.LeftMenu.name)
		-- local cats = GetCategoryList()
			
		-- for _, categoryID in ipairs(cats) do
			-- local catName, parentID = GetCategoryInfo(categoryID)
			
			-- if parentID == -1 then		-- add categories, followed by their respective sub-categories
				-- frame.LeftMenu:AddHeader(view, catName, onClickCallback)
				-- table.insert(view, { id = categoryID, isCollapsed = true } )
				
				-- for _, subCatID in ipairs(cats) do
					-- local _, subCatParentID = GetCategoryInfo(subCatID)
					-- if subCatParentID == categoryID then
						-- table.insert(view, subCatID )
					-- end
				-- end
			-- end
		-- end
		
		
	end,
	Update = function(frame)
		local account, realm = frame.SelectRealm:GetCurrentRealm()
		frame.ClassIcons:Update(account, realm, currentPage)

		if not view then
			BuildView()
		end

		local categoryIndex				-- index of the category in the menu table
		local categoryCacheIndex		-- index of the category in the cache table
		local MenuCache = {}
		
		for k, v in pairs (view) do		-- rebuild the cache
			if type(v) == "table" then		-- header
				categoryIndex = k
				table.insert(MenuCache, { linetype=1, nameIndex=k } )
				categoryCacheIndex = #MenuCache
				
				if (highlightIndex) and (highlightIndex == k) then
					MenuCache[#MenuCache].needsHighlight = true
				end
			else
				if view[categoryIndex].isCollapsed == false then
					table.insert(MenuCache, { linetype=2, nameIndex=k, parentIndex=categoryIndex } )
					
					if (highlightIndex) and (highlightIndex == k) then
						MenuCache[#MenuCache].needsHighlight = true
						MenuCache[categoryCacheIndex].needsHighlight = true
					end
				end
			end
		end
		
		local buttonWidth = 156
		if #MenuCache > 15 then
			buttonWidth = 136
		end
		
		local scrollFrame = frame.ScrollFrame
		local numRows = scrollFrame.numRows
		local offset = scrollFrame:GetOffset()
		local menuButton
		
		for rowIndex = 1, numRows do
			menuButton = scrollFrame:GetRow(rowIndex)
			
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
					local catName = GetCategoryInfo(view[p.nameIndex].id)
					
					menuButton.Text:SetText(colors.white .. catName)
					menuButton:SetScript("OnClick", Header_OnClick)
					menuButton.categoryIndex = p.nameIndex
				elseif p.linetype == 2 then
					local catName = GetCategoryInfo(view[p.nameIndex])
					
					menuButton.Text:SetText("|cFFBBFFBB   " .. catName)
					menuButton:SetScript("OnClick", Item_OnClick)
					menuButton.categoryIndex = p.parentIndex
					menuButton.subCategoryIndex = p.nameIndex
				end

				menuButton:Show()
			end
		end
		
		scrollFrame:Update(#MenuCache)
	end,
	GoToPreviousPage = function(frame)
		frame:SetPage(currentPage - 1)
	end,
	GoToNextPage = function(frame)
		frame:SetPage(currentPage + 1)
	end,
	GetPage = function(frame)
		return currentPage
	end,
	SetPage = function(frame, pageNum)
		currentPage = pageNum

		-- fix minimum page number
		currentPage = (currentPage < 1) and 1 or currentPage
		
		if currentPage == 1 then
			frame.PrevPage:Disable()
		else
			frame.PrevPage:Enable()
		end
		
		-- fix maximum page number
		currentPage = (currentPage > MAX_PAGES) and MAX_PAGES or currentPage
		
		if currentPage == MAX_PAGES then
			frame.NextPage:Disable()
		else
			frame.NextPage:Enable()
		end

		frame.PageNumber:SetText(format(MERCHANT_PAGE_NUMBER, currentPage, MAX_PAGES))	
		frame:Update()
		frame.Achievements:Update()
	end,
	GetRealm = function(frame)
		local account, realm = frame.SelectRealm:GetCurrentRealm()
		return realm, account
	end,
})
