local _, ns = ...
local points = ns.points
local textures = ns.textures
local scaling = ns.scaling
local colourPrefix		= ns.colour.prefix
local colourHighlight	= ns.colour.highlight
local colourPlaintext	= ns.colour.plaintext

-- Lore Objects
-- 6716		Between a Saurok and a Hard Place
-- 6754		The Dark Heart of the Mogu
-- 6846		Fish Tales
-- 6847		The Song of the Yaungol
-- 6850		Hozen in the Mist
-- 6855		The Seven Burdens of Shaohao
-- 6856		Ballad of Liu Lang
-- 6857		Heart of the Mantid Swarm
-- 6858		What is Worth Fighting For

-- NPCs
-- 6350		To All the Squirrels I Once Caressed?
-- 7439		Glorious

-- Treasures
-- 7284		Is another Man's Treasure
-- 7997		Riches of Pandaria

-- Miscellaneous Discovery
-- 7230		Legend of the Brewfathers
-- 7329		Pandaren Cuisine
-- 7381		Restore Balance
-- 7518		Wanderers, Dreamers, and You
-- 7932		I'm In Your Base Killing Your Dudes
-- 8078		Zul Again

-- Thunder Isle
-- 8049		The Zandalari Prophecy
-- 8050		Rumbles of Thunder
-- 8051		Gods and Monsters
-- 8103		Champions of Lei Shen

-- Timeless Isle
-- 8535		Celestial Challenge
-- 8712		Killing Time
-- 8714		Timeless Champion
-- 8724		Pilgrimage
-- 8725		Eyes on the Ground
-- 8726		Extreme Treasure Hunter
-- 8727 	Where There's Pirates, There's Booty
-- 8729		Treasure, Treasure Everywhere
-- 8730		Rolo's Riddle
-- 8743		Zarhym Altogether
-- 8784		Timeless Legends

points[ 424 ] = { -- Pandaria
	[80102680] = { aList=1 },
	[24401400] = { tip="Click on the Isle of Thunder to see the AddOn pins" },
	[70147451] = { aID=7997, item="Ship's Locker", aQuest=31396, tip="Below deck, aft end" }, -- object 213362
	[92906250] = { tip="Click on the Timeless Isle to see the AddOn pins" },
}
points[ 947 ] = { -- Azeroth
	[38708400] = { aList=1 },
	[41006940] = { tip="Click on the Isle of Thunder from the\nPandaria map to see AddOn pins" },
	[57008310] = { tip="Click on the Timeless Isle from the\nPandaria map to see AddOn pins" },
}

