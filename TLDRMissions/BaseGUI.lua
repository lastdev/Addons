local addonName, addon = ...
local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")
local LibStub = addon.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale("TLDRMissions")
LibStub("AceAddon-3.0"):NewAddon("TLDRMissions-AceEvent", "AceEvent-3.0")

function addon.BaseGUIMixin:InitTLDRButton()
    local tldrButton = CreateFrame("Button", "TLDRMissions"..self.followerTypeID.."ToggleButton", self.missionFrame, "UIPanelButtonTemplate")
    tldrButton:SetText("TL;DR")
    tldrButton:SetWidth(80)
    tldrButton:SetHeight(25)
    _G["TLDRMissions"..self.followerTypeID.."ToggleButtonText"]:SetScale(1.3)
    tldrButton:Hide()
    tldrButton:SetPoint("TOPLEFT", self.missionFrame, "TOPLEFT", 150, 0)
    
    tldrButton:SetScript("OnClick", function()
        self:SetShown(not self:IsShown())
        self:SetParent(self.missionFrame)
    end)
end

function addon.BaseGUIMixin:setupRewardCheckbox(categoryName, text)
    -- TLDRMissions1FrameResourcesRow
    local row = CreateFrame("Frame", "TLDRMissions"..self.followerTypeID.."Frame"..categoryName.."Row", self.MainTabPanel)
    row:SetPoint("TOPLEFT", self.TitleBarTexture, "BOTTOMLEFT", 50, -5 - (22 * self.numRewardCheckboxes))
    self.numRewardCheckboxes = self.numRewardCheckboxes + 1
    row.index = self.numRewardCheckboxes
    row:SetSize(200, 20)
    row:SetMovable(true)
    row:EnableMouse(true)
    row:RegisterForDrag("LeftButton")
    row:SetScript("OnDragStart", function(self, button)
    	self:StartMoving()
    end)
    row:SetScript("OnDragStop", function(self)
    	self:StopMovingOrSizing()
    end)
    row:SetFrameStrata("LOW")
    row:SetFrameLevel(3)
    
    row.Border = row:CreateTexture(nil, "BORDER")
    row.Border:SetAllPoints()
    row.Border:SetAtlas("GarrMission-FollowerItemBg")
    
    row.Background = row:CreateTexture(nil, "BACKGROUND")
    row.Background:SetAllPoints()
    row.Background:SetColorTexture(0.25, 0.25, 0.25, 0.7)
    

    local checkButton = CreateFrame("CheckButton", "TLDRMissions"..self.followerTypeID.."Frame"..categoryName.."CheckButton", self.MainTabPanel, "UICheckButtonTemplate")
    self[categoryName.."CheckButton"] = checkButton
    checkButton:SetPoint("TOPLEFT", row, -28, 5)
    _G["TLDRMissions"..self.followerTypeID.."Frame"..categoryName.."CheckButtonText"]:SetText(text)
    _G["TLDRMissions"..self.followerTypeID.."Frame"..categoryName.."CheckButtonText"]:SetDrawLayer("OVERLAY")
    
    checkButton.ExclusionLabel = checkButton:CreateFontString("TLDRMissions"..self.followerTypeID..""..categoryName.."ExclusionLabel", "OVERLAY", "GameFontNormalLarge")
    checkButton.ExclusionLabel:SetText("X")
    checkButton.ExclusionLabel:SetPoint("CENTER", checkButton, "CENTER", 0, 0)
    checkButton.ExclusionLabel:SetTextColor(1, 0, 0)
    checkButton.ExclusionLabel:Hide()

    local plname = categoryName.."PriorityLabel"
    self[plname] = self.MainTabPanel:CreateFontString("TLDRMissions"..self.followerTypeID..""..categoryName.."PriorityLabel", "OVERLAY", "GameFontNormal")
    self[plname]:SetPoint("TOPLEFT", checkButton, -15, -10)

    local resourceCostName = categoryName.."ResourceCostDropDown"
    self[resourceCostName] = LibDD:Create_UIDropDownMenu("TLDRMissions"..self.followerTypeID..""..categoryName.."ResourceCostDropDown", self.MainTabPanel)
    self[resourceCostName]:SetPoint("TOPLEFT", row, "TOPRIGHT", -50, 0)
    LibDD:UIDropDownMenu_SetWidth(self[resourceCostName], 10)
    LibDD:UIDropDownMenu_SetText(self[resourceCostName], "")
    
    table.insert(self.priorityLabels, self[plname])
    table.insert(self.checkButtons, checkButton)
    table.insert(self.rows, row)
    
    lastCheckButton = checkButton
    lastRow = row
    lastDD = self[resourceCostName]
    
    if self.AnythingForXPCheckButton then
        self.AnythingForXPCheckButton:SetPoint("TOPLEFT", self.TitleBarTexture, "BOTTOMLEFT", 27, -5 - ((self.numRewardCheckboxes + 1) * 22))
    end
