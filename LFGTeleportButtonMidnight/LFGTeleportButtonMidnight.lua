---@diagnostic disable: undefined-global
-- luacheck: globals CreateFrame UIParent DEFAULT_CHAT_FRAME SlashCmdList InCombatLockdown C_LFGList GameTooltip GetTime C_Spell LibStub Settings C_Timer C_AddOns SecondsToTime ChallengesFrame TELEPORT_TO_DUNGEON READY SPELL_FAILED_NOT_KNOWN

local ADDON_NAME = ...

-- Cache frequently used Lua functions for performance
local pairs, ipairs, type, tostring, tonumber = pairs, ipairs, type, tostring, tonumber
local floor, format = math.floor, string.format

-- Dev guard: stop if not in WoW client.
if not CreateFrame or not UIParent then
  if print then print("[TPB] WoW API not available; skipping addon init.") end
  return
end

-- Defaults
local DEFAULTS = {
  pos = { point = "CENTER", x = 0, y = 250 },
  size = { w = 50, h = 50 },
  locked = true,
  fontKey = nil, -- LibSharedMedia font key; nil means addon default
  fontSize = 25,
}

TPB_DB = TPB_DB or {}

local function mergeDefaults(db, defaults)
  db = db or {}
  for k, v in pairs(defaults) do
    if type(v) == "table" then
      if type(db[k]) ~= "table" then db[k] = {} end
      mergeDefaults(db[k], v)
    elseif db[k] == nil then
      db[k] = v
    end
  end
  return db
end

-- Midnight Season 1 Dungeons
-- Icon is fetched dynamically from spell via C_Spell.GetSpellInfo(spellID).iconID
local DUNGEONS = {
  { name = "Windrunner Spire",      spell = 1254400, triggers = { "windrunner", "spire" } },
  { name = "Skyreach",              spell = 1254557, triggers = { "skyreach" } },
  { name = "Seat of the Triumvirate", spell = 1254551, triggers = { "seat", "triumvirate" } },
  { name = "Pit of Saron",          spell = 1254555, triggers = { "pit of saron", "saron", "pit" } },
  { name = "Nexus-Point Xenas",     spell = 1254563, triggers = { "nexus", "xenas" } },
  { name = "Maisara Caverns",       spell = 1254559, triggers = { "maisara", "caverns" } },
  { name = "Magisters' Terrace",    spell = 1254572, triggers = { "magister", "terrace" } },
  { name = "Al'gethar Academy",     spell = 393273, triggers = { "algethar", "academy" } },
}

-- Activity ID to Dungeon Index Map
local ACTIVITY_TO_DUNGEON = {
  -- [ID] = Index in DUNGEONS table
  [1542] = 1, -- Windrunner Spire
  [182]  = 2, -- Skyreach
  [486]  = 3, -- Seat of the Triumvirate
  [1770] = 4, -- Pit of Saron
  [1768] = 5, -- Nexus-Point Xenas
  [1764] = 6, -- Maisara Caverns
  [1760] = 7, -- Magisters' Terrace
  [1160] = 8, -- Al'gethar Academy
}

-- MapChallengeMode ID to Spell ID for M+ UI overlay buttons
local MAP_ID_TO_SPELL = {
  -- Midnight Season 1
  [558] = 1254572, -- Magisters' Terrace
  [560] = 1254559, -- Maisara Caverns
  [559] = 1254563, -- Nexus-Point Xenas
  [557] = 1254400, -- Windrunner Spire
  [402] = 393273,  -- Al'gethar Academy
  [556] = 1254555, -- Pit of Saron
  [239] = 1254551, -- Seat of the Triumvirate
  [161] = 1254557, -- Skyreach
}

local function Print(msg)
  if DEFAULT_CHAT_FRAME then
    DEFAULT_CHAT_FRAME:AddMessage("|cff9be28f[TPB]|r " .. tostring(msg))
  else
    print("[TPB] " .. tostring(msg))
  end
end

-- Spell name helper
local function getSpellName(spellID)
  if not spellID then return nil end
  local info = C_Spell.GetSpellInfo(spellID)
  return info and info.name or nil
end

-- Spell knowledge helper
local function isTeleportKnown(spellID)
  if not spellID or not C_Spell then
    return false
  end

  if C_Spell.IsSpellKnownOrOverridesKnown then
    return C_Spell.IsSpellKnownOrOverridesKnown(spellID)
  end

  -- Beta builds sometimes omit IsSpellKnownOrOverridesKnown; fall back gracefully
  if C_Spell.IsSpellKnown then
    return C_Spell.IsSpellKnown(spellID)
  end

  if IsPlayerSpell then
    return IsPlayerSpell(spellID)
  end

  if IsSpellKnown then
    return IsSpellKnown(spellID)
  end

  return false
end

local function norm(s)
  s = (s or ""):lower()
  s = s:gsub("[^%a%d%'%s]", " ")
  s = s:gsub("%s+", " ")
  return s
end

local function matchDungeonFromListingName(name)
  local ln = norm(name)
  for _, d in ipairs(DUNGEONS) do
    for _, trig in ipairs(d.triggers) do
      if ln:find(trig, 1, true) then
        return d
      end
    end
  end
  return nil
end

local function matchDungeonFromActivity(activityID, fallbackName)
  if activityID then
    -- Direct static mapping gets priority for exactness
    if DUNGEONS[activityID] then
      return DUNGEONS[DUNGEONS[activityID]]
    end
    local full
    if C_LFGList and C_LFGList.GetActivityFullName then
      full = C_LFGList.GetActivityFullName(activityID)
    end
    if not full then
      local a = C_LFGList.GetActivityInfoTable and C_LFGList.GetActivityInfoTable(activityID)
      if a then full = a.fullName or a.shortName end
    end
    if full and full ~= "" then
      local d = matchDungeonFromListingName(full)
      if d then return d end
    end
  end
  return matchDungeonFromListingName(fallbackName or "")
