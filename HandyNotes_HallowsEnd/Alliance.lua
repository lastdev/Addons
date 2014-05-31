
if UnitFactionGroup("player") ~= "Alliance" then return end


local _, HallowsEnd = ...
local points = HallowsEnd.points
-- points[<mapfile>] = { [<coordinates>] = <quest ID> }


----------------------
-- Eastern Kingdoms --
----------------------
points["Arathi"] = {
	[40104910] = 28954, -- Refuge Pointe
}

points["Badlands"] = {
	[65903580] = 28955, -- Fuselight
	[20905630] = 28956, -- Dragon's Mouth
}

points["BlastedLands"] = {
	[60691408] = 28960, -- Nethergarde Keep
	[44338759] = 28961, -- Surwich
}

points["DunMorogh"] = {
	[54505070] = 12332, -- Kharanos
}

points["Duskwood"] = {
	[73804430] = 12344, -- Darkshire
}

points["EasternPlaguelands"] = {
	[75605240] = 12402, -- Light's Hope Chapel
}

points["Elwynn"] = {
	[43746589] = 12286, -- Goldshire
}

points["Hinterlands"] = {
	[14204470] = 12351, -- Aerie Peak
	[66204440] = 28970, -- Stormfeather Outpost
}

points["Ironforge"] = {
	[18705130] = 12335, -- The Commons
}

points["LochModan"] = {
	[35504840] = 12339, -- Thelsamar
	[82906360] = 28963, -- Farstrider Lodge
}

points["Redridge"] = {
	[26464150] = 12342, -- Lakeshire
}

points["SearingGorge"] = {
	[39486602] = 28965, -- Iron Summit
}

points["StormwindCity"] = {
	[60527533] = 12336, -- Trade District
}

points["StranglethornJungle"] = {
	[53166699] = 28964, -- Fort Livingston
}

points["SwampOfSorrows"] = {
	[71641408] = 28967, -- Bogpaddle
	[28933241] = 28968, -- The Harbourage
}

points["TheCapeOfStranglethorn"] = {
	[40927374] = 12397, -- Booty Bay
}

points["WesternPlaguelands"] = {
	[43408450] = 28988, -- Chillwind Camp
}

points["Westfall"] = {
	[56814732] = 12340, -- Sentinel Hill
}

points["Wetlands"] = {
	[10806090] = 12343, -- Menethil Harbour
	[26102590] = 28990, -- Swiftgear Station
	[58103920] = 28991, -- Greenwarden Grove
}


--------------
-- Kalimdor --
--------------
points["Ashenvale"] = {
	[37004930] = 12345, -- Astranaar
}

points["AzuremystIsle"] = {
	[48494205] = 12333, -- Azure Watch
}

points["Barrens"] = {
	[67307470] = 12396, -- Ratchet
}

points["BloodmystIsle"] = {
	[55705990] = 12341, -- Blood Watch
}

points["Darkshore"] = {
	[50801880] = 28951, -- Lor'danel
}

points["Darnassus"] = {
	[62203300] = 12334, -- Craftsman's Terrace
}

points["Desolace"] = {
	[66300670] = 12348, -- Nijel's Point
	[56805000] = 28993, -- Karnum's Glade
}

points["Dustwallow"] = {
	[66604530] = 12349, -- Theramore Isle
	[41907410] = 12398, -- Mudsprocket
}

points["Felwood"] = {
	[44602890] = 28994, -- Whisperwind Grove
	[61802670] = 28995, -- Talonbranch Glade
}

points["Feralas"] = {
	[46304520] = 12350, -- Feathermoon Stronghold
	[51101780] = 28952, -- Dreamer's Rest
}

points["Silithus"] = {
	[55503670] = 12401, -- Cenarion Hold
}

points["SouthernBarrens"] = {
	[39001100] = 29006, -- Honour's Stand
	[65604660] = 29007, -- Northwatch Hold
	[49106850] = 29008, -- Fort Triumph
}

points["StonetalonMountains"] = {
	[71027908] = 29010, -- Northwatch Expedition Base Camp
	[59105630] = 29011, -- Windshear Hold
	[39503280] = 29012, -- Thal'darah Overlook
	[31506070] = 29013, -- Farwatcher's Glen
}

points["Tanaris"] = {
	[52602710] = 12399, -- Gadgetzan
	[55706090] = 29014, -- Bootlegger Outpost
}

points["TheExodar"] = {
	[59251847] = 12337, -- Seat of the Naaru
}

points["Teldrassil"] = {
	[55405230] = 12331, -- Dolanaar
}

points["UngoroCrater"] = {
	[55206210] = 29018, -- Marshal's Stand
}

points["Winterspring"] = {
	[59805120] = 12400, -- Everlook
}


-------------
-- Outland --
-------------
points["BladesEdgeMountains"] = {
	[62903830] = 12406, -- Evergrove
	[35806380] = 12358, -- Sylvanaar
	[61006810] = 12359, -- Toshley's Station
}

points["Hellfire"] = {
	[54306360] = 12352, -- Honour Hold
	[23403650] = 12353, -- Temple of Telhamat
}

