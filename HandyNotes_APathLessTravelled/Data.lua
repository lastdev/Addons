local _, ns = ...
local points = ns.points
local textures = ns.textures
local scaling = ns.scaling
local colourPrefix		= ns.colour.prefix
local colourHighlight	= ns.colour.highlight
local colourPlaintext	= ns.colour.plaintext

local doomsayersRobes = "Kill him and oh boy, he might drop a toy!\n\n"
						.."The cool \"Doomsayer's Robes\" transform\n"
						.."no less!\n\n"
						.."If the corpse disappears instantly then there\n"
						.."was no drop this time. There's no toying with\n"
						.."this lad! Come back next time...\n\n"
						.."...And next time. But it ain't too bad. Reports\n"
						.."are you'll have it in ten attempts easy!"
						
--=======================================================================================================
--
-- EASTERN KINGDOMS
--
--=======================================================================================================

local abandonedHope = "Love the signs and the victims strung up.\nHmmm... someone or something has \n"
					.."been gnawing at their legs!"
local abercrombieAndFitch =   "Okay you've found Abercrombie. Great!\n"
							.."But now the other part. What could it be?\n"
							.."Hint: Do the quest chain!"
local antonJermaine = "Two dwarves on a camping / drinking expedition.\n"
					.."What could possibly go wrong? Guess the\n"
					.."\"locals\" scented something delicious!"
local aridensCamp = "Ariden's camp has been here since the first adventurers\n"
				.."traipsed through Deadwind Pass.\n\n"
				.."During the events of \"Legion\" A Relic Box was noticed...\n"
				.."\"clever forgeries\" hints at Ariden's activities - he's\n"
				.."nothing more than a charlatan trader, flogging conterfeit\n"
				.."artifacts!\n\n"
				.."Some adventurers will come here, specifically Unholy\n"
				.."Deathknights, Affliction Warlocks, and Balance Druids,\n"
				.."as they hunt for him in their quest to obtain a legendary\n"
				.."artifact weapon.\n\n"
				.."Depending upon your situation, some of the items in\n"
				.."the camp, when clicked, have extra information"
local artifactWeapons = "If you come across this then chances are\n"
					.."you'll see a disc structure in the lake.\n\n"
					.."Since the Legion era Holy Paladins who\n"
					.."adventured here are rumoured to have\n"
					.."found \"The Silver Hand\" artifact two-\n"
					.."handed mace legendary weapon!\n\n"
					.."Likewise \"Strom'kar the Warbreaker\" as\n"
					.."wielded by Arms Warriors and \"Xal'atath,\n"
					.."Blade of the Black Empire\" (along with\n"
					.."\"Secrets of the Void\" as possessed by\n"
					.."Shadow Priests.\n\n"
					.."An \"Underwater Passage\" here? Only\n"
					.."if you are on a quest to retrieve said\n"
					.."legendary weapons"
local blackIce = "Yup. You wear a ring and you can see it!\n"
				.."Sounds cool? I thought so!!! Here's the deal:\n\n"
				.."Go to Heroic Zul'Gurub and speak to Oversear\n"
				.."Blingbang at the entrance area. He'll give you\n"
				.."a bit of work to do. Sigh. Nothing is free in life...\n\n"
				.."(1) Kill High Priest Venoxis\n"
				.."(2) Kill High Priestess Kilnara\n"
				.."(3) Go to Jin'do the Godbreaker's platform but\n"
				.."pull and bring a Gurubashi Spirit Warrior with\n"
				.."you. Take the boss down to 1%\n"
				.."(4) In the next phase there are three chains\n"
				.."which need to be broken. Wait until a Warrior\n"
				.."Body Slams you then break the chain\n"
				.."(5) Kill Jin'do and loot him\n"
				.."(6) Hand in etc\n\n"
				.."\"Black Ice\" is a toy which rewards a cosmetic\n"
				.."effect. It does NOT use a ring slot! Neat? Yup!!!"
local broadsideBetty = "Well we hate to see her go,\nBut we love to watch her leave!\n"
						.."She'll do her best for William\nAnd Wes and Mike and Steve!\n"
						.."Her name is spread both far and wide!\nHer legend is renowned!\n"
						.."They call her Broadside Betty,\nShe's the roundest game in town!\n"
						.."So if you've mind to travel south,\nBe sure to stop and play!\n"
						.."'Cause she's the real reason\nThat they call it Booty Bay!\n\n"
						.."((Warcraft: Legends Vol. 4, manga))"
local caerDarrow = "Possible to fly in and snoop around!"
local catLady = "At the back of her house is a tombstone marking\n"
				.."the grave of \"Lord Underfoot\". You can meet\n"
				.."Lord Underfoot again at the Blacksmith in Arathi\n"
				.."Basin if you are Horde and you've captured it!\n\n"
				.."((Donni is named after former Blizzard staffer\n"
				.."Donna \"Kat\" Anthony, whom is reportedly the\n"
				.."person responsible for pushing for vanity pets\n"
				.."in game. Thank you Katricia!))"
local christ = "((The goblin statue with outstretched arms is referring to\n"
			.."\"Christ on Corcovado\". This statue is atop a mountain\n"
			.."near Rio de Janeiro.))\n\n"
			.."The robes the goblin is wearing are, appropriately,\n"
			.."\"Gamemaster Robes\", unobtainable be us mere\nmortals!"
local deadminesExit = "This is the exit to the, erm, Deadmines exit.\n\n"
					.."Ever since adventurers first used this exit\n"
					.."they have tried to go back in. Not possible!\n\n"
					.."When you exit from the Deadmines you are\n"
					.."placed below a ledge which is too high to\n"
					.."jump upon. Your only option is to continue\n"
					.."down to here"
local defiasGate = "This huge gate is the exit for the Defias Juggernaught.\n"
				.."That's the huge ship we see when we reach the\n"
				.."Ironclad Cove in the Deadmines.\n\n"
				.."((In WoW Alpha the Cove was outdoors!!!))"
local dregoth =   "Awwww he's not at all suspicious! First\n"
				.."appeared at the start of \"Dragonflight\".\n\n"
				.."Why did he suddenly arrive in Darkshire?\n"
				.."Nobody knows! Others have likewise popped\n"
				.."up in several locations across Azeroth!"
local dwarvenFarm = "Just a cool farming area. Chill. Nothing else to see!"
local ebonchill = "This location, complete with a Circle of Power\n"
				.."is swarming with arcane elementals and mana wyrm.\n\n"
				.."It became known around the time of \"Legion\" and\n"
				.."is a key location frost mages will visit when they\n"
				.."seek to acquire their legendary artifact weapon."
local fourChildren = "((The four children in this area are tributes\n"
					.."to Blizzard Exterior Level Designers. One,\n"
					.."Matt, wanders between the pond and the\n"
					.."lake, searching for fish))"
local gnollTent = "When gnolls skin their prey they leave\n"
				.."nothing to waste. Even a human face has\n"
				.."a use when stretched out for tent material!"
local garrod = "No need to take your shoes off when\n"
			.."visiting Garrod's house. Just fly right in!\n\n"
			.."Yup, flying on any of your mounts is\n"
			.."quite within his house rules it seems.\n\n"
			.."Just don't you dare try to mount up\n"
			.."though as he apparently draws the line\n"
			.."at that. Go figure, whatever!"
local graveMoss = "This herb, unusually, has just the one\nlocation which is viable to farm...\n"
				.."right here in the Raven Hill Cemetery!\n\nYes... I know you can find it elsewhere\n"
				.."but emphasis on \"viable\" please! :)"
local highPointEK = "Highest peak in the Eastern Kingdoms.\n\n"
					.."Hmmm... looks like another expedition\n"
					.."wasn't quite as successful..."
local hiHoHiHo = "It's the Seven Dwarves Plus Two!\n\n"
				.."Built in redundancy in case of\n"
				.."problems along the way.\n\n"
				.."Hang around a bit and you'll\n"
				.."see what I mean!\n\n"
local hogger = "Hogger  and Gammon, sitting in a tree...\n\nnot as such... but forgive the love-in...\n\n"
			.."Hogger is to Alliance and Stormwind as\nGammon is to Horde and Orgrimmar.\n\n"
			.."The NPC we love to bully. For the uninitiated\nI marked the map location"
local ironforgeGuardPatrol = "There's a solitary Ironforge Guard patrolling\n"
							.."the mountain top. Guess you never know\n"
							.."who might need directions.\n\n"
							.."Incredibly, the guard is able to walk\n"
							.."inclines that no other person dare try!"
local jeremiahSeely = "Such a chill place to while away your time!\n\n"
					.."Oh... the matter of Jeremiah. Once upon a time he\n"
					.."sold the \"Tome of the Clear Mind\", which hapless\n"
					.."adventurers like you and I would use to reset our\n"
					.."talents. No wonder it was a best seller!\n\n"
					.."I've a feeling Jeremiah is not so pleased with the\n"
					.."author(s) of the Steamy Romance Novel series!"
local miaMalkova = "((In 2021 Blizz, in response to the very serious\n"
					.."controversies at the time, set about not just\n"
					.."purging well knwon male personalities but also\n"
					.."some in-game window dressing.\n\n"
					.."A lot of innuendo was removed, for example.\n\n"
					.."They missed this one. Or is it too obscure?\n\n"
					.."Mia Malkova is a famous Twitch streamer and\n"
					.."is partnered to Rich Campbell, formerly of\n"
					.."OTK.\n\n"
					.."Her IRL in-game character is also a Nelf.\n\n"
					.."I don't dare talk about OnlyFans, her NSFW\n"
					.."Twitch account or the videos she made before\n"
					.."she retired from that industry.\n\n"
					.."Her bf Rich is worth researching too for his\n"
					.."sudden social silence in December 2022 due to\n"
					.."a very very bad allegation))"
local miaMalkovaTitle = "Goldshire ERP Is Tame (In Comparison)"
local mechanoArachnid = "Might impressive Mechano-\narachnid this!\n\n"
					.."But... where are the owners?\nWhat befell of them?\n\n"
					.."Interestingly... it's identical to the\n"
					.."extra large mechano-tanks at\n"
					.."Crushcog's arsenal and... its\n"
					.."almost all the way to Coldridge\nValley!\n\n"
					.."You think the dwarven recruits\n"
					.."were trying to steal this\ngnomish technology?"
local morgansPlotGlitch = "You've heard of glitching to fall through\n"
						.."the world. Yes, it's all to do with the\n"
						.."famous unfinished crypts below Karazhan.\n\n"
						.."On this occasion we WON'T be glitching.\n\n"
						.."Firstly strip off all your armour you\n"
						.."shameless immodest wretch you!\n\n"
						.."Next aggro and drag some Restless Spirits\n"
						.."from over yonder back here and down the\n"
						.."stairs to the gate below.\n\n"
						.."Stand in the left-most corner and face\n"
						.."the gate, being careful not to auto-\n"
						.."attack the Spirits. Let them kill you.\n\n"
						.."Spirit walk back to here and rez inside\n"
						.."the iron gate. Voilà! Not even a glitch!"
local ollie = "Ollie is one spoilt pug!"
local petrifiedYojamba = "Careful of the basilisk. She scales up and packs a whallop!\n\n"
						.."Oh... and all of those petrified Bloodscalp Shaman and\n"
						.."Scavengers... I guess she permanently petrified them with\n"
						.."her Crystaline Breath.\n\n"
						.."Which figures because when your are taking a S.E.L.F.I.E.\n"
						.."you do need everyone to be standing reeeeeal still now!\n\n"
						.."Yeah she drops a quest item for that blessed selfie camera."
local plugs = "I wonder what these two plugs are plugging?"
local rixaTransport = "Yup! It's an entertaining flight down\n"
					.."to Gol'Bolar Quarry way below!\n\n"
					.."If you are wondering... why...\n"
					.."It's probably because you are able\n"
					.."to get a free flight up to here from\n"
					.."Gol'Bolar and, well, you might not\n"
					.."be able to fly yourself!\n\n"
					.."Alliance only! Horde not welcome!"
local senegal = "The Senegal pet, purchasable from Narkk, is\nthe\n\n"
				.."    \"Favored pet of the goblins of Booty\n"
				.."    Bay, this colorful bird is renowned for\n"
				.."    its ability to count coins, tally budgets,\n"
				.."    and lie about contracts.\"\n\n(Pet Journal)"
local seasonedAV = "The two Alterac Valley explorers are quietly famous.\n\n"
				.."When defeated, they will drop Stormpike Commander's\n"
				.."Flesh which you turn-in when you are running AV!\n\n"
				.."Of course back in the day how would the Horde get\n"
				.."to here easily, given that flying wasn't a thing!"
local secondHighestPeakEK = "The second highest peak in the Eastern Kingdoms.\n\n"
							.."The highest? It's at 2 degrees from here.\n\n"
							.."Oh, erm, you'll need my \"X and Y\" AddOn\n"
							.."which shows degrees as well as coordinates!"
local shadowfangKeep = "Take a look around. Sure looks the same but...\n"
					.."each doorway is boarded up and each alcove\n"
					.."leads to nowhere!"
local shamefulTask = "Flagged for PvP but... taking a hit for the\n"
					.."team and reluctantly, of course, choosing\n"
					.."a rather safe task. Who are you kidding!\n"
					.."Makes all the Horde PvPers look gutless! :D"
local sledCave = "Many have met the sledders but I bet\n"
				.."you didn't know about their cave!"
local sledFall = "Maybe a good place to wait, if you're patient!\n"
				.."You never know what might slide in to view!"
local sledStart = "This is where it all begins!\n\n"
				.."Why can't we join in? Looks fun!"
local stanLee = "Stanley is a homage to Stan Lee, the famous DC and\n"
				.."Marvel comics writer/editor during the Silver Age\n"
				.."of Comics.\n\n"
				.."    \"With great power, comes great responsibility\"\n\n"
				.."As a boy I would be extra excited to see his by-line\n"
				.."on a story - I knew that it would indeed be epic!\n\n"
				.."More personally, all the Silver Age comics sustained\n"
				.."me during my hospitalisations and indeed holding\n"
				.."and reading these comics in bed remains the happiest\n"
				.."of times in my life. I could escape into their worlds!\n\n"
				.."    \"Whosoever holds this hammer, if he be worthy,\n"
				.."    shall possess the power of Thor\"\n\n"
				.."The Stanley we see here is a very good likeness too!\n\n"
				.."In his later years he was famous for cameos in MCU\n"
				.."movies and his appearance here is a cameo too.\n\n"
				.."Your character gets one chance only to witness his\n"
				.."pathing and to see him yell \"Excelsior!\" At the end\n"
				.."of the walk he will despawn forever.\n\n"
				.."    \"Face front, true believers!\"\n\n"
				.."What a fitting tribute!\n\n"
				.."    \"Nuf said\""
local stranglethornAmbience = "Just a really peacful location to level fishing. I can\n"
							.."see the waterfall from here but the sound doesn't\n"
							.."intrude. I can balance my audio ambience and music\n"
							.."how it suits me and just while away the time!"
local theUnknownSoldier = "So many questions. The two Dark Portal guardians. Why?\n\n"
						.."If lucky, the Unknown Soldier warrior will be present,\n"
						.."undead and kneeling at his own tomb.\n\n"
						.."There's a curious carved figure on a pedestal between\n"
						.."the two statues, the meaning of which is mysterious.\n\n"
						.."His armour is \"rare\" and the fact that the tomb is so\n"
						.."grand - it's not just an earthen grave - makes me\n"
						.."think that he was quite important. but... \"unknown\"?\n"
						.."That much doesn't make sense.\n\n"
						.."The location suggests that he died defending\n"
						.."Duskwood from the scourge invasion.\n\n"
						.."When you do kill him... he becomes a vrykul skeleton!\n\n"
						.."By the way his armour is a Lieutenant Commander's\n"
						.."Battlearmor / Grand Marshal's Battlegear combo. In\n"
						.."other words he was a decent (PvP) fighter!"
local wasItWorthTheTrip = "A quaint little grove of orange shrooms...\n\n"
						.."I waited and waited for something to occur.\n"
						.."I mean, you know about the Whispering\n"
						.."Forest in Tirisfal Glades?\n\n"
						.."Alas... nothing happened at all and in the\n"
						.."end I simply enjoyed my shrooms.\n\n"
						.."And that begged the question of was the trip\n"
						.."all the way over to here even worth it?...\n\n"
						.."Yeah! Just love the art for art's sake!"
