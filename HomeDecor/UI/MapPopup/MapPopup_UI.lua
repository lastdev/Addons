local ADDON, NS = ...

NS.UI = NS.UI or {}

local MapPopup = NS.UI.MapPopup or {}
NS.UI.MapPopup = MapPopup

local UI = NS.UI.MapPopupUI or {}
NS.UI.MapPopupUI = UI
MapPopup.UI = UI

local CreateFrame = _G.CreateFrame
local C_Timer = _G.C_Timer

local Controls = NS.UI.Controls
local RowStyles = NS.UI.RowStyles
local TrackerRows = NS.UI.TrackerRows
local Util = NS.UI.MapPopupUtil

local function GetTheme()
  return NS.UI and NS.UI.Theme and NS.UI.Theme.colors or {}
end

local function GetMapPopupDB()
  local addon = NS.Addon
  local profile = addon and addon.db and addon.db.profile
  if not profile then return nil end

  local mapPopup = profile.mapPopup
  if type(mapPopup) ~= "table" then
    mapPopup = {}
    profile.mapPopup = mapPopup
  end

  return mapPopup
end

local function ApplyRegionAlpha(root, alpha)
  if not root or not root.GetRegions then return end
  if not Util or not Util.Clamp then return end
  
  alpha = Util.Clamp(tonumber(alpha) or 1, 0, 1)

  local regions = { root:GetRegions() }
  for index = 1, #regions do
    local region = regions[index]
    if region and region.GetObjectType and region:GetObjectType() == "Texture" and region.GetDrawLayer then
      local layer = region:GetDrawLayer()
      if (layer == "BACKGROUND" or layer == "BORDER") and region.SetAlpha then
        local name = region.GetName and region:GetName() or nil
        if not name or (not name:find("Icon") and not name:find("icon")) then
          region:SetAlpha(alpha)
        end
      end
    end
  end
end

local function NextGlobalName(prefix)
  local ui = NS.UI
  ui.uid = (ui.uid or 0) + 1
  local counter = ui.uid
  local name = prefix .. tostring(counter)
  while _G[name] do
    counter = counter + 1
    ui.uid = counter
    name = prefix .. tostring(counter)
  end
  return name
end

function UI:CreateFrame()
  local theme = GetTheme()

  local frame = CreateFrame("Frame", "HomeDecorMapPopup", _G.UIParent, "BackdropTemplate")
  
  local database = GetMapPopupDB()
  local width, height = (database and database.width) or 340, (database and database.height) or 520
  frame:SetSize(width, height)
  
  frame:SetPoint("RIGHT", _G.UIParent, "RIGHT", -20, 0)
  frame:SetFrameStrata("DIALOG")
  frame:SetFrameLevel(220)
  frame:SetToplevel(true)
  frame:SetClampedToScreen(true)
  frame:SetMovable(true)
  frame:SetResizable(true)
  frame:EnableMouse(true)
  frame:Hide()

  frame.openVendors = {}
  frame.minWidth, frame.maxWidth = 280, 500
  frame.minHeight, frame.maxHeight = 220, 720
  frame.bgAlpha = 1
  frame.collapsed = false
  frame.lastSize = { width = width, height = height }

  if Controls and Controls.Backdrop then
    Controls:Backdrop(frame, theme.panel, theme.border)
    if Controls.ApplyBackground and NS.UI and NS.UI.Theme and NS.UI.Theme.textures then
      Controls:ApplyBackground(frame, NS.UI.Theme.textures.PanelBG or NS.UI.Theme.textures.MainBackground, 6, 1)
    end
  end

  self:CreateHeader(frame)
  self:CreateSettings(frame)
  self:CreateContent(frame)
  self:CreateResizeGrip(frame)
  self:SetupCollapse(frame)
  self:SetupAlpha(frame)

  return frame
end

