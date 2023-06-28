local _, T = ...

local tn, suf = "NotGameTooltip", 0
while _G[tn] do
	tn, suf = tn .. suf, suf + 1
end
local tip = CreateFrame("GameTooltip", tn, UIParent, "GameTooltipTemplate") do
	tip.supportsDataRefresh = true
	tip:SetScript("OnEvent", tip.OnEvent)
	tip:SetScript("OnHide", GameTooltip_OnHide)
	tip:HookScript("OnHide", function(self)
		for i=1, 2 do
			local st = self.shoppingTooltips[i]
			if st:IsOwned(self) then
				st:Hide()
			end
		end
	end)
	tip:OnLoad()
	tip.shoppingTooltips = {
		CreateFrame("GameTooltip", tn .. "!Shop1", UIParent, "ShoppingTooltipTemplate"),
		CreateFrame("GameTooltip", tn .. "!Shop2", UIParent, "ShoppingTooltipTemplate"),
	}
	tip.shoppingTooltips[1]:Hide()
	tip.shoppingTooltips[2]:Hide()
	local skipHide
	tip:SetScript("OnShow", function(self)
		if GameTooltip:IsForbidden() then
			return
		end
		skipHide = true
		GameTooltip:SetOwner(self, "ANCHOR_NONE")
		GameTooltip:SetText(" ")
		GameTooltip:Hide()
		-- GameTooltip's OnShow is deferred, so skipHide can't be cleared here
	end)
	local tw = CreateFrame("Frame", nil, GameTooltip)
	tw:SetScript("OnShow", function()
		if skipHide then
			skipHide = false
		else
			tip:Hide()
		end
	end)
end

T.NotGameTooltip = tip