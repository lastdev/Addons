-- For translations visit:  /  Per le traduzioni vai a:
-- http://wow.curseforge.com/addons/gogomount/localization/itIT/

if GetLocale() == "itIT" then
	BINDING_HEADER_GOGOHEADER = "GoGoMount"
	BINDING_NAME_GOGOBINDING = "Montare / Smontare" -- Needs review
	BINDING_NAME_GOGOBINDING2 = "Montare / Smontare (senza volo)" -- Needs review
	BINDING_NAME_GOGOBINDING3 = "Montare / Smontare Monti passeggeri" -- Needs review
	GoGo_Variables.Localize = {
	Skill = {
		Engineering = "Engineering", -- Requires localization
		Riding = "Riding", -- Requires localization
		Tailoring = "Tailoring", -- Requires localization
	},
	String = {
		AutomaticallyRemoveBuffs = "Automatically remove buffs that prevent mounting", -- Requires localization
		AutoStartCrusaderAura = "Auto start Crusader Aura", -- Requires localization
		AutoStartCrusaderAura_Long = "Automatically start Crusader Aura when using GoGoMount to mount.", -- Requires localization
		Clear = "Clear", -- Requires localization
		ClearGlobalFavoriteMounts = "Clear global favorite mounts", -- Requires localization
		CurrentZone = "Current Zone", -- Requires localization
		CurrentZoneDescription = "Mounts flagged here as zone favorites will be the only mounts GoGoMount will use in this zone.  All other mounts and shape forms will be ignored.  Clearing this list will allow GoGoMount to use all mounts (or global favorites if set).", -- Requires localization
		CurrentZoneExclusions = "Current Zone Exclusions", -- Requires localization
		CurrentZoneFavorites = "Current Zone Favorites", -- Requires localization
		DisableFlyingFromWater = "Disable flying from water", -- Requires localization
		DisableInCombat = "Disable GoGoMount buttons in combat", -- Requires localization
		DisableInCombat_Long = "This option disables GoGoMount buttons while in combat.  Useful for Druids who tank in bear form and accidently press their GoGoMount buttons.  Must be enabled or disabled before entering combat.", -- Requires localization
		DisableUnknownMountNotices = "Disable unknown mount notices", -- Requires localization
		DisableUpdateNotices = "Disable update notices", -- Requires localization
		DruidFlightPreference = "Always use flight forms instead of when moving only", -- Requires localization
		DruidOptions = "Druid Options", -- Requires localization
		DruidSingleClick = "Single click to shift from form to travel forms", -- Requires localization
		EnableAutoDismount = "Enable automatic dismount", -- Requires localization
		Favorites = "Favorites", -- Requires localization
		GlobalExclusions = "Global Exclusions", -- Requires localization
		GlobalExclusionsDescription = "Mounts will always be ignored.  Even if mounts selected here are set as favorites, they will not be used.", -- Requires localization
		GlobalFavorites = "Global Favorites", -- Requires localization
		GlobalPreferences = "Global Preferences", -- Requires localization
		GlobalZoneDescription = "Preferred mounts defined here will only take effect if there are no zone specific mount favorites set for the current zone you are in.", -- Requires localization
		HunterOptions = "Hunter Options", -- Requires localization
		NewVersionFound = "A newer version of GoGoMount is available.", -- Requires localization
		NoShapeInRandom = "Do not randomize shape forms with mounts", -- Requires localization
		PaladinOptions = "Paladin Options", -- Requires localization
		RemoveBuffs = "Remove buffs that can prevent mounting", -- Requires localization
		RemoveBuffs_Long = "GoGoMount will attempt to remove buffs and shapeforms that come from spells and items that prevent mounting.  This only works for known buffs and in some cases require 2 clicks of your GoGoMount button to mount.", -- Requires localization
		UnknownMountFound = "An unknown mount has been found in you list of mounts.  Please report this so that it can be added to future versions of GoGoMount.", -- Requires localization
		UseAspectOfThePackInstead = "Use Aspect Of The Pack instead of Aspect Of The Cheeta", -- Requires localization
		UseAspectOfThePackInstead_Long = "When enabled, GoGoMount will cast Aspect of the Pack instead of Aspect of the Cheetah.  Local zone or global settings override this setting.  If this is set to use Aspect of the Pack and you have Aspect of the Cheetah as a zone favorite, Aspect of the Cheetah will be used.", -- Requires localization
		ZoneExclusionsDescription = "Zone specific exclusions work the same as global exclusions but specific to this zone.  Any mount marked below as an exclusion for the zone you're currently in will never be summoned.", -- Requires localization
	},
	Talent = {
		AncestralSwiftness = "Ancestral Swiftness", -- Requires localization
		FeralSwiftness = "Feral Swiftness", -- Requires localization
	},
	Zone = {
		AbyssalDepths = "Abyssal Depths", -- Requires localization
		AmaniMountains = "Amani Mountains", -- Requires localization
		AQ40 = "Ahn'Qiraj", -- Requires localization
		AzuremystIsle = "Azuremyst Isle", -- Requires localization
		BloodmystIsle = "Bloodmyst Isle", -- Requires localization
		CrumblingDepths = "Crumbling Depths", -- Requires localization
		Dalaran = "Dalaran", -- Requires localization
		DarkbreakCove = "Darkbreak Cove", -- Requires localization
		Deepholm = "Deepholm", -- Requires localization
		DireMaul = "Dire Maul", -- Requires localization
		EversongWoods = "Eversong Woods", -- Requires localization
		Ghostlands = "Ghostlands", -- Requires localization
		Icecrown = "Icecrown", -- Requires localization
		Ironforge = "Ironforge", -- Requires localization
		IsleOfQuelDanas = "Isle of Quel'Danas", -- Requires localization
		KrasusLanding = "Krasus' Landing", -- Requires localization
		LegionsRest = "Legion's Rest", -- Requires localization
		Lghorek = "L'ghorek", -- Requires localization
		Nespirah = "Nespirah", -- Requires localization
		ShimmeringExpanse = "Shimmering Expanse", -- Requires localization
		SholazarBasin = "Sholazar Basin", -- Requires localization
		SilvermoonCity = "Silvermoon City", -- Requires localization
		SilverTideHollow = "Silver Tide Hollow", -- Requires localization
		TempleOfBethekk = "Temple of Bethekk", -- Requires localization
		TempleOfEarth = "Temple of Earth", -- Requires localization
		TenebrousCavern = "Tenebrous Cavern", -- Requires localization
		ThalassianPass = "Thalassian Pass", -- Requires localization
		ThalassianRange = "Thalassian Range", -- Requires localization
		TheCerebrillum = "The Cerebrillum", -- Requires localization
		TheExodar = "The Exodar", -- Requires localization
		TheFrozenSea = "The Frozen Sea", -- Requires localization
		TheOculus = "The Oculus", -- Requires localization
		TheStormPeaks = "The Storm Peaks", -- Requires localization
		TheTempleOfAtalHakkar = "The Temple of Atal'Hakkar", -- Requires localization
		TheUnderbelly = "The Underbelly", -- Requires localization
		TheVioletCitadel = "The Violet Citadel", -- Requires localization
		TheVortexPinnacle = "The Vortex Pinnacle", -- Requires localization
		TolBarad = "Tol Barad", -- Requires localization
		TolBaradPeninsula = "Tol Barad Peninsula", -- Requires localization
		TwistingNether = "Twisting Nether", -- Requires localization
		Vashjir = "Vashj'ir", -- Requires localization
		Wintergrasp = "Wintergrasp", -- Requires localization
	},
}

end --if