local _, ns = ...

-- Dungeon listing sorted by id
ns.dungeons = {
    [1] = {
        ["id"] = 6951, -- id
        ["keystone_instance"] = 169, -- map_challenge_mode_id
        ["instance_map_id"] = 1195, -- wow_instance_id
        ["lfd_activity_ids"] = { 22, 30, 180, 402 }, -- https://wow.tools/dbc/?dbc=groupfinderactivity
        ["timers"] = { 1080, 1440, 1800 }, -- keystone_timer_seconds * 0.6 , keystone_timer_seconds * 0.8, keystone_timer_seconds
        ["name"] = "Iron Docks",
        ["shortName"] = "ID",
    },
    [2] = {
        ["id"] = 6984, -- id
        ["keystone_instance"] = 166, -- map_challenge_mode_id
        ["instance_map_id"] = 1208, -- wow_instance_id
        ["lfd_activity_ids"] = { 25, 33, 183, 405 }, -- https://wow.tools/dbc/?dbc=groupfinderactivity
        ["timers"] = { 1080, 1440, 1800 }, -- keystone_timer_seconds * 0.6 , keystone_timer_seconds * 0.8, keystone_timer_seconds
        ["name"] = "Grimrail Depot",
        ["shortName"] = "GD",
    },
    [3] = {
        ["id"] = 800001, -- id
        ["keystone_instance"] = 369, -- map_challenge_mode_id
        ["instance_map_id"] = 2097, -- wow_instance_id
        ["lfd_activity_ids"] = { 679, 682 }, -- https://wow.tools/dbc/?dbc=groupfinderactivity
        ["timers"] = { 1368, 1824, 2280 }, -- keystone_timer_seconds * 0.6 , keystone_timer_seconds * 0.8, keystone_timer_seconds
        ["name"] = "Mechagon Junkyard",
        ["shortName"] = "YARD",
    },
    [4] = {
        ["id"] = 800002, -- id
        ["keystone_instance"] = 370, -- map_challenge_mode_id
        ["instance_map_id"] = 2097, -- wow_instance_id
        ["lfd_activity_ids"] = { 683, 684 }, -- https://wow.tools/dbc/?dbc=groupfinderactivity
        ["timers"] = { 1152, 1536, 1920 }, -- keystone_timer_seconds * 0.6 , keystone_timer_seconds * 0.8, keystone_timer_seconds
        ["name"] = "Mechagon Workshop",
        ["shortName"] = "WORK",
    },
    [5] = {
        ["id"] = 999998, -- id
        ["keystone_instance"] = 227, -- map_challenge_mode_id
        ["instance_map_id"] = 1651, -- wow_instance_id
        ["lfd_activity_ids"] = { 470, 471 }, -- https://wow.tools/dbc/?dbc=groupfinderactivity
        ["timers"] = { 1512, 2016, 2520 }, -- keystone_timer_seconds * 0.6 , keystone_timer_seconds * 0.8, keystone_timer_seconds
        ["name"] = "Return to Karazhan: Lower",
        ["shortName"] = "LOWR",
    },
    [6] = {
        ["id"] = 999999, -- id
        ["keystone_instance"] = 234, -- map_challenge_mode_id
        ["instance_map_id"] = 1651, -- wow_instance_id
        ["lfd_activity_ids"] = { 472, 473 }, -- https://wow.tools/dbc/?dbc=groupfinderactivity
        ["timers"] = { 1260, 1680, 2100 }, -- keystone_timer_seconds * 0.6 , keystone_timer_seconds * 0.8, keystone_timer_seconds
        ["name"] = "Return to Karazhan: Upper",
        ["shortName"] = "UPPR",
    },
    [7] = {
        ["id"] = 1000000,
        ["keystone_instance"] = 391,
        ["instance_map_id"] = 2441,
        ["lfd_activity_ids"] = { 1016, 1018 },
        ["timers"] = { 1404, 1872, 2340 },
        ["name"] = "Tazavesh: Streets of Wonder",
        ["shortName"] = "STRT",
    },
    [8] = {
        ["id"] = 1000001,
        ["keystone_instance"] = 392,
        ["instance_map_id"] = 2441,
        ["lfd_activity_ids"] = { 1017, 1019 },
        ["timers"] = { 1080, 1440, 1800 },
        ["name"] = "Tazavesh: So'leah's Gambit",
        ["shortName"] = "GMBT",
    }
}

-- Raid listing sorted by id
ns.raids = {
	[1] = {
		["id"] = 13224,
		["instance_map_id"] = 2296,
		["lfd_activity_ids"] = { 720, 721, 722 },
		["name"] = "Fated Castle Nathria",
		["shortName"] = "FCN",
	},
	[2] = {
		["id"] = 13561,
		["instance_map_id"] = 2450,
		["lfd_activity_ids"] = { 743, 744, 745 },
		["name"] = "Fated Sanctum of Domination",
		["shortName"] = "FSOD",
	},
	[3] = {
		["id"] = 13742,
		["instance_map_id"] = 2481,
		["lfd_activity_ids"] = { 1020, 1021, 1022 },
		["name"] = "Fated Sepulcher of the First Ones",
		["shortName"] = "FSFO",
	}
}
