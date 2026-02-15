-------------------------------------------------------------------------------
-- SmartBuff cache load/save/sync helpers
-- Load order: after SmartBuff.globals.lua, before SmartBuff.buffs.lua and SmartBuff.lua
-------------------------------------------------------------------------------

local SG = SMARTBUFF_GLOBALS;

-- Safe default structures (single source of truth for wipe-and-init)
local function defaultBuffListCache()
  return {
    version = nil,
    lastUpdate = 0,
    expectedCounts = { SCROLL = 0, FOOD = 0, POTION = 0, SELF = 0, GROUP = 0, ITEM = 0, TOTAL = 0 },
    enabledBuffs = {}
  };
end
local function defaultToyCache()
  return { version = nil, lastUpdate = 0, toyCount = 0, toybox = {} };
end
local function defaultItemSpellCache()
  return { version = nil, lastUpdate = 0, items = {}, spells = {}, itemIDs = {}, itemData = {}, needsRefresh = {} };
end
local function defaultBuffRelationsCache()
  return { version = nil, lastUpdate = 0, chains = {}, links = {} };
end
local function defaultValidSpells()
  return { version = nil, lastUpdate = 0, spells = {} };
end

-- Ensure cache exists (create if nil). Call before use when cache might not exist.
function SMARTBUFF_InitBuffListCache()
  if (not SmartBuffBuffListCache) then SmartBuffBuffListCache = defaultBuffListCache(); end
end
function SMARTBUFF_InitToyCache()
  if (not SmartBuffToyCache) then SmartBuffToyCache = defaultToyCache(); end
end
function SMARTBUFF_InitItemSpellCache()
  if (not SmartBuffItemSpellCache) then SmartBuffItemSpellCache = defaultItemSpellCache(); end
  if (not SmartBuffItemSpellCache.itemData) then SmartBuffItemSpellCache.itemData = {}; end
  if (not SmartBuffItemSpellCache.needsRefresh) then SmartBuffItemSpellCache.needsRefresh = {}; end
end
function SMARTBUFF_InitBuffRelationsCache()
  if (not SmartBuffBuffRelationsCache) then SmartBuffBuffRelationsCache = defaultBuffRelationsCache(); end
end
function SMARTBUFF_InitValidSpells()
  if (not SmartBuffValidSpells) then SmartBuffValidSpells = defaultValidSpells(); end
end

-- Wipe and re-init to safe default (for version change or reset). Replaces global with fresh table.
function SMARTBUFF_WipeAndInitBuffListCache()
  SmartBuffBuffListCache = defaultBuffListCache();
end
function SMARTBUFF_WipeAndInitToyCache()
  SmartBuffToyCache = defaultToyCache();
end
function SMARTBUFF_WipeAndInitItemSpellCache()
  SmartBuffItemSpellCache = defaultItemSpellCache();
end
function SMARTBUFF_WipeAndInitBuffRelationsCache()
  SmartBuffBuffRelationsCache = defaultBuffRelationsCache();
end
function SMARTBUFF_WipeAndInitValidSpells()
  SmartBuffValidSpells = defaultValidSpells();
end

