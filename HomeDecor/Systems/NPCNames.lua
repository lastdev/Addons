local ADDON, NS = ...

NS.Systems = NS.Systems or {}

local NPCNames = {}
NS.Systems.NPCNames = NPCNames

local CreatureInfo = _G.C_CreatureInfo
local TooltipInfo  = _G.C_TooltipInfo
local Timer        = _G.C_Timer

local CreateFrame = _G.CreateFrame
local UIParent    = _G.UIParent
local pcall       = _G.pcall
local tonumber    = _G.tonumber
local type        = _G.type
local pairs       = _G.pairs
local tremove     = _G.table.remove

local MAX_ATTEMPTS    = 8
local PER_TICK_BUDGET = 8
local BASE_DELAY      = 0.20
local MAX_DELAY       = 1.25

local cacheByNpcId     = {}
local attemptsByNpcId  = {}
local queuedByNpcId    = {}
local pendingQueue     = {}

local isPumping        = false
local listeners        = {}
local callbacksByNpcId = {}

local persistentCache
local persistentTried = false

local function getPersistentCache()
  if persistentTried then return persistentCache end
  persistentTried = true

  local db = NS and NS.DB
  if type(db) == "table" then
    local g = db.global
    if type(g) == "table" then
      g.npcNames = g.npcNames or {}
      persistentCache = g.npcNames
      return persistentCache
    end
  end

  if NS and type(NS.globalDB) == "table" then
    NS.globalDB.npcNames = NS.globalDB.npcNames or {}
    persistentCache = NS.globalDB.npcNames
    return persistentCache
  end

  return nil
end

local function loadPersisted(npcID)
  local store = getPersistentCache()
  if not store then return nil end
  local name = store[tostring(npcID)]
  if type(name) == "string" and name ~= "" then
    return name
  end
  return nil
end

local function savePersisted(npcID, name)
  local store = getPersistentCache()
  if not store then return end
  store[tostring(npcID)] = name
end

local tooltipFrame

local function trimText(text)
  if type(text) ~= "string" then return nil end
  text = text:gsub("^%s+", ""):gsub("%s+$", "")
  if text == "" then return nil end
  return text
end

local function ensureTooltipFrame()
  if tooltipFrame then return tooltipFrame end
  tooltipFrame = CreateFrame("GameTooltip", "HomeDecorNPCNameTip", UIParent, "GameTooltipTemplate")
  tooltipFrame:SetOwner(UIParent, "ANCHOR_NONE")
  return tooltipFrame
end

local function fireResolved(npcID, name)
  local list = callbacksByNpcId[npcID]
  if list then
    callbacksByNpcId[npcID] = nil
    for i = 1, #list do
      local fn = list[i]
      if type(fn) == "function" then
        pcall(fn, npcID, name)
      end
    end
  end

  for i = 1, #listeners do
    local fn = listeners[i]
    if type(fn) == "function" then
      pcall(fn, npcID, name)
    end
  end
end

local function getNameFromCreatureInfo(npcID)
  if not CreatureInfo or not CreatureInfo.GetCreatureInfo then return nil end
  local info = CreatureInfo.GetCreatureInfo(npcID)
  return info and trimText(info.name) or nil
end

local function getNameFromTooltipInfo(npcID)
  if not TooltipInfo or not TooltipInfo.GetHyperlink then return nil end

  local links = {
    ("unit:Creature-0-0-0-0-%d-0000000000"):format(npcID),
    ("unit:Creature-0-0-0-0-%d"):format(npcID),
  }

  for i = 1, #links do
    local ok, tipData = pcall(TooltipInfo.GetHyperlink, links[i])
    if ok and type(tipData) == "table" and type(tipData.lines) == "table" then
      local firstLine = tipData.lines[1]
      local text = firstLine and (firstLine.leftText or firstLine.text)
      text = trimText(text)
      if text then return text end
    end
  end

  return nil
end

local function getNameFromTooltipFrame(npcID)
  local tip = ensureTooltipFrame()
  if not tip or not tip.SetHyperlink then return nil end

  local left1 = _G["HomeDecorNPCNameTipTextLeft1"]
  local links = {
    ("unit:Creature-0-0-0-0-%d-0000000000"):format(npcID),
    ("unit:Creature-0-0-0-0-%d"):format(npcID),
  }

  for i = 1, #links do
    tip:ClearLines()
    local ok = pcall(tip.SetHyperlink, tip, links[i])
    if ok and left1 and left1.GetText then
      local name = trimText(left1:GetText())
      if name then return name end
    end
  end

  return nil
end

local function resolveNow(npcID)

  local name = getNameFromCreatureInfo(npcID)
  if name then return name end

  name = getNameFromTooltipInfo(npcID)
  if name then return name end

  return getNameFromTooltipFrame(npcID)
end

