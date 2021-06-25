
-- GLOBALS: PlaySound, SlashCmdList, BADBOY_OPTIONS, SLASH_BADBOY1
local L
do
	local _
	_, L = ...
end

--[[ Main Panel ]]--
local badboy = CreateFrame("Frame", "BadBoyConfig", UIParent)
badboy:SetSize(475, 500)
badboy:SetPoint("CENTER")
badboy:SetClampedToScreen(true)
badboy:EnableMouse(true)
badboy:SetMovable(true)
badboy:RegisterForDrag("LeftButton")
badboy:SetScript("OnDragStart", function(self) self:StartMoving() end)
badboy:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
badboy:Hide()
local bg = badboy:CreateTexture()
bg:SetAllPoints(badboy)
bg:SetColorTexture(0, 0, 0, 0.5)
local close = CreateFrame("Button", nil, badboy, "UIPanelCloseButton")
close:SetPoint("TOPRIGHT", badboy, "TOPRIGHT", -5, -5)

local title = badboy:CreateFontString(nil, nil, "GameFontNormalLarge")
title:SetPoint("TOPLEFT", 16, -16)
title:SetText("BadBoy")

--[[ Show spam checkbox ]]--
local btnShowSpam = CreateFrame("CheckButton", nil, badboy, "OptionsBaseCheckButtonTemplate")
btnShowSpam:SetPoint("TOPLEFT", title, "BOTTOMLEFT")
btnShowSpam:SetScript("OnClick", function(frame)
	local tick = frame:GetChecked()
	BADBOY_OPTIONS.tipSpam = tick
	if tick then
		PlaySound(856) -- SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON
	else
		PlaySound(857) -- SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF
	end
end)
btnShowSpam:SetScript("OnShow", function(frame)
	frame:SetChecked(BADBOY_OPTIONS.tipSpam)
end)

local btnShowSpamText = badboy:CreateFontString(nil, nil, "GameFontHighlight")
btnShowSpamText:SetPoint("LEFT", btnShowSpam, "RIGHT", 0, 1)
btnShowSpamText:SetText(L.spamTooltip)

--[[ Disable animation checkbox ]]--
local btnNoAnim = CreateFrame("CheckButton", nil, badboy, "OptionsBaseCheckButtonTemplate")
btnNoAnim:SetPoint("TOPLEFT", btnShowSpam, "BOTTOMLEFT")
btnNoAnim:SetScript("OnClick", function(frame)
	local tick = frame:GetChecked()
	BADBOY_OPTIONS.noAnim = tick
	if tick then
		PlaySound(856) -- SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON
	else
		PlaySound(857) -- SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF
	end
end)
btnNoAnim:SetScript("OnShow", function(frame)
	frame:SetChecked(BADBOY_OPTIONS.noAnim)
end)

local btnNoAnimText = badboy:CreateFontString(nil, nil, "GameFontHighlight")
btnNoAnimText:SetPoint("LEFT", btnNoAnim, "RIGHT", 0, 1)
btnNoAnimText:SetText(L.noAnimate)

--[[ Frequent button checkbox ]]--
local btnFreqButton = CreateFrame("CheckButton", nil, badboy, "OptionsBaseCheckButtonTemplate")
btnFreqButton:SetPoint("TOPLEFT", btnNoAnim, "BOTTOMLEFT")
btnFreqButton:SetScript("OnClick", function(frame)
	local tick = frame:GetChecked()
	BADBOY_OPTIONS.freqBtn = tick
	if tick then
		PlaySound(856) -- SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON
	else
		PlaySound(857) -- SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF
	end
end)
btnFreqButton:SetScript("OnShow", function(frame)
	frame:SetChecked(BADBOY_OPTIONS.freqBtn)
end)
btnFreqButton:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	GameTooltip:AddLine(L.frequentButtonTip, 0.5, 0.5, 0)
	GameTooltip:Show()
end)
btnFreqButton:SetScript("OnLeave", GameTooltip_Hide)

local btnFreqButtonText = badboy:CreateFontString(nil, nil, "GameFontHighlight")
btnFreqButtonText:SetPoint("LEFT", btnFreqButton, "RIGHT", 0, 1)
btnFreqButtonText:SetText(L.frequentButton)

--[[ BadBoy_Levels Title ]]--
local levelsTitle = badboy:CreateFontString("BadBoyLevelsConfigTitle", nil, "GameFontNormalLarge")
levelsTitle:SetPoint("TOPLEFT", btnFreqButton, "BOTTOMLEFT", 0, -3)
levelsTitle:SetText("BadBoy_Levels ["..ADDON_MISSING.."]")

--[[ BadBoy_Guilded Title ]]--
local guildedTitle = badboy:CreateFontString("BadBoyGuildedConfigTitle", nil, "GameFontNormalLarge")
guildedTitle:SetPoint("TOPLEFT", btnFreqButton, "BOTTOMLEFT", 0, -88)
guildedTitle:SetText("BadBoy_Guilded ["..ADDON_MISSING.."]")

--[[ BadBoy_Ignore Title ]]--
local ignoreTitle = badboy:CreateFontString("BadBoyIgnoreConfigTitle", nil, "GameFontNormalLarge")
ignoreTitle:SetPoint("TOPLEFT", btnFreqButton, "BOTTOMLEFT", 0, -156)
ignoreTitle:SetText("BadBoy_Ignore ["..ADDON_MISSING.."]")

--[[ BadBoy_CCleaner Title ]]--
local ccleanerTitle = badboy:CreateFontString("BadBoyCCleanerConfigTitle", nil, "GameFontNormalLarge")
ccleanerTitle:SetPoint("TOPLEFT", btnFreqButton, "BOTTOMLEFT", 0, -206)
ccleanerTitle:SetText("BadBoy_CCleaner ["..ADDON_MISSING.."]")

--[[ Slash Handler ]]--
SlashCmdList["BADBOY"] = function() badboy:Show() end
SLASH_BADBOY1 = "/badboy"
