FatalityOptions = CreateFrame("Frame", "FatalityOptionsFrame", UIParent)
FatalityOptions:SetWidth(350)
FatalityOptions:SetHeight(540)
FatalityOptions:SetFrameStrata("DIALOG")
FatalityOptions:SetPoint("CENTER", 0, 0)
FatalityOptions:SetBackdrop({bgFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 24, insets = {left = 5, right = 5, top = 5, bottom = 5}})
FatalityOptions:SetBackdropColor(0.1, 0.1, 0.1, 1)
FatalityOptions:SetBackdropBorderColor(1, 1, 1, 1)
FatalityOptions:SetMovable(1)
FatalityOptions:EnableMouse(1)
FatalityOptions:SetToplevel(1)
FatalityOptions:SetClampedToScreen(1)
FatalityOptions:SetScript("OnMouseDown", FatalityOptions.StartMoving)
FatalityOptions:SetScript("OnMouseUp", FatalityOptions.StopMovingOrSizing)
FatalityOptions.title = FatalityOptions:CreateFontString("FatalityTitleFont", "ARTWORK", "GameFontNormal")
FatalityOptions.title:SetFont(GameFontNormal:GetFont(), 20, "OUTLINE")
FatalityOptions.title:SetPoint("TOP", FatalityOptions, 0, -15)
FatalityOptions.title:SetText("|cffff9900"..Fatality.title.."|r |cffffff00v"..Fatality.version.."|r")
FatalityOptions.enableButton = CreateFrame("CheckButton", "FatalityEnableButton", FatalityOptions, "OptionsSmallCheckButtonTemplate")
FatalityOptions.enableButton:SetWidth(24)
FatalityOptions.enableButton:SetHeight(24)
FatalityOptions.enableButton:SetPoint("TOPLEFT", 5, -5)
FatalityOptions.enableButton:SetHitRectInsets(0, 0, 0, 0)
FatalityOptions.enableButton:SetCheckedTexture("Interface\\COMMON\\Indicator-Green")
FatalityOptions.enableButton:SetNormalTexture("Interface\\COMMON\\Indicator-Red")
FatalityOptions.enableButton.text = FatalityOptions.enableButton:CreateFontString(nil, "ARTWORK", "GameFontNormal")
FatalityOptions.enableButton.text:SetPoint("LEFT", FatalityOptions.enableButton, "RIGHT", -3, 0)
FatalityOptions.enableButton.text:SetFont(GameFontNormal:GetFont(), 16, "OUTLINE")
FatalityOptions.closeButton = CreateFrame("Button", "FatalityCloseButton", FatalityOptions, "UIPanelCloseButton")
FatalityOptions.closeButton:SetPoint("TOPRIGHT")
FatalityOptions.closeButton:SetScript("OnClick", function() FatalityOptions:Hide() end)

local L = Fatality_Locales

local slider_id, dropdown_id, checkbox_id, option_id = 1, 1, 1, 1
local options = {}
local outputs = {
	{"Self","SELF"},
	{CHANNEL,"CHANNEL"},
	{GUILD,"GUILD"},
	{OFFICER,"OFFICER"},
	{PARTY,"PARTY"},
	{RAID,"RAID"},
	{INSTANCE_CHAT,"INSTANCE_CHAT"},
	{RAID_WARNING,"RAID_WARNING"},
	{WHISPER,"WHISPER"},
}

local function printf(s, ...)
	print("|cff39d7e5Fatality:|r "..s:format(...))
end

local function GetIDByValue(value)
	for i=1,#outputs do
		if value == outputs[i][2] then return i end
	end
end

local function GetValueByID(id)
	for i=1,#outputs do
		if id == i then return outputs[i][2] end
	end
end