local welcomeMachine = "The Cataclysm threw up some changes\n"
						.."and good to see that the Hillsbrad\n"
						.."story, which begins here, is so self\n"
						.."aware.\n\n"
						.."Do yourself a favour and complete\n"
						.."this quest!"
local whiteOut = "Sadly, wouldn't be the first plane\n"
				.."to slam into a mountain side"
local yarrr = "((Perfect for International Talk Like A\n"
				.."Pirate Day... or any day for that matter..\n"
				.."is my AddOn called \"Yarrr\" @ Curseforge.\n\n"
				.."Lots of piratey themed random yells!\n\n"
				.."Get it now while stocks last!))"
					
points[ 14 ] = { -- Arathi Highlands
	[77975666] = { name="The Forbidding Sea",
					tip="Yup. An apt name for the\nzone. Yeah... I can see\n"
						.."water everywhere from\nhere. Not" },
	[89477333] = { name="What a Waist of Time!",
					tip="Just love this area. A few critters about\n"
						.."but nothing else really that's \"alive\".\n\n"
						.."Have a look around!\n\n"
						.."Don't hold your breath but... hoping\n"
						.."to have an AddOn to help step you\n"
						.."through that... \"waist of time\"!" },
}
points[ 17 ] = { -- Blasted Lands
	[14491467] = { name="Abandoned Kirin Tor Camp", tip=ebonchill },
	[17382103] = { name="Morgan's Plot Glitch", tip=morgansPlotGlitch },
	[27170144] = { name="Ghostly Trees", tip="The trees look positively tormented!" },
	[33527906] = { name="Was It Worth the Trip?", tip=wasItWorthTheTrip },
	[45448612] = { name="Come, fly right in!", tip=garrod },
}
points[ 36 ] = { -- Burning Steppes
	[02677869] = { name="Jeremiah Seely", tip=jeremiahSeely },
	[03955678] = { name="Hi Ho Hi Ho It's Off to the Expedition We Go...", tip=hiHoHiHo },
	[20292411] = { name="Don't Look Down!", tip=secondHighestPeakEK },
	[34477856] = { name="Plugs", tip=plugs },
}
points[ 42 ] = { -- Deadwind Pass
	[12694048] = { name="Dregoth", tip=dregoth },
	[24038144] = { name="The Slough of Dispair", tip="Let's not quibble about spelling errors\n"
						.."in unfinished areas!\n\nSpeaking of unfinished... this pit is\n"
						.."ready for the meat wagon deliveries!" },
	[25707270] = { name="Mass Burials - Cheaper buy the dozen!", tip="How many stiffs do you\n"
					.."think are in this mound?" },
	[27762902] = { name="Abercrombie and Fitch", tip=abercrombieAndFitch },
	[28378144] = { name="The Upside-down Sinners",
					tip="They are in this pool. I counted 40" },
	[29138132] = { name="The Upside-down Sinners",
					tip="Secret underwater passage here" },
	[31418112] = { name="To The Upside-down Sinners",
					tip="Dive down into this ante-pool" },
	[31592397] = { name="The Unknown Soldier", tip=theUnknownSoldier },
	[32117362] = { name="Doodad Thingumies", tip="Some great names" },
	[33477962] = { name="Mass Burial & Massacres",
					tip="I wonder which massacre is buried here" },
	[33487071] = { name="Forgotten Crypt side-passage",
					tip="Go this way, taking the first right, to descend" },
	[35523522] = { name="It's Hopeless, I'm All tied Up", tip=abandonedHope },
	[35637344] = { name="Pauper's Walk side-passage",
					tip="Go this way, always left, to descend" },
	[35656450] = { name="Abandoned Kirin Tor Camp", tip=ebonchill },
	[36336951] = { name="Pauper's Walk", tip="Too poor for a grave or tomb?\n"
					.."No worries!... We've plenty of\nopen pigeon holes for you!" },
	[36518091] = { name="Tome of the Unrepentant", tip="Spell checking wasn't a thing\n"
													.."for unfinished content" },
	[37757706] = { name="Lucid Nightmare / Puzzler's Desire", tip="On top of the bone pile will be the\n"
					.."\"Puzzler's Desire\" container IF you\nhave completed the arduous \"Lucid\n"
					.."Nightmare\" mount hunt puzzles!" },
	[37777329] = { name="Rez Location is Here", tip="Only possible if you stood where I\n"
												.."told you. Otherwise, rez inside the\n"
												.."first room and drop down into the\n"
												.."\"Well of the Forgotten\" and do\n"
												.."the walkthrough in reverse!" },
	[38617463] = { name="The Pit of Criminals", tip="That's a bigger pile of bones than I saw\n"
					.."in the Auchenai Crypts and Mana Tombs!\n\nIf you look up you will see that we are\n"
					.."at the bottom of a dumping hole. That is\n\n"
					.."the \"Well of the Forgotten\" which is far\nabove!" },
	[39342987] = { name="I Sit Upon the Hill of Shame\nA Shameful Task Chose I", tip=shamefulTask },
	[39887381] = { name="Morgan's Plot Glitch", tip=morgansPlotGlitch },
	[52473432] = { name="Ariden's Camp", tip=aridensCamp },
	[54224511] = { name="Ghostly Trees", tip="The trees look positively tormented!" },
}
points[ 27 ] = { -- Dun Morogh
	[18077480] = { name="High Admiral \"Shelly\" Jorrik <Retiree>",
					tip="From the events of The Burning Crusade, up to the\n"
						.."events of Legion, Jorrik could be found here.\n\n"
						.."He was famous for selling a Blacksmithing \"Solid\n"
						.."Iron Maul\" plan as well as being useful from the\n"
						.."cusp of Exalted and upwards for Bloodsail rep.\n\n"
						.."He's been farmed for the last time and Newman's\n"
						.."Landing, as it was known, is once more deserted.\n\n"
						.."Did you know... Jorrik needed 8+ hours to respawn!\n"
						.."Jorrik was a goblin but he had a gnome voice!" },
	[18337409] = { name="Newmans Landing",
					tip="Apparently new characters would very\n"
						.."briefly spawn here, hence the name.\n\n"
						.."If you look around then it's soon apparent\n"
						.."that Jorrik was running a bootleg still.\n\n"
						.."Initially it was impossible to fish here. Nowadays,\n"
						.."the fish are the same as Dun Morogh inland fish!\n\n"
						.."Up to TBC, if you died here you'd spawn at Sentinel\n"
						.."Hill or at Menethil Harbour. That's some corpse run!\n\n"
						.."Before Wrath this place was an \"Unknown\" zone.\n\n"
						.."If you aggroed Jorrik's guards and then dropped\n"
						.."it, they'd run all the way to Booty Bay and then\n"
						.."return to here. Yup, the round trip took hours!\n\n"
						.."Ultimate Trivia Bonus: See my Wowhead Retail\n"
						.."comment about Jorrik and the amazing way his\n"
						.."Blacksmithing plan's spawn was cycled!!!" },
	[30792567] = { name="Anton and Jermaine, Sitting in a Tree...", tip=antonJermaine },
	[34356115] = { name="Mechano-arachnid", tip=mechanoArachnid },
	[47532937] = { name="Three Minute Pause!", tip=sledFall },
	[57222838] = { name="Return to Mulverick! (Erm... in AV)", tip=seasonedAV },
	[57912395] = { name="Slip Slidin' Away", tip=sledStart },
	[58682192] = { name="Meet Ollie!", tip=ollie },
	[60492040] = { name="Cave Hotel at the Top of the World", tip=sledCave },
	[62211779] = { name="White Out", tip=whiteOut },
	[62622141] = { name="Keep Yer Feet on the Ground!", tip=ironforgeGuardPatrol },
	[64142617] = { name="Glad You Made It!", tip=highPointEK },
	[68690342] = { name="Dwarven Farmland", tip=dwarvenFarm },
	[75931680] = { name="All Aboard!", tip=rixaTransport },
}
points[ 47 ] = { -- Duskwood
	[06042360] = { name="We really do love you Hogger. Kinda...", tip=hogger },
	[06441595] = { name="Here's Looking at You!", tip=gnollTent },
	[09571188] = { name="Here's Looking at You!", tip=gnollTent },
	[19814448] = { name="Grave Moss", tip=graveMoss },
	[73484581] = { name="Dregoth", tip=dregoth },
	[87433521] = { name="Abercrombie and Fitch", tip=abercrombieAndFitch },
	[90983053] = { name="The Unknown Soldier", tip=theUnknownSoldier },
	[94624094] = { name="It's Hopeless, I'm All tied Up", tip=abandonedHope },
	[94746805] = { name="Abandoned Kirin Tor Camp", tip=ebonchill },
	[98153599] = { name="I Sit Upon the Hill of Shame\nA Shameful Task Chose I", tip=shamefulTask },
	[98657667] = { name="Morgan's Plot Glitch", tip=morgansPlotGlitch },
}
points[ 23 ] = { -- Eastern Plaguelands
	[07088583] = { name="Have a Look Around", tip=caerDarrow },
	[88001700] = { name="Outlandish!",
					tip="The reason we can't fly between Ghostlands\n"
						.."and Eastern Plaguelands...\n\n"
						.."((Eversong Woods, Ghostlands, and the Isle\n"
						.."of Quel'Danas were added in TBC. Players\n"
						.."who didn't own the TBC expansion, at the\n"
						.."time, were unable to use these zones.\n\n"
						.."The easy way was to make an instance\n"
						.."portal for gate keeping. The same can be\n"
						.."said for the Draenei starting zones.\n\n"
						.."Unknown to us, the Draenei and Blood Elf\n"
						.."zones are part of an inaccessible and\n"
						.."invisible area of the Outland continent.\n\n"
						.."See it @ Hayven YT 9rFE8HzIijY @9:27))" },
}
points[ 37 ] = { -- Elwynn Forest
	[24939513] = { name="We really do love you Hogger. Kinda...", tip=hogger },
	[25248918] = { name="Here's Looking at You!", tip=gnollTent },
	[27678602] = { name="Here's Looking at You!", tip=gnollTent },
	[40406390] = { name="Four Children", tip=fourChildren },
	[44205330] = { name="The Cat Lady", tip=catLady },
	[46306200] = { name="Children of Goldshire",
					tip="Arguably the most famous easter egg of all\n"
						.."in th Eastern Kingdoms. Be here at 07:00,\n"
						.."upstairs in the house. Follow the children.\n"
						.."At approximately 08:00 they despawn. At\n"
						.."each interval they pause for 10 minutes.\n\n"
						.."Even when the six children are not around\n"
						.."the ambience here is very spooky!\n\n"
						.."The children's names are:  Dana, Aaron,\n"
						.."Cameron, John, Jose, and Lisa.\n\n"
						.."((Named after Blizzard \"Dungeon Dept.\"\n"
						.."staff. Dana, btw, is a man IRL!))" },
	[50251395] = { name="Agee & Tekton",
					tip="So many sheep. Guess Agee is a sheep lover!\n\n"
						.."Oh yeah... Tekton. Hunters can tame that one.\n\n"
						.."If you kill one of the sheep then Agee reacts!\n"
						.."Erm... if you do come a cropper and get blown\n"
						.."off the cliff... it's a long walk back!\n\n"
						.."And the house. No furniture!" },
	[54081680] = { name="Turp, Roo and friends!",
					tip="After listening to Turp's story... who can blame them?" },
	[60053017] = { name="Jeremiah Seely", tip=jeremiahSeely },
	[61211029] = { name="Hi Ho Hi Ho It's Off to the Expedition We Go...", tip=hiHoHiHo },
	[82946330] = { name="Terry Palin - He's a lumberjack, he's okay!",
						tip="I'm a lumberjack\nand I'm okay,\n"
							.."I sleep all night\nand I work all day,\n"
							.."I cut down trees,\nI wear high heels,\n"
							.."Suspendies and a bra,\n"
							.."I wish I'd been a girlie,\n"
							.."Just like my dear pa-pa\n\n"
							.."((Named after Terry Jones and Michael Palin))" },
	[88933005] = { name="Plugs", tip=plugs },
}
points[ 95 ] = { -- Ghostlands
	[12072438] = { name="Moonwells of the Ghostlands",
					tip="The music you hear at this Night Elf\n"
						.."foothold is shared by one other location,\n"
						.."the Temple of the Moon in Darnassus" },
	[13165673] = { questName="The Lady's Necklace", quest=9175,
					tip="The Undead and Humans that occupy\n"
						.."Windrunner Spire have a chance to\n"
						.."drop \"The Lady's Necklace\".\n\n"
						.."You will truly enjoy following this through\n"
						.."to its epic conclusion. A magnificent\n"
						.."visual and auditory treat awaits you!\n\n"
						.."For sake of convenience this should be\n"
						.."your final task in the Ghostlands!" },
	[32525878] = { name="All Hope Abandon Ye",
					tip="...they were certainly abandoned all right.\n\n"
						.."Those responsible for the mass burials here\n"
						.."no doubt had good cause to leave rapidly.\n\n"
						.."Perhaps something from over\nyonder at The Dead Scar?" },
}
points[ 25 ] = { -- Hillsbrad Foothills
	[02725551] = { name="Paint it Pink... Just a Little Bit", tip=sparsePink },
	[03635215] = { name="It's the Same But It Isn't!", tip=shadowfangKeep },
	[90960258] = { name="Have a Look Around", tip=caerDarrow },
}
points[ 48 ] = { -- Loch Modan
	[96943269] = { name=miaMalkovaTitle, tip=miaMalkova },
}
points[ 469 ] = { -- New Tinkertown
	[31190428] = { name="Anton and Jermaine, Sitting in a Tree...", tip=antonJermaine },
	[75501406] = { name="Three Minute Pause!", tip=sledFall },
	[97766999] = { name="Mechano-arachnid", tip=mechanoArachnid },
}
points[ 50 ] = { -- Northern Stranglethorn
	[02221279] = { name="Exit guaranteed! Entrance? Not so much!", tip=deadminesExit },
	[12063055] = { name="Hold real still now and say \"cheese\"...", tip=petrifiedYojamba },
	[13051727] = { name="Exit from Ironclad Cove", tip=defiasGate },
	[17260081] = { name="Here's Looking at You!", tip=gnollTent },
	[19530403] = { name="Here's Looking at You!", tip=gnollTent },
	[20720108] = { name="Here's Looking at You!", tip=gnollTent },
	[23330282] = { name="Here's Looking at You!", tip=gnollTent },
	[74307900] = { name="Stranglethorn Ambience & Fishing", tip=stranglethornAmbience },
	[87170293] = { name="Morgan's Plot Glitch", tip=morgansPlotGlitch },
}
points[ 425 ] = { -- Northshire
	[19229327] = { name="The Cat Lady", tip=catLady },
	[76001040] = { name="Jeremiah Seely", tip=jeremiahSeely },
}
points[ 49 ] = { -- Redridge
	[02800704] = { name="Plugs", tip=plugs },
	[27974819] = { name="Plugs", tip="Suppose this is where all the kids hang out to go fishin' I guess!" },
}
points[ 32 ] = { -- Searing Gorge
	[35019356] = { name="Don't Look Down!", tip=secondHighestPeakEK },
}
points[ 21 ] = { -- Silverpine Forest
	[37344415] = { name="May I Have a Water Totem Please?",
					tip="A long, long time ago certain classes\n"
						.."had to run around a bit to earn certain\n"
						.."abilities, even a special mount!\n\n"
						.."Nowadays we are much more entitled and\n"
						.."Tiev here, for example, no longer has any\n"
						.."relevance.\n\n"
						.."Fondly (?) remembered by Horde Shaman!" },
	[41257089] = { name="Paint it Pink... Just a Little Bit", tip=sparsePink },
	[42306700] = { name="It's the Same But It Isn't!", tip=shadowfangKeep },
}
points[ 84 ] = { -- Stormwind
	[42807640] = { item=134831, npc=130828,
					tip="Gordon Mackellar - Toy Boy\n\n"
						.."He's inside the Pyrotechnics shop.\n\n" ..doomsayersRobes
						.."\n\nWait, there's bonus trivia!!!\n\n"
						.."You might not be in to toys. That's okay!\n\n"
						.."Go there anyhow to see the crazy way he\n"
						.."moves between the barrels of fireworks!\n\n"
						.."Yup, he's doing that in the air, not water!" },
	[50055283] = { name="Lord Krazore", tip="An enigma! This grandly titled Dark Iron Dwarf\n"
											.."appeared at the start of \"Dragonflight\". He's\n"
											.."patrolling around the front of the Cathedral.\n"
											.."Why did he suddenly arrive in Stormwind?\n"
											.."Nobody knows! Others have likewise popped\n"
											.."up in several locations across Azeroth!" },
	[55595592] = { name="Real names. For real!",
					tip= "Kneeling at the impressive fountain tribute\n"
						.."to the great Uther the Lightbringer, is Terran\n"
						.."Gregory and standing beside him is Deva\n"
						.."Marie in a long white wedding dress.\n\n"
						.."For his part, Terran is wearing the Tier 2\n"
						.."Paladin Judgement set. Doesn't it look\n"
						.."magnificent!\n\n"
						.."((Terran works as a Cinematic Narrative\n"
						.."Director for WoW and Deva is his wife. The\n"
						.."only husband/wife in-game tribute? And their\n"
						.."real names were used too - extremely rare!\n\n"
						.."Oh yeah the middle name \"Justice\" is real too!\n\n"
						.."Wait... there's more! His mum and dad, Judy\n"
						.."and David Gregory, are walking around nearby.\n"
						.."He sure got the full family tribute treatment!))" },
	[52796231] = { name="The Secret Garden", tip="A charming little secluded garden\n\n((Added some time around Cata iirc))" },
	[63504757] = { name="Cut-Throat Alley", tip="By foot you'll enter The Shady Lady inn from the canals.\n\n"
												.."Eclectic decor for sure! Quincy has a couple of items\n"
												.."you may not have yet collected. Definitely a hang-out\n"
												.."for shady Gilnean archaeology and relic traders!\n\n"
												.."Step out the back and welcome to Cut-Throat Alley!\n"
												.."Aside from the Stormwind rats there's an empty\n"
												.."house at one end, with a canopy bed upstairs too!\n\n"
												.."By the way, take a closer look at Quincy. Unusually,\n"
												.."he's only wearing torn shorts and not long pants!" },
	[63806160] = { name="Farrah Facet", tip="A homage to the late Farrah Fawcet,\n"
											.."a really popular actress of her time" },
	[81702840] = { name="Crithto - Too Cute to Kill!?",
					tip="((Named after a former WoW community team\n"
						.."member.))\n\n"
						.."The perky pug can usually be found scampering\n"
						.."around the Palace garden although the pathing\n"
						.."is much more complex than that.\n\n"
						.."Killing it yields 54g, a couple of items to make\n"
						.."you feel real guilty!" },
 	[84322590] = { name="Excelsior!", tip=stanLee },
}

