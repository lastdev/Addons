-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

local _, ns = ...
local L = ns.locale
local Class = ns.Class
local Map = ns.Map
local isinstance = ns.isinstance

local Node = ns.node.Node
local PetBattle = ns.node.PetBattle
local Quest = ns.node.Quest
local Rare = ns.node.Rare
local Treasure = ns.node.Treasure

local Achievement = ns.reward.Achievement
local Item = ns.reward.Item
local Mount = ns.reward.Mount
local Pet = ns.reward.Pet
local Toy = ns.reward.Toy
local Transmog = ns.reward.Transmog

local options = ns.options.args.VisibilityGroup.args
local defaults = ns.optionDefaults.profile

-------------------------------------------------------------------------------
------------------------------------- MAP -------------------------------------
-------------------------------------------------------------------------------

local map = Map({ id=118 })
local nodes = map.nodes

function map:enabled (node, coord, minimap)
    if not Map.enabled(self, node, coord, minimap) then return false end
	
	if not (C_QuestLog.IsQuestFlaggedCompleted(60767) or C_QuestLog.IsQuestFlaggedCompleted(60761)) then return false end

    local profile = ns.addon.db.profile
    if isinstance(node, Treasure) then
        if node.quest then return profile.chest_mech end
        return profile.locked_mech
    end
    if isinstance(node, Rare) then return profile.rare_icec end

    return false;
end


-------------------------------------------------------------------------------
----------------------------------- OPTIONS -----------------------------------
-------------------------------------------------------------------------------

defaults['rare_icec'] = true;

options.groupMechagon = {
    type = "header",
    name = L["Icecrown"],
    order = 0,
};


options.rareMechagon = {
    type = "toggle",
    arg = "rare_icec",
    name = L["options_toggle_rares"],
    desc = L["options_toggle_rares_desc"],
    order = 3,
    width = "normal",
};


-------------------------------------------------------------------------------
------------------------------------ RARES ------------------------------------
-------------------------------------------------------------------------------

nodes[31607050] = Rare({id=174067, quest=62345, note=L["id174067"], rewards={
    Transmog({item=183642, slot=L["cloth"]}),
    Transmog({item=183654, slot=L["plate"]}),
	Item({item=183676, quest=nil}),
}}); --药剂师诺斯

nodes[36506740] = Rare({id=174066, quest=62344, note=L["id174066"], rewards={
    Transmog({item=183643, slot=L["2h_axe"]}),
    Transmog({item=183645, slot=L["leather"]}),
    Transmog({item=183644, slot=L["mail"]}),
}}); --帕奇维克

nodes[49703270] = Rare({id=174065, quest=62343, note=L["id174065"], rewards={
    Transmog({item=183647, slot=L["polearm"]}),
    Transmog({item=183646, slot=L["mail"]}),
    Transmog({item=183648, slot=L["plate"]}),
}}); --鲜血女王兰娜瑟尔

nodes[57103030] = Rare({id=174064, quest=62342, note=L["id174064"], rewards={
    Transmog({item=183649, slot=L["leather"]}),
    Transmog({item=183651, slot=L["plate"]}),
	Item({item=183650, quest=nil}),
}}); --普崔塞德教授

nodes[51107850] = Rare({id=174063, quest=62341, note=L["id174063"], rewards={
    Transmog({item=183652, slot=L["bow"]}),
    Transmog({item=183641, slot=L["cloth"]}),
    Transmog({item=183653, slot=L["leather"]}),
    Transmog({item=183655, slot=L["mail"]}),
}}); --亡语者女士

nodes[57805610] = Rare({id=174062, quest=62340, note=L["id174062"], rewards={
    Transmog({item=183656, slot=L["leather"]}),
    Transmog({item=183657, slot=L["mail"]}),
    Transmog({item=183670, slot=L["plate"]}),
    Item({item=44151, quest=nil}),
}}); --残忍的斯卡迪

nodes[52305260] = Rare({id=174061, quest=62339, note=L["id174061"], rewards={
    Transmog({item=183658, slot=L["2h_axe"]}),
    Transmog({item=183668, slot=L["leather"]}),
    Item({item=183659, quest=nil}),
}}); --掠夺者因格瓦尔

nodes[54004470] = Rare({id=174060, quest=62338, note=L["id174060"], rewards={
    Transmog({item=183678, slot=L["fist"]}),
    --Transmog({item=183679, slot=L["leather"]}),
	--Transmog({item=183677, slot=L["mail"]}),
	Transmog({item=183661, slot=L["mail"]}),
    Transmog({item=183680, slot=L["cloak"]}),
    Item({item=183625, quest=nil}),
}}); --凯雷塞斯王子

