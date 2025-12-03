---@diagnostic disable: undefined-global
-- luacheck: globals CreateFrame UIParent DEFAULT_CHAT_FRAME SlashCmdList InCombatLockdown C_LFGList GameTooltip GetTime C_Spell LibStub Settings IsPlayerSpell

local ADDON_NAME, addon = ...

-- Development guard
if not CreateFrame or not UIParent then
  if print then print("[TPB] WoW API not available; skipping addon init.") end
  return
end

local DEFAULTS = {
  pos = { point = "CENTER", x = 0, y = 250 },
  size = { w = 50, h = 50 },
  locked = true,
  fontKey = nil,
  fontSize = 25,
  activityMap = {},
}

-- TPB_DB = TPB_DB or {} (Handled in ADDON_LOADED)

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

-- TWW S3 M+ dungeons
local DUNGEONS = {
  { name="Ara-Kara, City of Echoes", icon=5899326, spell=445417,  triggers={"ara-kara","ara kara","city of echoes","city of echo"} },
  { name="The Dawnbreaker",          icon=5899330, spell=445414,  triggers={"dawnbreaker","dawnbraker"} },
  { name="Tazavesh: Streets of Wonder", icon=4062727, spell=367416, triggers={"streets of wonder"} },
  { name="Tazavesh: So'leah's Gambit",  icon=4062727, spell=367416, triggers={"gambit","so'leah"} },
  { name="Priory of the Sacred Flame",  icon=5899331, spell=445444, triggers={"priory of the sacred flame"} },
  { name="Operation: Floodgate",        icon=6392629, spell=1216786, triggers={"operation floodgate","floodgate","flood gate"} },
  { name="Halls of Atonement",          icon=3601526, spell=354465, triggers={"halls of atonement","atonement"} },
  { name="Echo-dome Al'dari",           icon=6921877, spell=1237215, triggers={"echo-dome","echo dome","al'dari","al'dani","aldari","aldani"} },
}

-- Static Season 3 activityID -> dungeon index map
local ACTIVITY_TO_DUNGEON = {
  -- Exact GroupFinder activity IDs for Season 3 (Mythic Keystone) https://wago.tools/db2/GroupFinderActivity?build=11.2.0.62493&page=1&sort%5BFullName_lang%5D=asc
  [1016] = 3, -- Tazavesh: Streets of Wonder (Mythic Keystone)
  [1017] = 4, -- Tazavesh: So'leah's Gambit (Mythic Keystone)
  [1284] = 1, -- Ara-Kara, City of Echoes (Mythic Keystone)
  [1285] = 2, -- The Dawnbreaker (Mythic Keystone)
  [1281] = 5, -- Priory of the Sacred Flame (Mythic Keystone)
  [1550] = 6, -- Operation: Floodgate (Mythic Keystone)
  [1694] = 8, -- Eco/Echo-dome Al'dari (Mythic Keystone)
  [699]  = 7, -- Halls of Atonement (Mythic Keystone)
}

local function Print(msg)
  if DEFAULT_CHAT_FRAME then
    DEFAULT_CHAT_FRAME:AddMessage("|cff9be28f[TPB]|r "..tostring(msg))
  else
    print("[TPB] "..tostring(msg))
  end
end

-- Spell name helper compatible with modern API
local function getSpellName(spellID)
  if not spellID then return nil end
  if C_Spell and C_Spell.GetSpellInfo then
    local info = C_Spell.GetSpellInfo(spellID)
    return info and info.name or nil
  end
  return nil
end

