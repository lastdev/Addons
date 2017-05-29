local DS = LibStub("AceAddon-3.0"):GetAddon("Doom Shards", true)
if not DS then return end

local CD = DS:NewModule("display", "AceEvent-3.0")
local LSM = LibStub("LibSharedMedia-3.0")


--------------
-- Upvalues --
--------------
local GetSpellInfo = GetSpellInfo
local GetTime = GetTime
local math_huge = math.huge
local mathmax = math.max
local stringformat = string.format
local table_sort = table.sort
local wipe = wipe


------------
-- Frames --
------------
local CDFrame = DS:CreateParentFrame("DoomShardsDisplay", "display")
CD.frame = CDFrame
CDFrame:Hide()
local basePositions = {}
local resourceFrames = {}
local fontStringParent
local SATimers = {}
local statusbars = {}
local CDOnUpdateFrame = CreateFrame("frame", nil, UIParent)
CDOnUpdateFrame:Hide()


---------------
-- Constants --
---------------
local MAX_RESOURCE = 5
local backdrop = {
  bgFile = nil,
  edgeFile = nil,
  tile = false,
  edgeSize = 0
}
local statusbarBackdrop = {
  bgFile = nil,
  edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
  tile = false,
  edgeSize = 1
}
local borderBackdrop = {
  bgFile = nil,
  edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
  tile = false,
  edgeSize = 1
}


---------------
-- Variables --
---------------
local auras
local consolidateTicks
local db
local gainFlash
local nextCast
local referenceSpell
local referenceTime
local resourceCappedEnable
local resource
local remainingTimeThreshold
local resourceFromCurrentCast
local resourceGainPrediction
local resourceSpendIncludeHoG
local resourceSpendPrediction
local resourceGeneration
local statusbarCount
local statusbarEnable
local statusbarRefresh
local textEnable
local timeStamp
local visibilityConditionals = ""


-------------
-- Utility --
-------------
local getHasteMod = DS.GetHasteMod


---------------
-- Functions --
---------------
function CD:GetReferenceSpellCastingTime()
  if referenceTime then
    return (nextCast and (nextCast - GetTime()) or 0) + referenceTime * getHasteMod()
  else
    local _, _, _, castingTime = GetSpellInfo(referenceSpell)
    return (nextCast and (nextCast - GetTime()) or 0) + castingTime / 1000
  end
end

