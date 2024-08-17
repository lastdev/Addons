local addonName, addon = ...;

local CloseDropDownMenus = _G.CloseDropDownMenus;
local GameTooltip = _G.GameTooltip;
local IsAddOnLoaded = _G.C_AddOns.IsAddOnLoaded;
local ToggleDropDownMenu = _G.ToggleDropDownMenu;
local TomTom = _G.TomTom;
local UIDropDownMenu_AddButton = _G.UIDropDownMenu_AddButton;
local UIParent = _G.UIParent;
local WorldMapButton = _G.WorldMapButton;
local WorldMapTooltip = _G.WorldMapTooltip;

local HandyNotes = addon.HandyNotes;
local nodes = addon.nodeData;
local saved = addon.saved;
local handler = {};
local tooltip;
local currentInfo;

local infoProvider = addon.import('infoProvider');
local nodeHider = addon.import('nodeHider');

local function iterateZoneNodes (zone, nodes)
  for coords, _ in pairs(nodes) do
    local nodeList = infoProvider.getNodeInfo(zone, coords);

    if (nodeList ~= nil) then
      for _, node in ipairs(nodeList) do
        if (node.display == true) then
          coroutine.yield(coords, zone, node.icon, saved.settings.icon_scale, saved.settings.icon_alpha);
        end
      end
    else
      nodes[coords] = nil;
    end
  end
end

local function iterateZones (zones)
  for _, zone in ipairs(zones) do
    local zoneNodes = nodes[zone];

    if (zoneNodes) then
      iterateZoneNodes(zone, zoneNodes);
    end
  end
end

local function returnNil ()
  return nil;
end

function handler:GetNodes2(uiMapId, isMinimap)
  if (isMinimap == true and saved.settings.minimap_icons ~= true) then
    return returnNil;
  end

  -- local zones = HandyNotes:GetContinentZoneList(uiMapId); -- Is this a continent?
  local zones;

  if not zones then
    zones = {uiMapId};
  end

  infoProvider.flush();

  return coroutine.wrap(function ()
    iterateZones(zones);
  end);
end

local function addTooltipText (tooltip, info, header)
  if (info == nil or info.completed == true or info.collected == true) then return end

  local list = info.list;

  for x = 1, #list, 1 do
    if (list[x].collected == false or list[x].completed == false) then
      tooltip:AddDoubleLine(header, list[x].text);
      header = ' ';
    end
  end
end

local function displayNode (nodeInfo)
  tooltip:AddLine(nodeInfo.name or nodeInfo.rare or nodeInfo.treasure);
  -- tooltip:SetText(nodeData.name .. ' ' .. (node.rare or node.treasure));

  if (nodeInfo.description ~= nil) then
    tooltip:AddLine(nodeInfo.description);
  end

  addTooltipText(tooltip, nodeInfo.mountInfo, 'Mounts:');
  addTooltipText(tooltip, nodeInfo.toyInfo, 'Toys:');
  addTooltipText(tooltip, nodeInfo.achievementInfo, 'Achievements:');
end

