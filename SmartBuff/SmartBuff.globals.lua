-------------------------------------------------------------------------------
-- Globals
-------------------------------------------------------------------------------

SMARTBUFF_GLOBALS = { };
local SG = SMARTBUFF_GLOBALS;

-- Expected items/spells from buffs.lua - built during init, used for cache sync
-- Format: {items = {[varName] = itemID, ...}, spells = {[varName] = spellID, ...}}
-- itemIDToVarName / spellIDToVarName: O(1) lookup in DATA_LOAD_RESULT handlers (avoids O(n) pairs per event)
SMARTBUFF_ExpectedData = {
  items = {},
  spells = {},
  itemIDToVarName = {},
  spellIDToVarName = {}
};

-- Buff List Cache Structure
-- This cache is used to verify initialization completeness and detect when items/spells haven't loaded yet
-- It does NOT override user settings (SMARTBUFF_Buffs) - it's verification-only
if (not SmartBuffBuffListCache) then
  SmartBuffBuffListCache = {
    version = nil,  -- Will be set to SMARTBUFF_VERSION when cache is created/updated
    lastUpdate = 0,  -- Timestamp of last successful update (GetTime())
    expectedCounts = {
      SCROLL = 0,
      FOOD = 0,
      POTION = 0,
      SELF = 0,
      GROUP = 0,
      ITEM = 0,
      TOTAL = 0
    },
    enabledBuffs = {}  -- Snapshot of buff names that were enabled (for comparison only, not restoration)
  };
end

-- Item/Spell Data Cache Structure
-- Stores itemLinks and spell data from buffs.lua for persistence across reloads
-- Format: {[varName] = {itemLink/itemID/spellInfo, itemID (if item), needsRefresh (bool)}, ...}
if (not SmartBuffItemSpellCache) then
  SmartBuffItemSpellCache = {
    version = nil,  -- Will be set to SMARTBUFF_VERSION when cache is created/updated
    lastUpdate = 0,  -- Timestamp of last successful update (GetTime())
    items = {},  -- {[varName] = itemLink, ...} - itemLink strings for items
    spells = {},  -- {[varName] = spellInfo or spellName, ...} - spell data for spells
    itemIDs = {},  -- {[varName] = itemID, ...} - itemIDs for quick lookup
    itemData = {},  -- {[varName] = {minLevel, texture}, ...} - additional item data
    needsRefresh = {}  -- {[varName] = true/false, ...} - flag for items/spells that need refresh
  };
end

-- Buff Relationships Cache Structure
-- Stores chains and buff relationships (links/exclusivity) separately
-- Format: {[chainName] = {itemLink/itemID, ...}, [buffName] = {linkedBuffs}, ...}
if (not SmartBuffBuffRelationsCache) then
  SmartBuffBuffRelationsCache = {
    version = nil,  -- Will be set to SMARTBUFF_VERSION when cache is created/updated
    lastUpdate = 0,  -- Timestamp of last successful update (GetTime())
    chains = {},  -- {[chainName] = {itemLink/itemID, ...}, ...} - item chains
    links = {}  -- {[buffName] = {linkedBuffName, ...}, ...} - buff relationships
  };
end

-- Toy Cache Structure (Global - all characters see all toys)
-- Compact format: [toyID]=icon (no long itemLink keys). Legacy load supports [itemLink]={toyID,icon}.
if (not SmartBuffToyCache) then
  SmartBuffToyCache = {
    version = nil,
    lastUpdate = 0,
    toyCount = 0,
    toybox = {}  -- [toyID]=icon (compact); legacy [itemLink]={toyID,icon}
  };
end

-- Valid Spells Cache Structure
-- Stores list of valid castable spells for this character (per-character)
-- Format: {[spellID] = true, ...} - spellIDs that are known/valid for this character
if (not SmartBuffValidSpells) then
  SmartBuffValidSpells = {
    version = nil,  -- Will be set to SMARTBUFF_VERSION when cache is created/updated
    lastUpdate = 0,  -- Timestamp of last successful update (GetTime())
    spells = {}  -- {[spellID] = true, ...} - valid spellIDs for this character
  };
end

SMARTBUFF_TTC_R = 1;
SMARTBUFF_TTC_G = 1;
SMARTBUFF_TTC_B = 1;
SMARTBUFF_TTC_A = 1;

SMARTBUFF_OPTIONSFRAME_HEIGHT = 720;
SMARTBUFF_OPTIONSFRAME_WIDTH = 500;

