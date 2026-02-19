local ADDON, NS = ...
NS.UI = NS.UI or {}

local LumberList = NS.UI.LumberTrackLumberList or {}
NS.UI.LumberTrackLumberList = LumberList

local Utils = NS.LT.Utils
local Settings = NS.UI.LumberTrackSettings
local CreateFrame = CreateFrame
local unpack = unpack or table.unpack

function LumberList:Create(sharedCtx)
  if self.frame then return end
  local db = Utils.GetDB()

  local AccountWide = NS.UI.LumberTrackAccountWide
  if AccountWide and db.accountWide ~= nil then
    AccountWide:SetEnabled(db.accountWide)
  end

  local T = Utils.GetTheme()
  local frame = CreateFrame("Frame", "HomeDecorLumberList", UIParent, "BackdropTemplate")
  self.frame = frame
  self.sharedCtx = sharedCtx
  if sharedCtx then
    sharedCtx.lumberListFrame = frame
  end
  local w = tonumber(db.lumberListWidth) or 380
  local h = tonumber(db.lumberListHeight) or 520
  frame:SetSize(w, h)
  local point = db.lumberListPoint or "TOPRIGHT"
  local relPoint = db.lumberListRelPoint or "TOPRIGHT"
  local x = tonumber(db.lumberListX) or -360
  local y = tonumber(db.lumberListY) or -80
  frame:SetPoint(point, UIParent, relPoint, x, y)
  frame:SetFrameStrata("DIALOG")
  frame:SetFrameLevel(200)
  frame:SetToplevel(true)
  frame:SetClampedToScreen(true)
  frame:SetResizable(true)
  frame:SetMovable(true)
  frame:EnableMouse(true)
  frame:Hide()
  frame._bgAlpha = tonumber(db and db.alpha) or 1
  frame._collapsed = db.lumberListCollapsed and true or false
  Utils.CreateBackdrop(frame, T.panel, T.border)
  local savedAlpha = frame._bgAlpha
  if savedAlpha < 1 then
    frame:SetBackdropColor(T.panel[1], T.panel[2], T.panel[3], T.panel[4] * savedAlpha)
  end
  local header = CreateFrame("Frame", nil, frame, "BackdropTemplate")
  header:SetPoint("TOPLEFT", 6, -6)
  header:SetPoint("TOPRIGHT", -6, -6)
  header:SetHeight(32)
  Utils.CreateBackdrop(header, T.header, T.border)
  header:EnableMouse(true)
  header:RegisterForDrag("LeftButton")
  header:SetScript("OnDragStart", function() frame:StartMoving() end)
  header:SetScript("OnDragStop", function()
    frame:StopMovingOrSizing()
    local pt, relTo, relPt, xPos, yPos = frame:GetPoint(1)
    if pt and db then
      db.lumberListPoint = pt
      db.lumberListRelPoint = relPt
      db.lumberListX = xPos
      db.lumberListY = yPos
    end
  end)
  local collapseBtn = CreateFrame("Button", nil, header, "BackdropTemplate")
  collapseBtn:SetSize(26, 26)
  collapseBtn:SetPoint("LEFT", 10, 0)
  Utils.CreateBackdrop(collapseBtn, T.row, T.border)
  collapseBtn.icon = collapseBtn:CreateTexture(nil, "OVERLAY")
  collapseBtn.icon:SetSize(14, 14)
  collapseBtn.icon:SetPoint("CENTER")
  collapseBtn.icon:SetTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
  collapseBtn.icon:SetRotation(-1.5708)
  collapseBtn:SetScript("OnEnter", function(self)
    self:SetBackdropBorderColor(unpack(T.accentBright or T.accent))
  end)
  collapseBtn:SetScript("OnLeave", function(self)
    self:SetBackdropBorderColor(unpack(T.border))
  end)
  frame._collapsed = false
  collapseBtn:SetScript("OnClick", function()
    LumberList:ToggleCollapsed()
  end)
  self.collapseBtn = collapseBtn
  local title = header:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
  title:SetPoint("CENTER", 0, 0)
  title:SetText("Lumber Tracker")
  title:SetTextColor(unpack(T.accent))
  local settingsBtn = CreateFrame("Button", nil, header, "BackdropTemplate")
  settingsBtn:SetSize(26, 26)
  settingsBtn:SetPoint("RIGHT", -40, 0)
  Utils.CreateBackdrop(settingsBtn, T.row, T.border)
  settingsBtn.icon = settingsBtn:CreateTexture(nil, "OVERLAY")
  settingsBtn.icon:SetSize(14, 14)
  settingsBtn.icon:SetPoint("CENTER")
  settingsBtn.icon:SetTexture("Interface\\Buttons\\UI-OptionsButton")
  settingsBtn:SetScript("OnEnter", function(self)
    self:SetBackdropBorderColor(unpack(T.accentBright or T.accent))
  end)
  settingsBtn:SetScript("OnLeave", function(self)
    self:SetBackdropBorderColor(unpack(T.border))
  end)
  self.settingsBtn = settingsBtn

  local compactBtn = CreateFrame("Button", nil, header, "BackdropTemplate")
  compactBtn:SetSize(26, 26)
  compactBtn:SetPoint("LEFT", collapseBtn, "RIGHT", 4, 0)
  Utils.CreateBackdrop(compactBtn, T.row, T.border)
  compactBtn.icon = compactBtn:CreateTexture(nil, "OVERLAY")
  compactBtn.icon:SetSize(14, 14)
  compactBtn.icon:SetPoint("CENTER")
  compactBtn.icon:SetTexture("Interface\\Buttons\\UI-GuildButton-OfficerNote-Up")
  compactBtn:SetScript("OnEnter", function(self)
    self:SetBackdropBorderColor(unpack(T.accentBright or T.accent))
    if GameTooltip then
      GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
      GameTooltip:AddLine("Compact Mode", 1, 1, 1)
      GameTooltip:AddLine("Toggle compact single-line view", 0.7, 0.7, 0.7)
      GameTooltip:Show()
    end
  end)
  compactBtn:SetScript("OnLeave", function(self)
    self:SetBackdropBorderColor(unpack(T.border))
    if GameTooltip then GameTooltip:Hide() end
  end)
  local function UpdateCompactBtnAppearance()
    local Tx = Utils.GetTheme()
    if sharedCtx and sharedCtx.compactMode then
      compactBtn:SetBackdropBorderColor(unpack(Tx.accentBright or Tx.accent))
      compactBtn.icon:SetVertexColor(unpack(Tx.accent))
    else
      compactBtn:SetBackdropBorderColor(unpack(Tx.border))
      compactBtn.icon:SetVertexColor(0.6, 0.6, 0.6, 1)
    end
  end
  compactBtn:SetScript("OnClick", function()
    if not sharedCtx then return end
    local newVal = not (sharedCtx.compactMode and true or false)
    sharedCtx.compactMode = newVal
    local d = Utils.GetDB()
    if d then d.compactMode = newVal end
    if sharedCtx.rows then
      for i, row in pairs(sharedCtx.rows) do
        if row then row:Hide(); row:SetParent(nil) end
        sharedCtx.rows[i] = nil
      end
    end
    UpdateCompactBtnAppearance()
    local Render = NS.UI.LumberTrackRender
    if Render and Render.Refresh then Render:Refresh(sharedCtx) end
  end)
  self.compactBtn = compactBtn
  UpdateCompactBtnAppearance()
  local closeBtn = CreateFrame("Button", nil, header, "BackdropTemplate")
  closeBtn:SetSize(26, 26)
  closeBtn:SetPoint("RIGHT", -10, 0)
  Utils.CreateBackdrop(closeBtn, T.row, T.border)
  closeBtn.icon = closeBtn:CreateTexture(nil, "OVERLAY")
  closeBtn.icon:SetSize(14, 14)
  closeBtn.icon:SetPoint("CENTER")
  closeBtn.icon:SetTexture("Interface\\Buttons\\UI-StopButton")
  closeBtn.icon:SetVertexColor(1, 0.82, 0.2, 1)
  closeBtn:SetScript("OnEnter", function(self)
    self:SetBackdropBorderColor(unpack(T.accentBright or T.accent))
  end)
  closeBtn:SetScript("OnLeave", function(self)
    self:SetBackdropBorderColor(unpack(T.border))
  end)
  closeBtn:SetScript("OnClick", function()
    LumberList:Hide()
  end)
  self.closeBtn = closeBtn
  local searchContainer = CreateFrame("Frame", nil, frame, "BackdropTemplate")
  searchContainer:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 0, -4)
  searchContainer:SetPoint("TOPRIGHT", header, "BOTTOMRIGHT", 0, -4)
  searchContainer:SetHeight(44)
  Utils.CreateBackdrop(searchContainer, T.panel, T.border)
  if sharedCtx then
    sharedCtx.searchContainer = searchContainer
  end
  local searchBox = CreateFrame("EditBox", nil, searchContainer, "BackdropTemplate")
  searchBox:SetPoint("LEFT", 12, 0)
  searchBox:SetPoint("RIGHT", -12, 0)
  searchBox:SetHeight(26)
  searchBox:SetAutoFocus(false)
  searchBox:SetFontObject(GameFontHighlight)
  searchBox:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
  searchBox:SetScript("OnEnterPressed", function(self) self:ClearFocus() end)
  searchBox:SetScript("OnTextChanged", function(self)
    local text = self:GetText():lower()
    if sharedCtx then
      sharedCtx.search = text
      local Render = NS.UI.LumberTrackRender
      if Render and Render.Refresh then
        Render:Refresh(sharedCtx)
      end
    end
    if db then db.search = text end
  end)
  Utils.CreateBackdrop(searchBox, T.row, T.border)
  self.searchBox = searchBox
  local searchIcon = searchBox:CreateTexture(nil, "OVERLAY")
  searchIcon:SetSize(16, 16)
  searchIcon:SetPoint("LEFT", 6, 0)
  searchIcon:SetTexture("Interface\\Common\\UI-Searchbox-Icon")
  searchIcon:SetVertexColor(0.6, 0.6, 0.6, 1)
  local scroll = CreateFrame("ScrollFrame", nil, frame, "ScrollFrameTemplate")
  local Controls = NS.UI and NS.UI.Controls
  if Controls and Controls.SkinScrollFrame then
    Controls:SkinScrollFrame(scroll)
  end
  scroll:SetPoint("TOPLEFT", searchContainer, "BOTTOMLEFT", 6, -4)
  scroll:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -24, 50)
  local content = CreateFrame("Frame", nil, scroll)
  content:SetSize(1, 1)
  scroll:SetScrollChild(content)
  if sharedCtx then
    sharedCtx.content = content
    sharedCtx.scroll = scroll
    sharedCtx.searchBox = searchBox
  end
  local function SyncContentWidth()
    local sw = scroll:GetWidth()
    if sw and sw > 1 then
      content:SetWidth(sw)
    end
  end
  scroll:SetScript("OnSizeChanged", function()
    SyncContentWidth()
  end)
  frame:HookScript("OnShow", function()
    C_Timer.After(0, SyncContentWidth)
  end)
  local footer = CreateFrame("Frame", nil, frame, "BackdropTemplate")
  footer:SetPoint("BOTTOMLEFT", 6, 6)
  footer:SetPoint("BOTTOMRIGHT", -6, 6)
  footer:SetHeight(44)
  Utils.CreateBackdrop(footer, T.panel, T.border)
  if sharedCtx then
    sharedCtx.footer = footer
  end
  local totalText = footer:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  totalText:SetPoint("LEFT", 12, 0)
  totalText:SetText("Lumber Total: 0")
  totalText:SetTextColor(unpack(T.text))
  if sharedCtx then
    sharedCtx.totalText = totalText
  end
  local startFarmingBtn = CreateFrame("Button", nil, footer, "BackdropTemplate")
  startFarmingBtn:SetPoint("RIGHT", -12, 0)
  startFarmingBtn:SetSize(120, 28)
  Utils.CreateBackdrop(startFarmingBtn, T.row, T.border)
  startFarmingBtn.text = startFarmingBtn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  startFarmingBtn.text:SetFont("Fonts\\FRIZQT__.TTF", 11, "OUTLINE")
  startFarmingBtn.text:SetPoint("CENTER", 0, 0)
  startFarmingBtn.text:SetText("START FARMING")
  startFarmingBtn.text:SetTextColor(unpack(T.success))
  startFarmingBtn:SetScript("OnEnter", function(self)
    self:SetBackdropBorderColor(unpack(T.accentBright or T.accent))
  end)
  startFarmingBtn:SetScript("OnLeave", function(self)
    self:SetBackdropBorderColor(unpack(T.border))
  end)
  startFarmingBtn:SetScript("OnClick", function()
    local Farming = NS.UI.LumberTrackFarming
    local FarmingStats = NS.UI.LumberTrackFarmingStats
    if Farming and sharedCtx then
      Farming:Start(sharedCtx, 0)
      if FarmingStats and FarmingStats.Show then
        FarmingStats:Show()
      end
    end
  end)
  self.startFarmingBtn = startFarmingBtn

  local function applyListAlpha(value, showBackgrounds)
    local Tx = Utils.GetTheme()
    if showBackgrounds then
      frame:SetBackdropColor(Tx.panel[1], Tx.panel[2], Tx.panel[3], (Tx.panel[4] or 1) * value)
      frame:SetBackdropBorderColor(unpack(Tx.border or {}))
      header:SetBackdropColor(Tx.header[1], Tx.header[2], Tx.header[3], (Tx.header[4] or 1) * value)
      header:SetBackdropBorderColor(unpack(Tx.border or {}))
      searchContainer:SetBackdropColor(Tx.panel[1], Tx.panel[2], Tx.panel[3], (Tx.panel[4] or 1) * value)
      searchContainer:SetBackdropBorderColor(unpack(Tx.border or {}))
      footer:SetBackdropColor(Tx.panel[1], Tx.panel[2], Tx.panel[3], (Tx.panel[4] or 1) * value)
      footer:SetBackdropBorderColor(unpack(Tx.border or {}))
      if collapseBtn then collapseBtn:SetBackdropColor(unpack(Tx.row or {})); collapseBtn:SetBackdropBorderColor(unpack(Tx.border or {})) end
      if settingsBtn then settingsBtn:SetBackdropColor(unpack(Tx.row or {})); settingsBtn:SetBackdropBorderColor(unpack(Tx.border or {})) end
      if closeBtn then closeBtn:SetBackdropColor(unpack(Tx.row or {})); closeBtn:SetBackdropBorderColor(unpack(Tx.border or {})) end
      if searchBox then searchBox:SetBackdropColor(Tx.row[1], Tx.row[2], Tx.row[3], (Tx.row[4] or 1) * 0.7); searchBox:SetBackdropBorderColor(unpack(Tx.border or {})) end
      if startFarmingBtn then startFarmingBtn:SetBackdropColor(unpack(Tx.panel or {})); startFarmingBtn:SetBackdropBorderColor(unpack(Tx.border or {})) end
    else
      frame:SetBackdropColor(0, 0, 0, 0); frame:SetBackdropBorderColor(0, 0, 0, 0)
      header:SetBackdropColor(0, 0, 0, 0); header:SetBackdropBorderColor(0, 0, 0, 0)
      searchContainer:SetBackdropColor(0, 0, 0, 0); searchContainer:SetBackdropBorderColor(0, 0, 0, 0)
      footer:SetBackdropColor(0, 0, 0, 0); footer:SetBackdropBorderColor(0, 0, 0, 0)
      if collapseBtn then collapseBtn:SetBackdropColor(0, 0, 0, 0); collapseBtn:SetBackdropBorderColor(0, 0, 0, 0) end
      if settingsBtn then settingsBtn:SetBackdropColor(0, 0, 0, 0); settingsBtn:SetBackdropBorderColor(0, 0, 0, 0) end
      if closeBtn then closeBtn:SetBackdropColor(0, 0, 0, 0); closeBtn:SetBackdropBorderColor(0, 0, 0, 0) end
      if searchBox then searchBox:SetBackdropColor(0, 0, 0, 0.1); searchBox:SetBackdropBorderColor(0, 0, 0, 0) end
      if startFarmingBtn then startFarmingBtn:SetBackdropColor(0, 0, 0, 0); startFarmingBtn:SetBackdropBorderColor(0, 0, 0, 0) end
    end
  end
  local settings = Settings and Settings:CreatePanel(frame, sharedCtx, applyListAlpha)
  if settings then
    self.settings = settings
    self.slider = settings.slider
    local function ToggleSettings()
      if settings:IsShown() then settings:Hide(); return end
      if Settings and Settings.RefreshPanel then Settings:RefreshPanel(settings, sharedCtx) end
      settings:ClearAllPoints()
      settings:SetPoint("TOP", header, "BOTTOM", 0, -8)
      settings:Show()
      settings:Raise()
    end
    settingsBtn:SetScript("OnClick", ToggleSettings)
    do
      local b = CreateFrame("Button", nil, UIParent)
      settings._blocker = b
      b:SetAllPoints(UIParent)
      b:SetFrameStrata("DIALOG")
      b:SetFrameLevel(settings:GetFrameLevel() - 1)
      b:EnableMouse(true)
      b:Hide()
      b:SetScript("OnClick", function() settings:Hide() end)
    end
    settings:SetScript("OnShow", function()
      if settings._blocker then settings._blocker:SetFrameLevel(settings:GetFrameLevel() - 1); settings._blocker:Show(); settings:Raise() end
    end)
    settings:SetScript("OnHide", function()
      if settings._blocker then settings._blocker:Hide() end
    end)
  end

  local resizeGrip = CreateFrame("Button", nil, frame)
  resizeGrip:SetSize(18, 18)
  resizeGrip:SetPoint("BOTTOMRIGHT", -2, 2)
  resizeGrip:EnableMouse(true)
  resizeGrip:RegisterForDrag("LeftButton")
  resizeGrip.tex = resizeGrip:CreateTexture(nil, "OVERLAY")
  resizeGrip.tex:SetAllPoints()
  resizeGrip.tex:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
  resizeGrip:SetScript("OnDragStart", function()
    frame:StartSizing("BOTTOMRIGHT")
  end)
  resizeGrip:SetScript("OnDragStop", function()
    frame:StopMovingOrSizing()
    local ww, hh = frame:GetSize()
    if db then
      db.lumberListWidth = ww
      db.lumberListHeight = hh
    end
    local Rows = NS.UI.LumberTrackRows
    if Rows and Rows.Reflow and sharedCtx then
      C_Timer.After(0.1, function()
        Rows:Reflow(sharedCtx)
      end)
    end
  end)
  frame:SetResizeBounds(280, 280, 480, 720)
  if frame._collapsed then
    if sharedCtx then
      if sharedCtx.searchContainer then sharedCtx.searchContainer:Hide() end
      if sharedCtx.scroll then sharedCtx.scroll:Hide() end
      if sharedCtx.footer then sharedCtx.footer:Hide() end
    end
    if self.collapseBtn and self.collapseBtn.icon then
      self.collapseBtn.icon:SetRotation(0)
    end
    local targetW = tonumber(db.lumberListWidthCollapsed) or 300
    local targetH = tonumber(db.lumberListHeightCollapsed) or 44
    frame:SetSize(targetW, targetH)
  end
  if sharedCtx then
    local Render = NS.UI.LumberTrackRender
    if Render and Render.Refresh then
      Render:Refresh(sharedCtx)
    end
  end
  frame:HookScript("OnHide", function()
    local d = Utils.GetDB()
    if d then
      d.lumberListOpen = false
      if frame._bgAlpha then
        d.alpha = Utils.Clamp(frame._bgAlpha or d.alpha or 0.7, 0, 1)
      end
    end
  end)