end

local function matchDungeonFromActivityIDs(activityIDs)
  if type(activityIDs) == "table" then
    for _, actId in pairs(activityIDs) do
      if DUNGEONS[actId] then
        return DUNGEONS[DUNGEONS[actId]]
      end
      local fullName = nil
      if C_LFGList and C_LFGList.GetActivityFullName then
        fullName = C_LFGList.GetActivityFullName(actId)
      end
      if not fullName or fullName == "" then
        local a = C_LFGList.GetActivityInfoTable and C_LFGList.GetActivityInfoTable(actId)
        if a then fullName = a.fullName or a.shortName end
      end
      if type(fullName) == "string" and fullName:find("(Mythic Keystone)", 1, true) then
        local d = matchDungeonFromListingName(fullName)
        if d then return d end
      end
    end
  end
  return nil
end

-- Secure Button
---@diagnostic disable-next-line: redundant-parameter
local btn = CreateFrame("Button", "TPB_Button", UIParent, "SecureActionButtonTemplate")
btn:SetFrameStrata("MEDIUM")
btn:Hide()
btn:SetMovable(true)
btn:EnableMouse(true)
btn:RegisterForDrag("LeftButton")
btn:SetClampedToScreen(true)
-- Only allow secure action on left click; still listen to right-click for our script
btn:RegisterForClicks("LeftButtonDown", "LeftButtonUp")

local icon = btn:CreateTexture(nil, "ARTWORK")
icon:SetAllPoints(btn)
icon:Hide() -- use button normal texture like portal-buttons

-- Cooldown
---@diagnostic disable-next-line: redundant-parameter
local cd = CreateFrame("Cooldown", nil, btn, "CooldownFrameTemplate")
cd:SetAllPoints(btn)
-- Keep default swipe texture; some client builds error on nil swipes
cd:EnableMouse(false)
if cd.SetDrawEdge then cd:SetDrawEdge(false) end

-- Highlights
-- Only show strong highlight while pressing; use weaker border glow on hover
btn:SetHighlightTexture("")
btn:SetNormalTexture("")
btn:SetPushedTexture("Interface\\Buttons\\CheckButtonHilight")
do
  local pt = btn:GetPushedTexture()
  if pt and pt.SetBlendMode then pt:SetBlendMode("ADD") end
end

-- Text Overlay
local FONT_PATH = "Interface\\AddOns\\LFGTeleportButtonMidnight\\BebasNeue-Regular.ttf"
local overlayFont = CreateFont("TPB_OverlayFont")
do
  local ok = overlayFont:SetFont(FONT_PATH, 25, "OUTLINE")
  if not ok then
    local default, size, flags = GameFontNormal:GetFont()
    overlayFont:SetFont(default or "Fonts\\FRIZQT__.TTF", 25, "OUTLINE")
  end
end
local overlayText = btn:CreateFontString(nil, "OVERLAY")
overlayText:SetFontObject(overlayFont)
overlayText:SetTextColor(1, 1, 1, 1)
overlayText:SetJustifyH("CENTER")
overlayText:SetJustifyV("BOTTOM")
-- Keep the bottom of the text 35px above the icon/button top so it never overlaps
overlayText:ClearAllPoints()
overlayText:SetPoint("BOTTOM", btn, "TOP", 0, 5)

-- Hover Glow
local hoverGlow = btn:CreateTexture(nil, "HIGHLIGHT")
hoverGlow:SetTexture("Interface\\Buttons\\CheckButtonHilight")
hoverGlow:SetAllPoints(btn)
hoverGlow:SetBlendMode("ADD")
-- Tint hover with rgba(146,171,255,255) and lower alpha while hovering
hoverGlow:SetVertexColor(146 / 255, 171 / 255, 255 / 255, 1)
hoverGlow:SetAlpha(0.6)
hoverGlow:Hide()

local currentDungeon        = nil
local currentSpellID        = nil
local currentApplicationID  = nil -- Track which application the button is showing for
local pendingApply          = false
local pendingSecureUpdate   = false
local suppressedByCombat    = false
local hiddenForCombat       = false -- Auto-hide during combat
local userDismissed         = false
local notLearnedSoundPlayed = false
local showGitGudUntil       = nil
local NOT_LEARNED_SFX       = "Interface\\AddOns\\LFGTeleportButtonMidnight\\SHaoKhanlaughing.mp3"
local currentIconID         = nil
local pendingInvites        = {} -- Store multiple pending invites: [applicationID] = dungeon

-- Unknown teleport suffix helper
local function getUnknownSuffix(known)
  if known then return "" end
  local now = GetTime and GetTime() or 0
  if showGitGudUntil and now < showGitGudUntil then
    return "\n|cffff0000 Git Gud|r"
  end
  return "\n|cffff0000 No Teleport Yet|r"
end

-- LSM Support
local lsm = LibStub and LibStub("LibSharedMedia-3.0", true) or nil

local function applyFontFromDB()
  local size = (TPB_DB and TPB_DB.fontSize) or DEFAULTS.fontSize
  local path = FONT_PATH
  if lsm and TPB_DB and TPB_DB.fontKey then
    local fetched = lsm:Fetch("font", TPB_DB.fontKey, true)
    if type(fetched) == "string" and fetched ~= "" then
      path = fetched
    end
  end
  local ok = overlayFont:SetFont(path, size, "OUTLINE")
  if not ok then
    local default = select(1, GameFontNormal:GetFont())
    overlayFont:SetFont(default or "Fonts\\FRIZQT__.TTF", size, "OUTLINE")
  end
  if overlayText and overlayText.SetFont then
    local applied = overlayText:SetFont(path, size, "OUTLINE")
    if not applied then
      local default = select(1, GameFontNormal:GetFont())
      overlayText:SetFont(default or "Fonts\\FRIZQT__.TTF", size, "OUTLINE")
    end
  end
