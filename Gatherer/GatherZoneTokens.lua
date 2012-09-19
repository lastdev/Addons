--[[
	Gatherer Addon for World of Warcraft(tm).
	Version: 4.0.2 (<%codename%>)
	Revision: $Id: GatherZoneTokens.lua 972 2012-09-03 02:03:15Z Esamynn $

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GPL.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

	Note:
		This AddOn's source code is specifically designed to work with
		World of Warcraft's interpreted AddOn system.
		You have an implicit licence to use this AddOn with these facilities
		since that is it's designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat

	Functions for converting to and from the locale independent zone tokens
--]]
Gatherer_RegisterRevision("$URL: http://svn.norganna.org/gatherer/trunk/Gatherer/GatherZoneTokens.lua $", "$Rev: 972 $")

-- reference to the Astrolabe mapping library
local Astrolabe = DongleStub(Gatherer.AstrolabeVersion)

local _tr = Gatherer.Locale.Tr
local _trC = Gatherer.Locale.TrClient
local _trL = Gatherer.Locale.TrLocale

local metatable = { __index = getfenv(0) }
setmetatable( Gatherer.ZoneTokens, metatable )
setfenv(1, Gatherer.ZoneTokens)

local MapIdToTokenMap = {
	-- Kalimdor
		[772] = "AHNQIRAJ_THE_FALLEN_KINGDOM",
		[894] = "AMMEN_VALE",
		[43]  = "ASHENVALE",
		[181] = "AZSHARA",
		[464] = "AZUREMYST_ISLE",
		[476] = "BLOODMYST_ISLE",
		[890] = "CAMP_NARACHE",
		[42]  = "DARKSHORE",
		[381] = "DARNASSUS",
		[101] = "DESOLACE",
		[4]   = "DUROTAR",
		[141] = "DUSTWALLOW_MARSH",
		[891] = "ECHO_ISLES",
		[471] = "EXODAR",
		[182] = "FELWOOD",
		[121] = "FERALAS",
		[241] = "MOONGLADE",
		[606] = "MOUNT_HYJAL",
		[9]   = "MULGORE",
		[11]  = "NORTHERN_BARRENS",
		[321] = "ORGRIMMAR",
		[888] = "SHADOWGLEN",
		[261] = "SILITHUS",
		[607] = "SOUTHERN_BARRENS",
		[81]  = "STONETALON_MOUNTAINS",
		[161] = "TANARIS",
		[41]  = "TELDRASSIL",
		[61]  = "THOUSAND_NEEDLES",
		[362] = "THUNDER_BLUFF",
		[720] = "ULDUM",
		[201] = "UNGORO_CRATER",
		[889] = "VALLEY_OF_TRIALS",
		[281] = "WINTERSPRING",

	-- Eastern Kingdoms
		[614] = "ABYSSAL_DEPTHS",
		[16]  = "ARATHI_HIGHLANDS",
		[17]  = "BADLANDS",
		[19]  = "BLASTED_LANDS",
		[29]  = "BURNING_STEPPES",
		[673] = "CAPE_OF_STRANGLETHORN",
		[866] = "COLDRIDGE_VALLEY",
		[32]  = "DEADWIND_PASS",
		[892] = "DEATHKNELL",
		[27]  = "DUN_MOROGH",
		[34]  = "DUSKWOOD",
		[23]  = "EASTERN_PLAGUELANDS",
		[30]  = "ELWYNN_FOREST",
		[462] = "EVERSONG_WOODS",
		[463] = "GHOSTLANDS",
		[24]  = "HILLSBRAD_FOOTHILLS",
		[26]  = "HINTERLANDS",
		[341] = "IRONFORGE",
		[610] = "KELPTHAR_FOREST",
		[35]  = "LOCH_MODAN",
		[895] = "NEW_TINKERTOWN",
		[37]  = "NORTHERN_STRANGLETHORN",
		[864] = "NORTHSHIRE",
		[499] = "QUEL_DANAS",
		[36]  = "REDRIDGE_MOUNTAINS",
		[684] = "RUINS_OF_GILNEAS",
		[685] = "RUINS_OF_GILNEAS_CITY",
		[28]  = "SEARING_GORGE",
		[615] = "SHIMMERING_EXPANSE",
		[480] = "SILVERMOON",
		[21]  = "SILVERPINE_FOREST",
		[301] = "STORMWIND",
		[689] = "STRANGLETHORN_VALE",
		[893] = "SUNSTRIDER_ISLE",
		[38]  = "SWAMP_OF_SORROWS",
		[20]  = "TIRISFAL_GLADES",
		[708] = "TOL_BARAD",
		[709] = "TOL_BARAD_PENINSULA",
		[700] = "TWILIGHT_HIGHLANDS",
		[382] = "UNDERCITY",
		[613] = "VASHJIR",
		[22]  = "WESTERN_PLAGUELANDS",
		[39]  = "WESTFALL",
		[40]  = "WETLANDS",

	-- Outland
		[475] = "BLADES_EDGE_MOUNTAINS",
		[465] = "HELLFIRE_PENINSULA",
		[477] = "NAGRAND",
		[479] = "NETHERSTORM",
		[473] = "SHADOWMOON_VALLEY",
		[481] = "SHATTRATH",
		[478] = "TEROKKAR_FOREST",
		[467] = "ZANGARMARSH",

	-- Northrend
		[486] = "BOREAN_TUNDRA",
		[510] = "CRYSTALSONG_FOREST",
		[504] = "DALARAN",
		[488] = "DRAGONBLIGHT",
		[490] = "GRIZZLY_HILLS",
		[491] = "HOWLING_FJORD",
		[541] = "HROTHGARS_LANDING",
		[492] = "ICECROWN_GLACIER",
		[501] = "LAKE_WINTERGRASP",
		[493] = "SHOLAZAR_BASIN",
		[495] = "STORM_PEAKS",
		[496] = "ZULDRAK",

	-- The Maelstrom
		[640] = "DEEPHOLM",
		[605] = "KEZAN",
		[544] = "LOST_ISLES",
		[737] = "MAELSTROM",

	-- Pandaria
		[858] = "DREAD_WASTES",
		[806] = "JADE_FOREST",
		[857] = "KRASARANG_WILDS",
		[809] = "KUNLAI_SUMMIT",
		[905] = "SHRINE_OF_SEVEN_STARS",
		[903] = "SHRINE_OF_TWO_MOONS",
		[810] = "TOWNLONG_STEPPES",
		[811] = "VALE_OF_ETERNAL_BLOSSOMS",
		[807] = "VALLEY_OF_THE_FOUR_WINDS",
		[873] = "VEILED_STAIR",
}

