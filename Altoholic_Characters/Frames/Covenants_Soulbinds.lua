local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local currentCovenantID

addon:Controller("AltoholicUI.SoulbindsPanel", {
	Update = function(frame)
		frame:Hide()
		
		local character = addon.Tabs.Characters:GetAltKey()
		if not character then return end
		
		AltoholicTabCharacters.Status:SetText(format("%s|r / %s", DataStore:GetColoredCharacterName(character), COVENANT_PREVIEW_SOULBINDS))
		
		local covenantID, _, renownLevel =  DataStore:GetCovenantInfo(character)
		if covenantID == 0 then return end		-- 0 if no covenant has been chosen yet

		currentCovenantID = covenantID
		
		local activeSoulbindID = DataStore:GetActiveSoulbindID(character)
		local covenantData = C_Covenants.GetCovenantData(covenantID)
		
		-- Loop on the soulbinds of this covenant
		local i = 1
		for _, soulbindID in pairs(covenantData.soulbindIDs) do
			frame["Spec" .. i]:Update(character, C_Soulbinds.GetSoulbindData(soulbindID), (activeSoulbindID == soulbindID))
			i = i + 1
		end		
		
		frame:Show()
	end,
})
