local _, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger

---@class (exact) DelveEncounterBountifulButton : DelveEncounterBountifulButtonXml
---@field data DelveData
---@field waypointTracker DelveWaypointTracker
DelveCompanion_DelveEncounterBountifulButtonMixin = {}

---@param self DelveEncounterBountifulButton
function DelveCompanion_DelveEncounterBountifulButtonMixin:OnLoad()
    -- Logger.Log("DelveEncounterBountifulButton OnLoad start")
    -- NOTE: BountifulButton is acquired from a FramePool so OnLoad is called only once per button lifetime.
    -- Only one-time initializations here.
end

---@param self DelveEncounterBountifulButton
---@param data DelveData
---@param index number
function DelveCompanion_DelveEncounterBountifulButtonMixin:Init(data, index)
    ---@diagnostic disable-next-line: inject-field
    self.layoutIndex = index
    self.data = data

    local waypointTracker = CreateFromMixins(DelveCompanion_DelveWaypointMixin)
    waypointTracker:Prepare()
    self.waypointTracker = waypointTracker
end

---@param self DelveEncounterBountifulButton
function DelveCompanion_DelveEncounterBountifulButtonMixin:Update()
    self.waypointTracker.Update(self.data)
    self.WaypointIcon:SetShown(self.waypointTracker.isActive)

    ---@type number
    local achIcon = select(10, GetAchievementInfo(self.data.config.achievements.story))
    self.ArtBg:SetTexture(achIcon)
end

---@param self DelveEncounterBountifulButton
function DelveCompanion_DelveEncounterBountifulButtonMixin:OnEvent(event, ...)
    self:Update()
end

---@param self DelveEncounterBountifulButton
function DelveCompanion_DelveEncounterBountifulButtonMixin:OnShow()
    -- Logger.Log("DelveEncounterBountifulButton OnShow start")

    self:RegisterEvent("SUPER_TRACKING_CHANGED")
    self:Update()
end

---@param self DelveEncounterBountifulButton
function DelveCompanion_DelveEncounterBountifulButtonMixin:OnHide()
    self:UnregisterEvent("SUPER_TRACKING_CHANGED")
end

---@param self DelveEncounterBountifulButton
function DelveCompanion_DelveEncounterBountifulButtonMixin:OnEnter()
    self.waypointTracker:DisplayDelveTooltip(self, "ANCHOR_TOP", self.data)
end

---@param self DelveEncounterBountifulButton
function DelveCompanion_DelveEncounterBountifulButtonMixin:OnLeave()
    GameTooltip:Hide()
end

---@param self DelveEncounterBountifulButton
function DelveCompanion_DelveEncounterBountifulButtonMixin:OnClick()
    if self.waypointTracker:VerifyInput() then
        self.waypointTracker:ToggleTracking(self.data)
        self:Update()
        self.waypointTracker:DisplayDelveTooltip(self, "ANCHOR_TOP", self.data)
    end
end

--#region XML Annotations

--- `DelveCompanionDelveEncounterBountifulButtonTemplate`
---@class (exact) DelveEncounterBountifulButtonXml : Button
---@field layoutIndex number
---@field Background Texture
---@field ArtBg Texture
---@field WaypointIcon Texture

--#endregion
