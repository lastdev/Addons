local addonName, addon = ...
local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")
local LibStub = addon.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale("TLDRMissions")

local tldrButton = CreateFrame("Button", "TLDRMissionsLegionToggleButton", OrderHallMissionFrame, "UIPanelButtonTemplate")
tldrButton:SetText("TL;DR")
tldrButton:SetWidth(80)
tldrButton:SetHeight(25)
TLDRMissionsToggleButtonText:SetScale(1.3)
tldrButton:Hide()
tldrButton:SetPoint("TOPLEFT", OrderHallMissionFrame, "TOPLEFT", 150, 0)

tldrButton:SetScript("OnClick", function (self, button)
    addon.LegionGUI:SetShown(not addon.LegionGUI:IsShown())
    addon.LegionGUI:SetParent(OrderHallMissionFrame)
end)

local gui = addon.LegionGUI
gui:Hide()
gui:SetSize(350, 640)
if not gui:IsUserPlaced() then
    gui:SetPoint("CENTER")
end
gui:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true,
    tileSize = 32,
    edgeSize = 32,
    insets = { left = 11, right = 12, top = 12, bottom = 11, },
})
gui:SetFrameStrata("DIALOG")
gui:EnableMouse(true)
gui:SetMovable(true)
gui:SetClampedToScreen(true)
gui:RegisterForDrag("LeftButton")
gui:SetScript("OnDragStart", function(self)
    self:SetUserPlaced(true)
    self:StartMoving()
  end)
gui:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    local tldrRight = gui:GetRight()
    local tldrTop = gui:GetTop()
    local covLeft = OrderHallMissionFrame:GetLeft()
    local covTop = OrderHallMissionFrame:GetTop()
    
    -- accomodate other addons that can make the mission frame movable - allow clamping the GUI back to the left side of the mission frame
    if OrderHallMissionFrame and OrderHallMissionFrame:IsMovable() then
        if (((covLeft - 20) < tldrRight) and ((covLeft + 20) > tldrRight)) and (((covTop - 25) < tldrTop) and ((covTop + 5) > tldrTop)) then
            self:SetUserPlaced(false)
            self:ClearAllPoints()
            self:SetPoint("RIGHT", OrderHallMissionFrame, "LEFT")
        end
    end
    
    tldrTop = gui:GetTop()
    
    addon.Legiondb.profile.guiX = gui:GetLeft() - covLeft
    addon.Legiondb.profile.guiY = tldrTop - covTop
  end)

gui.CloseButton = CreateFrame("Button", "TLDRMissionsLegionFrameCloseButton", gui, "UIPanelCloseButton")
gui.CloseButton:SetPoint("TOPRIGHT", -6, -4)
gui.CloseButton:SetScript("OnClick", function()
    gui:SetShown(false)
end) 

gui.TitleBarTexture = gui:CreateTexture("TLDRMissionsLegionTitleBar", "BORDER", nil, -1)
gui.TitleBarTexture:SetPoint("TOPLEFT", gui, "TOPLEFT", 10, 7)
gui.TitleBarTexture:SetPoint("TOPRIGHT", gui, "TOPRIGHT", -10, 7)
gui.TitleBarTexture:SetHeight(40)
gui.TitleBarTexture:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-Top")
gui.TitleBarTexture:SetTexCoord(0, 1, 0, 0.14)

gui.TitleBarLabel = gui:CreateFontString("TLDRMissionsLegionTitleBarLabel", "OVERLAY", "GameFontNormal")
gui.TitleBarLabel:SetPoint("CENTER", gui.TitleBarTexture, "CENTER", 0, -7)
gui.TitleBarLabel:SetText(addonName.." "..C_AddOns.GetAddOnMetadata(addonName, "Version"))

--
-- Tab one: main frame
--

gui.MainTabButton = CreateFrame("Button", "TLDRMissionsLegionFrameTab1", gui, "PanelTabButtonTemplate")
gui.MainTabButton:SetPoint("TOPLEFT", gui, "BOTTOMLEFT", 0, 5)
gui.MainTabButton:SetText(GARRISON_MISSIONS)
gui.MainTabButton:SetScript("OnClick", function()
    PanelTemplates_SetTab(gui, 1)
    --gui.AdvancedTabPanel:Hide()
    gui.MainTabPanel:Show()
end)
gui.MainTabButton:SetID(1)

