BINDING_HEADER_GOGOHEADER = "GoGoMount"
BINDING_NAME_GOGOBINDING = "Mount/Dismount"
BINDING_NAME_GOGOBINDING2 = "Mount/Dismount (no flying)"
BINDING_NAME_GOGOBINDING3 = "Mount/Dismount Passenger Mounts"

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
---------
function GoGo_GetMountDB()
---------
	GoGo_Variables.MountDB = {
		[25863] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Qiraji Battle Tank
		[25953] = {[38] = true, [201] = true, [330]=true, [402]=true, [10002]=160},  -- Blue Qiraji Battle Tank
		[26055] = {[38] = true, [201] = true, [330]=true, [402]=true, [10002]=160},  -- Yellow Qiraji Battle Tank
		[26054] = {[38] = true, [201] = true, [330]=true, [402]=true, [10002]=160},  -- Red Qiraji Battle Tank
		[26056] = {[38] = true, [201] = true, [330]=true, [402]=true, [10002]=160},  -- Green Qiraji Battle Tank
		[26655] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Qiraji Battle Tank
		[26656] = {[38] = true, [330]=true, [400]=true, [402]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Qiraji Battle Tank
		[92155] = {[38] = true, [330]=true, [400]=true, [402]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Ultramarine Qiraji Battle Tank

		[30174] = {[15] = true, [39] = true, [10001]=67, [10002]=100, [10004]=67},  -- Riding Turtle
		[64731] = {[15] = true, [39] = true, [402]=true, [404]=true, [10001]=108, [10002]=100, [10004]=108},  -- Sea Turtle
		
		[120395] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Green Dragon Turtle
		[120822] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Red Dragon Turtle
		[127286] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Dragon Turtle
		[127287] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Blue Dragon Turtle
		[127288] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Brown Dragon Turtle
		[127289] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Purple Dragon Turtle
		[127290] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Red Dragon Turtle
		[127293] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Green Dragon Turtle
		[127295] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Black Dragon Turtle
		[127302] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Blue Dragon Turtle
		[127308] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Brown Dragon Turtle
		[127310] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Purple Dragon Turtle
		
		[33184] = {[38] = true, [9] = true, [4] = true, [999] = true},  -- Swift Magic Broom  --  itemid
		[42667] = {[7] = true, [9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [402]=true, [403]=true, [600]=true, [601]=true, [10002]=160, [10003]=250, [50000]=33176},  -- Flying Broom  --  itemid
		[42668] = {[9] = true, [11] = true, [36] = true, [50000]=33182},  -- Swift Flying Broom  --  [50000]=33184
		[47977] = {[7]=true, [9] = true, [10]=true, [38] = true, [300]=true, [301]=true, [330]=true, [402]=true, [403]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67, [50000]=37011},  -- Magic Broom -- itemid
	
		[32243] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Tawny Wind Rider
		[32244] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Blue Wind Rider
		[32245] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Green Wind Rider
		[32246] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Swift Red Wind Rider
		[32295] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Swift Green Wind Rider
		[32296] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Swift Yellow Wind Rider
		[32297] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Swift Purple Wind Rider
		[61230] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Armored Blue Wind Rider
		[64762] = {[9] = true, [39] = true, [52] = true, ["FlightOnly"] = true, [10003]=250, [50000]=44229},  -- Loaned Wind Rider Reins
		[107517] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Spectral Wind Rider

		[135418] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Grand Armored Wyvern
		[136164] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Grand Wyvern

		[37015] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Swift Nether Drake
		[41513] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Onyx Netherwing Drake
		[41514] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Azure Netherwing Drake
		[41515] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Cobalt Netherwing Drake
		[41516] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Purple Netherwing Drake
		[41517] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Veridian Netherwing Drake
		[41518] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Violet Netherwing Drake
		[44317] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Merciless Nether Drake
		[44744] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Merciless Nether Drake
		[49193] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Vengeful Nether Drake
		[58615] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Brutal Nether Drake

		[39798] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Green Riding Nether Ray
		[39800] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Red Riding Nether Ray
		[39801] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Purple Riding Nether Ray
		[39802] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Silver Riding Nether Ray
		[39803] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Blue Riding Nether Ray

		[43927] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Cenarion War Hippogryph
		[63844] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Argent Hippogryph
		[66087] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Silver Covenant Hippogryph
		[74856] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Blazing Hippogryph
		[97359] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Flameward Hippogryph
		[102514] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Corrupted Hippogryph
		[149801] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Emerald Hippogryph

		[43810] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Frost Wyrm
		[51960] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Frostwyrm Mount
		[64927] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Deadly Gladiator's Frostwyrm
		[65439] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Furious Gladiator's Frost Wyrm
		[67336] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Relentless Gladiator's Frost Wyrm
		[71810] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Wrathful Gladiator's Frost Wyrm
		
		[72807] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Icebound Frostbrood Vanquisher
		[72808] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Bloodbathed Frostbrood Vanquisher

		[3363] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Nether Drake
		[28828] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Nether Drake
		[49345] = {[9] = true, [54] = true, ["FlightOnly"] = true, [50000]=37815},  -- Emerald Drake
		[49461] = {[9] = true, [54] = true, ["FlightOnly"] = true, [50000]=37859},  -- Amber Drake
		[49462] = {[9] = true, [54] = true, ["FlightOnly"] = true, [50000]=37860},  -- Ruby Drake
		[59567] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Azure Drake
		[59568] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Blue Drake
		[59569] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Bronze Drake
		[59570] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Red Drake
		[59571] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Twilight Drake
		[59650] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Black Drake
		[60025] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Albino Drake
		[69395] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Onyxian Drake
		[88331] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67}, -- Volcanic Stone Drake
		[88335] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Drake of the East Wind
		[88718] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Phosphorescent Stone Drake
		[88741] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Drake of the West Wind
		[88742] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Drake of the North Wind
		[88744] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Drake of the South Wind
		[88746] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Vitreous Stone Drake
		[93326] = {[2] = true, [9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Sandstone Drake
		[93623] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Mottled Drake
		[101282] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Vicious Gladiator's Twilight Drake
		[101821] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Ruthless Gladiator's Twilight Drake
		[107842] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Blazing Drake
		[107844] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Twilight Harbinger
		[107845] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Life-Binder's Handmaiden
		[113120] = {[9]=true, [38]=true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Feldrake

		[59961] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Red Proto-Drake
		[59976] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Black Proto-Drake
		[59996] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Blue Proto-Drake
		[60002] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Time-Lost Proto-Drake
		[60021] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Plagued Proto-Drake
		[60024] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Violet Proto-Drake
		[61294] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Green Proto-Drake
		[63956] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Ironbound Proto-Drake
		[63963] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Rusted Proto-Drake
		[148392] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Spawn of Galakras

		[32345] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Peep the Phoenix Mount
		[40192] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Ashes of Al'ar
		[88990] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Dark Phoenix
		[129552] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Crimson Pandaren Phoenix
		[132117] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Ashen Pandaren Phoenix
		[132118] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Emerald Pandaren Phoenix
		[132119] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Violet Pandaren Phoenix

		[97493] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Pureblood Fire Hawk / Crimson Fire Hawk
		[97501] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Felfire Hawk / Green Fire Hawk / Beryl Fire Hawk
		[97560] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Corrupted Fire Hawk

		[54726] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Winged Steed of the Ebon Blade
		[54727] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Winged Steed of the Ebon Blade
		[54729] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Winged Steed of the Ebon Blade

		[32235] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Golden Gryphon
		[32239] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Ebon Gryphon
		[32240] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Snowy Gryphon
		[32242] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Swift Blue Gryphon
		[32289] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Swift Red Gryphon
		[32290] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Swift Green Gryphon
		[32292] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Swift Purple Gryphon
		[55164] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Swift Spectral Gryphon
		[61229] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Armored Snowy Gryphon
		[64749] = {[9] = true, [18] = true, [39] = true, [52] = true, ["FlightOnly"] = true, [10003]=250, [50000]=44221},  -- Loaned Gryphon Reins
		[107516] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Spectral Gryphon
		[135416] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Grand Armored Gryphon
		[136163] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Grand Gryphon


		[459] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Gray Wolf
		[578] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Wolf
		[579] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Red Wolf
		[580] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Timber Wolf
		[581] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Winter Wolf
		[6653] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Dire Wolf
		[6654] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Brown Wolf
		[16080] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Red Wolf
		[16081] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Winter Wolf
		[22724] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black War Wolf
		[23250] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Brown Wolf
		[23251] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Timber Wolf
		[23252] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Gray Wolf
		[23509] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Frostwolf Howler
		[63640] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Origimmar Wolf (Swift Orgrimmar Wolf)
		[64658] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Wolf
		[65646] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Burgundy Wolf
		[68056] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Horde Wolf
		[92232] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Spectral Wolf
		[100333] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Vicious War Wolf
		[145133] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67, [50000]=101675},  -- Moonfang
		[148396] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Kor'kron War Wolf
		[164222] = {[5]=true, [39]=true, [202]=true, [330]=true, [402]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Frostwolf War Wolf
		[171842] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Frostwolf

		[18363] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Riding Kodo
		[18989] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Gray Kodo
		[18990] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Brown Kodo
		[18991] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Green Kodo
		[18992] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Teal Kodo
		[22718] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black War Kodo
		[23247] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great White Kodo
		[23248] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Gray Kodo
		[23249] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Brown Kodo
		[49378] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Brewfest Riding Kodo
		[49379] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Brewfest Kodo
		[50869] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Brewfest Kodo
		[63641] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Thunder Bluff Kodo (Great Mulgore Kodo)
		[64657] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- White Kodo
		[65641] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Golden Kodo
		[69820] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Sunwalker Kodo
		[69826] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Sunwalker Kodo

		[34795] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Red Hawkstrider
		[35018] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Purple Hawkstrider
		[35020] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Blue Hawkstrider
		[35022] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Hawkstrider
		[33660] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Pink Hawkstrider
		[35025] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Green Hawkstrider
		[35027] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Purple Hawkstrider
		[35028] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Warstrider
		[46628] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift White Hawkstrider
		[41252] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Raven Lord
		[63642] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Silvermoon Hawkstrider (Swift Silvermoon Hawkstrider)
		[65639] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Red Hawkstrider
		[66091] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Sunreaver Hawkstrider
		[101542] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Flametalon of Alyzrazor
		[179478] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Voidtalon of the Dark Star

		[101573] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Shorestrider
		[102346] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Forest Strider
		[102349] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Springstrider
		[102350] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Lovebird
		
		[65917] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Magic Rooster
		[66122] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Magic Rooster
		[66123] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Magic Rooster
		[66124] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Magic Rooster

		[34790] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Dark War Talbuk
		[34896] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Cobalt War Talbuk
		[34897] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- White War Talbuk
		[34898] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Silver War Talbuk
		[34899] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Tan War Talbuk
		[39315] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Cobalt Riding Talbuk
		[39316] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Dark Riding Talbuk
		[39317] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Silver Riding Talbuk
		[39318] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Tan Riding Talbuk
		[39319] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- White Riding Talbuk
		[165803] = {[5]=true, [39] = true, [202]=true, [330]=true, [402]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Telaari Talbuk

		[130086] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Brown Riding Goat
		[130137] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- White Riding Goat
		[130138] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Riding Goat

		[6777] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Gray Ram
		[6896] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Ram
		[6898] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- White Ram
		[6899] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Brown Ram
		[17460] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Frost Ram
		[17461] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Ram
		[22720] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black War Ram
		[23238] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Brown Ram
		[23239] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Gray Ram
		[23240] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift White Ram
		[23510] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Stormpike Battle Charger
		[43899] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Brewfest Ram
		[43900] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Brewfest Ram
		[63636] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Ironforge Ram (Swift Ironforge Ram)
		[65643] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Violet Ram

		[10873] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Red Mechanostrider
		[10969] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Blue Mechanostrider
		[15779] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- White Mechanostrider Mod B
		[15780] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Green Mechanostrider
		[15781] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Steel Mechanostrider
		[17453] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Green Mechanostrider
		[17454] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Unpainted Mechanostrider
		[17455] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Purple Mechanostrider
		[17456] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Red and Blue Mechanostrider
		[17458] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Fluorescent Green Mechanostrider
		[17459] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Icy Blue Mechanostrider Mod A
		[22719] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Battlestrider
		[23222] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Yellow Mechanostrider
		[23223] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift White Mechanostrider
		[23225] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Green Mechanostrider
		[33630] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Blue Mechanostrider
		[63638] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Gnomeregan Mechanostrider (Turbostrider)
		[65642] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Turbostrider

		[123160] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Crimson Riding Crane
		[127174] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Azure Riding Crane
		[127176] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Golden Riding Crane
		[127177] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Regal Riding Crane
		[127178] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Jungle Riding Crane
		[127180] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Albino Riding Crane

		[8395] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Emerald Raptor
		[10795] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Ivory Raptor
		[10796] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Turquoise Raptor
		[10799] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Violet Raptor
		[16084] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Mottled Red Raptor
		[17450] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Ivory Raptor
		[22721] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black War Raptor
		[23241] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Blue Raptor
		[23242] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Olive Raptor
		[23243] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Orange Raptor
		[24242] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Razzashi Raptor
		[63635] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Darkspear Raptor (Swift Darkspear Raptor)
		[64659] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Venomhide Ravasaur
		[65644] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Purple Raptor
		[84751] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Fossilized Raptor
		[96491] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Armored Razzashi Raptor
		[97581] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Savage Raptor
		[138640] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Bone-White Primal Raptor
		[138641] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Red Primal Raptor
		[138642] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Primal Raptor
		[138643] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Green Primal Raptor

		[138423] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Cobalt Primordial Direhorn
		[138424] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Amber Primordial Direhorn
		[138425] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Slate Primordial Direhorn
		[138426] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Jade Primordial Direhorn
		[140249] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Golden Primal Direhorn
		[140250] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Crimson Primal Direhorn
		

		[43688] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Amani War Bear
		[51412] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Big Battle Bear
		[54753] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- White Polar Bear Mount
		[58983] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Big Blizzard Bear  -------------------------------------------------------------
		[59572] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Polar Bear
		[59573] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Brown Polar Bear
		[60114] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Armored Brown Bear
		[60116] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Armored Brown Bear
		[60118] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black War Bear
		[60119] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black War Bear
		--[64987] = {[38] = true, [999] = true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10004]=67},  --Big Blizzard Bear [PH] - ticket 211
		[98204] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Amani Battle Bear
		[103081] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Darkmoon Dancing Bear
		
		[8394] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Striped Frostsaber
		[10789] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Spotted Frostsaber
		[10793] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Striped Nightsaber
		[16055] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Nightsaber
		[16056] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Ancient Frostsaber
		[16058] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Primal Leopard
		[16059] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Tawny Sabercat
		[16060] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Golden Sabercat
		[17229] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Winterspring Frostsaber
		[22723] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black War Tiger
		[23219] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Mistsaber
		[23220] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Dawnsaber
		[23221] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Frostsaber
		[23338] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Stormsaber
		[24252] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Zulian Tiger
		[42776] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Spectral Tiger
		[42777] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Spectral Tiger
		[63637] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Darnassian Nightsaber (Swift Darnassian Mistsaber)
		[65638] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Moonsaber
		[66847] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Striped Dawnsaber
		[96499] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Zulian Panther
		[129932] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Green Shado-Pan Riding Tiger
		[129934] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Blue Shado-Pan Riding Tiger
		[129935] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Red Shado-Pan Riding Tiger
		[146615] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Vicious Warsaber
		[180545] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Mystic Runesaber
		
		[120043] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Jeweled Onyx Panther
		[121836] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Sapphire Panther
		[121837] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Jade Panther / Emerald Panther
		[121838] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Ruby Panther
		[121839] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Sunstone Panther / Dawnstone Panther

		[458] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Brown Horse
		[468] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- White Stallion
		[470] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Stallion
		[471] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Palamino
		[472] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Pinto
		[5784] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [406]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Felsteed
		[6648] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Chestnut Mare
		[8980] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Skeletal Horse
		[13819] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Warhorse
		[16082] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Palomino
		[16083] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- White Stallion
		[17462] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Red Skeletal Horse
		[17463] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Blue Skeletal Horse
		[17464] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Brown Skeletal Horse
		[17465] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Green Skeletal Warhorse
		[17481] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Rivendare's Deathcharger
		[22717] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black War Steed
		[22722] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Red Skeletal Warhorse
		[23161] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [406]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Dreadsteed
		[23214] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Charger
		[23227] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Palomino
		[23228] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift White Steed
		[23229] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Brown Steed
		[23246] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Purple Skeletal Warhorse
		[34767] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Summon Charger
		[34769] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Summon Warhorse
		[36702] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Fiery Warhorse
		[48025] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Headless Horseman's Mount
		[48778] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Acherus Deathcharger
		[58819] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Brown Steed
		[63232] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Stormwind Steed (Swift Stormwind Steed)
		[63643] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Forsaken Warhorse
		[64656] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Blue Skeletal Warhorse
		[64977] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Skeletal Horse
		[65640] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Gray Steed
		[65645] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- White Skeletal Warhorse
		[66090] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Quel'dorei Steed
		[66846] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Ochre Skeletal Warhorse
		[66906] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Argent Charger
		[66907] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Argent Warhorse
		[67466] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Argent Warhorse
		[68057] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Alliance Steed
		[68187] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Crusader's White Warhorse
		[68188] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Crusader's Black Warhorse
		[72286] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Invincible
		[73313] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Crimson Deathcharger
		[75614] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Celestial Steed
		[92231] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Spectral Steed
		[100332] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Vicious War Steed
		[103195] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Mountain Horse
		[103196] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Mountain Horse
		[107203] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Tyrael's Charger
		[134573] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Swift Windsteed
		[136505] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Ghastly Charger
		[142073] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Hearthsteed
		[146622] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Vicious Skeletal Warhorse
		[148970] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [406]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Felsteed
		[148972] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [406]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Dreadsteed

		[34406] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Brown Elekk
		[34407] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Elite Elekk
		[35710] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Gray Elekk
		[35711] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Purple Elekk
		[35712] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Green Elekk
		[35713] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Blue Elekk
		[35714] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Purple Elekk
		[47037] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift War Elekk
		[48027] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black War Elekk
		[63639] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Exodar Elekk  (Great Azuremyst Elekk)
		[65637] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grea Red Elekk (Blizzard typo on PTR?)
		[73629] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Exarch's Elekk
		[73630] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Exarch's Elekk

		[122708] = {[2]=true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grand Expedition Yak
		[123182] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- White Riding Yak
		[127209] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Riding Yak
		[127213] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Brown Riding Yak
		[127216] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grey Riding Yak
		[127220] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Blonde Riding Yak
		
		[88748] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Brown Riding Camel
		[88749] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Tan Riding Camel
		[88750] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grey Riding Camel
		[102488] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- White Riding Camel

		[50281] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Warp Stalker

		[118089] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=200},  -- Azure Water Strider  (walks on water)
		[127271] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=200},  -- Crimson Water Strider  (walks on water)
		[127272] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=200},  -- Orange Water Strider  (walks on water)
		[127274] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=200},  -- Jade Water Strider  (walks on water)
		[127278] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=200},  -- Golden Water Strider  (walks on water)
	
		[59785] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black War Mammoth
		[59788] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black War Mammoth
		[59791] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Wooly Mammoth
		[59793] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Wooly Mammoth
		[59797] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Ice Mammoth
		[59799] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Ice Mammoth
		[59802] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grand Ice Mammoth
		[59804] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grand Ice Mammoth
		[59810] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grand Black War Mammoth
		[59811] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grand Black War Mammoth
		[60136] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grand Caravan Mammoth
		[60140] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grand Caravan Mammoth
		[61425] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Traveler's Tundra Mammoth
		[61447] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Traveler's Tundra Mammoth
		[61465] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grand Black War Mammoth
		[61466] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grand Black War Mammoth
		[61467] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grand Black War Mammoth
		[61469] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grand Ice Mammoth
		[61470] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grand Ice Mammoth
		
		[48954] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Zhevra
		[49322] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Zhevra

		[46199] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- X-51 Nether-Rocket X-TREME
		[46197] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- X-51 Nether-Rocket
		[71342] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [403]=true, [10002]=160, [10003]=250},  -- Big Love Rocket
		[75973] = {[2] = true, [9] = true, [39] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- X-53 Touring Rocket
		[126507] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Depleted-Kyparium Rocket
		[126508] = {[9] = true, [39] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Geosynchronous World Spinner

		[44151] = {[9] = true, [39] = true, [46] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Turbo-Charged Flying Machine
		[44153] = {[9] = true, [36] = true, [45] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Flying Machine
		[55531] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Mechano-hog
		[60424] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Mekgineer's Chopper
		[63796] = {[9] = true, [36] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Mimiron's Head
		[66393] = {[7] = true, [10002]=200, [50000]=46856}, -- Keys to the Hot Rod
		[76203] = {[55] = true, [200] = true, [10004]=286, [50000]=55121},  -- River Boat
		[87090] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67}, -- Goblin Trike
		[87091] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67}, -- Goblin Turbo-Trike
		[134359] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Sky Golem (The Sky Claw)
		[171845] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Warlord's Deathwheel
		[179244] = {[39] = true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Summon Chauffeur
		[179245] = {[39] = true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Summon Chauffeur

		[61309] = {[9] = true, [49] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Magnificent Flying Carpet
		[61442] = {[9] = true, [47] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Swift Mooncloth Carpet
		[61444] = {[9] = true, [47] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Swift Shadoweave Carpet
		[61446] = {[9] = true, [47] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Swift Spellfire Carpet
		[61451] = {[9] = true, [48] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Flying Carpet
		[75596] = {[9] = true, [49] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Frosty Flying Carpet
		--	[????] = {[11] = true, [47] = true, [9] = true, [36] = true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10004]=67},  -- Swift Flying Carpet   --- item 39303
		[169952] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Creeping Carpet  (the one that can't fly even though tooltip shows it can)

		[61996] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Blue Dragonhawk
		[61997] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Red Dragonhawk
		[62048] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Black Dragonhawk Mount
		[66088] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Sunreaver Dragonhawk
		[96503] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Amani Dragonhawk
		[142266] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Armored Red Dragonhawk
		[142478] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Armored Blue Dragonhawk
		
		[113199] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Jade Cloud Serpent
		[123992] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Azure Cloud Serpent
		[123993] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Golden Cloud Serpent
		[124408] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Thundering Jade Cloud Serpent
		[127154] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Onyx Cloud Serpent
		[127156] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Crimson Cloud Serpent
		[127158] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Heavenly Onyx Cloud Serpent
		[127161] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Heavenly Crimson Cloud Serpent
		[127164] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Heavenly Golden Cloud Serpent
		[127165] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Heavenly Jade Cloud Serpent
		[127169] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Heavenly Azure Cloud Serpent
		[127170] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Astral Cloud Serpent
		[129918] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Thundering August Cloud Serpent
		[132036] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Thundering Ruby Cloud Serpent
		[139407] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Malevolent Gladiator's Cloud Serpent
		[139442] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Thundering Cobolt Cloud Serpent
		[148476] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Thundering Onyx Cloud Serpent
		[148618] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Tyrannical Gladiator's Cloud Serpent
		[148619] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Grievous Gladiator's Cloud Serpent
		[148620] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Prideful Gladiator's Cloud Serpent

		[139448] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Clutch of Ji-Kun

		[75207] = {[36] = true, [53] = true, [401] = true, [10001]=371, [10004]=371},  -- Abyssal Seahorse (was Abyssal Manta)
		[98718] = {[36] = true, [53] = true, [404] = true, [10001]=108, [10004]=108},  -- Subdued Seahorse

		[142641] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Brawler's Burly Mushan Beast
		[148428] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Ashhide Mushan Beast

		[171627] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Blacksteel Battleboar
		[171628] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Rocktusk Battleboar
		[171629] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Armored Frostboar
		[171632] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Frostplains Battleboar

		[121820] = {[2] = true, [9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Obsidian Nightwing

		[118737] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Pandaren Kite
		[130985] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Pandaren Kite
		[133023] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Jade Pandaren Kite

		[93644] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Kor'kron Annihilator
		[123886] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Amber Scorpion
		[148417] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Kor'kron Juggernaut

		[24347] = {[7]=true, [8]=true, [10001]=91, [10004]=91, [50000]=19979},  -- Master Angler
		
		[74918] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Wooly White Rhino
		[136471] = {[37] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Spawn of Horridon

		[155741] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Dread Raven
		
		[90621] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Golden King

		[136400] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Armored Skyscreamer

		[98727] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Winged Guardian
		[101641] = {[9] = true, [19] = true, [39] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67, [50000]=71086},  -- Tarecgosa's Visage
	--	[62087] = {[15] = true, [39] = true, [53] = true, [999] = true},  -- Aquatic Riding Ray   -- removed from the 3.1 PTR datafiles
		[110039] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Experiment 12-B
		[110051] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Heart of the Aspects
		[124659] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Imperial Quilen
		[130092] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Red Flying Cloud
		[130965] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Son of Galleon
		[139595] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Armored Bloodwing
		[142878] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Enchanted Fey Dragon
		[153489] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Iron Skyreaver (Iron Chimaera)

		[147595] = {[9]=true, [38]=true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Stormcrow

		-- Spells, shape forms, etc
		[40120] = {[7] = true, [9] = true, [300] = true, [403] = true, [9998] = true, ["FlightOnly"] = true, [10003]=380},  -- Druid Swift Flight Form
		[33943] = {[7] = true, [9] = true, [300] = true, [301] = true, [403] = true, [9998] = true, ["FlightOnly"] = true, [10003]=250},  -- Druid Flight Form
		[165962] = {[7] = true, [9] = true, [300] = true, [301] = true, [403] = true, [501] = true, [9998] = true, ["FlightOnly"] = true, [10003]=250},  -- Druid Flight Form  (new form that appears with Glyph of the Stag with patch 6.0)
		[783] = {[7] = true, [500] = true, [1000]=true, [10002]=140}, -- Druid Travel Form
		[2645] = {[7] = true, [8] = true, [500] = true, [1000] = true, ["DefaultInstance"] = true, [10002]=130}, -- Shaman Ghost Wolf Form
		[768] = {[7] = true, [8] = true, [1000] = true, [500] = true, ["DefaultInstance"] = true, [10002]=125},  -- Druid Cat Form
		[1066] = {[7] = true, [53] = true, [500]=true, [1000]=true, [10001]=101, [10004]=101, ["DefaultInstance"] = true},  -- Druid Aqua form
		[5118] = {[7] = true, [8] = true, [500] = true, ["DefaultInstance"] = true, [10002]=138},  -- Aspect of the Cheeta
		[13159] = {[7] = true, [8] = true, [500] = true, ["DefaultInstance"] = true, [10002]=138},  -- Aspect of the Pack
		[87840] = {[14] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Running Wild (Worgen Racial)
		[125883] = {[7]=true, [9]=true, [403]=true, ["FlightOnly"]=true, [10003]=160},	-- Zen Flight (Monk glyph)

		-- Other ...
		[163016] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67, [9999]=true},  -- Warforged Nightmare

		-- 6.0.0 Mounts (may change before expansion is released)
		[150926] = {[9] = true, [36]=true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Draenor Chimera
		[163025] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Grinning Reaver
		[163024] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Warforged Nightmare
		[171618] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Ancient Leatherhide
		[171838] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Armored Frostwolf
		[171626] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Armored Irontusk
		[171630] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Armored Razorback
		[171620] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Bloodhoof Bull
		[171832] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Breezestrider Stallion
		[124550] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Cataclysmic Gladiator's Twilight Drake
		[171848] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Challenger's War Yeti
		[171846] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Champion's Treadblade
		[171847] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Cindermane Charger
		[170347] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Core Hound
		[171634] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Domesticated Razorback
		[171844] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Dustmane Direwolf
		[171625] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Dusty Rockhide
		[175700] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Emerald Drake
		[148626] = {[99999]=true, ["note"]="mount that only lasts 20 seconds?  adding here but excluding to prevent GoGoMount from flagging a unknown mount"},  -- Furious Ashhide Mushan
		[171851] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Garn Nighthowl
		[171836] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Garn Steelmaw
		[171635] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Giant Coldsnout
		[171436] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Gorestrider Gronnling
		[171636] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Greytusk
		[171621] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Ironhoof Destroyer
		[171839] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Ironside Warwolf
		[171825] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Mosshide Riverwallow
		[171622] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Mottled Meadowstomper
		[171826] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Mudback Riverbeast
		[171833] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Pale Thorngrazer
		[171824] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Sapphire Riverbeast
		[171624] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Shadowhide Pearltusk
		[171829] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Shadowmane Charger
		[171843] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Smoky Direwolf
		[171828] = {[9]=true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Solar Spirehawk
		[171849] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Sunhide Gronnling
		[171830] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Breezestrider
		[171617] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Trained Icehoof
		[171623] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Trained Meadowstomper
		[171638] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Trained Riverwallow
		[171637] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Trained Rocktusk
		[171831] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Trained Silverpelt
		[171841] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Trained Snarler
		[171619] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Tundra Icehoof
		[171834] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Vicious War Ram
		[171835] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Vicious War Raptor
		[171837] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Warsong Direfang
		[171633] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Wild Goretusk
		[171616] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Witherhide Cliffstomper

		-- 6.2
		[182912] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Felsteel Annihilator
		[183117] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Corrupted Dreadwing
		[183889] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Vicious War Mechanostrider
		[185052] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Vicious War Kodo
		[186305] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Infernal Direwolf
		[186828] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Primal Gladiator's Felblood Gronnling
		[189364] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Coalfist Gronnling
		[190690] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Bristling Hellboar
		[190977] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Deathtusk Felboar
		[191633] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Soaring Skyterror
		[189044] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Warmongering Gladiator's Felblood Gronnling
		[189043] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Wild Gladiator's Felblood Gronnling
		
		-- 6.2.1
		[194046] = {[9] = true, [35] = true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Swift Spectral Rylak  (may not be player useable, might be for dead players only.. added for now to prevent GoGoMount from detecting as misisng mount)
		[191314] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Minion of Grumpus
		[142910] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Ironbound Wraithcharger
		[189998] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Illidari Felstalker
		[189999] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Grove Warden
		[194464] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Eclipse Dragonhawk

		-- 6.2.3
		[201098] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Infinite Timereaver
		
		-- 7.0.1 - Legion
		[193007] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Demonsaber
		[190710] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Enchanted Chicken
		[200175] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Felsaber
		[193695] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Prestigious War Steed
		[204166] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Prestigious War Wolf
		[196681] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Spirit of Eche'ro

		[213158] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Predatory Bloodgazer
		[213163] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Snowfeather Hunter
		[213164] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Brilliant Direbeak
		[213165] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Viridian Sharptalon
		
		[171850] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Llothien Prowler

		[213134] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Felblaze Infernal
		[171827] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Hellfire Infernal
		[213349] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Flarecore Infernal
		[171840] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Coldflame Infernal
		[213350] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Frostshard Infernal

		[213339] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Northern Elderhorn

		[213115] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Bloodfang Widow
		[213209] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Steelbound Devourer
		[215159] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Long-Forgotten Hippogryph
		[225765] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Leyfeather Hippogryph
		[215558] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Ratstallion
		[220124] = {[50000]=139421},		-- Ratstallion Harness

		[222202] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Prestigious Bronze Courser
		[222238] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Prestigious Ivory Courser
		[222236] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Prestigious Royal Courser
		[222237] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Prestigious Forest Courser
		[222240] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Prestigious Azure Courser
		[222241] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Prestigious Midnight Courser

		[223814] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Mechanized Lumber Extractor
		[223341] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Vicious Gilnean Warhorse
		[223354] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Vicious War Trike
		[223363] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Vicious Warstrider
		[223578] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Vicious War Elekk
		[227956] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Arcadian War Turtle

		[227986] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Vindictive Gladiator's Storm Dragon
		[227988] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Fearless Gladiator's Storm Dragon
		[227989] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Cruel Gladiator's Storm Dragon
		[227991] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Ferocious Gladiator's Storm Dragon
		[227994] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Fierce Gladiator's Storm Dragon
		[227995] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Demonic Gladiator's Storm Dragon
		
		[214791] = {[36] = true, [53] = true, [404] = true, [10001]=108, [10004]=108},  -- Brinedeep Bottom-Feeder
		[223018] = {[36] = true, [53] = true, [404] = true, [10001]=108, [10004]=108},  -- Fathom Dweller

		[215545] = {[999]=true, [9999]=true},  -- Fel Bat (Test)
		[220508] = {[38] = true, [203]=true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67, [50000]=139505},  -- 7.0 Paladin Order Hall Mount Dummy

		-- 7.1.5
		[228919] = {[36] = true, [53] = true, [404] = true, [10001]=108, [10004]=108},  -- Darkwater Skate
		[229499] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Midnight
		[230401] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- White Hawkstrider
		[230844] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Rockspine Basilisk // Brawler's Burly Basilisk
		[230987] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Arcanist's Manasaber
		[231428] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Smoldering Ember Wyrm

		-- 7.2.0
		[232519] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Abyss Worm
		[229376] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Archmage's Prismatic Disc
		[229385] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Ban-Lu, Grandmaster's Companion
		[229388] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Battlelord's Bloodthirsty War Wyrm
		[242881] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Cloudwing Hippogryph
		[229387] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Deathlord's Vilebrood Vanquisher
		[231442] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Farseer's Raging Tempest
		[229377] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- High Priest's Lightsworn Seeker
		[231435] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Highlord's Golden Charger
		[231589] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Highlord's Valorous Charger
		[231587] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Highlord's Vengeful Charger
		[231588] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Highlord's Vigilant Charger
		[242874] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Highmountain Elderhorn
		[229439] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Huntmaster's Dire Wolfhawk
		[229438] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Huntmaster's Fierce Wolfhawk
		[229386] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Huntmaster's Loyal Wolfhawk
		[233364] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Leywoven Flying Carpet
		[238454] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Netherlord's Accursed Wrathsteed
		[238452] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Netherlord's Brimstone Wrathsteed
		[232412] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Netherlord's Chaotic Wrathsteed
		[232405] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Primal Flamesaber
		[243025] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Riddler's Mind-Worm
		[231524] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Shadowblade's Baneful Omen
		[231525] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Shadowblade's Crimson Omen
		[231523] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Shadowblade's Lethal Omen
		[231434] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Shadowblade's Murderous Omen
		[229417] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Slayer's Felbroken Shrieker
		[239363] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Swift Spectral Hippogryph
		[242882] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Valarjar Stormwing
		[229487] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Vicious War Bear
		[229486] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Vicious War Bear
		[229512] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Vicious War Lion
		[230988] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Vicious War Scorpion
		[232525] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Vicious War Turtle
		[232523] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Vicious War Turtle
		[242875] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Wild Dreamrunner

		-- 7.3.0
		[235764] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Darkspore Mana Ray
		[239013] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Lightforged Warframe
		[242305] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Sable Ruinstrider
		[242896] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Vicious War Fox
		[242897] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Vicious War Fox
		[243201] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Demonic Gladiator's Storm Dragon
		[243512] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Luminous Starseeker
		[243651] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Shackled Ur'zul
		[243652] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Vile Fiend
		[245723] = {[2] = true, [9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Stormwind Skychaser
		[245725] = {[2] = true, [9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Orgrimmar Interceptor
		[247402] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Lucid Nightmare
		[247448] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Darkmoon Dirigible
		[253004] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Amethyst Ruinstrider
		[253005] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Beryl Ruinstrider
		[253006] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Russet Ruinstrider
		[253007] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Cerulean Ruinstrider
		[253008] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Umber Ruinstrider
		[253058] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Maddened Chaosrunner
		[253087] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Antoran Gloomhound
		[253088] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Antoran Charhound
		[253106] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Vibrant Mana Ray
		[253107] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Lambent Mana Ray
		[253108] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Felglow Mana Ray
		[253109] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Scintillating Mana Ray
		[253639] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Violet Spellwing
		[253660] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Biletooth Gnasher
		[253661] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Crimson Slavermaw
		[253662] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Acid Belcher
		[253711] = {[36] = true, [53] = true, [404] = true, [10001]=108, [10004]=108},  -- Pond Nettle
		[254069] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Glorious Felcrusher
		[254258] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Blessed Felcrusher
		[254259] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Avenging Felcrusher
		[254260] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Bleakhoof Ruinstrider

		-- 7.3.5.25996
		[239766] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Blue Qiraji War Tank
		[239770] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Qiraji War Tank

		-- 8.0.1.25902
		[237286] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Dune Scavenger
		[237287] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Alabaster Hyena
		[237288] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Reins of the Onyx War Hyena
		[239049] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Obsidian Krolusk
		[239766] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67, [50000]=151626},  -- Blue Qiraji War Tank
		[239767] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67, [50000]=151625},  -- Red Qiraji War Tank
		[243795] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Leaping Veinseeker
		[250735] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Bloodgorged Crawg
		[254811] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Squawks
		[254813] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Summon Sharkbait
		[255695] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Seabraid Stallion
		[255696] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Gilded Ravasaur
		[258022] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Lightforged Felcrusher
		[258060] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Highmountain Thunderhoof
		[258845] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Nightborne Manasaber
		[259202] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Starcursed Voidstrider
		[259213] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Admiralty Stallion
		[259395] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Shu-Zen, the Divine Sentinel
		[259740] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Green Marsh Hopper
		[260172] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Dapple Gray
		[260173] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Smoky Charger
		[260174] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Terrified Pack Mule
		[260175] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Goldenmane
		[261395] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- The Hivemind
		[261433] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Vicious War Basilisk
		[261434] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Vicious War Basilisk
		[262022] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Dread Gladiator's Proto-Drake
		[263707] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Zandalari Direhorn
		[264058] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Mighty Caravan Brutosaur
		[272472] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Undercity Plaguebat
		[274610] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Teldrassil Hippogryph

		-- 8.0.1.26032
		[266058] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Tomb Stalker
		[267270] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Kua'fon
		[267274] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Mag'har Direwolf

		-- 8.0.1.26367
		[270560] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Vicious War Clefthoof
		[270562] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Summon Darkforge Ram
		[270564] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Summon Dawnforge Ram
		[271646] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Dark Iron Core Hound
		[272481] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Vicious War Riverbeast

		-- 8.0.1.26433
		[273541] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Underrot Crawg

		-- 8.0.1.26522
		[275623] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Nazjatar Blood Serpent
		[275837] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Cobalt Pterrordax
		[275841] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Expedition Bloodswarmer

		-- 8.0.1.26624
		[278803] = {[36] = true, [53] = true, [404] = true, [10001]=108, [10004]=108},  -- Great Sea Ray
		[278966] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Tempestuous Skystallion
		[278979] = {[36] = true, [53] = true, [404] = true, [10001]=108, [10004]=108},  -- Surf Jelly
		[279454] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Conquerer's Scythemaw
		[279456] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Highland Mustang
		[279457] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Broken Highland Mustang
		[279466] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Twilight Avenger
		[279467] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Craghorn Chasm-Leaper
		[279469] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Qinsho's Eternal Hound
		[279474] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Palehide Direhorn

		-- 8.0.1.26714
		[279569] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Albino Raptor
		[279608] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Lil' Donkey
		[279611] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Skullripper
		[279868] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Witherbark Direwing
		
		-- 8.0.1.26788
		[280729] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Frenzied Feltalon
		[280730] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Pureheart Courser
		[281044] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Prestigious Bloodforged Courser

		-- 8.0.1.27602
		[261437] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Mecha-Mogul Mk2
		[272770] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- The Dreadwake

		-- 8.1.0.27826
		[281887] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Vicious Black Warsaber
		[281888] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Vicious White Warsaber
		[281889] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Vicious White Bonesteed
		[281890] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Vicious Black Bonesteed

		-- 8.1.0.28151
		[288438] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Blackpaw
		[288495] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Ashenvale Chimaera
		[288499] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Frightened Kodo
		[288503] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Umber Nightsaber
		[288505] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Kaldorei Nightsaber
		[288506] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Sandy Nightsaber
		[288587] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Blue Marsh Hopper
		[288589] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Yellow Marsh Hopper

		-- 8.1.0.28202
		[288711] = {[36] = true, [53] = true, [404] = true, [10001]=108, [10004]=108},  -- Saltwater Seahorse
		[288712] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Stonehide Elderhorn
		[288714] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Bloodthirsty Dreadwing
		[288720] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Bloodgorged Hunter
		[288721] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Island Thunderscale
		[288722] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Risen Mare
		[288735] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Rubyshell Krolusk
		[288736] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Azureshell Krolusk
		[288740] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Priestess' Moonsaber
		[289083] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- G.M.O.D.
		[289101] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Dazar'alor Windreaver

		-- 8.1.0.28294
		[289555] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Glacial Tidestorm

		-- 8.1.0.28616
		[281554] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Meat Wagon

		-- 8.1.0.28724
		[290133] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Vulpine Familiar

		-- 8.1.5.28938
		[282682] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Kul Tiran Charger
		[289639] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Bruce

		-- 8.1.5.28938
		[290134] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Hogrus, Swine of Good Fortune

--		[123456] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10004]=67},  -- Standard Ground Mount template
--		[123456] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [701]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Standard Air & Ground Mount template
--		[123456] = {[36] = true, [53] = true, [404] = true, [10001]=108, [10004]=108},  -- Standard Water (surface and submerged) Mount template
	}
end --if

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
