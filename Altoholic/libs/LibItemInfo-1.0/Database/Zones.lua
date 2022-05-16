--	*** LibItemInfo ***
-- Written by : Thaoky, EU-Marécages de Zangar
-- March 2021
-- This list was manually curated (source: mostly Wowhead + in-game).
-- Non-commercial use is permitted as long as credits are preserved, and that Blizzard's terms of services are respected.

--[[ Purpose of this file :

Items stored in this file are "zone items", or items that are only relevant to a given zone.
The goal is to provide a minimum of info to the user for all those items that only have a vague description.
If it's an item that can simply be clicked to learn (like a pet or a toy), it has nothing to do in this list.
If the item already a clear description about a faction it is related to, it has nothing to do in this list.
However, if it is an item for which you cannot say from which expansion/zone it is.. then it should be here.
For some items that have only 1 location where they can be used in the zone, then try to add X-Y Coords with SetZoneItem()

Zones

https://wowpedia.fandom.com/wiki/UiMapID
C_Map.GetMapInfo()  https://wowpedia.fandom.com/wiki/API_C_Map.GetMapInfo
ID's : https://wowpedia.fandom.com/wiki/UiMapID
--]]

local lib = LibStub("LibItemInfo-1.0")

-- Note, pass the coordinates as integers (simply x10)
-- ex: 38.9 42.0 => 389, 420
local SetZoneItem = lib.SetZoneItem


local VALE_OF_ETERNAL_BLOSSOM = 390

local AZSUNA = 630
local DRAENOR_NAGRAND = 550

local MALDRAXXUS = 1536
local THE_MAW = 1960
local KORTHIA = 1961
local ZERETH_MORTIS = 1970

lib:RegisterItems({

	-- 1.0 Classic


	
	-- 2.0 BC
	
	-- 3.0 WotLK
	
	-- 4.0 Cataclysm
	
	-- 5.0 Mists of Pandaria
	[87779] = SetZoneItem(4, VALE_OF_ETERNAL_BLOSSOM, 214, 169), 		-- Ancient Guo-Lai Cache Key
	
	-- 6.0 Warlords of Draenor
	[118658] = SetZoneItem(5, DRAENOR_NAGRAND, 502, 412), 		-- Gagrog's Skull
	[131744] = SetZoneItem(5, AZSUNA, 533, 394), 		-- Key to Nar'thalas Academy
	
	-- 7.0 Legion
	
	-- 8.0 Battle for Azeroth
	
	-- 9.0 Shadowlands
	[175757] = SetZoneItem(8, MALDRAXXUS, 389, 420), -- Construct Supply Key
	[180277] = SetZoneItem(8, MALDRAXXUS, 379, 456), -- Battlefront Ration Key
	
	[186727] = SetZoneItem(8, THE_MAW), 		-- Seal Breaker Key
	[186718] = SetZoneItem(8, KORTHIA), 		-- Teleporter Repair Kit
	
	[188957] = SetZoneItem(8, ZERETH_MORTIS), -- Genesis Mote
	[189863] = SetZoneItem(8, ZERETH_MORTIS), -- Spatial Opener
	[190189] = SetZoneItem(8, ZERETH_MORTIS), -- Sandworn Relic
	[190197] = SetZoneItem(8, ZERETH_MORTIS), -- Sandworn Chest Key
	[190198] = SetZoneItem(8, ZERETH_MORTIS), -- Sandworn Chest Key Fragment
	[190739] = SetZoneItem(8, ZERETH_MORTIS), -- Provis Wax
	[190740] = SetZoneItem(8, ZERETH_MORTIS), -- Automa Integration
})
