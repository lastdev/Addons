---
--- @file
--- Methods that operate with professions (name, recipes etc.).
---

local _, this = ...

local API = this.API

local Profession = {}

---
--- Checks, whether profession is learned or not.
---
--- @param name
---   Profession name (lowercase).
---
--- @return boolean
---   True, if profession is learned, false otherwise.
---
function Profession:isLearned(name)
  -- @TODO might need little bit of a simplification.
  -- @TODO prepare for main professions.
  local index = ''
  -- Currently only works for non-main professions.
  if (name == 'archaeology') then
    _, _, index = API:getProfessions()
  elseif (name == 'fishing') then
    _, _, _, index = API:getProfessions()
  elseif (name == 'cooking') then
    _, _, _, _, index = API:getProfessions()
  end

  if (index == nil) then
    return false
  end

  return index
end

this.Profession = Profession
