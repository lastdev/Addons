---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['kz_servants_quarters'] = {
  [39208910] = {
    icon = 'poi-door-up',
    portal = maps['kz_upper_livery_stables'],
  },
  [53106300] = {
    icon = 'poi-door-up',
    portal = maps['kz_banquet_hall'],
  },
  [38401240] = {
    icon = 'poi-door-right',
    portal = maps['kz_guest_chambers'],
  },
}

points['kz_upper_livery_stables'] = {
  [24807430] = {
    icon = 'poi-door-down',
    portal = maps['kz_servants_quarters'],
  },
  [74502430] = {
    icon = 'poi-door-down',
    portal = maps['kz_servants_quarters'],
  },
  [38900960] = {
    icon = 'poi-door-up',
    portal = maps['kz_banquet_hall'],
  },
}

points['kz_banquet_hall'] = {
  [39608440] = {
    icon = 'poi-door-down',
    portal = maps['kz_upper_livery_stables'],
  },
  [52409220] = {
    icon = 'poi-door-down',
    portal = maps['kz_servants_quarters'],
  },
  [71103770] = {
    icon = 'poi-door-left',
    portal = maps['kz_guest_chambers'],
  },
}

points['kz_guest_chambers'] = {
  [45702860] = {
    icon = 'poi-door-left',
    portal = maps['kz_servants_quarters'],
  },
  [71304340] = {
    icon = 'poi-door-down',
    portal = maps['kz_banquet_hall'],
  },
  [23504950] = {
    icon = 'poi-door-right',
    portal = maps['kz_opera_hall_balcony'],
  },
  [51808480] = {
    icon = 'poi-door-down',
    portal = maps['kz_masters_terrace'],
  },
}

points['kz_opera_hall_balcony'] = {
  [43008310] = {
    icon = 'poi-door-left',
    portal = maps['kz_guest_chambers'],
  },
  [62802050] = {
    icon = 'poi-door-up',
    portal = maps['kz_masters_terrace'],
  },
}

points['kz_masters_terrace'] = {
  [39601140] = {
    icon = 'poi-door-down',
    portal = maps['kz_opera_hall_balcony'],
  },
  [53606900] = {
    icon = 'poi-door-up',
    portal = maps['kz_guest_chambers'],
  },
  [66006660] = {
    icon = 'poi-door-right',
    portal = maps['kz_lower_broken_stair'],
  },
}

points['kz_lower_broken_stair'] = {
  [69306500] = {
    icon = 'poi-door-left',
    portal = maps['kz_masters_terrace'],
  },
  [50302370] = {
    icon = 'poi-door-down',
    portal = maps['kz_masters_terrace'],
  },
  [54006140] = {
    icon = 'poi-door-up',
    portal = maps['kz_upper_broken_stair'],
  },
}

points['kz_upper_broken_stair'] = {
  [58905400] = {
    icon = 'poi-door-down',
    portal = maps['kz_lower_broken_stair'],
  },
  [53805210] = {
    icon = 'poi-door-up',
    portal = maps['kz_menagerie'],
  },
}

points['kz_menagerie'] = {
  [60801980] = {
    icon = 'poi-door-down',
    portal = maps['kz_upper_broken_stair'],
  },
  [30706530] = {
    icon = 'poi-door-up',
    portal = maps['kz_guardians_library'],
  },
}

points['kz_guardians_library'] = {
  [31806090] = {
    icon = 'poi-door-down',
    portal = maps['kz_menagerie'],
  },
  [36102040] = {
    icon = 'poi-door-left',
    portal = maps['kz_repository'],
  },
  [60305780] = {
    icon = 'poi-door-right',
    portal = maps['kz_upper_library'],
  },
}

points['kz_repository'] = {
  [66302490] = {
    icon = 'poi-door-right',
    portal = maps['kz_guardians_library'],
  },
}

points['kz_upper_library'] = {
  [46105310] = {
    icon = 'poi-door-left',
    portal = maps['kz_guardians_library'],
  },
  [24606020] = {
    icon = 'poi-door-up',
    portal = maps['kz_celestial_watch'],
  },
  [40001710] = {
    icon = 'poi-door-right',
    portal = maps['kz_gamesmans_hall'],
  },
}

points['kz_celestial_watch'] = {
  [55008070] = {
    icon = 'poi-door-down',
    portal = maps['kz_upper_library'],
  },
}

points['kz_gamesmans_hall'] = {
  [18708250] = {
    icon = 'poi-door-left',
    portal = maps['kz_upper_library'],
  },
  [82205500] = {
    icon = 'poi-door-up',
    portal = maps['kz_medivhs_chambers'],
  },
  [38901820] = {
    icon = 'poi-door-left',
    portal = maps['kz_medivhs_chambers'],
  },
}

points['kz_medivhs_chambers'] = {
  [79506930] = {
    icon = 'poi-door-down',
    portal = maps['kz_gamesmans_hall'],
  },
  [29003040] = {
    icon = 'poi-door-right',
    portal = maps['kz_gamesmans_hall'],
  },
  [84807290] = {
    icon = 'poi-door-up',
    portal = maps['kz_power_station'],
  },
}

points['kz_power_station'] = {
  [70007580] = {
    icon = 'poi-door-down',
    portal = maps['kz_medivhs_chambers'],
  },
  [61207370] = {
    icon = 'poi-door-up',
    portal = maps['kz_netherspace'],
  },
}

points['kz_netherspace'] = {
  [50909060] = {
    icon = 'poi-door-down',
    portal = maps['kz_power_station'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
