---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['grd_train_depot'] = {
  [73302620] = {
    icon = 'door-up',
    portal = maps['grd_rafters'],
  },
}

points['grd_rafters'] = {
  [68102600] = {
    icon = 'door-down',
    portal = maps['grd_train_depot'],
  },
  [70107480] = {
    icon = 'door-down',
    portal = maps['grd_rear_train_cars'],
  },
}

points['grd_rear_train_cars'] = {
  [08305180] = {
    icon = 'door-left',
    portal = maps['grd_forward_train_cars'],
  },
}

points['grd_forward_train_cars'] = {
  [90805130] = {
    icon = 'door-right',
    portal = maps['grd_rear_train_cars'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