gui.MainTabPanel = CreateFrame("Frame", "TLDRMissionsLegionFrameMainPanel", gui)
gui.MainTabPanel:SetPoint("TOPLEFT", gui, "TOPLEFT")

--[[]
gui.priorityLabels = {}
gui.checkButtons = {}
gui.rows = {}

local lastRow, lastCheckButton, lastDD
local numRows = 0

local function setupButton(categoryName, text)
    -- TLDRMissionsWODFrameGarrisonResourcesRow
    local row = CreateFrame("Frame", "TLDRMissionsWODFrame"..categoryName.."Row", gui.MainTabPanel)
    row:SetPoint("TOPLEFT", gui.TitleBarTexture, "BOTTOMLEFT", 50, -5 - (22 * numRows))
    numRows = numRows + 1
    row.index = numRows
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
    

    local checkButton = CreateFrame("CheckButton", "TLDRMissionsWODFrame"..categoryName.."CheckButton", gui.MainTabPanel, "UICheckButtonTemplate")
    gui[categoryName.."CheckButton"] = checkButton
    checkButton:SetPoint("TOPLEFT", row, -28, 5)
    _G["TLDRMissionsWODFrame"..categoryName.."CheckButtonText"]:SetText(text)
    _G["TLDRMissionsWODFrame"..categoryName.."CheckButtonText"]:SetDrawLayer("OVERLAY")
    
    checkButton.ExclusionLabel = checkButton:CreateFontString("TLDRMissionsWOD"..categoryName.."ExclusionLabel", "OVERLAY", "GameFontNormalLarge")
    checkButton.ExclusionLabel:SetText("X")
    checkButton.ExclusionLabel:SetPoint("CENTER", checkButton, "CENTER", 0, 0)
    checkButton.ExclusionLabel:SetTextColor(1, 0, 0)
    checkButton.ExclusionLabel:Hide()

    local plname = categoryName.."PriorityLabel"
    gui[plname] = gui.MainTabPanel:CreateFontString("TLDRMissionsWOD"..categoryName.."PriorityLabel", "OVERLAY", "GameFontNormal")
    gui[plname]:SetPoint("TOPLEFT", checkButton, -15, -10)

    local resourceCostName = categoryName.."GarrisonResourceCostDropDown"
    gui[resourceCostName] = LibDD:Create_UIDropDownMenu("TLDRMissionsWOD"..categoryName.."GarrisonResourceCostDropDown", gui.MainTabPanel)
    gui[resourceCostName]:SetPoint("TOPLEFT", row, "TOPRIGHT", -50, 0)
    LibDD:UIDropDownMenu_SetWidth(gui[resourceCostName], 10)
    LibDD:UIDropDownMenu_SetText(gui[resourceCostName], "")
    
    table.insert(gui.priorityLabels, gui[plname])
    table.insert(gui.checkButtons, checkButton)
    table.insert(gui.rows, row)
    
    lastCheckButton = checkButton
    lastRow = row
    lastDD = gui[resourceCostName]
end

if addon.isWOD then
    setupButton("Gold", BONUS_ROLL_REWARD_MONEY)
end

setupButton("GarrisonResources", C_CurrencyInfo.GetBasicCurrencyInfo(824).name)

setupButton("FollowerItems", GARRISON_FOLLOWER_ITEMS)

--setupButton("PetCharms", gui.FollowerXPItemsCheckButton, L["PetCharms"], gui.FollowerXPItemsAnimaCostDropDown)
--setupButton("AugmentRunes", gui.PetCharmsCheckButton, L["AugmentRunes"], gui.PetCharmsAnimaCostDropDown)
--setupButton("Reputation", gui.AugmentRunesCheckButton, L["ReputationTokens"], gui.AugmentRunesAnimaCostDropDown)

setupButton("FollowerXP", L["BonusFollowerXP"])

setupButton("Gear", WORLD_QUEST_REWARD_FILTERS_EQUIPMENT)

setupButton("Apexis", "Apexis Crystal")

setupButton("Oil", "Oil")

setupButton("Seal", "Seal of Tempered Fate")

setupButton("Archaeology", PROFESSIONS_ARCHAEOLOGY)

gui.AnythingForXPCheckButton = CreateFrame("CheckButton", "TLDRMissionsWODFrameAnythingForXPCheckButton", gui.MainTabPanel, "UICheckButtonTemplate")
gui.AnythingForXPCheckButton:SetPoint("TOPLEFT", gui.TitleBarTexture, "BOTTOMLEFT", 27, -5 - ((numRows + 1) * 22))
TLDRMissionsWODFrameAnythingForXPCheckButtonText:SetText(L["AnythingForXPLabel"])

gui.SacrificeCheckButton = CreateFrame("CheckButton", "TLDRMissionsWODFrameSacrificeCheckButton", gui.MainTabPanel, "UICheckButtonTemplate")
gui.SacrificeCheckButton:SetPoint("TOPLEFT", gui.AnythingForXPCheckButton, 0, -22)
TLDRMissionsWODFrameSacrificeCheckButtonText:SetText(L["SacrificeLabel"])

gui.CalculateButton = CreateFrame("Button", "TLDRMissionsWODFrameCalculateButton", gui.MainTabPanel, "UIPanelButtonTemplate")
gui.CalculateButton:SetPoint("TOPLEFT", gui.SacrificeCheckButton, -10, -30)
gui.CalculateButton:SetText(L["Calculate"])
gui.CalculateButton:SetWidth(100)
gui.CalculateButton:SetEnabled(false)

gui.FailedCalcLabel = gui.MainTabPanel:CreateFontString("TLDRMissionsWODFrameFailedCalcLabel", "OVERLAY", "GameFontNormal")
gui.FailedCalcLabel:SetPoint("TOPLEFT", gui.CalculateButton, 0, -30)
gui.FailedCalcLabel:SetSize(280,40)
gui.FailedCalcLabel:SetNonSpaceWrap(true)
gui.FailedCalcLabel:SetWordWrap(true)
gui.FailedCalcLabel:SetMaxLines(3)
gui.FailedCalcLabel:SetJustifyH("LEFT")
gui.FailedCalcLabel:SetJustifyV("TOP")
gui.FailedCalcLabel:SetTextColor(1, 0.5, 0)

gui.NextMissionLabel = gui.MainTabPanel:CreateFontString("TLDRMissionsWODFrameNextMissionLabel", "OVERLAY", "GameFontNormal")
gui.NextMissionLabel:SetPoint("TOPLEFT", gui.CalculateButton, 0, -30)

gui.NextFollower1Label = gui.MainTabPanel:CreateFontString("TLDRMissionsWODFrameNextFollower1Label", "OVERLAY", "GameFontNormal")
gui.NextFollower1Label:SetPoint("TOPLEFT", gui.NextMissionLabel, 0, -15)

gui.NextFollower2Label = gui.MainTabPanel:CreateFontString("TLDRMissionsWODFrameNextFollower2Label", "OVERLAY", "GameFontNormal")
gui.NextFollower2Label:SetPoint("TOPLEFT", gui.NextFollower1Label, 0, -15)

gui.NextFollower3Label = gui.MainTabPanel:CreateFontString("TLDRMissionsWODFrameNextFollower3Label", "OVERLAY", "GameFontNormal")
gui.NextFollower3Label:SetPoint("TOPLEFT", gui.NextFollower2Label, 0, -15)

gui.RewardsLabel = gui.MainTabPanel:CreateFontString("TLDRMissionsWODFrameRewardsLabel", "OVERLAY", "GameFontNormal")
gui.RewardsLabel:SetPoint("TOPLEFT", gui.NextFollower3Label, 0, -20)
gui.RewardsLabel:SetText(GUILD_TAB_REWARDS..":")

gui.RewardsDetailLabel = gui.MainTabPanel:CreateFontString("TLDRMissionsWODFrameRewardsDetailLabel", "OVERLAY", "GameFontNormal")
gui.RewardsDetailLabel:SetPoint("TOPLEFT", gui.RewardsLabel, "TOPRIGHT", 10, 0)
gui.RewardsDetailLabel:SetSize(200,40)
gui.RewardsDetailLabel:SetNonSpaceWrap(true)
gui.RewardsDetailLabel:SetWordWrap(true)
gui.RewardsDetailLabel:SetMaxLines(3)
gui.RewardsDetailLabel:SetJustifyH("LEFT")
gui.RewardsDetailLabel:SetJustifyV("TOP")

gui.StartMissionButton = CreateFrame("Button", "TLDRMissionsWODFrameStartMissionButton", gui.MainTabPanel, "UIPanelButtonTemplate")
gui.StartMissionButton:SetPoint("TOPLEFT", gui.RewardsLabel, 0, -50)
gui.StartMissionButton:SetText(GARRISON_START_MISSION)
gui.StartMissionButton:SetWidth(100)
gui.StartMissionButton:SetEnabled(false)

gui.SkipMissionButton = CreateFrame("Button", "TLDRMissionsWODFrameSkipMissionButton", gui.MainTabPanel, "UIPanelButtonTemplate")
gui.SkipMissionButton:SetPoint("TOPLEFT", gui.StartMissionButton, "TOPRIGHT", 10, 0)
gui.SkipMissionButton:SetText(L["Skip"])
gui.SkipMissionButton:SetWidth(60)
gui.SkipMissionButton:SetEnabled(false)

gui.CostLabel = gui.MainTabPanel:CreateFontString("TLDRMissionsWODFrameCostLabel", "OVERLAY", "GameFontNormal")
gui.CostLabel:SetPoint("TOPLEFT", gui.SkipMissionButton, "TOPRIGHT", 5, -4)
gui.CostLabel:SetText(COSTS_LABEL)
gui.CostLabel:Hide()

gui.CostResultLabel = gui.MainTabPanel:CreateFontString("TLDRMissionsWODFrameCostResultLabel", "OVERLAY", "GameFontNormal")
gui.CostResultLabel:SetPoint("TOPLEFT", gui.CostLabel, "TOPRIGHT", 2, 0)

gui.LowTimeWarningLabel = gui.MainTabPanel:CreateFontString("TLDRMissionsWODFrameLowTimeWarningLabel", "OVERLAY", "GameFontNormal")
gui.LowTimeWarningLabel:SetPoint("BOTTOMLEFT", gui.StartMissionButton, "TOPLEFT", 0, 2)
gui.LowTimeWarningLabel:SetTextColor(1, 0, 0)

gui.EstimateLabel = gui.MainTabPanel:CreateFontString("TLDRMissionsWODFrameEstimateLabel", "OVERLAY", "GameFontNormal")
gui.EstimateLabel:SetPoint("TOPLEFT", gui.StartMissionButton, 0, -25)

for i = 1, 3 do
    gui["EstimateFollower"..i.."Label"] = gui.MainTabPanel:CreateFontString("TLDRMissionsWODFrameEstimateFollower"..i.."Label", "OVERLAY", "GameFontNormal")
    local g = gui["EstimateFollower"..i.."Label"]
    if i == 1 then
        g:SetPoint("TOPLEFT", gui.EstimateLabel, "BOTTOMLEFT", 0, -2)
    elseif i == 3 then
        g:SetPoint("TOPLEFT", gui.EstimateLabel, "TOPRIGHT", 10, 0)
    else
        g:SetPoint("TOPLEFT", gui["EstimateFollower"..(i-1).."Label"], "BOTTOMLEFT", 0, -2)
    end
end

]]

