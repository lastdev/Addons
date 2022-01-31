local myname, ns = ...

ns.hiddenConfig = {
    default_icon = true,
    display = true,
    achievementsHidden = true,
    zonesHidden = true,
}

ns.RegisterPoints(1543, {
    [15915168] = {},
    [16015170] = { note="Behind the portal", },
    [16875504] = {},
    [16915500] = {},
    [17584995] = { note="grapple", },
    [17745294] = {},
    [18295453] = {},
    [18914631] = { note="On the platform", },
    [19096746] = { note="below crafting place", },
    [19153426] = {},
    [19236727] = {},
    [19243429] = {},
    [19353800] = {},
    [19403788] = {},
    [19633539] = {},
    [20623857] = { note="Up at grapple ", },
    [20653858] = {},
    [21326569] = {},
    [21656684] = { note="Upstairs, on the edge", },
    [21737190] = { note="top of stairs", },
    [22495479] = {},
    [22946816] = { note="grapple", },
    [22952220] = { note="On top of the rock with candles, use hook", },
    [23004450] = { note="mobs snap and interrupts channel", },
    [23004470] = { note="Top of the platform, use hook", },
    [23007168] = {},
    [23167000] = { note="grapple", },
    [23297380] = { note="On the bridge", },
    [23307387] = {},
    [23473457] = {},
    [23523465] = {},
    [23716550] = {},
    [24134281] = {},
    [24191661] = { note="Behind altar", },
    [24246534] = { note="grapple", },
    [24344688] = { note="outside", },
    [24526844] = {},
    [24603005] = { note="up on rocks", },
    [25236567] = {},
    [25633108] = { note="On top of Dekaris' stone, use hook", },
    [25796891] = {},
    [26153093] = { note="Top of outcrop", },
    [26346862] = { note="No idea how to get there, I used door of shadows", },
    [26352906] = { note="Up at grapple", },
    [26764483] = { note="By rock wall", },
    [26852750] = { note="at grapple and on a pillar", },
    [27362594] = { note="Up at grapple", },
    [27427225] = { note="On the ground", },
    [27916014] = {},
    [28006050] = { note="next to Dolos rare", },
    [28384546] = { note="Under the big stone", },
    [28384548] = {},
    [28694933] = { note="on top of rock", },
    [29311823] = {},
    [29321826] = { note="on wall", },
    [29646541] = {},
    [29676552] = { note="On the edge", },
    [30216580] = {},
    [30222837] = { note="edge of cliff", },
    [32396744] = {},
    [32586494] = { note="Inside building, you can grab it through the wall", },
    [33044229] = {},
    [33102066] = { note="On top of the rock, use hook", },
    [33156481] = { note="By the wall", },
    [33174245] = {},
    [33617490] = {},
    [33986205] = { note="inside room", },
    [34007037] = {},
    [34027035] = { note="grapple", },
    [35446747] = { note="Top of the wall, use hook", },
    [36254216] = { note="top of stairs", },
    [37544334] = { note="on a ledge behind stygian incinerator", },
    [37804500] = { note="At grapple", },
    [38701943] = { note="Under the stone, south side", },
    [40004900] = { note="on top of rock", },
    [40124908] = {},
    [41194945] = { note="On top of the cage, use hook", },
    [41314786] = { note="On top of the cage, use hook", },
    [43806884] = {},
    [44356704] = { note="inside pit of anguish upper level", },
    [45036659] = { note="grapple", },
    [46258128] = {},
    [47136246] = {},
    [47166240] = { note="On the ground", },
    [48148380] = {},
    [48397060] = { note="On top of the cage, use hook", },
    [50007460] = { note="Up at grapple", },
    [50037306] = { note="on cage use hook", },
    [51437820] = { note="grapple", },
    [51478384] = { note="inside cave. couldn't find this one but i saw it on the map", },
    [51567853] = {},
    [51867087] = {},
    [52038191] = { note="On the ground", },
    [52157841] = {},
    [52187614] = { note="On top of the cage, use hook", },
    [52957023] = {},
    [52976863] = { note="grapple", },
    [53157841] = { note="grapple", },
    [53266871] = {},
    [53288031] = { note="On the ground", },
    [53496632] = { note="pit of anguish", },
    [53917700] = { note="on cage use hook", },
    [53985866] = { note="mini cave", },
    [54207930] = { note="multiple points in cave (3 upper 2 lower)", },
    [54278488] = { note="Outside", },
    [54368484] = {},
    [54515845] = { note="Inside cave", },
    [54526717] = { note="use grappling hook", },
    [54618000] = { note="Inside hound cave (cave entrance)", },
    [55067753] = { note="Inside cave", },
    [55247788] = { note="Grapple", },
    [55467721] = { note="cave", },
    [56677092] = {},
    [56766011] = {},
    [57178508] = { note="Inside cave", },
    [57465194] = {},
    [58095186] = { note="On the ground", },
    [58917834] = {},
    [59007840] = {},
    [60866755] = {},
    [61076916] = {},
    [67045548] = { note="pit of anguish bottom level", },
}, {
    requires_item = 184870, -- Stygia Dowser
    inbag = 185474, -- Armored Husk
    atlas = "vehicle-templeofkotmogu-greenball",
    label = "Stygia Nexus",
    quest = 63684, -- Feral Shadehound quest
    group = "Stygia Nexus",
})

