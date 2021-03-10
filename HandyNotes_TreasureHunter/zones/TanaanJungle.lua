local myname, ns = ...

-- ["TanaanJungleIntro"] = {},
ns.RegisterPoints(534, { -- TanaanJungle
    -- [42903490] = { quest=nil, currency=824, loot={128346}, label="Suspiciously Glowing Chest", note="Second floor", repeatable=true, },
    -- [35604620] = { quest=nil, currency=824, loot={128346}, label="Suspiciously Glowing Chest", note="in the cave", repeatable=true, },
    -- [49104660] = { quest=nil, currency=824, loot={128346}, label="Suspiciously Glowing Chest", note="on the pile", repeatable=true, },
    -- [22104980] = { quest=nil, currency=824, loot={128346}, label="Suspiciously Glowing Chest", note="on the ridge", repeatable=true, },
    -- [27506940] = { quest=nil, loot={128346}, currency=824, repeatable=true, }, -- draenic chest
    -- [21403570] = { quest=nil, loot={128346}, currency=824, repeatable=true, },
    [14905440] = { quest=38754, loot={127325}, note="In the tower, on an orc hanging from a chain" }, -- weeping wolf axe
    [15904970] = { quest=38208, loot={127324}, note="Back of cave", }, -- weathered axe
    [16005940] = { quest=38757, loot={128220}, note="Second floor of the tower", }, -- grannok's eye
    [17005300] = { quest=38283, loot={128346}, npc=91382, note="Small chest next to the body", }, -- deserter
    [17405700] = { quest=38755, loot={128346}, currency=824, note="In the hut", }, -- spoils
    [19304100] = { quest=38320, loot={127338}, note="Bottom of the lake", }, -- blade of Kra'nak
    [22004780] = { quest=38678, loot={128346}, currency=824, note="In the hut", }, -- warchest
    [25305030] = { quest=38735, loot={128222}, note="Top of tower, use rope to get up", }, -- enchanted spyglass
    [26506290] = { quest=38741, currency=823, note="Top of tower, use rope to get up", }, -- bleeding hollow chest
    [26804410] = { quest=38683, loot={127709}, }, -- Looted Bleeding Hollow Treasure
    [28702330] = { quest=38334, loot={127668}, }, -- Jewel of Hellfire
    [28803460] = { quest=38863, currency=823, }, -- Partially Mined Apexis Crystal
    [30307190] = { quest=38629, loot={127389}, }, -- polished crystal
    [31403110] = { quest=38732, loot={127413}, }, -- Jeweled Arakkoa Effigy
    [32407040] = { quest=38426, loot={127670}, toy=true, }, -- sargerei tome
    [33907810] = { quest=38760, loot={128346}, }, -- captain booty 1
    [34407830] = { quest=38762, loot={128346}, }, -- captain booty 3
    [34703464] = { quest=38742, loot={127669}, note="Bottom of the cave. Watch out for fall damage.", }, -- Mad Chief
    [34707710] = { quest=38761, loot={128346}, }, -- captain booty 2
    [35907860] = { quest=38758, currency=824, }, -- Ironbeard's Treasure
    [36304350] = { quest=37956, loot={127397}, }, -- Strange Sapphire
    [37004620] = { quest=38640, currency=824, }, -- Pale Removal Equipment
    [37808070] = { quest=38788, loot={127770}, }, -- brazier
    [40607980] = { quest=38638, loot={127333}, }, -- snake flute
    [40807550] = { quest=38639, loot={127766}, toy=true, }, -- perfect blossom
    [41607330] = { quest=38657, loot={127339}, }, -- forgotten champion sword
    [42803530] = { quest=38822, loot={127859}, note="Top floor", toy=true, },
    [43203830] = { quest=38821, loot={127348}, note="In the building" },
    [46207280] = { quest=38739, loot={128320}, }, -- Mysterious Corrupted Obelisk
    [46804220] = { quest=38776, loot={127328}, }, -- blade
    [46903660] = { quest=38771, loot={127347}, }, -- book
    [46904440] = { quest=38773, loot={128218}, }, -- fel satchel
    [47907040] = { quest=38705, loot={127329}, }, -- Crystalized Essence of Elements
    [48507520] = { quest=38814, loot={127337}, }, -- Looted Mystical Staff
    [49907680] = { quest=38809, loot={128223}, }, -- Bleeding Hollow Mushroom Stash
    [49907960] = { quest=38703, loot={127354}, }, -- Scouts Belongings
    [49908120] = { quest=38702, loot={127312}, }, -- Discarded Helm
    [50806490] = { quest=38731, loot={127412}, }, -- overgrown relic
    [51603270] = { quest=39075, currency=823, }, -- Fel-Tainted Apexis Formation
    [51702430] = { quest=38686, loot={127341}, }, -- Rune Etched Femur
    [54806930] = { quest=38593, loot={127334}, note="Climb the vine bridge, spear in the side", }, -- spear
    [54909070] = { quest=39470, currency=824, }, -- Dead Mans Chest
    [56906510] = { quest=38591, loot={127408}, }, -- broken selfie sack
    [58502500] = { quest=38679, loot={115804}, }, -- Jewel of the Fallen Star
    [61207580] = { quest=38601, currency=824, }, -- Blackfang Isle Cache
    [62107070] = { quest=38602, loot={128217}, }, -- Crystalized Fel Spike
    [62602050] = { quest=38682, loot={127401}, }, -- Censer of Torment
    [63402810] = { quest=38740, loot={128309}, }, -- Forgotten Shard of the Cipher
    [64704280] = { quest=38701, loot={127396}, toy=true, }, -- Loose Soil
    [65908500] = { quest=39469, loot={128386}, }, -- Bejeweled Egg
    [69705600] = { quest=38704, currency=824, }, -- Forgotten Iron Horde Supplies
    [73604320] = { quest=38779, note="First floor of north-east tower", }, -- Stashed Bleeding Hollow Loot
}, {
    achievement=10262,
    hide_quest=39463,
})

