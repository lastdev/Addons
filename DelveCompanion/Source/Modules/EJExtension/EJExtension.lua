local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Config
local Config = DelveCompanion.Config

--#region Constants

---@type integer
local EJ_TABS_COUNT = 8
--#endregion

---@class EJExtension
---@field DelvesList DelvesList
---@field DelveEncounter DelveEncounter
local EJExtension = {}
DelveCompanion.EJExtension = EJExtension

local function ExpansionDropdown_Select(tier)
    EJExtension:OnExpansionDropdownSelected(tier)
end

---@param self EJExtension
function EJExtension:OnExpansionDropdownSelected(tier)
    EJ_SelectTier(tier)

    local EncounterJournal = EncounterJournal

    local tierData = GetEJTierData(tier)
    do
        -- JourneysFrame has an internal variable to control the current displayed expansion. It should be set to properly reflect expansion switch done on the Delves tab.

        if EncounterJournal.JourneysFrame then
            -- If tier is greater than EJ_TIER_DATA, either we have "current season" selected, or an expansion is missing. Fall back on the current expansion.
            -- EJ_TIER_DATA is a local table so ExpansionEnumToEJTierDataTableId is used instead.
            if tier > #ExpansionEnumToEJTierDataTableId then
                EncounterJournal.JourneysFrame.expansionFilter = LE_EXPANSION_LEVEL_CURRENT
            else
                EncounterJournal.JourneysFrame.expansionFilter = tierData.expansionLevel
            end
        end
    end

    -- As it's a custom function for the dropdown, DelvesList is always shown here.
    do
        self.DelvesList.Frame:Refresh()
    end
end

---@param self EJExtension
function EJExtension:OnContentTabSet(id)
    -- Logger.Log("EJ_ContentTab_Select Hook. Tab ID: %d", id)

    local EncounterJournal = EncounterJournal

    if id ~= self.DelvesList.TabButton:GetID() then
        self.DelvesList.Frame:Hide()

        return
    end

    EJ_HideNonInstancePanels()
    EncounterJournal_ShowGreatVaultButton()

    -- If the Delves tab is opened with an earlier expansion selected, set the selected EJ Tier to the current expansion.
    if EJ_GetCurrentTier() < self.DelvesList.delvesMinTier then
        ExpansionDropdown_Select(GetServerExpansionLevel() + 1)
    end
    self.DelvesList:SetupExpansionDropdownForDelves(EncounterJournal, ExpansionDropdown_Select)
    EncounterJournal_EnableExpansionDropdown(-40, -30, EncounterJournal)
    EncounterJournal.instanceSelect.ExpansionDropdown:SetShown(true)

    self.DelvesList.Frame:Show()
end

---@param self EJExtension
function EJExtension:OnPostShow()
    -- Logger.Log("[EJExtension] OnPostShow")

    local EncounterJournal = EncounterJournal
    local currentTab = EncounterJournal.selectedTab

    if currentTab == self.DelvesList.TabButton:GetID() then
        self.DelvesList:SetupExpansionDropdownForDelves(EncounterJournal, ExpansionDropdown_Select)
    end
end

---@param self EJExtension
function EJExtension:Init()
    -- Logger.Log("[EJExtension] Init started...")

    ---@type Frame
    local EncounterJournal = EncounterJournal

    if not EncounterJournal then
        Logger.Log("[EJExtension] EncounterJournal is nil. Cannot init!")
        return
    end

    -- DelvesList
    do
        self.DelvesList:Init(EncounterJournal)

        PanelTemplates_SetNumTabs(EncounterJournal, EJ_TABS_COUNT)
    end

    -- JourneysFrame
    do
        self.DelveEncounter:Init(EncounterJournal.JourneysFrame)
    end

    EncounterJournal:HookScript("OnShow",
        function()
            EJExtension:OnPostShow()
        end
    )

    hooksecurefunc("EJ_ContentTab_Select",
        function(id)
            EJExtension:OnContentTabSet(id)
        end
    )
end

EventUtil.ContinueOnAddOnLoaded(DelveCompanion.Definitions.DependencyAddonName.encounterJournal,
    function()
        EJExtension:Init()
    end
)
