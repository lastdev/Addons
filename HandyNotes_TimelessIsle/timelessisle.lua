-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

local ADDON_NAME, ns = ...
local L = ns.locale
local isinstance = ns.isinstance

local Node = ns.node.Node
local Cave = ns.node.Cave
local NPC = ns.node.NPC
local PetBattle = ns.node.PetBattle
local Rare = ns.node.Rare
local Supply = ns.node.Supply
local Treasure = ns.node.Treasure

local Achievement = ns.reward.Achievement
local Item = ns.reward.Item
local Mount = ns.reward.Mount
local Pet = ns.reward.Pet
local Toy = ns.reward.Toy
local Transmog = ns.reward.Transmog

local MAPID = 554
local MAPID_LOSTSPIRITS = 555

local nodes = {}
local nodes_lostspirits = {}
local options = ns.options.args.VisibilityGroup.args
local defaults = ns.optionDefaults.profile

-------------------------------------------------------------------------------
----------------------------------- OPTIONS -----------------------------------
-------------------------------------------------------------------------------

defaults['treasure_timeless'] = true;
defaults['rare_timeless'] = true;
defaults['pet_timeless'] = true;

options.groupTimeless = {
    type = "header",
    name = L["timelessisle"],
    order = 10,
};

options.treasureTimeless = {
    type = "toggle",
    arg = "treasure_timeless",
    name = L["options_toggle_treasures"],
    desc = L["options_toggle_treasures_desc"],
    order = 11,
    width = "normal",
};

options.rareTimeless = {
    type = "toggle",
    arg = "rare_timeless",
    name = L["options_toggle_rares"],
    desc = L["options_toggle_rares_desc"],
    order = 13,
    width = "normal",
};

--[[
options.petTimeless = {
    type = "toggle",
    arg = "pet_timeless",
    name = L["options_toggle_battle_pets"],
    desc = L["options_toggle_battle_pets_desc"],
    order = 14,
    width = "normal",
};
]]

options.caveTimeless = {
    type = "toggle",
    arg = "cave_timeless",
    name = L["options_toggle_caves"],
    desc = L["options_toggle_caves_desc"],
    order = 17,
    width = "normal",
};

ns.included[MAPID] = function (node, profile)
    if isinstance(node, Treasure) then return profile.treasure_timeless end
    if isinstance(node, Rare) then return profile.rare_timeless end
    if isinstance(node, Cave) then return profile.cave_timeless end
    -- if isinstance(node, PetBattle) then return profile.pet_timeless end
    return false
end
ns.included[MAPID_LOSTSPIRITS] = ns.included[MAPID];


-- One time chests
nodes[36703410] = Treasure({quest=33170, label="Moss-Covered Chest"});
nodes[25502720] = Treasure({quest=33171, label="Moss-Covered Chest"});
nodes[27403910] = Treasure({quest=33172, label="Moss-Covered Chest"});
nodes[30703650] = Treasure({quest=33173, label="Moss-Covered Chest"});
nodes[22403540] = Treasure({quest=33174, label="Moss-Covered Chest"});
nodes[22104930] = Treasure({quest=33175, label="Moss-Covered Chest"});
nodes[24805300] = Treasure({quest=33176, label="Moss-Covered Chest"});
nodes[25704580] = Treasure({quest=33177, label="Moss-Covered Chest"});
nodes[22306810] = Treasure({quest=33178, label="Moss-Covered Chest"});
nodes[26806870] = Treasure({quest=33179, label="Moss-Covered Chest"});
nodes[31007630] = Treasure({quest=33180, label="Moss-Covered Chest"});
nodes[35307640] = Treasure({quest=33181, label="Moss-Covered Chest"});
nodes[38707160] = Treasure({quest=33182, label="Moss-Covered Chest"});
nodes[39807950] = Treasure({quest=33183, label="Moss-Covered Chest"});
nodes[34808420] = Treasure({quest=33184, label="Moss-Covered Chest"});
nodes[43608410] = Treasure({quest=33185, label="Moss-Covered Chest"});
nodes[47005370] = Treasure({quest=33186, label="Moss-Covered Chest"});
nodes[46704670] = Treasure({quest=33187, label="Moss-Covered Chest"});
nodes[51204570] = Treasure({quest=33188, label="Moss-Covered Chest"});
nodes[55504430] = Treasure({quest=33189, label="Moss-Covered Chest"});
nodes[58005070] = Treasure({quest=33190, label="Moss-Covered Chest"});
nodes[65704780] = Treasure({quest=33191, label="Moss-Covered Chest"});
nodes[63805920] = Treasure({quest=33192, label="Moss-Covered Chest"});
nodes[64907560] = Treasure({quest=33193, label="Moss-Covered Chest"});
nodes[60206600] = Treasure({quest=33194, label="Moss-Covered Chest"});
nodes[49706570] = Treasure({quest=33195, label="Moss-Covered Chest"});
nodes[53107080] = Treasure({quest=33196, label="Moss-Covered Chest"});
nodes[52706270] = Treasure({quest=33197, label="Moss-Covered Chest"});
nodes[61708850] = Treasure({quest=33227, label="Moss-Covered Chest"});
nodes[44206530] = Treasure({quest=33198, label="Moss-Covered Chest"});
nodes[26006140] = Treasure({quest=33199, label="Moss-Covered Chest"});
nodes[24603850] = Treasure({quest=33200, label="Moss-Covered Chest"});
nodes[29703180] = Treasure({quest=33202, label="Moss-Covered Chest"});
nodes[28203520] = Treasure({quest=33204, label="Sturdy Chest", note="Hit an Highwind Albatross to get carried here" });
nodes[26806490] = Treasure({quest=33205, label="Sturdy Chest", note="Hit an Highwind Albatross to get carried here" });
nodes[64607040] = Treasure({quest=33206, label="Sturdy Chest"});
nodes[59204950] = Treasure({quest=33207, label="Sturdy Chest", note="Located inside the Hammer Cavern" });
nodes[69503290] = Treasure({quest=33208, label="Smoldering Chest"});
nodes[54007820] = Treasure({quest=33209, label="Smoldering Chest"});
nodes[47602760] = Treasure({quest=33210, label="Blazing Chest"});
nodes[59903130] = Treasure({quest=33201, label="Moss-Covered Chest"});

