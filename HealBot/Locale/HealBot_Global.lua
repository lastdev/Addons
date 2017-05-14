HEALBOT_VERSION   = "7.2.0.0";
HEALBOT_ABOUT_URL = "http://healbot.darktech.org/"

function HealBot_globalVars()
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

    --Items
    HEALBOT_BLOOM                           = GetSpellInfo(176160) or "--Bloom"
    HEALBOT_EVER_BLOOMING_FROND             = GetItemInfo(118935) or "--Ever-Blooming Frond"
    HEALBOT_ORALIUS_WHISPERING_CRYSTAL      = GetItemInfo(118922) or "--Oralius' Whispering Crystal";
    HEALBOT_WHISPERS_OF_INSANITY            = GetSpellInfo(176151) or "--Whispers of Insanity"
    HEALBOT_SHROUD_OF_THE_NAGLFAR           = GetSpellInfo(215247) or "--Shroud of the Naglfar"
    HEALBOT_SPIRIT_FRAGMENT                 = GetSpellInfo(221878) or "--Spirit Fragment"
    HEALBOT_NORGANNONS_FORESIGHT            = GetSpellInfo(208215) or "--Norgannon's Foresight";

    --Racial Abilities
    HEALBOT_DARKFLIGHT                      = GetSpellInfo(68992) or "--Darkflight";
    HEALBOT_GIFT_OF_THE_NAARU               = GetSpellInfo(59547) or "--Gift of the Naaru";
    HEALBOT_STONEFORM                       = GetSpellInfo(20594) or "--Stoneform";

    --Harmful Spells
    --Death Knight
    HEALBOT_DEATH_COIL                      = GetSpellInfo(47541) or "--Death Coil"
    HEALBOT_PLAGUE_STRIKE                   = GetSpellInfo(45462) or "--Plague Strike"
    --Demon Hunter
    --Druid
    HEALBOT_CYCLONE                         = GetSpellInfo(33786) or "--Cyclone"
    HEALBOT_ENTANGLING_ROOTS                = GetSpellInfo(339)  or "--Entangling Roots"
    HEALBOT_FAERIE_FIRE                     = GetSpellInfo(770)  or "--Faerie Fire"
    HEALBOT_FAERIE_SWARM                    = GetSpellInfo(106707) or "--Faerie Swarm"
    HEALBOT_GROWL                           = GetSpellInfo(6795) or "--Growl"
    HEALBOT_HURRICANE                       = GetSpellInfo(16914)  or "--Hurricane"
    HEALBOT_MASS_ENTANGLEMENT               = GetSpellInfo(102359) or "--Mass Entanglement"
    HEALBOT_MOONFIRE                        = GetSpellInfo(8921) or "--Moonfire"
    HEALBOT_SOOTHE                          = GetSpellInfo(2908) or "--Soothe"
    HEALBOT_WRATH                           = GetSpellInfo(5176)  or "--Wrath"
    --Hunter
    HEALBOT_AIMED_SHOT                      = GetSpellInfo(19434) or "--Aimed Shot"  
    HEALBOT_ARCANE_SHOT                     = GetSpellInfo(3044) or "--Arcane Shot"
    HEALBOT_CONCUSSIVE_SHOT                 = GetSpellInfo(5116) or "--Concussive Shot"
    --Mage
    HEALBOT_FIRE_BLAST                      = GetSpellInfo(2136) or "--Fire Blast" 
    HEALBOT_FROSTFIRE_BOLT                  = GetSpellInfo(44614) or "--Frostfire Bolt"
    HEALBOT_MAGE_BOMB                       = GetSpellInfo(125430) or "--Mage Bomb" 
    --Monk
    HEALBOT_BLACKOUT_KICK                   = GetSpellInfo(100784) or "--Blackout Kick"
    HEALBOT_CHI_BURST                       = GetSpellInfo(123986) or "--Chi Burst"
    HEALBOT_CRACKLING_JADE_LIGHTNING        = GetSpellInfo(117952) or "--Crackling Jade Lightning"
    HEALBOT_DISABLE                         = GetSpellInfo(116095) or "--Disable"
    HEALBOT_JAB                             = GetSpellInfo(100780) or "--Jab"
    HEALBOT_PARALYSIS                       = GetSpellInfo(115078) or "--Paralysis"
    HEALBOT_PROVOKE                         = GetSpellInfo(115546) or "--Provoke"
    HEALBOT_SPEAR_HAND_STRIKE               = GetSpellInfo(116705) or "--Spear Hand Strike"
    HEALBOT_TIGER_PALM                      = GetSpellInfo(100787) or "--Tiger Palm"
    HEALBOT_TOUCH_OF_DEATH                  = GetSpellInfo(115080) or "--Touch of Death"
    --Paladin
    HEALBOT_BINDING_LIGHT                   = GetSpellInfo(115750) or "--Blinding Light"
    HEALBOT_CRUSADER_STRIKE                 = GetSpellInfo(35395) or "--Crusader Strike"
    HEALBOT_DENOUNCE                        = GetSpellInfo(2812) or "--Denounce"
    HEALBOT_HAMMER_OF_JUSTICE               = GetSpellInfo(853) or "--Hammer of Justice"
    HEALBOT_HAMMER_OF_WRATH                 = GetSpellInfo(24275) or "--Hammer of Wrath"
    HEALBOT_HOLY_SHOCK                      = GetSpellInfo(20473) or "--Holy Shock"
    HEALBOT_JUDGMENT                        = GetSpellInfo(20271) or "--Judgment"
    HEALBOT_REBUKE                          = GetSpellInfo(96231) or "--Rebuke"
    HEALBOT_RECKONING                       = GetSpellInfo(62124) or "--Reckoning"
    HEALBOT_REPENTANCE                      = GetSpellInfo(20066) or "--Repentance"
    HEALBOT_TURN_EVIL                       = GetSpellInfo(10326) or "--Turn Evil"
    --Priest
    HEALBOT_DOMINATE_MIND                   = GetSpellInfo(605) or "--Dominate Mind"
    HEALBOT_HOLY_FIRE                       = GetSpellInfo(14914) or "--Holy Fire"
    HEALBOT_MIND_SEAR                       = GetSpellInfo(48045) or "--Mind Sear"
    HEALBOT_MINDBENDER                      = GetSpellInfo(123040) or "--Mindbender"
    HEALBOT_SHACKLE_UNDEAD                  = GetSpellInfo(9484) or "--Shackle Undead"
    HEALBOT_SHADOW_WORD_PAIN                = GetSpellInfo(589) or "--Shadow Word: Pain"
    HEALBOT_SHADOW_WORD_DEATH               = GetSpellInfo(32379) or "--Shadow Word: Death"
    HEALBOT_SMITE                           = GetSpellInfo(585) or "--Smite"
    HEALBOT_HOLY_WORD_CHASTISE              = GetSpellInfo(88625) or "--Holy Word: Chastise";
    HEALBOT_DISPEL_MAGIC                    = GetSpellInfo(528) or "--Dispel Magic"
    --Rogue
    HEALBOT_GOUGE                           = GetSpellInfo(1776) or "--Gouge"
    HEALBOT_THROW                           = GetSpellInfo(121733) or "--Throw"  
    --Shaman
    HEALBOT_CHAIN_LIGHTNING                 = GetSpellInfo(421) or "--Chain Lightning"
    HEALBOT_EARTH_SHOCK                     = GetSpellInfo(8042) or "--Earth Shock"
    HEALBOT_ELEMENTAL_BLAST                 = GetSpellInfo(8056) or "--Elemental Blast"
    HEALBOT_FLAME_SHOCK                     = GetSpellInfo(8050) or "--Flame Shock"
    HEALBOT_FROST_SHOCK                     = GetSpellInfo(8056) or "--Frost Shock"
    HEALBOT_HEX                             = GetSpellInfo(51514) or "--Hex"
    HEALBOT_LAVA_BLAST                      = GetSpellInfo(51505) or "--Lava Blast"
    HEALBOT_LIGHTNING_BOLT                  = GetSpellInfo(403) or "--Lightning Bolt"
    HEALBOT_PRIMAL_STRIKE                   = GetSpellInfo(73899) or "--Primal Strike"
    HEALBOT_PURGE                           = GetSpellInfo(370) or "--Purge"
    HEALBOT_WIND_SHEAR                      = GetSpellInfo(57994) or "--Wind Shear" 
    --Warlock
    HEALBOT_CORRUPTION                      = GetSpellInfo(172) or "--Corruption" 
    HEALBOT_FEAR                            = GetSpellInfo(5782) or "--Fear"   
    --Warrior
    HEALBOT_EXECUTE                         = GetSpellInfo(5308) or "--Execute"
    HEALBOT_TAUNT                           = GetSpellInfo(355) or "--Taunt"

    --Healing Spells By Class 
    --Druid
    HEALBOT_CENARION_WARD                   = GetSpellInfo(102351) or "--Cenarion Ward";
    HEALBOT_HEALING_TOUCH                   = GetSpellInfo(5185) or "--Healing Touch";
    HEALBOT_LIFEBLOOM                       = GetSpellInfo(33763) or "--Lifebloom";
    HEALBOT_REGROWTH                        = GetSpellInfo(8936) or "--Regrowth";
    HEALBOT_REJUVENATION                    = GetSpellInfo(774) or "--Rejuvenation";
    HEALBOT_SWIFTMEND                       = GetSpellInfo(18562) or "--Swiftmend";
    HEALBOT_TRANQUILITY                     = GetSpellInfo(740) or "--Tranquility";
    HEALBOT_WILD_GROWTH                     = GetSpellInfo(48438) or "--Wild Growth";
    --Monk
    HEALBOT_CHI_WAVE                        = GetSpellInfo(132463) or "--Chi Wave"
    HEALBOT_CHI_BURST                       = GetSpellInfo(130651) or "--Chi Burst"
    HEALBOT_ENVELOPING_MIST                 = GetSpellInfo(124682) or "--Enveloping Mist"
    HEALBOT_RENEWING_MIST                   = GetSpellInfo(115151) or "--Renewing Mist"
    HEALBOT_REVIVAL                         = GetSpellInfo(115310) or "--Revival"
    HEALBOT_SOOTHING_MIST                   = GetSpellInfo(115175) or "--Soothing Mist" 
    HEALBOT_SURGING_MIST                    = GetSpellInfo(116694) or "--Surging Mist" 
    HEALBOT_UPLIFT                          = GetSpellInfo(116670) or "--Uplift"
    HEALBOT_ZEN_MEDITATION                  = GetSpellInfo(115176) or "--Zen Meditation"
    HEALBOT_ZEN_SPHERE                      = GetSpellInfo(124081) or "--Zen Sphere"
    --Paladin
    HEALBOT_FLASH_OF_LIGHT                  = GetSpellInfo(19750) or "--Flash of Light";
    HEALBOT_HOLY_LIGHT                      = GetSpellInfo(82326) or "--Holy Light";
    HEALBOT_HOLY_PRISM                      = GetSpellInfo(114165) or "--Holy Prism";
    HEALBOT_HOLY_RADIANCE                   = GetSpellInfo(82327) or "--Holy Radiance";
    HEALBOT_LIGHT_OF_DAWN                   = GetSpellInfo(85222) or "--Light of Dawn";
    HEALBOT_WORD_OF_GLORY                   = GetSpellInfo(85673) or "--Word of Glory";
    --Priest
    HEALBOT_BINDING_HEAL                    = GetSpellInfo(32546) or "--Binding Heal"
    HEALBOT_CASCADE                         = GetSpellInfo(121135) or "--Cascade"
    HEALBOT_CIRCLE_OF_HEALING               = GetSpellInfo(204883) or "--Circle of Healing";
    HEALBOT_DESPERATE_PRAYER                = GetSpellInfo(19236) or "--Desperate Prayer";
    HEALBOT_DIVINE_HYMN                     = GetSpellInfo(64843) or "--Divine Hymn";
    HEALBOT_DIVINE_STAR                     = GetSpellInfo(110744) or "--Divine Star"
    HEALBOT_FLASH_HEAL                      = GetSpellInfo(2061) or "--Flash Heal";
    HEALBOT_HALO                            = GetSpellInfo(120517) or "--Halo"
    HEALBOT_HEAL                            = GetSpellInfo(2060) or "--Heal";
   -- HEALBOT_HOLY_WORD_SANCTUARY             = GetSpellInfo(88685) or "--Holy Word: Sanctuary";
    HEALBOT_HOLY_WORD_SERENITY              = GetSpellInfo(2050) or "--Holy Word: Serenity";
    HEALBOT_PENANCE                         = GetSpellInfo(47540) or "--Penance"
    HEALBOT_PRAYER_OF_HEALING               = GetSpellInfo(596) or "--Prayer of Healing";
    HEALBOT_PRAYER_OF_MENDING               = GetSpellInfo(33076) or "--Prayer of Mending";
    HEALBOT_RENEW                           = GetSpellInfo(139) or "--Renew";
	--Legion Added
	HEALBOT_PLEA                            = GetSpellInfo(200829) or "--Plea";	
	HEALBOT_POWER_WORD_RADIANCE             = GetSpellInfo(194509) or "--Power Word: Radiance";
	HEALBOT_SHADOW_MEND                     = GetSpellInfo(186263) or "--Shadow Mend;"
	HEALBOT_HOLY_WORD_SANCTIFY              = GetSpellInfo(34861) or "--Holy Word: Sanctify";
	
    --Shaman
    HEALBOT_CHAIN_HEAL                      = GetSpellInfo(1064) or "--Chain Heal";
    HEALBOT_HEALING_RAIN                    = GetSpellInfo(73920) or "--Healing Rain";
    HEALBOT_HEALING_STREAM_TOTEM            = GetSpellInfo(119523) or "--Healing Stream Totem";
    HEALBOT_HEALING_SURGE                   = GetSpellInfo(8004) or "--Healing Surge";
    HEALBOT_HEALING_TIDE_TOTEM              = GetSpellInfo(108280) or "--Healing Tide Totem";
    HEALBOT_HEALING_WAVE                    = GetSpellInfo(77472) or "--Healing Wave";
    HEALBOT_RIPTIDE                         = GetSpellInfo(61295) or "--Riptide";
    --Warlock
    HEALBOT_HEALTH_FUNNEL                   = GetSpellInfo(755) or "--Health Funnel";

    
    --Buffs, Talents, Glyphs and Other Spells By Class
    --Death Knight
    HEALBOT_ANTIMAGIC_SHELL                 = GetSpellInfo(48707) or "--Antimagic Shell";
    HEALBOT_ANTIMAGIC_ZONE                  = GetSpellInfo(51052) or "--Antimagic Zone";
    HEALBOT_ARMY_OF_THE_DEAD                = GetSpellInfo(42650) or "--Army of the Dead";
    HEALBOT_BONE_SHIELD                     = GetSpellInfo(49222) or "--Bone Shield";
    HEALBOT_DANCING_RUNE_WEAPON             = GetSpellInfo(49028) or "--Dancing Rune Weapon"
    HEALBOT_HORN_OF_WINTER                  = GetSpellInfo(57330) or "--Horn of Winter";
    HEALBOT_ICEBOUND_FORTITUDE              = GetSpellInfo(48792) or "--Icebound Fortitude";
    HEALBOT_LICHBORNE                       = GetSpellInfo(49039) or "--Lichborne";
    HEALBOT_POWER_OF_THE_GRAVE              = GetSpellInfo(155522) or "--Power of the Grave";  
    HEALBOT_SHROUD_OF_PURGATORY             = GetSpellInfo(116888) or "--Shroud of Purgatory"; 
    HEALBOT_UNHOLY_AURA                     = GetSpellInfo(55610) or "--Unholy Aura"
    HEALBOT_VAMPIRIC_BLOOD                  = GetSpellInfo(55233) or "--Vampiric Blood";
    
    --Demon Hunter
    HEALBOT_DEMON_SPIKES                    = GetSpellInfo(203720) or "--Demon Spikes";
    HEALBOT_BLUR                            = GetSpellInfo(198589) or "--Blur"
    HEALBOT_EMPOWER_WARDS                   = GetSpellInfo(218256) or "--Empower Wards";
    HEALBOT_METAMORPHOSIS                   = GetSpellInfo(187827) or "--Metamorphosis";
    
	--Druid
    HEALBOT_BARKSKIN                        = GetSpellInfo(22812) or "--Barkskin";
    HEALBOT_DRUID_CLEARCASTING              = GetSpellInfo(16870) or "--Clearcasting";
    HEALBOT_FRENZIED_REGEN                  = GetSpellInfo(22842) or "--Frenzied Regeneration";
    HEALBOT_HARMONY                         = GetSpellInfo(77495) or "--Mastery Harmony";
    HEALBOT_IRONBARK                        = GetSpellInfo(102342) or "--Ironbark";
    HEALBOT_IRONFUR                         = GetSpellInfo(192081) or "--Ironfur";
    HEALBOT_LEADER_OF_THE_PACK              = GetSpellInfo(17007) or "--Leader of the Pack";
    HEALBOT_LIVING_SEED                     = GetSpellInfo(48500) or "--Living Seed";
    HEALBOT_MARK_OF_THE_WILD                = GetSpellInfo(1126) or "--Mark of the Wild";
    HEALBOT_MOONKIN_AURA                    = GetSpellInfo(24907) or "--Moonkin Aura";
    HEALBOT_NATURE_MOMENT_OF_CLARITY        = GetSpellInfo(155577) or "--Moment of Clarity";
    HEALBOT_NATURE_REJUVENATION_GERMINATION = GetSpellInfo(155777) or "--Rejuvenation (Germination)";
    HEALBOT_NATURE_RAMPANT_GROWTH           = GetSpellInfo(155834) or "--Rampant Growth";
    HEALBOT_SAVAGE_DEFENCE                  = GetSpellInfo(62606) or "--Savage Defense";
    HEALBOT_SURVIVAL_INSTINCTS              = GetSpellInfo(61336) or "--Survival Instincts";
    HEALBOT_TREE_OF_LIFE                    = GetSpellInfo(33891) or "--Tree of Life";
	--Legion Added
	HEALBOT_SPRING_BLOSSOMS                 = GetSpellInfo(207385) or "--Spring Blossoms";
    HEALBOT_CULTIVATION                     = GetSpellInfo(200390) or "--Cultivation";
    HEALBOT_INNERVATE                       = GetSpellInfo(29166) or "--Innervate";
    HEALBOT_ESSENCE_OF_GHANIR               = GetSpellInfo(208253) or "--Essence of G'Hanir"
    
	--Hunter
    HEALBOT_A_CHEETAH                       = GetSpellInfo(5118) or "--Aspect of the Cheetah"
    HEALBOT_A_PACK                          = GetSpellInfo(13159) or "--Aspect of the Pack"
    HEALBOT_A_WILD                          = GetSpellInfo(20043) or "--Aspect of the Wild"
    HEALBOT_DETERRENCE                      = GetSpellInfo(19263) or "--Deterrence"
    HEALBOT_LW_FEROCITY_OF_THE_RAPTOR       = GetSpellInfo(160200) or "--Lone Wolf: Ferocity of the Raptor"
    HEALBOT_LW_FORTITUDE_OF_THE_BEAR        = GetSpellInfo(160199) or "--Lone Wolf: Fortitude of the Bear"
    HEALBOT_LW_GRACE_OF_THE_CAT             = GetSpellInfo(160198) or "--Lone Wolf: Grace of the Cat"
    HEALBOT_LW_HASTE_OF_THE_HYENA           = GetSpellInfo(160203) or "--Lone Wolf: Haste of the Hyena"
    HEALBOT_LW_POWER_OF_THE_PRIMATES        = GetSpellInfo(160206) or "--Lone Wolf: Power of the Primates"
    HEALBOT_LW_QUICKNESS_OF_THE_DRAGONHAWK  = GetSpellInfo(172968) or "--Lone Wolf: Quickness of the Dragonhawk"
    HEALBOT_LW_VERSATILITY_OF_THE_RAVAGER   = GetSpellInfo(172967) or "--Lone Wolf: Versatility of the Ravager"
    HEALBOT_LW_WISDOM_OF_THE_SERPENT        = GetSpellInfo(160205) or "--Lone Wolf: Wisdom of the Serpent"
    HEALBOT_MENDPET                         = GetSpellInfo(136) or "--Mend Pet"
    HEALBOT_TRAP_LAUNCHER                   = GetSpellInfo(77769) or "--Trap Launcher"
    HEALBOT_TRUESHOT_AURA                   = GetSpellInfo(19506) or "--Trueshot Aura"
    
	--Hunter Pets
    HEALBOT_BARK_OF_THE_WILD                = GetSpellInfo(159988) or "--Bark of the Wild"
    HEALBOT_BLESSING_OF_KONGS               = GetSpellInfo(160017) or "--Blessing of Kongs"
    HEALBOT_BREATH_OF_THE_WINDS             = GetSpellInfo(24844) or "--Breath of the Winds"
    HEALBOT_CACKLING_HOWL                   = GetSpellInfo(128432) or "--Cackling Howl"
    HEALBOT_CHITINOUS_ARMOR                 = GetSpellInfo(50518) or "--Chitinous Armor"
    HEALBOT_DEFENSIVE_QUILLS                = GetSpellInfo(160045) or "--Defensive Quills"
    HEALBOT_DOUBLE_BITE                     = GetSpellInfo(58604) or "--Double Bite"
    HEALBOT_EMBRACE_OF_THE_SHALE_SPIDER     = GetSpellInfo(90363) or "--Embrace of the Shale Spider"
    HEALBOT_ENERGIZING_SPORES               = GetSpellInfo(135678) or "--Energizing Spores"
    HEALBOT_FEARLESS_ROAR                   = GetSpellInfo(126373) or "--Fearless Roar"
    HEALBOT_FURIOUS_HOWL                    = GetSpellInfo(24604) or "--Furious Howl"
    HEALBOT_GRACE                           = GetSpellInfo(173035) or "--Grace"
    HEALBOT_INVIGORATING_ROAR               = GetSpellInfo(50256) or "--Invigorating Roar"
    HEALBOT_INDOMITABLE                     = GetSpellInfo(35290) or "--Indomitable"
    HEALBOT_KEEN_SENSES                     = GetSpellInfo(160039) or "--Keen Senses"
    HEALBOT_PLAINSWALKING                   = GetSpellInfo(160073) or "--Plainswalking"
    HEALBOT_QIRAJI_FORTITUDE                = GetSpellInfo(90364) or "--Qiraji Fortitude"
    HEALBOT_ROAR_OF_COURAGE                 = GetSpellInfo(93435) or "--Roar of Courage"
    HEALBOT_SONIC_FOCUS                     = GetSpellInfo(50519) or "--Sonic Focus"
    HEALBOT_SAVAGE_VIGOR                    = GetSpellInfo(160003) or "--Savage Vigor"
    HEALBOT_SERPENTS_CUNNING                = GetSpellInfo(128433) or "--Serpent's Cunning"
    HEALBOT_SPEED_OF_THE_SWARM              = GetSpellInfo(160074) or "--Speed of the Swarm"
    HEALBOT_SPIRIT_BEAST_BLESSING           = GetSpellInfo(128997) or "--Spirit Beast Blessing"
    HEALBOT_SPRY_ATTACKS                    = GetSpellInfo(34889) or "--Spry Attacks"
    HEALBOT_STILL_WATER                     = GetSpellInfo(126309) or "--Still Water"
    HEALBOT_STRENGTH_OF_THE_EARTH           = GetSpellInfo(160077) or "--Strength of the Earth"
    HEALBOT_STRENGTH_OF_THE_PACK            = GetSpellInfo(160052) or "--Strength of the Pack"
    HEALBOT_STURDINESS                      = GetSpellInfo(160014) or "--Sturdiness"
    HEALBOT_TENACITY                        = GetSpellInfo(159735) or "--Tenacity"
    HEALBOT_TERRIFYING_ROAR                 = GetSpellInfo(90309) or "--Terrifying Roar"
    HEALBOT_WILD_STRENGTH                   = GetSpellInfo(57386) or "--Wild Strength"
    
	--Mage
    HEALBOT_ARCANE_BRILLIANCE               = GetSpellInfo(1459) or "--Arcane Brilliance";
    HEALBOT_DALARAN_BRILLIANCE              = GetSpellInfo(61316) or "--Dalaran Brilliance";
    HEALBOT_EVOCATION                       = GetSpellInfo(12051) or "--Evocation";
    HEALBOT_FOCUS_MAGIC                     = GetSpellInfo(54646) or "--Focus Magic";
    HEALBOT_ICE_BARRIER                     = GetSpellInfo(11426) or "--Ice Barrier"
    HEALBOT_INCANTERS_WARD                  = GetSpellInfo(1463) or "--Incanter's Ward"
    HEALBOT_ICE_BLOCK                       = GetSpellInfo(45438) or "--Ice Block"
    HEALBOT_ICE_WARD                        = GetSpellInfo(111264) or "--Ice Ward"
    HEALBOT_MAGE_WARD                       = GetSpellInfo(543) or "--Mage Ward";
    HEALBOT_TEMPORAL_SHIELD                 = GetSpellInfo(115610) or "--Temporal Shield"
    
	--Paladin
    HEALBOT_ARDENT_DEFENDER                 = GetSpellInfo(31850) or "--Ardent Defender";
    HEALBOT_BEACON_OF_FAITH                 = GetSpellInfo(156910) or "--Beacon of Faith";
    HEALBOT_BEACON_OF_INSIGHT               = GetSpellInfo(157007) or "--Beacon of Insight";
    HEALBOT_BEACON_OF_LIGHT                 = GetSpellInfo(53563) or "--Beacon of Light";
    HEALBOT_BEACON_OF_VIRTUE                = GetSpellInfo(200025) or "--Beacon of Virtue";
    HEALBOT_TYRS_DELIVERANCE                = GetSpellInfo(200654) or "--Tyr's Deliverance";
    HEALBOT_BLESSING_OF_KINGS               = GetSpellInfo(203538) or "--Greater Blessing of Kings";
    HEALBOT_BLESSING_OF_MIGHT               = GetSpellInfo(203528) or "--Greater Blessing of Might";
    HEALBOT_BLESSING_OF_WISDOM              = GetSpellInfo(203539) or "--Greater Blessing of Wisdom";
    HEALBOT_DAY_BREAK                       = GetSpellInfo(88821) or "--Daybreak";
    HEALBOT_DEVOTION_AURA                   = GetSpellInfo(465) or "--Devotion Aura";
    HEALBOT_DIVINE_PROTECTION               = GetSpellInfo(498) or "--Divine Protection";
    HEALBOT_DIVINE_PURPOSE                  = GetSpellInfo(86172) or "--Divine Purpose";
    HEALBOT_DIVINE_SAVED_BY_THE_LIGHT       = GetSpellInfo(157047) or "--Saved by the Light";
    HEALBOT_DIVINE_SHIELD                   = GetSpellInfo(642) or "--Divine Shield";
    HEALBOT_ETERNAL_FLAME                   = GetSpellInfo(114163) or "--Eternal Flame";
    HEALBOT_EXECUTION_SENTENCE              = GetSpellInfo(114157) or "--Execution Sentence";
    HEALBOT_GUARDED_BY_THE_LIGHT            = GetSpellInfo(53592) or "--Guarded by the Light";
    HEALBOT_GUARDIAN_ANCIENT_KINGS          = GetSpellInfo(86659) or "--Guardian of Ancient Kings";
    HEALBOT_HAND_OF_FREEDOM                 = GetSpellInfo(1044) or "--Hand of Freedom";
    HEALBOT_HAND_OF_PROTECTION              = GetSpellInfo(1022) or "--Hand of Protection";
    HEALBOT_HAND_OF_PURITY                  = GetSpellInfo(114039) or "--Hand of Purity";
    HEALBOT_HAND_OF_SACRIFICE               = GetSpellInfo(6940) or "--Hand of Sacrifice";
    HEALBOT_HAND_OF_SALVATION               = GetSpellInfo(1038) or "--Hand of Salvation";
    HEALBOT_HOLY_SHIELD                     = GetSpellInfo(20925) or "--Holy Shield"
    HEALBOT_HOLY_SHOCK                      = GetSpellInfo(20473) or "--Holy Shock";
    HEALBOT_ILLUMINATED_HEALING             = GetSpellInfo(86273) or "--Illuminated Healing";
    HEALBOT_INFUSION_OF_LIGHT               = GetSpellInfo(53576) or "--Infusion of Light";
    HEALBOT_LAY_ON_HANDS                    = GetSpellInfo(633) or "--Lay on Hands";
    HEALBOT_LIGHT_BEACON                    = GetSpellInfo(53651) or "--Light's Beacon";
    HEALBOT_RIGHTEOUS_FURY                  = GetSpellInfo(25780) or "--Righteous Fury";
    HEALBOT_SACRED_SHIELD                   = GetSpellInfo(20925) or "--Sacred Shield";
    HEALBOT_SANCTITY_AURA                   = GetSpellInfo(167187) or "--Sanctity Aura";
    HEALBOT_SEAL_OF_COMMAND                 = GetSpellInfo(105361) or "--Seal of Command";
    HEALBOT_SEAL_OF_JUSTICE                 = GetSpellInfo(20164) or "--Seal of Justice";
    HEALBOT_SEAL_OF_INSIGHT                 = GetSpellInfo(20165) or "--Seal of Insight";
    HEALBOT_SEAL_OF_RIGHTEOUSNESS           = GetSpellInfo(20154) or "--Seal of Righteousness";
    HEALBOT_SEAL_OF_TRUTH                   = GetSpellInfo(31801) or "--Seal of Truth";
    HEALBOT_SPEED_OF_LIGHT                  = GetSpellInfo(85499) or "--Speed of Light";
	--Legion Added
	HEALBOT_BLESSING_OF_SACRIFICE           = GetSpellInfo(199448) or "--Blessing of Sacrifice";
	HEALBOT_BESTOW_FAITH                    = GetSpellInfo(223306) or "--Bestow Faith";
	HEALBOT_LIGHT_OF_THE_MARTYR             = GetSpellInfo(183998) or "--Light of the Martyr";
    HEALBOT_HAND_OF_THE_PROTECTOR           = GetSpellInfo(213652) or "--Hand of the Protector";
    
	--Priest
    HEALBOT_ANGELIC_BULWARK                 = GetSpellInfo(108945) or "--Angelic Bulwark"
    HEALBOT_ARCHANGEL                       = GetSpellInfo(81700) or "--Archangel";
    HEALBOT_ASCENSION                       = GetSpellInfo(161862) or "--Ascension"
    HEALBOT_AUSPICIOUS_SPIRITS              = GetSpellInfo(155271) or "--Auspicious Spirits"
    HEALBOT_BLESSED_HEALING                 = GetSpellInfo(70772) or "--Blessed Healing";
    HEALBOT_CHAKRA                          = GetSpellInfo(14751) or "--Chakra";
    HEALBOT_CHAKRA_CHASTISE                 = GetSpellInfo(81209) or "--Chakra: Chastise";
    HEALBOT_CHAKRA_SANCTUARY                = GetSpellInfo(81206) or "--Chakra: Sanctuary";
    HEALBOT_CHAKRA_SERENITY                 = GetSpellInfo(81208) or "--Chakra: Serenity";
    HEALBOT_CLARITY_OF_POWER                = GetSpellInfo(155246) or "--Clarity of Power"
    HEALBOT_CLARITY_OF_PURPOSE              = GetSpellInfo(155245) or "--Clarity of Purpose"
    HEALBOT_CLARITY_OF_WILL                 = GetSpellInfo(152118) or "--Clarity of Will"
    HEALBOT_DISPERSION                      = GetSpellInfo(47585) or "--Dispersion"
    HEALBOT_DIVINE_AEGIS                    = GetSpellInfo(47515) or "--Divine Aegis";
    HEALBOT_DIVINE_INSIGHT                  = GetSpellInfo(109175) or "--Divine Insight";
    HEALBOT_EVANGELISM                      = GetSpellInfo(81661) or "--Evangelism";
    HEALBOT_ECHO_OF_LIGHT                   = GetSpellInfo(77489) or "--Echo of Light";
    HEALBOT_FEAR_WARD                       = GetSpellInfo(6346) or "--Fear Ward";
    HEALBOT_FOCUSED_WILL                    = GetSpellInfo(45243) or "--Focused Will";
    HEALBOT_GUARDIAN_SPIRIT                 = GetSpellInfo(47788) or "--Guardian Spirit";
    HEALBOT_GRACE                           = GetSpellInfo(47517) or "--Grace";
    HEALBOT_HOLY_NOVA                       = GetSpellInfo(132157) or "--Holy Nova";
    HEALBOT_LEAP_OF_FAITH                   = GetSpellInfo(73325) or "--Leap of Faith";
    HEALBOT_LEVITATE                        = GetSpellInfo(1706) or "--Levitate";
    HEALBOT_LIGHTWELL_RENEW                 = GetSpellInfo(7001) or "--Lightwell Renew";
    HEALBOT_MIND_QUICKENING                 = GetSpellInfo(49868) or "--Mind Quickening"
    HEALBOT_PAIN_SUPPRESSION                = GetSpellInfo(33206) or "--Pain Suppression";
    HEALBOT_POWER_INFUSION                  = GetSpellInfo(10060) or "--Power Infusion";
    HEALBOT_POWER_WORD_BARRIER              = GetSpellInfo(62618) or "--Power Word:Barrier";
    HEALBOT_POWER_WORD_FORTITUDE            = GetSpellInfo(21562) or "--Power Word:Fortitude";
    HEALBOT_POWER_WORD_SHIELD               = GetSpellInfo(17) or "--Power Word:Shield";
    HEALBOT_REVELATIONS                     = GetSpellInfo(88627) or "--Revelations";
    HEALBOT_SAVING_GRACE                    = GetSpellInfo(152116) or "--Saving Grace"
    HEALBOT_SAVING_VOID_ENTROPY             = GetSpellInfo(155361) or "--Void Entropy"
    HEALBOT_SERENDIPITY                     = GetSpellInfo(63733) or "--Serendipity";
    HEALBOT_SHADOWFORM                      = GetSpellInfo(232698) or "--Shadowform"
    HEALBOT_SHADOW_WORD_INSANITY            = GetSpellInfo(132573) or "--Shadow Word: Insanity";
    HEALBOT_SPIRIT_SHELL                    = GetSpellInfo(109964) or "--Spirit Shell";
    HEALBOT_SUNDERING_SOUL                  = GetSpellInfo(212570) or "--Sundering Soul";
    HEALBOT_SURGE_OF_DARKNESS               = GetSpellInfo(162448) or "--Surge of Darkness";
    HEALBOT_SURGE_OF_LIGHT                  = GetSpellInfo(114255) or "--Surge of Light";
    HEALBOT_TWIST_OF_FATE                   = GetSpellInfo(109142) or "--Twist of Fate";
