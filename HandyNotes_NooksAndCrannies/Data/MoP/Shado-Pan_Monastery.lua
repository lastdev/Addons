---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['spm_cloudstrike_dojo'] = {
  [25008260] = {
    icon = 'poi-door-left',
    portal = maps['spm_shadopan_monastery'],
  },
}

points['spm_shadopan_monastery'] = {
  [56508660] = {
    icon = 'poi-door-right',
    portal = maps['spm_cloudstrike_dojo'],
  },
  [35907930] = {
    icon = 'poi-door-up',
    portal = maps['spm_snowdrift_dojo'],
  },
  [24606630] = {
    icon = 'poi-door-down',
    portal = maps['spm_snowdrift_dojo'],
  },
  [31803440] = {
    icon = 'poi-door-right',
    portal = maps['spm_sealed_chambers'],
  },
  [44303840] = {
    icon = 'poi-door-up',
    portal = maps['spm_sealed_chambers'],
  },
}

points['spm_snowdrift_dojo'] = {
  [71907620] = {
    icon = 'poi-door-down',
    portal = maps['spm_shadopan_monastery'],
  },
  [18401900] = {
    icon = 'poi-door-up',
    portal = maps['spm_shadopan_monastery'],
  },
}

points['spm_sealed_chambers'] = {
  [19507080] = {
    icon = 'poi-door-left',
    portal = maps['spm_shadopan_monastery'],
  },
  [50908030] = {
    icon = 'poi-door-down',
    portal = maps['spm_shadopan_monastery'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
