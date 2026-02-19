local ADDON, NS = ...
NS.Systems = NS.Systems or {}

local MapPins = NS.Systems.MapPins or {}
NS.Systems.MapPins = MapPins

local C_Map = C_Map
local C_SuperTrack = C_SuperTrack
local UiMapPoint = UiMapPoint
local U = NS.Systems.MapPinsUtil or {}
NS.Systems.MapPinsUtil = U
MapPins.Util = U

U.ICON_TEX = "Interface\\AddOns\\HomeDecor\\Media\\Icon"
U.PIN_SIZE_WORLD = 16
U.PIN_SIZE_MINI = 14
U.PIN_SIZE_BADGE = 22
U.WAYPOINT_CLEAR_YARDS = 25

U.VENDOR_CLASS_LABEL = {
  [103693] = "Hunter", [105986] = "Rogue", [112318] = "Shaman", [112323] = "Druid",
  [93550] = "Death Knight", [100196] = "Paladin", [112338] = "Monk", [112392] = "Warrior",
  [112401] = "Priest", [112407] = "Demon Hunter", [112434] = "Warlock", [112440] = "Mage",
}

U.CLASS_COLORS = {
  ["Death Knight"] = { r = 0.77, g = 0.12, b = 0.23 },
  ["Demon Hunter"] = { r = 0.64, g = 0.19, b = 0.79 },
  ["Druid"] = { r = 1.00, g = 0.49, b = 0.04 },
  ["Hunter"] = { r = 0.67, g = 0.83, b = 0.45 },
  ["Mage"] = { r = 0.25, g = 0.78, b = 0.92 },
  ["Monk"] = { r = 0.00, g = 1.00, b = 0.59 },
  ["Paladin"] = { r = 0.96, g = 0.55, b = 0.73 },
  ["Priest"] = { r = 1.00, g = 1.00, b = 1.00 },
  ["Rogue"] = { r = 1.00, g = 0.96, b = 0.41 },
  ["Shaman"] = { r = 0.00, g = 0.44, b = 0.87 },
  ["Warlock"] = { r = 0.53, g = 0.53, b = 0.93 },
  ["Warrior"] = { r = 0.78, g = 0.61, b = 0.43 },
}

function U.ParseWorldmap(worldmap)
  if type(worldmap) ~= "string" then return end
  local mapIDStr, xStr, yStr = worldmap:match("^(%d+):(%d+):(%d+)$")
  if not mapIDStr then return end
  local mapID = tonumber(mapIDStr)
  local x = tonumber(xStr)
  local y = tonumber(yStr)
  if not mapID or not x or not y then return end
  x = x / 10000
  y = y / 10000
  if x <= 0 or y <= 0 or x >= 1 or y >= 1 then return end
  return mapID, x, y
end

function U.GetPinSettings()
  local profile = NS.db and NS.db.profile
  if not profile or not profile.mapPins then
    return "house", { r = 1, g = 1, b = 1 }, 1.0
  end
  local style = profile.mapPins.pinStyle or "house"
  local color = profile.mapPins.pinColor or { r = 1, g = 1, b = 1 }
  local size = profile.mapPins.pinSize or 1.0
  return style, color, size
end

function U.GetClassLabelForVendor(npcID)
  local vendorID = tonumber(npcID)
  return vendorID and U.VENDOR_CLASS_LABEL[vendorID] or nil
end

function U.GetFactionForVendor(vendor)
  if not vendor then return nil end
  local faction = vendor.faction
  if not faction then return nil end
  if type(faction) == "table" then
    local hasAlliance, hasHorde = false, false
    for k, factionValue in pairs(faction) do
      if factionValue == "Alliance" then hasAlliance = true elseif factionValue == "Horde" then hasHorde = true end
    end
    if hasAlliance and hasHorde then return "Both" end
    if hasAlliance then return "Alliance" end
    if hasHorde then return "Horde" end
    return nil
  end
  if faction == "Alliance" or faction == "Horde" or faction == "Neutral" or faction == "Both" then return faction end
  return tostring(faction)
end

function U.IsEnabled(profile, key, default)
  local mapPins = profile and profile.mapPins
  if type(mapPins) ~= "table" then return default end
  local value = mapPins[key]
  if value == nil then return default end
  return value and true or false
end

function U.ClearUserWaypoint(activeWaypointRef)
  if C_Map and C_Map.ClearUserWaypoint then
    pcall(C_Map.ClearUserWaypoint)
  end
  if C_SuperTrack and C_SuperTrack.SetSuperTrackedUserWaypoint then
    pcall(C_SuperTrack.SetSuperTrackedUserWaypoint, false)
  end
  if activeWaypointRef then activeWaypointRef[1] = nil end
end

function U.SetUserWaypoint(mapID, x, y, npcID, activeWaypointRef)
  if not (C_Map and C_Map.SetUserWaypoint and UiMapPoint and UiMapPoint.CreateFromCoordinates) then return end
  local point = UiMapPoint.CreateFromCoordinates(mapID, x, y)
  if not point then return end
  pcall(C_Map.SetUserWaypoint, point)
  if C_SuperTrack and C_SuperTrack.SetSuperTrackedUserWaypoint then
    pcall(C_SuperTrack.SetSuperTrackedUserWaypoint, true)
  end
  if activeWaypointRef then activeWaypointRef[1] = { mapID = mapID, x = x, y = y, npcID = npcID } end
end

function U.IsActiveWaypoint(activeWaypoint, mapID, x, y, npcID)
  if not activeWaypoint then return false end
  if npcID and activeWaypoint.npcID and npcID == activeWaypoint.npcID then return true end
  if mapID and activeWaypoint.mapID == mapID and x and y then
    local deltaX = (activeWaypoint.x or 0) - x
    local deltaY = (activeWaypoint.y or 0) - y
    return (deltaX * deltaX + deltaY * deltaY) < 0.0000005
  end
  return false
end

return U
