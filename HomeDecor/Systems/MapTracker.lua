local ADDON, NS = ...

NS.Systems = NS.Systems or {}
NS.Systems.MapTracker = NS.Systems.MapTracker or {}
local MapTracker = NS.Systems.MapTracker

local C_Map = _G.C_Map
local Enum = _G.Enum
local GetRealZoneText = _G.GetRealZoneText
local CreateFrame = _G.CreateFrame
local C_Timer = _G.C_Timer
local GetTime = _G.GetTime
local wipe = _G.wipe or function(t) for k in pairs(t) do t[k] = nil end end
local tonumber, tostring, type, pairs, ipairs, pcall = tonumber, tostring, type, pairs, ipairs, pcall

local indexBuilt = false
local vendorsByMapID, vendorsByZoneName, vendorsByZoneKey = {}, {}, {}
local continentChildren = {}
local callbacks = {}

local function parseMapID(worldmap)
  if type(worldmap) ~= "string" then return nil end
  local a = worldmap:match("^(%d+):")
  return a and tonumber(a) or nil
end

local function zoneKey(s)
  if type(s) ~= "string" then return nil end
  s = s:lower()
  s = s:gsub("[%c]", "")
  s = s:gsub("%s+", "")
  s = s:gsub("[%p]", "")
  return s
end

local function vendorMapID(v)
  if type(v) ~= "table" then return nil end
  local s = v.source
  return parseMapID(v.worldmap or (s and s.worldmap))
end

local function vendorZoneName(v)
  if type(v) ~= "table" then return nil end
  local s = v.source
  return v.zone or (s and s.zone)
end

local function isVendorRecord(t)
  if type(t) ~= "table" or type(t.items) ~= "table" then return false end
  local s = t.source
  local wm = t.worldmap or (s and s.worldmap)
  local zn = t.zone or (s and s.zone)
  return (wm and wm ~= "") or (zn and zn ~= "")
end

