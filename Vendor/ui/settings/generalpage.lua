local AddonName, Addon = ...
local GeneralPage = {}

local MerchantButton = Addon.MerchantButton
local AUTO_SELL = Addon.c_Config_AutoSell
local TOOLTIP = Addon.c_Config_Tooltip
local AUTO_REPAIR = Addon.c_Config_AutoRepair
local MINIMAP = Addon.c_Config_Minimap
local MERCHANT = Addon.c_Config_MerchantButton
local GUILD_REPAIR = Addon.c_Config_GuildRepair

--[[===========================================================================
   | Called when this panel is loaded 
   ==========================================================================]]
function GeneralPage:OnLoad()
	self.Tooltip.OnChange = function(state)
		Addon:Debug("settings", "General (Tooltip) has changed to: %s", state)
		self:SetProfileValue(TOOLTIP, state == true)
	end

	self.AutoSell.OnChange = function(state)
		Addon:Debug("settings", "General (AutoSell) has changed to: %s", state)
		self:SetProfileValue(AUTO_SELL, state == true)
	end

	self.AutoRepair.OnChange = function(state)
		Addon:Debug("settings", "General (AutoRepair) has changed to: %s", state)
		if (state) then
			self:SetProfileValue(AUTO_REPAIR, true)
			self:SetProfileValue(GUILD_REPAIR, true)
		else
			self:SetProfileValue(AUTO_REPAIR, false)
		end		
	end

	self.MiniMap.OnChange = function(state)
		Addon:Debug("settings", "General (MiniMap) has changed to: %s", state)
		self:SetProfileValue(MINIMAP, state == true)
	end

	self.Merchant.OnChange = function(state)
		Addon:Debug("settings", "General (Merchant) has changed to: %s", state)
		self:SetProfileValue(MERCHANT, state == true)
	end

	self.MiniMap:Disable()
	self.MiniMap:SetChecked(true)

	if (not Addon.IsClassic) then
		local merchantNew = CreateFrame("Frame", nil,  self, "NewFeatureLabelTemplate")
		merchantNew:SetPoint("TOPRIGHT", self.Merchant, "TOPRIGHT", -16, -10)
		merchantNew:Show()

		local miniNew = CreateFrame("Frame", nil,  self, "NewFeatureLabelTemplate")
		miniNew:SetPoint("TOPRIGHT", self.MiniMap, "TOPRIGHT", -16, -10)
		miniNew:Show()
	end
end

--[[===========================================================================
   | Called when this page is shown
   ==========================================================================]]
function GeneralPage:OnShow()
	local autoSell, tooltip, autoRepair, miniMap, merchant =
		self:GetProfileValues(AUTO_SELL, TOOLTIP, AUTO_REPAIR, MINIMAP, MERCHANT)
	
	self.AutoSell:SetChecked(autoSell)
	self.Tooltip:SetChecked(tooltip)
	self.AutoRepair:SetChecked(autoRepair)
	self.MiniMap:SetChecked(true)
	self.Merchant:SetChecked(merchant)	
end

Addon.Settings = Addon.Settings or {}
Addon.Settings.General = Mixin(GeneralPage, Addon.UseProfile)