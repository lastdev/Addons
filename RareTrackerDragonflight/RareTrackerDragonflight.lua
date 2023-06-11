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
    
    L[186200] = "Harkyn Grymstone"
    
    -- Stormed off
    L[193648] = "Infernum"
    L[193644] = "Bouldron"
    L[193686] = "Neela Firebane"
    L[193680] = "Zurgaz Corebreaker"
    L[193652] = "Grizzlerock"
    L[193675] = "Kain Firebrand"
    L[193678] = "Fieraan"
    L[193653] = "Gaelzion"
    L[193650] = "Emblazion"
    L[193645] = "Crystalus"
    L[193647] = "Karantun"
    L[193682] = "Rouen Icewind"
    L[193684] = "Pipspark Thundersnap"
    L[193674] = "Voraazka"
    L[193677] = "Maeleera"
    L[193679] = "Leerain"
    L[193654] = "Gravlion"
    L[193655] = "Frozion"
    
    -- The Forbidden Reach
    L[200584] = "Vraken the Hunter"
    L[200579] = "Ishyra"
    L[200610] = "Duzalgor"
    L[200717] = "Galakhad"
    L[200885] = "Lady Shaz'ra"
    L[201181] = "Mad-Eye Carrey"
    L[200960] = "Warden Entrix"
    L[200978] = "Pyrachniss"
    L[200619] = "Tectonus"
    L[200621] = "Manathema"
    L[200722] = "Gareed"
    L[200730] = "Tidesmith Zarviss"
    L[200738] = "Kangalo"
    L[200740] = "Agni Blazehoof"
    L[200743] = "Amephyst"
    L[200537] = "Gahz'raxes"
    L[200600] = "Reisa the Drowned"
    L[200681] = "Bonesifter Marwak"
    L[200721] = "Grugoth the Hullcrusher"
    L[200904] = "Veltrax"
    L[201013] = "Wyrmslayer Angvardi"
    L[200956] = "Ookbeard"
    L[200911] = "Volcanakk"
    L[200620] = "Sir Pinchalot"
    L[200622] = "Snarfang"
    L[200725] = "Faunos"
    L[200737] = "Arcantrix"
    L[200739] = "Fimbol"
    L[200742] = "Luttrok"
    L[203353] = "Loot Specialist"
    
    -- Zaralek Cavern
    L[203515] = "Alcanon"
    L[203621] = "Brullo the Strong"
    L[203664] = "Emberdusk"
    L[203592] = "General Zskorro"
    L[203611] = "Hadexia"
    L[203646] = "Dinn" -- Jrumm
    L[203466] = "Kaprachu"
    L[203462] = "Kob'rok"
    L[203630] = "Lavermix"
    L[203521] = "Professor Gastrinax"
    L[203643] = "Skornak"
    L[203662] = "Subterrax"
    L[201029] = "Veridian King"
    L[203468] = "Aquifon"
    L[204093] = "Colossian"
    L[203660] = "Flowfy"
    L[203477] = "Goopal"
    L[203627] = "Invoq" -- Invohq
    L[203625] = "Karokta" -- Kairoktra
    L[203618] = "Klakatak"
    L[203642] = "Kronkapace"
    L[200111] = "Magtembo" -- Magmanesha
    L[204096] = "Shadowforge Mole Machine"
    L[203480] = "Spinmarrow"
    L[203593] = "Underlight Queen"
end

-- Special category for elemental storms
local categorized_rare_ids = {
    ["Primal Storms"] = {
        193648, 193644, 193686, 193680, 193652, 193675, 193678, 193653, 193650, 
        193645, 193647, 193682, 193674, 193674, 193677, 193679, 193654, 193655
    }
}

