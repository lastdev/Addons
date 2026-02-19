local ADDON, NS = ...

NS.UI = NS.UI or {}

local MapPopup = NS.UI.MapPopup or {}
NS.UI.MapPopup = MapPopup

local Rows = NS.UI.MapPopupRows or {}
NS.UI.MapPopupRows = Rows
MapPopup.Rows = Rows

local CreateFrame = _G.CreateFrame

local Controls = NS.UI.Controls
local RowStyles = NS.UI.RowStyles

local rowPool = {}
local activeRows = {}

local function GetTheme()
  return NS.UI and NS.UI.Theme and NS.UI.Theme.colors or {}
end

function Rows.CreateSectionHeader(parent)
  local theme = GetTheme()
  
  local row = CreateFrame("Frame", nil, parent)
  row:SetHeight(26)
  row.kind = "section"

  row.label = row:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
  row.label:SetPoint("LEFT", 8, 0)
  row.label:SetJustifyH("LEFT")
  row.label:SetTextColor(1, 0.82, 0)
  
  row.line = row:CreateTexture(nil, "BACKGROUND")
  row.line:SetHeight(1)
  row.line:SetPoint("BOTTOMLEFT", 0, 2)
  row.line:SetPoint("BOTTOMRIGHT", 0, 2)
  row.line:SetColorTexture(0.3, 0.3, 0.3, 0.5)

  if RowStyles and RowStyles.ApplyFonts then
    RowStyles:ApplyFonts(row)
  end

  return row
end

function Rows.CreateSubsectionHeader(parent)
  local theme = GetTheme()
  
  local row = CreateFrame("Frame", nil, parent)
  row:SetHeight(22)
  row.kind = "subsection"

  row.label = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  row.label:SetPoint("LEFT", 12, 0)
  row.label:SetJustifyH("LEFT")
  row.label:SetTextColor(0.9, 0.9, 0.9)

  if RowStyles and RowStyles.ApplyFonts then
    RowStyles:ApplyFonts(row)
  end

  return row
end

function Rows.CreateVendorHeader(parent)
  local theme = GetTheme()
  
  local row = CreateFrame("Button", nil, parent, "BackdropTemplate")
  row:SetHeight(34)
  row.kind = "vendor"
  row:EnableMouse(true)
  row:RegisterForClicks("AnyUp")

  if RowStyles and RowStyles.SkinHeader then
    RowStyles:SkinHeader(row, 0.18)
  elseif Controls and Controls.Backdrop then
    Controls:Backdrop(row, theme.header, theme.border)
  end

  row.arrow = row:CreateTexture(nil, "OVERLAY")
  row.arrow:SetSize(14, 14)
  row.arrow:SetPoint("LEFT", 8, 0)
  row.arrow:SetTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
  row.arrow:SetRotation(-1.5708)

  row.label = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  row.label:SetPoint("LEFT", row.arrow, "RIGHT", 8, 0)
  row.label:SetJustifyH("LEFT")

  row.count = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  row.count:SetPoint("RIGHT", -12, 0)
  row.count:SetJustifyH("RIGHT")

  if RowStyles and RowStyles.ApplyFonts then
    RowStyles:ApplyFonts(row)
  end

  return row
end

