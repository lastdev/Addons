--[[
                                ----o----(||)----oo----(||)----o----

                                          Functions_Common

                                      v2.06 - 1st November 2025
                                Copyright (C) Taraezor / Chris Birch
                                         All Rights Reserved

                                ----o----(||)----oo----(||)----o----
]]

-- Summary:

-- Available functions:

	-- ns.StringSubstitutions( inputText )
		-- Looks for %xx fields within text and substitutes it with \cFFHHHHHH as necessary
		
	-- ns.PassGeneralChecks( table )
		-- Checks for .version, .versionUnder, .class, .faction, .race, .outdoors, .noAzeroth, .noContinent, .alwaysShow
		-- checks against globals such as ns.version and ns.mapID, _G[ ns.db ] values and API calls
		-- Returns true or false
		
	-- ns.Round( number, places )
		-- Rounds half AWAY from zero. -0.5 to -1.0, 0.5 to 1, 1.4 to 1, 2.6 to 3, -0.3 to 0, -2.7 to -3.
		-- Blizzard rounds half toward positive infinity. Wowhead rounds halves to even.
		-- Assumes type( number/places ) == "number" or else will abend.
		-- For input mmmmm.dddddd, m is ignored and only d is rounded to the requested places
		
	-- ns.pluginHandler:Refresh()
		-- Invoked by HandyNotes
		-- Events_Common causes HandyNotes refresh cycling to occur every 10s rather than every 1 to 3 100ths of a second.
		-- This throttling causes the Minimap pin show/hide to be rather delayed.
		-- The purpose is to reduce the impact on a player's fps, especially on potato PCs. The AddOn might need to
		-- process hundreds of pins per cycle.
		-- A future update is planned to allow player's to adjust the 10s timing.
		-- There is additional (arbitrary) throttling to allow for rogue server/client delays on loading screens
		
	-- ns.handyNotesPinIterator( t, prev )
		-- Also required by HandyNotes. THIS is the key routine that's invoked every 10 seconds to refresh the pin show/hide.
		-- ns.PassGeneralChecks( pin ) is called here always.
		-- ns.PassAdditionalEventChecks( pin ) is invoked as necessary. It's in the Functions_Events file
		-- ns.PassAdditionalAddOnSpecificChecks( pin ) is invoked as necessary. It's in the AddOn's Core file
		-- The AddOn is assumed to have it's pin textures organised into pin "series".
		
	-- ns.pluginHandler:OnEnable()
		-- Sets up the Continent and World Map pin tables from all of their children zones. See notes below
		
	-- ns.pluginHandler:GetNodes2( mapID )
		-- Required by HandyNotes
		
	-- ns.GuideTip( pin, colour )
		-- See notes below
		
	-- ns.pluginHandler:OnEnter( mapFile, coord )
		-- Required by HandyNotes
		-- THIS is the routine that has the tooltip line showing and formatting
		-- Looks for a pin.title and pin.name to show
		-- Invokes ns.AddOnEventTooltipLines( pin ) in Functions_Events as necessary
		-- Invokes ns.AddOnSpecificTooltipLines( pin ) in the AddOn's Core file as necessary
		-- Then shows any pin.guide and pin.tip, pin.noZidormi, pin.author and then coordinates

	-- ns.pluginHandler:OnLeave()
		-- Required by HandyNOtes. Hides the Tooltip although it's totally unnecessary in practice
		
	-- AdOn compartment is supported
		-- Left mouse click goes to the AddOn's general panel. Right click to a textures panel
		
	-- Slash commands
		-- Defined at the top of the AddOn's Data file

local addOnName, ns = ...

-- Localisations
local GetAddOnMetadata = C_AddOns.GetAddOnMetadata
local GetAuraDataByIndex= C_UnitAuras.GetAuraDataByIndex
local GetBestMapForUnit = C_Map.GetBestMapForUnit
local GetMapChildrenInfo = C_Map.GetMapChildrenInfo
local GetTime = GetTime
local GetWorldPosFromMapPos = C_Map.GetWorldPosFromMapPos
local IsOutdoors = IsOutdoors
local ceil, cos, fastrandom, find, floor, gsub, ipairs, next, sin =
		ceil, math.cos, fastrandom, string.find, floor, string.gsub, ipairs, next, math.sin

