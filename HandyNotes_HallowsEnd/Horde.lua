
if UnitFactionGroup("player") ~= "Horde" then return end


local _, HallowsEnd = ...
local points = HallowsEnd.points
-- points[<mapfile>] = { [<coordinates>] = <quest ID> }


----------------------
-- Eastern Kingdoms --
----------------------
points["Arathi"] = {
	[69003340] = 12380, -- Hammerfall
}

points["Badlands"] = {
	[65903580] = 28955, -- Fuselight
	[18304280] = 28957, -- New Kargath
}

points["BlastedLands"] = {
	[40501140] = 28959, -- Dreadmaul Hold
}

points["EasternPlaguelands"] = {
	[75605240] = 12402, -- Light's Hope Chapel
}

points["EversongWoods"] = {
	[48204780] = 12364, -- Falconwing Square
	[43707110] = 12365, -- Fairbreeze Village
}

points["Ghostlands"] = {
	[48603200] = 12373, -- Tranquillien
}

points["HillsbradFoothills"] = {
	[57804720] = 12376, -- Tarren Mill
	[60306380] = 28962, -- Eastpoint Tower
}

points["Hinterlands"] = {
	[78208140] = 12387, -- Revantusk Village
	[31905790] = 28971, -- Hiri'watha Research Station
}

points["SearingGorge"] = {
	[39486602] = 28965, -- Iron Summit
}

points["SilvermoonCity"] = {
	[79605790] = 12369, -- The Royal Exchange
	[67607320] = 12370, -- The Bazaar
}

points["Silverpine"] = {
	[46404280] = 12371, -- The Selpucher
	[44302040] = 28966, -- Forsaken Rear Guard
}

points["StranglethornJungle"] = {
	[37305170] = 12382, -- Grom'gol Base Camp
}

points["SwampOfSorrows"] = {
	[46905670] = 12384, -- Stonard
	[71641408] = 28967, -- Bogpaddle
}

points["TheCapeOfStranglethorn"] = {
	[40927374] = 12397, -- Booty Bay
	[35102720] = 28969, -- Hardwrench Hideaway
}

points["Tirisfal"] = {
	[60905150] = 12363, -- Brill
	[83007200] = 28972, -- The Bulwark
}

points["Undercity"] = {
	[67703790] = 12368, -- Trade Quarter
}

points["WesternPlaguelands"] = {
	[48206370] = 28987, -- Andorhal
}


--------------
-- Kalimdor --
--------------
points["Ashenvale"] = {
	[73906070] = 12377, -- Splintertree Post
	[50206720] = 28953, -- Silverwind Refuge
	[38604240] = 28958, -- Hellscream's Watch
	[13003410] = 28989, -- Zoram'gar Outpost
}

points["Aszhara"] = {
	[57105020] = 28992, -- Bilgewater Harbour
}

points["Barrens"] = {
	[49505800] = 12374, -- The Crossroads
	[67307470] = 12396, -- Ratchet
	[56304010] = 29002, -- Grol'dom Farm
	[62501660] = 29003, -- Nozzlepot's Outpost
}

points["Desolace"] = {
	[24106830] = 12381, -- Shadowprey Village
	[56805000] = 28993, -- Karnum's Glade
}

points["Durotar"] = {
	[51604170] = 12361, -- Razor Hill
}

points["Dustwallow"] = {
	[36803240] = 12383, -- Brackenwall Village
	[41907410] = 12398, -- Mudsprocket
}

points["Felwood"] = {
	[44602890] = 28994, -- Whisperwind Grove
}

points["Feralas"] = {
	[74804510] = 12386, -- Camp Mojache
	[41401560] = 28996, -- Camp Ataya
	[51904770] = 28998, -- Stonemaul Hold
}

points["Mulgore"] = {
	[46806040] = 12362, -- Bloodhoof Village
}

points["Orgrimmar"] = {
	[53807880] = 12366, -- The Valley of Strength
}

points["Silithus"] = {
	[55503670] = 12401, -- Cenarion Hold
}

points["SouthernBarrens"] = {
	[39302010] = 29004, -- Hunter's Hill
	[40706930] = 29005, -- Desolation Hold
}

points["StonetalonMountains"] = {
	[50406380] = 12378, -- Sun Rock Retreat
	[66506420] = 29009, -- Krom'gar Fortress
}

points["Tanaris"] = {
	[52602710] = 12399, -- Gadgetzan
	[55706090] = 29014, -- Bootlegger Outpost
}

points["ThunderBluff"] = {
	[45706450] = 12367, -- Lower Rise
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
	[53405550] = 12393, -- Thunderlord Stronghold
	[76206040] = 12394, -- Mok'Nathal Village
	[62903830] = 12406, -- Evergrove
}

points["Hellfire"] = {
	[56803750] = 12388, -- Thrallmar
	[26905960] = 12389, -- Falcon Watch
}

points["Nagrand"] = {
	[56703460] = 12392, -- Garadar
}