nodes_lostspirits[62903480] = Treasure({quest=33203, label="Skull-Covered Chest"});
nodes[42003800] = Treasure({quest=33203, label="Skull-Covered Chest", note="Located inside the cave below."});

-- Weekly chests
nodes[49706940] = Treasure({quest=32969, icon="star_chest", label="Gleaming Treasure Chest", rewards={
    Achievement({id=8726, criteria=24018})  -- Extreme Treasure Hunter
}});
nodes[51607460] = Cave({parent=nodes[49706940], label="Gleaming Treasure Chest", note="Pillar Jumping starts here"});

nodes[53904720] = Treasure({quest=32968, icon="star_chest", label="Rope-Bound Treasure Chest", rewards={
    Achievement({id=8726, criteria=24019})  -- Extreme Treasure Hunter
}});
nodes[60204590] = Cave({parent=nodes[53904720], label="Rope-Bound Treasure Chest", note="Rope Walking starts here"});

nodes[58506010] = Treasure({quest=32971, icon="star_chest", label="Mist-Covered Treasure Chest", note="Feather Falling: click on Gleaming Crane Statue.\n\nRequires Gleaming Treasure Chest and Rope-Bound Treasure Chest to be looted first.", rewards={
    Achievement({id=8726, criteria=24020})  -- Extreme Treasure Hunter
}});

nodes[40409300] = Treasure({quest=32957, icon="star_chest", label="Sunken Treasure", note="Kill nearby elites for the key", rewards={
    Achievement({id=8727, criteria=24021}),  -- Where There's Pirates, There's Booty
    Achievement({id=8728, criteria=24024}),  -- Cursed Swabby Helmet
    Toy({item=134024}),  -- Cursed Swabby Helmet
}});

nodes[22705890] = Treasure({quest=32956, icon="star_chest", label="Blackguard's Jetsam", rewards={
    Achievement({id=8727, criteria=24022})  -- Where There's Pirates, There's Booty
}});
nodes[16905710] = Cave({parent=nodes[22705890], label="Cave entrance to Blackguard's Jetsam"});

nodes[70608090] = Treasure({quest=32970, icon="star_chest", label="Gleaming Treasure Satchel", note="Walk on the ropes of the ship then jump on the pole where the satchel is hanging from.", rewards={
    Achievement({id=8727, criteria=24023})  -- Where There's Pirates, There's Booty
}});