points[ 224 ] = { -- Stranglethorn Vale
	[20210919] = { name="Exit guaranteed! Entrance? Not so much!", tip=deadminesExit },
	[26372031] = { name="Hold real still now and say \"cheese\"...", tip=petrifiedYojamba },
	[26991200] = { name="Exit from Ironclad Cove", tip=defiasGate },
	[29620170] = { name="Here's Looking at You!", tip=gnollTent },
	[31050371] = { name="Here's Looking at You!", tip=gnollTent },
	[31790187] = { name="Here's Looking at You!", tip=gnollTent },
	[33420296] = { name="Here's Looking at You!", tip=gnollTent },
	[33867270] = { name="Religiously Worshipping Money", tip=christ },
	[34607382] = { name="Black Ice - A VISIBLE Ring", tip=blackIce },
	[35957652] = { name="Arrrrgh It's a Pirate's Life!", tip=yarrr },
	[37467779] = { name="A Pirate Shanty", tip=broadsideBetty },
	[38947715] = { name="Beware of Parrot Poop on Your Shoulder", tip=senegal },
	[65335061] = { name="Stranglethorn Ambience & Fishing", tip=stranglethornAmbience },
	[73370303] = { name="Morgan's Plot Glitch", tip=morgansPlotGlitch },
	[82393546] = { name="Was It Worth the Trip?", tip=wasItWorthTheTrip },
	[89063940] = { name="Come, fly right in!", tip=garrod },
}
points[ 51 ] = { -- Swamp of Sorrows
	[02555400] = { name="Ariden's Camp", tip=aridensCamp },
	[04296474] = { name="Ghostly Trees", tip="The trees look positively tormented!" },
	[73680928] = { name="Beach Party Tonight!",
					tip="We got an early start\nWe're gonna have a ball\n"
						.."We're gonna ride the surf\nAnd that ain't all\n" 
						.."Nothin' is greater than the sand, surfing, salt air\n"
						.."Unrack our boards just as soon as we get there\n"
						.."Stack 'em in the sand while they're breaking just right\n"
						.."Yea we're surfin' all day and swingin' all night\n"
						.."Vacation is here - Beach Party tonight!\n\n"
						.."((Annette Funicello and Frankie Avalon, 1963))" },
}
points[ 210 ] = { -- The Cape of Stranglethorn
	[34216171] = { name="Religiously Worshipping Money", tip=christ },
	[35446358] = { name="Black Ice - A VISIBLE Ring", tip=blackIce },
	[37686807] = { name="Arrrrgh It's a Pirate's Life!", tip=yarrr },
	[40187017] = { name="A Pirate Shanty", tip=broadsideBetty },
	[42646910] = { name="Beware of Parrot Poop on Your Shoulder", tip=senegal },
	[86472504] = { name="Stranglethorn Ambience & Fishing", tip=stranglethornAmbience },
}
points[ 26 ] = { -- The Hinterlands
	[25920270] = { name="Have a Look Around", tip=caerDarrow },
}
points[ 18 ] = { -- Tirisfal Glades
	[14565256] = { name="Somthing's Fishy!",
					tip="A gnome skeleton with a dagger between the ribs.\n\n"
					.."A well prepared / provisioned fishing setup. Related\n"
					.."to the crashed plane? I think not." },
	[15425612] = { name="So Many Bubbles!", tip=artifactWeapons, },
	[17576753] = { name="Whispering Forest",
					tip="The best easter egg?\n\n"
					.."You must come here. Stand in the middle.\n"
					.."Wait. Seven Fey-Drunk Darters will spawn.\n\n"
					.."More happens. 15 minute cycle. Patience!" },
	[17945531] = { name="Gnomish Engineering",
					tip="Dive down and have a look around!\n\nDid the pilot survive?" },
	[21296181] = { name="Beneath Western Tirisfal Glades",
					tip="For years now there has been speculation about\n"
					.."the evil which lurks beneath Tirisfal Glades.\n\n"
					.."Not an old-God, according to a reliable source.\n\n"
					.."But then how reliable are sources? History / \n"
					.."facts are a product of the eye of the beholder!" },
	[30682827] = { name="I Took a Hit For the Team",
					tip="Flew out here. Hoping to find something cool.\n"
						.."Absolutely nothing. Better me than you I guess...\n\n"
						.."Still... appreciate the thistles they textured in\n"
						.."here. For people such as me I suppose" },
	[49305640] = { name="Real Live Skeleton Fish!",
					tip="Pop your head in the water and look around.\n\n"
						.."Yeah, those skeleton fish seem alive enough to me!" },
}
points[ 20 ] = { -- Tirisfal Glades - Keeper's Rest - Tomb of Tyr
	[37461241] = { name="So Many Bubbles!", tip=artifactWeapons, },
}
points[ 241 ] = { -- Twilight Highlands
	[42318344] = { name=miaMalkovaTitle, tip=miaMalkova },
	[73721657] = { name="You First!", tip="Another fresh body. Why so many?" },
	[73981897] = { name="She said it was 65 yards!", tip="Another aged goblin. What happens at The\n"
										.."Krazzworks when your productivity slows?" },
	[74631372] = { name="Come on Down!", tip="She probably died quite recently too.\n"
										.."Pushed, fell, jumped? You be the judge!" },
	[76132000] = { name="It's a Long Way to the Top", tip="How does one \"retire\" from The\n"
														.."Krazzworks. Compulsory at a certain age?" },
	[76401275] = { name="Time to Go!", tip="So many dead workers, aged and... dead.\n"
												.."Is parricide a thing at The Krazzworks?" },
	[78411391] = { name="OH&S Meeting Today!", tip="How do management deal with OH&S issues?\n"
												.."Did the worker representatives all \"fall\"?" },
	[79602083] = { name="This will be the best selfie!", tip="The only young \"victim\". The others\n"
															.."are all aged. A red herring to throw\n"
															.."us off the scent? Was she investigating\n"
															.."the sad demise of the others?" },
	[79961598] = { name="Your Number's Up!", tip="Interestingly the bodies are mostly of a\n"
										.."similar age. A pact ritual or ritual culling?" },
}
points[ 22 ] = { -- Western Plaguelands
	[69526869] = { name="Have a Look Around", tip=caerDarrow },
}
points[ 52 ] = { -- Westfall
	[38978427] = { name="Exit guaranteed! Entrance? Not so much!", tip=deadminesExit },
	[51668952] = { name="Exit from Ironclad Cove", tip=defiasGate },
	[56597024] = { name="Here's Looking at You!", tip=gnollTent },
	[59257401] = { name="Here's Looking at You!", tip=gnollTent },
	[60647055] = { name="Here's Looking at You!", tip=gnollTent },
	[63707260] = { name="Here's Looking at You!", tip=gnollTent },
	[67043178] = { name="We really do love you Hogger. Kinda...", tip=hogger },
	[67352587] = { name="Here's Looking at You!", tip=gnollTent },
	[69762274] = { name="Here's Looking at You!", tip=gnollTent },
	[77664789] = { name="Grave Moss", tip=graveMoss },
	[82360076] = { name="Four Children", tip=fourChildren },
}
points[ 56 ] = { -- Wetlands
	[06679870] = { name="Return to Mulverick! (Erm... in AV)", tip=seasonedAV },
	[07489345] = { name="Slip Slidin' Away", tip=sledStart },
	[08409104] = { name="Meet Ollie!", tip=ollie },
	[10538924] = { name="Cave Hotel at the Top of the World", tip=sledCave },
	[12578615] = { name="White Out", tip=whiteOut },
	[13059044] = { name="Keep Yer Feet on the Ground!", tip=ironforgeGuardPatrol },
	[14869607] = { name="Glad You Made It!", tip=highPointEK },
	[20256912] = { name="Dwarven Farmland", tip=dwarvenFarm },
	[28828498] = { name="All Aboard!", tip=rixaTransport },
}

--=======================================================================================================
--
-- KALIMDOR
--
--=======================================================================================================

local benched = "A lonesome bench on the border.\n\n"
				.."To one side barren and cold.\n"
				.."And on the other lush, green.\n"
				.."The horizon to the left... Teldrassil.\n\n"
				.."Perhaps. Depends really on your\n"
				.."standing with Zidormi in Darkshore\n"
				.."I'd suppose.\n\n"
				.."Don't look down... scary!"
local bioshock = "Wait a moment... Big Papa, not \"Daddy\"\n"
				.."and Andrew Ryan is \"Anderov Ryon\".\n"
				.."Well that doesn't matter because I can\n"
				.."see little Alice there... and we love\n"
				.."the little sisters of Bioshock...\n\n"
				.."Wait there's more! Some dialogue too!"
local boatAndSkulls = "Okay... a mysterious boat in a lake...\n\n"
					.."A couple of mysterious skulls and no\n"
					.."sign of whomever owned the boat...\n\n"
					.."Dive below the surface... very spooky!\n\n"
					.."Air bubbles as well? What the...!"
local camelBoast = "Yeah... probably a humble boast...\n\n"
				.."This is where you get dumped when the\n"
				.."swirling tornado from the Mysterious\n"
				.."Camel Figurine whisks you away to your\n"
				.."destiny in Feralas.\n\n"
				.."((Oh did I say already that I have an\n"
				.."AddOn too for farming the Figurine? It's\n"
				.."called \"HandyNotes - Camel\" of course!))"
local canoe = "I love the location and especially\n"
			.."the placement of this canoe. Perfect!"
local cultivation = "With your Tauren \"cultivation\" racial\n"
					.."bonus you'll have plenty of \"buffalo\"\n"
					.."to place in this here \"peace\" pipe"
local dadanga = "Prior to that questionable \"Cataclysm\"...\n"
				.."there lived an ancient kodo named\n"
				.."\"Dadanga\".\n\n"
				.."She was a harmless but hungry old girl.\n"
				.."You could bring her Bloodpetal Sprouts,\n"
				.."15 each time, and she would reward you\n"
				.."with a box of consumables and, if you\n"
				.."were lucky, the excellent Elixir of\n"
				.."Brute Force recipe.\n\n"
				.."Here now lies her grave, and there's a\n"
				.."one time reward for laying Bloodpetal\n"
				.."Sprouts on her grave.\n\n"
				.."R.I.P. Dadanga, needlessly killed off!\n\n"
				.."((Dodongo from the Zelda universe.\n"
				.."Link(en) was here too. In fact this\n"
				.."sub-zone had numerous references!))"
local dangui = "Geenia is the only vendor of the \"Formal\n"
				.." Dangui\" and it's only rarely stocked.\n\n"
				.."It's worth a look see if flying past.\n\n"
				.."Might fetch a million on the AH as it's\n"
				.."prized by collectors and RPers alike!"
local danguiTitle = "Formally Rare"
local dartingHatchling = "A set of easy to acquire and oh so\n"
						.."adorable raptor hatchling pets is\n"
						.."available - you just need to know\n"
						.."where to look!\n\n"
						.."The Darting hatchling is arguably\n"
						.."the easiest to acquire and it's\n"
						.."around here in a nest!\n\n"
						.."((I have a dedicated AddOn for\n"
						.."obtaining four of these pets. It's\n"
						.."HandyNotes - Adorable Raptor\n"
						.."Hatchlings @ Curseforge. Enjoy!))"
local diedAlone = "What strange fate caused this person\n"
				.."to die a lonely death?\n\n"
				.."Nearby a hut, three carefully dug and\n"
				.."marked graves...\n\n"
				.."But why come to here and with a\n"
				.."scoped rifle to end it all?"
local digRat = "Sigh. So you killed the Dig Rat critter and\n"
				.."finally you scored a Plump Dig Rat? Great!\n\n"
				.."But what's that... it just gets consumed?\n\n"
				.."Sigh. Read. The. Item. Text.\n\n"
				.."(1) Setup a cooking fire. (2) Use it.\n\n"
				.."You're welcome! Recipe learnt!"
local digRatTitle = "Adiposity-Based Chronic Disease Dig Rat\n"
					.."Erm... Sub-Prime Dimensioned Dig Rat\n"
					.."Oh, ah... Delightfully Rubenesque Dig Rat"
local donQuijote = "Maximillian of Northshire...\n\n"
					.."As little as possible needs to be said about\n"
					.."this incorrigible fop, for fear of spoiling\n"
					.."arguably the funniest quest chain this side\n"
					.."of Johnny Awesome's twinked bear ass"
local donQuijoteTitle = "Of Sancho Panza, Dulcinea... and Maximillian"
local doubleCompanions = "Within Azeroth we know that sometimes\n"
						.."a mob might, if we are really lucky, drop\n"
						.."a cool companion / pet.\n\n"
						.."The Noxious Whelps in Feralas have a\n"
						.."chance to drop TWO companions!\n\n"
						.."The gorgeous Sprite Darter (egg) and the\n"
						.."adorable Emerald Whelpling.\n\n"
						.."At 1 in 10,000 and 1 in 1,000 respectively\n"
						.."it ain't going to be easy though!\n\n"
						.."Wait, there's more! Technically, THREE\n"
						.."pets as the \"OOX-22/FE Distress Beacon\"\n"
						.."leads to the Mechanical Chicken and it has\n"
						.."a 1 in 500 drop chance too!"
local drazzilb = "One step forward is\n"
				.."two steps backward,\n"
				.."Say it anyway but\n"
				.."It's always awkward"
local fallaSagewind = "There can't be too many Tauren who are\n"
			.."friendly to both Horde and Alliance!\n\n"
			.."Prior to The Cataclysm she was part of a\n"
			.."quest chain, arising from your adventures\n"
			.."within the Wailing Caverns (below).\n\n"
			.."She'd send you to Hamuul Runetotem in\n"
			.."Thunderbluff or Mathrengyl Bearwalker\n"
			.."in Darnassus...\n\n"
			.."They would look at the \"Nightmare Shard\"\n"
			.."you had delivered and then pronounce...\n"
			.."\"This shard holds great secrets; it is the\n"
			.."pure essence of the Emerald Dream.\n"
			.."However, what I see in this shard is not\n"
			.."a dream; one would call this sort of a\n"
			.."vision a nightmare\".\n\n"
			.."((As this quest chain was removed from\n"
			.."WoW then it's safe to say that these\n"
			.."remarks are no longer canon!))"
