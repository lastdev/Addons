HEALBOT_VERSION   = "5.4.7.2";
HEALBOT_ABOUT_URL = "http://healbot.darktech.org/"
HEALBOT_2MOONS_URL = "http://freegames.darktech.org/twomoons/uni1/index.php"

function HealBot_globalVars()
    --Harmful Spells
    --Priest
	HEALBOT_MINDBENDER                      = GetSpellInfo(123040) or "--Mindbender"
    HEALBOT_SMITE                           = GetSpellInfo(585) or "--Smite"
    HEALBOT_HOLY_FIRE                       = GetSpellInfo(14914) or "--Holy Fire"
    HEALBOT_SHADOW_WORD_PAIN                = GetSpellInfo(589) or "--Shadow Word: Pain"
    HEALBOT_SHADOW_WORD_DEATH               = GetSpellInfo(32379) or "--Shadow Word: Death"
    HEALBOT_DISPEL_MAGIC                    = GetSpellInfo(528) or "--Dispel Magic"
    HEALBOT_DOMINATE_MIND                   = GetSpellInfo(605) or "--Dominate Mind"
    HEALBOT_MIND_SEAR                       = GetSpellInfo(48045) or "--Mind Sear"
    HEALBOT_SHACKLE_UNDEAD                  = GetSpellInfo(9484) or "--Shackle Undead"    
    --Druid
	HEALBOT_WRATH                           = GetSpellInfo(5176)  or "--Wrath"
    HEALBOT_HURRICANE                       = GetSpellInfo(16914)  or "--Hurricane"
    HEALBOT_FAERIE_FIRE                     = GetSpellInfo(770)  or "--Faerie Fire"
    HEALBOT_ENTANGLING_ROOTS                = GetSpellInfo(339)  or "--Entangling Roots"
    HEALBOT_FAERIE_SWARM                    = GetSpellInfo(106707) or "--Faerie Swarm"
    HEALBOT_MOONFIRE                        = GetSpellInfo(8921) or "--Moonfire"
    HEALBOT_GROWL                           = GetSpellInfo(6795) or "--Growl"
    HEALBOT_SOOTHE                          = GetSpellInfo(2908) or "--Soothe"
    HEALBOT_MASS_ENTANGLEMENT               = GetSpellInfo(102359) or "--Mass Entanglement"
    HEALBOT_CYCLONE                         = GetSpellInfo(33786) or "--Cyclone"   
    --Monk
	HEALBOT_JAB                             = GetSpellInfo(100780) or "--Jab"
    HEALBOT_TIGER_PALM                      = GetSpellInfo(100787) or "--Tiger Palm"
    HEALBOT_CHI_BURST                       = GetSpellInfo(123986) or "--Chi Burst"
    HEALBOT_BLACKOUT_KICK                   = GetSpellInfo(100784) or "--Blackout Kick"
    HEALBOT_PROVOKE                         = GetSpellInfo(115546) or "--Provoke"
    HEALBOT_TOUCH_OF_DEATH                  = GetSpellInfo(115080) or "--Touch of Death"
    HEALBOT_DISABLE                         = GetSpellInfo(116095) or "--Disable"
    HEALBOT_SPEAR_HAND_STRIKE               = GetSpellInfo(116705) or "--Spear Hand Strike"
    HEALBOT_PARALYSIS                       = GetSpellInfo(115078) or "--Paralysis"
    HEALBOT_CRACKLING_JADE_LIGHTNING        = GetSpellInfo(117952) or "--Crackling Jade Lightning"
    HEALBOT_GRAPPLE_WEAPON                  = GetSpellInfo(117368) or "--Grapple Weapon"    
    --Paladin
	HEALBOT_REBUKE                          = GetSpellInfo(96231) or "--Rebuke"
    HEALBOT_JUDGMENT                        = GetSpellInfo(20271) or "--Judgment"
    HEALBOT_CRUSADER_STRIKE                 = GetSpellInfo(35395) or "--Crusader Strike"
    HEALBOT_DENOUNCE                        = GetSpellInfo(2812) or "--Denounce"
    HEALBOT_HAMMER_OF_JUSTICE               = GetSpellInfo(853) or "--Hammer of Justice"
    HEALBOT_HAMMER_OF_WRATH                 = GetSpellInfo(24275) or "--Hammer of Wrath"
    HEALBOT_HOLY_SHOCK                      = GetSpellInfo(20473) or "--Holy Shock"
    HEALBOT_RECKONING                       = GetSpellInfo(62124) or "--Reckoning"
    HEALBOT_REPENTANCE                      = GetSpellInfo(20066) or "--Repentance"
    HEALBOT_TURN_EVIL                       = GetSpellInfo(10326) or "--Turn Evil"   
    --Shaman
	HEALBOT_CHAIN_LIGHTNING                 = GetSpellInfo(421) or "--Chain Lightning"
    HEALBOT_LIGHTNING_BOLT                  = GetSpellInfo(403) or "--Lightning Bolt"
    HEALBOT_EARTH_SHOCK                     = GetSpellInfo(8042) or "--Earth Shock"
    HEALBOT_FLAME_SHOCK                     = GetSpellInfo(8050) or "--Flame Shock"
    HEALBOT_FROST_SHOCK                     = GetSpellInfo(8056) or "--Frost Shock"
    HEALBOT_BIND_ELEMENTAL                  = GetSpellInfo(76780) or "--Bind Elemental"
    HEALBOT_HEX                             = GetSpellInfo(51514) or "--Hex"
    HEALBOT_LAVA_BLAST                      = GetSpellInfo(51505) or "--Lava Blast"
    HEALBOT_PRIMAL_STRIKE                   = GetSpellInfo(73899) or "--Primal Strike"
    HEALBOT_PURGE                           = GetSpellInfo(370) or "--Purge"
    HEALBOT_WIND_SHEAR                      = GetSpellInfo(57994) or "--Wind Shear"   
    --Mage
	HEALBOT_MAGE_BOMB                       = GetSpellInfo(125430) or "--Mage Bomb"
    HEALBOT_FROSTFIRE_BOLT                  = GetSpellInfo(44614) or "--Frostfire Bolt"
    HEALBOT_FIRE_BLAST                      = GetSpellInfo(2136) or "--Fire Blast"  
	--Hunter
	HEALBOT_CONCUSSIVE_SHOT                 = GetSpellInfo(5116) or "--Concussive Shot"
    HEALBOT_ARCANE_SHOT                     = GetSpellInfo(3044) or "--Arcane Shot"   
	--Death Knight
	HEALBOT_PLAGUE_STRIKE                   = GetSpellInfo(45462) or "--Plague Strike"
    HEALBOT_DEATH_COIL                      = GetSpellInfo(47541) or "--Death Coil"   
	--Rogue
	HEALBOT_GOUGE                           = GetSpellInfo(1776) or "--Gouge"
    HEALBOT_THROW                           = GetSpellInfo(121733) or "--Throw"   
	--Warlock
	HEALBOT_FEAR                            = GetSpellInfo(5782) or "--Fear"
	HEALBOT_CORRUPTION                      = GetSpellInfo(172) or "--Corruption"    
	--Warrior
	HEALBOT_EXECUTE                         = GetSpellInfo(5308) or "--Execute"
    HEALBOT_TAUNT                           = GetSpellInfo(355) or "--Taunt"    
   
	
	--Consumables
    --Bandages 
    HEALBOT_LINEN_BANDAGE                   = GetItemInfo(1251) or "--Linen Bandage";
	HEALBOT_HEAVY_LINEN_BANDAGE             = GetItemInfo(2581) or "--Heavy Linen Bandage";
	HEALBOT_SILK_BANDAGE                    = GetItemInfo(6450) or "--Silk Bandage";
    HEALBOT_HEAVY_SILK_BANDAGE              = GetItemInfo(6451) or "--Heavy Silk Bandage";
    HEALBOT_MAGEWEAVE_BANDAGE               = GetItemInfo(8544) or "--Mageweave Bandage";
    HEALBOT_HEAVY_MAGEWEAVE_BANDAGE         = GetItemInfo(8545) or "--Heavy Mageweave Bandage";
    HEALBOT_RUNECLOTH_BANDAGE               = GetItemInfo(14529) or "--Runecloth Bandage";
    HEALBOT_HEAVY_RUNECLOTH_BANDAGE         = GetItemInfo(14530) or "--Heavy Runecloth Bandage";
    HEALBOT_NETHERWEAVE_BANDAGE             = GetItemInfo(21990) or "--Netherweave Bandage";
    HEALBOT_HEAVY_NETHERWEAVE_BANDAGE       = GetItemInfo(21991) or "--Heavy Netherweave Bandage";
    HEALBOT_FROSTWEAVE_BANDAGE              = GetItemInfo(34721) or "--Frostweave Bandage";
    HEALBOT_HEAVY_FROSTWEAVE_BANDAGE        = GetItemInfo(34722) or "--Heavy Frostweave Bandage";
    HEALBOT_EMBERSILK_BANDAGE               = GetItemInfo(53049) or "--Embersilk Bandage";
    HEALBOT_DENSE_EMBERSILK_BANDAGE         = GetItemInfo(53051) or "--Dense Embersilk Bandage";
	HEALBOT_WINDWOOL_BANDAGE                = GetItemInfo(72985) or "--Windwool Bandage";
	HEALBOT_HEAVY_WINDWOOL_BANDAGE          = GetItemInfo(72986) or "--Heavy Windwool Bandage";    
	--Potions
	HEALBOT_MAJOR_HEALING_POTION            = GetItemInfo(13446) or "--Major Healing Potion";
    HEALBOT_SUPER_HEALING_POTION            = GetItemInfo(22829) or "--Super Healing Potion";
    HEALBOT_MAJOR_COMBAT_HEALING_POTION     = GetItemInfo(31838) or "--Major Combat Healing Potion";
    HEALBOT_RUNIC_HEALING_POTION            = GetItemInfo(33447) or "--Runic Healing Potion";
    HEALBOT_ENDLESS_HEALING_POTION          = GetItemInfo(43569) or "--Endless Healing Potion";   
    HEALBOT_MAJOR_MANA_POTION               = GetItemInfo(13444) or "--Major Mana Potion";
    HEALBOT_SUPER_MANA_POTION               = GetItemInfo(22832) or "--Super Mana Potion";
    HEALBOT_MAJOR_COMBAT_MANA_POTION        = GetItemInfo(31840) or "--Major Combat Mana Potion";
    HEALBOT_RUNIC_MANA_POTION               = GetItemInfo(33448) or "--Runic Mana Potion";
    HEALBOT_ENDLESS_MANA_POTION             = GetItemInfo(43570) or "--Endless Mana Potion";
    HEALBOT_PURIFICATION_POTION             = GetItemInfo(13462) or "--Purification Potion";
    HEALBOT_ANTI_VENOM                      = GetItemInfo(6452) or "--Anti-Venom";
    HEALBOT_POWERFUL_ANTI_VENOM             = GetItemInfo(19440) or "--Powerful Anti-Venom";
    HEALBOT_ELIXIR_OF_POISON_RES            = GetItemInfo(3386) or "--Potion of Curing";

    
	--Racial Abilities
    HEALBOT_STONEFORM                       = GetSpellInfo(20594) or "--Stoneform";
	HEALBOT_DARKFLIGHT                      = GetSpellInfo(68992) or "--Darkflight";
    HEALBOT_GIFT_OF_THE_NAARU               = GetSpellInfo(59547) or "--Gift of the Naaru";
    

    --Healing Spells By Class 
    --Druid
	HEALBOT_REJUVENATION                    = GetSpellInfo(774) or "--Rejuvenation";
    HEALBOT_LIFEBLOOM                       = GetSpellInfo(33763) or "--Lifebloom";
    HEALBOT_WILD_GROWTH                     = GetSpellInfo(48438) or "--Wild Growth";
    HEALBOT_TRANQUILITY                     = GetSpellInfo(740) or "--Tranquility";
    HEALBOT_SWIFTMEND                       = GetSpellInfo(18562) or "--Swiftmend";
    HEALBOT_REGROWTH                        = GetSpellInfo(8936) or "--Regrowth";
    HEALBOT_HEALING_TOUCH                   = GetSpellInfo(5185) or "--Healing Touch";
    HEALBOT_NOURISH                         = GetSpellInfo(50464) or "--Nourish";
    HEALBOT_CENARION_WARD                   = GetSpellInfo(102351) or "--Cenarion Ward";
    --Paladin
	HEALBOT_FLASH_OF_LIGHT                  = GetSpellInfo(19750) or "--Flash of Light";
    HEALBOT_WORD_OF_GLORY                   = GetSpellInfo(85673) or "--Word of Glory";
    HEALBOT_LIGHT_OF_DAWN                   = GetSpellInfo(85222) or "--Light of Dawn";
    HEALBOT_HOLY_LIGHT                      = GetSpellInfo(635) or "--Holy Light";
    HEALBOT_DIVINE_LIGHT                    = GetSpellInfo(82326) or "--Divine Light";
    HEALBOT_HOLY_RADIANCE                   = GetSpellInfo(82327) or "--Holy Radiance";
    HEALBOT_HOLY_PRISM                      = GetSpellInfo(114165) or "--Holy Prism";
    --Priest
	HEALBOT_GREATER_HEAL                    = GetSpellInfo(2060) or "--Greater Heal";
    HEALBOT_BINDING_HEAL                    = GetSpellInfo(32546) or "--Binding Heal"
    HEALBOT_PENANCE                         = GetSpellInfo(47540) or "--Penance"
    HEALBOT_PRAYER_OF_MENDING               = GetSpellInfo(33076) or "--Prayer of Mending";
    HEALBOT_FLASH_HEAL                      = GetSpellInfo(2061) or "--Flash Heal";
    HEALBOT_VOID_SHIFT                      = GetSpellInfo(108968) or "--Void Shift";
    HEALBOT_HEAL                            = GetSpellInfo(2050) or "--Heal";
    HEALBOT_DIVINE_HYMN                     = GetSpellInfo(64843) or "--Divine Hymn";
    HEALBOT_RENEW                           = GetSpellInfo(139) or "--Renew";
    HEALBOT_DESPERATE_PRAYER                = GetSpellInfo(19236) or "--Desperate Prayer";
    HEALBOT_PRAYER_OF_HEALING               = GetSpellInfo(596) or "--Prayer of Healing";
    HEALBOT_CIRCLE_OF_HEALING               = GetSpellInfo(34861) or "--Circle of Healing";
    HEALBOT_HOLY_WORD_CHASTISE              = GetSpellInfo(88625) or "--Holy Word: Chastise";
    HEALBOT_HOLY_WORD_SERENITY              = GetSpellInfo(88684) or "--Holy Word: Serenity";
    HEALBOT_HOLY_WORD_SANCTUARY             = GetSpellInfo(88685) or "--Holy Word: Sanctuary"; 
    HEALBOT_CASCADE                         = GetSpellInfo(121135) or "--Cascade"
    --Shaman
	HEALBOT_HEALING_WAVE                    = GetSpellInfo(331) or "--Healing Wave";
    HEALBOT_HEALING_SURGE                   = GetSpellInfo(8004) or "--Healing Surge";
    HEALBOT_RIPTIDE                         = GetSpellInfo(61295) or "--Riptide";
    HEALBOT_GREATER_HEALING_WAVE            = GetSpellInfo(77472) or "--Greater Healing Wave";
    HEALBOT_HEALING_RAIN                    = GetSpellInfo(73920) or "--Healing Rain";
    HEALBOT_CHAIN_HEAL                      = GetSpellInfo(1064) or "--Chain Heal";
    HEALBOT_HEALING_STREAM_TOTEM            = GetSpellInfo(119523) or "--Healing Stream Totem";
    HEALBOT_HEALING_TIDE_TOTEM              = GetSpellInfo(108280) or "--Healing Tide Totem";
    HEALBOT_MANA_TIDE_TOTEM                 = GetSpellInfo(16190) or "--Mana Tide Totem";
    --Monk
	HEALBOT_SOOTHING_MIST                   = GetSpellInfo(115175) or "--Soothing Mist"
    HEALBOT_ZEN_MEDITATION                  = GetSpellInfo(115176) or "--Zen Meditation"
    HEALBOT_ENVELOPING_MIST                 = GetSpellInfo(124682) or "--Enveloping Mist"
    HEALBOT_REVIVAL                         = GetSpellInfo(115310) or "--Revival"
    HEALBOT_RENEWING_MIST                   = GetSpellInfo(115151) or "--Renewing Mist"  
    HEALBOT_UPLIFT                          = GetSpellInfo(116670) or "--Uplift"
    HEALBOT_SURGING_MIST                    = GetSpellInfo(116694) or "--Surging Mist"
    HEALBOT_CHI_WAVE                        = GetSpellInfo(132463) or "--Chi Wave"
    HEALBOT_CHI_BURST                       = GetSpellInfo(130651) or "--Chi Burst"
    HEALBOT_ZEN_SPHERE                      = GetSpellInfo(124081) or "--Zen Sphere"
    --Warlock
	HEALBOT_HEALTH_FUNNEL                   = GetSpellInfo(755) or "--Health Funnel";

    
	--Buffs, Talents, Glyphs and Other Spells By Class
    --Death Knight
	HEALBOT_ICEBOUND_FORTITUDE              = GetSpellInfo(48792) or "--Icebound Fortitude";
    HEALBOT_ANTIMAGIC_SHELL                 = GetSpellInfo(48707) or "--Antimagic Shell";
    HEALBOT_ARMY_OF_THE_DEAD                = GetSpellInfo(42650) or "--Army of the Dead";
    HEALBOT_LICHBORNE                       = GetSpellInfo(49039) or "--Lichborne";
    HEALBOT_ANTIMAGIC_ZONE                  = GetSpellInfo(51052) or "--Antimagic Zone";
    HEALBOT_VAMPIRIC_BLOOD                  = GetSpellInfo(55233) or "--Vampiric Blood";
    HEALBOT_BONE_SHIELD                     = GetSpellInfo(49222) or "--Bone Shield";
    HEALBOT_HORN_OF_WINTER                  = GetSpellInfo(57330) or "--Horn of Winter";
    HEALBOT_DANCING_RUNE_WEAPON             = GetSpellInfo(49028) or "--Dancing Rune Weapon"
	HEALBOT_SHROUD_OF_PURGATORY             = GetSpellInfo(116888) or "--Shroud of Purgatory";
    --Druid
	HEALBOT_MARK_OF_THE_WILD                = GetSpellInfo(1126) or "--Mark of the Wild";
    HEALBOT_NATURES_GRASP                   = GetSpellInfo(16689) or "--Nature's Grasp";
    HEALBOT_BARKSKIN                        = GetSpellInfo(22812) or "--Barkskin";
    HEALBOT_IRONBARK                        = GetSpellInfo(102342) or "--Ironbark";
    HEALBOT_SURVIVAL_INSTINCTS              = GetSpellInfo(61336) or "--Survival Instincts";
    HEALBOT_FRENZIED_REGEN                  = GetSpellInfo(22842) or "--Frenzied Regeneration";
    HEALBOT_INNERVATE                       = GetSpellInfo(29166) or "--Innervate";
    HEALBOT_DRUID_CLEARCASTING              = GetSpellInfo(16870) or "--Clearcasting";
    HEALBOT_TREE_OF_LIFE                    = GetSpellInfo(33891) or "--Tree of Life";
    HEALBOT_HARMONY                         = GetSpellInfo(100977) or "--Harmony";
    HEALBOT_LIVING_SEED                     = GetSpellInfo(48500) or "--Living Seed";
    HEALBOT_SAVAGE_DEFENCE                  = GetSpellInfo(62606) or "--Savage Defense";
    HEALBOT_NATURE_SWIFTNESS                = GetSpellInfo(132158) or "--Nature's Swiftness";
    --Hunter
    HEALBOT_A_HAWK                          = GetSpellInfo(13165) or "--Aspect of the Hawk"
    HEALBOT_A_CHEETAH                       = GetSpellInfo(5118) or "--Aspect of the Cheetah"
    HEALBOT_A_PACK                          = GetSpellInfo(13159) or "--Aspect of the Pack"
    HEALBOT_A_WILD                          = GetSpellInfo(20043) or "--Aspect of the Wild"
    HEALBOT_A_IRON_HAWK                     = GetSpellInfo(109260) or "--Aspect of the Iron Hawk"
    HEALBOT_MENDPET                         = GetSpellInfo(136) or "--Mend Pet"
    HEALBOT_DETERRENCE                      = GetSpellInfo(19263) or "--Deterrence"
    HEALBOT_TRAP_LAUNCHER                   = GetSpellInfo(77769) or "--Trap Launcher"
    --Mage
	HEALBOT_ARCANE_BRILLIANCE               = GetSpellInfo(1459) or "--Arcane Brilliance";
    HEALBOT_DALARAN_BRILLIANCE              = GetSpellInfo(61316) or "--Dalaran Brilliance";
    HEALBOT_MAGE_WARD                       = GetSpellInfo(543) or "--Mage Ward";
    HEALBOT_MAGE_ARMOR                      = GetSpellInfo(6117) or "--Mage Armor";
    HEALBOT_MOLTEN_ARMOR                    = GetSpellInfo(30482) or "--Molten Armor";
    HEALBOT_FOCUS_MAGIC                     = GetSpellInfo(54646) or "--Focus Magic";
    HEALBOT_FROST_ARMOR                     = GetSpellInfo(7302) or "--Frost Armor";
    HEALBOT_TEMPORAL_SHIELD                 = GetSpellInfo(115610) or "--Temporal Shield"
    HEALBOT_ICE_BARRIER                     = GetSpellInfo(11426) or "--Ice Barrier"
    HEALBOT_INCANTERS_WARD                  = GetSpellInfo(1463) or "--Incanter's Ward"
    HEALBOT_ICE_BLOCK                       = GetSpellInfo(45438) or "--Ice Block"
    HEALBOT_ICE_WARD                        = GetSpellInfo(111264) or "--Ice Ward"
	HEALBOT_EVOCATION                       = GetSpellInfo(12051) or "--Evocation";
    --Paladin
    HEALBOT_BEACON_OF_LIGHT                 = GetSpellInfo(53563) or "--Beacon of Light";
    HEALBOT_LIGHT_BEACON                    = GetSpellInfo(53651) or "--Light's Beacon";
    HEALBOT_SACRED_SHIELD                   = GetSpellInfo(20925) or "--Sacred Shield";
    HEALBOT_LAY_ON_HANDS                    = GetSpellInfo(633) or "--Lay on Hands";
    HEALBOT_INFUSION_OF_LIGHT               = GetSpellInfo(53576) or "--Infusion of Light";
    HEALBOT_SPEED_OF_LIGHT                  = GetSpellInfo(85499) or "--Speed of Light";
    HEALBOT_DAY_BREAK                       = GetSpellInfo(88821) or "--Daybreak";
    HEALBOT_HOLY_SHOCK                      = GetSpellInfo(20473) or "--Holy Shock";
    HEALBOT_DIVINE_FAVOR                    = GetSpellInfo(31842) or "--Divine Favor";
    HEALBOT_DIVINE_PLEA                     = GetSpellInfo(54428) or "--Divine Plea"
    HEALBOT_DIVINE_SHIELD                   = GetSpellInfo(642) or "--Divine Shield";
    HEALBOT_BLESSING_OF_MIGHT               = GetSpellInfo(19740) or "--Blessing of Might";
    HEALBOT_BLESSING_OF_KINGS               = GetSpellInfo(20217) or "--Blessing of Kings";
    HEALBOT_SEAL_OF_RIGHTEOUSNESS           = GetSpellInfo(20154) or "--Seal of Righteousness";
    HEALBOT_SEAL_OF_JUSTICE                 = GetSpellInfo(20164) or "--Seal of Justice";
    HEALBOT_SEAL_OF_INSIGHT                 = GetSpellInfo(20165) or "--Seal of Insight";
    HEALBOT_SEAL_OF_TRUTH                   = GetSpellInfo(31801) or "--Seal of Truth";
    HEALBOT_HAND_OF_FREEDOM                 = GetSpellInfo(1044) or "--Hand of Freedom";
    HEALBOT_HAND_OF_PROTECTION              = GetSpellInfo(1022) or "--Hand of Protection";
    HEALBOT_HAND_OF_SACRIFICE               = GetSpellInfo(6940) or "--Hand of Sacrifice";
    HEALBOT_HAND_OF_SALVATION               = GetSpellInfo(1038) or "--Hand of Salvation";
    HEALBOT_RIGHTEOUS_FURY                  = GetSpellInfo(25780) or "--Righteous Fury";
    HEALBOT_DEVOTION_AURA                   = GetSpellInfo(465) or "--Devotion Aura";
    HEALBOT_DIVINE_PROTECTION               = GetSpellInfo(498) or "--Divine Protection";
    HEALBOT_ILLUMINATED_HEALING             = GetSpellInfo(86273) or "--Illuminated Healing";
    HEALBOT_ARDENT_DEFENDER                 = GetSpellInfo(31850) or "--Ardent Defender";
    HEALBOT_HOLY_SHIELD                     = GetSpellInfo(20925) or "--Holy Shield"
    HEALBOT_GUARDED_BY_THE_LIGHT            = GetSpellInfo(53592) or "--Guarded by the Light";
    HEALBOT_GUARDIAN_ANCIENT_KINGS          = GetSpellInfo(86698) or "--Guardian of Ancient Kings";
    HEALBOT_ETERNAL_FLAME                   = GetSpellInfo(114163) or "--Eternal Flame";
    HEALBOT_HAND_OF_PURITY                  = GetSpellInfo(114039) or "--Hand of Purity";
    HEALBOT_EXECUTION_SENTENCE              = GetSpellInfo(114157) or "--Execution Sentence";
    HEALBOT_DIVINE_PURPOSE                  = GetSpellInfo(86172) or "--Divine Purpose";
    --Priest
	HEALBOT_HOLY_NOVA                       = GetSpellInfo(132157) or "--Holy Nova";
	HEALBOT_POWER_WORD_SHIELD               = GetSpellInfo(17) or "--Power Word: Shield";
    HEALBOT_POWER_WORD_BARRIER              = GetSpellInfo(62618) or "--Power Word: Barrier";
    HEALBOT_SPIRIT_SHELL                    = GetSpellInfo(109964) or "--Spirit Shell";
    HEALBOT_ECHO_OF_LIGHT                   = GetSpellInfo(77489) or "--Echo of Light";
    HEALBOT_GUARDIAN_SPIRIT                 = GetSpellInfo(47788) or "--Guardian Spirit";
    HEALBOT_LEVITATE                        = GetSpellInfo(1706) or "--Levitate";
    HEALBOT_DIVINE_AEGIS                    = GetSpellInfo(47515) or "--Divine Aegis";
    HEALBOT_BLESSED_HEALING                 = GetSpellInfo(70772) or "--Blessed Healing";
    HEALBOT_PAIN_SUPPRESSION                = GetSpellInfo(33206) or "--Pain Suppression";
    HEALBOT_POWER_INFUSION                  = GetSpellInfo(10060) or "--Power Infusion";
    HEALBOT_POWER_WORD_FORTITUDE            = GetSpellInfo(21562) or "--Power Word: Fortitude";
    HEALBOT_INNER_FIRE                      = GetSpellInfo(588) or "--Inner Fire";
    HEALBOT_INNER_WILL                      = GetSpellInfo(73413) or "--Inner Will";
    HEALBOT_SHADOWFORM                      = GetSpellInfo(15473) or "--Shadowform"
    HEALBOT_INNER_FOCUS                     = GetSpellInfo(89485) or "--Inner Focus";
    HEALBOT_CHAKRA                          = GetSpellInfo(14751) or "--Chakra";
    HEALBOT_CHAKRA_SANCTUARY                = GetSpellInfo(81206) or "--Chakra: Sanctuary";
    HEALBOT_CHAKRA_SERENITY                 = GetSpellInfo(81208) or "--Chakra: Serenity";
    HEALBOT_CHAKRA_CHASTISE                 = GetSpellInfo(81209) or "--Chakra: Chastise";
    HEALBOT_REVELATIONS                     = GetSpellInfo(88627) or "--Revelations";
    HEALBOT_FEAR_WARD                       = GetSpellInfo(6346) or "--Fear Ward";
    HEALBOT_SERENDIPITY                     = GetSpellInfo(63733) or "--Serendipity";
    HEALBOT_VAMPIRIC_EMBRACE                = GetSpellInfo(15286) or "--Vampiric Embrace";
    HEALBOT_LIGHTWELL_RENEW                 = GetSpellInfo(7001) or "--Lightwell Renew";
    HEALBOT_GRACE                           = GetSpellInfo(47517) or "--Grace";
    HEALBOT_LEAP_OF_FAITH                   = GetSpellInfo(73325) or "--Leap of Faith";
    HEALBOT_EVANGELISM                      = GetSpellInfo(81661) or "--Evangelism";
    HEALBOT_ARCHANGEL                       = GetSpellInfo(81700) or "--Archangel";
    HEALBOT_DIVINE_INSIGHT                  = GetSpellInfo(109175) or "--Divine Insight";
    HEALBOT_HYMN_OF_HOPE                    = GetSpellInfo(64901) or "--Hymn of Hope";
    HEALBOT_ANGELIC_BULWARK                 = GetSpellInfo(108945) or "--Angelic Bulwark"
    HEALBOT_DISPERSION                      = GetSpellInfo(47585) or "--Dispersion"
    HEALBOT_TWIST_OF_FATE                   = GetSpellInfo(109142) or "--Twist of Fate";
    --Shaman
    HEALBOT_TIDAL_WAVES                     = GetSpellInfo(51564) or "--Tidal Waves";
    HEALBOT_ANACESTRAL_SWIFTNESS            = GetSpellInfo(16188) or "--Ancestral Swiftness";
    HEALBOT_LIGHTNING_SHIELD                = GetSpellInfo(324) or "--Lightning Shield";
    HEALBOT_ROCKBITER_WEAPON                = GetSpellInfo(8017) or "--Rockbiter Weapon";
    HEALBOT_FLAMETONGUE_WEAPON              = GetSpellInfo(8024) or "--Flametongue Weapon";
    HEALBOT_EARTHLIVING_WEAPON              = GetSpellInfo(51730) or "--Earthliving Weapon";
    HEALBOT_WINDFURY_WEAPON                 = GetSpellInfo(8232) or "--Windfury Weapon";
    HEALBOT_FROSTBRAND_WEAPON               = GetSpellInfo(8033) or "--Frostbrand Weapon";
    HEALBOT_EARTH_SHIELD                    = GetSpellInfo(974) or "--Earth Shield";
    HEALBOT_WATER_SHIELD                    = GetSpellInfo(52127) or "--Water Shield";
    HEALBOT_WATER_WALKING                   = GetSpellInfo(546) or "--Water Walking";
    HEALBOT_EARTHLIVING                     = GetSpellInfo(51945) or "--Earthliving";
    HEALBOT_UNLEASH_ELEMENTS                = GetSpellInfo(73680) or "--Unleash Elements";
    HEALBOT_UNLEASHED_FURY                  = GetSpellInfo(117012) or "--Unleashed Fury";
    HEALBOT_ASTRAL_SHIFT                    = GetSpellInfo(108271) or "--Astral Shift";
    HEALBOT_ANACESTRAL_VIGOR                = GetSpellInfo(105284) or "--Ancestral Vigor";
    HEALBOT_EMPOWER                         = GetSpellInfo(118350) or "--Empower";
    HEALBOT_ANACESTRAL_GUIDANCE             = GetSpellInfo(108281) or "--Ancestral Guidance";
    HEALBOT_ASCENDANCE                      = GetSpellInfo(114049) or "--Ascendance";
    HEALBOT_UNLEASH_LIFE                    = GetSpellInfo(73685) or "--Unleash Life";
    HEALBOT_UNLEASH_FLAME                   = GetSpellInfo(73683) or "--Unleash Flame";
    HEALBOT_SPIRITWALKERS_GRACE             = GetSpellInfo(79206) or "--Spiritwalker's Grace";
    HEALBOT_ELEMENTAL_MASTERY               = GetSpellInfo(16166) or "--Elemental Mastery";
    HEALBOT_SHAMANISTIC_RAGE                = GetSpellInfo(30823) or "--Shamanistic Rage";   
    --Monk
	HEALBOT_LEGACY_EMPEROR                  = GetSpellInfo(115921) or "--Legacy of the Emperor"
    HEALBOT_LEGACY_WHITETIGER               = GetSpellInfo(116781) or "--Legacy of the White Tiger"
    HEALBOT_RUSHING_JADE_WIND               = GetSpellInfo(116847) or "--Rushing Jade Wind"
    HEALBOT_LIFE_COCOON                     = GetSpellInfo(116849) or "--Life Cocoon"
    HEALBOT_THUNDER_FOCUS_TEA               = GetSpellInfo(116680) or "--Thunder Focus Tea"
    HEALBOT_SERPENT_ZEAL                    = GetSpellInfo(127722) or "--Serpent's Zeal"
    HEALBOT_MANA_TEA                        = GetSpellInfo(115867) or "--Mana Tea"
    HEALBOT_STANCE_MONK_TIGER               = GetSpellInfo(103985) or "--Stance of the Fierce Tiger"
    HEALBOT_STANCE_MONK_SERPENT             = GetSpellInfo(115070) or "--Stance of the Wise Serpent"
    HEALBOT_ELUSIVE_BREW                    = GetSpellInfo(115308) or "--Elusive Brew"
    HEALBOT_FORTIFYING_BREW                 = GetSpellInfo(115203) or "--Fortifying Brew"
    HEALBOT_DAMPEN_HARM                     = GetSpellInfo(122278) or "--Dampen Harm"
    HEALBOT_DIFFUSE_MAGIC                   = GetSpellInfo(122783) or "--Diffuse Magic"
    HEALBOT_AVERT_HARM                      = GetSpellInfo(115213) or "--Avert Harm"
    HEALBOT_GUARD                           = GetSpellInfo(115295) or "--Guard"
    --Warlock
	HEALBOT_DEMON_ARMOR                     = GetSpellInfo(687) or "--Demon Armor";
    HEALBOT_FEL_ARMOR                       = GetSpellInfo(28176) or "--Fel Armor";
    HEALBOT_SOUL_LINK                       = GetSpellInfo(19028) or "--Soul Link";
    HEALBOT_UNENDING_BREATH                 = GetSpellInfo(5697) or "--Unending Breath"
    HEALBOT_LIFE_TAP                        = GetSpellInfo(1454) or "--Life Tap";
    HEALBOT_BLOOD_PACT                      = GetSpellInfo(6307) or "--Blood Pact";
    HEALBOT_DARK_INTENT                     = GetSpellInfo(109773) or "--Dark Intent";
    HEALBOT_DARK_BARGAIN                    = GetSpellInfo(110913) or "--Dark Bargain"
    HEALBOT_TWILIGHT_WARD                   = GetSpellInfo(6229) or "--Twilight Ward"
    HEALBOT_UNENDING_RESOLVE                = GetSpellInfo(104773) or "--Unending Resolve"
    --Warrior
	HEALBOT_BATTLE_SHOUT                    = GetSpellInfo(6673) or "--Battle Shout";
    HEALBOT_COMMANDING_SHOUT                = GetSpellInfo(469) or "--Commanding Shout";
    HEALBOT_INTERVENE                       = GetSpellInfo(3411) or "--Intervene";
    HEALBOT_VIGILANCE                       = GetSpellInfo(114030) or "--Vigilance";
    HEALBOT_LAST_STAND                      = GetSpellInfo(12975) or "--Last Stand";
    HEALBOT_SHIELD_WALL                     = GetSpellInfo(871) or "--Shield Wall";
    HEALBOT_SHIELD_BLOCK                    = GetSpellInfo(2565) or "--Shield Block";
    HEALBOT_ENRAGED_REGEN                   = GetSpellInfo(55694) or "--Enraged Regeneration";
    HEALBOT_SHIELD_BARRIER                  = GetSpellInfo(112048) or "--Shield Barrier"
    HEALBOT_SAFEGUARD                       = GetSpellInfo(114029) or "--Safeguard"
    --Rogue
	HEALBOT_VANISH                          = GetSpellInfo(1856) or "--Vanish";
    HEALBOT_FEINT                           = GetSpellInfo(1966) or "--Feint"
    HEALBOT_CLOAK_OF_SHADOWS                = GetSpellInfo(31224) or "--Cloak of Shadows"

    
	--Resurrection Spells
    HEALBOT_RESURRECTION                    = GetSpellInfo(2006) or "--Resurrection";
    HEALBOT_MASS_RESURRECTION               = GetSpellInfo(83968) or "--Mass Resurrection";
    HEALBOT_REDEMPTION                      = GetSpellInfo(7328) or "--Redemption";
    HEALBOT_REBIRTH                         = GetSpellInfo(20484) or "--Rebirth";
    HEALBOT_REVIVE                          = GetSpellInfo(50769) or "--Revive";
    HEALBOT_ANCESTRALSPIRIT                 = GetSpellInfo(2008) or "--Ancestral Spirit";
    HEALBOT_RESUSCITATE                     = GetSpellInfo(115178) or "--Resuscitate"

    
	--Cure Spells
    HEALBOT_CLEANSE                         = GetSpellInfo(4987) or "--Cleanse";
    HEALBOT_REMOVE_CURSE                    = GetSpellInfo(475) or "--Remove Curse";
    HEALBOT_REMOVE_CORRUPTION               = GetSpellInfo(2782) or "--Remove Corruption";
    HEALBOT_NATURES_CURE                    = GetSpellInfo(88423) or "--Nature's Cure";
    HEALBOT_PURIFY                          = GetSpellInfo(527) or "--Purify";
    HEALBOT_CLEANSE_SPIRIT                  = GetSpellInfo(51886) or "--Cleanse Spirit";
    HEALBOT_IMPROVED_CLEANSE_SPIRIT         = GetSpellInfo(77130) or "--Improved Cleanse Spirit";
    HEALBOT_SACRED_CLEANSING                = GetSpellInfo(53551) or "--Sacred Cleansing";
    HEALBOT_BODY_AND_SOUL                   = GetSpellInfo(64127) or "--Body and Soul";
    HEALBOT_PURIFY_SPIRIT                   = GetSpellInfo(77130) or "--Purify Spirit";
    HEALBOT_DETOX                           = GetSpellInfo(115450) or "--Detox"; 

	--END OF SPELL LIST
	
	
	HEALBOT_DISEASE_en                      = "Disease";  -- Do NOT localize this value.
    HEALBOT_MAGIC_en                        = "Magic";  -- Do NOT localize this value.
    HEALBOT_CURSE_en                        = "Curse";  -- Do NOT localize this value.
    HEALBOT_POISON_en                       = "Poison";  -- Do NOT localize this value.
    HEALBOT_CUSTOM_en                       = "Custom";  -- Do NOT localize this value. 
	
	
	--Ignore Class Debuffs (ONLY DISPELLABLE DEBUFFS)
	HEALBOT_DEBUFF_IGNITE_MANA              = GetSpellInfo(19659) or "--Ignite Mana";
	HEALBOT_DEBUFF_TAINTED_MIND             = GetSpellInfo(16567) or "--Tainted Mind";
	HEALBOT_DEBUFF_VIPER_STING              = GetSpellInfo(39413) or "--Viper Sting";
	HEALBOT_DEBUFF_CURSE_OF_IMPOTENCE       = GetSpellInfo(34925) or "--Curse of Impotence";
	HEALBOT_DEBUFF_DECAYED_INTELLECT        = GetSpellInfo(31555) or "--Decayed Intellect";
	HEALBOT_DEBUFF_DECAYED_STRENGHT         = GetSpellInfo(6951) or "--Decayed Strength";
	HEALBOT_DEBUFF_SILENCE                  = GetSpellInfo(38913) or "--Silence";
	HEALBOT_DEBUFF_TRAMPLE                  = GetSpellInfo(126406) or "--Trample";
	HEALBOT_DEBUFF_UNSTABLE_AFFLICTION      = GetSpellInfo(35183) or "--Unstable Affliction";	
	--Ignore Movement Debuffs (ONLY DISPELLABLE DEBUFFS)
	HEALBOT_DEBUFF_FROSTBOLT                = GetSpellInfo(69573) or "--Frostbolt";
	HEALBOT_DEBUFF_MAGMA_SHACKLES           = GetSpellInfo(19496) or "--Magma Shackles";
	HEALBOT_DEBUFF_SLOW                     = GetSpellInfo(32922) or "--Slow";
	HEALBOT_DEBUFF_CHILLED                  = GetSpellInfo(6136) or "--Chilled";
    HEALBOT_DEBUFF_CONEOFCOLD               = GetSpellInfo(64645) or "--Cone of Cold";
	HEALBOT_DEBUFF_FROST_SHOCK              = GetSpellInfo(41116) or "--Frost Shock";
	HEALBOT_DEBUFF_EARTHBIND                = GetSpellInfo(3600) or "--Earthbind";
	HEALBOT_DEBUFF_SEAL_OF_JUSTICE          = GetSpellInfo(20170) or "--Seal of Justice";	
	--Ignore Non-Harmful Debuffs (ONLY DISPELLABLE DEBUFFS)
	HEALBOT_DEBUFF_DREAMLESS_SLEEP          = GetSpellInfo(15822) or "--Dreamless Sleep";
    HEALBOT_DEBUFF_GREATER_DREAMLESS        = GetSpellInfo(24360) or "--Greater Dreamless Sleep";
    HEALBOT_DEBUFF_MAJOR_DREAMLESS          = GetSpellInfo(28504) or "--Major Dreamless Sleep";
	HEALBOT_DEBUFF_HUNTERS_MARK             = GetSpellInfo(1130) or "--Hunter's Mark";			
	
	
	--Common Buffs
    HEALBOT_ZAMAELS_PRAYER                  = GetSpellInfo(88663) or "--Zamael's Prayer";
	
	--Harmful Debuffs
	--Debuffs
    HEALBOT_DEBUFF_WEAKENED_SOUL            = GetSpellInfo(6788) or "--Weakened Soul"; --DO NOT REMOVE
	HEALBOT_DEBUFF_ROCKET_FUEL_LEAK         = GetSpellInfo(94794) or "--Rocket Fuel Leak"; --Engineering 
	
	--Enemy Debuffs, Dungeons, Raids And Scenarios
	--Scenarios Proving Grounds
	HEALBOT_DEBUFF_CHOMP                    = GetSpellInfo(145263) or "--Chomp";
	HEALBOT_DEBUFF_LAVA_BURNS               = GetSpellInfo(145403) or "--Lava Burns";
	
    --[[World Bosses
	Sha of Anger]]
	HEALBOT_DEBUFF_SEETHE                   = GetSpellInfo(119487) or "--Seethe";
	HEALBOT_DEBUFF_AGGRESSIVE_BEHAVIOR      = GetSpellInfo(119626) or "--Aggressive Behavior";
	--HEALBOT_DEBUFF_BITTER_THOUGHTS          = GetSpellInfo(119610) or "--Bitter Thoughts";]]
    --Oondasta	
	HEALBOT_DEBUFF_CRUSH                    = GetSpellInfo(137504) or "--Crush";
	--Nalak, the Storm Lord
	HEALBOT_DEBUFF_LIGHTNING_TETHER         = GetSpellInfo(136339) or "--Lightning Tether";
	HEALBOT_DEBUFF_STORMCLOUD               = GetSpellInfo(139900) or "--Stormcloud";
	--Celestials
	HEALBOT_DEBUFF_SPECTRAL_SWIPE           = GetSpellInfo(144638) or "--Spectral Swipe";
	--HEALBOT_DEBUFF_JADEFLAME_BUFFET         = GetSpellInfo(144630) or "--Jadeflame Buffet";
	--Ordos
	HEALBOT_DEBUFF_BURNING_SOUL             = GetSpellInfo(144689) or "--Burning Soul";
	HEALBOT_DEBUFF_POOL_OF_FIRE             = GetSpellInfo(144694) or "--Pool of Fire";
	HEALBOT_DEBUFF_ANCIENT_FLAME            = GetSpellInfo(144699) or "--Ancient Flame";
	
	--[[Updated 5.2 Mists of Pandaria Expansion by Ariá - Silvermoon EU
	= GetMapNameByID(896) or "--Mogu'shan Vaults" 
	Trash]]
	HEALBOT_DEBUFF_SUNDERING_BITE           = GetSpellInfo(116970) or "--Sundering Bite";
	HEALBOT_DEBUFF_FULLY_PETRIFIED          = GetSpellInfo(125091) or "--Fully Petrified";
	HEALBOT_DEBUFF_FOCUSED_ASSAULT          = GetSpellInfo(116990) or "--Focused Assault";
	HEALBOT_DEBUFF_GROUND_SLAM              = GetSpellInfo(121087) or "--Ground Slam";
	HEALBOT_DEBUFF_IMPALE                   = GetSpellInfo(121247) or "--Impale";
	HEALBOT_DEBUFF_PYROBLAST                = GetSpellInfo(120670) or "--Pyroblast";
	HEALBOT_DEBUFF_TROLL_RUSH               = GetSpellInfo(116606) or "--Troll Rush";
	HEALBOT_DEBUFF_SUNDER_ARMOR             = GetSpellInfo(76622) or "--Sunder Armor";
	--The Stone Guard
	HEALBOT_DEBUFF_AMETHYST_POOL            = GetSpellInfo(130774) or "--Amethyst Pool";
	HEALBOT_DEBUFF_REND_FLESH               = GetSpellInfo(125206) or "--Rend Flesh";
	HEALBOT_DEBUFF_LIVING_AMETHYST          = GetSpellInfo(116322) or "--Living Amethyst";
	HEALBOT_DEBUFF_LIVING_COBALT            = GetSpellInfo(116199) or "--Living Cobalt";
	HEALBOT_DEBUFF_LIVING_JADE              = GetSpellInfo(116301) or "--Living Jade";
	HEALBOT_DEBUFF_LIVING_JASPER            = GetSpellInfo(116304) or "--Living Jasper";
	--HEALBOT_DEBUFF_JASPER_CHAINS            = GetSpellInfo(130395) or "--Jasper Chains";
	--Feng the Accursed
	HEALBOT_DEBUFF_LIGHTNING_LASH           = GetSpellInfo(131788) or "--Lightning Lash";
	HEALBOT_DEBUFF_LIGHTNING_CHARGE         = GetSpellInfo(116374) or "--Lightning Charge";
	HEALBOT_DEBUFF_FLAMING_SPEAR            = GetSpellInfo(116942) or "--Flaming Spear";
	HEALBOT_DEBUFF_WILDFIRE_SPARK           = GetSpellInfo(116784) or "--Wildfire Spark";
	HEALBOT_DEBUFF_ARCANE_SHOCK             = GetSpellInfo(131790) or "--Arcane Shock";
	HEALBOT_DEBUFF_ARCANE_RESONANCE         = GetSpellInfo(116577) or "--Arcane Resonance";
	HEALBOT_DEBUFF_SHADOWBURN               = GetSpellInfo(131792) or "--Shadowburn";
	--HEALBOT_DEBUFF_EPICENTRE                = GetSpellInfo(116040) or "--Epicentre";
	--Gara'jal the Spiritbinder
	HEALBOT_DEBUFF_VOODOO_DOLL              = GetSpellInfo(122151) or "--Voodoo Doll";
	--[[HEALBOT_DEBUFF_CROSSED_OVER             = GetSpellInfo(116260) or "--Crossed Over";	
	HEALBOT_DEBUFF_SOUL_SEVER               = GetSpellInfo(116278) or "--Soul Sever";]]	
	--The Spirit Kings
	HEALBOT_DEBUFF_PINNED_DOWN              = GetSpellInfo(118135) or "--Pinned Down";
	HEALBOT_DEBUFF_UNDYING_SHADOWS          = GetSpellInfo(117529) or "--Undying Shadows";
	--[[HEALBOT_DEBUFF_PILLAGED                 = GetSpellInfo(118048) or "--Pillaged"; 
	HEALBOT_DEBUFF_ROBBED_BLIND             = GetSpellInfo(118163) or "--Robbed Blind";]]
	--Elegon
	--HEALBOT_DEBUFF_OVERCHARGED              = GetSpellInfo(117878) or "--Overcharged";
	--Will of the Emporer
	HEALBOT_DEBUFF_FOCUSED_ASSAULT          = GetSpellInfo(116525) or "--Focused Assault";
	HEALBOT_DEBUFF_ENERGIZING_SMASH         = GetSpellInfo(116550) or "--Energizing Smash";
	HEALBOT_DEBUFF_IMPEDING_THRUST          = GetSpellInfo(117485) or "--Impeding Thrust";
	HEALBOT_DEBUFF_FOCUSED_DEFENSE          = GetSpellInfo(116778) or "--Focused Defense";
	HEALBOT_DEBUFF_DEVASTATING_ARC          = GetSpellInfo(116835) or "--Devastating Arc";
	HEALBOT_DEBUFF_STOMP                    = GetSpellInfo(132425) or "--Stomp";
	--[[HEALBOT_DEBUFF_FOCUSED_ENERGY           = GetSpellInfo(116829) or "--Focused Energy";
	HEALBOT_DEBUFF_TITAN_GAS                = GetSpellInfo(116782) or "--Titan Gas";]]
	
	--[[= GetMapNameByID(897) or "--Heart of Fear"
	Trash]]
	HEALBOT_DEBUFF_ARTERIAL_BLEEDING         = GetSpellInfo(123422) or "--Arterial Bleeding";
	HEALBOT_DEBUFF_DISMANTLED_ARMOR          = GetSpellInfo(123417) or "--Dismantled Armor";
	HEALBOT_DEBUFF_STUNNING_STRIKE           = GetSpellInfo(123420) or "--Stunning Strike";
	HEALBOT_DEBUFF_GALE_FORCE_WINDS          = GetSpellInfo(123497) or "--Gale Force Winds";
	HEALBOT_DEBUFF_MORTAL_REND               = GetSpellInfo(126901) or "--Mortal Rend";
	HEALBOT_DEBUFF_GRIEVOUS_WHIRL            = GetSpellInfo(126912) or "--Grievous Whirl";
	HEALBOT_DEBUFF_BURNING_STING             = GetSpellInfo(125490) or "--Burning Sting";
	HEALBOT_DEBUFF_SLAM                      = GetSpellInfo(125081) or "--Slam";
	HEALBOT_DEBUFF_ZEALOUS_PARASITE          = GetSpellInfo(125785) or "--Zealous Parasite";
	--Imperial Vizier Zor'lok
	HEALBOT_DEBUFF_EXHALE                    = GetSpellInfo(122761) or "--Exhale";
	HEALBOT_DEBUFF_CONVERT                   = GetSpellInfo(122740) or "--Convert";
	--HEALBOT_DEBUFF_PHEROMONES_OF_ZEAL        = GetSpellInfo(123812) or "--Pheromones of Zeal";
	--Blade Lord Ta'yak
	HEALBOT_DEBUFF_OVERWHELMING_ASSAULT      = GetSpellInfo(123474) or "--Overwhelming Assault";
	HEALBOT_DEBUFF_WIND_STEP      			 = GetSpellInfo(123175) or "--Wind Step";
	HEALBOT_DEBUFF_UNSEEN_STRIKE      		 = GetSpellInfo(122994) or "--Unseen Strike";
	--Garalon
	HEALBOT_DEBUFF_PHEROMONES      		     = GetSpellInfo(123092) or "--Pheromones";
	--HEALBOT_DEBUFF_PUNGENCY      		     = GetSpellInfo(123081) or "--Pungency";
	--Wind Lord Mel'jarak
	HEALBOT_DEBUFF_AMBER_PRISON      		 = GetSpellInfo(121876) or "--Amber Prison";
	HEALBOT_DEBUFF_CORROSIVE_RESIN     		 = GetSpellInfo(122064) or "--Corrosive Resin";
	HEALBOT_DEBUFF_KORTHIK_STRIKE     		 = GetSpellInfo(122409) or "--Kor'thik Strike";
	--Amber-Shaper Un'sok
	HEALBOT_DEBUFF_RESHAPE_LIFE     		 = GetSpellInfo(122370) or "--Reshape Life";
	HEALBOT_DEBUFF_PARASITIC_GROWTH     	 = GetSpellInfo(121949) or "--Parasitic Growth";
	HEALBOT_DEBUFF_FLING     	             = GetSpellInfo(122413) or "--Fling";
	HEALBOT_DEBUFF_AMBER_GLOBULE     	     = GetSpellInfo(125498) or "--Amber Globule";
	--Grand Empress Shek'zeer
	HEALBOT_DEBUFF_EYES_OF_THE_EMPRESS     	 = GetSpellInfo(123707) or "--Eyes of the Empress";
	HEALBOT_DEBUFF_CRY_OF_TERROR     	     = GetSpellInfo(123792) or "--Cry of Terror";
	HEALBOT_DEBUFF_STICKY_RESIN    	         = GetSpellInfo(124097) or "--Sticky Resin";
	HEALBOT_DEBUFF_POISON_BOMB     	         = GetSpellInfo(124777) or "--Poison Bomb";
	HEALBOT_DEBUFF_POISON_DRENCHED_ARMOR     = GetSpellInfo(124821) or "--Poison-Drenched Armor";
	HEALBOT_DEBUFF_VISIONS_OF_DEMISE    	 = GetSpellInfo(124868) or "--Visions of Demise";
	HEALBOT_DEBUFF_HEART_OF_FEAR     	     = GetSpellInfo(125638) or "--Heart of Fear";
	
	--[[= GetMapNameByID(886) or "--Terrace of Endless Spring"
	Protectors of the Endless]]
	HEALBOT_DEBUFF_TOUCH_OF_SHA             = GetSpellInfo(117519) or "--Touch of Sha";
	HEALBOT_DEBUFF_DEFILED_GROUND           = GetSpellInfo(118091) or "--Defiled Ground";
	HEALBOT_DEBUFF_OVERWHELMING_CORRUPTION  = GetSpellInfo(117353) or "--Overwhelming Corruption";
	--Tsulong
	HEALBOT_DEBUFF_SHADOW_BREATH            = GetSpellInfo(122752) or "--Shadow Breath";
	HEALBOT_DEBUFF_DREAD_SHADOWS            = GetSpellInfo(122768) or "--Dread Shadows";
	--Lei Shi
	HEALBOT_DEBUFF_SPRAY                    = GetSpellInfo(123121) or "--Spray";
	HEALBOT_DEBUFF_SCARY_FOG                = GetSpellInfo(123712) or "--Scary Fog";
	--Sha of Fear
	HEALBOT_DEBUFF_PENETRATING_BOLT          = GetSpellInfo(119086) or "--Penetrating Bolt";
	HEALBOT_DEBUFF_NAKED_AND_AFRAID          = GetSpellInfo(120669) or "--Naked and Afraid";
	HEALBOT_DEBUFF_HUDDLE_IN_TERROR          = GetSpellInfo(120629) or "--Huddle in Terror";
	HEALBOT_DEBUFF_CHAMPION_OF_THE_LIGHT     = GetSpellInfo(120268) or "--Champion of the Light";
	HEALBOT_DEBUFF_OMINOUS_CACKLE            = GetSpellInfo(129147) or "--Ominous Cackle";
	--HEALBOT_DEBUFF_DREAD_SPRAY               = GetSpellInfo(119983) or "--Dread Spray";
	
	--[[Updated 5.3 Mists of Pandaria Expansion by Ariá - Silvermoon EU 		
	= GetMapNameByID(930) or "--Throne of Thunder"
	Trash]]
	HEALBOT_DEBUFF_WOUNDING_STRIKE          = GetSpellInfo(140049) or "--Wounding Strike";
	HEALBOT_DEBUFF_STORM_ENERGY             = GetSpellInfo(139322) or "--Storm Energy";                      
	HEALBOT_DEBUFF_ANCIENT_VENOM            = GetSpellInfo(139888) or "--Ancient Venom";
	HEALBOT_DEBUFF_TORMENT                  = GetSpellInfo(139550) or "--Torment";
	HEALBOT_DEBUFF_CRUSH_ARMOR              = GetSpellInfo(33661) or  "--Crush Armor";
	HEALBOT_DEBUFF_STORMCLOUD               = GetSpellInfo(139900) or "--Stormcloud";
	HEALBOT_DEBUFF_SLASHING_TALONS          = GetSpellInfo(136753) or "--Slashing Talons";
	HEALBOT_DEBUFF_CHOKING_MISTS            = GetSpellInfo(140682) or "--Choking Mists";
	HEALBOT_DEBUFF_SHALE_SHARDS             = GetSpellInfo(140616) or "--Shale Shards"; 
	HEALBOT_DEBUFF_CORROSIVE_BREATH         = GetSpellInfo(140686) or "--Corrosive Breath";
	HEALBOT_DEBUFF_COCOON                   = GetSpellInfo(112844) or "--Cocoon";
	HEALBOT_DEBUFF_CHOKING_GAS              = GetSpellInfo(139470) or "--Choking Gas";
	HEALBOT_DEBUFF_GNAWED_UPON              = GetSpellInfo(134668) or "--Gnawed Upon";
	HEALBOT_DEBUFF_RETRIEVE_SPEAR           = GetSpellInfo(137072) or "--Retrieve Spear";
	--Jin'rokh the Breaker
	HEALBOT_DEBUFF_STATIC_WOUND             = GetSpellInfo(138389) or "--Static Wound";
	HEALBOT_DEBUFF_FOCUSED_LIGHTNING        = GetSpellInfo(137399) or "--Focused Lightning";
	HEALBOT_DEBUFF_THUNDERING_THROW         = GetSpellInfo(137167) or "--Thundering Throw";
	HEALBOT_DEBUFF_ELECTRIFIED_WATERS       = GetSpellInfo(138006) or "--Electrified Waters";
	--Horridon
	HEALBOT_DEBUFF_TRIPLE_PUNCTURE          = GetSpellInfo(136767) or "--Triple Puncture";        
	HEALBOT_DEBUFF_RENDING_CHARGE           = GetSpellInfo(136653) or "--Rending Charge";
	HEALBOT_DEBUFF_FROZEN_BOLT              = GetSpellInfo(136573) or "--Frozen Bolt";
	--Council of Elders 
	HEALBOT_DEBUFF_FRIGID_ASSAULT           = GetSpellInfo(136911) or "--Frigid Assault";
    HEALBOT_DEBUFF_BITING_COLD              = GetSpellInfo(136917) or "--Biting Cold";
	HEALBOT_DEBUFF_FROSTBITE                = GetSpellInfo(136937) or "--Frostbite";
	HEALBOT_DEBUFF_BODY_HEAT                = GetSpellInfo(137084) or "--Body Heat";
	HEALBOT_DEBUFF_MARKED_SOUL              = GetSpellInfo(137359) or "--Marked Soul";
	HEALBOT_DEBUFF_SOUL_FRAGMENT            = GetSpellInfo(137641) or "--Soul Fragment";    
	HEALBOT_DEBUFF_ENTRAPPED                = GetSpellInfo(136857) or "--Entrapped"; 
	--HEALBOT_DEBUFF_SHADOWED_SOUL            = GetSpellInfo(137650) or "--Shadowed Soul";	
    --Tortos
	HEALBOT_DEBUFF_QUAKE_STOMP             = GetSpellInfo(134920) or "--Quake Stomp";
	HEALBOT_DEBUFF_CRYSTAL_SHELL           = GetSpellInfo(137633) or "--Crystal Shell";       
	HEALBOT_DEBUFF_CRYSTAL_SHELL_FULL_CAPACITY = GetSpellInfo(140701) or "--Crystal Shell Full Capacity!";
	--Megaera
	HEALBOT_DEBUFF_IGNITE_FLESH             = GetSpellInfo(137731) or "--Ignite Flesh"; 
	HEALBOT_DEBUFF_ARCTIC_FREEZE            = GetSpellInfo(139842) or "--Arctic Freeze";    
    HEALBOT_DEBUFF_ROT_ARMOR                = GetSpellInfo(139840) or "--Rot Armor"; 
	HEALBOT_DEBUFF_TORRENT_OF_ICE           = GetSpellInfo(139870) or "--Torrent of Ice"; 
	--HEALBOT_DEBUFF_ICY_GROUND               = GetSpellInfo(139909) or "--Icy Ground"; 
	--Ji-Kun
	HEALBOT_DEBUFF_TALON_RAKE               = GetSpellInfo(134366) or "--Talon Rake"; 
    HEALBOT_DEBUFF_INFECTED_TALONS  	    = GetSpellInfo(140092) or "--Infected Talons"; 
	HEALBOT_DEBUFF_FEED_POOL                = GetSpellInfo(138319) or "--Feed Pool"; 
	HEALBOT_DEBUFF_SLIMED                   = GetSpellInfo(138309) or "--Slimed";                  
	--Durumu the Forgotten
	HEALBOT_DEBUFF_SERIOUS_WOUND            = GetSpellInfo(133767) or "--Serious Wound";
	HEALBOT_DEBUFF_ARTERIAL_CUT             = GetSpellInfo(133768) or "--Arterial Cut";
	HEALBOT_DEBUFF_LINGERING_GAZE           = GetSpellInfo(134626) or "--Lingering Gaze";
	HEALBOT_DEBUFF_LIFE_DRAIN               = GetSpellInfo(133798) or "--Life Drain";
	--[[HEALBOT_DEBUFF_BLUE_RAY_TRACKING        = GetSpellInfo(139202) or "--Blue Ray Tracking";
	HEALBOT_DEBUFF_BLUE_RAYS                = GetSpellInfo(133677) or "--Blue Rays";
	HEALBOT_DEBUFF_INFRARED_TRACKING        = GetSpellInfo(139204) or "--Infrared Tracking";
	HEALBOT_DEBUFF_INFRARED_LIGHT           = GetSpellInfo(133732) or "--Infrared Light";
	HEALBOT_DEBUFF_BRIGHT_LIGHT             = GetSpellInfo(133738) or "--Bright Light";]]
	--Primordius
	HEALBOT_DEBUFF_MALFORMED_BLOOD          = GetSpellInfo(136050) or "--Malformed Blood";
	HEALBOT_DEBUFF_VOLATILE_PATHOGEN        = GetSpellInfo(136228) or "--Volatile Pathogen";
	--Dark Animus
	HEALBOT_DEBUFF_CRIMSON_WAKE             = GetSpellInfo(138480) or "--Crimson Wake";
	HEALBOT_DEBUFF_EXPLOSIVE_SLAM           = GetSpellInfo(138569) or "--Explosive Slam";
	HEALBOT_DEBUFF_ANIMA_RING               = GetSpellInfo(136962) or "--Anima Ring";
	HEALBOT_DEBUFF_TOUCH_OF_ANIMUS          = GetSpellInfo(138659) or "--Touch of Animus";
	--HEALBOT_DEBUFF_ANIMA_FONT               = GetSpellInfo(138691) or "--Anima Font";
	--Iron Qon
	HEALBOT_DEBUFF_SCORCHED                 = GetSpellInfo(134647) or "--Scorched";
	HEALBOT_DEBUFF_FREEZE                   = GetSpellInfo(135145) or "--Freeze";
	HEALBOT_DEBUFF_STORM_CLOUD              = GetSpellInfo(137669) or "--Storm Cloud";
	--HEALBOT_DEBUFF_ARCING_LIGHTNING         = GetSpellInfo(136193) or "--Arcing Lightning";
	--Twin Consorts
	HEALBOT_DEBUFF_FAN_OF_FLAMES            = GetSpellInfo(137408) or "--Fan of Flames";	
	HEALBOT_DEBUFF_BEAST_OF_NIGHTMARES      = GetSpellInfo(137375) or "--Beast of Nightmares";
	HEALBOT_DEBUFF_CORRUPTED_HEALING        = GetSpellInfo(137360) or "--Corrupted Healing";
	--HEALBOT_DEBUFF_FLAMES_OF_PASSION        = GetSpellInfo(137417) or "--Flames of Passion";
	--Lei Shen
	HEALBOT_DEBUFF_DECAPITATE               = GetSpellInfo(134919) or "--Decapitate";
	HEALBOT_DEBUFF_CRASHING_THUNDER         = GetSpellInfo(135153) or "--Crashing Thunder"; 
	HEALBOT_DEBUFF_STATIC_SHOCK             = GetSpellInfo(135703) or "--Static Shock"; 
	HEALBOT_DEBUFF_OVERCHARGED              = GetSpellInfo(136295) or "--Overcharged"; 
	HEALBOT_DEBUFF_HELM_OF_COMMAND          = GetSpellInfo(139011) or "--Helm of Command"; 
	HEALBOT_DEBUFF_ELECTRICAL_SHOCK         = GetSpellInfo(136914) or "--Electrical Shock";
	--[[HEALBOT_DEBUFF_CRASHING_THUNDER         = GetSpellInfo(135153) or "--Crashing Thunder";
	HEALBOT_DEBUFF_DISCHARGED_ENERGY        = GetSpellInfo(137446) or "--Discharged Energy";
	HEALBOT_DEBUFF_WINDBURN                 = GetSpellInfo(140208) or "--Windburn";]]
	--Ra-Den
	HEALBOT_DEBUFF_UNSTABLE_VITA            = GetSpellInfo(138297) or "--Unstable Vita";
	HEALBOT_DEBUFF_VITA_SENSITIVITY         = GetSpellInfo(138372) or "--Vita Sensitivity";
	
	--[[Updated 5.4 Mists of Pandaria Expansion by Ariá - Silvermoon EU 	
	= GetMapNameByID(953) or "--Siege of Orgrimmar"
	Trash]]
	HEALBOT_DEBUFF_LOCKED_ON                = GetSpellInfo(143828) or "--Locked On";
    HEALBOT_DEBUFF_OBLITERATING_STRIKE      = GetSpellInfo(146537) or "--Obliterating Strike";
	HEALBOT_DEBUFF_PIERCE                   = GetSpellInfo(146556) or "--Pierce";		
	HEALBOT_DEBUFF_BLOOD_OF_YSHAARJ         = GetSpellInfo(147554) or "--Blood of YShaarj";	
	HEALBOT_DEBUFF_REAPING_WHIRLWIND        = GetSpellInfo(147642) or "--Reaping Whirlwind";
	HEALBOT_DEBUFF_FIRE_PIT                 = GetSpellInfo(148718) or "--Fire Pit";
	HEALBOT_DEBUFF_OVERCONFIDENCE           = GetSpellInfo(145893) or "--Overconfidence";
	HEALBOT_DEBUFF_JEALOUSY                 = GetSpellInfo(146324) or "--Jealousy";
	HEALBOT_DEBUFF_GROWING_OVERCONFIDENCE   = GetSpellInfo(145940) or "--Growing Overconfidence";
	HEALBOT_DEBUFF_BRIBE                    = GetSpellInfo(145553) or "--Bribe";
	HEALBOT_DEBUFF_INTIMIDATING_SHOUT       = GetSpellInfo(5246) or "--Intimidating Shout";
	HEALBOT_DEBUFF_FULL_OF_MEAT             = GetSpellInfo(81252) or "--Full of Meat";
	HEALBOT_DEBUFF_SCORCHED_EARTH           = GetSpellInfo(146228) or "--Scorched Earth";
	HEALBOT_DEBUFF_DREAD_HOWL               = GetSpellInfo(146002) or "--Dread Howl";
	HEALBOT_DEBUFF_SLOW_AND_STEADY          = GetSpellInfo(146908) or "--Slow and Steady";
	HEALBOT_DEBUFF_RESONATING_AMBER         = GetSpellInfo(146452) or "--Resonating Amber";
	--Immerseus
	HEALBOT_DEBUFF_CORROSIVE_BLAST          = GetSpellInfo(143436) or "--Corrosive Blast";
	HEALBOT_DEBUFF_SHA_POOL                 = GetSpellInfo(143460) or "--Sha Pool";
	--HEALBOT_DEBUFF_SHA_SPLASH               = GetSpellInfo(143298) or "--Sha Splash";
	--The Fallen Protectors
	HEALBOT_DEBUFF_NOXIOUS_POISON           = GetSpellInfo(143225) or "--Noxious Poison";
	HEALBOT_DEBUFF_DEFILED_GROUND           = GetSpellInfo(144357) or "--Defiled Ground";
	HEALBOT_DEBUFF_VENGEFUL_STRIKES         = GetSpellInfo(144397) or "--Vengeful Strikes";
	HEALBOT_DEBUFF_CORRUPTION_KICK          = GetSpellInfo(143009) or "--Corruption Kick";
	HEALBOT_DEBUFF_GARROTE                  = GetSpellInfo(143198) or "--Garrote"; 
	HEALBOT_DEBUFF_GOUGE                    = GetSpellInfo(1776) or "--Gouge";
	HEALBOT_DEBUFF_MARK_OF_ANGUISH          = GetSpellInfo(144365) or "--Mark of Anguish";
	HEALBOT_DEBUFF_FIXATE                   = GetSpellInfo(143292) or "--Fixate";
	HEALBOT_DEBUFF_SHA_SEAR                 = GetSpellInfo(143424) or "--Sha Sear";
	--[[HEALBOT_DEBUFF_DEBILITATION             = GetSpellInfo(147383) or "--Debilitation";
	HEALBOT_DEBUFF_SHADOWED_WEAKNESS        = GetSpellInfo(144176) or "--Shadowed Weakness";
	HEALBOT_DEBUFF_CORRUPTED_BREW           = GetSpellInfo(143023) or "--Corrupted Brew"; ]]
	--Norushen
	HEALBOT_DEBUFF_SELF_DOUBT               = GetSpellInfo(146124) or "--Self Doubt";
    HEALBOT_DEBUFF_BOTTOMLESS_PIT           = GetSpellInfo(146703) or "--Bottomless Pit";
	HEALBOT_DEBUFF_DISHEARTENING_LAUGH      = GetSpellInfo(146707) or "--Disheartening Laugh";
	--[[HEALBOT_DEBUFF_TEST_OF_SERENITY         = GetSpellInfo(144849) or "--Test of Serenity";
	HEALBOT_DEBUFF_TEST_OF_RELIANCE         = GetSpellInfo(144850) or "--Test of Serenity";
	HEALBOT_DEBUFF_TEST_OF_CONDIDENCE       = GetSpellInfo(144851) or "--Test of Confidence";
	HEALBOT_DEBUFF_DESPAIR                  = GetSpellInfo(145725) or "--Despair";]]
	--Sha of Pride
	HEALBOT_DEBUFF_WOUNDED_PRIDE            = GetSpellInfo(144358) or "--Wounded Pride";
	HEALBOT_DEBUFF_CORRUPTED_PRISON         = GetSpellInfo(144574) or "--Corrupted Prison";
	HEALBOT_DEBUFF_BANISHMENT               = GetSpellInfo(145215) or "--Banishment";
	HEALBOT_DEBUFF_REACHING_ATTACK          = GetSpellInfo(119775) or "--Reaching Attack";
	HEALBOT_DEBUFF_MARK_OF_ARROGANCE        = GetSpellInfo(144351) or "--Mark of Arrogance";
	HEALBOT_DEBUFF_AURA_OF_PRIDE            = GetSpellInfo(146818) or "--Aura of Pride";
    --Galakras
	HEALBOT_DEBUFF_FRACTURE                 = GetSpellInfo(147200) or "--Fracture";
	HEALBOT_DEBUFF_POISON_CLOUD             = GetSpellInfo(147705) or "--Poison Cloud";
	--[[HEALBOT_DEBUFF_FLAME_ARROWS             = GetSpellInfo(146763) or "--Flame Arrows";
	HEALBOT_DEBUFF_FLAMES_OF_GALAKROND      = GetSpellInfo(147029) or "--Flames of Galakrond";]]
	--Iron Juggernaut
	HEALBOT_DEBUFF_LASER_BURN               = GetSpellInfo(144459) or "--Laser Burn";
	HEALBOT_DEBUFF_IGNITE_ARMOUR            = GetSpellInfo(144467) or "--Ignite Armour";
	HEALBOT_DEBUFF_EXPLOSIVE_TAR            = GetSpellInfo(144498) or "--Explosive Tar";
	HEALBOT_DEBUFF_CUTTER_LASER_TARGET      = GetSpellInfo(146325) or "--Cutter Laser Target";
	--Kor'kron Dark Shaman
	HEALBOT_DEBUFF_REND                     = GetSpellInfo(17153)  or "--Rend";
	HEALBOT_DEBUFF_FROSTSTORM_STRIKE        = GetSpellInfo(144215) or "--Froststorm Strike";
	HEALBOT_DEBUFF_TOXIC_MIST               = GetSpellInfo(144089) or "--Toxic Mist";
	HEALBOT_DEBUFF_IRON_PRISON              = GetSpellInfo(144331) or "--Iron Prison";
	--[[HEALBOT_DEBUFF_FOUL_GEYSER              = GetSpellInfo(143993) or "--Foul Geyser";
	--HEALBOT_DEBUFF_TOXICITY                 = GetSpellInfo(144089) or "--Toxicity";]]
	--General Nazgrim 
	HEALBOT_DEBUFF_SUNDERING_BLOW           = GetSpellInfo(143494) or "--Sundering Blow";
	HEALBOT_DEBUFF_BONECRACKER              = GetSpellInfo(143638) or "--Bonecracker";
	HEALBOT_DEBUFF_ASSASSINS_MARK           = GetSpellInfo(143480) or "--Assassins Mark";
	HEALBOT_DEBUFF_HUNTERS_MARK             = GetSpellInfo(143882) or "--Hunters Mark";
	--Malkorok
	HEALBOT_DEBUFF_FATAL_STRIKE             = GetSpellInfo(142990) or "--Fatal Strike";
	HEALBOT_WEEK_ANCIENT_BARRIER            = GetSpellInfo(142863) or "--Week Ancient Barrier";
	HEALBOT_ANCIENT_BARRIER                 = GetSpellInfo(142864) or "--Ancient Barrier";
	HEALBOT_STRONG_ANCIENT_BARRIER          = GetSpellInfo(142865) or "--Strong Ancient Barrier";
	--[[HEALBOT_DEBUFF_ANCIENT_MIASMA           = GetSpellInfo(142861) or "--Ancient Miasma";
	HEALBOT_DEBUFF_LANGUISH                 = GetSpellInfo(142989) or "--Languish";]]
	--Spoils of Pandaria
	HEALBOT_DEBUFF_SET_TO_BLOW              = GetSpellInfo(145993) or "--Set to Blow";
	HEALBOT_DEBUFF_CARNIVOROUS_BITE         = GetSpellInfo(144853) or "--Carnivorous Bite";
	HEALBOT_DEBUFF_ENCAPSULATED_PHEROMONES  = GetSpellInfo(142524) or "--Encapsulated Pheromones";
	HEALBOT_DEBUFF_KEG_TOSS                 = GetSpellInfo(146217) or "--Keg Toss";
	HEALBOT_DEBUFF_GUSTING_BOMB             = GetSpellInfo(145712) or "--Gusting Bomb";
	--HEALBOT_DEBUFF_UNSTABLE_DEFENSE_SYSTEMS = GetSpellInfo(145688) or "--Unstable Defense Systems";
	--Thok the Bloodthirsty
	HEALBOT_DEBUFF_PANIC                  = GetSpellInfo(143766) or "--Panic";
	HEALBOT_DEBUFF_TAIL_LASH              = GetSpellInfo(143428) or "--Tail Lash";
	HEALBOT_DEBUFF_FIXATE                 = GetSpellInfo(143445) or "--Fixate";
	HEALBOT_DEBUFF_ACID_BREATH            = GetSpellInfo(143780) or "--Acid Breath";
	HEALBOT_DEBUFF_FREEZING_BREATH        = GetSpellInfo(143773) or "--Freezing Breath";
	HEALBOT_DEBUFF_SCORCHING_BREATH       = GetSpellInfo(143767) or "--Scorching Breath";
	--[[HEALBOT_DEBUFF_BURNING_BLOOD          = GetSpellInfo(143783) or "--Burning Blood";
	HEALBOT_DEBUFF_ICY_BLOOD              = GetSpellInfo(143800) or "--Icy Blood";
	HEALBOT_DEBUFF_BLOODIED              = GetSpellInfo(143452) or "--Bloodied";]]
	--Siegecrafter Blackfuse
	HEALBOT_DEBUFF_ELECTROSTATIC_CHARGE   = GetSpellInfo(143385) or "--Electrostatic Charge";
	HEALBOT_DEBUFF_OVERLOAD               = GetSpellInfo(145444) or "--Overload";
	HEALBOT_DEBUFF_SUPERHEATED            = GetSpellInfo(143856) or "--Superheated";
	--HEALBOT_DEBUFF_MAGNETIC_CRUSH         = GetSpellInfo(144466) or "--Magnetic Crush";
	--Paragons of the Klaxxi
	HEALBOT_DEBUFF_MUTATE                 = GetSpellInfo(143337) or "--Mutate";
	HEALBOT_DEBUFF_EXPOSED_VEINS          = GetSpellInfo(142931) or "--Exposed Veins";   
	HEALBOT_DEBUFF_GOUGE                  = GetSpellInfo(34940) or "--Gouge";
	HEALBOT_DEBUFF_CAUSTIC_BLOOD          = GetSpellInfo(142315) or "--Caustic Blood";
	HEALBOT_DEBUFF_TENDERZING_STRIKES     = GetSpellInfo(142929) or "--Tenderzing Strikes";
	HEALBOT_DEBUFF_MEZMERIZE              = GetSpellInfo(142668) or "--Mezmerize";
	HEALBOT_DEBUFF_SHIELD_BASH            = GetSpellInfo(143974) or "--Shield Bash";
	HEALBOT_DEBUFF_CAUSTIC_AMBER          = GetSpellInfo(143735) or "--Caustic Amber";
	HEALBOT_DEBUFF_HEWN                   = GetSpellInfo(143275) or "--Hewn";
	HEALBOT_DEBUFF_GENETIC_ALTERATION     = GetSpellInfo(143278) or "--Genetic Alteration"; 
	HEALBOT_DEBUFF_INJECTION              = GetSpellInfo(143339) or "--Injection";
	HEALBOT_DEBUFF_AIM                    = GetSpellInfo(142948) or "--Aim";
	HEALBOT_DEBUFF_WHIRLING               = GetSpellInfo(143702) or "--Whirling";
	HEALBOT_DEBUFF_FIERY_EDGE             = GetSpellInfo(142808) or "--Fiery Edge";
	HEALBOT_DEBUFF_FEED                   = GetSpellInfo(143362) or "--Feed";
	HEALBOT_DEBUFF_NOXIOUS_VAPORS         = GetSpellInfo(142797) or "--Noxious Vapors";
	HEALBOT_DEBUFF_CANNED_HEAT            = GetSpellInfo(143576) or "--Canned Heat";
	HEALBOT_DEBUFF_EERIE_FOG              = GetSpellInfo(142945) or "--Eerie Fog";
	--[[HEALBOT_DEBUFF_CHILLED_TO_THE_BONE    = GetSpellInfo(144216) or "--Chilled to the Bone";
	HEALBOT_DEBUFF_HUNGER                 = GetSpellInfo(143358) or "--Hunger";]]
	--Garrosh Hellscream
	HEALBOT_DEBUFF_HAMSTRING              = GetSpellInfo(26141) or "--Hamstring";
	HEALBOT_DEBUFF_DESECRATED             = GetSpellInfo(144762) or "--Desecrated";
    HEALBOT_DEBUFF_EMBODIED_DOUBT         = GetSpellInfo(149347) or "--Embodied Doubt";
	HEALBOT_DEBUFF_TOUCH_OF_YSHAARJ       = GetSpellInfo(145065) or "--Touch of Y'Shaarj";
	HEALBOT_DEBUFF_EMPOWERED_TOUCH_OF_YSHAARJ = GetSpellInfo(145171) or "--Empowered Touch of Y'Shaarj";
	HEALBOT_DEBUFF_GRIPPING_DESPAIR       = GetSpellInfo(145183) or "--Gripping Despair";
	HEALBOT_DEBUFF_EMPOWERED_GRIPPING_DESPAIR = GetSpellInfo(145195) or "--Empowered Gripping Despair";
    HEALBOT_DEBUFF_EXPLOSIVE_DESPAIR      = GetSpellInfo(145213) or "--Explosive Despair";
	HEALBOT_DEBUFF_MALICE                 = GetSpellInfo(147209) or "--Malice";
	HEALBOT_DEBUFF_MALICIOUS_BLAST        = GetSpellInfo(147235) or "--Malicious Blast";
	HEALBOT_DEBUFF_FIXATE                 = GetSpellInfo(147665) or "--Fixate";
	HEALBOT_DEBUFF_NAPALM                 = GetSpellInfo(147136) or "--Napalm";
	HEALBOT_DEBUFF_FAITH                  = GetSpellInfo(148994) or "--Faith"; --Buff
	HEALBOT_DEBUFF_HOPE                   = GetSpellInfo(149004) or "--Hope"; --Buff
	HEALBOT_DEBUFF_COURAGE                = GetSpellInfo(148983) or "--Courage"; --Buff
	--HEALBOT_DEBUFF_DESECRATED             = GetSpellInfo(144762) or "--Desecrated";
end

HealBot_globalVars()

if GetLocale()=="ptBR" then
    HEALBOT_ALT_RENEWING_MIST = "Brumas da Renovação"
else
    HEALBOT_ALT_RENEWING_MIST = HEALBOT_RENEWING_MIST
end