assert(_G.UnifiedTankFrames, "UnifiedTankFrames not found!")
local UnifiedTankFrames = _G.UnifiedTankFrames

local g_sources = _G.UnifiedTankFrames_Sources

local L = {}
L["addonName"] = "UnifiedTankFrames"
L["addonDescription"] = "Shows a list of tank frames combined from Blizzard, oRA3, oRA2 and CTRA. No matter in what way tanks are set, you will see them!"
L["frameConfig"] = "Frame Settings"
L["frameConfigDescription"] = "Changes the appearance of the tank frames. "..RED_FONT_COLOR_CODE.."You have to reload your UI or relog for some changes to take effect!"..FONT_COLOR_CODE_CLOSE
L["sourcesLabel"] = "Available Tank Sources:"
L["settingsLabel"] = "Available Frame Settings:"
L["showLabel"] = "Show Tank Frames:"
L["showWhenSolo"] = "When Solo"
L["showWhenSoloTooltip"] = "Only useful in combination with tank source \"Show Yourself\"!"
L["showInRaid"] = "In Raid"
L["showInParty"] = "In Party"
L["showRaidPartyTooltip"] = "Notice: Not all tank types are available in party!"
L["printInfo"] = "Print information messages"
L["printInfoDesc"] = "e.g. when tanks are added or removed and by which module."
L["general"] = "General Settings:"

local function round(num, dec)
	local m = 10^(dec or 0)
	return math.floor(num * m + 0.5) / m
end

local panels = {}
local interfaceLoaded = false

local function CreateCheckbox(parent, name, cfgDB, cfgValue, label, tooltip, func)
	if name == nil then
		name = cfgValue
	end
	local check = CreateFrame("CheckButton", "UnifiedTankFramesConfig"..name.."CheckBox", parent, "InterfaceOptionsCheckButtonTemplate")
	check.name = name
	check.func = func
	check.cfgDB = cfgDB
	check:SetScript("OnClick", function(self)
		local checked = self:GetChecked()
		PlaySound(checked and SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON or SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
		if checked then
			self.cfgDB[self.cfgValue] = true
			if self.func then self.func(self, true) end
		else
			self.cfgDB[self.cfgValue] = false
			if self.func then self.func(self, false) end
		end
	end)
	check.label = _G[check:GetName() .. "Text"]
	check.label:SetText(label)
	check:SetChecked(cfgDB[cfgValue])
	check.cfgValue = cfgValue
	if tooltip then
		check:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetText(tooltip)
			GameTooltip:Show()
		end)
		check:SetScript("OnLeave", function(self)
			GameTooltip:Hide()
		end)
	end
	return check
end

local function CreateSlider(parent, name, cfgDB, cfgValue, minValue, maxValue, step, tooltip, func)
	if name == nil then
		name = cfgValue
	end
	local slider = CreateFrame("Slider", "UnifiedTankFramesConfig"..name.."Slider", parent, "OptionsSliderTemplate")
	local name = slider:GetName()
	local value = cfgDB[cfgValue]
	slider.name = name
	slider.cfgDB = cfgDB
	slider.valueText = _G[name.."Text"]
	_G[name.."Low"]:SetText(tostring(minValue))
	_G[name.."High"]:SetText(tostring(maxValue))
	slider.valueText:SetText(value)
	slider:SetMinMaxValues(minValue, maxValue)
	slider:SetValue(value)
	slider:SetValueStep(step)
	slider.cfgValue = cfgValue
	slider.func = func
	slider.oldValue = value
	slider:SetScript("OnValueChanged", function(self, value)
		local v = round(value, 2)
		if slider.oldValue ~= v then
			self.cfgDB[self.cfgValue] = v
			self.valueText:SetText(v)
			if self.func then self.func(self, value) end
			slider.oldValue = v
		end
	end)
	slider:SetScript("OnMouseWheel", function(self, arg1)
		local step = self:GetValueStep() * arg1
		local value = self:GetValue()
		local minVal, maxVal = self:GetMinMaxValues()
		if step > 0 then
			self:SetValue(min(value+step, maxVal))
		else
			self:SetValue(max(value+step, minVal))
		end
	end)
	if tooltip then
		slider:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetText(tooltip)
			GameTooltip:Show()
		end)
		slider:SetScript("OnLeave", function(self)
			GameTooltip:Hide()
		end)
	end
	return slider
