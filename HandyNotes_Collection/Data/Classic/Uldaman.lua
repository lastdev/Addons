---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['uld_hall_of_keepers'] = {
  [47201280] = {
    icon = 'door-down',
    portal = maps['uld_khazgoroths_seat'],
  },
}

points['uld_khazgoroths_seat'] = {
  [64704180] = {
    icon = 'door-up',
    portal = maps['uld_hall_of_keepers'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
