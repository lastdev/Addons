---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['skr_lower_quarter'] = {
  [43506930] = {
    icon = 'door-right',
    portal = maps['skr_grand_spire'],
  },
}

points['skr_grand_spire'] = {
  [18807400] = {
    icon = 'door-left',
    portal = maps['skr_lower_quarter'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