--    HEALBOT_TRIAL_OF_LIGHT                  = GetSpellInfo(200128) or "--Trial of light";
    HEALBOT_VAMPIRIC_EMBRACE                = GetSpellInfo(15286) or "--Vampiric Embrace";
    HEALBOT_WORD_OF_MENDING                 = GetSpellInfo(155362) or "--Word of Mending";
	--Legion Added
	HEALBOT_APOTHEOSIS                      = GetSpellInfo(200183) or "--Apotheosis"; --Holy
	HEALBOT_DIVINITY                        = GetSpellInfo(197031) or "--Divinity";
	HEALBOT_SYMBOL_OF_HOPE                  = GetSpellInfo(64901) or "--Symbol of Hope";	
	HEALBOT_BODY_AND_MIND                   = GetSpellInfo(214121) or "--Body and Mind";
	HEALBOT_RAPTURE                         = GetSpellInfo(47536) or "--Rapture"; --Disc
	HEALBOT_ATONEMENT                       = GetSpellInfo(81749) or "--Atonement";
	HEALBOT_SHADOW_COVENANT                 = GetSpellInfo(204065) or "--Shadow Covenant";
    HEALBOT_LIGHT_OF_TUURE                  = GetSpellInfo(208065) or "--Light of T'uure";
    HEALBOT_BLESSING_OF_TUURE               = GetSpellInfo(196644) or "--Blessing of T'uure";
    HEALBOT_POWER_OF_THE_NAARU              = GetSpellInfo(196490) or "--Power of the Naaru";
    HEALBOT_POWER_OF_THE_DARK_SIDE          = GetSpellInfo(198069) or "--Power of the Dark Side";
    HEALBOT_ANGELIC_FEATHER                 = GetSpellInfo(121557) or "--Angelic Feather"
    HEALBOT_ALMAIESH_THE_CORD_OF_HOPE       = GetSpellInfo(211443) or "--Al'maiesh, the Cord of Hope";
    HEALBOT_VESTMANTS_OF_DISCIPLINE         = GetSpellInfo(197711) or "--Vestments of Discipline";

	--Shaman
    HEALBOT_ANACESTRAL_GUIDANCE             = GetSpellInfo(108281) or "--Ancestral Guidance";
    HEALBOT_ANACESTRAL_SWIFTNESS            = GetSpellInfo(16188) or "--Ancestral Swiftness";
    HEALBOT_ASCENDANCE                      = GetSpellInfo(114049) or "--Ascendance";
    HEALBOT_ASTRAL_SHIFT                    = GetSpellInfo(108271) or "--Astral Shift";
    HEALBOT_CLOUDBURST_TOTEM                = GetSpellInfo(157153) or "--Cloudburst Totem";
    HEALBOT_EARTH_SHIELD                    = GetSpellInfo(204288) or "--Earth Shield";
    HEALBOT_ELEMENTAL_FUSION                = GetSpellInfo(152257) or "--Elemental Fusion";
    HEALBOT_ELEMENTAL_MASTERY               = GetSpellInfo(16166) or "--Elemental Mastery";
    HEALBOT_EMPOWER                         = GetSpellInfo(118350) or "--Empower";
    HEALBOT_GENESIS                         = GetSpellInfo(145518) or "--Genesis";
    HEALBOT_GRACE_OF_AIR                    = GetSpellInfo(116956) or "--Grace of Air";
    HEALBOT_HIGH_TIDE                       = GetSpellInfo(157154) or "--High Tide";
    HEALBOT_LIGHTNING_SHIELD                = GetSpellInfo(324) or "--Lightning Shield";
    HEALBOT_SHAMANISTIC_RAGE                = GetSpellInfo(30823) or "--Shamanistic Rage";
    HEALBOT_SPIRITWALKERS_GRACE             = GetSpellInfo(79206) or "--Spiritwalker's Grace";
    HEALBOT_STORM_ELEMENTAL_TOTEM           = GetSpellInfo(152256) or "--Storm Elemenal Totem";
    HEALBOT_TIDAL_WAVES                     = GetSpellInfo(51564) or "--Tidal Waves";
    HEALBOT_UNLEASH_ELEMENTS                = GetSpellInfo(73680) or "--Unleash Elements";
    HEALBOT_UNLEASH_FLAME                   = GetSpellInfo(165462) or "--Unleash Flame";
    HEALBOT_UNLEASH_LIFE                    = GetSpellInfo(73685) or "--Unleash Life";
    HEALBOT_UNLEASHED_FURY                  = GetSpellInfo(117012) or "--Unleashed Fury";
    HEALBOT_WATER_SHIELD                    = GetSpellInfo(52127) or "--Water Shield";
    HEALBOT_WATER_WALKING                   = GetSpellInfo(546) or "--Water Walking";
    
	--Monk
    HEALBOT_BREATH_OF_THE_SERPENT           = GetSpellInfo(157535) or "--Breath of the Serpent"
    HEALBOT_CHI_EXPLOSION                   = GetSpellInfo(157676) or "--Chi Explosion"
    HEALBOT_CHI_TOROEDO                     = GetSpellInfo(115008) or "--Chi Torpedo"
    HEALBOT_DAMPEN_HARM                     = GetSpellInfo(122278) or "--Dampen Harm"
    HEALBOT_DETONATE_CHI                    = GetSpellInfo(115460) or "--Detonate Chi"
    HEALBOT_DIFFUSE_MAGIC                   = GetSpellInfo(122783) or "--Diffuse Magic"
    HEALBOT_ELUSIVE_BREW                    = GetSpellInfo(115308) or "--Elusive Brew"
    HEALBOT_FORTIFYING_BREW                 = GetSpellInfo(115203) or "--Fortifying Brew"
    HEALBOT_GUARD                           = GetSpellInfo(115295) or "--Guard"
    HEALBOT_LEGACY_EMPEROR                  = GetSpellInfo(115921) or "--Legacy of the Emperor"
    HEALBOT_LEGACY_WHITETIGER               = GetSpellInfo(116781) or "--Legacy of the White Tiger"
    HEALBOT_LIFE_COCOON                     = GetSpellInfo(116849) or "--Life Cocoon"
    HEALBOT_MANA_TEA                        = GetSpellInfo(115867) or "--Mana Tea"
    HEALBOT_RUSHING_JADE_WIND               = GetSpellInfo(116847) or "--Rushing Jade Wind"
    HEALBOT_SERENITY                        = GetSpellInfo(152173) or "--Serenity"
    HEALBOT_SERPENT_ZEAL                    = GetSpellInfo(127722) or "--Serpent's Zeal"
    HEALBOT_STANCE_MONK_TIGER               = GetSpellInfo(103985) or "--Stance of the Fierce Tiger"
    HEALBOT_STANCE_MONK_CRANE               = GetSpellInfo(154436) or "--Stance of the Spirited Crane"
    HEALBOT_STANCE_MONK_OX                  = GetSpellInfo(115069) or "--Stance of the Sturdy Ox"
    HEALBOT_STANCE_MONK_SERPENT             = GetSpellInfo(115070) or "--Stance of the Wise Serpent"
    HEALBOT_THUNDER_FOCUS_TEA               = GetSpellInfo(116680) or "--Thunder Focus Tea"
    HEALBOT_WINDFLURRY                      = GetSpellInfo(166916) or "--Windflurry"
    HEALBOT_EXTEND_LIFE                     = GetSpellInfo(185158) or "--Extend Life"
    HEALBOT_ESSENCE_FONT                    = GetSpellInfo(191837) or "--Essence Font"
    HEALBOT_TOUCH_OF_KARMA                  = GetSpellInfo(122470) or "--Touch of Karma"
    
	--Warlock
    HEALBOT_BLOOD_PACT                      = GetSpellInfo(166928) or "--Blood Pact";
    HEALBOT_DARK_BARGAIN                    = GetSpellInfo(110913) or "--Dark Bargain"
    HEALBOT_DARK_INTENT                     = GetSpellInfo(109773) or "--Dark Intent";
    HEALBOT_DEMON_ARMOR                     = GetSpellInfo(687) or "--Demon Armor";
    HEALBOT_FEL_ARMOR                       = GetSpellInfo(28176) or "--Fel Armor";
    HEALBOT_LIFE_TAP                        = GetSpellInfo(1454) or "--Life Tap";
    HEALBOT_SOUL_LINK                       = GetSpellInfo(19028) or "--Soul Link";
    HEALBOT_UNENDING_BREATH                 = GetSpellInfo(5697) or "--Unending Breath"
    HEALBOT_UNENDING_RESOLVE                = GetSpellInfo(104773) or "--Unending Resolve"
    
    --Warrior
    HEALBOT_BATTLE_SHOUT                    = GetSpellInfo(6673) or "--Battle Shout";
    HEALBOT_COMMANDING_SHOUT                = GetSpellInfo(469) or "--Commanding Shout";
    HEALBOT_ENRAGED_REGEN                   = GetSpellInfo(55694) or "--Enraged Regeneration";
    HEALBOT_INSPIRING_PRESENCE              = GetSpellInfo(167188) or "--Inspiring Presence"
    HEALBOT_INTERVENE                       = GetSpellInfo(3411) or "--Intervene";
    HEALBOT_LAST_STAND                      = GetSpellInfo(12975) or "--Last Stand";
    HEALBOT_SAFEGUARD                       = GetSpellInfo(114029) or "--Safeguard"