local feralas = "Map sub-zone text says we are in Feralas.\n"
				.."The music checks. The ambience checks.\n\n"
				.."One small detail though...\n\n"
				.."We ain't in Feralas!"
local bbqFish = "Just for fun, while researching my\n"
				.."Cod Do Batter fishing AddOn...\n\n"
				.."(shameless self promotion lol)\n\n"
				.."I thought I'd chance my arm...\n\n"
				.."Result was mostly junk, some\n"
				.."coal and a few Volatile Fire and\n"
				.."several Melted Cleavers worth\n"
				.."about 14 gold each!"
local bbqFishTitle = "Great Place for a BBQ!"
local gloomWeed = "You can appreciate why Tauren are\n"
				.."so chill and high up on these mesa.\n\n"
				.."By all reports they pack the best\n"
				.."Tirisfal Glades Gloom Weed into the\n"
				.."pipe, hence the acrid red fumes.\n\n"
				.."Do as a famous leader once\n"
				.."advised... Don't inhale!"
local hastenExtinction = "Prince Lakma, The Last Chimaerok\n"
						.."patrols through here. The last\n"
						.."of his kind. So sad.\n\n"
						.."Go on! You know you wanna do it!\n\n"
						.."In for the kill! The very last one!\n\n"
						.."Maybe some chimaerok tenderloin\n"
						.."will drop too! Nice!\n\n"
						.."Only problem is that when that\n"
						.."Cataclysm happened the recipe\n"
						.."disappeared. It's useless meat!\n\n"
						.."Doesn't it feel so good?"
local hawkwind = "In this \"space\" on the \"rock\" is\n"
				.."Grull Hawkwind!\n\n"
				.."In the Hall of the Mountain Grill you'll\n"
				.."come across Astounding Sounds,\n"
				.."Amazing Music. Is it already 25 Years\n"
				.."On since this Warrior on the Edge of\n"
				.."Time went In Search of Space?\n\n"
				.."You'll not find an Electric Tepee here\n"
				.."or in Thunder Bluff or Distant Horizons.\n\n"
				.."And when Hawkwind goes Into The\n"
				.."Woods we know one thing: The Future\n"
				.."Never Waits so Take Me to Your Future!"
local hyjalHeights = "Hyjal is already mightily elevated,\n"
					.."so who'd have expected this pesky\n"
					.."peak to be in the way?\n\n"
					.."At least the hapless pilot can be\n"
					.."remembered for discovering the\n"
					.."tallest point in Hyjal!"
local hyjalHeightsTitle = "Dang! Who Put That There?"				
local justTheTip = "((In November 2021 Blizzard, in order to\n"
				.."quieten public sentiment over a scandal,\n"
				.."decided to \"clean up\" parts of the game\n"
				.."(as well as other actions).\n\n"
				.."A couple of quests involving Harrison\n"
				.."Ford were cleansed of overt innuendo.\n\n"
				.."Previously, taken as a whole, the quest\n"
				.."titles alluded to a teenage \"first\n"
				.."experiment\" ;) cliche.\n\n"
				.."With the renamings of \"Just the Tip\"\n"
				.."to \"A Strange Disc\" and \"Premature\n"
				.."Explosionation\" to \"Exploding\n"
				.."Through\", the innuendo within the\n"
				.."quest chain was effectively disarmed))"
local justTheTipTitle = "Just the Tip. Promise.\nSee How it Feels..."
local korkronLoot = "Okay... so you're new to Azeroth and\n"
					.."somewhat povo? I get that... you don't\n"
					.."have the gold to throw around. Taraezor\n"
					.."to the rescue!\n\n"
					.."The Kor'kron mobs here can drop a cool\n"
					.."24 slot \"Kor'kron Supply Satchel\" and\n"
					.."an incredible three-headed hydra pet,\n"
					.."Gahz'rooki.\n\n"
					.."The bad news: 1 in 250 and 1 in 1,000\n"
					.."drop chances respectively"
local lakeDumont = "Well that's what I call the island!!!\n\n"
				.."Seems the sole purpose of all these NPCs\n"
				.."is to recognise Blizzard employees who\n"
				.."contributed in some way!\n\n"
				.."Could the fire inside the ruins be a\n"
				.."pyre for, erm, less celebrated ex-staff?"
local marioLuigi = "Two towers... Muigin in one, Larion\n"
				.."in the other. Look closely at what\n"
				.."they are wearing!\n\n"
				.."Now, swap the \"L\" and \"M\".\n"
				.."Got it yet? No?\n"
				.."Okay... drop the \"n\" too!\n\n"
				.."Prior to the Cataclysm, adventurers\n"
				.."reported that they would hit for 64\n"
				.."damage.\n\n"
				.."((Did you nintendo that amount, Blizzard?))"
local natPagle = "...from the journals of Taraezor...\n\n"
				.."Found him long ago on a small island off Theramore.\n\n"
				.."I can still picture him now. Alone with his mates.\n"
				.."That's Jack and Jim and Johnnie. Not to mention\n"
				.."Jamieson and Glen. And this wild dude who was a\n"
				.."real turkey.\n\n"
				.."I tell you bud, I'm wiser for the stories he told.\n\n"
				.."And forever grateful for the Nat's Lucky Fishing\n"
				.."Pole he gifted me.\n\n"
				.."A solitary man, a solitary existence..."
local natsLuckyFishingPole = "You'll need 225+ Classic Fishing (i.e.\n"
							.."\"Expert Fisherman\") and your level\n"
							.."must be at the Chromie Time minimum\n"
							.."for Dustwallow Marsh.\n\n"
							.."Reward is an excellent fishing pole\n"
							.."and it goes real well with my HandyNotes\n"
							.."\"Let Minnow\" AddOn @ Curseforge!"
local polyTurtle = "This one is just for disciples of\n"
					.."Khadgar. Mages in other words!\n\n"
					.."Fishing in any Cata zone SCHOOL\n"
					.."can potentially reward the turtle\n"
					.."polymorph!\n\n"
					.."Low drop rate though... but anyone\n"
					.."can receive it. You'll find it on the\n"
					.."AH no doubt!"
local ringo = "What would you think if I sang out of tune?\n"
			.."Would you stand up and walk out on me?\n"
			.."Lend me your ears and I'll sing you a song\n"
			.."And I'll try not to sing out of key\n"
			.."...Oh, I get by with a little help from my friends\n\n"
			.."(Ringo may or may not be in the cave)"
local rugAndCandles = "The prayer rug was laid down and\n"
					.."the candles, one by one, are being\n"
					.."lit. The circle of candles was\n"
					.."almost complete and then?\n\n"
					.."Argh! Don't leave us hanging!\n"
					.."Misfortune befell the owner of the\n"
					.."rug? Snapped away suddenly by...?"
local silenceOfTheLambs = "Go underneath to The Pools of Vision.\n\n"
						.."Clarice Foster pats through here...\n\n"
						.."Her doppelganger Jodie Starling\n"
						.."has never been found"
local stranded = "Oh so sad to see this.\n\n"
				.."You'll notice some others around.\n\n"
				.."Let's start a Tortoise Rescue!"
local threeArtOnRock = "Love the \"prehistoric\" style rock art.\n\n"
					.."Who painted it? Why hasn't it weathered?\n\n"
					.."A sign from the Old Gods? Perhaps a prank!"
local unusedBFA = "This cave and the hut above it were originally\n"
				.."a part of a Warfront story for the Battle for\n"
				.."Azeroth.\n\n"
				.."Sadly, this never happened.\n\n"
				.."By the way... stand here and listen to the\n"
				.."music (you need \"Ambience\" turned up)"
local viciousGiants = "Hang around a bit... these cute\n"
					.."critters are not so cute!\n\n"
					.."They seem to randomlt transform\n"
					.."into vicious, bloodthirsty giant\n"
					.."versions of themselves!"
local warningHash = "Do not toke on this pipe or you'll\n"
					.."make a hash of your gaming sess!"
local whatYouSmoking = "Something to mull over...\n\n"
					.."Whatever they are smoking,\n"
					.."those noxious looking red\n"
					.."fumes look positively foul!"
local whereIsEverybody = "Camp fire... check!\n"
						.."Seats... check!\n"
						.."Stash of stuff... check!\n"
						.."Cushion, firewood...\n\n"
						.."Okay... so where are you all?"
local zangenStonehoof = "Every night at 21:00 ((server time))\n"
						.."Zangen Stonehoof gives a short\n"
						.."speech and lights the bonfire!"

points[ 63 ] = { -- Ashenvale
	[00784614] = { name="Come Out, Come Out, Wherever You Are...", tip=whereIsEverybody },
	[12049525] = { name="Cultivating Stoned Talon Mountains", tip=cultivation },
	[21598965] = { name="Shocking Big Daddy Bio!", tip=bioshock },
	[24327458] = { name="Died Alone", tip=diedAlone },
	[47439236] = { name="What You Smoking?", tip=whatYouSmoking },
	[51168508] = { name="A Simple Canoe", tip=canoe },
	[83261380] = { name=bbqFishTitle, tip=bbqFish }, 
}
points[ 76 ] = { -- Azshara
	[07740686] = { name=hyjalHeightsTitle, tip=hyjalHeights }, 
}
points[ 462 ] = { -- Camp Narache
	[39453726] = { name="Quark, Strangeness and Charm", tip=hawkwind },
}
points[ 62 ] = { -- Darkshore
	[86600551] = { name=danguiTitle, tip=dangui },
	[87751911] = { name="Candles and Rug", tip=rugAndCandles },
	[94649467] = { name=bbqFishTitle, tip=bbqFish }, 
}
points[ 66 ] = { -- Desolace
	[87042785] = { name="Vicious Giants", tip=viciousGiants },
	[89354944] = { name="Silence of the Lambs", tip=silenceOfTheLambs },
	[90582690] = { name="Ancient Art?", tip=threeArtOnRock },
	[91935221] = { name="Surgeon General Says...", tip=warningHash },
	[95435537] = { name="Honoured Ancestors", tip=zangenStonehoof },
	[96705343] = { name="Advice to Mull Over", tip=gloomWeed },
}
points[ 1 ] = { -- Durotar
	[05626838] = { name="The Emerald Dream is Fake!", tip=fallaSagewind },
	[06125383] = { name="Did You See the Three-Headed Hydra?", tip=korkronLoot },
}
points[ 70 ] = { -- Dustwallow Marsh
	[23226046] = { name=digRatTitle, tip=digRat },
	[28399352] = { name="Stranded!", tip=stranded },
	[37153309] = { name="What's in a Name?", tip=drazzilb },
	[47841667] = { name="Awww They're So Cute!", tip=dartingHatchling },
	[58076065] = { name="Nat Pagle", tip=natPagle },
	[58766017] = { quest=6607, questName="Nat Pagle, Angler Extreme", tip=natsLuckyFishingPole },
}
points[ 77 ] = { -- Felwood
	[80817658] = { name=bbqFishTitle, tip=bbqFish }, 
	[92335217] = { name=hyjalHeightsTitle, tip=hyjalHeights }, 
}
points[ 69 ] = { -- Feralas
	[29007700] = { name="Isle of Dread",
					tip="The Sub-zone text remains but the island\n"
						.."disappeared with the dubious events of\n"
						.."the Cataclysm.\n\n" 
						.."The island was populated by a host of\n"
						.."high level chimaera, aka chimaerok.\n\n"
						.."Killing these was a means to obtaining\n"
						.."a quest reward: The epic recipe \"Dirge's\n"
						.."Kickin' Chimaerok Chops\". Prior to BFA\n"
						.."this was the most powerful food.\n\n"
						.."With Cataclysm the recipe disappeared\n"
						.."forever, along with the chimaerok.\n\n"
						.."The leader of the chimarea was Lord\n"
						.."Lakmaeran. His presumed son, Prince\n"
						.."Lakma can be found to the east on the\n"
						.."mainland" },
	[47937663] = { name="Hasten the Extinction!", tip=hastenExtinction },
	[47961049] = { name="Luvin' the Odds!", tip=doubleCompanions },
	[62400768] = { name="Boat and Bubbles!", tip=boatAndSkulls },
	[63991141] = { name="Tribute Island", tip=lakeDumont },
	[66537244] = { name="Will that be one hump or two?", tip=camelBoast },
	[68697306] = { name="Twinks and Bears Come Together",
					tip="Johnny Awesome is the gift that never stops\n"
						.."giving, beginning with the Old Spice after-\n"
						.."shave reference (\"look at me\")...\n\n"
						.."In Hillsbrad we found him, sparkling with his\n"
						.."twinked out gear and telling us of his fondness\n"
						.."for bear ass.\n\n"
						.."Twinks and Bears. A heavenly match for sure,\n"
						.."even allowing for the Warden in Hillsbrad\n"
						.."calling her \"Jenny\".\n\n"
						.."Blood elves - they ARE so pretty, just look at\n"
						.."that gorgeous hair and those lithe limbs!\n\n"
						.."So we find him here, surrounded by Awesimps,\n"
						.."indulging in a bit of R&R.\n\n"
						.."Is this the same Awesome to whom Lydon in\n"
						.."Hillsbrad offered a dolly?\n\n"
						.."Oh and those insects buzzing around him...\n"
						.."needs some more Old Spice does our Johnny!"},
	[69627455] = { name="Cut Content",
					tip="((This whole area was intended to be part\n"
						.."of the Patch 4.1 storyline, specifically\n"
						.."the Twilight Hammer's attempt to invade\n"
						.."the elemental plane of water, aka The\n"
						.."Abyssal Maw storyline.\n\n"
						.."You can see the cut content on Wowpedia.\n"
						.."Uninspiring quests. Best decision ever:\n"
						.."Cut the woeful quests and keep the NPCs!))" },
	[70767356] = { name="Get the @$#&ing hell outa my kitchen!",
					tip="He doesn't swear and sadly he does not sell\n"
						.."recipes. Nor does he insult you for lacking\n"
						.."skill at cooking.\n\n"
						.."And here he is... a fallen chef... doing nothing\n"
						.."more than chopping water melons and mixing\n"
						.."fruit punch" },
	[84971401] = { name="Quark, Strangeness and Charm", tip=hawkwind },
	[94838183] = { name="Vale Dadanga", quest=24702, questName="Here Lies Dadanga", tip=dadanga },
}
points[ 80 ] = { -- Moonglade
	[52003289] = { name=danguiTitle, tip=dangui }, 
	[55217097] = { name="Candles and Rug", tip=rugAndCandles },
	[64630996] = { name="Bench With a View", tip=benched },
}
points[ 198 ] = { -- Mount Hyjal
	[51167253] = { name=bbqFishTitle, tip=bbqFish }, 
	[67613768] = { name=hyjalHeightsTitle, tip=hyjalHeights }, 
}
points[ 7 ] = { -- Mulgore
	[01767388] = { name="Luvin' the Odds!", tip=doubleCompanions },
	[20177028] = { name="Boat and Bubbles!", tip=boatAndSkulls },
	[22197504] = { name="Tribute Island", tip=lakeDumont },
	[34570589] = { name="Vicious Giants", tip=viciousGiants },
	[36482371] = { name="Silence of the Lambs", tip=silenceOfTheLambs },
	[37490511] = { name="Ancient Art?", tip=threeArtOnRock },
	[38602599] = { name="Surgeon General Says...", tip=warningHash },
	[41492860] = { name="Honoured Ancestors", tip=zangenStonehoof },
	[42542700] = { name="Advice to Mull Over", tip=gloomWeed },
	[48957835] = { name="Quark, Strangeness and Charm", tip=hawkwind },
	[60971624] = { name="Ancient Art?", tip=threeArtOnRock },
	[61991753] = { name="Redrock Cave and Hut", tip=unusedBFA },
	[62942399] = { name="Ancient Art?", tip=threeArtOnRock },
	[94128319] = { name="What's in a Name?", tip=drazzilb },
}
points[ 10 ] = { -- Northern Barrens
	[00715650] = { name="Ancient Art?", tip=threeArtOnRock },
	[01777631] = { name="Surgeon General Says...", tip=warningHash },
	[04517878] = { name="Honoured Ancestors", tip=zangenStonehoof },
	[05507726] = { name="Advice to Mull Over", tip=gloomWeed },
	[21531795] = { name="What You Smoking?", tip=whatYouSmoking },
	[22996706] = { name="Ancient Art?", tip=threeArtOnRock },
	[23966828] = { name="Redrock Cave and Hut", tip=unusedBFA },
	[24867441] = { name="Ancient Art?", tip=threeArtOnRock },
	[25281064] = { name="A Simple Canoe", tip=canoe },
	[42856297] = { name="The Emerald Dream is Fake!", tip=fallaSagewind },
	[43304959] = { name="Did You See the Three-Headed Hydra?", tip=korkronLoot },
}
points[ 85 ] = { -- Orgrimmar
	[50845509] = { item=134831, npc=130911,
					tip="Charles Gastly - Toy Boy\n\n" ..doomsayersRobes },
}
points[ 81 ] = { -- Silithus
	[12525232] = { name="Welcome to Feralas!", tip=feralas },
	[21510163] = { name="Hasten the Extinction!", tip=hastenExtinction },
	[88285007] = { name=donQuijoteTitle, quest=24707, tip=donQuijote,
					questName="The Ballad of Maximillian" },
}
points[ 199 ] = { -- Southern Barrens
	[03395922] = { name="Boat and Bubbles!", tip=boatAndSkulls },
	[04886272] = { name="Tribute Island", tip=lakeDumont },
	[13981188] = { name="Vicious Giants", tip=viciousGiants },
	[15382498] = { name="Silence of the Lambs", tip=silenceOfTheLambs },
	[16121130] = { name="Ancient Art?", tip=threeArtOnRock },
	[16942666] = { name="Surgeon General Says...", tip=warningHash },
	[19072857] = { name="Honoured Ancestors", tip=zangenStonehoof },
	[19832740] = { name="Advice to Mull Over", tip=gloomWeed },
	[24556516] = { name="Quark, Strangeness and Charm", tip=hawkwind },
	[33391948] = { name="Ancient Art?", tip=threeArtOnRock },
	[34142043] = { name="Redrock Cave and Hut", tip=unusedBFA },
	[34842518] = { name="Ancient Art?", tip=threeArtOnRock },
	[47908810] = { name=digRatTitle, tip=digRat },
	[48781632] = { name="The Emerald Dream is Fake!", tip=fallaSagewind },
	[49140594] = { name="Did You See the Three-Headed Hydra?", tip=korkronLoot },
	[57776871] = { name="What's in a Name?", tip=drazzilb },
	[65335708] = { name="Awww They're So Cute!", tip=dartingHatchling },
	[72588823] = { name="Nat Pagle", tip=natPagle },
	[73078789] = { quest=6607, questName="Nat Pagle, Angler Extreme", tip=natsLuckyFishingPole },
}
points[ 65 ] = { -- Stonetalon Mountains
	[38081284] = { name="Come Out, Come Out, Wherever You Are...", tip=whereIsEverybody },
	[49096083] = { name="Cultivating Stoned Talon Mountains", tip=cultivation },
	[58425535] = { name="Shocking Big Daddy Bio!", tip=bioshock },
	[60719628] = { name="Vicious Giants", tip=viciousGiants },
	[61094062] = { name="Died Alone", tip=diedAlone },
	[63409556] = { name="Ancient Art?", tip=threeArtOnRock },
	[83685800] = { name="What You Smoking?", tip=whatYouSmoking },
	[87335089] = { name="A Simple Canoe", tip=canoe },
}
points[ 71 ] = { -- Tanaris
	[13988820] = { name="Khadgar's Turtling Again!", tip=polyTurtle },
	[15070806] = { name="Vale Dadanga", quest=24702, questName="Here Lies Dadanga", tip=dadanga },
	[18402962] = { name="Do You Need Anybody?", quest=24735,
					questName="A Little Help From My Friends", tip=ringo },
	[19973692] = { name="Patrolling Plumbers", tip=marioLuigi },
	[20727153] = { name=justTheTipTitle, tip=justTheTip },
}
points[ 64 ] = { -- Thousand Needles
	[16277471] = { name="Vale Dadanga", quest=24702, questName="Here Lies Dadanga", tip=dadanga },
	[40020623] = { name=digRatTitle, tip=digRat },
	[46194567] = { name="Stranded!", tip=stranded },
	[81600645] = { name="Nat Pagle", tip=natPagle },
	[82420588] = { quest=6607, questName="Nat Pagle, Angler Extreme", tip=natsLuckyFishingPole },
}
points[ 88 ] = { -- Thunder Bluff
	[28782589] = { name="Silence of the Lambs", tip=silenceOfTheLambs },
	[39883781] = { name="Surgeon General Says...", tip=warningHash },
	[54975141] = { name="Honoured Ancestors", tip=zangenStonehoof },
	[60424307] = { name="Advice to Mull Over", tip=gloomWeed },
}
points[ 249 ] = { -- Uldum
	[56714802] = { name="Khadgar's Turtling Again!", tip=polyTurtle },
	[64562860] = { name=justTheTipTitle, tip=justTheTip },
}
points[ 78 ] = { -- Un'Goro Crater
	[30615114] = { name=donQuijoteTitle, quest=24707, tip=donQuijote,
					questName="The Ballad of Maximillian" },
	[45480777] = { name="Vale Dadanga", quest=24702, questName="Here Lies Dadanga", tip=dadanga },
	[51974980] = { name="Do You Need Anybody?", quest=24735,
					questName="A Little Help From My Friends", tip=ringo },
	[55036404] = { name="Patrolling Plumbers", tip=marioLuigi },
}
points[ 83 ] = { -- Winterspring
	[25851972] = { name=danguiTitle, tip=dangui },
	[27063402] = { name="Candles and Rug", tip=rugAndCandles },
	[30591111] = { name="Bench With a View", tip=benched },
	[30700211] = { name="Winter's Veiled Darkshore Glade?",
					tip="Channel says Darkshore, Minimap\n"
						.."sub-zone says Veiled Sea. I'm on\n"
						.."the border of Winterspring and\n"
						.."Moonglade. Well... I'm somewhere!" },
	[45668939] = { name=hyjalHeightsTitle, tip=hyjalHeights }, 
}

