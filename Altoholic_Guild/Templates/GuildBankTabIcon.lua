local addonName = "Altoholic"
local addon = _G[addonName]

local function _Icon_OnEnter(frame)
	local parent = frame:GetParent()
	local guildKey = parent:GetCurrentGuild()
	
	local tabName = DataStore:GetGuildBankTabName(guildKey, frame:GetID())
	if not tabName then return end

	local tooltip = AltoTooltip
	tooltip:ClearLines()
	tooltip:SetOwner(frame, "ANCHOR_RIGHT")
	tooltip:AddLine(tabName)
	tooltip:Show()
end

local function _Icon_OnClick(frame, button)
	local guildBank = frame:GetParent()
	
	guildBank:SetCurrentBankTab(frame:GetID())
	guildBank:Update()
end

addon:RegisterClassExtensions("AltoGuildBankTabIcon", {
	Icon_OnEnter = _Icon_OnEnter,
	Icon_OnClick = _Icon_OnClick,
})