-- Spell knowledge helper
local function isTeleportKnown(spellID)
  if not spellID then return false end
  -- Modern API check: IsSpellKnownOrOverridesKnown is generally preferred for player spells
  if C_Spell and C_Spell.IsSpellKnownOrOverridesKnown and C_Spell.IsSpellKnownOrOverridesKnown(spellID) then
    return true
  end
  -- Fallback to standard IsSpellKnown
  if C_Spell and C_Spell.IsSpellKnown and C_Spell.IsSpellKnown(spellID) then
    return true
  end
  -- Restore IsPlayerSpell: reliable for permanent account-wide spells/teleports
  if IsPlayerSpell and IsPlayerSpell(spellID) then
    return true
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
    if ACTIVITY_TO_DUNGEON and ACTIVITY_TO_DUNGEON[activityID] then
      return DUNGEONS[ACTIVITY_TO_DUNGEON[activityID]]
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
      if ACTIVITY_TO_DUNGEON and ACTIVITY_TO_DUNGEON[actId] then
        return DUNGEONS[ACTIVITY_TO_DUNGEON[actId]]
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

-- Secure button
---@diagnostic disable-next-line: redundant-parameter
local btn = CreateFrame("Button", "LFGTeleportButtonFrame", UIParent, "SecureActionButtonTemplate")
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
icon:Hide()

-- Cooldown overlay
---@diagnostic disable-next-line: redundant-parameter
local cd = CreateFrame("Cooldown", nil, btn, "CooldownFrameTemplate")
cd:SetAllPoints(btn)
-- Keep default swipe texture; some client builds error on nil swipes
cd:EnableMouse(false)
if cd.SetDrawEdge then cd:SetDrawEdge(false) end

-- Overlay border
local border = btn:CreateTexture(nil, "OVERLAY")
border:Hide()

-- Highlight handling
-- Only show strong highlight while pressing; use weaker border glow on hover
btn:SetHighlightTexture("")
btn:SetNormalTexture("")
btn:SetPushedTexture("Interface\\Buttons\\CheckButtonHilight")
do
  local pt = btn:GetPushedTexture()
  if pt and pt.SetBlendMode then pt:SetBlendMode("ADD") end
end

-- Text overlay
local FONT_PATH = "Interface\\AddOns\\LFGTeleportButton\\BebasNeue-Regular.ttf"
local overlayFont = CreateFont("LFGTeleportButtonOverlayFont")
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

-- Hover glow will be created after frameBorder is defined

-- Fixed-size 50x50 border centered on the button
local frameBorder = CreateFrame("Frame", nil, btn)
frameBorder:SetSize(50, 50)
frameBorder:SetPoint("CENTER", btn, "CENTER")
frameBorder:SetFrameStrata("HIGH")
frameBorder:SetFrameLevel(btn:GetFrameLevel() + 5)

local borderThickness = 2
local r, g, b, a = 0, 0, 0, 1

local topLine = frameBorder:CreateTexture(nil, "OVERLAY")
topLine:SetColorTexture(r, g, b, a)
topLine:SetPoint("TOPLEFT", frameBorder, "TOPLEFT", 0, 0)
topLine:SetPoint("TOPRIGHT", frameBorder, "TOPRIGHT", 0, 0)
topLine:SetHeight(borderThickness)

local bottomLine = frameBorder:CreateTexture(nil, "OVERLAY")
bottomLine:SetColorTexture(r, g, b, a)
bottomLine:SetPoint("BOTTOMLEFT", frameBorder, "BOTTOMLEFT", 0, 0)
bottomLine:SetPoint("BOTTOMRIGHT", frameBorder, "BOTTOMRIGHT", 0, 0)
bottomLine:SetHeight(borderThickness)

local leftLine = frameBorder:CreateTexture(nil, "OVERLAY")
leftLine:SetColorTexture(r, g, b, a)
leftLine:SetPoint("TOPLEFT", frameBorder, "TOPLEFT", 0, 0)
leftLine:SetPoint("BOTTOMLEFT", frameBorder, "BOTTOMLEFT", 0, 0)
leftLine:SetWidth(borderThickness)

local rightLine = frameBorder:CreateTexture(nil, "OVERLAY")
rightLine:SetColorTexture(r, g, b, a)
rightLine:SetPoint("TOPRIGHT", frameBorder, "TOPRIGHT", 0, 0)
rightLine:SetPoint("BOTTOMRIGHT", frameBorder, "BOTTOMRIGHT", 0, 0)
rightLine:SetWidth(borderThickness)
-- Match portal-buttons look: hide the custom border by default
frameBorder:Hide()

