local myname, ns = ...

ns.QUELTHALAS = 2537
ns.ISLEOFQUELDANAS = 2424
ns.EVERSONGWOODS = 2395
ns.SILVERMOONCITY = 2393
ns.ZULAMAN = 2437
ns.ATALAMAN = 2536
ns.HARANDAR = 2413
ns.VOIDSTORM = 2405
ns.SLAYERSRISE = 2444
ns.ARCANTINA = 2541

-- ns.WORLDQUESTS = ns.conditions.QuestComplete(79573)

-- ns.MAXLEVEL = {ns.conditions.QuestComplete(67030), ns.conditions.Level(70)}
ns.DRAGONRIDING = ns.conditions.SpellKnown(376777)

ns.FACTION_AMANI = 2696 -- paragon:2705
ns.FACTION_SINGULARITY = 2699 -- paragon:2725
ns.FACTION_HARATI = 2704 -- paragon:2726
ns.FACTION_SILVERMOONCOURT = 2710 -- paragon:2727
-- ns.FACTION_VANGUARDLIGHT = 2709

ns.CURRENCY_VALORSTONE = 3008
ns.CURRENCY_VOIDLIGHT = 3316
ns.CURRENCY_AMANI = 3354 --  renown:3355
ns.CURRENCY_SINGULARITY = 3389 -- renown:3388
ns.CURRENCY_HARATI = 3370 -- renown:3369
ns.CURRENCY_SILVERMOONCOURT = 3365 -- renown:3371

-- ns.PROF_WW_ALCHEMY = 2871 -- spell:
-- ns.PROF_WW_BLACKSMITHING = 2872 -- spell:423332
-- ns.PROF_WW_COOKING = 2873 -- spell:
-- ns.PROF_WW_ENCHANTING = 2874 -- spell:
-- ns.PROF_WW_ENGINEERING = 2875 -- spell:
-- ns.PROF_WW_FISHING = 2876
-- ns.PROF_WW_HERBALISM = 2877
-- ns.PROF_WW_INSCRIPTION = 2878 -- spell:
-- ns.PROF_WW_JEWELCRAFTING = 2879 -- spell:
-- ns.PROF_WW_LEATHERWORKING = 2880 -- spell:
-- ns.PROF_WW_MINING = 2881
-- ns.PROF_WW_SKINNING = 2882
-- ns.PROF_WW_TAILORING = 2883 -- spell:

ns.hiddenConfig = {}

ns.defaults.profile.groupsHidden = {
    worldboss = true, -- we get their loot in the POI, without showing the points when you can't see them...
}

ns.defaults.profile.achievementsHidden = {
	[61052] = true, -- Dust 'Em Off
}

ns.groups["junk"] = BAG_FILTER_JUNK
ns.groups["professionknowledge"] = "Profession Knowledge"
ns.groups["glyphs"] = GLYPHS
ns.groups["delves"] = DELVES_LABEL
ns.groups["delveentrances"] = DELVES_SHOW_ENTRACES_ON_MAP_TEXT
ns.groups["races"] = "{spell:369968:Racing}"
ns.groups["worldboss"] = MAP_LEGEND_WORLDBOSS
