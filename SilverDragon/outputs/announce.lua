local core = LibStub("AceAddon-3.0"):GetAddon("SilverDragon")
local module = core:NewModule("Announce", "AceTimer-3.0", "LibSink-2.0", "LibToast-1.0")
local Debug = core.Debug

local LSM = LibStub("LibSharedMedia-3.0")

if LSM then
	-- Register some media
	LSM:Register("sound", "Rubber Ducky", [[Sound\Doodad\Goblin_Lottery_Open01.wav]])
	LSM:Register("sound", "Cartoon FX", [[Sound\Doodad\Goblin_Lottery_Open03.wav]])
	LSM:Register("sound", "Explosion", [[Sound\Doodad\Hellfire_Raid_FX_Explosion05.wav]])
	LSM:Register("sound", "Shing!", [[Sound\Doodad\PortcullisActive_Closed.wav]])
	LSM:Register("sound", "Wham!", [[Sound\Doodad\PVP_Lordaeron_Door_Open.wav]])
	LSM:Register("sound", "Simon Chime", [[Sound\Doodad\SimonGame_LargeBlueTree.wav]])
	LSM:Register("sound", "War Drums", [[Sound\Event Sounds\Event_wardrum_ogre.wav]])--NPC Scan default
	LSM:Register("sound", "Scourge Horn", [[Sound\Events\scourge_horn.wav]])--NPC Scan default
	LSM:Register("sound", "Pygmy Drums", [[Sound\Doodad\GO_PygmyDrumsStage_Custom0_Loop.ogg]])
	LSM:Register("sound", "Cheer", [[Sound\Event Sounds\OgreEventCheerUnique.wav]])
	LSM:Register("sound", "Humm", [[Sound\Spells\SimonGame_Visual_GameStart.wav]])
	LSM:Register("sound", "Short Circuit", [[Sound\Spells\SimonGame_Visual_BadPress.wav]])
	LSM:Register("sound", "Fel Portal", [[Sound\Spells\Sunwell_Fel_PortalStand.wav]])
	LSM:Register("sound", "Fel Nova", [[Sound\Spells\SeepingGaseous_Fel_Nova.wav]])
	LSM:Register("sound", "PVP Flag", [[Sound\Spells\PVPFlagTaken.wav]])
	LSM:Register("sound", "Algalon: Beware!", [[Sound\Creature\AlgalonTheObserver\UR_Algalon_BHole01.wav]])
	LSM:Register("sound", "Yogg Saron: Laugh", [[Sound\Creature\YoggSaron\UR_YoggSaron_Slay01.wav]])
	LSM:Register("sound", "Illidan: Not Prepared", [[Sound\Creature\Illidan\BLACK_Illidan_04.wav]])
	LSM:Register("sound", "Magtheridon: I am Unleashed", [[Sound\Creature\Magtheridon\HELL_Mag_Free01.wav]])
	LSM:Register("sound", "Loatheb: I see you", [[Sound\Creature\Loathstare\Loa_Naxx_Aggro02.ogg]])
	LSM:Register("sound", "NPCScan", [[Sound\Event Sounds\Event_wardrum_ogre.wav]])--Sound file is actually bogus, this just forces the option NPCScan into menu. We hack it later.
end

local mount_mobs = {
	[32491] = true, -- Time-Lost
	[50005] = true, -- Poseidus
	[50062] = true, -- Aeonaxx
	[50409] = true, -- Mysterious Camel
	[64403] = true, -- Alani
	[69769] = true, -- Zandalari Warbringer (Slate)
	[69841] = true, -- Zandalari Warbringer (Amber)
	[69842] = true, -- Zandalari Warbringer (Jade)
}
local boss_mobs = {
	[50009] = true, -- Mobus
	[50056] = true, -- Garr
	[50061] = true, -- Xariona
	[50063] = true, -- Akma'hat
	[50089] = true, -- Julak-Doom
	[60491] = true, -- Sha of Anger
	[62346] = true, -- Galleon
	[69099] = true, -- Nalak
	[69161] = true, -- Oondasta
}

