---
--- @file
--- Data structure and logic for points on map.
---

local _, this = ...

local API = this.API
local Cache = this.Cache
local HandyNotes = this.HandyNotes
local Currency = this.Currency
local Item = this.Item
local Achievement = this.Achievement
local Mount = this.Mount
local Pet = this.Pet
local Quest = this.Quest
local Toy = this.Toy
local Transmog = this.Transmog
local Loot = this.Loot
local Requirements = this.Requirements
local Text = this.Text
local t = this.t

local Point = {}

---
--- Checks, whether point has completed all rewards (toy, achievement, pet, transmog).
---
--- @param data
---   Map data for our point.
---
--- @return boolean
---   True, if all rewards are acquired.
---
function Point:isCompleted(data)
  -- Check, if associated quest is completed.
  if (Quest:isCompleted(data.questId) == true) then
    return true
  end

  -- If point doesn't have anything (items or achievements), consider it completed.
  if (data.loot == nil) then
    return true
  end

  -- Check, if all every piece of loot is completed.
  return Loot:isCompleted(data.loot)
end

---
--- Prepares name (header) for tooltip
---
--- @param data
---   Map data for our point.
---
--- @return ?string
---   Returns name of point or nil.
---
function Point:prepareName(data)
  local name = data.name
  -- If there is no name, try to load name from game.

  -- Try to load NPC name.
  if name == nil and data.npcId ~= nil then
    name = Cache:get(data.npcId, 'npcName')
    if (name == nil) then
      name = API:getNpcName(data.npcId)
      Cache:set(data.npcId, name, 'npcName')
    end
  end

  if name ~= nil then
    -- Colorize name.
    name = Text:color(name, 'white')
  end

  -- Validate, if we got any response and send placeholder data if we didn't.
  if (name == nil) then
    name = t['fetching_data']
  end

  return name
end

---
--- Prepares content of tooltip we want to show.
---
--- @param GameTooltip
---   GameTooltip object, that will do the rendering.
--- @param data
---   Map data for our point.
--- @param uiMapId
---   Map, where we want to create waypoint.
---
function Point:prepareTooltip(GameTooltip, data, uiMapId)
  -- Up-value GameTooltip.
  self.GameTooltip = GameTooltip
  -- Define name of tooltip.
  local name = self:prepareName(data)

  -- Set tooltip header (name).
  self.GameTooltip:SetText(name)
  -- Add note to tooltip.

  -- @todo perhaps move this to another file to be self-sustaining?
  -- If we have a note, we need to check if we should replace placeholder strings with real values.
  if data.note then
    -- Extract characters between [] and evaluate id and type ie [item(1234)].
    for type, id in data.note:gmatch('%[(%l+)%((%d+)%)%]') do
      if type == 'item' then
        data.note = data.note:gsub('%[' .. type .. '%(' .. id .. '%)%]', Item:getLink(id))
      end
      if type == 'npc' then
        data.note = data.note:gsub('%[' .. type .. '%(' .. id .. '%)%]', API:getNpcName(id))
      end
      if type == 'spell' then
        data.note = data.note:gsub('%[' .. type .. '%(' .. id .. '%)%]', API:getSpellName(id))
      end
      if type == 'achievement' then
        data.note = data.note:gsub('%[' .. type .. '%(' .. id .. '%)%]', Achievement:getLink(id))
      end
      if type == 'quest' then
        data.note = data.note:gsub('%[' .. type .. '%(' .. id .. '%)%]', API:getTitleForQuestID(id))
      end
      if type == 'currency' then
        data.note = data.note:gsub('%[' .. type .. '%(' .. id .. '%)%]', Currency:getLink(id))
      end
    end
  end

  self.GameTooltip:AddLine(data.note, nil, nil, nil, true)

  -- Add requirements to tooltip if there are any.
  if data.requirement then
    Requirements:prepare(self.GameTooltip, data.requirement)
  end

  -- Add rewards to tooltip.
  self:prepareLootTooltip(data.loot)
  -- Add waypoint info to tooltip.
  self:prepareWaypointTooltip(uiMapId)
  -- Add note about keeping tooltip opened.

  -- @todo need to figure out how to allow link click in tooltips. Disabled until then.
  -- self.GameTooltip:AddLine(Text:color(t['point_tooltip'], 'green'), nil, nil, nil, true)
  return
end