points[ 12 ] = { -- Kalimdor
	[39657988] = { name="Welcome to Feralas!", tip=feralas },
	[56751409] = { name="Elwynn Forest?",
					tip="Don't you love the lush green of\n"
						.."Elwynn... Wait on!\n\n"
						.."These trees aren't quite the same.\n"
						.."The music is familiar though!\n\n"
						.."Erm. This is Winterspring.\n\n"
						.."Okay. This is doing my head in!!!" },
	[58314263] = { item=134831, npc=130911,
					tip="Charles Gastly - Toy Boy\n\n" ..doomsayersRobes },
}

--=======================================================================================================
--
-- OUTLAND
--
--=======================================================================================================

local anAppleADay = "So many Apples! If one fell on his head, sure,\n"
					.."it hurts!. A few dozen? What a headache!\n\n"
					.."Newtonian thoughts aside, somebody cleaved\n"
					.."his head apart from point blank range! Now\n"
					.."THAT'S a headache! Wait on... that's his own\n"
					.."weapon, so that means... hmmm... but why?\n\n"
					.."Don't forget the Loose Dirt Mound which is\n"
					.."exactly where this pin is. Maybe some\n"
					.."goodies for you!"
local anAppleADayTitle = "An apple a day... Nah, fcuk it!"
local babyFarm = "Awww, isn't it so lovely! A well-meaning\n"
				.."matron caring for so many children and\n"
				.."babies!...\n\n"
				.."Hey... wait a minute there... something's a\n"
				.."bit off! The small cuts of meat on the\n"
				.."tiered food rack, the tauren floor rugs,\n"
				.."the tiny half eaten corpse in the kennel,\n"
				.."cages out the back complete with a tiny\n"
				.."skeleton...\n\n"
				.."Hate to break it to Chaddo but he ain't\n"
				.."gonna be no chad, his day is very near!\n"
				.."Hmmm... I wonder if he's seen the large\n"
				.."wooden club, next to the kennel?\n\n"
				.."And Sa'rah. well, lo que será, será...\n\n"
				.."Oh yeah, you'll have a blast if you play\n"
				.."in the sandbox, so do take care now!\n\n"
				.."Ahhh right... so all the babies are Horde\n"
				.."but Chaddo and Sa'rah are Alliance? Okay...\n\n"
				.."Did you see Jara? He's in the naughty corner!\n\n"
				.."((Prior to Blizzard's ill considered burst of\n"
				.."censorship, the sign at the entry gate read:\n\n"
				.."    \"Challe's Home for Little Tykes\"!\n\n"
				.."Presumably removed because the archaic\n"
				.."word \"tyke\" in British English means \"small\n"
				.."child\" but also \"Roman Catholic\", which is\n"
				.."rather derogatory. Oh Blizzard! lol))"			
local babyFarmTitle = "How ya gonna keep 'em down on the farm\nAfter they've seen Halaa\n"
					.."How ya gonna keep 'em away from harm,\nThat's a mystery"
local moteCloud = "Back in the day Engineers could fly around Nagrand\n"
				.."and harness the clouds for farming elemental motes.\n"
				.."They are always located on the floating islands"
local skywing = "Skywing patrols around here.\nI'm sure you'd love a great\nbattle pet just like this one!"
local slammer = "Gotta feel for the creature. There it was flying\n"
				.."around then wham! A flying chunk of Draenor!\n\n"
				.."Another theory is that when Draenor was sundered,\n"
				.."this subterranean skeleton was ripped out along\n"
				.."with the chunk of ground too. What's your take?"
				
points[ 104 ] = { -- Shadowmoon Valley
	[65748602] = { name="Sorry, Goose, but it's time to buzz the tower",
					tip="I feel the need, the need for speed but\n"
					.."something tells me your ego is writing\n"
					.."cheques your body can't cash.\n\n"
					.."Yeah, don't be a Goose, you big stud. Ja'y\n"
					.."over there talks about the Top Orc ;) and\n"
					.."Ichman, or did he mean Iceman? Dunno.\n"
					.."Not to forget Mulverick too, or wait,\n"
					.."was that Maverick?\n\n"
					.."The question is can you fly? If you can't\n"
					.."then you become everyone’s problem.\n"
					.."That’s because every time you go up\n"
					.."in the air you’re unsafe, and I don’t\n"
					.."like you because you’re dangerous.\n\n"
					.."Prove yourself and you can be my wing-\n"
					.."man any time. But always remember:\n\n"
					.."You Don't Have Time To Think Up\n"
					.."There. You Think, You're Dead" },
}
points[ 107 ] = { -- Nagrand
	[50901440] = { name=babyFarmTitle, tip=babyFarm },
	[51873042] = { name="Inscruitable Cloudy Sparkling...", tip=moteCloud },
	[55993734] = { name="Ouch who put that there?", tip=slammer },
	[57892632] = { name=anAppleADayTitle, tip=anAppleADay },
}
points[ 104 ] = { -- Shadowmoon Valley
	[00894515] = { name="Predatory Strike!", tip=skywing, quest=10898, questName="Skywing", item=31760 },
}
points[ 108 ] = { -- Terokkar Forest
	[38721280] = { name="Chuck, Muckbreath, Snarly and Toothy",
					tip="Yes, fishing dailies abound and there are\n"
					.."excellent rewards on offer such as the Bone\n"
					.."and Jeweled Fifhing Poles.\n\n"
					.."But Old Man Barlo here in Terokkar offers\n"
					.."four adorable and instantly lovable baby\n"
					.."crocolisk pets. Yup. Four!!!\n\n"
					.."20% of the time you'll be offered the\n"
					.."\"Crocolisks in the City\" daily. And each\n"
					.."of the four pets has a very high drop\n"
					.."chance with a repeat of a known pet\n"
					.."extremely unlikely" },
	[53847232] = { name="Predatory Strike!", tip=skywing, quest=10898, questName="Skywing", item=31760 },
}
points[ 102 ] = { -- Zangarmarsh
	[39627232] = { name=babyFarmTitle, tip=babyFarm },
	[40688992] = { name="Inscruitable Cloudy Sparkling...", tip=moteCloud },
	[45219752] = { name="Ouch who put that there?", tip=slammer },
	[47298542] = { name=anAppleADayTitle, tip=anAppleADay },
}

--=======================================================================================================
--
-- NORTHREND
--
--=======================================================================================================

local afsanehAsrar = "Afsaneh Asrar pats around the\n"
					.."stairs in The Legerdemain Lounge.\n\n"
					.."This is very unusual for an inn\n"
					.."keeper as they are always stationary.\n\n"
					.."So stop her at your favoured location\n"
					.."and set your hearthstone.\n\n"
					.."Now, whenever you hearth, you'll\n"
					.."return to that exact location!"
local agedWine = "Have a close look at Christi's inventory at\n"
				.."the \"One More Glass\" shop.\n\n"
				.."Two of the items are noted as:\n\n"
				.."        \"Improves with age\"\n\n"
				.."Pricey yes. and improve with age they do!\n\n"
				.."Deposit in your bank for a rainy RP day...\n"
				.."and voilà... 365 days later they will\n"
				.."change into something different!\n\n"
				.."Bonus trivia: Try the /drink emote!"
local arsenic = "What's \"arsenic\" spelled backwards?"
local arsenicTitle = "?sdrawkcab delleps \"cinesra\" s'tahW"
local badRogue = "Everything about Nisstina is just so wrong!\n\n"
				.."In stealth but she has her pet out? Doh!\n\n"
				.."Her gear... it's a noob mess!\n\n"
				.."It's as though she's a parody\n"
				.."of bad rogue adventurers!\n\n"
				.."Yup. Got a feelin they bin trolled mon!"
local badRogueTitle = "How Many Fingers Does a Troll Have?"
local bambi = "In another universe you may find Bambi,\n"
			.."Thumper and Flower. Even the mother of\n"
			.."Bambi!\n\n"
			.."And here too, you can see them running\n"
			.."around!"
local bmHunter = "Sholazar Basin is an iconic zone for\n"
				.."Beast Mastery Hunters.\n\n"
				.."Three, no less, incredibly difficult to\n"
				.."farm beasts: Aotona with its stunning\n"
				.."plumage; Loque'nahak, the first ever\n"
				.."spirit beast and with its awesome eyes\n"
				.."and striking fur markings; King Krush,\n"
				.."the fearsome lime green devilsaur!\n\n"
				.."And they were not merely rares but\n"
				.."indeed de rigueur for all adventurers\n"
				.."keen on the Frost Bitten achievement.\n\n"
				.."Tales abound to this day of ten year\n"
				.."farms. City and zone chat was filled\n"
				.."with QQ. Good luck!\n\n"
				.."(Today, BM will get FB credit for taming)"
local cockroach = "Another iconic farm... this time shaman\n"
				.."would camp here for hours in the hope\n"
				.."that Cravitz Lorent would soon spawn.\n\n"
				.."Finally, they'd be able to purchase the\n"
				.."\"Tome of Hex: Cockroach\".\n\n"
				.."Bonus fact: The real reason he hides\n"
				.."down here is because he's peddling\n"
				.."smutty \"Seamy Romance\" novels!\n\n"
				.."Bonus++: Priests will love the\n"
				.."Scarlet Confessional Book. Yup, it's\n"
				.."so much fun spamming this toy!"
local darahir = "Darahir sells a nice \"Ghostly Skull\"\n"
				.."pet. Doesn't seem to have a limit so\n"
				.."I'd guess if you made the trip down\n"
				.."here he'd surely let you buy one!"
local duoctane = "Did you know that his other\n"
				.."name is Dominic Toretto?\n\n"
				.."Now... let's see if we can\n"
				.."find where he parked his\n"
				.."black dodge charger!"
local elixir = "Keep a look out for this elixir, carelessly\n"
			.."left lying around by those Kirin Tor mages.\n\n"
			.."I got a fantastic Tuskarr transformation\n"
			.."and a nice fishing skill bonus to boot!\n\n"
			.."Oh... you didn't get transformed but all\n"
			.."others got transformed? Yeah that's the\n"
			.."impressive Tier 2 Netherwind Regalia set.\n"
			.."Doesn't it look superb!\n\n"
			.."What did you get?"
