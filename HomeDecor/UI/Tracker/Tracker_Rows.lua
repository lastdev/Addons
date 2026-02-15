local ADDON, NS = ...
NS.UI = NS.UI or {}

local Tracker = NS.UI.Tracker or {}
NS.UI.Tracker = Tracker

local Rows = NS.UI.TrackerRows or {}
NS.UI.TrackerRows = Rows
Tracker.Rows = Rows

local RS = NS.UI.RowStyles
local ProgressBar = NS.UI.ProgressBar

local HEADER_H = 44
local ITEM_H = 54
local MEDIA_SZ = 40
local ICON_SZ = 34

local CHECK_ATLAS = "common-icon-checkmark"
local CHECK_FALLBACK = "Interface\\RaidFrame\\ReadyCheck-Ready"

local wipe = _G.wipe or function(t) for k in pairs(t) do t[k] = nil end end

local function MakeArrow(parent)
  local t = parent:CreateTexture(nil, "OVERLAY")
  t:SetSize(12, 12)
  t:SetPoint("LEFT", 10, 0)
  t:SetTexture("Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Up")
  t:SetTexCoord(0.25, 0.75, 0.25, 0.75)
  return t
end

function Rows:StrongText(fs)
  if RS and RS.StrongText then
    RS:StrongText(fs)
  end
end

function Rows:PulseText(fs)
  if not fs then return end
  local ag = fs._pulseAnim
  if ag then
    ag:Stop()
    fs._pulseAnim = nil
  end
  ag = fs:CreateAnimationGroup()
  local a1 = ag:CreateAnimation("Alpha")
  a1:SetFromAlpha(1)
  a1:SetToAlpha(0.35)
  a1:SetDuration(0.6)
  a1:SetOrder(1)
  local a2 = ag:CreateAnimation("Alpha")
  a2:SetFromAlpha(0.35)
  a2:SetToAlpha(1)
  a2:SetDuration(0.6)
  a2:SetOrder(2)
  ag:SetLooping("REPEAT")
  ag:Play()
  fs._pulseAnim = ag
end

function Rows:StopPulse(fs)
  if not fs then return end
  local ag = fs._pulseAnim
  if ag then
    ag:Stop()
    fs._pulseAnim = nil
  end
  if fs.SetAlpha then
    fs:SetAlpha(1)
  end
end

function Rows:MakeSmallIconButton(parent, sizeOrTex)
  local b = CreateFrame("Button", nil, parent, "BackdropTemplate")

  local tex
  local size = sizeOrTex
  if type(sizeOrTex) == "string" then
    tex = sizeOrTex
    size = nil
  end

  local w = (type(size) == "number" and size) or 18
  b:SetSize(w, w)

  if RS and RS.ApplyBackdrop then
    RS:ApplyBackdrop(b, "button")
  end
  if RS and RS.ApplyHeaderTexture then
    RS:ApplyHeaderTexture(b, true)
  end

  local ic = b:CreateTexture(nil, "ARTWORK")
  ic:SetAllPoints()
  ic:SetTexCoord(0.08, 0.92, 0.08, 0.92)
  if tex then
    ic:SetTexture(tex)
  end
  b.icon = ic

  if b.SetHighlightTexture then
    local hl = b:CreateTexture(nil, "HIGHLIGHT")
    hl:SetAllPoints()
    hl:SetColorTexture(1, 1, 1, 0.05)
    b:SetHighlightTexture(hl)
  end

  return b
end