ns.RegisterPoints(1543, {
    [24007550] = {
        requires_item = 184870, -- Stygia Dowser
        inbag = 185056, -- Crumbling Stele
        loot = {185056}, -- Crumbling Stele
        label = "Rune puzzle",
        note = "Grapple up here, use your {item:184870}, then solve the puzzle by swapping runes to match the order they're found on the pillars around the platform. Once you have this you can buy the {item:185350} from {npc:162804:Ve'nari}",
        atlas = "reagents",
        quest = 63684, -- Feral Shadehound quest
        group = "Feral Shadehound",
    }
})

ns.RegisterPoints(1543, {
    [24601260] = { loot={185353}, }, -- Page: Binding
    [27906060] = { loot={185352}, }, -- Page: Souls
    [48808470] = { loot={185351}, }, -- Page: Forging
}, {
    requires_item = 185350, -- Partial Rune Codex
    inbag = 185632, -- Intact Rune Codex
    minimap = true,
    icon = true,
    quest = 63684, -- Feral Shadehound quest
    group = "Feral Shadehound",
})

ns.RegisterPoints(1543, {
    [35604180] = { -- Soulforger's Tools
        item = 185473,
        note = "Loot from {npc:166398:Soulforger Rhovus}, use to make {item:185474}",
        requires_item = 185632, -- Intact Rune Codex
    },
    [20206700] = { --Soulsteel Anvil
        npc = 177392,
        atlas = "repair",
        requires_item = 185473, -- Soulforger's Tools
    },
}, {
    minimap = true,
    inbag = {185474, 185471, 185475, any=true}, -- Armored Husk, Willing Wolf Soul, Feral Shadehound
    quest = 63684, -- Feral Shadehound quest
    group = "Feral Shadehound",
})

ns.RegisterPoints(1543, {
    [35302720] = {},
    [19105210] = {},
    [40002200] = {},
    [52801430] = {},
}, {
    npc = 177195, -- Stray Soul
    item = 185471, -- Willing Wolf Soul
    atlas = "poi-soulspiritghost",
    note = "Wanders the length of Gorgoa: the River of Souls, walking from south to north then despawning",
    requires_item = {185474}, -- Armored Husk
    inbag = {185471, 185475, any=true}, -- Willing Wolf Soul, Feral Shadehound
    quest = 63684, -- Feral Shadehound quest
    group = "Feral Shadehound",
})

ns.RegisterPoints(1543, {
    [45104830] = {
        label = "Binding Altar",
        note = "Bind the soul to the husk. Read your {item:185056} for the order to use the runes",
        atlas = "reagents",
        minimap = true,
        requires_item = 185471, -- Willing Wolf Soul
        inbag = 185475, -- Feral Shadehound
        quest = 63684, -- Feral Shadehound quest
        group = "Feral Shadehound",
    },
})