gui.CompleteMissionsButton = CreateFrame("Button", "TLDRMissionsWODFrameCompleteMissionsButton", gui.MainTabPanel, "UIPanelButtonTemplate")
gui.CompleteMissionsButton:SetPoint("BOTTOM", gui, "BOTTOM", 0, 10)
gui.CompleteMissionsButton:SetText(L["CompleteMissionButtonText"])
TLDRMissionsWODFrameCompleteMissionsButtonText:SetScale(1.2)
gui.CompleteMissionsButton:SetWidth(240)
gui.CompleteMissionsButton:SetHeight(25)
gui.CompleteMissionsButton:SetEnabled(true)

--
-- Advanced tab
--

--[[
gui.AdvancedTabPanel = CreateFrame("Frame", "TLDRMissionsWODFrameAdvancedPanel", gui)
gui.AdvancedTabPanel:SetPoint("TOPLEFT", gui, "TOPLEFT")
gui.AdvancedTabPanel:Hide()

gui.AdvancedTabButton = CreateFrame("Button", "TLDRMissionsWODFrameTab2", gui, "PanelTabButtonTemplate")
gui.AdvancedTabButton:SetPoint("TOPLEFT", gui.MainTabButton, "TOPRIGHT", 0, 0)
gui.AdvancedTabButton:SetText(ADVANCED_LABEL)
gui.AdvancedTabButton:SetScript("OnClick", function()
    PanelTemplates_SetTab(gui, 2)
    gui.AdvancedTabPanel:Show()
    gui.MainTabPanel:Hide()
end)
gui.AdvancedTabButton:SetID(2)

gui.FollowerXPSpecialTreatmentCheckButton = CreateFrame("CheckButton", "TLDRMissionsWODFrameFollowerXPSpecialTreatmentCheckButton", gui.AdvancedTabPanel, "UICheckButtonTemplate")
gui.FollowerXPSpecialTreatmentCheckButton:SetPoint("TOPLEFT", gui.TitleBarTexture, "BOTTOMLEFT", 25, 0)
TLDRMissionsWODFrameFollowerXPSpecialTreatmentCheckButtonText:SetText(L["FollowerXPSpecialTreatment"])

gui.FollowerXPSpecialTreatmentCheckButton:SetScript("OnEnter", function()
    GameTooltip:SetOwner(gui.FollowerXPSpecialTreatmentCheckButton, "ANCHOR_RIGHT")
    GameTooltip:SetText(L["FollowerXPSpecialTreatmentTooltip"], 1, 1, 1,  0.75, true)
    GameTooltip:Show()
end)
gui.FollowerXPSpecialTreatmentCheckButton:SetScript("OnLeave", function()
    GameTooltip:Hide()
end)

gui.FollowerXPSpecialTreatmentCheckButton:HookScript("OnClick", function()
    addon.db.profile.followerXPSpecialTreatment = gui.FollowerXPSpecialTreatmentCheckButton:GetChecked()
end)

gui.FollowerXPSpecialTreatmentAlgorithmDropDown = LibDD:Create_UIDropDownMenu("TLDRMissionsFollowerXPSpecialTreatmentAlgorithmDropDown", gui.AdvancedTabPanel)
gui.FollowerXPSpecialTreatmentAlgorithmDropDown:SetPoint("TOPLEFT", TLDRMissionsWODFrameFollowerXPSpecialTreatmentCheckButtonText, "TOPRIGHT", -10, 8)
LibDD:UIDropDownMenu_SetWidth(gui.FollowerXPSpecialTreatmentAlgorithmDropDown, 10)
LibDD:UIDropDownMenu_SetText(gui.FollowerXPSpecialTreatmentAlgorithmDropDown, "")

gui.LowerBoundLevelRestrictionLabel = gui.AdvancedTabPanel:CreateFontString("TLDRMissionsLowerBoundLevelRestrictionLabel", "OVERLAY", "GameFontNormal")
gui.LowerBoundLevelRestrictionLabel:SetPoint("TOPLEFT", gui.FollowerXPSpecialTreatmentCheckButton, 0, -40)
gui.LowerBoundLevelRestrictionLabel:SetText(L["LevelRestriction"])
gui.LowerBoundLevelRestrictionLabel:SetWordWrap(true)
gui.LowerBoundLevelRestrictionLabel:SetWidth(300)

gui.LowerBoundLevelRestrictionSlider = CreateFrame("Slider", "TLDRMissionsWODFrameSlider", gui.AdvancedTabPanel, "OptionsSliderTemplate")
gui.LowerBoundLevelRestrictionSlider:SetPoint("TOPLEFT", gui.LowerBoundLevelRestrictionLabel, 20, -20)
gui.LowerBoundLevelRestrictionSlider:SetSize(280, 20)
TLDRMissionsWODFrameSliderLow:SetText("1")
TLDRMissionsWODFrameSliderHigh:SetText("60")
TLDRMissionsWODFrameSliderText:SetText("3")
TLDRMissionsWODFrameSliderText:ClearAllPoints()
TLDRMissionsWODFrameSliderText:SetPoint("TOP", TLDRMissionsWODFrameSlider, "BOTTOM", 0, 3)
TLDRMissionsWODFrameSliderText:SetFontObject("GameFontHighlightSmall")
TLDRMissionsWODFrameSliderText:SetTextColor(0, 1, 0)
gui.LowerBoundLevelRestrictionSlider:SetOrientation('HORIZONTAL')
gui.LowerBoundLevelRestrictionSlider:SetValueStep(1)
gui.LowerBoundLevelRestrictionSlider:SetObeyStepOnDrag(true)
gui.LowerBoundLevelRestrictionSlider:SetMinMaxValues(1, 60)
gui.LowerBoundLevelRestrictionSlider:SetValue(3)

gui.AnimaCostLimitLabel = gui.AdvancedTabPanel:CreateFontString("TLDRMissionsWODCostLimitLabel", "OVERLAY", "GameFontNormal")
gui.AnimaCostLimitLabel:SetPoint("TOPLEFT", gui.LowerBoundLevelRestrictionSlider, -20, -40)
gui.AnimaCostLimitLabel:SetText("Resource Price Limit")
gui.AnimaCostLimitLabel:SetWordWrap(true)
gui.AnimaCostLimitLabel:SetWidth(300)

gui.AnimaCostLimitSlider = CreateFrame("Slider", "TLDRMissionsWODFrameAnimaCostSlider", gui.AdvancedTabPanel, "OptionsSliderTemplate")
gui.AnimaCostLimitSlider:SetPoint("TOPLEFT", gui.AnimaCostLimitLabel, 20, -10)
gui.AnimaCostLimitSlider:SetSize(280, 20)
TLDRMissionsWODFrameAnimaCostSliderLow:SetText("10")
TLDRMissionsWODFrameAnimaCostSliderHigh:SetText("300")
TLDRMissionsWODFrameAnimaCostSliderText:SetText("300")
TLDRMissionsWODFrameAnimaCostSliderText:ClearAllPoints()
TLDRMissionsWODFrameAnimaCostSliderText:SetPoint("TOP", TLDRMissionsWODFrameAnimaCostSlider, "BOTTOM", 0, 3)
TLDRMissionsWODFrameAnimaCostSliderText:SetFontObject("GameFontHighlightSmall")
TLDRMissionsWODFrameAnimaCostSliderText:SetTextColor(0, 1, 0)
gui.AnimaCostLimitSlider:SetOrientation('HORIZONTAL')
gui.AnimaCostLimitSlider:SetValueStep(10)
gui.AnimaCostLimitSlider:SetObeyStepOnDrag(true)
gui.AnimaCostLimitSlider:SetMinMaxValues(10, 300)
gui.AnimaCostLimitSlider:SetValue(300)

gui.DurationLabel = gui.AdvancedTabPanel:CreateFontString("TLDRMissionsDurationLabel", "OVERLAY", "GameFontNormal")
gui.DurationLabel:SetPoint("TOPLEFT", gui.AnimaCostLimitSlider, -20, -40)
gui.DurationLabel:SetText(L["DurationLabel"])
gui.DurationLabel:SetWidth(300)
gui.DurationLabel:SetWordWrap(true)

gui.DurationLowerSlider = CreateFrame("Slider", "TLDRMissionsWODFrameDurationLowerSlider", gui.AdvancedTabPanel, "OptionsSliderTemplate")
gui.DurationLowerSlider:SetPoint("TOPLEFT", gui.DurationLabel, 20, -10)
gui.DurationLowerSlider:SetSize(280, 20)
TLDRMissionsWODFrameDurationLowerSliderLow:SetText("1")
TLDRMissionsWODFrameDurationLowerSliderHigh:SetText("24")
TLDRMissionsWODFrameDurationLowerSliderText:ClearAllPoints()
TLDRMissionsWODFrameDurationLowerSliderText:SetPoint("TOP", TLDRMissionsWODFrameDurationLowerSlider, "BOTTOM", 0, 3)
TLDRMissionsWODFrameDurationLowerSliderText:SetFontObject("GameFontHighlightSmall")
TLDRMissionsWODFrameDurationLowerSliderText:SetTextColor(0, 1, 0)
gui.DurationLowerSlider:SetOrientation("HORIZONTAL")
gui.DurationLowerSlider:SetValueStep(1)
gui.DurationLowerSlider:SetObeyStepOnDrag(true)
gui.DurationLowerSlider:SetMinMaxValues(1, 24)
gui.DurationLowerSlider:SetValue(1)

gui.DurationHigherSlider = CreateFrame("Slider", "TLDRMissionsWODFrameDurationHigherSlider", gui.AdvancedTabPanel, "OptionsSliderTemplate")
gui.DurationHigherSlider:SetPoint("TOPLEFT", gui.DurationLabel, 20, -40)
gui.DurationHigherSlider:SetSize(280, 20)
TLDRMissionsWODFrameDurationHigherSliderLow:SetText("")
TLDRMissionsWODFrameDurationHigherSliderHigh:SetText("")
TLDRMissionsWODFrameDurationHigherSliderText:SetText("")
gui.DurationHigherSlider:SetOrientation("HORIZONTAL")
gui.DurationHigherSlider:SetValueStep(1)
gui.DurationHigherSlider:SetObeyStepOnDrag(true)
gui.DurationHigherSlider:SetMinMaxValues(1, 24)
gui.DurationHigherSlider:SetValue(24)

]]
gui.AutoShowButton = CreateFrame("CheckButton", "TLDRMissionsLegionFrameAutoShowButton", gui.MainTabPanel, "UICheckButtonTemplate")
gui.AutoShowButton:SetPoint("TOPLEFT", gui, "TOPLEFT", 20, -40)
TLDRMissionsLegionFrameAutoShowButtonText:SetText(L["AutoShowLabel"])

