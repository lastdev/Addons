---
--- @file
--- Bootstrap for Blizzard API functions.
---
--- We are going to bootstrap all Blizzard functions we are gonna need and use them
--- in our addon via this api. This way we can quickly fix our addon, if Blizzard
--- changes any game api.
---

local _, this = ...
local Icon = this.Icon
local t = this.t

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
--- Constant with number of bag slots.
---
--- @link https://wowpedia.fandom.com/wiki/BagID
--- @link https://www.townlong-yak.com/framexml/9.1.0/Constants.lua#212
---
API.BagSlots = NUM_BAG_SLOTS

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
--- Gets name of a quest.
---
--- @link https://wowpedia.fandom.com/wiki/API_C_QuestLog.GetTitleForQuestID
---
--- @param id
---   Quest ID.
---
--- @return ?string
---   Name of the quest or nil.
---
function API:getTitleForQuestID(id)
  return C_QuestLog.GetTitleForQuestID(id)
end

---
--- Gets link (formatted name) for achievement.
---
--- @link https://wowpedia.fandom.com/wiki/API_GetAchievementLink
---
--- @param id
---   Achievement ID.
---
--- @return string
---   Formatted achievement link.
---
function API:getAchievementLink(id)
  return GetAchievementLink(id)
end

---
--- Gets name for criteria and count of completed / required points.
---
--- @link https://wowpedia.fandom.com/wiki/API_GetAchievementCriteriaInfo
---
--- @param id
---   Achievement ID.
---
--- @return string
---   Name of the criteria.
--- @return number
---   Number of completed points.
--- @return number
---   Number of required points.
---
function API:getAchievementCriteriaCount(id)
  local name, _, _, count, required = GetAchievementCriteriaInfo(id, 1)

  return name, count, required
end

---
--- Gets name of a spell.
---
--- @link https://wowpedia.fandom.com/wiki/API_GetSpellInfo
---
--- @param id
---   Spell ID.
---
--- @return string
---   Name of the spell.
---
function API:getSpellName(id)
 local name = GetSpellInfo(id)

  return name
end

---
--- Gets name of an item.
---
--- @link https://wowpedia.fandom.com/wiki/API_C_Item.GetItemName
---
--- @param id
---   Item ID.
---
--- @return ?string
---   Name of the item or nil.
---
function API:getItemName(id)
  return C_Item.GetItemNameByID(id)
end

---
--- Gets name of an NPC (Vendor, rare, etc.).
---
--- @link https://wowpedia.fandom.com/wiki/GUID
--- @link https://wowpedia.fandom.com/wiki/API_UIObject_GetName
--- @link https://wowpedia.fandom.com/wiki/API_GameTooltip_SetHyperlink
---
--- @param id
---   Item ID.
---
--- @return ?string
---   Name of the NPC or nil.
---
function API:getNpcName(id)
  local frame = CreateFrame('GameTooltip', 'unit:Creature-0-0-0-0-' .. id, nil, 'GameTooltipTemplate')
  frame:SetOwner(WorldFrame, 'ANCHOR_NONE');
  frame:SetHyperlink('unit:Creature-0-0-0-0-' .. id)

  local frameName = frame:GetName() .. 'TextLeft1'
  local name = _G[frameName]:GetText()

  if (name == nil) then
    return t['fetching_data']
  end

  return name
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
  local name = Icon.list[data]

  -- Fallback if we don't have any icon specified.
  if (data == nil) then
    name = Icon.list['default']
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
--- Check, whether quest is completed or not.
---
--- @link https://wowpedia.fandom.com/wiki/API_C_QuestLog.IsQuestFlaggedCompleted
---
--- @param id
---   Quest ID.
---
--- @return boolean
---   True if it was completed, false if not or id is wrong.
---
function API:isQuestFlaggedCompleted(id)
  if not id then
    return false
  end

  return C_QuestLog.IsQuestFlaggedCompleted(id)
end

