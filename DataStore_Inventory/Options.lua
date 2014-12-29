if not DataStore then return end

local addonName = "DataStore_Inventory"
local addon = _G[addonName]
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

function addon:SetupOptions()
	local f = DataStore.Frames.InventoryOptions
	
	DataStore:AddOptionCategory(f, addonName, "DataStore")

	-- localize options
	f.AutoClearGuildInventory.Text:SetText(L["CLEAR_INVENTORY_TEXT"])
	f.BroadcastAiL.Text:SetText(L["BROADCAST_AIL_TEXT"])
	f.EquipmentRequestNotification.Text:SetText(L["EQUIP_REQ_TEXT"])
	
	DataStore:SetCheckBoxTooltip(f.AutoClearGuildInventory, L["CLEAR_INVENTORY_TITLE"], L["CLEAR_INVENTORY_ENABLED"], L["CLEAR_INVENTORY_DISABLED"])
	DataStore:SetCheckBoxTooltip(f.BroadcastAiL, L["BROADCAST_AIL_TITLE"], L["BROADCAST_AIL_ENABLED"], L["BROADCAST_AIL_DISABLED"])
	DataStore:SetCheckBoxTooltip(f.EquipmentRequestNotification, L["EQUIP_REQ_TITLE"], L["EQUIP_REQ_ENABLED"], L["EQUIP_REQ_DISABLED"])
	
	-- restore saved options to gui
	f.AutoClearGuildInventory:SetChecked(DataStore:GetOption(addonName, "AutoClearGuildInventory"))
	f.BroadcastAiL:SetChecked(DataStore:GetOption(addonName, "BroadcastAiL"))
	f.EquipmentRequestNotification:SetChecked(DataStore:GetOption(addonName, "EquipmentRequestNotification"))
end
