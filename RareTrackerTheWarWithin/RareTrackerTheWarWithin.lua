-- Get an object we can use for the localization of the addon.
local L = LibStub("AceLocale-3.0"):GetLocale("RareTracker", true)

-- Overwrite the language of entities to english if enforced.
if RareTracker.db.global.window.force_display_in_english then
    -- Isle of Dorn
    L[213115] = "Rustul Titancap"
    L[219262] = "Springbubble"
    L[219264] = "Bloodmaw"
    L[219267] = "Plaguehart"
    L[219266] = "Escaped Cutthroat"
    L[219270] = "Kronolith, Might of the Mountain"
    L[219271] = "Twice-Stinger the Wretched"
    L[221128] = "Clawbreaker K'zithix"
    L[219284] = "Zovex"
    L[222380] = "Rotfist"
    L[220883] = "Sweetspark the Oozeful"
    L[217534] = "Sandres the Relicbearer"
    L[219263] = "Warphorn"
    L[219265] = "Emperor Pitfang"
    L[219268] = "Gar'loc"
    L[219269] = "Tempest Lord Incarnus"
    L[219278] = "Shallowshell the Clacker"
    L[219279] = "Flamekeeper Graz"
    L[219281] = "Alunira"
    L[222378] = "Kereke"
    L[221126] = "Tephratennae"
    L[220890] = "Matriarch Charfuria"

    -- The Ringing Deeps
    L[220276] = "Candleflyer Captain"
    L[220274] = "Aquellion"
    L[220272] = "Deathbound Husk"
    L[220270] = "Zilthara"
    L[220268] = "Trungal"
    L[220266] = "Coalesced Monstrosity"
    L[220287] = "Kelpmire"
    L[220285] = "Lurker of the Deeps"
    L[221199] = "Hungerer of the Deeps"
    L[220275] = "King Splash"
    L[220273] = "Rampaging Blight"
    L[220271] = "Terror of the Forge"
    L[220269] = "Cragmund"
    L[220267] = "Charmonger"
    L[220265] = "Automaxor"
    L[220286] = "Deepflayer Broodmother"
    L[221217] = "Spore-infused Shalewing"
    L[218393] = "Disturbed Earthgorger"
    
    -- Hallowfall
    L[218458] = "Deepfiend Azellix"
    L[218452] = "Murkshade"
    L[221767] = "Funglour"
    L[215805] = "Sloshmuck"
    L[221648] = "The Perchfather"
    L[221708] = "Sir Alastair Purefire"
    L[221690] = "Strength of Beledar"
    L[221753] = "Deathtide"
    L[206203] = "Moth'ethk"
    L[206184] = "Deathpetal"
    L[207803] = "Toadstomper"
    L[206977] = "Parasidious"
    L[207780] = "Finclaw Bloodtide"
    L[218426] = "Ixlorb the Weaver"
    L[221551] = "Grimslice"
    L[218444] = "The Taskmaker"
    L[221534] = "Lytfang the Lost"
    L[221668] = "Horror of the Shallows"
    L[207802] = "Beledar's Spawn"
    L[221786] = "Pride of Beledar"
    L[206514] = "Crazed Cabbage Smacker"
    L[214757] = "Croakit"
    L[221179] = "Duskshadow"
    L[207826] = "Ravageant"
    L[220771] = "Murkspike"
    
    -- Azj'Kahet
    L[216031] = "Abyssal Devourer"
    L[214151] = "Ahg'zagall"
    L[216037] = "Vilewing"
    L[216039] = "Xishorr"
    L[216034] = "The XT-Minecrusher 8700"
    L[216043] = "Monstrous Lasharoth"
    L[216045] = "Enduring Gutterface"
    L[216049] = "The Oozekhan"
    L[216051] = "Umbraclaw Matra"
    L[216052] = "Kaheti Bladeguard"
    L[216032] = "Rhak'ik & Khak'ik"
    L[216041] = "Webspeaker Grik'ik"
    L[216038] = "Chitin Hulk"
    L[221327] = "Kaheti Silk Hauler"
    L[216042] = "Cha'tak"
    L[216044] = "Maddened Siegebomber"
    L[216048] = "Jix'ak the Crazed"
    L[216050] = "Harvester Qixt"
    L[222624] = "Deepcrawler Tx'kesh"
    L[216047] = "The One Left"
    L[216046] = "Tka'ktath"
    
    -- Siren Isle
    L[229982] = "Nerathor"
    L[229992] = "Stalagnarok"
    L[227550] = "Shardsong"
    L[228155] = "Grimgull"
    L[231090] = "Snacker"
    L[229852] = "Coralweaver Calliso"
    L[228583] = "Chef Chum Platter"
    L[227545] = "Ikir the Flotsurge"
    L[228201] = "Gravesludge"
    L[228154] = "Bloodbrine"
    L[228601] = "Ghostmaker"
    L[228159] = "Gunnlod the Sea-Drinker"
    L[228151] = "Wreckwater"
    L[229853] = "Siris the Sea Scorpion"
    L[228580] = "Plank-Master Bluebelly"
    L[230137] = "Asbjorn the Bloodsoaked"
    
    
    -- Seafury tempest rares.
    L[231356] = "Brinebough"
    L[231357] = "Zek'ul the Shipbreaker"
    L[231368] = "Ksvir the Forgotten"
    L[231353] = "Tempest Talon"
    L[228547] = "Slaughtershell"
    
    -- Undermine
    L[230931] = "Scrap Beak"
    L[230940] = "Tally Doublespeak"
    L[230946] = "V.V. Goosworth"
    L[230979] = "S.A.L."
    L[231012] = "Candy Stickemup"
    L[231288] = "Swigs Farsight"
    L[230793] = "The Junk-Wall"
    L[230828] = "Chief Foreman Gutso"
    L[234480] = "M.A.G.N.O."
    L[233471] = "Scrapchewer"
    L[231310] = "Darkfuse Precipitant"
    L[230934] = "Ratspit"
    L[230947] = "Slimesby"
    L[230951] = "Thwack"
    L[230995] = "Nitro"
    L[231017] = "Grimewick"
    L[230746] = "Ephemeral Agent Lathyd"
    L[230800] = "Slugger the Smart"
    L[230840] = "Flyboy Snooty"
    L[234499] = "Giovante"
    L[233472] = "Volstrike the Charged"
    
    L[234621] = "Gallagio"
    
    -- K'aresh
    L[232098] = "Chowdar"
    L[238540] = "Grubber"
    L[232128] = "Ixthar the Unblinking"
    L[245997] = "Malek'ta"
    L[232108] = "Morgil the Netherspawn"
    L[232182] = "Prototype MK-V"
    L[232006] = "Sha'ryth the Cursed"
    L[232193] = "Stalker of the Wastes"
    L[232111] = "The Nightreaver"
    L[232199] = "Xarran the Binder"
    L[241956] = "Arcana-Monger So'zer"
    L[245998] = "Heka'tamos"
    L[232077] = "Korgorath the Ravager"
    L[231981] = "Maw of the Sands"
    L[232127] = "Orith the Dreadful"
    L[232189] = "Revenant of the Wasteland"
    L[232129] = "Shadowhowl"
    L[234845] = "Sthaarbs"
    L[232195] = "Urmag"
    
    L[238144] = "Shatterpulse"
    L[238536] = "Hollowbane"
    L[241920] = "Purple Peat"
    L[238384] = "Xy'vox The Twisted"
