local ADDON, NS = ...
NS.UI = NS.UI or {}

local F = {}
NS.UI.LumberTrackFarming = F

local time = time or GetTime
local floor = math.floor

function F:Init(ctx)
  ctx.farming = ctx.farming or {}
  local f = ctx.farming
  f.active = false
  f.startTime = 0
  f.startTotal = 0
  f.totalGained = 0
  f.perSecond = 0
  f.perMinute = 0
  f.efficiency = 100
  f.topItems = {}
  f.primaryLumberID = nil
  f.paused = false
  f.pauseTime = 0
  f.totalPausedTime = 0
  return ctx
end

function F:Start(ctx, initialGain, itemID)
  if not ctx or not ctx.farming then return end
  local f = ctx.farming
  
  f.active = true
  f.startTime = time()
  f.paused = false
  f.pauseTime = 0
  f.totalPausedTime = 0
  
  local gain = tonumber(initialGain) or tonumber(ctx._autoStartGain) or 0
  local lumber = itemID or ctx._autoStartItemID
  
  f.primaryLumberID = lumber
  
  if lumber and ctx.counts and ctx.counts[lumber] then
    local currentCount = tonumber(ctx.counts[lumber]) or 0
    f.startTotal = math.max(0, currentCount - gain)
    f.totalGained = gain
  else
    f.startTotal = 0
    f.totalGained = gain
  end
  
  local Rate = NS.UI.LumberTrackRate
  if Rate and Rate.ResetSession then Rate:ResetSession() end
  
  self:Update(ctx)
  
  local db = ctx.GetDB and ctx.GetDB()
  if db then db.farmingActive = true end
  
  ctx._autoStartGain = nil
  ctx._autoStartItemID = nil
end

function F:Stop(ctx)
  if not ctx or not ctx.farming then return end
  local f = ctx.farming
  f.active = false
  if f.paused then
    f.totalPausedTime = f.totalPausedTime + (time() - f.pauseTime)
    f.paused = false
  end
  local db = ctx.GetDB and ctx.GetDB()
  if db then db.farmingActive = false end
end

function F:Pause(ctx)
  if not ctx or not ctx.farming or not ctx.farming.active or ctx.farming.paused then return end
  ctx.farming.paused = true
  ctx.farming.pauseTime = time()
  if ctx.farmingStatsUpdate then ctx.farmingStatsUpdate() end
end

function F:Resume(ctx)
  if not ctx or not ctx.farming or not ctx.farming.active or not ctx.farming.paused then return end
  local f = ctx.farming
  f.totalPausedTime = f.totalPausedTime + (time() - f.pauseTime)
  f.paused = false
  f.pauseTime = 0
  if ctx.farmingStatsUpdate then ctx.farmingStatsUpdate() end
end

function F:TogglePause(ctx)
  if not ctx or not ctx.farming then return end
  if ctx.farming.paused then self:Resume(ctx) else self:Pause(ctx) end
end

function F:Toggle(ctx)
  if not ctx or not ctx.farming then return end
  if ctx.farming.active then self:Stop(ctx) else self:Start(ctx, 0) end
end

function F:Update(ctx)
  if not ctx or not ctx.farming or not ctx.farming.active then return end
  
  local f = ctx.farming
  local now = time()
  
  local elapsed = f.paused and (f.pauseTime - f.startTime) - f.totalPausedTime or (now - f.startTime) - f.totalPausedTime
  elapsed = math.max(0, elapsed)
  
  if f.primaryLumberID and ctx.counts and ctx.counts[f.primaryLumberID] then
    local currentCount = tonumber(ctx.counts[f.primaryLumberID]) or 0
    f.totalGained = currentCount - f.startTotal
    if f.totalGained < 0 then
      f.startTotal = currentCount
      f.totalGained = 0
    end
  else
    f.totalGained = 0
  end
  
  if elapsed > 0 then
    f.perSecond = f.totalGained / elapsed
    f.perMinute = f.perSecond * 60
    f.efficiency = floor((f.perMinute / 180) * 100)
    if f.efficiency > 100 then f.efficiency = 100 end
  else
    if f.totalGained > 0 then
      f.perSecond = f.totalGained
      f.perMinute = f.totalGained * 60
      f.efficiency = 100
    else
      f.perSecond = 0
      f.perMinute = 0
      f.efficiency = 0
    end
  end
  
  self:UpdateTopItems(ctx)
end

function F:UpdateTopItems(ctx)
  if not ctx or not ctx.farming or not ctx.list then return end
  local Rate = NS.UI.LumberTrackRate
  if not Rate then return end
  
  local items = {}
  for idx, itemID in ipairs(ctx.list) do
    local rate = Rate:GetRate(itemID)
    local sessionGained = Rate:GetSessionStats(itemID)
    if rate > 0 or sessionGained > 0 then
      table.insert(items, {
        itemID = itemID,
        rate = rate,
        sessionGained = sessionGained,
        name = (ctx.meta[itemID] and ctx.meta[itemID].name) or "Unknown",
        icon = (ctx.meta[itemID] and ctx.meta[itemID].icon) or nil,
      })
    end
  end
  
  table.sort(items, function(a, b)
    if a.sessionGained ~= b.sessionGained then return a.sessionGained > b.sessionGained end
    return a.rate > b.rate
  end)
  
  local top = {}
  for i = 1, math.min(5, #items) do top[i]=items[i] end
  ctx.farming.topItems = top
  
  if not ctx.farming.primaryLumberID and #items > 0 then
    ctx.farming.primaryLumberID = items[1].itemID
  end
end

function F:GetSessionTime(ctx)
  if not ctx or not ctx.farming or not ctx.farming.active then return 0, "0:00" end
  local f = ctx.farming
  local now = time()
  local elapsed = f.paused and (f.pauseTime - f.startTime) - f.totalPausedTime or (now - f.startTime) - f.totalPausedTime
  elapsed = math.max(0, elapsed)
  local minutes = floor(elapsed / 60)
  local seconds = floor(elapsed % 60)
  return elapsed, string.format("%d:%02d", minutes, seconds)
end

function F:GetStats(ctx)
  if not ctx or not ctx.farming then 
    return { active = false, totalGained = 0, perSecond = 0, perMinute = 0, sessionTime="0:00", efficiency = 0, topItems={}}
  end
  local f = ctx.farming
  local _, timeStr = self:GetSessionTime(ctx)
  return {
    active = f.active or false,
    totalGained = f.totalGained or 0,
    perSecond = f.perSecond or 0,
    perMinute = f.perMinute or 0,
    sessionTime = timeStr,
    efficiency = f.efficiency or 0,
    topItems = f.topItems or {}
  }
end

return F