RareTracker.RegisterRaresForModule({
    -- Define the zone(s) in which the rares are present.
    ["target_zones"] = {2024},
    ["zone_name"] = "The Azure Span",
    ["plugin_name"] = "The Azure Span",
    ["plugin_name_abbreviation"] = "Dragonflight",
    ["entities"] = {
        --npc_id = {name, quest_id, coordinates}
        [193632] = {L[193632], 73900, nil}, --"Wilrive"
        [194270] = {L[194270], 73866, nil}, --"Arcane Devourer"
        [191356] = {L[191356], 73877, nil}, --"Frostpaw"
        [194392] = {L[194392], 73871, nil}, --"Brackle"
        [194210] = {L[194210], 73867, nil}, --"Azure Pathfinder"
        [193225] = {L[193225], 73887, nil}, --"Notfar the Unbearable"
        [190244] = {L[190244], 73883, nil}, --"Mahg the Trampler"
        [193251] = {L[193251], 74001, nil}, --"Gruffy"
--        [193693] = {L[193693], nil, nil}, --"Rusthide"
        [193691] = {L[193691], 72254, nil}, --"Fisherman Tinnak"
        [193708] = {L[193708], 74078, nil}, --"Skald the Impaler"
        [193735] = {L[193735], 74068, nil}, --"Moth'go Deeploom"
        [193167] = {L[193167], nil, nil}, --"Swagraal the Swollen"
        [193178] = {L[193178], 74058, nil}, --"Blightfur"
        [197344] = {L[197344], 74032, nil}, --"Snarglebone"
        [197354] = {L[197354], 73996, nil}, --"Gnarls"
        [197371] = {L[197371], 73891, nil}, --"Ravenous Tundra Bear"
        [193157] = {L[193157], 73873, nil}, --"Dragonhunter Gorund"
        [198004] = {L[198004], 73884, nil}, --"Mange the Outcast"
        [193201] = {L[193201], 73885, nil}, --"Mucka the Raker"
        [193698] = {L[193698], 73876, nil}, --"Frigidpelt Den Mother"
        [193116] = {L[193116], 73868, nil}, --"Beogoka"
        [193259] = {L[193259], 73870, nil}, --"Blue Terror"
        [193149] = {L[193149], 74030, nil}, --"Skag the Thrower"
        [193269] = {L[193269], 74002, nil}, --"Grumbletrunk"
        [193196] = {L[193196], 74087, nil}, --"Trilvarus Loreweaver"
        [193706] = {L[193706], nil, nil}, --"Snufflegust"
        [193710] = {L[193710], nil, nil}, --"Seereel, the Spring"
        [193634] = {L[193634], nil, nil}, --"Swog'ranka"
        [197557] = {L[197557], 74097, nil}, --"Bisquius"
        [193238] = {L[193238], 74082, nil}, --"Spellwrought Snowman"
        [197353] = {L[197353], 73985, nil}, --"Blisterhide"
        [197356] = {L[197356], 74004, nil}, --"High Shaman Rotknuckle"
        [197411] = {L[197411], 74057, nil}, --"Astray Splasher"
        
        [193259] = {L[193259], nil, nil}, --"Blue Terror"
        [195353] = {L[195353], nil, nil}, --"Breezebiter"
        
        [193648] = {L[193648], nil, nil}, --"Infernum"
        [193644] = {L[193644], nil, nil}, --"Bouldron"
        [193686] = {L[193686], nil, nil}, --"Neela Firebane"
        [193680] = {L[193680], nil, nil}, --"Zurgaz Corebreaker"
        [193652] = {L[193652], nil, nil}, --"Grizzlerock"
        [193675] = {L[193675], nil, nil}, --"Kain Firebrand"
        [193678] = {L[193678], nil, nil}, --"Fieraan"
        [193653] = {L[193653], nil, nil}, --"Gaelzion"
        [193650] = {L[193650], nil, nil}, --"Emblazion"
        [193645] = {L[193645], nil, nil}, --"Crystalus"
        [193647] = {L[193647], nil, nil}, --"Karantun"
        [193682] = {L[193682], nil, nil}, --"Rouen Icewind"
        [193684] = {L[193684], nil, nil}, --"Pipspark Thundersnap"
        [193674] = {L[193674], nil, nil}, --"Voraazka"
        [193677] = {L[193677], nil, nil}, --"Maeleera"
        [193679] = {L[193679], nil, nil}, --"Leerain"
        [193654] = {L[193654], nil, nil}, --"Gravlion"
        [193655] = {L[193655], nil, nil}, --"Frozion"
    },
    ["special_categories"] = categorized_rare_ids
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
        [193142] = {L[193142], 73875, nil}, --"Enraged Sapphire"
        [193209] = {L[193209], nil, nil}, --"Zenet Avis"
        [189652] = {L[189652], 73872, nil}, --"Deadwaker Ghendish"
        [193173] = {L[193173], 74015, nil}, --"Mikrin of the Raging Winds"
        [193123] = {L[193123], 74034, nil}, --"Steamgill"
        [193235] = {L[193235], 74018, nil}, --"Oshigol"
        [192045] = {L[192045], 74088, nil}, --"Windseeker Avash"
        [193140] = {L[193140], 74091, nil}, --"Zarizz"
        [187559] = {L[187559], 74075, nil}, --"Shade of Grief"
        [187781] = {L[187781], 73951, nil}, --"Hamett"
        [188124] = {L[188124], 73967, nil}, --"Irontree"
        [191842] = {L[191842], 73974, nil}, --"Sulfurion"
        [195204] = {L[195204], 73976, nil}, --"The Jolly Giant"
        [192453] = {L[192453], 73978, nil}, --"Vaniik the Stormtouched"
        [195186] = {L[195186], 73950, nil}, --"Cinta the Forgotten"
        [195409] = {L[195409], 73968, nil}, --"Makhra the Ashtouched"
        [196350] = {L[196350], nil, nil}, --"Old Stormhide"
        [193136] = {L[193136], 73893, nil}, --"Scav Notail"
        [193188] = {L[193188], 73894, nil}, --"Seeker Teryx"
        [197009] = {L[197009], 73882, nil}, --"Liskheszaera"
        [196010] = {L[196010], 74023, nil}, --"Researcher Sneakwing"
        [193227] = {L[193227], 74026, nil}, --"Ronsak the Decimator"
        [193212] = {L[193212], 74011, nil}, --"Malsegan"
        [193170] = {L[193170], 73994, nil}, --"Fulgurb"
        [192020] = {L[192020], 74063, nil}, --"Eaglemaster Niraak"
        [193215] = {L[193215], 74073, nil}, --"Scaleseeker Mezeri"
        [187219] = {L[187219], nil, nil}, --"Nokhud Warmaster"
        [188095] = {L[188095], 73966, nil}, --"Hunter of Deep"
        [188451] = {L[188451], 73980, nil}, --"Zerimek"
        [191950] = {L[191950], 73971, nil}, --"Porta the Overgrown"
        [192364] = {L[192364], 73979, nil}, --"Windscale the Stormborn"
        [192557] = {L[192557], nil, nil}, --"Quackers the Terrible"
        [195223] = {L[195223], 73973, nil}, --"Rustlily"
        [196334] = {L[196334], nil, nil}, --"The Great Enla"
        
        [195895] = {L[195895], nil, nil}, --"Nergazurai"
        [192557] = {L[192557], 73972, nil}, --"Quackers the Terrible"
        [193209] = {L[193209], 73901, nil}, --"Zenet Avis"
        
        [193648] = {L[193648], nil, nil}, --"Infernum"
        [193644] = {L[193644], nil, nil}, --"Bouldron"
        [193686] = {L[193686], nil, nil}, --"Neela Firebane"
        [193680] = {L[193680], nil, nil}, --"Zurgaz Corebreaker"
        [193652] = {L[193652], nil, nil}, --"Grizzlerock"
        [193675] = {L[193675], nil, nil}, --"Kain Firebrand"
        [193678] = {L[193678], nil, nil}, --"Fieraan"
        [193653] = {L[193653], nil, nil}, --"Gaelzion"
        [193650] = {L[193650], nil, nil}, --"Emblazion"
        [193645] = {L[193645], nil, nil}, --"Crystalus"
        [193647] = {L[193647], nil, nil}, --"Karantun"
        [193682] = {L[193682], nil, nil}, --"Rouen Icewind"
        [193684] = {L[193684], nil, nil}, --"Pipspark Thundersnap"
        [193674] = {L[193674], nil, nil}, --"Voraazka"
        [193677] = {L[193677], nil, nil}, --"Maeleera"
        [193679] = {L[193679], nil, nil}, --"Leerain"
        [193654] = {L[193654], nil, nil}, --"Gravlion"
        [193655] = {L[193655], nil, nil}, --"Frozion"
    },
    ["special_categories"] = categorized_rare_ids
})

