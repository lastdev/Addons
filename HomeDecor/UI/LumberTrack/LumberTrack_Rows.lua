local ADDON, NS = ...
NS.UI = NS.UI or {}

local Rows = NS.UI.LumberTrackRows or {}
NS.UI.LumberTrackRows = Rows

local Utils = NS.LT.Utils

local ROW_HEIGHT = 68
local ROW_HEIGHT_NO_ICON = 50
local ICON_SIZE = 36
local ROW_HEIGHT_COMPACT = 22
local ICON_SIZE_COMPACT = 16

local CreateFrame = CreateFrame
local GameTooltip = GameTooltip
local unpack = _G.unpack or table.unpack

local function NewLumberRow(parent)
  local T = Utils.GetTheme()

  local r = CreateFrame("Button", nil, parent, "BackdropTemplate")
  r._kind = "lumber"
  r:SetHeight(ROW_HEIGHT)
  r:EnableMouse(true)
  r:RegisterForClicks("AnyUp")

  Utils.CreateBackdrop(r, {0.10, 0.10, 0.13, 0.90}, {0.90, 0.72, 0.18, 0.3})

  r.iconFrame = CreateFrame("Frame", nil, r, "BackdropTemplate")
  r.iconFrame:SetSize(ICON_SIZE, ICON_SIZE)
  r.iconFrame:SetPoint("LEFT", 10, 0)
  Utils.CreateBackdrop(r.iconFrame, {0.08, 0.08, 0.10, 0.8}, {0.90, 0.72, 0.18, 0.5})
  
  r.icon = r.iconFrame:CreateTexture(nil, "ARTWORK")
  r.icon:SetSize(ICON_SIZE - 4, ICON_SIZE - 4)
  r.icon:SetPoint("CENTER")
  r.icon:SetTexture("Interface/Icons/INV_Misc_QuestionMark")
  r.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

  r.name = r:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  r.name:SetFont("Fonts\\FRIZQT__.TTF", 13, "OUTLINE")
  r.name:SetPoint("TOPLEFT", r.iconFrame, "TOPRIGHT", 10, -4)
  r.name:SetJustifyH("LEFT")
  r.name:SetWordWrap(false)
  r.name:SetShadowColor(0, 0, 0, 1)
  r.name:SetShadowOffset(1, -1)
  r.name:SetTextColor(unpack(T.text))

  r.countNumber = r:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  r.countNumber:SetFont("Fonts\\FRIZQT__.TTF", 20, "THICKOUTLINE")
  r.countNumber:SetPoint("TOPRIGHT", r, "TOPRIGHT", -10, -4)
  r.countNumber:SetTextColor(unpack(T.accent))
  r.countNumber:SetJustifyH("RIGHT")
  r.countNumber:SetShadowColor(0, 0, 0, 1)
  r.countNumber:SetShadowOffset(1, -1)
  
  r.name:SetPoint("RIGHT", r.countNumber, "LEFT", -12, 0)

  r.rate = r:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  r.rate:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
  r.rate:SetPoint("TOPLEFT", r.name, "BOTTOMLEFT", 0, -4)
  r.rate:SetTextColor(unpack(T.accent))
  r.rate:SetShadowColor(0, 0, 0, 0.9)
  r.rate:SetShadowOffset(1, -1)
  r.rate:SetText("")



  r.progressContainer = CreateFrame("Frame", nil, r, "BackdropTemplate")
  r.progressContainer:SetHeight(20)
  r.progressContainer:SetPoint("BOTTOMLEFT", r.iconFrame, "BOTTOMRIGHT", 10, 8)
  r.progressContainer:SetPoint("RIGHT", r, "RIGHT", -10, 0)
  Utils.CreateBackdrop(r.progressContainer, {0.04, 0.04, 0.05, 0.95}, {0.90, 0.72, 0.18, 0.5})
  
  r.progressFill = r.progressContainer:CreateTexture(nil, "ARTWORK")
  r.progressFill:SetPoint("LEFT", 1, 0)
  r.progressFill:SetPoint("TOP", 0, -1)
  r.progressFill:SetPoint("BOTTOM", 0, 1)
  r.progressFill:SetWidth(1)
  r.progressFill:SetTexture("Interface/Buttons/WHITE8x8")
  r.progressFill:SetGradient("HORIZONTAL",
    CreateColor(0.28, 0.24, 0.10, 1),
    CreateColor(0.90, 0.72, 0.18, 1))
  
  r.progressText = r.progressContainer:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  r.progressText:SetFont("Fonts\\FRIZQT__.TTF", 11, "THICKOUTLINE")
  r.progressText:SetPoint("CENTER")
  r.progressText:SetTextColor(1, 1, 1, 1)
  r.progressText:SetShadowColor(0, 0, 0, 1)
  r.progressText:SetShadowOffset(1, -1)
  r.progressText:SetJustifyH("CENTER")

  r.ApplyIconLayout = function(self, showIcons)
    showIcons = showIcons ~= false
    if self._iconsShown == showIcons then return end
    self._iconsShown = showIcons
    
    self:SetHeight(showIcons and ROW_HEIGHT or ROW_HEIGHT_NO_ICON)
    
    if self.iconFrame then
      self.iconFrame:SetShown(showIcons)
    end
    
    if self.name then
      self.name:ClearAllPoints()
      if showIcons and self.iconFrame then
        self.name:SetPoint("TOPLEFT", self.iconFrame, "TOPRIGHT", 6, 0)
        self.name:SetFont("Fonts\\FRIZQT__.TTF", 13, "OUTLINE")
      else
        self.name:SetPoint("TOPLEFT", self, "TOPLEFT", 10, -6)
        self.name:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
      end
      self.name:SetPoint("RIGHT", self.countNumber, "LEFT", -12, 0)
    end
    
    if self.countNumber then
      self.countNumber:ClearAllPoints()
      if showIcons then
        self.countNumber:SetFont("Fonts\\FRIZQT__.TTF", 16, "THICKOUTLINE")
        self.countNumber:SetPoint("TOPRIGHT", self, "TOPRIGHT", -8, -6)
      else
        self.countNumber:SetFont("Fonts\\FRIZQT__.TTF", 18, "THICKOUTLINE")
        self.countNumber:SetPoint("TOPRIGHT", self, "TOPRIGHT", -10, -6)
      end
    end
    
    if self.rate then
      self.rate:ClearAllPoints()
      if showIcons then
        self.rate:SetPoint("TOPLEFT", self.name, "BOTTOMLEFT", 0, -4)
        self.rate:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
      else
        self.rate:SetPoint("TOPLEFT", self.name, "BOTTOMLEFT", 0, -3)
        self.rate:SetFont("Fonts\\FRIZQT__.TTF", 9, "OUTLINE")
      end
    end
    
    if self.progressContainer then
      self.progressContainer:ClearAllPoints()
      if showIcons and self.iconFrame then
        self.progressContainer:SetPoint("BOTTOMLEFT", self.iconFrame, "BOTTOMRIGHT", 10, 0)
        self.progressContainer:SetHeight(20)
      else
        self.progressContainer:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 10, 6)
        self.progressContainer:SetHeight(16)
      end
      self.progressContainer:SetPoint("RIGHT", self, "RIGHT", -10, 0)
      
      if self.progressText then
        if showIcons then
          self.progressText:SetFont("Fonts\\FRIZQT__.TTF", 11, "THICKOUTLINE")
        else
          self.progressText:SetFont("Fonts\\FRIZQT__.TTF", 10, "THICKOUTLINE")
        end
      end
    end
  end

  r:ApplyIconLayout(true)

  r:SetScript("OnEnter", function(self)
    local T2 = Utils.GetTheme()
    self:SetBackdropBorderColor(unpack(T2.accentBright))
    if self.progressContainer then
      self.progressContainer:SetBackdropBorderColor(unpack(T2.accentBright))
    end
    if self.iconFrame then
      self.iconFrame:SetBackdropBorderColor(unpack(T2.accentBright))
    end
    if self.itemID and GameTooltip then
      GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
      GameTooltip:SetItemByID(self.itemID)
      
      local AccountWide = NS.UI.LumberTrackAccountWide
      if AccountWide then
        local breakdown = AccountWide:GetCharacterBreakdown(self.itemID)
        if breakdown and #breakdown > 0 then
          GameTooltip:AddLine(" ")
          GameTooltip:AddLine("Character Breakdown:", 0.9, 0.72, 0.18)
          for _, data in ipairs(breakdown) do
            local countStr = Rows:FormatNumber(data.count)
            if data.warband then
              GameTooltip:AddDoubleLine(data.label, countStr, 0.50, 0.78, 1.0, 0.50, 0.78, 1.0)
            else
              GameTooltip:AddDoubleLine(data.label, countStr, 0.8, 0.8, 0.8, 0.9, 0.72, 0.18)
            end
          end
        end
      end

      local Goals = NS.UI.LumberTrackGoals
      if Goals and Goals.GetGoalTooltip and self._ctx then
        local goalInfo = Goals:GetGoalTooltip(self.itemID, self._ctx)
        if goalInfo then
          GameTooltip:AddLine(" ")
          GameTooltip:AddLine(goalInfo, 0.9, 0.72, 0.18, true)
        end
      end
      GameTooltip:Show()
    end
  end)
  
  r:SetScript("OnLeave", function(self)
    local T2 = Utils.GetTheme()
    self:SetBackdropBorderColor(unpack(T2.border))
    if self.progressContainer then
      self.progressContainer:SetBackdropBorderColor(unpack(T2.accent))
    end
    if self.iconFrame then
      self.iconFrame:SetBackdropBorderColor(unpack(T2.accent))
    end
    if GameTooltip then
      GameTooltip:Hide()
    end
  end)
  
  return r
