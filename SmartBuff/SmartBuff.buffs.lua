local _;
local S = SMARTBUFF_GLOBALS;

-- ---------------------------------------------------------------------------
-- Globals and buff type constants (SMARTBUFF_PLAYERCLASS, SMARTBUFF_BUFFLIST, SMARTBUFF_CONST_*, S.CheckPet, S.Toybox, S.ToyboxByID)
-- ---------------------------------------------------------------------------
SMARTBUFF_PLAYERCLASS = nil;
SMARTBUFF_BUFFLIST = nil;

-- Buff types
SMARTBUFF_CONST_ALL       = "ALL";
SMARTBUFF_CONST_GROUP     = "GROUP";
SMARTBUFF_CONST_GROUPALL  = "GROUPALL";
SMARTBUFF_CONST_SELF      = "SELF";
SMARTBUFF_CONST_FORCESELF = "FORCESELF";
SMARTBUFF_CONST_TRACK     = "TRACK";
SMARTBUFF_CONST_WEAPON    = "WEAPON";
SMARTBUFF_CONST_INV       = "INVENTORY";  -- This denotes that it's something in the inventory, not an item itself
SMARTBUFF_CONST_FOOD      = "FOOD";  -- This is food, an inventory item
SMARTBUFF_CONST_SCROLL    = "SCROLL";  -- This is a scroll, an inventory item
SMARTBUFF_CONST_POTION    = "POTION";  -- This is a potion, an inventory item
SMARTBUFF_CONST_STANCE    = "STANCE";  -- This is a warrior stance
SMARTBUFF_CONST_ITEM      = "ITEM";  -- This denotes that it's a conjured item (healthstone, mage food)
SMARTBUFF_CONST_ITEMGROUP = "ITEMGROUP";  -- Unused, candidate for removal
SMARTBUFF_CONST_TOY       = "TOY";  -- This is a toy in the toybox

S.CheckPet = "CHECKPET";
S.CheckPetNeeded = "CHECKPETNEEDED";
S.CheckFishingPole = "CHECKFISHINGPOLE";
S.NIL = "x";
S.Toybox = { };
-- Index by itemID for O(1) toy lookup in FindItem (avoids O(n) pairs over Toybox every check)
S.ToyboxByID = { };

-- ---------------------------------------------------------------------------
-- Helper functions: spell/item load (cache or API), validation, toybox population (S.Toybox, S.ToyboxByID)
-- ---------------------------------------------------------------------------
local function GetItems(items)
  local t = { };
  for _, id in pairs(items) do
    -- Validate item ID is a number
    if (type(id) == "number" and id > 0) then
      -- Validate item ID exists in game using GetItemInfoInstant
      -- GetItemInfoInstant doesn't rely on cache - returns instantly for real items
      -- Non-real items will return nil
      local itemID = C_Item.GetItemInfoInstant(id);
      if (itemID) then
        -- Item ID is valid and exists in game
        -- Store item ID initially (will be updated to link when async load completes)
        local idx = #t + 1;
        t[idx] = itemID; -- Store numeric ID initially
        
        -- Async load item link using ContinueOnItemLoad
        -- This fires immediately if cached, or async if not cached
        local item = Item:CreateFromItemID(itemID);
        item:ContinueOnItemLoad(function()
          local link = item:GetItemLink();
          if (link) then
            --print("Item found: "..id..", "..link);
            t[idx] = link;
          end
          -- If link unavailable, keep ID (SMARTBUFF_FindItem handles both)
        end);
      end
      -- If GetItemInfoInstant returns nil, item doesn't exist - skip it
    end
  end
  return t;
end

-- Spellbook abilities are not filtered properly this is workaround
-- Return a spell name even if spell is not available
-- This avoids nil comparisons hopefully
local function getSpellBookItemByName(spellId)
  local name = C_Spell.GetSpellName(spellId);
  if (name == nil) then
    return nil;
  end
  local spellInfo = C_Spell.GetSpellInfo(name);
  if (spellInfo == nil) then
    return name;
  end
  return spellInfo;
end

-- Helper function to validate spell data completeness
-- Returns true if spell data looks complete and reliable
function SMARTBUFF_ValidateSpellData(spellInfo)
  if (not spellInfo) then return false; end
  -- If it's a table (spellInfo), check for critical fields
  if (type(spellInfo) == "table") then
    -- Must have name and spellID to be considered complete
    return spellInfo.name ~= nil and spellInfo.spellID ~= nil;
  end
  -- If it's a string (spell name fallback), it's incomplete
  return false;
end

-- Helper function to validate item data completeness
-- Returns true if item data looks complete and reliable
function SMARTBUFF_ValidateItemData(itemLink, minLevel, texture)
  if (not itemLink or itemLink == "") then return false; end
  -- Item link is the minimum requirement - minLevel and texture are optional but preferred
  return true;
end

-- Helper function to get spell info only if variable is not already set
-- Only calls API if variable is nil, and only updates if valid response received
-- Usage: GetSpellInfoIfNeeded("SMARTBUFF_VARNAME", spellId, isSpellbookSpell)
-- isSpellbookSpell: true for class/talent spells (use spellbook check), false/nil for item spells (flasks/potions)
local function GetSpellInfoIfNeeded(varName, spellId, isSpellbookSpell)
  -- Track expected spell for cache sync (and O(1) reverse lookup in DATA_LOAD_RESULT)
  if (SMARTBUFF_ExpectedData and SMARTBUFF_ExpectedData.spells) then
    SMARTBUFF_ExpectedData.spells[varName] = spellId;
    if (not SMARTBUFF_ExpectedData.spellIDToVarName) then SMARTBUFF_ExpectedData.spellIDToVarName = {}; end
    SMARTBUFF_ExpectedData.spellIDToVarName[spellId] = varName;
  end
  
  -- Check if variable is already set (non-nil) - skip if already loaded
  if (_G[varName] ~= nil) then
    return;  -- Already loaded and verified, skip API call
  end
  
  -- Try to load from cache first (AllTheThings pattern: use cache when live data not available)
  local cache = SmartBuffItemSpellCache;
  if (cache and cache.version and cache.spells and cache.spells[varName]) then
    local cachedSpell = cache.spells[varName];
    if (cachedSpell) then
      _G[varName] = cachedSpell;
      -- Validate cached data - if incomplete, mark for refresh
      if (not SMARTBUFF_ValidateSpellData(cachedSpell)) then
        if (not cache.needsRefresh) then cache.needsRefresh = {}; end
        cache.needsRefresh[varName] = true;
        C_Spell.RequestLoadSpellData(spellId);
      else
        -- Still request background refresh to ensure data is current
        C_Spell.RequestLoadSpellData(spellId);
      end
      return;
    end
  end
  
  -- Not in cache, try to load from API
  local spellName = C_Spell.GetSpellName(spellId);
  if (not spellName) then
    -- Spell doesn't exist - mark as invalid and skip
    if (SmartBuffValidSpells) then
      SmartBuffValidSpells.spells[spellId] = false;  -- Mark as invalid
    end
    return;
  end
  
  local spellInfo = getSpellBookItemByName(spellId);
  if (spellInfo) then
    -- Validate data - if incomplete, re-queue for refresh
    if (not SMARTBUFF_ValidateSpellData(spellInfo)) then
      C_Spell.RequestLoadSpellData(spellId);
      return;
    end
    
    -- For spellbook spells, verify they're known/valid for this character
    if (isSpellbookSpell) then
      local isKnown = C_SpellBook.IsSpellKnownOrInSpellBook(spellId);
      if (not isKnown) then
        -- Spell not known - mark as invalid and skip
        if (SmartBuffValidSpells) then
          SmartBuffValidSpells.spells[spellId] = false;
        end
        return;
      end
      -- Valid spellbook spell - mark as valid
      if (SmartBuffValidSpells) then
        if (not SmartBuffValidSpells.spells) then SmartBuffValidSpells.spells = {}; end
        SmartBuffValidSpells.spells[spellId] = true;
        SmartBuffValidSpells.version = SMARTBUFF_VERSION;
        SmartBuffValidSpells.lastUpdate = GetTime();
      end
    else
      -- Item spell (flask/potion) - always valid if spell exists
      if (SmartBuffValidSpells) then
        if (not SmartBuffValidSpells.spells) then SmartBuffValidSpells.spells = {}; end
        SmartBuffValidSpells.spells[spellId] = true;
        SmartBuffValidSpells.version = SMARTBUFF_VERSION;
        SmartBuffValidSpells.lastUpdate = GetTime();
      end
    end
    
    -- Valid API response - update variable and cache
    _G[varName] = spellInfo;
    SMARTBUFF_InitItemSpellCache();
    if (not SmartBuffItemSpellCache.spells) then
      SmartBuffItemSpellCache.spells = {};
    end
    if (not SmartBuffItemSpellCache.needsRefresh) then
      SmartBuffItemSpellCache.needsRefresh = {};
    end
    SmartBuffItemSpellCache.spells[varName] = spellInfo;
    SmartBuffItemSpellCache.needsRefresh[varName] = false;  -- Mark as valid
    SmartBuffItemSpellCache.version = SMARTBUFF_VERSION;
    SmartBuffItemSpellCache.lastUpdate = GetTime();
  else
    -- API call failed - request loading, cache will be repopulated when SPELL_DATA_LOAD_RESULT fires
    SMARTBUFF_InitItemSpellCache();
    if (not SmartBuffItemSpellCache.needsRefresh) then
      SmartBuffItemSpellCache.needsRefresh = {};
    end
    SmartBuffItemSpellCache.needsRefresh[varName] = true;  -- Mark as needing refresh
    C_Spell.RequestLoadSpellData(spellId);
  end
end

-- Helper function to get spell info directly from C_Spell.GetSpellInfo() only if variable is not already set
-- Loads from cache first, then API if needed
-- Usage: GetSpellInfoDirectIfNeeded("SMARTBUFF_VARNAME", spellId, isSpellbookSpell)
-- isSpellbookSpell: true for character/racial spells (use spellbook check), false/nil for item spells (flasks/potions/scrolls)
local function GetSpellInfoDirectIfNeeded(varName, spellId, isSpellbookSpell)
  -- Track expected spell for cache sync (and O(1) reverse lookup in DATA_LOAD_RESULT)
  if (SMARTBUFF_ExpectedData and SMARTBUFF_ExpectedData.spells) then
    SMARTBUFF_ExpectedData.spells[varName] = spellId;
    if (not SMARTBUFF_ExpectedData.spellIDToVarName) then SMARTBUFF_ExpectedData.spellIDToVarName = {}; end
    SMARTBUFF_ExpectedData.spellIDToVarName[spellId] = varName;
  end
  
  -- Check if variable is already set (non-nil) - skip if already loaded
  if (_G[varName] ~= nil) then
    return;  -- Already loaded and verified, skip API call
  end
  
  -- Try to load from cache first (AllTheThings pattern: use cache when live data not available)
  local cache = SmartBuffItemSpellCache;
  if (cache and cache.version and cache.spells and cache.spells[varName]) then
    local cachedSpell = cache.spells[varName];
    if (cachedSpell) then
      _G[varName] = cachedSpell;
      -- Validate cached data - if incomplete, mark for refresh
      if (not SMARTBUFF_ValidateSpellData(cachedSpell)) then
        if (not cache.needsRefresh) then cache.needsRefresh = {}; end
        cache.needsRefresh[varName] = true;
        C_Spell.RequestLoadSpellData(spellId);
      else
        -- Still request background refresh to ensure data is current
        C_Spell.RequestLoadSpellData(spellId);
      end
      return;
    end
  end
  
  -- Not in cache, try to load from API
  local spellName = C_Spell.GetSpellName(spellId);
  if (not spellName) then
    -- Spell doesn't exist - mark as invalid and skip
    if (SmartBuffValidSpells) then
      SmartBuffValidSpells.spells[spellId] = false;  -- Mark as invalid
    end
    return;
  end
  
  local spellInfo = C_Spell.GetSpellInfo(spellId);
  if (spellInfo) then
    -- Validate data - if incomplete, re-queue for refresh
    if (not SMARTBUFF_ValidateSpellData(spellInfo)) then
      C_Spell.RequestLoadSpellData(spellId);
      return;
    end
    
    -- For spellbook spells, verify they're known/valid for this character
    if (isSpellbookSpell) then
      local isKnown = C_SpellBook.IsSpellKnownOrInSpellBook(spellId);
      if (not isKnown) then
        -- Spell not known - mark as invalid and skip
        if (SmartBuffValidSpells) then
          SmartBuffValidSpells.spells[spellId] = false;
        end
        return;
      end
      -- Valid spellbook spell - mark as valid
      if (SmartBuffValidSpells) then
        if (not SmartBuffValidSpells.spells) then SmartBuffValidSpells.spells = {}; end
        SmartBuffValidSpells.spells[spellId] = true;
        SmartBuffValidSpells.version = SMARTBUFF_VERSION;
        SmartBuffValidSpells.lastUpdate = GetTime();
      end
    else
      -- Item spell (flask/potion/scroll) - always valid if spell exists
      if (SmartBuffValidSpells) then
        if (not SmartBuffValidSpells.spells) then SmartBuffValidSpells.spells = {}; end
        SmartBuffValidSpells.spells[spellId] = true;
        SmartBuffValidSpells.version = SMARTBUFF_VERSION;
        SmartBuffValidSpells.lastUpdate = GetTime();
      end
    end
    
    -- Valid API response received - update the variable and cache
    _G[varName] = spellInfo;
    -- Save to cache for persistence
    SMARTBUFF_InitItemSpellCache();
    if (not SmartBuffItemSpellCache.spells) then
      SmartBuffItemSpellCache.spells = {};
    end
    if (not SmartBuffItemSpellCache.needsRefresh) then
      SmartBuffItemSpellCache.needsRefresh = {};
    end
    SmartBuffItemSpellCache.spells[varName] = spellInfo;
    SmartBuffItemSpellCache.needsRefresh[varName] = false;  -- Mark as valid
    SmartBuffItemSpellCache.version = SMARTBUFF_VERSION;
    SmartBuffItemSpellCache.lastUpdate = GetTime();
  else
    -- API call failed - request loading, cache will be repopulated when SPELL_DATA_LOAD_RESULT fires
    SMARTBUFF_InitItemSpellCache();
    if (not SmartBuffItemSpellCache.needsRefresh) then
      SmartBuffItemSpellCache.needsRefresh = {};
    end
    SmartBuffItemSpellCache.needsRefresh[varName] = true;  -- Mark as needing refresh
    C_Spell.RequestLoadSpellData(spellId);
  end
end

-- Helper function to validate item data completeness
-- Returns true if item data looks complete and reliable
local function ValidateItemData(itemLink, minLevel, texture)
  -- Must have itemLink to be considered complete
  if (not itemLink or itemLink == "") then return false; end
  -- minLevel and texture should be present (can be 0/nil for some items, but should be explicitly set)
  -- For now, just check itemLink exists - minLevel/texture can be nil for some items
  return true;
end

-- Helper function to get item info only if variable is not already set
-- Loads from cache first, then API if needed
-- Usage: GetItemInfoIfNeeded("SMARTBUFF_VARNAME", itemId)
local function GetItemInfoIfNeeded(varName, itemId)
  -- Track expected item for cache sync (and O(1) reverse lookup in DATA_LOAD_RESULT)
  if (SMARTBUFF_ExpectedData and SMARTBUFF_ExpectedData.items) then
    SMARTBUFF_ExpectedData.items[varName] = itemId;
    if (not SMARTBUFF_ExpectedData.itemIDToVarName) then SMARTBUFF_ExpectedData.itemIDToVarName = {}; end
    SMARTBUFF_ExpectedData.itemIDToVarName[itemId] = varName;
  end
  
  -- Check if variable is already set (non-nil) - skip if already loaded
  if (_G[varName] ~= nil) then
    return;  -- Already loaded and verified, skip API call
  end
  
  -- Try to load from cache first (AllTheThings pattern: use cache when live data not available)
  local cache = SmartBuffItemSpellCache;
  if (cache and cache.version and cache.items and cache.items[varName]) then
    local cachedLink = cache.items[varName];
    if (cachedLink) then
      _G[varName] = cachedLink;
      -- Check if we have minLevel/texture in cache
      local itemData = cache.itemData and cache.itemData[varName];
      local minLevel = itemData and itemData[1];
      local texture = itemData and itemData[2];
      
      -- Validate cached data - if incomplete, mark for refresh
      if (not ValidateItemData(cachedLink, minLevel, texture)) then
        if (not cache.needsRefresh) then cache.needsRefresh = {}; end
        cache.needsRefresh[varName] = true;
        if (cache.itemIDs and cache.itemIDs[varName]) then
          C_Item.RequestLoadItemDataByID(cache.itemIDs[varName]);
        end
      else
        -- Still request background refresh to ensure data is current
        if (cache.itemIDs and cache.itemIDs[varName]) then
          C_Item.RequestLoadItemDataByID(cache.itemIDs[varName]);
        end
      end
      return;  -- Use cached data, refresh in background
    end
  end
  
  -- Not in cache, try to load from API
  local itemName, itemLink, itemRarity, itemLevel, minLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, texture = C_Item.GetItemInfo(itemId);
  if (itemLink) then
    -- Validate data - if incomplete, re-queue for refresh
    if (not SMARTBUFF_ValidateItemData(itemLink, minLevel, texture)) then
      C_Item.RequestLoadItemDataByID(itemId);
      -- Still mark in cache as needing refresh
      SMARTBUFF_InitItemSpellCache();
      if (not SmartBuffItemSpellCache.needsRefresh) then
        SmartBuffItemSpellCache.needsRefresh = {};
      end
      SmartBuffItemSpellCache.needsRefresh[varName] = true;
      return;
    end
    -- Valid API response received - update the variable and cache
    _G[varName] = itemLink;
    -- Save to cache for persistence (including minLevel and texture)
    SMARTBUFF_InitItemSpellCache();
    if (not SmartBuffItemSpellCache.items) then
      SmartBuffItemSpellCache.items = {};
    end
    if (not SmartBuffItemSpellCache.itemIDs) then
      SmartBuffItemSpellCache.itemIDs = {};
    end
    if (not SmartBuffItemSpellCache.itemData) then
      SmartBuffItemSpellCache.itemData = {};
    end
    if (not SmartBuffItemSpellCache.needsRefresh) then
      SmartBuffItemSpellCache.needsRefresh = {};
    end
    SmartBuffItemSpellCache.items[varName] = itemLink;
    SmartBuffItemSpellCache.itemIDs[varName] = itemId;
    SmartBuffItemSpellCache.itemData[varName] = {minLevel or 0, texture or 0};  -- Store minLevel and texture
    SmartBuffItemSpellCache.needsRefresh[varName] = false;  -- Mark as valid
    SmartBuffItemSpellCache.version = SMARTBUFF_VERSION;
    SmartBuffItemSpellCache.lastUpdate = GetTime();
  else
    -- Item not loaded yet: set placeholder so buff list can include it; ITEM_DATA_LOAD_RESULT will update later
    _G[varName] = "item:" .. tostring(itemId);
    SMARTBUFF_InitItemSpellCache();
    if (not SmartBuffItemSpellCache.needsRefresh) then
      SmartBuffItemSpellCache.needsRefresh = {};
    end
    SmartBuffItemSpellCache.needsRefresh[varName] = true;
    C_Item.RequestLoadItemDataByID(itemId);
  end
end