-- Rares

ns.RegisterPoints(534, { -- TanaanJungle
    [15006300]={ quest=39288, criteria=28221, npc=95044, loot={116658,116669,116780,128315,128025},}, -- Terrorfist
    [23004020]={ quest=39287, criteria=28220, npc=95053, loot={116658,116669,116780,128315,128025},}, -- Deathtalon
    [32407380]={ quest=39290, criteria=28219, npc=95054, loot={116658,116669,116780,128315,128025},}, -- Vengeance
    [46805260]={ quest=39289, criteria=28218, npc=95056, loot={116658,116669,116780,128315,128025},}, -- Doomroller
}, {
    achievement=10061,
    atlas="VignetteKillElite", scale=1.2,
})

ns.RegisterPoints(534, { -- TanaanJungle
    [37807260]={ quest=38632, criteria=28366, npc=92636, note="Find it several times and it'll appear to fight", }, -- The Night Haunter
    [39007300]={ quest=38631, criteria=28365, npc=92627, }, -- Rendrak
    [44403740]={ quest=37990, criteria=28338, npc=90519, }, -- Cindral the Wildfire
    [12605660]={ quest=38751, criteria=28350, npc=92977, }, -- The Iron Houndmaster
    [13405640]={ quest=38747, criteria=28347, npc=91243, }, -- Tho'gar Gorefist
    [15005420]={ quest=38746, criteria=28346, npc=91232, }, -- Commander Krag'goth
    [15805700]={ quest=38752, criteria=28349, npc=93001, }, -- Szirek the Twisted
    [16005900]={ quest=38750, criteria=28348, npc=93057, }, -- Grannok
    [16804300]={ quest=38034, criteria=28341, npc=90782, }, -- Rasthe
    [16804820]={ quest=38282, criteria=28329, npc=91374, }, -- Podlord Wakkawam
    [20005360]={ quest=38736, criteria=28369, npc=93028, }, -- Driss Vile
    [20404980]={ quest=38263, criteria=28352, npc=90885, }, -- Rogond the Tracker
    [21005240]={ quest=38266, criteria=28355, npc=90936, }, -- Bloodhunter Zulk
    [22804880]={ quest=38265, criteria=28353, npc=90887, }, -- Dorg the Bloody
    [23405220]={ quest=38262, criteria=28351, npc=90884, }, -- Bilkor the Thrower
    [25207620]={ quest=38029, criteria=28334, npc=90438, }, -- Lady Oran
    [25404620]={ quest=38264, criteria=28354, npc=90888, }, -- Drivnul
    [25807960]={ quest=38032, criteria=28337, npc=90442, }, -- Mistress Thavra
    [26205420]={ quest=38496, criteria=28356, npc=92197, }, -- Relgor
    [26207540]={ quest=38030, criteria=28335, npc=90437, }, -- Jax'zor
    [27403260]={ quest=37937, criteria=28340, npc=92451, }, -- Varyx the Damned
    [28805100]={ quest=38775, criteria=28372, npc=93168, }, -- Felbore
    [30807140]={ quest=38026, criteria=28333, npc=90429, loot={127655},}, -- Imp-Master Valessa
    [31406740]={ quest=38031, criteria=28336, npc=90434, }, -- Ceraxas
    [32603540]={ quest=38709, criteria=28368, npc=92941, }, -- Gorabosh
    [34004420]={ quest=38620, criteria=28362, npc=92574, }, -- Thromma the Gutslicer
    [34407240]={ quest=38654, criteria=28367, npc=92694, }, -- The Goreclaw
    [34407780]={ quest=38764, criteria=28371, npc=93125, }, -- Glub'glok
    [35004700]={ quest=38609, criteria=28363, npc=92552, }, -- Belgork
    [35808020]={ quest=38756, criteria=28370, npc=93076, loot={127659},}, -- Captain Ironbeard
    [37003300]={ quest=39045, criteria=28723, npc=90122, }, -- Zoug the Heavy
    [39006840]={ quest=38209, criteria=28330, npc=91093, loot={127652},}, -- Bramblefell
    [39403240]={ quest=39046, criteria=28724, npc=90094, }, -- Harbormaster Korak
    [39606820]={ quest=38825, criteria=28377, npc=93279, }, -- Kris'kar the Unredeemed
    [41007860]={ quest=38628, criteria=28364, npc=92606, }, -- Sylissa
    [41403740]={ quest=37953, criteria=28339, npc=90024, }, -- Sergeant Mor'grak
    [45804700]={ quest=38634, criteria=28726, npc=92647, }, -- Felsmith Damorka
    [46404220]={ quest=38400, criteria=28343, npc=91695, }, -- Grand Warlock Nethekurse
    [48202840]={ quest=38207, criteria=28331, npc=91087, }, -- Zeter'el
    [48405700]={ quest=38820, criteria=28730, npc=93264, }, -- Captain Grok'mar
    [49207340]={ quest=38597, criteria=28361, npc=92465, }, -- The Blackfang
    [49603660]={ quest=38411, criteria=28380, npc=91727, }, -- Executor Riloth
    [49606100]={ quest=38812, criteria=28725, npc=93236, }, -- Shadowthrash
    [50004780]={ quest=38749, criteria=28731, npc=89675, }, -- Commander Org'mok
    [50807440]={ quest=38696, criteria=28376, npc=92657, }, -- Bleeding Hollow Horror
    [51802740]={ quest=38211, criteria=28332, npc=91098, }, -- Felspark
    [51808340]={ quest=38605, criteria=28360, npc=92517, }, -- Krell the Serene
    [52201980]={ quest=38580, criteria=28729, npc=92411, }, -- Overlord Ma'gruth
    [52206500]={ quest=38726, criteria=28345, npc=93002, }, -- Magwia
    [52404020]={ quest=38430, criteria=28722, npc=91871, }, -- Argosh the Destroyer
    [53402140]={ quest=38557, criteria=28342, npc=92274, }, -- Painmistress Selora
    [55208080]={ -- Rumble in the Jungle: Akrrilo, Rendarr, Eyepiercer
        label="{quest:39565}",
        quest={39379,39399,39400},
        criteria={28373,28374,28375},
        note="Summon and defeat {npc:92766}, {npc:92817}, {npc:92819}",
        npc=92819,
        atlas="VignetteKillElite", scale=1.1,
    },
    [57002300]={ quest=38457, criteria=28727, npc=91009, }, -- Putre'thar
    [57606720]={ quest=38589, criteria=28357, npc=92429, }, -- Broodlord Ixkor
    [60002100]={ quest=38579, criteria=28728, npc=92408, }, -- Xanzith the Everlasting
    [62407240]={ quest=38600, criteria=28358, npc=92495, }, -- Soulslicer
    [63408100]={ quest=38604, criteria=28359, npc=92508, }, -- Gloomtalon
    [64603700]={ quest=38700, criteria=28344, npc=92887, }, -- Steelsnout
}, {
    achievement=10070,
})

ns.RegisterPoints(534, { -- TanaanJungle
    -- non-achievement:
    [40605640]={ quest=40107, npc=98408, loot={129295}, }, -- Fel Overseer Mudlump
    [20204120]={ quest=38028, npc=90777, loot={122117},}, -- High Priest Ikzan
    [22205040]={ quest=39159, npc=91227, loot={127666},}, -- Remnant of the Blood Moon
    [38408060]={ quest=37407, npc=80398, }, -- Keravnos
    [80405660]={ quest=40106, npc=98284, loot={108633},}, -- Gondar
    [83404340]={ quest=40105, npc=98283, loot={108631},}, -- Drakum
    [87605580]={ quest=40104, npc=98285, loot={108634},}, -- Smashum Grabb
})