nodes[64802210] = Rare({id=174059, quest=62337, note=L["id174059"], rewards={
    Transmog({item=183638, slot=L["dagger"]}),
    Transmog({item=183637, slot=L["leather"]}),
    Transmog({item=183636, slot=L["plate"]}),
}}); --黑骑士

nodes[70603850] = Rare({id=174058, quest=62336, note=L["id174058"], rewards={
    Transmog({item=183675, slot=L["cloth"]}),
    --Transmog({item=183668, slot=L["leather"]}),
    Transmog({item=183639, slot=L["mail"]}),
    Transmog({item=183635, slot=L["plate"]}),
    Item({item=183634, quest=nil}),
}}); --布隆亚姆<千魂之父>

nodes[47136593] = Rare({id=174057, quest=62335, note=L["id174057"], rewards={
    Transmog({item=183674, slot=L["cloth"]}),
    Transmog({item=183633, slot=L["leather"]}),
    Transmog({item=183632, slot=L["shield"]}),
}}); --天灾领主泰兰努斯

nodes[59107240] = Rare({id=174056, quest=62334, note=L["id174056"], rewards={
    Transmog({item=183630, slot=L["2h_axe"]}),
    Transmog({item=183666, slot=L["plate"]}),
    Item({item=183631, quest=nil}),
}}); --熔炉之主加弗斯特

nodes[58208350] = Rare({id=174055, quest=62333, note=L["id174055"], rewards={
    Transmog({item=183687, slot=L["cloth"]}),
    Transmog({item=183663, slot=L["cloth"]}),
    Transmog({item=183662, slot=L["mail"]}),
}}); --玛维恩

nodes[50208810] = Rare({id=174054, quest=62332, note=L["id174054"], rewards={
    Transmog({item=183667, slot=L["1h_sword"]}),
    Transmog({item=183664, slot=L["cloth"]}),
    Transmog({item=183665, slot=L["plate"]}),
    Transmog({item=183666, slot=L["plate"]}),
}}); --法瑞克 quest=

nodes[80106120] = Rare({id=174053, quest=62331, note=L["id174053"], rewards={
    Transmog({item=183686, slot=L["leather"]}),
    Transmog({item=183684, slot=L["shield"]}),
    Item({item=183685, quest=nil}),
}}); --先知萨隆亚

nodes[77806610] = Rare({id=174052, quest=62330, note=L["id174052"], rewards={
    Transmog({item=183627, slot=L["1h_mace"]}),
    Transmog({item=183671, slot=L["mail"]}),
    Transmog({item=183672, slot=L["plate"]}),
}}); --召唤者诺沃斯

nodes[58303940] = Rare({id=174051, quest=62329, note=L["id174051"], rewards={
    Transmog({item=183626, slot=L["2h_sword"]}),
    Transmog({item=183669, slot=L["cloth"]}),
    Transmog({item=183640, slot=L["mail"]}),
}}); --托尔戈 quest=62329

nodes[67505800] = Rare({id=174050, quest=62328, note=L["id174050"], rewards={
    Transmog({item=183681, slot=L["dagger"]}),
    Transmog({item=183682, slot=L["cloth"]}),
    Transmog({item=183683, slot=L["leather"]}),
}}); --看门者克里克希尔 quest=62328

nodes[29606220] = Rare({id=174049, quest=62327, note=L["id174049"], rewards={
    --Transmog({item=183678, slot=L["fist"]}),
    Transmog({item=183679, slot=L["leather"]}),
	Transmog({item=183677, slot=L["mail"]}),
	--Transmog({item=183661, slot=L["mail"]}),
    --Transmog({item=183680, slot=L["cloak"]}),
    Item({item=183625, quest=nil}),
}}); --塔达拉姆王子

nodes[44204910] = Rare({id=174048, quest=62326, note=L["id174048"], rewards={
    Transmog({item=183624, slot=L["dagger"]}),
    Transmog({item=183641, slot=L["cloth"]}),
    Item({item=183673, quest=nil}),
}}); --纳多克斯长老

nodes[18001800] = Rare({id=17293, quest=62325, note=L["plaguewave"], rewards={
    --Transmog({item=183652, slot=L["bow"]}),
    --Transmog({item=183682, slot=L["cloth"]}),
    --Transmog({item=183683, slot=L["leather"]}),
    --Transmog({item=183640, slot=L["mail"]}),
    --Transmog({item=183654, slot=L["plate"]}),
    Item({item=183200, quest=nil}),
    Item({item=183616, quest=nil}),
}, isNeverDone=1}); --天灾波

-------------------------------------------------------------------------------
-------------------------------- MISCELLANEOUS --------------------------------
-------------------------------------------------------------------------------


ns.maps[map.id] = map
