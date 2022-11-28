---
--- @file
--- Icon class for defining icons and their look.
---

local NAME, this = ...

local Icon = {}

---
--- Path to folder with icons.
---
Icon.path = 'Interface\\Addons\\' .. NAME .. '\\gfx\\'

---
--- List of icons we are going to use in our addon on map.
---
Icon.list = {
  ['default'] = Icon.path .. 'dot.blp',
  ['achievement'] = Icon.path .. 'achievement.blp',
  ['chest'] = Icon.path .. 'treasure.blp',
  ['monster'] = Icon.path .. 'monster.blp',
  ['pet'] = Icon.path .. 'pet.blp',
  ['poi'] = Icon.path .. 'dot.blp',
  ['portal'] = Icon.path .. 'portal.blp',
  ['summary'] = Icon.path .. 'summary.blp',
}

this.Icon = Icon
