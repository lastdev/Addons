local _, addon = ...;

local tinsert = _G.tinsert;

local GetAchievementCriteriaInfo = _G.GetAchievementCriteriaInfo;
local GetAchievementInfo = _G.GetAchievementInfo;
local GetAchievementNumCriteria = _G.GetAchievementNumCriteria;
local GetItemIcon = _G.GetItemIcon;
local GetItemInfo = _G.GetItemInfo;
local GetMountInfoByID = _G.C_MountJournal.GetMountInfoByID;
local IsItemDataCachedByID = _G.C_Item.IsItemDataCachedByID;
local IsQuestFlaggedCompleted = _G.C_QuestLog.IsQuestFlaggedCompleted;
local Item = _G.Item;
local PlayerHasToy = _G.PlayerHasToy;
local wipe = _G.wipe;

local rareData = addon.rareData;
local treasureInfo = addon.treasureData;
local nodes = addon.nodeData;
local saved = addon.saved;
local playerFaction;
local dataCache = {
  rares = {},
  treasures = {},
  nodes = {},
};

local nodeHider = addon.import('nodeHider');

local ICON_MAP = {
  question = 'Interface\\Icons\\inv_misc_questionmark',
  skullGray = 'Interface\\Addons\\HandyNotes_Pandaria\\icons\\RareIcon.tga',
  skullGreen = 'Interface\\Addons\\HandyNotes_Pandaria\\icons\\RareIconGreen.tga',
  skullBlue = 'Interface\\Addons\\HandyNotes_Pandaria\\icons\\RareIconBlue.tga',
  skullOrange = 'Interface\\Addons\\HandyNotes_Pandaria\\icons\\RareIconOrange.tga',
  skullYellow = 'Interface\\Addons\\HandyNotes_Pandaria\\icons\\RareIconYellow.tga',
  skullPurple = 'Interface\\Addons\\HandyNotes_Pandaria\\icons\\RareIconPurple.tga',
  chest = 'Interface\\Icons\\TRADE_ARCHAEOLOGY_CHESTOFTINYGLASSANIMALS',
};

local COLOR_MAP = {
  red = '|cFFFF0000',
  blue = '|cFF0000FF',
  green = '|cFF00FF00',
  yellow = '|cFFFFFF00',
};

addon.on('PLAYER_LOGIN', function ()
  playerFaction = _G.UnitFactionGroup('player');
end);

local function setTextColor (text, color)
  return color .. text .. '|r';
end

local function queryItem (itemId)
  local item = Item:CreateFromItemID(itemId);

  if (not item:IsItemEmpty()) then
    item:ContinueOnItemLoad(function ()
      addon.yell('DATA_READY', item);
    end);
  end
end

local function checkAchievement (achievementId, criteriaIndex)
  local achievementInfo = {GetAchievementInfo(achievementId)};
  local text = achievementInfo[2];
  local completed = achievementInfo[4];
  -- local completedOnThisCharacter = achievementInfo[13];
  local icon = achievementInfo[10];

  if (completed) then
    text = setTextColor(text, COLOR_MAP.green);
  else
    text = setTextColor(text, COLOR_MAP.red);
  end

  -- some achievements and their indices are set statically, so we make
  -- sure the criteria exists
  if (criteriaIndex > 0 and
      criteriaIndex <= GetAchievementNumCriteria(achievementId)) then
    local criteriaInfo = {GetAchievementCriteriaInfo(achievementId, criteriaIndex)};
    local criteria = criteriaInfo[1];
    local fulfilled = criteriaInfo[3];

    if (fulfilled) then
      completed = true;
      criteria = setTextColor(criteria, COLOR_MAP.green);
    else
      criteria = setTextColor(criteria, COLOR_MAP.red);
    end

    text = text .. ' - ' .. criteria;
  end

  return {
    completed = completed,
    text = text,
    icon = icon,
  };
end

local function getAchievementInfo (rareData)
  local achievementList = rareData.achievements;
  local criteriaList = rareData.criteria;

  if (achievementList == nil) then return nil end

  local list = {};
  local totalCompleted = true;
  local totalIcon;

  local function handleAchievement (achievement, criteria, index)
    local info = checkAchievement(achievement, criteria);

    if (info.completed == false) then
      totalCompleted = false;
      totalIcon = totalIcon or info.icon;
    end

    list[index] = info;
  end

  if (type(achievementList) == 'table') then
    for index, achievement in ipairs(achievementList) do
      handleAchievement(achievement, criteriaList[index], index);
    end
  else
    handleAchievement(achievementList, criteriaList, 1);
  end

  return {
    completed = totalCompleted,
    icon = totalIcon,
    list = list,
  };