end

RareTracker.RegisterRaresForModule({
    -- Define the zone(s) in which the rares are present.
    ["target_zones"] = {2248},
    ["zone_name"] = "Isle of Dorn",
    ["plugin_name"] = "Isle of Dorn",
    ["plugin_name_abbreviation"] = "TheWarWithin",
    ["entities"] = {
        --npc_id = {name, quest_id, coordinates}
        [213115] = {L[213115], 78619, {35.8, 74.8}}, --"Rustul Titancap"
        [219262] = {L[219262], 81892, {58.6, 60.6}}, --"Springbubble"
        [219264] = {L[219264], 81893, {41.4, 76.0}}, --"Bloodmaw"
        [219267] = {L[219267], 81897, {50.8, 69.8}}, --"Plaguehart"
        [219266] = {L[219266], 81907, {25.8, 45.0}}, --"Escaped Cutthroat"
        [219270] = {L[219270], 81902, {48.0, 27.0}}, --"Kronolith, Might of the Mountain"
        [219271] = {L[219271], 81904, {57.0, 22.6}}, --"Twice-Stinger the Wretched"
        [221128] = {L[221128], 81920, {55.6, 27.0}}, --"Clawbreaker K'zithix"
        [219284] = {L[219284], 82203, {30.8, 52.2}}, --"Zovex"
        [222380] = {L[222380], 82205, {30.8, 52.4}}, --"Rotfist"
        [220883] = {L[220883], 81922, {69.8, 38.4}}, --"Sweetspark the Oozeful"
        [217534] = {L[217534], 79685, {62.6, 68.4}}, --"Sandres the Relicbearer"
        [219263] = {L[219263], 81894, {56.4, 36.4}}, --"Warphorn"
        [219265] = {L[219265], 81895, {47.8, 60.2}}, --"Emperor Pitfang"
        [219268] = {L[219268], 81899, {53.4, 80.0}}, --"Gar'loc"
        [219269] = {L[219269], 81901, {57.4, 16.2}}, --"Tempest Lord Incarnus"
        [219278] = {L[219278], 81903, {74.2, 27.6}}, --"Shallowshell the Clacker"
        [219279] = {L[219279], 81905, {64.0, 40.6}}, --"Flamekeeper Graz"
        [219281] = {L[219281], 82196, {23.2, 58.2}}, --"Alunira"
        [222378] = {L[222378], 82204, {30.8, 52.2}}, --"Kereke"
        [221126] = {L[221126], 81923, {71.4, 36.6}}, --"Tephratennae"
        [220890] = {L[220890], 81921, {72.6, 40.4}}, --"Matriarch Charfuria"
    }
})

