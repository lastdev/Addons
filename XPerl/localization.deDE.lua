-- X-Perl UnitFrames
-- Author: Zek <Boodhoof-EU>
-- License: GNU GPL v3, 29 June 2007 (see LICENSE.txt)

if (GetLocale() == "deDE") then
	XPerl_LongDescription	= "UnitFrame Alternative f\195\188r ein neues Aussehen von Spieler, Begleiter, Gruppe, Ziel, Ziel des Ziels, Fokus und Schlachtzug"

	XPERL_MINIMAP_HELP1		= "|c00FFFFFFLinks-Klick|r, f\195\188r die Optionen (und zum |c0000FF00Entsperren der Fenster|r)"
	XPERL_MINIMAP_HELP2		= "|c00FFFFFFRechts-Klick|r, um das Symbol zu verschieben"
	XPERL_MINIMAP_HELP3		= "\rTats\195\164chliche Schlachtzugsmitglieder: |c00FFFF80%d|r\rTats\195\164chliche Gruppenmitglieder: |c00FFFF80%d|r"
	XPERL_MINIMAP_HELP4		= "\rDu bist der tats\195\164chliche Gruppen- oder Schlachtzugsleiter"
	XPERL_MINIMAP_HELP5		= "|c00FFFFFFAlt|r, f\195\188r die X-Perl Speicherausnutzung"
	XPERL_MINIMAP_HELP6		= "|c00FFFFFF+Umschalt|r, f\195\188r die X-Perl Speicherausnutzung seit dem Start"

	XPERL_MINIMENU_OPTIONS			= MAIN_MENU
	XPERL_MINIMENU_ASSIST			= "Zeige Assistiert-Frame"
	XPERL_MINIMENU_CASTMON			= "Zeige Casting-Monitor"
	XPERL_MINIMENU_RAIDAD			= "Zeige Schlachtzugs-Admin"
	XPERL_MINIMENU_ITEMCHK			= "Zeige Gegenstands-Checker"
	XPERL_MINIMENU_RAIDBUFF 		= "Schlachtzugsbuffs"
	XPERL_MINIMENU_ROSTERTEXT 		= "Listen-Text"
	XPERL_MINIMENU_RAIDSORT 		= "Sortierung des Schlachtzugs"
	XPERL_MINIMENU_RAIDSORT_GROUP 	= "Nach Gruppe sortieren"
	XPERL_MINIMENU_RAIDSORT_CLASS 	= "Nach Klasse sortieren"
	
	XPERL_TYPE_NOT_SPECIFIED		= "Nicht spezifiziert"
	XPERL_TYPE_PET					= PET			-- "Begleiter"
	XPERL_TYPE_BOSS 				= BOSS
	XPERL_TYPE_RAREPLUS 			= "Rar+"
	XPERL_TYPE_ELITE				= ELITE
	XPERL_TYPE_RARE 				= "Rar"

-- Zones
	XPERL_LOC_ZONE_SERPENTSHRINE_CAVERN 	= "H\195\182hle des Schlangenschreins"
	XPERL_LOC_ZONE_BLACK_TEMPLE 			= "Der Schwarze Tempel"
	XPERL_LOC_ZONE_HYJAL_SUMMIT 			= "Hyjalgipfel"
	XPERL_LOC_ZONE_KARAZHAN 				= "Karazhan"
	XPERL_LOC_ZONE_SUNWELL_PLATEAU 			= "Sonnenbrunnenplateau"
	XPERL_LOC_ZONE_NAXXRAMAS 				= "Naxxramas"
	XPERL_LOC_ZONE_OBSIDIAN_SANCTUM 		= "Das Obsidiansanktum"
	XPERL_LOC_ZONE_EYE_OF_ETERNITY 			= "Das Auge der Ewigkeit"
	XPERL_LOC_ZONE_ULDUAR 					= "Ulduar"
	XPERL_LOC_ZONE_TRIAL_OF_THE_CRUSADER 	= "Pr\195\188fung des Kreuzfahrers"
	XPERL_LOC_ZONE_ICECROWN_CITADEL 		= "Eiskronenzitadelle"
	XPERL_LOC_ZONE_RUBY_SANCTUM 			= "Das Rubinsanktum"

