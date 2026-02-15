local _, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Config
local Config = DelveCompanion.Config
---@type Lockit
local Lockit = DelveCompanion.Lockit

---@class (exact) DelveEncounterBountifulFrame : DelveEncounterBountifulFrameXml
---@field bountifulButtonsPool any
DelveCompanion_DelveEncounterBountifulFrameMixin = {}

---@param self DelveEncounterBountifulFrame
function DelveCompanion_DelveEncounterBountifulFrameMixin:OnLoad()
    -- Logger.Log("DelveEncounterBountifulFrame OnLoad start")
    self.Title:SetText(Lockit.UI_COMMON_BOUNTIFUL_DELVE_TITLE)

    self.ActiveDelves.NoBountifulLabel:SetText(Lockit.UI_NO_ACTIVE_BOUNTIFUL)
    self.bountifulButtonsPool = CreateFramePool("BUTTON", self.ActiveDelves.Container,
        "DelveCompanionDelveEncounterBountifulButtonTemplate")

    self.DelveOBotWidget.Cooldown:SetCountdownFont("GameFontHighlightSmall")
end

---@param self DelveEncounterBountifulFrame
function DelveCompanion_DelveEncounterBountifulFrameMixin:OnEvent(event, ...)
    -- Logger.Log("DelveEncounterBountifulFrame OnEvent start")
end

---@param self DelveEncounterBountifulFrame
function DelveCompanion_DelveEncounterBountifulFrameMixin:OnShow()
    -- Logger.Log("DelveEncounterBountifulFrame OnShow start")

    local expansion = GetEJTierData(EJ_GetCurrentTier()).expansionLevel
    DelveCompanion:UpdateDelvesData(expansion)

    for index, delveData in ipairs(DelveCompanion.Variables.delvesData[expansion]) do
        if delveData.isBountiful then
            ---@type OverviewBountifulButton
            local button = self.bountifulButtonsPool:Acquire()
            button:Init(delveData, index)
            button:Show()
        end
    end

    self.ActiveDelves.Container:Layout()
    self.ActiveDelves.NoBountifulLabel:SetShown(#self.ActiveDelves.Container:GetLayoutChildren() == 0)

    self.Title:ClearAllPoints()
    if expansion == LE_EXPANSION_WAR_WITHIN then
        self.DelveOBotWidget:SetShown(true) -- Delve-O-Bot 7001 works for TWW Delves only
        self.Title:SetPoint("LEFT", self, "TOPLEFT", 5, -27)
        self.Title:SetJustifyH("LEFT")
    else
        self.DelveOBotWidget:SetShown(false)
        self.Title:SetPoint("TOP", 0, -15)
        self.Title:SetJustifyH("CENTER")
    end
end

---@param self DelveEncounterBountifulFrame
function DelveCompanion_DelveEncounterBountifulFrameMixin:OnHide()
    -- Logger.Log("DelveEncounterBountifulFrame OnHide start")

    self.bountifulButtonsPool:ReleaseAll()
end

--#region XML Annotations

--- `DelveCompanionDelveEncounterBountifulFrameTemplate.ActiveDelves`
---@class (exact) DelveEncounterBountifulFrameActiveDelvesXml : Frame
---@field NoBountifulLabel FontString
---@field Container HorizontalLayoutFrame

--- `DelveCompanionDelveEncounterBountifulFrameTemplate`
---@class (exact) DelveEncounterBountifulFrameXml : Frame
---@field Title FontString
---@field DelveOBotWidget DelveOBotWidget
---@field ActiveDelves DelveEncounterBountifulFrameActiveDelvesXml

--#endregion
