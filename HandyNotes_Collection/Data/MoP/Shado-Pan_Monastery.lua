---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['spm_cloudstrike_dojo'] = {
  [25008260] = {
    icon = 'door-left',
    portal = maps['spm_shadopan_monastery'],
  },
}

points['spm_shadopan_monastery'] = {
  [56508660] = {
    icon = 'door-right',
    portal = maps['spm_cloudstrike_dojo'],
  },
  [35907930] = {
    icon = 'door-up',
    portal = maps['spm_snowdrift_dojo'],
  },
  [24606630] = {
    icon = 'door-down',
    portal = maps['spm_snowdrift_dojo'],
  },
  [31803440] = {
    icon = 'door-right',
    portal = maps['spm_sealed_chambers'],
  },
  [44303840] = {
    icon = 'door-up',
    portal = maps['spm_sealed_chambers'],
  },
}

points['spm_snowdrift_dojo'] = {
  [71907620] = {
    icon = 'door-down',
    portal = maps['spm_shadopan_monastery'],
  },
  [18401900] = {
    icon = 'door-up',
    portal = maps['spm_shadopan_monastery'],
  },
}

points['spm_sealed_chambers'] = {
  [19507080] = {
    icon = 'door-left',
    portal = maps['spm_shadopan_monastery'],
  },
  [50908030] = {
    icon = 'door-down',
    portal = maps['spm_shadopan_monastery'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