end

local function EnableSlider(name, enabled)
	local slider =_G["UnifiedTankFramesConfig"..name.."Slider"]
	if slider then
		if enabled then
			slider:Show()
		else
			slider:Hide()
		end
	end
end

local function _CreateScrollFrame(parent, width, height, content)
	local contentHeight = content:GetHeight()
	
	-- Create the parent frame that will contain the inner scroll child
	local scrollframe = CreateFrame("ScrollFrame", parent)
	
	-- This is a bare-bones frame is used to encapsulate the contents of
	-- the scroll frame.  Each scrollframe can have one scroll child.
	local scrollchild = content --CreateFrame("Frame", scrollframe)
	scrollchild:ClearAllPoints()
	scrollchild:SetParent(scrollframe)
	--scrollchild:SetWidth(width)

	-- Create the slider that will be used to scroll through the results
	local scrollbar = CreateFrame("Slider", nil, scrollframe)

	-- Set up internal textures for the scrollbar, background and thumb texture
	if not scrollbar.bg then
		scrollbar.bg = scrollbar:CreateTexture(nil, "BACKGROUND")
		scrollbar.bg:SetAllPoints(true)
		scrollbar.bg:SetTexture(0, 0, 0, 0.5)
	end

	if not scrollbar.thumb then
		scrollbar.thumb = scrollbar:CreateTexture(nil, "OVERLAY")
		scrollbar.thumb:SetTexture("Interface\\Buttons\\UI-ScrollBar-Knob")
		scrollbar.thumb:SetSize(25, 25)
		scrollbar:SetThumbTexture(scrollbar.thumb)
	end

	-- Size and place the parent frame, and set the scrollchild to be the
	-- frame of font strings we've created
	scrollframe:SetSize(width, height)
	scrollframe:SetPoint("CENTER", UIParent, 0, 0)
	scrollframe:SetScrollChild(scrollchild)
	scrollframe:Show()

	-- Set up the scrollbar to work properly
	local scrollMax = contentHeight - height
	scrollbar:SetOrientation("VERTICAL");
	scrollbar:SetSize(16, height)
	scrollbar:SetPoint("TOPLEFT", scrollframe, "TOPRIGHT", 0, 0)
	scrollbar:SetMinMaxValues(0, scrollMax)
	scrollbar:SetValue(0)
	scrollbar:SetScript("OnValueChanged", function(self)
		scrollframe:SetVerticalScroll(self:GetValue())
	end)

	-- Enable mousewheel scrolling
	scrollframe:EnableMouseWheel(true)
	scrollframe:SetScript("OnMouseWheel", function(self, delta)
		local current = scrollbar:GetValue()

		if IsShiftKeyDown() and (delta > 0) then
			scrollbar:SetValue(0)
		elseif IsShiftKeyDown() and (delta < 0) then
			scrollbar:SetValue(scrollMax)
		elseif (delta < 0) and (current < scrollMax) then
			scrollbar:SetValue(current + 20)
		elseif (delta > 0) and (current > 1) then
			scrollbar:SetValue(current - 20)
		end
	end)
	
	return scrollframe, scrollchild
end

