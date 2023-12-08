BINDING_HEADER_GOGOHEADER = "GoGoMount"
BINDING_NAME_GOGOBINDING = "Mount/Dismount"
BINDING_NAME_GOGOBINDING2 = "Mount/Dismount (no flying)"
BINDING_NAME_GOGOBINDING3 = "Mount/Dismount Passenger Mounts"
BINDING_NAME_GOGOBINDING4 = "Mount/Dismount Seller Mounts"
BINDING_NAME_GOGOBINDING5 = "Mount/Dismount Herbalism Mounts"

GoGo_Variables = {}
GoGo_Variables.ZoneExclude = {}
GoGo_Variables.Player = {}
GoGo_Variables.MountList = {}
--GoGo_DebugLog = {}
GoGo_Variables.Localize = {}
GoGo_Variables.Localize.Zone = {}
GoGo_Variables.Localize.String = {}
GoGo_Variables.Localize.Skill = {}
GoGo_Variables.Localize.Talent = {}
GoGo_Variables.GroundSpeed = {}
GoGo_Variables.AirSpeed = {}
GoGo_Variables.WaterSpeed = {}
GoGo_Variables.WaterSurfaceSpeed = {}
GoGo_Variables.Debug = 0
GoGo_Variables.DebugTimer = 0
GoGo_Variables.TestVersion = true
--GoGo_Variables.Zones = {}	-- Defined below
--GoGo_Variables.ZoneMapID = {}	-- Defined below
--if GoGo_Variables.Debug >= 6 then
--  GoGo_DebugAddLine("GoGo_Variables initialized ")
--end

---------------------------------------------------------
-- Mount data (true/false by default, else value)
--
-- 2 : passenger mount
-- 3 : seller mount
-- 4 : ????
-- 5 : while moving
-- 6 : can be used to gather herbs
-- 7 : instant
-- 8 : indoor
-- 9 : ????
-- 10 :
-- 11 :
-- 14 :
-- 15 :
-- 35 : Mounts unusable under Riding Level 300
-- 36 : Mounts unusable under Riding Level 225
-- 37 : Mounts unusable under Riding Level 150
-- 38 : Mounts unusable under Riding Level 75
-- 39 : 
-- 45 : Engineering low-level
-- 46 : Engineering high-level
-- 47 : Tailoring high-level
-- 48 : Tailoring low-level
-- 49 : Tailoring mid-level
-- 52 : Northrend loaned
-- 54 : The Oculus
-- 330 : Ground mounts which can go up to 200%
-- 400 : Thousand Needles speed buff special
-- 402 : Mount Up guild perk special (Ground)
-- 403 : Mount Up guild perk special (Air)
-- 405 : Water Gliding buff special
-- 406 : Dragonriding
-- 501 : Druid flight form
-- 701 : Ashran Swift Riding Crop special
-- 10001 : Underwater (speed)
-- 10002 : Ground (speed)
-- 10003 : Flying (speed)
-- 10004 : Water surface (speed)
-- 50000 : item ID <-> Spell ID for mounts from an item
--
---------------------------------------------------------


