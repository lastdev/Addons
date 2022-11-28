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
    completed = false,
    scale = 1,
    opacity = 75,
    summary = true,
    transmogTrack = true,
    transmogUnobtainable = false,
    transmogAllSources = false,
    showCollection = true,
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
    Addon:SendMessage('HandyNotes_NotifyUpdate', 'Collection')
    Addon:Refresh()
  end,
  args = {
    tracking = {
      type = "group",
      name = t["config_tracking"],
      inline = true,
      order = 10,
      args = {
        showCollection = {
          name = t['config_name_collection_show'],
          desc = t['config_description_collection_show'],
          width = 'full',
          type = 'toggle',
          arg = 'showCollection',
          order = 10,
        },
        scale = {
          type = 'range',
          name = t['config_scale'],
          desc = t['config_description_scale'],
          min = 0.5,
          max = 2,
          step = 0.25,
          arg = 'scale',
          order = 20,
        },
        opacity = {
          type = 'range',
          name = t['config_opacity'],
          desc = t['config_description_opacity'],
          min = 0,
          max = 100,
          step = 1,
          arg = 'opacity',
          order = 30,
        },
        summary = {
          name = t['config_name_summary'],
          desc = t['config_description_summary'],
          type = 'toggle',
          width = 'full',
          arg = 'summary',
          order = 35,
        },
        completed = {
          name = t['config_name_completed'],
          desc = t['config_description_completed'],
          type = 'toggle',
          arg = 'completed',
          order = 40,
        },
        transmogTrack = {
          name = t['config_name_transmog_track'],
          desc = t['config_description_transmog_track'],
          type = 'toggle',
          width = 'full',
          arg = 'transmogTrack',
          order = 50,
        },
        transmogUnobtainable = {
          name = t['config_name_transmog_unobtainable'],
          desc = t['config_description_transmog_unobtainable'],
          type = 'toggle',
          arg = 'transmogUnobtainable',
          order = 60,
        },
        transmogAllSources = {
          name = t['config_name_transmog_exact_source'],
          desc = t['config_description_transmog_exact_source'],
          type = 'toggle',
          arg = 'transmogAllSources',
          order = 70,
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