-- Load cache from SavedVariables (init structures, invalidate on version change or wrong structure)
-- Wrong structure (e.g. pre-cache upgrade) triggers WipeAndInit so we don't keep broken data.
function SMARTBUFF_LoadCache()
  SMARTBUFF_InitBuffListCache();
  if (SmartBuffBuffListCache.version and SmartBuffBuffListCache.version ~= SMARTBUFF_VERSION) then
    SMARTBUFF_WipeAndInitBuffListCache();
  elseif (type(SmartBuffBuffListCache.expectedCounts) ~= "table" or SmartBuffBuffListCache.expectedCounts.TOTAL == nil) then
    SMARTBUFF_WipeAndInitBuffListCache();
  end

  SMARTBUFF_InitToyCache();
  if (SmartBuffToyCache.version and SmartBuffToyCache.version ~= SMARTBUFF_VERSION) then
    SMARTBUFF_WipeAndInitToyCache();
  elseif (type(SmartBuffToyCache.toybox) ~= "table") then
    SMARTBUFF_WipeAndInitToyCache();
  end

  SMARTBUFF_InitItemSpellCache();
  if (SmartBuffItemSpellCache.version and SmartBuffItemSpellCache.version ~= SMARTBUFF_VERSION) then
    SMARTBUFF_WipeAndInitItemSpellCache();
  elseif (type(SmartBuffItemSpellCache.items) ~= "table" or type(SmartBuffItemSpellCache.spells) ~= "table") then
    SMARTBUFF_WipeAndInitItemSpellCache();
  end

  SMARTBUFF_InitBuffRelationsCache();
  if (SmartBuffBuffRelationsCache.version and SmartBuffBuffRelationsCache.version ~= SMARTBUFF_VERSION) then
    SMARTBUFF_WipeAndInitBuffRelationsCache();
  elseif (type(SmartBuffBuffRelationsCache.chains) ~= "table" or type(SmartBuffBuffRelationsCache.links) ~= "table") then
    SMARTBUFF_WipeAndInitBuffRelationsCache();
  end

  SMARTBUFF_InitValidSpells();
  if (SmartBuffValidSpells.version and SmartBuffValidSpells.version ~= SMARTBUFF_VERSION) then
    SMARTBUFF_WipeAndInitValidSpells();
  elseif (type(SmartBuffValidSpells.spells) ~= "table") then
    SMARTBUFF_WipeAndInitValidSpells();
  end

  return SmartBuffBuffListCache;
end

-- Clear ValidSpells cache and ensure .spells is a table so the next buff list build re-validates.
-- Used on version change (LoadCache), spell-change events, login/reload (PLAYER_ENTERING_WORLD), and Reset Buffs.
function SMARTBUFF_ClearValidSpells()
  SMARTBUFF_InitValidSpells();
  SmartBuffValidSpells.version = nil;
  SmartBuffValidSpells.lastUpdate = 0;
  if (SmartBuffValidSpells.spells) then
    wipe(SmartBuffValidSpells.spells);
  end
  SmartBuffValidSpells.spells = SmartBuffValidSpells.spells or {};
end

-- Sync item/spell cache with expected list from buffs.lua (remove extras, add missing, flag needsRefresh)
function SMARTBUFF_SyncItemSpellCache()
  SMARTBUFF_InitItemSpellCache();
  if (not SmartBuffItemSpellCache.items) then SmartBuffItemSpellCache.items = {}; end
  if (not SmartBuffItemSpellCache.spells) then SmartBuffItemSpellCache.spells = {}; end
  if (not SmartBuffItemSpellCache.itemIDs) then SmartBuffItemSpellCache.itemIDs = {}; end

  local cache = SmartBuffItemSpellCache;
  local expected = SMARTBUFF_ExpectedData;

  if (not expected or not expected.items or not expected.spells) then
    return;
  end

  for varName, _ in pairs(cache.items) do
    if (not expected.items[varName]) then
      cache.items[varName] = nil;
      cache.itemIDs[varName] = nil;
      cache.itemData[varName] = nil;
      cache.needsRefresh[varName] = nil;
    end
  end

  for varName, _ in pairs(cache.spells) do
    if (not expected.spells[varName]) then
      cache.spells[varName] = nil;
      cache.needsRefresh[varName] = nil;
    end
  end

  for varName, itemId in pairs(expected.items) do
    if (not cache.items[varName]) then
      cache.items[varName] = nil;
      cache.itemIDs[varName] = itemId;
      cache.itemData[varName] = nil;
      cache.needsRefresh[varName] = true;
    else
      cache.needsRefresh[varName] = true;
    end
  end

  for varName, spellId in pairs(expected.spells) do
    if (not cache.spells[varName]) then
      cache.spells[varName] = nil;
      cache.needsRefresh[varName] = true;
    else
      cache.needsRefresh[varName] = true;
    end
  end

  cache.version = SMARTBUFF_VERSION;
  cache.lastUpdate = GetTime();
end