-- Status
	XPERL_LOC_DEAD			= DEAD			-- "Tot"
	XPERL_LOC_GHOST 		= "Geist"
	XPERL_LOC_FEIGNDEATH	= "Totstellen"
	XPERL_LOC_OFFLINE		= PLAYER_OFFLINE	-- "Offline"
	XPERL_LOC_RESURRECTED	= "Wiederbelebung"
	XPERL_LOC_SS_AVAILABLE	= "SS verf\195\188gbar"
	XPERL_LOC_UPDATING		= "Aktualisierung"
	XPERL_LOC_ACCEPTEDRES	= "Akzeptiert"		-- Wiederbelebung akzeptiert
	XPERL_RAID_GROUP		= "Gruppe %d"
	XPERL_RAID_GROUPSHORT	= "G%d"

	XPERL_LOC_NONEWATCHED	= "nicht beobachtet"

	XPERL_LOC_STATUSTIP 	= "Status Hervorhebungen: " 	-- Tooltip explanation of status highlight on unit
	XPERL_LOC_STATUSTIPLIST = {
		HOT = "Heilung \195\188ber Zeit",
		AGGRO = "Aggro",
		MISSING = "Dein Klassenbuff fehlt",
		HEAL = "Wird geheilt",
		SHIELD = SHIELDSLOT
	}

	XPERL_OK							= "OK"
	XPERL_CANCEL						= "Abbrechen"

	XPERL_LOC_LARGENUMDIV				= 1000
	XPERL_LOC_LARGENUMTAG				= "K"
	XPERL_LOC_HUGENUMDIV				= 1000000
	XPERL_LOC_HUGENUMTAG				= "M"

	BINDING_HEADER_XPERL 				= XPerl_ProductName
	BINDING_NAME_TOGGLERAID 			= "Schalter f\195\188r die Schlachtzugsfenster"
	BINDING_NAME_TOGGLERAIDSORT 		= "Schalter f\195\188r Schlachtzug sortieren nach Klasse/Gruppe"
	BINDING_NAME_TOGGLERAIDPETS 		= "Schalter f\195\188r Schlachtzugsbegleiter"
	BINDING_NAME_TOGGLEOPTIONS 			= "Schalter f\195\188r das Optionenfenster"
	BINDING_NAME_TOGGLEBUFFTYPE 		= "Schalter f\195\188r Buffs/Debuffs/Keine"
	BINDING_NAME_TOGGLEBUFFCASTABLE 	= "Schalter f\195\188r Zauberbar/Heilbar"
	BINDING_NAME_TEAMSPEAKMONITOR 		= "Teamspeak Monitor"
	BINDING_NAME_TOGGLERANGEFINDER 		= "Schalter f\195\188r Reichweiten-Finder"

	XPERL_KEY_NOTICE_RAID_BUFFANY 		= "Alle Buffs/Debuffs anzeigen"
	XPERL_KEY_NOTICE_RAID_BUFFCURECAST 	= "Nur zauberbare/heilbare Buffs oder Debuffs anzeigen"
	XPERL_KEY_NOTICE_RAID_BUFFS 		= "Schlachtzug-Buffs anzeigen"
	XPERL_KEY_NOTICE_RAID_DEBUFFS 		= "Schlachtzug-Debuffs anzeigen"
	XPERL_KEY_NOTICE_RAID_NOBUFFS 		= "Keine Schlachtzug-Buffs anzeigen"

	XPERL_DRAGHINT1						= "|c00FFFFFFKlicken|r, zum Skalieren des Fensters"
	XPERL_DRAGHINT2						= "|c00FFFFFFUmschalt+Klick|r, zum Anpassen der Fenstergr\195\182\195\159e"

	-- Usage
	XPerlUsageNameList					= {XPerl = "Core", XPerl_Player = "Player", XPerl_PlayerPet = "Pet", XPerl_Target = "Target", XPerl_TargetTarget = "Target's Target", XPerl_Party = "Party", XPerl_PartyPet = "Party Pets", XPerl_RaidFrames = "Raid Frames", XPerl_RaidHelper = "Raid Helper", XPerl_RaidAdmin = "Raid Admin", XPerl_TeamSpeak = "TS Monitor", XPerl_RaidMonitor = "Raid Monitor", XPerl_RaidPets = "Raid Pets", XPerl_ArcaneBar = "Arcane Bar", XPerl_PlayerBuffs = "Player Buffs", XPerl_GrimReaper = "Grim Reaper"}
	XPERL_USAGE_MEMMAX					= "UI Max. Speicher: %d"
	XPERL_USAGE_MODULES 				= "Module: "
	XPERL_USAGE_NEWVERSION				= "*Neuere Version"
	XPERL_USAGE_AVAILABLE				= "%s |c00FFFFFF%s|r ist zum Download verf\195\188gbar"

	XPERL_CMD_MENU						= "menu"
	XPERL_CMD_OPTIONS					= "options"
	XPERL_CMD_LOCK						= "lock"
	XPERL_CMD_UNLOCK					= "unlock"
	XPERL_CMD_CONFIG					= "config"
	XPERL_CMD_LIST						= "list"
	XPERL_CMD_DELETE					= "delete"
	XPERL_CMD_HELP						= "|c00FFFF80Verwendung: |c00FFFFFF/xperl menu | lock | unlock | config list | config delete <realm> <name>"
	XPERL_CANNOT_DELETE_CURRENT 		= "Die aktuelle Konfiguration kann nicht gel\195\182scht werden"
	XPERL_CONFIG_DELETED				= "Konfiguration gel\195\182scht f\195\188r %s/%s"
	XPERL_CANNOT_FIND_DELETE_TARGET		= "Konfiguration kann nicht zum L\195\182schen gefunden werden (%s/%s)"
	XPERL_CANNOT_DELETE_BADARGS 		= "Bitte einen Realmnamen und Spielernamen angeben"
	XPERL_CONFIG_LIST					= "Konfigurationsliste:"
	XPERL_CONFIG_CURRENT				= " (Aktuell)"

	XPERL_RAID_TOOLTIP_WITHBUFF      	= "Mit Buff: (%s)"
	XPERL_RAID_TOOLTIP_WITHOUTBUFF   	= "Ohne Buff: (%s)"
	XPERL_RAID_TOOLTIP_BUFFEXPIRING		= "%s's %s schwindet in %s"	-- Name, buff name, time to expire

