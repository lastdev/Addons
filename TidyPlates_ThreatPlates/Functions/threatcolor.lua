local ADDON_NAME, NAMESPACE = ...
ThreatPlates = NAMESPACE.ThreatPlates

---------------------------------------------------------------------------------------------------
-- Imported functions and constants
---------------------------------------------------------------------------------------------------
local RGB = ThreatPlates.RGB
local COLOR_TRANSPARENT = RGB(0, 0, 0, 0)
--local COLOR_TAPPED = RGB(100, 100, 100)

local function SetThreatColor(unit)
  local db = TidyPlatesThreat.db.profile
  local style, unique_setting = TidyPlatesThreat.SetStyle(unit)

  local c = COLOR_TRANSPARENT

--  if unit.unitid and ThreatPlates_IsTapDenied(unit.unitid) then
--    -- tapped unit: grey if not a player and can't get tap on unit
--    c = COLOR_TAPPED
--  end

  if style == "unique" and unique_setting.UseThreatGlow then
    -- set style to tank/dps or normal
    style = TidyPlatesThreat.GetThreatStyle(unit)
  end

  -- problem with this is if threat system is enabled, it does not work for unique - which it should in this case!
  if style == "dps" or style == "tank" or (style == "normal" and InCombatLockdown()) then
    if db.ShowThreatGlowOnAttackedUnitsOnly and unit.unitid then
      local _, threatStatus = UnitDetailedThreatSituation("player", unit.unitid);
      if (threatStatus ~= nil) then
        c = db.settings[style]["threatcolor"][unit.threatSituation]
      end
    else
      c = db.settings[style]["threatcolor"][unit.threatSituation]
    end
  end

  return c.r, c.g, c.b, c.a
end

TidyPlatesThreat.SetThreatColor = SetThreatColor
