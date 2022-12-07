local myname, ns = ...

ns.VALDRAKKEN = 2112
ns.WAKINGSHORES = 2022
ns.OHNAHRANPLAINS = 2023
ns.AZURESPAN = 2024
ns.THALDRASZUS = 2025
ns.FORBIDDENREACH = 2026
ns.FORBIDDENREACHINTRO = 2118 -- Dracthyr

ns.FACTION_MARUUK = 2503
ns.FACTION_DRAGONSCALE = 2507
ns.FACTION_VALDRAKKEN = 2510
ns.FACTION_ISKAARA = 2511

ns.MAXLEVEL = {ns.conditions.QuestComplete(67030), ns.conditions.Level(70)}
ns.DRAGONRIDING = ns.conditions.SpellKnown(376777)

ns.PROF_DF_ALCHEMY = 2823 -- spell: 366261
ns.PROF_DF_BLACKSMITHING = 2822 -- spell: 365677
ns.PROF_DF_COOKING = 2824
ns.PROF_DF_ENCHANTING = 2825 -- spell: 366255
ns.PROF_DF_ENGINEERING = 2827 -- spell: 366254
ns.PROF_DF_FISHING = 2826
ns.PROF_DF_HERBALISM = 2832
ns.PROF_DF_INSCRIPTION = 2828 -- spell: 366251
ns.PROF_DF_JEWELCRAFTING = 2829 -- spell: 366250
ns.PROF_DF_LEATHERWORKING = 2830 -- spell: 366249
ns.PROF_DF_MINING = 2833
ns.PROF_DF_SKINNING = 2834
ns.PROF_DF_TAILORING = 2831 -- spell: 366258

ns.hiddenConfig = {
    groupsHidden = true,
}

ns.defaults.profile.groupsHiddenByZone[ns.WAKINGSHORES] = {
    scoutpack = true,
}
ns.defaults.profile.groupsHiddenByZone[ns.OHNAHRANPLAINS] = {
    scoutpack = true,
}

ns.groups["junk"] = BAG_FILTER_JUNK
ns.groups["scoutpack"] = "Expedition Scout's Pack"
ns.groups["glyphs"] = "Dragon Glyphs"
ns.groups["dailymount"] = "Daily Mounts"
ns.groups["races"] = "{achievement:15939:Dragon Racing Completionist}"
ns.groups["professionknowledge"] = "Profession Knowledge"
ns.groups["hunts"] = "{achievement:16540:Hunt Master}"

-- Intro:
-- Talked to Azurathel: 72285
-- Talked to Genn and Shaw: 72286
-- Talked to Turalyon and Shaw: 72287

-- Rescued Waddles: 70872

-- Talked to Lethanak at the Life Pools: 72059

-- unlocked dragon customization: 68797

-- TODO achievements:
-- Selfie achievements: Framing A New Perspective (16634), That's Pretty Neat! (16446)
-- Fragments of History (16323)