points[ 422 ] = { -- Dread Wastes

	-- To All the Squirrels I Once Caressed?
	[58227670] = { aID=6350, aIndex=3, }, -- Clouded Hedgehog
	[58306655] = { aID=6350, aIndex=3, }, -- Clouded Hedgehog
	[58407090] = { aID=6350, aIndex=3, }, -- Clouded Hedgehog
	[60227320] = { aID=6350, aIndex=3, }, -- Clouded Hedgehog
	[60556460] = { aID=6350, aIndex=3, }, -- Clouded Hedgehog
	[61156890] = { aID=6350, aIndex=3, }, -- Clouded Hedgehog
	[62157370] = { aID=6350, aIndex=3, }, -- Clouded Hedgehog
	[63806960] = { aID=6350, aIndex=3, continent=true }, -- Clouded Hedgehog
	[65156615] = { aID=6350, aIndex=3, }, -- Clouded Hedgehog
	[65857170] = { aID=6350, aIndex=3, }, -- Clouded Hedgehog
	[66607000] = { aID=6350, aIndex=3, }, -- Clouded Hedgehog
	[67856590] = { aID=6350, aIndex=3, }, -- Clouded Hedgehog
	[69256070] = { aID=6350, aIndex=3, }, -- Clouded Hedgehog
	[54257900] = { aID=6350, aIndex=6, }, -- Emperor Crab
	[55417971] = { aID=6350, aIndex=6, }, -- Emperor Crab
	[56678046] = { aID=6350, aIndex=6, }, -- Emperor Crab
	[58818015] = { aID=6350, aIndex=6, continent=true }, -- Emperor Crab
	[60378027] = { aID=6350, aIndex=6, }, -- Emperor Crab
	[60888196] = { aID=6350, aIndex=6, }, -- Emperor Crab
	[61648027] = { aID=6350, aIndex=6, }, -- Emperor Crab
	[61878144] = { aID=6350, aIndex=6, }, -- Emperor Crab
	[59007325] = { aID=6350, aIndex=14, }, -- Resilient Roach
	[61905905] = { aID=6350, aIndex=14, }, -- Resilient Roach
	[62206680] = { aID=6350, aIndex=14, continent=true }, -- Resilient Roach
	[62406520] = { aID=6350, aIndex=14, }, -- Resilient Roach
	[63357180] = { aID=6350, aIndex=14, }, -- Resilient Roach
	[64356390] = { aID=6350, aIndex=14, }, -- Resilient Roach
	[66956520] = { aID=6350, aIndex=14, tip="In the burrow" }, -- Resilient Roach
	[67056310] = { aID=6350, aIndex=14, tip="In the burrow" }, -- Resilient Roach

	-- Between a Saurok and a Hard Place
	[67446079] = { aID=6716, aIndex=3, }, -- The Deserters

	-- Heart of the Mantid Swarm
	[35543263] = { aID=6857, aIndex=4, }, -- The Empress
	[53611558] = { aID=6857, aIndex=3, tip="Enter through here. It's at the\n"
							.."far side of the circular room" }, -- Amber
	[48363286] = { aID=6857, aIndex=1, }, -- Cycle of the Mantid
	[60005500] = { aID=6857, aIndex=2, }, -- Mantid Society
	
	-- Is another Man's Treasure
	[25515438] = { aID=7284, item=86525, aQuest=31436,
					tip="Enter the Murkscale Grotto. The entrance is submerged" },
					-- Bloodsoaked Chitin Fragment
	[25975025] = { aID=7284, item=86525, aQuest=31436 }, -- Bloodsoaked Chitin Fragment
	[28914192] = { aID=7284, item=86527, aQuest=31438, tip="Don't enter the Amber Womb. It's in the smaller of\n"
					.."the two purple bushes to the left of the entrance" }, -- Blade of the Poisoned Mind
	[30209080] = { aID=7284, item=86524, aQuest=31435 }, -- Dissector's Staff of Mutation
	[32993013] = { aID=7284, item="Amber Encased Necklace", aQuest=31431 },
					-- Lucid Amulet of the Agile Mind itemID 86521
	[41806300] = { aID=7284, item="Glinting Rapana Whelk", aQuest=31432,
					tip="Look on this island for a tiny snail. "
					.."Try '/tar glinting'" }, -- Manipulator's Talisman
	[48702996] = { aID=7284, item=86520, aQuest=31430 }, -- Malik's Stalwart Spear
	[54285637] = { aID=7284, item=86526, aQuest=31437 }, -- Swarmkeeper's Medallion
	[56717772] = { aID=7284, item=86523, aQuest=31434 }, -- Swarming Cleaver of Ka'roz
	[66306655] = { aID=7284, item=86522, aQuest=31433 }, -- Blade of the Prime
	[66766389] = { aID=7284, item=86522, aQuest=31433,
					tip="Enter the Mistblade Den here" }, -- Blade of the Prime
	[71773607] = { aID=7284, item=86519, aQuest=31666 }, -- Wind-Reaver's Dagger of Quick Strikes

	-- Glorious
	[25212840] = { aID=7439, aIndex=55, continent=true }, -- Dak the Breaker
	[34742323] = { aID=7439, aIndex=41, continent=true }, -- Ai-Li Skymirror
	[35623053] = { aID=7439, aIndex=20, }, -- Gar'lok
	[35996227] = { aID=7439, aIndex=48, }, -- Omnis Grinlock
	[36176406] = { aID=7439, aIndex=48, }, -- Omnis Grinlock
	[36376089] = { aID=7439, aIndex=48, }, -- Omnis Grinlock
	[37015960] = { aID=7439, aIndex=48, }, -- Omnis Grinlock
	[37016411] = { aID=7439, aIndex=48, continent=true }, -- Omnis Grinlock
	[37682957] = { aID=7439, aIndex=20, continent=true }, -- Gar'lok
	[38046366] = { aID=7439, aIndex=48, }, -- Omnis Grinlock
	[38275807] = { aID=7439, aIndex=48, }, -- Omnis Grinlock
	[39006255] = { aID=7439, aIndex=48, }, -- Omnis Grinlock
	[39174182] = { aID=7439, aIndex=20, }, -- Gar'lok
	[39235834] = { aID=7439, aIndex=48, }, -- Omnis Grinlock
	[39486099] = { aID=7439, aIndex=48, }, -- Omnis Grinlock
	[39805946] = { aID=7439, aIndex=48, }, -- Omnis Grinlock
	[52600582] = { aID=7439, aIndex=12, }, -- Eshelon
	[53670505] = { aID=7439, aIndex=12, }, -- Eshelon
	[55260586] = { aID=7439, aIndex=12, continent=true }, -- Eshelon
	[55346355] = { aID=7439, aIndex=6, continent=true }, -- Ik-Ik the Nimble
	[56490769] = { aID=7439, aIndex=12, }, -- Eshelon
	[66378676] = { aID=7439, aIndex=12, }, -- Eshelon
	[64255846] = { aID=7439, aIndex=13, continent=true }, -- Nalash Verdantis
	[71893769] = { aID=7439, aIndex=27, continent=true }, -- Karr the Darkener
	[72982204] = { aID=7439, aIndex=34, }, -- Krol the Blade
	[73162020] = { aID=7439, aIndex=34, }, -- Krol the Blade
	[74102054] = { aID=7439, aIndex=34, continent=true }, -- Krol the Blade
	[74462290] = { aID=7439, aIndex=34, }, -- Krol the Blade
	[54846581] = { aID=7439, aIndex=6, tip="Enter the burrow", continent=true  }, -- Ik-Ik The Nimble

	-- Zul Again
	[48636121] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[49196300] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[49926460] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[50676617] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[52046691] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[53106666] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[54466696] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[55806685] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[57266629] = { aID=8078, npc=69842, tip="Zandalari Warscout", continent=true },
	[58566683] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[59786506] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[59796688] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[59806307] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[60516161] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[61426065] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[62636060] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	
	
	[36794752] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[37504922] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[38265012] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[38414804] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[38964678] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[39754931] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[40414590] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[40904993] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[41494436] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[41925109] = { aID=8078, npc=69842, tip="Zandalari Warscout", continent=true },
	[43345182] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[44055353] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[44955522] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[45755681] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[46175908] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[47096050] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[47406150] = { aID=8078, tip="Zandalari Warbringer. There are three types, each dropping\n"
					.."a different coloured Primordial Direhorn mount.\n\n"
					.."Can despawn as fast as 2 to 3 minutes after spawning" },
}
points[ 504 ] = { -- Isle of Thunder
	[68005800] = { aList=1 },
	[34808140] = { aID=8103, aIndex=3, }, -- Ku'lai the Skyclaw
	[34886561] = { aID=8050, aIndex=3, }, -- Unity at a Price
	[35116239] = { aID=8103, aIndex=2, tip="On the top level terrace" }, -- Mumta
	[35327011] = { aID=8049, aIndex=1, }, -- Coming of Age
	[35875471] = { aID=8051, aIndex=1, }, -- Agents of Order
	[36297037] = { aID=8049, aIndex=3, }, -- Shadows of the Loa
	[39428159] = { aID=8103, tip="Ra-sha is not part of this or any achievement but\n"
							.."a Shan'ze Ritual Stone can drop" }, -- Ra-sha
	[40164067] = { aID=8050, aIndex=1, }, -- Lei Shen
	[44732980] = { aID=8103, aIndex=7, }, -- Al'tabim the All-Seeing
	[47075991] = { aID=8050, aIndex=2, }, -- The Sacred Mount
	[48588887] = { aID=8103, aIndex=1, tip="Runs around the beach in a... haywire manner!" },
					-- Haywire Sunreaver Construct
	[49183306] = { aID=8103, aIndex=8, tip="Enter the mine then check the World Map" }, -- Backbreaker Uru
	[49543411] = { aID=8051, aIndex=3, tip="Enter the mine then check the World Map" },
					-- The Curse and the Silence
	[49902034] = { aID=8051, aIndex=3, tip="Access via the Lightning Vein Mine" }, -- The Curse and the Silence
	[51007120] = { aID=8103, aIndex=4, tip="High up on an isolated rock" }, -- Progenitus
	[50457232] = { aID=8103, aIndex=4, tip="4) Jump! But... you'll need a speed boost to make it.\n\n"
								.."If you don't care about the loot then use a range attack" }, -- Progenitus
	[50487542] = { aID=8103, aIndex=4, tip="3) This way" }, -- Progenitus
	[50177794] = { aID=8103, aIndex=4, tip="2) Go up here" }, -- Progenitus
	[45227369] = { aID=8103, aIndex=4, tip="1) Start here" }, -- Progenitus
	[53785321] = { aID=8103, aIndex=5, tip="1) Respawn is about 70 minutes" }, -- Goda
	[54343552] = { aID=8103, aIndex=9, }, -- Lu-Ban
	[54402890] = { aID=8103, aIndex=8, tip="Enter the mine then check the World Map" }, -- Backbreaker Uru
	[55012972] = { aID=8051, aIndex=3, tip="Enter the mine then check the World Map" }, -- The Curse and the Silence
	[59282624] = { aID=8051, aIndex=2, tip="Inside the Thunder Forges" }, -- Shadow, Storm, and Stone
	[59603640] = { aID=8103, aIndex=10, }, -- Molthor
	[60736879] = { aID=8050, aIndex=4, }, -- The Pandaren Problem
	[61484958] = { aID=8103, aIndex=6, }, -- God-Hulk Ramuk
	[62543770] = { aID=8051, aIndex=4, }, -- Age of a Hundred Kings
	[63544930] = { aID=8103, aIndex=10, tip="Not an error. Has two spawn locations.\n"
										.."At the top of Conqueror's Terrace" }, -- Molthor
	[66014463] = { aID=8049, aIndex=2, }, -- For Council and King
	[52664140] = { aID=8049, aIndex=4, }, -- The Dark Prophet Zul
}
points[ 505 ] = { -- Lightning Vein Mine on the Isle of Thunder
	[42862921] = { aID=8051, aIndex=3, tip="2) Continue through here. Turn right when outside" },
					-- The Curse and the Silence
	[43183836] = { aID=8103, aIndex=8, tip="3) Patrols from about here through to the outdoor area" },
					-- Backbreaker Uru
	[45006303] = { aID=8103, aIndex=8, tip="1) Proceed this way" }, -- Backbreaker Uru
	[47634814] = { aID=8103, aIndex=8, tip="2) Continue" }, -- Backbreaker Uru
	[50525608] = { aID=8051, aIndex=3, tip="1) This way!" }, -- The Curse and the Silence
}
points[ 418 ] = { -- Krasarang Wilds

	-- To All the Squirrels I Once Caressed?
	[46553465] = { aID=6350, aIndex=1, }, -- Amethyst Spiderling
	[46853970] = { aID=6350, aIndex=1, }, -- Amethyst Spiderling
	[47703680] = { aID=6350, aIndex=1, }, -- Amethyst Spiderling
	[48253985] = { aID=6350, aIndex=1, }, -- Amethyst Spiderling
	[66802525] = { aID=6350, aIndex=1, continent=true }, -- Amethyst Spiderling
	[70002810] = { aID=6350, aIndex=1, }, -- Amethyst Spiderling
	[72852415] = { aID=6350, aIndex=1, }, -- Amethyst Spiderling
	[47753890] = { aID=6350, aIndex=10, }, -- Luyu Moth
	[47804130] = { aID=6350, aIndex=10, }, -- Luyu Moth
	[48853465] = { aID=6350, aIndex=10, continent=true }, -- Luyu Moth
	[50654010] = { aID=6350, aIndex=10, }, -- Luyu Moth
	[66652130] = { aID=6350, aIndex=10, }, -- Luyu Moth
	[67802290] = { aID=6350, aIndex=10, }, -- Luyu Moth
	[70302455] = { aID=6350, aIndex=10, }, -- Luyu Moth
	
	--Is another Man's Treasure
	[42289196] = { aID=7284, item="Equipment Locker", aQuest=31410,
					tip="Lowest level of the boat, bow end.\n"
					.."Biggest chest I've ever seen!!!" }, -- Various random items
	[50814936] = { aID=7284, item=86124, aQuest=31409, }, -- Pandaren Fishing Spear
	[52378865] = { aID=7284, item="Barrel of Banana Infused Rum", aQuest=31411, }, -- Recipe for it. ItemID 87266

	-- Glorious
	[14543484] = { aID=7439, aIndex=17, tip="Turns  here" }, -- Torik Ethis
	[15393488] = { aID=7439, aIndex=17, tip="Turns here" }, -- Torik Ethis
	[15303473] = { aID=7439, aIndex=17, tip="Pauses here" }, -- Torik Ethis
	[15593464] = { aID=7439, aIndex=17, tip="Pauses and turns here" }, -- Torik Ethis
	[15483433] = { aID=7439, aIndex=17, tip="Pauses and turns here", continent=true  }, -- Torik Ethis
	[14853533] = { aID=7439, aIndex=17, tip="Pauses and turns here" }, -- Torik Ethis
	[15263539] = { aID=7439, aIndex=17, tip="Pauses and turns here" }, -- Torik Ethis
	[14883589] = { aID=7439, aIndex=17, tip="Turns here" }, -- Torik Ethis
	[30593837] = { aID=7439, aIndex=10, continent=true }, -- Cournith Waterstrider
	[39335533] = { aID=7439, aIndex=38, continent=true }, -- Ruun Ghostpaw
	[39392899] = { aID=7439, aIndex=52, continent=true }, -- Go-Kan
	[52308890] = { aID=7439, aIndex=3, tip="Small patrol area on the deck", continent=true  }, -- Spriggin
	[53513889] = { aID=7439, aIndex=24, tip="Spawns in four locations" }, -- Gaarn the Toxic
	[53883216] = { aID=7439, aIndex=24, tip="Spawns in four locations" }, -- Gaarn the Toxic
	[56184695] = { aID=7439, aIndex=45, continent=true }, -- Arness the Scale
	[56223797] = { aID=7439, aIndex=24, tip="Spawns in four locations", continent=true  }, -- Gaarn the Toxic
	[56313511] = { aID=7439, aIndex=24, tip="Spawns in four locations" }, -- Gaarn the Toxic
	[67182326] = { aID=7439, aIndex=31, continent=true }, -- Qu'nas

	-- I'm In Your Base Killing Your Dudes
	[84972737] = { aID=7932, aIndex=1, npc=68318, faction="Horde" }, -- Dalan Nightbreaker
	[84583118] = { aID=7932, aIndex=2, npc=68317, faction="Horde" }, -- Mavis Harms
	[87482919] = { aID=7932, aIndex=3, npc=68319, faction="Horde" }, -- Disha Fearwarden
	[14135712] = { aID=7932, aIndex=1, npc=68321, faction="Alliance" }, -- Kar Warmaker
	[13166634] = { aID=7932, aIndex=2, npc=68320, faction="Alliance" }, -- Ubunti the Shade
	[10685684] = { aID=7932, aIndex=3, npc=68322, faction="Alliance" }, -- Muerta
	[85292911] = { aID=7932, aQuest=32247, qName="A King Among Men", npc=68392, faction="Alliance",
					tip="Talk to King Varian Wrynn. This quest follows after \"Meet the Scout\",\n"
					.."obtained from Lyalia in the Vale of Eternal Blossoms" },
	[08676445] = { aID=7932, aQuest=32250, qName="The Might of the Warchief", npc=67867, faction="Horde",
					tip="Talk to Garrosh Hellscream. This quest follows after \"Meet the Scout\",\n"
					.."obtained from Sunwalker Dezco in the Vale of Eternal Blossoms" },
	[80301750] = { aID=7932, aQuest=32109, qName="Lion's Landing", npc=68392, faction="Alliance",
					tip="Talk to King Varian Wrynn. This quest follows after \"A King Among Men\"" },
	[10545322] = { aID=7932, aQuest=32108, qName="Domination Point", npc=67867, faction="Horde",
					tip="Talk to Garrosh Hellscream. This quest follows after \"The Might of the Warchief\"" },
	
	-- Zul Again
	[38866447] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[40606265] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[41846045] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[43295821] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[45025632] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[45985400] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[46725198] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[47544942] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[48554704] = { aID=8078, npc=69842, tip="Zandalari Warscout", continent=true },
	[49193809] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[49394524] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[49872986] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[49763276] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[49513541] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[50273981] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[50394273] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[52372889] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[54232803] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[56402827] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[58172892] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[58972728] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	
	[16164286] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[17484475] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[18424309] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[19034081] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[20884046] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[22593950] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[24514051] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[25984197] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[26014450] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[26944651] = { aID=8078, npc=69842, tip="Zandalari Warscout", continent=true },
	[28454671] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[29864577] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[31564743] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[33484735] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[33925668] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[34515401] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[34654912] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[35265211] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[35635837] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[36316079] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[37786369] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[38546665] = { aID=8078, npc=69842, tip="Zandalari Warscout" },
	[38786739] = { aID=8078, npc=69769, tip="Zandalari Warbringer" },

	-- Miscellany
	[30553864] = { aID=6846, aIndex=3, }, -- Origins
	[32822939] = { aID=6716, aIndex=4, }, -- The Last Stand
	[40495664] = { aID=6855, aIndex=4, tip="At the top of the stairs - a large gong" }, -- Part 4
	[50943166] = { aID=6754, aIndex=2, }, -- The Lost Dynasty
	[52218605] = { aID=6850, aIndex=2, tip="Cave entrance" }, -- Hozen Maturity
	[52418768] = { aID=6850, aIndex=2, tip="In the cave" }, -- Hozen Maturity
	[68540758] = { aID=7997, item=86220, aQuest=31408, }, -- Saurok Stone Tablet. Item/object the same name
	[70550951] = { aID=7997, item=86220, aQuest=31408, tip="Cave entrance" },
					-- Saurok Stone Tablet. Item/object the same name
	[72203098] = { aID=6856, aIndex=4, }, -- Waiting for the Turtle
	[72403200] = { aID=7518, tip="Stand here\n\n"
							.."You must be present at the very start or the\n"
							.."very end of the mini-event. This is at 9pm /\n"
							.."11pm\ PST Sundays.\n\n"
							.."You'll need to convert that to your local server\n"
							.."time. Local server time can fluctuate due to\n"
							.."summer / daylight saving time at both ends.\n\n"
							.."A Wandering Herald spawns a few hours before\n"
							.."the event is due to start. Talk to him and he'll\n"
							.."give you an estimate of when the event begins.\n\n"
							.."Best to station an alt here. Good luck!" },
	[72453100] = { aID=7518, tip="Read the notice about the Festival...\n\n"
							.."Basically \"Sunday nights just after sunset\"" },
	[81361133] = { aID=7230, aIndex=1, }, -- Quan Tou Kuo the Two Fisted
}
points[ 379 ] = { -- Kun-Lai Summit
	-- Is another Man's Treasure
	[35177631] = { aID=7284, item="Frozen Trail Packer", aQuest=31304 }, -- Kafa Press itemID 86125
	[37417788] = { aID=7284, item="Frozen Trail Packer", aQuest=31304, tip="Enter here. Go right to the end" },
	[44675234] = { aID=7284, item=86393, aQuest=31417, tip="At the foot of Ren Yun the Blind" },
					-- Tablet of Ren Yun
	[52837129] = { aID=7284, item=86394, aQuest=31413, tip="Enter The Deeper, then check your map" },
					-- Hozen Warrior Spear
	[70056380] = { aID=7284, item="Stash of Yaungol Weapons", aQuest=31421 },
					-- Sturdy Yaungol Spear. itemID 88723. CONFIRMED
	[71156260] = { aID=7284, item="Stash of Yaungol Weapons", aQuest=31421 },
					-- Sturdy Yaungol Spear. itemID 88723
	[72977347] = { aID=7284, item="Sprite's Cloth Chest", aQuest=31412, tip="Enter Pranksters' Hollow" },

	-- Glorious
	[36657984] = { aID=7439, aIndex=18, continent=true }, -- Ski'thik
	[40814263] = { aID=7439, aIndex=39, continent=true }, -- Ahone the Wanderer
	[45096364] = { aID=7439, aIndex=4, tip="Maybe in this cave" }, -- Scritch
	[45106525] = { aID=7439, aIndex=4, tip="Maybe in this cave" }, -- Scritch
	[46236190] = { aID=7439, aIndex=4, tip="Maybe in this cave", continent=true  }, -- Scritch CONFIRMED
	[46896565] = { aID=7439, aIndex=4, tip="Maybe in this cave" }, -- Scritch
	[47016309] = { aID=7439, aIndex=4, tip="Maybe in this cave" }, -- Scritch
	[47588117] = { aID=7439, aIndex=53, tip="Patrol path" }, -- Korda Torros
	[48558133] = { aID=7439, aIndex=53, tip="Patrol path" }, -- Korda Torros
	[48908071] = { aID=7439, aIndex=53, tip="Patrol path" }, -- Korda Torros
	[49488078] = { aID=7439, aIndex=53, tip="Patrol path", continent=true  }, -- Korda Torros
	[50288060] = { aID=7439, aIndex=53, tip="Patrol path" }, -- Korda Torros
	[51038067] = { aID=7439, aIndex=53, tip="Patrol path" }, -- Korda Torros
	[51077930] = { aID=7439, aIndex=53, tip="Patrol path" }, -- Korda Torros
	[51438007] = { aID=7439, aIndex=53, tip="Patrol path" }, -- Korda Torros
	[55444397] = { aID=7439, aIndex=25, }, -- Borginn Darkfist
	[55634345] = { aID=7439, aIndex=25, continent=true }, -- Borginn Darkfist
	[56064321] = { aID=7439, aIndex=25, }, -- Borginn Darkfist
	[57047600] = { aID=7439, aIndex=32, }, -- Havak
	[57497494] = { aID=7439, aIndex=32, }, -- Havak
	[58717395] = { aID=7439, aIndex=32, continent=true }, -- Havak
	[59357376] = { aID=7439, aIndex=32, }, -- Havak
	[63911374] = { aID=7439, aIndex=46, continent=true }, -- Nessos the Oracle
	[73387625] = { aID=7439, aIndex=11, author="V. More?" }, -- Zai the Outcast
	[73867724] = { aID=7439, aIndex=11, author="V. More?", continent=true  }, -- Zai the Outcast
	[74137880] = { aID=7439, aIndex=11, author="V. More?" }, -- Zai the Outcast
	[74377929] = { aID=7439, aIndex=11, author="V. More?" }, -- Zai the Outcast
	
	-- Riches of Pandaria
	[36747983] = { aID=7997, item="Lost Adventurer's Belongings", aQuest=31418 },
	[50476197] = { aID=7997, item="Hozen Treasure Cache", aQuest=31414,
					tip="Enter Knucklethump Hole, then check your map" },
	[52575154] = { aID=7997, item="Rikktik's Tiny Chest", aQuest=31419 },
					-- Rikktik's  Tick Remover, itemID 86430
	[52205074] = { aID=7997, item="Rikktik's Tiny Chest", aQuest=31419, tip="Enter Emperor Rikktik's Rest" }, 
	[59695310] = { aID=7997, item="Stolen Sprite Treasure", aQuest=31415,
					tip="Enter Howlingwind Cavern, then check your map" },
	[63194173] = { aID=7997, item=86471, aQuest=31420, tip="Enter the Path of Conquerors" },
					-- Ancient Mogu Tablet
	[63925017] = { aID=7997, item=86471, aQuest=31420, tip="Enter the Path of Conquerors" },
					-- Ancient Mogu Tablet
	[64224511] = { aID=7997, item=86471, aQuest=31420, tip="Inside the Path of Conquerors" },
					-- Ancient Mogu Tablet
	[72013397] = { aID=7997, item=86422, aQuest=31416, tip="Submerged" }, -- Statue of Xuen
	[57787632] = { aID=7997, item=86427, aQuest=31422, }, -- Terracotta Head

	-- Zul Again
	[75126753] = { aID=8078, tip="Zandalari Warbringer. There are three types, each dropping\n"
					.."a different coloured Primordial Direhorn mount.\n\n"
					.."Can despawn as fast as 2 to 3 minutes after spawning" },
	[66858422] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[66888478] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[66927998] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[66948050] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[66958376] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[66958522] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[67038114] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[67188581] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[67128339] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[67168164] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[67228288] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[67278229] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[67367982] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[67638614] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[67697957] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[67997935] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[68208639] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[68257901] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[68477870] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[68737838] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[68947791] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[69167753] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[69447695] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[69737665] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[70017635] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[70327603] = { aID=8078, npc=69768, tip="Zandalari Warscout", continent=true },
	[70547565] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[70717524] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[70887496] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[71107477] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[71367462] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[71457331] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[71457427] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[71537385] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[71577272] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[71737225] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[72007169] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[72337134] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[72587108] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[72827084] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[73016997] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[73017047] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[73096954] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[73176910] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[73276860] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[73536828] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[74156824] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[74656784] = { aID=8078, npc=69768, tip="Zandalari Warscout" },

	-- Miscellany
	[40994236] = { aID=6855, aIndex=7, }, -- Part 7
	[43835120] = { aID=6855, aIndex=2, }, -- Part 2
	[44675233] = { aID=7230, aIndex=3, }, -- Ren Yun the Blind
	[45766188] = { aID=6850, aIndex=4, }, -- The Hozen Ravage
	[50397927] = { aID=6847, aIndex=1, }, -- Yaungol Tactics
	[53034648] = { aID=6754, aIndex=1, tip="Enter through here. Beware of traps inside" },
					-- Valley of the Emperors
	[63034080] = { aID=6858, aIndex=5, }, -- Victory in Kun-Lai
	[67754834] = { aID=6855, aIndex=6, }, -- Part 6
	[71746301] = { aID=6847, aIndex=3, }, -- Yaungoil
	[74488357] = { aID=6846, aIndex=4, }, -- Role Call
}
points[ 380 ] = { -- Kun-Lai Summit - Howlingwind Cavern
	[41724421] = { aID=7997, item="Stolen Sprite Treasure", aQuest=31415 },
}
points[ 381 ] = { -- Kun-Lai Summit - Pranksters' Hollow
	[55237029] = { aID=7284, item="Sprite's Cloth Chest", aQuest=31412 }, -- various loot
}
points[ 382 ] = { -- Kun-Lai Summit - Knucklethump Hole
	[51952745] = { aID=7997, item="Hozen Treasure Cache", aQuest=31414 },
}
points[ 383 ] = { -- Kun-Lai Summit - The Deeper - Upper Deep
	[62814977] = { aID=7284, item=86394, aQuest=31413, tip="Go this way (descend)" }, -- Hozen Warrior Spear
}
points[ 384 ] = { -- Kun-Lai Summit - The Deeper - Lower Deep
	[24086749] = { aID=7284, item=86394, aQuest=31413, tip="Embedded in the largest rock in the pool" },
					-- Hozen Warrior Spear
	[32244133] = { aID=7284, item=86394, aQuest=31413, tip="Come this way" }, -- Hozen Warrior Spear
}
points[ 385 ] = { -- Kun-Lai Summit - Tomb of Conquerors
	[58357143] = { aID=6754, aIndex=1, }, -- Valley of the Emperors
}
points[ 371 ] = { -- The Jade Forest

	-- To All the Squirrels I Once Caressed?
	[30105090] = { aID=6350, aIndex=9, }, -- Leopard Tree Frog
	[31195048] = { aID=6350, aIndex=9, }, -- Leopard Tree Frog
	[31594945] = { aID=6350, aIndex=9, }, -- Leopard Tree Frog
	[32454699] = { aID=6350, aIndex=9, }, -- Leopard Tree Frog
	[33445060] = { aID=6350, aIndex=15, }, -- Shrine Fly
	[33515135] = { aID=6350, aIndex=9, }, -- Leopard Tree Frog
	[33634758] = { aID=6350, aIndex=9, }, -- Leopard Tree Frog
	[33675086] = { aID=6350, aIndex=15, }, -- Shrine Fly
	[34134748] = { aID=6350, aIndex=9, }, -- Leopard Tree Frog
	[35214815] = { aID=6350, aIndex=9, }, -- Leopard Tree Frog
	[36014852] = { aID=6350, aIndex=9, }, -- Leopard Tree Frog
	[36215964] = { aID=6350, aIndex=15, continent=true }, -- Shrine Fly
	[36325741] = { aID=6350, aIndex=15, }, -- Shrine Fly
	[36625844] = { aID=6350, aIndex=15, }, -- Shrine Fly
	[36955784] = { aID=6350, aIndex=15, }, -- Shrine Fly
	[37135812] = { aID=6350, aIndex=15, }, -- Shrine Fly
	[37425885] = { aID=6350, aIndex=15, }, -- Shrine Fly
	[37705135] = { aID=6350, aIndex=9, }, -- Leopard Tree Frog
	[37856172] = { aID=6350, aIndex=9, }, -- Leopard Tree Frog
	[41465552] = { aID=6350, aIndex=9, }, -- Leopard Tree Frog
	[41585683] = { aID=6350, aIndex=9, }, -- Leopard Tree Frog
	[41755833] = { aID=6350, aIndex=9, continent=true }, -- Leopard Tree Frog
	[41875966] = { aID=6350, aIndex=9, }, -- Leopard Tree Frog
	[42545460] = { aID=6350, aIndex=9, }, -- Leopard Tree Frog
	[43036495] = { aID=6350, aIndex=9, }, -- Leopard Tree Frog
	[43065719] = { aID=6350, aIndex=9, }, -- Leopard Tree Frog
	[43085908] = { aID=6350, aIndex=9, }, -- Leopard Tree Frog
	[43176066] = { aID=6350, aIndex=9, }, -- Leopard Tree Frog
	[43316131] = { aID=6350, aIndex=9, }, -- Leopard Tree Frog
	[43466351] = { aID=6350, aIndex=9, }, -- Leopard Tree Frog
	[43947628] = { aID=6350, aIndex=9, }, -- Leopard Tree Frog
	[63908482] = { aID=6350, aIndex=4, }, -- Coral Adder
	[64368533] = { aID=6350, aIndex=4, }, -- Coral Adder
	[64548620] = { aID=6350, aIndex=4, }, -- Coral Adder
	[64958423] = { aID=6350, aIndex=4, }, -- Coral Adder
	[65208564] = { aID=6350, aIndex=4, continent=true }, -- Coral Adder
	[65518262] = { aID=6350, aIndex=4, }, -- Coral Adder
	[66098267] = { aID=6350, aIndex=4, }, -- Coral Adder
	[66268499] = { aID=6350, aIndex=4, }, -- Coral Adder
	[66318651] = { aID=6350, aIndex=4, }, -- Coral Adder
	[66798608] = { aID=6350, aIndex=4, }, -- Coral Adder
	
	-- Is another Man's Treasure
	[44926467] = { aID=7284, item=86196, aQuest=31402 }, -- Ancient Jinyu Staff
	[45576439] = { aID=7284, item=86196, aQuest=31402 }, -- Ancient Jinyu Staff
	[46167121] = { aID=7284, item=86196, aQuest=31402 }, -- Ancient Jinyu Staff
	[46386535] = { aID=7284, item=86196, aQuest=31402 }, -- Ancient Jinyu Staff
	[46437007] = { aID=7284, item=86196, aQuest=31402 }, -- Ancient Jinyu Staff
	[47106743] = { aID=7284, item=86196, aQuest=31402 }, -- Ancient Jinyu Staff
	[46092912] = { aID=7284, item=85777, aQuest=31399, -- Ancient Pandaren Mining Pick
					tip="It's in the mine. Several locations", author="No reliable data online" },
	[40201370] = { aID=7284, item=86198, aQuest=31403, }, -- Hammer of Ten Thunders
	[41201380] = { aID=7284, item=86198, aQuest=31403, }, -- Hammer of Ten Thunders
	[42001756] = { aID=7284, item=86198, aQuest=31403, }, -- Hammer of Ten Thunders
	[43001160] = { aID=7284, item=86198, aQuest=31403, }, -- Hammer of Ten Thunders
	[39254663] = { aID=7284, item=86199, aQuest=31307, -- Jade Infused Blade
					tip="Doesn't matter the quest phase - no spoilers -\n"
					.."you can always find this (if it has spawned)", },					
	[39420723] = { aID=7284, item=85776, aQuest=31397, }, -- Wodin's Mantid Shanker

	-- Glorious
	[33565078] = { aID=7439, aIndex=8, continent=true }, -- Aethis
	[39516261] = { aID=7439, aIndex=15, continent=true }, -- Krax'ik
	[40201360] = { aID=7439, aIndex=29, tip="Possible topmost spawn" },
	[42221741] = { aID=7439, aIndex=29, tip="Confirmed spawn", continent=true  }, -- Morgrinn Crackfang
	[42543885] = { aID=7439, aIndex=1, continent=true }, -- Mister Ferocious
	[43457672] = { aID=7439, aIndex=22, tip="Patrol path" },
	[43677619] = { aID=7439, aIndex=22, tip="Patrol path" },
	[43707187] = { aID=7439, aIndex=22, tip="Patrol path" },
	[43727279] = { aID=7439, aIndex=22, tip="Patrol path", continent=true  },
	[43957431] = { aID=7439, aIndex=22, tip="Patrol path" },
	[44017339] = { aID=7439, aIndex=22, tip="Patrol path" },
	[44017509] = { aID=7439, aIndex=22, tip="Patrol path" },
	[44037578] = { aID=7439, aIndex=22, tip="Patrol path" },
	[46301990] = { aID=7439, aIndex=29, tip="Possible bottommost spawn" },
	[47951843] = { aID=7439, aIndex=29, tip="Confirmed spawn" }, -- Morgrinn Crackfang
	[53584965] = { aID=7439, aIndex=50, }, -- Ferdinand
	[54234231] = { aID=7439, aIndex=50, continent=true }, -- Ferdinand
	[57387169] = { aID=7439, aIndex=36, continent=true }, -- Urobi the Walker
	[66007420] = { aID=7439, aIndex=43, continent=true }, -- Sarnak

	-- Riches of Pandaria
	[23493505] = { aID=7997, item=86216, aQuest=31404, }, -- Pandaren Ritual Stone
	[26213235] = { aID=7997, item=85780, aQuest=31400, tip="On the table. Where else would it be!" },
					-- Ancient Pandaren Tea Pot
	[31962776] = { aID=7997, item=85781, aQuest=31401, }, -- Lucky Pandaren Coin
	[51299800] = { aID=7997, item="Ship's Locker", aQuest=31396,
					tip="Due south and off the map. Switch to the Pandaria map" }, -- object 213362

	-- Zul Again
	[52561885] = { aID=8078, tip="Zandalari Warbringer. There are three types, each dropping\n"
					.."a different coloured Primordial Direhorn mount.\n\n"
					.."Can despawn as fast as 2 to 3 minutes after spawning" },
	[42711655] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[43761733] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[44621782] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[45531743] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[46501832] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[46761956] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[47182089] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[48282136] = { aID=8078, npc=69768, tip="Zandalari Warscout", continent=true },
	[49282080] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[49483692] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[50172004] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[50743701] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[51432009] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[51803720] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[52621924] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[52632213] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[52722371] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[52793166] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[52843348] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[52923687] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[53022066] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[53023530] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[53343012] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[53362494] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[53892845] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[53902646] = { aID=8078, npc=69768, tip="Zandalari Warscout" },

	-- Miscellany	
	[29014636] = { aID=6850, aIndex=1, }, -- Hozen Speech
	[34073344] = { aID=7381, tip="Click the Broken Incense Burner" },
	[35753045] = { aID=6858, aIndex=3, }, -- The First Monks
	[37383012] = { aID=7230, aIndex=2, }, -- Xin Wu Yin the Broken Hearted
	[42271748] = { aID=6754, aIndex=3, }, -- Spirit Binders
	[47084512] = { aID=6855, aIndex=1, }, -- Part 1
	[55895683] = { aID=6855, aIndex=3, }, -- Part 3
	[66018858] = { aID=6846, aIndex=1, }, -- Watersmithing
	[67722936] = { aID=6716, aIndex=1, }, -- The Saurok
}
points[ 372 ] = { -- Greenstone Quarry in The Jade Forest
	[52044144] = { aID=7284, item=85777, aQuest=31399, -- Is another Man's Treasure
					tip="Several confirmed locations. Descend and check the map.\n"
						.."Note: This is NOT one of them, they're all below" },
}
points[ 373 ] = { -- Greenstone Quarry in The Jade Forest
	[33327792] = { aID=7284, item=85777, aQuest=31399, }, -- Ancient Pandaren Mining Pick
	[37911352] = { aID=7284, item=85777, aQuest=31399, }, -- Ancient Pandaren Mining Pick
	[40334133] = { aID=7284, item=85777, aQuest=31399, }, -- Ancient Pandaren Mining Pick
	[64235565] = { aID=7284, item=85777, aQuest=31399, }, -- Ancient Pandaren Mining Pick
}
points[ 433 ] = { -- The Veiled Stair
	[45770404] = { aID=6716, aIndex=2, }, -- The Defiant
	[74907648] = { aID=7284, item=86473, aQuest=31428, }, -- The Hammer of Folly
}

