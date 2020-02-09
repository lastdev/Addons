local _, ns = ...
local L = ns.L

local moss       = L["Moss-Covered Chest"]
local sturdy     = L["Sturdy Chest"]
local smoldering = L["Smoldering Chest"]
local skull      = L["Skull-Covered Chest"]
local blazing    = L["Blazing Chest"]

ns.points = {
	-- http://www.wowhead.com/achievement=8729/treasure-treasure-everywhere
	-- mapFiles 5th or 1st return of GetMapInfo()
	-- coord 1st and 2nd return of GetPlayerMapPosition("player") times 10,000
	-- 0.12345678 and 0.87654321 -> [12348765]
	[554] = { -- 'TimelessIsle'
		-- Moss-Covered Chests
		[22204930] = {type = moss, quest = 33175},
		[22246808] = {type = moss, quest = 33178},
		[22423535] = {type = moss, quest = 33174},
		[24623863] = {type = moss, quest = 33200, note = L['On a treestump']},
		[24755301] = {type = moss, quest = 33176},
		[25522721] = {type = moss, quest = 33171},
		[25664584] = {type = moss, quest = 33177},
		[26016145] = {type = moss, quest = 33199, note = L['On a treestump']},
		[26856875] = {type = moss, quest = 33179},
		[27363909] = {type = moss, quest = 33172},
		[29683174] = {type = moss, quest = 33202},
		[30603655] = {type = moss, quest = 33173, note = L['On a treestump']},
		[31007633] = {type = moss, quest = 33180},
		[34858422] = {type = moss, quest = 33184},
		[35367642] = {type = moss, quest = 33181},
		[36703403] = {type = moss, quest = 33170},
		[38737159] = {type = moss, quest = 33182},
		[39797953] = {type = moss, quest = 33183},
		[43568404] = {type = moss, quest = 33185},
		[44136546] = {type = moss, quest = 33198, note = L['On a treestump']},
		[46764678] = {type = moss, quest = 33187},
		[46955369] = {type = moss, quest = 33186},
		[49716572] = {type = moss, quest = 33195},
		[51174568] = {type = moss, quest = 33188},
		[52756286] = {type = moss, quest = 33197},
		[53097077] = {type = moss, quest = 33196},
		[55524434] = {type = moss, quest = 33189},
		[58015070] = {type = moss, quest = 33190},
		[59913132] = {type = moss, quest = 33201},
		[60176603] = {type = moss, quest = 33194},
		[61648849] = {type = moss, quest = 33227, note = L['In the shipwreck of Cpt. Zvezdan']},
		[63815915] = {type = moss, quest = 33192},
		[64917559] = {type = moss, quest = 33193},
		[65634783] = {type = moss, quest = 33191},
		-- Sturdy Chests
		[26676495] = {
			type = sturdy,
			quest = 33205,
			note = L['On the top of the cliff. Use the Highwind Albatross'],
		},
		[28193521] = {
			type = sturdy,
			quest = 33204,
			note = L['On the top of the cliff. Use the Highwind Albatross'],
		},
		[59254946] = {
			type = sturdy,
			quest = 33207,
			note = L['Inside the Mysterious Den. Use one of objects from Legends of the Past'],
		},
		[64687047] = {type = sturdy, quest = 33206},
		-- Smoldering Chests
		[53987805] = {type = smoldering, quest = 33209},
		[69573289] = {type = smoldering, quest = 33208},
		-- Skull-Covered Chest
		[46703230] = {
			type = skull,
			quest = 33203,
			note = L['Inside Cavern of Lost Spirits (entrance at 43.2, 41.3)'],
		},
		-- Blazing Chest
		[47262682] = {type = blazing, quest = 33210},
	},

	[555] = { -- 'CavernofLostSpirits'
		-- Skull-Covered Chest
		[62903480] = {type = skull, quest = 33203},
	}
}
