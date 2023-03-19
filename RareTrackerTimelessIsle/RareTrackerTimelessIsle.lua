-- Get an object we can use for the localization of the addon.
local L = LibStub("AceLocale-3.0"):GetLocale("RareTracker", true)

-- Overwrite the language of entities to english if enforced.
if RareTracker.db.global.window.force_display_in_english then
    L[73174] = "Archiereus of Flame (Sanctuary)"
    L[73666] = "Archiereus of Flame (Summoned)"
    L[72775] = "Bufo"
    L[73171] = "Champion of the Black Flame"
    L[72045] = "Chelon"
    L[73175] = "Cinderfall"
    L[72049] = "Cranegnasher"
    L[73281] = "Dread Ship Vazuvius"
    L[73158] = "Emerald Gander"
    L[73279] = "Evermaw"
    L[73172] = "Flintlord Gairan"
    L[73282] = "Garnia"
    L[72970] = "Golganarr"
    L[73161] = "Great Turtle Furyshell"
    L[72909] = "Gu'chi the Swarmbringer"
    L[73167] = "Huolon"
    L[73163] = "Imperial Python"
    L[73160] = "Ironfur Steelhorn"
    L[73169] = "Jakur of Ordon"
    L[72193] = "Karkanos"
    L[73277] = "Leafmender"
    L[73166] = "Monstrous Spineclaw"
    L[72048] = "Rattleskew"
    L[73157] = "Rock Moss"
    L[71864] = "Spelurk"
    L[72769] = "Spirit of Jadefire"
    L[73704] = "Stinkbraid "
    L[72808] = "Tsavo'ka"
    L[73173] = "Urdur the Cauterizer"
    L[73170] = "Watcher Osu"
    L[72245] = "Zesqua"
    L[71919] = "Zhu-Gon the Sour"
end

-- Register the data for the target zone.
RareTracker.RegisterRaresForModule(
    {
        -- Define the zone(s) in which the rares are present.
        ["target_zones"] = {554},
        ["zone_name"] = "Timeless Isle",
        ["plugin_name"] = "Timeless Isle",
        ["plugin_name_abbreviation"] = "TimelessIsle",
        ["entities"] = {
            --npc_id = {name, quest_id, coordinates}
            [73174] = {L[73174], nil, {49.7, 22.2}}, -- "Archiereus of Flame (Sanctuary)"
            [73666] = {L[73666], nil, {34.9, 28.9}}, -- "Archiereus of Flame (Summoned)"
            [72775] = {L[72775], nil, {65.4, 70.0}}, -- "Bufo"
            [73171] = {L[73171], nil, nil}, -- "Champion of the Black Flame"
            [72045] = {L[72045], nil, {25.3, 35.8}}, -- "Chelon"
            [73175] = {L[73175], nil, {54.0, 52.4}}, -- "Cinderfall"
            [72049] = {L[72049], nil, {44.5, 69.0}}, -- "Cranegnasher"
            [73281] = {L[73281], nil, {25.8, 23.2}}, -- "Dread Ship Vazuvius"
            [73158] = {L[73158], nil, nil}, -- "Emerald Gander"
            [73279] = {L[73279], nil, nil}, -- "Evermaw"
            [73172] = {L[73172], nil, nil}, -- "Flintlord Gairan"
            [73282] = {L[73282], nil, {64.8, 28.8}}, -- "Garnia"
            [72970] = {L[72970], nil, {62.5, 63.5}}, -- "Golganarr"
            [73161] = {L[73161], nil, nil}, -- "Great Turtle Furyshell"
            [72909] = {L[72909], nil, nil}, -- "Gu'chi the Swarmbringer"
            [73167] = {L[73167], nil, nil}, -- "Huolon"
            [73163] = {L[73163], nil, nil}, -- "Imperial Python"
            [73160] = {L[73160], nil, nil}, -- "Ironfur Steelhorn"
            [73169] = {L[73169], nil, {52.0, 83.4}}, -- "Jakur of Ordon"
            [72193] = {L[72193], nil, {33.9, 85.1}}, -- "Karkanos"
            [73277] = {L[73277], nil, {67.3, 44.1}}, -- "Leafmender"
            [73166] = {L[73166], nil, nil}, -- "Monstrous Spineclaw"
            [72048] = {L[72048], nil, {60.6, 87.2}}, -- "Rattleskew"
            [73157] = {L[73157], nil, {45.4, 29.4}}, -- "Rock Moss"
            [71864] = {L[71864], nil, {59.0, 48.8}}, -- "Spelurk"
            [72769] = {L[72769], nil, {45.4, 38.9}}, -- "Spirit of Jadefire"
            [73704] = {L[73704], nil, {71.5, 80.7}}, -- "Stinkbraid "
            [72808] = {L[72808], nil, {54.6, 44.3}}, -- "Tsavo'ka"
            [73173] = {L[73173], nil, {45.4, 26.6}}, -- "Urdur the Cauterizer"
            [73170] = {L[73170], nil, {57.5, 77.1}}, -- "Watcher Osu"
            [72245] = {L[72245], nil, {47.6, 87.3}}, -- "Zesqua"
            [71919] = {L[71919], nil, {37.4, 77.4}} -- "Zhu-Gon the Sour"
        }
    }
)
