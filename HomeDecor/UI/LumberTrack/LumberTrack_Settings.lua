local ADDON, NS = ...
NS.UI = NS.UI or {}

local Settings = {}
NS.UI.LumberTrackSettings = Settings
local Utils = NS.LT.Utils

local CreateFrame = CreateFrame
local unpack = _G.unpack or table.unpack
local GameTooltip = GameTooltip

local function CreateCheckbox(parent, x, y, label, tooltipText)
  local cb = CreateFrame("CheckButton", nil, parent, "UICheckButtonTemplate")
  cb:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)

  local lbl = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  lbl:SetPoint("LEFT", cb, "RIGHT", 4, 0)
  lbl:SetText(label)
  cb.label = lbl

  if tooltipText then
    cb:SetScript("OnEnter", function(self)
      if GameTooltip then
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:AddLine(label, 1, 1, 1)
        GameTooltip:AddLine(tooltipText, 0.7, 0.7, 0.7, true)
        GameTooltip:Show()
      end
    end)
    cb:SetScript("OnLeave", function()
      if GameTooltip then GameTooltip:Hide() end
    end)
  end

  return cb
end

function Settings:CreatePanel(parent, sharedCtx, onAlphaChange)
  if not parent then return nil end

  local db = Utils.GetDB()
  local T = Utils.GetTheme()

  local settings = CreateFrame("Frame", nil, parent, "BackdropTemplate")
  settings:SetFrameStrata("DIALOG")
  settings:SetFrameLevel(parent:GetFrameLevel() + 20)
  settings:SetSize(280, 455)
  settings:SetPoint("CENTER", parent, "CENTER", 0, 0)
  settings:Hide()
  Utils.CreateBackdrop(settings, T.panel, T.border)

  local title = settings:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
  title:SetPoint("TOP", 0, -16)
  title:SetText("Settings")
  title:SetTextColor(unpack(T.accent or {1, 0.82, 0.2, 1}))

  local yOffset = -50

  local iconsCB = CreateCheckbox(settings, 20, yOffset, "Show Icons")
  iconsCB:SetChecked(sharedCtx and sharedCtx.showIcons ~= false or true)
  iconsCB:SetScript("OnClick", function(self)
    if sharedCtx then
      sharedCtx.showIcons = self:GetChecked() and true or false
      if db then db.showIcons = sharedCtx.showIcons end
      local Render = NS.UI.LumberTrackRender
      if Render and Render.Refresh then Render:Refresh(sharedCtx) end
      local Rows = NS.UI.LumberTrackRows
      if Rows and Rows.Reflow then
        C_Timer.After(0.1, function() Rows:Reflow(sharedCtx) end)
      end
    end
  end)
  yOffset = yOffset - 35

  local hideCB = CreateCheckbox(settings, 20, yOffset, "Hide Items with 0")
  hideCB:SetChecked(sharedCtx and sharedCtx.hideZero and true or false)
  hideCB:SetScript("OnClick", function(self)
    if sharedCtx then
      sharedCtx.hideZero = self:GetChecked() and true or false
      if db then db.hideZero = sharedCtx.hideZero end
      local Render = NS.UI.LumberTrackRender
      if Render and Render.Refresh then Render:Refresh(sharedCtx) end
    end
  end)
  yOffset = yOffset - 35

  local compactCB = CreateCheckbox(settings, 20, yOffset, "Compact Mode",
    "Shows a condensed single-line list — fits more items with less screen space")
  compactCB:SetChecked(sharedCtx and sharedCtx.compactMode and true or false)
  compactCB:SetScript("OnClick", function(self)
    if sharedCtx then
      local newVal = self:GetChecked() and true or false
      sharedCtx.compactMode = newVal
      if db then db.compactMode = newVal end
      if sharedCtx.rows then
        for i, row in pairs(sharedCtx.rows) do
          if row then row:Hide(); row:SetParent(nil) end
          sharedCtx.rows[i] = nil
        end
      end
      local LumberList = NS.UI.LumberTrackLumberList
      if LumberList and LumberList.compactBtn then
        local Tx = Utils.GetTheme()
        if newVal then
          LumberList.compactBtn:SetBackdropBorderColor(unpack(Tx.accentBright or Tx.accent))
          LumberList.compactBtn.icon:SetVertexColor(unpack(Tx.accent))
        else
          LumberList.compactBtn:SetBackdropBorderColor(unpack(Tx.border))
          LumberList.compactBtn.icon:SetVertexColor(0.6, 0.6, 0.6, 1)
        end
      end
      local Render = NS.UI.LumberTrackRender
      if Render and Render.Refresh then Render:Refresh(sharedCtx) end
    end
  end)
  settings.compactCB = compactCB
  yOffset = yOffset - 35

  local autoFarmCB = CreateCheckbox(settings, 20, yOffset, "Auto Farm Mode",
    "Automatically start farming stats when you loot lumber")
  autoFarmCB:SetChecked((db and db.autoStartFarming) and true or false)
  autoFarmCB:SetScript("OnClick", function(self)
    local checked = self:GetChecked() and true or false
    if db then db.autoStartFarming = checked end
    if sharedCtx then sharedCtx.autoStartFarming = checked end
  end)
  yOffset = yOffset - 35

  local accountWideCB = CreateCheckbox(settings, 20, yOffset, "Account Wide",
    "Combines lumber counts from all characters.\n\nHover over rows to see per-character breakdown.")
  local AccountWide = NS.UI.LumberTrackAccountWide
  accountWideCB:SetChecked(AccountWide and AccountWide:IsEnabled() or false)
  accountWideCB:SetScript("OnClick", function(self)
    local checked = self:GetChecked() and true or false
    if AccountWide then AccountWide:SetEnabled(checked) end
    if db then db.accountWide = checked end
    local Render = NS.UI.LumberTrackRender
    if Render and Render.Refresh then Render:Refresh(sharedCtx) end
  end)
  yOffset = yOffset - 35

  local goalLabel = settings:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  goalLabel:SetPoint("TOPLEFT", 20, yOffset)
  goalLabel:SetText("Goal Amount:")

  local goalInput = CreateFrame("EditBox", nil, settings, "BackdropTemplate")
  goalInput:SetPoint("LEFT", goalLabel, "RIGHT", 8, 0)
  goalInput:SetSize(80, 26)
  goalInput:SetAutoFocus(false)
  goalInput:SetFontObject(GameFontHighlight)
  goalInput:SetTextInsets(8, 8, 0, 0)
  goalInput:SetMaxLetters(6)
  goalInput:SetNumeric(true)
  Utils.CreateBackdrop(goalInput, T.row or {0.12, 0.12, 0.14, 1}, T.border or {0.24, 0.24, 0.28, 0.8})

  local goalVal = (sharedCtx and tonumber(sharedCtx.goal)) or (db and tonumber(db.goal)) or 1000
  goalInput:SetText(tostring(goalVal))
  goalInput:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
  goalInput:SetScript("OnEnterPressed", function(self)
    local val = tonumber(self:GetText()) or 1000
    val = Utils.Clamp(val, 1, 999999)
    self:SetText(tostring(val))
    if sharedCtx then
      sharedCtx.goal = val
      if db then db.goal = val end
      local Render = NS.UI.LumberTrackRender
      if Render and Render.Refresh then Render:Refresh(sharedCtx) end
    end
    self:ClearFocus()
  end)
  yOffset = yOffset - 35

  local autoGoalCB = CreateCheckbox(settings, 20, yOffset, "Auto-Calculate Goals",
    "Automatically calculates goals based on housing decor recipes you haven't crafted yet")
  autoGoalCB:SetChecked((db and db.autoGoal) and true or false)
  autoGoalCB:SetScript("OnClick", function(self)
    local checked = self:GetChecked() and true or false
    if db then db.autoGoal = checked end
    if sharedCtx then sharedCtx.autoGoal = checked end
    if checked then
      goalInput:Hide()
      goalLabel:SetTextColor(0.5, 0.5, 0.5, 1)
    else
      goalInput:Show()
      goalLabel:SetTextColor(1, 1, 1, 1)
    end
    local Render = NS.UI.LumberTrackRender
    if Render and Render.Refresh then Render:Refresh(sharedCtx) end
  end)

  if (db and db.autoGoal) then
    goalInput:Hide()
    goalLabel:SetTextColor(0.5, 0.5, 0.5, 1)
  end
  yOffset = yOffset - 35

  local alphaLabel = settings:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  alphaLabel:SetPoint("TOPLEFT", 20, yOffset)
  alphaLabel:SetText("Transparency:")
  yOffset = yOffset - 30

  local slider = CreateFrame("Slider", nil, settings, "OptionsSliderTemplate")
  slider:SetPoint("TOPLEFT", 20, yOffset)
  slider:SetWidth(200)
  slider:SetMinMaxValues(0, 1)
  slider:SetValue(parent._bgAlpha or 0.7)
  slider:SetValueStep(0.05)

  local alphaValue = settings:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  alphaValue:SetPoint("LEFT", slider, "RIGHT", 8, 0)
  alphaValue:SetText(string.format("%.0f%%", (parent._bgAlpha or 0.7) * 100))

  slider:SetScript("OnValueChanged", function(self, value)
    parent._bgAlpha = value
    alphaValue:SetText(string.format("%.0f%%", value * 100))
    local d = Utils.GetDB()
    if d then d.alpha = value end
    local showBackgrounds = value >= 0.3
    if sharedCtx then
      sharedCtx.showRowBackgrounds = showBackgrounds
      local Rows = NS.UI.LumberTrackRows
      if Rows and Rows.UpdateRowTransparency then
        Rows:UpdateRowTransparency(sharedCtx)
      end
    end
    if type(onAlphaChange) == "function" then
      onAlphaChange(value, showBackgrounds)
    end
  end)

  settings.iconsCB = iconsCB
  settings.hideCB = hideCB
  settings.autoFarmCB = autoFarmCB
  settings.accountWideCB = accountWideCB
  settings.goalInput = goalInput
  settings.goalLabel = goalLabel
  settings.autoGoalCB = autoGoalCB
  settings.slider = slider

  return settings
end

function Settings:RefreshPanel(settingsPanel, sharedCtx)
  if not settingsPanel then return end

  local db = Utils.GetDB()
  local AccountWide = NS.UI.LumberTrackAccountWide

  if settingsPanel.iconsCB then
    settingsPanel.iconsCB:SetChecked(sharedCtx and sharedCtx.showIcons ~= false or true)
  end

  if settingsPanel.hideCB then
    settingsPanel.hideCB:SetChecked(sharedCtx and sharedCtx.hideZero and true or false)
  end

  if settingsPanel.compactCB then
    settingsPanel.compactCB:SetChecked(sharedCtx and sharedCtx.compactMode and true or false)
  end

  if settingsPanel.autoFarmCB then
    settingsPanel.autoFarmCB:SetChecked((db and db.autoStartFarming) and true or false)
  end

  if settingsPanel.accountWideCB and AccountWide then
    settingsPanel.accountWideCB:SetChecked(AccountWide:IsEnabled())
  end
end

function Settings:Get(key)
  local db = Utils.GetDB()
  return db[key]
end

function Settings:Set(key, value)
  local db = Utils.GetDB()
  db[key] = value
end

return Settings