local function InsertItem(t, type, itemId, spellId, duration, link)
  -- Use GetItemInfoIfNeeded pattern to track and cache items
  -- Generate a unique varName for tracking (won't be used as global, just for cache tracking)
  local varName = "SMARTBUFF_DYNAMIC_" .. tostring(itemId);
  
  -- Track expected item for cache sync (and O(1) reverse lookup in DATA_LOAD_RESULT)
  if (SMARTBUFF_ExpectedData and SMARTBUFF_ExpectedData.items) then
    SMARTBUFF_ExpectedData.items[varName] = itemId;
    if (not SMARTBUFF_ExpectedData.itemIDToVarName) then SMARTBUFF_ExpectedData.itemIDToVarName = {}; end
    SMARTBUFF_ExpectedData.itemIDToVarName[itemId] = varName;
  end
  
  -- Try cache first
  local item = nil;
  local minLevel, texture = nil, nil;
  local cache = SmartBuffItemSpellCache;
  if (cache and cache.version and cache.items and cache.items[varName]) then
    item = cache.items[varName];
    local itemData = cache.itemData and cache.itemData[varName];
    if (itemData) then
      minLevel = itemData[1];
      texture = itemData[2];
    end
  end
  
  -- If not in cache, try API
  if (not item) then
    local itemName, itemLink, itemRarity, itemLevel, apiMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, apiTexture = C_Item.GetItemInfo(itemId);
    item = itemLink;
    minLevel = apiMinLevel;
    texture = apiTexture;
    
    -- Cache if valid
    if (item and SMARTBUFF_ValidateItemData(item, minLevel, texture)) then
      SMARTBUFF_InitItemSpellCache();
      if (not SmartBuffItemSpellCache.items) then SmartBuffItemSpellCache.items = {}; end
      if (not SmartBuffItemSpellCache.itemIDs) then SmartBuffItemSpellCache.itemIDs = {}; end
      if (not SmartBuffItemSpellCache.itemData) then SmartBuffItemSpellCache.itemData = {}; end
      if (not SmartBuffItemSpellCache.needsRefresh) then SmartBuffItemSpellCache.needsRefresh = {}; end
      SmartBuffItemSpellCache.items[varName] = item;
      SmartBuffItemSpellCache.itemIDs[varName] = itemId;
      SmartBuffItemSpellCache.itemData[varName] = {minLevel or 0, texture or 0};
      SmartBuffItemSpellCache.needsRefresh[varName] = false;
    elseif (item) then
      -- Item link exists but data incomplete - mark for refresh
      SMARTBUFF_InitItemSpellCache();
      if (not SmartBuffItemSpellCache.needsRefresh) then SmartBuffItemSpellCache.needsRefresh = {}; end
      SmartBuffItemSpellCache.needsRefresh[varName] = true;
      C_Item.RequestLoadItemDataByID(itemId);
    else
      -- Item not loaded - request loading
      SMARTBUFF_InitItemSpellCache();
      if (not SmartBuffItemSpellCache.needsRefresh) then SmartBuffItemSpellCache.needsRefresh = {}; end
      SmartBuffItemSpellCache.needsRefresh[varName] = true;
      C_Item.RequestLoadItemDataByID(itemId);
    end
  else
    -- Item in cache - still request background refresh
    if (cache.needsRefresh and cache.needsRefresh[varName]) then
      C_Item.RequestLoadItemDataByID(itemId);
    end
  end
  
  -- Get spell info (use GetSpellInfoDirectIfNeeded pattern)
  -- Item spells (flasks/potions/toys) are NOT spellbook spells - don't use spellbook check
  local spellVarName = "SMARTBUFF_DYNAMIC_SPELL_" .. tostring(spellId);
  if (SMARTBUFF_ExpectedData and SMARTBUFF_ExpectedData.spells) then
    SMARTBUFF_ExpectedData.spells[spellVarName] = spellId;
    if (not SMARTBUFF_ExpectedData.spellIDToVarName) then SMARTBUFF_ExpectedData.spellIDToVarName = {}; end
    SMARTBUFF_ExpectedData.spellIDToVarName[spellId] = spellVarName;
  end
  
  local spell = nil;
  if (cache and cache.version and cache.spells and cache.spells[spellVarName]) then
    spell = cache.spells[spellVarName];
  end
  
  if (not spell) then
    spell = C_Spell.GetSpellInfo(spellId);
    if (spell and SMARTBUFF_ValidateSpellData(spell)) then
      SMARTBUFF_InitItemSpellCache();
      if (not SmartBuffItemSpellCache.spells) then SmartBuffItemSpellCache.spells = {}; end
      if (not SmartBuffItemSpellCache.needsRefresh) then SmartBuffItemSpellCache.needsRefresh = {}; end
      SmartBuffItemSpellCache.spells[spellVarName] = spell;
      SmartBuffItemSpellCache.needsRefresh[spellVarName] = false;
    elseif (spell) then
      -- Spell exists but incomplete - mark for refresh
      SMARTBUFF_InitItemSpellCache();
      if (not SmartBuffItemSpellCache.needsRefresh) then SmartBuffItemSpellCache.needsRefresh = {}; end
      SmartBuffItemSpellCache.needsRefresh[spellVarName] = true;
      C_Spell.RequestLoadSpellData(spellId);
    else
      -- Spell not loaded - request loading
      SMARTBUFF_InitItemSpellCache();
      if (not SmartBuffItemSpellCache.needsRefresh) then SmartBuffItemSpellCache.needsRefresh = {}; end
      SmartBuffItemSpellCache.needsRefresh[spellVarName] = true;
      C_Spell.RequestLoadSpellData(spellId);
    end
  end
  
  -- Accept partial data (AllTheThings pattern) - add item even if data isn't fully loaded yet
  -- Data will be updated when ITEM_DATA_LOAD_RESULT/SPELL_DATA_LOAD_RESULT fires
  if (item) then
    -- ItemLink available - use it
    local spellToAdd = spell;
    if (not spellToAdd and spellId) then
      -- Spell not loaded yet - use spellId as placeholder, will be resolved by event system
      spellToAdd = spellId;
    end
    --print("Item found: "..item..", "..tostring(spellToAdd));
    tinsert(t, {item, duration, type, nil, spellToAdd, link});
  elseif (itemId) then
    -- ItemLink not loaded yet - use itemId as placeholder, will be resolved by event system
    -- This ensures toys/items are added even if itemLink isn't available immediately
    local itemPlaceholder = "item:" .. tostring(itemId);
    local spellToAdd = spell;
    if (not spellToAdd and spellId) then
      spellToAdd = spellId;
    end
    tinsert(t, {itemPlaceholder, duration, type, nil, spellToAdd, link});
  end
  -- If neither item nor itemId is available, skip adding (will be added when data loads via events)
end

local function AddItem(itemId, spellId, duration, link)
  InsertItem(SMARTBUFF_SCROLL, SMARTBUFF_CONST_SCROLL, itemId, spellId, duration, link);
end

-- ---------------------------------------------------------------------------
-- Toybox: load collected toys into S.Toybox / S.ToyboxByID for TOY buff type
-- Uses C_ToyBox; restores from SmartBuffToyCache when valid, then refreshes from live.
-- ---------------------------------------------------------------------------
function SMARTBUFF_LoadToys()
  -- Populate S.Toybox (by link) and S.ToyboxByID (by itemID) from C_ToyBox; restore from cache first, then override with live data.
  local cache = SmartBuffToyCache;
  local nLearned = C_ToyBox.GetNumLearnedDisplayedToys() or 0;

  -- Skip full reload if cache is valid and learned toy count matches (avoids re-scanning C_ToyBox every init)
  if (cache and cache.version and cache.toyCount > 0) then
    local currentToyCount = 0;
    if (S.Toybox) then
      for _ in pairs(S.Toybox) do
        currentToyCount = currentToyCount + 1;
      end
    end
    
    if (currentToyCount == cache.toyCount and currentToyCount == nLearned and nLearned > 0) then
      SMARTBUFF_AddMsgD("Toys already loaded and verified (cached: " .. cache.toyCount .. ")");
      return;
    end
  end

  -- Clear and restore from cache first (fallback pattern - AllTheThings: use cache when live data not available)
  wipe(S.Toybox);
  wipe(S.ToyboxByID);
  -- Cache format: new [toyID]=icon; legacy [itemLink]={toyID,icon}. Build toyIDToCachedLink for placeholders.
  local toyIDToCachedLink = {};
  if (cache and cache.version and cache.toybox) then
    for k, v in pairs(cache.toybox) do
      local id, icon, linkKey;
      if (type(v) == "table") then
        id, icon = v[1], v[2];
        linkKey = k;
      else
        id, icon = k, v;
        linkKey = "item:" .. tostring(id);
      end
      local entry = {id, icon};
      S.Toybox[linkKey] = entry;
      S.ToyboxByID[id] = entry;
      toyIDToCachedLink[id] = linkKey;
    end
  end

  -- Reset toybox filters so indexing sees all toys (user may have e.g. expansion source set to none)
  if (C_ToyBoxInfo and C_ToyBoxInfo.SetDefaultFilters) then
    C_ToyBoxInfo.SetDefaultFilters();
  end
  C_ToyBox.SetCollectedShown(true);
  C_ToyBox.SetAllSourceTypeFilters(true);
  C_ToyBox.SetFilterString("");
  local nTotal = C_ToyBox.GetNumTotalDisplayedToys();

  if (nLearned <= 0) then
    return;
  end

  -- Load toys from live data, updating/overriding cached entries when available
  for i = 1, nTotal do
    local num = C_ToyBox.GetToyFromIndex(i);
    local id, name, icon = C_ToyBox.GetToyInfo(num);
    if (id and PlayerHasToy(id)) then
      local _, itemLink = C_Item.GetItemInfo(id);
      if (itemLink) then
        local entry = {id, icon};
        S.Toybox[tostring(itemLink)] = entry;
        S.ToyboxByID[id] = entry;
      else
        C_Item.RequestLoadItemDataByID(id);
        local cachedLink = toyIDToCachedLink[id];
        local cachedIcon = (cache and cache.toybox) and (cache.toybox[id] or (type(cache.toybox[cachedLink]) == "table" and cache.toybox[cachedLink][2]));
        local entry = {id, icon or cachedIcon};
        S.Toybox[cachedLink or ("item:" .. tostring(id))] = entry;
        S.ToyboxByID[id] = entry;
      end
    end
  end

  SMARTBUFF_AddMsgD("Toys initialized");
end

-- ---------------------------------------------------------------------------
-- Init: item list (stones, oils, food items, scroll table, toys)
-- ---------------------------------------------------------------------------
function SMARTBUFF_InitItemList()
  -- Weapon enhancements: mana gems, sharpening stones, weightstones, oils (classic → TWW)
  -- Only call API if variable is not already set (optimization: skip if already loaded and verified)
  GetItemInfoIfNeeded("SMARTBUFF_MANAGEM", 36799); --"Mana Gem"
  GetItemInfoIfNeeded("SMARTBUFF_BRILLIANTMANAGEM", 81901); --"Brilliant Mana Gem"
  GetItemInfoIfNeeded("SMARTBUFF_SSROUGH", 2862); --"Rough Sharpening Stone"
  GetItemInfoIfNeeded("SMARTBUFF_SSCOARSE", 2863); --"Coarse Sharpening Stone"
  GetItemInfoIfNeeded("SMARTBUFF_SSHEAVY", 2871); --"Heavy Sharpening Stone"
  GetItemInfoIfNeeded("SMARTBUFF_SSSOLID", 7964); --"Solid Sharpening Stone"
  GetItemInfoIfNeeded("SMARTBUFF_SSDENSE", 12404); --"Dense Sharpening Stone"
  GetItemInfoIfNeeded("SMARTBUFF_SSELEMENTAL", 18262); --"Elemental Sharpening Stone"
  GetItemInfoIfNeeded("SMARTBUFF_SSFEL", 23528); --"Fel Sharpening Stone"
  GetItemInfoIfNeeded("SMARTBUFF_SSADAMANTITE", 23529); --"Adamantite Sharpening Stone"
  GetItemInfoIfNeeded("SMARTBUFF_WSROUGH", 3239); --"Rough Weightstone"
  GetItemInfoIfNeeded("SMARTBUFF_WSCOARSE", 3240); --"Coarse Weightstone"
  GetItemInfoIfNeeded("SMARTBUFF_WSHEAVY", 3241); --"Heavy Weightstone"
  GetItemInfoIfNeeded("SMARTBUFF_WSSOLID", 7965); --"Solid Weightstone"
  GetItemInfoIfNeeded("SMARTBUFF_WSDENSE", 12643); --"Dense Weightstone"
  GetItemInfoIfNeeded("SMARTBUFF_WSFEL", 28420); --"Fel Weightstone"
  GetItemInfoIfNeeded("SMARTBUFF_WSADAMANTITE", 28421); --"Adamantite Weightstone"
  GetItemInfoIfNeeded("SMARTBUFF_SHADOWOIL", 3824); --"Shadow Oil"
  GetItemInfoIfNeeded("SMARTBUFF_FROSTOIL", 3829); --"Frost Oil"
  GetItemInfoIfNeeded("SMARTBUFF_MANAOIL1", 20745); --"Minor Mana Oil"
  GetItemInfoIfNeeded("SMARTBUFF_MANAOIL2", 20747); --"Lesser Mana Oil"
  GetItemInfoIfNeeded("SMARTBUFF_MANAOIL3", 20748); --"Brilliant Mana Oil"
  GetItemInfoIfNeeded("SMARTBUFF_MANAOIL4", 22521); --"Superior Mana Oil"
  GetItemInfoIfNeeded("SMARTBUFF_WIZARDOIL1", 20744); --"Minor Wizard Oil"
  GetItemInfoIfNeeded("SMARTBUFF_WIZARDOIL2", 20746); --"Lesser Wizard Oil"
  GetItemInfoIfNeeded("SMARTBUFF_WIZARDOIL3", 20750); --"Wizard Oil"
  GetItemInfoIfNeeded("SMARTBUFF_WIZARDOIL4", 20749); --"Brilliant Wizard Oil"
  GetItemInfoIfNeeded("SMARTBUFF_WIZARDOIL5", 22522); --"Superior Wizard Oil"
  GetItemInfoIfNeeded("SMARTBUFF_SHADOWCOREOIL", 171285); --"Shadowcore Oil"
  GetItemInfoIfNeeded("SMARTBUFF_EMBALMERSOIL", 171286); --"Embalmer's Oil"
  -- Dragonflight
  GetItemInfoIfNeeded("SMARTBUFF_SafeRockets_q1", 198160); -- Completely Safe Rockets (Quality 1)
  GetItemInfoIfNeeded("SMARTBUFF_SafeRockets_q2", 198161); -- Completely Safe Rockets (Quality 2)
  GetItemInfoIfNeeded("SMARTBUFF_SafeRockets_q3", 198162); -- Completely Safe Rockets (Quality 3)
  GetItemInfoIfNeeded("SMARTBUFF_BuzzingRune_q1", 194821); -- Buzzing Rune (Quality 1)
  GetItemInfoIfNeeded("SMARTBUFF_BuzzingRune_q2", 194822); -- Buzzing Rune (Quality 2)
  GetItemInfoIfNeeded("SMARTBUFF_BuzzingRune_q3", 194823); -- Buzzing Rune (Quality 3)
  GetItemInfoIfNeeded("SMARTBUFF_ChirpingRune_q1", 194824); -- Chirping Rune (Quality 1)
  GetItemInfoIfNeeded("SMARTBUFF_ChirpingRune_q2", 194825); -- Chirping Rune (Quality 2)
  GetItemInfoIfNeeded("SMARTBUFF_ChirpingRune_q3", 194826); -- Chirping Rune (Quality 3)
  GetItemInfoIfNeeded("SMARTBUFF_HowlingRune_q1", 194821); -- Howling Rune (Quality 1)
  GetItemInfoIfNeeded("SMARTBUFF_HowlingRune_q2", 194822); -- Howling Rune (Quality 2)
  GetItemInfoIfNeeded("SMARTBUFF_HowlingRune_q3", 194820); -- Howling Rune (Quality 3)
  GetItemInfoIfNeeded("SMARTBUFF_PrimalWeighstone_q1", 191943); -- Primal Weighstone (Quality 1)
  GetItemInfoIfNeeded("SMARTBUFF_PrimalWeighstone_q2", 191944); -- Primal Weighstone (Quality 2)
  GetItemInfoIfNeeded("SMARTBUFF_PrimalWeighstone_q3", 191945); -- Primal Weighstone (Quality 3)
  GetItemInfoIfNeeded("SMARTBUFF_PrimalWhetstone_q1", 191933); -- Primal Whestone (Quality 1)
  GetItemInfoIfNeeded("SMARTBUFF_PrimalWhetstone_q2", 191939); -- Primal Whestone (Quality 2)
  GetItemInfoIfNeeded("SMARTBUFF_PrimalWhetstone_q3", 191940); -- Primal Whestone (Quality 3)
  -- The War Within
  GetItemInfoIfNeeded("SMARTBUFF_TWWWeaponEnhance1_q1", 222503); -- Ironclaw Razorstone
  GetItemInfoIfNeeded("SMARTBUFF_TWWWeaponEnhance1_q2", 222504); -- Ironclaw Razorstone
  GetItemInfoIfNeeded("SMARTBUFF_TWWWeaponEnhance1_q3", 222505); -- Ironclaw Razorstone
  GetItemInfoIfNeeded("SMARTBUFF_TWWWeaponEnhance2_q1", 222506); -- Ironclaw Weightstone
  GetItemInfoIfNeeded("SMARTBUFF_TWWWeaponEnhance2_q2", 222506); -- Ironclaw Weightstone
  GetItemInfoIfNeeded("SMARTBUFF_TWWWeaponEnhance2_q3", 222507); -- Ironclaw Weightstone
  GetItemInfoIfNeeded("SMARTBUFF_TWWWeaponEnhance3_q1", 222508); -- Ironclaw Whetstone
  GetItemInfoIfNeeded("SMARTBUFF_TWWWeaponEnhance3_q2", 222509); -- Ironclaw Whetstone
  GetItemInfoIfNeeded("SMARTBUFF_TWWWeaponEnhance3_q3", 222510); -- Ironclaw Whetstone
  GetItemInfoIfNeeded("SMARTBUFF_TWWWeaponEnhance4_q1", 224108); -- Oil of Beledar's Grace
  GetItemInfoIfNeeded("SMARTBUFF_TWWWeaponEnhance4_q2", 224109); -- Oil of Beledar's Grace
  GetItemInfoIfNeeded("SMARTBUFF_TWWWeaponEnhance4_q3", 224110); -- Oil of Beledar's Grace
  GetItemInfoIfNeeded("SMARTBUFF_TWWWeaponEnhance5_q1", 224111); -- Oil of Deep Toxins
  GetItemInfoIfNeeded("SMARTBUFF_TWWWeaponEnhance5_q2", 224112); -- Oil of Deep Toxins
  GetItemInfoIfNeeded("SMARTBUFF_TWWWeaponEnhance5_q3", 224113); -- Oil of Deep Toxins
  GetItemInfoIfNeeded("SMARTBUFF_TWWWeaponEnhance6_q1", 224105); -- Algari Mana Oil
  GetItemInfoIfNeeded("SMARTBUFF_TWWWeaponEnhance6_q2", 224106); -- Algari Mana Oil
  GetItemInfoIfNeeded("SMARTBUFF_TWWWeaponEnhance6_q3", 224107); -- Algari Mana Oil

  -- Food (well-fed) item vars
--  SMARTBUFF_KIBLERSBITS         = C_Item.GetItemInfo(33874); --"Kibler's Bits"
--  SMARTBUFF_STORMCHOPS          = C_Item.GetItemInfo(33866); --"Stormchops"
  GetItemInfoIfNeeded("SMARTBUFF_JUICYBEARBURGER", 35565); --"Juicy Bear Burger"
  GetItemInfoIfNeeded("SMARTBUFF_CRUNCHYSPIDER", 22645); --"Crunchy Spider Surprise"
  GetItemInfoIfNeeded("SMARTBUFF_LYNXSTEAK", 27635); --"Lynx Steak"
  GetItemInfoIfNeeded("SMARTBUFF_CHARREDBEARKABOBS", 35563); --"Charred Bear Kabobs"
  GetItemInfoIfNeeded("SMARTBUFF_BATBITES", 27636); --"Bat Bites"
  GetItemInfoIfNeeded("SMARTBUFF_ROASTEDMOONGRAZE", 24105); --"Roasted Moongraze Tenderloin"
  GetItemInfoIfNeeded("SMARTBUFF_MOKNATHALSHORTRIBS", 31672); --"Mok'Nathal Shortribs"
  GetItemInfoIfNeeded("SMARTBUFF_CRUNCHYSERPENT", 31673); --"Crunchy Serpent"
  GetItemInfoIfNeeded("SMARTBUFF_ROASTEDCLEFTHOOF", 27658); --"Roasted Clefthoof"
  GetItemInfoIfNeeded("SMARTBUFF_FISHERMANSFEAST", 33052); --"Fisherman's Feast"
  GetItemInfoIfNeeded("SMARTBUFF_WARPBURGER", 27659); --"Warp Burger"
  GetItemInfoIfNeeded("SMARTBUFF_RAVAGERDOG", 27655); --"Ravager Dog"
  GetItemInfoIfNeeded("SMARTBUFF_SKULLFISHSOUP", 33825); --"Skullfish Soup"
  GetItemInfoIfNeeded("SMARTBUFF_BUZZARDBITES", 27651); --"Buzzard Bites"
  GetItemInfoIfNeeded("SMARTBUFF_TALBUKSTEAK", 27660); --"Talbuk Steak"
  GetItemInfoIfNeeded("SMARTBUFF_GOLDENFISHSTICKS", 27666); --"Golden Fish Sticks"
  GetItemInfoIfNeeded("SMARTBUFF_SPICYHOTTALBUK", 33872); --"Spicy Hot Talbuk"
  GetItemInfoIfNeeded("SMARTBUFF_FELTAILDELIGHT", 27662); --"Feltail Delight"
  GetItemInfoIfNeeded("SMARTBUFF_BLACKENEDSPOREFISH", 27663); --"Blackened Sporefish"
  GetItemInfoIfNeeded("SMARTBUFF_HOTAPPLECIDER", 34411); --"Hot Apple Cider"
  GetItemInfoIfNeeded("SMARTBUFF_BROILEDBLOODFIN", 33867); --"Broiled Bloodfin"
  GetItemInfoIfNeeded("SMARTBUFF_SPICYCRAWDAD", 27667); --"Spicy Crawdad"
  GetItemInfoIfNeeded("SMARTBUFF_POACHEDBLUEFISH", 27665); --"Poached Bluefish"
  GetItemInfoIfNeeded("SMARTBUFF_BLACKENEDBASILISK", 27657); --"Blackened Basilisk"
  GetItemInfoIfNeeded("SMARTBUFF_GRILLEDMUDFISH", 27664); --"Grilled Mudfish"
  GetItemInfoIfNeeded("SMARTBUFF_CLAMBAR", 30155); --"Clam Bar"
  GetItemInfoIfNeeded("SMARTBUFF_SAGEFISHDELIGHT", 21217); --"Sagefish Delight"
  GetItemInfoIfNeeded("SMARTBUFF_SALTPEPPERSHANK", 133557); --"Salt & Pepper Shank"
  GetItemInfoIfNeeded("SMARTBUFF_PICKLEDSTORMRAY", 133562); --"Pickled Stormray"
  GetItemInfoIfNeeded("SMARTBUFF_DROGBARSTYLESALMON", 133569); --"Drogbar-Style Salmon"
  GetItemInfoIfNeeded("SMARTBUFF_BARRACUDAMRGLGAGH", 133567); --"Barracuda Mrglgagh"
  GetItemInfoIfNeeded("SMARTBUFF_FIGHTERCHOW", 133577); --"Fighter Chow"
  GetItemInfoIfNeeded("SMARTBUFF_FARONAARFIZZ", 133563); --"Faronaar Fizz"
  GetItemInfoIfNeeded("SMARTBUFF_BEARTARTARE", 133576); --"Bear Tartare"
  GetItemInfoIfNeeded("SMARTBUFF_LEGIONCHILI", 118428); --"Legion Chili"
  GetItemInfoIfNeeded("SMARTBUFF_DEEPFRIEDMOSSGILL", 133561); --"Deep-Fried Mossgill"
  GetItemInfoIfNeeded("SMARTBUFF_MONDAZI", 154885); --"Mon'Dazi"
  GetItemInfoIfNeeded("SMARTBUFF_KULTIRAMISU", 154881); --"Kul Tiramisu"
  GetItemInfoIfNeeded("SMARTBUFF_GRILLEDCATFISH", 154889); --"Grilled Catfish"
  GetItemInfoIfNeeded("SMARTBUFF_LOALOAF", 154887); --"Loa Loaf"
  GetItemInfoIfNeeded("SMARTBUFF_HONEYHAUNCHES", 154882); --"Honey-Glazed Haunches"
  GetItemInfoIfNeeded("SMARTBUFF_RAVENBERRYTARTS", 154883); --"Ravenberry Tarts"
  GetItemInfoIfNeeded("SMARTBUFF_SWAMPFISHNCHIPS", 154884); --"Swamp Fish 'n Chips"
  GetItemInfoIfNeeded("SMARTBUFF_SEASONEDLOINS", 154891); --"Seasoned Loins"
  GetItemInfoIfNeeded("SMARTBUFF_SAILORSPIE", 154888); --"Sailor's Pie"
  GetItemInfoIfNeeded("SMARTBUFF_SPICEDSNAPPER", 154886); --"Spiced Snapper"
  --_,SMARTBUFF_HEARTSBANEHEXWURST = C_Item.GetItemInfo(163781); --"Heartsbane Hexwurst"
  GetItemInfoIfNeeded("SMARTBUFF_ABYSSALFRIEDRISSOLE", 168311); --"Abyssal-Fried Rissole"
  GetItemInfoIfNeeded("SMARTBUFF_BAKEDPORTTATO", 168313); --"Baked Port Tato"
  GetItemInfoIfNeeded("SMARTBUFF_BILTONG", 168314); --"Bil'Tong"
  GetItemInfoIfNeeded("SMARTBUFF_BIGMECH", 168310); --"Mech-Dowel's 'Big Mech'"
  GetItemInfoIfNeeded("SMARTBUFF_FRAGRANTKAKAVIA", 168312); --"Fragrant Kakavia"
  GetItemInfoIfNeeded("SMARTBUFF_BANANABEEFPUDDING", 172069); --"Banana Beef Pudding"
  GetItemInfoIfNeeded("SMARTBUFF_BUTTERSCOTCHRIBS", 172040); --"Butterscotch Marinated Ribs"
  GetItemInfoIfNeeded("SMARTBUFF_CINNAMONBONEFISH", 172044); --"Cinnamon Bonefish Stew"
  GetItemInfoIfNeeded("SMARTBUFF_EXTRALEMONYFILET", 184682); --"Extra Lemony Herb Filet"
  GetItemInfoIfNeeded("SMARTBUFF_FRIEDBONEFISH", 172063); --"Friedn Bonefish"
  GetItemInfoIfNeeded("SMARTBUFF_IRIDESCENTRAVIOLI", 172049); --"Iridescent Ravioli with Apple Sauce"
  GetItemInfoIfNeeded("SMARTBUFF_MEATYAPPLEDUMPLINGS", 172048); --"Meaty Apple Dumplings"
  GetItemInfoIfNeeded("SMARTBUFF_PICKLEDMEATSMOOTHIE", 172068); --"Pickled Meat Smoothie"
  GetItemInfoIfNeeded("SMARTBUFF_SERAPHTENDERS", 172061); --"Seraph Tenders"
  GetItemInfoIfNeeded("SMARTBUFF_SPINEFISHSOUFFLE", 172041); --"Spinefish Souffle and Fries"
  GetItemInfoIfNeeded("SMARTBUFF_STEAKALAMODE", 172051); --"Steak ala Mode"
  GetItemInfoIfNeeded("SMARTBUFF_SWEETSILVERGILL", 172050); --"Sweet Silvergill Sausages"
  GetItemInfoIfNeeded("SMARTBUFF_TENEBROUSCROWNROAST", 172045); --"Tenebrous Crown Roast Aspic"
  -- Dragonflight
  GetItemInfoIfNeeded("SMARTBUFF_TimelyDemise", 197778); -- Timely Demise (70 Haste)
  GetItemInfoIfNeeded("SMARTBUFF_FiletOfFangs", 197779); -- Filet of Fangs (70 Crit)
  GetItemInfoIfNeeded("SMARTBUFF_SeamothSurprise", 197780); -- Seamoth Surprise (70 Vers)
  GetItemInfoIfNeeded("SMARTBUFF_SaltBakedFishcake", 197781); -- Salt-Baked Fishcake (70 Mastery)
  GetItemInfoIfNeeded("SMARTBUFF_FeistyFishSticks", 197782); -- Feisty Fish Sticks (45 Haste/Crit)
  GetItemInfoIfNeeded("SMARTBUFF_SeafoodPlatter", 197783); -- Aromatic Seafood Platter (45 Haste/Vers)
  GetItemInfoIfNeeded("SMARTBUFF_SeafoodMedley", 197784); -- Sizzling Seafood Medley (45 Haste/Mastery)
  GetItemInfoIfNeeded("SMARTBUFF_RevengeServedCold", 197785); -- Revenge, Served Cold (45 Crit/Verst)
  GetItemInfoIfNeeded("SMARTBUFF_Tongueslicer", 197786); -- Thousandbone Tongueslicer (45 Crit/Mastery)
  GetItemInfoIfNeeded("SMARTBUFF_GreatCeruleanSea", 197787); -- Great Cerulean Sea (45 Vers/Mastery)
  GetItemInfoIfNeeded("SMARTBUFF_FatedFortuneCookie", 197792); -- Fated Fortune Cookie (76 primary stat)
  GetItemInfoIfNeeded("SMARTBUFF_KaluakBanquet", 197794); -- Feast: Grand Banquet of the Kalu'ak (76 primary stat)
  GetItemInfoIfNeeded("SMARTBUFF_HoardOfDelicacies", 197795); -- Feast: Hoard of Draconic Delicacies (76 primary stat)
  GetItemInfoIfNeeded("SMARTBUFF_DeviouslyDeviledEgg", 204072); -- Deviously Deviled Eggs

  -- Well-fed food: item ID list (S.FoodItems) for buff checks (TWW / Midnight focus; legacy IDs commented)
  S.FoodItems = GetItems({
    -- WotLK -- Deprecating
    -- 39691, 34125, 42779, 42997, 42998, 42999, 43000, 34767, 42995, 34769, 34754, 34758, 34766, 42994, 42996, 34756, 34768, 42993, 34755, 43001, 34757, 34752, 34751, 34750, 34749, 34764, 34765, 34763, 34762, 42942, 43268, 34748,
    -- CT -- Deprecating
    -- 62651, 62652, 62653, 62654, 62655, 62656, 62657, 62658, 62659, 62660, 62661, 62662, 62663, 62664, 62665, 62666, 62667, 62668, 62669, 62670, 62671, 62649,
    -- MoP -- Deprecating
    -- 74645, 74646, 74647, 74648, 74649, 74650, 74652, 74653, 74655, 74656, 86069, 86070, 86073, 86074, 81400, 81401, 81402, 81403, 81404, 81405, 81406, 81408, 81409, 81410, 81411, 81412, 81413, 81414,
    -- WoD -- Deprecating
    -- 111431, 111432, 111433, 111434, 111435, 111436, 111437, 111438, 111439, 111440, 11441, 111442, 111443, 111444, 111445, 111446, 111447, 111448, 111449, 111450, 111451, 111452, 111453, 111454,127991, 111457, 111458, 118576,
    -- TWW almost all food items
    222733, 222728, 222732, 222720, 222735, 222731, 222721, 222730, 225855, 222729, 225592, 222736, 222726, 222718, 222724, 222745, 222725, 222703, 222715, 222710, 222712, 222704,
    222727, 222722, 222711, 222705, 222708, 222707, 223968, 222713, 222723, 222714, 222702, 222709, 222719, 222717, 222716, 222706,
    -- TWW adds hearty food version to 31 the above foods that make it persist through death
    222781, 222766, 222776, 222780, 222778, 222768, 222783, 222779, 222751, 222773, 222753, 222774, 222752, 222758, 222770, 222775, 222777, 222759,
    222760, 222765, 222763, 222769, 222761, 222772, 222757, 222762, 222754, 222755, 222756, 222767, 222750, 222764, 222771,
    -- Midnight
    241316, 241312, 241310, 241314, 241318, 
  });

  -- Warlock healthstones
  GetItemInfoIfNeeded("SMARTBUFF_HEALTHSTONE", 5512); --"Healthstone"
  GetItemInfoIfNeeded("SMARTBUFF_DEMONICHEALTHSTONE", 224464); --"Demonic Healthstone"
  S.StoneWarlock = GetItems({5512, 224464});

  -- Conjured mage food IDs
  GetItemInfoIfNeeded("SMARTBUFF_CONJUREDMANA", 113509); --"Conjured Mana Buns"
  S.FoodMage = GetItems({113509, 80618, 80610, 65499, 43523, 43518, 34062, 65517, 65516, 65515, 65500, 42955});

  --_,SMARTBUFF_BCPETFOOD1          = C_Item.GetItemInfo(33874); --"Kibler's Bits (Pet food)"
  --_,SMARTBUFF_WOTLKPETFOOD1       = C_Item.GetItemInfo(43005); --"Spiced Mammoth Treats (Pet food)"

  -- Scroll table: register scroll item vars, then build SMARTBUFF_SCROLL via AddItem(...) below
  -- Scrolls: Agility, Intellect, Stamina, Spirit, Strength, Protection (I–IX)
  GetItemInfoIfNeeded("SMARTBUFF_SOAGILITY1", 3012); --"Scroll of Agility I"
  GetItemInfoIfNeeded("SMARTBUFF_SOAGILITY2", 1477); --"Scroll of Agility II"
  GetItemInfoIfNeeded("SMARTBUFF_SOAGILITY3", 4425); --"Scroll of Agility III"
  GetItemInfoIfNeeded("SMARTBUFF_SOAGILITY4", 10309); --"Scroll of Agility IV"
  GetItemInfoIfNeeded("SMARTBUFF_SOAGILITY5", 27498); --"Scroll of Agility V"
  GetItemInfoIfNeeded("SMARTBUFF_SOAGILITY6", 33457); --"Scroll of Agility VI"
  GetItemInfoIfNeeded("SMARTBUFF_SOAGILITY7", 43463); --"Scroll of Agility VII"
  GetItemInfoIfNeeded("SMARTBUFF_SOAGILITY8", 43464); --"Scroll of Agility VIII"
  GetItemInfoIfNeeded("SMARTBUFF_SOAGILITY9", 63303); --"Scroll of Agility IX"
  GetItemInfoIfNeeded("SMARTBUFF_SOINTELLECT1", 955); --"Scroll of Intellect I"
  GetItemInfoIfNeeded("SMARTBUFF_SOINTELLECT2", 2290); --"Scroll of Intellect II"
  GetItemInfoIfNeeded("SMARTBUFF_SOINTELLECT3", 4419); --"Scroll of Intellect III"
  GetItemInfoIfNeeded("SMARTBUFF_SOINTELLECT4", 10308); --"Scroll of Intellect IV"
  GetItemInfoIfNeeded("SMARTBUFF_SOINTELLECT5", 27499); --"Scroll of Intellect V"
  GetItemInfoIfNeeded("SMARTBUFF_SOINTELLECT6", 33458); --"Scroll of Intellect VI"
  GetItemInfoIfNeeded("SMARTBUFF_SOINTELLECT7", 37091); --"Scroll of Intellect VII"
  GetItemInfoIfNeeded("SMARTBUFF_SOINTELLECT8", 37092); --"Scroll of Intellect VIII"
  GetItemInfoIfNeeded("SMARTBUFF_SOINTELLECT9", 63305); --"Scroll of Intellect IX"
  GetItemInfoIfNeeded("SMARTBUFF_SOSTAMINA1", 1180); --"Scroll of Stamina I"
  GetItemInfoIfNeeded("SMARTBUFF_SOSTAMINA2", 1711); --"Scroll of Stamina II"
  GetItemInfoIfNeeded("SMARTBUFF_SOSTAMINA3", 4422); --"Scroll of Stamina III"
  GetItemInfoIfNeeded("SMARTBUFF_SOSTAMINA4", 10307); --"Scroll of Stamina IV"
  GetItemInfoIfNeeded("SMARTBUFF_SOSTAMINA5", 27502); --"Scroll of Stamina V"
  GetItemInfoIfNeeded("SMARTBUFF_SOSTAMINA6", 33461); --"Scroll of Stamina VI"
  GetItemInfoIfNeeded("SMARTBUFF_SOSTAMINA7", 37093); --"Scroll of Stamina VII"
  GetItemInfoIfNeeded("SMARTBUFF_SOSTAMINA8", 37094); --"Scroll of Stamina VIII"
  GetItemInfoIfNeeded("SMARTBUFF_SOSTAMINA9", 63306); --"Scroll of Stamina IX"
  GetItemInfoIfNeeded("SMARTBUFF_SOSPIRIT1", 1181); --"Scroll of Spirit I"
  GetItemInfoIfNeeded("SMARTBUFF_SOSPIRIT2", 1712); --"Scroll of Spirit II"
  GetItemInfoIfNeeded("SMARTBUFF_SOSPIRIT3", 4424); --"Scroll of Spirit III"
  GetItemInfoIfNeeded("SMARTBUFF_SOSPIRIT4", 10306); --"Scroll of Spirit IV"
  GetItemInfoIfNeeded("SMARTBUFF_SOSPIRIT5", 27501); --"Scroll of Spirit V"
  GetItemInfoIfNeeded("SMARTBUFF_SOSPIRIT6", 33460); --"Scroll of Spirit VI"
  GetItemInfoIfNeeded("SMARTBUFF_SOSPIRIT7", 37097); --"Scroll of Spirit VII"
  GetItemInfoIfNeeded("SMARTBUFF_SOSPIRIT8", 37098); --"Scroll of Spirit VIII"
  GetItemInfoIfNeeded("SMARTBUFF_SOSPIRIT9", 63307); --"Scroll of Spirit IX"
  GetItemInfoIfNeeded("SMARTBUFF_SOSTRENGHT1", 954); --"Scroll of Strength I"
  GetItemInfoIfNeeded("SMARTBUFF_SOSTRENGHT2", 2289); --"Scroll of Strength II"
  GetItemInfoIfNeeded("SMARTBUFF_SOSTRENGHT3", 4426); --"Scroll of Strength III"
  GetItemInfoIfNeeded("SMARTBUFF_SOSTRENGHT4", 10310); --"Scroll of Strength IV"
  GetItemInfoIfNeeded("SMARTBUFF_SOSTRENGHT5", 27503); --"Scroll of Strength V"
  GetItemInfoIfNeeded("SMARTBUFF_SOSTRENGHT6", 33462); --"Scroll of Strength VI"
  GetItemInfoIfNeeded("SMARTBUFF_SOSTRENGHT7", 43465); --"Scroll of Strength VII"
  GetItemInfoIfNeeded("SMARTBUFF_SOSTRENGHT8", 43466); --"Scroll of Strength VIII"
  GetItemInfoIfNeeded("SMARTBUFF_SOSTRENGHT9", 63304); --"Scroll of Strength IX"
  GetItemInfoIfNeeded("SMARTBUFF_SOPROTECTION9", 63308); --"Scroll of Protection IX"

  -- Misc consumables and one-off items (augment runes, toys, etc.; some used in SMARTBUFF_SCROLL)
  GetItemInfoIfNeeded("SMARTBUFF_MiscItem1", 178512); --"Celebration Package"
  GetItemInfoIfNeeded("SMARTBUFF_MiscItem2", 44986); --"Warts-B-Gone Lip Balm"
  GetItemInfoIfNeeded("SMARTBUFF_MiscItem3", 69775); --"Vrykul Drinking Horn"
  GetItemInfoIfNeeded("SMARTBUFF_MiscItem4", 86569); --"Crystal of Insanity"
  GetItemInfoIfNeeded("SMARTBUFF_MiscItem5", 85500); --"Anglers Fishing Raft"
  GetItemInfoIfNeeded("SMARTBUFF_MiscItem6", 85973); --"Ancient Pandaren Fishing Charm"
  GetItemInfoIfNeeded("SMARTBUFF_MiscItem7", 94604); --"Burning Seed"
  GetItemInfoIfNeeded("SMARTBUFF_MiscItem9", 92738); --"Safari Hat"
  GetItemInfoIfNeeded("SMARTBUFF_MiscItem10", 110424); --"Savage Safari Hat"
  GetItemInfoIfNeeded("SMARTBUFF_MiscItem11", 118922); --"Oralius' Whispering Crystal"
  GetItemInfoIfNeeded("SMARTBUFF_MiscItem12", 129192); --"Inquisitor's Menacing Eye"
  GetItemInfoIfNeeded("SMARTBUFF_MiscItem13", 129210); --"Fel Crystal Fragments"
  GetItemInfoIfNeeded("SMARTBUFF_MiscItem14", 128475); --"Empowered Augment Rune"
  GetItemInfoIfNeeded("SMARTBUFF_MiscItem15", 128482); --"Empowered Augment Rune"
  GetItemInfoIfNeeded("SMARTBUFF_MiscItem17", 147707); --"Repurposed Fel Focuser"
  --Shadowlands
  GetItemInfoIfNeeded("SMARTBUFF_AugmentRune", 190384); --"Eternal Augment Rune"
  GetItemInfoIfNeeded("SMARTBUFF_VieledAugment", 181468); --"Veiled Augment Rune"
  GetItemInfoIfNeeded("SMARTBUFF_DreamAugmentRune", 211495); --"Dreambound Augment Rune"

  --Dragonflight
  GetItemInfoIfNeeded("SMARTBUFF_DraconicRune", 201325); -- Draconic Augment Rune
  GetItemInfoIfNeeded("SMARTBUFF_VantusRune_VotI_q1", 198491); -- Vantus Rune: Vault of the Incarnates (Quality 1)
  GetItemInfoIfNeeded("SMARTBUFF_VantusRune_VotI_q2", 198492); -- Vantus Rune: Vault of the Incarnates (Quality 2)
  GetItemInfoIfNeeded("SMARTBUFF_VantusRune_VotI_q3", 198493); -- Vantus Rune: Vault of the Incarnates (Quality 3)

  GetItemInfoIfNeeded("SMARTBUFF_FLASKTBC1", 22854); --"Flask of Relentless Assault"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTBC2", 22866); --"Flask of Pure Death"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTBC3", 22851); --"Flask of Fortification"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTBC4", 22861); --"Flask of Blinding Light"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTBC5", 22853); --"Flask of Mighty Versatility"
  GetItemInfoIfNeeded("SMARTBUFF_FLASK1", 46377); --"Flask of Endless Rage"
  GetItemInfoIfNeeded("SMARTBUFF_FLASK2", 46376); --"Flask of the Frost Wyrm"
  GetItemInfoIfNeeded("SMARTBUFF_FLASK3", 46379); --"Flask of Stoneblood"
  GetItemInfoIfNeeded("SMARTBUFF_FLASK4", 46378); --"Flask of Pure Mojo"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKCT1", 58087); --"Flask of the Winds"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKCT2", 58088); --"Flask of Titanic Strength"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKCT3", 58086); --"Flask of the Draconic Mind"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKCT4", 58085); --"Flask of Steelskin"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKCT5", 67438); --"Flask of Flowing Water"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKCT7", 65455); --"Flask of Battle"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKMOP1", 75525); --"Alchemist's Flask"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKMOP2", 76087); --"Flask of the Earth"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKMOP3", 76086); --"Flask of Falling Leaves"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKMOP4", 76084); --"Flask of Spring Blossoms"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKMOP5", 76085); --"Flask of the Warm Sun"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKMOP6", 76088); --"Flask of Winter's Bite"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKWOD1", 109152); --"Draenic Stamina Flask"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKWOD2", 109148); --"Draenic Strength Flask"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKWOD3", 109147); --"Draenic Intellect Flask"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKWOD4", 109145); --"Draenic Agility Flask"
  GetItemInfoIfNeeded("SMARTBUFF_GRFLASKWOD1", 109160); --"Greater Draenic Stamina Flask"
  GetItemInfoIfNeeded("SMARTBUFF_GRFLASKWOD2", 109156); --"Greater Draenic Strength Flask"
  GetItemInfoIfNeeded("SMARTBUFF_GRFLASKWOD3", 109155); --"Greater Draenic Intellect Flask"
  GetItemInfoIfNeeded("SMARTBUFF_GRFLASKWOD4", 109153); --"Greater Draenic Agility Flask"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKLEG1", 127850); --"Flask of Ten Thousand Scars"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKLEG2", 127849); --"Flask of the Countless Armies"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKLEG3", 127847); --"Flask of the Whispered Pact"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKLEG4", 127848); --"Flask of the Seventh Demon"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKBFA1", 152639); --"Flask of Endless Fathoms"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKBFA2", 152638); --"Flask of the Currents"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKBFA3", 152641); --"Flask of the Undertow"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKBFA4", 152640); --"Flask of the Vast Horizon"
  GetItemInfoIfNeeded("SMARTBUFF_GRFLASKBFA1", 168652); --"Greather Flask of Endless Fathoms"
  GetItemInfoIfNeeded("SMARTBUFF_GRFLASKBFA2", 168651); --"Greater Flask of the Currents"
  GetItemInfoIfNeeded("SMARTBUFF_GRFLASKBFA3", 168654); --"Greather Flask of teh Untertow"
  GetItemInfoIfNeeded("SMARTBUFF_GRFLASKBFA4", 168653); --"Greater Flask of the Vast Horizon"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKSL1", 171276); --"Spectral Flask of Power"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKSL2", 171278); --"Spectral Flask of Stamina"

  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF1_q1", 191318); -- Phial of the Eye in the Storm (Quality 1)
  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF1_q2", 191319); -- Phial of the Eye in the Storm (Quality 2)
  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF1_q3", 191320); -- Phial of the Eye in the Storm (Quality 3)

  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF2_q1", 191321); -- Phial of Still Air (Quality 1)
  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF2_q2", 191322); -- Phial of Still Air (Quality 2)
  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF2_q3", 191323); -- Phial of Still Air (Quality 3)

  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF3_q1", 191324); -- Phial of Icy Preservation (Quality 1)
  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF3_q2", 191325); -- Phial of Icy Preservation (Quality 2)
  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF3_q3", 191326); -- Phial of Icy Preservation (Quality 3)

  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF4_q1", 191327); -- Iced Phial of Corrupting Rage (Quality 1)
  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF4_q2", 191328); -- Iced Phial of Corrupting Rage (Quality 2)
  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF4_q3", 191329); -- Iced Phial of Corrupting Rage (Quality 3)

  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF5_q1", 191330); -- Phial of Charged Isolation (Quality 1)
  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF5_q2", 191331); -- Phial of Charged Isolation (Quality 2)
  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF5_q3", 191332); -- Phial of Charged Isolation (Quality 3)

  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF6_q1", 191333); -- Phial of Glacial Fury (Quality 1)
  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF6_q2", 191334); -- Phial of Glacial Fury (Quality 2)
  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF6_q3", 191335); -- Phial of Glacial Fury (Quality 3)

  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF7_q1", 191336); -- Phial of Static Empowerment (Quality 1)
  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF7_q2", 191337); -- Phial of Static Empowerment (Quality 2)
  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF7_q3", 191338); -- Phial of Static Empowerment (Quality 3)

  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF8_q1", 191339); -- Phial of Tepid Versatility (Quality 1)
  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF8_q2", 191340); -- Phial of Tepid Versatility (Quality 2)
  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF8_q3", 191341); -- Phial of Tepid Versatility (Quality 3)

  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF9_q1", 191342); -- Aerated Phial of Deftness (Quality 1)
  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF9_q2", 191343); -- Aerated Phial of Deftness (Quality 2)
  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF9_q3", 191344); -- Aerated Phial of Deftness (Quality 3)

  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF10_q1", 191345); -- Steaming Phial of Finesse (Quality 1)
  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF10_q2", 191346); -- Steaming Phial of Finesse (Quality 2)
  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF10_q3", 191347); -- Steaming Phial of Finesse (Quality 3)

  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF11_q1", 191348); -- Charged Phial of Alacrity (Quality 1)
  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF11_q2", 191349); -- Charged Phial of Alacrity (Quality 2)
  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF11_q3", 191350); -- Charged Phial of Alacrity (Quality 3)

  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF12_q1", 191354); -- Crystalline Phial of Perception (Quality 1)
  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF12_q2", 191355); -- Crystalline Phial of Perception (Quality 2)
  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF12_q3", 191356); -- Crystalline Phial of Perception (Quality 3)

  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF13_q1", 191357); -- Phial of Elemental Chaos (Quality 1)
  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF13_q2", 191358); -- Phial of Elemental Chaos (Quality 2)
  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF13_q3", 191359); -- Phial of Elemental Chaos (Quality 3)

  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF14_q1", 197720); -- Aerated Phial of Quick Hands (Quality 1)
  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF14_q2", 197721); -- Aerated Phial of Quick Hands (Quality 2)
  GetItemInfoIfNeeded("SMARTBUFF_FlaskDF14_q3", 197722); -- Aerated Phial of Quick Hands (Quality 3)

  GetItemInfoIfNeeded("SMARTBUFF_ELIXIRTBC1", 22831); --"Elixir of Major Agility"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIRTBC2", 28104); --"Elixir of Mastery"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIRTBC3", 22825); --"Elixir of Healing Power"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIRTBC4", 22834); --"Elixir of Major Defense"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIRTBC5", 22824); --"Elixir of Major Strangth"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIRTBC6", 32062); --"Elixir of Major Fortitude"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIRTBC7", 22840); --"Elixir of Major Mageblood"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIRTBC8", 32067); --"Elixir of Draenic Wisdom"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIRTBC9", 28103); --"Adept's Elixir"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIRTBC10", 22848); --"Elixir of Empowerment"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIRTBC11", 28102); --"Onslaught Elixir"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIRTBC12", 22835); --"Elixir of Major Shadow Power"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIRTBC13", 32068); --"Elixir of Ironskin"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIRTBC14", 32063); --"Earthen Elixir"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIRTBC15", 22827); --"Elixir of Major Frost Power"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIRTBC16", 31679); --"Fel Strength Elixir"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIRTBC17", 22833); --"Elixir of Major Firepower"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIR1", 39666); --"Elixir of Mighty Agility"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIR2", 44332); --"Elixir of Mighty Thoughts"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIR3", 40078); --"Elixir of Mighty Fortitude"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIR4", 40073); --"Elixir of Mighty Strength"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIR5", 40072); --"Elixir of Spirit"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIR6", 40097); --"Elixir of Protection"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIR7", 44328); --"Elixir of Mighty Defense"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIR8", 44331); --"Elixir of Lightning Speed"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIR9", 44329); --"Elixir of Expertise"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIR10", 44327); --"Elixir of Deadly Strikes"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIR11", 44330); --"Elixir of Armor Piercing"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIR12", 44325); --"Elixir of Accuracy"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIR13", 40076); --"Guru's Elixir"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIR14", 9187); --"Elixir of Greater Agility"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIR15", 28103); --"Adept's Elixir"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIR16", 40070); --"Spellpower Elixir"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIRCT1", 58148); --"Elixir of the Master"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIRCT2", 58144); --"Elixir of Mighty Speed"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIRCT3", 58094); --"Elixir of Impossible Accuracy"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIRCT4", 58143); --"Prismatic Elixir"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIRCT5", 58093); --"Elixir of Deep Earth"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIRCT6", 58092); --"Elixir of the Cobra"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIRCT7", 58089); --"Elixir of the Naga"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIRCT8", 58084); --"Ghost Elixir"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIRMOP1", 76081); --"Elixir of Mirrors"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIRMOP2", 76079); --"Elixir of Peace"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIRMOP3", 76080); --"Elixir of Perfection"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIRMOP4", 76078); --"Elixir of the Rapids"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIRMOP5", 76077); --"Elixir of Weaponry"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIRMOP6", 76076); --"Mad Hozen Elixir"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIRMOP7", 76075); --"Mantid Elixir"
  GetItemInfoIfNeeded("SMARTBUFF_ELIXIRMOP8", 76083); --"Monk's Elixir"

