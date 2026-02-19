local _, NS = ...

NS.Systems = NS.Systems or {}
NS.Systems.Reputation = NS.Systems.Reputation or {}
local R = NS.Systems.Reputation

R._cache = R._cache or {}

local CreateFrame, UIParent = _G.CreateFrame, _G.UIParent
local GetText = _G.GetText
local Item = _G.Item
local C_TooltipInfo = _G.C_TooltipInfo
local _G = _G

local tonumber, tostring, type, pcall = tonumber, tostring, type, pcall
local floor, min = math.floor, math.min

local function trim(s)
  if type(s) ~= "string" then return s end
  return (s:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function isTrue(v)
  if v == true or v == 1 then return true end
  if type(v) == "string" then
    local s = trim(v):lower()
    return s == "true" or s == "1" or s == "yes"
  end
  return false
end

local function shouldTrackRepText(text)
  if type(text) ~= "string" then return false end
  local s = text:lower()
  if s == "" then return false end
  if s == "reputation required" then return false end
  if s:find("renown", 1, true) then return false end
  return true
end

local function recordRepAlt(out)
  local RepAlts = NS.Systems and NS.Systems.ReputationAlts
  if not RepAlts or not RepAlts.Record then return end
  if not out or not out.text or out.met ~= true then return end
  if not shouldTrackRepText(out.text) then return end
  pcall(RepAlts.Record, RepAlts, out.text, true)
end

local function ensureTooltip()
  local tt = R._tt
  if tt then return tt end
  tt = CreateFrame("GameTooltip", "HomeDecorRepScanTooltip", UIParent, "GameTooltipTemplate")
  tt:SetOwner(UIParent, "ANCHOR_NONE")
  tt:Hide()
  R._tt = tt
  return tt
end

local function normalizeRequires(line)
  if type(line) ~= "string" then return nil end
  local s = line:gsub("：", ":")
  return s:match("^Requires:%s*(.+)$") or s:match("^Requires%s+(.+)$")
end

local standingCache
local function getStandingLabels()
  if standingCache then return standingCache end
  local t = {}
  for i = 1, 8 do
    local tok = _G["FACTION_STANDING_LABEL" .. i]
    local lab = tok and ((GetText and GetText(tok)) or tok) or nil
    if type(lab) == "string" and lab ~= "" then
      t[#t + 1] = lab
      t[#t + 1] = lab:lower()
    end
  end
  standingCache = t
  return t
end

local function looksLikeRep(rhs)
  if not rhs or rhs == "" then return false end
  local low = rhs:lower()

  if low:find("item level", 1, true) or low:find("level", 1, true) or low:find("class", 1, true) or low:find("race", 1, true) then
    return false
  end

  if rhs:find("%s%-%s") then return true end

  local labels = getStandingLabels()
  for i = 1, #labels do
    local s = labels[i]
    if rhs:find(s, 1, true) or low:find(s, 1, true) then
      return true
    end
  end

  return low:find("friendly", 1, true)
      or low:find("honored", 1, true)
      or low:find("revered", 1, true)
      or low:find("exalted", 1, true)
      or low:find("neutral", 1, true)
      or low:find("unfriendly", 1, true)
      or low:find("hostile", 1, true)
      or low:find("hated", 1, true)
end

local function isRed(r, g, b)
  return r and g and b and (r > 0.9 and g < 0.3 and b < 0.3)
end

local function findItemID(it)
  if not it then return nil end
  local s = it.source
  local id = (s and s.itemID) or it.itemID
  if id then return id end

  local DI = NS.Systems and NS.Systems.DecorIndex
  if DI and it.decorID then
    local e = DI[it.decorID]
    local item = e and e.item
    local src = item and item.source
    return (src and src.itemID) or (item and item.itemID) or nil
  end

  return nil
end

local function scanTooltip(itemID)
  itemID = tonumber(itemID)
  if not itemID then return nil end

  local cached = R._cache[itemID]
  if cached ~= nil then return cached or nil end

  if C_TooltipInfo and C_TooltipInfo.GetItemByID then
    local ok, data = pcall(C_TooltipInfo.GetItemByID, itemID)
    if ok and data and type(data.lines) == "table" then
      local lines = data.lines
      for i = 1, min(#lines, 40) do
        local ln = lines[i]
        local raw = ln and (ln.leftText or ln.text)
        local line = trim(raw)
        if line and line ~= "" then
          local rhs = normalizeRequires(line)
          if rhs then
            rhs = trim(rhs)
            if looksLikeRep(rhs) then
              local c = ln.leftColor or ln.color or ln.leftTextColor
              local r = c and (c.r or c.R) or nil
              local g = c and (c.g or c.G) or nil
              local b = c and (c.b or c.B) or nil
              local out = { text = rhs, met = not isRed(r, g, b) }
              R._cache[itemID] = out
              return out
            end
          end
        end
      end
    end
  end

  local tt = ensureTooltip()
  tt:ClearLines()
  tt:SetOwner(UIParent, "ANCHOR_NONE")
  tt:SetItemByID(itemID)

  local name = tt:GetName()
  if not name then
    R._cache[itemID] = false
    return nil
  end

  local n = tt:NumLines() or 0
  for i = 2, min(n, 25) do
    local fs = _G[name .. "TextLeft" .. i]
    if fs then
      local line = trim(fs:GetText())
      if line and line ~= "" then
        local rhs = normalizeRequires(line)
        if rhs then
          rhs = trim(rhs)
          if looksLikeRep(rhs) then
            local r, g, b = fs:GetTextColor()
            local out = { text = rhs, met = not isRed(r, g, b) }
            R._cache[itemID] = out
            return out
          end
        end
      end
    end
  end

  R._cache[itemID] = false
  return nil
end

local function requestRescan(itemID)
  if not itemID or not Item or not Item.CreateFromItemID then return end
  local it = Item:CreateFromItemID(itemID)
  if not it or it:IsItemEmpty() then return end

  it:ContinueOnItemLoad(function()
    R._cache[itemID] = nil
    local out = scanTooltip(itemID)
    if out then
      recordRepAlt(out)
      return
    end
  end)
end

function R.GetRequirement(it)
  if not it then return nil end

  local req = it.requirements
  if not req then
    local DI = NS.Systems and NS.Systems.DecorIndex
    if DI and it.decorID then
      local e = DI[it.decorID]
      local item = e and e.item
      req = item and item.requirements or nil
    end
  end
  if not req then return nil end

  local rep = req.rep or req.reputation
  if rep == nil then return nil end

  if isTrue(rep) then
    local itemID = findItemID(it)
    if not itemID then
      local out = { text = "Reputation required" }
      return out
    end
    local out = scanTooltip(itemID)
    if out then
      recordRepAlt(out)
      return out
    end
    requestRescan(itemID)
    local fallback = { text = "Reputation required" }
    return fallback
  end

  if type(rep) == "string" then
    local s = trim(rep)
    if s == "" then s = "Reputation required" end
    local out = { text = s }
    recordRepAlt(out)
    return out
  end

  if type(rep) == "table" then
    local name = rep.title or rep.name or rep.faction or rep.rep
    local lvl = rep.level or rep.standing or rep.rank
    if name and lvl then
      local out = { text = tostring(name) .. " (" .. tostring(lvl) .. ")" }
      recordRepAlt(out)
      return out
    end
    if name then
      local out = { text = tostring(name) }
      recordRepAlt(out)
      return out
    end
    local out = { text = "Reputation required" }
    return out
  end

  local out = { text = "Reputation required" }
  return out
end

return R
