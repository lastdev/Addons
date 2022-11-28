---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = this.points

---
--- Table with maps names and their respective IDs.
---
--- @link https://wow.tools/dbc/?dbc=uimapgroupmember
---
--- @var table maps
---   Map definitions for easier finding and loading UiMapIDs in specific maps.
---
local maps = {
  -- Warlords of Draenor
  ['draenor'] = 572,
  ['frostfire_ridge'] = 525,
  ['tanaan_jungle'] = 534,
  ['talador'] = 535,
  ['shadowmoon_valley'] = 539,
  ['spires_of_arak'] = 542,
  ['gorgrond'] = 543,
  ['nagrand'] = 550,

  -- Minimaps
  ['tomb_of_souls'] = 537,
  ['bloodthorn_cave'] = 540,
  ['cragplume'] = 549,
}

-- Iterate all maps and assign their ids, so we can use them for our points.
for _, id in pairs(maps) do
  points[id] = {}
end

this.maps = maps
this.points = points