end
function LumberList:ToggleCollapsed()
  if not self.frame then return end
  local db = Utils.GetDB()
  local wasCollapsed = self.frame._collapsed
  local currentW, currentH = self.frame:GetWidth(), self.frame:GetHeight()
  if wasCollapsed then
    db.lumberListWidthCollapsed = currentW
    db.lumberListHeightCollapsed = currentH
  else
    db.lumberListWidth = currentW
    db.lumberListHeight = currentH
  end
  self.frame._collapsed = not wasCollapsed
  db.lumberListCollapsed = self.frame._collapsed
  if self.sharedCtx then
    if self.frame._collapsed then
      if self.sharedCtx.searchContainer then self.sharedCtx.searchContainer:Hide() end
      if self.sharedCtx.scroll then self.sharedCtx.scroll:Hide() end
      if self.sharedCtx.footer then self.sharedCtx.footer:Hide() end
    else
      if self.sharedCtx.searchContainer then self.sharedCtx.searchContainer:Show() end
      if self.sharedCtx.scroll then self.sharedCtx.scroll:Show() end
      if self.sharedCtx.footer then self.sharedCtx.footer:Show() end
    end
  end
  if self.collapseBtn and self.collapseBtn.icon then
    self.collapseBtn.icon:SetRotation(self.frame._collapsed and 0 or -1.5708)
  end
  local targetW = self.frame._collapsed and (tonumber(db.lumberListWidthCollapsed) or 300) or (tonumber(db.lumberListWidth) or 380)
  local targetH = self.frame._collapsed and (tonumber(db.lumberListHeightCollapsed) or 44) or (tonumber(db.lumberListHeight) or 520)
  self.frame:SetSize(targetW, targetH)
end
function LumberList:Show()
  if not self.frame then return end
  self.frame:Show()
  self.frame:Raise()
  if self.sharedCtx then
    local Render = NS.UI.LumberTrackRender
    if Render and Render.Refresh then
      Render:Refresh(self.sharedCtx)
    end
  end
  local db = Utils.GetDB()
  if db then db.lumberListOpen = true end
end
function LumberList:Hide()
  if not self.frame then return end
  self.frame:Hide()
  local db = Utils.GetDB()
  if db then
    db.lumberListOpen = false
    if self.frame._bgAlpha then
      db.alpha = self.frame._bgAlpha
    end
  end
end
function LumberList:Toggle()
  if not self.frame then return end
  if self.frame:IsShown() then
    self:Hide()
  else
    self:Show()
  end
end
return LumberList