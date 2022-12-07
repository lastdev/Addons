---
--- @file
--- Summary point with all loot in given map.
---

local _, this = ...

local Loot = this.Loot

local Summary = {}

Summary.rewards = {}

---
--- Aggregates all map rewards into single point.
---
--- @param points
---   All points in given map.
---
--- @return table point
---   Summary point for map.
---
function Summary:preparePoint(points)
  if (this.Addon.db.profile.summary == false) then
    return nil
  end

  -- Clear rewards table.
  self.rewards = {}

  for _, data in pairs(points) do
    if (data.loot and data.summary == nil and Loot:isCompleted(data.loot) == false) then
      for type, loot in pairs(data.loot) do
        if (self.rewards[type] == nil) then
          self.rewards[type] = {}
        end
        -- Aggregate loot from all points.

        -- Achievements are a bit complicated, since the will have multiple criteria.
        if (type == 'achievement') then
          self:achievement(loot, type)
        end

        -- Items are simple, just add them or replace duplicates, it doesn't really matter.
        if (type == 'item') then
          self:item(loot, type)
        end
      end
    end
  end

  return self.rewards
end

function Summary:achievement(loot, reward)
  for id, values in pairs (loot) do
    if (values.criteriaId) then
      if (self.rewards[reward][id] == nil) then
        self.rewards[reward][id] = {}
      end
      if (self.rewards[reward][id]['criteriaId'] == nil) then
        self.rewards[reward][id]['criteriaId'] = {}
      end
      if (type(values.criteriaId) == 'table') then
        for _,v in ipairs(values.criteriaId) do
          table.insert(self.rewards[reward][id]['criteriaId'], v)
        end
      else
        table.insert(self.rewards[reward][id]['criteriaId'], values.criteriaId)
      end
    else
      self.rewards[reward][id] = values
    end
  end
end

function Summary:item(loot, type)
  for id, values in pairs (loot) do
    self.rewards[type][id] = values
  end

end

this.Summary = Summary
