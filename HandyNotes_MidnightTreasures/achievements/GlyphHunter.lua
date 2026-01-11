local myname, ns = ...

-- 61584

-- Skyriding Glyphs
local GLYPH = ns.nodeMaker{
    atlas="Warfront-AllianceHero-Silver",
    scale=1.4,
    minimap=true,
    requires=ns.DRAGONRIDING,
    group="glyphs",
    -- loot={{257145, mount=2756}}, -- Crimson Dragonhawk
    note="Collect all the glyphs for the {item:257145:Crimson Dragonhawk}",
}

ns.RegisterPoints(ns.EVERSONGWOODS, {
	[65243269] = {criteria=110336,}, -- Brightwing Estate, Eversong Woods
	[58931954] = {criteria=110337, translate={[ns.SILVERMOONCITY]=true}}, -- Silvermoon City, Eversong Woods
	[39975963] = {criteria=110338,}, -- Goldenmist Village, Eversong Woods
	[49474803] = {criteria=110339,}, -- Path of Dawn, Eversong Woods
	[39464560] = {criteria=110340,}, -- Sunsail Anchorage, Eversong Woods
	[62616277] = {criteria=110341,}, -- Danwstar Spire, Eversong Woods
	[52466755] = {criteria=110342,}, -- Tranquillien, Eversong Woods
	[33416524] = {criteria=110343,}, -- Daggerspine Point, Eversong Woods
	[58435833] = {criteria=110344, note="In the branches"}, -- Suncrown Tree, Eversong Woods
	[43214637] = {criteria=110345, note="In the branches"}, -- Fairbreeze Village, Eversong Woods
}, GLYPH{achievement=61576})
ns.RegisterPoints(ns.SILVERMOONCITY, {
	[48350655] = {criteria=110335,}, -- The Shining Span, Eversong Woods
}, GLYPH{achievement=61576, parent=true})

ns.RegisterPoints(ns.ZULAMAN, {
	[19267057] = {criteria=110353,}, -- Revantusk Sedge, Zul'aman
	[42913436] = {criteria=110355,}, -- Shadebasin Watch, Zul'aman
	[53628040] = {criteria=110354,}, -- Temple of Akil'zon, Zul'aman
	[51462362] = {criteria=110356,}, -- Temple of Jan'alai, Zul'aman
	[53195447] = {criteria=110357,}, -- Strait of Hexx'alor, Zul'aman
	[39111975] = {criteria=110358, note="In the chasm"}, -- Witherbark Bluffs, Zul'aman
	[30418473] = {criteria=110359, note="At the top of the waterfall"}, -- Nalorakk's Prowl, Zul'aman
	[27952858] = {criteria=110360,}, -- Zeb'Alar Lumberyard, Zul'aman
	[24835486] = {criteria=110361, translate={[ns.ATALAMAN]=true}}, -- Amani Pass, Zul'aman
	[46668226] = {criteria=110362,}, -- Solemn Valley, Zul'aman
	[42798015] = {criteria=110363,}, -- Spiritpaw Burrow, Zul'aman
}, GLYPH{achievement=61581})

ns.RegisterPoints(ns.HARANDAR, {
	[60184439] = {criteria=110364,}, -- Blossoming Terrace, Harandar
	[46675330] = {criteria=110365,}, -- The Cradle, Harandar
	[34542333] = {criteria=112628,}, -- Roots of Teldrassil, Harandar
	[69184612] = {criteria=110367,}, -- Roots of Amirdrassil, Harandar
	[54653555] = {criteria=110368,}, -- Blooming Lattice, Harandar
	[73082591] = {criteria=110369,}, -- Roots of Nordrassil, Harandar
	[44556281] = {criteria=110370,}, -- Fungara Village, Harandar
	[26546139] = {criteria=110366,}, -- Roots of Shaladrassil, Harandar
	[61876751] = {criteria=110371,}, -- Rift of Aln, Harandar
}, GLYPH{achievement=61582})

ns.RegisterPoints(ns.VOIDSTORM, {
	[51346272] = {criteria=110372,}, -- The Voidspire, Voidstorm
	[37184998] = {criteria=110373, note="Under the bridge"}, -- The Molt, Voidstorm
	[35676110] = {criteria=110374,}, -- The Ingress, Voidstorm
	[39917098] = {criteria=110375,}, -- The Bladeburrows, Voidstorm
	[55124556] = {criteria=110376,}, -- Gnawing Reach, Voidstorm
	[36084456] = {criteria=110377,}, -- Hanaar Outpost, Voidstorm
	[38907613] = {criteria=110378,}, -- Ethereum Refinery, Voidstorm
	[45285225] = {criteria=110379,}, -- Master's Perch, Voidstorm
	[64977190] = {criteria=110380,}, -- Obscurion Citadel, Voidstorm
	[36083725] = {criteria=110381,}, -- Shadowguard Point, Voidstorm
	[49268752] = {criteria=110382,}, -- The Gorging Pit, Voidstorm
}, GLYPH{achievement=61583})