local isMOP = select(4, _G.GetBuildInfo()) >= 50000
 

if (not isMOP) then
-- Status highlight spells
XPERL_HIGHLIGHT_SPELLS = {
	hotSpells  = {
		[GetSpellInfo(774)] = 12,			-- Rejuvenation (old id 26982)
		[GetSpellInfo(8936)] = 6,			-- Regrowth (old id 26980)
		[GetSpellInfo(139)] = 12,			-- Renew (old id 25222)
	    [GetSpellInfo(48438)] = 7,			-- Wild Growth 
		[GetSpellInfo(33763)] = 8,			-- Lifebloom
		[GetSpellInfo(28880)] = 15,			-- Gift of the Naaru (Racial)
		[GetSpellInfo(61295)] = 15,			-- Riptide
	},
	pomSpells = {
		[GetSpellInfo(33076)] = 30			-- Prayer of Mending
	},
	shieldSpells = {
		[GetSpellInfo(17)] = 30,			-- Power Word: Shield
		[GetSpellInfo(76669)] = 6,			-- Illuminated Healing
		[GetSpellInfo(974)] = 600			-- Earth Shield	(old id 32594)
	},
	healSpells = {
		[GetSpellInfo(2061)] = 1.5,			-- Flash of Light (old id 25235)
		[GetSpellInfo(2060)] = 3,			-- Greater Heal (old id 25213)
		[GetSpellInfo(2050)] = 3,			-- Heal (old id 6064)
		[GetSpellInfo(5185)] = 3,			-- Healing Touch (old id 26979)
		[GetSpellInfo(8936)] = 1.5,			-- Regrowth (old id 26980)
		[GetSpellInfo(331)] = 3,			-- Healing Wave (old id 25396)
		[GetSpellInfo(8004)] = 1.5,			-- Lesser Healing Wave (old id 25420)
		[GetSpellInfo(19750)] = 1.5,		-- Flash Heal (old id 27137)
		[GetSpellInfo(635)] = 2.5,			-- Holy Light (old id 27136)
		[GetSpellInfo(50464)] = 3.0			-- Nourish
	},
	buffSpells = {
		PRIEST = {
			[GetSpellInfo(21532)] = true,	-- Power Word: Fortitude (old id 25389)
			[GetSpellInfo(39231)] = true	-- Prayer of Fortitude (old id 25392)
		},
	    DRUID = {
			[GetSpellInfo(1126)] = true		-- Mark of the Wild (old id 26990)
		},
	    MAGE = {
			[GetSpellInfo(1459)] = true		-- Arcane Intellect (old id 27126)
		},
	    PALADIN = {
			[GetSpellInfo(19740)] = true,	-- Blessing of Might
			[GetSpellInfo(20217)] = true	-- Blessing of Kings
		},
	},
	groupHealSpells = {
		[GetSpellInfo(596)] = 2.5,			-- Prayer of Healing (old id 25308)
		[GetSpellInfo(1064)] = 2.5,			-- Chain Heal
	},
}


