local addon, ns = ...
local event_manager = ns.events.manager
local custom_events = ns.events.custom
local media = ns.media

DFH_Mixin = {};

SLASH_DFH_TOGGLE1 = "/dfh"

function DFH_Mixin:OnLoad()
  self:RegisterForDrag("LeftButton")

  self:SetClampedToScreen(true)
  self.locked = true

  self.texture = self:CreateTexture()
  self.texture:SetAllPoints()
  self.texture:SetColorTexture(0, 0, 0)
  self.texture:SetAlpha(0)

  self.openHeight = self:GetHeight()
  -- I'm sure there's a better way to do this but I want to go sit in raid finder
  self.sections = { self.Reputations, self.Timers, self.Todos, self.ProfessionTodos }

  SlashCmdList["DFH_TOGGLE"] = function()
    self:OnClick()
  end

  self.showing = true

  event_manager:subscribe(
    self,
    {
      custom_events.FONT_CHANGED,
      custom_events.THEME_LOADED,
      custom_events.BACKGROUND_OPACITY_CHANGED
    },
    "DFH_Main_Frame"
  )
  event_manager:handle(custom_events.MAIN_FRAME_LOADED, self)
end

function DFH_Mixin:notify(event_name, ...)
  if event_name == custom_events.THEME_LOADED then
    local font, _, opacity, _, locked = ...
    self.Title:SetFontObject(media:get_font_object(font))
    self.texture:SetAlpha(opacity)

    self.locked = locked
    -- Need to figure out how to correctly load status bars when hidden
    -- if showing then
    --   self:showFrames()
    -- else
    --   self:hideFrames()
    -- end
    -- self.showing = showing
  elseif event_name == custom_events.FONT_CHANGED then
    local _, font_object = ...
    self.Title:SetFontObject(font_object)
  elseif event_name == custom_events.BACKGROUND_OPACITY_CHANGED then
    self.texture:SetAlpha(...)
  end

  for _, section in ipairs(self.sections) do
    section.Title:notify(event_name, ...)
  end
end

function DFH_Mixin:hideFrames()
  for _, frame in ipairs(self.sections) do
    frame:Hide()
  end

  self:SetHeight(26)
  self.showing = not self.showing

  event_manager:handle(custom_events.FRAME_SHOWING_CHANGED, self.showing)
end

function DFH_Mixin:showFrames()
  for _, frame in ipairs(self.sections) do
    frame:Show()
  end

  self:SetHeight(self.openHeight)
  self.showing = not self.showing

  event_manager:handle(custom_events.FRAME_SHOWING_CHANGED, self.showing)
end

function DFH_Mixin:OnClick()
  if self.showing then
    self:hideFrames()
  else
    self:showFrames()
  end
end

function DFH_Mixin:ToggleLock()
  self.locked = not self.locked
  event_manager:handle(custom_events.FRAME_LOCKED_CHANGED, self.locked)
end

function DFH_Mixin:OnShow()
  event_manager:handle(custom_events.MAIN_FRAME_SHOWN, self)
  local children = self:GetChildren()
  local total = 0

  for _, child in ipairs(children) do
    total = total + child:GetHeight()
  end

  -- self:SetHeight(total)
end

function DFH_Mixin:OnHide()
end

function DFH_Mixin:OnMouseUp()
  self:StopMovingOrSizing()
end

function DFH_Mixin:OnMouseDown()
  -- self:StartSizing("BOTTOMRIGHT");
end

function DFH_Mixin:OnDragStart()
  if not self.locked then
    if IsShiftKeyDown() then
      self:StartSizing("BOTTOMRIGHT")
    else
      self:StartMoving()
    end
  end
end

function DFH_Mixin:OnDragStop()
  self:StopMovingOrSizing()
end

DFH_ButtonMixin = {}

function DFH_ButtonMixin:OnClick()
  self:GetParent():OnClick()
end

DFH_ConfigButtonMixin = {}

function DFH_ConfigButtonMixin:OnClick()
  event_manager:handle("OPEN_CONFIG", self:GetParent())
end

DFH_LockButtonMixin = {}

function DFH_LockButtonMixin:OnClick()
  self:GetParent():ToggleLock()
end

function DFH_LockButtonMixin:OnEnter()
  GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
  GameTooltip:SetText("Frame " .. (self:GetParent().locked and "Locked" or "Unlocked"), 0.9, 1.0, 1.0)
  GameTooltip:AddLine("Click to " .. (self:GetParent().locked and "unlock" or "lock") .. " the " .. addon .. " frame",
    0.5, 0.5, 1.0, 1)
  GameTooltip:Show()
end

function DFH_LockButtonMixin:OnLeave()
  GameTooltip:Hide()
end