end

-- Forward declaration so UI can call it before it's defined
local applyPositionAndSizeFromDB

-- Options Panel
local optionsPanel
local standaloneOptionsFrame
local standaloneLSMCallbacksHooked = false

local function EnsureStandaloneOptions()
  if standaloneOptionsFrame then
    standaloneOptionsFrame:Show()
    return
  end

  ---@diagnostic disable-next-line: redundant-parameter
  local frame = CreateFrame("Frame", nil, UIParent)
  frame:SetSize(450, 370)
  frame:SetPoint("CENTER")
  frame:SetMovable(true)
  frame:EnableMouse(true)
  frame:RegisterForDrag("LeftButton")
  frame:SetScript("OnDragStart", function(self) self:StartMoving() end)
  frame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
  frame:SetClampedToScreen(true)
  frame:SetAlpha(1)
  frame:SetFrameStrata("DIALOG")

  -- Subtle background without border
  local bg = frame:CreateTexture(nil, "BACKGROUND")
  bg:SetAllPoints(true)
  bg:SetColorTexture(0, 0, 0, 0.70)

  -- Title
  local title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
  title:ClearAllPoints()
  title:SetPoint("TOP", frame, "TOP", 0, -48)
  title:SetText("|TInterface\\AddOns\\LFGTeleportButtonMidnight\\Media\\portal.blp:20|t LFG Teleport Button - Options")

  -- Close button
  ---@diagnostic disable-next-line: redundant-parameter
  local closeBtn = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
  closeBtn:SetSize(22, 22)
  closeBtn:ClearAllPoints()
  closeBtn:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -10, -10)
  closeBtn:SetText("X")
  closeBtn:SetScript("OnClick", function() frame:Hide() end)

  -- Preview
  local preview = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
  if preview and preview.SetFontObject and GameFontHighlight then
    preview:SetFontObject(GameFontHighlight)
  end
  preview:ClearAllPoints()
  preview:SetPoint("TOP", title, "BOTTOM", 0, -16)
  preview:SetTextColor(1, 1, 1)
  preview:SetText("You have been invited to :\nExample Dungeon\n|cffff0000 No Teleport Yet|r")

  local function refreshPreview()
    local size = 20
    local path = FONT_PATH
    if lsm and TPB_DB and TPB_DB.fontKey then
      local fetched = lsm:Fetch("font", TPB_DB.fontKey, true)
      if type(fetched) == "string" and fetched ~= "" then
        path = fetched
      end
    end
    local ok = preview:SetFont(path, size, "OUTLINE")
    if not ok then
      local default = select(1, GameFontNormal:GetFont())
      preview:SetFont(default or "Fonts\\FRIZQT__.TTF", size, "OUTLINE")
    end
  end

  -- Font selector
  local label = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
  label:ClearAllPoints()
  label:SetPoint("TOP", preview, "BOTTOM", 0, -16)
  label:SetText("")

  local AceGUI_local = LibStub and LibStub("AceGUI-3.0", true)
  local fontWidgetRefStandalone = nil
  local fontAnchor = label
  if AceGUI_local and AceGUI_local.Create then
    local fontWidget = AceGUI_local:Create("LSM30_Font")
    fontWidgetRefStandalone = fontWidget
    fontWidget:SetLabel("Font")
    if lsm and lsm.HashTable then
      fontWidget:SetList(lsm:HashTable("font"))
    end
    fontWidget:SetValue(TPB_DB.fontKey or "")
    fontWidget:SetCallback("OnValueChanged", function(widget, event, key)
      TPB_DB.fontKey = key ~= "" and key or nil
      if fontWidgetRefStandalone and fontWidgetRefStandalone.SetValue then
        fontWidgetRefStandalone:SetValue(key or "")
      end
      applyFontFromDB()
      refreshPreview()
    end)
    local fw = fontWidget.frame
    fw:SetParent(frame)
    fw:ClearAllPoints()
    fw:SetPoint("TOP", label, "BOTTOM", 0, -8)
    fw:SetWidth(300)
    fw:Show()
    fontAnchor = fw
  else
    ---@diagnostic disable-next-line: redundant-parameter
    local fontSelectBtn = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    fontSelectBtn:SetPoint("TOP", label, "BOTTOM", 0, -8)
    fontSelectBtn:SetSize(240, 24)
    fontSelectBtn:SetText("Font (LSM required)")
    fontSelectBtn:SetScript("OnClick", function()
      print("[TPB] AceGUI-3.0-SharedMediaWidgets not loaded; cannot show font menu.")
    end)
    fontAnchor = fontSelectBtn
  end

  -- Font size
  local sizeWidgetStandalone, sizeValueLabelStandalone, sizeSliderStandalone
  if AceGUI_local and AceGUI_local.Create then
    sizeWidgetStandalone = AceGUI_local:Create("Slider")
    sizeWidgetStandalone:SetLabel("Font Size")
    sizeWidgetStandalone:SetSliderValues(8, 72, 1)
    sizeWidgetStandalone:SetValue((TPB_DB and TPB_DB.fontSize) or DEFAULTS.fontSize)
    local swf = sizeWidgetStandalone.frame
    swf:SetParent(frame)
    swf:ClearAllPoints()
    swf:SetPoint("TOP", fontAnchor, "BOTTOM", 0, -24)
    swf:SetWidth(300)
    swf:Show()
    sizeValueLabelStandalone = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    sizeValueLabelStandalone:SetPoint("TOP", swf, "BOTTOM", 0, -4)
    sizeValueLabelStandalone:SetText(tostring((TPB_DB and TPB_DB.fontSize) or DEFAULTS.fontSize))
    sizeWidgetStandalone:SetCallback("OnValueChanged", function(widget, event, value)
      value = tonumber(value) or ((TPB_DB and TPB_DB.fontSize) or DEFAULTS.fontSize)
      value = floor(value + 0.5)
      TPB_DB.fontSize = value
      if sizeValueLabelStandalone then sizeValueLabelStandalone:SetText(tostring(value)) end
      applyFontFromDB()
    end)
  else
    ---@diagnostic disable-next-line: redundant-parameter
    sizeSliderStandalone = CreateFrame("Slider", nil, frame, "OptionsSliderTemplate")
    sizeSliderStandalone:SetPoint("TOP", fontAnchor, "BOTTOM", 0, -24)
    sizeSliderStandalone:SetMinMaxValues(8, 72)
    sizeSliderStandalone:SetObeyStepOnDrag(true)
    sizeSliderStandalone:SetValueStep(1)
    sizeSliderStandalone:SetWidth(240)
    _G[sizeSliderStandalone:GetName() .. 'Low']:SetText('8')
    _G[sizeSliderStandalone:GetName() .. 'High']:SetText('72')
    _G[sizeSliderStandalone:GetName() .. 'Text']:SetText('Font Size')
    sizeSliderStandalone:SetScript("OnValueChanged", function(self, value)
      value = floor(value + 0.5)
      TPB_DB.fontSize = value
      applyFontFromDB()
    end)
    sizeValueLabelStandalone = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    sizeValueLabelStandalone:SetPoint("TOP", sizeSliderStandalone, "BOTTOM", 0, -4)
    sizeValueLabelStandalone:SetText(tostring((TPB_DB and TPB_DB.fontSize) or DEFAULTS.fontSize))
  end

  -- Drag hint
  local dragHint = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
  dragHint:ClearAllPoints()
  dragHint:SetPoint("BOTTOM", frame, "BOTTOM", 0, 30)
  dragHint:SetText("Hold CTRL and Left-Drag the button to move it")

  -- Reset position
  ---@diagnostic disable-next-line: redundant-parameter
  local resetBtn = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
  resetBtn:ClearAllPoints()
  resetBtn:SetPoint("BOTTOM", frame, "BOTTOM", 0, 5)
  resetBtn:SetSize(140, 24)
  resetBtn:SetText("Reset Position")
  resetBtn:SetScript("OnClick", function()
    TPB_DB.pos.point = DEFAULTS.pos.point
    TPB_DB.pos.x = DEFAULTS.pos.x
    TPB_DB.pos.y = DEFAULTS.pos.y
    if type(applyPositionAndSizeFromDB) == "function" then
      applyPositionAndSizeFromDB()
    else
      btn:SetSize(TPB_DB.size.w, TPB_DB.size.h)
      btn:ClearAllPoints()
      btn:SetPoint(TPB_DB.pos.point, UIParent, TPB_DB.pos.point, TPB_DB.pos.x, TPB_DB.pos.y)
    end
    if not btn:IsShown() then btn:Show() end
    if not currentIconID then
      currentIconID = 135751
      if overlayText and overlayText.SetText then
        local title = "Test Dungeon"
        local suffix = getUnknownSuffix(false)
        overlayText:SetText("You have been invited to :\n|cff07f8ab" .. title .. "|r" .. suffix)
      end
    end
    if icon and icon.SetTexture then icon:SetTexture(currentIconID) end
    if icon and icon.Show then icon:Show() end
    if icon and icon.SetDesaturated then icon:SetDesaturated(false) end
    Print("Position reset to default.")
  end)

  frame:SetScript("OnShow", function()
    -- Sync size slider/label
    if sizeWidgetStandalone and sizeWidgetStandalone.SetValue then
      sizeWidgetStandalone:SetValue((TPB_DB and TPB_DB.fontSize) or DEFAULTS.fontSize)
      if sizeValueLabelStandalone then sizeValueLabelStandalone:SetText(tostring((TPB_DB and TPB_DB.fontSize) or
        DEFAULTS.fontSize)) end
    elseif sizeSliderStandalone and sizeSliderStandalone.SetValue then
      sizeSliderStandalone:SetValue((TPB_DB and TPB_DB.fontSize) or DEFAULTS.fontSize)
      if sizeValueLabelStandalone then sizeValueLabelStandalone:SetText(tostring((TPB_DB and TPB_DB.fontSize) or
        DEFAULTS.fontSize)) end
    end
    if fontWidgetRefStandalone and fontWidgetRefStandalone.SetValue then
      fontWidgetRefStandalone:SetValue(TPB_DB.fontKey or "")
    end
    refreshPreview()
    applyFontFromDB()
  end)

  if lsm and lsm.RegisterCallback and not standaloneLSMCallbacksHooked then
    standaloneLSMCallbacksHooked = true
    lsm:RegisterCallback("LibSharedMedia_Registered", function(event, mediatype, key)
      if mediatype == "font" then
        refreshPreview()
      end
    end)
    lsm:RegisterCallback("LibSharedMedia_SetGlobal", function(event, mediatype)
      if mediatype == "font" then
        applyFontFromDB()
        refreshPreview()
      end
    end)
  end

  standaloneOptionsFrame = frame
  frame:Show()