---
--- Prepares rewards for tooltip.
---
--- @param loot
---   Loot that can be earned from point.
---
function Point:prepareLootTooltip(loot)
  if not loot then
    return
  end

  -- Add header for loot.
  self.GameTooltip:AddLine(' ')
  self.GameTooltip:AddLine(t['rewards'])

  -- Store number of lines in tooltip.
  local lines = self.GameTooltip:NumLines();

  -- Type is achievement, pet, mount etc.
  for type, data in pairs(loot) do
    if (type == 'achievement') then
      -- Cycle all achievements.
      for achievementId, achievement in pairs(data) do
        self:prepareAchievementTooltip(achievementId, achievement)
      end
    end
    if (type == 'item') then
      -- Cycle all items.
      for itemId, item in pairs(data) do
        self:prepareItemTooltip(itemId, item)
      end
    end
  end

  -- Check, if we actually added any new lines. If not, write some text.
  -- @todo this should be done better, so it hides the word 'rewards'.
  if (lines == self.GameTooltip:NumLines()) then
    self.GameTooltip:AddLine(Text:color('-- ' .. t['not_eligible'] .. ' --', 'white'))
  end
end

---
--- Loops all items and evaluates, what to display.
---
--- @param itemId
---   ID of a item we are checking.
--- @param data
---   Item data (like quest or mount id, subtype).
---
function Point:prepareItemTooltip(itemId, data)
  -- If we have mount.
  if (data.mountId) then
    self:prepareMountTooltip(itemId, data.mountId)
    return
  end
  -- If we have toy.
  if (data.type == 'toy') then
    self:prepareToyTooltip(itemId)
    return
  end
  -- If we have pet.
  if (data.petId) then
    self:preparePetTooltip(itemId, data.petId)
    return
  end
  -- If we have item with quest.
  if (data.questId) then
    self:prepareQuestTooltip(itemId, data.questId)
    return
  end
  -- If we have transmog.
  if (data.type == 'transmog') then
    self:prepareTransmogTooltip(itemId, data.subtype)
    return
  end
  -- Basic item.
  self:prepareBasicTooltip(itemId, data.subtype)
end

---
--- Prepares tooltip display for achievements.
---
--- @todo Refactor this, since its bloated and can be simplified.
---
--- @param id
---   Achievement ID.
--- @param achievement
---   Achievement data.
---
function Point:prepareAchievementTooltip(id, achievement)
  local achievementStatus = t['in_progress']
  local color = 'red'
  local text = Achievement:getIcon(id) .. Achievement:getLink(id)

  if (Achievement:isCompleted(id)) then
    achievementStatus = t['earned']
    color = 'green'

    self.GameTooltip:AddDoubleLine(text, achievementStatus, nil, nil, nil, Text:color2rgb(color))

    -- If achievement is completed, don't display criteria or any sub-lines.
    return
  end

  self.GameTooltip:AddDoubleLine(text, achievementStatus, nil, nil, nil, Text:color2rgb(color))

  -- Achievement has countable requirement.
  if (achievement.count) then
    local name, count, required = Achievement:getCriteriaCount(id)
    achievementStatus = count .. '/' .. required
    color = 'yellow'

    -- Check, whether count is completed.
    if (count == required) then
      achievementStatus = t['earned']
      color = 'green'
    end

    self.GameTooltip:AddDoubleLine('     ' .. name, achievementStatus, 255, 255, 255, Text:color2rgb(color))

    -- We can quit here, because achievement with count and criteria id doesn't exist (hopefully).
    return
  end

  -- Achievement has single criteria.
  if (achievement.criteriaId) then
    if (type(achievement.criteriaId) == 'number') then
      achievementStatus = t['in_progress']
      color = 'red'

      if (Achievement:isCriteriaCompleted(id, achievement.criteriaId)) then
        achievementStatus = t['earned']
        color = 'green'
      end

      self.GameTooltip:AddDoubleLine('     ' .. Achievement:getCriteriaName(id, achievement.criteriaId), achievementStatus, 255, 255, 255, Text:color2rgb(color))

      -- If we assigned single criteria, there wont be multi criteria and we can quit.
      return
    end

    -- Achievement has multiple criteria.
    if (type(achievement.criteriaId) == 'table') then
      -- Check each criteria, like above.
      for _, criteriaId in ipairs(achievement.criteriaId) do
        achievementStatus = t['in_progress']
        color = 'red'

        if (Achievement:isCriteriaCompleted(id, criteriaId)) then
          achievementStatus = t['earned']
          color = 'green'
        end

        self.GameTooltip:AddDoubleLine('     ' .. Achievement:getCriteriaName(id, criteriaId), achievementStatus, 255, 255, 255, Text:color2rgb(color))
      end
    end
  end
end

---
--- Prepares tooltip display for mount.
---
--- @param id
---   Item ID that mount is learned from.
--- @param mountId
---   Mount ID from mount journal.
---
function Point:prepareMountTooltip(id, mountId)
  local color = 'red'

  if (Mount:isCollected(mountId)) then
    color = 'green'
  end

  local text = Item:getIcon(id) .. Item:getLink(id)

  self.GameTooltip:AddDoubleLine(text, t['mount'], nil, nil, nil, Text:color2rgb(color))
end

