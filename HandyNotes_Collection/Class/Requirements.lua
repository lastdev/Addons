---
--- @file
--- Handles requirements completition for displaying in tooltips.
---

local _, this = ...

local API = this.API
local Item = this.Item
local Achievement = this.Achievement
local Player = this.Player
local Profession = this.Profession
local Quest = this.Quest
local Text = this.Text
local t = this.t

local Requirements = {}

---
--- Prepares requirements for tooltip.
---
--- @param GameTooltip
---   Tooltip we are gonna assign notes to.
--- @param requirements
---   Requirements, that needs to be met.
---
function Requirements:prepare(GameTooltip, requirements)
  -- Assign tooltip.
  self.GameTooltip = GameTooltip

  -- Add header.
  self.GameTooltip:AddLine(' ')
  self.GameTooltip:AddLine(t['requirements'])

  -- Type is achievement, quest etc.
  for type, data in pairs(requirements) do
    if (type == 'faction') then
        self:prepareFactionRequirement(data)
    end
    if (type == 'quest') then
      self:prepareQuestRequirements(data)
    end
    if (type == 'achievement') then
      -- Cycle all achievements.
      for _, achievementId in ipairs(data) do
        self:prepareAchievementRequirement(achievementId)
      end
    end
    if (type == 'reputation') then
      -- Cycle all reputations.
      for reputationId, reputation in pairs(data) do
        self:prepareReputationRequirement(reputationId, reputation)
      end
    end
    if (type == 'profession') then
      self:prepareProfessionRequirement(data)
    end
    if (type == 'item') then
      -- Cycle all items.
      for itemId, _ in pairs(data) do
        self:prepareItemRequirement(itemId)
      end
    end
  end
end

---
--- Cycles all quest requirements and calls evaluation for single quest.
---
--- @param quests
---   Array with quests requirements.
---
function Requirements:prepareQuestRequirements(quests)
  for questId, data in pairs(quests) do
    self:prepareQuestRequirement(questId, data)
  end
end

---
--- Prepares requirement tooltip display for quest.
---
--- @param questId
---   Quest ID from journal.
--- @param data
---   Quest data, like state (completed / active).
---
function Requirements:prepareQuestRequirement(questId, data)
  local color = 'red'
  local status = t['incomplete']

  -- Quest must be completed.
  if (not data.state or data.state == 'completed') then
    if (Quest:isCompleted(questId)) then
      color = 'green'
      status = t['completed']
    end
  -- Quest must be active in journal.
  elseif (data.state == 'active') then
    status = t['inactive']

    if (Quest:isActive(questId)) then
      color = 'green'
      status = t['active']
    end
  end

  -- Quest name.
  local name = Quest:getName(questId)

  -- Quest flag icon.
  -- @todo replace with something more appropriate.
  local icon = '|T237607:0:0:0:-1|t '

  -- Change color to white.
  local text = icon .. Text:color(name, 'white')

  self.GameTooltip:AddDoubleLine(text, status, nil, nil, nil, Text:color2rgb(color))
end

---
--- Prepares requirement tooltip display for achievement.
---
--- @param achievementId
---   Achievement ID from journal.
---
function Requirements:prepareAchievementRequirement(achievementId)
  local color = 'red'
  local status = t['in_progress']

  if (Achievement:isCompleted(achievementId)) then
    status = t['earned']
    color = 'green'
  end

  local text = Achievement:getIcon(achievementId) .. Achievement:getLink(achievementId)

  self.GameTooltip:AddDoubleLine(text, status, nil, nil, nil, Text:color2rgb(color))
end

---
--- Prepares requirement tooltip display for reputation.
---
--- @param reputationId
---   Reputation ID.
--- @param reputation
---   Reputation detail, like standing etc.
---
function Requirements:prepareReputationRequirement(reputationId, reputation)
  local color = 'red'
  local name, standingId = API:getFactionInfoByID(reputationId)
  local status = API:getText(standingId)

  -- Quest flag icon.
  -- @todo replace with something more appropriate.
  local icon = '|T237607:0:0:0:-1|t '

  local text = icon .. Text:color(name, 'white')

  if (standingId >= reputation.level) then
    color = 'green'
  end

  self.GameTooltip:AddDoubleLine(text, status, nil, nil, nil, Text:color2rgb(color))
end

---
--- Prepares requirement tooltip display for items.
---
--- @param itemId
---   Item ID.
---
function Requirements:prepareItemRequirement(itemId)
  local color = 'red'
  local status = t['missing']
  local text = Item:getIcon(itemId) .. Item:getLink(itemId)

  if (Item:isInBag(itemId) == true) then
    color = 'green'
    status = t['collected']
  end

  self.GameTooltip:AddDoubleLine(text, status, nil, nil, nil, Text:color2rgb(color))
end

---
--- Prepares requirement tooltip display for faction.
---
--- @param faction
---   Faction name (Horde or Alliance).
---
function Requirements:prepareFactionRequirement(faction)
  local color = 'red'

  if ((faction:lower() == 'horde' and Player:isHorde() == true) or (faction:lower() == 'alliance' and Player:isHorde() == false)) then
    color = 'green'
  end

  self.GameTooltip:AddDoubleLine(t['faction'], faction, nil, nil, nil, Text:color2rgb(color))
end

---
--- Prepares profession tooltip display for items.
---
--- @param profession
---   Profession name. Works only for non-main professions at the moment.
---
function Requirements:prepareProfessionRequirement(profession)
  local color = 'red'
  local status = t['inactive']
  local text = Text:color(profession, 'white')
  local profIndex = Profession:isLearned(profession)

  if (profIndex ~= false) then
    local name, icon, level = API:getProfessionInfo(profIndex)
    icon = '|T' .. icon .. ':0:0:0:-1|t '
    color = 'green'
    status = t['active'] .. ' (' .. level .. ')'
    text = icon .. Text:color(name, 'white')
  end

  self.GameTooltip:AddDoubleLine(text, status, nil, nil, nil, Text:color2rgb(color))
end

this.Requirements = Requirements