end
local function InitOptionsPanel()
  if optionsPanel then return end
  optionsPanel = CreateFrame("Frame", nil)
  local displayName = "|TInterface\\AddOns\\LFGTeleportButtonMidnight\\Media\\portal.blp:16|t LFG Teleport Button"
  optionsPanel.name = displayName

  -- Open Config Button
  ---@diagnostic disable-next-line: redundant-parameter
  local openStandaloneBtn = CreateFrame("Button", nil, optionsPanel, "UIPanelButtonTemplate")
  openStandaloneBtn:SetPoint("CENTER", optionsPanel, "CENTER", 0, 0)
  openStandaloneBtn:SetSize(200, 48)
  openStandaloneBtn:SetText("Open Config")
  do
    local fs = openStandaloneBtn:GetFontString()
    if fs and fs.GetFont then
      local fontPath, fontSize, fontFlags = fs:GetFont()
      local newSize = floor((fontSize or 14) * 2)
      fs:SetFont(fontPath or "Fonts\\FRIZQT__.TTF", newSize, fontFlags)
    end
  end
  openStandaloneBtn:SetScript("OnClick", function()
    EnsureStandaloneOptions()
  end)

  if Settings and Settings.RegisterCanvasLayoutCategory then
    local category = Settings.RegisterCanvasLayoutCategory(optionsPanel, optionsPanel.name)
    Settings.RegisterAddOnCategory(category)
  else
    -- Settings API check
    -- as we are strictly targeting modern retail.
    print("[TPB] Settings API not found. Options panel not registered.")
  end
