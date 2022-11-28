---
--- @file
--- Basic addon initialization.
---

-- In every file, this is returned by game client. First is addon name, second is table with data,
-- so we can pass it between files.
local NAME, this = ...

-- Localize globals.
local LibStub = _G.LibStub
local AceLocale = LibStub('AceLocale-3.0')
local HandyNotes = LibStub('AceAddon-3.0'):GetAddon('HandyNotes')
---
--- Register our Addon with AceEvents-3.0, so we can register events with function callbacks.
---
--- @see Addon:OnEnable()
---
local Addon = LibStub('AceAddon-3.0'):NewAddon(NAME, 'AceEvent-3.0')

-- Initialize map points, so we can move all data files at the end of .toc file.
local points = {}

-- Register our addon back to global namespace.
this.Addon = Addon
this.AceLocale = AceLocale
this.HandyNotes = HandyNotes
this.LibStub = LibStub
this.points = points
