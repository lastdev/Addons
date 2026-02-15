local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger

--- A button representing a Delve in the Delves list.
---@class (exact) DelveInstanceButton : DelveInstanceButtonXml
---@field data DelveData?
---@field waypointTracker DelveWaypointTracker
DelveCompanion_DelveInstanceButtonMixin = {}

---@param self DelveInstanceButton
---@param data DelveData
function DelveCompanion_DelveInstanceButtonMixin:Init(data)
    self.data = data

    self.DelveName:SetText(data.delveName)
    if C_Texture.GetAtlasInfo(data.config.atlasBgID) ~= nil then
        self.DelveArtBg:SetAtlas(data.config.atlasBgID)
    end

    local waypointTracker = CreateFromMixins(DelveCompanion_DelveWaypointMixin)
    waypointTracker:Prepare()
    self.waypointTracker = waypointTracker

    self.RightIconsContainer:Layout()
end

---@param self DelveInstanceButton
function DelveCompanion_DelveInstanceButtonMixin:Refresh()
    self.BountifulIcon:SetShown(self.data.isBountiful)
    self.RightIconsContainer.NotCompletedStoryIcon:SetShown(
        self.data.config.achievements
        and not self.data.isStoryCompleted
    )

    self.waypointTracker.Update(self.data)
    self.RightIconsContainer.WaypointIcon:SetShown(self.waypointTracker.isActive)

    self.RightIconsContainer:Layout()
end

---@param self DelveInstanceButton
function DelveCompanion_DelveInstanceButtonMixin:OnEvent(event, ...)
    self:Refresh()
end

---@param self DelveInstanceButton
function DelveCompanion_DelveInstanceButtonMixin:OnShow()
    -- Logger.Log("DelveInstanceButton OnShow start")

    self:RegisterEvent("SUPER_TRACKING_CHANGED")
end

---@param self DelveInstanceButton
function DelveCompanion_DelveInstanceButtonMixin:OnHide()
    self:UnregisterEvent("SUPER_TRACKING_CHANGED")
end

---@param self DelveInstanceButton
function DelveCompanion_DelveInstanceButtonMixin:OnEnter()
    -- TODO: delete completely if works fine.
    -- if DelveCompanion.Variables.maxLevelReached == false then
    --     return
    -- end

    self.waypointTracker:DisplayDelveTooltip(self, "ANCHOR_TOP", self.data)
end

---@param self DelveInstanceButton
function DelveCompanion_DelveInstanceButtonMixin:OnLeave()
    GameTooltip:Hide()
end

---@param self DelveInstanceButton
function DelveCompanion_DelveInstanceButtonMixin:OnClick()
    -- TODO: delete completely if works fine.
    -- if not DelveCompanion.Variables.maxLevelReached then
    --     return
    -- end

    if self.waypointTracker:VerifyInput() then
        self.waypointTracker:ToggleTracking(self.data)
        self:Refresh()
        self.waypointTracker:DisplayDelveTooltip(self, "ANCHOR_TOP", self.data)
    else
        -- EventRegistry:TriggerEvent(DelveCompanion.Definitions.Events.DELVE_INSTANCE_BUTTON_CLICK, self.data)
    end
end

--#region XML Annotations

---@class (exact) RightIconsContainer : HorizontalLayoutFrame
---@field WaypointIcon Frame
---@field NotCompletedStoryIcon Frame

--- `DelveCompanionDelveInstanceButtonTemplate`
---@class (exact) DelveInstanceButtonXml : Button
---@field DefaultBg Texture
---@field DelveArtBg Texture
---@field DelveName FontString
---@field BountifulIcon Texture
---@field RightIconsContainer RightIconsContainer
--#endregion
