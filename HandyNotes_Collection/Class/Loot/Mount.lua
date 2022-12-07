---
--- @file
--- Handles mount loot from npcs, quests and chests.
---

local _, this = ...

local API = this.API
local Status = this.Status

local Mount = {}

---
--- Checks, whether mount is collected or not.
---
--- @param id
---   Mount ID of the mount.
---
--- @return boolean
---   True, if mount is collected, false otherwise.
---
function Mount:isCollected(id)
  local collected = Status:get(id, 'mountId')
  if (collected == false) then
    _, _, collected = API:mountJournalGetMountInfo(id)

    -- Validate, if we got any response and send placeholder data if we didn't.
    if (collected == nil) then
      return false
    end

    if (collected == true) then
      Status:set(id, 'mountId')
    end
  end

  return collected
end

this.Mount = Mount
