-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                          https://tradeskillmaster.com                          --
--    All Rights Reserved - Detailed license information included with addon.     --
-- ------------------------------------------------------------------------------ --

local TSM = select(2, ...) ---@type TSM
local MatString = TSM.Include("Util.MatString")
local ItemInfo = TSM.Include("Service.ItemInfo")
local Profession = TSM.Include("Service.Profession")
local Rectangle = TSM.Include("UI.Rectangle")
local Tooltip = TSM.Include("UI.Tooltip")
local UIElements = TSM.Include("UI.UIElements")
local ItemString = TSM.Include("Util.ItemString")
local L = TSM.Include("Locale").GetTable()
local private = {
	salvageMatsTemp = {},
}
local CORNER_RADIUS = 6



-- ============================================================================
-- Element Definition
-- ============================================================================

local ItemSelector = UIElements.Define("ItemSelector", "Button") ---@class ItemSelector: Button
ItemSelector:_ExtendStateSchema()
	:AddBooleanField("disabled", false)
	:AddBooleanField("mouseOver", false)
	:AddOptionalStringField("selection")
	:Commit()



-- ============================================================================
-- Public Class Methods
-- ============================================================================

function ItemSelector:__init(button)
	self.__super:__init(button)

	local frame = self:_GetBaseFrame()
	frame:TSMSetScript("OnMouseUp", self:__closure("_HandleClick"))
	frame:TSMSetScript("OnEnter", self:__closure("_HandleFrameEnter"))
	frame:TSMSetScript("OnLeave", self:__closure("_HandleFrameLeave"))

	self._background = Rectangle.New(frame)
	self._background:SetCornerRadius(CORNER_RADIUS)
	self._backgroundOverlay = Rectangle.New(frame, 1)
	self._backgroundOverlay:SetCornerRadius(CORNER_RADIUS)
	self._backgroundOverlay:SetInset(2)
	self._backgroundOverlay:SetColor("PRIMARY_BG_ALT")

	self._quality = UIElements.CreateFontString(self, frame)
	self._quality:SetSize(32, 32)
	self._quality:TSMSetFont("BODY_BODY1")
	self._quality:SetPoint("TOPLEFT", -2, 10)
	self._quality:SetJustifyH("LEFT")

	self._addIcon = UIElements.CreateTexture(self, frame, "ARTWORK")
	self._addIcon:SetPoint("BOTTOMRIGHT", -2, 2)
	self._addIcon:TSMSetTextureAndSize("iconPack.14x14/Add/Default")

	self._items = {}
	self._onSelectionChanged = nil
end

function ItemSelector:Acquire()
	self.__super:Acquire()

	self:EnableRightClick()

	-- Set our own state
	self._state:PublisherForKeyChange("selection")
		:MapWithFunction(private.SelectionToItemString)
		:Share(2)
		:CallMethod(self, "SetTooltip")
		:CallMethod(self, "SetBackgroundWithItemHighlight")

	-- Set the background state
	self._state:Publisher()
		:IgnoreDuplicatesWithKeys("disabled", "mouseOver")
		:MapWithFunction(private.StateToBackgroundColorKey)
		:IgnoreDuplicates()
		:CallMethod(self._background, "SubscribeColor")

	self._state:PublisherForKeyChange("selection")
		:MapBooleanEquals(nil)
		:Share(3)
		:CallMethod(self._background, "SetShown")
		:CallMethod(self._backgroundOverlay, "SetShown")
		:CallMethod(self._addIcon, "SetShown")

	-- Set the quality state
	self._state:PublisherForKeyChange("selection")
		:MapWithFunction(private.SelectionToQualityText)
		:CallMethod(self._quality, "SetText")
end

function ItemSelector:Release()
	self.__super:Release()

	self._background:CancelAll()
	self._backgroundOverlay:CancelAll()

	wipe(self._items)
	self._onSelectionChanged = nil
end

---Sets the selectable items that can be picked.
---@param items string[] The indexed table that contains the possible selections
---@return ItemSelector
function ItemSelector:SetItems(items)
	wipe(self._items)
	for _, itemString in ipairs(items) do
		tinsert(self._items, itemString)
	end
	return self
end

---SEts the list of items from a salvage crafting recipe.
---@param craftString string The craft string of the salvage recipe
---@return ItemSelector
function ItemSelector:SetSalvageTargetItems(craftString)
	wipe(self._items)
	if not craftString or not Profession.IsSalvage(craftString) then
		return self
	end
	assert(not next(private.salvageMatsTemp))
	for _, matString in Profession.MatIterator(craftString) do
		for matItemString in MatString.ItemIterator(matString) do
			tinsert(private.salvageMatsTemp, ItemString.ToId(matItemString))
		end
	end
	local targetItems = Profession.GetTargetItems(private.salvageMatsTemp)
	wipe(private.salvageMatsTemp)

	local requiredQty = Profession.GetCraftedQuantityRange(craftString)
	for _, targetItem in ipairs(targetItems) do
		local location = C_Item.GetItemLocation(targetItem.itemGUID)
		local stackCount = location and C_Item.GetStackCount(location) or 0
		if stackCount >= requiredQty then
			tinsert(self._items, targetItem.itemGUID)
		end
	end
	return self
end

---Sets the list of items from a mat string.
---@param matString string The mat string
---@return ItemSelector
function ItemSelector:SetMatString(matString)
	wipe(self._items)
	if matString then
		for itemString in MatString.ItemIterator(matString) do
			tinsert(self._items, itemString)
		end
	end
	return self
end

---Get the currently selected item.
---@return The selected item
function ItemSelector:GetSelection()
	return self._state.selection
end

