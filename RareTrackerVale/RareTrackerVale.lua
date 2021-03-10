-- Get an object we can use for the localization of the addon.
local L = LibStub("AceLocale-3.0"):GetLocale("RareTracker", true)

-- Group rares by the assaults they are active in.
-- Notes: used the values found in the HandyNotes_VisionsOfNZoth addon.
local assault_rare_ids = {
    [3155826] = { -- West (MAN)
        160825, 160878, 160893, 160872, 160874, 160876, 160810, 160868, 160826, 160930, 160920, 160867, 160922, 157468, 160906
    }, [3155832] = { -- Mid (MOG)
        157466, 157183, 157287, 157153, 157171, 157160, 160968, 157290, 157162, 156083, 157291, 157279, 155958, 154600, 157468, 157443, 160906
    }, [3155841] = { -- East (EMP)
        154447, 154467, 154559, 157267, 157266, 154106, 154490, 157176, 157468, 154394, 154332, 154495, 154087, 159087, 160906
    }
}

-- Register the data for the target zone.
RareTracker.RegisterRaresForModule({
    -- Define the zone(s) in which the rares are present.
    ["target_zones"] = {1530, 1579},
    ["zone_name"] = "Vale of Eternal Blossoms",
    ["plugin_name"] = "Vale of Eternal Blossoms",
    ["plugin_name_abbreviation"] = "Vale",
    ["SelectTargetEntities"] = function(self, target_npc_ids)
        local map_texture = C_MapExplorationInfo.GetExploredMapTextures(1530)
        if map_texture then
            local assault_id = map_texture[1].fileDataIDs[1]
            for _, npc_id in pairs(assault_rare_ids[assault_id]) do
                target_npc_ids[npc_id] = true
            end
        else
            for npc_id, _ in pairs(self.primary_id_to_data[1530].entities) do
                target_npc_ids[npc_id] = true
            end
        end
    end,
    ["entities"] = {
        --npc_id = {name, quest_id, coordinates}
        [160825] = {L[160825], 58300, {20, 75}}, -- "Amber-Shaper Esh'ri"
        [157466] = {L[157466], 57363, {34, 68}}, -- "Anh-De the Loyal"
        [154447] = {L[154447], 56237, {57, 41}}, -- "Brother Meller"
        [160878] = {L[160878], 58307, {6, 70}}, -- "Buh'gzaki the Blasphemous"
        [160893] = {L[160893], 58308, {6, 64}}, -- "Captain Vor'lek"
        [154467] = {L[154467], 56255, {81, 65}}, -- "Chief Mek-mek"
        [157183] = {L[157183], 58296, {19, 68}}, -- "Coagulated Anima"
        [159087] = {L[159087], 57834, nil}, -- "Corrupted Bonestripper"
        [154559] = {L[154559], 56323, {67, 68}}, -- "Deeplord Zrihj"
        [160872] = {L[160872], 58304, {27, 67}}, -- "Destroyer Krox'tazar"
        [157287] = {L[157287], 57349, {42, 57}}, -- "Dokani Obliterator"
        [160874] = {L[160874], 58305, {12, 41}}, -- "Drone Keeper Ak'thet"
        [160876] = {L[160876], 58306, {10, 41}}, -- "Enraged Amber Elemental"
        [157267] = {L[157267], 57343, {45, 45}}, -- "Escaped Mutation"
        [157153] = {L[157153], 57344, {30, 38}}, -- "Ha-Li"
        [160810] = {L[160810], 58299, {29, 53}}, -- "Harbinger Il'koxik"
        [160868] = {L[160868], 58303, {13, 51}}, -- "Harrier Nir'verash"
        [157171] = {L[157171], 57347, {28, 40}}, -- "Heixi the Stonelord"
        [160826] = {L[160826], 58301, {20, 61}}, -- "Hive-Guard Naz'ruzek"
        [157160] = {L[157160], 57345, {12, 31}}, -- "Houndlord Ren"
        [160930] = {L[160930], 58312, {18, 66}}, -- "Infused Amber Ooze"
        [160968] = {L[160968], 58295, {17, 12}}, -- "Jade Colossus"
        [157290] = {L[157290], 57350, {27, 11}}, -- "Jade Watcher"
        [160920] = {L[160920], 58310, {18, 9}}, -- "Kal'tik the Blight"
        [157266] = {L[157266], 57341, {46, 59}}, -- "Kilxl the Gaping Maw"
        [160867] = {L[160867], 58302, {26, 38}}, -- "Kzit'kovok"
        [160922] = {L[160922], 58311, {15, 37}}, -- "Needler Zhesalla"
        [154106] = {L[154106], 56094, {90, 46}}, -- "Quid"
        [157162] = {L[157162], 57346, {22, 12}}, -- "Rei Lun"
        [154490] = {L[154490], 56302, {64, 52}}, -- "Rijz'x the Devourer"
        [156083] = {L[156083], 56954, {46, 57}}, -- "Sanguifang"
        [160906] = {L[160906], 58309, {27, 43}}, -- "Skiver"
        [157291] = {L[157291], 57351, {18, 38}}, -- "Spymaster Hul'ach"
        [157279] = {L[157279], 57348, {26, 75}}, -- "Stormhowl"
        [155958] = {L[155958], 58507, {29, 22}}, -- "Tashara"
        [154600] = {L[154600], 56332, {47, 64}}, -- "Teng the Awakened"
        [157176] = {L[157176], 57342, {52, 42}}, -- "The Forgotten"
        [157468] = {L[157468], 57364, {10, 67}}, -- "Tisiphon"
        [154394] = {L[154394], 56213, {87, 42}}, -- "Veskan the Fallen"
        [154332] = {L[154332], 56183, {67, 28}}, -- "Voidtender Malketh"
        [154495] = {L[154495], 56303, {53, 62}}, -- "Will of N'Zoth"
        [157443] = {L[157443], 57358, {54, 49}}, -- "Xiln the Mountain"
        [154087] = {L[154087], 56084, {71, 41}}, -- "Zror'um the Infinite"
    }
})