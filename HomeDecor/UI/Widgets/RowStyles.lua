local ADDON, NS = ...

NS.UI = NS.UI or {}
local RS = NS.UI.RowStyles or {}
NS.UI.RowStyles = RS

local C = NS.UI.Controls

local tonumber, type = tonumber, type

local function ThemeColors()
  return (NS.UI and NS.UI.Theme and NS.UI.Theme.colors) or {}
end

local function ClampAlpha(x)
  x = tonumber(x) or 0
  if x < 0 then return 0 end
  if x > 1 then return 1 end
  return x
end

local function Mix(a, b, t)
  if type(a) ~= "table" or type(b) ~= "table" then return a or b end
  t = ClampAlpha(t)
  local ar, ag, ab, aa = a[1] or 1, a[2] or 1, a[3] or 1, a[4]
  local br, bg, bb, ba = b[1] or 1, b[2] or 1, b[3] or 1, b[4]
  local r = ar + (br - ar) * t
  local g = ag + (bg - ag) * t
  local b2 = ab + (bb - ab) * t
  local a2 = (aa ~= nil) and aa or ((ba ~= nil) and ba or 1)
  return { r, g, b2, a2 }
end

local function DimBorder(border, factor, alpha)
  if type(border) ~= "table" then return border end
  factor = tonumber(factor) or 0.70
  alpha = tonumber(alpha) or border[4] or 1
  return { (border[1] or 1) * factor, (border[2] or 1) * factor, (border[3] or 1) * factor, alpha }
end

local function BronzeBase()
  local T = ThemeColors()
  local b = T.borderGold or T.accentSoft or T.accent
  if type(b) == "table" then
    return { b[1] or 0.62, b[2] or 0.50, b[3] or 0.14, b[4] or 1 }
  end
  return { 0.62, 0.50, 0.14, 1 }
end

local function Palette()
  local T = ThemeColors()

  local text = T.text or { 0.92, 0.92, 0.92, 1 }
  local subt = T.textMuted or T.placeholder or { 0.65, 0.65, 0.68, 1 }

  local warm = BronzeBase()

  local gold = Mix(warm, subt, 0.62)
  gold[4] = warm[4] or 1

  return gold, text, subt
end

local function GetInheritedAlpha(frame)
  local p = frame
  while p do
    if p._bgAlpha ~= nil then
      return ClampAlpha(p._bgAlpha)
    end
    p = p.GetParent and p:GetParent() or nil
  end
  return 1
end

local function SetTexAlpha(tex, a)
  if not tex then return end
  if tex.SetAlpha then tex:SetAlpha(a) end
  if a <= 0 then
    if tex.Hide then tex:Hide() end
  else
    if tex.Show then tex:Show() end
  end
end

local function HeaderBorderColor()
  local T = ThemeColors()
  local base = T.headerBorder
  if type(base) == "table" then
    return { base[1] or 0.60, base[2] or 0.48, base[3] or 0.14, base[4] or 1 }
  end
  local b = BronzeBase()
  return Mix(b, { 0.35, 0.35, 0.38, 1 }, 0.35)
end

local function DefaultBorderColor()
  local T = ThemeColors()
  local base = T.borderGold or T.accentSoft or T.accent
  if type(base) ~= "table" then base = { 0.62, 0.50, 0.14, 1 } end
  local neutral = T.border
  if type(neutral) ~= "table" then neutral = { 0.35, 0.35, 0.38, 1 } end
  return Mix(base, neutral, 0.55)
end

local function BorderColorFor(frame)
  if frame and frame.__rsKind == "header" then
    return HeaderBorderColor()
  end
  return DefaultBorderColor()
end

local function BackdropBorderAlpha(frame, a)
  if not frame or not frame.SetBackdropBorderColor then return end
  a = ClampAlpha(a or 0)
  local c = BorderColorFor(frame)
  frame:SetBackdropBorderColor(c[1] or 1, c[2] or 1, c[3] or 1, a)
end

local function ApplyPieces(t, a)
  if type(t) ~= "table" then return end
  SetTexAlpha(t.LeftEdge, a); SetTexAlpha(t.RightEdge, a)
  SetTexAlpha(t.TopEdge, a); SetTexAlpha(t.BottomEdge, a)
  SetTexAlpha(t.TopLeftCorner, a); SetTexAlpha(t.TopRightCorner, a)
  SetTexAlpha(t.BottomLeftCorner, a); SetTexAlpha(t.BottomRightCorner, a)
end

function RS:ForceBorderAlpha(frame, a)
  if not frame then return end
  a = ClampAlpha(a or 0)

  BackdropBorderAlpha(frame, a)

  SetTexAlpha(frame.LeftEdge, a); SetTexAlpha(frame.RightEdge, a)
  SetTexAlpha(frame.TopEdge, a); SetTexAlpha(frame.BottomEdge, a)
  SetTexAlpha(frame.TopLeftCorner, a); SetTexAlpha(frame.TopRightCorner, a)
  SetTexAlpha(frame.BottomLeftCorner, a); SetTexAlpha(frame.BottomRightCorner, a)

  ApplyPieces(frame._bd, a)
  ApplyPieces(frame.__bd, a)
  ApplyPieces(frame._backdrop, a)
  ApplyPieces(frame.__backdrop, a)

  if frame.backdropInfo and frame.backdropInfo.borderColor then
    frame.backdropInfo.borderColor[4] = a
  end

  if frame.border and type(frame.border) == "table" then
    SetTexAlpha(frame.border, a)
  end