do
  local function sortFunc(a, b)
    return a.tick < b.tick
  end

  local tblCache = {}
  local function getRecycledTbl()
    local tblCacheLength = #tblCache
    if tblCacheLength > 0 then
      local tbl = tblCache[tblCacheLength]
      tblCache[tblCacheLength] = nil
      return tbl
    else
      return {}
    end
  end

  local function storeRecycleTbl(tbl)
    tblCache[#tblCache+1] = tbl
  end

  local orderedTbl = {}
  local consolidatedTbl = {}
  function CD:BuildSortedAuraIndicators()
    local i = 0
    for GUID, tbl in pairs(auras) do
      for spellID, aura in pairs(tbl) do
        local tick, resourceChance, isLastTick
        repeat
          i = i + 1
          tick, resourceChance, isLastTick = aura:IterateTick(tick)
          orderedTbl[i] = orderedTbl[i] or getRecycledTbl()
          orderedTbl[i].tick = tick
          orderedTbl[i].resourceChance = resourceChance
          orderedTbl[i].aura = aura
        until isLastTick or i > 100
      end
    end
    for k = i+1, #orderedTbl do
      storeRecycleTbl(orderedTbl[k])
      orderedTbl[k] = nil
    end
    table_sort(orderedTbl, sortFunc)

    if consolidateTicks then
      for k, v in ipairs(consolidatedTbl) do
        consolidatedTbl[k] = nil
      end
      i = 1
      local chance = 0
      for k, indicator in ipairs(orderedTbl) do
        chance = chance + indicator.resourceChance
        if chance >= 1 then
          consolidatedTbl[i] = indicator
          indicator.resourceChance = chance
          i = i + 1
          chance = 0
        end
      end
      return consolidatedTbl
    else
      return orderedTbl
    end
  end
end

function CD:UpdateResource(frame, active, coloring)
  if active then
    if coloring == "spending" then
      frame:SetSpendColor()
    elseif coloring == "capped" then
      frame:SetCapColor()
    else
      frame:SetOriginalColor()
    end
    if not frame.active then
      frame:Show()
      if gainFlash then
        frame.flasher:Play()
      end
      frame.active = true
    end
  else
    if frame.flasher:IsPlaying() then
      frame.flasher:Stop()
    end
    frame:Hide()
    frame.active = false
  end
end

function CD:UpdateResourceGainPrediction(frame)  -- Must not play animations
  frame:Show()
  frame:SetGainColor()
end

function CD:UpdateHoGPrediction(frame)  -- Must not play animations  -- TODO: maybe add another color (yellow) for another GCD before this one
  frame:Show()
  frame:SetSpendColor()
end

function CD:UpdateDoomPrediction(position, indicator)
  if indicator then
    if textEnable then
      local SATimer = SATimers[position]
      SATimer:SetTimer(indicator)
      SATimer:Show()
    end
    if statusbarEnable then
      local statusbar = statusbars[position]
      statusbar:SetTimer(indicator)
      statusbar:Show()
    end
  else
    if textEnable then
      SATimers[position]:Hide()
    end
    if statusbarEnable then
      statusbars[position]:Hide()
    end
  end
end

function CD:Update()
  if not DS.locked then
    return
  end

  local indicators = self:BuildSortedAuraIndicators()
  CD.indicators = indicators  -- For WeakAuras methods

  -- Shards
  local spendThreshold = resource + ((resourceSpendPrediction and resourceGeneration < 0) and resourceGeneration or 0)
  for i = 1, MAX_RESOURCE do
    if resourceEnable then
      self:UpdateResource(resourceFrames[i], i <= resource, i > spendThreshold and "spending" or (resourceCappedEnable and resource == MAX_RESOURCE) and "capped" or nil)
    end
    self:UpdateDoomPrediction(i, false)
  end

  -- Show shard spending for doom prediction in timeframe of currently cast spender
  if resourceEnable and resourceSpendIncludeHoG and nextCast then
    local additionalResources = - resource - resourceGeneration
    if additionalResources > 0 then
      for t = 1, additionalResources do
        local indicator = indicators[t]
        if indicator then
          if indicator.tick < nextCast then
            CD:UpdateHoGPrediction(resourceFrames[resource + t])
          else
            break
          end

        else
          break

        end
      end
    end
  end

  -- Doom prediction
  local generatedResource
  local castEnd
  if resourceGainPrediction then
    generatedResource = resourceGeneration > 0 and resourceGeneration
    castEnd = generatedResource and nextCast or nil
  end
  local t = 1
  local indicator = indicators[t]
  for i = resource + 1, statusbarCount do
    if resourceGainPrediction and castEnd and (not indicator or castEnd < indicator.tick) then
      if resourceEnable and i <= MAX_RESOURCE then
        self:UpdateResourceGainPrediction(resourceFrames[i])
      end
      self:UpdateDoomPrediction(i, false)
      generatedResource = generatedResource - 1
      if generatedResource <= 0 then
        castEnd = nil
      end

    else
      self:UpdateDoomPrediction(i, indicator)
      t = t + 1
      indicator = indicators[t]

    end
  end
end

function CD:DOOM_SHARDS_UPDATE()
  timeStamp = DS.timeStamp
  resource = DS.resource
  auras = DS.auras
  resourceGeneration = DS.generating
  nextCast = DS.nextCast

  self:Update()
  self:SendMessage("DOOM_SHARDS_DISPLAY_UPDATE", "test")
end

local function SATimerOnUpdate(self, elapsed)
  self.elapsed = self.elapsed + elapsed
  self.remaining = self.remaining - elapsed
  if self.elapsed > 0.1 then
    local remaining = self.remaining
    if remaining < remainingTimeThreshold then
      self.fontString:SetText(stringformat("%.1f", remaining < 0 and 0 or remaining))
    else
      self.fontString:SetText(stringformat("%.0f", remaining))
    end
    if remaining < CD:GetReferenceSpellCastingTime() then
      if not self.fontString.hogColored then
        self.fontString:SetHoGColor()
      end
    else
      if self.fontString.hogColored then
        self.fontString:SetOriginalColor()
      end
    end
    self.elapsed = 0
  end
end

local function statusbarOnUpdate(statusbar, elapsed)
  statusbar.remaining = statusbar.remaining - elapsed
  statusbar.elapsed = statusbar.elapsed + elapsed
  if statusbar.elapsed > statusbar.refresh then
    statusbar.statusbar:SetValue(statusbar.maxTime - (statusbar.remaining < 0 and 0 or statusbar.remaining))  -- check for < 0 necessary?
    statusbar.elapsed = 0
  end
end


----------------
-- Visibility --
----------------
do
  -- can't use RegisterStateDriver because Restricted Environment doesn't allow for animations
  local currentState = "hide"

  function CDOnUpdateFrame:EvaluateConditionals()
    local state = SecureCmdOptionParse(visibilityConditionals)
    if state ~= currentState then
      if state == "hide" then
        CDFrame.fader:Stop()
        CDFrame:SetAlpha(0)
        currentState = "hide"

      elseif state == "fade" and currentState ~= "hide" then
        CDFrame.fader:Play()
        currentState = "hide"

      elseif state ~= "fade" then  -- show
        CDFrame.fader:Stop()
        CDFrame:SetAlpha(1)
        currentState = "show"

      end
    end
  end

  local ticker = 0
  CDOnUpdateFrame:SetScript("OnUpdate", function(self, elapsed)
    ticker = ticker + elapsed
    if ticker > 0.2 then
      self:EvaluateConditionals()
      ticker = 0
    end
  end)

  CDOnUpdateFrame:SetScript("OnShow", function(self)
    currentState = nil
    self:EvaluateConditionals()
    self:RegisterEvents()
  end)

  CDOnUpdateFrame:SetScript("OnHide", function(self)
    self:UnregisterEvents()
  end)

  CDOnUpdateFrame:SetScript("OnEvent", function(self)
    self:EvaluateConditionals()
  end)

  function CDOnUpdateFrame:RegisterEvents()
    self:RegisterEvent("MODIFIER_STATE_CHANGED")
    self:RegisterEvent("PLAYER_REGEN_DISABLED")
    self:RegisterEvent("PLAYER_TARGET_CHANGED")
  end

  function CDOnUpdateFrame:UnregisterEvents()
    self:UnregisterAllEvents()
  end
end


----------------
-- Animations --
----------------
local function buildFader()
  CDFrame.fader = CDFrame.fader or CDFrame:CreateAnimationGroup()
  CDFrame.fader:SetScript("OnPlay", function()
    CDFrame:StopAnimating()
  end)
  CDFrame.fader:SetScript("OnFinished", function()
    CDFrame:SetAlpha(0)
  end)
  CDFrame.fader.fadeOut = CDFrame.fader:CreateAnimation("Alpha")
  CDFrame.fader.fadeOut:SetFromAlpha(1)
  CDFrame.fader.fadeOut:SetToAlpha(0)
  CDFrame.fader.fadeOut:SetDuration(db.fadeOutDuration)
  CDFrame.fader.fadeOut:SetSmoothing("IN")
end

local function buildFlasher(parentFrame)
  local smoke = parentFrame.smoke
  if not smoke then
    parentFrame.smoke = CreateFrame("frame", "$parentSmoke", parentFrame)
    smoke = parentFrame.smoke
    smoke:SetBackdrop(backdrop)
    smoke:SetBackdropColor(1, 1, 1, 1)
    smoke:SetAllPoints()
    smoke:SetAlpha(0)
    smoke:Show()
  end

  parentFrame.flasher = smoke:CreateAnimationGroup()
  local function hideSmoke()
    smoke:SetAlpha(0)
  end
  parentFrame.flasher:SetScript("OnFinished", hideSmoke)

  parentFrame.flasher.start = parentFrame.flasher:CreateAnimation("Alpha")
  parentFrame.flasher.start:SetFromAlpha(0)
  parentFrame.flasher.start:SetToAlpha(0.5)
  parentFrame.flasher.start:SetDuration(0.2)
  parentFrame.flasher.start:SetOrder(1)

  parentFrame.flasher.out = parentFrame.flasher:CreateAnimation("Alpha")
  parentFrame.flasher.out:SetFromAlpha(0.5)
  parentFrame.flasher.out:SetToAlpha(0)
  parentFrame.flasher.out:SetDuration(0.3)
  parentFrame.flasher.out:SetOrder(2)
end


-------------
-- Visuals --
-------------
local function buildFrames()
  local orientation = db.orientation
  local growthDirection = db.growthDirection
  local height = db.height
  local width = db.width
  local flags = db.fontFlags
  local stringXOffset = db.stringXOffset
  local stringYOffset = db.stringYOffset
  local statusbarXOffset = db.statusbarXOffset
  local statusbarYOffset = db.statusbarYOffset
  backdrop.bgFile = (not db.useTexture or db.textureHandle == "Empty") and "Interface\\ChatFrame\\ChatFrameBackground" or LSM:Fetch("statusbar", db.textureHandle)
  statusbarBackdrop.bgFile = (not db.useTexture or db.textureHandle == "Empty") and "Interface\\ChatFrame\\ChatFrameBackground" or LSM:Fetch("statusbar", db.textureHandle)

  local CDFrameHeight = db.height + 25
  local CDFrameWidth = statusbarCount * db.width + (statusbarCount - 1) * db.spacing
  CDFrame:ClearAllPoints()
  CDFrame:SetPoint(db.anchor, _G[db.anchorFrame], db.posX, db.posY)
  CDFrame:SetHeight(db.orientation == "Vertical" and CDFrameWidth or CDFrameHeight)
  CDFrame:SetWidth(db.orientation == "Vertical" and CDFrameHeight or CDFrameWidth)

  if growthDirection == "Reversed" then
    stringXOffset = -1 * stringXOffset
  end

  do
    for i = 1, statusbarCount do
      basePositions[i] = (width + db.spacing) * (i - 1)
    end
  end

  if resourceEnable then
    local function createResourceFrame(numeration)
      local frame = resourceFrames[numeration] or CreateFrame("frame", "$parentResource", CDFrame)
      frame:ClearAllPoints()
      if orientation == "Vertical" then
        frame:SetHeight(width)
        frame:SetWidth(height)
        if growthDirection == "Reversed" then
          frame:SetPoint("TOPRIGHT", 0, -basePositions[numeration])
        else
          frame:SetPoint("BOTTOMRIGHT", 0, basePositions[numeration])
        end
      else
        frame:SetHeight(height)
        frame:SetWidth(width)
        if growthDirection == "Reversed" then
          frame:SetPoint("BOTTOMRIGHT", -basePositions[numeration], 0)
        else
          frame:SetPoint("BOTTOMLEFT", basePositions[numeration], 0)
        end
      end

      frame:SetBackdrop(backdrop)

      if numeration <= MAX_RESOURCE then
        frame:Show()

        if not frame.border then
          frame.border = CreateFrame("frame", "$parentBorder", frame)
        end
        frame.border:SetAllPoints(frame)
        frame.border:SetBackdrop(borderBackdrop)
        frame.border:SetBackdropBorderColor(db.borderColor.r, db.borderColor.b, db.borderColor.g, db.borderColor.a)

        local color = db["color"..numeration]
        local cr, cb, cg, ca = color.r, color.b, color.g, color.a
        function frame:SetOriginalColor()
          self:SetBackdropColor(cr, cb, cg, ca)
        end
        frame:SetOriginalColor()

        CDFrame.emptyResources = CDFrame.emptyResources or {}
        if db.alwaysShowBorders then
          if not CDFrame.emptyResources[numeration] then
            CDFrame.emptyResources[numeration] = CreateFrame("frame", "$parentBorderParent", CDFrame)
          end
          local emptyResourceFrame = CDFrame.emptyResources[numeration]
          emptyResourceFrame:Show()
          emptyResourceFrame:SetAllPoints(frame)
          emptyResourceFrame:SetFrameLevel(frame:GetFrameLevel() - 1)
          emptyResourceFrame:SetBackdrop(frame:GetBackdrop())
          local emptyColor = db.emptyColor
          emptyResourceFrame:SetBackdropColor(emptyColor.r, emptyColor.b, emptyColor.g, emptyColor.a)
          if not emptyResourceFrame.border then
            emptyResourceFrame.border = CreateFrame("frame", "$parentBorder", emptyResourceFrame)
          end
          emptyResourceFrame.border:SetAllPoints(emptyResourceFrame)
          emptyResourceFrame.border:SetBackdrop(borderBackdrop)
          emptyResourceFrame.border:SetBackdropBorderColor(db.borderColor.r, db.borderColor.b, db.borderColor.g, db.borderColor.a)
        else
          if CDFrame.emptyResources[numeration] then
            CDFrame.emptyResources[numeration]:Hide()
          end
        end

      else
        frame:Hide()
        frame:SetBackdropColor(0, 0, 0, 0)  -- dummy frame to anchor overflow fontstring to
      end

      local c3r, c3b, c3g, c3a = db.resourceCappedColor.r, db.resourceCappedColor.b, db.resourceCappedColor.g, db.resourceCappedColor.a
      function frame:SetCapColor()
        self:SetBackdropColor(c3r, c3b, c3g, c3a)
      end

      local c4r, c4b, c4g, c4a = db.resourceSpendColor.r, db.resourceSpendColor.b, db.resourceSpendColor.g, db.resourceSpendColor.a
      function frame:SetSpendColor()
        self:SetBackdropColor(c4r, c4b, c4g, c4a)
      end

      local c5r, c5b, c5g, c5a = db.resourceGainColor.r, db.resourceGainColor.b, db.resourceGainColor.g, db.resourceGainColor.a
      function frame:SetGainColor()
        self:SetBackdropColor(c5r, c5b, c5g, c5a)
      end

      buildFlasher(frame)

      frame.active = true

      return frame
    end
    for i = 1, statusbarCount do
      resourceFrames[i] = createResourceFrame(i)
    end

  else
    for i = 1, #resourceFrames do
      resourceFrames[i]:Hide()
    end
  end

  if textEnable then
    local function createTimerFontString(numeration)
      local parentFrame
      local fontString
      if not SATimers[numeration] then
        parentFrame = SATimers[numeration] or CreateFrame("frame", "$parentTextParent", CDFrame)
        parentFrame:SetFrameStrata("MEDIUM")
        parentFrame:Show()
        fontString = parentFrame:CreateFontString(nil, "OVERLAY")
        parentFrame.fontString = fontString
      else
        parentFrame = SATimers[numeration]
        fontString = parentFrame.fontString
      end

      parentFrame:ClearAllPoints()
      if orientation == "Vertical" then
        parentFrame:SetHeight(width)
        parentFrame:SetWidth(height)
        if growthDirection == "Reversed" then
          parentFrame:SetPoint("TOPRIGHT", -height - stringYOffset - 1, -basePositions[numeration] - stringXOffset)
        else
          parentFrame:SetPoint("BOTTOMRIGHT", -height - stringYOffset - 1, basePositions[numeration] + stringXOffset)
        end
      else
        parentFrame:SetWidth(width)
        parentFrame:SetHeight(height)
        if growthDirection == "Reversed" then
          parentFrame:SetPoint("BOTTOMRIGHT", -basePositions[numeration] - stringXOffset, height + stringYOffset + 1)
        else
          parentFrame:SetPoint("BOTTOMLEFT", basePositions[numeration] + stringXOffset, height + stringYOffset + 1)
        end
      end

      fontString:ClearAllPoints()
      if orientation == "Vertical" then
        fontString:SetPoint("RIGHT")
      else
        fontString:SetPoint("BOTTOM")
      end

      fontString:SetFont(LSM:Fetch("font", db.fontName), db.fontSize, (flags == "MONOCHROMEOUTLINE" or flags == "OUTLINE" or flags == "THICKOUTLINE") and flags or nil)
      fontString:SetShadowOffset(1, -1)
      fontString:SetShadowColor(0, 0, 0, db.fontFlags == "Shadow" and 1 or 0)

      local c1r, c1b, c1g, c1a = db.fontColor.r, db.fontColor.b, db.fontColor.g, db.fontColor.a
      function fontString:SetOriginalColor()
        self:SetTextColor(c1r, c1b, c1g, c1a)
        self.hogColored = false
      end
      local c2r, c2b, c2g, c2a = db.fontColorHoGPrediction.r, db.fontColorHoGPrediction.b, db.fontColorHoGPrediction.g, db.fontColorHoGPrediction.a
      function fontString:SetHoGColor()
        self:SetTextColor(c2r, c2b, c2g, c2a)
        self.hogColored = true
      end

      parentFrame.elapsed = 0
      parentFrame.remaining = 0
      function parentFrame:SetTimer(indicator)
        self.remaining = indicator.tick - GetTime()
        self.elapsed = 1
        self:Show()
      end
      parentFrame:SetScript("OnUpdate", SATimerOnUpdate)  -- only triggers when frame is shown

      fontString:SetText("0.0")
      fontString:SetOriginalColor()
      fontString:Show()
      return parentFrame
    end
    for i = 1, statusbarCount do
      SATimers[i] = createTimerFontString(i)
      SATimers[i]:Show()
    end
    if #SATimers > statusbarCount then
      for i = statusbarCount + 1, #SATimers do
        SATimers[i]:Hide()
      end
    end
  end

  if statusbarEnable then
    local function createStatusBars(numeration)
      local frame
      local statusbar
      if statusbars[numeration] then
        frame = statusbars[numeration]
        statusbar = frame.statusbar
      else
        frame = CreateFrame("Frame", "$parentIndicatorParent", CDFrame)
        statusbar = CreateFrame("StatusBar", "$parentIndicator", frame)
        frame.statusbar = statusbar
      end

      frame:ClearAllPoints()
      if orientation == "Vertical" then
        frame:SetHeight(width)
        frame:SetWidth(height)
        if growthDirection == "Reversed" then
          frame:SetPoint("TOPRIGHT", -statusbarYOffset, statusbarXOffset - basePositions[numeration])
        else
          frame:SetPoint("BOTTOMRIGHT", -statusbarYOffset, statusbarXOffset + basePositions[numeration])
        end
      else
        frame:SetHeight(height)
        frame:SetWidth(width)
        if growthDirection == "Reversed" then
          frame:SetPoint("BOTTOMRIGHT", statusbarXOffset - basePositions[numeration], statusbarYOffset)
        else
          frame:SetPoint("BOTTOMLEFT", statusbarXOffset + basePositions[numeration], statusbarYOffset)
        end
      end
      frame:SetBackdrop(statusbarBackdrop)
      frame:SetBackdropColor(db.statusbarColorBackground.r, db.statusbarColorBackground.b, db.statusbarColorBackground.g, db.statusbarColorBackground.a)
      frame:SetBackdropBorderColor(db.borderColor.r, db.borderColor.b, db.borderColor.g, db.borderColor.a)

      statusbar:SetPoint("TOPLEFT", 1 , -1)  -- to properly display border
      statusbar:SetPoint("BOTTOMRIGHT", -1 , 1)
      statusbar:SetStatusBarTexture((not db.useTexture or db.textureHandle == "Empty") and "Interface\\ChatFrame\\ChatFrameBackground" or LSM:Fetch("statusbar", db.textureHandle))

      statusbar:SetMinMaxValues(0, 20)
      statusbar:SetOrientation(orientation == "Vertical" and "VERTICAL" or "HORIZONTAL")
      statusbar:SetReverseFill(db.statusbarReverse)

      frame.remaining = 0
      frame.elapsed = 0
      frame.maxTime = 20
      frame.refresh = 0.1
      function frame:SetTimer(indicator)
        local aura = indicator.aura
        self.elapsed = 1
        self.remaining = indicator.tick - GetTime()
        self.maxTime = aura.duration
        self.refresh = aura.tickLength / db.width  -- TODO: cache scale
        self.statusbar:SetMinMaxValues(0, self.maxTime)
        self:Show()
      end
      frame:SetScript("OnUpdate", statusbarOnUpdate)  -- only triggers when frame is shown

      frame:Show()

      local c1r, c1b, c1g, c1a
      local c2r, c2b, c2g, c2a
      if numeration <= MAX_RESOURCE then
        c1r, c1b, c1g, c1a = db.statusbarColorBackground.r, db.statusbarColorBackground.b, db.statusbarColorBackground.g, db.statusbarColorBackground.a
        c2r, c2b, c2g, c2a = db.statusbarColor.r, db.statusbarColor.b, db.statusbarColor.g, db.statusbarColor.a
      else
        c1r, c1b, c1g, c1a = db.statusbarColorOverflow.r, db.statusbarColorOverflow.b, db.statusbarColorOverflow.g, db.statusbarColorOverflow.a
        c2r, c2b, c2g, c2a = db.statusbarColorOverflowForeground.r, db.statusbarColorOverflowForeground.b, db.statusbarColorOverflowForeground.g, db.statusbarColorOverflowForeground.a
      end


      function frame:SetOriginalColor()
        self:SetBackdropColor(c1r, c1b, c1g, c1a)
        self.gainColored = false
      end

      statusbar:SetStatusBarColor(c2r, c2b, c2g, c2a)
      frame:SetOriginalColor()

      return frame
    end
    for i = 1, statusbarCount do
      statusbars[i] = createStatusBars(i)
    end
    if #statusbars > statusbarCount then
      for i = statusbarCount + 1, #statusbars do
        statusbars[i]:Hide()
      end
    end
  end
end


------------------------------
-- Initialization and stuff --
------------------------------
function CD:Unlock()
  CDFrame.fader:Stop()
  CDOnUpdateFrame:Hide()
  for i = 1, statusbarCount do
    if textEnable then
      SATimers[i]:Show()
    end
    if statusbarEnable and (db.statusbarXOffset ~= 0 or db.statusbarYOffset ~= 0) then
      statusbars[i].statusbar:SetValue(10)
      statusbars[i]:Show()
    end

    if i == statusbarCount then
      break
    end

    if resourceEnable then
      resourceFrames[i]:Show()
    end
  end
end

function CD:Lock()
  CDFrame.fader:Stop()  -- necessary?
  CDOnUpdateFrame:Show()
  self:Update()
end

function CD:Build()
  db = DS.db.display
  gainFlash = db.gainFlash
  resourceEnable = db.resourceEnable
  resourceCappedEnable = db.resourceCappedEnable
  remainingTimeThreshold = db.remainingTimeThreshold
  resourceGainPrediction = db.resourceGainPrediction
  resourceSpendIncludeHoG = DS.specializationID == 266 and db.resourceSpendIncludeHoG  -- Only show for Demonology
  resourceSpendPrediction = db.resourceSpendPrediction
  statusbarEnable = db.statusbarEnable
  textEnable = db.textEnable
  visibilityConditionals = db.visibilityConditionals or ""
  consolidateTicks = db.consolidateTicks

  local specHandling = DS.specSettings[DS.specializationID].specHandling
  referenceSpell = specHandling.referenceSpell
  referenceTime = specHandling.referenceTime

  statusbarCount = 5 + db.statusbarCount

  buildFrames()
  buildFader()
  if DS.locked then
    CDOnUpdateFrame:Show()
  end

  CDFrame:Show()
  CDOnUpdateFrame:EvaluateConditionals()  -- In case very first frame stays on screen longer due to e.g. loading
end

function CD:OnInitialize()
end

function CD:OnEnable()
  self:RegisterMessage("DOOM_SHARDS_UPDATE")
  CDOnUpdateFrame:RegisterEvents()
end

function CD:OnDisable()
  self:UnregisterMessage("DOOM_SHARDS_UPDATE")
  CDOnUpdateFrame:Hide()
end
