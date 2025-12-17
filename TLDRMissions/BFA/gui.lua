local addonName, addon = ...
local LibStub = addon.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale("TLDRMissions")

addon.BFAGUIMixin = CreateFromMixins(addon.BaseGUIMixin)

function addon.BFAGUIMixin:Init()
    addon.BaseGUIMixin.Init(self)
    
    self:setupRewardCheckbox("BFAResources", C_CurrencyInfo.GetBasicCurrencyInfo(addon.BFAGUI.RESOURCE_CURRENCY_ID).name)
    self:setupRewardCheckbox("ArtifactPower", ARTIFACT_POWER)
    --setupButton("FollowerItems", GARRISON_FOLLOWER_ITEMS)
    --setupButton("PetCharms", L["PetCharms"])
    --setupButton("AugmentRunes", gui.PetCharmsCheckButton, L["AugmentRunes"], gui.PetCharmsAnimaCostDropDown)
    self:setupRewardCheckbox("Reputation", L["ReputationTokens"])
    --setupButton("FollowerXP", L["BonusFollowerXP"])
    --setupButton("Gear", WORLD_QUEST_REWARD_FILTERS_EQUIPMENT)
    --setupButton("CraftingReagents", PROFESSIONS_MODIFIED_CRAFTING_REAGENT_BASIC)
    --setupButton("Oil", "Oil")
    --setupButton("Archaeology", PROFESSIONS_ARCHAEOLOGY)
    
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