function module:OnInitialize()
	self.db = core.db:RegisterNamespace("Announce", {
		profile = {
			sink = true,
			drums = true,
			sound = true,
			sound_mount = true,
			sound_boss = true,
			soundfile = "Loatheb: I see you",
			soundfile_mount = "Illidan: Not Prepared",
			soundfile_boss = "Magtheridon: I am Unleashed",
			sound_loop = 1,
			sound_mount_loop = 1,
			sound_boss_loop = 1,
			flash = true,
			instances = true,
			expansions = {
				classic = true,
				bc = true,
				wrath = true,
				cataclysm = true,
				pandaria = true,
				cities = true,
				unknown = true,
			},
			sink_opts = {},
		},
	})

	self:SetSinkStorage(self.db.profile.sink_opts)
	self:DefineSinkToast("Rare seen!", [[Interface\Icons\INV_Misc_Head_Dragon_01]])

	core.RegisterCallback(self, "Seen")

	local config = core:GetModule("Config", true)
	if config then
		local toggle = config.toggle
		local get = function(info) return self.db.profile[info[#info]] end
		local set = function(info, v) self.db.profile[info[#info]] = v end

		local sink_config = self:GetSinkAce3OptionsDataTable()
		sink_config.inline = true
		sink_config.order = 15

		local faker = function(id, name, zone, x, y)
			return {
				type = "execute", name = name,
				desc = "Fake seeing " .. name,
				func = function()
					-- id, name, zone, x, y, is_dead, is_new_location, source, unit
					core.events:Fire("Seen", id, name, zone, x, y, false, false, "fake", false)
				end,
			}
		end

		local options = {
			general = {
				type = "group", name = "General", inline = true,
				order = 10,
				get = get, set = set,
				args = {
					flash = toggle("Flash", "Flash the edges of the screen."),
					instances = toggle("Instances", "Show announcements while in an instance"),
				},
			},
			expansions = {
				type = "group", name = "Expansions", inline = true,
				order = 15,
				get = function(info) return self.db.profile.expansions[info[#info]] end,
				set = function(info, v) self.db.profile.expansions[info[#info]] = v end,
				args = {
					about = config.desc("Whether to announce rares in zones from this expansion", 0, false),
					classic = toggle("Classic", "Vanilla. Basic. 1-60. Whatevs.", 10, false),
					bc = toggle("Burning Crusade", "Illidan McGrumpypants. 61-70.", 20, false),
					wrath = toggle("Wrath of the Lich King", "Emo Arthas. 71-80.", 30, false),
					cataclysm = toggle("Cataclysm", "Play it off, keyboard cataclysm! 81-85.", 40, false),
					pandaria = toggle("Mists of Pandaria", "Everybody was kung fu fighting. 86-90.", 50, false),
					cities = toggle("Capitol Cities", "Expansion indifferent and ever evolving.", 60, false),
					unknown = toggle(UNKNOWN, "Not sure where they fit.", 70, false),
				},
			},
			message = {
				type = "group", name = "Messages",
				order = 20,
				get = get, set = set,
				args = {
					sink = toggle("Enabled", "Send a message to whatever scrolling text addon you're using.", 10),
					output = sink_config,
				},
			},
			test = {
				type = "group", name = "Test it!",
				inline =  true,
				args = {
					-- id, name, zone, x, y, is_dead, is_new_location, source, unit
					time = faker(32491, "Time-Lost Proto Drake (Mount!)", 495, 0.490, 0.362),
					anger = faker(60491, "Sha of Anger (Boss!)", 809, 0.5, 0.5),
					vyragosa = faker(32630, "Vyragosa (Boring)", 495, 0.5, 0.5),
					deathmaw = faker(10077, "Deathmaw (Pet!)", 29, 0.5, 0.5),
				},
			},
		}
		if LSM then
			local soundfile = function(enabled_key, order)
				return {
					type = "select", dialogControl = "LSM30_Sound",
					name = "Sound to Play", desc = "Choose a sound file to play",
					values = AceGUIWidgetLSMlists.sound,
					disabled = function() return not self.db.profile[enabled_key] end,
					order = order,
				}
			end
			local soundrange = function(order)
				return {
					type = "range",
					name = "Repeat...",
					desc = "How many times to repeat the sound",
					min = 1, max = 10, step = 1,
					order = order,
				}
			end
			options.sound = {
				type = "group", name = "Sounds",
				get = get, set = set,
				order = 10,
				args = {
					about = config.desc("Play sounds to announce rare mobs? Can do special things for special mobs. You *really* don't want to miss, say, the Time-Lost Proto Drake, after all...", 0),
					sound = toggle("Enabled", "Play sounds at all!", 10),
					drums = toggle("The Sound of Drums", "Underneath it all, the constant drumming", 12),
					soundfile = soundfile("sound", 15),
					sound_loop = soundrange(17),
					mount = {type="header", name="", order=20,},
					sound_mount = toggle("Mount sounds", "Play a special sound for mobs that drop a mount", 21),
					soundfile_mount = soundfile("sound_mount", 25),
					sound_mount_loop = soundrange(27),
					boss = {type="header", name="", order=30,},
					sound_boss = toggle("Boss sounds", "Play a special sound for mobs that require a group", 31),
					soundfile_boss = soundfile("sound_boss", 35),
					sound_boss_loop = soundrange(37),
				},
			}
		end
		config.options.args.outputs.plugins.announce = options
	end
end

function module:Seen(callback, id, name, zone, ...)
	Debug("Announce:Seen", id, name, zone, ...)

	if not self.db.profile.instances and IsInInstance() then
		return
	end

	if not self:CareAboutZone(zone) then
		Debug("Skipping due to expansion", exp)
		return
	end

	core.events:Fire("Announce", id, name, zone, ...)
end

function module:CareAboutZone(zone)
	local exp = core.guess_expansion(zone)
	if exp and not self.db.profile.expansions[exp] then
		return
	end
	return true
end

core.RegisterCallback("SD Announce Sink", "Announce", function(callback, id, name, zone, x, y, dead, newloc, source)
	if not module.db.profile.sink then
		return
	end

	Debug("Pouring")
	if source:match("^sync") then
		local channel, player = source:match("sync:(.+):(.+)")
		if channel and player then
			local localized_zone = GetMapNameByID(zone) or UNKNOWN
			source = "by " .. player .. " in your " .. strlower(channel) .. "; " .. localized_zone
		end
	end
	if x and y then
		source = source .. " @ " .. core.round(x * 100, 1) .. "," .. core.round(y * 100, 1)
	end
	local prefix = "Rare seen: "
	if module.db.profile.sink_opts.sink20OutputSink == "LibToast-1.0" then
		prefix = ""
	end
	module:Pour((prefix .. "%s%s (%s)"):format(core:GetMobLabel(id) or name or UNKNOWN, dead and "... but it's dead" or '', source or ''))
end)

function module:PlaySound(s)
	-- Arg is a table, to make scheduling the loops easier. I am lazy.
	Debug("Playing sound", s.soundfile, s.loops)
	-- boring check:
	if not s.loops or s.loops == 0 then return end
	-- now, noise!
	local drums = self.db.profile.drums
	if s.soundfile == "NPCScan" then
		--Override default behavior and force npcscan behavior of two sounds at once
		drums = true
		PlaySoundFile(LSM:Fetch("sound", "Scourge Horn"), "Master")
	else
		--Play whatever sound is set
		PlaySoundFile(LSM:Fetch("sound", s.soundfile), "Master")
	end
	if drums then
		PlaySoundFile(LSM:Fetch("sound", "War Drums"), "Master")
	end
	s.loops = s.loops - 1
	if s.loops > 0 then
		self:ScheduleTimer("PlaySound", 4.5, s)
	end
end
core.RegisterCallback("SD Announce Sound", "Announce", function(callback, id)
	if not (module.db.profile.sound and LSM) then
		return
	end
	local soundfile, loops
	if mount_mobs[id] then
		soundfile = module.db.profile.soundfile_mount
		loops = module.db.profile.sound_mount_loop
	elseif boss_mobs[id] then
		soundfile = module.db.profile.soundfile_boss
		loops = module.db.profile.sound_boss_loop
	else
		soundfile = module.db.profile.soundfile
		loops = module.db.profile.sound_loop
	end
	module:PlaySound{soundfile = soundfile, loops = loops}
end)

core.RegisterCallback("SD Announce Flash", "Announce", function(callback)
	if not module.db.profile.flash then
		return
	end

	Debug("Flashing")
	LowHealthFrame_StartFlashing(0.5, 0.5, 6, false, 0.5)
end)

-- Expansion checking
-- It's possible I should library-ise this...

do
	local classic_zones = {
		[101] = "Desolace",
		[11] = "Barrens",
		[121] = "Feralas",
		[13] = "Kalimdor",
		[14] = "Azeroth",
		[141] = "Dustwallow",
		[907] = "Dustwallow", -- _terrain1
		[16] = "Arathi",
		[161] = "Tanaris",
		[17] = "Badlands",
		[181] = "Aszhara",
		[182] = "Felwood",
		[19] = "BlastedLands",
		[20] = "Tirisfal",
		[201] = "UngoroCrater",
		[21] = "Silverpine",
		[22] = "WesternPlaguelands",
		[23] = "EasternPlaguelands",
		[24] = "HillsbradFoothills",
		[241] = "Moonglade",
		[26] = "Hinterlands",
		[261] = "Silithus",
		[27] = "DunMorogh",
		[28] = "SearingGorge",
		[281] = "Winterspring",
		[29] = "BurningSteppes",
		[30] = "Elwynn",
		[32] = "DeadwindPass",
		[34] = "Duskwood",
		[35] = "LochModan",
		[36] = "Redridge",
		[37] = "StranglethornJungle",
		[38] = "SwampOfSorrows",
		[39] = "Westfall",
		[4] = "Durotar",
		[40] = "Wetlands",
		[41] = "Teldrassil",
		[42] = "Darkshore",
		[43] = "Ashenvale",
		[607] = "SouthernBarrens",
		[61] = "ThousandNeedles",
		[673] = "TheCapeOfStranglethorn",
		[689] = "StranglethornVale",
		[772] = "AhnQirajTheFallenKingdom",
		[81] = "StonetalonMountains",
		[9] = "Mulgore",
		-- starting zones
		[864] = "Northshire",
		[866] = "ColdridgeValley",
		[888] = "ShadowglenStart",
		[890] = "CampNaracheStart",
		[892] = "DeathknellStart",
		[895] = "NewTinkertownStart",
	}
	local bc_zones = {
		[465] = "Hellfire",
		[466] = "Expansion01",
		[467] = "Zangarmarsh",
		[473] = "ShadowmoonValley",
		[475] = "BladesEdgeMountains",
		[477] = "Nagrand",
		[478] = "TerokkarForest",
		[479] = "Netherstorm",
		[499] = "Sunwell",
		-- starting zones
		[462] = "EversongWoods",
		[463] = "Ghostlands",
		[464] = "AzuremystIsle",
		[476] = "BloodmystIsle",
		[893] = "SunstriderIsleStart",
		[894] = "AmmenValeStart",
	}
	local wrath_zones = {
		[485] = "Northrend",
		[486] = "BoreanTundra",
		[488] = "Dragonblight",
		[490] = "GrizzlyHills",
		[491] = "HowlingFjord",
		[492] = "IcecrownGlacier",
		[493] = "SholazarBasin",
		[495] = "TheStormPeaks",
		[496] = "ZulDrak",
		[501] = "LakeWintergrasp",
		[510] = "CrystalsongForest",
		[541] = "HrothgarsLanding",
	}
	local cata_zones = {
		[606] = "Hyjal",
		[683] = "Hyjal", -- _terrain1
		[610] = "VashjirKelpForest",
		[613] = "Vashjir",
		[614] = "VashjirDepths",
		[615] = "VashjirRuins",
		[640] = "Deepholm",
		[700] = "TwilightHighlands",
		[770] = "TwilightHighlands", -- _terrain1
		[708] = "TolBarad",
		[709] = "TolBaradDailyArea",
		[720] = "Uldum",
		[748] = "Uldum", -- _terrain1
		[737] = "TheMaelstrom",
		[751] = "TheMaelstromContinent",
		[795] = "MoltenFront",
		-- starting zones
		[544] = "TheLostIsles",
		[605] = "Kezan",
		[684] = "RuinsofGilneas",
		[685] = "RuinsofGilneasCity",
		[891] = "EchoIslesStart",
	}
	local mop_zones = {
		[806] = "TheJadeForest",
		[807] = "ValleyoftheFourWinds",
		[809] = "KunLaiSummit",
		[810] = "TownlongWastes",
		[811] = "ValeofEternalBlossoms",
		[857] = "Krasarang",
		[858] = "DreadWastes",
		[862] = "Pandaria",
		[873] = "TheHiddenPass",
		[903] = "ShrineofTwoMoons",
		[905] = "ShrineofSevenStars",
		[928] = "IsleoftheThunderKing",
		[929] = "IsleOfGiants",
		[951] = "TimelessIsle",
		-- starting zones
		[889] = "ValleyofTrialsStart",
	}
	local main_cities = {
		[301] = "StormwindCity",
		[321] = "Orgrimmar",
		[341] = "Ironforge",
		[362] = "ThunderBluff",
		[381] = "Darnassus",
		[382] = "Undercity",
		[471] = "TheExodar",
		[480] = "SilvermoonCity",
		[481] = "ShattrathCity",
		[504] = "Dalaran",
		[823] = "DarkmoonFaireIsland",
	}

	local function guess_expansion(zone)
		if not zone then
			return 'unknown'
		end
		if classic_zones[zone] then
			return 'classic'
		end
		if bc_zones[zone] then
			return 'bc'
		end
		if wrath_zones[zone] then
			return 'wrath'
		end
		if cata_zones[zone] then
			return 'cataclysm'
		end
		if mop_zones[zone] then
			return 'pandaria'
		end
		if main_cities[zone] then
			return 'cities'
		end
		return 'unknown'
	end
	core.guess_expansion = guess_expansion
end
