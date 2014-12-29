local addonName = "Altoholic"
local addon = _G[addonName]

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local GREY		= "|cFF808080"

local view
local isViewValid
local collected = {}

local function BuildView()
	-- Prepare the followers' view
	-- list all collected followers (across all alts), sorted alphabetically
	-- .. then list all uncollected followers, also sorted alphabetically

	local uncollected = {}	-- sorted list
	local followers
	
	view = {}
	
	local realm, account = addon.Tabs.Grids:GetRealm()
	
	-- Get a list of all collected followers across all alts on this realm
	for characterKey, character in pairs(DataStore:GetCharacters(realm, account)) do
		followers = DataStore:GetFollowers(character)
		
		if followers then
			for name, info in pairs(followers) do
				collected[name] = true	-- ["Admiral Taylor"] = true
			end
		end
	end

	for k, v in pairs(collected) do
		table.insert(view, k)
	end
	
	table.sort(view)
	
	-- prepare a list of uncollected followers
	for k, follower in pairs(C_Garrison.GetFollowers()) do
		if not collected[follower.name] then
			table.insert(uncollected, follower.name)
		end
	end

	table.sort(uncollected)

	for k, v in pairs(uncollected) do
		table.insert(view, v)
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
	RowSetup = function(self, entry, row, dataRowID)
			local name = view[dataRowID]
			if name then
				local rowName = entry .. row
				
				_G[rowName.."Name"]:SetText((collected[name] and WHITE or GREY) .. name)
				_G[rowName.."Name"]:SetJustifyH("LEFT")
				_G[rowName.."Name"]:SetPoint("TOPLEFT", 15, 0)
			end
		end,
	ColumnSetup = function(self, entry, row, column, dataRowID, character)
			local itemName = entry.. row .. "Item" .. column;
			local itemTexture = _G[itemName .. "_Background"]
			local itemButton = _G[itemName]
			local itemText = _G[itemName .. "Name"]
			
			local name = view[dataRowID]
			local _, rarity, level = DataStore:GetFollowerInfo(character, name)

			-- id has to come from the reference, as we are listing all followers here (even those uncollected by some alts)
			local id = DataStore:GetFollowerID(name)	

			itemText:SetFontObject("NumberFontNormalSmall")
			itemText:SetJustifyH("RIGHT")
			itemText:SetPoint("BOTTOMRIGHT", 0, 0)
			itemTexture:SetDesaturated(false)
			itemTexture:SetTexCoord(0, 1, 0, 1)
			GarrisonFollowerPortrait_Set(itemTexture, C_Garrison.GetFollowerPortraitIconIDByID(id))
			-- itemTexture:SetToFileData(C_Garrison.GetFollowerPortraitIconIDByID(id))
			
			if level then
				itemButton.key = character
				itemButton.followerName = name
				itemTexture:SetVertexColor(1.0, 1.0, 1.0);
				itemText:SetText(GREEN .. level)
				
				local r, g, b = GetItemQualityColor(rarity)
				itemButton.border:SetVertexColor(r, g, b, 0.5)
				itemButton.border:Show()
				
			else
				itemButton.key = nil
				itemButton.followerName = nil
				itemTexture:SetVertexColor(0.4, 0.4, 0.4);
				itemText:SetText("")
				itemButton.border:SetVertexColor(1.0, 1.0, 1.0, 0.5)
				itemButton.border:Hide()
			end
		end,
	OnEnter = function(frame) 
			local character = frame.key
			if not character then return end

			-- get the follower link
			local link = DataStore:GetFollowerLink(character, frame.followerName)
			if not link then return end
			
			-- toggle the tooltip, use blizzard's own function for that
			local _, garrisonFollowerID, quality, level, itemLevel, ability1, ability2, ability3, ability4, trait1, trait2, trait3, trait4 = strsplit(":", link);
			FloatingGarrisonFollowerTooltip:ClearAllPoints()
			FloatingGarrisonFollowerTooltip:SetPoint("TOPLEFT", frame, "TOPRIGHT", 1, 1)
			FloatingGarrisonFollower_Toggle(tonumber(garrisonFollowerID), tonumber(quality), tonumber(level), tonumber(itemLevel), tonumber(ability1), tonumber(ability2), tonumber(ability3), tonumber(ability4), tonumber(trait1), tonumber(trait2), tonumber(trait3), tonumber(trait4))
		end,
	OnClick = function(frame, button)
			local character = frame.key
			if not character then return end

			-- get the follower link
			local link = DataStore:GetFollowerLink(character, frame.followerName)
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

addon.Tabs.Grids:RegisterGrid(12, callbacks)
