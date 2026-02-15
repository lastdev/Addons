local _, NS = ...
NS.UI = NS.UI or {}

local Tracker = NS.UI.Tracker or {}
NS.UI.Tracker = Tracker

local U = NS.UI.TrackerUtil or {}
NS.UI.TrackerUtil = U
Tracker.Util = U

local DecorIconCache = {}
local DecorNameCache = {}
local QuestTitleCache = {}
local AchTitleCache = {}

local C_HousingCatalog = _G.C_HousingCatalog
local C_QuestLog = _G.C_QuestLog
local GetAchievementInfo = _G.GetAchievementInfo

local pcall = pcall
local tonumber = tonumber
local tostring = tostring
local type = type
local concat = table.concat

local function GetViewerHooks()
  local ui = NS.UI
  local view = ui and ui.Viewer
  if not view then return end
  return view.Data, view.Util, view.Requirements
end

function U.Clamp(v, a, b)
  if v < a then return a end
  if v > b then return b end
  return v
end

local function GetCatalogInfo(decorID)
  if not decorID then return end
  if not (C_HousingCatalog and C_HousingCatalog.GetCatalogEntryInfoByRecordID) then return end
  return C_HousingCatalog.GetCatalogEntryInfoByRecordID(1, decorID, true)
end

function U.GetDecorIcon(decorID)
  local Data = GetViewerHooks()
  if Data and Data.GetDecorIcon then
    return Data.GetDecorIcon(decorID)
  end

  if not decorID then return end

  local cached = DecorIconCache[decorID]
  if cached ~= nil then
    return cached or nil
  end

  local info = GetCatalogInfo(decorID)
  local icon = info and info.iconTexture
  DecorIconCache[decorID] = icon or false
  return icon
end

function U.GetDecorName(decorID)
  local Data = GetViewerHooks()
  if Data and Data.GetDecorName then
    return Data.GetDecorName(decorID)
  end

  if not decorID then return end

  local cached = DecorNameCache[decorID]
  if cached ~= nil then
    return cached or nil
  end

  local info = GetCatalogInfo(decorID)
  local name = info and info.name
  if type(name) ~= "string" or name == "" then
    name = nil
  end

  DecorNameCache[decorID] = name or false
  return name
end

function U.IsCollectedSafe(it)
  local _, Util = GetViewerHooks()
  if Util and Util.IsCollectedSafe then
    return Util.IsCollectedSafe(it)
  end

  local Systems = NS.Systems
  local Collection = Systems and Systems.Collection
  if not (Collection and Collection.IsCollected) then
    return false
  end

  local ok, res = pcall(Collection.IsCollected, Collection, it)
  if ok and type(res) == "boolean" then
    return res
  end

  local id = (it and it.source and it.source.itemID)
    or (it and it.itemID)
    or (it and it.id)
    or (it and it.decorID)

  if not id then return false end

  local ok2, res2 = pcall(Collection.IsCollected, Collection, id)
  if ok2 and type(res2) == "boolean" then
    return res2
  end

  return false
end

local function GetQuestTitle(id)
  id = tonumber(id)
  if not id then return end

  local cached = QuestTitleCache[id]
  if cached ~= nil then
    return cached or nil
  end

  local title
  if C_QuestLog and C_QuestLog.GetTitleForQuestID then
    local ok, t = pcall(C_QuestLog.GetTitleForQuestID, id)
    if ok and type(t) == "string" and t ~= "" then
      title = t
    end
  end

  QuestTitleCache[id] = title or false
  return title
end

local function GetAchievementTitle(id)
  id = tonumber(id)
  if not id then return end

  local cached = AchTitleCache[id]
  if cached ~= nil then
    return cached or nil
  end

  local title
  if GetAchievementInfo then
    local ok, a1, a2, a3 = pcall(GetAchievementInfo, id)
    if ok then
      local nm = a2 or a3 or a1
      if type(nm) == "string" and nm ~= "" then
        title = nm
      end
    end
  end

  AchTitleCache[id] = title or false
  return title
end

local function GetRequirementsTable(it)
  if type(it) ~= "table" then return end

  local req = it.requirements
  if not req then
    local src = it.source
    local sreq = src and src.requirements
    if type(sreq) == "table" then
      req = sreq
    end
  end

  if type(req) == "table" then
    return req
  end

  local Systems = NS.Systems
  local DecorIndex = Systems and Systems.DecorIndex
  if not DecorIndex then return end

  local decorID = it.decorID or (it.source and it.source.decorID)
  if not decorID then return end

  local entry = DecorIndex[decorID]
  local item = entry and entry.item
  local ireq = item and item.requirements
  return (type(ireq) == "table") and ireq or nil
end

local function GetRepNameFromReq(req)
  if not req then return end

  local rep = req.rep or req.reputation
  if rep == nil then return end

  if type(rep) == "string" then
    if rep == "" then return "" end
    local low = rep:lower()
    if low == "true" or low == "yes" or low == "1" then
      return ""
    end
    return rep
  end

  if type(rep) == "table" then
    return rep.name
      or rep.title
      or rep.faction
      or rep.factionName
      or rep.repName
      or (rep.id and tostring(rep.id))
      or ""
  end

  if type(rep) == "number" then
    return tostring(rep)
  end
end

function U.GetAQAndRepLines(it)
  local req = GetRequirementsTable(it)
  if not req then return end

  local aqLine
  local ach = req.achievement
  local q = req.quest

  if type(ach) == "table" and ach.id then
    local id = ach.id
    local name = ach.title or ach.name or GetAchievementTitle(id) or ("Achievement #" .. tostring(id))
    aqLine = "|cffffd100*|r |cffd8d8d8Achievement: " .. tostring(name) .. "|r"
  elseif type(q) == "table" and q.id then
    local id = q.id
    local name = q.title or q.name or GetQuestTitle(id) or ("Quest #" .. tostring(id))
    aqLine = "|cffffd100!|r |cffd8d8d8Quest: " .. tostring(name) .. "|r"
  end

  local repLine
  local _, _, Req = GetViewerHooks()
  if Req and Req.GetRepRequirement and Req.BuildRepDisplay then
    local repReq = Req.GetRepRequirement(it)
    local s = Req.BuildRepDisplay(repReq, false)
    if s and s ~= "" then
      repLine = s
    end
  end

  if not repLine then
    local rn = GetRepNameFromReq(req)
    if rn ~= nil then
      if rn ~= "" then
        repLine = "|cffb0b0b0Reputation: " .. rn .. "|r"
      else
        repLine = "|cffb0b0b0Reputation required|r"
      end
    end
  end

  return aqLine, repLine
end

function U.BuildTitleSuffix(it)
  local req = GetRequirementsTable(it)
  if not req then return "" end

  local out, n = {}, 0

  local ach = req.achievement
  if type(ach) == "table" and (ach.id or ach.title or ach.name) then
    n = n + 1
    out[n] = "[Achievement]"
  end

  local q = req.quest
  if type(q) == "table" and (q.id or q.title or q.name) then
    n = n + 1
    out[n] = "[Quest]"
  end

  local rn = GetRepNameFromReq(req)
  if rn ~= nil then
    n = n + 1
    out[n] = (rn ~= "" and ("[Reputation: " .. rn .. "]")) or "[Reputation]"
  end

  if n == 0 then return "" end
  return " " .. concat(out, " ")
end

return U
