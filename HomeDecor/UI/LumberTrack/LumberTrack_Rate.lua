local ADDON, NS = ...
NS.UI = NS.UI or {}

local R = {}
NS.UI.LumberTrackRate = R
local Utils = NS.LT.Utils

local time = Utils.GetTime

R.mostRecentItemID = nil
R.mostRecentTime = 0

local MAX_HISTORY = 180
local CLEANUP_THRESHOLD = 120

function R:InitItem(itemID)
  if not self.data then self.data={} end
  if self.data[itemID] then return end
  self.data[itemID] = { history={}, sessionStart = 0, sessionGained = 0, lastCount = 0, currentRate = 0, perSecond = 0 }
end

local function CleanHistory(history, now, maxAge)
  maxAge = maxAge or 60
  local firstValid = 1
  for i = 1, #history do
    if now - history[i]<=maxAge then
      firstValid = i
      break
    end
  end
  
  if firstValid > 1 then
    local newHistory = {}
    for i = firstValid, #history do newHistory[#newHistory+1]=history[i] end
    Utils.Wipe(history)
    for i = 1, #newHistory do history[i]=newHistory[i] end
  end
  
  if #history > MAX_HISTORY then
    local keep = {}
    local startIdx = #history - MAX_HISTORY + 1
    for i = startIdx, #history do keep[#keep+1]=history[i] end
    Utils.Wipe(history)
    for i = 1, #keep do history[i]=keep[i] end
  end
end

function R:RecordGain(itemID, amount)
  self:InitItem(itemID)
  local data = self.data[itemID]
  local now = time()
  
  CleanHistory(data.history, now, 60)
  
  local safeAmount = math.min(amount, 1000)
  for i = 1, safeAmount do data.history[#data.history+1]=now end
  
  if #data.history > CLEANUP_THRESHOLD then CleanHistory(data.history, now, 45) end
  
  data.sessionGained = data.sessionGained + amount
  self.mostRecentItemID = itemID
  self.mostRecentTime = now
end

function R:CalculateRate(itemID)
  if not self.data or not self.data[itemID] then return 0 end
  local data = self.data[itemID]
  local now = time()
  CleanHistory(data.history, now, 60)
  local rate = #data.history
  data.currentRate = rate
  data.perSecond = rate / 60
  return rate
end

function R:UpdateAll()
  if not self.data then return end
  local now = time()
  for itemID, data in pairs(self.data) do
    self:CalculateRate(itemID)
    local timeSinceLastGain = #data.history > 0 and (now - data.history[#data.history]) or 999999
    local hasRecentActivity = timeSinceLastGain < 300
    local hasSessionGains = (data.sessionGained or 0)>0
    if not hasRecentActivity and not hasSessionGains then Utils.Wipe(data.history) end
  end
end

function R:CheckGains(counts)
  if not counts then return end
  if not self.data then self.data={} end
  
  local latestGainItemID, latestGainAmount = nil, 0
  for itemID, newCount in pairs(counts) do
    self:InitItem(itemID)
    local data = self.data[itemID]
    local oldCount = data.lastCount or 0
    if newCount > oldCount then
      local gained = newCount - oldCount
      self:RecordGain(itemID, gained)
      if gained > latestGainAmount then
        latestGainItemID = itemID
        latestGainAmount = gained
      end
    end
    data.lastCount = newCount
  end
  
  if latestGainItemID then
    self.mostRecentItemID = latestGainItemID
    self.mostRecentTime = time()
  end
end

function R:GetRate(itemID)
  if not self.data or not self.data[itemID] then return 0, 0 end
  local data = self.data[itemID]
  return data.currentRate or 0, data.perSecond or 0
end

function R:GetMostRecentItem()
  return self.mostRecentItemID
end

function R:GetSessionStats(itemID)
  if not self.data or not self.data[itemID] then return 0, 0 end
  local data = self.data[itemID]
  return data.sessionGained or 0, data.sessionStart or 0
end

function R:InitializeFromCounts(counts)
  if not counts then return end
  if not self.data then self.data={} end
  for itemID, count in pairs(counts) do
    self:InitItem(itemID)
    self.data[itemID].lastCount = count
  end
end

function R:ResetSession(itemID)
  if itemID then
    self:InitItem(itemID)
    local data = self.data[itemID]
    data.sessionStart = data.lastCount or 0
    data.sessionGained = 0
    Utils.Wipe(data.history)
  else
    for id in pairs(self.data or {}) do self:ResetSession(id) end
    self.mostRecentItemID = nil
    self.mostRecentTime = 0
  end
end

function R:Clear()
  if self.data then Utils.Wipe(self.data) end
  self.mostRecentItemID = nil
  self.mostRecentTime = 0
end

function R:PeriodicCleanup()
  if not self.data then return end
  local now = time()
  local itemsToRemove = {}
  for itemID, data in pairs(self.data) do
    local timeSinceLastGain = #data.history > 0 and (now - data.history[#data.history]) or 999999
    local hasSessionGains = (data.sessionGained or 0)>0
    if timeSinceLastGain > 600 and not hasSessionGains then
      itemsToRemove[#itemsToRemove+1]=itemID
    else
      CleanHistory(data.history, now, 60)
    end
  end
  for j, itemID in ipairs(itemsToRemove) do self.data[itemID]=nil end
end

return R