-- TWW
  -- Consumables
  GetItemInfoIfNeeded("SMARTBUFF_TWWCrystalAugRune1", 224572); --"Crystallized Augment Rune"
  GetItemInfoIfNeeded("SMARTBUFF_TWWEtherealAugRune", 243191); --"Ethereal Augment Rune"

  -- Flasks and phials
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW1_Q1", 212269); --"Flask of Tempered Aggression"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW1_Q2", 212270); --"Flask of Tempered Aggression"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW1_Q3", 212271); --"Flask of Tempered Aggression"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW2_Q1", 212272); --"Flask of Tempered Swiftness"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW2_Q2", 212273); --"Flask of Tempered Swiftness"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW2_Q3", 212274); --"Flask of Tempered Swiftness"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW3_Q1", 212275); --"Flask of Tempered Versatility"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW3_Q2", 212276); --"Flask of Tempered Versatility"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW3_Q3", 212277); --"Flask of Tempered Versatility"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW4_Q1", 212278); --"Flask of Tempered Mastery"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW4_Q2", 212279); --"Flask of Tempered Mastery"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW4_Q3", 212280); --"Flask of Tempered Mastery"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW5_Q1", 212281); --"Flask of Alchemical Chaos"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW5_Q2", 212282); --"Flask of Alchemical Chaos"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW5_Q3", 212283); --"Flask of Alchemical Chaos"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWWPvP_1", 212289); --"Vicious Flask of Classical Spirits"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWWPvP_2", 212292); --"Vicious Flask of Honor"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWWPvP_3", 212295); --"Vicious Flask of Manifested Fury"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWWPvP_4", 212298); --"Vicious Flask of the Wrecking Ball"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW6_Q1", 212299); --"Flask of Saving Graces"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW6_Q2", 212300); --"Flask of Saving Graces"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW6_Q3", 212301); --"Flask of Saving Graces"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW7_Q1", 212305); --"Phial of Concentrated Ingenuity"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW7_Q2", 212306); --"Phial of Concentrated Ingenuity"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW7_Q3", 212307); --"Phial of Concentrated Ingenuity"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW8_Q1", 212308); --"Phial of Truesight"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW8_Q2", 212309); --"Phial of Truesight"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW8_Q3", 212310); --"Phial of Truesight"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW9_Q1", 212311); --"Phial of Enhanced Ambidexterity"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW9_Q2", 212312); --"Phial of Enhanced Ambidexterity"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW9_Q3", 212313); --"Phial of Enhanced Ambidexterity"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW10_Q1", 212314); --"Phial of Bountiful Seasons"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW10_Q2", 212315); --"Phial of Bountiful Seasons"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW10_Q3", 212316); --"Phial of Bountiful Seasons"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW11_Q1", 212725); --"Fleeting Flask of Tempered Aggression"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW11_Q2", 212727); --"Fleeting Flask of Tempered Aggression"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW11_Q3", 212728); --"Fleeting Flask of Tempered Aggression"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW12_Q1", 212729); --"Fleeting Flask of Tempered Swiftness"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW12_Q2", 212730); --"Fleeting Flask of Tempered Swiftness"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW12_Q3", 212731); --"Fleeting Flask of Tempered Swiftness"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW13_Q1", 212732); --"Fleeting Flask of Tempered Versatility"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW13_Q2", 212733); --"Fleeting Flask of Tempered Versatility"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW13_Q3", 212734); --"Fleeting Flask of Tempered Versatility"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW14_Q1", 212735); --"Fleeting Flask of Tempered Mastery"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW14_Q2", 212736); --"Fleeting Flask of Tempered Mastery"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW14_Q3", 212738); --"Fleeting Flask of Tempered Mastery"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW15_Q1", 212739); --"Fleeting Flask of Alchemical Chaos"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW15_Q2", 212740); --"Fleeting Flask of Alchemical Chaos"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW15_Q3", 212741); --"Fleeting Flask of Alchemical Chaos"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW16_Q1", 212745); --"Fleeting Flask of Saving Graces"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW16_Q2", 212746); --"Fleeting Flask of Saving Graces"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKTWW16_Q3", 212747); --"Fleeting Flask of Saving Graces"
  -- midnight flasks
  GetItemInfoIfNeeded("SMARTBUFF_FLASKMIDN1", 241326); --"Flask of the shattered sun"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKMIDN2", 241324); --"Flask of the blood knights"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKMIDN3", 241320); --"Flask of the Thalassian Resistance"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKMIDN4", 241322); --"Flask of Magisters"
  GetItemInfoIfNeeded("SMARTBUFF_FLASKMIDN5", 241334); --"Vicious Thalassian Flask of Honor"

  -- Draught of Ten Lands (consumable)
  GetItemInfoIfNeeded("SMARTBUFF_EXP_POTION", 166750); --"Draught of Ten Lands"

  -- Fishing pole: S.FishingPole for CHECKFISHINGPOLE (special case: 7th return from GetItemInfo)
  if (S.FishingPole == nil) then
    local _, _, _, _, _, _, fishingPole = C_Item.GetItemInfo(6256);
    if (fishingPole) then
      S.FishingPole = fishingPole;
    end
  end

  SMARTBUFF_AddMsgD("Item list initialized");
  -- Load toybox so TOY buff type can resolve items; settings preserved even if option is off.
  SMARTBUFF_LoadToys();
