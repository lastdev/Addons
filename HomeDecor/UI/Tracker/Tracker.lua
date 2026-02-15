local ADDON, NS = ...
NS.UI = NS.UI or {}

local Tracker = NS.UI.Tracker or {}
NS.UI.Tracker = Tracker

local UI = NS.UI.TrackerUI
local Render = NS.UI.TrackerRender
local Events = NS.UI.TrackerEvents

local function GetTrackerDB()
  local addon = NS.Addon
  local prof = addon and addon.db and addon.db.profile
  local t = prof and prof.tracker
  if type(t) == "table" then
    return t
  end

  local sv = _G.HomeDecorDB
  if type(sv) ~= "table" then
    return nil
  end

  local t1 = sv.tracker
  if type(t1) == "table" then
    return t1
  end

  local s = sv.settings
  if type(s) == "table" then
    local t2 = s.tracker
    if type(t2) == "table" then
      return t2
    end
  end

  local p = sv.profile
  if type(p) == "table" then
    local t3 = p.tracker
    if type(t3) == "table" then
      return t3
    end
  end

  return nil
end

local function SetOpen(open)
  local db = GetTrackerDB()
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

  local db = GetTrackerDB()
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