-- Hover glow
local hoverGlow = btn:CreateTexture(nil, "HIGHLIGHT")
hoverGlow:SetTexture("Interface\\Buttons\\CheckButtonHilight")
hoverGlow:SetAllPoints(btn)
hoverGlow:SetBlendMode("ADD")
-- Tint hover with rgba(146,171,255,255) and lower alpha while hovering
hoverGlow:SetVertexColor(146/255, 171/255, 255/255, 1)
hoverGlow:SetAlpha(0.6)
hoverGlow:Hide()

local currentDungeon   = nil
local currentSpellID   = nil
local currentApplicationID = nil  -- Track which application the button is showing for
local pendingApply     = false
local pendingSecureUpdate = false
local suppressedByCombat = false
local userDismissed = false
local notLearnedSoundPlayed = false
local showGitGudUntil = nil
local NOT_LEARNED_SFX = "Interface\\AddOns\\LFGTeleportButton\\SHaoKhanlaughing.mp3"
local currentIconID = nil
local pendingInviteDungeon = nil  -- Store dungeon info when invited, show button when accepted
local pendingInviteApplicationID = nil  -- Track which invitation is pending
local setLockedState

-- Helper: unknown-teleport suffix chooses between default warning and "Git Gud"
local function getUnknownSuffix(known)
  if known then return "" end
  local now = GetTime and GetTime() or 0
  if showGitGudUntil and now < showGitGudUntil then
    return "\n|cffff0000 Git Gud|r"
  end
  return "\n|cffff0000 No Teleport Yet|r"
end

-- LibSharedMedia support (optional)
local libstub = rawget(_G, "LibStub")
local lsm = libstub and libstub("LibSharedMedia-3.0", true) or nil

local function applyFontFromDB()
  local size = (addon.db and addon.db.fontSize) or DEFAULTS.fontSize
  local path = FONT_PATH
  if lsm and addon.db and addon.db.fontKey then
    local fetched = lsm:Fetch("font", addon.db.fontKey, true)
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

local applyPositionAndSizeFromDB

-- Options panel (canvas-based) with font selection via LibSharedMedia
local optionsPanel
local standaloneOptionsFrame
local standaloneLSMCallbacksHooked = false

