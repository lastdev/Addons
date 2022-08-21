---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['gss_gate_of_setting_sun'] = {
  [46203280] = {
    icon = 'door-up',
    portal = maps['gss_gate_watch_tower'],
  },
}

points['gss_gate_watch_tower'] = {
  [49105100] = {
    icon = 'door-down',
    portal = maps['gss_gate_of_setting_sun'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
