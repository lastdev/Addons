local addonName, shared = ...;

local addon = shared.addon;
local rareInfo = shared.rareData;
local nodes = shared.nodeData;

--if true then return end

local function nameCheck ()
  for zone, zoneNodes in pairs(nodes) do
    for coords, node in pairs(zoneNodes) do
      local info = addon.getNodeInfo(node);

      if (info == nil) then
        print(node.treasure, '-', node.rare);
      end

      if (info and info.name == nil) then
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
