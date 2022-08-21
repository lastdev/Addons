---
--- @file
--- Logic for point loot.
---

local _, this = ...

local Achievement = this.Achievement
local Mount = this.Mount
local Pet = this.Pet
local Quest = this.Quest
local Toy = this.Toy
local Transmog = this.Transmog

local Loot = {}

---
--- Loops all loot and checks, if it is completed.
---
--- @param loot
---   Table with all loot options.
---
--- @return boolean
---   True, if all is completed, false otherwise.
---
function Loot:isCompleted(loot)
  self.status = {}

  -- Loop all items in loot.
  for key, value in pairs(loot) do
    if (key == 'achievement') then
      -- Loop all achievements.
      for id, achievement in pairs(value) do
        table.insert(self.status, self:isAchievementCompleted(id, achievement))
      end
    end
    if (key == 'item') then
      self:isItemCompleted(value)
    end
  end

  -- Loop all statuses, if anything is not done, return false.
  for _, value in ipairs(self.status) do
    if (value == false) then
      return false
    end
  end
  -- Everything is done.
  return true
end

---
--- Loops all items and checks, if they are completed.
---
--- @param items
---   Table with all items.
---
function Loot:isItemCompleted(items)
  -- Loop all items.
  for id, item in pairs(items) do
    if (item.mountId) then
      table.insert(self.status, Mount:isCollected(item.mountId))
    end
    if (item.type == 'toy') then
      table.insert(self.status, Toy:isCollected(id))
    end
    if (item.petId) then
      table.insert(self.status, Pet:isCollected(item.petId))
    end
    if (item.type == 'transmog') then
      table.insert(self.status, Transmog:isCollected(id))
    end
    if (item.questId) then
      table.insert(self.status, Quest:isCompleted(item.questId))
    end
  end
end

---
--- Checks, whether achievement in loot is completed.
---
--- @param id
---   Achievement ID.
--- @param achievement
---   Table with achievements data, if any.
---
--- @return boolean
---   True, if achievement or its part is completed, false otherwise.
---
function Loot:isAchievementCompleted(id, achievement)
  if (Achievement:isValid(id)) then
    -- Check, whether whole achievement is completed.
    if (Achievement:isCompleted(id)) then
      return true
    end

    -- We have count, so we have to check achievement criteria count.
    if (achievement.count) then
      return Achievement:isCountCompleted(id)
    end

    -- We have criteriaId, so we have to check achievement criteria id.
    if (achievement.criteriaId and type(achievement.criteriaId) == 'number') then
      return Achievement:isCriteriaCompleted(id, achievement.criteriaId)
    end

    -- We have multiple criteriaId, so we have to check every criteria id.
    if (achievement.criteriaId and type(achievement.criteriaId) == 'table') then
      for _, criteriaId in pairs(achievement.criteriaId) do
        if (Achievement:isCriteriaCompleted(id, criteriaId)) then
          return true
        end
      end
    end
  end

  return false
end

this.Loot = Loot
