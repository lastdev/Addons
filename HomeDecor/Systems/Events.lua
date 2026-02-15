local ADDON, NS = ...

NS.Systems = NS.Systems or {}
local Events = NS.Systems.Events or {}
NS.Systems.Events = Events

local MONTH = { jan=1,feb=2,mar=3,apr=4,may=5,jun=6,jul=7,aug=8,sep=9,oct=10,nov=11,dec=12 }

local time = _G.time
local date = _G.date
local tonumber = tonumber
local tostring = tostring
local type = type
local pairs = pairs
local ipairs = ipairs
local floor = math.floor
local sort = table.sort
local concat = table.concat

local function Now()
  return time()
end

local function Wipe(t)
  if type(t) ~= "table" then return end
  for k in pairs(t) do t[k] = nil end
end

local function FormatRemaining(sec)
  sec = tonumber(sec) or 0
  if sec < 0 then sec = 0 end
  local d = floor(sec / 86400); sec = sec - d * 86400
  local h = floor(sec / 3600);  sec = sec - h * 3600
  local m = floor(sec / 60)
  if d > 0 then return string.format("%dd %dh", d, h) end
  if h > 0 then return string.format("%dh %dm", h, m) end
  return string.format("%dm", m)
end

local function GetProfile()
  local adb = NS.db and NS.db.profile
  if adb then return adb end
  NS.DB = NS.DB or {}
  NS.DB.profile = NS.DB.profile or {}
  return NS.DB.profile
end

local function EnsureTimers()
  local p = GetProfile()
  p.timers = p.timers or {}
  return p.timers
end

local function Cache(self)
  local c = self.cache
  if c then return c end
  c = {
    date = {},
    flat = { ready = false, list = {} },
    status = { nextCheck = 0, sig = nil, hasActive = false, events = {}, parts = {} },
  }
  self.cache = c
  return c
end

function Events:ParseDateEpoch(str, isEnd)
  if type(str) ~= "string" or str == "" then return nil end

  local dateCache = Cache(self).date
  local key = (isEnd and "E:" or "S:") .. str
  local cached = dateCache[key]
  if cached ~= nil then return cached end

  local n = date("*t")
  local m, d, y

  local mon, day, year = str:match("^%s*([%a]+)%s*[-/ ]%s*(%d%d?)%s*[-/ ]%s*(%d%d%d%d)%s*$")
  if mon and day and year then
    m = MONTH[mon:lower()]
    d = tonumber(day)
    y = tonumber(year)
  else
    mon, day = str:match("^%s*([%a]+)%s*[-/ ]%s*(%d%d?)%s*$")
    if mon and day then
      m = MONTH[mon:lower()]
      d = tonumber(day)
    end
  end

  if not m or not d then
    dateCache[key] = nil
    return nil
  end

  local guessY = y or n.year
  if not y then
    local epochGuess = time({
      year = guessY, month = m, day = d,
      hour = isEnd and 23 or 0,
      min  = isEnd and 59 or 0,
      sec  = isEnd and 59 or 0,
    })
    local today0 = time({ year=n.year, month=n.month, day=n.day, hour=0, min=0, sec=0 })
    if epochGuess and epochGuess < today0 then
      guessY = guessY + 1
    end
  end

  local epoch = time({
    year = guessY, month = m, day = d,
    hour = isEnd and 23 or 0,
    min  = isEnd and 59 or 0,
    sec  = isEnd and 59 or 0,
  })

  dateCache[key] = epoch
  return epoch
end

local function IsEventLeaf(t)
  return type(t) == "table" and type(t.items) == "table" and (t.title or t.name)
end

