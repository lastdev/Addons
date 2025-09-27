local _, addon = ...;

local infoProvider = addon.import('infoProvider');

local function nameCheck ()
  local nodes = addon.nodeData;

  for zone, zoneNodes in pairs(nodes) do
    for coords, node in pairs(zoneNodes) do
      local info = infoProvider.getNodeInfo(zone, coords);

      if (info == nil) then
        print(node.treasure, '-', node.rare);
      elseif (info.name == nil) then
        if (node.treasure ~= nil) then
          print('no name for treasure:', node.treasure);
        end

        if (node.rare ~= nil) then
          print('no name for rare:', node.rare);
        end
      end
    end
  end
end

addon.on('PLAYER_STOPPED_MOVING', function ()
  nameCheck();
end);
