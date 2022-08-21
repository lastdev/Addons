---
--- @file
--- Methods to handle player character.
---

local _, this = ...

local API = this.API

local Player = {}

---
--- Checks, whether player is from Horde or not. We treat false as Alliance (even tho it can be neutral).
---
--- @return boolean
---   True, if player is from Horde faction, false otherwise.
---
function Player:isHorde()
  if (API:unitFactionGroup() == 'Horde') then
    return true
  end

  return false
end

this.Player = Player
