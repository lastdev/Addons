--------------------------------------------------------------------------------
--[[ worldmap.lua - A collection of utilities for the World Map. ]]--
--
-- by erglo <erglo.coder+WAU@gmail.com>
--
-- Copyright (C) 2024  Erwin D. Glockner (aka erglo)
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see http://www.gnu.org/licenses.
--
-- Further reading:
-- ================
-- REF.: <https://www.townlong-yak.com/framexml/live/Blizzard_APIDocumentationGenerated/MapConstantsDocumentation.lua>
-- REF.: <https://www.townlong-yak.com/framexml/live/Blizzard_APIDocumentationGenerated/MapDocumentation.lua>
-- REF.: <https://www.townlong-yak.com/framexml/live/Blizzard_SharedMapDataProviders/WaypointLocationDataProvider.lua>
-- REF.: <https://www.townlong-yak.com/framexml/live/Blizzard_WorldMap/Blizzard_WorldMapTemplates.lua>
-- REF.: <https://www.townlong-yak.com/framexml/live/Helix/GlobalColors.lua>
-- REF.: <https://www.townlong-yak.com/framexml/live/ObjectAPI/UiMapPoint.lua>
-- 
--------------------------------------------------------------------------------

local _, ns = ...

local utils = ns.utils or {}
ns.utils = utils

local LocalMapUtils = {}
utils.worldmap = LocalMapUtils

local C_Map = C_Map
local C_SuperTrack = C_SuperTrack
local UiMapPoint = UiMapPoint

----- Constants ----------------------------------------------------------------

-------------------------------------------------- Enum.UIMapType.Cosmic

LocalMapUtils.COSMIC_MAP_ID = 946

-------------------------------------------------- Enum.UIMapType.World

LocalMapUtils.AZEROTH_MAP_ID = 947

-------------------------------------------------- Enum.UIMapType.Continent

LocalMapUtils.KALIMDOR_MAP_ID = 12
LocalMapUtils.EASTERN_KINGDOMS_MAP_ID = 13
LocalMapUtils.OUTLAND_MAP_ID = 101
LocalMapUtils.NORTHREND_MAP_ID = 113
LocalMapUtils.PANDARIA_MAP_ID = 424
LocalMapUtils.DRAENOR_MAP_ID = 572
LocalMapUtils.BROKEN_ISLES_MAP_ID = 619
LocalMapUtils.ZANDALAR_MAP_ID = 875
LocalMapUtils.KUL_TIRAS_MAP_ID = 876
LocalMapUtils.ARGUS_MAP_ID = 905
LocalMapUtils.THE_MAELSTROM_MAP_ID = 948
LocalMapUtils.THE_SHADOWLANDS_MAP_ID = 1550
LocalMapUtils.DRAGON_ISLES_MAP_ID = 1978

-------------------------------------------------- Enum.UIMapType.Zone

----- Dragonflight -----

LocalMapUtils.THE_WAKING_SHORES_MAP_ID = 2022
LocalMapUtils.OHNAHRAN_PLAINS_MAP_ID = 2023
LocalMapUtils.THE_AZURE_SPAN_MAP_ID = 2024
LocalMapUtils.THALDRASZUS_MAP_ID = 2025
LocalMapUtils.THEFORBIDDEN_REACH_MAP_ID = 2118
LocalMapUtils.ZARALEK_CAVERN_MAP_ID = 2133
LocalMapUtils.THE_FORBIDDEN_REACH_MAP_ID = 2151
LocalMapUtils.EMERALD_DREAM_MAP_ID = 2200
LocalMapUtils.AMIRDRASSIL_MAP_ID = 2239
-- Thaldraszus
LocalMapUtils.VALDRAKKEN_MAP_ID = 2112
-- Zaralek Cavern
LocalMapUtils.THE_THROUGHWAY_MAP_ID = 2165

----- Shadowlands -----

LocalMapUtils.REVENDRETH_MAP_ID = 1525
LocalMapUtils.BASTION_MAP_ID = 1533
LocalMapUtils.MALDRAXXUS_MAP_ID = 1536
LocalMapUtils.THE_MAW_MAP_ID = 1543  -- alt: 1960
LocalMapUtils.ARDENWEALD_MAP_ID = 1565
LocalMapUtils.ZERETH_MORTIS_MAP_ID = 1970
-- The Maw
LocalMapUtils.KORTHIA_MAP_ID = 1961

-- Note: Some maps, ie. Oribos, etc. are NOT zones (mapType: 3).

----- Battle for Azeroth -----