end

local function NewCompactRow(parent)
  local T = Utils.GetTheme()

  local r = CreateFrame("Button", nil, parent, "BackdropTemplate")
  r._kind = "compact"
  r:SetHeight(ROW_HEIGHT_COMPACT)
  r:EnableMouse(true)
  r:RegisterForClicks("AnyUp")

  Utils.CreateBackdrop(r, {0.08, 0.08, 0.10, 0.0}, {0.90, 0.72, 0.18, 0.0})

  r.iconFrame = CreateFrame("Frame", nil, r, "BackdropTemplate")
  r.iconFrame:SetSize(ICON_SIZE_COMPACT, ICON_SIZE_COMPACT)
  r.iconFrame:SetPoint("LEFT", 4, 0)
  Utils.CreateBackdrop(r.iconFrame, {0.08, 0.08, 0.10, 0.7}, {0.90, 0.72, 0.18, 0.3})

  r.icon = r.iconFrame:CreateTexture(nil, "ARTWORK")
  r.icon:SetSize(ICON_SIZE_COMPACT - 2, ICON_SIZE_COMPACT - 2)
  r.icon:SetPoint("CENTER")
  r.icon:SetTexture("Interface/Icons/INV_Misc_QuestionMark")
  r.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

  r.name = r:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  r.name:SetFont("Fonts\\FRIZQT__.TTF", 11, "OUTLINE")
  r.name:SetPoint("LEFT", r.iconFrame, "RIGHT", 5, 0)
  r.name:SetWidth(130)
  r.name:SetJustifyH("LEFT")
  r.name:SetWordWrap(false)
  r.name:SetShadowColor(0, 0, 0, 1)
  r.name:SetShadowOffset(1, -1)
  r.name:SetTextColor(unpack(T.text))

  r.progressBar = r:CreateTexture(nil, "ARTWORK")
  r.progressBar:SetHeight(3)
  r.progressBar:SetPoint("BOTTOMLEFT", r.iconFrame, "BOTTOMRIGHT", 5, 2)
  r.progressBar:SetWidth(1)
  r.progressBar:SetTexture("Interface/Buttons/WHITE8x8")
  r.progressBar:SetGradient("HORIZONTAL",
    CreateColor(0.28, 0.24, 0.10, 1),
    CreateColor(0.90, 0.72, 0.18, 1))

  r.progressBg = r:CreateTexture(nil, "BACKGROUND")
  r.progressBg:SetHeight(3)
  r.progressBg:SetPoint("BOTTOMLEFT", r.iconFrame, "BOTTOMRIGHT", 5, 2)
  r.progressBg:SetPoint("RIGHT", r.name, "RIGHT", 0, 0)
  r.progressBg:SetTexture("Interface/Buttons/WHITE8x8")
  r.progressBg:SetVertexColor(0.12, 0.12, 0.14, 0.8)

  r.countNumber = r:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  r.countNumber:SetFont("Fonts\\FRIZQT__.TTF", 11, "THICKOUTLINE")
  r.countNumber:SetPoint("RIGHT", r, "RIGHT", -6, 0)
  r.countNumber:SetTextColor(unpack(T.accent))
  r.countNumber:SetJustifyH("RIGHT")
  r.countNumber:SetShadowColor(0, 0, 0, 1)
  r.countNumber:SetShadowOffset(1, -1)



  r.sep = r:CreateTexture(nil, "BACKGROUND")
  r.sep:SetHeight(1)
  r.sep:SetPoint("BOTTOMLEFT", 4, 0)
  r.sep:SetPoint("BOTTOMRIGHT", -4, 0)
  r.sep:SetTexture("Interface/Buttons/WHITE8x8")
  r.sep:SetVertexColor(0.90, 0.72, 0.18, 0.08)

  r:SetScript("OnEnter", function(self)
    local T2 = Utils.GetTheme()
    if self.sep then self.sep:SetVertexColor(0.90, 0.72, 0.18, 0.35) end
    if self.name then self.name:SetTextColor(unpack(T2.accent)) end
    if self.itemID and GameTooltip then
      GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
      GameTooltip:SetItemByID(self.itemID)
      local AccountWide = NS.UI.LumberTrackAccountWide
      if AccountWide then
        local breakdown = AccountWide:GetCharacterBreakdown(self.itemID)
        if breakdown and #breakdown > 0 then
          GameTooltip:AddLine(" ")
          GameTooltip:AddLine("Character Breakdown:", 0.9, 0.72, 0.18)
          for _, data in ipairs(breakdown) do
            local countStr = Rows:FormatNumber(data.count)
            if data.warband then
              GameTooltip:AddDoubleLine(data.label, countStr, 0.50, 0.78, 1.0, 0.50, 0.78, 1.0)
            else
              GameTooltip:AddDoubleLine(data.label, countStr, 0.8, 0.8, 0.8, 0.9, 0.72, 0.18)
            end
          end
        end
      end
      GameTooltip:Show()
    end
  end)

  r:SetScript("OnLeave", function(self)
    local T2 = Utils.GetTheme()
    if self.sep then self.sep:SetVertexColor(0.90, 0.72, 0.18, 0.08) end
    if self.name then self.name:SetTextColor(unpack(T2.text)) end
    if GameTooltip then GameTooltip:Hide() end
  end)

  return r
