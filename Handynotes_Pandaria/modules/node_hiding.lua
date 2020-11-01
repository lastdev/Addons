local addonName, shared = ...;

local addon = shared.addon;

local module = {};
local hiddenNodes;

addon.on('PLAYER_LOGIN', function ()
  if (storedData == nil) then
      storedData = {
        hiddenNodes = {},
      };
  elseif (storedData.hiddenNodes == nil) then
    storedData.hiddenNodes = {};
  end

  hiddenNodes = storedData.hiddenNodes;
end);

module.hide = function (zone, coords)
  hiddenNodes[zone] = hiddenNodes[zone] or {};
  hiddenNodes[zone][coords] = true;
end;

module.isHidden = function (zone, coords)
  return (hiddenNodes[zone] ~= nil and hiddenNodes[zone][coords] == true);
end

module.restoreZoneNodes = function (zone)
  hiddenNodes[zone] = nil;
end

module.restoreAllNodes = function (zone)
  table.wipe(hiddenNodes);
end

addon.export('nodeHider', module);
