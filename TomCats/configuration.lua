--[[ See license.txt for license and copyright information ]]
local _, addon = ...

local CreateFrame = CreateFrame
local BlizzardOptionsPanel_OnLoad = BlizzardOptionsPanel_OnLoad
local BlizzardOptionsPanel_RegisterControl = BlizzardOptionsPanel_RegisterControl
local InterfaceAddOnsList_Update = InterfaceAddOnsList_Update
local InterfaceOptions_AddCategory = InterfaceOptions_AddCategory
local InterfaceOptionsPanel_Cancel = InterfaceOptionsPanel_Cancel
local InterfaceOptionsPanel_Default = InterfaceOptionsPanel_Default
local InterfaceOptionsPanel_Refresh = InterfaceOptionsPanel_Refresh
local CONTROLTYPE_CHECKBOX = CONTROLTYPE_CHECKBOX
local UIParent = UIParent

local function Config_Okay(self)
	for _, v in ipairs(self.controls) do
		if (v.okay) then v:okay() end
	end
end

local function OnHyperlinkClick(self, link)
	link = "https://" .. link
	if (self.popup:IsShown() and link == self.popup.text) then
		self.popup:Hide()
		return
	end
	self.popup.text = link
	self.popup.info:SetText("Press Control-C to copy the link")
	self.popup.editbox:SetText(self.popup.text)
	self.popup.editbox:HighlightText()
	self.popup:SetFrameStrata("TOOLTIP")
	self.popup:Show()
end

local function OnHyperlinkEnter(self, link, _, fontString)
	self.linksHighlight = self.linksHighlight or self:CreateFontString()
	self.links = fontString
	self.linksHighlight:ClearAllPoints()
	self.linksHighlight:SetFont(self.links:GetFont())
	local text = self.links:GetText()
	text = string.gsub(text, "(|H.-|h)", "")
	text = string.gsub(text, "(|h)", "")
	text = string.gsub(text, link, "|cFFFFD100" .. link .. "|r")
	self.linksHighlight:SetText(text)
	self.linksHighlight:Show()
	for i = 1, self.links:GetNumPoints() do
		self.linksHighlight:SetPoint(self.links:GetPoint(i))
	end
	self.linksHighlight:SetSpacing(self.links:GetSpacing())
	self.linksHighlight:SetJustifyH(self.links:GetJustifyH())
	self.linksHighlight:SetShadowOffset(self.links:GetShadowOffset())
	self.linksHighlight:SetSize(self.links:GetSize())
	self.links:SetAlpha(0.1)
end

local function OnHyperlinkLeave(self)
	self.linksHighlight:Hide()
	self.links:SetAlpha(1.0)
end

do
	local configFrame = CreateFrame("FRAME", "TomCats_Config", UIParent, "TomCats_ConfigTemplate")
	configFrame.name = "TomCat's Tours"
	configFrame.controls = { }
	configFrame.Header.Text:SetFont(configFrame.Header.Text:GetFont(), 64)
	local checkBox_minimapButton = configFrame.checkBox_minimapButton
	checkBox_minimapButton.type = CONTROLTYPE_CHECKBOX
	checkBox_minimapButton.Text:SetText("Show \"TomCat's Tours\" Minimap Button")
	local function setTooltipText(value)
		if (value == "1") then
			checkBox_minimapButton.tooltipText = "Deselect to hide the main \"TomCat's Tours\" minimap button"
		else
			checkBox_minimapButton.tooltipText = "Select to show the main \"TomCat's Tours\" minimap button"
		end
	end
	setTooltipText("1")
	checkBox_minimapButton.defaultValue = "1"
	checkBox_minimapButton.GetValue = function()
		local minimapButtonPrefs = TomCats_Account.preferences["TomCats-MinimapButton"]
		local currentValue = minimapButtonPrefs and minimapButtonPrefs.hidden and "0" or "1"
		setTooltipText(currentValue)
		return currentValue
	end
	checkBox_minimapButton.SetValue = function(_, value)
		setTooltipText(value)
	end
	checkBox_minimapButton.okay = function()
		addon.minimapButton:SetEnabled(checkBox_minimapButton.value == "1")
	end
	BlizzardOptionsPanel_RegisterControl(checkBox_minimapButton, configFrame)

	local checkBox_betaFeatures = configFrame.checkBox_betaFeatures
	checkBox_betaFeatures.type = CONTROLTYPE_CHECKBOX
	checkBox_betaFeatures.Text:SetText("Enable the Beta Features")
	local function setTooltipText1(value)
		if (value == "1") then
			checkBox_betaFeatures.tooltipText = "Deselect to disable the beta features"
		else
			checkBox_betaFeatures.tooltipText = "Select to enable the beta features"
		end
	end
	setTooltipText1("0")
	checkBox_betaFeatures.defaultValue = "0"
	checkBox_betaFeatures.GetValue = function()
		local enableBeta = addon.IsBetaEnabled and addon.IsBetaEnabled()
		local currentValue = enableBeta and "1" or "0"
		setTooltipText1(currentValue)
		return currentValue
	end
	checkBox_betaFeatures.SetValue = function(_, value)
		setTooltipText1(value)
	end
	checkBox_betaFeatures.okay = function()
		addon.SetBetaEnabled(checkBox_betaFeatures.value == "1")
	end
	BlizzardOptionsPanel_RegisterControl(checkBox_betaFeatures, configFrame)

	configFrame.html1:SetScript("OnHyperlinkClick", OnHyperlinkClick)
	configFrame.html1:SetScript("OnHyperlinkEnter", OnHyperlinkEnter)
	configFrame.html1:SetScript("OnHyperlinkLeave", OnHyperlinkLeave)
	BlizzardOptionsPanel_OnLoad(
			configFrame,
			Config_Okay,
			InterfaceOptionsPanel_Cancel,
			InterfaceOptionsPanel_Default,
			InterfaceOptionsPanel_Refresh
	)
	InterfaceOptions_AddCategory(configFrame)
	InterfaceAddOnsList_Update()
end
