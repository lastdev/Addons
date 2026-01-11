local addonName, addon = ...
local LibStub = addon.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale("TLDRMissions")

function addon.BaseGUIMixin:clearReportText(includeFailed)
    if includeFailed then
        self.FailedCalcLabel:SetText()
    end
    self.NextMissionLabel:SetText()
    for i = 1, 3 do
        self["NextFollower"..i.."Label"]:SetText()
    end
    self.RewardsDetailLabel:SetText()
    self.LowTimeWarningLabel:SetText()
end

function addon.BaseGUIMixin:updateRewardText(missionID)
    local text = ""
    local rewards = C_Garrison.GetMissionRewardInfo(missionID)
    if rewards then
        for _, reward in pairs(rewards) do
            if reward.currencyID and (reward.currencyID == 0) then
                text = text..GetCoinTextureString(reward.quantity).."; "
            elseif reward.followerXP then
                text = text..reward.followerXP.." "..L["BonusFollowerXP"].."; "
            elseif reward.itemID then
                local _, itemLink = addon:GetItemInfo(reward.itemID)
                itemLink = itemLink or "[item: "..reward.itemID.."]"
                text = text..itemLink.." x"..reward.quantity.."; "
            elseif reward.currencyID and (reward.currencyID ~= 0) then
                local info = C_CurrencyInfo.GetCurrencyInfo(reward.currencyID)
                text = text..info.name.." x"..reward.quantity.."; "
            end
        end
    end
    self.RewardsDetailLabel:SetText(text)
end