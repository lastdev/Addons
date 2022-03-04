-- Get an object we can use for the localization of the addon.
local L = LibStub("AceLocale-3.0"):GetLocale("RareTracker", true)

-- Overwrite the language of entities to english if enforced.
if RareTracker.db.global.window.force_display_in_english then
    L[157964] = "Adjutant Dekaris"
    L[157833] = "Borr-Geth"
    L[160770] = "Darithis the Bleak"
    L[170711] = "Dolos"
    L[169827] = "Ekphoras, Herald of Grief"
    L[170303] = "Exos, Herald of Domination"
    L[170301] = "Apholeias, Herald of Loss"
    L[170302] = "Talaporas, Herald of Pain"
    L[158278] = "Nascent Devourer"
    L[172577] = "Orophea"
    L[166398] = "Soulforger Rhovus"
    L[170731] = "Thanassos"
    L[172862] = "Yero the Skittish"
    L[171317] = "Conjured Death"
    L[158025] = "Darklord Taraxis"
    L[170774] = "Eketra"
    L[154330] = "Eternas the Tormentor"
    L[162849] = "Morguliax"
    L[164064] = "Obolos"
    L[170634] = "Shadeweaver Zeris"
    L[175012] = "Ikras the Devourer"
    L[179853] =  "Blinding Shadow (Rift)"
    L[179851] = "Guard Orguluus (Rift)"
    L[179735] =  "Torglluun (Rift)"
    L[180246] = "Carriage Crusher"
    L[179779] = "Deomen the Vortex"
    L[179460] = "Fallen Charger"
    L[179805] = "Traitor Balthier"
    L[177444] = "Ylva"
    L[179769] = "Consumption (Spawn)"
    L[179755] = "Consumption (Rare)"
    L[179768] = "Consumption (Rare Elite)"
    L[177903] = "Dominated Protector"
    L[180013] = "Escaped Wilderling"
    L[180042] = "Fleshwing"
    L[179472] = "Konthrogz the Obliterator"
    L[179931] = "Relic Breaker Krelva"
    L[179108] = "Kroke the Tormented"
    L[179684] = "Malbog"
    L[180160] = "Reliwik the Defiant"
    L[179985] = "Stygian Stonecrusher"
    L[179760] = "Towering Exterminator"
    L[180162] = "Ve'rayn"
    L[180032] = "Wild Worldcracker"
    L[179859] = "Xyraxz the Unknowable"
    L[179802] = "Yarxhov the Pillager"
    L[177336] = "Zelnithop"
    L[179913] = "Deadsoul Hatcher (Rift)"
    L[179608] = "Screaming Shade (Rift)"
    L[179911] = "Silent Soulstalker (Rift)"
    L[179914] = "Observer Yorik (Rift)"
end