-- Load buff relationships (chains and links) from cache
function SMARTBUFF_LoadBuffRelationsCache()
  local cache = SmartBuffBuffRelationsCache;
  if (not cache or not cache.version or cache.version ~= SMARTBUFF_VERSION) then
    return;
  end

  if (cache.chains and SG) then
    for key, value in pairs(cache.chains) do
      if (type(value) == "table") then
        SG[key] = value;
      end
    end
  end

  if (cache.links and SG) then
    for key, value in pairs(cache.links) do
      if (type(value) == "table") then
        SG[key] = value;
      end
    end
  end
end

-- Save buff relationships (chains and links) to cache
function SMARTBUFF_SaveBuffRelationsCache()
  SMARTBUFF_InitBuffRelationsCache();

  local cache = SmartBuffBuffRelationsCache;
  cache.version = SMARTBUFF_VERSION;
  cache.lastUpdate = GetTime();

  wipe(cache.chains);
  if (SG) then
    for key, value in pairs(SG) do
      if (type(key) == "string" and string.match(key, "^Chain") and type(value) == "table") then
        cache.chains[key] = value;
      end
    end
  end

  wipe(cache.links);
  if (SG) then
    for key, value in pairs(SG) do
      if (type(key) == "string" and string.match(key, "^Link") and type(value) == "table") then
        cache.links[key] = value;
      end
    end
  end
end

-- Save cache to SavedVariables (buff list counts, enabled snapshot, toy count)
function SMARTBUFF_SaveCache(counts, enabledBuffsSnapshot, toyCount)
  local cache = SmartBuffBuffListCache;
  if (not cache) then
    SMARTBUFF_LoadCache();
    cache = SmartBuffBuffListCache;
  end

  cache.version = SMARTBUFF_VERSION;
  cache.lastUpdate = GetTime();

  if (counts) then
    cache.expectedCounts.SCROLL = counts.SCROLL or 0;
    cache.expectedCounts.FOOD = counts.FOOD or 0;
    cache.expectedCounts.POTION = counts.POTION or 0;
    cache.expectedCounts.SELF = counts.SELF or 0;
    cache.expectedCounts.GROUP = counts.GROUP or 0;
    cache.expectedCounts.ITEM = counts.ITEM or 0;
    cache.expectedCounts.TOTAL = counts.TOTAL or 0;
  end

  if (enabledBuffsSnapshot) then
    wipe(cache.enabledBuffs);
    for _, buffName in ipairs(enabledBuffsSnapshot) do
      table.insert(cache.enabledBuffs, buffName);
    end
  end

  if (toyCount ~= nil) then
    SMARTBUFF_InitToyCache();
    SmartBuffToyCache.toyCount = toyCount;
    SmartBuffToyCache.version = SMARTBUFF_VERSION;
    SmartBuffToyCache.lastUpdate = GetTime();

    if (SG and SG.ToyboxByID) then
      wipe(SmartBuffToyCache.toybox);
      for id, toyData in pairs(SG.ToyboxByID) do
        if (toyData and toyData[2]) then
          SmartBuffToyCache.toybox[id] = toyData[2];
        end
      end
    end
  end
end

