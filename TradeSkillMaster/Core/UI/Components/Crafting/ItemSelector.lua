-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                          https://tradeskillmaster.com                          --
--    All Rights Reserved - Detailed license information included with addon.     --
-- ------------------------------------------------------------------------------ --

local TSM = select(2, ...) ---@type TSM
local Rectangle = TSM.Include("UI.Rectangle")
local Tooltip = TSM.Include("UI.Tooltip")
local UIElements = TSM.Include("UI.UIElements")
local ItemInfo = TSM.Include("Service.ItemInfo")
local L = TSM.Include("Locale").GetTable()
local private = {}
local CORNER_RADIUS = 6



-- ============================================================================
-- Element Definition
-- ============================================================================

local ItemSelector = UIElements.Define("ItemSelector", "Button") ---@class ItemSelector: Button
ItemSelector:_ExtendStateSchema()
	:AddBooleanField("disabled", false)
	:AddBooleanField("mouseOver", false)
	:AddStringField("selection", "")
	:AddNumberField("itemQuality", 0)
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
end

function ItemSelector:Acquire()
	self.__super:Acquire()

	self:EnableRightClick()

	-- Set the background state
	self._state:Publisher()
		:IgnoreDuplicatesWithKeys("disabled", "mouseOver")
		:MapWithFunction(private.StateToBackgroundColorKey)
		:IgnoreDuplicates()
		:CallMethod(self._background, "SubscribeColor")

	self._state:PublisherForKeyChange("selection")
		:MapBooleanEquals("")
		:CallMethod(self._background, "SetShown")
	self._state:PublisherForKeyChange("selection")
		:MapBooleanEquals("")
		:CallMethod(self._backgroundOverlay, "SetShown")
	self._state:PublisherForKeyChange("selection")
		:MapBooleanEquals("")
		:CallMethod(self._addIcon, "SetShown")

	-- Set the quality state
	self._state:PublisherForKeyChange("itemQuality")
		:MapWithFunction(private.StateToQualityText)
		:CallMethod(self._quality, "SetText")
end

function ItemSelector:Release()
	self.__super:Release()

	self._background:CancelAll()
	self._backgroundOverlay:CancelAll()

	wipe(self._items)
end

---Sets the selectable items that can be picked
---@param items string[] The indexed table that contains the possible selections
function ItemSelector:SetItems(items)
	wipe(self._items)
	for _, itemString in ipairs(items) do
		tinsert(self._items, itemString)
	end
	return self
end

---Clears the current selection
function ItemSelector:ClearSelection()
	self._state.selection = ""
	return self
end

---Returns the current selection of the ItemSelector
function ItemSelector:GetSelection()
	return self._state.selection
end

---Set whether or not the item selector is disabled.
---@param disabled boolean Whether or not the item selector should be disabled
---@return ItemSelector
function ItemSelector:SetDisabled(disabled)
	self._state.disabled = disabled and true or false
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
		self._state.selection = ""
		self._state.itemQuality = 0
		self:SetBackground(nil)
		self:SetTooltip(nil)
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
				:SetFont("ITEM_BODY3")
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
					:SetContext(self)
					:AddChildrenWithFunction(private.CreateItems, self)
				)
			)
		)
	)
end

function ItemSelector.__private:_CloseDialog()
	self:GetBaseElement():HideDialog()
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
	self._state.selection = button:GetContext()
	self._state.itemQuality = ItemInfo.GetCraftedQuality(self._state.selection) or 0

	self:GetBaseElement():HideDialog()
	self:SetBackgroundWithItemHighlight(self._state.selection)
	self:SetTooltip(self._state.selection)
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

function private.StateToQualityText(itemQuality)
	if itemQuality > 0 then
		return Professions.GetChatIconMarkupForQuality(itemQuality, true)
	else
		return ""
	end
end

function private.CreateItems(frame, self)
	for _, itemString in ipairs(frame:GetContext()._items) do
		local craftQuality = ItemInfo.GetCraftedQuality(itemString)
		frame:AddChild(UIElements.New("Frame", "content")
			:SetLayout("HORIZONTAL")
			:AddChild(UIElements.New("Button", itemString.."Icon")
				:SetSize(30, 30)
				:SetPadding(0, 0, 0, 0)
				:SetMargin(2, 2, 2, 2)
				:SetContext(itemString)
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