RareTracker.RegisterRaresForModule({
    -- Define the zone(s) in which the rares are present.
    ["target_zones"] = {2025},
    ["zone_name"] = "Thaldraszus",
    ["plugin_name"] = "Thaldraszus",
    ["plugin_name_abbreviation"] = "Dragonflight",
    ["entities"] = {
        --npc_id = {name, quest_id, coordinates}
        [193143] = {L[193143], 73892, nil}, --"Razk'vex the Untamed"
        [193128] = {L[193128], 74096, nil}, --"Blightpaw the Depraved"
        [193125] = {L[193125], 73878, nil}, --"Goremaul the Gluttonous"
        [193246] = {L[193246], 74013, nil}, --"Matriarch Remalla"
        [193258] = {L[193258], 74035, nil}, --"Tempestrian"
        [193234] = {L[193234], 69875, nil}, --"Eldoren the Reborn"
        [193220] = {L[193220], 73987, nil}, --"Broodweaver Araznae"
        [193666] = {L[193666], 74025, nil}, --"Rokmur"
        [183984] = {L[183984], 74086, nil}, --"The Weeping Vilomah"
        [191305] = {L[191305], 74085, nil}, --"The Great Shellkhan"
        [193241] = {L[193241], 74066, nil}, --"Lord Epochbrgl"
        [193126] = {L[193126], 73881, nil}, --"Innumerable Ruination"
        [193130] = {L[193130], 73889, nil}, --"Pleasant Alpha"
        [193688] = {L[193688], 74020, nil}, --"Phenran"
        [193210] = {L[193210], 74021, nil}, --"Phleep"
        [193146] = {L[193146], 74036, nil}, --"Treasure-Mad Trambladd"
        [193240] = {L[193240], 74024, nil}, --"Riverwalker Tamopo"
        [193176] = {L[193176], 74029, nil}, --"Sandana the Tempest"
        [193161] = {L[193161], 74089, nil}, --"Woolfang"
        [193663] = {L[193663], 74061, nil}, --"Craggravated Elemental"
        [193658] = {L[193658], 74060, nil}, --"Corrupted Proto-Dragon"
        [193664] = {L[193664], 74055, nil}, --"Ancient Protector"
        
        [193273] = {L[193273], 72842, nil}, --"Liskron the Dazzling"
        [193234] = {L[193234], 73990, nil}, --"Eldoren the Reborn"
        
        [193648] = {L[193648], nil, nil}, --"Infernum"
        [193644] = {L[193644], nil, nil}, --"Bouldron"
        [193686] = {L[193686], nil, nil}, --"Neela Firebane"
        [193680] = {L[193680], nil, nil}, --"Zurgaz Corebreaker"
        [193652] = {L[193652], nil, nil}, --"Grizzlerock"
        [193675] = {L[193675], nil, nil}, --"Kain Firebrand"
        [193678] = {L[193678], nil, nil}, --"Fieraan"
        [193653] = {L[193653], nil, nil}, --"Gaelzion"
        [193650] = {L[193650], nil, nil}, --"Emblazion"
        [193645] = {L[193645], nil, nil}, --"Crystalus"
        [193647] = {L[193647], nil, nil}, --"Karantun"
        [193682] = {L[193682], nil, nil}, --"Rouen Icewind"
        [193684] = {L[193684], nil, nil}, --"Pipspark Thundersnap"
        [193674] = {L[193674], nil, nil}, --"Voraazka"
        [193677] = {L[193677], nil, nil}, --"Maeleera"
        [193679] = {L[193679], nil, nil}, --"Leerain"
        [193654] = {L[193654], nil, nil}, --"Gravlion"
        [193655] = {L[193655], nil, nil}, --"Frozion"
    },
    ["special_categories"] = categorized_rare_ids
})

