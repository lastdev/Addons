local _, NS = ...

NS.UI = NS.UI or {}
NS.UI.ResizeBar = NS.UI.ResizeBar or {}
local RB = NS.UI.ResizeBar

local C = NS.UI and NS.UI.Controls
local T = NS.UI and NS.UI.Theme and NS.UI.Theme.colors

local CreateFrame = CreateFrame
local floor, max, min = math.floor, math.max, math.min
local unpack = unpack or table.unpack

local function clamp(v, a, b)
  if v < a then return a end
  if v > b then return b end
  return v
end

local function ApplyCanvasScale(frame)
  if not frame or not frame.canvas then return end
  local c = frame.canvas
  local bw, bh = c._baseW or c:GetWidth() or 1, c._baseH or c:GetHeight() or 1
  local w, h = frame:GetWidth() or 1, frame:GetHeight() or 1
  local sx, sy = (w / bw), (h / bh)
  local s = math.min(sx, sy)
  if s < 0.70 then s = 0.70 end
  if s > 1.35 then s = 1.35 end
  c:SetScale(s)
  c:ClearAllPoints()
  c:SetPoint("CENTER")
end

function RB:Attach(rootFrame, headerFrame)
  if not rootFrame or not headerFrame or rootFrame._resizeWidget then return end
  if not C or not T then return end

  local db = NS.db and NS.db.profile
  if not db then return end
  db.ui = db.ui or {}

  local function GetSmartBaseSize()
  local sw = (UIParent and UIParent.GetWidth and UIParent:GetWidth()) or 0
  local sh = (UIParent and UIParent.GetHeight and UIParent:GetHeight()) or 0

  if sw <= 0 or sh <= 0 then
    return 1160, 680
  end

  local w = floor(sw * 0.70 + 0.5)
  local h = floor(sh * 0.70 + 0.5)

  w = clamp(w, 1080, 1320)
  h = clamp(h, 620, 780)
  return w, h
end

local BASE_W, BASE_H = GetSmartBaseSize()
  local MIN_W, MAX_W = 880, 1700
  local MIN_S, MAX_S = 0, 200

local BUMP = 20

local function displayToEffective(s)
  s = clamp(s or 0, MIN_S, MAX_S)
  local t = (s - 100) / 100
  local bump = BUMP * (1 - (t * t))
  return clamp(s + bump, MIN_S, MAX_S)
end

local function effectiveToDisplay(eff)

  eff = clamp(eff or 0, MIN_S, MAX_S)
  local lo, hi = MIN_S, MAX_S
  for _ = 1, 20 do
    local mid = (lo + hi) / 2
    local e = displayToEffective(mid)
    if e < eff then lo = mid else hi = mid end
  end
  return clamp(math.floor(((lo + hi) / 2) + 0.5), MIN_S, MAX_S)
end

  local STEP = 5

  local function widthToScale(w)
    w = clamp(w, MIN_W, MAX_W)
    return effectiveToDisplay(floor(((w - MIN_W) / (MAX_W - MIN_W)) * MAX_S + 0.5))
  end

  local function scaleToWidth(s)
    s = clamp(s, MIN_S, MAX_S)
    return MIN_W + (s / MAX_S) * (MAX_W - MIN_W)
  end

  local startW = tonumber(db.ui.width) or BASE_W
  startW = clamp(startW, MIN_W, MAX_W)

  local startH = tonumber(db.ui.height)
  if not startH then
    startH = floor(BASE_H * (startW / BASE_W))
  end

  rootFrame:SetSize(startW, startH)
  ApplyCanvasScale(rootFrame)

  local parent = headerFrame.controls or headerFrame

  local holder = CreateFrame("Frame", nil, parent)
  holder:SetSize(230, 16)
  holder:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, -6)

  local label = holder:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
  label:SetPoint("LEFT", 0, 0)
  label:SetText("Scale")

  local sliderBG = CreateFrame("Frame", nil, holder, "BackdropTemplate")
  C:Backdrop(sliderBG, T.panel, T.border)
  sliderBG:SetPoint("LEFT", label, "RIGHT", 6, 0)
  sliderBG:SetSize(130, 16)

  local slider = CreateFrame("Slider", nil, sliderBG)
  slider:SetAllPoints(sliderBG)
  slider:SetMinMaxValues(MIN_S, MAX_S)
  slider:SetValueStep(STEP)
  slider:SetObeyStepOnDrag(true)
  slider:SetOrientation("HORIZONTAL")
  slider:SetThumbTexture("Interface\\Buttons\\UI-SliderBar-Button-Horizontal")
  local thumb = slider:GetThumbTexture()
  if thumb then thumb:Hide() end

  local fill = sliderBG:CreateTexture(nil, "ARTWORK")
  fill:SetPoint("LEFT", 4, 0)
  fill:SetHeight(10)
  fill:SetColorTexture(unpack(T.accent))

  local valueBox = CreateFrame("Frame", nil, holder, "BackdropTemplate")
  C:Backdrop(valueBox, T.panel, T.border)
  valueBox:SetPoint("LEFT", sliderBG, "RIGHT", 6, 0)
  valueBox:SetSize(36, 16)

  local valueText = valueBox:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
  valueText:SetPoint("CENTER", 0, 0)

  local function setScaleVisual(s)
    s = clamp(s, MIN_S, MAX_S)
    local pct = s / MAX_S
    fill:SetWidth((sliderBG:GetWidth() - 8) * pct)
    valueText:SetText(s)
  end

  local function applyScale(s)
    s = floor(s / STEP) * STEP
    s = clamp(s, MIN_S, MAX_S)

    setScaleVisual(s)

    local w = floor(scaleToWidth(displayToEffective(s)))
    local h = floor(BASE_H * (w / BASE_W))

    rootFrame:SetSize(w, h)
    ApplyCanvasScale(rootFrame)

    db.ui.width = w
    db.ui.height = h

    if NS.UI and NS.UI.Viewer and NS.UI.Viewer.RequestRender then
      NS.UI.Viewer:RequestRender(true)
    end
  end

  slider:SetValue(widthToScale(startW))
  setScaleVisual(widthToScale(startW))

  slider:SetScript("OnValueChanged", function(_, v)
    v = floor(v / STEP) * STEP
    setScaleVisual(clamp(v, MIN_S, MAX_S))
  end)

  slider:SetScript("OnMouseUp", function(self)
    applyScale(self:GetValue())
  end)

  C:ApplyHover(sliderBG, T.panel, T.hover)
  C:ApplyHover(valueBox, T.panel, T.hover)

  holder:SetFrameLevel((parent:GetFrameLevel() or headerFrame:GetFrameLevel()) + 2)
  rootFrame._resizeWidget = holder
end

return RB