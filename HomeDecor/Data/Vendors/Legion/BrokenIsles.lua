local ADDON, NS = ...

NS.Data = NS.Data or {}
NS.Data.Vendors = NS.Data.Vendors or {}

NS.Data.Vendors["Legion"] = NS.Data.Vendors["Legion"] or {}

NS.Data.Vendors["Legion"]["BrokenIsles"] = {

  {
    source={
      id=89939,
      type="vendor",
      faction="Horde",
      zone="Azsuna",
      worldmap="630:4780:2360"
    },
    items={
      {decorID=2530, source={type="vendor", itemID=246864, currency="1000", currencytype=1220}, requirements={quest={id=37470}}},
    }
  },

  {
    source={
      id=93971,
      type="vendor",
      faction="Neutral",
      zone="Suramar",
      worldmap="680:4032:6973"
    },
    items={
      {decorID=4026, source={type="vendor", itemID=247912, currency="250", currencytype=1155}},
      {decorID=4033, source={type="vendor", itemID=247919, currency="150", currencytype=1155}},
    }
  },

  {
    source={
      id=97140,
      type="vendor",
      faction="Horde",
      zone="Suramar",
      worldmap="680:3713:4655"
    },
    items={
      {decorID=1440, source={type="vendor", itemID=244536}, requirements={rep="true"}},
      {decorID=2516, source={type="vendor", itemID=246850}, requirements={rep="true"}},
      {decorID=3983, source={type="vendor", itemID=247844}, requirements={rep="true"}},
      {decorID=3984, source={type="vendor", itemID=247845}, requirements={rep="true"}},
      {decorID=3985, source={type="vendor", itemID=247847}, requirements={rep="true"}},
      {decorID=4024, source={type="vendor", itemID=247910}, requirements={rep="true"}},
      {decorID=4035, source={type="vendor", itemID=247921}, requirements={rep="true"}},
      {decorID=4038, source={type="vendor", itemID=247924}, requirements={rep="true"}},
    }
  },

  {
    source={
      id=103693,
      type="vendor",
      faction="Neutral",
      zone="Trueshot Lodge",
      worldmap="739:4456:4888"
    },
    items={
      {decorID=1740, source={type="vendor", itemID=245549, currency="500", currencytype=1220}},
      {decorID=5877, source={type="vendor", itemID=250110, currency="500", currencytype=1220}},
      {decorID=5891, source={type="vendor", itemID=250126, currency="2000", currencytype=1220}, requirements={achievement={id=60984}}},
      {decorID=5893, source={type="vendor", itemID=250128, currency="1000", currencytype=1220}},
    }
  },

  {
    source={
      id=105333,
      type="vendor",
      faction="Neutral",
      zone="Dalaran",
      worldmap="628:6736:6322"
    },
    items={
      {decorID=7610, source={type="vendor", itemID=250307, costs={{currency="6000", currencytype=1220},{currency="50", currencytype=1508}}}, requirements={achievement={id=42318}}},
      {decorID=7620, source={type="vendor", itemID=250402, costs={{currency="12000", currencytype=1220},{currency="50", currencytype=1508}}}, requirements={achievement={id=42658}}},
      {decorID=7621, source={type="vendor", itemID=250403, costs={{currency="18000", currencytype=1220},{currency="50", currencytype=1508}}}, requirements={achievement={id=42692}}},
      {decorID=7622, source={type="vendor", itemID=250404, costs={{currency="3000", currencytype=1220},{currency="50", currencytype=1508}}}},
      {decorID=7623, source={type="vendor", itemID=250405, costs={{currency="3000", currencytype=1220},{currency="50", currencytype=1508}}}, requirements={achievement={id=61060}}},
      {decorID=7624, source={type="vendor", itemID=250406, costs={{currency="18000", currencytype=1220},{currency="50", currencytype=1508}}}, requirements={achievement={id=42321}}},
      {decorID=7625, source={type="vendor", itemID=250407, costs={{currency="3000", currencytype=1220},{currency="50", currencytype=1508}}}, requirements={achievement={id=42619}}},
      {decorID=7658, source={type="vendor", itemID=250622, costs={{currency="3000", currencytype=1220},{currency="50", currencytype=1508}}}, requirements={achievement={id=42675}}},
      {decorID=7686, source={type="vendor", itemID=250689, costs={{currency="6000", currencytype=1220},{currency="50", currencytype=1508}}}, requirements={achievement={id=61054}}},
      {decorID=7687, source={type="vendor", itemID=250690, costs={{currency="3000", currencytype=1220},{currency="50", currencytype=1508}}}, requirements={achievement={id=42627}}},
      {decorID=7690, source={type="vendor", itemID=250693, costs={{currency="18000", currencytype=1220},{currency="50", currencytype=1508}}}, requirements={achievement={id=42674}}},
      {decorID=8810, source={type="vendor", itemID=251778, costs={{currency="18000", currencytype=1220},{currency="50", currencytype=1508}}}, requirements={achievement={id=61218}}},
      {decorID=8811, source={type="vendor", itemID=251779, costs={{currency="18000", currencytype=1220},{currency="50", currencytype=1508}}}, requirements={achievement={id=42689}}},
      {decorID=9165, source={type="vendor", itemID=252753, costs={{currency="3000", currencytype=1220},{currency="50", currencytype=1508}}}, requirements={achievement={id=42655}}},
      {decorID=11278, source={type="vendor", itemID=256677, costs={{currency="3000", currencytype=1220},{currency="50", currencytype=1508}}}, requirements={achievement={id=42628}}},
      {decorID=11279, source={type="vendor", itemID=256678, costs={{currency="1500", currencytype=1220},{currency="50", currencytype=1508}}}},
      {decorID=11942, source={type="vendor", itemID=258299, costs={{currency="12000", currencytype=1220},{currency="50", currencytype=1508}}}, requirements={achievement={id=42547}}},
    }
  },

  {
    source={
      id=105986,
      type="vendor",
      faction="Neutral",
      zone="The Hall of Shadows",
      worldmap="626:2692:3683"
    },
    items={
      {decorID=7815, source={type="vendor", itemID=250783, currency="500", currencytype=1220}},
      {decorID=7816, source={type="vendor", itemID=250784, currency="500", currencytype=1220}},
      {decorID=7817, source={type="vendor", itemID=250785, currency="1000", currencytype=1220}},
      {decorID=7818, source={type="vendor", itemID=250786, currency="2000", currencytype=1220}, requirements={achievement={id=60989}}},
    }
  },

  {
    source={
      id=106901,
      type="vendor",
      faction="Horde",
      zone="Val'sharah",
      worldmap="641:5470:7325"
    },
    items={
      {decorID=675, source={type="vendor", itemID=238859, costs={{currency="800", currencytype="gold"},{currency="2000", currencytype=1220}}}, requirements={rep="true"}},
      {decorID=677, source={type="vendor", itemID=238861, costs={{currency="400", currencytype="gold"},{currency="750", currencytype=1220}}}, requirements={rep="true"}},
      {decorID=1695, source={type="vendor", itemID=245261, costs={{currency="500", currencytype="gold"},{currency="1000", currencytype=1220}}}, requirements={rep="true"}},
      {decorID=8195, source={type="vendor", itemID=251494, currency="200", currencytype=1220}, requirements={rep="true"}},
      {decorID=15453, source={type="vendor", itemID=264168, costs={{currency="400", currencytype="gold"},{currency="750", currencytype=1220}}}, requirements={rep="true"}},
    }
  },

  {
    source={
      id=106902,
      type="vendor",
      faction="Neutral",
      zone="Highmountain",
      worldmap="650:4588:6049"
    },
    items={
      {decorID=1231, source={type="vendor", itemID=245452, costs={{currency="400", currencytype="gold"},{currency="750", currencytype=1220}}}, requirements={rep="true"}},
      {decorID=1252, source={type="vendor", itemID=243290, costs={{currency="800", currencytype="gold"},{currency="2000", currencytype=1220}}}, requirements={rep="true"}},
      {decorID=1292, source={type="vendor", itemID=243359, costs={{currency="560", currencytype="gold"},{currency="1000", currencytype=1220}}}, requirements={rep="true"}},
      {decorID=1293, source={type="vendor", itemID=245454, costs={{currency="240", currencytype="gold"},{currency="500", currencytype=1220}}}, requirements={rep="true"}},
      {decorID=1295, source={type="vendor", itemID=245458, costs={{currency="240", currencytype="gold"},{currency="500", currencytype=1220}}}, requirements={rep="true"}},
      {decorID=1297, source={type="vendor", itemID=245450, costs={{currency="800", currencytype="gold"},{currency="2000", currencytype=1220}}}, requirements={rep="true"}},
      {decorID=1703, source={type="vendor", itemID=245270, costs={{currency="560", currencytype="gold"},{currency="1000", currencytype=1220}}}, requirements={rep="true"}},
      {decorID=5136, source={type="vendor", itemID=248985, costs={{currency="400", currencytype="gold"},{currency="750", currencytype=1220}}}, requirements={rep="true"}},
    }
  },

  {
    source={
      id=108017,
      type="vendor",
      faction="Neutral",
      zone="Thunder Totem, Highmountain",
      worldmap="652:5470:7740"
    },
    items={
      {decorID=1235, source={type="vendor", itemID=245453, costs={{currency="300", currencytype="gold"},{currency="500", currencytype=1220}}}, requirements={quest={id=42590}}},
      {decorID=1251, source={type="vendor", itemID=245405, costs={{currency="300", currencytype="gold"},{currency="500", currencytype=1220}}}, requirements={quest={id=42622}}},
      {decorID=1287, source={type="vendor", itemID=245456, costs={{currency="500", currencytype="gold"},{currency="750", currencytype=1220}}}, requirements={quest={id=39579}}},
      {decorID=1291, source={type="vendor", itemID=245461, costs={{currency="700", currencytype="gold"},{currency="1000", currencytype=1220}}}, requirements={quest={id=39780}}},
      {decorID=1294, source={type="vendor", itemID=245457, costs={{currency="300", currencytype="gold"},{currency="500", currencytype=1220}}}, requirements={quest={id=39614}}},
      {decorID=1307, source={type="vendor", itemID=245460, costs={{currency="500", currencytype="gold"},{currency="750", currencytype=1220}}}, requirements={achievement={id=11257}}},
      {decorID=1309, source={type="vendor", itemID=245409, costs={{currency="300", currencytype="gold"},{currency="500", currencytype=1220}}}, requirements={quest={id=39496}}},
      {decorID=11315, source={type="vendor", itemID=256913, costs={{currency="300", currencytype="gold"},{currency="500", currencytype=1220}}}, requirements={achievement={id=10996}}},
      {decorID=11487, source={type="vendor", itemID=257397, costs={{currency="500", currencytype="gold"},{currency="750", currencytype=1220}}}, requirements={quest={id=39992}}},
      {decorID=11491, source={type="vendor", itemID=257401, costs={{currency="700", currencytype="gold"},{currency="1000", currencytype=1220}}}, requirements={quest={id=39387}}},
      {decorID=11751, source={type="vendor", itemID=257721, costs={{currency="300", currencytype="gold"},{currency="500", currencytype=1220}}}, requirements={achievement={id=10398}}},
      {decorID=11752, source={type="vendor", itemID=257722, costs={{currency="300", currencytype="gold"},{currency="500", currencytype=1220}}}, requirements={quest={id=39426}}},
      {decorID=11753, source={type="vendor", itemID=257723, costs={{currency="500", currencytype="gold"},{currency="750", currencytype=1220}}}, requirements={quest={id=39305}}},
      {decorID=14379, source={type="vendor", itemID=260698, costs={{currency="100", currencytype="gold"},{currency="200", currencytype=1220}}}, requirements={quest={id=39772}}},
      {decorID=15741, source={type="vendor", itemID=264477, currency="8", currencytype="gold"}, requirements={quest={id=39487}}},
    }
  },

  {
    source={
      id=108537,
      type="vendor",
      faction="Neutral",
      zone="Highmountain",
      worldmap="650:4162:1044"
    },
    items={
      {decorID=11905, source={type="vendor", itemID=258219, currency="175", currencytype=1220}},
      {decorID=11907, source={type="vendor", itemID=258221, currency="450", currencytype=1220}, requirements={quest={id=40230}}},
      {decorID=11909, source={type="vendor", itemID=258223, currency="400", currencytype=1220}, requirements={achievement={id=11699}}},
    }
  },

  {
    source={
      id=109306,
      type="vendor",
      faction="Neutral",
      zone="Val'sharah",
      worldmap="641:6020:8486"
    },
    items={
      {decorID=1692, source={type="vendor", itemID=245258}, requirements={quest={id=42751}}},
      {decorID=1882, source={type="vendor", itemID=245698}, requirements={quest={id=40573}}},
      {decorID=1883, source={type="vendor", itemID=245699}, requirements={quest={id=40573}}},
    }
  },

  {
    source={
      id=112318,
      type="vendor",
      faction="Alliance",
      zone="The Maelstrom",
      worldmap="726:3032:6069"
    },
    items={
      {decorID=7839, source={type="vendor", itemID=250916, currency="500", currencytype=1220}},
      {decorID=7841, source={type="vendor", itemID=250918, currency="1000", currencytype=1220}},
      {decorID=7874, source={type="vendor", itemID=251014, currency="2000", currencytype=1220}, requirements={achievement={id=60990}}},
      {decorID=7875, source={type="vendor", itemID=251015, currency="500", currencytype=1220}},
    }
  },

  {
    source={
      id=112323,
      type="vendor",
      faction="Neutral",
      zone="The Dreamgrove",
      worldmap="747:4002:1772"
    },
    items={
      {decorID=1741, source={type="vendor", itemID=245550, currency="500", currencytype=1220}},
      {decorID=2086, source={type="vendor", itemID=246216, currency="500", currencytype=1220}},
      {decorID=5897, source={type="vendor", itemID=250133, currency="1000", currencytype=1220}},
      {decorID=7873, source={type="vendor", itemID=251013, currency="2000", currencytype=1220}, requirements={achievement={id=60983}}},
    }
  },

  {
    source={
      id=112338,
      type="vendor",
      faction="Neutral",
      zone="Mandori Village",
      worldmap="709:5033:5913"
    },
    items={
      {decorID=5112, source={type="vendor", itemID=248935, currency="500", currencytype=1220}},
      {decorID=5113, source={type="vendor", itemID=248936, currency="500", currencytype=1220}},
      {decorID=5119, source={type="vendor", itemID=248942, currency="2000", currencytype=1220}, requirements={achievement={id=60986}}},
    }
  },

  {
    source={
      id=112392,
      type="vendor",
      faction="Horde",
      zone="Skyhold",
      worldmap="695:5549:2591"
    },
    items={
      {decorID=5528, source={type="vendor", itemID=249460, currency="500", currencytype=1220}},
      {decorID=5529, source={type="vendor", itemID=249461, currency="2000", currencytype=1220}, requirements={achievement={id=60992}}},
      {decorID=5532, source={type="vendor", itemID=249464, currency="1000", currencytype=1220}},
      {decorID=5562, source={type="vendor", itemID=249551, currency="500", currencytype=1220}},
    }
  },

  {
    source={
      id=112401,
      type="vendor",
      faction="Horde",
      zone="Netherlight Temple",
      worldmap="702:3862:2377"
    },
    items={
      {decorID=7606, source={type="vendor", itemID=250302, currency="500", currencytype=1220}},
      {decorID=7607, source={type="vendor", itemID=250303, currency="500", currencytype=1220}},
      {decorID=7608, source={type="vendor", itemID=250304, currency="500", currencytype=1220}},
      {decorID=7821, source={type="vendor", itemID=250789, currency="1000", currencytype=1220}},
      {decorID=8768, source={type="vendor", itemID=251636, currency="2000", currencytype=1220}, requirements={achievement={id=60988}}},
    }
  },

  {
    source={
      id=112407,
      type="vendor",
      faction="Neutral",
      zone="The Fel Hammer",
      worldmap="720:6100:5673"
    },
    items={
      {decorID=5530, source={type="vendor", itemID=249462, currency="1000", currencytype=1220}},
      {decorID=5531, source={type="vendor", itemID=249463, currency="500", currencytype=1220}},
      {decorID=5555, source={type="vendor", itemID=249518, currency="2000", currencytype=1220}, requirements={achievement={id=60982}}},
      {decorID=11276, source={type="vendor", itemID=256675, currency="500", currencytype=1220}},
    }
  },

  {
    source={
      id=112434,
      type="vendor",
      faction="Alliance",
      zone="Dreadscar Rift",
      worldmap="717:5876:3269"
    },
    items={
      {decorID=5120, source={type="vendor", itemID=248943, currency="1000", currencytype=1220}},
      {decorID=5127, source={type="vendor", itemID=248959, currency="500", currencytype=1220}},
      {decorID=5292, source={type="vendor", itemID=249004, currency="500", currencytype=1220}},
      {decorID=15477, source={type="vendor", itemID=264242, currency="2000", currencytype=1220}, requirements={achievement={id=60991}}},
    }
  },

  {
    source={
      id=112440,
      type="vendor",
      faction="Neutral",
      zone="Hall of the Guardian",
      worldmap="735:4475:5787"
    },
    items={
      {decorID=5894, source={type="vendor", itemID=250130, currency="500", currencytype=1220}},
      {decorID=5895, source={type="vendor", itemID=250131, currency="1500", currencytype=1220}, requirements={achievement={id=60985}}},
      {decorID=5896, source={type="vendor", itemID=250132, currency="500", currencytype=1220}},
      {decorID=7579, source={type="vendor", itemID=250239, currency="1000", currencytype=1220}},
    }
  },

  {
    source={
      id=112634,
      type="vendor",
      faction="Alliance",
      zone="Val'sharah",
      worldmap="641:5714:7191"
    },
    items={
      {decorID=679, source={type="vendor", itemID=238863, currency="300", currencytype=1220}},
      {decorID=1694, source={type="vendor", itemID=245260, currency="400", currencytype=1220}},
    }
  },

  {
    source={
      id=112716,
      type="vendor",
      faction="Alliance",
      zone="Dalaran",
      worldmap="626:4340:4940"
    },
    items={
      {decorID=2517, source={type="vendor", itemID=246851, currency="15000", currencytype="gold"}},
    }
  },

  {
    source={
      id=115736,
      type="vendor",
      faction="Neutral",
      zone="Suramar",
      worldmap="680:3713:4655"
    },
    items={
      {decorID=1440, source={type="vendor", itemID=244536, costs={{currency="560", currencytype="gold"},{currency="1000", currencytype=1220}}}, requirements={rep="true"}},
      {decorID=2516, source={type="vendor", itemID=246850, costs={{currency="800", currencytype="gold"},{currency="2000", currencytype=1220}}}, requirements={rep="true"}},
      {decorID=3983, source={type="vendor", itemID=247844, costs={{currency="400", currencytype="gold"},{currency="750", currencytype=1220}}}, requirements={rep="true"}},
      {decorID=3984, source={type="vendor", itemID=247845, costs={{currency="400", currencytype="gold"},{currency="750", currencytype=1220}}}, requirements={rep="true"}},
      {decorID=3985, source={type="vendor", itemID=247847, costs={{currency="560", currencytype="gold"},{currency="1000", currencytype=1220}}}, requirements={rep="true"}},
      {decorID=4024, source={type="vendor", itemID=247910, costs={{currency="240", currencytype="gold"},{currency="500", currencytype=1220}}}, requirements={rep="true"}},
      {decorID=4035, source={type="vendor", itemID=247921, costs={{currency="240", currencytype="gold"},{currency="500", currencytype=1220}}}, requirements={rep="true"}},
      {decorID=4038, source={type="vendor", itemID=247924, costs={{currency="560", currencytype="gold"},{currency="1000", currencytype=1220}}}, requirements={rep="true"}},
    }
  },

  {
    source={
      id=248594,
      type="vendor",
      faction="Neutral",
      zone="Suramar",
      worldmap="680:5090:7778"
    },
    items={
      {decorID=1444, source={type="vendor", itemID=244654, currency="100", currencytype=1155}, requirements={rep="true"}},
      {decorID=1464, source={type="vendor", itemID=244676, currency="200", currencytype=1155}, requirements={rep="true"}},
      {decorID=1465, source={type="vendor", itemID=244677, currency="300", currencytype=1155}, requirements={rep="true"}},
      {decorID=1466, source={type="vendor", itemID=244678, currency="100", currencytype=1155}, requirements={rep="true"}},
      {decorID=1919, source={type="vendor", itemID=246001, currency="200", currencytype=1155}, requirements={rep="true"}},
      {decorID=1920, source={type="vendor", itemID=246002, currency="300", currencytype=1155}, requirements={rep="true"}},
    }
  },

  {
    source={
      id=251042,
      type="vendor",
      faction="Neutral",
      zone="Dalaran",
      worldmap="619:5506:7797"
    },
    items={
      {decorID=7610, source={type="vendor", itemID=250307, currency="10000", currencytype=3252}, requirements={achievement={id=42318}}},
      {decorID=7620, source={type="vendor", itemID=250402, currency="20000", currencytype=3252}, requirements={achievement={id=42658}}},
      {decorID=7621, source={type="vendor", itemID=250403, currency="30000", currencytype=3252}, requirements={achievement={id=42692}}},
      {decorID=7622, source={type="vendor", itemID=250404, currency="5000", currencytype=3252}},
      {decorID=7623, source={type="vendor", itemID=250405, currency="5000", currencytype=3252}, requirements={achievement={id=61060}}},
      {decorID=7624, source={type="vendor", itemID=250406, currency="30000", currencytype=3252}, requirements={achievement={id=42321}}},
      {decorID=7625, source={type="vendor", itemID=250407, currency="5000", currencytype=3252}, requirements={achievement={id=42619}}},
      {decorID=7658, source={type="vendor", itemID=250622, currency="5000", currencytype=3252}, requirements={achievement={id=42675}}},
      {decorID=7686, source={type="vendor", itemID=250689, currency="10000", currencytype=3252}, requirements={achievement={id=61054}}},
      {decorID=7687, source={type="vendor", itemID=250690, currency="5000", currencytype=3252}, requirements={achievement={id=42627}}},
      {decorID=7690, source={type="vendor", itemID=250693, currency="30000", currencytype=3252}, requirements={achievement={id=42674}}},
      {decorID=8810, source={type="vendor", itemID=251778, currency="30000", currencytype=3252}, requirements={achievement={id=61218}}},
      {decorID=8811, source={type="vendor", itemID=251779, currency="30000", currencytype=3252}, requirements={achievement={id=42689}}},
      {decorID=9165, source={type="vendor", itemID=252753, currency="5000", currencytype=3252}, requirements={achievement={id=42655}}},
      {decorID=11278, source={type="vendor", itemID=256677, currency="5000", currencytype=3252}, requirements={achievement={id=42628}}},
      {decorID=11279, source={type="vendor", itemID=256678, currency="2500", currencytype=3252}},
      {decorID=11942, source={type="vendor", itemID=258299, currency="20000", currencytype=3252}, requirements={achievement={id=42547}}},
    }
  },

  {
    source={
      id=252043,
      type="vendor",
      faction="Alliance",
      zone="Dalaran",
      worldmap="627:6746:3389"
    },
    items={
      {decorID=947, source={type="vendor", itemID=245411, currency="2000", currencytype="gold"}, requirements={quest={id=38882}}},
      {decorID=9267, source={type="vendor", itemID=253251, currency="200", currencytype="gold"}, requirements={quest={id=39801}}},
    }
  },

  {
    source={
      id=252498,
      type="vendor",
      faction="Horde",
      zone="Val'sharah",
      worldmap="641:4209:5938"
    },
    items={
      {decorID=1801, source={type="vendor", itemID=245615, currency="350", currencytype=1220}, requirements={quest={id=39117}}},
      {decorID=1802, source={type="vendor", itemID=245616, currency="1000", currencytype=1220}, requirements={quest={id=46107}}},
    }
  },

  {
    source={
      id=252969,
      type="vendor",
      faction="Neutral",
      zone="Suramar",
      worldmap="680:4963:6283"
    },
    items={
      {decorID=752, source={type="vendor", itemID=245448, costs={{currency="1000", currencytype="gold"},{currency="2000", currencytype=1220}}}, requirements={achievement={id=11124}}},
      {decorID=1747, source={type="vendor", itemID=245558, currency="225", currencytype=1220}, requirements={quest={id=44955}}},
      {decorID=3981, source={type="vendor", itemID=247842, currency="600", currencytype=1220}, requirements={quest={id=44756}}},
      {decorID=3982, source={type="vendor", itemID=247843, currency="1200", currencytype=1220}, requirements={achievement={id=11340}}},
      {decorID=4025, source={type="vendor", itemID=247911, currency="100", currencytype=1220}, requirements={quest={id=43318}}},
      {decorID=4028, source={type="vendor", itemID=247914, currency="400", currencytype=1220}, requirements={quest={id=44052}}},
      {decorID=4031, source={type="vendor", itemID=247917, currency="200", currencytype=1220}, requirements={quest={id=41915}}},
      {decorID=4040, source={type="vendor", itemID=248009, currency="175", currencytype=1220}, requirements={quest={id=42489}}},
    }
  },

  {
    source={
      id=253387,
      type="vendor",
      faction="Neutral",
      zone="Val'sharah",
      worldmap="641:5426:7236"
    },
    items={
      {decorID=675, source={type="vendor", itemID=238859, costs={{currency="1000", currencytype="gold"},{currency="2000", currencytype=1220}}}, requirements={rep="true"}},
      {decorID=676, source={type="vendor", itemID=238860, currency="700", currencytype=1220}},
      {decorID=677, source={type="vendor", itemID=238861, costs={{currency="500", currencytype="gold"},{currency="750", currencytype=1220}}}, requirements={rep="true"}},
      {decorID=1695, source={type="vendor", itemID=245261, costs={{currency="700", currencytype="gold"},{currency="1000", currencytype=1220}}}, requirements={rep="true"}},
      {decorID=1881, source={type="vendor", itemID=245697, currency="600", currencytype=1220}, requirements={achievement={id=10698}}},
      {decorID=1884, source={type="vendor", itemID=245700, currency="250", currencytype=1220}, requirements={quest={id=38663}}},
      {decorID=1886, source={type="vendor", itemID=245702, currency="75", currencytype=1220}, requirements={quest={id=38147}}},
      {decorID=1887, source={type="vendor", itemID=245703, currency="750", currencytype=1220}, requirements={achievement={id=11258}}},
      {decorID=1889, source={type="vendor", itemID=245739, currency="300", currencytype=1220}, requirements={quest={id=40890}}},
      {decorID=8195, source={type="vendor", itemID=251494, currency="200", currencytype=1220}, requirements={rep="true"}},
      {decorID=15453, source={type="vendor", itemID=264168, costs={{currency="500", currencytype="gold"},{currency="750", currencytype=1220}}}, requirements={rep="true"}},
    }
  },

  {
    source={
      id=253434,
      type="vendor",
      faction="Neutral",
      zone="Suramar",
      worldmap="641:7992:7389"
    },
    items={
      {decorID=1885, source={type="vendor", itemID=245701, currency="175", currencytype=1220}, requirements={quest={id=40321}}},
    }
  },

  {
    source={
      id=255101,
      type="vendor",
      faction="Neutral",
      zone="Suramar",
      worldmap="680:4558:6915"
    },
    items={
      {decorID=11483, source={type="vendor", itemID=257393, currency="50", currencytype=1155}},
      {decorID=11708, source={type="vendor", itemID=257598, currency="125", currencytype=1155}},
    }
  },

  {
    source={
      id=256826,
      type="vendor",
      faction="Neutral",
      zone="Suramar",
      worldmap="680:1511:5333"
    },
    items={
      {decorID=11908, source={type="vendor", itemID=258222, currency="600", currencytype=1220}, requirements={quest={id=41143}}},
    }
  },

}