function UI:CreateHeader(frame)
  local theme = GetTheme()
  local database = GetMapPopupDB()

  local header = CreateFrame("Frame", nil, frame, "BackdropTemplate")
  header:SetPoint("TOPLEFT", 6, -6)
  header:SetPoint("TOPRIGHT", -6, -6)
  header:SetHeight(32)
  header:EnableMouse(true)
  header:RegisterForDrag("LeftButton")

  if Controls and Controls.Backdrop then
    Controls:Backdrop(header, theme.header, theme.border)
    if Controls.ApplyHeaderTexture then
      Controls:ApplyHeaderTexture(header, false)
    end
  end

  header:SetScript("OnDragStart", function() frame:StartMoving() end)
  header:SetScript("OnDragStop", function() 
    frame:StopMovingOrSizing()
    local db = GetMapPopupDB()
    if db then
      local point, _, relPoint, posX, posY = frame:GetPoint(1)
      if point then
        db.point = point
        db.relPoint = relPoint or point
        db.x = tonumber(posX) or 0
        db.y = tonumber(posY) or 0
      end
    end
  end)

  header.collapse = TrackerRows and TrackerRows.MakeSmallIconButton and TrackerRows:MakeSmallIconButton(header, "Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
  if header.collapse then
    header.collapse:SetPoint("LEFT", header, "LEFT", 10, 0)
    if header.collapse.icon and header.collapse.icon.SetRotation then
      header.collapse.icon:SetRotation(-1.5708)
    end
  end

  header.title = header:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
  header.title:SetPoint("CENTER", header, "CENTER", 0, 0)
  header.title:SetText("Vendors")
  header.title:SetTextColor(theme.accent[1] or 1, theme.accent[2] or 0.82, theme.accent[3] or 0)

  if RowStyles and RowStyles.StrongText then
    RowStyles:StrongText(header.title)
  end

  header.closeBtn = CreateFrame("Button", nil, header, "BackdropTemplate")
  header.closeBtn:SetSize(26, 26)
  header.closeBtn:SetPoint("RIGHT", header, "RIGHT", -10, 0)

  if Controls and Controls.Backdrop then
    Controls:Backdrop(header.closeBtn, theme.panel, theme.border)
    if Controls.ApplyHover then
      Controls:ApplyHover(header.closeBtn, theme.panel, theme.hover)
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

  header.settings = TrackerRows and TrackerRows.MakeSmallIconButton and TrackerRows:MakeSmallIconButton(header, "Interface\\Buttons\\UI-OptionsButton")
  if header.settings then
    header.settings:SetPoint("RIGHT", header.closeBtn, "LEFT", -6, 0)
  end

  frame.header = header
end

function UI:CreateSettings(frame)
  local theme = GetTheme()

  local settings = CreateFrame("Frame", nil, frame, "BackdropTemplate")
  settings:SetSize(220, 76)
  settings:SetFrameStrata("TOOLTIP")
  settings:Hide()

  if Controls and Controls.Backdrop then
    Controls:Backdrop(settings, theme.panel, theme.border)
  end

  settings.label = settings:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
  settings.label:SetPoint("TOPLEFT", 16, -16)
  settings.label:SetText("Panel Transparency")

  settings.alphaValue = settings:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
  settings.alphaValue:SetPoint("TOPRIGHT", -16, -38)
  settings.alphaValue:SetJustifyH("RIGHT")

  local sliderName = NextGlobalName("HomeDecorMapPopupAlphaSlider")
  settings.slider = CreateFrame("Slider", sliderName, settings, "OptionsSliderTemplate")
  settings.slider:SetPoint("LEFT", 16, -10)
  settings.slider:SetPoint("RIGHT", -16, -10)
  settings.slider:SetPoint("BOTTOM", 0, 14)
  settings.slider:SetHeight(18)
  settings.slider:SetMinMaxValues(0.00, 1.00)
  settings.slider:SetValueStep(0.01)
  settings.slider:SetObeyStepOnDrag(true)

  do
    local sliderFrameName = settings.slider:GetName()
    if sliderFrameName then
      local low = _G[sliderFrameName .. "Low"]
      if low then low:SetText("") end
      local high = _G[sliderFrameName .. "High"]
      if high then high:SetText("") end
      local text = _G[sliderFrameName .. "Text"]
      if text then text:SetText("") end
    end
  end

  local function ToggleSettings()
    if settings:IsShown() then
      settings:Hide()
      return
    end
    settings:ClearAllPoints()
    settings:SetPoint("TOP", frame.header, "BOTTOM", 0, -6)
    settings:Show()
    settings:Raise()
  end

  if frame.header.settings then
    frame.header.settings:SetScript("OnClick", ToggleSettings)
  end

  settings:SetScript("OnShow", function()
    if not settings.blocker then
      local blocker = CreateFrame("Button", nil, _G.UIParent)
      settings.blocker = blocker
      blocker:SetAllPoints(_G.UIParent)
      blocker:SetFrameStrata("DIALOG")
      blocker:SetFrameLevel(settings:GetFrameLevel() - 1)
      blocker:EnableMouse(true)
      blocker:SetScript("OnClick", function() settings:Hide() end)
    end
    settings.blocker:Show()
    settings.blocker:Raise()
    settings:Raise()
  end)

  settings:SetScript("OnHide", function()
    local blocker = settings.blocker
    if blocker then blocker:Hide() end
  end)

  frame.settings = settings
end

function UI:CreateContent(frame)
  local scroll = CreateFrame("ScrollFrame", nil, frame, "ScrollFrameTemplate")
  if Controls and Controls.SkinScrollFrame then
    Controls:SkinScrollFrame(scroll)
  end
  scroll:SetPoint("TOPLEFT", frame.header, "BOTTOMLEFT", 6, -6)
  scroll:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -24, 12)

  local content = CreateFrame("Frame", nil, scroll)
  content:SetSize(scroll:GetWidth() - 8, 500)
  scroll:SetScrollChild(content)

  local noItems = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  noItems:SetPoint("CENTER", scroll, "CENTER")
  noItems:SetTextColor(0.6, 0.6, 0.6)
  noItems:Hide()

  frame.scroll = scroll
  frame.content = content
  frame.noItems = noItems
