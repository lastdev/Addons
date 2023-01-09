-- Get an object we can use for the localization of the addon.
local L = LibStub("AceLocale-3.0"):GetLocale("RareTracker", true)

-- Overwrite the language of entities to english if enforced.
if RareTracker.db.global.window.force_display_in_english then
    L[193632] = "Wilrive"
    L[194270] = "Arcane Devourer"
    L[191356] = "Frostpaw"
    L[194392] = "Brackle"
    L[194210] = "Azure Pathfinder"
    L[193225] = "Notfar the Unbearable"
    L[190244] = "Mahg the Trampler"
    L[193251] = "Gruffy"
    L[193693] = "Rusthide"
    L[193691] = "Fisherman Tinnak"
    L[193708] = "Skald the Impaler"
    L[193735] = "Moth'go Deeploom"
    L[193167] = "Swagraal the Swollen"
    L[193178] = "Blightfur"
    L[197344] = "Snarglebone"
    L[197354] = "Gnarls"
    L[197371] = "Ravenous Tundra Bear"
    L[193157] = "Dragonhunter Gorund"
    L[198004] = "Mange the Outcast"
    L[193201] = "Mucka the Raker"
    L[193698] = "Frigidpelt Den Mother"
    L[193116] = "Beogoka"
    L[193259] = "Blue Terror"
    L[193149] = "Skag the Thrower"
    L[193269] = "Grumbletrunk"
    L[193196] = "Trilvarus Loreweaver"
    L[193706] = "Snufflegust"
    L[193710] = "Seereel, the Spring"
    L[193634] = "Swog'ranka"
    L[197557] = "Bisquius"
    L[193238] = "Spellwrought Snowman"
    L[197353] = "Blisterhide"
    L[197356] = "High Shaman Rotknuckle"
    L[197411] = "Astray Splasher"
        
    L[193259] = "Blue Terror"
        
    L[195353] = "Breezebiter"

    -- The Ohnahran Plains
    L[193165] = "Sparkspitter Vrak"
    L[193142] = "Enraged Sapphire"
    L[193209] = "Zenet Avis"
    L[189652] = "Deadwaker Ghendish"
    L[193173] = "Mikrin of the Raging Winds"
    L[193123] = "Steamgill"
    L[193235] = "Oshigol"
    L[192045] = "Windseeker Avash"
    L[193140] = "Zarizz"
    L[187559] = "Shade of Grief"
    L[187781] = "Hamett"
    L[188124] = "Irontree"
    L[191842] = "Sulfurion"
    L[195204] = "The Jolly Giant"
    L[192453] = "Vaniik the Stormtouched"
    L[195186] = "Cinta the Forgotten"
    L[195409] = "Makhra the Ashtouched"
    L[196350] = "Old Stormhide"
    L[193136] = "Scav Notail"
    L[193188] = "Seeker Teryx"
    L[197009] = "Liskheszaera"
    L[196010] = "Researcher Sneakwing"
    L[193227] = "Ronsak the Decimator"
    L[193212] = "Malsegan"
    L[193170] = "Fulgurb"
    L[192020] = "Eaglemaster Niraak"
    L[193215] = "Scaleseeker Mezeri"
    L[187219] = "Nokhud Warmaster"
    L[188095] = "Hunter of Deep"
    L[188451] = "Zerimek"
    L[191950] = "Porta the Overgrown"
    L[192364] = "Windscale the Stormborn"
    L[192557] = "Quackers the Terrible"
    L[195223] = "Rustlily"
    L[196334] = "The Great Enla"
    
    L[195895] = "Nergazurai"
    L[192557] = "Quackers the Terrible"
    L[193209] = "Zenet Avis"

    -- Thaldraszus
    L[193143] = "Razk'vex the Untamed"
    L[193128] = "Blightpaw the Depraved"
    L[193125] = "Goremaul the Gluttonous"
    L[193246] = "Matriarch Remalla"
    L[193258] = "Tempestrian"
    L[193234] = "Eldoren the Reborn"
    L[193220] = "Broodweaver Araznae"
    L[193666] = "Rokmur"
    L[183984] = "The Weeping Vilomah"
    L[191305] = "The Great Shellkhan"
    L[193241] = "Lord Epochbrgl"
    L[193126] = "Innumerable Ruination"
    L[193130] = "Pleasant Alpha"
    L[193688] = "Phenran"
    L[193210] = "Phleep"
    L[193146] = "Treasure-Mad Trambladd"
    L[193240] = "Riverwalker Tamopo"
    L[193176] = "Sandana the Tempest"
    L[193161] = "Woolfang"
    L[193663] = "Craggravated Elemental"
    L[193658] = "Corrupted Proto-Dragon"
    L[193664] = "Ancient Protector"
        
    L[193273] = "Liskron the Dazzling"
    L[193234] = "Eldoren the Reborn"

    -- The Waking Shores
    L[196056] = "Gushgut the Beaksinker"
    L[187945] = "Anhydros the Tidetaker"
    L[199645] = "Helmet Missingway"
    L[193217] = "Drakewing"
    L[193135] = "Azra's Prized Peony"
    L[193118] = "O'nank Shorescour"
    L[193132] = "Amethyzar the Glittering"
    L[193152] = "Massive Magmashell"
    L[193134] = "Enkine the Voracious"
    L[192362] = "Possessive Hornswog"
    L[190985] = "Death's Shadow"
    L[193266] = "Lepidoralia the Resplendent"
    L[187598] = "Rohzor Forgesmash"
    L[190986] = "Battlehorn Pyrhus"
    L[193232] = "Rasnar the War Ender"
    L[193271] = "Shadeslash Trakken"
    L[193256] = "Nulltheria the Void Gazer"
    L[193181] = "Skewersnout"
    L[192738] = "Brundin the Dragonbane"
    L[193148] = "Thunderous Matriarch"
    L[193228] = "Snappy"
    L[193120] = "Smogswog the Firebreather"
    L[186827] = "Magmaton"
    L[193154] = "Forgotten Gryphon"
    L[193198] = "Captain Lancer"
    L[186859] = "Worldcarver A'tir"
    L[189822] = "Shas'ith"
    L[186783] = "Cauldronbearer Blakor"
    L[187886] = "Turboris"
    L[190991] = "Char"
    L[187306] = "Morchok"
    L[193175] = "Slurpo, the Incredible Snail"
        
    L[193217] = "Drakewing"
    L[193154] = "Forgotten Gryphon"
