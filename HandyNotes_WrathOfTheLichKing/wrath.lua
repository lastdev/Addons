local myname, ns = ...

-- Borean Tundra
ns.RegisterPoints(114, {
    [21002840] = {
        route={21002840,22003340,27003560,35402940,34002420},
    },
    [34002420] = {route=21002840},
}, { -- Old Crystalbark
    achievement=2257,
    criteria=8103,
    npc=32357,
    loot={44649},
})
ns.RegisterPoints(114, {
    [62603480] = {route={62603480,59802540,59801460,68001920,73603260,68403660,loop=true,}},
}, { -- Fumblub Gearwind
    achievement=2257,
    criteria=8104,
    npc=32358,
    loot={44666},
})
ns.RegisterPoints(114, {
    [80404600] = {route={80404600,84104570}},
    [81203160] = {route={81203160,91403240}},
    [88203960] = {},
}, { -- Icehorn
    achievement=2257,
    criteria=8105,
    npc=32361,
    loot={44667},
})

-- Howling Fjord
ns.RegisterPoints(117, {
    [49800460] = {},
    [52801160] = {},
    [60802000] = {},
    [68201720] = {},
}, { -- Perobas the Bloodthirster
    achievement=2257,
    criteria=8106,
    npc=32377,
    loot={44669},
})
ns.RegisterPoints(117, {
    [68604840] = {},
    [69405820] = {},
    [73403980] = {},
    [74004500] = {},
    [74005240] = {},
    [74406060] = {},
}, { -- Vigdis the War Maiden
    achievement=2257,
    criteria=8107,
    npc=32386,
    loot={44670},
})
ns.RegisterPoints(117, {
    [26006380] = {},
    [30807120] = {},
    [31205660] = {},
    [33208020] = {},
}, { -- King Ping
    achievement=2257,
    criteria=8108,
    npc=32398,
    loot={44668},
})

-- Dragonblight
ns.RegisterPoints(115, {
    [68805780] = {route={68805780,70005140,68004600,66803280,69602910,70903280,64103610,61304270,63105250,59806190,56505230,58304230,61304270}},
    [53505920] = {route={53505920,56505230,58304230,60303330,59502740}},
    [59502740] = {route=53505920},
}, { -- Tukemuth
    achievement=2257,
    criteria=8109,
    npc=32400,
    loot={44673},
})
ns.RegisterPoints(115, {
    [15604560] = {}, -- solo spawn point
    -- big chain of spawns it patrols along:
    [16405820] = {route={16405820,20605520,23605310,26705860,28406140,30805860,33205580}},
    [20605520] = {route=16405820},
    [23605310] = {route=16405820},
    [26705860] = {route=16405820},
    [28406140] = {route=16405820},
    [30805860] = {route=16405820},
    [33205580] = {route=16405820},
}, { -- Crazed Indu'le Survivor
    achievement=2257,
    npc=32409,
    loot={44672},
})
ns.RegisterPoints(115, {
    [69207480] = {},
    [72702590] = {},
    [85803660] = {},
}, { -- Scarlet Highlord Daion
    achievement=2257,
    criteria=8111,
    npc=32417,
    loot={44671},
})

-- Grizzly Hills
ns.RegisterPoints(116, {
    [10603920] = {route={10603920,12204440,12805000,12005560}},
    [12005560] = {route=10603920},
    [11207100] = {route={11207100,17207040,22407320}},
    [22405590] = {route=11207100},
    [28004180] = {},
}, { -- Grocklar
    achievement=2257,
    criteria=8112,
    npc=32422,
    loot={44675},
})
ns.RegisterPoints(116, {
    [28004540] = {},
    [34004920] = {},
    [39605060] = {},
}, { -- Seething Hate
    achievement=2257,
    criteria=8113,
    npc=32429,
    loot={44674},
})
ns.RegisterPoints(116, {
    [61503600] = {route=74204240},
    [67802680] = {route=74204240},
    [66404120] = {route=74204240},
    [74204240] = {routes={{74204240,71603500,67802680,65903130,65103510,66404120},{65103510,61503600}}},
}, { -- Syreian the Bonecarver
    achievement=2257,
    criteria=8114,
    npc=32438,
    loot={44676},
})
ns.RegisterPoints(116, {
    [31005580] = { -- Arcturis
        npc=38453,
        loot={51958},
    },
})

-- Zul'drak
ns.RegisterPoints(121, {
    [21208260] = {},
    [26208280] = {},
    [28807220] = {},
    [40405460] = {},
    [40406000] = {},
    [42607060] = {},
    [45806040] = {},
    [45807580] = {},
    [49808240] = {},
}, { -- Zul'drak Sentinel
    achievement=2257,
    criteria=8115,
    npc=32447,
    loot={44677},
})
ns.RegisterPoints(121, {
    [14405620] = {},
    [17407020] = {},
    [20807880] = {},
    [22406180] = {},
    [26205560] = {},
    [26607100] = {},
}, { -- Griegen
    achievement=2257,
    criteria=8116,
    npc=32471,
    loot={44686},
})
ns.RegisterPoints(121, {
    [53203140] = {},
    [61203640] = {},
    [71402320] = {},
    [71402900] = {},
    [74406640] = {},
    [77204220] = {},
    [81403440] = {},
}, { -- Terror Spinner
    achievement=2257,
    criteria=8117,
    npc=32475,
    loot={44685},
})
ns.RegisterPoints(121, {
    [61006160] = {},
    [63204340] = {},
    [67607740] = {},
    [69404800] = {},
    [77006940] = {},
}, { -- Gondria
    npc=33776,
    loot={46324},
})