local factsOfLife = "Whatever could Natalie and Chooch be discussing?\n\n"
					.."Aside from the Facts of Life of course!"
local factsOfLifeTitle = "The Good and Bad?\nYou take em both, and there you have..."
local fabio = "It's a little known fact in Dalaran that\n"
			.."Fabio has appeared on the cover of\n"
			.."100's of Steamy Romance Novels.\n\n"
			.."(Never heard of them? It's surely no\n"
			.."coincidence that the water well nearby\n"
			.."is a secret entrance to The Underbelly.\n"
			.."Occasionally Cravitz Lorent can be found\n"
			.."there. Ask and he might open his rain-\n"
			.."coat to reveal his tasteless tomes.)\n\n"
			.."Needless to say, Fabio looks positively\n"
			.."gorgeous here with his tradmark flowing\n"
			.."locks, chiselled nelf features and that\n"
			.."Je ne sais quoi that has made him a\n"
			.."magnet to women and, yes... he's still\n"
			.."single and looking!\n\n"
			.."(He'd look much prettier if he were a\n"
			.."blood elf. Just saying...)"
local genderBending = "Grab some Underbelly Elixir\n"
					.."and start quaffing... soon\n"
					.."enough everyone will become\n"
					.."a mage... but wait on... there's\n"
					.."some serious gender bending\n"
					.."happening here as well!"
local higherDnD = "Upon this crate is often a document.\n"
				.."It's a part of a collection achievement\n"
				.."called \"Higher Learning\" and the task\n"
				.."is a huge reference to the popular\n"
				.."tabletop game Dungeons & Dragons!\n\n"
				.."((Yeah... Taraezor (that's yours truly!)\n"
				.."has an AddOn over at Curseforge to\n"
				.."track your progress. Get it now while\n"
				.."stocks last!))\n\n"
				.."Each book you are required to collect\n"
				.."is one of the schools of magic in the\n"
				.."D&D universe. Now... lets roll 2D20\n"
				.."and..."

local initiative = "When your GM is a dud...\n"
					.."always roll for initiative!"
local jones = "Is this the same Jones we saw on that ship?\n\n"
			.."No, not The Exodar... but a similar ship!\n\n"
			.."If it is the same ship's cat\n"
			.."then this is definitely alien!"
local jonesTitle = "Jones isn't a pet. He's a survivor"
local lost = "Subtract one from each of the numbers\n"
			.."on the hatch and what do you get?\n\n"
			.."The six Valenzetti Equation numbers\n"
			.."of course!\n\nStill not clear?\nHow "
			.."about \"Dharma Initiative\"?\n\n"
			.."Okay, if you're still reading then you're\n"
			.."definitely \"Lost\"! ;)\n\n"
			.."It all adds up! That crashed plane...\n"
			.."could it be Oceanic Flight 815?\n\n"
			.."And if you see a puff of smoke moving\n"
			.."towards you... then just run!"
local mageLove = "Mages must come to Endora!\n\n"
				.."If you are lucky she will sell the:\n"
				.."   (1) Ancient Tome of Portal: Dalaran\n"
				.."   (2) Tome of Polymorph: Black Cat\n"
				.."   (3) Dalaran Initiates Pin\n\n"
				.."Even if they are unavailable she will\n"
				.."surely restock within about 45 minutes\n"
				.."or so.\n\n"
				.."She always has available:\n"
				.."   (1) Mystical Tome:Arcane Linguist\n"
				.."   (2) Familiar Stone\n"
				.."   (3) Mystical Tome: Illusion\n\n"
				.."Insciptors! Don't forget that she might\n"
				.."also have the Glyph of Dalaran Brilliance\n"
				.."Technique available too. Mages love it!\n\n"
				.."Bonues trivia: In another universe, the\n"
				.."60's TV show Bewitched! starred Samantha,\n"
				.."whose mother's name was Endora. The name\n"
				.."of the actress... Agnes Moorehead. Ah...\n"
				.."It's all starting to add up!\n\n"
				.."And now the black cat \"Bad Luck\"...\n"
				.."I wonder who it was who was polymorphed!!!"
local NethaerasLight = "There was a famous community worker,\n"
					.."whose avatar was a candle, who is\n"
					.."commemorated in Dalaran. There are\n"
					.."ten possible locations where you\n"
					.."might find a candle...\n\n"
					.."Dismount, target it and /cheer\n\n"
					.."You'll be rewarded with a nice pet!"
local polarBearCub = "Mages love their polymorphs!\n"
					.."So how about a cute polar bear cub?\n\n"
					.."The tome drops off Arctic Grizzlies\n"
					.."in Dragonblight. There's a few here!\n\n"
					.."The drop rate is around 1:100"
local rayban = "Okay, let's accept for one moment that\n"
				.."Shifty Vickers here has nicked Mankrik's\n"
				.."Old Wedding Garments...\n\n"
				.."But I just gotta know where to lay my\n"
				.."hands on those cool shades!"
local raybanTitle = "Mankrik's Ray-Bans too? Very Shifty!"
local sheddleShine = "Upstairs of The Threads of Fate is\n"
					.."Sheddle, who'll gladly shine your\n"
					.."shoes.\n\n"
					.."No tip necessary (as he's paid a\n"
					.."decent wage by those kindly Kirin\n"
					.."Tor mages).\n\n"
					.."He does a nice job too. The buff\n"
					.."will last you an hour.\n\n"
					.."Just sit in the seat and Sheddle\n"
					.."will apply the spit and polish!"
local shortcut = "Have a look into the well. Have a reeeeal\n"
				.."good look!\n\n"
				.."Oops! Did you fall in? Nevermind! You\n"
				.."just discovered a shortcut..."
local silverbrook = "A great place for inscriptors to farm the\n"
					.."cool \"Rituals of the New Moon\" which\n"
					.."confers an on-use transform into a giant\n"
					.."wolf onto an off-hand gear piece.\n\n"
					.."It's Bind on Pickup so make sure you're\n"
					.."an inscriptor!\n\n"
					.."Oh yeah... at this very location one of\n"
					.."the Silverbrook Hunters is buried up to\n"
					.."his head!\n\n"
					.."This is also the best location for Ally\n"
					.."as Silverbrook mobs in other locations\n"
					.."are invariably friendly. Horde, you've\n"
					.."lots more options! Regardless, the\n"
					.."mobs spawn really quick here too!\n\n"
					.."Expect to farm 200 or so for the drop"
local silverbrookTitle = "This Silverbrook Hunter\nis up to his neck in it!"
local smouldering = "The camp is very basic.\n"
					.."But the fire smoulders.\n"
					.."Not long departed.\n"
					.."Will he/she return?"
local timmyJ = "Yo Timmy J the deal\n"
				.."Keepin it so real\n"
				.."Pimpin purple 'n' hat 'n' mo\n"
				.."Uh, uh it's Timmy J on show\n"
				.."It be boss in dis hood\n"
				.."An Timmy J always got da wood\n"
				.."Yeah Timmy J can bounce\n"
				.."Careful don't blow that ounce\n"
				.."Trashin tha ride\n"
				.."like wat yo got ta hide?\n"
				.."Ya 'sall pimped out\n"
				.."Like that I got no doubt"
local vitamins = "What maniacal abomination is this?\n\n"
				.."There must surely be something in the\n"
				.."sewer water for a rat to grow that big!\n\n"
				.."Takes more than prayers and \"vitamins\"\n"
				.."to grow such a hulking beast.\n\n"
				.."What evil juice are the mages of Dalaran\n"
				.."pumping through the sewer?\n\n"
				.."Psst! For your very own Giant Sewer Rat\n"
				.."companion try fishing anywhwere in The\n"
				.."Underbelly. The RNG is brutal but eventually\n"
				.."you'll be rewarded with a more modestly,\n"
				.."but still hulkingly ginormous, giant rat of\n"
				.."your very own!"
local windle = "At 21:00 \"Blizzard Time\" Windle pats around\n"
				.."Dalaran, lighting the gas lamps and torches.\n\n"
				.."Windle's not the bright spark he once was\n"
				.."and he always misses a few.\n\n"
				.."Why does he light the lights? They are in\n"
				.."memory of his daughter Kinndy. She died\n"
				.."in the Theramore explosion.\n\n"
				.."Help out Windle by purchasing a magic\n"
				.."wand so that you may light the lamps that\n"
				.."Windle missed!\n\n"
				.."(If you're late to the party he walks clock-\n"
				.."wise and is done in about 5 minutes)"
			
points[ 114 ] = { -- Borean Tundra
	[22545039] = { name="So Many Tundra Penguins",
					tip="Why this berg? No idea. But there's\n"
					.."over 50 penguins here... just... chillin'!\n\n"
					.."Oh the puns Taraezor, the puns!" },
	[35213522] = { name="Perky Coquettes",
					tip="Fancy meeting Kevin Kanai Griffith\n"
						.."on the Coldarra rim of all places!\n\n"
						.."A great Northrend memorial to an\n"
						.."amazing fantasy artist!\n\n"
						.."So blue. So very blue!" },
	[42063169] = { name="A Bridge Too Far?",
					tip="No. It was a bridge to nowhere.\n\n"
						.."Look across the way to Coldarra.\n"
						.."This bridge was always doomed.\n\n"
						.."Most likely gnomish engineering.\n"
						.."Oh, goblin you say? Whatever!" },
	[54638937] = { name="White Murloc Egg",
					tip="This is what you came for. But beware...\n"
					.."you may only learn one per account!" },
	[55828810] = { name="It's Merky Looking for Terky Lerky!",
					tip="Dive down exactly here. Only a short way.\n\n"
						.."Face to 102 degrees and you'll see a slit\n"
						.." / orifice in the rocks.\n\n"
						.."((My \"X and Y\" AddOn @ Curseforge shows\n"
						.."degrees. Get it!))\n\n"
						.."Go through the opening and pivot clockwise\n"
						.."175 degrees and surface.\n\n" },
	[58678234] = { name="21 Up!", tip="Try AoE the penguins. Dare you!\n"
									.."It's downright freaky...\n\n"
									.."Almost instant respawn. 21.\n"
									.."Always 21 of the blessed birds!\n\n"
									.."Wait on... respawn but still dead??"},
	[61297673] = { name="Somebody didn't get the memo!",
					tip="A berg must have a population of 21\n"
						.."penguins if it has penguins at all.\n\n"
						.."14 only! Heads will roll for this\n"
						.."outrageous error!"},
	[62117672] = { name="21 Again!", tip="These bergs love their populations\n"
										.."of exactly 21 penguins.\n\n"
										.."It's the same here. Try to wipe\n"
										.."'em out and sure... they respawn\n"
										.."again as the living dead!\n\n"
										.."And only later do their ghosts\n"
										.."disappear"},
	[98072276] = { name="Smouldering", tip=smouldering },
}
points[ 127 ] = { -- Crystalsong Forest
	[25863929] = { name="Give Me a Fast Five!", tip=duoctane },
	[26573766] = { name="This One Ate It's Vitamins!", tip=vitamins },
	[27374052] = { name="Endora Moorehead", tip=mageLove },
	[27803634] = { name="Bouncin' Timmy J!", tip=timmyJ },
	[28003480] = { name="You Light Up My Life Nethaera", tip=NethaerasLight },
	[28393869] = { name=initiative, tip=higherDnD },
	[28533621] = { name=raybanTitle, tip=rayban },
	[28634106] = { name="Let there be guitar... erm... light!", tip=windle },
	[28813861] = { name="No Tip Necessary!", tip=sheddleShine },
	[29193474] = { name="It Ain't Over 'Til It's Over", tip=cockroach },
	[29403576] = { name="Well I'll be!", tip=shortcut },
	[29563764] = { name="Mobile Innkeeper!", tip=afsanehAsrar },
	[29643766] = { name="Gender Bending", tip=genderBending },
	[29763977] = { name="Underbelly Elixir", tip=elixir },
	[29783559] = { name="I Can't Believe It's Not Butter!", tip=fabio },
	[29893742] = { name=jonesTitle, tip=jones },
	[30563571] = { name="Vintage... 365 days ago!", tip=agedWine },
	[30653619] = { name=factsOfLifeTitle, tip=factsOfLife },
	[31583163] = { name=badRogueTitle, tip=badRogue },
	[32533141] = { name=arsenicTitle, tip=arsenic },
	[32663246] = { name="Cool Pet For Sale!", tip=darahir },
}
points[ 125 ] = { -- Dalaran
	[37213132] = { name="You Light Up My Life Nethaera", tip=NethaerasLight },
	[38595555] = { name="Endora Moorehead", tip=mageLove },
	[41054109] = { name="You Light Up My Life Nethaera", tip=NethaerasLight },
	[40683536] = { name="Bouncin' Timmy J!", tip=timmyJ },
	[41662789] = { name="You Light Up My Life Nethaera", tip=NethaerasLight },
	[43554669] = { name=initiative, tip=higherDnD },
	[43965799] = { name="You Light Up My Life Nethaera", tip=NethaerasLight },
	[44982399] = { name="You Light Up My Life Nethaera", tip=NethaerasLight },
	[44695816] = { name="Let there be guitar... erm... light!", tip=windle },
	[45574632] = { name="No Tip Necessary!", tip=sheddleShine },
	[48393252] = { name="Well I'll be!", tip=shortcut },
	[49204160] = { name="Mobile Innkeeper!", tip=afsanehAsrar },
	[49907063] = { name="You Light Up My Life Nethaera", tip=NethaerasLight },
	[50253169] = { name="I Can't Believe It's Not Butter!", tip=fabio },
	[50774057] = { name=jonesTitle, tip=jones },
	[50853011] = { name="You Light Up My Life Nethaera", tip=NethaerasLight },
	[53353534] = { name="You Light Up My Life Nethaera", tip=NethaerasLight },
	[54003228] = { name="Vintage... 365 days ago!", tip=agedWine },
	[58315231] = { name="You Light Up My Life Nethaera", tip=NethaerasLight },
	[61964415] = { name="You Light Up My Life Nethaera", tip=NethaerasLight },
}
points[ 126 ] = { -- Dalaran - The Underbelly
	[31284960] = { name="Give Me a Fast Five!", tip=duoctane },
	[34754171] = { name="This One Ate It's Vitamins!", tip=vitamins },
	[44193473] = { name=raybanTitle, tip=rayban },
	[47372759] = { name="It Ain't Over 'Til It's Over", tip=cockroach },
	[49564170] = { name="Gender Bending", tip=genderBending },
	[50165190] = { name="Underbelly Elixir", tip=elixir },
	[54453460] = { name=factsOfLifeTitle, tip=factsOfLife },
	[58931259] = { name=badRogueTitle, tip=badRogue },
	[63531151] = { name=arsenicTitle, tip=arsenic },
	[64171661] = { name="Cool Pet For Sale!", tip=darahir },
}
points[ 115 ] = { -- Dragonblight
	[12654150] = { name="Smouldering", tip=smouldering },
	[40775451] = { name="Attention Mages!", tip=polarBearCub },
	
}
points[ 116 ] = { -- Grizzly Hills
	[31065547] = { name="Arcturis",
					tip="Northrend... who loves it more than\n"
						.."Beast Mastery Hunters?\n\n"
						.."And here is where they find Arcturis,\n"
						.."A magnificent ghostly \"spirit beast\"\n"
						.."in the form of a grizzly bear.\n\n"
						.."The only one of its kind!" },
	[32225888] = { name="Just \"Passing Through\"",
					tip="This outhouse is unique amongst the\n"
						.."outhouses of Azeroth, this author\n"
						.."being well accustomed and all...\n\n"
						.."Knock on the door! Oh... really?\n\n"
						.."Horde... that's as far as it goes\n"
						.."for you, sorry to say. Just purchase\n"
						.."yourself a whoppee cushion, okay?\n"
						.."But try and press your ear against\n"
						.."the wall. Hey! I said your ear you\n"
						.."pervert! Stop trying to peek inside!\n\n"
						.."Alliance... you can go further, no\n"
						.."need to strain, in fact you'll be\n"
						.."doing your... duty.\n\n"
						.."If you haven't already, walk on\n"
						.."over to the entrance to the Lodge.\n"
						.."There's a bucket to the left of the\n"
						.."doorway, just inside the Lodge.\n\n"
						.."You'll deal with Anderhol who'll\n"
						.."help you to... get things moving\n"
						.."and to... get down to business!\n\n"
						.."Oh, the dialogue between Jacob\n"
						.."and Anderhol after the final\n"
						.."quest turn-in is priceless!\n\n"
						.."Feel free to avail yourself of\n"
						.."these facilities any time after!" },
	[35956912] = { name=silverbrookTitle, tip=silverbrook },
	[56922936] = { name="Who Killed Bambi?\nA Rotten, Vicious Rumour?", tip=bambi },
}
points[ 117 ] = { -- Howling Fjord
	[26470047] = { name=silverbrookTitle, tip=silverbrook },
}
points[ 118 ] = { -- Icecrown
	[03177702] = { name="I've Got One Up on You!\n(Reference Lost)", tip=lost },
	[19809549] = { name="Beast Master Hunter Nostalgia", tip=bmHunter },
	[44720439] = { name="Lonesome Berg", tip="Love the attention to detail" },
	[54060804] = { name="Wasted Conspiracy or Clever Prepping?",
					tip="Here they are all alone... three conspirators.\n\n"
						.."Better to hide here as nobody can be trusted?\n\n"
						.."But there's danger within their ranks?\n"
						.."Or they truly parrot as one?\n\n"
						.."I suspect that they are prepping!\n"
						.."They'll surely be safe here come the\n"
						.."armageddon / apocalypse / holocaust!" },
}
points[ 119 ] = { -- Sholazar Basin
	[21923373] = { name="You Have Exactly 108 Minutes",
					tip="To stop these electromagnetic pulses\n"
					.."you need to enter a code sequence\n"
					.."into a terminal.\n\n"
					.."Use your initiative and search for a\n"
					.."hexagon shaped hatch nearby!" },
	[26742412] = { name="Don't Stand in the Purple Stuff",
					tip="Stand here long enough and you'll get\n"
					.."zapped by mysterious purple lightning.\n\n"
					.."It won't hurt you, but the rust coloured\n"
					.."smoke plume is rather disconcerting!" },
	[38663722] = { name="I've Got One Up on You!\n(Reference Lost)", tip=lost },
	[62606380] = { name="Beast Master Hunter Nostalgia", tip=bmHunter },
}
points[ 120 ] = { -- The Storm Peaks
	[38484056] = { name="Jeeves, can you please take out the\n"
						.."dungeon trash, there's a good helper.",
					tip="Jeeves is an iconic part of being an engineer\n"
						.."and this is the best location to grind out the\n"
						.."schematic.\n\n"
						.."Focus on the Library Guardians, of which\n"
						.."there are numerous in the Terrace of the\n"
						.."makers.\n\n"
						.."Note: You must salvage the corpses and not\n"
						.."merely loot them" },
}
points[ 123 ] = { -- Wintergrasp
	[04271422] = { name="Beast Master Hunter Nostalgia", tip=bmHunter },
	[47458540] = { name="Smouldering", tip=smouldering },
}
points[ 121 ] = { -- Zul'Drak
	[70079551] = { name="Who Killed Bambi?\nA Rotten, Vicious Rumour?", tip=bambi },
}
--=======================================================================================================
--
-- PANDARIA
--
--=======================================================================================================