end

RareTracker.RegisterRaresForModule({
    -- Define the zone(s) in which the rares are present.
    ["target_zones"] = {2024},
    ["zone_name"] = "The Azure Span",
    ["plugin_name"] = "The Azure Span",
    ["plugin_name_abbreviation"] = "Dragonflight",
    ["entities"] = {
        --npc_id = {name, quest_id, coordinates}
        [193632] = {L[193632], nil, nil}, --"Wilrive"
        [194270] = {L[194270], nil, nil}, --"Arcane Devourer"
        [191356] = {L[191356], nil, nil}, --"Frostpaw"
        [194392] = {L[194392], 70165, nil}, --"Brackle"
        [194210] = {L[194210], 73867, nil}, --"Azure Pathfinder"
        [193225] = {L[193225], 73887, nil}, --"Notfar the Unbearable"
        [190244] = {L[190244], 73883, nil}, --"Mahg the Trampler"
        [193251] = {L[193251], 69885, nil}, --"Gruffy"
        [193693] = {L[193693], nil, nil}, --"Rusthide"
        [193691] = {L[193691], nil, nil}, --"Fisherman Tinnak"
        [193708] = {L[193708], nil, nil}, --"Skald the Impaler"
        [193735] = {L[193735], nil, nil}, --"Moth'go Deeploom"
        [193167] = {L[193167], nil, nil}, --"Swagraal the Swollen"
        [193178] = {L[193178], 69858, nil}, --"Blightfur"
        [197344] = {L[197344], 74032, nil}, --"Snarglebone"
        [197354] = {L[197354], 73996, nil}, --"Gnarls"
        [197371] = {L[197371], nil, nil}, --"Ravenous Tundra Bear"
        [193157] = {L[193157], 73873, nil}, --"Dragonhunter Gorund"
        [198004] = {L[198004], nil, nil}, --"Mange the Outcast"
        [193201] = {L[193201], nil, nil}, --"Mucka the Raker"
        [193698] = {L[193698], 69985, nil}, --"Frigidpelt Den Mother"
        [193116] = {L[193116], nil, nil}, --"Beogoka"
        [193259] = {L[193259], 73870, nil}, --"Blue Terror"
        [193149] = {L[193149], 72154, nil}, --"Skag the Thrower"
        [193269] = {L[193269], 69892, nil}, --"Grumbletrunk"
        [193196] = {L[193196], 69861, nil}, --"Trilvarus Loreweaver"
        [193706] = {L[193706], nil, nil}, --"Snufflegust"
        [193710] = {L[193710], nil, nil}, --"Seereel, the Spring"
        [193634] = {L[193634], nil, nil}, --"Swog'ranka"
        [197557] = {L[197557], 74097, nil}, --"Bisquius"
        [193238] = {L[193238], nil, nil}, --"Spellwrought Snowman"
        [197353] = {L[197353], 73985, nil}, --"Blisterhide"
        [197356] = {L[197356], 74004, nil}, --"High Shaman Rotknuckle"
        [197411] = {L[197411], nil, nil}, --"Astray Splasher"
        
        [193259] = {L[193259], nil, nil}, --"Blue Terror"
        
        [195353] = {L[195353], nil, nil}, --"Breezebiter"
        
    }
})