-- Print cache statistics (cBuffs optional: pass from SmartBuff.lua for "Current Buff List" line)
function SMARTBUFF_PrintCacheStats(cBuffs)
  local addMsg = SMARTBUFF_AddMsg;
  if (not addMsg) then return; end

  addMsg("=== SmartBuff Cache Statistics ===", true);

  local buffCache = SmartBuffBuffListCache;
  if (buffCache) then
    addMsg("BuffListCache: version=" .. tostring(buffCache.version) .. ", lastUpdate=" .. tostring(buffCache.lastUpdate), true);
    if (buffCache.expectedCounts) then
      addMsg("  Expected: SCROLL=" .. buffCache.expectedCounts.SCROLL .. ", FOOD=" .. buffCache.expectedCounts.FOOD .. ", POTION=" .. buffCache.expectedCounts.POTION .. ", SELF=" .. buffCache.expectedCounts.SELF .. ", GROUP=" .. buffCache.expectedCounts.GROUP .. ", ITEM=" .. buffCache.expectedCounts.ITEM .. ", TOTAL=" .. buffCache.expectedCounts.TOTAL, true);
    end
  else
    addMsg("BuffListCache: not initialized", true);
  end

  local toyCache = SmartBuffToyCache;
  if (toyCache) then
    addMsg("ToyCache: version=" .. tostring(toyCache.version) .. ", lastUpdate=" .. tostring(toyCache.lastUpdate), true);
    addMsg("  ToyCount: " .. tostring(toyCache.toyCount), true);
    local toyCacheCount = 0;
    if (toyCache.toybox) then for _ in pairs(toyCache.toybox) do toyCacheCount = toyCacheCount + 1; end end
    addMsg("  Toys in cache: " .. toyCacheCount, true);
  else
    addMsg("ToyCache: not initialized", true);
  end

  local itemSpellCache = SmartBuffItemSpellCache;
  if (itemSpellCache) then
    addMsg("ItemSpellCache: version=" .. tostring(itemSpellCache.version) .. ", lastUpdate=" .. tostring(itemSpellCache.lastUpdate), true);
    local itemCount, spellCount, needsRefreshCount = 0, 0, 0;
    if (itemSpellCache.items) then for _ in pairs(itemSpellCache.items) do itemCount = itemCount + 1; end end
    if (itemSpellCache.spells) then for _ in pairs(itemSpellCache.spells) do spellCount = spellCount + 1; end end
    if (itemSpellCache.needsRefresh) then
      for _, needsRefresh in pairs(itemSpellCache.needsRefresh) do if (needsRefresh) then needsRefreshCount = needsRefreshCount + 1; end end
    end
    addMsg("  Items: " .. itemCount .. ", Spells: " .. spellCount .. ", NeedsRefresh: " .. needsRefreshCount, true);
    local nilItems, nilSpells = 0, 0;
    if (itemSpellCache.items) then for _, itemLink in pairs(itemSpellCache.items) do if (not itemLink) then nilItems = nilItems + 1; end end end
    if (itemSpellCache.spells) then for _, spellInfo in pairs(itemSpellCache.spells) do if (not spellInfo) then nilSpells = nilSpells + 1; end end end
    if (nilItems > 0 or nilSpells > 0) then addMsg("  WARNING: Nil entries - Items: " .. nilItems .. ", Spells: " .. nilSpells, true); end
  else
    addMsg("ItemSpellCache: not initialized", true);
  end

  local validSpells = SmartBuffValidSpells;
  if (validSpells) then
    local validCount, invalidCount = 0, 0;
    if (validSpells.spells) then
      for _, isValid in pairs(validSpells.spells) do
        if (isValid == true) then validCount = validCount + 1; elseif (isValid == false) then invalidCount = invalidCount + 1; end
      end
    end
    addMsg("ValidSpells: version=" .. tostring(validSpells.version) .. ", Valid: " .. validCount .. ", Invalid: " .. invalidCount, true);
  else
    addMsg("ValidSpells: not initialized", true);
  end

  local expected = SMARTBUFF_ExpectedData;
  if (expected) then
    local expectedItems, expectedSpells = 0, 0;
    if (expected.items) then for _ in pairs(expected.items) do expectedItems = expectedItems + 1; end end
    if (expected.spells) then for _ in pairs(expected.spells) do expectedSpells = expectedSpells + 1; end end
    addMsg("ExpectedData: Items: " .. expectedItems .. ", Spells: " .. expectedSpells, true);
  end

  if (cBuffs) then
    local currentCount = 0;
    for i, _ in pairs(cBuffs) do
      if (type(i) == "number" and cBuffs[i] and cBuffs[i].BuffS) then currentCount = currentCount + 1; end
    end
    addMsg("Current Buff List: " .. currentCount .. " buffs", true);
  end

  addMsg("=== End Cache Statistics ===", true);
end

-- Invalidate all buff-related caches (wipe and re-init to safe defaults so next load repopulates)
function SMARTBUFF_InvalidateBuffCache()
  SMARTBUFF_WipeAndInitBuffListCache();
  SMARTBUFF_WipeAndInitToyCache();
  SMARTBUFF_WipeAndInitItemSpellCache();
  SMARTBUFF_WipeAndInitBuffRelationsCache();
end
