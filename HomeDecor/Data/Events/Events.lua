local ADDON, NS = ...

NS.Data = NS.Data or {}
NS.Data.Events = NS.Data.Events or {}

NS.Data.Events["Events"] = NS.Data.Events["Events"] or {}
NS.Data.Events["Events"]["New Events"] = {

  {
    title="Materialist Ophinell",
    endsOn="Mar-02",
    source={
      id=249196,
      type="vendor",
      faction="Neutral",
      zone="Twilight Highlands",
      worldmap="241:4960:8120"},
    items={
      {decorID=714,       source={type="vendor",  itemID=245284, currency="2000", currencytype="Honor"}},
      {decorID=1236,  source={type="vendor",  itemID=245330, currency="2000", currencytype="Honor"}},
      {decorID=1227,       source={type="vendor",  itemID=251997, currency="2000", currencytype="Honor"}}}
  },
 {
   title="Twitch Event!",
   endsOn="Feb-17",
   source={
     type="external",
     platform="twitch",
     label="Claim via Twitch event",
     url="https://twitch.tv/"},
   items={
     {decorID=15151,  source={type="external", itemID=263301}}}
  },
   {
   title="It's Nearly Midnight",
   endsOn="Mar-02",
   source={
     type="external",
     platform="twitch",
     label="These can be bought in Stormwind and Org",
     url="https://twitch.tv/"},
   items={
     {decorID=14467,  source={type="external", itemID=260785}}}}}
