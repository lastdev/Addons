---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps
local t = this.t

points['ugp_upper_pinnacle'] = {
  [41807680] = {
    name = t['observance_hall'],
    icon = 'poi-door-right',
    portal = maps['ugp_lower_pinnacle'],
  },
  [59503300] = {
    name = t['ruined_court'],
    icon = 'poi-door-down',
    portal = maps['ugp_lower_pinnacle'],
  },
  [54407910] = {
    name = t['observance_hall'],
    icon = 'poi-door-down',
    portal = maps['ugp_lower_pinnacle'],
  },
  [55005360] = {
    name = t['ruined_court'],
    icon = 'poi-door-right',
    portal = maps['ugp_lower_pinnacle'],
  },
}

points['ugp_lower_pinnacle'] = {
  [28407640] = {
    name = t['ravens_watch'],
    icon = 'poi-door-up',
    portal = maps['ugp_upper_pinnacle'],
  },
  [46008430] = {
    name = t['trophy_hall'],
    icon = 'poi-door-up',
    portal = maps['ugp_upper_pinnacle'],
  },
  [54301730] = {
    name = t['eagles_eye'],
    icon = 'poi-door-up',
    portal = maps['ugp_upper_pinnacle'],
  },
  [40304420] = {
    name = t['ymirons_seat'],
    icon = 'poi-door-left',
    portal = maps['ugp_upper_pinnacle'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