-- Zandalar
LocalMapUtils.ZULDAZAR_MAP_ID = 862
LocalMapUtils.NAZMIR_MAP_ID = 863
LocalMapUtils.VOLDUN_MAP_ID = 864
-- Kul Tiras
LocalMapUtils.TIRAGARDE_SOUND_MAP_ID = 895
LocalMapUtils.DRUSTVAR_MAP_ID = 896
LocalMapUtils.STORMSONG_VALLEY_MAP_ID = 942
LocalMapUtils.TOL_DAGOR_MAP_ID = 1169
LocalMapUtils.MECHAGON_ISLAND_MAP_ID = 1462
-- Zuldazar
LocalMapUtils.DAZARALOR_MAP_ID = 1165
-- Nazmir
LocalMapUtils.THE_UNDERROT_MAP_ID = 1041
-- Tiragarde Sound
LocalMapUtils.BORALUS_MAP_ID = 1161
-- Azeroth
LocalMapUtils.NAZJATAR_MAP_ID = 1355

----- Legion -----

-- Broken Isles
LocalMapUtils.AZSUNA_MAP_ID = 630
LocalMapUtils.STORMHEIM_MAP_ID = 634
LocalMapUtils.VALSHARAH_MAP_ID = 641
LocalMapUtils.BROKEN_SHORE_MAP_ID = 646
LocalMapUtils.HIGHMOUNTAIN_MAP_ID = 650
LocalMapUtils.SURAMAR_MAP_ID = 680
LocalMapUtils.EYE_OF_AZSHARA_MAP_ID = 790
-- Argus
LocalMapUtils.KROKUUN_MAP_ID = 830
LocalMapUtils.EREDATH_MAP_ID = 882
LocalMapUtils.ANTORAN_WASTES_MAP_ID = 885
-- High Mountain
LocalMapUtils.TRUESHOT_LODGE_MAP_ID = 739

-- Note: Maps like Mardum, etc. are NOT zones (mapType: 3).

----- Warlords of Draenor -----

LocalMapUtils.FROSTFIRE_RIDGE_MAP_ID = 525
LocalMapUtils.TANAAN_JUNGLE_MAP_ID = 534
LocalMapUtils.TALADOR_MAP_ID = 535
LocalMapUtils.SHADOWMOON_VALLEY_MAP_ID = 539
LocalMapUtils.SPIRES_OF_ARAK_MAP_ID = 542
LocalMapUtils.GORGROND_MAP_ID = 543
LocalMapUtils.NAGRAND_MAP_ID = 550
LocalMapUtils.ASHRAN_MAP_ID = 588

--> TODO - Add more zones.

----- Wrapper ------------------------------------------------------------------

 local mapInfoCache = {}  --> { [uiMapID] = mapInfo, ...}

-- Return the map information for given map.
---@param uiMapID number
---@return UiMapDetails mapInfo
--
function LocalMapUtils:GetMapInfo(uiMapID)
    if not mapInfoCache[uiMapID] then
        mapInfoCache[uiMapID] = C_Map.GetMapInfo(uiMapID)
    end
    return mapInfoCache[uiMapID]
end

-- Get the map information for each child zone of given map.
---@param mapID number
---@param mapType number|Enum.UIMapType|nil
---@param allDescendants boolean|nil
---@return UiMapDetails[] mapChildrenInfos
--
function LocalMapUtils:GetMapChildrenInfo(mapID, mapType, allDescendants)
	return C_Map.GetMapChildrenInfo(mapID, mapType, allDescendants)
end

-- Return map information for any child map at given position on the map.
-- Note: The argument `ignoreZoneMapPositionData` is optional.
---@param uiMapID number
---@param x number
---@param y number
---@param ignoreZoneMapPositionData boolean|nil
---@return UiMapDetails mapInfo
-- 
function LocalMapUtils:GetMapInfoAtPosition(uiMapID, x, y, ignoreZoneMapPositionData)
    return C_Map.GetMapInfoAtPosition(uiMapID, x, y, ignoreZoneMapPositionData)
end

-- Returns the current uiMapID of the player's current location.
---@return number uiMapID
--
function LocalMapUtils:GetBestMapForPlayer()
    return C_Map.GetBestMapForUnit("player")   -- or C_Map.GetFallbackWorldMapID()
end

-- Returns the player's current map position.
---@return Vector2DMixin|nil playerMapPosition
--
function LocalMapUtils:GetPlayerPosition()
    -- Note: "Only works for the player and party members."
    return C_Map.GetPlayerMapPosition(self:GetBestMapForPlayer(), "player")
end

----- Convenience -----

-- Check whether the given map is a continent.
---@param uiMapID number
---@return boolean isContinent
-- 
function LocalMapUtils:IsMapTypeContinent(uiMapID)
    local mapInfo = self:GetMapInfo(uiMapID)
    return mapInfo.mapType == Enum.UIMapType.Continent
end

----- User Waypoints -----------------------------------------------------------

