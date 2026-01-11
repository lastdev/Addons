local _, db = ...
local STAR_TEXTURE = "Interface\\AddOns\\HomeBound\\Assets\\star"
local STAR2_TEXTURE = "Interface\\AddOns\\HomeBound\\Assets\\star2"
local HORDE_ICON_TEXTURE = "Interface\\AddOns\\HomeBound\\Assets\\horde"
local ALLIANCE_ICON_TEXTURE = "Interface\\AddOns\\HomeBound\\Assets\\alliance"
local COLLECTED_ICON_TEXTURE = "Interface\\AddOns\\HomeBound\\Assets\\collected2"

hb_settings = hb_settings or {
	scale = 1.0,
	hideCompleted = false,
	hideNonFavorited = false,
	useTomTom = true,
	closeOnEsc = true,
	toggleKeybind = nil,
	completedAchievs = {},
	completedQuest = {},
	completedDrop = {},
	favorites = {},
	showMinimapButton = true,
	tabFilters = {},
	showVendorCheckmarks = true
}
dbHB = {minimap = {hide = false}}

local vendorSessionCache = {}
local activeWidgets = {}
local collapsedHeaders = {}
local itemNameCache = {} 
local collectionCache = {} 
local widgetPool = { headers = {}, lines = {} } 

local LibDBIcon = LibStub("LibDBIcon-1.0", true)
local minimapButton
local questTitleCache = {}
local currentFaction = 1
local currentTab = "decor"
local hb_options_category = nil
local currentSearchQuery = ""
local currentPopupNpcID = nil
local currentPopupNpcName = nil

local function ApplyBackdrop(f, r, g, b, a)
	f:SetBackdrop({
		bgFile = "Interface\\Buttons\\WHITE8x8",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = false, edgeSize = 16,
		insets = { left = 4, right = 4, top = 4, bottom = 4 }
	})
	f:SetBackdropColor(r or 0.1, g or 0.1, b or 0.1, a or 0.95)
	f:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)
end

local function MakeMovable(f)
	f:SetMovable(true)
	f:EnableMouse(true)
	f:SetScript("OnMouseDown", function(self, button) if button == "LeftButton" then self:StartMoving() end end)
	f:SetScript("OnMouseUp", function(self, button) if button == "LeftButton" then self:StopMovingOrSizing() end end)
end

local refreshTimer = nil
local function RequestUpdate()
	if refreshTimer then refreshTimer:Cancel() end
	refreshTimer = C_Timer.NewTimer(0.2, function()
		refreshTimer = nil
		if HB_MainFrame and HB_MainFrame:IsShown() then
			BuildUI()
		end
	end)
end

local function GetCachedItemName(itemID)
	if itemNameCache[itemID] then return itemNameCache[itemID], false end
	local item = Item:CreateFromItemID(itemID)
	if not item:IsItemEmpty() then
		item:ContinueOnItemLoad(function() 
			itemNameCache[itemID] = item:GetItemName() 
			RequestUpdate() 
		end)
	end
	return "Loading Item...", true
end

local function ItemPassesRequirements(itemID)
	
	local filters = hb_settings.tabFilters["vendors"]
	if not filters then return true end
	
	if filters.achievement and filters.quest and filters.reputation then return true end

	local data = db.decorItem and db.decorItem[itemID]
	if not data then return true end

	if data.reqAchiev and not filters.achievement then return false end
	if data.reqQuest and not filters.quest then return false end
	if data.reqRep and not filters.reputation then return false end

	return true
end

local function AnchorPreviewToTooltip(previewFrame, tooltip)
	previewFrame:ClearAllPoints()
	local tooltipBottomY = tooltip:GetBottom()
	local previewScaledHeight = previewFrame:GetHeight() * previewFrame:GetEffectiveScale()
	if tooltipBottomY and (tooltipBottomY - previewScaledHeight - 30 < 0) then 
		previewFrame:SetPoint("BOTTOMLEFT", tooltip, "TOPLEFT", 0, 5)
	else 
		previewFrame:SetPoint("TOPLEFT", tooltip, "BOTTOMLEFT", 0, -5) 
	end
	previewFrame:Show()
end

local function IsItemCollected(itemID)
	if hb_settings.completedDrop[itemID] then return true end
	if collectionCache[itemID] ~= nil then return collectionCache[itemID] end
	local decorID = db.decorItem[itemID] and db.decorItem[itemID].decorID
	if not decorID then 
		collectionCache[itemID] = false
		return false 
	end
	local info = C_HousingCatalog.GetCatalogEntryInfoByRecordID(1, decorID, true)
	if info and info.firstAcquisitionBonus == 0 then
		hb_settings.completedDrop[itemID] = true
		return true
	end
	collectionCache[itemID] = false
	return false
end

local function GetVendorStatus(npcID)
	if vendorSessionCache[npcID] then
		return vendorSessionCache[npcID].isComplete, vendorSessionCache[npcID].missingCount
	end
	local items = db.vendorItems[npcID]
	local missingCount = 0
	for _, itemID in ipairs(items) do
		if not IsItemCollected(itemID) then missingCount = missingCount + 1 end
	end
	local isComplete = (missingCount == 0)
	vendorSessionCache[npcID] = {isComplete = isComplete, missingCount = missingCount}
	return isComplete, missingCount
end

local function IsAchievementComplete(achievementID)
	if not achievementID then return false end
	if type(achievementID) == "table" then
		for _, id in ipairs(achievementID) do
			if IsAchievementComplete(id) then return true end
		end
		return false
	end
	if hb_settings.completedAchievs[achievementID] then return true end
	local _, _, _, completed = GetAchievementInfo(achievementID)
	if completed then hb_settings.completedAchievs[achievementID] = true end
	return completed or false
end

local function IsQuestComplete(questID)
	if not questID then return false end
	if type(questID) == "table" then
		for _, id in ipairs(questID) do
			if IsQuestComplete(id) then return true end
		end
		return false
	end
	if hb_settings.completedQuest[questID] then return true end
	local completed = C_QuestLog.IsQuestFlaggedCompletedOnAccount(questID)
	if completed then hb_settings.completedQuest[questID] = true end
	return completed
end

local function IsRewardComplete(reward)
	if currentTab == "vendors" then 
		local complete = GetVendorStatus(reward.id)
		return complete
	elseif currentTab == "drops" or currentTab == "professions" then
		return IsItemCollected(reward.id)
	end
	if reward.type == "quest" then return IsQuestComplete(reward.id)
	else return IsAchievementComplete(reward.id) end
end

local function GetRewardID(reward)
	if currentTab == "vendors" or currentTab == "drops" or currentTab == "professions" then
		return reward.id
	else
		if type(reward.id) == "table" then return reward.id[currentFaction] else return reward.id end
	end
end

local function IsFavorited(reward)
	if not hb_settings.favorites[currentTab] then hb_settings.favorites[currentTab] = {} end
	local id = GetRewardID(reward)
	return hb_settings.favorites[currentTab][id]
end

local function ToggleFavorite(reward)
	if not hb_settings.favorites[currentTab] then hb_settings.favorites[currentTab] = {} end
	local id = GetRewardID(reward)
	hb_settings.favorites[currentTab][id] = not hb_settings.favorites[currentTab][id]
	BuildUI()
end

local function GetRewardFaction(reward)
	if not reward.icon then return "neutral"
	elseif reward.icon == ALLIANCE_ICON_TEXTURE then return "alliance"
	elseif reward.icon == HORDE_ICON_TEXTURE then return "horde"
	else return "neutral" end
end

local function GetFullTexturePath(texturePath)
	if texturePath and not string.match(texturePath, "[\\/]") then
		return "Interface\\AddOns\\HomeBound\\Assets\\" .. texturePath
	end
	return texturePath
end

local frame = CreateFrame("Frame", "HB_MainFrame", UIParent, "BackdropTemplate")
frame:SetSize(650, 500)
frame:SetPoint("CENTER")
frame:SetFrameStrata("HIGH")
ApplyBackdrop(frame, 0.02, 0.02, 0.02, 0.95)
frame:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)
MakeMovable(frame)
frame:Hide()

local bindingFrame = CreateFrame("Button", "HB_KeyBindListener", UIParent)
bindingFrame:RegisterForClicks("AnyDown")
bindingFrame:SetScript("OnClick", function()
	if not frame:IsShown() then BuildUI() end
	frame:SetShown(not frame:IsShown())
end)

local wowheadPopup = CreateFrame("Frame", "HB_WowheadLinkFrame", UIParent, "BackdropTemplate")
wowheadPopup:SetSize(350, 90)
wowheadPopup:SetFrameStrata("FULLSCREEN_DIALOG") 
ApplyBackdrop(wowheadPopup, 0.1, 0.1, 0.1, 1)
wowheadPopup:SetBackdropBorderColor(0.64, 0.64, 0.64, 1)
MakeMovable(wowheadPopup)
wowheadPopup:Hide()

local whGradient = wowheadPopup:CreateTexture(nil, "BACKGROUND")
whGradient:SetPoint("TOPLEFT", 4, -4); whGradient:SetPoint("BOTTOMRIGHT", -4, 4)
whGradient:SetColorTexture(1, 1, 1, 1)
whGradient:SetGradient("VERTICAL", CreateColor(0.12, 0.12, 0.12, 1), CreateColor(0.05, 0.05, 0.05, 1))

local wowheadPopupTitle = wowheadPopup:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
wowheadPopupTitle:SetPoint("TOP", 0, -14); wowheadPopupTitle:SetText("Ctrl + C to copy"); wowheadPopupTitle:SetTextColor(1, 0.82, 0)

local wowheadPopupEditBox = CreateFrame("EditBox", nil, wowheadPopup, "InputBoxTemplate")
wowheadPopupEditBox:SetSize(300, 20); wowheadPopupEditBox:SetPoint("CENTER", 0, -5); wowheadPopupEditBox:SetAutoFocus(false)
wowheadPopupEditBox:SetScript("OnEscapePressed", function() wowheadPopup:Hide() end)

local wowheadPopupCloseBtn = CreateFrame("Button", nil, wowheadPopup, "UIPanelCloseButton")
wowheadPopupCloseBtn:SetPoint("TOPRIGHT", 0, 0); wowheadPopupCloseBtn:SetSize(30, 30)
wowheadPopupCloseBtn:SetScript("OnClick", function() wowheadPopup:Hide() end)

