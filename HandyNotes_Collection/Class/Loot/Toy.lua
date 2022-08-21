---
--- @file
--- Handles toy loot from npcs, quests and chests.
---

local _, this = ...

local API = this.API
local Status = this.Status

local Toy = {}

---
--- Checks, whether toy is collected or not.
---
--- @param id
---   Item ID, that toy is learned from.
---
--- @return boolean
---   True, if toy collected, false otherwise.
---
function Toy:isCollected(id)
  local collected = Status:get(id, 'toyId')
  if (collected == false) then
    collected = API:playerHasToy(id)

    -- Validate, if we got any response and send placeholder data if we didn't.
    if (collected == nil) then
      return false
    end

    if (collected == true) then
      Status:set(id, 'toyId')
    end
  end

  return collected
end

this.Toy = Toy
