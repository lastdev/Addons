local ADDON, NS = ...

NS.UI = NS.UI or {}
local View = NS.UI.Viewer
local Requirements = View.Requirements

local C = NS.UI.Controls
local function Theme() return NS.UI.Theme or {} end

local TT = NS.UI.Tooltips
local DecorIndex = NS.Systems and NS.Systems.DecorIndex
local RepSys = NS.Systems and NS.Systems.Reputation

local wowheadPopup

local function BuildWowheadItemURL(itemID)
  if not itemID then return nil end
  return "https://www.wowhead.com/item=" .. tostring(itemID)
end

local function BuildWowheadAchievementURL(achievementID)
  if not achievementID then return nil end
  return "https://www.wowhead.com/achievement=" .. tostring(achievementID)
end

local function BuildWowheadQuestURL(questID)
  if not questID then return nil end
  return "https://www.wowhead.com/quest=" .. tostring(questID)
end

local achNameCache = {}
local questNameCache = {}

local function GetAchievementTitleSafe(id)
  id = tonumber(id)
  if not id then return nil end
  if achNameCache[id] ~= nil then
    return achNameCache[id] or nil
  end
  if not GetAchievementInfo then
    achNameCache[id] = false
    return nil
  end
  local name = select(2, GetAchievementInfo(id))
  if name and name ~= "" then
    achNameCache[id] = name
    return name
  end
  achNameCache[id] = false
  return nil
end

local function GetQuestTitleSafe(id)
  id = tonumber(id)
  if not id then return nil end
  if questNameCache[id] ~= nil then
    return questNameCache[id] or nil
  end
  if C_QuestLog and C_QuestLog.RequestLoadQuestByID then
    C_QuestLog.RequestLoadQuestByID(id)
  end
  if C_QuestLog and C_QuestLog.GetTitleForQuestID then
    local title = C_QuestLog.GetTitleForQuestID(id)
    if title and title ~= "" then
      questNameCache[id] = title
      return title
    end
  end
  questNameCache[id] = false
  return nil
end

local function IsQuestComplete(questID)
  questID = tonumber(questID)
  if not questID then return false end

  if C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted then
    return C_QuestLog.IsQuestFlaggedCompleted(questID)
  end

  if IsQuestFlaggedCompleted then
    return IsQuestFlaggedCompleted(questID)
  end

  return false
end

local function IsAchievementComplete(achievementID)
  achievementID = tonumber(achievementID)
  if not achievementID then return false end

  if not GetAchievementInfo then return false end

  local _, _, _, completed = GetAchievementInfo(achievementID)
  return completed == true
end

local function GetRequirementLink(it)
  if not it then return nil end

  local r = it.requirements
  if not r and DecorIndex and it.decorID then
    local entry = DecorIndex[it.decorID]
    local item  = entry and entry.item
    r = item and item.requirements or nil
  end
  if not r then return nil end

  if r.quest and r.quest.id then
    local id = r.quest.id
    local completed = IsQuestComplete(id)
    return {
      kind = "quest",
      id = id,
      text = r.quest.title or GetQuestTitleSafe(id) or ("Quest " .. tostring(id)),
      completed = completed
    }
  end
  if r.achievement and r.achievement.id then
    local id = r.achievement.id
    local completed = IsAchievementComplete(id)
    return {
      kind = "achievement",
      id = id,
      text = r.achievement.title or GetAchievementTitleSafe(id) or ("Achievement " .. tostring(id)),
      completed = completed
    }
  end
  return nil
end

local function BuildReqDisplay(req, hover)
  if not req then return "" end

  local completed = req.completed == true

  if completed then

    local check = "|TInterface\\RaidFrame\\ReadyCheck-Ready:14:14:0:0:64:64:0:64:0:64|t "
    local txtCol = "|cff40ff40"
    return check .. txtCol .. (req.text or "") .. "|r"
  else

    local sym = (req.kind == "quest") and "!" or "*"
    local symCol = "|cffffd100" .. sym .. "|r "
    local txtCol = hover and "|cfffff2a0" or "|cffffffff"
    return symCol .. txtCol .. (req.text or "") .. "|r"
  end
end