local function ShowWowheadLinkPopup(id, rewardType)
	local url = ""
	if rewardType == "quest" then url = "https://www.wowhead.com/quest=" .. tostring(id)
	elseif rewardType == "item" then url = "https://www.wowhead.com/item=" .. tostring(id)
	else url = "https://www.wowhead.com/achievement=" .. tostring(id) end
	wowheadPopupEditBox:SetText(url)
	wowheadPopup:Show()
	wowheadPopupEditBox:SetFocus()
	wowheadPopupEditBox:HighlightText()
end

local vendorPopup = CreateFrame("Frame", "HB_VendorPopup", UIParent, "BackdropTemplate")
vendorPopup:SetSize(350, 100)
vendorPopup:SetPoint("CENTER")
vendorPopup:SetFrameStrata("DIALOG")
vendorPopup:Hide()
ApplyBackdrop(vendorPopup, 0.1, 0.1, 0.1, 1)
vendorPopup:SetBackdropBorderColor(0.64, 0.64, 0.64, 1)
MakeMovable(vendorPopup)

local popupGradient = vendorPopup:CreateTexture(nil, "BACKGROUND")
popupGradient:SetPoint("TOPLEFT", 4, -4); popupGradient:SetPoint("BOTTOMRIGHT", -4, 4)
popupGradient:SetColorTexture(1, 1, 1, 1)
popupGradient:SetGradient("VERTICAL", CreateColor(0.12, 0.12, 0.12, 1), CreateColor(0.05, 0.05, 0.05, 1))

local vendorPopupTitle = vendorPopup:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
vendorPopupTitle:SetPoint("TOP", 0, -12); vendorPopupTitle:SetText("Vendor Items"); vendorPopupTitle:SetTextColor(1, 0.82, 0)

local popupIconCache = {} 

local vendorCheckmarkToggle = CreateFrame("CheckButton", nil, vendorPopup, "UICheckButtonTemplate")
vendorCheckmarkToggle:SetSize(28, 28)
vendorCheckmarkToggle:SetPoint("RIGHT", vendorPopupTitle, "LEFT", -6, 0) 
vendorCheckmarkToggle.text:Hide()
vendorCheckmarkToggle:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOP")
	GameTooltip:SetText("Include Checkmarks")
	GameTooltip:Show()
end)
vendorCheckmarkToggle:SetScript("OnLeave", function() GameTooltip:Hide() end)
vendorCheckmarkToggle:SetScript("OnClick", function(self)
	local isChecked = self:GetChecked()
	hb_settings.showVendorCheckmarks = isChecked
	for _, container in pairs(popupIconCache) do
		if container:IsShown() and container.btn and container.btn.isCollected then
			container.checkFrame:SetShown(isChecked)
		end
	end
end)

local vendorPopupHiddenText = vendorPopup:CreateFontString(nil, "OVERLAY", "GameFontNormal")
vendorPopupHiddenText:SetFont(STANDARD_TEXT_FONT, 12)
vendorPopupHiddenText:SetTextColor(0.9, 0.9, 0.9, 1)
vendorPopupHiddenText:SetPoint("TOP", vendorPopupTitle, "BOTTOM", 0, -2)
vendorPopupHiddenText:Hide()
vendorPopup.hiddenText = vendorPopupHiddenText

local titleSeparator = vendorPopup:CreateTexture(nil, "ARTWORK")
titleSeparator:SetHeight(2); titleSeparator:SetColorTexture(0.4, 0.4, 0.4, 0.8)
titleSeparator:SetPoint("TOPLEFT", 10, -36); titleSeparator:SetPoint("TOPRIGHT", -10, -36)

local recipeTitle = vendorPopup:CreateFontString(nil, "OVERLAY")
recipeTitle:SetFont(STANDARD_TEXT_FONT, 14); recipeTitle:SetText("Recipe:"); recipeTitle:Hide()

local vendorPopupCloseBtn = CreateFrame("Button", nil, vendorPopup, "UIPanelCloseButton")
vendorPopupCloseBtn:SetPoint("TOPRIGHT", 0, 0); vendorPopupCloseBtn:SetSize(30, 30)
vendorPopupCloseBtn:SetScript("OnClick", function() vendorPopup:Hide() end)

local function GetPopupIconFrame(index)
	local container = popupIconCache[index]
	if not container then
		container = CreateFrame("Frame", nil, vendorPopup)
		container:SetSize(50, 50) 
		local borderFrame = CreateFrame("Frame", nil, container, "BackdropTemplate")
		borderFrame:SetSize(50, 50)
		borderFrame:SetPoint("TOP")
		borderFrame:SetBackdrop({ edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 2 })
		borderFrame:SetClipsChildren(true)
		container.borderFrame = borderFrame
		local btn = CreateFrame("Button", nil, borderFrame)
		btn:SetAllPoints(borderFrame)
		btn:RegisterForClicks("AnyUp")
		container.btn = btn
		local glow = btn:CreateTexture(nil, "BACKGROUND")
		glow:SetPoint("TOPLEFT", -2, 2); glow:SetPoint("BOTTOMRIGHT", 2, -2)
		glow:SetColorTexture(0, 0, 0, 0.5)
		container.glow = glow
		local icon = btn:CreateTexture(nil, "ARTWORK")
		icon:SetPoint("TOPLEFT", 2, -2); icon:SetPoint("BOTTOMRIGHT", -2, 2)
		icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
		container.icon = icon
		
		local checkFrame = CreateFrame("Frame", nil, container)
		checkFrame:SetSize(18, 18)
		checkFrame:SetPoint("BOTTOM", 0, -10)
		checkFrame:SetFrameLevel(borderFrame:GetFrameLevel() + 10)
		checkFrame:Hide()
		
		local checkTex = checkFrame:CreateTexture(nil, "ARTWORK")
		checkTex:SetAllPoints()
		checkTex:SetTexture(COLLECTED_ICON_TEXTURE)
		checkFrame.texture = checkTex
		
		container.checkFrame = checkFrame

		local countBar = CreateFrame("Frame", nil, container)
		countBar:SetSize(50, 16)
		countBar:SetPoint("TOP", borderFrame, "BOTTOM", 0, 0)
		container.countBar = countBar
		local countBg = countBar:CreateTexture(nil, "BACKGROUND")
		countBg:SetAllPoints()
		countBg:SetColorTexture(0, 0, 0, 1) 
		local countText = countBar:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
		countText:SetFont(STANDARD_TEXT_FONT, 14, nil) 
		countText:SetTextColor(1, 1, 1, 1)
		countText:SetPoint("CENTER", countBar, "CENTER", 0, 0)
		container.countText = countText
		btn:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
		btn:GetHighlightTexture():SetBlendMode("ADD"); btn:GetHighlightTexture():SetAllPoints(icon)
		table.insert(popupIconCache, container)
	end
	return container
end

local function PopupButton_OnEnter(self)
	local container = self:GetParent():GetParent()
	local borderFrame = container.borderFrame
	local glow = container.glow
	if self.isReagent or self.isRecipe then
		SetCursor("CAST_CURSOR")
		borderFrame:SetBackdropBorderColor(1, 0.82, 0, 1)
		glow:SetColorTexture(1, 0.82, 0, 0.2)
	else
		SetCursor("INSPECT_CURSOR")
		if self.isCollected then
			borderFrame:SetBackdropBorderColor(1, 1, 1, 1)
			glow:SetColorTexture(1, 1, 1, 0.1)
		else
			borderFrame:SetBackdropBorderColor(1, 0.82, 0, 1)
			glow:SetColorTexture(1, 0.82, 0, 0.2)
		end
	end
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetHyperlink("item:" .. self.itemID)
	GameTooltip:Show()
end

local function PopupButton_OnLeave(self)
	local container = self:GetParent():GetParent()
	local borderFrame = container.borderFrame
	local glow = container.glow
	ResetCursor()
	if self.isReagent or self.isRecipe or not self.isCollected then
		borderFrame:SetBackdropBorderColor(0.4, 0.4, 0.4, 1)
	else
		borderFrame:SetBackdropBorderColor(1, 1, 1, 1)
	end
	glow:SetColorTexture(0, 0, 0, 0.5)
	GameTooltip:Hide()
end

local function PopupButton_OnClick(self, button)
	if IsModifiedClick("CHATLINK") then
		local _, link = GetItemInfo(self.itemID)
		if link then ChatEdit_InsertLink(link) end
	elseif (self.isReagent or self.isRecipe) and (button == "LeftButton" or button == "RightButton") then
		ShowWowheadLinkPopup(self.itemID, "item")
	elseif button == "LeftButton" then
		DressUpItemLink("item:" .. self.itemID)
	end
end

local function SetupPopupButton(container, data, typeStr)
	local btn = container.btn
	local borderFrame = container.borderFrame
	local itemID = data.id
	btn.itemID = itemID
	btn.isReagent = (typeStr == "reagent")
	btn.isRecipe = (typeStr == "recipe")
	btn.isCollected = false
	if typeStr == "vendor" then
		btn.isCollected = IsItemCollected(itemID)
		borderFrame:SetBackdropBorderColor(btn.isCollected and 1 or 0.4, btn.isCollected and 1 or 0.4, btn.isCollected and 1 or 0.4, 1)
		
		if btn.isCollected and hb_settings.showVendorCheckmarks then 
			container.checkFrame:Show() 
		else 
			container.checkFrame:Hide() 
		end
		
		container:SetSize(50, 50)
		container.countBar:Hide()
	elseif typeStr == "reagent" then
		borderFrame:SetBackdropBorderColor(0.4, 0.4, 0.4, 1)
		container.checkFrame:Hide()
		container:SetSize(50, 66)
		container.countText:SetText(data.amount or 1)
		container.countBar:Show()
	else
		borderFrame:SetBackdropBorderColor(0.4, 0.4, 0.4, 1)
		container.checkFrame:Hide()
		container:SetSize(50, 50)
		container.countBar:Hide()
	end
	local texture = GetItemIcon(itemID)
	container.icon:SetTexture(texture or (typeStr == "recipe" and "Interface\\Icons\\INV_Scroll_03" or "Interface\\Icons\\INV_Misc_QuestionMark"))
	btn:SetScript("OnEnter", PopupButton_OnEnter)
	btn:SetScript("OnLeave", PopupButton_OnLeave)
	btn:SetScript("OnClick", PopupButton_OnClick)
	container:Show()
