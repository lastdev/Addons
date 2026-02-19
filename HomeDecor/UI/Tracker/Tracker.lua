local ADDON, NS = ...
NS.UI = NS.UI or {}

local Tracker = NS.UI.Tracker or {}
NS.UI.Tracker = Tracker

local UI = NS.UI.TrackerUI
local Render = NS.UI.TrackerRender
local Events = NS.UI.TrackerEvents
local U = NS.UI.TrackerUtil

local function SetOpen(open)
  local db = U and U.GetTrackerDB and U.GetTrackerDB()
  if db then
    db.open = open and true or false
  end
end

function Tracker:Create()
  if self.frame then return end
  if not (UI and UI.CreateFrame) then return end

  local frame, ctx = UI:CreateFrame()
  self.frame = frame
  self.ctx = ctx

  if Render and Render.Attach then
    Render:Attach(self, ctx)
  end

  if Events and Events.Attach then
    Events:Attach(self, ctx)
  end

  frame:HookScript("OnShow", function() SetOpen(true) end)
  frame:HookScript("OnHide", function() SetOpen(false) end)

  local db = U and U.GetTrackerDB and U.GetTrackerDB()
  if db and db.open then
    frame:Show()
    frame:Raise()
  else
    frame:Hide()
  end
end

function Tracker:Show()
  if not self.frame then
    self:Create()
  end
  local frame = self.frame
  if not frame then return end
  frame:Show()
  frame:Raise()
  SetOpen(true)
end

function Tracker:Hide()
  local frame = self.frame
  if not frame then return end
  frame:Hide()
  SetOpen(false)
end

function Tracker:Toggle()
  if not self.frame then
    self:Create()
  end
  local frame = self.frame
  if not frame then return end
  if frame:IsShown() then
    self:Hide()
  else
    self:Show()
  end
end

return Tracker
