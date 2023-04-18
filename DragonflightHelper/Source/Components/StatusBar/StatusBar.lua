local SharedMedia = LibStub("LibSharedMedia-3.0")

DFH_StatusBarMixin = {}

function DFH_StatusBarMixin:OnLoad()
  self.description = ""
  self.rolloverDescription = nil

  self.enterCallback = function()
    -- no op by default
  end
  self.leaveCallback = function()
    -- no op by default
  end

  self.clickCallback = function()
    -- no op by default
  end

  local texture = SharedMedia:Fetch("statusbar", "BantoBar")
  local color = ITEM_QUALITY_COLORS[3]

  self.StatusBarBackground:SetStatusBarColor(220, 220, 220, 0.2)
  self.StatusBarBackground:SetStatusBarTexture(texture)
  self.StatusBarForeground:SetStatusBarTexture(texture)

  self:SetForegroundColor(color.r, color.g, color.b, 1)
  self:SetBackgroundColor(255, 255, 255, 0.1)
end

-- function DFH_StatusBarMixin:OnShow()
-- end

-- function DFH_StatusBarMixin:OnHide()
-- end

function DFH_StatusBarMixin:SetTitle(title)
  self.Container.Title:SetText(title)
end

function DFH_StatusBarMixin:SetDescription(description)
  self.description = description

  self.Container.Description:SetText(description)
end

function DFH_StatusBarMixin:SetRolloverDescription(rolloverDescription)
  self.rolloverDescription = rolloverDescription
end

function DFH_StatusBarMixin:OnEnter()
  if self.rolloverDescription ~= nil then
    self.Container.Description:SetText(self.rolloverDescription)
  end

  self.enterCallback()
end

function DFH_StatusBarMixin:OnLeave()
  self.Container.Description:SetText(self.description)
  self.leaveCallback()
end

function DFH_StatusBarMixin:OnClick()
  self.clickCallback()
end

function DFH_StatusBarMixin:SetValue(value)
  self.StatusBarForeground:SetValue(value)
end

function DFH_StatusBarMixin:SetMinMaxValues(minimum, maximum)
  self.StatusBarForeground:SetMinMaxValues(minimum, maximum)
  self.StatusBarBackground:SetMinMaxValues(minimum, maximum)
end

function DFH_StatusBarMixin:SetForegroundColor(r, g, b, a)
  self.StatusBarForeground:SetStatusBarColor(r, g, b, a)
end

function DFH_StatusBarMixin:SetBackgroundColor(r, g, b, a)
  self.StatusBarBackground:SetStatusBarColor(r, g, b, a)
end

function DFH_StatusBarMixin:SetReverseFill()
  self.StatusBarForeground:SetReverseFill(true)
end

function DFH_StatusBarMixin:SetEnterCallback(fn)
  self.enterCallback = fn
end

function DFH_StatusBarMixin:SetLeaveCallback(fn)
  self.leaveCallback = fn
end

function DFH_StatusBarMixin:SetClickCallback(fn)
  self.clickCallback = fn
end

DFH_StatusBarButton = {}

function DFH_StatusBarButton:OnClick()
  self:GetParent():OnClick()
end

function DFH_StatusBarButton:OnEnter()
  self:GetParent():OnEnter()
end

function DFH_StatusBarButton:OnLeave()
  self:GetParent():OnLeave()
end
