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

-- Utgarde Pinnacle
t['ymirons_seat'] = "Ymiron's Seat"
t['ravens_watch'] = "Raven's Watch"
t['eagles_eye'] = "Eagle's Eye"
t['observance_hall'] = 'Observance Hall'
t['ruined_court'] = 'Ruined Court'
t['trophy_hall'] = 'Trophy Hall'
