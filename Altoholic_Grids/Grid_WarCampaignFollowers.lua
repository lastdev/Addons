local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local OPTION_FOLLOWERS = "UI.Tabs.Grids.Garrisons.CurrentFollowers"

local view
local isViewValid
local collected = {}

local function SortByFollowerName(a, b)
	local nameA = C_Garrison.GetFollowerNameByID(a)
	local nameB = C_Garrison.GetFollowerNameByID(b)
	
	return nameA < nameB
end

local function BuildView()
	-- Prepare the followers' view
	-- list all collected followers (across all alts), sorted alphabetically
	-- .. then list all uncollected followers, also sorted alphabetically

	local account = AltoholicTabGrids:GetAccount()
	local uncollected = {}
	local followers
	
	-- Prepare a list of all collected followers across all alts on this account
    for realm in pairs(DataStore:GetRealms(account)) do
    	for characterKey, character in pairs(DataStore:GetCharacters(realm, account)) do
    		followers = DataStore:GetBFAFollowers(character)
    		
    		if followers then
    			for id, _ in pairs(followers) do
    				-- temporary fix: follower keys have been replaced from their name (string) to their id (numeric)
    				-- fix it here instead of in datastore, which is already ok.
    				if (type(id) == "number") then
    					collected[id] = true	-- [123] = true
    				end
    			end
    		end
    	end
    end
	
	-- Prepare a list of uncollected followers
	local followersList = C_Garrison.GetFollowers(Enum.GarrisonFollowerType.FollowerType_8_0)
	if followersList then 
		local link
		for k, follower in pairs(followersList) do
  			link = C_Garrison.GetFollowerLinkByID(follower.followerID)
  			if link then
  				local	id = link:match("garrfollower:(%d+)")
  				id = tonumber(id)
  					
  				if not collected[id] then
  					table.insert(uncollected, id)
  				end
  			end
		end
		table.sort(uncollected, SortByFollowerName)
	end
	
	-- Now prepare the view, depending on user selection.
	view = {}
	
	local currentFollowers = addon:GetOption(OPTION_FOLLOWERS)
	
	-- in every other case (1, 2, 4 ,5) , we must add collected followers
	for id, _ in pairs(collected) do
		table.insert(view, id)
	end
	table.sort(view, SortByFollowerName)

	-- add uncollected
	for k, id in pairs(uncollected) do
		table.insert(view, id)
	end
	
	isViewValid = true
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
			local name = C_Garrison.GetFollowerNameByID(id)
			rowFrame.Name.followerID = id
			rowFrame.Name.followerName = name

			if name then
				rowFrame.Name.Text:SetText(colors.white .. name)
				rowFrame.Name.Text:SetJustifyH("LEFT")
			end
		end,
	RowOnEnter = function(self)
			local id = self.followerID
			local text = C_Garrison.GetFollowerSourceTextByID(id)
			if not text then return end
			
			AltoTooltip:SetOwner(self, "ANCHOR_TOP")
			AltoTooltip:ClearLines()
			AltoTooltip:AddLine(self.followerName, 1, 1, 1)
			AltoTooltip:AddLine(" ")
			AltoTooltip:AddLine(text)
			AltoTooltip:Show()
		end,
	RowOnLeave = function(self)
			AltoTooltip:Hide()
		end,
	ColumnSetup = function(self, button, dataRowID, character)
			local id = view[dataRowID]
			local rarity, level = DataStore:GetFollowerInfo(character, id)

			button.Name:SetFontObject("NumberFontNormalSmall")
			button.Name:SetJustifyH("RIGHT")
			button.Name:SetPoint("BOTTOMRIGHT", 0, 0)
			button.Background:SetDesaturated(false)
			button.Background:SetTexCoord(0, 1, 0, 1)
			-- GarrisonFollowerPortrait_Set(button.Background, C_Garrison.GetFollowerPortraitIconIDByID(id))
			
			button.Background:SetTexture(C_Garrison.GetFollowerPortraitIconIDByID(id))
			
			if level then
				button.key = character
				button.followerID = id
				button.Background:SetVertexColor(1.0, 1.0, 1.0);
				button.Name:SetText(colors.green .. level)
				
				local r, g, b = GetItemQualityColor(rarity)
				button.IconBorder:SetVertexColor(r, g, b, 0.5)
				button.IconBorder:Show()
				
			else
				button.key = nil
				button.followerID = nil
				button.Background:SetVertexColor(0.4, 0.4, 0.4);
				button.Name:SetText("")
				button.IconBorder:SetVertexColor(1.0, 1.0, 1.0, 0.5)
				button.IconBorder:Hide()
			end
		end,
	OnEnter = function(frame)
			addon:DrawFollowerTooltip(frame)
		end,
	OnClick = function(frame, button)
			local character = frame.key
			if not character then return end

			-- get the follower link
			local link = DataStore:GetFollowerLink(character, frame.followerID)
			if not link then return end
			
			-- on shift-click, insert in chat
			if ( button == "LeftButton" ) and ( IsShiftKeyDown() ) then
				local chat = ChatEdit_GetLastActiveWindow()
				if chat:IsShown() then
					chat:Insert(link)
				end
			end
		end,
	OnLeave = function(self)
			FloatingGarrisonFollowerTooltip:Hide()
		end,
	InitViewDDM = function(frame, title)
			frame:Hide()
            title:Hide()
		end,
}

local function OnFollowersUpdated()
	isViewValid = nil
	AltoholicTabGrids:Update()
end

addon:RegisterMessage("DATASTORE_GARRISON_FOLLOWERS_UPDATED", OnFollowersUpdated)

AltoholicTabGrids:RegisterGrid(17, callbacks)