end

-- ---------------------------------------------------------------------------
-- Init: spell IDs and buff relationship tables (S.Link*, S.Chain*)
-- ---------------------------------------------------------------------------
function SMARTBUFF_InitSpellIDs()
  local isSpellBookBuff = true  -- true for spellbook spells, false for item spells
  -- Restore chains and links from cache first (AllTheThings pattern: use cache when live data not available)
  SMARTBUFF_LoadBuffRelationsCache();
  
  -- Only call API if variable is not already set (optimization: skip if already loaded and verified)
  GetSpellInfoIfNeeded("SMARTBUFF_TESTSPELL", 774, isSpellBookBuff );

  -- Druid
  GetSpellInfoIfNeeded("SMARTBUFF_DRUID_CAT", 768, isSpellBookBuff); --"Cat Form"
  GetSpellInfoIfNeeded("SMARTBUFF_DRUID_TREE", 33891, isSpellBookBuff); --"Incarnation: Tree of Life"
  GetSpellInfoIfNeeded("SMARTBUFF_DRUID_TREANT", 114282, isSpellBookBuff); --"Treant Form"
  GetSpellInfoIfNeeded("SMARTBUFF_DRUID_MOONKIN", 24858, isSpellBookBuff); --"Moonkin Form"
  GetSpellInfoIfNeeded("SMARTBUFF_DRUID_BEAR", 5487, isSpellBookBuff); --"Bear Form"
  GetSpellInfoIfNeeded("SMARTBUFF_MOTW", 1126, isSpellBookBuff); --"Mark of the Wild"
  GetSpellInfoIfNeeded("SMARTBUFF_BARKSKIN", 22812, isSpellBookBuff); --"Barkskin"
  GetSpellInfoIfNeeded("SMARTBUFF_TIGERSFURY", 5217, isSpellBookBuff); --"Tiger's Fury"

  -- Priest
  GetSpellInfoIfNeeded("SMARTBUFF_PWF", 21562, isSpellBookBuff); --"Power Word: Fortitude"
  GetSpellInfoIfNeeded("SMARTBUFF_PWS", 17, isSpellBookBuff); --"Power Word: Shield"
  GetSpellInfoIfNeeded("SMARTBUFF_LEVITATE", 1706, isSpellBookBuff); --"Levitate"
  GetSpellInfoIfNeeded("SMARTBUFF_SHADOWFORM", 232698, isSpellBookBuff); --"Shadowform"
  GetSpellInfoIfNeeded("SMARTBUFF_VAMPIRICEMBRACE", 15286, isSpellBookBuff); --"Vampiric Embrace"
  -- Priest buff links
  --S.LinkPriestChakra        = { SMARTBUFF_CHAKRA1, SMARTBUFF_CHAKRA2, SMARTBUFF_CHAKRA3 };

  -- Mage
  GetSpellInfoIfNeeded("SMARTBUFF_AB", 1459, isSpellBookBuff); --"Arcane Intellect"
  GetSpellInfoIfNeeded("SMARTBUFF_ICEBARRIER", 11426, isSpellBookBuff); --"Ice Barrier"
  GetSpellInfoIfNeeded("SMARTBUFF_COMBUSTION", 190319, isSpellBookBuff); --"Combustion"
  GetSpellInfoIfNeeded("SMARTBUFF_PRESENCEOFMIND", 205025, isSpellBookBuff); --"Presence of Mind"
  GetSpellInfoIfNeeded("SMARTBUFF_SLOWFALL", 130, isSpellBookBuff); --"Slow Fall"
  GetSpellInfoIfNeeded("SMARTBUFF_REFRESHMENT", 190336, isSpellBookBuff); --"Conjure Refreshment"
  GetSpellInfoIfNeeded("SMARTBUFF_PRISBARRIER", 235450, isSpellBookBuff); --"Prismatic Barrier"
  GetSpellInfoIfNeeded("SMARTBUFF_BLAZBARRIER", 235313, isSpellBookBuff); --"Blazing Barrier"
  GetSpellInfoIfNeeded("SMARTBUFF_SUMMONWATERELELEMENTAL", 31687, isSpellBookBuff); -- Summon Water Elemental

  -- Mage buff links
 -- S.ChainMageArmor = { SMARTBUFF_FROSTARMOR, SMARTBUFF_MAGEARMOR, SMARTBUFF_MOLTENARMOR };

  -- Warlock
  GetSpellInfoIfNeeded("SMARTBUFF_UNENDINGBREATH", 5697, isSpellBookBuff); --"Unending Breath"
  GetSpellInfoIfNeeded("SMARTBUFF_LIFETAP", 1454, isSpellBookBuff); --"Life Tap"
  GetSpellInfoIfNeeded("SMARTBUFF_CREATEHS", 6201, isSpellBookBuff); --"Create Healthstone" (creates either regular or demonic based on talents)
  GetSpellInfoIfNeeded("SMARTBUFF_CREATEHSWELL", 29893, isSpellBookBuff); --"Create Soulwell"
  GetSpellInfoIfNeeded("SMARTBUFF_SOULSTONE", 20707, isSpellBookBuff); --"Soulstone"
  GetSpellInfoIfNeeded("SMARTBUFF_GOSACRIFICE", 108503, isSpellBookBuff); --"Grimoire of Sacrifice"
  -- Warlock pets
  GetSpellInfoIfNeeded("SMARTBUFF_SUMMONIMP", 688, isSpellBookBuff); --"Summon Imp"
  GetSpellInfoIfNeeded("SMARTBUFF_SUMMONFELHUNTER", 691, isSpellBookBuff); --"Summon Fellhunter"
  GetSpellInfoIfNeeded("SMARTBUFF_SUMMONVOIDWALKER", 697, isSpellBookBuff); --"Summon Voidwalker"
  GetSpellInfoIfNeeded("SMARTBUFF_SUMMONSUCCUBUS", 366222, isSpellBookBuff); --"Summon Succubus/Incubus"
  GetSpellInfoIfNeeded("SMARTBUFF_SUMMONFELGUARD", 30146, isSpellBookBuff); --"Summon Felguard"
  GetSpellInfoIfNeeded("SMARTBUFF_DEMONICTYRANT", 265187, isSpellBookBuff); --"Summon Demonic Tyrant"

  -- Hunter