function Rows.CreateItemRow(parent)
  local theme = GetTheme()

  local row = CreateFrame("Button", nil, parent, "BackdropTemplate")
  row:SetHeight(54)
  row.kind = "item"
  row:EnableMouse(true)
  row:RegisterForClicks("AnyUp")
  row:SetClipsChildren(true)

  if RowStyles and RowStyles.SkinTrackerItem then
    RowStyles:SkinTrackerItem(row, 0.16)
  elseif RowStyles and RowStyles.SkinListRow then
    RowStyles:SkinListRow(row, 0.14)
  elseif Controls and Controls.Backdrop then
    Controls:Backdrop(row, theme.row, theme.border)
  end

  row.media = CreateFrame("Frame", nil, row)
  row.media:SetPoint("LEFT", 10, 0)
  row.media:SetSize(40, 40)

  row.mediaBg = row.media:CreateTexture(nil, "BACKGROUND")
  row.mediaBg:SetAllPoints()

  row.icon = row.media:CreateTexture(nil, "ARTWORK")
  row.icon:SetPoint("CENTER", 0, 0)
  row.icon:SetSize(34, 34)
  row.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

  local CHECK_ATLAS = "common-icon-checkmark"
  local CHECK_FALLBACK = "Interface\\RaidFrame\\ReadyCheck-Ready"
  
  row.check = row.media:CreateTexture(nil, "OVERLAY", nil, 7)
  row.check:SetSize(13, 13)
  row.check:SetPoint("BOTTOMLEFT", row.media, "BOTTOMLEFT", 1, 1)
  if row.check.SetAtlas then
    row.check:SetAtlas(CHECK_ATLAS, true)
  else
    row.check:SetTexture(CHECK_FALLBACK)
  end
  row.check:SetVertexColor(0.75, 0.95, 0.75, 0.95)
  row.check:Hide()

  row.faction = row.media:CreateTexture(nil, "OVERLAY")
  row.faction:SetPoint("BOTTOMRIGHT", 2, -2)
  row.faction:SetSize(14, 14)
  row.faction:SetAlpha(1)
  row.faction:Hide()

  row.texAlliance = "Interface\\FriendsFrame\\PlusManz-Alliance"
  row.texHorde = "Interface\\FriendsFrame\\PlusManz-Horde"

  row.title = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  row.title:SetPoint("TOPLEFT", row.media, "TOPRIGHT", 10, -10)
  row.title:SetPoint("RIGHT", row, "RIGHT", -12, 0)
  row.title:SetJustifyH("LEFT")
  row.title:SetWordWrap(false)
  row.title:SetMaxLines(1)

  row.reqAQ = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  row.reqAQ:SetPoint("TOPLEFT", row.title, "BOTTOMLEFT", 0, -2)
  row.reqAQ:SetPoint("RIGHT", row, "RIGHT", -12, 0)
  row.reqAQ:SetJustifyH("LEFT")
  row.reqAQ:SetWordWrap(false)
  row.reqAQ:Hide()

  row.reqRep = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  row.reqRep:SetPoint("TOPLEFT", row.reqAQ, "BOTTOMLEFT", 0, -1)
  row.reqRep:SetPoint("RIGHT", row, "RIGHT", -12, 0)
  row.reqRep:SetJustifyH("LEFT")
  row.reqRep:SetWordWrap(false)
  row.reqRep:Hide()

  row.reqBtn = CreateFrame("Button", nil, row)
  row.reqBtn:Hide()

  if RowStyles and RowStyles.ApplyFonts then
    RowStyles:ApplyFonts(row)
  end

  return row
end

function Rows.GetOrCreate(kind, parent)
  if #rowPool > 0 then
    local row = rowPool[#rowPool]
    rowPool[#rowPool] = nil
    if row.kind == kind then
      return row
    end
    rowPool[#rowPool + 1] = row
  end

  if kind == "section" then
    return Rows.CreateSectionHeader(parent)
  elseif kind == "subsection" then
    return Rows.CreateSubsectionHeader(parent)
  elseif kind == "vendor" then
    return Rows.CreateVendorHeader(parent)
  else
    return Rows.CreateItemRow(parent)
  end
end

function Rows.Release(row)
  if not row then return end
  
  row:Hide()
  row:ClearAllPoints()
  row.vendorID = nil
  row.itemData = nil
  row.fullItem = nil
  row.interactionData = nil
  row.interactionContext = nil
  rowPool[#rowPool + 1] = row
  activeRows[row] = nil
end

function Rows.GetActive()
  return activeRows
end

function Rows.SetActive(row)
  activeRows[row] = true
end

return Rows
