local _, ns = ...
local points = ns.points
local textures = ns.textures
local scaling = ns.scaling
local colourPrefix		= ns.colour.prefix
local colourHighlight	= ns.colour.highlight
local colourPlaintext	= ns.colour.plaintext

local st = {}

st.doomsayersRobes = "Kill him and oh boy, he might drop a toy!\n\n"
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

st.abandonedHope = "Love the signs and the victims strung up.\nHmmm... someone or something has \n"
					.."been gnawing at their legs!"
st.abercrombieAndFitch = "Okay you've found Abercrombie. Great!\n"
							.."But now the other part. What could it be?\n"
							.."Hint: Do the quest chain!"
st.antonJermaine = "Two dwarves on a camping / drinking\n"
					.." expedition. What could possibly go\n"
					.."wrong? Guess the \"locals\" scented\nsomething delicious?\n\n"
					.."It's more than I can bear!"
st.aridensCamp = "Ariden's camp has been here since the first adventurers\n"
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
st.artifactWeapons = "If you come across this then chances are\n"
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
st.blackIce = "Yup. You wear a ring and you can see it!\n"
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
st.broadsideBetty = "Well we hate to see her go,\nBut we love to watch her leave!\n"
						.."She'll do her best for William\nAnd Wes and Mike and Steve!\n"
						.."Her name is spread both far and wide!\nHer legend is renowned!\n"
						.."They call her Broadside Betty,\nShe's the roundest game in town!\n"
						.."So if you've mind to travel south,\nBe sure to stop and play!\n"
						.."'Cause she's the real reason\nThat they call it Booty Bay!\n\n"
						.."((Warcraft: Legends Vol. 4, manga))"
st.caerDarrow = "Possible to fly in and snoop around!"
st.catLady = "At the back of her house is a tombstone marking\n"
				.."the grave of \"Lord Underfoot\". You can meet\n"
				.."Lord Underfoot again at the Blacksmith in Arathi\n"
				.."Basin if you are Horde and you've captured it!\n\n"
				.."((Donni is named after former Blizzard staffer\n"
				.."Donna \"Kat\" Anthony, whom is reportedly the\n"
				.."person responsible for pushing for vanity pets\n"
				.."in game. Thank you Katricia!))"
st.christ = "((The goblin statue with outstretched arms is referring to\n"
			.."\"Christ on Corcovado\". This statue is atop a mountain\n"
			.."near Rio de Janeiro.))\n\n"
			.."The robes the goblin is wearing are, appropriately,\n"
			.."\"Gamemaster Robes\", unobtainable be us mere\nmortals!"
st.darkmoonPortalA = "The Darkmoon Faire portal is exactly\n"
				.."at this location when it comes around\n"
				.."each month. Before you go rushing in,\n"
				.."grab some Simple Flour from Tharynn\n"
				.."Bouden back at the cart at the town's\n"
				.."edge. And any other materials you'll\n"
				.."need for those sweet profession skill\n"
				.."jumps!"
st.deadminesExit = "This is the exit to the, erm, Deadmines exit.\n\n"
					.."Ever since adventurers first used this exit\n"
					.."they have tried to go back in. Not possible!\n\n"
					.."When you exit from the Deadmines you are\n"
					.."placed below a ledge which is too high to\n"
					.."jump upon. Your only option is to continue\n"
					.."down to here"
st.defiasGate = "This huge gate is the exit for the Defias Juggernaught.\n"
				.."That's the huge ship we see when we reach the\n"
				.."Ironclad Cove in the Deadmines.\n\n"
				.."((In WoW Alpha the Cove was outdoors!!!))"
st.dregoth =   "Awwww he's not at all suspicious! First\n"
				.."appeared at the start of \"Dragonflight\".\n\n"
				.."Why did he suddenly arrive in Darkshire?\n"
				.."Nobody knows! Others have likewise popped\n"
				.."up in several locations across Azeroth!"
st.dwarvenFarm = "Just a cool farming area. Chill. Nothing else to see!"
st.ebonchill = "This location, complete with a Circle of Power\n"
				.."is swarming with arcane elementals and mana wyrm.\n\n"
				.."It became known around the time of \"Legion\" and\n"
				.."is a key location frost mages will visit when they\n"
				.."seek to acquire their legendary artifact weapon."
st.fourChildren = "((The four children in this area are tributes\n"
					.."to Blizzard Exterior Level Designers. One,\n"
					.."Matt, wanders between the pond and the\n"
					.."lake, searching for fish))"
st.fourSkeletons = "Four of them. Looking up at... what?\n"
				.."And it looks like some crazy drinking\n"
				.."ritual too! Did they become somehow\n"
				.."ensorcelled?"
st.gnollTent = "When gnolls skin their prey they leave\n"
				.."nothing to waste. Even a human face has\n"
				.."a use when stretched out for tent material!"
st.garrod = "No need to take your shoes off when\n"
			.."visiting Garrod's house. Just fly right in!\n\n"
			.."Yup, flying on any of your mounts is\n"
			.."quite within his house rules it seems.\n\n"
			.."Just don't you dare try to mount up\n"
			.."though as he apparently draws the line\n"
			.."at that. Go figure, whatever!"
st.graveMoss = "This herb, unusually, has just the one\nlocation which is viable to farm...\n"
				.."right here in the Raven Hill Cemetery!\n\nYes... I know you can find it elsewhere\n"
				.."but emphasis on \"viable\" please! :)"
st.highPointEK = "Highest peak in the Eastern Kingdoms.\n\n"
					.."Hmmm... looks like another expedition\n"
					.."wasn't quite as successful..."
st.hiHoHiHo = "It's the Seven Dwarves Plus Two!\n\n"
				.."Built in redundancy in case of\n"
				.."problems along the way.\n\n"
				.."Hang around a bit and you'll\n"
				.."see what I mean!\n\n"
st.hogger = "Hogger  and Gammon, sitting in a tree...\n\nnot as such... but forgive the love-in...\n\n"
			.."Hogger is to Alliance and Stormwind as\nGammon is to Horde and Orgrimmar.\n\n"
			.."The NPC we love to bully. For the uninitiated\nI marked the map location"
st.holdBreath = "Originally I was going to suggest that\n"
				.."you dive down and check out the\n"
				.."Quel'dorei (High Elf) ship wrecks.\n\n"
				.."Then I realised that... breathing,\n"
				.."submerged... not a problem here!"
st.ironforgeGuardPatrol = "There's a solitary Ironforge Guard patrolling\n"
							.."the mountain top. Guess you never know\n"
							.."who might need directions.\n\n"
							.."Incredibly, the guard is able to walk\n"
							.."inclines that no other person dare try!"
st.jeremiahSeely = "Such a chill place to while away your time!\n\n"
					.."Oh... the matter of Jeremiah. Once upon a time he\n"
					.."sold the \"Tome of the Clear Mind\", which hapless\n"
					.."adventurers like you and I would use to reset our\n"
					.."talents. No wonder it was a best seller!\n\n"
					.."I've a feeling Jeremiah is not so pleased with the\n"
					.."author(s) of the Steamy Romance Novel series!"
st.kibler = "Kibler has a storied history. These days,\n"
			.."he offers one last quest in the Burning\n"
			.."Steppes before you are sent on your\n"
			.."way to the Swamp of Sorrows.\n\n"
			.."The reward for all of your trouble is a\n"
			.."cute little Tiny Flamefly (firefly) pet!\n"
			.."It's for Horde only...\n\n"
			.."Before Cataclysm he was much more\n"
			.."generous. A Smoulderweb Hatchling\n"
			.."AND a Worg Pup were your rewards and\n"
			.."he didn't mind whose side you were on!\n\n"
			.."Bonus Factoid!...\n\n"
			.."A possible reward from the Terrokar\n"
			.."fishing dailies is the \"Kibler's Bits\"\n"
			.."recipe. If YOU eat the food then your\n"
			.."pet will be bigger for 20 minutes!"
st.lonesomeCoral = "So curious. Why is this coral / sea\n"
				.."garden above all of the others?"
st.miaMalkova = "((In 2021 Blizz, in response to the very serious\n"
					.."controversies at the time, set about not just\n"
					.."purging well known male personalities but also\n"
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
st.miaMalkovaTitle = "Goldshire ERP Is Tame (In Comparison)"
st.mechanoArachnid = "Might impressive Mechano-\narachnid this!\n\n"
					.."But... where are the owners?\nWhat befell of them?\n\n"
					.."Interestingly... it's identical to the\n"
					.."extra large mechano-tanks at\n"
					.."Crushcog's arsenal and... its\n"
					.."almost all the way to Coldridge\nValley!\n\n"
					.."You think the dwarven recruits\n"
					.."were trying to steal this\ngnomish technology?"
st.morgansPlotGlitch = "You've heard of glitching to fall through\n"
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
st.nakada = "Just... volunteer!\n\nPssst... several outcomes, all harmless!"
st.ollie = "Ollie is one spoilt pug!"
st.petrifiedYojamba = "Careful of the basilisk. She scales up and packs a whallop!\n\n"
						.."Oh... and all of those petrified Bloodscalp Shaman and\n"
						.."Scavengers... I guess she permanently petrified them with\n"
						.."her Crystaline Breath.\n\n"
						.."Which figures because when your are taking a S.E.L.F.I.E.\n"
						.."you do need everyone to be standing reeeeeal still now!\n\n"
						.."Yeah she drops a quest item for that blessed selfie camera."
st.planeCamp = "If Alliance, you may have flown over\n"
			.."this camp many times while taxiing\n"
			.."between Ironforge and Stormwind.\n\n"
			.."What's curious is that the plane didn't\n"
			.."crash land for once. In fact it's a nice\n"
			.."safe little hideaway. So, where are the\n"
			.."people who live here?"
st.plugs = "I wonder what these two plugs are plugging?"
st.questNextToFM = "Alliance can visit Ragged Jong\nfor a quest and...\n\n"
					.."Oh wait. WTF! He's standing\nright next to a max level\n"
					.."Horde Wind Rider Master.\n\n"
					.."This is not going to finish well..."
st.rixaTransport = "Yup! It's an entertaining flight down\n"
					.."to Gol'Bolar Quarry way below!\n\n"
					.."If you are wondering... why...\n"
					.."It's probably because you are able\n"
					.."to get a free flight up to here from\n"
					.."Gol'Bolar and, well, you might not\n"
					.."be able to fly yourself!\n\n"
					.."Alliance only! Horde not welcome!"
st.sandahl = "In the basement of this innocuous pub\n"
				.."lurks a warlock coven, led by Sandahl.\n\n"
				.."Of immense importance to Warlocks\n"
				.."who crave green/fel fire for their magic!"
st.senegal = "The Senegal pet, purchasable from Narkk, is\nthe\n\n"
				.."    \"Favored pet of the goblins of Booty\n"
				.."    Bay, this colorful bird is renowned for\n"
				.."    its ability to count coins, tally budgets,\n"
				.."    and lie about contracts.\"\n\n(Pet Journal)"
st.seasonedAV = "The two Alterac Valley explorers are quietly famous.\n\n"
				.."When defeated, they will drop Stormpike Commander's\n"
				.."Flesh which you turn-in when you are running AV!\n\n"
				.."Of course back in the day how would the Horde get\n"
				.."to here easily, given that flying wasn't a thing!"
st.secondHighestPeakEK = "The second highest peak in the Eastern Kingdoms.\n\n"
							.."The highest? It's at 2 degrees from here.\n\n"
							.."Oh, erm, you'll need my \"X and Y\" AddOn\n"
							.."which shows degrees as well as coordinates!"
st.shadowfangKeep = "Take a look around. Sure looks the same but...\n"
					.."each doorway is boarded up and each alcove\n"
					.."leads to nowhere!"
st.shamefulTask = "Flagged for PvP but... taking a hit for the\n"
					.."team and reluctantly, of course, choosing\n"
					.."a rather safe task. Who are you kidding!\n"
					.."Makes all the Horde PvPers look gutless! :D"
st.sharpbeak = "Now that I've got your attention...\n\n"
				.."Sharpbeak gives a free lift down to\n"
				.."Fraggar Thundermantle's little camp,\n"
				.."if you were wondering. I marked it\n"
				.."on the map :)"
st.sledCave = "Many have met the sledders but I bet\n"
				.."you didn't know about their cave!"
st.sledFall = "Maybe a good place to wait, if you're patient!\n"
				.."You never know what might slide in to view!"
st.sledStart = "This is where it all begins!\n\n"
				.."Why can't we join in? Looks fun!"
st.stanLee = "Stanley is a homage to Stan Lee, the famous DC and\n"
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
st.stranglethornAmbience = "Just a really peacful location to level fishing. I can\n"
							.."see the waterfall from here but the sound doesn't\n"
							.."intrude. I can balance my audio ambience and music\n"
							.."how it suits me and just while away the time!"
st.sundayStrollTitle="A relaxing Sunday stroll.\nWhat could possibly go wrong?"
st.sundayStroll ="I just love these pathways\nthat connect the zones! <3"
st.theUnknownSoldier = "So many questions. The two Dark Portal guardians. Why?\n\n"
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
st.thisSoCute = "Should I or shouldn't I...\n\n"
				.."Often I reveal the details of the Vignette.\n"
				.."Half the time you may not bother to fly there?\n\n"
				.."Well, I just love these extras, these little\n"
				.."glimpses of eveyday life in Azeroth.\n\n"
				.."But this scene is just so cute yeah?\n\n"
				.."What's up with Jessel? Exhausted from being\n"
				.."a parent I guess!"
st.virility = "Something quite remarkable\n"
			.."about this statue. Did you\n"
			.."notice his wood? Strategically\n"
			.."placed wood to hide what would\n"
			.."surely be his impressive...\n\n"
			.."Did somebody say wood again?"
st.wasItWorthTheTrip = "A quaint little grove of orange shrooms...\n\n"
						.."I waited and waited for something to occur.\n"
						.."I mean, you know about the Whispering\n"
						.."Forest in Tirisfal Glades?\n\n"
						.."Alas... nothing happened at all and in the\n"
						.."end I simply enjoyed my shrooms.\n\n"
						.."And that begged the question of was the trip\n"
						.."all the way over to here even worth it?...\n\n"
						.."Yeah! Just love the art for art's sake!"
st.welcomeMachine = "The Cataclysm threw up some changes\n"
						.."and good to see that the Hillsbrad\n"
						.."story, which begins here, is so self\n"
						.."aware.\n\n"
						.."Do yourself a favour and complete\n"
						.."this quest!"
st.whiteOut = "Sadly, wouldn't be the first plane\n"
				.."to slam into a mountain side"
st.yarrr = "((Perfect for International Talk Like A\n"
				.."Pirate Day... or any day for that matter..\n"
				.."is my AddOn called \"Yarrr\" @ Curseforge.\n\n"
				.."Lots of piratey themed random yells!\n\n"
				.."Get it now while stocks last!))"
					
