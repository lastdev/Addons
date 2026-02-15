local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Config
local Config = DelveCompanion.Config

--#region Constants

--#endregion

---@class DelveEncounter
---@field CompanionFrame Button
---@field ExpBar JourneyEncounterExpBar
---@field ConfigPanel CompanionConfigPanel
local DelveEncounter = {}
DelveCompanion.EJExtension.DelveEncounter = DelveEncounter

---@param self DelveEncounter
function DelveEncounter:OnShowHook()
    -- Logger.Log("[DelveEncounter] OnShowHook...")

    local companionFrame = self.CompanionFrame

    ---@type EJTierData
    local tierData = GetEJTierData(EJ_GetCurrentTier())

    do
        local progressFrame = companionFrame:GetParent()
        local companionID = progressFrame.majorFactionData.playerCompanionID
        self.ExpBar.factionID = C_DelvesUI.GetFactionForCompanion(companionID)
        self.ExpBar:Show()
    end

    do
        local isConfigUnlocked = C_QuestLog.IsQuestFlaggedCompletedOnAccount(
            Config.COMPANION_UNLOCK_QUEST[tierData.expansionLevel])
        self.ConfigPanel:SetShown(isConfigUnlocked)
    end
end

---@param self DelveEncounter
function DelveEncounter:OnHideHook()
    -- Logger.Log("[DelveEncounter] OnHideHook...")

    self.ExpBar:Hide()
end

--- Initialize Delves list.
---@param self DelveEncounter
---@param JourneysFrame Frame
function DelveEncounter:Init(JourneysFrame)
    -- Logger.Log("[DelveEncounter] Init started...")

    ---@type Button
    local companionFrame = JourneysFrame.JourneyProgress.DelvesCompanionConfigurationFrame

    if not companionFrame then
        Logger.Log("[DelveEncounter] Companion frame is nil. Cannot init!")
        return
    end

    do
        companionFrame:ClearPoint("CENTER")
        companionFrame:SetPoint("LEFT", 30, 0)

        companionFrame:HookScript("OnShow",
            function()
                self:OnShowHook()
            end
        )
        companionFrame:HookScript("OnHide",
            function()
                self:OnHideHook()
            end
        )
        self.CompanionFrame = companionFrame

        ---@type FontString
        local compName = companionFrame.CompanionConfigBtn.CompanionName
        compName:SetJustifyH("CENTER")
        compName:ClearAllPoints()
        compName:SetPoint("TOPLEFT", companionFrame.CompanionConfigBtn.Icon, "TOPRIGHT", 5, 17)

        ---@type JourneyEncounterExpBar
        local bar = CreateFrame("StatusBar", "$parent.CompanionExpBar", companionFrame,
            "DelveCompanionJourneyEncounterExpBarTemplate")
        bar:SetPoint("TOP", compName, "BOTTOM", 0, 2)
        self.ExpBar = bar

        ---@type CompanionConfigPanel
        local configPanel = CreateFrame("Frame", "$parent.ConfigPanel", companionFrame,
            "DelveCompanionCompanionConfigPanelTemplate")
        configPanel:SetPoint("TOP", bar, "BOTTOM", 0, 3)
        self.ConfigPanel = configPanel
    end

    do
        ---@type DelveEncounterBountifulFrame
        local bountifulFrame = CreateFrame("Frame", "$parent.BountifulPanel", companionFrame,
            "DelveCompanionDelveEncounterBountifulFrameTemplate")
        bountifulFrame:SetPoint("LEFT", companionFrame, "RIGHT", 15, -6)

        ---@type DelveEncounterConsumablesFrame
        local consumablesFrame = CreateFrame("Frame", "$parent.ConsumalesPanel", companionFrame,
            "DelveCompanionDelveEncounterConsumablesFrameTemplate")
        consumablesFrame:SetPoint("LEFT", bountifulFrame, "RIGHT", 10, 0)
    end
end
