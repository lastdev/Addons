local ADDON, NS = ...

NS.UI = NS.UI or {}
local L = NS.UI.Layout or {}
NS.UI.Layout = L

local Dropdown = NS.UI.Dropdown

local C = NS.UI.Controls
local Theme = NS.UI.Theme
local T = (Theme and Theme.colors) or {}
local Textures = (Theme and Theme.textures) or nil

local FiltersSys = NS.Systems and NS.Systems.Filters
local GlobalIndex = NS.Systems and NS.Systems.GlobalIndex

local CreateFrame = CreateFrame
local UIParent = UIParent
local tinsert = tinsert
local unpack = unpack
local ipairs = ipairs
local strlower = string.lower
local format = string.format

local ACCENT = T.accent or { 1, 0.82, 0.2, 1 }
local BORDER = T.border or { 0.20, 0.20, 0.20, 1 }
local TEXT_MUTED = T.textMuted or { 1, 1, 1, 0.55 }
local PLACEHOLDER = T.placeholder or { 1, 1, 1, 0.35 }

local function getDB()
  local profile = NS.db and NS.db.profile
  if not profile then return nil end

  local ui = profile.ui
  if not ui then ui = {}; profile.ui = ui end
  if not ui.viewMode then ui.viewMode = "Icon" end
  if not ui.activeCategory then ui.activeCategory = "Achievements" end
  if not ui.expanded then ui.expanded = {} end
  if ui.search == nil then ui.search = "" end

  profile.filters = profile.filters or {}
  if FiltersSys and FiltersSys.EnsureDefaults then
    FiltersSys:EnsureDefaults(profile)
  end

  profile.favorites = profile.favorites or {}
  return profile
end

local function Backdrop(f, bg, border)
  if C and C.Backdrop then C:Backdrop(f, bg, border) end
end

local function Hover(b, base, hover)
  if C and C.ApplyHover then C:ApplyHover(b, base, hover) end
end

local function SkinBtn(b)
  if C and C.SkinButton then C:SkinButton(b, true) end
end

local function NewFS(parent, template)
  return parent:CreateFontString(nil, "OVERLAY", template or "GameFontNormal")
end

local function Trim(s)
  if not s or s == "" then return "" end
  return (s:gsub("^%s+", ""):gsub("%s+$", ""))
end

local communityPopup

local function ShowCommunityPopup()
  if communityPopup then
    communityPopup:Show()
    return
  end

  local p = CreateFrame("Frame", "HomeDecorCommunityPopup", UIParent, "BackdropTemplate")
  communityPopup = p

  if UISpecialFrames then
    tinsert(UISpecialFrames, "HomeDecorCommunityPopup")
  end

  p:SetSize(560, 360)
  p:SetPoint("CENTER")
  p:SetFrameStrata("FULLSCREEN_DIALOG")
  p:SetFrameLevel(9999)
  p:SetToplevel(true)
  p:SetClampedToScreen(true)

  Backdrop(p, T.panel, T.border)

  p:EnableMouse(true)
  p:SetMovable(true)
  p:RegisterForDrag("LeftButton")
  p:SetScript("OnDragStart", p.StartMoving)
  p:SetScript("OnDragStop", p.StopMovingOrSizing)
  p:SetPropagateKeyboardInput(true)
  p:SetScript("OnKeyDown", function(self, key)
    if key == "ESCAPE" then self:Hide() end
  end)

  local header = CreateFrame("Frame", nil, p, "BackdropTemplate")
  Backdrop(header, T.header, T.border)
  header:SetPoint("TOPLEFT", 6, -6)
  header:SetPoint("TOPRIGHT", -6, -6)
  header:SetHeight(48)

  local title = NewFS(header, "GameFontNormalLarge")
  title:SetPoint("CENTER")
  title:SetText("Community")
  title:SetTextColor(unpack(ACCENT))

  local closeBtn = CreateFrame("Button", nil, header, "BackdropTemplate")
  Backdrop(closeBtn, T.panel, T.border)
  closeBtn:SetSize(26, 26)
  closeBtn:SetPoint("RIGHT", header, "RIGHT", -10, 0)
  Hover(closeBtn, T.panel, T.hover)

  local closeIcon = closeBtn:CreateTexture(nil, "OVERLAY")
  closeIcon:SetSize(14, 14)
  closeIcon:SetPoint("CENTER")
  closeIcon:SetTexture("Interface\\Buttons\\UI-StopButton")
  closeIcon:SetVertexColor(1, 0.82, 0.2, 1)

  closeBtn:SetScript("OnClick", function() p:Hide() end)

  local div = p:CreateTexture(nil, "ARTWORK")
  div:SetColorTexture(1, 1, 1, 0.12)
  div:SetHeight(1)
  div:SetPoint("TOPLEFT", 12, -60)
  div:SetPoint("TOPRIGHT", -12, -60)

  local links = {
    { "Join our Discord community", "https://discord.gg/G2gCV9Zc57" },
    { "Support development (BuyMeACoffee)", "https://buymeacoffee.com/azroaddons" },
    { "Donate via PayPal", "https://www.paypal.com/donate/?business=Jhookftw1@hotmail.com" },
    { "Share HomeDecor with friends", "https://www.curseforge.com/wow/addons/home-decor" },
  }

  local function Highlight(self)
    self:SetFocus()
    self:HighlightText()
  end

  local y = -78
  local gap = 60

  for i = 1, #links do
    local info = links[i]

    local label = NewFS(p, "GameFontNormal")
    label:SetPoint("TOPLEFT", 16, y - ((i - 1) * gap))
    label:SetText(info[1])
    label:SetTextColor(1, 1, 1, 0.95)

    local edit = CreateFrame("EditBox", nil, p, "InputBoxTemplate")
    edit:SetAutoFocus(false)
    edit:SetHeight(30)
    edit:SetPoint("TOPLEFT", label, "BOTTOMLEFT", -6, -6)
    edit:SetPoint("RIGHT", -16, 0)
    edit:SetTextInsets(12, 12, 0, 0)
    edit:SetFontObject("GameFontHighlight")
    edit:SetText(info[2])

    edit:SetScript("OnMouseUp", Highlight)
    edit:SetScript("OnEditFocusGained", Highlight)
    edit:SetScript("OnEscapePressed", function() p:Hide() end)
    edit:SetScript("OnEnterPressed", function() p:Hide() end)
  end

  p:Show()
