local ADDON, NS = ...
NS.Systems = NS.Systems or {}

local MapPins = NS.Systems.MapPins or {}
NS.Systems.MapPins = MapPins

local D = NS.Systems.MapPinsData or {}
NS.Systems.MapPinsData = D
MapPins.Data = D

local pairs = pairs
local wipe = wipe or function(t) for k in pairs(t) do t[k] = nil end end
local C_Map = C_Map
local NPCNames = NS.Systems and NS.Systems.NPCNames
local U = NS.Systems.MapPinsUtil

D.mapIndex = {}
D.zoneToContinent = {}
D.SPECIAL_ZONES = { [2352] = true, [2351] = true }
D.CONTINENT_IDS = {
  [619] = true, [875] = true, [876] = true, [1978] = true, [2274] = true,
  [13] = true, [12] = true, [101] = true, [113] = true, [948] = true,
  [905] = true, [424] = true, [572] = true,
}

function D.BuildIndex()
  wipe(D.mapIndex)
  wipe(D.zoneToContinent)

  local Vendors = NS.Data and NS.Data.Vendors
  if type(Vendors) ~= "table" then return end

  local parseWorldmap = U and U.ParseWorldmap
  if not parseWorldmap then return end

  local seenVendorsByMap = {}

  for regionKey, regions in pairs(Vendors) do
    if type(regions) == "table" then
      for listKey, vendorList in pairs(regions) do
        if type(vendorList) == "table" then
          for vendorIndex = 1, #vendorList do
            local vendor = vendorList[vendorIndex]
            local source = vendor and vendor.source
            local id = source and source.id
            local zone = source and source.zone
            local faction = source and source.faction
            local mapID, x, y = parseWorldmap(source and source.worldmap)
            if mapID and id then
              local seenInMap = seenVendorsByMap[mapID]
              if not seenInMap then
                seenInMap = {}
                seenVendorsByMap[mapID] = seenInMap
              end
              local vendorID = tonumber(id)
              if not seenInMap[vendorID] then
                seenInMap[vendorID] = true
                local mapVendors = D.mapIndex[mapID]
                if not mapVendors then mapVendors = {}; D.mapIndex[mapID] = mapVendors end
                mapVendors[#mapVendors + 1] = { id = vendorID, mapID = mapID, x = x, y = y, zone = zone, faction = faction }
              end
            end
          end
        end
      end
    end
  end

  if C_Map and C_Map.GetMapInfo then
    for mapID in pairs(D.mapIndex) do
      local currentMapID = mapID
      for iterCount = 1, 10 do
        local info = C_Map.GetMapInfo(currentMapID)
        if not info then break end
        if info.parentMapID and D.CONTINENT_IDS[info.parentMapID] then
          D.zoneToContinent[mapID] = info.parentMapID
          break
        end
        if D.SPECIAL_ZONES[mapID] or not info.parentMapID or info.parentMapID == 0 or info.parentMapID == currentMapID then
          break
        end
        currentMapID = info.parentMapID
      end
    end
  end

  if NPCNames and NPCNames.PrefetchMany then
    local allVendorIDs = {}
    for mapKey, vendorList in pairs(D.mapIndex) do
      for vendorIndex = 1, #vendorList do
        allVendorIDs[#allVendorIDs + 1] = vendorList[vendorIndex].id
      end
    end
    if #allVendorIDs > 0 then
      NPCNames.PrefetchMany(allVendorIDs)
    end
  end

  for mapID, vendorList in pairs(D.mapIndex) do
    for vendorIndex = 1, #vendorList do
      local vendor = vendorList[vendorIndex]
      if NPCNames and NPCNames.Get then
        vendor.name = NPCNames.Get(vendor.id)
      end
      if not vendor.name or vendor.name == "" then
        vendor.name = "Vendor #" .. vendor.id
      end
    end
  end
end

function D.GetZoneCenterOnMap(zoneMapID, parentMapID)
  if not C_Map or not C_Map.GetMapRectOnMap then return nil end
  local minX, maxX, minY, maxY = C_Map.GetMapRectOnMap(zoneMapID, parentMapID)
  if minX and maxX and minY and maxY then
    return { x = (minX + maxX) / 2, y = (minY + maxY) / 2 }
  end
  return nil
end

function D.CountVendorsInZone(zoneMapID)
  local list = D.mapIndex[zoneMapID]
  return list and #list or 0
end

function D.ResolveNamesFor(vendorList)
  if not vendorList then return end
  for vendorIndex = 1, #vendorList do
    local vendor = vendorList[vendorIndex]
    if vendor and not vendor.name then
      if NPCNames and NPCNames.Get then
        vendor.name = NPCNames.Get(vendor.id)
      end
      if not vendor.name or vendor.name == "" then
        vendor.name = "Vendor #" .. vendor.id
      end
    end
  end
end

return D