---Sets the current selection of the ItemSelector.
---@param selection? string The item to select or nil to clear the selection
---@return ItemSelector
function ItemSelector:SetSelection(selection)
	self._state.selection = selection
	if self._onSelectionChanged then
		self:_onSelectionChanged(selection)
	end
	return self
end

---Set whether or not the item selector is disabled.
---@param disabled boolean Whether or not the item selector should be disabled
---@return ItemSelector
function ItemSelector:SetDisabled(disabled)
	self._state.disabled = disabled and true or false
	return self
end

---Registers a script handler.
---@param script "OnSelectionChanged"
---@param handler fun(itemSelector: ItemSelector, ...: any) The handler
---@return ItemSelector
function ItemSelector:SetScript(script, handler)
	if script == "OnSelectionChanged" then
		self._onSelectionChanged = handler
	else
		self.__super:SetScript(script, handler)
	end
	return self
end



-- ============================================================================
-- Private Class Methods
-- ============================================================================

function ItemSelector.__private:_HandleClick(_, mouseButton)
	if not self._acquired or self._state.disabled then
		return
	end

	if mouseButton == "RightButton" then
		self:SetSelection(nil)
		Tooltip.Hide()
		return
	end

	self._opened = not self._opened
	if not self._opened then
		return
	end

	self:GetBaseElement():ShowDialogFrame(UIElements.New("Frame", "frame")
		:SetSize(130, 168)
		:SetLayout("VERTICAL")
		:SetPadding(2)
		:AddAnchor("TOPLEFT", self:_GetBaseFrame(), "TOPRIGHT", 4, 0)
		:SetRoundedBackgroundColor("FRAME_BG")
		:SetMouseEnabled(true)
		:SetScript("OnHide", self:__closure("_HandleFrameOnHide"))
		:AddChild(UIElements.New("Frame", "header")
			:SetLayout("HORIZONTAL")
			:SetHeight(24)
			:SetStrata("HIGH")
			:SetRoundedBackgroundColor("ACTIVE_BG")
			:AddChild(UIElements.New("Text", "title")
				:SetMargin(18, 8, -4, 0)
				:SetFont("BODY_BODY3")
				:SetJustifyH("CENTER")
				:SetText(L["Item Selection"])
			)
			:AddChild(UIElements.New("Button", "closeBtn")
				:SetMargin(0, 2, -4, 0)
				:SetBackgroundAndSize("iconPack.14x14/Close/Default")
				:SetScript("OnClick", self:__closure("_HandleFrameOnHide"))
			)
		)
		:AddChild(UIElements.New("Frame", "scroll")
			:SetLayout("HORIZONTAL")
			:SetMargin(0, 0, -4, 0)
			:SetStrata("DIALOG")
			:SetHeight(144)
			:SetBackgroundColor("FRAME_BG")
			:AddChild(UIElements.New("ScrollFrame", "scroll")
				:SetPadding(12, 8, 4, 4)
				:AddChild(UIElements.New("Frame", "items")
					:SetLayout("FLOW")
					:AddChildrenWithFunction(self:__closure("_CreateItems"))
				)
			)
		)
	)
end

function ItemSelector.__private:_HandleFrameOnHide()
	self._opened = false
	self:GetBaseElement():HideDialog()
end

function ItemSelector.__private:_HandleFrameEnter()
	self._state.mouseOver = true
end

function ItemSelector.__private:_HandleFrameLeave()
	self._state.mouseOver = false
end

function ItemSelector.__private:_HandleButtonOnClick(button)
	self:SetSelection(button:GetContext())
	self:GetBaseElement():HideDialog()
end

function ItemSelector.__private:_CreateItems(frame)
	for _, item in ipairs(self._items) do
		local itemString = nil
		if ItemString.IsItem(item) then
			itemString = item
		elseif strmatch(item, "^Item-") then
			itemString = ItemString.Get(C_Item.GetItemIDByGUID(item))
		else
			error("Invalid item")
		end
		local craftQuality = ItemInfo.GetCraftedQuality(itemString)
		frame:AddChild(UIElements.New("Frame", "content")
			:SetLayout("HORIZONTAL")
			:AddChild(UIElements.New("Button", itemString.."Icon")
				:SetSize(30, 30)
				:SetPadding(0, 0, 0, 0)
				:SetMargin(2, 2, 2, 2)
				:SetContext(item)
				:SetBackgroundWithItemHighlight(itemString)
				:SetTooltip(itemString)
				:SetScript("OnClick", self:__closure("_HandleButtonOnClick"))
			)
			:AddChildNoLayout(UIElements.New("Text", itemString.."Quality")
				:SetSize(30, 30)
				:AddAnchor("TOPLEFT", 0, 8)
				:SetShown(craftQuality and true or false)
				:SetText(craftQuality and Professions.GetChatIconMarkupForQuality(craftQuality, true) or "")
			)
		)
	end
end



-- ============================================================================
-- Private Helper Functions
-- ============================================================================

function private.StateToBackgroundColorKey(state)
	if state.disabled then
		return "ACTIVE_BG"
	else
		if state.mouseOver then
			return "TEXT_ALT+HOVER"
		else
			return "TEXT_ALT"
		end
	end
end

function private.SelectionToItemString(selection)
	if selection and strmatch(selection, "^Item-") then
		selection = ItemString.Get(C_Item.GetItemIDByGUID(selection))
	end
	return selection
end

function private.SelectionToQualityText(selection)
	if selection and strmatch(selection, "^Item-") then
		selection = ItemString.Get(C_Item.GetItemIDByGUID(selection))
	end
	local itemQuality = selection and ItemInfo.GetCraftedQuality(selection)
	if not itemQuality then
		return ""
	end
	return Professions.GetChatIconMarkupForQuality(itemQuality, true)
end
