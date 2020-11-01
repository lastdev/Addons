local addonName, shared = ...;

local addon = shared.addon;

addon.on('PLAYER_LOGIN', function ()
  convertedData = nil;
end);
