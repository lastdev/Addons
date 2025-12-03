--[[
                                ----o----(||)----oo----(||)----o----

                                        Dragons Tread Lightly
										
                                 A partial replacement for the Here
                                 Be Dragons translations for map pin
								coordinate routines and lookup tables

                                       v1.03 - 19th July 2025
                                Copyright (C) Taraezor / Chris Birch
                                         All Rights Reserved

                                ----o----(||)----oo----(||)----o----
]]

local addOnName, ns = ...
-- Make a shared data namespace
ns.DragonsTreadLightly = {}

-- Localisations
local Clamp = Clamp
local GetWorldPosFromMapPos = C_Map.GetWorldPosFromMapPos
local GetMapWorldSize = C_Map.GetMapWorldSize
local floor, insert, ipair, tostring = math.floor, table.insert, ipair, tostring

-- ---------------------------------------------------------------------------------------------------------------------------------
--== v1.03 - 19th July 2025
--* Using calculated values for the ns.DragonsTreadLightly.azeroth lookup table for Classic Mists for Northrend, EK, Kalimdor.
--*   Previously this data was visually estimated by trial and error. Calculation uses basic High School substitution algebra and
--*   is accurate to about 4/5 digits!

--== v1.02 - 29th June 2025
--* Zaralek Cavern added into the special table
--* Nazjatar added into the special table
--* New special table format due to Nazjatar being in two maps
--* New routine to manually add a child to a continent (again due to Nazjatar situation but now ready for others too)

--== v1.01 - 26th June 2025
--* Pandaria translations now based on calculations
--* Removed debug code that had been commented out
--* Localisations cleaned up

--== v1.00 - 5th June 2025
--* Initial release
-- ---------------------------------------------------------------------------------------------------------------------------------

local function DragonsTreadLightlyFill( mapID )

	-- Blizzard uses a cartesian system that is very different from that which we encountered at school/university.
	-- The top left of the screen is the origin. As we extend rightwards/horizontally the numbers become more negative.
	-- Likewise as we extend downwards/vertically the numbers become more negative.
	-- Additionally X is Y and Y is X in the traditional sense we encountered at school/university.
	-- It gets worse. Much worse...
	
	if not ns.DragonsTreadLightly[ tostring( mapID ) ] then
		-- Careful: Argus 905 and The Maelstrom 948 return bad results (and a couple of other obscure ones)
		
		local topLeft, botRight, instance, data, parent;
		
		if mapID == 947 then
			topLeft, botRight = { x=0, y=0 }, { x=0.99999, y=0.99999 }
		else
			instance, topLeft = GetWorldPosFromMapPos( mapID, { x=0, y=0 } )
			instance, botRight = GetWorldPosFromMapPos( mapID, { x=0.99999, y=0.99999 } )
			if not topLeft or not botRight then return end
		end
		
		-- Beware Torghast / The Maw (Infinite dungeon), The Deaths of Chromie and The Emerald Nightmare maps
		-- all throw up a lot of sizing discrepancies when compared with a simple manual topLeft/botRight calculation

		if ns.DragonsTreadLightly.transforms[ instance ] then
			for _, data in ipairs( ns.DragonsTreadLightly.transforms[ instance ] ) do
				-- There might be more than one map being repositioned and resized onto the target
				-- Actually this is only true of Azeroth as the target: Kalimdor and the Eastern Kingdoms, thus the range testing
				if topLeft.y <= data.maxX and botRight.y >= data.minX and topLeft.x <= data.maxY and botRight.x >= data.minY then
					instance = data.newInstanceID
					topLeft.y = topLeft.y + data.offsetX
					botRight.y = botRight.y + data.offsetX
					topLeft.x = topLeft.x + data.offsetY
					botRight.x = botRight.x + data.offsetY
					break
				end
			end
		end
		
		data = C_Map.GetMapInfo( mapID )
		if not data then return end
		parent = ( data == nil ) and 0 or ( ( data.parentMapID == nil ) and 0 or data.parentMapID )

--if mapID == 418 or mapID == 422 or mapID == 379 or mapID == 371 or mapID == 388 then
--	print(data.name.." 1="..(topLeft.y - botRight.y).." 2="..(topLeft.x - botRight.x).." 3="..topLeft.y.." 4="..topLeft.x)
--end
--Jade Forest		6983.2601318359		4654.1135253906		1452.0799560547		3652.080078125
--Kun-Lai Summit	6258.2674560547		4172.8782958984		4839.580078125		5618.75
--Townlong			5743.6923828125		3829.1247558594		7079.169921875		4558.330078125
--Krasarang			4687.4528808594		3124.9726715088		2947.919921875		-110.41600036621
--Dread Wastes		5352.0264892578		3568.7144775391		6139.580078125		1416.6700439453

		ns.DragonsTreadLightly[ tostring( mapID ) ] = { ns.Round( topLeft.y - botRight.y, 4 ),
					ns.Round( topLeft.x - botRight.x, 4 ), ns.Round( topLeft.y, 4 ), ns.Round( topLeft.x, 4 ),
					instance = instance, name = data.name, mapType = data.mapType, parent = parent }
	end
