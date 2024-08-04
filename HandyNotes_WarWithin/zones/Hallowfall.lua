local myname, ns = ...

-- Treasures

ns.RegisterPoints(ns.HALLOWFALL, {
    [41795827] = { -- Caesper
        criteria=69692,
        quest=83263,
        loot={225639}, -- Recipe: Exquisitely Eviscerated Muscle
        active=ns.conditions.Item(225238), -- Meaty Haunch
        related={
            [69254397]={label="{npc:217645:Torran Dellain}", note="Buy {item:225238:Meaty Haunch}"},
        },
        note="Buy {item:225238:Meaty Haunch} from {npc:217645:Torran Dellain}",
    },
    [55145185] = { -- Smuggler's Treasure
        criteria=69693,
        quest=83273,
        loot={226021}, -- Jar of Pickles
        note="Get the key from the dead NPC",
    },
    [59716058] = { -- Dark Ritual
        criteria=69694,
        quest=83284,
        loot={225693}, -- Shadowed Essence
        note="In cave; use the book, defeat the summoned monsters",
    },
    [40035112] = { -- Arathi Loremaster
        criteria=69695,
        quest=83298,
        loot={{225659, toy=true}},
        note="Answer riddles from {npc:221630:Ryfus Sacredpyr}; you need to find the books for {achievement:40622:Biblo Archivist} for the correct answers to appear",
    },
    [55726960] = { -- Jewel of the Cliffs
        criteria=69697,
        quest=81971,
        loot={224580}, -- Massive Sapphire Chunk
        note="High up on the rocks",
    },
    [30233875] = { -- Priory Satchel
        criteria=69698,
        quest=81972,
        loot={224578}, -- Arathor Courier's Satchel
        note="Hanging from the cathedral",
    },
    [50071385] = { -- Lost Necklace
        criteria=69699,
        quest=81978,
        loot={224575}, -- Lightbearer's Pendant
    },
    [57652744] = { -- Illuminated Footlocker
        criteria=69701,
        quest=81468,
        loot={{224552, toy=true}},
        note="Catch falling glimmers from {npc:220703:Starblessed Glimmerfly} until you get {spell:442529:Glimmering Illumination}",
    },
    [76165399] = { -- Spore-covered Coffer
        criteria=69702,
        quest=79275,
        loot={}, -- alchemy mats
        note="In cave",
    },
    -- [] = {criteria=69700, quest=82005}, -- Sky-Captains' Sunken Cache
}, {
    achievement=40848,
})

-- Illusive Kobyss Lure (Treasures)
ns.RegisterPoints(ns.HALLOWFALL, {
    [55362720] = {label="{npc:215653:Kobyss Shadeshaper}: {item:225554:Sunless Lure}",},
    [47611854] = {label="{npc:213622:Murkfin Depthstalker}: {item:225558:Murkfin Lure}",},
    [50655037] = {label="{npc:215243:Hungering Shimmerfin}: {item:225559:Hungering Shimmerfin}",},
    [34965465] = {label="{npc:213406:Ragefin Necromancer}: {item:225560:Ragefin Necrostaff}",},
}, {
    achievement=40848, -- Treasures
    criteria=69696,
    quest=83299,
    atlas="Vehicle-TempleofKotmogu-CyanBall", scale=1.2,
    loot={{225641, toy=true}}, -- Illusive Kobyss Lure
    note="Gather and combine {item:225554:Sunless Lure}, {item:225558:Murkfin Lure}, {item:225559:Hungering Shimmerfin}, {item:225560:Ragefin Necrostaff}",
})

-- Biblo Archivist
ns.RegisterPoints(ns.HALLOWFALL, {
    [48153959] = {criteria=68954, loot={225212}, note="Needed for {achievement:40848.69695:Arathi Loremaster}"}, -- The Big Book of Arathi Idioms
    [43884991] = {criteria=68955, loot={225217}}, -- 500 Dishes Using Cave Fish and Mushrooms
    [69344394] = {criteria=68957, loot={225207}, note="Needed for {achievement:40848.69695:Arathi Loremaster}"}, -- Care and Feeding of the Imperial Lynx
    [68684159] = {criteria=68958, loot={225206}}, -- Light's Gambit Playbook
    [57595180] = {criteria=68960, loot={225208}}, -- From the Depths They Come
    [48806470] = {criteria=68961, loot={225216}, note="Needed for {achievement:40848.69695:Arathi Loremaster}"}, -- Palawltar's Codex of Dimensional Structure
    [64182812] = {criteria=68963, loot={225204}, note="Needed for {achievement:40848.69695:Arathi Loremaster}"}, -- Shadow Curfew Guidelines
    [59802203] = {criteria=68965, loot={225205}}, -- Shadow Curfew Journal
    [70225684] = {criteria=68967, loot={225215}, note="Needed for {achievement:40848.69695:Arathi Loremaster}"}, -- The Song of Renilash
    [56586518] = {criteria=68968, loot={225203}, note="Needed for {achievement:40848.69695:Arathi Loremaster}"}, -- Beledar- The Emperor's Vision
    -- [] = {criteria=69729, loot={228457}}, -- Lightspark Grade Book
}, {
    achievement=40622,
    texture=ns.atlas_texture("profession", {r=0, g=1, b=1}),
    minimap=true,
})

