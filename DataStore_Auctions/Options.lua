if not DataStore then return end

local addonName = "DataStore_Auctions"
local addon = _G[addonName]
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

function addon:SetupOptions()
	local f = DataStore.Frames.AuctionsOptions
	
	DataStore:AddOptionCategory(f, addonName, "DataStore")

	-- localize options
	f.AutoClearExpiredItems.Text:SetText(L["Automatically clear expired auctions and bids"])
	DataStore:SetCheckBoxTooltip(f.AutoClearExpiredItems, L["CLEAR_ITEMS_TITLE"], L["CLEAR_ITEMS_ENABLED"], L["CLEAR_ITEMS_DISABLED"])
	
	-- restore saved options to gui
	f.AutoClearExpiredItems:SetChecked(DataStore:GetOption(addonName, "AutoClearExpiredItems"))
end
