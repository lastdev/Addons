local ADDON, NS = ...

NS.Data = NS.Data or {}
NS.Data.Drops = NS.Data.Drops or {}

NS.Data.Drops["Dragonflight"] = NS.Data.Drops["Dragonflight"] or {}

local MOBS = {
  [147261]={name="Erkhart Stormvein",worldmap=""},
  [147332]={name="Kyrakka",worldmap=""}}

NS.Data.Drops["Dragonflight"]["DragonIsles"] = {
    {decorID=11137,  source={ type="drop", zone="DragonIsles", itemID=256354, npcID=189901, npc="Warlord Sargha", worldmap="2081:5000:5000" }},
    {decorID=14330,  source={ type="drop", zone="DragonIsles", itemID=260359, npcID=190609, npc="Echo of Doragosa", worldmap="2099:5000:5000" }},
	{decorID=11163,  source={ type="drop", zone="DragonIsles", itemID=256428,mobs=MOBS}}
}