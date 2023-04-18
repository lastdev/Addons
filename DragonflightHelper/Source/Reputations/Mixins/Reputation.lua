DFH_ReputationItemMixin = CreateFromMixins(DFH_StatusBarMixin)

function DFH_ReputationItemMixin:OnLoad()
  DFH_StatusBarMixin.OnLoad(self)
  self.initialized = false
end

function DFH_ReputationItemMixin:OnShow()
  FrameUtil.RegisterFrameForEvents(self, {
    "UPDATE_FACTION",
    "MAJOR_FACTION_RENOWN_LEVEL_CHANGED",
    "MAJOR_FACTION_UNLOCKED"
  })
end

function DFH_ReputationItemMixin:OnHide()
  FrameUtil.UnregisterFrameForEvents(self, {
    "UPDATE_FACTION",
    "MAJOR_FACTION_RENOWN_LEVEL_CHANGED",
    "MAJOR_FACTION_UNLOCKED"
  })
end

function DFH_ReputationItemMixin:OnEvent(event, ...)
  if event == "UPDATE_FACTION" and self.initialized == false then
    self:Init()
    self:Update()
  elseif event == "UPDATE_FACTION" or event == "MAJOR_FACTION_RENOWN_LEVEL_CHANGED" or event == "MAJOR_FACTION_UNLOCKED" then
    self:Update()
  end
end

function DFH_ReputationItemMixin:Init()
  self.initialized = true
end

function DFH_ReputationItemMixin:Update()
  self.factionInfo:update()

  self:SetText()
  self:SetMinMaxValues(self.factionInfo.barMin, self.factionInfo.barMax)
  self:SetValue(self.factionInfo.barValue)
end

function DFH_ReputationItemMixin:SetText()
  -- Artisan's Consortium name too long:
  local dashIndex = self.factionInfo.title:find("-")
  if dashIndex == nil then
    self:SetTitle(self.factionInfo.title)
  else
    self:SetTitle(self.factionInfo.title:sub(0, dashIndex - 1))
  end

  self:SetDescription(self.factionInfo.detail)
  self:SetRolloverDescription(("%d / %d"):format(self.factionInfo.barValue, self.factionInfo.barMax))
end