local repScanCache = {}
local repScanTT

local function Trim(s)
  if type(s) ~= "string" then return s end
  return (s:gsub("^%s+",""):gsub("%s+$",""))
end

local function IsTrueFlag(v)
  if v == true or v == 1 then return true end
  if type(v) == "string" then
    local s = v:lower():gsub("%s+","")
    return (s == "true" or s == "1" or s == "yes" or s == "y")
  end
  return false
end

local function EnsureRepTooltip()
  if repScanTT and repScanTT.GetName then return repScanTT end
  local tt = CreateFrame("GameTooltip", "HomeDecorRepScanTooltip_REQ", UIParent, "GameTooltipTemplate")
  tt:SetOwner(UIParent, "ANCHOR_NONE")
  tt:Hide()
  repScanTT = tt
  return tt
end

local function NormalizeRequiresPrefix(line)
  if type(line) ~= "string" then return nil end
  local s = line:gsub("：", ":")
  return s:match("^Requires:%s*(.+)$") or s:match("^Requires%s+(.+)$")
end

local function LooksLikeRepRequirement(rhs)
  if not rhs or rhs == "" then return false end
  local low = rhs:lower()
  if low:find("level") or low:find("class") or low:find("race") or low:find("item level") then
    return false
  end
  if rhs:find("%s%-%s") then return true end

  for i = 1, 8 do
    local token = _G["FACTION_STANDING_LABEL" .. i]
    local lab = token and (GetText and GetText(token) or token) or nil
    if lab and rhs:find(lab, 1, true) then
      return true
    end
  end
  return false
end

local function ScanTooltipForRep(itemID)
  if not itemID then return nil end
  local cached = repScanCache[itemID]
  if cached then return cached end

  local tt = EnsureRepTooltip()
  tt:ClearLines()
  tt:SetItemByID(itemID)

  local tname = tt:GetName()
  if not tname then return nil end

  for i = 2, math.min(tt:NumLines() or 0, 25) do
    local fs = _G[tname .. "TextLeft" .. i]
    if fs then
      local line = Trim(fs:GetText())
      if line and line ~= "" then
        local rhs = NormalizeRequiresPrefix(line)
        if rhs then
          rhs = Trim(rhs)
          if LooksLikeRepRequirement(rhs) then
            local r, g = fs:GetTextColor()
            local met = not (r and g and (r > 0.9 and g < 0.3))
            local out = { text = rhs, met = met }
            repScanCache[itemID] = out
            return out
          end
        end
      end
    end
  end

  return nil
end

local function FindItemIDForReq(it)
  if not it then return nil end
  local s = it.source
  if s and s.itemID then return s.itemID end
  if it.itemID then return it.itemID end
  if DecorIndex and it.decorID then
    local entry = DecorIndex[it.decorID]
    if entry and entry.item and entry.item.source and entry.item.source.itemID then
      return entry.item.source.itemID
    end
    if entry and entry.itemID then return entry.itemID end
  end
  return nil
end

local function RequestRepRescanAfterLoad(itemID)
  if not itemID or not Item or not Item.CreateFromItemID then return end
  local item = Item:CreateFromItemID(itemID)
  if not item or item:IsItemEmpty() then return end
  item:ContinueOnItemLoad(function()
    repScanCache[itemID] = nil
    if View and View.instance and View.instance.Render then
      View.instance:Render()
    elseif NS.UI and NS.UI.Layout and NS.UI.Layout.Render then
      NS.UI.Layout:Render()
    end
  end)
end

local function GetRepRequirement(it)
  if RepSys and RepSys.GetRequirement then
    local out = RepSys.GetRequirement(it)
    if out then return out end
  end

  if not it then return nil end

  local r = it.requirements
  if not r and DecorIndex and it.decorID then
    local entry = DecorIndex[it.decorID]
    local item  = entry and entry.item
    r = item and item.requirements or nil
  end
  if not r then return nil end

  local rep = r.rep or r.reputation
  if rep == nil then return nil end

  if IsTrueFlag(rep) then
    local itemID = FindItemIDForReq(it)
    if itemID then
      local out = ScanTooltipForRep(itemID)
      if out then return out end
      RequestRepRescanAfterLoad(itemID)
    end
    return { text = "Reputation required" }
  end

  if type(rep) == "string" then
    local s = rep:gsub("^%s+",""):gsub("%s+$","")
    if s == "" then
      return { text = "Reputation required" }
    end
    return { text = s }
  end

  if type(rep) == "table" then
    local name = rep.title or rep.name or rep.faction or rep.rep
    local lvl  = rep.level or rep.standing or rep.rank
    if name and lvl then
      return { text = tostring(name) .. " (" .. tostring(lvl) .. ")" }
    elseif name then
      return { text = tostring(name) }
    end
    return { text = "Reputation required" }
  end

  return { text = "Reputation required" }
