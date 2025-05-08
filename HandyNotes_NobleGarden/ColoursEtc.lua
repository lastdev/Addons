local _, ns = ...

-- Gay / Gaudy / 60's Pop Art Colour Scheme
ns.colour = {}
ns.colour.prefix	= "\124cFF00CED1" -- DarkTurquoise (W3C)
ns.colour.highlight	= "\124cFFFF1493" -- Deep Pink (W3C)
ns.colour.achieveH	= "\124cFFFF8C00" -- Dark Orange (W3C)
ns.colour.achieveI	= "\124cFFFFD700" -- Gold (W3C)
ns.colour.achieveD	= "\124cFFFFFF00" -- Yellow (W3C)
ns.colour.seasonal	= "\124cFF7CFC00" -- LawnGreen (W3C)
ns.colour.daily		= "\124cFF00BFFF" -- Deep Sky Blue (W3C)
ns.colour.Guide		= "\124cFF00FFFF" -- Cyan or Aqua (W3C)
ns.colour.plaintext = "\124cFF20B2AA" -- LightSeaGreen (W3C)
ns.colour.completeR	= "\124cFFFF0000" -- Red (W3C)
ns.colour.completeG	= "\124cFF00FF00" -- Green (W3C)

_, _, _, ns.version = GetBuildInfo()
ns.preAchievements = ( ns.version < 30000 ) and true or false -- Didn't have achievements prior to WotLK

ns.questTypes = { "Seasonal", "Daily", "One Time", }
ns.questTypesDB = { "removeSeasonal", "removeDailies", "removeOneTime", }
-- One Time quests are so uncommon in seasonal events that it's silly to waste a good colour that will rarely be used
ns.questColours = { ns.colour.seasonal, ns.colour.daily, ns.colour.seasonal, }