-- Default spells for range checking in the healer visual out-of-range cues.
XPerl_DefaultRangeSpells = {
	DRUID	= {spell = GetSpellInfo(5185)},				-- Healing Touch
	PALADIN = {spell = GetSpellInfo(635)},				-- Holy Light
	PRIEST	= {spell = GetSpellInfo(2061)},				-- Flash Heal
	SHAMAN	= {spell = GetSpellInfo(331)},				-- Healing Wave
	MAGE	= {spell = GetSpellInfo(475)},				-- Remove Lesser Curse
	WARLOCK	= {spell = GetSpellInfo(5697)},				-- Underwater Breathing
	ANY		= {item = GetItemInfo(21991)}				-- Heavy Netherweave Bandage
}

-- Don't highlight these magical debuffs
XPerl_ArcaneExclusions = {
	[GetSpellInfo(63559)] = true,						-- Bind Life
	[GetSpellInfo(30451)] = true,						-- Arcane Blast (again) (old 42897)
	[GetSpellInfo(30108)] = true,						-- Unstable Affliction (old 30405)
	[GetSpellInfo(15822)] = true,						-- Dreamless Sleep
	[GetSpellInfo(24360)] = true,						-- Greater Dreamless Sleep
	[GetSpellInfo(28504)] = true,						-- Major Dreamless Sleep
	[GetSpellInfo(31257)] = true,						-- Chilled
	[GetSpellInfo(710)] = true,							-- Banish
	[GetSpellInfo(44836)] = true,						-- Also Banish !?
	[GetSpellInfo(24306)] = true,						-- Delusions of Jin'do
	[GetSpellInfo(46543)] = {ROGUE = true, WARRIOR = true},	-- Ignite Mana
	[GetSpellInfo(16567)] = {ROGUE = true, WARRIOR = true},	-- Tainted Mind
	[GetSpellInfo(39052)] = {ROGUE = true},				-- Sonic Burst
	[GetSpellInfo(41190)] = {ROGUE = true, WARRIOR = true}, -- Mind-numbing Poison
	[GetSpellInfo(25195)] = {ROGUE = true},				-- Curse of Tongues
	[GetSpellInfo(30129)] = true,						-- Charred Earth - Nightbane debuff, can't be cleansed, but shows as magic
	[GetSpellInfo(31651)] = {MAGE = true, WARLOCK = true, PRIEST = true},	-- Banshee Curse, Melee hit rating debuff
	[GetSpellInfo(38913)] = {ROGUE = true},				-- Silence
	[GetSpellInfo(31555)] = {ROGUE = true, WARRIOR = true}, -- Decayed Intellect
}
else