end

function addon.BaseGUIMixin:Init()
    self:InitTLDRButton()
    
    self:Hide()
    self:SetSize(350, 640)
    if not self:IsUserPlaced() then
        self:SetPoint("CENTER")
    end
    self:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 32,
        insets = { left = 11, right = 12, top = 12, bottom = 11, },
    })
    self:SetFrameStrata("DIALOG")
    self:EnableMouse(true)
    self:SetMovable(true)
    self:SetClampedToScreen(true)
    self:RegisterForDrag("LeftButton")
    self:SetScript("OnDragStart", function(self)
        self:SetUserPlaced(true)
        self:StartMoving()
      end)
    self:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        local tldrRight = self:GetRight()
        local tldrTop = self:GetTop()
        local covLeft = self.missionFrame:GetLeft()
        local covTop = self.missionFrame:GetTop()
        
        -- accomodate other addons that can make the mission frame movable - allow clamping the GUI back to the left side of the mission frame
        if self.missionFrame:IsMovable() then
            if (((covLeft - 20) < tldrRight) and ((covLeft + 20) > tldrRight)) and (((covTop - 25) < tldrTop) and ((covTop + 5) > tldrTop)) then
                self:SetUserPlaced(false)
                self:ClearAllPoints()
                self:SetPoint("RIGHT", self.missionFrame, "LEFT")
            end
        end
        
        tldrTop = self:GetTop()
        
        self.db.profile.guiX = self:GetLeft() - covLeft
        self.db.profile.guiY = tldrTop - covTop
      end)

    self.CloseButton = CreateFrame("Button", "TLDRMissions"..self.followerTypeID.."FrameCloseButton", self, "UIPanelCloseButton")
    self.CloseButton:SetPoint("TOPRIGHT", -6, -4)
    self.CloseButton:SetScript("OnClick", function()
        self:SetShown(false)
    end) 

    self.TitleBarTexture = self:CreateTexture("TLDRMissions"..self.followerTypeID.."TitleBar", "BORDER", nil, -1)
    self.TitleBarTexture:SetPoint("TOPLEFT", self, "TOPLEFT", 10, 7)
    self.TitleBarTexture:SetPoint("TOPRIGHT", self, "TOPRIGHT", -10, 7)
    self.TitleBarTexture:SetHeight(40)
    self.TitleBarTexture:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-Top")
    self.TitleBarTexture:SetTexCoord(0, 1, 0, 0.14)

    self.TitleBarLabel = self:CreateFontString("TLDRMissions"..self.followerTypeID.."TitleBarLabel", "OVERLAY", "GameFontNormal")
    self.TitleBarLabel:SetPoint("CENTER", self.TitleBarTexture, "CENTER", 0, -7)
    self.TitleBarLabel:SetText(addonName.." "..C_AddOns.GetAddOnMetadata(addonName, "Version"))

    --
    -- Tab one: main frame
    --

    self.MainTabButton = CreateFrame("Button", "TLDRMissions"..self.followerTypeID.."FrameTab1", self, "PanelTabButtonTemplate")
    self.MainTabButton:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 0, 5)
    self.MainTabButton:SetText(GARRISON_MISSIONS)
    self.MainTabButton:SetScript("OnClick", function()
        PanelTemplates_SetTab(self, 1)
        self.AdvancedTabPanel:Hide()
        self.MainTabPanel:Show()
    end)
    self.MainTabButton:SetID(1)

    self.MainTabPanel = CreateFrame("Frame", "TLDRMissions"..self.followerTypeID.."FrameMainPanel", self)
    self.MainTabPanel:SetPoint("TOPLEFT", self, "TOPLEFT")

    self.priorityLabels = {}
    self.checkButtons = {}
    self.rows = {}

    self.lastRow, self.lastCheckButton, self.lastDD = nil, nil, nil
    self.numRewardCheckboxes = 0

    if self.isClassic then
        self.setupRewardCheckbox("Gold", BONUS_ROLL_REWARD_MONEY)
    end

    self.AnythingForXPCheckButton = CreateFrame("CheckButton", "TLDRMissions"..self.followerTypeID.."FrameAnythingForXPCheckButton", self.MainTabPanel, "UICheckButtonTemplate")
    self.AnythingForXPCheckButton:SetPoint("TOPLEFT", self.TitleBarTexture, "BOTTOMLEFT", 27, -5 - ((self.numRewardCheckboxes + 1) * 22))
    _G["TLDRMissions"..self.followerTypeID.."FrameAnythingForXPCheckButtonText"]:SetText(L["AnythingForXPLabel"])

    self.SacrificeCheckButton = CreateFrame("CheckButton", "TLDRMissions"..self.followerTypeID.."FrameSacrificeCheckButton", self.MainTabPanel, "UICheckButtonTemplate")
    self.SacrificeCheckButton:SetPoint("TOPLEFT", self.AnythingForXPCheckButton, 0, -22)
    _G["TLDRMissions"..self.followerTypeID.."FrameSacrificeCheckButtonText"]:SetText(L["SacrificeLabel"])
    self.SacrificeCheckButton:SetEnabled(false)

    self.CalculateButton = CreateFrame("Button", "TLDRMissions"..self.followerTypeID.."FrameCalculateButton", self.MainTabPanel, "UIPanelButtonTemplate")
    self.CalculateButton:SetPoint("TOPLEFT", self.SacrificeCheckButton, -10, -30)
    self.CalculateButton:SetText(L["Calculate"])
    self.CalculateButton:SetWidth(100)
    self.CalculateButton:SetEnabled(false)

    self.FailedCalcLabel = self.MainTabPanel:CreateFontString("TLDRMissions"..self.followerTypeID.."FrameFailedCalcLabel", "OVERLAY", "GameFontNormal")
    self.FailedCalcLabel:SetPoint("TOPLEFT", self.CalculateButton, 0, -30)
    self.FailedCalcLabel:SetSize(280,40)
    self.FailedCalcLabel:SetNonSpaceWrap(true)
    self.FailedCalcLabel:SetWordWrap(true)
    self.FailedCalcLabel:SetMaxLines(3)
    self.FailedCalcLabel:SetJustifyH("LEFT")
    self.FailedCalcLabel:SetJustifyV("TOP")
    self.FailedCalcLabel:SetTextColor(1, 0.5, 0)

    self.NextMissionLabel = self.MainTabPanel:CreateFontString("TLDRMissions"..self.followerTypeID.."FrameNextMissionLabel", "OVERLAY", "GameFontNormal")
    self.NextMissionLabel:SetPoint("TOPLEFT", self.CalculateButton, 0, -30)

    self.NextFollower1Label = self.MainTabPanel:CreateFontString("TLDRMissions"..self.followerTypeID.."FrameNextFollower1Label", "OVERLAY", "GameFontNormal")
    self.NextFollower1Label:SetPoint("TOPLEFT", self.NextMissionLabel, 0, -15)

    self.NextFollower2Label = self.MainTabPanel:CreateFontString("TLDRMissions"..self.followerTypeID.."FrameNextFollower2Label", "OVERLAY", "GameFontNormal")
    self.NextFollower2Label:SetPoint("TOPLEFT", self.NextFollower1Label, 0, -15)

    self.NextFollower3Label = self.MainTabPanel:CreateFontString("TLDRMissions"..self.followerTypeID.."FrameNextFollower3Label", "OVERLAY", "GameFontNormal")
    self.NextFollower3Label:SetPoint("TOPLEFT", self.NextFollower2Label, 0, -15)

    self.RewardsLabel = self.MainTabPanel:CreateFontString("TLDRMissions"..self.followerTypeID.."FrameRewardsLabel", "OVERLAY", "GameFontNormal")
    self.RewardsLabel:SetPoint("TOPLEFT", self.NextFollower3Label, 0, -20)
    self.RewardsLabel:SetText(GUILD_TAB_REWARDS..":")

    self.RewardsDetailLabel = self.MainTabPanel:CreateFontString("TLDRMissions"..self.followerTypeID.."FrameRewardsDetailLabel", "OVERLAY", "GameFontNormal")
    self.RewardsDetailLabel:SetPoint("TOPLEFT", self.RewardsLabel, "TOPRIGHT", 10, 0)
    self.RewardsDetailLabel:SetSize(200,40)
    self.RewardsDetailLabel:SetNonSpaceWrap(true)
    self.RewardsDetailLabel:SetWordWrap(true)
    self.RewardsDetailLabel:SetMaxLines(3)
    self.RewardsDetailLabel:SetJustifyH("LEFT")
    self.RewardsDetailLabel:SetJustifyV("TOP")

    self.StartMissionButton = CreateFrame("Button", "TLDRMissions"..self.followerTypeID.."FrameStartMissionButton", self.MainTabPanel, "UIPanelButtonTemplate")
    self.StartMissionButton:SetPoint("TOPLEFT", self.RewardsLabel, 0, -50)
    self.StartMissionButton:SetText(GARRISON_START_MISSION)
    self.StartMissionButton:SetWidth(100)
    self.StartMissionButton:SetEnabled(false)

    self.SkipMissionButton = CreateFrame("Button", "TLDRMissions"..self.followerTypeID.."FrameSkipMissionButton", self.MainTabPanel, "UIPanelButtonTemplate")
    self.SkipMissionButton:SetPoint("TOPLEFT", self.StartMissionButton, "TOPRIGHT", 10, 0)
    self.SkipMissionButton:SetText(L["Skip"])
    self.SkipMissionButton:SetWidth(60)
    self.SkipMissionButton:SetEnabled(false)

    self.CostLabel = self.MainTabPanel:CreateFontString("TLDRMissions"..self.followerTypeID.."FrameCostLabel", "OVERLAY", "GameFontNormal")
    self.CostLabel:SetPoint("TOPLEFT", self.SkipMissionButton, "TOPRIGHT", 5, -4)
    self.CostLabel:SetText(COSTS_LABEL)
    self.CostLabel:Hide()

    self.CostResultLabel = self.MainTabPanel:CreateFontString("TLDRMissions"..self.followerTypeID.."FrameCostResultLabel", "OVERLAY", "GameFontNormal")
    self.CostResultLabel:SetPoint("TOPLEFT", self.CostLabel, "TOPRIGHT", 2, 0)

    self.LowTimeWarningLabel = self.MainTabPanel:CreateFontString("TLDRMissions"..self.followerTypeID.."FrameLowTimeWarningLabel", "OVERLAY", "GameFontNormal")
    self.LowTimeWarningLabel:SetPoint("BOTTOMLEFT", self.StartMissionButton, "TOPLEFT", 0, 2)
    self.LowTimeWarningLabel:SetTextColor(1, 0, 0)

    self.EstimateLabel = self.MainTabPanel:CreateFontString("TLDRMissions"..self.followerTypeID.."FrameEstimateLabel", "OVERLAY", "GameFontNormal")
    self.EstimateLabel:SetPoint("TOPLEFT", self.StartMissionButton, 0, -25)

    for i = 1, 3 do
        self["EstimateFollower"..i.."Label"] = self.MainTabPanel:CreateFontString("TLDRMissions"..self.followerTypeID.."FrameEstimateFollower"..i.."Label", "OVERLAY", "GameFontNormal")
        local g = self["EstimateFollower"..i.."Label"]
        if i == 1 then
            g:SetPoint("TOPLEFT", self.EstimateLabel, "BOTTOMLEFT", 0, -2)
        elseif i == 3 then
            g:SetPoint("TOPLEFT", self.EstimateLabel, "TOPRIGHT", 10, 0)
        else
            g:SetPoint("TOPLEFT", self["EstimateFollower"..(i-1).."Label"], "BOTTOMLEFT", 0, -2)
        end
    end

    self.WarningLabel = self.MainTabPanel:CreateFontString("TLDRMissions"..self.followerTypeID.."FrameWarningLabel", "OVERLAY", "GameFontNormal")
    self.WarningLabel:SetPoint("TOPLEFT", self.EstimateLabel, "BOTTOMLEFT", 0, -30)
    self.WarningLabel:SetText([[
        This module is still in development.
        
        Warning: due to a bug in the game, pressing this Complete Missions Button will cause any troops out on missions to stay alive with zero health.
        If you want those troops to properly die, complete the missions manually through the default UI!
        ]])
    self.WarningLabel:SetSize(300, 150)

    self.CompleteMissionsButton = CreateFrame("Button", "TLDRMissions"..self.followerTypeID.."FrameCompleteMissionsButton", self.MainTabPanel, "UIPanelButtonTemplate")
    self.CompleteMissionsButton:SetPoint("BOTTOM", self, "BOTTOM", 0, 10)
    self.CompleteMissionsButton:SetText(L["CompleteMissionButtonText"])
    _G["TLDRMissions"..self.followerTypeID.."FrameCompleteMissionsButtonText"]:SetScale(1.2)
    self.CompleteMissionsButton:SetWidth(240)
    self.CompleteMissionsButton:SetHeight(25)
    self.CompleteMissionsButton:SetEnabled(true)

    --
    -- Advanced tab
    --

    self.AdvancedTabPanel = CreateFrame("Frame", "TLDRMissions"..self.followerTypeID.."FrameAdvancedPanel", self)
    self.AdvancedTabPanel:SetPoint("TOPLEFT", self, "TOPLEFT")
    self.AdvancedTabPanel:Hide()

    self.AdvancedTabButton = CreateFrame("Button", "TLDRMissions"..self.followerTypeID.."FrameTab2", self, "PanelTabButtonTemplate")
    self.AdvancedTabButton:SetPoint("TOPLEFT", self.MainTabButton, "TOPRIGHT", 0, 0)
    self.AdvancedTabButton:SetText(ADVANCED_LABEL)
    self.AdvancedTabButton:SetScript("OnClick", function()
        PanelTemplates_SetTab(self, 2)
        self.AdvancedTabPanel:Show()
        self.MainTabPanel:Hide()
    end)
    self.AdvancedTabButton:SetID(2)

    self.LowerBoundLevelRestrictionLabel = self.AdvancedTabPanel:CreateFontString("TLDRMissionsLowerBoundLevelRestrictionLabel", "OVERLAY", "GameFontNormal")
    self.LowerBoundLevelRestrictionLabel:SetPoint("TOPLEFT", self.TitleBarTexture, "BOTTOMLEFT", 15, -10)
    self.LowerBoundLevelRestrictionLabel:SetText(L["LevelRestriction"])
    self.LowerBoundLevelRestrictionLabel:SetWordWrap(true)
    self.LowerBoundLevelRestrictionLabel:SetWidth(300)

    self.LowerBoundLevelRestrictionSlider = CreateFrame("Slider", "TLDRMissions"..self.followerTypeID.."FrameSlider", self.AdvancedTabPanel, "OptionsSliderTemplate")
    self.LowerBoundLevelRestrictionSlider:SetPoint("TOPLEFT", self.LowerBoundLevelRestrictionLabel, 20, -20)
    self.LowerBoundLevelRestrictionSlider:SetSize(280, 20)
    _G["TLDRMissions"..self.followerTypeID.."FrameSliderLow"]:SetText("1")
    _G["TLDRMissions"..self.followerTypeID.."FrameSliderHigh"]:SetText("45")
    _G["TLDRMissions"..self.followerTypeID.."FrameSliderText"]:SetText("3")
    _G["TLDRMissions"..self.followerTypeID.."FrameSliderText"]:ClearAllPoints()
    _G["TLDRMissions"..self.followerTypeID.."FrameSliderText"]:SetPoint("TOP", "TLDRMissions"..self.followerTypeID.."FrameSlider", "BOTTOM", 0, 3)
    _G["TLDRMissions"..self.followerTypeID.."FrameSliderText"]:SetFontObject("GameFontHighlightSmall")
    _G["TLDRMissions"..self.followerTypeID.."FrameSliderText"]:SetTextColor(0, 1, 0)
    self.LowerBoundLevelRestrictionSlider:SetOrientation('HORIZONTAL')
    self.LowerBoundLevelRestrictionSlider:SetValueStep(1)
    self.LowerBoundLevelRestrictionSlider:SetObeyStepOnDrag(true)
    self.LowerBoundLevelRestrictionSlider:SetMinMaxValues(1, 45)
    self.LowerBoundLevelRestrictionSlider:SetValue(3)

    self.AnimaCostLimitLabel = self.AdvancedTabPanel:CreateFontString("TLDRMissions"..self.followerTypeID.."CostLimitLabel", "OVERLAY", "GameFontNormal")
    self.AnimaCostLimitLabel:SetPoint("TOPLEFT", self.LowerBoundLevelRestrictionSlider, -20, -40)
    self.AnimaCostLimitLabel:SetText("Resource Price Limit")
    self.AnimaCostLimitLabel:SetWordWrap(true)
    self.AnimaCostLimitLabel:SetWidth(300)

    self.AnimaCostLimitSlider = CreateFrame("Slider", "TLDRMissions"..self.followerTypeID.."FrameAnimaCostSlider", self.AdvancedTabPanel, "OptionsSliderTemplate")
    self.AnimaCostLimitSlider:SetPoint("TOPLEFT", self.AnimaCostLimitLabel, 20, -10)
    self.AnimaCostLimitSlider:SetSize(280, 20)
    _G["TLDRMissions"..self.followerTypeID.."FrameAnimaCostSliderLow"]:SetText("10")
    _G["TLDRMissions"..self.followerTypeID.."FrameAnimaCostSliderHigh"]:SetText("1000")
    _G["TLDRMissions"..self.followerTypeID.."FrameAnimaCostSliderText"]:SetText("1000")
    _G["TLDRMissions"..self.followerTypeID.."FrameAnimaCostSliderText"]:ClearAllPoints()
    _G["TLDRMissions"..self.followerTypeID.."FrameAnimaCostSliderText"]:SetPoint("TOP", "TLDRMissions"..self.followerTypeID.."FrameAnimaCostSlider", "BOTTOM", 0, 3)
    _G["TLDRMissions"..self.followerTypeID.."FrameAnimaCostSliderText"]:SetFontObject("GameFontHighlightSmall")
    _G["TLDRMissions"..self.followerTypeID.."FrameAnimaCostSliderText"]:SetTextColor(0, 1, 0)
    self.AnimaCostLimitSlider:SetOrientation('HORIZONTAL')
    self.AnimaCostLimitSlider:SetValueStep(10)
    self.AnimaCostLimitSlider:SetObeyStepOnDrag(true)
    self.AnimaCostLimitSlider:SetMinMaxValues(10, 1000)
    self.AnimaCostLimitSlider:SetValue(1000)

    self.DurationLabel = self.AdvancedTabPanel:CreateFontString("TLDRMissionsDurationLabel", "OVERLAY", "GameFontNormal")
    self.DurationLabel:SetPoint("TOPLEFT", self.AnimaCostLimitSlider, -20, -40)
    self.DurationLabel:SetText(L["DurationLabel"])
    self.DurationLabel:SetWidth(300)
    self.DurationLabel:SetWordWrap(true)

    self.DurationLowerSlider = CreateFrame("Slider", "TLDRMissions"..self.followerTypeID.."FrameDurationLowerSlider", self.AdvancedTabPanel, "OptionsSliderTemplate")
    self.DurationLowerSlider:SetPoint("TOPLEFT", self.DurationLabel, 20, -10)
    self.DurationLowerSlider:SetSize(280, 20)
    _G["TLDRMissions"..self.followerTypeID.."FrameDurationLowerSliderLow"]:SetText("1")
    _G["TLDRMissions"..self.followerTypeID.."FrameDurationLowerSliderHigh"]:SetText("24")
    _G["TLDRMissions"..self.followerTypeID.."FrameDurationLowerSliderText"]:ClearAllPoints()
    _G["TLDRMissions"..self.followerTypeID.."FrameDurationLowerSliderText"]:SetPoint("TOP", "TLDRMissions"..self.followerTypeID.."FrameDurationLowerSlider", "BOTTOM", 0, 3)
    _G["TLDRMissions"..self.followerTypeID.."FrameDurationLowerSliderText"]:SetFontObject("GameFontHighlightSmall")
    _G["TLDRMissions"..self.followerTypeID.."FrameDurationLowerSliderText"]:SetTextColor(0, 1, 0)
    self.DurationLowerSlider:SetOrientation("HORIZONTAL")
    self.DurationLowerSlider:SetValueStep(1)
    self.DurationLowerSlider:SetObeyStepOnDrag(true)
    self.DurationLowerSlider:SetMinMaxValues(1, 24)
    self.DurationLowerSlider:SetValue(1)

    self.DurationHigherSlider = CreateFrame("Slider", "TLDRMissions"..self.followerTypeID.."FrameDurationHigherSlider", self.AdvancedTabPanel, "OptionsSliderTemplate")
    self.DurationHigherSlider:SetPoint("TOPLEFT", self.DurationLabel, 20, -40)
    self.DurationHigherSlider:SetSize(280, 20)
    _G["TLDRMissions"..self.followerTypeID.."FrameDurationHigherSliderLow"]:SetText("")
    _G["TLDRMissions"..self.followerTypeID.."FrameDurationHigherSliderHigh"]:SetText("")
    _G["TLDRMissions"..self.followerTypeID.."FrameDurationHigherSliderText"]:SetText("")
    self.DurationHigherSlider:SetOrientation("HORIZONTAL")
    self.DurationHigherSlider:SetValueStep(1)
    self.DurationHigherSlider:SetObeyStepOnDrag(true)
    self.DurationHigherSlider:SetMinMaxValues(1, 24)
    self.DurationHigherSlider:SetValue(24)

    self.MinimumTroopsLabel = self.AdvancedTabPanel:CreateFontString("TLDRMissions"..self.followerTypeID.."FrameMinimumTroopsLabel", "OVERLAY", "GameFontNormal")
    self.MinimumTroopsLabel:SetPoint("TOPLEFT", self.DurationHigherSlider, -20, -20)
    self.MinimumTroopsLabel:SetText(L["MinimumTroops"])
    self.MinimumTroopsLabel:SetWordWrap(true)
    self.MinimumTroopsLabel:SetWidth(300)

    self.MinimumTroopsSlider = CreateFrame("Slider", "TLDRMissions"..self.followerTypeID.."FrameMinimumTroopsSlider", self.AdvancedTabPanel, "OptionsSliderTemplate")
    self.MinimumTroopsSlider:SetPoint("TOPLEFT", self.MinimumTroopsLabel, 20, -10)
    self.MinimumTroopsSlider:SetSize(280, 20)
    _G["TLDRMissions"..self.followerTypeID.."FrameMinimumTroopsSliderLow"]:SetText("0")
    _G["TLDRMissions"..self.followerTypeID.."FrameMinimumTroopsSliderHigh"]:SetText("3")
    _G["TLDRMissions"..self.followerTypeID.."FrameMinimumTroopsSliderText"]:SetText("2")
    _G["TLDRMissions"..self.followerTypeID.."FrameMinimumTroopsSliderText"]:ClearAllPoints()
    _G["TLDRMissions"..self.followerTypeID.."FrameMinimumTroopsSliderText"]:SetPoint("TOP", "TLDRMissions"..self.followerTypeID.."FrameMinimumTroopsSlider", "BOTTOM", 0, 3)
    _G["TLDRMissions"..self.followerTypeID.."FrameMinimumTroopsSliderText"]:SetFontObject("GameFontHighlightSmall")
    _G["TLDRMissions"..self.followerTypeID.."FrameMinimumTroopsSliderText"]:SetTextColor(0, 1, 0)
    self.MinimumTroopsSlider:SetOrientation('HORIZONTAL')
    self.MinimumTroopsSlider:SetValueStep(1)
    self.MinimumTroopsSlider:SetObeyStepOnDrag(true)
    self.MinimumTroopsSlider:SetMinMaxValues(0, 3)
    self.MinimumTroopsSlider:SetValue(2)

    self.MinimumTroopsInfoLabel = self.AdvancedTabPanel:CreateFontString("TLDRMissions"..self.followerTypeID.."FrameMinimumTroopsInfoLabel", "OVERLAY", "GameFontNormal")
    self.MinimumTroopsInfoLabel:SetPoint("TOPLEFT", self.MinimumTroopsSlider, "BOTTOMLEFT", 0, -10)
    self.MinimumTroopsInfoLabel:SetText("Set minimum troops to 3 for 'use as many as possible'.")
    self.MinimumTroopsInfoLabel:SetSize(250, 30)

    self.AutoShowButton = CreateFrame("CheckButton", "TLDRMissions"..self.followerTypeID.."FrameAutoShowButton", self.AdvancedTabPanel, "UICheckButtonTemplate")
    self.AutoShowButton:SetPoint("TOPLEFT", self.MinimumTroopsInfoLabel, -20, -30)
    _G["TLDRMissions"..self.followerTypeID.."FrameAutoShowButtonText"]:SetText(L["AutoShowLabel"])

    self.AutoShowButton:HookScript("OnClick", function()
        self.db.profile.autoShowUI = self.AutoShowButton:GetChecked()
    end)

    self.AutoStartButton = CreateFrame("CheckButton", "TLDRMissions"..self.followerTypeID.."FrameAutoStartButton", self.AdvancedTabPanel, "UICheckButtonTemplate")
    self.AutoStartButton:SetPoint("TOPLEFT", self.AutoShowButton, 0, -25)
    _G["TLDRMissions"..self.followerTypeID.."FrameAutoStartButtonText"]:SetText(L["AutoStart"])

    self.AutoStartButton:HookScript("OnClick", function()
        self.db.profile.autoStart = self.AutoStartButton:GetChecked()
    end)

    self.SkipFullResourcesButton = CreateFrame("CheckButton", "TLDRMissions"..self.followerTypeID.."FrameSkipFullResourcesButton", self.AdvancedTabPanel, "UICheckButtonTemplate")
    self.SkipFullResourcesButton:SetPoint("TOPLEFT", self.AutoStartButton, 0, -25)
    _G["TLDRMissions"..self.followerTypeID.."FrameSkipFullResourcesButtonText"]:SetText(L["SkipFullResources"])

    self.SkipFullResourcesButton:HookScript("OnClick", function()
        self.db.profile.skipFullResources = self.SkipFullResourcesButton:GetChecked()
    end)

    --
    -- Tab 3
    --

    self.ProfileTabButton = CreateFrame("Button", "TLDRMissions"..self.followerTypeID.."FrameTab3", self, "PanelTabButtonTemplate")
    self.ProfileTabButton:SetPoint("TOPLEFT", self.MainTabButton, "TOPRIGHT", 0, 0)
    self.ProfileTabButton:SetText(L["Profiles"])

    --
    --
    --

    PanelTemplates_SetNumTabs(self, 3)
    PanelTemplates_SetTab(self, 1)
    
    self.CompleteMissionsButton:SetScript("OnClick", addon.CompleteMissionsButtonOnClickHandler)
end