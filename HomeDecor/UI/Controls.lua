local ADDON, NS = ...

NS.UI = NS.UI or {}

local C = {}
NS.UI.Controls = C

local unpack = _G.unpack or table.unpack
local min = math.min

local function GetTheme()
  local UI = NS.UI
  local Theme = UI and UI.Theme
  return Theme, Theme and Theme.colors, Theme and Theme.textures
end

function C:Backdrop(frame, bgColor, borderColor)
  if not frame then return end

  if frame.SetBackdrop then
    frame:SetBackdrop({
      bgFile = "Interface\\Buttons\\WHITE8x8",
      edgeFile = "Interface\\Buttons\\WHITE8x8",
      tile = false,
      edgeSize = 1,
      insets = { left = 0, right = 0, top = 0, bottom = 0 },
    })
  end

  if frame.SetBackdropColor then
    if bgColor then
      frame:SetBackdropColor(unpack(bgColor))
    else
      frame:SetBackdropColor(0, 0, 0, 0.80)
    end
  end

  if frame.SetBackdropBorderColor then
    if borderColor then
      frame:SetBackdropBorderColor(unpack(borderColor))
    else
      frame:SetBackdropBorderColor(0.20, 0.20, 0.20, 1)
    end
  end
end

function C:ApplyHover(btn, bgNormal, bgHover, borderNormal, borderHover)
  if not btn then return end
  if not btn.backdropInfo and not btn.SetBackdrop then
    if Mixin and BackdropTemplateMixin then
      Mixin(btn, BackdropTemplateMixin)
    end
  end

  local _, T = GetTheme()
  local nbg = bgNormal or (T and T.row) or { 0.08, 0.08, 0.10, 1 }
  local hbg = bgHover or (T and T.hover) or { 0.14, 0.14, 0.17, 1 }
  local nbd = borderNormal or (T and T.border) or { 0.35, 0.28, 0.14, 0.9 }
  local hbd = borderHover or (T and T.accentSoft) or { 0.92, 0.78, 0.45, 0.55 }

  if not btn.__hdHasBackdrop then
    self:Backdrop(btn, nbg, nbd)
    btn.__hdHasBackdrop = true
  end

  local function setColors(bg, bd)
    if btn.SetBackdropColor then
      btn:SetBackdropColor(bg[1], bg[2], bg[3], bg[4] or 1)
    end
    if btn.SetBackdropBorderColor then
      btn:SetBackdropBorderColor(bd[1], bd[2], bd[3], bd[4] or 1)
    end
  end

  setColors(nbg, nbd)

  if btn.__hdHoverHooked then return end
  btn.__hdHoverHooked = true

  btn:HookScript("OnEnter", function() setColors(hbg, hbd) end)
  btn:HookScript("OnLeave", function() setColors(nbg, nbd) end)
  btn:HookScript("OnMouseDown", function()
    setColors({ hbg[1] * 0.85, hbg[2] * 0.85, hbg[3] * 0.85, hbg[4] }, hbd)
  end)
  btn:HookScript("OnMouseUp", function()
    if btn.IsMouseOver and btn:IsMouseOver() then
      setColors(hbg, hbd)
    else
      setColors(nbg, nbd)
    end
  end)
  btn:HookScript("OnDisable", function()
    setColors({ nbg[1], nbg[2], nbg[3], 0.55 }, { nbd[1], nbd[2], nbd[3], 0.35 })
  end)
  btn:HookScript("OnEnable", function()
    setColors(nbg, nbd)
  end)
end