local function MenuEdit_ToggleAlpha(o)
	local menu = (o.name == "Raid" and FatalityDropdownMenu1) or (o.name == "Party" and FatalityDropdownMenu2)
	if menu then
		if FatalityDB[o.var] then
			menu.edit:Enable()
			menu.edit:SetAlpha(1)
			UIDropDownMenu_EnableDropDown(menu)
		else
			menu.edit:Disable()
			menu.edit:SetAlpha(0.5)
			UIDropDownMenu_DisableDropDown(menu)
		end
	end
end

local function MenuEdit_ToggleVisibility(menu, id)
	local value = GetValueByID(id)
	if value == "CHANNEL" then
		menu.edit:SetText(FatalityDB[menu.var[2]])
	elseif value == "WHISPER" then
		menu.edit:SetText(FatalityDB[menu.var[3]])
	else
		menu.edit:Hide()
		return
	end
	menu.edit:Show()
end

function FatalityOptions:Update(id)
	local o = options[id]
	if o.type == "Checkbox" then
		self.db[o.var] = o.check:GetChecked() or false
		MenuEdit_ToggleAlpha(o)
	elseif o.type == "Slider" then
		self.db[o.var] = o.slider:GetValue()
	elseif o.type == "Dropdown" then
		local value = GetValueByID(UIDropDownMenu_GetSelectedID(o.menu))
		self.db[o.var[1]] = value
		if value == "CHANNEL" or value == "WHISPER" then
			self.db[value == "CHANNEL" and o.var[2] or o.var[3]] = o.menu.edit:GetText()
		end
		Fatality:UpdateOutputSettings()
	end
end

function FatalityOptions:UpdateEnabledStatus(click)
	if click then
		FatalityStatusDB.enabled = not FatalityStatusDB.enabled
		printf(FatalityStatusDB.enabled and L.addon_enabled or L.addon_disabled)
		Fatality:CheckEnable()
	end
	self.enableButton:SetChecked(FatalityStatusDB.enabled)
end

FatalityOptions.enableButton:SetScript("OnClick", function() FatalityOptions:UpdateEnabledStatus(true) end)

local function init(self)
	for _,option in pairs(outputs) do
		local info = UIDropDownMenu_CreateInfo()
		info.text = option[1]
		info.value = option[2]
		info.func = function(self)
			local menu = UIDROPDOWNMENU_OPEN_MENU
			UIDropDownMenu_SetSelectedID(menu, self:GetID())
			MenuEdit_ToggleVisibility(menu, self:GetID())
			FatalityOptions:Update(menu.id)
		end
		UIDropDownMenu_AddButton(info)
	end
end

function FatalityOptions:ShowOptions()
	for j=1,#options do
		local o = options[j]
		if o.type == "Checkbox" then
			o.check:SetChecked(self.db[o.var])
			MenuEdit_ToggleAlpha(o)
		elseif o.type == "Slider" then
			o.slider:SetValue(self.db[o.var])
		elseif o.type == "Dropdown" then
			UIDropDownMenu_Initialize(o.menu, init)
			UIDropDownMenu_SetSelectedID(o.menu, GetIDByValue(self.db[o.var[1]]))
			o.menu.edit:SetText(self.db[o.var[1]] == "CHANNEL" and self.db[o.var[2]] or self.db[o.var[3]])
			MenuEdit_ToggleVisibility(o.menu, UIDropDownMenu_GetSelectedID(o.menu))
		end
	end
	self:Show()
	FatalityOptions:UpdateEnabledStatus()
end

FatalityOptions:SetScript("OnHide", function(self)
	if self.db.first then
		self.db.first = false
		self:ShowOptions()
		printf(L.welcome1)
		printf(L.welcome2)
		printf(L.welcome3)
	end
	Fatality:CheckEnable()
end)

local function MenuEdit_OnFocusLost(self)
	if not self.confirmed then
		self:SetText(self.originalText)
		self:ClearFocus()
		self.button:Hide()
	end
end

local function Checkbox_OnClick(self)
	FatalityOptions:Update(self.id)
end

local function MenuEdit_OnFocusGained(self)
	self.confirmed = false
	self.originalText = self:GetText()
	self:HighlightText()