-- The Missing Lynx
ns.RegisterPoints(ns.HALLOWFALL, {
    [60426022] = {criteria=68975, npc=220720}, -- Magpie
    [42695384] = {criteria=68998,}, -- Evan
    [42735388] = {criteria=68999,}, -- Emery
    [42305381] = {criteria=69000,}, -- Jinx
    [69274372] = {criteria=69001,}, -- Moog
    [69274372] = {criteria=69002,}, -- Iggy
    [63302940] = {criteria=7, note="Light the lesser keyflame"}, -- Nightclaw
    [63262811] = {criteria=8, note="Light the blooming keyflame"}, -- Shadowpouncer
    [63792932] = {criteria=9, note="Light the blooming keyflame"}, -- Purrlock
    [61193054] = {criteria=10,}, -- Miral Murder-Mittens
    [64441857] = {criteria=11,}, -- Fuzzy
    [64441857] = {criteria=12,}, -- Furball
    [61922081] = {criteria=13,}, -- Dander
    [42145371] = {criteria=69010,}, -- Gobbo
}, {
    achievement=40625,
    atlas="WildBattlePet", color={r=0.75, g=1, b=0},
})

-- Rares

ns.RegisterPoints(ns.HALLOWFALL, {
    [23005920] = { -- Lytfang the Lost
        criteria=69710,
        quest=81756,
        npc=221534,
        vignette=6145,
    },
    [63402880] = { -- Moth'ethk
        criteria=69719,
        quest=82557,
        npc=206203,
        loot={
            211973, -- Spider-Touched Bag
        },
        vignette=5958,
    },
    [44001620] = { -- The Perchfather
        criteria=69711,
        quest=81791,
        npc=221648,
        vignette=6151,
    },
    [56806920] = { -- The Taskmaker
        criteria=69708,
        quest=80009,
        npc=218444,
        vignette=6033,
    },
    [32405400] = { -- Grimslice
        -- [32405400, 32805200, 33205640, 33605740, 34205200, 37005480]
        criteria=69706,
        quest=81761,
        npc=221551,
        vignette=6146,
    },
    [42803100] = { -- Strength of Beledar
        criteria=69713,
        quest=81849,
        npc=221690,
        vignette=6153,
    },
    [57006420] = { -- Ixlorb the Spinner
        criteria=69704,
        quest=80006,
        npc=218426,
        vignette=6032,
    },
    [62401320] = { -- Murkspike
        criteria=69728,
        quest=82565,
        npc=220771,
        vignette=6123,
    },
    [63203140] = { -- Deathpetal
        criteria=69721,
        quest=82559,
        npc=206184,
        loot={
            211967, -- Large Sealed Crate
        },
        vignette=6078,
    },
    [72006420] = { -- Deepfiend Azellix
        criteria=69703,
        quest=80011,
        npc=218458,
        vignette=6035,
    },
    [64401880] = { -- Duskshadow
        criteria=69724,
        quest=82562,
        npc=221179,
        vignette=6122,
    },
    [36807180] = { -- Funglour
        criteria=69707,
        quest=81881,
        npc=221767,
        vignette=6157,
    },
    [35803540] = { -- Sir Alastair Purefire
        -- [35803540, 36203560]
        criteria=69714,
        quest=81853,
        npc=221708,
        vignette=6154,
    },
    [43410990] = { -- Horror of the Shallows
        criteria=69712,
        quest=81836,
        npc=221668,
        loot={
            221211, -- Grasp of the Shallows
        },
        vignette=6152,
        note="Very long patrol",
        route={
            43410990,43870879,44520774,45250767,45970726,45540662,44870677,44270749,43710858,43230977,42781094,42351213,41981324,41631452,41391580,41051714,40501821,39731909,38871990,38132054,37392117,36652173,35992256,35292353,34632446,33992545,33422650,32912763,32492891,32153010,31783130,30933154,29993162,29123191,28213204,27343238,26553287,26513416,26813550,27393654,27983757,28633853,29403934,30173998,30764092,30984221,30594339,29814381,28934419,28064452,27194486,26364534,25664611,24954700,24144768,23314830,23274858,22464885,21604925,20774968,19904976,19565105,20285138,20865040,21614971,22474926,
            r=0,g=0,b=1,
        },
    },
    -- UNKNOWN LOCATION
    --[[
    [] = { -- Sloshmuck
        criteria=69709,
        quest=79271,
        npc=215805,
        vignette=5988,
    },
    [] = { -- Brineslash
        criteria=69718,
        quest=80486,
        npc=220159,
        vignette=6075,
    },
    [] = { -- Crazed Cabbage Smacker
        criteria=69720,
        quest=82558,
        npc=206514,
        vignette=6120,
    },
    [] = { -- Croakit
        criteria=69722,
        quest=82560,
        npc=214757,
        vignette=6125,
        --tameable=true, -- hopper
    },
    [] = { -- Toadstomper
        criteria=69723,
        quest=82561,
        npc=207803,
        vignette=6084,
    },
    [] = { -- Parasidious
        criteria=69725,
        quest=82563,
        npc=206977,
        vignette=6361,
    },
    [] = { -- Ravageant
        criteria=69726,
        quest=82566,
        npc=207826,
        vignette=6124,
    },
    [] = { -- Finclaw Bloodtide
        criteria=69727,
        quest=82564,
        npc=207780, -- also 220492?
        loot={}
        vignette=6085,
    },
    [] = { -- Pride of Beledar
        criteria=69715,
        quest=81882,
        npc=221786,
        vignette=6159,
        -- tameable=true, -- stag
        note="UNKNOWN LOCATION",
    },
    [] = { -- Murkshade
        criteria=69705,
        quest=80010,
        npc=218452,
        vignette=6034,
    },
    --]]
}, {
    achievement=40851,
})
-- Beledar's Spawn
ns.RegisterPoints(ns.HALLOWFALL, {
    [25825754] = {},
    [32673962] = {},
    [37207191] = {},
    [37744585] = {},
    [38382474] = {},
    [42733133] = {},
    [45252569] = {},
    [47015504] = {},
    [48853197] = {},
    [50514857] = {},
    [51427080] = {},
    [54833679] = {},
    [58034885] = {},
    [60451862] = {},
    [61380753] = {},
    [62823857] = {},
    [68123014] = {},
    [71976558] = {},
    [72066566] = {},
    [72804152] = {},
}, {
    achievement=40851,
    criteria=69716,
    quest=81763,
    npc=207802,
    loot={{223315, mount=2192}}, -- Beledar's Spawn
    requires=ns.conditions.MajorFaction(ns.FACTION_ARATHI, 23),
    active=ns.conditions.QuestComplete(82998), -- attunement
    note="Buy and use {item:224553:Beledar's Attunement} from {majorfaction:2570:Hallowfall Arathi} to access",
    vignette=6359, -- also 6118?
})

