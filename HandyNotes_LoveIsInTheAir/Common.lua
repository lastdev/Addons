local _, ns = ...

ns.db = {}

_, _, _, ns.version = GetBuildInfo()
ns.preAchievements = ( ns.version < 30000 ) and true or false -- Didn't have achievements prior to WotLK

ns.questTypes = { "Seasonal", "Daily", "One Time", }
ns.questTypesDB = { "removeSeasonal", "removeDailies", "removeOneTime", }
-- One Time quests are so uncommon in seasonal events that it's silly to waste a good colour that will rarely be used
ns.questColours = { ns.colour.seasonal, ns.colour.daily, ns.colour.seasonal, }

ns.locale = GetLocale()

ns.realm = GetNormalizedRealmName() -- On a fresh login this will return null
ns.oceania = { AmanThul = true, Barthilas = true, Caelestrasz = true, DathRemar = true,
			Dreadmaul = true, Frostmourne = true, Gundrak = true, JubeiThos = true, 
			Khazgoroth = true, Nagrand = true, Saurfang = true, Thaurissan = true,
			-- The following are Classic Era 1.15.x
			Yojamba = true, Remulos = true, Arugal = true, Felstriker = true,
			-- The following are Classic Seasonal (SoD) 1.15.x
			Penance = true, Shadowstrike = true,
			-- Classic Anniversary from 1.15.5
			Maladath = true, }
if ns.oceania[ ns.realm ] then
	ns.locale = "enGB"
end

ns.name = UnitName( "player" ) or "Character"
ns.faction = UnitFactionGroup( "player" )