---------
function GoGo_GetMountDB()
---------

	--for _,mountID in ipairs(C_MountJournal.GetMountIDs()) do
	--	spellID = select(2, C_MountJournal.GetMountInfoByID(mountID))
	--	mountType = select(5, C_MountJournal.GetMountInfoExtraByID(mountID))
	--	selfMount = select(4, C_MountJournal.GetMountInfoExtraByID(mountID))
	--	selfMountT = "0"
	--	if selfMount then selfMountT = "1" end
	--	mountName = select(1, C_MountJournal.GetMountInfoByID(mountID))
	--	--if (spellID<127293) then
	--	if (spellID<999999) then
	--		GoGo_DebugAddLine("GoGo_GetMountDB: " .. spellID .. "," .. mountType .. "," .. selfMountT .. "," .. mountName)
	--	end --if
	--end --for
	
	GoGo_Variables.GenericMountDB = {
	
		[230] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67}, -- Generic Ground Mount
		-- No default for type 231
		-- No default for type 232
		[241] = {[38] = true, [201] = true, [330]=true, [402]=true, [10002]=160}, -- Qiraji Battle Tanks
		-- Type 242: Swift Spectral Mounts - mounts used in Ghost Form, after dying
		-- No default for type 247
		[248] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67}, -- Generic Flying Mount
		[254] = {[36] = true, [53] = true, [404] = true, [10001]=108, [10004]=108}, -- Generic Water Mount
		[284] = {[39] = true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67}, -- Chauffeured mounts
		-- No default for type 398
		[402] = {[406]=true} -- Dragonriding mounts
		-- Missing type 412
	
	}

	GoGo_Variables.MountDB = {
	
	    -- SPECIAL 230
		
		-- No water glide (to check)
		[26656] = {[38] = true, [330]=true, [400]=true, [402]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Qiraji Battle Tank
		[92155] = {[38] = true, [330]=true, [400]=true, [402]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Ultramarine Qiraji Battle Tank
		
		-- Walks on water
		[118089] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=200},  -- Azure Water Strider
		[127271] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=200},  -- Crimson Water Strider

        -- Passenger mounts
		[55531] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Mechano-hog
		[60136] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grand Caravan Mammoth
		[60140] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grand Caravan Mammoth
		[60424] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Mekgineer's Chopper
		[61465] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grand Black War Mammoth
		[61466] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grand Black War Mammoth
		[61467] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grand Black War Mammoth
		[61469] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grand Ice Mammoth
		[61470] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grand Ice Mammoth

		-- Seller mounts
		[61425] = {[2] = true, [3] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Traveler's Tundra Mammoth
		[61447] = {[2] = true, [3] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Traveler's Tundra Mammoth
		[122708] = {[2]=true, [3] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grand Expedition Yak
		[264058] = {[2] = true, [3] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Mighty Caravan Brutosaur
		
		-- Mounts from objects
		[239767] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67, [50000]=151625},  -- Red Qiraji War Tank
		
		-- Misc (to check) 
		[136471] = {[37] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Spawn of Horridon
		
		
		-- TYPE 231
		[30174] = {[15] = true, [39] = true, [10001]=67, [10002]=100, [10004]=67},  -- Riding Turtle
		[64731] = {[15] = true, [39] = true, [402]=true, [404]=true, [10001]=108, [10002]=100, [10004]=108},  -- Sea Turtle
		
		
		-- TYPE 232
		[75207] = {[36] = true, [53] = true, [401] = true, [10001]=108, [10002]=160, [10003]=250, [10004]=371},  -- Vashj'ir Seahorse
		
		
		-- TYPE 247
		[130092] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Red Flying Cloud


		-- SPECIAL 248
		
		-- Passenger mounts
		[75973] = {[2] = true, [9] = true, [39] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- X-53 Touring Rocket
		[93326] = {[2] = true, [9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Sandstone Drake
		[121820] = {[2] = true, [9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Obsidian Nightwing
		[245723] = {[2] = true, [9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Stormwind Skychaser
		[245725] = {[2] = true, [9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Orgrimmar Interceptor

		-- Herbalism mounts
		[134359] = {[6] = true, [9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Sky Golem (The Sky Claw)
		[223814] = {[6] = true, [9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Mechanized Lumber Extractor

		-- Mounts requiring engineering
		[44151] = {[9] = true, [39] = true, [46] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Turbo-Charged Flying Machine
		[44153] = {[9] = true, [36] = true, [45] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Flying Machine

		-- Mounts requiring tailoring
		[61309] = {[9] = true, [49] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Magnificent Flying Carpet
		[61451] = {[9] = true, [48] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Flying Carpet
		[75596] = {[9] = true, [49] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Frosty Flying Carpet

		-- Misc (to check) 
		[63796] = {[9] = true, [36] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Mimiron's Head
		[71342] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [403]=true, [10002]=160, [10003]=250},  -- Big Love Rocket
		[126508] = {[9] = true, [39] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Geosynchronous World Spinner


		-- SPECIAL 254
		
		-- Misc (to check)
		[98718] = {[36] = true, [53] = true, [404] = true, [10001]=108, [10002]=160, [10003]=250, [10004]=108},  -- Subdued Seahorse
		[228919] = {[36] = true, [53] = true, [404] = true, [10001]=108, [10002]=160, [10003]=250, [10004]=108},  -- Darkwater Skate
		[278803] = {[36] = true, [53] = true, [404] = true, [10001]=108, [10002]=160, [10003]=250, [10004]=108},  -- Great Sea Ray
		[278979] = {[36] = true, [53] = true, [404] = true, [10001]=108, [10002]=160, [10003]=250, [10004]=108},  -- Surf Jelly
		
		
		-- TYPE 398
		[267270] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Kua'fon
		
		-- SHAPE FORMS AND SPEED SPELLS
		[768] = {[7] = true, [8] = true, [1000] = true, [500] = true, ["DefaultInstance"] = true, [10002]=130},  -- Druid Cat Form
		[783] = {[7] = true, [500] = true, [1000]=true, [10002]=200}, -- Druid Travel Form
		[1066] = {[7] = true, [53] = true, [500]=true, [1000]=true, [10001]=101, [10004]=101, ["DefaultInstance"] = true},  -- Druid Aqua form
		[2645] = {[7] = true, [8] = true, [500] = true, [1000] = true, ["DefaultInstance"] = true, [10002]=130}, -- Shaman Ghost Wolf Form
		[33943] = {[7] = true, [9] = true, [300] = true, [301] = true, [403] = true, [9998] = true, ["FlightOnly"] = true, [10003]=250},  -- Druid Flight Form
		[40120] = {[7] = true, [9] = true, [300] = true, [403] = true, [9998] = true, ["FlightOnly"] = true, [10003]=380},  -- Druid Swift Flight Form
		[87840] = {[14] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Running Wild (Worgen Racial)
		[125883] = {[7]=true, [9]=true, [403]=true, ["FlightOnly"]=true, [10003]=160},	-- Zen Flight (Monk glyph)
		[165962] = {[7] = true, [9] = true, [300] = true, [301] = true, [403] = true, [501] = true, [9998] = true, ["FlightOnly"] = true, [10003]=250},  -- Druid Flight Form  (new form that appears with Glyph of the Stag with patch 6.0)
		[186257] = {[7] = true, [8] = true, [500] = true, ["DefaultInstance"] = true, [10002]=138},  -- Aspect of the Cheeta
		[210053] = {[7] = true, [500] = true, [1000]=true, [10002]=200}, -- Druid Mount Form
		[310143] = {[7] = true, [8] = true, [500] = true, [1000] = true, ["DefaultInstance"] = true, [10002]=150}, -- Night Fae SoulShape
		
		
		-- MOUNTS FROM ITEMS
		[42667] = {[7] = true, [9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [402]=true, [403]=true, [600]=true, [601]=true, [10002]=160, [10003]=250, [50000]=33176},  -- Flying Broom  --  itemid
		[42668] = {[9] = true, [11] = true, [36] = true, [50000]=33182},  -- Swift Flying Broom  --  [50000]=33184
		[47977] = {[7]=true, [9] = true, [10]=true, [38] = true, [300]=true, [301]=true, [330]=true, [402]=true, [403]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67, [50000]=37011},  -- Magic Broom -- itemid
		[49345] = {[9] = true, [54] = true, ["FlightOnly"] = true, [50000]=37815},  -- Emerald Drake
		[49461] = {[9] = true, [54] = true, ["FlightOnly"] = true, [50000]=37859},  -- Amber Drake
		[49462] = {[9] = true, [54] = true, ["FlightOnly"] = true, [50000]=37860},  -- Ruby Drake
		[64762] = {[9] = true, [39] = true, [52] = true, ["FlightOnly"] = true, [10003]=250, [50000]=44229},  -- Loaned Wind Rider Reins
		[66393] = {[7] = true, [10002]=200, [50000]=46856}, -- Keys to the Hot Rod
		[76203] = {[55] = true, [200] = true, [10004]=286, [50000]=55121},  -- River Boat
		[101641] = {[9] = true, [19] = true, [39] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67, [50000]=71086},  -- Tarecgosa's Visage
		[145133] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67, [50000]=101675},  -- Moonfang
		[220124] = {[50000]=139421},		-- Ratstallion Harness
		[220508] = {[38] = true, [203]=true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67, [50000]=139505},  -- 7.0 Paladin Order Hall Mount Dummy
		[239766] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67, [50000]=151626},  -- Blue Qiraji War Tank
		[295190] = {[8]=true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67, [50000]=168035},  -- Mawrat Harness
		[304916] = {[8]=true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67, [50000]=170499},  -- Maw Seeker Harness
		[315315] = {[8]=true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67, [50000]=174464},  -- Spectral Bridle
		
		
		-- DRAENOR NAGRAND GARISON ABILITY
		[164222] = {[5]=true, [39]=true, [202]=true, [330]=true, [402]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Frostwolf War Wolf
		[165803] = {[5]=true, [39] = true, [202]=true, [330]=true, [402]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Telaari Talbuk
		
		
		-- OTHER
		[148626] = {[99999]=true, ["note"]="mount that only lasts 20 seconds?  adding here but excluding to prevent GoGoMount from flagging a unknown mount"},  -- Furious Ashhide Mushan
		[163016] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67, [9999]=true},  -- Warforged Nightmare

		[397406] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67, [9999]=true},  -- Warforged Nightmare


		------------------------------------------------------

		-- Obsolete (Uncategorized spells)
		--    [471] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Palamino
		--   [3363] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Nether Drake
		--  [15781] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Steel Mechanostrider
		--  [16058] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Primal Leopard
		--  [16059] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Tawny Sabercat
		--  [16060] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Golden Sabercat
		--  [17455] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Purple Mechanostrider
		--  [17456] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Red and Blue Mechanostrider
		--  [17458] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Fluorescent Green Mechanostrider
		--  [23220] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Dawnsaber
		--  [34407] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Elite Elekk
		--  [43810] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Frost Wyrm
		--  [47037] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift War Elekk
		--  [50281] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Warp Stalker
		--  [51960] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Frostwyrm Mount
		--  [54726] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Winged Steed of the Ebon Blade
		--  [54727] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Winged Steed of the Ebon Blade
		--  [58819] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Brown Steed
		--  [59573] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Brown Polar Bear
		--  [59802] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grand Ice Mammoth
		--  [59804] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grand Ice Mammoth
		-- [148970] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Felsteed
		-- [148972] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Dreadsteed
		-- [171840] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Coldflame Infernal
		-- [190710] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Enchanted Chicken


		-- Obsolete (Ground mounts)
		--  [50869] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Brewfest Kodo
		--  [66907] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Argent Warhorse
		-- [123160] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Crimson Riding Crane
		-- [127178] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Jungle Riding Crane
		-- [127180] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Albino Riding Crane
		-- [127272] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=200},  -- Orange Water Strider  (walks on water)
		-- [127274] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=200},  -- Jade Water Strider  (walks on water)
		-- [127278] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=200},  -- Golden Water Strider  (walks on water)
		-- [171618] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Ancient Leatherhide
		-- [213349] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Flarecore Infernal
		-- [215545] = {[999]=true, [9999]=true},  -- Fel Bat (Test)

		-- Obsolete (Flying mounts)
		--  [32345] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Peep the Phoenix Mount
		-- [147595] = {[9]=true, [38]=true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Stormcrow
		-- [171847] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Cindermane Charger
		-- [237288] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Reins of the Onyx War Hyena
		-- [278966] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Tempestuous Skystallion
		-- [300152] = {[36] = true, [53] = true, [404] = true, [10001]=108, [10004]=108}, -- Tidestallion
		
		-- Obsolete (Removed)
		--  [33184] = {[38] = true, [9] = true, [4] = true, [999] = true},  -- Swift Magic Broom  --  itemid
	   
	}
	
	-- Fill generic mount types from journal
	for _,mountID in ipairs(C_MountJournal.GetMountIDs()) do
		spellID = select(2, C_MountJournal.GetMountInfoByID(mountID))
		mountTypeID  = select(5, C_MountJournal.GetMountInfoExtraByID(mountID))
		if GoGo_Variables.MountDB[spellID] == nil and mountTypeID ~= 242 then
			if GoGo_Variables.Debug >= 10 then
				GoGo_DebugAddLine("GoGo_GetMountDB: Adding mount " .. spellID .. " with standard type " .. mountTypeID )
			end --if
			if  GoGo_Variables.GenericMountDB[mountTypeID] == nil then
				GoGo_Msg(UnknownMountType)
				if GoGo_Variables.Debug >= 6 then
					GoGo_DebugAddLine("GoGo_GetMountDB: Missing type " .. mountTypeID )
				end --if
			else
				GoGo_Variables.MountDB[spellID] = GoGo_Variables.GenericMountDB[mountTypeID]
			end --if
		end --if
 	end --for
	
end --function

GoGo_Variables.MountItemIDs = {
	[19979] = {[50000]=24347, [51001]=true},  -- Hook of the Master Angler
	[33176] = {[50000]=42667, [51000] = true},  -- Flying Broom 
	[33182] = {[50000]=42668, [51000] = true},  -- Swift Flying Broom
	-- [33183] = {[51000] = true},  -- Old Magic Broom  -- no longer in game
	[33184] = {[50000]=42668, [51000] = true},  -- Swift Flying Broom
--	[33189] = {[51000] = true},  -- Rickety Magic Broom  -- no speed increase but doesn't seem to cast a spell either..
	[37011] = {[50000]=47977, [51000] = true},	-- Magic Broom
	[37815] = {[50000]=49345, [51000] = true},  -- Emerald Essence
	[37859] = {[50000]=49461, [51000] = true},  -- Amber Essence
	[37860] = {[50000]=49462, [51000] = true},  -- Ruby Essence
	[44221] = {[50000]=64749, [51000] = true},  -- Loaned Gryphon Reins
	[44229] = {[50000]=64762, [51000] = true},  -- Loaned Wind Rider Reins
	[46856] = {[50000]=66393, [51000] = true},  -- Hot Rod
	[55121] = {[50000]=76203, [51000] = true},  -- River Boat
	[71086] = {[50000]=101641, [51001] = true},  -- Dragonwrath, Tarecgosa's Rest
	[101675] = {[50000]=145133, [51000] = true},  -- Shimmering Moonstone
	[139421] = {[50000]=220124, [51000] = true},	-- Ratstallion Harness (item casts spell id 220123 but mount is 220124)
	[139505] = {[50000]=220508, [51000] = true},	-- Reins of the Charger
	[151625] = {[50000]=239767, [51000] = true},  	-- Ruby Qiraji Resonating Crystal
	[151626] = {[50000]=239766, [51000] = true},  	-- Sapphire Qiraji Resonating Crystal
	[168035] = {[50000]=295190, [51000] = true},  	-- Mawrat Harness
	[170499] = {[50000]=304916, [51000] = true},  	-- Maw Seeker Harness
	[174464] = {[50000]=315315, [51000] = true},  	-- Spectral Bride
}


--[[
GoGo_FlyCoOrds = {   -- x = west / east,  y = north / south
	["Dalaran"] = {
		["Underbelly"] = {
			[1] = {0.09200777113437, 0.53064680099487, 0.30007892847061, 0.88580405712128},  -- south west pipe
--			[2] = {0.00000000000000, 0.00000000000000, 0.00000000000000, 0.00000000000000},  -- 3.0.8 PTR the pipe did not have any location co-ordinates as well as other parts of underbelly
		},
		["Dalaran"] = {
			[1] = {0.32762300968170, 0.92964243888855, 0.44406870007515, 0.99999999999999},  -- south floating rock - south part of rock is off dalaran map and zero's out
			[2] = {0.00000000000000, 0.00000000000000, 0.00000000000000, 0.00000000000000},  -- south end of south floating rock that's considered off the dalaran map, north end of north floating rock
			[3] = {0.84375905990601, 0.53441548347473, 0.92961716651917, 0.56119620800018},  -- east floating rock near Karasus' Landing - north half
			[4] = {0.81565266847610, 0.56119620800018, 0.92961716651917, 0.62259274721146},  -- east floating rock near Karasus' Landing - middle section
			[5] = {0.82037299871445, 0.62259274721146, 0.92961716651917, 0.65996080636978},  -- east floating rock near Karasus' Landing - south of above middle section
			[6] = {0.83119285106659, 0.65996080636978, 0.92961716651917, 0.69355386495590},  -- east floating rock near Karasus' Landing - south half
			[7] = {0.24048496782780, 0.00000000000000, 0.35678505897522, 0.06878154724837},  -- north floating rock - middle section
			[8] = {0.24048496782780, 0.06878154724837, 0.32650312781334, 0.09258409589529},  -- north floating rock - south section
			[9] = {0.73049765825272, 0.58968532085419, 0.82789492607117, 0.69320708513260},  -- outer rim - south of Karasus' Landing
			[10] = {0.78565186262131, 0.69320708513260, 0.82789492607117, 0.90059036016464},  -- outer rim - south of above
			[11] = {0.19430139660835, 0.73027163743973, 0.82789492607117, 0.91422116756439},  -- outer rim - south end
			[12] = {0.07060649325275, 0.27633512020111, 0.26812949776649, 0.73027163743973},  -- outer rim - west end
			[13] = {0.12171425670385, 0.13289329409599, 0.29824274778366, 0.34425541758537},  -- outer rim - north end - east from above
			[14] = {0.29824274778366, 0.13289329409599, 0.30157667398453, 0.34425541758537},  -- outer rim - north end - east from above
			[15] = {0.30157667398453, 0.13289329409599, 0.30533048510551, 0.33688980340958},  -- outer rim - north end - east from above
			[16] = {0.30533048510551, 0.13289329409599, 0.30807453393936, 0.32788288593292},  -- outer rim - north end - east from above
			[17] = {0.30807453393936, 0.13289329409599, 0.31300327181816, 0.32129821181297},  -- outer rim - north end - east from above
			[18] = {0.31300327181816, 0.13289329409599, 0.31939730048180, 0.30955401062965},  -- outer rim - north end - east from above
			[19] = {0.31939730048180, 0.05900426954031, 0.42953002452850, 0.27856853604317},  -- outer rim - north end - east from above
			[20] = {0.42953002452850, 0.01805531047284, 0.52528887987137, 0.16944953799248},  -- outer rim - north end - east from above
			[21] = {0.52528887987137, 0.01805531047284, 0.74681603908539, 0.16944953799248},  -- outer rim - north end - east from above
			[22] = {0.67614758014679, 0.16781881451607, 0.82789492607117, 0.73049765825272},  -- outer rim - north east - south east from above to Karasus' Landing
		},
		["VioletCitadel"] = {
			[1] = {0.24813342094431, 0.42324751615524, 0.26391690969467, 0.43607267737389},  -- upper level south part
			[2] = {0.25418719649315, 0.41306078433990, 0.26763379573822, 0.42324751615524},  -- upper level north east from above
			[3] = {0.25979378819466, 0.40825596451759, 0.26960688829422, 0.41306078433990},  -- upper level north from above
			[4] = {0.26259636878967, 0.39096131920815, 0.27175131440163, 0.40825596451759},  -- upper level north from above
			[5] = {0.26015603542328, 0.37608715891838, 0.27175131440163, 0.39096131920815},  -- upper level north west from above
			[6] = {0.24976442754269, 0.36279606819153, 0.26814296841621, 0.37608715891838},  -- upper level north west from above
			[7] = {0.21763536334038, 0.34758481383324, 0.26284533739090, 0.36279606819153},  -- upper level north part
			[8] = {0.21075734496117, 0.36279606819153, 0.23006491363049, 0.38133582472801},  -- upper level south west from above
			[9] = {0.20883683860302, 0.38133582472801, 0.22105532884598, 0.41938513517380},  -- upper level south from above
		},
	},
}
]]

GoGo_Variables.DebuffDB = {
	21848,	-- Snowman constume from Xmas time -- requires 2 clicks to mount
	24347,  -- Master Angler (from Hook of the Master Angler)
	24723,  -- Skeleton costume (from trick-or-treating in Inns)
	24741,  -- Wisp Costume (from Hallowed Wand - Wisp during Halloween)
--	24753,	-- Trick (from trick-or-treating in Inns)  -- can't be removed?
--	24858,	-- Moonkin Form (Druids)  -- still needs to be removed for worgens shifting to running wild stance - handled in code
	45438,  -- Ice Block (Mages)  -- takes too long to cool down after removal
	59831,  -- Underbelly Elixir (from Underbelly Elixir - Dalaran) - one of the random effects turning player into a wasp
	--	61316,	-- Arcane Brilliance (Mages) -- USED FOR TESTING PURPOSES ONLY
	61716,  -- Rabbit Costume (from Blossoming Branch - Noblegarden / Easter)
	61734,  -- Noblegarden Bunny (from Brightly Colored Egg - Noblegarden / Easter)
	71484,  -- Strength of the Taunka (from Deathbringer's Will)
	71485,  -- Agility of the Vrykul (from Deathbringer's Will)
	71486,  -- Power of the Taunka (from Deathbringer's Will)
	--71487,  -- Precision of the Iron Dwarves (from Deathbringer's Will)			-- removed by Blizzard on MoP beta
	71491,  -- Aim of the Iron Dwarves (from Deathbringer's Will)
	71492,  -- Speed of the Vrykul (from Deathbringer's Will)
	71556,  -- Agility of the Vrykul (from Heroic Deathbringer's Will)
	--71557,  -- Precision of the Iron Dwarves (from Heroic Deathbringer's Will)		 -- removed by Blizzard on MoP beta
	71558,  -- Power of the Taunka (from Heroic Deathbringer's Will)
	71559,  -- Aim of the Iron Dwarves (from Heroic Deathbringer's Will)
	71560,  -- Speed of the Vrykul (from Heroic Deathbringer's Will)
	71561,  -- Strength of the Taunka (from Heroic Deathbringer's Will)
	75724,	-- Seeds of Discord (Mount Hyjal quest from item "Ogre Disguise" itemid 55137)
	91760,	-- Endure the Transformation (from Bones of Transformation)
	91771,	-- Wisp Form (from Wisp Amulet)
	98445,  -- Trapped In Amber (from Ancient Amber)  	-- requires 2 clicks to mount
	114282,  -- Treant Form (Druid glyph in Warcraft 6.0)
	122099,  -- Bamboozled (from /love Meng Meng in SW)
	165185,	-- Bloodclaw Charm (from Bloodmaine Claw toy)
	167399,	-- Make Like A Tree (from Ancient's Bloom toy)  	-- requires 2 clicks to mount
	172010,	-- Abomination Costume  (from trick-or-treating at the inns)
	172015,	-- Geist Costume (from trick-or-treating at the inns)
	172020,	-- Spider Costume (from trick-or-treating at the inns)
--  Removed the items below now that they temporarily shift back to normal form for mounting and don't need to be removed
--	24732,  -- Bat costume (from trick-or-treating in Inns)
--	172003,	-- Slime Costume (from trick-or-treating at inns)
--	172008,	-- Ghoul Costume (from trick-or-treating at inns)
--	190968, -- Myserious Brew
--	191211, -- Nerubian Constume (from tirick-or-treating at inns)
}

GoGo_Variables.GroundSpeed = {
	200,  -- Ground fast
	160,  -- Ground slow
	100,  -- Ground really slow
}

GoGo_Variables.AirSpeed = {
	410,  -- Air faster
	380,  -- Air fast
	250,  -- Air slow
}

GoGo_Variables.WaterSpeed = {
	371,  -- Abyssal Seahorse
	108,  -- Subdued Seahorse
	91,  -- Master Angler
	67,  -- Water normal
}

GoGo_Variables.WaterSurfaceSpeed = {
	371,  -- Abyssal Seahorse
	200,  -- Water surface ground mounts such as water striders
	108,  -- Subdued Seahorse
	91,  -- Master Angler
	67,  -- Water normal
}

GoGo_Variables.ZoneMapID = {
	[1] = 4,
	[2] = 4,
	[3] = 4,
	[4] = 4,
	[5] = 4,
	[6] = 4,
	[7] = 9,
	[8] = 9,
	[9] = 9,
	[10] = 11,
	[11] = 11,
	[12] = 13,
	[13] = 14,
	[14] = 16,
	[15] = 17,
	[16] = 17,
	[17] = 19,
	[18] = 20,
	[19] = 20,
	[20] = 20,
	[21] = 21,
	[22] = 22,
	[23] = 23,
	[24] = 23,
	[25] = 24,
	[26] = 26,
	[27] = 27,
	[28] = 27,
	[29] = 27,
	[30] = 27,
	[31] = 27,
	[32] = 28,
	[33] = 28,
	[34] = 28,
	[35] = 28,
	[36] = 29,
	[37] = 30,
	[38] = 30,
	[39] = 30,
	[40] = 30,
	[41] = 30,
	[42] = 32,
	[43] = 32,
	[44] = 32,
	[45] = 32,
	[46] = 32,
	[47] = 34,
	[48] = 35,
	[49] = 36,
	[50] = 37,
	[51] = 38,
	[52] = 39,
	[53] = 39,
	[54] = 39,
	[55] = 39,
	[56] = 40,
	[57] = 41,
	[58] = 41,
	[59] = 41,
	[60] = 41,
	[61] = 41,
	[62] = 42,
	[63] = 43,
	[64] = 61,
	[65] = 81,
	[66] = 101,
	[67] = 101,
	[68] = 101,
	[69] = 121,
	[70] = 141,
	[71] = 161,
	[72] = 161,
	[73] = 161,
	[74] = 161,
	[75] = 161,
	[76] = 181,
	[77] = 182,
	[78] = 201,
	[79] = 201,
	[80] = 241,
	[81] = 261,
	[82] = 261,
	[83] = 281,
	[84] = 301,
	[85] = 321,
	[86] = 321,
	[87] = 341,
	[88] = 362,
	[89] = 381,
	[90] = 382,
	[91] = 401,
	[92] = 443,
	[93] = 461,
	[94] = 462,
	[95] = 463,
	[96] = 463,
	[97] = 464,
	[98] = 464,
	[99] = 464,
	[100] = 465,
	[101] = 466,
	[102] = 467,
	[103] = 471,
	[104] = 473,
	[105] = 475,
	[106] = 476,
	[107] = 477,
	[108] = 478,
	[109] = 479,
	[110] = 480,
	[111] = 481,
	[112] = 482,
	[113] = 485,
	[114] = 486,
	[115] = 488,
	[116] = 490,
	[117] = 491,
	[118] = 492,
	[119] = 493,
	[120] = 495,
	[121] = 496,
	[122] = 499,
	[123] = 501,
	[124] = 502,
	[125] = 504,
	[126] = 504,
	[127] = 510,
	[128] = 512,
	[129] = 520,
	[130] = 521,
	[131] = 521,
	[132] = 522,
	[133] = 523,
	[134] = 523,
	[135] = 523,
	[136] = 524,
	[137] = 524,
	[138] = 525,
	[139] = 525,
	[140] = 526,
	[141] = 527,
	[142] = 528,
	[143] = 528,
	[144] = 528,
	[145] = 528,
	[146] = 528,
	[147] = 529,
	[148] = 529,
	[149] = 529,
	[150] = 529,
	[151] = 529,
	[152] = 529,
	[153] = 530,
	[154] = 530,
	[155] = 531,
	[156] = 532,
	[157] = 533,
	[158] = 533,
	[159] = 533,
	[160] = 534,
	[161] = 534,
	[162] = 535,
	[163] = 535,
	[164] = 535,
	[165] = 535,
	[166] = 535,
	[167] = 535,
	[168] = 536,
	[169] = 540,
	[170] = 541,
	[171] = 542,
	[172] = 543,
	[173] = 543,
	[174] = 544,
	[175] = 544,
	[176] = 544,
	[177] = 544,
	[178] = 544,
	[179] = 545,
	[180] = 545,
	[181] = 545,
	[182] = 545,
	[183] = 601,
	[184] = 602,
	[185] = 603,
	[186] = 604,
	[187] = 604,
	[188] = 604,
	[189] = 604,
	[190] = 604,
	[191] = 604,
	[192] = 604,
	[193] = 604,
	[194] = 605,
	[195] = 605,
	[196] = 605,
	[197] = 605,
	[198] = 606,
	[199] = 607,
	[200] = 609,
	[201] = 610,
	[202] = 611,
	[203] = 613,
	[204] = 614,
	[205] = 615,
	[206] = 626,
	[207] = 640,
	[208] = 640,
	[209] = 640,
	[210] = 673,
	[213] = 680,
	[217] = 684,
	[218] = 685,
	[219] = 686,
	[220] = 687,
	[221] = 688,
	[222] = 688,
	[223] = 688,
	[224] = 689,
	[225] = 690,
	[226] = 691,
	[227] = 691,
	[228] = 691,
	[229] = 691,
	[230] = 692,
	[231] = 692,
	[232] = 696,
	[233] = 697,
	[234] = 699,
	[235] = 699,
	[236] = 699,
	[237] = 699,
	[238] = 699,
	[239] = 699,
	[240] = 699,
	[241] = 700,
	[242] = 704,
	[243] = 704,
	[244] = 708,
	[245] = 709,
	[246] = 710,
	[247] = 717,
	[248] = 718,
	[249] = 720,
	[250] = 721,
	[251] = 721,
	[252] = 721,
	[253] = 721,
	[254] = 721,
	[255] = 721,
	[256] = 722,
	[257] = 722,
	[258] = 723,
	[259] = 723,
	[260] = 724,
	[261] = 725,
	[262] = 726,
	[263] = 727,
	[264] = 727,
	[265] = 728,
	[266] = 729,
	[267] = 730,
	[268] = 730,
	[269] = 731,
	[270] = 731,
	[271] = 731,
	[272] = 732,
	[273] = 733,
	[274] = 734,
	[275] = 736,
	[276] = 737,
	[277] = 747,
	[279] = 749,
	[280] = 750,
	[281] = 750,
	[282] = 752,
	[283] = 753,
	[284] = 753,
	[285] = 754,
	[286] = 754,
	[287] = 755,
	[288] = 755,
	[289] = 755,
	[290] = 755,
	[291] = 756,
	[292] = 756,
	[293] = 757,
	[294] = 758,
	[295] = 758,
	[296] = 758,
	[297] = 759,
	[298] = 759,
	[299] = 759,
	[300] = 760,
	[301] = 761,
	[302] = 762,
	[303] = 762,
	[304] = 762,
	[305] = 762,
	[306] = 763,
	[307] = 763,
	[308] = 763,
	[309] = 763,
	[310] = 764,
	[311] = 764,
	[312] = 764,
	[313] = 764,
	[314] = 764,
	[315] = 764,
	[316] = 764,
	[317] = 765,
	[318] = 765,
	[319] = 766,
	[320] = 766,
	[321] = 766,
	[322] = 767,
	[323] = 767,
	[324] = 768,
	[325] = 769,
	[327] = 772,
	[328] = 773,
	[329] = 775,
	[330] = 776,
	[331] = 779,
	[332] = 780,
	[333] = 781,
	[334] = 782,
	[335] = 789,
	[336] = 789,
	[337] = 793,
	[338] = 795,
	[339] = 796,
	[340] = 796,
	[341] = 796,
	[342] = 796,
	[343] = 796,
	[344] = 796,
	[345] = 796,
	[346] = 796,
	[347] = 797,
	[348] = 798,
	[349] = 798,
	[350] = 799,
	[351] = 799,
	[352] = 799,
	[353] = 799,
	[354] = 799,
	[355] = 799,
	[356] = 799,
	[357] = 799,
	[358] = 799,
	[359] = 799,
	[360] = 799,
	[361] = 799,
	[362] = 799,
	[363] = 799,
	[364] = 799,
	[365] = 799,
	[366] = 799,
	[367] = 800,
	[368] = 800,
	[369] = 800,
	[370] = 803,
	[371] = 806,
	[372] = 806,
	[373] = 806,
	[374] = 806,
	[375] = 806,
	[376] = 807,
	[377] = 807,
	[378] = 808,
	[379] = 809,
	[380] = 809,
	[381] = 809,
	[382] = 809,
	[383] = 809,
	[384] = 809,
	[385] = 809,
	[386] = 809,
	[387] = 809,
	[388] = 810,
	[389] = 810,
	[390] = 811,
	[391] = 811,
	[392] = 811,
	[393] = 811,
	[394] = 811,
	[395] = 811,
	[396] = 811,
	[397] = 813,
	[398] = 816,
	[399] = 819,
	[400] = 819,
	[401] = 820,
	[402] = 820,
	[403] = 820,
	[404] = 820,
	[405] = 820,
	[406] = 820,
	[407] = 823,
	[408] = 823,
	[409] = 824,
	[410] = 824,
	[411] = 824,
	[412] = 824,
	[413] = 824,
	[414] = 824,
	[415] = 824,
	[416] = 851,
	[417] = 856,
	[418] = 857,
	[419] = 857,
	[420] = 857,
	[421] = 857,
	[422] = 858,
	[423] = 860,
	[424] = 862,
	[425] = 864,
	[426] = 864,
	[427] = 866,
	[428] = 866,
	[429] = 867,
	[430] = 867,
	[431] = 871,
	[432] = 871,
	[433] = 873,
	[434] = 873,
	[435] = 874,
	[436] = 874,
	[437] = 875,
	[438] = 875,
	[439] = 876,
	[440] = 876,
	[441] = 876,
	[442] = 876,
	[443] = 877,
	[444] = 877,
	[445] = 877,
	[446] = 877,
	[447] = 878,
	[448] = 880,
	[449] = 881,
	[450] = 882,
	[451] = 883,
	[452] = 884,
	[453] = 885,
	[454] = 885,
	[455] = 885,
	[456] = 886,
	[457] = 887,
	[458] = 887,
	[459] = 887,
	[460] = 888,
	[461] = 889,
	[462] = 890,
	[463] = 891,
	[464] = 891,
	[465] = 892,
	[466] = 892,
	[467] = 893,
	[468] = 894,
	[469] = 895,
	[470] = 895,
	[471] = 896,
	[472] = 896,
	[473] = 896,
	[474] = 897,
	[475] = 897,
	[476] = 898,
	[477] = 898,
	[478] = 898,
	[479] = 898,
	[480] = 899,
	[481] = 900,
	[482] = 900,
	[483] = 906,
	[486] = 911,
	[487] = 912,
	[488] = 914,
	[489] = 914,
	[490] = 919,
	[491] = 919,
	[492] = 919,
	[493] = 919,
	[494] = 919,
	[495] = 919,
	[496] = 919,
	[497] = 919,
	[498] = 920,
	[499] = 922,
	[500] = 922,
	[501] = 924,
	[502] = 924,
	[503] = 925,
	[504] = 928,
	[505] = 928,
	[506] = 928,
	[507] = 929,
	[508] = 930,
	[509] = 930,
	[510] = 930,
	[511] = 930,
	[512] = 930,
	[513] = 930,
	[514] = 930,
	[515] = 930,
	[516] = 933,
	[517] = 933,
	[518] = 934,
	[519] = 935,
	[520] = 937,
	[521] = 937,
	[522] = 938,
	[523] = 939,
	[524] = 940,
	[525] = 941,
	[526] = 941,
	[527] = 941,
	[528] = 941,
	[529] = 941,
	[530] = 941,
	[531] = 941,
	[532] = 941,
	[533] = 941,
	[534] = 945,
	[535] = 946,
	[536] = 946,
	[537] = 946,
	[538] = 946,
	[539] = 947,
	[540] = 947,
	[541] = 947,
	[542] = 948,
	[543] = 949,
	[544] = 949,
	[545] = 949,
	[546] = 949,
	[547] = 949,
	[548] = 949,
	[549] = 949,
	[550] = 950,
	[551] = 950,
	[552] = 950,
	[553] = 950,
	[554] = 951,
	[555] = 951,
	[556] = 953,
	[557] = 953,
	[558] = 953,
	[559] = 953,
	[560] = 953,
	[561] = 953,
	[562] = 953,
	[563] = 953,
	[564] = 953,
	[565] = 953,
	[566] = 953,
	[567] = 953,
	[568] = 953,
	[569] = 953,
	[570] = 953,
	[571] = 955,
	[572] = 962,
	[573] = 964,
	[574] = 969,
	[575] = 969,
	[576] = 969,
	[577] = 970,
	[578] = 970,
	[579] = 971,
	[580] = 971,
	[581] = 971,
	[582] = 973,
	[585] = 976,
	[586] = 976,
	[587] = 976,
	[588] = 978,
	[589] = 978,
	[590] = 980,
	[592] = 983,
	[593] = 984,
	[594] = 986,
	[595] = 987,
	[596] = 988,
	[597] = 988,
	[598] = 988,
	[599] = 988,
	[600] = 988,
	[601] = 989,
	[602] = 989,
	[606] = 993,
	[607] = 993,
	[608] = 993,
	[609] = 993,
	[610] = 994,
	[611] = 994,
	[612] = 994,
	[613] = 994,
	[614] = 994,
	[615] = 994,
	[616] = 995,
	[617] = 995,
	[618] = 995,
	[619] = 1007,
	[620] = 1008,
	[621] = 1008,
	[622] = 1009,
	[623] = 1010,
	[624] = 1011,
	[625] = 1014,
	[626] = 1014,
	[627] = 1014,
	[628] = 1014,
	[629] = 1014,
	[630] = 1015,
	[631] = 1015,
	[632] = 1015,
	[633] = 1015,
	[634] = 1017,
	[635] = 1017,
	[636] = 1017,
	[637] = 1017,
	[638] = 1017,
	[639] = 1017,
	[640] = 1017,
	[641] = 1018,
	[642] = 1018,
	[643] = 1018,
	[644] = 1018,
	[645] = 1020,
	[646] = 1021,
	[647] = 1021,
	[648] = 1021,
	[649] = 1022,
	[650] = 1024,
	[651] = 1024,
	[652] = 1024,
	[653] = 1024,
	[654] = 1024,
	[655] = 1024,
	[656] = 1024,
	[657] = 1024,
	[658] = 1024,
	[659] = 1024,
	[660] = 1024,
	[661] = 1026,
	[662] = 1026,
	[663] = 1026,
	[664] = 1026,
	[665] = 1026,
	[666] = 1026,
	[667] = 1026,
	[668] = 1026,
	[669] = 1026,
	[670] = 1026,
	[671] = 1027,
	[672] = 1028,
	[673] = 1028,
	[674] = 1028,
	[675] = 1028,
	[676] = 1031,
	[677] = 1032,
	[678] = 1032,
	[679] = 1032,
	[680] = 1033,
	[681] = 1033,
	[682] = 1033,
	[683] = 1033,
	[684] = 1033,
	[685] = 1033,
	[686] = 1033,
	[687] = 1033,
	[688] = 1033,
	[689] = 1033,
	[690] = 1033,
	[691] = 1033,
	[692] = 1033,
	[693] = 1033,
	[694] = 1034,
	[695] = 1035,
	[696] = 1037,
	[697] = 1038,
	[698] = 1039,
	[699] = 1039,
	[700] = 1039,
	[701] = 1039,
	[702] = 1040,
	[703] = 1041,
	[704] = 1041,
	[705] = 1041,
	[706] = 1042,
	[707] = 1042,
	[708] = 1042,
	[709] = 1044,
	[710] = 1045,
	[711] = 1045,
	[712] = 1045,
	[713] = 1046,
	[714] = 1047,
	[715] = 1048,
	[716] = 1049,
	[717] = 1050,
	[718] = 1051,
	[719] = 1052,
	[720] = 1052,
	[721] = 1052,
	[723] = 1054,
	[725] = 1056,
	[726] = 1057,
	[728] = 1059,
	[729] = 1060,
	[731] = 1065,
	[732] = 1066,
	[733] = 1067,
	[734] = 1068,
	[735] = 1068,
	[736] = 1069,
	[737] = 1070,
	[738] = 1071,
	[739] = 1072,
	[740] = 1073,
	[741] = 1073,
	[742] = 1075,
	[743] = 1075,
	[744] = 1076,
	[745] = 1076,
	[746] = 1076,
	[747] = 1077,
	[748] = 1078,
	[749] = 1079,
	[750] = 1080,
	[751] = 1081,
	[752] = 1081,
	[753] = 1081,
	[754] = 1081,
	[755] = 1081,
	[756] = 1081,
	[757] = 1082,
	[758] = 1084,
	[759] = 1085,
	[760] = 1086,
	[761] = 1087,
	[762] = 1087,
	[763] = 1087,
	[764] = 1088,
	[765] = 1088,
	[766] = 1088,
	[767] = 1088,
	[768] = 1088,
	[769] = 1088,
	[770] = 1088,
	[771] = 1088,
	[772] = 1088,
	[773] = 1090,
	[774] = 1090,
	[775] = 1091,
	[776] = 1092,
	[777] = 1094,
	[778] = 1094,
	[779] = 1094,
	[780] = 1094,
	[781] = 1094,
	[782] = 1094,
	[783] = 1094,
	[784] = 1094,
	[785] = 1094,
	[786] = 1094,
	[787] = 1094,
	[788] = 1094,
	[789] = 1094,
	[790] = 1096,
	[791] = 1097,
	[792] = 1097,
	[793] = 1099,
	[794] = 1100,
	[795] = 1100,
	[796] = 1100,
	[797] = 1100,
	[798] = 1102,
	[799] = 1104,
	[800] = 1104,
	[801] = 1104,
	[802] = 1104,
	[803] = 1104,
	[804] = 1105,
	[805] = 1105,
	[806] = 1114,
	[807] = 1114,
	[808] = 1114,
	[809] = 1115,
	[810] = 1115,
	[811] = 1115,
	[812] = 1115,
	[813] = 1115,
	[814] = 1115,
	[815] = 1115,
	[816] = 1115,
	[817] = 1115,
	[818] = 1115,
	[819] = 1115,
	[820] = 1115,
	[821] = 1115,
	[822] = 1115,
	[823] = 1116,
	[824] = 1126,
	[825] = 1127,
	[826] = 1129,
	[827] = 1130,
	[828] = 1131,
	[829] = 1132,
	[830] = 1135,
	[831] = 1135,
	[832] = 1135,
	[833] = 1135,
	[834] = 1136,
	[835] = 1137,
	[836] = 1137,
	[837] = 1139,
	[838] = 1140,
	[839] = 1142,
	[840] = 1143,
	[841] = 1143,
	[842] = 1143,
	[843] = 1144,
	[844] = 1145,
	[845] = 1146,
	[846] = 1146,
	[847] = 1146,
	[848] = 1146,
	[849] = 1146,
	[850] = 1147,
	[851] = 1147,
	[852] = 1147,
	[853] = 1147,
	[854] = 1147,
	[855] = 1147,
	[856] = 1147,
	[857] = 1148,
	[858] = 1149,
	[859] = 1150,
	[860] = 1151,
	[861] = 1152,
	[862] = 1153,
	[863] = 1154,
	[864] = 1155,
	[865] = 1156,
	[866] = 1156,
	[867] = 1157,
	[868] = 1158,
	[869] = 1159,
	[870] = 1159,
	[871] = 1160,
	[872] = 1161,
	[873] = 1161,
	[874] = 1161,
	[875] = 1162,
	[876] = 1163,
	[877] = 1164,
	[878] = 1165,
	[879] = 1165,
	[880] = 1165,
	[881] = 1166,
	[882] = 1170,
	[883] = 1170,
	[884] = 1170,
	[885] = 1171,
	[886] = 1171,
	[887] = 1171,
	[888] = 1172,
	[889] = 1173,
	[890] = 1173,
	[891] = 1174,
	[892] = 1174,
	[893] = 1174,
	[894] = 1174,
	[895] = 1175,
	[896] = 1176,
	[897] = 1177,
	[898] = 1177,
	[899] = 1177,
	[900] = 1177,
	[901] = 1177,
	[902] = 1177,
	[903] = 1178,
	[904] = 1183,
	[905] = 1184,
	[906] = 1185,
	[907] = 1186,
	[908] = 1187,
	[909] = 1188,
	[910] = 1188,
	[911] = 1188,
	[912] = 1188,
	[913] = 1188,
	[914] = 1188,
	[915] = 1188,
	[916] = 1188,
	[917] = 1188,
	[918] = 1188,
	[919] = 1188,
	[920] = 1188,
	[921] = 1190,
	[922] = 1191,
	[923] = 1192,
	[924] = 1193,
	[925] = 1194,
	[926] = 1195,
	[927] = 1196,
	[928] = 1197,
	[929] = 1198,
	[930] = 1199,
	[931] = 1200,
	[932] = 1201,
	[933] = 1202,
	[934] = 1204,
	[935] = 1204,
	[936] = 1205,
	[938] = 1210,
	[939] = 1211,
	[940] = 1212,
	[941] = 1212,
	[942] = 1213,
	[943] = 1214,
	[971] = 1215,
	[972] = 1216,
	[973] = 1217,
	[974] = 1219,
	[975] = 1219,
	[976] = 1219,
	[977] = 1219,
	[978] = 1219,
	[979] = 1219,
	[980] = 1219,
	[981] = 1220,
	[994] = 1184,
	[998] = 382
}