function C:Segmented(parent, labels, getValue, setValue)
  local _, T = GetTheme()
  labels = labels or {}

  local f = CreateFrame("Frame", nil, parent)
  f:SetHeight(24)

  local btns = {}
  local pad = 2
  local bw = (#labels >= 2) and 44 or 46
  f:SetWidth(#labels * bw + (#labels - 1) * pad)

  local function styleSelected(b, selected)
    if not b then return end
    local bg = b.__hdNormalBG
    if selected then
      if bg then
        bg:SetVertexColor(unpack(T.accent))
        bg:SetAlpha(0.22)
      end
      if b.text then
        b.text:SetTextColor(unpack(T.text))
      end
    else
      if bg then
        bg:SetVertexColor(1, 1, 1, 1)
        bg:SetAlpha(1.0)
      end
      if b.text then
        b.text:SetTextColor(unpack(T.textMuted))
      end
    end
  end

  local function refresh()
    local cur = getValue and getValue() or nil
    for i = 1, #btns do
      styleSelected(btns[i], labels[i] == cur)
    end
  end

  for i = 1, #labels do
    local label = labels[i]
    local b = CreateFrame("Button", nil, f, "BackdropTemplate")
    b:SetSize(bw, 24)

    if i == 1 then
      b:SetPoint("LEFT", f, "LEFT", 0, 0)
    else
      b:SetPoint("LEFT", btns[i - 1], "RIGHT", pad, 0)
    end

    self:Backdrop(b, T and T.panel, T and T.border)
    self:ApplyHover(b, T and T.panel, T and T.hover, T and T.border, T and T.accentSoft)

    b.text = b:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    b.text:SetPoint("CENTER", 0, 0)
    b.text:SetText(label)

    b:SetScript("OnClick", function()
      if setValue then
        setValue(label)
      end
      refresh()
      if f.OnValueChanged then
        f:OnValueChanged(label)
      end
    end)

    btns[i] = b
  end

  f.buttons = btns
  f.Refresh = refresh
  f:SetScript("OnShow", refresh)
  refresh()
  return f
end

local function HideRegions(frame)
  if not frame or not frame.GetRegions then return end
  for i = 1, 40 do
    local r = select(i, frame:GetRegions())
    if not r then break end
    if r.GetObjectType and r:GetObjectType() == "Texture" then
      local tx = r.GetTexture and r:GetTexture()
      local at = r.GetAtlas and r:GetAtlas()
      if tx or at then
        r:SetAlpha(0)
      end
    end
  end
end

function C:ApplyBackdropHover(frame, normal, hover)
  if not frame or frame.__hdHover then return end
  if not frame.SetBackdropColor then return end
  frame.__hdHover = true

  local n = normal or { frame:GetBackdropColor() }
  local h = hover or { n[1], n[2], n[3], 0.18 }

  frame:SetScript("OnEnter", function()
    if not frame._selected then
      frame:SetBackdropColor(unpack(h))
    end
  end)

  frame:SetScript("OnLeave", function()
    if not frame._selected then
      frame:SetBackdropColor(unpack(n))
    end
  end)
end

function C:SetSelected(frame, selected, normal, selectedBG)
  if not frame or not frame.SetBackdropColor then return end
  frame._selected = selected and true or false

  if selected then
    if selectedBG then
      frame:SetBackdropColor(unpack(selectedBG))
    else
      frame:SetBackdropColor(0.90, 0.75, 0.35, 0.20)
    end
  else
    if normal then
      frame:SetBackdropColor(unpack(normal))
    end
  end
end

function C:ApplyHeaderTexture(frame, big)
  if not frame or frame.__hdHeaderSkinned then return end
  local _, _, X = GetTheme()
  if not X then return end

  frame.__hdHeaderSkinned = true

  local tex = frame:CreateTexture(nil, "BACKGROUND", nil, 0)
  frame.__hdHeaderTex = tex
  tex:SetAllPoints(frame)
  tex:SetTexture(big and (X.BigHeaderBar or X.HeaderBar) or X.HeaderBar)
  tex:SetAlpha(1)

  local hover = frame:CreateTexture(nil, "ARTWORK", nil, 1)
  frame.__hdHeaderHover = hover
  hover:SetAllPoints(frame)
  hover:SetTexture(big and (X.BigHeaderBar or X.HeaderBar) or X.HeaderBar)
  hover:SetAlpha(0)

  if frame.EnableMouse then
    frame:EnableMouse(true)
  end

  frame:HookScript("OnEnter", function()
    local h = frame.__hdHeaderHover
    if h then h:SetAlpha(0.35) end
  end)

  frame:HookScript("OnLeave", function()
    local h = frame.__hdHeaderHover
    if h then h:SetAlpha(0) end
  end)
end

function C:SkinButton(btn, isTab)
  if not btn or btn.__hdBtnSkinned then return end
  local _, _, X = GetTheme()
  if not X then return end

  btn.__hdBtnSkinned = true

  if btn.SetNormalTexture then
    btn:SetNormalTexture(isTab and X.TabNormal or X.ButtonNormal)
  end
  if btn.SetPushedTexture then
    btn:SetPushedTexture(isTab and X.TabPushed or X.ButtonPushed)
  end
  if btn.SetDisabledTexture and (isTab and X.TabDisabled or X.ButtonDisabled) then
    btn:SetDisabledTexture(isTab and X.TabDisabled or X.ButtonDisabled)
  end
  if btn.SetHighlightTexture then
    btn:SetHighlightTexture(isTab and X.TabHover or X.ButtonHover, "BLEND")
  end

  local nt = btn.GetNormalTexture and btn:GetNormalTexture()
  if nt then
    nt:SetAllPoints(btn)
    nt:SetDrawLayer("ARTWORK", 0)
    nt:SetAlpha(1)
  end

  local pt = btn.GetPushedTexture and btn:GetPushedTexture()
  if pt then
    pt:SetAllPoints(btn)
    pt:SetDrawLayer("ARTWORK", 1)
    pt:SetAlpha(1)
  end

  local dt = btn.GetDisabledTexture and btn:GetDisabledTexture()
  if dt then
    dt:SetAllPoints(btn)
    dt:SetDrawLayer("ARTWORK", 0)
    dt:SetAlpha(1)
  end

  local ht = btn.GetHighlightTexture and btn:GetHighlightTexture()
  if ht then
    ht:SetAllPoints(btn)
    ht:SetDrawLayer("ARTWORK", 0)
    ht:SetAlpha(0.28)
    if ht.SetBlendMode then
      ht:SetBlendMode("ADD")
    end
  end

  if btn.GetNumRegions and btn.GetRegions then
    for i = 1, btn:GetNumRegions() do
      local r = select(i, btn:GetRegions())
      if r and r.GetObjectType and r:GetObjectType() == "FontString" and r.SetDrawLayer then
        r:SetDrawLayer("OVERLAY", 7)
      end
    end
  end

  if btn.text and btn.text.SetDrawLayer then
    btn.text:SetDrawLayer("OVERLAY", 7)
  end
end

function C:SkinScrollFrame(sf)
  if not sf then return end
  local _, _, X = GetTheme()
  if not X then return end

  local sb = sf.ScrollBar or sf.scrollBar or (sf.GetScrollBar and sf:GetScrollBar())
  if not sb then return end

  local function overlay(owner, key, texture, layer, sub)
    if not (owner and owner.CreateTexture) then return end
    local t = owner[key]
    if not t then
      t = owner:CreateTexture(nil, layer or "ARTWORK", nil, sub or 2)
      owner[key] = t
    end
    t:SetTexture(texture)
    t:SetAllPoints(owner)
    t:Show()
    return t
  end

  local trackOwner = sb.Track or sb
  HideRegions(trackOwner)
  overlay(trackOwner, "__hdTrackOverlay", X.ScrollTrack, "BACKGROUND", 0)

  local thumbBtn = sb.Thumb or (sb.Track and sb.Track.Thumb) or (sb.GetThumb and sb:GetThumb())
  local classicThumb = (sb.GetThumbTexture and sb:GetThumbTexture()) or sb.ThumbTexture

  if thumbBtn and thumbBtn.CreateTexture then
    if thumbBtn.Begin then thumbBtn.Begin:SetAlpha(0) end
    if thumbBtn.Middle then thumbBtn.Middle:SetAlpha(0) end
    if thumbBtn.End then thumbBtn.End:SetAlpha(0) end
    HideRegions(thumbBtn)
    overlay(thumbBtn, "__hdThumbOverlay", X.ScrollThumb, "ARTWORK", 5)

    if not thumbBtn.__hdThumbHooks then
      thumbBtn.__hdThumbHooks = true
      local function reshow(b) local o = b.__hdThumbOverlay; if o then o:Show() end end
      thumbBtn:HookScript("OnShow", reshow)
      thumbBtn:HookScript("OnMouseDown", reshow)
      thumbBtn:HookScript("OnMouseUp", reshow)
      thumbBtn:HookScript("OnEnter", reshow)
      thumbBtn:HookScript("OnLeave", reshow)
    end
  elseif classicThumb and classicThumb.SetTexture then
    classicThumb:SetTexture(X.ScrollThumb)
    classicThumb:SetAlpha(1)
    classicThumb:Show()
  end

  local upBtn = sb.Back or sb.UpButton
  local dnBtn = sb.Forward or sb.DownButton

  local function skinArrow(btn, tex)
    if not btn then return end
    HideRegions(btn)
    local o = overlay(btn, "__hdArrowOverlay", tex, "ARTWORK", 6)
    if o then
      o:ClearAllPoints()
      o:SetPoint("CENTER", btn, "CENTER", 0, 0)
      local w, h = btn:GetSize()
      local s = 16
      if w and h and w > 0 and h > 0 then
        s = min(16, w, h)
      end
      o:SetSize(s, s)
    end
    if btn.__hdArrowHooks then return end
    btn.__hdArrowHooks = true
    local function reshow(b) local o2 = b.__hdArrowOverlay; if o2 then o2:Show() end end
    btn:HookScript("OnShow", reshow)
    btn:HookScript("OnMouseDown", reshow)
    btn:HookScript("OnMouseUp", reshow)
  end

  skinArrow(upBtn, X.ScrollArrowUp or X.DropdownArrow)
  skinArrow(dnBtn, X.ScrollArrowDown or X.DropdownArrow)
end

function C:PolishWidgets(root)
  if not root then return end
  local _, _, X = GetTheme()
  if not X then return end

  local function looksLikeHeader(f)
    if not f or f.__hdHeaderSkinned then return false end
    if f._kind == "header" then return true end
    if not f.GetHeight then return false end
    local h = f:GetHeight()
    if not h or h < 18 or h > 44 then return false end
    if f.GetObjectType and f:GetObjectType() == "Button" then return false end
    if f.GetBackdrop and f:GetBackdrop() then return true end
    return false
  end

  local function apply(f)
    if not f then return end

    if looksLikeHeader(f) then
      self:ApplyHeaderTexture(f, f:GetHeight() >= 30)
    end

    if f.GetObjectType and f:GetObjectType() == "Button" then
      self:SkinButton(f, f.__hdIsTab == true)
    end

    if f.SetBackdropColor and not f.__hdHover then
      self:ApplyBackdropHover(f)
    end
  end

  local function walk(f, depth)
    apply(f)
    if depth <= 0 or not f.GetChildren then return end
    for _, ch in ipairs({ f:GetChildren() }) do
      walk(ch, depth - 1)
    end
  end

  walk(root, 6)
end

function C:ClearHoverHighlights(root)
  if not root or type(root) ~= "table" or not root.GetChildren then return end

  local stack = { root }
  local idx = 1

  while stack[idx] do
    local f = stack[idx]
    idx = idx + 1

    local rs = f._rsHL
    if rs and rs.Hide then
      rs:Hide()
    end

    local hl = f._hl
    if hl then
      if hl.SetAlpha then hl:SetAlpha(0) end
      if hl.Hide then hl:Hide() end
    end

    local ok, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10 = pcall(f.GetChildren, f)
    if ok then
      local children = { c1, c2, c3, c4, c5, c6, c7, c8, c9, c10 }
      if #children == 10 then
        children = { f:GetChildren() }
      end
      for i = 1, #children do
        local ch = children[i]
        if ch then
          stack[#stack + 1] = ch
        end
      end
    end
  end
end

return C