-- Status highlight spells
XPERL_HIGHLIGHT_SPELLS = {
	hotSpells  = {
		[GetSpellInfo(774)] = 12,			-- Rejuvenation (old id 26982)
		[GetSpellInfo(8936)] = 6,			-- Regrowth (old id 26980)
		[GetSpellInfo(139)] = 12,			-- Renew (old id 25222)
	    [GetSpellInfo(48438)] = 7,			-- Wild Growth 
		[GetSpellInfo(33763)] = 8,			-- Lifebloom
		[GetSpellInfo(28880)] = 15,			-- Gift of the Naaru (Racial)
		[GetSpellInfo(61295)] = 15,			-- Riptide
	},
	pomSpells = {
		[GetSpellInfo(33076)] = 30			-- Prayer of Mending
	},
	shieldSpells = {
		[GetSpellInfo(17)] = 30,			-- Power Word: Shield
		[GetSpellInfo(76669)] = 6,			-- Illuminated Healing
		[GetSpellInfo(974)] = 600			-- Earth Shield	(old id 32594)
	},
	healSpells = {
		[GetSpellInfo(2061)] = 1.5,			-- Flash of Light (old id 25235)
		[GetSpellInfo(2060)] = 3,			-- Greater Heal (old id 25213)
		[GetSpellInfo(2050)] = 3,			-- Heal (old id 6064)
		[GetSpellInfo(5185)] = 3,			-- Healing Touch (old id 26979)
		[GetSpellInfo(8936)] = 1.5,			-- Regrowth (old id 26980)
		[GetSpellInfo(331)] = 3,			-- Healing Wave (old id 25396)
		[GetSpellInfo(8004)] = 1.5,			-- Lesser Healing Wave (old id 25420)
		[GetSpellInfo(19750)] = 1.5,		-- Flash Heal (old id 27137)
		[GetSpellInfo(635)] = 2.5,			-- Holy Light (old id 27136)
		[GetSpellInfo(50464)] = 3.0			-- Nourish
	},
	buffSpells = {
		PRIEST = {
			[GetSpellInfo(21532)] = true	-- Power Word: Fortitude (old id 25389)
		},
	    DRUID = {
			[GetSpellInfo(1126)] = true		-- Mark of the Wild (old id 26990)
		},
	    MAGE = {
			[GetSpellInfo(1459)] = true		-- Arcane Intellect (old id 27126)
		},
	    PALADIN = {
			[GetSpellInfo(19740)] = true,	-- Blessing of Might
			[GetSpellInfo(20217)] = true	-- Blessing of Kings
		},
	},
	groupHealSpells = {
		[GetSpellInfo(596)] = 2.5,			-- Prayer of Healing (old id 25308)
		[GetSpellInfo(1064)] = 2.5,			-- Chain Heal
	},
}


-- Default spells for range checking in the healer visual out-of-range cues.
XPerl_DefaultRangeSpells = {
	DRUID	= {spell = GetSpellInfo(5185)},				-- Healing Touch
	PALADIN = {spell = GetSpellInfo(635)},				-- Holy Light
	PRIEST	= {spell = GetSpellInfo(2061)},				-- Flash Heal
	SHAMAN	= {spell = GetSpellInfo(331)},				-- Healing Wave
	MAGE	= {spell = GetSpellInfo(475)},				-- Remove Lesser Curse
	WARLOCK	= {spell = GetSpellInfo(5697)},				-- Underwater Breathing
	ANY		= {item = GetItemInfo(21991)}				-- Heavy Netherweave Bandage
}

-- Don't highlight these magical debuffs
XPerl_ArcaneExclusions = {
	[GetSpellInfo(63559)] = true,						-- Bind Life
	[GetSpellInfo(30451)] = true,						-- Arcane Blast (again) (old 42897)
	[GetSpellInfo(30108)] = true,						-- Unstable Affliction (old 30405)
	[GetSpellInfo(15822)] = true,						-- Dreamless Sleep
	[GetSpellInfo(24360)] = true,						-- Greater Dreamless Sleep
	[GetSpellInfo(28504)] = true,						-- Major Dreamless Sleep
	[GetSpellInfo(31257)] = true,						-- Chilled
	[GetSpellInfo(710)] = true,							-- Banish
	[GetSpellInfo(44836)] = true,						-- Also Banish !?
	[GetSpellInfo(24306)] = true,						-- Delusions of Jin'do
	[GetSpellInfo(46543)] = {ROGUE = true, WARRIOR = true},	-- Ignite Mana
	[GetSpellInfo(16567)] = {ROGUE = true, WARRIOR = true},	-- Tainted Mind
	[GetSpellInfo(39052)] = {ROGUE = true},				-- Sonic Burst
	[GetSpellInfo(41190)] = {ROGUE = true, WARRIOR = true}, -- Mind-numbing Poison
	[GetSpellInfo(25195)] = {ROGUE = true},				-- Curse of Tongues
	[GetSpellInfo(30129)] = true,						-- Charred Earth - Nightbane debuff, can't be cleansed, but shows as magic
	[GetSpellInfo(31651)] = {MAGE = true, WARLOCK = true, PRIEST = true},	-- Banshee Curse, Melee hit rating debuff
	[GetSpellInfo(38913)] = {ROGUE = true},				-- Silence
	[GetSpellInfo(31555)] = {ROGUE = true, WARRIOR = true}, -- Decayed Intellect
}

end

end