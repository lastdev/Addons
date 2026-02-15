local ADDON, NS = ...
NS.UI = NS.UI or {}
local View = NS.UI.Viewer
local Frames = View.Frames

local function RS()
  return NS.UI and NS.UI.RowStyles
end

function Frames.CreateHeader(content)
  local h = CreateFrame("Button", nil, content, "BackdropTemplate")
  h._kind = "header"
  h:EnableMouse(true)
  h:RegisterForClicks("AnyUp")

  h.text = h:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  h.text:SetPoint("TOPLEFT", 14, -6)

  h.count = h:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  h.count:SetPoint("TOPRIGHT", -44, -6)

  h.check = h:CreateTexture(nil, "OVERLAY")
  h.check:SetSize(14, 14)
  h.check:SetPoint("TOPRIGHT", -14, -6)
  h.check:SetTexture("Interface\\RaidFrame\\ReadyCheck-Ready")
  h.check:Hide()

  local S = RS()
  if S then S:SkinHeader(h, 0.20) end

  return h
end

function Frames.CreateListRow(content)
  local r = CreateFrame("Frame", nil, content, "BackdropTemplate")
  r._kind = "list"
  r:EnableMouse(true)
  r:SetClipsChildren(true)

  r.accent = r:CreateTexture(nil, "BACKGROUND")
  r.accent:SetPoint("TOPLEFT", 0, 0)
  r.accent:SetPoint("BOTTOMLEFT", 0, 0)
  r.accent:SetWidth(3)

  r.textBg = r:CreateTexture(nil, "BACKGROUND")
  r.textBg:SetPoint("TOPLEFT", 58, -2)
  r.textBg:SetPoint("BOTTOMRIGHT", -2, 2)

  r.iconBG = CreateFrame("Frame", nil, r, "BackdropTemplate")
  r.iconBG:SetSize(44, 44)
  r.iconBG:SetPoint("LEFT", 10, 0)

  r.icon = r.iconBG:CreateTexture(nil, "ARTWORK")
  r.icon:SetPoint("TOPLEFT", 4, -4)
  r.icon:SetPoint("BOTTOMRIGHT", -4, 4)
  r.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")

  r.checkFrame = CreateFrame("Frame", nil, r.iconBG)
  r.checkFrame:SetAllPoints(r.iconBG)
  r.checkFrame:SetFrameLevel(r.iconBG:GetFrameLevel() + 10)

  r.check = r.checkFrame:CreateTexture(nil, "OVERLAY")
  r.check:SetSize(22, 22)
  r.check:SetPoint("CENTER", r.icon, "CENTER", 0, 0)
  r.check:SetTexture("Interface\\RaidFrame\\ReadyCheck-Ready")
  r.check:Hide()

  r.factionIcon = r.checkFrame:CreateTexture(nil, "OVERLAY")
  r.factionIcon:SetSize(16, 16)
  r.factionIcon:SetPoint("TOPRIGHT", r.iconBG, "TOPRIGHT", -2, -2)
  r.factionIcon:Hide()

  r.text = r:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  r.text:SetPoint("TOPLEFT", 64, -6)
  r.text:SetJustifyH("LEFT")
  r.text:SetWordWrap(false)
  r.text:SetMaxLines(1)

  r.meta = r:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  r.meta:SetPoint("TOPLEFT", r.text, "BOTTOMLEFT", 0, -2)
  r.meta:SetJustifyH("LEFT")
  r.meta:SetWordWrap(false)
  r.meta:SetMaxLines(1)
  r.meta:Hide()

  r.div = r:CreateTexture(nil, "BORDER")
  r.div:Hide()

  r.req = r:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
  r.req:SetPoint("TOPLEFT", r.text, "BOTTOMLEFT", 0, -2)
  r.req:SetJustifyH("LEFT")
  r.req:SetWordWrap(false)
  r.req:SetMaxLines(1)
  r.req:Hide()

  r.rep = r:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
  r.rep:SetPoint("TOPLEFT", r.req, "BOTTOMLEFT", 0, -1)
  r.rep:SetJustifyH("LEFT")
  r.rep:SetWordWrap(false)
  r.rep:SetMaxLines(1)
  r.rep:Hide()

  r.reqBtn = CreateFrame("Button", nil, r)
  r.reqBtn:Hide()
  r.reqBtn:EnableMouse(true)
  r.reqBtn:RegisterForClicks("AnyUp")

  local S = RS()
  if S then S:SkinListRow(r, 0.16) end

  return r
end