end

local function updateMovable()
  -- Drag handling
  btn:SetScript("OnDragStart", function(self)
    if IsControlKeyDown and IsControlKeyDown() and not InCombatLockdown() then
      self:StartMoving()
    end
  end)
  btn:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    local p, _, _, x, y = self:GetPoint()
    TPB_DB.pos.point = p; TPB_DB.pos.x = x; TPB_DB.pos.y = y
  end)
end

-- ALT+RightClick to hide
btn:SetScript("OnMouseUp", function(self, mouseButton)
  -- Play sound on unlearned click
  if mouseButton == "LeftButton" then
    if currentSpellID and not isTeleportKnown(currentSpellID) and not notLearnedSoundPlayed then
      if PlaySoundFile then
        PlaySoundFile(NOT_LEARNED_SFX, "Master")
      end
      notLearnedSoundPlayed = true
      -- Show Git Gud for 3 seconds
      if GetTime then showGitGudUntil = GetTime() + 3 end
      -- Update overlay to reflect the new message once the sound condition is met
      local title = (currentDungeon and currentDungeon.name) or "Teleport"
      overlayText:SetText("You have been invited to :\n|cff07f8ab" .. title .. "|r" .. getUnknownSuffix(false))
      -- Schedule text refresh after Git Gud expires
      if C_Timer and C_Timer.After then
        C_Timer.After(3.1, function()
          if currentDungeon and btn:IsShown() then
            local t = currentDungeon.name or "Teleport"
            local k = currentSpellID and isTeleportKnown(currentSpellID)
            overlayText:SetText("You have been invited to :\n|cff07f8ab" .. t .. "|r" .. getUnknownSuffix(k))
          end
        end)
      end
    end
  end
  if mouseButton == "RightButton" and (IsAltKeyDown and IsAltKeyDown()) then
    if GameTooltip and GameTooltip:IsOwned(self) then GameTooltip:Hide() end
    userDismissed = true
    -- Clear all state when user manually dismisses
    currentApplicationID = nil
    currentDungeon = nil
    currentSpellID = nil
    currentIconID = nil
    pendingApply = false
    pendingSecureUpdate = false
    suppressedByCombat = false
    pendingInvites = {}
    if InCombatLockdown and InCombatLockdown() then
      -- Avoid protected Show/Hide in combat; fade out instead
      self:SetAlpha(0)
      suppressedByCombat = true
    else
      self:Hide()
    end
  end
end)

-- Tooltip
btn:SetScript("OnEnter", function(self)
  if not GameTooltip then return end
  GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
  GameTooltip:SetText("Left Click to Teleport", 1, 1, 1)
  GameTooltip:AddLine("ALT + Right Click to Close", 1, 1, 1)
  GameTooltip:AddLine("CTRL + Left Click to Drag", 0.8, 0.8, 0.8)
  -- No chat command hints
  GameTooltip:Show()
  if hoverGlow then hoverGlow:Show() end
end)

btn:SetScript("OnLeave", function()
  if GameTooltip then GameTooltip:Hide() end
  if hoverGlow then hoverGlow:Hide() end
end)


local function updateKnownVisual()
  if not currentSpellID then return end
  -- Keep button fully opaque
  btn:SetAlpha(1)
  local known = isTeleportKnown(currentSpellID)
  if currentIconID then
    icon:SetTexture(currentIconID)
  end
  icon:Show()
  if icon and icon.SetDesaturated then icon:SetDesaturated(not known) end
end

local function updateCooldown()
  if not currentSpellID then return end

  -- Wrap entire cooldown logic in pcall to handle "secret values" during combat
  local success = pcall(function()
    local info = C_Spell.GetSpellCooldown(currentSpellID)
    if info and info.startTime and info.duration and info.duration > 1.5 then
      cd:SetCooldown(info.startTime, info.duration)
    elseif cd.Clear then
      cd:Clear()
    end
  end)
  if not success and cd.Clear then
    cd:Clear()
  end

  -- Update on-button text overlay
  local title = (currentDungeon and currentDungeon.name) or "Teleport"
  local known = currentSpellID and isTeleportKnown(currentSpellID)
  local suffix = getUnknownSuffix(known)
  overlayText:SetText("You have been invited to :\n|cff07f8ab" .. title .. "|r" .. suffix)
  -- Note: Combat lockdown is now handled in applyDungeon, so we don't hide here
  -- This was causing the button to disappear when SPELL_UPDATE_COOLDOWN fired during combat
  if suppressedByCombat and not InCombatLockdown() then
    btn:SetAlpha(1)
    suppressedByCombat = false
  end
end

