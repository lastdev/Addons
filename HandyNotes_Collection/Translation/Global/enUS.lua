---
--- @file
--- Localization file for global text strings in enUS language.
---

local NAME, this = ...

-- We add true as last parameter, since this is default language.
local t = this.AceLocale:NewLocale(NAME, 'enUS', true)

if not t then
  return
end

-- Configuration
t['config_name'] = 'Collection'
t['config_description'] = 'Handful collection of points around the World (of Warcraft).'
t['config_name_waypoints_show'] = 'Show waypoints'
t['config_description_waypoints_show'] = 'Should waypoints in instances (pre-Legion raids and dungeons) be shown?'
t['config_name_collection_show'] = 'Show collection icons'
t['config_description_collection_show'] = 'Controls, whether icons for collection (mounts, pets, transmogs, achievements) should be shown.'
t['config_name_completed'] = 'Show completed'
t['config_description_completed'] = 'Show points you have already found?'
t['config_waypoint'] = 'Waypoint configuration'
t['config_tracking'] = 'Collection configuration'
t['config_scale'] = 'Scale'
t['config_description_scale'] = 'The scale of the icons.'
t['config_opacity'] = 'Opacity'
t['config_description_opacity'] = 'The alpha transparency of the icons.'
t['config_name_summary'] = 'Use summary point'
t['config_description_summary'] = 'Displays summary point on continent map with all items missing from child maps (eg. shows missing stuff from Nagrand on Draenor map).'
t['config_name_transmog_track'] = 'Track transmogs'
t['config_description_transmog_track'] = 'There is a lot of transmogs and it can overwhelm you map. This button disables it all.'
t['config_name_transmog_unobtainable'] = 'Show unobtainable transmogs'
t['config_description_transmog_unobtainable'] = 'Shows unobtainable transmogs (like plate armor on mage characters).'
t['config_name_transmog_exact_source'] = 'Track exact transmogs'
t['config_description_transmog_exact_source'] = 'Tracks exact transmogrification source (like ATT).'
t['config_name_cache'] = 'Clear cache'
t['config_description_cache'] = [[
Clear stored data from cache.

Stored data are data, that are pulled from WoW API (item name, quest name etc), so we don't have to query in-game API all the time.

Cache is automatically cleared when new World of Warcraft build is created.
]]
t['waypoint'] = '<Shift-Click> on this point to create map pin.'
t['point_tooltip'] = 'You can keep this tooltip visible while holding <Alt> button.'
t['rewards'] = 'Rewards'
t['earned'] = 'Earned'
t['quest'] = 'Quest'
t['active'] = 'Active'
t['inactive'] = 'Inactive'
t['completed'] = 'Completed'
t['incomplete'] = 'Incomplete'
t['missing'] = 'Missing'
t['collected'] = 'Collected'
t['in_progress'] = 'In progress'
t['not_eligible'] = 'not eligible'
t['fetching_data'] = 'Fetching data'
t['requirements'] = 'Requirements'
t['faction'] = 'Faction'
t['toy'] = 'Toy'
t['pet'] = 'Pet'
t['mount'] = 'Mount'
t['cloak'] = 'Cloak'
t['neck'] = 'Neck'
t['off-hand'] = 'Off-hand'
t['trinket'] = 'Trinket'
t['ring'] = 'Ring'