function Frames.CreateTile(content)
  local r = CreateFrame("Frame", nil, content, "BackdropTemplate")
  r._kind = "tile"
  r:EnableMouse(true)
  r:SetClipsChildren(true)

  r.media = CreateFrame("Frame", nil, r, "BackdropTemplate")
  r.media:SetPoint("TOPLEFT", 10, -10)
  r.media:SetPoint("TOPRIGHT", -10, -10)
  r.media:SetHeight(85)
  r.media:SetClipsChildren(true)

  r.mediaBg = r.media:CreateTexture(nil, "BACKGROUND")
  r.mediaBg:SetAllPoints()

  r.icon = r.media:CreateTexture(nil, "ARTWORK")
  r.icon:SetPoint("CENTER", 0, 0)
  r.icon:SetSize(68, 68)

  if r.icon.SetTexCoord then r.icon:SetTexCoord(0.20, 0.80, 0.20, 0.80) end
  r.checkFrame = CreateFrame("Frame", nil, r.media)
  r.checkFrame:SetAllPoints(r.media)
  r.checkFrame:SetFrameLevel(r.media:GetFrameLevel() + 10)

  r.check = r.checkFrame:CreateTexture(nil, "OVERLAY")
  r.check:SetSize(26, 26)
  r.check:SetPoint("CENTER", r.icon, "CENTER", 0, 0)
  r.check:SetTexture("Interface\\RaidFrame\\ReadyCheck-Ready")
  r.check:Hide()

  r.factionIcon = r.checkFrame:CreateTexture(nil, "OVERLAY")
  r.factionIcon:SetSize(24, 24)
  r.factionIcon:SetPoint("TOPRIGHT", r.media, "TOPRIGHT", -6, -6)
  r.factionIcon:Hide()

  r.dyePaletteFrame = CreateFrame("Frame", nil, r.media, "BackdropTemplate")
  r.dyePaletteFrame:SetSize(50, 16)
  r.dyePaletteFrame:SetPoint("BOTTOMLEFT", r.media, "BOTTOMLEFT", 2, 2)
  r.dyePaletteFrame:SetFrameLevel(r.media:GetFrameLevel() + 15)
  r.dyePaletteFrame:Hide()

  r.dyePaletteFrame.bg = r.dyePaletteFrame:CreateTexture(nil, "BACKGROUND")
  r.dyePaletteFrame.bg:SetAllPoints()
  r.dyePaletteFrame.bg:SetColorTexture(0, 0, 0, 0.75)

  r.dyePaletteFrame.text = r.dyePaletteFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
  r.dyePaletteFrame.text:SetPoint("CENTER", 0, 0)
  r.dyePaletteFrame.text:SetText("")
  r.dyePaletteFrame.text:SetTextColor(0.4, 0.9, 1.0, 1)

  r.div = r:CreateTexture(nil, "BORDER")
  r.div:SetPoint("TOPLEFT", r.media, "BOTTOMLEFT", 6, -8)
  r.div:SetPoint("TOPRIGHT", r.media, "BOTTOMRIGHT", -6, -8)
  r.div:SetHeight(1)

  r.textArea = CreateFrame("Frame", nil, r)
  r.textArea:SetPoint("TOPLEFT", r.media, "BOTTOMLEFT", 8, -8)
  r.textArea:SetPoint("TOPRIGHT", r.media, "BOTTOMRIGHT", -8, -8)
  r.textArea:SetHeight(50)
  r.textArea:SetClipsChildren(true)

  r.label = r.textArea:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
  r.label:SetPoint("TOPLEFT", 0, 0)
  r.label:SetPoint("TOPRIGHT", 0, 0)
  r.label:SetJustifyH("LEFT")
  r.label:SetWordWrap(true)
  r.label:SetMaxLines(2)

  r.note = r.textArea:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  r.note:SetJustifyH("LEFT")
  r.note:SetWordWrap(true)
  r.note:SetMaxLines(2)
  r.note:Hide()

  r.titleDiv = r.textArea:CreateTexture(nil, "BORDER")
  r.titleDiv:Hide()

  r.meta = r.textArea:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  r.meta:SetJustifyH("LEFT")
  r.meta:SetWordWrap(false)
  r.meta:SetMaxLines(1)
  r.meta:Hide()

  r.timer = r.textArea:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  r.timer:SetJustifyH("RIGHT")
  r.timer:SetWordWrap(false)
  r.timer:SetMaxLines(1)
  r.timer:Hide()

  r.textBg = r:CreateTexture(nil, "BACKGROUND")
  r.textBg:Hide()

  r.headDiv = r:CreateTexture(nil, "BORDER")
  r.headDiv:Hide()

  r.secReq = CreateFrame("Frame", nil, r, "BackdropTemplate")
  r.secReq:SetHeight(22)
  r.secReq:SetClipsChildren(true)
  r.secReq:Hide()

  r.secReq.bg = r.secReq:CreateTexture(nil, "BACKGROUND")
  r.secReq.bg:SetAllPoints()
  r.secReq.bg:SetColorTexture(0.08, 0.09, 0.11, 0.6)

  r.secReq.text = r.secReq:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  r.secReq.text:SetPoint("LEFT", 12, 0)
  r.secReq.text:SetJustifyH("LEFT")
  r.secReq.text:SetText("Quests / Achs")
  r.secReq.text:SetTextColor(0.9, 0.9, 0.9, 1)
  r.reqRow = CreateFrame("Frame", nil, r, "BackdropTemplate")
  r.reqRow:SetHeight(32)
  r.reqRow:SetClipsChildren(true)
  r.reqRow:Hide()

  r.reqRow.bg = r.reqRow:CreateTexture(nil, "BACKGROUND")
  r.reqRow.bg:SetAllPoints()
  r.reqRow.bg:SetColorTexture(0.05, 0.06, 0.08, 0.4)

  r.req = r.reqRow:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  r.req:SetPoint("TOPLEFT", 10, -6)
  r.req:SetPoint("TOPRIGHT", -10, -6)
  r.req:SetJustifyH("LEFT")
  r.req:SetWordWrap(true)
  r.req:SetMaxLines(2)

  r.reqBtn = CreateFrame("Button", nil, r)
  r.reqBtn:Hide()
  r.reqBtn:EnableMouse(true)
  r.reqBtn:RegisterForClicks("AnyUp")

  r.secRep = CreateFrame("Frame", nil, r, "BackdropTemplate")
  r.secRep:SetHeight(22)
  r.secRep:SetClipsChildren(true)
  r.secRep:Hide()

  r.secRep.bg = r.secRep:CreateTexture(nil, "BACKGROUND")
  r.secRep.bg:SetAllPoints()
  r.secRep.bg:SetColorTexture(0.08, 0.09, 0.11, 0.6)

  r.secRep.text = r.secRep:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  r.secRep.text:SetPoint("LEFT", 12, 0)
  r.secRep.text:SetJustifyH("LEFT")
  r.secRep.text:SetText("Reputation")
  r.secRep.text:SetTextColor(0.9, 0.9, 0.9, 1)
  r.repRow = CreateFrame("Frame", nil, r, "BackdropTemplate")
  r.repRow:SetHeight(32)
  r.repRow:SetClipsChildren(true)
  r.repRow:Hide()

  r.repRow.bg = r.repRow:CreateTexture(nil, "BACKGROUND")
  r.repRow.bg:SetAllPoints()
  r.repRow.bg:SetColorTexture(0.05, 0.06, 0.08, 0.4)

  r.rep = r.repRow:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  r.rep:SetPoint("TOPLEFT", 10, -6)
  r.rep:SetPoint("TOPRIGHT", -10, -6)
  r.rep:SetJustifyH("LEFT")
  r.rep:SetWordWrap(true)
  r.rep:SetMaxLines(2)

  r.secCur = CreateFrame("Frame", nil, r, "BackdropTemplate")
  r.secCur:SetHeight(22)
  r.secCur:SetClipsChildren(true)
  r.secCur:Hide()

  r.secCur.bg = r.secCur:CreateTexture(nil, "BACKGROUND")
  r.secCur.bg:SetAllPoints()
  r.secCur.bg:SetColorTexture(0.08, 0.09, 0.11, 0.6)

  r.secCur.text = r.secCur:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  r.secCur.text:SetPoint("LEFT", 12, 0)
  r.secCur.text:SetJustifyH("LEFT")
  r.secCur.text:SetText("Currency")
  r.secCur.text:SetTextColor(0.9, 0.9, 0.9, 1)

  r.curRow = CreateFrame("Frame", nil, r, "BackdropTemplate")
  r.curRow:SetHeight(30)
  r.curRow:SetClipsChildren(true)
  r.curRow:Hide()

  r.curRow.bg = r.curRow:CreateTexture(nil, "BACKGROUND")
  r.curRow.bg:SetAllPoints()
  r.curRow.bg:SetColorTexture(0.05, 0.06, 0.08, 0.4)

  r.curLeftIcon = r.curRow:CreateTexture(nil, "ARTWORK")
  r.curLeftIcon:SetSize(16, 16)
  r.curLeftIcon:SetPoint("LEFT", 10, 0)
  r.curLeftIcon:SetTexture("Interface\\MoneyFrame\\UI-GoldIcon")

  r.curLeftText = r.curRow:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
  r.curLeftText:SetPoint("LEFT", r.curLeftIcon, "RIGHT", 4, 0)
  r.curLeftText:SetJustifyH("LEFT")
  r.curLeftText:SetTextColor(1, 0.82, 0, 1)

  r.curRightIcon = r.curRow:CreateTexture(nil, "ARTWORK")
  r.curRightIcon:SetSize(16, 16)
  r.curRightIcon:SetPoint("RIGHT", -10, 0)
  r.curRightIcon:SetTexture("Interface\\MoneyFrame\\UI-GoldIcon")

  r.curRightText = r.curRow:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  r.curRightText:SetPoint("RIGHT", r.curRightIcon, "LEFT", -4, 0)
  r.curRightText:SetJustifyH("RIGHT")
  r.curRightText:SetTextColor(1, 0.82, 0, 1)

  r.currency = r.curLeftText

  local S = RS()
  if S then S:SkinTile(r, 0.16) end

  return r
end

return Frames