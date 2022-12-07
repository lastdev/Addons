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

-- Dragon Soul
t['wyrmrest_temple'] = 'Wyrmrest Temple'
t['wyrmrest_summit'] = 'Wyrmrest Summit'
