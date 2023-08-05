---
--- @file
--- Bootstrap for Blizzard API functions.
---
--- We are going to bootstrap all Blizzard functions we are gonna need and use them
--- in our addon via this api. This way we can quickly fix our addon, if Blizzard
--- changes any game api.
---

local NAME, this = ...

local API = {}

---
--- GameTooltip object.
---
--- @link https://wowpedia.fandom.com/wiki/Widget_API#GameTooltip
--- @link https://wowpedia.fandom.com/wiki/UIOBJECT_GameTooltip
---
API.GameTooltip = GameTooltip

---
--- UIParent object.
---
--- @link https://wowpedia.fandom.com/wiki/API_Region_SetParent
---
API.UIParent = UIParent

---
--- UiMapPoint object.
---
--- @link https://wowpedia.fandom.com/wiki/UiMapPoint
--- @link https://www.townlong-yak.com/framexml/live/ObjectAPI/UiMapPoint.lua
---
API.UiMapPoint = UiMapPoint

---
--- Frame WorldMapFrame is used for work with world map.
---
--- @link https://wowpedia.fandom.com/wiki/Widget_API#Frame
---
API.WorldMapFrame = WorldMapFrame

---
--- This mixin provides worldmap with data, we supply our pins (paths and pois) to map via this.
---
--- @link https://www.townlong-yak.com/framexml/ptr/Blizzard_MapCanvas/MapCanvas_DataProviderBase.lua
---
API.MapCanvasDataProviderMixin = MapCanvasDataProviderMixin

---
--- This mixin handles displaying and styling for pins (paths and pois).
---
--- @link https://www.townlong-yak.com/framexml/ptr/Blizzard_MapCanvas/MapCanvas_DataProviderBase.lua
---
API.MapCanvasPinMixin = MapCanvasPinMixin

---
--- Blizzard settings.
---
--- @link https://github.com/Gethe/wow-ui-source/blob/live/Interface/SharedXML/Settings/Blizzard_Settings.lua
---
API.Settings = Settings

---
--- Constant with translated string for 'close' text from game client.
---
API.closeLabel = CLOSE

---
--- Gets game build version for caching purposes.
---
--- @link https://wowpedia.fandom.com/wiki/API_GetBuildInfo
---
--- @return number
---   Game build number (ie 40132).
---
function API:getVersion()
  local _, version = GetBuildInfo()

  return tonumber(version)
end

---
--- Gets distance from the left side of the screen to the center of a region.
---
--- @link https://wowpedia.fandom.com/wiki/API_Region_GetCenter
---
--- @return number
---   Distance between the region's center and the left edge of the screen.
---
function API:getUIParentCenter()
  return self.UIParent:GetCenter()
end

---
--- Loads icon from game files.
---
--- Good way to search for graphics is using WoW.tools or TextureAtlasViewer addon.
---
--- @link https://wowpedia.fandom.com/wiki/API_C_Texture.GetAtlasInfo
--- @link https://wow.tools/
--- @link https://www.curseforge.com/wow/addons/textureatlasviewer
---
--- @param data
---   Name of icon we want to load.
---
--- @return table
---   Returns AtlasInfo object.
---
function API:GetAtlasInfo(data)
  local name = data

  -- Fallback if we don't have any icon specified.
  if (data == nil) then
    name = 'CGuy_AOIFollowsCamera'
  end

  local graphics = C_Texture.GetAtlasInfo(name)
  local icon = {
    icon = graphics.file,
    tCoordLeft = graphics.leftTexCoord,
    tCoordRight = graphics.rightTexCoord,
    tCoordTop = graphics.topTexCoord,
    tCoordBottom = graphics.bottomTexCoord,
  }

  return icon
end

---
--- Copies (or mixes in) children from one or more tables into another.
---
--- @link https://wowpedia.fandom.com/wiki/API_CreateFromMixins
---
--- @param mixin
---   One or more pattern tables that are copied from or table that children are pasted into.
---
--- @return table
---   The table that children were pasted into.
---
function API:createFromMixins(mixin)
  return CreateFromMixins(mixin)
end

---
--- Gets map name from uiMapID.
---
--- @link https://wowpedia.fandom.com/wiki/API_C_Map.GetMapInfo
--- @link https://wowpedia.fandom.com/wiki/API_C_Map.GetMapGroupID
--- @link https://wowpedia.fandom.com/wiki/API_C_Map.GetMapGroupMembersInfo
---
--- @param id
---   Map id (uiMapID).
---
--- @return string
---   Map name.
---
function API:getMapName(id)
  local groupId = C_Map.GetMapGroupID(id)

  -- Map is part of dungeon / raid. Loop all sub-zones from group and return name of ours.
  if (groupId) then
    for _, data in pairs(C_Map.GetMapGroupMembersInfo(groupId)) do
      if (data['mapID'] == id) then
        return data['name']
      end
    end
  end

  return C_Map.GetMapInfo(id).name
