local _, ns = ...
ns.continents = {}
ns.map = {}

-- Name Spaced data file for anything mapping related and which is common across my AddOns

if ( ns.version < 50000) then
	ns.continents[ 1414 ] = true -- Kalimdor
	ns.continents[ 1415 ] = true -- Eastern Kingdoms
else
	ns.continents[ 12 ] = true -- Kalimdor
	ns.continents[ 13 ] = true -- Eastern Kingdoms
end
if ( ns.version < 50000) then
	ns.continents[ 1945 ] = ( ns.version >= 20000) and true or nil -- Outland
elseif ( ns.version >= 60000) then
	ns.continents[ 101 ] = true -- Outland
else
	ns.continents[ 1467 ] = true -- Outland
end
ns.continents[ 113 ] = ( ns.version >= 30000) and true or nil -- Northrend
ns.continents[ 203 ] = ( ns.version >= 40000) and true or nil -- Vashj'ir
ns.continents[ 948 ] = ( ns.version >= 40000) and true or nil -- The Maelstrom
ns.continents[ 424 ] = ( ns.version >= 50000) and true or nil -- Pandaria
ns.continents[ 572 ] = ( ns.version >= 60000) and true or nil -- Draenor
ns.continents[ 619 ] = ( ns.version >= 70000) and true or nil -- Broken Isles
ns.continents[ 875 ] = ( ns.version >= 80000) and true or nil -- Zandalar
ns.continents[ 876 ] = ( ns.version >= 80000) and true or nil -- Kul Tiras
ns.continents[ 1550 ] = ( ns.version >= 90000) and true or nil -- Shadowlands
ns.continents[ 1978 ] = ( ns.version >= 100000) and true or nil -- Dragon Isles
ns.continents[ 2274 ] = ( ns.version >= 110000) and true or nil -- Khaz Algar
ns.continents[ 947 ] = true -- Azeroth

--==================================================================================================================================
--
-- KALIMDOR
--
--==================================================================================================================================

ns.map.ashenvale = ( ns.version < 50000 ) and 1440 or 63
ns.map.azshara = ( ns.version < 50000 ) and 1447 or 76
ns.map.azuremyst = ( ns.version < 50000 ) and 1943 or 97
ns.map.barrens = ( ns.version < 50000 ) and 1413 or 10 -- In Classic Cata it's called "The Barrens". Retail it's "Northern Barrens"
ns.map.bloodmyst = ( ns.version < 50000 ) and 1950 or 106
ns.map.darkshore = ( ns.version < 50000 ) and 1439 or 62
ns.map.darnassus = ( ns.version < 50000 ) and 1457 or 89
ns.map.desolace = ( ns.version < 50000 ) and 1443 or 66
ns.map.durotar = ( ns.version < 50000 ) and 1411 or 1
ns.map.dustwallow = ( ns.version < 50000 ) and 1445 or 70
ns.map.felwood = ( ns.version < 50000 ) and 1448 or 77
ns.map.feralas = ( ns.version < 50000 ) and 1444 or 69
ns.map.moonglade = ( ns.version < 50000 ) and 1450 or 80
ns.map.mulgore = ( ns.version < 50000 ) and 1412 or 7
ns.map.orgrimmar = ( ns.version < 50000 ) and 1454 or 85
ns.map.silithus = ( ns.version < 50000 ) and 1451 or 81
ns.map.stonetalon = ( ns.version < 50000 ) and 1442 or 65
ns.map.tanaris = ( ns.version < 50000 ) and 1446 or 71
ns.map.teldrassil = ( ns.version < 50000 ) and 1438 or 57
ns.map.theExodar = ( ns.version < 50000 ) and 1947 or 103
ns.map.thousand = ( ns.version < 50000 ) and 1441 or 64
ns.map.thunder = ( ns.version < 50000 ) and 1456 or 88
ns.map.ungoro = ( ns.version < 50000 ) and 1449 or 78
ns.map.winterspring = ( ns.version < 50000 ) and 1452 or 83
ns.map.kalimdor = ( ns.version < 50000 ) and 1414 or 12

--==================================================================================================================================
--
-- EASTERN KINGDOMS
--
--==================================================================================================================================

ns.map.alterac = ( ns.version < 50000 ) and 1416
ns.map.arathi = ( ns.version < 50000 ) and 1417 or 14
ns.map.badlands = ( ns.version < 50000 ) and 1418 or 15
ns.map.blastedLands = ( ns.version < 50000 ) and 1419 or 17
ns.map.burningSteppes = ( ns.version < 50000 ) and 1428 or 36
ns.map.deadwind = ( ns.version < 50000 ) and 1430 or 42
ns.map.dunMorogh = ( ns.version < 50000 ) and 1426 or 27
ns.map.duskwood = ( ns.version < 50000 ) and 1431 or 47
ns.map.easternP = ( ns.version < 50000 ) and 1423 or 23
ns.map.elwynn = ( ns.version < 50000 ) and 1429 or 37
ns.map.eversong = ( ns.version < 50000 ) and 1941 or 94
ns.map.ghostlands = ( ns.version < 50000 ) and 1942 or 95
ns.map.hillsbrad = ( ns.version < 50000 ) and 1424 or 25
ns.map.ironforge = ( ns.version < 50000 ) and 1455 or 87
ns.map.lochModan = ( ns.version < 50000 ) and 1432 or 48
ns.map.northStrangle = ( ns.version < 50000 ) and 1434 or 50 -- 1434 is listed as "stranglethorne"
ns.map.redridge = ( ns.version < 50000 ) and 1433 or 49
ns.map.searingGorge = ( ns.version < 50000 ) and 1427 or 32
ns.map.silvermoon = ( ns.version < 50000 ) and 1954 or 110
ns.map.silverpine = ( ns.version < 50000 ) and 1421 or 21
ns.map.stormwind = ( ns.version < 50000 ) and 1453 or 84
ns.map.swampOS = ( ns.version < 50000 ) and 1435 or 51
ns.map.TheHinter = ( ns.version < 50000 ) and 1425 or 26
ns.map.tirisfal = ( ns.version < 50000 ) and 1420 or 18
ns.map.undercity = ( ns.version < 50000 ) and 1458 or ( ( ns.version < 60000 ) and 998 or 90 )
ns.map.westernP = ( ns.version < 50000 ) and 1422 or 22
ns.map.westfall = ( ns.version < 50000 ) and 1436 or 52
ns.map.wetlands = ( ns.version < 50000 ) and 1437 or 56
ns.map.easternK = ( ns.version < 50000 ) and 1415 or 13

--==================================================================================================================================
--
-- OUTLAND
--
--==================================================================================================================================

ns.map.bladesEdge = ( ns.version < 50000 ) and 1949 or 105
ns.map.hellfire = ( ns.version < 50000 ) and 1944 or 100
ns.map.nagrand = ( ns.version < 50000 ) and 1951 or 107
ns.map.netherstorm = ( ns.version < 50000 ) and 1953 or 109
ns.map.shadowmoon = ( ns.version < 50000 ) and 1948 or 104
ns.map.shattrath = ( ns.version < 50000 ) and 1955 or 111
ns.map.terokkar = ( ns.version < 50000 ) and 1952 or 108
ns.map.zangarmarsh = ( ns.version < 50000 ) and 1946 or 102
ns.map.outland = ( ns.version < 50000 ) and 1945 or  ( ( ns.version < 60000 ) and 1467 or 101 )