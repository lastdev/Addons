---
--- @file
--- This file exists to ensure language is loaded in right location.
---

local NAME, this = ...

local t = this.AceLocale:GetLocale(NAME)

this.t = t
