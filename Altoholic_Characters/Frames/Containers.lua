local addonName = "Altoholic"
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

addon.Containers = {}

local ns = addon.Containers		-- ns = namespace

local bagIndices

local function UpdateBagIndices(bag, size)
	-- the BagIndices table will be used by self:Containers_Update to determine which part of a bag should be displayed on a given line
	-- ex: [1] = bagID = 0, from 1, to 12
	-- ex: [2] = bagID = 0, from 13, to 16

	local lowerLimit = 1

	while size > 0 do					-- as long as there are slots to process ..
		table.insert(bagIndices, { bagID=bag, from=lowerLimit} )
	
		if size <= 12 then			-- no more lines ? leave
			return
		else
			size = size - 12			-- .. or adjust counters
			lowerLimit = lowerLimit + 12
		end
	end
end

local function UpdateSpread()

	local rarity = addon:GetOption("UI.Tabs.Characters.ViewBagsRarity")
	
	local numRows = 7
	local frame = AltoholicFrameContainers
	local scrollFrame = frame.ScrollFrame
	
	if #bagIndices == 0 then
		for i = 1, numRows do
			frame["Entry"..i]:Hide()
		end
		
		FauxScrollFrame_Update( scrollFrame, numRows, numRows, 41)
		return
	end
	
	local character = Altoholic.Tabs.Characters:GetAltKey()
	local DS = DataStore
	local offset = FauxScrollFrame_GetOffset( scrollFrame );
	
	AltoholicTabCharacters.Status:SetText(format("%s|r / %s", DataStore:GetColoredCharacterName(character), L["Containers"]))
	
	local rowFrame
	local itemButton
	
	for i=1, numRows do
		rowFrame = frame["Entry"..i]
		
		local line = i + offset
		
		if line <= #bagIndices then
		
			local containerID = bagIndices[line].bagID
			local container = DS:GetContainer(character, containerID)
			local containerIcon, _, containerSize = DS:GetContainerInfo(character, containerID)
			
			-- Column 1 : the bag
			itemButton = rowFrame.Item1
			
			if bagIndices[line].from == 1 then		-- if this is the first line for this bag .. draw bag icon
				itemButton.Icon:SetDesaturated(false)
				
				-- 15/10/2014: note, find a better way for this than this ugly hack
				if containerID == "VoidStorage.Tab1" then
					itemButton:SetID(201)	-- use id 201 for void storage, only required a few lines below
				elseif containerID == "VoidStorage.Tab2" then
					itemButton:SetID(202)	-- use id 202 for void storage, only required a few lines below
				elseif containerID == REAGENTBANK_CONTAINER then
					itemButton:SetID(300)
				else
					itemButton:SetID(containerID)
				end
				
				itemButton.Icon:SetTexture(containerIcon)
				itemButton:SetScript("OnEnter", function(self)
					local id = self:GetID()
					GameTooltip:SetOwner(self, "ANCHOR_LEFT");
					if id == 0 then
						GameTooltip:AddLine(BACKPACK_TOOLTIP,1,1,1);
						GameTooltip:AddLine(format(CONTAINER_SLOTS, 16, BAGSLOT),1,1,1);
						
					elseif id == 100 then
						GameTooltip:AddLine(L["Bank"],0.5,0.5,1);
						GameTooltip:AddLine(L["28 Slot"],1,1,1);
					elseif id >= 201 and id <= 202 then
						GameTooltip:AddLine(VOID_STORAGE,0.5,0.5,1);
					elseif id == 300 then
						GameTooltip:AddLine(REAGENT_BANK,0.5,0.5,1);
					else
						local character = Altoholic.Tabs.Characters:GetAltKey()
						local _, link = DS:GetContainerInfo(character, id)
						GameTooltip:SetHyperlink(link);
						if (id >= 5) and (id <= 11) then
							GameTooltip:AddLine(L["Bank bag"],0,1,0);
						end
					end
					GameTooltip:Show();
				end)
				itemButton.Count:Hide()
				itemButton:Show()
			else
				itemButton:Hide()
			end
			
			-- Column 2 : empty
			itemButton = rowFrame.Item2
			itemButton:Hide()
			itemButton.id = nil
			itemButton.link = nil
			
			-- Columns 3 to 14 : bag content
			for j=3, 14 do
				itemButton = rowFrame["Item"..j]
				itemButton.IconBorder:Hide()
				itemButton.Icon:SetDesaturated(false)
				
				local slotID = bagIndices[line].from - 3 + j
				local itemID, itemLink, itemCount = DS:GetSlotInfo(container, slotID)
				
				if (slotID <= containerSize) then 
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
							Altoholic:Item_OnEnter(self)
						end)
					
					if not itemCount or (itemCount < 2) then
						itemButton.Count:Hide();
					else
						itemButton.Count:SetText(itemCount);
						itemButton.Count:Show();
					end
					
					local startTime, duration, isEnabled = DS:GetContainerCooldownInfo(container, slotID)
					
					itemButton.startTime = startTime
					itemButton.duration = duration
					
					CooldownFrame_SetTimer(itemButton.Cooldown, startTime or 0, duration or 0, isEnabled)
				
					itemButton:Show()
				else
					itemButton:Hide()
					itemButton.id = nil
					itemButton.link = nil
					itemButton.startTime = nil
					itemButton.duration = nil
				end
			end
			rowFrame:Show()
		else
			rowFrame:Hide()
		end
	end
	
	if #bagIndices < numRows then
		FauxScrollFrame_Update( scrollFrame, numRows, numRows, 41);
	else
		FauxScrollFrame_Update( scrollFrame, #bagIndices, numRows, 41);
	end	
end	

local function UpdateAllInOne()
	local rarity = addon:GetOption("UI.Tabs.Characters.ViewBagsRarity")
	local numRows = 7
	local frame = AltoholicFrameContainers
	local scrollFrame = frame.ScrollFrame
	
	local character = Altoholic.Tabs.Characters:GetAltKey()
	AltoholicTabCharacters.Status:SetText(format("%s|r / %s / %s", DataStore:GetColoredCharacterName(character), L["Containers"], L["All-in-one"]))

	local offset = FauxScrollFrame_GetOffset(scrollFrame)
	
	local minSlotIndex = offset * 14
	local currentSlotIndex = 0		-- this indexes the non-empty slots
	local rowIndex = 1
	local colIndex = 1
	
	local containerList = {}

	if addon:GetOption("UI.Tabs.Characters.ViewBags") then
		for i = 0, 4 do
			table.insert(containerList, i)
		end
	end
	
	if addon:GetOption("UI.Tabs.Characters.ViewBank") then
		for i = 5, 11 do
			table.insert(containerList, i)
		end
		table.insert(containerList, 100)
	end
	
	if addon:GetOption("UI.Tabs.Characters.ViewVoidStorage") then
		table.insert(containerList, "VoidStorage.Tab1")
		table.insert(containerList, "VoidStorage.Tab2")
	end
	
	if addon:GetOption("UI.Tabs.Characters.ViewReagentBank") then
		table.insert(containerList, REAGENTBANK_CONTAINER)
	end
	
	local itemButton
	if #containerList > 0 then
		local DS = DataStore
		
		for _, containerID in pairs(containerList) do
			local container = DS:GetContainer(character, containerID)
			local _, _, containerSize = DS:GetContainerInfo(character, containerID)

			for slotID = 1, containerSize do
				local itemID, itemLink, itemCount = DS:GetSlotInfo(container, slotID)
				if itemID then
					currentSlotIndex = currentSlotIndex + 1
					if (currentSlotIndex > minSlotIndex) and (rowIndex <= numRows) then
						itemButton = frame["Entry"..rowIndex]["Item"..colIndex]
						itemButton.IconBorder:Hide()
						itemButton.Icon:SetTexture(GetItemIcon(itemID))
						itemButton.Icon:SetDesaturated(false)
						
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
						
						itemButton.id = itemID
						itemButton.link = itemLink
						itemButton:SetScript("OnEnter", function(self) 
								Altoholic:Item_OnEnter(self)
							end)
					
						if not itemCount or (itemCount < 2) then
							itemButton.Count:Hide();
						else
							itemButton.Count:SetText(itemCount);
							itemButton.Count:Show();
						end
						
						local startTime, duration, isEnabled = DS:GetContainerCooldownInfo(container, slotID)
						
						itemButton.startTime = startTime
						itemButton.duration = duration
						
						CooldownFrame_SetTimer(itemButton.Cooldown, startTime or 0, duration or 0, isEnabled)
				
						itemButton:Show()
						
						colIndex = colIndex + 1
						if colIndex > 14 then
							colIndex = 1
							rowIndex = rowIndex + 1
						end
					end				
				end
			end
		end
	end
		
	while rowIndex <= numRows do
		while colIndex <= 14 do
			itemButton = frame["Entry"..rowIndex]["Item"..colIndex]
			itemButton:Hide()
			itemButton.id = nil
			itemButton.link = nil
			itemButton.startTime = nil
			itemButton.duration = nil
			colIndex = colIndex + 1
		end
	
		colIndex = 1
		rowIndex = rowIndex + 1
	end
	
	for i = 1, numRows do
		frame["Entry"..i]:Show()
	end

	FauxScrollFrame_Update( scrollFrame, ceil(currentSlotIndex / 14), numRows, 41);
end


function ns:SetView(isAllInOne)
	if not isAllInOne then	-- not an all-in-one view
		ns.Update = UpdateSpread
		ns:UpdateCache()
		FauxScrollFrame_SetOffset( AltoholicFrameContainers.ScrollFrame, 0)
	else
		ns.Update = UpdateAllInOne
	end
end

function ns:UpdateCache()
	bagIndices = bagIndices or {}
	wipe(bagIndices)

	local character = addon.Tabs.Characters:GetAltKey()
	
	if addon:GetOption("UI.Tabs.Characters.ViewBags") then
		for bagID = 0, 4 do
			if DataStore:GetContainer(character, bagID) then
				local _, _, size = DataStore:GetContainerInfo(character, bagID)
				UpdateBagIndices(bagID, size)
			end
		end	
	end
	
	if addon:GetOption("UI.Tabs.Characters.ViewBank") then
		for bagID = 5, 11 do
			if DataStore:GetContainer(character, bagID) then
				local _, _, size = DataStore:GetContainerInfo(character, bagID)
				UpdateBagIndices(bagID, size)
			end
		end
		
		if DataStore:GetContainer(character, 100) then 	-- if bank has been visited, add it
			UpdateBagIndices(100, 28)
		end
	end
	
	if addon:GetOption("UI.Tabs.Characters.ViewVoidStorage") then
		UpdateBagIndices("VoidStorage.Tab1", 80)
		UpdateBagIndices("VoidStorage.Tab2", 80)
	end
	
	if addon:GetOption("UI.Tabs.Characters.ViewReagentBank") then
		local _, _, size = DataStore:GetContainerInfo(character, REAGENTBANK_CONTAINER)
		UpdateBagIndices(REAGENTBANK_CONTAINER, size)
	end
end

-- *** Event Handlers ***
local function OnBagUpdate(bag)
	addon:RefreshTooltip()

	if DataStore:IsMailBoxOpen() and AltoholicFrameMail:IsVisible() then	
		-- if a bag is updated while the mailbox is opened, this means an attachment has been taken.
		addon.Mail:BuildView()
		addon.Mail:Update()
	end
end

addon:RegisterEvent("BAG_UPDATE", OnBagUpdate)