SMARTBUFF_ACTION_ITEM  = "item";
SMARTBUFF_ACTION_SPELL = "spell";

SMARTBUFF_CONST_AUTOSOUND = "Deathbind Sound";
--SMARTBUFF_CONST_AUTOSOUND = "TaxiNodeDiscovered";
--SMARTBUFF_CONST_AUTOSOUND = "GLUECREATECHARACTERBUTTON";

--[[
SystemFont
GameFontNormal
GameFontNormalSmall
GameFontNormalLarge
GameFontHighlight
GameFontHighlightSmall
GameFontHighlightSmallOutline
GameFontHighlightLarge
GameFontDisable
GameFontDisableSmall
GameFontDisableLarge
GameFontGreen
GameFontGreenSmall
GameFontGreenLarge
GameFontRed
GameFontRedSmall
GameFontRedLarge
GameFontWhite
GameFontDarkGraySmall
NumberFontNormalYellow
NumberFontNormalSmallGray
QuestFontNormalSmall
DialogButtonHighlightText
ErrorFont
TextStatusBarText
CombatLogFont
NumberFontNormalLarge
NumberFontNormalHuge
]]--

----------------------------------------------------------------------------

-- Returns an unumerated table.
---## Example
---```
---Enum.Animals = Enum.MakeEnum ( "Dog", "Cat", "Rabbit" )
---print( Enum.Animals.Cat ) -- prints "Cat"
---```
---@param ... ...
---@return table
function Enum.MakeEnum(...)
  return tInvert({...})
    --  for i = 1, #t do
    --      local v = t[i]
    --      --t[i] = nil
    --      t[v] = i
    -- end
    -- return t
    end

-- Returns an unumerated table from an existing table.
---## Example
---```
---Fish = { "Loach", "Pike", "Herring" }
---Enum.Fish = Enum.MakeEnumFromTable(Fish)
---print(Enum.Fish.Herring) -- prints "Herring"
---```
function Enum.MakeEnumFromTable(t)
    return tInvert(t)
end

-- Returns a table `t` of self-indexed values
-- ## Example
-- ```lua
-- t = dict( "foo", "bar")
-- print(t.foo)  -- prints the string "foo"
-- ```
---@param tbl table
---@return table
function Enum.MakeDict(tbl)
    local t = {};
    for k, v in ipairs(tbl) do
        t[v] = v;
    end
    return t;
end

-- Returns a copy of `list` with `keys` and `values` inverted
-- ## Example
---```
---t = { "foo" = 1, "bar" = 2};
---s = tinvert(t);
---print(t.foo); -- prints the number 1
---print(s[1]); -- prints the string "foo";
---```
---@param tbl table
---@return table out
function table.invert(tbl)
  local out = {}
  for k, v in pairs(tbl) do
    out[v] = k
  end
  return out
end

local Default, Nil = {}, function () end -- for uniqueness
---@param case any
---@return any
-- Implements a `switch` statement in Lua.
-- ## Example
-- ```
-- switch(case) = {
--     [1] = function() print("one") end,
--     [2] = print,
--     [3] = math.sin,
--     default = function() print("default") end,
-- }
-- ```
function switch (case)
  return setmetatable({ case }, {
    __call = function (t, cases)
      local item = #t == 0 and Nil or t[1]
      return (cases[item] or cases[Default] or Nil)
    end
  })
end

-- Prints debuggin information using a formatted version of its variable
-- number of arguments following the description given in its first argument.
---
---[View documents](command:extension.lua.doc?["en-us/51/manual.html/pdf-string.format"])
---@param s any
---@param ... any
function printf(s, ...)
  print("   ",SMARTBUFF_TITLE,"::",string.format(s, ...))
end

-- Prints debug information to `stdout`. Receives any number of arguments,
-- converting each argument to a string following the same rules of
-- [tostring](command:extension.lua.doc?["en-us/51/manual.html/pdf-tostring"]).
---
--- [View documents](command:extension.lua.doc?["en-us/51/manual.html/pdf-print"])
---
function printd(...)
    print("   ",SMARTBUFF_TITLE,"::",...)
end

--- Prints the value of any global variable, table value, frame, function result, or any valid Lua expression. Output is color coded for easier reading. Tables display up to 30 values, the rest are skipped and a message is shown.
---@param t any
---@param startkey? any
function dump(t, startkey)
  DevTools_Dump(t, startkey)
end
