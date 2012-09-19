-- This was going to be a full fledged OOP library, but due to some limitations
-- and due to a lack of time, I decided against it. Right now it does the following:
-- * Provides wrapper tables to allow RR to function without name clashes
-- * Provides debugging functions.

local addonName, addonTable = ...;


if(WoW_Sandbox == nil) then
WoW_Sandbox = true;

-- Load databases
addonTable.ReagentRestockerDB=ReagentRestockerDB
addonTable.RRGlobal=RRGlobal

-- Import packages
--addonTable.packages = packages;

-- For some reason, many basic Lua functions are lost when loading a new
-- environment.
addonTable.pairs = pairs;
addonTable.print = print;
addonTable.table = table;

addonTable.tinsert = tinsert;
addonTable.tremove = tremove;

addonTable.type = type;
addonTable.tostring = tostring;
addonTable.string = string;
addonTable.loadBlizzard = loadBlizzard;
addonTable.error = error;
addonTable.GameTooltip = GameTooltip;
addonTable.GetAddOnMetadata=GetAddOnMetadata;
addonTable.getPlayerBagIDList=getPlayerBagIDList;
addonTable.getIDFromItemLink=getIDFromItemLink;
addonTable.GetContainerNumSlots=GetContainerNumSlots;
addonTable.GetContainerItemLink=GetContainerItemLink;
addonTable.GetContainerItemInfo=GetContainerItemInfo;
addonTable.UseContainerItem=UseContainerItem;
addonTable.BANK_CONTAINER=BANK_CONTAINER;
addonTable.SlashCmdList=SlashCmdList;
addonTable.InterfaceOptions_AddCategory=InterfaceOptions_AddCategory;
addonTable.RaidRollHasLoaded=RaidRollHasLoaded;
addonTable.WorldFrame = WorldFrame;
addonTable.GameTooltip=GameTooltip;
addonTable.GameTooltip_SetDefaultAnchor=GameTooltip_SetDefaultAnchor;
addonTable.SetItemRef=SetItemRef;
addonTable.UIParent=UIParent;
addonTable.setfenv=setfenv;
addonTable.getfenv=getfenv;
addonTable.setmetatable=setmetatable;
addonTable.ceil=ceil;
addonTable.tonumber=tonumber;
addonTable.time=time;
addonTable.max = max;
addonTable.min = min;
addonTable.floor = floor;
addonTable.strlen=strlen;
addonTable.abs=abs;
addonTable.GetBuildInfo=GetBuildInfo;
addonTable.select = select;

addonTable.coroutine = coroutine;

addonTable.map = table.foreach;
addonTable.unpack = unpack;

-- Load Mik's scrolling Battle text, if available. Used for displaying messages.
addonTable.MikSBT = MikSBT;
addonTable.UIErrorsFrame = UIErrorsFrame;

-- Load basic WoW functions. Very incomplete.
--[[addonTable.SlashCmdList = SlashCmdList;
addonTable.CreateFrame = CreateFrame;
addonTable.InterfaceOptions_AddCategory=InterfaceOptions_AddCategory;
addonTable.GetCursorInfo=GetCursorInfo;
addonTable.GetItemInfo=GetItemInfo;]]--

--COMMAND LIST:
-- PLAYER_LEAVING_WORLD is triggered on leaving the world
-- UPDATE_INVENTORY_ALERTS called first, then UPDATE_INVENTORY_DURABILITY
-- then BAG_UPDATE is called several times
-- BAG_UPDATE_COOLDOWN is called much later, but called twice. Does seem reliable.

-- ZONE_CHANGED_NEW_AREA called when changing zones.


-- Load LibStub and Ace, if available

if LibStub ~= nil then
	addonTable.LibStub = LibStub;
end

--local _GLOBAL=_G;

-- Okay, we're just uncluding _G now. Eventually, I'm switching out of this mess.
addonTable._G=_G;


addonTable._G = _G;

-- Environment set! ------------------------------------------------------------
setfenv(1,addonTable);

--print("Sandbox.lua loaded");

else
-- Sandbox already loaded, do nothing.
end