end

-- ---------------------------------------------------------------------------------------------------------------------------------

function ns.DragonsTreadLightlyCoords( coord, zoneO, zoneD )

	-- coord is 00000000 (xx.xx,yy.yy) format. Assumed good, no negatives
	-- Returns 00000000, 0 <= x <= 0.9999, 0 <= y <= 0.9999

	local x, y, instance, data = floor( coord / 10000 ) / 10000, ( coord % 10000 ) / 10000;
	if zoneO == zoneD then return coord, x, y end

	DragonsTreadLightlyFill( zoneO )
	DragonsTreadLightlyFill( zoneD )
	
    if zoneO == 947 or zoneD == 947 then	
		if ( zoneO ~= 947 and not ns.DragonsTreadLightly[ tostring( zoneO ) ] ) or
				( zoneD ~= 947 and not ns.DragonsTreadLightly[ tostring( zoneD ) ] ) then return nil, nil, nil end	
		instance = ( zoneO == 947 ) and ns.DragonsTreadLightly[ tostring( zoneD ) ].instance or
														ns.DragonsTreadLightly[ tostring( zoneO ) ].instance
		if not ns.DragonsTreadLightly.azeroth[ instance ] then return nil, nil, nil end
		if zoneO == 947 then
			data = ns.DragonsTreadLightly.azeroth[ instance ]
		else
			data = ns.DragonsTreadLightly[ tostring( zoneO ) ]
		end
		if not data then return nil, nil, nil end
		x, y = data[ 3 ] - data[ 1 ] * x, data[ 4 ] - data[ 2 ] * y
		if zoneO == 947 then
			data = ns.DragonsTreadLightly[ tostring( zoneD ) ]
		else
			data = ns.DragonsTreadLightly.azeroth[ instance ]
		end
		if not data then return nil, nil, nil end
		x, y = ( data[ 3 ] - x ) / data[ 1 ], ( data[ 4 ] - y ) / data[ 2 ]
	elseif ns.DragonsTreadLightly.special[ zoneO ] and ns.DragonsTreadLightly.special[ zoneO ][ zoneD ] then
		x = ( 1 - x ) * ns.DragonsTreadLightly.special[ zoneO ][ zoneD ][ 1 ] + x * ns.DragonsTreadLightly.special[ zoneO ][ zoneD ][ 2 ]
		y = ( 1 - y ) * ns.DragonsTreadLightly.special[ zoneO ][ zoneD ][ 3 ] + y * ns.DragonsTreadLightly.special[ zoneO ][ zoneD ][ 4 ]
	elseif not ns.DragonsTreadLightly[ tostring( zoneO ) ] or not ns.DragonsTreadLightly[ tostring( zoneD ) ] then
		return nil, nil, nil
	else
		data = ns.DragonsTreadLightly[ tostring( zoneO ) ]		
		if not data then return nil, nil, nil end
		x, y = data[ 3 ] - data[ 1 ] * x, data[ 4 ] - data[ 2 ] * y
		data = ns.DragonsTreadLightly[ tostring( zoneD ) ]		
		if not data then return nil, nil, nil end
		x, y = ( data[ 3 ] - x ) / data[ 1 ], ( data[ 4 ] - y ) / data[ 2 ]
	end
	if x < 0 or x >= 1 or y < 0 or y >= 1 then return nil, nil, nil end
	return floor( x * 10000 + 0.5 ) * 10000 + floor( y * 10000 + 0.5 ), x, y
end

function ns.DragonsTreadLightlyAddChildren( continentMapID, children )
	if continentMapID == 875 or continentMapID == 876 then -- Zandalar, KulTiras
		insert( children, { mapID=1355 } ) -- Nazjatar
	end
	return children
end

-- ---------------------------------------------------------------------------------------------------------------------------------