---
--- Check, whether quest is active or not.
---
--- @link https://wowpedia.fandom.com/wiki/API_C_QuestLog.IsOnQuest
---
--- @param id
---   Quest ID.
---
--- @return boolean
---   True if it is active, false otherwise.
---
function API:isOnQuest(id)
  if not id then
    return false
  end

  return C_QuestLog.IsOnQuest(id)
end

---
--- Checks, whether achievement is valid or not.
---
--- @link https://wowpedia.fandom.com/wiki/API_C_AchievementInfo.IsValidAchievement
---
--- @param id
---   Achievement ID.
---
--- @return boolean
---   True, if achievement is valid, false otherwise.
---
function API:achievementInfoIsValidAchievement(id)
  return C_AchievementInfo.IsValidAchievement(id)
end

---
--- Gets achievement info.
---
--- @link https://wowpedia.fandom.com/wiki/API_GetAchievementInfo
---
--- @param achievementId
---   Achievement ID.
---
--- @return number
---   Achievement ID.
--- @return string
---   The Name of the Achievement.
--- @return number
---   Points awarded for completing this achievement.
--- @return boolean
---   Returns true/false depending if you've completed this achievement on any character.
--- @return ?number
---   Month this was completed. Returns nil if Completed is false.
--- @return ?number
---   Day this was completed. Returns nil if Completed is false.
--- @return ?number
---   Year this was completed. Returns nil if Completed is false. Returns number of years since 2000.
--- @return string
---   The Description of the Achievement.
--- @return number
---   A bitfield that indicates achievement properties.
--- @return number
---   The fileID of the icon used for this achievement.
--- @return string
---   Text describing the reward you get for completing this achievement.
--- @return boolean
---   Returns true/false depending if this is a guild achievement.
--- @return boolean
---   Returns true/false depending if you've completed this achievement on this character.
---
function API:getAchievementInfo(achievementId)
  local id, name, points, completed, month, day, year, description, flags, icon, rewardText, isGuild, wasEarnedByMe = GetAchievementInfo(achievementId)

  return id, name, points, completed, month, day, year, description, flags, icon, rewardText, isGuild, wasEarnedByMe
end

---
--- Checks, whether achievement criteria is completed.
---
--- @link https://wowpedia.fandom.com/wiki/API_GetAchievementCriteriaInfo
---
--- @param id
---   Achievement ID.
---
--- @param criteriaId
---   Achievement criteria ID.
---
--- @return string
---   The name of the criteria.
--- @return number
---   Criteria type; specifies the meaning of the assetID.
--- @return boolean
---   True if you've completed this criteria; false otherwise.
---
function API:getAchievementCriteriaInfoByID(id, criteriaId)
  local name, type, completed = GetAchievementCriteriaInfoByID(id, criteriaId)

  return name, type, completed
end

---
--- Checks, whether achievement has all count type criteria is completed.
---
--- @link https://wowpedia.fandom.com/wiki/API_GetAchievementCriteriaInfo
---
--- @param id
---   Achievement ID.
---
--- @return string
---   The name of the criteria.
--- @return number
---   Criteria type; specifies the meaning of the assetID.
--- @return boolean
---   True if you've completed this criteria; false otherwise.
--- @return number
---   Quantity requirement imposed by some criteriaType.
--- @return number
---   The required quantity for the criteria. Used mostly in achievements with progress bars. Usually 0.
---
function API:getAchievementCriteriaInfo(id)
  local name, type, completed, quantity, reqQuantity = GetAchievementCriteriaInfo(id, 1)

  return name, type, completed, quantity, reqQuantity
end

---
--- Gets info about mount by his ID.
---
--- @link https://wowpedia.fandom.com/wiki/API_C_MountJournal.GetMountInfoByID
---
--- @param id
---   Mount ID of the mount.
---
--- @return string
---   The name of the mount.
--- @return string
---   Icon texture used by the mount.
--- @return boolean
---   Indicates if the player has learned the mount.
---
function API:mountJournalGetMountInfo(id)
  local name, _, icon, _, _, _, _, _, _, _, collected = C_MountJournal.GetMountInfoByID(id)

  return name, icon, collected
