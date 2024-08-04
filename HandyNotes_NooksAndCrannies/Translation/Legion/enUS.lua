---
--- @file
--- Localization file for Cataclysm in enUS language.
---

local NAME, this = ...

-- We add true as last parameter, since this is default language.
local t = this.AceLocale:NewLocale(NAME, 'enUS', true)

if not t then
  return
end

-- Valdrakken
t['shalaran'] = "Portal to Shal'Aran"