end

local function EnsureHighlight(frame)
  if not frame or frame._rsHL then return end
  frame._rsHL = frame:CreateTexture(nil, "HIGHLIGHT")
  frame._rsHL:SetAllPoints()
  frame._rsHL:SetColorTexture(1, 1, 1, 1)
  frame._rsHL:SetBlendMode("ADD")
  frame._rsHL:Hide()
end

local function SetHighlight(frame, alpha, show)
  local gold = Palette()
  EnsureHighlight(frame)
  frame._rsHL:SetVertexColor(gold[1], gold[2], gold[3], gold[4] or 1)
  frame._rsHL:SetAlpha(alpha or 0)
  if show then frame._rsHL:Show() else frame._rsHL:Hide() end
end

function RS:ApplyHover(frame, baseAlpha)
  if not frame or not frame.SetScript or frame._rsHoverApplied then return end
  frame._rsHoverApplied = true

  baseAlpha = tonumber(baseAlpha) or 0.14
  frame._rsHoverBase = baseAlpha

  EnsureHighlight(frame)
  SetHighlight(frame, 0, false)

  frame:HookScript("OnEnter", function(self)
    if self._rsSelected then return end
    local a = GetInheritedAlpha(self) * (tonumber(self._rsHoverBase) or 0.14)
    SetHighlight(self, a, true)
  end)

  frame:HookScript("OnLeave", function(self)
    if self._rsSelected then return end
    if self._rsHL then self._rsHL:Hide() end
  end)
end

function RS:SetSelected(frame, selected, alpha)
  if not frame then return end
  EnsureHighlight(frame)

  frame._rsSelected = selected and true or false
  if frame._rsSelected then
    local a = GetInheritedAlpha(frame) * (tonumber(alpha) or 0.22)
    SetHighlight(frame, a, true)
  else
    if frame._rsHL then frame._rsHL:Hide() end
  end
end

function RS:Reset(frame)
  if not frame then return end

  frame._rsSelected = nil

  if frame._rsHL then
    frame._rsHL:SetAlpha(0)
    frame._rsHL:Hide()
  end

  if frame.GetHighlightTexture then
    local ht = frame:GetHighlightTexture()
    if ht and ht.Hide then ht:Hide() end
  end

  if frame.__hdHeaderHover and frame.__hdHeaderHover.Hide then
    frame.__hdHeaderHover:Hide()
  end
end

function RS:ApplyFonts(row)
  local _, text, subt = Palette()
  if not row then return end

  local function SetFS(fs, fontObj, r, g, b, a)
    if not fs then return end
    if fontObj and fs.SetFontObject then fs:SetFontObject(fontObj) end
    if r and fs.SetTextColor then fs:SetTextColor(r, g, b, a or 1) end
  end

  SetFS(row.text,  GameFontNormal, text[1], text[2], text[3], text[4])
  SetFS(row.title, GameFontNormal, text[1], text[2], text[3], text[4])
  SetFS(row.label, GameFontNormal, text[1], text[2], text[3], text[4])
  SetFS(row.zone,  GameFontNormal, text[1], text[2], text[3], text[4])

  SetFS(row.meta,   GameFontHighlightSmall, subt[1], subt[2], subt[3], subt[4])
  SetFS(row.count,  GameFontHighlightSmall, subt[1], subt[2], subt[3], subt[4])
  SetFS(row.timer,  GameFontHighlightSmall, subt[1], subt[2], subt[3], subt[4])
  SetFS(row.reqAQ,  GameFontHighlightSmall, subt[1], subt[2], subt[3], subt[4])
  SetFS(row.reqRep, GameFontHighlightSmall, subt[1], subt[2], subt[3], subt[4])
  SetFS(row.req,    GameFontHighlightSmall, subt[1], subt[2], subt[3], subt[4])
  SetFS(row.rep,    GameFontHighlightSmall, subt[1], subt[2], subt[3], subt[4])
end

function RS:StrongText(fs)
  local gold = Palette()
  if not fs or not fs.SetFontObject then return end
  fs:SetFontObject(GameFontNormalLarge)
  if fs.SetTextColor then fs:SetTextColor(gold[1], gold[2], gold[3], 1) end
end

function RS:ApplyDivider(tex, alpha)
  if not tex or not tex.SetColorTexture then return end
  alpha = tonumber(alpha) or 0.08
  tex:SetColorTexture(1, 1, 1, alpha)
end

