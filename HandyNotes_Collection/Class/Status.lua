---
--- @file
--- This is similar to cache, but it doesn't flush. It stores completed achievements, transmogs and other stuff.
---

local _, this = ...

---
--- Collection storage for data, so we won't have to query WoW API so much.
---
--- Currently used cache types are:
---   achievementId, mountId, sourceId, toyId, visualId
---
local Status = {}

---
--- Gets data from cache.
---
--- @param id
---   ID of object we want to get from status storage. Can be string or number.
--- @param type
---   Type of status storage, we are loading from (achievement, item etc.).
---
--- @return boolean
---   True, if requested id from given type has been completed, false otherwise.
---
function Status:get(id, type)
  -- Cache type doesn't exists, quit and don't search anymore.
  if not (HandyNotes_CollectionSTATUS[type]) then
    return false
  end

  -- Cycle all items in given array, if it contains our id.
  for _, value in ipairs(HandyNotes_CollectionSTATUS[type]) do
    if (value == id) then
      return true
    end
  end

  return false
end

---
--- Stores data to status storage.
---
--- @param id
---   ID of object we want to store to status storage. Can be string or number.
--- @param type
---   Type of status storage, we are storing to (achievement, item etc.).
---
function Status:set(id, type)
  -- Create cache type, if we don't have any.
  if not HandyNotes_CollectionSTATUS[type] then
    HandyNotes_CollectionSTATUS[type] = {}
  end

  table.insert(HandyNotes_CollectionSTATUS[type], id)
end

this.Status = Status
