local addonName = "Altoholic"
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local STAT_PRIO = 1
local STAT_UNKNOWN = 2
local NUM_TALENT_TIERS = 7

local function _Update(frame, character, class, specializationIndex)
	local _, specName = DataStore:GetSpecializationInfo(class, specializationIndex)
	
	if specName then
		for tier = 1, NUM_TALENT_TIERS do
			frame["Tier"..tier]:Update(character, class, specializationIndex)
		end
		frame.tooltip = STAT_PRIO
		frame.class = class
		frame.spec = specializationIndex
	else
		for tier = 1, NUM_TALENT_TIERS do
			frame["Tier"..tier]:Hide()
		end
		frame.tooltip = STAT_UNKNOWN
	end
	
	frame.SpecInfo.Name:SetText(specName or "?")
	frame:Show()
end

local function _SpecInfo_OnEnter(frame, button)
	
	if frame.tooltip == STAT_PRIO then
		AltoTooltip:ClearLines()
		AltoTooltip:SetOwner(button, "ANCHOR_TOP")
		AltoTooltip:AddLine(L["TALENT_SPECIALIZATION_STAT_PRIORITY"], 0, 1, 0)
		AltoTooltip:AddLine(" ", 1, 1, 1)
		for i, priority in pairs(DataStore:GetStatPriority(frame.class, frame.spec)) do
			AltoTooltip:AddLine(format("%s%d. %s%s", addon.Colors.cyan, i, addon.Colors.white, priority), 1, 1, 1)
		end

		AltoTooltip:AddLine(" ", 1, 1, 1)
		AltoTooltip:AddLine("Source: Icy Veins (7.0)", 1, 1, 0)
		AltoTooltip:Show()
		
	elseif frame.tooltip == STAT_UNKNOWN then
		AltoTooltip:ClearLines()
		AltoTooltip:SetOwner(button, "ANCHOR_TOP")
		AltoTooltip:AddLine(format("%s%s", addon.Colors.white, L["TALENT_SPECIALIZATION_UNKOWN"]), 1, 1, 1)
		AltoTooltip:Show()
	end

end

addon:RegisterClassExtensions("AltoTalentSpecialization", {
	Update = _Update,
	SpecInfo_OnEnter = _SpecInfo_OnEnter,
})