points[ 14 ] = { -- Arathi Highlands
	[71870431] = { name="Egregious Ride Share Surge Pricing", tip=st.sharpbeak },
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
points[ 15 ] = { -- Badlands
	[08747981] = { name="Now that was tricky!", tip=st.questNextToFM },
	[09597845] = { name="Kibler's Exotic Pets", tip=st.kibler },
}
points[ 17 ] = { -- Blasted Lands
	[14491467] = { name="Abandoned Kirin Tor Camp", tip=st.ebonchill },
	[17382103] = { name="Morgan's Plot Glitch", tip=st.morgansPlotGlitch },
	[27170144] = { name="Ghostly Trees", tip="The trees look positively tormented!" },
	[33527906] = { name="Was It Worth the Trip?", tip=st.wasItWorthTheTrip },
	[45448612] = { name="Come, fly right in!", tip=st.garrod },
	[64625555] = { name="Four Skeleton Friends", tip=st.fourSkeletons },
}
points[ 36 ] = { -- Burning Steppes
	[02677869] = { name="Jeremiah Seely", tip=st.jeremiahSeely },
	[03955678] = { name="Hi Ho Hi Ho It's Off to the Expedition We Go...", tip=st.hiHoHiHo },
	[20292411] = { name="Don't Look Down!", tip=st.secondHighestPeakEK },
	[34477856] = { name="Plugs", tip=st.plugs },
	[54122388] = { name="Now that was tricky!", tip=st.questNextToFM },
	[54952256] = { name="Kibler's Exotic Pets", tip=st.kibler },
	[78295882] = { name="Blast Off!", tip="Whether you're Horde or Alliance (or even\n"
										.."a confused Panda I suppose) Sharon has one\n"
										.."helluva rocket ride for you to Bogpaddle\n\n"
										.."It's a one way trip so do make sure that\n"
										.."you're all done here!" },
}
points[ 42 ] = { -- Deadwind Pass
	[12694048] = { name="Dregoth", tip=st.dregoth, outdoors=true },
	[24038144] = { name="The Slough of Dispair", tip="Let's not quibble about spelling errors\n"
						.."in unfinished areas!\n\nSpeaking of unfinished... this pit is\n"
						.."ready for the meat wagon deliveries!", outdoors=false },
	[25707270] = { name="Mass Burials - Cheaper buy the dozen!", tip="How many stiffs do you\n"
					.."think are in this mound?", outdoors=false },
	[27762902] = { name="Abercrombie and Fitch", tip=st.abercrombieAndFitch, outdoors=true },
	[28378144] = { name="The Upside-down Sinners", tip="They are in this pool. I counted 40", outdoors=false },
	[29138132] = { name="The Upside-down Sinners", tip="Secret underwater passage here", outdoors=false },
	[31418112] = { name="To The Upside-down Sinners", tip="Dive down into this ante-pool", outdoors=false },
	[31592397] = { name="The Unknown Soldier", tip=st.theUnknownSoldier, outdoors=true },
	[32117362] = { name="Doodad Thingumies", tip="Some great names", outdoors=false },
	[33477962] = { name="Mass Burial & Massacres", tip="I wonder which massacre is buried here?", outdoors=false },
	[33487071] = { name="Forgotten Crypt side-passage", tip="Go this way, taking the first right, to descend", outdoors=false },
	[35523522] = { name="It's Hopeless, I'm All tied Up", tip=st.abandonedHope, outdoors=true },
	[35637344] = { name="Pauper's Walk side-passage", tip="Go this way, always left, to descend", outdoors=false },
	[35656450] = { name="Abandoned Kirin Tor Camp", tip=st.ebonchill, outdoors=true },
	[36336951] = { name="Pauper's Walk", outdoors=false, tip="Too poor for a grave or tomb?\n"
					.."No worries!... We've plenty of\nopen pigeon holes for you!" },
	[36518091] = { name="Tome of the Unrepentant", outdoors=false,
					tip="Spell checking wasn't a thing\nfor unfinished content" },
	[37757706] = { name="Lucid Nightmare / Puzzler's Desire", outdoors=false, tip="On top of the bone pile will be the\n"
					.."\"Puzzler's Desire\" container IF you\nhave completed the arduous \"Lucid\n"
					.."Nightmare\" mount hunt puzzles!" },
	[37777329] = { name="Rez Location is Here", outdoors=false, tip="Only possible if you stood where I\n"
												.."told you. Otherwise, rez inside the\n"
												.."first room and drop down into the\n"
												.."\"Well of the Forgotten\" and do\n"
												.."the walkthrough in reverse!" },
	[38617463] = { name="The Pit of Criminals", outdoors=false, tip="That's a bigger pile of bones than I saw\n"
					.."in the Auchenai Crypts and Mana Tombs!\n\nIf you look up you will see that we are\n"
					.."at the bottom of a dumping hole. That is\n\n"
					.."the \"Well of the Forgotten\" which is far\nabove!" },
	[39342987] = { name="I Sit Upon the Hill of Shame\nA Shameful Task Chose I", tip=st.shamefulTask, outdoors=true },
	[39887381] = { name="Morgan's Plot Glitch", tip=st.morgansPlotGlitch, outdoors=true },
	[52473432] = { name="Ariden's Camp", tip=st.aridensCamp, outdoors=true },
	[54224511] = { name="Ghostly Trees", tip="The trees look positively tormented!", outdoors=true },
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
	[30792567] = { name="Anton and Jermaine, Sitting in a Tree...", tip=st.antonJermaine },
	[34356115] = { name="Mechano-arachnid", tip=st.mechanoArachnid },
	[47532937] = { name="Three Minute Pause!", tip=st.sledFall },
	[57222838] = { name="Return to Mulverick! (Erm... in AV)", tip=st.seasonedAV },
	[57912395] = { name="Slip Slidin' Away", tip=st.sledStart },
	[58682192] = { name="Meet Ollie!", tip=st.ollie },
	[59516795] = { name="Nice landing!", tip=st.planeCamp },
	[60492040] = { name="Cave Hotel at the Top of the World", tip=st.sledCave },
	[62211779] = { name="White Out", tip=st.whiteOut },
	[62622141] = { name="Keep Yer Feet on the Ground!", tip=st.ironforgeGuardPatrol },
	[64142617] = { name="Glad You Made It!", tip=st.highPointEK },
	[68690342] = { name="Dwarven Farmland", tip=st.dwarvenFarm },
	[75931680] = { name="All Aboard!", tip=st.rixaTransport },
}
points[ 47 ] = { -- Duskwood
	[06042360] = { name="We really do love you Hogger. Kinda...", tip=st.hogger },
	[06441595] = { name="Here's Looking at You!", tip=st.gnollTent },
	[09571188] = { name="Here's Looking at You!", tip=st.gnollTent },
	[19814448] = { name="Grave Moss", tip=st.graveMoss },
	[73484581] = { name="Dregoth", tip=st.dregoth },
	[87433521] = { name="Abercrombie and Fitch", tip=st.abercrombieAndFitch },
	[90983053] = { name="The Unknown Soldier", tip=st.theUnknownSoldier },
	[94624094] = { name="It's Hopeless, I'm All tied Up", tip=st.abandonedHope },
	[94746805] = { name="Abandoned Kirin Tor Camp", tip=st.ebonchill },
	[98153599] = { name="I Sit Upon the Hill of Shame\nA Shameful Task Chose I", tip=st.shamefulTask },
	[98657667] = { name="Morgan's Plot Glitch", tip=st.morgansPlotGlitch },
}
points[ 23 ] = { -- Eastern Plaguelands
	[05332745] = { name="The wall!", tip="Travelling north I hit a wall right here" },
	[07088583] = { name="Have a Look Around", tip=st.caerDarrow },
	[15991428] = { name="The wall!", tip="Travelling north I hit a wall right here" },
	[34561359] = { name="The wall!", tip="Travelling north I hit a wall right here" },
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
	[24939513] = { name="We really do love you Hogger. Kinda...", tip=st.hogger },
	[25248918] = { name="Here's Looking at You!", tip=st.gnollTent },
	[27678602] = { name="Here's Looking at You!", tip=st.gnollTent },
	[40406390] = { name="Four Children", tip=st.fourChildren },
	[41786950] = { name="Step right up!", tip=st.darkmoonPortalA },
	[44205330] = { name="The Cat Lady", tip=st.catLady },
	[46306200] = { name="Children of Goldshire",
					tip="Arguably the most famous easter egg of all\n"
						.."in the Eastern Kingdoms. Be here at 07:00,\n"
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
	[60053017] = { name="Jeremiah Seely", tip=st.jeremiahSeely },
	[61211029] = { name="Hi Ho Hi Ho It's Off to the Expedition We Go...", tip=st.hiHoHiHo },
	[82946330] = { name="Terry Palin - He's a lumberjack, he's okay!",
						tip="I'm a lumberjack\nand I'm okay,\n"
							.."I sleep all night\nand I work all day,\n"
							.."I cut down trees,\nI wear high heels,\n"
							.."Suspendies and a bra,\n"
							.."I wish I'd been a girlie,\n"
							.."Just like my dear pa-pa\n\n"
							.."((Named after Terry Jones and Michael Palin))" },
	[88933005] = { name="Plugs", tip=st.plugs },
}
points[ 94 ] = { -- Eversong Woods
	[21489502] = { name="Don't hold your breath. Erm...", tip=st.holdBreath },
	[27861133] = { name="Lonesome Coral?", tip=st.lonesomeCoral },
	[40871596] = { name="This is just so cute!", tip=st.thisSoCute },
}
points[ 95 ] = { -- Ghostlands
	[07941568] = { name="Don't hold your breath. Erm...", tip=st.holdBreath },
	[10967877] = { name="The wall!", tip="Travelling south I hit a wall right here" },
	[12072438] = { name="Moonwells of the Ghostlands",
					tip="The music you hear at this Night Elf\n"
						.."foothold is shared by one other location,\n"
						.."the Temple of the Moon in Darnassus" },
	[13165673] = { questName={ "The Lady's Necklace", "Journey to Undercity" } , quest={ 9175, 9180 },
					name="We are no longer part of the Scourge.\nFrom here on out, we will be known as\n"
						.."the Forsaken. We will find our own\npath in this world, and slaughter\n"
						.."everyone who stands in our way.",
					tip="The Undead and Humans that occupy\nWindrunner Spire have a chance to\n"
						.."drop \"The Lady's Necklace\".\n\nYou will truly enjoy following this through\n"
						.."to its epic conclusion. A magnificent\nvisual and auditory treat awaits you!\n\n"
						.."For sake of convenience this should be\nyour final task in the Ghostlands!\n\n"
						.."(Note: Horde only! The quote is from\n\"The Frozen Throne\", Warcraft III)" },
	[32525878] = { name="All Hope Abandon Ye",
					tip="...they were certainly abandoned all right.\n\n"
						.."Those responsible for the mass burials here\n"
						.."no doubt had good cause to leave rapidly.\n\n"
						.."Perhaps something from over\nyonder at The Dead Scar?" },
}
points[ 25 ] = { -- Hillsbrad Foothills
	[02725551] = { name="Paint it Pink... Just a Little Bit", tip=st.sparsePink },
	[03635215] = { name="It's the Same But It Isn't!", tip=st.shadowfangKeep },
	[89393084] = { name=st.sundayStrollTitle, tip=st.sundayStroll },
	[90960258] = { name="Have a Look Around", tip=st.caerDarrow },
}
points[ 48 ] = { -- Loch Modan
	[96943269] = { name=st.miaMalkovaTitle, tip=st.miaMalkova },
}
points[ 469 ] = { -- New Tinkertown
	[31190428] = { name="Anton and Jermaine, Sitting in a Tree...", tip=st.antonJermaine },
	[75501406] = { name="Three Minute Pause!", tip=st.sledFall },
	[97766999] = { name="Mechano-arachnid", tip=st.mechanoArachnid },
}
points[ 50 ] = { -- Northern Stranglethorn
	[02221279] = { name="Exit guaranteed! Entrance? Not so much!", tip=st.deadminesExit },
	[12063055] = { name="Hold real still now and say \"cheese\"...", tip=st.petrifiedYojamba },
	[13051727] = { name="Exit from Ironclad Cove", tip=st.defiasGate },
	[17260081] = { name="Here's Looking at You!", tip=st.gnollTent },
	[19530403] = { name="Here's Looking at You!", tip=st.gnollTent },
	[20720108] = { name="Here's Looking at You!", tip=st.gnollTent },
	[23330282] = { name="Here's Looking at You!", tip=st.gnollTent },
	[74307900] = { name="Stranglethorn Ambience & Fishing", tip=stranglethornAmbience },
	[75883192] = { name="Black Ice - A VISIBLE Ring", tip=st.blackIce },
	[87170293] = { name="Morgan's Plot Glitch", tip=st.morgansPlotGlitch },
}
points[ 425 ] = { -- Northshire
	[19229327] = { name="The Cat Lady", tip=st.catLady },
	[76001040] = { name="Jeremiah Seely", tip=st.jeremiahSeely },
}
points[ 49 ] = { -- Redridge
	[02800704] = { name="Plugs", tip=st.plugs },
	[27974819] = { name="Plugs", tip="Suppose this is where all the kids hang out to go fishin' I guess!" },
	[81003825] = { name="Oh You'll Take the High Road\nAnd I'll Take the Low Road...",
						tip="So practical. How did Horde travel between\n"
						.."the Swamp of Sorrows and the Burning Steppes?\n\n"
						.."They walk along this path of course! It completely\n"
						.."avoids the pesky Alliance zone of Redridge.\n\n"
						.."Let's put our rose tinted glasses on and recall\n"
						.."those \"good ole days\"!\n\n"
						.."(I didn't forget Sharon's rocket ride, sigh)"
 },
}
points[ 32 ] = { -- Searing Gorge
	[20360403] = { name="Nice landing!", tip=st.planeCamp },
	[35019356] = { name="Don't Look Down!", tip=st.secondHighestPeakEK },
	[82819324] = { name="Now that was tricky!", tip=st.questNextToFM },
	[83979137] = { name="Kibler's Exotic Pets", tip=st.kibler },
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
	[41257089] = { name="Paint it Pink... Just a Little Bit", tip=st.sparsePink },
	[42306700] = { name="It's the Same But It Isn't!", tip=st.shadowfangKeep },
}
points[ 84 ] = { -- Stormwind
	[42348168] = { npc=5496, name="I'm Green With Envy!", tip=st.sandahl },
	[42807640] = { item=134831, npc=130828,
					tip="Gordon Mackellar - Toy Boy\n\n"
						.."He's inside the Pyrotechnics shop.\n\n" ..st.doomsayersRobes
						.."\n\nWait, there's bonus trivia!!!\n\n"
						.."You might not be in to toys. That's okay!\n\n"
						.."Go there anyhow to see the crazy way he\n"
						.."moves between the barrels of fireworks!\n\n"
						.."Yup, he's doing that in the air, not water!" },
	[39636393] = { name="Vale Son of Stormwind and Azeroth's Last Hope!",
					tip="((There is some phasing. You may not experience this))\n\n"
						.."You MUST come here, take a seat and listen to the music\n"
						.."as the life of the great Varian Wyrnn is commemorated.\n\n"
						.."At times melancholy, at times haunting, it's a fitting\n"
						.."tribute to an incredible leader. Vale King Varian!\n\n"
						.."    \124cFFFDD017My son, a terrible darkness has returned to our world.\n"
						.."    As before, it seeks to annihilate all that we hold dear.\n"
						.."    I go to face it, knowing I may not return.\n"
						.."    All my life, I have lived by the sword.\n"
						.."    I have seen kingdoms burn and watched brave heroes die in vain.\n"
						.."    It’s been... difficult for me to trust after losing so much.\n"
						.."    But from you, I have learned patience…tolerance... and faith.\n"
						.."    OPEN FIRE!\n"
						.."    Anduin, I now believe as you do. That peace is the noblest aspiration.\n"
						.."    But to preserve it... you must be willing to fight!\n"
						.."    FOR AZEROTH!\n" },
	[45826377] = { name="Canticle of Sacrifice", tip="Elor bindel\nMorin'aminor\nLende anu\nShorel'aran\n\n"
						.."Ann'da anore\nSelama ashal'anore\nDiel shala anu bala\nAnar'alah\n"
						.."Ash'thero'dalah'dor\nAnn'da,Band'or shorel'aran\n\n"
						.."The English translation from the Thalassian:\n\n"
						.."Sleep forever\nin quiet serenity\nWe bid you\nfarewell\n\nFather of our people\n"
						.."Justice for our people\nSafe journey\nBy the light\nwatch our land\nFather, Farewell" },
	[47888440] = { npc=82564, name="Volunteers needed!", tip=st.nakada },
	[50055283] = { name="Lord Krazore", tip="An enigma! This grandly titled Dark Iron Dwarf\n"
											.."appeared at the start of \"Dragonflight\". He's\n"
											.."patrolling around the front of the Cathedral.\n"
											.."Why did he suddenly arrive in Stormwind?\n"
											.."Nobody knows! Others have likewise popped\n"
											.."up in several locations across Azeroth!" },
	[50368405] = { name="Mage Quarter Garden", tip="Beneath the Tower is a delightful area.\n\n"
						.."Come see for yourself! Lot's of\nconversations and things happening.\n\n"
						.."The garden is bursting with flavour!" },
	[50518746] = { name="Your daughter is just fine sir!",
					tip="I dare you to look Archmage Malin\nin the eye after you've completed\n"
						.."your work, in particular that ley line\ntask south-west of Star's Rest.\n\nFeel's good, huh?" },
	[52796231] = { name="The Secret Garden", tip="A charming little secluded garden\n\n((Added some time around Cata iirc))" },
	[54115329] = { name="Vale Alonsus Faol, Paladin\nfounder and great leader",
					tip="((It's obvious I strongly disagree with some\n"
					.."of the lore wipes and changes of Cataclysm.\n"
					.."This one is different but no less egregious))\n\n"
					.."Uther is a revered Alliance leader and he\n"
					.."definitely should be remembered but...\n\n"
					.."At the time of the Opening of the Tomb of\n"
					.."Sargeras (aka \"Legion\") his memorial\n"
					.."appeared here. Not the most appropriate\n"
					.."location choice. In fact, it required the\n"
					.."erasing of the memorial to Alonsus Faol.\n\n"
					.."Known as the Archbishop of the Church of\n"
					.."the Holy Light, Faol is instrumental in the\n"
					.."reconstruction of the Cathedral of Light,\n"
					.."indeed he was its Archbishop! With Anduin\n"
					.."Lothar he founded the Order of the Knights\n"
					.."of the Silver Hand - aka Paladins!!\n\n"
					.."There is much more. It is insulting to move\n"
					.."his memorial to a forgotten nook in Tirisfal.\n\n"
					.."Uther's statue could have been placed in\n"
					.."many locations. It didn't have to be here!" },
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
	[57215632] = { name="What a Fuzzy Puzzle!", tip="Charming pair of Cats in Hats!\n\n"
						.."Hmm, singular that'd be a Cat in a Hat?" },
	[63504757] = { name="Cut-Throat Alley", tip="By foot you'll enter The Shady Lady inn from the canals.\n\n"
												.."Eclectic decor for sure! Quincy has a couple of items\n"
												.."you may not have yet collected. Definitely a hang-out\n"
												.."for shady Gilnean archaeology and relic traders!\n\n"
												.."Step out the back and welcome to Cut-Throat Alley!\n"
												.."Aside from the Stormwind rats there's an empty\n"
												.."house at one end, with a canopy bed upstairs too!\n\n"
												.."By the way, take a closer look at Quincy. Unusually,\n"
												.."he's only wearing torn shorts and not long pants!" },
	[63806160] = { name="Farrah Facet", tip="A homage to the late Farrah Fawcet,\na really popular actress of her time" },
	[72985924] = { name="Custom Treadblade Chopper",
					tip="Got a cool 100,000g?\n\nThen head over here and feast\nyour eyes on this sweet ride!\n\n"
							.."And if you're feeling lucky then\nLenny \"Fingers\" McCoy just\nmight have something for you!" },
	[74835567] = { name="A warm tavern and a cold ale.\nWhat more could we ask for?",
						tip="You have just gotta listen to the whacky\nbro dialogue of Christoph Faral and Aedis\n"
							.."Brom. They manage to reference a few of\nAzeroth's famous fighters too! And of\n"
							.."course there's their unbridled mateship\ntoo.\n\n"
							.."If they aren't present then they' re likely\noff fighting a war somewhere. They'll be\n"
							.."back shortly to slake their thirst" },
	[76255319] = { name="Don't stop movin to that funky, funky beat",
						tip="Every now and again DJ Daphne will yell that\nshe's gonna lay down some funky beats. If you\n"
							.."hear her yell then hurry over to the Pig and\nWhistle for a fantastic dance party!\n\n"
							.."You could wait several hours. She does have\nsome unique chat text though, which might\n"
							.."interest you while you wait.\n\n"
							.."Once the party has started, she'll play a loop\nof her own remix of the Hearthstone \"One\n"
							.."Night in Kharazan\" menu music. It's a banger!!!\n\n"
							.."(I think there's a minimum player requirement)" },
	[78867093] = { name="Zanzil's Embrace", tip="Go downstairs and speak to Gerald Black.\nPurchase a \"Zanzil's Slow Poison\" and\n"
							.."drink it.\n\nYup, that's a seven day long countdown!" },
	[79216819] = { name="Training Hall", tip="You must come here and wander around.\nThe decorations and flavour are next level.\n"
						.."Slowly wander around and feast your eyes.\nSo much eye candy!\n\nCompare that to the SI:7 HQ nearby!\n\n"
						.."Hey, wait a minute, didn't their HQ be right\nhere? No, hang on, their HQ keeps getting\nmoved around!" },
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
	[20210919] = { name="Exit guaranteed! Entrance? Not so much!", tip=st.deadminesExit },
	[26372031] = { name="Hold real still now and say \"cheese\"...", tip=st.petrifiedYojamba },
	[26991200] = { name="Exit from Ironclad Cove", tip=st.defiasGate },
	[29620170] = { name="Here's Looking at You!", tip=st.gnollTent },
	[31050371] = { name="Here's Looking at You!", tip=st.gnollTent },
	[31790187] = { name="Here's Looking at You!", tip=st.gnollTent },
	[33420296] = { name="Here's Looking at You!", tip=st.gnollTent },
	[33867270] = { name="Religiously Worshipping Money", tip=st.christ },
	[35957652] = { name="Arrrrgh It's a Pirate's Life!", tip=st.yarrr },
	[37467779] = { name="A Pirate Shanty", tip=st.broadsideBetty },
	[38947715] = { name="Beware of Parrot Poop on Your Shoulder", tip=st.senegal },
	[65335061] = { name="Stranglethorn Ambience & Fishing", tip=stranglethornAmbience },
	[66312116] = { name="Black Ice - A VISIBLE Ring", tip=st.blackIce },
	[73370303] = { name="Morgan's Plot Glitch", tip=st.morgansPlotGlitch },
	[82393546] = { name="Was It Worth the Trip?", tip=st.wasItWorthTheTrip },
	[89063940] = { name="Come, fly right in!", tip=st.garrod },
	[99782232] = { name="Four Skeleton Friends", tip=st.fourSkeletons },
}
points[ 467 ] = { -- Sunstrider Isle
	[29771532] = { name="Lonesome Coral?", tip=st.lonesomeCoral },
	[69802960] = { name="This is just so cute!", tip=st.thisSoCute },
}

points[ 51 ] = { -- Swamp of Sorrows
	[02555400] = { name="Ariden's Camp", tip=st.aridensCamp },
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
	[34216171] = { name="Religiously Worshipping Money", tip=st.christ },
	[37686807] = { name="Arrrrgh It's a Pirate's Life!", tip=st.yarrr },
	[40187017] = { name="A Pirate Shanty", tip=st.broadsideBetty },
	[42646910] = { name="Beware of Parrot Poop on Your Shoulder", tip=st.senegal },
	[86472504] = { name="Stranglethorn Ambience & Fishing", tip=stranglethornAmbience },
}
points[ 26 ] = { -- The Hinterlands
	[23943838] = { name=st.sundayStrollTitle, tip=st.sundayStroll },
	[25920270] = { name="Have a Look Around", tip=st.caerDarrow },
	[53276656] = { name="Egregious Ride Share Surge Pricing", tip=st.sharpbeak },
	[63536009] = { name="How did we do today?",
						tip="Sharpbeak drops you here. It's a\n"
						.."slow taxi, not worth it soz to say" },
}
points[ 18 ] = { -- Tirisfal Glades
	[14565256] = { name="Somthing's Fishy!",
					tip="A gnome skeleton with a dagger between the ribs.\n\n"
					.."A well prepared / provisioned fishing setup. Related\n"
					.."to the crashed plane? I think not." },
	[15425612] = { name="So Many Bubbles!", tip=st.artifactWeapons, },
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
	[61367060] = { name="He has so much wood", tip=st.virility },
	[88812656] = { name="The wall!", tip="Travelling north I hit a wall right here" },
}
points[ 20 ] = { -- Tirisfal Glades - Keeper's Rest - Tomb of Tyr
	[37461241] = { name="So Many Bubbles!", tip=st.artifactWeapons, },
}
points[ 241 ] = { -- Twilight Highlands
	[42318344] = { name=st.miaMalkovaTitle, tip=st.miaMalkova },
	[73721657] = { name="You First!", random=0.3, tip="Another fresh body. Why so many?" },
	[73981897] = { name="She said it was 65 yards!", random=0.3, tip="Another aged goblin. What happens at The\n"
						.."Krazzworks when your productivity slows?" },
	[74631372] = { name="Come on Down!", random=0.3, tip="She probably died quite recently too.\n"
						.."Pushed, fell, jumped? You be the judge!" },
	[76132000] = { name="It's a Long Way to the Top", random=0.3, tip="How does one \"retire\" from The\n"
						.."Krazzworks. Compulsory at a certain age?" },
	[76401275] = { name="Time to Go!", random=0.4, tip="So many dead workers, aged and... dead.\n"
						.."Is patricide a thing at The Krazzworks?" },
	[78411391] = { name="OH&S Meeting Today!", random=0.3, tip="How do management deal with OH&S issues?\n"
						.."Did the worker representatives all \"fall\"?" },
	[79602083] = { name="This will be the best selfie!", random=0.4, tip="The only young \"victim\". The others\n"
						.."are all aged. A red herring to throw\nus off the scent? Was she investigating\n"
						.."the sad demise of the others?" },
	[79961598] = { name="Your Number's Up!", random=0.4, tip="Interestingly the bodies are mostly of a\n"
						.."similar age. A pact ritual or ritual culling?" },
}
points[ 90 ] = { -- Undercity
	[63842611] = { name="He has so much wood", tip=st.virility .."\n\n(Above in the Ruins)" },
}
points[ 22 ] = { -- Western Plaguelands
	[03635776] = { name="He has so much wood", tip=st.virility },
	[32481149] = { name="The wall!", tip="Travelling north I hit a wall right here" },
	[51961745] = { name="The wall!", tip="Travelling north I hit a wall right here" },
	[67891396] = { name="The wall!", tip="Travelling north I hit a wall right here" },
	[69526869] = { name="Have a Look Around", tip=st.caerDarrow },
	[77880161] = { name="The wall!", tip="Travelling north I hit a wall right here" },
}
points[ 52 ] = { -- Westfall
	[38978427] = { name="Exit guaranteed! Entrance? Not so much!", tip=st.deadminesExit },
	[51668952] = { name="Exit from Ironclad Cove", tip=st.defiasGate },
	[56597024] = { name="Here's Looking at You!", tip=st.gnollTent },
	[59257401] = { name="Here's Looking at You!", tip=st.gnollTent },
	[60647055] = { name="Here's Looking at You!", tip=st.gnollTent },
	[63707260] = { name="Here's Looking at You!", tip=st.gnollTent },
	[67043178] = { name="We really do love you Hogger. Kinda...", tip=st.hogger },
	[67352587] = { name="Here's Looking at You!", tip=st.gnollTent },
	[69762274] = { name="Here's Looking at You!", tip=st.gnollTent },
	[77664789] = { name="Grave Moss", tip=st.graveMoss },
	[82360076] = { name="Four Children", tip=st.fourChildren },
	[83760636] = { name="Step right up!", tip=st.darkmoonPortalA },
}
points[ 56 ] = { -- Wetlands
	[06679870] = { name="Return to Mulverick! (Erm... in AV)", tip=st.seasonedAV },
	[07489345] = { name="Slip Slidin' Away", tip=st.sledStart },
	[08409104] = { name="Meet Ollie!", tip=st.ollie },
	[10538924] = { name="Cave Hotel at the Top of the World", tip=st.sledCave },
	[12578615] = { name="White Out", tip=st.whiteOut },
	[13059044] = { name="Keep Yer Feet on the Ground!", tip=st.ironforgeGuardPatrol },
	[14869607] = { name="Glad You Made It!", tip=st.highPointEK },
	[20256912] = { name="Dwarven Farmland", tip=st.dwarvenFarm },
	[28828498] = { name="All Aboard!", tip=st.rixaTransport },
}

--=======================================================================================================
--
-- KALIMDOR
--
--=======================================================================================================

st.benched = "A lonesome bench on the border.\n\n"
				.."To one side barren and cold.\n"
				.."And on the other lush, green.\n"
				.."The horizon to the left... Teldrassil.\n\n"
				.."Perhaps. Depends really on your\n"
				.."standing with Zidormi in Darkshore\n"
				.."I'd suppose.\n\n"
				.."Don't look down... scary!"
st.bioshock = "Wait a moment... Big Papa, not \"Daddy\"\n"
				.."and Andrew Ryan is \"Anderov Ryon\".\n"
				.."Well that doesn't matter because I can\n"
				.."see little Alice there... and we love\n"
				.."the little sisters of Bioshock...\n\n"
				.."Wait there's more! Some dialogue too!"
st.boatAndSkulls = "Okay... a mysterious boat in a lake...\n\n"
					.."A couple of mysterious skulls and no\n"
					.."sign of whomever owned the boat...\n\n"
					.."Dive below the surface... very spooky!\n\n"
					.."Air bubbles as well? What the...!"
st.camelBoast = "Yeah... probably a humble boast...\n\n"
				.."This is where you get dumped when the\n"
				.."swirling tornado from the Mysterious\n"
				.."Camel Figurine whisks you away to your\n"
				.."destiny in Feralas.\n\n"
				.."((Oh did I say already that I have an\n"
				.."AddOn too for farming the Figurine? It's\n"
				.."called \"HandyNotes - Camel\" of course!))"
st.canoe = "I love the location and especially\n"
			.."the placement of this canoe. Perfect!"
st.crashLanded = "This is where draenei \"wake up\"\nwhen they begin life on Azeroth"
st.cultivation = "With your Tauren \"cultivation\" racial\n"
					.."bonus you'll have plenty of \"buffalo\"\n"
					.."to place in this here \"peace\" pipe"
st.dadanga = "Prior to that questionable \"Cataclysm\"...\n"
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
st.dangui = "Geenia is the only vendor of the \"Formal\n"
				.." Dangui\" and it's only rarely stocked.\n\n"
				.."It's worth a look see if flying past.\n\n"
				.."Might fetch a million on the AH as it's\n"
				.."prized by collectors and RPers alike!"
st.danguiTitle = "Formally Rare"
st.darkmoonPortalH = "The Darkmoon Faire portal is exactly\n"
				.."at this location when it comes around\n"
				.."each month. Before you go rushing in,\n"
				.."grab some Simple Flour from Shadi\n"
				.."Mistrunner on the main Thunderbluff\n"
				.."mesa. And any other materials you'll\n"
				.."need for those sweet profession skill\n"
				.."jumps!"
st.dartingHatchling = "A set of easy to acquire and oh so\n"
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
st.diedAlone = "What strange fate caused this person\n"
				.."to die a lonely death?\n\n"
				.."Nearby a hut, three carefully dug and\n"
				.."marked graves...\n\n"
				.."But why come to here and with a\n"
				.."scoped rifle to end it all?"
st.digRat = "Sigh. So you killed the Dig Rat critter and\n"
				.."finally you scored a Plump Dig Rat? Great!\n\n"
				.."But what's that... it just gets consumed?\n\n"
				.."Sigh. Read. The. Item. Text.\n\n"
				.."(1) Setup a cooking fire. (2) Use it.\n\n"
				.."You're welcome! Recipe learnt!"
st.digRatTitle = "Adiposity-Based Chronic Disease Dig Rat\n"
					.."Erm... Sub-Prime Dimensioned Dig Rat\n"
					.."Oh, ah... Delightfully Rubenesque Dig Rat"
st.donQuijote = "Maximillian of Northshire...\n\n"
					.."As little as possible needs to be said about\n"
					.."this incorrigible fop, for fear of spoiling\n"
					.."arguably the funniest quest chain this side\n"
					.."of Johnny Awesome's twinked bear ass"
st.donQuijoteTitle = "Of Sancho Panza, Dulcinea... and Maximillian"
st.doubleCompanions = "Within Azeroth we know that sometimes\n"
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
st.drazzilb = "One step forward is\n"
				.."two steps backward,\n"
				.."Say it anyway but\n"
				.."It's always awkward"
st.fallaSagewind = "There can't be too many Tauren who are\n"
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
st.feralas = "Map sub-zone text says we are in Feralas.\n"
				.."The music checks. The ambience checks.\n\n"
				.."One small detail though...\n\n"
				.."We ain't in Feralas!"
st.bbqFish = "Just for fun, while researching my\n"
				.."Cod Do Batter fishing AddOn...\n\n"
				.."(shameless self promotion lol)\n\n"
				.."I thought I'd chance my arm...\n\n"
				.."Result was mostly junk, some\n"
				.."coal and a few Volatile Fire and\n"
				.."several Melted Cleavers worth\n"
				.."about 14 gold each!"
st.bbqFishTitle = "Great Place for a BBQ!"
st.gloomWeed = "You can appreciate why Tauren are\n"
				.."so chill and high up on these mesa.\n\n"
				.."By all reports they pack the best\n"
				.."Tirisfal Glades Gloom Weed into the\n"
				.."pipe, hence the acrid red fumes.\n\n"
				.."Do as a famous leader once\n"
				.."advised... Don't inhale!"
st.groundClutter = "Just this once, max out \"Ground Clutter\".\n"
					.."You're welcome! :)\n\n"
					.."((Here we go again... I have an AddOn for\n"
					.."that too so you may seemlessly switch\n"
					.."between gorgeous vistas such as here or\n"
					.."denuded landscapes for farming hard to\n"
					.."see stuff))"
st.hastenExtinction = "Prince Lakma, The Last Chimaerok\n"
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
st.hawkwind = "In this \"space\" on the \"rock\" is\n"
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
st.hyjalHeights = "Hyjal is already mightily elevated,\n"
					.."so who'd have expected this pesky\n"
					.."peak to be in the way?\n\n"
					.."At least the hapless pilot can be\n"
					.."remembered for discovering the\n"
					.."tallest point in Hyjal!"
st.hyjalHeightsTitle = "Dang! Who Put That There?"				
st.justTheTip = "((In November 2021 Blizzard, in order to\n"
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
st.justTheTipTitle = "Just the Tip. Promise.\nSee How it Feels..."
st.korkronLoot = "Okay... so you're new to Azeroth and\n"
					.."somewhat povo? I get that... you don't\n"
					.."have the gold to throw around. Taraezor\n"
					.."to the rescue!\n\n"
					.."The Kor'kron mobs here can drop a cool\n"
					.."24 slot \"Kor'kron Supply Satchel\" and\n"
					.."an incredible three-headed hydra pet,\n"
					.."Gahz'rooki.\n\n"
					.."The bad news: 1 in 250 and 1 in 1,000\n"
					.."drop chances respectively"
st.lakeDumont = "Well that's what I call the island!!!\n\n"
				.."Seems the sole purpose of all these NPCs\n"
				.."is to recognise Blizzard employees who\n"
				.."contributed in some way!\n\n"
				.."Could the fire inside the ruins be a\n"
				.."pyre for, erm, less celebrated ex-staff?"
st.loneSurvivor = "It's highly likely this poor person thinks that\n"
				.."only he/she survived. Just over yonder is the\n"
				.."bustling Ammen Vale settlement and...\n\n"
				.."decades later this poor soul is discovered?"
st.marioLuigi = "Two towers... Muigin in one, Larion\n"
				.."in the other. Look closely at what\n"
				.."they are wearing!\n\n"
				.."Now, swap the \"L\" and \"M\".\n"
				.."Got it yet? No?\n"
				.."Okay... drop the \"n\" too!\n\n"
				.."Prior to the Cataclysm, adventurers\n"
				.."reported that they would hit for 64\n"
				.."damage.\n\n"
				.."((Did you nintendo that amount, Blizzard?))"
st.miniGames = "There are three all told. Horde\n"
					.."only. Reason enough to quest\nhere. A really  fun diversion!"
st.natPagle = "...from the journals of Taraezor...\n\n"
				.."Found him long ago on a small island off Theramore.\n\n"
				.."I can still picture him now. Alone with his mates.\n"
				.."That's Jack and Jim and Johnnie. Not to mention\n"
				.."Jamieson and Glen. And this wild dude who was a\n"
				.."real turkey.\n\n"
				.."I tell you bud, I'm wiser for the stories he told.\n\n"
				.."And forever grateful for the Nat's Lucky Fishing\n"
				.."Pole he gifted me.\n\n"
				.."A solitary man, a solitary existence..."
st.natsLuckyFishingPole = "You'll need 225+ Classic Fishing (i.e.\n"
							.."\"Expert Fisherman\") and your level\n"
							.."must be at the Chromie Time minimum\n"
							.."for Dustwallow Marsh.\n\n"
							.."Reward is an excellent fishing pole\n"
							.."and it goes real well with my HandyNotes\n"
							.."\"Let Minnow\" AddOn @ Curseforge!"
st.polyTurtle = "This one is just for disciples of\n"
					.."Khadgar. Mages in other words!\n\n"
					.."Fishing in any Cata zone SCHOOL\n"
					.."can potentially reward the turtle\n"
					.."polymorph!\n\n"
					.."Low drop rate though... but anyone\n"
					.."can receive it. You'll find it on the\n"
					.."AH no doubt!"
st.particleDensity = "Just this once, max out \"Particle Density\".\n"
					.."You're welcome! :)\n\n"
					.."(A great place to experiment with this setting,\n"
					.."ensuring you can squeeze as much out of that\n"
					.."old potato of yours!)"
st.ringo = "What would you think if I sang out of tune?\n"
			.."Would you stand up and walk out on me?\n"
			.."Lend me your ears and I'll sing you a song\n"
			.."And I'll try not to sing out of key\n"
			.."...Oh, I get by with a little help from my friends\n\n"
			.."(Ringo may or may not be in the cave)"
st.rugAndCandles = "The prayer rug was laid down and\n"
					.."the candles, one by one, are being\n"
					.."lit. The circle of candles was\n"
					.."almost complete and then?\n\n"
					.."Argh! Don't leave us hanging!\n"
					.."Misfortune befell the owner of the\n"
					.."rug? Snapped away suddenly by...?"
st.silenceOfTheLambs = "Go underneath to The Pools of Vision.\n\n"
						.."Clarice Foster pats through here...\n\n"
						.."Her doppelganger Jodie Starling\n"
						.."has never been found"
st.stranded = "Oh so sad to see this.\n\n"
				.."You'll notice some others around.\n\n"
				.."Let's start a Tortoise Rescue!"
st.targetPractice = "It is very rare to see anyone\n"
						.."actually using the 100's of\n"
						.."targets we see in our travels.\n\n"
						.."So the denizens of Azeroth\n"
						.."do really practise! Sometimes..."
st.taurenHead = "Look directly above. That's a severed\n"
					.."tauren head that's hanging there. But,\n"
					.."functioning as a dream catcher? Ew!"
st.threeArtOnRock = "Love the \"prehistoric\" style rock art.\n\n"
					.."Who painted it? Why hasn't it weathered?\n\n"
					.."A sign from the Old Gods? Perhaps a prank!"
st.toeToToe = "Where else can you see the elementals\n"
				.."just going for it against each other?"
st.unusedBFA = "This cave and the hut above it were originally\n"
				.."a part of a Warfront story for the Battle for\n"
				.."Azeroth.\n\n"
				.."Sadly, this never happened.\n\n"
				.."By the way... stand here and listen to the\n"
				.."music (you need \"Ambience\" turned up)"
st.viciousGiants = "Hang around a bit... these cute\n"
					.."critters are not so cute!\n\n"
					.."They seem to randomlt transform\n"
					.."into vicious, bloodthirsty giant\n"
					.."versions of themselves!"
st.vielTitle = "That old felcloth grind... :("
st.viel = "Every once in a while Vi'el will have\n"
			.."some felcloth for sale. And all the\n"
			.."classic tailors may rejoice. And those\n"
			.."of us farming for cool mogging too!\n\n"
			.."The grind is made doubly difficult if\n"
			.."you need to make mooncloth on the\n"
			.."way to the amazing Mooncloth Robe!!!\n\n"
			.."(Oh yeah... The Henderine Initiates? An\n"
			.."easier source of felcloth for those in the\n"
			.."know. Sadly, with the Cataclysm they\n"
			.."all disappeared. Enjoy the grind baby!)"
st.vortacoil = "Tex here has a great toy for sale.\n"
				.."But would you pay 5000g?\n\n"
				.."The lovely looking apprentice Joanna,\n"
				.."who is standing nearby, is wearing the\n"
				.."Mage starter \"Recruit's Robe\". It's\n"
				.."available in different colours as the\n"
				.."\"Astralaan Robe\" too. The similar\n"
				.."\"Soulcloth Vest\" is also appealing!"
st.warningHash = "Do not toke on this pipe or you'll\n"
					.."make a hash of your gaming sess!"
st.whatYouSmoking = "Something to mull over...\n\n"
					.."Whatever they are smoking,\n"
					.."those noxious looking red\n"
					.."fumes look positively foul!"
st.whereIsEverybody = "Camp fire... check!\n"
						.."Seats... check!\n"
						.."Stash of stuff... check!\n"
						.."Cushion, firewood...\n\n"
						.."Okay... so where are you all?"
st.zangenStonehoof = "Every night at 21:00 ((server time))\n"
						.."Zangen Stonehoof gives a short\n"
						.."speech and lights the bonfire!"

points[ 468 ] = { -- Ammen Vale
	[30241602] = { name="Earth, Wind, Water and Fire!", tip=st.toeToToe },
	[61332957] = { name="Sorry, we crash landed... :(", tip=st.crashLanded },
	[64008593] = { name="Nestlewood Vibes", tip="Just love this cool owlkin area" },
	[42760840] = { name="I'm the Lone Survivor", tip=st.loneSurvivor },
}
points[ 63 ] = { -- Ashenvale
	[00784614] = { name="Come Out, Come Out, Wherever You Are...", tip=st.whereIsEverybody },
	[12049525] = { name="Cultivating Stoned Talon Mountains", tip=st.cultivation },
	[21598965] = { name="Shocking Big Daddy Bio!", tip=st.bioshock },
	[24327458] = { name="Died Alone", tip=st.diedAlone },
	[47439236] = { name="What You Smoking?", tip=st.whatYouSmoking },
	[51168508] = { name="A Simple Canoe", tip=st.canoe },
	[83261380] = { name=st.bbqFishTitle, tip=st.bbqFish }, 
}
points[ 76 ] = { -- Azshara
	[07740686] = { name=st.hyjalHeightsTitle, tip=st.hyjalHeights }, 
	[19955657] = { name="Gallywix Pleasure Palace",
						tip="The pleasure is all yours at this ultimate\n"
							.."shrine to one's love of indulgence.\n\n"
							.."Why not take a seat at the cocktail bar\n"
							.."and gaze across the Azshara vista towards\n"
							.."the gates of Orgrimmar?\n\n"
							.."Perhaps a dip in the outdoor heated spa\n"
							.."is more to your liking?\n\n"
							.."Nevermind if you miss your chip or putt!\n"
							.."Nobody saw you so go on, give it a nudge!\n\n"
							.."Inside a suckling pig awaits. Tuck in!\n\n"
							.."Upstairs, it's trippy man! It's got that\n"
							.."wholesome 70's vibe. Yup, it's a \"love in\"!" }, 
	[25563805] = { name="Of Toys and Chests...", tip=vortacoil }, 
	[25630494] = { name=st.vielTitle, tip=viel }, 
	[25663942] = { name="Target Practice", tip=st.targetPractice }, 
	[28215290] = { name="Love that sneer!",
						tip="That's an impressive shrine to oneself!\n\n"
							.."Not sure what I'm on about? That's\n"
							.."okay, just stand here and face west.\n\n"
							.."Yeah, they got the expression just right!" }, 
	[39898476] = { name="When you need to cast an expelianus...",
						tip="I was in desperate need to release the kraken.\n"
							.."When my best friend, DJ Trolldya, caught wind\n"
							.."of my plugged up condition he said\n\n"
							.."    \"Don't worry mon, Bingham Gadgetspring\n"
							.."    has just the thing to get you movin'\"\n\n"
							.."and of course I listened, after all I'm not\n"
							.."typically the stuck up sort. So I flew here and\n"
							.."I went upstairs, but I'm not so sure now. If I\n"
							.."were a tauren then it's of course not a\n"
							.."problem, even if a friend needs to assist by\n"
							.."rolling up a sleeve and greasing an arm.\n\n"
							.."But how do the little people fair? I'm only\n"
							.."a gnome. I recall my friend saying\n\n"
							.."    \"Relax mon, it's a suppository\"\n\n"
							.."Butt, your milage may vary so come here and\n"
							.."see for yourself. The instruction manual is\n"
							.."nearby, along with a lamp to shine a light on\n"
							.."the problem area. There's a toolbox too with\n"
							.."lots of gadgets, inclduing some calipers! You\n"
							.."might care to borrow Bingham's large mallet.\n"
							.."No paperwork. Just be sure to return\n"
							.."everything once the job is done!" }, 
	[56041212] = { name="Mini games!", tip=st.miniGames }, 
	[69808506] = { name="Area 51 3/4",
						tip="Attention aliens:\n\n"
							.."This is the officially designated\n"
							.."landing zone for all Star Visitors!" }, 
	[80973246] = { name="A magnificent ancient erection",
						tip="Phloem has been standing here an eternity,\n"
							.."determined to savour its wonderous riches\n\n"
							.."(Interestingly, you can see this same\n"
							.."Kaldorei structure repated elsewhere\n"
							.."in Azeroth)" }, 
	[85825684] = { name="Your guess is as good as mine...",
						tip="Of course we know what this\nis meant to be. Erm, don't we?" }, 
}
points[ 97 ] = { -- Azuremyst Isle
	[22337021] = { name="Totemic Wards", tip=st.taurenHead },
	[26952592] = { name="Come, Say Hi!",
						tip=  "Susurrus and Velaada don't get many\n"
							.."visitors these days. Not since the\n"
							.."dubious over simplifications which\n"
							.."arose from the Cataclysm. ;)\n\n"
							.."Still, wander up and say hi!\n\n"
							.."And if you're a shammy, think\n"
							.."of what might have been, back\nin the day!\n\n"
							.."I've marked the start of the\n"
							.."path for you" },
	[45511835] = { name="Tauren Trophy", tip=st.taurenHead },
	[70373701] = { name="Earth, Wind, Water and Fire!", tip=st.toeToToe },
	[75963360] = { name="I'm the Lone Survivor", tip=st.loneSurvivor },
	[84264306] = { name="Sorry, we crash landed... :(", tip=st.crashLanded },
	[85456824] = { name="Nestlewood Vibes", tip="Just love this cool owlkin area" },
}
points[ 99 ] = { -- Azuremyst Isle - Stillpine Hold
	[22108928] = { name="Tauren Trophy", tip=st.taurenHead },
}
points[ 462 ] = { -- Camp Narache
	[39453726] = { name="Quark, Strangeness and Charm", tip=st.hawkwind },
}
points[ 62 ] = { -- Darkshore
	[73687192] = { name="Too much ground clutter?", tip=st.groundClutter }, 
	[76544700] = { name="Particle Density", tip=st.particleDensity }, 
	[86600551] = { name=st.danguiTitle, tip=st.dangui },
	[87751911] = { name="Candles and Rug", tip=st.rugAndCandles },
	[94649467] = { name=st.bbqFishTitle, tip=st.bbqFish }, 
}
points[ 66 ] = { -- Desolace
	[87042785] = { name="Vicious Giants", tip=viciousGiants },
	[89354944] = { name="Silence of the Lambs", tip=st.silenceOfTheLambs },
	[89806417] = { name="Step Right Up!", tip=st.darkmoonPortalH },
	[90582690] = { name="Ancient Art?", tip=st.threeArtOnRock },
	[91935221] = { name="Surgeon General Says...", tip=st.warningHash },
	[95435537] = { name="Honoured Ancestors", tip=st.zangenStonehoof },
	[96705343] = { name="Advice to Mull Over", tip=st.gloomWeed },
}
points[ 1 ] = { -- Durotar
	[05626838] = { name="The Emerald Dream is Fake!", tip=st.fallaSagewind },
	[06125383] = { name="Did You See the Three-Headed Hydra?", tip=st.korkronLoot },
}
points[ 70 ] = { -- Dustwallow Marsh
	[23226046] = { name=st.digRatTitle, tip=st.digRat },
	[28399352] = { name="Stranded!", tip=stranded },
	[37153309] = { name="What's in a Name?", tip=st.drazzilb },
	[47841667] = { name="Awww They're So Cute!", tip=st.dartingHatchling },
	[58076065] = { name="Nat Pagle", tip=st.natPagle },
	[58766017] = { quest={ 6607 }, questName={ "Nat Pagle, Angler Extreme" }, tip=st.natsLuckyFishingPole },
}
points[ 77 ] = { -- Felwood
	[58465232] = { name="Too much ground clutter?", tip=st.groundClutter }, 
	[61512575] = { name="Particle Density", tip=st.particleDensity }, 
	[80817658] = { name=st.bbqFishTitle, tip=st.bbqFish }, 
	[92335217] = { name=st.hyjalHeightsTitle, tip=st.hyjalHeights }, 
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
	[47937663] = { name="Hasten the Extinction!", tip=st.hastenExtinction },
	[47961049] = { name="Luvin' the Odds!", tip=st.doubleCompanions },
	[62400768] = { name="Boat and Bubbles!", tip=st.boatAndSkulls },
	[63991141] = { name="Tribute Island", tip=st.lakeDumont },
	[66537244] = { name="Will that be one hump or two?", tip=st.camelBoast },
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
	[69627455] = { name="Cut Content", tip="((This whole area was intended to be part\nof the Patch 4.1 storyline, specifically\n"
					.."the Twilight Hammer's attempt to invade\nthe elemental plane of water, aka The\nAbyssal Maw storyline.\n\n"
					.."You can see the cut content on Wowpedia.\nUninspiring quests. Best decision ever:\n"
					.."Cut the woeful quests and keep the NPCs!))" },
	[70767356] = { name="Get the @$#&ing hell outa my kitchen!", tip="He doesn't swear and sadly he does not sell\n"
					.."recipes. Nor does he insult you for lacking\nskill at cooking.\n\n"
					.."And here he is... a fallen chef... doing nothing\nmore than chopping water melons and mixing\n"
					.."fruit punch" },
	[84971401] = { name="Quark, Strangeness and Charm", tip=st.hawkwind },
	[94838183] = { name="Vale Dadanga", quest={ 24702 }, questName={ "Here Lies Dadanga" }, tip=st.dadanga },
}
points[ 80 ] = { -- Moonglade
	[52003289] = { name=st.danguiTitle, tip=st.dangui }, 
	[55217097] = { name="Candles and Rug", tip=st.rugAndCandles },
	[64630996] = { name="Bench With a View", tip=st.benched },
}
points[ 198 ] = { -- Mount Hyjal
	[19253790] = { name="Too much ground clutter?", tip=st.groundClutter }, 
	[51167253] = { name=st.bbqFishTitle, tip=st.bbqFish }, 
	[67613768] = { name=st.hyjalHeightsTitle, tip=st.hyjalHeights }, 
	[90767819] = { name="Of Toys and Chests...", tip=vortacoil }, 
	[90853519] = { name=st.vielTitle, tip=viel }, 
	[90897996] = { name="Target Practice", tip=st.targetPractice }, 
}
points[ 7 ] = { -- Mulgore
	[01767388] = { name="Luvin' the Odds!", tip=st.doubleCompanions },
	[20177028] = { name="Boat and Bubbles!", tip=st.boatAndSkulls },
	[22197504] = { name="Tribute Island", tip=st.lakeDumont },
	[34570589] = { name="Vicious Giants", tip=viciousGiants },
	[36482371] = { name="Silence of the Lambs", tip=st.silenceOfTheLambs },
	[36843586] = { name="Step Right Up!", tip=st.darkmoonPortalH },
	[37490511] = { name="Ancient Art?", tip=st.threeArtOnRock },
	[38602599] = { name="Surgeon General Says...", tip=st.warningHash },
	[41492860] = { name="Honoured Ancestors", tip=st.zangenStonehoof },
	[42542700] = { name="Advice to Mull Over", tip=st.gloomWeed },
	[48957835] = { name="Quark, Strangeness and Charm", tip=st.hawkwind },
	[60971624] = { name="Ancient Art?", tip=st.threeArtOnRock },
	[61991753] = { name="Redrock Cave and Hut", tip=unusedBFA },
	[62942399] = { name="Ancient Art?", tip=st.threeArtOnRock },
	[94128319] = { name="What's in a Name?", tip=st.drazzilb },
}
points[ 10 ] = { -- Northern Barrens
	[00715650] = { name="Ancient Art?", tip=st.threeArtOnRock },
	[00108566] = { name="Step Right Up!", tip=st.darkmoonPortalH },
	[01777631] = { name="Surgeon General Says...", tip=st.warningHash },
	[04517878] = { name="Honoured Ancestors", tip=st.zangenStonehoof },
	[05507726] = { name="Advice to Mull Over", tip=st.gloomWeed },
	[21531795] = { name="What You Smoking?", tip=st.whatYouSmoking },
	[22996706] = { name="Ancient Art?", tip=st.threeArtOnRock },
	[23966828] = { name="Redrock Cave and Hut", tip=unusedBFA },
	[24867441] = { name="Ancient Art?", tip=st.threeArtOnRock },
	[25281064] = { name="A Simple Canoe", tip=st.canoe },
	[42856297] = { name="The Emerald Dream is Fake!", tip=st.fallaSagewind },
	[43304959] = { name="Did You See the Three-Headed Hydra?", tip=st.korkronLoot },
}
points[ 85 ] = { -- Orgrimmar
	[50845509] = { item=134831, npc=130911, tip="Charles Gastly - Toy Boy\n\n" ..st.doomsayersRobes },
	[52398576] = { npc=199015, name="Skeletal Troll March", tip="Along with his retinue of similar skeletal\n"
					.."trolls, First Mate Jamboya makes his way\nfrom Grommash Hold past here and\n"
					.."downwards to the first portal room\nwhere they exit to Zandalar.\n\n"
					.."Yes, you can look for them in Vol'dun!" },
}
points[ 81 ] = { -- Silithus
	[12525232] = { name="Welcome to Feralas!", tip=st.feralas },
	[21510163] = { name="Hasten the Extinction!", tip=st.hastenExtinction },
	[88285007] = { name=st.donQuijoteTitle, quest={ 24707 }, tip=st.donQuijote, questName={ "The Ballad of Maximillian" } },
}
points[ 199 ] = { -- Southern Barrens
	[03395922] = { name="Boat and Bubbles!", tip=st.boatAndSkulls },
	[04886272] = { name="Tribute Island", tip=st.lakeDumont },
	[13981188] = { name="Vicious Giants", tip=viciousGiants },
	[15382498] = { name="Silence of the Lambs", tip=st.silenceOfTheLambs },
	[15653391] = { name="Step Right Up!", tip=st.darkmoonPortalH },
	[16121130] = { name="Ancient Art?", tip=st.threeArtOnRock },
	[16942666] = { name="Surgeon General Says...", tip=st.warningHash },
	[19072857] = { name="Honoured Ancestors", tip=st.zangenStonehoof },
	[19832740] = { name="Advice to Mull Over", tip=st.gloomWeed },
	[24556516] = { name="Quark, Strangeness and Charm", tip=st.hawkwind },
	[33391948] = { name="Ancient Art?", tip=st.threeArtOnRock },
	[34142043] = { name="Redrock Cave and Hut", tip=unusedBFA },
	[34842518] = { name="Ancient Art?", tip=st.threeArtOnRock },
	[47908810] = { name=st.digRatTitle, tip=st.digRat },
	[48781632] = { name="The Emerald Dream is Fake!", tip=st.fallaSagewind },
	[49140594] = { name="Did You See the Three-Headed Hydra?", tip=st.korkronLoot },
	[57776871] = { name="What's in a Name?", tip=st.drazzilb },
	[65335708] = { name="Awww They're So Cute!", tip=st.dartingHatchling },
	[72588823] = { name="Nat Pagle", tip=st.natPagle },
	[73078789] = { quest={ 6607 }, questName={ "Nat Pagle, Angler Extreme" }, tip=st.natsLuckyFishingPole },
}
points[ 65 ] = { -- Stonetalon Mountains
	[38081284] = { name="Come Out, Come Out, Wherever You Are...", tip=st.whereIsEverybody },
	[49096083] = { name="Cultivating Stoned Talon Mountains", tip=st.cultivation },
	[58425535] = { name="Shocking Big Daddy Bio!", tip=st.bioshock },
	[60719628] = { name="Vicious Giants", tip=viciousGiants },
	[61094062] = { name="Died Alone", tip=st.diedAlone },
	[63409556] = { name="Ancient Art?", tip=st.threeArtOnRock },
	[83685800] = { name="What You Smoking?", tip=st.whatYouSmoking },
	[87335089] = { name="A Simple Canoe", tip=st.canoe },
}
points[ 71 ] = { -- Tanaris
	[13988820] = { name="Khadgar's Turtling Again!", tip=st.polyTurtle },
	[15070806] = { name="Vale Dadanga", quest={ 24702 }, questName={ "Here Lies Dadanga" }, tip=st.dadanga },
	[18402962] = { name="Do You Need Anybody?", quest={ 24735 },
					questName={ "A Little Help From My Friends" }, tip=st.ringo },
	[19973692] = { name="Patrolling Plumbers", tip=st.marioLuigi },
	[20727153] = { name=st.justTheTipTitle, tip=st.justTheTip },
}
points[ 57 ] = { -- Teldrassil
	[56715355] = { name="Somebody shrunk the world!", tip="The oversize table with it's huge leg\n"
					.."of meat and huges apples do rather\nmake Nyoma and Zarrin seem so small!" },
	[55755204] = { name="Elven water source", tip="Atop a setee is a type of fountain, filling\n"
					.."a bowl with water. Only, the fountain is a\ntree cutting, seeping its life force into\n"
					.."the bowl below. It's a constant flow too!" },
	[55454995] = { name="Elven magnetism", tip="Atop a setee we see a large tree cutting\n"
					.."that is able to suspend two rocks in the air,\nas if there is some magnetic force. Amazing!" },
	[57255296] = { name="Elven magnetism", tip="Atop a setee we see a large tree cutting\n"
					.."that is able to suspend a large rock in the\nair, as if by some magnetic force. Wow!" },
}
points[ 64 ] = { -- Thousand Needles
	[16277471] = { name="Vale Dadanga", quest={ 24702 }, questName={ "Here Lies Dadanga" }, tip=st.dadanga },
	[40020623] = { name=st.digRatTitle, tip=st.digRat },
	[46194567] = { name="Stranded!", tip=stranded },
	[81600645] = { name="Nat Pagle", tip=st.natPagle },
	[82420588] = { quest={ 6607 }, questName={ "Nat Pagle, Angler Extreme" }, tip=st.natsLuckyFishingPole },
}
points[ 88 ] = { -- Thunder Bluff
	[28782589] = { name="Silence of the Lambs", tip=st.silenceOfTheLambs },
	[30708933] = { name="Step Right Up!", tip=st.darkmoonPortalH },
	[39883781] = { name="Surgeon General Says...", tip=st.warningHash },
	[54975141] = { name="Honoured Ancestors", tip=st.zangenStonehoof },
	[60424307] = { name="Advice to Mull Over", tip=st.gloomWeed },
}
points[ 249 ] = { -- Uldum
	[35271718] = { name="Awesome statue!", tip="Nuff said. Check it out!" },
	[56714802] = { name="Khadgar's Turtling Again!", tip=st.polyTurtle },
	[64562860] = { name=st.justTheTipTitle, tip=st.justTheTip },
}
points[ 78 ] = { -- Un'Goro Crater
	[30615114] = { name=st.donQuijoteTitle, quest={ 24707 }, tip=st.donQuijote, questName={ "The Ballad of Maximillian" } },
	[45480777] = { name="Vale Dadanga", quest={ 24702 }, questName={ "Here Lies Dadanga" }, tip=st.dadanga },
	[51974980] = { name="Do You Need Anybody?", quest={ 24735 }, questName={ "A Little Help From My Friends" }, tip=st.ringo },
	[55036404] = { name="Patrolling Plumbers", tip=st.marioLuigi },
}
points[ 83 ] = { -- Winterspring
	[12278953] = { name="Too much ground clutter?", tip=st.groundClutter }, 
	[15286334] = { name="Particle Density", tip=st.particleDensity }, 
	[25851972] = { name=st.danguiTitle, tip=st.dangui },
	[27063402] = { name="Candles and Rug", tip=st.rugAndCandles },
	[30591111] = { name="Bench With a View", tip=st.benched },
	[30700211] = { name="Winter's Veiled Darkshore Glade?", tip="Channel says Darkshore, Minimap\nsub-zone says Veiled Sea. I'm on\n"
					.."the border of Winterspring and\nMoonglade. Well... I'm somewhere!" },
	[45668939] = { name=st.hyjalHeightsTitle, tip=st.hyjalHeights }, 
	[76767865] = { name="It's all about the skulls", tip="Oh and that rotting flesh too!" }, 
	[56041212] = { name="Mini games!", tip=st.miniGames }, 
	[61718766] = { name=st.vielTitle, tip=viel }, 
}

points[ 12 ] = { -- Kalimdor
	[39657988] = { name="Welcome to Feralas!", tip=st.feralas },
	[56751409] = { name="Elwynn Forest?", tip="Don't you love the lush green of\nElwynn... Wait on!\n\n"
					.."These trees aren't quite the same.\nThe music is familiar though!\n\nErm. This is Winterspring.\n\n"
					.."Okay. This is doing my head in!!!" },
	[58314263] = { item=134831, npc=130911,
					tip="Charles Gastly - Toy Boy\n\n" ..st.doomsayersRobes },
}

--=======================================================================================================
--
-- OUTLAND
--
--=======================================================================================================

st.anAppleADay = "So many Apples! If one fell on his head, sure,\nit hurts!. A few dozen? What a headache!\n\n"
			.."Newtonian thoughts aside, somebody cleaved\nhis head apart from point blank range! Now\n"
			.."THAT'S a headache! Wait on... that's his own\nweapon, so that means... hmmm... but why?\n\n"
			.."Don't forget the Loose Dirt Mound which is\nexactly where this pin is. Maybe some\n"
			.."goodies for you!"
st.anAppleADayTitle = "An apple a day... Nah, fcuk it!"
st.babyFarm = "Awww, isn't it so lovely! A well-meaning\nmatron caring for so many children and\nbabies!...\n\n"
			.."Hey... wait a minute there... something's a\nbit off! The small cuts of meat on the\n"
			.."tiered food rack, the tauren floor rugs,\nthe tiny half eaten corpse in the kennel,\n"
			.."cages out the back complete with a tiny\nskeleton...\n\nHate to break it to Chaddo but he ain't\n"
			.."gonna be no chad, his day is very near!\nHmmm... I wonder if he's seen the large\n"
			.."wooden club, next to the kennel?\n\nAnd Sa'rah. well, lo que será, será...\n\n"
			.."Oh yeah, you'll have a blast if you play\nin the sandbox, so do take care now!\n\n"
			.."Ahhh right... so all the babies are Horde\nbut Chaddo and Sa'rah are Alliance? Okay...\n\n"
			.."Did you see Jara? He's in the naughty corner!\n\n((Prior to Blizzard's ill considered burst of\n"
			.."censorship, the sign at the entry gate read:\n\n    \"Challe's Home for Little Tykes\"!\n\n"
			.."Presumably removed because the archaic\nword \"tyke\" in British English means \"small\n"
			.."child\" but also \"Roman Catholic\", which is\nrather derogatory. Oh Blizzard! lol))"			
st.babyFarmTitle = "How ya gonna keep 'em down on the farm\nAfter they've seen Halaa\n"
			.."How ya gonna keep 'em away from harm,\nThat's a mystery"
st.crocolisksTitle = "Chuck, Muckbreath, Snarly and Toothy"
st.crocolisks="Yes, fishing dailies abound and there are\nexcellent rewards on offer such as the Bone\n"
			.."and Jeweled Fishing Poles.\n\nBut Old Man Barlo here in Terokkar offers\n"
			.."four adorable and instantly lovable baby\ncrocolisk pets. Yup. Four!!!\n\n"
			.."20% of the time you'll be offered the\n\"Crocolisks in the City\" daily. And each\n"
			.."of the four pets has a very high drop\nchance with a repeat of a known pet\nextremely unlikely"
st.skyFence = "Just love the way the fence\nis suspended and... yeah! <3"
st.moteCloud = "Back in the day Engineers could fly around Nagrand\nand harness the clouds for farming elemental motes.\n"
			.."They are always located on the floating islands"
st.skywing = "Skywing patrols around here.\nI'm sure you'd love a great\nbattle pet just like this one!"
st.slammer = "Gotta feel for the creature. There it was flying\naround then wham! A flying chunk of Draenor!\n\n"
			.."Another theory is that when Draenor was sundered,\nthis subterranean skeleton was ripped out along\n"
			.."with the chunk of ground too. What's your take?"
				
points[ 100 ] = { -- Hellfire Peninsular
	[10598543] = { name=st.crocolisksTitle, tip=st.crocolisks },
	[54778817] = { name="Don't Fence Me In!", tip=st.skyFence },
}
points[ 107 ] = { -- Nagrand
	[50901440] = { name=st.babyFarmTitle, tip=st.babyFarm },
	[51873042] = { name="Inscruitable Cloudy Sparkling...", tip=st.moteCloud },
	[55993734] = { name="Ouch who put that there?", tip=st.slammer },
	[57892632] = { name=st.anAppleADayTitle, tip=st.anAppleADay },
	[95994079] = { name=st.crocolisksTitle, tip=st.crocolisks },
}
points[ 104 ] = { -- Shadowmoon Valley
	[00894515] = { name="Predatory Strike!", tip=st.skywing, quest={ 10898 }, questName={ "Skywing" }, item=31760 },
	[65748602] = { name="Sorry, Goose, but it's time to buzz the tower", tip="I feel the need, the need for speed but\n"
					.."something tells me your ego is writing\ncheques your body can't cash.\n\n"
					.."Yeah, don't be a Goose, you big stud. Ja'y\nover there talks about the Top Orc ;) and\n"
					.."Ichman, or did he mean Iceman? Dunno.\nNot to forget Mulverick too, or wait,\nwas that Maverick?\n\n"
					.."The question is can you fly? If you can't\nthen you become everyone’s problem.\n"
					.."That’s because every time you go up\nin the air you’re unsafe, and I don’t\n"
					.."like you because you’re dangerous.\n\nProve yourself and you can be my wing-\n"
					.."man any time. But always remember:\n\nYou Don't Have Time To Think Up\nThere. You Think, You're Dead" },
}
points[ 108 ] = { -- Terokkar Forest	
	[38721280] = { name=st.crocolisksTitle, tip=st.crocolisks },
	[53847232] = { name="Predatory Strike!", tip=st.skywing, quest={ 10898 }, questName={ "Skywing" }, item=31760 },
	[80971542] = { name="Don't Fence Me In!", tip=st.skyFence },
}
points[ 102 ] = { -- Zangarmarsh
	[39627232] = { name=st.babyFarmTitle, tip=st.babyFarm },
	[40688992] = { name="Inscruitable Cloudy Sparkling...", tip=st.moteCloud },
	[45219752] = { name="Ouch who put that there?", tip=st.slammer },
	[47298542] = { name=st.anAppleADayTitle, tip=st.anAppleADay },
}

--=======================================================================================================
--
-- NORTHREND
--
--=======================================================================================================

st.afsanehAsrar = "Afsaneh Asrar pats around the\nstairs in The Legerdemain Lounge.\n\nThis is very unusual for an inn\n"
			.."keeper as they are always stationary.\n\nSo stop her at your favoured location\nand set your hearthstone.\n\n"
			.."Now, whenever you hearth, you'll\nreturn to that exact location!"
st.agedWine = "Have a close look at Christi's inventory at\nthe \"One More Glass\" shop.\n\nTwo of the items are noted as:\n\n"
			.."        \"Improves with age\"\n\nPricey yes. and improve with age they do!\n\n"
			.."Deposit in your bank for a rainy RP day...\nand voilà... 365 days later they will\n"
			.."change into something different!\n\nBonus trivia: Try the /drink emote!"
st.arsenic = "What's \"arsenic\" spelled backwards?"
st.arsenicTitle = "?sdrawkcab delleps \"cinesra\" s'tahW"
st.badRogue = "Everything about Nisstina is just so wrong!\n\nIn stealth but she has her pet out? Doh!\n\n"
			.."Her gear... it's a noob mess!\n\nIt's as though she's a parody\nof bad rogue adventurers!\n\n"
			.."Yup. Got a feelin they bin trolled mon!"
st.badRogueTitle = "How Many Fingers Does a Troll Have?"
st.bambi = "In another universe you may find Bambi,\nThumper and Flower. Even the mother of\nBambi!\n\n"
			.."And here too, you can see them running\naround!"
st.bmHunter = "Sholazar Basin is an iconic zone for\nBeast Mastery Hunters.\n\nThree, no less, incredibly difficult to\n"
			.."farm beasts: Aotona with its stunning\nplumage; Loque'nahak, the first ever\nspirit beast and with its awesome eyes\n"
			.."and striking fur markings; King Krush,\nthe fearsome lime green devilsaur!\n\nAnd they were not merely rares but\n"
			.."indeed de rigueur for all adventurers\nkeen on the Frost Bitten achievement.\n\n"
			.."Tales abound to this day of ten year\nfarms. City and zone chat was filled\nwith QQ. Good luck!\n\n"
			.."(Today, BM will get FB credit for taming)"
st.cockroach = "Another iconic farm... this time shaman\nwould camp here for hours in the hope\n"
			.."that Cravitz Lorent would soon spawn.\n\nFinally, they'd be able to purchase the\n\"Tome of Hex: Cockroach\".\n\n"
			.."Bonus fact: The real reason he hides\ndown here is because he's peddling\nsmutty \"Seamy Romance\" novels!\n\n"
			.."Bonus++: Priests will love the\nScarlet Confessional Book. Yup, it's\nso much fun spamming this toy!"
st.darahir = "Darahir sells a nice \"Ghostly Skull\"\npet. Doesn't seem to have a limit so\nI'd guess if you made the trip down\n"
			.."here he'd surely let you buy one!"
st.duoctane = "Did you know that his other\nname is Dominic Toretto?\n\nNow... let's see if we can\nfind where he parked his\n"
			.."black dodge charger!"
st.elixir = "Keep a look out for this elixir, carelessly\nleft lying around by those Kirin Tor mages.\n\n"
			.."I got a fantastic Tuskarr transformation\nand a nice fishing skill bonus to boot!\n\n"
			.."Oh... you didn't get transformed but all\nothers got transformed? Yeah that's the\n"
			.."impressive Tier 2 Netherwind Regalia set.\nDoesn't it look superb!\n\nWhat did you get?"
st.factsOfLife = "Whatever could Natalie and Chooch be discussing?\n\nAside from the Facts of Life of course!"
st.factsOfLifeTitle = "The Good and Bad?\nYou take em both, and there you have..."
st.fabio = "It's a little known fact in Dalaran that\nFabio has appeared on the cover of\n100's of Steamy Romance Novels.\n\n"
			.."(Never heard of them? It's surely no\ncoincidence that the water well nearby\n"
			.."is a secret entrance to The Underbelly.\nOccasionally Cravitz Lorent can be found\n"
			.."there. Ask and he might open his rain-\ncoat to reveal his tasteless tomes.)\n\n"
			.."Needless to say, Fabio looks positively\ngorgeous here with his tradmark flowing\n"
			.."locks, chiselled nelf features and that\nJe ne sais quoi that has made him a\n"
			.."magnet to women and, yes... he's still\nsingle and looking!\n\n(He'd look much prettier if he were a\n"
			.."blood elf. Just saying...)"
st.genderBending = "Grab some Underbelly Elixir\nand start quaffing... soon\nenough everyone will become\n"
			.."a mage... but wait on... there's\nsome serious gender bending\nhappening here as well!"
st.higherDnD = "Upon this crate is often a document.\nIt's a part of a collection achievement\n"
			.."called \"Higher Learning\" and the task\nis a huge reference to the popular\ntabletop game Dungeons & Dragons!\n\n"
			.."((Yeah... Taraezor (that's yours truly!)\nhas an AddOn over at Curseforge to\n"
			.."track your progress. Get it now while\nstocks last!))\n\nEach book you are required to collect\n"
			.."is one of the schools of magic in the\nD&D universe. Now... lets roll 2D20\nand..."
st.initiative = "When your GM is a dud...\nalways roll for initiative!"
st.jones = "Is this the same Jones we saw on that ship?\n\nNo, not The Exodar... but a similar ship!\n\n"
			.."If it is the same ship's cat\nthen this is definitely alien!"
st.jonesTitle = "Jones isn't a pet. He's a survivor"
st.lost = "Subtract one from each of the numbers\non the hatch and what do you get?\n\nThe six Valenzetti Equation numbers\n"
			.."of course!\n\nStill not clear?\nHow about \"Dharma Initiative\"?\n\nOkay, if you're still reading then you're\n"
			.."definitely \"Lost\"! ;)\n\nIt all adds up! That crashed plane...\ncould it be Oceanic Flight 815?\n\n"
			.."And if you see a puff of smoke moving\ntowards you... then just run!"
st.mageLove = "Mages must come to Endora!\n\nIf you are lucky she will sell the:\n   (1) Ancient Tome of Portal: Dalaran\n"
			.."   (2) Tome of Polymorph: Black Cat\n   (3) Dalaran Initiates Pin\n\nEven if they are unavailable she will\n"
			.."surely restock within about 45 minutes\nor so.\n\nShe always has available:\n"
			.."   (1) Mystical Tome:Arcane Linguist\n   (2) Familiar Stone\n   (3) Mystical Tome: Illusion\n\n"
			.."Insciptors! Don't forget that she might\nalso have the Glyph of Dalaran Brilliance\n"
			.."Technique available too. Mages love it!\n\nBonues trivia: In another universe, the\n"
			.."60's TV show Bewitched! starred Samantha,\nwhose mother's name was Endora. The name\n"
			.."of the actress... Agnes Moorehead. Ah...\nIt's all starting to add up!\n\n"
			.."And now the black cat \"Bad Luck\"...\nI wonder who it was who was polymorphed!!!"
st.maricaHase = "15 years ago this writer (@Taraezor) first visited\nDalaran and he couldn't believe his eyes when he\n"
			.."stumbled upon the exotically delectable Marcia!\n\nAnd now, in the present day... nobody is the wiser\n"
			.."as to her real identity \"in another universe\". Yeah,\nthat universe we call \"IRL\".\n\n"
			.."Who is she? None other than Marica Hase!\n\n((Easily found on IG and X. She's an AV Idol from\n"
			.."Japan so... those links might be naughty! Careful!\n\nHow the hell did this survive the infamous Blizzard|n"
			.."purge of politically incorrect or naughty content?))"
st.nethaerasLight = "There was a famous community worker,\nwhose avatar was a candle, who is\ncommemorated in Dalaran. There are\n"
			.."ten possible locations where you\nmight find a candle...\n\nDismount, target it and /cheer\n\n"
			.."You'll be rewarded with a nice pet!"
st.northrendHighest = "So you just try sitting atop the Icecrown\nCitadel. Ouch! Until then... this here is\n"
			.."the highest perch in Northrend. Correct?\n\nBonus factoid... really, just try to sit atop\n"
			.."the Citadel! There's a \"force\"\npreventing you from trying!\n\nHey, who's spoiling all the fun?"
st.polarBearCub = "Mages love their polymorphs!\nSo how about a cute polar bear cub?\n\nThe tome drops off Arctic Grizzlies\n"
			.."in Dragonblight. There's a few here!\n\nThe drop rate is around 1:100"
st.rayban = "Okay, let's accept for one moment that\nShifty Vickers here has nicked Mankrik's\nOld Wedding Garments...\n\n"
			.."But I just gotta know where to lay my\nhands on those cool shades!"
st.raybanTitle = "Mankrik's Ray-Bans too? Very Shifty!"
st.sheddleShine = "Upstairs of The Threads of Fate is\nSheddle, who'll gladly shine your\nshoes.\n\n"
			.."No tip necessary (as he's paid a\ndecent wage by those kindly Kirin\nTor mages).\n\n"
			.."He does a nice job too. The buff\nwill last you an hour.\n\nJust sit in the seat and Sheddle\n"
			.."will apply the spit and polish!"
st.shortcut = "Have a look into the well. Have a reeeeal\ngood look!\n\nOops! Did you fall in? Nevermind! You\n"
			.."just discovered a shortcut..."
st.silverbrook = "A great place for inscriptors to farm the\ncool \"Rituals of the New Moon\" which\n"
			.."confers an on-use transform into a giant\nwolf onto an off-hand gear piece.\n\n"
			.."It's Bind on Pickup so make sure you're\nan inscriptor!\n\nOh yeah... at this very location one of\n"
			.."the Silverbrook Hunters is buried up to\nhis head!\n\nThis is also the best location for Ally\n"
			.."as Silverbrook mobs in other locations\nare invariably friendly. Horde, you've\n"
			.."lots more options! Regardless, the\nmobs spawn really quick here too!\n\nExpect to farm 200 or so for the drop"
st.silverbrookTitle = "This Silverbrook Hunter\nis up to his neck in it!"
st.smouldering = "The camp is very basic.\nBut the fire smoulders.\nNot long departed.\nWill he/she return?"
st.timmyJ = "Yo Timmy J the deal\nKeepin it so real\nPimpin purple 'n' hat 'n' mo\nUh, uh it's Timmy J on show\n"
			.."It be boss in dis hood\nAn Timmy J always got da wood\nYeah Timmy J can bounce\nCareful don't blow that ounce\n"
			.."Trashin tha ride\nlike wat yo got ta hide?\nYa 'sall pimped out\nLike that I got no doubt"
st.vitamins = "What maniacal abomination is this?\n\nThere must surely be something in the\n"
			.."sewer water for a rat to grow that big!\n\nTakes more than prayers and \"vitamins\"\n"
			.."to grow such a hulking beast.\n\nWhat evil juice are the mages of Dalaran\npumping through the sewer?\n\n"
			.."Psst! For your very own Giant Sewer Rat\ncompanion try fishing anywhwere in The\n"
			.."Underbelly. The RNG is brutal but eventually\nyou'll be rewarded with a more modestly,\n"
			.."but still hulkingly ginormous, giant rat of\nyour very own!"
st.windle = "At 21:00 \"Blizzard Time\" Windle pats around\nDalaran, lighting the gas lamps and torches.\n\n"
			.."Windle's not the bright spark he once was\nand he always misses a few.\n\n"
			.."Why does he light the lights? They are in\nmemory of his daughter Kinndy. She died\n"
			.."in the Theramore explosion.\n\nHelp out Windle by purchasing a magic\n"
			.."wand so that you may light the lamps that\nWindle missed!\n\n"
			.."(If you're late to the party he walks clock-\nwise and is done in about 5 minutes)"
			
points[ 114 ] = { -- Borean Tundra
	[22545039] = { name="So Many Tundra Penguins", tip="Why this berg? No idea. But there's\n"
					.."over 50 penguins here... just... chillin'!\n\nOh the puns Taraezor, the puns!" },
	[35213522] = { name="Perky Coquettes", tip="Fancy meeting Kevin Kanai Griffith\non the Coldarra rim of all places!\n\n"
						.."A great Northrend memorial to an\namazing fantasy artist!\n\nSo blue. So very blue!" },
	[42063169] = { name="A Bridge Too Far?", tip="No. It was a bridge to nowhere.\n\n"
						.."Look across the way to Coldarra.\nThis bridge was always doomed.\n\n"
						.."Most likely gnomish engineering.\nOh, goblin you say? Whatever!" },
	[54638937] = { name="White Murloc Egg",
					tip="This is what you came for. But beware...\n"
					.."you may only learn one per account!" },
	[55828810] = { name="It's Merky Looking for Terky Lerky!", tip="Dive down exactly here. Only a short way.\n\n"
						.."Face to 102 degrees and you'll see a slit\n/ orifice in the rocks.\n\n"
						.."((My \"X and Y\" AddOn @ Curseforge shows\ndegrees. Get it!))\n\n"
						.."Go through the opening and pivot clockwise\n175 degrees and surface.\n\n" },
	[58678234] = { name="21 Up!", tip="Try AoE the penguins. Dare you!\nIt's downright freaky...\n\n"
						.."Almost instant respawn. 21.\nAlways 21 of the blessed birds!\n\n"
						.."Wait on... respawn but still dead??"},
	[61297673] = { name="Somebody didn't get the memo!", tip="A berg must have a population of 21\n"
						.."penguins if it has penguins at all.\n\n14 only! Heads will roll for this\n"
						.."outrageous error!"},
	[62117672] = { name="21 Again!", tip="These bergs love their populations\nof exactly 21 penguins.\n\n"
						.."It's the same here. Try to wipe\n'em out and sure... they respawn\nagain as the living dead!\n\n"
						.."And only later do their ghosts\ndisappear"},
	[98072276] = { name="Smouldering", tip=st.smouldering },
}
points[ 127 ] = { -- Crystalsong Forest
	[25863929] = { name="Give Me a Fast Five!", tip=st.duoctane },
	[26573766] = { name="This One Ate It's Vitamins!", tip=vitamins },
	[27374052] = { name="Endora Moorehead", tip=st.mageLove },
	[27803634] = { name="Bouncin' Timmy J!", tip=st.timmyJ },
	[28003480] = { name="You Light Up My Life Nethaera", tip=st.nethaerasLight },
	[28393869] = { name=st.initiative, tip=st.higherDnD },
	[28533621] = { name=st.raybanTitle, tip=st.rayban },
	[28634106] = { name="Let there be guitar... erm... light!", tip=st.windle },
	[28813861] = { name="No Tip Necessary!", tip=st.sheddleShine },
	[29193474] = { name="It Ain't Over 'Til It's Over", tip=st.cockroach },
	[29403576] = { name="Well I'll be!", tip=st.shortcut },
	[29563764] = { name="Mobile Innkeeper!", tip=st.afsanehAsrar },
	[29643766] = { name="Gender Bending", tip=st.genderBending },
	[29763977] = { name="Underbelly Elixir", tip=st.elixir },
	[29783559] = { name="I Can't Believe It's Not Butter!", tip=st.fabio },
	[29893742] = { name=st.jonesTitle, tip=st.jones },
	[30563571] = { name="Vintage... 365 days ago!", tip=st.agedWine },
	[30653619] = { name=st.factsOfLifeTitle, tip=st.factsOfLife },
	[31583163] = { name=st.badRogueTitle, tip=st.badRogue },
	[32533141] = { name=st.arsenicTitle, tip=st.arsenic },
	[32663246] = { name="Cool Pet For Sale!", tip=st.darahir },
	[30364247] = { name="Ooh Matron!", tip=st.maricaHase },
}
points[ 125 ] = { -- Dalaran
	[37213132] = { name="You Light Up My Life Nethaera", random=0.3, tip=st.nethaerasLight },
	[38595555] = { name="Endora Moorehead", tip=st.mageLove },
	[41054109] = { name="You Light Up My Life Nethaera", random=0.3, tip=st.nethaerasLight },
	[40683536] = { name="Bouncin' Timmy J!", tip=st.timmyJ },
	[41662789] = { name="You Light Up My Life Nethaera", random=0.3, tip=st.nethaerasLight },
	[43554669] = { name=st.initiative, tip=st.higherDnD },
	[43965799] = { name="You Light Up My Life Nethaera", random=0.3, tip=st.nethaerasLight },
	[44982399] = { name="You Light Up My Life Nethaera", random=0.3, tip=st.nethaerasLight },
	[44695816] = { name="Let there be guitar... erm... light!", tip=st.windle },
	[45574632] = { name="No Tip Necessary!", tip=st.sheddleShine },
	[48393252] = { name="Well I'll be!", tip=st.shortcut },
	[49204160] = { name="Mobile Innkeeper!", tip=st.afsanehAsrar },
	[49907063] = { name="You Light Up My Life Nethaera", random=0.3, tip=st.nethaerasLight },
	[50253169] = { name="I Can't Believe It's Not Butter!", tip=st.fabio },
	[50774057] = { name=st.jonesTitle, tip=st.jones },
	[50853011] = { name="You Light Up My Life Nethaera", random=0.3, tip=st.nethaerasLight },
	[53056494] = { name="Ooh Matron!", tip=st.maricaHase },
	[53353534] = { name="You Light Up My Life Nethaera", random=0.3, tip=st.nethaerasLight },
	[54003228] = { name="Vintage... 365 days ago!", tip=st.agedWine },
	[58315231] = { name="You Light Up My Life Nethaera", random=0.3, tip=st.nethaerasLight },
	[61964415] = { name="You Light Up My Life Nethaera", random=0.3, tip=st.nethaerasLight },
}
points[ 126 ] = { -- Dalaran - The Underbelly
	[31284960] = { name="Give Me a Fast Five!", tip=st.duoctane },
	[34754171] = { name="This One Ate It's Vitamins!", tip=vitamins },
	[44193473] = { name=st.raybanTitle, tip=st.rayban },
	[47372759] = { name="It Ain't Over 'Til It's Over", tip=st.cockroach },
	[49564170] = { name="Gender Bending", tip=st.genderBending },
	[50165190] = { name="Underbelly Elixir", tip=st.elixir },
	[54453460] = { name=st.factsOfLifeTitle, tip=st.factsOfLife },
	[58931259] = { name=st.badRogueTitle, tip=st.badRogue },
	[63531151] = { name=st.arsenicTitle, tip=st.arsenic },
	[64171661] = { name="Cool Pet For Sale!", tip=st.darahir },
}
points[ 115 ] = { -- Dragonblight
	[12654150] = { name="Smouldering", tip=st.smouldering },
	[40775451] = { name="Attention Mages!", tip=st.polarBearCub },
	
}
points[ 116 ] = { -- Grizzly Hills
	[31065547] = { name="Arcturis", tip="Northrend... who loves it more than\n"
						.."Beast Mastery Hunters?\n\nAnd here is where they find Arcturis,\n"
						.."A magnificent ghostly \"spirit beast\"\nin the form of a grizzly bear.\n\n"
						.."The only one of its kind!" },
	[32225888] = { name="Just \"Passing Through\"", tip="This outhouse is unique amongst the\n"
						.."outhouses of Azeroth, this author\nbeing well accustomed and all...\n\n"
						.."Knock on the door! Oh... really?\n\nHorde... that's as far as it goes\n"
						.."for you, sorry to say. Just purchase\nyourself a whoppee cushion, okay?\n"
						.."But try and press your ear against\nthe wall. Hey! I said your ear you\n"
						.."pervert! Stop trying to peek inside!\n\nAlliance... you can go further, no\n"
						.."need to strain, in fact you'll be\ndoing your... duty.\n\n"
						.."If you haven't already, walk on\nover to the entrance to the Lodge.\n"
						.."There's a bucket to the left of the\ndoorway, just inside the Lodge.\n\n"
						.."You'll deal with Anderhol who'll\nhelp you to... get things moving\n"
						.."and to... get down to business!\n\nOh, the dialogue between Jacob\n"
						.."and Anderhol after the final\nquest turn-in is priceless!\n\n"
						.."Feel free to avail yourself of\nthese facilities any time after!" },
	[35956912] = { name=st.silverbrookTitle, tip=st.silverbrook },
	[56922936] = { name="Who Killed Bambi?\nA Rotten, Vicious Rumour?", tip=st.bambi },
}
points[ 117 ] = { -- Howling Fjord
	[26470047] = { name=st.silverbrookTitle, tip=st.silverbrook },
}
points[ 118 ] = { -- Icecrown
	[03177702] = { name="I've Got One Up on You!\n(Reference Lost)", tip=st.lost },
	[19809549] = { name="Beast Master Hunter Nostalgia", tip=st.bmHunter },
	[44720439] = { name="Lonesome Berg", tip="Love the attention to detail" },
	[54060804] = { name="Wasted Conspiracy or Clever Prepping?", tip="Here they are all alone... three conspirators.\n\n"
						.."Better to hide here as nobody can be trusted?\n\nBut there's danger within their ranks?\n"
						.."Or they truly parrot as one?\n\nI suspect that they are prepping!\n"
						.."They'll surely be safe here come the\narmageddon / apocalypse / holocaust!" },
	[75678754] = { name="Endora Moorehead", tip=st.mageLove },
	[75868573] = { name="Bouncin' Timmy J!", tip=st.timmyJ },
	[76128675] = { name=st.initiative, tip=st.higherDnD },
	[76228778] = { name="Let there be guitar... erm... light!", tip=st.windle },
	[76308671] = { name="No Tip Necessary!", tip=st.sheddleShine },
	[76558547] = { name="Well I'll be!", tip=st.shortcut },
	[76628629] = { name="Mobile Innkeeper!", tip=st.afsanehAsrar },
	[76728540] = { name="I Can't Believe It's Not Butter!", tip=st.fabio },
	[76778620] = { name=st.jonesTitle, tip=st.jones },
	[76978838] = { name="Ooh Matron!", tip=st.maricaHase },
	[77068545] = { name="Vintage... 365 days ago!", tip=st.agedWine },
	[94214908] = { name="You Can't Sit Atop the Citadel!", tip=st.northrendHighest },
}
points[ 119 ] = { -- Sholazar Basin
	[21923373] = { name="You Have Exactly 108 Minutes", tip="To stop these electromagnetic pulses\n"
					.."you need to enter a code sequence\ninto a terminal.\n\n"
					.."Use your initiative and search for a\nhexagon shaped hatch nearby!" },
	[26742412] = { name="Don't Stand in the Purple Stuff", tip="Stand here long enough and you'll get\n"
					.."zapped by mysterious purple lightning.\n\nIt won't hurt you, but the rust coloured\n"
					.."smoke plume is rather disconcerting!" },
	[38663722] = { name="I've Got One Up on You!\n(Reference Lost)", tip=st.lost },
	[62606380] = { name="Beast Master Hunter Nostalgia", tip=st.bmHunter },
}
points[ 120 ] = { -- The Storm Peaks
	[16079345] = { name="Endora Moorehead", tip=st.mageLove },
	[16249185] = { name="Bouncin' Timmy J!", tip=st.timmyJ },
	[16479275] = { name=st.initiative, tip=st.higherDnD },
	[16569366] = { name="Let there be guitar... erm... light!", tip=st.windle },
	[16639272] = { name="No Tip Necessary!", tip=st.sheddleShine },
	[16859163] = { name="Well I'll be!", tip=st.shortcut },
	[16919235] = { name="Mobile Innkeeper!", tip=st.afsanehAsrar },
	[17009156] = { name="I Can't Believe It's Not Butter!", tip=st.fabio },
	[17049227] = { name=st.jonesTitle, tip=st.jones },
	[17229419] = { name="Ooh Matron!", tip=st.maricaHase },
	[17299161] = { name="Vintage... 365 days ago!", tip=st.agedWine },
	[32425954] = { name="You Can't Sit Atop the Citadel!", tip=st.northrendHighest },
	[38484056] = { name="Jeeves, can you please take out the\ndungeon trash, there's a good helper.",
					tip="Jeeves is an iconic part of being an engineer\nand this is the best location to grind out the\n"
						.."schematic.\n\nFocus on the Library Guardians, of which\n"
						.."there are numerous in the Terrace of the\nmakers.\n\n"
						.."Note: You must salvage the corpses and not\nmerely loot them" },
}
points[ 123 ] = { -- Wintergrasp
	[04271422] = { name="Beast Master Hunter Nostalgia", tip=st.bmHunter },
	[47458540] = { name="Smouldering", tip=st.smouldering },
}
points[ 121 ] = { -- Zul'Drak
	[70079551] = { name="Who Killed Bambi?\nA Rotten, Vicious Rumour?", tip=st.bambi },
}

--=======================================================================================================
--
-- THE MAELSTROM
--
--=======================================================================================================

points[ 207 ] = { -- Deepholm
	[69873708] = { name="Perhaps a Sturdy Chest", tip="Enter the Fungal Deep.\nProceed up the trail.\n"
			.."You rewards are waiting!\n\nPerhaps... several reported\nlocations but it was here\nfor me!" },
}

--=======================================================================================================
--
-- VASHJ'IR
--
--=======================================================================================================

st.burgyTitle = "Cringe West Country Accent Meeting Point"
st.burgy = "That'l right! Arrrr! Here be tea redoubtable\nBurgy Blackheart, patrolling tee ancien\n"
			.."wreck of ee ship. And if yer best ee then\nyer get tee look likel ee too!\n\n"
			.."\"Burgy Blackheart's Handsome Hat\". Arrr!\nEe's a boot! Bleddy 'ansum! Perfect fer yer\n"
			.."Toy Box! So where yer to? Get don ere!\n\nNot jes an at. Yer'll look like ee too!\n\n"
			.."Yer wildn' ferget ta 19 September - ere\nInternational Talk Like a Pirate Day where\n"
			.."yer get ter soun like a right idyot.\n\n((I've an AddOn for that too, sigh. It's\n"
			.."called \"Yarrr\" - tons of says/yells with\npirate themed jokes. Enjoy if you dare!))"
st.difficult = "Even experienced adventurers have trouble\nlocating the entrances to L'ghorek"
st.pearlVashj = ""

points[ 204 ] = { -- Abyssal Depths
	[35104106] = { name="Why So Difficult?", tip=st.difficult },
	[41504673] = { name="Why So Difficult?", tip=st.difficult },
}
points[ 201 ] = { -- Kelp'thar Forest
}
points[ 205 ] = { -- Shimmering Expanse
	[57126987] = { name=st.burgyTitle, tip=st.burgy },
}
points[ 203 ] = { -- Vashj'ir
	[19599879] = { name="They are Tormenting Us!", tip="There is a massive brilliant\nglowing pearl here, along\n"
					.."with a very large sea-\ncreature skeleton.\n\nNobody knows its purpose,\nonly that to venture there is\n"
					.."a real challenge because it\nis very suspiciously encased\nin a varying fatigue zone!\n\n"
					.."Wait! Is that Burning Steppes\nmusic I hear? The mystery\ndeepens!" },
	[28094968] = { name="Why So Difficult?", tip=st.difficult },
	[31855301] = { name="Why So Difficult?", tip=st.difficult },
	[69737114] = { name=st.burgyTitle, tip=st.burgy },
}

--=======================================================================================================
--
-- PANDARIA
--
--=======================================================================================================

st.abandonedKite = "We've all had to do the swim of shame\nwhen we've fallen off a cliff or gone\n"
			.."too far while exploring.\n\nA convenient taxi! It's a freebie too!\n\nBut... why is it \"abandoned\"?"
st.alignedGrass = "The grass lines here are precisely aligned.\n\nWhen correctly oriented one can see the letters\n"
			.."\"EVD\" and from a distance the silhouette of an\nancient carriage is apparent. Is this the long\n"
			.."rumoured reference to the \"Chariots of the Old\nOnes\" and a subsequent \"Return to the Stars\"?"
st.bellTolls = "This deserted landing is a questing location\n"
			.."which is not often visited. I urge you to go\n"
			.."inside and listen to the excellent zone music"
st.birdFeast = "Very much the bloody feast. Love the\nsplatter effect when they lean in to bite!"
st.boatBuilding = "Centre of the workbench.\n\n((The flavour text...\n\n\"A book describing "
			.."the intracies[sic] of building\na fine watercraft. You wouldn't understand.\"\n\n"
			.."has me stumped. The deliberate misspelling\nand such led me down a rabbit hole and yet\n"
			.."I found nothing. It must be a reference, but\na reference to what? !!))"
st.clamshellBand = "One of six items you need to collect\nin order to craft the Clamshell Band.\n\n"
			.."The Clamshell Band in turn is needed\nto summon Clawlord Kril'mandar in\n"
			.."south-west Krasarang Wilds at\n(12.6,81.2).\n\nThat boss drops Lobstmourne, an\n"
			.."interesting claw-like fist weapon\nused for transmogging"
st.condor = "The highest peak in The Jade Forest and an\nexcellent place to watch the Condors flying!"
st.eaPandaria = "Sounds like a good idea for an AddOn!\nYeah... shameless self promotaion again\nbut it really is good!"
st.forgottenLockbox = "Second floor of the \"Tavern in the Mists\".\n\n"
st.gokklok = "You'll love dancing to this toy...\nJust go kill it already and thank me later!"
st.grohl = "I was in nirvana when I wandered into this cave!...\n\nIs someone getting the best, the best, the best\n"
			.."The best of you?\nIs someone getting the best, the best, the best\nThe best of you?\n\n"
			.."He's putting on quite the show! If you hang around\nlong enough his mate ghostly mate Kurt might appear!\n\n"
			.."((Nah... I just made that last bit up. RIP))"
st.hawkmaster = "My favourite secret location in Pandaria!\n\nWithin The Veiled Stair we have The Secret\n"
			.."Aerie and within that we have \"The People\nof the Sky\", a small and oh so isolated\n"
			.."village of Hawkmasters and Hawk Trainers.\n\nThere's a book in one of the huts.\n\n"
			.."In addition to the named Hawkmasters, there\nis the adorable Lil' Reed and Lil' Griffin, two\n"
			.."unobtainable pets to make your heart melt!"
st.kherShan = "Seems to be guarded the memorial which is\n"
			.."likely dedicated to whom? Kipling? Mowgli?"
st.krosh = "When you run out of IRL references...\nWhy not refer back to yourself?\n\n"
			.."You all remember Kresh from The Wailing Caverns?\nHe dropped the \"Kresh's Back\" shield. This time\n"
			.."around... hmmm... that quest name has a double\nreference!!! And... \"whose\" works with and\n"
			.."without the apostrophe. Nice work Blizz writers!!!\n\nHey hunter tamers! This one's unique!"
st.lakeKittitata = "Far from an unfinished borderland zone,\nLake Kittitata, especially the upper section,\n"
			.."affords a spectacular view of The Jade Forest\nbelow, as well as ample opportunity to fish\n"
			.."the plentiful Jade Lungfish schools"
st.lenin = "Advance far enough and you'll be rewarded\nwith the Townlong Steppes zone quest\n"
			.."completion achievement!\n\nIt's undoubtedly a reference to a phrase\n"
			.."popularised by Vladimir Ilyich Ulyanov,\ncommonly known as \"Lenin\", and is\n"
			.."indeed the title of one of his tomes.\n\nThat you are still with me here is an\n"
			.."achievement itself!\n\n\"Steppes\" obviously reinforces this\nby referencing the Russian Steppes.\n\n"
st.litterOfXuen = "So cute. There are several\nof these spirit kitties!"
st.lobstmourne = "Once you have all six pieces and you've\ncrafted the Clamshell Band then you must\n"
			.."come here and use it to summon Clawlord\nKril'mandar who will then drop Lobstmourne.\n\n"
			.."This is an interesting fist weapon which\nis nice for transmogrification purposes"
st.loKiAlaniStory = "He may not get many visitors but be prepared\nto stay a while and listen for Loh-Ki has a\n"
			.."great story to tell... the origin of ..."
st.manglemaw = "Awww... such a cute baby crocolisk!\n\nToo cute to kill! No... you wouldn't\n"
			.."dare kill cute lil junior Manglemaw?"
st.masterNguyen = "Who are the \"Five Sorcerers\"? What secret?\n\nSo much time has elapsed since the mists cleared\n"
			.."over Pandaria and we are still none the wiser!\n\nDon't you love his \"Power of the Storm\" buff!\n\n"
			.."((I've marked the extremes of his pat path))"
st.mountainClimber = "It must be so cold up here!"
st.neverest = "The highest peak in all of Azeroth!\nIs it really 8,844m above sea level?"
st.nothingToSee = "Nothing to see... move on!\n\nBut you've got to agree it is big!"
st.psilocybin = "A tiny mushroom... why? Is it magical?\nWhat a strange trip this must be!"				
st.renFiretongue = "He just wants to be left alone.\n\nBy the way, Ren can also be found on the\n"
			.."Kun-Lai Summit side of the Gate of the\nAugust Celestials, phasing permitted"
st.rollingDeep = "We could have had it all!\n\nRolling in the deep\nYou had my heart inside of your hands\n"
			.."But you played it, you played it, you played it\nYou played it to the beat"				
st.roseOffering = "Hidden away between the zones is this\naltar, like any other save for a solitary\n"
			.."rose. It's fresh! Who placed it here and\nwho lit the incense?"
st.rosesSkeleton = "Two strange skeletons and a bed of roses.\n\nAre they a type of saurok? Head to tail and\n"
			.."facing away from each other. No camp or weapons.\n\nThe largest rose is in the hand of one of the deceased"
st.samwiseDidier = "Celebrating Blizzard's very own real life\nhobbit, the popular WoW artist Sam\n"
			.."Didier who arguably is responsible for the\nPandaren art we know and love.\n\n"
			.."And of course Samwise Gamgee from\nThe Hobbit"
st.secondHighest = "The highest summit in Azeroth? Almost but not quite!\n\nFace at 44 degrees (easy with the \"X and Y\" AddOn by\n"
			.."yours truly @ Curse) and you might be able to see\nhighest peak in Azeroth from here, way off in the\n"
			.."distance.\n\nWasn't that factoid worth the shameless self promotion!"
st.secretAerie = "With one tiny questing exception, the Secret\nAerie is a perfect location for some chill\n"
			.."fishing. Hey, the Tiger Gourami Schools\nwhich spawn here can help in that respect\n"
			.."too! Don't forget the book in the boat!"
st.senTheOptimist = "You'll find Sen wandering around here.\n\nOriginally his dialogue was messed up.\n"
			.."That's thankfully been fixed. He's now\nsimply... optimistic!"
st.serpentShrine = "I love this location @ the Peak of Serenity"
st.smiteAgain = "The Deadmines was apparently not \"merely a\nsetback\" for " ..colourHighlight .."Mr Smite"
			..colourPlaintext ..". In fact the evidence\nhere is that he is still rather traumatised.\n\n"
			.."Determined to start a new life he travelled far\nfrom his old base in Westfall. He filed his horns,\n"
			.."coloured his mane, doned a hoodie and generally\nkeeps a low profile in this quiet corner of the Vale.\n\n"
			.."Mindless toying with his Gnomish model tug boat\nand his old-world \"vanilla\" chest, no doubt filled\n"
			.."with painful memories, hint at his trauma.\n\n((He drops a cool \"Mr Smite\" transform toy\n"
			.."so you may need to wait for the respawn))\n\nHe still wields his favourite weapons too!"
st.solitaryReed = "Attention to detail? Allowing a\nsolitary reed to stick out of the sea?"
st.teaTree = "Reminds me of Leptospermum scoparium,\naka \"Tea Tree\" in my country"
st.tigerWood = "Okay how to tee up a reference? I don't really\nknow how because it's a bit of a bogey. Par\n"
			.."for the course for most people I suppose"
st.wallWatchers = "Chat to the Wallwatchers...\n\nUncanny! It's as though they had worked far\n"
			.."to the north, protecting Castle Black from the\nwildlings!\n\n"
			.."Hang around and Ygritte, Styr and the wildlings\nmight appear? Don't forget to burn the bodies!"
st.weirdBirdGuitar = "This non-clickable old broiler is a...?\n\nCheckout its animation! It's not about\n"
			.."to start talking turkey, that's for sure!\n\nAnd the guitar? A case of \"Zul again\"\n"
			.."or merely gobbledygook?"
st.zumba = "Hey, we're just in time for the sprite zumba class!\n\nAwwwww, aren't they just so adorable!\n\n"
			.."C'mon! Let's squeeze into our active wear...\nYeah... must have shrunk in the wash that last\n"
			.."time we exercised..."

points[ 422 ] = { -- Dread Wastes
	[27066933] = { item=90170, npc=66935, tip=st.clamshellBand },
	[27251612] = { name="Gokk'lok", tip=st.gokklok },
	[27841135] = { item=90171, npc=66938, tip=st.clamshellBand },
	[38291747] = { name="Zumba! Sprite Zumba!", tip=st.zumba },
	[39150680] = { name="Adele", npc=65178, tip=st.rollingDeep },
	[67785750] = { name="Exploration Achievements - Pandaria", tip=st.eaPandaria },
	[73851280] = { name="Jon, Samwell, Maester Aemon, et al...", tip=st.wallWatchers },
	[82171958] = { name="Erik was here!", tip=st.alignedGrass },
	[85142068] = { name="Ole Slow-hand Gobbler", tip=st.weirdBirdGuitar },
	[94651947] = { name="Single Rose", tip=st.roseOffering },
	[97881995] = { tip="It's Magic!", tip=st.psilocybin },
}
points[ 418 ] = { -- Krasarang Wilds
	[09301680] = { name="Exploration Achievements - Pandaria", tip=st.eaPandaria },
	[12768150] = { name="Who c-c-c-calls?",
					item=90087, npc=66936, tip=st.lobstmourne },
	[39008770] = { item=90169, npc=66934, tip=st.clamshellBand },
	[52167341] = { item=87798, obj=214403, quest={ 31863 },
					questName={ "The Servers are busy at this time.\nPlease try again later.\n(Error 37)" },
					tip="((Collect the stack of papers by all means!\n\nNow read the document... okay... it references\n"
					.."the launch date and time of Diablo III!\n\nSystem Failure? You ever tried to login\n"
					.."during the launch of a Blizzard game?\n\nError 37... Error 37...))"},
}
points[ 379 ] = { -- Kun-Lai Summit
	[23878689] = { name="One Steppe Forward, Two Steppes Back", tip=st.lenin },
	[28402722] = { name="Foo! It's Grohl Grohl", tip=st.grohl },
	[33022635] = { name="For whom the Bell Tolls", tip=st.bellTolls },
	[35694240] = { name="Grove of Falling Blossoms", tip=st.teaTree },
	[43565348] = { name="Mountain Climber", tip=st.mountainClimber },
	[43901700] = { name="Wally and Tik Tak", tip="Wally the Walrus and Tik Tak the Carpenter...\n\n"
					.."Indeed, things are becoming curiouser and curiouser\nin this wonderland of adventures. But ah! There's a\n"
					.."moral to this story... somewhere, yes, let me think...\n\n"
					.."Never imagine yourself not to be otherwise than what\nit might appear to others that what you were or might\n"
					.."have been was not otherwise than what you had been\nwould have appeared to them to be otherwise" },
	[44415252] = { name="Neverest Pinnacle", tip=st.neverest },
	[44694984] = { name="Mountain Climber", tip=st.mountainClimber },
	[46055551] = { name="Mountain Climber", tip=st.mountainClimber },
	[46185204] = { name="Mountain Climber", tip=st.mountainClimber },
	[47509341] = { name="Farewell Rose", tip=st.rosesSkeleton },
	[47897349] = { item="Mo-Mo's Treasure Chest", obj=214407, quest={ 31868 }, 
					tip="No idea who Mo Mo is but he sure has a phat loot chest!" },
	[48147300] = { name="Mo-Mo's Treasure Chest", tip="Enter the cave here" },
	[49601820] = { item=90168, npc=66933, tip=st.clamshellBand },
	[50709361] = { name="Loh-Ki", tip=st.loKiAlaniStory },
	[51549291] = { name="Ren Firetongue", tip=st.renFiretongue },
	[51703933] = { name="Serpent Shrine", tip=st.serpentShrine },
	[54242420] = { tip="What a great view from the rock pools and the waterfall!" },
	[57202020] = { name="Lon'li Guju", tip="The only \"vanilla\" tortoise in all of Pandaria!\n"
					.."He flies along the coast here.\n\nHe must be so lonely. Help cheer him up by giving\n"
					.."a /hug or a /wave. He'll immediately come over to\nyou and follow you around for a couple of minutes!\n\n"
					.."((A reference to " ..colourHighlight .."Lonesome George" ..colourPlaintext ..", the only known\n"
					.."individual of the Pinta Island Tortoise sub-species,\nand who eventually passed away.\n\n"
					.."The plaque overlooking his old corral in Galapágos\n(Ecuador) now reads, " ..colourHighlight 
					.."\"We promise to tell your\nstory and to share your conservation message.\"\n\n"
					..colourPlaintext .."Vale El Solitario George!))" },
	[68601660] = { name="Mei and Eva", tip="Mei is certainly in the zone, focusing on her\n"
					.."student. But... persist with talking to her.\n\nA little extra tidbit no?\n\n"
					.."Interact some more... okay then... leave her be" },
	[70115354] = { name="Aw, They're So Cute!", tip=st.litterOfXuen },
	[74331054] = { name="Green Voodoo Brew", tip="The brew needs a few more frogs, so go to it now!" },
	[75151644] = { name="Red Voodoo Brew", tip="A mysteriously tasty concoction indeed!\n"
					.."You'll acquire voodoo mastery in no time!" },
	[75561339] = { name="Magenta Voodoo Brew", tip="Ewwww! That magenta slurry looks a bit off!" },
	[76991233] = { name="Blue Voodoo Brew", tip="Now go dance with a witch doctor!\n\nYeah... I be jammon wit' you too!" },
	[77121537] = { name="Duskwing Crow Feast", tip= birdFeast },
	[78168745] = { name="Lake Kittitata", tip=st.lakeKittitata },
	[79329951] = { name="The People of the Sky", tip=st.hawkmaster },
	[79607153] = { tip=st.nothingToSee },
	[81027378] = { name="\"Abandoned\" Kites", tip=st.abandonedKite },
	[81279685] = { name="The Secret Aerie", tip=st.secretAerie },
	[84905375] = { name="\"Abandoned\" Kites", tip=st.abandonedKite },
	[88365201] = { name="\"Abandoned\" Kites", tip=st.abandonedKite },
	[89629496] = { name="Tigers' Wood", tip=st.tigerWood },
	[90978626] = { name="Sam the Wise", tip=st.samwiseDidier },
	[91349358] = { name="Kher Shan", tip=st.kherShan },
	[95134722] = { name="Solitary Reed", tip=st.solitaryReed },
}
points[ 386 ] = { -- Kun-Lai Summit - Ruins of Korune
	[53613073] = { name="For whom the Bell Tolls", tip="That's far enough - the place is booby trapped!\n\n"
					.."Turn up the volume and grab a coffee. There are\nten randomly selected tracks for this sub-zone,\n"
					.."plus others which I think play.\n\nI just love the percussion / bell elements!" },
	[91717844] = { name="Condor Heights", tip=st.condor },
}
points[ 371 ] = { -- The Jade Forest
	[05426296] = { name="Single Rose", tip=st.roseOffering },
	[07906333] = { tip="It's Magic!", tip=st.psilocybin },
	[14330574] = { name="Aw, They're So Cute!", tip=st.litterOfXuen },
	[14746943] = { name="Manglemaw", tip=st.manglemaw },
	[17067175] = { name="Sen the Optimist", tip=st.senTheOptimist },
	[17215270] = { name="Yorik Sharpeye", tip=st.smiteAgain },
	[19144770] = { tip=st.secondHighest },
	[21543615] = { name="Lake Kittitata", tip=st.lakeKittitata },
	[22574696] = { name="The People of the Sky", tip=st.hawkmaster },
	[22832187] = { tip=st.nothingToSee },
	[23206046] = { item="Forgotten Lockbox", obj=214325, quest={ 31867 }, tip=st.forgottenLockbox },
	[24102390] = { name="\"Abandoned\" Kites", tip=st.abandonedKite },
	[24324458] = { name="The Secret Aerie", tip=st.secretAerie },
	[27570594] = { name="\"Abandoned\" Kites", tip=st.abandonedKite },
	[29925165] = { name="Hungry Bloodtalon", tip= birdFeast },
	[30680438] = { name="\"Abandoned\" Kites", tip=st.abandonedKite },
	[32004300] = { name="Tigers' Wood", tip=st.tigerWood },
	[33354165] = { name="Kher Shan", tip=st.kherShan },
	[33023508] = { name="Sam the Wise", tip=st.samwiseDidier },
	[33682807] = { name="Condor Heights", tip=st.condor },
	[34187689] = { item=87524, obj=214340, quest={ 31869 }, tip=st.boatBuilding }, -- Boat-Building Instructions
	[36750008] = { name="Solitary Reed", tip=st.solitaryReed },
	[39254663] = { name="Jade Raccoon", quest={ 29716, 29723 }, questName={ "The Double Hozen Dare", "The Jade Witch", },
					tip="She's a bit weird! So... all the jade stuff outside?\n(There's a fun trinket reward too)" },
	[43987339] = { name="Nectarbreeze Orchard", tip=st.teaTree },
	[45163735] = { name="Forest Heart Raft", tip="Another mysterious skeleton but this time...\n\n"
					.."Doubly mysterious. Two cute (unclickable) birds,\na pink teddy bear. empty bottles, fresh snacks\n"
					.."and flowers, and...\n\nDive down! There are more empty bottles and\nhe lost his oars!" },
	[46298069] = { quest={ 31865}, item="Offering of Remembrance", obj=214338, },
	[52471341] = { name="The Moon is a Balloon", tip="Not sure what's \"Up\" here...\n\n"
					.."It must be a reference to something,\nso why not look it \"up\"?" },
	[54204240] = { name="Ferdinand", tip="All he wants to do is smell the flowers!\n\n"
					.."When you agro him he dual wields... flowers!\n\n((Childrens' book reference))" },
			-- Deliberately offset as he also appears in my EA Pandaria AddOn
	[54059071] = { name="Follow the yellow brick road", tip="We're off to see the Wizard\nThe wonderful Wizard of Oz\n"
					.."We hear he is a whiz of a wiz\nIf ever a wiz there was\nIf ever, oh ever a wiz there was..." },
	[55303160] = { name="Martar", tip="Martar the peeping gnoll pats around here. Try fighting him!\n\n"
					.."Did you get his awesome magnifying glass? Awww, better\n"
					.."luck next time. On average it will take three or four attempts!\n\n"
					.."But make sure that you get it... you'll be going blind from\n"
					.."reading those steamy romance novels he otherwise drops..." },
	[56281829] = { name="Anglers Fisherman", tip="Love the various popup gossip\nfrom the st.fisherman.\n\n"
					.."Yeah the \"Noodler\" he refers\nto is alive and well at the\nAnglers village in Krasarang" },
	[57222127] = { name="Just a domestic...", tip="A really curious conversation.\n\nIt infrequently triggers. I had to\n"
					.."go AFK and check the chat dialogue" },
	[57465196] = { name="Master Nguyen of The Five Sorcerers", tip=st.masterNguyen
					.."\n\nAfter he leaves here (and unlike the other end\npoints he only pauses here briefly) he will\n"
					.."attempt to walk past the Jade Temple cafe\nonly to pause and glitch! Watch it happen!" },
	[58131923] = { name="Anglers Fisherwoman", tip="So the women are mostly this side\nand the men are across the water.\n\n"
					.."Click for the random chat popup!\n\nAnd for this fisherwoman, most\n"
					.."importantly you must look up...\n\nHey Junior get down from there!" },
	[59353644] = { item=90166, npc=66932, tip=st.clamshellBand },
	[59739602] = { item=90167, npc=66937, tip=st.clamshellBand },
	[60014210] = { name="\"Abandoned\" Kites", tip=st.abandonedKite },
	[62065527] = { name="Master Nguyen of The Five Sorcerers", tip=st.masterNguyen },
	[62452754] = { quest={ 31866 }, item="Stash of Gems", obj=214337, tip="Inside the Shadowfae Madcap cave" },
	[62822340] = { name="Perplexing Pair", tip="This needs an explanation!\n(There are more!)" },
	[63532504] = { name="Perplexing Pair", tip="This needs an explanation!\n(There are more!)" },
	[65252540] = { name="Lovely Altar", tip="And I'd love to climb up there!" },
	[65364755] = { name="Master Nguyen of The Five Sorcerers", tip=st.masterNguyen },
}
points[ 433 ] = { -- The Veiled Stair
	[31364098] = { name="Yorik Sharpeye", tip=st.smiteAgain },
	[38842154] = { tip=st.secondHighest },
	[52231867] = { name="The People of the Sky", tip=st.hawkmaster },
	[54667122] = { item="Forgotten Lockbox", obj=214325, quest={ 31867 }, tip=st.forgottenLockbox },
	[88190280] = { name="Tigers' Wood", tip=st.tigerWood },
	[80813691] = { name="Hungry Bloodtalon", tip= birdFeast },
}
points[ 388 ] = { -- Townlong Steppes
	[23000700] = { name="G'nathus", tip="Look for G'nathus along the north coast.\n"
					.."Good chance to drop a really cool battle pet!" },
	[32496177] = { name="Meanwhile... \"planet\"side... we've located the missing\n"
					.."fifth watcher from the Vault of Archavon in Wintergrasp!!!",
					tip="Well go on! Get in there and find out what all the fuss is about!" },	
	[41759707] = { name="Gokk'lok", tip=st.gokklok },
	[42309263] = { item=90171, npc=66938, tip=st.clamshellBand },
	[42875825] = { tip="Well I've got the balls to say it! The bull lacks a pizzle!" },
	[52049833] = { name="Zumba! Sprite Zumba!", tip=st.zumba },
	[52848838] = { name="Adele", tip=st.rollingDeep },
	[65006700] = { name="One Steppe Forward, Two Steppes Back", tip=st.lenin },
	[69940197] = { name="Foo! It's Grohl Grohl", tip=st.grohl },
	[74970102] = { name="For whom the Bell Tolls", tip=st.bellTolls },
	[77831852] = { name="Grove of Falling Blossoms", tip=st.teaTree },
	[85189397] = { name="Jon, Samwell, Maester Aemon, et al...", tip=st.wallWatchers },
	[86463058] = { name="Mountain Climber", tip=st.mountainClimber },
	[87382954] = { name="Neverest Pinnacle", tip=st.neverest },
	[87692663] = { name="Mountain Climber", tip=st.mountainClimber },
	[89173280] = { name="Mountain Climber", tip=st.mountainClimber },
	[89302902] = { name="Mountain Climber", tip=st.mountainClimber },
	[90757410] = { name="Farewell Rose", tip=st.rosesSkeleton },
	[94237432] = { name="Loh-Ki", tip=st.loKiAlaniStory },
	[95157356] = { name="Ren Firetongue", tip=st.renFiretongue },
	[95321517] = { name="Serpent Shrine", tip=st.serpentShrine },
}
points[ 389 ] = { -- Townlong Steppes - Niuzao Catacombs
	[64122205] = { name="Huggalon the Heart Watcher", tip="He drops the cute B.F.F. Necklace toy.\n\n"
					..colourHighlight .."Gooooo Planet! The power is yours Captain!\n\n"
					..colourPlaintext .."((Okay... the VoA reference is itself\na reference. Captain Planet anyone?))" },
}
points[ 390 ] = { -- Vale of Eternal Blossoms
	[11625855] = { name="Jon, Samwell, Maester Aemon, et al...", tip=st.wallWatchers },
	[24251345] = { name="Farewell Rose", tip=st.rosesSkeleton },
	[29187289] = { name="Erik was here!", tip=st.alignedGrass },
	[32161394] = { name="Loh-Ki", tip=st.loKiAlaniStory },
	[34241222] = { name="Ren Firetongue", tip=st.renFiretongue },
	[35477522] = { name="Ole Slow-hand Gobbler", tip=st.weirdBirdGuitar },
	[55577266] = { name="Single Rose", tip=st.roseOffering },
	[62397367] = { tip="It's Magic!", tip=st.psilocybin },
	[81259049] = { name="Manglemaw", tip=st.manglemaw },
	[87659691] = { name="Sen the Optimist", tip=st.senTheOptimist },
	[93383057] = { tip=st.secondHighest },
	[93429040] = { name="Krosh", tip=st.krosh },
	[89004400] = { name="Yorik Sharpeye", tip=st.smiteAgain },
}
points[ 376 ] = { -- Valley of the Four Winds
	[04266616] = { name="Exploration Achievements - Pandaria", tip=st.eaPandaria },
	[12540520] = { name="Jon, Samwell, Maester Aemon, et al...", tip=st.wallWatchers },
	[23881445] = { name="Erik was here!", tip=st.alignedGrass },
	[27941595] = { name="Ole Slow-hand Gobbler", tip=st.weirdBirdGuitar },
	[40911430] = { name="Single Rose", tip=st.roseOffering },
	[45311495] = { tip="It's Magic!", tip=st.psilocybin },
	[52104850] = { name="Farmer Yoon", tip="You'll need to advance the Tillers for this one...\n\n"
					.."One of his dailies is called \"Red Blossom Leeks,\nYou Make the Croc-in' World Go Down\".\n\n"
					.."Okay you got the reference? Great! Now do\nyourself a favour and instal my HandyNotes:\n"
					.."DarkSoilTillers AddOn!" },
	[57492579] = { name="Manglemaw", tip=st.manglemaw },
	[61622993] = { name="Sen the Optimist", tip=st.senTheOptimist },
	[65342573] = { name="Krosh", tip=st.krosh },
	[72540985] = { item="Forgotten Lockbox", obj=214325, quest={ 31867 }, tip=st.forgottenLockbox },
	[92083907] = { item=87524, obj=214340, quest={ 31869 }, tip=st.boatBuilding }, -- Boat-Building Instructions
}
points[ 424 ] = { -- Pandaria
	[71008180] = { tip="An epic showdown settles the score once and for all...\n\nLuce Bree versus Nuck Chorris!!!\n\n"
					.."The winner? Would I spoil that for you?!" },
	[20005700] = { name="Master Korin", tip="((No reference to Master Korin! Really Blizzard? Grrrr!))" },
}
points[ 554 ] = { -- Timeless Isle
	[63002800] = { name="Garnia", tip="She might drop a gorgeous fire elemental\nbattle pet if you're really lucky!\n\n"
					.."Actually I counted 16 possible pets\nto be had off the various rare elites\n"
					.."and such on the Timeless Isle!" },
	[70377737] = { name="Underwater Love", tip="Enter the cave at this location...\n\nYour guess is as good as mine as to\n"
					.."what might have been happening here!\nPerhaps some kind of weird love ritual!\n\n"
					.."Oh yeah... the Glinting Sand is actually\nuseful for two separate achievements on\n"
					.."the Timeless Isle. But since you have my\n\"Exploration Achievements - Pandaria\"\n"
					.."AddOn you knew that already! Didn't you?\n\nWait! There's more!!! Sit down and touch\n"
					.."the fire. Oops! Where am I?\n\nBonus Trivia! This is the alternative\n"
					.."way to unlock your Garrison / flight\npoints etc without completing the quest\npreliminaries in WoD" },
}

--=======================================================================================================
--
-- DARKMOON FAIRE
--
--=======================================================================================================

st.dmfSpritDust = "Note: Can only be seen when\nyou are in spirit form!\n\nBonus DMF fact: When you are\n"
			.."alive you can see where the\nspirits are standing/walking.\nLook closely for green-blue\nsparkling dust clouds!"
st.stayAWALto = "Stay a While and Listen to..."

points[ 407 ] = { -- Darkmoon Faire
	[31303370] = { name=st.stayAWALto, tip="Zazla!\n\nThis troll can be found pacing\n"
					.."through here and his back\nstory is quite mysterious.\n\n" ..st.dmfSpritDust },
	[32285448] = { name=st.stayAWALto, tip="Brendon Paulson!\n\nHe walks a loop in this\n"
					.."vicinity. Loyal to Silas, he\ntoo has a curious past.\n\n" ..st.dmfSpritDust },
	[36136612] = { name="A Scattering of Crows", tip="When you see some crows sitting\n"
					.."on the grass, rush over to them!\nThey'll quickly scatter away!\n\n(Several locations)" },
	[36545797] = { name="When Rona looks you up and down...",  tip="There's a reason why she hides out here.\n"
					.."All of her meat is from dubious origins.\n\nI strongly suspect a couple of the\n"
					.."ghostly carnies you can meet, became\nher victims. Others no doubt as well.\n\n"
					.."Bonus trivia: Around the time of the\nLegion, most of her menu disappeared!\n\nShe used to also sell:\n"
					.."* Beer-Basted Short Ribs\n* Draenic Dumplings\n* Gnomeregan Gnuggets\n* Mulgore Meat Pie\n"
					.."* Silvermoon Steak\n* Stormwind Surprise\n* Teldrassil Tenderloin\n* Troll Tartare\n\n"
					.."Decisions, decisons... I'll go the\nMulgore Meat Pie. I do like steak\n"
					.."but I'd imagine there's not a lot of\nmeat on the bone Silvermoon way" },
	[41287218] = { name=st.stayAWALto, tip="Franklin Jenner!\n\nHe walks a wide loop behind\n"
					.."the tents. Hmmm, seems he\nquite quite the \"handy man\".\n\n" ..st.dmfSpritDust },
	[44002675] = { name=st.stayAWALto, tip="Kupp Coincare!\n\nKupp is in an out of the way\n"
					.."place. And what do you make\nof Silas' role in this?\n\n" ..st.dmfSpritDust },
	[47447453] = { name=st.stayAWALto, tip="Martha Weller!\n\nAs well as being the location\nof the Spirit Healer, you\n"
					.."can also find Martha patrolling\naround here.\n\n" ..st.dmfSpritDust },
	[57447285] = { name="Flik", tip="Flik scampers around these parts,\nalong with his pet frog. If you're\n"
					.."quick enough to catch Flik, he just\nmight sell you one of his less\nfrequently stocked Wood Frog Box.\n"
					.."Of course he also has his standard\nbasic Tree Frog crates too!" },
	[59066122] = { name="I Only Do Hardmode", tip="Lynnish Hardmode is one helluva\ndevilish vendor. Checkout her\n"
					.."arcade style games. No rewards,\njust that warm fuzzy feeling that\nyou beat that lump of silicon\n"
					.."and metal!" },
	[60327464] = { name=st.stayAWALto, tip="Sithera Wellspun!\n\nYou'll find this bloodelf wandering\n"
					.."aimlessly around here, apparently\nlooking for her camp site. Do you\nthink that Rona Greenteeth banged\n"
					.."her on the head with her frypan?\n\n" ..st.dmfSpritDust },
	[67262259] = { name="Ham & Pineapple, Thin Crust", tip="One of your potential rewards\nfrom the Sealed Darkmoon Crates\n"
					.."at the Darkmoon fishing schools\nis a Pineapple pizza. Yum!\n\nBut some dilettante said \"Just\n"
					.."terrible\" in its description.\n\nEveryone just loves pineapple\non pizza. Surely!\n\n"
					.."Just don't get me started on\nanchovies! Eeeeew!" },
	[68956887] = { name=st.stayAWALto, tip="Arlon Surehoof!\n\nArlon is a tauren and he appears to\nbe guarding his camp site.\n\n"
					.."The same camp site as Sithera?\nHe'd sure make fine wagyu for\nRona Greenteeth over yonder!\n\n"
					..st.dmfSpritDust },
	[74873433] = { name="Cavern of Lament", tip="You'll lament getting wasted by Erinys.\n\nWhich version of her to kill? Doesn't\n"
					.."matter - kill 'em all until a quest drops\nReward is a cool toy. 'Nuf said!\n\n"
					.."Pin marks a submerged cavern" },
}

--=======================================================================================================
--
-- MISCELLANY
--
--=======================================================================================================

points[ 1532 ] = { -- Crapopolis
	[46454882] = { name="Mind Your Step!", tip="Did you known there's another mine field?\n\n"
					.."Sparksocket Minefield, to the west of K3 in\nStorm Peaks." },
	[56086809] = { name="Funky Town!", tip="Ahhh yes every New Years Eve the\nAuction House in Stormwind or\n"
					.."Orgrimmar is transformed into a disco.\n\nBut here... it's 24/7!\n\n"
					.."Time to splash out your best toys!\nNow, where's my Rainbow Generator..." },
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
scaling[1] = 0.41
scaling[2] = 0.41
scaling[3] = 0.41
scaling[4] = 0.41
scaling[5] = 0.41
scaling[6] = 0.41
scaling[7] = 0.49
scaling[8] = 0.46
scaling[9] = 0.56
scaling[10] = 0.56
scaling[11] = 0.43
scaling[12] = 0.37
scaling[13] = 0.36
scaling[14] = 0.32
