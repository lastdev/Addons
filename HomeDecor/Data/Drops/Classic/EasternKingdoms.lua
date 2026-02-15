local ADDON, NS = ...

NS.Data=NS.Data or{};NS.Data.Drops=NS.Data.Drops or{};NS.Data.Drops["Classic"]=NS.Data.Drops["Classic"] or{}

local MOBSETS={
Stormwind_Footlocker={
[47739]={name="\"Captain\" Cookie",worldmap="52:4244:7190"},
[49541]={name="Vanessa VanCleef",worldmap="52:4244:7190"}}}

NS.Data.Drops["Classic"]["EasternKingdoms"]={
	{decorID=2246, source={type="drop",zone="EasternKingdoms",itemID=246429,npcID=9019,npc="Emperor Dagran Thaurissan",worldmap="35:3882:1866"}},
	{decorID=1324, source={type="drop",zone="EasternKingdoms",itemID=245435,npcID=77120,npc="Warlord Zaela",worldmap="33:7878:3333"}},
	{decorID=4401, source={type="drop",zone="EasternKingdoms",itemID=248332,mobSet="Stormwind_Footlocker",_mobSets=MOBSETS}},
	{decorID=2531, source={type="drop",zone="EasternKingdoms",itemID=246865,npcID=114790,npc="Viz'aduum the Watcher",worldmap="42:4691:6955"}},
	{decorID=1445, source={type="drop",zone="EasternKingdoms",itemID=244655,npcID=46964,npc="Lord Godfrey",worldmap="21:4456:6728"}}
}
