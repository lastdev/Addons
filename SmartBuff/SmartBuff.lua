-------------------------------------------------------------------------------
-- SmartBuff
-- Originally created by Aeldra (EU-Proudmoore)
-- Retail version fixes / improvements by Codermik & Speedwaystar
-- Discord: https://discord.gg/R6EkZ94TKK
-- Cast the most important buffs on you, tanks or party/raid members/pets.
-------------------------------------------------------------------------------

-- Changes to SMARTBUFF_VERSION will pop up a 'what's new'
-- and options frame on first load... could be annoying if done too often
-- What's new is pulled from the SMARTBUFF_WHATSNEW string in localization.en.lua
-- this is mostly optional, but good for internal housekeeping
SMARTBUFF_DATE               = "110226"; -- EU Date: DDMMYY
SMARTBUFF_VERSION            = "r38." .. SMARTBUFF_DATE;
-- Update the NR below to force reload of SB_Buffs on first login
-- This is now OPTIONAL for most changes - only needed for major logical reworks or large patch changes.
-- Definition changes (spell IDs, Links, Chain) in buffs.lua no longer require version bumps.
-- Profile logic changes and buff definition updates are handled automatically without requiring version bumps.
SMARTBUFF_VERSIONNR          = 120000;
-- End of version info

SMARTBUFF_TITLE              = "SmartBuff";
SMARTBUFF_SUBTITLE           = "Supports you in casting buffs";
SMARTBUFF_DESC               = "Cast the most important buffs on you, your tanks, party/raid members/pets";
SMARTBUFF_VERS_TITLE         = SMARTBUFF_TITLE .. " " .. SMARTBUFF_VERSION;
SMARTBUFF_OPTIONS_TITLE      = SMARTBUFF_VERS_TITLE .. " Retail ";

-- addon name
local addonName              = ...
local SmartbuffPrefix        = "Smartbuff";
local SmartbuffSession       = true;
local SmartbuffVerCheck      = false; -- for my use when checking guild users/testers versions  :)
local buildInfo              = select(4, GetBuildInfo())
local SmartbuffVerNotifyList = {}

local SG                     = SMARTBUFF_GLOBALS;
local OG                     = nil; -- Options global
local O                      = nil; -- Options local
local B                      = nil; -- Buff settings local
local _;

-- Ensure SavedVariables exist when nil (new install or deleted SavedVariables)
if (type(SMARTBUFF_Options) ~= "table") then SMARTBUFF_Options = {}; end
if (type(SMARTBUFF_Buffs) ~= "table") then SMARTBUFF_Buffs = {}; end
if (type(SMARTBUFF_OptionsGlobal) ~= "table") then
  SMARTBUFF_OptionsGlobal = {};
  SMARTBUFF_OptionsGlobal.FirstStart = "V0";  -- so Options_Init sees version "changed" and pops options + news
end

local GlobalCd               = 1.5;
local maxSkipCoolDown        = 3;
local maxRaid                = 40;
local maxBuffs               = 40;
local maxScrollButtons       = 30;
local numBuffs               = 0;

local isLoaded               = false;
local isPlayer               = false;
local isInit                 = false;
local isCombat               = false;
local isSetBuffs             = false;
local isSetZone              = false;
local isFirstError           = false;
local isMounted              = false;
local isCTRA                 = true;
local isKeyUpChanged         = false;
local isKeyDownChanged       = false;
local isAuraChanged          = false;
local isClearSplash          = false;
local isRebinding            = false;
local isParrot               = false;
local isSync                 = false;
local isSyncReq              = false;
local isInitBtn              = false;

local isShapeshifted         = false;
local sShapename             = "";

local tStartZone             = 0;
local tTicker                = 0;
local tSync                  = 0;
local setBuffsPending        = false;  -- SMARTBUFF_ScheduleSetBuffs: one timer at a time

local sRealmName             = nil;
local sPlayerName            = nil;
local sID                    = nil;
local sPlayerClass           = nil;
local tLastCheck             = 0;
local iLastBuffSetup         = -1;
local sLastTexture           = "";
local iLastGroupSetup        = -99;
local sLastZone              = "";
local tAutoBuff              = 0;
local tDebuff                = 0;
local sMsgWarning            = "";
local iCurrentFont           = 6;
local iCurrentList           = -1;
local iLastPlayer            = -1;

local isPlayerMoving         = false;

local cGroups                = {};
local cClassGroups           = {};
local cBuffs                 = {};
local cBuffIndex             = {};
local cBuffTimer             = {};
local cBlacklist             = {};
local cUnits                 = {};
local cBuffsCombat           = {};

local cScrBtnBO              = nil;

local cAddUnitList           = {};
local cIgnoreUnitList        = {};

local cClasses               = { "DRUID", "HUNTER", "MAGE", "PALADIN", "PRIEST", "ROGUE", "SHAMAN", "WARLOCK", "WARRIOR",
  "DEATHKNIGHT", "MONK", "DEMONHUNTER", "EVOKER", "HPET", "WPET", "DKPET", "TANK", "HEALER", "DAMAGER" };
local cOrderGrp              = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
local cFonts                 = { "NumberFontNormal", "NumberFontNormalLarge", "NumberFontNormalHuge", "GameFontNormal",
  "GameFontNormalLarge", "GameFontNormalHuge", "ChatFontNormal", "QuestFont", "MailTextFontNormal", "QuestTitleFont" };

local currentUnit            = nil;
local currentSpell           = nil;
local tCastRequested         = 0;
local currentTemplate        = nil;
local currentSpec            = nil;

local imgSB                  = "Interface\\Icons\\Spell_Nature_Purge";
local imgIconOn              = "Interface\\AddOns\\SmartBuff\\Icons\\MiniMapButtonEnabled";
local imgIconOff             = "Interface\\AddOns\\SmartBuff\\Icons\\MiniMapButtonDisabled";

local IconPaths              = {
  ["Pet"]     = "Interface\\Icons\\spell_nature_spiritwolf",
  ["Roles"]   = "Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES",
  ["Classes"] = "Interface\\WorldStateFrame\\Icons-Classes",
};

local Icons                  = {
  ["WARRIOR"]     = { IconPaths.Classes, 0.00, 0.25, 0.00, 0.25 },
  ["MAGE"]        = { IconPaths.Classes, 0.25, 0.50, 0.00, 0.25 },
  ["ROGUE"]       = { IconPaths.Classes, 0.50, 0.75, 0.00, 0.25 },
  ["DRUID"]       = { IconPaths.Classes, 0.75, 1.00, 0.00, 0.25 },
  ["HUNTER"]      = { IconPaths.Classes, 0.00, 0.25, 0.25, 0.50 },
  ["SHAMAN"]      = { IconPaths.Classes, 0.25, 0.50, 0.25, 0.50 },
  ["PRIEST"]      = { IconPaths.Classes, 0.50, 0.75, 0.25, 0.50 },
  ["WARLOCK"]     = { IconPaths.Classes, 0.75, 1.00, 0.25, 0.50 },
  ["PALADIN"]     = { IconPaths.Classes, 0.00, 0.25, 0.50, 0.75 },
  ["DEATHKNIGHT"] = { IconPaths.Classes, 0.25, 0.50, 0.50, 0.75 },
  ["MONK"]        = { IconPaths.Classes, 0.50, 0.75, 0.50, 0.75 },
  ["DEMONHUNTER"] = { IconPaths.Classes, 0.75, 1.00, 0.50, 0.75 },
  ["EVOKER"]      = { IconPaths.Classes, 0.75, 1.00, 0.50, 0.75 },
  ["PET"]         = { IconPaths.Pet, 0.08, 0.92, 0.08, 0.92 },
  ["TANK"]        = { IconPaths.Roles, 0.0, 19 / 64, 22 / 64, 41 / 64 },
  ["HEALER"]      = { IconPaths.Roles, 20 / 64, 39 / 64, 1 / 64, 20 / 64 },
  ["DAMAGER"]     = { IconPaths.Roles, 20 / 64, 39 / 64, 22 / 64, 41 / 64 },
  ["NONE"]        = { IconPaths.Roles, 20 / 64, 39 / 64, 22 / 64, 41 / 64 },
};

-- available sounds (25)
local sharedMedia            = LibStub:GetLibrary("LibSharedMedia-3.0")
local Sounds                 = { 1141, 3784, 4574, 17318, 15262, 13830, 15273, 10042, 10720, 17316, 3337, 7894, 7914, 10033, 416, 57207, 78626, 49432, 10571, 58194, 21970, 17339, 84261, 43765 }
local soundTable             = {
  ["Deathbind_Sound"] = 1141,
  ["Air_Elemental"] = 3784,
  ["PVP_Update"] = 4574,
  ["LFG_DungeonReady"] = 17318,
  ["Aggro_Enter_Warning_State"] = 15262,
  ["Glyph_MinorDestroy"] = 13830,
  ["GM_ChatWarning"] = 15273,
  ["SPELL_SpellReflection_State_Shield"] = 10042,
  ["Disembowel_Impact"] = 10720,
  ["LFG_Rewards"] = 17316,
  ["EyeOfKilrogg_Death"] = 3337,
  ["TextEmote_HuF_Sigh"] = 7894,
  ["TextEmote_HuM_Sigh"] = 7914,
  ["TextEmote_BeM_Whistle"] = 10033,
  ["Murloc_Aggro"] = 416,
  ["SPELL_WR_ShieldSlam_Revamp_Cast"] = 57207,
  ["Spell_Moroes_Vanish_poof_01"] = 78626,
  ["SPELL_WR_WhirlWind_Proto_Cast"] = 49432,
  ["Fel_Reaver_Alarm"] = 10571,
  ["SPELL_RO_SaberSlash_Cast"] = 58194,
  ["FX_ArcaneMagic_DarkSwell"] = 21970,
  ["Epic_Fart"] = 17339,
  ["VO_72_LASAN_SKYHORN_WOUND"] = 84261,
  ["SPELL_PA_SealofInsight"] = 43765
}
for soundName, soundData in pairs(soundTable) do
  sharedMedia:Register(sharedMedia.MediaType.SOUND, soundName, soundData)
end
local sounds = sharedMedia:HashTable("sound")
-- dump(sounds)

local DebugChatFrame = DEFAULT_CHAT_FRAME;

-- Popup reset all data
StaticPopupDialogs["SMARTBUFF_DATA_PURGE"] = {
  text = SMARTBUFF_OFT_PURGE_DATA,
  button1 = SMARTBUFF_OFT_YES,
  button2 = SMARTBUFF_OFT_NO,
  OnAccept = function() SMARTBUFF_ResetAll() end,
  timeout = 0,
  whileDead = 1,
  hideOnEscape = 1
}

-- Popup reset buffs
StaticPopupDialogs["SMARTBUFF_BUFFS_PURGE"] = {
  text = SMARTBUFF_OFT_PURGE_BUFFS,
  button1 = SMARTBUFF_OFT_YES,
  button2 = SMARTBUFF_OFT_NO,
  OnAccept = function() SMARTBUFF_ResetBuffs() end,
  timeout = 0,
  whileDead = 1,
  hideOnEscape = 1
}

-- Popup to reloadui
StaticPopupDialogs["SMARTBUFF_GUI_RELOAD"] = {
  text = SMARTBUFF_OFT_REQ_RELOAD,
  button1 = SMARTBUFF_OFT_OKAY,
  OnAccept = function() ReloadUI() end,
  timeout = 0,
  whileDead = 1,
  hideOnEscape = 1
}

-- Rounds a number to the given number of decimal places.
local r_mult;
local function Round(num, idp)
  r_mult = 10 ^ (idp or 0);
  return math.floor(num * r_mult + 0.5) / r_mult;
end

-- Returns a chat color code string
local function BCC(r, g, b)
  return string.format("|cff%02x%02x%02x", (r * 255), (g * 255), (b * 255));
end

local BL  = BCC(0, 0, 1);
local BLD = BCC(0, 0, 0.7);
local BLL = BCC(0.5, 0.8, 1);
local GR  = BCC(0, 1, 0);
local GRD = BCC(0, 0.7, 0);
local GRL = BCC(0.6, 1, 0.6);
local RD  = BCC(1, 0, 0);
local RDD = BCC(0.7, 0, 0);
local RDL = BCC(1, 0.3, 0.3);
local YL  = BCC(1, 1, 0);
local YLD = BCC(0.7, 0.7, 0);
local YLL = BCC(1, 1, 0.5);
local OR  = BCC(1, 0.7, 0);
local ORD = BCC(0.7, 0.5, 0);
local ORL = BCC(1, 0.6, 0.3);
local WH  = BCC(1, 1, 1);
local CY  = BCC(0.5, 1, 1);

-- function to preview selected warning sound in options screen
function SMARTBUFF_PlaySpashSound()
  PlaySound(Sounds[O.AutoSoundSelection]);
end

function SMARTBUFF_ChooseSplashSound()
  local menu = {}
  local i = 1
  for sound, soundpath in pairs(sounds) do
    menu[i] = { text = sound, notCheckable = true, func = function() PlaySound(soundpath) end }
    i = i + 1
  end
  local dropDown = CreateFrame("Frame", "DropDownMenuFrame", UIParent, "UIDropDownMenuTemplate")
  -- UIDropDownMenu_Initialize(dropDown, menu, "MENU")
  -- make the menu appear at the frame:
  dropDown:SetPoint("CENTER", UIParent, "CENTER")
  dropDown:SetScript("OnMouseUp", function(self, button, down)
    --    print("mousedown")
    -- EasyMenu(menu, dropDown, dropDown, 0 , 0, "MENU");
  end)
end

