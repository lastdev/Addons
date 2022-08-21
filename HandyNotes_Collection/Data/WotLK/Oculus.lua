---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['ocl_band_of_variance'] = {
  [49308210] = {
    icon = 'door-up',
    portal = maps['ocl_band_of_transmutation'],
  },
}

points['ocl_band_of_acceleration'] = {
  [49407770] = {
    icon = 'door-down',
    portal = maps['ocl_band_of_variance'],
  },
  [49407240] = {
    icon = 'door-up',
    portal = maps['ocl_band_of_transmutation'],
  },
}

points['ocl_band_of_transmutation'] = {
  [33407930] = {
    icon = 'door-down',
    portal = maps['ocl_band_of_acceleration'],
  },
  [66307760] = {
    icon = 'door-up',
    portal = maps['ocl_band_of_alignment'],
  },
}

points['ocl_band_of_alignment'] = {
  [47807470] = {
    icon = 'door-down',
    portal = maps['ocl_band_of_transmutation'],
  },
}


-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