function Rows:SetPanelAlpha(row, a)
  if not row then return end
  a = a or 1

  local function SetTexAlpha(tex)
    if tex and tex.SetAlpha then
      tex:SetAlpha(a)
    end
  end

  SetTexAlpha(row.Center)
  SetTexAlpha(row.LeftEdge); SetTexAlpha(row.RightEdge)
  SetTexAlpha(row.TopEdge); SetTexAlpha(row.BottomEdge)
  SetTexAlpha(row.TopLeftCorner); SetTexAlpha(row.TopRightCorner)
  SetTexAlpha(row.BottomLeftCorner); SetTexAlpha(row.BottomRightCorner)

  SetTexAlpha(row.__hdHeaderTex)
  SetTexAlpha(row.__hdHeaderHover)
  SetTexAlpha(row.mediaBg)

  local bar = row.bar
  if bar then
    SetTexAlpha(bar.Center); SetTexAlpha(bar.LeftEdge); SetTexAlpha(bar.RightEdge)
    SetTexAlpha(bar.TopEdge); SetTexAlpha(bar.BottomEdge)
    SetTexAlpha(bar.TopLeftCorner); SetTexAlpha(bar.TopRightCorner)
    SetTexAlpha(bar.BottomLeftCorner); SetTexAlpha(bar.BottomRightCorner)
    SetTexAlpha(bar.bg)
    SetTexAlpha(bar.edge)
  end

  if row._rsHL then
    row._rsHoverBase = 0.16
  end
end

function Rows:SetPanelAlphaForActive(frame, a)
  local active = frame and frame._active
  if not active then return end
  for i = 1, #active do
    self:SetPanelAlpha(active[i], a)
  end
end

function Rows:SyncVendorBars(_frame) end

local function NewOverallRow(parent)
  local r = CreateFrame("Button", nil, parent, "BackdropTemplate")
  r._kind = "overall"
  r:SetHeight(HEADER_H)
  r:EnableMouse(true)
  r:RegisterForClicks("AnyUp")

  r.arrow = MakeArrow(r)

  r.zone = r:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  r.zone:SetPoint("LEFT", r.arrow, "RIGHT", 8, 0)
  r.zone:SetJustifyH("LEFT")
  r.zone:SetWordWrap(false)

  r.count = r:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  r.count:SetPoint("RIGHT", -12, 0)
  r.count:SetJustifyH("RIGHT")

  if ProgressBar and ProgressBar.Create then
    r.bar = ProgressBar:Create(r, 160)
    r.bar:SetPoint("BOTTOMLEFT", r.zone, "BOTTOMLEFT", 0, -10)
    r.bar:Hide()
  end

  if RS then
    if RS.SkinTrackerHeader then
      RS:SkinTrackerHeader(r, 0.16)
    end
    if RS.StrongText then
      RS:StrongText(r.zone)
    end
  end

  return r
end

local function NewVendorRow(parent)
  local r = CreateFrame("Button", nil, parent, "BackdropTemplate")
  r._kind = "vendor"
  r:SetHeight(HEADER_H)
  r:EnableMouse(true)
  r:RegisterForClicks("AnyUp")

  r.arrow = MakeArrow(r)

  r.label = r:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  r.label:SetPoint("LEFT", r.arrow, "RIGHT", 8, 0)
  r.label:SetJustifyH("LEFT")
  r.label:SetWordWrap(false)

  r.count = r:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  r.count:SetPoint("RIGHT", -12, 0)
  r.count:SetJustifyH("RIGHT")

  if ProgressBar and ProgressBar.Create then
    r.bar = ProgressBar:Create(r, 160)
    r.bar:SetPoint("BOTTOMLEFT", r, "BOTTOMLEFT", 34, 8)
    r.bar:Hide()
  end

  if RS and RS.SkinTrackerHeader then
    RS:SkinTrackerHeader(r, 0.16)
  end

  return r
end

