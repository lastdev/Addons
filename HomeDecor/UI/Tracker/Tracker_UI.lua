local ADDON, NS = ...
NS.UI = NS.UI or {}

local Tracker = NS.UI.Tracker or {}
NS.UI.Tracker = Tracker

local UI = NS.UI.TrackerUI or {}
NS.UI.TrackerUI = UI
Tracker.UI = UI

local Controls = NS.UI.Controls
local ProgressBar = NS.UI.ProgressBar
local Rows = NS.UI.TrackerRows
local RowStyles = NS.UI.RowStyles
local U = NS.UI.TrackerUtil

local floor = math.floor
local max = math.max
local fmt = string.format
local unpack = _G.unpack or table.unpack

local function GetThemeColors()
  local theme = NS.UI and NS.UI.Theme
  return (theme and theme.colors) or {}
end

local function Clamp(v, a, b)
  return (U and U.Clamp and U.Clamp(v, a, b)) or (v < a and a or (v > b and b or v))
end

local function ApplyRegionAlpha(root, a)
  if not root or not root.GetRegions then return end
  a = Clamp(tonumber(a) or 1, 0, 1)

  local regions = { root:GetRegions() }
  for i = 1, #regions do
    local r = regions[i]
    if r and r.GetObjectType and r:GetObjectType() == "Texture" and r.GetDrawLayer then
      local layer = r:GetDrawLayer()
      if (layer == "BACKGROUND" or layer == "BORDER") and r.SetAlpha then
        local name = r.GetName and r:GetName() or nil
        if not name or (not name:find("Icon") and not name:find("icon")) then
          r:SetAlpha(a)
        end
      end
    end
  end
end

local function NextGlobalName(prefix)
  local ui = NS.UI
  ui.__uid = (ui.__uid or 0) + 1
  local n = ui.__uid
  local name = prefix .. tostring(n)
  while _G[name] do
    n = n + 1
    ui.__uid = n
    name = prefix .. tostring(n)
  end
  return name
end

local function GetTrackerDB()
  return U and U.GetTrackerDB and U.GetTrackerDB()
end

local function ReadSizeFromDB(db, defaultW, defaultH)
  if not db then return defaultW, defaultH end
  local size = db.size
  local w = tonumber(db.width) or (size and tonumber(size.w)) or defaultW
  local h = tonumber(db.height) or (size and tonumber(size.h)) or defaultH
  return w, h
end

local function ReadPositionFromDB(db)
  local p = db and (db.pos or db)
  local point = (p and p.point) or "TOPRIGHT"
  local relPoint = (p and p.relPoint) or point
  local x = tonumber(p and p.x) or -40
  local y = tonumber(p and p.y) or -80
  return point, relPoint, x, y
end

local function WritePositionToDB(db, point, relPoint, x, y)
  if not db then return end
  local pos = db.pos
  if type(pos) ~= "table" then
    pos = {}
    db.pos = pos
  end

  pos.point = point
  pos.relPoint = relPoint or point
  pos.x = tonumber(x) or 0
  pos.y = tonumber(y) or 0

  db.point, db.relPoint, db.x, db.y = pos.point, pos.relPoint, pos.x, pos.y
end

