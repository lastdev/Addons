---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['kz_servants_quarters'] = {
  [39208910] = {
    icon = 'door-up',
    portal = maps['kz_upper_livery_stables'],
  },
  [53106300] = {
    icon = 'door-up',
    portal = maps['kz_banquet_hall'],
  },
  [38401240] = {
    icon = 'door-right',
    portal = maps['kz_guest_chambers'],
  },
}

points['kz_upper_livery_stables'] = {
  [24807430] = {
    icon = 'door-down',
    portal = maps['kz_servants_quarters'],
  },
  [74502430] = {
    icon = 'door-down',
    portal = maps['kz_servants_quarters'],
  },
  [38900960] = {
    icon = 'door-up',
    portal = maps['kz_banquet_hall'],
  },
}

points['kz_banquet_hall'] = {
  [39608440] = {
    icon = 'door-down',
    portal = maps['kz_upper_livery_stables'],
  },
  [52409220] = {
    icon = 'door-down',
    portal = maps['kz_servants_quarters'],
  },
  [71103770] = {
    icon = 'door-left',
    portal = maps['kz_guest_chambers'],
  },
}

points['kz_guest_chambers'] = {
  [45702860] = {
    icon = 'door-left',
    portal = maps['kz_servants_quarters'],
  },
  [71304340] = {
    icon = 'door-down',
    portal = maps['kz_banquet_hall'],
  },
  [23504950] = {
    icon = 'door-right',
    portal = maps['kz_opera_hall_balcony'],
  },
  [51808480] = {
    icon = 'door-down',
    portal = maps['kz_masters_terrace'],
  },
}

points['kz_opera_hall_balcony'] = {
  [43008310] = {
    icon = 'door-left',
    portal = maps['kz_guest_chambers'],
  },
  [62802050] = {
    icon = 'door-up',
    portal = maps['kz_masters_terrace'],
  },
}

points['kz_masters_terrace'] = {
  [39601140] = {
    icon = 'door-down',
    portal = maps['kz_opera_hall_balcony'],
  },
  [53606900] = {
    icon = 'door-up',
    portal = maps['kz_guest_chambers'],
  },
  [66006660] = {
    icon = 'door-right',
    portal = maps['kz_lower_broken_stair'],
  },
}

points['kz_lower_broken_stair'] = {
  [69306500] = {
    icon = 'door-left',
    portal = maps['kz_masters_terrace'],
  },
  [50302370] = {
    icon = 'door-down',
    portal = maps['kz_masters_terrace'],
  },
  [54006140] = {
    icon = 'door-up',
    portal = maps['kz_upper_broken_stair'],
  },
}

points['kz_upper_broken_stair'] = {
  [58905400] = {
    icon = 'door-down',
    portal = maps['kz_lower_broken_stair'],
  },
  [53805210] = {
    icon = 'door-up',
    portal = maps['kz_menagerie'],
  },
}

points['kz_menagerie'] = {
  [60801980] = {
    icon = 'door-down',
    portal = maps['kz_upper_broken_stair'],
  },
  [30706530] = {
    icon = 'door-up',
    portal = maps['kz_guardians_library'],
  },
}

points['kz_guardians_library'] = {
  [31806090] = {
    icon = 'door-down',
    portal = maps['kz_menagerie'],
  },
  [36102040] = {
    icon = 'door-left',
    portal = maps['kz_repository'],
  },
  [60305780] = {
    icon = 'door-right',
    portal = maps['kz_upper_library'],
  },
}

points['kz_repository'] = {
  [66302490] = {
    icon = 'door-right',
    portal = maps['kz_guardians_library'],
  },
}

points['kz_upper_library'] = {
  [46105310] = {
    icon = 'door-left',
    portal = maps['kz_guardians_library'],
  },
  [24606020] = {
    icon = 'door-up',
    portal = maps['kz_celestial_watch'],
  },
  [40001710] = {
    icon = 'door-right',
    portal = maps['kz_gamesmans_hall'],
  },
}

points['kz_celestial_watch'] = {
  [55008070] = {
    icon = 'door-down',
    portal = maps['kz_upper_library'],
  },
}

points['kz_gamesmans_hall'] = {
  [18708250] = {
    icon = 'door-left',
    portal = maps['kz_upper_library'],
  },
  [82205500] = {
    icon = 'door-up',
    portal = maps['kz_medivhs_chambers'],
  },
  [38901820] = {
    icon = 'door-left',
    portal = maps['kz_medivhs_chambers'],
  },
}

points['kz_medivhs_chambers'] = {
  [79506930] = {
    icon = 'door-down',
    portal = maps['kz_gamesmans_hall'],
  },
  [29003040] = {
    icon = 'door-right',
    portal = maps['kz_gamesmans_hall'],
  },
  [84807290] = {
    icon = 'door-up',
    portal = maps['kz_power_station'],
  },
}

points['kz_power_station'] = {
  [70007580] = {
    icon = 'door-down',
    portal = maps['kz_medivhs_chambers'],
  },
  [61207370] = {
    icon = 'door-up',
    portal = maps['kz_netherspace'],
  },
}

points['kz_netherspace'] = {
  [50909060] = {
    icon = 'door-down',
    portal = maps['kz_power_station'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