local LibStub = _G.LibStub
local HandyNotes = _G.HandyNotes

-- ---------------------------------------------------------------------------------------------------------------------------------

-- The original text will have "%xx" and it will be converted here
-- Supported fields in the Common module: pin.guide, pin.tip, pin.title, pin.name, ns.eventName, and series .title
-- Supported fields in the Options_Common and Options_Events files: All field names and field tooltips
-- Supported fields in the Event module: Used in GetCriteriaName() - thus any achievement criteria name source
-- Non event AddOns: See APLT for "series" examples".

function ns.StringSubstitutions( inputText )

	local hash = gsub( inputText, "%%cr", ns.colour.prefix )
	hash = gsub( hash, "%%ch", ns.colour.highlight )
	hash = gsub( hash, "%%cp", ns.colour.plaintext )
	
	hash = gsub( hash, "%%up", ns.name )
	hash = gsub( hash, "%%ut", ( UnitName( "target" ) or "target" ) )
	hash = gsub( hash, "%%uu", ( UnitName( "target" ) or ns.name ) )
	
	hash = gsub( hash, "%%t(%a%a)", function( n ) return ns.colour[ n ] end)

	return hash
end

function ns.PassGeneralChecks( pin ) -- Must be kept lean and mean as it is invoked everywhere and often for each pin

	if ns.mapID ~= 947 or ( pin.noAzeroth == nil and _G[ ns.db ].ShowAzeroth == true ) then
		if ( ns.continents[ ns.mapID ] == nil ) or ( pin.noContinent == nil and _G[ ns.db ].ShowContinents == true ) then
			if ( pin.version == nil ) or ( ns.version >= pin.version ) then
				if ( pin.versionUnder == nil ) or ( ns.version < pin.versionUnder ) then
					if ( pin.class == nil) or ( pin.class == ns.class ) then
						if ( pin.faction == nil ) or ( ( pin.faction == "Horde" ) and ( ns.faction == "Horde" ) ) or
									( ( pin.faction == "Alliance" ) and ( ns.faction == "Alliance" ) ) then
							if ( pin.race == nil ) or ( pin.race == ns.race ) then
								if ( pin.outdoors == nil ) or ( pin.outdoors == IsOutdoors() ) then
									return true
								end
							end
						end
					end
				end
			end
		end
	end
	
	return false
end

function ns.Round( num, places ) -- Rounds halves away from zero. See notes above
	if num < 0 then
		return ceil( ( num * 10^places ) - .5 ) / 10^places
	end
	return floor( num * 10^places + .5 ) / 10^places
end

-- ---------------------------------------------------------------------------------------------------------------------------------

-- The pin clustering system allows for a central pin with coordinates on a map to in turn be surrounded by several other pins, all
-- in equidistant intervals in a circle pattern. Pin textures are allocated randomly and if there are sufficient textures then each
-- pin will have a unique texture.

ns.cluster, ns.clusterCoords = {}, {}

local function NewClusterPins()

	-- Executed each refresh
	-- ns.clusterNames and ns.clusterMapping are from Data_xxx if indeed it has pin clusters
	
	if ns.clusterNames == nil then return end
	
	local usedIndexes = {}
	
	local function UniqueTextureIndex()
		while true do
			local i = fastrandom( ns.clusterMapping[ 1 ], ns.clusterMapping[ 2 ] )
			if ( ns.clusterMapping[ 2 ] - ns.clusterMapping[ 1 ] + 1 ) >= #ns.clusterNames then
				-- Ensure the selected texture is unique iff there are sufficient textures to allow for that.
				-- The pin count includes the centre pin.
				if usedIndexes[ i ] == nil then
					usedIndexes[ i ] = true
					return i
				end
			else
				return i
			end
		end
	end
	
	for i = 1, #ns.clusterNames do				-- ns.clusterNames is setup in Data_xxx
		ns.cluster[ i ] = UniqueTextureIndex()	-- index into ns.textures
	end	
