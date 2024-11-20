
if UnitFactionGroup("player") ~= "Horde" then return end


local _, HallowsEnd = ...
local points = HallowsEnd.points
-- points[<mapfile>] = { [<coordinates>] = <quest ID> }


----------------------
-- Eastern Kingdoms --
----------------------
points[14] = { -- "Arathi"
	[69023327] = 12380, -- Hammerfall
}

points[15] = { -- "Badlands"
	[65863565] = 28955, -- Fuselight
	[18364273] = 28957, -- New Kargath
}

points[17] = { -- "BlastedLands"
	[40471128] = 28959, -- Dreadmaul Hold
}

points[23] = { -- "EasternPlaguelands"
	[75575231] = 12402, -- Light's Hope Chapel
}

points[94] = { -- "EversongWoods"
	[48204788] = 12364, -- Falconwing Square
	[43707103] = 12365, -- Fairbreeze Village
}

points[95] = { -- "Ghostlands"
	[48683190] = 12373, -- Tranquillien
}

points[25] = { -- "HillsbradFoothills"
	[57854727] = 12376, -- Tarren Mill
	[60266374] = 28962, -- Eastpoint Tower
}

points[26] = { -- "Hinterlands"
	[78198147] = 12387, -- Revantusk Village
	[31805787] = 28971, -- Hiri'watha Research Station
}

points[32] = { -- "SearingGorge"
	[39486603] = 28965, -- Iron Summit
}

points[110] = { -- "SilvermoonCity"
	[79435767] = 12369, -- The Royal Exchange
	[67587288] = 12370, -- The Bazaar
}

points[21] = { -- "Silverpine"
	[46454291] = 12371, -- The Selpucher
	[44292029] = 28966, -- Forsaken Rear Guard
}

points[50] = { -- "StranglethornJungle"
	[37385178] = 12382, -- Grom'gol Base Camp
}

points[51] = { -- "SwampOfSorrows"
	[46875692] = 12384, -- Stonard
	[71651410] = 28967, -- Bogpaddle
}

points[210] = { -- "TheCapeOfStranglethorn"
	[40927374] = 12397, -- Booty Bay
	[35042721] = 28969, -- Hardwrench Hideaway
}

points[18] = { -- "Tirisfal"
	[60995141] = 12363, -- Brill
	[83057208] = 28972, -- The Bulwark
}

points[90] = { -- "Undercity"
	[67763740] = 12368, -- Trade Quarter
}

points[22] = { -- "WesternPlaguelands"
	[48286365] = 28987, -- Andorhal
}


--------------
-- Kalimdor --
--------------
points[63] = { -- "Ashenvale"
	[73906070] = 12377, -- Splintertree Post
	[50206720] = 28953, -- Silverwind Refuge
	[38604240] = 28958, -- Hellscream's Watch
	[13003410] = 28989, -- Zoram'gar Outpost
}

points[76] = { -- "Aszhara"
	[57105020] = 28992, -- Bilgewater Harbour
}

points[10] = { -- "Barrens"
	[49505800] = 12374, -- The Crossroads
	[67307470] = 12396, -- Ratchet
	[56304010] = 29002, -- Grol'dom Farm
	[62501660] = 29003, -- Nozzlepot's Outpost
}

points[66] = { -- "Desolace"
	[24106830] = 12381, -- Shadowprey Village
	[56805000] = 28993, -- Karnum's Glade
}

points[1] = { -- "Durotar"
	[51604170] = 12361, -- Razor Hill
}

points[70] = { -- "Dustwallow"
	[36803240] = 12383, -- Brackenwall Village
	[41907410] = 12398, -- Mudsprocket
}

points[77] = { -- "Felwood"
	[44602890] = 28994, -- Whisperwind Grove
}

points[69] = { -- "Feralas"
	[74804510] = 12386, -- Camp Mojache
	[41401560] = 28996, -- Camp Ataya
	[51904770] = 28998, -- Stonemaul Hold
}

points[7] = { -- "Mulgore"
	[46806040] = 12362, -- Bloodhoof Village
}

