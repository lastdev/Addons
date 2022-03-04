-- Redefine often used functions locally.
local UnitBuff = UnitBuff

-- Get an object we can use for the localization of the addon.
local L = LibStub("AceLocale-3.0"):GetLocale("RareTracker", true)

-- Overwrite the language of entities to english if enforced.
if RareTracker.db.global.window.force_display_in_english then
    L[151934] = "Arachnoid Harvester"
    L[154342] = "Arachnoid Harvester (F)"
    L[155060] = "Doppel Ganger"
    L[152113] = "The Kleptoboss (CC88)"
    L[154225] = "The Rusty Prince (F)"
    L[151623] = "The Scrap King (M)"
    L[151625] = "The Scrap King"
    L[151940] = "Uncle T'Rogg"
    L[150394] = "Armored Vaultbot"
    L[153200] = "Boilburn (JD41)"
    L[151308] = "Boggac Skullbash"
    L[152001] = "Bonepicker"
    L[154739] = "Caustic Mechaslime (CC73)"
    L[149847] = "Crazed Trogg (Orange)"
    L[152569] = "Crazed Trogg (Green)"
    L[152570] = "Crazed Trogg (Blue)"
    L[151569] = "Deepwater Maw"
    L[150342] = "Earthbreaker Gulroc (TR35)"
    L[154153] = "Enforcer KX-T57"
    L[151202] = "Foul Manifestation"
    L[135497] = "Fungarian Furor"
    L[153228] = "Gear Checker Cogstar"
    L[153205] = "Gemicide (JD99)"
    L[154701] = "Gorged Gear-Cruncher (CC61)"
    L[151684] = "Jawbreaker"
    L[152007] = "Killsaw"
    L[151933] = "Malfunctioning Beastbot"
    L[151124] = "Mechagonian Nullifier"
    L[151672] = "Mecharantula"
    L[8821909] = "Mecharantula (F)"
    L[151627] = "Mr. Fixthis"
    L[151296] = "OOX-Avenger/MG"
    L[153206] = "Ol' Big Tusk (TR28)"
    L[152764] = "Oxidized Leachbeast"
    L[151702] = "Paol Pondwader"
    L[150575] = "Rumblerocks"
    L[152182] = "Rustfeather"
    L[155583] = "Scrapclaw"
    L[150937] = "Seaspit"
    L[153000] = "Sparkqueen P'Emp"
    L[153226] = "Steel Singer Freza"
    L[152932] = "Razak Ironsides"
end

-- Link drill codes to their respective entities.
local drill_announcing_rares = {
    ["CC88"] = 152113,
    ["JD41"] = 153200,
    ["CC73"] = 154739,
    ["TR35"] = 150342,
    ["JD99"] = 153205,
    ["CC61"] = 154701,
    ["TR28"] = 153206,
}

-- Certain npcs have yell emotes to announce their arrival.
local yell_announcing_rares = {
    [L[151934]] = 151934, -- "Arachnoid Harvester"
    [L[151625]] = 151623, -- "The Scrap King"
    [L[151940]] = 151940, -- "Uncle T'Rogg",
    [L[151308]] = 151308, -- "Boggac Skullbash"
    [L[153228]] = 153228, -- "Gear Checker Cogstar"
    [L[151124]] = 151124, -- "Mechagonian Nullifier"
    [L[151296]] = 151296, -- "OOX-Avenger/MG"
    [L[150937]] = 150937, -- "Seaspit"
    [L[152932]] = 153000, -- "Sparkqueen P'Emp, announced by Razak Ironsides"
}