--  SMARTBUFF_TRUESHOTAURA    = getSpellBookItemByName(288613); --"Trueshot Aura" (P) -- candidate for deletion (spell doesn't exist in retail WoW)
  GetSpellInfoIfNeeded("SMARTBUFF_VOLLEY", 260243, isSpellBookBuff); --"Volley"
  GetSpellInfoIfNeeded("SMARTBUFF_RAPIDFIRE", 257044, isSpellBookBuff); --"Rapid Fire"
  GetSpellInfoIfNeeded("SMARTBUFF_AOTC", 186257, isSpellBookBuff); --"Aspect of the Cheetah"
  GetSpellInfoIfNeeded("SMARTBUFF_AOTW", 193530, isSpellBookBuff); --"Aspect of the Wild"
  GetSpellInfoIfNeeded("SMARTBUFF_AOTE", 186289, isSpellBookBuff); --"Aspect of the Eagle"
  -- Hunter pets
  GetSpellInfoIfNeeded("SMARTBUFF_CALL_PET_1", 883, isSpellBookBuff); -- "Call Pet 1"
  GetSpellInfoIfNeeded("SMARTBUFF_CALL_PET_2", 83242, isSpellBookBuff); -- "Call Pet 2"
  GetSpellInfoIfNeeded("SMARTBUFF_CALL_PET_3", 83243, isSpellBookBuff); -- "Call Pet 3"
  GetSpellInfoIfNeeded("SMARTBUFF_CALL_PET_4", 83244, isSpellBookBuff); -- "Call Pet 4"
  GetSpellInfoIfNeeded("SMARTBUFF_CALL_PET_5", 83245, isSpellBookBuff); -- "Call Pet 5"
  -- Hunter buff links
  S.LinkAspects = { 186257, 193530, 186289 }; -- Aspect of the Cheetah, Wild, Eagle
--  S.LinkAmmo     = { SMARTBUFF_AMMOI, SMARTBUFF_AMMOP, SMARTBUFF_AMMOF };
--  S.LinkLoneWolf = { SMARTBUFF_LW1, SMARTBUFF_LW2, SMARTBUFF_LW3, SMARTBUFF_LW4, SMARTBUFF_LW5, SMARTBUFF_LW6, SMARTBUFF_LW7, SMARTBUFF_LW8 };

  -- Shaman
  GetSpellInfoIfNeeded("SMARTBUFF_LIGHTNINGSHIELD", 192106, isSpellBookBuff); --"Lightning Shield"
  GetSpellInfoIfNeeded("SMARTBUFF_WATERSHIELD", 52127, isSpellBookBuff); --"Water Shield"
  GetSpellInfoIfNeeded("SMARTBUFF_EARTHSHIELD", 974, isSpellBookBuff); --"Earth Shield"
  GetSpellInfoIfNeeded("SMARTBUFF_WATERWALKING", 546, isSpellBookBuff); --"Water Walking"
  --GetSpellInfoIfNeeded("SMARTBUFF_EMASTERY", 16166, isSpellBookBuff); --"Elemental Mastery"
  GetSpellInfoIfNeeded("SMARTBUFF_ASCENDANCE_ELE", 114050, isSpellBookBuff); --"Ascendance (Elemental)"
  GetSpellInfoIfNeeded("SMARTBUFF_ASCENDANCE_ENH", 114051, isSpellBookBuff); --"Ascendance (Enhancement)"
  GetSpellInfoIfNeeded("SMARTBUFF_ASCENDANCE_RES", 114052, isSpellBookBuff); --"Ascendance (Restoration)"
  GetSpellInfoIfNeeded("SMARTBUFF_WINDFURYW", 33757, isSpellBookBuff); --"Windfury Weapon"
  GetSpellInfoIfNeeded("SMARTBUFF_FLAMETONGUEW", 318038, isSpellBookBuff); --"Flametongue Weapon"
  GetSpellInfoIfNeeded("SMARTBUFF_EVERLIVINGW", 382021, isSpellBookBuff); --"Everliving Weapon"
  GetSpellInfoIfNeeded("SMARTBUFF_SKYFURY", 462854, isSpellBookBuff); --"Skyfury"
  GetSpellInfoIfNeeded("SMARTBUFF_TSWARD", 462760, isSpellBookBuff); --"Thunderstrike Ward" -- Shield
  GetSpellInfoIfNeeded("SMARTBUFF_TIDEGUARD", 457481, isSpellBookBuff); --"Tidecaller's Guard" -- Shield. Replaces Flametongue Weapon

  -- Shaman buff links
  S.ChainShamanShield = { 192106, 52127, 974 }; -- Lightning Shield, Water Shield, Earth Shield

  -- Warrior
  GetSpellInfoIfNeeded("SMARTBUFF_BATTLESHOUT", 6673, isSpellBookBuff); --"Battle Shout"
  --SMARTBUFF_COMMANDINGSHOUT = getSpellBookItemByName(97462);    --"Reallying Cry"
  GetSpellInfoIfNeeded("SMARTBUFF_BERSERKERRAGE", 18499, isSpellBookBuff); --"Berserker Rage"
  GetSpellInfoIfNeeded("SMARTBUFF_BATSTANCE", 386164, isSpellBookBuff); --"Battle Stance"
  GetSpellInfoIfNeeded("SMARTBUFF_DEFSTANCE", 386208, isSpellBookBuff); --"Defensive Stance"
  GetSpellInfoIfNeeded("SMARTBUFF_BERSERKSTANCE", 386196, isSpellBookBuff); --"Berserker Stance"
--  SMARTBUFF_GLADSTANCE      = getSpellBookItemByName(156291); --"Gladiator Stance"
  GetSpellInfoIfNeeded("SMARTBUFF_SHIELDBLOCK", 2565, isSpellBookBuff); --"Shield Block"
  GetSpellInfoIfNeeded("SMARTBUFF_WARAVATAR", 107574, isSpellBookBuff); --"Avatar"

  -- Warrior buff chains (spell IDs so chains don't depend on globals at assembly time)
  S.ChainWarriorStance = { 386164, 386208, 386196 }; -- Battle Stance, Defensive Stance, Berserker Stance
  S.ChainWarriorShout  = { 6673 }; -- Battle Shout

  -- Rogue
  GetSpellInfoIfNeeded("SMARTBUFF_STEALTH", 1784, isSpellBookBuff); --"Stealth"
  GetSpellInfoIfNeeded("SMARTBUFF_BLADEFLURRY", 13877, isSpellBookBuff); --"Blade Flurry"
  GetSpellInfoIfNeeded("SMARTBUFF_SAD", 315496, isSpellBookBuff); --"Slice and Dice"
  GetSpellInfoIfNeeded("SMARTBUFF_EVASION", 5277, isSpellBookBuff); --"Evasion"
--  SMARTBUFF_HUNGERFORBLOOD  = getSpellBookItemByName(60177); --"Hunger For Blood"
  GetSpellInfoIfNeeded("SMARTBUFF_TRICKS", 57934, isSpellBookBuff); --"Tricks of the Trade"
  GetSpellInfoIfNeeded("SMARTBUFF_RECUPERATE", 185311, isSpellBookBuff); --"Crimson Vial
  -- Poisons
  GetSpellInfoIfNeeded("SMARTBUFF_WOUNDPOISON", 8679, isSpellBookBuff); --"Wound Poison"
  GetSpellInfoIfNeeded("SMARTBUFF_CRIPPLINGPOISON", 3408, isSpellBookBuff); --"Crippling Poison"
  GetSpellInfoIfNeeded("SMARTBUFF_DEADLYPOISON", 2823, isSpellBookBuff); --"Deadly Poison"
--  SMARTBUFF_LEECHINGPOISON      = getSpellBookItemByName(108211); --"Leeching Poison"
  GetSpellInfoIfNeeded("SMARTBUFF_INSTANTPOISON", 315584, isSpellBookBuff); --"Instant Poison"
  GetSpellInfoIfNeeded("SMARTBUFF_NUMBINGPOISON", 5761, isSpellBookBuff); --"Numbing Poison"
  GetSpellInfoIfNeeded("SMARTBUFF_AMPLIFYPOISON", 381664, isSpellBookBuff); --"Amplifying Poison"
  GetSpellInfoIfNeeded("SMARTBUFF_ATROPHICPOISON", 381637, isSpellBookBuff); --"Atrophic Poison"

  -- Rogue buff links
  S.ChainRoguePoisonsLethal     = { 8679, 315584, 381664, 2823 }; -- Wound, Instant, Amplifying, Deadly Poison
  S.ChainRoguePoisonsNonLethal = { 3408, 5761, 381637 }; -- Crippling, Numbing, Atrophic Poison

  -- Rogue Assassination talent Dragon-Tempered Blades (381801): allows 2 of each poison type; chains make poisons exclusive (1 per chain). When talent is known, ignore poison chains so addon doesn't treat "already have one" as "don't cast another".
  SMARTBUFF_ROGUE_DRAGON_TEMPERED_BLADES_SPELL_ID = 381801;
  function SMARTBUFF_RogueHasDragonTemperedBlades()
    local id = SMARTBUFF_ROGUE_DRAGON_TEMPERED_BLADES_SPELL_ID;
    if (C_SpellBook and C_SpellBook.IsSpellKnownOrInSpellBook and C_SpellBook.IsSpellKnownOrInSpellBook(id)) then return true; end
    if (IsSpellKnown and IsSpellKnown(id)) then return true; end
    return false;
  end
  -- Compare chain content (same length, same values per index); entries may be number or string (e.g. spell ID vs name).
  local function chainContentEqual(a, b)
    if (not a or not b or type(a) ~= "table" or type(b) ~= "table" or #a ~= #b) then return false; end
    for i = 1, #a do
      local va, vb = a[i], b[i];
      if (va ~= vb) then
        local na, nb = tonumber(va) or va, tonumber(vb) or vb;
        if (na ~= nb) then return false; end
      end
    end
    return true;
  end
  function SMARTBUFF_IsRoguePoisonChain(chain)
    return chainContentEqual(chain, S.ChainRoguePoisonsLethal) or chainContentEqual(chain, S.ChainRoguePoisonsNonLethal);
  end

  -- Paladin
  GetSpellInfoIfNeeded("SMARTBUFF_RIGHTEOUSFURY", 25780, isSpellBookBuff); --"Righteous Fury"
  GetSpellInfoIfNeeded("SMARTBUFF_HOF", 1044, isSpellBookBuff); --"Blessing of Freedom"
  GetSpellInfoIfNeeded("SMARTBUFF_HOP", 1022, isSpellBookBuff); --"Blessing of Protection"
  GetSpellInfoIfNeeded("SMARTBUFF_BEACONOFLIGHT", 53563, isSpellBookBuff); --"Beacon of Light"
  GetSpellInfoIfNeeded("SMARTBUFF_BEACONOFAITH", 156910, isSpellBookBuff); --"Beacon of Faith"
  GetSpellInfoIfNeeded("SMARTBUFF_BEACONOFVIRTUE", 200025, isSpellBookBuff); --"Beacon of Virtue"
  GetSpellInfoIfNeeded("SMARTBUFF_CRUSADERAURA", 32223, isSpellBookBuff); --"Crusader Aura"
  GetSpellInfoIfNeeded("SMARTBUFF_DEVOTIONAURA", 465, isSpellBookBuff); --"Devotion Aura"
  GetSpellInfoIfNeeded("SMARTBUFF_CONCENTRATIONAURA", 317920, isSpellBookBuff); --"Concentration Aura"
  GetSpellInfoIfNeeded("SMARTBUFF_RITEOFSANTIFICATION", 433568, true); --"Right of Sanctification, Hero"
  GetSpellInfoIfNeeded("SMARTBUFF_RITEOFADJURATION", 433583, isSpellBookBuff); --"Right of Adjuration, Hero"
  -- Paladin buff links
  S.ChainPaladinAura = { 32223, 465, 317920 }; -- Crusader Aura, Devotion Aura, Concentration Aura

  -- Death Knight
  GetSpellInfoIfNeeded("SMARTBUFF_DANCINGRW", 49028, isSpellBookBuff); --"Dancing Rune Weapon"
--  SMARTBUFF_BLOODPRESENCE     = getSpellBookItemByName(48263); --"Blood Presence"
--  SMARTBUFF_FROSTPRESENCE     = getSpellBookItemByName(48266); --"Frost Presence"
--  SMARTBUFF_UNHOLYPRESENCE    = getSpellBookItemByName(48265); --"Unholy Presence"
  GetSpellInfoIfNeeded("SMARTBUFF_PATHOFFROST", 3714, isSpellBookBuff); --"Path of Frost"
--  SMARTBUFF_BONESHIELD        = getSpellBookItemByName(49222); --"Bone Shield"
--  SMARTBUFF_HORNOFWINTER      = getSpellBookItemByName(57330); --"Horn of Winter"
  GetSpellInfoIfNeeded("SMARTBUFF_RAISEDEAD", 46584, isSpellBookBuff); --"Raise Dead"
--  SMARTBUFF_POTGRAVE          = getSpellBookItemByName(155522); --"Power of the Grave" (P)
  -- Death Knight buff links
--  S.ChainDKPresence = { SMARTBUFF_BLOODPRESENCE, SMARTBUFF_FROSTPRESENCE, SMARTBUFF_UNHOLYPRESENCE };

  -- Monk
  GetSpellInfoIfNeeded("SMARTBUFF_BLACKOX", 115315, isSpellBookBuff); --"Summon Black Ox Statue"
  GetSpellInfoIfNeeded("SMARTBUFF_JADESERPENT", 115313, isSpellBookBuff); --"Summon Jade Serpent Statue"
  -- Monk buff links
  S.ChainMonkStatue = { 115315, 115313 }; -- Summon Black Ox Statue, Summon Jade Serpent Statue
--  S.ChainMonkStance = { SMARTBUFF_SOTFIERCETIGER, SMARTBUFF_SOTSTURDYOX, SMARTBUFF_SOTWISESERPENT, SMARTBUFF_SOTSPIRITEDCRANE };

  -- Evoker
  GetSpellInfoIfNeeded("SMARTBUFF_BRONZEBLESSING", 364342, isSpellBookBuff); --"Blessing of the Bronze"
  GetSpellInfoIfNeeded("SMARTBUFF_SENSEPOWER", 361021, isSpellBookBuff); --"Sense Power"
  GetSpellInfoIfNeeded("SMARTBUFF_SourceOfMagic", 369459, isSpellBookBuff); --"Source of Magic"
  GetSpellInfoIfNeeded("SMARTBUFF_EbonMight", 395152, isSpellBookBuff); --"Ebon Might"
  GetSpellInfoIfNeeded("SMARTBUFF_BlisteringScale", 360827, isSpellBookBuff); --"Blistering Scales"
  GetSpellInfoIfNeeded("SMARTBUFF_Timelessness", 412710, isSpellBookBuff); --"Timelessness"
  GetSpellInfoIfNeeded("SMARTBUFF_BronzeAttunement", 403265, isSpellBookBuff); --"Bronze Attunement"
  GetSpellInfoIfNeeded("SMARTBUFF_BlackAttunement", 403264, isSpellBookBuff); --"Black Attunement"

  -- Demon Hunter

  -- Tracking -- this is deprecated due to moving to minimap
  GetSpellInfoIfNeeded("SMARTBUFF_FINDMINERALS", 2580, isSpellBookBuff); --"Find Minerals"
  GetSpellInfoIfNeeded("SMARTBUFF_FINDHERBS", 2383, isSpellBookBuff); --"Find Herbs"
  GetSpellInfoIfNeeded("SMARTBUFF_FINDTREASURE", 2481, isSpellBookBuff); --"Find Treasure"
  GetSpellInfoIfNeeded("SMARTBUFF_TRACKHUMANOIDS", 19883, isSpellBookBuff); --"Track Humanoids"
  GetSpellInfoIfNeeded("SMARTBUFF_TRACKBEASTS", 1494, isSpellBookBuff); --"Track Beasts"
  GetSpellInfoIfNeeded("SMARTBUFF_TRACKUNDEAD", 19884, isSpellBookBuff); --"Track Undead"
  GetSpellInfoIfNeeded("SMARTBUFF_TRACKHIDDEN", 19885, isSpellBookBuff); --"Track Hidden"
  GetSpellInfoIfNeeded("SMARTBUFF_TRACKELEMENTALS", 19880, isSpellBookBuff); --"Track Elementals"
  GetSpellInfoIfNeeded("SMARTBUFF_TRACKDEMONS", 19878, isSpellBookBuff); --"Track Demons"
  GetSpellInfoIfNeeded("SMARTBUFF_TRACKGIANTS", 19882, isSpellBookBuff); --"Track Giants"
  GetSpellInfoIfNeeded("SMARTBUFF_TRACKDRAGONKIN", 19879, isSpellBookBuff); --"Track Dragonkin"

  -- Racial
  GetSpellInfoIfNeeded("SMARTBUFF_STONEFORM", 20594,  isSpellBookBuff); --"Stoneform"
  GetSpellInfoIfNeeded("SMARTBUFF_BLOODFURY", 20572, isSpellBookBuff); --"Blood Fury" 33697, 33702
  GetSpellInfoIfNeeded("SMARTBUFF_BERSERKING", 26297, isSpellBookBuff); --"Berserking"
  GetSpellInfoIfNeeded("SMARTBUFF_WOTFORSAKEN", 7744, isSpellBookBuff); --"Will of the Forsaken"
  GetSpellInfoIfNeeded("SMARTBUFF_WarStomp", 20549, isSpellBookBuff); --"War Stomp"
  GetSpellInfoIfNeeded("SMARTBUFF_Visage", 351239, isSpellBookBuff); --"Evoker Visage"

  -- Eating & Drinking (Generic)
  GetSpellInfoDirectIfNeeded("SMARTBUFF_EatingAura", 433); --"Food"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_DrinkingAura", 430); --"Drink"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_FoodDrinkAura", 192002); --"Food & Drink"
  -- Well Fed (Generic)
  GetSpellInfoDirectIfNeeded("SMARTBUFF_WellFedAura", 46899); --"Well Fed"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_HeartyFedAura", 462181); --"Hearty Well Fed"
  
  -- Misc
  GetSpellInfoDirectIfNeeded("SMARTBUFF_KIRUSSOV", 46302); --"K'iru's Song of Victory"
  -- Special case: FISHING has fallback spell ID
  if (SMARTBUFF_FISHING == nil) then
    SMARTBUFF_FISHING = C_Spell.GetSpellInfo(450647) or C_Spell.GetSpellInfo(131476);
  end

  -- Scroll
  GetSpellInfoDirectIfNeeded("SMARTBUFF_SBAGILITY", 8115); --"Scroll buff: Agility"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_SBINTELLECT", 8096); --"Scroll buff: Intellect"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_SBSTAMINA", 8099); --"Scroll buff: Stamina"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_SBSPIRIT", 8112); --"Scroll buff: Spirit"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_SBSTRENGHT", 8118); --"Scroll buff: Strength"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_SBPROTECTION", 89344); --"Scroll buff: Armor"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BMiscItem1", 326396); --"WoW's 16th Anniversary"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BMiscItem2", 62574); --"Warts-B-Gone Lip Balm"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BMiscItem3", 98444); --"Vrykul Drinking Horn"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BMiscItem4", 127230); --"Visions of Insanity"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BMiscItem5", 124036); --"Anglers Fishing Raft"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BMiscItem6", 125167); --"Ancient Pandaren Fishing Charm"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BMiscItem7", 138927); --"Burning Essence"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BMiscItem8", 160331); --"Blood Elf Illusion"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BMiscItem9", 158486); --"Safari Hat"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BMiscItem10", 158474); --"Savage Safari Hat"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BMiscItem11", 176151); --"Whispers of Insanity"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BMiscItem12", 193456); --"Gaze of the Legion"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BMiscItem13", 193547); --"Fel Crystal Infusion"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BMiscItem14", 190668); --"Empower"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BMiscItem14_1", 175457); --"Focus Augmentation"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BMiscItem14_2", 175456); --"Hyper Augmentation"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BMiscItem14_3", 175439); --"Stout Augmentation
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BMiscItem16", 181642); --"Bodyguard Miniaturization Device"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BMiscItem17", 242551); --"Fel Focus"
  -- Shadowlands
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BAugmentRune", 367405); --"Eternal Augmentation from Eternal Augment Rune"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BVieledAugment", 347901); --"Veiled Augmentation from Veiled Augment Rune"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BDreamAugmentRune", 393438); --"Dream Augmentation from Dream Augment Rune"
  -- Dragonflight
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BDraconicRune", 393438); -- Draconic Augmentation from Draconic Augment Rune
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BVantusRune_VotI_q1", 384154); -- Vantus Rune: Vault of the Incarnates (Quality 1)
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BVantusRune_VotI_q2", 384248); -- Vantus Rune: Vault of the Incarnates (Quality 2)
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BVantusRune_VotI_q3", 384306); -- Vantus Rune: Vault of the Incarnates (Quality 3)
  -- TWW
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BTWWCrystalAugRune1", 453250); -- Crystallization/Crystallized Augment Rune
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BTWWEtherealAugRune", 1234969); -- Ethereal Augmentation from Ethereal Augment Rune

  -- Links as spell IDs so links don't depend on globals at assembly time
  S.LinkSafariHat = { 158486, 158474 }; -- Safari Hat, Savage Safari Hat (spell IDs)
  S.LinkAugment   = { 190668, 175457, 175456, 175439, 367405, 347901, 393438, 393438, 453250, 1234969 }; -- Empower/Focus/Hyper/Stout, Eternal/Veiled/Dream/Draconic/Crystal/Ethereal augment runes

  -- Flasks & Elixirs
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKTBC1", 28520); --"Flask of Relentless Assault"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKTBC2", 28540); --"Flask of Pure Death"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKTBC3", 28518); --"Flask of Fortification"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKTBC4", 28521); --"Flask of Blinding Light"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKTBC5", 28519); --"Flask of Mighty Versatility"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASK1", 53760); --"Flask of Endless Rage"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASK2", 53755); --"Flask of the Frost Wyrm"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASK3", 53758); --"Flask of Stoneblood"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASK4", 54212); --"Flask of Pure Mojo"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKCT1", 79471); --"Flask of the Winds"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKCT2", 79472); --"Flask of Titanic Strength"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKCT3", 79470); --"Flask of the Draconic Mind"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKCT4", 79469); --"Flask of Steelskin"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKCT5", 94160); --"Flask of Flowing Water"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKCT7", 92679); --"Flask of Battle"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKMOP1", 105617); --"Alchemist's Flask"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKMOP2", 105694); --"Flask of the Earth"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKMOP3", 105693); --"Flask of Falling Leaves"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKMOP4", 105689); --"Flask of Spring Blossoms"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKMOP5", 105691); --"Flask of the Warm Sun"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKMOP6", 105696); --"Flask of Winter's Bite"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKCT61", 79640); --"Enhanced Intellect"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKCT62", 79639); --"Enhanced Agility"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKCT63", 79638); --"Enhanced Strength"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKWOD1", 156077); --"Draenic Stamina Flask"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKWOD2", 156071); --"Draenic Strength Flask"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKWOD3", 156070); --"Draenic Intellect Flask"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKWOD4", 156073); --"Draenic Agility Flask"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BGRFLASKWOD1", 156084); --"Greater Draenic Stamina Flask"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BGRFLASKWOD2", 156080); --"Greater Draenic Strength Flask"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BGRFLASKWOD3", 156079); --"Greater Draenic Intellect Flask"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BGRFLASKWOD4", 156064); --"Greater Draenic Agility Flask"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKLEG1", 188035); --"Flask of Ten Thousand Scars"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKLEG2", 188034); --"Flask of the Countless Armies"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKLEG3", 188031); --"Flask of the Whispered Pact"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKLEG4", 188033); --"Flask of the Seventh Demon"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKBFA1", 251837); --"Flask of Endless Fathoms"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKBFA2", 251836); --"Flask of the Currents"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKBFA3", 251839); --"Flask of the Undertow"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKBFA4", 251838); --"Flask of the Vast Horizon"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BGRFLASKBFA1", 298837); --"Greather Flask of Endless Fathoms"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BGRFLASKBFA2", 298836); --"Greater Flask of the Currents"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BGRFLASKBFA3", 298841); --"Greather Flask of teh Untertow"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BGRFLASKBFA4", 298839); --"Greater Flask of the Vast Horizon"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKSL1", 307185); --"Spectral Flask of Power"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKSL2", 307187); --"Spectral Flask of Stamina"
  -- Dragonflight
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFlaskDF1", 371345); -- Phial of the Eye in the Storm
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFlaskDF2", 371204); -- Phial of Still Air
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFlaskDF3", 371036); -- Phial of Icy Preservation
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFlaskDF4", 374000); -- Iced Phial of Corrupting Rage
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFlaskDF5", 371386); -- Phial of Charged Isolation
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFlaskDF6", 373257); -- Phial of Glacial Fury
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFlaskDF7", 370652); -- Phial of Static Empowerment
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFlaskDF8", 371172); -- Phial of Tepid Versatility
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFlaskDF9", 393700); -- Aerated Phial of Deftness
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFlaskDF10", 393717); -- Steaming Phial of Finesse
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFlaskDF11", 371186); -- Charged Phial of Alacrity
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFlaskDF12", 393714); -- Crystalline Phial of Perception
  -- the Phial of Elemental Chaos gives 1 the following 4 random buffs every 60 seconds
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFlaskDF13_1", 371348); -- Elemental Chaos: Fire
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFlaskDF13_2", 371350); -- Elemental Chaos: Air
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFlaskDF13_3", 371351); -- Elemental Chaos: Earth
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFlaskDF13_4", 371353); -- Elemental Chaos: Frost
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFlaskDF14", 393665); -- Aerated Phial of Quick Hands
  -- The War Within
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKTWW1", 431971); -- Flask of Tempered Aggression
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKTWW2", 431972); -- Flask of Tempered Swiftness
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKTWW3", 431973); -- Flask of Tempered Versatility
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKTWW4", 431974); -- Flask of Tempered Mastery
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKTWW5", 432021); -- Flask of Tempered Chaos
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKTWW6", 432473); -- Flask of Tempered Aggression
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKTWW7", 432306); -- Phial of Concentrated Ingenuity
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKTWW8", 432265); -- Phial of Truesight
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKTWW9", 432304); -- Phial of Enhanced Ambidexterity
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKTWW10", 432286); -- Phial of Bountiful Seasons
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKTWWPvP_1", 432403); -- Vicious Flask of Classical Spirits
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKTWWPvP_2", 432430); -- Vicious Flask of Honor
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKTWWPvP_3", 432497); -- Vicious Flask of Manifested Fury
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKTWWPvP_4", 432452); -- Vicious Flask of the Wrecking Ball
  -- midnight flasks
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKMIDN1", 1235111); -- Flask of the shattered sun
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKMIDN2", 1235110); -- Flask of the blood knights
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKMIDN3", 1235057); -- Flask of the Thalassian Resistance
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKMIDN4", 1235108); -- Flask of Magisters
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BFLASKMIDN5", 1239355); -- Vicious Thalassian Flask of Honor

  -- Flask/Phial links as spell IDs so links don't depend on globals at assembly time
  S.LinkFlaskTBC     = { 28520, 28540, 28518, 28521, 28519 }; -- TBC flasks
  S.LinkFlaskCT7     = { 79471, 79472, 79470, 79469, 94160 }; -- Cataclysm flasks
  S.LinkFlaskMoP     = { 79640, 79639, 79638, 105694, 105693, 105689, 105691, 105696 }; -- MoP flasks
  S.LinkFlaskWoD     = { 156077, 156071, 156070, 156073, 156084, 156080, 156079, 156064 }; -- WoD flasks
  S.LinkFlaskLeg     = { 188035, 188034, 188031, 188033 }; -- Legion flasks
  S.LinkFlaskBfA     = { 251837, 251836, 251839, 251838, 298837, 298836, 298841, 298839 }; -- BfA flasks
  S.LinkFlaskSL      = { 307185, 307187 }; -- Shadowlands flasks
  S.LinkFlaskDF      = { 371345, 371204, 371036, 374000, 371386, 373257, 370652, 371172, 393700, 393717, 371186, 393714, 371348, 371350, 371351, 371353, 393665 }; -- Dragonflight phials
  S.LinkFlaskTWW     = { 431971, 431972, 431973, 431974, 432021, 432473, 432306, 432265, 432304, 432286, 432403, 432430, 432497, 432452 }; -- TWW flasks
  S.LinkFlaskMidnight = { 1235111, 1235110, 1235057, 1235108, 1239355 }; -- Midnight flasks

  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIRTBC1", 54494); --"Major Agility" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIRTBC2", 33726); --"Mastery" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIRTBC3", 28491); --"Healing Power" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIRTBC4", 28502); --"Major Defense" G
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIRTBC5", 28490); --"Major Strength" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIRTBC6", 39625); --"Major Fortitude" G
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIRTBC7", 28509); --"Major Mageblood" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIRTBC8", 39627); --"Draenic Wisdom" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIRTBC9", 54452); --"Adept's Elixir" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIRTBC10", 134870); --"Empowerment" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIRTBC11", 33720); --"Onslaught Elixir" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIRTBC12", 28503); --"Major Shadow Power" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIRTBC13", 39628); --"Ironskin" G
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIRTBC14", 39626); --"Earthen Elixir" G
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIRTBC15", 28493); --"Major Frost Power" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIRTBC16", 38954); --"Fel Strength Elixir" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIRTBC17", 28501); --"Major Firepower" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIR1", 28497); --"Mighty Agility" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIR2", 60347); --"Mighty Thoughts" G
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIR3", 53751); --"Elixir of Mighty Fortitude" G
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIR4", 53748); --"Mighty Strength" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIR5", 53747); --"Elixir of Spirit" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIR6", 53763); --"Protection" G
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIR7", 60343); --"Mighty Defense" G
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIR8", 60346); --"Lightning Speed" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIR9", 60344); --"Expertise" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIR10", 60341); --"Deadly Strikes" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIR11", 80532); --"Armor Piercing"
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIR12", 60340); --"Accuracy" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIR13", 53749); --"Guru's Elixir" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIR14", 11334); --"Elixir of Greater Agility" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIR15", 54452); --"Adept's Elixir" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIR16", 33721); --"Spellpower Elixir" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIRCT1", 79635); --"Elixir of the Master" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIRCT2", 79632); --"Elixir of Mighty Speed" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIRCT3", 79481); --"Elixir of Impossible Accuracy" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIRCT4", 79631); --"Prismatic Elixir" G
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIRCT5", 79480); --"Elixir of Deep Earth" G
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIRCT6", 79477); --"Elixir of the Cobra" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIRCT7", 79474); --"Elixir of the Naga" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIRCT8", 79468); --"Ghost Elixir" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIRMOP1", 105687); --"Elixir of Mirrors" G
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIRMOP2", 105685); --"Elixir of Peace" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIRMOP3", 105686); --"Elixir of Perfection" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIRMOP4", 105684); --"Elixir of the Rapids" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIRMOP5", 105683); --"Elixir of Weaponry" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIRMOP6", 105682); --"Mad Hozen Elixir" B
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIRMOP7", 105681); --"Mantid Elixir" G
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BELIXIRMOP8", 105688); --"Monk's Elixir" B
  -- Draught of Ten Lands
  GetSpellInfoDirectIfNeeded("SMARTBUFF_BEXP_POTION", 289982); --Draught of Ten Lands

  --if (SMARTBUFF_GOTW) then
  --  SMARTBUFF_AddMsgD(SMARTBUFF_GOTW.." found");
  --end

  -- Save chains and links to cache (after all variables are populated)
  SMARTBUFF_SaveBuffRelationsCache();

  -- Buff map
  S.LinkStats = { 1126 }; -- Mark of the Wild (spell ID)

  S.LinkSta   = { 21562 }; -- Power Word: Fortitude (spell ID)

  -- S.LinkAp removed - only contained BATTLESHOUT (which doesn't need to link to itself)

  S.LinkInt   = { 19742, 1459, 61316 }; -- Blessing of Wisdom, Arcane Intellect, Dalaran Brilliance (spell IDs)

  --S.LinkSp    = { SMARTBUFF_DARKINTENT, SMARTBUFF_AB, SMARTBUFF_DALARANB, SMARTBUFF_STILLWATER };

  --SMARTBUFF_AddMsgD("Spell IDs initialized");
end

-- ---------------------------------------------------------------------------
-- Build item relationship tables (FOOD, SCROLL, POTION). Call after InitItemList.
-- ---------------------------------------------------------------------------
function SMARTBUFF_BuildItemTables()

  -- FOOD
    SMARTBUFF_FOOD = {
    {SMARTBUFF_ABYSSALFRIEDRISSOLE, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_BAKEDPORTTATO, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_BANANABEEFPUDDING, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_BARRACUDAMRGLGAGH, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_BATBITES,  15, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_BEARTARTARE, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_BILTONG, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_BIGMECH, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_BLACKENEDBASILISK, 30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_BLACKENEDSPOREFISH, 30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_BROILEDBLOODFIN, 30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_BUTTERSCOTCHRIBS, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_BUZZARDBITES, 30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_CHARREDBEARKABOBS, 15, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_CINNAMONBONEFISH, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_CLAMBAR, 30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_CRUNCHYSERPENT, 30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_CRUNCHYSPIDER, 15, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_DEEPFRIEDMOSSGILL, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_DROGBARSTYLESALMON, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_EXTRALEMONYFILET, 20, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_FARONAARFIZZ, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_FELTAILDELIGHT, 30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_FIGHTERCHOW, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_FRAGRANTKAKAVIA, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_FRIEDBONEFISH, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_GOLDENFISHSTICKS, 30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_GRILLEDCATFISH, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_GRILLEDMUDFISH, 30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_HEARTSBANEHEXWURST, 5, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_HONEYHAUNCHES, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_IRIDESCENTRAVIOLI, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_JUICYBEARBURGER,   15, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_KIBLERSBITS,   20, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_KULTIRAMISU, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_LEGIONCHILI, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_LOALOAF, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_LYNXSTEAK,   15, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_MEATYAPPLEDUMPLINGS, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_MOKNATHALSHORTRIBS, 30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_MONDAZI, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_PICKLEDMEATSMOOTHIE, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_PICKLEDSTORMRAY, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_POACHEDBLUEFISH, 30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_RAVAGERDOG, 30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_RAVENBERRYTARTS, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_ROASTEDCLEFTHOOF, 30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_ROASTEDMOONGRAZE,  15, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_SAGEFISHDELIGHT, 15, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_SAILORSPIE, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_SALTPEPPERSHANK, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_SEASONEDLOINS, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_SERAPHTENDERS, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_SKULLFISHSOUP, 30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_SPICEDSNAPPER, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_SPICYCRAWDAD, 30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_SPICYHOTTALBUK, 30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_SPINEFISHSOUFFLE, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_STEAKALAMODE, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_STORMCHOPS,  30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_SWAMPFISHNCHIPS, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_SWEETSILVERGILL, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_TALBUKSTEAK, 30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_TENEBROUSCROWNROAST, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_WARPBURGER, 30, SMARTBUFF_CONST_FOOD},
    -- Dragonflight
    {SMARTBUFF_TimelyDemise, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_FiletOfFangs, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_SeamothSurprise, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_SaltBakedFishcake, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_FeistyFishSticks, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_SeafoodPlatter, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_SeafoodMedley, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_RevengeServedCold, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_Tongueslicer, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_GreatCeruleanSea, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_FatedFortuneCookie, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_KaluakBanquet, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_HoardOfDelicacies, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_DeviouslyDeviledEgg, 60, SMARTBUFF_CONST_FOOD},
  };

  -- Helper: item ID from value (number, "item:ID", or link)
  local function itemIdFrom(val)
    if (type(val) == "number" and val > 0) then return val; end
    if (type(val) == "string") then return tonumber(string.match(val, "item:(%d+)")); end
    return nil;
  end
  local function foodAlreadyHasItemId(id)
    if (not id) then return false; end
    for _, entry in pairs(SMARTBUFF_FOOD) do
      if (entry and entry[1] and itemIdFrom(entry[1]) == id) then return true; end
    end
    return false;
  end
  -- Add from S.FoodItems using canonical "item:ID" only and dedupe by ID so we never get two rows for the same item
  local seenFoodIds = {};
  for n, name in pairs(S.FoodItems) do
    if (name) then
      local id = itemIdFrom(name);
      if (id) then
        if (not seenFoodIds[id] and not foodAlreadyHasItemId(id)) then
          seenFoodIds[id] = true;
          tinsert(SMARTBUFF_FOOD, 1, {"item:" .. tostring(id), 60, SMARTBUFF_CONST_FOOD});
        end
      else
        -- Fallback if we couldn't get an ID (unexpected)
        tinsert(SMARTBUFF_FOOD, 1, {name, 60, SMARTBUFF_CONST_FOOD});
      end
    end
  end

  --[[
  for _, v in pairs(SMARTBUFF_FOOD) do
    if (v and v[1]) then
      --print("List: "..v[1]);
    end
  end
  ]]

  -- Build SMARTBUFF_SCROLL: fixed scroll/misc entries first, then AddItem(...) scrolls and toys below
  SMARTBUFF_SCROLL = {
    {SMARTBUFF_MiscItem17, 60, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_BMiscItem17, S.LinkFlaskLeg},
    {SMARTBUFF_MiscItem16, 60, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_BMiscItem16},
    {SMARTBUFF_MiscItem15, 60, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_BMiscItem14, S.LinkAugment},
    {SMARTBUFF_MiscItem14, 60, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_BMiscItem14, S.LinkAugment},
    {SMARTBUFF_MiscItem13, 10, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_BMiscItem13},
    {SMARTBUFF_MiscItem12, 60, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_BMiscItem12},
    {SMARTBUFF_MiscItem11, 60, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_BMiscItem11, S.LinkFlaskWoD},
    {SMARTBUFF_MiscItem10, -1, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_BMiscItem10, S.LinkSafariHat},
    {SMARTBUFF_MiscItem9, -1, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_BMiscItem9, S.LinkSafariHat},
    {SMARTBUFF_MiscItem1, -1, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_BMiscItem1},
    {SMARTBUFF_MiscItem2, -1, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_BMiscItem2},
    {SMARTBUFF_MiscItem3, 10, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_BMiscItem3},
    {SMARTBUFF_MiscItem4, 60, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_BMiscItem4, S.LinkFlaskMoP},
    {SMARTBUFF_MiscItem5, 10, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_BMiscItem5},
    {SMARTBUFF_MiscItem6, 60, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_BMiscItem6},
    {SMARTBUFF_MiscItem7, 60, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_BMiscItem7},
    {SMARTBUFF_MiscItem8, 5, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_BMiscItem8},
    {SMARTBUFF_AugmentRune, 60, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_BAugmentRune, S.LinkAugment},
    {SMARTBUFF_VieledAugment, 60, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_BVieledAugment, S.LinkAugment},
    {SMARTBUFF_DreamAugmentRune, 60, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_BDreamAugmentRune, S.LinkAugment},
    {SMARTBUFF_SOAGILITY9, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBAGILITY},
    {SMARTBUFF_SOAGILITY8, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBAGILITY},
    {SMARTBUFF_SOAGILITY7, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBAGILITY},
    {SMARTBUFF_SOAGILITY6, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBAGILITY},
    {SMARTBUFF_SOAGILITY5, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBAGILITY},
    {SMARTBUFF_SOAGILITY4, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBAGILITY},
    {SMARTBUFF_SOAGILITY3, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBAGILITY},
    {SMARTBUFF_SOAGILITY2, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBAGILITY},
    {SMARTBUFF_SOAGILITY1, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBAGILITY},
    {SMARTBUFF_SOINTELLECT9, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBINTELLECT},
    {SMARTBUFF_SOINTELLECT8, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBINTELLECT},
    {SMARTBUFF_SOINTELLECT7, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBINTELLECT},
    {SMARTBUFF_SOINTELLECT6, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBINTELLECT},
    {SMARTBUFF_SOINTELLECT5, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBINTELLECT},
    {SMARTBUFF_SOINTELLECT4, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBINTELLECT},
    {SMARTBUFF_SOINTELLECT3, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBINTELLECT},
    {SMARTBUFF_SOINTELLECT2, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBINTELLECT},
    {SMARTBUFF_SOINTELLECT1, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBINTELLECT},
    {SMARTBUFF_SOSTAMINA9, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTAMINA},
    {SMARTBUFF_SOSTAMINA8, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTAMINA},
    {SMARTBUFF_SOSTAMINA7, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTAMINA},
    {SMARTBUFF_SOSTAMINA6, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTAMINA},
    {SMARTBUFF_SOSTAMINA5, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTAMINA},
    {SMARTBUFF_SOSTAMINA4, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTAMINA},
    {SMARTBUFF_SOSTAMINA3, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTAMINA},
    {SMARTBUFF_SOSTAMINA2, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTAMINA},
    {SMARTBUFF_SOSTAMINA1, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTAMINA},
    {SMARTBUFF_SOSPIRIT9, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSPIRIT},
    {SMARTBUFF_SOSPIRIT8, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSPIRIT},
    {SMARTBUFF_SOSPIRIT7, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSPIRIT},
    {SMARTBUFF_SOSPIRIT6, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSPIRIT},
    {SMARTBUFF_SOSPIRIT5, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSPIRIT},
    {SMARTBUFF_SOSPIRIT4, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSPIRIT},
    {SMARTBUFF_SOSPIRIT3, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSPIRIT},
    {SMARTBUFF_SOSPIRIT2, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSPIRIT},
    {SMARTBUFF_SOSPIRIT1, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSPIRIT},
    {SMARTBUFF_SOSTRENGHT9, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTRENGHT},
    {SMARTBUFF_SOSTRENGHT8, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTRENGHT},
    {SMARTBUFF_SOSTRENGHT7, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTRENGHT},
    {SMARTBUFF_SOSTRENGHT6, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTRENGHT},
    {SMARTBUFF_SOSTRENGHT5, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTRENGHT},
    {SMARTBUFF_SOSTRENGHT4, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTRENGHT},
    {SMARTBUFF_SOSTRENGHT3, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTRENGHT},
    {SMARTBUFF_SOSTRENGHT2, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTRENGHT},
    {SMARTBUFF_SOSTRENGHT1, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTRENGHT},
    {SMARTBUFF_SOPROTECTION9, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBPROTECTION},

    -- Dragonflight
    {SMARTBUFF_DraconicRune, 60, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_BDraconicRune, S.LinkAugment},
    {SMARTBUFF_VantusRune_VotI_q1, 60, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_BVantusRune_VotI_q1},
    {SMARTBUFF_VantusRune_VotI_q2, 60, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_BVantusRune_VotI_q2},
    {SMARTBUFF_VantusRune_VotI_q3, 60, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_BVantusRune_VotI_q3},

    -- TWW
    {SMARTBUFF_TWWCrystalAugRune1, 60, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_BTWWCrystalAugRune1, S.LinkAugment},
    {SMARTBUFF_TWWEtherealAugRune, 60, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_BTWWEtherealAugRune, S.LinkAugment},
  };

  -- Viable toy buffs: each AddItem(itemId, spellId, duration) appends one entry to SMARTBUFF_SCROLL.
  -- These are toys SmartBuff can track and suggest (CONST_SCROLL type; resolved via S.Toybox / item vars)
  -- Shadowlands
  AddItem(212525, 432001,  15); -- Delicate Ebony Parasol
  AddItem(182694, 341678,  15); -- Stylish Black Parasol
  -- Dragonflight
  AddItem(199902, 388275,  30); -- Wayfarer's Compass
  AddItem(202019, 396172,  30); -- Golden Dragon Goblet
  AddItem(198857, 385941,  30); -- Lucky Duck
  -- TWW
  AddItem(212518, 431709, 60);  -- Vial of Endless Draconic Scales
  -- Other Toys
  AddItem(174906, 270058,  60); -- Lightning-Forged Augment Rune
  AddItem(153023, 224001,  60); -- Lightforged Augment Rune
  AddItem(160053, 270058,  60); --Battle-Scarred Augment Rune
  AddItem(164375, 281303,  10); --Bad Mojo Banana
  AddItem(129165, 193345,  10); --Barnacle-Encrusted Gem
  AddItem(116115, 170869,  60); -- Blazing Wings
  AddItem(133997, 203533,   0); --Black Ice
  AddItem(122298, 181642,  60); --Bodyguard Miniaturization Device
  AddItem(163713, 279934,  30); --Brazier Cap
  AddItem(128310, 189363,  10); --Burning Blade
  AddItem(116440, 171554,  20); --Burning Defender's Medallion
  AddItem(128807, 192225,  60); -- Coin of Many Faces
  AddItem(138878, 217668,   5); --Copy of Daglop's Contract
  AddItem(143662, 232613,  60); --Crate of Bobbers: Pepe
  AddItem(142529, 231319,  60); --Crate of Bobbers: Cat Head
  AddItem(142530, 231338,  60); --Crate of Bobbers: Tugboat
  AddItem(142528, 231291,  60); --Crate of Bobbers: Can of Worms
  AddItem(142532, 231349,  60); --Crate of Bobbers: Murloc Head
  AddItem(147308, 240800,  60); --Crate of Bobbers: Enchanted Bobber
  AddItem(142531, 231341,  60); --Crate of Bobbers: Squeaky Duck
  AddItem(147312, 240801,  60); --Crate of Bobbers: Demon Noggin
  AddItem(147307, 240803,  60); --Crate of Bobbers: Carved Wooden Helm
  AddItem(147309, 240806,  60); --Crate of Bobbers: Face of the Forest
  AddItem(147310, 240802,  60); --Crate of Bobbers: Floating Totem
  AddItem(147311, 240804,  60); --Crate of Bobbers: Replica Gondola
  AddItem(122117, 179872,  15); --Cursed Feather of Ikzan
  AddItem( 54653,  75532,  30); -- Darkspear Pride
  AddItem(108743, 160688,  10); --Deceptia's Smoldering Boots
  AddItem(159753, 279366,   5); --Desert Flute
  AddItem(164373, 281298,  10); --Enchanted Soup Stone
  AddItem(140780, 224992,   5); --Fal'dorei Egg
  AddItem(122304, 138927,  10); -- Fandral's Seed Pouch
  AddItem(102463, 148429,  10); -- Fire-Watcher's Oath
  AddItem(128471, 190655,  30); --Frostwolf Grunt's Battlegear
  AddItem(128462, 190653,  30); --Karabor Councilor's Attire
  AddItem(161342, 275089,  30); --Gem of Acquiescence
  AddItem(127659, 188228,  60); --Ghostly Iron Buccaneer's Hat
  AddItem( 54651,  75531,  30); -- Gnomeregan Pride
  AddItem(118716, 175832,   5); --Goren Garb
  AddItem(138900, 217708,  10); --Gravil Goldbraid's Famous Sausage Hat
  AddItem(159749, 277572,   5); --Haw'li's Hot & Spicy Chili
  AddItem(163742, 279997,  60); --Heartsbane Grimoire
  AddItem(129149, 193333,  60); -- Death's Door Charm
  AddItem(140325, 223446,  10); --Home Made Party Mask
  AddItem(136855, 210642,0.25); --Hunter's Call
  AddItem( 43499,  58501,  10); -- Iron Boot Flask
  AddItem(118244, 173956,  60); --Iron Buccaneer's Hat
  AddItem(170380, 304369, 120); --Jar of Sunwarmed Sand
  AddItem(127668, 187174,   5); --Jewel of Hellfire
  AddItem( 26571, 127261,  10); --Kang's Bindstone
  AddItem( 68806,  96312,  30); -- Kalytha's Haunted Locket
  AddItem(163750, 280121,  10); --Kovork Kostume
  AddItem(164347, 281302,  10); --Magic Monkey Banana
  AddItem(118938, 176180,  10); --Manastorm's Duplicator
  AddItem(163775, 280133,  10); --Molok Morion
  AddItem(101571, 144787,   0); --Moonfang Shroud
  AddItem(105898, 145255,  10); --Moonfang's Paw
  AddItem( 52201,  73320,  10); --Muradin's Favor
  AddItem(138873, 217597,   5); --Mystical Frosh Hat
  AddItem(163795, 280308,  10); --Oomgut Ritual Drum
  AddItem(  1973,  16739,   5); --Orb of Deception
  AddItem( 35275, 160331,  30); --Orb of the Sin'dorei
  AddItem(158149, 264091,  30); --Overtuned Corgi Goggles
  AddItem(130158, 195949,   5); --Path of Elothir
  AddItem(127864, 188172,  60); --Personal Spotlight
  AddItem(127394, 186842,   5); --Podling Camouflage
  AddItem(108739, 162402,   5); --Pretty Draenor Pearl
  AddItem(129093, 129999,  10); --Ravenbear Disguise
  AddItem(153179, 254485,   5); --Blue Conservatory Scroll
  AddItem(153180, 254486,   5); --Yellow Conservatory Scroll
  AddItem(153181, 254487,   5); --Red Conservatory Scroll
  AddItem(104294, 148529,  15); --Rime of the Time-Lost Mariner
  AddItem(119215, 176898,  10); --Robo-Gnomebobulator
  AddItem(119134, 176569,  30); --Sargerei Disguise
  AddItem(129055,  62089,  60); --Shoe Shine Kit
  AddItem(163436, 279977,  30); --Spectral Visage
  AddItem(156871, 261981,  60); --Spitzy
  AddItem( 66888,   6405,   3); --Stave of Fur and Claw
  AddItem(111476, 169291,   5); --Stolen Breath
  AddItem(140160, 222630,  10); --Stormforged Vrykul Horn
  AddItem(163738, 279983,  30); --Syndicate Mask
  AddItem(130147, 195509,   5); --Thistleleaf Branch
  AddItem(113375, 166592,   5); --Vindicator's Armor Polish Kit
  AddItem(163565, 279407,   5); --Vulpera Scrapper's Armor
  AddItem(163924, 280632,  30); --Whiskerwax Candle
  AddItem( 97919, 141917,   3); --Whole-Body Shrinka'
  AddItem(167698, 293671,  60); --Secret Fish Goggles
  AddItem(169109, 299445,  60); --Beeholder's Goggles
  AddItem(191341, 371172,  30); -- Tepid Q3

  -- Potions... but really it's flasks :)
  SMARTBUFF_POTION = {
    {SMARTBUFF_ELIXIRTBC1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRTBC1},
    {SMARTBUFF_ELIXIRTBC2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRTBC2},
    {SMARTBUFF_ELIXIRTBC3, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRTBC3},
    {SMARTBUFF_ELIXIRTBC4, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRTBC4},
    {SMARTBUFF_ELIXIRTBC5, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRTBC5},
    {SMARTBUFF_ELIXIRTBC6, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRTBC6},
    {SMARTBUFF_ELIXIRTBC7, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRTBC7},
    {SMARTBUFF_ELIXIRTBC8, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRTBC8},
    {SMARTBUFF_ELIXIRTBC9, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRTBC9},
    {SMARTBUFF_ELIXIRTBC10, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRTBC10},
    {SMARTBUFF_ELIXIRTBC11, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRTBC11},
    {SMARTBUFF_ELIXIRTBC12, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRTBC12},
    {SMARTBUFF_ELIXIRTBC13, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRTBC13},
    {SMARTBUFF_ELIXIRTBC14, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRTBC14},
    {SMARTBUFF_ELIXIRTBC15, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRTBC15},
    {SMARTBUFF_ELIXIRTBC16, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRTBC16},
    {SMARTBUFF_ELIXIRTBC17, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRTBC17},
    {SMARTBUFF_FLASKTBC1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTBC1}, --, S.LinkFlaskTBC},
    {SMARTBUFF_FLASKTBC2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTBC2},
    {SMARTBUFF_FLASKTBC3, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTBC3},
    {SMARTBUFF_FLASKTBC4, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTBC4},
    {SMARTBUFF_FLASKTBC5, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTBC5},
    {SMARTBUFF_FLASKLEG1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKLEG1, S.LinkFlaskLeg},
    {SMARTBUFF_FLASKLEG2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKLEG2},
    {SMARTBUFF_FLASKLEG3, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKLEG3},
    {SMARTBUFF_FLASKLEG4, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKLEG4},
    {SMARTBUFF_FLASKWOD1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKWOD1, S.LinkFlaskWoD},
    {SMARTBUFF_FLASKWOD2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKWOD2},
    {SMARTBUFF_FLASKWOD3, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKWOD3},
    {SMARTBUFF_FLASKWOD4, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKWOD4},
    {SMARTBUFF_GRFLASKWOD1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BGRFLASKWOD1},
    {SMARTBUFF_GRFLASKWOD2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BGRFLASKWOD2},
    {SMARTBUFF_GRFLASKWOD3, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BGRFLASKWOD3},
    {SMARTBUFF_GRFLASKWOD4, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BGRFLASKWOD4},
    {SMARTBUFF_FLASKMOP1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKMOP1, S.LinkFlaskMoP},
    {SMARTBUFF_FLASKMOP2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKMOP2},
    {SMARTBUFF_FLASKMOP3, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKMOP3},
    {SMARTBUFF_FLASKMOP4, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKMOP4},
    {SMARTBUFF_FLASKMOP5, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKMOP5},
    {SMARTBUFF_FLASKMOP6, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKMOP6},
    {SMARTBUFF_ELIXIRMOP1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRMOP1},
    {SMARTBUFF_ELIXIRMOP2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRMOP2},
    {SMARTBUFF_ELIXIRMOP3, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRMOP3},
    {SMARTBUFF_ELIXIRMOP4, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRMOP4},
    {SMARTBUFF_ELIXIRMOP5, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRMOP5},
    {SMARTBUFF_ELIXIRMOP6, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRMOP6},
    {SMARTBUFF_ELIXIRMOP7, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRMOP7},
    {SMARTBUFF_ELIXIRMOP8, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRMOP8},
    {SMARTBUFF_EXP_POTION, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BEXP_POTION},
    {SMARTBUFF_FLASKCT1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKCT1},
    {SMARTBUFF_FLASKCT2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKCT2},
    {SMARTBUFF_FLASKCT3, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKCT3},
    {SMARTBUFF_FLASKCT4, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKCT4},
    {SMARTBUFF_FLASKCT5, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKCT5},
    {SMARTBUFF_FLASKCT7, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKCT7, S.LinkFlaskCT7},
    {SMARTBUFF_ELIXIRCT1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRCT1},
    {SMARTBUFF_ELIXIRCT2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRCT2},
    {SMARTBUFF_ELIXIRCT3, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRCT3},
    {SMARTBUFF_ELIXIRCT4, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRCT4},
    {SMARTBUFF_ELIXIRCT5, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRCT5},
    {SMARTBUFF_ELIXIRCT6, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRCT6},
    {SMARTBUFF_ELIXIRCT7, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRCT7},
    {SMARTBUFF_ELIXIRCT8, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRCT8},
    {SMARTBUFF_FLASK1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASK1},
    {SMARTBUFF_FLASK2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASK2},
    {SMARTBUFF_FLASK3, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASK3},
    {SMARTBUFF_FLASK4, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASK4},
    {SMARTBUFF_ELIXIR1,  60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIR1},
    {SMARTBUFF_ELIXIR2,  60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIR2},
    {SMARTBUFF_ELIXIR3,  60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIR3},
    {SMARTBUFF_ELIXIR4,  60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIR4},
    {SMARTBUFF_ELIXIR5,  60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIR5},
    {SMARTBUFF_ELIXIR6,  60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIR6},
    {SMARTBUFF_ELIXIR7,  60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIR7},
    {SMARTBUFF_ELIXIR8,  60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIR8},
    {SMARTBUFF_ELIXIR9,  60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIR9},
    {SMARTBUFF_ELIXIR10, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIR10},
    {SMARTBUFF_ELIXIR11, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIR11},
    {SMARTBUFF_ELIXIR12, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIR12},
    {SMARTBUFF_ELIXIR13, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIR13},
    {SMARTBUFF_ELIXIR14, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIR14},
    {SMARTBUFF_ELIXIR15, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIR15},
    {SMARTBUFF_ELIXIR16, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIR16},
    {SMARTBUFF_FLASKBFA1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKBFA1, S.LinkFlaskBfA},
    {SMARTBUFF_FLASKBFA2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKBFA2},
    {SMARTBUFF_FLASKBFA3, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKBFA3},
    {SMARTBUFF_FLASKBFA4, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKBFA4},
    {SMARTBUFF_GRFLASKBFA1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BGRFLASKBFA1},
    {SMARTBUFF_GRFLASKBFA2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BGRFLASKBFA2},
    {SMARTBUFF_GRFLASKBFA3, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BGRFLASKBFA3},
    {SMARTBUFF_GRFLASKBFA4, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BGRFLASKBFA4},
    {SMARTBUFF_FLASKSL1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKSL1, S.LinkFlaskSL},
    {SMARTBUFF_FLASKSL2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKSL2},
    -- Dragonflight
    -- consuming an identical phial will add another 30 min
    -- alchemist's flasks last twice as long
    {SMARTBUFF_FlaskDF1_q1, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF1, S.LinkFlaskDF},
    {SMARTBUFF_FlaskDF1_q2, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF1, S.LinkFlaskDF},
    {SMARTBUFF_FlaskDF1_q3, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF1, S.LinkFlaskDF},

    {SMARTBUFF_FlaskDF2_q1, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF2, S.LinkFlaskDF},
    {SMARTBUFF_FlaskDF2_q2, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF2, S.LinkFlaskDF},
    {SMARTBUFF_FlaskDF2_q3, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF2, S.LinkFlaskDF},

    {SMARTBUFF_FlaskDF3_q1, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF3, S.LinkFlaskDF},
    {SMARTBUFF_FlaskDF3_q2, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF3, S.LinkFlaskDF},
    {SMARTBUFF_FlaskDF3_q3, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF3, S.LinkFlaskDF},

    {SMARTBUFF_FlaskDF4_q1, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF4, S.LinkFlaskDF},
    {SMARTBUFF_FlaskDF4_q2, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF4, S.LinkFlaskDF},
    {SMARTBUFF_FlaskDF4_q3, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF4, S.LinkFlaskDF},

    {SMARTBUFF_FlaskDF5_q1, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF5, S.LinkFlaskDF},
    {SMARTBUFF_FlaskDF5_q2, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF5, S.LinkFlaskDF},
    {SMARTBUFF_FlaskDF5_q3, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF5, S.LinkFlaskDF},

    {SMARTBUFF_FlaskDF6_q1, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF6, S.LinkFlaskDF},
    {SMARTBUFF_FlaskDF6_q2, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF6, S.LinkFlaskDF},
    {SMARTBUFF_FlaskDF6_q3, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF6, S.LinkFlaskDF},

    {SMARTBUFF_FlaskDF7_q1, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF7, S.LinkFlaskDF},
    {SMARTBUFF_FlaskDF7_q2, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF7, S.LinkFlaskDF},
    {SMARTBUFF_FlaskDF7_q3, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF7, S.LinkFlaskDF},

    {SMARTBUFF_FlaskDF8_q1, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF8, S.LinkFlaskDF},
    {SMARTBUFF_FlaskDF8_q2, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF8, S.LinkFlaskDF},
    {SMARTBUFF_FlaskDF8_q3, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF8, S.LinkFlaskDF},

    {SMARTBUFF_FlaskDF9_q1, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF9, S.LinkFlaskDF},
    {SMARTBUFF_FlaskDF9_q2, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF9, S.LinkFlaskDF},
    {SMARTBUFF_FlaskDF9_q3, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF9, S.LinkFlaskDF},

    {SMARTBUFF_FlaskDF10_q1, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF10, S.LinkFlaskDF},
    {SMARTBUFF_FlaskDF10_q2, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF10, S.LinkFlaskDF},
    {SMARTBUFF_FlaskDF10_q3, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF10, S.LinkFlaskDF},

    {SMARTBUFF_FlaskDF11_q1, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF11, S.LinkFlaskDF},
    {SMARTBUFF_FlaskDF11_q2, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF11, S.LinkFlaskDF},
    {SMARTBUFF_FlaskDF11_q3, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF11, S.LinkFlaskDF},

    {SMARTBUFF_FlaskDF12_q1, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF12, S.LinkFlaskDF},
    {SMARTBUFF_FlaskDF12_q2, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF12, S.LinkFlaskDF},
    {SMARTBUFF_FlaskDF12_q3, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF12, S.LinkFlaskDF},

    -- the Elemental Chaos flask has 4 random effects changing every 60 seconds
    {SMARTBUFF_FlaskDF13_q1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF13_1, S.LinkFlaskDF},
    {SMARTBUFF_FlaskDF13_q2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF13_1, S.LinkFlaskDF},
    {SMARTBUFF_FlaskDF13_q3, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF13_1, S.LinkFlaskDF},

    {SMARTBUFF_FlaskDF14_q1, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF14, S.LinkFlaskDF},
    {SMARTBUFF_FlaskDF14_q2, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF14, S.LinkFlaskDF},
    {SMARTBUFF_FlaskDF14_q3, 30, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFlaskDF14, S.LinkFlaskDF},
    -- The War Within
    -- Default duration seems to be 60 and consuming more adds 60
    -- Fleeting ones do same buff
    {SMARTBUFF_FLASKTWW1_Q1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW1, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW1_Q2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW1, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW1_Q3, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW1, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW11_Q1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW1, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW11_Q2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW1, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW11_Q3, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW1, S.LinkFlaskTWW},

    {SMARTBUFF_FLASKTWW2_Q1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW2, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW2_Q2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW2, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW2_Q3, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW2, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW12_Q1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW2, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW12_Q2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW2, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW12_Q3, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW2, S.LinkFlaskTWW},

    {SMARTBUFF_FLASKTWW3_Q1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW3, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW3_Q2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW3, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW3_Q3, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW3, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW13_Q1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW3, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW13_Q2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW3, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW13_Q3, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW3, S.LinkFlaskTWW},

    {SMARTBUFF_FLASKTWW4_Q1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW4, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW4_Q2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW4, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW4_Q3, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW4, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW14_Q1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW4, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW14_Q2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW4, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW14_Q3, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW4, S.LinkFlaskTWW},

    {SMARTBUFF_FLASKTWW5_Q1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW5, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW5_Q2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW5, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW5_Q3, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW5, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW15_Q1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW5, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW15_Q2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW5, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW15_Q3, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW5, S.LinkFlaskTWW},

    {SMARTBUFF_FLASKTWW6_Q1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW6, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW6_Q2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW6, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW6_Q3, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW6, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW16_Q1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW6, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW16_Q2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW6, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW16_Q3, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW6, S.LinkFlaskTWW},
    -- TWW Profession phials
    {SMARTBUFF_FLASKTWW7_Q1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW7, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW7_Q2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW7, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW7_Q3, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW7, S.LinkFlaskTWW},

    {SMARTBUFF_FLASKTWW8_Q1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW8, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW8_Q2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW8, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW8_Q3, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW8, S.LinkFlaskTWW},

    {SMARTBUFF_FLASKTWW9_Q1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW9, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW9_Q2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW9, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW9_Q3, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW9, S.LinkFlaskTWW},

    {SMARTBUFF_FLASKTWW10_Q1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW10, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW10_Q2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW10, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWW10_Q3, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWW10, S.LinkFlaskTWW},
    -- TWW PVP Flasks
    {SMARTBUFF_FLASKTWWPvP_1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWWPvP1, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWWPvP_2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWWPvP2, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWWPvP_3, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWWPvP3, S.LinkFlaskTWW},
    {SMARTBUFF_FLASKTWWPvP_4, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKTWWPvP4, S.LinkFlaskTWW},
    -- midnight flasks
    {SMARTBUFF_FLASKMIDN1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKMIDN1, S.LinkFlaskMidnight},
    {SMARTBUFF_FLASKMIDN2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKMIDN2, S.LinkFlaskMidnight},
    {SMARTBUFF_FLASKMIDN3, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKMIDN3, S.LinkFlaskMidnight},
    {SMARTBUFF_FLASKMIDN4, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKMIDN4, S.LinkFlaskMidnight},
    {SMARTBUFF_FLASKMIDN5, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKMIDN5, S.LinkFlaskMidnight},

  }