points[85] = { -- "Orgrimmar"
	[53807880] = 12366, -- The Valley of Strength
}

points[81] = { -- "Silithus"
	[55503670] = 12401, -- Cenarion Hold
}

points[199] = { -- "SouthernBarrens"
	[39302010] = 29004, -- Hunter's Hill
	[40706930] = 29005, -- Desolation Hold
}

points[65] = { -- "StonetalonMountains"
	[50406380] = 12378, -- Sun Rock Retreat
	[66506420] = 29009, -- Krom'gar Fortress
}

points[71] = { -- "Tanaris"
	[52602710] = 12399, -- Gadgetzan
	[55706090] = 29014, -- Bootlegger Outpost
}

points[88] = { -- "ThunderBluff"
	[45706450] = 12367, -- Lower Rise
}

points[78] = { -- "UngoroCrater"
	[55206210] = 29018, -- Marshal's Stand
}

points[83] = { -- "Winterspring"
	[59805120] = 12400, -- Everlook
}


-------------
-- Outland --
-------------
points[105] = { -- "BladesEdgeMountains"
	[53405550] = 12393, -- Thunderlord Stronghold
	[76206040] = 12394, -- Mok'Nathal Village
	[62903830] = 12406, -- Evergrove
}

points[100] = { -- "Hellfire"
	[56803750] = 12388, -- Thrallmar
	[26905960] = 12389, -- Falcon Watch
}

points[107] = { -- "Nagrand"
	[56703460] = 12392, -- Garadar
}

points[109] = { -- "Netherstorm"
	[32006440] = 12407, -- Area 52
	[43403610] = 12408, -- The Stormspire
}

points[104] = { -- "ShadowmoonValley"
	[30302780] = 12395, -- Shadowmoon Village
}

points[111] = { -- "ShattrathCity"
}

points[108] = { -- "TerokkarForest"
	[48804520] = 12391, -- Stonebreaker Hold
}

points[102] = { -- "Zangarmarsh"
	[30705090] = 12390, -- Zabra'jin Village
	[78506290] = 12403, -- Cenarion Refuge
}


---------------
-- Northrend --
---------------
points[114] = { -- "BoreanTundra"
	[78454915] = 13460, -- Unu'pe
	[76663747] = 13467, -- Taunka'le Village
	[41715440] = 13468, -- Warsong Hold
	[49750998] = 13501, -- Bor'gorok Outpost
}

points[127] = { -- "CrystalsongForest"
	[29053658] = 13463, -- The Ledgerdemain Lounge, Dalaran
	[27294136] = 13472, -- The Underbelly, Dalaran
	[34743302] = 13474, -- Sunreaver's Sanctuary, Dalaran
}

points[125] = { -- "Dalaran"
	[48144132] = 13463, -- The Ledgerdemain Lounge
	[42305680] = 13472, -- The Underbelly
	[66842962] = 13474, -- Sunreaver's Sanctuary
}

points[126] = { -- "DalaranUnderbelly"
	[38225959] = 13472, -- The Underbelly
}

points[115] = { -- "Dragonblight"
	[60155345] = 13456, -- Wyrmrest Temple
	[48117466] = 13459, -- Moa'ki Harbour
	[37834648] = 13469, -- Agmar's Hammer
	[76826328] = 13470, -- Venomspite
}

points[116] = { -- "GrizzlyHills"
	[20896477] = 12946, -- Conquest Hold
	[65354700] = 12947, -- Camp Oneqwah
}

points[117] = { -- "HowlingFjord"
	[25445982] = 13452, -- Kamagua
	[49441075] = 13464, -- Camp Winterhoof
	[52106614] = 13465, -- New Agamand
	[79273063] = 13466, -- Vengeance Landing
}

points[119] = { -- "SholazarBasin"
	[26615920] = 12950, -- Nesingwary Base Camp
}

points[120] = { -- "TheStormPeaks"
	[41078585] = 13461, -- K3
	[30923716] = 13462, -- Bouldercrag's Refuge
	[67655069] = 13471, -- Camp Tunka'lo
	[37094951] = 13548, -- Grom'arsh Crash Site
}