function RS:ApplyAccent(tex, alpha)
  if not tex or not tex.SetColorTexture then return end
  alpha = tonumber(alpha) or 0.055
  tex:SetColorTexture(1, 1, 1, alpha)
end

function RS:ApplySoftBg(tex, alpha)
  if not tex or not tex.SetColorTexture then return end
  alpha = tonumber(alpha) or 0.02
  tex:SetColorTexture(1, 1, 1, alpha)
end

local function BackdropFor(kind)
  local T = ThemeColors()
  if kind == "header" then
    local bg = (T.header or T.row or T.panel)
    local bd = T.border
    if type(bd) == "table" then
      bd = DimBorder(bd, 0.80, (bd[4] ~= nil and bd[4] or 1))
    else
      bd = { 0.30, 0.30, 0.33, 1 }
    end
    return bg, bd
  end
  if kind == "media" then
    return (T.row or T.panel), T.border
  end
  if kind == "button" then
    return (T.button or T.panel), T.border
  end
  return (T.panel or T.row), T.border
end

function RS:ApplyBackdrop(frame, kind)
  if not frame or not (C and C.Backdrop) then return end

  frame.__rsKind = kind

  local bg, border = BackdropFor(kind)
  C:Backdrop(frame, bg, border)

  local T = ThemeColors()
  local headerA = tonumber(T.headerBorderAlpha) or 0.72

  if kind == "item" then
    self:ForceBorderAlpha(frame, 1)
  elseif kind == "header" then
    self:ForceBorderAlpha(frame, headerA)
  else
    self:ForceBorderAlpha(frame, 0)
  end
end

local function ApplyHeaderTint(frame)
  if not frame then return end
  local T = ThemeColors()

  local base = T.headerTint or HeaderBorderColor()
  local text = (T.textMuted or T.placeholder or { 0.65, 0.65, 0.68, 1 })

  local c = Mix(base, text, 0.58)
  c[4] = (type(base) == "table" and base[4]) or 1

  if frame.__hdHeaderTex and frame.__hdHeaderTex.SetVertexColor then
    frame.__hdHeaderTex:SetVertexColor(c[1] or 1, c[2] or 1, c[3] or 1, c[4] or 1)
  end
  if frame.__hdHeaderTex and frame.__hdHeaderTex.SetAlpha then
    frame.__hdHeaderTex:SetAlpha(c[4] or 1)
  end
end

function RS:ApplyHeaderTexture(frame, isWidget)
  if not frame then return end
  if C and C.ApplyHeaderTexture then
    C:ApplyHeaderTexture(frame, isWidget and true or false)
  end
  ApplyHeaderTint(frame)
end

function RS:SkinHeader(row, hoverAlpha)
  if not row then return end
  self:Reset(row)

  local T = ThemeColors()
  local headerA = tonumber(T.headerBorderAlpha) or 0.72

  self:ApplyBackdrop(row, "header")
  self:ApplyHeaderTexture(row, false)
  self:ForceBorderAlpha(row, headerA)

  ApplyHeaderTint(row)
  self:ApplyHover(row, hoverAlpha or 0.18)
  self:ApplyFonts(row)

  if not row.__rsOnShowHook then
    row.__rsOnShowHook = true
    row:HookScript("OnShow", function(selfRow)
      if RS then
        local TT = ThemeColors()
        local a = tonumber(TT.headerBorderAlpha) or 0.72
        RS:ApplyBackdrop(selfRow, "header")
        RS:ApplyHeaderTexture(selfRow, false)
        RS:ForceBorderAlpha(selfRow, a)
        ApplyHeaderTint(selfRow)
        RS:ApplyFonts(selfRow)
      end
    end)
  end
end

function RS:SkinListRow(row, hoverAlpha)
  if not row then return end
  self:Reset(row)

  self:ApplyBackdrop(row, "item")
  self:ApplyHover(row, hoverAlpha or 0.14)
  self:ApplyFonts(row)

  self:ApplyAccent(row.accent, 0.055)
  self:ApplySoftBg(row.textBg, 0.02)
  self:ApplyDivider(row.div, 0.08)

  if row.iconBG then
    self:ApplyBackdrop(row.iconBG, "media")
  end
end

function RS:SkinTile(row, hoverAlpha)
  if not row then return end
  self:Reset(row)

  self:ApplyBackdrop(row, "item")
  self:ApplyHover(row, hoverAlpha or 0.14)
  self:ApplyFonts(row)

  self:ApplySoftBg(row.textBg, 0.02)
  self:ApplyDivider(row.div, 0.08)
  self:ApplyDivider(row.titleDiv, 0.08)

  if row.mediaBg then
    self:ApplyAccent(row.mediaBg, 0.055)
  end
end

function RS:SkinTrackerHeader(row, hoverAlpha)
  self:SkinHeader(row, hoverAlpha or 0.14)
end

function RS:SkinTrackerItem(row, hoverAlpha)
  self:SkinListRow(row, hoverAlpha or 0.14)
  if row.mediaBg then self:ApplyAccent(row.mediaBg, 0.055) end
end

return RS