end

local function BuildRepDisplay(rep, hover)
  if not rep or not rep.text or rep.text == "" then return "" end

  local isMet = rep.met == true

  if isMet then

    local check = "|TInterface\\RaidFrame\\ReadyCheck-Ready:14:14:0:0:64:64:0:64:0:64|t "
    local txtCol = "|cff40ff40"
    return check .. txtCol .. rep.text .. "|r"
  else

    local icon = "|TInterface\\Icons\\Achievement_Reputation_01:14:14:0:0:64:64:4:60:4:60|t "
    local txtCol = hover and "|cffff4040" or "|cffff2020"
    return icon .. txtCol .. rep.text .. "|r"
  end
end

local function EnsurePopup()
  local T = Theme()
  if wowheadPopup and wowheadPopup._rows then return wowheadPopup end

  local p = wowheadPopup
  if not p then
    p = CreateFrame("Frame", "HomeDecorWowheadPopup", UIParent, "BackdropTemplate")
    wowheadPopup = p

    if type(UISpecialFrames) == "table" then
      local already
      for i = 1, #UISpecialFrames do
        if UISpecialFrames[i] == "HomeDecorWowheadPopup" then
          already = true
          break
        end
      end
      if not already then
        tinsert(UISpecialFrames, 1, "HomeDecorWowheadPopup")
      end
    end

    p:SetFrameStrata("FULLSCREEN_DIALOG")
    p:SetFrameLevel(9999)
    p:SetToplevel(true)
    p:SetClampedToScreen(true)
    p:SetPoint("CENTER")

    if C and C.Backdrop then
      C:Backdrop(p, T.panel, T.border)
    else
      p:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 },
      })
      p:SetBackdropColor(0, 0, 0, 0.9)
    end

    p:EnableMouse(true)
    p:SetMovable(true)
    p:RegisterForDrag("LeftButton")
    p:SetScript("OnDragStart", p.StartMoving)
    p:SetScript("OnDragStop", p.StopMovingOrSizing)

    p:EnableKeyboard(true)
    if p.SetPropagateKeyboardInput then
      p:SetPropagateKeyboardInput(false)
    end
    p:SetScript("OnKeyDown", function(self, key)
      if key == "ESCAPE" then self:Hide() end
    end)

    local header = CreateFrame("Frame", nil, p, "BackdropTemplate")
    header:SetPoint("TOPLEFT", 6, -6)
    header:SetPoint("TOPRIGHT", -6, -6)
    header:SetHeight(44)
    if C and C.Backdrop then
      C:Backdrop(header, T.header, T.border)
    end
    p._header = header

    local title = header:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("LEFT", 12, 0)
    title:SetText("Wowhead Links")
    local colors = T.colors or {}
    if title.SetTextColor then
      local c = colors.accent or {1,1,1,1}
      title:SetTextColor(c[1] or 1, c[2] or 1, c[3] or 1, c[4] or 1)
    end
    p._title = title

    local hint = p:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    hint:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 12, -8)
    hint:SetText("Ctrl+C to copy, then paste into your browser.")
    p._hint = hint

    p._closeBtn = CreateFrame("Button", nil, header, "BackdropTemplate")
    if C and C.Backdrop then
      C:Backdrop(p._closeBtn, T.panel, T.border)
    end
    p._closeBtn:SetSize(26, 26)
    p._closeBtn:SetPoint("RIGHT", header, "RIGHT", -10, 0)
    if C and C.ApplyHover then
      C:ApplyHover(p._closeBtn, T.panel, T.hover)
    end

    p._closeBtn.icon = p._closeBtn:CreateTexture(nil, "OVERLAY")
    p._closeBtn.icon:SetSize(14, 14)
    p._closeBtn.icon:SetPoint("CENTER")
    p._closeBtn.icon:SetTexture("Interface\\Buttons\\UI-StopButton")
    p._closeBtn.icon:SetVertexColor(1, 0.82, 0.2, 1)

    p._closeBtn:SetFrameStrata(p:GetFrameStrata())
    p._closeBtn:SetFrameLevel(p:GetFrameLevel() + 20)
    p._closeBtn:SetScript("OnClick", function() p:Hide() end)
    p._closeBtn:Show()

    local blocker = CreateFrame("Button", nil, UIParent)
    blocker:SetAllPoints(UIParent)
    blocker:SetFrameStrata("FULLSCREEN_DIALOG")
    blocker:SetFrameLevel(9998)
    blocker:EnableMouse(true)
    blocker:RegisterForClicks("AnyUp")
    blocker:SetScript("OnClick", function()
      if wowheadPopup then wowheadPopup:Hide() end
    end)
    blocker:Hide()
    p._blocker = blocker

    p:HookScript("OnShow", function(self)
      if self._blocker then self._blocker:Show() end
    end)
    p:HookScript("OnHide", function(self)
      if self._blocker then self._blocker:Hide() end
      if self._rows then
        for i = 1, #self._rows do
          local eb = self._rows[i] and self._rows[i].editbox
          if eb and eb:HasFocus() then eb:ClearFocus() end
        end
      end
    end)

    p:Hide()
  end

  if not p._rows then p._rows = {} end
  for i = 1, 3 do
    if not p._rows[i] then
      local row = {}

      local lab = p:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
      row.label = lab

      local eb = CreateFrame("EditBox", nil, p, "InputBoxTemplate")
      eb:SetAutoFocus(false)
      eb:SetTextInsets(10, 10, 0, 0)
      eb:SetFontObject("ChatFontNormal")
      eb:SetHeight(28)
      eb:SetScript("OnEscapePressed", function() p:Hide() end)
      eb:SetScript("OnEnterPressed", function() p:Hide() end)
      row.editbox = eb

      p._rows[i] = row
    end
  end

  return p
