---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['msp_crimson_assembly_hall'] = {
  [49806790] = {
    icon = 'door-down',
    portal = maps['msp_vaults_of_kings_past'],
  },
}

points['msp_vaults_of_kings_past'] = {
  [59802650] = {
    icon = 'door-up',
    portal = maps['msp_crimson_assembly_hall'],
  },
  [71607610] = {
    icon = 'door-up',
    portal = maps['msp_throne_of_ancient_conquerors'],
  },
}

points['msp_throne_of_ancient_conquerors'] = {
  [58902420] = {
    icon = 'door-down',
    portal = maps['msp_vaults_of_kings_past'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
