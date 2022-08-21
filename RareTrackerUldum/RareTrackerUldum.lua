-- Redefine often used variables locally.
local C_MapExplorationInfo = C_MapExplorationInfo

-- Get an object we can use for the localization of the addon.
local L = LibStub("AceLocale-3.0"):GetLocale("RareTracker", true)

-- Overwrite the language of entities to english if enforced.
if RareTracker.db.global.window.force_display_in_english then
    L[157170] = "Acolyte Taspu"
    L[158557] = "Actiss the Deceiver"
    L[157593] = "Amalgamation of Flesh"
    L[151883] = "Anaua"
    L[155703] = "Anq'uri the Titanic"
    L[157472] = "Aphrom the Guise of Madness"
    L[154578] = "Aqir Flayer"
    L[154576] = "Aqir Titanus"
    L[162172] = "Aqir Warcaster"
    L[162370] = "Armagedillo"
    L[152757] = "Atekhramun"
    L[162171] = "Captain Dunewalker"
    L[157167] = "Champion Sen-mat"
    L[162147] = "Corpse Eater"
    L[158531] = "Corrupted Neferset Guard"
    L[158594] = "Doomsayer Vathiris"
    L[158491] = "Falconer Amenophis"
    L[157120] = "Fangtaker Orsa"
    L[158633] = "Gaze of N'Zoth"
    L[158597] = "High Executor Yothrim"
    L[158528] = "High Guard Reshef"
    L[162163] = "High Priest Ytaessis"
    L[151995] = "Hik-Ten the Taskmaster"
    L[160623] = "Hungering Miasma"
    L[152431] = "Kaneb-ti"
    L[155531] = "Infested Wastewander Captain"
    L[157134] = "Ishak of the Four Winds"
    L[156655] = "Korzaran the Slaughterer"
    L[154604] = "Lord Aj'qirai"
    L[156078] = "Magus Rehleth"
    L[157157] = "Muminah the Incandescent"
    L[152677] = "Nebet the Ascended"
    L[162196] = "Obsidian Annihilator"
    L[162142] = "Qho"
    L[157470] = "R'aas the Anima Devourer"
    L[156299] = "R'khuzj the Unfathomable"
    L[162173] = "R'krox the Runt"
    L[157390] = "R'oyolok the Reality Eater"
    L[157146] = "Rotfeaster"
    L[152040] = "Scoutmaster Moswen"
    L[151948] = "Senbu the Pridefather"
    L[161033] = "Shadowmaw"
    L[156654] = "Shol'thoss the Doomspeaker"
    L[160532] = "Shoth the Darkened"
    L[157476] = "Shugshul the Flesh Gorger"
    L[162140] = "Skikx'traz"
    L[162372] = "Spirit of Cyrus the Black"
    L[162352] = "Spirit of Dark Ritualist Zakahn"
    L[151878] = "Sun King Nahkotep"
    L[151897] = "Sun Priestess Nubitt"
    L[151609] = "Sun Prophet Epaphos"
    L[152657] = "Tat the Bonechewer"
    L[158636] = "The Grand Executor"
    L[157188] = "The Tomb Widow"
    L[158595] = "Thoughtstealer Vos"
    L[152788] = "Uat-ka the Sun's Wrath"
    L[162170] = "Warcaster Xeshro"
    L[151852] = "Watcher Rehu"
    L[157473] = "Yiphrim the Will Ravager"
    L[157164] = "Zealot Tekem"
    L[157469] = "Zoth'rum the Intellect Pillager"
    L[162141] = "Zuythiz"
end

-- Rare ids that have loot, which will be used as a default fallback option if no assault is active (introduction not done).
local rare_ids_with_loot = {
    157593, -- "Amalgamation of Flesh"
    162147, -- "Malevolent Drone"
    158633, -- "Gaze of N'Zoth"
    157134, -- "Ishak of the Four Winds"
    154604, -- "Lord Aj'qirai"
    157146, -- "Rotfeaster"
    162140, -- "Skikx'traz"
    158636, -- "The Grand Executor"
    157473, -- "Yiphrim the Will Ravager"
}