end

local function LayoutPopupItems(items, typeStr, startIndex, startX, startY, verticalStep)
	local tileSize, margin, columns = 50, 12, 6
	local i = startIndex
	for _, item in ipairs(items) do
		local container = GetPopupIconFrame(i + 1)
		local col = i % columns
		local row = math.floor(i / columns)
		container:SetPoint("TOPLEFT", vendorPopup, "TOPLEFT", startX + (col * (tileSize + margin)), startY - (row * verticalStep))
		SetupPopupButton(container, typeStr == "vendor" and {id = item} or item, typeStr)
		i = i + 1
	end
	local totalRows = math.floor((i - startIndex - 1) / columns) + 1
	local totalHeight = math.abs(startY) + (totalRows * verticalStep)
	return i, totalHeight
end

local function ShowVendorPopup(npcID, vendorName)
	if not npcID or not db.vendorItems or not db.vendorItems[npcID] then return end
	
	currentPopupNpcID = npcID
	currentPopupNpcName = vendorName or currentPopupNpcName

	local allItems = db.vendorItems[npcID]
	
	local addedItems = {}
	local totalCount = #allItems
	local hiddenCount = 0
	
	for _, itemID in ipairs(allItems) do
		if ItemPassesRequirements(itemID) then
			table.insert(addedItems, itemID)
		else
			hiddenCount = hiddenCount + 1
		end
	end

	vendorPopupTitle:SetText((currentPopupNpcName or "Vendor") .. " sells:")
	
	vendorCheckmarkToggle:Show()
	vendorCheckmarkToggle:SetChecked(hb_settings.showVendorCheckmarks)
	
	recipeTitle:Hide()
	for _, frame in pairs(popupIconCache) do frame:Hide() end
	
	local topOffset = -48
	if hiddenCount > 0 then
		vendorPopup.hiddenText:SetText("(" .. hiddenCount .. " hidden)")
		vendorPopup.hiddenText:Show()
		titleSeparator:SetPoint("TOPLEFT", 10, -50)
		titleSeparator:SetPoint("TOPRIGHT", -10, -50)
		topOffset = -62
	else
		vendorPopup.hiddenText:Hide()
		titleSeparator:SetPoint("TOPLEFT", 10, -36)
		titleSeparator:SetPoint("TOPRIGHT", -10, -36)
	end
	
	local tileSize, margin = 50, 12
	local columns = 6
	local _, height = LayoutPopupItems(addedItems, "vendor", 0, 25, topOffset, tileSize + margin)
	local totalWidth = (25 * 2) + (columns * (tileSize + margin)) - margin
	vendorPopup:SetSize(totalWidth, height + 4)
	vendorPopup:Show()
end

local function ShowReagentsPopup(itemData)
	local reagents = itemData.reagents
	if not reagents then return end
	vendorPopupTitle:SetText("Reagents required:")
	
	vendorCheckmarkToggle:Hide()
	
	vendorPopup.hiddenText:Hide()
	titleSeparator:SetPoint("TOPLEFT", 10, -36)
	titleSeparator:SetPoint("TOPRIGHT", -10, -36)
	
	recipeTitle:Hide()
	for _, frame in pairs(popupIconCache) do frame:Hide() end
	local tileSize, margin, columns = 50, 12, 6
	local verticalStep = tileSize + 16 + margin 
	local index, height = LayoutPopupItems(reagents, "reagent", 0, 25, -48, verticalStep)
	if itemData.recipe then
		recipeTitle:Show()
		recipeTitle:SetPoint("TOPLEFT", vendorPopup, "TOPLEFT", 24, -(height + 4))
		local recipeY = -(height + 24) 
		local container = GetPopupIconFrame(index + 1)
		container:SetPoint("TOPLEFT", vendorPopup, "TOPLEFT", 25, recipeY)
		SetupPopupButton(container, {id = itemData.recipe}, "recipe")
		height = math.abs(recipeY) + tileSize + margin
	end
	local totalWidth = (25 * 2) + (columns * (tileSize + margin)) - margin
	vendorPopup:SetSize(totalWidth, height + 4)
	vendorPopup:Show()
end

local previewFrame = CreateFrame("Frame", "HB_RewardFrame", UIParent, "BackdropTemplate")
previewFrame:SetSize(300, 330); previewFrame:SetFrameStrata("TOOLTIP")
ApplyBackdrop(previewFrame, 0.05, 0.05, 0.05, 0.98)
previewFrame:Hide()

local previewTitle = previewFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
previewTitle:SetFont(STANDARD_TEXT_FONT, 15); previewTitle:SetPoint("TOP", 0, -12); previewTitle:SetText("Decor Reward")
previewTitle:SetWidth(280); previewTitle:SetTextColor(1, 0.82, 0)

previewFrame.currentReward = nil
previewFrame.currentRewardIndex = 1
previewFrame.totalRewards = 0

local previewTexture = previewFrame:CreateTexture(nil, "ARTWORK")
previewTexture:SetSize(288, 288); previewTexture:SetPoint("BOTTOM", 0, 6)
previewTexture:SetTexCoord(0.08, 0.92, 0.08, 0.92); previewFrame.texture = previewTexture

local previewModel = CreateFrame("PlayerModel", nil, previewFrame)
previewModel:SetSize(288, 288); previewModel:SetPoint("BOTTOM", 0, 6)
previewModel:SetScript("OnModelLoaded", function(self)
	self:MakeCurrentCameraCustom()
	local modelID = self:GetModelFileID()
	local posData = db.modelPositions[modelID]
	if posData then
		self:SetPosition(posData.model_x, 0, posData.model_z); self:SetCameraPosition(0, 0, posData.camera_y); self:SetCameraDistance(posData.zoom)
	else
		self:SetPosition(0, 0, 0); self:SetCameraPosition(0, 0, 4); self:SetCameraDistance(10)
	end
end)
previewFrame.model = previewModel; previewModel:Hide()

local smallPreviewFrame = CreateFrame("Frame", "HB_SmallPreviewFrame", UIParent, "BackdropTemplate")
smallPreviewFrame:SetSize(300, 300); smallPreviewFrame:SetFrameStrata("TOOLTIP")
ApplyBackdrop(smallPreviewFrame, 0.05, 0.05, 0.05, 0.98)
smallPreviewFrame:Hide()
local smallPreviewTexture = smallPreviewFrame:CreateTexture(nil, "ARTWORK")
smallPreviewTexture:SetPoint("TOPLEFT", 4, -4); smallPreviewTexture:SetPoint("BOTTOMRIGHT", -4, 4)
smallPreviewTexture:SetTexCoord(0.08, 0.92, 0.08, 0.92)

local rotation = 0
local rotationSpeed = 0.5
previewFrame:SetScript("OnUpdate", function(self, elapsed)
	if self:IsShown() and self.model:IsShown() then
		rotation = rotation + (rotationSpeed * elapsed)
		if rotation >= (math.pi * 2) then rotation = rotation - (math.pi * 2) end
		self.model:SetFacing(rotation)
	end
end)

local supportFrame = CreateFrame("Frame", "HB_SupportFrame", UIParent, "BackdropTemplate")
supportFrame:SetSize(450, 224); supportFrame:SetPoint("CENTER")
ApplyBackdrop(supportFrame, 0.02, 0.02, 0.02, 0.95)
supportFrame:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)
supportFrame:SetFrameStrata("DIALOG"); MakeMovable(supportFrame); supportFrame:Hide()

local supportTitleBg = supportFrame:CreateTexture(nil, "BACKGROUND")
supportTitleBg:SetTexture("Interface\\Buttons\\WHITE8x8")
supportTitleBg:SetPoint("TOPLEFT", 4, -4); supportTitleBg:SetPoint("TOPRIGHT", -4, -4); supportTitleBg:SetHeight(40)
supportTitleBg:SetGradient("VERTICAL", CreateColor(0.15, 0.15, 0.15, 1), CreateColor(0.08, 0.08, 0.08, 1))
local supportTitle = supportFrame:CreateFontString(nil, "OVERLAY")
supportTitle:SetFont(STANDARD_TEXT_FONT, 16, "OUTLINE"); supportTitle:SetPoint("TOP", 0, -16); supportTitle:SetText("Community & Support"); supportTitle:SetTextColor(1, 0.85, 0, 1)
local supportCloseBtn = CreateFrame("Button", nil, supportFrame, "UIPanelCloseButton")
supportCloseBtn:SetPoint("TOPRIGHT", -2, -2); supportCloseBtn:SetSize(28, 28)

local function CreateSupportEditBox(text, url, yOffset)
	local txt = supportFrame:CreateFontString(nil, "OVERLAY")
	txt:SetFont(STANDARD_TEXT_FONT, 13); txt:SetPoint("TOPLEFT", 20, yOffset); txt:SetText(text); txt:SetTextColor(0.9, 0.9, 0.9, 1)
	local box = CreateFrame("EditBox", nil, supportFrame, "InputBoxTemplate")
	box:SetSize(408, 20); box:SetPoint("TOPLEFT", 22, yOffset - 20); box:SetAutoFocus(false); box:SetText(url)
	box:SetScript("OnEscapePressed", function(self) self:ClearFocus() end); box:SetScript("OnEnterPressed", function(self) self:ClearFocus() end)
end

CreateSupportEditBox("Join the community on Discord!", "https://dsc.gg/homebound", -54)
CreateSupportEditBox("Share this addon with your friends!", "https://www.curseforge.com/wow/addons/home-bound", -110)
CreateSupportEditBox("You can leave a tip if you like", "https://buymeacoffee.com/bettiold", -166)

frame:SetScript("OnHide", function()
	if wowheadPopup and wowheadPopup:IsShown() then wowheadPopup:Hide() end
	if supportFrame and supportFrame:IsShown() then supportFrame:Hide() end
	if vendorPopup and vendorPopup:IsShown() then vendorPopup:Hide() end
end)