RareTracker.RegisterRaresForModule({
    -- Define the zone(s) in which the rares are present.
    ["target_zones"] = {2023},
    ["zone_name"] = "Ohn'ahran Plains",
    ["plugin_name"] = "Ohn'ahran Plains",
    ["plugin_name_abbreviation"] = "Dragonflight",
    ["entities"] = {
        --npc_id = {name, quest_id, coordinates}
        [193165] = {L[193165], 73896, nil}, --"Sparkspitter Vrak"
        [193142] = {L[193142], 69840, nil}, --"Enraged Sapphire"
        [193209] = {L[193209], nil, nil}, --"Zenet Avis"
        [189652] = {L[189652], nil, nil}, --"Deadwaker Ghendish"
        [193173] = {L[193173], 69857, nil}, --"Mikrin of the Raging Winds"
        [193123] = {L[193123], 69667, nil}, --"Steamgill"
        [193235] = {L[193235], 69877, nil}, --"Oshigol"
        [192045] = {L[192045], 74088, nil}, --"Windseeker Avash"
        [193140] = {L[193140], 72364, nil}, --"Zarizz"
        [187559] = {L[187559], 74075, nil}, --"Shade of Grief"
        [187781] = {L[187781], nil, nil}, --"Hamett"
        [188124] = {L[188124], 73967, nil}, --"Irontree"
        [191842] = {L[191842], nil, nil}, --"Sulfurion"
        [195204] = {L[195204], nil, nil}, --"The Jolly Giant"
        [192453] = {L[192453], nil, nil}, --"Vaniik the Stormtouched"
        [195186] = {L[195186], nil, nil}, --"Cinta the Forgotten"
        [195409] = {L[195409], 73968, nil}, --"Makhra the Ashtouched"
        [196350] = {L[196350], nil, nil}, --"Old Stormhide"
        [193136] = {L[193136], 69863, nil}, --"Scav Notail"
        [193188] = {L[193188], nil, nil}, --"Seeker Teryx"
        [197009] = {L[197009], nil, nil}, --"Liskheszaera"
        [196010] = {L[196010], 70689, nil}, --"Researcher Sneakwing"
        [193227] = {L[193227], 69878, nil}, --"Ronsak the Decimator"
        [193212] = {L[193212], 69871, nil}, --"Malsegan"
        [193170] = {L[193170], 69856, nil}, --"Fulgurb"
        [192020] = {L[192020], 74063, nil}, --"Eaglemaster Niraak"
        [193215] = {L[193215], nil, nil}, --"Scaleseeker Mezeri"
        [187219] = {L[187219], nil, nil}, --"Nokhud Warmaster"
        [188095] = {L[188095], 73966, nil}, --"Hunter of Deep"
        [188451] = {L[188451], 73980, nil}, --"Zerimek"
        [191950] = {L[191950], nil, nil}, --"Porta the Overgrown"
        [192364] = {L[192364], nil, nil}, --"Windscale the Stormborn"
        [192557] = {L[192557], nil, nil}, --"Quackers the Terrible"
        [195223] = {L[195223], nil, nil}, --"Rustlily"
        [196334] = {L[196334], nil, nil}, --"The Great Enla"
        
        [195895] = {L[195895], nil, nil}, --"Nergazurai"
        [192557] = {L[192557], nil, nil}, --"Quackers the Terrible"
        [193209] = {L[193209], nil, nil}, --"Zenet Avis"
    }
})

