---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['bt_karabor_sewers'] = {
  [27500950] = {
    icon = 'poi-door-up',
    portal = maps['bt_black_temple'],
  },
}

points['bt_black_temple'] = {
  [29007770] = {
    icon = 'poi-door-down',
    portal = maps['bt_karabor_sewers'],
  },
  [74204780] = {
    icon = 'poi-door-right',
    portal = maps['bt_sanctuary_of_shadows'],
  },
}

points['bt_sanctuary_of_shadows'] = {
  [21105050] = {
    icon = 'poi-door-left',
    portal = maps['bt_black_temple'],
  },
  [61703420] = {
    icon = 'poi-door-right',
    portal = maps['bt_halls_of_anguish'],
  },
  [58509100] = {
    icon = 'poi-door-left',
    portal = maps['bt_gorefiends_vigil'],
  },
  [26702220] = {
    icon = 'poi-door-up',
    portal = maps['bt_den_of_mortal_delights'],
  },
}

points['bt_halls_of_anguish'] = {
  [64303940] = {
    icon = 'poi-door-left',
    portal = maps['bt_sanctuary_of_shadows'],
  },
}

points['bt_gorefiends_vigil'] = {
  [74706860] = {
    icon = 'poi-door-right',
    portal = maps['bt_sanctuary_of_shadows'],
  },
}

points['bt_den_of_mortal_delights'] = {
  [08505110] = {
    icon = 'poi-door-down',
    portal = maps['bt_sanctuary_of_shadows'],
  },
  [67305500] = {
    icon = 'poi-door-down',
    portal = maps['bt_chamber_of_command'],
  },
}

points['bt_chamber_of_command'] = {
  [64701790] = {
    icon = 'poi-door-left',
    portal = maps['bt_den_of_mortal_delights'],
  },
  [34104890] = {
    icon = 'poi-door-left',
    portal = maps['bt_temple_summit'],
  },
}

points['bt_temple_summit'] = {
  [53102680] = {
    icon = 'poi-door-down',
    portal = maps['bt_chamber_of_command'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
