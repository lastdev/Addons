--	*** LibItemInfo ***
-- Written by : Thaoky, EU-Marécages de Zangar
-- March 2021
-- This list was manually curated (source: mostly Wowhead + in-game).
-- Non-commercial use is permitted as long as credits are preserved, and that Blizzard's terms of services are respected.

local lib = LibStub("LibItemInfo-1.0")

local e = lib.Enum.ReagentTypes
local bag = lib.Enum.BagTypes
local SetReagent = lib.SetReagent

-- Items that are related to multiple professions
lib:RegisterItems({

	-- 1.0 Classic
	[5498] = SetReagent(0, e.Multi, 0, bag.GemBag), -- Small Lustrous Pearl
	[5500] = SetReagent(0, e.Multi, 0, bag.GemBag), -- Iridescent Pearl
	[7067] = SetReagent(0, e.Multi), -- Elemental Earth
	[7068] = SetReagent(0, e.Multi), -- Elemental Fire
	[7069] = SetReagent(0, e.Multi), -- Elemental Air
	[7070] = SetReagent(0, e.Multi), -- Elemental Water
	[7075] = SetReagent(0, e.Multi), -- Core of Earth
	[7077] = SetReagent(0, e.Multi), -- Heart of Fire
	[7079] = SetReagent(0, e.Multi), -- Globe of Water
	[7081] = SetReagent(0, e.Multi), -- Breath of Wind
	[7972] = SetReagent(0, e.Multi), -- Ichor of Undeath
	[10286] = SetReagent(0, e.Multi, 0, bag.HerbBag), -- Heart of the wild
	[12809] = SetReagent(0, e.Multi, 0), -- Guardian Stone
	[13926] = SetReagent(0, e.Multi, 0, bag.GemBag), -- Golden Pearl
	
	-- 2.0 BC
	[23572] = SetReagent(1, e.Multi), -- Primal Nether
	[24478] = SetReagent(1, e.Multi, 0, bag.GemBag), -- Jaggal Pearl
	[30183] = SetReagent(1, e.Multi, 0, bag.LeatherworkingBag), -- Nether Vortex
	
	-- 3.0 WotLK
	[36784] = SetReagent(2, e.Multi, 0, bag.GemBag), -- Siren's Tear
	
	-- 4.0 Cataclysm
	[52325] = SetReagent(3, e.Multi), -- Volatile Fire
	[52326] = SetReagent(3, e.Multi), -- Volatile Water
	[52327] = SetReagent(3, e.Multi), -- Volatile Earth
	[52328] = SetReagent(3, e.Multi), -- Volatile Air
	[52329] = SetReagent(3, e.Multi), -- Volatile Life
	
	-- 5.0 Mists of Pandaria
	[89112] = SetReagent(4, e.Multi), -- Mote of Harmony
	[76061] = SetReagent(4, e.Multi), -- Spirit of Harmony
	
	-- 6.0 Warlords of Draenor
	
	-- 7.0 Legion
	[124438] = SetReagent(6, e.Multi), -- Unbroken Claw
	[124439] = SetReagent(6, e.Multi), -- Unbroken Tooth
	
	-- 8.0 Battle for Azeroth
	[152668] = SetReagent(7, e.Multi), -- Expulsom
	[162460] = SetReagent(7, e.Multi), -- Hydrocore
	[162461] = SetReagent(7, e.Multi), -- Sanguicel
	[165703] = SetReagent(7, e.Multi), -- Breath of Bwonsamdi
	[165948] = SetReagent(7, e.Multi), -- Tidalcore
	
	-- 9.0 Shadowlands
	[178787] = SetReagent(8, e.Multi), -- Orboreal Shard
	[180055] = SetReagent(8, e.Multi), -- Relic of the Past I
	[178757] = SetReagent(8, e.Multi), -- Relic of the Past II
	[178788] = SetReagent(8, e.Multi), -- Relic of the Past III
	[178759] = SetReagent(8, e.Multi), -- Relic of the Past IV
	[178760] = SetReagent(8, e.Multi), -- Relic of the Past V
})
