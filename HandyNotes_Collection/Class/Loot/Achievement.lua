---
--- @file
--- Methods that operate with achievements (links, names, criteria, status etc.).
---

local _, this = ...

local API = this.API
local Cache = this.Cache
local Status = this.Status
local t = this.t

local Achievement = {}

---
--- Checks, whether achievement is valid or not.
---
--- @param id
---   Achievement ID.
---
--- @return boolean
---   True, if achievement is valid, false otherwise.
---
function Achievement:isValid(id)
  return API:achievementInfoIsValidAchievement(id)
end

---
--- Checks, whether achievement is completed.
---
--- @param id
---   Achievement ID.
---
--- @return boolean
---   True, if achievement is completed, false otherwise.
---
function Achievement:isCompleted(id)
  local completed = Status:get(id, 'achievementId')

  if (completed == false) then
    _, _, _, completed = API:getAchievementInfo(id)

    -- Validate, if we got any response and send placeholder data if we didn't.
    if (completed == nil) then
      return false
    end

    if (completed == true) then
      Status:set(id, 'achievementId')
    end
  end


  return completed
end

---
--- Checks, whether achievement criteria is completed.
---
--- @param id
---   Achievement ID.
---
--- @param criteriaId
---   Achievement criteria ID.
---
--- @return boolean
---   True, if achievement is completed, false otherwise.
---
function Achievement:isCriteriaCompleted(id, criteriaId)
  local _, _, completed = API:getAchievementCriteriaInfoByID(id, criteriaId)

  return completed
end

---
--- Checks, whether achievement has all count type criteria is completed.
---
--- @param id
---   Achievement ID.
---
--- @return boolean
---   True, if achievement is completed, false otherwise.
---
function Achievement:isCountCompleted(id)
  local _, _, completed = API:getAchievementCriteriaInfo(id)

  return completed
end

---
--- Gets link (formatted name) for achievement.
---
--- @param id
---   Achievement ID.
---
--- @return string
---   Formatted achievement link.
---
function Achievement:getLink(id)
  local link = Cache:get(id, 'achievementLink')
  if (link == nil) then
    link = API:getAchievementLink(id)

    -- Validate, if we got any response and send placeholder data if we didn't.
    if (link == nil) then
      return t['fetching_data']
    end

    Cache:set(id, link, 'achievementLink')
  end

  return link
end

---
--- Gets icon for achievement.
---
--- @param id
---   Achievement ID.
---
--- @return string
---   Formatted achievement icon.
---
function Achievement:getIcon(id)
  local icon = Cache:get(id, 'achievementIcon')
  if (icon == nil) then
    _, _, _, _, _, _, _, _, _, icon = API:getAchievementInfo(id)

    -- Validate, if we got any response and send placeholder data if we didn't.
    if (icon == nil) then
      return ''
    end

    -- Fix weird positioning in tooltip by moving it 1px down.
    icon = '|T' .. icon .. ':0:0:0:-1|t '
    Cache:set(id, icon, 'achievementIcon')
  end

  return icon
end

---
--- Gets criteria name of achievement by criteria id.
---
--- @param id
---   Achievement ID.
---
--- @param criteriaId
---   Achievement criteria ID.
---
--- @return string
---   Achievement criteria name.
---
function Achievement:getCriteriaName(id, criteriaId)
  local name = Cache:get(id .. criteriaId, 'criteriaName')
  if (name == nil) then
    name = API:getAchievementCriteriaInfoByID(id, criteriaId)

    -- Validate, if we got any response and send placeholder data if we didn't.
    if (name == nil) then
      return t['fetching_data']
    end

    Cache:set(id .. criteriaId, name, 'criteriaName')
  end

  return name
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
function Achievement:getCriteriaCount(id)
  local name, _, _, count, required = API:getAchievementCriteriaInfo(id)

  return name, count, required
end

this.Achievement = Achievement