points["Nagrand"] = {
	[54207580] = 12357, -- Telaar
}

points["Netherstorm"] = {
	[32006440] = 12407, -- Area 52
	[43403610] = 12408, -- The Stormspire
}

points["ShadowmoonValley"] = {
	[37105820] = 12360, -- Wildhammer Stronghold
	[61002820] = 12409, -- Altar of Sha'tar
	[56305980] = 12409, -- Sanctum of the Stars
}

points["ShattrathCity"] = {
	[28104900] = 12404, -- Aldor Rise
	[56208180] = 12404, -- Scryer's Tier
}

points["TerokkarForest"] = {
	[56605320] = 12356, -- Allerian Stronghold
}

points["Zangarmarsh"] = {
	[67204900] = 12354, -- Telredor
	[41902620] = 12355, -- Orebor Harbourage
	[78506290] = 12403, -- Cenarion Refuge
}


---------------
-- Northrend --
---------------
points["BoreanTundra"] = {
	[58506790] = 13436, -- Valliance Keep
	[57101880] = 13437, -- Fizzcrank Airstrip
	[78404920] = 13460, -- Unu'pe
}

points["Dalaran"] = {
	[48304080] = 13463, -- The Ledgerdemain Lounge
	[37805990] = 13472, -- The Underbelly
	[42506360] = 13473, -- The Silver Enclave
}

points["Dragonblight"] = {
	[29005620] = 13438, -- Stars' Rest
	[77505130] = 13439, -- Wintergarde Keep
	[60105350] = 13456, -- Wyrmrest Temple
	[48207470] = 13459, -- Moa'ki Harbour
}

points["GrizzlyHills"] = {
	[32006020] = 12944, -- Amberpine Lodge
	[59602640] = 12945, -- Westfall Brigade
}

points["HowlingFjord"] = {
	[58406280] = 13433, -- Valgarde
	[30804150] = 13434, -- Westguard Keep
	[60501590] = 13435, -- Fort Wildevar
	[25405980] = 13452, -- Kamagua
}

points["SholazarBasin"] = {
	[26705920] = 12950, -- Nesingwary Base Camp
}

points["TheStormPeaks"] = {
	[28707430] = 13448, -- Frosthold
	[41108590] = 13461, -- K3
	[30903720] = 13462, -- Bouldercrag's Refuge
}

points["ZulDrak"] = {
	[59305720] = 12940, -- Zim'Torga
	[40806600] = 12941, -- The Argent Stand
}


---------------
-- Cataclysm --
---------------
points["Deepholm"] = {
	[47405170] = 29020, -- Temple of Earth
}

points["Hyjal"] = {
	[63002410] = 28999, -- Nordrassil
	[18703730] = 29000, -- Grove of Aessina
	[42704560] = 29001, -- Shrine of Aviana
}

points["TwilightHighlands"] = {
	[60405820] = 28977, -- Firebeard's Patrol
	[79507850] = 28980, -- Highbank
	[49603040] = 28978, -- Thundermar
	[43605730] = 28979, -- Victor's Point
}

points["Uldum"] = {
	[26600730] = 29016, -- Oasis of Vir'sar
	[54703300] = 29017, -- Ramkahen
}

points["VashjirDepths"] = {
	[54707220] = 28985, -- Darkbreak Cove
}

points["VashjirKelpForest"] = {
	[63406020] = 28981, -- Deepmist Grotto
}

points["VashjirRuins"] = {
	[49204190] = 28982, -- Silver Tide Hollow
	[49705740] = 28983, -- Tranquil Wash
}


--------------
-- Pandaria --
--------------
points["DreadWastes"] = {
	[55007100] = 32023, -- Soggy's Gamble
	[56003200] = 32024, -- Klaxxi'vess
}

points["Krasarang"] = {
	[51007700] = 32034, -- Marista
	[76000700] = 32036, -- Zhu's Watch
}

points["KunLaiSummit"] = {
	[73009200] = 32039, -- Binan Village
	[64006100] = 32041, -- The Grummle Bazaar
	[57006000] = 32037, -- One Keg
	[54008300] = 32042, -- Westwind Rest
	[62002900] = 32051, -- Zouchin Village
}

points["TheHiddenPass"] = {
	[55007200] = 32026, -- Tavern in the Mists
}

points["TheJadeForest"] = {
	[46004400] = 32027, -- Dawn's Blossom
	[48003500] = 32029, -- Greenstone Village
	[55006300] = 32032, -- Jade Temple Grounds
	[45008400] = 32049, -- Paw'don Village
	[60008300] = 32033, -- Pearlfin Village
	[56002400] = 32031, -- Sri-La Village
	[42002300] = 32021, -- Tian Monastery
}

points["TownlongWastes"] = {
	[71005800] = 32043, -- Longying Outpost
}

points["ValeofEternalBlossoms"] = {
	[35157775] = 32044, -- Mistfall Village
	[87006400] = 32052, -- Shrine of Seven Stars
}

points["ValleyoftheFourWinds"] = {
	[84002000] = 32048, -- Pang's Stead
	[20005600] = 32046, -- Stoneplow
}
