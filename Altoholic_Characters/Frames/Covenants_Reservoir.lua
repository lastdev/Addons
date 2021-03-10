local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local currentCovenantID

local BORDER_TEXTURE = "CovenantSanctum-Icon-Border-%s"

addon:Controller("AltoholicUI.ReservoirPanel", {
	Update = function(frame)
		frame:Hide()
		
		local character = addon.Tabs.Characters:GetAltKey()
		if not character then return end
		
		AltoholicTabCharacters.Status:SetText(format("%s|r / %s", DataStore:GetColoredCharacterName(character), COVENANT_SANCTUM_TAB_UPGRADES))
		
		local covenantID, _, renownLevel =  DataStore:GetCovenantInfo(character)
		if covenantID == 0 then return end		-- 0 if no covenant has been chosen yet

		currentCovenantID = covenantID
		
		frame.TravelUpgrade:Update(character, covenantID, Enum.GarrTalentFeatureType.TravelPortals)
		frame.DiversionUpgrade:Update(character, covenantID, Enum.GarrTalentFeatureType.AnimaDiversion)
		frame.AdventureUpgrade:Update(character, covenantID, Enum.GarrTalentFeatureType.Adventures)
		frame.UniqueUpgrade:Update(character, covenantID, Enum.GarrTalentFeatureType.SanctumUnique)
	
		frame:Show()
	end,
})