end

function UI:CreateResizeGrip(frame)
  local resizeGrip = CreateFrame("Button", nil, frame)
  resizeGrip:SetSize(18, 18)
  resizeGrip:SetPoint("BOTTOMRIGHT", -2, 2)
  resizeGrip:EnableMouse(true)

  resizeGrip.tex = resizeGrip:CreateTexture(nil, "OVERLAY")
  resizeGrip.tex:SetAllPoints()
  resizeGrip.tex:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")

  local function SyncContentWidth()
    local scrollWidth = frame.scroll:GetWidth()
    if scrollWidth and scrollWidth > 1 then
      frame.content:SetWidth(scrollWidth)
    end
  end

  local function ClampFrameSize()
    if frame.sizingClamp then return end
    frame.sizingClamp = true

    local currentWidth, currentHeight = frame:GetSize()
    if currentWidth and currentHeight and Util and Util.Clamp then
      local clampedWidth = Util.Clamp(currentWidth, frame.minWidth, frame.maxWidth)
      local clampedHeight = Util.Clamp(currentHeight, frame.minHeight, frame.maxHeight)
      if clampedWidth ~= currentWidth or clampedHeight ~= currentHeight then
        frame:SetSize(clampedWidth, clampedHeight)
      end
    end

    frame.sizingClamp = false
  end

  frame.lastSizeWidth, frame.lastSizeHeight = frame:GetSize()
  frame:HookScript("OnSizeChanged", function(self, newWidth, newHeight)
    if frame.collapsed then return end
    if newWidth == frame.lastSizeWidth and newHeight == frame.lastSizeHeight then return end
    frame.lastSizeWidth, frame.lastSizeHeight = newWidth, newHeight

    local database = GetMapPopupDB()
    if database then
      database.width = tonumber(newWidth) or database.width
      database.height = tonumber(newHeight) or database.height
    end

    ClampFrameSize()
    SyncContentWidth()
  end)

  resizeGrip:SetScript("OnMouseDown", function(self, button)
    if button ~= "LeftButton" then return end
    frame.isSizing = true
    frame:StartSizing("BOTTOMRIGHT")
  end)

  resizeGrip:SetScript("OnMouseUp", function()
    frame:StopMovingOrSizing()
    frame.isSizing = false

    ClampFrameSize()
    SyncContentWidth()

    C_Timer.After(0, function()
      if not frame or not frame:IsShown() or frame.collapsed then return end
      SyncContentWidth()
    end)
  end)

  frame.resizeGrip = resizeGrip
end