local function Flatten(root, out, visited, depth)
  if type(root) ~= "table" then return end
  if visited[root] then return end
  visited[root] = true

  depth = (depth or 0) + 1
  if depth > 12 then return end

  if IsEventLeaf(root) then
    out[#out + 1] = root
    return
  end

  local nums
  for k, v in pairs(root) do
    if type(k) == "number" and k >= 1 and floor(k) == k and type(v) == "table" then
      nums = nums or {}
      nums[#nums + 1] = k
    end
  end
  if nums then
    sort(nums)
    for i = 1, #nums do
      Flatten(root[nums[i]], out, visited, depth)
    end
  end

  for k, v in pairs(root) do
    if type(k) ~= "number" and type(v) == "table" then
      Flatten(v, out, visited, depth)
    end
  end
end

function Events:GetEventsFlat()
  local c = Cache(self)
  if c.flat.ready then return c.flat.list end

  local list = {}
  if NS.Data and type(NS.Data.Events) == "table" then
    Flatten(NS.Data.Events, list, {}, 0)
  end

  c.flat.list = list
  c.flat.ready = true
  return list
end

function Events:CleanupTimers(now)
  local timers = EnsureTimers()
  for decorID, endTime in pairs(timers) do
    if (type(decorID) ~= "number" and type(decorID) ~= "string") or type(endTime) ~= "number" or endTime <= now then
      timers[decorID] = nil
    end
  end
end

function Events:RecalcStatus(now)
  local c = Cache(self)
  local s = c.status

  if s.sig and now < (s.nextCheck or 0) then
    return s.hasActive, s.sig
  end

  local MAX_INTERVAL = 300

  self:CleanupTimers(now)
  Wipe(s.events)
  Wipe(s.parts)

  local hasActive = false
  local nextChange = now + MAX_INTERVAL

  local timers = EnsureTimers()
  for _, endTime in pairs(timers) do
    if type(endTime) == "number" and endTime > now and endTime < nextChange then
      nextChange = endTime
    end
  end

  local list = self:GetEventsFlat()
  for _, ev in ipairs(list) do
    if type(ev) == "table" then
      local active = false
      local sEpoch, eEpoch

      if ev.active == true then
        active = true
      else
        sEpoch = tonumber(ev.startsAt) or (ev.startsOn and self:ParseDateEpoch(ev.startsOn, false))
        eEpoch = tonumber(ev.endsAt)   or (ev.endsOn and self:ParseDateEpoch(ev.endsOn, true))

        if sEpoch and eEpoch then
          active = (now >= sEpoch and now <= eEpoch)
        elseif eEpoch then
          active = (now <= eEpoch)
        end

        if not active and sEpoch and sEpoch > now and sEpoch < nextChange then
          nextChange = sEpoch
        elseif active and eEpoch and (eEpoch + 1) > now and (eEpoch + 1) < nextChange then
          nextChange = eEpoch + 1
        elseif (not sEpoch) and eEpoch and (eEpoch + 1) > now and (eEpoch + 1) < nextChange then
          nextChange = eEpoch + 1
        end
      end

      if active then
        ev._startsEpoch = sEpoch
        ev._endsEpoch = eEpoch
        s.events[#s.events + 1] = ev
        hasActive = true
        s.parts[#s.parts + 1] = tostring(ev.title or ev.name or "Event")
      end
    end
  end

  if #s.parts > 1 then sort(s.parts) end
  s.sig = (#s.parts > 0) and concat(s.parts, "|") or ""
  s.hasActive = hasActive

  if nextChange <= now then nextChange = now + 1 end
  s.nextCheck = nextChange

  return hasActive, s.sig
end

function Events:GetEventTimeText(ev, now)
  if type(ev) ~= "table" then return nil end
  now = now or Now()
  local e = ev._endsEpoch or (ev.endsAt and tonumber(ev.endsAt)) or (ev.endsOn and self:ParseDateEpoch(ev.endsOn, true))
  if not e then return nil end
  local remain = e - now
  if remain < 0 then remain = 0 end
  return "Ends in " .. FormatRemaining(remain)
end

function Events:GetTimeText(arg, now)
  now = now or Now()
  if type(arg) == "table" then
    return self:GetEventTimeText(arg, now)
  end
  local e = tonumber(arg)
  if not e then return nil end
  local remain = e - now
  if remain < 0 then remain = 0 end
  return "Ends in " .. FormatRemaining(remain)
end

function Events:Invalidate()
  local c = self.cache
  if not c then return end

  if c.flat then
    c.flat.ready = false
    c.flat.list = {}
  end

  if c.date then
    Wipe(c.date)
  end

  local s = c.status
  if s then
    s.sig = nil
    s.nextCheck = 0
    s.hasActive = false
    if s.events then Wipe(s.events) end
    if s.parts then Wipe(s.parts) end
  end
end

function Events:GetActive()
  self:RecalcStatus(Now())
  return Cache(self).status.events
end

function Events:HasActive()
  local ok = self:RecalcStatus(Now())
  return ok == true
end

return Events