end

local function findScaleWidgetsOnce(header)
  if not header or not header.GetChildren then return nil end
  if header._hdScale then return header._hdScale[1], header._hdScale[2], header._hdScale[3] end

  local label, slider, value

  local function scan(f, depth)
    if not f or depth > 7 or label then return end

    if f.GetText then
      local ok, t = pcall(f.GetText, f)
      if ok and t == "Scale" then
        label = f
        local parent = f.GetParent and f:GetParent() or nil
        if parent and parent.GetChildren then
          local kids = { parent:GetChildren() }
          for i = 1, #kids do
            local c = kids[i]
            if c ~= f and c and c.GetObjectType then
              local ot = c:GetObjectType()
              if not slider and ot == "Slider" then
                slider = c
              elseif not value and (ot == "EditBox" or ot == "FontString" or ot == "Frame") then
                value = c
              end
            end
          end
        end
      end
    end

    if not label and f.GetChildren then
      local kids = { f:GetChildren() }
      for i = 1, #kids do
        scan(kids[i], depth + 1)
        if label then break end
      end
    end
  end

  scan(header, 0)
  header._hdScale = { label, slider, value }
  return label, slider, value
end

local function dockScale(frame, header)
  if not frame or not header or not header.controls then return end

  local label, slider, value = findScaleWidgetsOnce(header)
  if not label then return end

  local group = header.scaleGroup
  if not group then
    group = CreateFrame("Frame", nil, header.controls)
    header.scaleGroup = group
    group:SetHeight(20)
  end

  if label.SetParent then label:SetParent(group) end
  if slider and slider.SetParent then slider:SetParent(group) end
  if value and value.SetParent then value:SetParent(group) end

  label:ClearAllPoints()
  label:SetPoint("LEFT", group, "LEFT", 0, 0)

  if slider then
    slider:ClearAllPoints()
    slider:SetPoint("LEFT", label, "RIGHT", 8, 0)
  end

  if value then
    value:ClearAllPoints()
    value:SetPoint("LEFT", (slider or label), "RIGHT", 8, 0)
  end

  local rightEdge = header.trackerBtn or header.closeBtn or header
  group:ClearAllPoints()
  group:SetPoint("LEFT", header.controls, "LEFT", 10, 0)
  group:SetPoint("RIGHT", rightEdge, "LEFT", -12, 0)

  local avail = group:GetWidth() or 0
  if avail < 160 then avail = 160 end
  if avail > 360 then avail = 360 end
  group:SetWidth(avail)

  if slider and slider.SetWidth then
    local used = 30
    if label.GetStringWidth then used = used + (label:GetStringWidth() or 40) end
    if value and value.GetWidth then used = used + (value:GetWidth() or 28) end
    local sw = avail - used
    if sw < 80 then sw = 80 end
    if sw > 240 then sw = 240 end
    slider:SetWidth(sw)
  end
