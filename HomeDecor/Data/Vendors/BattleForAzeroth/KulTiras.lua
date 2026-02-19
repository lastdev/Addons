local ADDON, NS = ...

NS.Data = NS.Data or {}
NS.Data.Vendors = NS.Data.Vendors or {}

NS.Data.Vendors["BattleForAzeroth"] = NS.Data.Vendors["BattleForAzeroth"] or {}

NS.Data.Vendors["BattleForAzeroth"]["KulTiras"] = {

  {
    source={
      id=127151,
      type="vendor",
      faction="Horde",
      zone="The Vindicaar",
      worldmap="940:6822:5691"
    },
    items={
      {decorID=930, source={type="vendor", itemID=245422, currency="640", currencytype="gold"}, requirements={quest={id=47691}}},
      {decorID=8189, source={type="vendor", itemID=251480, currency="240", currencytype="gold"}, requirements={quest={id=44004}}},
    }
  },

  {
    source={
      id=135808,
      type="vendor",
      faction="Alliance",
      zone="Boralus",
      worldmap="1161:6760:2180"
    },
    items={
      {decorID=2091, source={type="vendor", itemID=246222, currency="75", currencytype=1560}, requirements={rep="true"}},
      {decorID=8984, source={type="vendor", itemID=252036, currency="500", currencytype=1560}, requirements={rep="true"}},
      {decorID=9036, source={type="vendor", itemID=252387, currency="100", currencytype=1560}, requirements={rep="true"}},
      {decorID=9037, source={type="vendor", itemID=252388, currency="50", currencytype=1560}, requirements={rep="true"}},
      {decorID=9051, source={type="vendor", itemID=252402, currency="450", currencytype=1560}, requirements={rep="true"}},
    }
  },
  
  {
    source={
      id=142115,
      type="vendor",
      faction="Alliance",
      zone="Boralus Harbor",
      worldmap="1161:6760:4080"
    },
    items={
      {decorID=4813, source={type="vendor", itemID=248796, currency="3000", currencytype="gold"}, requirements={achievement={id=5442}}},
    }
  },
  
  {
    source={
      id=144129,
      type="vendor",
      faction="Neutral",
      zone="Blackrock Depths",
      worldmap="1186:4977:3222"
    },
    items={
      {decorID=1120, source={type="vendor", itemID=245291}},
    }
  },

  {
    source={
      id=150716,
      type="vendor",
      faction="Neutral",
      zone="Mechagon",
      worldmap="1462:7370:3691"
    },
    items={
      {decorID=2322, source={type="vendor", itemID=246479, currency="5", currencytype=3363}, requirements={achievement={id=13723}}},
      {decorID=2323, source={type="vendor", itemID=246480, currency="800", currencytype="gold"}, requirements={rep="true"}},
      {decorID=2326, source={type="vendor", itemID=246483, currency="400", currencytype="gold"}, requirements={achievement={id=13473}}},
      {decorID=2327, source={type="vendor", itemID=246484}, requirements={rep="true"}},
      {decorID=2337, source={type="vendor", itemID=246497}, requirements={rep="true"}},
      {decorID=2338, source={type="vendor", itemID=246498, currency="80", currencytype="gold"}, requirements={rep="true"}},
      {decorID=2339, source={type="vendor", itemID=246499, currency="120", currencytype="gold"}, requirements={rep="true"}},
      {decorID=2341, source={type="vendor", itemID=246501, currency="160", currencytype="gold"}, requirements={rep="true"}},
      {decorID=2343, source={type="vendor", itemID=246503, currency="80", currencytype="gold"}, requirements={rep="true"}},
      {decorID=2430, source={type="vendor", itemID=246598}, requirements={achievement={id=13477}}},
      {decorID=2433, source={type="vendor", itemID=246601}},
      {decorID=2435, source={type="vendor", itemID=246603}, requirements={achievement={id=13475}}},
      {decorID=2437, source={type="vendor", itemID=246605, currency="120", currencytype="gold"}, requirements={rep="true"}},
      {decorID=2466, source={type="vendor", itemID=246701, currency="160", currencytype="gold"}},
      {decorID=2467, source={type="vendor", itemID=246703}, requirements={quest={id=55736}}},
    }
  },

  {
    source={
      id=152194,
      type="vendor",
      faction="Neutral",
      zone="Chamber of Heart",
      worldmap="1473:5015:6693"
    },
    items={
      {decorID=3837, source={type="vendor", itemID=247667, currency="10000", currencytype=1803}, requirements={achievement={id=40953}}},
      {decorID=3838, source={type="vendor", itemID=247668, currency="10000", currencytype=1803}, requirements={achievement={id=40953}}},
    }
  },

  {
    source={
      id=246721,
      type="vendor",
      faction="Alliance",
      zone="Tiragarde Sound",
      worldmap="1161:5629:4582"
    },
    items={
      {decorID=9039, source={type="vendor", itemID=252390, currency="450", currencytype=1560}},
      {decorID=9040, source={type="vendor", itemID=252391, currency="750", currencytype=1560}},
      {decorID=9042, source={type="vendor", itemID=252393, currency="500", currencytype=1560}},
      {decorID=9053, source={type="vendor", itemID=252404, currency="300", currencytype=1560}},
      {decorID=12210, source={type="vendor", itemID=258765, currency="175", currencytype=1560}},
    }
  },

  {
    source={
      id=252313,
      type="vendor",
      faction="Alliance",
      zone="Stormsong Valley",
      worldmap="942:5960:6960"
    },
    items={
      {decorID=1900, source={type="vendor", itemID=245984, currency="350", currencytype=1560}, requirements={quest={id=50783}}},
      {decorID=9043, source={type="vendor", itemID=252394, currency="550", currencytype=1560}},
      {decorID=9044, source={type="vendor", itemID=252395, currency="450", currencytype=1560}, requirements={quest={id=51401}}},
      {decorID=9045, source={type="vendor", itemID=252396, currency="125", currencytype=1560}},
      {decorID=9047, source={type="vendor", itemID=252398, currency="200", currencytype=1560}},
      {decorID=9139, source={type="vendor", itemID=252652, currency="800", currencytype=1560}},
      {decorID=9142, source={type="vendor", itemID=252655, currency="175", currencytype=1560}, requirements={quest={id=50611}}},
    }
  },

  {
    source={
      id=252316,
      type="vendor",
      faction="Alliance",
      zone="Tiragarde Sound",
      worldmap="895:5340:3120"
    },
    items={
      {decorID=9041, source={type="vendor", itemID=252392, currency="250", currencytype=1560}, requirements={quest={id=48089}}},
      {decorID=9054, source={type="vendor", itemID=252405, currency="250", currencytype=1560}},
    }
  },

  {
    source={
      id=252345,
      type="vendor",
      faction="Alliance",
      zone="Tiragarde Sound",
      worldmap="1161:7074:1566"
    },
    items={
      {decorID=1704, source={type="vendor", itemID=245271, currency="800", currencytype=1560}, requirements={achievement={id=12582}}},
      {decorID=9035, source={type="vendor", itemID=252386, currency="400", currencytype=1560}, requirements={quest={id=50972}}},
      {decorID=9049, source={type="vendor", itemID=252400, currency="500", currencytype=1560}, requirements={quest={id=53887}}},
      {decorID=9052, source={type="vendor", itemID=252403, currency="550", currencytype=1560}, requirements={quest={id=53720}}},
      {decorID=9055, source={type="vendor", itemID=252406, currency="375", currencytype=1560}, requirements={quest={id=47489}}},
      {decorID=9140, source={type="vendor", itemID=252653, currency="650", currencytype=1560}, requirements={achievement={id=13049}}},
      {decorID=9141, source={type="vendor", itemID=252654, currency="300", currencytype=1560}, requirements={achievement={id=12997}}},
      {decorID=9166, source={type="vendor", itemID=252754, currency="800", currencytype=1560}, requirements={quest={id=55045}}},
    }
  },

}
