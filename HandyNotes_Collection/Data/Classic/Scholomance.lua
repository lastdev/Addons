---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['schm_reliquary'] = {
  [80302380] = {
    icon = 'door-left',
    portal = maps['schm_chamber_of_summoning'],
  },
}

points['schm_chamber_of_summoning'] = {
  [77302650] = {
    icon = 'door-right',
    portal = maps['schm_reliquary'],
  },
  [57609360] = {
    icon = 'door-down',
    portal = maps['schm_upper_study'],
  },
}

points['schm_upper_study'] = {
  [49601350] = {
    icon = 'door-up',
    portal = maps['schm_chamber_of_summoning'],
  },
  [49902610] = {
    icon = 'door-down',
    portal = maps['schm_headmasters_study'],
  },
}

points['schm_headmasters_study'] = {
  [50001800] = {
    icon = 'door-up',
    portal = maps['schm_upper_study'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