end

---
--- If map is open, we change it to another one (usable for portals to another map, ie. dungeons or raids).
---
--- @link https://wowpedia.fandom.com/wiki/UiMapID
---
--- @param id
---   Map id (uiMapID).
---
function API:changeMap(id)
  if self.WorldMapFrame:IsShown() then
    self.WorldMapFrame:SetMapID(id)
  end
end

---
--- Checks, whether player can set waypoint on map.
---
--- @link https://wowpedia.fandom.com/wiki/API_C_Map.CanSetUserWaypointOnMap
---
--- @param uiMapId
---   Map ID, where we want to add point.
---
--- @return boolean
---   True, if player can set waypoint on given map, false otherwise.
---
function API:canSetUserWaypointOnMap(uiMapId)
  return C_Map.CanSetUserWaypointOnMap(uiMapId)
end

---
--- Adds user waypoint to map.
---
--- @link https://wowpedia.fandom.com/wiki/API_C_Map.SetUserWaypoint
---
--- @param position
---   Map vector (uiMapId, x and y), where we want to place waypoint.
---
function API:setUserWaypoint(position)
  C_Map.SetUserWaypoint(position)
end

---
--- Sets user waypoint to be tracked.
---
--- @link https://wowpedia.fandom.com/wiki/API_C_SuperTrack.SetSuperTrackedUserWaypoint
---
function API:setSuperTrackedUserWaypoint()
  C_SuperTrack.SetSuperTrackedUserWaypoint(true)
end

---
--- Checks, whether shift button on keyboard is pushed.
---
--- @link https://wowpedia.fandom.com/wiki/API_IsModifierKeyDown
---
--- @return boolean
---   True, if shift is down, else otherwise.
---
function API:IsShiftKeyDown()
  return IsShiftKeyDown()
end

---
--- Checks, whether alt button on keyboard is pushed.
---
--- @link https://wowpedia.fandom.com/wiki/API_IsModifierKeyDown
---
--- @return boolean
---   True, if alt is down, else otherwise.
---
function API:IsAltKeyDown()
  return IsAltKeyDown()
end

---
--- Get the name of the faction (Horde/Alliance) a unit belongs to.
---
--- @link https://wowpedia.fandom.com/wiki/API_UnitFactionGroup
---
--- @return string
---   Unit's faction name in English, i.e. "Alliance", "Horde", "Neutral" or nil.
---
function API:unitFactionGroup()
  return UnitFactionGroup('player')
end

---
--- Creates frame for contextual menu.
---
--- @link https://wowpedia.fandom.com/wiki/API_CreateFrame
--- @link https://wowpedia.fandom.com/wiki/UI_Object_UIDropDownMenu
---
--- @return table
---   Frame with menu display mode.
---
function API:prepareMenu()
  local menu = CreateFrame('Frame', NAME .. 'ContextualMenu')
  menu.displayMode = 'MENU'

  return menu
end

---
--- Prepares button object that will be filled with text and logic.
---
--- @link https://wowpedia.fandom.com/wiki/API_UIDropDownMenu_CreateInfo
---
--- @return table
---   Empty table, that we need to fill with values.
---
function API:menuButtonPrepare()
  return UIDropDownMenu_CreateInfo()
end

---
--- Adds blank line 'button' to contextual menu.
---
--- @link https://wowpedia.fandom.com/wiki/API_UIDropDownMenu_AddButton
---
function API:menuAddSpacer()
  UIDropDownMenu_AddSpace()
end

---
--- Adds button to menu. Used in initialization function.
---
--- @link https://wowpedia.fandom.com/wiki/API_UIDropDownMenu_AddButton
---
--- @param button
---   Table containing button data (like text, functions etc.).
---
function API:menuAddButton(button)
  -- No button in contextual menu is checkbox.
  button.notCheckable = 1

  -- Add button.
  UIDropDownMenu_AddButton(button)
end

---
--- Closes contextual menu.
---
--- @link https://wowpedia.fandom.com/wiki/Using_UIDropDownMenu
---
function API:closeMenu()
  CloseDropDownMenus()
end

---
--- Opens contextual menu.
---
--- @link https://wowpedia.fandom.com/wiki/API_ToggleDropDownMenu
---
--- @param name
---   Menu name to be opened.
--- @param anchor
---   Name of anchor, we are closing (eg. addon name).
---
function API:openMenu(name, anchor)
  ToggleDropDownMenu(1, nil, name, anchor, 0, 0)
end

this.API = API