end

local function CreateCategoryIndicators(btn)
  if not btn or btn._hdHasIndicators then return end
  btn._hdHasIndicators = true

  local bg = btn:CreateTexture(nil, "BACKGROUND")
  btn.selBG = bg
  bg:SetPoint("TOPLEFT", btn, "TOPLEFT", 2, -2)
  bg:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -2, 2)
  bg:SetColorTexture(1, 1, 1, 0.07)
  bg:Hide()

  local function edge()
    local t = btn:CreateTexture(nil, "BORDER")
    t:SetColorTexture(ACCENT[1], ACCENT[2], ACCENT[3], 0.30)
    t:Hide()
    return t
  end

  btn.selTop, btn.selBottom, btn.selLeft, btn.selRight = edge(), edge(), edge(), edge()

  btn.selTop:SetPoint("TOPLEFT", btn, "TOPLEFT", 2, -2)
  btn.selTop:SetPoint("TOPRIGHT", btn, "TOPRIGHT", -2, -2)
  btn.selTop:SetHeight(1)

  btn.selBottom:SetPoint("BOTTOMLEFT", btn, "BOTTOMLEFT", 2, 2)
  btn.selBottom:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -2, 2)
  btn.selBottom:SetHeight(1)

  btn.selLeft:SetPoint("TOPLEFT", btn, "TOPLEFT", 2, -2)
  btn.selLeft:SetPoint("BOTTOMLEFT", btn, "BOTTOMLEFT", 2, 2)
  btn.selLeft:SetWidth(1)

  btn.selRight:SetPoint("TOPRIGHT", btn, "TOPRIGHT", -2, -2)
  btn.selRight:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -2, 2)
  btn.selRight:SetWidth(1)
end

local function SetCategorySelected(btn, selected)
  if not btn then return end
  local show = selected and true or false
  if btn.selBG then btn.selBG:SetShown(show) end
  if btn.selTop then btn.selTop:SetShown(show) end
  if btn.selBottom then btn.selBottom:SetShown(show) end
  if btn.selLeft then btn.selLeft:SetShown(show) end
  if btn.selRight then btn.selRight:SetShown(show) end
end