RareTracker.RegisterRaresForModule({
    -- Define the zone(s) in which the rares are present.
    ["target_zones"] = {2214},
    ["zone_name"] = "The Ringing Deeps",
    ["plugin_name"] = "The Ringing Deeps",
    ["plugin_name_abbreviation"] = "TheWarWithin",
    ["entities"] = {
        --npc_id = {name, quest_id, coordinates}
        [220276] = {L[220276], 80505, {67.0, 31.0}}, --"Candleflyer Captain"
        [220274] = {L[220274], 80557, {49.6, 66.2}}, --"Aquellion"
        [220272] = {L[220272], 81566, {66.8, 68.4}}, --"Deathbound Husk"
        [220270] = {L[220270], 80506, {52.0, 26.6}}, --"Zilthara"
        [220268] = {L[220268], 80574, {71.6, 46.2}}, --"Trungal"
        [220266] = {L[220266], 81511, {57.8, 38.6}}, --"Coalesced Monstrosity"
        [220287] = {L[220287], 81485, {47.0, 46.8}}, --"Kelpmire"
        [220285] = {L[220285], 81633, {60.8, 76.6}}, --"Lurker of the Deeps"
        [221199] = {L[221199], 81648, {66.0, 49.6}}, --"Hungerer of the Deeps"
        [220275] = {L[220275], 80547, {42.8, 35.0}}, --"King Splash"
        [220273] = {L[220273], 81563, {57.2, 54.8}}, --"Rampaging Blight"
        [220271] = {L[220271], 80507, {47.6, 11.6}}, --"Terror of the Forge"
        [220269] = {L[220269], 80560, {50.8, 46.6}}, --"Cragmund"
        [220267] = {L[220267], 81562, {41.6, 17.0}}, --"Charmonger"
        [220265] = {L[220265], 81674, {52.6, 19.8}}, --"Automaxor"
        [220286] = {L[220286], 80536, {54.6, 8.8}}, --"Deepflayer Broodmother"
        [221217] = {L[221217], 81652, {67.2, 46.2}}, --"Spore-infused Shalewing"
        [218393] = {L[218393], 80003, {67.0, 52.6}}, --"Disturbed Earthgorger"
    }
})