points[121] = { -- "ZulDrak"
	[59335720] = 12940, -- Zim'Torga
	[40866604] = 12941, -- The Argent Stand
}


---------------
-- Cataclysm --
---------------
points[207] = { -- "Deepholm"
	[51205000] = 29019, -- Temple of Earth
}

points[198] = { -- "Hyjal"
	[63002410] = 28999, -- Nordrassil
	[18703730] = 29000, -- Grove of Aessina
	[42704560] = 29001, -- Shrine of Aviana
}

points[241] = { -- "TwilightHighlands"
	[53404290] = 28973, -- Blood Gulch
	[45107670] = 28974, -- Crush Blow
	[75401650] = 28976, -- The Krazzworks
}

points[249] = { -- "Uldum"
	[26600730] = 29016, -- Oasis of Vir'sar
	[54703300] = 29017, -- Ramkahen
}

points[204] = { -- "VashjirDepths"
	[51306060] = 28986, -- Tenebrous Caverns
}

points[201] = { -- "VashjirKelpForest"
	[63406020] = 28981, -- Deepmist Grotto
}

points[205] = { -- "VashjirRuins"
	[49204190] = 28982, -- Silver Tide Hollow
	[51506250] = 28984, -- Legion's Rest
}


--------------
-- Pandaria --
--------------
points[422] = { -- "DreadWastes"
	[55217120] = 32023, -- Soggy's Gamble
	[55933227] = 32024, -- Klaxxi'vess
}

points[418] = { -- "Krasarang"
	[51407729] = 32034, -- Marista's Bait & Brew
	[75900687] = 32036, -- Zhu's Watch
	[61032514] = 32047, -- Thunder Cleft (Horde)
	[28255074] = 32020, -- Dawnchaser Retreat (Horde)
}

points[379] = { -- "KunLaiSummit"
	[72739228] = 32039, -- Binan Village
	[64216127] = 32041, -- The Grummle Bazaar
	[57455995] = 32037, -- One Keg
	[62778050] = 32040, -- Eastwind Rest
	[62502890] = 32051, -- Zouchin Village
}

points[391] = { -- "ShrineofTwoMoons"
	[60306630] = 32022, -- Shrine of Two Moons, Vale of Eternal Blossoms
}

points[392] = { -- "ShrineofTwoMoons"
	[58847832] = 32022, -- Shrine of Two Moons, Vale of Eternal Blossoms
}

points[433] = { -- "TheHiddenPass"
	[55117223] = 32026, -- Tavern in the Mists
}

points[371] = { -- "TheJadeForest"
	[45774360] = 32027, -- Dawn's Blossom
	[48093462] = 32029, -- Greenstone Village
	[54606333] = 32032, -- Jade Temple Grounds
	[28451327] = 32050, -- Honeydew Village (Horde)
	[28014738] = 32028, -- Grookin Hill (Horde)
	[55712441] = 32031, -- Sri-La Village
	[41682314] = 32021, -- Tian Monastery
}

points[388] = { -- "TownlongWastes"
	[71115778] = 32043, -- Longying Outpost
}

points[390] = { -- "ValeofEternalBlossoms"
	[35157775] = 32044, -- Mistfall Village
	[61981626] = 32022, -- Shrine of Two Moons
}

points[376] = { -- "ValleyoftheFourWinds"
	[83642015] = 32048, -- Pang's Stead
	[19875579] = 32046, -- Stoneplow
}


-------------
-- Draenor --
-------------
points[590] = { -- "garrisonffhorde_tier3"
	[47083791] = 39657, -- Frostwall Garrison
}

points[525] = { -- "FrostfireRidge"
	[48276471] = 39657, -- Frostwall Garrison
}


------------------
-- Broken Isles --
------------------
points[627] = { -- "Dalaran70"
	[47954177] = 43055, -- The Ledgerdemain Lounge
	[67042940] = 43057, -- Windrunner's Sanctuary
}


