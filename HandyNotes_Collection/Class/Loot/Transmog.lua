---
--- @file
--- Handles transmog loot from npcs, quests and chests.
---

local _, this = ...

local API = this.API
local Status = this.Status

local Transmog = {}

---
--- Prepares transmog check and evaluates global config
---
--- @param id
---   Item ID, that transmog is learned from.
---
--- @return boolean
---   True, if transmog collected, false otherwise.
---
function Transmog:prepare(id)
  -- Load config, how strict we should be.
  local track = this.Addon.db.profile.transmogTrack
  local unobtainable = this.Addon.db.profile.transmogUnobtainable

  -- Player doesn't want to track transmogs, treat them as collected.
  if (track == false) then
    return true
  end

  -- Check, if player has this exact transmog already.
  local collected = Status:get(id, 'visualId')
  if (collected == false) then
    collected = API:playerHasTransmog(id)

    if (collected == true) then
      Status:set(id, 'visualId')
    end
  end

  if (collected == true) then
    return true
  end

  -- Now, we check, if player can collect this transmog.
  local canCollect = API:playerCanCollectSource(id)

  -- He can't collect this, but he doesn't want to show unobtainable sources, so we act like he has it.
  if (canCollect == false and unobtainable == false) then
    return true
  end
end

---
--- Checks, whether transmog is collected or not.
---
--- @param id
---   Item ID, that transmog is learned from.
---
--- @return boolean
---   True, if transmog collected, false otherwise.
---
function Transmog:isCollected(id)
  -- Prepare for check.
  if (self:prepare(id) == true) then
    return true
  end

  -- Load config, how strict we should be.
  local exact = this.Addon.db.profile.transmogAllSources

  -- Player doesn't want to look for exact source, so we check other sources with same appearances.
  if (exact == false) then
    -- Load more detailed data about this transmog.
    local appearanceId, sourceId = API:getTransmogInfo(id)

    -- Check modified appearance.
    local collectedModified = Status:get(id, 'sourceId')
    if (collectedModified == false) then
      collectedModified = API:playerHasTransmogAppearance(sourceId)

      if (collectedModified == true) then
        Status:set(id, 'sourceId')
      end
    end

    if (collectedModified == true) then
      return true
    end

    -- Load other sources with same appearance.
    local sources = API:getAppearanceSources(appearanceId)

    -- No sources, he doesn't have it.
    if (sources == nil) then
      return false
    end

    -- Loop all sources, if player has at least one, he has it.
    for _, source in pairs(sources) do
      if (source.isCollected) then
        return true
      end
    end
  end

  -- Everything failed, he really doesn't have it.
  return false
end

this.Transmog = Transmog
