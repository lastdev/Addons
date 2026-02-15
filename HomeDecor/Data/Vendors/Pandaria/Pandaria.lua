local ADDON, NS = ...

NS.Data = NS.Data or {}
NS.Data.Vendors = NS.Data.Vendors or {}

NS.Data.Vendors["Pandaria"] = NS.Data.Vendors["Pandaria"] or {}

NS.Data.Vendors["Pandaria"]["Pandaria"] = {

  {
    source={
      id=58414,
      type="vendor",
      faction="Neutral",
      zone="The Jade Forest",
      worldmap="371:5670:4438"
    },
    items={
      {decorID=3870, source={type="vendor", itemID=247730, currency="800", currencytype="gold"}, requirements={rep="true"}},
      {decorID=3872, source={type="vendor", itemID=247732, currency="400", currencytype="gold"}, requirements={rep="true"}},
    }
  },

  {
    source={
      id=58706,
      type="vendor",
      faction="Horde",
      zone="Valley of the Four Winds",
      worldmap="376:5320:5180"
    },
    items={
      {decorID=1201, source={type="vendor", itemID=245508, currency="800", currencytype="gold"}, requirements={rep="true"}},
      {decorID=3840, source={type="vendor", itemID=247670, currency="800", currencytype="gold"}, requirements={rep="true"}},
      {decorID=3874, source={type="vendor", itemID=247734, currency="640", currencytype="gold"}, requirements={rep="true"}},
      {decorID=3877, source={type="vendor", itemID=247737, currency="240", currencytype="gold"}, requirements={rep="true"}},
      {decorID=4488, source={type="vendor", itemID=248663, currency="240", currencytype="gold"}, requirements={quest={id=30526}}},
    }
  },

  {
    source={
      id=59698,
      type="vendor",
      faction="Horde",
      zone="Kun-Lai Summit",
      worldmap="379:5724:6096"
    },
    items={
      {decorID=15595, source={type="vendor", itemID=264349, currency="1000", currencytype="gold"}, requirements={quest={id=30612}}},
    }
  },

  {
    source={
      id=62088,
      type="vendor",
      faction="Horde",
      zone="Vale of Eternal Blossoms",
      worldmap="433:2388:2179"
    },
    items={
      {decorID=767, source={type="vendor", itemID=245332, currency="2000", currencytype="gold"}, requirements={achievement={id=61467}}},
      {decorID=11453, source={type="vendor", itemID=257351, currency="2000", currencytype="gold"}, requirements={achievement={id=42189}}},
      {decorID=11456, source={type="vendor", itemID=257354, currency="2000", currencytype="gold"}, requirements={achievement={id=42187}}},
      {decorID=11457, source={type="vendor", itemID=257355, currency="2000", currencytype="gold"}, requirements={achievement={id=42188}}},
    }
  },

  {
    source={
      id=64001,
      type="vendor",
      faction="Horde",
      zone="Vale of Eternal Blossoms",
      worldmap="390:6280:2320"
    },
    items={
      {decorID=3869, source={type="vendor", itemID=247729, currency="240", currencytype="gold"}, requirements={quest={id=31230}}},
      {decorID=15605, source={type="vendor", itemID=264362, currency="500", currencytype="gold"}},
    }
  },

  {
    source={
      id=64605,
      type="vendor",
      faction="Horde",
      zone="Vale of Eternal Blossoms",
      worldmap="390:8223:2933"
    },
    items={
      {decorID=1172, source={type="vendor", itemID=245512, currency="240", currencytype="gold"}, requirements={rep="true"}},
      {decorID=3832, source={type="vendor", itemID=247662, currency="400", currencytype="gold"}, requirements={rep="true"}},
      {decorID=3833, source={type="vendor", itemID=247663, currency="1600", currencytype="gold"}, requirements={rep="true"}},
      {decorID=3993, source={type="vendor", itemID=247855, currency="240", currencytype="gold"}, requirements={rep="true"}},
      {decorID=3995, source={type="vendor", itemID=247858, currency="1600", currencytype="gold"}, requirements={quest={id=32816}}},
      {decorID=11873, source={type="vendor", itemID=258147, currency="800", currencytype="gold"}, requirements={rep="true"}},
    }
  },

  {
    source={
      id=78564,
      type="vendor",
      faction="Alliance",
      zone="Lunarfall",
      worldmap="582:3850:3140"
    },
    items={
      {decorID=4403, source={type="vendor", itemID=248334, costs={{currency="160", currencytype="gold"},{currency="300", currencytype=824}}}, requirements={quest={id=36404}}},
      {decorID=4404, source={type="vendor", itemID=248335, costs={{currency="40", currencytype="gold"},{currency="100", currencytype=824}}}, requirements={quest={id=36202}}},
      {decorID=4485, source={type="vendor", itemID=248660, costs={{currency="160", currencytype="gold"},{currency="300", currencytype=824}}}, requirements={quest={id=34192}}},
      {decorID=4486, source={type="vendor", itemID=248661, costs={{currency="160", currencytype="gold"},{currency="300", currencytype=824}}}, requirements={quest={id=36592}}},
      {decorID=4816, source={type="vendor", itemID=248799, costs={{currency="40", currencytype="gold"},{currency="100", currencytype=824}}}, requirements={quest={id=34586}}},
      {decorID=4818, source={type="vendor", itemID=248800, currency="1500", currencytype=824}, requirements={quest={id=36615}}},
      {decorID=4844, source={type="vendor", itemID=248810, costs={{currency="40", currencytype="gold"},{currency="100", currencytype=824}}}, requirements={quest={id=35176}}},
    }
  },

  {
    source={
      id=79774,
      type="vendor",
      faction="Horde",
      zone="Frostwall",
      worldmap="590:4380:4740"
    },
    items={
      {decorID=1318, source={type="vendor", itemID=245438, costs={{currency="240", currencytype="gold"},{currency="500", currencytype=824}}}},
      {decorID=1353, source={type="vendor", itemID=245443, costs={{currency="160", currencytype="gold"},{currency="300", currencytype=824}}}, requirements={quest={id=34586}}},
      {decorID=1407, source={type="vendor", itemID=244315, currency="1500", currencytype=824}, requirements={quest={id=36614}}},
      {decorID=1408, source={type="vendor", itemID=244316, costs={{currency="160", currencytype="gold"},{currency="300", currencytype=824}}}, requirements={quest={id=34192}}},
      {decorID=1412, source={type="vendor", itemID=244320, costs={{currency="40", currencytype="gold"},{currency="100", currencytype=824}}}},
      {decorID=1443, source={type="vendor", itemID=244653, costs={{currency="160", currencytype="gold"},{currency="300", currencytype=824}}}, requirements={quest={id=36592}}},
    }
  },

  {
    source={
      id=86776,
      type="vendor",
      faction="Horde",
      zone="Frostwall",
      worldmap="585:5140:6200"
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
      id=88223,
      type="vendor",
      faction="Neutral",
      zone="Lunarfall",
      worldmap="582:3850:3140"
    },
    items={
      {decorID=4403, source={type="vendor", itemID=248334}, requirements={quest={id=36404}}},
      {decorID=4404, source={type="vendor", itemID=248335}, requirements={quest={id=36202}}},
      {decorID=4485, source={type="vendor", itemID=248660}, requirements={quest={id=34192}}},
      {decorID=4486, source={type="vendor", itemID=248661}, requirements={quest={id=36592}}},
      {decorID=4816, source={type="vendor", itemID=248799}, requirements={quest={id=34586}}},
      {decorID=4844, source={type="vendor", itemID=248810}, requirements={quest={id=35176}}},
    }
  },

}