end

local function MenuEdit_OnTextChanged(self, user)
	if user then self.button:Show() end
end

local function MenuEditButton_OnClick(self)
	local parent = self:GetParent()
	parent.confirmed = true
	parent:ClearFocus()
	self:Hide()
	FatalityOptions:Update(parent.id)
end

local function MenuEdit_OnEnterPressed(self)
	self.confirmed = true
	self:ClearFocus()
	self.button:Hide()
	FatalityOptions:Update(self.id)
end

local function SliderEdit_OnEnterPressed(self, focus)
	self.confirmed = true
	self:GetParent().slider:SetValue(self:GetNumber())
	FatalityOptions:Update(self.id)
	if not focus then self:ClearFocus() end
end

local function SliderEdit_OnFocusGained(self)
	self.confirmed = false
	self.originalText = self:GetText()
	self:HighlightText()
end

local function SliderEdit_OnFocusLost(self)
	if not self.confirmed then
		self:SetText(self.originalText)
		self:ClearFocus()
	end
end

local function Slider_OnValueChanged(self)
	self:GetParent().edit:SetNumber(self:GetValue())
	FatalityOptions:Update(self.id)
end

local function Slider_OnMouseWheel(self, delta)
	self:SetValue(self:GetValue() + self:GetParent().step * delta)
end

local function Option_OnEnter(frame)
	local tip, parent = GameTooltip, frame:GetParent()
	tip:SetOwner(frame, "ANCHOR_TOP", 0, 10)
	tip:SetText(parent.name)
	tip:AddLine("|cffffffcc"..parent.description.."|r")
	tip:Show()
end

local function Option_OnLeave(frame)
	GameTooltip:Hide()
end

