local addonName, shared = ...;

local wipe = _G.wipe;

local saved = shared.saved;

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

shared.addon.export('nodeHider', module);
