local u = BittensGlobalTables.GetTable("BittensUtilities")
if u.SkipOrUpgrade(u, "Options Panels", 5) then
	return
end

local _G = _G
local CreateFrame = CreateFrame
local InterfaceOptions_AddCategory = InterfaceOptions_AddCategory
local InterfaceOptionsFrame = InterfaceOptionsFrame
local InterfaceOptionsFrame_OpenToCategory = InterfaceOptionsFrame_OpenToCategory
local InterfaceOptionsFrame_Show = InterfaceOptionsFrame_Show
local InterfaceOptionsFrameCancel_OnClick = InterfaceOptionsFrameCancel_OnClick
local UIDropDownMenu_AddButton = UIDropDownMenu_AddButton
local UIDropDownMenu_CreateInfo = UIDropDownMenu_CreateInfo
local UIDropDownMenu_Initialize = UIDropDownMenu_Initialize
local UIDropDownMenu_JustifyText = UIDropDownMenu_JustifyText
local UIDropDownMenu_SetButtonWidth = UIDropDownMenu_SetButtonWidth
local UIDropDownMenu_SetText = UIDropDownMenu_SetText
local UIDropDownMenu_SetWidth = UIDropDownMenu_SetWidth
local ipairs = ipairs
local math = math
local print = print
local select = select
local type = type
local wipe = wipe

local function createOption(name, default, frameType, template)
	return {
		Name = name,
		Default = default,
		FrameType = frameType,
		Template = template,
	}
end

function u.CreateCheckBoxOption(name, text, default)
	local option = createOption(
		name, default, "CheckButton", "InterfaceOptionsCheckButtonTemplate")
	option.Text = text
	return option
end

function u.CreateSliderOption(name, text, default, min, max, width)
	local option = createOption(
		name, default, "Slider", "OptionsSliderTemplate")
	option.Text = text
	option.Min = min
	option.Max = max
	option.Width = width
	return option
end

function u.CreateDropdownOption(name, default, width, ...)
	local option = createOption(
		name, default, "Frame", "UIDropDownMenuTemplate")
	option.Width = width
	option.Items = { }
	for i = 1, select("#", ...) do
		local item = select(i, ...)
		if type(item) == "string" then
			item = { Value = item, Text = item }
		end
		option.Items[i] = item
	end
	return option
end

function u.CreateLabel(text, template)
	return {
		Type = "label",
		Text = text,
		Template = template,
	}
end