RareTracker.RegisterRaresForModule({
    -- Define the zone(s) in which the rares are present.
    ["target_zones"] = {2022},
    ["zone_name"] = "The Waking Shores",
    ["plugin_name"] = "The Waking Shores",
    ["plugin_name_abbreviation"] = "Dragonflight",
    ["entities"] = {
        --npc_id = {name, quest_id, coordinates}
        [196056] = {L[196056], 73879, nil}, --"Gushgut the Beaksinker"
        [187945] = {L[187945], 73865, nil}, --"Anhydros the Tidetaker"
        [199645] = {L[199645], nil, nil}, --"Helmet Missingway"
        [193217] = {L[193217], nil, nil}, --"Drakewing"
        [193135] = {L[193135], 73984, nil}, --"Azra's Prized Peony"
        [193118] = {L[193118], 74017, nil}, --"O'nank Shorescour"
        [193132] = {L[193132], 73981, nil}, --"Amethyzar the Glittering"
        [193152] = {L[193152], 74012, nil}, --"Massive Magmashell"
        [193134] = {L[193134], 73072, nil}, --"Enkine the Voracious"
        [192362] = {L[192362], 70864, nil}, --"Possessive Hornswog"
        [190985] = {L[190985], 73074, nil}, --"Death's Shadow"
        [193266] = {L[193266], 74065, nil}, --"Lepidoralia the Resplendent"
        [187598] = {L[187598], 74052, nil}, --"Rohzor Forgesmash"
        [190986] = {L[190986], 74040, nil}, --"Battlehorn Pyrhus"
        [193232] = {L[193232], 74051, nil}, --"Rasnar the War Ender"
        [193271] = {L[193271], 74076, nil}, --"Shadeslash Trakken"
        [193256] = {L[193256], 73888, nil}, --"Nulltheria the Void Gazer"
        [193181] = {L[193181], 73895, nil}, --"Skewersnout"
        [192738] = {L[192738], 73890, nil}, --"Brundin the Dragonbane"
        [193148] = {L[193148], 73899, nil}, --"Thunderous Matriarch"
        [193228] = {L[193228], 73997, nil}, --"Snappy"
        [193120] = {L[193120], 74031, nil}, --"Smogswog the Firebreather"
        [186827] = {L[186827], 74010, nil}, --"Magmaton"
        [193154] = {L[193154], 73073, nil}, --"Forgotten Gryphon"
        [193198] = {L[193198], 73075, nil}, --"Captain Lancer"
        [186859] = {L[186859], 74090, nil}, --"Worldcarver A'tir"
        [189822] = {L[189822], 74077, nil}, --"Shas'ith"
        [186783] = {L[186783], 74042, nil}, --"Cauldronbearer Blakor"
        [187886] = {L[187886], 74054, nil}, --"Turboris"
        [190991] = {L[190991], 74043, nil}, --"Char"
        [187306] = {L[187306], 74067, nil}, --"Morchok"
        [193175] = {L[193175], 74079, nil}, --"Slurpo, the Incredible Snail"
        
        [193217] = {L[193217], 73874, nil}, --"Drakewing"
        [193154] = {L[193154], nil, nil}, --"Forgotten Gryphon"
        
        [193648] = {L[193648], nil, nil}, --"Infernum"
        [193644] = {L[193644], nil, nil}, --"Bouldron"
        [193686] = {L[193686], nil, nil}, --"Neela Firebane"
        [193680] = {L[193680], nil, nil}, --"Zurgaz Corebreaker"
        [193652] = {L[193652], nil, nil}, --"Grizzlerock"
        [193675] = {L[193675], nil, nil}, --"Kain Firebrand"
        [193678] = {L[193678], nil, nil}, --"Fieraan"
        [193653] = {L[193653], nil, nil}, --"Gaelzion"
        [193650] = {L[193650], nil, nil}, --"Emblazion"
        [193645] = {L[193645], nil, nil}, --"Crystalus"
        [193647] = {L[193647], nil, nil}, --"Karantun"
        [193682] = {L[193682], nil, nil}, --"Rouen Icewind"
        [193684] = {L[193684], nil, nil}, --"Pipspark Thundersnap"
        [193674] = {L[193674], nil, nil}, --"Voraazka"
        [193677] = {L[193677], nil, nil}, --"Maeleera"
        [193679] = {L[193679], nil, nil}, --"Leerain"
        [193654] = {L[193654], nil, nil}, --"Gravlion"
        [193655] = {L[193655], nil, nil}, --"Frozion"
        
        [186200] = {L[186200], 74000, nil}, --"Harkyn Grymstone"
    },
    ["special_categories"] = categorized_rare_ids
})