RareTracker.RegisterRaresForModule({
    -- Define the zone(s) in which the rares are present.
    ["target_zones"] = {2215},
    ["zone_name"] = "Hallowfall",
    ["plugin_name"] = "Hallowfall",
    ["plugin_name_abbreviation"] = "TheWarWithin",
    ["entities"] = {
        --npc_id = {name, quest_id, coordinates}
        [218458] = {L[218458], 80011, {72.0, 64.2}}, --"Deepfiend Azellix"
        [218452] = {L[218452], 80010, {52.2, 26.8}}, --"Murkshade"
        [221767] = {L[221767], 81881, {36.8, 71.8}}, --"Funglour"
        [215805] = {L[215805], 79271, {73.6, 52.2}}, --"Sloshmuck"
        [221648] = {L[221648], 81791, {44.6, 16.4}}, --"The Perchfather"
        [221708] = {L[221708], 81853, {36.0, 35.6}}, --"Sir Alastair Purefire"
        [221690] = {L[221690], 81849, {43.6, 29.8}}, --"Strength of Beledar"
        [221753] = {L[221753], 81880, {44.8, 42.8}}, --"Deathtide"
        [206203] = {L[206203], 82557, {63.4, 28.6}}, --"Moth'ethk"
        [206184] = {L[206184], 82559, {65.6, 33.2}}, --"Deathpetal"
        [207803] = {L[207803], 82561, {67.6, 24.2}}, --"Toadstomper"
        [206977] = {L[206977], 82563, {61.8, 32.4}}, --"Parasidious"
        [207780] = {L[207780], 82564, {62.4, 17.6}}, --"Finclaw Bloodtide"
        [218426] = {L[218426], 80006, {57.0, 64.2}}, --"Ixlorb the Weaver"
        [221551] = {L[221551], 81761, {33.2, 53.4}}, --"Grimslice"
        [218444] = {L[218444], 80009, {56.6, 69.0}}, --"The Taskmaker"
        [221534] = {L[221534], 81756, {23.0, 59.0}}, --"Lytfang the Lost"
        [221668] = {L[221668], 81836, nil}, --"Horror of the Shallows"
        [207802] = {L[207802], 81763, nil}, --"Beledar's Spawn"
        [221786] = {L[221786], 81882, {57.6, 48.6}}, --"Pride of Beledar"
        [206514] = {L[206514], 82558, {65.8, 28.0}}, --"Crazed Cabbage Smacker"
        [214757] = {L[214757], 82560, {67.2, 23.6}}, --"Croakit"
        [221179] = {L[221179], 82562, {63.8, 19.4}}, --"Duskshadow"
        [207826] = {L[207826], 82566, {61.8, 33.6}}, --"Ravageant"
        [220771] = {L[220771], 82565, {63.6, 12.8}}, --"Murkspike"
    }
})

RareTracker.RegisterRaresForModule({
    -- Define the zone(s) in which the rares are present.
    ["target_zones"] = {2255, 2213, 2256, 2216},
    ["zone_name"] = "Azj-Kahet",
    ["plugin_name"] = "Azj-Kahet",
    ["plugin_name_abbreviation"] = "TheWarWithin",
    ["entities"] = {
        --npc_id = {name, quest_id, coordinates}
        [216031] = {L[216031], 81695, {46.6, 38.6}}, --"Abyssal Devourer"
        [214151] = {L[214151], 78905, {38.0, 42.8}}, --"Ahg'zagall"
        [216037] = {L[216037], 81700, {35.0, 40.4}}, --"Vilewing"
        [216039] = {L[216039], 81701, {67.8, 58.2}}, --"Xishorr"
        [216034] = {L[216034], 81703, {76.6, 57.8}}, --"The XT-Minecrusher 8700"
        [216043] = {L[216043], 81705, {70.0, 69.0}}, --"Monstrous Lasharoth"
        [216045] = {L[216045], 81707, {58.2, 62.8}}, --"Enduring Gutterface"
        [216049] = {L[216049], 82035, {62.0, 89.8}}, --"The Oozekhan"
        [216051] = {L[216051], 82037, {64.6, 3.6}}, --"Umbraclaw Matra"
        [216052] = {L[216052], 82078, {62.4, 6.8}}, --"Kaheti Bladeguard"
        [216032] = {L[216032], 81694, {44.0, 38.0}}, --"Rhak'ik & Khak'ik"
        [216041] = {L[216041], 81699, {61.4, 27.6}}, --"Webspeaker Grik'ik"
        [216038] = {L[216038], 81634, {31.2, 56.6}}, --"Chitin Hulk"
        [221327] = {L[221327], 81702, {62.8, 27.2}}, --"Kaheti Silk Hauler"
        [216042] = {L[216042], 81704, {70.6, 21.6}}, --"Cha'tak"
        [216044] = {L[216044], 81706, {65.6, 63.6}}, --"Maddened Siegebomber"
        [216048] = {L[216048], 82034, {67.0, 83.6}}, --"Jix'ak the Crazed"
        [216050] = {L[216050], 82036, {65.0, 83.6}}, --"Harvester Qixt"
        [222624] = {L[222624], 82077, {64.6, 8.6}}, --"Deepcrawler Tx'kesh"
        [216047] = {L[216047], 82290, {63.5, 95}}, --"The One Left"
        [216046] = {L[216046], 82289, {62.8, 66.6}}, --"Tka'ktath"
    }
})