local function displayTooltip (nodeList)
  tooltip:ClearLines();

  for x = 1, #nodeList, 1 do
    displayNode(nodeList[x]);

    if (x < #nodeList) then
      tooltip:AddLine(' ');
    end
  end

  tooltip:Show();
end

function handler:OnEnter(uiMapId, coords)
  local nodeList = infoProvider.getNodeInfo(uiMapId, coords);

  if (nodeList == nil) then return end

  currentInfo = nodeList;

  tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip;

  if (self:GetCenter() > UIParent:GetCenter()) then
    tooltip:SetOwner(self, "ANCHOR_LEFT");
  else
    tooltip:SetOwner(self, "ANCHOR_RIGHT");
  end

  displayTooltip(nodeList);
end

function handler:OnLeave(uiMapId, coords)
  currentInfo = nil;
  tooltip:Hide();
end

local function getNestedValue (object, ...)
  for x = 1, select('#', ...), 1 do
    if (object == nil) then
      return nil;
    end
    object = object[select(x, ...)];
  end

  return object;
end

local function checkIfNodeQueriedToy (node, item)
  local toyList = getNestedValue(node, 'toyInfo', 'list');

  if (toyList ~= nil) then
    local itemId = item:GetItemID();

    for _, toy in ipairs(toyList) do
      if (toy.queried == itemId) then
        toy.name = item:GetItemName();
        toy.text = toy.name;
        toy.icon = item:GetItemIcon() or toy.icon;
        toy.queried = nil;
        displayTooltip(currentInfo);
        return;
      end
    end
  end
end

addon.listen('DATA_READY', function (item)
  if (currentInfo ~= nil) then
    for _, node in ipairs(currentInfo) do
      checkIfNodeQueriedToy(node, item);
    end
  end
end);

local function updateNodes ()
  HandyNotes:SendMessage('HandyNotes_NotifyUpdate', addonName);
end

-- node menu handling
do
  local function CloseDropDown (button, level)
    CloseDropDownMenus(level);
  end

  local function addTomTomWaypoint(button, mapId, coords)
    if TomTom then
      local x, y = HandyNotes:getXY(coords);
      local info = infoProvider.getNodeInfo(mapId, coords)[1];

      TomTom:AddWaypoint(mapId, x, y, {
        title = info.name;
        persistent = nil,
        minimap = saved.settings.minimap_icons,
        world = true,
        from = addonName,
      });
    end
  end

  local dropdown = _G.CreateFrame('Frame', 'HandyNotes_Pandaria_DropdownMenu');
  local clickedMapId;
  local clickedCoord;

  dropdown.displayMode = "MENU";
  dropdown.initialize = function (button, level)
    if (not level) then return end

    if (level == 1) then
      UIDropDownMenu_AddButton({
        text = 'HandyNotes Pandaria',
        isTitle = true,
        notCheckable = true,
        notClickable = true,
      }, level);

      if (IsAddOnLoaded('TomTom')) then
        UIDropDownMenu_AddButton({
          text = 'Add TomTom waypoint',
          notCheckable = true,
          func = addTomTomWaypoint,
          arg1 = clickedMapId,
          arg2 = clickedCoord,
        }, level);
      end

      UIDropDownMenu_AddButton({
        text = 'Hide this node',
        notCheckable = true,
        arg1 = clickedMapId,
        arg2 = clickedCoord,
        func = function (button, zone, coords)
          nodeHider.hide(zone, coords);
          updateNodes();
        end,
      }, level);

      UIDropDownMenu_AddButton({
        text = 'Restore hidden nodes in this zone',
        notCheckable = true,
        func = function (button, zone, coords)
          nodeHider.restoreZoneNodes(zone);
          updateNodes();
        end,
        arg1 = clickedMapId,
        arg2 = clickedCoord,
      }, level);

      UIDropDownMenu_AddButton({
        text = 'Close',
        func = CloseDropDown,
        notCheckable = true,
        arg1 = level,
      }, level);
    end
  end;

  function handler:OnClick (button, down, mapID, coord)
    if (button == 'RightButton' and not down) then
      clickedMapId = mapID;
      clickedCoord = coord;
      ToggleDropDownMenu(1, nil, dropdown, self, 0, 0);
    end
  end
end

local function registerWithHandyNotes ()
  local settings = saved.settings;
  local options = {
    type = "group",
    name = 'Pandaria',
    desc = 'Rares and treasures in Pandaria',
    get = function (info) return settings[info.arg] end,
    set = function (info, v)
      settings[info.arg] = v;
      updateNodes();
    end,
    args = {
      icon_settings = {
        type = "group",
        name = "Icon settings",
        inline = true,
        args = {
          icon_scale = {
            order = 1,
            type = 'range',
            name = 'Icon Scale',
            desc = 'The scale of the icons',
            min = 0.5, max = 3, step = 0.1,
            arg = 'icon_scale',
            width = 'normal',
          },
          icon_alpha = {
            order = 2,
            type = 'range',
            name = 'Icon Alpha',
            desc = 'The alpha transparency of the icons',
            min = 0, max = 1, step = 0.01,
            arg = 'icon_alpha',
            width = 'normal',
          },
          minimap_icons = {
            order = 3,
            type = 'toggle',
            name = 'Show icons on the minimap',
            desc = 'Show icons on the minimap',
            arg = 'minimap_icons',
            width = 'full',
          },
          show_rares = {
            order = 4,
            type = 'toggle',
            name = 'Show rares',
            desc = 'Show nodes of rare mobs',
            arg = 'show_rares',
            width = 'full',
          },
          show_treasures = {
            order = 5,
            type = 'toggle',
            name = 'Show treasures',
            desc = 'Show nodes of treasures',
            arg = 'show_treasures',
            width = 'full',
          },
        }
      },
      visibility_settings = {
        type = "group",
        name = "Show rares when they:",
        inline = true,
        args = {
          always_show_rares = {
            order = 1,
            type = 'toggle',
            name = 'exist (always)',
            desc = 'exist (always)',
            arg = 'always_show_rares',
            width = 'full',
          },
          show_mounts = {
            order = 2,
            type = 'toggle',
            name = 'drop an uncollected mount',
            desc = 'drop an uncollected mount',
            arg = 'show_mounts',
            width = 'full',
          },
          show_toys = {
            order = 3,
            type = 'toggle',
            name = 'drop an uncollected toy',
            desc = 'drop an uncollected toy',
            arg = 'show_toys',
            width = 'full',
          },
          show_achievements = {
            order = 4,
            type = 'toggle',
            name = 'are required for an achievement',
            desc = 'are required for an achievement',
            arg = 'show_achievements',
            width = 'full',
          },
          show_special_rares = {
            order = 5,
            type = 'toggle',
            name = 'drop a useful item',
            desc = 'drop a useful item',
            arg = 'show_special_rares',
            width = 'full',
          },
          reset_nodes = {
            order = 6,
            type = 'execute',
            name = 'Restore hidden nodes',
            desc = 'Shows manually hidden nodes again',
            func = function()
              nodeHider.restoreAllNodes();
              updateNodes();
            end,
            width = 'normal',
          },
        }
      }
    },
  };

  HandyNotes:RegisterPluginDB(addonName, handler, options);
  updateNodes();
end

function addon.integrateWithHandyNotes ()
  registerWithHandyNotes();
  addon.funnel({'CRITERIA_UPDATE'}, updateNodes);
  addon.on({'NEW_TOY_ADDED', 'NEW_MOUNT_ADDED'}, updateNodes);
end