local titleBg = frame:CreateTexture(nil, "BACKGROUND")
titleBg:SetTexture("Interface\\Buttons\\WHITE8x8")
titleBg:SetPoint("TOPLEFT", 4, -4); titleBg:SetPoint("TOPRIGHT", -4, -4); titleBg:SetHeight(50)
titleBg:SetGradient("VERTICAL", CreateColor(0.15, 0.15, 0.15, 1), CreateColor(0.08, 0.08, 0.08, 1))

local title = frame:CreateFontString(nil, "OVERLAY")
title:SetFont(STANDARD_TEXT_FONT, 16, "OUTLINE"); title:SetPoint("TOP", 0, -14); title:SetText("Home Bound"); title:SetTextColor(1, 0.85, 0, 1)

local subtitle = frame:CreateFontString(nil, "OVERLAY")
subtitle:SetFont(STANDARD_TEXT_FONT, 11); subtitle:SetPoint("TOP", title, "BOTTOM", 0, -2); subtitle:SetText("Track your Player Housing rewards"); subtitle:SetTextColor(0.7, 0.7, 0.7, 1)

local infoIcon = CreateFrame("Button", nil, frame)
infoIcon:SetSize(24, 24); infoIcon:SetPoint("TOPLEFT", 8, -8)
local iconTexture = infoIcon:CreateTexture(nil, "ARTWORK")
iconTexture:SetTexture("Interface\\BUTTONS\\UI-GuildButton-PublicNote-Up"); iconTexture:SetAllPoints(infoIcon)
infoIcon:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", "ADD")
infoIcon:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
	GameTooltip:AddLine("Home Bound Tips", 1, 0.82, 0)
	GameTooltip:AddLine("\nYou can right-click to get a Wowhead link.", 1, 1, 1, true)
	GameTooltip:AddLine("Left-click an achievement to open it in the achievement panel.", 1, 1, 1, true)
	GameTooltip:AddLine("\nFor accurate achievement completion data, log in to at least one Alliance and one Horde character.", 1, 1, 1, true)
	GameTooltip:Show()
end)
infoIcon:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

local supportIcon = CreateFrame("Button", nil, frame)
supportIcon:SetSize(24, 24); supportIcon:SetPoint("LEFT", infoIcon, "RIGHT", 6, 0)
local supportIconTexture = supportIcon:CreateTexture(nil, "ARTWORK")
supportIconTexture:SetTexture("Interface\\AddOns\\HomeBound\\Assets\\discord"); supportIconTexture:SetAllPoints(supportIcon)
supportIcon:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", "ADD")
supportIcon:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
	GameTooltip:AddLine("Community & Support", 1, 0.82, 0)
	GameTooltip:AddLine("\nClick to share the addon!", 1, 1, 1, true)
	GameTooltip:Show()
end)
supportIcon:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
supportIcon:SetScript("OnClick", function() supportFrame:Show() end)

local closeBtn = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
closeBtn:SetPoint("TOPRIGHT", -2, -2); closeBtn:SetSize(28, 28)

local tabs = {}
local currentTabX = 0

local function UpdateTabStyles()
	for _, t in pairs(tabs) do
		if t.id == string.lower(currentTab) or (t.text and string.lower(t.text) == currentTab) then
			t:SetBackdropColor(0.02, 0.02, 0.02, 1); t:SetBackdropBorderColor(1, 0.82, 0, 1); t:SetFrameLevel(frame:GetFrameLevel() + 2)
		else
			t:SetBackdropColor(0.1, 0.1, 0.1, 1); t:SetBackdropBorderColor(0.3, 0.3, 0.3, 1); t:SetFrameLevel(frame:GetFrameLevel() + 1)
		end
	end
end

local function CreateBottomTab(id, text, iconPath)
	local tab = CreateFrame("Button", "HB_Tab_"..id, frame, "BackdropTemplate")
	tab:SetHeight(32)
	tab:SetBackdrop({
		bgFile = "Interface\\Buttons\\WHITE8x8", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		edgeSize = 15, insets = { left = 2, right = 2, top = 2, bottom = 2 }
	})
	local tabIcon = tab:CreateTexture(nil, "ARTWORK"); tabIcon:SetSize(20, 20); tabIcon:SetPoint("LEFT", 10, 0); tabIcon:SetTexture(iconPath)
	local tabText = tab:CreateFontString(nil, "OVERLAY", "GameFontNormal"); tabText:SetPoint("LEFT", tabIcon, "RIGHT", 6, 0); tabText:SetText(text)
	local textWidth = tabText:GetStringWidth()
	local myWidth = 10 + 20 + 6 + textWidth + 10
	tab:SetWidth(myWidth)
	tab.xPos = currentTabX
	tab:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", tab.xPos, 1)
	currentTabX = currentTabX + myWidth - 1
	tab.id = string.lower(id); tab.text = text
	table.insert(tabs, tab)
	tab:SetScript("OnMouseDown", function(self)
		if currentTab ~= self.id then self:ClearAllPoints(); self:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", self.xPos, -1) end
	end)
	tab:SetScript("OnMouseUp", function(self)
		if currentTab ~= self.id then self:ClearAllPoints(); self:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", self.xPos, 1) end
	end)
	tab:SetScript("OnClick", function() currentTab = string.lower(id); UpdateTabStyles(); BuildUI() end)
	return tab
end

local tabDecor = CreateBottomTab("Decor", "Unlockables", "Interface\\Icons\\INV_Crate_03")
local tabVendors = CreateBottomTab("Vendors", "Vendors", "Interface\\Icons\\INV_Misc_Bag_10")
local tabDrops = CreateBottomTab("Drops", "Drops", "Interface\\Icons\\Achievement_Boss_Onyxia") 
local tabProfessions = CreateBottomTab("Professions", "Professions", "Interface\\Icons\\Trade_Alchemy")
UpdateTabStyles()

local function RefreshVendorPopup()
	if vendorPopup:IsShown() and currentPopupNpcID then
		ShowVendorPopup(currentPopupNpcID, currentPopupNpcName)
	end
end

local filterButton = CreateFrame("DropdownButton", "HB_FilterButton", frame, "WowStyle1FilterDropdownTemplate")
filterButton:SetSize(120, 24); filterButton:SetPoint("TOPLEFT", 10, -60); filterButton:SetText("Filters")
filterButton.Text:ClearAllPoints(); filterButton.Text:SetPoint("CENTER")
filterButton:SetupMenu(function(dropdown, rootDescription)
	local activeFilters = hb_settings.tabFilters[currentTab] or {}
	rootDescription:CreateCheckbox("Hide Completed", function() return hb_settings.hideCompleted end, function() hb_settings.hideCompleted = not hb_settings.hideCompleted; BuildUI() end)
	rootDescription:CreateCheckbox("Hide Non-Favorited", function() return hb_settings.hideNonFavorited end, function() hb_settings.hideNonFavorited = not hb_settings.hideNonFavorited; BuildUI() end)
	rootDescription:CreateDivider()
	if currentTab == "decor" then
		rootDescription:CreateCheckbox("Achievements", function() return activeFilters.achievement end, function() activeFilters.achievement = not activeFilters.achievement; BuildUI() end)
		rootDescription:CreateCheckbox("Quests", function() return activeFilters.quest end, function() activeFilters.quest = not activeFilters.quest; BuildUI() end)
		rootDescription:CreateDivider()
	end
	local factionMenu = rootDescription:CreateButton("Faction")
	factionMenu:CreateCheckbox("Neutral", function() return activeFilters.neutral end, function() activeFilters.neutral = not activeFilters.neutral; BuildUI() end)
	factionMenu:CreateCheckbox("Alliance", function() return activeFilters.alliance end, function() activeFilters.alliance = not activeFilters.alliance; BuildUI() end)
	factionMenu:CreateCheckbox("Horde", function() return activeFilters.horde end, function() activeFilters.horde = not activeFilters.horde; BuildUI() end)
	
	if currentTab == "vendors" then
		local reqMenu = rootDescription:CreateButton("Requires")
		reqMenu:CreateCheckbox("Achievement", function() return activeFilters.achievement end, function() activeFilters.achievement = not activeFilters.achievement; BuildUI(); RefreshVendorPopup() end)
		reqMenu:CreateCheckbox("Quest", function() return activeFilters.quest end, function() activeFilters.quest = not activeFilters.quest; BuildUI(); RefreshVendorPopup() end)
		reqMenu:CreateCheckbox("Reputation", function() return activeFilters.reputation end, function() activeFilters.reputation = not activeFilters.reputation; BuildUI(); RefreshVendorPopup() end)
	end

	rootDescription:CreateDivider()
	rootDescription:CreateButton("Reset Filters", function() 
		activeFilters.neutral = true; activeFilters.alliance = true; activeFilters.horde = true; 
		if currentTab == "decor" then activeFilters.achievement = true; activeFilters.quest = true; end
		if currentTab == "vendors" then activeFilters.achievement = true; activeFilters.quest = true; activeFilters.reputation = true; end
		BuildUI() 
		RefreshVendorPopup()
	end)
end)

local searchBox = CreateFrame("EditBox", "HB_SearchBox", frame, "SearchBoxTemplate")
searchBox:SetSize(172, 24)
searchBox.Instructions:SetTextColor(0.8, 0.8, 0.8)
searchBox:SetPoint("TOPRIGHT", -34, -48)
searchBox:SetScale(1.2)
searchBox:SetAutoFocus(false)

local searchDebounce = nil
searchBox:SetScript("OnTextChanged", function(self)
	SearchBoxTemplate_OnTextChanged(self)
	if searchDebounce then searchDebounce:Cancel() end
	searchDebounce = C_Timer.NewTimer(0.25, function()
		currentSearchQuery = string.lower(self:GetText())
		BuildUI()
	end)
end)

local optionsBtn = CreateFrame("Button", nil, frame)
optionsBtn:SetSize(22, 24)
optionsBtn:SetPoint("TOPRIGHT", -10, -61)
optionsBtn:SetNormalTexture(5684767)
optionsBtn:GetNormalTexture():SetTexCoord(0.8057, 0.8350, 0.1201, 0.1514)
optionsBtn:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
optionsBtn:SetScript("OnClick", function() 
	if hb_options_category then Settings.OpenToCategory(hb_options_category:GetID()) end 
end)
optionsBtn:SetScript("OnEnter", function(self) 
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT"); GameTooltip:SetText("Options"); GameTooltip:Show() 
end)
optionsBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)