end


-- ---------------------------------------------------------------------------
-- Init: per-class buff list (SMARTBUFF_BUFFLIST)
-- Set SMARTBUFF_BUFFLIST for current class; each entry: { spellVar, duration, type, ... }.
-- ---------------------------------------------------------------------------
function SMARTBUFF_InitSpellList()
  if (SMARTBUFF_PLAYERCLASS == nil) then return; end

  --if (SMARTBUFF_GOTW) then
  --  SMARTBUFF_AddMsgD(SMARTBUFF_GOTW.." found");
  --end

  -- Druid
  if (SMARTBUFF_PLAYERCLASS == "DRUID") then
    SMARTBUFF_BUFFLIST = {
      {SMARTBUFF_DRUID_MOONKIN, -1, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_DRUID_TREANT, -1, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_DRUID_BEAR, -1, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_DRUID_CAT, -1, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_DRUID_TREE, 0.5, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_MOTW, 60, SMARTBUFF_CONST_GROUP, {9}, "HPET;WPET;DKPET"},
      {SMARTBUFF_BARKSKIN, 0.25, SMARTBUFF_CONST_FORCESELF},
      {SMARTBUFF_TIGERSFURY, 0.1, SMARTBUFF_CONST_SELF, nil, SMARTBUFF_DRUID_CAT},
    };
  end

  -- Priest
  if (SMARTBUFF_PLAYERCLASS == "PRIEST") then
    SMARTBUFF_BUFFLIST = {
      {SMARTBUFF_SHADOWFORM, -1, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_VAMPIRICEMBRACE, 30, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_PWF, 60, SMARTBUFF_CONST_GROUP, {6}, "HPET;WPET;DKPET"}, -- S.LinkSta removed - chain only contains PWF itself
      {SMARTBUFF_PWS, 0.5, SMARTBUFF_CONST_GROUP, {6}, "MAGE;WARLOCK;ROGUE;PALADIN;WARRIOR;DRUID;HUNTER;SHAMAN;DEATHKNIGHT;MONK;DEMONHUNTER;EVOKER;HPET;WPET;DKPET"},
      {SMARTBUFF_LEVITATE, 2, SMARTBUFF_CONST_GROUP, {34}, "HPET;WPET;DKPET"},
    };
  end

  -- Mage
  if (SMARTBUFF_PLAYERCLASS == "MAGE") then
    SMARTBUFF_BUFFLIST = {
      {SMARTBUFF_AB, 60, SMARTBUFF_CONST_GROUP, {1,14,28,42,56,70,80}, "HPET;WPET;DKPET", S.LinkInt, S.LinkInt},
      {SMARTBUFF_SLOWFALL, 0.5, SMARTBUFF_CONST_GROUP, {32}, "HPET;WPET;DKPET"},
      {SMARTBUFF_ICEBARRIER, 1, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_PRISBARRIER, 1, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_COMBUSTION, -1, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_PRESENCEOFMIND, 0.165, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_BLAZBARRIER, 1, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_SUMMONWATERELELEMENTAL, -1, SMARTBUFF_CONST_SELF, nil, S.CheckPet},
      {SMARTBUFF_REFRESHMENT, 0.03, SMARTBUFF_CONST_ITEM, nil, SMARTBUFF_CONJUREDMANA, nil, S.FoodMage},
    };
  end

  -- Warlock
  if (SMARTBUFF_PLAYERCLASS == "WARLOCK") then
    SMARTBUFF_BUFFLIST = {
      {SMARTBUFF_UNENDINGBREATH, 10, SMARTBUFF_CONST_GROUP, {16}, "HPET;WPET;DKPET"},
      {SMARTBUFF_GOSACRIFICE, 60, SMARTBUFF_CONST_SELF, nil, S.CheckPetNeeded},
      {SMARTBUFF_SOULSTONE, 15, SMARTBUFF_CONST_GROUP, {18}, "WARRIOR;DRUID;SHAMAN;HUNTER;ROGUE;MAGE;PRIEST;PALADIN;WARLOCK;DEATHKNIGHT;EVOKER;MONK;DEMONHUNTER;HPET;WPET;DKPET"},
      {SMARTBUFF_CREATEHS, 0.03, SMARTBUFF_CONST_ITEM, nil, SMARTBUFF_HEALTHSTONE, nil, S.StoneWarlock},
      {SMARTBUFF_CREATEHSWELL, 0.03, SMARTBUFF_CONST_ITEM, nil, SMARTBUFF_HEALTHSTONE, nil, S.StoneWarlock},
      {SMARTBUFF_SUMMONIMP, -1, SMARTBUFF_CONST_SELF, nil, S.CheckPet},
      {SMARTBUFF_SUMMONFELHUNTER, -1, SMARTBUFF_CONST_SELF, nil, S.CheckPet},
      {SMARTBUFF_SUMMONVOIDWALKER, -1, SMARTBUFF_CONST_SELF, nil, S.CheckPet},
      {SMARTBUFF_SUMMONSUCCUBUS, -1, SMARTBUFF_CONST_SELF, nil, S.CheckPet},
      {SMARTBUFF_SUMMONFELGUARD, -1, SMARTBUFF_CONST_SELF, nil, S.CheckPet},
    };
  end

  -- Hunter
  if (SMARTBUFF_PLAYERCLASS == "HUNTER") then
    SMARTBUFF_BUFFLIST = {
      {SMARTBUFF_RAPIDFIRE, 0.2, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_VOLLEY, -1, SMARTBUFF_CONST_SELF},
      -- {SMARTBUFF_TRUESHOTAURA, -1, SMARTBUFF_CONST_SELF}, -- candidate for deletion (spell doesn't exist in retail WoW)
      {SMARTBUFF_AOTC, -1, SMARTBUFF_CONST_SELF, nil, nil, S.LinkAspects},
      {SMARTBUFF_AOTW, -1, SMARTBUFF_CONST_SELF, nil, nil, S.LinkAspects},
      {SMARTBUFF_CALL_PET_1, -1, SMARTBUFF_CONST_SELF, nil, S.CheckPet},
      {SMARTBUFF_CALL_PET_2, -1, SMARTBUFF_CONST_SELF, nil, S.CheckPet},
      {SMARTBUFF_CALL_PET_3, -1, SMARTBUFF_CONST_SELF, nil, S.CheckPet},
      {SMARTBUFF_CALL_PET_4, -1, SMARTBUFF_CONST_SELF, nil, S.CheckPet},
      {SMARTBUFF_CALL_PET_5, -1, SMARTBUFF_CONST_SELF, nil, S.CheckPet},
    };
  end

  -- Shaman
  if (SMARTBUFF_PLAYERCLASS == "SHAMAN") then
    SMARTBUFF_BUFFLIST = {
      {SMARTBUFF_LIGHTNINGSHIELD, 60, SMARTBUFF_CONST_SELF, nil, nil, nil, S.ChainShamanShield},
      {SMARTBUFF_WATERSHIELD, 60, SMARTBUFF_CONST_SELF, nil, nil, nil, S.ChainShamanShield},
      {SMARTBUFF_WINDFURYW, 60, SMARTBUFF_CONST_WEAPON},
      {SMARTBUFF_FLAMETONGUEW, 60, SMARTBUFF_CONST_WEAPON},
      {SMARTBUFF_TSWARD, 60, SMARTBUFF_CONST_WEAPON},
      {SMARTBUFF_TIDEGUARD, 60, SMARTBUFF_CONST_WEAPON},
      {SMARTBUFF_EVERLIVINGW, 60, SMARTBUFF_CONST_WEAPON},
      {SMARTBUFF_EARTHSHIELD, 10, SMARTBUFF_CONST_GROUP, {50,60,70,75,80}, "WARRIOR;DEATHKNIGHT;DRUID;SHAMAN;HUNTER;ROGUE;MAGE;PRIEST;PALADIN;WARLOCK;MONK;DEMONHUNTER;EVOKER;HPET;WPET;DKPET"},
      {SMARTBUFF_UNLEASHFLAME, 0.333, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_ASCENDANCE_ELE, 0.25, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_ASCENDANCE_ENH, 0.25, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_ASCENDANCE_RES, 0.25, SMARTBUFF_CONST_SELF},
      --{SMARTBUFF_EMASTERY, 0.5, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_SKYFURY, 10, SMARTBUFF_CONST_GROUP, {16}},
      {SMARTBUFF_WATERWALKING, 10, SMARTBUFF_CONST_GROUP, {28}}
    };
  end

  -- Warrior
  if (SMARTBUFF_PLAYERCLASS == "WARRIOR") then
    SMARTBUFF_BUFFLIST = {
      {SMARTBUFF_BATTLESHOUT, 60, SMARTBUFF_CONST_SELF, nil, nil, nil, S.ChainWarriorShout}, -- S.LinkAp removed - chain only contains BATTLESHOUT itself
      {SMARTBUFF_BERSERKERRAGE, 0.165, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_SHIELDBLOCK, 0.1666, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_BATSTANCE, -1, SMARTBUFF_CONST_SELF, nil, nil, nil, S.ChainWarriorStance},
      {SMARTBUFF_DEFSTANCE, -1, SMARTBUFF_CONST_SELF, nil, nil, nil, S.ChainWarriorStance},
      {SMARTBUFF_BERSERKSTANCE, -1, SMARTBUFF_CONST_SELF, nil, nil, nil, S.ChainWarriorStance},
      {SMARTBUFF_WARAVATAR, 1.5, SMARTBUFF_CONST_SELF},
    };
  end

  -- Rogue
  if (SMARTBUFF_PLAYERCLASS == "ROGUE") then
    SMARTBUFF_BUFFLIST = {
      {SMARTBUFF_STEALTH, -1, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_BLADEFLURRY, -1, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_SAD, 0.2, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_TRICKS, 0.5, SMARTBUFF_CONST_GROUP, {75}, "WARRIOR;DEATHKNIGHT;DRUID;SHAMAN;HUNTER;ROGUE;MAGE;PRIEST;PALADIN;WARLOCK;MONK;DEMONHUNTER;EVOKER;HPET;WPET;DKPET"},
      {SMARTBUFF_RECUPERATE, 0.5, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_EVASION, 0.2, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_INSTANTPOISON, 60, SMARTBUFF_CONST_SELF, nil, S.CheckFishingPole, nil, S.ChainRoguePoisonsLethal},
      {SMARTBUFF_WOUNDPOISON, 60, SMARTBUFF_CONST_SELF, nil, S.CheckFishingPole, nil, S.ChainRoguePoisonsLethal},
      {SMARTBUFF_AMPLIFYPOISON, 60, SMARTBUFF_CONST_SELF, nil, S.CheckFishingPole, nil, S.ChainRoguePoisonsLethal},
      {SMARTBUFF_NUMBINGPOISON, 60, SMARTBUFF_CONST_SELF, nil, S.CheckFishingPole, nil, S.ChainRoguePoisonsNonLethal},
      {SMARTBUFF_CRIPPLINGPOISON, 60, SMARTBUFF_CONST_SELF, nil, S.CheckFishingPole, nil, S.ChainRoguePoisonsNonLethal},
      {SMARTBUFF_ATROPHICPOISON, 60, SMARTBUFF_CONST_SELF, nil, S.CheckFishingPole, nil, S.ChainRoguePoisonsNonLethal},
      {SMARTBUFF_DEADLYPOISON, 60, SMARTBUFF_CONST_SELF, nil, S.CheckFishingPole, nil, S.ChainRoguePoisonsLethal},
    };
  end

  -- Paladin
  if (SMARTBUFF_PLAYERCLASS == "PALADIN") then
    SMARTBUFF_BUFFLIST = {
      {SMARTBUFF_HOF, 0.1, SMARTBUFF_CONST_GROUP, {52}, "WARRIOR;DEATHKNIGHT;DRUID;SHAMAN;HUNTER;ROGUE;MAGE;PRIEST;PALADIN;WARLOCK;MONK;DEMONHUNTER;EVOKER;HPET;WPET;DKPET"},
      {SMARTBUFF_BEACONOFLIGHT, 5, SMARTBUFF_CONST_GROUP, {39}, "WARRIOR;DRUID;SHAMAN;HUNTER;ROGUE;MAGE;PRIEST;PALADIN;WARLOCK;DEATHKNIGHT;MONK;DEMONHUNTER;EVOKER;HPET;WPET;DKPET"},
      {SMARTBUFF_BEACONOFAITH, 5, SMARTBUFF_CONST_GROUP, {39}, "WARRIOR;DRUID;SHAMAN;HUNTER;ROGUE;MAGE;PRIEST;PALADIN;WARLOCK;DEATHKNIGHT;MONK;DEMONHUNTER;EVOKER;HPET;WPET;DKPET"},
      {SMARTBUFF_BEACONOFVIRTUE, 5, SMARTBUFF_CONST_GROUP, {39}, "WARRIOR;DRUID;SHAMAN;HUNTER;ROGUE;MAGE;PRIEST;PALADIN;WARLOCK;DEATHKNIGHT;MONK;DEMONHUNTER;EVOKER;HPET;WPET;DKPET"},
      {SMARTBUFF_CRUSADERAURA, -1, SMARTBUFF_CONST_SELF, nil, nil, nil, S.ChainPaladinAura},
      {SMARTBUFF_DEVOTIONAURA, -1, SMARTBUFF_CONST_SELF, nil, nil, nil, S.ChainPaladinAura},
      {SMARTBUFF_CONCENTRATIONAURA, -1, SMARTBUFF_CONST_SELF, nil, nil, nil, S.ChainPaladinAura},
      {SMARTBUFF_RITEOFADJURATION, 60, SMARTBUFF_CONST_WEAPON},
      {SMARTBUFF_RITEOFSANTIFICATION, 60, SMARTBUFF_CONST_WEAPON},
    };
  end

  -- Deathknight
  if (SMARTBUFF_PLAYERCLASS == "DEATHKNIGHT") then
    SMARTBUFF_BUFFLIST = {
      {SMARTBUFF_DANCINGRW, 0.2, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_RAISEDEAD, 1, SMARTBUFF_CONST_SELF, nil, S.CheckPet},
      {SMARTBUFF_PATHOFFROST, -1, SMARTBUFF_CONST_SELF}
    };
  end

  -- Monk 
  if (SMARTBUFF_PLAYERCLASS == "MONK") then
    SMARTBUFF_BUFFLIST = {
      {SMARTBUFF_BLACKOX, 15, SMARTBUFF_CONST_SELF, nil, nil, nil, S.ChainMonkStatue},
      {SMARTBUFF_SMARTBUFF_JADESERPENT, 15, SMARTBUFF_CONST_SELF, nil, nil, nil, S.ChainMonkStatue}
    };
  end

  -- Demon Hunter
  if (SMARTBUFF_PLAYERCLASS == "DEMONHUNTER") then
    SMARTBUFF_BUFFLIST = {
    };
  end

  -- Evoker
  if (SMARTBUFF_PLAYERCLASS == "EVOKER") then
    SMARTBUFF_BUFFLIST = {
      {SMARTBUFF_SENSEPOWER, -1, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_BRONZEBLESSING, 60, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_Timelessness, 30, SMARTBUFF_CONST_GROUP, {1}, "WARRIOR;DRUID;SHAMAN;HUNTER;ROGUE;MAGE;PRIEST;PALADIN;WARLOCK;DEATHKNIGHT;MONK;DEMONHUNTER;EVOKER"},
      {SMARTBUFF_BlisteringScale, -1, SMARTBUFF_CONST_GROUP, {1}, "WARRIOR;DRUID;SHAMAN;HUNTER;ROGUE;MAGE;PRIEST;PALADIN;WARLOCK;DEATHKNIGHT;MONK;DEMONHUNTER;EVOKER"},
      {SMARTBUFF_SourceOfMagic, 60, SMARTBUFF_CONST_GROUP, {1}, "WARRIOR;HUNTER;ROGUE;MAGE;WARLOCK;DEATHKNIGHT;DEMONHUNTER;TANK;DAMAGER;HPET;WPET;DKPET"},
      {SMARTBUFF_EbonMight, -1, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_BronzeAttunement, -1, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_BlackAttunement, -1, SMARTBUFF_CONST_SELF},
    };
  end

  -- Stones and oils
  SMARTBUFF_WEAPON = {
    {SMARTBUFF_SSROUGH, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_SSCOARSE, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_SSHEAVY, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_SSSOLID, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_SSDENSE, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_SSELEMENTAL, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_SSFEL, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_SSADAMANTITE, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_WSROUGH, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_WSCOARSE, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_WSHEAVY, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_WSSOLID, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_WSDENSE, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_WSFEL, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_WSADAMANTITE, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_SHADOWOIL, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_FROSTOIL, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_MANAOIL4, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_MANAOIL3, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_MANAOIL2, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_MANAOIL1, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_WIZARDOIL5, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_WIZARDOIL4, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_WIZARDOIL3, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_WIZARDOIL2, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_WIZARDOIL1, 60, SMARTBUFF_CONST_INV},
    -- Shadowlands
    {SMARTBUFF_SHADOWCOREOIL, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_EMBALMERSOIL, 60, SMARTBUFF_CONST_INV},
    -- Dragonflight
    {SMARTBUFF_SafeRockets_q1, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_SafeRockets_q2, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_SafeRockets_q3, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_BuzzingRune_q1, 120, SMARTBUFF_CONST_INV},
    {SMARTBUFF_BuzzingRune_q2, 120, SMARTBUFF_CONST_INV},
    {SMARTBUFF_BuzzingRune_q3, 120, SMARTBUFF_CONST_INV},
    {SMARTBUFF_ChirpingRune_q1, 120, SMARTBUFF_CONST_INV},
    {SMARTBUFF_ChirpingRune_q2, 120, SMARTBUFF_CONST_INV},
    {SMARTBUFF_ChirpingRune_q3, 120, SMARTBUFF_CONST_INV},
    {SMARTBUFF_HowlingRune_q1, 120, SMARTBUFF_CONST_INV},
    {SMARTBUFF_HowlingRune_q2, 120, SMARTBUFF_CONST_INV},
    {SMARTBUFF_HowlingRune_q3, 120, SMARTBUFF_CONST_INV},
    {SMARTBUFF_HowlingRune_q3, 120, SMARTBUFF_CONST_INV},
    {SMARTBUFF_PrimalWeighstone_q1, 120, SMARTBUFF_CONST_INV},
    {SMARTBUFF_PrimalWeighstone_q2, 120, SMARTBUFF_CONST_INV},
    {SMARTBUFF_PrimalWeighstone_q3, 120, SMARTBUFF_CONST_INV},
    {SMARTBUFF_PrimalWhetstone_q1, 120, SMARTBUFF_CONST_INV},
    {SMARTBUFF_PrimalWhetstone_q2, 120, SMARTBUFF_CONST_INV},
    {SMARTBUFF_PrimalWhetstone_q3, 120, SMARTBUFF_CONST_INV},
    -- TWW
    {SMARTBUFF_TWWWeaponEnhance1_q1, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_TWWWeaponEnhance1_q2, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_TWWWeaponEnhance1_q3, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_TWWWeaponEnhance2_q1, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_TWWWeaponEnhance2_q2, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_TWWWeaponEnhance2_q3, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_TWWWeaponEnhance3_q1, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_TWWWeaponEnhance3_q2, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_TWWWeaponEnhance3_q3, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_TWWWeaponEnhance4_q1, 120, SMARTBUFF_CONST_INV},
    {SMARTBUFF_TWWWeaponEnhance4_q2, 120, SMARTBUFF_CONST_INV},
    {SMARTBUFF_TWWWeaponEnhance4_q3, 120, SMARTBUFF_CONST_INV},
    {SMARTBUFF_TWWWeaponEnhance5_q1, 120, SMARTBUFF_CONST_INV},
    {SMARTBUFF_TWWWeaponEnhance5_q2, 120, SMARTBUFF_CONST_INV},
    {SMARTBUFF_TWWWeaponEnhance5_q3, 120, SMARTBUFF_CONST_INV},
    {SMARTBUFF_TWWWeaponEnhance6_q1, 120, SMARTBUFF_CONST_INV},
    {SMARTBUFF_TWWWeaponEnhance6_q2, 120, SMARTBUFF_CONST_INV},
    {SMARTBUFF_TWWWeaponEnhance6_q3, 120, SMARTBUFF_CONST_INV},

  };

  -- Tracking
  SMARTBUFF_TRACKING = {
    {SMARTBUFF_FINDMINERALS, -1, SMARTBUFF_CONST_TRACK},
    {SMARTBUFF_FINDHERBS, -1, SMARTBUFF_CONST_TRACK},
    {SMARTBUFF_FINDTREASURE, -1, SMARTBUFF_CONST_TRACK},
    {SMARTBUFF_TRACKHUMANOIDS, -1, SMARTBUFF_CONST_TRACK},
    {SMARTBUFF_TRACKBEASTS, -1, SMARTBUFF_CONST_TRACK},
    {SMARTBUFF_TRACKUNDEAD, -1, SMARTBUFF_CONST_TRACK},
    {SMARTBUFF_TRACKHIDDEN, -1, SMARTBUFF_CONST_TRACK},
    {SMARTBUFF_TRACKELEMENTALS, -1, SMARTBUFF_CONST_TRACK},
    {SMARTBUFF_TRACKDEMONS, -1, SMARTBUFF_CONST_TRACK},
    {SMARTBUFF_TRACKGIANTS, -1, SMARTBUFF_CONST_TRACK},
    {SMARTBUFF_TRACKDRAGONKIN, -1, SMARTBUFF_CONST_TRACK}
  };

  -- Racial
  SMARTBUFF_RACIAL = {
    {SMARTBUFF_STONEFORM, 0.133, SMARTBUFF_CONST_SELF},  -- Dwarf
    --{SMARTBUFF_PRECEPTION, 0.333, SMARTBUFF_CONST_SELF}, -- Human
    {SMARTBUFF_BLOODFURY, 0.416, SMARTBUFF_CONST_SELF},  -- Orc
    {SMARTBUFF_BERSERKING, 0.166, SMARTBUFF_CONST_SELF}, -- Troll
    {SMARTBUFF_WOTFORSAKEN, 0.083, SMARTBUFF_CONST_SELF}, -- Undead
    {SMARTBUFF_WarStomp, 0.033, SMARTBUFF_CONST_SELF}, -- Tauren
    {SMARTBUFF_Visage, -1, SMARTBUFF_CONST_SELF} -- Evoker
  };
  SMARTBUFF_AddMsgD("Spell list initialized");

--  LoadToys();

end
