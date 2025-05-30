local MDT = MDT
local L = MDT.L
local dungeonIndex = 29
MDT.dungeonList[dungeonIndex] = L["De Other Side"]
MDT.mapInfo[dungeonIndex] = {
  viewportPositionOverrides =
  {
    [1] = {
      zoomScale = 1.2999999523163,
      horizontalPan = 102.41712541524,
      verticalPan = 87.49594729527,
    },
    [2] = {
      zoomScale = 1.2999999523163,
      horizontalPan = 121.73863775574,
      verticalPan = 90.409493722852,
    },
    [3] = {
      zoomScale = 1.2999999523163,
      horizontalPan = 147.68724111862,
      verticalPan = 54.40608486673,
    },
    [4] = {
      zoomScale = 1.5999999046326,
      horizontalPan = 230.48191107345,
      verticalPan = 84.302357414492,
    },
  },
  teleportId = 354468,
  shortName = L["deOtherSideShortName"],
  englishName = "De Other Side",
  mapID = 377
};

local zones = { 1677, 1678, 1679, 1680 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.scaleMultiplier[dungeonIndex] = 1.3

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "DeOtherSide_Ardenweald",
  [1] = "DeOtherSide_Main",
  [2] = "DeOtherSide_Gnome",
  [3] = "DeOtherSide_Hakkar",
  [4] = "DeOtherSide_Ardenweald",
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["De Other Side"],
  [2] = L["Mechagon"],
  [3] = L["Zul'Gurub"],
  [4] = L["Ardenweald"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 384, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {
  [1] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 425.34581434668,
      ["y"] = -496.78200170972,
      ["target"] = 2,
      ["direction"] = -1,
      ["connectionIndex"] = 1,
    },
    [2] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 609.62984287316,
      ["y"] = -321.44105600137,
      ["target"] = 4,
      ["direction"] = 2,
      ["connectionIndex"] = 2,
    },
    [3] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 233.5615662991,
      ["y"] = -323.0244548815,
      ["target"] = 3,
      ["direction"] = -2,
      ["connectionIndex"] = 3,
    },
  },
  [2] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 414.86600451766,
      ["y"] = -129.05231596606,
      ["target"] = 1,
      ["direction"] = 1,
      ["connectionIndex"] = 1,
    },
  },
  [3] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 697.51109695369,
      ["y"] = -269.18739796662,
      ["target"] = 1,
      ["direction"] = 2,
      ["connectionIndex"] = 3,
    },
  },
  [4] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 283.13229583992,
      ["y"] = -327.26341521812,
      ["target"] = 1,
      ["direction"] = -2,
      ["connectionIndex"] = 2,
    },
  },
};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Risen Bonesoldier",
    ["id"] = 168949,
    ["count"] = 4,
    ["health"] = 132318,
    ["scale"] = 1,
    ["displayId"] = 96958,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Control Undead"] = true,
      ["Silence"] = true,
      ["Shackle Undead"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [333728] = {
      },
      [333729] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 430.84325228126,
        ["y"] = -130.3544057562,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 435.15384182747,
        ["y"] = -184.47714226447,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 420.94837044418,
        ["y"] = -184.01432683476,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 337.90144255441,
        ["y"] = -315.02883429492,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 312.1890208094,
        ["y"] = -339.16537326399,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 312.03233842515,
        ["y"] = -313.86900604587,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 428.69099394222,
        ["y"] = -440.41536790269,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 428.69099394222,
            ["y"] = -440.41536790269,
          },
          [2] = {
            ["x"] = 413.22602000001,
            ["y"] = -438.94856755993,
          },
          [3] = {
            ["x"] = 404.17775928259,
            ["y"] = -439.51409143894,
          },
          [4] = {
            ["x"] = 400.2191163989,
            ["y"] = -445.45200722583,
          },
          [5] = {
            ["x"] = 395.97776011436,
            ["y"] = -452.80373271022,
          },
          [6] = {
            ["x"] = 389.7570702533,
            ["y"] = -453.3692323199,
          },
          [7] = {
            ["x"] = 395.97776011436,
            ["y"] = -452.80373271022,
          },
          [8] = {
            ["x"] = 400.2191163989,
            ["y"] = -445.45200722583,
          },
          [9] = {
            ["x"] = 404.17775928259,
            ["y"] = -439.51409143894,
          },
          [10] = {
            ["x"] = 413.22602000001,
            ["y"] = -438.94856755993,
          },
          [11] = {
            ["x"] = 440.65356409176,
            ["y"] = -439.51409143894,
          },
          [12] = {
            ["x"] = 451.11561023736,
            ["y"] = -440.36235298811,
          },
          [13] = {
            ["x"] = 452.1690508352,
            ["y"] = -444.29537518663,
          },
          [14] = {
            ["x"] = 452.81215760504,
            ["y"] = -451.10718534254,
          },
          [15] = {
            ["x"] = 459.31558513627,
            ["y"] = -452.80373271022,
          },
          [16] = {
            ["x"] = 452.81215760504,
            ["y"] = -451.10718534254,
          },
          [17] = {
            ["x"] = 452.1690508352,
            ["y"] = -444.29537518663,
          },
          [18] = {
            ["x"] = 451.11561023736,
            ["y"] = -440.36235298811,
          },
          [19] = {
            ["x"] = 440.65356409176,
            ["y"] = -439.51409143894,
          },
        },
      },
      [8] = {
        ["x"] = 524.12711661346,
        ["y"] = -309.43576650204,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
    },
  },
  [2] = {
    ["name"] = "Risen Cultist",
    ["id"] = 168992,
    ["count"] = 4,
    ["health"] = 165398,
    ["scale"] = 1,
    ["displayId"] = 96964,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Control Undead"] = true,
      ["Silence"] = true,
      ["Shackle Undead"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [328707] = {
        ["interruptible"] = true,
      },
      [328740] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 421.10862442704,
        ["y"] = -130.54356921374,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 441.6959112792,
        ["y"] = -195.96475534093,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 415.27014934872,
        ["y"] = -196.13839630085,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 330.38852710471,
        ["y"] = -339.88380692342,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 543.86587768346,
        ["y"] = -327.97454951945,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [6] = {
        ["x"] = 553.28271886185,
        ["y"] = -323.59793408895,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 543.06623813352,
        ["y"] = -345.61240639186,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
    },
  },
  [3] = {
    ["name"] = "Risen Warlord",
    ["id"] = 169905,
    ["count"] = 6,
    ["health"] = 297716,
    ["scale"] = 1.3,
    ["displayId"] = 97150,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [333227] = {
      },
      [333641] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 428.21367438716,
        ["y"] = -198.31336330968,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 435.52383634275,
        ["y"] = -478.62835125073,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 418.65533350339,
        ["y"] = -478.7922782417,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
    },
  },
  [4] = {
    ["name"] = "Skeletal Raptor",
    ["id"] = 168986,
    ["count"] = 3,
    ["health"] = 82097,
    ["scale"] = 1,
    ["displayId"] = 33733,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Control Undead"] = true,
      ["Silence"] = true,
      ["Shackle Undead"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [333711] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 325.00761758251,
        ["y"] = -311.69321210911,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 332.37502496391,
        ["y"] = -326.88010023603,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [3] = {
        ["x"] = 440.08477117176,
        ["y"] = -447.20830485009,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [4] = {
        ["x"] = 432.13265605334,
        ["y"] = -451.09882008637,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 439.58097565357,
        ["y"] = -436.45534602755,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 433.42118072824,
        ["y"] = -429.11275869554,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 522.26898550725,
        ["y"] = -299.7,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
    },
  },
  [5] = {
    ["name"] = "Death Speaker",
    ["id"] = 168942,
    ["count"] = 6,
    ["health"] = 281177,
    ["scale"] = 1.3,
    ["displayId"] = 96957,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [333875] = {
        ["interruptible"] = true,
      },
      [334051] = {
      },
      [334076] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 304.55384153377,
        ["y"] = -327.1962504384,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 553.55857934589,
        ["y"] = -336.28735558008,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
    },
  },
  [6] = {
    ["name"] = "Enraged Spirit",
    ["id"] = 168934,
    ["count"] = 8,
    ["health"] = 297716,
    ["scale"] = 1.3,
    ["displayId"] = 97153,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [333787] = {
      },
      [342869] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 341.01367780134,
        ["y"] = -413.71615734533,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 341.01367780134,
            ["y"] = -413.71615734533,
          },
          [2] = {
            ["x"] = 329.50394703386,
            ["y"] = -399.07354739487,
          },
          [3] = {
            ["x"] = 317.34535248528,
            ["y"] = -382.39079783302,
          },
          [4] = {
            ["x"] = 313.95226959566,
            ["y"] = -365.14254861335,
          },
          [5] = {
            ["x"] = 314.23500728991,
            ["y"] = -348.1770492226,
          },
          [6] = {
            ["x"] = 313.95226959566,
            ["y"] = -365.14254861335,
          },
          [7] = {
            ["x"] = 317.34535248528,
            ["y"] = -382.39079783302,
          },
          [8] = {
            ["x"] = 329.50394703386,
            ["y"] = -399.07354739487,
          },
          [9] = {
            ["x"] = 349.8625414489,
            ["y"] = -428.48037902845,
          },
          [10] = {
            ["x"] = 358.6280409732,
            ["y"] = -441.77003356601,
          },
          [11] = {
            ["x"] = 369.65561193679,
            ["y"] = -449.96999702848,
          },
          [12] = {
            ["x"] = 384.35903988825,
            ["y"] = -453.36309205277,
          },
          [13] = {
            ["x"] = 393.6900633397,
            ["y"] = -453.08035435852,
          },
          [14] = {
            ["x"] = 384.35903988825,
            ["y"] = -453.36309205277,
          },
          [15] = {
            ["x"] = 369.65561193679,
            ["y"] = -449.96999702848,
          },
          [16] = {
            ["x"] = 358.6280409732,
            ["y"] = -441.77003356601,
          },
          [17] = {
            ["x"] = 349.8625414489,
            ["y"] = -428.48037902845,
          },
        },
      },
      [2] = {
        ["x"] = 513.13175520464,
        ["y"] = -414.3983697049,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 513.13175520464,
            ["y"] = -414.3983697049,
          },
          [2] = {
            ["x"] = 500.00770718767,
            ["y"] = -430.55444976088,
          },
          [3] = {
            ["x"] = 487.84908836976,
            ["y"] = -444.97511574876,
          },
          [4] = {
            ["x"] = 473.71116007613,
            ["y"] = -452.89234151698,
          },
          [5] = {
            ["x"] = 459.31558513627,
            ["y"] = -452.80373271022,
          },
          [6] = {
            ["x"] = 447.98018543041,
            ["y"] = -454.30611493088,
          },
          [7] = {
            ["x"] = 434.40778106394,
            ["y"] = -455.71991261411,
          },
          [8] = {
            ["x"] = 447.98018543041,
            ["y"] = -454.30611493088,
          },
          [9] = {
            ["x"] = 459.31558513627,
            ["y"] = -452.80373271022,
          },
          [10] = {
            ["x"] = 473.71116007613,
            ["y"] = -452.89234151698,
          },
          [11] = {
            ["x"] = 487.84908836976,
            ["y"] = -444.97511574876,
          },
          [12] = {
            ["x"] = 500.00770718767,
            ["y"] = -430.55444976088,
          },
          [13] = {
            ["x"] = 513.13175520464,
            ["y"] = -414.3983697049,
          },
          [14] = {
            ["x"] = 522.91113500559,
            ["y"] = -396.62345097936,
          },
          [15] = {
            ["x"] = 532.8076823842,
            ["y"] = -381.35451123541,
          },
          [16] = {
            ["x"] = 536.76625279698,
            ["y"] = -372.58901171112,
          },
          [17] = {
            ["x"] = 536.48351510273,
            ["y"] = -352.51315499033,
          },
          [18] = {
            ["x"] = 534.78753163024,
            ["y"] = -327.95180609538,
          },
          [19] = {
            ["x"] = 535.07026932449,
            ["y"] = -308.15873560749,
          },
          [20] = {
            ["x"] = 536.20134144813,
            ["y"] = -285.53809402248,
          },
          [21] = {
            ["x"] = 535.07026932449,
            ["y"] = -308.15873560749,
          },
          [22] = {
            ["x"] = 534.78753163024,
            ["y"] = -327.95180609538,
          },
          [23] = {
            ["x"] = 536.48351510273,
            ["y"] = -352.51315499033,
          },
          [24] = {
            ["x"] = 536.76625279698,
            ["y"] = -372.58901171112,
          },
          [25] = {
            ["x"] = 532.8076823842,
            ["y"] = -381.35451123541,
          },
          [26] = {
            ["x"] = 522.91113500559,
            ["y"] = -396.62345097936,
          },
        },
      },
    },
  },
  [7] = {
    ["name"] = "Defunct Dental Drill",
    ["id"] = 167962,
    ["count"] = 8,
    ["health"] = 297716,
    ["scale"] = 1.3,
    ["displayId"] = 92177,
    ["creatureType"] = "Mechanical",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [331927] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 431.98355156737,
        ["y"] = -216.89875768341,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 488.19575505743,
        ["y"] = -288.27522607573,
        ["sublevel"] = 2,
      },
    },
  },
  [8] = {
    ["name"] = "Volatile Memory",
    ["id"] = 170147,
    ["count"] = 0,
    ["health"] = 33079,
    ["scale"] = 0.6,
    ["displayId"] = 91017,
    ["creatureType"] = "Mechanical",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [331398] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 384.95188778548,
        ["y"] = -272.38130386002,
        ["g"] = 8,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 390.21327056255,
        ["y"] = -269.17512206294,
        ["g"] = 8,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 387.77612206004,
        ["y"] = -278.08317276646,
        ["g"] = 8,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 392.84426206035,
        ["y"] = -274.96224569955,
        ["g"] = 8,
        ["sublevel"] = 2,
      },
      [5] = {
        ["x"] = 520.6730695605,
        ["y"] = -362.21200198522,
        ["g"] = 10,
        ["sublevel"] = 2,
        ["inspiring"] = true,
      },
      [6] = {
        ["x"] = 528.42507157294,
        ["y"] = -361.56308117398,
        ["g"] = 10,
        ["sublevel"] = 2,
      },
      [7] = {
        ["x"] = 519.17210799443,
        ["y"] = -353.63172759558,
        ["g"] = 10,
        ["sublevel"] = 2,
      },
      [8] = {
        ["x"] = 527.82497991473,
        ["y"] = -355.23699897191,
        ["g"] = 10,
        ["sublevel"] = 2,
      },
    },
  },
  [9] = {
    ["name"] = "Headless Client",
    ["id"] = 167963,
    ["count"] = 5,
    ["health"] = 165398,
    ["scale"] = 1,
    ["displayId"] = 91123,
    ["creatureType"] = "Mechanical",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [332156] = {
      },
      [332158] = {
      },
      [332196] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 412.19996962823,
        ["y"] = -273.51848572772,
        ["g"] = 8,
        ["sublevel"] = 2,
        ["inspiring"] = true,
      },
      [2] = {
        ["x"] = 447.21102163053,
        ["y"] = -289.20711596381,
        ["g"] = 9,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 455.60969701103,
        ["y"] = -283.19923192762,
        ["g"] = 9,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 456.6648220674,
        ["y"] = -291.79067262322,
        ["g"] = 9,
        ["sublevel"] = 2,
      },
    },
  },
  [10] = {
    ["name"] = "4.RF-4.RF",
    ["id"] = 167964,
    ["count"] = 8,
    ["health"] = 297716,
    ["scale"] = 1.3,
    ["displayId"] = 68856,
    ["creatureType"] = "Mechanical",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [331548] = {
      },
      [331846] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 425.53752288965,
        ["y"] = -276.80257817476,
        ["g"] = 8,
        ["sublevel"] = 2,
      },
    },
  },
  [11] = {
    ["name"] = "Lubricator",
    ["id"] = 167965,
    ["count"] = 5,
    ["health"] = 231557,
    ["scale"] = 1,
    ["displayId"] = 91631,
    ["creatureType"] = "Mechanical",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [331379] = {
        ["interruptible"] = true,
      },
      [332084] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 519.43912463397,
        ["y"] = -382.67639304969,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 509.8831546429,
        ["y"] = -357.6075390558,
        ["g"] = 10,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 524.03002603411,
        ["y"] = -417.05119004857,
        ["sublevel"] = 2,
      },
    },
  },
  [12] = {
    ["name"] = "Sentient Oil",
    ["id"] = 167967,
    ["count"] = 6,
    ["health"] = 181938,
    ["scale"] = 1,
    ["displayId"] = 90423,
    ["creatureType"] = "Aberration",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Banish"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [332234] = {
        ["interruptible"] = true,
      },
      [332236] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 489.87340991373,
        ["y"] = -446.34853679966,
        ["g"] = 11,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 504.42378378378,
        ["y"] = -443.55,
        ["g"] = 11,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 498.74986167371,
        ["y"] = -454.90648000524,
        ["g"] = 11,
        ["sublevel"] = 2,
      },
    },
  },
  [13] = {
    ["name"] = "Millhouse Manastorm",
    ["id"] = 164556,
    ["count"] = 0,
    ["health"] = 892053,
    ["scale"] = 1,
    ["displayId"] = 68818,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["isBoss"] = true,
    ["encounterID"] = 2409,
    ["instanceID"] = 1188,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [320008] = {
      },
      [320132] = {
      },
      [320141] = {
      },
      [320787] = {
      },
      [342905] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 432.77405405405,
        ["y"] = -348.48,
        ["g"] = 12,
        ["sublevel"] = 2,
      },
    },
  },
  [14] = {
    ["name"] = "Millificent Manastorm",
    ["id"] = 164555,
    ["count"] = 0,
    ["health"] = 759897,
    ["scale"] = 1,
    ["displayId"] = 67422,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["isBoss"] = true,
    ["encounterID"] = 2409,
    ["instanceID"] = 1188,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [320145] = {
      },
      [320147] = {
      },
      [320168] = {
      },
      [320785] = {
      },
      [320823] = {
      },
      [321061] = {
      },
      [323877] = {
      },
      [324010] = {
      },
      [332509] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 406.57513513514,
        ["y"] = -375.795,
        ["g"] = 12,
        ["sublevel"] = 2,
      },
    },
  },
  [15] = {
    ["name"] = "Atal'ai Hoodoo Hexxer",
    ["id"] = 170572,
    ["count"] = 6,
    ["health"] = 264636,
    ["scale"] = 1,
    ["displayId"] = 97345,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [332605] = {
        ["interruptible"] = true,
      },
      [332608] = {
        ["interruptible"] = true,
      },
      [332612] = {
        ["interruptible"] = true,
      },
      [332693] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 585.95165105373,
        ["y"] = -273.72116211514,
        ["sublevel"] = 3,
        ["patrol"] = {
          [1] = {
            ["x"] = 585.95165105373,
            ["y"] = -270.7752087178,
          },
          [2] = {
            ["x"] = 605.25110818439,
            ["y"] = -270.72155438794,
          },
          [3] = {
            ["x"] = 620.31938723365,
            ["y"] = -269.69997373232,
          },
          [4] = {
            ["x"] = 634.87687047493,
            ["y"] = -268.4230170934,
          },
          [5] = {
            ["x"] = 620.31938723365,
            ["y"] = -269.69997373232,
          },
          [6] = {
            ["x"] = 605.25110818439,
            ["y"] = -270.72155438794,
          },
          [7] = {
            ["x"] = 585.95165105373,
            ["y"] = -270.7752087178,
          },
          [8] = {
            ["x"] = 569.49586196013,
            ["y"] = -270.46616744429,
          },
          [9] = {
            ["x"] = 549.5751104178,
            ["y"] = -270.2107695403,
          },
          [10] = {
            ["x"] = 540.89169128555,
            ["y"] = -270.46616744429,
          },
          [11] = {
            ["x"] = 549.5751104178,
            ["y"] = -270.2107695403,
          },
          [12] = {
            ["x"] = 569.49586196013,
            ["y"] = -270.46616744429,
          },
        },
      },
      [2] = {
        ["x"] = 481.29628499167,
        ["y"] = -263.00522566624,
        ["g"] = 15,
        ["sublevel"] = 3,
      },
      [3] = {
        ["x"] = 384.88233152341,
        ["y"] = -262.6534205006,
        ["g"] = 16,
        ["sublevel"] = 3,
      },
    },
  },
  [16] = {
    ["name"] = "Atal'ai High Priest",
    ["id"] = 170490,
    ["count"] = 5,
    ["health"] = 181938,
    ["scale"] = 1,
    ["displayId"] = 97300,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [332705] = {
        ["interruptible"] = true,
      },
      [332706] = {
        ["interruptible"] = true,
      },
      [332707] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 644.18817701958,
        ["y"] = -256.70353606287,
        ["g"] = 13,
        ["sublevel"] = 3,
        ["inspiring"] = true,
      },
      [2] = {
        ["x"] = 526.69605524093,
        ["y"] = -275.05341932947,
        ["g"] = 14,
        ["sublevel"] = 3,
        ["inspiring"] = true,
      },
      [3] = {
        ["x"] = 385.3806741573,
        ["y"] = -273.70144976399,
        ["g"] = 16,
        ["sublevel"] = 3,
        ["inspiring"] = true,
      },
    },
  },
  [17] = {
    ["name"] = "Atal'ai Devoted",
    ["id"] = 170486,
    ["count"] = 2,
    ["health"] = 10135,
    ["scale"] = 1,
    ["displayId"] = 97298,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 651.1905641926,
        ["y"] = -268.00952122972,
        ["g"] = 13,
        ["sublevel"] = 3,
      },
      [2] = {
        ["x"] = 638.85133506071,
        ["y"] = -266.93029662882,
        ["g"] = 13,
        ["sublevel"] = 3,
      },
      [3] = {
        ["x"] = 490.65463620323,
        ["y"] = -259.35012998545,
        ["g"] = 15,
        ["sublevel"] = 3,
      },
      [4] = {
        ["x"] = 493.77579539414,
        ["y"] = -269.44698921297,
        ["g"] = 15,
        ["sublevel"] = 3,
      },
      [5] = {
        ["x"] = 485.40145123356,
        ["y"] = -274.39184604584,
        ["g"] = 15,
        ["sublevel"] = 3,
      },
    },
  },
  [18] = {
    ["name"] = "Atal'ai Deathwalker",
    ["id"] = 170480,
    ["count"] = 5,
    ["health"] = 198477,
    ["scale"] = 1,
    ["displayId"] = 97294,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Control Undead"] = true,
      ["Silence"] = true,
      ["Shackle Undead"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [332671] = {
      },
      [332678] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 533.05078651685,
        ["y"] = -268.25623735671,
        ["g"] = 14,
        ["sublevel"] = 3,
      },
      [2] = {
        ["x"] = 523.42382022472,
        ["y"] = -265.37457855698,
        ["g"] = 14,
        ["sublevel"] = 3,
      },
      [3] = {
        ["x"] = 391.36449438202,
        ["y"] = -278.71628455833,
        ["g"] = 16,
        ["sublevel"] = 3,
      },
      [4] = {
        ["x"] = 391.19460674157,
        ["y"] = -256.52376938638,
        ["g"] = 16,
        ["sublevel"] = 3,
      },
    },
  },
  [19] = {
    ["name"] = "Hakkar the Soulflayer",
    ["id"] = 164558,
    ["count"] = 0,
    ["health"] = 958131,
    ["scale"] = 1,
    ["displayId"] = 95484,
    ["creatureType"] = "Beast",
    ["level"] = 60,
    ["isBoss"] = true,
    ["encounterID"] = 2408,
    ["instanceID"] = 1188,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [322736] = {
      },
      [322759] = {
      },
      [323064] = {
      },
      [323166] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 222.35192565928,
        ["y"] = -269.81384259559,
        ["sublevel"] = 3,
      },
    },
  },
  [20] = {
    ["name"] = "Weald Shimmermoth",
    ["id"] = 164862,
    ["count"] = 3,
    ["health"] = 148858,
    ["scale"] = 1,
    ["displayId"] = 95199,
    ["creatureType"] = "Beast",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [334493] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 336.92667201929,
        ["y"] = -318.15985530423,
        ["g"] = 18,
        ["sublevel"] = 4,
      },
      [2] = {
        ["x"] = 326.3149634769,
        ["y"] = -318.12354158851,
        ["g"] = 18,
        ["sublevel"] = 4,
      },
      [3] = {
        ["x"] = 321.58710447761,
        ["y"] = -293.53178724928,
        ["g"] = 17,
        ["sublevel"] = 4,
      },
      [4] = {
        ["x"] = 318.12680597015,
        ["y"] = -298.9982987106,
        ["g"] = 17,
        ["sublevel"] = 4,
      },
      [5] = {
        ["x"] = 502.12777306043,
        ["y"] = -198.49160526323,
        ["g"] = 33,
        ["sublevel"] = 4,
      },
      [6] = {
        ["x"] = 524.92181201618,
        ["y"] = -233.21136666586,
        ["g"] = 35,
        ["sublevel"] = 4,
      },
      [7] = {
        ["x"] = 552.06502701215,
        ["y"] = -267.75058054279,
        ["g"] = 36,
        ["sublevel"] = 4,
      },
      [8] = {
        ["x"] = 542.89748441158,
        ["y"] = -268.02029490016,
        ["g"] = 36,
        ["sublevel"] = 4,
      },
    },
  },
  [21] = {
    ["name"] = "Spriggan Mendbender",
    ["id"] = 164857,
    ["count"] = 2,
    ["health"] = 115779,
    ["scale"] = 1,
    ["stealth"] = true,
    ["displayId"] = 95696,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [30831] = {
      },
      [321349] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 368.29196165168,
        ["y"] = -319.61692911431,
        ["g"] = 20,
        ["sublevel"] = 4,
      },
      [2] = {
        ["x"] = 366.2680681725,
        ["y"] = -262.03393196566,
        ["g"] = 21,
        ["sublevel"] = 4,
      },
      [3] = {
        ["x"] = 372.90103578002,
        ["y"] = -253.04229035843,
        ["g"] = 21,
        ["sublevel"] = 4,
      },
      [4] = {
        ["x"] = 426.46781459181,
        ["y"] = -169.98462039035,
        ["g"] = 30,
        ["sublevel"] = 4,
      },
      [5] = {
        ["x"] = 463.1257699944,
        ["y"] = -152.25831795697,
        ["g"] = 31,
        ["sublevel"] = 4,
      },
      [6] = {
        ["x"] = 451.56058871494,
        ["y"] = -213.32334687651,
        ["g"] = 29,
        ["sublevel"] = 4,
      },
      [7] = {
        ["x"] = 493.99874066938,
        ["y"] = -158.90647668332,
        ["g"] = 32,
        ["sublevel"] = 4,
      },
      [8] = {
        ["x"] = 446.42131129432,
        ["y"] = -150.4747893349,
        ["g"] = 31,
        ["sublevel"] = 4,
      },
      [9] = {
        ["x"] = 635.01237347411,
        ["y"] = -273.56531805774,
        ["g"] = 38,
        ["sublevel"] = 4,
      },
    },
  },
  [22] = {
    ["name"] = "Juvenile Runestag",
    ["id"] = 171342,
    ["count"] = 2,
    ["health"] = 132318,
    ["scale"] = 0.8,
    ["displayId"] = 93792,
    ["creatureType"] = "Beast",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [334529] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 332.46952580544,
        ["y"] = -269.82694372785,
        ["g"] = 19,
        ["sublevel"] = 4,
        ["inspiring"] = true,
      },
      [2] = {
        ["x"] = 341.09970659888,
        ["y"] = -262.5323471415,
        ["g"] = 19,
        ["sublevel"] = 4,
      },
      [3] = {
        ["x"] = 412.46045921152,
        ["y"] = -230.56314314017,
        ["g"] = 24,
        ["sublevel"] = 4,
      },
      [4] = {
        ["x"] = 402.68856356775,
        ["y"] = -219.63203869198,
        ["g"] = 24,
        ["sublevel"] = 4,
      },
      [5] = {
        ["x"] = 387.07339998002,
        ["y"] = -177.11162697676,
        ["g"] = 28,
        ["sublevel"] = 4,
      },
      [6] = {
        ["x"] = 391.70468994451,
        ["y"] = -181.8725833681,
        ["g"] = 28,
        ["sublevel"] = 4,
      },
      [7] = {
        ["x"] = 570.94829224327,
        ["y"] = -287.69600833506,
        ["g"] = 37,
        ["sublevel"] = 4,
      },
      [8] = {
        ["x"] = 577.3862293211,
        ["y"] = -279.26929200072,
        ["g"] = 37,
        ["sublevel"] = 4,
      },
    },
  },
  [23] = {
    ["name"] = "Runestag Elderhorn",
    ["id"] = 164873,
    ["count"] = 4,
    ["health"] = 198477,
    ["scale"] = 1,
    ["displayId"] = 93795,
    ["creatureType"] = "Beast",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [345498] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 340.62096814411,
        ["y"] = -272.22414950361,
        ["g"] = 19,
        ["sublevel"] = 4,
        ["patrol"] = {
          [1] = {
            ["x"] = 340.62096814411,
            ["y"] = -272.22414950361,
          },
          [2] = {
            ["x"] = 347.66816135174,
            ["y"] = -280.8081358328,
          },
          [3] = {
            ["x"] = 346.81225159994,
            ["y"] = -291.50708119431,
          },
          [4] = {
            ["x"] = 336.96920680725,
            ["y"] = -296.6425948031,
          },
          [5] = {
            ["x"] = 346.81225159994,
            ["y"] = -291.50708119431,
          },
          [6] = {
            ["x"] = 347.66816135174,
            ["y"] = -280.8081358328,
          },
          [7] = {
            ["x"] = 340.62096814411,
            ["y"] = -272.22414950361,
          },
          [8] = {
            ["x"] = 333.33156740459,
            ["y"] = -260.90807340096,
          },
          [9] = {
            ["x"] = 329.47992760651,
            ["y"] = -252.77685729488,
          },
          [10] = {
            ["x"] = 333.33156740459,
            ["y"] = -260.90807340096,
          },
        },
      },
      [2] = {
        ["x"] = 402.54006613111,
        ["y"] = -229.27383462368,
        ["g"] = 24,
        ["sublevel"] = 4,
        ["patrol"] = {
          [1] = {
            ["x"] = 402.54006613111,
            ["y"] = -229.27383462368,
          },
          [2] = {
            ["x"] = 394.0861297132,
            ["y"] = -236.20018478798,
          },
          [3] = {
            ["x"] = 387.02485130332,
            ["y"] = -242.83354505392,
          },
          [4] = {
            ["x"] = 382.10331972398,
            ["y"] = -248.82495923152,
          },
          [5] = {
            ["x"] = 387.02485130332,
            ["y"] = -242.83354505392,
          },
          [6] = {
            ["x"] = 394.0861297132,
            ["y"] = -236.20018478798,
          },
          [7] = {
            ["x"] = 402.54006613111,
            ["y"] = -229.27383462368,
          },
          [8] = {
            ["x"] = 408.6367056898,
            ["y"] = -221.22163813427,
          },
          [9] = {
            ["x"] = 413.34427360567,
            ["y"] = -214.58829623431,
          },
          [10] = {
            ["x"] = 408.6367056898,
            ["y"] = -221.22163813427,
          },
        },
      },
      [3] = {
        ["x"] = 396.92154668332,
        ["y"] = -187.12372074224,
        ["g"] = 28,
        ["sublevel"] = 4,
      },
      [4] = {
        ["x"] = 579.97220323046,
        ["y"] = -286.18010187548,
        ["g"] = 37,
        ["sublevel"] = 4,
        ["inspiring"] = true,
        ["patrol"] = {
          [1] = {
            ["x"] = 579.97220323046,
            ["y"] = -286.18010187548,
          },
          [2] = {
            ["x"] = 594.5174567575,
            ["y"] = -299.77622888079,
          },
          [3] = {
            ["x"] = 614.43822868843,
            ["y"] = -304.62871196101,
          },
          [4] = {
            ["x"] = 642.0208056257,
            ["y"] = -313.05672158073,
          },
          [5] = {
            ["x"] = 655.04594428265,
            ["y"] = -317.65385061797,
          },
          [6] = {
            ["x"] = 642.0208056257,
            ["y"] = -313.05672158073,
          },
          [7] = {
            ["x"] = 614.43822868843,
            ["y"] = -304.62871196101,
          },
          [8] = {
            ["x"] = 594.5174567575,
            ["y"] = -299.77622888079,
          },
          [9] = {
            ["x"] = 579.97220323046,
            ["y"] = -286.18010187548,
          },
          [10] = {
            ["x"] = 559.52842885688,
            ["y"] = -274.23676925626,
          },
          [11] = {
            ["x"] = 547.01407500828,
            ["y"] = -264.53178117514,
          },
          [12] = {
            ["x"] = 527.85948577005,
            ["y"] = -250.22967501713,
          },
          [13] = {
            ["x"] = 517.89911076493,
            ["y"] = -241.03548270471,
          },
          [14] = {
            ["x"] = 527.85948577005,
            ["y"] = -250.22967501713,
          },
          [15] = {
            ["x"] = 547.01407500828,
            ["y"] = -264.53178117514,
          },
          [16] = {
            ["x"] = 559.52842885688,
            ["y"] = -274.23676925626,
          },
        },
      },
    },
  },
  [24] = {
    ["name"] = "Spriggan Barkbinder",
    ["id"] = 164861,
    ["count"] = 2,
    ["health"] = 115779,
    ["scale"] = 1,
    ["stealth"] = true,
    ["displayId"] = 95695,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [30831] = {
      },
      [321764] = {
        ["interruptible"] = true,
      },
      [339966] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 377.8755068026,
        ["y"] = -323.07782180927,
        ["g"] = 20,
        ["sublevel"] = 4,
      },
      [2] = {
        ["x"] = 371.13654660895,
        ["y"] = -329.42031028296,
        ["g"] = 20,
        ["sublevel"] = 4,
      },
      [3] = {
        ["x"] = 375.954527521,
        ["y"] = -268.04650519317,
        ["g"] = 21,
        ["sublevel"] = 4,
      },
      [4] = {
        ["x"] = 381.15606463006,
        ["y"] = -259.3349480948,
        ["g"] = 21,
        ["sublevel"] = 4,
      },
      [5] = {
        ["x"] = 414.47339867995,
        ["y"] = -168.59286674184,
        ["g"] = 30,
        ["sublevel"] = 4,
      },
      [6] = {
        ["x"] = 458.45395861729,
        ["y"] = -223.55107644576,
        ["g"] = 29,
        ["sublevel"] = 4,
      },
      [7] = {
        ["x"] = 490.81734482948,
        ["y"] = -170.47660259061,
        ["g"] = 32,
        ["sublevel"] = 4,
        ["inspiring"] = true,
      },
      [8] = {
        ["x"] = 423.26674171052,
        ["y"] = -158.73567936227,
        ["g"] = 30,
        ["sublevel"] = 4,
      },
      [9] = {
        ["x"] = 447.18042865273,
        ["y"] = -224.80565049287,
        ["g"] = 29,
        ["sublevel"] = 4,
      },
      [10] = {
        ["x"] = 453.45352074671,
        ["y"] = -160.39215226683,
        ["g"] = 31,
        ["sublevel"] = 4,
      },
      [11] = {
        ["x"] = 501.7661307011,
        ["y"] = -172.12121383827,
        ["g"] = 32,
        ["sublevel"] = 4,
      },
      [12] = {
        ["x"] = 491.0045973844,
        ["y"] = -206.58904039042,
        ["g"] = 33,
        ["sublevel"] = 4,
      },
      [13] = {
        ["x"] = 626.20228772955,
        ["y"] = -282.06069395209,
        ["g"] = 38,
        ["sublevel"] = 4,
      },
      [14] = {
        ["x"] = 615.34556810948,
        ["y"] = -280.00290302388,
        ["g"] = 38,
        ["sublevel"] = 4,
      },
    },
  },
  [25] = {
    ["name"] = "Bladebeak Hatchling",
    ["id"] = 171341,
    ["count"] = 1,
    ["health"] = 33079,
    ["scale"] = 0.7,
    ["displayId"] = 95554,
    ["creatureType"] = "Beast",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [334664] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 387.9646303402,
        ["y"] = -304.18852544274,
        ["g"] = 22,
        ["sublevel"] = 4,
      },
      [2] = {
        ["x"] = 390.26048157899,
        ["y"] = -293.80461824326,
        ["g"] = 22,
        ["sublevel"] = 4,
      },
      [3] = {
        ["x"] = 398.30095864883,
        ["y"] = -303.84768585462,
        ["g"] = 22,
        ["sublevel"] = 4,
      },
      [4] = {
        ["x"] = 371.60486853343,
        ["y"] = -235.39671196635,
        ["g"] = 26,
        ["sublevel"] = 4,
      },
      [5] = {
        ["x"] = 365.75847307426,
        ["y"] = -238.91804366513,
        ["g"] = 26,
        ["sublevel"] = 4,
      },
      [6] = {
        ["x"] = 341.84054867371,
        ["y"] = -190.61037555015,
        ["sublevel"] = 4,
      },
      [7] = {
        ["x"] = 520.5191641791,
        ["y"] = -222.66592048711,
        ["g"] = 35,
        ["sublevel"] = 4,
      },
      [8] = {
        ["x"] = 596.73159644245,
        ["y"] = -248.67012117195,
        ["g"] = 39,
        ["sublevel"] = 4,
      },
      [9] = {
        ["x"] = 584.90905646629,
        ["y"] = -208.87554045522,
        ["g"] = 40,
        ["sublevel"] = 4,
      },
      [10] = {
        ["x"] = 606.27516734424,
        ["y"] = -234.51694519227,
        ["g"] = 39,
        ["sublevel"] = 4,
        ["inspiring"] = true,
      },
      [11] = {
        ["x"] = 577.31480199586,
        ["y"] = -205.96944098129,
        ["g"] = 40,
        ["sublevel"] = 4,
      },
      [12] = {
        ["x"] = 582.83343924014,
        ["y"] = -199.43414749928,
        ["g"] = 40,
        ["sublevel"] = 4,
      },
    },
  },
  [26] = {
    ["name"] = "Territorial Bladebeak",
    ["id"] = 171181,
    ["count"] = 4,
    ["health"] = 165398,
    ["scale"] = 1,
    ["displayId"] = 95555,
    ["creatureType"] = "Beast",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [334535] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 458.56462987012,
        ["y"] = -258.86394788185,
        ["g"] = 23,
        ["sublevel"] = 4,
      },
      [2] = {
        ["x"] = 390.1515368287,
        ["y"] = -219.5853199247,
        ["g"] = 25,
        ["sublevel"] = 4,
        ["inspiring"] = true,
        ["patrol"] = {
          [1] = {
            ["x"] = 390.1515368287,
            ["y"] = -219.5853199247,
          },
          [2] = {
            ["x"] = 402.54006613111,
            ["y"] = -229.27383462368,
          },
          [3] = {
            ["x"] = 410.07603500753,
            ["y"] = -239.77226999803,
          },
          [4] = {
            ["x"] = 406.02535303701,
            ["y"] = -258.36854748265,
          },
          [5] = {
            ["x"] = 391.29563346016,
            ["y"] = -274.7553678209,
          },
          [6] = {
            ["x"] = 394.05743118819,
            ["y"] = -290.77395583696,
          },
          [7] = {
            ["x"] = 406.39358535921,
            ["y"] = -300.9006489108,
          },
          [8] = {
            ["x"] = 428.67231249215,
            ["y"] = -298.50707165251,
          },
          [9] = {
            ["x"] = 449.84629524862,
            ["y"] = -292.06281637452,
          },
          [10] = {
            ["x"] = 456.29054262496,
            ["y"] = -271.44118210136,
          },
          [11] = {
            ["x"] = 449.47804712313,
            ["y"] = -249.71484295994,
          },
          [12] = {
            ["x"] = 438.06251326583,
            ["y"] = -241.06113843724,
          },
          [13] = {
            ["x"] = 422.04392524978,
            ["y"] = -228.90910042732,
          },
          [14] = {
            ["x"] = 404.00000415011,
            ["y"] = -212.15403196357,
          },
          [15] = {
            ["x"] = 393.68921466927,
            ["y"] = -200.55437404353,
          },
          [16] = {
            ["x"] = 378.86161671832,
            ["y"] = -186.16860237654,
          },
          [17] = {
            ["x"] = 362.10654825457,
            ["y"] = -188.00979559413,
          },
          [18] = {
            ["x"] = 341.48493768633,
            ["y"] = -197.21588810835,
          },
          [19] = {
            ["x"] = 337.61836397527,
            ["y"] = -213.97096447374,
          },
          [20] = {
            ["x"] = 346.82444068621,
            ["y"] = -236.80203218834,
          },
          [21] = {
            ["x"] = 373.70620617462,
            ["y"] = -228.70069195222,
          },
        },
      },
      [3] = {
        ["x"] = 405.67919458137,
        ["y"] = -256.44554845749,
        ["g"] = 23,
        ["sublevel"] = 4,
      },
      [4] = {
        ["x"] = 328.43937058029,
        ["y"] = -216.55899463699,
        ["g"] = 27,
        ["sublevel"] = 4,
      },
      [5] = {
        ["x"] = 424.75923203729,
        ["y"] = -251.09304441192,
        ["g"] = 23,
        ["sublevel"] = 4,
      },
      [6] = {
        ["x"] = 428.47287898773,
        ["y"] = -268.37593488526,
        ["g"] = 23,
        ["sublevel"] = 4,
      },
      [7] = {
        ["x"] = 386.08010030437,
        ["y"] = -209.62241529618,
        ["g"] = 25,
        ["sublevel"] = 4,
      },
      [8] = {
        ["x"] = 411.1206474819,
        ["y"] = -275.69584695119,
        ["g"] = 23,
        ["sublevel"] = 4,
      },
      [9] = {
        ["x"] = 353.20204061755,
        ["y"] = -199.3251698186,
        ["g"] = 27,
        ["sublevel"] = 4,
      },
      [10] = {
        ["x"] = 369.05940263108,
        ["y"] = -194.95011761987,
        ["g"] = 27,
        ["sublevel"] = 4,
      },
      [11] = {
        ["x"] = 346.61537240015,
        ["y"] = -223.52945442219,
        ["g"] = 27,
        ["sublevel"] = 4,
      },
      [12] = {
        ["x"] = 360.62369660883,
        ["y"] = -212.2625367009,
        ["g"] = 27,
        ["sublevel"] = 4,
      },
      [13] = {
        ["x"] = 379.66844016406,
        ["y"] = -220.49736074068,
        ["g"] = 25,
        ["sublevel"] = 4,
      },
      [14] = {
        ["x"] = 492.60280446794,
        ["y"] = -223.41884934435,
        ["g"] = 34,
        ["sublevel"] = 4,
      },
      [15] = {
        ["x"] = 495.22709335015,
        ["y"] = -231.68279655267,
        ["g"] = 34,
        ["sublevel"] = 4,
      },
      [16] = {
        ["x"] = 516.40790005064,
        ["y"] = -234.23981871928,
        ["g"] = 35,
        ["sublevel"] = 4,
        ["inspiring"] = true,
      },
      [17] = {
        ["x"] = 595.24844074339,
        ["y"] = -235.75033636678,
        ["g"] = 39,
        ["sublevel"] = 4,
      },
      [18] = {
        ["x"] = 597.82484580817,
        ["y"] = -187.14039692993,
        ["g"] = 41,
        ["sublevel"] = 4,
      },
      [19] = {
        ["x"] = 564.96045815832,
        ["y"] = -177.41409697726,
        ["g"] = 41,
        ["sublevel"] = 4,
      },
      [20] = {
        ["x"] = 604.46437649911,
        ["y"] = -209.39226638251,
        ["g"] = 41,
        ["sublevel"] = 4,
      },
    },
  },
  [27] = {
    ["name"] = "Bladebeak Matriarch",
    ["id"] = 171343,
    ["count"] = 5,
    ["health"] = 330795,
    ["scale"] = 1.3,
    ["displayId"] = 95551,
    ["creatureType"] = "Beast",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [334535] = {
      },
      [334800] = {
      },
      [334967] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 446.50013797699,
        ["y"] = -303.92814736856,
        ["sublevel"] = 4,
      },
      [2] = {
        ["x"] = 374.6588609606,
        ["y"] = -175.29176806545,
        ["sublevel"] = 4,
      },
      [3] = {
        ["x"] = 482.08078588761,
        ["y"] = -231.19470649304,
        ["g"] = 34,
        ["sublevel"] = 4,
      },
      [4] = {
        ["x"] = 548.65045228019,
        ["y"] = -212.57857741789,
        ["sublevel"] = 4,
      },
    },
  },
  [28] = {
    ["name"] = "Mythresh, Sky's Talons",
    ["id"] = 171184,
    ["count"] = 12,
    ["health"] = 396955,
    ["scale"] = 1.3,
    ["displayId"] = 96412,
    ["creatureType"] = "Dragonkin",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [340016] = {
      },
      [340026] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 459.57049968443,
        ["y"] = -189.01868421309,
        ["sublevel"] = 4,
      },
    },
  },
  [29] = {
    ["name"] = "Dealer Xy'exa",
    ["id"] = 164450,
    ["count"] = 0,
    ["health"] = 1123326,
    ["scale"] = 1,
    ["displayId"] = 97540,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["isBoss"] = true,
    ["encounterID"] = 2398,
    ["instanceID"] = 1188,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [320230] = {
      },
      [323687] = {
      },
      [324090] = {
      },
      [342961] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 701.32728358209,
        ["y"] = -316.46131805158,
        ["sublevel"] = 4,
      },
    },
  },
  [30] = {
    ["name"] = "Mueh'zala",
    ["id"] = 166608,
    ["count"] = 0,
    ["health"] = 13215600,
    ["scale"] = 1,
    ["displayId"] = 96358,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["isBoss"] = true,
    ["encounterID"] = 2410,
    ["instanceID"] = 1188,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [325258] = {
      },
      [325691] = {
      },
      [325725] = {
      },
      [325807] = {
      },
      [326171] = {
      },
      [327646] = {
      },
      [327649] = {
      },
      [334810] = {
      },
      [334961] = {
      },
      [334970] = {
      },
      [335000] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 501.65449275362,
        ["y"] = -321.77934782609,
        ["sublevel"] = 1,
      },
    },
  },
  [31] = {
    ["name"] = "Incinerator Arkolath",
    ["id"] = 179446,
    ["count"] = 0,
    ["health"] = 336131,
    ["ignoreFortified"] = true,
    ["scale"] = 1.5,
    ["displayId"] = 100718,
    ["iconTexture"] = 236297,
    ["creatureType"] = "Humanoid",
    ["level"] = 61,
    ["include"] = {
      ["level"] = 10,
      ["affix"] = 128,
    },
    ["powers"] = {
      [357575] = {
        ["dps"] = true,
        ["healer"] = true,
        ["tank"] = true,
      },
      [357839] = {
        ["tank"] = true,
      },
      [357848] = {
        ["dps"] = true,
      },
      [357864] = {
        ["dps"] = true,
      },
      [357889] = {
        ["healer"] = true,
      },
      [357897] = {
        ["tank"] = true,
      },
      [357900] = {
        ["healer"] = true,
      },
    },
    ["spells"] = {
      [355707] = {
      },
      [355732] = {
      },
      [355737] = {
      },
      [358967] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 301.35232310413,
        ["y"] = -353.75739821598,
        ["sublevel"] = 1,
        ["week"] = {
          [1] = true,
          [2] = true,
          [5] = true,
          [6] = true,
          [9] = true,
          [10] = true,
        },
      },
      [2] = {
        ["x"] = 519.5664629665,
        ["y"] = -355.4057005356,
        ["sublevel"] = 1,
        ["week"] = {
          [3] = true,
          [4] = true,
          [7] = true,
          [8] = true,
          [11] = true,
          [12] = true,
        },
      },
    },
  },
  [32] = {
    ["name"] = "Oros Coldheart",
    ["id"] = 179892,
    ["count"] = 0,
    ["health"] = 336131,
    ["ignoreFortified"] = true,
    ["scale"] = 1.5,
    ["displayId"] = 97237,
    ["iconTexture"] = 136213,
    ["creatureType"] = "Humanoid",
    ["level"] = 61,
    ["include"] = {
      ["level"] = 10,
      ["affix"] = 128,
    },
    ["powers"] = {
      [357815] = {
        ["dps"] = true,
        ["healer"] = true,
      },
      [357817] = {
        ["tank"] = true,
      },
      [357820] = {
        ["tank"] = true,
      },
      [357825] = {
        ["dps"] = true,
      },
      [357829] = {
        ["healer"] = true,
      },
      [357834] = {
        ["dps"] = true,
        ["tank"] = true,
      },
      [357842] = {
        ["healer"] = true,
      },
    },
    ["spells"] = {
      [355710] = {
      },
      [356414] = {
      },
      [356666] = {
      },
      [358894] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 519.5664629665,
        ["y"] = -355.4057005356,
        ["sublevel"] = 1,
        ["week"] = {
          [1] = true,
          [2] = true,
          [5] = true,
          [6] = true,
          [9] = true,
          [10] = true,
        },
      },
      [2] = {
        ["x"] = 301.35232310413,
        ["y"] = -353.75739821598,
        ["sublevel"] = 1,
        ["week"] = {
          [3] = true,
          [4] = true,
          [7] = true,
          [8] = true,
          [11] = true,
          [12] = true,
        },
      },
    },
  },
  [33] = {
    ["name"] = "Soggodon the Breaker",
    ["id"] = 179891,
    ["count"] = 0,
    ["health"] = 358540,
    ["ignoreFortified"] = true,
    ["scale"] = 1.5,
    ["displayId"] = 98535,
    ["iconTexture"] = 2103898,
    ["creatureType"] = "Humanoid",
    ["level"] = 62,
    ["include"] = {
      ["level"] = 10,
      ["affix"] = 128,
    },
    ["powers"] = {
      [356827] = {
        ["dps"] = true,
        ["healer"] = true,
      },
      [356828] = {
        ["dps"] = true,
        ["tank"] = true,
      },
      [357524] = {
        ["dps"] = true,
        ["healer"] = true,
        ["tank"] = true,
      },
      [357556] = {
        ["healer"] = true,
      },
      [357778] = {
        ["tank"] = true,
      },
    },
    ["spells"] = {
      [355719] = {
      },
      [355806] = {
      },
      [358784] = {
      },
      [358968] = {
      },
      [358970] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 429.31243632103,
        ["y"] = -231.55688066273,
        ["sublevel"] = 2,
        ["week"] = {
          [1] = true,
          [2] = true,
          [5] = true,
          [6] = true,
          [9] = true,
          [10] = true,
        },
      },
      [2] = {
        ["x"] = 354.11801353272,
        ["y"] = -267.53464555794,
        ["sublevel"] = 4,
        ["week"] = {
          [3] = true,
          [4] = true,
          [7] = true,
          [8] = true,
          [11] = true,
          [12] = true,
        },
      },
    },
  },
  [34] = {
    ["name"] = "Executioner Varruth",
    ["id"] = 179890,
    ["count"] = 0,
    ["health"] = 336131,
    ["ignoreFortified"] = true,
    ["scale"] = 1.5,
    ["displayId"] = 92418,
    ["iconTexture"] = 237552,
    ["creatureType"] = "Humanoid",
    ["level"] = 61,
    ["include"] = {
      ["level"] = 10,
      ["affix"] = 128,
    },
    ["powers"] = {
      [357575] = {
        ["dps"] = true,
        ["healer"] = true,
        ["tank"] = true,
      },
      [357604] = {
        ["tank"] = true,
      },
      [357609] = {
        ["dps"] = true,
      },
      [357706] = {
        ["dps"] = true,
      },
      [357747] = {
        ["healer"] = true,
      },
      [357847] = {
        ["healer"] = true,
      },
      [357863] = {
        ["tank"] = true,
      },
    },
    ["spells"] = {
      [355714] = {
      },
      [356923] = {
      },
      [356925] = {
      },
      [358971] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 354.11801353272,
        ["y"] = -267.53464555794,
        ["sublevel"] = 4,
        ["week"] = {
          [1] = true,
          [2] = true,
          [5] = true,
          [6] = true,
          [9] = true,
          [10] = true,
        },
      },
      [2] = {
        ["x"] = 429.31243632103,
        ["y"] = -231.55688066273,
        ["sublevel"] = 2,
        ["week"] = {
          [3] = true,
          [4] = true,
          [7] = true,
          [8] = true,
          [11] = true,
          [12] = true,
        },
      },
    },
  },
  [35] = {
    ["name"] = "Wo Relic",
    ["id"] = 185683,
    ["count"] = 0,
    ["health"] = 27566,
    ["ignoreFortified"] = true,
    ["scale"] = 1,
    ["displayId"] = 101046,
    ["iconTexture"] = 4335644,
    ["creatureType"] = "Mechanical",
    ["level"] = 62,
    ["bonusSpell"] = 368241,
    ["badCreatureModel"] = true,
    ["modelPosition"] = {
      [1] = 0,
      [2] = 0,
      [3] = 0.6,
    },
    ["include"] = {
      ["level"] = 10,
      ["affix"] = 130,
    },
    ["spells"] = {
      [366566] = {
      },
      [368078] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 428.48643867853,
        ["y"] = -214.41576246776,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 544.48742267707,
        ["y"] = -315.39407671355,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 358.81205858206,
        ["y"] = -224.31354078736,
        ["sublevel"] = 4,
      },
      [4] = {
        ["x"] = 512.13281932004,
        ["y"] = -246.07896661376,
        ["sublevel"] = 4,
      },
      [5] = {
        ["x"] = 689.85275425222,
        ["y"] = -334.67717475994,
        ["sublevel"] = 4,
      },
      [6] = {
        ["x"] = 426.36419490985,
        ["y"] = -464.94124684016,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 450.20613116741,
        ["y"] = -302.02525271517,
        ["sublevel"] = 2,
      },
      [8] = {
        ["x"] = 428.99206024075,
        ["y"] = -369.32571454417,
        ["sublevel"] = 2,
      },
      [9] = {
        ["x"] = 298.731191505,
        ["y"] = -312.22379547775,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 643.67007699485,
        ["y"] = -278.25421685115,
        ["sublevel"] = 3,
      },
      [11] = {
        ["x"] = 236.6993931525,
        ["y"] = -289.77744212083,
        ["sublevel"] = 3,
      },
      [12] = {
        ["x"] = 501.02111013176,
        ["y"] = -342.79120235421,
        ["sublevel"] = 1,
      },
    },
  },
  [36] = {
    ["name"] = "Urh Relic",
    ["id"] = 185685,
    ["count"] = 0,
    ["health"] = 27566,
    ["ignoreFortified"] = true,
    ["scale"] = 1,
    ["displayId"] = 105134,
    ["iconTexture"] = 4335642,
    ["creatureType"] = "Mechanical",
    ["level"] = 62,
    ["bonusSpell"] = 368239,
    ["badCreatureModel"] = true,
    ["modelPosition"] = {
      [1] = 0,
      [2] = 0,
      [3] = 0.75,
    },
    ["include"] = {
      ["level"] = 10,
      ["affix"] = 130,
    },
    ["spells"] = {
      [366288] = {
      },
      [366297] = {
      },
      [368243] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 414.20439583652,
        ["y"] = -209.35518501009,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 536.72266897527,
        ["y"] = -335.99419414174,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 371.36229052264,
        ["y"] = -206.88264580379,
        ["sublevel"] = 4,
      },
      [4] = {
        ["x"] = 509.1219775813,
        ["y"] = -222.62649928755,
        ["sublevel"] = 4,
      },
      [5] = {
        ["x"] = 711.87068358516,
        ["y"] = -335.2276308675,
        ["sublevel"] = 4,
      },
      [6] = {
        ["x"] = 449.49970575651,
        ["y"] = -473.18131965324,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 435.16048837886,
        ["y"] = -293.58502022344,
        ["sublevel"] = 2,
      },
      [8] = {
        ["x"] = 444.679872047,
        ["y"] = -365.18588207077,
        ["sublevel"] = 2,
      },
      [9] = {
        ["x"] = 299.70733368867,
        ["y"] = -341.92600069748,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 631.0661591293,
        ["y"] = -254.92378466983,
        ["sublevel"] = 3,
      },
      [11] = {
        ["x"] = 235.89490342796,
        ["y"] = -250.35684717706,
        ["sublevel"] = 3,
      },
      [12] = {
        ["x"] = 499.14393675187,
        ["y"] = -298.27540608147,
        ["sublevel"] = 1,
      },
    },
  },
  [37] = {
    ["name"] = "Vy Relic",
    ["id"] = 185680,
    ["count"] = 0,
    ["health"] = 27566,
    ["ignoreFortified"] = true,
    ["scale"] = 1,
    ["displayId"] = 103111,
    ["iconTexture"] = 4335643,
    ["creatureType"] = "Mechanical",
    ["level"] = 62,
    ["bonusSpell"] = 368240,
    ["badCreatureModel"] = true,
    ["modelPosition"] = {
      [1] = 0,
      [2] = 0,
      [3] = 0.75,
    },
    ["include"] = {
      ["level"] = 10,
      ["affix"] = 130,
    },
    ["spells"] = {
      [366406] = {
      },
      [366409] = {
      },
      [368103] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 442.8809692557,
        ["y"] = -209.5801025667,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 554.47054531303,
        ["y"] = -349.93889194564,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 341.79951024863,
        ["y"] = -210.50828086518,
        ["sublevel"] = 4,
      },
      [4] = {
        ["x"] = 525.76056064439,
        ["y"] = -245.44510805843,
        ["sublevel"] = 4,
      },
      [5] = {
        ["x"] = 722.14570677489,
        ["y"] = -315.41146297092,
        ["sublevel"] = 4,
      },
      [6] = {
        ["x"] = 405.28868356517,
        ["y"] = -472.86440397652,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 445.06850933329,
        ["y"] = -277.43852821364,
        ["sublevel"] = 2,
      },
      [8] = {
        ["x"] = 413.30424843449,
        ["y"] = -349.06234862344,
        ["sublevel"] = 2,
      },
      [9] = {
        ["x"] = 318.67213048293,
        ["y"] = -326.86573673138,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 658.15107617233,
        ["y"] = -255.46005744655,
        ["sublevel"] = 3,
      },
      [11] = {
        ["x"] = 242.06271936135,
        ["y"] = -269.39672887284,
        ["sublevel"] = 3,
      },
      [12] = {
        ["x"] = 478.2268816762,
        ["y"] = -319.19250719111,
        ["sublevel"] = 1,
      },
    },
  },
};
