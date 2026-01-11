local addonName, addon = ...
local LibStub = addon.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale("TLDRMissions")

addon.WODGUIMixin = CreateFromMixins(addon.BaseGUIMixin)

local interfaceVersion = select(4, GetBuildInfo())
if (interfaceVersion >= 50000) and (interfaceVersion < 60000) then
    addon.isWOD = true
end

function addon.WODGUIMixin:Init()
    addon.BaseGUIMixin.Init(self)
    
    if addon.isWOD then
        self:setupRewardCheckbox("Gold", BONUS_ROLL_REWARD_MONEY)
    end
    
    self:setupRewardCheckbox("GarrisonResources", C_CurrencyInfo.GetBasicCurrencyInfo(824).name)
    self:setupRewardCheckbox("FollowerItems", GARRISON_FOLLOWER_ITEMS)
    self:setupRewardCheckbox("PetCharms", L["PetCharms"])
    self:setupRewardCheckbox("FollowerXP", L["BonusFollowerXP"])
    self:setupRewardCheckbox("Gear", WORLD_QUEST_REWARD_FILTERS_EQUIPMENT)
    self:setupRewardCheckbox("Apexis", "Apexis Crystal")
    self:setupRewardCheckbox("Oil", "Oil")
    self:setupRewardCheckbox("Seal", "Seal of Tempered Fate")
    self:setupRewardCheckbox("Archaeology", PROFESSIONS_ARCHAEOLOGY)
    
    self.ProfileTabButton:SetScript("OnClick", function()
        LibStub("AceConfigDialog-3.0"):Open("TLDRMissions-WOD")
    end)

    self.SacrificeCheckButton:SetEnabled(false)
    
    self:InitRewardCheckButtons()
end