RareTracker.RegisterRaresForModule({
    -- Define the zone(s) in which the rares are present.
    ["target_zones"] = {2025},
    ["zone_name"] = "Thaldraszus",
    ["plugin_name"] = "Thaldraszus",
    ["plugin_name_abbreviation"] = "Dragonflight",
    ["entities"] = {
        --npc_id = {name, quest_id, coordinates}
        [193143] = {L[193143], 69853, nil}, --"Razk'vex the Untamed"
        [193128] = {L[193128], 73869, nil}, --"Blightpaw the Depraved"
        [193125] = {L[193125], nil, nil}, --"Goremaul the Gluttonous"
        [193246] = {L[193246], 69883, nil}, --"Matriarch Remalla"
        [193258] = {L[193258], 69886, nil}, --"Tempestrian"
        [193234] = {L[193234], 69875, nil}, --"Eldoren the Reborn"
        [193220] = {L[193220], 69868, nil}, --"Broodweaver Araznae"
        [193666] = {L[193666], 69966, nil}, --"Rokmur"
        [183984] = {L[183984], 74086, nil}, --"The Weeping Vilomah"
        [191305] = {L[191305], 72121, nil}, --"The Great Shellkhan"
        [193241] = {L[193241], 69882, nil}, --"Lord Epochbrgl"
        [193126] = {L[193126], nil, nil}, --"Innumerable Ruination"
        [193130] = {L[193130], nil, nil}, --"Pleasant Alpha"
        [193688] = {L[193688], 69976, nil}, --"Phenran"
        [193210] = {L[193210], 74021, nil}, --"Phleep"
        [193146] = {L[193146], 70947, nil}, --"Treasure-Mad Trambladd"
        [193240] = {L[193240], 69880, nil}, --"Riverwalker Tamopo"
        [193176] = {L[193176], 69859, nil}, --"Sandana the Tempest"
        [193161] = {L[193161], 74089, nil}, --"Woolfang"
        [193663] = {L[193663], 74061, nil}, --"Craggravated Elemental"
        [193658] = {L[193658], 74060, nil}, --"Corrupted Proto-Dragon"
        [193664] = {L[193664], 74055, nil}, --"Ancient Protector"
        
        [193273] = {L[193273], nil, nil}, --"Liskron the Dazzling"
        [193234] = {L[193234], nil, nil}, --"Eldoren the Reborn"
    }
})

RareTracker.RegisterRaresForModule({
    -- Define the zone(s) in which the rares are present.
    ["target_zones"] = {2022},
    ["zone_name"] = "The Waking Shores",
    ["plugin_name"] = "The Waking Shores",
    ["plugin_name_abbreviation"] = "Dragonflight",
    ["entities"] = {
        --npc_id = {name, quest_id, coordinates}
        [196056] = {L[196056], nil, nil}, --"Gushgut the Beaksinker"
        [187945] = {L[187945], nil, nil}, --"Anhydros the Tidetaker"
        [199645] = {L[199645], nil, nil}, --"Helmet Missingway"
        [193217] = {L[193217], nil, nil}, --"Drakewing"
        [193135] = {L[193135], 69839, nil}, --"Azra's Prized Peony"
        [193118] = {L[193118], 70983, nil}, --"O'nank Shorescour"
        [193132] = {L[193132], 69838, nil}, --"Amethyzar the Glittering"
        [193152] = {L[193152], 69848, nil}, --"Massive Magmashell"
        [193134] = {L[193134], 73072, nil}, --"Enkine the Voracious"
        [192362] = {L[192362], 67048, nil}, --"Possessive Hornswog"
        [190985] = {L[190985], 73074, nil}, --"Death's Shadow"
        [193266] = {L[193266], 69891, nil}, --"Lepidoralia the Resplendent"
        [187598] = {L[187598], 74052, nil}, --"Rohzor Forgesmash"
        [190986] = {L[190986], 74040, nil}, --"Battlehorn Pyrhus"
        [193232] = {L[193232], 74051, nil}, --"Rasnar the War Ender"
        [193271] = {L[193271], 74076, nil}, --"Shadeslash Trakken"
        [193256] = {L[193256], 72103, nil}, --"Nulltheria the Void Gazer"
        [193181] = {L[193181], nil, nil}, --"Skewersnout"
        [192738] = {L[192738], nil, nil}, --"Brundin the Dragonbane"
        [193148] = {L[193148], 69841, nil}, --"Thunderous Matriarch"
        [193228] = {L[193228], nil, nil}, --"Snappy"
        [193120] = {L[193120], 69668, nil}, --"Smogswog the Firebreather"
        [186827] = {L[186827], 70979, nil}, --"Magmaton"
        [193154] = {L[193154], 72130, nil}, --"Forgotten Gryphon"
        [193198] = {L[193198], 72127, nil}, --"Captain Lancer"
        [186859] = {L[186859], 74090, nil}, --"Worldcarver A'tir"
        [189822] = {L[189822], 74077, nil}, --"Shas'ith"
        [186783] = {L[186783], 74042, nil}, --"Cauldronbearer Blakor"
        [187886] = {L[187886], 74054, nil}, --"Turboris"
        [190991] = {L[190991], 74043, nil}, --"Char"
        [187306] = {L[187306], 74067, nil}, --"Morchok"
        [193175] = {L[193175], 74079, nil}, --"Slurpo, the Incredible Snail"
        
        [193217] = {L[193217], nil, nil}, --"Drakewing"
        [193154] = {L[193154], nil, nil}, --"Forgotten Gryphon"
    }
})