------------------
-- Dragon Isles --
------------------
points[2023] = { -- "Ohn'ahran Plains"
	[46224060] = 75684, -- Broadhoof Outpost
	[66242453] = 75693, -- Emberwatch
	[72148039] = 75692, -- Forkriver Crossing
	[62934057] = 75685, -- Maruukai
	[57147672] = 75687, -- Ohn'iri Springs
	[81295920] = 75688, -- Pinewood Post
	[85853536] = 75689, -- Rusza'thar Reach
	[28646057] = 75686, -- Shady Sanctuary (Greenscale Inn)
	[41916043] = 75691, -- Teerakai
	[85042603] = 75690, -- Timberstep Outpost
}

points[2025] = { -- "Thaldraszus"
	[50084273] = 75698, -- Algeth'era Court (The Late Night Lab)
	[35087921] = 75696, -- Garden Shrine
	[52406981] = 75697, -- Gelikyr Post
	[59858269] = 75695, -- Temporal Conflux
}

points[2024] = { -- "The Azure Span"
	[47034026] = 75667, -- Camp Antonidas (Mage's Rest)
	[62785773] = 75668, -- Camp Nowhere (Mulsted's Marquee)
	[12394935] = 75669, -- Iskaara
	[65501625] = 75670, -- Theron's Watch
	[18812455] = 75671, -- Three-Falls Lookout (The Missing Hinge Inn)
}

points[2151] = { -- "The Forbidden Reach"
	[33835880] = 75702, -- Morqut Village
}

points[2022] = { -- "The Waking Shores"
	[24468210] = 75672, -- Apex Observatory
	[47678330] = 75673, -- Dragonscale Basecamp
	[65225793] = 75675, -- Life Vault Ruins
	[43116666] = 77698, -- Obsidian Bulwark
	[25775518] = 75676, -- Obsidian Throne
	[58036731] = 75674, -- Ruby Lifeshine
	[76075475] = 75677, -- Skytop Observatory
	[53913904] = 75678, -- Uktulut Backwater
	[46442741] = 75679, -- Uktulut Pier
	[76213541] = 75683, -- Wingrest Embassy
	[80422788] = 75682, -- Wild Coast (Horde)
}

points[2112] = { -- "Valdraaken"
	[72374669] = 75700, -- The Parting Glass
	[47134540] = 75699, -- The Roasted Ram
	[22353086] = 75701, -- Weyrnrest
}

points[2133] = { -- "Zaralek Cavern"
	[56375635] = 75704, -- Loamm
	[52122647] = 75703, -- Obsidian Rest
}


----------------
-- Khaz Algar --
----------------
points[2248] = { -- "Isle of Dorn"
	[58172711] = 84567, -- Rambleshire
	[41997437] = 84566, -- Freywold Village
}

points[2339] = { -- "Dornogal"
	[45014731] = 84564, -- Dornogal
}

points[2214] = { -- "The Ringing Depths"
	[47893209] = 84569, -- Gundargaz
	[61874627] = 84571, -- Shadowvein Point
	[59466408] = 84568, -- Camp Murroch
	[63417898] = 84570, -- Opportunity Point
}

points[2215] = { -- "Hallowfall"
	[42765571] = 84575, -- Mereldar
	[69064571] = 84572, -- Dunnelle's Kindess (Dunelle's Rest)
	[49133953] = 84573, -- Lorel's Crossing (Fjord Tavern)
	[40576800] = 84574, -- Light's Redoubt
}

points[2255] = { -- "Azj-Kahet"
	[58961862] = 84579, -- Faerin's Advance
	[56863897] = 84582, -- Weaver's Lair (The Trap Door)
	[77956277] = 84580, -- Mmarl (Rock Bottom Inn)
	[44856626] = 84581, -- Wildcamp Ul'ar
}

points[2216] = { -- "City of Threads"
	[57453850] = 84577, -- The Burrows, Lower City (The Cobwebs)
	[62044136] = 84576, -- High Hollows
}

points[2213] = { -- "City of Threads, Umbral Bazaar"
	[49742225] = 84578, -- Umbral Bazaar (The Skittering Lounge)
}