Tokens = {}
TokensByContinent = {}
TokenToMapID = {}
ZoneNames = {GetMapContinents()}

unrecognizedZones = {}

Ver3To4TempTokens = {
	["AhnQirajTheFallenKingdom"] = "AHNQIRAJ_THE_FALLEN_KINGDOM",
	["Uldum"] = "ULDUM",
	["SouthernBarrens"] = "SOUTHERN_BARRENS",
	["Orgrimmar"] = "ORGRIMMAR",
	["Hyjal_terrain1"] = "MOUNT_HYJAL",
	["Darnassus"] = "DARNASSUS",
	["VashjirRuins"] = "SHIMMERING_EXPANSE",
	["StormwindCity"] = "STORMWIND",
	["RuinsofGilneasCity"] = "RUINS_OF_GILNEAS_CITY",
	["StranglethornVale"] = "STRANGLETHORN_VALE",
	["TwilightHighlands"] = "TWILIGHT_HIGHLANDS",
	["VashjirKelpForest"] = "KELPTHAR_FOREST",
	["HillsbradFoothills"] = "HILLSBRAD_FOOTHILLS",
	["StranglethornJungle"] = "NORTHERN_STRANGLETHORN",
	["RuinsofGilneas"] = "RUINS_OF_GILNEAS",
	["Vashjir"] = "VASHJIR",
	["TolBaradDailyArea"] = "TOL_BARAD_PENINSULA",
	["TolBarad"] = "TOL_BARAD",
	["TheCapeOfStranglethorn"] = "CAPE_OF_STRANGLETHORN",
	["VashjirDepths"] = "ABYSSAL_DEPTHS",
	["Kezan"] = "KEZAN",
	["TheLostIsles"] = "LOST_ISLES",
	["Deepholm"] = "DEEPHOLM",
	["TheMaelstrom"] = "MAELSTROM",
}