-- Rares
nodes[37004300] = Rare({id=73158, label="Emerald Gander", note="All around the Celestial Court. Kill Brilliant Windfeather mobs until it spawns.", rewards={
    Achievement({id=8714, criteria=23967}),  -- Kill
}});
nodes[24805500] = Rare({id=73161, label="Great Turtle Furyshell", note="All around the west side of the island. Kill Great Turtle mobs until it spawns.", rewards={
    Achievement({id=8714, criteria=23969}),  -- Kill
    Achievement({id=8728, criteria=24072}),  -- Hardened Shell
}});
nodes[38007500] = Rare({id=72909, label="Gu'chi the Swarmbringer", rewards={
    Achievement({id=8714, criteria=23970}),  -- Kill
    Achievement({id=8728, criteria={24047, 24046}}),  -- Swarmling of Gu'chi, Sticky Silkworm Goo
    Pet({id=1345, item=104291}),  -- Swarmling of Gu'chi
}});
nodes[47008700] = Rare({id=72245, label="Zesqua", rewards={
    Achievement({id=8714, criteria=23971}),  -- Kill
    Achievement({id=8728, criteria=24056}),  -- Rain Stone
}});
nodes[37557731] = Rare({id=71919, label="Zhu-Gon Sour", rewards={
    Achievement({id=8714, criteria=23972}),  -- Kill
    Achievement({id=8728, criteria=24032}),  -- Skunky Alemental
}});
nodes[34088384] = Rare({id=72193, label="Karkanos", rewards={
    Achievement({id=8714, criteria=23973}),  -- Kill
    Achievement({id=8728, criteria=24079}),  -- Giant Purse of Timeless Coins
}});
nodes[25063598] = Rare({id=72045, label="Chelon", rewards={
    Achievement({id=8714, criteria=23974}),  -- Kill
}});
nodes[59004880] = Rare({id=71864, label="Spelurk", rewards={
    Achievement({id=8714, criteria=23975}),  -- Kill
    Achievement({id=8728, criteria=24064}),  -- Cursed Talisman
}});
nodes[43896989] = Rare({id=72049, label="Cranegnasher", rewards={
    Achievement({id=8714, criteria=23976}),  -- Kill
    Achievement({id=8728, criteria=24041}),  -- Pristine Stalker Hide
}});
nodes[61008860] = Rare({id=72048, label="Rattleskew", rewards={
    Achievement({id=8714, criteria=23977}),  -- Kill
    Achievement({id=8728, criteria=24065}),  -- Captain Zvezdan's Lost Leg
}});
nodes[50008700] = Rare({id=73166, label="Monstrous Spineclaw", note="All around the island. Kill Ancient Spineclaw mobs until it spawns.", rewards={
    Achievement({id=8714, criteria=23985}),  -- Kill
    Achievement({id=8728, criteria=24033}),  -- Spineclaw Crab
    Pet({id=1337, item=104168}),  -- Spineclaw Crab
}});
nodes_lostspirits[48006100] = Rare({id=72769, label="Spirit of Jadefire", rewards={
    Achievement({id=8714, criteria=23978}),  -- Kill
    Achievement({id=8728, criteria={24060, 24037}}),  -- Jadefire Spirit, Glowing Green Ash
    Pet({id=1348, item=104307}),  -- Jadefire Spirit
}});
nodes[44003800] = Rare({id=72769, label="Spirit of Jadefire", note="Located inside the cave below.", rewards={
    Achievement({id=8714, criteria=23978}),  -- Kill
    Achievement({id=8728, criteria={24060, 24037}}),  -- Jadefire Spirit, Glowing Green Ash
    Pet({id=1348, item=104307}),  -- Jadefire Spirit
}});
nodes[67004300] = Rare({id=73277, label="Leafmender", rewards={
    Achievement({id=8714, criteria=23979}),  -- Kill
    Achievement({id=8728, criteria=24025}),  -- Ashleaf Spriteling
    Pet({id=1323, item=104156}),  -- Ashleaf Spriteling
}});
nodes[66577009] = Rare({id=72775, label="Bufo", rewards={
    Achievement({id=8714, criteria=23986}),  -- Kill
    Achievement({id=8728, criteria=24034}),  -- Gulp Froglet
    Pet({id=1338, item=104169}),  -- Gulp Froglet
}});
nodes[64002700] = Rare({id=73282, label="Garnia", rewards={
    Achievement({id=8714, criteria=23982}),  -- Kill
    Achievement({id=8728, criteria=24027}),  -- Ruby Droplet
    Pet({id=1328, item=104159}),  -- Ruby Droplet
}});
nodes[54094240] = Rare({id=72808, label="Tsavo'ka", rewards={
    Achievement({id=8714, criteria=23983}),  -- Kill
    Achievement({id=8728, criteria=24041}),  -- Pristine Stalker Hide
}});
nodes[71588185] = Rare({id=73704, label="Stinkbraid", rewards={
    Achievement({id=8714, criteria=24144}),  -- Kill
}});
nodes_lostspirits[42923211] = Rare({id=73157, label="Rock Moss", rewards={
    Achievement({id=8714, criteria=23980}),  -- Kill
    Achievement({id=8728, criteria=24063}),  -- Golden Moss
}});
nodes[46003800] = Rare({id=73157, label="Rock Moss", note="Located inside the cave below.", rewards={
    Achievement({id=8714, criteria=23980}),  -- Kill
    Achievement({id=8728, criteria=24063}),  -- Golden Moss
}});
nodes[57007200] = Rare({id=73170, label="Watcher Osu", rewards={
    Achievement({id=8714, criteria=23992}),  -- Kill
    Achievement({id=8728, criteria=24058}),  -- Ashen Stone
}});
nodes[52008100] = Rare({id=73169, label="Jakur of Ordon", rewards={
    Achievement({id=8714, criteria=23994}),  -- Kill
    Achievement({id=8728, criteria=24068}),  -- Warning Sign
    Toy({item=104331}),  -- Warning Sign
}});
nodes[62524383] = Rare({id=73171, label="Champion of the Black Flame", rewards={
    Achievement({id=8714, criteria=23996}),  -- Kill
    Achievement({id=8728, criteria={24079, 24055}}),  -- Big Bag of Herbs, Blackflame Daggers
    Toy({item=104302}),  -- Blackflame Daggers
}});
nodes[52954988] = Rare({id=73175, label="Cinderfall", rewards={
    Achievement({id=8714, criteria=23981}),  -- Kill
    Achievement({id=8728, criteria={24054, 24038}}),  -- Falling Flame, Glowing Blue Ash
}});
nodes[43002500] = Rare({id=73173, label="Urdur the Cauterizer", rewards={
    Achievement({id=8714, criteria=23993}),  -- Kill
    Achievement({id=8728, criteria=24059}),  -- Sunset Stone
}});
nodes[44003400] = Rare({id=73172, label="Flintlord Gairan", rewards={
    Achievement({id=8714, criteria=23995}),  -- Kill
    Achievement({id=8728, criteria=24053}),  -- Ordon Death Chime
}});
nodes[65875660] = Rare({id=73167, label="Huolon", rewards={
    Achievement({id=8714, criteria=23984}),  -- Kill
    Achievement({id=8728, criteria=24081}),  -- Reins of the Thundering Onyx Cloud Serpent
    Mount({id=561, item=104269}),  -- Thundering Onyx Cloud Serpent
}});
nodes[62506350] = Rare({id=72970, label="Golganarr", rewards={
    Achievement({id=8714, criteria=23988}),  -- Kill
    Achievement({id=8728, criteria={24040, 24039}}),  -- Glinting Pile of Stone, Odd Polished Stone
    Toy({item=104262}),  -- Odd Polished Stone
}});
nodes[19005800] = Rare({id=73279, label="Evermaw", rewards={
    Achievement({id=8714, criteria=23990}),  -- Kill
}});
nodes[28802450] = Rare({id=73281, label="Dread Ship Vazuvius", rewards={
    Achievement({id=8714, criteria=23987}),  -- Kill
    Achievement({id=8728, criteria=24050}),  -- Rime of the Time-Lost Mariner
    Toy({item=104294}),  -- Rime of the Time-Lost Mariner
}});

