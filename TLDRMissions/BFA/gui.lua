local addonName, addon = ...
local LibStub = addon.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale("TLDRMissions")

addon.BFAGUIMixin = CreateFromMixins(addon.BaseGUIMixin)

function addon.BFAGUIMixin:Init()
    addon.BaseGUIMixin.Init(self)
    
    self:setupRewardCheckbox("BFAResources", C_CurrencyInfo.GetBasicCurrencyInfo(addon.BFAGUI.RESOURCE_CURRENCY_ID).name)
    self:setupRewardCheckbox("ArtifactPower", ARTIFACT_POWER)
    --self:setupRewardCheckbox("FollowerItems", GARRISON_FOLLOWER_ITEMS)
    --self:setupRewardCheckbox("PetCharms", L["PetCharms"])
    self:setupRewardCheckbox("AugmentRunes", L["AugmentRunes"])
    self:setupRewardCheckbox("Reputation", L["ReputationTokens"])
    --self:setupRewardCheckbox("FollowerXP", L["BonusFollowerXP"])
    --self:setupRewardCheckbox("Gear", WORLD_QUEST_REWARD_FILTERS_EQUIPMENT)
    self:setupRewardCheckbox("CraftingReagents", PROFESSIONS_MODIFIED_CRAFTING_REAGENT_BASIC)
    --self:self:setupRewardCheckbox("Archaeology", PROFESSIONS_ARCHAEOLOGY)
    
    self.ProfileTabButton:SetScript("OnClick", function()
        LibStub("AceConfigDialog-3.0"):Open("TLDRMissions-BFA")
    end)
    
    self.SacrificeCheckButton:SetEnabled(false)
    
    self.PrioritiseLethalCheckButton = CreateFrame("CheckButton", "TLDRMissions"..self.followerTypeID.."FramePrioritiseLethalCheckButton", self.AdvancedTabPanel, "UICheckButtonTemplate")
    self.PrioritiseLethalCheckButton:SetPoint("TOPLEFT", self.SkipFullResourcesButton, 0, -25)
    _G["TLDRMissions"..self.followerTypeID.."FramePrioritiseLethalCheckButtonText"]:SetText("Send 'Lethal' missions first (these will kill your troops)")
    
    self.PrioritiseLethalCheckButton:HookScript("OnClick", function()
        self.db.profile.useLethalMissionPriority = self.PrioritiseLethalCheckButton:GetChecked()
    end)
    
    self:InitRewardCheckButtons()
end