function UI:SetupCollapse(frame)
  local function SetCollapsed(collapsed)
    collapsed = collapsed and true or false
    if collapsed == frame.collapsed then return end
    frame.collapsed = collapsed

    local database = GetMapPopupDB()
    if database then database.collapsed = collapsed end

    if collapsed then
      frame.settings:Hide()

      local currentWidth, currentHeight = frame:GetSize()
      frame.lastSizeWidth, frame.lastSizeHeight = currentWidth, currentHeight
      frame.lastSize.width, frame.lastSize.height = currentWidth, currentHeight

      frame.scroll:Hide()
      frame.resizeGrip:Hide()

      frame:SetHeight(48)
      if frame.header.collapse and frame.header.collapse.icon and frame.header.collapse.icon.SetRotation then
        frame.header.collapse.icon:SetRotation(0)
      end
      return
    end

    frame.scroll:Show()
    frame.resizeGrip:Show()

    local restoreWidth = frame.lastSizeWidth or (database and tonumber(database.width)) or 340
    local restoreHeight = frame.lastSizeHeight or (database and tonumber(database.height)) or 520
    frame:SetSize(restoreWidth, restoreHeight)

    if frame.header.collapse and frame.header.collapse.icon and frame.header.collapse.icon.SetRotation then
      frame.header.collapse.icon:SetRotation(-1.5708)
    end

    if frame.content then
      local scrollWidth = frame.scroll:GetWidth()
      if scrollWidth and scrollWidth > 1 then
        frame.content:SetWidth(scrollWidth)
      end
    end
  end

  if frame.header.collapse then
    frame.header.collapse:SetScript("OnClick", function()
      SetCollapsed(not frame.collapsed)
    end)
  end

  local database = GetMapPopupDB()
  if database and database.collapsed then
    SetCollapsed(true)
  end
end

function UI:SetupAlpha(frame)
  local function ApplyPanelsAlpha(alpha, pulse)
    if not Util or not Util.Clamp then return end
    frame.bgAlpha = Util.Clamp(tonumber(alpha) or 1, 0, 1)
    local iconAlpha = Util.Clamp(0.2 + (frame.bgAlpha * 0.8), 0, 1)

    if TrackerRows and TrackerRows.SetPanelAlpha then
      TrackerRows:SetPanelAlpha(frame, frame.bgAlpha)
      TrackerRows:SetPanelAlpha(frame.header, frame.bgAlpha)
      TrackerRows:SetPanelAlpha(frame.settings, frame.bgAlpha)
    end

    ApplyRegionAlpha(frame, frame.bgAlpha)
    ApplyRegionAlpha(frame.header, frame.bgAlpha)
    ApplyRegionAlpha(frame.settings, frame.bgAlpha)

    if frame.header.collapse then frame.header.collapse:SetAlpha(iconAlpha) end
    if frame.header.settings then frame.header.settings:SetAlpha(iconAlpha) end

    if frame.header.closeBtn then
      frame.header.closeBtn:SetAlpha(iconAlpha)
      if frame.header.closeBtn.icon then
        frame.header.closeBtn.icon:SetAlpha(iconAlpha)
      end
    end

    frame.settings.alphaValue:SetText(string.format("%d%%", frame.bgAlpha * 100))
  end

  frame.ApplyPanelsAlpha = ApplyPanelsAlpha

  frame.settings.slider:SetScript("OnValueChanged", function(self, value)
    ApplyPanelsAlpha(value, not frame.initing)
    local database = GetMapPopupDB()
    if database and Util and Util.Clamp then 
      database.alpha = Util.Clamp(value, 0, 1) 
    end
  end)

  local database = GetMapPopupDB()
  if database and Util and Util.Clamp then
    local alpha = Util.Clamp(tonumber(database.alpha) or frame.bgAlpha or 1, 0, 1)
    frame.ApplyPanelsAlpha(alpha, false)

    frame.initing = true
    frame.settings.slider:SetValue(alpha)
    frame.initing = nil
  end

  local NPCNames = NS.Systems and NS.Systems.NPCNames
  if NPCNames and NPCNames.RegisterListener then
    NPCNames.RegisterListener(function(npcID, name)
      if not frame:IsShown() then return end
      if frame.isRefreshing then return end
      
      local Rows = NS.UI.MapPopupRows
      if not Rows then return end
      
      local activeRows = Rows.GetActive()
      for row in pairs(activeRows) do
        if row.kind == "vendor" and row.npcID == npcID and name then
          row.label:SetText(name)
          
          local popup = NS.UI.MapPopup
          if popup and #(popup.currentVendors or {}) == 1 then
            frame.header.title:SetText(name)
          end
        end
      end
    end)
  end
end

return UI