-- Reorders values in the table
local function treorder(t, i, n)
  if (t and type(t) == "table" and t[i]) then
    local s = t[i];
    tremove(t, i);
    if (i + n < 1) then
      tinsert(t, 1, s);
    elseif (i + n > #t) then
      tinsert(t, s);
    else
      tinsert(t, i + n, s);
    end
  end
end

-- Debug util to dump a variable (primarily table to string)
local function dump(o)
  if type(o) == 'table' then
     local s = '{ '
     for k,v in pairs(o) do
        if type(k) ~= 'number' then k = '"'..k..'"' end
        s = s .. '['..k..'] = ' .. dump(v) .. ','
     end
     return s .. '} '
  else
     return tostring(o)
  end
end

-- Finds a value in the table and returns the index
local function tfind(t, s)
  if (t and type(t) == "table" and s) then
    for k, v in pairs(t) do
      if (v and v == s) then
        return k;
      end
    end
  end
  return false;
end

-- Chain/link entries: spell ID (number), spell name (string), or spell info table (.name).
-- Order can be string or table (saved state).
-- Resolve numeric IDs at use time so chains/links don't depend on globals being set when assembled.
local function ResolveChainOrLinkEntry(entry)
  if (type(entry) == "number") then
    local name = C_Spell.GetSpellName(entry);
    if (name and name ~= "") then return name; end
    return "item:" .. tostring(entry);
  end
  if (type(entry) == "table" and entry.name) then return entry.name; end
  return type(entry) == "string" and entry or nil;
end

local function ChainContains(chain, buffName)
  if (not chain or type(chain) ~= "table" or not buffName) then return false; end
  local nameToMatch = (type(buffName) == "table" and buffName.name) or buffName;
  if (not nameToMatch) then return false; end
  local cbi = nameToMatch and cBuffIndex[nameToMatch];
  if (type(nameToMatch) == "string" and cbi and cBuffs[cbi] and cBuffs[cbi].IDS) then
    local resolved = C_Spell and C_Spell.GetSpellName and C_Spell.GetSpellName(cBuffs[cbi].IDS);
    if (resolved and resolved ~= "") then nameToMatch = resolved; end
  end
  for _, entry in ipairs(chain) do
    if (not entry) then
    elseif (entry == nameToMatch) then return true;
    elseif (type(entry) == "table" and entry.name == nameToMatch) then return true;
    elseif (type(entry) == "number") then
      if (ResolveChainOrLinkEntry(entry) == nameToMatch) then return true; end
    end
  end
  return false;
end

local function ChkS(text)
  if (text == nil) then
    text = "";
  end
  return text;
end

local function IsVisibleToPlayer(self)
  if (not self) then return false; end

  local w, h = UIParent:GetWidth(), UIParent:GetHeight();
  local x, y = self:GetLeft(), UIParent:GetHeight() - self:GetTop();

  --print(format("w = %.0f, h = %.0f, x = %.0f, y = %.0f", w, h, x, y));
  if (x >= 0 and x < (w - self:GetWidth()) and y >= 0 and y < (h - self:GetHeight())) then
    return true;
  end
  return false;
end

local function CS()
  if (currentSpec == nil) then
    currentSpec = GetSpecialization();
  end
  if (currentSpec == nil) then
    currentSpec = 1;
    SMARTBUFF_AddMsgErr("Could not detect active talent group, set to default = 1");
    printd("Could not detect active talent group, set to default = 1");
  end
  return currentSpec;
end

local function CT()
  return currentTemplate;
end

local function GetBuffSettings(buff)
  if (not B or not buff) then return nil; end
  local cBuff = B[CS()][CT()][buff];
  local id = (type(buff) == "string") and tonumber(string.match(buff, "item:(%d+)"));
  -- If found via direct key and key is a full item link (not canonical), migrate to canonical so
  -- SavedVariables persist next session (link string can differ between sessions).
  if (cBuff and id and type(buff) == "string") then
    local canKey = "item:" .. tostring(id);
    if (buff ~= canKey) then
      B[CS()][CT()][canKey] = cBuff;
      B[CS()][CT()][buff] = nil;
    end
  end
  -- Item-type keys can be full link or "item:ID"; try canonical key so settings persist across load order
  if (not cBuff and type(buff) == "string") then
    if (not id) then id = tonumber(string.match(buff, "item:(%d+)")); end
    if (id) then
      cBuff = B[CS()][CT()]["item:" .. tostring(id)];
      -- Last session may have saved under full link; find any key that refers to this item
      if (not cBuff) then
        for k, v in pairs(B[CS()][CT()]) do
          if (type(k) == "string" and type(v) == "table") then
            local kid = tonumber(string.match(k, "item:(%d+)"));
            if (kid == id) then
              cBuff = v;
              -- Migrate to canonical key so future lookups and saves use one key
              local canKey = "item:" .. tostring(id);
              B[CS()][CT()][canKey] = v;
              B[CS()][CT()][k] = nil;
              break;
            end
          end
        end
      end
    end
  end
  return cBuff;
end

-- Remove duplicate item-type keys in B[spec][template]: keep only canonical "item:ID",
-- migrate or drop link/name orphans so SavedVariables stay clean and we avoid confused state.
-- Rate-limited to CRUFT_CLEANUP_CHUNK keys per iteration; continues next frame if more keys remain.
local CRUFT_CLEANUP_CHUNK = 500;
local function CleanBuffSettingsCruftOneTable(t, keys, startIdx)
  if (not t or type(t) ~= "table") then return; end
  local expected = SMARTBUFF_ExpectedData;
  if (not expected or not expected.items) then return; end
  if (not keys) then
    keys = {};
    for k, v in pairs(t) do
      if (k ~= "SelfFirst" and type(v) == "table") then
        tinsert(keys, k);
      end
    end
    startIdx = 1;
  end
  local toRemove = {};
  local toMigrate = {};
  local last = math.min(startIdx + CRUFT_CLEANUP_CHUNK - 1, #keys);
  for i = startIdx, last do
    local k = keys[i];
    if (k and t[k] ~= nil) then
      local id = (type(k) == "string") and tonumber(string.match(k, "item:(%d+)"));
      if (id) then
        local canKey = "item:" .. tostring(id);
        if (k ~= canKey) then
          if (t[canKey]) then
            toRemove[k] = true;
          else
            toMigrate[k] = canKey;
          end
        end
      else
        for varName, itemId in pairs(expected.items) do
          if (_G[varName] == k) then
            local canKey = "item:" .. tostring(itemId);
            if (t[canKey]) then
              toRemove[k] = true;
            else
              toMigrate[k] = canKey;
            end
            break;
          end
        end
      end
    end
  end
  for k, canKey in pairs(toMigrate) do
    t[canKey] = t[k];
    t[k] = nil;
  end
  for k in pairs(toRemove) do
    t[k] = nil;
  end
  if (last < #keys) then
    C_Timer.After(0, function()
      CleanBuffSettingsCruftOneTable(t, keys, last + 1);
    end);
  end
end

local function CleanBuffSettingsCruft()
  if (not B or not B[CS()]) then return; end
  if (not SMARTBUFF_ExpectedData or not SMARTBUFF_ExpectedData.items) then return; end
  for ctKey, ctTbl in pairs(B[CS()]) do
    if (ctKey ~= "Order" and type(ctTbl) == "table") then
      CleanBuffSettingsCruftOneTable(ctTbl);
    end
  end
end

local function InitBuffSettings(cBI, reset)
  local buff = cBI.BuffS;
  local cBuff = GetBuffSettings(buff);
  local id = (type(buff) == "string") and tonumber(string.match(buff, "item:(%d+)"));
  if (cBuff == nil) then
    -- Use canonical key for item-type buffs so link vs placeholder doesn't lose saved settings
    local key = buff;
    if (type(buff) == "string") then
      if (not id) then id = tonumber(string.match(buff, "item:(%d+)")); end
      -- Item-type buffs: resolve id from ExpectedData when buff has no "item:ID" (e.g. init timing/name).
      -- Use canonical key and restore EnableS from cache.
      if (not id and SMARTBUFF_ExpectedData and SMARTBUFF_ExpectedData.items) then
        for varName, itemId in pairs(SMARTBUFF_ExpectedData.items) do
          if (_G[varName] == buff) then id = itemId; break; end
        end
      end
      if (id) then key = "item:" .. tostring(id); end
    end
    B[CS()][CT()][key] = {};
    cBuff = B[CS()][CT()][key];
    reset = true;
  end

  if (reset) then
    wipe(cBuff);
    cBuff.EnableS = false;
    cBuff.EnableG = false;
    cBuff.SelfOnly = false;
    cBuff.SelfNot = false;
    cBuff.CIn = false;
    cBuff.COut = true;
    cBuff.MH = true; -- default to checked
    cBuff.OH = false;
    cBuff.RH = false;
    cBuff.Reminder = true;
    cBuff.RBTime = 0;
    cBuff.ManaLimit = 0;
    if (cBI.Type == SMARTBUFF_CONST_GROUP or cBI.Type == SMARTBUFF_CONST_ITEMGROUP) then
      for n in pairs(cClasses) do
        if (cBI.Type == SMARTBUFF_CONST_GROUP and not string.find(cBI.Params, cClasses[n])) then
          cBuff[cClasses[n]] = true;
        else
          cBuff[cClasses[n]] = false;
        end
      end
    end
    -- Restore EnableS from cache when we had to create (e.g. B was missing this key; user had it enabled last session)
    if (SmartBuffBuffListCache and SmartBuffBuffListCache.enabledBuffs) then
      if (not id) then id = (type(buff) == "string") and tonumber(string.match(buff, "item:(%d+)")); end
      if (not id and SMARTBUFF_ExpectedData and SMARTBUFF_ExpectedData.items) then
        for varName, itemId in pairs(SMARTBUFF_ExpectedData.items) do
          if (_G[varName] == buff) then id = itemId; break; end
        end
      end
      for _, en in ipairs(SmartBuffBuffListCache.enabledBuffs) do
        if (en == buff or (id and type(en) == "string" and (("item:" .. tostring(id)) == en or tonumber(string.match(en, "item:(%d+)")) == id))) then
          cBuff.EnableS = true;
          break;
        end
      end
    end
  end

  -- Upgrades
  if (cBuff.RBTime == nil) then
    cBuff.Reminder = true; cBuff.RBTime = 0;
  end                                                                        -- to 1.10g
  if (cBuff.ManaLimit == nil) then cBuff.ManaLimit = 0; end                  -- to 1.12b
  if (cBuff.SelfNot == nil) then cBuff.SelfNot = false; end                  -- to 2.0i
  if (cBuff.AddList == nil) then cBuff.AddList = {}; end                     -- to 2.1a
  if (cBuff.IgnoreList == nil) then cBuff.IgnoreList = {}; end               -- to 2.1a
  if (cBuff.RH == nil) then cBuff.RH = false; end                            -- to 4.0b
end

local function InitBuffOrder(reset)
  if not B then B = {} end
  if not B[CS()] then B[CS()] = {} end
  if not B[CS()].Order then B[CS()].Order = {} end

  local b;
  local i;
  local ord = B[CS()].Order;

  if (reset) then
    wipe(ord);
    SMARTBUFF_AddMsgD("Reset buff order");
  end

  -- Normalize Order: item-type keys to canonical "item:ID" and dedupe (single source of truth;
  -- avoids link vs placeholder duplicates on reload).
  -- Also normalize numeric item IDs (corrupt/old saved state) so they don't show as separate rows
  do
    local function idFrom(s)
      if (type(s) == "number" and s > 0) then return s; end
      if (type(s) == "string") then return tonumber(string.match(s, "item:(%d+)")); end
      return nil;
    end
    for k, v in pairs(ord) do
      if (v ~= nil) then
        local id = idFrom(v);
        if (id) then ord[k] = "item:" .. tostring(id); end
      end
    end
    local seen, newOrd = {}, {};
    for idx = 1, #ord do
      local key = ord[idx];
      if (key and not seen[key]) then
        seen[key] = true;
        tinsert(newOrd, key);
      end
    end
    wipe(ord);
    for _, key in ipairs(newOrd) do tinsert(ord, key); end
  end

  -- Remove not longer existing buffs in the order list
  -- Also remove toys if IncludeToys is disabled
  local toRemove = {};
  local includeToys = (O and O.IncludeToys) or false;
  for k, v in pairs(ord) do
    if (v and cBuffIndex[v] == nil) then
      SMARTBUFF_AddMsgD("Remove from buff order: " .. v);
      tinsert(toRemove, k);
    elseif (v and not includeToys and SG.Toybox and SG.Toybox[v]) then
      SMARTBUFF_AddMsgD("Remove toy from buff order (toys excluded): " .. v);
      tinsert(toRemove, k);
    end
  end
  -- Remove collected indices in reverse order to avoid index shifting issues
  table.sort(toRemove, function(a, b) return a > b; end);
  for _, k in ipairs(toRemove) do
    tremove(ord, k);
  end

  i = 1;
  while (cBuffs[i] and cBuffs[i].BuffS) do
    -- Skip toys if IncludeToys is disabled
    if (includeToys or not SG.Toybox or not SG.Toybox[cBuffs[i].BuffS]) then
      b = false;
      for _, v in pairs(ord) do
        if (v and v == cBuffs[i].BuffS) then
          b = true;
          break;
        end
      end
      -- buff not found add it to order list
      if (not b) then
        tinsert(ord, cBuffs[i].BuffS);
        SMARTBUFF_AddMsgD("Add to buff order: " .. cBuffs[i].BuffS);
      end
    end
    i = i + 1;
  end
end

local function IsMinLevel(minLevel)
  if (not minLevel) then
    return true;
  end
  if (minLevel > UnitLevel("player")) then
    return false;
  end
  return true;
end

local function IsPlayerInGuild()
  return IsInGuild()   -- and GetGuildInfo("player")
end

local function SendSmartbuffVersion(player, unit)
  -- if ive announced to this player / the player is me then just return.
  if player == UnitName("player") then return end
  for count, value in ipairs(SmartbuffVerNotifyList) do
    if value[1] == player then return end
  end
  -- not announced, add the player and announce.
  tinsert(SmartbuffVerNotifyList, { player, unit, GetTime() })
  C_ChatInfo.SendAddonMessage(SmartbuffPrefix, SMARTBUFF_VERSION, "WHISPER", player)
  SMARTBUFF_AddMsgD(string.format("%s was sent version information.", player))
end

-- TODO: Redesign if reactivated!
local function IsTalentSkilled(t, i, name)
  local _, tName, _, _, tAvailable = GetTalentInfo(t, i);
  if (tName) then
    isTTreeLoaded = true;
    SMARTBUFF_AddMsgD("Talent: " .. tName .. ", Points = " .. tAvailable);
    if (name and name == tName and tAvailable > 0) then
      SMARTBUFF_AddMsgD("Debuff talent found: " .. name .. ", Points = " .. tAvailable);
      return true, tAvailable;
    end
  else
    SMARTBUFF_AddMsgD("Talent tree not available!");
    isTTreeLoaded = false;
  end
  return false, 0;
end


-- SMARTBUFF_OnLoad
function SMARTBUFF_OnLoad(self)
  self:RegisterEvent("ADDON_LOADED");
  self:RegisterEvent("PLAYER_LOGIN"); -- added
  self:RegisterEvent("PLAYER_ENTERING_WORLD");
  self:RegisterEvent("UNIT_NAME_UPDATE");
  self:RegisterEvent("PLAYER_REGEN_ENABLED");
  self:RegisterEvent("PLAYER_REGEN_DISABLED");
  self:RegisterEvent("PLAYER_STARTED_MOVING"); -- added
  self:RegisterEvent("PLAYER_STOPPED_MOVING"); -- added
  self:RegisterEvent("PLAYER_TALENT_UPDATE");
  self:RegisterEvent("SPELLS_CHANGED");
  self:RegisterEvent("ACTIONBAR_HIDEGRID");
  self:RegisterEvent("UNIT_AURA");
  self:RegisterEvent("CHAT_MSG_ADDON");
  self:RegisterEvent("CHAT_MSG_CHANNEL");
  self:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
  self:RegisterEvent("UNIT_SPELLCAST_FAILED");
  self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
  self:RegisterEvent("PLAYER_LEVEL_UP");
  self:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED");
  -- Cache-related events for partial reloads
  self:RegisterEvent("NEW_TOY_ADDED");
  self:RegisterEvent("BAG_UPDATE");
  self:RegisterEvent("ITEM_DATA_LOAD_RESULT");
  self:RegisterEvent("SPELL_DATA_LOAD_RESULT");
  --auto template events
  self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
  self:RegisterEvent("GROUP_ROSTER_UPDATE")
  self:RegisterEvent("ACTIVE_DELVE_DATA_UPDATE")

  --One of them allows SmartBuff to be closed with the Escape key
  tinsert(UISpecialFrames, "SmartBuffOptionsFrame");
  UIPanelWindows["SmartBuffOptionsFrame"] = nil;

  SlashCmdList["SMARTBUFF"] = SMARTBUFF_command;
  SLASH_SMARTBUFF1 = "/sbo";
  SLASH_SMARTBUFF2 = "/sbuff";
  SLASH_SMARTBUFF3 = "/smartbuff";
  SLASH_SMARTBUFF4 = "/sb";

  SlashCmdList["SMARTBUFFMENU"] = SMARTBUFF_OptionsFrame_Toggle;
  SLASH_SMARTBUFFMENU1 = "/sbm";

  SlashCmdList["SmartReloadUI"] = function(msg) ReloadUI(); end;
  SLASH_SmartReloadUI1 = "/rui";

  SMARTBUFF_InitSpellIDs();
  SMARTBUFF_InitItemList();
  -- BuildItemTables and InitSpellList run only in SetBuffs when SMARTBUFF_BUFFLIST == nil
  -- (single init path, avoids duplicate potion/flask entries).

  --DEFAULT_CHAT_FRAME:AddMessage("SB OnLoad");
end

-- END SMARTBUFF_OnLoad


-- SMARTBUFF_OnEvent
function SMARTBUFF_OnEvent(self, event, ...)
local arg1, arg2, arg3, arg4, arg5 = ...;

  if ((event == "UNIT_NAME_UPDATE" and arg1 == "player") or event == "PLAYER_ENTERING_WORLD") then
    -- Clear valid-spells on login/reload so next buff list build re-validates
    -- (runs before isInit return so combat doesn't skip it).
    if (event == "PLAYER_ENTERING_WORLD" and (arg1 or arg2) and SmartBuffValidSpells) then
      SMARTBUFF_ClearValidSpells();
    end
    if IsPlayerInGuild() and event == "PLAYER_ENTERING_WORLD" then
      C_ChatInfo.SendAddonMessage(SmartbuffPrefix, SMARTBUFF_VERSION, "GUILD")
    end
    isPlayer = true;
    if (event == "PLAYER_ENTERING_WORLD" and isInit and O and O.Toggle) then
      isSetZone = true;
      tStartZone = GetTime();
    end
    if (event == "PLAYER_ENTERING_WORLD" and isLoaded and isPlayer and not isInit and not InCombatLockdown()) then
      SMARTBUFF_Options_Init(self);
    end
  elseif (event == "ADDON_LOADED" and arg1 and (arg1 == SMARTBUFF_TITLE or strfind(arg1, "SmartBuff") == 1)) then
    isLoaded = true;
  end

  -- PLAYER_LOGIN
  if event == "PLAYER_LOGIN" then
    local prefixResult = C_ChatInfo.RegisterAddonMessagePrefix(SmartbuffPrefix)
    -- Load cache on login
    SMARTBUFF_LoadCache();
  end

  -- CHAT_MSG_ADDON
  if event == "CHAT_MSG_ADDON" then
    if arg1 == SmartbuffPrefix then
      -- its us.
      if arg2 then
        if arg2 > SMARTBUFF_VERSION and SmartbuffSession then
          DEFAULT_CHAT_FRAME:AddMessage(SMARTBUFF_MSG_NEWVER1 ..
          SMARTBUFF_VERSION .. SMARTBUFF_MSG_NEWVER2 .. arg2 .. SMARTBUFF_MSG_NEWVER3)
          SmartbuffSession = false
        end
        if arg5 and arg5 ~= UnitName("player") and SmartbuffVerCheck then
          DEFAULT_CHAT_FRAME:AddMessage("|cff00e0ffSmartbuff : |cffFFFF00" ..
          arg5 .. " (" .. arg3 .. ")|cffffffff has revision |cffFFFF00r" .. arg2 .. "|cffffffff installed.")
        end
      end
    end
  end

  if (event == "SMARTBUFF_UPDATE" and isLoaded and isPlayer and not isInit and not InCombatLockdown()) then
    SMARTBUFF_Options_Init(self);
    --    print(buildInfo)
  end

  if (not isInit or O == nil) then
    return;
  end;

  if (event == "PLAYER_REGEN_DISABLED") then
    SMARTBUFF_Ticker(true);

    if (O.Toggle) then
      if (O.InCombat) then
        for spell, data in pairs(cBuffsCombat) do
          if (data and data.Unit and data.ActionType) then
            if (data.Type == SMARTBUFF_CONST_SELF or data.Type == SMARTBUFF_CONST_FORCESELF or data.Type == SMARTBUFF_CONST_STANCE or data.Type == SMARTBUFF_CONST_ITEM) then
              SmartBuff_KeyButton:SetAttribute("unit", nil);
            else
              SmartBuff_KeyButton:SetAttribute("unit", data.Unit);
            end
            SmartBuff_KeyButton:SetAttribute("type", data.ActionType);
            SmartBuff_KeyButton:SetAttribute("spell", spell);
            SmartBuff_KeyButton:SetAttribute("item", nil);
            SmartBuff_KeyButton:SetAttribute("target-slot", nil);
            SmartBuff_KeyButton:SetAttribute("target-item", nil);
            SmartBuff_KeyButton:SetAttribute("macrotext", nil);
            SmartBuff_KeyButton:SetAttribute("action", nil);
            SMARTBUFF_AddMsgD("Enter Combat, set button: " .. spell .. " on " .. data.Unit .. ", " .. data.ActionType);
            break;
          end
        end
      else
        -- In-combat option off: clear button so we don't show a stale out-of-combat reminder in combat
        SmartBuff_KeyButton:SetAttribute("type", nil);
        SmartBuff_KeyButton:SetAttribute("unit", nil);
        SmartBuff_KeyButton:SetAttribute("spell", nil);
        SmartBuff_KeyButton:SetAttribute("item", nil);
        SmartBuff_KeyButton:SetAttribute("macrotext", nil);
        SmartBuff_KeyButton:SetAttribute("action", nil);
      end
      SMARTBUFF_SyncBuffTimers();
      SMARTBUFF_Check(1, true);
    end
  elseif (event == "PLAYER_REGEN_ENABLED") then
    SMARTBUFF_Ticker(true);

    if (O.Toggle) then
      if (O.InCombat) then
        SmartBuff_KeyButton:SetAttribute("type", nil);
        SmartBuff_KeyButton:SetAttribute("unit", nil);
        SmartBuff_KeyButton:SetAttribute("spell", nil);
      end
      SMARTBUFF_SyncBuffTimers();
      SMARTBUFF_Check(1, true);
    end

    -- PLAYER_STARTED_MOVING / PLAYER_STOPPED_MOVING
  elseif (event == "PLAYER_STARTED_MOVING") then
    isPlayerMoving = true;
  elseif (event == "PLAYER_STOPPED_MOVING") then
    isPlayerMoving = false;
  elseif (event == "PLAYER_TALENT_UPDATE") then
    if (SmartBuffOptionsFrame:IsVisible()) then
      SmartBuffOptionsFrame:Hide();
    end
    if (currentSpec ~= GetSpecialization()) then
      currentSpec = GetSpecialization();
      if (B[currentSpec] == nil) then
        B[currentSpec] = {};
      end
      SMARTBUFF_AddMsg(format(SMARTBUFF_MSG_SPECCHANGED, tostring(currentSpec)), true);
      SMARTBUFF_ScheduleSetBuffs();
    end
  elseif (event == "SPELLS_CHANGED" or event == "ACTIONBAR_HIDEGRID") then
    SMARTBUFF_ScheduleSetBuffs();
  end

  if (not isInit or O == nil) then
    return;
  end;

  if (not O.Toggle) then
    return;
  end;

  if (event == "UNIT_AURA") then
    if (UnitAffectingCombat("player") and (arg1 == "player" or string.find(arg1, "^party") or string.find(arg1, "^raid"))) then
      isSyncReq = true;
    end
    -- Detect dismounting: trigger check on next ticker cycle during initialization
    if (arg1 == "player" and isInit) then
      local wasMounted = isMounted;
      isMounted = IsMounted() or IsFlying();
      -- If player just dismounted, trigger check on next ticker cycle
      if (wasMounted and not isMounted) then
        isAuraChanged = true;
      end
    end
  end

  if (event == "UI_ERROR_MESSAGE") then
    SMARTBUFF_AddMsgD(string.format("Error message: %s", arg1));
  end

  if (event == "UNIT_SPELLCAST_FAILED") then
    currentUnit = arg1;
    SMARTBUFF_AddMsgD(string.format("Spell failed: %s", arg1));
    if (currentUnit and (string.find(currentUnit, "party") or string.find(currentUnit, "raid") or (currentUnit == "target" and O.Debug))) then
      if (UnitName(currentUnit) ~= sPlayerName and O.BlacklistTimer > 0) then
        cBlacklist[currentUnit] = GetTime();
        if (currentUnit and UnitName(currentUnit)) then
        end
      end
    end
    currentUnit = nil;
    currentSpell = nil;
    tCastRequested = 0;
  elseif (event == "UNIT_SPELLCAST_SUCCEEDED") then
    if (arg1 and arg1 == "player") then
      local unit = nil;
      local spell = nil;
      local target = nil;
      if (arg1 and arg2) then
        if (not arg3) then arg3 = ""; end
        if (not arg4) then arg4 = ""; end
        SMARTBUFF_AddMsgD("Spellcast succeeded: target " ..
        arg1 .. ", spellID " .. arg3 .. " (" .. C_Spell.GetSpellName(arg3) .. "), " .. arg4)
        if (string.find(arg1, "party") or string.find(arg1, "raid")) then
          spell = arg2;
        end
        --SMARTBUFF_SetButtonTexture(SmartBuff_KeyButton, imgSB);
      end

      if (currentUnit and currentSpell and currentUnit ~= "target") then
        unit = currentUnit;
        spell = currentSpell;
      end

      if (unit) then
        local name = UnitName(unit);
        if (cBuffTimer[unit] == nil) then
          cBuffTimer[unit] = {};
        end
        cBuffTimer[unit][spell] = GetTime();
        
        -- Check if this is an ITEM type creation spell (like Create Healthstone)
        -- If so, reset tLastCheck to prevent immediate extra check before item appears in inventory
        if (spell and cBuffIndex[spell]) then
          local buffIndex = cBuffIndex[spell];
          local cBI = cBuffs[buffIndex];
          if (cBI and cBI.Type == SMARTBUFF_CONST_ITEM) then
            -- Reset check timer so next check happens after normal interval (prevents extra out-of-order check)
            tLastCheck = GetTime();
            SMARTBUFF_AddMsgD("ITEM type spell cast succeeded, resetting check timer");
          end
        end
        
        if (name ~= nil) then
          SMARTBUFF_AddMsg(name .. ": " .. spell .. " " .. SMARTBUFF_MSG_BUFFED);
          currentUnit = nil;
          currentSpell = nil;
          tCastRequested = 0;
        end
      end

      if (isClearSplash) then
        isClearSplash = false;
        SMARTBUFF_Splash_Clear();
      end
    end
  end

  -- Cache-related event handlers for partial reloads
  -- Note: These handlers are after isInit check, so isInit and O are guaranteed to be valid
  if (event == "NEW_TOY_ADDED") then
    if (O.Toggle) then
      -- Reload toys when a new toy is added (full rebuild; toyID not always guaranteed)
      SMARTBUFF_ReloadToys();
    end
  elseif (event == "BAG_UPDATE") then
    -- Only process character bags (0-5: backpack, equipped bags, reagent bag)
    -- Bank bags (6-12) don't need to trigger reload
    local bagID = arg1;
    if (bagID and bagID >= 0 and bagID <= 5 and O.Toggle) then
      -- Check for new items in character bags (debounced to avoid spam)
      if (not SMARTBUFF_BagUpdateTimer) then
        SMARTBUFF_BagUpdateTimer = C_Timer.After(0.5, function()
          SMARTBUFF_ReloadItems();
          SMARTBUFF_BagUpdateTimer = nil;
        end);
      end
    end
  elseif (event == "SPELLS_CHANGED" or event == "PLAYER_LEVEL_UP" or event == "PLAYER_SPECIALIZATION_CHANGED") then
    -- Clear valid-spells cache so next buff list build re-validates (level-up, spec change, false negatives)
    SMARTBUFF_ClearValidSpells();
    if (O.Toggle) then
      -- Reload spells when spells change, level up, or spec changes
      -- Only reload spell IDs, not static tables from buffs.lua
      SMARTBUFF_ReloadSpells();
    end
  elseif (event == "ITEM_DATA_LOAD_RESULT" or event == "SPELL_DATA_LOAD_RESULT") then
    -- Item/Spell data finished loading (or failed) - validate, update cache, and rebuild buff list only when we actually updated
    local dataID, success = ...;
    if (success and isInit and O and O.Toggle) then
      local cache = SmartBuffItemSpellCache;
      local didUpdate = false;  -- Only trigger full rebuild when we actually wrote to cache (avoids rebuild spam)
      if (cache and cache.needsRefresh) then
        if (event == "ITEM_DATA_LOAD_RESULT") then
          local varName = SMARTBUFF_ExpectedData.itemIDToVarName and SMARTBUFF_ExpectedData.itemIDToVarName[dataID];
          if (varName) then
            local itemName, itemLink, itemRarity, itemLevel, minLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, texture = C_Item.GetItemInfo(dataID);
            if (itemLink and SMARTBUFF_ValidateItemData(itemLink, minLevel, texture)) then
              if (not cache.items) then cache.items = {}; end
              if (not cache.itemIDs) then cache.itemIDs = {}; end
              if (not cache.itemData) then cache.itemData = {}; end
              cache.items[varName] = itemLink;
              cache.itemIDs[varName] = dataID;
              cache.itemData[varName] = {minLevel or 0, texture or 0};
              cache.needsRefresh[varName] = false;
              _G[varName] = itemLink;
              local placeholder = "item:" .. tostring(dataID);
              for _, buffTable in pairs({SMARTBUFF_SCROLL, SMARTBUFF_FOOD, SMARTBUFF_POTION, SMARTBUFF_WEAPON}) do
                if (buffTable) then
                  for _, buff in pairs(buffTable) do
                    if (buff[1] == placeholder) then buff[1] = itemLink; end
                  end
                end
              end
              if (SG.Toybox and SG.Toybox[placeholder]) then
                local toyData = SG.Toybox[placeholder];
                SG.Toybox[itemLink] = toyData;
                SG.Toybox[placeholder] = nil;
                if (SG.ToyboxByID) then
                  SG.ToyboxByID[dataID] = toyData;
                end
              end
              didUpdate = true;
            else
              cache.needsRefresh[varName] = true;
              C_Item.RequestLoadItemDataByID(dataID);
            end
          end
        elseif (event == "SPELL_DATA_LOAD_RESULT") then
          local varName = SMARTBUFF_ExpectedData.spellIDToVarName and SMARTBUFF_ExpectedData.spellIDToVarName[dataID];
          if (varName) then
            local spellInfo = C_Spell.GetSpellInfo(dataID);
            if (spellInfo and SMARTBUFF_ValidateSpellData(spellInfo)) then
              if (not cache.spells) then cache.spells = {}; end
              cache.spells[varName] = spellInfo;
              cache.needsRefresh[varName] = false;
              _G[varName] = spellInfo;
              didUpdate = true;
            else
              cache.needsRefresh[varName] = true;
              C_Spell.RequestLoadSpellData(dataID);
            end
          end
        end
      end
      -- Schedule one full rebuild when we actually updated cache (coalesced via ScheduleSetBuffs)
      if (didUpdate) then
        SMARTBUFF_ScheduleSetBuffs();
      end
    end
  end

  if event == "ZONE_CHANGED_NEW_AREA" or event == "GROUP_ROSTER_UPDATE" or event == "PLAYER_LEVEL_UP" or event == "PLAYER_SPECIALIZATION_CHANGED" then
      SMARTBUFF_SetTemplate()
  end
end

-- END SMARTBUFF_OnEvent


function SMARTBUFF_OnUpdate(self, elapsed)
  if not self.Elapsed then
    self.Elapsed = 0.5  -- Throttle: 0.5s reduces CPU vs 0.2s (2 checks/sec vs 5)
  end
  self.Elapsed = self.Elapsed - elapsed
  if self.Elapsed > 0 then
    return
  end
  self.Elapsed = 0.5

  if (not isInit) then
    if (isLoaded and GetTime() > tAutoBuff + 0.5) then
      tAutoBuff = GetTime();
      local specID = GetSpecialization()
      if (specID) then
        SMARTBUFF_OnEvent(self, "SMARTBUFF_UPDATE");
      end
    end
  else
    SMARTBUFF_Ticker();
    SMARTBUFF_Check(1);
  end
end

function SMARTBUFF_Ticker(force)
  if (force or GetTime() > tTicker + 1) then
    tTicker = GetTime();

    if (isSyncReq or tTicker > tSync + 10) then
      SMARTBUFF_SyncBuffTimers();
    end

    if (isAuraChanged) then
      isAuraChanged = false;
      SMARTBUFF_Check(1, true);
    end
  end
end

-- Will dump the value of msg to the default chat window
function SMARTBUFF_AddMsg(msg, force)
  if (DEFAULT_CHAT_FRAME and (force or not O.ToggleMsgNormal)) then
    DEFAULT_CHAT_FRAME:AddMessage(YLL .. msg .. "|r");
  end
end

function SMARTBUFF_AddMsgErr(msg, force)
  if (DEFAULT_CHAT_FRAME and (force or not O.ToggleMsgError)) then
    DEFAULT_CHAT_FRAME:AddMessage(RDL .. SMARTBUFF_TITLE .. ": " .. msg .. "|r");
  end
end

function SMARTBUFF_AddMsgWarn(msg, force)
  if (DEFAULT_CHAT_FRAME and (force or not O.ToggleMsgWarning)) then
    if (isParrot) then
      Parrot:ShowMessage(CY .. msg .. "|r");
    else
      DEFAULT_CHAT_FRAME:AddMessage(CY .. msg .. "|r");
    end
  end
end

function SMARTBUFF_AddMsgD(msg, r, g, b)
  if (not O or not O.Debug) then return; end  -- Early-out to avoid work when Debug off
  if (r == nil) then r = 0.5; end
  if (g == nil) then g = 0.8; end
  if (b == nil) then b = 1; end
  if (DebugChatFrame) then
    DebugChatFrame:AddMessage(msg, r, g, b);
  end
end

Enum.SmartBuffGroup = {
  Solo = 1,
  Party = 2,
  LFR = 3,
  Raid = 4,
  MythicKeystone = 5,
  HorrificVision = 6,
  Delve = 7,
  Battleground = 8,
  Arena = 9,
  NerubarRaid = 10,
  UndermineRaid = 11,
  Custom1 = 12,
  Custom2 = 13,
  Custom3 = 14,
  Custom4 = 15,
  Custom5 = 16
}

-- Set the current template and create an array of units
function SMARTBUFF_SetTemplate(force)
  -- Only block in combat (not when mounted) - setup should work when mounted
  -- Mount check only blocks actual buff checking/casting, not data structure setup
  if (not force and InCombatLockdown()) then return end
  -- When force (e.g. from Options_Init), always run SetBuffs so reminder loop has state even if version prompt left options open
  if (not force and SmartBuffOptionsFrame:IsVisible()) then return end

  -- Ensure currentTemplate is set (fallback to Solo if nil)
  if (currentTemplate == nil) then
    currentTemplate = SMARTBUFF_TEMPLATES[Enum.SmartBuffGroup.Solo];
  end
  
  local newTemplate = currentTemplate -- default to old template

  -- if autoswitch no group change is enabled, load new template based on group composition
  if O.AutoSwitchTemplate then
    newTemplate = SMARTBUFF_TEMPLATES[Enum.SmartBuffGroup.Solo];
    local name, instanceType, difficultyID, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceID, instanceGroupSize, LfgDungeonID = GetInstanceInfo()
    --printd("name: " .. name, ", instanceType: " .. instanceType .. ", difficultyID: " .. difficultyID .. ", difficultyName: " .. difficultyName, ", instanceID: " .. instanceID)

    if IsInRaid() then
      newTemplate = SMARTBUFF_TEMPLATES[Enum.SmartBuffGroup.Raid];
    elseif IsInGroup() then
      newTemplate = SMARTBUFF_TEMPLATES[Enum.SmartBuffGroup.Party];
    end
    -- check instance type (allows solo raid clearing, etc)
    if instanceType == "raid" then
      newTemplate = SMARTBUFF_TEMPLATES[Enum.SmartBuffGroup.Raid];
      if LfgDungeonID then
        newTemplate = SMARTBUFF_TEMPLATES[Enum.SmartBuffGroup.LFR];
      end
    elseif instanceType == "party" then
      newTemplate = SMARTBUFF_TEMPLATES[Enum.SmartBuffGroup.Party];
      if (difficultyID == 8) then
        newTemplate = SMARTBUFF_TEMPLATES[Enum.SmartBuffGroup.MythicKeystone];
      end
    end
    if (difficultyID == 152) then
      newTemplate = SMARTBUFF_TEMPLATES[Enum.SmartBuffGroup.HorrificVision];
    elseif (difficultyID == 208) then
      newTemplate = SMARTBUFF_TEMPLATES[Enum.SmartBuffGroup.Delve];
    end
  end

  -- if autoswitch on instance change is enabled, load new instance template if any, unless in LFR
  local isRaidInstanceTemplate = false
  if O.AutoSwitchTemplateInst and not (newTemplate == SMARTBUFF_TEMPLATES[Enum.SmartBuffGroup.LFR]) then
    local zone = GetRealZoneText()
    local instances = Enum.MakeEnumFromTable(SMARTBUFF_INSTANCES);
    local i = instances[zone]
    if i and SMARTBUFF_TEMPLATES[i + Enum.SmartBuffGroup.Arena] then
      newTemplate = SMARTBUFF_TEMPLATES[i + Enum.SmartBuffGroup.Arena]
      isRaidInstanceTemplate = true
    end
  end

  if currentTemplate ~= newTemplate then
    SMARTBUFF_AddMsgD("Current tmpl: " .. currentTemplate or "nil" .. " - new tmpl: " .. newTemplate or "nil");
    SMARTBUFF_AddMsg(SMARTBUFF_TITLE ..
    " :: " .. SMARTBUFF_OFT_AUTOSWITCHTMP .. ": " .. currentTemplate .. " -> " .. newTemplate);
  end
  currentTemplate = newTemplate;

  SMARTBUFF_SetBuffs();
  wipe(cBlacklist);
  wipe(cBuffTimer);
  wipe(cUnits);
  wipe(cGroups);
  cClassGroups = nil;
  wipe(cAddUnitList);
  wipe(cIgnoreUnitList);

  -- Raid Setup, including smart instance templates
  if currentTemplate == (SMARTBUFF_TEMPLATES[Enum.SmartBuffGroup.Raid]) or isRaidInstanceTemplate then
    cClassGroups = {};
    local name, server, rank, subgroup, level, class, classeng, zone, online, isDead;
    local sRUnit = nil;

    j = 1;
    for n = 1, maxRaid, 1 do
      name, rank, subgroup, level, class, classeng, zone, online, isDead = GetRaidRosterInfo(n);
      if (name) then
        server = nil;
        i = string.find(name, "-", 1, true);
        if (i and i > 0) then
          server = string.sub(name, i + 1);
          name   = string.sub(name, 1, i - 1);
          SMARTBUFF_AddMsgD(name .. ", " .. server);
        end
        sRUnit = "raid" .. n;

        --SMARTBUFF_AddMsgD(name .. ", " .. sRUnit .. ", " .. UnitName(sRUnit));

        SMARTBUFF_AddUnitToClass("raid", n);
        SmartBuff_AddToUnitList(1, sRUnit, subgroup);
        SmartBuff_AddToUnitList(2, sRUnit, subgroup);

        if (name == sPlayerName and not server) then
          psg = subgroup;
        end

        if (O.ToggleGrp[subgroup]) then
          s = "";
          if (name == UnitName(sRUnit)) then
            if (cGroups[subgroup] == nil) then
              cGroups[subgroup] = {};
            end
            if (name == sPlayerName and not server) then b = true; end
            cGroups[subgroup][j] = sRUnit;
            j = j + 1;
          end
        end
        -- attempt to announce the addon version (if they have it)
        -- seems to be an issue with cross-realm, need to look at this later
        -- but in the meantime I am disabling it...  CM
        -- if online then SendSmartbuffVersion(name, sRUnit) end
      end
    end --end for

    if (not b or B[CS()][currentTemplate].SelfFirst) then
      SMARTBUFF_AddSoloSetup();
      --SMARTBUFF_AddMsgD("Player not in selected groups or buff self first");
    end

    SMARTBUFF_AddMsgD("Raid Unit-Setup finished");

    -- Party Setup
  elseif (currentTemplate == (SMARTBUFF_TEMPLATES[Enum.SmartBuffGroup.Party])) then
    cClassGroups = {};
    if (B[CS()][currentTemplate].SelfFirst) then
      SMARTBUFF_AddSoloSetup();
      --SMARTBUFF_AddMsgD("Buff self first");
    end

    cGroups[1] = {};
    cGroups[1][0] = "player";
    SMARTBUFF_AddUnitToClass("player", 0);
    for j = 1, 4, 1 do
      cGroups[1][j] = "party" .. j;
      SMARTBUFF_AddUnitToClass("party", j);
      SmartBuff_AddToUnitList(1, "party" .. j, 1);
      SmartBuff_AddToUnitList(2, "party" .. j, 1);
      name, _, _, _, _, _, _, online, _, _ = GetRaidRosterInfo(j);
      if name and online then SendSmartbuffVersion(name, "party") end
    end
    SMARTBUFF_AddMsgD("Party Unit-Setup finished");

    -- Solo Setup
  else
    SMARTBUFF_AddSoloSetup();
    SMARTBUFF_AddMsgD("Solo Unit-Setup finished");
  end
  --collectgarbage();
end

function SMARTBUFF_AddUnitToClass(unit, i)
  local u = unit;
  local up = "pet";
  if (unit ~= "player") then
    u = unit .. i;
    up = unit .. "pet" .. i;
  end
  if (UnitExists(u)) then
    if (not cUnits[1]) then
      cUnits[1] = {};
    end
    cUnits[1][i] = u;
    SMARTBUFF_AddMsgD("Unit added: " .. UnitName(u) .. ", " .. u);

    local _, uc = UnitClass(u);
    if (uc and not cClassGroups[uc]) then
      cClassGroups[uc] = {};
    end
    if (uc) then
      cClassGroups[uc][i] = u;
    end
  end
end

function SMARTBUFF_AddSoloSetup()
  cGroups[0] = {};
  cGroups[0][0] = "player";
  cUnits[0] = {};
  cUnits[0][0] = "player";
  if (sPlayerClass == "HUNTER" or sPlayerClass == "WARLOCK" or sPlayerClass == "DEATHKNIGHT" or sPlayerClass == "MAGE") then cGroups[0][1] =
    "pet"; end

  if (B[CS()][currentTemplate] and B[CS()][currentTemplate].SelfFirst) then
    if (not cClassGroups) then
      cClassGroups = {};
    end
    cClassGroups[0] = {};
    cClassGroups[0][0] = "player";
  end
end

-- END SMARTBUFF_SetUnits


-- Get Spell ID from spellbook
function SMARTBUFF_GetSpellID(spellname)
  local i, id = 1, nil;
  local spellN, spellId, skillType;
  if (spellname) then
    spellname = string.lower(spellname);
  else
    return nil;
  end
  while C_SpellBook.GetSpellBookItemName(i, Enum.SpellBookSpellBank.Player) do
    spellN = C_SpellBook.GetSpellBookItemName(i, Enum.SpellBookSpellBank.Player);
    skillType, spellId = C_SpellBook.GetSpellBookItemType(i, Enum.SpellBookSpellBank.Player);
--    print(spellN .. " " .. spellId);
--    print(skillType)
    if (skillType == "FLYOUT") then
      for j = 1, GetNumFlyouts() do
        local fid = GetFlyoutID(j);
        local name, description, numSlots, isKnown = GetFlyoutInfo(fid)
        if (isKnown) then
          for s = 1, numSlots do
            local flySpellID, overrideSpellID, isKnown, spellN, slotSpecID = GetFlyoutSlotInfo(fid, s);
            if (isKnown and string.lower(spellN) == spellname) then
--              print(spellname .. " " .. spellN .. " " .. flySpellID);
              return flySpellID;
            end
          end
        end
      end
    end
    if (spellN ~= nil and string.lower(spellN) == spellname) then
      id = spellId;
      break;
    end
    i = i + 1;
  end
  if (id) then
    -- IsPassiveSpell is a legacy function that no longer exists in modern WoW API
    -- Passive spells are typically not usable, so we skip them via IsSpellKnown check
    -- FUTURESPELL indicates a spell not yet learned, so skip it
    if (skillType == "FUTURESPELL" or not IsSpellKnown(id)) then
      id = nil;
      i = nil;
    end
  end
  return id, i;
end

-- END SMARTBUFF_GetSpellID

-- Get current buff counts from cBuffs array (final list)
-- Returns a table with counts by category
function SMARTBUFF_GetCurrentBuffCounts()
  local counts = {
    SCROLL = 0,
    FOOD = 0,
    POTION = 0,
    SELF = 0,
    GROUP = 0,
    ITEM = 0,
    TOTAL = 0
  };
  
  -- Count from cBuffs array (final list)
  local maxIndex = 0;
  for i, _ in pairs(cBuffs) do
    if (type(i) == "number" and i > maxIndex) then
      maxIndex = i;
    end
  end
  
  for i = 1, maxIndex do
    if (cBuffs[i] and cBuffs[i].Type) then
      local buffType = cBuffs[i].Type;
      if (counts[buffType] ~= nil) then
        counts[buffType] = counts[buffType] + 1;
      end
      counts.TOTAL = counts.TOTAL + 1;
    end
  end
  
  return counts;
end

-- Verify buff list completeness by comparing current counts to cache
-- Returns: true if counts match or exceed cache, false if significantly lower
-- Note: Following AllTheThings pattern - this is informational only, we accept partial data
function SMARTBUFF_VerifyBuffList()
  local cache = SmartBuffBuffListCache;
  if (not cache or not cache.version) then
    -- No cache exists yet - first run, accept whatever we have
    return true;
  end
  
  local currentCounts = SMARTBUFF_GetCurrentBuffCounts();
  local expectedCounts = cache.expectedCounts;
  
  -- If current total is significantly lower than cache (< 80%), items might still be loading
  -- But we accept it anyway (AllTheThings pattern: accept partial data)
  if (expectedCounts.TOTAL > 0 and currentCounts.TOTAL < expectedCounts.TOTAL * 0.8) then
    return false;  -- Likely incomplete, but we'll accept it
  end
  
  -- If current total matches or exceeds cache, initialization is likely complete
  -- (exceeding is OK - player may have acquired new items)
  return true;
end

-- Partial reload functions for event-based updates
-- These functions only update what's needed without rebuilding static tables from buffs.lua
-- Static tables (SMARTBUFF_SCROLL, SMARTBUFF_FOOD, etc.) are only rebuilt on initial load or reset

-- Reload toys only (called when NEW_TOY_ADDED fires)
-- Only reloads toy collection, does NOT rebuild static tables
function SMARTBUFF_ReloadToys()
  if (InCombatLockdown()) then return; end
  SMARTBUFF_LoadToys();
  -- Trigger rebuild of cBuffs from existing static tables to include new toys
  SMARTBUFF_ScheduleSetBuffs();
end

-- Reload items from inventory (called when BAG_UPDATE fires for character bags)
-- Does NOT rebuild static tables - just triggers rebuild of cBuffs which checks bags
function SMARTBUFF_ReloadItems()
  if (InCombatLockdown()) then return; end
  -- Trigger rebuild of cBuffs - SMARTBUFF_SetBuff() will check bags via SMARTBUFF_FindItem()
  -- Don't call SMARTBUFF_InitItemList() as that rebuilds static item variables unnecessarily
  SMARTBUFF_ScheduleSetBuffs();
end

-- Reload spells (called when SPELLS_CHANGED, PLAYER_LEVEL_UP, or PLAYER_SPECIALIZATION_CHANGED fires)
-- Only reloads spell IDs, does NOT rebuild static tables from buffs.lua
function SMARTBUFF_ReloadSpells()
  if (InCombatLockdown()) then return; end
  -- Only reload spell IDs - static tables from buffs.lua don't change during gameplay
  SMARTBUFF_InitSpellIDs();
  -- Trigger rebuild of cBuffs from existing static tables with updated spell IDs
  SMARTBUFF_ScheduleSetBuffs();
end

-- Schedule a single full buff list rebuild after 0.5s. Only one timer at a time: further calls
-- while pending are ignored, so a burst of events yields one run 0.5s after the first. PreCheck
-- no longer calls SetBuffs from OnUpdate, so this avoids high CPU/memory after login/reload.
function SMARTBUFF_ScheduleSetBuffs()
  if (setBuffsPending) then return; end
  setBuffsPending = true;
  isSetBuffs = true;
  C_Timer.After(0.5, function()
    setBuffsPending = false;
    isSetBuffs = false;
    if (not InCombatLockdown() and isInit and O and O.Toggle) then
      SMARTBUFF_SetBuffs();
      isSyncReq = true;
    end
  end);
end

-- Set the buff array
function SMARTBUFF_SetBuffs()
  if (InCombatLockdown()) then return end
  if (B == nil) then return; end

  local n = 1;
  local buff = nil;
  local ct = currentTemplate;

  if (B[CS()] == nil) then
    B[CS()] = {};
  end

  -- Load cache for verification
  SMARTBUFF_LoadCache();

  -- Only rebuild static tables from buffs.lua if they're not already populated
  -- Static tables don't change during gameplay, only on initial load or reset
  if (SMARTBUFF_BUFFLIST == nil) then
    -- Clear expected data list before building
    SMARTBUFF_ExpectedData.items = {};
    SMARTBUFF_ExpectedData.spells = {};
    SMARTBUFF_InitSpellIDs();
    SMARTBUFF_InitItemList();
    -- Sync cache with expected list (remove extras, add missing, flag all as needsRefresh)
    SMARTBUFF_SyncItemSpellCache();
    SMARTBUFF_BuildItemTables();
    SMARTBUFF_InitSpellList();
    -- Load toys on initial setup
    SMARTBUFF_LoadToys();
    -- Retry once after a delay so item data (flasks, toys) that was not yet loaded can be picked up
    C_Timer.After(1.5, function()
      if (isInit and O and O.Toggle and not InCombatLockdown() and B) then
        SMARTBUFF_LoadToys();
        SMARTBUFF_SetBuffs();
      end
    end);
  elseif (SMARTBUFF_PLAYERCLASS ~= sPlayerClass) then
    -- Player class changed (shouldn't happen, but be safe)
    SMARTBUFF_ExpectedData.items = {};
    SMARTBUFF_ExpectedData.spells = {};
    SMARTBUFF_InitSpellIDs();
    SMARTBUFF_SyncItemSpellCache();
    SMARTBUFF_InitSpellList();
  else
    -- Static tables already populated - only reload spell IDs if needed (for spell availability)
    -- Don't rebuild static tables unnecessarily
    SMARTBUFF_ExpectedData.spells = {};  -- Only rebuild spell expected list
    SMARTBUFF_InitSpellIDs();
    -- Sync only spells (items haven't changed)
    if (SmartBuffItemSpellCache and SmartBuffItemSpellCache.spells) then
      local expected = SMARTBUFF_ExpectedData;
      for varName, _ in pairs(SmartBuffItemSpellCache.spells) do
        if (not expected.spells[varName]) then
          SmartBuffItemSpellCache.spells[varName] = nil;
          if (SmartBuffItemSpellCache.needsRefresh) then
            SmartBuffItemSpellCache.needsRefresh[varName] = nil;
          end
        end
      end
      for varName, spellId in pairs(expected.spells) do
        if (not SmartBuffItemSpellCache.spells[varName]) then
          SmartBuffItemSpellCache.spells[varName] = nil;
          if (not SmartBuffItemSpellCache.needsRefresh) then
            SmartBuffItemSpellCache.needsRefresh = {};
          end
          SmartBuffItemSpellCache.needsRefresh[varName] = true;
        else
          if (not SmartBuffItemSpellCache.needsRefresh) then
            SmartBuffItemSpellCache.needsRefresh = {};
          end
          SmartBuffItemSpellCache.needsRefresh[varName] = true;
        end
      end
    end
    -- Don't reload toys if already verified via cache
    -- Toys will only reload when NEW_TOY_ADDED event fires
  end

  if (B[CS()][ct] == nil) then
    B[CS()][ct] = {};
    B[CS()][ct].SelfFirst = false;
  end

  CleanBuffSettingsCruft();

  wipe(cBuffs);
  wipe(cBuffIndex);
  numBuffs = 0;

  for _, buff in pairs(SMARTBUFF_BUFFLIST) do
    n = SMARTBUFF_SetBuff(buff, n, true);
  end

  for _, buff in pairs(SMARTBUFF_WEAPON) do
    n = SMARTBUFF_SetBuff(buff, n);
  end

  for _, buff in pairs(SMARTBUFF_RACIAL) do
    n = SMARTBUFF_SetBuff(buff, n);
  end

  for _, buff in pairs(SMARTBUFF_TRACKING) do
    n = SMARTBUFF_SetBuff(buff, n);
  end

  for _, buff in pairs(SMARTBUFF_POTION) do
    n = SMARTBUFF_SetBuff(buff, n);
  end

  for _, buff in pairs(SMARTBUFF_SCROLL) do
    n = SMARTBUFF_SetBuff(buff, n);
  end

  for _, buff in pairs(SMARTBUFF_FOOD) do
    n = SMARTBUFF_SetBuff(buff, n);
  end

  wipe(cBuffsCombat);
  SMARTBUFF_SetInCombatBuffs();

  numBuffs = n - 1;

  -- Accept current state (even if incomplete) - following AllTheThings pattern
  -- Don't retry indefinitely - accept partial data and let events handle updates
  local currentCounts = SMARTBUFF_GetCurrentBuffCounts();
  
  -- Count toys separately (stored in S.Toybox, not in static tables)
  local toyCount = 0;
  if (SG.Toybox) then
    for _ in pairs(SG.Toybox) do
      toyCount = toyCount + 1;
    end
  end
  
  -- Note: currentCounts includes items/spells that made it into cBuffs[]
  -- Items/spells that returned nil during SMARTBUFF_SetBuff() were filtered out
  -- This is expected - they'll be added when ITEM_DATA_LOAD_RESULT/SPELL_DATA_LOAD_RESULT fires
  
  -- Save cache with current state (accept partial data like AllTheThings)
  -- For items use only canonical key "item:ID" and that entry's state so duplicate keys (link vs canonical) don't both get added
  local enabledBuffsSnapshot = {};
  local seenItemIDs = {};
  if (B[CS()] and B[CS()][ct]) then
    for buffName, settings in pairs(B[CS()][ct]) do
      if (type(settings) == "table" and (settings.EnableS or settings.EnableG)) then
        local id = (type(buffName) == "string") and tonumber(string.match(buffName, "item:(%d+)"));
        if (id) then
          if (not seenItemIDs[id]) then
            seenItemIDs[id] = true;
            local canonical = "item:" .. tostring(id);
            local entry = B[CS()][ct][canonical] or settings;
            if (type(entry) == "table" and (entry.EnableS or entry.EnableG)) then
              tinsert(enabledBuffsSnapshot, canonical);
            end
          end
        else
          tinsert(enabledBuffsSnapshot, buffName);
        end
      end
    end
  end
  SMARTBUFF_SaveCache(currentCounts, enabledBuffsSnapshot, toyCount);
  InitBuffOrder(false);

  -- Redraw options buff list if open so item/spell names appear when data loads (no close/reopen needed)
  if (SmartBuffOptionsFrame and SmartBuffOptionsFrame:IsVisible()) then SMARTBUFF_BuffOrderOnScroll(); end

  -- Note: If items/spells are still loading, ITEM_DATA_LOAD_RESULT/SPELL_DATA_LOAD_RESULT events will trigger rebuild
  -- This follows AllTheThings pattern: accept partial data, mark what's missing, let events handle updates

  isSetBuffs = false;
end

-- Helper function to extract itemID from itemLink string or itemID number
-- Returns itemID (number) or nil
local function ExtractItemID(item)
  if (type(item) == "number") then
    return item;
  elseif (type(item) == "string") then
    return tonumber(string.match(item, "item:(%d+)"));
  end
  return nil;
end

-- Helper for UI display: resolve spell/item IDs and varNames to display names using cache first, then API.
-- buffType (optional): when provided and SMARTBUFF_IsItem(buffType), resolve numeric/ID as item only;
-- when spell-like, spell only; when nil, keep current fallback.
local function GetBuffDisplayName(buffName, buffType)
  if (buffName == nil) then return nil; end

  local cache = SmartBuffItemSpellCache;
  local expected = SMARTBUFF_ExpectedData;
  local forceItem = (buffType ~= nil) and SMARTBUFF_IsItem(buffType);
  local forceSpell = (buffType ~= nil) and not SMARTBUFF_IsItem(buffType);

  if (type(buffName) == "number") then
    if (not forceItem) then
      local varName = expected and expected.spellIDToVarName and expected.spellIDToVarName[buffName];
      if (varName and cache and cache.spells and cache.spells[varName]) then
        local spellInfo = cache.spells[varName];
        if (spellInfo and spellInfo.name) then
          return spellInfo.name;
        end
      end
      if (forceSpell) then
        local spellName = C_Spell.GetSpellName(buffName);
        if (spellName) then return spellName; end
        return tostring(buffName);
      end
    end
    if (not forceSpell) then
      local varName = expected and expected.itemIDToVarName and expected.itemIDToVarName[buffName];
      if (varName and cache and cache.items and cache.items[varName]) then
        return cache.items[varName];
      end
      local itemName, itemLink = C_Item.GetItemInfo(buffName);
      if (itemLink) then return itemLink; end
      if (itemName) then return itemName; end
      if (forceItem) then
        C_Item.RequestLoadItemDataByID(buffName);
        return tostring(buffName);
      end
    end
    if (buffType == nil) then
      local spellName = C_Spell.GetSpellName(buffName);
      if (spellName) then return spellName; end
      C_Item.RequestLoadItemDataByID(buffName);
    end
    return tostring(buffName);
  elseif (type(buffName) == "string") then
    if (string.match(buffName, "^|c")) then
      return buffName;
    end

    if (not forceItem) then
      if (cache and cache.spells and cache.spells[buffName]) then
        local spellInfo = cache.spells[buffName];
        if (spellInfo and spellInfo.name) then
          return spellInfo.name;
        end
      end
    end
    if (not forceSpell) then
      if (cache and cache.items and cache.items[buffName]) then
        return cache.items[buffName];
      end
    end

    local itemID = nil;
    local isItemKey = string.match(buffName, "^item:%d+");
    if (isItemKey) then
      itemID = ExtractItemID(buffName);
    else
      local num = tonumber(buffName);
      if (num and tostring(num) == buffName) then
        itemID = num;
      end
    end

    if (itemID) then
      -- "item:ID" format: always resolve as item only
      if (isItemKey or forceItem) then
        local varName = expected and expected.itemIDToVarName and expected.itemIDToVarName[itemID];
        if (varName and cache and cache.items and cache.items[varName]) then
          return cache.items[varName];
        end
      local itemName, itemLink = C_Item.GetItemInfo(itemID);
      if (itemLink) then return itemLink; end
      if (itemName) then return itemName; end
      C_Item.RequestLoadItemDataByID(itemID);
        return tostring(itemID);
      end
      if (forceSpell) then
        local varName = expected and expected.spellIDToVarName and expected.spellIDToVarName[itemID];
        if (varName and cache and cache.spells and cache.spells[varName]) then
          local spellInfo = cache.spells[varName];
          if (spellInfo and spellInfo.name) then
            return spellInfo.name;
          end
        end
        local spellName = C_Spell.GetSpellName(itemID);
        if (spellName) then return spellName; end
        return tostring(itemID);
      end
      -- buffType == nil: current fallback (spell then item)
      local varName = expected and expected.spellIDToVarName and expected.spellIDToVarName[itemID];
      if (varName and cache and cache.spells and cache.spells[varName]) then
        local spellInfo = cache.spells[varName];
        if (spellInfo and spellInfo.name) then
          return spellInfo.name;
        end
      end
      varName = expected and expected.itemIDToVarName and expected.itemIDToVarName[itemID];
      if (varName and cache and cache.items and cache.items[varName]) then
        return cache.items[varName];
      end
      local itemName, itemLink = C_Item.GetItemInfo(itemID);
      if (itemName) then return itemName; end
      if (itemLink) then return itemLink; end
      C_Item.RequestLoadItemDataByID(itemID);
      return ("Item " .. tostring(itemID));
    end
  end

  -- Never show raw "item:ID" to user (splash, chat, UI) – only if we didn't handle it above
  local id = (type(buffName) == "string") and tonumber(string.match(buffName, "item:(%d+)"));
  if (id) then
    local itemName, itemLink = C_Item.GetItemInfo(id);
    if (itemName) then return itemName; end
    if (itemLink) then return itemLink; end
    return ("Item " .. tostring(id));
  end
  return buffName;
end

function SMARTBUFF_SetBuff(buff, i, ia)
  if (buff == nil or buff[1] == nil) then return i; end
  local isItemType = (SMARTBUFF_IsItem(buff[3]) or buff[3] == SMARTBUFF_CONST_WEAPON);
  -- For item-type buffs, always resolve canonical itemID (from number, "item:ID", or link) so we dedupe and store one key only
  local itemID = nil;
  if (type(buff[1]) == "number" and buff[1] > 0) then
    itemID = buff[1];
  elseif (type(buff[1]) == "string") then
    itemID = ExtractItemID(buff[1]);
  end
  local key = (type(buff[1]) == "string") and buff[1] or nil;
  -- Dedupe item-type buffs: same key or same canonical item ID (avoids duplicate potion/flask/food entries)
  if (key and isItemType and cBuffIndex[key]) then return i; end
  if (itemID and isItemType and cBuffIndex["item:" .. tostring(itemID)]) then return i; end
  cBuffs[i] = nil;
  cBuffs[i] = {};
  if (type(buff[1]) == "table")
  then
    cBuffs[i].BuffS = buff[1].name;
  else
    -- Item-type buffs: store canonical "item:ID" only so Order and B[][][] use one key (no link vs placeholder vs number split)
    if (itemID and isItemType) then
      cBuffs[i].BuffS = "item:" .. tostring(itemID);
    else
      cBuffs[i].BuffS = buff[1];
    end
  end
  cBuffs[i].DurationS = ceil(buff[2] * 60);
  cBuffs[i].Type = buff[3];
  cBuffs[i].CanCharge = false;

  if (SMARTBUFF_IsSpell(cBuffs[i].Type)) then
    -- Extract spellID from buff[1] - cached spellInfo table has spellID, spell name string needs lookup
    if (type(buff[1]) == "table" and buff[1].spellID) then
      cBuffs[i].IDS = buff[1].spellID;
    elseif (cBuffs[i].BuffS) then
      cBuffs[i].IDS, cBuffs[i].BookID = SMARTBUFF_GetSpellID(cBuffs[i].BuffS);
    end
    
    -- Filter invalid/uncastable spells using valid spells cache
    if (cBuffs[i].IDS and SmartBuffValidSpells and SmartBuffValidSpells.spells) then
      local isValid = SmartBuffValidSpells.spells[cBuffs[i].IDS];
      if (isValid == false) then
        -- Spell marked as invalid - filter out
        cBuffs[i] = nil;
        return i;
      elseif (isValid == nil) then
        -- Spell not yet validated - check now
        local spellName = C_Spell.GetSpellName(cBuffs[i].IDS);
        if (not spellName) then
          -- Spell doesn't exist
          if (not SmartBuffValidSpells.spells) then SmartBuffValidSpells.spells = {}; end
          SmartBuffValidSpells.spells[cBuffs[i].IDS] = false;
          cBuffs[i] = nil;
          return i;
        end
        -- For spellbook spells (all class/spec spells), verify they're known; skip for items/track/toys
        local isSpellbookType = not SMARTBUFF_IsItem(cBuffs[i].Type) and cBuffs[i].Type ~= SMARTBUFF_CONST_TRACK and cBuffs[i].Type ~= SMARTBUFF_CONST_TOY;
        if (isSpellbookType) then
          local isKnown = C_SpellBook.IsSpellKnownOrInSpellBook(cBuffs[i].IDS);
          if (not isKnown) then
            -- Spell not known for this class/spec - mark as invalid
            if (not SmartBuffValidSpells.spells) then SmartBuffValidSpells.spells = {}; end
            SmartBuffValidSpells.spells[cBuffs[i].IDS] = false;
            cBuffs[i] = nil;
            return i;
          end
        end
        -- Valid spell - mark as valid
        if (not SmartBuffValidSpells.spells) then SmartBuffValidSpells.spells = {}; end
        SmartBuffValidSpells.spells[cBuffs[i].IDS] = true;
      end
    end
  end
  if (cBuffs[i].IDS == nil and not (SMARTBUFF_IsItem(cBuffs[i].Type) or cBuffs[i].Type == SMARTBUFF_CONST_TRACK)) then
    cBuffs[i] = nil;
    return i;
  end

  if (buff[4] ~= nil) then cBuffs[i].LevelsS = buff[4] else cBuffs[i].LevelsS = nil end
  if (buff[5] ~= nil) then cBuffs[i].Params = buff[5] else cBuffs[i].Params = SG.NIL end
  cBuffs[i].Links = buff[6];
  cBuffs[i].Chain = buff[7];

  -- Warlock Nether Ward fix
  --if (cBuffs[i].BuffS == SMARTBUFF_SHADOWWARD and IsTalentSkilled(3, 13, SMARTBUFF_NETHERWARD)) then
  --  cBuffs[i].BuffS = SMARTBUFF_NETHERWARD;
  --end

  if (cBuffs[i].IDS ~= nil) then
    -- Try to get icon from cached spellInfo first
    local icon = nil;
    if (type(buff[1]) == "table" and buff[1].icon) then
      icon = buff[1].icon;
    else
      -- Fallback to API call
      icon = C_Spell.GetSpellTexture(cBuffs[i].IDS);
    end
    cBuffs[i].IconS = icon;
  else
    if (cBuffs[i].Type == SMARTBUFF_CONST_TRACK) then
      local b = false;
      for n = 1, C_Minimap.GetNumTrackingTypes() do
        local trackN, trackT, trackA, trackC = C_Minimap.GetTrackingInfo(n);
        if (trackN ~= nil) then
          --SMARTBUFF_AddMsgD(n..". "..trackN.." ("..trackC..")");
          if (trackN == cBuffs[i].BuffS) then
            b = true;
            --cBuffs[i].IDS = SMARTBUFF_GetSpellID(cBuffs[i].BuffS);
            cBuffs[i].IDS = nil;
            cBuffs[i].IconS = trackT;
          end
        end
      end
      if (not b) then
        cBuffs[i] = nil;
        return i;
      end
    elseif (ia or cBuffs[i].Type == SMARTBUFF_CONST_ITEMGROUP) then
      -- Try to get minLevel and texture from cache first
      local minLevel, texture = nil, nil;
      local cache = SmartBuffItemSpellCache;
      if (cache and cache.itemData) then
        -- Find varName by itemLink; cap iterations to avoid "script ran too long"
        local seen = 0;
        local maxCacheScan = 64;
        for varName, itemLink in pairs(cache.items or {}) do
          seen = seen + 1;
          if (seen > maxCacheScan) then break; end
          if (itemLink == cBuffs[i].BuffS) then
            local itemData = cache.itemData[varName];
            if (itemData) then
              minLevel = itemData[1];
              texture = itemData[2];
            end
            break;
          end
        end
      end
      
      -- If not in cache, try API call
      if (minLevel == nil) then
        local _, _, _, _, apiMinLevel, _, _, _, _, apiTexture = C_Item.GetItemInfo(cBuffs[i].BuffS);
        minLevel = apiMinLevel;
        texture = apiTexture;
      end
      
      if (minLevel == nil) then
        -- Item data not loaded yet - request loading and keep buff (AllTheThings pattern: accept partial data)
        local itemID = ExtractItemID(cBuffs[i].BuffS);
        if (itemID) then
          C_Item.RequestLoadItemDataByID(itemID);
        end
        -- Keep buff in list - will be validated when ITEM_DATA_LOAD_RESULT fires
        cBuffs[i].IconS = nil;  -- No texture yet
      elseif (not IsMinLevel(minLevel)) then
        cBuffs[i] = nil;
        return i;
      else
        cBuffs[i].IconS = texture;
      end
    else
      -- ITEM type (conjured items like Create Healthstone) or FOOD/SCROLL/POTION types
      SMARTBUFF_AddMsgD("SetBuff item-related type: " .. cBuffs[i].BuffS .. " (Type: " .. cBuffs[i].Type .. ")");
      -- Try to get minLevel and texture from cache first
      local minLevel, texture = nil, nil;
      local cache = SmartBuffItemSpellCache;
      if (cache and cache.itemData) then
        -- Find varName by itemLink; cap iterations to avoid "script ran too long"
        local seen = 0;
        local maxCacheScan = 64;
        for varName, itemLink in pairs(cache.items or {}) do
          seen = seen + 1;
          if (seen > maxCacheScan) then break; end
          if (itemLink == cBuffs[i].BuffS) then
            local itemData = cache.itemData[varName];
            if (itemData) then
              minLevel = itemData[1];
              texture = itemData[2];
            end
            break;
          end
        end
      end
      
      -- If not in cache, try API call
      if (minLevel == nil) then
        local _, _, _, _, apiMinLevel, _, _, _, _, apiTexture = C_Item.GetItemInfo(cBuffs[i].BuffS);
        minLevel = apiMinLevel;
        texture = apiTexture;
      end
      
      SMARTBUFF_AddMsgD("  GetItemInfo(BuffS) minLevel: " .. tostring(minLevel));
      if (minLevel == nil) then
        -- Item data not loaded yet - request loading and keep buff (AllTheThings pattern: accept partial data)
        local itemID = ExtractItemID(cBuffs[i].BuffS);
        if (itemID) then
          C_Item.RequestLoadItemDataByID(itemID);
          SMARTBUFF_AddMsgD("  Item data not loaded yet, requested loading (itemID: " .. itemID .. ")");
        end
        -- Keep buff in list - will be validated when ITEM_DATA_LOAD_RESULT fires
      elseif (not IsMinLevel(minLevel)) then
        SMARTBUFF_AddMsgD("  Filtered out: level requirement not met");
        cBuffs[i] = nil;
        return i;
      end
      local _, _, count, findItemTexture = SMARTBUFF_FindItem(cBuffs[i].BuffS, cBuffs[i].Chain);
      -- Use texture from cache if available, otherwise use FindItem result
      if (not texture) then
        texture = findItemTexture;
      end
      SMARTBUFF_AddMsgD("  FindItem result: count=" .. tostring(count) .. ", texture=" .. tostring(texture));

      if count then
        if (count == 0) then
          -- For ITEM type (conjured items), count == 0 is expected - spell creates the item
          -- For FOOD/SCROLL/POTION types, count == 0 means item not available - filter out
          if (cBuffs[i].Type == SMARTBUFF_CONST_ITEM) then
            SMARTBUFF_AddMsgD("  Item not found (count=0), keeping buff (ITEM type - spell creates item)");
            -- Try to get texture from item name/chain for icon
            local chainTexture = nil;
            if (cBuffs[i].Chain and #cBuffs[i].Chain > 0) then
              -- Try first item in chain for texture
              local itemID = ExtractItemID(cBuffs[i].Chain[1]);
              if (itemID) then
                local _, _, _, _, _, _, _, _, _, chainTexture = C_Item.GetItemInfo(itemID);
                if (chainTexture) then
                  cBuffs[i].IconS = chainTexture;
                else
                  -- Chain item data not loaded - request loading
                  C_Item.RequestLoadItemDataByID(itemID);
                end
              end
            end
            if (not cBuffs[i].IconS) then
              -- Fallback: use texture from BuffS (already retrieved above)
              cBuffs[i].IconS = buffTexture;
            end
          else
            -- FOOD/SCROLL/POTION types - filter out if item not found
            SMARTBUFF_AddMsgD("  Filtered out: count=0 (item not in inventory for " .. cBuffs[i].Type .. " type)");
            cBuffs[i] = nil;
            return i;
          end
        else
          -- count > 0: Item found in inventory
          SMARTBUFF_AddMsgD("  Item found in inventory (count=" .. count .. "), keeping buff");
          cBuffs[i].IconS = texture;
        end
      else
        SMARTBUFF_AddMsgD("  Filtered out: FindItem returned nil");
        cBuffs[i] = nil;
        return i;
      end
    end
  end

  SMARTBUFF_AddMsgD("Add " .. cBuffs[i].BuffS);

  cBuffs[i].BuffG = nil; --buff[6]; -- Disabled for Cataclysm
  cBuffs[i].IDG = nil;   --SMARTBUFF_GetSpellID(cBuffs[i].BuffG);
  if (cBuffs[i].IDG ~= nil) then
    cBuffs[i].IconG = C_Spell.GetSpellTexture(cBuffs[i].BuffG);
  else
    cBuffs[i].IconG = nil;
  end
  --if (buff[7] ~= nil) then cBuffs[i].DurationG = ceil(buff[7] * 60); else cBuffs[i].DurationG = nil; end
  --if (buff[8] ~= nil) then cBuffs[i].LevelsG = buff[8]; else cBuffs[i].LevelsG = nil; end
  --if (buff[9] ~= nil) then cBuffs[i].ReagentG = buff[9]; else cBuffs[i].ReagentG = nil; end

  --[[
  if (O.Debug) then
    local s = name;
    if (cBuffs[i].IDS) then s = s .. " ID = " .. cBuffs[i].IDS .. ", Icon = " .. cBuffs[i].IconS; else s = s .. " ID = nil"; end
    if (cBuffs[i].BuffG ~= nil) then
      s = s .. " - " .. cBuffs[i].BuffG;
      if (cBuffs[i].IDG) then s = s .. " ID = " .. cBuffs[i].IDG .. ", Icon = " .. cBuffs[i].IconG; else s = s .. " ID = nil"; end
    end
    SMARTBUFF_AddMsgD(s);
  end
  ]] --
  cBuffIndex[cBuffs[i].BuffS] = i;
  -- Register canonical item key so B[][][] iteration (e.g. SetInCombatBuffs) finds this buff when key is "item:ID"
  local itemID = ExtractItemID(cBuffs[i].BuffS);
  if (itemID) then
    cBuffIndex["item:" .. tostring(itemID)] = i;
  end
  if (cBuffs[i].IDG ~= nil) then
    cBuffIndex[cBuffs[i].BuffG] = i;
  end
  InitBuffSettings(cBuffs[i]);

  return i + 1;
end

function SMARTBUFF_SetInCombatBuffs()
  local ct = currentTemplate;
  if (ct == nil or B[CS()] == nil or B[CS()][ct] == nil) then
    return;
  end
  for name, data in pairs(B[CS()][ct]) do
    --SMARTBUFF_AddMsgD(name .. ", type = " .. type(data));
    if (type(data) == "table" and cBuffIndex[name] and (B[CS()][ct][name].EnableS or B[CS()][ct][name].EnableG) and B[CS()][ct][name].CIn) then
      local cBI = cBuffs[cBuffIndex[name]];  -- Get definition data from cBuffs[]
      if (cBI) then
        if (cBuffsCombat[name]) then
          wipe(cBuffsCombat[name]);
        else
          cBuffsCombat[name] = {};
        end
        cBuffsCombat[name].Unit = "player";
        cBuffsCombat[name].Type = cBI.Type;  -- ✅ From cBuffs[]
        cBuffsCombat[name].Links = cBI.Links;  -- ✅ Copy Links for future use
        cBuffsCombat[name].Chain = cBI.Chain;  -- ✅ Copy Chain for future use
        cBuffsCombat[name].ActionType = "spell";
        SMARTBUFF_AddMsgD("Set combat spell: " .. name);
      end
      --break;
    end
  end
end

-- END SMARTBUFF_SetBuffs


function SMARTBUFF_IsTalentFrameVisible()
  return PlayerTalentFrame and PlayerTalentFrame:IsVisible();
end

-- Main Check functions
function SMARTBUFF_PreCheck(mode, force)
  if (not isInit) then return false end

  if (not isInitBtn) then
    SMARTBUFF_InitActionButtonPos();
  end

  if (not O.Toggle) then
    if (mode == 0) then
      SMARTBUFF_AddMsg(SMARTBUFF_MSG_DISABLED);
    end
    return false;
  end

  -- Buff list rebuild is now scheduled via SMARTBUFF_ScheduleSetBuffs() only (no SetBuffs from OnUpdate).

  if ((mode == 1 and not O.ToggleAuto) or IsMounted() or IsFlying() or LootFrame:IsVisible()
        or UnitOnTaxi("player") or UnitIsDeadOrGhost("player") or UnitIsCorpse("player")
        or (mode ~= 1 and (SMARTBUFF_IsPicnic("player") or SMARTBUFF_IsFishing("player")))
        or (UnitInVehicle("player") or UnitHasVehicleUI("player"))
        --or (mode == 1 and (O.ToggleAutoRest and IsResting()) and not UnitIsPVP("player"))
        or (not O.BuffInCities and IsResting() and not UnitIsPVP("player"))) then
    if (UnitIsDeadOrGhost("player")) then
      SMARTBUFF_CheckBuffTimers();
    end
    return false;
  end

  -- Now check AutoTimer (only if we passed the mount check)
  if (mode == 1 and not force) then
    if ((GetTime() - tLastCheck) < O.AutoTimer) then
      return false;
    end
  end
  --SMARTBUFF_AddMsgD(string.format("%.2f, %.2f", GetTime(), GetTime() - tLastCheck));
  tLastCheck = GetTime();

  -- If buffs can't casted, hide UI elements
  if (C_PetBattles.IsInBattle() or UnitInVehicle("player") or UnitHasVehicleUI("player")) then
    if (not InCombatLockdown() and SmartBuff_KeyButton:IsVisible()) then
      SmartBuff_KeyButton:Hide();
    end
    return false;
  else
    SMARTBUFF_ShowSAButton();
  end

  SMARTBUFF_SetButtonTexture(SmartBuff_KeyButton, imgSB);
  if (SmartBuffOptionsFrame:IsVisible()) then return false; end

  -- check for mount-spells
  if (sPlayerClass == "PALADIN" and (IsMounted() or IsFlying()) and not SMARTBUFF_CheckBuff("player", SMARTBUFF_CRUSADERAURA)) then
    return true;
  elseif (sPlayerClass == "DEATHKNIGHT" and IsMounted() and not SMARTBUFF_CheckBuff("player", SMARTBUFF_PATHOFFROST)) then
    return true;
  end
  --SMARTBUFF_AddMsgD("2: " .. GetTime() - tLastCheck);

  if (UnitAffectingCombat("player")) then
    isCombat = true;
    if (O.Debug) then SMARTBUFF_AddMsgD("In combat"); end
  else
    isCombat = false;
    if (O.Debug) then SMARTBUFF_AddMsgD("Out of combat"); end
  end

  -- Don't run the check loop until buff list is ready (missing B/Order, or Order has entries but cBuffs wasn't built)
  if (not B or not B[CS()] or not B[CS()].Order or (numBuffs == 0 and next(B[CS()].Order))) then
    SMARTBUFF_ScheduleSetBuffs();
    return false;
  end

  sMsgWarning = "";
  isFirstError = true;

  return true;
end

-- Bufftimer check functions
function SMARTBUFF_CheckBuffTimers()
  local n = 0;
  local ct = currentTemplate;

  --SMARTBUFF_AddMsgD("SMARTBUFF_CheckBuffTimers");

  local cGrp = cUnits;
  for subgroup in pairs(cGrp) do
    n = 0;
    if (cGrp[subgroup] ~= nil) then
      for _, unit in pairs(cGrp[subgroup]) do
        if (unit) then
          if (SMARTBUFF_CheckUnitBuffTimers(unit)) then
            n = n + 1;
          end
        end
      end
      if (cBuffTimer[subgroup]) then
        cBuffTimer[subgroup] = nil;
        SMARTBUFF_AddMsgD("Group " .. subgroup .. ": group timer reseted");
      end
    end
  end
end

-- END SMARTBUFF_CheckBuffTimers

-- if unit is dead, remove all timers
function SMARTBUFF_CheckUnitBuffTimers(unit)
  if (UnitExists(unit) and UnitIsConnected(unit) and UnitIsFriend("player", unit) and UnitIsPlayer(unit) and UnitIsDeadOrGhost(unit)) then
    local _, uc = UnitClass(unit);
    local fd = nil;
    if (uc == "HUNTER") then
      fd = SMARTBUFF_IsFeignDeath(unit);
    end
    if (not fd) then
      if (cBuffTimer[unit]) then
        cBuffTimer[unit] = nil;
        SMARTBUFF_AddMsgD(UnitName(unit) .. ": unit timer reseted");
      end
      if (cBuffTimer[uc]) then
        cBuffTimer[uc] = nil;
        SMARTBUFF_AddMsgD(uc .. ": class timer reseted");
      end
      return true;
    end
  end
end

-- END SMARTBUFF_CheckUnitBuffTimers


-- Reset BT: clear buff timers only (runtime cBuffTimer; no saved vars).
function SMARTBUFF_ResetBuffTimers()
  if (not isInit) then return; end

  local ct = currentTemplate;
  local t = GetTime();
  local rbTime = 0;
  local i = 0;
  local d = 0;
  local tl = 0;
  local buffS = nil;
  local buff = nil;
  local unit = nil;
  local obj = nil;
  local uc = nil;

  local cGrp = cGroups;
  for subgroup in pairs(cGrp) do
    n = 0;
    if (cGrp[subgroup] ~= nil) then
      for _, unit in pairs(cGrp[subgroup]) do
        if (unit and UnitExists(unit) and UnitIsConnected(unit) and UnitIsFriend("player", unit) and UnitIsPlayer(unit) and not UnitIsDeadOrGhost(unit)) then
          _, uc = UnitClass(unit);
          i = 1;
          while (cBuffs[i] and cBuffs[i].BuffS) do
            d = -1;
            buff = nil;
            rbTime = 0;
            buffS = cBuffs[i].BuffS;
            local bs = GetBuffSettings(buffS);

            if (bs) then rbTime = bs.RBTime or 0; end
            if (rbTime <= 0) then
              rbTime = O.RebuffTimer;
            end

            if (bs and cBuffs[i].BuffG and bs.EnableG and cBuffs[i].IDG ~= nil and cBuffs[i].DurationG > 0) then
              d = cBuffs[i].DurationG;
              buff = cBuffs[i].BuffG;
              obj = subgroup;
            end

            if (d > 0 and buff) then
              if (not cBuffTimer[obj]) then
                cBuffTimer[obj] = {};
              end
              cBuffTimer[obj][buff] = t - d + rbTime - 1;
            end

            buff = nil;
            if (buffS and bs and bs.EnableS and cBuffs[i].IDS ~= nil and cBuffs[i].DurationS > 0
                  and uc and bs[uc]) then
              d = cBuffs[i].DurationS;
              buff = buffS;
              obj = unit;
            end

            if (d > 0 and buff) then
              if (not cBuffTimer[obj]) then
                cBuffTimer[obj] = {};
              end
              cBuffTimer[obj][buff] = t - d + rbTime - 1;
            end

            i = i + 1;
          end
        end
      end
    end
  end
  --isAuraChanged = true;
  SMARTBUFF_Check(1, true);
end

function SMARTBUFF_ShowBuffTimers()
  if (not isInit) then return; end

  local ct = currentTemplate;
  local t = GetTime();
  local rbTime = 0;
  local i = 0;
  local d = 0;
  local tl = 0;
  local buffS = nil;

  for unit in pairs(cBuffTimer) do
    for buff in pairs(cBuffTimer[unit]) do
      if (unit and buff and cBuffTimer[unit][buff]) then
        d = -1;
        buffS = nil;
        if (cBuffIndex[buff]) then
          i = cBuffIndex[buff];
          if (cBuffs[i].BuffS == buff and cBuffs[i].DurationS > 0) then
            d = cBuffs[i].DurationS;
            buffS = cBuffs[i].BuffS;
          elseif (cBuffs[i].BuffG == buff and cBuffs[i].DurationG > 0) then
            d = cBuffs[i].DurationG;
            buffS = cBuffs[i].BuffS;
          end
          i = i + 1;
        end

        local bs = buffS and GetBuffSettings(buffS);
        if (buffS and bs) then
          if (d > 0) then
            rbTime = bs.RBTime or 0;
            if (rbTime <= 0) then
              rbTime = O.RebuffTimer;
            end
            tl = cBuffTimer[unit][buff] + d - t;
            if (tl >= 0) then
              local s = "";
              if (string.find(unit, "^party") or string.find(unit, "^raid") or string.find(unit, "^player") or string.find(unit, "^pet")) then
                local un = UnitName(unit);
                if (un) then
                  un = " (" .. un .. ")";
                else
                  un = "";
                end
                s = "Unit " .. unit .. un;
              elseif (string.find(unit, "^%d$")) then
                s = "Grp " .. unit;
              else
                s = "Class " .. unit;
              end
              --SMARTBUFF_AddMsg(s .. ": " .. buff .. ", time left: " .. string.format(": %.0f", tl) .. ", rebuff time: " .. rbTime);
              SMARTBUFF_AddMsg(string.format("%s: %s, time left: %.0f, rebuff time: %.0f", s, buff, tl, rbTime));
            else
              cBuffTimer[unit][buff] = nil;
            end
          else
            --SMARTBUFF_AddMsgD("Removed: " .. buff);
            cBuffTimer[unit][buff] = nil;
          end
        end
      end
    end
  end
end

-- END SMARTBUFF_ResetBuffTimers


-- Synchronize the internal buff timers with the UI timers
function SMARTBUFF_SyncBuffTimers()
  if (not isInit or isSync or isSetBuffs or SMARTBUFF_IsTalentFrameVisible()) then return; end
  isSync = true;
  tSync = GetTime();

  local ct = CT();
  local rbTime = 0;
  local i = 0;
  local buffS = nil;
  local unit = nil;
  local uc = nil;

  local cGrp = cGroups;
  for subgroup in pairs(cGrp) do
    n = 0;
    if (cGrp[subgroup] ~= nil) then
      for _, unit in pairs(cGrp[subgroup]) do
        if (unit and UnitExists(unit) and UnitIsConnected(unit) and UnitIsFriend("player", unit) and UnitIsPlayer(unit) and not UnitIsDeadOrGhost(unit)) then
          _, uc = UnitClass(unit);
          i = 1;
          while (cBuffs[i] and cBuffs[i].BuffS) do
            rbTime = 0;
            buffS = cBuffs[i].BuffS;
            local bs = GetBuffSettings(buffS);

            if (bs and bs.RBTime ~= nil) then
              rbTime = bs.RBTime;
              if (rbTime <= 0) then
                rbTime = O.RebuffTimer;
              end
            end

            if (buffS and bs and bs.EnableS and cBuffs[i].IDS ~= nil and cBuffs[i].DurationS > 0) then
              if (cBuffs[i].Type ~= SMARTBUFF_CONST_SELF or (cBuffs[i].Type == SMARTBUFF_CONST_SELF and SMARTBUFF_IsPlayer(unit))) then
                SMARTBUFF_SyncBuffTimer(unit, unit, cBuffs[i]);
              end
            end

            i = i + 1;
          end -- END while
        end
      end     -- END for
    end
  end         -- END for

  isSync = false;
  isSyncReq = false;
end

function SMARTBUFF_SyncBuffTimer(unit, grp, cBuff)
  if (not unit or not grp or not cBuff) then return end
  local d = cBuff.DurationS;
  local buff = cBuff.BuffS;
  if (d and d > 0 and buff) then
    local t = GetTime();
    local ret, _, _, timeleft = SMARTBUFF_CheckUnitBuffs(unit, buff, cBuff.Type, cBuff.Links, cBuff.Chain);
    if (ret == nil and timeleft ~= nil) then
      if (not cBuffTimer[grp]) then cBuffTimer[grp] = {} end
      st = Round(t - d + timeleft, 2);
      if (not cBuffTimer[grp][buff] or (cBuffTimer[grp][buff] and cBuffTimer[grp][buff] ~= st)) then
        cBuffTimer[grp][buff] = st;
        if (timeleft > 60) then
          SMARTBUFF_AddMsgD("Buff timer sync: " ..
          grp .. ", " .. buff .. ", " .. string.format("%.1f", timeleft / 60) .. "min");
        else
          SMARTBUFF_AddMsgD("Buff timer sync: " ..
          grp .. ", " .. buff .. ", " .. string.format("%.1f", timeleft) .. "sec");
        end
      end
    end
  end
end

-- check if the player is shapeshifted
function SMARTBUFF_IsShapeshifted()
  if (sPlayerClass == "SHAMAN") then
    if (GetShapeshiftForm(true) > 0) then
      local spellInfo = C_Spell.GetSpellInfo("Ghost Wolf");
      if (not spellInfo) then
        -- Spell data not loaded - request loading (AllTheThings pattern)
        C_Spell.RequestLoadSpellData("Ghost Wolf");
      end
      return true, spellInfo;
    end
  elseif (sPlayerClass == "DRUID") then
    local i;
    for i = 1, GetNumShapeshiftForms(), 1 do
      local icon, active, castable, spellId = GetShapeshiftFormInfo(i);
      local spellIinfo = C_Spell.GetSpellInfo(spellId);
      if (not spellIinfo and spellId) then
        -- Spell data not loaded - request loading (AllTheThings pattern)
        C_Spell.RequestLoadSpellData(spellId);
      end
      if (active and castable and spellIinfo ~= SMARTBUFF_DRUID_TREANT) then
        return true, spellIinfo;
      end
    end
  end
  return false, nil;
end

-- END SMARTBUFF_IsShapeshifted


local IsChecking = false;
function SMARTBUFF_Check(mode, force)
  -- print("precheck "..tostring(SMARTBUFF_PreCheck(mode, force)))
  if (IsChecking or not SMARTBUFF_PreCheck(mode, force)) then return; end
  IsChecking = true;

  local ct = currentTemplate;
  local unit = nil;
  local units = nil;
  local unitsGrp = nil;
  local unitB = nil;
  local unitL = nil;
  local unitU = nil;
  local uLevel = nil;
  local uLevelL = nil;
  local uLevelU = nil;
  local idL = nil;
  local idU = nil;
  local subgroup = 0;
  local i;
  local j;
  local n;
  local m;
  local rc;
  local rank;
  local reagent;
  local nGlobal = 0;

  SMARTBUFF_checkBlacklist();

  -- In combat, all reminder/buff logic is disabled unless O.InCombat is enabled
  if (InCombatLockdown() and not O.InCombat) then
    IsChecking = false;
    return;
  end

  -- 1. check in combat buffs (logic when O.InCombat; surface notification only when O.ToggleAutoCombat too)
  if (InCombatLockdown() and O.InCombat) then
    for spell in pairs(cBuffsCombat) do
      if (spell) then
        local ret, actionType, spellName, slot, unit, buffType = SMARTBUFF_BuffUnit("player", 0, mode, spell)
        if (O.Debug) then SMARTBUFF_AddMsgD("Check combat spell: " .. spell .. ", ret = " .. ret); end
        if (ret and ret == 0 and O.ToggleAutoCombat) then
          IsChecking = false;
          return ret, actionType, spellName, slot, unit, buffType;
        end
      end
    end
  end

  -- 2. buff target, if enabled
  if ((mode == 0 or mode == 5) and O.BuffTarget) then
    local actionType, spellName, slot, buffType;
    i, actionType, spellName, slot, _, buffType = SMARTBUFF_BuffUnit("target", 0, mode);
    if (i <= 1) then
      if (i == 0) then
        --tLastCheck = GetTime() - O.AutoTimer + GlobalCd;
      end
      IsChecking = false;
      return i, actionType, spellName, slot, "target", buffType;
    end
  end

  -- 3. check groups
  local cGrp = cGroups;
  local cOrd = cOrderGrp;
  isMounted = IsMounted() or IsFlying();
  for _, subgroup in pairs(cOrd) do
    --SMARTBUFF_AddMsgD("Checking subgroup " .. subgroup .. ", " .. GetTime());
    if (cGrp[subgroup] ~= nil or (type(subgroup) == "number" and subgroup == 1)) then
      if (cGrp[subgroup] ~= nil) then
        units = cGrp[subgroup];
      else
        units = nil;
      end

      if (cUnits and type(subgroup) == "number" and subgroup == 1) then
        unitsGrp = cUnits[1];
      else
        unitsGrp = units;
      end

      -- check buffs
      if (units) then
        for _, unit in pairs(units) do
          if (isSetBuffs) then break; end
          if (O.Debug) then SMARTBUFF_AddMsgD("Checking single unit = " .. unit); end
          local spellName, actionType, slot, buffType;
          i, actionType, spellName, slot, _, buffType = SMARTBUFF_BuffUnit(unit, subgroup, mode);

          if (i <= 1) then
            -- Logic gated by O.InCombat (early exit); in combat surface notification only when both O.InCombat and O.ToggleAutoCombat
            if (not InCombatLockdown() or (O.InCombat and O.ToggleAutoCombat)) then
              if (i == 0 and mode ~= 1) then
                --tLastCheck = GetTime() - O.AutoTimer + GlobalCd;
                if (actionType == SMARTBUFF_ACTION_ITEM) then
                  --tLastCheck = tLastCheck + 2;
                end
              end
              IsChecking = false;
              return i, actionType, spellName, slot, unit, buffType;
            end
          end
        end
      end
    end
  end -- for groups

  if (mode == 0) then
    if (sMsgWarning == "" or sMsgWarning == " ") then
      SMARTBUFF_AddMsg(SMARTBUFF_MSG_NOTHINGTODO);
    else
      SMARTBUFF_AddMsgWarn(sMsgWarning);
      sMsgWarning = "";
    end
  end
  --tLastCheck = GetTime();
  IsChecking = false;
end

-- END SMARTBUFF_Check


-- Buffs a unit
function SMARTBUFF_BuffUnit(unit, subgroup, mode, spell)
  local bs = nil;  -- Buff settings for current buff
  local buff = nil;  -- Current buff name being checked
  local buffname = nil; -- Name of current buff
  local buffnS = nil; -- Name of current buff in cBuffs array
  local uc = nil; -- Unit class
  local ur = "NONE"; -- Unit role
  local un = nil; -- Unit name
  local uct = nil; -- Unit creature type
  local ucf = nil; -- Unit creature family
  local r;  -- Return value: 0 = success, 1 = item found, 20 = item not found
  local i;  -- Index of current buff in cBuffs array
  local bt = 0; -- Buff target
  local cd = 0; -- Cooldown of current buff
  local cds = 0; -- Cooldown start time of current buff
  local charges = 0; -- Charges of current buff
  local handtype = ""; -- Hand type of current buff
  local bExpire = false; -- Expire flag for current buff
  local isPvP = false; -- Is PvP flag
  local bufftarget = nil; -- Buff target
  local rbTime = 0; -- Rebuff timer
  local bUsable = false; -- Usable flag for current buff
  local time = GetTime(); -- Current time
  local cBuff = nil; -- Current buff in cBuffs array
  local iId = nil; -- Item ID of current buff
  local iSlot = -1; -- Item slot of current buff

  if (UnitIsPVP("player")) then isPvP = true end

  SMARTBUFF_CheckUnitBuffTimers(unit);

  --SMARTBUFF_AddMsgD("Checking " .. unit);

  if (UnitExists(unit) and UnitIsFriend("player", unit) and not UnitIsDeadOrGhost(unit) and not UnitIsCorpse(unit)
        and UnitIsConnected(unit) and UnitIsVisible(unit) and not UnitOnTaxi(unit) and not cBlacklist[unit]
        and ((not UnitIsPVP(unit) and (not isPvP or O.BuffPvP)) or (UnitIsPVP(unit) and (isPvP or O.BuffPvP)))) then
    --and not SmartBuff_UnitIsIgnored(unit)

    --print("Prep Check");

    _, uc = UnitClass(unit);
    un = UnitName(unit);
    ur = UnitGroupRolesAssigned(unit);
    uct = UnitCreatureType(unit);
    ucf = UnitCreatureFamily(unit);
    if (uct == nil) then uct = ""; end
    if (ucf == nil) then ucf = ""; end

    --if (un) then print("Grp "..subgroup.." checking "..un.." ("..unit.."/"..uc.."/"..ur.."/"..uct.."/"..ucf..")", 0, 1, 0.5); end

    isShapeshifted, sShapename = SMARTBUFF_IsShapeshifted();
    -- sShapename is spellInfo array
    --while (cBuffs[i] and cBuffs[i].BuffS) do
    for i, buffnS in pairs(B[CS()].Order) do
      --print(buffnS)
      if (isSetBuffs or SmartBuffOptionsFrame:IsVisible()) then break; end
      cBuff = cBuffs[cBuffIndex[buffnS]];
      --buffnS = cBuff.BuffS;
      bs = GetBuffSettings(buffnS);
      bExpire = false;
      handtype = "";
      charges = -1;
      bufftarget = nil;
      bUsable = false;
      iId = nil;
      iSlot = -1;

      if (cBuff and bs) then bUsable = bs.EnableS end

      if (bUsable and spell and spell ~= buffnS) then
        bUsable = false;
        SMARTBUFF_AddMsgD("Exclusive check on " .. spell .. ", current spell = " .. buffnS);
      end
      if (bUsable and cBuff.Type == SMARTBUFF_CONST_SELF and not SMARTBUFF_IsPlayer(unit)) then bUsable = false end
      if (bUsable and not cBuff.Type == SMARTBUFF_CONST_TRACK and not SMARTBUFF_IsItem(cBuff.Type) and not C_Spell.IsSpellUsable(buffnS)) then bUsable = false end
      if (bUsable and bs.SelfNot and SMARTBUFF_IsPlayer(unit)) then bUsable = false end
      if (bUsable and cBuff.Params == SG.CheckFishingPole and SMARTBUFF_IsFishingPoleEquiped()) then bUsable = false end

      -- Check for buffs which depends on a pet
      if (bUsable and cBuff.Params == SG.CheckPet and UnitExists("pet")) then bUsable = false end
      if (bUsable and cBuff.Params == SG.CheckPetNeeded and not UnitExists("pet")) then bUsable = false end

      -- Check for mount auras
      if (bUsable and (sPlayerClass == "PALADIN" or sPlayerClass == "DEATHKNIGHT")) then
        isMounted = false;
        if (sPlayerClass == "PALADIN") then
          isMounted = IsMounted() or IsFlying();
          if ((buffnS ~= SMARTBUFF_CRUSADERAURA.name and isMounted) or (buffnS == SMARTBUFF_CRUSADERAURA.name and not isMounted)) then
            bUsable = false;
          end
        elseif (sPlayerClass == "DEATHKNIGHT") then
          isMounted = IsMounted();
          if (buffnS ~= SMARTBUFF_PATHOFFROST.name and isMounted) then
            bUsable = false;
          end
        end
      end

      if (bUsable and not (cBuff.Type == SMARTBUFF_CONST_TRACK or SMARTBUFF_IsItem(cBuff.Type))) then
        -- check if you have enough mana/rage/energy to cast
        local isUsable, notEnoughMana = C_Spell.IsSpellUsable(buffnS);
        if (notEnoughMana) then
          bUsable = false;
          SMARTBUFF_AddMsgD("Buff " .. (GetBuffDisplayName(cBuff.BuffS, cBuff.Type) or cBuff.BuffS) .. ", not enough mana!");
        elseif (mode ~= 1 and isUsable == nil and buffnS ~= SMARTBUFF_PWS.name) then
          bUsable = false;
          SMARTBUFF_AddMsgD("Buff " .. (GetBuffDisplayName(cBuff.BuffS, cBuff.Type) or cBuff.BuffS) .. " is not usable!");
        end
      end

      if (bUsable and bs.EnableS and (cBuff.IDS ~= nil or SMARTBUFF_IsItem(cBuff.Type) or cBuff.Type == SMARTBUFF_CONST_TRACK)
            and ((mode ~= 1 and ((isCombat and bs.CIn) or (not isCombat and bs.COut)))
              or (mode == 1 and bs.Reminder and ((not isCombat and bs.COut)
                or (isCombat and bs.CIn))))) then
        --print("Check: "..buffnS)

        if (not bs.SelfOnly or (bs.SelfOnly and SMARTBUFF_IsPlayer(unit))) then
          -- get current spell cooldown
          cd = 0;
          cds = 0;
          if (cBuff.IDS) then
            local cooldown = C_Spell.GetSpellCooldown(buffnS);
            if cooldown and type(cooldown) == "table" then
              cds = tonumber(cooldown["startTime"]) or 0;
              cd = tonumber(cooldown["duration"]) or 0;
            end
            -- Force numeric: secret values may survive tonumber(), validate with pcall before arithmetic
            local ok, _ = pcall(function() return cds + cd end);
            if not ok then cds = 0; cd = 0; end
            cd = (cds + cd) - GetTime();
            if (cd < 0) then
              cd = 0;
            end
            SMARTBUFF_AddMsgD(buffnS .. " cd = " .. cd);
          end

          -- check if spell has cooldown
          if (cd <= 0 or (mode == 1 and cd <= 1.5)) then
            if (cBuff.IDS and sMsgWarning == SMARTBUFF_MSG_CD) then
              sMsgWarning = " ";
            end

            rbTime = bs.RBTime;
            if (rbTime <= 0) then
              rbTime = O.RebuffTimer;
            end

            SMARTBUFF_AddMsgD(uc .. " " .. CT());

            if (not SMARTBUFF_IsInList(unit, un, bs.IgnoreList) and (((cBuff.Type == SMARTBUFF_CONST_GROUP or cBuff.Type == SMARTBUFF_CONST_ITEMGROUP)
                    and (bs[ur]
                      or (bs.SelfOnly and SMARTBUFF_IsPlayer(unit))
                      or (bs[uc] and (UnitIsPlayer(unit) or uct == SMARTBUFF_HUMANOID or (uc == "DRUID" and (uct == SMARTBUFF_BEAST or uct == SMARTBUFF_ELEMENTAL))))
                      or (bs["HPET"] and uct == SMARTBUFF_BEAST and uc ~= "DRUID")
                      or (bs["DKPET"] and uct == SMARTBUFF_UNDEAD)
                      or (bs["WPET"] and (uct == SMARTBUFF_DEMON or (uc ~= "DRUID" and uct == SMARTBUFF_ELEMENTAL)) and ucf ~= SMARTBUFF_DEMONTYPE)))
                  or (cBuff.Type ~= SMARTBUFF_CONST_GROUP and SMARTBUFF_IsPlayer(unit))
                  or SMARTBUFF_IsInList(unit, un, bs.AddList))) then
              buff = nil;

              -- Tracking ability ------------------------------------------------------------------------
              if (cBuff.Type == SMARTBUFF_CONST_TRACK) then
                --print("Check tracking: "..buffnS)
                local count = C_Minimap.GetNumTrackingTypes();
                for n = 1, C_Minimap.GetNumTrackingTypes() do
                  local trackN, trackT, trackA, trackC = C_Minimap.GetTrackingInfo(n);
                  if (trackN ~= nil and not trackA) then
                    SMARTBUFF_AddMsgD(n .. ". " .. trackN .. " (" .. trackC .. ")");
                    if (trackN == buffnS) then
                      if (sPlayerClass == "DRUID" and buffnS == SMARTBUFF_DRUID_TRACK.name) then
                        if (isShapeshifted and sShapename == SMARTBUFF_DRUID_CAT) then
                          buff = buffnS;
                          C_Minimap.SetTracking(n, 1);
                        end
                      else
                        buff = buffnS;
                        C_Minimap.SetTracking(n, 1);
                        --print("SetTracking: "..n)
                      end
                      if (buff ~= nil) then
                        SMARTBUFF_AddMsgD("Tracking enabled: " .. buff);
                        buff = nil;
                      end
                    end
                  end
                end

                -- Food, Scroll, Potion or conjured items ------------------------------------------------------------------------
              elseif (cBuff.Type == SMARTBUFF_CONST_FOOD or cBuff.Type == SMARTBUFF_CONST_SCROLL or cBuff.Type == SMARTBUFF_CONST_POTION or cBuff.Type == SMARTBUFF_CONST_ITEM or
                    cBuff.Type == SMARTBUFF_CONST_ITEMGROUP) then
                if (cBuff.Type == SMARTBUFF_CONST_ITEM) then
                  SMARTBUFF_AddMsgD("BuffUnit ITEM type: " .. buffnS);
                  SMARTBUFF_AddMsgD("  Params: " .. tostring(cBuff.Params));
                  SMARTBUFF_AddMsgD("  Chain: " .. (cBuff.Chain and tostring(#cBuff.Chain) .. " items" or "nil"));
                  bt = nil;
                  buff = nil;
                  if (cBuff.Params ~= SG.NIL) then
                    local cr = SMARTBUFF_CountReagent(cBuff.Params, cBuff.Chain);
                    SMARTBUFF_AddMsgD(cr .. " " .. cBuff.Params .. " found");
                    if (cr == 0) then
                      buff = cBuff.Params;
                    end
                  else
                    -- Params is nil, use Chain to find item
                    SMARTBUFF_AddMsgD("  Params is nil, checking Chain for items");
                    local bag, slot, count = SMARTBUFF_FindItem(buffnS, cBuff.Chain);
                    SMARTBUFF_AddMsgD("  FindItem result: count=" .. tostring(count) .. ", bag=" .. tostring(bag) .. ", slot=" .. tostring(slot));
                    if (count == 0) then
                      SMARTBUFF_AddMsgD("  Item not found (count=0), will cast creation spell");
                      buff = buffnS; -- Use spell name for casting
                    else
                      SMARTBUFF_AddMsgD("  Item found in inventory (count=" .. count .. "), skipping cast");
                    end
                  end

                  -- dont attempt to use food while moving or we will waste them.
                elseif (cBuff.Type == SMARTBUFF_CONST_FOOD and isPlayerMoving == false and not SMARTBUFF_IsPicnic(unit)) then
                  -- unpleasant kludge for hearty buff food, which gives SMARTBUFF_HeartyFedAura
                  if string.find(cBuff.BuffS, SMARTBUFF_LOC_HEARTY) then
                    buff, index, buffname, bt, charges = SMARTBUFF_CheckUnitBuffs(unit, SMARTBUFF_HeartyFedAura, cBuff.Type, cBuff.Links, cBuff.Chain);
                  else
                  -- normal buff food, which givevs SMARTBUFF_WellFedAura
                    buff, index, buffname, bt, charges = SMARTBUFF_CheckUnitBuffs(unit, SMARTBUFF_WellFedAura, cBuff.Type, cBuff.Links, cBuff.Chain);
                  end
                else
                  if (cBuff.Params ~= SG.NIL) then
                    if (cBuff.Links and cBuff.Links == SG.CheckFishingPole) then
                      if (SMARTBUFF_IsFishingPoleEquiped()) then
                        buff, index, buffname, bt, charges = SMARTBUFF_CheckUnitBuffs(unit, cBuff.Params, cBuff.Type);
                      else
                        buff = nil;
                      end
                    else
                      buff, index, buffname, bt, charges = SMARTBUFF_CheckUnitBuffs(unit, cBuff.Params, cBuff.Type,
                        cBuff.Links, cBuff.Chain);
                    end
                    SMARTBUFF_AddMsgD("Buff time (" .. tostring(cBuff.Params) .. ") = " .. tostring(bt));
                  else
                    buff = nil;
                  end
                end

                if (buff == nil and cBuff.DurationS >= 1 and rbTime > 0) then
                  if (charges == nil) then charges = -1; end
                  if (charges > 1) then cBuff.CanCharge = true; end
                  bufftarget = nil;
                end

                if (bt and bt <= rbTime) then
                  buff = buffnS;
                  bExpire = true;
                end

                if (buff) then
                  if (cBuff.Type ~= SMARTBUFF_CONST_ITEM) then
                    local cr, iid = SMARTBUFF_CountReagent(buffnS, cBuff.Chain);
                    if (cr > 0) then
                      buff = buffnS;
                      if (cBuff.Type == SMARTBUFF_CONST_ITEMGROUP or cBuff.Type == SMARTBUFF_CONST_SCROLL) then
                        cds, cd = C_Container.GetItemCooldown(iid);
                        cds = tonumber(cds) or 0;
                        cd = tonumber(cd) or 0;
                        local ok, _ = pcall(function() return cds + cd end);
                        if not ok then cds = 0; cd = 0; end
                        cd = (cds + cd) - GetTime();
                        SMARTBUFF_AddMsgD(cr .. " " .. buffnS .. " found, cd = " .. cd);
                        if (cd > 0) then
                          buff = nil;
                        end
                      end
                      SMARTBUFF_AddMsgD(cr .. " " .. buffnS .. " found");
                    else
                      SMARTBUFF_AddMsgD("No " .. buffnS .. " found");
                      buff = nil;
                      bExpire = false;
                    end
                  end
                end

                -- Weapon buff ------------------------------------------------------------------------
              elseif (cBuff.Type == SMARTBUFF_CONST_WEAPON or cBuff.Type == SMARTBUFF_CONST_INV) then
                SMARTBUFF_AddMsgD("Check weapon Buff");
                hasMainHandEnchant, mainHandExpiration, mainHandCharges, mainHandEnchantID, hasOffHandEnchant, offHandExpiration, offHandCharges, offHandEnchantID =
                GetWeaponEnchantInfo();
                bMh = hasMainHandEnchant;
                tMh = mainHandExpiration;
                cMh = mainHandCharges;
                bOh = hasOffHandEnchant;
                tOh = offHandExpiration;
                cOh = offHandCharges;


                if (bs.MH) then
                  iSlot = INVSLOT_MAINHAND;
                  iId = GetInventoryItemID("player", iSlot);
                  if (iId and SMARTBUFF_CanApplyWeaponBuff(buffnS, iSlot)) then
                    if (bMh) then
                      if (rbTime > 0 and cBuff.DurationS >= 1) then
                        --if (tMh == nil) then tMh = 0; end
                        tMh = floor(tMh / 1000);
                        charges = cMh;
                        if (charges == nil) then charges = -1; end
                        if (charges > 1) then cBuff.CanCharge = true; end
                        SMARTBUFF_AddMsgD(un ..
                        " (WMH): " ..
                        buffnS .. string.format(" %.0f sec left", tMh) .. ", " .. charges .. " charges left");
                        if (tMh <= rbTime or (O.CheckCharges and cBuff.CanCharge and charges > 0 and charges <= O.MinCharges)) then
                          buff = buffnS;
                          bt = tMh;
                          bExpire = true;
                        end
                      end
                    else
                      handtype = "main";
                      buff = buffnS;
                    end
                  else
                    SMARTBUFF_AddMsgD(
                    "Weapon Buff cannot be cast, no mainhand weapon equipped or wrong weapon/stone type");
                  end
                end

                if (bs.OH and not bExpire and not buffloc) then
                  iSlot = INVSLOT_OFFHAND
                  iId = GetInventoryItemID("player", iSlot);
                  if (iId and SMARTBUFF_CanApplyWeaponBuff(buffnS, iSlot)) then
                    if (bOh) then
                      if (rbTime > 0 and cBuff.DurationS >= 1) then
                        --if (tOh == nil) then tOh = 0; end
                        tOh = floor(tOh / 1000);
                        charges = cOh;
                        if (charges == nil) then charges = -1; end
                        if (charges > 1) then cBuff.CanCharge = true; end
                        SMARTBUFF_AddMsgD(un ..
                        " (WOH): " ..
                        buffnS .. string.format(" %.0f sec left", tOh) .. ", " .. charges .. " charges left");
                        if (tOh <= rbTime or (O.CheckCharges and cBuff.CanCharge and charges > 0 and charges <= O.MinCharges)) then
                          buff = buffnS;
                          bt = tOh;
                          bExpire = true;
                        end
                      end
                    else
                      handtype = "off";
                      buff = buffnS;
                    end
                  else
                    SMARTBUFF_AddMsgD(
                    "Weapon Buff cannot be cast, no offhand weapon equipped or wrong weapon/stone type");
                  end
                end

                if (buff and cBuff.Type == SMARTBUFF_CONST_INV) then
                  local cr = SMARTBUFF_CountReagent(buffnS, cBuff.Chain);
                  if (cr > 0) then
                    SMARTBUFF_AddMsgD(cr .. " " .. buffnS .. " found");
                  else
                    SMARTBUFF_AddMsgD("No " .. buffnS .. " found");
                    buff = nil;
                  end
                end
                -- Normal buff ------------------------------------------------------------------------
              else
                local index = nil;

                -- check timer object
                buff, index, buffname, bt, charges = SMARTBUFF_CheckUnitBuffs(unit, buffnS, cBuff.Type, cBuff.Links,
                  cBuff.Chain);
                if (charges == nil) then charges = -1; end
                if (charges > 1) then cBuff.CanCharge = true; end

                -- Only consider rebuff when the *same* buff (or linked) is on; index > 0 means chained/linked buff found - do not cast another in chain
                if (unit ~= "target" and buff == nil and (not index or index == 0) and cBuff.DurationS >= 1 and rbTime > 0) then
                  if (SMARTBUFF_IsPlayer(unit)) then
                    if (cBuffTimer[unit] ~= nil and cBuffTimer[unit][buffnS] ~= nil) then
                      local tbt = cBuff.DurationS - (time - cBuffTimer[unit][buffnS]);
                      if (not bt or bt - tbt > rbTime) then
                        bt = tbt;
                      end
                    end
                    --if (charges == nil) then charges = -1; end
                    --if (charges > 1) then cBuff.CanCharge = true; end
                    bufftarget = nil;
                    --SMARTBUFF_AddMsgD(un .. " (P): " .. index .. ". " .. GetPlayerBuffTexture(index) .. "(" .. charges .. ") - " .. buffnS .. string.format(" %.0f sec left", bt));
                  elseif (cBuffTimer[unit] ~= nil and cBuffTimer[unit][buffnS] ~= nil) then
                    bt = cBuff.DurationS - (time - cBuffTimer[unit][buffnS]);
                    bufftarget = nil;
                    --SMARTBUFF_AddMsgD(un .. " (S): " .. buffnS .. string.format(" %.0f sec left", bt));
                  elseif (cBuff.BuffG ~= nil and cBuffTimer[subgroup] ~= nil and cBuffTimer[subgroup][cBuff.BuffG] ~= nil) then
                    bt = cBuff.DurationG - (time - cBuffTimer[subgroup][cBuff.BuffG]);
                    if (type(subgroup) == "number") then
                      bufftarget = SMARTBUFF_MSG_GROUP .. " " .. subgroup;
                    else
                      bufftarget = SMARTBUFF_MSG_CLASS .. " " .. UnitClass(unit);
                    end
                    --SMARTBUFF_AddMsgD(bufftarget .. ": " .. cBuff.BuffG .. string.format(" %.0f sec left", bt));
                  elseif (cBuff.BuffG ~= nil and cBuffTimer[uc] ~= nil and cBuffTimer[uc][cBuff.BuffG] ~= nil) then
                    bt = cBuff.DurationG - (time - cBuffTimer[uc][cBuff.BuffG]);
                    bufftarget = SMARTBUFF_MSG_CLASS .. " " .. UnitClass(unit);
                    --SMARTBUFF_AddMsgD(bufftarget .. ": " .. cBuff.BuffG .. string.format(" %.0f sec left", bt));
                  else
                    bt = nil;
                  end

                  if ((bt and bt <= rbTime) or (O.CheckCharges and cBuff.CanCharge and charges > 0 and charges <= O.MinCharges)) then
                    if (buffname) then
                      buff = buffname;
                    else
                      buff = buffnS;
                    end
                    bExpire = true;
                  end
                end

                -- check if the group buff is active, in this case it is not possible to cast the single buff
                if (buffname and mode ~= 1 and buffname ~= buffnS) then
                  buff = nil;
                  --SMARTBUFF_AddMsgD("Group buff is active, single buff canceled!");
                end
              end -- END normal buff

              -- check if shapeshifted and cancel buff if it is not possible to cast it
              if (buff and cBuff.Type ~= SMARTBUFF_CONST_TRACK and cBuff.Type ~= SMARTBUFF_CONST_FORCESELF) then
                --isShapeshifted = true;
                if (isShapeshifted) then
                  -- Buff linked to shapeshift form... or not
                  -- Params is buff[5] in buffs
                  if (cBuff.Params == sShapename) then
                    --SMARTBUFF_AddMsgD("Cast " .. buff .. " while shapeshifted");
                  else
                    if (cBuff.Params == SMARTBUFF_DRUID_CAT) then
                      buff = nil;
                    end
                    if (buff and mode ~= 1 and not O.InShapeshift and (sShapename ~= SMARTBUFF_DRUID_MOONKIN and sShapename ~= SMARTBUFF_DRUID_TREANT)) then
                      --sMsgWarning = SMARTBUFF_MSG_SHAPESHIFT .. ": " .. sShapename;
                      buff = nil;
                    end
                  end
                elseif (cBuff.Params == SMARTBUFF_DRUID_CAT) then
                  buff = nil;
                end
              end

              if (buff) then
                if (cBuff.IDS) then
                  SMARTBUFF_AddMsgD("Checking " .. i .. " - " .. cBuff.IDS .. " " .. buffnS);
                end

                -- Cast mode ---------------------------------------------------------------------------------------
                if (mode == 0 or mode == 5) then
                  currentUnit = nil;
                  currentSpell = nil;

                  --try to apply weapon buffs on main/off hand
                  if (cBuff.Type == SMARTBUFF_CONST_INV) then
                    if (iSlot and (handtype ~= "" or bExpire)) then
                      local bag, slot, count = SMARTBUFF_FindItem(buffnS, cBuff.Chain);
                      if (count > 0) then
                        sMsgWarning = "";
                        local itemInfo = C_Item.GetItemInfo(buffnS);
                        if (not itemInfo) then
                          -- Item data not loaded - request loading (AllTheThings pattern)
                          local itemID = ExtractItemID(buffnS);
                          if (itemID) then
                            C_Item.RequestLoadItemDataByID(itemID);
                          end
                        end
                        return 0, SMARTBUFF_ACTION_ITEM, itemInfo or buffnS, iSlot, "player", cBuff.Type;
                      end
                    end
                    r = 50;
                  elseif (cBuff.Type == SMARTBUFF_CONST_WEAPON) then
                    if (iId and (handtype ~= "" or bExpire)) then
                      sMsgWarning = "";
                      return 0, SMARTBUFF_ACTION_SPELL, buffnS, iSlot, "player", cBuff.Type;
                      --return 0, SMARTBUFF_ACTION_SPELL, buffnS, iId, "player", cBuff.Type;
                    end
                    r = 50;

                    -- eat food or use scroll or potion
                  elseif (cBuff.Type == SMARTBUFF_CONST_FOOD or cBuff.Type == SMARTBUFF_CONST_SCROLL or cBuff.Type == SMARTBUFF_CONST_POTION) then
                    local bag, slot, count = SMARTBUFF_FindItem(buffnS, cBuff.Chain);
                    if (count > 0 or bExpire) then
                      sMsgWarning = "";
                      return 0, SMARTBUFF_ACTION_ITEM, buffnS, 0, "player", cBuff.Type;
                    end
                    r = 20;

                    -- use item on a unit
                  elseif (cBuff.Type == SMARTBUFF_CONST_ITEMGROUP) then
                    local bag, slot, count = SMARTBUFF_FindItem(buffnS, cBuff.Chain);
                    if (count > 0) then
                      sMsgWarning = "";
                      return 0, SMARTBUFF_ACTION_ITEM, buffnS, 0, unit, cBuff.Type;
                    end
                    r = 20;

                    -- create item
                  elseif (cBuff.Type == SMARTBUFF_CONST_ITEM) then
                    SMARTBUFF_AddMsgD("BuffUnit ITEM type: " .. buffnS);
                    SMARTBUFF_AddMsgD("  Chain: " .. (cBuff.Chain and tostring(#cBuff.Chain) .. " items" or "nil"));
                    local bag, slot, count = SMARTBUFF_FindItem(buff, cBuff.Chain);
                    SMARTBUFF_AddMsgD("  FindItem result: count=" .. tostring(count) .. ", bag=" .. tostring(bag) .. ", slot=" .. tostring(slot));
                    if (count == 0) then
                      SMARTBUFF_AddMsgD("  Item not found (count=0), attempting to cast: " .. buffnS .. " (IDS: " .. tostring(cBuff.IDS) .. ")");
                      r = SMARTBUFF_doCast(unit, cBuff.IDS, buffnS, cBuff.LevelsS, cBuff.Type);
                      SMARTBUFF_AddMsgD("  doCast result: " .. tostring(r));
                      if (r == 0) then
                        currentUnit = unit;
                        currentSpell = buffnS;
                      end
                    else
                      SMARTBUFF_AddMsgD("  Item found in inventory (count=" .. count .. "), skipping cast");
                      -- Item exists, no action needed - return early to avoid warning
                      return 0;
                    end

                    -- cast spell
                  else
                    r = SMARTBUFF_doCast(unit, cBuff.IDS, buffnS, cBuff.LevelsS, cBuff.Type);
                    if (r == 0) then
                      currentUnit = unit;
                      currentSpell = buffnS;
                      tCastRequested = GetTime();
                    end
                  end

                  -- Check mode ---------------------------------------------------------------------------------------
                elseif (mode == 1) then
                  currentUnit = nil;
                  currentSpell = nil;
                  if (bufftarget == nil) then bufftarget = un; end

                  if (cBuff.IDS ~= nil or SMARTBUFF_IsItem(cBuff.Type) or cBuff.Type == SMARTBUFF_CONST_TRACK) then
                    -- clean up buff timer, if expired
                    if (bt and bt < 0 and bExpire) then
                      bt = 0;
                      if (cBuffTimer[unit] ~= nil and cBuffTimer[unit][buffnS] ~= nil) then
                        cBuffTimer[unit][buffnS] = nil;
                        --SMARTBUFF_AddMsgD(un .. " (S): " .. buffnS .. " timer reset");
                      end
                      if (cBuff.IDG ~= nil) then
                        if (cBuffTimer[subgroup] ~= nil and cBuffTimer[subgroup][cBuff.BuffG] ~= nil) then
                          cBuffTimer[subgroup][cBuff.BuffG] = nil;
                          --SMARTBUFF_AddMsgD("Group " .. subgroup .. ": " .. buffnS .. " timer reset");
                        end
                        if (cBuffTimer[uc] ~= nil and cBuffTimer[uc][cBuff.BuffG] ~= nil) then
                          cBuffTimer[uc][cBuff.BuffG] = nil;
                          --SMARTBUFF_AddMsgD("Class " .. uc .. ": " .. cBuff.BuffG .. " timer reset");
                        end
                      end
                      tLastCheck = time - O.AutoTimer + 0.5;
                      return 0;
                    end

                    SMARTBUFF_SetMissingBuffMessage(bufftarget, buff, cBuff.IconS, cBuff.CanCharge, charges, bt, bExpire);
                    SMARTBUFF_SetButtonTexture(SmartBuff_KeyButton, cBuff.IconS);
                    return 0;
                  end
                end

                if (r == 0) then
                  -- target buffed
                  -- Message will printed in the "SPELLCAST_STOP" event
                  sMsgWarning = "";
                  return 0, SMARTBUFF_ACTION_SPELL, buffnS, -1, unit, cBuff.Type;
                elseif (r == 1) then
                  -- spell cooldown
                  if (mode == 0) then SMARTBUFF_AddMsgWarn(buffnS .. " " .. SMARTBUFF_MSG_CD); end
                  return 1;
                elseif (r == 2) then
                  -- can not target
                  if (mode == 0 and ucf ~= SMARTBUFF_DEMONTYPE) then SMARTBUFF_AddMsgD("Can not target " .. un); end
                elseif (r == 3) then
                  -- target oor
                  if (mode == 0) then SMARTBUFF_AddMsgWarn(un .. " " .. SMARTBUFF_MSG_OOR); end
                  break;
                elseif (r == 4) then
                  -- spell cooldown > maxSkipCoolDown
                  if (mode == 0) then SMARTBUFF_AddMsgD(buffnS .. " " .. SMARTBUFF_MSG_CD .. " > " .. maxSkipCoolDown); end
                elseif (r == 5) then
                  -- target to low
                  if (mode == 0) then SMARTBUFF_AddMsgD(un .. " is to low to get buffed with " .. buffnS); end
                elseif (r == 6) then
                  -- not enough mana/rage/energy
                  sMsgWarning = SMARTBUFF_MSG_OOM;
                elseif (r == 7) then
                  -- tracking ability is already active
                  if (mode == 0) then SMARTBUFF_AddMsgD(buffnS .. " not used, other ability already active"); end
                elseif (r == 8) then
                  -- actionslot is not defined
                  if (mode == 0) then SMARTBUFF_AddMsgD(buffnS .. " has no actionslot"); end
                elseif (r == 9) then
                  -- spell ID not found
                  if (mode == 0) then SMARTBUFF_AddMsgD(buffnS .. " spellID not found"); end
                elseif (r == 10) then
                  -- target could not buffed
                  if (mode == 0) then SMARTBUFF_AddMsgD(buffnS .. " could not buffed on " .. un); end
                elseif (r == 20) then
                  -- item not found
                  if (mode == 0) then SMARTBUFF_AddMsgD(buffnS .. " could not used"); end
                elseif (r == 50) then
                  -- weapon buff could not applied
                  if (mode == 0) then SMARTBUFF_AddMsgD(buffnS .. " could not applied"); end
                else
                  -- no spell selected
                  if (mode == 0) then SMARTBUFF_AddMsgD(SMARTBUFF_MSG_CHAT); end
                end
              end
            end
          else
            -- cooldown
            if (sMsgWarning == "") then
              sMsgWarning = SMARTBUFF_MSG_CD;
            end
            --SMARTBUFF_AddMsgD("Spell on cd: "..buffnS);
          end
        end -- group or self
      end
      --i = i + 1;
    end -- for buff
  end
  return 3;
end

-- END SMARTBUFF_BuffUnit


function SMARTBUFF_IsInList(unit, unitname, list)
  if (list ~= nil) then
    for un in pairs(list) do
      if (un ~= nil and UnitIsPlayer(unit) and un == unitname) then
        return true;
      end
    end
  end
  return false;
end

function SMARTBUFF_SetMissingBuffMessage(target, buff, icon, bCanCharge, nCharges, tBuffTimeLeft, bExpire)
  -- Resolve "item:ID" to display name/link for splash and chat (canonical key is stored; show name to user)
  local displayBuff = (buff and GetBuffDisplayName(buff, nil)) or buff;

  local f = SmartBuffSplashFrame;
  -- show splash buff message
  if (f and O.ToggleAutoSplash and not SmartBuffOptionsFrame:IsVisible()) then
    local s;
    local sd = O.SplashDuration;
    local si = "";

    if (OG.SplashIcon and icon) then
      local n = O.SplashIconSize;
      if (n == nil or n <= 0) then
        n = O.CurrentFontSize;
      end
      si = string.format("\124T%s:%d:%d:1:0\124t ", icon, n, n) or "";
    end
    if (OG.SplashMsgShort and si == "") then si = displayBuff end
    if (O.AutoTimer < 4) then
      sd = 1;
      f:Clear();
    end

    f:SetTimeVisible(sd);
    if (not nCharges) then nCharges = 0; end
    if (O.CheckCharges and bCanCharge and nCharges > 0 and nCharges <= O.MinCharges and bExpire) then
      if (OG.SplashMsgShort) then
        s = target .. " > " .. si .. " < " .. format(SMARTBUFF_ABBR_CHARGES_OL, nCharges);
      else
        s = target ..
        "\n" .. SMARTBUFF_MSG_REBUFF ..
        " " .. si .. displayBuff .. ": " .. format(ITEM_SPELL_CHARGES, nCharges) .. " " .. SMARTBUFF_MSG_LEFT;
      end
    elseif (bExpire) then
      if (OG.SplashMsgShort) then
        s = target .. " > " .. si .. " < " .. format(SECOND_ONELETTER_ABBR, tBuffTimeLeft);
      else
        s = target ..
        "\n" .. SMARTBUFF_MSG_REBUFF .. " " ..
        si .. displayBuff .. ": " .. format(SECONDS_ABBR, tBuffTimeLeft) .. " " .. SMARTBUFF_MSG_LEFT;
      end
    else
      if (OG.SplashMsgShort) then
        s = target .. " > " .. si;
      else
        s = target .. " " .. SMARTBUFF_MSG_NEEDS .. " " .. si .. displayBuff;
      end
    end
    f:AddMessage(s, O.ColSplashFont.r, O.ColSplashFont.g, O.ColSplashFont.b, 1.0);
  end

  -- show chat buff message
  if (O.ToggleAutoChat) then
    if (O.CheckCharges and bCanCharge and nCharges > 0 and nCharges <= O.MinCharges and bExpire) then
      SMARTBUFF_AddMsgWarn(
      target ..
      ": " .. SMARTBUFF_MSG_REBUFF .. " " .. displayBuff .. ", " ..
      format(ITEM_SPELL_CHARGES, nCharges) .. " " .. SMARTBUFF_MSG_LEFT, true);
    elseif (bExpire) then
      SMARTBUFF_AddMsgWarn(
      target .. ": " .. SMARTBUFF_MSG_REBUFF .. " " .. displayBuff .. " " ..
      format(SECONDS_ABBR, tBuffTimeLeft) .. " " .. SMARTBUFF_MSG_LEFT, true);
    else
      SMARTBUFF_AddMsgWarn(target .. " " .. SMARTBUFF_MSG_NEEDS .. " " .. displayBuff, true);
    end
  end

  -- play sound
  if (O.ToggleAutoSound) then
    PlaySound(Sounds[O.AutoSoundSelection]);
  end
end

-- check if a spell/reagent could applied on a weapon
function SMARTBUFF_CanApplyWeaponBuff(buff, slot)
  local cWeaponTypes = nil;
  if (string.find(buff, SMARTBUFF_WEAPON_SHARP_PATTERN)) then
    cWeaponTypes = SMARTBUFF_WEAPON_SHARP;
  elseif (string.find(buff, SMARTBUFF_WEAPON_BLUNT_PATTERN)) then
    cWeaponTypes = SMARTBUFF_WEAPON_BLUNT;
  else
    cWeaponTypes = SMARTBUFF_WEAPON_STANDARD;
  end

  local itemLink = GetInventoryItemLink("player", slot);
  local _, _, itemCode = string.find(itemLink, "item:(%d+):");
  local itemID = itemCode and tonumber(itemCode);
  local _, _, _, _, _, itemType, itemSubType = C_Item.GetItemInfo(itemID);
  if (not itemType and itemID) then
    -- Item data not loaded - request loading (AllTheThings pattern)
    C_Item.RequestLoadItemDataByID(itemID);
  end

  --if (itemType and itemSubType) then
  --  SMARTBUFF_AddMsgD("Type: " .. itemType .. ", Subtype: " .. itemSubType);
  --end

  if (cWeaponTypes and itemSubType) then
    for _, weapon in pairs(cWeaponTypes) do
      --SMARTBUFF_AddMsgD(weapon);
      if (string.find(itemSubType, weapon)) then
        --SMARTBUFF_AddMsgD("Can apply " .. buff .. " on " .. itemSubType);
        return true, weapon;
      end
    end
  end
  return false;
end

-- END SMARTBUFF_CanApplyWeaponBuff


-- Check the unit blacklist
function SMARTBUFF_checkBlacklist()
  local t = GetTime();
  for unit in pairs(cBlacklist) do
    if (t > (cBlacklist[unit] + O.BlacklistTimer)) then
      cBlacklist[unit] = nil;
    end
  end
end

-- END SMARTBUFF_checkBlacklist


-- Casts a spell
function SMARTBUFF_doCast(unit, id, spellName, levels, buffType)
  SMARTBUFF_AddMsgD("doCast spellName "..spellName);
  if (id == nil) then return 9; end
  if (buffType == SMARTBUFF_CONST_TRACK and (GetTrackingTexture() ~= "Interface\\Minimap\\Tracking\\None")) then
    --SMARTBUFF_AddMsgD("Track already enabled: " .. iconTrack);
    return 7;
  end

  -- check if spell has cooldown
  local cooldown = C_Spell.GetSpellCooldown(spellName);
  local cd = nil;
  if (cooldown and type(cooldown) == "table") then
    cd = cooldown["duration"];
  end
  cd = tonumber(cd) or 0;
  -- Force numeric: secret values may survive tonumber(), validate with pcall before comparison
  local ok, _ = pcall(function() return cd + 0 end);
  if not ok then cd = 0; end
  if (cd > maxSkipCoolDown) then
    return 4;
  elseif (cd > 0) then
    return 1;
  end

  -- Rangecheck
  --SMARTBUFF_AddMsgD("Spell has range: "..spellName.." = "..ChkS(SpellHasRange(spellName)));
  if (buffType == SMARTBUFF_CONST_GROUP or buffType == SMARTBUFF_CONST_ITEMGROUP) then
    if (C_Spell.SpellHasRange(spellName)) then
      if (not C_Spell.IsSpellInRange(spellName, unit)) then
        return 3;
      end
    else
      -- TODO: This function is restricted to group only
      if (UnitInRange(unit) ~= 1) then
        return 3;
      end
    end
  end

  -- check if you have enough mana/energy/rage to cast
  local isUsable, notEnoughMana = C_Spell.IsSpellUsable(spellName);
  if (notEnoughMana) then
    return 6;
  end

  return 0;
end

-- END SMARTBUFF_doCast


-- checks if the unit is the player
function SMARTBUFF_IsPlayer(unit)
  if (unit and UnitIsUnit("player", unit)) then
    return true;
  end
  return false;
end

-- END SMARTBUFF_IsPlayer


function UnitBuffByBuffName(target, buffname, filter)
  for i = 1, 40 do
    local AuraData = C_UnitAuras.GetAuraDataByIndex(target, i, filter);
    if not AuraData then return end;
    local name = AuraData.name;
    -- Guard: name can be nil or secret value (type() may still report "string"); validate compare with pcall
    if not name then
      -- skip this aura, continue to next
    else
      local ok, isMatch = pcall(function() return name == buffname end);
      if ok and isMatch then
        local icon = AuraData.icon;
        local charges = AuraData.charges or 0;
        local dispelName = AuraData.dispelName;
        local duration = tonumber(AuraData.duration) or 0;
        local expirationTime = tonumber(AuraData.expirationTime) or 0;
        local source = AuraData.sourceUnit;
        return buffname, icon, charges, dispelName, duration, expirationTime, source;
      end
    end
  end
end

-- Will return the name of the buff to cast
function SMARTBUFF_CheckUnitBuffs(unit, buffN, buffT, buffL, buffC)
  if (not unit or (not buffN and not buffL)) then return end

  local i, n, v;
  local buff = nil;
  local defBuff = nil;
  local timeleft = nil;
  local duration = nil;
  local caster = nil;
  local count = nil;
  local icon = nil;
  -- local time = GetTime();
  local uname = UnitName(unit) or "?";
  if (buffN) then
    if (type(buffN) == "table") then
      defBuff = buffN.name;
    else
      defBuff = buffN;
    end
  else
    defBuff = buffL[1];
  end

  -- Stance/Presence/Seal check, these are not in the aura list
  n = cBuffIndex[defBuff];
  if (cBuffs[n] and cBuffs[n].Type == SMARTBUFF_CONST_STANCE) then
    if (defBuff and buffC and #buffC >= 1) then
      local t = B[CS()].Order;
      if (t and #t >= 1) then
        --SMARTBUFF_AddMsgD("Check chained stance: "..defBuff);
        for i = 1, #t, 1 do
          --print("Check for chained stance: "..t[i]);
          if (t[i] and ChainContains(buffC, t[i])) then
            v = GetBuffSettings(t[i]);
            if (v and v.EnableS) then
              for n = 1, GetNumShapeshiftForms(), 1 do
                local _, name, active, castable = GetShapeshiftFormInfo(n);
                --print(t[i]..", "..name..", active = "..(active or "nil"));
                if (name and not active and castable and name == t[i]) then
                  return defBuff, nil, nil, nil, nil;
                elseif (name and active and castable and name == t[i]) then
                  --print("Chained stance found: "..t[i]);
                  return nil, i, defBuff, 1800, -1;
                end
              end
            end
          end
        end
      end
    end
    return defBuff, nil, nil, nil, nil;

    --[[
    count = tonumber(cBuffs[n].Params);
    if (count) then
      if (count == GetShapeshiftForm()) then
        return nil, n, defBuff, 1800, -1;
      else
        SMARTBUFF_AddMsgD("BonusBarOffset: "..GetShapeshiftForm().." -> "..count);
      end
      return defBuff, nil, nil, nil, nil;
    end
    ]] --
  end

  -- Check linked buffs
  if (buffL) then
    if (not O.LinkSelfBuffCheck and buffT == SMARTBUFF_CONST_SELF) then
      -- Do not check linked self buffs
    elseif (not O.LinkGrpBuffCheck and buffT == SMARTBUFF_CONST_GROUP) then
      -- Do not check linked group buffs
    else
      for n, vt in pairs(buffL) do
        v = ResolveChainOrLinkEntry(vt);
        if (v and v ~= defBuff) then
          SMARTBUFF_AddMsgD("Check linked buff (" .. uname .. "): " .. v);
          buff, icon, count, _, duration, timeleft, caster = UnitBuffByBuffName(unit, v);
          if (buff) then
            timeleft = (tonumber(timeleft) or 0) - GetTime();
            if (timeleft > 0) then
              timeleft = timeleft;
            else
              timeleft = GetTime();
            end
            SMARTBUFF_AddMsgD("Linked buff found: " .. buff .. ", " .. timeleft .. ", " .. icon);
            return nil, n, defBuff, timeleft, count;
          end
        end
      end
    end
  end

  -- Check chained buffs (skip rogue poison chains when Dragon-Tempered Blades allows 2 of each type)
  if (defBuff and buffC and #buffC > 1) then
    local skipRoguePoisonChain = SMARTBUFF_RogueHasDragonTemperedBlades() and SMARTBUFF_IsRoguePoisonChain(buffC);
    if (not skipRoguePoisonChain) then
      local t = B[CS()].Order;
      if (t and #t > 1) then
        --SMARTBUFF_AddMsgD("Check chained buff ("..uname.."): "..defBuff);
        for i = 1, #t, 1 do
          if (t[i] and ChainContains(buffC, t[i])) then
            v = GetBuffSettings(t[i]);
            local cBI = cBuffs[cBuffIndex[t[i]]];
            if (v and v.EnableS and cBI) then
              local b, tl, im = SMARTBUFF_CheckBuff(unit, t[i]);
              if (b and im) then
                --SMARTBUFF_AddMsgD("Chained buff found: "..t[i]..", "..tl);
                if (SMARTBUFF_CheckBuffLink(unit, t[i], cBI.Type, cBI.Links)) then
                  return nil, i, defBuff, tl, -1;
                end
              elseif (not b and t[i] == defBuff) then
                return defBuff, nil, nil, nil, nil;
              end
            end
          end
        end
      end
    end
  end

  -- Check default buff
  if (defBuff) then
    SMARTBUFF_AddMsgD("Check default buff (" .. uname .. "): " .. defBuff);
    buff, icon, count, _, duration, timeleft, caster = UnitBuffByBuffName(unit, defBuff);
    if (buff) then
      timeleft = (tonumber(timeleft) or 0) - GetTime();
      if (timeleft > 0) then
        timeleft = timeleft;
      else
        timeleft = GetTime();
      end
      if (SMARTBUFF_IsPlayer(caster)) then
        SMARTBUFF_UpdateBuffDuration(defBuff, duration);
      end
      SMARTBUFF_AddMsgD("Default buff found: " .. buff .. ", " .. timeleft .. ", " .. icon);
      return nil, 0, defBuff, timeleft, count;
    end
  end

  -- Buff not found, return default buff
  return defBuff, nil, nil, nil, nil;
end

function SMARTBUFF_CheckBuffLink(unit, defBuff, buffT, buffL)
  -- Check linked buffs
  if (buffL) then
    if (not O.LinkSelfBuffCheck and buffT == SMARTBUFF_CONST_SELF) then
      -- Do not check linked self buffs
    elseif (not O.LinkGrpBuffCheck and buffT == SMARTBUFF_CONST_GROUP) then
      -- Do not check linked group buffs
    else
      for n, v in pairs(buffL) do
        local linkName = ResolveChainOrLinkEntry(v);
        if (linkName and linkName ~= defBuff) then
          SMARTBUFF_AddMsgD("Check linked buff (" .. (UnitName(unit) or "?") .. "): " .. linkName);
          buff, icon, count, _, duration, timeleft, caster = UnitBuffByBuffName(unit, linkName);
          if (buff) then
            timeleft = (tonumber(timeleft) or 0) - GetTime();
            if (timeleft > 0) then
              timeleft = timeleft;
            else
              timeleft = GetTime();
            end
            SMARTBUFF_AddMsgD("Linked buff found: " .. buff .. ", " .. timeleft .. ", " .. icon);
            return nil, n, defBuff, timeleft, count;
          end
        end
      end
    end
  end
  return defBuff;
end

function SMARTBUFF_CheckBuffChain(unit, buff, chain)
  local i;
  if (buff and chain and #chain > 1) then
    local skipRoguePoisonChain = SMARTBUFF_RogueHasDragonTemperedBlades() and SMARTBUFF_IsRoguePoisonChain(chain);
    if (not skipRoguePoisonChain) then
      local t = B[CS()].Order;
      if (t and #t > 1) then
        SMARTBUFF_AddMsgD("Check chained buff: " .. buff);
        for i = 1, #t, 1 do
          if (t[i] and t[i] ~= buff and ChainContains(chain, t[i])) then
            local b, tl, im = SMARTBUFF_CheckBuff(unit, t[i], true);
            if (b and im) then
              SMARTBUFF_AddMsgD("Chained buff found: " .. t[i]);
              return nil, i, buff, tl, -1;
            end
          end
        end
      end
    end
  end
  return buff;
end

function SMARTBUFF_UpdateBuffDuration(buff, duration)
  local i = cBuffIndex[buff];
  if (i ~= nil and cBuffs[i] ~= nil and buff == cBuffs[i].BuffS) then
    if (cBuffs[i].DurationS ~= nil and cBuffs[i].DurationS > 0 and cBuffs[i].DurationS ~= duration) then
      SMARTBUFF_AddMsgD("Updated buff duration: " .. buff .. " = " .. duration .. "sec, old = " .. cBuffs[i].DurationS);
      cBuffs[i].DurationS = duration;
    end
  end
end

function UnitAuraBySpellName(target, spellname, filter)
  for i = 1, 40 do
    local AuraData = C_UnitAuras.GetAuraDataByIndex(target, i, filter);
    if not AuraData then return end;
    local name = AuraData.name;
    -- Guard: name can be nil or secret value (type() may still report "string"); validate compare with pcall
    if not name then
      -- skip this aura, continue to next
    else
      local ok, isMatch = pcall(function() return name == spellname end);
      if ok and isMatch then
        local timeleft = tonumber(AuraData.expirationTime) or 0;
        local caster = AuraData.sourceUnit;
        return spellname, timeleft, caster;
      end
    end
  end
end

function SMARTBUFF_CheckBuff(unit, buffName, isMine)
  if (not unit or not buffName) then
    return false, 0;
  end
  local buff, timeleft, caster = UnitAuraBySpellName(unit, buffName, "HELPFUL");
  if (buff) then
    SMARTBUFF_AddMsgD(UnitName(unit) .. " buff found: " .. buff, 0, 1, 0.5);
    if (buff == buffName) then
      timeleft = (tonumber(timeleft) or 0) - GetTime();
      if (timeleft > 0) then
        timeleft = timeleft;
      else
        timeleft = GetTime();
      end
      if (isMine and caster) then
        if (SMARTBUFF_IsPlayer(caster)) then
          return true, timeleft, caster;
        end
        return false, 0, nil;
      end
      return true, timeleft, SMARTBUFF_IsPlayer(caster);
    end
  end
  return false, 0;
end

-- END SMARTBUFF_CheckUnitBuffs


-- Will return the name/description of the buff
function SMARTBUFF_GetBuffName(unit, buffIndex, line)
  local i = buffIndex;
  local name = nil;
  if (i < 0 or i > maxBuffs) then
    return nil;
  end
  --SmartBuffTooltip:SetOwner(SmartBuffFrame, "ANCHOR_NONE");
  SmartBuffTooltip:ClearLines();
  SmartBuffTooltip:SetUnitBuff(unit, i);
  local obj = _G["SmartBuffTooltipTextLeft" .. line];
  if (obj) then
    name = obj:GetText();
  end
  return name;
end

-- END SMARTBUFF_GetBuffName


-- IsFeignDeath(unit)
function SMARTBUFF_IsFeignDeath(unit)
  return UnitIsFeignDeath(unit);
end

-- END SMARTBUFF_IsFeignDeath

---Scan localized aura names for "food", "drink" or "food & drink"
---@param unit? string default: "player"
---@return boolean returns `true` if the player is eating or drinking, `false` otherwise
function SMARTBUFF_IsPicnic(unit)
  if not unit then unit = "player" end
  local nameE = SMARTBUFF_EatingAura and SMARTBUFF_EatingAura.name;
  local nameD = SMARTBUFF_DrinkingAura and SMARTBUFF_DrinkingAura.name;
  local nameFD = SMARTBUFF_FoodDrinkAura and SMARTBUFF_FoodDrinkAura.name;
  if (nameE and AuraUtil.FindAuraByName(nameE, unit, "HELPFUL")) or
      (nameD and AuraUtil.FindAuraByName(nameD, unit, "HELPFUL")) or
      (nameFD and AuraUtil.FindAuraByName(nameFD, unit, "HELPFUL")) then
    return true
  end
  return false
end

---Scan localized aura names for "well fed" or "hearty well fed"
---@param unit? string default: "player"
---@return boolean returns `true` if the player is well fed, `false` otherwise
function SMARTBUFF_IsWellFed(unit)
  if not unit then unit = "player" end
  local nameW = SMARTBUFF_WellFedAura and SMARTBUFF_WellFedAura.name;
  local nameH = SMARTBUFF_HeartyFedAura and SMARTBUFF_HeartyFedAura.name;
  if (nameW and AuraUtil.FindAuraByName(nameW, unit, "HELPFUL")) or
      (nameH and AuraUtil.FindAuraByName(nameH, unit, "HELPFUL")) then
    return true
  end
  return false
end

-- IsFishing(unit)
function SMARTBUFF_IsFishing(unit)
  -- name, displayName, textureID, startTimeMs, endTimeMs, isTradeskill, notInterruptible,
  -- spellID, isEmpowered, numEmpowerStages = UnitChannelInfo(unitToken)
  local spell = UnitChannelInfo(unit);
  if (spell ~= nil and SMARTBUFF_FISHING.name ~= nil and spell == SMARTBUFF_FISHING.name) then
    SMARTBUFF_AddMsgD("Channeling "..SMARTBUFF_FISHING.name);
    return true;
  end
  return false;
end

function SMARTBUFF_IsFishingPoleEquiped()
  if (not SG or not SG.FishingPole) then return false end

  local link = GetInventoryItemLink("player", GetInventorySlotInfo("MainHandSlot"));
  if (not link) then return false end

  local itemID = ExtractItemID(link);
  local _, _, _, _, _, _, subType = C_Item.GetItemInfo(itemID);
  if (not subType) then
    -- Item data not loaded - request loading (AllTheThings pattern)
    if (itemID) then
      C_Item.RequestLoadItemDataByID(itemID);
    end
    return false;
  end

  --print(SG.FishingPole.." - "..subType);
  if (SG.FishingPole == subType) then return true end

  return false;
end

-- END SMARTBUFF_IsFishing

-- SMARTBUFF_IsSpell(sType)
function SMARTBUFF_IsSpell(sType)
  return sType == SMARTBUFF_CONST_GROUP or sType == SMARTBUFF_CONST_GROUPALL or sType == SMARTBUFF_CONST_SELF or
  sType == SMARTBUFF_CONST_FORCESELF or sType == SMARTBUFF_CONST_WEAPON or sType == SMARTBUFF_CONST_STANCE or
  sType == SMARTBUFF_CONST_ITEM;
end

-- END SMARTBUFF_IsSpell

-- SMARTBUFF_IsItem(sType)
function SMARTBUFF_IsItem(sType)
  return sType == SMARTBUFF_CONST_INV or sType == SMARTBUFF_CONST_FOOD or sType == SMARTBUFF_CONST_SCROLL or
  sType == SMARTBUFF_CONST_POTION or sType == SMARTBUFF_CONST_ITEMGROUP;
end

-- END SMARTBUFF_IsItem


-- Loops through all of the debuffs currently active looking for a texture string match
function SMARTBUFF_IsDebuffTexture(unit, debufftex)
  local active = false;
  local i = 1;
  local name, icon;
  -- name,rank,icon,count,type = UnitDebuff("unit", id or "name"[,"rank"])
  while (C_UnitAuras.GetDebuffDataByIndex(unit, i)) do
    local DebuffInfo = C_UnitAuras.GetDebuffDataByIndex(unit, i);
    name = DebuffInfo.name;
    icon = DebuffInfo.icon;
    -- Guard: icon can be nil or secret value
    if (icon and type(icon) == "string" and string.find(icon, debufftex)) then
      active = true;
      break
    end
    i = i + 1;
  end
  return active;
end

-- END SMARTASPECT_IsDebuffTex



-- Unified internal function for finding items in bags
-- Searches on ItemLink in addition to itemText to support Dragonflight and above item qualities
-- Returns: firstBag, firstSlot, firstCount, totalCount, itemID, texture
--   - firstBag, firstSlot: First match location (or 999, toyID for toys)
--   - firstCount: Stack count of first match (for FindItem)
--   - totalCount: Sum of all matching items across all bags (for CountReagent)
--   - itemID: Item ID of first match
--   - texture: Icon of first match
local function SMARTBUFF_FindItemInternal(reagent, chain, debug)
  if (reagent == nil) then
    if (debug) then
      SMARTBUFF_AddMsgD("FindItem: reagent is nil");
    end
    return nil, nil, 0, 0, nil, nil;
  end
  
  -- Handle special case: "ScanBagsForSBInit" is just a trigger, not a real item
  if (type(reagent) == "string" and reagent == "ScanBagsForSBInit") then
    return nil, nil, 0, 0, nil, nil;
  end
  
  if (O.IncludeToys) then
    -- reagent can be itemLink (string), itemID (number), or placeholder "item:12345"
    local link = nil;
    local itemID = nil;
    
    if (type(reagent) == "string") then
      -- Check if it's a full itemLink (starts with |c)
      if (string.match(reagent, "^|c")) then
        link = reagent;
        -- Extract itemID from full itemLink for matching
        itemID = tonumber(string.match(reagent, "item:(%d+)"));
      elseif (string.match(reagent, "^item:%d+$")) then
        -- Placeholder format "item:12345" - extract itemID
        itemID = tonumber(string.match(reagent, "item:(%d+)"));
        -- Try to get full itemLink from API
        if (itemID) then
          local _, itemLink = C_Item.GetItemInfo(itemID);
          link = itemLink;
        end
      end
    elseif (type(reagent) == "number") then
      -- itemID - need to get itemLink
      itemID = reagent;
      local _, itemLink = C_Item.GetItemInfo(reagent);
      link = itemLink;
    end
    
    -- Try direct link match first
    if (link) then
      local toy = SG.Toybox[link];
      if (toy) then
        if (debug) then
          SMARTBUFF_AddMsgD("FindItem: Found toy by link");
        end
        -- For toys: bag=999 (special marker), slot=toyID, firstCount=1, totalCount=1, id=toyID, texture=toyIcon
        return 999, toy[1], 1, 1, toy[1], toy[2];
      end
    end
    
    -- O(1) toy lookup by itemID via ToyboxByID index (avoids O(n) pairs over Toybox every check)
    if (itemID and SG.ToyboxByID) then
      local toy = SG.ToyboxByID[itemID];
      if (toy) then
        if (debug) then
          SMARTBUFF_AddMsgD("FindItem: Found toy by itemID");
        end
        return 999, toy[1], 1, 1, toy[1], toy[2];
      end
    end
  end

  local totalCount = 0;
  local itemID = nil;
  local firstBag = nil;
  local firstSlot = nil;
  local firstCount = 0;
  local texture = nil;
  
  if not (chain) then chain = { reagent }; end
  
  if (debug) then
    SMARTBUFF_AddMsgD("FindItem: Searching for reagent=" .. tostring(reagent) .. ", chain size=" .. #chain);
    for i = 1, #chain do
      local chainItem = chain[i];
      SMARTBUFF_AddMsgD("  Chain[" .. i .. "]: " .. tostring(chainItem) .. " (type: " .. type(chainItem) .. ")");
    end
  end
  
  for bag = 0, NUM_BAG_FRAMES do
    for slot = 1, C_Container.GetContainerNumSlots(bag) do
      local bagItemID = C_Container.GetContainerItemID(bag, slot);
      if (bagItemID) then
        for i = 1, #chain, 1 do
          -- Handle both numeric IDs and item link strings
          -- Supports Dragonflight item qualities by extracting ID from item links
          local buffItemID = nil;
          if type(chain[i]) == "number" then
            buffItemID = chain[i];
          elseif type(chain[i]) == "string" then
            buffItemID = tonumber(string.match(chain[i], "item:(%d+)"));
          end
          
          if buffItemID and buffItemID == bagItemID then
            local containerInfo = C_Container.GetContainerItemInfo(bag, slot);
            if (containerInfo) then
              -- Store first match location, count, and icon
              if (firstBag == nil) then
                firstBag = bag;
                firstSlot = slot;
                firstCount = containerInfo.stackCount;
                itemID = buffItemID;
                texture = containerInfo.iconFileID;
              end
              -- Sum all matches for total count
              totalCount = totalCount + containerInfo.stackCount;
              
              if (debug) then
                SMARTBUFF_AddMsgD("FindItem: MATCH! bagItemID=" .. bagItemID .. " matches chain[" .. i .. "]=" .. buffItemID);
              end
            end
          end
        end
      end
    end
  end
  
  if (debug and totalCount == 0) then
    SMARTBUFF_AddMsgD("FindItem: Not found in inventory, returning count=0");
  end
  
  return firstBag, firstSlot, firstCount, totalCount, itemID, texture;
end

-- Returns the number of a reagent currently in player's bag
-- we now search on ItemLink in addition to itemText, in order to support Dragonflight item qualities
-- Returns: totalCount, itemID (sum of all matches across all bags)
function SMARTBUFF_CountReagent(reagent, chain)
  local _, _, _, totalCount, itemID = SMARTBUFF_FindItemInternal(reagent, chain, false);
  if (reagent == nil) then
    return -1, nil;
  end
  return totalCount, itemID;
end

-- Returns the first matching item location and icon
-- we now search on ItemLink in addition to itemText, in order to support Dragonflight item qualities
-- Returns: bag, slot, count, texture (first match only - count is stackCount of first match)
function SMARTBUFF_FindItem(reagent, chain)
  local bag, slot, firstCount, _, _, texture = SMARTBUFF_FindItemInternal(reagent, chain, true);
  if (reagent == nil) then
    return nil, nil, -1, nil;
  end
  return bag, slot, firstCount, texture;
end

-- END Reagent functions


-- checks if the player is inside a battlefield
function SMARTBUFF_IsActiveBattlefield(zone)
  local i, status, map, instanceId, teamSize;
  for i = 1, GetMaxBattlefieldID() do
    status, map, instanceId, _, _, teamSize = GetBattlefieldStatus(i);
    if (status and status ~= "none") then
      SMARTBUFF_AddMsgD("Battlefield status = " ..
      ChkS(status) ..
      ", Id = " .. ChkS(instanceId) .. ", TS = " .. ChkS(teamSize) .. ", Map = " .. ChkS(map) .. ", Zone = " ..
      ChkS(zone));
    else
      SMARTBUFF_AddMsgD("Battlefield status = none");
    end
    if (status and status == "active" and map) then
      if (teamSize and type(teamSize) == "number" and teamSize > 0) then
        return 2;
      end
      return 1;
    end
  end
  return 0;
end

-- END IsActiveBattlefield


-- Helper functions ---------------------------------------------------------------------------------------
function SMARTBUFF_toggleBool(b, msg)
  if (not b or b == nil) then
    b = true;
    SMARTBUFF_AddMsg(SMARTBUFF_TITLE .. ": " .. msg .. GR .. "On", true);
  else
    b = false
    SMARTBUFF_AddMsg(SMARTBUFF_TITLE .. ": " .. msg .. RD .. "Off", true);
  end
  return b;
end

function SMARTBUFF_BoolState(b, msg)
  if (b) then
    SMARTBUFF_AddMsg(SMARTBUFF_TITLE .. ": " .. msg .. GR .. "On", true);
  else
    SMARTBUFF_AddMsg(SMARTBUFF_TITLE .. ": " .. msg .. RD .. "Off", true);
  end
end

function SMARTBUFF_Split(msg, char)
  local arr = {};
  while (string.find(msg, char)) do
    local iStart, iEnd = string.find(msg, char);
    tinsert(arr, strsub(msg, 1, iStart - 1));
    msg = strsub(msg, iEnd + 1, strlen(msg));
  end
  if (strlen(msg) > 0) then
    tinsert(arr, msg);
  end
  return arr;
end

-- END Bool helper functions


-- Init the SmartBuff variables ---------------------------------------------------------------------------------------
function SMARTBUFF_Options_Init(self)
  if (isInit) then return; end

  self:UnregisterEvent("CHAT_MSG_CHANNEL");
  self:UnregisterEvent("UPDATE_MOUSEOVER_UNIT");

  --DebugChatFrame:AddMessage("Starting init SB");

  _, sPlayerClass = UnitClass("player");
  sRealmName = GetRealmName();
  sPlayerName = UnitName("player");
  sID = sRealmName .. ":" .. sPlayerName;
  --AutoSelfCast = GetCVar("autoSelfCast");

  SMARTBUFF_PLAYERCLASS = sPlayerClass;

  if (type(SMARTBUFF_Buffs) ~= "table") then SMARTBUFF_Buffs = {}; end
  B = SMARTBUFF_Buffs;
  if (type(SMARTBUFF_Options) ~= "table") then SMARTBUFF_Options = {}; end
  O = SMARTBUFF_Options;

  SMARTBUFF_BROKER_SetIcon();


  if (O.Toggle == nil) then O.Toggle = true; end
  if (O.ToggleAuto == nil) then O.ToggleAuto = true; end
  if (O.AutoTimer == nil) then O.AutoTimer = 5; end
  if (O.BlacklistTimer == nil) then O.BlacklistTimer = 5; end
  if (O.ToggleAutoCombat == nil) then O.ToggleAutoCombat = false; end
  if (O.ToggleAutoChat == nil) then O.ToggleAutoChat = false; end
  if (O.ToggleAutoSplash == nil) then O.ToggleAutoSplash = true; end
  if (O.ToggleAutoSound == nil) then O.ToggleAutoSound = true; end
  if (O.AutoSoundSelection == nil) then O.AutoSoundSelection = 4; end;
  if (O.CheckCharges == nil) then O.CheckCharges = true; end
  --if (O.ToggleAutoRest == nil) then  O.ToggleAutoRest = true; end
  if (O.RebuffTimer == nil) then O.RebuffTimer = 20; end
  if (O.SplashDuration == nil) then O.SplashDuration = 2; end
  if (O.SplashIconSize == nil) then O.SplashIconSize = 16; end

  if (O.BuffTarget == nil) then O.BuffTarget = false; end
  if (O.BuffPvP == nil) then O.BuffPvP = false; end
  if (O.BuffInCities == nil) then O.BuffInCities = true; end
  if (O.LinkSelfBuffCheck == nil) then O.LinkSelfBuffCheck = true; end
  if (O.LinkGrpBuffCheck == nil) then O.LinkGrpBuffCheck = true; end

  if (O.ScrollWheel ~= nil and O.ScrollWheelUp == nil) then O.ScrollWheelUp = O.ScrollWheel; end
  if (O.ScrollWheel ~= nil and O.ScrollWheelDown == nil) then O.ScrollWheelDown = O.ScrollWheel; end
  if (O.ScrollWheelUp == nil) then O.ScrollWheelUp = true; end
  if (O.ScrollWheelDown == nil) then O.ScrollWheelDown = true; end

  if (O.InCombat == nil) then O.InCombat = true; end
  if (O.IncludeToys == nil) then O.IncludeToys = false; end
  if (O.AutoSwitchTemplate == nil) then O.AutoSwitchTemplate = true; end
  if (O.AutoSwitchTemplateInst == nil) then O.AutoSwitchTemplateInst = true; end
  if (O.InShapeshift == nil) then O.InShapeshift = true; end

  O.ToggleGrp = { true, true, true, true, true, true, true, true };

  if (O.ToggleMsgNormal == nil) then O.ToggleMsgNormal = true; end
  if (O.ToggleMsgWarning == nil) then O.ToggleMsgWarning = true; end
  if (O.ToggleMsgError == nil) then O.ToggleMsgError = false; end

  if (O.HideMmButton == nil) then O.HideMmButton = false; end
  if (O.HideSAButton == nil) then O.HideSAButton = false; end

  if (O.SBButtonFix == nil) then O.SBButtonFix = false; end
  if (O.SBButtonDownVal == nil or O.SBButtonDownVal == true or O.SBButtonDownVal == false) then O.SBButtonDownVal =
    C_CVar.GetCVar("ActionButtonUseKeyDown"); end

  if (O.MinCharges == nil) then
    if (sPlayerClass == "SHAMAN" or sPlayerClass == "PRIEST") then
      O.MinCharges = 1;
    else
      O.MinCharges = 3;
    end
  end

  if (not O.AddList) then O.AddList = {}; end
  if (not O.IgnoreList) then O.IgnoreList = {}; end

  if (O.LastTemplate == nil) then O.LastTemplate = SMARTBUFF_TEMPLATES[1]; end
  local b = false;
  while (SMARTBUFF_TEMPLATES[i] ~= nil) do
    if (SMARTBUFF_TEMPLATES[i] == O.LastTemplate) then
      b = true;
      break;
    end
    i = i + 1;
  end
  if (not b) then
    O.LastTemplate = SMARTBUFF_TEMPLATES[1];
  end

  currentTemplate = O.LastTemplate;
  currentSpec = GetSpecialization();

  if (O.OldWheelUp == nil) then O.OldWheelUp = ""; end
  if (O.OldWheelDown == nil) then O.OldWheelDown = ""; end

  SMARTBUFF_InitActionButtonPos();

  if (O.SplashX == nil) then O.SplashX = 100; end
  if (O.SplashY == nil) then O.SplashY = -100; end
  if (O.CurrentFont == nil) then O.CurrentFont = 6; end
  if (O.ColSplashFont == nil) then
    O.ColSplashFont = {};
    O.ColSplashFont.r = 1.0;
    O.ColSplashFont.g = 1.0;
    O.ColSplashFont.b = 1.0;
  end
  iCurrentFont = O.CurrentFont;

  if (O.Debug == nil) then O.Debug = false; end

  -- Cosmos support
  if (EarthFeature_AddButton) then
    EarthFeature_AddButton(
      {
        id = SMARTBUFF_TITLE,
        name = SMARTBUFF_TITLE,
        subtext = SMARTBUFF_TITLE,
        tooltip = "",
        icon = imgSB,
        callback = SMARTBUFF_OptionsFrame_Toggle,
        test = nil,
      })
  elseif (Cosmos_RegisterButton) then
    Cosmos_RegisterButton(SMARTBUFF_TITLE, SMARTBUFF_TITLE, SMARTBUFF_TITLE, imgSB, SMARTBUFF_OptionsFrame_Toggle);
  end

  if (C_AddOns.IsAddOnLoaded("Parrot")) then
    isParrot = true;
  end

  SMARTBUFF_FindItem("ScanBagsForSBInit");

  SMARTBUFF_AddMsg(SMARTBUFF_VERS_TITLE .. " " .. SMARTBUFF_MSG_LOADED, true);
  SMARTBUFF_AddMsg("/sbm - " .. SMARTBUFF_OFT_MENU, true);
  isInit = true;

  SMARTBUFF_CheckMiniMapButton();
  SMARTBUFF_MinimapButton_OnUpdate(SmartBuff_MiniMapButton);
  SMARTBUFF_ShowSAButton();
  SMARTBUFF_Splash_Hide();

  if (O.UpgradeToDualSpec == nil) then
    for n = 1, GetNumSpecGroups(), 1 do
      if (B[n] == nil) then
        B[n] = {};
      end
      for k, v in pairs(SMARTBUFF_TEMPLATES) do
        SMARTBUFF_AddMsgD(v);
        if (B[v] ~= nil) then
          B[n][v] = B[v];
        end
      end
    end
    for k, v in pairs(SMARTBUFF_TEMPLATES) do
      if (B[v] ~= nil) then
        wipe(B[v]);
        B[v] = nil;
      end
    end
    O.UpgradeToDualSpec = true;
    SMARTBUFF_AddMsg("Upgraded to dual spec", true);
  end

  for k, v in pairs(cClasses) do
    if (SMARTBUFF_CLASSES[k] == nil) then
      SMARTBUFF_CLASSES[k] = v;
    end
  end

  -- Show version prompt (What's New) before any rebuild so user always sees it even if rebuild errors
  if (type(SMARTBUFF_OptionsGlobal) ~= "table") then
    SMARTBUFF_OptionsGlobal = {};
    SMARTBUFF_BuffOrderReset();
  end
  OG = SMARTBUFF_OptionsGlobal;
  if (OG.SplashIcon == nil) then OG.SplashIcon = true; end
  if (OG.SplashMsgShort == nil) then OG.SplashMsgShort = false; end
  if (OG.FirstStart == nil) then OG.FirstStart = "V0"; end

  SMARTBUFF_Splash_ChangeFont(0);

  -- Version prompt uses SMARTBUFF_VERSION (string); often only this is bumped, not SMARTBUFF_VERSIONNR
  if (OG.FirstStart ~= SMARTBUFF_VERSION) then
    SMARTBUFF_OptionsFrame_Open(true);
    OG.FirstStart = SMARTBUFF_VERSION;
    if (OG.Tutorial == nil) then
      OG.Tutorial = SMARTBUFF_VERSIONNR;
      SMARTBUFF_ToggleTutorial();
    end
    SmartBuffOptionsCredits_lblText:SetText(SMARTBUFF_CREDITS); -- bugfix, credits now showing at first start
    SmartBuffWNF_lblText:SetText(SMARTBUFF_WHATSNEW);
    -- Ensure options frame is visible and positioned before showing WNF frame
    if (SmartBuffOptionsFrame:IsVisible()) then
      SmartBuffWNF:Show();
    else
      -- If options frame isn't visible yet, show WNF after a short delay
      C_Timer.After(0.1, function()
        if (SmartBuffOptionsFrame:IsVisible()) then
          SmartBuffWNF:Show();
        end
      end);
    end
  end

  -- Buff data reset uses O.VersionNr / SMARTBUFF_VERSIONNR (number); only when that changes (purge + rebuild)
  O.VersionNr = O.VersionNr or SMARTBUFF_VERSIONNR -- don't reset if O.VersionNr == nil
  if (O.VersionNr ~= SMARTBUFF_VERSIONNR) then
    O.VersionNr = SMARTBUFF_VERSIONNR;
    StaticPopup_Show("SMARTBUFF_BUFFS_PURGE");
    SMARTBUFF_SetTemplate()
    InitBuffOrder(true);
    SMARTBUFF_AddMsg("Upgraded SmartBuff to " .. SMARTBUFF_VERSION, true);
  end
  -- TODO: Bring back major reset of everything but also there's a UI button still to do it

  if (not IsVisibleToPlayer(SmartBuff_KeyButton)) then
    SmartBuff_KeyButton:ClearAllPoints();
    SmartBuff_KeyButton:SetPoint("CENTER", UIParent, "CENTER", 0, 100);
  end

  -- Initialize mount state
  isMounted = IsMounted() or IsFlying();

  -- Call SMARTBUFF_SetTemplate() first to set up currentTemplate and groups
  -- Then it will call SMARTBUFF_SetBuffs() internally
  -- This ensures proper initialization order
  SMARTBUFF_SetTemplate(true);
  SMARTBUFF_RebindKeys();
  isSyncReq = true;
  -- Initialize tLastCheck to ensure AutoTimer works correctly after dismounting
  tLastCheck = GetTime();
end

-- END SMARTBUFF_Options_Init

function SMARTBUFF_InitActionButtonPos()
  if (InCombatLockdown()) then return end

  isInitBtn = true;
  if (O.ActionBtnX == nil) then
    SMARTBUFF_SetButtonPos(SmartBuff_KeyButton);
  else
    SmartBuff_KeyButton:ClearAllPoints();
    SmartBuff_KeyButton:SetPoint("TOPLEFT", UIParent, "TOPLEFT", O.ActionBtnX, O.ActionBtnY);
  end
  --print(format("x = %.0f, y = %.0f", O.ActionBtnX, O.ActionBtnY));
end

-- Reset all: O, B, and all caches (keeps OG: account-level splash/tutorial). Full clear; requires ReloadUI.
function SMARTBUFF_ResetAll()
  currentUnit = nil;
  currentSpell = nil;
  tCastRequested = 0;
  SMARTBUFF_InvalidateBuffCache();

  wipe(SMARTBUFF_Options);
  SMARTBUFF_Options = {};

  wipe(SMARTBUFF_Buffs);
  SMARTBUFF_Buffs = {};

  SMARTBUFF_WipeAndInitBuffListCache();
  SMARTBUFF_WipeAndInitItemSpellCache();
  SMARTBUFF_WipeAndInitBuffRelationsCache();
  SMARTBUFF_WipeAndInitToyCache();
  SMARTBUFF_WipeAndInitValidSpells();

  ReloadUI();
end

-- Reset only buffs: wipe all buff-related saved vars and reinit to safe defaults. Keeps SMARTBUFF_Options and global caches.
function SMARTBUFF_ResetBuffs()
  currentUnit = nil;
  currentSpell = nil;
  tCastRequested = 0;
  SMARTBUFF_InvalidateBuffCache();

  wipe(SMARTBUFF_Buffs);
  SMARTBUFF_Buffs = {};

  SMARTBUFF_ClearValidSpells();

  SMARTBUFF_SetTemplate();
  InitBuffOrder(true);
  SMARTBUFF_OptionsFrame_Close(true);
end

function SMARTBUFF_SetButtonPos(self)
  local x, y = self:GetLeft(), self:GetTop() - UIParent:GetHeight();
  O.ActionBtnX = x;
  O.ActionBtnY = y;
  --print(format("x = %.0f, y = %.0f", x, y));
end

function SMARTBUFF_RebindKeys()
  -- Keybinding APIs are protected during combat; skip so we don't trigger ADDON_ACTION_BLOCKED
  if (InCombatLockdown()) then return; end
  ClearOverrideBindings(SmartBuffFrame);
  local i;
  isRebinding = true;
  for i = 1, GetNumBindings(), 1 do
    local s = "";
    local command, category, key1, key2 = GetBinding(i);

    --if (command and key1) then
    --  SMARTBUFF_AddMsgD(i .. " = " .. command .. " - " .. key1;
    --end

    if (key1 and key1 == "MOUSEWHEELUP" and command ~= "SmartBuff_KeyButton") then
      O.OldWheelUp = command;
      --SMARTBUFF_AddMsgD("Old wheel up: " .. command);
    elseif (key1 and key1 == "MOUSEWHEELDOWN" and command ~= "SmartBuff_KeyButton") then
      O.OldWheelDown = command;
      --SMARTBUFF_AddMsgD("Old wheel down: " .. command);
    end

    if (command and command == "SMARTBUFF_BIND_TRIGGER") then
      --s = i .. " = " .. command;
      if (key1) then
        --s = s .. ", key1 = " .. key1 .. " rebound";
        SetOverrideBindingClick(SmartBuffFrame, false, key1, "SmartBuff_KeyButton");
      end
      if (key2) then
        --s = s .. ", key2 = " .. key2 .. " rebound";
        SetOverrideBindingClick(SmartBuffFrame, false, key2, "SmartBuff_KeyButton");
      end
      --SMARTBUFF_AddMsgD(s);
      break;
    end
  end

  if (O.ScrollWheelUp) then
    isKeyUpChanged = true;
    SetOverrideBindingClick(SmartBuffFrame, false, "MOUSEWHEELUP", "SmartBuff_KeyButton", "MOUSEWHEELUP");
    --SMARTBUFF_AddMsgD("Set wheel up");
  else
    if (isKeyUpChanged) then
      isKeyUpChanged = false;
      SetOverrideBinding(SmartBuffFrame, false, "MOUSEWHEELUP");
      --SMARTBUFF_AddMsgD("Set old wheel up: " .. O.OldWheelUp);
    end
  end

  if (O.ScrollWheelDown) then
    isKeyDownChanged = true;
    SetOverrideBindingClick(SmartBuffFrame, false, "MOUSEWHEELDOWN", "SmartBuff_KeyButton", "MOUSEWHEELDOWN");
    --SMARTBUFF_AddMsgD("Set wheel down");
  else
    if (isKeyDownChanged) then
      isKeyDownChanged = false;
      SetOverrideBinding(SmartBuffFrame, false, "MOUSEWHEELDOWN");
      --SMARTBUFF_AddMsgD("Set old wheel down: " .. O.OldWheelDown);
    end
  end
  isRebinding = false;
end

function SMARTBUFF_ResetBindings()
  if (not isRebinding) then
    isRebinding = true;
    if (O.OldWheelUp == "SmartBuff_KeyButton") then
      SetBinding("MOUSEWHEELUP", "CAMERAZOOMIN");
    else
      SetBinding("MOUSEWHEELUP", O.OldWheelUp);
    end
    if (O.OldWheelDown == "SmartBuff_KeyButton") then
      SetBinding("MOUSEWHEELDOWN", "CAMERAZOOMOUT");
    else
      SetBinding("MOUSEWHEELDOWN", O.OldWheelDown);
    end
    SaveBindings(GetCurrentBindingSet());
    SMARTBUFF_RebindKeys();
  end
end

-- SmartBuff commandline menu ---------------------------------------------------------------------------------------
function SMARTBUFF_command(msg)
  if (not isInit) then
    SMARTBUFF_AddMsgWarn(SMARTBUFF_VERS_TITLE .. " not initialized correctly!", true);
    return;
  end

  if (msg == "toggle" or msg == "t") then
    SMARTBUFF_OToggle();
    SMARTBUFF_SetTemplate();
  elseif (msg == "menu") then
    SMARTBUFF_OptionsFrame_Toggle();
  elseif (msg == "rbt") then
    SMARTBUFF_ResetBuffTimers();
  elseif (msg == "sbt") then
    SMARTBUFF_ShowBuffTimers();
  elseif (msg == "target") then
    if (SMARTBUFF_PreCheck(0)) then
      SMARTBUFF_checkBlacklist();
      SMARTBUFF_BuffUnit("target", 0, 0);
    end
  elseif (msg == "debug") then
    O.Debug = SMARTBUFF_toggleBool(O.Debug, "Debug active = ");
  elseif (msg == "open") then
    SMARTBUFF_OptionsFrame_Open(true);
  elseif (msg == "sync") then
    SMARTBUFF_SyncBuffTimers();
  elseif (msg == "rb") then
    SMARTBUFF_ResetBindings();
    SMARTBUFF_AddMsg("SmartBuff key and mouse bindings reset.", true);
  elseif (msg == "rafp") then
    SmartBuffSplashFrame:ClearAllPoints();
    SmartBuffSplashFrame:SetPoint("CENTER", UIParent, "CENTER");
    SmartBuff_MiniMapButton:ClearAllPoints();
    SmartBuff_MiniMapButton:SetPoint("TOPLEFT", Minimap, "TOPLEFT");
    SmartBuff_KeyButton:ClearAllPoints();
    SmartBuff_KeyButton:SetPoint("CENTER", UIParent, "CENTER");
    SmartBuffOptionsFrame:ClearAllPoints();
    SmartBuffOptionsFrame:SetPoint("CENTER", UIParent, "CENTER");
  elseif (msg == "test") then
    -- Test Code ******************************************
    -- ****************************************************
    --local spellname = "Mind--numbing Poison";
    --SMARTBUFF_AddMsg("Original: " .. spellname, true);
    --if (string.find(spellname, "%-%-") ~= nil) then
    --  spellname = string.gsub(spellname, "%-%-", "%-");
    --end
    --SMARTBUFF_AddMsg("Modified: " .. spellname, true);
    -- ****************************************************
    -- ****************************************************
  elseif (msg == "changes") then
    SMARTBUFF_OptionsFrame_Open(true);
    SmartBuffWNF_lblText:SetText(SMARTBUFF_WHATSNEW);
    -- Force show the changelog frame after a brief delay to ensure options frame is positioned
    C_Timer.After(0.1, function()
      SmartBuffWNF:Show();
    end);
  elseif (msg == "reload") then
    SMARTBUFF_BuffOrderReset();
    SMARTBUFF_OptionsFrame_Open(true);
  elseif (msg == "cache") then
    SMARTBUFF_PrintCacheStats(cBuffs);
  else
    --SMARTBUFF_Check(0);
    SMARTBUFF_AddMsg(SMARTBUFF_VERS_TITLE, true);
    SMARTBUFF_AddMsg("Syntax: /sbo [command] or /sbuff [command] or /smartbuff [command]", true);
    SMARTBUFF_AddMsg("toggle  -  " .. SMARTBUFF_OFT, true);
    SMARTBUFF_AddMsg("menu     -  " .. SMARTBUFF_OFT_MENU, true);
    SMARTBUFF_AddMsg("target  -  " .. SMARTBUFF_OFT_TARGET, true);
    SMARTBUFF_AddMsg("rbt      -  " .. "Reset buff timers", true);
    SMARTBUFF_AddMsg("sbt      -  " .. "Show buff timers", true);
    SMARTBUFF_AddMsg("rafp     -  " .. "Reset all frame positions", true);
    SMARTBUFF_AddMsg("sync     -  " .. "Sync buff timers with UI", true);
    SMARTBUFF_AddMsg("rb       -  " .. "Reset key/mouse bindings", true);
    SMARTBUFF_AddMsg("changes    -  " .. "Display changelog", true);
    SMARTBUFF_AddMsg("reload    -  " .. "Reset buff list", true);
  end
end

-- END SMARTBUFF_command


-- SmartBuff options toggle ---------------------------------------------------------------------------------------
function SMARTBUFF_OToggle()
  if (not isInit) then return; end
  O.Toggle = SMARTBUFF_toggleBool(O.Toggle, "Active = ");
  SMARTBUFF_CheckMiniMapButton();
  if (O.Toggle) then
    SMARTBUFF_SetTemplate();
  end
end

function SMARTBUFF_OToggleAuto()
  O.ToggleAuto = not O.ToggleAuto;
end

function SMARTBUFF_OToggleAutoCombat()
  O.ToggleAutoCombat = not O.ToggleAutoCombat;
end

function SMARTBUFF_OToggleAutoChat()
  O.ToggleAutoChat = not O.ToggleAutoChat;
end

function SMARTBUFF_OToggleAutoSplash()
  O.ToggleAutoSplash = not O.ToggleAutoSplash;
end

function SMARTBUFF_OToggleAutoSound()
  O.ToggleAutoSound = not O.ToggleAutoSound;
end

--function SMARTBUFF_OToggleCheckCharges()
--  O.ToggleCheckCharges = not O.ToggleCheckCharges;
--end
--function SMARTBUFF_OToggleAutoRest()
--  O.ToggleAutoRest = not O.ToggleAutoRest;
--end

function SMARTBUFF_OAutoSwitchTmp()
  O.AutoSwitchTemplate = not O.AutoSwitchTemplate;
end

function SMARTBUFF_OAutoSwitchTmpInst()
  O.AutoSwitchTemplateInst = not O.AutoSwitchTemplateInst;
end

function SMARTBUFF_OBuffTarget()
  O.BuffTarget = not O.BuffTarget;
end

function SMARTBUFF_OBuffPvP()
  O.BuffPvP = not O.BuffPvP;
end

function SMARTBUFF_OBuffInCities()
  O.BuffInCities = not O.BuffInCities;
end

function SMARTBUFF_OLinkSelfBuffCheck()
  O.LinkSelfBuffCheck = not O.LinkSelfBuffCheck;
end

function SMARTBUFF_OLinkGrpBuffCheck()
  O.LinkGrpBuffCheck = not O.LinkGrpBuffCheck;
end

function SMARTBUFF_OScrollWheelUp()
  O.ScrollWheelUp = not O.ScrollWheelUp;
  isKeyUpChanged = true;
end

function SMARTBUFF_OScrollWheelDown()
  O.ScrollWheelDown = not O.ScrollWheelDown;
  isKeyDownChanged = true;
end

function SMARTBUFF_OInShapeshift()
  O.InShapeshift = not O.InShapeshift;
end

function SMARTBUFF_OInCombat()
  O.InCombat = not O.InCombat;
end

function SMARTBUFF_OIncludeToys()
  O.IncludeToys = not O.IncludeToys;
  SMARTBUFF_Options_OnShow();
  -- InitBuffOrder(false) is already called in SMARTBUFF_Options_OnShow(), no need to reset order
end

function SMARTBUFF_OToggleMsgNormal()
  O.ToggleMsgNormal = not O.ToggleMsgNormal;
end

function SMARTBUFF_OToggleMsgWarning()
  O.ToggleMsgWarning = not O.ToggleMsgWarning;
end

function SMARTBUFF_OToggleMsgError()
  O.ToggleMsgError = not O.ToggleMsgError;
end

function SMARTBUFF_OHideMmButton()
  O.HideMmButton = not O.HideMmButton;
  SMARTBUFF_CheckMiniMapButton();
end

function SMARTBUFF_OHideSAButton()
  O.HideSAButton = not O.HideSAButton;
  SMARTBUFF_ShowSAButton();
end

function SMARTBUFF_OSelfFirst()
  B[CS()][currentTemplate].SelfFirst = not B[CS()][currentTemplate].SelfFirst;
end

function SMARTBUFF_OToggleBuff(s, i)
  if (cBuffs[i] == nil) then
    return
  end
  local bs = GetBuffSettings(cBuffs[i].BuffS);
  if (bs == nil) then
    return;
  end

  if (s == "S") then
    bs.EnableS = not bs.EnableS;
    --SMARTBUFF_AddMsgD("OToggleBuff = "..cBuffs[i].BuffS..", "..tostring(bs.EnableS));
    if (bs.EnableS) then
      SmartBuff_BuffSetup_Show(i);
    else
      SmartBuff_BuffSetup:Hide();
      iLastBuffSetup = -1;
      SmartBuff_PlayerSetup:Hide();
    end
  elseif (s == "G") then
    bs.EnableG = not bs.EnableG;
  end
end

function SMARTBUFF_OToggleDebug()
  O.Debug = not O.Debug;
end

function SMARTBUFF_ToggleFixBuffing()
  O.SBButtonFix = not O.SBButtonFix;
  if not O.SBButtonFix and not InCombatLockdown() then
    pcall(C_CVar.SetCVar, "ActionButtonUseKeyDown", O.SBButtonDownVal);
  end
end

function SMARTBUFF_OptionsFrame_Toggle()
  if (not isInit) then return; end

  if (SmartBuffOptionsFrame:IsVisible()) then
    if (iLastBuffSetup > 0) then
      SmartBuff_BuffSetup:Hide();
      iLastBuffSetup = -1;
      SmartBuff_PlayerSetup:Hide();
    end
    SmartBuffOptionsFrame:Hide();
  else
    SmartBuffOptionsCredits_lblText:SetText(SMARTBUFF_CREDITS);
    SmartBuffOptionsFrame:Show();
    SmartBuff_PlayerSetup:Hide();
  end

  SMARTBUFF_MinimapButton_CheckPos();
end

function SMARTBUFF_OptionsFrame_Open(force)
  if (not isInit) then return; end
  if (not SmartBuffOptionsFrame:IsVisible() or force) then
    SmartBuffOptionsFrame:Show();
  end
end

function SMARTBUFF_OptionsFrame_Close(force)
  if (not isInit) then return; end
  if (SmartBuffOptionsFrame:IsVisible() or force) then
    SmartBuffOptionsFrame:Hide();
  end
end

function SmartBuff_BuffSetup_Show(i)
  local icon1 = cBuffs[i].IconS;
  local icon2 = cBuffs[i].IconG;
  local name = cBuffs[i].BuffS;
  local btype = cBuffs[i].Type;
  local hidden = true;
  local n = 0;
  local bs = GetBuffSettings(name);

  if (name == nil or btype == SMARTBUFF_CONST_TRACK) then
    SmartBuff_BuffSetup:Hide();
    iLastBuffSetup = -1;
    SmartBuff_PlayerSetup:Hide();
    return;
  end

  if (SmartBuff_BuffSetup:IsVisible() and i == iLastBuffSetup) then
    SmartBuff_BuffSetup:Hide();
    iLastBuffSetup = -1;
    SmartBuff_PlayerSetup:Hide();
    return;
  else
    if (btype == SMARTBUFF_CONST_GROUP or btype == SMARTBUFF_CONST_ITEMGROUP) then
      hidden = false;
    end

    if (icon2 and bs.EnableG) then
      SmartBuff_BuffSetup_BuffIcon2:SetNormalTexture(icon2);
      SmartBuff_BuffSetup_BuffIcon2:Show();
    else
      SmartBuff_BuffSetup_BuffIcon2:Hide();
    end
    if (icon1) then
      SmartBuff_BuffSetup_BuffIcon1:SetNormalTexture(icon1);
      if (icon2 and bs.EnableG) then
        SmartBuff_BuffSetup_BuffIcon1:SetPoint("TOPLEFT", 44, -30);
      else
        SmartBuff_BuffSetup_BuffIcon1:SetPoint("TOPLEFT", 64, -30);
      end
      SmartBuff_BuffSetup_BuffIcon1:Show();
    else
      SmartBuff_BuffSetup_BuffIcon1:SetPoint("TOPLEFT", 24, -30);
      SmartBuff_BuffSetup_BuffIcon1:Hide();
    end

    local obj = SmartBuff_BuffSetup_BuffText;
    if (name) then
      obj:SetText(GetBuffDisplayName(name, btype));
      --SMARTBUFF_AddMsgD(name);
    else
      obj:SetText("");
    end

    SmartBuff_BuffSetup_cbSelf:SetChecked(bs.SelfOnly);
    SmartBuff_BuffSetup_cbSelfNot:SetChecked(bs.SelfNot);
    SmartBuff_BuffSetup_cbCombatIn:SetChecked(bs.CIn);
    SmartBuff_BuffSetup_cbCombatOut:SetChecked(bs.COut);
    SmartBuff_BuffSetup_cbMH:SetChecked(bs.MH);
    SmartBuff_BuffSetup_cbOH:SetChecked(bs.OH);
    SmartBuff_BuffSetup_cbRH:SetChecked(bs.RH);
    SmartBuff_BuffSetup_cbReminder:SetChecked(bs.Reminder);
    SmartBuff_BuffSetup_txtManaLimit:SetNumber(bs.ManaLimit);

    --SMARTBUFF_AddMsgD("Test Buff setup show 1");
    if (cBuffs[i].DurationS > 0) then
      SmartBuff_BuffSetup_RBTime:SetMinMaxValues(0, cBuffs[i].DurationS);
      _G[SmartBuff_BuffSetup_RBTime:GetName() .. "High"]:SetText(cBuffs[i].DurationS);
      if (cBuffs[i].DurationS <= 60) then
        SmartBuff_BuffSetup_RBTime:SetValueStep(1);
      elseif (cBuffs[i].DurationS <= 180) then
        SmartBuff_BuffSetup_RBTime:SetValueStep(5);
      elseif (cBuffs[i].DurationS <= 600) then
        SmartBuff_BuffSetup_RBTime:SetValueStep(10);
      else
        SmartBuff_BuffSetup_RBTime:SetValueStep(30);
      end
      SmartBuff_BuffSetup_RBTime:SetValue(bs.RBTime);
      _G[SmartBuff_BuffSetup_RBTime:GetName() .. "Text"]:SetText(bs.RBTime .. "\nsec");
      SmartBuff_BuffSetup_RBTime:Show();
    else
      SmartBuff_BuffSetup_RBTime:Hide();
    end
    --SMARTBUFF_AddMsgD("Test Buff setup show 2");

    SmartBuff_BuffSetup_txtManaLimit:Hide();
    if (cBuffs[i].Type == SMARTBUFF_CONST_INV or cBuffs[i].Type == SMARTBUFF_CONST_WEAPON) then
      SmartBuff_BuffSetup_cbMH:Show();
      SmartBuff_BuffSetup_cbOH:Show();
      SmartBuff_BuffSetup_cbRH:Hide();
    else
      SmartBuff_BuffSetup_cbMH:Hide();
      SmartBuff_BuffSetup_cbOH:Hide();
      SmartBuff_BuffSetup_cbRH:Hide();
      if (cBuffs[i].Type ~= SMARTBUFF_CONST_FOOD and cBuffs[i].Type ~= SMARTBUFF_CONST_SCROLL and cBuffs[i].Type ~= SMARTBUFF_CONST_POTION) then
        SmartBuff_BuffSetup_txtManaLimit:Show();
        --SMARTBUFF_AddMsgD("Show ManaLimit");
      end
    end

    if (cBuffs[i].Type == SMARTBUFF_CONST_GROUP or cBuffs[i].Type == SMARTBUFF_CONST_ITEMGROUP) then
      SmartBuff_BuffSetup_cbSelf:Show();
      SmartBuff_BuffSetup_cbSelfNot:Show();
      SmartBuff_BuffSetup_btnPriorityList:Show();
      SmartBuff_BuffSetup_btnIgnoreList:Show();
    else
      SmartBuff_BuffSetup_cbSelf:Hide();
      SmartBuff_BuffSetup_cbSelfNot:Hide();
      SmartBuff_BuffSetup_btnPriorityList:Hide();
      SmartBuff_BuffSetup_btnIgnoreList:Hide();
      SmartBuff_PlayerSetup:Hide();
    end

    local cb = nil;
    local btn = nil;
    n = 0;
    --SMARTBUFF_AddMsgD("Test Buff setup show 3");
    for _ in pairs(cClasses) do
      n = n + 1;
      cb = _G["SmartBuff_BuffSetup_cbClass" .. n];
      btn = _G["SmartBuff_BuffSetup_ClassIcon" .. n];
      if (hidden) then
        cb:Hide();
        btn:Hide();
      else
        cb:SetChecked(bs[cClasses[n]]);
        cb:Show();
        btn:Show();
      end
    end
    iLastBuffSetup = i;
    --SMARTBUFF_AddMsgD("Test Buff setup show 4");
    SmartBuff_BuffSetup:Show();

    if (SmartBuff_PlayerSetup:IsVisible()) then
      SmartBuff_PS_Show(iCurrentList);
    end
  end
end

function SmartBuff_BuffSetup_ManaLimitChanged(self)
  local i = iLastBuffSetup;
  if (i <= 0) then
    return;
  end
  local name = cBuffs[i].BuffS;
  local cBuff = GetBuffSettings(name);
  if (cBuff) then
    cBuff.ManaLimit = self:GetNumber();
  end
end

function SmartBuff_BuffSetup_OnClick()
  local i = iLastBuffSetup;
  local ct = currentTemplate;
  if (i <= 0) then
    return;
  end
  local name     = cBuffs[i].BuffS;
  local cBuff    = GetBuffSettings(name);

  cBuff.SelfOnly = SmartBuff_BuffSetup_cbSelf:GetChecked();
  cBuff.SelfNot  = SmartBuff_BuffSetup_cbSelfNot:GetChecked();
  cBuff.CIn      = SmartBuff_BuffSetup_cbCombatIn:GetChecked();
  cBuff.COut     = SmartBuff_BuffSetup_cbCombatOut:GetChecked();
  cBuff.MH       = SmartBuff_BuffSetup_cbMH:GetChecked();
  cBuff.OH       = SmartBuff_BuffSetup_cbOH:GetChecked();
  cBuff.RH       = SmartBuff_BuffSetup_cbRH:GetChecked();
  cBuff.Reminder = SmartBuff_BuffSetup_cbReminder:GetChecked();

  cBuff.RBTime   = SmartBuff_BuffSetup_RBTime:GetValue();
  _G[SmartBuff_BuffSetup_RBTime:GetName() .. "Text"]:SetText(cBuff.RBTime .. "\nsec");

  if (cBuffs[i].Type == SMARTBUFF_CONST_GROUP or cBuffs[i].Type == SMARTBUFF_CONST_ITEMGROUP) then
    local n = 0;
    local cb = nil;
    for _ in pairs(cClasses) do
      n = n + 1;
      cb = _G["SmartBuff_BuffSetup_cbClass" .. n];
      cBuff[cClasses[n]] = cb:GetChecked();
    end
  end
  --SMARTBUFF_AddMsgD("Buff setup saved");
end

function SmartBuff_BuffSetup_ToolTip(mode)
  local i = iLastBuffSetup;
  if (i <= 0) then
    return;
  end
  local ids = cBuffs[i].IDS;
  local idg = cBuffs[i].IDG;
  local btype = cBuffs[i].Type

  GameTooltip:ClearLines();
  if (SMARTBUFF_IsItem(btype)) then
    local bag, slot, count, texture = SMARTBUFF_FindItem(cBuffs[i].BuffS, cBuffs[i].Chain);
    if (bag and slot) then
      if (bag == 999) then -- Toy
        GameTooltip:SetToyByItemID(slot);
      else
        GameTooltip:SetBagItem(bag, slot);
      end
    end
  else
    if (mode == 1 and ids) then
      local link = C_Spell.GetSpellLink(ids);
      if (link) then GameTooltip:SetHyperlink(link); end
    elseif (mode == 2 and idg) then
      local link = C_Spell.GetSpellLink(idg);
      if (link) then GameTooltip:SetHyperlink(link); end
    end
  end
  GameTooltip:Show();
end

-- END SmartBuff options toggle


-- Options frame functions ---------------------------------------------------------------------------------------
function SMARTBUFF_Options_OnLoad(self)
end

function SMARTBUFF_Options_OnShow()
  -- Check if the options frame is out of screen area
  local top    = GetScreenHeight() - math.abs(SmartBuffOptionsFrame:GetTop());
  local bottom = GetScreenHeight() - math.abs(SmartBuffOptionsFrame:GetBottom());
  local left   = SmartBuffOptionsFrame:GetLeft();
  local right  = SmartBuffOptionsFrame:GetRight();

  --SMARTBUFF_AddMsgD("X: " .. GetScreenWidth() .. ", " .. left .. ", " .. right);
  --SMARTBUFF_AddMsgD("Y: " .. GetScreenHeight() .. ", " .. top .. ", " .. bottom);

  if (GetScreenWidth() < left + 20 or GetScreenHeight() < top + 20 or right < 20 or bottom < 20) then
    SmartBuffOptionsFrame:SetPoint("TOPLEFT", UIParent, "CENTER", -SmartBuffOptionsFrame:GetWidth() / 2,
      SmartBuffOptionsFrame:GetHeight() / 2);
  end

  SmartBuff_ShowControls("SmartBuffOptionsFrame", true);

  -- Clean up buff order (remove invalid, add missing) without resetting custom order
  InitBuffOrder(false);

  SmartBuffOptionsFrame_cbSB:SetChecked(O.Toggle);
  SmartBuffOptionsFrame_cbAuto:SetChecked(O.ToggleAuto);
  SmartBuffOptionsFrameAutoTimer:SetValue(O.AutoTimer);
  SmartBuff_SetSliderText(SmartBuffOptionsFrameAutoTimer, SMARTBUFF_OFT_AUTOTIMER, O.AutoTimer, INT_SPELL_DURATION_SEC);
  SmartBuffOptionsFrame_cbAutoCombat:SetChecked(O.ToggleAutoCombat);
  SmartBuffOptionsFrame_cbAutoChat:SetChecked(O.ToggleAutoChat);
  SmartBuffOptionsFrame_cbAutoSplash:SetChecked(O.ToggleAutoSplash);
  SmartBuffOptionsFrame_cbAutoSound:SetChecked(O.ToggleAutoSound);

  --SmartBuffOptionsFrame_cbCheckCharges:SetChecked(O.ToggleCheckCharges);
  --SmartBuffOptionsFrame_cbAutoRest:SetChecked(O.ToggleAutoRest);
  SmartBuffOptionsFrame_cbAutoSwitchTmp:SetChecked(O.AutoSwitchTemplate);
  SmartBuffOptionsFrame_cbAutoSwitchTmpInst:SetChecked(O.AutoSwitchTemplateInst);
  SmartBuffOptionsFrame_cbBuffPvP:SetChecked(O.BuffPvP);
  SmartBuffOptionsFrame_cbBuffTarget:SetChecked(O.BuffTarget);
  SmartBuffOptionsFrame_cbBuffInCities:SetChecked(O.BuffInCities);
  SmartBuffOptionsFrame_cbInShapeshift:SetChecked(O.InShapeshift);
  SmartBuffOptionsFrame_cbFixBuffIssue:SetChecked(O.SBButtonFix);

  SmartBuffOptionsFrame_cbLinkGrpBuffCheck:SetChecked(O.LinkGrpBuffCheck);
  SmartBuffOptionsFrame_cbLinkSelfBuffCheck:SetChecked(O.LinkSelfBuffCheck);

  SmartBuffOptionsFrame_cbScrollWheelUp:SetChecked(O.ScrollWheelUp);
  SmartBuffOptionsFrame_cbScrollWheelDown:SetChecked(O.ScrollWheelDown);
  SmartBuffOptionsFrame_cbInCombat:SetChecked(O.InCombat);
  SmartBuffOptionsFrame_cbIncludeToys:SetChecked(O.IncludeToys);
  SmartBuffOptionsFrame_cbMsgNormal:SetChecked(O.ToggleMsgNormal);
  SmartBuffOptionsFrame_cbMsgWarning:SetChecked(O.ToggleMsgWarning);
  SmartBuffOptionsFrame_cbMsgError:SetChecked(O.ToggleMsgError);
  SmartBuffOptionsFrame_cbHideMmButton:SetChecked(O.HideMmButton);
  SmartBuffOptionsFrame_cbHideSAButton:SetChecked(O.HideSAButton);

  SmartBuffOptionsFrameRebuffTimer:SetValue(O.RebuffTimer);
  SmartBuff_SetSliderText(SmartBuffOptionsFrameRebuffTimer, SMARTBUFF_OFT_REBUFFTIMER, O.RebuffTimer,
    INT_SPELL_DURATION_SEC);
  SmartBuffOptionsFrameBLDuration:SetValue(O.BlacklistTimer);
  SmartBuff_SetSliderText(SmartBuffOptionsFrameBLDuration, SMARTBUFF_OFT_BLDURATION, O.BlacklistTimer,
    INT_SPELL_DURATION_SEC);

  SMARTBUFF_SetCheckButtonBuffs(0);

  SmartBuffOptionsFrame_cbSelfFirst:SetChecked(B[CS()][currentTemplate].SelfFirst);

  SMARTBUFF_Splash_Show();

  SMARTBUFF_AddMsgD("Option frame updated: " .. currentTemplate);
end

function SMARTBUFF_ShowSubGroups(frame, grpTable)
  local i;
  for i = 1, 8, 1 do
    obj = _G[frame .. "_cbGrp" .. i];
    if (obj) then
      obj:SetChecked(grpTable[i]);
    end
  end
end

function SMARTBUFF_Options_OnHide()
  if (SmartBuffWNF:IsVisible()) then
    SmartBuffWNF:Hide();
  end
  SMARTBUFF_ToggleTutorial(true);
  SmartBuffOptionsFrame:SetHeight(SMARTBUFF_OPTIONSFRAME_HEIGHT);
  --SmartBuff_BuffSetup:SetHeight(SMARTBUFF_OPTIONSFRAME_HEIGHT);
  wipe(cBuffsCombat);
  SMARTBUFF_SetInCombatBuffs();
  SmartBuff_BuffSetup:Hide();
  SmartBuff_PlayerSetup:Hide();
  SMARTBUFF_Splash_Hide();
  SMARTBUFF_RebindKeys();
  --collectgarbage();
end

function SmartBuff_ShowControls(sName, bShow)
  local children = { _G[sName]:GetChildren() };
  for i, child in pairs(children) do
    --SMARTBUFF_AddMsgD(i .. ": " .. child:GetName());
    if (i > 1 and string.find(child:GetName(), "^" .. sName .. ".+")) then
      if (bShow) then
        child:Show();
      else
        child:Hide();
      end
    end
  end
end

function SmartBuffOptionsFrameSlider_OnLoad(self, low, high, step, labels)
  _G[self:GetName() .. "Text"]:SetFontObject(GameFontNormalSmall);
  if (labels) then
    if (self:GetOrientation() ~= "VERTICAL") then
      _G[self:GetName() .. "Low"]:SetText(low);
    else
      _G[self:GetName() .. "Low"]:SetText("");
    end
    _G[self:GetName() .. "High"]:SetText(high);
  else
    _G[self:GetName() .. "Low"]:SetText("");
    _G[self:GetName() .. "High"]:SetText("");
  end
  self:SetMinMaxValues(low, high);
  self:SetValueStep(step);
  self:SetStepsPerPage(step);

  if (step < 1) then return; end

  self.GetValueBase = self.GetValue;
  self.GetValue = function()
    local n = self:GetValueBase();
    if (n) then
      local r = Round(n);
      if (r ~= n) then
        self:SetValue(n);
      end
      return r;
    end
    return low;
  end;
end

function SmartBuff_SetSliderText(self, text, value, valformat, setval)
  if (not self or not value) then return end
  local s;
  if (setval) then self:SetValue(value) end
  if (valformat) then
    s = string.format(valformat, value);
  else
    s = tostring(value);
  end
  _G[self:GetName() .. "Text"]:SetText(text .. " " .. WH .. s .. "|r");
end

function SmartBuff_BuffSetup_RBTime_OnValueChanged(self)
  _G[SmartBuff_BuffSetup_RBTime:GetName() .. "Text"]:SetText(WH .. format("%.0f", self:GetValue()) .. "\nsec|r");
end

function SMARTBUFF_SetCheckButtonBuffs(mode)
  local objS;
  local objG;
  local i = 1;
  local ct = currentTemplate;

  if (mode == 0) then
    SMARTBUFF_SetBuffs();
  end

  if (sPlayerClass == "DRUID" or sPlayerClass == "SHAMAN") then
    SmartBuffOptionsFrame_cbInShapeshift:Show();
  else
    SmartBuffOptionsFrame_cbInShapeshift:Hide();
  end

  SMARTBUFF_BuffOrderOnScroll();
end

function SMARTBUFF_DropDownTemplate_OnShow(self)
  local i = 0;
  for _, tmp in pairs(SMARTBUFF_TEMPLATES) do
    i = i + 1;
    --SMARTBUFF_AddMsgD(i .. "." .. tmp);
    if (tmp == currentTemplate) then
      break;
    end
  end
  UIDropDownMenu_Initialize(self, SMARTBUFF_DropDownTemplate_Initialize);
  UIDropDownMenu_SetSelectedValue(SmartBuffOptionsFrame_ddTemplates, i);
  UIDropDownMenu_SetWidth(SmartBuffOptionsFrame_ddTemplates, 135);
end

function SMARTBUFF_DropDownTemplate_Initialize()
  local info = UIDropDownMenu_CreateInfo();
  info.text = ALL;
  info.value = -1;
  info.func = SMARTBUFF_DropDownTemplate_OnClick;
  for k, v in pairs(SMARTBUFF_TEMPLATES) do
    info.text = SMARTBUFF_TEMPLATES[k];
    info.value = k;
    info.func = SMARTBUFF_DropDownTemplate_OnClick;
    info.checked = nil;
    UIDropDownMenu_AddButton(info);
  end
end

function SMARTBUFF_DropDownTemplate_OnClick(self)
  local i = self.value;
  local tmp = nil;
  UIDropDownMenu_SetSelectedValue(SmartBuffOptionsFrame_ddTemplates, i);
  tmp = SMARTBUFF_TEMPLATES[i];
  --SMARTBUFF_AddMsgD("Selected/Current Buff-Template: " .. tmp .. "/" .. currentTemplate);
  SMARTBUFF_SetBuffs()
  if (currentTemplate ~= tmp) then
    SmartBuff_BuffSetup:Hide();
    iLastBuffSetup = -1;
    SmartBuff_PlayerSetup:Hide();

    currentTemplate = tmp;
    SMARTBUFF_Options_OnShow();
    O.LastTemplate = currentTemplate;
  end
end

-- END Options frame functions


-- Splash screen functions ---------------------------------------------------------------------------------------
function SMARTBUFF_Splash_Show()
  if (not isInit) then return; end
  SMARTBUFF_Splash_ChangeFont(1);
  SmartBuffSplashFrame:EnableMouse(true);
  SmartBuffSplashFrame:Show();
  SmartBuffSplashFrame:SetTimeVisible(60);
  SmartBuffSplashFrameOptions:Show();
end

function SMARTBUFF_Splash_Hide()
  if (not isInit) then return; end
  SMARTBUFF_Splash_Clear();
  SMARTBUFF_Splash_ChangePos();
  SmartBuffSplashFrame:EnableMouse(false);
  SmartBuffSplashFrame:SetFadeDuration(O.SplashDuration);
  SmartBuffSplashFrame:SetTimeVisible(O.SplashDuration);
  SmartBuffSplashFrameOptions:Hide();
end

function SMARTBUFF_Splash_Clear()
  SmartBuffSplashFrame:Clear();
end

function SMARTBUFF_Splash_ChangePos()
  local x, y = SmartBuffSplashFrame:GetLeft(), SmartBuffSplashFrame:GetTop() - UIParent:GetHeight();
  if (O) then
    O.SplashX = x;
    O.SplashY = y;
  end
end

function SMARTBUFF_Splash_ChangeFont(mode)
  local f = SmartBuffSplashFrame;

  if (mode > 1) then
    SMARTBUFF_Splash_ChangePos();
    iCurrentFont = iCurrentFont + 1;
  end
  if (not cFonts[iCurrentFont]) then
    iCurrentFont = 1;
  end
  O.CurrentFont = iCurrentFont;
  f:ClearAllPoints();
  f:SetPoint("TOPLEFT", O.SplashX, O.SplashY);

  local fo = f:GetFontObject();
  local fName, fHeight, fFlags = _G[cFonts[iCurrentFont]]:GetFont();
  if (mode > 1 or O.CurrentFontSize == nil) then
    O.CurrentFontSize = fHeight;
  end
  fo:SetFont(fName, O.CurrentFontSize, fFlags);
  SmartBuffSplashFrameOptions.size:SetValue(O.CurrentFontSize);

  f:SetInsertMode("TOP");
  f:SetJustifyV("MIDDLE");
  if (mode > 0) then
    local si = "";
    if (OG.SplashIcon) then
      local n = O.SplashIconSize;
      if (n == nil or n <= 0) then
        n = O.CurrentFontSize;
      end
      si = string.format(" \124T%s:%d:%d:1:0\124t", "Interface\\Icons\\INV_Misc_QuestionMark", n, n) or "";
    else
      si = " BuffXYZ";
    end
    SMARTBUFF_Splash_Clear();
    if (OG.SplashMsgShort) then
      f:AddMessage(cFonts[iCurrentFont] .. " >" .. si .. "\ndrag'n'drop to move", O.ColSplashFont.r, O.ColSplashFont.g,
        O.ColSplashFont.b, 1.0);
    else
      f:AddMessage(cFonts[iCurrentFont] .. " " .. SMARTBUFF_MSG_NEEDS .. si .. "\ndrag'n'drop to move", O.ColSplashFont
      .r, O.ColSplashFont.g, O.ColSplashFont.b, 1.0);
    end
  end
end

-- END Splash screen events


-- Playerlist functions ---------------------------------------------------------------------------------------
function SmartBuff_PlayerSetup_OnShow()
end

function SmartBuff_PlayerSetup_OnHide()
end

function SmartBuff_PS_GetList()
  if (iLastBuffSetup <= 0) then return {} end

  local name = cBuffs[iLastBuffSetup].BuffS;
  if (name) then
    local cBuff = GetBuffSettings(name);
    if (cBuff) then
      if (iCurrentList == 1) then
        return cBuff.AddList or {};
      else
        return cBuff.IgnoreList or {};
      end
    end
  end
  return {};
end

function SmartBuff_PS_GetUnitList()
  if (iCurrentList == 1) then
    return cAddUnitList;
  else
    return cIgnoreUnitList;
  end
end

function SmartBuff_UnitIsAdd(unit)
  if (unit and cAddUnitList[unit]) then return true end
  return false;
end

function SmartBuff_UnitIsIgnored(unit)
  if (unit and cIgnoreUnitList[unit]) then return true end
  return false;
end

function SmartBuff_PS_Show(i)
  iCurrentList = i;
  iLastPlayer = -1;
  local obj = SmartBuff_PlayerSetup_Title;
  if (iCurrentList == 1) then
    obj:SetText("Additional list");
  else
    obj:SetText("Ignore list");
  end
  obj:ClearFocus();
  SmartBuff_PlayerSetup_EditBox:ClearFocus();
  SmartBuff_PlayerSetup:Show();
  SmartBuff_PS_SelectPlayer(0);
end

function SmartBuff_PS_AddPlayer()
  local cList = SmartBuff_PS_GetList();
  local un = UnitName("target");
  if (un and UnitIsPlayer("target") and (UnitInRaid("target") or UnitInParty("target") or O.Debug)) then
    if (not cList[un]) then
      cList[un] = true;
      SmartBuff_PS_SelectPlayer(0);
    end
  end
end

function SmartBuff_PS_RemovePlayer()
  local n = 0;
  local cList = SmartBuff_PS_GetList();
  for player in pairs(cList) do
    n = n + 1;
    if (n == iLastPlayer) then
      cList[player] = nil;
      break;
    end
  end
  SmartBuff_PS_SelectPlayer(0);
end

function SmartBuff_AddToUnitList(idx, unit, subgroup)
  iCurrentList = idx;
  local cList = SmartBuff_PS_GetList();
  local cUnitList = SmartBuff_PS_GetUnitList();
  if (unit and subgroup) then
    local un = UnitName(unit);
    if (un and cList[un]) then
      cUnitList[unit] = subgroup;
      --SMARTBUFF_AddMsgD("Added to UnitList:" .. un .. "(" .. unit .. ")");
    end
  end
end

function SmartBuff_PS_SelectPlayer(iOp)
  local idx = iLastPlayer + iOp;
  local cList = SmartBuff_PS_GetList();
  local s = "";

  local tn = 0;
  for player in pairs(cList) do
    tn = tn + 1;
    s = s .. player .. "\n";
  end

  -- update list in textbox
  if (iOp == 0) then
    SmartBuff_PlayerSetup_EditBox:SetText(s);
    --SmartBuff_PlayerSetup_EditBox:ClearFocus();
  end

  -- highlight selected player
  if (tn > 0) then
    if (idx > tn) then idx = tn; end
    if (idx < 1) then idx = 1; end
    iLastPlayer = idx;
    --SmartBuff_PlayerSetup_EditBox:ClearFocus();
    local n = 0;
    local i = 0;
    local w = 0;
    for player in pairs(cList) do
      n = n + 1;
      w = string.len(player);
      if (n == idx) then
        SmartBuff_PlayerSetup_EditBox:HighlightText(i + n - 1, i + n + w);
        break;
      end
      i = i + w;
    end
  end
end

function SmartBuff_PS_Resize()
  local h = SmartBuffOptionsFrame:GetHeight();
  local b = true;

  if (h < 200) then
    SmartBuffOptionsFrame:SetHeight(SMARTBUFF_OPTIONSFRAME_HEIGHT);
    --SmartBuff_BuffSetup:SetHeight(SMARTBUFF_OPTIONSFRAME_HEIGHT);
    b = true;
  else
    SmartBuffOptionsFrame:SetHeight(40);
    --SmartBuff_BuffSetup:SetHeight(40);
    b = false;
  end
  SmartBuff_ShowControls("SmartBuffOptionsFrame", b);
  if (b) then
    SMARTBUFF_SetCheckButtonBuffs(1);
  end
end

-- END Playerlist functions


-- Secure button functions, NEW TBC ---------------------------------------------------------------------------------------

function SMARTBUFF_ShowSAButton()
  if (not InCombatLockdown()) then
    if (O.HideSAButton) then
      SmartBuff_KeyButton:Hide();
    else
      SmartBuff_KeyButton:Show();
    end
  end
end

local sScript;
function SMARTBUFF_OnClick(obj)
  --    print("SMARTBUFF_OnClick: CVAL is "..C_CVar.GetCVar("ActionButtonUseKeyDown"));
end

local lastBuffType = "";
function SMARTBUFF_OnPreClick(self, button, down)
  if (not isInit) then return end
  local mode = 0;
  if (button) then
    if (button == "MOUSEWHEELUP" or button == "MOUSEWHEELDOWN") then
      mode = 5;
    end
  end

  local td;
  if (lastBuffType == "") then
    td = 0.8;
  else
    td = GlobalCd;
  end
  -- If we requested a cast but never got SUCCEEDED/FAILED (cast never went off), expire cooldown
  -- so scroll can retry. Do not expire while player is casting (e.g. long pet summon).
  -- Safe if combat interrupts (FAILED fires) or cast started then combat (SUCCEEDED/FAILED when done).
  local isCasting = false;
  do
    local ok, name = pcall(UnitCastingInfo, "player");
    if ok and name then isCasting = true; end
  end
  if ((currentUnit or currentSpell) and tCastRequested > 0 and (GetTime() - tCastRequested) > 2 and not isCasting) then
    tAutoBuff = GetTime() - td - 0.1;
    currentUnit = nil;
    currentSpell = nil;
    tCastRequested = 0;
  end

  if (not InCombatLockdown()) then
    self:SetAttribute("type", nil);
    self:SetAttribute("unit", nil);
    self:SetAttribute("spell", nil);
    self:SetAttribute("item", nil);
    self:SetAttribute("macrotext", nil);
    self:SetAttribute("target-slot", nil);
    self:SetAttribute("target-item", nil);
    self:SetAttribute("action", nil);
  end

  --sScript = self:GetScript("OnClick");
  --self:SetScript("OnClick", SMARTBUFF_OnClick);

  -- Macros don't like ActionButtonUseKeyDown=1. Use 0 for click, 1 for scroll
  -- so both work. Skip in combat (SetCVar is protected).
  if O.SBButtonFix and not InCombatLockdown() then
    local isClick = (button == "LeftButton" or button == "RightButton");
    local val = isClick and 0 or 1;
    pcall(C_CVar.SetCVar, "ActionButtonUseKeyDown", val);
  end

  --SMARTBUFF_AddMsgD("Last buff type: " .. lastBuffType .. ", set cd: " .. td);

  if (UnitCastingInfo("player")) then
    --print("Channeling...reset AutoBuff timer");
    tAutoBuff = GetTime() + 0.7;
    return;
  end

  if (GetTime() < (tAutoBuff + td)) then return end

  --SMARTBUFF_AddMsgD("next buff check");
  tAutoBuff = GetTime();
  lastBuffType = "";
  currentUnit = nil;
  currentSpell = nil;
  tCastRequested = 0;

  if (not InCombatLockdown()) then
    local ret, actionType, spellName, slot, unit, buffType = SMARTBUFF_Check(mode);
    if (ret and ret == 0 and actionType and spellName and unit) then
      lastBuffType = buffType;
      self:SetAttribute("type", actionType);
      self:SetAttribute("unit", unit);
      if (actionType == SMARTBUFF_ACTION_SPELL) then
        if (slot and slot > 0 and unit == "player") then
          self:SetAttribute("type", "macro");
          self:SetAttribute("macrotext", string.format("/use %s\n/use %i\n/click StaticPopup1Button1", spellName, slot));
          --self:SetAttribute("target-item", slot);
          SMARTBUFF_AddMsgD("Weapon buff " .. spellName .. ", " .. slot);
        else
          self:SetAttribute("spell", spellName);
        end

        if (cBuffIndex[spellName]) then
          currentUnit = unit;
          currentSpell = spellName;
          tCastRequested = GetTime();
        end
      elseif (actionType == SMARTBUFF_ACTION_ITEM and slot) then
        self:SetAttribute("item", spellName);
        if (slot > 0) then
          self:SetAttribute("type", "macro");
          self:SetAttribute("macrotext", string.format("/use %s\n/use %i\n/click StaticPopup1Button1", spellName, slot));
        end
      elseif (actionType == "action" and slot) then
        self:SetAttribute("action", slot);
      else
        SMARTBUFF_AddMsgD("Preclick: not supported actiontype -> " .. actionType);
      end

      --isClearSplash = true;
      tLastCheck = GetTime() - O.AutoTimer + GlobalCd;
    end
  end
end

function SMARTBUFF_OnPostClick(self, button, down)
  if (not isInit) then return end
  if (button) then
    if (button == "MOUSEWHEELUP") then
      CameraZoomIn(1);
    elseif (button == "MOUSEWHEELDOWN") then
      CameraZoomOut(1);
    end
  end

  if (InCombatLockdown()) then
    return
  end

  self:SetAttribute("type", nil);
  self:SetAttribute("unit", nil);
  self:SetAttribute("spell", nil);
  self:SetAttribute("item", nil);
  self:SetAttribute("target-slot", nil);
  self:SetAttribute("target-item", nil);
  self:SetAttribute("macrotext", nil);
  self:SetAttribute("action", nil);

  SMARTBUFF_SetButtonTexture(SmartBuff_KeyButton, imgSB);

  -- Ensure we reset the cvar back to the original player's setting.
  if O.SBButtonFix then
    pcall(C_CVar.SetCVar, "ActionButtonUseKeyDown", O.SBButtonDownVal);
  end

  --SMARTBUFF_AddMsgD("Button reseted, " .. button);
  --self:SetScript("OnClick", sScript);
end

function SMARTBUFF_SetButtonTexture(button, texture, text)
  --if (InCombatLockdown()) then return; end

  if (button and texture and texture ~= sLastTexture) then
    sLastTexture = texture;
    button:SetNormalTexture(texture);
    --SMARTBUFF_AddMsgD("Button slot texture set -> " .. texture);
    if (text) then
      --button.title:SetText(spell);
    end
  end
end

-- END secure button functions


-- Minimap button functions ---------------------------------------------------------------------------------------
-- Sets the correct icon on the minimap button
function SMARTBUFF_CheckMiniMapButton()
  if (O.Toggle) then
    SmartBuff_MiniMapButton:SetNormalTexture(imgIconOn);
  else
    SmartBuff_MiniMapButton:SetNormalTexture(imgIconOff);
  end

  if (O.HideMmButton) then
    SmartBuff_MiniMapButton:Hide();
  else
    SmartBuff_MiniMapButton:Show();
  end

  -- Update the Titan Panel icon
  if (TitanPanelBarButton and TitanPanelSmartBuffButton_SetIcon ~= nil) then
    TitanPanelSmartBuffButton_SetIcon();
  end

  -- Update the FuBar icon
  if (C_AddOns.IsAddOnLoaded("FuBar") and C_AddOns.IsAddOnLoaded("FuBar_SmartBuffFu") and SMARTBUFF_Fu_SetIcon ~= nil) then
    SMARTBUFF_Fu_SetIcon();
  end

  -- Update the Broker icon
  SMARTBUFF_BROKER_SetIcon();
end

function SMARTBUFF_MinimapButton_CheckPos()
  if (not isInit or not SmartBuff_MiniMapButton) then return; end
  local x = SmartBuff_MiniMapButton:GetLeft();
  local y = SmartBuff_MiniMapButton:GetTop();
  if (x == nil or y == nil) then return; end
  x = x - Minimap:GetLeft();
  y = y - Minimap:GetTop();
  if (math.abs(x) < 180 and math.abs(y) < 180) then
    O.MMCPosX = x;
    O.MMCPosY = y;
    --SMARTBUFF_AddMsgD("x = " .. O.MMCPosX .. ", y = " .. O.MMCPosY);
  end
end

-- Function to move the minimap button arround the minimap
function SMARTBUFF_MinimapButton_OnUpdate(self, move)
  if (not isInit or self == nil or not self:IsVisible()) then
    return;
  end

  local xpos, ypos;
  self:ClearAllPoints()
  if (move or O.MMCPosX == nil) then
    local pos, r
    local xmin, ymin = Minimap:GetLeft(), Minimap:GetBottom();
    xpos, ypos       = GetCursorPosition();
    xpos             = xmin - xpos / Minimap:GetEffectiveScale() + 70;
    ypos             = ypos / Minimap:GetEffectiveScale() - ymin - 70;
    pos              = math.deg(math.atan2(ypos, xpos));
    r                = math.sqrt(xpos * xpos + ypos * ypos);
    xpos             = 52 - r * cos(pos);
    ypos             = r * sin(pos) - 52;
    -- give a little more freedom around the minimap
    if xpos <= -34 then xpos = -34; end
    if xpos >= 174 then xpos = 174; end
    if ypos <= -195 then ypos = -195; end
    if ypos >= 35 then ypos = 35; end
    O.MMCPosX = xpos;
    O.MMCPosY = ypos;
  else
    xpos = O.MMCPosX;
    ypos = O.MMCPosY;
  end
  self:ClearAllPoints()
  self:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", xpos, ypos);
end

-- END Minimap button functions



-- Scroll frame functions ---------------------------------------------------------------------------------------

local ScrBtnSize = 20;
local ScrLineHeight = 18;
local function SetPosScrollButtons(parent, cBtn)
  local btn;
  local name;
  for i = 1, #cBtn, 1 do
    btn = cBtn[i];
    btn:ClearAllPoints();
    btn:SetPoint("TOPLEFT", parent, "TOPLEFT", 2, -2 - ScrLineHeight * (i - 1));
  end
end

local StartY, EndY;
local function CreateScrollButton(name, parent, cBtn, onClick, onDragStop)
  local btn = CreateFrame("CheckButton", name, parent, "UICheckButtonTemplate");
  btn:SetWidth(ScrBtnSize);
  btn:SetHeight(ScrBtnSize);
  --  btn:RegisterForClicks("LeftButtonUp");
  btn:SetScript("OnClick", onClick);
  --  btn:SetScript("OnMouseUp", onClick);

  if (onDragStop ~= nil) then
    btn:SetMovable(true);
    btn:RegisterForDrag("LeftButton");
    btn:SetScript("OnDragStart", function(self, b)
      StartY = self:GetTop();
      self:StartMoving();
    end
    );
    btn:SetScript("OnDragStop", function(self, b)
      EndY = self:GetTop();
      local i = tonumber(self:GetID()) + FauxScrollFrame_GetOffset(parent);
      local n = math.floor((StartY - EndY) / ScrLineHeight);
      self:StopMovingOrSizing();
      SetPosScrollButtons(parent, cBtn);
      onDragStop(i, n);
    end
    );
  end

  local text = btn:CreateFontString(nil, nil, "GameFontNormal");
  text:SetJustifyH("LEFT");
  --text:SetAllPoints(btn);
  text:SetPoint("TOPLEFT", btn, "TOPLEFT", ScrBtnSize, 0);
  text:SetWidth(parent:GetWidth() - ScrBtnSize);
  text:SetHeight(ScrBtnSize);
  btn:SetFontString(text);
  btn:SetHighlightFontObject("GameFontHighlight");

  local highlight = btn:CreateTexture();
  --highlight:SetAllPoints(btn);
  highlight:SetPoint("TOPLEFT", btn, "TOPLEFT", 0, -2);
  highlight:SetWidth(parent:GetWidth());
  highlight:SetHeight(ScrLineHeight - 3);

  highlight:SetTexture("Interface/QuestFrame/UI-QuestTitleHighlight");
  btn:SetHighlightTexture(highlight);

  return btn;
end


local function CreateScrollButtons(self, cBtn, sBtnName, onClick, onDragStop)
  local btn, i;
  for i = 1, maxScrollButtons, 1 do
    btn = CreateScrollButton(sBtnName .. i, self, cBtn, onClick, onDragStop);
    btn:SetID(i);
    cBtn[i] = btn;
  end
  SetPosScrollButtons(self, cBtn);
end


local function OnScroll(self, cData, sBtnName)
  local num = #cData;
  local n, numToDisplay;

  if (num <= maxScrollButtons) then
    numToDisplay = num - 1;
  else
    numToDisplay = maxScrollButtons;
  end

  FauxScrollFrame_Update(self, num, floor(numToDisplay / 3 + 0.5), ScrLineHeight);
  -- [B]ufflist for current spec, current template; use GetBuffSettings so item keys (link vs item:ID) resolve to same entry
  local t = B[CS()][CT()];
  for i = 1, maxScrollButtons, 1 do
    n = i + FauxScrollFrame_GetOffset(self);
    btn = _G[sBtnName .. i];
    if (btn) then
      if (n <= num and t ~= nil) then
        btn:SetNormalFontObject("GameFontNormalSmall");
        btn:SetHighlightFontObject("GameFontHighlightSmall");
        local idx = cBuffIndex[cData[n]];
        local btype = (idx and cBuffs[idx]) and cBuffs[idx].Type or nil;
        btn:SetText(GetBuffDisplayName(cData[n], btype));
        local bs = GetBuffSettings(cData[n]);
        if (bs) then
          btn:SetChecked(bs.EnableS);
        else
          btn:SetChecked(false);
        end
        btn:Show();
      else
        btn:Hide();
      end
    end
  end
end


function SMARTBUFF_BuffOrderOnScroll(self, arg1)
  if (not self) then
    self = SmartBuffOptionsFrame_ScrollFrameBuffs;
  end

  local name = "SMARTBUFF_BtnScrollBO";
  if (not cScrBtnBO and self) then
    cScrBtnBO = {};
    CreateScrollButtons(self, cScrBtnBO, name, SMARTBUFF_BuffOrderBtnOnClick, SMARTBUFF_BuffOrderBtnOnDragStop);
  end

  if not B[CS()] then B[CS()] = {} end
  if (B[CS()].Order == nil) then
    B[CS()].Order = {};
  end

  local t = {};
  for _, v in pairs(B[CS()].Order) do
    if (v) then
      tinsert(t, v);
    end
  end
  OnScroll(self, t, name);
end

function SMARTBUFF_BuffOrderBtnOnClick(self, button)
  local n = self:GetID() + FauxScrollFrame_GetOffset(self:GetParent());
  local i = cBuffIndex[B[CS()].Order[n]];
  --SMARTBUFF_AddMsgD("Buff OnClick = "..n..", "..button);
  if (button == "LeftButton") then
    SMARTBUFF_OToggleBuff("S", i);
  else
    SmartBuff_BuffSetup_Show(i);
  end
end

function SMARTBUFF_BuffOrderBtnOnDragStop(i, n)
  treorder(B[CS()].Order, i, n);
  SMARTBUFF_BuffOrderOnScroll();
end

-- Reset List: buff order/sorting only (B[].Order); no options or buff profiles.
function SMARTBUFF_BuffOrderReset()
  SMARTBUFF_InvalidateBuffCache();
  InitBuffOrder(true);
  SMARTBUFF_BuffOrderOnScroll();
end

-- Help plate functions ---------------------------------------------------------------------------------------

local HelpPlateList = {
  FramePos = { x = 20, y = -20 },
  FrameSize = { width = 480, height = 720 },
  [1] = { ButtonPos = { x = 344, y = -80 }, HighLightBox = { x = 260, y = -50, width = 204, height = 410 }, ToolTipDir = "DOWN", ToolTipText = "Spell list\nDrag'n'Drop to change the priority order" },
  [2] = { ButtonPos = { x = 105, y = -110 }, HighLightBox = { x = 10, y = -30, width = 230, height = 125 }, ToolTipDir = "DOWN", ToolTipText = "Buff reminder options" },
  [3] = { ButtonPos = { x = 105, y = -250 }, HighLightBox = { x = 10, y = -165, width = 230, height = 135 }, ToolTipDir = "DOWN", ToolTipText = "Character based options" },
  [4] = { ButtonPos = { x = 200, y = -320 }, HighLightBox = { x = 10, y = -300, width = 230, height = 90 }, ToolTipDir = "RIGHT", ToolTipText = "Additional UI options" },
  [5] = { ButtonPos = { x = 192, y = -630 }, HighLightBox = { x = 5, y = -635, width = 374, height = 33 }, ToolTipDir = "UP", ToolTipText = "Reset buttons\n\nReset BT: Clear buff timers only\nReset All: Wipe everything (profiles + options)\nReset Buffs: Resets buffs and profiles to defaults\nReset List: Reset buff order only" },
}

function SMARTBUFF_ToggleTutorial(close)
  local helpPlate = HelpPlateList;
  if (not helpPlate) then return end;

  local b = HelpPlate.IsShowingHelpInfo(helpPlate);
  if (close) then
    HelpPlate.Hide(false);
    return;
  end

  if (not b) then
    HelpPlate.Show(helpPlate, SmartBuffOptionsFrame, SmartBuffOptionsFrame_TutorialButton, true);
  else
    HelpPlate.Hide(true);
  end
end