local function NewItemRow(parent)
  local r = CreateFrame("Button", nil, parent, "BackdropTemplate")
  r._kind = "item"
  r:SetHeight(ITEM_H)
  r:EnableMouse(true)
  r:RegisterForClicks("AnyUp")
  r:SetClipsChildren(true)

  r.media = CreateFrame("Frame", nil, r)
  r.media:SetPoint("LEFT", 10, 0)
  r.media:SetSize(MEDIA_SZ, MEDIA_SZ)

  r.mediaBg = r.media:CreateTexture(nil, "BACKGROUND")
  r.mediaBg:SetAllPoints()

  r.icon = r.media:CreateTexture(nil, "ARTWORK")
  r.icon:SetPoint("CENTER", 0, 0)
  r.icon:SetSize(ICON_SZ, ICON_SZ)

  r.check = r.media:CreateTexture(nil, "OVERLAY", nil, 7)
  r.check:SetSize(13, 13)
  r.check:SetPoint("BOTTOMLEFT", r.media, "BOTTOMLEFT", 1, 1)
  if r.check.SetAtlas then
    r.check:SetAtlas(CHECK_ATLAS, true)
  else
    r.check:SetTexture(CHECK_FALLBACK)
  end
  r.check:SetVertexColor(0.75, 0.95, 0.75, 0.95)
  r.check:Hide()

  r.faction = r.media:CreateTexture(nil, "OVERLAY")
  r.faction:SetPoint("BOTTOMRIGHT", 2, -2)
  r.faction:SetSize(14, 14)
  r.faction:SetAlpha(1)
  r.faction:Hide()

  r.owned = r.media:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
  r.owned:ClearAllPoints()
  r.owned:SetPoint("BOTTOMRIGHT", r.media, "BOTTOMRIGHT", -1, 1)
  r.owned:SetJustifyH("RIGHT")
  r.owned:SetTextColor(0.86, 0.84, 0.78, 1)
  if r.owned.SetFontObject then
    r.owned:SetFontObject(GameFontNormalSmall)
  end
  if r.owned.SetShadowOffset then
    r.owned:SetShadowOffset(1, -1)
  end
  r.owned:Hide()

  r._texAlliance = "Interface\\FriendsFrame\\PlusManz-Alliance"
  r._texHorde = "Interface\\FriendsFrame\\PlusManz-Horde"

  r.title = r:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  r.title:SetPoint("TOPLEFT", r.media, "TOPRIGHT", 10, -10)
  r.title:SetPoint("RIGHT", r, "RIGHT", -12, 0)
  r.title:SetJustifyH("LEFT")
  r.title:SetWordWrap(false)
  r.title:SetMaxLines(1)

  r.reqAQ = r:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  r.reqAQ:SetPoint("TOPLEFT", r.title, "BOTTOMLEFT", 0, -2)
  r.reqAQ:SetPoint("RIGHT", r, "RIGHT", -12, 0)
  r.reqAQ:SetJustifyH("LEFT")
  r.reqAQ:SetWordWrap(false)
  r.reqAQ:Hide()

  r.reqRep = r:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  r.reqRep:SetPoint("TOPLEFT", r.reqAQ, "BOTTOMLEFT", 0, -2)
  r.reqRep:SetPoint("RIGHT", r, "RIGHT", -12, 0)
  r.reqRep:SetJustifyH("LEFT")
  r.reqRep:SetWordWrap(false)
  r.reqRep:Hide()

  if RS and RS.SkinTrackerItem then
    RS:SkinTrackerItem(r, 0.16)
  end

  return r
end

function Rows:InitPools(frame, content)
  frame._pool = frame._pool or { overall = {}, vendor = {}, item = {} }
  frame._active = frame._active or {}
  frame._content = content
  frame._rowFactories = frame._rowFactories or {
    overall = function() return NewOverallRow(content) end,
    vendor = function() return NewVendorRow(content) end,
    item = function() return NewItemRow(content) end,
  }
end

function Rows:Acquire(frame, kind)
  local pool = frame._pool and frame._pool[kind]
  if not pool then return end

  local row = table.remove(pool)
  if not row then
    local f = frame._rowFactories and frame._rowFactories[kind]
    row = f and f() or nil
  end
  if not row then return end

  if RS then
    if kind == "overall" or kind == "vendor" then
      if RS.SkinTrackerHeader then
        RS:SkinTrackerHeader(row, 0.16)
      end
    else
      if RS.SkinTrackerItem then
        RS:SkinTrackerItem(row, 0.16)
      end
    end
  end

  row:Show()
  local active = frame._active
  active[#active + 1] = row
  return row
end

function Rows:ReleaseAll(frame)
  local active = frame and frame._active
  local pool = frame and frame._pool
  if not active or not pool then return end

  for i = 1, #active do
    local r = active[i]
    if r then
      r:Hide()
      r:ClearAllPoints()
      local k = r._kind or "item"
      local p = pool[k]
      if p then
        p[#p + 1] = r
      end
    end
  end

  wipe(active)
end

return Rows