-- Get an object we can use for the localization of the addon.
local L = LibStub("AceLocale-3.0"):GetLocale("RareTracker", true)

-- Overwrite the language of entities to english if enforced.
if RareTracker.db.global.window.force_display_in_english then
    L[60491] = "Sha of Anger"
    L[62346] = "Galleon"
    L[69099] = "Nalak"
    L[69161] = "Oondasta"
    L[83746] = "Rukhmar"
end

RareTracker.RegisterRaresForModule({
    -- Define the zone(s) in which the rares are present.
    ["target_zones"] = {379},
    ["zone_name"] = "Kun-Lai Summit",
    ["plugin_name"] = "World Bosses",
    ["plugin_name_abbreviation"] = "WorldBosses",
    ["entities"] = {
        --npc_id = {name, quest_id, coordinates}
        [60491] = {L[60491], 32099, nil}, -- "Sha of Anger"
    }
})

RareTracker.RegisterRaresForModule({
    -- Define the zone(s) in which the rares are present.
    ["target_zones"] = {376},
    ["zone_name"] = "Valley of the Four Winds",
    ["plugin_name"] = "World Bosses",
    ["plugin_name_abbreviation"] = "WorldBosses",
    ["entities"] = {
        --npc_id = {name, quest_id, coordinates}
        [62346] = {L[62346], 32098, nil}, -- "Galleon"
    }
})

RareTracker.RegisterRaresForModule({
    -- Define the zone(s) in which the rares are present.
    ["target_zones"] = {504},
    ["zone_name"] = "Isle of Thunder",
    ["plugin_name"] = "World Bosses",
    ["plugin_name_abbreviation"] = "WorldBosses",
    ["entities"] = {
        --npc_id = {name, quest_id, coordinates}
        [69099] = {L[69099], 32518, nil}, -- "Nalak"
    }
})

RareTracker.RegisterRaresForModule({
    -- Define the zone(s) in which the rares are present.
    ["target_zones"] = {507},
    ["zone_name"] = "Isle of Giants",
    ["plugin_name"] = "World Bosses",
    ["plugin_name_abbreviation"] = "WorldBosses",
    ["entities"] = {
        --npc_id = {name, quest_id, coordinates}
        [69161] = {L[69161], 32519, nil}, -- "Oondasta"
    }
})

RareTracker.RegisterRaresForModule({
    -- Define the zone(s) in which the rares are present.
    ["target_zones"] = {542},
    ["zone_name"] = "Spires of Arak",
    ["plugin_name"] = "World Bosses",
    ["plugin_name_abbreviation"] = "WorldBosses",
    ["entities"] = {
        --npc_id = {name, quest_id, coordinates}
        [83746] = {L[83746], 37464, nil}, -- "Rukhmar"
    }
})



-- Event rares
RareTracker.RegisterRaresForModule({
    -- Define the zone(s) in which the rares are present.
    ["target_zones"] = {78},
    ["zone_name"] = "Un'Goro Crater",
    ["plugin_name"] = "World Bosses",
    ["plugin_name_abbreviation"] = "WorldBosses",
    ["entities"] = {
        --npc_id = {name, quest_id, coordinates}
        [185784] = {L[185784], nil, nil}, -- "Unbridled Storm Lord"
        [189954] = {L[189954], nil, nil}, -- "Rumbling Earth Lord"
        [189933] = {L[189933], nil, nil}, -- "Glacial Ice Lord"
        [189955] = {L[189955], nil, nil}, -- "Raging Fire Lord"
    }
})

RareTracker.RegisterRaresForModule({
    -- Define the zone(s) in which the rares are present.
    ["target_zones"] = {10},
    ["zone_name"] = "Northern Barrens",
    ["plugin_name"] = "World Bosses",
    ["plugin_name_abbreviation"] = "WorldBosses",
    ["entities"] = {
        --npc_id = {name, quest_id, coordinates}
        [185784] = {L[185784], nil, nil}, -- "Unbridled Storm Lord"
        [189954] = {L[189954], nil, nil}, -- "Rumbling Earth Lord"
        [189933] = {L[189933], nil, nil}, -- "Glacial Ice Lord"
        [189955] = {L[189955], nil, nil}, -- "Raging Fire Lord"
    }
})

RareTracker.RegisterRaresForModule({
    -- Define the zone(s) in which the rares are present.
    ["target_zones"] = {15},
    ["zone_name"] = "Badlands",
    ["plugin_name"] = "World Bosses",
    ["plugin_name_abbreviation"] = "WorldBosses",
    ["entities"] = {
        --npc_id = {name, quest_id, coordinates}
        [185784] = {L[185784], nil, nil}, -- "Unbridled Storm Lord"
        [189954] = {L[189954], nil, nil}, -- "Rumbling Earth Lord"
        [189933] = {L[189933], nil, nil}, -- "Glacial Ice Lord"
        [189955] = {L[189955], nil, nil}, -- "Raging Fire Lord"
    }
})