-- Group rares by the assaults they are active in.
-- Notes: used the values found in the HandyNotes_VisionsOfNZoth addon.
local assault_rare_ids = {
    [3165083] = { -- West (AQR)
        155703, 154578, 154576, 162172, 162370, 162171, 162147, 162163, 155531, 157134, 154604, 156078, 162196, 162142, 156299,
        162173, 160532, 162140, 162372, 162352, 151878, 162170, 162141, 157472, 158531, 152431, 157470, 157390, 157476, 158595,
        157473, 157469
    },
    [3165092] = { -- South (EMP)
        158557, 155703, 154578, 154576, 162172, 158594, 158491, 158633, 158597, 158528, 160623, 155531, 157134, 156655, 162196,
        156299, 161033, 156654, 160532, 151878, 158636, 157472, 158531, 152431, 157470, 157390, 157476, 158595, 157473, 157469
    },
    [3165098] = { -- East (AMA)
        157170, 151883, 155703, 154578, 154576, 162172, 152757, 157120, 151995, 155531, 157134, 157157, 152677, 162196, 157146,
        152040, 151948, 162372, 162352, 151878, 151897, 151609, 152657, 151852, 157164, 162141, 157167, 157593, 157188, 152788,
        157472, 158531, 152431, 157470, 157390, 157476, 158595, 157473, 157469
    }
}

