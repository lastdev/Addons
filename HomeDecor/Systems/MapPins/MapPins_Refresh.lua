local ADDON, NS = ...
NS.Systems = NS.Systems or {}

local MapPins = NS.Systems.MapPins or {}
NS.Systems.MapPins = MapPins

local R = NS.Systems.MapPinsRefresh or {}
NS.Systems.MapPinsRefresh = R
MapPins.Refresh = R

local GameTooltip = GameTooltip
local IsShiftKeyDown = IsShiftKeyDown
local WorldMapFrame = WorldMapFrame
local LibStub = LibStub
local HBDPins = LibStub and LibStub("HereBeDragons-Pins-2.0", true)
local C_Map = C_Map
local U = NS.Systems.MapPinsUtil
local D = NS.Systems.MapPinsData
local P = NS.Systems.MapPinsPools
local TooltipSys = NS.UI and NS.UI.Tooltips

function R.AddWorldPinsForMap(mapID)
  if not HBDPins then return end
  P.ClearWorldPins()
  local vendorList = D.mapIndex[mapID]
  if type(vendorList) ~= "table" or #vendorList == 0 then return end

  D.ResolveNamesFor(vendorList)
  local style, color, size = U.GetPinSettings()
  local PIN_SIZE = U and U.PIN_SIZE_WORLD or 16

  for vendorIndex = 1, #vendorList do
    local vendor = vendorList[vendorIndex]
    local pinFrame = P.EnsurePool()
    pinFrame.vendor = vendor
    pinFrame:SetSize(PIN_SIZE * size, PIN_SIZE * size)
    P.ApplyPinStyle(pinFrame, style, color, size)

    pinFrame:SetScript("OnEnter", function(self)
      if not self.vendor then return end
      local v = self.vendor
      local npcID = v.id
      local zoneName = v.zone
      local vendorName = v.name
      local shiftKeyDown = IsShiftKeyDown and IsShiftKeyDown()
      GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
      GameTooltip:SetText(vendorName or "Vendor", 1, 1, 1)
      if zoneName then GameTooltip:AddLine(zoneName, 0.8, 0.8, 0.8) end
      local faction = U.GetFactionForVendor(v)
      if faction then
        local factionText = faction
        if faction == "Alliance" then factionText = "|TInterface\\FriendsFrame\\PlusManz-Alliance:16:16|t " .. faction
        elseif faction == "Horde" then factionText = "|TInterface\\FriendsFrame\\PlusManz-Horde:16:16|t " .. faction
        elseif faction == "Both" then factionText = "|TInterface\\FriendsFrame\\PlusManz-Alliance:16:16|t |TInterface\\FriendsFrame\\PlusManz-Horde:16:16|t Both"
        end
        GameTooltip:AddDoubleLine("Faction", factionText, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8)
      end
      local classLabel = U.GetClassLabelForVendor(npcID)
      if classLabel then
        local classColor = U.CLASS_COLORS and U.CLASS_COLORS[classLabel]
        if classColor then
          GameTooltip:AddDoubleLine("Requires", classLabel, 0.8, 0.8, 0.8, classColor.r, classColor.g, classColor.b)
        else
          GameTooltip:AddDoubleLine("Requires", classLabel, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8)
        end
      end
      GameTooltip:AddLine(" ", 0, 0, 0)
      local hasWaypoint = MapPins.IsActiveWaypoint and MapPins:IsActiveWaypoint(v.mapID, v.x, v.y, npcID)
      GameTooltip:AddLine(hasWaypoint and "Left-click: Clear waypoint" or "Left-click: Set waypoint", 1, 0.82, 0)
      GameTooltip:AddLine("Right-click: Show vendor items", 1, 0.82, 0)
      if shiftKeyDown and npcID then GameTooltip:AddLine("NPC ID: " .. npcID, 0.8, 0.8, 0.8) end
      if npcID and TooltipSys and type(TooltipSys.AppendNpcMouseover) == "function" then
        pcall(TooltipSys.AppendNpcMouseover, GameTooltip, npcID)
      end
      GameTooltip:Show()
    end)

    pinFrame:SetScript("OnLeave", function() if GameTooltip then GameTooltip:Hide() end end)

    pinFrame:SetScript("OnClick", function(self, mouseButton)
      local vendor = self.vendor
      if not vendor then return end
      if mouseButton == "LeftButton" then
        local mapID, x, y = vendor.mapID, vendor.x, vendor.y
        if mapID and x and y then
          if MapPins.IsActiveWaypoint and MapPins:IsActiveWaypoint(mapID, x, y, vendor.id) then
            MapPins:ClearUserWaypoint()
          else
            MapPins:SetUserWaypoint(mapID, x, y, vendor.id)
          end
          if MapPins.RefreshTooltip then MapPins.RefreshTooltip() end
        end
        return
      end
      if mouseButton == "RightButton" then
        local MapPopup = NS.UI and NS.UI.MapPopup
        if MapPopup and MapPopup.Show then
          MapPopup:Show(vendor.id, vendor)
        end
      end
    end)

    pinFrame:Show()
    P.usedWorld[pinFrame] = true
    pcall(function()
      HBDPins:AddWorldMapIconMap(ADDON, pinFrame, mapID, vendor.x, vendor.y, HBD_PINS_WORLDMAP_SHOW_PARENT)
    end)
  end