local abandonedKite = "We've all had to do the swim of shame\n"
				.."when we've fallen off a cliff or gone\n"
				.."too far while exploring.\n\n"
				.."A convenient taxi! It's a freebie too!\n\n"
				.."But... why is it \"abandoned\"?"
local alignedGrass = "The grass lines here are precisely aligned.\n\n"
			.."When correctly oriented one can see the letters\n"
			.."\"EVD\" and from a distance the silhouette of an\n"
			.."ancient carriage is apparent. Is this the long\n"
			.."rumoured reference to the \"Chariots of the Old\n"
			.."Ones\" and a subsequent \"Return to the Stars\"?"
local bellTolls = "This deserted landing is a questing location\n"
			.."which is not often visited. I urge you to go\n"
			.."inside and listen to the excellent zone music"
local birdFeast = "Very much the bloody feast. Love the\n"
			.."splatter effect when they lean in to bite!"
local boatBuilding = "Centre of the workbench.\n\n((The flavour text..."
			.."\n\n\"A book describing "
			.."the intracies[sic] of building\na fine "
			.."watercraft. You wouldn't understand.\"\n\n"
			.."has me stumped. The deliberate misspelling\n"
			.."and such led me down a rabbit hole and yet\n"
			.."I found nothing. It must be a reference, but\n"
			.."a reference to what? !!))"
local clamshellBand = "One of six items you need to collect\n"
				.."in order to craft the Clamshell Band.\n\n"
				.."The Clamshell Band in turn is needed\n"
				.."to summon Clawlord Kril'mandar in\n"
				.."south-west Krasarang Wilds at\n(12.6,81.2).\n\n"
				.."That boss drops Lobstmourne, an\n"
				.."interesting claw-like fist weapon\nused for transmogging"
local condor = "The highest peak in The Jade Forest and an\n"
		.."excellent place to watch the Condors flying!"
local eaPandaria = "Sounds like a good idea for an AddOn!\n"
			.."Yeah... shameless self promotaion again\n"
			.."but it really is good!"
local forgottenLockbox = "Second floor of the \"Tavern in the Mists\".\n\n"
local gokklok = "You'll love dancing to this toy...\n"
			.."Just go kill it already and thank me later!"
local grohl = "I was in nirvana when I wandered into this cave!...\n\n"
		.."Is someone getting the best, the best, the best\n"
		.."The best of you?\n"
		.."Is someone getting the best, the best, the best\n"
		.."The best of you?\n\n"
		.."He's putting on quite the show! If you hang around\n"
		.."long enough his mate ghostly mate Kurt might appear!\n\n"
		.."((Nah... I just made that last bit up. RIP))"
local hawkmaster = "My favourite secret location in Pandaria!\n\n"
			.."Within The Veiled Stair we have The Secret\n"
			.."Aerie and within that we have \"The People\n"
			.."of the Sky\", a small and oh so isolated\n"
			.."village of Hawkmasters and Hawk Trainers.\n\n"
			.."There's a book in one of the huts.\n\n"
			.."In addition to the named Hawkmasters, there\n"
			.."is the adorable Lil' Reed and Lil' Griffin, two\n"
			.."unobtainable pets to make your heart melt!"
local kherShan = "Seems to be guarded the memorial which is\n"
			.."likely dedicated to whom? Kipling? Mowgli?"
local krosh = "When you run out of IRL references...\n"
		.."Why not refer back to yourself?\n\n"
		.."You all remember Kresh from The Wailing Caverns?\n"
		.."He dropped the \"Kresh's Back\" shield. This time\n"
		.."around... hmmm... that quest name has a double\n"
		.."reference!!! And... \"whose\" works with and\n"
		.."without the apostrophe. Nice work Blizz writers!!!\n\n"
		.."Hey hunter tamers! This one's unique!"
local lakeKittitata = "Far from an unfinished borderland zone,\n"
				.."Lake Kittitata, especially the upper section,\n"
				.."affords a spectacular view of The Jade Forest\n"
				.."below, as well as ample opportunity to fish\n"
				.."the plentiful Jade Lungfish schools"
local lenin = "Advance far enough and you'll be rewarded\n"
		.."with the Townlong Steppes zone quest\n"
		.."completion achievement!\n\n"
		.."It's undoubtedly a reference to a phrase\n"
		.."popularised by Vladimir Ilyich Ulyanov,\n"
		.."commonly known as \"Lenin\", and is\n"
		.."indeed the title of one of his tomes.\n\n"
		.."That you are still with me here is an\n"
		.."achievement itself!\n\n"
		.."\"Steppes\" obviously reinforces this\n"
		.."by referencing the Russian Steppes.\n\n"
local lobstmourne = "Once you have all six pieces and you've\n"
			.."crafted the Clamshell Band then you must\n"
			.."come here and use it to summon Clawlord\n"
			.."Kril'mandar who will then drop Lobstmourne.\n\n"
			.."This is an interesting fist weapon which\n"
			.."is nice for transmogrification purposes"
local loKiAlaniStory = "He may not get many visitors but be prepared\n"
				.."to stay a while and listen for Loh-Ki has a\n"
				.."great story to tell... the origin of ..."
local manglemaw = "Awww... such a cute baby crocolisk!\n\n"
			.."Too cute to kill! No... you wouldn't\n"
			.."dare kill cute lil junior Manglemaw?"
local masterNguyen = "Who are the \"Five Sorcerers\"? What secret?\n\n"
			.."So much time has elapsed since the mists cleared\n"
			.."over Pandaria and we are still none the wiser!\n\n"
			.."Don't you love his \"Power of the Storm\" buff!\n\n"
			.."((I've marked the extremes of his pat path))"
local mountainClimber = "It must be so cold up here!"
local neverest = "The highest peak in all of Azeroth!\n"
		.."Is it really 8,844m above sea level?"
local nothingToSee = "Nothing to see... move on!\n\n"
				.."But you've got to agree it is big!"
local Psilocybin = "A tiny mushroom... why? Is it magical?\n"
			.."What a strange trip this must be!"				
local renFiretongue = "He just wants to be left alone.\n\n"
				.."By the way, Ren can also be found on the\n"
				.."Kun-Lai Summit side of the Gate of the\n"
				.."August Celestials, phasing permitted"
local rollingDeep = "We could have had it all!\n\n"
			.."Rolling in the deep\n"
			.."You had my heart inside of your hands\n"
			.."But you played it, you played it, you played it\n"
			.."You played it to the beat"				
local roseOffering = "Hidden away between the zones is this\n"
				.."altar, like any other save for a solitary\n"
				.."rose. It's fresh! Who placed it here and\n"
				.."who lit the incense?"
local rosesSkeleton = "Two strange skeletons and a bed of roses.\n\n"
				.."Are they a type of saurok? Head to tail and\n"
				.."facing away from each other. No camp or weapons.\n\n"
				.."The largest rose is in the hand of one of the deceased"
local samwiseDidier = "Celebrating Blizzard's very own real life\n"
				.."hobbit, the popular WoW artist Sam\n"
				.."Didier who arguably is responsible for the\n"
				.."Pandaren art we know and love.\n\n"
				.."And of course Samwise Gamgee from\n"
				.."The Hobbit"
local secondHighest = "The highest summit in Azeroth? Almost but not quite!\n\n"
				.."Face at 44 degrees (easy with the \"X and Y\" AddOn by\n"
				.."yours truly @ Curse) and you might be able to see\n"
				.."highest peak in Azeroth from here, way off in the\n"
				.."distance.\n\n"
				.."Wasn't that factoid worth the shameless self promotion!"
local secretAerie = "With one tiny questing exception, the Secret\n"
				.."Aerie is a perfect location for some chill\n"
				.."fishing. Hey, the Tiger Gourami Schools\n"
				.."which spawn here can help in that respect\n"
				.."too! Don't forget the book in the boat!"
local senTheOptimist = "You'll find Sen wandering around here.\n\n"
				.."Originally his dialogue was messed up.\n"
				.."That's thankfully been fixed. He's now\n"
				.."simply... optimistic!"
local serpentShrine = "I love this location @ the Peak of Serenity"
local smiteAgain = "The Deadmines was apparently not \"merely a\n"
			.."setback\" for " ..colourHighlight .."Mr Smite"
			..colourPlaintext ..". In fact the evidence\n"
			.."here is that he is still rather traumatised.\n\n"
			.."Determined to start a new life he travelled far\n"
			.."from his old base in Westfall. He filed his horns,\n"
			.."coloured his mane, doned a hoodie and generally\n"
			.."keeps a low profile in this quiet corner of the Vale.\n\n"
			.."Mindless toying with his Gnomish model tug boat\n"
			.."and his old-world \"vanilla\" chest, no doubt filled\n"
			.."with painful memories, hint at his trauma.\n\n"
			.."((He drops a cool \"Mr Smite\" transform toy\n"
			.."so you may need to wait for the respawn))\n\n"
			.."He still wields his favourite weapons too!"
local solitaryReed = "Attention to detail? Allowing a\n"
				.."solitary reed to stick out of the sea?"
local teaTree = "Reminds me of Leptospermum scoparium,\n"
		.."aka \"Tea Tree\" in my country"
local tigerWood = "Okay how to tee up a reference? I don't really\n"
			.."know how because it's a bit of a bogey. Par\n"
			.."for the course for most people I suppose"
local wallWatchers = "Chat to the Wallwatchers...\n\n"
				.."Uncanny! It's as though they had worked far\n"
				.."to the north, protecting Castle Black from the\n"
				.."wildlings!\n\n"
				.."Hang around and Ygritte, Styr and the wildlings\n"
				.."might appear? Don't forget to burn the bodies!"
local weirdBirdGuitar = "This non-clickable old broiler is a...?\n\n"
				.."Checkout its animation! It's not about\n"
				.."to start talking turkey, that's for sure!\n\n"
				.."And the guitar? A case of \"Zul again\"\n"
				.."or merely gobbledygook?"
local zumba = "Hey, we're just in time for the sprite zumba class!\n\n"
		.."Awwwww, aren't they just so adorable!\n\n"
		.."C'mon! Let's squeeze into our active wear...\n"
		.."Yeah... must have shrunk in the wash that last\n"
		.."time we exercised..."

