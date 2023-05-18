local addon, ns = ...

local event_manager = ns.events.manager
local custom_events = ns.events.custom
local theme = ns.media
local media = ns.media
DFH_StatusBarMixin = {}

local id = 0

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

  self.foreground = ITEM_QUALITY_COLORS[3]
  self:SetColors(self.foreground)

  self.barname = addon .. "_statusbar_" .. id
  id = id + 1

  event_manager:subscribe(
    self,
    {
      custom_events.THEME_LOADED,
      custom_events.STATUSBAR_TEXTURE_CHANGED,
      custom_events.FONT_CHANGED
    },
    self.barname
  )
end

function DFH_StatusBarMixin:SetColors(color)
  self.StatusBarBackground:SetStatusBarColor(220, 220, 220, 0.2)

  self.StatusBarForeground:SetStatusBarColor(color.r, color.g, color.b, color.a)
  self:SetBackgroundColor(255, 255, 255, 0.1)
end

function DFH_StatusBarMixin:update_texture(texture_name)
  local texture = media:get_statusbar(texture_name)

  self.StatusBarBackground:SetStatusBarTexture(texture)
  self.StatusBarForeground:SetStatusBarTexture(texture)
  self:SetColors(self.foreground)
end

function DFH_StatusBarMixin:notify(event, ...)
  if event == custom_events.THEME_LOADED then
    local font, statusbar = ...
    local font_object = media:get_font_object(font)

    self:update_texture(statusbar)
    self.Container.Title:SetFontObject(font_object)
    self.Container.Description:SetFontObject(font_object)
  elseif event == custom_events.STATUSBAR_TEXTURE_CHANGED then
    self:update_texture(...)
  elseif event == custom_events.FONT_CHANGED then
    local _, font_object = ...
    self.Container.Title:SetFontObject(font_object)
    self.Container.Description:SetFontObject(font_object)
  end
end

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
  self.foreground = { r = r, g = g, b = b, a = a }
  self:SetColors(self.foreground)
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