nodes[34403250] = Rare({id=73666, label="Archiereus of Flame", rewards={
    -- Criterion ID is bugged and returns 0
}});

nodes[31004300] = Rare({id=73163, label="Imperial Python", note="All around the Celestial Court. Kill Death Adder mobs until it spawns.", rewards={
    Achievement({id=8714, criteria=23989}),  -- Kill
    Achievement({id=8728, criteria=24029}),  -- Death Adder Hatchling
    Pet({id=1330, item=104161}),  -- Death Adder Hatchling TODO: figure out id
}});

nodes[34004300] = Rare({id=73160, label="Ironfur Steelhorn", note="All around the Celestial Court. Kill Ironfur Great Bull mobs until it spawns.", rewards={
    Achievement({id=8714, criteria=23968}),  -- Kill
}});


--[[
nodes[41003800] = nodes_lostspirits[62903480];
-- Lost spirits
local count = 0
for i, v in ipairs(nodes_lostspirits) do
    -- nodes[41003800 + 2 * 1000000 * count] = v;
    -- local backnode = CopyTable(v)
    -- backnode["note"] = "Located inside the cave below"
    -- nodes[41003800 + 2 * 1000000 * count] = type(v)(backnode);
    count = count + 1
end
]]

nodes[43904066] = Cave({parent={nodes[42003800], nodes[44003800], nodes[46003800]}, label="Cavern of Lost Spirits"});


ns.nodes[MAPID] = nodes
ns.nodes[MAPID_LOSTSPIRITS] = nodes_lostspirits