function L:CreateShell()
  local db = getDB()
  if not db or not C then return nil end

  local UI = db.ui
  local Filters = db.filters

  local f = CreateFrame("Frame", "HomeDecorFrame", UIParent, "BackdropTemplate")
  Backdrop(f, T.bg, T.border)

  if C.ApplyBackground and Textures and Textures.MainBackground then
    C:ApplyBackground(f, Textures.MainBackground, 8, 1)
  end

  f:SetSize(1150, 680)
  f:SetPoint("CENTER")

  local function rerender()
    local v = f.view
    if v and v.Render then v:Render() end
  end

  local header = CreateFrame("Frame", nil, f, "BackdropTemplate")
  Backdrop(header, T.header, T.border)
  header:SetBackdropColor(0, 0, 0, 0)
  header:SetBackdropBorderColor(unpack(BORDER))
  header:SetPoint("TOPLEFT", 8, -8)
  header:SetPoint("TOPRIGHT", -8, -8)
  header:SetHeight(52)
  header:EnableMouse(false)
  f.Header = header

  header.controls = CreateFrame("Frame", nil, header)
  header.controls:SetPoint("TOPLEFT", header, "TOPLEFT", 8, -8)
  header.controls:SetPoint("TOPRIGHT", header, "TOPRIGHT", -8, -8)
  header.controls:SetHeight(22)
  header.controls:EnableMouse(false)

  local logo = header:CreateTexture(nil, "ARTWORK")
  header.logo = logo

  if Textures and Textures.Logo then
    logo:SetTexture(Textures.Logo)
  else
    logo:SetColorTexture(1, 0.82, 0.2, 1)
  end

  logo:SetSize(506, 50) 
  logo:SetPoint("CENTER", header, "TOP", 0, -26)
  logo:SetTexCoord(0, 1, 0, 1)
  logo:SetAlpha(1)


  local closeBtn = CreateFrame("Button", nil, header, "BackdropTemplate")
  header.closeBtn = closeBtn
  Backdrop(closeBtn, T.panel, T.border)
  closeBtn:SetSize(22, 22)
  closeBtn:SetPoint("TOPRIGHT", header, "TOPRIGHT", -10, -8)
  Hover(closeBtn, T.panel, T.hover)

  local closeIcon = closeBtn:CreateTexture(nil, "OVERLAY")
  closeBtn.icon = closeIcon
  closeIcon:SetSize(14, 14)
  closeIcon:SetPoint("CENTER", 0, 0)
  closeIcon:SetTexture("Interface\\Buttons\\UI-StopButton")
  closeIcon:SetVertexColor(1, 0.82, 0.2, 1)
  closeBtn:SetFrameLevel(header:GetFrameLevel() + 6)
  closeIcon:SetDrawLayer("OVERLAY", 7)

  closeBtn:SetScript("OnClick", function()
    if f and f.Hide then f:Hide() end
  end)

  local trackerBtn = CreateFrame("Button", nil, header, "BackdropTemplate")
  header.trackerBtn = trackerBtn
  Backdrop(trackerBtn, T.panel, T.border)
  trackerBtn:SetSize(72, 20)
  trackerBtn:SetPoint("RIGHT", closeBtn, "LEFT", -12, 0)
  Hover(trackerBtn, T.panel, T.hover)

  local trackerText = NewFS(trackerBtn, "GameFontNormal")
  trackerBtn.text = trackerText
  trackerText:SetPoint("CENTER", 0, 0)
  trackerText:SetText("Tracker")
  trackerText:SetTextColor(unpack(ACCENT))
  trackerBtn:SetFrameLevel(header:GetFrameLevel() + 6)
  trackerText:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
  trackerText:SetShadowColor(0, 0, 0, 0)
  trackerText:SetShadowOffset(0, 0)
  trackerText:SetDrawLayer("OVERLAY", 7)

  trackerBtn:SetScript("OnClick", function()
    local Tr = (NS.UI and NS.UI.Tracker) or (NS.UI and NS.UI.DecorTracker) or NS.Tracker
    if Tr and Tr.Toggle then Tr:Toggle() end
  end)

  local profBtn = CreateFrame("Button", nil, header, "BackdropTemplate")
  header.profBtn = profBtn
  Backdrop(profBtn, T.panel, T.border)
  profBtn:SetSize(72, 20)
  profBtn:SetPoint("RIGHT", trackerBtn, "LEFT", -8, 0)
  Hover(profBtn, T.panel, T.hover)

  local profText = NewFS(profBtn, "GameFontNormal")
  profBtn.text = profText
  profText:SetPoint("CENTER", 0, 0)
  profText:SetText("Profs")
  profText:SetTextColor(unpack(ACCENT))
  profBtn:SetFrameLevel(header:GetFrameLevel() + 6)
  profText:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
  profText:SetShadowColor(0, 0, 0, 0)
  profText:SetShadowOffset(0, 0)
  profText:SetDrawLayer("OVERLAY", 7)

  profBtn:SetScript("OnClick", function()
    local PT = (NS.UI and NS.UI.ProfTracker) or NS.ProfTracker
    if PT and PT.Toggle then PT:Toggle() end
  end)

  header.viewToggle = C:Segmented(
    header, { "Icon", "List" },
    function() return UI.viewMode end,
    function(v) UI.viewMode = v end
  )

  local left = CreateFrame("Frame", nil, f, "BackdropTemplate")
  Backdrop(left, T.panel, T.border)
  if C.ApplyBackground and Textures and Textures.LeftPanelBG then
    C:ApplyBackground(left, Textures.LeftPanelBG, 6, 1)
  end
  local contentTopY = -(8 + header:GetHeight() + 4)
  left:SetPoint("TOPLEFT", 8, contentTopY)
  left:SetPoint("BOTTOMLEFT", 8, 8)
  left:SetWidth(200)

  local cats = { "Achievements", "Quests", "Vendors", "Drops", "Professions", "PVP" }
  left.buttons = {}

  local function applyCategoryText(btn, cname)
    local collected, total = 0, 0
    if GlobalIndex and GlobalIndex.GetCounts then
      collected, total = GlobalIndex:GetCounts(cname)
    end
    if total > 0 then
      btn.text:SetText(format("%s (%d / %d)", cname, collected, total))
    else
      btn.text:SetText(cname)
    end
  end

  local y = -12
  for i = 1, #cats do
    local cname = cats[i]
    local b = CreateFrame("Button", nil, left, "BackdropTemplate")
    Backdrop(b, T.panel, T.border)
    SkinBtn(b)

    b:SetPoint("TOPLEFT", 10, y)
    b:SetPoint("RIGHT", -10, y)
    b:SetHeight(28)

    local txt = NewFS(b, "GameFontNormal")
    b.text = txt
    txt:SetPoint("CENTER")
    b._category = cname

    CreateCategoryIndicators(b)
    applyCategoryText(b, cname)
    Hover(b, T.panel, T.hover)

    left.buttons[#left.buttons + 1] = b
    y = y - 32
  end

  local filtersTitle = NewFS(left, "GameFontNormal")
  filtersTitle:SetPoint("TOPLEFT", 10, y - 10)
  filtersTitle:SetText("Filters")
  filtersTitle:SetTextColor(unpack(ACCENT))
  y = y - 24

  local filtersLine = left:CreateTexture(nil, "ARTWORK")
  filtersLine:SetColorTexture(1, 1, 1, 0.15)
  filtersLine:SetHeight(1)
  filtersLine:SetPoint("TOPLEFT", 10, y)
  filtersLine:SetPoint("TOPRIGHT", -10, y)
  y = y - 6

  local filterScroll = CreateFrame("ScrollFrame", nil, left, "ScrollFrameTemplate")
  filterScroll:SetPoint("TOPLEFT", 8, y)
  filterScroll:SetPoint("BOTTOMRIGHT", -28, 86)

  local filterContent = CreateFrame("Frame", nil, filterScroll)
  filterContent:SetPoint("TOPLEFT", 0, 0)
  filterScroll:SetScrollChild(filterContent)
  filterScroll:SetScript("OnSizeChanged", function(self, w)
    filterContent:SetWidth((w or 0) - 2)
  end)

  if C and C.SkinScrollFrame then
    C:SkinScrollFrame(filterScroll)
  end

  local right = CreateFrame("Frame", nil, f, "BackdropTemplate")
  Backdrop(right, T.panel, T.border)
  if C.ApplyBackground and Textures then
    local bg = Textures.ModelBG or Textures.ModalBG or Textures.MainBackground
    if bg then C:ApplyBackground(right, bg, 8, 1) end
  end
  right:SetPoint("TOPLEFT", left, "TOPRIGHT", 8, 0)
  right:SetPoint("BOTTOMRIGHT", -8, 8)
  f.Right = right

  local bar = CreateFrame("Frame", nil, right, "BackdropTemplate")
  Backdrop(bar, T.panel, T.border)
  if C.ApplyHeaderTexture then C:ApplyHeaderTexture(bar, false) end
  bar:SetPoint("TOPLEFT", 8, -8)
  bar:SetPoint("TOPRIGHT", -8, -8)
  bar:SetHeight(36)
  f.TopBar = bar

  local function MakeTopButton(parent, w, h)
    local b = CreateFrame("Button", nil, parent, "BackdropTemplate")
    Backdrop(b, T.panel, T.border)
    SkinBtn(b)
    b:SetSize(w, h)
    Hover(b, T.panel, T.hover)

    b.icon = b:CreateTexture(nil, "OVERLAY")
    b.icon:SetSize(14, 14)
    b.icon:SetPoint("LEFT", b, "LEFT", 8, 0)

    b.text = NewFS(b, "GameFontNormal")
    b.text:SetPoint("LEFT", b.icon, "RIGHT", 6, 0)
    return b
  end

  local savedBtn = MakeTopButton(bar, 120, 24)
  savedBtn:SetPoint("LEFT", bar, "LEFT", 8, 0)
  if savedBtn.icon.SetAtlas then
    savedBtn.icon:SetAtlas("auctionhouse-icon-favorite", false)
  else
    savedBtn.icon:SetTexture("Interface/Common/ReputationStar")
  end
  savedBtn.icon:SetVertexColor(1, 1, 1, 1)
  savedBtn.text:SetText("Saved Items")

  local eventsBtn = MakeTopButton(bar, 96, 24)
  eventsBtn:SetPoint("LEFT", savedBtn, "RIGHT", 6, 0)
  eventsBtn.icon:SetTexture("Interface\\Icons\\INV_Misc_PocketWatch_01")
  eventsBtn.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
  eventsBtn.icon:SetDesaturated(true)
  eventsBtn.icon:SetVertexColor(1, 1, 1, 0.9)
  eventsBtn.text:SetText("Events")
  eventsBtn.text:SetTextColor(unpack(TEXT_MUTED))

  local glow = eventsBtn:CreateTexture(nil, "ARTWORK")
  eventsBtn.glow = glow
  glow:SetTexture("Interface\\AddOns\\HomeDecor\\Media\\UI\\event_badge_small.tga")
  glow:SetPoint("CENTER", eventsBtn, "CENTER", 0, 0)
  glow:SetSize(110, 34)
  glow:SetBlendMode("ADD")
  glow:SetAlpha(0)

  local glowAnim = eventsBtn:CreateAnimationGroup()
  eventsBtn.glowAnim = glowAnim
  do
    local a1 = glowAnim:CreateAnimation("Alpha")
    a1:SetFromAlpha(0.10)
    a1:SetToAlpha(0.70)
    a1:SetDuration(0.55)
    a1:SetSmoothing("IN_OUT")
    a1:SetOrder(1)

    local a2 = glowAnim:CreateAnimation("Alpha")
    a2:SetFromAlpha(0.70)
    a2:SetToAlpha(0.10)
    a2:SetDuration(0.65)
    a2:SetSmoothing("IN_OUT")
    a2:SetOrder(2)
  end
  glowAnim:SetLooping("REPEAT")

  local EventsSys = NS.Systems and NS.Systems.Events or nil
  local function getEventState()
    local Ev = EventsSys or (NS.Systems and NS.Systems.Events)
    EventsSys = Ev
    if not Ev then return false, "" end

    if Ev.GetStatus then
      return Ev:GetStatus()
    elseif Ev.GetActive then
      local list = Ev:GetActive()
      local hasActive = (type(list) == "table" and #list > 0)
      return hasActive, (hasActive and "active" or "")
    elseif Ev.HasActive then
      local hasActive = Ev:HasActive() and true or false
      return hasActive, (hasActive and "active" or "")
    end

    return false, ""
  end

  local UpdateTopTabs
  local SelectCategory
  local setSearchUI

  UpdateTopTabs = function()
    C:SetSelected(savedBtn, UI.activeCategory == "Saved Items", T.panel, T.row)
    C:SetSelected(eventsBtn, UI.activeCategory == "Events", T.panel, T.row)

    local hasActive, sig = getEventState()
    if UI.activeCategory == "Events" and sig ~= "" then
      db.ui.eventsSeenSig = sig
    end

    local seenSig = db.ui.eventsSeenSig or ""
    local isNew = (sig ~= "" and sig ~= seenSig)

    if hasActive then
      eventsBtn.icon:SetDesaturated(false)
      eventsBtn.text:SetTextColor(unpack(ACCENT))
      eventsBtn:SetAlpha(1.0)

      if isNew then
        glow:SetAlpha(0.10)
        if not glowAnim:IsPlaying() then glowAnim:Play() end
      else
        if glowAnim:IsPlaying() then glowAnim:Stop() end
        glow:SetAlpha(0.25)
      end
    else
      eventsBtn.icon:SetDesaturated(true)
      eventsBtn.text:SetTextColor(unpack(TEXT_MUTED))
      eventsBtn:SetAlpha(0.85)
      if glowAnim:IsPlaying() then glowAnim:Stop() end
      glow:SetAlpha(0)
      db.ui.eventsSeenSig = ""
    end
  end

  SelectCategory = function(categoryName)

    UI.activeCategory = categoryName
    db.ui.activeCategory = categoryName

    if f.SearchBox then
      local txt = UI.search or ""
      f.SearchBox._squelchCmd = true
      f.SearchBox:SetText(txt)
      f.SearchBox:SetCursorPosition(#txt)
      f.SearchBox._squelchCmd = false
      if setSearchUI then setSearchUI(txt ~= "") end
    end

    for i = 1, #left.buttons do
      local bb = left.buttons[i]
      local sel = (bb._category == categoryName)
      C:SetSelected(bb, sel, T.panel, T.row)
      SetCategorySelected(bb, sel)
    end

    if UpdateTopTabs then UpdateTopTabs() end
    if f.view and f.view.scrollFrame then
      f.view.scrollFrame:SetVerticalScroll(0)
    end

    rerender()

    if NS.UI and NS.UI.HeaderController and NS.UI.HeaderController.Reset then
      NS.UI.HeaderController:Reset()
    end
  end

  for i = 1, #left.buttons do
    local b = left.buttons[i]
    b:SetScript("OnClick", function() SelectCategory(b._category) end)
  end

  savedBtn:SetScript("OnClick", function() SelectCategory("Saved Items") end)
  eventsBtn:SetScript("OnClick", function()
    SelectCategory("Events")
    local _, sig = getEventState()
    db.ui.eventsSeenSig = sig or ""
    if UpdateTopTabs then UpdateTopTabs() end
  end)

  for i = 1, #left.buttons do
    local b = left.buttons[i]
    local isSel = (b._category == UI.activeCategory)
    C:SetSelected(b, isSel, T.panel, T.row)
    SetCategorySelected(b, isSel)
  end

  if header.viewToggle then
    header.viewToggle.OnValueChanged = function(_, v)
      UI.viewMode = v
      if f.view and f.view.SetViewMode then f.view:SetViewMode(v) end
      rerender()
    end
    if header.viewToggle.Refresh then header.viewToggle:Refresh() end
    header.viewToggle:SetParent(bar)
    header.viewToggle:ClearAllPoints()
    header.viewToggle:SetPoint("RIGHT", bar, "RIGHT", -8, 0)
  end

  local search = CreateFrame("EditBox", nil, bar, "BackdropTemplate")
  Backdrop(search, T.panel, T.border)
  search:SetPoint("LEFT", eventsBtn, "RIGHT", 8, 0)
  if header.viewToggle and header.viewToggle.GetLeft then
    search:SetPoint("RIGHT", header.viewToggle, "LEFT", -8, 0)
  else
    search:SetPoint("RIGHT", -8, 0)
  end
  search:SetHeight(24)
  search:SetAutoFocus(false)
  search:SetFontObject(GameFontHighlightSmall)
  search:SetTextInsets(8, 26, 0, 0)
  search:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)

  local placeholder = search:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
  placeholder:SetPoint("LEFT", search, "LEFT", 8, 0)
  placeholder:SetText("Search...")
  placeholder:SetTextColor(unpack(PLACEHOLDER))

  f.SearchBox = search
  f.SearchPlaceholder = placeholder

  local clearBtn = CreateFrame("Button", nil, search, "BackdropTemplate")
  Backdrop(clearBtn, T.panel, T.border)
  clearBtn:SetSize(18, 18)
  clearBtn:SetPoint("RIGHT", search, "RIGHT", -6, 0)
  Hover(clearBtn, T.panel, T.hover)

  local clearIcon = clearBtn:CreateTexture(nil, "OVERLAY")
  clearIcon:SetSize(12, 12)
  clearIcon:SetPoint("CENTER", 0, 0)
  clearIcon:SetTexture("Interface\\Buttons\\UI-StopButton")
  clearIcon:SetVertexColor(1, 0.82, 0.2, 0.95)

  clearBtn:Hide()
  search._clearBtn = clearBtn

  setSearchUI = function(hasText)
    clearBtn:SetShown(hasText)
    placeholder:SetShown((not hasText) and (not search:HasFocus()))
  end

  local function routeCategoryCommand(q)
    if q == "achievement" or q == "achievements" then return "Achievements" end
    if q == "quest" or q == "quests" then return "Quests" end
    if q == "vendor" or q == "vendors" then return "Vendors" end
    if q == "drop" or q == "drops" then return "Drops" end
    if q == "profession" or q == "professions" then return "Professions" end
    if q == "pvp" then return "PVP" end
    return nil
  end

  clearBtn:SetScript("OnClick", function()
    search._squelchCmd = true
    search:SetText("")
    search:ClearFocus()
    search._squelchCmd = false

    UI.search = ""
    db.ui.search = ""
    UI._searchNorm = ""
    UI._searchLast = ""
    UI._searchTokens = UI._searchTokens or {}
    for i = #UI._searchTokens, 1, -1 do UI._searchTokens[i] = nil end

    if FiltersSys and FiltersSys.PrepareSearch then
      FiltersSys:PrepareSearch(UI)
    end

    setSearchUI(false)

    if UI.activeCategory == "Search" and UI._searchPrevCategory then
      UI.activeCategory = UI._searchPrevCategory
      UI._searchPrevCategory = nil
    end

    rerender()
  end)

  search:SetText(UI.search or "")
  setSearchUI((search:GetText() or "") ~= "")

  search:SetScript("OnTextChanged", function(self)
    if self._squelchCmd then return end

    local txt = self:GetText() or ""
    UI.search = txt
    db.ui.search = txt

    local q = strlower(Trim(txt))
    local cmd = routeCategoryCommand(q)

    if cmd then
      if UI.activeCategory ~= cmd then SelectCategory(cmd) end
      setSearchUI(true)
      rerender()
      return
    end

    if q ~= "" then
      if UI.activeCategory ~= "Search" then
        UI._searchPrevCategory = UI.activeCategory
        UI.activeCategory = "Search"
      end
    else
      if UI.activeCategory == "Search" and UI._searchPrevCategory then
        UI.activeCategory = UI._searchPrevCategory
        UI._searchPrevCategory = nil
      end
    end

    setSearchUI(txt ~= "")
    rerender()
  end)

  search:SetScript("OnEditFocusGained", function()
    placeholder:Hide()
    setSearchUI((search:GetText() or "") ~= "")
  end)

  search:SetScript("OnEditFocusLost", function()
    setSearchUI((search:GetText() or "") ~= "")
  end)

  if NS.UI and NS.UI.FilterPopup and NS.UI.FilterPopup.Build then
    NS.UI.FilterPopup:Build(filterContent, {
      C = C,
      T = T,
      Dropdown = Dropdown,
      Filters = Filters,
      FiltersSys = FiltersSys,
      UI = UI,
      db = db,
      rerender = rerender,
    })
  end

  if NS.UI and NS.UI.ResizeBar then
    NS.UI.ResizeBar:Attach(f, header)
  end

  if header then
    header:HookScript("OnShow", function() dockScale(f, header) end)
    header:HookScript("OnSizeChanged", function() dockScale(f, header) end)
  end
  f:HookScript("OnShow", function() dockScale(f, header) end)
  f:HookScript("OnSizeChanged", function() dockScale(f, header) end)

  if NS.UI and NS.UI.ViewFactory and NS.UI.ViewFactory.Create then
    f.view = NS.UI.ViewFactory:Create(f, UI, db)
  end
  if f.view and f.view.OnShow then f.view:OnShow() end
  rerender()

  if NS.UI and NS.UI.HeaderController and NS.UI.HeaderController.Reset then
    NS.UI.HeaderController:Reset()
  end

  local divider = left:CreateTexture(nil, "ARTWORK")
  divider:SetColorTexture(1, 1, 1, 0.15)
  divider:SetHeight(1)
  divider:SetPoint("BOTTOMLEFT", 12, 44)
  divider:SetPoint("BOTTOMRIGHT", -12, 44)

  local communityBtn = CreateFrame("Button", nil, left, "BackdropTemplate")
  Backdrop(communityBtn, T.header, T.border)
  communityBtn:SetPoint("BOTTOMLEFT", 10, 50)
  communityBtn:SetPoint("BOTTOMRIGHT", -10, 50)
  communityBtn:SetHeight(26)
  Hover(communityBtn, T.header, T.hover)

  local commIcon = communityBtn:CreateTexture(nil, "OVERLAY")
  commIcon:SetSize(14, 14)
  commIcon:SetPoint("LEFT", 10, 0)
  commIcon:SetTexture("Interface\\FriendsFrame\\UI-Toast-ChatInviteIcon")

  local commText = NewFS(communityBtn, "GameFontNormal")
  commText:SetPoint("LEFT", commIcon, "RIGHT", 6, 0)
  commText:SetText("Community")

  communityBtn:SetScript("OnClick", ShowCommunityPopup)

  local whatsNewBtn = CreateFrame("Button", nil, left, "BackdropTemplate")
  Backdrop(whatsNewBtn, T.panel, T.border)
  whatsNewBtn:SetPoint("BOTTOMLEFT", 10, 10)
  whatsNewBtn:SetPoint("BOTTOMRIGHT", -10, 10)
  whatsNewBtn:SetHeight(26)
  Hover(whatsNewBtn, T.header, T.hover)

  local wnText = NewFS(whatsNewBtn, "GameFontNormal")
  wnText:SetPoint("CENTER")
  wnText:SetText("What's New")

  whatsNewBtn:SetScript("OnClick", function()
    if NS.UI and NS.UI.ShowChangelogPopup then
      NS.UI:ShowChangelogPopup(true)
    end
  end)

  local function EnsureTicker()
    if f.eventTicker or not C_Timer or not C_Timer.NewTicker then return end
    f.eventTicker = C_Timer.NewTicker(2, function()
      if f:IsShown() and UpdateTopTabs then UpdateTopTabs() end
    end)
  end

  local function CancelTicker()
    if f.eventTicker and f.eventTicker.Cancel then
      f.eventTicker:Cancel()
    end
    f.eventTicker = nil
  end

  f:HookScript("OnShow", function()
    EnsureTicker()
    if UpdateTopTabs then UpdateTopTabs() end
  end)

  f:HookScript("OnHide", function()
    CancelTicker()
  end)

  EnsureTicker()
  if UpdateTopTabs then UpdateTopTabs() end

  return f
end

return L
