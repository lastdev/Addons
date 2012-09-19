function PoJ_GetMouseCoordString()
	local x, y = GetCursorPosition();
  local scale = WorldMapButton:GetEffectiveScale();
  x =     (x / scale - WorldMapButton:GetLeft()  ) / WorldMapButton:GetWidth()
  y = 1 - (y / scale - WorldMapButton:GetBottom()) / WorldMapButton:GetHeight()
  if x >= 0 and x <= 1 and y >= 0 and y <= 1 then
    x = tostring(PoJ_Round(100 * x, 1))
    y = tostring(PoJ_Round(100 * y, 1))
    if strlen(x) < 3 then
      x = x .. ".0"
    end
    if strlen(y) < 3 then
      y = y .. ".0"
    end
    return x .. "    " .. y
  end
  return ""
end


function PoJ_GetPlayerCoordString()
  if not WorldMapFrame:IsVisible() then
    SetMapToCurrentZone()
  end
  local x, y = GetPlayerMapPosition("player")
  if x ~= 0 or y ~= 0 then
    x = tostring(PoJ_Round(100 * x, 1))
    y = tostring(PoJ_Round(100 * y, 1))
    if strlen(x) < 3 then
      x = x .. ".0"
    end
    if strlen(y) < 3 then
      y = y .. ".0"
    end
    return x .. "    " .. y
  end
  return ""
end


function PoJ_ShowCoords()
  PoJ_ShowObject(PoJ_Coord, PoJ_Vars.CoordShow)
end


function PoJ_ShowCoords_Map()
  PoJ_ShowObject(PoJ_MapPlayerCoord, PoJ_Vars.CoordShowMap)
  PoJ_ShowObject(PoJ_MapMouseCoord , PoJ_Vars.CoordShowMap)
  if PoJ_Vars.CoordShowMap then
    PoJ_UpdateCoordPositions()
  end
end


function PoJ_UpdateCoordPositions()
  if not InCombatLockdown() then
    if WORLDMAP_SETTINGS.size == WORLDMAP_WINDOWED_SIZE then
      PoJ_MapPlayerCoord:SetPoint("BOTTOMRIGHT", WorldMapDetailFrame, "BOTTOM", 0, -26);
      PoJ_MapMouseCoord:SetPoint("BOTTOMLEFT", WorldMapDetailFrame, "BOTTOM", 0, -26);
    else
      PoJ_MapPlayerCoord:SetPoint("BOTTOMRIGHT", WorldMapPositioningGuide, "BOTTOM", 0, 4);
      PoJ_MapMouseCoord:SetPoint("BOTTOMLEFT", WorldMapPositioningGuide, "BOTTOM", 0, 4);
    end
  end
end
