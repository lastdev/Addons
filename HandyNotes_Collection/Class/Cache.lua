---
--- @file
--- Cache handling.
---

local _, this = ...

local API = this.API
local t = this.t

---
--- Cache storage for data, so we won't have to query WoW API so much.
---
--- Currently used cache types are:
---   achievementIcon, achievementLink, criteriaName, itemIcon, itemLink,
---   itemSubtype, mapName, mountCollected, npcName, questName,
---   transmogExact, transmogModified, toyCollected.
---
local Cache = {}

---
--- Initializes cache, invalidating if version is mismatched, so we are caching current data.
---
function Cache:initialize()
  -- Get game build from API.
  local gameVersion = API:getVersion()
  -- If we don't have cache or version is not matched, invalidate cache.
  if not HandyNotes_CollectionCACHE or (self:get('version') ~= gameVersion) then
    self:invalidate()
  end
end

---
--- Gets data from cache.
---
--- @param id
---   ID of object we want to get from cache. Can be string or number.
--- @param type
---   Type of cache, we are loading from (achievement, item etc.). Can be omitted.
---
--- @return ?string
---   Data from cache or nil, if we don't have them.
---
function Cache:get(id, type)
  -- If we have data in cache, return it.
  if not type and HandyNotes_CollectionCACHE[id] then
    return HandyNotes_CollectionCACHE[id]
  end

  -- Cache type doesn't exists, quit and don't search anymore.
  if not (HandyNotes_CollectionCACHE[type]) then
    return nil
  end

  if (HandyNotes_CollectionCACHE[type][id]) then
    return HandyNotes_CollectionCACHE[type][id]
  end

  return nil
end

---
--- Stores data to cache.
---
--- @param id
---   ID of object we want to store to cache. Can be string or number.
--- @param data
---   Data we want to store to cache.
--- @param type
---   Type of cache, we are storing to (achievement, item etc.). Can be omitted.
---
function Cache:set(id, data, type)
  if (data == nil or data == t['fetching_data']) then
    return
  end

  if not type then
    HandyNotes_CollectionCACHE[id] = data
    return
  end

  -- Create cache type, if we don't have any.
  if not HandyNotes_CollectionCACHE[type] then
    HandyNotes_CollectionCACHE[type] = {}
  end

  HandyNotes_CollectionCACHE[type][id] = data
end

---
--- Invalidates all data in cache.
---
function Cache:invalidate()
  HandyNotes_CollectionCACHE = {}
  -- Set version to cache, so it doesn't invalidate next time we reload game.
  local gameVersion = API:getVersion()
  self:set('version', gameVersion)
end

this.Cache = Cache
