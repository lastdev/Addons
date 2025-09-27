local addonName, addon = ...
local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")
local LibStub = addon.LibStub

_G[addonName] = {}
addon.API = {}
local api = addon.API
_G[addonName].API = api
_G[addonName].GUI = addon.GUI

addon.hooks = {}
addon.hooks.singleBlockCompletionCheck = {}
addon.hooks.missionsFilter = {}

-- Suggested .toc format:
-- ## LoadOnDemand: 1
-- ## LoadWith: TLDRMissions

-- Fires after all other internal block checks have been processed
--
-- Your inner function:
-- Parameter: missionID {number}
-- Returns: true if you want this mission set to blocked
-- 
-- EXAMPLE USAGE:
-- TLDRMissions.API:HookSingleBlockCompletionCheck(function(missionID)
--   if missionID == 2224 then
--      return true
--   end
-- end)
function api:HookSingleBlockCompletionCheck(func)
    table.insert(addon.hooks.singleBlockCompletionCheck, func)
end

-- Fires after all other internal filters have been processed
-- Passes in the missions still remaining, for you to filter down further
-- You must modify the table passed in or changes will not be preserved
--
-- Your inner function:
-- Parameter: missions {table}
-- Returns: nil
--
-- EXAMPLE USAGE:
-- TLDRMissions.API:HookMissionsFilter(function(missions)
--   for i, mission in pairs(missions) do
--     if mission.missionID == 2224 then
--       table.remove(missions, i)
--       break
--     end
--   end
-- end)
--
-- Remember to be careful of removing elements from a table while looping over it
-- Use a workaround such as starting your loop over again after removing an element
-- Or copy the table, wipe the parameter, then insert the ones you want to keep back into the parameter
function api:HookMissionsFilter(func)
    table.insert(addon.hooks.missionsFilter, func)
end
