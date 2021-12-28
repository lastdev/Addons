local addonName, shared = ...;

local SETTINGS_NAME = 'HandyNotes_Pandaria_savedData';

shared.saved = {};

local function findGlobalObject (names)
  for _, name in ipairs(names) do
    if (type(_G[name]) == 'table') then
      return _G[name];
    end
  end

  return nil;
end

local function checkSettings (settings)
  local defaults = {
    icon_scale = 1,
    icon_alpha = 1,
    minimap_icons = true,
    show_rares = true,
    show_treasures = true,
    always_show_rares = false,
    show_mounts = true,
    show_toys = true,
    show_achievements = true,
    show_special_rares = true,
  };

  for param, defaultValue in pairs(defaults) do
    if (type(settings[param]) ~= type(defaultValue)) then
      settings[param] = defaultValue;
    end
  end
end

local function handleAddonLoad (event, loadedAddon)
  if (loadedAddon ~= addonName) then return end

  local saved = shared.saved;
  local readData = findGlobalObject({
    SETTINGS_NAME,
    'storedData',
  }) or {};

  if (type(readData.hiddenNodes) == 'table') then
    saved.hiddenNodes = readData.hiddenNodes;
  else
    saved.hiddenNodes = {};
  end

  if (type(readData.settings) == 'table') then
    saved.settings = readData.settings;
  else
    saved.settings = {};
  end

  checkSettings(saved.settings);

  shared.addon.off('ADDON_LOADED', handleAddonLoad);
end

local function exportSettings ()
  _G[SETTINGS_NAME] = shared.saved;
end

shared.addon.on('ADDON_LOADED', handleAddonLoad);
shared.addon.on('PLAYER_LOGOUT', exportSettings);
