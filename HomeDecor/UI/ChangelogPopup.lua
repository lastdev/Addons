local ADDON, NS = ...

local C    = NS.UI and NS.UI.Controls
local T    = NS.UI and NS.UI.Theme and NS.UI.Theme.colors
local CLog = NS.Systems and NS.Systems.Changelog
if not C or not T or not CLog then return end

local Popup

local function CreatePopup()
  if Popup then return Popup end

  local p = CreateFrame("Frame", "HomeDecorChangelogPopup", UIParent, "BackdropTemplate")
  Popup = p

  p:SetSize(520, 350)
  p:SetPoint("CENTER")
  p:SetFrameStrata("FULLSCREEN_DIALOG")
  p:SetFrameLevel(9999)
  p:SetToplevel(true)
  p:SetClampedToScreen(true)

  C:Backdrop(p, T.panel, T.border)

  p:EnableMouse(true)
  p:SetMovable(true)
  p:RegisterForDrag("LeftButton")
  p:SetScript("OnDragStart", p.StartMoving)
  p:SetScript("OnDragStop", p.StopMovingOrSizing)

  local header = CreateFrame("Frame", nil, p, "BackdropTemplate")
  header:SetPoint("TOPLEFT", 6, -6)
  header:SetPoint("TOPRIGHT", -6, -6)
  header:SetHeight(48)
  C:Backdrop(header, T.header, T.border)

  header.title = header:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
  header.title:SetPoint("CENTER")
  header.title:SetText("What's New")
  header.title:SetTextColor(unpack(T.accent))

  header.closeBtn = CreateFrame("Button", nil, header, "BackdropTemplate")
  C:Backdrop(header.closeBtn, T.panel, T.border)
  header.closeBtn:SetSize(26, 26)
  header.closeBtn:SetPoint("RIGHT", header, "RIGHT", -10, 0)
  C:ApplyHover(header.closeBtn, T.panel, T.hover)

  header.closeBtn.icon = header.closeBtn:CreateTexture(nil, "OVERLAY")
  header.closeBtn.icon:SetSize(14, 14)
  header.closeBtn.icon:SetPoint("CENTER")
  header.closeBtn.icon:SetTexture("Interface\\Buttons\\UI-StopButton")
  header.closeBtn.icon:SetVertexColor(1, 0.82, 0.2, 1)

  header.closeBtn:SetScript("OnClick", function()
    CLog:MarkSeen()
    p:Hide()
  end)

  local auto = CreateFrame("CheckButton", nil, header, "UICheckButtonTemplate")
  auto:SetPoint("LEFT", header, "LEFT", 8, 0)
  auto.text = auto:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  auto.text:SetPoint("LEFT", auto, "RIGHT", 4, 0)
  auto.text:SetText("Auto Open")

  auto:SetScript("OnClick", function(self)
    CLog:SetAutoOpen(self:GetChecked())
  end)

  local div = p:CreateTexture(nil, "ARTWORK")
  div:SetColorTexture(1, 1, 1, 0.12)
  div:SetHeight(1)
  div:SetPoint("TOPLEFT", 12, -60)
  div:SetPoint("TOPRIGHT", -12, -60)

  local sf = CreateFrame("ScrollFrame", nil, p, "ScrollFrameTemplate")
  sf:SetPoint("TOPLEFT", 12, -68)
  sf:SetPoint("BOTTOMRIGHT", -28, 56)

  local content = CreateFrame("Frame", nil, sf)
  content:SetPoint("TOPLEFT", 0, 0)
  sf:SetScrollChild(content)

  sf:SetScript("OnSizeChanged", function(self, w)
    content:SetWidth((w or 0) - 2)
  end)

  local txt = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
  txt:SetPoint("TOPLEFT")
  txt:SetJustifyH("LEFT")
  txt:SetJustifyV("TOP")
  txt:SetWordWrap(true)

  local label = p:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
  label:SetPoint("BOTTOMLEFT", 14, 18)
  label:SetText("Support Discord:")
  label:SetTextColor(unpack(T.accent))

  local edit = CreateFrame("EditBox", nil, p, "InputBoxTemplate")
  edit:SetSize(260, 24)
  edit:SetPoint("LEFT", label, "RIGHT", 6, 0)
  edit:SetAutoFocus(false)
  edit:SetText("https://discord.gg/G2gCV9Zc57")
  edit:SetCursorPosition(0)

  local function Highlight(self)
    self:SetFocus()
    self:HighlightText(0, self:GetNumLetters())
  end
  edit:SetScript("OnMouseUp", Highlight)
  edit:SetScript("OnEditFocusGained", Highlight)
  edit:SetScript("OnEscapePressed", edit.ClearFocus)

  p:SetScript("OnShow", function()
    auto:SetChecked(CLog:IsAutoOpenEnabled())
    txt:SetText(CLog:GetText() or "")
    content:SetHeight(math.max(1, txt:GetStringHeight()))
  end)

  p:SetPropagateKeyboardInput(true)
  p:SetScript("OnKeyDown", function(self, key)
  if key == "ESCAPE" then
    CLog:MarkSeen()
    self:Hide()
    self:SetPropagateKeyboardInput(false)
  end
end)

  p:Hide()
  return p
end

function NS.UI:ShowChangelogPopup(force)
  if not force and not CLog:IsNewVersion() then return end
  CreatePopup():Show()
end