local ancientSpineclaw = "Kill the Ancient Spineclaw mobs to\nforce the Monstrous Spineclaw to spawn"
local deathAdder = "Kill the Death Adder mobs to\nforce the Imperial Adder to spawn"
local emeraldGander = "Kill the Brilliant Windfeather mobs to force a spawn"
local evermaw = "Swims clockwise and fast! Do NOT discard\nthe \"Mist-Filled Spirit Lantern\".\n\n"
				.."The Lantern is needed to summon another\n"
				.."rare elite - Dread Ship Vazuvius"
local glintingSand = "Glinting sand has a chance to contain \"Rolo's Riddle\",\n"
					.."a quest starter which leads to an achievement. If you\n"
					.."leave the zone the item will disappear"
local greatTurtle = "Farm all the great turtle mobs to force a spawn"
local ironfur = "Farm all the ironfur mobs to force a spawn"
local legends = colourHighlight .."19 locations randomly spawn one of the four\n"
				.."objects and they may be clicked multiple times"
local several = "Several in this area"
local timeLostShrine = colourHighlight .."12 shrines randomly give one of the four buffs.\n"
						.."There is a five minute reactivation timer"

points[ 554 ] = { -- Timeless Isle
	[77005900] = { aList=1 },

	-- Killing Time
	[31407220] = { aID=8712, aIndex=1, npc=72908, }, -- Spotted Swarmer
	[32607520] = { aID=8712, aIndex=1, npc=72908, },
	[33807800] = { aID=8712, aIndex=1, npc=72908, },
	[37406940] = { aID=8712, aIndex=1, npc=72908, },
	[38608300] = { aID=8712, aIndex=1, npc=72908, },
	[40407680] = { aID=8712, aIndex=1, npc=72908, },
	[40407980] = { aID=8712, aIndex=1, npc=72908, },
	[40607880] = { aID=8712, aIndex=1, npc=72908, },
	[41607720] = { aID=8712, aIndex=1, npc=72908, },
	[42007240] = { aID=8712, aIndex=1, npc=72908, },
	[42607540] = { aID=8712, aIndex=1, npc=72908, },
	[26605220] = { aID=8712, aIndex=2, npc=71143, tip=several }, -- Windfeather Chick
	[28405040] = { aID=8712, aIndex=2, npc=71143 },
	[29605260] = { aID=8712, aIndex=2, npc=71143, tip=several },
	[29606720] = { aID=8712, aIndex=2, npc=71143, tip=several },
	[29806060] = { aID=8712, aIndex=2, npc=71143, tip=several },
	[30003420] = { aID=8712, aIndex=2, npc=71143, tip=several },
	[30406620] = { aID=8712, aIndex=2, npc=71143 },
	[30602880] = { aID=8712, aIndex=2, npc=71143, tip=several },
	[30604160] = { aID=8712, aIndex=2, npc=71143 },
	[30906205] = { aID=8712, aIndex=2, npc=71143 },
	[31605020] = { aID=8712, aIndex=2, npc=71143, tip=several },
	[31607880] = { aID=8712, aIndex=2, npc=71143, tip=several },
	[32656465] = { aID=8712, aIndex=2, npc=71143, tip=several },
	[32005240] = { aID=8712, aIndex=2, npc=71143, tip=several },
	[32407060] = { aID=8712, aIndex=2, npc=71143, tip=several },
	[32605280] = { aID=8712, aIndex=2, npc=71143, tip=several },
	[33208020] = { aID=8712, aIndex=2, npc=71143, tip=several },
	[33605180] = { aID=8712, aIndex=2, npc=71143, tip=several },
	[33006660] = { aID=8712, aIndex=2, npc=71143, tip=several },
	[34808220] = { aID=8712, aIndex=2, npc=71143, tip=several },
	[35803880] = { aID=8712, aIndex=2, npc=71143, tip=several },
	[36008220] = { aID=8712, aIndex=2, npc=71143, tip=several },
	[37603900] = { aID=8712, aIndex=2, npc=71143, tip=several },
	[39003800] = { aID=8712, aIndex=2, npc=71143 },
	[39404400] = { aID=8712, aIndex=2, npc=71143, tip=several },
	[39504050] = { aID=8712, aIndex=2, npc=71143, tip=several },
	[40808120] = { aID=8712, aIndex=2, npc=71143, tip=several },
	[41206960] = { aID=8712, aIndex=2, npc=71143, tip=several },
	[41608120] = { aID=8712, aIndex=2, npc=71143, tip=several },
	[42406860] = { aID=8712, aIndex=2, npc=71143, tip=several },
	[42604480] = { aID=8712, aIndex=2, npc=71143, tip=several },
	[43206620] = { aID=8712, aIndex=2, npc=71143, tip=several },
	[44505360] = { aID=8712, aIndex=2, npc=71143, tip=several },
	[44806220] = { aID=8712, aIndex=2, npc=71143, tip=several },
	[45205240] = { aID=8712, aIndex=2, npc=71143, tip=several },
	[45205680] = { aID=8712, aIndex=2, npc=71143, tip=several },
	[20604460] = { aID=8712, aIndex=3, npc=72763, tip=several }, -- Great Turtle Hatchling
	[21404300] = { aID=8712, aIndex=3, npc=72763, tip=several },
	[21405280] = { aID=8712, aIndex=3, npc=72763, tip=several },
	[21804960] = { aID=8712, aIndex=3, npc=72763, tip=several },
	[23505440] = { aID=8712, aIndex=3, npc=72763, tip=several },
	[22604440] = { aID=8712, aIndex=3, npc=72763, tip=several },
	[22604800] = { aID=8712, aIndex=3, npc=72763, tip=several },
	[22806680] = { aID=8712, aIndex=3, npc=72763, tip=several },
	[22855140] = { aID=8712, aIndex=3, npc=72763, tip=several },
	[23606220] = { aID=8712, aIndex=3, npc=72763, tip=several },
	[23606340] = { aID=8712, aIndex=3, npc=72763, tip=several },
	[23606540] = { aID=8712, aIndex=3, npc=72763, tip=several },
	[24004700] = { aID=8712, aIndex=3, npc=72763, tip=several },
	[24004760] = { aID=8712, aIndex=3, npc=72763, tip=several },
	[24205660] = { aID=8712, aIndex=3, npc=72763, tip=several },
	[24806060] = { aID=8712, aIndex=3, npc=72763, tip=several },
	[25005140] = { aID=8712, aIndex=3, npc=72763, tip=several },
	[25007000] = { aID=8712, aIndex=3, npc=72763, tip=several },
	[25605320] = { aID=8712, aIndex=3, npc=72763, tip=several },
	[26804660] = { aID=8712, aIndex=4, npc=72842, tip=several }, -- Ironfur Herdling
	[27203960] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[28004700] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[28204060] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[28205080] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[28604880] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[28605960] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[29003940] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[29004360] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[29007160] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[29404560] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[29404740] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[29606980] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[30004420] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[30207160] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[30604720] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[30604920] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[30807000] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[31404300] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[31404480] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[31405860] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[31807060] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[32005960] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[32605800] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[32604280] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[32604480] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[32605800] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[33006280] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[33207000] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[33403680] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[33603860] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[33606280] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[33806140] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[34603760] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[34604100] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[34607080] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[34806780] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[35006720] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[35007260] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[35404260] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[35607160] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[36206760] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[37603680] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[39603780] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[40806540] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[40806760] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[43605160] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[43804360] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[44605480] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[44605860] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[45255180] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[45406380] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[45604460] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[46204860] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[46606020] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[46806300] = { aID=8712, aIndex=4, npc=72842, tip=several },
	[26605220] = { aID=8712, aIndex=5, npc=72761 }, -- Windfeather Nestkeeper
	[28405040] = { aID=8712, aIndex=5, npc=72761 },
	[29605240] = { aID=8712, aIndex=5, npc=72761, tip=several },
	[29606720] = { aID=8712, aIndex=5, npc=72761, tip=several },
	[30203320] = { aID=8712, aIndex=5, npc=72761 },
	[30306115] = { aID=8712, aIndex=5, npc=72761, tip=several },
	[30403920] = { aID=8712, aIndex=5, npc=72761, tip=several },
	[30804380] = { aID=8712, aIndex=5, npc=72761, tip=several },
	[31205000] = { aID=8712, aIndex=5, npc=72761, tip=several },
	[32156615] = { aID=8712, aIndex=5, npc=72761, tip=several },
	[31607860] = { aID=8712, aIndex=5, npc=72761, tip=several },
	[32805280] = { aID=8712, aIndex=5, npc=72761, tip=several },
	[33056820] = { aID=8712, aIndex=5, npc=72761 },
	[33806700] = { aID=8712, aIndex=5, npc=72761, tip=several },
	[34008160] = { aID=8712, aIndex=5, npc=72761, tip=several },
	[35803880] = { aID=8712, aIndex=5, npc=72761, tip=several },
	[36608380] = { aID=8712, aIndex=5, npc=72761, tip=several },
	[37603900] = { aID=8712, aIndex=5, npc=72761, tip=several },
	[39204480] = { aID=8712, aIndex=5, npc=72761, tip=several },
	[40004200] = { aID=8712, aIndex=5, npc=72761, tip=several },
	[40608160] = { aID=8712, aIndex=5, npc=72761, tip=several },
	[42006980] = { aID=8712, aIndex=5, npc=72761, tip=several },
	[42204355] = { aID=8712, aIndex=5, npc=72761, tip=several },
	[43206860] = { aID=8712, aIndex=5, npc=72761, tip=several },
	[43406620] = { aID=8712, aIndex=5, npc=72761, tip=several },
	[44006520] = { aID=8712, aIndex=5, npc=72761, tip=several },
	[44206160] = { aID=8712, aIndex=5, npc=72761, tip=several },
	[44406580] = { aID=8712, aIndex=5, npc=72761, tip=several },
	[45005300] = { aID=8712, aIndex=5, npc=72761, tip=several },
	[27803920] = { aID=8712, aIndex=6, npc=72843, tip=several }, -- Ironfur Grazer
	[27804560] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[27804840] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[28405100] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[28604060] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[28604660] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[28604900] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[28805840] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[29604500] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[29607160] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[29804340] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[30604940] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[30804700] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[31006920] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[31606800] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[31804340] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[31805860] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[32203780] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[33103800] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[33606120] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[34603740] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[34604180] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[34607160] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[35006880] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[35807100] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[36206760] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[37604380] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[38003720] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[39203760] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[40606640] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[40503845] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[41603700] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[43404280] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[44005340] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[44604340] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[45204980] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[44705120] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[45205680] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[45406460] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[44955950] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[46805020] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[46806200] = { aID=8712, aIndex=6, npc=72843, tip=several },
	[35607920] = { aID=8712, aIndex=7, npc=73018, tip=several }, -- Spectral Brewmaster
	[36007580] = { aID=8712, aIndex=7, npc=73018, tip=several },
	[37607460] = { aID=8712, aIndex=7, npc=73018, tip=several },
	[37608080] = { aID=8712, aIndex=7, npc=73018, tip=several },
	[38807160] = { aID=8712, aIndex=7, npc=73018, tip=several },
	[39807780] = { aID=8712, aIndex=7, npc=73018, tip=several },
	[41207340] = { aID=8712, aIndex=7, npc=73018, tip=several },
	[34808360] = { aID=8712, aIndex=8, npc=73025, tip=several }, -- Spectral Mistweaver
	[35007800] = { aID=8712, aIndex=8, npc=73025, tip=several },
	[35207640] = { aID=8712, aIndex=8, npc=73025, tip=several },
	[36607560] = { aID=8712, aIndex=8, npc=73025, tip=several },
	[37607400] = { aID=8712, aIndex=8, npc=73025, tip=several },
	[37608100] = { aID=8712, aIndex=8, npc=73025, tip=several },
	[38607260] = { aID=8712, aIndex=8, npc=73025, tip=several },
	[39207460] = { aID=8712, aIndex=8, npc=73025, tip=several },
	[39607940] = { aID=8712, aIndex=8, npc=73025, tip=several },
	[35807780] = { aID=8712, aIndex=9, npc=73021, tip=several }, -- Spectral Windwalker
	[36007540] = { aID=8712, aIndex=9, npc=73021, tip=several },
	[36808060] = { aID=8712, aIndex=9, npc=73021, tip=several },
	[37607400] = { aID=8712, aIndex=9, npc=73021, tip=several },
	[39007260] = { aID=8712, aIndex=9, npc=73021, tip=several },
	[39607380] = { aID=8712, aIndex=9, npc=73021, tip=several },
	[39607960] = { aID=8712, aIndex=9, npc=73021, tip=several },
	[48604640] = { aID=8712, aIndex=10, npc=72807, tip=several }, -- Crag stalker
	[48806240] = { aID=8712, aIndex=10, npc=72807, tip=several },
	[49005280] = { aID=8712, aIndex=10, npc=72807, tip=several },
	[49204960] = { aID=8712, aIndex=10, npc=72807, tip=several },
	[49606020] = { aID=8712, aIndex=10, npc=72807, tip=several },
	[49806540] = { aID=8712, aIndex=10, npc=72807, tip=several },
	[50005120] = { aID=8712, aIndex=10, npc=72807, tip=several },
	[50405740] = { aID=8712, aIndex=10, npc=72807, tip=several },
	[50605340] = { aID=8712, aIndex=10, npc=72807, tip=several },
	[50606660] = { aID=8712, aIndex=10, npc=72807, tip=several },
	[51006160] = { aID=8712, aIndex=10, npc=72807, tip=several },
	[51606360] = { aID=8712, aIndex=10, npc=72807, tip=several },
	[51805420] = { aID=8712, aIndex=10, npc=72807, tip=several },
	[52105825] = { aID=8712, aIndex=10, npc=72807, tip=several },
	[52606680] = { aID=8712, aIndex=10, npc=72807, tip=several },
	[53007060] = { aID=8712, aIndex=10, npc=72807, tip=several },
	[54404380] = { aID=8712, aIndex=10, npc=72807, tip=several },
	[54606920] = { aID=8712, aIndex=10, npc=72807, tip=several },
	[54805560] = { aID=8712, aIndex=10, npc=72807, tip=several },
	[55004560] = { aID=8712, aIndex=10, npc=72807, tip=several },
	[57004560] = { aID=8712, aIndex=10, npc=72807, tip=several },
	[57006980] = { aID=8712, aIndex=10, npc=72807, tip=several },
	[57804860] = { aID=8712, aIndex=10, npc=72807, tip=several },
	[58205080] = { aID=8712, aIndex=10, npc=72807, tip=several },
	[58205420] = { aID=8712, aIndex=10, npc=72807, tip=several },
	[59606760] = { aID=8712, aIndex=10, npc=72807, tip=several },
	[60606560] = { aID=8712, aIndex=10, npc=72807, tip=several },
	[60805260] = { aID=8712, aIndex=10, npc=72807, tip=several },
	[61905600] = { aID=8712, aIndex=10, npc=72807, tip=several },
	[62605280] = { aID=8712, aIndex=10, npc=72807, tip=several },
	[63605900] = { aID=8712, aIndex=10, npc=72807, tip=several },
	[64206120] = { aID=8712, aIndex=10, npc=72807, tip=several },
	[64405500] = { aID=8712, aIndex=10, npc=72807, tip=several },
	[65005060] = { aID=8712, aIndex=10, npc=72807, tip=several },
	[63404160] = { aID=8712, aIndex=11, npc=72877, tip=several }, -- Ashleaf Sprite
	[63803600] = { aID=8712, aIndex=11, npc=72877 },
	[65805800] = { aID=8712, aIndex=11, npc=72877, tip=several },
	[66203880] = { aID=8712, aIndex=11, npc=72877, tip=several },
	[67604400] = { aID=8712, aIndex=11, npc=72877, tip=several },
	[69005240] = { aID=8712, aIndex=11, npc=72877, tip=several },
	[71005540] = { aID=8712, aIndex=11, npc=72877, tip=several },
	[71204140] = { aID=8712, aIndex=11, npc=72877, tip=several },
	[73604720] = { aID=8712, aIndex=11, npc=72877, tip=several },
	[48007860] = { aID=8712, aIndex=12, npc=72875, tip=several }, -- Ordon Candlekeeper
	[50608280] = { aID=8712, aIndex=12, npc=72875, tip=several },
	[52208220] = { aID=8712, aIndex=12, npc=72875, tip=several },
	[52407540] = { aID=8712, aIndex=12, npc=72875, tip=several },
	[53208000] = { aID=8712, aIndex=12, npc=72875, tip=several },
	[54207380] = { aID=8712, aIndex=12, npc=72875, tip=several },
	[54608000] = { aID=8712, aIndex=12, npc=72875, tip=several },
	[54608420] = { aID=8712, aIndex=12, npc=72875, tip=several },
	[55008240] = { aID=8712, aIndex=12, npc=72875, tip=several },
	[55207840] = { aID=8712, aIndex=12, npc=72875, tip=several },
	[55607800] = { aID=8712, aIndex=12, npc=72875, tip=several },
	[56808000] = { aID=8712, aIndex=12, npc=72875, tip=several },
	[56907500] = { aID=8712, aIndex=12, npc=72875, tip=several },
	[58607660] = { aID=8712, aIndex=12, npc=72875, tip=several },
	[43903910] = { aID=8712, aIndex=13, npc=73162, tip=several }, -- Fireboding Flame
	[45603280] = { aID=8712, aIndex=13, npc=73162, tip=several },
	[45803720] = { aID=8712, aIndex=13, npc=73162, tip=several },
	[47003260] = { aID=8712, aIndex=13, npc=73162, tip=several },
	[47203560] = { aID=8712, aIndex=13, npc=73162, tip=several },
	[25773019] = { aID=8712, aIndex=14, npc=72767, tip=several }, -- Jademist Dancer
	[29605060] = { aID=8712, aIndex=15, npc=72762, tip=several }, -- Brilliant Windfeather
	[30155890] = { aID=8712, aIndex=15, npc=72762, tip=several },
	[30496415] = { aID=8712, aIndex=15, npc=72762, tip=several },
	[30804380] = { aID=8712, aIndex=15, npc=72762, tip=several },
	[30806660] = { aID=8712, aIndex=15, npc=72762, tip=several },
	[31205160] = { aID=8712, aIndex=15, npc=72762, tip=several },
	[31804060] = { aID=8712, aIndex=15, npc=72762, tip=several },
	[31807980] = { aID=8712, aIndex=15, npc=72762, tip=several },
	[32604860] = { aID=8712, aIndex=15, npc=72762, tip=several },
	[36604060] = { aID=8712, aIndex=15, npc=72762, tip=several },
	[36808380] = { aID=8712, aIndex=15, npc=72762, tip=several },
	[38604160] = { aID=8712, aIndex=15, npc=72762, tip=several },
	[39606860] = { aID=8712, aIndex=15, npc=72762, tip=several },
	[41254160] = { aID=8712, aIndex=15, npc=72762, tip=several },
	[40804320] = { aID=8712, aIndex=15, npc=72762, tip=several },
	[42606760] = { aID=8712, aIndex=15, npc=72762, tip=several },
	[42607060] = { aID=8712, aIndex=15, npc=72762, tip=several },
	[44605480] = { aID=8712, aIndex=15, npc=72762, tip=several },
	[44606140] = { aID=8712, aIndex=15, npc=72762, tip=several },
	[20604260] = { aID=8712, aIndex=16, npc=72764, tip=several }, -- Great Turtle
	[22004260] = { aID=8712, aIndex=16, npc=72764, tip=several },
	[21604460] = { aID=8712, aIndex=16, npc=72764, tip=several },
	[22006160] = { aID=8712, aIndex=16, npc=72764, tip=several },
	[22604660] = { aID=8712, aIndex=16, npc=72764, tip=several },
	[22606560] = { aID=8712, aIndex=16, npc=72764, tip=several },
	[22606800] = { aID=8712, aIndex=16, npc=72764, tip=several },
	[23355300] = { aID=8712, aIndex=16, npc=72764, tip=several },
	[23405800] = { aID=8712, aIndex=16, npc=72764, tip=several },
	[23406280] = { aID=8712, aIndex=16, npc=72764, tip=several },
	[23604960] = { aID=8712, aIndex=16, npc=72764, tip=several },
	[23806060] = { aID=8712, aIndex=16, npc=72764, tip=several },
	[24207000] = { aID=8712, aIndex=16, npc=72764, tip=several },
	[24607020] = { aID=8712, aIndex=16, npc=72764, tip=several },
	[25355740] = { aID=8712, aIndex=16, npc=72764, tip=several },
	[25405300] = { aID=8712, aIndex=16, npc=72764, tip=several },
	[25805060] = { aID=8712, aIndex=16, npc=72764, tip=several },
	[26207200] = { aID=8712, aIndex=16, npc=72764, tip=several },
	[28003940] = { aID=8712, aIndex=17, npc=72844, tip=several }, -- Ironfur Great Bull
	[28005940] = { aID=8712, aIndex=17, npc=72844, tip=several },
	[28404680] = { aID=8712, aIndex=17, npc=72844, tip=several },
	[28604980] = { aID=8712, aIndex=17, npc=72844, tip=several },
	[29204440] = { aID=8712, aIndex=17, npc=72844, tip=several },
	[29604340] = { aID=8712, aIndex=17, npc=72844, tip=several },
	[29607000] = { aID=8712, aIndex=17, npc=72844, tip=several },
	[30604800] = { aID=8712, aIndex=17, npc=72844, tip=several },
	[31406920] = { aID=8712, aIndex=17, npc=72844, tip=several },
	[32004460] = { aID=8712, aIndex=17, npc=72844, tip=several },
	[32005940] = { aID=8712, aIndex=17, npc=72844, tip=several },
	[33006200] = { aID=8712, aIndex=17, npc=72844, tip=several },
	[34203840] = { aID=8712, aIndex=17, npc=72844, tip=several },
	[34804080] = { aID=8712, aIndex=17, npc=72844 },
	[35004300] = { aID=8712, aIndex=17, npc=72844 },
	[35006720] = { aID=8712, aIndex=17, npc=72844, tip=several },
	[35007100] = { aID=8712, aIndex=17, npc=72844, tip=several },
	[37803660] = { aID=8712, aIndex=17, npc=72844 },
	[41003760] = { aID=8712, aIndex=17, npc=72844 },
	[41006580] = { aID=8712, aIndex=17, npc=72844, tip=several },
	[44604340] = { aID=8712, aIndex=17, npc=72844 },
	[44605260] = { aID=8712, aIndex=17, npc=72844, tip=several },
	[45405840] = { aID=8712, aIndex=17, npc=72844, tip=several },
	[45204560] = { aID=8712, aIndex=17, npc=72844 },
	[46806300] = { aID=8712, aIndex=17, npc=72844, tip=several },
	[42603220] = { aID=8712, aIndex=18, npc=72771, tip=several }, -- Damp Shambler
	[43602940] = { aID=8712, aIndex=18, npc=72771, tip=several },
	[44403240] = { aID=8712, aIndex=18, npc=72771, tip=several },
	[47802920] = { aID=8712, aIndex=18, npc=72771, tip=several },
	[49405840] = { aID=8712, aIndex=19, npc=72805, tip=several }, -- Primal Stalker
	[50305613] = { aID=8712, aIndex=19, npc=72805, tip=several },
	[52406140] = { aID=8712, aIndex=19, npc=72805, tip=several },
	[52606380] = { aID=8712, aIndex=19, npc=72805, tip=several },
	[55604500] = { aID=8712, aIndex=19, npc=72805, tip=several },
	[57804680] = { aID=8712, aIndex=19, npc=72805, tip=several },
	[59806680] = { aID=8712, aIndex=19, npc=72805, tip=several },
	[61405260] = { aID=8712, aIndex=19, npc=72805, tip=several },
	[62805220] = { aID=8712, aIndex=19, npc=72805, tip=several },
	[63605780] = { aID=8712, aIndex=19, npc=72805, tip=several },
	[63606030] = { aID=8712, aIndex=19, npc=72805, tip=several },
	[64805480] = { aID=8712, aIndex=19, npc=72805, tip=several },
	[15603680] = { aID=8712, aIndex=20, npc=72766, tip=several },
	[15603680] = { aID=8712, aIndex=20, npc=72766 }, -- Ancient Spineclaw
	[16406060] = { aID=8712, aIndex=20, npc=72766 },
	[17605300] = { aID=8712, aIndex=20, npc=72766, tip=several },
	[18007520] = { aID=8712, aIndex=20, npc=72766 },
	[18205860] = { aID=8712, aIndex=20, npc=72766 },
	[18206440] = { aID=8712, aIndex=20, npc=72766, tip=several },
	[18805440] = { aID=8712, aIndex=20, npc=72766 },
	[20604760] = { aID=8712, aIndex=20, npc=72766, tip=several },
	[21007100] = { aID=8712, aIndex=20, npc=72766 },
	[21206360] = { aID=8712, aIndex=20, npc=72766 },
	[21603260] = { aID=8712, aIndex=20, npc=72766, tip=several },
	[21603540] = { aID=8712, aIndex=20, npc=72766, tip=several },
	[22603080] = { aID=8712, aIndex=20, npc=72766, tip=several },
	[22803560] = { aID=8712, aIndex=20, npc=72766, tip=several },
	[23602880] = { aID=8712, aIndex=20, npc=72766, tip=several },
	[25407460] = { aID=8712, aIndex=20, npc=72766, tip=several },
	[27608040] = { aID=8712, aIndex=20, npc=72766 },
	[27807460] = { aID=8712, aIndex=20, npc=72766, tip=several },
	[29208400] = { aID=8712, aIndex=20, npc=72766 },
	[30603100] = { aID=8712, aIndex=20, npc=72766 },
	[33008580] = { aID=8712, aIndex=20, npc=72766 },
	[38608680] = { aID=8712, aIndex=20, npc=72766 },
	[40609080] = { aID=8712, aIndex=20, npc=72766 },
	[44809040] = { aID=8712, aIndex=20, npc=72766 },
	[52008680] = { aID=8712, aIndex=20, npc=72766 },
	[62208240] = { aID=8712, aIndex=20, npc=72766 },
	[66007840] = { aID=8712, aIndex=20, npc=72766 },
	[68007780] = { aID=8712, aIndex=20, npc=72766 },
	[68607420] = { aID=8712, aIndex=20, npc=72766 },
	[70207040] = { aID=8712, aIndex=20, npc=72766 },
	[70806340] = { aID=8712, aIndex=20, npc=72766 },
	[62357382] = { aID=8712, aIndex=21, npc=72777, tip=several }, -- Gulp Frog
	[63107850] = { aID=8712, aIndex=21, npc=72777, tip=several },
	[66007070] = { aID=8712, aIndex=21, npc=72777, tip=several },
	[65607400] = { aID=8712, aIndex=21, npc=72777, tip=several },
	[66406760] = { aID=8712, aIndex=21, npc=72777, tip=several },
	[66607640] = { aID=8712, aIndex=21, npc=72777 },
	[70207040] = { aID=8712, aIndex=21, npc=72777 },
	[26204620] = { aID=8712, aIndex=22, npc=72841 }, -- Death Adder
	[26806940] = { aID=8712, aIndex=22, npc=72841 },
	[28006160] = { aID=8712, aIndex=22, npc=72841, tip=several },
	[29004360] = { aID=8712, aIndex=22, npc=72841 },
	[29006460] = { aID=8712, aIndex=22, npc=72841, tip=several },
	[29607360] = { aID=8712, aIndex=22, npc=72841, tip=several },
	[30803680] = { aID=8712, aIndex=22, npc=72841 },
	[31007640] = { aID=8712, aIndex=22, npc=72841 },
	[33804660] = { aID=8712, aIndex=22, npc=72841 },
	[33807460] = { aID=8712, aIndex=22, npc=72841 },
	[36607460] = { aID=8712, aIndex=22, npc=72841 },
	[44606560] = { aID=8712, aIndex=22, npc=72841 },
	[50604680] = { aID=8712, aIndex=22, npc=72841 },
	[53005780] = { aID=8712, aIndex=22, npc=72841 },
	[51007660] = { aID=8712, aIndex=23, npc=72894 }, -- Ordon Fire Watcher
	[51608360] = { aID=8712, aIndex=23, npc=72894, tip=several },
	[52408200] = { aID=8712, aIndex=23, npc=72894, tip=several },
	[52607560] = { aID=8712, aIndex=23, npc=72894, tip=several },
	[52608000] = { aID=8712, aIndex=23, npc=72894, tip=several },
	[52008280] = { aID=8712, aIndex=23, npc=72894, tip=several },
	[54207360] = { aID=8712, aIndex=23, npc=72894, tip=several },
	[54207640] = { aID=8712, aIndex=23, npc=72894, tip=several },
	[54607860] = { aID=8712, aIndex=23, npc=72894, tip=several },
	[54608300] = { aID=8712, aIndex=23, npc=72894, tip=several },
	[56208060] = { aID=8712, aIndex=23, npc=72894, tip=several },
	[56607520] = { aID=8712, aIndex=23, npc=72894, tip=several },
	[56607860] = { aID=8712, aIndex=23, npc=72894, tip=several },
	[57008240] = { aID=8712, aIndex=23, npc=72894, tip=several },
	[57807760] = { aID=8712, aIndex=23, npc=72894, tip=several },
	[58607900] = { aID=8712, aIndex=23, npc=72894, tip=several },
	[59607580] = { aID=8712, aIndex=23, npc=72894, tip=several },
	[49407840] = { aID=8712, aIndex=24, npc=72892, tip=several }, -- Ordon Oathguard
	[50807680] = { aID=8712, aIndex=24, npc=72892, tip=several },
	[51608380] = { aID=8712, aIndex=24, npc=72892, tip=several },
	[52207560] = { aID=8712, aIndex=24, npc=72892, tip=several },
	[54007520] = { aID=8712, aIndex=24, npc=72892, tip=several },
	[54808040] = { aID=8712, aIndex=24, npc=72892, tip=several },
	[55007380] = { aID=8712, aIndex=24, npc=72892, tip=several },
	[56408240] = { aID=8712, aIndex=24, npc=72892, tip=several },
	[57007360] = { aID=8712, aIndex=24, npc=72892, tip=several },
	[58008120] = { aID=8712, aIndex=24, npc=72892 },
	[58207600] = { aID=8712, aIndex=24, npc=72892, tip=several },
	[58607120] = { aID=8712, aIndex=24, npc=72892, tip=several },
	[59608160] = { aID=8712, aIndex=24, npc=72892, tip=several },
	[58407140] = { aID=8712, aIndex=25, npc=72895, tip=several }, -- Burning Berserker
	[59605260] = { aID=8712, aIndex=25, npc=72895, tip=several },
	[60006980] = { aID=8712, aIndex=25, npc=72895, tip=several },
	[60404920] = { aID=8712, aIndex=25, npc=72895, tip=several },
	[61204760] = { aID=8712, aIndex=25, npc=72895, tip=several },
	[61406840] = { aID=8712, aIndex=25, npc=72895, tip=several },
	[63403960] = { aID=8712, aIndex=25, npc=72895, tip=several },
	[63803960] = { aID=8712, aIndex=25, npc=72895, tip=several },
	[63406520] = { aID=8712, aIndex=25, npc=72895, tip=several },
	[64806180] = { aID=8712, aIndex=25, npc=72895, tip=several },
	[65604040] = { aID=8712, aIndex=25, npc=72895, tip=several },
	[65606000] = { aID=8712, aIndex=25, npc=72895, tip=several },
	[66603660] = { aID=8712, aIndex=25, npc=72895, tip=several },
	[67403420] = { aID=8712, aIndex=25, npc=72895, tip=several },
	[67805560] = { aID=8712, aIndex=25, npc=72895, tip=several },
	[68604060] = { aID=8712, aIndex=25, npc=72895, tip=several },
	[69003640] = { aID=8712, aIndex=25, npc=72895, tip=several },
	[69004660] = { aID=8712, aIndex=25, npc=72895, tip=several },
	[69204840] = { aID=8712, aIndex=25, npc=72895, tip=several },
	[69603240] = { aID=8712, aIndex=25, npc=72895, tip=several },
	[69605860] = { aID=8712, aIndex=25, npc=72895, tip=several },
	[69803500] = { aID=8712, aIndex=25, npc=72895, tip=several },
	[71403840] = { aID=8712, aIndex=25, npc=72895, tip=several },
	[71405740] = { aID=8712, aIndex=25, npc=72895, tip=several },
	[71604360] = { aID=8712, aIndex=25, npc=72895, tip=several },
	[72604680] = { aID=8712, aIndex=25, npc=72895, tip=several },
	[72605080] = { aID=8712, aIndex=25, npc=72895, tip=several },
	[72605400] = { aID=8712, aIndex=25, npc=72895, tip=several },
	[72804160] = { aID=8712, aIndex=25, npc=72895, tip=several },
	[73604980] = { aID=8712, aIndex=25, npc=72895, tip=several },
	[74005120] = { aID=8712, aIndex=25, npc=72895 },
	[32403160] = { aID=8712, aIndex=26, npc=72888 }, -- Molten Guardian
	[33002900] = { aID=8712, aIndex=26, npc=72888 },
	[33403460] = { aID=8712, aIndex=26, npc=72888 },
	[36003460] = { aID=8712, aIndex=26, npc=72888 },
	[36602900] = { aID=8712, aIndex=26, npc=72888 },
	[47002800] = { aID=8712, aIndex=26, npc=72888 },
	[47202580] = { aID=8712, aIndex=26, npc=72888 },
	[51203720] = { aID=8712, aIndex=26, npc=72888 },
	[52802620] = { aID=8712, aIndex=26, npc=72888 },
	[52803780] = { aID=8712, aIndex=26, npc=72888 },
	[54602700] = { aID=8712, aIndex=26, npc=72888 },
	[56605760] = { aID=8712, aIndex=26, npc=72888 },
	[55406160] = { aID=8712, aIndex=27, npc=72876 }, -- Crimsonscale Firestorm
	[57206100] = { aID=8712, aIndex=27, npc=72876, tip=several },
	[57805880] = { aID=8712, aIndex=27, npc=72876, tip=several },
	[58605620] = { aID=8712, aIndex=27, npc=72876, tip=several },
	[62005740] = { aID=8712, aIndex=27, npc=72876 },
	[62604460] = { aID=8712, aIndex=27, npc=72876, tip=several },
	[63003340] = { aID=8712, aIndex=27, npc=72876, tip=several },
	[64003480] = { aID=8712, aIndex=27, npc=72876 },
	[63804460] = { aID=8712, aIndex=27, npc=72876 },
	[65603500] = { aID=8712, aIndex=27, npc=72876 },
	[65804040] = { aID=8712, aIndex=27, npc=72876 },
	[66005700] = { aID=8712, aIndex=27, npc=72876, tip=several },
	[66604420] = { aID=8712, aIndex=27, npc=72876, tip=several },
	[68005540] = { aID=8712, aIndex=27, npc=72876, tip=several },
	[68203720] = { aID=8712, aIndex=27, npc=72876 },
	[68404360] = { aID=8712, aIndex=27, npc=72876 },
	[68405840] = { aID=8712, aIndex=27, npc=72876 },
	[68805380] = { aID=8712, aIndex=27, npc=72876 },
	[69803660] = { aID=8712, aIndex=27, npc=72876 },
	[70405940] = { aID=8712, aIndex=27, npc=72876, tip=several },
	[71205060] = { aID=8712, aIndex=27, npc=72876 },
	[71205280] = { aID=8712, aIndex=27, npc=72876 },
	[71805840] = { aID=8712, aIndex=27, npc=72876 },
	[72003940] = { aID=8712, aIndex=27, npc=72876, tip=several },
	[72405400] = { aID=8712, aIndex=27, npc=72876, tip=several },
	[72804200] = { aID=8712, aIndex=27, npc=72876, tip=several },
	[72804960] = { aID=8712, aIndex=27, npc=72876, tip=several },
	[74004420] = { aID=8712, aIndex=27, npc=72876, tip=several },
	[16403580] = { aID=8712, aIndex=28, npc=72765, tip=several }, -- Elder Great Turtle
	[17603720] = { aID=8712, aIndex=28, npc=72765, tip=several },
	[17804600] = { aID=8712, aIndex=28, npc=72765, tip=several },
	[18803900] = { aID=8712, aIndex=28, npc=72765, tip=several },
	[18806240] = { aID=8712, aIndex=28, npc=72765, tip=several },
	[19203100] = { aID=8712, aIndex=28, npc=72765, tip=several },
	[19605400] = { aID=8712, aIndex=28, npc=72765, tip=several },
	[19606500] = { aID=8712, aIndex=28, npc=72765, tip=several },
	[19805480] = { aID=8712, aIndex=28, npc=72765, tip=several },
	[20006360] = { aID=8712, aIndex=28, npc=72765, tip=several },
	[20206580] = { aID=8712, aIndex=28, npc=72765, tip=several },
	[21005480] = { aID=8712, aIndex=28, npc=72765, tip=several },
	[52605640] = { aID=8712, aIndex=29, npc=72809, tip=several }, -- Eroded Cliffdweller
	[53805500] = { aID=8712, aIndex=29, npc=72809, tip=several },
	[55606780] = { aID=8712, aIndex=29, npc=72809, tip=several },
	[55805360] = { aID=8712, aIndex=29, npc=72809, tip=several },
	[56204560] = { aID=8712, aIndex=29, npc=72809, tip=several },
	[56604680] = { aID=8712, aIndex=29, npc=72809, tip=several },
	[56804860] = { aID=8712, aIndex=29, npc=72809, tip=several },
	[56805040] = { aID=8712, aIndex=29, npc=72809, tip=several },
	[56806780] = { aID=8712, aIndex=29, npc=72809, tip=several },
	[57806840] = { aID=8712, aIndex=29, npc=72809, tip=several },
	[58606580] = { aID=8712, aIndex=29, npc=72809, tip=several },
	[59605320] = { aID=8712, aIndex=29, npc=72809, tip=several },
	[60806360] = { aID=8712, aIndex=29, npc=72809, tip=several },
	[62005520] = { aID=8712, aIndex=29, npc=72809, tip=several },
	[62605740] = { aID=8712, aIndex=29, npc=72809, tip=several },
	[62605900] = { aID=8712, aIndex=29, npc=72809, tip=several },
	[62606040] = { aID=8712, aIndex=29, npc=72809, tip=several },
	[63606180] = { aID=8712, aIndex=29, npc=72809, tip=several },
	[63606320] = { aID=8712, aIndex=29, npc=72809, tip=several },
	[34003040] = { aID=8712, aIndex=30, npc=72897, tip=several }, -- Blazebound Chanter
	[33403380] = { aID=8712, aIndex=30, npc=72897, tip=several },
	[36603180] = { aID=8712, aIndex=30, npc=72897, tip=several },
	[39802660] = { aID=8712, aIndex=30, npc=72897, tip=several },
	[43603380] = { aID=8712, aIndex=30, npc=72897, tip=several },
	[43802560] = { aID=8712, aIndex=30, npc=72897, tip=several },
	[44403060] = { aID=8712, aIndex=30, npc=72897 },
	[45602260] = { aID=8712, aIndex=30, npc=72897, tip=several },
	[46003620] = { aID=8712, aIndex=30, npc=72897 },
	[46802920] = { aID=8712, aIndex=30, npc=72897, tip=several },
	[47002680] = { aID=8712, aIndex=30, npc=72897 },
	[47402340] = { aID=8712, aIndex=30, npc=72897 },
	[48603660] = { aID=8712, aIndex=30, npc=72897, tip=several },
	[48604160] = { aID=8712, aIndex=30, npc=72897, tip=several },
	[48803060] = { aID=8712, aIndex=30, npc=72897 },
	[49402780] = { aID=8712, aIndex=30, npc=72897, tip=several },
	[50803160] = { aID=8712, aIndex=30, npc=72897, tip=several },
	[51802660] = { aID=8712, aIndex=30, npc=72897, tip=several },
	[53203060] = { aID=8712, aIndex=30, npc=72897, tip=several },
	[54806040] = { aID=8712, aIndex=30, npc=72897, tip=several },
	[55603380] = { aID=8712, aIndex=30, npc=72897, tip=several },
	[55802780] = { aID=8712, aIndex=30, npc=72897, tip=several },
	[57003160] = { aID=8712, aIndex=30, npc=72897, tip=several },
	[57402860] = { aID=8712, aIndex=30, npc=72897, tip=several },
	[57806160] = { aID=8712, aIndex=30, npc=72897, tip=several },
	[65803440] = { aID=8712, aIndex=30, npc=72897, tip=several },
	[67203380] = { aID=8712, aIndex=30, npc=72897, tip=several },
	[67603580] = { aID=8712, aIndex=30, npc=72897, tip=several },
	[69003340] = { aID=8712, aIndex=30, npc=72897, tip=several },
	[69003500] = { aID=8712, aIndex=30, npc=72897, tip=several },
	[69603460] = { aID=8712, aIndex=30, npc=72897, tip=several },
	[33403400] = { aID=8712, aIndex=31, npc=72896, tip=several }, -- Eternal Kilnmaster
	[34402940] = { aID=8712, aIndex=31, npc=72896, tip=several },
	[35003540] = { aID=8712, aIndex=31, npc=72896, tip=several },
	[35803540] = { aID=8712, aIndex=31, npc=72896, tip=several },
	[36603120] = { aID=8712, aIndex=31, npc=72896, tip=several },
	[40603080] = { aID=8712, aIndex=31, npc=72896 },
	[40802560] = { aID=8712, aIndex=31, npc=72896, tip=several },
	[41602880] = { aID=8712, aIndex=31, npc=72896, tip=several },
	[42603160] = { aID=8712, aIndex=31, npc=72896, tip=several },
	[43803380] = { aID=8712, aIndex=31, npc=72896, tip=several },
	[44203100] = { aID=8712, aIndex=31, npc=72896 },
	[44802840] = { aID=8712, aIndex=31, npc=72896, tip=several },
	[45602260] = { aID=8712, aIndex=31, npc=72896, tip=several },
	[45802260] = { aID=8712, aIndex=31, npc=72896 },
	[47203660] = { aID=8712, aIndex=31, npc=72896, tip=several },
	[47402360] = { aID=8712, aIndex=31, npc=72896, tip=several },
	[49003860] = { aID=8712, aIndex=31, npc=72896, tip=several },
	[49602540] = { aID=8712, aIndex=31, npc=72896, tip=several },
	[50803160] = { aID=8712, aIndex=31, npc=72896, tip=several },
	[51802360] = { aID=8712, aIndex=31, npc=72896, tip=several },
	[51802660] = { aID=8712, aIndex=31, npc=72896, tip=several },
	[53203060] = { aID=8712, aIndex=31, npc=72896, tip=several },
	[55203340] = { aID=8712, aIndex=31, npc=72896, tip=several },
	[55402760] = { aID=8712, aIndex=31, npc=72896, tip=several },
	[55602440] = { aID=8712, aIndex=31, npc=72896, tip=several },
	[55802800] = { aID=8712, aIndex=31, npc=72896, tip=several },
	[56005960] = { aID=8712, aIndex=31, npc=72896, tip=several },
	[56603860] = { aID=8712, aIndex=31, npc=72896, tip=several },
	[56806200] = { aID=8712, aIndex=31, npc=72896, tip=several },
	[57003360] = { aID=8712, aIndex=31, npc=72896, tip=several },
	[65803460] = { aID=8712, aIndex=31, npc=72896, tip=several },
	[67003360] = { aID=8712, aIndex=31, npc=72896 },
	[67603580] = { aID=8712, aIndex=31, npc=72896, tip=several },
	[69003420] = { aID=8712, aIndex=31, npc=72896, tip=several },
	[69803540] = { aID=8712, aIndex=31, npc=72896, tip=several },
	[34603100] = { aID=8712, aIndex=32, npc=72898, tip=several }, -- High Priest of Ordos
	[44602680] = { aID=8712, aIndex=32, npc=72898, tip=several },
	[49403300] = { aID=8712, aIndex=32, npc=72898, tip=several },
	[49603360] = { aID=8712, aIndex=32, npc=72898, tip=several },
	[50602360] = { aID=8712, aIndex=32, npc=72898, tip=several },
	[56603480] = { aID=8712, aIndex=32, npc=72898, tip=several },
	[57602700] = { aID=8712, aIndex=32, npc=72898, tip=several },
	
	-- Pilgrimage
	-- Four buffs to collect from 12 spawn points. The same shrine may be clicked multiple times.
	-- Core file has special code. Note: No aIndex here
	[22862923] = { aID=8724, obj=222776, item="Time-Lost Shrine", tip=timeLostShrine },
	[26765219] = { aID=8724, obj=222776, item="Time-Lost Shrine", tip=timeLostShrine },
	[28017199] = { aID=8724, obj=222776, item="Time-Lost Shrine", tip=timeLostShrine },
	[30134556] = { aID=8724, obj=222776, item="Time-Lost Shrine", tip=timeLostShrine },
	[30606257] = { aID=8724, obj=222776, item="Time-Lost Shrine", tip=timeLostShrine },
	[34982947] = { aID=8724, obj=222776, item="Time-Lost Shrine", tip=timeLostShrine },
	[37507420] = { aID=8724, obj=222776, item="Time-Lost Shrine", tip=timeLostShrine },
	[43485588] = { aID=8724, obj=222776, item="Time-Lost Shrine", tip=timeLostShrine },
	[49767024] = { aID=8724, obj=222776, item="Time-Lost Shrine", tip=timeLostShrine },
	[52976071] = { aID=8724, obj=222776, item="Time-Lost Shrine", tip=timeLostShrine },
	[58154655] = { aID=8724, obj=222776, item="Time-Lost Shrine", tip=timeLostShrine },
	[63965066] = { aID=8724, obj=222776, item="Time-Lost Shrine", tip=timeLostShrine },
	[66247223] = { aID=8724, obj=222776, item="Time-Lost Shrine", tip=timeLostShrine },
	
	-- Eyes on the Ground
	[16806250] = { aID=8725, aIndex=1, obj=223193, item="Giant Clam" },
	[18505380] = { aID=8725, aIndex=1, obj=223193, item="Giant Clam" },
	[18702030] = { aID=8725, aIndex=1, obj=223193, item="Giant Clam" },
	[25601440] = { aID=8725, aIndex=1, obj=223193, item="Giant Clam" },
	[29702180] = { aID=8725, aIndex=1, obj=223193, item="Giant Clam" },
	[47808790] = { aID=8725, aIndex=1, obj=223193, item="Giant Clam" },	
	[19703950] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[20205640] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[20503600] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[20506160] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[20407150] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[20605360] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[20706450] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[20903300] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[20906050] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[20907400] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[21104490] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[21106290] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[21504090] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[21504980] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[21803500] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[22103060] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[22706950] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[22905550] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[23006170] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[23207540] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[23303550] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[23502950] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[23503310] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[23503770] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[23504650] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[23605910] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[23705020] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[24406770] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[25007480] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[25505520] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[25606000] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[25907060] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[26605180] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[26702850] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[27107550] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[28208060] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[28603060] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[28808430] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[29602910] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[30703050] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[31708480] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[33702260] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[34108720] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[36502050] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip="Furthest reported occurence" },
	[36508750] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[38609190] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[39209080] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[40509210] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[45308970] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[52508680] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[55508800] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=several },
	[55508800] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[60208840] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[61808360] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[62708030] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[64807750] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=several },
	[65607800] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=several },
	[65707650] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=several },
	[67107860] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[68207450] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=glintingSand },
	[70206720] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=several },
	[70507700] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand",
					tip="Best location for farming Glinting Sand.\n"
						.."Dive down and enter the cave here.\n"
						.."You're welcome!" },
	[71106280] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip="Furthest reported occurence" },
	[71507300] = { aID=8725, aIndex=2, obj=222684, item="Glinting Sand", tip=several },
	[29406720] = { aID=8725, aIndex=3, obj=222685, item="Crane Nest" },
	[29605250] = { aID=8725, aIndex=3, obj=222685, item="Crane Nest" },
	[29826059] = { aID=8725, aIndex=3, obj=222685, item="Crane Nest" },
	[30473905] = { aID=8725, aIndex=3, obj=222685, item="Crane Nest" },
	[30654129] = { aID=8725, aIndex=3, obj=222685, item="Crane Nest" },
	[31485001] = { aID=8725, aIndex=3, obj=222685, item="Crane Nest" },
	[31507880] = { aID=8725, aIndex=3, obj=222685, item="Crane Nest" },
	[31556470] = { aID=8725, aIndex=3, obj=222685, item="Crane Nest" },
	[32666943] = { aID=8725, aIndex=3, obj=222685, item="Crane Nest" },
	[32805280] = { aID=8725, aIndex=3, obj=222685, item="Crane Nest" },
	[33208050] = { aID=8725, aIndex=3, obj=222685, item="Crane Nest" },
	[33216601] = { aID=8725, aIndex=3, obj=222685, item="Crane Nest" },
	[34008160] = { aID=8725, aIndex=3, obj=222685, item="Crane Nest" },
	[36508250] = { aID=8725, aIndex=3, obj=222685, item="Crane Nest" },
	[39994112] = { aID=8725, aIndex=3, obj=222685, item="Crane Nest" },
	[41506960] = { aID=8725, aIndex=3, obj=222685, item="Crane Nest" },
	[42574497] = { aID=8725, aIndex=3, obj=222685, item="Crane Nest" },
	[43206850] = { aID=8725, aIndex=3, obj=222685, item="Crane Nest" },
	[43306600] = { aID=8725, aIndex=3, obj=222685, item="Crane Nest" },
	[44776241] = { aID=8725, aIndex=3, obj=222685, item="Crane Nest" },
	[48908250] = { aID=8725, aIndex=5, obj=222687, item="Ordon Supplies" },
	[50108190] = { aID=8725, aIndex=5, obj=222687, item="Ordon Supplies", tip=several },
	[50508450] = { aID=8725, aIndex=5, obj=222687, item="Ordon Supplies", tip=several },
	[50508450] = { aID=8725, aIndex=5, obj=222687, item="Ordon Supplies", tip=several },
	[51608290] = { aID=8725, aIndex=5, obj=222687, item="Ordon Supplies", tip=several },
	[51508050] = { aID=8725, aIndex=5, obj=222687, item="Ordon Supplies" },
	[51507620] = { aID=8725, aIndex=5, obj=222687, item="Ordon Supplies", tip=several },
	[53108300] = { aID=8725, aIndex=5, obj=222687, item="Ordon Supplies", tip=several },
	[53207430] = { aID=8725, aIndex=5, obj=222687, item="Ordon Supplies", tip=several },
	[53207850] = { aID=8725, aIndex=5, obj=222687, item="Ordon Supplies" },
	[54308150] = { aID=8725, aIndex=5, obj=222687, item="Ordon Supplies", tip=several },
	[54508420] = { aID=8725, aIndex=5, obj=222687, item="Ordon Supplies" },
	[54707300] = { aID=8725, aIndex=5, obj=222687, item="Ordon Supplies", tip=several },
	[55107770] = { aID=8725, aIndex=5, obj=222687, item="Ordon Supplies", tip=several },
	[55507050] = { aID=8725, aIndex=5, obj=222687, item="Ordon Supplies" },
	[56508050] = { aID=8725, aIndex=5, obj=222687, item="Ordon Supplies", tip=several },
	[56508370] = { aID=8725, aIndex=5, obj=222687, item="Ordon Supplies" },
	[56607850] = { aID=8725, aIndex=5, obj=222687, item="Ordon Supplies", tip=several },
	[57808490] = { aID=8725, aIndex=5, obj=222687, item="Ordon Supplies", tip=several },
	[57907550] = { aID=8725, aIndex=5, obj=222687, item="Ordon Supplies" },
	[58708350] = { aID=8725, aIndex=5, obj=222687, item="Ordon Supplies" },
	[59007850] = { aID=8725, aIndex=5, obj=222687, item="Ordon Supplies" },
	[59508250] = { aID=8725, aIndex=5, obj=222687, item="Ordon Supplies" },
	[59808010] = { aID=8725, aIndex=5, obj=222687, item="Ordon Supplies" },
	[66803600] = { aID=8725, aIndex=5, obj=222687, item="Ordon Supplies", tip=several },
	[67703280] = { aID=8725, aIndex=5, obj=222687, item="Ordon Supplies", tip=several },
	[68005960] = { aID=8725, aIndex=5, obj=222687, item="Ordon Supplies" },
	[69503180] = { aID=8725, aIndex=5, obj=222687, item="Ordon Supplies" },
	[69603420] = { aID=8725, aIndex=5, obj=222687, item="Ordon Supplies" },
	[70503560] = { aID=8725, aIndex=5, obj=222687, item="Ordon Supplies" },
	[43903740] = { aID=8725, aIndex=6, obj=222688, item="Firestorm Egg" },
	[55704070] = { aID=8725, aIndex=6, obj=222688, item="Firestorm Egg" },
	[59003700] = { aID=8725, aIndex=6, obj=222688, item="Firestorm Egg" },
	[59004990] = { aID=8725, aIndex=6, obj=222688, item="Firestorm Egg" },
	[59204170] = { aID=8725, aIndex=6, obj=222688, item="Firestorm Egg" },
	[59502600] = { aID=8725, aIndex=6, obj=222688, item="Firestorm Egg" },
	[60105960] = { aID=8725, aIndex=6, obj=222688, item="Firestorm Egg" },
	[61703520] = { aID=8725, aIndex=6, obj=222688, item="Firestorm Egg" },
	[61904030] = { aID=8725, aIndex=6, obj=222688, item="Firestorm Egg" },
	[62904990] = { aID=8725, aIndex=6, obj=222688, item="Firestorm Egg" },
	[63603250] = { aID=8725, aIndex=6, obj=222688, item="Firestorm Egg" },
	[66905300] = { aID=8725, aIndex=6, obj=222688, item="Firestorm Egg" },
	[67506350] = { aID=8725, aIndex=6, obj=222688, item="Firestorm Egg" },
	[72205960] = { aID=8725, aIndex=6, obj=222688, item="Firestorm Egg" },
	[72505630] = { aID=8725, aIndex=6, obj=222688, item="Firestorm Egg" },
	[74803750] = { aID=8725, aIndex=6, obj=222688, item="Firestorm Egg" },
	[76503690] = { aID=8725, aIndex=6, obj=222688, item="Firestorm Egg" },
	[40102660] = { aID=8725, aIndex=7, obj=222689, item="Fiery Altar of Ordos" },
	[42703450] = { aID=8725, aIndex=7, obj=222689, item="Fiery Altar of Ordos" },
	[44502970] = { aID=8725, aIndex=7, obj=222689, item="Fiery Altar of Ordos" },
	[45502350] = { aID=8725, aIndex=7, obj=222689, item="Fiery Altar of Ordos" },
	[48503950] = { aID=8725, aIndex=7, obj=222689, item="Fiery Altar of Ordos" },
	[49602740] = { aID=8725, aIndex=7, obj=222689, item="Fiery Altar of Ordos" },
	[51003150] = { aID=8725, aIndex=7, obj=222689, item="Fiery Altar of Ordos" },
	[51502650] = { aID=8725, aIndex=7, obj=222689, item="Fiery Altar of Ordos" },
	[53102550] = { aID=8725, aIndex=7, obj=222689, item="Fiery Altar of Ordos" },
	[55503340] = { aID=8725, aIndex=7, obj=222689, item="Fiery Altar of Ordos" },
	[55602790] = { aID=8725, aIndex=7, obj=222689, item="Fiery Altar of Ordos" },
	[57303080] = { aID=8725, aIndex=7, obj=222689, item="Fiery Altar of Ordos" },
	[59503050] = { aID=8725, aIndex=7, obj=222689, item="Fiery Altar of Ordos" },
	[75504460] = { aID=8725, aIndex=7, obj=222689, item="Fiery Altar of Ordos" },
	
	-- Treasure, Treasure Everywhere
	[22104930] = { aID=8729, aIndex=1, aQuest=33175, item="Moss-Covered Chest" },
	[22256812] = { aID=8729, aIndex=1, aQuest=33178, item="Moss-Covered Chest" },
	[22403540] = { aID=8729, aIndex=1, aQuest=33174, item="Moss-Covered Chest" },
	[24703860] = { aID=8729, aIndex=1, aQuest=33200, item="Moss-Covered Chest", tip="In the tree trunk stump" },
	[24795304] = { aID=8729, aIndex=1, aQuest=33176, item="Moss-Covered Chest" },
	[25492719] = { aID=8729, aIndex=1, aQuest=33171, item="Moss-Covered Chest" },
	[25684582] = { aID=8729, aIndex=1, aQuest=33177, item="Moss-Covered Chest" },
	[26006140] = { aID=8729, aIndex=1, aQuest=33199, item="Moss-Covered Chest" },
	[26806490] = { aID=8729, aIndex=4, aQuest=33205, item="Sturdy Chest" },
	[26846875] = { aID=8729, aIndex=1, aQuest=33179, item="Moss-Covered Chest" },
	[27353907] = { aID=8729, aIndex=1, aQuest=33172, item="Moss-Covered Chest" },
	[28203520] = { aID=8729, aIndex=4, aQuest=33204, item="Sturdy Chest" },
	[29763173] = { aID=8729, aIndex=1, aQuest=33202, item="Moss-Covered Chest" },
	[30673656] = { aID=8729, aIndex=1, aQuest=33173, item="Moss-Covered Chest", tip="In the tree trunk stump" },
	[31007630] = { aID=8729, aIndex=1, aQuest=33180, item="Moss-Covered Chest" },
	[34808420] = { aID=8729, aIndex=1, aQuest=33184, item="Moss-Covered Chest" },
	[35307640] = { aID=8729, aIndex=1, aQuest=33181, item="Moss-Covered Chest" },
	[36713408] = { aID=8729, aIndex=1, aQuest=33170, item="Moss-Covered Chest", tip="In the shrubbery" },
	[38707160] = { aID=8729, aIndex=1, aQuest=33182, item="Moss-Covered Chest" },
	[39807950] = { aID=8729, aIndex=1, aQuest=33183, item="Moss-Covered Chest" },
	[43608410] = { aID=8729, aIndex=1, aQuest=33185, item="Moss-Covered Chest" },
	[44206530] = { aID=8729, aIndex=1, aQuest=33198, item="Moss-Covered Chest" },
	[46703230] = { aID=8729, aIndex=2, aQuest=33203, item="Skull-Covered Chest" },
	[46704674] = { aID=8729, aIndex=1, aQuest=33187, item="Moss-Covered Chest" },
	[46975370] = { aID=8729, aIndex=1, aQuest=33186, item="Moss-Covered Chest", tip="Submerged" },
	[47602760] = { aID=8729, aIndex=3, aQuest=33210, item="Blazing Chest" },
	[49706570] = { aID=8729, aIndex=1, aQuest=33195, item="Moss-Covered Chest" },
	[51164568] = { aID=8729, aIndex=1, aQuest=33188, item="Moss-Covered Chest" },
	[52706270] = { aID=8729, aIndex=1, aQuest=33197, item="Moss-Covered Chest" },
	[53107082] = { aID=8729, aIndex=1, aQuest=33196, item="Moss-Covered Chest" },
	[54007820] = { aID=8729, aIndex=5, aQuest=33209, item="Smoldering Chest" },
	[55554429] = { aID=8729, aIndex=1, aQuest=33189, item="Moss-Covered Chest" },
	[58025068] = { aID=8729, aIndex=1, aQuest=33190, item="Moss-Covered Chest" },
	[59184954] = { aID=8729, aIndex=4, aQuest=33207, tip="Inside the Mysterious Den. "
					.."Use a cushion toy to get in", item="Sturdy Chest" },
	[59903130] = { aID=8729, aIndex=1, aQuest=33201, item="Moss-Covered Chest" },
	[60206600] = { aID=8729, aIndex=1, aQuest=33194, item="Moss-Covered Chest" },
	[61708850] = { aID=8729, aIndex=1, aQuest=33227, item="Moss-Covered Chest" },
	[63805916] = { aID=8729, aIndex=1, aQuest=33192, item="Moss-Covered Chest" },
	[64597041] = { aID=8729, aIndex=4, aQuest=33206, tip="Inside the Croaking Hollow", item="Sturdy Chest" },
	[64917557] = { aID=8729, aIndex=1, aQuest=33193, tip="Behind the lion statue", item="Moss-Covered Chest" },
	[65704780] = { aID=8729, aIndex=1, aQuest=33191, item="Moss-Covered Chest" },
	[69503290] = { aID=8729, aIndex=5, aQuest=33208, item="Smoldering Chest" },

	-- Rolo's Riddle
	[49376943] = { aID=8730, aQuest=32974, item="First clue", tip="The first clue is here" },
	[34402580] = { aID=8730, aQuest=32975, item="Second clue", tip="The second clue is here" },
	[65602330] = { aID=8730, aQuest=32976, item="Third clue", tip="The third clue is here" },
	
	-- Repeatables
	-- Celestial Challenge
	[35504820] = { aID=8535, aIndex=1, aQuest=33117 }, -- Chi-Ji <The Red Crane>
	[42404840] = { aID=8535, aIndex=2, aQuest=33117 }, -- Niuzao <The Black Ox>
	[35706270] = { aID=8535, aIndex=3, aQuest=33117 }, -- Xuen <The White Tiger>
	[42506220] = { aID=8535, aIndex=4, aQuest=33117 }, -- Yu'lon <The Jade Serpent>
	-- Extreme Treasure Hunter
	[49706940] = { aID=8726, aIndex=1, aQuest=32969, obj=220901, }, -- Gleaming Treasure Chest
	[51507470] = { aID=8726, aIndex=1, aQuest=32969, obj=220901, tip="Start here and hop to the pillars" },
					-- Gleaming Treasure Chest
	[53904720] = { aID=8726, aIndex=2, aQuest=32968, obj=220902, }, -- Rope-Bound Treasure Chest
	[60204630] = { aID=8726, aIndex=2, aQuest=32968, obj=220902, tip="Start here and jump from rope to rope" },
					-- Rope-Bound Treasure Chest
	[58706010] = { aID=8726, aIndex=3, aQuest=32971, obj=220908, -- Mist-Covered Treasure Chest
					tip="Click on the Gleaming Crane Statue.\n\n"
					.."You'll get launched up into the sky.\n"
					.."Click on one of the floating \"mist\n"
					.."covered\" chests as you slow-fall" },
	-- Where There's Pirates, There's Booty
	[17205730] = { aID=8727, aIndex=2, aQuest=32956, obj=220986, }, -- Blackguard's Jetsam
	[40009220] = { aID=8727, aIndex=1, aQuest=32957, obj=220832, }, -- Sunken Hozen Treasure
	[71308000] = { aID=8727, aIndex=3, aQuest=32970, obj=221036, }, -- Gleaming Treasure Satchel
	-- Zarhym Altogether	
	[43004160] = { aID=8743, aQuest=32962, tip="Enter the Cavern of Lost Spirits here" },
	[53205630] = { aID=8743, aQuest=32962, tip="Start by talking to Zarhym" },
	[53403150] = { aID=8743, aQuest=32962, tip="Click the pile of bones" },

	-- Timeless Legends
	-- 19 locations could spawn one of four objects. Objects may be clicked multiple times.
	-- Core file has special code. Note: No aIndex here
	[22403870] = { aID=8784, tip=legends },
	[24977188] = { aID=8784, tip=legends },
	[32006150] = { aID=8784, tip=legends },
	[32603280] = { aID=8784, tip=legends },
	[33805450] = { aID=8784, tip=legends },
	[37694108] = { aID=8784, tip=legends },
	[39607780] = { aID=8784, tip=legends },
	[42805540] = { aID=8784, tip=legends },
	[47308080] = { aID=8784, tip=legends },
	[48005120] = { aID=8784, tip=legends },
	[50407170] = { aID=8784, tip=legends },
	[52206260] = { aID=8784, tip=legends },
	[55107290] = { aID=8784, tip=legends },
	[55305030] = { aID=8784, tip=legends },
	[55605930] = { aID=8784, tip=legends },
	[63104530] = { aID=8784, tip=legends },
	[64507230] = { aID=8784, tip=legends },
	[65405170] = { aID=8784, tip=legends },
	[68406040] = { aID=8784, tip=legends },
	
	-- Timeless Champion
	[30804520] = { aID=8714, aIndex=1, npc=73158, tip=emeraldGander }, -- Emerald Gander
	[30805060] = { aID=8714, aIndex=1, npc=73158, tip=emeraldGander }, -- Emerald Gander
	[31206660] = { aID=8714, aIndex=1, npc=73158, tip=emeraldGander }, -- Emerald Gander
	[31606265] = { aID=8714, aIndex=1, npc=73158, tip=emeraldGander }, -- Emerald Gander
	[40604380] = { aID=8714, aIndex=1, npc=73158, tip=emeraldGander }, -- Emerald Gander
	[41004060] = { aID=8714, aIndex=1, npc=73158, tip=emeraldGander }, -- Emerald Gander
	[42807000] = { aID=8714, aIndex=1, npc=73158, tip=emeraldGander }, -- Emerald Gander
	[44805380] = { aID=8714, aIndex=1, npc=73158, tip=emeraldGander }, -- Emerald Gander
	[29455935] = { aID=8714, aIndex=2, npc=73160, tip=ironfur }, -- Ironfur Steelhorn
	[30807080] = { aID=8714, aIndex=2, npc=73160, tip=ironfur }, -- Ironfur Steelhorn
	[32605800] = { aID=8714, aIndex=2, npc=73160, tip=ironfur }, -- Ironfur Steelhorn
	[35204180] = { aID=8714, aIndex=2, npc=73160, -- Ironfur Steelhorn
					tip="Check the north side of the map \"rectangle\" only occasionally" },
	[35806620] = { aID=8714, aIndex=2, npc=73160, -- Ironfur Steelhorn
					tip="Stay on the western side of the map \"rectangle\"" },
	[44604380] = { aID=8714, aIndex=2, npc=73160, -- Ironfur Steelhorn
					tip="You'll have no luck farming the eastern side of the rectangle" },
	[20604320] = { aID=8714, aIndex=3, npc=73161, tip=greatTurtle }, -- Great Turtle Furyshell
	[22004260] = { aID=8714, aIndex=3, npc=73161, tip="The northern spawn limit" }, -- Great Turtle Furyshell
	[22206140] = { aID=8714, aIndex=3, npc=73161, tip=greatTurtle }, -- Great Turtle Furyshell
	[22404580] = { aID=8714, aIndex=3, npc=73161, tip=greatTurtle }, -- Great Turtle Furyshell
	[22355352] = { aID=8714, aIndex=3, npc=73161, tip=greatTurtle }, -- Great Turtle Furyshell
	[22606680] = { aID=8714, aIndex=3, npc=73161, tip=greatTurtle }, -- Great Turtle Furyshell
	[22606680] = { aID=8714, aIndex=3, npc=73161, tip=greatTurtle }, -- Great Turtle Furyshell
	[23604980] = { aID=8714, aIndex=3, npc=73161, tip=greatTurtle }, -- Great Turtle Furyshell
	[25405280] = { aID=8714, aIndex=3, npc=73161, tip=greatTurtle }, -- Great Turtle Furyshell
	[26607240] = { aID=8714, aIndex=3, npc=73161, tip="The southern spawn limit" }, -- Great Turtle Furyshell
	[30207100] = { aID=8714, aIndex=4, npc=72909 }, -- Gu'chi the Swarmbringer
	[30207280] = { aID=8714, aIndex=4, npc=72909 }, -- Gu'chi the Swarmbringer
	[31207060] = { aID=8714, aIndex=4, npc=72909 }, -- Gu'chi the Swarmbringer
	[31607460] = { aID=8714, aIndex=4, npc=72909 }, -- Gu'chi the Swarmbringer
	[32607740] = { aID=8714, aIndex=4, npc=72909 }, -- Gu'chi the Swarmbringer
	[34407020] = { aID=8714, aIndex=4, npc=72909 }, -- Gu'chi the Swarmbringer
	[34407980] = { aID=8714, aIndex=4, npc=72909 }, -- Gu'chi the Swarmbringer
	[37008150] = { aID=8714, aIndex=4, npc=72909 }, -- Gu'chi the Swarmbringer
	[37207000] = { aID=8714, aIndex=4, npc=72909 }, -- Gu'chi the Swarmbringer
	[38608220] = { aID=8714, aIndex=4, npc=72909 }, -- Gu'chi the Swarmbringer
	[39406980] = { aID=8714, aIndex=4, npc=72909 }, -- Gu'chi the Swarmbringer
	[40208280] = { aID=8714, aIndex=4, npc=72909 }, -- Gu'chi the Swarmbringer
	[40608060] = { aID=8714, aIndex=4, npc=72909 }, -- Gu'chi the Swarmbringer
	[41407100] = { aID=8714, aIndex=4, npc=72909 }, -- Gu'chi the Swarmbringer
	[42007300] = { aID=8714, aIndex=4, npc=72909 }, -- Gu'chi the Swarmbringer
	[42207400] = { aID=8714, aIndex=4, npc=72909 }, -- Gu'chi the Swarmbringer
	[42207600] = { aID=8714, aIndex=4, npc=72909 }, -- Gu'chi the Swarmbringer
	[47238804] = { aID=8714, aIndex=5, npc=72245 }, -- Zesqua
	[37607760] = { aID=8714, aIndex=6, npc=71919 }, -- Zhu-Gon the Sour
	[33808520] = { aID=8714, aIndex=7, npc=72193 }, -- Karkanos
	[25223582] = { aID=8714, aIndex=8, npc=72045 }, -- Chelon
	[59094885] = { aID=8714, aIndex=9, npc=71864, -- Spelurk
					tip="Use a toy cushion or similar. Place it inside the cave. Sit. Stand up.\n"
					.."Then break the \"cave-in\" with the hammer. Spelurk then spawns" },
	[43807000] = { aID=8714, aIndex=10, npc=73854, -- Cranegnasher
					tip="Kite some cranes to here. This will force Cranegnasher to de-cloak" },
	[60208740] = { aID=8714, aIndex=11, npc=72048 }, -- Rattleskew
	[43304080] = { aID=8714, aIndex=12, npc=72769, -- Spirit of Jadefire
					tip="Enter the Cavern then check your world map" },
	[67204400] = { aID=8714, aIndex=13, npc=73277 }, -- Leafmender
	[62207680] = { aID=8714, aIndex=14, npc=72775, tip="Southern spawn limit" }, -- Bufo
	[63607260] = { aID=8714, aIndex=14, npc=72775 }, -- Bufo
	[64807460] = { aID=8714, aIndex=14, npc=72775, -- Bufo
					tip="You don't need to kill frogs to make Bufo spawn" }, 
	[65606980] = { aID=8714, aIndex=14, npc=72775 }, -- Bufo
	[66606540] = { aID=8714, aIndex=14, npc=72775, tip="Northern spawn limit" }, -- Bufo
	[63203000] = { aID=8714, aIndex=15, npc=73282 }, -- Garnia
	[64002720] = { aID=8714, aIndex=15, npc=73282 }, -- Garnia
	[64302890] = { aID=8714, aIndex=15, npc=73282 }, -- Garnia
	[65002740] = { aID=8714, aIndex=15, npc=73282 }, -- Garnia
	[54604430] = { aID=8714, aIndex=16, npc=72808, tip="Enter his den at the Red Stone Run" }, -- Tsavo'ka
	[18205860] = { aID=8714, aIndex=17, npc=73166, tip=ancientSpineclaw }, -- Monstrous Spineclaw
	[18206440] = { aID=8714, aIndex=17, npc=73166, tip=ancientSpineclaw }, -- Monstrous Spineclaw
	[19005500] = { aID=8714, aIndex=17, npc=73166, tip=ancientSpineclaw }, -- Monstrous Spineclaw
	[20604760] = { aID=8714, aIndex=17, npc=73166, tip=ancientSpineclaw }, -- Monstrous Spineclaw
	[21007160] = { aID=8714, aIndex=17, npc=73166, tip=ancientSpineclaw }, -- Monstrous Spineclaw
	[21206370] = { aID=8714, aIndex=17, npc=73166, tip=ancientSpineclaw }, -- Monstrous Spineclaw
	[21603260] = { aID=8714, aIndex=17, npc=73166, tip=ancientSpineclaw }, -- Monstrous Spineclaw
	[22003560] = { aID=8714, aIndex=17, npc=73166, tip=ancientSpineclaw }, -- Monstrous Spineclaw
	[23602840] = { aID=8714, aIndex=17, npc=73166, tip=ancientSpineclaw }, -- Monstrous Spineclaw
	[23803560] = { aID=8714, aIndex=17, npc=73166, tip=ancientSpineclaw }, -- Monstrous Spineclaw
	[25602460] = { aID=8714, aIndex=17, npc=73166, tip=ancientSpineclaw }, -- Monstrous Spineclaw
	[27807460] = { aID=8714, aIndex=17, npc=73166, tip=ancientSpineclaw }, -- Monstrous Spineclaw
	[28208150] = { aID=8714, aIndex=17, npc=73166, tip=ancientSpineclaw }, -- Monstrous Spineclaw
	[30603100] = { aID=8714, aIndex=17, npc=73166, tip=ancientSpineclaw }, -- Monstrous Spineclaw
	[35408700] = { aID=8714, aIndex=17, npc=73166, tip=ancientSpineclaw }, -- Monstrous Spineclaw
	[38008650] = { aID=8714, aIndex=17, npc=73166, tip=ancientSpineclaw }, -- Monstrous Spineclaw
	[40809080] = { aID=8714, aIndex=17, npc=73166, tip=ancientSpineclaw }, -- Monstrous Spineclaw
	[44808960] = { aID=8714, aIndex=17, npc=73166, tip=ancientSpineclaw }, -- Monstrous Spineclaw
	[52208660] = { aID=8714, aIndex=17, npc=73166, tip=ancientSpineclaw }, -- Monstrous Spineclaw
	[61608320] = { aID=8714, aIndex=17, npc=73166, tip=ancientSpineclaw }, -- Monstrous Spineclaw
	[63207980] = { aID=8714, aIndex=17, npc=73166, tip=ancientSpineclaw }, -- Monstrous Spineclaw
	[65607800] = { aID=8714, aIndex=17, npc=73166, tip=ancientSpineclaw }, -- Monstrous Spineclaw
	[67807820] = { aID=8714, aIndex=17, npc=73166, tip=ancientSpineclaw }, -- Monstrous Spineclaw
	[68807480] = { aID=8714, aIndex=17, npc=73166, tip=ancientSpineclaw }, -- Monstrous Spineclaw
	[26204620] = { aID=8714, aIndex=18, npc=73163, tip=deathAdder }, -- Imperial Python
	[26806940] = { aID=8714, aIndex=18, npc=73163, tip=deathAdder }, -- Imperial Python
	[27406140] = { aID=8714, aIndex=18, npc=73163, tip=deathAdder }, -- Imperial Python
	[29006460] = { aID=8714, aIndex=18, npc=73163, tip=deathAdder }, -- Imperial Python
	[29607360] = { aID=8714, aIndex=18, npc=73163, tip=deathAdder }, -- Imperial Python
	[30403680] = { aID=8714, aIndex=18, npc=73163, tip=deathAdder }, -- Imperial Python
	[31007640] = { aID=8714, aIndex=18, npc=73163, tip=deathAdder }, -- Imperial Python
	[33604560] = { aID=8714, aIndex=18, npc=73163, tip=deathAdder }, -- Imperial Python
	[33807460] = { aID=8714, aIndex=18, npc=73163, tip=deathAdder }, -- Imperial Python
	[36607460] = { aID=8714, aIndex=18, npc=73163, tip=deathAdder }, -- Imperial Python
	[44606560] = { aID=8714, aIndex=18, npc=73163, tip=deathAdder }, -- Imperial Python
	[50604680] = { aID=8714, aIndex=18, npc=73163, tip=deathAdder }, -- Imperial Python
	[53005780] = { aID=8714, aIndex=18, npc=73163, tip=deathAdder }, -- Imperial Python
	[71358293] = { aID=8714, aIndex=19, npc=73704 }, -- Stinkbraid
	[42704240] = { aID=8714, aIndex=20, npc=73157, -- Rock Moss
					tip="Enter the Cavern then check your World Map" },
	[57407660] = { aID=8714, aIndex=21, npc=73170 }, -- Watcher Osu
	[53208280] = { aID=8714, aIndex=22, npc=73169 }, -- Jakur of Ordon
	[60604840] = { aID=8714, aIndex=23, npc=73171 }, -- Champion of the Black Flame
	[61104670] = { aID=8714, aIndex=23, npc=73171 }, -- Champion of the Black Flame
	[63204340] = { aID=8714, aIndex=23, npc=73171 }, -- Champion of the Black Flame
	[65004200] = { aID=8714, aIndex=23, npc=73171 }, -- Champion of the Black Flame
	[65406020] = { aID=8714, aIndex=23, npc=73171 }, -- Champion of the Black Flame
	[67404240] = { aID=8714, aIndex=23, npc=73171 }, -- Champion of the Black Flame
	[67605760] = { aID=8714, aIndex=23, npc=73171 }, -- Champion of the Black Flame
	[69605500] = { aID=8714, aIndex=23, npc=73171 }, -- Champion of the Black Flame
	[69804460] = { aID=8714, aIndex=23, npc=73171 }, -- Champion of the Black Flame
	[70605180] = { aID=8714, aIndex=23, npc=73171 }, -- Champion of the Black Flame
	[71004720] = { aID=8714, aIndex=23, npc=73171 }, -- Champion of the Black Flame
	[54405320] = { aID=8714, aIndex=24, npc=73175 }, -- Cinderfall
	[43602600] = { aID=8714, aIndex=25, npc=73173 }, -- Urdur the Cauterizer
	[40802780] = { aID=8714, aIndex=26, npc=73172 }, -- Flintlord Gairan
	[44203380] = { aID=8714, aIndex=26, npc=73172 }, -- Flintlord Gairan
	[46603960] = { aID=8714, aIndex=26, npc=73172 }, -- Flintlord Gairan
	[48803700] = { aID=8714, aIndex=26, npc=73172 }, -- Flintlord Gairan
	[55603800] = { aID=8714, aIndex=26, npc=73172 }, -- Flintlord Gairan
	[58005740] = { aID=8714, aIndex=27, npc=73167 }, -- Huolon <The Black Wind>
	[65403620] = { aID=8714, aIndex=27, npc=73167 }, -- Huolon <The Black Wind>
	[65605700] = { aID=8714, aIndex=27, npc=73167 }, -- Huolon <The Black Wind>
	[66405980] = { aID=8714, aIndex=27, npc=73167 }, -- Huolon <The Black Wind>
	[67205740] = { aID=8714, aIndex=27, npc=73167 }, -- Huolon <The Black Wind>
	[68605860] = { aID=8714, aIndex=27, npc=73167 }, -- Huolon <The Black Wind>
	[73005360] = { aID=8714, aIndex=27, npc=73167 }, -- Huolon <The Black Wind>
	[73805080] = { aID=8714, aIndex=27, npc=73167 }, -- Huolon <The Black Wind>
	[74304260] = { aID=8714, aIndex=27, npc=73167 }, -- Huolon <The Black Wind>
	[61606380] = { aID=8714, aIndex=28, npc=72970 }, -- Golganarr
	[14005800] = { aID=8714, aIndex=29, npc=73279, tip=evermaw }, -- Evermaw
	[14202960] = { aID=8714, aIndex=29, npc=73279, tip=evermaw }, -- Evermaw
	[14404460] = { aID=8714, aIndex=29, npc=73279, tip=evermaw }, -- Evermaw
	[17606760] = { aID=8714, aIndex=29, npc=73279, tip=evermaw }, -- Evermaw
	[19501630] = { aID=8714, aIndex=29, npc=73279, tip=evermaw }, -- Evermaw
	[20807500] = { aID=8714, aIndex=29, npc=73279, tip=evermaw }, -- Evermaw
	[23800840] = { aID=8714, aIndex=29, npc=73279, tip=evermaw }, -- Evermaw
	[30000380] = { aID=8714, aIndex=29, npc=73279, tip=evermaw }, -- Evermaw
	[26208540] = { aID=8714, aIndex=29, npc=73279, tip=evermaw }, -- Evermaw
	[33149115] = { aID=8714, aIndex=29, npc=73279, -- Evermaw
					tip="Spawns east southeast of here\n\n" ..evermaw }, 
	[40409680] = { aID=8714, aIndex=29, npc=73279, tip=evermaw }, -- Evermaw
	[41600320] = { aID=8714, aIndex=29, npc=73279, tip=evermaw }, -- Evermaw
	[49209780] = { aID=8714, aIndex=29, npc=73279, tip=evermaw }, -- Evermaw
	[50000500] = { aID=8714, aIndex=29, npc=73279, tip=evermaw }, -- Evermaw
	[57800640] = { aID=8714, aIndex=29, npc=73279, tip=evermaw }, -- Evermaw
	[59009680] = { aID=8714, aIndex=29, npc=73279, tip=evermaw }, -- Evermaw
	[65009340] = { aID=8714, aIndex=29, npc=73279, tip=evermaw }, -- Evermaw
	[66001400] = { aID=8714, aIndex=29, npc=73279, tip=evermaw }, -- Evermaw
	[71008760] = { aID=8714, aIndex=29, npc=73279, tip=evermaw }, -- Evermaw
	[74401780] = { aID=8714, aIndex=29, npc=73279, tip=evermaw }, -- Evermaw
	[76307800] = { aID=8714, aIndex=29, npc=73279, tip=evermaw }, -- Evermaw
	[78202580] = { aID=8714, aIndex=29, npc=73279, tip=evermaw }, -- Evermaw
	[80006700] = { aID=8714, aIndex=29, npc=73279, tip=evermaw }, -- Evermaw
	[80603420] = { aID=8714, aIndex=29, npc=73279, tip=evermaw }, -- Evermaw
	[80704580] = { aID=8714, aIndex=29, npc=73279, tip=evermaw }, -- Evermaw
	[81005600] = { aID=8714, aIndex=29, npc=73279, tip=evermaw }, -- Evermaw
	[26002340] = { aID=8714, aIndex=30, npc=73281 }, -- Dread Ship Vazuvius
	[26312790] = { aID=8714, aIndex=30, npc=73281, -- Dread Ship Vazuvius
					tip="Use your Mist-Filled Spirit Lantern,\n"
						.."dropped by Evermaw, to summon Dread\n"
						.."Captain Genest" },
	[34603080] = { aID=8714, aIndex=31, npc=73666, -- Archiereus of Flame
					tip="Summoned version. Either one counts" },
	[48803360] = { aID=8714, aIndex=31, npc=73174, -- Archiereus of Flame
					tip="Non-summoned version. Either one counts" },
	[50802300] = { aID=8714, aIndex=31, npc=73174, -- Archiereus of Flame
					tip="Non-summoned version. Either one counts" },
	[56603540] = { aID=8714, aIndex=31, npc=73174, -- Archiereus of Flame
					tip="Non-summoned version. Either one counts" },
	[58002560] = { aID=8714, aIndex=31, npc=73174, -- Archiereus of Flame
					tip="Non-summoned version. Either one counts" },
}
points[ 555 ] = { -- Timeless Isle - Cavern of Lost Spirits
	[42003320] = { aID=8714, aIndex=20, npc=73157 }, -- Rock Moss
	[43603440] = { aID=8714, aIndex=20, npc=73157 }, -- Rock Moss
	[44003000] = { aID=8714, aIndex=20, npc=73157 }, -- Rock Moss
	[44003260] = { aID=8714, aIndex=20, npc=73157 }, -- Rock Moss
	[45802140] = { aID=8714, aIndex=20, npc=73157 }, -- Rock Moss
	[46203100] = { aID=8714, aIndex=20, npc=73157 }, -- Rock Moss
	[46603240] = { aID=8714, aIndex=20, npc=73157 }, -- Rock Moss
	[47003480] = { aID=8714, aIndex=20, npc=73157 }, -- Rock Moss
	[47403620] = { aID=8714, aIndex=20, npc=73157 }, -- Rock Moss
	[47603220] = { aID=8714, aIndex=20, npc=73157 }, -- Rock Moss
	[48206220] = { aID=8714, aIndex=12, npc=72769 }, -- Spirit of Jadefire
	[48403040] = { aID=8714, aIndex=20, npc=73157 }, -- Rock Moss
	[49403560] = { aID=8714, aIndex=20, npc=73157 }, -- Rock Moss
	[49902900] = { aID=8714, aIndex=20, npc=73157 }, -- Rock Moss
	[52407260] = { aID=8714, aIndex=12, npc=72769 }, -- Spirit of Jadefire
	[54006800] = { aID=8714, aIndex=12, npc=72769 }, -- Spirit of Jadefire
	[56003080] = { aID=8714, aIndex=12, npc=72769 }, -- Spirit of Jadefire
	[62403580] = { aID=8714, aIndex=12, npc=72769 }, -- Spirit of Jadefire
	[62903480] = { aID=8729, aIndex=2, aQuest=33203, item="Skull-Covered Chest" },
	[64004780] = { aID=8714, aIndex=12, npc=72769 }, -- Spirit of Jadefire
	[64206380] = { aID=8714, aIndex=12, npc=72769 }, -- Spirit of Jadefire
	[70206220] = { aID=8714, aIndex=12, npc=72769 }, -- Spirit of Jadefire
	[74403240] = { aID=8714, aIndex=12, npc=72769 }, -- Spirit of Jadefire

	[38202960] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[38703880] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[39002740] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[39802570] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[41903810] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[42506670] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[42603140] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[43103770] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[43503990] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[44603060] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[44707900] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[44907630] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[45103750] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[45202190] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[45603350] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[45702070] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[46502530] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[46602870] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[47103750] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[47302630] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[47503120] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[47603550] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[48503360] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[48603880] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[48801530] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[52501310] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[53406500] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[53503360] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[53705600] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[53707350] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[53806350] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[54703120] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[56904050] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[59506300] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[59705890] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[64003540] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[66006550] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[67702720] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[67703420] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[68502800] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[68804950] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[71101180] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
	[74603410] = { aID=8725, aIndex=4, obj=222686, item="Eerie Crystal", tip=several },
}
points[ 388 ] = { -- Townlong Steppes

	-- To All the Squirrels I Once Caressed?
	[51807080] = { aID=6350, aIndex=13, }, -- Mongoose
	[52506570] = { aID=6350, aIndex=13, }, -- Mongoose
	[70608120] = { aID=6350, aIndex=13, }, -- Mongoose
	[72508060] = { aID=6350, aIndex=13, }, -- Mongoose
	[72608440] = { aID=6350, aIndex=13, continent=true }, -- Mongoose
	[72807650] = { aID=6350, aIndex=13, }, -- Mongoose
	[76107270] = { aID=6350, aIndex=13, }, -- Mongoose
	[77006700] = { aID=6350, aIndex=13, }, -- Mongoose
	[78606420] = { aID=6350, aIndex=13, }, -- Mongoose
	[80006700] = { aID=6350, aIndex=13, }, -- Mongoose
	[81308120] = { aID=6350, aIndex=13, }, -- Mongoose
	[81608410] = { aID=6350, aIndex=13, }, -- Mongoose	
	[49207140] = { aID=6350, aIndex=17, }, -- Yakrat
	[49806720] = { aID=6350, aIndex=17, }, -- Yakrat
	[70608380] = { aID=6350, aIndex=17, continent=true }, -- Yakrat
	[75408250] = { aID=6350, aIndex=17, }, -- Yakrat
	[77508360] = { aID=6350, aIndex=17, }, -- Yakrat
	[78107840] = { aID=6350, aIndex=17, }, -- Yakrat
	[79807180] = { aID=6350, aIndex=17, }, -- Yakrat
	[81807150] = { aID=6350, aIndex=17, }, -- Yakrat
	[82507350] = { aID=6350, aIndex=17, }, -- Yakrat
	[83607900] = { aID=6350, aIndex=17, }, -- Yakrat
	[83807620] = { aID=6350, aIndex=17, }, -- Yakrat

	-- Is another Man's Treasure
	[66244468] = { aID=7284, item=86518, aQuest=31425, }, -- Yaungol Fire Carrier
	[66854805] = { aID=7284, item=86518, aQuest=31425, }, -- Yaungol Fire Carrier
	
	-- Glorious
	[31856196] = { aID=7439, aIndex=40, continent=true }, -- Yul Wildpaw
	[41887849] = { aID=7439, aIndex=19 }, -- Lith'ik the Stalker
	[46317445] = { aID=7439, aIndex=19, continent=true }, -- Lith'ik the Stalker
	[47818426] = { aID=7439, aIndex=19 }, -- Lith'ik the Stalker
	[47868855] = { aID=7439, aIndex=19 }, -- Lith'ik the Stalker
	[53896348] = { aID=7439, aIndex=26, continent=true }, -- Norlaxx
	[59358537] = { aID=7439, aIndex=47, continent=true }, -- Siltriss the Sharpener
	[62863540] = { aID=7439, aIndex=33, continent=true }, -- Kah'tir
	[64034947] = { aID=7439, aIndex=54, }, -- Lon the Bull
	[64234997] = { aID=7439, aIndex=54, }, -- Lon the Bull
	[64365058] = { aID=7439, aIndex=54, continent=true }, -- Lon the Bull
	[64705068] = { aID=7439, aIndex=54, }, -- Lon the Bull
	[65195059] = { aID=7439, aIndex=54, }, -- Lon the Bull
	[65378747] = { aID=7439, aIndex=12, continent=true }, -- Eshelon
	[65655061] = { aID=7439, aIndex=54, }, -- Lon the Bull
	[66134494] = { aID=7439, aIndex=54, }, -- Lon the Bull
	[66135082] = { aID=7439, aIndex=54, }, -- Lon the Bull
	[66375268] = { aID=7439, aIndex=54, }, -- Lon the Bull
	[66415205] = { aID=7439, aIndex=54, }, -- Lon the Bull
	[66425133] = { aID=7439, aIndex=54, }, -- Lon the Bull
	[66564473] = { aID=7439, aIndex=54, }, -- Lon the Bull
	[66585279] = { aID=7439, aIndex=54, }, -- Lon the Bull
	[66695237] = { aID=7439, aIndex=54, }, -- Lon the Bull
	[66705185] = { aID=7439, aIndex=54, }, -- Lon the Bull
	[66725154] = { aID=7439, aIndex=54, continent=true }, -- Lon the Bull
	[66935110] = { aID=7439, aIndex=54, }, -- Lon the Bull
	[67134465] = { aID=7439, aIndex=54, }, -- Lon the Bull
	[67214645] = { aID=7439, aIndex=54, }, -- Lon the Bull
	[67214722] = { aID=7439, aIndex=54, }, -- Lon the Bull
	[67265089] = { aID=7439, aIndex=54, }, -- Lon the Bull
	[67334575] = { aID=7439, aIndex=54, }, -- Lon the Bull
	[67354519] = { aID=7439, aIndex=54, }, -- Lon the Bull
	[67524784] = { aID=7439, aIndex=54, }, -- Lon the Bull
	[67754834] = { aID=7439, aIndex=54, }, -- Lon the Bull
	[67755028] = { aID=7439, aIndex=54, }, -- Lon the Bull
	[67834902] = { aID=7439, aIndex=54, }, -- Lon the Bull
	[67854967] = { aID=7439, aIndex=54, }, -- Lon the Bull
	[67407355] = { aID=7439, aIndex=5, tip="Enter the cave here", continent=true  }, -- The Yowler
	[67858751] = { aID=7439, aIndex=12, }, -- Eshelon
	[68998921] = { aID=7439, aIndex=12, }, -- Eshelon

	-- Riches of Pandaria
	[62823404] = { aID=7997, item="Abandoned Crate of Goods", aQuest=31427, },
	[65838609] = { aID=7997, item=86472, aQuest=31426, }, -- Amber Encased Moth
	[32816174] = { aID=7997, item=86516, aQuest=31423, tip="Enter the Niuzao Catacombs, then check your map" },
					-- Fragment of Dread
	[50855512] = { aID=7997, item=86517, aQuest=31424, author="V" }, -- Hardened Sap of Kri'vess
	[51115734] = { aID=7997, item=86517, aQuest=31424, author="V" }, -- Hardened Sap of Kri'vess
	[52065872] = { aID=7997, item=86517, aQuest=31424, author="V" }, -- Hardened Sap of Kri'vess
	[52505770] = { aID=7997, item=86517, aQuest=31424, author="?" }, -- Hardened Sap of Kri'vess
	[52565553] = { aID=7997, item=86517, aQuest=31424, author="V" }, -- Hardened Sap of Kri'vess
	[53786129] = { aID=7997, item=86517, aQuest=31424, author="V" }, -- Hardened Sap of Kri'vess
	[52805620] = { aID=7997, item=86517, aQuest=31424, author="?" }, -- Hardened Sap of Kri'vess
	[53806000] = { aID=7997, item=86517, aQuest=31424, author="?" }, -- Hardened Sap of Kri'vess
	[53905840] = { aID=7997, item=86517, aQuest=31424, author="?" }, -- Hardened Sap of Kri'vess
	[55526100] = { aID=7997, item=86517, aQuest=31424, author="V" }, -- Hardened Sap of Kri'vess
	[55615413] = { aID=7997, item=86517, aQuest=31424, author="V" }, -- Hardened Sap of Kri'vess
	[56005500] = { aID=7997, item=86517, aQuest=31424, author="?" }, -- Hardened Sap of Kri'vess
	[57345670] = { aID=7997, item=86517, aQuest=31424, author="V" }, -- Hardened Sap of Kri'vess
	[57505860] = { aID=7997, item=86517, aQuest=31424, author="?" }, -- Hardened Sap of Kri'vess

	-- Zul Again
	[36598565] = { aID=8078, tip="Zandalari Warbringer. There are three types, each dropping\n"
					.."a different coloured Primordial Direhorn mount.\n\n"
					.."Can despawn as fast as 2 to 3 minutes after spawning" },
	[36878512] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[37478659] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[38048410] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[38758762] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[39098230] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[39818890] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[39918074] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[40407882] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[40967683] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[41028985] = { aID=8078, npc=69768, tip="Zandalari Warscout", continent=true },
	[42559059] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[42657607] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[44007481] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[44199059] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[45108916] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[46147524] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[46478993] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[47328834] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[47857424] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[48278673] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[48808460] = { aID=8078, npc=69768, tip="Zandalari Warscout" },
	[49487319] = { aID=8078, npc=69768, tip="Zandalari Warscout" },

	-- Miscellany
	[37776291] = { aID=6855, aIndex=5, }, -- Part 5
	[65394998] = { aID=6847, aIndex=2, }, -- Dominance
	[84087287] = { aID=6847, aIndex=4, }, -- Trapped in a Strange Land

}
points[ 389 ] = { -- Townlong Steppes - Niuzao Catacombs
	[36448782] = { aID=7997, item=86516, aQuest=31423, }, -- Fragment of Dread
	[48508953] = { aID=7997, item=86516, aQuest=31423, }, -- Fragment of Dread
	[55673320] = { aID=7997, item=86516, aQuest=31423, tip="check this general area" }, -- Fragment of Dread
	[56556447] = { aID=7997, item=86516, aQuest=31423, }, -- Fragment of Dread
	[64282029] = { aID=7997, item=86516, aQuest=31423, tip="An ore node might be concealing it" },
}