function UI:CreateFrame()
  local T = GetThemeColors()

  local frame = CreateFrame("Frame", "HomeDecorTracker", UIParent, "BackdropTemplate")

  local db = GetTrackerDB()
  local w, h = ReadSizeFromDB(db, 310, 520)
  frame:SetSize(w, h)

  do
    local point, relPoint, x, y = ReadPositionFromDB(db)
    frame:ClearAllPoints()
    frame:SetPoint(point, UIParent, relPoint, x, y)
  end

  frame:SetFrameStrata("DIALOG")
  frame:SetFrameLevel(220)
  frame:SetToplevel(true)
  frame:SetClampedToScreen(true)
  frame:SetResizable(true)
  frame:Hide()

  frame._minW, frame._maxW = 260, 420
  frame._minH, frame._maxH = 220, 720
  frame._pendingRefresh = false
  frame._bgAlpha = 1
  frame._hideCompleted = false
  frame._openVendors = frame._openVendors or {}
  frame._collapsed = false
  frame._lastSize = { w = frame:GetWidth(), h = frame:GetHeight() }

  if Controls and Controls.Backdrop then
    Controls:Backdrop(frame, T.panel, T.border)
    if Controls.ApplyBackground and NS.UI and NS.UI.Theme and NS.UI.Theme.textures then
      Controls:ApplyBackground(frame, NS.UI.Theme.textures.PanelBG or NS.UI.Theme.textures.MainBackground, 6, 1)
    end
  end

  local function SaveFramePosition()
    local d = GetTrackerDB()
    if not d then return end
    local point, relTo, relPoint, x, y = frame:GetPoint(1)
    if not point then return end
    WritePositionToDB(d, point, relPoint, x, y)
  end

  frame:SetScript("OnHide", SaveFramePosition)

  frame:HookScript("OnShow", function()
    C_Timer.After(0, function()
      if not frame or not frame._ApplyPanelsAlpha then return end
      local d = GetTrackerDB()
      local a = Clamp(tonumber(d and d.alpha) or frame._bgAlpha or 1, 0, 1)
      frame._ApplyPanelsAlpha(a, false)
    end)
  end)

  local header = CreateFrame("Frame", nil, frame, "BackdropTemplate")
  header:SetPoint("TOPLEFT", 6, -6)
  header:SetPoint("TOPRIGHT", -6, -6)
  header:SetHeight(32)

  if Controls and Controls.Backdrop then
    Controls:Backdrop(header, T.header, T.border)
    if Controls.ApplyHeaderTexture then
      Controls:ApplyHeaderTexture(header, false)
    end
  end

  frame:SetMovable(true)
  frame:EnableMouse(true)
  header:EnableMouse(true)
  header:RegisterForDrag("LeftButton")

  header:SetScript("OnDragStart", function()
    local cc = NS.UI and NS.UI.Controls
    if cc and cc.ClearHoverHighlights then
      cc:ClearHoverHighlights(frame)
    end
    frame:StartMoving()
  end)

  header:SetScript("OnDragStop", function()
    frame:StopMovingOrSizing()
    SaveFramePosition()
    local cc = NS.UI and NS.UI.Controls
    if cc and cc.ClearHoverHighlights then
      cc:ClearHoverHighlights(frame)
    end
  end)

  header.collapse = Rows and Rows.MakeSmallIconButton and Rows:MakeSmallIconButton(header, "Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
  if header.collapse then
    header.collapse:SetPoint("LEFT", header, "LEFT", 10, 0)
    if header.collapse.icon and header.collapse.icon.SetRotation then
      header.collapse.icon:SetRotation(-1.5708)
    end
  end

  header.title = header:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
  header.title:SetPoint("CENTER", header, "CENTER", 0, 0)
  header.title:SetText("DecorTracker")
  header.title:SetTextColor(unpack(T.accent))

  if RowStyles and RowStyles.StrongText then
    RowStyles:StrongText(header.title)
  end

  header.closeBtn = CreateFrame("Button", nil, header, "BackdropTemplate")
  header.closeBtn:SetSize(26, 26)
  header.closeBtn:SetPoint("RIGHT", header, "RIGHT", -10, 0)

  if Controls and Controls.Backdrop then
    Controls:Backdrop(header.closeBtn, T.panel, T.border)
    if Controls.ApplyHover then
      Controls:ApplyHover(header.closeBtn, T.panel, T.hover)
    end
  end

  header.closeBtn.icon = header.closeBtn:CreateTexture(nil, "OVERLAY")
  header.closeBtn.icon:SetSize(14, 14)
  header.closeBtn.icon:SetPoint("CENTER")
  header.closeBtn.icon:SetTexture("Interface\\Buttons\\UI-StopButton")
  header.closeBtn.icon:SetVertexColor(1, 0.82, 0.2, 1)

  header.closeBtn:SetScript("OnClick", function()
    frame:Hide()
  end)

  header.settings = Rows and Rows.MakeSmallIconButton and Rows:MakeSmallIconButton(header, "Interface\\Buttons\\UI-OptionsButton")
  if header.settings then
    header.settings:SetPoint("RIGHT", header.closeBtn, "LEFT", -6, 0)
  end

  local settings = CreateFrame("Frame", nil, frame, "BackdropTemplate")
  settings:SetFrameStrata("DIALOG")
  settings:SetFrameLevel(frame:GetFrameLevel() + 12)
  settings:SetSize(240, 155)
  settings:Hide()

  if Controls and Controls.Backdrop then
    Controls:Backdrop(settings, T.panel, T.border)
  end

  settings.title = settings:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  settings.title:SetPoint("TOP", 0, -12)
  settings.title:SetText("Settings")
  settings.title:SetTextColor(unpack(T.accent))
  if RowStyles and RowStyles.StrongText then
    RowStyles:StrongText(settings.title)
  end

  settings.hideLabel = settings:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
  settings.hideLabel:SetPoint("TOPLEFT", 16, -38)
  settings.hideLabel:SetText("Hide Completed:")
  if RowStyles and RowStyles.NormalText then
    RowStyles:NormalText(settings.hideLabel)
  end

  settings.hideCB = CreateFrame("CheckButton", nil, settings, "UICheckButtonTemplate")
  settings.hideCB:SetPoint("LEFT", settings.hideLabel, "RIGHT", 8, 0)
  settings.hideCB:SetSize(24, 24)
  if settings.hideCB.text then
    settings.hideCB.text:SetText("")
  end

  settings.highlightLabel = settings:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
  settings.highlightLabel:SetPoint("TOPLEFT", 16, -68)
  settings.highlightLabel:SetText("Highlight Saved Items:")
  if RowStyles and RowStyles.NormalText then
    RowStyles:NormalText(settings.highlightLabel)
  end

  settings.highlightCB = CreateFrame("CheckButton", nil, settings, "UICheckButtonTemplate")
  settings.highlightCB:SetPoint("LEFT", settings.highlightLabel, "RIGHT", 8, 0)
  settings.highlightCB:SetSize(24, 24)
  if settings.highlightCB.text then
    settings.highlightCB.text:SetText("")
  end

  settings.alphaLabel = settings:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
  settings.alphaLabel:SetPoint("TOPLEFT", 16, -98)
  settings.alphaLabel:SetText("Transparency")
  if RowStyles and RowStyles.NormalText then
    RowStyles:NormalText(settings.alphaLabel)
  end

  settings.alphaValue = settings:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
  settings.alphaValue:SetPoint("TOPRIGHT", -16, -98)
  settings.alphaValue:SetJustifyH("RIGHT")
  if RowStyles and RowStyles.NormalText then
    RowStyles:NormalText(settings.alphaValue)
  end

  local sliderName = NextGlobalName("HomeDecorTrackerAlphaSlider")
  settings.slider = CreateFrame("Slider", sliderName, settings, "OptionsSliderTemplate")
  settings.slider:SetPoint("LEFT", 16, -70)
  settings.slider:SetPoint("RIGHT", -16, -70)
  settings.slider:SetPoint("BOTTOM", 0, 14)
  settings.slider:SetHeight(18)
  settings.slider:SetMinMaxValues(0.00, 1.00)
  settings.slider:SetValueStep(0.01)
  settings.slider:SetObeyStepOnDrag(true)

  do
    local n = settings.slider:GetName()
    if n then
      local low = _G[n .. "Low"]
      if low then low:SetText("") end
      local high = _G[n .. "High"]
      if high then high:SetText("") end
      local text = _G[n .. "Text"]
      if text then text:SetText("") end
    end
  end

  local function ToggleSettings()
    if settings:IsShown() then
      settings:Hide()
      return
    end
    settings:ClearAllPoints()
    settings:SetPoint("TOP", header, "BOTTOM", 0, -6)
    settings:Show()
    settings:Raise()
  end

  if header.settings then
    header.settings:SetScript("OnClick", ToggleSettings)
  end

  settings:SetScript("OnShow", function()
    if not settings._blocker then
      local b = CreateFrame("Button", nil, UIParent)
      settings._blocker = b
      b:SetAllPoints(UIParent)
      b:SetFrameStrata("DIALOG")
      b:SetFrameLevel(settings:GetFrameLevel() - 1)
      b:EnableMouse(true)
      b:SetScript("OnClick", function() settings:Hide() end)
    end
    settings._blocker:Show()
    settings._blocker:Raise()
    settings:Raise()
  end)

  settings:SetScript("OnHide", function()
    local b = settings._blocker
    if b then b:Hide() end
  end)

  local trackRow = CreateFrame("Frame", nil, frame, "BackdropTemplate")
  trackRow:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 0, -6)
  trackRow:SetPoint("TOPRIGHT", header, "BOTTOMRIGHT", 0, -6)
  trackRow:SetHeight(30)

  if Controls and Controls.Backdrop then
    Controls:Backdrop(trackRow, T.panel, T.border)
  end

  local trackZoneCB = CreateFrame("CheckButton", nil, trackRow, "UICheckButtonTemplate")
  trackZoneCB:SetPoint("LEFT", 6, 0)
  if trackZoneCB.text then
    trackZoneCB.text:SetText("Track Current Zone")
  end
  trackZoneCB:SetChecked(not (db and db.trackZone == false))

  local overallRow = CreateFrame("Frame", nil, frame, "BackdropTemplate")
  overallRow:SetPoint("TOPLEFT", trackRow, "BOTTOMLEFT", 0, -6)
  overallRow:SetPoint("TOPRIGHT", trackRow, "BOTTOMRIGHT", 0, -6)
  overallRow:SetHeight(42)
  overallRow:SetClipsChildren(true)

  if Controls and Controls.Backdrop then
    Controls:Backdrop(overallRow, T.panel, T.border)
  end

  overallRow.zone = overallRow:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  overallRow.zone:SetPoint("LEFT", 12, 0)
  overallRow.zone:SetPoint("RIGHT", -80, 0)
  overallRow.zone:SetJustifyH("LEFT")
  overallRow.zone:SetTextColor(unpack(T.accent))
  if RowStyles and RowStyles.StrongText then
    RowStyles:StrongText(overallRow.zone)
  end

  overallRow.count = overallRow:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
  overallRow.count:SetPoint("TOPRIGHT", -10, -6)
  overallRow.count:SetTextColor(unpack(T.text))
  if RowStyles and RowStyles.StrongText then
    RowStyles:StrongText(overallRow.count)
  end

  if ProgressBar and ProgressBar.Create then
    overallRow.bar = ProgressBar:Create(overallRow, 270)
    overallRow.bar:SetPoint("BOTTOMLEFT", 12, 6)
    overallRow.bar:SetPoint("BOTTOMRIGHT", overallRow, "BOTTOMRIGHT", -12, 6)
  end

  local scroll = CreateFrame("ScrollFrame", nil, frame, "ScrollFrameTemplate")
  if Controls and Controls.SkinScrollFrame then
    Controls:SkinScrollFrame(scroll)
  end
  scroll:SetPoint("TOPLEFT", overallRow, "BOTTOMLEFT", 6, -6)
  scroll:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -24, 12)

  local content = CreateFrame("Frame", nil, scroll)
  content:SetSize(1, 1)
  scroll:SetScrollChild(content)

  local resizeGrip = CreateFrame("Button", nil, frame)
  resizeGrip:SetSize(18, 18)
  resizeGrip:SetPoint("BOTTOMRIGHT", -2, 2)
  resizeGrip:EnableMouse(true)

  resizeGrip.tex = resizeGrip:CreateTexture(nil, "OVERLAY")
  resizeGrip.tex:SetAllPoints()
  resizeGrip.tex:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")

  local function SyncContentWidth()
    local sw = scroll:GetWidth()
    if sw and sw > 1 then
      content:SetWidth(sw)
    end
  end

  local function SyncBarsToWidth()
    local rowW = (overallRow and overallRow.GetWidth and overallRow:GetWidth()) or frame:GetWidth()
    local barW = max(120, (rowW or 0) - 24)
    local bar = overallRow.bar
    if bar and bar.SetWidth then
      bar:SetWidth(barW)
    end
    if Rows and Rows.SyncVendorBars then
      Rows:SyncVendorBars(frame, barW)
    end
  end

  local function ClampFrameSize()
    if frame._sizingClamp then return end
    frame._sizingClamp = true

    local ww, hh = frame:GetSize()
    if ww and hh then
      local cw = Clamp(ww, frame._minW, frame._maxW)
      local ch = Clamp(hh, frame._minH, frame._maxH)
      if cw ~= ww or ch ~= hh then
        frame:SetSize(cw, ch)
      end
    end

    frame._sizingClamp = false
  end

  frame._lastSizeW, frame._lastSizeH = frame:GetSize()
  frame:HookScript("OnSizeChanged", function(f, ww, hh)
    if frame._collapsed then return end
    if ww == frame._lastSizeW and hh == frame._lastSizeH then return end
    frame._lastSizeW, frame._lastSizeH = ww, hh

    local d = GetTrackerDB()
    if d then
      d.width = tonumber(ww) or d.width
      d.height = tonumber(hh) or d.height
      d.size = d.size or {}
      d.size.w, d.size.h = d.width, d.height
    end

    ClampFrameSize()
    SyncContentWidth()
    SyncBarsToWidth()

    frame.__hdSizeToken = (frame.__hdSizeToken or 0) + 1
    local tok = frame.__hdSizeToken
    C_Timer.After(0, function()
      if not frame or not frame:IsShown() or frame._collapsed or tok ~= frame.__hdSizeToken then return end
      SyncContentWidth()
      SyncBarsToWidth()
      if Rows and Rows.ApplyWidth then
        Rows:ApplyWidth(frame, frame:GetWidth())
      end
    end)
  end)

  resizeGrip:SetScript("OnMouseDown", function(grip, btn)
    if btn ~= "LeftButton" then return end
    frame._isSizing = true
    frame:StartSizing("BOTTOMRIGHT")
  end)

  resizeGrip:SetScript("OnMouseUp", function()
    frame:StopMovingOrSizing()
    frame._isSizing = false

    ClampFrameSize()
    SyncContentWidth()
    SyncBarsToWidth()

    C_Timer.After(0, function()
      if not frame or not frame:IsShown() or frame._collapsed then return end
      SyncContentWidth()
      SyncBarsToWidth()
      if Rows and Rows.ApplyWidth then
        Rows:ApplyWidth(frame, frame:GetWidth())
      end
      if frame.RequestRefresh then
        frame:RequestRefresh()
      elseif frame.Refresh then
        frame:Refresh()
      end
      if frame._ApplyPanelsAlpha then frame._ApplyPanelsAlpha((GetTrackerDB() and GetTrackerDB().alpha) or frame._bgAlpha or 1, false) end
    end)
  end)

  local function SetCollapsed(collapsed)
    collapsed = collapsed and true or false
    if collapsed == frame._collapsed then return end
    frame._collapsed = collapsed

    local d = GetTrackerDB()
    if d then d.collapsed = collapsed end

    if collapsed then
      settings:Hide()

      local ww, hh = frame:GetSize()
      frame._lastSizeW, frame._lastSizeH = ww, hh
      frame._lastSize.w, frame._lastSize.h = ww, hh

      trackRow:Hide()
      overallRow:Hide()
      scroll:Hide()
      resizeGrip:Hide()

      frame:SetHeight(48)
      if header.collapse and header.collapse.icon and header.collapse.icon.SetRotation then
        header.collapse.icon:SetRotation(0)
      end
      return
    end

    trackRow:Show()
    overallRow:Show()
    scroll:Show()
    resizeGrip:Show()

    if trackZoneCB:GetChecked()
      and NS.Systems and NS.Systems.MapTracker
      and NS.Systems.MapTracker.Enable
    then
      NS.Systems.MapTracker:Enable(true)
    end

    if NS.Systems and NS.Systems.MapTracker and NS.Systems.MapTracker.GetCurrentZone then
      local name, mapID = NS.Systems.MapTracker:GetCurrentZone()
      if (not name or name == "") and GetRealZoneText then
        name = GetRealZoneText()
      end
      frame._lastZoneName, frame._lastZoneMapID = name, mapID
    end

    local rw = frame._lastSizeW or (d and tonumber(d.width)) or 310
    local rh = frame._lastSizeH or (d and tonumber(d.height)) or 520
    frame:SetSize(rw, rh)

    ClampFrameSize()
    if header.collapse and header.collapse.icon and header.collapse.icon.SetRotation then
      header.collapse.icon:SetRotation(-1.5708)
    end

    SyncContentWidth()
    SyncBarsToWidth()

    if Rows and Rows.ApplyWidth then
      Rows:ApplyWidth(frame, frame:GetWidth())
    end

    if frame.Refresh then
      frame:Refresh()
    end
    frame:RequestRefresh("expand")
  end

  if header.collapse then
    header.collapse:SetScript("OnClick", function()
      SetCollapsed(not frame._collapsed)
    end)
  end

  local function ApplyPanelsAlpha(a, pulse)
    frame._bgAlpha = Clamp(tonumber(a) or 1, 0, 1)
    local iconA = Clamp(0.2 + (frame._bgAlpha * 0.8), 0, 1)

    if Rows and Rows.SetPanelAlpha then
      Rows:SetPanelAlpha(frame, frame._bgAlpha)
      Rows:SetPanelAlpha(header, frame._bgAlpha)
      Rows:SetPanelAlpha(trackRow, frame._bgAlpha)
      Rows:SetPanelAlpha(overallRow, frame._bgAlpha)
      Rows:SetPanelAlpha(settings, frame._bgAlpha)
    end

    ApplyRegionAlpha(frame, frame._bgAlpha)
    ApplyRegionAlpha(header, frame._bgAlpha)
    ApplyRegionAlpha(settings, frame._bgAlpha)

    if header.collapse then header.collapse:SetAlpha(iconA) end
    if header.settings then header.settings:SetAlpha(iconA) end

    if header.closeBtn then
      header.closeBtn:SetAlpha(iconA)
      if header.closeBtn.icon then
        header.closeBtn.icon:SetAlpha(iconA)
      end
    end

    if Rows and Rows.SetPanelAlphaForActive then
      Rows:SetPanelAlphaForActive(frame, frame._bgAlpha)
    end

    settings.alphaValue:SetText(fmt("%d%%", floor(frame._bgAlpha * 100 + 0.5)))
    if pulse and Rows and Rows.PulseText then
      Rows:PulseText(settings.alphaValue)
    end
  end

  frame._ApplyPanelsAlpha = ApplyPanelsAlpha
  frame._SyncContentWidth = SyncContentWidth
  frame._SyncBarsToWidth = SyncBarsToWidth
  frame._ClampSize = ClampFrameSize
  frame._SetCollapsed = SetCollapsed

  function frame:RequestRefresh(reason)
    if self._collapsed or self._pendingRefresh then return end
    self._pendingRefresh = true
    local delay = (reason == "toggle" and 0) or 0.08
    C_Timer.After(delay, function()
      if not frame then return end
      frame._pendingRefresh = false
      if not frame:IsShown() or frame._collapsed then return end
      if frame.Refresh then frame:Refresh(reason) end
      if frame._ApplyPanelsAlpha then frame._ApplyPanelsAlpha((GetTrackerDB() and GetTrackerDB().alpha) or frame._bgAlpha or 1, false) end
    end)
  end

  settings.hideCB:SetScript("OnClick", function()
    frame._hideCompleted = settings.hideCB:GetChecked() and true or false
    local d = GetTrackerDB()
    if d then d.hideCompleted = frame._hideCompleted end
    frame:RequestRefresh("hidecompleted")
  end)

  settings.highlightCB:SetScript("OnClick", function()
    local d = GetTrackerDB()
    if not d then return end
    d.showFavoritesOnZoneEnter = settings.highlightCB:GetChecked() and true or false
  end)

  settings.slider:SetScript("OnValueChanged", function(slider, v)
    ApplyPanelsAlpha(v, not frame._initing)
    local d = GetTrackerDB()
    if d then d.alpha = Clamp(v, 0, 1) end
  end)

  do
    local d = GetTrackerDB()
    if d then
      frame._hideCompleted = d.hideCompleted and true or false
      settings.hideCB:SetChecked(frame._hideCompleted)
      
      local showFavs = d.showFavoritesOnZoneEnter
      if showFavs == nil then showFavs = true end
      settings.highlightCB:SetChecked(showFavs)

      local a = Clamp(tonumber(d.alpha) or frame._bgAlpha or 1, 0, 1)
      frame._ApplyPanelsAlpha(a, false)

      frame._initing = true
      settings.slider:SetValue(a)
      frame._initing = nil

      if d.collapsed then
        SetCollapsed(true)
      end
    else
      frame._initing = true
      settings.slider:SetValue(Clamp(frame._bgAlpha or 1, 0, 1))
      frame._initing = nil
      settings.highlightCB:SetChecked(true)
    end
  end

  frame:HookScript("OnHide", function()
    local d = GetTrackerDB()
    if not d then return end
    d.alpha = Clamp(frame._bgAlpha or d.alpha or 1, 0, 1)
    d.collapsed = frame._collapsed and true or false
    d.trackZone = trackZoneCB:GetChecked() and true or false
    d.hideCompleted = frame._hideCompleted and true or false
    d.showFavoritesOnZoneEnter = settings.highlightCB:GetChecked() and true or false
  end)

  return frame, {
    frame = frame,
    header = header,
    settings = settings,
    trackRow = trackRow,
    overallRow = overallRow,
    scroll = scroll,
    content = content,
    resize = resizeGrip,
    trackCB = trackZoneCB,
    GetDB = GetTrackerDB,
  }
end

return UI