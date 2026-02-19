local ADDON, NS = ...

NS.UI = NS.UI or {}
NS.UI.Options = NS.UI.Options or {}
local Options = NS.UI.Options

local CreateFrame = _G.CreateFrame
local InterfaceOptionsFrame_OpenToCategory = _G.InterfaceOptionsFrame_OpenToCategory
local Settings = _G.Settings

local function bool(v)
  return v and true or false
end

local function ensureProfile()
  local db = NS.db
  local prof = db and db.profile
  if not prof then return nil end
  prof.mapPins = prof.mapPins or {}
  if prof.mapPins.minimap == nil then prof.mapPins.minimap = true end
  if prof.mapPins.worldmap == nil then prof.mapPins.worldmap = true end
  if prof.mapPins.pinStyle == nil then prof.mapPins.pinStyle = "house" end
  if prof.mapPins.pinSize == nil then prof.mapPins.pinSize = 1.0 end
  if prof.mapPins.pinColor == nil or type(prof.mapPins.pinColor) ~= "table" then
    prof.mapPins.pinColor = { r = 1.0, g = 1.0, b = 1.0 }
  else
    prof.mapPins.pinColor.r = prof.mapPins.pinColor.r or 1.0
    prof.mapPins.pinColor.g = prof.mapPins.pinColor.g or 1.0
    prof.mapPins.pinColor.b = prof.mapPins.pinColor.b or 1.0
  end
  prof.minimap = prof.minimap or { hide = false }
  prof.vendor = prof.vendor or {}
  if prof.vendor.showCollectedCheckmark == nil then prof.vendor.showCollectedCheckmark = true end
  if prof.vendor.showOwnedCount == nil then prof.vendor.showOwnedCount = false end
  if prof.vendor.showVendorNPCTooltip == nil then prof.vendor.showVendorNPCTooltip = false end
  return prof
end

local function refreshPins()
  local MP = NS.Systems and NS.Systems.MapPins
  if not MP then return end
  if MP.RefreshCurrentZone then pcall(function() MP:RefreshCurrentZone() end) end
  if MP.RefreshWorldMap then pcall(function() MP:RefreshWorldMap() end) end
end

local function openCategoryFrame(panel)
  if Settings and Settings.OpenToCategory and panel then
    local cat = panel.category
    local id

    if type(cat) == "table" then
      id = cat.ID
      if not id and type(cat.GetID) == "function" then
        local ok, v = pcall(cat.GetID, cat)
        if ok then id = v end
      end
    elseif type(cat) == "number" then
      id = cat
    end

    if id then
      Settings.OpenToCategory(id)
      return
    end

    if panel.name then
      pcall(function() Settings.OpenToCategory(panel.name) end)
      return
    end
  end

  if InterfaceOptionsFrame_OpenToCategory and panel then
    InterfaceOptionsFrame_OpenToCategory(panel)
    InterfaceOptionsFrame_OpenToCategory(panel)
  end
end

local function mkCheckbox(parent, label, sub)
  local b = CreateFrame("CheckButton", nil, parent, "InterfaceOptionsCheckButtonTemplate")
  b.Text:SetText(label)
  if sub and sub ~= "" then
    b.tooltipText = label
    b.tooltipRequirement = sub
  end
  return b
end

local function mkDropdown(parent, width)
  local dropdown = CreateFrame("Frame", nil, parent, "UIDropDownMenuTemplate")
  _G.UIDropDownMenu_SetWidth(dropdown, width or 120)
  return dropdown
end

local function mkColorPicker(parent, label)
  local button = CreateFrame("Button", nil, parent)
  button:SetSize(20, 20)

  button.bg = button:CreateTexture(nil, "BACKGROUND")
  button.bg:SetAllPoints()
  button.bg:SetColorTexture(0, 0, 0, 0.5)

  button.color = button:CreateTexture(nil, "ARTWORK")
  button.color:SetPoint("TOPLEFT", 2, -2)
  button.color:SetPoint("BOTTOMRIGHT", -2, 2)
  button.color:SetColorTexture(1, 1, 1)

  button.label = button:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
  button.label:SetPoint("LEFT", button, "RIGHT", 5, 0)
  button.label:SetText(label)

  button:SetScript("OnClick", function(self)
    if not _G.ColorPickerFrame then return end
    local prof = ensureProfile()
    if not prof then return end

    local info = {}
    info.r = prof.mapPins.pinColor.r
    info.g = prof.mapPins.pinColor.g
    info.b = prof.mapPins.pinColor.b
    info.hasOpacity = false
    info.swatchFunc = function()
      local r, g, b = _G.ColorPickerFrame:GetColorRGB()
      prof.mapPins.pinColor.r = r
      prof.mapPins.pinColor.g = g
      prof.mapPins.pinColor.b = b
      self.color:SetColorTexture(r, g, b)
      refreshPins()
    end
    info.cancelFunc = function(restore)
      prof.mapPins.pinColor.r = restore.r
      prof.mapPins.pinColor.g = restore.g
      prof.mapPins.pinColor.b = restore.b
      self.color:SetColorTexture(restore.r, restore.g, restore.b)
      refreshPins()
    end

    _G.ColorPickerFrame:SetupColorPickerAndShow(info)
  end)

  return button
