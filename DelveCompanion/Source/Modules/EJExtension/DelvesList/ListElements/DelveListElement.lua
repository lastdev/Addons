local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger

--- Composit frame to display a Delve button and other related elements (progress widget, etc).
---@class (exact) DelveListElement : DelveListElementXml
DelveCompanion_DelveListElementMixin = {}

---@param self DelveListElement
---@param data DelveData
function DelveCompanion_DelveListElementMixin:Init(data)
    self.InstanceButton:Init(data)
    self.InstanceButton:Refresh()

    if data.config.achievements then
        self.ProgressWidget:Init(data.config.achievements.story, data.config.achievements.chest)
        self.ProgressWidget:Refresh()
        self.ProgressWidget:Show()
    else
        self.ProgressWidget:Hide()
    end
end

---@param self DelveListElement
function DelveCompanion_DelveListElementMixin:OnShow()
end

---@param self DelveListElement
function DelveCompanion_DelveListElementMixin:OnHide()
end

--#region XML Annotations

--- `DelveCompanionDelveListElementTemplate`
---@class (exact) DelveListElementXml : Frame
---@field InstanceButton DelveInstanceButton
---@field ProgressWidget DelvesProgressWidget
--#endregion
