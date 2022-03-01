-- Get an object we can use for the localization of the addon.
local L = LibStub("AceLocale-3.0"):GetLocale("RareTracker", true)

-- Register the data for the target zones.
RareTracker.RegisterRaresForModule({
    ["target_zones"] = {1970},
    ["zone_name"] = "Zereth Mortis",
    ["plugin_name"] = "Zereth Mortis",
    ["plugin_name_abbreviation"] = "ZerethMortis",
    ["entities"] = {
        --npc_id = {name, quest_id, coordinates}
        [178778] = {L[178778], 65579, {53.1, 93.1}}, -- "Gluttonous Overgrowth"
        [178229] = {L[178229], 65557, {61.8, 60.6}}, -- "Feasting"
        [183927] = {L[183927], 65574, {53.4, 47.1}}, -- "Sand Matriarch Ileus"
        [179006] = {L[179006], 65549, {64.7, 33.8}}, -- "Akkaris"
        [183925] = {L[183925], 65272, {50.0, 40.0}}, -- "Tahkwitz"
        [179043] = {L[179043], 65582, {54.7, 68.8}}, -- "Orixal"
        [183747] = {L[183747], 65584, {47.1, 47.0}}, -- "Vitiane"
        [182318] = {L[182318], 65583, {59.7, 21.4}}, -- "General Zarathura"
        [181249] = {L[181249], 65550, {54.6, 72.6}}, -- "Tethos"
        [180746] = {L[180746], 64668, {38.9, 27.6}}, -- "Protector of the First Ones"
        [180924] = {L[180924], 64719, {69.1, 36.6}}, -- "Garudeon"
        [180978] = {L[180978], 65548, {52.4, 75.5}}, -- "Hirukon"
        [183814] = {L[183814], 65257, {58.7, 40.4}}, -- "Otaris the Provoked"
        [183748] = {L[183748], 65551, {58.1, 68.3}}, -- "Helmix"
        [183516] = {L[183516], 65580, {43.9, 75.1}}, -- "The Engulfer"
        [183746] = {L[183746], 65556, {43.4, 89.2}}, -- "Otiosen"
        [180917] = {L[180917], 64716, {53.6, 44.4}}, -- "Destabilized Core"
        [183737] = {L[183737], 65241, {64.1, 49.8}}, -- "Xy'rath the Covetous"
        [183596] = {L[183596], 65553, {50.2, 68.0}}, -- "Chitali the Eldest"
        [183722] = {L[183722], 65240, {35.9, 71.2}}, -- "Sorranos"
        [184409] = {L[184409], 65555, {47.5, 45.1}}, -- "Euv'ouk"
        [178563] = {L[178563], 65581, {52.5, 25.0}}, -- "Hadeon the Stonebreaker"
        [178963] = {L[178963], 63988, {75.6, 45.5}}, -- "Gorkek"
        [184413] = {L[184413], 65549, {42.3, 21.0}}, -- "Shifting Stargorger"
        [178508] = {L[178508], 65547, {54.1, 35.0}}, -- "Mother Phestis"
        [183646] = {L[183646], 65544, {64.5, 58.6}}, -- "Furidian"
        [183764] = {L[183764], 65251, {43.1, 32.0}}, -- "Zatojin"
        [183953] = {L[183953], 65273, {47.5, 62.2}}, -- "Corrupted Architect"
        [181360] = {L[181360], 65239, {39.4, 56.1}}, -- "Vexis"
    },
})
