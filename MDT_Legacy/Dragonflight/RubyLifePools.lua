local addonName = ...
local MDT = MDT
local L = MDT.L
local dungeonIndex = 42
MDT.dungeonList[dungeonIndex] = L["RubyLifePools"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 393256,
  shortName = L["rubyLifePoolsShortName"],
  englishName = "Ruby Life Pools",
  mapID = 399
};

local zones = { 2094, 2095 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Interface\\AddOns\\'..addonName..'\\Dragonflight\\Textures\\RubyLifePools' }
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["RubyLifePools"],
}

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonTotalCount[dungeonIndex] = { normal = 660, teeming = 1000, teemingEnabled = true }

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Primal Juggernaut",
    ["id"] = 188244,
    ["count"] = 18,
    ["health"] = 13426021,
    ["scale"] = 1,
    ["displayId"] = 101209,
    ["creatureType"] = "Elemental",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [372696] = {
      },
      [372697] = {
      },
      [372730] = {
      },
      [372793] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 101.28063457457,
        ["y"] = -469.58349346714,
        ["sublevel"] = 1,
        ["scale"] = 2.2,
      },
      [2] = {
        ["x"] = 138.12731769362,
        ["y"] = -186.350008352,
        ["sublevel"] = 1,
        ["scale"] = 2.2,
      },
    },
  },
  [2] = {
    ["name"] = "Flashfrost Earthshaper",
    ["id"] = 187969,
    ["count"] = 10,
    ["health"] = 6713011,
    ["scale"] = 1,
    ["displayId"] = 107409,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
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
      ["Sleep Walk"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [371471] = {
      },
      [372735] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 130.89323000235,
        ["y"] = -374.35184176998,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [2] = {
        ["x"] = 104.38231928109,
        ["y"] = -347.52499728206,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [3] = {
        ["x"] = 117.1760062445,
        ["y"] = -338.64942594525,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [4] = {
        ["x"] = 62.783058870974,
        ["y"] = -269.66707697627,
        ["g"] = 6,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [5] = {
        ["x"] = 125.45512595255,
        ["y"] = -242.3309310591,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [6] = {
        ["x"] = 136.50397129573,
        ["y"] = -147.2878277117,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [7] = {
        ["x"] = 168.13807255387,
        ["y"] = -122.22705920542,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [8] = {
        ["x"] = 199.36134524303,
        ["y"] = -138.63523178362,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
    },
  },
  [3] = {
    ["name"] = "Primal Terrasentry",
    ["id"] = 188011,
    ["count"] = 10,
    ["health"] = 6713011,
    ["scale"] = 1,
    ["displayId"] = 79800,
    ["creatureType"] = "Elemental",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Mind Control"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Banish"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
    },
    ["spells"] = {
      [371956] = {
      },
      [373458] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 139.44271912845,
        ["y"] = -365.53792645157,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [2] = {
        ["x"] = 84.068972757823,
        ["y"] = -301.83098313393,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [3] = {
        ["x"] = 95.490112691563,
        ["y"] = -296.19690319299,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [4] = {
        ["x"] = 47.661843299819,
        ["y"] = -262.86828441536,
        ["g"] = 6,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [5] = {
        ["x"] = 114.07641623045,
        ["y"] = -258.90898565986,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [6] = {
        ["x"] = 106.90620795095,
        ["y"] = -270.24216220175,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [7] = {
        ["x"] = 135.17183937329,
        ["y"] = -159.67071827677,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
    },
  },
  [4] = {
    ["name"] = "Flashfrost Chillweaver",
    ["id"] = 188067,
    ["count"] = 10,
    ["health"] = 6713011,
    ["scale"] = 1,
    ["displayId"] = 107397,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
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
      ["Sleep Walk"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [371489] = {
      },
      [371887] = {
      },
      [371984] = {
      },
      [372565] = {
      },
      [372568] = {
      },
      [372743] = {
      },
      [372749] = {
      },
      [384933] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 102.57834453243,
        ["y"] = -333.7965356426,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [2] = {
        ["x"] = 75.404473202243,
        ["y"] = -293.63357750824,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [3] = {
        ["x"] = 99.754424612035,
        ["y"] = -259.94035396047,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [4] = {
        ["x"] = 65.990464975534,
        ["y"] = -243.88836030923,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [5] = {
        ["x"] = 112.61503123909,
        ["y"] = -238.45221664724,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [6] = {
        ["x"] = 111.79076645048,
        ["y"] = -195.38031879331,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [7] = {
        ["x"] = 128.21757919495,
        ["y"] = -209.12888316339,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [8] = {
        ["x"] = 146.95610003591,
        ["y"] = -157.06871118267,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [9] = {
        ["x"] = 176.73901217756,
        ["y"] = -142.05433165881,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
        ["patrol"] = {
        },
      },
    },
  },
  [5] = {
    ["name"] = "Infused Whelp",
    ["id"] = 187894,
    ["count"] = 1,
    ["health"] = 2315989,
    ["scale"] = 1,
    ["displayId"] = 102140,
    ["creatureType"] = "Dragonkin",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Mind Control"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Hibernate"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [372683] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 52.6236740354,
        ["y"] = -227.90841396287,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [2] = {
        ["x"] = 52.562747601477,
        ["y"] = -237.00858746836,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [3] = {
        ["x"] = 60.625336471297,
        ["y"] = -231.82696836021,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [4] = {
        ["x"] = 81.321166274962,
        ["y"] = -181.43994901251,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [5] = {
        ["x"] = 88.198587355798,
        ["y"] = -176.46093059139,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [6] = {
        ["x"] = 93.115356570922,
        ["y"] = -167.85845014562,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [7] = {
        ["x"] = 75.295837538943,
        ["y"] = -195.93407019468,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [8] = {
        ["x"] = 78.656920277899,
        ["y"] = -188.59722297802,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [9] = {
        ["x"] = 100.44986203134,
        ["y"] = -168.96069305494,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [10] = {
        ["x"] = 84.125275297128,
        ["y"] = -194.66779422266,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [11] = {
        ["x"] = 102.53006430479,
        ["y"] = -176.87056951862,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [12] = {
        ["x"] = 88.181516829349,
        ["y"] = -182.9250225971,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [13] = {
        ["x"] = 92.703029599599,
        ["y"] = -190.1191892089,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [14] = {
        ["x"] = 106.94531793702,
        ["y"] = -173.69554114549,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [15] = {
        ["x"] = 95.019191779843,
        ["y"] = -175.89452146547,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [16] = {
        ["x"] = 98.270964178502,
        ["y"] = -184.4709019435,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [17] = {
        ["x"] = 145.91722760083,
        ["y"] = -230.07826761241,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [18] = {
        ["x"] = 147.68716058765,
        ["y"] = -210.96838518609,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [19] = {
        ["x"] = 145.17073456603,
        ["y"] = -216.52927558316,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [20] = {
        ["x"] = 151.67688847452,
        ["y"] = -223.57641813874,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [21] = {
        ["x"] = 154.61968779497,
        ["y"] = -214.27947464049,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [22] = {
        ["x"] = 139.59350461094,
        ["y"] = -223.30465010222,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [23] = {
        ["x"] = 158.63880653482,
        ["y"] = -218.08388740481,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [24] = {
        ["x"] = 118.78325223304,
        ["y"] = -292.68420475662,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [25] = {
        ["x"] = 129.41757449399,
        ["y"] = -297.91169006525,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [26] = {
        ["x"] = 120.75035792957,
        ["y"] = -299.32115714572,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [27] = {
        ["x"] = 127.3497859774,
        ["y"] = -305.39476233375,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [28] = {
        ["x"] = 129.9135985132,
        ["y"] = -291.27293105194,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [29] = {
        ["x"] = 124.93853111482,
        ["y"] = -286.18739843938,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [30] = {
        ["x"] = 50.605790731227,
        ["y"] = -333.96324442772,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [31] = {
        ["x"] = 32.928864602457,
        ["y"] = -329.72636265431,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [32] = {
        ["x"] = 42.558274725997,
        ["y"] = -327.27888077465,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [33] = {
        ["x"] = 41.342810409217,
        ["y"] = -334.80573669962,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [34] = {
        ["x"] = 48.039956680497,
        ["y"] = -317.21535958351,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [35] = {
        ["x"] = 32.989903107577,
        ["y"] = -320.68983572788,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [36] = {
        ["x"] = 56.975798404017,
        ["y"] = -318.90544800915,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [37] = {
        ["x"] = 53.914244819387,
        ["y"] = -309.68743105715,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [38] = {
        ["x"] = 49.721495420757,
        ["y"] = -301.473577271,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [39] = {
        ["x"] = 38.014186429547,
        ["y"] = -300.83832854586,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [40] = {
        ["x"] = 32.071556563917,
        ["y"] = -310.56607364373,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [41] = {
        ["x"] = 40.448336306507,
        ["y"] = -317.92162453907,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [42] = {
        ["x"] = 42.044136819447,
        ["y"] = -308.56123277186,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [43] = {
        ["x"] = 52.477607892147,
        ["y"] = -325.78663731518,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [44] = {
        ["x"] = 60.505561205697,
        ["y"] = -329.18276976004,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [45] = {
        ["x"] = 57.512142108417,
        ["y"] = -336.79615635534,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [46] = {
        ["x"] = 49.117754968527,
        ["y"] = -341.29950390651,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [47] = {
        ["x"] = 85.563863995454,
        ["y"] = -173.43005961341,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [48] = {
        ["x"] = 213.56841599493,
        ["y"] = -175.87340311759,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [49] = {
        ["x"] = 213.40398267619,
        ["y"] = -163.01213281745,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [50] = {
        ["x"] = 207.8529070262,
        ["y"] = -169.9915328733,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
    },
  },
  [6] = {
    ["name"] = "Defier Draghar",
    ["id"] = 187897,
    ["count"] = 40,
    ["health"] = 20139032,
    ["scale"] = 1,
    ["stealthDetect"] = true,
    ["displayId"] = 107106,
    ["creatureType"] = "Dragonkin",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [372047] = {
      },
      [372087] = {
      },
      [372088] = {
      },
      [372794] = {
      },
      [372796] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 184.89270123479,
        ["y"] = -193.51510383252,
        ["sublevel"] = 1,
        ["scale"] = 2.2,
      },
    },
  },
  [7] = {
    ["name"] = "Melidrussa Chillworn",
    ["id"] = 188252,
    ["count"] = 0,
    ["health"] = 46843573,
    ["scale"] = 1,
    ["displayId"] = 106891,
    ["creatureType"] = "Humanoid",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 2488,
    ["instanceID"] = 1202,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [372808] = {
      },
      [372851] = {
      },
      [372963] = {
      },
      [372988] = {
      },
      [373046] = {
      },
      [373680] = {
      },
      [373688] = {
      },
      [373727] = {
      },
      [383925] = {
      },
      [384024] = {
      },
      [385518] = {
      },
      [396044] = {
      },
      [397077] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 281.25653994104,
        ["y"] = -290.54103286633,
        ["sublevel"] = 1,
        ["scale"] = 2,
      },
    },
  },
  [8] = {
    ["name"] = "Scorchling",
    ["id"] = 190205,
    ["count"] = 1,
    ["health"] = 1342602,
    ["scale"] = 1,
    ["displayId"] = 102535,
    ["creatureType"] = "Elemental",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Mind Control"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Banish"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
    },
    ["spells"] = {
      [373869] = {
      },
      [378968] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 473.54328904008,
        ["y"] = -279.49716585858,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [2] = {
        ["x"] = 500.25181175504,
        ["y"] = -290.87698119043,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [3] = {
        ["x"] = 502.02953051656,
        ["y"] = -322.78707922624,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [4] = {
        ["x"] = 460.83596510875,
        ["y"] = -338.77073422343,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [5] = {
        ["x"] = 463.28797282585,
        ["y"] = -358.13669303088,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [6] = {
        ["x"] = 516.02809843308,
        ["y"] = -404.19476041828,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [7] = {
        ["x"] = 522.73505386803,
        ["y"] = -458.75084439749,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [8] = {
        ["x"] = 532.67245583012,
        ["y"] = -466.78621574516,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [9] = {
        ["x"] = 557.02238893344,
        ["y"] = -434.15629250042,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [10] = {
        ["x"] = 612.30861303376,
        ["y"] = -450.32258383015,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [11] = {
        ["x"] = 627.90364851055,
        ["y"] = -459.88939594336,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [12] = {
        ["x"] = 639.30879707081,
        ["y"] = -446.74357802914,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [13] = {
        ["x"] = 766.11619942765,
        ["y"] = -323.97254325904,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [14] = {
        ["x"] = 773.96863215766,
        ["y"] = -305.23356163146,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [15] = {
        ["x"] = 760.31062014295,
        ["y"] = -303.21628038448,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [16] = {
        ["x"] = 702.37951499064,
        ["y"] = -228.4832771671,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [17] = {
        ["x"] = 685.32995753761,
        ["y"] = -234.69460848972,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [18] = {
        ["x"] = 693.44955850302,
        ["y"] = -220.03543865148,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [19] = {
        ["x"] = 682.03821248733,
        ["y"] = -224.94875715422,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [20] = {
        ["x"] = 692.73334675594,
        ["y"] = -208.79667877594,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [21] = {
        ["x"] = 591.56158459574,
        ["y"] = -196.96277766472,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [22] = {
        ["x"] = 542.45029092567,
        ["y"] = -235.7266101616,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [23] = {
        ["x"] = 556.31232179183,
        ["y"] = -238.56782169582,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [24] = {
        ["x"] = 549.21367787381,
        ["y"] = -250.02452917774,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
    },
  },
  [9] = {
    ["name"] = "Thunderhead",
    ["id"] = 197698,
    ["count"] = 40,
    ["health"] = 20139032,
    ["scale"] = 1,
    ["displayId"] = 106435,
    ["creatureType"] = "Dragonkin",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [391726] = {
      },
      [391727] = {
      },
      [392395] = {
      },
      [392640] = {
      },
      [392641] = {
      },
      [392642] = {
      },
      [395303] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 479.31483155353,
        ["y"] = -312.22150758466,
        ["sublevel"] = 1,
        ["scale"] = 2.5,
      },
    },
  },
  [10] = {
    ["name"] = "Primalist Cinderweaver",
    ["id"] = 190207,
    ["count"] = 10,
    ["health"] = 6713011,
    ["scale"] = 1,
    ["displayId"] = 102886,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
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
      ["Sleep Walk"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [384194] = {
      },
      [384197] = {
      },
      [385063] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 480.82581253865,
        ["y"] = -394.99560894578,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [2] = {
        ["x"] = 478.3397658196,
        ["y"] = -376.11264054188,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [3] = {
        ["x"] = 505.77686180094,
        ["y"] = -430.33159249967,
        ["g"] = 15,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [4] = {
        ["x"] = 573.27170903197,
        ["y"] = -469.64703778507,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [5] = {
        ["x"] = 724.73241722268,
        ["y"] = -261.04375163146,
        ["g"] = 17,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [6] = {
        ["x"] = 619.96370925884,
        ["y"] = -190.2425764598,
        ["g"] = 19,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [7] = {
        ["x"] = 589.62228942946,
        ["y"] = -230.51092011358,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [8] = {
        ["x"] = 593.0882387647,
        ["y"] = -219.09478314761,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
    },
  },
  [11] = {
    ["name"] = "Blazebound Destroyer",
    ["id"] = 190034,
    ["count"] = 16,
    ["health"] = 11412119,
    ["scale"] = 1,
    ["displayId"] = 102505,
    ["creatureType"] = "Elemental",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [373614] = {
      },
      [373692] = {
      },
      [373693] = {
      },
      [384139] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 489.67981064042,
        ["y"] = -384.71840098227,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["scale"] = 2,
      },
      [2] = {
        ["x"] = 568.38271854785,
        ["y"] = -457.39319674692,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 2,
      },
      [3] = {
        ["x"] = 721.2382470802,
        ["y"] = -274.90364860999,
        ["g"] = 17,
        ["sublevel"] = 1,
        ["scale"] = 2,
      },
      [4] = {
        ["x"] = 631.08423028757,
        ["y"] = -201.2116183606,
        ["g"] = 19,
        ["sublevel"] = 1,
        ["scale"] = 2,
      },
    },
  },
  [12] = {
    ["name"] = "Primalist Flamedancer",
    ["id"] = 190206,
    ["count"] = 10,
    ["health"] = 7384312,
    ["scale"] = 1,
    ["displayId"] = 102969,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
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
      ["Sleep Walk"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [373972] = {
      },
      [373973] = {
      },
      [373977] = {
      },
      [385536] = {
      },
      [385567] = {
      },
      [385568] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 511.30497132095,
        ["y"] = -442.0080139097,
        ["g"] = 15,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [2] = {
        ["x"] = 518.76424356649,
        ["y"] = -432.23566662949,
        ["g"] = 15,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [3] = {
        ["x"] = 555.58398034437,
        ["y"] = -461.62676526419,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [4] = {
        ["x"] = 733.30440480878,
        ["y"] = -282.65575863501,
        ["g"] = 17,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [5] = {
        ["x"] = 640.66056162774,
        ["y"] = -190.39827790199,
        ["g"] = 19,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [6] = {
        ["x"] = 580.57928461849,
        ["y"] = -223.61714799433,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
    },
  },
  [13] = {
    ["name"] = "Primalist Shockcaster",
    ["id"] = 195119,
    ["count"] = 14,
    ["health"] = 10740817,
    ["scale"] = 1,
    ["displayId"] = 108753,
    ["creatureType"] = "Humanoid",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [385310] = {
      },
      [385311] = {
      },
      [385312] = {
      },
      [385313] = {
      },
      [385314] = {
      },
      [385316] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 526.809602612,
        ["y"] = -338.60407286165,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      },
      [2] = {
        ["x"] = 574.27773054004,
        ["y"] = -415.35553202475,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      },
      [3] = {
        ["x"] = 680.30835983498,
        ["y"] = -277.13847947594,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      },
      [4] = {
        ["x"] = 589.32245138592,
        ["y"] = -258.01388552246,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      },
    },
  },
  [14] = {
    ["name"] = "Flamegullet",
    ["id"] = 197697,
    ["count"] = 40,
    ["health"] = 20139032,
    ["scale"] = 1,
    ["stealthDetect"] = true,
    ["displayId"] = 106023,
    ["creatureType"] = "Dragonkin",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [391723] = {
      },
      [391724] = {
      },
      [392394] = {
      },
      [392569] = {
      },
      [392570] = {
      },
      [395292] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 731.33110037629,
        ["y"] = -400.47436133393,
        ["sublevel"] = 1,
        ["scale"] = 2.5,
      },
    },
  },
  [15] = {
    ["name"] = "Kokia Blazehoof",
    ["id"] = 189232,
    ["count"] = 0,
    ["health"] = 40151634,
    ["scale"] = 1,
    ["displayId"] = 106851,
    ["creatureType"] = "Humanoid",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 2485,
    ["instanceID"] = 1202,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [372107] = {
      },
      [372811] = {
      },
      [372819] = {
      },
      [372820] = {
      },
      [372858] = {
      },
      [372859] = {
      },
      [372860] = {
      },
      [372863] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 479.87966686496,
        ["y"] = -232.88346577194,
        ["sublevel"] = 1,
        ["scale"] = 2,
      },
    },
  },
  [16] = {
    ["name"] = "Storm Warrior",
    ["id"] = 197982,
    ["count"] = 10,
    ["health"] = 6713011,
    ["scale"] = 1,
    ["displayId"] = 107116,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
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
      ["Sleep Walk"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [392406] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 443.43388966418,
        ["y"] = -198.70941224111,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [2] = {
        ["x"] = 434.3075430312,
        ["y"] = -207.35892298144,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [3] = {
        ["x"] = 356.2948081972,
        ["y"] = -140.89984768495,
        ["g"] = 24,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
        ["patrol"] = {
        },
      },
      [4] = {
        ["x"] = 363.66398750955,
        ["y"] = -133.79697633026,
        ["g"] = 24,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [5] = {
        ["x"] = 323.62389703043,
        ["y"] = -81.13314740225,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [6] = {
        ["x"] = 320.82135026789,
        ["y"] = -91.95714487562,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [7] = {
        ["x"] = 286.6359342376,
        ["y"] = -85.071721637223,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [8] = {
        ["x"] = 295.26883850193,
        ["y"] = -76.968911806891,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [9] = {
        ["x"] = 314.95707183002,
        ["y"] = -113.79906943275,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
    },
  },
  [17] = {
    ["name"] = "Primal Thundercloud",
    ["id"] = 197509,
    ["count"] = 0,
    ["health"] = 995103,
    ["scale"] = 1,
    ["displayId"] = 102516,
    ["creatureType"] = "Elemental",
    ["level"] = 69,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Mind Control"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Banish"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
    },
    ["spells"] = {
      [391031] = {
      },
      [392398] = {
      },
      [392399] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 431.13152013117,
        ["y"] = -195.6986262502,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [2] = {
        ["x"] = 403.34243438809,
        ["y"] = -181.17984255837,
        ["g"] = 22,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [3] = {
        ["x"] = 410.87664211028,
        ["y"] = -173.62681853449,
        ["g"] = 22,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [4] = {
        ["x"] = 378.49521530182,
        ["y"] = -168.23196162669,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [5] = {
        ["x"] = 395.32869950909,
        ["y"] = -167.42368496293,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [6] = {
        ["x"] = 396.25111818363,
        ["y"] = -150.83056202294,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [7] = {
        ["x"] = 256.27849430324,
        ["y"] = -101.97512481833,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [8] = {
        ["x"] = 252.40707045072,
        ["y"] = -107.61596048733,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [9] = {
        ["x"] = 250.58597056069,
        ["y"] = -98.047257408442,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [10] = {
        ["x"] = 247.36505954987,
        ["y"] = -103.95344781756,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [11] = {
        ["x"] = 296.16254480078,
        ["y"] = -66.952490137926,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [12] = {
        ["x"] = 276.19173661396,
        ["y"] = -83.564560408933,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [13] = {
        ["x"] = 279.37777235149,
        ["y"] = -90.893261558163,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [14] = {
        ["x"] = 338.33845985204,
        ["y"] = -57.753100544532,
        ["g"] = 28,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [15] = {
        ["x"] = 346.23760641566,
        ["y"] = -58.151325967912,
        ["g"] = 28,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [16] = {
        ["x"] = 340.81407618887,
        ["y"] = -51.289147208002,
        ["g"] = 28,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [17] = {
        ["x"] = 311.51091068611,
        ["y"] = -123.21571440265,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [18] = {
        ["x"] = 341.34717918788,
        ["y"] = -64.055169293192,
        ["g"] = 28,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [19] = {
        ["x"] = 323.76094943351,
        ["y"] = -48.469988341458,
        ["g"] = 28,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [20] = {
        ["x"] = 329.89290560946,
        ["y"] = -42.83497997535,
        ["g"] = 28,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [21] = {
        ["x"] = 303.72259772989,
        ["y"] = -70.642750500389,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
    },
  },
  [18] = {
    ["name"] = "Tempest Channeler",
    ["id"] = 198047,
    ["count"] = 16,
    ["health"] = 10740817,
    ["scale"] = 1,
    ["displayId"] = 102868,
    ["creatureType"] = "Humanoid",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [392486] = {
      },
      [392488] = {
      },
      [392574] = {
      },
      [392576] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 387.14765533399,
        ["y"] = -158.44175986472,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      },
      [2] = {
        ["x"] = 302.93545274213,
        ["y"] = -117.57466577239,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
    },
  },
  [19] = {
    ["name"] = "Flame Channeler",
    ["id"] = 197985,
    ["count"] = 16,
    ["health"] = 10740817,
    ["scale"] = 1,
    ["displayId"] = 102888,
    ["creatureType"] = "Humanoid",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [392451] = {
      },
      [392452] = {
      },
      [392454] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 331.08445670882,
        ["y"] = -89.49724943219,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [2] = {
        ["x"] = 305.65285829636,
        ["y"] = -107.99115377429,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
    },
  },
  [20] = {
    ["name"] = "High Channeler Ryvati",
    ["id"] = 197535,
    ["count"] = 40,
    ["health"] = 20139032,
    ["scale"] = 1,
    ["displayId"] = 102943,
    ["creatureType"] = "Humanoid",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [391050] = {
      },
      [391130] = {
      },
      [392486] = {
      },
      [392488] = {
      },
      [392574] = {
      },
      [392924] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 281.85447935368,
        ["y"] = -71.356965310323,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      },
    },
  },
  [21] = {
    ["name"] = "Erkhart Stormvein",
    ["id"] = 190485,
    ["count"] = 0,
    ["health"] = 30113726,
    ["scale"] = 1,
    ["displayId"] = 108318,
    ["creatureType"] = "Humanoid",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 2503,
    ["instanceID"] = 1202,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [181089] = {
      },
      [381512] = {
      },
      [381513] = {
      },
      [381514] = {
      },
      [381515] = {
      },
      [381516] = {
      },
      [381517] = {
      },
      [381518] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 255.0992522811,
        ["y"] = -21.384343906324,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["scale"] = 2,
      },
    },
  },
  [22] = {
    ["name"] = "Kyrakka",
    ["id"] = 190484,
    ["count"] = 0,
    ["health"] = 24090980,
    ["scale"] = 1,
    ["displayId"] = 107137,
    ["creatureType"] = "Dragonkin",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 2503,
    ["instanceID"] = 1202,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [381525] = {
      },
      [381526] = {
      },
      [381602] = {
      },
      [381605] = {
      },
      [381607] = {
      },
      [381862] = {
      },
      [381864] = {
      },
      [384494] = {
      },
      [384773] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 226.44679474865,
        ["y"] = -49.239741574134,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["scale"] = 2,
      },
    },
  },
};