RareTracker.RegisterRaresForModule({
    -- Define the zone(s) in which the rares are present.
    ["target_zones"] = {2151},
    ["zone_name"] = "The Forbidden Reach",
    ["plugin_name"] = "The Forbidden Reach",
    ["plugin_name_abbreviation"] = "Dragonflight",
    ["entities"] = {
        --npc_id = {name, quest_id, coordinates}
        [200584] = {L[200584], 74336, {58.2, 48.3}}, --"Vraken the Hunter"
        [200579] = {L[200579], 74338, {41.0, 14.4}}, --"Ishyra"
        [200610] = {L[200610], 74340, {32.9, 29.3}}, --"Duzalgor"
        [200717] = {L[200717], 74342, {44.7, 79.4}}, --"Galakhad"
        [200885] = {L[200885], 74344, {59.7, 58.8}}, --"Lady Shaz'ra"
        [201181] = {L[201181], 74346, {67.9, 45.3}}, --"Mad-Eye Carrey"
        [200960] = {L[200960], 74348, {45.9, 79.7}}, --"Warden Entrix"
        [200978] = {L[200978], 74350, {51.7, 72.8}}, --"Pyrachniss"
        [200619] = {L[200619], 74300, nil}, --"Tectonus"
        [200621] = {L[200621], 74306, nil}, --"Manathema"
        [200722] = {L[200722], 74321, nil}, --"Gareed"
        [200730] = {L[200730], 74325, nil}, --"Tidesmith Zarviss"
        [200738] = {L[200738], 74329, nil}, --"Kangalo"
        [200740] = {L[200740], 74331, nil}, --"Agni Blazehoof"
        [200743] = {L[200743], 74333, nil}, --"Amephyst"
        [200537] = {L[200537], 74337, {28.3, 37.9}}, --"Gahz'raxes"
        [200600] = {L[200600], 74339, {47.7, 20.7}}, --"Reisa the Drowned"
        [200681] = {L[200681], 74341, {43.7, 60.9}}, --"Bonesifter Marwak"
        [200721] = {L[200721], 74343, {43.9, 90.5}}, --"Grugoth the Hullcrusher"
        [200904] = {L[200904], 74345, {73.0, 67.4}}, --"Veltrax"
        [201013] = {L[201013], 74347, {61.7, 34.0}}, --"Wyrmslayer Angvardi"
        [200956] = {L[200956], 74349, {36.7, 12.2}}, --"Ookbeard"
        [200911] = {L[200911], 74351, {78.2, 50.7}}, --"Volcanakk"
        [200620] = {L[200620], 74305, nil}, --"Sir Pinchalot"
        [200622] = {L[200622], 74307, nil}, --"Snarfang"
        [200725] = {L[200725], 74322, nil}, --"Faunos"
        [200737] = {L[200737], 74328, nil}, --"Arcantrix"
        [200739] = {L[200739], 74330, nil}, --"Fimbol"
        [200742] = {L[200742], 74332, nil}, --"Luttrok"
        [203353] = {L[203353], nil, nil}, --"Loot Specialist" 
    }
})

