local addonName = ...
local MDT = MDT
local L = MDT.L
local dungeonIndex = 10
MDT.dungeonList[dungeonIndex] = L["Return to Karazhan Upper"]
MDT.dungeonTotalCount[dungeonIndex] = { normal = 169, teeming = 202, teemingEnabled = true }

MDT.mapInfo[dungeonIndex] = {
  teleportId = 373262,
  shortName = L["karaUpperShortName"],
  englishName = "Return to Karazhan Upper",
  mapID = 234
};

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Interface\\AddOns\\' .. addonName .. '\\Legion\\Textures\\UpperKarazhan' }
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Return to Karazhan Upper"],
}

MDT.mapPOIs[dungeonIndex] = {
  [1] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "generalNote",
      ["x"] = 473.71573045709,
      ["y"] = -62.768256975879,
      ["text"] = "manaDevourerNote",
    },
    [2] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "dungeonEntrance",
      ["x"] = 352.46325812626,
      ["y"] = -345.36401564462,
    },
  },
};


MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Forlorn Spirit",
    ["id"] = 114626,
    ["count"] = 4,
    ["health"] = 340880,
    ["scale"] = 2,
    ["displayId"] = 26404,
    ["creatureType"] = "Undead",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [228252] = {
      },
      [228254] = {
      },
      [228255] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 255.36254975962,
        ["y"] = -359.35690283028,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [2] = {
        ["x"] = 294.90705527658,
        ["y"] = -379.64930297256,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
    },
  },
  [2] = {
    ["name"] = "Shrieking Terror",
    ["id"] = 114627,
    ["count"] = 4,
    ["health"] = 382886,
    ["scale"] = 2,
    ["displayId"] = 10698,
    ["creatureType"] = "Undead",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [228239] = {
      },
      [228241] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 320.85875644405,
        ["y"] = -328.17757063263,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
    },
  },
  [3] = {
    ["name"] = "Damaged Golem",
    ["id"] = 114334,
    ["count"] = 6,
    ["health"] = 306309,
    ["scale"] = 1.5,
    ["displayId"] = 61850,
    ["creatureType"] = "Mechanical",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [227529] = {
      },
      [242894] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 185.11114266127,
        ["y"] = -254.77801948797,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [2] = {
        ["x"] = 178.45536754786,
        ["y"] = -309.85344428647,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [3] = {
        ["x"] = 60.661969581334,
        ["y"] = -330.83838681306,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [4] = {
        ["x"] = 164.75337421211,
        ["y"] = -398.87315470401,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
    },
  },
  [4] = {
    ["name"] = "Abstract Nullifier",
    ["id"] = 115765,
    ["count"] = 18,
    ["health"] = 340343,
    ["scale"] = 1,
    ["displayId"] = 74335,
    ["creatureType"] = "Mechanical",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [230050] = {
      },
      [230083] = {
      },
      [230094] = {
      },
      [230161] = {
      },
      [230162] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 121.45753645188,
        ["y"] = -293.45335428796,
        ["sublevel"] = 1,
        ["scale"] = 2.3,
      },
    },
  },
  [5] = {
    ["name"] = "Mana Confluence",
    ["id"] = 114338,
    ["count"] = 9,
    ["health"] = 306309,
    ["scale"] = 1.5,
    ["displayId"] = 55144,
    ["creatureType"] = "Elemental",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [228700] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 67.471026906501,
        ["y"] = -341.29183191758,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [2] = {
        ["x"] = 126.6846199343,
        ["y"] = -354.18279135194,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [3] = {
        ["x"] = 107.29566089226,
        ["y"] = -405.4490493819,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [4] = {
        ["x"] = 155.77201435916,
        ["y"] = -388.48944730103,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
    },
  },
  [6] = {
    ["name"] = "Mana-Gorged Wyrm",
    ["id"] = 114364,
    ["count"] = 1,
    ["health"] = 102103,
    ["scale"] = 1.5,
    ["displayId"] = 62387,
    ["creatureType"] = "Beast",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [228362] = {
      },
      [232271] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 47.522164824389,
        ["y"] = -332.90642314081,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [2] = {
        ["x"] = 54.296742010497,
        ["y"] = -343.98170809164,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [3] = {
        ["x"] = 63.671590067718,
        ["y"] = -353.75061297893,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [4] = {
        ["x"] = 143.67916607638,
        ["y"] = -354.0105080249,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [5] = {
        ["x"] = 136.21494925939,
        ["y"] = -344.71513588297,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [6] = {
        ["x"] = 127.55570078127,
        ["y"] = -335.53716477677,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [7] = {
        ["x"] = 100.48012645561,
        ["y"] = -393.10276168282,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [8] = {
        ["x"] = 96.277081583523,
        ["y"] = -413.78108806362,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [9] = {
        ["x"] = 88.551252930065,
        ["y"] = -401.79699501304,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [10] = {
        ["x"] = 169.3956270064,
        ["y"] = -385.20045153879,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [11] = {
        ["x"] = 178.10415717185,
        ["y"] = -396.41954376913,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [12] = {
        ["x"] = 160.37722308354,
        ["y"] = -375.83968738831,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
    },
  },
  [7] = {
    ["name"] = "Infused Pyromancer",
    ["id"] = 115488,
    ["count"] = 8,
    ["health"] = 467972,
    ["scale"] = 2,
    ["displayId"] = 63419,
    ["creatureType"] = "Demon",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [229677] = {
      },
      [229678] = {
      },
      [374743] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 99.323941172796,
        ["y"] = -113.75833565151,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [2] = {
        ["x"] = 26.658627431692,
        ["y"] = -126.521394096,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [3] = {
        ["x"] = 752.97600326895,
        ["y"] = -228.62523689143,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [4] = {
        ["x"] = 99.233061708414,
        ["y"] = -148.07567683058,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [5] = {
        ["x"] = 753.07127973856,
        ["y"] = -170.87672846423,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [6] = {
        ["x"] = 735.7280213263,
        ["y"] = -228.35305261102,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
    },
  },
  [8] = {
    ["name"] = "Fel Bat",
    ["id"] = 115484,
    ["count"] = 4,
    ["health"] = 212714,
    ["scale"] = 1.5,
    ["displayId"] = 73837,
    ["creatureType"] = "Demon",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Sap"] = true,
    },
    ["spells"] = {
      [229597] = {
      },
      [229622] = {
      },
      [229623] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 76.987079074466,
        ["y"] = -133.63883577023,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [2] = {
        ["x"] = 124.60417422543,
        ["y"] = -190.25690241712,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [3] = {
        ["x"] = 78.137297255742,
        ["y"] = -190.54539627945,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [4] = {
        ["x"] = 125.22283986485,
        ["y"] = -162.00179505129,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [5] = {
        ["x"] = 126.06048901179,
        ["y"] = -133.36396219669,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [6] = {
        ["x"] = 776.2517710715,
        ["y"] = -90.001932173296,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [7] = {
        ["x"] = 775.6823826535,
        ["y"] = -55.589533950719,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [8] = {
        ["x"] = 736.38580929051,
        ["y"] = -91.284205984724,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [9] = {
        ["x"] = 776.93784936913,
        ["y"] = -143.96431467898,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [10] = {
        ["x"] = 733.35867373687,
        ["y"] = -143.49500295366,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [11] = {
        ["x"] = 775.9658588157,
        ["y"] = -117.20460710762,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [12] = {
        ["x"] = 761.5351176325,
        ["y"] = -252.81841531054,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [13] = {
        ["x"] = 736.84429777652,
        ["y"] = -266.67376480322,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [14] = {
        ["x"] = 745.18799402043,
        ["y"] = -195.08894097639,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
    },
  },
  [9] = {
    ["name"] = "Wrathguard Flamebringer",
    ["id"] = 115757,
    ["count"] = 12,
    ["health"] = 638144,
    ["scale"] = 2,
    ["displayId"] = 73944,
    ["creatureType"] = "Demon",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [191540] = {
      },
      [230043] = {
      },
      [230044] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 210.9803824063,
        ["y"] = -169.63633233135,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
    },
  },
  [10] = {
    ["name"] = "Rat",
    ["id"] = 115417,
    ["count"] = 7,
    ["health"] = 382886,
    ["scale"] = 2,
    ["displayId"] = 73857,
    ["creatureType"] = "Beast",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [229692] = {
      },
      [229693] = {
      },
      [229696] = {
      },
      [229698] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 579.07499955482,
        ["y"] = -373.43865103144,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [2] = {
        ["x"] = 578.508042024,
        ["y"] = -439.52938346142,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [3] = {
        ["x"] = 578.12122657475,
        ["y"] = -260.86017693585,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
    },
  },
  [11] = {
    ["name"] = "Ancient Tome",
    ["id"] = 115419,
    ["count"] = 7,
    ["health"] = 298270,
    ["scale"] = 2,
    ["displayId"] = 73859,
    ["creatureType"] = "Beast",
    ["level"] = 81,
    ["clones"] = {
      [1] = {
        ["x"] = 549.90648831992,
        ["y"] = -410.11526437961,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [2] = {
        ["x"] = 550.27655426593,
        ["y"] = -278.41600219615,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
    },
  },
  [12] = {
    ["name"] = "Spider",
    ["id"] = 115418,
    ["count"] = 7,
    ["health"] = 319072,
    ["scale"] = 2,
    ["displayId"] = 73858,
    ["creatureType"] = "Beast",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [229704] = {
      },
      [229705] = {
      },
      [229706] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 551.18561825703,
        ["y"] = -238.15057446772,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [2] = {
        ["x"] = 552.57038560818,
        ["y"] = -344.34935617413,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [3] = {
        ["x"] = 578.44913390362,
        ["y"] = -410.20079482343,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
    },
  },
  [13] = {
    ["name"] = "Mana Devourer",
    ["id"] = 115831,
    ["count"] = 3,
    ["health"] = 212714,
    ["scale"] = 1,
    ["displayId"] = 62384,
    ["creatureType"] = "Elemental",
    ["level"] = 82,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Root"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [230218] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 489.22108121455,
        ["y"] = -63.120449989798,
        ["sublevel"] = 1,
        ["scale"] = 1.7,
      },
      [2] = {
        ["x"] = 500.57650723939,
        ["y"] = -49.200038024107,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [3] = {
        ["x"] = 505.46747870174,
        ["y"] = -41.064947891392,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [4] = {
        ["x"] = 509.44983343211,
        ["y"] = -48.712487332007,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [5] = {
        ["x"] = 544.31454034497,
        ["y"] = -40.913372241108,
        ["g"] = 6,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [6] = {
        ["x"] = 540.20485545503,
        ["y"] = -47.927664640851,
        ["g"] = 6,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [7] = {
        ["x"] = 548.72653220204,
        ["y"] = -48.490267510285,
        ["g"] = 6,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [8] = {
        ["x"] = 556.87966917252,
        ["y"] = -71.430140272783,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [9] = {
        ["x"] = 549.42309586086,
        ["y"] = -62.982962709744,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [10] = {
        ["x"] = 556.05383566105,
        ["y"] = -86.363459521839,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [11] = {
        ["x"] = 518.6286369718,
        ["y"] = -99.117057244095,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [12] = {
        ["x"] = 513.0867813308,
        ["y"] = -107.48513684231,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [13] = {
        ["x"] = 522.12753796685,
        ["y"] = -107.87047139226,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [14] = {
        ["x"] = 497.41461675087,
        ["y"] = -84.657901335875,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [15] = {
        ["x"] = 492.71557420247,
        ["y"] = -92.483606137801,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [16] = {
        ["x"] = 501.91630257425,
        ["y"] = -92.778786954811,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [17] = {
        ["x"] = 548.34537382968,
        ["y"] = -85.847324931238,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [18] = {
        ["x"] = 548.38374275807,
        ["y"] = -78.023627502421,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [19] = {
        ["x"] = 556.40437051655,
        ["y"] = -78.615282912696,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [20] = {
        ["x"] = 556.87302406752,
        ["y"] = -63.787303877341,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [21] = {
        ["x"] = 548.4935131122,
        ["y"] = -71.407814130847,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
    },
  },
  [14] = {
    ["name"] = "Erudite Slayer",
    ["id"] = 115486,
    ["count"] = 9,
    ["health"] = 340343,
    ["scale"] = 2,
    ["displayId"] = 73838,
    ["creatureType"] = "Demon",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [229608] = {
      },
      [229611] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 753.15020363831,
        ["y"] = -152.55843649688,
        ["g"] = 15,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
    },
  },
  [15] = {
    ["name"] = "King",
    ["id"] = 115388,
    ["count"] = 18,
    ["health"] = 638144,
    ["scale"] = 3,
    ["displayId"] = 16293,
    ["creatureType"] = "Humanoid",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [229427] = {
      },
      [229429] = {
      },
      [229468] = {
      },
      [229489] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 739.29096613798,
        ["y"] = -398.05426887796,
        ["sublevel"] = 1,
      },
    },
  },
  [16] = {
    ["name"] = "The Curator",
    ["id"] = 114247,
    ["count"] = 0,
    ["health"] = 2091168,
    ["scale"] = 2,
    ["displayId"] = 16958,
    ["creatureType"] = "Mechanical",
    ["level"] = 82,
    ["isBoss"] = true,
    ["encounterID"] = 1557,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [227254] = {
      },
      [227257] = {
      },
      [227267] = {
      },
      [227285] = {
      },
      [227465] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 185.403750989,
        ["y"] = -472.65441806645,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
    },
  },
  [17] = {
    ["name"] = "Viz'aduum the Watcher",
    ["id"] = 114790,
    ["count"] = 0,
    ["health"] = 1704400,
    ["scale"] = 2,
    ["displayId"] = 73709,
    ["creatureType"] = "Humanoid",
    ["level"] = 82,
    ["isBoss"] = true,
    ["encounterID"] = 1838,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [229083] = {
      },
      [229151] = {
      },
      [229159] = {
      },
      [229161] = {
      },
      [229598] = {
      },
      [229610] = {
      },
      [230084] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 744.18655545962,
        ["y"] = -510.82506184766,
        ["sublevel"] = 1,
      },
    },
  },
  [18] = {
    ["name"] = "Shade of Medivh",
    ["id"] = 114350,
    ["count"] = 0,
    ["health"] = 1491350,
    ["scale"] = 2,
    ["displayId"] = 73834,
    ["creatureType"] = "Humanoid",
    ["level"] = 82,
    ["isBoss"] = true,
    ["encounterID"] = 1817,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [227592] = {
      },
      [227615] = {
      },
      [227628] = {
      },
      [227641] = {
      },
      [227644] = {
      },
      [227779] = {
      },
      [228249] = {
      },
      [228261] = {
      },
      [228262] = {
      },
      [228269] = {
      },
      [228334] = {
      },
      [228958] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 427.87415292095,
        ["y"] = -171.34916364824,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
    },
  },
  [19] = {
    ["name"] = "Mana Devourer",
    ["id"] = 114252,
    ["count"] = 0,
    ["health"] = 1917450,
    ["scale"] = 2,
    ["displayId"] = 73157,
    ["creatureType"] = "Dragonkin",
    ["level"] = 82,
    ["isBoss"] = true,
    ["encounterID"] = 1818,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [227297] = {
      },
      [227457] = {
      },
      [227523] = {
      },
      [227618] = {
      },
      [227620] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 605.42711753764,
        ["y"] = -231.05968355034,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
    },
  },
};
