local ADDON, NS = ...

NS.Data=NS.Data or{};NS.Data.Drops=NS.Data.Drops or{};NS.Data.Drops["Classic"]=NS.Data.Drops["Classic"] or{}

local MOBSETS={
Darkshore_Rares={
[147261]={name="Granokk",worldmap="62:4820:5560"},
[147332]={name="Stonebinder Ssra'vess",worldmap="62:4540:5880"},
[147751]={name="Shattershard",worldmap="62:4340:2920"},
[147966]={name="Aman",worldmap="62:3740:8420"},
[147970]={name="Mrggr'marr",worldmap="62:3540:8140"},
[149654]={name="Glimmerspine",worldmap="62:4340:1980"},
[149657]={name="Madfeather",worldmap="62:4400:4840"},
[149665]={name="Scalefiend",worldmap="62:4740:4460"}}}

NS.Data.Drops["Classic"]["Kalimdor"]={
	{decorID=840, source={type="drop",zone="Darkshore",itemID=245462,mobSet="Darkshore_Rares",_mobSets=MOBSETS}},
	{decorID=2000, source={type="drop",zone="Darkshore",itemID=246110,mobSet="Darkshore_Rares",_mobSets=MOBSETS}},
	{decorID=1836, source={type="drop",zone="Darkshore",itemID=245627,mobSet="Darkshore_Rares",_mobSets=MOBSETS}},
	{decorID=948, source={type="drop",zone="Darkshore",itemID=241066,mobSet="Darkshore_Rares",_mobSets=MOBSETS}}
}