-- Set a user waypoint on given map at given position.
---@param uiMapID number
---@param posX number
---@param posY number
---@param setActive boolean|nil  Defaults to `nil`.
---@param chatNotifyOnError boolean|nil  Defaults to `nil`.
---@return UiMapPoint|nil mapPoint
--
function LocalMapUtils:SetUserWaypointXY(uiMapID, posX, posY, setActive, chatNotifyOnError)
    if C_Map.CanSetUserWaypointOnMap(uiMapID) then
        local uiMapPoint = UiMapPoint.CreateFromCoordinates(uiMapID, posX, posY)
        C_Map.SetUserWaypoint(uiMapPoint)
        local shouldSuperTrack = setActive and setActive or not C_SuperTrack.IsSuperTrackingUserWaypoint()
		C_SuperTrack.SetSuperTrackedUserWaypoint(shouldSuperTrack)
		if shouldSuperTrack then
			PlaySound(SOUNDKIT.UI_MAP_WAYPOINT_SUPER_TRACK_ON)
		else
			PlaySound(SOUNDKIT.UI_MAP_WAYPOINT_SUPER_TRACK_OFF)
        end
        return uiMapPoint
    else
        -- Inform user
        UIErrorsFrame:AddMessage(MAP_PIN_INVALID_MAP, RED_FONT_COLOR:GetRGBA())
        if chatNotifyOnError then
            print(RED_FONT_COLOR:WrapTextInColorCode(MAP_PIN_INVALID_MAP))
        end
    end
end

-- Get the UiMapPoint of a previously set user waypoint.
---@return UiMapPoint|nil mapPoint
-- 
function LocalMapUtils:GetUserWaypoint()
    if not C_Map.HasUserWaypoint() then return end

    return C_Map.GetUserWaypoint()
end

-- Remove a previously set user waypoint.
function LocalMapUtils:ClearUserWaypoint()
    if not C_Map.HasUserWaypoint() then return end

    C_Map.ClearUserWaypoint()
    C_SuperTrack.SetSuperTrackedUserWaypoint(false)
    PlaySound(SOUNDKIT.UI_MAP_WAYPOINT_REMOVE)
end

--[[--> TODO -----

local hyperlink = C_Map.GetUserWaypointHyperlink()
local uiMapPoint = C_Map.GetUserWaypointFromHyperlink(hyperlink)
local mapPosition = C_Map.GetUserWaypointPositionForMap(uiMapID)

UiMapPoint.CreateFromVector2D(mapID, position, z)

WorldMapFrame:TriggerEvent("SetAreaLabel", MAP_AREA_LABEL_TYPE.POI, self.name, self.description);
WorldMapFrame:TriggerEvent("ClearAreaLabel", MAP_AREA_LABEL_TYPE.POI);

-- Returns a map area/subzone name.  
---@param areaID number
---@return string areaName
-- [Documentation](https://wowpedia.fandom.com/wiki/API_C_Map.GetAreaInfo),
-- [AreaTable.db2](https://wow.tools/dbc/?dbc=areatable)
--
function LocalMapUtils:GetAreaInfo(areaID)
	return C_Map.GetAreaInfo(areaID)
end

-- Returns a table with POI IDs currently active on the world map.
---@param mapID number
---@return number[] areaPoiIDs
-- REF.: <FrameXML/Blizzard_SharedMapDataProviders/AreaPOIDataProvider.lua>
-- REF.: <FrameXML/Blizzard_SharedMapDataProviders/SharedMapPoiTemplates.lua>
-- REF.: <FrameXML/Blizzard_APIDocumentationGenerated/AreaPoiInfoDocumentation.lua>
-- REF.: <FrameXML/TableUtil.lua>
--
function LocalMapUtils:GetAreaPOIForMap(mapID)
	local areaPOIs = GetAreaPOIsForPlayerByMapIDCached(mapID);
	areaPOIs = TableIsEmpty(areaPOIs) and C_AreaPoiInfo.GetAreaPOIForMap(mapID) or areaPOIs;
	return areaPOIs;
end

-- Main POI retrieval function; Gets all POIs of given map info.
---@param mapInfo table|UiMapDetails
---@param includeAreaName boolean|nil
---@return AreaPOIInfo[]|nil activeAreaPOIs
---@class AreaPOIInfo
--
function LocalMapUtils:GetAreaPOIForMapInfo(mapInfo, includeAreaName)
	local areaPOIs = self:GetAreaPOIForMap(mapInfo.mapID);
	if (areaPOIs and #areaPOIs > 0) then
		local activeAreaPOIs = {};
		for i, areaPoiID in ipairs(areaPOIs) do
			local poiInfo = C_AreaPoiInfo.GetAreaPOIInfo(mapInfo.mapID, areaPoiID);
			if not poiInfo then
				ClearCachedAreaPOIsForPlayer();
				break;
			end
            tinsert(activeAreaPOIs, poiInfo);
		end
		return activeAreaPOIs;
	end
end

]]