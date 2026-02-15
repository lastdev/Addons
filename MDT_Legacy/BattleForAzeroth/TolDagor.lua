local MDT = MDT
local L = MDT.L
local dungeonIndex = 23
MDT.dungeonList[dungeonIndex] = L["Tol Dagor"]
MDT.mapInfo[dungeonIndex] = {
  viewportPositionOverrides =
  {
    [1] = {
      zoomScale = 1.8999998569489,
      horizontalPan = 291.80521169104,
      verticalPan = 126.49567245981,
    },
    [2] = {
      zoomScale = 1.5999999046326,
      horizontalPan = 181.36659738551,
      verticalPan = 67.969520100732,
    },
    [3] = {
      zoomScale = 1.2999999523163,
      horizontalPan = 53.044494315603,
      verticalPan = 109.47271962255,
    },
    [4] = {
      zoomScale = 1.2999999523163,
      horizontalPan = 74.300611780571,
      verticalPan = 72.503083103944,
    },
    [5] = {
      zoomScale = 1.2999999523163,
      horizontalPan = 61.403255426994,
      verticalPan = 55.466726337752,
    },
    [6] = {
      zoomScale = 1.2999999523163,
      horizontalPan = 98.034112946346,
      verticalPan = 64.938350262682,
    },
    [7] = {
      zoomScale = 1.5999999046326,
      horizontalPan = 174.48055721809,
      verticalPan = 86.184873724839,
    },
  },
  teleportId = 0, -- no teleport
  iconId = 2011149,
  shortName = L["tolDagorShortName"],
  englishName = "Tol Dagor",
  mapID = 246
};