end

local function SetupPinClusterCoordinates()

	-- Executed once per load screen / login
	-- ns.clusterRadius, ns.clusterNames are defined in the Data_xxx file.
	
	if ns.clusterNames == nil then return end
	if #ns.clusterCoords > 0 then return end
	
	-- To here with the following defined in Data_xxx:
	-- ns.pinCluster[ 1 ] to ns.pinCluster[ n ] = {} -- a pin set. Index 1 is the centre, probably a "flavour" pin. All the other
	-- pins will surround it at a fixed radius and at equidistant arc lengths / circle perimiter lengths.
	-- Thus ( #ns.clusterNames or #ns.pinCluster or #ns.clusterCoords ) minus 1 is the number of pins surrounding the centre pin.
	-- The pin set must have a cluster="name" field. Only one pin is specified in the ns.points data. Assumed to be the centre pin.
	-- Radius parameter is optional. Coord is a standard ns.points coord as in Data_xxx.

	local scaling, width, height
	if ns.version < 60000 then
		local _, topLeft = GetWorldPosFromMapPos( 947, { x=0, y=0 } )
		local _, botRight = GetWorldPosFromMapPos( 947, { x=1, y=1 } )
		local top, left = topLeft:GetXY()
		local bottom, right = botRight:GetXY()
		width, height = right - left, bottom - top	
		scaling = width / height -- 0.79 (1/1.2658) GetWorldPosFromMapPos
		width, height = UIParent:GetWidth(), UIParent:GetHeight() -- UIParent WorldMapFrame
		scaling = scaling * width / height -- 1.404475. Close to root 2. Coincidence?
	else
		width, height = C_Map.GetMapWorldSize( 947 )
		scaling = width / height
	end
	local angle = ( #ns.clusterNames > 1 ) and ( 2 * math.pi / ( #ns.clusterNames - 1 ) ) or 0
	local radius = ns.clusterRadius or 4.5
			-- This is in 0 to 100 map units as a distance from the given centre pin as (nn.nn,nn.nn).

	local function CalcNextPoint( i )
		return radius * cos( angle * i ) / scaling, radius * sin( angle * i )
	end

	ns.clusterCoords[ 1 ] = {}
	ns.clusterCoords[ 1 ].x, ns.clusterCoords[ 1 ].y = 0, 0
			-- Index 1 is the centre pin and is effectively unused. All other coords are saved as an offset from the centre pin
	for i = 2, #ns.clusterNames do
		local nX, nY = CalcNextPoint( 2 - i )
		ns.clusterCoords[ i ] = {}
		ns.clusterCoords[ i ].x = nX -- +/- nn.nnnn...
		ns.clusterCoords[ i ].y = nY -- +/- nn.nnnn...
	end
end

-- ---------------------------------------------------------------------------------------------------------------------------------

-- Bootstrap Related Code

-- My AddOn system throttles the frequency of the HandyNotes update cycling. This is to ensure that there's minimal impact upon the
-- player's FPS, especially on potato PC's. A consequence of this is that the Minimap will not instantly be updated after a player
-- action, such as completing a quest or achievement, that might result in a pin appearing / disappearing.

-- The throttling also gets around a rare problem that HN has when it wants to update but a cinematic is playing or there's
-- exceptional lag or a first Refresh is triggered too soon. The 60s / 10s in the ns.delay timer in practice is quite sufficient.

-- Note that HandyNotes uses the Ace DB system. I use my own DB routine (standard WoW). Nevertheless, HN requires a DB to be
-- "registered" or else the AddOn will not function.

-- Note the optional Interface option setup functions below. Found in the Options_Events or Options_xxx files if at all.

local function GetAddOnVersion()
	local _, _, version = find( GetAddOnMetadata( addOnName, "Version" ), "(%d+\.%d+)" )
	version = tonumber( version )
	return version
end

local function SetupSavedPlayerOptions()

	-- Reminder: There might be other AddOns using different Engine versions and with/without the Events package.
	-- And the engine saves the variables account wide but per AddOn.

	_G[ ns.db ] = _G[ ns.db ] or {}
	
	if ( ns.engine == nil ) or ( ns.engine.version == nil ) then return end -- I.e. can opt out of versioning
	
	local addOnVer = GetAddOnVersion()

	if ( _G[ ns.db ][ "engineVer" ] == nil ) or
						( ns.engine.resetEngine and ( _G[ ns.db ][ "engineVer" ] < ns.engine.resetEngine ) ) or
						( ns.engine.resetAddOn and ( _G[ ns.db ][ "addOnVer" ] < ns.engine.resetAddOn ) ) then
		_G[ ns.db ] = {} -- Cleanout the old saved variables. Future flags can trigger different things
		_G[ ns.db ][ "engineVer" ] = ns.engine.version
		_G[ ns.db ][ "addOnVer" ] = addOnVer
		return
	end
end

ns.pluginHandler = {}
LibStub( "AceAddon-3.0" ):NewAddon( ns.pluginHandler, "DummyDB_" ..ns.addOnName, "AceEvent-3.0" )

function ns.pluginHandler:Refresh()
	if GetTime() > ( ns.delay or 0 ) then
		ns.delay = nil
		self:SendMessage( "HandyNotes_NotifyUpdate", ns.addOnName )
	end
end

local function OnUpdate()
	if GetTime() > ( ns.saveClusterTime or 0 ) then
		NewClusterPins()
		ns.saveClusterTime = GetTime() + fastrandom( 600, 1800 )
	end
	if GetTime() > ( ns.saveTime or 0 ) then
		ns.saveTime = GetTime() + 10
		ns.pluginHandler:Refresh()
	end
end

local function OnEventHandler( self, event, ... )
	if ( event == "PLAYER_ENTERING_WORLD" ) or ( event == "PLAYER_LEAVING_WORLD" ) then
		ns.delay = GetTime() + 60 -- Some arbitrary large amount
	elseif event == "SPELLS_CHANGED" then
		ns.delay = GetTime() + 10 -- Allow a 10 second safety buffer before we resume refreshes
	elseif event == "VARIABLES_LOADED" then
		SetupSavedPlayerOptions()
		SetupPinClusterCoordinates()
		ns.InterfaceOptions()
		if ns.InterfaceOptionsEvents ~= nil then ns.InterfaceOptionsEvents() end
		if ns.InterfaceOptionsAddOnSpecific ~= nil then ns.InterfaceOptionsAddOnSpecific() end
	end
end

ns.eventFrame = CreateFrame( "Frame" )
ns.eventFrame:SetScript( "OnUpdate", OnUpdate )
ns.eventFrame:RegisterEvent( "PLAYER_ENTERING_WORLD" )
ns.eventFrame:RegisterEvent( "PLAYER_LEAVING_WORLD" )
ns.eventFrame:RegisterEvent( "SPELLS_CHANGED" )
ns.eventFrame:RegisterEvent( "VARIABLES_LOADED" )
ns.eventFrame:SetScript( "OnEvent", OnEventHandler )

-- ---------------------------------------------------------------------------------------------------------------------------------

-- HandyNotes requires a pin iteration routine that gets invoked every update cycle. Functions_Common throttles the frequency.
-- If an AddOn has something needing to be done for a pin that is unique to that AddOn then the ns.GetAddOnSpecificTextureIndex()
-- and ns.PassAdditionalAddOnSpecificChecks() functions can be defined. They're intended to reside in the Core file.
-- The ns.PassAdditionalEventChecks() function is in the Common_Events file, if used.

local function ScalePin( base )

	-- ns.scaling and ns.pinSizeVersionFudge are in Common or else Data_xxx. ns.continents is in Mapping.
	
	return _G[ ns.db ].IconScale * ns.pinSizeVersionFudge *
			( ( ns.scaling[ base ] == nil ) and 0.25 or ns.scaling[ base ] ) * 
			( ( ns.continents[ ns.mapID ] == nil ) and 1 or ( ( ns.mapID == 947 ) and 0.6 or 0.8 ) )
end

local function ShowPinCluster( coord, scaling )

	local cX, cY = floor( coord / 10000 ) / 100, ( coord % 10000 ) / 100

	for i = 2, #ns.clusterCoords do -- Several # variables available for this
		local pX, pY = ns.Round( cX + ns.clusterCoords[ i ].x, 2), ns.Round( cY + ns.clusterCoords[ i ].y, 2 )
		local pCoord = pX * 1000000 + pY * 100
		pX, pY = pX / 100, pY / 100
		
		-- The nominal coord in the Data_xxx file must be replaced with the calculated coord
		for k, v in pairs ( ns.points[ ns.mapID ] ) do
			if v.cluster and v.cluster == ns.clusterNames[ i ] and pCoord ~= k then
				ns.points[ ns.mapID ][ pCoord ] = ns.points[ ns.mapID ][ k ]
				ns.points[ ns.mapID ][ k ] = nil
			end
		end
		
		-- Tell HandyNotes to display the pin on the World Map
		HandyNotes.WorldMapDataProvider:GetMap():AcquirePin( "HandyNotesWorldMapPinTemplate", ns.addOnName, pX, pY,
			ns.textures[ ns.cluster[ i ] ], ScalePin( ns.cluster[ i ] ) * 1.5 * ( ( scaling == nil ) and 1 or scaling ),
			_G[ ns.db ].IconAlpha, pCoord, ns.mapID, nil )
	end	
end

function ns.handyNotesPinIterator( t, prev )
	if not t then return end
	if _G[ ns.db ].ShowPins == nil or _G[ ns.db ].ShowPins == false then return end
	
	local coord, pin = next( t, prev );
	local hash, savedSeriesTexture;

	while coord do
		if pin then
			if ns.PassGeneralChecks( pin ) and
					( ( ns.PassAdditionalEventChecks == nil ) or ns.PassAdditionalEventChecks( pin ) ) and
					( ( ns.PassAdditionalAddOnSpecificChecks == nil ) or
							ns.PassAdditionalAddOnSpecificChecks( pin ) ) then
				if pin.series then
					savedSeriesTexture = _G[ ns.db ][ "iconSeries" ..pin.series ]
					if savedSeriesTexture > 1 then -- 0 == no show requested for this series of pins
						hash = ( savedSeriesTexture <= ( ns.texturesBaseTotal + 1 ) ) and ( savedSeriesTexture - 1 ) or
								( ns.seriesMapping[ pin.series ] + savedSeriesTexture - ns.texturesBaseTotal - 2 )
						return coord, nil, ( ns.textures[ hash ] or nil ),
								ScalePin( hash ) * ( ( pin.scaling == nil ) and 1 or pin.scaling ), _G[ ns.db ].IconAlpha
					end
				elseif pin.cluster and pin.cluster == ns.clusterNames[ 1 ] then
					ShowPinCluster( coord, pin.scaling )
					hash = ns.cluster[ 1 ]
					return coord, nil, ( ns.textures[ hash ] or nil ),
							ScalePin( hash ) * 2.2 * ( ( pin.scaling == nil ) and 1 or pin.scaling ), _G[ ns.db ].IconAlpha
				elseif ns.GetAddOnSpecificTextureIndex then
					hash = ns.GetAddOnSpecificTextureIndex()
				end
			end
		end
		coord, pin = next( t, coord )
	end
end

-- ---------------------------------------------------------------------------------------------------------------------------------

-- Used by HandyNotes at AddOn loading/setup time.

-- Each Continent / World Map defined in ns.continents (Mapping file) has a ns.points (Data_xxx file) populated with the map pins
-- from each of the child zones. The Mapping file is setup to automatically use the correct mapID for the current game version.

-- When the player enters the world, if this routine gets called with the HandyNotes HereBeDragons module for all of my AddOns that
-- use HandyNotes then the player's interface will freeze if the thousands of pins all get logic checks. I.e. show/hide decisions
-- plus maybe API calls too. So this routine just does a dump of any existent pins with basic checking and calls Dragons Tread
-- Lightly as my lighter replacement for much of the HBD system of HandyNotes.

-- Using my Dragons Tread Lightly comes at the cost of some dungeon maps appearing on Continent maps due to the inconsistent or
-- strange way that maps are internally setup server side. This can be easily avoided by ensuring that every dungeon pin has a
-- noContinent=true parameter. This is checked in PassGeneralChecks(). DTL has an advantage over HBD in that DTL allows certain map
-- children that are undefined in HBD. Examples: Maelstrom, Nazjatar, Dornogal.

-- At issue here is the tardiness / unwillingness of the HBD maintainers to offer a temporary fix for Blizzard's error when Classic
-- Mists launched with incorrect translations of the zone coordinates to the World Map. If I had persisted using HBD then all of
-- my HandyNotes AddOns would have had incorrect pin placement on the Azeroth map for the Beta period and the first two weeks after
-- launch!

function ns.pluginHandler:OnEnable()
	for continentMapID in next, ns.continents do
		local children = GetMapChildrenInfo( continentMapID, nil, true )
		children = ns.DragonsTreadLightlyAddChildren( continentMapID, children )
		for _, map in next, children do
			if ns.points[ map.mapID ] then
				for coord, v in next, ns.points[ map.mapID ] do
					if ns.PassGeneralChecks( v ) then
						local newCoord = ns.DragonsTreadLightlyCoords( coord, map.mapID, continentMapID )
						if newCoord then
							ns.points[ continentMapID ] = ns.points[ continentMapID ] or {}
							ns.points[ continentMapID ][ newCoord ] = v
						end
					end
				end
			end
		end
	end
	HandyNotes:RegisterPluginDB( ns.addOnName, ns.pluginHandler, nil )
end

function ns.pluginHandler:GetNodes2( mapID )
	ns.mapID = mapID
	return ns.handyNotesPinIterator, ns.points[ mapID ]
end

-- ---------------------------------------------------------------------------------------------------------------------------------

-- Guides and Tips may be an array of strings or a single string or nil.
-- Guides preceed Tips when shown. A Guide will be extensive, a Tip briefer, maybe finessing a generic Guide.
-- Note that ns.wordwrap is used. It is set in the Data_xxx file.
-- It's expected that a Guide would be way to extensive to translate, but any translation must occur in the Data_xxx file.
-- In the Common_Events file, Guides and Tips are not shown for completed Quests/Achievements.
-- The second passed paramter (colour) is optional and is there for any future expansion. Currently unused.
-- ns.colour.guide is a part of the Events system. If the Events module is not used then it will be nil here.
-- String substitutions are supported for Guides and Tips

local function ShowGuideTip( tip, colour )
	if ( tip == nil ) or ( tip == "" ) then return end
	GameTooltip:AddLine( ns.spaceLine ..( colour or ns.colour.plaintext ) 
						..( ns.StringSubstitutions( tip ) ), nil, nil, nil, ns.wordwrap )
	ns.spaceLine = ""
end

local function GuideTipTyping( gt, colour )
	if type( gt ) == "table" then
		for i, v in ipairs( gt ) do
			ShowGuideTip( v, colour )
		end
	elseif type( gt ) == "string" then
		ShowGuideTip( gt, colour )
	end
end

function ns.GuideTip( pin, colour )
	GuideTipTyping( pin.guide, ( colour or ns.colour.guide ) )
	GuideTipTyping( pin.tip, colour )
	return
end

-- ---------------------------------------------------------------------------------------------------------------------------------

local function CorrectMapPhase( old, mapID )

	-- Used by AddOns that need to differentiate between the Zidormi map phases. Will add a Tooltip line if the player is in the
	-- wrong phase for the pin. Don't come here if ns.noZidormiCheck = true. This field is for ALL pins and is in Data_xxx.
	-- Next look for a pin.noZidormi and also bypass if not nil. Otherwise, arrive here.
	
	-- If the player is not in the zone then return true.

	-- Note that the player might be looking at Theramore on the Minimap (i.e. likely actually in Theramore) but the player might be
	-- looking at the Southern Barrens zone with the Theramore pin way over in the distance, or some other zone. Design decision is
	-- to show a warning only if the player is actually in the zone.
	
	-- If the passed pin.zidormiOldPhase boolean doesn't match the phase then issue a Tooltip line.
	-- Pass old=true if you want the old phase. Pass old=false if you want the "current times" phase.
							
	-- Note: Sometime October 2025 Blizzard silently fixed the Tirisfal bug that required players to do Zidormi three times.
	-- Note: If swapping in Darkshore then the player receives NO buff and thus this routine will drop through as "new".

	-- Note: GetMapArtID() was useful at times during testing a couple of years ago. Always returns nil these days.
	
	if ( ns.version < 60000 ) then return true end -- Zidormi phasing started from Legion
	if GetBestMapForUnit( "player" ) ~= mapID then return true end
	
	if (  mapID == 17 ) or (  mapID == 18 ) or (  mapID == 2070 ) or -- Blasted Lands, 2 x Tirisfal Glades
			(  mapID == 14 ) or (  mapID == 57 ) or (  mapID == 62 ) or -- Arathi Highlands, Teldrassil, Darkshore
			(  mapID == 70 ) or (  mapID == 81 ) or -- Theramore (Dustwallow Marsh), Silithus, (Darnassus 89 not necessary)
			(  mapID == 249 ) or (  mapID == 1527 ) then -- 2 x Uldum
		for i = 1, 40 do -- 40 is rather arbitrary these days I think
			local auraData = GetAuraDataByIndex( "player", i, "HELPFUL" )
			if auraData == nil then break end
			if auraData.spellId then -- Look for Time Travelling buff
				-- If two values: the first is if login and already "old". Second is after a switch to old while logged in.
				if ( auraData.spellId == 276954 ) or ( auraData.spellId == 276950 ) or	-- Arathi
					( auraData.spellId == 176111 ) or ( auraData.spellId == 372329 ) or -- Blasted Lands
					( auraData.spellId == 254169 ) or 									-- Kun-Lai Summit / Peak of Serenity
					( auraData.spellId == 277430 ) or ( auraData.spellId == 277427 ) or -- Teldrassil ("new" is inaccessible)
					( auraData.spellId == 123979 ) or 									-- Theramore
					( auraData.spellId == 317931 ) or ( auraData.spellId == 317928 ) or -- Vale of Eternal Blossoms
					( auraData.spellId == 317785 ) or ( auraData.spellId == 316193 ) or -- Uldum
					-- The following has the first buff only ever encountered during testing
					( auraData.spellId == 276827 ) or ( auraData.spellId == 276824 ) or -- Tirisfal Glades
					-- The following have three values. The first was encountered during testing. Note: switching to old gives NO buff
					( auraData.spellId == 290246 ) or ( auraData.spellId == 290245 ) or ( auraData.spellId == 1213445 ) or  -- Darkshore
					-- First is if login and already "old". Second is after a switch to old. 3rd is a mystery
					( auraData.spellId == 264606 ) or ( auraData.spellId == 255152 ) or ( auraData.spellId == 262016 ) then  -- Silithus						
					return ( ( old == nil ) and true or old )
				end
			end
		end
		return ( ( old == nil ) and false or not old )
	else
		return true
	end
end

function ns.pluginHandler:OnEnter( mapFile, coord )
	-- mapFile is a mapID for either the Minimap or the currently showing World Map zone
	if self:GetCenter() > UIParent:GetCenter() then
		GameTooltip:SetOwner( self, "ANCHOR_LEFT" )
	else
		GameTooltip:SetOwner( self, "ANCHOR_RIGHT" )
	end

	local pin = ns.points[ mapFile ] and ns.points[ mapFile ][ coord ]

	if pin.series and ns.series[ pin.series ].title then
		GameTooltip:SetText( ns.colour.prefix ..ns.StringSubstitutions( ns.series[ pin.series ].title ) )
	else
		GameTooltip:SetText( ns.colour.prefix ..ns.StringSubstitutions( pin.title or ns.eventName ) )
	end
	if pin.name then
		GameTooltip:AddLine( ns.colour.highlight ..ns.StringSubstitutions( pin.name ) .."\n" )
	end
	
	ns.spaceLine = ""

	if ns.AddOnEventTooltipLines then ns.AddOnEventTooltipLines( pin, mapFile ) end
	if ns.AddOnSpecificTooltipLines then ns.AddOnSpecificTooltipLines( pin, mapFile ) end

	ns.GuideTip( pin )		

	if ns.noZidormiCheck == false then
		if ( pin.noZidormi == nil ) and ( CorrectMapPhase( pin.zidormiOldPhase, mapFile ) == false ) then
			ShowGuideTip( ns.L[ "ZidormiWrongPhase" ] )
		end
	end
	
	if ns.author and pin.author then
		GameTooltip:AddLine( ns.colour.highlight ..pin.author )
	end
	
	if ( _G[ ns.db ].ShowCoordinates == true ) and ( pin.noCoords == nil ) then
		GameTooltip:AddLine( ( ns.colour.subH or ns.colour.highlight ) .."(" ..format( "%.02f", ( floor( coord / 10000 ) / 100 ) )
						.."," ..format( "%.02f", ( ( coord % 10000 ) / 100 ) ) ..")" )
	end

	GameTooltip:Show()
end

function ns.pluginHandler:OnLeave()
	GameTooltip:Hide()
end

-- ---------------------------------------------------------------------------------------------------------------------------------

_G[ "HandyNotes_" ..ns.addOnName .."_OnAddonCompartmentClick" ] = function( addonName, buttonName )
	if buttonName == "LeftButton" then
		Settings.OpenToCategory( ns.optionsMainPanel:GetID() )
	elseif buttonName == "RightButton" then
		Settings.OpenToCategory( ns.optionsTextures:GetID() )
	elseif buttonName == "MiddleButton" then
		Settings.OpenToCategory( ns.removeWhenCompleted:GetID() )
	end
end

_G[ "HandyNotes_" ..ns.addOnName .."_OnAddonCompartmentEnter" ] = function( ... )
	GameTooltip:SetOwner( MinimapCluster or AddonCompartmentFrame, "ANCHOR_LEFT" )	
	GameTooltip:AddLine( ns.colour.prefix ..ns.eventName .."\n\n" )
	GameTooltip:AddDoubleLine( ns.colour.highlight ..ns.L[ "Left" ], ns.colour.plaintext ..ns.L[ "Options" ] )
	if ns.removeWhenCompleted ~= nil then
		GameTooltip:AddDoubleLine( ns.colour.highlight ..ns.L[ "Middle" ], ns.colour.plaintext ..ns.L[ "Achievements" ] .."/"
			..ns.L[ "Quests" ] )
	end
	if ns.optionsTextures ~= nil then
		GameTooltip:AddDoubleLine( ns.colour.highlight ..ns.L[ "Right" ], ns.colour.plaintext ..ns.L[ "Textures" ] )
	end
	GameTooltip:Show()
end

_G[ "HandyNotes_" ..ns.addOnName .."_OnAddonCompartmentLeave" ] = function( ... )
	GameTooltip:Hide()
end

-- ---------------------------------------------------------------------------------------------------------------------------------

local function Slash( options )
	Settings.OpenToCategory( ns.optionsMainPanel:GetID() )
	if ( ns.version >= 100000 ) then
		print( ns.colour.prefix ..ns.addOnName ..": " ..ns.colour.highlight ..ns.L[ "TryMinimapMenu" ] )
	end
end

for i,v in ipairs ( ns.slashCommands ) do
	_G[ "SLASH_" ..ns.addOnName ..i ] = v
end

SlashCmdList[ ns.addOnName ] = function( options ) Slash( options ) end