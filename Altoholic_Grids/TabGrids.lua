local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local CHARS_PER_FRAME = 12
local current_start_col = 1
local gridCallbacks = {}
local start_char_index = 1

addon:Controller("AltoholicUI.TabGrids", {
	OnBind = function(frame)
		frame.Label1:SetText(L["Realm"])
		frame.Equipment.text = L["Equipment"]
		frame.Factions.text = L["Reputations"]
		frame.Archeology.text = GetSpellInfo(78670)
		frame.Dailies.text = "Daily Quests"
		frame.FollowerAbilities.text = format("%s/%s", GARRISON_RECRUIT_ABILITIES, GARRISON_RECRUIT_TRAITS)
		frame.Sets.text = WARDROBE_SETS
		
		frame.SelectRealm:RegisterClassEvent("RealmChanged", function()
				frame.Status:SetText("")
				frame:Update()
			end)
		
		frame.ClassIcons.OnCharacterChanged = function()
				frame:Update()
			end
			
		frame.Equipment:StartAutoCastShine()
		frame.currentGridID = 1
	end,
	RegisterGrid = function(frame, gridID, callbacks)
		gridCallbacks[gridID] = callbacks
	end,
	InitializeGrid = function(frame, gridID)
		if gridCallbacks[gridID] then
			gridCallbacks[gridID].InitViewDDM(frame.SelectView, frame.TextView)
		end
		frame.currentGridID = gridID
	end,
	Update = function(frame)
		local account, realm = frame.SelectRealm:GetCurrentRealm()
		frame.ClassIcons:Update(account, realm)

		local grids = AltoholicFrameGrids
		local scrollFrame = grids.ScrollFrame
		local numRows = scrollFrame.numRows
		grids:Show()
			
		local offset = scrollFrame:GetOffset()
		frame:SetStatus("")
		
		local obj = gridCallbacks[frame.currentGridID]	-- point to the callbacks of the current object (equipment, tabards, ..)
		obj:OnUpdate()
		
		local size = obj:GetSize()
		local itemButton
		
        -- AltoIconListEntryTemplate.Item1
        -- 	<Anchor point="BOTTOMLEFT" relativeKey="$parent" relativePoint="BOTTOMLEFT" x="180" y="0" />
        local classIcons = frame.ClassIcons

        -- Update which class icons are shown
        for i = 1, 50 do
            local icon = classIcons["Icon"..i]
            icon:ClearAllPoints()
            if (i < current_start_col) or (i >= (current_start_col + CHARS_PER_FRAME)) then
                icon:SetShown(false)
            else
                if (i == current_start_col) then
                    icon:SetPoint("TOPLEFT", icon:GetParent())
                else
                    icon:SetPoint("BOTTOMLEFT", classIcons["Icon"..(i-1)], "BOTTOMLEFT", 35, 0)
                end
                icon:SetShown(true)
                icon:Show()
            end
        end
        
		for rowIndex = 1, numRows do
			local rowFrame = scrollFrame:GetRow(rowIndex)
			local dataRowID = rowIndex + offset
			if dataRowID <= size then	-- if the row is visible

				obj:RowSetup(rowFrame, dataRowID)
				itemButton = rowFrame.Name
				itemButton:SetScript("OnEnter", obj.RowOnEnter)
				itemButton:SetScript("OnLeave", obj.RowOnLeave)
                
                local current_end_col = current_start_col + CHARS_PER_FRAME
                if current_end_col > 50 then current_end_col = 50 end
				for colIndex = 1, 50 do
					itemButton = rowFrame["Item"..colIndex]
					itemButton.IconBorder:Hide()
					
					character = addon:GetOption(format("Tabs.Grids.%s.%s.Column%d", account, realm, colIndex))
					if character then
						itemButton:SetScript("OnEnter", obj.OnEnter)
						itemButton:SetScript("OnClick", obj.OnClick)
						itemButton:SetScript("OnLeave", obj.OnLeave)
						
						itemButton:Show()	-- note: this Show() must remain BEFORE the next call, if the button has to be hidden, it's done in ColumnSetup
						obj:ColumnSetup(itemButton, dataRowID, character)
                        itemButton:ClearAllPoints()
                        if (colIndex < current_start_col) or (colIndex >= current_end_col) then
                            -- Column is out of range, hide it
                            itemButton:Hide()
                        elseif colIndex == current_start_col then
                            -- Column is the left-most one, anchor it to the left
                            itemButton:SetPoint("BOTTOMRIGHT", rowFrame["Name"], "BOTTOMRIGHT", 50, 0)
                        else
                            -- Column is in the middle, anchor it to the one next to it
                            itemButton:SetPoint("BOTTOMLEFT", rowFrame["Item"..(colIndex-1)], "BOTTOMLEFT", 35, 0)
                        end
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

		scrollFrame:Update(size)
	end,
	UpdateMenuIcons = function(frame)
		if DataStore_Inventory then
			frame.Equipment:EnableIcon()
		else
			frame.Equipment:DisableIcon()
		end

		if DataStore_Reputations then
			frame.Factions:EnableIcon()
		else
			frame.Factions:DisableIcon()
		end
		
		if DataStore_Currencies then
			frame.Tokens:EnableIcon()
		else
			frame.Tokens:DisableIcon()
		end
		
		if DataStore_Pets then
			frame.Pets:EnableIcon()
		else
			frame.Pets:DisableIcon()
		end

		if DataStore_Quests then
			frame.Dailies:EnableIcon()
		else
			frame.Dailies:DisableIcon()
		end
		
		if DataStore_Agenda then
			frame.Dungeons:EnableIcon()
		else
			frame.Dungeons:DisableIcon()
		end
		
		if DataStore_Garrisons then
			frame.GarrisonArchitect:EnableIcon()
			frame.GarrisonFollowers:EnableIcon()
			frame.FollowerAbilities:EnableIcon()
		else
			frame.GarrisonArchitect:DisableIcon()
			frame.GarrisonFollowers:DisableIcon()
			frame.FollowerAbilities:DisableIcon()
		end
	end,
	SetStatus = function(frame, text)
		frame.Status:SetText(text or "")
	end,
	SetViewDDMText = function(frame, text)
		frame.SelectView:SetText(text)
	end,
	GetRealm = function(frame)
		return frame.SelectRealm:GetCurrentRealm()	-- returns : account, realm
	end,
})

function addon:OnTabGridsRightButtonClick(frame)
    if current_start_col == 50 then return end
    current_start_col = current_start_col + 1
    frame:GetParent().Update(frame:GetParent())    
end

function addon:OnTabGridsLeftButtonClick(frame)
    if current_start_col == 1 then return end
    current_start_col = current_start_col - 1
    frame:GetParent().Update(frame:GetParent())
end