points[ 422 ] = { -- Dread Wastes
	[27066933] = { item=90170, npc=66935, tip=clamshellBand },
	[27251612] = { name="Gokk'lok", tip=gokklok },
	[27841135] = { item=90171, npc=66938, tip=clamshellBand },
	[38291747] = { name="Zumba! Sprite Zumba!", tip=zumba },
	[39150680] = { name="Adele", npc=65178, tip=rollingDeep },
	[67785750] = { name="Exploration Achievements - Pandaria", tip=eaPandaria },
	[73851280] = { name="Jon, Samwell, Maester Aemon, et al...", tip=wallWatchers },
	[82171958] = { name="Erik was here!", tip=alignedGrass },
	[85142068] = { name="Ole Slow-hand Gobbler", tip=weirdBirdGuitar },
	[94651947] = { name="Single Rose", tip=roseOffering },
	[97881995] = { tip="It's Magic!", tip=Psilocybin },
}
points[ 418 ] = { -- Krasarang Wilds
	[09301680] = { name="Exploration Achievements - Pandaria", tip=eaPandaria },
	[12768150] = { name="Who c-c-c-calls?",
					item=90087, npc=66936, tip=lobstmourne },
	[39008770] = { item=90169, npc=66934, tip=clamshellBand },
	[52167341] = { item=87798, obj=214403, quest=31863,
					tip="Collect the stack of papers by all means!\n\n"
					.."Now read the document... okay... it references\n"
					.."the launch date and time of Diablo III!\n\n"
					.."System Failure? You ever tried to login\n"
					.."during the launch of a Blizzard game?\n\nError 37... Error 37..."},
}
points[ 379 ] = { -- Kun-Lai Summit
	[23878689] = { name="One Steppe Forward, Two Steppes Back", tip=lenin },
	[28402722] = { name="Foo! It's Grohl Grohl", tip=grohl },
	[33022635] = { name="For whom the Bell Tolls", tip=bellTolls },
	[35694240] = { name="Grove of Falling Blossoms", tip=teaTree },
	[43565348] = { name="Mountain Climber", tip=mountainClimber },
	[43901700] = { name="Wally and Tik Tak",
					tip="Wally the Walrus and Tik Tak the Carpenter...\n\n"
					.."Indeed, things are becoming curiouser and curiouser\n"
					.."in this wonderland of adventures. But ah! There's a\n"
					.."moral to this story... somewhere, yes, let me think...\n\n"
					.."Never imagine yourself not to be otherwise than what\n"
					.."it might appear to others that what you were or might\n"
					.."have been was not otherwise than what you had been\n"
					.."would have appeared to them to be otherwise" },
	[44415252] = { name="Neverest Pinnacle", tip=neverest },
	[44694984] = { name="Mountain Climber", tip=mountainClimber },
	[46055551] = { name="Mountain Climber", tip=mountainClimber },
	[46185204] = { name="Mountain Climber", tip=mountainClimber },
	[47509341] = { name="Farewell Rose", tip=rosesSkeleton },
	[47897349] = { item="Mo-Mo's Treasure Chest", obj=214407, quest=31868, 
					tip="No idea who Mo Mo is but he sure has a phat loot chest!" },
	[48147300] = { name="Mo-Mo's Treasure Chest", tip="Enter the cave here" },
	[49601820] = { item=90168, npc=66933, tip=clamshellBand },
	[50709361] = { name="Loh-Ki", tip=loKiAlaniStory },
	[51549291] = { name="Ren Firetongue", tip=renFiretongue },
	[51703933] = { name="Serpent Shrine", tip=serpentShrine },
	[54242420] = { tip="What a great view from the rock pools and the waterfall!" },
	[57202020] = { name="Lon'li Guju",
					tip="The only \"vanilla\" tortoise in all of Pandaria!\n"
					.."He flies along the coast here.\n\n"
					.."He must be so lonely. Help cheer him up by giving\n"
					.."a /hug or a /wave. He'll immediately come over to\n"
					.."you and follow you around for a couple of minutes!\n\n"
					.."((A reference to " ..colourHighlight .."Lonesome George"
					..colourPlaintext ..", the only known\n"
					.."individual of the Pinta Island Tortoise sub-species,\n"
					.."and who eventually passed away.\n\n"
					.."The plaque overlooking his old corral in Galapágos\n"
					.."(Ecuador) now reads, " ..colourHighlight 
					.."\"We promise to tell your\n"
					.."story and to share your conservation message.\"\n\n"
					..colourPlaintext .."Vale El Solitario George!))" },
	[68601660] = { name="Mei and Eva",
					tip="Mei is certainly in the zone, focusing on her\n"
					.."student. But... persist with talking to her.\n\n"
					.."A little extra tidbit no?\n\n"
					.."Interact some more... okay then... leave her be" },
	[74331054] = { name="Green Voodoo Brew", tip="The brew needs a few more frogs, so go to it now!" },
	[75151644] = { name="Red Voodoo Brew", tip="A mysteriously tasty concoction indeed!\n"
					.."You'll acquire voodoo mastery in no time!" },
	[75561339] = { name="Magenta Voodoo Brew", tip="Ewwww! That magenta slurry looks a bit off!" },
	[76991233] = { name="Blue Voodoo Brew", tip="Now go dance with a witch doctor!\n\n"
					.."Yeah... I be jammon wit' you too!" },
	[77121537] = { name="Duskwing Crow Feast", tip= birdFeast },
	[78168745] = { name="Lake Kittitata", tip=lakeKittitata },
	[79329951] = { name="The People of the Sky", tip=hawkmaster },
	[79607153] = { tip=nothingToSee },
	[81027378] = { name="\"Abandoned\" Kites", tip=abandonedKite },
	[81279685] = { name="The Secret Aerie", tip=secretAerie },
	[84905375] = { name="\"Abandoned\" Kites", tip=abandonedKite },
	[88365201] = { name="\"Abandoned\" Kites", tip=abandonedKite },
	[89629496] = { name="Tigers' Wood", tip=tigerWood },
	[90978626] = { name="Sam the Wise", tip=samwiseDidier },
	[91349358] = { name="Kher Shan", tip=kherShan },
	[95134722] = { name="Solitary Reed", tip=solitaryReed },
}
points[ 386 ] = { -- Kun-Lai Summit - Ruins of Korune
	[53613073] = { name="For whom the Bell Tolls",
					tip="That's far enough - the place is booby trapped!\n\n"
					.."Turn up the volume and grab a coffee. There are\n"
					.."ten randomly selected tracks for this sub-zone,\n"
					.."plus others which I think play.\n\n"
					.."I just love the percussion / bell elements!" },
	[91717844] = { name="Condor Heights", tip=condor },
}
points[ 371 ] = { -- The Jade Forest
	[05426296] = { name="Single Rose", tip=roseOffering },
	[07906333] = { tip="It's Magic!", tip=Psilocybin },
	[14746943] = { name="Manglemaw", tip=manglemaw },
	[17067175] = { name="Sen the Optimist", tip=senTheOptimist },
	[17215270] = { name="Yorik Sharpeye", tip=smiteAgain },
	[19144770] = { tip=secondHighest },
	[21543615] = { name="Lake Kittitata", tip=lakeKittitata },
	[22574696] = { name="The People of the Sky", tip=hawkmaster },
	[22832187] = { tip=nothingToSee },
	[23206046] = { item="Forgotten Lockbox", obj=214325, quest=31867, tip=forgottenLockbox },
	[24102390] = { name="\"Abandoned\" Kites", tip=abandonedKite },
	[24324458] = { name="The Secret Aerie", tip=secretAerie },
	[27570594] = { name="\"Abandoned\" Kites", tip=abandonedKite },
	[29925165] = { name="Hungry Bloodtalon", tip= birdFeast },
	[30680438] = { name="\"Abandoned\" Kites", tip=abandonedKite },
	[32004300] = { name="Tigers' Wood", tip=tigerWood },
	[33354165] = { name="Kher Shan", tip=kherShan },
	[33023508] = { name="Sam the Wise", tip=samwiseDidier },
	[33682807] = { name="Condor Heights", tip=condor },
	[34187689] = { item=87524, obj=214340, quest=31869, tip=boatBuilding }, -- Boat-Building Instructions
	[36750008] = { name="Solitary Reed", tip=solitaryReed },
	[39254663] = { name="The Jade Witch",  -- quest 29716,( 29723) not completed
					tip="She's a bit weird! So... all the jade stuff outside?" },
	[43987339] = { name="Nectarbreeze Orchard", tip=teaTree },
	[45163735] = { name="Forest Heart Raft",
					tip="Another mysterious skeleton but this time...\n\n"
					.."Doubly mysterious. Two cute (unclickable) birds,\n"
					.."a pink teddy bear. empty bottles, fresh snacks\n"
					.."and flowers, and...\n\n"
					.."Dive down! There are more empty bottles and\n"
					.."he lost his oars!" },
	[46298069] = { quest=31865, item="Offering of Remembrance", obj=214338, },
	[52471341] = { name="The Moon is a Balloon",
					tip="Not sure what's \"Up\" here...\n\n"
					.."It must be a reference to something,\n"
					.."so why not look it \"up\"?" },
	[54204240] = { name="Ferdinand", tip="All he wants to do is smell the flowers!\n\n"
					.."When you agro him he dual wields... flowers!\n\n"
					.."((Childrens' book reference))" },
			-- Deliberately offset as he also appears in my EA Pandaria AddOn
	[54059071] = { name="Follow the yellow brick road",
					tip="We're off to see the Wizard\n"
					.."The wonderful Wizard of Oz\n"
					.."We hear he is a whiz of a wiz\n"
					.."If ever a wiz there was\n"
					.."If ever, oh ever a wiz there was..." },
	[55303160] = { name="Martar",
					tip="Martar the peeping gnoll pats around here. Try fighting him!\n\n"
					.."Did you get his awesome magnifying glass? Awww, better\n"
					.."luck next time. On average it will take three or four attempts!\n\n"
					.."But make sure that you get it... you'll be going blind from\n"
					.."reading those steamy romance novels he otherwise drops..." },
	[56281829] = { name="Anglers Fisherman",
					tip="Love the various popup gossip\n"
					.."from the local fisherman.\n\n"
					.."Yeah the \"Noodler\" he refers\n"
					.."to is alive and well at the\n"
					.."Anglers village in Krasarang" },
	[57222127] = { name="Just a domestic...", tip="A really curious conversation.\n\n"
						.."It infrequently triggers. I had to\n"
						.."go AFK and check the chat dialogue" },
	[57465196] = { name="Master Nguyen of The Five Sorcerers", tip=masterNguyen
					.."\n\nAfter he leaves here (and unlike the other end\n"
					.."points he only pauses here briefly) he will\n"
					.."attempt to walk past the Jade Temple cafe\n"
					.."only to pause and glitch! Watch it happen!" },
	[58131923] = { name="Anglers Fisherwoman",
					tip="So the women are mostly this side\n"
					.."and the men are across the water.\n\n"
					.."Click for the random chat popup!\n\n"
					.."And for this fisherwoman, most\n"
					.."importantly you must look up...\n\n"
					.."Hey Junior get down from there!" },
	[59353644] = { item=90166, npc=66932, tip=clamshellBand },
	[59739602] = { item=90167, npc=66937, tip=clamshellBand },
	[60014210] = { name="\"Abandoned\" Kites", tip=abandonedKite },
	[62065527] = { name="Master Nguyen of The Five Sorcerers", tip=masterNguyen },
	[62452754] = { quest=31866, item="Stash of Gems", obj=214337,
					tip="Inside the Shadowfae Madcap cave" },
	[65364755] = { name="Master Nguyen of The Five Sorcerers", tip=masterNguyen },
}
points[ 433 ] = { -- The Veiled Stair
	[31364098] = { name="Yorik Sharpeye", tip=smiteAgain },
	[38842154] = { tip=secondHighest },
	[52231867] = { name="The People of the Sky", tip=hawkmaster },
	[54667122] = { item="Forgotten Lockbox", obj=214325, quest=31867, tip=forgottenLockbox },
	[88190280] = { name="Tigers' Wood", tip=tigerWood },
	[80813691] = { name="Hungry Bloodtalon", tip= birdFeast },
}
points[ 388 ] = { -- Townlong Steppes
	[23000700] = { name="G'nathus",
					tip="Look for G'nathus along the north coast.\n"
					.."Good chance to drop a really cool battle pet!" },
	[32496177] = { name="Meanwhile... \"planet\"side... we've located the missing\n"
					.."fifth watcher from the Vault of Archavon in Wintergrasp!!!",
					tip="Well go on! Get in there and find out what all the fuss is about!" },	
	[41759707] = { name="Gokk'lok", tip=gokklok },
	[42309263] = { item=90171, npc=66938, tip=clamshellBand },
	[42875825] = { tip="Well I've got the balls to say it! The bull lacks a pizzle!" },
	[52049833] = { name="Zumba! Sprite Zumba!", tip=zumba },
	[52848838] = { name="Adele", tip=rollingDeep },
	[65006700] = { name="One Steppe Forward, Two Steppes Back", tip=lenin },
	[69940197] = { name="Foo! It's Grohl Grohl", tip=grohl },
	[74970102] = { name="For whom the Bell Tolls", tip=bellTolls },
	[77831852] = { name="Grove of Falling Blossoms", tip=teaTree },
	[85189397] = { name="Jon, Samwell, Maester Aemon, et al...", tip=wallWatchers },
	[86463058] = { name="Mountain Climber", tip=mountainClimber },
	[87382954] = { name="Neverest Pinnacle", tip=neverest },
	[87692663] = { name="Mountain Climber", tip=mountainClimber },
	[89173280] = { name="Mountain Climber", tip=mountainClimber },
	[89302902] = { name="Mountain Climber", tip=mountainClimber },
	[90757410] = { name="Farewell Rose", tip=rosesSkeleton },
	[94237432] = { name="Loh-Ki", tip=loKiAlaniStory },
	[95157356] = { name="Ren Firetongue", tip=renFiretongue },
	[95321517] = { name="Serpent Shrine", tip=serpentShrine },
}
points[ 389 ] = { -- Townlong Steppes - Niuzao Catacombs
	[64122205] = { name="Huggalon the Heart Watcher",
					tip="He drops the cute B.F.F. Necklace toy.\n\n"
					..colourHighlight .."Gooooo Planet! The power is yours Captain!\n\n"
					..colourPlaintext .."((Okay... the VoA reference is itself\n"
					.."a reference. Captain Planet anyone?))" },
}
points[ 390 ] = { -- Vale of Eternal Blossoms
	[11625855] = { name="Jon, Samwell, Maester Aemon, et al...", tip=wallWatchers },
	[24251345] = { name="Farewell Rose", tip=rosesSkeleton },
	[29187289] = { name="Erik was here!", tip=alignedGrass },
	[32161394] = { name="Loh-Ki", tip=loKiAlaniStory },
	[34241222] = { name="Ren Firetongue", tip=renFiretongue },
	[35477522] = { name="Ole Slow-hand Gobbler", tip=weirdBirdGuitar },
	[55577266] = { name="Single Rose", tip=roseOffering },
	[62397367] = { tip="It's Magic!", tip=Psilocybin },
	[81259049] = { name="Manglemaw", tip=manglemaw },
	[87659691] = { name="Sen the Optimist", tip=senTheOptimist },
	[93383057] = { tip=secondHighest },
	[93429040] = { name="Krosh", tip=krosh },
	[89004400] = { name="Yorik Sharpeye", tip=smiteAgain },
}
points[ 376 ] = { -- Valley of the Four Winds
	[04266616] = { name="Exploration Achievements - Pandaria", tip=eaPandaria },
	[12540520] = { name="Jon, Samwell, Maester Aemon, et al...", tip=wallWatchers },
	[23881445] = { name="Erik was here!", tip=alignedGrass },
	[27941595] = { name="Ole Slow-hand Gobbler", tip=weirdBirdGuitar },
	[40911430] = { name="Single Rose", tip=roseOffering },
	[45311495] = { tip="It's Magic!", tip=Psilocybin },
	[52104850] = { name="Farmer Yoon",
					tip="You'll need to advance the Tillers for this one...\n\n"
					.."One of his dailies is called \"Red Blossom Leeks,\n"
					.."You Make the Croc-in' World Go Down\".\n\n"
					.."Okay you got the reference? Great! Now do\n"
					.."yourself a favour and instal my HandyNotes:\n"
					.."DarkSoilTillers AddOn!" },
	[57492579] = { name="Manglemaw", tip=manglemaw },
	[61622993] = { name="Sen the Optimist", tip=senTheOptimist },
	[65342573] = { name="Krosh", tip=krosh },
	[72540985] = { item="Forgotten Lockbox", obj=214325, quest=31867, tip=forgottenLockbox },
	[92083907] = { item=87524, obj=214340, quest=31869, tip=boatBuilding }, -- Boat-Building Instructions
}
points[ 424 ] = { -- Pandaria
	[71008180] = { tip="An epic showdown settles the score once and for all...\n\n"
					.."Luce Bree versus Nuck Chorris!!!\n\n"
					.."The winner? Would I spoil that for you?!" },
	[20005700] = { name="Master Korin",
					tip="((No reference to Master Korin! Really Blizzard? Grrrr!))" },
}
points[ 554 ] = { -- Timeless Isle
	[63002800] = { name="Garnia", tip="She might drop a gorgeous fire elemental\n"
									.."battle pet if you're really lucky!\n\n"
									.."Actually I counted 16 possible pets\n"
									.."to be had off the various rare elites\n"
									.."and such on the Timeless Isle!" },
	[70377737] = { name="Underwater Love",
					tip="Enter the cave at this location...\n\n"
					.."Your guess is as good as mine as to\n"
					.."what might have been happening here!\n"
					.."Perhaps some kind of weird love ritual!\n\n"
					.."Oh yeah... the Glinting Sand is actually\n"
					.."useful for two separate achievements on\n"
					.."the Timeless Isle. But since you have my\n"
					.."\"Exploration Achievements - Pandaria\"\n"
					.."AddOn you knew that already! Didn't you?\n\n"
					.."Wait! There's more!!! Sit down and touch\n"
					.."the fire. Oops! Where am I?" },
}

--=======================================================================================================
--
-- MISCELLANY
--
--=======================================================================================================

points[ 1532 ] = { -- Crapopolis
	[46454882] = { name="Mind Your Step!",
					tip="Did you known there's another mine field?\n\n"
					.."Sparksocket Minefield, to the west of K3 in\n"
					.."Storm Peaks." },
	[56086809] = { name="Funky Town!",
					tip="Ahhh yes every New Years Eve the\n"
					.."Auction House in Stormwind or\n"
					.."Orgrimmar is transformed into a disco.\n\n"
					.."But here... it's 24/7!\n\n"
					.."Time to splash out your best toys!\n"
					.."Now, where's my Rainbow Generator..." },
}

-- Choice of texture
-- Note that these textures are all repurposed and as such have non-uniform sizing
-- I should also allow for non-uniform origin placement as well as adjust the x,y offsets
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
textures[11] = "Interface\\HelpFrame\\HelpIcon-CharacterStuck"	
textures[12] = "Interface\\PlayerFrame\\UI-PlayerFrame-DeathKnight-Frost"
textures[13] = "Interface\\TargetingFrame\\PetBadge-Magical"
textures[14] = "Interface\\Vehicles\\UI-Vehicles-Raid-Icon"
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
scaling[11] = 0.57
scaling[12] = 0.49
scaling[13] = 0.48
scaling[14] = 0.43
