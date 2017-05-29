local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local function _SetMember(frame, playerName, color, isHeader)
	if isHeader then
		frame.Collapse:Show()
		frame.Name:SetPoint("TOPLEFT", 20, 0)
	else
		frame.Collapse:Hide()
		frame.Name:SetPoint("TOPLEFT", 10, 0)
	end

	frame.Name.Text:SetText(format("%s%s", color, playerName))
	frame.CharName = playerName
end

local function _SetMemberInfo(frame, level, averageItemLvl, version, class)
	frame.Level:SetText(format("%s%s", colors.green, level))
	if averageItemLvl then
		frame.AvgILevel.Text:SetText(format("%s%.1f", colors.yellow, averageItemLvl))
	else
		frame.AvgILevel.Text:SetText("")
	end
	frame.Version:SetText(format("%s%s", colors.white, version))
	frame.Class:SetText(class)
end

local function _Collapse_OnClick(frame)
	local rowID = frame:GetID()
	frame:GetParent():TogglePlayerAlts(rowID)
end

local function _Name_OnEnter(frame)
	local member = frame.CharName
	if not member then return end

	local name, rank, rankIndex, _, _, zone, note, officerNote, _, _, englishClass = DataStore:GetGuildMemberInfo(member)
	if name ~= member then return end
  
	local tooltip = AltoTooltip
	
	tooltip:ClearLines()
	tooltip:SetOwner(frame.Name, "ANCHOR_RIGHT")
	tooltip:AddLine(format("%s%s", DataStore:GetClassColor(englishClass), member),1,1,1)
	tooltip:AddLine(format("%s%s|r %d%s (%d)", colors.white, RANK_COLON, rank, colors.green, rankIndex))
	
	if zone then
		tooltip:AddLine(format("%s%s|r %s", colors.white, ZONE_COLON, zone))
	end
	
	if note then
		tooltip:AddLine(" ",1,1,1)
		tooltip:AddLine(format("%s%s:", colors.white, NOTE))
		tooltip:AddLine(note)
	end
	
	if officerNote then
		tooltip:AddLine(" ",1,1,1)
		tooltip:AddLine(format("%s%s:", colors.white, GUILD_OFFICER_NOTE))
		tooltip:AddLine(officerNote)
	end

	tooltip:Show()
end

local function _Level_OnEnter(frame)
	local member = frame.CharName
	if member == L["Offline Members"] then return end
	
	local _, _, _, _, _, _, _, _, _, _, englishClass = DataStore:GetGuildMemberInfo(member)
	local guild = DataStore:GetGuild()
	local averageItemLvl = DataStore:GetGuildMemberAverageItemLevel(guild, member) or 0
	
	local tooltip = AltoTooltip
	
	tooltip:ClearLines()
	tooltip:SetOwner(frame, "ANCHOR_RIGHT")
	tooltip:AddLine(format("%s%s", DataStore:GetClassColor(englishClass), member), 1, 1, 1)
	tooltip:AddLine(format("%s%s: %s%s", colors.white, L["COLUMN_ILEVEL_TITLE"], colors.green, format("%.1f", averageItemLvl)), 1, 1, 1)

	addon:AiLTooltip()
	tooltip:AddLine(" ", 1, 1, 1)
	tooltip:AddLine(format("%s%s", colors.green, L["Left-click to see this character's equipment"]), 1, 1, 1)
	tooltip:Show()
end

local function _Level_OnClick(frame, button)
	if button ~= "LeftButton" then return end

	local rowID = frame:GetID()
	frame:GetParent():ShowPlayerEquipment(rowID, frame.CharName)
end

addon:RegisterClassExtensions("AltoGuildMemberRow", {
	SetMember = _SetMember,
	SetMemberInfo = _SetMemberInfo,
	Collapse_OnClick = _Collapse_OnClick,
	Name_OnEnter = _Name_OnEnter,
	Level_OnEnter = _Level_OnEnter,
	Level_OnClick = _Level_OnClick,
})
