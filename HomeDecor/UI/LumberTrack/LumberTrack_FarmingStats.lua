local ADDON, NS = ...
NS.UI = NS.UI or {}

local FarmingStats = NS.UI.LumberTrackFarmingStats or {}
NS.UI.LumberTrackFarmingStats = FarmingStats

local Utils = NS.LT.Utils
local CreateFrame = _G.CreateFrame
local unpack = _G.unpack or table.unpack

function FarmingStats:Create(sharedCtx)
  if self.frame then return end
  local db = Utils.GetDB()
  local T = Utils.GetTheme()
  local collapsed = db.farmingStatsCollapsed and true or false
  local BASE_W = 300
  local BASE_H = collapsed and 166 or 300
  local initScale = collapsed and (db.farmingStatsScaleCollapsed or 60) or (db.farmingStatsScale or 60)
  local MIN_SCALE_VAL = 25
  local MAX_SCALE_VAL = 100
  local MIN_FACTOR = 0.7
  local MAX_FACTOR = 1.5
  initScale = Utils.Clamp(initScale, MIN_SCALE_VAL, MAX_SCALE_VAL)
  local range = MAX_SCALE_VAL - MIN_SCALE_VAL
  local normalized = (initScale - MIN_SCALE_VAL) / range
  local initScaleFactor = MIN_FACTOR + normalized * (MAX_FACTOR - MIN_FACTOR)
  local initW = math.floor(BASE_W * initScaleFactor + 0.5)
  local initH = math.floor(BASE_H * initScaleFactor + 0.5)
  local frame = CreateFrame("Frame", "HomeDecorFarmingStats", UIParent, "BackdropTemplate")
  self.frame = frame
  frame:SetSize(initW, initH)
  local point = db.farmingStatsPoint or "TOPLEFT"
  local relPoint = db.farmingStatsRelPoint or "TOPLEFT"
  local x = tonumber(db.farmingStatsX) or 250
  local y = tonumber(db.farmingStatsY) or -80
  frame:SetPoint(point, UIParent, relPoint, x, y)
  frame:SetFrameStrata("DIALOG")
  frame:SetFrameLevel(210)
  frame:SetToplevel(true)
  frame:SetClampedToScreen(true)
  frame:SetResizable(true)
  frame:SetMovable(true)
  frame:EnableMouse(true)
  frame:Hide()
  frame._bgAlpha = tonumber(db and db.farmingStatsAlpha) or 1
  frame:SetBackdrop({
    bgFile = "Interface/Buttons/WHITE8x8",
    edgeFile = "Interface/Buttons/WHITE8x8",
    edgeSize = 2,
  })
  frame:SetBackdropColor(0.06, 0.06, 0.07, frame._bgAlpha)
  frame:SetBackdropBorderColor(0.21, 0.21, 0.25, 1)
  local container = CreateFrame("Frame", nil, frame)
  container:SetAllPoints()
  local canvas = CreateFrame("Frame", nil, container)
  canvas:SetAllPoints()
  self.canvas = canvas
  self.BASE_W = 300
  self.BASE_H_EXPANDED = 300
  self.BASE_H_COLLAPSED = 166
  local header = CreateFrame("Frame", nil, canvas, "BackdropTemplate")
  header:SetPoint("TOPLEFT", 6, -6)
  header:SetPoint("TOPRIGHT", -6, -6)
  header:SetHeight(32)
  header:SetBackdrop({
    bgFile = "Interface/Buttons/WHITE8x8",
    edgeFile = "Interface/Buttons/WHITE8x8",
    edgeSize = 1,
  })
  header:SetBackdropColor(0.12, 0.12, 0.14, 1)
  header:SetBackdropBorderColor(0.90, 0.72, 0.18, 0.5)
  header:EnableMouse(true)
  header:RegisterForDrag("LeftButton")
  header:SetScript("OnDragStart", function() frame:StartMoving() end)
  header:SetScript("OnDragStop", function()
    frame:StopMovingOrSizing()
    local pt, _, relPt, xPos, yPos = frame:GetPoint(1)
    if pt and db then
      db.farmingStatsPoint = pt
      db.farmingStatsRelPoint = relPt
      db.farmingStatsX = xPos
      db.farmingStatsY = yPos
    end
  end)
  local collapseBtn = CreateFrame("Button", nil, header, "BackdropTemplate")
  collapseBtn:SetSize(26, 26)
  collapseBtn:SetPoint("LEFT", 10, 0)
  Utils.CreateBackdrop(collapseBtn, T.panel or { 0.08, 0.08, 0.10, 0.95 }, T.border or { 0.24, 0.24, 0.28, 0.8 })
  collapseBtn.icon = collapseBtn:CreateTexture(nil, "OVERLAY")
  collapseBtn.icon:SetSize(14, 14)
  collapseBtn.icon:SetPoint("CENTER")
  collapseBtn.icon:SetTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
  collapseBtn.icon:SetRotation(collapsed and 0 or -1.5708)
  collapseBtn:SetScript("OnEnter", function(self)
    self:SetBackdropBorderColor(unpack(T.accentBright))
  end)
  collapseBtn:SetScript("OnLeave", function(self)
    self:SetBackdropBorderColor(unpack(T.border))
  end)
  collapseBtn:SetScript("OnClick", function()
    FarmingStats:ToggleCollapsed()
  end)
  self.collapseBtn = collapseBtn
  local title = header:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
  title:SetPoint("CENTER", 0, 0)
  title:SetText("Farming Stats")
  title:SetTextColor(unpack(T.accent or { 0.90, 0.72, 0.18, 1 }))
  self.title = title
  local settingsBtn = CreateFrame("Button", nil, header, "BackdropTemplate")
  settingsBtn:SetSize(26, 26)
  settingsBtn:SetPoint("RIGHT", -40, 0)
  Utils.CreateBackdrop(settingsBtn, T.panel or { 0.08, 0.08, 0.10, 0.95 }, T.border or { 0.24, 0.24, 0.28, 0.8 })
  settingsBtn.icon = settingsBtn:CreateTexture(nil, "OVERLAY")
  settingsBtn.icon:SetSize(14, 14)
  settingsBtn.icon:SetPoint("CENTER")
  settingsBtn.icon:SetTexture("Interface\\Buttons\\UI-OptionsButton")
  settingsBtn:SetScript("OnEnter", function(self)
    self:SetBackdropBorderColor(unpack(T.accentBright or T.accent or { 0.9, 0.72, 0.18, 1 }))
  end)
  settingsBtn:SetScript("OnLeave", function(self)
    self:SetBackdropBorderColor(unpack(T.border or {}))
  end)
  self.settingsBtn = settingsBtn
  local MIN_SCALE = 25
  local MAX_SCALE = 100
  local MIN_FACTOR = 0.7
  local MAX_FACTOR = 1.5
  local function sliderToScaleFactor(sliderVal)
    sliderVal = Utils.Clamp(sliderVal, MIN_SCALE, MAX_SCALE)
    local range = MAX_SCALE - MIN_SCALE
    local normalized = (sliderVal - MIN_SCALE) / range
    return MIN_FACTOR + normalized * (MAX_FACTOR - MIN_FACTOR)
  end
  local function scaleFactorToSlider(scaleFactor)
    scaleFactor = Utils.Clamp(scaleFactor, MIN_FACTOR, MAX_FACTOR)
    local normalized = (scaleFactor - MIN_FACTOR) / (MAX_FACTOR - MIN_FACTOR)
    local sliderVal = MIN_SCALE + (normalized * (MAX_SCALE - MIN_SCALE))
    return math.floor(sliderVal / 5 + 0.5) * 5
  end
  local initScale = collapsed and (db.farmingStatsScaleCollapsed or 60) or (db.farmingStatsScale or 60)
  initScale = Utils.Clamp(initScale, MIN_SCALE, MAX_SCALE)
  local initialScaleFactor = sliderToScaleFactor(initScale)
  canvas:SetScale(initialScaleFactor)
  local closeBtn = CreateFrame("Button", nil, header, "BackdropTemplate")
  closeBtn:SetSize(26, 26)
  closeBtn:SetPoint("RIGHT", -10, 0)
  Utils.CreateBackdrop(closeBtn, T.panel or { 0.08, 0.08, 0.10, 0.95 }, T.border or { 0.24, 0.24, 0.28, 0.8 })
  closeBtn.icon = closeBtn:CreateTexture(nil, "OVERLAY")
  closeBtn.icon:SetSize(14, 14)
  closeBtn.icon:SetPoint("CENTER")
  closeBtn.icon:SetTexture("Interface\\Buttons\\UI-StopButton")
  closeBtn.icon:SetVertexColor(1, 0.82, 0.2, 1)
  closeBtn:SetScript("OnClick", function()
    FarmingStats:Hide()
  end)
  self.closeBtn = closeBtn
  self.header = header
  local statsContainer = CreateFrame("Frame", nil, canvas)
  statsContainer:SetPoint("TOPLEFT", 14, -44)
  statsContainer:SetPoint("TOPRIGHT", -14, -44)
  statsContainer:SetHeight(120)
  local function CreateStatBox(parent, label)
    local box = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    box:SetBackdrop({
      bgFile = "Interface/Buttons/WHITE8x8",
      edgeFile = "Interface/Buttons/WHITE8x8",
      edgeSize = 1,
    })
    box:SetBackdropColor(0.10, 0.10, 0.13, 1)
    box:SetBackdropBorderColor(0.90, 0.72, 0.18, 0.30)
    local labelText = box:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    labelText:SetFont(STANDARD_TEXT_FONT or "Fonts\\FRIZQT__.TTF", 9, "OUTLINE")
    labelText:SetPoint("TOP", 0, -4)
    labelText:SetText(label)
    labelText:SetTextColor(0.60, 0.60, 0.67, 1)
    local valueText = box:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    valueText:SetFont(STANDARD_TEXT_FONT or "Fonts\\FRIZQT__.TTF", 17, "THICKOUTLINE")
    valueText:SetPoint("CENTER", 0, -3)
    valueText:SetText("0")
    valueText:SetTextColor(1, 0.85, 0.40, 1)
    valueText:SetShadowColor(0, 0, 0, 1)
    valueText:SetShadowOffset(1, -1)
    box.value = valueText
    return box
  end
  local statRow = CreateFrame("Frame", nil, statsContainer)
  statRow:SetPoint("TOPLEFT", 0, 0)
  statRow:SetPoint("TOPRIGHT", 0, 0)
  statRow:SetHeight(50)
  local totalBox = CreateStatBox(statRow, "TOTAL")
  totalBox:SetPoint("TOPLEFT", 0, 0)
  totalBox:SetPoint("BOTTOMLEFT", 0, 0)
  totalBox:SetWidth(62)
  self.totalText = totalBox.value
  self.totalBox = totalBox
  local bagsBox = CreateStatBox(statRow, "BAGS")
  bagsBox:SetPoint("LEFT", totalBox, "RIGHT", 4, 0)
  bagsBox:SetPoint("TOP", 0, 0)
  bagsBox:SetPoint("BOTTOM", 0, 0)
  bagsBox:SetWidth(62)
  self.bagsText = bagsBox.value
  self.bagsBox = bagsBox
  local perMinBox = CreateStatBox(statRow, "/MIN")
  perMinBox:SetPoint("LEFT", bagsBox, "RIGHT", 4, 0)
  perMinBox:SetPoint("TOP", 0, 0)
  perMinBox:SetPoint("BOTTOM", 0, 0)
  perMinBox:SetWidth(62)
  self.perMinText = perMinBox.value
  self.perMinBox = perMinBox
  local perHourBox = CreateStatBox(statRow, "/HR")
  perHourBox:SetPoint("LEFT", perMinBox, "RIGHT", 4, 0)
  perHourBox:SetPoint("TOPRIGHT", 0, 0)
  perHourBox:SetPoint("BOTTOM", 0, 0)
  self.perHourText = perHourBox.value
  self.perHourBox = perHourBox
  local timerBar = CreateFrame("Frame", nil, statsContainer, "BackdropTemplate")
  timerBar:SetPoint("TOPLEFT", 0, -54)
  timerBar:SetPoint("TOPRIGHT", 0, -54)
  timerBar:SetHeight(28)
  timerBar:SetBackdrop({
    bgFile = "Interface/Buttons/WHITE8x8",
    edgeFile = "Interface/Buttons/WHITE8x8",
    edgeSize = 2,
  })
  timerBar:SetBackdropColor(0.15, 0.15, 0.17, 1)
  timerBar:SetBackdropBorderColor(0.90, 0.72, 0.18, 0.40)
  self.timerBar = timerBar
  local timerLabel = timerBar:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  timerLabel:SetFont(STANDARD_TEXT_FONT or "Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
  timerLabel:SetPoint("LEFT", 10, 0)
  timerLabel:SetText("SESSION")
  timerLabel:SetTextColor(0.63, 0.63, 0.75, 1)
  local timerValue = timerBar:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
  timerValue:SetFont(STANDARD_TEXT_FONT or "Fonts\\FRIZQT__.TTF", 18, "THICKOUTLINE")
  timerValue:SetPoint("RIGHT", -10, 0)
  timerValue:SetText("0:00")
  timerValue:SetTextColor(1, 0.85, 0.40, 1)
  timerValue:SetShadowColor(0, 0, 0, 1)
  timerValue:SetShadowOffset(1, -1)
  self.timerText = timerValue
  local buttonContainer = CreateFrame("Frame", nil, statsContainer)
  buttonContainer:SetPoint("TOPLEFT", 0, -86)
  buttonContainer:SetPoint("TOPRIGHT", 0, -86)
  buttonContainer:SetHeight(28)
  local pauseBtn = CreateFrame("Button", nil, buttonContainer, "BackdropTemplate")
  pauseBtn:SetPoint("LEFT", 0, 0)
  pauseBtn:SetPoint("RIGHT", buttonContainer, "CENTER", -2, 0)
  pauseBtn:SetHeight(28)
  pauseBtn:SetBackdrop({
    bgFile = "Interface/Buttons/WHITE8x8",
    edgeFile = "Interface/Buttons/WHITE8x8",
    edgeSize = 1,
  })
  pauseBtn:SetBackdropColor(0.16, 0.16, 0.20, 1)
  pauseBtn:SetBackdropBorderColor(0.90, 0.72, 0.18, 0.40)
  pauseBtn.text = pauseBtn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  pauseBtn.text:SetFont(STANDARD_TEXT_FONT or "Fonts\\FRIZQT__.TTF", 11, "OUTLINE")
  pauseBtn.text:SetPoint("CENTER", 0, 0)
  pauseBtn.text:SetText("START")
  pauseBtn.text:SetTextColor(0.30, 0.80, 0.40, 1)
  pauseBtn:SetScript("OnClick", function()
    local Farming = NS.UI.LumberTrackFarming
    if not Farming or not sharedCtx then return end
    if not sharedCtx.farming or not sharedCtx.farming.active then
      Farming:Start(sharedCtx, 0)
    else
      Farming:TogglePause(sharedCtx)
    end
    FarmingStats:UpdateStats()
  end)
  self.pauseBtn = pauseBtn
  local resetBtn = CreateFrame("Button", nil, buttonContainer, "BackdropTemplate")
  resetBtn:SetPoint("LEFT", buttonContainer, "CENTER", 2, 0)
  resetBtn:SetPoint("RIGHT", 0, 0)
  resetBtn:SetHeight(28)
  resetBtn:SetBackdrop({
    bgFile = "Interface/Buttons/WHITE8x8",
    edgeFile = "Interface/Buttons/WHITE8x8",
    edgeSize = 1,
  })
  resetBtn:SetBackdropColor(0.16, 0.16, 0.20, 1)
  resetBtn:SetBackdropBorderColor(0.80, 0.28, 0.28, 0.40)
  resetBtn.text = resetBtn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  resetBtn.text:SetFont(STANDARD_TEXT_FONT or "Fonts\\FRIZQT__.TTF", 11, "OUTLINE")
  resetBtn.text:SetPoint("CENTER", 0, 0)
  resetBtn.text:SetText("RESET")
  resetBtn.text:SetTextColor(1, 0.53, 0.53, 1)
  resetBtn:SetScript("OnClick", function()
    local Farming = NS.UI.LumberTrackFarming
    local Rate = NS.UI.LumberTrackRate
    if not sharedCtx then return end
    if Farming then Farming:Stop(sharedCtx) end
    if Rate then Rate:Clear() end
    if sharedCtx.farming then
      sharedCtx.farming.active = false
      sharedCtx.farming.totalGained = 0
    end
    FarmingStats:UpdateStats()
  end)
  self.resetBtn = resetBtn
  local collectingContainer = CreateFrame("Frame", nil, canvas, "BackdropTemplate")
  collectingContainer:SetPoint("TOPLEFT", 14, -162)
  collectingContainer:SetPoint("TOPRIGHT", -14, -162)
  collectingContainer:SetHeight(120)
  collectingContainer:SetBackdrop({
    bgFile = "Interface/Buttons/WHITE8x8",
    edgeFile = "Interface/Buttons/WHITE8x8",
    edgeSize = 2,
  })
  collectingContainer:SetBackdropColor(0.08, 0.08, 0.10, 1)
  collectingContainer:SetBackdropBorderColor(0.21, 0.21, 0.25, 1)
  local collectingTitle = collectingContainer:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  collectingTitle:SetFont(STANDARD_TEXT_FONT or "Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
  collectingTitle:SetPoint("TOPLEFT", 10, -8)
  collectingTitle:SetText("COLLECTING")
  collectingTitle:SetTextColor(0.63, 0.63, 0.75, 1)
  self.collectingContainer = collectingContainer
  if collapsed then
    collectingContainer:Hide()
  end
  local settings = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
  settings:SetFrameStrata("FULLSCREEN_DIALOG")
  settings:SetFrameLevel(500)
  settings:SetSize(320, 180)
  settings:Hide()
  Utils.CreateBackdrop(settings, T.panel or { 0.08, 0.08, 0.10, 0.95 }, T.border or { 0.24, 0.24, 0.28, 0.8 })
  local settingsTitle = settings:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
  settingsTitle:SetPoint("TOP", 0, -16)
  settingsTitle:SetText("Farming Settings")
  settingsTitle:SetTextColor(unpack(T.accent))
  local autoFarmCB = CreateFrame("CheckButton", nil, settings, "UICheckButtonTemplate")
  autoFarmCB:SetPoint("TOPLEFT", 20, -50)
  autoFarmCB:SetChecked((db and db.autoStartFarming) and true or false)
  local autoFarmLabel = settings:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  autoFarmLabel:SetPoint("LEFT", autoFarmCB, "RIGHT", 4, 0)
  autoFarmLabel:SetText("Auto Farm Mode")
  autoFarmLabel:SetTextColor(unpack(T.text or { 0.92, 0.92, 0.92, 1 }))
  autoFarmCB:SetScript("OnClick", function(self)
    local checked = self:GetChecked() and true or false
    if db then db.autoStartFarming = checked end
    if sharedCtx then sharedCtx.autoStartFarming = checked end
  end)
  local alphaLabel = settings:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  alphaLabel:SetPoint("TOPLEFT", 20, -90)
  alphaLabel:SetText("Transparency:")
  alphaLabel:SetTextColor(unpack(T.text or { 0.92, 0.92, 0.92, 1 }))
  local alphaSlider = CreateFrame("Slider", nil, settings, "OptionsSliderTemplate")
  alphaSlider:SetPoint("TOPLEFT", alphaLabel, "BOTTOMLEFT", 0, -10)
  alphaSlider:SetWidth(240)
  alphaSlider:SetMinMaxValues(0, 1)
  alphaSlider:SetValueStep(0.05)
  local alphaValue = settings:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  alphaValue:SetPoint("LEFT", alphaSlider, "RIGHT", 8, 0)
  alphaValue:SetText(string.format("%.0f%%", frame._bgAlpha * 100))
  local function applyStatsAlpha(showBackgrounds)
    local bg = showBackgrounds and { 0.06, 0.06, 0.07, frame._bgAlpha } or { 0, 0, 0, 0 }
    local borderOn = { 0.21, 0.21, 0.25, 1 }
    frame:SetBackdropColor(unpack(bg))
    frame:SetBackdropBorderColor(unpack(showBackgrounds and borderOn or { 0, 0, 0, 0 }))
    local headerBg = showBackgrounds and { 0.12, 0.12, 0.14, 1 } or { 0, 0, 0, 0 }
    local headerBorder = showBackgrounds and { 0.90, 0.72, 0.18, 0.5 } or { 0, 0, 0, 0 }
    if header then header:SetBackdropColor(unpack(headerBg)); header:SetBackdropBorderColor(unpack(headerBorder)) end
    local btnBg = showBackgrounds and { 0.08, 0.08, 0.10, 0.95 } or { 0, 0, 0, 0 }
    local btnBorder = showBackgrounds and { 0.24, 0.24, 0.28, 0.8 } or { 0, 0, 0, 0 }
    if collapseBtn then collapseBtn:SetBackdropColor(unpack(btnBg)); collapseBtn:SetBackdropBorderColor(unpack(btnBorder)) end
    if settingsBtn then settingsBtn:SetBackdropColor(unpack(btnBg)); settingsBtn:SetBackdropBorderColor(unpack(btnBorder)) end
    if closeBtn then closeBtn:SetBackdropColor(unpack(btnBg)); closeBtn:SetBackdropBorderColor(unpack(btnBorder)) end
    local boxBg = showBackgrounds and { 0.10, 0.10, 0.13, 1 } or { 0, 0, 0, 0 }
    local boxBorder = showBackgrounds and { 0.90, 0.72, 0.18, 0.30 } or { 0, 0, 0, 0 }
    if totalBox then totalBox:SetBackdropColor(unpack(boxBg)); totalBox:SetBackdropBorderColor(unpack(boxBorder)) end
    if bagsBox then bagsBox:SetBackdropColor(unpack(boxBg)); bagsBox:SetBackdropBorderColor(unpack(boxBorder)) end
    if perMinBox then perMinBox:SetBackdropColor(unpack(boxBg)); perMinBox:SetBackdropBorderColor(unpack(boxBorder)) end
    if perHourBox then perHourBox:SetBackdropColor(unpack(boxBg)); perHourBox:SetBackdropBorderColor(unpack(boxBorder)) end
    local barBg = showBackgrounds and { 0.15, 0.15, 0.17, 1 } or { 0, 0, 0, 0 }
    local barBorder = showBackgrounds and { 0.90, 0.72, 0.18, 0.40 } or { 0, 0, 0, 0 }
    if timerBar then timerBar:SetBackdropColor(unpack(barBg)); timerBar:SetBackdropBorderColor(unpack(barBorder)) end
    local pauseBg = showBackgrounds and { 0.16, 0.16, 0.20, 1 } or { 0, 0, 0, 0 }
    if pauseBtn then pauseBtn:SetBackdropColor(unpack(pauseBg)); pauseBtn:SetBackdropBorderColor(unpack(showBackgrounds and { 0.90, 0.72, 0.18, 0.40 } or { 0, 0, 0, 0 })) end
    if resetBtn then resetBtn:SetBackdropColor(unpack(pauseBg)); resetBtn:SetBackdropBorderColor(unpack(showBackgrounds and { 0.80, 0.28, 0.28, 0.40 } or { 0, 0, 0, 0 })) end
    if collectingContainer then collectingContainer:SetBackdropColor(unpack(showBackgrounds and { 0.08, 0.08, 0.10, 1 } or { 0, 0, 0, 0 })); collectingContainer:SetBackdropBorderColor(unpack(showBackgrounds and { 0.21, 0.21, 0.25, 1 } or { 0, 0, 0, 0 })) end
  end
  alphaSlider:SetScript("OnValueChanged", function(_, value)
    frame._bgAlpha = value
    alphaValue:SetText(string.format("%.0f%%", value * 100))
    local d = Utils.GetDB()
    if d then d.farmingStatsAlpha = value end
    applyStatsAlpha(value >= 0.3)
  end)
  self.settings = settings
  self.alphaSlider = alphaSlider
  if sharedCtx then
    sharedCtx.showRowBackgrounds = (frame._bgAlpha >= 0.3)
  end
  alphaSlider:SetValue(frame._bgAlpha)
  local function ToggleSettings()
    if settings:IsShown() then
      settings:Hide()
      return
    end
    autoFarmCB:SetChecked((db and db.autoStartFarming) and true or false)
    settings:ClearAllPoints()
    local frameX, frameY = frame:GetCenter()
    local frameTop = frameY + (frame:GetHeight() / 2)
    settings:SetPoint("TOP", UIParent, "BOTTOMLEFT", frameX, frameTop - 44)
    settings:Show()
    settings:Raise()
  end
  settingsBtn:SetScript("OnClick", ToggleSettings)
  do
    local b = CreateFrame("Button", nil, UIParent)
    settings._blocker = b
    b:SetAllPoints(UIParent)
    b:SetFrameStrata("FULLSCREEN_DIALOG")
    b:SetFrameLevel(settings:GetFrameLevel() - 1)
    b:EnableMouse(true)
    b:Hide()
    b:SetScript("OnClick", function() settings:Hide() end)
  end
  settings:SetScript("OnShow", function()
    settings._blocker:SetFrameLevel(settings:GetFrameLevel() - 1)
    settings._blocker:Show()
    settings:Raise()
  end)
  settings:SetScript("OnHide", function()
    settings._blocker:Hide()
  end)
  local resizeGrip = CreateFrame("Button", nil, frame)
  resizeGrip:SetSize(24, 24)
  resizeGrip:SetPoint("BOTTOMRIGHT", -1, 1)
  resizeGrip:SetFrameLevel(frame:GetFrameLevel() + 100)
  resizeGrip:EnableMouse(true)
  resizeGrip:RegisterForDrag("LeftButton")
  resizeGrip.tex = resizeGrip:CreateTexture(nil, "OVERLAY")
  resizeGrip.tex:SetAllPoints()
  resizeGrip.tex:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
  resizeGrip.tex:SetAlpha(0.8)
  resizeGrip:SetScript("OnEnter", function(self)
    self.tex:SetAlpha(1.0)
    self:SetSize(28, 28)
  end)
  resizeGrip:SetScript("OnLeave", function(self)
    self.tex:SetAlpha(0.8)
    self:SetSize(24, 24)
  end)
  resizeGrip:SetScript("OnDragStart", function()
    frame._isResizing = true
    frame._resizeStartW, frame._resizeStartH = frame:GetSize()
    frame._resizeStartX, frame._resizeStartY = GetCursorPosition()
    local scale = UIParent:GetEffectiveScale()
    frame._resizeStartX = frame._resizeStartX / scale
    frame._resizeStartY = frame._resizeStartY / scale
  end)
  resizeGrip:SetScript("OnDragStop", function()
    frame._isResizing = false
    local ww, hh = frame:GetSize()
    local isCollapsed = db.farmingStatsCollapsed and true or false
    local BASE_W = 300
    local targetScaleFactor = ww / BASE_W
    local MIN_FACTOR = 0.7
    local MAX_FACTOR = 1.5
    targetScaleFactor = Utils.Clamp(targetScaleFactor, MIN_FACTOR, MAX_FACTOR)
    local MIN_SCALE_VAL = 25
    local MAX_SCALE_VAL = 100
    local normalized = (targetScaleFactor - MIN_FACTOR) / (MAX_FACTOR - MIN_FACTOR)
    local newSliderValue = MIN_SCALE_VAL + (normalized * (MAX_SCALE_VAL - MIN_SCALE_VAL))
    newSliderValue = math.floor(newSliderValue / 5 + 0.5) * 5
    if db then
      if isCollapsed then
        db.farmingStatsScaleCollapsed = newSliderValue
        db.farmingStatsWidthCollapsed = ww
        db.farmingStatsHeightCollapsed = hh
      else
        db.farmingStatsScale = newSliderValue
        db.farmingStatsWidth = ww
        db.farmingStatsHeight = hh
      end
    end
  end)
  resizeGrip:SetScript("OnUpdate", function(self, elapsed)
    if not frame._isResizing then return end
    local cursorX, cursorY = GetCursorPosition()
    local scale = UIParent:GetEffectiveScale()
    cursorX = cursorX / scale
    cursorY = cursorY / scale
    local deltaX = cursorX - frame._resizeStartX
    local deltaY = frame._resizeStartY - cursorY
    local delta = math.max(deltaX, deltaY)
    local isCollapsed = db.farmingStatsCollapsed and true or false
    local BASE_W = 300
    local BASE_H = isCollapsed and 166 or 300
    local aspectRatio = BASE_W / BASE_H
    local newW = frame._resizeStartW + delta
    local newH = newW / aspectRatio
    local MIN_FACTOR = 0.7
    local MAX_FACTOR = 1.5
    local minW = math.floor(BASE_W * MIN_FACTOR)
    local maxW = math.floor(BASE_W * MAX_FACTOR)
    local minH = math.floor(BASE_H * MIN_FACTOR)
    local maxH = math.floor(BASE_H * MAX_FACTOR)
    newW = Utils.Clamp(newW, minW, maxW)
    newH = Utils.Clamp(newH, minH, maxH)
    if newW / newH ~= aspectRatio then
      newW = newH * aspectRatio
    end
    frame:SetSize(newW, newH)
    local scaleFactor = newW / BASE_W
    scaleFactor = Utils.Clamp(scaleFactor, MIN_FACTOR, MAX_FACTOR)
    canvas:SetScale(scaleFactor)
  end)
  local MIN_FACTOR = 0.7
  local MAX_FACTOR = 1.5
  local BASE_W = 300
  local BASE_H = collapsed and 166 or 300
  local minW = math.floor(BASE_W * MIN_FACTOR)
  local maxW = math.floor(BASE_W * MAX_FACTOR)
  local minH = math.floor(BASE_H * MIN_FACTOR)
  local maxH = math.floor(BASE_H * MAX_FACTOR)
  frame:SetResizeBounds(minW, minH, maxW, maxH)
  frame:SetScript("OnSizeChanged", nil)
  self.resizeGrip = resizeGrip
  self.sharedCtx = sharedCtx
  frame:SetScript("OnUpdate", function(self, elapsed)
    self._updateTimer = (self._updateTimer or 0) + elapsed
    if self._updateTimer >= 0.5 then
      self._updateTimer = 0
      FarmingStats:UpdateStats()
    end
  end)
  local Farming = NS.UI.LumberTrackFarming
  if Farming and Farming.Init and sharedCtx then
    Farming:Init(sharedCtx)
  end
  frame:HookScript("OnHide", function()
    local d = Utils.GetDB()
    if d then
      d.farmingStatsOpen = false
      if frame._bgAlpha then
        d.farmingStatsAlpha = Utils.Clamp(frame._bgAlpha or d.farmingStatsAlpha or 0.7, 0, 1)
      end
    end
  end)
end
function FarmingStats:UpdateStats()
  if not self.frame or not self.sharedCtx then return end
  local Farming = NS.UI.LumberTrackFarming
  local Rate = NS.UI.LumberTrackRate
  if not Farming then return end
  local stats = Farming:GetStats(self.sharedCtx)
  if self.totalText then
    self.totalText:SetText(Utils.FormatNumberCompact(stats.totalGained or 0))
  end
  if self.bagsText then
    local recentItemID = Rate and Rate:GetMostRecentItem()
    if recentItemID and self.sharedCtx.counts and self.sharedCtx.counts[recentItemID] then
      local bagCount = self.sharedCtx.counts[recentItemID] or 0
      self.bagsText:SetText(Utils.FormatNumberCompact(bagCount))
    else
      self.bagsText:SetText("0")
    end
  end
  if self.perMinText then
    self.perMinText:SetText(Utils.FormatNumberCompact(math.floor(stats.perMinute or 0)))
  end
  if self.perHourText then
    local perHour = (stats.perMinute or 0) * 60
    self.perHourText:SetText(Utils.FormatNumberCompact(math.floor(perHour)))
  end
  if self.timerText then
    self.timerText:SetText(stats.sessionTime or "0:00")
  end
  if self.pauseBtn and self.sharedCtx.farming then
    if not self.sharedCtx.farming.active then
      self.pauseBtn.text:SetText("START")
      self.pauseBtn.text:SetTextColor(0.30, 0.80, 0.40, 1)
    elseif self.sharedCtx.farming.paused then
      self.pauseBtn.text:SetText("RESUME")
      self.pauseBtn.text:SetTextColor(0.30, 0.80, 0.40, 1)
    else
      self.pauseBtn.text:SetText("PAUSE")
      self.pauseBtn.text:SetTextColor(1, 0.85, 0.40, 1)
    end
  end
  if self.title then
    local recentItemID = Rate and Rate:GetMostRecentItem()
    if recentItemID and self.sharedCtx.meta and self.sharedCtx.meta[recentItemID] then
      local lumberName = self.sharedCtx.meta[recentItemID].name
      if lumberName and type(lumberName) == "string" then
        lumberName = lumberName:gsub(" Lumber$", "")
        self.title:SetText(lumberName .. " ")
      else
        self.title:SetText("Farming Stats")
      end
    else
      self.title:SetText("Farming Stats")
    end
  end
end
function FarmingStats:ToggleCollapsed()
  if not self.frame or not self.canvas then return end
  local db = Utils.GetDB()
  local wasCollapsed = db.farmingStatsCollapsed and true or false
  db.farmingStatsCollapsed = not wasCollapsed
  local nowCollapsed = db.farmingStatsCollapsed
  if self.collectingContainer then
    if nowCollapsed then
      self.collectingContainer:Hide()
    else
      self.collectingContainer:Show()
    end
  end
  if self.collapseBtn and self.collapseBtn.icon then
    self.collapseBtn.icon:SetRotation(nowCollapsed and 0 or -1.5708)
  end
  local savedScale = nowCollapsed and (db.farmingStatsScaleCollapsed or 60) or (db.farmingStatsScale or 60)
  local MIN_SCALE_VAL = 25
  local MAX_SCALE_VAL = 100
  local MIN_FACTOR = 0.7
  local MAX_FACTOR = 1.5
  savedScale = Utils.Clamp(savedScale, MIN_SCALE_VAL, MAX_SCALE_VAL)
  local range = MAX_SCALE_VAL - MIN_SCALE_VAL
  local normalized = (savedScale - MIN_SCALE_VAL) / range
  local scaleFactor = MIN_FACTOR + normalized * (MAX_FACTOR - MIN_FACTOR)
  local BASE_W = 300
  local BASE_H = nowCollapsed and 166 or 300
  local newW = math.floor(BASE_W * scaleFactor + 0.5)
  local newH = math.floor(BASE_H * scaleFactor + 0.5)
  self.frame:SetSize(newW, newH)
  local minW = math.floor(BASE_W * MIN_FACTOR)
  local maxW = math.floor(BASE_W * MAX_FACTOR)
  local minH = math.floor(BASE_H * MIN_FACTOR)
  local maxH = math.floor(BASE_H * MAX_FACTOR)
  self.frame:SetResizeBounds(minW, minH, maxW, maxH)
  self.canvas:SetScale(scaleFactor)
end
function FarmingStats:Show()
  if not self.frame then return end
  self.frame:Show()
  self.frame:Raise()
  local db = Utils.GetDB()
  if db then db.farmingStatsOpen = true end
  self:UpdateStats()
end
function FarmingStats:Hide()
  if not self.frame then return end
  self.frame:Hide()
  local db = Utils.GetDB()
  if db then
    db.farmingStatsOpen = false
    if self.frame._bgAlpha then
      db.farmingStatsAlpha = self.frame._bgAlpha
    end
  end
end
function FarmingStats:Toggle()
  if not self.frame then return end
  if self.frame:IsShown() then
    self:Hide()
  else
    self:Show()
  end
end
return FarmingStats