local function applyDungeon(d)
  currentDungeon = d
  currentSpellID = d.spell

  if InCombatLockdown() then
    pendingApply = true
    return
  end

  -- Don't show if user dismissed the button
  if userDismissed then
    return
  end

  -- Secure attributes: resolve spell name via modern API
  -- Secure attributes: use ID directly for robustness
  -- Always prevent right-click from triggering secure actions
  btn:SetAttribute("type2", nil)

  -- Fetch icon dynamically from spell API (fallback to generic portal icon)
  local spellInfo = C_Spell.GetSpellInfo(currentSpellID)
  local iconID = spellInfo and spellInfo.iconID or 135744 -- 135744 = generic portal icon
  currentIconID = iconID
  icon:SetTexture(iconID)
  icon:Show()

  local known = isTeleportKnown(currentSpellID)
  if known then
    btn:SetAttribute("type", "spell")
    btn:SetAttribute("spell", currentSpellID)
  else
    -- Disarm left click if spell not known
    btn:SetAttribute("type", nil)
    btn:SetAttribute("spell", nil)
  end

  updateKnownVisual()
  updateCooldown()
  btn:ClearAllPoints()
  btn:SetPoint(TPB_DB.pos.point, UIParent, TPB_DB.pos.point, TPB_DB.pos.x, TPB_DB.pos.y)
  btn:SetSize(TPB_DB.size.w, TPB_DB.size.h)
  btn:Show()
  local overlayTitle = (d.name or "Teleport")
  local suffix = getUnknownSuffix(known)
  overlayText:SetText("You have been invited to :\n|cff07f8ab" .. overlayTitle .. "|r" .. suffix)
  Print("Teleport ready: " .. (d.name or "unknown"))
end

-- Slash: /tpbutton lock  (toggle)
SLASH_TPBUTTON1 = "/tpbutton"
-- Forward declaration defined earlier; do not redeclare here
-- local applyPositionAndSizeFromDB