end

local function checkToy (toy)
  local collected = PlayerHasToy(toy);
  local toyName;
  local icon;
  local queried;

  -- data is not cached yet
  if (IsItemDataCachedByID(toy)) then
    local toyInfo = {GetItemInfo(toy)};

    toyName = toyInfo[1];
    icon = toyInfo[10] or ICON_MAP.skullGreen;
  else
    toyName = 'waiting for data...';
    icon = GetItemIcon(toy) or ICON_MAP.skullGreen;
    queried = toy;
    queryItem(toy);
  end

  if (collected) then
    toyName = setTextColor(toyName, COLOR_MAP.green);
  else
    toyName = setTextColor(toyName, COLOR_MAP.red);
  end

  return {
    text = toyName,
    name = toyName,
    icon = icon,
    collected = collected,
    queried = queried,
  };
end

local function getToyInfo (rareData)
  local toyList = rareData.toys;

  if (toyList == nil) then return nil end

  local list = {};
  local totalCollected = true;
  local totalIcon;

  local function handleToy (toy, index)
    local info = checkToy(toy);

    if (info.collected == false) then
      totalCollected = false;
      totalIcon = totalIcon or info.icon;
    end

    list[index] = info;
  end

  if (type(toyList) == 'table') then
    for index, toy in ipairs(toyList) do
      handleToy(toy, index);
    end
  else
    handleToy(toyList, 1);
  end

  return {
    collected = totalCollected,
    icon = totalIcon,
    list = list,
  };
end

local function checkMount (mountId)
  local mountInfo = {GetMountInfoByID(mountId)};
  local mountName = mountInfo[1];
  local icon = mountInfo[3] or ICON_MAP.skullOrange;
  local collected = mountInfo[11];

  if (collected) then
    mountName = setTextColor(mountName, COLOR_MAP.green);
  else
    mountName = setTextColor(mountName, COLOR_MAP.red);
  end

  return {
    collected = collected,
    icon = icon,
    text = mountName,
  };
end

local function getMountInfo (rareData)
  local mountList = rareData.mounts;

  if (mountList == nil) then return nil end

  local list = {};
  local totalCollected = true;
  local totalIcon;

  local function handleMount (mount, index)
    local info = checkMount(mount);

    if (info.collected == false) then
      totalCollected = false;
      totalIcon = totalIcon or info.icon;
    end

    list[index] = info;
  end

  if (type(mountList) == "table") then
    for index, mountId in ipairs(mountList) do
      handleMount(mountId, index);
    end
  else
    handleMount(mountList, 1);
  end

  return {
    collected = totalCollected,
    icon = totalIcon,
    list = list,
  };
end

local function interpreteRareInfo (nodeInfo)
  local settings = saved.settings;

  nodeInfo.icon = nodeInfo.icon or ICON_MAP.question;
  nodeInfo.display = false;

  if (settings.show_rares == false or nodeInfo.questCompleted == true) then
    return;
  end

  local mountInfo = nodeInfo.mountInfo;

  if (settings.show_mounts == true and mountInfo ~= nil and mountInfo.collected == false) then
    nodeInfo.icon = mountInfo.icon or ICON_MAP.skullPurple;
    nodeInfo.display = true;
    return;
  end

  local toyInfo = nodeInfo.toyInfo;

  if (settings.show_toys == true and toyInfo ~= nil and toyInfo.collected == false) then
    nodeInfo.icon = toyInfo.icon or ICON_MAP.skullGreen;
    nodeInfo.display = true;
    return;
  end

  local achievementInfo = nodeInfo.achievementInfo;

  if (settings.show_achievements == true and achievementInfo ~= nil and achievementInfo.completed == false) then
    -- nodeInfo.icon = achievementInfo.icon;
    nodeInfo.icon = ICON_MAP.skullYellow;
    nodeInfo.display = true;
    return;
  end

  if (settings.show_special_rares == true and nodeInfo.special == true) then
    nodeInfo.icon = ICON_MAP.skullBlue;
    nodeInfo.display = true;
    return;
  end

  if (settings.always_show_rares == true) then
    nodeInfo.icon = ICON_MAP.skullGray;
    nodeInfo.display = true;
    return;
  end
