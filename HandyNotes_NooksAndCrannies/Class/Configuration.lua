---
--- @file
--- Global module configuration.
---

local _, this = ...

local Addon = this.Addon
local Cache = this.Cache
local t = this.t

---
--- Defines, which configuration will be loaded, when addon is initialized.
---
--- @see Addon:OnInitialize()
---
--- @var table defaults
---   Default addon configuration.
---
this.defaults = {
  profile = {
    scale = 1,
    opacity = 100,
    worldScale = 0.75,
    worldOpacity = 100,
  },
}

---
--- Defines our options to be configured from game UI under Interface -> AddOns -> HandyNotes -> Plugins.
---
--- This is AceConfig-3.0 standardized table.
--- @link https://www.wowace.com/projects/ace3/pages/ace-config-3-0-options-tables
---
--- @todo better config display UI.
---
--- @var table options
---   Configuration options for our addon.
---
this.options = {
  type = 'group',
  name = t['config_name'],
  desc = t['config_description'],
  get = function(info) return Addon.db.profile[info.arg] end,
  set = function(info, v)
    Addon.db.profile[info.arg] = v
    Addon:SendMessage('HandyNotes_NotifyUpdate', 'NooksAndCrannies')
    Addon:Refresh()
  end,
  args = {
    waypoints = {
      type = "group",
      name = t["config_waypoint"],
      inline = true,
      order = 10,
      args = {
        scale = {
          type = 'range',
          name = t['config_scale'],
          desc = t['config_description_scale'],
          min = 0.25,
          max = 2,
          step = 0.25,
          arg = 'scale',
          order = 10,
        },
        opacity = {
          type = 'range',
          name = t['config_opacity'],
          desc = t['config_description_opacity'],
          min = 0,
          max = 100,
          step = 1,
          arg = 'opacity',
          order = 20,
        },
        worldScale = {
          type = 'range',
          name = t['config_worldscale'],
          desc = t['config_description_worldscale'],
          min = 0.25,
          max = 2,
          step = 0.05,
          arg = 'worldScale',
          order = 30,
        },
        worldOpacity = {
          type = 'range',
          name = t['config_worldopacity'],
          desc = t['config_description_worldopacity'],
          min = 0,
          max = 100,
          step = 1,
          arg = 'worldOpacity',
          order = 40,
        },
      },
    },
    resetCache = {
      name = t['config_name_cache'],
      desc = t['config_description_cache'],
      type = 'execute',
      func = function() Cache:invalidate() end,
      confirm = true,
      arg = 'resetCache',
      order = 20,
    },
  },
}
