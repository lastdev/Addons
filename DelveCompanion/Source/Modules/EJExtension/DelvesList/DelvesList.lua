local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Config
local Config = DelveCompanion.Config

--#region Constants

---@type string
local DELVES_TAB_PARENT_KEY = "DelvesTab"

---@type integer
local EJ_DELVES_TAB_BUTTON_ID = 8
--#endregion

---@class DelvesList
---@field delvesMinTier integer
---@field Frame DelvesListFrame
---@field TabButton Button
---@field InfoFrame DelvesInfoFrame
local DelvesList = {}
DelveCompanion.EJExtension.DelvesList = DelvesList

---@param self DelvesList
---@param SelectedCallback function
function DelvesList:SetupExpansionDropdownForDelves(EncounterJournal, SelectedCallback)
    local function IsSelected(tier)
        return tier == EJ_GetCurrentTier()
    end

    EncounterJournal.instanceSelect.ExpansionDropdown:SetupMenu(function(dropdown, rootDescription)
        rootDescription:SetTag("MENU_EJ_EXPANSION")
        for tier = self.delvesMinTier, EJ_GetNumTiers() do
            local text = EJ_GetTierInfo(tier)
            rootDescription:CreateRadio(text, IsSelected, SelectedCallback, tier)
        end
    end)
end

--- Callback to handle a click on a delve in the list.
---@param _ any
---@param delveData DelveData
local function OnDelveButtonClicked(_, delveData)
    if delveData == nil then
        return
    end

    DelvesList.InfoFrame.data = delveData

    DelvesList.InfoFrame:Setup()
    DelvesList.InfoFrame:Show()
end

--- Create a tab button in EncounterJournal to open Delves list.
---@param self DelvesList
---@param EncounterJournal Frame
function DelvesList:CreateDelvesTabButton(EncounterJournal)
    ---@type Button
    local button = CreateFrame("Button", "$parent." .. DELVES_TAB_PARENT_KEY, EncounterJournal,
        "BottomEncounterTierTabTemplate")
    button:SetParentKey(DELVES_TAB_PARENT_KEY)
    button:SetText(_G["DELVES_LABEL"])
    button:SetID(EJ_DELVES_TAB_BUTTON_ID)

    self.TabButton = button
end

--- Create a tab button in EncounterJournal to open Delves list.
---@param self DelvesList
---@param EncounterJournal Frame
function DelvesList:CreateDelvesListFrame(EncounterJournal)
    ---@type DelvesListFrame
    local frame = CreateFrame("Frame", "$parent.DelvesListFrame", EncounterJournal,
        "DelveCompanionDelvesListFrameTemplate")

    self.Frame = frame
end

--- Initialize Delves list.
---@param self DelvesList
---@param EncounterJournal Frame
function DelvesList:Init(EncounterJournal)
    do
        self:CreateDelvesTabButton(EncounterJournal)
    end

    do
        self.delvesMinTier = GetEJTierDataTableID(Config.DELVES_MIN_EXPANSION)
        self:CreateDelvesListFrame(EncounterJournal)
    end

    do
        -- ---@type DelvesInfoFrame
        -- local infoFrame = CreateFrame("Frame", "$parent.DelveInfoFrame", delvesListFrame,
        --     "DelveCompanionDelveInfoFrameTemplate")
        -- DelvesList.InfoFrame = infoFrame

        -- EventRegistry:RegisterCallback(DelveCompanion.Definitions.Events.DELVE_INSTANCE_BUTTON_CLICK,
        --     OnDelveButtonClicked, DelveCompanion.DelvesList)
    end
end