-- Register the data for the target zone.
RareTracker.RegisterRaresForModule({
    -- Define the zone(s) in which the rares are present.
    ["target_zones"] = {1462, 1522},
    ["zone_name"] = "Mechagon",
    ["plugin_name"] = "Mechagon",
    ["plugin_name_abbreviation"] = "Mechagon",
    ["entities"] = {
        --npc_id = {name, quest_id, coordinates}
        [151934] = {L[151934], 55512, {52.86, 40.94}}, -- "Arachnoid Harvester"
        [154342] = {L[154342], 55512, {52.86, 40.94}}, -- "Arachnoid Harvester (F)"
        -- [155060] = {L[155060], 56419, {80.96, 20.19}}, -- "Doppel Ganger"
        [152113] = {L[152113], 55858, {68.40, 48.14}}, -- "The Kleptoboss"
        [154225] = {L[154225], 56182, {57.34, 58.30}}, -- "The Rusty Prince (F)"
        [151623] = {L[151623], 55364, {72.13, 50.00}}, -- "The Scrap King (M)"
        [151625] = {L[151625], 55364, {72.13, 50.00}}, -- "The Scrap King"
        [151940] = {L[151940], 55538, {58.13, 22.16}}, -- "Uncle T'Rogg"
        -- [150394] = {L[150394], 55546, {53.26, 50.08}}, -- "Armored Vaultbot"
        [153200] = {L[153200], 55857, {51.24, 50.21}}, -- "Boilburn"
        [151308] = {L[151308], 55539, {55.52, 25.37}}, -- "Boggac Skullbash"
        [152001] = {L[152001], 55537, {65.57, 24.18}}, -- "Bonepicker"
        [154739] = {L[154739], 56368, {31.27, 86.14}}, -- "Caustic Mechaslime"
        [149847] = {L[149847], 55812, {82.53, 20.78}}, -- "Crazed Trogg (Orange)"
        [152569] = {L[152569], 55812, {82.53, 20.78}}, -- "Crazed Trogg (Green)"
        [152570] = {L[152570], 55812, {82.53, 20.78}}, -- "Crazed Trogg (Blue)"
        [151569] = {L[151569], 55514, {35.03, 42.53}}, -- "Deepwater Maw"
        [150342] = {L[150342], 55814, {63.24, 25.43}}, -- "Earthbreaker Gulroc"
        [154153] = {L[154153], 56207, {55.34, 55.16}}, -- "Enforcer KX-T57"
        [151202] = {L[151202], 55513, {65.69, 51.85}}, -- "Foul Manifestation"
        [135497] = {L[135497], 55367, nil}, -- "Fungarian Furor"
        [153228] = {L[153228], 55852, nil}, -- "Gear Checker Cogstar"
        [153205] = {L[153205], 55855, {59.58, 67.34}}, -- "Gemicide"
        [154701] = {L[154701], 56367, {77.97, 50.28}}, -- "Gorged Gear-Cruncher"
        [151684] = {L[151684], 55399, {77.23, 44.74}}, -- "Jawbreaker"
        [152007] = {L[152007], 55369, nil}, -- "Killsaw"
        [151933] = {L[151933], 55544, {60.68, 42.11}}, -- "Malfunctioning Beastbot"
        [151124] = {L[151124], 55207, {57.16, 52.57}}, -- "Mechagonian Nullifier"
        [151672] = {L[151672], 55386, {87.98, 20.81}}, -- "Mecharantula"
        [8821909] = {L[8821909], 55386, {87.98, 20.81}}, -- "Mecharantula"
        [151627] = {L[151627], 55859, {61.03, 60.97}}, -- "Mr. Fixthis"
        [151296] = {L[151296], 55515, {57.16, 39.46}}, -- "OOX-Avenger/MG"
        [153206] = {L[153206], 55853, {56.21, 36.25}}, -- "Ol' Big Tusk"
        [152764] = {L[152764], 55856, {55.77, 60.05}}, -- "Oxidized Leachbeast"
        [151702] = {L[151702], 55405, {22.67, 68.75}}, -- "Paol Pondwader"
        [150575] = {L[150575], 55368, {39.49, 53.46}}, -- "Rumblerocks"
        [152182] = {L[152182], 55811, {66.04, 79.20}}, -- "Rustfeather"
        [155583] = {L[155583], 56737, {82.46, 77.55}}, -- "Scrapclaw"
        [150937] = {L[150937], 55545, {19.39, 80.33}}, -- "Seaspit"
        [153000] = {L[153000], 55810, {81.64, 22.13}}, -- "Sparkqueen P'Emp"
        [153226] = {L[153226], 55854, {25.61, 77.30}}, -- "Steel Singer Freza"
    },
    ["NPCIdRedirection"] = function(npc_id)
        -- Check whether the entity is Mecharantula.
        if npc_id == 151672 then
            -- Check if the player has the time displacement buff.
            for i=1,40 do
                local spell_id = select(10, UnitBuff("player", i))
                if spell_id == nil then
                    break
                elseif spell_id == 296644 then
                    -- Change the NPC id to a bogus id.
                    npc_id = 8821909
                    break
                end
            end
        end
        return npc_id
    end,
    ["FindMatchForText"] = function(self, text)
        -- Check if any of the drill rig designations is contained in the broadcast text.
        for designation, npc_id in pairs(drill_announcing_rares) do
            if text:find(designation) then
                self:ProcessEntityAlive(npc_id, npc_id, nil, nil, false)
                return
            end
        end
    end,
    ["FindMatchForName"] = function(self, name)
        local npc_id = yell_announcing_rares[name]
        if npc_id then
            self:ProcessEntityAlive(npc_id, npc_id, nil, nil, false)
        end
    end
})