local zaralek_rare_announcements = {
    [L["The great war beast bathes in the burning fires."]] = 200111,
    [L["A Champion emerges on the ancient battlefield."]] = 203627,
    [L["An eerie yet soothing light flickers in the darkness from underneath large wings."]] = 203593,
    [L["Barked orders can be heard from within the Brimstone Garrison."]] = 203592,
    [L["A flash of teeth and wings darts across the cavern ceiling."]] = 203625,
    [L[203462]] = 203462,
    [L[204093]] = 204093,
    [L["The drone of ancient drums echoes throughout the cavern."]] = 203646,
    [L["The earth trembles in the caldera."]] = 203662,
    [L["Maniacal laughter and explosions can be heard echoing in the cavern."]] = 203521,
    [L["The crystalline structures begin to stir."]] = 201029,
    [L[203477]] = 203477,
    [L[203466]] = 203466,
    [L["The strong are gathering in Glimmerogg to test their mettle."]] = 203621,
    [L["You feel the temperature within the cavern rise significantly."]] = 203643,
    [L[203664]] = 203664,
    [L["The snapping of great claws can be heard from the waters."]] = 203618,
    [L["A pair of terrifying howls pierce the air."]] = 203660,
    [L[203515]] = 203515,
    [L[203468]] = 203468,
    [L[203480]] = 203480,
}