end

function Rows:CreateCompactRow(parent)
  return NewCompactRow(parent)
end

function Rows:SetCompactRowData(row, ctx, itemID, currentCount, itemName, iconTexture)
  if not row then return end

  local T = Utils.GetTheme()
  row.itemID = itemID
  row._ctx = ctx

  if row.icon and iconTexture then
    row.icon:SetTexture(iconTexture)
  end

  if row.name then
    row.name:SetText(itemName or ("Item " .. tostring(itemID)))
  end

  local v = tonumber(currentCount) or 0
  local Goals = NS.UI.LumberTrackGoals
  local goalVal = 1000
  if Goals and Goals.GetGoal then
    goalVal = Goals:GetGoal(itemID, ctx)
  else
    goalVal = (ctx and tonumber(ctx.goal)) or 1000
  end
  if goalVal < 1 then goalVal = 1 end

  if row.countNumber then
    row.countNumber:SetText(tostring(v))
    if v >= goalVal then
      row.countNumber:SetTextColor(unpack(T.success))
    elseif v >= goalVal * 0.5 then
      row.countNumber:SetTextColor(unpack(T.accent))
    else
      row.countNumber:SetTextColor(unpack(T.text))
    end
  end

  if row.progressBar and row.progressBg and row.name then
    local pct = goalVal > 0 and (v / goalVal) or 0
    if pct > 1 then pct = 1 end
    row._lastPct = pct

    local barMaxWidth = (row.name:GetWidth() or 130)
    local fillWidth = math.max(2, barMaxWidth * pct)
    row.progressBar:SetWidth(fillWidth)

    if pct >= 1 then
      row.progressBar:SetGradient("HORIZONTAL",
        CreateColor(0.18, 0.50, 0.24, 1),
        CreateColor(0.30, 0.80, 0.40, 1))
    elseif pct >= 0.5 then
      row.progressBar:SetGradient("HORIZONTAL",
        CreateColor(0.28, 0.24, 0.10, 1),
        CreateColor(0.90, 0.72, 0.18, 1))
    else
      row.progressBar:SetGradient("HORIZONTAL",
        CreateColor(0.18, 0.18, 0.20, 1),
        CreateColor(0.35, 0.35, 0.38, 1))
    end
  end

  local showIcons = ctx and ctx.showIcons ~= false
  if row.iconFrame then
    row.iconFrame:SetShown(showIcons)
    if row.name then
      row.name:ClearAllPoints()
      if showIcons then
        row.name:SetPoint("LEFT", row.iconFrame, "RIGHT", 5, 1)
      else
        row.name:SetPoint("LEFT", row, "LEFT", 6, 1)
      end
      row.name:SetPoint("RIGHT", row.countNumber, "LEFT", -4, 0)
    end
    if row.progressBar then
      row.progressBar:ClearAllPoints()
      if showIcons then
        row.progressBar:SetPoint("BOTTOMLEFT", row.iconFrame, "BOTTOMRIGHT", 5, 2)
      else
        row.progressBar:SetPoint("BOTTOMLEFT", row, "BOTTOMLEFT", 6, 2)
      end
    end
    if row.progressBg then
      row.progressBg:ClearAllPoints()
      if showIcons then
        row.progressBg:SetPoint("BOTTOMLEFT", row.iconFrame, "BOTTOMRIGHT", 5, 2)
      else
        row.progressBg:SetPoint("BOTTOMLEFT", row, "BOTTOMLEFT", 6, 2)
      end
      row.progressBg:SetPoint("RIGHT", row.name, "RIGHT", 0, 0)
    end
  end