local pandarenCuisine = "All except the \"Perfectly Cooked Instant Noodles\" and\n"
					.."the \"Sliced Peaches\" may be purchased from this NPC.\n\n"
					.."The remaining two, as recipes, can be bought from Sungshin\n"
					.."Ironpaw at Halfhill in the Valley of the Four Winds"

points[ 390 ] = { -- Vale of Eternal Blossoms
	-- To All the Squirrels I Once Caressed?
	[30956785] = { aID=6350, aIndex=5, }, -- Dancing Water Skimmer
	[31756700] = { aID=6350, aIndex=5, continent=true }, -- Dancing Water Skimmer
	[33156515] = { aID=6350, aIndex=5, }, -- Dancing Water Skimmer
	[22656080] = { aID=6350, aIndex=7, }, -- Gilded Moth
	[30206415] = { aID=6350, aIndex=7, continent=true }, -- Gilded Moth
	[36606275] = { aID=6350, aIndex=7, }, -- Gilded Moth
	[25556470] = { aID=6350, aIndex=8, }, -- Golden Civet
	[27306875] = { aID=6350, aIndex=8, }, -- Golden Civet
	[30355910] = { aID=6350, aIndex=8, continent=true }, -- Golden Civet
	[36656495] = { aID=6350, aIndex=8, }, -- Golden Civet

	-- Glorious
	[13865864] = { aID=7439, aIndex=21, continent=true }, -- Kal'tik the Blight
	[15253522] = { aID=7439, aIndex=28, continent=true }, -- Kang the Soul Thief
	[30789150] = { aID=7439, aIndex=7, continent=true }, -- Major Nanners
	[34546187] = { aID=7439, aIndex=49, }, -- Moldo One Eye
	[35586003] = { aID=7439, aIndex=49, }, -- Moldo One Eye
	[36765802] = { aID=7439, aIndex=49, }, -- Moldo One Eye
	[37865636] = { aID=7439, aIndex=49, continent=true }, -- Moldo One Eye
	[38855429] = { aID=7439, aIndex=49, }, -- Moldo One Eye
	[39572514] = { aID=7439, aIndex=35, continent=true }, -- Urgolax
	[40545339] = { aID=7439, aIndex=49, }, -- Moldo One Eye
	[40956848] = { aID=7439, aIndex=42, tip="Enter here", continent=true  }, -- Al-Ran the Shifting Cloud
	[42135392] = { aID=7439, aIndex=49, }, -- Moldo One Eye
	[42846925] = { aID=7439, aIndex=42, continent=true }, -- Al-Ran the Shifting Cloud
	[43845229] = { aID=7439, aIndex=49, }, -- Moldo One Eye
	[69413064] = { aID=7439, aIndex=14, continent=true }, -- Sahn Tidehunter
	[88084435] = { aID=7439, aIndex=56, continent=true }, -- Yorik Sharpeye

	-- I'm In Your Base Killing Your Dudes
	[83995870] = { aID=7932, aQuest=32246, qName="Meet the Scout", npc=64610, faction="Alliance",
					tip="Talk to Lyalia. She's down below" },
	[62932818] = { aID=7932, aQuest=32249, qName="Meet the Scout", npc=64566, faction="Horde",
					tip="Talk to Sunwalker Dezco. He's down below" },

	-- Miscellany
	[26002100] = { aID=6858, aIndex=4, }, -- Together, We are Strong
	[40007700] = { aID=6754, aIndex=4, }, -- The Thunder King
	[53006900] = { aID=6858, aIndex=2, }, -- Always Remember
	[62561387] = { aID=7329, npc=64041, faction="Horde", -- Pandaren Cuisine
					tip=colourHighlight .."Mifan\n\n" ..colourPlaintext ..pandarenCuisine }, 
	[67704427] = { aID=6855, aIndex=8, }, -- Part 8
	[87286939] = { aID=7329, npc=63013, faction="Alliance", -- Pandaren Cuisine
					tip=colourHighlight .."Sway Dish Chef\n\n" ..colourPlaintext ..pandarenCuisine }, 
}
points[ 391 ] = { -- Shrine of Two Moons in Vale of Eternal Blossoms
	[67163883] = { aID=7329, npc=64041, faction="Horde", -- Pandaren Cuisine
					tip=colourHighlight .."Mifan\n\n" ..colourPlaintext ..pandarenCuisine }, 
}
points[ 393 ] = { -- Shrine of Seven Stars in Vale of Eternal Blossoms
	[40307080] = { aID=7329, npc=63013, faction="Alliance", -- Pandaren Cuisine
					tip=colourHighlight .."Sway Dish Chef\n\n" ..colourPlaintext ..pandarenCuisine }, 
}
points[ 376 ] = { -- Valley of the Four Winds
	-- To All the Squirrels I Once Caressed?
	[62156350] = { aID=6350, aIndex=2, }, -- Bandicoon
	[62555775] = { aID=6350, aIndex=2, continent=true }, -- Bandicoon
	[63856245] = { aID=6350, aIndex=2, }, -- Bandicoon
	[59855675] = { aID=6350, aIndex=11, continent=true }, -- Malayan Quillrat
	[59955870] = { aID=6350, aIndex=11, }, -- Malayan Quillrat
	[58755735] = { aID=6350, aIndex=12, }, -- Marsh Fiddler
	[63256055] = { aID=6350, aIndex=12, continent=true }, -- Marsh Fiddler
	[64306136] = { aID=6350, aIndex=12, }, -- Marsh Fiddler
	[59405965] = { aID=6350, aIndex=16, continent=true }, -- Sifang Otter
	[64406525] = { aID=6350, aIndex=16, }, -- Sifang Otter

	-- Ballad of Liu Lang
	[20225586] = { aID=6856, aIndex=1, }, -- The Birthplace of Liu Lang
	[34576384] = { aID=6856, aIndex=3, }, -- The Wandering Widow
	[55044713] = { aID=6856, aIndex=2, }, -- A Most Famous Bill of Sale
	
	-- Is another Man's Treasure
	[46802440] = { aID=7284, item="Ghostly Pandaren Fisherman", aQuest=31284, },
					-- I opted for the NPC rather than the item 85973 Ancient Pandaren Fishing Charm
	[45403838] = { aID=7284, item="Ghostly Pandaren Craftsman", aQuest=31292, tip="Standing under a tree" },
					-- I opted for the NPC rather than the item 86079 Ancient Pandaren Woodcutter
	[43613748] = { aID=7284, item="Cache of Pilfered Goods", aQuest=31406, 
					tip="Descend into the Springtail Warren" }, -- Object 213649
	[18944247] = { aID=7284, item=86218, aQuest=31407, }, -- Staff of the Hidden Master
	[19183773] = { aID=7284, item=86218, aQuest=31407, }, -- Staff of the Hidden Master
	[17473586] = { aID=7284, item=86218, aQuest=31407, }, -- Staff of the Hidden Master
	[14933373] = { aID=7284, item=86218, aQuest=31407, }, -- Staff of the Hidden Master
	[15422917] = { aID=7284, item=86218, aQuest=31407, }, -- Staff of the Hidden Master
	
	-- Glorious
	[08175803] = { aID=7439, aIndex=16, }, -- Nal'lak the Ripper
	[08295951] = { aID=7439, aIndex=16, }, -- Nal'lak the Ripper
	[08385672] = { aID=7439, aIndex=16, }, -- Nal'lak the Ripper
	[08706018] = { aID=7439, aIndex=16, }, -- Nal'lak the Ripper
	[08755589] = { aID=7439, aIndex=16, }, -- Nal'lak the Ripper
	[09134811] = { aID=7439, aIndex=16, }, -- Nal'lak the Ripper
	[09145943] = { aID=7439, aIndex=16, }, -- Nal'lak the Ripper
	[09155842] = { aID=7439, aIndex=16, }, -- Nal'lak the Ripper
	[09205137] = { aID=7439, aIndex=16, }, -- Nal'lak the Ripper
	[09246043] = { aID=7439, aIndex=16, }, -- Nal'lak the Ripper
	[09375488] = { aID=7439, aIndex=16, }, -- Nal'lak the Ripper
	[09414758] = { aID=7439, aIndex=16, }, -- Nal'lak the Ripper
	[09514858] = { aID=7439, aIndex=16, }, -- Nal'lak the Ripper
	[09625267] = { aID=7439, aIndex=16, }, -- Nal'lak the Ripper
	[09635005] = { aID=7439, aIndex=16, }, -- Nal'lak the Ripper
	[09645672] = { aID=7439, aIndex=16, }, -- Nal'lak the Ripper
	[09735758] = { aID=7439, aIndex=16, }, -- Nal'lak the Ripper
	[09845392] = { aID=7439, aIndex=16, }, -- Nal'lak the Ripper
	[10015617] = { aID=7439, aIndex=16, continent=true }, -- Nal'lak the Ripper
	[10164923] = { aID=7439, aIndex=16, }, -- Nal'lak the Ripper
	[10174727] = { aID=7439, aIndex=16, }, -- Nal'lak the Ripper
	[10475653] = { aID=7439, aIndex=16, }, -- Nal'lak the Ripper
	[10824807] = { aID=7439, aIndex=16, }, -- Nal'lak the Ripper
	[11245649] = { aID=7439, aIndex=16, }, -- Nal'lak the Ripper
	[11514890] = { aID=7439, aIndex=16, }, -- Nal'lak the Ripper
	[11635282] = { aID=7439, aIndex=16, }, -- Nal'lak the Ripper
	[11705556] = { aID=7439, aIndex=16, }, -- Nal'lak the Ripper
	[11905410] = { aID=7439, aIndex=16, }, -- Nal'lak the Ripper
	[11995106] = { aID=7439, aIndex=16, }, -- Nal'lak the Ripper
	[12184841] = { aID=7439, aIndex=16, }, -- Nal'lak the Ripper
	[12304964] = { aID=7439, aIndex=16, }, -- Nal'lak the Ripper
	[13953847] = { aID=7439, aIndex=2, author="V. need five" }, -- Bonobos
	[15383220] = { aID=7439, aIndex=2, author="V. need five" }, -- Bonobos
	[16494092] = { aID=7439, aIndex=2, author="V. need five" }, -- Bonobos
	[18597770] = { aID=7439, aIndex=30, continent=true }, -- Jonn-Dar
	[19133566] = { aID=7439, aIndex=2, author="V. need five", continent=true  }, -- Bonobos
	[32886269] = { aID=7439, aIndex=51, }, -- Blackhoof
	[34545922] = { aID=7439, aIndex=51, continent=true }, -- Blackhoof
	[36942575] = { aID=7439, aIndex=23, item=86569, continent=true  }, -- Sulik'shor
	[37826040] = { aID=7439, aIndex=51, }, -- Blackhoof
	[39635765] = { aID=7439, aIndex=51, }, -- Blackhoof
	[52132787] = { aID=7439, aIndex=9, author="Look for more", -- Sele'na
					tip="Bugged location. Head of the body still visible.\n\nLots of other locations" },
	[52142832] = { aID=7439, aIndex=9, tip="Pat perimeter", author="Look for more" }, -- Sele'na
	[52552915] = { aID=7439, aIndex=9, tip="Pat perimeter", author="Look for more" }, -- Sele'na
	[52832757] = { aID=7439, aIndex=9, tip="Pat perimeter", author="Look for more" }, -- Sele'na
	[52992916] = { aID=7439, aIndex=9, tip="Pat perimeter", author="Look for more" }, -- Sele'na
	[53152776] = { aID=7439, aIndex=9, tip="Pat perimeter", author="Look for more" }, -- Sele'na
	[53402889] = { aID=7439, aIndex=9, tip="Pat perimeter", author="Look for more" }, -- Sele'na
					
	[53663226] = { aID=7439, aIndex=9, tip="Pat perimeter", author="Look for more" }, -- Sele'na
	[53803165] = { aID=7439, aIndex=9, tip="Pat perimeter", author="Look for more" }, -- Sele'na
	[54073159] = { aID=7439, aIndex=9, tip="Pat perimeter", author="Look for more" }, -- Sele'na
	[54223269] = { aID=7439, aIndex=9, tip="Pat perimeter", author="Look for more" }, -- Sele'na
	[54283235] = { aID=7439, aIndex=9, tip="Pat perimeter", author="Look for more" }, -- Sele'na
	[54293197] = { aID=7439, aIndex=9, tip="Pat perimeter", author="Look for more" }, -- Sele'na

	[53973577] = { aID=7439, aIndex=9, tip="Pat perimeter", author="Look for more" }, -- Sele'na
	[54113668] = { aID=7439, aIndex=9, tip="Pat perimeter", author="Look for more" }, -- Sele'na
	[54233631] = { aID=7439, aIndex=9, tip="Pat perimeter", author="Look for more" }, -- Sele'na
	[54543576] = { aID=7439, aIndex=9, tip="Pat perimeter", author="Look for more" }, -- Sele'na
	[54543717] = { aID=7439, aIndex=9, tip="Pat perimeter", author="Look for more" }, -- Sele'na
	[54823583] = { aID=7439, aIndex=9, tip="Pat perimeter", author="Look for more" }, -- Sele'na
	[55093679] = { aID=7439, aIndex=9, tip="Pat perimeter", author="Look for more", continent=true  }, -- Sele'na
	[54963622] = { aID=7439, aIndex=9, tip="Pat perimeter", author="Look for more" }, -- Sele'na

	[57173330] = { aID=7439, aIndex=9, tip="Pat perimeter", author="Look for more" }, -- Sele'na
	[57233398] = { aID=7439, aIndex=9, tip="Pat perimeter", author="Look for more" }, -- Sele'na
	[57243364] = { aID=7439, aIndex=9, tip="Pat perimeter", author="Look for more" }, -- Sele'na
	[57343292] = { aID=7439, aIndex=9, tip="Pat perimeter", author="Look for more" }, -- Sele'na
	[57543403] = { aID=7439, aIndex=9, tip="Pat perimeter", author="Look for more" }, -- Sele'na
	[57603322] = { aID=7439, aIndex=9, tip="Pat perimeter", author="Look for more" }, -- Sele'na
	[57763357] = { aID=7439, aIndex=9, tip="Pat perimeter", author="Look for more" }, -- Sele'na
	[57873394] = { aID=7439, aIndex=9, tip="Pat perimeter", author="Look for more" }, -- Sele'na
	[57893375] = { aID=7439, aIndex=9, tip="Pat perimeter", author="Look for more" }, -- Sele'na
	
	[67246025] = { aID=7439, aIndex=44, }, -- Salyin Warscout
	[67665912] = { aID=7439, aIndex=44, }, -- Salyin Warscout
	[68235825] = { aID=7439, aIndex=44, }, -- Salyin Warscout
	[68585729] = { aID=7439, aIndex=44, }, -- Salyin Warscout
	[68965641] = { aID=7439, aIndex=44, }, -- Salyin Warscout
	[69345526] = { aID=7439, aIndex=44, }, -- Salyin Warscout
	[69715425] = { aID=7439, aIndex=44, }, -- Salyin Warscout
	[70075323] = { aID=7439, aIndex=44, }, -- Salyin Warscout
	[70745262] = { aID=7439, aIndex=44, }, -- Salyin Warscout
	[71535228] = { aID=7439, aIndex=44, }, -- Salyin Warscout
	[72115241] = { aID=7439, aIndex=44, }, -- Salyin Warscout
	[72785255] = { aID=7439, aIndex=44, }, -- Salyin Warscout
	[73465276] = { aID=7439, aIndex=44, }, -- Salyin Warscout
	[74095249] = { aID=7439, aIndex=44, continent=true }, -- Salyin Warscout
	[74194963] = { aID=7439, aIndex=44, }, -- Salyin Warscout
	[74265150] = { aID=7439, aIndex=44, }, -- Salyin Warscout
	[74305060] = { aID=7439, aIndex=44, }, -- Salyin Warscout
	[74634899] = { aID=7439, aIndex=44, }, -- Salyin Warscout
	[74934811] = { aID=7439, aIndex=44, }, -- Salyin Warscout
	[75344667] = { aID=7439, aIndex=44, }, -- Salyin Warscout
	[75414771] = { aID=7439, aIndex=44, }, -- Salyin Warscout
	[75904654] = { aID=7439, aIndex=44, }, -- Salyin Warscout
	[88391785] = { aID=7439, aIndex=37, continent=true }, -- Nasra Spothide

	-- Riches of Pandaria
	[23722832] = { aID=7997, item="Virmen Treasure Cache", aQuest=31405, }, -- Virmen Treasure Cache
	[23203071] = { aID=7997, item="Virmen Treasure Cache", aQuest=31405, tip="Hidden entrance. Under the tree" },
					-- Virmen Treasure Cache					
	[75015515] = { aID=7997, item=86220, aQuest=31408, }, -- Saurok Stone Tablet. Item/object the same name
	[77405745] = { aID=7997, item=86220, aQuest=31408, tip="Cave entrance" },
					-- Saurok Stone Tablet. Item/object the same name

	-- Miscellany
	[18823167] = { aID=6858, aIndex=1, }, -- Pandaren Fighting Tactics
	[53595124] = { aID=7329, npc=64231, -- Pandaren Cuisine
					tip=colourHighlight .."Sungshin Ironpaw\n\n" ..colourPlaintext
					.."\"Perfectly Cooked Instant Noodles\" and \"Sliced \n"
					.."Peaches\" recipes may be purchased here. The\n"
					.." others, as ready to eat food, may be purchased\n"
					.."from your base in the Vale of Eternal Blossoms.\n\n"
					.."Sungshin also sells \"Pandaren Peaches\" and the\n"
					.."\"Instant Noodles\""
					}, 
	[61223475] = { aID=6846, aIndex=2, }, -- Waterspeakers
	[83202117] = { aID=6850, aIndex=3, }, -- Embracing the Passions
}