local function buildIndex()
  if indexBuilt then return end
  local root = NS.Data and NS.Data.Vendors
  if type(root) ~= "table" then return end

  local out, seen = {}, {}
  local function walk(node)
    if type(node) ~= "table" or seen[node] then return end
    seen[node] = true
    if isVendorRecord(node) then
      out[#out + 1] = node
      return
    end
    for _, v in pairs(node) do
      if type(v) == "table" then walk(v) end
    end
  end

  walk(root)
  if #out == 0 then return end

  indexBuilt = true
  wipe(vendorsByMapID)
  wipe(vendorsByZoneName)
  wipe(vendorsByZoneKey)

  for i = 1, #out do
    local v = out[i]

    local mid = vendorMapID(v)
    if mid then
      local key = tostring(mid)
      local t = vendorsByMapID[key]
      if not t then t = {}; vendorsByMapID[key] = t end
      t[#t + 1] = v
    end

    local zn = vendorZoneName(v)
    if zn and zn ~= "" then
      local t2 = vendorsByZoneName[zn]
      if not t2 then t2 = {}; vendorsByZoneName[zn] = t2 end
      t2[#t2 + 1] = v

      local zk = zoneKey(zn)
      if zk then
        local t3 = vendorsByZoneKey[zk]
        if not t3 then t3 = {}; vendorsByZoneKey[zk] = t3 end
        t3[#t3 + 1] = v
      end
    end
  end
end

local function getContinentChild(continentID, zoneName)
  if not continentID or not zoneName or zoneName == "" then return nil end

  local byContinent = continentChildren[continentID]
  if not byContinent then
    byContinent = {}
    continentChildren[continentID] = byContinent
  end

  local cached = byContinent[zoneName]
  if cached ~= nil then return cached or nil end

  local child
  if C_Map and C_Map.GetMapChildrenInfo then
    local children = C_Map.GetMapChildrenInfo(continentID, nil, true)
    if type(children) == "table" then
      for i = 1, #children do
        local c = children[i]
        if c and c.mapID and c.name == zoneName then
          child = c.mapID
          break
        end
      end
    end
  end

  byContinent[zoneName] = child or false
  return child
end

local function resolveZoneMapID(mapID, zoneName)
  if not mapID or not C_Map or not C_Map.GetMapInfo then return mapID end

  local ui = Enum and Enum.UIMapType
  local T_CONTINENT = ui and ui.Continent or 2
  local T_ZONE = ui and ui.Zone or 3
  local T_DUNGEON = ui and ui.Dungeon or 4
  local T_CITY = ui and ui.City or 5
  local T_MICRO = ui and ui.Micro or 6
  local T_SCENARIO = ui and ui.Scenario or 7

  local cur, guard = mapID, 0
  local info = C_Map.GetMapInfo(cur)

  while info and info.parentMapID and info.parentMapID > 0 and guard < 25 do
    guard = guard + 1
    local mt = info.mapType
    if mt == T_ZONE or mt == T_DUNGEON or mt == T_CITY or mt == T_MICRO or mt == T_SCENARIO then return cur end
    local parent = info.parentMapID
    if not parent or parent == 0 or parent == cur then break end
    cur = parent
    info = C_Map.GetMapInfo(cur)
  end

  if info and info.mapType == T_CONTINENT then
    local z = zoneName or (GetRealZoneText and GetRealZoneText()) or ""
    local child = getContinentChild(cur, z)
    if child then return child end
  end

  return cur or mapID
end

local function fire(zoneName, mapID)
  for _, fn in pairs(callbacks) do
    pcall(fn, zoneName, mapID)
  end
end

function MapTracker:RegisterCallback(key, fn)
  if type(fn) ~= "function" then return end
  key = key or tostring(fn)
  callbacks[key] = fn
  return key
end

function MapTracker:UnregisterCallback(key)
  if key then callbacks[key] = nil end
end

MapTracker.zoneName = MapTracker.zoneName or nil
MapTracker.zoneMapID = MapTracker.zoneMapID or nil
MapTracker.enabled = MapTracker.enabled or false
MapTracker.queued = MapTracker.queued or false
MapTracker.lastRun = MapTracker.lastRun or 0

function MapTracker:GetCurrentZone()
  return self.zoneName or "", self.zoneMapID
end

function MapTracker:UpdateNow(force)
  if not self.enabled then return end

  local now = (GetTime and GetTime()) or 0
  if not force and (now - (self.lastRun or 0) < 0.25) then return end
  self.lastRun = now

  local zoneText = (GetRealZoneText and GetRealZoneText()) or ""
  local mapID = (C_Map and C_Map.GetBestMapForUnit and C_Map.GetBestMapForUnit("player")) or nil
  if mapID then mapID = resolveZoneMapID(mapID, zoneText) end

  local name = zoneText
  if (not name or name == "") and mapID and C_Map and C_Map.GetMapInfo then
    local info = C_Map.GetMapInfo(mapID)
    if info and info.name and info.name ~= "" then name = info.name end
  end
  if not name then name = "" end

  local changed = (mapID ~= self.zoneMapID) or (name ~= self.zoneName)
  if not changed then return end

  self.zoneName = name
  self.zoneMapID = mapID
  fire(name, mapID)
end

function MapTracker:QueueUpdate(delay, force)
  if not self.enabled then return end

  delay = delay or 0.35

  if self.queued then
    self._rerun = true
    if force then self._rerunForce = true end
    if delay > (self._rerunDelay or 0) then
      self._rerunDelay = delay
    end
    return
  end

  self.queued = true
  self._queuedForce = force and true or false

  C_Timer.After(delay, function()
    if not MapTracker.enabled then
      MapTracker.queued = false
      MapTracker._queuedForce = nil
      MapTracker._rerun = nil
      MapTracker._rerunForce = nil
      MapTracker._rerunDelay = nil
      return
    end

    MapTracker.queued = false
    local runForce = MapTracker._queuedForce
    MapTracker._queuedForce = nil

    MapTracker:UpdateNow(runForce)

    if MapTracker._rerun then
      local rForce = MapTracker._rerunForce
      local rDelay = MapTracker._rerunDelay or 0.55
      MapTracker._rerun = nil
      MapTracker._rerunForce = nil
      MapTracker._rerunDelay = nil
      MapTracker:QueueUpdate(rDelay, rForce)
    end
  end)
end

function MapTracker:Enable(enabled)
  enabled = enabled and true or false
  if enabled == self.enabled then return end
  self.enabled = enabled

  if not enabled then
    if self.frame then self.frame:Hide() end
    return
  end

  buildIndex()
  self:QueueUpdate(0, true)

  if not self.frame then
    local f = CreateFrame("Frame")
    f:RegisterEvent("PLAYER_ENTERING_WORLD")
    f:RegisterEvent("ZONE_CHANGED_NEW_AREA")
    f:RegisterEvent("ZONE_CHANGED")
    f:RegisterEvent("ZONE_CHANGED_INDOORS")
    f:RegisterEvent("ADDON_LOADED")
    f:SetScript("OnEvent", function(_, event, arg1)
      if event == "ADDON_LOADED" then
        if type(arg1) == "string" and (arg1 == ADDON or arg1:match("^" .. ADDON)) then
          MapTracker:ClearCaches()
          MapTracker:QueueUpdate(0.15, true)
        end
        return
      end
      if event == "PLAYER_ENTERING_WORLD" then
        MapTracker:QueueUpdate(0.90, true)
        return
      end
      if event == "ZONE_CHANGED_NEW_AREA" then
        MapTracker:QueueUpdate(0.65, true)
        return
      end
      MapTracker:QueueUpdate(0.35, true)
    end)
    self.frame = f
  else
    self.frame:Show()
  end
end

function MapTracker:ClearCaches()
  indexBuilt = false
  wipe(vendorsByMapID)
  wipe(vendorsByZoneName)
  wipe(vendorsByZoneKey)
  wipe(continentChildren)
end

function MapTracker:GetVendorsForCurrentZone()
  buildIndex()
  local name, mapID = self:GetCurrentZone()
  if mapID then
    local t = vendorsByMapID[tostring(mapID)]
    if t then return t end
  end
  if name and name ~= "" then
    local t2 = vendorsByZoneName[name]
    if t2 then return t2 end
    local zk = zoneKey(name)
    if zk then
      local t3 = vendorsByZoneKey[zk]
      if t3 then return t3 end
    end
  end
  return {}
end

local Collection = NS.Systems and NS.Systems.Collection

local function isCollected(it)
  if not Collection or not Collection.IsCollected then return false end
  local ok, res = pcall(Collection.IsCollected, Collection, it)
  if ok and type(res) == "boolean" then return res end
  local id = (it and it.source and it.source.itemID) or (it and it.itemID) or (it and it.id) or (it and it.decorID)
  local ok2, res2 = pcall(Collection.IsCollected, Collection, id)
  if ok2 and type(res2) == "boolean" then return res2 end
  return false
end

function MapTracker:CountVendor(vendor)
  local total, collected = 0, 0
  local items = vendor and vendor.items
  if type(items) ~= "table" then return 0, 0 end
  for i = 1, #items do
    local it = items[i]
    if type(it) == "table" then
      total = total + 1
      if isCollected(it) then collected = collected + 1 end
    end
  end
  return collected, total
end

function MapTracker:CountVendors(vendors)
  local total, collected = 0, 0
  if type(vendors) ~= "table" then return 0, 0 end
  for i = 1, #vendors do
    local c, t = self:CountVendor(vendors[i])
    collected = collected + c
    total = total + t
  end
  return collected, total
end

return MapTracker