end

function R.AddMiniPinsForMap(mapID)
  if not HBDPins then return end
  P.ClearMiniPins()
  local vendorList = D.mapIndex[mapID]
  if type(vendorList) ~= "table" or #vendorList == 0 then return end

  D.ResolveNamesFor(vendorList)
  local style, color, size = U.GetPinSettings()
  local PIN_SIZE = U and U.PIN_SIZE_MINI or 14

  for vendorIndex = 1, #vendorList do
    local vendor = vendorList[vendorIndex]
    local pinFrame = P.EnsurePool()
    pinFrame.vendor = vendor
    pinFrame:SetSize(PIN_SIZE * size, PIN_SIZE * size)
    P.ApplyPinStyle(pinFrame, style, color, size)

    pinFrame:SetScript("OnEnter", function(self)
      if not self.vendor then return end
      local v = self.vendor
      local npcID = v.id
      local zoneName = v.zone
      local vendorName = v.name
      local shiftKeyDown = IsShiftKeyDown and IsShiftKeyDown()
      GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
      GameTooltip:SetText(vendorName or "Vendor", 1, 1, 1)
      if zoneName then GameTooltip:AddLine(zoneName, 0.8, 0.8, 0.8) end
      local faction = U.GetFactionForVendor(v)
      if faction then
        local factionText = faction
        if faction == "Alliance" then factionText = "|TInterface\\FriendsFrame\\PlusManz-Alliance:16:16|t " .. faction
        elseif faction == "Horde" then factionText = "|TInterface\\FriendsFrame\\PlusManz-Horde:16:16|t " .. faction
        elseif faction == "Both" then factionText = "|TInterface\\FriendsFrame\\PlusManz-Alliance:16:16|t |TInterface\\FriendsFrame\\PlusManz-Horde:16:16|t Both"
        end
        GameTooltip:AddDoubleLine("Faction", factionText, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8)
      end
      local classLabel = U.GetClassLabelForVendor(npcID)
      if classLabel then
        local classColor = U.CLASS_COLORS and U.CLASS_COLORS[classLabel]
        if classColor then
          GameTooltip:AddDoubleLine("Requires", classLabel, 0.8, 0.8, 0.8, classColor.r, classColor.g, classColor.b)
        else
          GameTooltip:AddDoubleLine("Requires", classLabel, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8)
        end
      end
      GameTooltip:AddLine(" ", 0, 0, 0)
      local hasWaypoint = MapPins.IsActiveWaypoint and MapPins:IsActiveWaypoint(v.mapID, v.x, v.y, npcID)
      GameTooltip:AddLine(hasWaypoint and "Left-click: Clear waypoint" or "Left-click: Set waypoint", 1, 0.82, 0)
      GameTooltip:AddLine("Right-click: Show vendor items", 1, 0.82, 0)
      if shiftKeyDown and npcID then GameTooltip:AddLine("NPC ID: " .. npcID, 0.8, 0.8, 0.8) end
      if npcID and TooltipSys and type(TooltipSys.AppendNpcMouseover) == "function" then
        pcall(TooltipSys.AppendNpcMouseover, GameTooltip, npcID)
      end
      GameTooltip:Show()
    end)

    pinFrame:SetScript("OnLeave", function() if GameTooltip then GameTooltip:Hide() end end)

    pinFrame:SetScript("OnClick", function(self, mouseButton)
      local vendor = self.vendor
      if not vendor then return end
      if mouseButton == "LeftButton" then
        local mapID, x, y = vendor.mapID, vendor.x, vendor.y
        if mapID and x and y then
          if MapPins.IsActiveWaypoint and MapPins:IsActiveWaypoint(mapID, x, y, vendor.id) then
            MapPins:ClearUserWaypoint()
          else
            MapPins:SetUserWaypoint(mapID, x, y, vendor.id)
          end
          if MapPins.RefreshTooltip then MapPins.RefreshTooltip() end
        end
        return
      end
      if mouseButton == "RightButton" then
        local MapPopup = NS.UI and NS.UI.MapPopup
        if MapPopup and MapPopup.Show then
          MapPopup:Show(vendor.id, vendor)
        end
      end
    end)

    pinFrame:Show()
    P.usedMini[pinFrame] = true
    pcall(function()
      HBDPins:AddMinimapIconMap(ADDON, pinFrame, mapID, vendor.x, vendor.y, true)
    end)
  end