-- Sholazar Basin
ns.RegisterPoints(119, {
    [40205900] = {},
    [41206840] = {},
    [42007380] = {},
    [42205180] = {},
    [52407240] = {},
    [54405180] = {},
    [56406520] = {},
}, { -- Aotona
    achievement=2257,
    criteria=8118,
    npc=32481,
    loot={44691},
})
ns.RegisterPoints(119, {
    [25804880] = {},
    [29204220] = {},
    [32603540] = {},
    [36202960] = {},
    [47004340] = {},
    [50808140] = {},
    [52204240] = {},
    [58808180] = {},
    [63808280] = {},
}, { -- King Krush
    achievement=2257,
    criteria=8119,
    npc=32485,
    loot={44683},
})
ns.RegisterPoints(119, {
    [20607000] = {},
    [30806640] = {},
    [35402960] = {},
    [50808120] = {},
    [58402140] = {},
    [66007900] = {},
    [70807120] = {},
}, { -- Loque'nahak
    achievement=2257,
    criteria=8100,
    npc=32517,
    loot={44687,44688},
})

-- Icecrown
ns.RegisterPoints(118, {
    [68406420] = {route={
        68406420, 67405820, 66205260, 65004740, 60804120,
        54004120, 49004280, 45205020, 44005820,
        r=0, g=1, b=0,
    }},
}, { -- Putridus the Ancient
    achievement=2257,
    criteria=8122,
    npc=32487,
    loot={44696},
})
ns.RegisterPoints(118, {
    [37702410] = {route={
        37702410, 32502860, 30803280, 29603800, 31904150, 28604540,
        r=1, g=1, b=1,
    }},
    [52605610] = {route={
        52605610, 54805220, 59405860, 59406220,
        r=1, g=1, b=1,
    }},
}, { -- Hildana Deathstealer
    achievement=2257,
    criteria=8102,
    npc=32495,
    loot={44697},
})
ns.RegisterPoints(118, {
    [31206220] = {},
    [33607060] = {},
    [47407820] = {},
    [48408500] = {},
    [67603860] = {},
    [72803500] = {},
}, { -- High Thane Jorfus
    achievement=2257,
    criteria=8101,
    npc=32501,
    loot={44695},
})

-- Storm Peaks
ns.RegisterPoints(120, {
    [37805840] = {},
    [41005180] = {},
    [41404020] = {},
    [68004760] = {},
}, { -- Dirkee
    achievement=2257,
    criteria=8121,
    npc=32500,
    loot={44681,44708},
})
ns.RegisterPoints(120, {
    [32406780] = {},
    [35607390] = {},
    [50407200] = {},
    [50003310] = {},
}, { -- Vyragosa
    achievement=2257,
    criteria=8120,
    npc=32630,
    loot={44732},
})
ns.RegisterPoints(120, {
    [27805040] = {},
    [30206460] = {},
    [46206440] = {},
}, { -- Skoll
    npc=35189,
    loot={49227},
})
ns.RegisterPoints(120, { -- Time-Lost Proto-Drake
    [31006940] = {route={
        31006940, 27906450, 26405840, 27805020, 37304120, 39804290, 40405870,
        loop=true,
        r=0,g=0.6,b=0,
    }},
    [35607660] = {route={
        35607660, 35706610, 29006580, 26607510, 31208030,
        loop=true,
        r=0,g=0,b=0.6,
    }},
    [51007000] = {route={
        51007000, 46206050, 41806080, 40106910, 36907250, 38008100, 46708130,
        loop=true,
        r=1,g=1,b=0,
    }},
    [52003400] = {route={
        52003400, 43803130, 32603690, 27703960, 28505050, 26805830,
        28706500, 34706500, 40005980, 47205520, 50304870, 46604040,
        loop=true,
        r=0.6,g=0,b=0,
    }},
}, {
    npc=32491,
    loot={{44168,mount=265}},
    atlas="VignetteKillElite", scale=1.3,
    note="Rare-spawn of {npc:32630}",
})

-- Higher Learning
-- Coords from: https://www.wowhead.com/achievement=1956/higher-learning#comments:id=1463964
-- /script WorldMapFrame:SetMapID(125)
ns.RegisterPoints(125, { -- Dalaran
    [56004500] = {criteria=7236, note="On ground by bookshelf",}, -- Introduction
    [52005500] = {criteria=7237, note="On ground by guild vendor",}, -- Abjuration
    [30004600] = {criteria=7238, note="Downstairs; bookshelf on the left",}, -- Conjuation
    [26005100] = {criteria=7239, note="On ground between bookshelves",}, -- Divination
    [43004700] = {criteria=7240, note="On balcony, by crates",}, -- Enchantment
    [64005200] = {criteria=7241, note="By crates in the corner",}, -- Illusion
    [46003900] = {criteria=7242, note="Upstairs; on empty bookshelf",}, -- Necromancy
    [47003900] = {criteria=7243, note="Downstairs; on empty bookshelf by stove",}, -- Transmutation
}, {
    achievement=1956, -- Higher Learning
    loot={{43824,toy=true}}, -- The Schools of Arcane Magic - Mastery
    note="Books spawn occasionally, and despawn shortly after someone reads them",
    texture=ns.atlas_texture("profession", {r=0.5, g=1, b=1}),
    minimap=true,
})