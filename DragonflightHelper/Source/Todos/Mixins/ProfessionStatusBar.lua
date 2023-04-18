DFH_ProfessionStatusBar = CreateFromMixins(
  DFH_ProfessionLoader,
  DFH_TodoEventHandler,
  DFH_ProfessionUpdate,
  DFH_StatusBarMixin
)

function DFH_ProfessionStatusBar:OnLoad()
  DFH_StatusBarMixin.OnLoad(self)
  self:LoadProfessions()

  local completedColor = FACTION_BAR_COLORS[5]
  local incompleteColor = FACTION_BAR_COLORS[1]

  self:SetBackgroundColor(incompleteColor.r, incompleteColor.g, incompleteColor.b, 0.4)
  self:SetForegroundColor(completedColor.r, completedColor.g, completedColor.b)
end
