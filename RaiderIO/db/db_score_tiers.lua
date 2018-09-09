local _, ns = ...
ns.scoreTiers = {
	[1] = {
		["score"] = 6000,
		["color"] = { 0.90, 0.80, 0.50 } -- 6000+ #e6cc80 |cffe6cc806000+|r
	},
	[2] = {
		["score"] = 5500,
		["color"] = { 0.93, 0.73, 0.38 } -- 5500+ #ecb960 |cffecb9605500+|r
	},
	[3] = {
		["score"] = 5000,
		["color"] = { 0.95, 0.65, 0.25 } -- 5000+ #f2a640 |cfff2a6405000+|r
	},
	[4] = {
		["score"] = 4500,
		["color"] = { 0.97, 0.58, 0.13 } -- 4500+ #f89320 |cfff893204500+|r
	},
	[5] = {
		["score"] = 4000,
		["color"] = { 1, 0.5333333333333333, 0 }
	},
	[6] = {
		["score"] = 3800,
		["color"] = { 0.9254901960784314, 0.44313725490196076, 0.1843137254901961 }
	},
	[7] = {
		["score"] = 3600,
		["color"] = { 0.8549019607843137, 0.3843137254901961, 0.37254901960784315 }
	},
	[8] = {
		["score"] = 3400,
		["color"] = { 0.7803921568627451, 0.3254901960784314, 0.5568627450980392 }
	},
	[9] = {
		["score"] = 3200,
		["color"] = { 0.7450980392156863, 0.26666666666666666, 0.7098039215686275 }
	},
	[10] = {
		["score"] = 3000,
		["color"] = { 0.6392156862745098, 0.20784313725490197, 0.9333333333333333 }
	},
	[11] = {
		["score"] = 2800,
		["color"] = { 0.5098039215686274, 0.25098039215686274, 0.9176470588235294 }
	},
	[12] = {
		["score"] = 2600,
		["color"] = { 0.3803921568627451, 0.2980392156862745, 0.9058823529411765 }
	},
	[13] = {
		["score"] = 2400,
		["color"] = { 0.2549019607843137, 0.34509803921568627, 0.8901960784313725 }
	},
	[14] = {
		["score"] = 2200,
		["color"] = { 0.12549019607843137, 0.39215686274509803, 0.8784313725490196 }
	},
	[15] = {
		["score"] = 2000,
		["color"] = { 0, 0.4392156862745098, 0.8666666666666667 }
	},
	[16] = {
		["score"] = 1800,
		["color"] = { 0.023529411764705882, 0.5490196078431373, 0.6901960784313725 }
	},
	[17] = {
		["score"] = 1600,
		["color"] = { 0.047058823529411764, 0.6627450980392157, 0.5176470588235295 }
	},
	[18] = {
		["score"] = 1400,
		["color"] = { 0.07058823529411765, 0.7725490196078432, 0.34509803921568627 }
	},
	[19] = {
		["score"] = 1200,
		["color"] = { 0.09411764705882353, 0.8862745098039215, 0.17254901960784313 }
	},
	[20] = {
		["score"] = 1000,
		["color"] = { 0.11764705882352941, 1, 0 }
	},
	[21] = {
		["score"] = 900,
		["color"] = { 0.29411764705882354, 1, 0.2 }
	},
	[22] = {
		["score"] = 800,
		["color"] = { 0.47058823529411764, 1, 0.4 }
	},
	[23] = {
		["score"] = 700,
		["color"] = { 0.6470588235294118, 1, 0.6 }
	},
	[24] = {
		["score"] = 600,
		["color"] = { 0.8235294117647058, 1, 0.8 }
	},
	[25] = {
		["score"] = 500,
		["color"] = { 1, 1, 1 }
	},
}

-- Simple "Color Blind" (standard quality) mode
ns.scoreTiersSimple = {
	[1] = {
		["score"] = 6000,
		["quality"] = 6
	},
	[2] = {
		["score"] = 4000,
		["quality"] = 5
	},
	[3] = {
		["score"] = 3000,
		["quality"] = 4
	},
	[4] = {
		["score"] = 2000,
		["quality"] = 3
	},
	[5] = {
		["score"] = 1000,
		["quality"] = 2
	},
	[6] = {
		["score"] = 500,
		["quality"] = 1
	}
}

-- Dungeon listing sorted by id
ns.dungeons = {
	[1] = {
		["id"] = 9028,
		["keystone_instance"] = 244,
		["instance_map_id"] = 1763,
		["lfd_activity_ids"] = { 501, 500, 499, 502 },
		["name"] = "Atal'Dazar",
		["shortName"] = "AD"
	},
	[2] = {
		["id"] = 9164,
		["keystone_instance"] = 245,
		["instance_map_id"] = 1754,
		["lfd_activity_ids"] = { 539, 519, 517, 518 },
		["name"] = "Freehold",
		["shortName"] = "FH"
	},
	[3] = {
		["id"] = 9526,
		["keystone_instance"] = 249,
		["instance_map_id"] = 1762,
		["lfd_activity_ids"] = { 513, 514 },
		["name"] = "King's Rest",
		["shortName"] = "KR"
	},
	[4] = {
		["id"] = 9525,
		["keystone_instance"] = 252,
		["instance_map_id"] = 1864,
		["lfd_activity_ids"] = { 538, 523, 521, 522 },
		["name"] = "Shrine of the Storm",
		["shortName"] = "SOTS"
	},
	[5] = {
		["id"] = 9354,
		["keystone_instance"] = 353,
		["instance_map_id"] = 1822,
		["lfd_activity_ids"] = { 533, 534 },
		["name"] = "Siege of Boralus",
		["shortName"] = "SIEGE"
	},
	[6] = {
		["id"] = 9527,
		["keystone_instance"] = 250,
		["instance_map_id"] = 1877,
		["lfd_activity_ids"] = { 503, 505, 645, 504 },
		["name"] = "Temple of Sethraliss",
		["shortName"] = "TOS"
	},
	[7] = {
		["id"] = 8064,
		["keystone_instance"] = 247,
		["instance_map_id"] = 1594,
		["lfd_activity_ids"] = { 509, 511, 646, 510 },
		["name"] = "The MOTHERLODE!!",
		["shortName"] = "TM"
	},
	[8] = {
		["id"] = 9391,
		["keystone_instance"] = 251,
		["instance_map_id"] = 1841,
		["lfd_activity_ids"] = { 506, 508, 644, 507 },
		["name"] = "The Underrot",
		["shortName"] = "UNDR"
	},
	[9] = {
		["id"] = 9327,
		["keystone_instance"] = 246,
		["instance_map_id"] = 1771,
		["lfd_activity_ids"] = { 537, 527, 525, 526 },
		["name"] = "Tol Dagor",
		["shortName"] = "TD"
	},
	[10] = {
		["id"] = 9424,
		["keystone_instance"] = 248,
		["instance_map_id"] = 1862,
		["lfd_activity_ids"] = { 536, 531, 529, 530 },
		["name"] = "Waycrest Manor",
		["shortName"] = "WM"
	}
}