points["Netherstorm"] = {
	[32006440] = 12407, -- Area 52
	[43403610] = 12408, -- The Stormspire
}

points["ShadowmoonValley"] = {
	[30302780] = 12395, -- Shadowmoon Village
	[61002820] = 12409, -- Altar of Sha'tar
	[56305980] = 12409, -- Sanctum of the Stars
}

points["ShattrathCity"] = {
	[28104900] = 12404, -- Aldor Rise
	[56208180] = 12404, -- Scryer's Tier
}

points["TerokkarForest"] = {
	[48804520] = 12391, -- Stonebreaker Hold
}

points["Zangarmarsh"] = {
	[30705090] = 12390, -- Zabra'jin Village
	[78506290] = 12403, -- Cenarion Refuge
}


---------------
-- Northrend --
---------------
points["BoreanTundra"] = {
	[78404920] = 13460, -- Unu'pe
	[76703740] = 13467, -- Taunka'le Village
	[41805440] = 13468, -- Warsong Hold
	[49701000] = 13501, -- Bor'gorok Outpost
}

points["Dalaran"] = {
	[48304080] = 13463, -- The Ledgerdemain Lounge
	[37805990] = 13472, -- The Underbelly
	[66603010] = 13474, -- Sunreaver's Sanctuary
}

points["Dragonblight"] = {
	[60105350] = 13456, -- Wyrmrest Temple
	[48207470] = 13459, -- Moa'ki Harbour
	[37804640] = 13469, -- Agmar's Hammer
	[76806320] = 13470, -- Venomspite
}

points["GrizzlyHills"] = {
	[20906470] = 12946, -- Conquest Hold
	[65404700] = 12947, -- Camp Oneqwah
}

points["HowlingFjord"] = {
	[25405980] = 13452, -- Kamagua
	[49501090] = 13464, -- Camp Winterhoof
	[52106620] = 13465, -- New Agamand
	[79203050] = 13466, -- Vengeance Landing
}

points["SholazarBasin"] = {
	[26705920] = 12950, -- Nesingwary Base Camp
}

points["TheStormPeaks"] = {
	[41108590] = 13461, -- K3
	[30903720] = 13462, -- Bouldercrag's Refuge
	[67605060] = 13471, -- Camp Tunka'lo
	[37104960] = 13548, -- Grom'arsh Crash Site
}

points["ZulDrak"] = {
	[59305720] = 12940, -- Zim'Torga
	[40806600] = 12941, -- The Argent Stand
}


---------------
-- Cataclysm --
---------------
points["Deepholm"] = {
	[51205000] = 29019, -- Temple of Earth
}

points["Hyjal"] = {
	[63002410] = 28999, -- Nordrassil
	[18703730] = 29000, -- Grove of Aessina
	[42704560] = 29001, -- Shrine of Aviana
}

points["TwilightHighlands"] = {
	[53404290] = 28973, -- Blood Gulch
	[45107670] = 28974, -- Crush Blow
	[75401650] = 28976, -- The Krazzworks
}

points["Uldum"] = {
	[26600730] = 29016, -- Oasis of Vir'sar
	[54703300] = 29017, -- Ramkahen
}

points["VashjirDepths"] = {
	[51306060] = 28986, -- Tenebrous Caverns
}

points["VashjirKelpForest"] = {
	[63406020] = 28981, -- Deepmist Grotto
}

points["VashjirRuins"] = {
	[49204190] = 28982, -- Silver Tide Hollow
	[51506250] = 28984, -- Legion's Rest
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
	[61002500] = 32047, -- Thunder Cleft
	[28005100] = 32020, -- Dawnchaser Retreat
}

points["KunLaiSummit"] = {
	[73009200] = 32039, -- Binan Village
	[64006100] = 32041, -- The Grummle Bazaar
	[57006000] = 32037, -- One Keg
	[63008100] = 32040, -- Eastwind Rest
	[62002900] = 32051, -- Zouchin Village
}

points["TheHiddenPass"] = {
	[55007200] = 32026, -- Tavern in the Mists
}

points["TheJadeForest"] = {
	[46004400] = 32027, -- Dawn's Blossom
	[48003500] = 32029, -- Greenstone Village
	[55006300] = 32032, -- Jade Temple Grounds
	[29001000] = 32050, -- Honeydew Village
	[28004700] = 32028, -- Grookin Hill
	[56002400] = 32031, -- Sri-La Village
	[42002300] = 32021, -- Tian Monastery
}

points["TownlongWastes"] = {
	[71005800] = 32043, -- Longying Outpost
}

points["ValeofEternalBlossoms"] = {
	[35157775] = 32044, -- Mistfall Village
	[61981626] = 32022, -- Shrine of Two Moons
}

points["ValleyoftheFourWinds"] = {
	[84002000] = 32048, -- Pang's Stead
	[20005600] = 32046, -- Stoneplow
}