local function CreateOption(type, var, name, description, step, min, max, letters)
	local option = CreateFrame("Frame", "FatalityOption"..option_id, FatalityOptions)
	option:SetWidth(1)
	option:SetHeight(1)
	option.type = type
	option.name = name
	option.step = step
	option.var = var
	option.id = option_id
	if type == "Checkbox" then
		option.check = CreateFrame("CheckButton", "FatalityCheckbox"..checkbox_id, option, "OptionsSmallCheckButtonTemplate")
		option.check:SetScript("OnClick", Checkbox_OnClick)
		option.check:SetPoint("LEFT", option)
		option.check:SetWidth(28)
		option.check:SetHeight(28)
		option.check:SetChecked(FatalityDB[var])
		option.check:SetHitRectInsets(0, -60, 0, 0)
		option.check:GetNormalTexture():SetAlpha(0.6)
		option.check:SetScript("OnEnter", Option_OnEnter)
		option.check:SetScript("OnLeave", Option_OnLeave)
		option.check.id = option_id
		option.check.texture = option.check:CreateTexture(nil, "ARTWORK")
		option.check.texture:SetWidth(22)
		option.check.texture:SetHeight(22)
		option.check.texture:SetAlpha(0.9)
		option.check.texture:SetPoint("LEFT", 2, 1)
		option.check.texture:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-Ready")
		option.check:SetCheckedTexture(option.check.texture)
		option.text = FatalityOptions:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		option.text:SetPoint("LEFT", option.check, "RIGHT", -1, 1)
		option.text:SetFont(GameFontNormal:GetFont(), 14, "OUTLINE")
		option.text:SetText(name)
		option.description = description
		checkbox_id = checkbox_id + 1
	elseif type == "Slider" then
		option.edit = CreateFrame("EditBox", "FatalitySliderInputBox"..slider_id, option, "InputBoxTemplate")
		option.edit:SetPoint("LEFT", option)
		option.edit:SetTextInsets(-5, 0, 0, 0)
		option.edit:SetNumber(FatalityDB[var])
		option.edit:SetWidth(50)
		option.edit:SetHeight(20)
		option.edit:SetAutoFocus(false)
		option.edit:SetMaxLetters(letters)
		option.edit:SetJustifyH("CENTER")
		option.edit:SetNumeric(true)
		option.edit:SetScript("OnEnterPressed", SliderEdit_OnEnterPressed)
		option.edit:SetScript("OnEditFocusGained", SliderEdit_OnFocusGained)
		option.edit:SetScript("OnEditFocusLost", SliderEdit_OnFocusLost)
		option.edit.id = option_id
		local slider_name = "Slider"..slider_id
		option.slider = CreateFrame("Slider", slider_name, option, "OptionsSliderTemplate")
		option.slider:SetWidth(250)
		option.slider:SetPoint("LEFT", option.edit, "RIGHT", 10, -7)
		option.slider:SetMinMaxValues(min, max)
		option.slider:SetValueStep(step)
		option.slider:SetValue(FatalityDB[var])
		option.slider:EnableMouseWheel(1)
		option.slider:SetScript("OnValueChanged", Slider_OnValueChanged)
		option.slider:SetScript("OnMouseWheel", Slider_OnMouseWheel)
		option.slider:SetScript("OnEnter", Option_OnEnter)
		option.slider:SetScript("OnLeave", Option_OnLeave)
		option.slider.id = option_id
		option.lefttext = _G[slider_name.."Low"]
		option.lefttext:SetFont(GameFontNormal:GetFont(), 12, "OUTLINE")
		option.lefttext:SetTextColor(1, 1, 0.8)
		option.lefttext:ClearAllPoints()
		option.lefttext:SetPoint("BOTTOMLEFT", option.slider, "TOPLEFT", 0, 0)
		option.lefttext:SetText(min)
		option.midtext = _G[slider_name.."Text"]
		option.midtext:SetFont(GameFontNormal:GetFont(), 12, "OUTLINE")
		option.midtext:SetTextColor(0.98, 0.81, 0)
		option.midtext:ClearAllPoints()
		option.midtext:SetPoint("TOP", option.slider, 0, 14)
		option.midtext:SetText(name)
		option.righttext = _G[slider_name.."High"]
		option.righttext:SetFont(GameFontNormal:GetFont(), 12, "OUTLINE")
		option.righttext:SetTextColor(1, 1, 0.8)
		option.righttext:ClearAllPoints()
		option.righttext:SetPoint("BOTTOMRIGHT", option.slider, "TOPRIGHT", 0, 0)
		option.righttext:SetText(max)
		option.description = description
		slider_id = slider_id + 1
	elseif type == "Dropdown" then
		option.menu = CreateFrame("Button", "FatalityDropdownMenu"..dropdown_id, option, "UIDropDownMenuTemplate")
		option.menu:SetPoint("LEFT", option, -20, -25)
		option.menu.id = option_id
		option.menu.text = option.menu:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		option.menu.text:SetFont(GameFontNormal:GetFont(), 14, "OUTLINE")
		option.menu.text:SetPoint("LEFT", option.menu, 17, 26)
		option.menu.text:SetText(name)
		option.menu.edit = CreateFrame("EditBox", "FatalityDropdownEditBox"..dropdown_id, option.menu, "InputBoxTemplate")
		option.menu.edit:SetPoint("LEFT", option.menu, "RIGHT", 122, 3)
		option.menu.edit:SetWidth(135)
		option.menu.edit:SetHeight(20)
		option.menu.edit:SetMaxLetters(50)
		option.menu.edit:SetAutoFocus(false)
		option.menu.edit:SetScript("OnEnterPressed", MenuEdit_OnEnterPressed)
		option.menu.edit:SetScript("OnTextChanged", MenuEdit_OnTextChanged)
		option.menu.edit:SetScript("OnEditFocusGained", MenuEdit_OnFocusGained)
		option.menu.edit:SetScript("OnEditFocusLost", MenuEdit_OnFocusLost)
		option.menu.edit.id = option_id
		option.menu.edit.button = CreateFrame("Button", "FatalityDropdownEditBoxButton"..dropdown_id, option.menu.edit, "UIPanelButtonTemplate")
		option.menu.edit.button:SetWidth(40)
		option.menu.edit.button:SetHeight(20)
		option.menu.edit.button:SetPoint("RIGHT", 40, 0)
		option.menu.edit.button:SetText("Okay")
		option.menu.edit.button:SetScript("OnClick", MenuEditButton_OnClick)
		option.menu.edit.button:Hide()
		UIDropDownMenu_Initialize(option.menu, init)
		UIDropDownMenu_SetSelectedID(option.menu, GetIDByValue(FatalityDB[var[1]]))
		UIDropDownMenu_JustifyText(option.menu, "LEFT")
		option.menu.var = var
		dropdown_id = dropdown_id + 1
	end
	if #options == 0 then
		option:SetPoint("TOPLEFT", 12, -60)
	else
		local prev = options[#options]
		if type == "Checkbox" then
			if step == "left" or (step == "right" and prev.step == "right") then
				option:SetPoint("BOTTOM", prev, 0, #options % 2 == 0 and -35 or -25)
			elseif step == "right" then
				if prev.step == "left" then
					option:SetPoint("LEFT", options[1], 155, 0)
				end
			end
		elseif type == "Slider" then
			if prev.type == "Checkbox" then
				option:SetPoint("BOTTOM", options[6], 10, -40)
			else
				option:SetPoint("BOTTOM", prev, 0, -50)
			end
		elseif type == "Dropdown" then
			if prev.type == "Dropdown" then
				option:SetPoint("BOTTOM", prev, 0, -50)
			else
				option:SetPoint("BOTTOM", prev, -3, -35)
			end
		end
	end
	options[#options + 1] = option
	option_id = option_id + 1
end

FatalityOptions:RegisterEvent("ADDON_LOADED")
FatalityOptions:SetScript("OnEvent", function(self, event, addon)
	if addon == "Fatality" then
		self.db = FatalityDB
		CreateOption("Checkbox", "raid", L.config_raid, L.config_raid_desc, "left")
		CreateOption("Checkbox", "promoted", L.config_promoted, L.config_promoted_desc, "left")
		CreateOption("Checkbox", "overkill", L.config_overkill, L.config_overkill_desc, "left")
		CreateOption("Checkbox", "absorb", L.config_absorb, L.config_absorb_desc, "left")
		CreateOption("Checkbox", "icons", L.config_icons, L.config_icons_desc, "left")
		CreateOption("Checkbox", "source", L.config_source, L.config_source_desc, "left")
		CreateOption("Checkbox", "party", L.config_party, L.config_party_desc,  "right")
		CreateOption("Checkbox", "lfr", L.config_lfr, L.config_lfr_desc, "right")
		CreateOption("Checkbox", "resist", L.config_resist, L.config_resist_desc, "right")
		CreateOption("Checkbox", "block", L.config_block, L.config_block_desc, "right")
		CreateOption("Checkbox", "school", L.config_school, L.config_school_desc, "right")
		CreateOption("Checkbox", "short", L.config_short, L.config_short_desc, "right")
		CreateOption("Slider", "limit10", L.config_limit10, L.config_limit_desc , 1, 1, 10, 2)
		CreateOption("Slider", "limit25", L.config_limit25, L.config_limit_desc, 1, 1, 25, 2)
		CreateOption("Slider", "history", L.config_history, L.config_history_desc, 1, 1, 5, 1)
		CreateOption("Slider", "threshold", L.config_threshold, L.config_threshold_desc, 250, 0, 100000, 6)
		CreateOption("Dropdown", {"output1","channel1","whisper1"}, L.config_output_raid)
		CreateOption("Dropdown", {"output2","channel2","whisper2"}, L.config_output_party)
		UISpecialFrames[#UISpecialFrames + 1] = self:GetName()
		self:UnregisterEvent("ADDON_LOADED")
		self:UpdateEnabledStatus()
	end
end)