-- Register the data for the target zones.
RareTracker.RegisterRaresForModule({
    -- Define the zone(s) in which the rares are present.
    ["target_zones"] = {1543},
    ["zone_name"] = "The Maw",
    ["plugin_name"] = "The Maw",
    ["plugin_name_abbreviation"] = "Maw",
    ["entities"] = {
        --npc_id = {name, quest_id, coordinates}
        [157964] = {L[157964], 57482, {25.8, 31.2}}, -- "Adjutant Dekaris"
        [157833] = {L[157833], 57469, {39.6, 41.0}}, -- "Borr-Geth"
        [180246] = {L[180246], 64258, {45.5, 54.8}}, -- "Carriage Crusher"
        [160770] = {L[160770], 62281, {60.8, 47.8}}, -- "Darithis the Bleak"
        [170711] = {L[170711], 60909, {32.9, 65.2}}, -- "Dolos"
        [169827] = {L[169827], 60666, {42.4, 21.2}}, -- "Ekphoras, Herald of Grief"
        [170303] = {L[170303], 62260, {20.6, 69.5}}, -- "Exos, Herald of Domination"
        [170301] = {L[170301], 60788, {19.8, 41.6}}, -- "Apholeias, Herald of Loss"
        [170302] = {L[170302], 60789, {28.6, 11.6}}, -- "Talaporas, Herald of Pain"
        [158278] = {L[158278], 57573, {46.2, 74.4}}, -- "Nascent Devourer"
        [172577] = {L[172577], 61519, {23.6, 21.8}}, -- "Orophea"
        [166398] = {L[166398], 60834, {35.0, 42.0}}, -- "Soulforger Rhovus"
        [170731] = {L[170731], 60914, {27.4, 71.3}}, -- "Thanassos"
        [172862] = {L[172862], 61568, {37.6, 65.6}}, -- "Yero the Skittish"
        [171317] = {L[171317], 61106, {28.6, 13.6}}, -- "Conjured Death"
        [158025] = {L[158025], 62282, {48.6, 81.4}}, -- "Darklord Taraxis"
        [170774] = {L[170774], 60915, {23.2, 53.0}}, -- "Eketra"
        [154330] = {L[154330], 57509, {27.4, 49.4}}, -- "Eternas the Tormentor"
        [162849] = {L[162849], 60987, {16.6, 50.6}}, -- "Morguliax"
        [164064] = {L[164064], 60667, {48.5, 18.4}}, -- "Obolos"
        [170634] = {L[170634], 60884, {31.0, 60.3}}, -- "Shadeweaver Zeris"
        [175012] = {L[175012], 62788, {32.5, 51.8}}, -- "Ikras the Devourer"
        
        [179853] = {L[179853], 64276, {36.0, 41.6}}, -- "Blinding Shadow (Rift)"
        [179851] = {L[179851], 64272, {51, 70}}, -- "Guard Orguluus (Rift)"
        [179735] = {L[179735], 64232, {28.6, 25.1}}, -- "Torglluun (Rift)"
        
        [179779] = {L[179779], 64251, {66.4, 55.5}}, -- "Deomen the Vortex"
        [179460] = {L[179460], 64164, nil}, -- "Fallen Charger"
        [179805] = {L[179805], 64258, {67.4, 47.8}}, -- "Traitor Balthier"
        [177444] = {L[177444], 64152, {66.4, 41.9}}, -- "Ylva"
    },
    ["NPCIdRedirection"] = function(npc_id)
        -- Check whether the entity has redirected IDs.
        if npc_id == 169828 then
            return 169827 -- "Ekphoras, Herald of Grief"
        elseif npc_id == 170315 then
            return 170301 -- "Apholeias, Herald of Loss"
        elseif npc_id == 170305 then
            return 170302 -- "Talaporas, Herald of Pain"
        else
            return npc_id
        end
    end
})

RareTracker.RegisterRaresForModule({
    ["target_zones"] = {1961, 2007},
    ["zone_name"] = "Korthia",
    ["plugin_name"] = "Korthia",
    ["plugin_name_abbreviation"] = "Korthia",
    ["entities"] = {
        --npc_id = {name, quest_id, coordinates}
        [179769] = {L[179769], 64243, {50.3, 42.6}}, -- "Consumption (Spawn)"
        [179755] = {L[179755], 64243, {50.3, 42.6}}, -- "Consumption (Rare)"
        [179768] = {L[179768], 64243, {50.3, 42.6}}, -- "Consumption (Rare Elite)"
        [177903] = {L[177903], 63830, {51.9, 20.9}}, -- "Dominated Protector"
        [180013] = {L[180013], 64320, {33.2, 39.4}}, -- "Escaped Wilderling"
        [180042] = {L[180042], 64349, {59.8, 43.4}}, -- "Fleshwing"
        [179472] = {L[179472], 64246, nil}, -- "Konthrogz the Obliterator"
        [179931] = {L[179931], 64291, {22.9, 42.1}}, -- "Relic Breaker Krelva"
        [179108] = {L[179108], 64428, {62.1, 36.4}}, -- "Kroke the Tormented"
        [179684] = {L[179684], 64233, {60.7, 23.1}}, -- "Malbog"
        [180160] = {L[180160], 64455, {56.3, 66.1}}, -- "Reliwik the Defiant"
        [179985] = {L[179985], 64313, {45.7, 80.0}}, -- "Stygian Stonecrusher"
        [179760] = {L[179760], 64245, nil}, -- "Towering Exterminator"
        [180162] = {L[180162], 64457, nil}, -- "Ve'rayn"
        [180032] = {L[180032], 64338, {56.9, 32.4}}, -- "Wild Worldcracker"
        [179859] = {L[179859], 64278, {45.0, 35.5}}, -- "Xyraxz the Unknowable"
        [179802] = {L[179802], 64257, {39.4, 52.4}}, -- "Yarxhov the Pillager"
        [177336] = {L[177336], 64442, {27.8, 58.9}}, -- "Zelnithop"
        
        [179913] = {L[179913], 64285, {60.0, 53.2}}, -- "Deadsoul Hatcher (Rift)"
        [179608] = {L[179608], 64263, {44.8, 42.8}}, -- "Screaming Shade (Rift)"
        [179911] = {L[179911], 64284, {57.6, 70.4}}, -- "Silent Soulstalker (Rift)"
        [179914] = {L[179914], 64440, {50.3, 75.9}}, -- "Observer Yorik (Rift)"
    },
})
