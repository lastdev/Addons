DFH_TodoEventHandler = {}

local DFH_EVENTS = {
  "ENCOUNTER_LOOT_RECEIVED",
  "QUEST_TURNED_IN",
  "CURRENCY_DISPLAY_UPDATE",
  "QUEST_ACCEPTED",
  "QUEST_REMOVED"
}

function DFH_TodoEventHandler:OnShow()
  FrameUtil.RegisterFrameForEvents(self, DFH_EVENTS)
end

function DFH_TodoEventHandler:OnHide()
  FrameUtil.UnregisterFrameForEvents(self, DFH_EVENTS)
end

function DFH_TodoEventHandler:OnEvent(event, ...)
  if self.Update == nil then
    DFH_Utilities.error("[DEBUG]", "DFH_TodoEventHandler: No Update method found for this entry")
    return
  end

  self:Update()
end
