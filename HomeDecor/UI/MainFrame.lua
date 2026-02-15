local ADDON, NS = ...
NS.UI = NS.UI or {}
local UI = NS.UI

function UI:CreateMainFrame()
  if self.MainFrame then return end

  local Layout = self.Layout
  local View = self.Viewer
  if not Layout or not View then return end

  local frame = Layout:CreateShell()
  if not frame then return end

  self.MainFrame = frame

  frame:Hide()
  frame:SetFrameStrata("DIALOG")
  frame:SetFrameLevel(100)

  frame:SetMovable(true)
  frame:EnableMouse(true)
  frame:RegisterForDrag("LeftButton")
  frame:SetScript("OnDragStart", function(self)
    local C = NS.UI and NS.UI.Controls
    if C and C.ClearHoverHighlights then C:ClearHoverHighlights(self) end
    self:StartMoving()
  end)
  frame:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    local C = NS.UI and NS.UI.Controls
    if C and C.ClearHoverHighlights then C:ClearHoverHighlights(self) end
  end)

  if frame.GetName then
    local name = frame:GetName()
    if name and type(UISpecialFrames) == "table" then
      tinsert(UISpecialFrames, name)
    end
  end

  frame.view = View:Create(frame.Right)

  frame:SetScript("OnShow", function()
    if frame.view and frame.view.Render then frame.view:Render() end
  end)
end

function UI:ToggleMainFrame()
  if not self.MainFrame then
    self:CreateMainFrame()
  end

  local f = self.MainFrame
  if not f then return end

  if f:IsShown() then
    f:Hide()
  else
    f:Show()
    if NS.Systems and NS.Systems.Changelog then
      NS.Systems.Changelog:TryAutoPopup()
    end
  end
end

return UI