local siren_isle_rare_announcements = {
    [L["Deep beneath the isle surface, a strange sound echoes and then goes silent."]] = 227550,
    [L["Seagulls sound a warning as the water churns violently offshore."]] = 231090,
    [L["Thunderous footfalls echo along the western shores, marking the arrival of a new threat."]] = 227545,
    [L["A foul smell is carried on the wind from the west."]] = 228154,
    [L["A haunting, echoing howl rises from the hillside. A feel of unease lingers on the air."]] = 228601,
    [L["The ground trembles and a chill fills the air. Something undead is stirring."]] = 228159,
    [L["The sound of waves and breaking wood is carried on the wind."]] = 228151,
    [L["A strange skittering sound echoes above the lap of shallow water."]] = 229853,
    [L["A gurgling giggle and the sound of chains dragging across the sand cuts through the seaside silence."]] = 229852,
}

RareTracker.RegisterRaresForModule({
    -- Define the zone(s) in which the rares are present.
    ["target_zones"] = {2369, 2375},
    ["zone_name"] = "Siren Isle",
    ["plugin_name"] = "Siren Isle",
    ["plugin_name_abbreviation"] = "TheWarWithin",
    ["entities"] = {
        --npc_id = {name, quest_id, coordinates}
        [229982] = {L[229982], nil, {27.6, 65.6}}, --"Nerathor"
        [229992] = {L[229992], nil, {39.4, 56.6}}, --"Stalagnarok"
        [227550] = {L[227550], nil, {49.0, 16.8}}, --"Shardsong"
        [228155] = {L[228155], 84796, {36.2, 23.6}}, --"Grimgull"
        [231090] = {L[231090], 86933, {72.0, 23.6}}, --"Snacker"
        [229852] = {L[229852], 84802, {62.6, 88.8}}, --"Coralweaver Calliso"
        [228583] = {L[228583], 84800, {64.2, 86.8}}, --"Chef Chum Platter"
        [227545] = {L[227545], 84792, {33.6, 74.6}}, --"Ikir the Flotsurge"
        [228201] = {L[228201], 85669, {58.8, 67.4}}, --"Gravesludge"
        [228154] = {L[228154], 84795, {35.4, 72.6}}, --"Bloodbrine"
        [228601] = {L[228601], 84801, {53.8, 35.8}}, --"Ghostmaker"
        [228159] = {L[228159], 84797, {49.0, 16.8}}, --"Gunnlod the Sea-Drinker"
        [228151] = {L[228151], 84794, {47.6, 75.8}}, --"Wreckwater"
        [229853] = {L[229853], 84803, {56.6, 84.6}}, --"Siris the Sea Scorpion"
        [228580] = {L[228580], 84799, {61.2, 94.2}}, --"Plank-Master Bluebelly"
        [230137] = {L[230137], 84805, {64.0, 87.8}}, --"Asbjorn the Bloodsoaked"
        
        -- Seafury tempest rares.
        [231356] = {L[231356], 85404, {56.6, 81.4}}, --"Brinebough"
        [231357] = {L[231357], 85405, {33.2, 73.6}}, --"Zek'ul the Shipbreaker"
        [231368] = {L[231368], 85406, {44.49, 22.70}}, --"Ksvir the Forgotten"
        [231353] = {L[231353], 85403, {41.89, 60.04}}, --"Tempest Talon"
        [228547] = {L[228547], 84798, nil}, --"Slaughtershell"
    },
    ["FindMatchForText"] = function(self, text)
        -- Check whether the chat message matches one of the known annoucements.
        for designation, npc_id in pairs(siren_isle_rare_announcements) do
            if text:find(designation) then
                self:ProcessEntityAlive(npc_id, npc_id, nil, nil, false)
                return
            end
        end
    end
})

