---
--- @file
--- Handles pet loot from npcs, quests and chests.
---

local _, this = ...

local API = this.API

local Pet = {}

---
--- Checks, whether pet is collected or not.
---
--- @param id
---   Species ID of the pet.
---
--- @return boolean
---   True, if pet is collected, false otherwise.
---
function Pet:isCollected(id)
  local collected = API:petJournalGetNumCollectedInfo(id)

  if (collected > 0) then
    return true
  end

  return false
end

this.Pet = Pet