end

---
--- Gets name and link (formatted name) for item.
---
--- @link https://wowpedia.fandom.com/wiki/API_GetItemInfo
---
--- @param id
---   Item ID.
---
--- @return string
---   The localized name of the item.
--- @return string
---   The localized link of the item.
--- @return string
---   The localized type name of the item: Armor, Weapon, Quest, etc.
--- @return string
---   The localized sub-type name of the item: Bows, Guns, Staves, etc.
--- @return string
---   The texture for the item icon.
---
function API:getItemInfo(id)
  local name, link, _, _, _, type, subtype, _, _, icon = GetItemInfo(id)

  return name, link, type, subtype, icon
end

---
--- Checks, whether toy is collected or not.
---
--- @link https://wowpedia.fandom.com/wiki/API_PlayerHasToy
---
--- @param id
---   Item ID, that toy is learned from.
---
--- @return boolean
---   True, if toy collected, false otherwise.
---
function API:playerHasToy(id)
  return PlayerHasToy(id)
end

---
--- Gets information about number of collected pets of given id.
---
--- @link https://wowpedia.fandom.com/wiki/API_C_PetJournal.GetNumCollectedInfo
---
--- @param id
---   Species ID of the pet.
---
--- @return number
---   Number of battle pets of the queried species the player has collected.
--- @return number
---   Maximum number of battle pets of the queried species the player may collect.
---
function API:petJournalGetNumCollectedInfo(id)
  local collected, max = C_PetJournal.GetNumCollectedInfo(id)

  return collected, max
end

---
--- Gets appearance and source ids for item, we are checking.
---
--- @link https://wowpedia.fandom.com/wiki/API_C_TransmogCollection.GetItemInfo
--- @link https://wowpedia.fandom.com/wiki/AppearanceID
---
--- @param id
---   Item ID, we are checking.
---
--- @return number
---   Appearance ID of item (items can have same source, but different appearance).
--- @return number
---   Source ID of transmog.
---
function API:getTransmogInfo(id)
  local appearanceId, sourceId = C_TransmogCollection.GetItemInfo(id)

  return appearanceId, sourceId
end

---
--- Checks, whether item transmog is already collected or not.
---
--- @link https://wowpedia.fandom.com/wiki/API_C_TransmogCollection.PlayerHasTransmog
---
--- @param id
---   Item ID of an item we are checking.
---
--- @return boolean
---   True, if transmog is already collected, false otherwise.
---
function API:playerHasTransmog(id)
  return C_TransmogCollection.PlayerHasTransmog(id)
end

---
--- Checks, whether item transmog modified appearance is already collected or not.
---
--- @link https://wowpedia.fandom.com/wiki/API_C_TransmogCollection.PlayerHasTransmogItemModifiedAppearance
---
--- @param sourceId
---   Source ID of an item we are checking.
---
--- @return boolean
---   True, if transmog is already collected, false otherwise.
---
function API:playerHasTransmogAppearance(sourceId)
  return C_TransmogCollection.PlayerHasTransmogItemModifiedAppearance(sourceId)
end

---
--- Gets table of sources data for given appearance (you can have same appearance from different source).
---
--- @link https://wowpedia.fandom.com/wiki/API_C_TransmogCollection.GetAppearanceSources
---
--- @param appearanceId
---   Appearance ID of an item we are checking.
---
--- @return table
---   Table of sources for given appearanceId.
---
function API:getAppearanceSources(appearanceId)
  return C_TransmogCollection.GetAppearanceSources(appearanceId)
end