SlashCmdList.TPBUTTON = function(msg)
  msg = (msg or ""):gsub("^%s+", ""):gsub("%s+$", "")
  local lower = msg:lower()

  if lower == "lock" then
    TPB_DB.locked = not TPB_DB.locked
    updateMovable()
    Print(TPB_DB.locked and "Locked (cannot drag)" or "Unlocked (drag with left mouse)")
  elseif lower == "show" then
    if currentDungeon then
      -- Reset dismissal state for show command
      userDismissed = false
      applyDungeon(currentDungeon)
    else
      Print("No dungeon selected yet; use /tpbutton test N")
    end
  elseif lower:find("^test") then
    local idx = tonumber(msg:match("^%s*test%s+(%d+)%s*$"))
    if idx and DUNGEONS[idx] then
      -- Reset dismissal state for test commands
      userDismissed = false
      applyDungeon(DUNGEONS[idx])
    else
      Print("Usage: /tpbutton test N  (N=1-" .. #DUNGEONS .. ")")
      for i, d in ipairs(DUNGEONS) do
        local known = isTeleportKnown(d.spell)
        local spellName = getSpellName(d.spell)
        Print(i ..
        ": " ..
        d.name ..
        " (spell: " .. tostring(d.spell) .. ", known: " .. tostring(known) .. ", spellName: " ..
        (spellName or "nil") .. ")")
      end
    end
  elseif lower == "debug" then
    Print("=== Dungeon Debug Info ===")
    for i, d in ipairs(DUNGEONS) do
      local known = isTeleportKnown(d.spell)
      local spellName = getSpellName(d.spell)
      local spellInfo = C_Spell.GetSpellInfo(d.spell)
      local iconID = spellInfo and spellInfo.iconID or "N/A"
      Print(i .. ": " .. d.name)
      Print("  Spell ID: " .. tostring(d.spell))
      Print("  -> isTeleportKnown: " .. tostring(known))
      Print("  -> C_Spell.IsSpellKnownOrOverridesKnown: " .. tostring(C_Spell.IsSpellKnownOrOverridesKnown(d.spell)))
      Print("  -> Name: " .. (spellName or "nil"))
      Print("  -> Icon (from API): " .. tostring(iconID))
    end
    Print("=== Activity Mappings ===")
    for k, v in pairs(DUNGEONS) do
      if type(k) == "number" and type(v) == "number" then
        local d = DUNGEONS[v]
        Print("Activity " .. k .. " -> " .. (d and d.name or "INVALID INDEX " .. v))
      end
    end
  elseif lower == "reset" then
    TPB_DB.pos.point = DEFAULTS.pos.point
    TPB_DB.pos.x = DEFAULTS.pos.x
    TPB_DB.pos.y = DEFAULTS.pos.y
    applyPositionAndSizeFromDB()
    Print("Position reset to default.")
  elseif lower == "state" or lower == "status" then
    Print("=== Button State ===")
    Print("IsShown: " .. tostring(btn:IsShown()))
    Print("Alpha: " .. tostring(btn:GetAlpha()))
    Print("userDismissed: " .. tostring(userDismissed))
    Print("pendingApply: " .. tostring(pendingApply))
    Print("pendingSecureUpdate: " .. tostring(pendingSecureUpdate))
    Print("suppressedByCombat: " .. tostring(suppressedByCombat))
    Print("InCombat: " .. tostring(InCombatLockdown and InCombatLockdown() or false))
    Print("currentDungeon: " .. tostring(currentDungeon and currentDungeon.name or "nil"))
    Print("currentSpellID: " .. tostring(currentSpellID))
    Print("currentIconID: " .. tostring(currentIconID))
    Print("currentApplicationID: " .. tostring(currentApplicationID))
    if currentSpellID then
      Print("Spell Known: " .. tostring(isTeleportKnown(currentSpellID)))
      Print("Spell Name: " .. tostring(getSpellName(currentSpellID)))
    end
  else
    Print(
    "Commands: /tpbutton lock | /tpbutton show | /tpbutton test N | /tpbutton debug | /tpbutton reset | /tpbutton state")
  end
end

-- =============================================
-- M+ UI Overlay Buttons (like DungeonTeleportButtons)
-- =============================================
local overlayButtons = {}

local function UpdateOverlayTooltip(parent, spellID, initialize)
  if not initialize and not GameTooltip:IsOwned(parent) then return end

  local Button_OnEnter = parent:GetScript("OnEnter")
  if not Button_OnEnter then return end

  local name = C_Spell.GetSpellName(spellID)
  Button_OnEnter(parent)

  if C_Spell.IsSpellKnownOrOverridesKnown and C_Spell.IsSpellKnownOrOverridesKnown(spellID) then
    GameTooltip:AddLine(" ")
    GameTooltip:AddLine(name or TELEPORT_TO_DUNGEON)
    -- Wrap cooldown check in pcall to handle "secret values" during combat
    local showReady = true
    pcall(function()
      local cooldownInfo = C_Spell.GetSpellCooldown(spellID)
      if cooldownInfo and cooldownInfo.duration and cooldownInfo.duration > 0 then
        local remaining = cooldownInfo.startTime + cooldownInfo.duration - GetTime()
        if remaining > 0 then
          GameTooltip:AddLine(SecondsToTime(math.ceil(remaining)), 1, 0, 0)
          showReady = false
        end
      end
    end)
    if showReady then
      GameTooltip:AddLine(READY, 0, 1, 0)
    end
  else
    GameTooltip:AddLine(" ")
    GameTooltip:AddLine(name or TELEPORT_TO_DUNGEON)
    GameTooltip:AddLine(SPELL_FAILED_NOT_KNOWN, 1, 0, 0)
  end

  GameTooltip:Show()
  C_Timer.After(1, function() UpdateOverlayTooltip(parent, spellID) end)
end

local function CreateOverlayButton(parent, spellID)
  if not spellID then return end

  local button = overlayButtons[parent] or CreateFrame("Button", nil, parent, "InsecureActionButtonTemplate")
  button:SetAllPoints(parent)
  button:RegisterForClicks("AnyDown", "AnyUp")
  button:SetAttribute("type", "spell")
  button:SetAttribute("spell", spellID)
  button:SetScript("OnEnter", function() UpdateOverlayTooltip(parent, spellID, true) end)
  button:SetScript("OnLeave", function() if GameTooltip:IsOwned(parent) then GameTooltip:Hide() end end)

  overlayButtons[parent] = button
end

local function CreateAllOverlayButtons()
  if InCombatLockdown() then return end
  if not ChallengesFrame then return end
  if not ChallengesFrame.DungeonIcons then return end

  for _, dungeonIcon in next, ChallengesFrame.DungeonIcons do
    CreateOverlayButton(dungeonIcon, MAP_ID_TO_SPELL[dungeonIcon.mapID])
  end
end

local function InitializeChallengesUI()
  if not C_AddOns.IsAddOnLoaded("Blizzard_ChallengesUI") then return false end

  if ChallengesFrame and type(ChallengesFrame.Update) == "function" then
    hooksecurefunc(ChallengesFrame, "Update", CreateAllOverlayButtons)
  end
  CreateAllOverlayButtons()
  return true
end

-- Event handler
local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("LFG_LIST_APPLICATION_STATUS_UPDATED")
f:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
f:RegisterEvent("SPELL_UPDATE_COOLDOWN")
f:RegisterEvent("SPELLS_CHANGED")
f:RegisterEvent("PLAYER_REGEN_ENABLED")
f:RegisterEvent("PLAYER_REGEN_DISABLED")
f:RegisterEvent("GROUP_ROSTER_UPDATE")

applyPositionAndSizeFromDB = function()
  btn:SetSize(TPB_DB.size.w, TPB_DB.size.h)
  btn:ClearAllPoints()
  btn:SetPoint(TPB_DB.pos.point, UIParent, TPB_DB.pos.point, TPB_DB.pos.x, TPB_DB.pos.y)
end

local nonMatchPrinted = {}


local function CheckActiveGroup()
  if InCombatLockdown() then return end
  if userDismissed then return end

  local info = C_LFGList.GetActiveEntryInfo()
  if info then
    local d = matchDungeonFromActivity(info.activityID, info.name)
    if d and currentDungeon ~= d then
      applyDungeon(d)
    end
  end
end

local events = {}

function events:ADDON_LOADED(name)
  if name == ADDON_NAME then
    TPB_DB = mergeDefaults(TPB_DB, DEFAULTS)
    -- Always start locked on load
    TPB_DB.locked = true
    updateMovable()
    -- Try to initialize M+ overlay if ChallengesUI is already loaded
    InitializeChallengesUI()
  elseif name == "Blizzard_ChallengesUI" then
    -- ChallengesUI just loaded, initialize our overlay buttons
    InitializeChallengesUI()
  end
end

function events:PLAYER_LOGIN()
  applyPositionAndSizeFromDB()
  applyFontFromDB()
  InitOptionsPanel()
  -- Reset per-login sound flag
  notLearnedSoundPlayed = false
  -- Try to initialize M+ overlay (in case it loaded before us)
  InitializeChallengesUI()
  -- Start 5s ticker for host/active group check
  C_Timer.NewTicker(5, CheckActiveGroup)
end

function events:LFG_LIST_APPLICATION_STATUS_UPDATED(applicationID, newStatus, oldStatus, groupID)
  if newStatus == "invited" then
    -- Store dungeon info when invited, but don't show button yet
    -- Reset user dismissal state for new invitations
    userDismissed = false
    local info
    -- Prefer resolving via applicationID â†’ searchResultID â†’ info
    if applicationID and C_LFGList.GetApplicationInfo then
      local searchResultID = C_LFGList.GetApplicationInfo(applicationID)
      if type(searchResultID) == "number" and searchResultID > 0 then
        info = C_LFGList.GetSearchResultInfo(searchResultID)
      end
    end
    -- Fallback: try numeric groupID if provided
    if not info and groupID then
      local maybeId = tonumber(groupID)
      if maybeId then
        info = C_LFGList.GetSearchResultInfo(maybeId)
      end
    end

    local listName = info and info.name or ""
    if info and (not listName or listName == "") then
      listName = (info.comment or "") .. " " .. (info.voiceChat or "")
    end
    local d = nil
    if info and info.activityIDs then
      d = matchDungeonFromActivityIDs(info.activityIDs)
    end
    if not d then
      d = matchDungeonFromActivity(info and info.activityID, listName)
    end
    if d then
      -- Store dungeon info keyed by applicationID - supports multiple pending invites
      pendingInvites[applicationID] = d
    else
      -- Rate-limit non-match prints using applicationID when available
      local key = applicationID or groupID or "unknown"
      if not nonMatchPrinted[key] then
        nonMatchPrinted[key] = true
        Print("Listing did not match a Midnight S1 dungeon; button not shown.")
      end
    end
  elseif newStatus == "inviteAccepted" or (oldStatus == "invited" and newStatus ~= "invited" and newStatus ~= "declined" and newStatus ~= "cancelled" and newStatus ~= "failed" and newStatus ~= "timedout") then
    -- Show button when invite is accepted
    -- Look up the correct dungeon for THIS specific applicationID
    local d = pendingInvites[applicationID]
    if d then
      currentApplicationID = applicationID
      applyDungeon(d)
      -- Clear all pending invites since we joined a group
      pendingInvites = {}
    end
  elseif newStatus == "declined" or newStatus == "cancelled" or newStatus == "failed" or newStatus == "timedout" then
    -- Clear rate-limit entry regardless of key type
    nonMatchPrinted[applicationID or groupID] = nil
    -- Clear this specific pending invite
    pendingInvites[applicationID] = nil
    -- Only hide the button if this status change is for the CURRENT invitation
    -- When you apply to multiple dungeons and get invited to one, WoW cancels all other applications
    -- We don't want to hide the button when those OTHER applications get cancelled
    if applicationID == currentApplicationID then
      -- Clear all state since this invitation is done
      currentApplicationID = nil
      currentDungeon = nil
      currentSpellID = nil
      currentIconID = nil
      pendingApply = false
      pendingSecureUpdate = false
      suppressedByCombat = false
      btn:Hide()
    end
  end
end

function events:UNIT_SPELLCAST_SUCCEEDED(unit, _, spellID)
  if unit == "player" and currentSpellID and spellID == currentSpellID then
    -- Clear all state since we're done with this teleport
    currentApplicationID = nil
    currentDungeon = nil
    currentSpellID = nil
    currentIconID = nil
    pendingApply = false
    pendingSecureUpdate = false
    suppressedByCombat = false
    pendingInvites = {}
    btn:Hide()
  end
end

function events:SPELL_UPDATE_COOLDOWN()
  -- Only process if button is shown and we have a current spell
  if currentSpellID and btn:IsShown() then
    updateCooldown()
    if showGitGudUntil then
      local now = GetTime and GetTime() or 0
      if now < showGitGudUntil then
        local title = (currentDungeon and currentDungeon.name) or "Teleport"
        local known = isTeleportKnown(currentSpellID)
        overlayText:SetText("You have been invited to :\n|cff07f8ab" .. title .. "|r" .. getUnknownSuffix(known))
      end
    end
  end
end

function events:SPELLS_CHANGED()
  -- Only process if we have a current spell being tracked
  if not currentSpellID then return end

  if InCombatLockdown and InCombatLockdown() then
    pendingSecureUpdate = true
    -- Hide visuals to avoid interaction in combat
    btn:SetAlpha(0)
    suppressedByCombat = true
  else
    local known = isTeleportKnown(currentSpellID)
    if known then
      btn:SetAttribute("type", "spell")
      btn:SetAttribute("spell", currentSpellID)
    else
      btn:SetAttribute("type", nil)
      btn:SetAttribute("spell", nil)
    end
    updateKnownVisual()
    -- Refresh overlay text with red warning if needed
    local title = (currentDungeon and currentDungeon.name) or "Teleport"
    local suffix = getUnknownSuffix(known)
    overlayText:SetText("You have been invited to :\n|cff07f8ab" .. title .. "|r" .. suffix)
    -- Ensure any font changes apply to the live overlay
    applyFontFromDB()
  end
end

function events:PLAYER_REGEN_DISABLED()
  -- Combat started - auto-hide button if shown
  if btn:IsShown() and btn:GetAlpha() > 0 and currentDungeon then
    btn:SetAlpha(0)
    hiddenForCombat = true
  end
end

function events:PLAYER_REGEN_ENABLED()
  -- Combat ended - restore button if it was auto-hidden
  if hiddenForCombat then
    hiddenForCombat = false
    if currentDungeon and not userDismissed then
      btn:SetAlpha(1)
    end
  end

  -- Only process if we have pending updates or suppressed state
  if not (pendingApply or pendingSecureUpdate or suppressedByCombat) then
    -- Nothing else to do
  else
    -- Safe to apply any deferred secure updates now
    if pendingApply and currentDungeon then
      pendingApply = false
      applyDungeon(currentDungeon)
    end
    if pendingSecureUpdate and currentSpellID then
      pendingSecureUpdate = false
      local known = isTeleportKnown(currentSpellID)
      if known then
        btn:SetAttribute("type", "spell")
        btn:SetAttribute("spell", currentSpellID)
      else
        btn:SetAttribute("type", nil)
        btn:SetAttribute("spell", nil)
      end
    end
    if suppressedByCombat then
      suppressedByCombat = false
      btn:SetAlpha(1)
    end
  end
end

function events:GROUP_ROSTER_UPDATE()
  -- Check if player joined a group and we have pending invites
  -- This handles cases where the status change event doesn't fire properly
  if not currentDungeon then
    -- Check if we have any pending invites
    local appID, dungeon = next(pendingInvites)
    if appID and dungeon then
      -- Check if player is actually in a group now
      local inGroup = (IsInGroup and IsInGroup()) or (IsInRaid and IsInRaid())
      if inGroup then
        -- Player joined a group, show the button
        currentApplicationID = appID
        applyDungeon(dungeon)
        pendingInvites = {}
      end
    end
  end
end

f:SetScript("OnEvent", function(self, event, ...)
  if events[event] then
    events[event](events, ...)
  end
end)