-- Choice of texture
-- Note that these textures are all repurposed and as such have non-uniform sizing.
-- I've copied my scaling factors from an old AddOn.
-- in order to homogenise the sizes I should also allow for non-uniform origin placement as well as
-- adjust the x,y offsets
textures[1] = "Interface\\PlayerFrame\\MonkLightPower"
textures[2] = "Interface\\PlayerFrame\\MonkDarkPower"
textures[3] = "Interface\\Common\\Indicator-Red"
textures[4] = "Interface\\Common\\Indicator-Yellow"
textures[5] = "Interface\\Common\\Indicator-Green"
textures[6] = "Interface\\Common\\Indicator-Gray"
textures[7] = "Interface\\Common\\Friendship-ManaOrb"	
textures[8] = "Interface\\TargetingFrame\\UI-PhasingIcon"
textures[9] = "Interface\\Store\\Category-icon-pets"
textures[10] = "Interface\\Store\\Category-icon-featured"
textures[11] = "Interface\\AddOns\\HandyNotes_EAPandaria\\EAPandariaGold"
textures[12] = "Interface\\AddOns\\HandyNotes_EAPandaria\\EAPandariaBlue"
textures[13] = "Interface\\AddOns\\HandyNotes_EAPandaria\\EAPandariaPink"
textures[14] = "Interface\\AddOns\\HandyNotes_EAPandaria\\EAPandariaOriginal"
textures[15] = "Interface\\AddOns\\HandyNotes_EAPandaria\\Love"

scaling[1] = 0.55
scaling[2] = 0.55
scaling[3] = 0.55
scaling[4] = 0.55
scaling[5] = 0.55
scaling[6] = 0.55
scaling[7] = 0.65
scaling[8] = 0.62
scaling[9] = 0.75
scaling[10] = 0.75
scaling[11] = 0.4
scaling[12] = 0.4
scaling[13] = 0.4
scaling[14] = 0.4
scaling[15] = 0.35