--    HEALBOT_SHIELD_BARRIER                  = GetSpellInfo(112048) or "--Shield Barrier"
    HEALBOT_SHIELD_BLOCK                    = GetSpellInfo(2565) or "--Shield Block";
    HEALBOT_SHIELD_WALL                     = GetSpellInfo(871) or "--Shield Wall";
    HEALBOT_VIGILANCE                       = GetSpellInfo(114030) or "--Vigilance";
    
	--Rogue
    HEALBOT_CLOAK_OF_SHADOWS                = GetSpellInfo(31224) or "--Cloak of Shadows"
    HEALBOT_EVASION                         = GetSpellInfo(5277) or "--Evasion";
    HEALBOT_FEINT                           = GetSpellInfo(1966) or "--Feint"
    HEALBOT_SWIFTBLADES_CUNNING             = GetSpellInfo(113742) or "--Swiftblade's Cunning";
    HEALBOT_VANISH                          = GetSpellInfo(1856) or "--Vanish";
    
    --Resurrection Spells
    HEALBOT_ANCESTRALSPIRIT                 = GetSpellInfo(2008) or "--Ancestral Spirit";
    HEALBOT_DEBUFF_MASS_RESURRECTED         = GetSpellInfo(95223) or "--Recently Mass Resurrected";
    --HEALBOT_MASS_RESURRECTION               = GetSpellInfo(83968) or "--Mass Resurrection";
    
    HEALBOT_ABSOLUTION                      = GetSpellInfo(212056) or "--Absolution";
    HEALBOT_ANCESTRAL_VISION                = GetSpellInfo(212048) or "--Ancestral Vision";
    HEALBOT_MASS_RESURRECTION               = GetSpellInfo(212036) or "--Mass Resurrection";
    HEALBOT_REAWAKEN                        = GetSpellInfo(212051) or "--Reawaken";
    HEALBOT_REVITALIZE                      = GetSpellInfo(212040) or "--Revitalize";
    
    HEALBOT_REDEMPTION                      = GetSpellInfo(7328) or "--Redemption";
    HEALBOT_REBIRTH                         = GetSpellInfo(20484) or "--Rebirth";
    HEALBOT_RESURRECTION                    = GetSpellInfo(2006) or "--Resurrection";
    HEALBOT_RESUSCITATE                     = GetSpellInfo(115178) or "--Resuscitate"
    HEALBOT_REVIVE                          = GetSpellInfo(50769) or "--Revive";
    
    --Cure Spells
    HEALBOT_BODY_AND_SOUL                   = GetSpellInfo(64127) or "--Body and Soul";
    HEALBOT_CLEANSE                         = GetSpellInfo(4987) or "--Cleanse";
    HEALBOT_CLEANSE_SPIRIT                  = GetSpellInfo(51886) or "--Cleanse Spirit";
    HEALBOT_CLEANSE_TOXIN                  = GetSpellInfo(213644) or "--Cleanse Toxins";
    HEALBOT_DETOX                           = GetSpellInfo(115450) or "--Detox";
    HEALBOT_NATURES_CURE                    = GetSpellInfo(88423) or "--Nature's Cure";
    HEALBOT_PURIFY                          = GetSpellInfo(527) or "--Purify";
    HEALBOT_PURIFY_SPIRIT                   = GetSpellInfo(77130) or "--Purify Spirit";
    HEALBOT_PURIFY_DISEASE                  = GetSpellInfo(213634) or "--Purify Disease";
    HEALBOT_MASS_DISPEL                     = GetSpellInfo(32375) or "--Mass Dispel";
    HEALBOT_REMOVE_CURSE                    = GetSpellInfo(475) or "--Remove Curse";
    HEALBOT_REMOVE_CORRUPTION               = GetSpellInfo(2782) or "--Remove Corruption";
    HEALBOT_SACRED_CLEANSING                = GetSpellInfo(53551) or "--Sacred Cleansing";
    
    --[[END OF SPELL LIST]]--

    --Ignore Class Debuffs (ONLY DISPELLABLE DEBUFFS)
    HEALBOT_DEBUFF_CURSE_OF_IMPOTENCE       = GetSpellInfo(34925) or "--Curse of Impotence";
    HEALBOT_DEBUFF_DECAYED_INTELLECT        = GetSpellInfo(31555) or "--Decayed Intellect";
    HEALBOT_DEBUFF_DECAYED_STRENGHT         = GetSpellInfo(6951) or "--Decayed Strength";
    HEALBOT_DEBUFF_IGNITE_MANA              = GetSpellInfo(19659) or "--Ignite Mana";
    HEALBOT_DEBUFF_SILENCE                  = GetSpellInfo(38913) or "--Silence";
    HEALBOT_DEBUFF_TAINTED_MIND             = GetSpellInfo(16567) or "--Tainted Mind";
    HEALBOT_DEBUFF_TRAMPLE                  = GetSpellInfo(126406) or "--Trample";
    --HEALBOT_DEBUFF_UNSTABLE_AFFLICTION      = GetSpellInfo(35183) or "--Unstable Affliction";
    --HEALBOT_DEBUFF_UNSTABLE_AFFLICTION      = GetSpellInfo(156954) or "--Unstable Affliction";
    HEALBOT_DEBUFF_UNSTABLE_AFFLICTION      = GetSpellInfo(30108) or "--Unstable Affliction";
    HEALBOT_DEBUFF_VIPER_STING              = GetSpellInfo(39413) or "--Viper Sting";   
    --Ignore Movement Debuffs (ONLY DISPELLABLE DEBUFFS)
    HEALBOT_DEBUFF_CHILLED                  = GetSpellInfo(6136) or "--Chilled";
    HEALBOT_DEBUFF_CONEOFCOLD               = GetSpellInfo(64645) or "--Cone of Cold";
    HEALBOT_DEBUFF_EARTHBIND                = GetSpellInfo(3600) or "--Earthbind";
    HEALBOT_DEBUFF_FROST_SHOCK              = GetSpellInfo(41116) or "--Frost Shock";
    HEALBOT_DEBUFF_FROSTBOLT                = GetSpellInfo(69573) or "--Frostbolt";
    HEALBOT_DEBUFF_MAGMA_SHACKLES           = GetSpellInfo(19496) or "--Magma Shackles";
    HEALBOT_DEBUFF_SEAL_OF_JUSTICE          = GetSpellInfo(20170) or "--Seal of Justice";
    HEALBOT_DEBUFF_SLOW                     = GetSpellInfo(32922) or "--Slow";  
    --Ignore Non-Harmful Debuffs (ONLY DISPELLABLE DEBUFFS)
    HEALBOT_DEBUFF_DREAMLESS_SLEEP          = GetSpellInfo(15822) or "--Dreamless Sleep";
    HEALBOT_DEBUFF_GREATER_DREAMLESS        = GetSpellInfo(24360) or "--Greater Dreamless Sleep";
    HEALBOT_DEBUFF_MAJOR_DREAMLESS          = GetSpellInfo(28504) or "--Major Dreamless Sleep";
    
    --Common Buffs
    HEALBOT_ZAMAELS_PRAYER                  = GetSpellInfo(88663) or "--Zamael's Prayer";
    
    --Harmful Debuffs
    --Debuffs
    HEALBOT_DEBUFF_ROCKET_FUEL_LEAK         = GetSpellInfo(94794) or "--Rocket Fuel Leak"; --Engineering 
    HEALBOT_DEBUFF_SAVING_GRACE             = GetSpellInfo(155274) or "--Saving Grace"; --DO NOT REMOVE
    HEALBOT_DEBUFF_WEAKENED_SOUL            = GetSpellInfo(6788) or "--Weakened Soul"; --DO NOT REMOVE
    
    --Unit Max Health Modifier Debuffs
    HEALBOT_DEBUFF_AURA_OF_CONTEMPT         = GetSpellInfo(179986) or "--Aura of Content";
    
            
    --Ignore Class Debuffs (ONLY DISPELLABLE DEBUFFS)
    HEALBOT_DEBUFF_CURSE_OF_IMPOTENCE       = GetSpellInfo(34925) or "--Curse of Impotence";
    HEALBOT_DEBUFF_DECAYED_INTELLECT        = GetSpellInfo(31555) or "--Decayed Intellect";
    HEALBOT_DEBUFF_DECAYED_STRENGHT         = GetSpellInfo(6951) or "--Decayed Strength";
    HEALBOT_DEBUFF_IGNITE_MANA              = GetSpellInfo(19659) or "--Ignite Mana";
    HEALBOT_DEBUFF_SILENCE                  = GetSpellInfo(38913) or "--Silence";
    HEALBOT_DEBUFF_TAINTED_MIND             = GetSpellInfo(16567) or "--Tainted Mind";
    HEALBOT_DEBUFF_TRAMPLE                  = GetSpellInfo(126406) or "--Trample";
    --HEALBOT_DEBUFF_UNSTABLE_AFFLICTION      = GetSpellInfo(35183) or "--Unstable Affliction";
    --HEALBOT_DEBUFF_UNSTABLE_AFFLICTION      = GetSpellInfo(156954) or "--Unstable Affliction";
    HEALBOT_DEBUFF_UNSTABLE_AFFLICTION      = GetSpellInfo(30108) or "--Unstable Affliction";
    HEALBOT_DEBUFF_VIPER_STING              = GetSpellInfo(39413) or "--Viper Sting";   
    --Ignore Movement Debuffs (ONLY DISPELLABLE DEBUFFS)
    HEALBOT_DEBUFF_CHILLED                  = GetSpellInfo(6136) or "--Chilled";
    HEALBOT_DEBUFF_CONEOFCOLD               = GetSpellInfo(64645) or "--Cone of Cold";
    HEALBOT_DEBUFF_EARTHBIND                = GetSpellInfo(3600) or "--Earthbind";
    HEALBOT_DEBUFF_FROST_SHOCK              = GetSpellInfo(41116) or "--Frost Shock";
    HEALBOT_DEBUFF_FROSTBOLT                = GetSpellInfo(69573) or "--Frostbolt";
    HEALBOT_DEBUFF_MAGMA_SHACKLES           = GetSpellInfo(19496) or "--Magma Shackles";
    HEALBOT_DEBUFF_SEAL_OF_JUSTICE          = GetSpellInfo(20170) or "--Seal of Justice";
    HEALBOT_DEBUFF_SLOW                     = GetSpellInfo(32922) or "--Slow";  
    --Ignore Non-Harmful Debuffs (ONLY DISPELLABLE DEBUFFS)
    HEALBOT_DEBUFF_DREAMLESS_SLEEP          = GetSpellInfo(15822) or "--Dreamless Sleep";
    HEALBOT_DEBUFF_GREATER_DREAMLESS        = GetSpellInfo(24360) or "--Greater Dreamless Sleep";
    HEALBOT_DEBUFF_MAJOR_DREAMLESS          = GetSpellInfo(28504) or "--Major Dreamless Sleep";
    
    --Common Buffs
    HEALBOT_ZAMAELS_PRAYER                  = GetSpellInfo(88663) or "--Zamael's Prayer";
    
    --Harmful Debuffs
    --Debuffs
    HEALBOT_DEBUFF_ROCKET_FUEL_LEAK         = GetSpellInfo(94794) or "--Rocket Fuel Leak"; --Engineering/DO NOT REMOVE 
    HEALBOT_DEBUFF_SAVING_GRACE             = GetSpellInfo(155274) or "--Saving Grace"; --DO NOT REMOVE
    HEALBOT_DEBUFF_WEAKENED_SOUL            = GetSpellInfo(6788) or "--Weakened Soul"; --DO NOT REMOVE
    
    --Unit Max Health Modifier Debuffs
    HEALBOT_DEBUFF_AURA_OF_CONTEMPT         = GetSpellInfo(179986) or "--Aura of Content";
    
            
    --[[Updated Patch 6.2.0 Warlords Of Draenor Expansion by Ariá - Silvermoon EU]]--
    --World Bosses
    --Drov The Ruiner
    --Tarlna The Ageless    
    HEALBOT_DEBUFF_COLOSSAL_BLOW            = GetSpellInfo(175973) or "--Colossal Blow";
    HEALBOT_DEBUFF_NOXIOUS_SPIT             = GetSpellInfo(161833) or "--Noxious Spit";
    --Rukhmar
    HEALBOT_DEBUFF_PIERCED_ARMOR            = GetSpellInfo(167615) or "--Pierced Armor";
	--Supreme Lord Kazzak
    HEALBOT_DEBUFF_MARK_OF_KAZZAK           = GetSpellInfo(187667) or "--Mark of Kazzak";
	HEALBOT_DEBUFF_FEL_BREATH               = GetSpellInfo(187664) or "--Fel Breath";
	HEALBOT_DEBUFF_SUPREME_DOOM             = GetSpellInfo(187466) or "--Supreme Doom";	 
    
	--Scenarios, Dungeons & Proving Grounds
    HEALBOT_DEBUFF_CHOMP                    = GetSpellInfo(145263) or "--Chomp";
    HEALBOT_DEBUFF_LAVA_BURNS               = GetSpellInfo(145403) or "--Lava Burns";
    --DISPELABLE (DO NOT REMOVE)
    HEALBOT_DEBUFF_WITHERING_FLAMES         = GetSpellInfo(150032) or "--Withering Flames";
    
    --[[=GetMapNameByID(7545)) or "--Hellfire Citadel" 
	Trash]]
    HEALBOT_DEBUFF_CORRUPTION_SIPHON    = GetSpellInfo(190735) or "--Corruption Siphon";
	HEALBOT_DEBUFF_SLAM                 = GetSpellInfo(184243) or "--Slam";
	HEALBOT_DEBUFF_COWER                = GetSpellInfo(184238) or "--Cower!";
	HEALBOT_DEBUFF_CRUSH                = GetSpellInfo(188081) or "--Crush";
	HEALBOT_DEBUFF_FOCUSED_FIRE         = GetSpellInfo(187110) or "--Focused Fire";
	HEALBOT_DEBUFF_PRIMAL_ENERGIES      = GetSpellInfo(187122) or "--Primal Energies";
	HEALBOT_DEBUFF_RESIDUAL_SHADOWS     = GetSpellInfo(187103) or "--Residual Shadows";
	HEALBOT_DEBUFF_DARK_FATE            = GetSpellInfo(182644) or "--Dark Fate";
	HEALBOT_DEBUFF_FEL_FURY             = GetSpellInfo(182601) or "--Fel Fury";
	HEALBOT_DEBUFF_TOUCH_OF_MORTALITY   = GetSpellInfo(184587) or "--Touch of Mortality";
	HEALBOT_DEBUFF_HELLFIRE_BLAST       = GetSpellInfo(184621) or "--Hellfire Blast";
	HEALBOT_DEBUFF_NOXIOUS_CLOUD        = GetSpellInfo(186384) or "--Noxious Cloud";
	HEALBOT_DEBUFF_RAIN_OF_FIRE         = GetSpellInfo(189550) or "--Rain of Fire";
	HEALBOT_DEBUFF_WAR_STOMP            = GetSpellInfo(18950) or "--War Stomp";
	HEALBOT_DEBUFF_MARK_OF_KAZROGAL     = GetSpellInfo(189512) or "--Mark of Kaz'rogal";
	HEALBOT_DEBUFF_DOOM                 = GetSpellInfo(189538) or "--Doom";
	HEALBOT_DEBUFF_CRIPPLE              = GetSpellInfo(189544) or "--Cripple";
	HEALBOT_DEBUFF_SLEEP                = GetSpellInfo(189470) or "--Sleep";
	HEALBOT_DEBUFF_CARRION_SWARM        = GetSpellInfo(189464) or "--Carrion Swarm";
	--HEALBOT_DEBUFF_FEL_CORRUPTION       = GetSpellInfo(188796) or "--Fel Corruption";/DO NOT REMOVE
	--Hellfire Assault
    HEALBOT_DEBUFF_HOWLING_AXE          = GetSpellInfo(184370) or "--Howling Axe";
	HEALBOT_DEBUFF_FELFIRE_MUNITIONS    = GetSpellInfo(186016) or "--Felfire Munitions";
	--Iron Reaver 
    HEALBOT_DEBUFF_UNSTABLE_ORB         = GetSpellInfo(182001) or "--Unstable Orb";
	HEALBOT_DEBUFF_IMMOLATION           = GetSpellInfo(182074) or "--Immolation";
	HEALBOT_DEBUFF_FUEL_STREAK          = GetSpellInfo(182668) or "--Fuel Streak";
	HEALBOT_DEBUFF_ARTILLERY            = GetSpellInfo(182108) or "--Artillery";
	HEALBOT_DEBUFF_FIREBOMB_VULNERABILITY = GetSpellInfo(185978) or "--Firebomb Vulnerability";
	HEALBOT_DEBUFF_FLAME_VULNERABILITY  = GetSpellInfo(182373) or "--Flame Vulnerability";
	--Kormrok
    HEALBOT_DEBUFF_SHADOW_GLOBULE       = GetSpellInfo(180270) or "--Shadow Globule";
	HEALBOT_DEBUFF_FIERY_GLOBULE        = GetSpellInfo(185519) or "--Fiery Globule";
	HEALBOT_DEBUFF_FOUL_GLOBULE         = GetSpellInfo(185521) or "--Foul Globule";
	HEALBOT_DEBUFF_EXPLOSIVE_BURST      = GetSpellInfo(181306) or "--Explosive Burst";
	HEALBOT_DEBUFF_SHADOWY_POOL         = GetSpellInfo(181082) or "--Shadowy Pool";
	HEALBOT_DEBUFF_FIERY_POOL           = GetSpellInfo(186559) or "--Fiery Pool";
	HEALBOT_DEBUFF_FOUL_POOL            = GetSpellInfo(186560) or "--Foul Pool";
	HEALBOT_DEBUFF_SHADOWY_RESIDUE      = GetSpellInfo(181208) or "--Shadow Residue";
	HEALBOT_DEBUFF_FIERY_RESIDUE        = GetSpellInfo(185686) or "--Fiery Residue";
	HEALBOT_DEBUFF_FOUL_RESIDUE         = GetSpellInfo(181695) or "--Foul Residue";
	HEALBOT_DEBUFF_FEL_TOUCH            = GetSpellInfo(181321) or "--Fel Touch";
	--Hellfire High Council
    HEALBOT_DEBUFF_BLOODBOIL            = GetSpellInfo(184355) or "--Bloodboil";
	HEALBOT_DEBUFF_FEL_RAGE             = GetSpellInfo(184358) or "--Fel Rage";
	HEALBOT_DEBUFF_REAP                 = GetSpellInfo(184652) or "--Reap";
	HEALBOT_DEBUFF_FEL_BLADE            = GetSpellInfo(183226) or "--Fel Blade";
	--Kilrogg Deadeye
    HEALBOT_DEBUFF_HEART_SEEKER         = GetSpellInfo(180387) or "--Heart Seeker";
	HEALBOT_DEBUFF_BLOOD_SPATTER        = GetSpellInfo(188852) or "--Blood Splatter";
	HEALBOT_DEBUFF_FEL_PUDDLE           = GetSpellInfo(184067) or "--Fel Puddle";
	HEALBOT_DEBUFF_VISION_OF_DEATH      = GetSpellInfo(181488) or "--Vision of Death";
	HEALBOT_DEBUFF_RENDING_HOWL         = GetSpellInfo(183917) or "--Rending Howl";
	--Gorefiend 
    HEALBOT_DEBUFF_DOOM_WELL            = GetSpellInfo(179995) or "--Doom Well";
	HEALBOT_DEBUFF_FEL_FLAMES           = GetSpellInfo(185189) or "--Fel Flames";
	HEALBOT_DEBUFF_SHADOW_OF_DEATH      = GetSpellInfo(179864) or "--Shadow of Death";
	HEALBOT_DEBUFF_HUNGER_FOR_LIFE      = GetSpellInfo(180148) or "--Hunger for Life";
	HEALBOT_DEBUFF_TOUCH_OF_DOOM        = GetSpellInfo(179978) or "--Touch of Doom";
	HEALBOT_DEBUFF_SHARED_FATE          = GetSpellInfo(179909) or "--Shared Fate";
	HEALBOT_DEBUFF_DIGEST               = GetSpellInfo(181295) or "--Digest";
	HEALBOT_DEBUFF_POOL_OF_SOULS        = GetSpellInfo(186770) or "--Pool of Souls";
	--Shadow-Lord Iskar 
	HEALBOT_DEBUFF_PHANTASMAL_WOUNDS    = GetSpellInfo(182323) or "--Phantasmal Wounds";
	HEALBOT_DEBUFF_PHANTASMAL_WINDS     = GetSpellInfo(181956) or "--Phantasmal Winds";
	HEALBOT_DEBUFF_FEL_CHAKRAM          = GetSpellInfo(182173) or "--Fel Chakram";
	HEALBOT_DEBUFF_FEL_BEAM_FIXATE      = GetSpellInfo(185747) or "--Fel Beam Fixate";
	HEALBOT_DEBUFF_PHANTASMAL_FEL_BOMB  = GetSpellInfo(179219) or "--Phantasmal Fel Bomb";
	HEALBOT_DEBUFF_PHANTASMAL_CORRUPTION = GetSpellInfo(181824) or "--Phantasmal Corruption";
	HEALBOT_DEBUFF_PHANTASMAL_NOVA      = GetSpellInfo(187991) or "--Phantasmal Nova";
	HEALBOT_DEBUFF_FEL_FIRE             = GetSpellInfo(182600) or "--Fel Fire";
	HEALBOT_DEBUFF_RADIANCE_OF_ANZU     = GetSpellInfo(185239) or "--Radiance of Anzu";
	HEALBOT_DEBUFF_FEL_INCINERATION     = GetSpellInfo(182582) or "--Fel Incineration";
	--Socrethar the Eternal
	HEALBOT_DEBUFF_OVERWHELMING_POWER   = GetSpellInfo(189541) or "--Overwhelming Power";
	HEALBOT_DEBUFF_FELBLAZE_RESIDUE     = GetSpellInfo(182218) or "--Felblaze Residue";
	HEALBOT_DEBUFF_VOLATILE_FEL_ORB     = GetSpellInfo(182992) or "--Volatile Fel Orb";
	HEALBOT_DEBUFF_GIFT_OF_THE_MANARI   = GetSpellInfo(184124) or "--Gift of the Man'ari";
	HEALBOT_DEBUFF_VIRULENT_HAUNT       = GetSpellInfo(182900) or "--Virulent Haunt";
	HEALBOT_DEBUFF_GHASTLY_FIXATION     = GetSpellInfo(182769) or "--Ghastly Fixation";
	HEALBOT_DEBUFF_SHATTERED_DEFENSES   = GetSpellInfo(182038) or "--Shattered Defenses";
	HEALBOT_DEBUFF_ETERNAL_HUNGER       = GetSpellInfo(188666) or "--Eternal Hunger";
	--Fel Lord Zakuun
	HEALBOT_DEBUFF_BEFOULED             = GetSpellInfo(179711) or "--Befouled";
	HEALBOT_DEBUFF_LATENT_ENERGY        = GetSpellInfo(182008) or "--Latent Energy";
	HEALBOT_DEBUFF_SEED_OF_DESTRUCTION  = GetSpellInfo(181508) or "--Seed of Destruction";
	HEALBOT_DEBUFF_FEL_CRYSTAL          = GetSpellInfo(179620) or "--Fel Crystal";
	--Tyrant Velhari
	HEALBOT_DEBUFF_DESPOILED_GROUND     = GetSpellInfo(180604) or "--Despoiled Ground";
	HEALBOT_DEBUFF_FONT_OF_CORRUPTION   = GetSpellInfo(180526) or "--Font of Corruption";
	HEALBOT_DEBUFF_EDICT_OF_CONDEMNATION = GetSpellInfo(182459) or "--Edict of Condemnation";
	--Xhul'horac
	HEALBOT_DEBUFF_ABLAZE               = GetSpellInfo(188208) or "--Ablaze";
	HEALBOT_DEBUFF_FELSINGED            = GetSpellInfo(186073) or "--Felsinged";
	HEALBOT_DEBUFF_WASTING_VOID         = GetSpellInfo(186063) or "--Wasting Void";
	HEALBOT_DEBUFF_FEL_SURGE            = GetSpellInfo(186407) or "--Fel Surge";
	HEALBOT_DEBUFF_VOID_SURGE           = GetSpellInfo(186333) or "--Void Surge";
	HEALBOT_DEBUFF_CHAINS_OF_FEL        = GetSpellInfo(186490) or "--Chains of Fel";
	--Mannoroth
	HEALBOT_DEBUFF_GAZING_SHADOWS       = GetSpellInfo(182031) or "--Gazing Shadows";
	HEALBOT_DEBUFF_BLOOD_OF_MANNOROTH   = GetSpellInfo(182171) or "--Blood of Mannoroth";
	HEALBOT_DEBUFF_MARK_OF_DOOM         = GetSpellInfo(181099) or "--Mark of Doom";
	HEALBOT_DEBUFF_FEL_HELLFIRE         = GetSpellInfo(181191) or "--Fel Hellfire";
	HEALBOT_DEBUFF_MANNOROTHS_GAZE      = GetSpellInfo(181597) or "--Mannoroth's Gaze";
	HEALBOT_DEBUFF_SHADOWFORCE          = GetSpellInfo(181799) or "--Shadowforce";
	HEALBOT_DEBUFF_DOOM_SPIKE           = GetSpellInfo(181116) or "--Doom Spike";
	HEALBOT_DEBUFF_WRATH_OF_GULDAN      = GetSpellInfo(186348) or "--Wrath of Gul'dan";
	HEALBOT_DEBUFF_GRIPPING_SHADOWS     = GetSpellInfo(186350) or "--Gripping Shadows";
	--Archimonde
	HEALBOT_DEBUFF_DOOMFIRE             = GetSpellInfo(183586) or "--Doomfire";
	HEALBOT_DEBUFF_NETHER_TEAR          = GetSpellInfo(189891) or "--Nether Tear";
	HEALBOT_DEBUFF_DOOMFIRE_FIXATE      = GetSpellInfo(182879) or "--Doomfire Fixate";
	HEALBOT_DEBUFF_SHACKLED_TORMENT     = GetSpellInfo(184931) or "--Shackled Torment";
	HEALBOT_DEBUFF_WROUGHT_CHAOS        = GetSpellInfo(184265) or "--Wrought Chaos";
	HEALBOT_DEBUFF_FOCUSED_CHAOS        = GetSpellInfo(185014) or "--Focused Chaos";
	HEALBOT_DEBUFF_DEVOUR_LIFE          = GetSpellInfo(187047) or "--Devour Life";
	HEALBOT_DEBUFF_VOID_STAR_FIXATE     = GetSpellInfo(189895) or "--Void Star Fixate";
	HEALBOT_DEBUFF_SHADOW_BLAST         = GetSpellInfo(183864) or "--Shadow Blast";
	HEALBOT_DEBUFF_DARK_CONDUIT         = GetSpellInfo(190396) or "--Dark Conduit";
	HEALBOT_DEBUFF_SOURCE_OF_CHAOS      = GetSpellInfo(190721) or "--Source of Chaos";
	HEALBOT_DEBUFF_MARK_OF_THE_LEGION   = GetSpellInfo(187050) or "--Mark of the Legion";
    
    HEALBOT_DEBUFF_BLACKENING_SOUL      = GetSpellInfo(209158) or "--Blackening Soul"
    HEALBOT_DEBUFF_DARKENING_SOUL       = GetSpellInfo(206651) or "--Darkening Soul"
    HEALBOT_DEBUFF_SHADOW_BURST         = GetSpellInfo(204044) or "--Shadow Burst"
end

HEALBOT_DISEASE_en                      = "Disease";  -- Do NOT localize this value.
HEALBOT_MAGIC_en                        = "Magic";  -- Do NOT localize this value.
HEALBOT_CURSE_en                        = "Curse";  -- Do NOT localize this value.
HEALBOT_POISON_en                       = "Poison";  -- Do NOT localize this value.
HEALBOT_CUSTOM_en                       = "Custom";  -- Do NOT localize this value. 

--HealBot_globalVars()