do	-- Fill the lookup tables

	-- This data handles the fact that the zones need to be placed within continents and continents need to be placed within the
	-- world and indeed the world map has been redrawn several times.
	-- Data copied from Here Be Dragons AddOn 2/6/2025 except Pandaria and Khaz Algar, which was estimated by sight
	-- v1.03 Recalculated Nothrend, EK, Kalimdor for Classic Mists. No longer purely sight based
	
	if ns.DragonsTreadLightly.azeroth then return end	
	ns.DragonsTreadLightly.azeroth = {}
	
	if ns.version < 30000 then				-- Width, Height, Left, Top. Reducing width/height actually increases it
		ns.DragonsTreadLightly.azeroth[0] = { 44688.53, 29791.24, 32681.47, 11479.44 }
		ns.DragonsTreadLightly.azeroth[1] = { 44878.66, 29916.10,  8723.96, 14824.53 }
	elseif ns.version < 50000 then
		ns.DragonsTreadLightly.azeroth[0] = { 48033.24, 32020.8, 36867.97, 14848.84 }
		ns.DragonsTreadLightly.azeroth[1] = { 47908.72, 31935.28, 8552.61, 18467.83 }
		ns.DragonsTreadLightly.azeroth[571] = { 47662.7, 31772.19, 25198.53, 11072.07 }
		ns.DragonsTreadLightly.azeroth[646] = { 52500, 35000, 27590, 19100 } -- Deepholm
	elseif ns.version < 60000 then
		ns.DragonsTreadLightly.azeroth[0] = { 57115, 38083, 46284, 15795 } -- Eastern Kingdom zones. v1.03
		ns.DragonsTreadLightly.azeroth[1] = { 58984, 39319, 10154, 19536 } -- Kalimdor zones. v1.03
		ns.DragonsTreadLightly.azeroth[571] = { 56338, 37568, 29893, 11497 } -- Northrend zones. v1.03
		ns.DragonsTreadLightly.azeroth[646] = { 52500, 35000, 26970, 17950 } -- Deepholm
		ns.DragonsTreadLightly.azeroth[870] = { 53101, 35407, 28649, 30726 } -- Pandaria zones v1.01 Calculated
   else
		ns.DragonsTreadLightly.azeroth[0] = { 76153.14, 50748.62, 65008.24, 23827.51 }
		ns.DragonsTreadLightly.azeroth[1] = { 77621.12, 51854.98, 12444.4, 28030.61 }
		ns.DragonsTreadLightly.azeroth[571] = { 71773.64, 50054.05, 36205.94, 12366.81 }
		ns.DragonsTreadLightly.azeroth[646] = { 52500, 35000, 24820, 17870 } -- Deepholm
		ns.DragonsTreadLightly.azeroth[870] = { 67710.54, 45118.08, 33565.89, 38020.67 }
		ns.DragonsTreadLightly.azeroth[1220] = { 82758.64, 55151.28, 52943.46, 24484.72 }
		ns.DragonsTreadLightly.azeroth[1642] = { 77933.3, 51988.91, 44262.36, 32835.1 }
		ns.DragonsTreadLightly.azeroth[1643] = { 76060.47, 50696.96, 55384.8, 25774.35 }
		ns.DragonsTreadLightly.azeroth[2444] = { 111420.37, 74283, 86088.21, 15682.4 }
		ns.DragonsTreadLightly.azeroth[2552] = { 82171.44, 54787.67, 21219.3, 47876.05 }
		ns.DragonsTreadLightly.azeroth[2601] = { 67929.29, 49267.42, 18325.63, 42233.06 }
	end
	
	-- Special Placements. Force a map's pins to appear on another map.
	-- 
	-- With the exception of the Isle of Dorn you'd not want Khaz Algar zones pins to ripple up to the Azeroth map
	-- Will need to be redesigned if either of the two maps gets altered between expansions
	-- Reminder: Nazjatar needs to be added to the children table for Kul Tiras and Zandalar
	ns.DragonsTreadLightly.special = {} -- L R T B
	ns.DragonsTreadLightly.special[ 207 ] = {} -- Deepholm
	ns.DragonsTreadLightly.special[ 207 ][ 948 ] = { 0.372, 0.65, 0.175, 0.395 } -- The Maelstrom
	ns.DragonsTreadLightly.special[ 1355 ] = {} -- Nazjatar
	ns.DragonsTreadLightly.special[ 1355 ][ 875 ] = { 0.808, 0.925, 0.0965, 0.2125 } -- Zandalar
	ns.DragonsTreadLightly.special[ 1355 ][ 876 ] = { 0.808, 0.925, 0.0965, 0.2125 } -- Kul Tiras
	ns.DragonsTreadLightly.special[ 2133 ] = {} -- Zaralek Cavern
	ns.DragonsTreadLightly.special[ 2133 ][ 1978 ] = { 0.7575, 0.99, 0.7145, 0.945 } -- Dragon Isles
	ns.DragonsTreadLightly.special[ 2214 ] = {} -- The Ringing Deeps 
	ns.DragonsTreadLightly.special[ 2214 ][ 2274 ] = { 0.363, 0.74, 0.42, 0.76 } -- Khaz Algar
	ns.DragonsTreadLightly.special[ 2215 ] = {} -- Hallowfall
	ns.DragonsTreadLightly.special[ 2215 ][ 2274 ] = { 0.18, 0.595, 0.33, 0.747 } -- Khaz Algar
	ns.DragonsTreadLightly.special[ 2248 ] = {} -- Isle of Dorn
	ns.DragonsTreadLightly.special[ 2248 ][ 2274 ] = { 0.5, 0.948, 0.01, 0.456 } -- Khaz Algar
	ns.DragonsTreadLightly.special[ 2255 ] = {} -- Azj-Kahet
	ns.DragonsTreadLightly.special[ 2255 ][ 2274 ] = { 0.27, 0.615, 0.579, 0.908 } -- Khaz Algar
	ns.DragonsTreadLightly.special[ 2256 ] = {} -- Lower Azj-Kahet
	ns.DragonsTreadLightly.special[ 2256 ][ 2274 ] = { 0.27, 0.615, 0.579, 0.908 } -- Khaz Algar
	ns.DragonsTreadLightly.special[ 2346 ] = {} -- Undermine
	ns.DragonsTreadLightly.special[ 2346 ][ 2274 ] = { 0.72, 0.92, 0.645, 0.84 } -- Khaz Algar
	
	-- map transform data extracted from UIMapAssignment.db2 (see HereBeDragons-Scripts on GitHub)
	-- format: instanceID, newInstanceID, minY, maxY, minX, maxX, offsetY, offsetX
	-- Taraezor: Copied from HereBeDragons-2.0.lua 2/6/2025

	ns.DragonsTreadLightly.transforms = {}
	if ns.version >= 20000 then
		ns.DragonsTreadLightly.transforms[ 530 ] = {
			{ newInstanceID = 0, minY = 4800, maxY = 16000,
								minX = -10133.3, maxX = -2666.67, offsetY = -2400, offsetX = 2400 },
			{ newInstanceID = 1, minY = -6933.33, maxY = 533.33,
								minX = -16000, maxX = -8000, offsetY = 9916, offsetX = 17600 } }
			
		if ns.version >= 30000 and ns.version < 40000 then
			ns.DragonsTreadLightly.transforms[ 609 ] = { { newInstanceID = 0, minY = -10000, maxY = 10000,
													minX = -10000, maxX = 10000, offsetY = 0, offsetX = 0 } }
		end
		
		ns.DragonsTreadLightly.transforms[ 732 ] = { { newInstanceID = 0, minY = -3200, maxY = 533.3,
				minX = -533.3, maxX = 2666.7, offsetY = -611.8, offsetX = 3904.3 } }
		ns.DragonsTreadLightly.transforms[ 1014 ] = { { newInstanceID = 870, minY = 3200, maxY = 5333.3,
				minX = 1066.7, maxX = 2666.7, offsetY = 0, offsetX = 0 } }
		ns.DragonsTreadLightly.transforms[ 1064 ] = { { newInstanceID = 870, minY = 5391, maxY = 8148,
				minX = 3518, maxX = 7655, offsetY = -2134.2, offsetX = -2286.6 } }
		ns.DragonsTreadLightly.transforms[ 1208 ] = { { newInstanceID = 1116, minY = -2666, maxY = -2133,
				minX = 0, maxX = 3200, offsetY = -2333.9, offsetX = 966.7 } }
		ns.DragonsTreadLightly.transforms[ 1498 ] = { { newInstanceID = 1220, minY = -533.3, maxY = 2133.3,
				minX = 3733.3, maxX = 5866.7, offsetY = 0, offsetX = 0 } }
		ns.DragonsTreadLightly.transforms[ 1545 ] = { { newInstanceID = 1220, minY = -2666.7, maxY = 0,
				minX = 4800, maxX = 8000, offsetY = 0, offsetX = 0 } }
		ns.DragonsTreadLightly.transforms[ 1599 ] = { { newInstanceID = 1, minY = 4800, maxY = 5866.7,
				minX = -4266.7, maxX = -3200, offsetY = -490.6, offsetX = -0.4 } }
		ns.DragonsTreadLightly.transforms[ 1609 ] = { { newInstanceID = 571, minY = 6400, maxY = 8533.3,
				minX = -1600, maxX = 533.3, offsetY = 512.8, offsetX = 545.3 } }
	end
end