local function queueNpc(npcID)
  if queuedByNpcId[npcID] then return end
  queuedByNpcId[npcID] = true
  pendingQueue[#pendingQueue + 1] = npcID
end

local function backoffDelay(npcID)
  local tries = attemptsByNpcId[npcID] or 1
  local delay = BASE_DELAY * (1.35 ^ (tries - 1))
  if delay > MAX_DELAY then delay = MAX_DELAY end
  return delay
end

local function pumpQueue()
  if isPumping then return end
  if not Timer or not Timer.After then return end

  isPumping = true

  Timer.After(0, function()
    isPumping = false

    local budget = PER_TICK_BUDGET
    local retryList = {}

    while budget > 0 and #pendingQueue > 0 do
      budget = budget - 1

      local npcID = tremove(pendingQueue, 1)
      queuedByNpcId[npcID] = nil

      local cached = cacheByNpcId[npcID]
      if cached ~= nil then
        if cached ~= false then
          fireResolved(npcID, cached)
        end
      else
        local name = resolveNow(npcID)
        if name then
          cacheByNpcId[npcID] = name
    savePersisted(npcID, name)
          savePersisted(npcID, name)
          attemptsByNpcId[npcID] = nil
          fireResolved(npcID, name)
        else
          attemptsByNpcId[npcID] = (attemptsByNpcId[npcID] or 0) + 1
          if attemptsByNpcId[npcID] < MAX_ATTEMPTS then
            retryList[#retryList + 1] = npcID
          else
            cacheByNpcId[npcID] = false
          end
        end
      end
    end

    if #retryList > 0 then
      local delay = 0
      for i = 1, #retryList do
        local d = backoffDelay(retryList[i])
        if d > delay then delay = d end
      end

      Timer.After(delay, function()
        for i = 1, #retryList do
          queueNpc(retryList[i])
        end
        if #pendingQueue > 0 then pumpQueue() end
      end)

      return
    end

    if #pendingQueue > 0 then
      pumpQueue()
    end
  end)
end

function NPCNames.Get(npcID, callback)
  npcID = tonumber(npcID)
  if not npcID then
    if type(callback) == "function" then callback(nil, nil) end
    return nil
  end

  if cacheByNpcId[npcID] == nil then
    local persisted = loadPersisted(npcID)
    if persisted then
      cacheByNpcId[npcID] = persisted
    end
  end

  local cached = cacheByNpcId[npcID]
  if cached ~= nil then
    if cached ~= false then
      if type(callback) == "function" then callback(npcID, cached) end
      return cached
    end
    if type(callback) == "function" then callback(npcID, nil) end
    return nil
  end

  local name = resolveNow(npcID)
  if name then
    cacheByNpcId[npcID] = name
    attemptsByNpcId[npcID] = nil
    if type(callback) == "function" then callback(npcID, name) end
    fireResolved(npcID, name)
    return name
  end

  if type(callback) == "function" then
    callbacksByNpcId[npcID] = callbacksByNpcId[npcID] or {}
    callbacksByNpcId[npcID][#callbacksByNpcId[npcID] + 1] = callback
  end

  queueNpc(npcID)
  pumpQueue()
  return nil
end

function NPCNames.Prefetch(npcID)
  npcID = tonumber(npcID)
  if not npcID then return end
  if cacheByNpcId[npcID] ~= nil then return end
  local persisted = loadPersisted(npcID)
  if persisted then cacheByNpcId[npcID] = persisted return end
  queueNpc(npcID)
  pumpQueue()
end

function NPCNames.PrefetchMany(ids)
  if type(ids) ~= "table" then return end
  for i = 1, #ids do
    local npcID = tonumber(ids[i])
    if npcID and cacheByNpcId[npcID] == nil then
      queueNpc(npcID)
    end
  end
  pumpQueue()
end

function NPCNames.RegisterListener(fn)
  if type(fn) ~= "function" then return end
  listeners[#listeners + 1] = fn
end

function NPCNames.ClearCache()
  for k in pairs(cacheByNpcId) do cacheByNpcId[k] = nil end
  for k in pairs(attemptsByNpcId) do attemptsByNpcId[k] = nil end
  for k in pairs(queuedByNpcId) do queuedByNpcId[k] = nil end
  for k in pairs(callbacksByNpcId) do callbacksByNpcId[k] = nil end
  for i = #pendingQueue, 1, -1 do pendingQueue[i] = nil end
end

function NPCNames.PrefetchVendors(vendors)
  if type(vendors) ~= "table" then return end
  local ids = {}
  for i = 1, #vendors do
    local v = vendors[i]
    local src = v and v.source
    local id = src and src.id or v and v.id
    id = tonumber(id)
    if id then
      ids[#ids + 1] = id
    end
  end
  if #ids > 0 then
    NPCNames.PrefetchMany(ids)
  end
end

return NPCNames
