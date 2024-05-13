local addonName = ...
local addon = _G[addonName]
local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")
local LibStub = addon.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale("TLDRMissions")

local gui = addon.WODGUI
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
    local covLeft = GarrisonMissionFrame:GetLeft()
    local covTop = GarrisonMissionFrame:GetTop()
    
    -- accomodate other addons that can make the mission frame movable - allow clamping the GUI back to the left side of the mission frame
    if GarrisonMissionFrame and GarrisonMissionFrame:IsMovable() then
        if (((covLeft - 20) < tldrRight) and ((covLeft + 20) > tldrRight)) and (((covTop - 25) < tldrTop) and ((covTop + 5) > tldrTop)) then
            self:SetUserPlaced(false)
            self:ClearAllPoints()
            self:SetPoint("RIGHT", GarrisonMissionFrame, "LEFT")
        end
    end
    
    tldrTop = gui:GetTop()
    
    addon.WODdb.profile.guiX = gui:GetLeft() - covLeft
    addon.WODdb.profile.guiY = tldrTop - covTop
  end)

gui.CloseButton = CreateFrame("Button", "TLDRMissionsWODFrameCloseButton", gui, "UIPanelCloseButton")
gui.CloseButton:SetPoint("TOPRIGHT", -6, -4)
gui.CloseButton:SetScript("OnClick", function()
    gui:SetShown(false)
end) 

gui.TitleBarTexture = gui:CreateTexture("TLDRMissionsWODTitleBar", "BORDER", nil, -1)
gui.TitleBarTexture:SetPoint("TOPLEFT", gui, "TOPLEFT", 10, 7)
gui.TitleBarTexture:SetPoint("TOPRIGHT", gui, "TOPRIGHT", -10, 7)
gui.TitleBarTexture:SetHeight(40)
gui.TitleBarTexture:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-Top")
gui.TitleBarTexture:SetTexCoord(0, 1, 0, 0.14)

gui.TitleBarLabel = gui:CreateFontString("TLDRMissionsWODTitleBarLabel", "OVERLAY", "GameFontNormal")
gui.TitleBarLabel:SetPoint("CENTER", gui.TitleBarTexture, "CENTER", 0, -7)
gui.TitleBarLabel:SetText(addonName.." "..GetAddOnMetadata(addonName, "Version"))

--
-- Tab one: main frame
--

gui.MainTabButton = CreateFrame("Button", "TLDRMissionsWODFrameTab1", gui, "PanelTabButtonTemplate")
gui.MainTabButton:SetPoint("TOPLEFT", gui, "BOTTOMLEFT", 0, 5)
gui.MainTabButton:SetText(GARRISON_MISSIONS)
gui.MainTabButton:SetScript("OnClick", function()
    PanelTemplates_SetTab(gui, 1)
    gui.AdvancedTabPanel:Hide()
    gui.MainTabPanel:Show()
end)
gui.MainTabButton:SetID(1)

gui.MainTabPanel = CreateFrame("Frame", "TLDRMissionsWODFrameMainPanel", gui)
gui.MainTabPanel:SetPoint("TOPLEFT", gui, "TOPLEFT")

local function setupButton(categoryName, setPointTo, text, acSetPointTo)
    local name = categoryName.."CheckButton"
    gui[name] = CreateFrame("CheckButton", "TLDRMissionsWODFrame"..categoryName.."CheckButton", gui.MainTabPanel, "UICheckButtonTemplate")
    gui[name]:SetPoint("TOPLEFT", setPointTo, 0, -22)
    _G["TLDRMissionsWODFrame"..categoryName.."CheckButtonText"]:SetText(text)
    
    gui[name].ExclusionLabel = gui[name]:CreateFontString("TLDRMissionsWOD"..categoryName.."ExclusionLabel", "OVERLAY", "GameFontNormalLarge")
    gui[name].ExclusionLabel:SetText("X")
    gui[name].ExclusionLabel:SetPoint("CENTER", gui[name], "CENTER", 0, 0)
    gui[name].ExclusionLabel:SetTextColor(1, 0, 0)
    gui[name].ExclusionLabel:Hide()

    local plname = categoryName.."PriorityLabel"
    gui[plname] = gui.MainTabPanel:CreateFontString("TLDRMissions"..categoryName.."PriorityLabel", "OVERLAY", "GameFontNormal")
    gui[plname]:SetPoint("TOPLEFT", gui[name], -15, -10)

    local resourceCostName = categoryName.."GarrisonResourceCostDropDown"
    gui[resourceCostName] = LibDD:Create_UIDropDownMenu("TLDRMissions"..categoryName.."GarrisonResourceCostDropDown", gui.MainTabPanel)
    gui[resourceCostName]:SetPoint("TOPRIGHT", acSetPointTo, 0, -22)
    LibDD:UIDropDownMenu_SetWidth(gui[resourceCostName], 10)
    LibDD:UIDropDownMenu_SetText(gui[resourceCostName], "")