end

local function readRareInfo (rareId)
  if (rareId == nil) then return nil end

  local rareCache = dataCache.rares;

  if (rareCache[rareId] ~= nil) then
    return rareCache[rareId];
  end

  local rareInfo = rareData[rareId];

  if (rareInfo == nil) then
    return nil;
  end

  if (rareInfo.faction and rareInfo.faction ~= playerFaction) then
    return nil;
  end

  rareInfo.achievementInfo = getAchievementInfo(rareInfo);
  rareInfo.toyInfo = getToyInfo(rareInfo);
  rareInfo.mountInfo = getMountInfo(rareInfo);
  rareInfo.mountInfo = getMountInfo(rareInfo);
  rareInfo.questCompleted = rareInfo.quest and IsQuestFlaggedCompleted(rareInfo.quest);

  rareCache[rareId] = rareInfo;
  return rareInfo;
end

local function getRareInfo (rareId)
  local info = readRareInfo(rareId);

  if (info ~= nil) then
    interpreteRareInfo(info);
  end

  return info;
end

local function interpreteTreasureInfo (nodeInfo)
  local settings = saved.settings;

  nodeInfo.icon = nodeInfo.icon or ICON_MAP.chest;
  nodeInfo.display = true;

  if (settings.show_treasures == false or nodeInfo.collected == true) then
    nodeInfo.display = false;
    return;
  end

  local achievementInfo = nodeInfo.achievementInfo;

  if (settings.show_achievements == true and achievementInfo ~= nil and achievementInfo.completed == false) then
    return;
  end

  if (nodeInfo.autoHide == true) then
    nodeInfo.display = false;
    return;
  end
end

local function readTreasureInfo (treasureId)
  local treasureData = treasureInfo[treasureId];

  if (treasureData == nil) then
    -- print('no information about treasure:', treasureId);
    return nil;
  end

  local treasureCache = dataCache.treasures;

  if (treasureCache[treasureId] ~= nil) then
    return treasureCache[treasureId];
  end

  if (treasureData.faction and treasureData.faction ~= playerFaction) then
    return nil;
  end

  treasureData.achievementInfo = getAchievementInfo(treasureData);
  treasureData.collected = treasureData.quest and IsQuestFlaggedCompleted(treasureData.quest);
  treasureCache[treasureId] = treasureData;

  return treasureData;
end

local function getTreasureInfo (treasureId)
  local info = readTreasureInfo(treasureId);

  if (info ~= nil) then
    interpreteTreasureInfo(info);
  end

  return info;
end

local function getNodeInfo (zone, coords)
  if (nodeHider.isHidden(zone, coords)) then
    return {
      display = false,
    };
  end

  local nodeCache = dataCache.nodes;

  if (nodeCache[zone] ~= nil and nodeCache[zone][coords] ~= nil) then
    return nodeCache[zone][coords];
  end

  local nodeData = nodes[zone] and nodes[zone][coords];

  if (nodeData == nil) then return nil end

  local nodes = {};

  if (nodeData.rare ~= nil) then
    if (type(nodeData.rare) == 'table') then
      for _, rareId in ipairs(nodeData.rare) do
        tinsert(nodes, getRareInfo(rareId));
      end
    else
      tinsert(nodes, getRareInfo(nodeData.rare));
    end
  end

  if (nodeData.treasure ~= nil) then
    if (type(nodeData.treasure) == 'table') then
      for _, rareId in ipairs(nodeData.treasure) do
        tinsert(nodes, getTreasureInfo(rareId));
      end
    else
      tinsert(nodes, getTreasureInfo(nodeData.treasure));
    end
  end

  if (#nodes == 0) then
    return nil;
  end

  nodeCache[zone] = nodeCache[zone] or {};
  nodeCache[zone][coords] = nodes;

  return nodes;
end

local function flush ()
  wipe(dataCache.rares);
  wipe(dataCache.treasures);
  wipe(dataCache.nodes);
end

addon.export('infoProvider', {
  getNodeInfo = getNodeInfo,
  flush = flush,
});
