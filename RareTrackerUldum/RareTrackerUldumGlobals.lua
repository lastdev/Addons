-- Redefine often used functions locally.
local GetLocale = GetLocale
local ipairs = ipairs
local pairs = pairs

-- ####################################################################
-- ##                          Static Data                           ##
-- ####################################################################

-- The zones in which the addon is active.
RTU.target_zones = {
    [1527] = true
}
RTU.parent_zone = 1527

-- NPCs that are banned during shard detection.
-- Player followers sometimes spawn with the wrong zone id.
RTU.banned_NPC_ids = {
    [154297] = true,
    [150202] = true,
    [154304] = true,
    [152108] = true,
    [151300] = true,
    [151310] = true,
    [69792] = true,
    [62821] = true,
    [62822] = true,
    [32639] = true,
    [32638] = true,
    [89715] = true,
}

-- Simulate a set data structure for efficient existence lookups.
function Set (list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end

-- The ids of the rares the addon monitors.
RTU.rare_ids = {
    157170, -- "Acolyte Taspu",
    158557, -- "Actiss the Deceiver",
    157593, -- "Amalgamation of Flesh",
    151883, -- "Anaua",
    155703, -- "Anq'uri the Titanic",
    157472, -- "Aphrom the Guise of Madness",
    154578, -- "Aqir Flayer",
    154576, -- "Aqir Titanus",
    162172, -- "Aqir Warcaster",
    162370, -- "Armagedillo",
    152757, -- "Atekhramun",
    162171, -- "Captain Dunewalker",
    157167, -- "Champion Sen-mat",
    162147, -- "Corpse Eater",
    158531, -- "Corrupted Neferset Guard"
    158594, -- "Doomsayer Vathiris",
    158491, -- "Falconer Amenophis",
    157120, -- "Fangtaker Orsa",
    158633, -- "Gaze of N'Zoth",
    158597, -- "High Executor Yothrim",
    158528, -- "High Guard Reshef",
    162163, -- "High Priest Ytaessis",
    151995, -- "Hik-Ten the Taskmaster",
    160623, -- "Hungering Miasma",
    152431, -- "Kaneb-ti",
    155531, -- "Infested Wastewander Captain",
    157134, -- "Ishak of the Four Winds",
    156655, -- "Korzaran the Slaughterer",
    154604, -- "Lord Aj'qirai",
    156078, -- "Magus Rehleth",
    157157, -- "Muminah the Incandescent",
    152677, -- "Nebet the Ascended",
    162196, -- "Obsidian Annihilator",
    162142, -- "Qho",
    157470, -- "R'aas the Anima Devourer",
    156299, -- "R'khuzj the Unfathomable",
    162173, -- "R'krox the Runt",
    157390, -- "R'oyolok the Reality Eater",
    157146, -- "Rotfeaster",
    152040, -- "Scoutmaster Moswen",
    151948, -- "Senbu the Pridefather",
    161033, -- "Shadowmaw",
    156654, -- "Shol'thoss the Doomspeaker",
    160532, -- "Shoth the Darkened",
    157476, -- "Shugshul the Flesh Gorger",
    162140, -- "Skikx'traz",
    162372, -- "Spirit of Cyrus the Black",
    162352, -- "Spirit of Dark Ritualist Zakahn",
    151878, -- "Sun King Nahkotep",
    151897, -- "Sun Priestess Nubitt",
    151609, -- "Sun Prophet Epaphos",
    152657, -- "Tat the Bonechewer",
    158636, -- "The Grand Executor",
    157188, -- "The Tomb Widow",
    158595, -- "Thoughtstealer Vos",
    152788, -- "Uat-ka the Sun's Wrath"
    162170, -- "Warcaster Xeshro",
    151852, -- "Watcher Rehu",
    157473, -- "Yiphrim the Will Ravager",
    157164, -- "Zealot Tekem",
    157469, -- "Zoth'rum the Intellect Pillager",
    162141, -- "Zuythiz",
}

-- Create a table, such that we can look up a rare in constant time.
RTU.rare_ids_set = Set(RTU.rare_ids)

-- Group rares by the assaults they are active in.
-- Notes: used the values found in the HandyNotes_VisionsOfNZoth addon.
RTU.assault_rare_ids = {
    [3165083] = Set({ -- West (AQR)
        155703,
        154578,
        154576,
        162172,
        162370,
        162171,
        162147,
        162163,
        155531,
        157134,
        154604,
        156078,
        162196,
        162142,
        156299,
        162173,
        160532,
        162140,
        162372,
        162352,
        151878,
        162170,
        162141,
        
        157472, -- "Aphrom the Guise of Madness"
        158531, -- "Corrupted Neferset Guard"
        152431, -- "Kaneb-ti"
        157470, -- "R'aas the Anima Devourer"
        157390, -- "R'oyolok the Reality Eater"
        157476, -- "Shugshul the Flesh Gorger"
        158595, -- "Thoughtstealer Vos"
        157473, -- "Yiphrim the Will Ravager"
        157469, -- "Zoth'rum the Intellect Pillager"
    }),
    [3165092] = Set({ -- South (EMP)
        158557,
        155703,
        154578,
        154576,
        162172,
        158594,
        158491,
        158633,
        158597,
        158528,
        160623,
        155531,
        157134,
        156655,
        162196,
        156299,
        161033,
        156654,
        160532,
        151878,
        158636,
        
        157472, -- "Aphrom the Guise of Madness"
        158531, -- "Corrupted Neferset Guard"
        152431, -- "Kaneb-ti"
        157470, -- "R'aas the Anima Devourer"
        157390, -- "R'oyolok the Reality Eater"
        157476, -- "Shugshul the Flesh Gorger"
        158595, -- "Thoughtstealer Vos"
        157473, -- "Yiphrim the Will Ravager"
        157469, -- "Zoth'rum the Intellect Pillager"
    }),
    [3165098] = Set({ -- East (AMA)
        157170,
        151883,
        155703,
        154578,
        154576,
        162172,
        152757,
        157120,
        151995,
        155531,
        157134,
        157157,
        152677,
        162196,
        157146,
        152040,
        151948,
        162372,
        162352,
        151878,
        151897,
        151609,
        152657,
        151852,
        157164,
        162141,
        157167,
        157593, -- "Amalgamation of Flesh"
        157188, -- "The Tomb Widow"
        152788, -- "Uat-ka the Sun's Wrath"
        
        157472, -- "Aphrom the Guise of Madness"
        158531, -- "Corrupted Neferset Guard"
        152431, -- "Kaneb-ti"
        157470, -- "R'aas the Anima Devourer"
        157390, -- "R'oyolok the Reality Eater"
        157476, -- "Shugshul the Flesh Gorger"
        158595, -- "Thoughtstealer Vos"
        157473, -- "Yiphrim the Will Ravager"
        157469, -- "Zoth'rum the Intellect Pillager"
    })
}

-- Rare ids that have loot, which will be used as a default fallback option if no assault is active (introduction not done).
RTU.rare_ids_with_loot = Set({
    157593, -- "Amalgamation of Flesh"
    162147, -- "Malevolent Drone"
    158633, -- "Gaze of N'Zoth"
    157134, -- "Ishak of the Four Winds"
    154604, -- "Lord Aj'qirai"
    157146, -- "Rotfeaster"
    162140, -- "Skikx'traz"
    158636, -- "The Grand Executor"
    157473, -- "Yiphrim the Will Ravager"
})

-- Get the rare names in the correct localization.
RTU.localization = GetLocale()
RTU.rare_names = {}

if RTU.localization == "frFR" then
    -- The names to be displayed in the frames and general chat messages for the French localization.
    RTU.rare_names = {
        [157170] = "Acolyte Taspu",
        [158557] = "Actiss le Trompeur",
        [157593] = "Amalgame de chair",
        [151883] = "Anaua",
        [155703] = "Anq'uri le Titanesque",
        [157472] = "Aphrom l'Incarnation de la folie",
        [154578] = "Ecorcheur aqir",
        [154576] = "Titanus aqir",
        [162172] = "Invocateur de guerre aqir",
        [162370] = "Armaglyptodon",
        [152757] = "Atekhramun",
        [162171] = "Capitaine marchedune",
        [157167] = "Champion Sen-mat",
        [162147] = "Mange-cadavres",
        [158531] = "Garde de Neferset corrompu",
        [158594] = "Auspice funeste Vathiris",
        [158491] = "Fauconnier Amenophis",
        [157120] = "Orsa Chasse-crocs",
        [158633] = "Regard de N'Zoth",
        [158597] = "Grand exécuteur Yothrim",
        [158528] = "Haut garde Reshef",
        [162163] = "Grand prêtre Ytaessis",
        [151995] = "Hik-ten le Sous-chef",
        [160623] = "Miasme affamé",
        [152431] = "Kaneb-ti",
        [155531] = "Capitaine bat-le-désert contaminé",
        [157134] = "Ishak des Quatre vents",
        [156655] = "Korzaran le Massacreur",
        [154604] = "Seigneur Aj'qirai",
        [156078] = "Magus Rehleth",
        [157157] = "Muminah l'Incandescent",
        [152677] = "Nebet le Sublimé",
        [162196] = "Annihilateur d'obsidienne",
        [162142] = "Qho",
        [157470] = "R'aas le Dévoreur d'anima",
        [156299] = "R'khuzj l'Insondable",
        [162173] = "R'krox l'Avorton",
        [157390] = "R'oyolok le Bâfreur de réalité",
        [157146] = "Croque-Charogne",
        [152040] = "Maître-éclaireur Moswen",
        [151948] = "Senbu le Père-de-troupe",
        [161033] = "Ombregueule",
        [156654] = "Shol'thoss l'Orateur funeste",
        [160532] = "Shoth l'Assombri",
        [157476] = "Shugshul le Gobeur de chair",
        [162140] = "Skikx'traz",
        [162372] = "Esprit de Cyrus le Noir",
        [162352] = "Esprit du ritualiste sombre Zakahn",
        [151878] = "Roi-soleil Nahkotep",
        [151897] = "Prêtresse du soleil Nabett",
        [151609] = "Prophète du soleil Epaphos",
        [152657] = "Tat le Mâche-les-os",
        [158636] = "Le grand exécuteur",
        [157188] = "La veuve du tombeau",
        [158595] = "Pilleur mental Vos",
        [152788] = "Uat-ka Courroux-du-Soleil",
        [162170] = "Invocateur de guerre Xeshro",
        [151852] = "Guetteur Rehu",
        [157473] = "Yiphrim le Ravageur de volonté",
        [157164] = "Zélote Tekem",
        [157469] = "Zoth'rum le Pilleur d'intellect",
        [162141] = "Zuythiz",
    }
elseif RTU.localization == "deDE" then
    -- The names to be displayed in the frames and general chat messages for the German localizations.
    RTU.rare_names = {
        [157170] = "Akolyth Taspu",
        [158557] = "Actiss der Betrüger",
        [157593] = "Fleischverschmelzung",
        [151883] = "Anaua",
        [155703] = "Anq'uri der Titanische",
        [157472] = "Aphrom das Antlitz des Wahnsinns",
        [154578] = "Schinder der Aqir",
        [154576] = "Titanus der Aqir",
        [162172] = "Schlachtzauberer der Aqir",
        [162370] = "Armagürtlon",
        [152757] = "Atekhramun",
        [162171] = "Hauptmann Dünenläufer",
        [157167] = "Champion Sen-mat",
        [162147] = "Leichenfresser",
        [158531] = "Verderbte Wache der Neferset",
        [158594] = "Weltuntergangsverkünder Vathiris",
        [158491] = "Falkner Amenophis",
        [157120] = "Reißzahnsammler Orsa",
        [158633] = "Blick von N'Zoth",
        [158597] = "High Executor Yothrim",
        [158528] = "Oberster Wächter Reshef",
        [162163] = "Hohepriester Ytaessis",
        [151995] = "Hik-ten der Zuchtmeister",
        [160623] = "Hungerndes Miasma",
        [152431] = "Kaneb-ti",
        [155531] = "Befallener Hauptmann der Wüstenwanderer",
        [157134] = "Ishak von den Vier Winden",
        [156655] = "Korzaran der Schlächter",
        [154604] = "Lord Aj'qirai",
        [156078] = "Magus Rehleth",
        [157157] = "Muminah der Strahlende",
        [152677] = "Nebet der Aufgestiegene",
        [162196] = "Obsidianvernichter",
        [162142] = "Qho",
        [157470] = "R'aas der Animaverschlinger",
        [156299] = "R'khuzj der Unergründliche",
        [162173] = "R'krox, der Kleinste",
        [157390] = "R'oyolok der Realitätenverschlinger",
        [157146] = "Fäulnisverschlinger",
        [152040] = "Spähmeister Moswen",
        [151948] = "Senbu der Rudelvater",
        [161033] = "Schattenschlund",
        [156654] = "Shol'thoss der Untergangsverkünder",
        [160532] = "Shoth der Verdunkelte",
        [157476] = "Shugshul der Fleischschlinger",
        [162140] = "Skikx'traz",
        [162372] = "Geist Cyrus' des Schwarzen",
        [162352] = "Geist des dunklen Ritualisten Zakahn",
        [151878] = "Sonnenkönig Nahkotep",
        [151897] = "Sonnenpriesterin Nubitt",
        [151609] = "Sonnenprophet Epaphos",
        [152657] = "Tatt der Knochenkauer",
        [158636] = "Der Großexekutor",
        [157188] = "Gruftwitwe",
        [158595] = "Gedankenräuber Vos",
        [152788] = "Uat-ka der Sonnenzorn",
        [162170] = "Schlachtzauberer Xeshro",
        [151852] = "Beobachter Rehu",
        [157473] = "Yiphrim der Willensräuber",
        [157164] = "Zelot Tekem",
        [157469] = "Zoth'rum der Intellektplünderer",
        [162141] = "Zuythiz",
    }
elseif RTU.localization == "esES" or RTU.localization == "esMX" then
    -- The names to be displayed in the frames and general chat messages for the Spanish localizations.
    RTU.rare_names = {
        [157170] = "Acólito Taspu",
        [158557] = "Actiss el Embustero",
        [157593] = "Amalgama de carne",
        [151883] = "Anaua",
        [155703] = "Anq'uri el Titánico",
        [157472] = "Aphrom, la Imagen de la Locura",
        [154578] = "Despellejador aqir",
        [154576] = "Titanus aqir",
        [162172] = "Taumaturgo de guerra aqir",
        [162370] = "Armagedillo",
        [152757] = "Atekhramun",
        [162171] = "Capitán Caminadunas",
        [157167] = "Campeón Sen-mat",
        [162147] = "Comecadáveres",
        [158531] = "Guardia neferset corrupto",
        [158594] = "Orador del Sino Vathiris",
        [158491] = "Halconero Amenophis",
        [157120] = "Robacolmillos Orsa",
        [158633] = "Mirada de N'Zoth",
        [158597] = "Sumo ejecutor Yothrim",
        [158528] = "Guardia superior Reshef",
        [162163] = "Sumo sacerdote Ytaessis",
        [151995] = "Hik-ten el Capataz",
        [160623] = "Miasma hambriento",
        [152431] = "Kaneb-ti",
        [155531] = "Capitán Vagayermos infestado",
        [157134] = "Ishak de los Cuatro Vientos",
        [156655] = "Korzaran el Carnicero",
        [154604] = "Lord Aj'qirai",
        [156078] = "Magus Rehleth",
        [157157] = "Muminah el Incandescente",
        [152677] = "Nebet el Ascendido",
        [162196] = "Aniquilador de obsidiana",
        [162142] = "Qho",
        [157470] = "R'aas el Devoraánimas",
        [156299] = "R'khuzj el Inconmensurable",
        [162173] = "R'krox el Renacuajo",
        [157390] = "R'oyolok el Devorarrealidades",
        [157146] = "Comecarroña",
        [152040] = "Maestro de exploradores Moswen",
        [151948] = "Senbu el Padre de la Manada",
        [161033] = "Buchesombrío",
        [156654] = "Shol'thoss el Augurador",
        [160532] = "Shoth el Oscurecido",
        [157476] = "Shugshul el Engullidor de Carne",
        [162140] = "Skikx'traz",
        [162372] = "Espíritu de Cyrus el Oscuro",
        [162352] = "Espíritu del ritualista oscuro Zakahn",
        [151878] = "Rey del sol Nahkotep",
        [151897] = "Sacerdote del sol Nubitt",
        [151609] = "Profeta del sol Epaphos",
        [152657] = "Tat el Mascahuesos",
        [158636] = "El Gran Ejecutor",
        [157188] = "La Viuda de la Tumba",
        [158595] = "Robaideas Vos",
        [152788] = "Uat-ka la Ira del Sol",
        [162170] = "Taumaturgo de guerra Xeshro",
        [151852] = "Vigía Rehu",
        [157473] = "Yiphrim el Devastador de Voluntades",
        [157164] = "Fanático Tekem",
        [157469] = "Zoth'rum el Saqueador de Intelectos",
        [162141] = "Zuythiz",
    }
elseif RTU.localization == "itIT" then
    -- The names to be displayed in the frames and general chat messages for the Italian localization.
    RTU.rare_names = {
        [157170] = "Accolito Taspu",
        [158557] = "Actis l'Ingannatore",
        [157593] = "Amalgama di Carne",
        [151883] = "Anaua",
        [155703] = "Anq'uri il Titanico",
        [157472] = "Afrom la Follia Incarnata",
        [154578] = "Scuoiatore Aqir",
        [154576] = "Titanus Aqir",
        [162172] = "Mago da Guerra Aqir",
        [162370] = "Armagedillo",
        [152757] = "Atekhramun",
        [162171] = "Capitano Calcadune",
        [157167] = "Campione Sen-Mat",
        [162147] = "Mangiatore di Cadaveri",
        [158531] = "Guardia Neferset Corrotta",
        [158594] = "Vate della Rovina Vathiris",
        [158491] = "Falconiere Amenofis",
        [157120] = "Collezionista di Zanne Orsa",
        [158633] = "Sguardo di N'zoth",
        [158597] = "Gran Esecutore Yothrim",
        [158528] = "Gran Guardia Reshef",
        [162163] = "Gran Sacerdote Ytaessis",
        [151995] = "Hik-Ten il Coordinatore",
        [160623] = "Miasma Famelico",
        [152431] = "Kaneb-Ti",
        [155531] = "Capitano Nomade Infestato",
        [157134] = "Ishak dei Quattro Venti",
        [156655] = "Korzaran lo Sterminatore",
        [154604] = "Signore Aj'qirai",
        [156078] = "Magus Rehleth",
        [157157] = "Muminah l'Incandescente",
        [152677] = "Nebet l'Asceso",
        [162196] = "Annientatore di Ossidiana",
        [162142] = "Qho",
        [157470] = "R'aas il Divoratore d'Anima",
        [156299] = "R'khuzj il Terrificante",
        [162173] = "R'krox il Piccolo",
        [157390] = "R'oyolok il Divoratore della Realtà",
        [157146] = "Gozzomarcio",
        [152040] = "Gran Esploratore Moswen",
        [151948] = "Senbu il Padre del Branco",
        [161033] = "Musombroso",
        [156654] = "Shol'thoss l'Oratore della Rovina",
        [160532] = "Shoth l'Oscurato",
        [157476] = "Shugshul l'Ingozzacarne",
        [162140] = "Skikx'traz",
        [162372] = "Spirito di Cyrus il Nero",
        [162352] = "Spirito del Ritualista Oscuro Zakahn",
        [151878] = "Re del Sole Nahkotep",
        [151897] = "Sacerdotessa del Sole Nubitt",
        [151609] = "Profeta del Sole Epafos",
        [152657] = "Tat il Masticaossa",
        [158636] = "Il Grande Esecutore",
        [157188] = "Vedova delle Tombe",
        [158595] = "Rubapensieri Vos",
        [152788] = "Uat-ka l'Ira del Sole",
        [162170] = "Mago da Guerra Xeshro",
        [151852] = "Guardiano Rehu",
        [157473] = "Yifrim il Devastatore della Volontà",
        [157164] = "Zelota Tekem",
        [157469] = "Zoth'rum il Saccheggiatore dell'Intelletto",
        [162141] = "Zuythiz",
    }
elseif RTU.localization == "ptPT" or RTU.localization == "ptBR" then
    -- The names to be displayed in the frames and general chat messages for the Portuguese localizations.
    RTU.rare_names = {
        [157170] = "Acólito Taspu",
        [158557] = "Actiss, o Enganador",
        [157593] = "Amálgama de Carne",
        [151883] = "Anaua",
        [155703] = "Anq'uri, o Titânico",
        [157472] = "Aphrom, o Aspecto da Loucura",
        [154578] = "Esfolador Aqir",
        [154576] = "Titanus Aqir",
        [162172] = "Mago de Guerra Aqir",
        [162370] = "Tatudumal",
        [152757] = "Atekhramun",
        [162171] = "Capitão Trilhadunas",
        [157167] = "Campeão Sen-mat",
        [162147] = "Comedor de Cadáveres",
        [158531] = "Guarda de Neferset Corrompido",
        [158594] = "Agoureiro Vathiris",
        [158491] = "Falcoeiro Amenófis",
        [157120] = "Rancapresas Orsa",
        [158633] = "Olhar de N'Zoth",
        [158597] = "Alto-executor Yothrim",
        [158528] = "Alto-guarda Reshef",
        [162163] = "Sumo Sacerdote Ytaessis",
        [151995] = "Hik-ten, o Capataz",
        [160623] = "Miasma Faminto",
        [152431] = "Kaneb-ti",
        [155531] = "Capitão Errante Infestado",
        [157134] = "Ishak dos Quatro Ventos",
        [156655] = "Korzaran, o Massacrante",
        [154604] = "Lorde Aj'qirai",
        [156078] = "Magus Rehleth",
        [157157] = "Muminah, o Incandescente",
        [152677] = "Nebet, o Elevado",
        [162196] = "Aniquilador Obsidiano",
        [162142] = "Qho",
        [157470] = "R'aas, o Devorador de Ânima",
        [156299] = "R'khuzj, o Inconcebível",
        [162173] = "R'krox, o Nanico",
        [157390] = "R'oyolok, o Devorador da Realidade",
        [157146] = "Putrífago",
        [152040] = "Batedor Mestre Moswen",
        [151948] = "Senbu, o Pai da Alcateia",
        [161033] = "Gorjumbro",
        [156654] = "Shol'thoss, a Voz da Ruína",
        [160532] = "Shoth, o Obscurecido",
        [157476] = "Sugshul, o Engolidor de Carne",
        [162140] = "Skikx'traz",
        [162372] = "Espírito de Cyrus, o Negro",
        [162352] = "Espírito do Ritualista das Trevas Zakahn",
        [151878] = "Rei Sol Nahkotep",
        [151897] = "Sacerdotisa do Sol Nubitt",
        [151609] = "Profeta do Sol Epaphos",
        [152657] = "Tat, o Mascaosso",
        [158636] = "O Grande Executor",
        [157188] = "A Viúva da Tumba",
        [158595] = "Ladrão de Pensamentos Vos",
        [152788] = "Uat-ka, a Ira do Sol",
        [162170] = "Mago de Guerra Xeshro",
        [151852] = "Vigia Rehu",
        [157473] = "Yiphrim, o Assolador da Vontade",
        [157164] = "Zelote Tekem",
        [157469] = "Zoth'rum, o Pilhador de Intelecto",
        [162141] = "Zuythiz",
    }
elseif RTU.localization == "ruRU" then
    -- The names to be displayed in the frames and general chat messages for the Russian localization.
    RTU.rare_names = {
        [157170] = "Послушник Таспу",
        [158557] = "Актисс Обманщик",
        [157593] = "Слияние плоти",
        [151883] = "Анауа",
        [155703] = "Анк'ури Необъятный",
        [157472] = "Афром, Лик Безумия",
        [154578] = "Акир-бичеватель",
        [154576] = "Акир-колосс",
        [162172] = "Акир - боевой заклинатель",
        [162370] = "Армагеносец",
        [152757] = "Атехрамун",
        [162171] = "Капитан стражи песков",
        [157167] = "Защитник Сен-мат",
        [162147] = "Пожиратель трупов",
        [158531] = "Падший стражник Неферсета",
        [158594] = "Вестник рока Ватирис",
        [158491] = "Сокольничий Аменофис",
        [157120] = "Вырыватель клыков Орса",
        [158633] = "Взор Н'Зота",
        [158597] = "Верховный палач Йотрим",
        [158528] = "Верховный страж Решеф",
        [162163] = "Верховный жрец Итэссис",
        [151995] = "Хик-тен надсмотрщик",
        [160623] = "Алчущие миазмы",
        [152431] = "Канеб-ти",
        [155531] = "Зараженный капитан Скитальцев Пустыни",
        [157134] = "Исхак Повелитель Четырех Ветров",
        [156655] = "Корзаран Убийца",
        [154604] = "Лорд Аж'кирай",
        [156078] = "Маг Ренлет",
        [157157] = "Мумина Сияющий",
        [152677] = "Небет Перерожденный",
        [162196] = "Обсидиановый аннигилятор",
        [162142] = "Кьюхо",
        [157470] = "Р'аас Пожиратель анимы",
        [156299] = "Р'хузж Непостижимый",
        [162173] = "Р'кроз Недоросток",
        [157390] = "Р'йолок Пожиратель реальности",
        [157146] = "Гниложор",
        [152040] = "Командир разведчиков Мосвен",
        [151948] = "Сенбу, глава прайда",
        [161033] = "Темная пасть",
        [156654] = "Шол'тосс Глашатай Судьбы",
        [160532] = "Шот Омраченный",
        [157476] = "Шугшул Пожирающий плоть",
        [162140] = "Скикз'траз",
        [162372] = "Дух Сайруса Черного",
        [162352] = "Дух темного ритуалиста Закана",
        [151878] = "Солнечный король Накхотеп",
        [151897] = "Жрица солнца Нубитт",
        [151609] = "Пророк Солнца Эпафос",
        [152657] = "Тат Костеглод",
        [158636] = "Великий палач",
        [157188] = "Могильная вдова",
        [158595] = "Похититель мыслей Вос",
        [152788] = "Уат-ка Гнев солнца",
        [162170] = "Боевой заклинатель Зешро",
        [151852] = "Дозорный Рэху",
        [157473] = "Ифрим, Убийца Воли",
        [157164] = "Ревнитель Текем",
        [157469] = "Зот'рум Разоритель сознания",
        [162141] = "Зуйтиз",
    }
elseif RTU.localization == "koKR" then
    -- The names to be displayed in the frames and general chat messages for the Korean localization.
    RTU.rare_names = {
        [157170] = "수행사제 타스푸",
        [158557] = "기만자 액티스",
        [157593] = "살덩어리의 융합체",
        [151883] = "아나우아",
        [155703] = "거대한 자 안쿠리",
        [157472] = "광기의 허울 아프롬",
        [154578] = "아퀴르 갈퀴손",
        [154576] = "아퀴르 괴수",
        [162172] = "아퀴르 전쟁마법사",
        [162370] = "아마게딜로",
        [152757] = "아테크라문",
        [162171] = "대장 듄워커",
        [157167] = "용사 센마트",
        [162147] = "시체 청소부",
        [158531] = "타락한 네페르세트 경비병",
        [158594] = "파멸의 예언자 바시리스",
        [158491] = "매사냥꾼 아메노피스",
        [157120] = "송곳니갈취자 오르사",
        [158633] = "느조스의 시선",
        [158597] = "고위집행관 요스림",
        [158528] = "고위 경비병 레쉬프",
        [162163] = "대사제 이태스시스",
        [151995] = "감독관 히크텐",
        [160623] = "굶주린 독기",
        [152431] = "카넵티",
        [155531] = "감염된 사막유랑단 대장",
        [157134] = "네 바람의 이샤크",
        [156655] = "학살자 코르자란",
        [154604] = "군주 아즈퀴라이",
        [156078] = "학자 레흘레스",
        [157157] = "빛나는 무미나",
        [152677] = "승천자 네베트",
        [162196] = "흑요석 파멸자",
        [162142] = "큐호",
        [157470] = "령 포식자 라아스",
        [156299] = "속을 알 수 없는 알크후즈",
        [162173] = "보잘것없는 알크록스",
        [157390] = "현실포식자 로요로크",
        [157146] = "부패탐식자",
        [152040] = "정찰대장 모스웬",
        [151948] = "긍지아비 센부",
        [161033] = "어둠아귀",
        [156654] = "파멸예언자 숄소스",
        [160532] = "암흑에 물든 쇼스",
        [157476] = "살덩이 탐식자 슈그슐",
        [162140] = "스킥스트라즈",
        [162372] = "흑사자 사이러스의 영혼",
        [162352] = "암흑 의식술사 자칸의 영혼",
        [151878] = "태양왕 나흐코텝",
        [151897] = "태양 여사제 누비트",
        [151609] = "태양 예언자 에파포스",
        [152657] = "해골이빨 타트",
        [158636] = "대집행관",
        [157188] = "무덤 과부거미",
        [158595] = "생각강탈자 보스",
        [152788] = "태양의 분노 우아트카",
        [162170] = "전쟁마법사 제쉬로",
        [151852] = "감시자 리후",
        [157473] = "의지약탈자 이프림",
        [157164] = "광신도 테켐",
        [157469] = "지능강탈자 조스럼",
        [162141] = "주이시즈",
    }
elseif RTU.localization == "zhCN" then
    -- The names to be displayed in the frames and general chat messages for the Simplified Chinese localization.
    RTU.rare_names = {
        [157170] = "侍战者塔斯普",
        [158557] = "欺诈者阿克提斯",
        [157593] = "血肉融合体",
        [151883] = "阿那瓦",
        [155703] = "巨擘之力安克乌瑞",
        [157472] = "癫狂伪装者阿弗罗姆",
        [154578] = "亚基剥除者",
        [154576] = "亚基巨虫",
        [162172] = "亚基战争法师",
        [162370] = "硕铠鼠",
        [152757] = "阿特克拉蒙",
        [162171] = "沙丘行者队长",
        [157167] = "勇士森-马特",
        [162147] = "食尸者",
        [158531] = "被腐化的尼斐塞特守卫",
        [158594] = "末日预言者瓦希利斯",
        [158491] = "驯鹰者亚梅诺菲斯",
        [157120] = "掠牙者奥尔萨",
        [158633] = "恩佐斯的凝视",
        [158597] = "高阶执行者约兹里姆",
        [158528] = "高阶护卫雷舍夫",
        [162163] = "高阶祭司雅塔西斯",
        [151995] = "工头西克-滕",
        [160623] = "饥饿瘴气",
        [152431] = "卡奈布-提",
        [155531] = "废土寄生者队长",
        [157134] = "四风之龙艾夏克",
        [156655] = "屠灭者寇扎兰",
        [154604] = "亚吉其莱勋爵",
        [156078] = "魔导师莱勒斯",
        [157157] = "耀辉者玛米纳",
        [152677] = "晋升者内贝特",
        [162196] = "黑曜歼灭者",
        [162142] = "克霍",
        [157470] = "心能吞噬者拉亚斯",
        [156299] = "不可估量者勒霍兹基",
        [162173] = "柔弱者拉克诺斯",
        [157390] = "现实消化者罗约洛克",
        [157146] = "腐肉饕餮者",
        [152040] = "高级斥候莫斯文",
        [151948] = "狮父森布",
        [161033] = "影喉",
        [156654] = "末日语者修索斯",
        [160532] = "黑暗者肖斯",
        [157476] = "血肉饕餮者舒格舒尔",
        [162140] = "斯克提拉兹",
        [162372] = "乌黑的赛勒斯的灵魂",
        [162352] = "黑暗仪祭师扎卡汗之魂",
        [151878] = "太阳王纳科泰普",
        [151897] = "太阳女祭司纽比特",
        [151609] = "太阳先知艾帕弗斯",
        [152657] = "噬骨者塔特",
        [158636] = "大执行官",
        [157188] = "陵墓寡妇蛛",
        [158595] = "思维窃贼沃斯",
        [152788] = "“太阳之怒”瓦特-卡",
        [162170] = "战争法师夏克希诺",
        [151852] = "守护者雷胡",
        [157473] = "意志破坏者伊弗里姆",
        [157164] = "狂热者泰科姆",
        [157469] = "神智掠夺者佐斯拉姆",
        [162141] = "扎耶希兹",
    }
else
    -- The names to be displayed in the frames and general chat messages for the English localizations.
    RTU.rare_names = {
        [157170] = "Acolyte Taspu",
        [158557] = "Actiss the Deceiver",
        [157593] = "Amalgamation of Flesh",
        [151883] = "Anaua",
        [155703] = "Anq'uri the Titanic",
        [157472] = "Aphrom the Guise of Madness",
        [154578] = "Aqir Flayer",
        [154576] = "Aqir Titanus",
        [162172] = "Aqir Warcaster",
        [162370] = "Armagedillo",
        [152757] = "Atekhramun",
        [162171] = "Captain Dunewalker",
        [157167] = "Champion Sen-mat",
        [162147] = "Corpse Eater",
        [158531] = "Corrupted Neferset Guard",
        [158594] = "Doomsayer Vathiris",
        [158491] = "Falconer Amenophis",
        [157120] = "Fangtaker Orsa",
        [158633] = "Gaze of N'Zoth",
        [158597] = "High Executor Yothrim",
        [158528] = "High Guard Reshef",
        [162163] = "High Priest Ytaessis",
        [151995] = "Hik-Ten the Taskmaster",
        [160623] = "Hungering Miasma",
        [152431] = "Kaneb-ti",
        [155531] = "Infested Wastewander Captain",
        [157134] = "Ishak of the Four Winds",
        [156655] = "Korzaran the Slaughterer",
        [154604] = "Lord Aj'qirai",
        [156078] = "Magus Rehleth",
        [157157] = "Muminah the Incandescent",
        [152677] = "Nebet the Ascended",
        [162196] = "Obsidian Annihilator",
        [162142] = "Qho",
        [157470] = "R'aas the Anima Devourer",
        [156299] = "R'khuzj the Unfathomable",
        [162173] = "R'krox the Runt",
        [157390] = "R'oyolok the Reality Eater",
        [157146] = "Rotfeaster",
        [152040] = "Scoutmaster Moswen",
        [151948] = "Senbu the Pridefather",
        [161033] = "Shadowmaw",
        [156654] = "Shol'thoss the Doomspeaker",
        [160532] = "Shoth the Darkened",
        [157476] = "Shugshul the Flesh Gorger",
        [162140] = "Skikx'traz",
        [162372] = "Spirit of Cyrus the Black",
        [162352] = "Spirit of Dark Ritualist Zakahn",
        [151878] = "Sun King Nahkotep",
        [151897] = "Sun Priestess Nubitt",
        [151609] = "Sun Prophet Epaphos",
        [152657] = "Tat the Bonechewer",
        [158636] = "The Grand Executor",
        [157188] = "The Tomb Widow",
        [158595] = "Thoughtstealer Vos",
        [152788] = "Uat-ka the Sun's Wrath",
        [162170] = "Warcaster Xeshro",
        [151852] = "Watcher Rehu",
        [157473] = "Yiphrim the Will Ravager",
        [157164] = "Zealot Tekem",
        [157469] = "Zoth'rum the Intellect Pillager",
        [162141] = "Zuythiz",
    }
end

-- Overrides for display names of rares that are too long.
local rare_display_name_overwrites = {}

rare_display_name_overwrites["enUS"] = {}
rare_display_name_overwrites["enGB"] = {}
rare_display_name_overwrites["itIT"] = {
    [157469] = "Zoth'rum",
}
rare_display_name_overwrites["frFR"] = {}
rare_display_name_overwrites["zhCN"] = {}
rare_display_name_overwrites["zhTW"] = {}
rare_display_name_overwrites["koKR"] = {}
rare_display_name_overwrites["deDE"] = {
    [155531] = "Hauptmann der Wüstenwanderer"
}
rare_display_name_overwrites["esES"] = {}
rare_display_name_overwrites["esMX"] = rare_display_name_overwrites["esES"]
rare_display_name_overwrites["ptPT"] = {
    [162352] = "Ritualista das Trevas Zakahn",
}
rare_display_name_overwrites["ptBR"] = rare_display_name_overwrites["ptPT"]
rare_display_name_overwrites["ruRU"] = {
    [155531] = "Зараженный капитан Пустыни",
}

RTU.rare_display_names = {}
for key, value in pairs(RTU.rare_names) do
    if rare_display_name_overwrites[RTU.localization][key] then
        RTU.rare_display_names[key] = rare_display_name_overwrites[RTU.localization][key]
    else
        RTU.rare_display_names[key] = value
    end
end

-- The quest ids that indicate that the rare has been killed already.
RTU.completion_quest_ids = {
    [157170] = 57281, -- "Acolyte Taspu"
    [158557] = 57669, -- "Actiss the Deceiver"
    [157593] = 57667, -- "Amalgamation of Flesh"
    [151883] = 55468, -- "Anaua"
    [155703] = 56834, -- "Anq'uri the Titanic"
    [157472] = 57437, -- "Aphrom the Guise of Madness"
    [154578] = 58612, -- "Aqir Flayer"
    [154576] = 58614, -- "Aqir Titanus"
    [162172] = 58694, -- "Aqir Warcaster"
    [162370] = 58718, -- "Armagedillo"
    [152757] = 55710, -- "Atekhramun"
    [162171] = 58699, -- "Captain Dunewalker"
    [157167] = 57280, -- "Champion Sen-mat"
    [162147] = 58696, -- "Corpse Eater"
    [158531] = 57665, -- "Corrupted Neferset Guard"
    [158594] = 57672, -- "Doomsayer Vathiris"
    [158491] = 57662, -- "Falconer Amenophis"
    [157120] = 57258, -- "Fangtaker Orsa"
    [158633] = 57680, -- "Gaze of N'Zoth"
    [158597] = 57675, -- "High Executor Yothrim"
    [158528] = 57664, -- "High Guard Reshef"
    [162163] = 58701, -- "High Priest Ytaessis"
    [151995] = 55502, -- "Hik-Ten the Taskmaster"
    [160623] = 58206, -- "Hungering Miasma"
    [152431] = 55629, -- "Kaneb-ti"
    [155531] = 56823, -- "Infested Wastewander Captain"
    [157134] = 57259, -- "Ishak of the Four Winds"
    [156655] = 57433, -- "Korzaran the Slaughterer"
    [154604] = 56340, -- "Lord Aj'qirai"
    [156078] = 56952, -- "Magus Rehleth"
    [157157] = 57277, -- "Muminah the Incandescent"
    [152677] = 55684, -- "Nebet the Ascended"
    [162196] = 58681, -- "Obsidian Annihilator"
    [162142] = 58693, -- "Qho"
    [157470] = 57436, -- "R'aas the Anima Devourer"
    [156299] = 57430, -- "R'khuzj the Unfathomable"
    [162173] = 58864, -- "R'krox the Runt"
    [157390] = 57434, -- "R'oyolok the Reality Eater"
    [157146] = 57273, -- "Rotfeaster"
    [152040] = 55518, -- "Scoutmaster Moswen"
    [151948] = 55496, -- "Senbu the Pridefather"
    [161033] = 58333, -- "Shadowmaw"
    [156654] = 57432, -- "Shol'thoss the Doomspeaker"
    [160532] = 58169, -- "Shoth the Darkened"
    [157476] = 57439, -- "Shugshul the Flesh Gorger"
    [162140] = 58697, -- "Skikx'traz"
    [162372] = 58715, -- "Spirit of Cyrus the Black"
    [162352] = 58716, -- "Spirit of Dark Ritualist Zakahn"
    [151878] = 58613, -- "Sun King Nahkotep"
    [151897] = 55479, -- "Sun Priestess Nubitt"
    [151609] = 55353, -- "Sun Prophet Epaphos"
    [152657] = 55682, -- "Tat the Bonechewer"
    [158636] = 57688, -- "The Grand Executor"
    [157188] = 57285, -- "The Tomb Widow"
    [158595] = 57673, -- "Thoughtstealer Vos"
    [152788] = 55716, -- "Uat-ka the Sun's Wrath"
    [162170] = 58702, -- "Warcaster Xeshro"
    [151852] = 55461, -- "Watcher Rehu"
    [157473] = 57438, -- "Yiphrim the Will Ravager"
    [157164] = 57279, -- "Zealot Tekem"
    [157469] = 57435, -- "Zoth'rum the Intellect Pillager"
    [162141] = 58695, -- "Zuythiz"
}

RTU.completion_quest_inverse = {
    [57281] = {157170}, -- "Acolyte Taspu"
    [57669] = {158557}, -- "Actiss the Deceiver"
    [57667] = {157593}, -- "Amalgamation of Flesh"
    [55468] = {151883}, -- "Anaua"
    [56834] = {155703}, -- "Anq'uri the Titanic"
    [57437] = {157472}, -- "Aphrom the Guise of Madness"
    [58612] = {154578}, -- "Aqir Flayer"
    [58614] = {154576}, -- "Aqir Titanus"
    [58694] = {162172}, -- "Aqir Warcaster"
    [58718] = {162370}, -- "Armagedillo"
    [55710] = {152757}, -- "Atekhramun"
    [58699] = {162171}, -- "Captain Dunewalker"
    [57280] = {157167}, -- "Champion Sen-mat"
    [58696] = {162147}, -- "Corpse Eater"
    [57665] = {158531}, -- "Corrupted Neferset Guard"
    [57672] = {158594}, -- "Doomsayer Vathiris"
    [57662] = {158491}, -- "Falconer Amenophis"
    [57258] = {157120}, -- "Fangtaker Orsa"
    [57680] = {158633}, -- "Gaze of N'Zoth"
    [57675] = {158597}, -- "High Executor Yothrim"
    [57664] = {158528}, -- "High Guard Reshef"
    [58701] = {162163}, -- "High Priest Ytaessis"
    [55502] = {151995}, -- "Hik-Ten the Taskmaster"
    [58206] = {160623}, -- "Hungering Miasma"
    [55629] = {152431}, -- "Kaneb-ti"
    [56823] = {155531}, -- "Infested Wastewander Captain"
    [57259] = {157134}, -- "Ishak of the Four Winds"
    [57433] = {156655}, -- "Korzaran the Slaughterer"
    [56340] = {154604}, -- "Lord Aj'qirai"
    [56952] = {156078}, -- "Magus Rehleth"
    [57277] = {157157}, -- "Muminah the Incandescent"
    [55684] = {152677}, -- "Nebet the Ascended"
    [58681] = {162196}, -- "Obsidian Annihilator"
    [58693] = {162142}, -- "Qho"
    [57436] = {157470}, -- "R'aas the Anima Devourer"
    [57430] = {156299}, -- "R'khuzj the Unfathomable"
    [58864] = {162173}, -- "R'krox the Runt"
    [57434] = {157390}, -- "R'oyolok the Reality Eater"
    [57273] = {157146}, -- "Rotfeaster"
    [55518] = {152040}, -- "Scoutmaster Moswen"
    [55496] = {151948}, -- "Senbu the Pridefather"
    [58333] = {161033}, -- "Shadowmaw"
    [57432] = {156654}, -- "Shol'thoss the Doomspeaker"
    [58169] = {160532}, -- "Shoth the Darkened"
    [57439] = {157476}, -- "Shugshul the Flesh Gorger"
    [58697] = {162140}, -- "Skikx'traz"
    [58715] = {162372}, -- "Spirit of Cyrus the Black"
    [58716] = {162352}, -- "Spirit of Dark Ritualist Zakahn"
    [58613] = {151878}, -- "Sun King Nahkotep"
    [55479] = {151897}, -- "Sun Priestess Nubitt"
    [55353] = {151609}, -- "Sun Prophet Epaphos"
    [55682] = {152657}, -- "Tat the Bonechewer"
    [57688] = {158636}, -- "The Grand Executor"
    [57285] = {157188}, -- "The Tomb Widow"
    [57673] = {158595}, -- "Thoughtstealer Vos"
    [55716] = {152788}, -- "Uat-ka the Sun's Wrath"
    [58702] = {162170}, -- "Warcaster Xeshro"
    [55461] = {151852}, -- "Watcher Rehu"
    [57438] = {157473}, -- "Yiphrim the Will Ravager"
    [57279] = {157164}, -- "Zealot Tekem"
    [57435] = {157469}, -- "Zoth'rum the Intellect Pillager"
    [58695] = {162141}, -- "Zuythiz"
}

-- A set of placeholder icons, which will be used if the rare location is not yet known.
RTU.rare_coordinates = {
    [157170] = {["x"] = 64, ["y"] = 26}, -- "Acolyte Taspu"
    [158557] = {["x"] = 66.77, ["y"] = 74.33}, -- "Actiss the Deceiver"
    [157593] = {["x"] = 70, ["y"] = 50}, -- "Amalgamation of Flesh"
    [151883] = {["x"] = 69, ["y"] = 49}, -- "Anaua"
    [155703] = {["x"] = 32, ["y"] = 64}, -- "Anq'uri the Titanic"
    [157472] = {["x"] = 50, ["y"] = 79}, -- "Aphrom the Guise of Madness"
    [154578] = {["x"] = 39, ["y"] = 25}, -- "Aqir Flayer"
    [154576] = {["x"] = 31, ["y"] = 57}, -- "Aqir Titanus"
    [162172] = {["x"] = 38, ["y"] = 45}, -- "Aqir Warcaster"
    [162370] = {["x"] = 44, ["y"] = 42}, -- "Armagedillo"
    [152757] = {["x"] = 65.3, ["y"] = 51.6}, -- "Atekhramun"
    [162171] = {["x"] = 45, ["y"] = 57}, -- "Captain Dunewalker"
    [157167] = {["x"] = 75, ["y"] = 52}, -- "Champion Sen-mat"
    [162147] = {["x"] = 30, ["y"] = 49}, -- "Corpse Eater"
    [158531] = {["x"] = 50, ["y"] = 79}, -- "Corrupted Neferset Guard"
    [158594] = {["x"] = 49, ["y"] = 38}, -- "Doomsayer Vathiris"
    [158491] = {["x"] = 48, ["y"] = 70}, -- "Falconer Amenophis"
    [157120] = {["x"] = 75, ["y"] = 68}, -- "Fangtaker Orsa"
    [158633] = {["x"] = 55, ["y"] = 53}, -- "Gaze of N'Zoth"
    [158597] = {["x"] = 54, ["y"] = 43}, -- "High Executor Yothrim"
    [158528] = {["x"] = 53.68, ["y"] = 79.33}, -- "High Guard Reshef"
    [162163] = {["x"] = 42, ["y"] = 58}, -- "High Priest Ytaessis"
    [151995] = {["x"] = 80, ["y"] = 47}, -- "Hik-Ten the Taskmaster"
    [160623] = {["x"] = 60, ["y"] = 39}, -- "Hungering Miasma"
    [152431] = {["x"] = 77, ["y"] = 52}, -- "Kaneb-ti"
    [155531] = {["x"] = 19, ["y"] = 58}, -- "Infested Wastewander Captain"
    [157134] = {["x"] = 73, ["y"] = 83}, -- "Ishak of the Four Winds"
    [156655] = {["x"] = 71, ["y"] = 73}, -- "Korzaran the Slaughterer"
    [154604] = {["x"] = 34, ["y"] = 18}, -- "Lord Aj'qirai"
    [156078] = {["x"] = 30, ["y"] = 66}, -- "Magus Rehleth"
    [157157] = {["x"] = 66, ["y"] = 20}, -- "Muminah the Incandescent"
    [152677] = {["x"] = 61, ["y"] = 24}, -- "Nebet the Ascended"
    [162196] = {["x"] = 35, ["y"] = 17}, -- "Obsidian Annihilator"
    [162142] = {["x"] = 37, ["y"] = 59}, -- "Qho"
    [157470] = {["x"] = 51, ["y"] = 88}, -- "R'aas the Anima Devourer"
    [156299] = {["x"] = 58, ["y"] = 57}, -- "R'khuzj the Unfathomable"
    [162173] = {["x"] = 28, ["y"] = 13}, -- "R'krox the Runt"
    -- [157390] -- "R'oyolok the Reality Eater"
    [157146] = {["x"] = 69, ["y"] = 32}, -- "Rotfeaster"
    [152040] = {["x"] = 70, ["y"] = 42}, -- "Scoutmaster Moswen"
    [151948] = {["x"] = 74, ["y"] = 65}, -- "Senbu the Pridefather"
    [161033] = {["x"] = 57, ["y"] = 38}, -- "Shadowmaw"
    [156654] = {["x"] = 59, ["y"] = 83}, -- "Shol'thoss the Doomspeaker"
    [160532] = {["x"] = 61, ["y"] = 75}, -- "Shoth the Darkened"
    [157476] = {["x"] = 55, ["y"] = 80}, -- "Shugshul the Flesh Gorger"
    [162140] = {["x"] = 21, ["y"] = 61}, -- "Skikx'traz"
    [162372] = {["x"] = 67, ["y"] = 68}, -- "Spirit of Cyrus the Black"
    [162352] = {["x"] = 52, ["y"] = 40}, -- "Spirit of Dark Ritualist Zakahn"
    [151878] = {["x"] = 79, ["y"] = 64}, -- "Sun King Nahkotep"
    [151897] = {["x"] = 85, ["y"] = 57}, -- "Sun Priestess Nubitt"
    [151609] = {["x"] = 73, ["y"] = 74}, -- "Sun Prophet Epaphos"
    [152657] = {["x"] = 66, ["y"] = 35}, -- "Tat the Bonechewer"
    [158636] = {["x"] = 49, ["y"] = 82}, -- "The Grand Executor"
    [157188] = {["x"] = 84, ["y"] = 47}, -- "The Tomb Widow"
    [158595] = {["x"] = 65, ["y"] = 72}, -- "Thoughtstealer Vos"
    [152788] = {["x"] = 68, ["y"] = 64}, -- "Uat-ka the Sun's Wrath"
    [162170] = {["x"] = 34, ["y"] = 26}, -- "Warcaster Xeshro"
    [151852] = {["x"] = 80, ["y"] = 52}, -- "Watcher Rehu"
    -- [157473] -- "Yiphrim the Will Ravager"
    [157164] = {["x"] = 80, ["y"] = 57}, -- "Zealot Tekem"
    -- [157469] -- "Zoth'rum the Intellect Pillager"
    [162141] = {["x"] = 40, ["y"] = 41}, -- "Zuythiz"
}