end

setupButton("GarrisonResources", gui.TitleBarTexture, C_CurrencyInfo.GetBasicCurrencyInfo(824).name, gui.TitleBarTexture)
gui.GarrisonResourcesCheckButton:SetPoint("TOPLEFT", gui.TitleBarTexture, "BOTTOMLEFT", 20, 0)
gui.GarrisonResourcesGarrisonResourceCostDropDown:SetPoint("TOPRIGHT", gui.TitleBarTexture, "BOTTOMRIGHT", 10, 0)

setupButton("FollowerItems", gui.GarrisonResourcesCheckButton, GARRISON_FOLLOWER_ITEMS, gui.GarrisonResourcesGarrisonResourceCostDropDown)

--setupButton("PetCharms", gui.FollowerXPItemsCheckButton, L["PetCharms"], gui.FollowerXPItemsAnimaCostDropDown)
--setupButton("AugmentRunes", gui.PetCharmsCheckButton, L["AugmentRunes"], gui.PetCharmsAnimaCostDropDown)
--setupButton("Reputation", gui.AugmentRunesCheckButton, L["ReputationTokens"], gui.AugmentRunesAnimaCostDropDown)

setupButton("FollowerXP", gui.FollowerItemsCheckButton, L["BonusFollowerXP"], gui.FollowerItemsGarrisonResourceCostDropDown)

setupButton("Gear", gui.FollowerXPCheckButton, WORLD_QUEST_REWARD_FILTERS_EQUIPMENT, gui.FollowerXPGarrisonResourceCostDropDown)

setupButton("AnythingForXP", gui.GearCheckButton, L["AnythingForXPLabel"], gui.GearGarrisonResourceCostDropDown)

gui.SacrificeCheckButton = CreateFrame("CheckButton", "TLDRMissionsWODFrameSacrificeCheckButton", gui.MainTabPanel, "UICheckButtonTemplate")
gui.SacrificeCheckButton:SetPoint("TOPLEFT", gui.AnythingForXPCheckButton, 0, -22)
TLDRMissionsWODFrameSacrificeCheckButtonText:SetText(L["SacrificeLabel"])

gui.CalculateButton = CreateFrame("Button", "TLDRMissionsWODFrameCalculateButton", gui.MainTabPanel, "UIPanelButtonTemplate")
gui.CalculateButton:SetPoint("TOPLEFT", gui.SacrificeCheckButton, -10, -30)
gui.CalculateButton:SetText(L["Calculate"])
gui.CalculateButton:SetWidth(100)
gui.CalculateButton:SetEnabled(false)

gui.AbortButton = CreateFrame("Button", "TLDRMissionsWODFrameAbortButton", gui.MainTabPanel, "UIPanelButtonTemplate")
gui.AbortButton:SetPoint("TOPLEFT", gui.CalculateButton, "TOPRIGHT", 10, 0)
gui.AbortButton:SetText(CANCEL)
gui.AbortButton:SetWidth(60)
gui.AbortButton:SetEnabled(false)

gui.SkipCalculationButton = CreateFrame("Button", "TLDRMissionsWODFrameSkipCalculationButton", gui.MainTabPanel, "UIPanelButtonTemplate")
gui.SkipCalculationButton:SetPoint("TOPLEFT", gui.AbortButton, "TOPRIGHT", 10, 0)
gui.SkipCalculationButton:SetText(L["Skip"])
gui.SkipCalculationButton:SetWidth(60)
gui.SkipCalculationButton:SetEnabled(false)

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
gui.RewardsLabel:SetPoint("TOPLEFT", gui.NextFollower5Label, 0, -20)
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

gui.CompleteMissionsButton = CreateFrame("Button", "TLDRMissionsWODFrameCompleteMissionsButton", gui.MainTabPanel, "UIPanelButtonTemplate")
gui.CompleteMissionsButton:SetPoint("BOTTOM", gui, "BOTTOM", 0, 10)
gui.CompleteMissionsButton:SetText(L["CompleteMissionButtonText"])
TLDRMissionsWODFrameCompleteMissionsButtonText:SetScale(1.2)
gui.CompleteMissionsButton:SetWidth(240)
gui.CompleteMissionsButton:SetHeight(25)
gui.CompleteMissionsButton:SetEnabled(true)

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

PanelTemplates_SetNumTabs(gui, 2)
PanelTemplates_SetTab(gui, 1)
