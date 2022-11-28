---
--- @file
--- Methods that operate with quests (completition etc.).
---

local _, this = ...

local API = this.API
local Cache = this.Cache
local t = this.t

local Quest = {}

---
--- Gets name for a quest.
---
--- @param id
---   Quest ID.
---
--- @return boolean
---   Localized quest name.
---
function Quest:getName(id)
  local name = Cache:get(id, 'questName')
  if (name == nil) then
    name = API:getTitleForQuestID(id)

    -- Validate, if we got any response and send placeholder data if we didn't.
    if (name == nil) then
      return t['fetching_data']
    end

    Cache:set(id, name, 'questName')
  end

  return name
end

---
--- Checks, whether quest is completed.
---
--- @param id
---   Quest ID.
---
--- @return boolean
---   True, if quest is completed, false otherwise.
---
function Quest:isCompleted(id)
  return API:isQuestFlaggedCompleted(id)
end

---
--- Checks, whether quest is active in quest tab.
---
--- @param id
---   Quest ID.
---
--- @return boolean
---   True, if quest is active, false otherwise.
---
function Quest:isActive(id)
  return API:isOnQuest(id)
end

this.Quest = Quest