-- Register the data for the target zone.
RareTracker.RegisterRaresForModule({
    -- Define the zone(s) in which the rares are present.
    ["target_zones"] = {1527},
    ["zone_name"] = "Uldum",
    ["plugin_name"] = "Uldum",
    ["plugin_name_abbreviation"] = "Uldum",
    ["SelectTargetEntities"] = function(self, target_npc_ids)
        local map_texture = C_MapExplorationInfo.GetExploredMapTextures(1527)
        if map_texture then
            local assault_id = map_texture[1].fileDataIDs[1]
            for _, npc_id in pairs(assault_rare_ids[assault_id]) do
                target_npc_ids[npc_id] = true
            end
        else
            -- First of all, we want 'enable_rare_filter' to be true if undefined.
            if not self.db.global.uldum then
                self.db.global.uldum = {}
                self.db.global.uldum.enable_rare_filter = true
            end
            
            if self.db.global.uldum.enable_rare_filter then
                for _, npc_id in pairs(rare_ids_with_loot) do
                    target_npc_ids[npc_id] = true
                end
            else
                for npc_id, _ in pairs(self.primary_id_to_data[1527].entities) do
                    target_npc_ids[npc_id] = true
                end
            end
        end
    end,
    ["GetOptionsTable"] = function(self) return {
            ["filter_list"] = {
                type = "toggle",
                name = L["Enable filter fallback"],
                desc = L["Show only rares that drop special loot (mounts/pets/toys)"..
                    " when no assault data is available."],
                width = "full",
                order = self:GetOrder(),
                get = function()
                    if not self.db.global.uldum then
                        self.db.global.uldum = {}
                        self.db.global.uldum.enable_rare_filter = true
                    end
                    return self.db.global.uldum.enable_rare_filter
                end,
                set = function(_, val)
                    self.db.global.uldum.enable_rare_filter = val
                    self:UpdateDisplayList()
                end
            }
        }
    end,
    ["entities"] = {
        --npc_id = {name, quest_id, coordinates}
        [157170] = {L[157170], 57281, {64, 26}}, -- "Acolyte Taspu"
        [158557] = {L[158557], 57669, {66.77, 74.33}}, -- "Actiss the Deceiver"
        [157593] = {L[157593], 57667, {70, 50}}, -- "Amalgamation of Flesh"
        [151883] = {L[151883], 55468, {69, 49}}, -- "Anaua"
        [155703] = {L[155703], 56834, {32, 64}}, -- "Anq'uri the Titanic"
        [157472] = {L[157472], 57437, {50, 79}}, -- "Aphrom the Guise of Madness"
        [154578] = {L[154578], 58612, {39, 25}}, -- "Aqir Flayer"
        [154576] = {L[154576], 58614, {31, 57}}, -- "Aqir Titanus"
        [162172] = {L[162172], 58694, {38, 45}}, -- "Aqir Warcaster"
        [162370] = {L[162370], 58718, {44, 42}}, -- "Armagedillo"
        [152757] = {L[152757], 55710, {65.3, 51.6}}, -- "Atekhramun"
        [162171] = {L[162171], 58699, {45, 57}}, -- "Captain Dunewalker"
        [157167] = {L[157167], 57280, {75, 52}}, -- "Champion Sen-mat"
        [162147] = {L[162147], 58696, {30, 49}}, -- "Corpse Eater"
        [158531] = {L[158531], 57665, {50, 79}}, -- "Corrupted Neferset Guard"
        [158594] = {L[158594], 57672, {49, 38}}, -- "Doomsayer Vathiris"
        [158491] = {L[158491], 57662, {48, 70}}, -- "Falconer Amenophis"
        [157120] = {L[157120], 57258, {75, 68}}, -- "Fangtaker Orsa"
        [158633] = {L[158633], 57680, {55, 53}}, -- "Gaze of N'Zoth"
        [158597] = {L[158597], 57675, {54, 43}}, -- "High Executor Yothrim"
        [158528] = {L[158528], 57664, {53.68, 79.33}}, -- "High Guard Reshef"
        [162163] = {L[162163], 58701, {42, 58}}, -- "High Priest Ytaessis"
        [151995] = {L[151995], 55502, {80, 47}}, -- "Hik-Ten the Taskmaster"
        [160623] = {L[160623], 58206, {60, 39}}, -- "Hungering Miasma"
        [152431] = {L[152431], 55629, {77, 52}}, -- "Kaneb-ti"
        [155531] = {L[155531], 56823, {19, 58}}, -- "Infested Wastewander Captain"
        [157134] = {L[157134], 57259, {73, 83}}, -- "Ishak of the Four Winds"
        [156655] = {L[156655], 57433, {71, 73}}, -- "Korzaran the Slaughterer"
        [154604] = {L[154604], 56340, {34, 18}}, -- "Lord Aj'qirai"
        [156078] = {L[156078], 56952, {30, 66}}, -- "Magus Rehleth"
        [157157] = {L[157157], 57277, {66, 20}}, -- "Muminah the Incandescent"
        [152677] = {L[152677], 55684, {61, 24}}, -- "Nebet the Ascended"
        [162196] = {L[162196], 58681, {35, 17}}, -- "Obsidian Annihilator"
        [162142] = {L[162142], 58693, {37, 59}}, -- "Qho"
        [157470] = {L[157470], 57436, {51, 88}}, -- "R'aas the Anima Devourer"
        [156299] = {L[156299], 57430, {58, 57}}, -- "R'khuzj the Unfathomable"
        [162173] = {L[162173], 58864, {28, 13}}, -- "R'krox the Runt"
        [157390] = {L[157390], 57434, nil}, -- "R'oyolok the Reality Eater"
        [157146] = {L[157146], 57273, {69, 32}}, -- "Rotfeaster"
        [152040] = {L[152040], 55518, {70, 42}}, -- "Scoutmaster Moswen"
        [151948] = {L[151948], 55496, {74, 65}}, -- "Senbu the Pridefather"
        [161033] = {L[161033], 58333, {57, 38}}, -- "Shadowmaw"
        [156654] = {L[156654], 57432, {59, 83}}, -- "Shol'thoss the Doomspeaker"
        [160532] = {L[160532], 58169, {61, 75}}, -- "Shoth the Darkened"
        [157476] = {L[157476], 57439, {55, 80}}, -- "Shugshul the Flesh Gorger"
        [162140] = {L[162140], 58697, {21, 61}}, -- "Skikx'traz"
        [162372] = {L[162372], 58715, {67, 68}}, -- "Spirit of Cyrus the Black"
        [162352] = {L[162352], 58716, {52, 40}}, -- "Spirit of Dark Ritualist Zakahn"
        [151878] = {L[151878], 58613, {79, 64}}, -- "Sun King Nahkotep"
        [151897] = {L[151897], 55479, {85, 57}}, -- "Sun Priestess Nubitt"
        [151609] = {L[151609], 55353, {73, 74}}, -- "Sun Prophet Epaphos"
        [152657] = {L[152657], 55682, {66, 35}}, -- "Tat the Bonechewer"
        [158636] = {L[158636], 57688, {49, 82}}, -- "The Grand Executor"
        [157188] = {L[157188], 57285, {84, 47}}, -- "The Tomb Widow"
        [158595] = {L[158595], 57673, {65, 72}}, -- "Thoughtstealer Vos"
        [152788] = {L[152788], 55716, {68, 64}}, -- "Uat-ka the Sun's Wrath"
        [162170] = {L[162170], 58702, {34, 26}}, -- "Warcaster Xeshro"
        [151852] = {L[151852], 55461, {80, 52}}, -- "Watcher Rehu"
        [157473] = {L[157473], 57438, nil}, -- "Yiphrim the Will Ravager"
        [157164] = {L[157164], 57279, {80, 57}}, -- "Zealot Tekem"
        [157469] = {L[157469], 57435, nil}, -- "Zoth'rum the Intellect Pillager"
        [162141] = {L[162141], 58695, {40, 41}}, -- "Zuythiz"
    }
})