end

local function ShowWowheadLinks(links)
  if not links or #links == 0 then return end

  local p = EnsurePopup()
  if not p or not p._rows then return end

  local maxRows = math.min(#links, 3)
  local width = 560
  local topY = -78
  local rowGap = 46

  p:SetWidth(width)
  p:SetHeight(90 + (maxRows * rowGap))

  for i = 1, 3 do
    local row = p._rows[i]
    if row then
      row.label:Hide()
      row.editbox:Hide()
    end
  end

  local focused
  for i = 1, maxRows do
    local row = p._rows[i]
    local l = links[i] or {}

    row.label:ClearAllPoints()
    row.label:SetPoint("TOPLEFT", 16, topY - ((i - 1) * rowGap))
    row.label:SetText(l.label or "Link")
    row.label:Show()

    row.editbox:ClearAllPoints()
    row.editbox:SetPoint("TOPLEFT", row.label, "BOTTOMLEFT", -6, -6)
    row.editbox:SetPoint("TOPRIGHT", p, "TOPRIGHT", -16, topY - ((i - 1) * rowGap) - 22)
    row.editbox:SetText(l.url or "")
    row.editbox:Show()

    if not focused then focused = row.editbox end
  end

  p:Show()
  if focused then
    focused:HighlightText()
    focused:SetFocus()
  end
end

Requirements.ShowWowheadLinks = ShowWowheadLinks
Requirements.BuildWowheadItemURL = BuildWowheadItemURL
Requirements.BuildWowheadAchievementURL = BuildWowheadAchievementURL
Requirements.BuildWowheadQuestURL = BuildWowheadQuestURL
Requirements.GetRequirementLink = GetRequirementLink
Requirements.BuildReqDisplay = BuildReqDisplay
Requirements.GetRepRequirement = GetRepRequirement
Requirements.BuildRepDisplay = BuildRepDisplay

return Requirements