local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "ScrollFrameTemplate")
scrollFrame:SetPoint("TOPLEFT", 12, -90); scrollFrame:SetPoint("BOTTOMRIGHT", -32, 12)
local scrollChild = CreateFrame("Frame", nil, scrollFrame)
scrollChild:SetSize(620, 1); scrollFrame:SetScrollChild(scrollChild)
scrollFrame.ScrollBar:ClearAllPoints(); scrollFrame.ScrollBar:SetPoint("TOPRIGHT", scrollFrame, "TOPRIGHT", 15, -8); scrollFrame.ScrollBar:SetHeight(385)

local function AcquireHeader(parent)
	local f = table.remove(widgetPool.headers)
	if not f then
		f = CreateFrame("Button", nil, parent)
		f:SetSize(600, 32)
		local bg = f:CreateTexture(nil, "BACKGROUND"); bg:SetAllPoints(); bg:SetTexture("Interface\\Buttons\\WHITE8x8")
		f.bg = bg
		f.icon = f:CreateFontString(nil, "OVERLAY"); f.icon:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE"); f.icon:SetPoint("LEFT", 8, 0)
		f.text = f:CreateFontString(nil, "OVERLAY"); f.text:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE"); f.text:SetPoint("LEFT", 28, 0)
		f.progress = f:CreateFontString(nil, "OVERLAY"); f.progress:SetFont(STANDARD_TEXT_FONT, 11); f.progress:SetPoint("RIGHT", -8, 0)
		f.isHeader = true
	end
	f:SetParent(parent); f:Show()
	return f
end

local function AcquireLine(parent)
	local f = table.remove(widgetPool.lines)
	if not f then
		f = CreateFrame("Button", nil, parent)
		f:SetSize(590, 22)
		f:RegisterForClicks("AnyUp")
		f.collectedDot = f:CreateTexture(nil, "OVERLAY"); f.collectedDot:SetSize(32, 32); f.collectedDot:SetScale(0.3); f.collectedDot:SetPoint("LEFT", 0, 0)
		f.text = f:CreateFontString(nil, "OVERLAY"); f.text:SetFont(STANDARD_TEXT_FONT, 12); f.text:SetPoint("LEFT", 20, 0); f.text:SetJustifyH("LEFT")
		f.rightText = f:CreateFontString(nil, "OVERLAY"); f.rightText:SetFont(STANDARD_TEXT_FONT, 11); 
		f.rightText:SetPoint("RIGHT", -10, 0)
		f.specialIcon = f:CreateTexture(nil, "OVERLAY"); f.specialIcon:SetSize(22, 22); f.specialIcon:SetPoint("LEFT", f.text, "RIGHT", 16, 0)
		local starBtn = CreateFrame("Button", nil, f)
		starBtn:SetSize(22, 22)
		starBtn:SetPoint("RIGHT", -8, 0)
		starBtn:SetPropagateMouseMotion(true)
		local starTex = starBtn:CreateTexture(nil, "ARTWORK")
		starTex:SetAllPoints()
		starBtn.icon = starTex
		f.starButton = starBtn
		f:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
		f.isLine = true
	end
	f:UnlockHighlight()
	f.starButton:Hide()
	f.rightText:SetPoint("RIGHT", -10, 0)
	if f.specialIcon then f.specialIcon:Hide() end
	if f.nextButton then f.nextButton:Hide() end
	f.text:SetTextColor(0.9, 0.9, 0.9, 1)
	f:SetScript("OnEnter", nil); f:SetScript("OnLeave", nil); f:SetScript("OnClick", nil)
	f:SetParent(parent); f:Show()
	return f
end

local function ClearWidgets()
	for _, widget in ipairs(activeWidgets) do 
		widget:Hide(); widget:ClearAllPoints()
		if widget.isHeader then table.insert(widgetPool.headers, widget)
		elseif widget.isLine then table.insert(widgetPool.lines, widget) end
	end
	wipe(activeWidgets)
	local regions = {scrollChild:GetRegions()}
	for _, region in ipairs(regions) do if region:IsObjectType("FontString") then region:Hide() end end
end

local function CreateHeader(parent, group, total, completed, y)
	if collapsedHeaders[group.name] == nil then collapsedHeaders[group.name] = true end
	local collapsed = collapsedHeaders[group.name]
	local percent = total > 0 and math.floor((completed / total) * 100) or 0
	local header = AcquireHeader(parent)
	header:SetPoint("TOPLEFT", 0, y)
	header.bg:SetGradient("HORIZONTAL", CreateColor(0.12, 0.12, 0.12, 0.8), CreateColor(0.08, 0.08, 0.08, 0.8))
	header.icon:SetText(collapsed and "+" or "−"); header.icon:SetTextColor(0.8, 0.8, 0.8, 1)
	header.text:SetText(group.name); header.text:SetTextColor(1, 1, 1, 1)
	local color = (percent == 100) and CreateColor(0.2, 1, 0.2, 1) or ((percent >= 50) and CreateColor(1, 0.82, 0, 1) or CreateColor(0.9, 0.9, 0.9, 1))
	header.progress:SetText(string.format("%d/%d (%d%%)", completed, total, percent)); header.progress:SetTextColor(color:GetRGBA())
	header:SetScript("OnClick", function() collapsedHeaders[group.name] = not collapsed; BuildUI() end)
	header:SetScript("OnEnter", function(self) self.bg:SetGradient("HORIZONTAL", CreateColor(0.18, 0.18, 0.18, 1), CreateColor(0.12, 0.12, 0.12, 1)) end)
	header:SetScript("OnLeave", function(self) self.bg:SetGradient("HORIZONTAL", CreateColor(0.12, 0.12, 0.12, 0.8), CreateColor(0.08, 0.08, 0.08, 0.8)) end)
	table.insert(activeWidgets, header)
	return header, collapsed, y - 36
end

local function UpdatePreviewDisplay()
	if not previewFrame.currentReward or not previewFrame:IsShown() then return end
	local reward = previewFrame.currentReward
	local index = previewFrame.currentRewardIndex
	local titleText = (type(reward.title) == "table") and reward.title[index] or reward.title or "Decor Reward"
	previewTitle:SetText(titleText)
	local hasPreview = false
	if reward.model3D then
		local modelId = (type(reward.model3D) == "table") and reward.model3D[index] or reward.model3D
		if modelId then
			previewFrame.model:Show(); previewFrame.texture:Hide(); previewFrame.model:SetModel(modelId); rotation = 0; hasPreview = true
		end
	elseif reward.texture then
		local textureId = (type(reward.texture) == "table") and reward.texture[index] or reward.texture
		if textureId and textureId ~= "" then
			previewFrame.model:Hide(); previewFrame.texture:Show()
			local fullTexturePath = GetFullTexturePath(tostring(textureId))
			if fullTexturePath then previewFrame.texture:SetTexture(fullTexturePath); hasPreview = true end
		end
	end
	if not hasPreview then previewFrame:Hide() end
end

local function CycleReward(direction)
	if not previewFrame:IsShown() or previewFrame.totalRewards <= 1 then return end
	local newIndex = previewFrame.currentRewardIndex + direction
	if newIndex > previewFrame.totalRewards then newIndex = 1 end
	if newIndex < 1 then newIndex = previewFrame.totalRewards end
	previewFrame.currentRewardIndex = newIndex
	UpdatePreviewDisplay()
end

local function ConfigureLineBase(line, text, rightText, isComplete, icon, isFavorited, rewardData)
	line.text:SetText(text)
	if isComplete then 
		line.text:SetTextColor(0.64, 0.64, 0.64, 1); 
		line.collectedDot:SetTexture("Interface\\AddOns\\HomeBound\\Assets\\collected")
	else 
		line.text:SetTextColor(0.9, 0.9, 0.9, 1); 
		line.collectedDot:SetTexture("Interface\\AddOns\\HomeBound\\Assets\\progress") 
	end
	if icon then
		line.specialIcon:Show(); line.specialIcon:SetTexture(icon)
	end
	line.rightText:SetText(rightText or ""); line.rightText:SetTextColor(0.7, 0.7, 0.7)
	local star = line.starButton
	if isFavorited then
		 star:Show()
		 star.icon:SetTexture(STAR2_TEXTURE)
		 line.rightText:SetPoint("RIGHT", -32, 0) 
	else
		 star:Hide()
		 star.icon:SetTexture(STAR_TEXTURE)
		 line.rightText:SetPoint("RIGHT", -10, 0)
	end
	star:SetScript("OnClick", function() ToggleFavorite(rewardData) end)
	star:SetScript("OnEnter", function(self) 
		if isFavorited then
			self.icon:SetTexture(STAR_TEXTURE)
		else
			self.icon:SetTexture(STAR2_TEXTURE)
		end
		ResetCursor() 
		line:LockHighlight()
	end)
	star:SetScript("OnLeave", function(self)
		if self:GetParent():IsMouseOver() then
			 if isFavorited then
				self.icon:SetTexture(STAR2_TEXTURE)
			 else
				self.icon:SetTexture(STAR_TEXTURE)
			 end
			 return
		end
		line:UnlockHighlight()
		GameTooltip:Hide()
		ResetCursor()
		if not isFavorited then
			 self:Hide()
			 line.rightText:SetPoint("RIGHT", -10, 0)
		else
			 self.icon:SetTexture(STAR2_TEXTURE)
		end
	end)
end

local function CleanupLineState(line, isFavorited)
	line:UnlockHighlight()
	ResetCursor()
	GameTooltip:Hide()
	smallPreviewFrame:Hide()
	if previewFrame then
		previewFrame:Hide(); previewFrame.model:Hide(); previewFrame.texture:Hide(); previewFrame.currentReward = nil; 
		if line.nextButton then line.nextButton:Hide() end
	end
	if not isFavorited then
		 line.starButton:Hide()
		 line.rightText:SetPoint("RIGHT", -10, 0)
	end
end

