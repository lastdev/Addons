local addonName = ...
local addon = _G[addonName]

local function _Item_OnEnter(frame)
	local itemID = frame.itemID
	if not itemID then return end
	
	local itemLink = frame.itemLink or select(2, GetItemInfo(itemID))
	if not itemLink then return end		-- still not valid ? exit
	
	GameTooltip:SetOwner(frame, "ANCHOR_LEFT")
	
	if itemLink then
		GameTooltip:SetHyperlink(itemLink)
	else
		-- this line queries the server for an unknown id
		GameTooltip:SetHyperlink("item:"..itemID..":0:0:0:0:0:0:0")	
		
		-- don't leave residual info in the tooltip after the server query
		GameTooltip:ClearLines()	
	end
	GameTooltip:Show()
end

local function _Item_OnClick(frame, button)
	local itemID = frame.itemID
	if button ~= "LeftButton" or not itemID then return end
	
	local itemLink = frame.itemLink or select(2, GetItemInfo(itemID))
	if not itemLink then return end		-- still not valid ? exit
	
	if IsControlKeyDown() then
		DressUpItemLink(itemLink)
	elseif IsShiftKeyDown() then
		local chat = ChatEdit_GetLastActiveWindow()
	
		if chat:IsShown() then
			chat:Insert(itemLink)
		else
			AltoholicFrame_SearchEditBox:SetText(GetItemInfo(itemLink))
		end
	end
end

local function _SetInfo(frame, itemID, itemLink, startTime, duration)
	frame.itemID = itemID
	frame.itemLink = itemLink
	frame.startTime = startTime
	frame.duration = duration
end

local function _SetItem(frame, itemID, itemLink, rarityToMatch)
	frame:SetInfo(itemID, itemLink)
	frame.IconBorder:Hide()
	frame.Icon:SetDesaturated(false)
	
	if itemID then
		frame:SetIcon(GetItemIcon(itemID))
		frame:SetRarityMatch(rarityToMatch)
	else
		frame:SetIcon("Interface\\PaperDoll\\UI-Backpack-EmptySlot")
	end
end

local function _SetRarity(frame, rarity)
	-- Set the right border colour depending on the item's rarity
	local r, g, b = GetItemQualityColor(rarity)
	
	frame.IconBorder:SetVertexColor(r, g, b, 0.5)
	frame.IconBorder:Show()
end

local function _SetRarityMatch(frame, rarityToMatch)
	-- the item is set to the right rarity if it matches the one passed as parameter, otherwise it is greyed out
	if not rarityToMatch or rarityToMatch == 0 then	return end

	local _, _, itemRarity = GetItemInfo(frame.itemID)
	if itemRarity and itemRarity == rarityToMatch then
		frame:SetRarity(itemRarity)
	else
		frame.Icon:SetDesaturated(true)
	end
end

local function _SetCount(frame, count)
	if not count or (count < 2) then
		frame.Count:Hide()
	else
		frame.Count:SetText(count)
		frame.Count:Show()
	end
end

local function _SetCooldown(frame, startTime, duration, isEnabled)
	frame.startTime = startTime
	frame.duration = duration

	CooldownFrame_Set(frame.Cooldown, startTime or 0, duration or 0, isEnabled)
end

addon:RegisterClassExtensions("AltoItemIcon", {
	Item_OnEnter = _Item_OnEnter,
	Item_OnClick = _Item_OnClick,
	SetInfo = _SetInfo,
	SetItem = _SetItem,
	SetRarity = _SetRarity,
	SetRarityMatch = _SetRarityMatch,
	SetCount = _SetCount,
	SetCooldown = _SetCooldown,
})
