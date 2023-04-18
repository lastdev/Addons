DFH_TodoEventHandler = {}

function DFH_TodoEventHandler:OnShow()
  FrameUtil.RegisterFrameForEvents(self, {
    "ENCOUNTER_LOOT_RECEIVED",
    "QUEST_TURNED_IN",
    "CURRENCY_DISPLAY_UPDATE",
    "QUEST_ACCEPTED",
    "QUEST_REMOVED"
  })
end

function DFH_TodoEventHandler:OnHide()
  FrameUtil.UnregisterFrameForEvents(self, {
    "ENCOUNTER_LOOT_RECEIVED",
    "QUEST_TURNED_IN",
    "CURRENCY_DISPLAY_UPDATE",
    "QUEST_ACCEPTED",
    "QUEST_REMOVED"
  })
end

function DFH_TodoEventHandler:OnEvent(event, ...)
  if self.Update == nil then
    DFH_Utilities.error("[DEBUG]", "DFH_TodoEventHandler: No Update method found for this entry")
    return
  end

  self:Update()
end