-- ScrollFrame code is heavily adapted form AceGUI-3.0 ScrollFrame widget (Ace3: Copyright (c) 2007, LibTooltip Development Team via Ace3 Style BSD, http://www.wowace.com/addons/ace3/)
local function CreateScrollFrame(parent)
	local scrollframe = CreateFrame("ScrollFrame", nil, parent)
	scrollframe:EnableMouseWheel(true)
	scrollframe.status = { scrollvalue = 0 }
	scrollframe.SetScroll = function(self, value)
		local status = self.status
		local viewheight = self:GetHeight()
		local height = self.content:GetHeight()
		local offset

		if viewheight > height then
			offset = 0
		else
			offset = floor((height - viewheight) / 1000.0 * value)
		end
		self.content:ClearAllPoints()
		self.content:SetPoint("TOPLEFT", 0, offset)
		self.content:SetPoint("TOPRIGHT", 0, offset)
		status.offset = offset
		status.scrollvalue = value
	end
	scrollframe:SetScript("OnMouseWheel",  function(self, value)
		local status = self.status
		local height, viewheight = self:GetHeight(), self.content:GetHeight()
		
		if self.scrollBarShown then
			local diff = height - viewheight
			local delta = 1
			if value < 0 then
				delta = -1
			end
			self.scrollbar:SetValue(min(max(status.scrollvalue + delta*(1000/(diff/45)),0), 1000))
		end
	end)
	scrollframe:SetScript("OnSizeChanged", function(self)
		if self.updateLock then return end
		self.updateLock = true
		local status = self.status
		local height, viewheight = self:GetHeight(), self.content:GetHeight()
		local offset = status.offset or 0
		local curvalue = self.scrollbar:GetValue()
		-- Give us a margin of error of 2 pixels to stop some conditions that i would blame on floating point inaccuracys
		-- No-one is going to miss 2 pixels at the bottom of the frame, anyhow!
		if viewheight < height + 2 then
			if self.scrollBarShown then
				self.scrollBarShown = nil
				self.scrollbar:Hide()
				self.scrollbar:SetValue(0)
				self:SetPoint("BOTTOMRIGHT")
			end
		else
			if not self.scrollBarShown then
				self.scrollBarShown = true
				self.scrollbar:Show()
				self:SetPoint("BOTTOMRIGHT", -24, 4)
			end
			local value = (offset / (viewheight - height) * 1000)
			if value > 1000 then value = 1000 end
			self.scrollbar:SetValue(value)
			self:SetScroll(value)
			if value < 1000 then
				self.content:ClearAllPoints()
				self.content:SetPoint("TOPLEFT", 0, offset)
				self.content:SetPoint("TOPRIGHT", 0, offset)
				status.offset = offset
			end
		end
		self.updateLock = nil
	end)

	local scrollbar = CreateFrame("Slider", parent:GetName().."ScrollBar", scrollframe, "UIPanelScrollBarTemplate")
	scrollframe.scrollbar = scrollbar
	scrollbar:SetPoint("TOPLEFT", scrollframe, "TOPRIGHT", 4, -16)
	scrollbar:SetPoint("BOTTOMLEFT", scrollframe, "BOTTOMRIGHT", 4, 16)
	scrollbar:SetMinMaxValues(0, 1000)
	scrollbar:SetValueStep(1)
	scrollbar:SetValue(0)
	scrollbar:SetWidth(16)
	scrollbar:Hide()
	-- set the script as the last step, so it doesn't fire yet
	scrollbar:SetScript("OnValueChanged", function(self,v) local p = self:GetParent() p:SetScroll(v) end)

	local scrollbg = scrollbar:CreateTexture(nil, "BACKGROUND")
	scrollbg:SetAllPoints(scrollbar)
	scrollbg:SetTexture(0, 0, 0, 0.4)

	-- scroll content
	local content = CreateFrame("Frame", nil, scrollframe)
	scrollframe.content = content
	content:SetPoint("TOPLEFT")
	content:SetPoint("TOPRIGHT")
	content:SetHeight(300)
	scrollframe:SetScrollChild(content)
	scrollframe:SetScroll(0)
	
	return scrollframe, content
end

local function ShowInterfaceOptions(self)
	if interfaceLoaded then return end

	do -- main settings panel
		local frame = panels.main
		local title = frame:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
		title:SetPoint('TOPLEFT', 16, -16)
		title:SetText(L["addonName"])
		
		local desc = frame:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmall')
		desc:SetHeight(24)
		desc:SetPoint('TOPLEFT', title, 'BOTTOMLEFT', 0, -8)
		desc:SetPoint('RIGHT', frame, -32, 0)
		desc:SetNonSpaceWrap(true)
		desc:SetJustifyH('LEFT')
		desc:SetJustifyV('TOP')
		desc:SetText(L["addonDescription"])
		
		local scrollframe, content = CreateScrollFrame(frame)
		scrollframe:SetPoint('TOPLEFT', desc, 'BOTTOMLEFT', -4, -8)
		scrollframe:SetPoint("BOTTOMRIGHT", 0, 4)
		
		local panel = content
		local height = 0
		
		local label = panel:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
		label:SetText(L["sourcesLabel"])
		label:SetHeight(12)
		label:SetPoint('TOPLEFT', 4, 0)
		--label:SetPoint("TOPLEFT", desc, "BOTTOMLEFT", 0, -8)
		height = height + 12
		
		local anchorTo = label
		for name, source in pairs(UnifiedTankFrames.db.sources) do
			if g_sources[name] ~= nil then
				local checkbox = CreateCheckbox(panel, name, source, "enabled", g_sources[name].description, nil, function(self, value)
					local source = g_sources[self.name]
					if source then
						if value then
							source:onEnable(UnifiedTankFrames)
						else
							source:onDisable(UnifiedTankFrames)
						end
					end
				end)
				checkbox:SetPoint("TOPLEFT", anchorTo, "BOTTOMLEFT", 0, -8)
				anchorTo = checkbox
				height = height + 32
				source = g_sources[name]
				if source.config then
					local group = CreateFrame("Frame", nil, panel)
					group:SetWidth(panel:GetWidth())
					group:SetPoint("TOPLEFT", anchorTo, "BOTTOMLEFT", 0, 0)
					local anchorToSub = nil
					local heightGroup = 0
					for key, value in pairs(source.config) do
						local label = key
						if source.L and source.L[key] then
							label = source.L[key]
						end
						local checkbox = CreateCheckbox(group, name..key, source.config, key, label, nil)
						if anchorToSub == nil then
							checkbox:SetPoint("TOPLEFT", 24, 0)
						else
							checkbox:SetPoint("TOPLEFT", anchorToSub, "BOTTOMLEFT", 0, -2)
						end
						heightGroup = heightGroup + 32
						anchorToSub = checkbox
					end
					group:SetHeight(heightGroup)
					anchorTo = group
					height = height + heightGroup + 40
				end
			end
		end
		
		local showIn = panel:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
		showIn:SetText(L["showLabel"])
		showIn:SetHeight(12)
		showIn:SetPoint("TOPLEFT", anchorTo, "BOTTOMLEFT", 0, -8)
		height = height + 12
		local showInRaid = CreateCheckbox(panel, "ShowInRaid", UnifiedTankFrames.db, "showRaid", L["showInRaid"], nil, function(self, value)
			UnifiedTankFrames:UpdateShowState()
		end)
		height = height + 32
		showInRaid:SetPoint("TOPLEFT", showIn, "BOTTOMLEFT", 0, -8)
		local showInParty = CreateCheckbox(panel, "ShowInParty", UnifiedTankFrames.db, "showParty", L["showInParty"], L["showRaidPartyTooltip"], function(self, value)
			UnifiedTankFrames:UpdateShowState()
		end)
		showInParty:SetPoint("TOPLEFT", showInRaid, "BOTTOMLEFT", 0, -8)
		height = height + 32
        local showWhenSolo = CreateCheckbox(panel, "ShowWhenSolo", UnifiedTankFrames.db, "showSolo", L["showWhenSolo"], L["showWhenSoloTooltip"], function(self, value)
			UnifiedTankFrames:UpdateShowState()
		end)
		showWhenSolo:SetPoint("TOPLEFT", showInParty, "BOTTOMLEFT", 0, -8)
		height = height + 32
		
		local general = panel:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
		general:SetText(L["general"])
		general:SetHeight(12)
		general:SetPoint("TOPLEFT", showWhenSolo, "BOTTOMLEFT", 0, -8)
		height = height + 12
		local printInfo = CreateCheckbox(panel, "PrintInfo", UnifiedTankFrames.db, "printInfo", L["printInfo"], L["printInfoDesc"], nil)
		height = height + 32
		printInfo:SetPoint("TOPLEFT", general, "BOTTOMLEFT", 0, -8)
		
		content:SetHeight(height)
		local r = scrollframe:GetScript("OnSizeChanged")
		r(scrollframe)
	end
	
	if UnifiedTankFrames.frames then
		do -- frames settings panel
			local frame = panels.frames
			local title = frame:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
			title:SetPoint('TOPLEFT', 16, -16)
			title:SetText(L["frameConfig"])
			
			local desc = frame:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmall')
			desc:SetHeight(24)
			desc:SetPoint('TOPLEFT', title, 'BOTTOMLEFT', 0, -8)
			desc:SetPoint('RIGHT', frame, -32, 0)
			desc:SetNonSpaceWrap(true)
			desc:SetJustifyH('LEFT')
			desc:SetJustifyV('TOP')
			desc:SetText(L["frameConfigDescription"])
				
			local scrollframe, content = CreateScrollFrame(frame)
			scrollframe:SetPoint('TOPLEFT', desc, 'BOTTOMLEFT', -4, -8)
			scrollframe:SetPoint("BOTTOMRIGHT", 0, 4)
			
			local panel = content
			local height = 0
			
			local label = panel:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
			label:SetText(L["settingsLabel"])
			label:SetHeight(12)
			label:SetPoint('TOPLEFT', 4, 0)
			height = height + 12
			--label:SetPoint("TOPLEFT", desc, "BOTTOMLEFT", 0, -8)
			
			local anchorTo = label
			local db = UnifiedTankFrames.db.frames[UnifiedTankFrames.frames.name]
			for name, option in pairs(UnifiedTankFrames.frames.config) do
				if type(option.default) == "boolean" then
					local checkbox = CreateCheckbox(panel, "FrameConfig"..name, db, name, option.name, option.tooltip, option.func)
					checkbox:SetPoint("TOPLEFT", anchorTo, "BOTTOMLEFT", 0, -8)
					anchorTo = checkbox
					height = height + 32
				elseif type(option.default) == "number" then
					local slider = CreateSlider(panel, "FrameConfig"..name, db, name, option.min, option.max, option.step, option.tooltip, option.func)
					local label = panel:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
					label:SetText(option.name)
					label:SetPoint("TOPLEFT", anchorTo, "BOTTOMLEFT", 0, -8)
					slider:SetPoint("TOPLEFT", label, "BOTTOMLEFT", 0, -12)
					anchorTo = slider
					height = height + 64
				end
			end
			local reload = CreateFrame("Button", "UnifiedTankFramesConfigReloadButton", panel, "UIPanelButtonTemplate")
			reload:SetText("ReloadUI")
			reload:SetScript("OnClick", function() ReloadUI() end)
			reload:SetPoint("TOPLEFT", anchorTo, "BOTTOMLEFT", 0, -12)
			height = height + 48
			
			content:SetHeight(height)
			local r = scrollframe:GetScript("OnSizeChanged")
			r(scrollframe)
		end
	end
	
	interfaceLoaded = true
end

local function RegisterInterfaceOptions()
	if panels.main == nil then
		panels.main = CreateFrame("Frame", "UnifiedTankFramesConfig", InterfaceOptionsFramePanelContainer)
		panels.main.name = L["addonName"]
		panels.main:SetScript("OnShow", ShowInterfaceOptions)
		panels.main:Hide()
		panels.main.cancel = function()
		end
		panels.main.okay  = function()
		end
		if InterfaceOptions_AddCategory then
			InterfaceOptions_AddCategory(panels.main)
		else
			local category, layout = _G.Settings.RegisterCanvasLayoutCategory(panels.main, panels.main.name)
			panels.main.category = category
			_G.Settings.RegisterAddOnCategory(category)
			UnifiedTankFrames.settingsCategoryId = category:GetID()
		end
	end
	if panels.frames == nil then
		panels.frames = CreateFrame("Frame", "UnifiedTankFramesConfigFrameConfig", panels.main)
		panels.frames.name = L["frameConfig"]
		panels.frames:SetScript("OnShow", ShowInterfaceOptions)
		panels.frames.parent = panels.main.name
		panels.frames:Hide()
		if InterfaceOptions_AddCategory then
			InterfaceOptions_AddCategory(panels.frames)
		else
			local category, layout = _G.Settings.RegisterCanvasLayoutSubcategory(panels.main.category, panels.frames, panels.frames.name)
			panels.frames.category = category
		end
	end
end

UnifiedTankFrames.RegisterInterfaceOptions = RegisterInterfaceOptions