-- Deathtide
local deathtide = ns.nodeMaker{
    achievement=40851,
    criteria=69717,
    quest=81880,
}
ns.RegisterPoints(ns.HALLOWFALL, {
    [44744241] = { -- Deathtide
        npc=221753,
        loot={223921}, -- Ever-Oozing Signet
        vignette=6156,
        active=ns.conditions.Item(220123), -- Ominous Offering
        note="Create an {item:220123:Ominous Offering} to summon",
    },
}, deathtide{})
ns.RegisterPoints(ns.HALLOWFALL, {
    -- Jar of Mucus
    [48001668] = {route={48001668, 44744241, highlightOnly=true}},
}, deathtide{
    label="{item:220124}",
    loot={220124},
    texture=ns.atlas_texture("playerpartyblip",{r=0,g=1,b=1,}),
    note="Take to {npc:221753} @ 44.7,42.4",
})
ns.RegisterPoints(ns.HALLOWFALL, {
     -- Offering of Pure Water
    [28925120] = {route={28925120, 44744241, highlightOnly=true}},
    [34185782] = {route={34185782, 44744241, highlightOnly=true}},
    [34365357] = {route={34365357, 44744241, highlightOnly=true}},
    [43451413] = {route={43451413, 44744241, highlightOnly=true}},
    [50094966] = {route={50094966, 44744241, highlightOnly=true}},
    [53771913] = {route={53771913, 44744241, highlightOnly=true}},
    [55142344] = {route={55142344, 44744241, highlightOnly=true}},
}, deathtide{
    label="{item:220122}",
    loot={220122},
    texture=ns.atlas_texture("playerpartyblip",{r=0,g=0,b=1,}),
    note="Take to {npc:221753} @ 44.7,42.4",
})


ns.RegisterPoints(ns.HALLOWFALL, {
    [63400560] = { -- Radiant-Twisted Mycelium
        quest=nil,
        npc=214905,
        vignette=5984,
    },
})