local function EnsureStandaloneOptions()
  if standaloneOptionsFrame then
    standaloneOptionsFrame:Show()
    return
  end

  ---@diagnostic disable-next-line: redundant-parameter
  local frame = CreateFrame("Frame", "LFGTeleportButtonStandaloneOptions", UIParent)
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
  title:SetText("|TInterface\\AddOns\\LFGTeleportButton\\Media\\portal.blp:20|t LFG Teleport Button - Options")

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
  preview:SetTextColor(1,1,1)
  preview:SetText("You have been invited to :\nExample Dungeon\n|cffff0000 No Teleport Yet|r")

  local function refreshPreview()
    local size = 20
    local path = FONT_PATH
    if lsm and addon.db and addon.db.fontKey then
      local fetched = lsm:Fetch("font", addon.db.fontKey, true)
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

  local AceGUI_local = (libstub and libstub("AceGUI-3.0", true)) or rawget(_G, "AceGUI")
  local fontWidgetRefStandalone = nil
  local fontAnchor = label
  if AceGUI_local and AceGUI_local.Create then
    local fontWidget = AceGUI_local:Create("LSM30_Font")
    fontWidgetRefStandalone = fontWidget
    fontWidget:SetLabel("Font")
    if lsm and lsm.HashTable then
      fontWidget:SetList(lsm:HashTable("font"))
    end
    fontWidget:SetValue(addon.db.fontKey or "")
    fontWidget:SetCallback("OnValueChanged", function(widget, event, key)
      addon.db.fontKey = key ~= "" and key or nil
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
    sizeWidgetStandalone:SetValue((addon.db and addon.db.fontSize) or DEFAULTS.fontSize)
    local swf = sizeWidgetStandalone.frame
    swf:SetParent(frame)
    swf:ClearAllPoints()
    swf:SetPoint("TOP", fontAnchor, "BOTTOM", 0, -24)
    swf:SetWidth(300)
    swf:Show()
    sizeValueLabelStandalone = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    sizeValueLabelStandalone:SetPoint("TOP", swf, "BOTTOM", 0, -4)
    sizeValueLabelStandalone:SetText(tostring((addon.db and addon.db.fontSize) or DEFAULTS.fontSize))
    sizeWidgetStandalone:SetCallback("OnValueChanged", function(widget, event, value)
      value = tonumber(value) or ((addon.db and addon.db.fontSize) or DEFAULTS.fontSize)
      value = math.floor(value + 0.5)
      addon.db.fontSize = value
      if sizeValueLabelStandalone then sizeValueLabelStandalone:SetText(tostring(value)) end
      applyFontFromDB()
    end)
  else
    ---@diagnostic disable-next-line: redundant-parameter
    sizeSliderStandalone = CreateFrame("Slider", "LFGTeleportButtonFontSizeSlider", frame, "OptionsSliderTemplate")
    sizeSliderStandalone:SetPoint("TOP", fontAnchor, "BOTTOM", 0, -24)
    sizeSliderStandalone:SetMinMaxValues(8, 72)
    sizeSliderStandalone:SetObeyStepOnDrag(true)
    sizeSliderStandalone:SetValueStep(1)
    sizeSliderStandalone:SetWidth(240)
    _G[sizeSliderStandalone:GetName()..'Low']:SetText('8')
    _G[sizeSliderStandalone:GetName()..'High']:SetText('72')
    _G[sizeSliderStandalone:GetName()..'Text']:SetText('Font Size')
    sizeSliderStandalone:SetScript("OnValueChanged", function(self, value)
      value = math.floor(value + 0.5)
      addon.db.fontSize = value
      applyFontFromDB()
    end)
    sizeValueLabelStandalone = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    sizeValueLabelStandalone:SetPoint("TOP", sizeSliderStandalone, "BOTTOM", 0, -4)
    sizeValueLabelStandalone:SetText(tostring((addon.db and addon.db.fontSize) or DEFAULTS.fontSize))
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
    addon.db.pos.point = DEFAULTS.pos.point
    addon.db.pos.x = DEFAULTS.pos.x
    addon.db.pos.y = DEFAULTS.pos.y
    if type(applyPositionAndSizeFromDB) == "function" then
      applyPositionAndSizeFromDB()
    else
      btn:SetSize(addon.db.size.w, addon.db.size.h)
      btn:ClearAllPoints()
      btn:SetPoint(addon.db.pos.point, UIParent, addon.db.pos.point, addon.db.pos.x, addon.db.pos.y)
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
      sizeWidgetStandalone:SetValue((addon.db and addon.db.fontSize) or DEFAULTS.fontSize)
      if sizeValueLabelStandalone then sizeValueLabelStandalone:SetText(tostring((addon.db and addon.db.fontSize) or DEFAULTS.fontSize)) end
    elseif sizeSliderStandalone and sizeSliderStandalone.SetValue then
      sizeSliderStandalone:SetValue((addon.db and addon.db.fontSize) or DEFAULTS.fontSize)
      if sizeValueLabelStandalone then sizeValueLabelStandalone:SetText(tostring((addon.db and addon.db.fontSize) or DEFAULTS.fontSize)) end
    end
    if fontWidgetRefStandalone and fontWidgetRefStandalone.SetValue then
      fontWidgetRefStandalone:SetValue(addon.db.fontKey or "")
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
  optionsPanel = CreateFrame("Frame", "LFGTeleportButtonOptionsPanel")
  local displayName = "|TInterface\\AddOns\\LFGTeleportButton\\Media\\portal.blp:16|t LFG Teleport Button"
  optionsPanel.name = displayName

  -- Only a single button that opens the standalone options
  ---@diagnostic disable-next-line: redundant-parameter
  local openStandaloneBtn = CreateFrame("Button", nil, optionsPanel, "UIPanelButtonTemplate")
  openStandaloneBtn:SetPoint("CENTER", optionsPanel, "CENTER", 0, 0)
  openStandaloneBtn:SetSize(200, 48)
  openStandaloneBtn:SetText("Open Config")
  do
    local fs = openStandaloneBtn:GetFontString()
    if fs and fs.GetFont then
      local fontPath, fontSize, fontFlags = fs:GetFont()
      local newSize = math.floor((fontSize or 14) * 2)
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
    -- If Settings API is missing (very old client), we just print a warning or do nothing
    -- as we are strictly targeting modern retail.
    print("[TPB] Settings API not found. Options panel not registered.")
  end
end

local function updateMovable()
  -- Allow dragging only when CTRL is held while left-dragging
  btn:SetScript("OnDragStart", function(self)
    if IsControlKeyDown and IsControlKeyDown() and not InCombatLockdown() then
      self:StartMoving()
    end
  end)
  btn:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    local p, _, _, x, y = self:GetPoint()
    addon.db.pos.point = p; addon.db.pos.x = x; addon.db.pos.y = y
  end)