end

function R.ShowZoneBadges(continentMapID)
  P.ClearBadges()
  local style, color, size = U.GetPinSettings()
  local PIN_SIZE_BADGE = U and U.PIN_SIZE_BADGE or 22
  local zoneCounts = {}
  for zoneMapID, continentID in pairs(D.zoneToContinent) do
    if continentID == continentMapID and not D.SPECIAL_ZONES[zoneMapID] then
      local count = D.CountVendorsInZone(zoneMapID)
      if count > 0 then zoneCounts[zoneMapID] = count end
    end
  end

  for zoneMapID, vendorCount in pairs(zoneCounts) do
    local zoneCenter = D.GetZoneCenterOnMap(zoneMapID, continentMapID)
    if zoneCenter then
      local zoneName = "Zone"
      if C_Map and C_Map.GetMapInfo then
        local info = C_Map.GetMapInfo(zoneMapID)
        if info then zoneName = info.name end
      end
      local frame = P.EnsureBadgePool()
      frame.badgeData = { mapID = zoneMapID, zoneName = zoneName, vendorCount = vendorCount }
      frame:SetSize(PIN_SIZE_BADGE * size, PIN_SIZE_BADGE * size)
      P.ApplyBadgeStyle(frame, style, color, size)
      frame.count:SetText(tostring(vendorCount))
      frame:SetScript("OnEnter", function(self)
        if not self.badgeData then return end
        local badgeData = self.badgeData
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText((badgeData.vendorCount or 0) .. " Vendors", 1, 1, 1)
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("Left-click: View zone map", 0.5, 0.5, 0.5)
        GameTooltip:AddLine("Right-click: Show all vendors", 1, 0.82, 0)
        GameTooltip:Show()
      end)
      frame:SetScript("OnLeave", function() if GameTooltip then GameTooltip:Hide() end end)
      frame:SetScript("OnClick", function(self, button)
        if not self.badgeData then return end
        if button == "LeftButton" and self.badgeData.mapID then
          if WorldMapFrame and type(WorldMapFrame.SetMapID) == "function" then
            WorldMapFrame:SetMapID(self.badgeData.mapID)
          end
        end
        if button == "RightButton" and self.badgeData.mapID then
          local vendors = {}
          local seenVendorIDs = {}
          local vendorList = D.mapIndex[self.badgeData.mapID]
          if vendorList and #vendorList > 0 then
            for i = 1, #vendorList do
              local vendor = vendorList[i]
              if not seenVendorIDs[vendor.id] then
                seenVendorIDs[vendor.id] = true
                vendors[#vendors + 1] = { id = vendor.id, data = vendor }
              end
            end
          end
          if #vendors > 0 then
            local MapPopup = NS.UI and NS.UI.MapPopup
            if MapPopup and MapPopup.ShowMultiple then MapPopup:ShowMultiple(vendors) end
          end
        end
      end)
      frame:Show()
      P.usedBadges[frame] = true
      pcall(function()
        HBDPins:AddWorldMapIconMap(ADDON, frame, continentMapID, zoneCenter.x, zoneCenter.y, HBD_PINS_WORLDMAP_SHOW_CONTINENT)
      end)
    end
  end
end

function R.ShowContinentBadges()
  P.ClearBadges()
  local style, color, size = U.GetPinSettings()
  local PIN_SIZE_BADGE = U and U.PIN_SIZE_BADGE or 22
  local continentVendors = {}
  for zoneMapID, continentID in pairs(D.zoneToContinent) do
    local vendorList = D.mapIndex[zoneMapID]
    if vendorList and #vendorList > 0 then
      if not continentVendors[continentID] then continentVendors[continentID] = {} end
      for i = 1, #vendorList do
        local vendor = vendorList[i]
        if vendor and vendor.id then continentVendors[continentID][vendor.id] = true end
      end
    end
  end
  local continentCounts = {}
  for continentID, vendorSet in pairs(continentVendors) do
    local count = 0
    for vid in pairs(vendorSet) do count = count + 1 end
    continentCounts[continentID] = count
  end

  for continentID, vendorCount in pairs(continentCounts) do
    local continentName = "Continent"
    if C_Map and C_Map.GetMapInfo then
      local info = C_Map.GetMapInfo(continentID)
      if info then continentName = info.name end
    end
    local frame = P.EnsureBadgePool()
    frame.badgeData = { mapID = continentID, zoneName = continentName, vendorCount = vendorCount, isContinent = true }
    frame:SetSize(PIN_SIZE_BADGE * size, PIN_SIZE_BADGE * size)
    P.ApplyBadgeStyle(frame, style, color, size)
    frame.count:SetText(tostring(vendorCount))
    frame:SetScript("OnEnter", function(self)
      if not self.badgeData then return end
      local badgeData = self.badgeData
      GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
      GameTooltip:SetText((badgeData.vendorCount or 0) .. " Vendors", 1, 1, 1)
      GameTooltip:AddLine(" ")
      GameTooltip:AddLine("Left-click: View zone map", 0.5, 0.5, 0.5)
      GameTooltip:AddLine("Right-click: Show all vendors", 1, 0.82, 0)
      GameTooltip:Show()
    end)
    frame:SetScript("OnLeave", function() if GameTooltip then GameTooltip:Hide() end end)
    frame:SetScript("OnClick", function(self, button)
      if not self.badgeData then return end
      if button == "LeftButton" and self.badgeData.mapID then
        local WorldMapFrame = _G.WorldMapFrame
        if WorldMapFrame and type(WorldMapFrame.SetMapID) == "function" then WorldMapFrame:SetMapID(self.badgeData.mapID) end
      end
      if button == "RightButton" and self.badgeData.mapID then
        local vendors = {}
        local seenVendorIDs = {}
        if self.badgeData.isContinent then
          for zoneMapID, continentID in pairs(D.zoneToContinent) do
            if continentID == self.badgeData.mapID then
              local zoneVendors = D.mapIndex[zoneMapID]
              if zoneVendors and #zoneVendors > 0 then
                for i = 1, #zoneVendors do
                  local vendor = zoneVendors[i]
                  if not seenVendorIDs[vendor.id] then
                    seenVendorIDs[vendor.id] = true
                    vendors[#vendors + 1] = { id = vendor.id, data = vendor }
                  end
                end
              end
            end
          end
        else
          local vendorList = D.mapIndex[self.badgeData.mapID]
          if vendorList and #vendorList > 0 then
            for i = 1, #vendorList do
              local vendor = vendorList[i]
              if not seenVendorIDs[vendor.id] then
                seenVendorIDs[vendor.id] = true
                vendors[#vendors + 1] = { id = vendor.id, data = vendor }
              end
            end
          end
        end
        if #vendors > 0 then
          local MapPopup = NS.UI and NS.UI.MapPopup
          if MapPopup and MapPopup.ShowMultiple then MapPopup:ShowMultiple(vendors) end
        end
      end
    end)
    frame:Show()
    P.usedBadges[frame] = true
    pcall(function()
      HBDPins:AddWorldMapIconMap(ADDON, frame, continentID, 0.5, 0.5, HBD_PINS_WORLDMAP_SHOW_WORLD)
    end)
  end

  for specialZoneID in pairs(D.SPECIAL_ZONES) do
    local count = D.CountVendorsInZone(specialZoneID)
    if count > 0 then
      local zoneName = "Special Zone"
      if C_Map and C_Map.GetMapInfo then
        local info = C_Map.GetMapInfo(specialZoneID)
        if info then zoneName = info.name end
      end
      local frame = P.EnsureBadgePool()
      frame.badgeData = { mapID = specialZoneID, zoneName = zoneName, vendorCount = count, isSpecial = true }
      frame:SetSize(PIN_SIZE_BADGE * size, PIN_SIZE_BADGE * size)
      P.ApplyBadgeStyle(frame, style, color, size)
      frame.count:SetText(tostring(count))
      frame:SetScript("OnEnter", function(self)
        if not self.badgeData then return end
        local badgeData = self.badgeData
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText((badgeData.vendorCount or 0) .. " Vendors", 1, 1, 1)
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("Left-click: View zone map", 0.5, 0.5, 0.5)
        GameTooltip:AddLine("Right-click: Show all vendors", 1, 0.82, 0)
        GameTooltip:Show()
      end)
      frame:SetScript("OnLeave", function() if GameTooltip then GameTooltip:Hide() end end)
      frame:SetScript("OnClick", function(self, button)
        if not self.badgeData then return end
        if button == "LeftButton" and self.badgeData.mapID then
          if WorldMapFrame and type(WorldMapFrame.SetMapID) == "function" then WorldMapFrame:SetMapID(self.badgeData.mapID) end
        end
        if button == "RightButton" and self.badgeData.mapID then
          local vendors = {}
          local seenVendorIDs = {}
          local vendorList = D.mapIndex[self.badgeData.mapID]
          if vendorList and #vendorList > 0 then
            for i = 1, #vendorList do
              local vendor = vendorList[i]
              if not seenVendorIDs[vendor.id] then
                seenVendorIDs[vendor.id] = true
                vendors[#vendors + 1] = { id = vendor.id, data = vendor }
              end
            end
          end
          if #vendors > 0 then
            local MapPopup = NS.UI and NS.UI.MapPopup
            if MapPopup and MapPopup.ShowMultiple then MapPopup:ShowMultiple(vendors) end
          end
        end
      end)
      frame:Show()
      P.usedBadges[frame] = true
      local x, y = 0.5, 0.5
      if specialZoneID == 2352 then x, y = 0.35, 0.35 elseif specialZoneID == 2351 then x, y = 0.65, 0.35 end
      pcall(function()
        HBDPins:AddWorldMapIconMap(ADDON, frame, specialZoneID, x, y, HBD_PINS_WORLDMAP_SHOW_WORLD)
      end)
    end
  end
end

return R