-- Add the function apply() to the returned panel.  It, along with widgets in
-- the panel, should use/modify the values in panel.Settings.
--
-- You should make missing (nil) values in panel.Settings represent default
-- values.
--
-- If you provide a parent, they will share the same panel.Settings.  Call
-- Initialize() on the parent first, and you can omit the argument when calling
-- it on the children.
function u.CreateOptionsPanel(name, parent)	
	local panel = CreateFrame("Frame")
	panel.name = name
	panel.Children = { }
	if parent then
		panel.parent = parent.name
		panel.Settings = parent.Settings
		panel.Defaults = parent.Defaults
		panel.WidgetBaseName = parent.WidgetBaseName .. name
		panel.ParentPanel = parent
		parent.Children[panel] = true
	else
		panel.Settings = { }
		panel.Defaults = { }
		panel.WidgetBaseName = name
	end
	
	function panel.Initialize(savedSettingsTableName)
		if not parent then
			panel.SavedSettings = u.GetOrMakeTable(_G, savedSettingsTableName)
			u.ShallowCopy(panel.SavedSettings, panel.Settings)
		end
		panel.apply()
	end
	
	function panel.AddWidget(widget, x, y)
		widget:SetPoint("TOPLEFT", x, y)
		return y - widget:GetHeight()
	end
	
	function panel.AddLabel(text, template, x, y)
		local label = panel:CreateFontString(nil, nil, template)
		label:SetText(text)
		return panel.AddWidget(label, x, y)
	end
	
	function panel.Add(option, x, y)
		local widgetName = panel.WidgetBaseName .. option.Name
		local widget = CreateFrame(
			option.FrameType, widgetName, panel, option.Template)
		
		local topPad = 0
		local bottomPad = 0
		if option.Template == "InterfaceOptionsCheckButtonTemplate" then
			_G[widgetName .. "Text"]:SetText(option.Text)
			widget:SetScript("OnClick", function()
				local value = not not widget:GetChecked()
				panel.Settings[option.Name] = value
				panel.apply(option.Name, value)
			end)
		elseif option.Template == "OptionsSliderTemplate" then
			widget:SetWidth(option.Width)
			widget:SetMinMaxValues(option.Min, option.Max)
			_G[widgetName .. 'High']:SetText(option.Max);
			local tmpWidget = _G[widgetName .. 'Low']
			tmpWidget:SetText(option.Min);
			bottomPad = tmpWidget:GetHeight()
			tmpWidget = _G[widgetName .. "Text"]
			tmpWidget:SetText(" ")
			topPad = tmpWidget:GetHeight()
			widget:SetScript("OnValueChanged", function(self, value)
				value = math.floor(value)
				panel.Settings[option.Name] = value
				tmpWidget:SetText(option.Text:format(value))
				panel.apply(option.Name, value)
			end)
		elseif option.Template == "UIDropDownMenuTemplate" then
			UIDropDownMenu_SetWidth(widget, option.Width)
			UIDropDownMenu_SetButtonWidth(widget, option.Width + 15)
			UIDropDownMenu_JustifyText(widget, "LEFT")
			UIDropDownMenu_Initialize(widget, function()
				local selected = panel.GetValue(option)
				for _, item in ipairs(option.Items) do
					local info = UIDropDownMenu_CreateInfo()
					info.text = item.Text
					info.checked = item.Value == selected
					info.func = function()
						panel.Settings[option.Name] = item.Value
						UIDropDownMenu_SetText(widget, item.Text)
						panel.apply(option.Name, item.Value)
					end
					UIDropDownMenu_AddButton(info)
				end
			end)
		else
			print("OptionsPanels.CreateOptionsPanel.Add error: unrecognized option type")
		end
		
		u.GetOrMakeTable(panel, option.Template)[option] = widget
		panel.Defaults[option.Name] = option.Default
		return panel.AddWidget(widget, x, y - topPad) - bottomPad
	end
	
	function panel.AddGroup(label, options, x, y)
		if label then
			y = panel.AddLabel(label, "GameFontNormalLarge", x, y)
		end
		for _, option in ipairs(options) do
			local t = type(option)
			if t == "table" then
				if option.Type == "label" then
					y = panel.AddLabel(option.Text, option.Template, x, y)
				elseif option.Template then
					y = panel.Add(option, x, y)
				else
					y = panel.AddWidget(option, x, y)
				end
			elseif t == "number" then
				y = y - option
			elseif t == "string" then
				y = panel.AddLabel(option, "GameFontNormal", x, y)
			else
				print("OptionsPanels.CreateOptionsPanel.AddGroup error: unrecognized option type:", type)
			end
		end
		return y
	end
	
	function panel.GetValue(option)
		if type(option) == "table" then
			option = option.Name
		end
		local value = panel.Settings[option]
		if value == nil then
			return panel.Defaults[option]
		else
			return value
		end
	end
	
	function panel.default()
		wipe(panel.Settings)
		local parent = panel
		while parent.ParentPanel do
			parent = parent.ParentPanel
		end
		local function updateAll(p)
			p.apply()
			p.refresh()
			for child in u.Keys(p.Children) do
				updateAll(child)
			end
		end
		updateAll(parent)
	end
	
	function panel.refresh()
		for option, checkBox in 
			u.Pairs(panel.InterfaceOptionsCheckButtonTemplate) do
			
			checkBox:SetChecked(panel.GetValue(option))
		end
		for option, slider in u.Pairs(panel.OptionsSliderTemplate) do
			slider:SetValue(panel.GetValue(option))
		end
		for option, dropdown in u.Pairs(panel.UIDropDownMenuTemplate) do
			local selected = panel.GetValue(option)
			for item in u.Values(option.Items) do
				if item.Value == selected then
					UIDropDownMenu_SetText(dropdown, item.Text)
				end
			end
		end
	end
	
	function panel.okay()
		if not parent then
			u.ShallowCopy(panel.Settings, panel.SavedSettings)
		end
		panel.apply()
	end
	
	function panel.cancel()
		if not parent then
			u.ShallowCopy(panel.SavedSettings, panel.Settings)
		end
		panel.apply()
	end
	
	InterfaceOptions_AddCategory(panel)
	return panel
end

function u.ToggleOptionsPanel(panel)
	if not InterfaceOptionsFrame:IsVisible() then
		InterfaceOptionsFrame_Show()
		InterfaceOptionsFrame_OpenToCategory(panel)
	elseif panel:IsVisible() then
		InterfaceOptionsFrameCancel_OnClick()
	else
		InterfaceOptionsFrame_OpenToCategory(panel)
	end
end