gui.AutoShowButton:HookScript("OnClick", function()
    addon.Legiondb.profile.autoShowUI = gui.AutoShowButton:GetChecked()
end)

--[[]
gui.AutoStartButton = CreateFrame("CheckButton", "TLDRMissionsWODFrameAutoStartButton", gui.AdvancedTabPanel, "UICheckButtonTemplate")
gui.AutoStartButton:SetPoint("TOPLEFT", gui.AutoShowButton, 0, -25)
TLDRMissionsWODFrameAutoStartButtonText:SetText(L["AutoStart"])

gui.AutoStartButton:HookScript("OnClick", function()
    addon.WODdb.profile.autoStart = gui.AutoStartButton:GetChecked()
end)

gui.SkipFullResourcesButton = CreateFrame("CheckButton", "TLDRMissionsWODFrameSkipFullResourcesButton", gui.AdvancedTabPanel, "UICheckButtonTemplate")
gui.SkipFullResourcesButton:SetPoint("TOPLEFT", gui.AutoStartButton, 0, -25)
TLDRMissionsWODFrameSkipFullResourcesButtonText:SetText(L["SkipFullResources"])

gui.SkipFullResourcesButton:HookScript("OnClick", function()
    addon.WODdb.profile.skipFullResources = gui.SkipFullResourcesButton:GetChecked()
end)

--
-- Tab 3
--

gui.ProfileTabButton = CreateFrame("Button", "TLDRMissionsWODFrameTab3", gui, "PanelTabButtonTemplate")
gui.ProfileTabButton:SetPoint("TOPLEFT", gui.MainTabButton, "TOPRIGHT", 0, 0)
gui.ProfileTabButton:SetText(L["Profiles"])
gui.ProfileTabButton:SetScript("OnClick", function()
    LibStub("AceConfigDialog-3.0"):Open("TLDRMissions-WOD")
end)

--
--
--

]]

PanelTemplates_SetNumTabs(gui, 1)
PanelTemplates_SetTab(gui, 1)