local function StandardizeLineScripts(line, onEnter, onClick, onLeave, isFavorited)
	line:SetScript("OnEnter", function(self)
		self:LockHighlight() 
		self.starButton:Show()
		self.rightText:SetPoint("RIGHT", -32, 0)
		if self.starButton:IsMouseOver() then
			if isFavorited then
				self.starButton.icon:SetTexture(STAR_TEXTURE)
			else
				self.starButton.icon:SetTexture(STAR2_TEXTURE)
			end
		elseif not isFavorited then
			self.starButton.icon:SetTexture(STAR_TEXTURE)
		else
			self.starButton.icon:SetTexture(STAR2_TEXTURE)
		end
		if onEnter then onEnter(self) end
	end)
	line:SetScript("OnClick", onClick)
	line:SetScript("OnLeave", function(self)
		if self.starButton:IsMouseOver() then return end
		CleanupLineState(self, isFavorited)
		if onLeave then onLeave(self) end
	end)
end

local function CreateVendorLine(parent, vendor, y)
	local isComplete, missingCount = GetVendorStatus(vendor.id)
	local line = AcquireLine(parent); line:SetPoint("TOPLEFT", 10, y)
	local nameText = vendor.title or "Unknown NPC"
	if not isComplete and missingCount > 0 then nameText = nameText .. " (" .. missingCount .. " missing)" end
	local mapName = "Unknown Zone"
	if vendor.mapID then
		local mapInfo = C_Map.GetMapInfo(vendor.mapID); if mapInfo and mapInfo.name then mapName = mapInfo.name end
	end
	local isFav = IsFavorited(vendor)
	ConfigureLineBase(line, nameText, mapName, isComplete, vendor.icon, isFav, vendor)
	StandardizeLineScripts(line, function(self)
		if not self.starButton:IsMouseOver() then SetCursor("BUY_CURSOR") end
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:AddLine(vendor.title, 1, 1, 1)
		if vendor.mapID then GameTooltip:AddLine(mapName, 1, 0.82, 0) end
		GameTooltip:AddLine("\n|cff00ff00<Left Click>|r to open Vendor Items", 1, 1, 1)
		GameTooltip:AddLine("|cff00ff00<Right Click>|r to add Map Pin", 1, 1, 1)
		GameTooltip:Show()
	end, function(self, button)
		if button == "LeftButton" then ShowVendorPopup(vendor.id, vendor.title)
		elseif button == "RightButton" then
			if InCombatLockdown() then return end
			local targetMapID = vendor.mapIDWaypoint or vendor.mapID
			if targetMapID and vendor.x and vendor.y then
				if TomTom and hb_settings.useTomTom then TomTom:AddWaypoint(targetMapID, vendor.x / 100, vendor.y / 100, { title = vendor.title })
				else
					local waypoint = UiMapPoint.CreateFromCoordinates(targetMapID, vendor.x / 100, vendor.y / 100)
					C_Map.SetUserWaypoint(waypoint); C_SuperTrack.SetSuperTrackedUserWaypoint(true)
				end
				C_Map.OpenWorldMap(vendor.mapID)
			end
		end
	end, nil, isFav)
	table.insert(activeWidgets, line)
	return y - 24
end

