local myname, ns = ...

ns.map_questids = {
    ["ShadowmoonValleyDR"] = 36464,
    ["FrostfireRidge"] = 34557,
    ["Gorgrond"] = 36465,
    ["Talador"] = 36466,
    ["SpiresOfArak"] = 36467,
    ["NagrandDraenor"] = 36468,
    ["TanaanJungle"] = 39463,
}

ns.points = {
    --[[ structure:
    [mapFile] = { -- "_terrain1" etc will be stripped from attempts to fetch this
        [coord] = {
            label=[string], -- label: text that'll be the label, optional
            item=[id], -- itemid
            quest=[id], -- will be checked, for whether character already has it
            achievement=[id], -- will be shown in the tooltip
            junk=[bool], -- doesn't count for achievement
            npc=[id], -- related npc id, used to display names in tooltip
            note=[string], -- some text which might be helpful
        },
    },
    --]]
    ["NagrandDraenor"] = {
        -- steamwheedle supplies
        [50108220]={ quest=35577, label="Steamwheedle Supplies", note="Use a glider", currency=824, },
        [52708010]={ quest=35583, label="Steamwheedle Supplies", note="Use a glider", currency=824, },
        [64601760]={ quest=35648, label="Steamwheedle Supplies", note="Use a glider", currency=824, },
        [70601860]={ quest=35646, label="Steamwheedle Supplies", note="Use a glider", currency=824, },
        [77805190]={ quest=35591, label="Steamwheedle Supplies", note="Use a glider", currency=824, },
        [87602030]={ quest=35662, label="Steamwheedle Supplies", note="Use a glider", currency=824, },
        [88204260]={ quest=35616, label="Steamwheedle Supplies", note="Use a glider", currency=824, },
        -- abu'gar
        [38404940]={ quest=36711, item=114245, note="Abu'Gar's Favorite Lure, won't show complete until you get Abu'Gar", }, -- 36072
        [65906120]={ quest=36711, item=114242, note="Abu'gar's Vitality, won't show complete until you get Abu'Gar", }, -- 35711
        [85403870]={ quest=36711, item=114243, note="Abu'gar's Missing Reel, won't show complete until you get Abu'Gar", }, -- 36089
        -- glider-required
        [70501390]={ quest=35643, label="Mountain Climber's Pack", note="Use a glider", currency=824, },
        [73007040]={ quest=35678, label="Warsong Lockbox", note="Use a glider", currency=824, },
        [76107000]={ quest=35682, item=118678, note="Warsong Spear, use a glider", },
        [80606060]={ quest=35593, label="Warsong Spoils", note="Use a glider", currency=824, },
        [81103720]={ quest=35661, item=118262, note="Brilliant Dreampetal, use a glider", },
        [87504500]={ quest=35622, label="Hidden Stash", currency=824, note="Use a glider", },
        [88901820]={ quest=35660, label="Fungus-Covered Chest", note="Use a glider", currency=824, },
        -- generic garrison supplies
        [37707060]={ quest=34760, label="Treasure of Kull'krosh", currency=824, },
        [40406860]={ quest=37435, label="Spirit Coffer", currency=824, junk=true, },
        [43305750]={ quest=35987, label="Genedar Debris", currency=824, },
        [44606750]={ quest=36002, label="Genedar Debris", currency=824, },
        [47207430]={ quest=35576, label="Goblin Pack", currency=824, },
        [48006010]={ quest=35999, label="Genedar Debris", currency=824, },
        [48607270]={ quest=36008, label="Genedar Debris", currency=824, },
        [51706030]={ quest=35695, label="Warsong Cache", currency=824, },
        [55306820]={ quest=36011, label="Genedar Debris", currency=824, },
        [56607290]={ quest=36050, label="Adventurer's Pouch", currency=824, },
        [73001090]={ quest=35951, label="A Pile of Dirt", note="Jump down", currency=824, },
        [73006220]={ quest=35590, label="Goblin Pack", currency=824, },
        [73107550]={ quest=35673, label="Appropriated Warsong Supplies", currency=824, },
        [77101660]={ quest=36174, label="Bounty of the Elements", currency=824, note="Cave, use the Elemental Stones for access", },
        [89103310]={ quest=36857, label="Smuggler's Cache", note="In a cave, dodge the tripwires", currency=824, },
        [89406580]={ quest=35976, label="Warsong Supplies", currency=824, },
        -- treasures
        [38305880]={ quest=36109, label="Goldtoe's Plunder", npc=84068, item=114054, note="Gold, parrot has the key", },
        [45605200]={ quest=35969, label="Adventurer's Pack", note="Gold, random green", },
        [45806630]={ quest=36020, item=117981, note="Fragment of Oshu'gun", },
        [50006650]={ quest=35579, item=118264, note="Void-Infused Crystal", },
        [52404440]={ quest=36073, item=118250, note="Warsong Helm", },
        [53406430]={ quest=36088, label="Adventurer's Pouch", note="Random green, in the cave", }, -- todo: confirm location
        [57806220]={ quest=36115, item=118278, note="Pale Elixir", },
        [58205260]={ quest=35694, item=118266, note="Golden Kaliri Egg", },
        [58305940]={ quest=36021, item=116688, note="Pokkar's Thirteenth Axe", },
        [61805740]={ quest=36082, label="Lost Pendant", note="Green amulet", },
        [62506710]={ quest=36116, label="Bag of Herbs", note="Assorted herbs", },
        [64703580]={ quest=36071, item=118235, note="Watertight Bag", },
        [64706580]={ quest=36046, item=118253, note="Telaar Defender Shield", },
        [66901950]={ quest=35954, item=118234, note="Elemental Offering, jump down", },
        [67404900]={ quest=36039, item=118252, note="Highmaul Sledge", },
        [67605980]={ quest=35759, label="Abandoned Cargo", note="Gold, random green", },
        [69905240]={ quest=35597, label="Adventurer's Pack", note="Gold, random green", },
        [72706100]={ quest=36035, item=118254, note="Polished Saberon Skull", note="Circuitous path up the cliff from in Sabermaw, past the Adventuer's Mace", },
        [73102160]={ quest=35692, item=118233, note="Freshwater Clam", },
        [73901410]={ quest=35955, label="Adventurer's Sack", note="Gold", },
        [75206500]={ quest=36102, label="Saberon Stash", note="Gold, jump down", },
        [75306570]={ quest=36099, item=61986, note="Important Exploration Supplies", },
        [75404710]={ quest=36074, item=118236, note="Gambler's Purse", },
        [75806200]={ quest=36077, label="Adventurer's Mace", note="Gold, green mace; circuitous path up the cliff from in Sabermaw", },
        [77302820]={ quest=35986, item=116760, note="Bone-Carved Dagger", },
        [78901550]={ quest=36036, item=118251, note="Elemental Shackles", },
        [81007980]={ quest=36049, item=118255, note="Ogre Beads", },
        [81501300]={ quest=35953, item=116640, note="Adventurer's Staff", },
        [82305660]={ quest=35765, label="Adventurer's Pack", note="Gold, random green", },
        [85405340]={ quest=35696, label="Burning Blade Cache", note="In tower, jump from cliff", },
        [87107290]={ quest=36051, item=118054, note="Grizzlemaw's Bonepile", },
        -- rares
        [34607700]={ quest=34727, npc=79725, item=118244, }, -- Captain Ironbeard (also drops 116809)
        [38001960]={ quest=37397, npc=87846, achievement=9571, }, -- Pit Slayer
        [38602240]={ quest=37395, npc=87788, item=119405, achievement=9571, }, -- Durg Spinecrusher
        [40001600]={ quest=37395, npc=87837, achievement=9571, }, -- Bonebreaker
        [42207860]={ quest=34725, npc=80122, item=116798, currency=824, note="In a cave", }, -- Gaz'orda
        [42804920]={ quest=35875, npc=83409, item=116765, }, -- Ophiis
        [43003640]={ quest=37400, npc=87234, item=119380, achievement=9541, }, -- Brutag Grimblade
        [43803440]={ quest=37473, npc=87239, achievement=9541, }, -- Krahl Deadeye
        [45003640]={ quest=37472, npc=87344, achievement=9541, }, -- Gortag Steelgrip
        [45801520]={ quest=36229, npc=84435, item=118690, }, -- Mr. Pinchy Sr.
        [45803480]={ quest=37399, npc=86959, item=119355, achievement=9541, }, -- Karosh Blackwind
        [47607080]={ quest=35865, npc=83401, item=116815, pet=true, }, -- Netherspawn
        [52009000]={ quest=37408, npc=80370, }, -- Lernaea
        [52205580]={ quest=35715, npc=82764, item=118246, }, -- Gar'lua
        [54806120]={ quest=35931, npc=83634, item=116797, }, -- Scout Pokhar
        [58008400]={ quest=35900, npc=83526, item=118688, }, -- Ru'klaa
        [58201200]={ quest=37398, npc=88210, achievement=9617, }, -- Krud the Eviscerator
        [58201800]={ quest=37637, npc=88208, currency=823, }, -- Pit Beast
        [61804720]={ quest=35912, npc=83542, currency=824, }, -- Sean Whitesea
        [61806900]={ quest=35943, npc=83680, item=116800, }, -- Outrider Duretha
        [65003900]={ quest=35920, npc=83591, item=116814, }, -- Tura'aka
        [66605660]={ quest=35717, npc=82778, item=116824, }, -- Gnarlhoof the Rabid
        [66805120]={ quest=35714, npc=82758, item=116795, }, -- Greatfeather
        [70004180]={ quest=35893, npc=83483, item=116807, }, -- Flinthide
        [70602940]={ quest=35877, npc=83428, item=116808, }, -- Windcaller Korast
        [73605780]={ quest=35712, npc=82755, item=118243, }, -- Redclaw the Feral
        [74801180]={ quest=35836, npc=82975, item=116836, note="Use the fishing rod at 75.3,10.9", }, -- Fangler
        [75606500]={ quest=36128, npc=80057, item=116806, }, -- Soulfang
        [77006400]={ quest=35735, npc=82826, currency=824, note="In a cave, use the switch", }, -- Berserk T-300 Series Mark II
        [80603040]={ quest=35923, npc=83603, item=118245, }, -- Hunter Blacktooth
        [81206000]={ quest=35932, npc=83643, item=116796, }, -- Malroc Stonesunder
        [82607620]={ quest=34645, npc=79024, item=116805, }, -- Warmaster Blugthol
        [84603660]={ quest=36159, npc=84263, item=118689, }, -- Graveltooth
        [84605340]={ quest=35778, npc=82899, currency=824, }, -- Ancient Blademaster
        [86007160]={ quest=35784, npc=82912, item=118687, }, -- Grizzlemaw
        [87005500]={ quest=34862, npc=78161, item=116799, }, -- Hyperious
        [89004120]={ quest=35623, npc=82486, item=118679, }, -- Explorer Nozzand
        [93202820]={ quest=35898, npc=83509, item=116916, }, -- Gorepetal
        -- steamwheedle rares
        [62601680]={ quest=37211, npc=86732, item=118655, }, -- Bergruu
        [50204120]={ quest=37221, npc=86743, item=118656, }, -- Dekorhan
        [63402960]={ quest=37225, npc=86750, item=118660, }, -- Thek'talon
        [48202220]={ quest=37223, npc=86771, item=118658, }, -- Gagrog the Brutal
        [41004400]={ quest=37226, npc=86835, item=118661, }, -- Xelganak
        [51001600]={ quest=37210, npc=86774, item=118654, }, -- Aogexon
        [60003800]={ quest=37222, npc=86729, item=118657, }, -- Direhoof
        [34005100]={ quest=37224, npc=87666, item=118659, }, -- Mu'gra
        [37003800]={ quest=37520, npc=88951, item=120172, }, -- Vileclaw
        -- followers
        [40307610]={ quest=35596, follower=170, note="Kill Bolkar nearby to get the key", }, -- Goldmane
        [46401600]={ quest=34466, follower=190, note="Mysterious Staff; collect all the Mysterious items across Draenor", }, -- Archmage Vargoth
        [67205600]={ quest=36711, npc=82746, follower=209, note="Rebuild his fishing rod by gathering the pieces @ 38.4,49.3, 65.8,61.1, 85.4,38.7", }, -- Abu'gar
        -- pepe!
        [80105040]={ quest=39265, item=127865, achievement=10053, }, -- Viking Pepe
        -- Voidtalon
        [57302670]={ quest=37864, item=121815, note="Occasionally spawning portal", },
        [45903140]={ quest=37864, item=121815, note="Occasionally spawning portal", },
        [40504750]={ quest=37864, item=121815, note="Occasionally spawning portal", },
    },
    --[[
    -- TODO: need the name
    ["ACaveInNagrand"] = {
        [66305730]={ quest=36088, label="Adventurer's Pouch", note="Random green", },
    },
    -- "Vault of the Titan"
    ["StonecragGorge"] = {

    },
    --]]
    ["ShadowmoonValleyDR"] = {
        -- garrison-y
        [27100260]={ quest=35280, currency=824, label="Stolen Treasure", },
        [26500570]={ quest=34174, currency=824, label="Fantastic Fish", },
        [28800710]={ quest=35279, currency=824, label="Sunken Treasure", },
        [30301990]={ quest=35530, currency=824, label="Lunarfall Egg", note="Moves to the garrison once built", faction="Alliance", },
        [45802460]={ quest=33570, currency=824, label="Shadowmoon Exile Treasure", note="cave below Exile Rise", },
        [52902490]={ quest=37254, currency=824, label="Mushroom-Covered Chest", },
        [57904530]={ quest=33568, currency=824, label="Kaliri Egg", },
        [28303930]={ quest=33883, currency=824, label="Shadowmoon Treasure", },
        [42106130]={ quest=33041, currency=824, label="Iron Horde Cargo Shipment", },
        [84504470]={ quest=33885, currency=824, label="Cargo of the Raven Queen", },
        -- treasures
        [20303060]={ quest=33575, item=108904, note="Demonic Cache", },
        [22803390]={ quest=33572, item=113373, note="Rotting Basket", },
        [29803750]={ quest=36879, label="Dusty Lockbox", note="On top of the standing stones; some random greens", },
        [30004530]={ quest=35919, item=113563, note="Shadowmoon Sacrificial Dagger", },
        [31303910]={ quest=33886, item=109081, note="Ronokk's Belongings", },
        [33503970]={ quest=33569, item=113545, note="Reusable mana potion", },
        [34204350]={ quest=33866, item=109124, note="Veema's Herb Bag, underground", },
        [34404620]={ quest=33891, item=108901, note="Giant Moonwillow Cone", },
        [35904090]={ quest=33540, item=113546, note="Uzko's Knickknacks", },
        [36704450]={ quest=33573, item=113378, },
        [36804140]={ quest=33046, item=113547, note="Beloved's Offering, offhand decoration", },
        [37202310]={ quest=33613, item=108945, note="in cave, Bubbling Cauldron", },
        [37202610]={ quest=35677, item=110506, note="Sunken Fishing Boat, fishy fun items", },
        [37505930]={ quest=33567, item=108903, note="Iron Horde Tribute", },
        [37704430]={ quest=33584, item=113531, note="Consumable: Rested XP", },
        [38504300]={ quest=33614, item=113408, note="Greka's Urn", },
        [39208380]={ quest=33566, item=113372, note="Waterlogged Chest", },
        [41502790]={ quest=33869, item=108902, note="Armored Elekk Tusk", },
        [43806060]={ quest=33611, item=107650, note="Peaceful Offering", },
        [44505920]={ quest=33612, item=107650, note="Peaceful Offering", },
        [44506350]={ quest=33384, item=107650, note="Peaceful Offering", },
        [45206050]={ quest=33610, item=107650, note="Peaceful Offering", },
        [47104610]={ quest=33564, item=108900, note="Hanging Satchel", },
        [48704750]={ quest=35798, item=109130, note="Glowing Cave Mushroom", },
        [49303750]={ quest=33867, item=109739, note="Astrologer's Box", toy=true, },
        [51107910]={ quest=33574, item=113375, note="Vindicator's Cache", toy=true, },
        [51803550]={ quest=33037, label="False-Bottomed Jar", note="Gold", junk=true, },
        [52804840]={ quest=35584, item=113560, note="Ancestral Greataxe, against the grave", },
        [55004500]={ quest=35581, item=109124, note="Alchemist's Satchel", },
        [55307480]={ quest=35580, item=117550, note="Swamplighter Hive", toy=true, },
        [55801990]={ quest=35600, item=118104, note="Strange Spore, on top of the mushroom, go over the mountain", pet=true, },
        [58902200]={ quest=35603, item=113215, note="Mikkal's Chest, a sick burn from the NPC", },
        [66903350]={ quest=36507, item=116875, note="Orc Skeleton", },
        [67108430]={ quest=33565, item=44722, note="Scaly Rylak Egg, ah the memories", },
        -- rares (do these count for the 'treasure hunter' achievement?)
        [21602100]={ quest=33640, item=108906, npc=75482, }, -- Veloss
        [27604360]={ quest=36880, item=118734, npc=86689, }, -- Sneevel
        [29600620]={ quest=35281, item=111666, npc=81406, }, -- Bahameye
        [29603380]={ quest=33664, item=113082, npc=76380, note="In the cave @ 25,33", }, -- Gorum
        [29605080]={ quest=37357, item=119369, npc=85451, }, -- Malgosh Shadowkeeper
        [31905720]={ quest=37359, item=119392, npc=85078, }, -- Voidreaver Urnae
        [32203500]={ quest=33039, item=109061, npc=72362, }, -- Ku'targ the Voidseer
        [32604140]={ quest=35847, item=109074, npc=83385, }, -- Voidseer Kalurg
        [37203640]={ quest=33061, item=109060, npc=77140, }, -- Amaukwa
        [37404880]={ quest=35558, item=113631, toy=true, npc=79524, }, -- Hypnocroak
        [37601460]={ quest=33055, item=108907, npc=72537, }, -- Leaf-Reader Kurri
        [38607020]={ quest=35523, item=113559, npc=82362, }, -- Morva Soultwister
        [40804440]={ quest=33043, item=109078, npc=74206, }, -- Killmaw
        [41008300]={ quest=35448, item=113548, npc=82268, }, -- Darkmaster Go'vid
        [42804100]={ quest=33038, item=113553, npc=75434, }, -- Windfang Matriarch
        [43807740]={ quest=33383, item=117551, npc=81639, }, -- Brambleking Fili
        [44005760]={ quest=33642, item=119449, npc=75071, }, -- Mother Om'ra, hunter quest
        [44802080]={ quest=35906, item=113561, npc=77310, }, -- Mad King Sporeon
        [46007160]={ quest=37351, currency=823, npc=84911, }, -- Demidos
        [48007760]={ quest=37355, item=119360, npc=85121, }, -- Lady Temptessa
        [48208100]={ quest=37354, currency=823, npc=85029, }, -- Shadowspeaker Niir
        [48602260]={ quest=35553, item=113542, npc=82374, }, -- Rai'vosh, reusable slow-fall Item
        [48604360]={ quest=33064, item=109075, npc=77085, }, -- Dark Emanation
        [48806640]={ quest=33389, item=113570, toy=true, npc=75435, }, -- Yggdrel
        [49604200]={ quest=35555, item=113541, npc=82411, }, -- Darktalon
        [50207240]={ quest=37352, currency=823, npc=84925, }, -- Quartermaster Hershak
        [50807880]={ quest=37356, item=86213, npc=86213, }, -- Aqualir
        [51807920]={ quest=37353, item=85001, npc=85001, }, -- Master Sergeant Milgra
        [52801680]={ quest=35731, item=113540, npc=82326, }, -- Ba'ruun, reusable food (no buff)
        [53005060]={ quest=34068, item=109077, npc=72606, }, -- Rockhoof
        [54607060]={ quest=33643, item=108957, npc=75492, }, -- Venomshade
        [57404840]={ quest=35909, item=113571, npc=83553, }, -- Insha'tar
        [58408680]={ quest=37409, label="Nagidna", npc=85555, note="in a cave @ 59,89", }, -- item not known yet...
        [61005520]={ quest=35732, item=113543, npc=82415, }, -- Shinri
        [61408880]={ quest=37411, item=119411, npc=85837, }, -- Slivermaw
        [61606180]={ quest=35725, item=113557, npc=82207, }, -- Faebright
        [67806380]={ quest=35688, item=113556, npc=82676, }, -- Enavra
        [68208480]={ quest=37410, currency=823, npc=85568, }, -- Avalanche
        -- followers
        [42804040]={ quest=35614, follower=179, npc=74741, faction="Alliance", note="Do the crystal defense event here to get him", }, -- Artificer Romuul
        -- Voidtalon
        [49607160]={ quest=37864, item=121815, note="Occasionally spawning portal", },
        [43207100]={ quest=37864, item=121815, note="Occasionally spawning portal", },
        [50907250]={ quest=37864, item=121815, note="Occasionally spawning portal", },
        [41907570]={ quest=37864, item=121815, note="Occasionally spawning portal", },
        [48706990]={ quest=37864, item=121815, note="Occasionally spawning portal", },
        [46607000]={ quest=37864, item=121815, note="Occasionally spawning portal", },
    },
    ["BloodthornCave"] = {
        [55544974]={ quest=33572, item=113373, note="Rotting Basket", level=15, },
    },
    ["FrostfireRidge"] = {
        -- garrison
        [16104980]={ quest=33942, label="Supply Dump", currency=824, },
        [21605070]={ quest=34931, label="Pale Loot Sack", currency=824, },
        [24001300]={ quest=34647, label="Snow-Covered Strongbox", currency=824, },
        [34202350]={ quest=32803, label="Thunderlord Cache", currency=824, },
        [37205920]={ quest=34967, label="Raided Loot", currency=824, },
        [43705550]={ quest=34841, label="Forgotten Supplies", currency=824, },
        [51002280]={ quest=34521, label="Glowing Obsidian Shard", currency=824, note="May be missing?", },
        [56707180]={ quest=36863, label="Iron Horde Munitions", currency=824, },
        [64702570]={ quest=33946, label="Survivalist's Cache", currency=824, },
        [66702640]={ quest=33948, label="Goren Leftovers", currency=824, },
        [68204580]={ quest=33947, label="Grimfrost Treasure", currency=824, },
        [69006910]={ quest=33017, label="Iron Horde Supplies", currency=824, },
        [74505620]={ quest=34937, label="Lady Sena's Other Materials Stash", currency=824, faction="Horde", },
        -- treasures
        [09804540]={ quest=34641, item=111407, note="Sealed Jug", },
        [19201200]={ quest=34642, item=111408, note="Lucky Coin", },
        [21900960]={ quest=33926, item=108739, note="Lagoon Pool", toy=true, },
        [23102500]={ quest=33916, item=108735, note="Arena Master's War Horn", toy=true, },
        [24202720]={ quest=33501, item=63293, note="Spectator's Chest; booze, jump from the tower, entrance @ 25,30", },
        [24204860]={ quest=34507, item=110689, note="Frozen Frostwolf Axe; cave at 25,51", },
        [25502040]={ quest=34648, item=111415, note="Gnawed Bone", },
        [27604280]={ quest=33500, item=43696, note="Slave's Stash, booze", },
        [30305120]={ quest=33438, item=107662, note="Time-Warped Tower; loot all the frozen ogres", }, -- note: other ogres are 33497, 33439, and 33440
        [38403780]={ quest=33502, item=112087, note="Obsidian Petroglyph", },
        [39701710]={ quest=33532, item=120945, currency=823, note="In the tower, behind some rocks", }, -- Cragmaul Cache
        [40902010]={ quest=34473, item=110536, note="Envoy's Satchel", },
        [42401970]={ quest=34520, item=120341, note="Burning Pearl", },
        [42703170]={ quest=33940, item=112187, note="Crag-Leaper's Cache", },
        [54803540]={ quest=33525, item=107273, note="Combine with Frostwolf First-Fang @ 63,48", }, -- Young Orc Traveler
        [57105210]={ quest=34476, item=111554, note="Frozen Orc Skeleton", },
        [61804250]={ quest=33511, npc=72156, item=112110, note="Interrupt the ritual, then feed him ogres", },
        [63401480]={ quest=33525, item=107272, npc=75081, note="Combine with Snow Hare's Foot @ 54,35", }, -- Young Orc Woman
        [64406580]={ quest=33505, item=117564, note="Wiggling Egg; rylak nests on the roof", pet=true, },
        -- bladespire...
        [26503640]={ quest=35367, label="Gorr'thogg's Personal Reserve", currency=824, },
        [26703940]={ quest=35370, item=113189, note="Doorog's Secret Stash", },
        [26603520]={ quest=35347, currency=824, label="Ogre Booty", },
        [27173763]={ quest=35373, label="Ogre Booty", note="Gold", },
        [27283876]={ quest=35570, label="Ogre Booty", note="Gold", },
        [27603382]={ quest=35371, label="Ogre Booty", note="Gold", },
        [28093409]={ quest=35567, currency=824, label="Ogre Booty", },
        [28093409]={ quest=35568, currency=824, label="Ogre Booty", },
        [28093409]={ quest=35569, currency=824, label="Ogre Booty", },
        [28293440]={ quest=35368, label="Ogre Booty", note="Gold", },
        [28293440]={ quest=35369, label="Ogre Booty", note="Gold", },
        -- rares
        [67407820]={ quest=34477, item=112086, npc=78621, }, -- Cyclonic Fury
        [41206820]={ quest=34843, item=111953, npc=80242, }, -- Chillfang
        [28206620]={ quest=34470, item=111666, npc=78606, }, -- Pale Fishmonger
        [38606300]={ quest=34865, item=112077, npc=80312, }, -- Grutush the Pillager
        [51806480]={ quest=34825, item=111948, npc=80190, }, -- Gruuk
        [76406340]={ quest=34132, item=112094, npc=77526, }, -- Scout Goreseeker
        [25405500]={ quest=34129, item=112066, npc=77513, }, -- Coldstomp the Griever
        [27405000]={ quest=34497, item=111476, npc=78867, toy=true, }, -- Breathless
        [40404700]={ quest=33014, item=111490, npc=72294, }, -- Cindermaw
        [66403140]={ quest=33843, item=111533, npc=74613, }, -- Broodmother Reeg'ak
        [36803400]={ quest=33938, item=111576, npc=76918, }, -- Primalist Mur'og
        [26803160]={ quest=34133, item=111475, npc=77527, }, -- The Beater
        [40402780]={ quest=34559, item=111477, npc=79145, }, -- Yaga the Scarred
        [61602640]={ quest=34708, item=112078, npc=79678, }, -- Jehil the Climber
        [34002320]={ quest=32941, item=101436, npc=71721, currency=824, }, -- Canyon Icemother
        [54602220]={ quest=32918, item=111530, npc=71665, }, -- Giant-Slayer Kul
        [58603420]={ quest=34130, npc=78151, currency=824, }, -- Huntmaster Kuang
        [54606940]={ quest=34131, item=111484, npc=76914, }, -- Coldtusk
        [71404680]={ quest=33504, item=107661, npc=74971, }, -- Firefury Giant
        [47005520]={ quest=34839, item=111955, npc=80235, }, -- Gurun
        [50201860]={ quest=33531, item=112096, npc=75120, note="...and a peeled banana", }, -- Clumsy Cragmaul Brute
        [84404880]={ quest=nil, npc=84384, note=UNKNOWN, }, -- Taskmaster Kullah
        [85005220]={ quest=37556, npc=87600, currency=823, }, -- Jaluk the Pacifist
        [88605740]={ quest=37525, npc=84378, currency=823, }, -- Ak'ox the Slaughterer
        [86604880]={ quest=37401, item=119359, npc=84392, }, -- Ragore Driftstalker
        [86605180]={ quest=37403, npc=84376, currency=823, }, -- Earthshaker Holar
        [83604720]={ quest=37402, npc=87622, currency=823, }, -- Ogom the Mangler
        [87004640]={ quest=37404, npc=84374, currency=823, }, -- Kaga the Ironbender
        [70002700]={ quest=37381, npc=87351, currency=823, }, -- Mother of Goren
        [72203300]={ quest=34361, item=111534, npc=78265, }, -- The Bone Crawler
        [68801940]={ quest=37382, npc=87348, currency=823, }, -- Hoarfrost
        [72203000]={ quest=nil, npc=87349, note=UNKNOWN }, -- Gomtar the Agile
        [72203600]={ quest=37380, npc=87352, note="Flees" }, -- Gibblette the Cowardly
        [70003600]={ quest=33562, item=111545, npc=72364, currency=824, }, -- Gorg'ak the Lava Guzzler
        [70603900]={ quest=37379, npc=87356, currency=823, }, -- Vrok the Ancient
        [72402420]={ quest=37378, npc=87357, currency=823, }, -- Valkor
        [43600940]={ quest=37384, item=119379, npc=82618, }, -- Tor'goroth
        [38201600]={ quest=37383, item=119399, npc=82620, }, -- Son of Goramal
        [45001500]={ quest=37385, npc=82617, currency=823, }, -- Slogtusk the Corpse-Eater
        [48202340]={ quest=37386, item=119390, npc=82616, }, -- Jabberjaw
        [43002100]={ quest=37387, item=119356, npc=82614, }, -- Moltnoma
        [40601240]={ quest=34522, npc=79104, currency=823, }, -- Ug'lok the Frozen
        -- followers
        [39602800]={ quest=34733, follower=32, note="Rescue Dagg from the other cage first, then find him outside your garrison", }, -- Dagg
        [68001900]={ quest=34464, follower=190, note="Mysterious Boots; collect all the Mysterious items across Draenor", }, -- Archmage Vargoth
        [65906080]={ quest=34733, follower=32, note="Rescue Dagg from the cage, then go to his other location", }, -- Dagg
        -- Voidtalon
        [51001990]={ quest=37864, item=121815, note="Occasionally spawning portal", },
        [52301830]={ quest=37864, item=121815, note="Occasionally spawning portal", },
        [53841721]={ quest=37864, item=121815, note="Occasionally spawning portal", },
        [47702750]={ quest=37864, item=121815, note="Occasionally spawning portal", },
    },
    ["BladespireFortress"] = {
        [44806480]={ quest=35570, label="Ogre Booty", note="Gold", level=1, },
        [48506720]={ quest=35369, label="Ogre Booty", note="Gold; up some crates", level=1, },
        [53702880]={ quest=35368, label="Ogre Booty", note="Gold; up some crates", level=1, },
        [36502900]={ quest=35347, currency=824, label="Ogre Booty", level=2, },
        [37806900]={ quest=35370, item=113189, note="Doorog's Secret Stash; second floor, outside", level=2, },
        [46401640]={ quest=35371, label="Ogre Booty", note="Gold; up some crates; may hit an invisible ceiling, it's reachable if you work at it", level=2, },
        [51101770]={ quest=35567, currency=824, label="Ogre Booty", level=2, },
        [52605300]={ quest=35373, label="Ogre Booty", note="Gold; up some crates", level=2, },
        [70806800]={ quest=35569, currency=824, label="Ogre Booty", note="In the vault", level=2, },
        [76606330]={ quest=35568, currency=824, label="Ogre Booty", note="In the vault", level=2, },
        [31706640]={ quest=35367, item=113108, note="Gorr'thogg's Personal Reserve", level=3, },
    },
    ["Gorgrond"] = {
        -- treasures
        [39006810]={ quest=36631, label="Sasha's Secret Stash", note="Random green + gold; top of the tower on a broken beam outside, you have to jump down", },
        [40007230]={ quest=36170, item=118715, note="Femur of Improbability", },
        [40407660]={ quest=36621, item=118710, note="Explorer Canister", currency=824, },
        [41705300]={ quest=36506, item=118702, note="Brokor's Sack", },
        [41807810]={ quest=36658, label="Evermorn Supply Cache", note="Green and gold; behind a hut", },
        [42408340]={ quest=36625, label="Discarded Pack", note="Gold; under the roots", },
        [42604680]={ quest=35056, label="Horned Skull", currency=824, },
        [43109290]={ quest=34241, item=118227, note="Ockbar's Pack", },
        [43907050]={ quest=36118, label="Pile of Rubble", note="Random green + gold; behind the ruined ogre statue head", },
        [43704240]={ quest=36618, label="Iron Supply Chest", currency=824, },
        [44207420]={ quest=35709, label="Laughing Skull Cache", currency=824, note="Up a tree", },
        [45004260]={ quest=36634, item=118713, note="Sniper's Crossbow", },
        [45704970]={ quest=36610, item=118708, note="Suntouched Spear", },
        [46105000]={ quest=36651, label="Harvestable Precious Crystal", currency=824, },
        [46204290]={ quest=36521, item=118707, note="Petrified Rylak Egg", },
        [48109340]={ quest=36604, label="Stashed Emergency Rucksack", },
        [48904730]={ quest=36203, item=118716, note="Warm Goren Egg", toy=true, },
        [49304360]={ quest=36596, item=107645, note="Weapons Cache", currency=824, },
        [52506690]={ quest=36509, item=118717, note="Odd Skull", },
        [53008000]={ quest=34940, item=118718, note="Strange Looking Dagger; cave entrance at 51.3,77.6", },
        [53107440]={ quest=36654, item=118714, note="Remains of Balik Orecrusher", },
        [57006530]={ quest=37249, item=118106, note="Strange Spore; on mushrooms on the cliff", pet=true, junk=true, },
        [57805600]={ quest=36605, item=118703, note="Remains of Balldir Deeprock", },
        [59406370]={ quest=36628, item=118712, note="Vindicator's Hammer; on a mushroom, climb up into Wildwood from 59.8,53.5 (yes, it's a long way), jump to the mushrooms at 61.9,60.0, and carry on across to the one with a nest on top", },
        [71906660]={ quest=nil, label="Sunken Treasure", currency=824, },
        -- rares
        [37608140]={ quest=36600, item=118231, npc=85970, }, -- Riptar
        [38206620]={ quest=35910, item=118224, npc=79629, }, -- Stomper Kreego
        [40007900]={ quest=35335, item=118222, npc=82085, toy=true, }, -- Bashiok
        [40205960]={ quest=36394, item=114227, npc=80725, toy=true, }, -- Sulfurious
        [41804540]={ quest=36391, item=118230, npc=81038, }, -- Gelgor of the Blue Flame
        [44609220]={ quest=36656, item=118223, npc=86137, }, -- Sunclaw
        [46003360]={ quest=37368, npc=86579, achievement=9655,  }, -- Blademaster Ro'gor
        [46205080]={ quest=36204, item=118229, npc=80868, }, -- Glut
        [46804320]={ quest=36186, item=118210, npc=84431, }, -- Greldrok the Cunning
        [47002380]={ quest=37365, npc=86577, achievement=9655, }, -- Horgg
        [47002580]={ quest=37364, npc=86582, achievement=9655, }, -- Morgo Kain
        [47603060]={ quest=37367, npc=86574, achievement=9655, }, -- Inventor Blammo
        [47804140]={ quest=36393, item=118211, npc=85264, }, -- Rolkor
        [48202100]={ quest=37362, npc=86566, achievement=9655, }, -- Defector Dazgo
        [49003380]={ quest=37363, npc=86562, achievement=9655, }, -- Maniacal Madgard
        [50002380]={ quest=37366, npc=86571, achievement=9655, }, -- Durp the Hated
        [50605320]={ quest=36178, item=118709, npc=84406, pet=true, }, -- Mandrakor
        [52207020]={ quest=35908, item=118209, npc=83522, }, -- Hive Queen Skrikka
        [52805360]={ quest=37413, item=119397, npc=78269, currency=823, }, -- Gnarljaw
        [53404460]={ quest=35503, item=118212, npc=82311, }, -- Char the Burning
        [53407820]={ quest=34726, item=118208, npc=76473, }, -- Mother Araneae
        [54207240]={ quest=36837, item=118228, npc=86520, }, -- Stompalupagus
        [55004660]={ quest=37377, item=119412, npc=88672, currency=823, achievement=9678, }, -- Hunter Bal'ra
        [57406860]={ quest=36387, item=118221, npc=85250, toy=true, }, -- Fossilwood the Petrified
        [57603580]={ quest=37370, item=119406, npc=82058, currency=823, achievement=9678, }, -- Depthroot
        [58006360]={ quest=35153, item=113453, npc=80785, }, -- Fungal Praetorian
        [58604120]={ quest=37371, npc=86268, currency=823, achievement=9678, }, -- Alkali
        [59603180]={ quest=37374, item=119367, npc=88582, currency=823, achievement=9678, }, -- Swift Onyx Flayer
        [59604300]={ quest=37375, item=119414, npc=88583, currency=823, achievement=9678, }, -- Grove Warden Yal
        [61803930]={ quest=37376, item=119391, npc=88586, currency=823, achievement=9678, }, -- Mogamago
        [63803160]={ quest=37372, npc=86266, achievement=9678, }, -- Venolasix
        [64006180]={ quest=36794, item=118213, npc=86410, }, -- Sylldross
        [69204460]={ quest=37369, item=119432, npc=86257, toy=true, achievement=9678, repeatable=true, note="Repeatable until you know the toy he drops", }, -- Basten
        [72803580]={ quest=37373, item=119381, npc=88580, achievement=9678, }, -- Firestarter Grash
        [76004200]={ quest=37405, npc=80371, currency=823, }, -- Typhon
        -- followers
        [39703990]={ quest=34463, follower=190, note="Mysterious Ring; collect all the Mysterious items across Draenor", }, -- Archmage Vargoth
        [44908690]={ quest=36037, npc=83820, follower=193, note="He'll look hostile; fight the things that are attacking him", }, -- Tormmok
        [42809090]={ quest=34279, npc=78030, follower=189, note="Follow the path up and fight him", }, -- Blook
        -- pepe!
        [47504130]={ quest=39267, item=127867, achievement=10053, }, -- Ninja Pepe
        -- Voidtalon
        [51603880]={ quest=37864, item=121815, note="Occasionally spawning portal", },
        [54004500]={ quest=37864, item=121815, note="Occasionally spawning portal", },
        [56004000]={ quest=37864, item=121815, note="Occasionally spawning portal", },
        [43203420]={ quest=37864, item=121815, note="Occasionally spawning portal", },
    },
    ["Talador"] = {
        -- treasures
        [33307670]={ quest=34259, label="Bonechewer Remnants", currency=824, },
        [35509660]={ quest=34249, label="Farmer's Bounty", currency=824, },
        [36509610]={ quest=34182, item=117567, note="Aarko's Family Treasure", },
        [37607490]={ quest=34148, item=112371, note="Bonechewer Spear; sticking out of Viperlash, cave entrance @ 36,75", },
        [38201250]={ quest=34258, label="Light of the Sea", currency=824, },
        [38408450]={ quest=34257, item=116119, note="Treasure of Ango'rosh", },
        [39307770]={ quest=35162, item=112699, note="Teroclaw Nest", pet=true, },
        [39505520]={ quest=34254, item=117570, note="Soulbinder's Reliquary", },
        [39807670]={ quest=35162, item=112699, note="Teroclaw Nest", pet=true, },
        [40608950]={ quest=34140, label="Yuuri's Gift", note="You have to complete Nightmare in the Tomb first", currency=824, faction="Alliance", },
        [47009170]={ quest=34256, item=116128, note="Relic of Telmor", },
        [52502950]={ quest=34235, item=116132, note="Luminous Shell", },
        [54002760]={ quest=34290, item=116402, note="Ketya's Stash", pet=true, },
        [54105630]={ quest=35162, item=112699, note="Teroclaw Nest", pet=true, },
        [55206680]={ quest=34253, item=116118, note="Draenei Weapons", currency=824, },
        [57207540]={ quest=34134, item=117563, note="Rescue 4 draenei trapped in spider webs, then Isaari's Cache will spawn here", faction="Alliance", junk=true, },
        [57402870]={ quest=34238, item=116120, note="Foreman's Lunchbox", toy=true, },
        [58901200]={ quest=33933, item=108743, note="Deceptia's Smoldering Boots", toy=true, },
        [61107170]={ quest=34116, item=117563, label="Rescue 4 adventurers trapped in spider webs, then Norana's Cache will spawn here", faction="Horde", },
        [62003240]={ quest=34236, item=116131, note="Amethyl Crystal", currency=824, },
        [62404800]={ quest=34252, item=110506, note="Barrel of Fish", },
        [64607920]={ quest=34251, item=117571, note="Iron Box", },
        [64901330]={ quest=34232, item=116117, note="Rook's Tacklebox", },
        [65501130]={ quest=34233, item=117568, note="Jug of Aged Ironwine, cave entrance to the north", },
        [65508860]={ quest=34255, item=116129, note="Webbed Sac", },
        [65908520]={ quest=34276, label="Rusted Lockbox", note="Random green", },
        [66608690]={ quest=34239, item=117569, note="Curious Deathweb Egg", toy=true, },
        [68785621]={ quest=34101, item=109192, note="Lightbearer", },
        [70100700]={ quest=36937, label="Burning Blade Cache", currency=823, },
        [70803200]={ quest=35162, item=112699, note="Teroclaw Nest", pet=true, },
        [70903550]={ quest=35162, item=112699, note="Teroclaw Nest", pet=true, },
        [72403700]={ quest=35162, item=112699, note="Teroclaw Nest", pet=true, },
        [72803560]={ quest=35162, item=112699, note="Teroclaw Nest", pet=true, },
        [73503070]={ quest=35162, item=112699, note="Teroclaw Nest", pet=true, },
        [73505140]={ quest=34471, item=116127, note="Bright Coin", },
        [74303400]={ quest=35162, item=112699, note="Teroclaw Nest", pet=true, },
        [74602930]={ quest=35162, item=112699, note="Teroclaw Nest", pet=true, },
        [75003600]={ quest=33649, npc=75644, }, -- Iron Scout (not sure what's on this... wowhead is silent...)
        [75704140]={ quest=34261, label="Keluu's Belongings", note="Gold", },
        [75804480]={ quest=34250, item=116128, note="Relic of Aruuna", },
        [77005000]={ quest=34248, item=116116, note="Charred Sword", },
        [78201480]={ quest=34263, item=117572, note="Pure Crystal Dust; upper level of the mine", },
        [81803500]={ quest=34260, item=109118, note="Aruuna Mining Cart", },
        -- rares
        [22207400]={ quest=36919, npc=85572, note="In a crate, no loot", }, -- Grrbrrgle
        [30502640]={ quest=37345, npc=82920, item=119388, }, -- Lord Korinak
        [31404750]={ quest=37344, npc=87668, currency=823, note="3 people needed to stand on the symbols", }, -- Orumo the Observer
        [31806380]={ quest=34189, npc=77719, item=116113, }, -- Glimmerwing
        [33803780]={ quest=37346, npc=82942, currency=823, }, -- Lady Demlash
        [34205700]={ quest=34221, npc=77795, item=113670, toy=true, }, -- Echo of Murmur
        [36804100]={ quest=37350, npc=88436, item=119383, }, -- Vigilant Paarthos
        [37203760]={ quest=37348, npc=82988, currency=823, }, -- Kurlosh Doomfang
        [37607040]={ quest=34165, npc=77620, item=116123, }, -- Cro Fleshrender
        [37802140]={ quest=37342, npc=88494, currency=823, achievement=9633, }, -- Legion Vanguard
        [38001460]={ quest=37343, npc=82922, item=119435, achievement=9633, }, -- Xothear the Destroyer (also drops 119371)
        [39004960]={ quest=37349, npc=82998, item=119353, }, -- Matron of Sin
        [41004200]={ quest=37347, npc=82930, currency=823, }, -- Shadowflame Terrorwalker
        [41506020]={ quest=34671, npc=79543, item=112370, }, -- Shirzir
        [44003800]={ quest=37339, npc=87597, achievement=9633, }, -- Bombardier Gu'gok
        [46002740]={ quest=37337, npc=88071, currency=823, achievement=9633, }, -- War Council: Strategist Ankor, Archmagus Tekar, Soulbinder Naylana
        [46005500]={ quest=34145, npc=77614, item=113288, }, -- Frenzied Golem (also drops 113287)
        [46603520]={ quest=37338, npc=88043, item=119378, achievement=9633, }, -- Avatar of Socrethar
        [47603900]={ quest=37340, npc=83019, item=119402, achievement=9633, }, -- Gug'tol
        [48002500]={ quest=37312, npc=83008, item=119403, achievement=9633, }, -- Haakun the All-Consuming
        [49009200]={ quest=34208, npc=77784, item=116070, }, -- Lo'marg Jawcrusher
        [50203520]={ quest=37341, npc=82992, item=119386, achievement=9633, }, -- Felfire Consort
        [50808380]={ quest=35018, npc=80204, item=112373, }, -- Felbark
        [53802580]={ quest=34135, npc=77529, item=112263, }, -- Yazheera the Incinerator
        [53909100]={ quest=34668, npc=79485, item=116110, }, -- Talonpriest Zorkra
        [56606360]={ quest=35219, npc=78710, item=116122, toy=true, }, -- Kharazos the Triumphant, Galzomar, Sikthiss
        [59008800]={ quest=34171, npc=77634, item=116126, note="Kill the hatchlings to summon", }, -- Taladorantula
        [59505960]={ quest=34196, npc=77741, item=116112, }, -- Ra'kahn
        [62004600]={ quest=34185, npc=77715, item=116124, }, -- Hammertooth
        [63802070]={ quest=34945, npc=80524, item=112475, note="Enrages if you kill his pet", }, -- Underseer Bloodmane
        [66808540]={ quest=34498, npc=78872, item=116125, toy=true, }, -- Klikixx
        [67408060]={ quest=34929, npc=80471, item=116075, }, -- Gennadian
        [67703550]={ quest=36858, npc=86549, item=117562, }, -- Steeltusk
        [68201580]={ quest=34142, npc=77561, item=112499, }, -- Dr. Gloom
        [69603340]={ quest=34205, npc=77776, item=112261, }, -- Wandering Vindicator
        [78005040]={ quest=34167, npc=77626, item=112369, }, -- Hen-Mother Hami
        [86403040]={ quest=34859, npc=79334, item=116077, }, -- No'losh
        -- followers
        [45303700]={ quest=34465, follower=190, note="Mysterious Hat; collect all the Mysterious items across Draenor", }, -- Archmage Vargoth
        [62755038]={ quest=nil, follower=171, note="Complete the quests starting with Clear!", }, -- Pleasure-Bot 8000 (actually a different quest for alliance and horde)
        [57405120]={ quest=36519, follower=207, note="Complete her quest", faction="Alliance", }, -- Defender Illona
        [58005300]={ quest=36518, follower=207, note="Complete her quest", faction="Horde", }, -- Aeda Brightdawn
        [56802600]={ quest=36522, follower=208, note="Complete his quest. Find him again outside your garrison.", }, -- Ahm
        -- pepe!
        [51006330]={ quest=39266, item=127869, achievement=10053, }, -- Knight Pepe
        -- Voidtalon
        [47004800]={ quest=37864, item=121815, note="Occasionally spawning portal", },
        [39705540]={ quest=37864, item=121815, note="Occasionally spawning portal", },
        [51904120]={ quest=37864, item=121815, note="Occasionally spawning portal", },
        [46205260]={ quest=37864, item=121815, note="Occasionally spawning portal", },
    },
    ["TombofSouls"] = {
        [67602320]={ quest=34671, npc=79543, item=112370, }, -- Shirzir
    },
    ["SpiresOfArak"] = {
        -- archeology
        [33302730]={ quest=36422, label="Sun-Touched Cache", currency=829, note="Needs archeology", },
        [42701830]={ quest=36244, label="Misplaced Scrolls", note="Needs archeology", currency=829, },
        [43001640]={ quest=36245, label="Relics of the Outcasts", currency=829, note="Needs archeology; on top of the walls", },
        [43202720]={ quest=36355, label="Relics of the Outcasts", currency=829, note="Needs archeology; climb the ropes", },
        [46004410]={ quest=36354, label="Relics of the Outcasts", currency=829, note="Needs archeology; climb the tree, jump to the rope", },
        [51904890]={ quest=36360, label="Relics of the Outcasts", currency=829, note="Needs archeology", },
        [52404280]={ quest=36416, label="Misplaced Scroll", currency=829, note="Needs archeology; start climbing the mountain at 53.6, 47.7", },
        [56304530]={ quest=36433, label="Smuggled Apexis Artifacts", currency=829, note="Needs archeology; climb  the mushrooms up the tree", },
        [60205390]={ quest=36359, label="Relics of the Outcasts", currency=829, note="Needs archeology", },
        [67403980]={ quest=36356, label="Relics of the Outcasts", currency=829, note="Needs archeology", },
        -- shrines
        [43802470]={ quest=36397, item=115463, note="Take to a Shrine of Terrok", repeatable=true, },
        [43901500]={ quest=36395, item=115463, note="Take to a Shrine of Terrok", repeatable=true, },
        [48906250]={ quest=36399, item=115463, note="Take to a Shrine of Terrok", repeatable=true, },
        [53108450]={ quest=nil, item=115463, note="Take to a Shrine of Terrok", repeatable=true, },
        [55602200]={ quest=36400, item=115463, note="Take to a Shrine of Terrok", repeatable=true, },
        [69204330]={ quest=36398, item=115463, note="Take to a Shrine of Terrok", repeatable=true, },
        [42402670]={ quest=36388, item=118242, note="Gift of Anzu", note="Drink Elixir of Shadow Sight", },
        [46904050]={ quest=36389, item=118238, note="Gift of Anzu", note="Drink Elixir of Shadow Sight", },
        [48604450]={ quest=36386, item=118237, note="Gift of Anzu", note="Drink Elixir of Shadow Sight", },
        [52001960]={ quest=36392, item=118239, note="Gift of Anzu", note="Drink Elixir of Shadow Sight", },
        [57007900]={ quest=36390, item=118241, note="Gift of Anzu", note="Drink Elixir of Shadow Sight", },
        [61105550]={ quest=36381, item=118240, note="Gift of Anzu", note="Drink Elixir of Shadow Sight", },
        [48305260]={ quest=36405, item=118267, note="Offering to the Raven Mother", },
        [48905470]={ quest=36406, item=118267, note="Offering to the Raven Mother", },
        [51906460]={ quest=36407, item=118267, note="Offering to the Raven Mother", },
        [53305560]={ quest=36403, item=118267, note="Offering to the Raven Mother", },
        [61006380]={ quest=36410, item=118267, note="Offering to the Raven Mother", },
        -- treasures
        [29504170]={ quest=35334, item=118207, pet=true, label="Egg of Varasha", note="In the cave", },
        [36801720]={ quest=36243, label="Outcast's Belongings", note="Random green", },
        [50402580]={ quest=36444, item=118691, note="Iron Horde Explosives", },
        [50702880]={ quest=36247, label="Lost Herb Satchel", note="Assorted herbs", },
        [36303940]={ quest=36402, item=120337, note="Orcish Signaling Horn", },
        [37204740]={ quest=36420, label="Garrison Supplies", currency=824, },
        [36505790]={ quest=36418, item=116914, note="Ephial's Dark Grimoire", },
        [47803610]={ quest=36411, item=116911, note="Lost Ring", },
        [49203730]={ quest=36445, item=116835, note="Assassin's Spear", },
        [46903400]={ quest=36446, label="Outcast's Pouch", note="Random green", },
        [47903070]={ quest=36361, item=116920, note="Shattered Hand Lockbox", },
        [42102170]={ quest=36447, label="Outcast's Belongings", note="Random green", },
        [34102750]={ quest=36421, label="Sun-Touched Cache", currency=824, },
        [68203880]={ quest=36375, npc=85190, item=118692, }, -- Sethekk Idol
        [71604850]={ quest=36450, item=109223, note="Sethekk Ritual Brew", },
        [41805050]={ quest=36451, item=116918, note="Garrison Workman's Hammer", },
        [56202880]={ quest=36362, label="Shattered Hand Cache", currency=824, },
        [68408900]={ quest=36453, label="Coinbender's Payment", note="Gold", },
        [63606740]={ quest=36454, label="Mysterious Mushrooms", note="Herbs", },
        [66505650]={ quest=36455, label="Waterlogged Satchel", note="Random green", },
        [54403240]={ quest=36364, item=118695, note="Toxicfang Venom", currency=824, },
        [59708130]={ quest=36365, label="Spray-O-Matic 5000 XT", currency=824, },
        [60908460]={ quest=36456, label="Shredder Parts", currency=824, },
        [55509080]={ quest=36366, label="Campaign Contributions", note="Gold", },
        [50502210]={ quest=36246, item=116919, note="Hidden in the water", }, -- Fractured Sunstone
        [44401200]={ quest=36377, npc=85206, item=118693, }, -- Rukhmar's Image
        [40605500]={ quest=36458, item=116913, note="Abandoned Mining Pick", },
        [58706030]={ quest=36340, item=116922, note="Ogron Plunder (Hobbit reference!)", },
        [37305070]={ quest=36657, item=116887, note="Feed the dog 3x[Rooby Reat] from the chef downstairs", },
        [37705640]={ quest=36462, item=116020, note="Unlocks a chest in Admiral Taylor's Garrison Town Hall @ 36.2,54.4", },
        [59109060]={ quest=36366, item=116917, note="In the control room", }, -- Sailor Zazzuk's 180-Proof Rum
        -- rares
        [25202420]={ quest=36943, npc=86978, item=118696, currency=824, }, -- Gaze, not certain about item-drop
        [33005900]={ quest=36305, npc=84951, item=116836, }, -- Gobblefin
        [33402200]={ quest=36265, npc=84805, item=116858, }, -- Stonespite
        [36405240]={ quest=36129, npc=82247, item=116837, }, -- Nas Dunberlin
        [38402780]={ quest=36470, npc=85504, item=118107, pet=true, }, -- Rotcap
        [46402860]={ quest=36267, npc=84807, item=118198, }, -- Durkath Steelmaw
        [46802300]={ quest=35599, npc=80614, item=116839, }, -- Blade-Dancer Aeryx
        [51800720]={ quest=37394, npc=83990, item=119407, }, -- Solar Magnifier
        [52003540]={ quest=36478, npc=79938, item=118201, }, -- Shadowbark
        [52805480]={ quest=36472, npc=85520, item=116857, }, -- Swarmleaf
        [53208900]={ quest=36396, npc=84417, item=118206, }, -- Mutafen
        [54606320]={ quest=36278, npc=84836, item=116838, }, -- Talonbreaker
        [54803960]={ quest=36297, npc=84890, item=118200, }, -- Festerbloom
        [56609460]={ quest=36306, npc=84955, item=118202, }, -- Jiasska the Sporegorger
        [57407400]={ quest=36254, npc=84775, item=116852, }, -- Tesska the Broken
        [58208460]={ quest=36291, npc=84887, item=116907, }, -- Betsi Boombasket
        [58604520]={ quest=36298, npc=84912, item=116855, }, -- Sunderthorn
        [59201500]={ quest=36887, npc=86724, item=118279, }, -- Hermit Palefur
        [59403740]={ quest=36279, npc=84838, item=118199, }, -- Poisonmaster Bortusk
        [62603740]={ quest=36268, npc=84810, item=118735, }, -- Kalos the Bloodbathed
        [64006480]={ quest=36283, npc=84856, item=118205, }, -- Blightglow
        [66005500]={ quest=36288, npc=84872, item=118204, }, -- Oskiira the Vengeful
        [69004880]={ quest=36276, npc=84833, item=118203, }, -- Sangrikrass
        [69005400]={ quest=37406, npc=80372, note="No loot", }, -- Echidna
        [71203380]={ quest=37392, npc=87027, currency=823, }, -- Shadow Hulk
        [74404280]={ quest=37390, npc=87019, currency=823, }, -- Glutonous Giant
        -- followers
        [55306850]={ quest=37168, follower=219, note="Follow the trail up the hill to 54.9,65.4, find him in the cave", }, -- Leorajh
        -- pepe!
        [54108360]={ quest=39268, item=127870, achievement=10053, }, -- Pirate Pepe
        -- Voidtalon
        [47002010]={ quest=37864, item=121815, note="Occasionally spawning portal", },
        [50400610]={ quest=37864, item=121815, note="Occasionally spawning portal", },
        [60801120]={ quest=37864, item=121815, note="Occasionally spawning portal", },
        [36501820]={ quest=37864, item=121815, note="Occasionally spawning portal", },
    },
    -- Garrisons!
    ["garrisonsmvalliance_tier1"] = {
        [49604380]={ quest=35530, currency=824, label="Lunarfall Egg", note="wagon", faction="Alliance", junk=true, },
        [51800110]={ quest=35289, currency=824, label="Spark's Stolen Supplies", note="cave by lake", junk=true, },
        [42405436]={ quest=35381, currency=824, label="Pippers' Buried Supplies", junk=true, },
        [50704850]={ quest=35382, currency=824, label="Pippers' Buried Supplies", junk=true, },
        [30802830]={ quest=35383, currency=824, label="Pippers' Buried Supplies", junk=true, },
        [49197683]={ quest=35384, currency=824, label="Pippers' Buried Supplies", junk=true, },
    },
    ["garrisonsmvalliance_tier2"] = {
        [37006590]={ quest=35530, currency=824, label="Lunarfall Egg, wagon", },
        [51800110]={ quest=35289, currency=824, label="Spark's Stolen Supplies", note="cave by lake", junk=true, },
        [41685803]={ quest=35381, currency=824, label="Pippers' Buried Supplies", junk=true, },
        [51874545]={ quest=35382, currency=824, label="Pippers' Buried Supplies", junk=true, },
        [34972345]={ quest=35383, currency=824, label="Pippers' Buried Supplies", junk=true, },
        [46637608]={ quest=35384, currency=824, label="Pippers' Buried Supplies", junk=true, },
    },
    ["garrisonsmvalliance_tier3"] = {
        [61277261]={ quest=35530, currency=824, label="Lunarfall Egg, tent", },
        [51800110]={ quest=35289, currency=824, label="Spark's Stolen Supplies", note="cave by lake", junk=true, },
        [60575515]={ quest=35381, currency=824, label="Pippers' Buried Supplies", junk=true, },
        [37307491]={ quest=35382, currency=824, label="Pippers' Buried Supplies", junk=true, },
        [37864378]={ quest=35383, currency=824, label="Pippers' Buried Supplies", junk=true, },
        [61527154]={ quest=35384, currency=824, label="Pippers' Buried Supplies", junk=true, },
    },
    ["garrisonffhorde_tier1"] = {
        [72505620]={ quest=34937, label="Lady Sena's Other Materials Stash", currency=824, faction="Horde", },
    },
    ["garrisonffhorde_tier2"] = {
        [72505620]={ quest=34937, label="Lady Sena's Other Materials Stash", currency=824, faction="Horde", },
    },
    ["garrisonffhorde_tier3"] = {
        [72505620]={ quest=34937, label="Lady Sena's Other Materials Stash", currency=824, faction="Horde", },
    },
    ["FoundryRaid"] = {
        [59305720] = { quest=34405, item=109118, label="Iron Horde Chest", junk=true, level=2, },
    },
    -- ["TanaanJungleIntro"] = {},
    ["TanaanJungle"] = {
        -- [42903490] = { quest=nil, currency=824, item=128346, note="Suspiciously Glowing Chest. Second floor", repeatable=true, },
        -- [35604620] = { quest=nil, currency=824, item=128346, note="Suspiciously Glowing Chest, in the cave", repeatable=true, },
        -- [49104660] = { quest=nil, currency=824, item=128346, note="Suspiciously Glowing Chest, on the pile", repeatable=true, },
        -- [22104980] = { quest=nil, currency=824, item=128346, note="Suspiciously Glowing Chest, on the ridge", repeatable=true, },
        -- [27506940] = { quest=nil, item=128346, currency=824, repeatable=true, }, -- draenic chest
        -- [21403570] = { quest=nil, item=128346, currency=824, repeatable=true, },
        [14905440] = { quest=38754, item=127325, achievement=10262, note="In the tower, on an orc hanging from a chain" }, -- weeping wolf axe
        [15904970] = { quest=38208, item=127324, achievement=10262, note="Back of cave", }, -- weathered axe
        [16005940] = { quest=38757, item=128220, achievement=10262, note="Second floor of the tower", }, -- grannok's eye
        [17005300] = { quest=38283, item=128346, achievement=10262, npc=91382, label="Small chest next to the body", }, -- deserter
        [17405700] = { quest=38755, item=128346, achievement=10262, currency=824, note="In the hut", }, -- spoils
        [19304100] = { quest=38320, item=127338, achievement=10262, note="Bottom of the lake", }, -- blade of Kra'nak
        [22004780] = { quest=38678, item=128346, achievement=10262, currency=824, note="In the hut", }, -- warchest
        [25305030] = { quest=38735, item=128222, achievement=10262, note="Top of tower, use rope to get up", }, -- enchanted spyglass
        [26506290] = { quest=38741, currency=823, achievement=10262, note="Top of tower, use rope to get up", }, -- bleeding hollow chest
        [26804410] = { quest=38683, item=127709, achievement=10262, }, -- Looted Bleeding Hollow Treasure
        [28702330] = { quest=38334, item=127668, achievement=10262, }, -- Jewel of Hellfire
        [28803460] = { quest=38863, currency=823, achievement=10262, }, -- Partially Mined Apexis Crystal
        [30307190] = { quest=38629, item=127389, achievement=10262, }, -- polished crystal
        [31403110] = { quest=38732, item=127413, achievement=10262, }, -- Jeweled Arakkoa Effigy
        [32407040] = { quest=38426, item=127670, achievement=10262, toy=true, }, -- sargerei tome
        [33907810] = { quest=38760, item=128346, achievement=10262, }, -- captain booty 1
        [34407830] = { quest=38762, item=128346, achievement=10262, }, -- captain booty 3
        [34703464] = { quest=38742, item=127669, achievement=10262, note="Bottom of the cave. Watch out for fall damage.", }, -- Mad Chief
        [34707710] = { quest=38761, item=128346, achievement=10262, }, -- captain booty 2
        [35907860] = { quest=38758, currency=824, achievement=10262, }, -- Ironbeard's Treasure
        [36304350] = { quest=37956, item=127397, achievement=10262, }, -- Strange Sapphire
        [37004620] = { quest=38640, currency=824, achievement=10262, }, -- Pale Removal Equipment
        [37808070] = { quest=38788, item=127770, achievement=10262, }, -- brazier
        [40607980] = { quest=38638, item=127333, achievement=10262, }, -- snake flute
        [40807550] = { quest=38639, item=127766, achievement=10262, toy=true, }, -- perfect blossom
        [41607330] = { quest=38657, item=127339, achievement=10262, }, -- forgotten champion sword
        [42803530] = { quest=38822, item=127859, achievement=10262, note="Top floor", toy=true, },
        [43203830] = { quest=38821, item=127348, achievement=10262, note="In the building" },
        [46207280] = { quest=38739, item=128320, achievement=10262, }, -- Mysterious Corrupted Obelisk
        [46804220] = { quest=38776, item=127328, achievement=10262, }, -- blade
        [46903660] = { quest=38771, item=127347, achievement=10262, }, -- book
        [46904440] = { quest=38773, item=128218, achievement=10262, }, -- fel satchel
        [47907040] = { quest=38705, item=127329, achievement=10262, }, -- Crystalized Essence of Elements
        [48507520] = { quest=38814, item=127337, achievement=10262, }, -- Looted Mystical Staff
        [49907680] = { quest=38809, item=128223, achievement=10262, }, -- Bleeding Hollow Mushroom Stash
        [49907960] = { quest=38703, item=127354, achievement=10262, }, -- Scouts Belongings
        [49908120] = { quest=38702, item=127312, achievement=10262, }, -- Discarded Helm
        [50806490] = { quest=38731, item=127412, achievement=10262, }, -- overgrown relic
        [51603270] = { quest=39075, currency=823, achievement=10262, }, -- Fel-Tainted Apexis Formation
        [51702430] = { quest=38686, item=127341, achievement=10262, }, -- Rune Etched Femur
        [54806930] = { quest=38593, item=127334, achievement=10262, note="Climb the vine bridge, spear in the side", }, -- spear
        [54909070] = { quest=39470, currency=824, achievement=10262, }, -- Dead Mans Chest
        [56906510] = { quest=38591, item=127408, achievement=10262, }, -- broken selfie sack
        [58502500] = { quest=38679, item=115804, achievement=10262, }, -- Jewel of the Fallen Star
        [61207580] = { quest=38601, currency=824, achievement=10262, }, -- Blackfang Isle Cache
        [62107070] = { quest=38602, item=128217, achievement=10262, }, -- Crystalized Fel Spike
        [62602050] = { quest=38682, item=127401, achievement=10262, }, -- Censer of Torment
        [63402810] = { quest=38740, item=128309, achievement=10262, }, -- Forgotten Shard of the Cipher
        [64704280] = { quest=38701, item=127396, achievement=10262, toy=true, }, -- Loose Soil
        [65908500] = { quest=39469, item=128386, achievement=10262, }, -- Bejeweled Egg
        [69705600] = { quest=38704, currency=824, achievement=10262, }, -- Forgotten Iron Horde Supplies
        [73604320] = { quest=38779, note="First floor of north-east tower", achievement=10262, }, -- Stashed Bleeding Hollow Loot
    },
    ["AshranAllianceFactionHub"] = {
        [45307020] = { follower=467, faction="Alliance", note="Outside the town hall", }, -- Fen Tao
    },
    ["AshranHordeFactionHub"] = {
        [47004500] = { follower=467, faction="Horde", note="Outside the inn", }, -- Fen Tao
    },
}