end

function setLockedState(newLocked)
  -- No-op: locking removed. Keep for backward compatibility.
  updateMovable()
  Print("Drag with CTRL + Left Mouse. Lock option removed.")
end

-- ALT + Right Click: hide
btn:SetScript("OnMouseUp", function(self, mouseButton)
  -- Play a one-time sound per login if user clicks an unlearned portal
  if mouseButton == "LeftButton" then
    if currentSpellID and not isTeleportKnown(currentSpellID) and not notLearnedSoundPlayed then
      if PlaySoundFile then
        PlaySoundFile(NOT_LEARNED_SFX, "Master")
      end
      notLearnedSoundPlayed = true
      -- Show Git Gud for 5 seconds
      if GetTime then showGitGudUntil = GetTime() + 5 end
      -- Update overlay to reflect the new message once the sound condition is met
      local title = (currentDungeon and currentDungeon.name) or "Teleport"
      overlayText:SetText("You have been invited to :\n|cff07f8ab" .. title .. "|r" .. getUnknownSuffix(false))
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
    pendingInviteDungeon = nil
    pendingInviteApplicationID = nil
    if InCombatLockdown and InCombatLockdown() then
      -- Avoid protected Show/Hide in combat; fade out instead
      self:SetAlpha(0)
      suppressedByCombat = true
    else
      self:Hide()
    end
  end
end)

-- Time formatting for tooltip cooldown
local function formatCooldown(seconds)
  if not seconds or seconds <= 0 then return nil end
  local hours = math.floor(seconds / 3600)
  local minutes = math.floor((seconds % 3600) / 60)
  local secs = math.floor(seconds % 60)
  return string.format("%02d:%02d:%02d", hours, minutes, secs)
end

-- Show simple tooltip with usage instructions
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
  local start, duration

  if C_Spell and C_Spell.GetSpellCooldown then
    local info = C_Spell.GetSpellCooldown(currentSpellID)
    if info then start, duration = info.startTime, info.duration end
  end
  if start and duration and duration > 1.5 then
    cd:SetCooldown(start, duration)
  else
    if cd.Clear then
      cd:Clear()
    end
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

  icon:SetTexture(d.icon)
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
  btn:SetPoint(addon.db.pos.point, UIParent, addon.db.pos.point, addon.db.pos.x, addon.db.pos.y)
  btn:SetSize(addon.db.size.w, addon.db.size.h)
  btn:Show()
  local known = isTeleportKnown(currentSpellID)
  local overlayTitle = (d.name or "Teleport")
  local suffix = getUnknownSuffix(known)
  overlayText:SetText("You have been invited to :\n|cff07f8ab" .. overlayTitle .. "|r" .. suffix)
  -- Use the ARTWORK texture for the icon (normal texture is kept blank)
  local spellInfo = C_Spell and C_Spell.GetSpellInfo and C_Spell.GetSpellInfo(currentSpellID)
  local iconID = spellInfo and spellInfo.iconID or d.icon
  if iconID then
    currentIconID = iconID
    icon:SetTexture(iconID)
    icon:Show()
  end
  Print("Teleport ready: "..(d.name or "unknown"))