RareTracker.RegisterRaresForModule({
    -- Define the zone(s) in which the rares are present.
    ["target_zones"] = {2133, 2184},
    ["zone_name"] = "Zaralek Cavern",
    ["plugin_name"] = "Zaralek Cavern",
    ["plugin_name_abbreviation"] = "Dragonflight",
    ["entities"] = {
        --npc_id = {name, quest_id, coordinates}
        [203515] = {L[203515], 75284, {56.90, 73.14}}, --"Alcanon"
        [203621] = {L[203621], 75326, {41.46, 86.12}}, --"Brullo the Strong"
        [203664] = {L[203664], 75361, {31.79, 50.58}}, --"Emberdusk"
        [203592] = {L[203592], 75295, {42.63, 18.88}}, --"General Zskorro"
        [203611] = {L[203611], nil, nil}, --"Hadexia"
        [203646] = {L[203646], 75352, {28.51, 51.11}}, --"Jrumm"
        [203466] = {L[203466], 75268, {59.58, 39.45}}, --"Kaprachu"
        [203462] = {L[203462], 75266, {64.73, 55.46}}, --"Kob'rok"
        [203630] = {L[203630], nil, nil}, --"Lavermix"
        [203521] = {L[203521], 75291, {52.83, 18.87}}, --"Professor Gastrinax"
        [203643] = {L[203643], 75348, {36.40, 52.74}}, --"Skornak"
        [203662] = {L[203662], 75359, {38.45, 46.56}}, --"Subterrax"
        [201029] = {L[201029], 75365, {38.91, 71.58}}, --"Veridian King"
        [203468] = {L[203468], 75270, {48.33, 75.09}}, --"Aquifon"
        [204093] = {L[204093], 75475, {48.38, 23.86}}, --"Colossian"
        [203660] = {L[203660], 75357, {35.86, 43.83}}, --"Flowfy"
        [203477] = {L[203477], 75273, {68.80, 45.84}}, --"Goopal"
        [203627] = {L[203627], 75335, {45.65, 33.30}}, --"Invoq"
        [203625] = {L[203625], 75333, {42.20, 65.17}}, --"Kairoktra"
        [203618] = {L[203618], 75321, {54.19, 41.77}}, --"Klakatak"
        [203642] = {L[203642], nil, nil}, --"Kronkapace"
        [200111] = {L[200111], 75339, {40.79, 38.29}}, --"Magmanesha"
        [204096] = {L[204096], 75576, nil}, --"Shadowforge Mole Machine"
        [203480] = {L[203480], 75275, {54.77, 65.89}}, --"Spinmarrow"
        [203593] = {L[203593], 75297, {57.78, 69.10}}, --"Underlight Queen"
    },
    ["FindMatchForText"] = function(self, text)
        -- Check if any of the drill rig designations is contained in the broadcast text.
        for designation, npc_id in pairs(zaralek_rare_announcements) do
            if text:find(designation) then
                self:ProcessEntityAlive(npc_id, npc_id, nil, nil, false)
                return
            end
        end
    end
})
