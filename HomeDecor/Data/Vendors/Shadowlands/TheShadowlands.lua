local ADDON, NS = ...

NS.Data = NS.Data or {}
NS.Data.Vendors = NS.Data.Vendors or {}

NS.Data.Vendors["Shadowlands"] = NS.Data.Vendors["Shadowlands"] or {}

NS.Data.Vendors["Shadowlands"]["TheShadowlands"] = {

  {
    source={
      id=64032,
      type="vendor",
      faction="Alliance",
      zone="Vale of Eternal Blossoms",
      worldmap="1530:8520:6160"
    },
    items={
      {decorID=3869, source={type="vendor", itemID=247729, currency="240", currencytype="gold"}, requirements={quest={id=31230}}},
      {decorID=15605, source={type="vendor", itemID=264362, currency="500", currencytype="gold"}},
    }
  },

  {
    source={
      id=162804,
      type="vendor",
      faction="Alliance",
      zone="The Maw",
      worldmap="1543:4680:4160"
    },
    items={
      {decorID=4181, source={type="vendor", itemID=248125, currency="10000", currencytype=1767}, requirements={achievement={id=20501}}},
    }
  },

  {
    source={
      id=174710,
      type="vendor",
      faction="Neutral",
      zone="Sinfall",
      worldmap="1699:5400:2480"
    },
    items={
      {decorID=756, source={type="vendor", itemID=245501, currency="1500", currencytype=1813}, requirements={rep="true"}},
    }
  },

}