end

function Rows:InitPools(frame, content)
  frame._pool = frame._pool or {lumber = {}}
  frame._active = frame._active or {}
  frame._content = content
  frame._rowFactories = frame._rowFactories or {
    lumber = function() return NewLumberRow(content) end,
  }
end

function Rows:Acquire(frame, kind)
  kind = kind or "lumber"
  local pool = frame._pool and frame._pool[kind]
  if not pool then return end
  
  local row = table.remove(pool)
  if not row then
    local f = frame._rowFactories and frame._rowFactories[kind]
    row = f and f() or nil
  end
  if not row then return end
  
  row:Show()
  local active = frame._active
  active[#active + 1] = row
  return row
end

function Rows:ReleaseAll(frame)
  local active = frame and frame._active
  local pool = frame and frame._pool
  if not active or not pool then return end
  
  for i = 1, #active do
    local r = active[i]
    if r then
      r:Hide()
      r:ClearAllPoints()
      local k = r._kind or "lumber"
      local p = pool[k]
      if p then
        p[#p + 1] = r
      end
    end
  end
  
  for k in pairs(active) do
    active[k] = nil
  end
end

function Rows:CreateRow(parent)
  return NewLumberRow(parent)
end

function Rows:SetRowData(row, ctx, itemID, currentCount, itemName, iconTexture)
  if not row then return end

  local T = Utils.GetTheme()
  local showBackgrounds = ctx.showRowBackgrounds ~= false

  row.itemID = itemID
  row._ctx = ctx

  if showBackgrounds then
    row:SetBackdropColor(0.10, 0.10, 0.13, 0.90)
    row:SetBackdropBorderColor(0.90, 0.72, 0.18, 0.3)
  else
    row:SetBackdropColor(0, 0, 0, 0)
    row:SetBackdropBorderColor(0, 0, 0, 0)
  end

  if row.icon and iconTexture then
    row.icon:SetTexture(iconTexture)
  end

  if row.iconFrame then
    if showBackgrounds then
      row.iconFrame:SetBackdropColor(0.08, 0.08, 0.10, 0.8)
      row.iconFrame:SetBackdropBorderColor(0.90, 0.72, 0.18, 0.5)
    else
      row.iconFrame:SetBackdropColor(0, 0, 0, 0)
      row.iconFrame:SetBackdropBorderColor(0, 0, 0, 0)
    end
  end

  if row.name then
    row.name:SetText(itemName or ("Item " .. tostring(itemID)))
  end

  if row.rate then
    local Rate = NS.UI.LumberTrackRate
    if Rate then
      local ratePerMin = Rate:GetRate(itemID)
      if ratePerMin > 0 then
        row.rate:SetFormattedText("↑ +%d/min", ratePerMin)
        row.rate:SetTextColor(unpack(T.success))
        row.rate:Show()
      else
        row.rate:Hide()
      end
    else
      row.rate:Hide()
    end
  end

  local v = tonumber(currentCount) or 0
  local Goals = NS.UI.LumberTrackGoals
  local goalVal = 1000
  
  if Goals and Goals.GetGoal then
    goalVal = Goals:GetGoal(itemID, ctx)
  else
    goalVal = (ctx and tonumber(ctx.goal)) or 1000
  end
  
  if goalVal < 1 then goalVal = 1 end

  if row.countNumber then
    row.countNumber:SetText(tostring(v))
    if v >= goalVal then
      row.countNumber:SetTextColor(unpack(T.success))
    elseif v >= goalVal * 0.5 then
      row.countNumber:SetTextColor(unpack(T.accent))
    else
      row.countNumber:SetTextColor(unpack(T.text))
    end
  end

  if row.progressFill and row.progressContainer then
    local pct = goalVal > 0 and (v / goalVal) or 0
    if pct > 1 then pct = 1 end
    row._lastPct = pct
    
    local containerWidth = row.progressContainer:GetWidth() or 100
    local fillWidth = math.max(2, (containerWidth - 2) * pct)
    row.progressFill:SetWidth(fillWidth)
    
    if showBackgrounds then
      row.progressContainer:SetBackdropColor(0.04, 0.04, 0.05, 0.95)
    else
      row.progressContainer:SetBackdropColor(0, 0, 0, 0)
    end
    
    if pct >= 1 then
      row.progressFill:SetGradient("HORIZONTAL",
        CreateColor(0.18, 0.50, 0.24, 1),
        CreateColor(0.30, 0.80, 0.40, 1))
      if row.progressContainer and showBackgrounds then
        row.progressContainer:SetBackdropBorderColor(unpack(T.success))
      elseif row.progressContainer then
        row.progressContainer:SetBackdropBorderColor(0, 0, 0, 0)
      end
    elseif pct >= 0.5 then
      row.progressFill:SetGradient("HORIZONTAL",
        CreateColor(0.28, 0.24, 0.10, 1),
        CreateColor(0.90, 0.72, 0.18, 1))
      if row.progressContainer and showBackgrounds then
        row.progressContainer:SetBackdropBorderColor(unpack(T.accent))
      elseif row.progressContainer then
        row.progressContainer:SetBackdropBorderColor(0, 0, 0, 0)
      end
    else
      row.progressFill:SetGradient("HORIZONTAL",
        CreateColor(0.18, 0.18, 0.20, 1),
        CreateColor(0.45, 0.45, 0.48, 1))
      if row.progressContainer and showBackgrounds then
        row.progressContainer:SetBackdropBorderColor(unpack(T.border))
      elseif row.progressContainer then
        row.progressContainer:SetBackdropBorderColor(0, 0, 0, 0)
      end
    end
  end
  
  if row.progressText then
    row.progressText:SetFormattedText("%s / %s",
      self:FormatNumber(v),
      self:FormatNumber(goalVal))
  end
end

function Rows:FormatNumber(num)
  return Utils.FormatNumber(num)
end

function Rows:Reflow(ctx)
  if not ctx or type(ctx.rows) ~= "table" then return end
  
  local showIcons = ctx.showIcons ~= false
  
  for i = 1, #ctx.rows do
    local row = ctx.rows[i]
    if row and row.IsShown and row:IsShown() then
      if row.ApplyIconLayout then
        row:ApplyIconLayout(showIcons)
      elseif row.iconFrame then
        row.iconFrame:SetShown(showIcons)
      end
      
      if row.progressFill and row.progressContainer and row._lastPct then
        local containerWidth = row.progressContainer:GetWidth() or 100
        local fillWidth = math.max(2, (containerWidth - 2) * row._lastPct)
        row.progressFill:SetWidth(fillWidth)
      end
    end
  end
end

function Rows:UpdateRowTransparency(ctx)
  if not ctx or type(ctx.rows) ~= "table" then return end
  
  local showBackgrounds = ctx.showRowBackgrounds ~= false
  
  for i = 1, #ctx.rows do
    local row = ctx.rows[i]
    if row and row.IsShown and row:IsShown() then
      if showBackgrounds then
        row:SetBackdropColor(0.10, 0.10, 0.13, 0.90)
        row:SetBackdropBorderColor(0.90, 0.72, 0.18, 0.3)
        
        if row.iconFrame then
          row.iconFrame:SetBackdropColor(0.08, 0.08, 0.10, 0.8)
          row.iconFrame:SetBackdropBorderColor(0.90, 0.72, 0.18, 0.5)
        end
        
        if row.progressContainer then
          row.progressContainer:SetBackdropColor(0.04, 0.04, 0.05, 0.95)
        end
      else
        row:SetBackdropColor(0, 0, 0, 0)
        row:SetBackdropBorderColor(0, 0, 0, 0)
        
        if row.iconFrame then
          row.iconFrame:SetBackdropColor(0, 0, 0, 0)
          row.iconFrame:SetBackdropBorderColor(0, 0, 0, 0)
        end
        
        if row.progressContainer then
          row.progressContainer:SetBackdropColor(0, 0, 0, 0)
          row.progressContainer:SetBackdropBorderColor(0, 0, 0, 0)
        end
      end
    end
  end
end

return Rows