end

-- Slash: /tpbutton lock  (toggle)
SLASH_TPBUTTON1 = "/tpbutton"
-- Forward declaration defined earlier; do not redeclare here
-- local applyPositionAndSizeFromDB

SlashCmdList.TPBUTTON = function(msg)
  msg = (msg or ""):gsub("^%s+", ""):gsub("%s+$","")
  local lower = msg:lower()

  if lower == "lock" then
    addon.db.locked = not addon.db.locked
    updateMovable()
    Print(addon.db.locked and "Locked (cannot drag)" or "Unlocked (drag with left mouse)")

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
      Print("Usage: /tpbutton test N  (N=1-"..#DUNGEONS..")")
      for i, d in ipairs(DUNGEONS) do
        local known = isTeleportKnown(d.spell)
        local spellName = getSpellName(d.spell)
        Print(i..": "..d.name.." (spell: "..tostring(d.spell)..", known: "..tostring(known)..", spellName: "..(spellName or "nil")..")")
      end
    end
  
  elseif lower == "debug" then
    Print("=== Dungeon Debug Info ===")
    for i, d in ipairs(DUNGEONS) do
      local known = isTeleportKnown(d.spell)
      local spellName = getSpellName(d.spell)
      Print(i..": "..d.name)
      Print("  Spell ID: "..tostring(d.spell))
      Print("  -> isTeleportKnown: "..tostring(known))
      if C_Spell and C_Spell.IsSpellKnownOrOverridesKnown then
        Print("  -> C_Spell.IsSpellKnownOrOverridesKnown: "..tostring(C_Spell.IsSpellKnownOrOverridesKnown(d.spell)))
      end
      if IsPlayerSpell then
        Print("  -> IsPlayerSpell: "..tostring(IsPlayerSpell(d.spell)))
      end
      Print("  -> Name: "..(spellName or "nil"))
      Print("  -> Icon: "..tostring(d.icon))
    end
    Print("=== Activity Mappings ===")
    for activityID, dungeonIndex in pairs(ACTIVITY_TO_DUNGEON) do
      local d = DUNGEONS[dungeonIndex]
      Print("Activity "..activityID.." -> "..(d and d.name or "INVALID INDEX "..dungeonIndex))
    end

  elseif lower == "reset" then
    addon.db.pos.point = DEFAULTS.pos.point
    addon.db.pos.x = DEFAULTS.pos.x
    addon.db.pos.y = DEFAULTS.pos.y
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
    Print("Commands: /tpbutton lock | /tpbutton show | /tpbutton test N | /tpbutton debug | /tpbutton reset | /tpbutton state")
  end
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
f:RegisterEvent("GROUP_ROSTER_UPDATE")

applyPositionAndSizeFromDB = function()
  btn:SetSize(addon.db.size.w, addon.db.size.h)
  btn:ClearAllPoints()
  btn:SetPoint(addon.db.pos.point, UIParent, addon.db.pos.point, addon.db.pos.x, addon.db.pos.y)
end

local nonMatchPrinted = {}

f:SetScript("OnEvent", function(self, event, ...)
  if event == "ADDON_LOADED" then
    local name = ...
    if name == ADDON_NAME then
      TPB_DB = mergeDefaults(TPB_DB, DEFAULTS)
      addon.db = TPB_DB
      -- Always start locked on load
      addon.db.locked = true
      updateMovable()
    end

  elseif event == "PLAYER_LOGIN" then
    applyPositionAndSizeFromDB()
    applyFontFromDB()
    InitOptionsPanel()
    -- Reset per-login sound flag
    notLearnedSoundPlayed = false

  elseif event == "LFG_LIST_APPLICATION_STATUS_UPDATED" then
    -- (applicationID, newStatus, oldStatus, groupID)
    local applicationID, newStatus, oldStatus, groupID = ...
    if newStatus == "invited" then
      -- Store dungeon info when invited, but don't show button yet
      -- Reset user dismissal state for new invitations
      userDismissed = false
      -- Store this applicationID so we know which invitation the button is for
      pendingInviteApplicationID = applicationID
      local info
      -- Prefer resolving via applicationID → searchResultID → info
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
        -- Store dungeon info but don't show button yet - wait for acceptance
        pendingInviteDungeon = d
      else
        -- Rate-limit non-match prints using applicationID when available
        local key = applicationID or groupID or "unknown"
        if not nonMatchPrinted[key] then
          nonMatchPrinted[key] = true
          Print("Listing did not match a TWW S3 dungeon; button not shown.")
        end
        pendingInviteDungeon = nil
        pendingInviteApplicationID = nil
      end
    elseif newStatus == "inviteAccepted" or (oldStatus == "invited" and newStatus ~= "invited" and newStatus ~= "declined" and newStatus ~= "cancelled" and newStatus ~= "failed" and newStatus ~= "timedout") then
      -- Show button when invite is accepted
      -- Check if we have a pending invite for this application
      if pendingInviteDungeon and (not applicationID or applicationID == pendingInviteApplicationID) then
        currentApplicationID = pendingInviteApplicationID
        applyDungeon(pendingInviteDungeon)
        pendingInviteDungeon = nil
        pendingInviteApplicationID = nil
      end
    elseif newStatus == "declined" or newStatus == "cancelled" or newStatus == "failed" or newStatus == "timedout" then
      -- Clear rate-limit entry regardless of key type
      nonMatchPrinted[applicationID or groupID] = nil
      -- Clear pending invite if this is the one we were tracking
      if applicationID == pendingInviteApplicationID then
        pendingInviteDungeon = nil
        pendingInviteApplicationID = nil
      end
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

  elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
    local unit, _, spellID = ...
    if unit == "player" and currentSpellID and spellID == currentSpellID then
      -- Clear all state since we're done with this teleport
      currentApplicationID = nil
      currentDungeon = nil
      currentSpellID = nil
      currentIconID = nil
      pendingApply = false
      pendingSecureUpdate = false
      suppressedByCombat = false
      pendingInviteDungeon = nil
      pendingInviteApplicationID = nil
      btn:Hide()
    end

  elseif event == "SPELL_UPDATE_COOLDOWN" then
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

  elseif event == "SPELLS_CHANGED" then
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

  elseif event == "PLAYER_REGEN_ENABLED" then
    -- Only process if we have pending updates or suppressed state
    if not (pendingApply or pendingSecureUpdate or suppressedByCombat) then
      return  -- Nothing to do, exit early
    end
    
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

  elseif event == "GROUP_ROSTER_UPDATE" then
    -- Check if player joined a group and we have a pending invite
    -- This handles cases where the status change event doesn't fire properly
    if pendingInviteDungeon and not currentDungeon then
      -- Check if player is actually in a group now
      local inGroup = false
      if IsInGroup and IsInGroup() then
        inGroup = true
      elseif IsInRaid and IsInRaid() then
        inGroup = true
      end
      
      if inGroup then
        -- Player joined a group, show the button
        currentApplicationID = pendingInviteApplicationID
        applyDungeon(pendingInviteDungeon)
        pendingInviteDungeon = nil
        pendingInviteApplicationID = nil
      end
    end
  end
end)


