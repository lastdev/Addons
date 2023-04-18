DFH_TodoStatusBar = CreateFromMixins(
  DFH_TodoEventHandler,
  DFH_TodoUpdate,
  DFH_StatusBarMixin
)

function DFH_TodoStatusBar:OnLoad()
  DFH_StatusBarMixin.OnLoad(self)

  local completedColor = FACTION_BAR_COLORS[5]
  local incompleteColor = FACTION_BAR_COLORS[1]

  self:SetBackgroundColor(incompleteColor.r, incompleteColor.g, incompleteColor.b, 0.3)
  self:SetForegroundColor(completedColor.r, completedColor.g, completedColor.b)
end
