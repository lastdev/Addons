local addonName = "Altoholic"
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local function _Update(frame, profession, recipeID, color)
	-- ** set the crafted item **
	local craftedItemID = DataStore:GetCraftResultItem(recipeID)
	local itemName, itemLink, itemRarity
	
	if craftedItemID then
		frame.CraftedItem:SetIcon(GetItemIcon(craftedItemID))
		frame.CraftedItem.id = craftedItemID
		frame.CraftedItem:Show()
		
		itemName, itemLink, itemRarity = GetItemInfo(craftedItemID)
	else
		frame.CraftedItem:Hide()
	end
	
	-- ** set the recipe link **
	if recipeID then
		local link = addon:GetRecipeLink(recipeID, profession, color)
		local recipeText
		
		if itemName then
			local _, _, _, hexColor = GetItemQualityColor(itemRarity)
			recipeText = format("|c%s%s", hexColor, itemName)
		else
			recipeText = link
		end
	
		frame.RecipeLink.Text:SetText(recipeText)
		frame.RecipeLink.link = link
	else
		-- this should NEVER happen, like NEVER-EVER-ER !!
		frame.RecipeLink.Text:SetText(L["N/A"])
		frame.RecipeLink.link = nil
	end
	
	-- ** set the reagents **
	local reagents = DataStore:GetCraftReagents(recipeID)		-- reagents = "2996,2|2318,1|2320,1"
	local index = 1
	
	if reagents then
		for reagent in reagents:gmatch("([^|]+)") do
			local reagentIcon = frame["Reagent" .. index]
			local reagentID, reagentCount = strsplit(",", reagent)
			reagentID = tonumber(reagentID)
			
			if reagentID then
				reagentCount = tonumber(reagentCount)
				
				reagentIcon.id = reagentID
				reagentIcon:SetIcon(GetItemIcon(reagentID))
				reagentIcon.Count:SetText(reagentCount)
				reagentIcon.Count:Show()
			
				reagentIcon:Show()
				index = index + 1
			else
				reagentIcon:Hide()
			end				
		end
	end
	
	-- hide unused reagent icons
	while index <= 8 do
		frame["Reagent" .. index]:Hide()
		index = index + 1
	end

	frame:Show()
end

local function _RecipeLink_OnEnter(frame)
	local link = frame.RecipeLink.link
	if not link then return end
	
	GameTooltip:ClearLines()
	GameTooltip:SetOwner(frame.RecipeLink, "ANCHOR_RIGHT")
	GameTooltip:SetHyperlink(link)
	GameTooltip:AddLine(" ", 1, 1, 1)
	GameTooltip:Show()
end

local function _RecipeLink_OnClick(frame, button)
	if button ~= "LeftButton" or not IsShiftKeyDown() then return end

	local link = frame.RecipeLink.link
	if not link then return end
	
	local chat = ChatEdit_GetLastActiveWindow()
	if chat:IsShown() then 
		chat:Insert(link)
	end
end

addon:RegisterClassExtensions("AltoRecipeRow", {
	Update = _Update,
	RecipeLink_OnEnter = _RecipeLink_OnEnter,
	RecipeLink_OnClick = _RecipeLink_OnClick,
})
