--------------------------------------------------------------------------------
--[[ handynotes.lua - A collection of utilities for HandyNotes plugins. ]]--
--
-- by erglo <erglo.coder+WAU@gmail.com>
--
-- Copyright (C) 2023-2024  Erwin D. Glockner (aka erglo)
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
-- REF.: <https://github.com/Nevcairiel/HandyNotes>
-- REF.: <https://github.com/Nevcairiel/HandyNotes/blob/master/HandyNotes.lua>
-- REF.: <https://www.townlong-yak.com/framexml/live/Blizzard_APIDocumentationGenerated/MapDocumentation.lua>
-- REF.: <https://www.townlong-yak.com/framexml/live/Blizzard_SharedMapDataProviders/WaypointLocationDataProvider.lua>
--
-- (see also the function comments section for more)
-- 
-- Requirements:
-- =============
-- This utilities need "HandyNotes" to be installed.
-- 
-- Download at <https://www.wowace.com/projects/handynotes> or
-- <https://www.curseforge.com/wow/addons/handynotes>.
-- 
--------------------------------------------------------------------------------

local _, ns = ...

local utils = ns.utils or {}
ns.utils = utils

local LocalHandyNotesUtils = {}
utils.handynotes = LocalHandyNotesUtils

LocalHandyNotesUtils.HandyNotes = _G["HandyNotes"]

if not LocalHandyNotesUtils.HandyNotes then
    error("Embedded library/addon required: HandyNotes", 0)
end

local C_Map = C_Map
local C_SuperTrack = C_SuperTrack

----- Wrapper ------------------------------------------------------------------

-- Get the HandyNotes coordinates from given x/y position numbers.
---@param x number
---@param y number
---@return number coord
-- 
function LocalHandyNotesUtils:GetCoordFromXY(x, y)
    return self.HandyNotes:getCoord(x, y)
end

-- Get the x/y position from given HandyNotes coordinates number.
---@param coord number
---@return number posX
---@return number posY
--
function LocalHandyNotesUtils:GetXYFromCoord(coord)
    return self.HandyNotes:getXY(coord)
end

----- Player position coords -----

-- Get the uiMapID and the HandyNotes coordinates from the player's current position.
---@return number|nil mapID
---@return number|nil coord
-- 
function LocalHandyNotesUtils:GetPlayerMapCoord()
    local mapID = C_Map.GetBestMapForUnit("player")
    local playerPosition = C_Map.GetPlayerMapPosition(mapID, "player")
    if playerPosition then
        return mapID, self:GetCoordFromXY(playerPosition:GetXY())
    end
end

----- Waypoints -----

-- Set a user waypoint on given map at given HandyNotes coordinates. The optional "chatNotifyOnError" informs the user
-- additionally in chat that given map doesn't support waypoints (on screen by default).
---@param mapID number
---@param coord number
---@param chatNotifyOnError boolean|nil
---@return boolean success
--
-- REF.: [Blizzard_APIDocumentationGenerated/MapDocumentation.lua](https://www.townlong-yak.com/framexml/live/Blizzard_APIDocumentationGenerated/MapDocumentation.lua)<br>
-- REF.: [Blizzard_SharedMapDataProviders/WaypointLocationDataProvider.lua](https://www.townlong-yak.com/framexml/live/Blizzard_SharedMapDataProviders/WaypointLocationDataProvider.lua)<br>
-- REF.: [ObjectAPI/UiMapPoint.lua](https://www.townlong-yak.com/framexml/live/ObjectAPI/UiMapPoint.lua)
-- 
function LocalHandyNotesUtils:SetMapCoordUserWaypoint(mapID, coord, chatNotifyOnError)
    if C_Map.CanSetUserWaypointOnMap(mapID) then
        local posX, posY = self:GetXYFromCoord(coord)
        local uiMapPoint = UiMapPoint.CreateFromCoordinates(mapID, posX, posY)
        C_Map.SetUserWaypoint(uiMapPoint)
        C_SuperTrack.SetSuperTrackedUserWaypoint(true)  --> set waypoint as active
        return true
    else
        UIErrorsFrame:AddMessage(MAP_PIN_INVALID_MAP, RED_FONT_COLOR:GetRGBA())
        if chatNotifyOnError then
            print(RED_FONT_COLOR:WrapTextInColorCode(MAP_PIN_INVALID_MAP))
        end
        return false
    end
end

-- Get the uiMapID and the HandyNotes coordinates from a user waypoint.
---@return number|nil mapID
---@return number|nil coord
-- 
function LocalHandyNotesUtils:GetUserWaypointMapCoord()
    if not C_Map.HasUserWaypoint() then return end

    local uiMapPoint = C_Map.GetUserWaypoint()
    if not TableIsEmpty(uiMapPoint) then
        local posX, posY = uiMapPoint.position.x, uiMapPoint.position.y
        return uiMapPoint.uiMapID, self:GetCoordFromXY(posX, posY)
    end
end

-- Remove a previously set user waypoint.
function LocalHandyNotesUtils:ClearUserWaypoint()
    C_Map.ClearUserWaypoint()
end