for continent, zones in pairs(Astrolabe.ContinentList) do
	local continentZoneNames = {GetMapZones(continent)}
	ZoneNames[continent] = { CONTINENT = ZoneNames[continent] }
	local tokenMap = {}
	for index, mapID in pairs(zones) do
		if ( index > 0 ) then
			local zoneToken
			if not ( MapIdToTokenMap[mapID] ) then
				-- use the mapID as a temporary token and 
				zoneToken = mapID;
				table.insert(unrecognizedZones, continentZoneNames[index])
			else
				zoneToken = MapIdToTokenMap[mapID]
			end
			Tokens[zoneToken] = zoneToken
			Tokens[mapID] = zoneToken
			tokenMap[index] = zoneToken
			tokenMap[zoneToken] = index
			TokenToMapID[zoneToken] = mapID
			
			ZoneNames[continent][zoneToken] = continentZoneNames[index]
			ZoneNames[zoneToken] = continentZoneNames[index]
			ZoneNames[continentZoneNames[index]] = zoneToken
		end
	end
	TokensByContinent[continent] = tokenMap
end

if ( next(unrecognizedZones) ) then
	-- some zones were unrecognized, warn user
	local zoneList = string.join(", ", unpack(unrecognizedZones))
	Gatherer.Locale.SECTION_HIGHLIGHT_CODE = HIGHLIGHT_FONT_COLOR_CODE
	Gatherer.Notifications.AddInfo(_tr("ZONETOKENS_UNIDENTIFIED_ZONES_WARNING", zoneList))
end
unrecognizedZones = nil

function GetZoneTokenByContZone( continent, zone )
	if not ( TokensByContinent[continent] ) then
		return nil
	end
	local val = TokensByContinent[continent][zone]
	if ( val ) then
		if ( type(zone) == "number" ) then
			return val
		else
			return zone
		end
	else
		-- try other sources
		val = Ver3To4TempTokens[zone]
		if ( val ) then
			return val
		end
	end
end

function GetContinentAndZone( token )
	for continent, zoneTokens in pairs(TokensByContinent) do
		if ( zoneTokens[token] ) then
			return continent, zoneTokens[token]
		end
	end
end

function GetZoneIndex( continent, token )
	if not ( Tokens[continent] ) then
		return nil
	end
	local val = Tokens[continent][token]
	if ( val ) then
		if ( type(token) == "string" ) then
			return val
		else
			return token
		end
	end
end

function GetZoneMapID( continent, token )
	local zone = nil
	if ( Tokens[continent] ) then
		zone = Tokens[continent][token]
	end
	if ( type(zone) ~= "number" and type(token) == "number" ) then
		zone = Tokens[continent][Tokens[continent][token]]
	end
	return Astrolabe:GetMapID(continent, zone)
end

function GetZoneMapIDAndFloor( mapToken )
	local mapID = TokenToMapID[mapToken]
	if ( mapID ) then
		return mapID, ((Astrolabe:GetNumFloors(mapID) == 0) and 0 or 1)
	end
end

function GetZoneToken( mapID )
	return Tokens[mapID]
end