---
--- Checks, whether character can collect transmog or not (ie, mage can't collect plate).
---
--- @link https://wowpedia.fandom.com/wiki/API_C_TransmogCollection.PlayerCanCollectSource
--- @link https://www.townlong-yak.com/framexml/live/CollectionsUtil.lua
---
--- @param id
---   Item ID of an item we are checking.
---
--- @return boolean
---   True, if character can collect, false otherwise.
---
function API:playerCanCollectSource(id)
  local _, sourceId = self:getTransmogInfo(id)

  local hasItemData, canCollect = CollectionWardrobeUtil.PlayerCanCollectSource(sourceId)

  if (hasItemData == true and canCollect == true) then
    return true
  end

  return false
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
--- @deprecated in 0.11.0 and scheduled for removal in 0.13.0
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
--- Returns information about the specified faction or faction header in the player's reputation pane.
---
--- @link https://wowpedia.fandom.com/wiki/API_GetFactionInfo
--- @link https://wowpedia.fandom.com/wiki/StandingId
---
--- @param factionId
---   Id of a faction we want to get info from.
---
--- @return string
---   Name of the faction.
--- @return number
---   StandingId representing the current standing (eg. 4 for Neutral, 5 for Friendly).
---
function API:getFactionInfoByID(factionId)
 local name, _, standingId = GetFactionInfoByID(factionId)

  return name, standingId
end

---
--- Currently only usable to get string for faction standing.
---
--- @link https://wowpedia.fandom.com/wiki/API_GetText
---
--- @param standingId
---   Faction standing ID to get name from.
---
--- @return string
---   Localized string with faction standing label.
---
function API:getText(standingId)
  return GetText('FACTION_STANDING_LABEL' .. standingId)
end

---
--- Returns the total number of slots in the bag specified by the index.
---
--- @link https://wowpedia.fandom.com/wiki/API_GetContainerNumSlots
--- @link https://wowpedia.fandom.com/wiki/BagID
---
--- @param bagId
---   ID of a container (bag), we want to get number of slots in (0 = backpack, 1 - 4 bags).
---
--- @return number
---   The number of slots in the specified bag, or 0 if there is no bag in the given slot.
---
function API:getContainerNumSlots(bagId)
  return GetContainerNumSlots(bagId)
end

---
--- Returns the item id of the item in a particular container slot.
---
--- @link https://wowpedia.fandom.com/wiki/API_GetContainerItemID
--- @link https://wowpedia.fandom.com/wiki/BagID
---
--- @param bagId
---   Index of the bag to query.
--- @param slot
---   Index of the slot within the bag to query; ascending from 1.
---
--- @return number
---   Item ID of the item held in the container slot, nil if there is no item in the container slot.
---
function API:getContainerItemID(bagId, slot)
  return GetContainerItemID(bagId, slot)
end

---
--- Returns indexes for player professions.
---
--- @link https://wowpedia.fandom.com/wiki/API_GetProfessions
---
--- @return number
---   Index of first profession.
--- @return number
---   Index of second profession.
--- @return number
---   Index of archaeology profession.
--- @return number
---   Index of fishing profession.
--- @return number
---   Index of cooking profession.
---
function API:getProfessions()
  local prof1, prof2, archaeology, fishing, cooking = GetProfessions()

  return prof1, prof2, archaeology, fishing, cooking
end

---
--- Returns details about given profession index.
---
--- @link https://wowpedia.fandom.com/wiki/API_GetProfessionInfo
---
--- @param index
---   Index of the profession.
---
--- @return string
---   Profession name.
--- @return string
---   Profession icon.
--- @return number
---   Profession level.
---
function API:getProfessionInfo(index)
  local name, icon, skillLevel = GetProfessionInfo(index)

  return name, icon, skillLevel
end

---
--- Returns details about given currency ID.
---
--- @link https://wowpedia.fandom.com/wiki/API_C_CurrencyInfo.GetCurrencyInfo
---
--- @param currencyId
---   ID of a currency.
---
--- @return table
---   Currency name and icon.
---
function API:getCurrecyInfo(currencyId)
  local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(currencyId)

  local currency = {
    name = currencyInfo.name,
    icon = currencyInfo.iconFileID,
  }

  return currency
end

this.API = API
