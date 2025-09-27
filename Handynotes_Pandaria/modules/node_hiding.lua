local addonName, addon = ...;

local wipe = _G.wipe;

local saved = addon.saved;

local module = {};

module.hide = function (zone, coords)
  saved.hiddenNodes[zone] = saved.hiddenNodes[zone] or {};
  saved.hiddenNodes[zone][coords] = true;
end;

module.isHidden = function (zone, coords)
  return (saved.hiddenNodes[zone] ~= nil and
      saved.hiddenNodes[zone][coords] == true);
end

module.restoreZoneNodes = function (zone)
  saved.hiddenNodes[zone] = nil;
end

module.restoreAllNodes = function (zone)
  wipe(saved.hiddenNodes);
end

addon.export('nodeHider', module);
