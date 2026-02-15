local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

--- `Frame` with a map name displayed in the `Delves list` to group Delves.
---@class (exact) DelvesMapHeader : DelveMapHeaderXml
DelveCompanion_DelvesListMapHeaderMixin = {}

---@param self DelvesMapHeader
---@param name string
function DelveCompanion_DelvesListMapHeaderMixin:Init(name)
    self.MapName:SetText(name)
end

--#region XML Annotations

--- `DelveCompanionDelveMapHeaderTemplate`
---@class (exact) DelveMapHeaderXml : Frame
---@field Background Texture
---@field MapName FontString Localized name of the map
--#endregion