end

local function mkSlider(parent, label, minVal, maxVal, step)
  local slider = CreateFrame("Slider", nil, parent, "OptionsSliderTemplate")
  slider:SetMinMaxValues(minVal, maxVal)
  slider:SetValueStep(step)
  slider:SetObeyStepOnDrag(true)

  slider.label = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
  slider.label:SetPoint("BOTTOMLEFT", slider, "TOPLEFT", 0, 2)
  slider.label:SetText(label)

  slider.valueText = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
  slider.valueText:SetPoint("BOTTOMRIGHT", slider, "TOPRIGHT", 0, 2)

  slider.Low:SetText(string.format("%.1f", minVal))
  slider.High:SetText(string.format("%.1f", maxVal))

  return slider
end

function Options:Ensure()
  if self.panel then return end

  local panel = CreateFrame("Frame")
  panel.name = "HomeDecor"

  local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
  title:SetPoint("TOPLEFT", 16, -16)
  title:SetText("HomeDecor")

  local sub = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
  sub:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -6)
  sub:SetText("Quality-of-life settings for the addon.")

  local y = -60

  local cbMinimapButton = mkCheckbox(panel, "Show minimap button")
  cbMinimapButton:SetPoint("TOPLEFT", 16, y)
  y = y - 34

  local minimapHeader = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
  minimapHeader:SetPoint("TOPLEFT", 16, y)
  minimapHeader:SetText("Minimap")
  y = y - 24

  local cbMiniPins = mkCheckbox(panel, "Show vendor pins on the minimap")
  cbMiniPins:SetPoint("TOPLEFT", 32, y)
  y = y - 34

  local worldmapHeader = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
  worldmapHeader:SetPoint("TOPLEFT", 16, y)
  worldmapHeader:SetText("World Map")
  y = y - 24

  local cbWorldPins = mkCheckbox(panel, "Show vendor pins on the world map")
  cbWorldPins:SetPoint("TOPLEFT", 32, y)
  y = y - 34

  local filterHeader = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
  filterHeader:SetPoint("TOPLEFT", 16, y)
  filterHeader:SetText("Filters")
  y = y - 24

  local cbHideCollected = mkCheckbox(panel, "Hide already collected items",
    "Hides items you have already collected from the browser and list views")
  cbHideCollected:SetPoint("TOPLEFT", 32, y)
  y = y - 34

  local appearanceHeader = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
  appearanceHeader:SetPoint("TOPLEFT", 16, y)
  appearanceHeader:SetText("Pin Appearance")
  y = y - 24

  local styleLabel = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
  styleLabel:SetPoint("TOPLEFT", 32, y)
  styleLabel:SetText("Pin Style:")

  local ddPinStyle = mkDropdown(panel, 120)
  ddPinStyle:SetPoint("LEFT", styleLabel, "RIGHT", 0, -3)

  _G.UIDropDownMenu_Initialize(ddPinStyle, function(self)
    local prof = ensureProfile()
    if not prof then return end

    local info = _G.UIDropDownMenu_CreateInfo()

    info.text = "House Icon"
    info.value = "house"
    info.checked = (prof.mapPins.pinStyle == "house")
    info.func = function()
      prof.mapPins.pinStyle = "house"
      _G.UIDropDownMenu_SetText(ddPinStyle, "House Icon")
      refreshPins()
    end
    _G.UIDropDownMenu_AddButton(info)

    info.text = "Dot"
    info.value = "dot"
    info.checked = (prof.mapPins.pinStyle == "dot")
    info.func = function()
      prof.mapPins.pinStyle = "dot"
      _G.UIDropDownMenu_SetText(ddPinStyle, "Dot")
      refreshPins()
    end
    _G.UIDropDownMenu_AddButton(info)
  end)

  y = y - 34

  local colorPicker = mkColorPicker(panel, "Pin Color")
  colorPicker:SetPoint("TOPLEFT", 32, y)

  local btnResetColor = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
  btnResetColor:SetSize(100, 22)
  btnResetColor:SetPoint("LEFT", colorPicker.label, "RIGHT", 10, 0)
  btnResetColor:SetText("Reset Color")
  btnResetColor:SetScript("OnClick", function()
    local prof = ensureProfile()
    if not prof then return end
    prof.mapPins.pinColor.r = 1.0
    prof.mapPins.pinColor.g = 1.0
    prof.mapPins.pinColor.b = 1.0
    colorPicker.color:SetColorTexture(1, 1, 1)
    refreshPins()
  end)

  y = y - 40

  local sizeSlider = mkSlider(panel, "Pin Size", 0.5, 2.0, 0.1)
  sizeSlider:SetSize(200, 16)
  sizeSlider:SetPoint("TOPLEFT", 32, y)
  sizeSlider:SetScript("OnValueChanged", function(self, value)
    local prof = ensureProfile()
    if not prof then return end
    value = math.floor(value * 10 + 0.5) / 10
    prof.mapPins.pinSize = value
    self.valueText:SetText(string.format("%.1fx", value))
    refreshPins()
  end)

  y = y - 40

  local trackerHeader = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
  trackerHeader:SetPoint("TOPLEFT", 16, y)
  trackerHeader:SetText("Tracker")
  y = y - 24

  local cbShowFavoritesOnZone = mkCheckbox(panel, "Highlight saved items when entering zone",
    "When enabled, saved items will be highlighted when you enter a new zone")
  cbShowFavoritesOnZone:SetPoint("TOPLEFT", 32, y)

  local function syncFromDB()
    local prof = ensureProfile()
    if not prof then return end
    cbMinimapButton:SetChecked(not bool(prof.minimap.hide))
    cbMiniPins:SetChecked(bool(prof.mapPins.minimap))
    cbWorldPins:SetChecked(bool(prof.mapPins.worldmap))
    cbHideCollected:SetChecked(bool(prof.filters and prof.filters.hideCollected))

    local tracker = prof.tracker or {}
    cbShowFavoritesOnZone:SetChecked(tracker.showFavoritesOnZoneEnter ~= false)

    if prof.mapPins.pinStyle == "dot" then
      _G.UIDropDownMenu_SetText(ddPinStyle, "Dot")
    else
      _G.UIDropDownMenu_SetText(ddPinStyle, "House Icon")
    end

    local c = prof.mapPins.pinColor
    colorPicker.color:SetColorTexture(c.r, c.g, c.b)

    local size = prof.mapPins.pinSize or 1.0
    sizeSlider:SetValue(size)
    sizeSlider.valueText:SetText(string.format("%.1fx", size))
  end

  cbMinimapButton:SetScript("OnClick", function(self)
    local prof = ensureProfile()
    if not prof then return end
    local show = self:GetChecked() and true or false
    prof.minimap.hide = not show
    if NS.UI and NS.UI.SetMinimapHidden then
      pcall(NS.UI.SetMinimapHidden, NS.db, not show)
    else
      local LDBIcon = _G.LibStub and _G.LibStub("LibDBIcon-1.0", true)
      if LDBIcon and LDBIcon:IsRegistered(ADDON) then
        if show then LDBIcon:Show(ADDON) else LDBIcon:Hide(ADDON) end
      end
    end
  end)

  cbMiniPins:SetScript("OnClick", function(self)
    local prof = ensureProfile()
    if not prof then return end
    prof.mapPins.minimap = self:GetChecked() and true or false
    refreshPins()
  end)

  cbHideCollected:SetScript("OnClick", function(self)
    local prof = ensureProfile()
    if not prof then return end
    prof.filters = prof.filters or {}
    prof.filters.hideCollected = self:GetChecked() and true or false
    local UI = NS.UI
    if UI and UI.MainFrame and UI.MainFrame.view then
      pcall(function() UI.MainFrame.view:RequestRender(true) end)
    end
  end)

  cbWorldPins:SetScript("OnClick", function(self)
    local prof = ensureProfile()
    if not prof then return end
    prof.mapPins.worldmap = self:GetChecked() and true or false
    refreshPins()
  end)

  cbShowFavoritesOnZone:SetScript("OnClick", function(self)
    local prof = ensureProfile()
    if not prof then return end
    prof.tracker = prof.tracker or {}
    prof.tracker.showFavoritesOnZoneEnter = self:GetChecked() and true or false
  end)

  panel:SetScript("OnShow", syncFromDB)

  if Settings and Settings.RegisterCanvasLayoutCategory then
    local category = Settings.RegisterCanvasLayoutCategory(panel, panel.name)
    Settings.RegisterAddOnCategory(category)
    panel.category = category
  else
    local add = _G.InterfaceOptions_AddCategory
    if add then add(panel) end
  end

  self.panel = panel

  local vendorPanel = CreateFrame("Frame")
  vendorPanel.name = "Vendor Options"

  local vendorTitle = vendorPanel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
  vendorTitle:SetPoint("TOPLEFT", 16, -16)
  vendorTitle:SetText("Vendor Options")

  local vendorSub = vendorPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
  vendorSub:SetPoint("TOPLEFT", vendorTitle, "BOTTOMLEFT", 0, -6)
  vendorSub:SetText("Control what HomeDecor overlays on the vendor window.")

  local vy = -60

  local cbCollectedCheckmark = mkCheckbox(vendorPanel, "Show collected checkmark",
    "Show a checkmark on vendor items you already own in your housing storage")
  cbCollectedCheckmark:SetPoint("TOPLEFT", 16, vy)
  vy = vy - 34

  local cbOwnedCount = mkCheckbox(vendorPanel, "Show owned count",
    "Show a number on vendor items indicating how many you own in your housing storage")
  cbOwnedCount:SetPoint("TOPLEFT", 16, vy)
  vy = vy - 34

  local cbVendorNPCTooltip = mkCheckbox(vendorPanel, "Show vendor NPC tooltip info",
    "Show HomeDecor info in the tooltip when hovering over a vendor NPC")
  cbVendorNPCTooltip:SetPoint("TOPLEFT", 16, vy)

  local function syncVendorFromDB()
    local prof = ensureProfile()
    if not prof then return end
    local v1 = bool(prof.vendor.showCollectedCheckmark)
    local v2 = bool(prof.vendor.showOwnedCount)
    local v3 = bool(prof.vendor.showVendorNPCTooltip)
    cbCollectedCheckmark:SetChecked(v1)
    cbCollectedCheckmark.value = v1
    cbOwnedCount:SetChecked(v2)
    cbOwnedCount.value = v2
    cbVendorNPCTooltip:SetChecked(v3)
    cbVendorNPCTooltip.value = v3
  end

  vendorPanel:SetScript("OnShow", syncVendorFromDB)

  local settingsFrame = _G.SettingsPanel or _G.InterfaceOptionsFrame
  if settingsFrame and settingsFrame.HookScript then
    settingsFrame:HookScript("OnShow", syncVendorFromDB)
  end

  if Settings and Settings.OpenToCategory then
    hooksecurefunc(Settings, "OpenToCategory", function()
      C_Timer.After(0, syncVendorFromDB)
    end)
  end

  cbCollectedCheckmark:SetScript("OnClick", function(self)
    local prof = ensureProfile()
    if not prof then return end
    local val = self:GetChecked() and true or false
    prof.vendor.showCollectedCheckmark = val
    self.value = val
    local CM = NS.UI and NS.UI.VendorCheckMarks
    if CM then
      if val then
        if CM.Refresh then pcall(CM.Refresh, CM) end
      else
        if CM.HideAll then pcall(CM.HideAll, CM) end
      end
    end
  end)

  cbOwnedCount:SetScript("OnClick", function(self)
    local prof = ensureProfile()
    if not prof then return end
    local val = self:GetChecked() and true or false
    prof.vendor.showOwnedCount = val
    self.value = val
    local DC = NS.UI and NS.UI.VendorDecorCounters
    if DC then
      if val then
        if DC.Refresh then pcall(DC.Refresh, DC) end
      else
        if DC.HideAll then pcall(DC.HideAll, DC) end
      end
    end
  end)

  cbVendorNPCTooltip:SetScript("OnClick", function(self)
    local prof = ensureProfile()
    if not prof then return end
    local val = self:GetChecked() and true or false
    prof.vendor.showVendorNPCTooltip = val
    self.value = val
  end)

  if Settings and Settings.RegisterCanvasLayoutSubcategory then
    local vendorCategory = Settings.RegisterCanvasLayoutSubcategory(panel.category, vendorPanel, vendorPanel.name)
    vendorPanel.category = vendorCategory
    if panel.category then
      panel.category.collapsed = true
    end
  else
    vendorPanel.parent = panel
    local add = _G.InterfaceOptions_AddCategory
    if add then add(vendorPanel) end
  end

  self.vendorPanel = vendorPanel
end

function Options:Open()
  self:Ensure()
  openCategoryFrame(self.panel)
end

return Options