local zones = { 974, 975, 976, 977, 978, 979, 980 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "PrisonDungeon",
  [1] = "PrisonDungeon",
  [2] = "PrisonDungeon1_",
  [3] = "PrisonDungeon2_",
  [4] = "PrisonDungeon3_",
  [5] = "PrisonDungeon4_",
  [6] = "PrisonDungeon5_",
  [7] = "PrisonDungeon6_",
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Tol Dagor Sublevel1"],
  [2] = L["The Drain"],
  [3] = L["The Brig"],
  [4] = L["Detention Block"],
  [5] = L["Officer Quarters"],
  [6] = L["Overseer's Redoubt"],
  [7] = L["Overseer's Summit"],
}
MDT.dungeonTotalCount[dungeonIndex] = { normal = 400, teeming = 479, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {
  [1] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 429.14575221168,
      ["y"] = -262.48238754636,
      ["target"] = 2,
      ["direction"] = -2,
      ["connectionIndex"] = 1,
    },
    [2] = {
      ["template"] = "DeathReleasePinTemplate",
      ["type"] = "graveyard",
      ["x"] = 647.46008933814,
      ["y"] = -323.24173620103,
      ["graveyardDescription"] = "",
    },
    [3] = {
      ["template"] = "DeathReleasePinTemplate",
      ["type"] = "graveyard",
      ["x"] = 462.50964014617,
      ["y"] = -281.83580607976,
      ["graveyardDescription"] = "tdGraveyardNote1",
    },
  },
  [2] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 592.87359409387,
      ["y"] = -293.64644125367,
      ["target"] = 1,
      ["direction"] = 2,
      ["connectionIndex"] = 1,
    },
    [2] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 454.00006758794,
      ["y"] = -120.99821179174,
      ["target"] = 3,
      ["direction"] = -2,
      ["connectionIndex"] = 2,
    },
    [3] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "door",
      ["x"] = 497.30085206047,
      ["y"] = -226.92509913277,
      ["doorName"] = "Sewer Gate",
      ["lockpick"] = true,
      ["doorDescription"] = "",
    },
    [4] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "tdprisonkey",
      ["x"] = 327.37631924595,
      ["y"] = -259.49817884669,
    },
    [5] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "tdprisonkey",
      ["x"] = 541.88933589202,
      ["y"] = -252.32441542972,
    },
    [6] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "tdprisonkey",
      ["x"] = 570.90039133419,
      ["y"] = -198.70891225244,
    },
    [7] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "tdprisonkey",
      ["x"] = 438.08534915751,
      ["y"] = -161.93013251665,
    },
    [8] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "tdprisonkey",
      ["x"] = 413.76855097664,
      ["y"] = -246.92767963576,
    },
    [9] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "tdprisonkey",
      ["x"] = 461.34582715726,
      ["y"] = -145.16687134973,
    },
  },
  [3] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 476.41240071571,
      ["y"] = -187.11512731937,
      ["target"] = 2,
      ["direction"] = -1,
      ["connectionIndex"] = 2,
    },
    [2] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 311.79902903432,
      ["y"] = -460.41462426303,
      ["target"] = 4,
      ["direction"] = 1,
      ["connectionIndex"] = 3,
    },
    [3] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "door",
      ["x"] = 310.03890671508,
      ["y"] = -350.76394802461,
      ["doorName"] = "Prison Gate",
      ["lockpick"] = true,
      ["doorDescription"] = "",
    },
    [4] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "door",
      ["x"] = 478.42943341834,
      ["y"] = -294.67309052738,
      ["doorName"] = "Prison Gate",
      ["lockpick"] = true,
      ["doorDescription"] = "",
    },
    [5] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "door",
      ["x"] = 298.43826548799,
      ["y"] = -326.6835033043,
      ["doorName"] = "Prison Barsx",
      ["lockpick"] = true,
      ["formattedDoorDescription"] = {
        [1] = "tdBuffGateNote",
        [2] = "\n",
        [3] = "\n",
        [4] = "\n",
        [5] = "\n",
      },
    },
    [6] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "door",
      ["x"] = 358.09242143672,
      ["y"] = -236.06541579087,
      ["doorName"] = "Prison Bars",
      ["lockpick"] = true,
      ["formattedDoorDescription"] = {
        [1] = "tdBuffGateNote",
        [2] = "\n",
        [3] = "\n",
        [4] = "\n",
        [5] = "\n",
      },
    },
    [7] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "door",
      ["x"] = 429.49956431235,
      ["y"] = -418.6335527449,
      ["doorName"] = "Prison Bars",
      ["lockpick"] = true,
      ["formattedDoorDescription"] = {
        [1] = "tdBuffGateNote",
        [2] = "\n",
        [3] = "\n",
        [4] = "\n",
        [5] = "\n",
      },
    },
    [8] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "door",
      ["x"] = 317.04689195555,
      ["y"] = -303.0449876628,
      ["doorName"] = "Prison Bars",
      ["lockpick"] = true,
      ["formattedDoorDescription"] = {
        [1] = "tdBuffGateNote",
        [2] = "\n",
        [3] = "\n",
        [4] = "\n",
        [5] = "\n",
      },
    },
    [9] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "door",
      ["x"] = 347.29237946953,
      ["y"] = -254.86541064356,
      ["doorName"] = "Prison Bars",
      ["lockpick"] = true,
      ["formattedDoorDescription"] = {
        [1] = "tdBuffGateNote",
        [2] = "\n",
        [3] = "\n",
        [4] = "\n",
        [5] = "\n",
      },
    },
    [10] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "door",
      ["x"] = 461.57195383542,
      ["y"] = -369.72975641613,
      ["doorName"] = "Prison Bars",
      ["lockpick"] = true,
      ["formattedDoorDescription"] = {
        [1] = "tdBuffGateNote",
        [2] = "\n",
        [3] = "\n",
        [4] = "\n",
        [5] = "\n",
      },
    },
    [11] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "door",
      ["x"] = 445.50049335717,
      ["y"] = -392.9440473463,
      ["doorName"] = "Prison Bars",
      ["lockpick"] = true,
      ["formattedDoorDescription"] = {
        [1] = "tdBuffGateNote",
        [2] = "\n",
        [3] = "\n",
        [4] = "\n",
        [5] = "\n",
      },
    },
    [12] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "door",
      ["x"] = 491.92910587132,
      ["y"] = -322.22977757645,
      ["doorName"] = "Prison Bars",
      ["lockpick"] = true,
      ["formattedDoorDescription"] = {
        [1] = "tdBuffGateNote",
        [2] = "\n",
        [3] = "\n",
        [4] = "\n",
        [5] = "\n",
      },
    },
    [13] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "tdprisonkey",
      ["x"] = 357.03975190127,
      ["y"] = -324.41146834197,
    },
    [14] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "tdprisonkey",
      ["x"] = 308.69262661692,
      ["y"] = -323.00387569819,
    },
    [15] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "tdprisonkey",
      ["x"] = 414.72803284209,
      ["y"] = -170.64246587206,
    },
    [16] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "tdprisonkey",
      ["x"] = 353.45401378142,
      ["y"] = -200.28001925019,
    },
    [17] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "tdprisonkey",
      ["x"] = 384.18148542908,
      ["y"] = -395.00750840427,
    },
    [18] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "tdprisonkey",
      ["x"] = 414.00297776122,
      ["y"] = -237.49898650692,
    },
    [19] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "tdprisonkey",
      ["x"] = 384.77433124093,
      ["y"] = -178.47965873006,
    },
  },
  [4] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 313.00005758367,
      ["y"] = -441.99833049439,
      ["target"] = 3,
      ["direction"] = -1,
      ["connectionIndex"] = 3,
    },
    [2] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 219.00000645407,
      ["y"] = -371.99834172614,
      ["target"] = 5,
      ["direction"] = 1,
      ["connectionIndex"] = 4,
    },
    [3] = {
      ["template"] = "DeathReleasePinTemplate",
      ["type"] = "graveyard",
      ["x"] = 336.15677336968,
      ["y"] = -358.690180572,
      ["graveyardDescription"] = "tdGraveyardNote2",
    },
    [4] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "door",
      ["x"] = 322.38299113063,
      ["y"] = -234.18683041859,
      ["doorName"] = "Prison Bars",
      ["lockpick"] = true,
      ["doorDescription"] = "tdHowlisNote",
    },
    [5] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "door",
      ["x"] = 359.05915201413,
      ["y"] = -183.15399599877,
      ["doorName"] = "Prison Bars",
      ["lockpick"] = true,
      ["doorDescription"] = "tdHowlisNote",
    },
    [6] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "door",
      ["x"] = 341.18300314946,
      ["y"] = -208.98680115971,
      ["doorName"] = "Prison Bars",
      ["lockpick"] = true,
      ["doorDescription"] = "tdHowlisNote",
    },
    [7] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "door",
      ["x"] = 491.23264157131,
      ["y"] = -278.27853729051,
      ["doorName"] = "Prison Bars",
      ["lockpick"] = true,
      ["doorDescription"] = "tdHowlisNote",
    },
    [8] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "door",
      ["x"] = 475.44313696461,
      ["y"] = -305.64700893053,
      ["doorName"] = "Prison Bars",
      ["lockpick"] = true,
      ["doorDescription"] = "tdHowlisNote",
    },
    [9] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "door",
      ["x"] = 460.17995520134,
      ["y"] = -330.91014402277,
      ["doorName"] = "Prison Bars",
      ["lockpick"] = true,
      ["doorDescription"] = "tdHowlisNote",
    },
    [10] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "generalNote",
      ["x"] = 359.14450923037,
      ["y"] = -210.61333863941,
      ["text"] = "tdWardenFightingNote",
    },
  },
  [5] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 212.99992649071,
      ["y"] = -384.99838623404,
      ["target"] = 4,
      ["direction"] = -1,
      ["connectionIndex"] = 4,
    },
    [2] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 487.99998658896,
      ["y"] = -92.998271234334,
      ["target"] = 6,
      ["direction"] = 1,
      ["connectionIndex"] = 5,
    },
    [3] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "door",
      ["x"] = 356.9995854944,
      ["y"] = -404.49679019861,
      ["doorName"] = "Prison Gate",
      ["lockpick"] = true,
      ["doorDescription"] = "",
    },
    [4] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "door",
      ["x"] = 484.87937131732,
      ["y"] = -270.18747899972,
      ["doorName"] = "Prison Gate",
      ["lockpick"] = true,
      ["doorDescription"] = "",
    },
  },
  [6] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 452.00002179295,
      ["y"] = -155.99833837338,
      ["target"] = 5,
      ["direction"] = -1,
      ["connectionIndex"] = 5,
    },
    [2] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 519.99998390675,
      ["y"] = -199.9983239565,
      ["target"] = 7,
      ["direction"] = 1,
      ["connectionIndex"] = 6,
    },
    [3] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "heavyCannon",
      ["x"] = 387.54905152042,
      ["y"] = -98.627695689899,
    },
    [4] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "heavyCannon",
      ["x"] = 587.3175423851,
      ["y"] = -238.8518062721,
    },
    [5] = {
      ["template"] = "DeathReleasePinTemplate",
      ["type"] = "graveyard",
      ["x"] = 427.66171594679,
      ["y"] = -482.48947620288,
      ["graveyardDescription"] = "tdGraveyardNote3",
    },
  },
  [7] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 569.99996362254,
      ["y"] = -159.99830585159,
      ["target"] = 6,
      ["direction"] = -1,
      ["connectionIndex"] = 6,
    },
  },
};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Saltwater Snapper",
    ["id"] = 127477,
    ["count"] = 6,
    ["health"] = 922194,
    ["scale"] = 1,
    ["displayId"] = 46043,
    ["creatureType"] = "Beast",
    ["level"] = 121,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [258054] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 602.33294129608,
        ["y"] = -217.059546414,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 595.40607303846,
        ["y"] = -181.21503869038,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 612.89238947303,
        ["y"] = -171.33069454039,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 604.34584409908,
        ["y"] = -154.31585274858,
        ["sublevel"] = 1,
      },
    },
  },
  [2] = {
    ["name"] = "Stinging Parasite",
    ["id"] = 127480,
    ["count"] = 1,
    ["health"] = 230549,
    ["scale"] = 0.6,
    ["displayId"] = 5990,
    ["creatureType"] = "Beast",
    ["level"] = 120,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [258075] = {
      },
      [277242] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 502.5164332929,
        ["y"] = -254.00355751879,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 502.5164332929,
            ["y"] = -254.00355751879,
          },
          [2] = {
            ["x"] = 567.56572225286,
            ["y"] = -233.21790321807,
          },
          [3] = {
            ["x"] = 564.52087537141,
            ["y"] = -191.49995411977,
          },
          [4] = {
            ["x"] = 567.56572225286,
            ["y"] = -233.21790321807,
          },
          [5] = {
            ["x"] = 502.5164332929,
            ["y"] = -254.00355751879,
          },
          [6] = {
            ["x"] = 515.93390707361,
            ["y"] = -275.42694347323,
          },
          [7] = {
            ["x"] = 486.95216091555,
            ["y"] = -303.3181545467,
          },
          [8] = {
            ["x"] = 515.93390707361,
            ["y"] = -275.42694347323,
          },
        },
      },
      [2] = {
        ["x"] = 514.89708116989,
        ["y"] = -255.6179242644,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 508.8256328874,
        ["y"] = -255.6179242644,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 507.75412871092,
        ["y"] = -248.83218073601,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 513.82563830105,
        ["y"] = -249.90362360486,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 586.20367134525,
        ["y"] = -282.50886189912,
        ["g"] = 7,
        ["sublevel"] = 2,
      },
      [7] = {
        ["x"] = 581.08740359176,
        ["y"] = -286.22978208705,
        ["g"] = 7,
        ["sublevel"] = 2,
      },
      [8] = {
        ["x"] = 579.4595346931,
        ["y"] = -292.50885611236,
        ["g"] = 7,
        ["sublevel"] = 2,
      },
      [9] = {
        ["x"] = 574.34322701836,
        ["y"] = -287.16002710451,
        ["g"] = 7,
        ["sublevel"] = 2,
      },
      [10] = {
        ["x"] = 579.22695347811,
        ["y"] = -281.81117813603,
        ["g"] = 7,
        ["sublevel"] = 2,
      },
      [11] = {
        ["x"] = 502.47543760572,
        ["y"] = -298.72271476306,
        ["g"] = 9,
        ["sublevel"] = 2,
      },
      [12] = {
        ["x"] = 504.72542494486,
        ["y"] = -303.97269952615,
        ["g"] = 9,
        ["sublevel"] = 2,
      },
      [13] = {
        ["x"] = 511.22544797367,
        ["y"] = -307.72270703494,
        ["g"] = 9,
        ["sublevel"] = 2,
      },
      [14] = {
        ["x"] = 506.22544511451,
        ["y"] = -297.47269795501,
        ["g"] = 9,
        ["sublevel"] = 2,
      },
      [15] = {
        ["x"] = 510.22543452724,
        ["y"] = -302.22271891024,
        ["g"] = 9,
        ["sublevel"] = 2,
      },
      [16] = {
        ["x"] = 510.47543788885,
        ["y"] = -294.72270389266,
        ["g"] = 9,
        ["sublevel"] = 2,
      },
      [17] = {
        ["x"] = 516.22540791749,
        ["y"] = -301.72269072934,
        ["g"] = 9,
        ["sublevel"] = 2,
      },
      [18] = {
        ["x"] = 447.09309005694,
        ["y"] = -373.73758083669,
        ["g"] = 10,
        ["sublevel"] = 2,
      },
      [19] = {
        ["x"] = 452.22820143486,
        ["y"] = -381.30513414926,
        ["g"] = 10,
        ["sublevel"] = 2,
      },
      [20] = {
        ["x"] = 453.57954775523,
        ["y"] = -373.73758083669,
        ["g"] = 10,
        ["sublevel"] = 2,
      },
      [21] = {
        ["x"] = 456.55251429954,
        ["y"] = -365.62946811823,
        ["g"] = 10,
        ["sublevel"] = 2,
      },
      [22] = {
        ["x"] = 458.9849562342,
        ["y"] = -370.76459109489,
        ["g"] = 10,
        ["sublevel"] = 2,
      },
      [23] = {
        ["x"] = 463.30929229638,
        ["y"] = -372.65649682114,
        ["g"] = 10,
        ["sublevel"] = 2,
      },
      [24] = {
        ["x"] = 458.71470552812,
        ["y"] = -378.06189370138,
        ["g"] = 10,
        ["sublevel"] = 2,
      },
    },
  },
  [3] = {
    ["name"] = "Sewer Vicejaw",
    ["id"] = 127482,
    ["count"] = 4,
    ["health"] = 845345,
    ["scale"] = 1.2,
    ["displayId"] = 84333,
    ["creatureType"] = "Beast",
    ["level"] = 120,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
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
      [209859] = {
      },
      [258079] = {
      },
      [277242] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 554.33223641337,
        ["y"] = -269.54240043972,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 557.0822519334,
        ["y"] = -261.79239278937,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 552.26730775915,
        ["y"] = -319.21199513459,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 513.40430820744,
        ["y"] = -329.51210718072,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 486.76462087793,
        ["y"] = -365.14670956877,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 482.64699421327,
        ["y"] = -372.20552698742,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 338.99908497557,
        ["y"] = -314.49730942398,
        ["sublevel"] = 2,
      },
      [8] = {
        ["x"] = 363.9931776649,
        ["y"] = -270.08151859923,
        ["g"] = 8,
        ["sublevel"] = 2,
      },
      [9] = {
        ["x"] = 364.28735204952,
        ["y"] = -251.71261273687,
        ["g"] = 8,
        ["sublevel"] = 2,
      },
      [10] = {
        ["x"] = 397.9740854707,
        ["y"] = -218.66091147994,
        ["sublevel"] = 2,
      },
      [11] = {
        ["x"] = 418.99912118539,
        ["y"] = -280.49732836708,
        ["sublevel"] = 2,
      },
      [12] = {
        ["x"] = 386.99898050725,
        ["y"] = -479.49735781828,
        ["g"] = 44,
        ["sublevel"] = 2,
      },
      [13] = {
        ["x"] = 450.96845366135,
        ["y"] = -329.18935366965,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 450.25418906927,
        ["y"] = -339.18933384312,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 509.89701444861,
        ["y"] = -275.26076764221,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [16] = {
        ["x"] = 508.11133764151,
        ["y"] = -284.54645256979,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
    },
  },
  [4] = {
    ["name"] = "Silt Crab",
    ["id"] = 127381,
    ["count"] = 3,
    ["health"] = 768495,
    ["scale"] = 1,
    ["displayId"] = 42978,
    ["creatureType"] = "Beast",
    ["level"] = 120,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [258058] = {
      },
      [277242] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 509.71289588607,
        ["y"] = -362.61953268822,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 513.79453030713,
        ["y"] = -368.33384189747,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 519.71288883197,
        ["y"] = -365.6807803996,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 515.83533875943,
        ["y"] = -357.721595906,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 523.99860760155,
        ["y"] = -359.96648870682,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 467.85002481984,
        ["y"] = -334.24968277289,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 465.59999456536,
        ["y"] = -343.49967840639,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 456.93789483453,
        ["y"] = -345.2689025355,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 457.70713581315,
        ["y"] = -335.84582434166,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 461.36098094389,
        ["y"] = -329.11506481415,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 524.71605006068,
        ["y"] = -276.91386525457,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 526.14462298387,
        ["y"] = -285.68937838403,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 516.55278121855,
        ["y"] = -288.54652423042,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 516.34869687003,
        ["y"] = -280.179179798,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 518.38952283879,
        ["y"] = -272.01591095588,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
    },
  },
  [5] = {
    ["name"] = "The Sand Queen",
    ["id"] = 127479,
    ["count"] = 0,
    ["health"] = 5379465,
    ["scale"] = 1,
    ["displayId"] = 82983,
    ["creatureType"] = "Beast",
    ["level"] = 122,
    ["isBoss"] = true,
    ["encounterID"] = 2097,
    ["instanceID"] = 1002,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [205276] = {
      },
      [257092] = {
      },
      [257495] = {
      },
      [257580] = {
      },
      [257608] = {
      },
      [257617] = {
      },
      [259975] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 438.66653393032,
        ["y"] = -288.50224547575,
        ["sublevel"] = 1,
      },
    },
  },
  [6] = {
    ["name"] = "Irontide Thug",
    ["id"] = 130025,
    ["count"] = 7,
    ["health"] = 1152743,
    ["scale"] = 1.4,
    ["stealthDetect"] = true,
    ["displayId"] = 81499,
    ["creatureType"] = "Humanoid",
    ["level"] = 121,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [258128] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 480.99935364488,
        ["y"] = -217.64026135748,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 397.82382324822,
        ["y"] = -328.1330661427,
        ["g"] = 15,
        ["sublevel"] = 3,
        ["patrol"] = {
          [1] = {
            ["x"] = 397.82382324822,
            ["y"] = -328.1330661427,
          },
          [2] = {
            ["x"] = 430.85352893265,
            ["y"] = -350.75231298973,
          },
          [3] = {
            ["x"] = 415.13927741539,
            ["y"] = -375.39520986025,
          },
          [4] = {
            ["x"] = 430.85352893265,
            ["y"] = -350.75231298973,
          },
          [5] = {
            ["x"] = 397.82382324822,
            ["y"] = -328.1330661427,
          },
          [6] = {
            ["x"] = 373.53810107037,
            ["y"] = -312.41877274579,
          },
        },
      },
      [3] = {
        ["x"] = 260.60025859838,
        ["y"] = -432.05543520436,
        ["g"] = 25,
        ["sublevel"] = 5,
      },
      [4] = {
        ["x"] = 490.42071295242,
        ["y"] = -207.15826466181,
        ["sublevel"] = 2,
      },
    },
  },
  [7] = {
    ["name"] = "Cutwater Striker",
    ["id"] = 131112,
    ["count"] = 6,
    ["health"] = 768494,
    ["scale"] = 1.2,
    ["displayId"] = 78990,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
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
      [209859] = {
      },
      [272620] = {
      },
      [277242] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 438.91364326191,
        ["y"] = -171.61955940192,
        ["g"] = 11,
        ["sublevel"] = 3,
      },
      [2] = {
        ["x"] = 442.36530621817,
        ["y"] = -293.07662931057,
        ["g"] = 21,
        ["sublevel"] = 4,
      },
    },
  },
  [8] = {
    ["name"] = "Blacktooth Arsonist",
    ["id"] = 135366,
    ["count"] = 6,
    ["health"] = 845345,
    ["scale"] = 1.2,
    ["displayId"] = 84394,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [265889] = {
      },
      [277242] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 444.91362080064,
        ["y"] = -161.21952280377,
        ["g"] = 11,
        ["sublevel"] = 3,
      },
      [2] = {
        ["x"] = 339.97985221193,
        ["y"] = -223.16651558537,
        ["sublevel"] = 3,
      },
      [3] = {
        ["x"] = 469.30896999818,
        ["y"] = -306.25231313575,
        ["g"] = 16,
        ["sublevel"] = 3,
      },
      [4] = {
        ["x"] = 475.73756645102,
        ["y"] = -314.8237342011,
        ["g"] = 16,
        ["sublevel"] = 3,
      },
      [5] = {
        ["x"] = 463.16095012299,
        ["y"] = -411.51882344584,
        ["sublevel"] = 3,
      },
      [6] = {
        ["x"] = 338.82048561533,
        ["y"] = -459.48779564915,
        ["g"] = 43,
        ["sublevel"] = 4,
      },
      [7] = {
        ["x"] = 452.92765290393,
        ["y"] = -297.28269037781,
        ["g"] = 21,
        ["sublevel"] = 4,
      },
      [8] = {
        ["x"] = 576.99310183786,
        ["y"] = -189.2636595395,
        ["sublevel"] = 4,
      },
      [9] = {
        ["x"] = 592.90225009449,
        ["y"] = -243.80912399546,
        ["sublevel"] = 4,
      },
      [10] = {
        ["x"] = 411.29177304573,
        ["y"] = -168.1755326815,
        ["g"] = 22,
        ["sublevel"] = 4,
      },
      [11] = {
        ["x"] = 398.50106374076,
        ["y"] = -166.08252131348,
        ["g"] = 22,
        ["sublevel"] = 4,
      },
      [12] = {
        ["x"] = 399.33868110829,
        ["y"] = -153.17026228029,
        ["g"] = 22,
        ["sublevel"] = 4,
      },
      [13] = {
        ["x"] = 310.19898101028,
        ["y"] = -299.29694782543,
        ["sublevel"] = 4,
      },
      [14] = {
        ["x"] = 451.0749338574,
        ["y"] = -310.17339654044,
        ["g"] = 21,
        ["sublevel"] = 4,
      },
      [15] = {
        ["x"] = 387.10825865836,
        ["y"] = -327.80864757903,
        ["g"] = 15,
        ["sublevel"] = 3,
      },
    },
  },
  [9] = {
    ["name"] = "Despondent Scallywag",
    ["id"] = 130582,
    ["count"] = 0,
    ["health"] = 230549,
    ["scale"] = 1,
    ["neutral"] = true,
    ["displayId"] = 82828,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [277242] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 399.16415349133,
        ["y"] = -186.36952183157,
        ["sublevel"] = 3,
      },
      [2] = {
        ["x"] = 377.76183798225,
        ["y"] = -172.85543408806,
        ["sublevel"] = 3,
      },
      [3] = {
        ["x"] = 356.5394392884,
        ["y"] = -188.04642190814,
        ["sublevel"] = 3,
      },
      [4] = {
        ["x"] = 363.25811227846,
        ["y"] = -213.58579952476,
        ["sublevel"] = 3,
      },
      [5] = {
        ["x"] = 435.51552474471,
        ["y"] = -247.58941250354,
        ["sublevel"] = 3,
      },
      [6] = {
        ["x"] = 455.83812923582,
        ["y"] = -245.97651529586,
        ["sublevel"] = 3,
      },
      [7] = {
        ["x"] = 490.45741287849,
        ["y"] = -259.67823664231,
        ["sublevel"] = 3,
      },
      [8] = {
        ["x"] = 497.95742789606,
        ["y"] = -270.17822762617,
        ["sublevel"] = 3,
      },
      [9] = {
        ["x"] = 514.59871463497,
        ["y"] = -300.93909904085,
        ["sublevel"] = 3,
      },
      [10] = {
        ["x"] = 367.92955528628,
        ["y"] = -242.32351042292,
        ["sublevel"] = 3,
      },
      [11] = {
        ["x"] = 358.95549013445,
        ["y"] = -264.81075196189,
        ["sublevel"] = 3,
      },
      [12] = {
        ["x"] = 292.83791167328,
        ["y"] = -288.63135010439,
        ["sublevel"] = 3,
      },
      [13] = {
        ["x"] = 279.96680331062,
        ["y"] = -309.89522410862,
        ["sublevel"] = 3,
      },
      [14] = {
        ["x"] = 509.24879748026,
        ["y"] = -334.06950346075,
        ["sublevel"] = 3,
      },
      [15] = {
        ["x"] = 512.17985588983,
        ["y"] = -340.10398455655,
        ["sublevel"] = 3,
      },
      [16] = {
        ["x"] = 485.10320075226,
        ["y"] = -388.76501474893,
        ["sublevel"] = 3,
      },
      [17] = {
        ["x"] = 421.62820196217,
        ["y"] = -416.71908917301,
        ["sublevel"] = 4,
      },
      [18] = {
        ["x"] = 408.13980889411,
        ["y"] = -440.20744651337,
        ["sublevel"] = 4,
      },
      [19] = {
        ["x"] = 398.98219030411,
        ["y"] = -363.82208697561,
        ["sublevel"] = 4,
      },
      [20] = {
        ["x"] = 512.72816932252,
        ["y"] = -215.84435874927,
        ["sublevel"] = 4,
      },
      [21] = {
        ["x"] = 511.43785709384,
        ["y"] = -246.48948875714,
        ["sublevel"] = 4,
      },
      [22] = {
        ["x"] = 537.99899643287,
        ["y"] = -170.49694998748,
        ["sublevel"] = 4,
      },
      [23] = {
        ["x"] = 558.99893298186,
        ["y"] = -275.49689022452,
        ["sublevel"] = 4,
      },
      [24] = {
        ["x"] = 552.22488520648,
        ["y"] = -227.6260183297,
        ["sublevel"] = 4,
      },
      [25] = {
        ["x"] = 387.4814552537,
        ["y"] = -164.27339713864,
        ["sublevel"] = 4,
      },
      [26] = {
        ["x"] = 407.0886780298,
        ["y"] = -145.920272082,
        ["sublevel"] = 4,
      },
      [27] = {
        ["x"] = 413.89915895692,
        ["y"] = -118.29703487586,
        ["sublevel"] = 4,
      },
      [28] = {
        ["x"] = 432.89913548945,
        ["y"] = -128.29708350953,
        ["sublevel"] = 4,
      },
      [29] = {
        ["x"] = 333.97210038108,
        ["y"] = -174.95063873074,
        ["sublevel"] = 4,
      },
      [30] = {
        ["x"] = 350.36039252306,
        ["y"] = -382.21391295582,
        ["sublevel"] = 5,
      },
      [31] = {
        ["x"] = 321.22994208553,
        ["y"] = -394.60521477265,
        ["sublevel"] = 5,
      },
    },
  },
  [10] = {
    ["name"] = "Bilge Rat Looter",
    ["id"] = 127485,
    ["count"] = 3,
    ["health"] = 461097,
    ["scale"] = 1,
    ["displayId"] = 79322,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [258133] = {
      },
      [258134] = {
      },
      [277242] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 325.6419055777,
        ["y"] = -244.06877195236,
        ["sublevel"] = 3,
      },
      [2] = {
        ["x"] = 281.72339595137,
        ["y"] = -320.47911822193,
        ["sublevel"] = 3,
      },
      [3] = {
        ["x"] = 408.23200240763,
        ["y"] = -325.88818210011,
        ["g"] = 15,
        ["sublevel"] = 3,
      },
      [4] = {
        ["x"] = 401.70139083722,
        ["y"] = -336.7045124401,
        ["g"] = 15,
        ["sublevel"] = 3,
      },
      [5] = {
        ["x"] = 471.94551441813,
        ["y"] = -381.69079464815,
        ["sublevel"] = 3,
      },
      [6] = {
        ["x"] = 446.81472496499,
        ["y"] = -429.6626044022,
        ["sublevel"] = 3,
      },
      [7] = {
        ["x"] = 399.31109148195,
        ["y"] = -524.1061140859,
        ["sublevel"] = 3,
      },
      [8] = {
        ["x"] = 399.13476424929,
        ["y"] = -453.1987822089,
        ["g"] = 18,
        ["sublevel"] = 3,
      },
      [9] = {
        ["x"] = 392.33470730792,
        ["y"] = -459.19877691377,
        ["g"] = 18,
        ["sublevel"] = 3,
      },
      [10] = {
        ["x"] = 385.13474799435,
        ["y"] = -460.39881018702,
        ["g"] = 18,
        ["sublevel"] = 3,
      },
      [11] = {
        ["x"] = 377.45568019118,
        ["y"] = -452.05373643056,
        ["g"] = 18,
        ["sublevel"] = 3,
      },
      [12] = {
        ["x"] = 388.33809004435,
        ["y"] = -443.81839792574,
        ["g"] = 18,
        ["sublevel"] = 3,
      },
      [13] = {
        ["x"] = 343.86708263188,
        ["y"] = -490.89182680386,
        ["sublevel"] = 3,
      },
      [14] = {
        ["x"] = 260.31258395163,
        ["y"] = -420.56458688456,
        ["g"] = 25,
        ["sublevel"] = 5,
      },
    },
  },
  [11] = {
    ["name"] = "Cutwater Striker",
    ["id"] = 131112,
    ["count"] = 6,
    ["health"] = 768495,
    ["scale"] = 1,
    ["displayId"] = 78990,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
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
      [209859] = {
      },
      [272620] = {
      },
      [277242] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 303.06214892669,
        ["y"] = -342.85695519908,
        ["g"] = 14,
        ["sublevel"] = 3,
      },
      [2] = {
        ["x"] = 302.13192386986,
        ["y"] = -336.34531991941,
        ["g"] = 14,
        ["sublevel"] = 3,
      },
      [3] = {
        ["x"] = 463.96367588866,
        ["y"] = -315.18091172191,
        ["g"] = 16,
        ["sublevel"] = 3,
      },
      [4] = {
        ["x"] = 290.27940164397,
        ["y"] = -446.34556786155,
        ["g"] = 19,
        ["sublevel"] = 3,
      },
      [5] = {
        ["x"] = 358.86758599858,
        ["y"] = -232.54112799194,
        ["g"] = 23,
        ["sublevel"] = 4,
      },
      [6] = {
        ["x"] = 396.65372420396,
        ["y"] = -315.53595075063,
        ["g"] = 15,
        ["sublevel"] = 3,
      },
    },
  },
  [12] = {
    ["name"] = "Bilge Rat Seaspeaker",
    ["id"] = 130026,
    ["count"] = 6,
    ["health"] = 691646,
    ["scale"] = 1.2,
    ["displayId"] = 42840,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
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
      [209859] = {
      },
      [258150] = {
      },
      [258153] = {
      },
      [277242] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 280.78690373476,
        ["y"] = -447.49873407591,
        ["g"] = 19,
        ["sublevel"] = 3,
      },
      [2] = {
        ["x"] = 288.05961152145,
        ["y"] = -436.58963338193,
        ["g"] = 19,
        ["sublevel"] = 3,
      },
      [3] = {
        ["x"] = 440.07049065209,
        ["y"] = -309.06839434267,
        ["g"] = 21,
        ["sublevel"] = 4,
      },
      [4] = {
        ["x"] = 461.14195696974,
        ["y"] = -280.49696524666,
        ["g"] = 21,
        ["sublevel"] = 4,
      },
      [5] = {
        ["x"] = 367.79621602493,
        ["y"] = -221.11258700735,
        ["g"] = 23,
        ["sublevel"] = 4,
      },
      [6] = {
        ["x"] = 351.01046023995,
        ["y"] = -240.04115207794,
        ["g"] = 23,
        ["sublevel"] = 4,
      },
      [7] = {
        ["x"] = 343.50529897076,
        ["y"] = -229.42082777753,
        ["g"] = 23,
        ["sublevel"] = 4,
      },
    },
  },
  [13] = {
    ["name"] = "Irontide Raider",
    ["id"] = 135254,
    ["count"] = 4,
    ["health"] = 461096,
    ["scale"] = 1,
    ["displayId"] = 79064,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Root"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 509.64193698534,
        ["y"] = -323.56841311087,
        ["sublevel"] = 4,
      },
      [2] = {
        ["x"] = 519.73551776178,
        ["y"] = -294.94335528054,
        ["sublevel"] = 4,
      },
      [3] = {
        ["x"] = 331.53965844642,
        ["y"] = -162.51820154885,
        ["sublevel"] = 4,
      },
      [4] = {
        ["x"] = 315.99131365628,
        ["y"] = -187.09743281643,
        ["sublevel"] = 4,
      },
      [5] = {
        ["x"] = 294.92759545372,
        ["y"] = -215.21126254028,
        ["sublevel"] = 4,
      },
    },
  },
  [14] = {
    ["name"] = "Block Warden",
    ["id"] = 131445,
    ["count"] = 9,
    ["health"] = 1383289,
    ["scale"] = 1.2,
    ["displayId"] = 81496,
    ["creatureType"] = "Humanoid",
    ["level"] = 121,
    ["characteristics"] = {
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [259188] = {
      },
      [259711] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 352.79616785293,
        ["y"] = -221.11258700735,
        ["g"] = 23,
        ["sublevel"] = 4,
      },
    },
  },
  [15] = {
    ["name"] = "Jes Howlis",
    ["id"] = 127484,
    ["count"] = 0,
    ["health"] = 4610970,
    ["scale"] = 1,
    ["displayId"] = 81739,
    ["creatureType"] = "Humanoid",
    ["level"] = 122,
    ["isBoss"] = true,
    ["encounterID"] = 2098,
    ["instanceID"] = 1002,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [205276] = {
      },
      [257777] = {
      },
      [257785] = {
      },
      [257791] = {
      },
      [257793] = {
      },
      [257814] = {
      },
      [257827] = {
      },
      [257956] = {
      },
      [258544] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 318.27236291642,
        ["y"] = -342.9850555754,
        ["sublevel"] = 4,
      },
    },
  },
  [16] = {
    ["name"] = "Ashvane Jailer",
    ["id"] = 135699,
    ["count"] = 7,
    ["health"] = 1229590,
    ["scale"] = 1.2,
    ["stealthDetect"] = true,
    ["displayId"] = 81513,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [258313] = {
      },
      [258317] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 263.2873792635,
        ["y"] = -321.60115034702,
        ["g"] = 24,
        ["sublevel"] = 4,
      },
    },
  },
  [17] = {
    ["name"] = "Ashvane Officer",
    ["id"] = 127486,
    ["count"] = 7,
    ["health"] = 1229592,
    ["scale"] = 1.2,
    ["stealthDetect"] = true,
    ["displayId"] = 84380,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
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
      [132951] = {
      },
      [209859] = {
      },
      [258313] = {
      },
      [258317] = {
      },
      [277242] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 273.59065723706,
        ["y"] = -431.49747604165,
        ["g"] = 25,
        ["sublevel"] = 5,
      },
      [2] = {
        ["x"] = 416.21652165327,
        ["y"] = -358.48696179859,
        ["g"] = 26,
        ["sublevel"] = 5,
      },
      [3] = {
        ["x"] = 445.3997130528,
        ["y"] = -399.09683310571,
        ["g"] = 27,
        ["sublevel"] = 5,
      },
      [4] = {
        ["x"] = 339.97462175159,
        ["y"] = -236.49684323045,
        ["g"] = 40,
        ["sublevel"] = 5,
      },
      [5] = {
        ["x"] = 309.71831615463,
        ["y"] = -184.2656017754,
        ["g"] = 29,
        ["sublevel"] = 5,
      },
      [6] = {
        ["x"] = 324.00409967373,
        ["y"] = -184.62271877494,
        ["g"] = 29,
        ["sublevel"] = 5,
      },
      [7] = {
        ["x"] = 436.89852951953,
        ["y"] = -116.52643540471,
        ["g"] = 31,
        ["sublevel"] = 5,
      },
      [8] = {
        ["x"] = 429.47915806449,
        ["y"] = -128.13931468112,
        ["g"] = 31,
        ["sublevel"] = 5,
      },
      [9] = {
        ["x"] = 407.00029696023,
        ["y"] = -116.73914881196,
        ["g"] = 33,
        ["sublevel"] = 6,
      },
      [10] = {
        ["x"] = 341.32534143007,
        ["y"] = -188.70847958861,
        ["g"] = 34,
        ["sublevel"] = 6,
      },
      [11] = {
        ["x"] = 282.00011311733,
        ["y"] = -268.13304911185,
        ["g"] = 35,
        ["sublevel"] = 6,
      },
      [12] = {
        ["x"] = 343.49253473649,
        ["y"] = -419.02110471566,
        ["g"] = 37,
        ["sublevel"] = 6,
      },
      [13] = {
        ["x"] = 337.61022896149,
        ["y"] = -428.72700391062,
        ["g"] = 37,
        ["sublevel"] = 6,
      },
      [14] = {
        ["x"] = 349.18896568803,
        ["y"] = -228.88503493595,
        ["g"] = 40,
        ["sublevel"] = 5,
      },
    },
  },
  [18] = {
    ["name"] = "Ashvane Marine",
    ["id"] = 130027,
    ["count"] = 7,
    ["health"] = 1229592,
    ["scale"] = 1.2,
    ["displayId"] = 81513,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
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
      [132951] = {
      },
      [185857] = {
      },
      [209859] = {
      },
      [258864] = {
      },
      [277242] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 428.93550353855,
        ["y"] = -360.28152301284,
        ["g"] = 26,
        ["sublevel"] = 5,
      },
      [2] = {
        ["x"] = 528.13019744539,
        ["y"] = -338.42129253843,
        ["g"] = 28,
        ["sublevel"] = 5,
      },
      [3] = {
        ["x"] = 284.23766854546,
        ["y"] = -348.02078743969,
        ["sublevel"] = 5,
      },
      [4] = {
        ["x"] = 256.09263363268,
        ["y"] = -261.73805103142,
        ["g"] = 30,
        ["sublevel"] = 5,
      },
      [5] = {
        ["x"] = 251.67951143731,
        ["y"] = -272.93801211483,
        ["g"] = 30,
        ["sublevel"] = 5,
      },
      [6] = {
        ["x"] = 260.76150040665,
        ["y"] = -280.26914006618,
        ["g"] = 30,
        ["sublevel"] = 5,
      },
      [7] = {
        ["x"] = 453.72596677257,
        ["y"] = -129.89677011403,
        ["g"] = 31,
        ["sublevel"] = 5,
      },
      [8] = {
        ["x"] = 441.41463616357,
        ["y"] = -139.10706553052,
        ["g"] = 31,
        ["sublevel"] = 5,
      },
      [9] = {
        ["x"] = 395.54529956391,
        ["y"] = -121.06264448015,
        ["g"] = 33,
        ["sublevel"] = 6,
      },
      [10] = {
        ["x"] = 330.73709005778,
        ["y"] = -185.76728883463,
        ["g"] = 34,
        ["sublevel"] = 6,
      },
      [11] = {
        ["x"] = 288.23092058391,
        ["y"] = -378.52744333478,
        ["g"] = 36,
        ["sublevel"] = 6,
      },
      [12] = {
        ["x"] = 279.43087112963,
        ["y"] = -390.9274552797,
        ["g"] = 36,
        ["sublevel"] = 6,
      },
      [13] = {
        ["x"] = 347.90433348963,
        ["y"] = -428.13876071096,
        ["g"] = 37,
        ["sublevel"] = 6,
      },
      [14] = {
        ["x"] = 357.31353423848,
        ["y"] = -244.24260710534,
        ["g"] = 40,
        ["sublevel"] = 5,
      },
      [15] = {
        ["x"] = 342.31352904516,
        ["y"] = -247.24263303412,
        ["g"] = 40,
        ["sublevel"] = 5,
      },
    },
  },
  [19] = {
    ["name"] = "Ashvane Flamecaster",
    ["id"] = 127488,
    ["count"] = 7,
    ["health"] = 1075893,
    ["scale"] = 1.2,
    ["displayId"] = 81520,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [258634] = {
      },
      [258869] = {
      },
      [277242] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 484.78556244655,
        ["y"] = -401.59213388675,
        ["g"] = 27,
        ["sublevel"] = 5,
      },
      [2] = {
        ["x"] = 494.2015688759,
        ["y"] = -329.84984081926,
        ["g"] = 28,
        ["sublevel"] = 5,
      },
      [3] = {
        ["x"] = 507.4158787811,
        ["y"] = -315.20698628135,
        ["g"] = 28,
        ["sublevel"] = 5,
      },
      [4] = {
        ["x"] = 410.93685438669,
        ["y"] = -150.94506086973,
        ["sublevel"] = 5,
      },
      [5] = {
        ["x"] = 534.1133210271,
        ["y"] = -255.32920031569,
        ["g"] = 32,
        ["sublevel"] = 5,
      },
      [6] = {
        ["x"] = 520.62492795904,
        ["y"] = -279.98036392787,
        ["g"] = 32,
        ["sublevel"] = 5,
      },
      [7] = {
        ["x"] = 537.36915862756,
        ["y"] = -274.16641241129,
        ["g"] = 32,
        ["sublevel"] = 5,
      },
      [8] = {
        ["x"] = 268.81835147547,
        ["y"] = -269.95122712534,
        ["g"] = 35,
        ["sublevel"] = 6,
      },
      [9] = {
        ["x"] = 287.0001122935,
        ["y"] = -279.49667967899,
        ["g"] = 35,
        ["sublevel"] = 6,
      },
      [10] = {
        ["x"] = 290.03091038846,
        ["y"] = -388.92747130218,
        ["g"] = 36,
        ["sublevel"] = 6,
      },
      [11] = {
        ["x"] = 299.95970605716,
        ["y"] = -384.76549551068,
        ["g"] = 36,
        ["sublevel"] = 6,
      },
    },
  },
  [20] = {
    ["name"] = "Ashvane Spotter",
    ["id"] = 136665,
    ["count"] = 7,
    ["health"] = 1229592,
    ["scale"] = 1.2,
    ["displayId"] = 81513,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
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
      [185857] = {
      },
      [209859] = {
      },
      [258864] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 465.70560778831,
        ["y"] = -196.61444212221,
        ["sublevel"] = 5,
      },
    },
  },
  [21] = {
    ["name"] = "Knight Captain Valyri",
    ["id"] = 127490,
    ["count"] = 0,
    ["health"] = 5379465,
    ["scale"] = 1.4,
    ["displayId"] = 81498,
    ["creatureType"] = "Humanoid",
    ["level"] = 122,
    ["isBoss"] = true,
    ["encounterID"] = 2099,
    ["instanceID"] = 1002,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [256955] = {
      },
      [256970] = {
      },
      [256976] = {
      },
      [257028] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 408.18795143608,
        ["y"] = -469.85788606973,
        ["sublevel"] = 6,
      },
    },
  },
  [22] = {
    ["name"] = "Ashvane Warden",
    ["id"] = 127497,
    ["count"] = 9,
    ["health"] = 1383291,
    ["scale"] = 1.2,
    ["stealthDetect"] = true,
    ["displayId"] = 81496,
    ["creatureType"] = "Humanoid",
    ["level"] = 121,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [259188] = {
      },
      [259711] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 507.95729835021,
        ["y"] = -349.60682645817,
        ["sublevel"] = 6,
      },
      [2] = {
        ["x"] = 466.69231767646,
        ["y"] = -171.92045801987,
        ["g"] = 39,
        ["sublevel"] = 7,
      },
      [3] = {
        ["x"] = 484.38466373628,
        ["y"] = -184.22818275919,
        ["g"] = 39,
        ["sublevel"] = 7,
      },
      [4] = {
        ["x"] = 287.81427825998,
        ["y"] = -400.39920708411,
        ["g"] = 36,
        ["sublevel"] = 6,
      },
    },
  },
  [23] = {
    ["name"] = "Ashvane Priest",
    ["id"] = 130028,
    ["count"] = 7,
    ["health"] = 1229592,
    ["scale"] = 1,
    ["displayId"] = 81550,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [258917] = {
      },
      [258935] = {
      },
      [258938] = {
      },
      [277242] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 557.92331321717,
        ["y"] = -259.55412635752,
        ["g"] = 38,
        ["sublevel"] = 6,
      },
      [2] = {
        ["x"] = 565.7804389758,
        ["y"] = -264.55413219691,
        ["g"] = 38,
        ["sublevel"] = 6,
      },
      [3] = {
        ["x"] = 482.64180523204,
        ["y"] = -169.76710967625,
        ["g"] = 39,
        ["sublevel"] = 7,
      },
    },
  },
  [24] = {
    ["name"] = "Overseer Korgus",
    ["id"] = 127503,
    ["count"] = 0,
    ["health"] = 6609057,
    ["scale"] = 1,
    ["displayId"] = 81505,
    ["creatureType"] = "Humanoid",
    ["level"] = 122,
    ["isBoss"] = true,
    ["encounterID"] = 2096,
    ["instanceID"] = 1002,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [256038] = {
      },
      [256039] = {
      },
      [256044] = {
      },
      [256083] = {
      },
      [256101] = {
      },
      [256105] = {
      },
      [256128] = {
      },
      [256198] = {
      },
      [256199] = {
      },
      [256200] = {
      },
      [256201] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 336.40231150178,
        ["y"] = -379.05602618369,
        ["sublevel"] = 7,
      },
    },
  },
  [25] = {
    ["name"] = "Bilge Rat Looter",
    ["id"] = 135706,
    ["count"] = 3,
    ["health"] = 461096,
    ["scale"] = 1,
    ["displayId"] = 79322,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 257.82684543938,
        ["y"] = -328.42866822157,
        ["g"] = 24,
        ["sublevel"] = 4,
      },
    },
  },
};