RareTracker.RegisterRaresForModule({
    -- Define the zone(s) in which the rares are present.
    ["target_zones"] = {2346},
    ["zone_name"] = "Undermine",
    ["plugin_name"] = "Undermine",
    ["plugin_name_abbreviation"] = "TheWarWithin",
    ["entities"] = {
        --npc_id = {name, quest_id, coordinates}
        [230931] = {L[230931], 84917, {68.8, 80.4}}, --"Scrap Beak"
        [230940] = {L[230940], 84919, {36.7, 45.5}}, --"Tally Doublespeak"
        [230946] = {L[230946], 84920, {38.0, 78.9}}, --"V.V. Goosworth"
        [230979] = {L[230979], 84922, {41.1, 25.6}}, --"S.A.L."
        [231012] = {L[231012], 84927, {42.3, 77.3}}, --"Candy Stickemup"
        [231288] = {L[231288], 85004, {41.4, 44.0}}, --"Swigs Farsight"
        [230793] = {L[230793], 84884, {64.2, 50.4}}, --"The Junk-Wall"
        [230828] = {L[230828], 84907, {57.5, 86.6}}, --"Chief Foreman Gutso"
        [234480] = {L[234480], 86298, {39.8, 22.2}}, --"M.A.G.N.O."
        [233471] = {L[233471], 85778, {57.2, 78.6}}, --"Scrapchewer"
        [231310] = {L[231310], 85010, {40.9, 92.0}}, --"Darkfuse Precipitant"
        [230934] = {L[230934], 84918, {25.8, 35.6}}, --"Ratspit"
        [230947] = {L[230947], 84920, {38.0, 78.9}}, --"Slimesby"
        [230951] = {L[230951], 84921, {54.6, 50.6}}, --"Thwack"
        [230995] = {L[230995], 84926, {47.0, 55.1}}, --"Nitro"
        [231017] = {L[231017], 84928, {66.9, 33.6}}, --"Grimewick"
        [230746] = {L[230746], 84877, {25.6, 68.4}}, --"Ephemeral Agent Lathyd"
        [230800] = {L[230800], 84895, {52.0, 41.2}}, --"Slugger the Smart"
        [230840] = {L[230840], 84911, {61.9, 10.3}}, --"Flyboy Snooty"
        [234499] = {L[234499], 86307, {31.1, 75.5}}, --"Giovante"
        [233472] = {L[233472], 85777, {63.2, 26.0}}, --"Volstrike the Charged"
        [234621] = {L[234621], 87007, nil}, --"Gallagio"
    }
})

RareTracker.RegisterRaresForModule({
    -- Define the zone(s) in which the rares are present.
    ["target_zones"] = {2371, 2472},
    ["zone_name"] = "K'aresh",
    ["plugin_name"] = "K'aresh",
    ["plugin_name_abbreviation"] = "TheWarWithin",
    ["entities"] = {
        --npc_id = {name, quest_id, coordinates}
        [232098] = {L[232098], 90587, {77.0, 74.9}}, --"Chowdar"
        [238540] = {L[238540], 90698, {71.1, 56.9}}, --"Grubber"
        [232128] = {L[232128], 90596, {63.8, 44.3}}, --"Ixthar the Unblinking"
        [245997] = {L[245997], 91275, {53.8, 59.2}}, --"Malek'ta"
        [232108] = {L[232108], 90588, {55.7, 52.1}}, --"Morgil the Netherspawn"
        [232182] = {L[232182], 90590, {46.0, 24.2}}, --"Prototype MK-V"
        [232006] = {L[232006], 90585, {73.5, 55.1}}, --"Sha'ryth the Cursed"
        [232193] = {L[232193], 90592, {76.7, 42.2}}, --"Stalker of the Wastes"
        [232111] = {L[232111], 90589, {51.8, 58.6}}, --"The Nightreaver"
        [232199] = {L[232199], 90584, {65.1, 49.9}}, --"Xarran the Binder"
        [241956] = {L[241956], 90696, {34.7, 36.1}}, --"Arcana-Monger So'zer"
        [245998] = {L[245998], 91276, {75.4, 30.4}}, --"Heka'tamos"
        [232077] = {L[232077], 90586, {66.0, 43.5}}, --"Korgorath the Ravager"
        [231981] = {L[231981], 90594, {54.4, 54.4}}, --"Maw of the Sands"
        [232127] = {L[232127], 90595, {52.7, 20.5}}, --"Orith the Dreadful"
        [232189] = {L[232189], 90591, {50.4, 64.4}}, --"Revenant of the Wasteland"
        [232129] = {L[232129], 90583, {51.4, 49.5}}, --"Shadowhowl"
        [234845] = {L[234845], 91293, {73.8, 32.9}}, --"Sthaarbs"
        [232195] = {L[232195], 90593, {70.2, 49.9}}, --"Urmag"
        
        [238144] = {L[238144], 90687, {49.0, 28.6}}, --"Shatterpulse"
        [238536] = {L[238536], 90689, {48.4, 16.8}}, --"Hollowbane"
        [241920] = {L[241920], 90692, {42.6, 57.6}}, --"Purple Peat"
        [238384] = {L[238384], 90694, {32.8, 58.6}}, --"Xy'vox The Twisted"
        
    }
})

