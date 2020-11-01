local _, addon = ...
select(2, ...).TomCatsLibs.Data["Links"] = {
    ["redChapter"] = { type = "gotoPage", chapter = 2, page = 1 },
    ["greenChapter"] = { type = "gotoPage", chapter = 3, page = 1 },
    ["Griftah"] = { type = "coordinates", mapID = 111, x = 0.65654307603836, y = 0.69248735904694 },
    ["Ol' Fishbreath"] = { type = "coordinates", mapID = 201, x = 0.59992009401321, y = 0.58672666549683 },
    ["Sir Finley Mrrgglton"] = { type = "coordinates", mapID = 205, x = 0.44590544700623, y = 0.20201343297958 },
    ["Manta Stargazer"] = { type = "coordinates", mapID = 205, x = 0.53977417945862, y = 0.24080747365952 },
    ["Lil' Whaley"] = { type = "coordinates", mapID = 205, x = 0.6975103020668, y = 0.47128921747208 },
    ["Crimson Angerfish"] = { type = "coordinates", mapID = 205, x = 0.53064024448395, y = 0.88902056217194 },
    ["Little Carp"] = { type = "coordinates", mapID = 204, x = 0.45455116033554, y = 0.17670238018036 },
    ["Gloomy Bluefin"] = { type = "coordinates", mapID = 204, x = 0.65145707130432, y = 0.42147547006607 },
    ["Volatile Violetscale"] = { type = "coordinates", mapID = 204, x = 0.38734519481659, y = 0.78901195526123 },
    ["The Blackfish"] = { type = "coordinates", mapID = 204, x = 0.16037803888321, y = 0.82712185382843 },
}

select(2, ...).TomCatsLibs.Data["MapNames"] = {
    [111] = "Shattrath City / Outland",
    [201] = "Kep'thar Forest",
    [205] = "Shimmering Expanse",
    [204] = "Abyssal Depths",
}