local function CreateDropLine(parent, dropItem, y)
	local isComplete = IsItemCollected(dropItem.id)
	local itemName, isLoading = GetCachedItemName(dropItem.id)
	local line = AcquireLine(parent); line:SetPoint("TOPLEFT", 10, y)
	local leftText = itemName
	if not isLoading and dropItem.sources and #dropItem.sources >= 2 then leftText = leftText .. " (" .. #dropItem.sources .. " sources)" end
	local rightTextString = "Unknown Source"
	local mapName = "Unknown Zone"
	if dropItem.sources and #dropItem.sources > 0 then
		local firstSource = dropItem.sources[1]
		local mapInfo = C_Map.GetMapInfo(firstSource.mapID)
		if mapInfo and mapInfo.name then mapName = mapInfo.name end
		rightTextString = (#dropItem.sources == 1) and (firstSource.title .. " in " .. mapName) or ("Multiple drops in " .. mapName)
	end
	local isFav = IsFavorited(dropItem)
	ConfigureLineBase(line, leftText, rightTextString, isComplete, nil, isFav, dropItem)
	StandardizeLineScripts(line, function(self)
		if not self.starButton:IsMouseOver() then SetCursor("INSPECT_CURSOR") end
		local item = Item:CreateFromItemID(dropItem.id)
		item:ContinueOnItemLoad(function()
			if not self:IsMouseOver() and not self.starButton:IsMouseOver() then return end
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT"); GameTooltip:SetItemByID(dropItem.id); GameTooltip:AddLine("\nDrops from:", 1, 0.82, 0)
			if dropItem.sources then for _, src in ipairs(dropItem.sources) do GameTooltip:AddLine(src.title, 1, 1, 1) end end
			GameTooltip:AddLine("\n|cff00ff00<Left Click>|r to open Decor", 1, 1, 1)
			GameTooltip:AddLine("|cff00ff00<Right Click>|r to add Map Pin", 1, 1, 1)
			GameTooltip:Show()
			local decorData = db.decorItem[dropItem.id]
			if decorData and not decorData.thumbnailID then
				local info = C_HousingCatalog.GetCatalogEntryInfoByRecordID(1, decorData.decorID, true)
				decorData.thumbnailID = info and info.iconTexture
			end
			if decorData and decorData.thumbnailID then
				smallPreviewTexture:SetTexture(decorData.thumbnailID)
				AnchorPreviewToTooltip(smallPreviewFrame, GameTooltip)
			end
		end)
	end, function(self, button)
		if IsModifiedClick("CHATLINK") then
			local _, link = GetItemInfo(dropItem.id)
			if link then ChatEdit_InsertLink(link) end
		elseif button == "LeftButton" then DressUpItemLink("item:" .. dropItem.id)
		elseif button == "RightButton" then
			if InCombatLockdown() then return end
			if dropItem.sources and #dropItem.sources > 0 then
				local firstSource = dropItem.sources[1]
				if TomTom and hb_settings.useTomTom then
					for _, src in ipairs(dropItem.sources) do if src.mapID and src.x and src.y then TomTom:AddWaypoint(src.mapID, src.x / 100, src.y / 100, { title = src.title }) end end
				elseif firstSource.mapID and firstSource.x and firstSource.y then
					local waypoint = UiMapPoint.CreateFromCoordinates(firstSource.mapID, firstSource.x / 100, firstSource.y / 100)
					C_Map.SetUserWaypoint(waypoint); C_SuperTrack.SetSuperTrackedUserWaypoint(true)
				end
				C_Map.OpenWorldMap(firstSource.mapID)
			end
		end
	end, nil, isFav)
	table.insert(activeWidgets, line)
	return y - 24
end

local function CreateProfessionLine(parent, profItem, y)
	local isComplete = IsItemCollected(profItem.id)
	local itemName = GetCachedItemName(profItem.id)
	local line = AcquireLine(parent); line:SetPoint("TOPLEFT", 10, y)
	local skillString = (profItem.skill or "Skill") .. " (" .. (profItem.skillNeeded or 0) .. ")"
	local isFav = IsFavorited(profItem)
	ConfigureLineBase(line, itemName, skillString, isComplete, nil, isFav, profItem)
	StandardizeLineScripts(line, function(self)
		if not self.starButton:IsMouseOver() then SetCursor("INSPECT_CURSOR") end
		local item = Item:CreateFromItemID(profItem.id)
		item:ContinueOnItemLoad(function()
			if not self:IsMouseOver() and not self.starButton:IsMouseOver() then return end
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT"); GameTooltip:SetItemByID(profItem.id); 
			GameTooltip:AddLine("\n|cff00ff00<Left Click>|r to open Decor", 1, 1, 1)
			GameTooltip:AddLine("|cff00ff00<Right Click>|r to open Reagents", 1, 1, 1)
			GameTooltip:Show()
			local decorData = db.decorItem[profItem.id]
			if decorData and not decorData.thumbnailID then
				local info = C_HousingCatalog.GetCatalogEntryInfoByRecordID(1, decorData.decorID, true)
				decorData.thumbnailID = info and info.iconTexture
			end
			if decorData and decorData.thumbnailID then
				smallPreviewTexture:SetTexture(decorData.thumbnailID)
				AnchorPreviewToTooltip(smallPreviewFrame, GameTooltip)
			end
		end)
	end, function(self, button)
		if IsModifiedClick("CHATLINK") then
			local _, link = GetItemInfo(profItem.id)
			if link then ChatEdit_InsertLink(link) end
		elseif button == "LeftButton" then DressUpItemLink("item:" .. profItem.id)
		elseif button == "RightButton" then ShowReagentsPopup(profItem) end
	end, nil, isFav)
	table.insert(activeWidgets, line)
	return y - 24
end

local function CreateRewardLine(parent, reward, y)
	local primaryID = reward.id
	if type(reward.id) == "table" then primaryID = reward.id[currentFaction] end
	local displayName, isQuestLoading = nil, false
	if reward.type == "quest" then
		displayName = questTitleCache[primaryID] or C_QuestLog.GetTitleForQuestID(primaryID)
		if displayName then questTitleCache[primaryID] = displayName else displayName = "Loading Quest..."; isQuestLoading = true end
	else
		local _, name = GetAchievementInfo(primaryID)
		displayName = name or "Unknown Achievement"
	end
	local isComplete = IsRewardComplete(reward)
	local line = AcquireLine(parent); line:SetPoint("TOPLEFT", 10, y)
	local rewardTypeString = reward.type and (reward.type:sub(1,1):upper() .. reward.type:sub(2)) or "Achievement"
	local isFav = IsFavorited(reward)
	ConfigureLineBase(line, displayName, rewardTypeString, isComplete, reward.icon, isFav, reward)
	if isQuestLoading then
		QuestEventListener:AddCallback(primaryID, function()
			local newName = C_QuestLog.GetTitleForQuestID(primaryID)
			if newName and line.text:IsVisible() then line.text:SetText(newName); questTitleCache[primaryID] = newName
			elseif line.text:IsVisible() then line.text:SetText("Unknown Quest") end
		end)
	end
	if not line.nextButton then
		local nextButton = CreateFrame("Button", nil, line)
		nextButton:SetPoint("RIGHT", line.rightText, "LEFT", -8, 0); nextButton:SetSize(48, 22)
		local nextButtonText = nextButton:CreateFontString(nil, "ARTWORK", "GameFontNormal"); nextButtonText:SetAllPoints(); nextButtonText:SetFont(STANDARD_TEXT_FONT, 12)
		nextButtonText:SetText("(Next)"); nextButton:SetPropagateMouseMotion(true)
		nextButton.text = nextButtonText
		nextButton:SetScript("OnClick", function() CycleReward(1) end)
		line.nextButton = nextButton
	end
	line.nextButton:Hide()
	local defaultNextColor = {1, 0.82, 0}; line.nextButton.text:SetTextColor(unpack(defaultNextColor))
	line.nextButton:SetScript("OnEnter", function() line.nextButton.text:SetTextColor(1, 1, 1) end)
	line.nextButton:SetScript("OnLeave", function() line.nextButton.text:SetTextColor(unpack(defaultNextColor)) end)
	StandardizeLineScripts(line, function(self)
		if not isComplete then line.text:SetTextColor(1, 0.82, 0, 1) end
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		if reward.type == "quest" then GameTooltip:SetHyperlink("quest:" .. primaryID) else GameTooltip:SetHyperlink(GetAchievementLink(primaryID)) end
		GameTooltip:Show()
		previewFrame.currentReward = reward; previewFrame.currentRewardIndex = 1
		local rewardsTable = reward.model3D or reward.texture
		if type(rewardsTable) == "table" then previewFrame.totalRewards = #rewardsTable
		else previewFrame.totalRewards = (rewardsTable ~= nil and rewardsTable ~= "") and 1 or 0 end
		if previewFrame.totalRewards > 1 then line.nextButton:Show() end
		if previewFrame.totalRewards > 0 then
			AnchorPreviewToTooltip(previewFrame, GameTooltip)
			UpdatePreviewDisplay()
		end
	end, function(self, button)
		if button == "LeftButton" then
			if reward.type ~= "quest" then
				if not AchievementFrame then AchievementFrame_LoadUI() end
				if not AchievementFrame:IsShown() then AchievementFrame_ToggleAchievementFrame() end
				AchievementFrame_SelectAchievement(primaryID)
			end
		elseif button == "RightButton" then
			ShowWowheadLinkPopup(primaryID, reward.type or "achievement") 
		end
	end, function(self)
		if isComplete then line.text:SetTextColor(0.64, 0.64, 0.64, 1) else line.text:SetTextColor(0.9, 0.9, 0.9, 1) end
	end, isFav)
	table.insert(activeWidgets, line)
	return y - 24
end

function BuildUI()
	ClearWidgets()
	local y = 0
	local hasContent = false
	local dataSource = (currentTab == "vendors" and db.vendors) or (currentTab == "drops" and db.drops) or (currentTab == "professions" and db.professions) or db.collections
	if not dataSource then return end
	local activeFilters = hb_settings.tabFilters[currentTab] or {}
	for _, group in ipairs(dataSource) do
		local groupTotal = 0
		local groupCompleted = 0
		local visibleRewards = {}
		local items = (currentTab == "vendors" and group.npcs) or (currentTab == "drops" and group.items) or (currentTab == "professions" and group.items) or group.achievements
		if items then
			for _, item in ipairs(items) do
				groupTotal = groupTotal + 1
				if IsRewardComplete(item) then groupCompleted = groupCompleted + 1 end

				local showStructural = true
				local rewardFaction = GetRewardFaction(item)
				local factionMatch = (rewardFaction == "neutral" and activeFilters.neutral) or (rewardFaction == "alliance" and activeFilters.alliance) or (rewardFaction == "horde" and activeFilters.horde)
				if not factionMatch then showStructural = false end
				if currentTab == "decor" then
					local rewardType = item.type or "achievement"
					local typeMatch = (rewardType == "quest" and activeFilters.quest) or (rewardType == "achievement" and activeFilters.achievement)
					if not typeMatch then showStructural = false end
				end
				if showStructural then
					local showSearch = true
					if currentSearchQuery ~= "" then
						local nameToCheck = ""
						if currentTab == "vendors" then
							 nameToCheck = item.title or ""
						elseif currentTab == "drops" or currentTab == "professions" then
							 nameToCheck = GetCachedItemName(item.id)
						else
							 local primaryID = item.id
							 if type(item.id) == "table" then primaryID = item.id[currentFaction] end
							 if item.type == "quest" then
									nameToCheck = questTitleCache[primaryID] or C_QuestLog.GetTitleForQuestID(primaryID) or ""
							 else
									local _, achievName = GetAchievementInfo(primaryID)
									nameToCheck = achievName or ""
							 end
						end
						if nameToCheck == "" or not string.find(string.lower(nameToCheck), currentSearchQuery, 1, true) then
							showSearch = false
						end
					end
					
					local showReqs = true
					if currentTab == "vendors" then
						local hasAnyPass = false
						local vItems = db.vendorItems[item.id]
						if vItems then
							for _, vItem in ipairs(vItems) do
								if ItemPassesRequirements(vItem) then
									hasAnyPass = true
									break
								end
							end
						end
						if not hasAnyPass then showReqs = false end
					end

					if showSearch and showReqs then table.insert(visibleRewards, item) end
				end
			end
		end
		if #visibleRewards > 0 then
			local favItems = {}
			local otherItems = {}
			for _, reward in ipairs(visibleRewards) do
				if IsFavorited(reward) then
					table.insert(favItems, reward)
				else
					table.insert(otherItems, reward)
				end
			end
			local isFullyComplete = (groupTotal > 0 and groupTotal == groupCompleted)
			local hasRenderableContent = false
			if hb_settings.hideNonFavorited then
				 if #favItems > 0 then hasRenderableContent = true end
			else
				 if (#favItems + #otherItems) > 0 then hasRenderableContent = true end
			end
			if hb_settings.hideCompleted and isFullyComplete then hasRenderableContent = false end
			local function HasVisible(list)
				 for _, it in ipairs(list) do
						if not (hb_settings.hideCompleted and IsRewardComplete(it)) then return true end
				 end
				 return false
			end
			if hasRenderableContent then
					local showFavs = HasVisible(favItems)
					local showOthers = (not hb_settings.hideNonFavorited) and HasVisible(otherItems)
					if showFavs or showOthers then
						hasContent = true
						local header, collapsed, newY = CreateHeader(scrollChild, group, groupTotal, groupCompleted, y)
						y = newY
						if not collapsed then
							local original_y = y
							for _, item in ipairs(favItems) do
								if not (hb_settings.hideCompleted and IsRewardComplete(item)) then
									 if currentTab == "vendors" then y = CreateVendorLine(scrollChild, item, y)
									 elseif currentTab == "drops" then y = CreateDropLine(scrollChild, item, y)
									 elseif currentTab == "professions" then y = CreateProfessionLine(scrollChild, item, y)
									 else y = CreateRewardLine(scrollChild, item, y) end
								end
							end
							if not hb_settings.hideNonFavorited then
								for _, item in ipairs(otherItems) do
									 if not (hb_settings.hideCompleted and IsRewardComplete(item)) then
											if currentTab == "vendors" then y = CreateVendorLine(scrollChild, item, y)
											elseif currentTab == "drops" then y = CreateDropLine(scrollChild, item, y)
											elseif currentTab == "professions" then y = CreateProfessionLine(scrollChild, item, y)
											else y = CreateRewardLine(scrollChild, item, y) end
									 end
								end
							end
							if y < original_y then y = y - 10 end
						end
					end
			end
		end
	end
	if not hasContent then
		local msg = scrollChild:CreateFontString(nil, "OVERLAY")
		msg:SetFont(STANDARD_TEXT_FONT, 14); msg:SetPoint("TOP", 0, -50)
		msg:SetText("You've collected everything!\nTry changing your filters.")
		msg:SetTextColor(0.9, 0.9, 0.9, 1); table.insert(activeWidgets, msg)
	end
	scrollChild:SetHeight(math.abs(y) + 20)
end

local function UpdateEscBehavior()
	local frameName = "HB_MainFrame"
	local foundIndex = nil
	for i, v in pairs(UISpecialFrames) do if v == frameName then foundIndex = i break end end
	if hb_settings.closeOnEsc then
		if not foundIndex then table.insert(UISpecialFrames, frameName) end
	else
		if foundIndex then table.remove(UISpecialFrames, foundIndex) end
	end
end

local function UpdateKeyBinding()
	if InCombatLockdown() then return end
	ClearOverrideBindings(bindingFrame)
	if hb_settings.toggleKeybind and hb_settings.toggleKeybind ~= "" then
		SetOverrideBindingClick(bindingFrame, true, hb_settings.toggleKeybind, "HB_KeyBindListener")
	end
end

local function CreateOptionsPanel()
	local configFrame = CreateFrame("Frame", "HB_ConfigFrame", UIParent)
	configFrame.name = "Home Bound"
	local configTitle = configFrame:CreateFontString(nil, "ARTWORK")
	configTitle:SetFont(STANDARD_TEXT_FONT, 16); configTitle:SetPoint("TOPLEFT", 16, -16); configTitle:SetText("Home Bound Settings")
	local escCheck = CreateFrame("CheckButton", nil, configFrame, "UICheckButtonTemplate")
	escCheck:SetPoint("TOPLEFT", configTitle, "BOTTOMLEFT", 0, -20)
	escCheck.Text:SetFont(STANDARD_TEXT_FONT, 14); escCheck.Text:SetTextColor(1, 0.82, 0); escCheck.Text:SetText(" Esc to Close Home Bound")
	escCheck:SetChecked(hb_settings.closeOnEsc)
	escCheck:SetScript("OnClick", function(self) hb_settings.closeOnEsc = self:GetChecked(); UpdateEscBehavior() end)
	local mmCheck = CreateFrame("CheckButton", nil, configFrame, "UICheckButtonTemplate")
	mmCheck:SetPoint("TOPLEFT", escCheck, "BOTTOMLEFT", 0, -10)
	mmCheck.Text:SetFont(STANDARD_TEXT_FONT, 14); mmCheck.Text:SetTextColor(1, 0.82, 0); mmCheck.Text:SetText(" Minimap Button")
	mmCheck:SetChecked(hb_settings.showMinimapButton)
	mmCheck:SetScript("OnClick", function(self) 
		hb_settings.showMinimapButton = self:GetChecked()
		if LibDBIcon then
			 if hb_settings.showMinimapButton then LibDBIcon:Show("HomeBound") else LibDBIcon:Hide("HomeBound") end
		end
	end)
	local tomCheck = CreateFrame("CheckButton", nil, configFrame, "UICheckButtonTemplate")
	tomCheck:SetPoint("TOPLEFT", mmCheck, "BOTTOMLEFT", 0, -10)
	tomCheck.Text:SetFont(STANDARD_TEXT_FONT, 14); tomCheck.Text:SetTextColor(1, 0.82, 0); tomCheck.Text:SetText(" Enable TomTom Waypoints")
	tomCheck:SetChecked(hb_settings.useTomTom)
	tomCheck:SetScript("OnClick", function(self) hb_settings.useTomTom = self:GetChecked() end)
	if not TomTom then tomCheck:Disable(); tomCheck.Text:SetText(" Enable TomTom Waypoints (Not Installed)") end
	local scaleLabel = configFrame:CreateFontString(nil, "ARTWORK")
	scaleLabel:SetFont(STANDARD_TEXT_FONT, 14); scaleLabel:SetTextColor(1, 0.82, 0); scaleLabel:SetPoint("TOPLEFT", tomCheck, "BOTTOMLEFT", 0, -20); scaleLabel:SetText("UI Scale")
	local scaleSlider = CreateFrame("Slider", nil, configFrame, "MinimalSliderWithSteppersTemplate")
	scaleSlider:SetWidth(200)
	scaleSlider:SetHeight(20)
	scaleSlider:SetPoint("TOPLEFT", scaleLabel, "BOTTOMLEFT", 0, -10)
	scaleSlider:Init(hb_settings.scale or 1.0, 0.5, 1.5, 20, {
		[MinimalSliderWithSteppersMixin.Label.Right] = function(value)
			return string.format("%.2f", value)
		end
	})
	scaleSlider.RightText:SetFont(STANDARD_TEXT_FONT, 14)
	scaleSlider.Slider:SetValueStep(0.05)
	scaleSlider:RegisterCallback(MinimalSliderWithSteppersMixin.Event.OnValueChanged, function(_, value)
		local rounded = tonumber(string.format("%.2f", value))
		hb_settings.scale = rounded
		frame:SetScale(rounded); supportFrame:SetScale(rounded); vendorPopup:SetScale(rounded); wowheadPopup:SetScale(rounded)
	end)
	local keybindLabel = configFrame:CreateFontString(nil, "ARTWORK")
	keybindLabel:SetFont(STANDARD_TEXT_FONT, 14); keybindLabel:SetTextColor(1, 0.82, 0); keybindLabel:SetPoint("TOPLEFT", scaleSlider, "BOTTOMLEFT", 0, -30); keybindLabel:SetText("Toggle Frame Keybind")
	local keybindBtn = CreateFrame("Button", nil, configFrame, "UIPanelButtonTemplate")
	keybindBtn:SetPoint("LEFT", keybindLabel, "RIGHT", 10, 0); keybindBtn:SetSize(140, 28)
	keybindBtn.Text:SetFont(STANDARD_TEXT_FONT, 14); keybindBtn:RegisterForClicks("AnyUp")
	keybindBtn:SetText(hb_settings.toggleKeybind or "Not Bound")
	keybindBtn:SetScript("OnEnter", function(self)
		if hb_settings.toggleKeybind and hb_settings.toggleKeybind ~= "" then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:AddLine("Home Bound (" .. hb_settings.toggleKeybind .. ")", 1, 1, 1)
			GameTooltip:AddLine("|cff00ff00<Right Click to unbind>", 1, 1, 1)
			GameTooltip:Show()
		end
	end)
	keybindBtn:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
	keybindBtn:SetScript("OnClick", function(self, button)
		if button == "RightButton" then
			hb_settings.toggleKeybind = nil
			self:SetText("Not Bound")
			UpdateKeyBinding()
			GameTooltip:Hide()
		else
			self:SetText("Press a key...")
			self:EnableKeyboard(true)
			self:SetScript("OnKeyDown", function(btn, key)
				if key == "LSHIFT" or key == "RSHIFT" or key == "LCTRL" or key == "RCTRL" or key == "LALT" or key == "RALT" then return end
				if key == "ESCAPE" then
					btn:EnableKeyboard(false)
					btn:SetText(hb_settings.toggleKeybind or "Not Bound")
					btn:SetScript("OnKeyDown", nil)
				else
					local modifier = ""
					if IsAltKeyDown() then modifier = modifier .. "ALT-" end
					if IsControlKeyDown() then modifier = modifier .. "CTRL-" end
					if IsShiftKeyDown() then modifier = modifier .. "SHIFT-" end
					local fullKey = modifier .. key
					hb_settings.toggleKeybind = fullKey
					btn:SetText(fullKey)
					btn:EnableKeyboard(false)
					btn:SetScript("OnKeyDown", nil)
					UpdateKeyBinding()
				end
			end)
		end
	end)
	local category = Settings.RegisterCanvasLayoutCategory(configFrame, "Home Bound")
	Settings.RegisterAddOnCategory(category)
	hb_options_category = category
end

local init = CreateFrame("Frame")
init:RegisterEvent("ADDON_LOADED")
init:RegisterEvent("PLAYER_ENTERING_WORLD")
init:RegisterEvent("ACHIEVEMENT_EARNED")
init:RegisterEvent("QUEST_TURNED_IN")
init:RegisterEvent("HOUSE_DECOR_ADDED_TO_CHEST")

init:SetScript("OnEvent", function(self, event, addon, ...)
	if event == "ADDON_LOADED" and addon == "HomeBound" then
		hb_settings.completedAchievs = hb_settings.completedAchievs or {}
		hb_settings.completedQuest = hb_settings.completedQuest or {}
		hb_settings.completedDrop = hb_settings.completedDrop or {}
		hb_settings.favorites = hb_settings.favorites or {}
		
		if hb_settings.showVendorCheckmarks == nil then hb_settings.showVendorCheckmarks = true end
		
		db.decorIdToItemId = {}
		if db.decorItem then
			for itemID, data in pairs(db.decorItem) do db.decorIdToItemId[data.decorID] = itemID end
		end
		hb_settings.showMinimapButton = hb_settings.showMinimapButton == nil and true or hb_settings.showMinimapButton
		if hb_settings.useTomTom == nil then hb_settings.useTomTom = true end
		if hb_settings.closeOnEsc == nil then hb_settings.closeOnEsc = true end
		hb_settings.tabFilters = hb_settings.tabFilters or {}
		local function InitializeTabFilter(tabName, includeType, includeReqs)
			 if not hb_settings.tabFilters[tabName] then
					 hb_settings.tabFilters[tabName] = { neutral = true, alliance = true, horde = true }
					 if includeType then
							 hb_settings.tabFilters[tabName].achievement = true
							 hb_settings.tabFilters[tabName].quest = true
					 end
					 if includeReqs then
						hb_settings.tabFilters[tabName].achievement = true
						hb_settings.tabFilters[tabName].quest = true
						hb_settings.tabFilters[tabName].reputation = true
					 end
			 end
		end
		InitializeTabFilter("decor", true, false)
		InitializeTabFilter("vendors", false, true)
		InitializeTabFilter("drops", false, false)
		InitializeTabFilter("professions", false, false)
		local ldb = LibStub:GetLibrary("LibDataBroker-1.1", true)
		if ldb then
			local dataobj = ldb:NewDataObject("HomeBound", { type = "launcher", icon = 7252953, label = "HomeBound", text = "HomeBound", name = "HomeBound",
				OnClick = function(_, button)
					if button == "LeftButton" then
						if not frame:IsShown() then BuildUI() end
						frame:SetShown(not frame:IsShown())
					elseif button == "RightButton" then Settings.OpenToCategory(hb_options_category:GetID()) end
				end
			})
			function dataobj:OnTooltipShow() self:AddLine("|cffffffffHome Bound|r"); self:AddLine("|cff00ff00<Left Click to toggle>\n<Right Click for options>"); self:SetScale(GameTooltip:GetScale()) end
			LibDBIcon:Register("HomeBound", dataobj, dbHB.minimap)
		end
	elseif event == "PLAYER_ENTERING_WORLD" then
		if UnitFactionGroup("player") == "Horde" then currentFaction = 2 end
		local scale = hb_settings.scale or 1.0
		frame:SetScale(scale); supportFrame:SetScale(scale); vendorPopup:SetScale(scale); wowheadPopup:SetScale(scale)
		BuildUI()
		CreateOptionsPanel()
		UpdateEscBehavior()
		UpdateKeyBinding()
		if not hb_settings.showMinimapButton then LibDBIcon:Hide("HomeBound") end
		wowheadPopup:ClearAllPoints()
		wowheadPopup:SetPoint("CENTER", frame, "CENTER", 0, 0)
		vendorPopup:ClearAllPoints()
		vendorPopup:SetPoint("CENTER", frame, "CENTER", 0, 0)
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	elseif event == "ACHIEVEMENT_EARNED" or event == "QUEST_TURNED_IN" then
		C_Timer.After(0.5, BuildUI)
	elseif event == "HOUSE_DECOR_ADDED_TO_CHEST" then
		local decorID = ...
		local itemID = db.decorIdToItemId[decorID]
		if itemID and not hb_settings.completedDrop[itemID] then
			hb_settings.completedDrop[itemID] = true
			for npcID, info in pairs(vendorSessionCache) do
				if not info.isComplete then vendorSessionCache[npcID] = nil; GetVendorStatus(npcID) end
			end
			collectionCache[itemID] = nil
			BuildUI()
		end
	end
end)

SLASH_HB1 = "/hb"
SLASH_HB2 = "/homebound"
SlashCmdList["HB"] = function()
	if not frame:IsShown() then BuildUI() end
	frame:SetShown(not frame:IsShown())
end