local ADDON, NS = ...

NS.Data = NS.Data or {}
NS.Data.Vendors = NS.Data.Vendors or {}

NS.Data.Vendors["BurningCrusade"] = NS.Data.Vendors["BurningCrusade"] or {}

NS.Data.Vendors["BurningCrusade"]["Outland"] = {

  {
    source={
      id=16528,
      type="vendor",
      faction="Horde",
      zone="Ghostlands",
      worldmap="95:4760:3240"
    },
    items={
      {decorID=10950, source={type="vendor", itemID=256049, currency="5000", currencytype="gold"}, requirements={rep="true"}},
      {decorID=11500, source={type="vendor", itemID=257419, currency="5000", currencytype="gold"}, requirements={rep="true"}},
    }
  },

  {
    source={
      id=68363,
      type="vendor",
      faction="Alliance",
      zone="Bizmo's Brawlpub",
      worldmap="499:5100:3000"
    },
    items={
      {decorID=10913, source={type="vendor", itemID=255840, currency="8000", currencytype="gold"}},
      {decorID=12263, source={type="vendor", itemID=259071, currency="4000", currencytype="gold"}},
      {decorID=14815, source={type="vendor", itemID=263026, currency="500", currencytype="gold"}},
    }
  },

  {
    source={
      id=68364,
      type="vendor",
      faction="Horde",
      zone="Brawl'gar Arena",
      worldmap="503:5200:2780"
    },
    items={
      {decorID=10913, source={type="vendor", itemID=255840, currency="8000", currencytype="gold"}},
      {decorID=12263, source={type="vendor", itemID=259071, currency="4000", currencytype="gold"}},
      {decorID=14815, source={type="vendor", itemID=263026, currency="500", currencytype="gold"}},
    }
  },

  {
    source={
      id=145695,
      type="vendor",
      faction="Neutral",
      zone="Brawl'gar Arena",
      worldmap="503:5084:2913"
    },
    items={
      {decorID=10913, source={type="vendor", itemID=255840, currency="8000", currencytype="gold"}},
      {decorID=12263, source={type="vendor", itemID=259071, currency="4000", currencytype="gold"}},
      {decorID=14815, source={type="vendor", itemID=263026, currency="500", currencytype="gold"}},
    }
  },

  {
    source={
      id=151941,
      type="vendor",
      faction="Neutral",
      zone="Deeprun Tram",
      worldmap="500:5425:2513"
    },
    items={
      {decorID=10913, source={type="vendor", itemID=255840, currency="8000", currencytype="gold"}},
      {decorID=12263, source={type="vendor", itemID=259071, currency="4000", currencytype="gold"}},
      {decorID=14815, source={type="vendor", itemID=263026, currency="500", currencytype="gold"}},
    }
  },

}