---
--- Prepares tooltip display for toy.
---
--- @param id
---   Item ID, that is toy.
---
function Point:prepareToyTooltip(id)
  local color = 'red'

  if (Toy:isCollected(id)) then
    color = 'green'
  end

  local text = Item:getIcon(id) .. Item:getLink(id)

  self.GameTooltip:AddDoubleLine(text, t['toy'], nil, nil, nil, Text:color2rgb(color))
end

---
--- Prepares tooltip display for pet.
---
--- @param id
---   Item ID, that pet is learned from.
--- @param speciesId
---   Species ID from pet journal.
---
function Point:preparePetTooltip(id, speciesId)
  local color = 'red'

  if (Pet:isCollected(speciesId)) then
    color = 'green'
  end

  local text = Item:getIcon(id) .. Item:getLink(id)

  self.GameTooltip:AddDoubleLine(text, t['pet'], nil, nil, nil, Text:color2rgb(color))
end

---
--- Prepares tooltip display for quest.
---
--- @param id
---   Item ID, that gives a quest.
--- @param questId
---   Quest ID from journal.
---
function Point:prepareQuestTooltip(id, questId)
  local color = 'red'

  if (Quest:isCompleted(questId)) then
    color = 'green'
  end

  local text = Item:getIcon(id) .. Item:getLink(id)

  self.GameTooltip:AddDoubleLine(text, t['quest'], nil, nil, nil, Text:color2rgb(color))
end

---
--- Prepares tooltip display for transmog.
---
--- @param id
---   Item ID, that is transmog.
--- @param subtype
---   Custom subtype for item. Some has unusable game data.
---
function Point:prepareTransmogTooltip(id, subtype)
  -- Does player want to track transmogs?
  local track = this.Addon.db.profile.transmogTrack
  -- Check, whether we are required to show unobtainable transmogs.
  local unobtainable = this.Addon.db.profile.transmogUnobtainable

  -- Player doesn't want to track transmogs, quit here
  if (track == false) then
    return
  end

  -- First, we check, if player can collect this transmog.
  local canCollect = API:playerCanCollectSource(id)

  -- Is transmog collected? Workaround for settings color.
  local collected = Transmog:isCollected(id)

  -- He can't collect this, but he doesn't want to show unobtainable sources, so we quit evaluation below.
  if (canCollect == false and unobtainable == false) then
    return
  end

  -- We can override subtype in map data file, because some game data are unusable (ie. off-hand).
  local description = subtype or Item:getSubtype(id)
  local color = 'red'

  -- If player can't collect source, change color to orange.
  if (canCollect == false and collected == false) then
    color = 'orange'
    -- Workaround, because rbg colors for some reason doesn't work with some combinations.
    -- @todo maybe replace everywhere with this color style.
    description = Text:color(description, color)
  end

  if (collected) then
    color = 'green'
  end

  local text = Item:getIcon(id) .. Item:getLink(id)

  self.GameTooltip:AddDoubleLine(text, description, nil, nil, nil, Text:color2rgb(color))
end

---
--- Prepares tooltip display for basic item.
---
--- @param id
---   Item ID.
--- @param subtype
---   Custom subtype for item. Some has unusable game data.
---
function Point:prepareBasicTooltip(id, subtype)
  -- We can override subtype in map data file, because some game data are unusable (ie. off-hand).
  local description = subtype or Item:getSubtype(id)
  local color = 'white'

  local text = Item:getIcon(id) .. Item:getLink(id)

  self.GameTooltip:AddDoubleLine(text, description, nil, nil, nil, Text:color2rgb(color))
end

---
--- Prepares tooltip display for waypoint.
---
--- @param uiMapId
---   Map, where we want to create waypoint.
---
function Point:prepareWaypointTooltip(uiMapId)
  -- Waypoints on this map cannot be created.
  if (API:canSetUserWaypointOnMap(uiMapId) == false) then
    return
  end

  -- Add info, that player can create waypoint here.
  self.GameTooltip:AddLine(' ')
  self.GameTooltip:AddLine(Text:color(t['waypoint'], 'green'), nil, nil, nil, true)
end

---
--- Creates user waypoint on map (if creation is possible).
---
--- @param uiMapId
---   Map, where we want to create waypoint.
--- @param coord
---   Coordinates on map, where we will be placing waypoint.
---
function Point:createWaypoint(uiMapId, coord)
  -- Waypoints on this map cannot be created.
  if (API:canSetUserWaypointOnMap(uiMapId) == false) then
    return
  end

  -- Get map vector.
  local mapPoint = API.UiMapPoint.CreateFromCoordinates(uiMapId, HandyNotes:getXY(coord))

  -- Create waypoint and set it active.
  API:setUserWaypoint(mapPoint)
  API:setSuperTrackedUserWaypoint()
end

this.Point = Point
