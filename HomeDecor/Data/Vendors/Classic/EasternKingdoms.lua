local ADDON, NS = ...

NS.Data = NS.Data or {}
NS.Data.Vendors = NS.Data.Vendors or {}

NS.Data.Vendors["Classic"] = NS.Data.Vendors["Classic"] or {}

NS.Data.Vendors["Classic"]["EasternKingdoms"] = {

  {
    source={
      id=1247,
      type="vendor",
      faction="Alliance",
      zone="Dun Morogh",
      worldmap="469:9392:7091"
    },
    items={
      {decorID=11130, source={type="vendor", itemID=256330, currency="190", currencytype="gold"}},
    }
  },

  {
    source={
      id=2140,
      type="vendor",
      faction="Horde",
      zone="Silverpine Forest",
      worldmap="21:4406:3968"
    },
    items={
      {decorID=11498, source={type="vendor", itemID=257412, costs={{currency="142", currencytype="gold"},{currency="50", currencytype="silver"}}}, requirements={quest={id=27550}}},
    }
  },

  {
    source={
      id=13217,
      type="vendor",
      faction="Alliance",
      zone="Hillsbrad Foothills",
      worldmap="25:4480:4640"
    },
    items={
      {decorID=2241, source={type="vendor", itemID=246424}},
    }
  },

  {
    source={
      id=14624,
      type="vendor",
      faction="Horde",
      zone="Searing Gorge",
      worldmap="32:3860:2870"
    },
    items={
      {decorID=1315, source={type="vendor", itemID=245333, currency="150", currencytype="gold"}, requirements={quest={id=28035}}},
      {decorID=2226, source={type="vendor", itemID=246409, currency="700", currencytype="gold"}, requirements={quest={id=28064}}},
    }
  },

  {
    source={
      id=44114,
      type="vendor",
      faction="Alliance",
      zone="Duskwood",
      worldmap="47:2027:5835"
    },
    items={
      {decorID=1833, source={type="vendor", itemID=245624, currency="150", currencytype="gold"}, requirements={quest={id=26760}}},
      {decorID=11305, source={type="vendor", itemID=256905, currency="175", currencytype="gold"}, requirements={quest={id=26754}}},
    }
  },

  {
    source={
      id=44337,
      type="vendor",
      faction="Alliance",
      zone="Surwich, Blasted Lands",
      worldmap="17:4580:8860"
    },
    items={
      {decorID=1481, source={type="vendor", itemID=244777, currency="1100", currencytype="gold"}},
    }
  },

  {
    source={
      id=45417,
      type="vendor",
      faction="Neutral",
      zone="Light's Hope Chapel",
      worldmap="23:7380:5220"
    },
    items={
      {decorID=4813, source={type="vendor", itemID=248796, currency="3000", currencytype="gold"}, requirements={achievement={id=5442}}},
    }
  },

  {
    source={
      id=49386,
      type="vendor",
      faction="Neutral",
      zone="Twilight Highlands",
      worldmap="241:4861:3068"
    },
    items={
      {decorID=1998, source={type="vendor", itemID=246108, currency="2000", currencytype="gold"}, requirements={rep="true"}},
      {decorID=2242, source={type="vendor", itemID=246425, currency="400", currencytype="gold"}, requirements={rep="true"}},
    }
  },

  {
    source={
      id=49877,
      type="vendor",
      faction="Alliance",
      zone="Stormwind City",
      worldmap="84:6775:7306"
    },
    items={
      {decorID=4402, source={type="vendor", itemID=248333, currency="95", currencytype="gold"}, requirements={rep="true"}},
      {decorID=4405, source={type="vendor", itemID=248336, currency="285", currencytype="gold"}, requirements={quest={id=59583}}},
      {decorID=4443, source={type="vendor", itemID=248617, costs={{currency="142", currencytype="gold"},{currency="50", currencytype="silver"}}}, requirements={rep="true"}},
      {decorID=4444, source={type="vendor", itemID=248618, currency="190", currencytype="gold"}, requirements={quest={id=26270}}},
      {decorID=4445, source={type="vendor", itemID=248619, costs={{currency="237", currencytype="gold"},{currency="50", currencytype="silver"}}}, requirements={rep="true"}},
      {decorID=4446, source={type="vendor", itemID=248620, costs={{currency="142", currencytype="gold"},{currency="50", currencytype="silver"}}}, requirements={rep="true"}},
      {decorID=4447, source={type="vendor", itemID=248621, currency="285", currencytype="gold"}, requirements={quest={id=26390}}},
      {decorID=4487, source={type="vendor", itemID=248662, currency="475", currencytype="gold"}, requirements={quest={id=543}}},
      {decorID=4490, source={type="vendor", itemID=248665, costs={{currency="237", currencytype="gold"},{currency="50", currencytype="silver"}}}, requirements={rep="true"}},
      {decorID=4811, source={type="vendor", itemID=248794, costs={{currency="47", currencytype="gold"},{currency="50", currencytype="silver"}}}, requirements={rep="true"}},
      {decorID=4812, source={type="vendor", itemID=248795, costs={{currency="71", currencytype="gold"},{currency="25", currencytype="silver"}}}, requirements={rep="true"}},
      {decorID=4814, source={type="vendor", itemID=248797, costs={{currency="47", currencytype="gold"},{currency="50", currencytype="silver"}}}, requirements={quest={id=26229}}},
      {decorID=4815, source={type="vendor", itemID=248798, currency="190", currencytype="gold"}, requirements={quest={id=54}}},
      {decorID=4819, source={type="vendor", itemID=248801, currency="95", currencytype="gold"}, requirements={quest={id=26297}}},
      {decorID=5115, source={type="vendor", itemID=248938, costs={{currency="142", currencytype="gold"},{currency="50", currencytype="silver"}}}, requirements={quest={id=60}}},
      {decorID=5116, source={type="vendor", itemID=248939, currency="95", currencytype="gold"}, requirements={rep="true"}},
      {decorID=9242, source={type="vendor", itemID=253168, currency="95", currencytype="silver"}},
      {decorID=11274, source={type="vendor", itemID=256673, currency="950", currencytype="gold"}, requirements={quest={id=7604}}},
    }
  },

  {
    source={
      id=50304,
      type="vendor",
      faction="Horde",
      zone="Undercity, Orgrimmar",
      worldmap="90:6320:4900"
    },
    items={
      {decorID=923, source={type="vendor", itemID=245504, costs={{currency="127", currencytype="gold"},{currency="50", currencytype="silver"}}}, requirements={quest={id=27098}}},
      {decorID=924, source={type="vendor", itemID=245505, currency="85", currencytype="gold"}, requirements={quest={id=27098}}},
    }
  },

  {
    source={
      id=50309,
      type="vendor",
      faction="Alliance",
      zone="Ironforge",
      worldmap="87:5560:4820"
    },
    items={
      {decorID=2243, source={type="vendor", itemID=246426, currency="570", currencytype="gold"}, requirements={rep="true"}},
      {decorID=2333, source={type="vendor", itemID=246490, costs={{currency="237", currencytype="gold"},{currency="50", currencytype="silver"}}}, requirements={rep="true"}},
      {decorID=2334, source={type="vendor", itemID=246491, costs={{currency="142", currencytype="gold"},{currency="50", currencytype="silver"}}}, requirements={rep="true"}},
      {decorID=8982, source={type="vendor", itemID=252010, costs={{currency="427", currencytype="gold"},{currency="50", currencytype="silver"}}}, requirements={rep="true"}},
      {decorID=11133, source={type="vendor", itemID=256333, currency="950", currencytype="gold"}, requirements={rep="true"}},
    }
  },

  {
    source={
      id=100196,
      type="vendor",
      faction="Neutral",
      zone="Sanctum of Light",
      worldmap="23:7564:4909"
    },
    items={
      {decorID=7572, source={type="vendor", itemID=250231, currency="500", currencytype=1220}},
      {decorID=7573, source={type="vendor", itemID=250232, currency="500", currencytype=1220}},
      {decorID=7576, source={type="vendor", itemID=250235, currency="1000", currencytype=1220}},
      {decorID=7577, source={type="vendor", itemID=250236, currency="2000", currencytype=1220}, requirements={achievement={id=60987}}},
    }
  },

  {
    source={
      id=115805,
      type="vendor",
      faction="Horde",
      zone="Burning Steppes",
      worldmap="36:4680:4460"
    },
    items={
      {decorID=11131, source={type="vendor", itemID=256331, currency="450", currencytype="gold"}},
    }
  },

  {
    source={
      id=142115,
      type="vendor",
      faction="Alliance",
      zone="Boralus Harbor",
      worldmap="23:7380:5220"
    },
    items={
      {decorID=4813, source={type="vendor", itemID=248796, currency="3000", currencytype="gold"}, requirements={achievement={id=5442}}},
    }
  },

  {
    source={
      id=211065,
      type="vendor",
      faction="Alliance",
      zone="Stormglen Village, Gilneas",
      worldmap="217:6040:9240"
    },
    items={
      {decorID=857, source={type="vendor", itemID=245520, currency="150", currencytype="gold"}, requirements={achievement={id=19719}}},
      {decorID=859, source={type="vendor", itemID=245516, currency="75", currencytype="gold"}},
      {decorID=860, source={type="vendor", itemID=245515, currency="75", currencytype="gold"}},
      {decorID=1795, source={type="vendor", itemID=245604, currency="100", currencytype="gold"}},
      {decorID=1826, source={type="vendor", itemID=245617, currency="100", currencytype="gold"}},
      {decorID=11944, source={type="vendor", itemID=258301, currency="125", currencytype="gold"}},
    }
  },

  {
    source={
      id=249196,
      type="vendor",
      faction="Neutral",
      zone="Twilight Highlands",
      worldmap="241:4960:8120"
    },
    items={
      {decorID=714, source={type="vendor", itemID=245284, currency="50", currencytype=3319}},
      {decorID=1227, source={type="vendor", itemID=251997, currency="75", currencytype=3319}},
      {decorID=1236, source={type="vendor", itemID=245330, currency="50", currencytype=3319}},
    }
  },

  {
    source={
      id=253227,
      type="vendor",
      faction="Neutral",
      zone="Twilight Highlands",
      worldmap="241:4974:2957"
    },
    items={
      {decorID=1998, source={type="vendor", itemID=246108, currency="2000", currencytype="gold"}, requirements={rep="true"}},
      {decorID=2242, source={type="vendor", itemID=246425, currency="400", currencytype="gold"}, requirements={rep="true"}},
      {decorID=2244, source={type="vendor", itemID=246427, currency="1000", currencytype="gold"}, requirements={quest={id=28244}}},
      {decorID=2245, source={type="vendor", itemID=246428, currency="1500", currencytype="gold"}, requirements={quest={id=28655}}},
    }
  },

  {
    source={
      id=253232,
      type="vendor",
      faction="Alliance",
      zone="The Library, Ironforge",
      worldmap="87:7580:940"
    },
    items={
      {decorID=2228, source={type="vendor", itemID=246411, currency="700", currencytype="gold"}},
      {decorID=2229, source={type="vendor", itemID=246412, currency="450", currencytype="gold"}},
    }
  },

  {
    source={
      id=253235,
      type="vendor",
      faction="Alliance",
      zone="Dun Morogh",
      worldmap="87:2472:4393"
    },
    items={
      {decorID=1118, source={type="vendor", itemID=245427, currency="1200", currencytype="gold"}, requirements={quest={id=53566}}},
      {decorID=1216, source={type="vendor", itemID=245426, currency="700", currencytype="gold"}, requirements={achievement={id=4859}}},
      {decorID=2243, source={type="vendor", itemID=246426, currency="600", currencytype="gold"}, requirements={rep="true"}},
      {decorID=2333, source={type="vendor", itemID=246490, currency="250", currencytype="gold"}, requirements={rep="true"}},
      {decorID=2334, source={type="vendor", itemID=246491, currency="150", currencytype="gold"}, requirements={rep="true"}},
      {decorID=8982, source={type="vendor", itemID=252010, currency="450", currencytype="gold"}, requirements={rep="true"}},
      {decorID=11133, source={type="vendor", itemID=256333, currency="1000", currencytype="gold"}, requirements={rep="true"}},
      {decorID=11160, source={type="vendor", itemID=256425, currency="350", currencytype="gold"}, requirements={achievement={id=8316}}},
    }
  },

  {
    source={
      id=254603,
      type="vendor",
      faction="Alliance",
      zone="Stormwind City",
      worldmap="84:7780:6580"
    },
    items={
      {decorID=3880, source={type="vendor", itemID=247740, currency="2000", currencytype=1792}, requirements={achievement={id=6981}}},
      {decorID=3881, source={type="vendor", itemID=247741, currency="1000", currencytype=1792}, requirements={achievement={id=6981}}},
      {decorID=3884, source={type="vendor", itemID=247744, currency="1000", currencytype=1792}, requirements={achievement={id=231}}},
      {decorID=3886, source={type="vendor", itemID=247746, currency="800", currencytype=1792}, requirements={achievement={id=200}}},
      {decorID=3890, source={type="vendor", itemID=247750, currency="2500", currencytype=1792}, requirements={achievement={id=40612}}},
      {decorID=3893, source={type="vendor", itemID=247756, currency="1000", currencytype=1792}, requirements={achievement={id=1157}}},
      {decorID=3894, source={type="vendor", itemID=247757, currency="600", currencytype=1792}, requirements={achievement={id=158}}},
      {decorID=3895, source={type="vendor", itemID=247758, currency="1200", currencytype=1792}, requirements={achievement={id=221}}},
      {decorID=3898, source={type="vendor", itemID=247761, currency="400", currencytype=1792}, requirements={achievement={id=212}}},
      {decorID=3899, source={type="vendor", itemID=247762, currency="300", currencytype=1792}, requirements={achievement={id=213}}},
      {decorID=3900, source={type="vendor", itemID=247763}, requirements={achievement={id=61683}}},
      {decorID=3902, source={type="vendor", itemID=247765}, requirements={achievement={id=61687}}},
      {decorID=3903, source={type="vendor", itemID=247766}, requirements={achievement={id=61688}}},
      {decorID=3905, source={type="vendor", itemID=247768}, requirements={achievement={id=61684}}},
      {decorID=3906, source={type="vendor", itemID=247769}, requirements={achievement={id=61685}}},
      {decorID=3907, source={type="vendor", itemID=247770}, requirements={achievement={id=61686}}},
      {decorID=9244, source={type="vendor", itemID=253170, currency="750", currencytype=1792}, requirements={achievement={id=40210}}},
      {decorID=11296, source={type="vendor", itemID=256896, currency="450", currencytype=1792}, requirements={achievement={id=5245}}},
    }
  },

  {
    source={
      id=255203,
      type="vendor",
      faction="Alliance",
      zone="Founder's Point",
      worldmap="2352:5195:3831"
    },
    items={
      {decorID=373, source={type="vendor", itemID=245375, currency="100", currencytype="gold"}, requirements={quest={id=92437}}},
      {decorID=374, source={type="vendor", itemID=245384, currency="50", currencytype="gold"}, requirements={quest={id=92961}}},
      {decorID=377, source={type="vendor", itemID=235675, currency="50", currencytype="gold"}, requirements={quest={id=92988}}},
      {decorID=378, source={type="vendor", itemID=245355, currency="50", currencytype="gold"}, requirements={quest={id=92962}}},
      {decorID=379, source={type="vendor", itemID=245358, currency="10", currencytype="gold"}},
      {decorID=383, source={type="vendor", itemID=235677, currency="50", currencytype="gold"}, requirements={quest={id=92987}}},
      {decorID=388, source={type="vendor", itemID=245383, currency="150", currencytype="gold"}},
      {decorID=389, source={type="vendor", itemID=245356, currency="50", currencytype="gold"}, requirements={quest={id=92963}}},
      {decorID=390, source={type="vendor", itemID=245376, currency="125", currencytype="gold"}, requirements={quest={id=92964}}},
      {decorID=478, source={type="vendor", itemID=245354, currency="25", currencytype="gold"}},
      {decorID=483, source={type="vendor", itemID=245352, currency="50", currencytype="gold"}},
      {decorID=484, source={type="vendor", itemID=245353, currency="75", currencytype="gold"}},
      {decorID=495, source={type="vendor", itemID=245336, currency="100", currencytype="gold"}, requirements={quest={id=92984}}},
      {decorID=498, source={type="vendor", itemID=235633, currency="50", currencytype="gold"}},
      {decorID=527, source={type="vendor", itemID=236675, currency="50", currencytype="gold"}},
      {decorID=528, source={type="vendor", itemID=236676, currency="75", currencytype="gold"}, requirements={quest={id=92966}}},
      {decorID=529, source={type="vendor", itemID=236677, currency="100", currencytype="gold"}, requirements={quest={id=92968}}},
      {decorID=530, source={type="vendor", itemID=236678, currency="100", currencytype="gold"}, requirements={quest={id=92967}}},
      {decorID=533, source={type="vendor", itemID=245392, currency="50", currencytype="gold"}},
      {decorID=534, source={type="vendor", itemID=245393, currency="100", currencytype="gold"}},
      {decorID=535, source={type="vendor", itemID=245394, currency="100", currencytype="gold"}},
      {decorID=536, source={type="vendor", itemID=245395, currency="75", currencytype="gold"}},
      {decorID=726, source={type="vendor", itemID=239075, currency="50", currencytype="gold"}, requirements={quest={id=92986}}},
      {decorID=1044, source={type="vendor", itemID=242255, currency="75", currencytype="gold"}},
      {decorID=1083, source={type="vendor", itemID=245370, currency="125", currencytype="gold"}, requirements={quest={id=93119}}},
      {decorID=1123, source={type="vendor", itemID=245334, currency="10", currencytype="gold"}, requirements={quest={id=92979}}},
      {decorID=1244, source={type="vendor", itemID=245335, currency="10", currencytype="gold"}},
      {decorID=1434, source={type="vendor", itemID=244530, currency="75", currencytype="gold"}},
      {decorID=1435, source={type="vendor", itemID=244531, currency="100", currencytype="gold"}, requirements={quest={id=92982}}},
      {decorID=1454, source={type="vendor", itemID=244664, currency="50", currencytype="gold"}},
      {decorID=1455, source={type="vendor", itemID=244665, currency="50", currencytype="gold"}},
      {decorID=1456, source={type="vendor", itemID=244666, currency="50", currencytype="gold"}},
      {decorID=1701, source={type="vendor", itemID=245267, currency="10", currencytype="gold"}},
      {decorID=1702, source={type="vendor", itemID=245268, currency="10", currencytype="gold"}},
      {decorID=1738, source={type="vendor", itemID=245547, currency="100", currencytype="gold"}, requirements={quest={id=92981}}},
      {decorID=1739, source={type="vendor", itemID=245548, currency="100", currencytype="gold"}, requirements={quest={id=92977}}},
      {decorID=1745, source={type="vendor", itemID=245556, currency="100", currencytype="gold"}, requirements={quest={id=92980}}},
      {decorID=1991, source={type="vendor", itemID=246101, currency="10", currencytype="gold"}, requirements={quest={id=92973}}},
      {decorID=1993, source={type="vendor", itemID=246103, currency="25", currencytype="gold"}, requirements={quest={id=92972}}},
      {decorID=1996, source={type="vendor", itemID=246106, currency="10", currencytype="gold"}, requirements={quest={id=92985}}},
      {decorID=2099, source={type="vendor", itemID=246243, currency="50", currencytype="gold"}, requirements={quest={id=92976}}},
      {decorID=2100, source={type="vendor", itemID=246245, currency="100", currencytype="gold"}, requirements={quest={id=92975}}},
      {decorID=2101, source={type="vendor", itemID=246246, currency="125", currencytype="gold"}, requirements={quest={id=92974}}},
      {decorID=2102, source={type="vendor", itemID=246247, currency="75", currencytype="gold"}},
      {decorID=2103, source={type="vendor", itemID=246248, currency="50", currencytype="gold"}},
      {decorID=2342, source={type="vendor", itemID=246502, currency="100", currencytype="gold"}, requirements={quest={id=92996}}},
      {decorID=9064, source={type="vendor", itemID=252417, currency="50", currencytype="gold"}},
      {decorID=9144, source={type="vendor", itemID=252659, currency="75", currencytype="gold"}},
      {decorID=9471, source={type="vendor", itemID=253589, currency="75", currencytype="gold"}, requirements={quest={id=92989}}},
      {decorID=9473, source={type="vendor", itemID=253592, currency="75", currencytype="gold"}},
      {decorID=9474, source={type="vendor", itemID=253593, currency="125", currencytype="gold"}},
      {decorID=12199, source={type="vendor", itemID=258670, currency="75", currencytype="gold"}},
    }
  },

  {
    source={
      id=255213,
      type="vendor",
      faction="Alliance",
      zone="Founder's Point",
      worldmap="2352:5200:3840"
    },
    items={
      {decorID=479, source={type="vendor", itemID=245365, currency="125", currencytype="gold"}},
      {decorID=480, source={type="vendor", itemID=245366, currency="150", currencytype="gold"}},
      {decorID=481, source={type="vendor", itemID=245368, currency="150", currencytype="gold"}},
      {decorID=482, source={type="vendor", itemID=245357, currency="150", currencytype="gold"}},
      {decorID=485, source={type="vendor", itemID=245377, currency="75", currencytype="gold"}},
      {decorID=486, source={type="vendor", itemID=245378, currency="125", currencytype="gold"}},
      {decorID=487, source={type="vendor", itemID=245360, currency="75", currencytype="gold"}},
      {decorID=488, source={type="vendor", itemID=245359, currency="150", currencytype="gold"}},
      {decorID=489, source={type="vendor", itemID=245379, currency="125", currencytype="gold"}},
      {decorID=490, source={type="vendor", itemID=245380, currency="125", currencytype="gold"}},
      {decorID=491, source={type="vendor", itemID=245382, currency="125", currencytype="gold"}},
      {decorID=492, source={type="vendor", itemID=245385, currency="100", currencytype="gold"}},
      {decorID=493, source={type="vendor", itemID=245386, currency="125", currencytype="gold"}},
      {decorID=494, source={type="vendor", itemID=235523, currency="50", currencytype="gold"}, requirements={quest={id=92965}}},
      {decorID=496, source={type="vendor", itemID=245372, currency="100", currencytype="gold"}, requirements={quest={id=92983}}},
      {decorID=497, source={type="vendor", itemID=245374, currency="100", currencytype="gold"}},
      {decorID=770, source={type="vendor", itemID=245367, currency="150", currencytype="gold"}},
      {decorID=1122, source={type="vendor", itemID=242951, currency="75", currencytype="gold"}, requirements={quest={id=92969}}},
      {decorID=1280, source={type="vendor", itemID=243334, currency="50", currencytype="gold"}, requirements={quest={id=92978}}},
      {decorID=1457, source={type="vendor", itemID=244667, currency="125", currencytype="gold"}},
      {decorID=1742, source={type="vendor", itemID=245551, currency="75", currencytype="gold"}},
      {decorID=1862, source={type="vendor", itemID=245656, currency="150", currencytype="gold"}},
      {decorID=1863, source={type="vendor", itemID=245657, currency="125", currencytype="gold"}},
      {decorID=1878, source={type="vendor", itemID=245662, currency="100", currencytype="gold"}, requirements={quest={id=92999}}},
      {decorID=1992, source={type="vendor", itemID=246102, currency="125", currencytype="gold"}, requirements={quest={id=92998}}},
      {decorID=1994, source={type="vendor", itemID=246104, currency="25", currencytype="gold"}, requirements={quest={id=92971}}},
      {decorID=1995, source={type="vendor", itemID=246105, currency="100", currencytype="gold"}},
      {decorID=1996, source={type="vendor", itemID=246106, currency="10", currencytype="gold"}, requirements={quest={id=92985}}},
      {decorID=1997, source={type="vendor", itemID=246107, currency="125", currencytype="gold"}, requirements={quest={id=92997}}},
      {decorID=1999, source={type="vendor", itemID=246109, currency="25", currencytype="gold"}},
      {decorID=2089, source={type="vendor", itemID=246219, currency="100", currencytype="gold"}},
      {decorID=2385, source={type="vendor", itemID=246588, currency="150", currencytype="gold"}},
      {decorID=2496, source={type="vendor", itemID=246742, currency="75", currencytype="gold"}, requirements={quest={id=92970}}},
      {decorID=9472, source={type="vendor", itemID=253590, currency="100", currencytype="gold"}},
      {decorID=14814, source={type="vendor", itemID=263025, currency="100", currencytype="gold"}},
    }
  },

  {
    source={
      id=255216,
      type="vendor",
      faction="Alliance",
      zone="Founder's Point",
      worldmap="2352:5220:3800"
    },
    items={
      {decorID=80, source={type="vendor", itemID=235994, currency="100", currencytype="gold"}, requirements={quest={id=93008}}},
      {decorID=984, source={type="vendor", itemID=241617, currency="50", currencytype="gold"}, requirements={quest={id=93143}}},
      {decorID=985, source={type="vendor", itemID=241618, currency="10", currencytype="gold"}, requirements={quest={id=93000}}},
      {decorID=987, source={type="vendor", itemID=241620, currency="100", currencytype="gold"}, requirements={quest={id=93150}}},
      {decorID=988, source={type="vendor", itemID=241621, currency="25", currencytype="gold"}, requirements={quest={id=93152}}},
      {decorID=989, source={type="vendor", itemID=241622, currency="75", currencytype="gold"}},
      {decorID=994, source={type="vendor", itemID=253441, currency="100", currencytype="gold"}, requirements={quest={id=93005}}},
      {decorID=1153, source={type="vendor", itemID=253479, currency="50", currencytype="gold"}, requirements={quest={id=93006}}},
      {decorID=1162, source={type="vendor", itemID=253490, currency="75", currencytype="gold"}, requirements={quest={id=93002}}},
      {decorID=1163, source={type="vendor", itemID=253493, currency="100", currencytype="gold"}, requirements={quest={id=93147}}},
      {decorID=1245, source={type="vendor", itemID=243242, currency="50", currencytype="gold"}},
      {decorID=1246, source={type="vendor", itemID=243243, currency="75", currencytype="gold"}},
      {decorID=1329, source={type="vendor", itemID=243495, currency="100", currencytype="gold"}, requirements={quest={id=93149}}},
      {decorID=1487, source={type="vendor", itemID=244781, currency="50", currencytype="gold"}},
      {decorID=1770, source={type="vendor", itemID=245575, currency="100", currencytype="gold"}, requirements={quest={id=92994}}},
      {decorID=1771, source={type="vendor", itemID=245576, currency="50", currencytype="gold"}, requirements={quest={id=92993}}},
      {decorID=1772, source={type="vendor", itemID=245578, currency="100", currencytype="gold"}, requirements={quest={id=92992}}},
      {decorID=1773, source={type="vendor", itemID=245579, currency="75", currencytype="gold"}},
      {decorID=1774, source={type="vendor", itemID=245581, currency="50", currencytype="gold"}, requirements={quest={id=93135}}},
      {decorID=1775, source={type="vendor", itemID=245582, currency="75", currencytype="gold"}},
      {decorID=1776, source={type="vendor", itemID=245583, currency="100", currencytype="gold"}, requirements={quest={id=93136}}},
      {decorID=1844, source={type="vendor", itemID=245649, currency="100", currencytype="gold"}, requirements={quest={id=93137}}},
      {decorID=2104, source={type="vendor", itemID=246249, currency="50", currencytype="gold"}, requirements={quest={id=93140}}},
      {decorID=2105, source={type="vendor", itemID=246250, currency="125", currencytype="gold"}, requirements={quest={id=93138}}},
      {decorID=2106, source={type="vendor", itemID=246251, currency="75", currencytype="gold"}},
      {decorID=2107, source={type="vendor", itemID=246252, currency="50", currencytype="gold"}},
      {decorID=2108, source={type="vendor", itemID=246253, currency="100", currencytype="gold"}, requirements={quest={id=93139}}},
      {decorID=2109, source={type="vendor", itemID=246254, currency="50", currencytype="gold"}, requirements={quest={id=92991}}},
      {decorID=2110, source={type="vendor", itemID=246255, currency="125", currencytype="gold"}, requirements={quest={id=93009}}},
      {decorID=2111, source={type="vendor", itemID=246256, currency="75", currencytype="gold"}},
      {decorID=2112, source={type="vendor", itemID=246257, currency="50", currencytype="gold"}},
      {decorID=2113, source={type="vendor", itemID=246258, currency="100", currencytype="gold"}, requirements={quest={id=92990}}},
      {decorID=2254, source={type="vendor", itemID=246431, currency="50", currencytype="gold"}},
      {decorID=2458, source={type="vendor", itemID=246691, currency="50", currencytype="gold"}},
      {decorID=2474, source={type="vendor", itemID=246711, currency="10", currencytype="gold"}},
      {decorID=2590, source={type="vendor", itemID=246961, currency="10", currencytype="gold"}},
      {decorID=3826, source={type="vendor", itemID=247501, currency="75", currencytype="gold"}},
      {decorID=4562, source={type="vendor", itemID=248760, currency="50", currencytype="gold"}, requirements={quest={id=93134}}},
      {decorID=5563, source={type="vendor", itemID=249558, currency="100", currencytype="gold"}},
      {decorID=8917, source={type="vendor", itemID=251981, currency="50", currencytype="gold"}, requirements={quest={id=93141}}},
      {decorID=8918, source={type="vendor", itemID=251982, currency="75", currencytype="gold"}},
      {decorID=9254, source={type="vendor", itemID=253180, currency="100", currencytype="gold"}},
      {decorID=9255, source={type="vendor", itemID=253181, currency="50", currencytype="gold"}, requirements={quest={id=93007}}},
      {decorID=10860, source={type="vendor", itemID=255650, currency="25", currencytype="gold"}, requirements={quest={id=92995}}},
      {decorID=11719, source={type="vendor", itemID=257690, currency="100", currencytype="gold"}, requirements={quest={id=93003}}},
      {decorID=15454, source={type="vendor", itemID=264169, currency="25", currencytype="gold"}},
    }
  },

  {
    source={
      id=255218,
      type="vendor",
      faction="Alliance",
      zone="Founder's Point",
      worldmap="2352:5220:3780"
    },
    items={
      {decorID=986, source={type="vendor", itemID=253437, currency="75", currencytype="gold"}},
      {decorID=990, source={type="vendor", itemID=241623, currency="10", currencytype="gold"}},
      {decorID=991, source={type="vendor", itemID=253439, currency="75", currencytype="gold"}},
--       {decorID=992, source={type="vendor", itemID=241625, currency="25", currencytype="gold"}} -- EA_NOTE,
      {decorID=1155, source={type="vendor", itemID=243088, currency="100", currencytype="gold"}},
      {decorID=1165, source={type="vendor", itemID=253495, currency="125", currencytype="gold"}},
      {decorID=1350, source={type="vendor", itemID=244118, currency="100", currencytype="gold"}},
      {decorID=1356, source={type="vendor", itemID=244169, currency="100", currencytype="gold"}, requirements={quest={id=93148}}},
      {decorID=1486, source={type="vendor", itemID=244780, currency="100", currencytype="gold"}, requirements={quest={id=93004}}},
      {decorID=1488, source={type="vendor", itemID=244782, currency="50", currencytype="gold"}, requirements={quest={id=93001}}},
      {decorID=3827, source={type="vendor", itemID=247502, currency="150", currencytype="gold"}},
      {decorID=4484, source={type="vendor", itemID=248658, currency="25", currencytype="gold"}},
      {decorID=11720, source={type="vendor", itemID=257691, currency="10", currencytype="gold"}, requirements={quest={id=93142}}},
      {decorID=11721, source={type="vendor", itemID=257692, currency="100", currencytype="gold"}, requirements={quest={id=93151}}},
    }
  },

  {
    source={
      id=255221,
      type="vendor",
      faction="Alliance",
      zone="Founder's Point",
      worldmap="2352:5347:4093"
    },
    items={
      {decorID=520, source={type="vendor", itemID=245369, currency="25", currencytype="gold"}},
      {decorID=521, source={type="vendor", itemID=245371, currency="75", currencytype="gold"}},
      {decorID=771, source={type="vendor", itemID=245329, currency="25", currencytype="gold"}},
      {decorID=772, source={type="vendor", itemID=245327, currency="50", currencytype="gold"}},
      {decorID=773, source={type="vendor", itemID=245328, currency="25", currencytype="gold"}},
      {decorID=1864, source={type="vendor", itemID=245658, currency="10", currencytype="gold"}},
      {decorID=1865, source={type="vendor", itemID=245659, currency="10", currencytype="gold"}},
      {decorID=1866, source={type="vendor", itemID=245660, currency="10", currencytype="gold"}},
      {decorID=1867, source={type="vendor", itemID=245661, currency="10", currencytype="gold"}},
      {decorID=4406, source={type="vendor", itemID=248337, currency="50", currencytype="gold"}},
      {decorID=4407, source={type="vendor", itemID=248338, currency="50", currencytype="gold"}},
      {decorID=4408, source={type="vendor", itemID=248339, currency="50", currencytype="gold"}},
      {decorID=4461, source={type="vendor", itemID=248635, currency="25", currencytype="gold"}},
      {decorID=4465, source={type="vendor", itemID=248639, currency="25", currencytype="gold"}},
      {decorID=4466, source={type="vendor", itemID=248640, currency="25", currencytype="gold"}},
      {decorID=4467, source={type="vendor", itemID=248641, currency="25", currencytype="gold"}},
      {decorID=4468, source={type="vendor", itemID=248642, currency="50", currencytype="gold"}},
      {decorID=4469, source={type="vendor", itemID=248643, currency="125", currencytype="gold"}},
      {decorID=4470, source={type="vendor", itemID=248644, currency="25", currencytype="gold"}},
      {decorID=4471, source={type="vendor", itemID=248645, currency="25", currencytype="gold"}},
      {decorID=4472, source={type="vendor", itemID=248646, currency="50", currencytype="gold"}},
      {decorID=4473, source={type="vendor", itemID=248647, currency="10", currencytype="gold"}},
      {decorID=4474, source={type="vendor", itemID=248648, currency="50", currencytype="gold"}},
      {decorID=4475, source={type="vendor", itemID=248649, currency="125", currencytype="gold"}},
      {decorID=4822, source={type="vendor", itemID=248802, currency="10", currencytype="gold"}},
      {decorID=4823, source={type="vendor", itemID=248803, currency="25", currencytype="gold"}},
      {decorID=4845, source={type="vendor", itemID=248811, currency="10", currencytype="gold"}},
      {decorID=10855, source={type="vendor", itemID=255644, currency="150", currencytype="gold"}},
      {decorID=10856, source={type="vendor", itemID=255646, currency="150", currencytype="gold"}},
      {decorID=12189, source={type="vendor", itemID=258658, currency="150", currencytype="gold"}},
      {decorID=12190, source={type="vendor", itemID=258659, currency="150", currencytype="gold"}},
      {decorID=17868, source={type="vendor", itemID=266239, currency="150", currencytype="gold"}},
      {decorID=17869, source={type="vendor", itemID=266240, currency="150", currencytype="gold"}},
      {decorID=17870, source={type="vendor", itemID=266241, currency="150", currencytype="gold"}},
      {decorID=17871, source={type="vendor", itemID=266242, currency="150", currencytype="gold"}},
      {decorID=17872, source={type="vendor", itemID=266243, currency="150", currencytype="gold"}},
      {decorID=17873, source={type="vendor", itemID=266244, currency="75", currencytype="gold"}},
      {decorID=17874, source={type="vendor", itemID=266245, currency="75", currencytype="gold"}},
      {decorID=17918, source={type="vendor", itemID=266443, currency="50", currencytype="gold"}},
      {decorID=17919, source={type="vendor", itemID=266444, currency="75", currencytype="gold"}},
    }
  },

  {
    source={
      id=255222,
      type="vendor",
      faction="Alliance",
      zone="Founder's Point",
      worldmap="2352:6240:8020"
    },
    items={
      {decorID=81, source={type="vendor", itemID=245398, currency="100", currencytype="gold"}, requirements={quest={id=93110}}},
      {decorID=522, source={type="vendor", itemID=236653, currency="75", currencytype="gold"}},
      {decorID=523, source={type="vendor", itemID=236654, currency="100", currencytype="gold"}, requirements={quest={id=93073}}},
      {decorID=524, source={type="vendor", itemID=236655, currency="100", currencytype="gold"}, requirements={quest={id=93074}}},
      {decorID=525, source={type="vendor", itemID=236666, currency="50", currencytype="gold"}, requirements={quest={id=93075}}},
      {decorID=526, source={type="vendor", itemID=236667, currency="50", currencytype="gold"}},
      {decorID=534, source={type="vendor", itemID=245393, currency="100", currencytype="gold"}},
      {decorID=535, source={type="vendor", itemID=245394, currency="100", currencytype="gold"}},
      {decorID=536, source={type="vendor", itemID=245395, currency="75", currencytype="gold"}},
      {decorID=1437, source={type="vendor", itemID=244533, currency="50", currencytype="gold"}, requirements={quest={id=93078}}},
      {decorID=1438, source={type="vendor", itemID=244534, currency="50", currencytype="gold"}, requirements={quest={id=93079}}},
      {decorID=1451, source={type="vendor", itemID=244661, currency="50", currencytype="gold"}},
      {decorID=1452, source={type="vendor", itemID=244662, currency="50", currencytype="gold"}},
      {decorID=1453, source={type="vendor", itemID=244663, currency="50", currencytype="gold"}},
      {decorID=1698, source={type="vendor", itemID=245264, currency="10", currencytype="gold"}},
      {decorID=1699, source={type="vendor", itemID=245265, currency="10", currencytype="gold"}},
      {decorID=1700, source={type="vendor", itemID=245266, currency="50", currencytype="gold"}, requirements={quest={id=93080}}},
      {decorID=1723, source={type="vendor", itemID=245532, currency="50", currencytype="gold"}, requirements={quest={id=93081}}},
      {decorID=1736, source={type="vendor", itemID=245545, currency="25", currencytype="gold"}, requirements={quest={id=93083}}},
      {decorID=1744, source={type="vendor", itemID=245555, currency="100", currencytype="gold"}, requirements={quest={id=93111}}},
      {decorID=1879, source={type="vendor", itemID=245680, currency="75", currencytype="gold"}, requirements={quest={id=93109}}},
      {decorID=1977, source={type="vendor", itemID=246036, currency="75", currencytype="gold"}, requirements={quest={id=93091}}},
      {decorID=1978, source={type="vendor", itemID=246037, currency="75", currencytype="gold"}},
      {decorID=1979, source={type="vendor", itemID=246038, currency="75", currencytype="gold"}},
      {decorID=2092, source={type="vendor", itemID=246223, currency="75", currencytype="gold"}},
      {decorID=2093, source={type="vendor", itemID=246224, currency="75", currencytype="gold"}, requirements={quest={id=93099}}},
      {decorID=2094, source={type="vendor", itemID=246225, currency="50", currencytype="gold"}},
      {decorID=2114, source={type="vendor", itemID=246259, currency="50", currencytype="gold"}, requirements={quest={id=93085}}},
      {decorID=2115, source={type="vendor", itemID=246260, currency="100", currencytype="gold"}, requirements={quest={id=93087}}},
      {decorID=2116, source={type="vendor", itemID=246261, currency="125", currencytype="gold"}, requirements={quest={id=93088}}},
      {decorID=2117, source={type="vendor", itemID=246262, currency="75", currencytype="gold"}},
      {decorID=2118, source={type="vendor", itemID=246263, currency="50", currencytype="gold"}},
      {decorID=2384, source={type="vendor", itemID=246587, currency="25", currencytype="gold"}, requirements={quest={id=93100}}},
      {decorID=2439, source={type="vendor", itemID=246607, currency="75", currencytype="gold"}},
      {decorID=2440, source={type="vendor", itemID=246608, currency="125", currencytype="gold"}},
      {decorID=2441, source={type="vendor", itemID=246609, currency="100", currencytype="gold"}},
      {decorID=2442, source={type="vendor", itemID=246610, currency="100", currencytype="gold"}},
      {decorID=2445, source={type="vendor", itemID=246613, currency="125", currencytype="gold"}},
      {decorID=2446, source={type="vendor", itemID=246614, currency="100", currencytype="gold"}, requirements={quest={id=93115}}},
      {decorID=2454, source={type="vendor", itemID=246687, currency="10", currencytype="gold"}, requirements={quest={id=93101}}},
      {decorID=2535, source={type="vendor", itemID=246869, currency="75", currencytype="gold"}, requirements={quest={id=93132}}},
      {decorID=2545, source={type="vendor", itemID=246879, currency="25", currencytype="gold"}},
      {decorID=2592, source={type="vendor", itemID=247221, currency="50", currencytype="gold"}, requirements={quest={id=93106}}},
      {decorID=4386, source={type="vendor", itemID=248246, currency="75", currencytype="gold"}, requirements={quest={id=93107}}},
      {decorID=5853, source={type="vendor", itemID=250093, currency="75", currencytype="gold"}},
      {decorID=5854, source={type="vendor", itemID=250094, currency="75", currencytype="gold"}},
      {decorID=7836, source={type="vendor", itemID=250913, currency="75", currencytype="gold"}},
      {decorID=7842, source={type="vendor", itemID=250920, currency="25", currencytype="gold"}, requirements={quest={id=93102}}},
      {decorID=8771, source={type="vendor", itemID=251639, currency="100", currencytype="gold"}},
      {decorID=8907, source={type="vendor", itemID=251973, currency="50", currencytype="gold"}, requirements={quest={id=93108}}},
      {decorID=8910, source={type="vendor", itemID=251974, currency="50", currencytype="gold"}},
      {decorID=8911, source={type="vendor", itemID=251975, currency="25", currencytype="gold"}},
      {decorID=8912, source={type="vendor", itemID=251976, currency="50", currencytype="gold"}},
      {decorID=9143, source={type="vendor", itemID=252657, currency="50", currencytype="gold"}},
      {decorID=10324, source={type="vendor", itemID=254316, currency="75", currencytype="gold"}},
      {decorID=10367, source={type="vendor", itemID=254560, currency="50", currencytype="gold"}},
      {decorID=10952, source={type="vendor", itemID=256050, currency="75", currencytype="gold"}},
      {decorID=11480, source={type="vendor", itemID=257389, currency="50", currencytype="gold"}},
      {decorID=11874, source={type="vendor", itemID=258148, currency="75", currencytype="gold"}},
    }
  },

  {
    source={
      id=255228,
      type="vendor",
      faction="Alliance",
      zone="Founder's Point",
      worldmap="2352:6240:8000"
    },
    items={
      {decorID=1436, source={type="vendor", itemID=244532, currency="10", currencytype="gold"}, requirements={quest={id=93077}}},
      {decorID=1439, source={type="vendor", itemID=244535, currency="150", currencytype="gold"}},
      {decorID=1724, source={type="vendor", itemID=245533, currency="50", currencytype="gold"}, requirements={quest={id=93082}}},
      {decorID=1737, source={type="vendor", itemID=245546, currency="50", currencytype="gold"}, requirements={quest={id=93084}}},
      {decorID=2087, source={type="vendor", itemID=246217, currency="75", currencytype="gold"}, requirements={quest={id=93097}}},
      {decorID=2088, source={type="vendor", itemID=246218, currency="25", currencytype="gold"}, requirements={quest={id=93098}}},
      {decorID=2090, source={type="vendor", itemID=246220, currency="125", currencytype="gold"}},
      {decorID=2098, source={type="vendor", itemID=246241, currency="10", currencytype="gold"}, requirements={quest={id=93103}}},
      {decorID=2443, source={type="vendor", itemID=246611, currency="125", currencytype="gold"}},
      {decorID=2444, source={type="vendor", itemID=246612, currency="100", currencytype="gold"}},
      {decorID=2447, source={type="vendor", itemID=246615, currency="10", currencytype="gold"}},
      {decorID=2448, source={type="vendor", itemID=246616, currency="25", currencytype="gold"}},
      {decorID=2534, source={type="vendor", itemID=246868, currency="100", currencytype="gold"}, requirements={quest={id=93131}}},
      {decorID=2546, source={type="vendor", itemID=246880, currency="10", currencytype="gold"}, requirements={quest={id=93104}}},
      {decorID=2547, source={type="vendor", itemID=246881, currency="10", currencytype="gold"}},
      {decorID=2548, source={type="vendor", itemID=246882, currency="100", currencytype="gold"}, requirements={quest={id=93133}}},
      {decorID=2549, source={type="vendor", itemID=246883, currency="25", currencytype="gold"}, requirements={quest={id=93105}}},
      {decorID=2550, source={type="vendor", itemID=246884, currency="25", currencytype="gold"}},
      {decorID=5561, source={type="vendor", itemID=249550, currency="150", currencytype="gold"}},
      {decorID=8236, source={type="vendor", itemID=251545, currency="100", currencytype="gold"}},
      {decorID=8769, source={type="vendor", itemID=251637, currency="100", currencytype="gold"}},
      {decorID=8770, source={type="vendor", itemID=251638, currency="150", currencytype="gold"}},
      {decorID=10791, source={type="vendor", itemID=254893, currency="150", currencytype="gold"}},
      {decorID=10892, source={type="vendor", itemID=255708, currency="100", currencytype="gold"}},
      {decorID=11139, source={type="vendor", itemID=256357, currency="75", currencytype="gold"}},
      {decorID=11437, source={type="vendor", itemID=257099, currency="100", currencytype="gold"}},
    }
  },

  {
    source={
      id=255230,
      type="vendor",
      faction="Alliance",
      zone="Founder's Point",
      worldmap="2352:6223:8030"
    },
    items={
      {decorID=4406, source={type="vendor", itemID=248337, currency="50", currencytype="gold"}},
      {decorID=4407, source={type="vendor", itemID=248338, currency="50", currencytype="gold"}},
      {decorID=4408, source={type="vendor", itemID=248339, currency="50", currencytype="gold"}},
      {decorID=4451, source={type="vendor", itemID=248625, currency="150", currencytype="gold"}},
      {decorID=4452, source={type="vendor", itemID=248626, currency="75", currencytype="gold"}},
      {decorID=4453, source={type="vendor", itemID=248627, currency="10", currencytype="gold"}},
      {decorID=4454, source={type="vendor", itemID=248628, currency="150", currencytype="gold"}},
      {decorID=4455, source={type="vendor", itemID=248629, currency="25", currencytype="gold"}},
      {decorID=4456, source={type="vendor", itemID=248630, currency="25", currencytype="gold"}},
      {decorID=4457, source={type="vendor", itemID=248631, currency="100", currencytype="gold"}},
      {decorID=4458, source={type="vendor", itemID=248632, currency="75", currencytype="gold"}},
      {decorID=4459, source={type="vendor", itemID=248633, currency="50", currencytype="gold"}},
      {decorID=4460, source={type="vendor", itemID=248634, currency="125", currencytype="gold"}},
      {decorID=4462, source={type="vendor", itemID=248636, currency="75", currencytype="gold"}},
      {decorID=4463, source={type="vendor", itemID=248637, currency="10", currencytype="gold"}},
      {decorID=4464, source={type="vendor", itemID=248638, currency="25", currencytype="gold"}},
      {decorID=4476, source={type="vendor", itemID=248650, currency="10", currencytype="gold"}},
      {decorID=11461, source={type="vendor", itemID=257359, currency="10", currencytype="gold"}},
      {decorID=11479, source={type="vendor", itemID=257388, currency="10", currencytype="gold"}},
      {decorID=11481, source={type="vendor", itemID=257390, currency="10", currencytype="gold"}},
      {decorID=11482, source={type="vendor", itemID=257392, currency="10", currencytype="gold"}},
      {decorID=14382, source={type="vendor", itemID=260701, currency="25", currencytype="gold"}},
      {decorID=14383, source={type="vendor", itemID=260702, currency="75", currencytype="gold"}},
      {decorID=17863, source={type="vendor", itemID=266234}},
      {decorID=17864, source={type="vendor", itemID=266235}},
      {decorID=17865, source={type="vendor", itemID=266236}},
      {decorID=17866, source={type="vendor", itemID=266237}},
      {decorID=17867, source={type="vendor", itemID=266238}},
      {decorID=17873, source={type="vendor", itemID=266244}},
      {decorID=17874, source={type="vendor", itemID=266245}},
      {decorID=17918, source={type="vendor", itemID=266443}},
      {decorID=17919, source={type="vendor", itemID=266444}},
    }
  },

  {
    source={
      id=256071,
      type="vendor",
      faction="Alliance",
      zone="Stormwind City",
      worldmap="84:4926:8009"
    },
    items={
      {decorID=766, source={type="vendor", itemID=239177, currency="2000", currencytype="gold"}},
      {decorID=768, source={type="vendor", itemID=239179, currency="2000", currencytype="gold"}},
      {decorID=2511, source={type="vendor", itemID=246845, currency="2000", currencytype="gold"}},
      {decorID=2513, source={type="vendor", itemID=246847, currency="2000", currencytype="gold"}},
      {decorID=2514, source={type="vendor", itemID=246848, currency="2000", currencytype="gold"}},
      {decorID=2526, source={type="vendor", itemID=246860, currency="2000", currencytype="gold"}},
    }
  },

  {
    source={
      id=256119,
      type="vendor",
      faction="Horde",
      zone="Orgrimmar",
      worldmap="86:9987:1210"
    },
    items={
      {decorID=766, source={type="vendor", itemID=239177, currency="2000", currencytype="gold"}},
      {decorID=768, source={type="vendor", itemID=239179, currency="2000", currencytype="gold"}},
      {decorID=2511, source={type="vendor", itemID=246845, currency="2000", currencytype="gold"}},
      {decorID=2513, source={type="vendor", itemID=246847, currency="2000", currencytype="gold"}},
      {decorID=2514, source={type="vendor", itemID=246848, currency="2000", currencytype="gold"}},
      {decorID=2526, source={type="vendor", itemID=246860, currency="2000", currencytype="gold"}},
    }
  },

  {
    source={
      id=256750,
      type="vendor",
      faction="Alliance",
      zone="Founder's Point",
      worldmap="2352:5830:6168"
    },
    items={
      {decorID=721, source={type="vendor", itemID=245400, currency="10", currencytype="gold"}},
      {decorID=722, source={type="vendor", itemID=245401, currency="10", currencytype="gold"}},
      {decorID=723, source={type="vendor", itemID=245402, currency="10", currencytype="gold"}},
      {decorID=724, source={type="vendor", itemID=245403, currency="10", currencytype="gold"}},
      {decorID=725, source={type="vendor", itemID=245404, currency="10", currencytype="gold"}},
    }
  },

  {
    source={
      id=261231,
      type="vendor",
      faction="Neutral",
      zone="Stormwind City",
      worldmap="84:4860:6880"
    },
    items={
      {decorID=14467, source={type="vendor", itemID=260785, currency="1350", currencytype="gold"}},
    }
  },

}
