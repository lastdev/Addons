local ADDON, NS = ...

NS.Data = NS.Data or {}
NS.Data.Vendors = NS.Data.Vendors or {}

NS.Data.Vendors["Warlords"] = NS.Data.Vendors["Warlords"] or {}

NS.Data.Vendors["Warlords"]["Draenor"] = {

  {
    source={
      id=76872,
      type="vendor",
      faction="Horde",
      zone="Frostwall",
      worldmap="525:4800:6600"
    },
    items={
      {decorID=1416, source={type="vendor", itemID=244324, currency="150", currencytype=824}},
    }
  },

  {
    source={
      id=78564,
      type="vendor",
      faction="Alliance",
      zone="Lunarfall",
      worldmap="579:3780:3340"
    },
    items={
      {decorID=126, source={type="vendor", itemID=245275, currency="100", currencytype=824}},
    }
  },

  {
    source={
      id=79812,
      type="vendor",
      faction="Horde",
      zone="Frostwall",
      worldmap="525:4800:6600"
    },
    items={
      {decorID=1326, source={type="vendor", itemID=245437}},
      {decorID=1352, source={type="vendor", itemID=245442, currency="100", currencytype=824}},
    }
  },

  {
    source={
      id=81133,
      type="vendor",
      faction="Alliance",
      zone="Shadowmoon Valley (Draenor)",
      worldmap="539:4620:3930"
    },
    items={
      {decorID=11451, source={type="vendor", itemID=257349, costs={{currency="200", currencytype="gold"},{currency="300", currencytype=824}}}},
    }
  },

  {
    source={
      id=85427,
      type="vendor",
      faction="Alliance",
      zone="Lunarfall",
      worldmap="539:3100:1500"
    },
    items={
      {decorID=931, source={type="vendor", itemID=245424, costs={{currency="500", currencytype="gold"},{currency="1000", currencytype=823}}}},
      {decorID=8235, source={type="vendor", itemID=251544, costs={{currency="500", currencytype="gold"},{currency="1000", currencytype=823}}}},
    }
  },

  {
    source={
      id=85932,
      type="vendor",
      faction="Alliance",
      zone="Stormshield, Ashran",
      worldmap="622:4640:7460"
    },
    items={
      {decorID=927, source={type="vendor", itemID=245423, currency="250", currencytype=824}, requirements={rep="true"}},
      {decorID=8185, source={type="vendor", itemID=251476, currency="1000", currencytype=824}, requirements={rep="true"}},
      {decorID=8188, source={type="vendor", itemID=251479, currency="1500", currencytype=824}, requirements={rep="true"}},
      {decorID=8190, source={type="vendor", itemID=251481, currency="500", currencytype=824}, requirements={rep="true"}},
      {decorID=8192, source={type="vendor", itemID=251483, currency="250", currencytype=824}, requirements={rep="true"}},
      {decorID=8193, source={type="vendor", itemID=251484, currency="1000", currencytype=824}, requirements={rep="true"}},
      {decorID=8194, source={type="vendor", itemID=251493, currency="500", currencytype=824}, requirements={rep="true"}},
      {decorID=8242, source={type="vendor", itemID=251551, currency="1500", currencytype=824}, requirements={rep="true"}},
    }
  },

  {
    source={
      id=85946,
      type="vendor",
      faction="Alliance",
      zone="Stormshield, Ashran",
      worldmap="622:4440:7520"
    },
    items={
      {decorID=12203, source={type="vendor", itemID=258743, currency="8", currencytype="gold"}, requirements={rep="true"}},
      {decorID=12206, source={type="vendor", itemID=258746, currency="8", currencytype="gold"}, requirements={rep="true"}},
      {decorID=12207, source={type="vendor", itemID=258747, currency="8", currencytype="gold"}, requirements={rep="true"}},
    }
  },

  {
    source={
      id=85950,
      type="vendor",
      faction="Alliance",
      zone="Stormshield",
      worldmap="622:4097:5954"
    },
    items={
      {decorID=928, source={type="vendor", itemID=245425, costs={{currency="300", currencytype="gold"},{currency="500", currencytype=823}}}, requirements={quest={id=35396}}},
      {decorID=8177, source={type="vendor", itemID=251330, costs={{currency="100", currencytype="gold"},{currency="300", currencytype=823}}}, requirements={quest={id=34792}}},
      {decorID=8186, source={type="vendor", itemID=251477, costs={{currency="500", currencytype="gold"},{currency="1000", currencytype=824}}}, requirements={quest={id=36169}}},
      {decorID=8187, source={type="vendor", itemID=251478}, requirements={quest={id=35196}}},
      {decorID=8239, source={type="vendor", itemID=251548, costs={{currency="300", currencytype="gold"},{currency="500", currencytype=823}}}, requirements={quest={id=34792}}},
      {decorID=8240, source={type="vendor", itemID=251549, currency="2000", currencytype=824}, requirements={quest={id=37322}}},
      {decorID=8772, source={type="vendor", itemID=251640, costs={{currency="500", currencytype="gold"},{currency="1000", currencytype=823}}}, requirements={quest={id=34099}}},
      {decorID=8785, source={type="vendor", itemID=251653, costs={{currency="500", currencytype="gold"},{currency="1000", currencytype=824}}}, requirements={quest={id=35685}}},
      {decorID=8786, source={type="vendor", itemID=251654, costs={{currency="800", currencytype="gold"},{currency="2000", currencytype=823}}}, requirements={quest={id=33256}}},
    }
  },

  {
    source={
      id=86037,
      type="vendor",
      faction="Horde",
      zone="Warspear",
      worldmap="624:5348:5974"
    },
    items={
      {decorID=12203, source={type="vendor", itemID=258743, currency="8", currencytype="gold"}, requirements={rep="true"}},
      {decorID=12206, source={type="vendor", itemID=258746, currency="8", currencytype="gold"}, requirements={rep="true"}},
      {decorID=12207, source={type="vendor", itemID=258747, currency="8", currencytype="gold"}, requirements={rep="true"}},
    }
  },

  {
    source={
      id=86779,
      type="vendor",
      faction="Horde",
      zone="Lunarfall",
      worldmap="539:3100:1500"
    },
    items={
      {decorID=1354, source={type="vendor", itemID=245444, currency="250", currencytype=824}},
      {decorID=1355, source={type="vendor", itemID=245445, currency="150", currencytype=824}},
      {decorID=1413, source={type="vendor", itemID=244321, currency="100", currencytype=824}},
      {decorID=1414, source={type="vendor", itemID=244322, currency="100", currencytype=824}},
    }
  },

  {
    source={
      id=87015,
      type="vendor",
      faction="Horde",
      zone="Frostwall",
      worldmap="525:4800:6600"
    },
    items={
      {decorID=1317, source={type="vendor", itemID=245431, costs={{currency="500", currencytype="gold"},{currency="1000", currencytype=823}}}, requirements={rep="true"}},
      {decorID=1322, source={type="vendor", itemID=245433, costs={{currency="500", currencytype="gold"},{currency="1000", currencytype=823}}}, requirements={rep="true"}},
    }
  },

  {
    source={
      id=87312,
      type="vendor",
      faction="Neutral",
      zone="Frostwall",
      worldmap="525:4800:6600"
    },
    items={
      {decorID=751, source={type="vendor", itemID=239162, costs={{currency="50", currencytype="gold"},{currency="100", currencytype=824}}}},
    }
  },

  {
    source={
      id=87775,
      type="vendor",
      faction="Neutral",
      zone="Spires of Arak",
      worldmap="542:4670:4496"
    },
    items={
      {decorID=12200, source={type="vendor", itemID=258740, currency="8", currencytype="gold"}, requirements={achievement={id=9415}}},
      {decorID=12201, source={type="vendor", itemID=258741, currency="8", currencytype="gold"}, requirements={quest={id=35671}}},
      {decorID=12205, source={type="vendor", itemID=258745, currency="8", currencytype="gold"}, requirements={quest={id=35704}}},
      {decorID=12208, source={type="vendor", itemID=258748, currency="8", currencytype="gold"}, requirements={quest={id=35273}}},
      {decorID=12209, source={type="vendor", itemID=258749, currency="8", currencytype="gold"}, requirements={quest={id=35896}}},
    }
  },

  {
    source={
      id=88220,
      type="vendor",
      faction="Alliance",
      zone="Lunarfall",
      worldmap="539:3100:1500"
    },
    items={
      {decorID=751, source={type="vendor", itemID=239162, costs={{currency="50", currencytype="gold"},{currency="100", currencytype=824}}}},
    }
  },

  {
    source={
      id=88223,
      type="vendor",
      faction="Neutral",
      zone="Lunarfall",
      worldmap="579:3780:3340"
    },
    items={
      {decorID=126, source={type="vendor", itemID=245275}},
    }
  },

  {
    source={
      id=256946,
      type="vendor",
      faction="Neutral",
      zone="Talador",
      worldmap="535:7040:5740"
    },
    items={
      {decorID=12202, source={type="vendor", itemID=258742, currency="10", currencytype="gold"}, requirements={quest={id=33582}}},
    }
  },

}
