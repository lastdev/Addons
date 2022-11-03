--	*** LibItemInfo ***
-- Written by : Thaoky, EU-Marécages de Zangar
-- March 2021
-- This list was manually curated (source: mostly Wowhead + in-game).
-- Non-commercial use is permitted as long as credits are preserved, and that Blizzard's terms of services are respected.

local lib = LibStub("LibItemInfo-1.0")

local e = lib.Enum.ReagentTypes
local bag = lib.Enum.BagTypes
local SetReagent = lib.SetReagent

lib:RegisterItems({
	-- https://www.wowhead.com/items?filter=166:88:217;5:1:1;0:0:0

	-- 1.0 Classic
	[774] = SetReagent(0, e.Jewelcrafting), -- Malachite
	[818] = SetReagent(0, e.Jewelcrafting), -- Tigerseye
	[1206] = SetReagent(0, e.Jewelcrafting), -- Moss Agate
	[1210] = SetReagent(0, e.Jewelcrafting), -- Shadowgem
	[1529] = SetReagent(0, e.Jewelcrafting), -- Jade
	[1705] = SetReagent(0, e.Jewelcrafting), -- Lesser Moonstone
	[3864] = SetReagent(0, e.Jewelcrafting), -- Citrine
	[7909] = SetReagent(0, e.Jewelcrafting), -- Aquamarine
	[7910] = SetReagent(0, e.Jewelcrafting), -- Star Ruby
	[12361] = SetReagent(0, e.Jewelcrafting), -- Blue Sapphire
	[12363] = SetReagent(0, e.Jewelcrafting), -- Arcane Crystal
	[12364] = SetReagent(0, e.Jewelcrafting), -- Huge Emerald
	[12799] = SetReagent(0, e.Jewelcrafting), -- Large Opal
	[12800] = SetReagent(0, e.Jewelcrafting), -- Azerothian Diamond
	
	[20816] = SetReagent(0, e.Jewelcrafting, 1), -- Delicate Copper Wire
	[20817] = SetReagent(0, e.Jewelcrafting, 50), -- Bronze Setting
	[20963] = SetReagent(0, e.Jewelcrafting, 150), -- Mithril Filigree
	[21752] = SetReagent(0, e.Jewelcrafting, 225), -- Thorium Setting
	
	-- 2.0 BC
	[21929] = SetReagent(1, e.Jewelcrafting), -- Flame Spessarite
	[23077] = SetReagent(1, e.Jewelcrafting), -- Blood Garnet
	[23079] = SetReagent(1, e.Jewelcrafting), -- Deep Peridot
	[23107] = SetReagent(1, e.Jewelcrafting), -- Shadow Draenite
	[23112] = SetReagent(1, e.Jewelcrafting), -- Golden Draenite
	[23117] = SetReagent(1, e.Jewelcrafting), -- Azure Moonstone
	[23436] = SetReagent(1, e.Jewelcrafting), -- Living Ruby
	[23437] = SetReagent(1, e.Jewelcrafting), -- Talasite
	[23438] = SetReagent(1, e.Jewelcrafting), -- Star of Elune
	[23439] = SetReagent(1, e.Jewelcrafting), -- Noble Topaz
	[23440] = SetReagent(1, e.Jewelcrafting), -- Dawnstone
	[23441] = SetReagent(1, e.Jewelcrafting), -- Nightseye
	[24243] = SetReagent(1, e.Jewelcrafting), -- Adamantite Powder
	[24479] = SetReagent(1, e.Jewelcrafting), -- Shadow Pearl
	[32227] = SetReagent(1, e.Jewelcrafting), -- Crimson Spinel
	[32228] = SetReagent(1, e.Jewelcrafting), -- Empyrean Sapphire
	[32229] = SetReagent(1, e.Jewelcrafting), -- Lionseye
	[32230] = SetReagent(1, e.Jewelcrafting), -- Shadowsong Amethyst
	[32231] = SetReagent(1, e.Jewelcrafting), -- Pyrestone
	[32249] = SetReagent(1, e.Jewelcrafting), -- Seaspray Emerald
	
	[31079] = SetReagent(1, e.Jewelcrafting, 25), -- Mercurial Adamantite
	
	-- 3.0 WotLK
	[36783] = SetReagent(2, e.Jewelcrafting), -- Northsea Pearl
	[36917] = SetReagent(2, e.Jewelcrafting), -- Bloodstone
	[36918] = SetReagent(2, e.Jewelcrafting), -- Scarlet Ruby
	[36920] = SetReagent(2, e.Jewelcrafting), -- Sun Crystal
	[36921] = SetReagent(2, e.Jewelcrafting), -- Autumn's Glow
	[36923] = SetReagent(2, e.Jewelcrafting), -- Chalcedony
	[36924] = SetReagent(2, e.Jewelcrafting), -- Sky Sapphire
	[36926] = SetReagent(2, e.Jewelcrafting), -- Shadow Crystal
	[36927] = SetReagent(2, e.Jewelcrafting), -- Twilight Opal
	[36929] = SetReagent(2, e.Jewelcrafting), -- Huge Citrine
	[36930] = SetReagent(2, e.Jewelcrafting), -- Monarch Topaz
	[36932] = SetReagent(2, e.Jewelcrafting), -- Dark Jade
	[36933] = SetReagent(2, e.Jewelcrafting), -- Forest Emerald
	
	-- 4.0 Cataclysm
	[52177] = SetReagent(3, e.Jewelcrafting), -- Carnelian
	[52178] = SetReagent(3, e.Jewelcrafting), -- Zephyrite
	[52179] = SetReagent(3, e.Jewelcrafting), -- Alicite
	[52180] = SetReagent(3, e.Jewelcrafting), -- Nightstone
	[52181] = SetReagent(3, e.Jewelcrafting), -- Hessonite
	[52182] = SetReagent(3, e.Jewelcrafting), -- Jasper
	[52188] = SetReagent(3, e.Jewelcrafting), -- Jeweler's Setting
	
	[71805] = SetReagent(3, e.Jewelcrafting), -- Queen's Garnet
	[71806] = SetReagent(3, e.Jewelcrafting), -- Lightstone
	[71807] = SetReagent(3, e.Jewelcrafting), -- Deepholm Iolite
	[71808] = SetReagent(3, e.Jewelcrafting), -- Lava Coral
	[71809] = SetReagent(3, e.Jewelcrafting), -- Shadow Spinel
	[71810] = SetReagent(3, e.Jewelcrafting), -- Elven Peridot
	
	-- 5.0 Mists of Pandaria
	[76130] = SetReagent(4, e.Jewelcrafting), -- Tiger Opal
	[76132] = SetReagent(4, e.Jewelcrafting), -- Primal Diamond
	[76133] = SetReagent(4, e.Jewelcrafting), -- Lapis Lazuli
	[76134] = SetReagent(4, e.Jewelcrafting), -- Sunstone
	[76135] = SetReagent(4, e.Jewelcrafting), -- Roguestone
	[76136] = SetReagent(4, e.Jewelcrafting), -- Pandarian Garnet
	[76137] = SetReagent(4, e.Jewelcrafting), -- Alexandrite
	[76734] = SetReagent(4, e.Jewelcrafting), -- Serpent's Eye
	[90407] = SetReagent(4, e.Jewelcrafting), -- Sparkling Shard	
	
	-- 6.0 Warlords of Draenor
	-- WoD did jewelcrafting differently ..
	[115524] = SetReagent(5, e.Jewelcrafting), -- Taladite Crystal
	
	-- 7.0 Legion
	[129100] = SetReagent(6, e.Jewelcrafting), -- Gem Chip
	[130172] = SetReagent(6, e.Jewelcrafting), -- Sangrite
	[130173] = SetReagent(6, e.Jewelcrafting), -- Deep Amber
	[130174] = SetReagent(6, e.Jewelcrafting), -- Azsunite
	[130175] = SetReagent(6, e.Jewelcrafting), -- Chaotic Spinel
	[130176] = SetReagent(6, e.Jewelcrafting), -- Skystone
	[130177] = SetReagent(6, e.Jewelcrafting), -- Queen's Opal
	[130178] = SetReagent(6, e.Jewelcrafting), -- Furystone
	[130179] = SetReagent(6, e.Jewelcrafting), -- Eye of Prophecy
	[130180] = SetReagent(6, e.Jewelcrafting), -- Dawnlight
	[130181] = SetReagent(6, e.Jewelcrafting), -- Pandemonite
	[130182] = SetReagent(6, e.Jewelcrafting), -- Maelstrom Sapphire
	[130183] = SetReagent(6, e.Jewelcrafting), -- Shadowruby
	[151579] = SetReagent(6, e.Jewelcrafting), -- Labradorite
	[151718] = SetReagent(6, e.Jewelcrafting), -- Argulite
	[151719] = SetReagent(6, e.Jewelcrafting), -- Lightsphene
	[151720] = SetReagent(6, e.Jewelcrafting), -- Chemirine
	[151721] = SetReagent(6, e.Jewelcrafting), -- Hesselian
	[151722] = SetReagent(6, e.Jewelcrafting), -- Florid Malachite
	
	-- 8.0 Battle for Azeroth
	[153700] = SetReagent(7, e.Jewelcrafting), -- Golden Beryl
	[153701] = SetReagent(7, e.Jewelcrafting), -- Rubellite
	[153702] = SetReagent(7, e.Jewelcrafting), -- Kubiline
	[153703] = SetReagent(7, e.Jewelcrafting), -- Solstone
	[153704] = SetReagent(7, e.Jewelcrafting), -- Viridium
	[153705] = SetReagent(7, e.Jewelcrafting), -- Kyanite
	[153706] = SetReagent(7, e.Jewelcrafting), -- Kraken's Eye
	[154120] = SetReagent(7, e.Jewelcrafting), -- Owlseye
	[154121] = SetReagent(7, e.Jewelcrafting), -- Scarlet Diamond
	[154122] = SetReagent(7, e.Jewelcrafting), -- Tidal Amethyst
	[154123] = SetReagent(7, e.Jewelcrafting), -- Amberblaze
	[154124] = SetReagent(7, e.Jewelcrafting), -- Laribole
	[154125] = SetReagent(7, e.Jewelcrafting), -- Royal Quartz
	[168635] = SetReagent(7, e.Jewelcrafting), -- Leviathan's Eye
	[168188] = SetReagent(7, e.Jewelcrafting), -- Sage Agate
	[168189] = SetReagent(7, e.Jewelcrafting), -- Dark Opal
	[168190] = SetReagent(7, e.Jewelcrafting), -- Lava Lazuli
	[168191] = SetReagent(7, e.Jewelcrafting), -- Sea Currant
	[168192] = SetReagent(7, e.Jewelcrafting), -- Sand Spinel
	[168193] = SetReagent(7, e.Jewelcrafting), -- Azsharine
	
	-- 9.0 Shadowlands
	[173108] = SetReagent(8, e.Jewelcrafting), -- Oriblase
	[173109] = SetReagent(8, e.Jewelcrafting), -- Angerseye
	[173110] = SetReagent(8, e.Jewelcrafting), -- Umbryl
	[173168] = SetReagent(8, e.Jewelcrafting), -- Laestrite Setting
	[173170] = SetReagent(8, e.Jewelcrafting), -- Essence of Rebirth
	[173171] = SetReagent(8, e.Jewelcrafting), -- Essence of Torment
	[173172] = SetReagent(8, e.Jewelcrafting), -- Essence of Servitude
	[173173] = SetReagent(8, e.Jewelcrafting), -- Essence of Valor
})