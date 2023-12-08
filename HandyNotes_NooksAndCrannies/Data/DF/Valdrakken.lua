---
--- @file
--- Map point definitions.
---

local _, this = ...

local Player = this.Player
local points = {}
local maps = this.maps
local t = this.t

-- Alliance portals.
local Home = {
  ['id'] = maps['stormwind'],
  ['position'] = 59704180,
}

-- Horde portals.
if (Player:isHorde() == true) then
  Home = {
    ['id'] = maps['orgrimmar'],
    ['position'] = 56603830,
  }
end

points['valdrakken'] = {
  [Home['position']] = {
    icon = 'warlockportal-yellow-32x32',
    portal = Home['id'],
  },
  [53605540] = {
    name = t['timeways'],
    note = t['timeways_note'],
    icon = 'warlockportal-yellow-32x32',
    portal = maps['timeways'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
