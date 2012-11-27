HealBot_Default_Textures={
    [1]= {name="HealBot 01", file=[[Interface\Addons\HealBot\Images\bar1.tga]]},
    [2]= {name="Waves", file=[[Interface\Addons\HealBot\Images\bar2.tga]]},
    [3]= {name="HealBot 03", file=[[Interface\Addons\HealBot\Images\bar3.tga]]},
    [4]= {name="HealBot 04", file=[[Interface\Addons\HealBot\Images\bar4.tga]]},
    [5]= {name="HealBot 05", file=[[Interface\Addons\HealBot\Images\bar5.tga]]},
    [6]= {name="BantoBar", file=[[Interface\Addons\HealBot\Images\bar6.tga]]},
    [7]= {name="Otravi", file=[[Interface\Addons\HealBot\Images\bar7.tga]]},
    [8]= {name="Smooth", file=[[Interface\Addons\HealBot\Images\bar8.tga]]},
    [9]= {name="Charcoal", file=[[Interface\Addons\HealBot\Images\bar9.tga]]},
    [10]= {name="HealBot 10", file=[[Interface\Addons\HealBot\Images\bar10.tga]]},
    [11]= {name="Diagonal", file=[[Interface\Addons\HealBot\Images\bar11.tga]]},
    [12]= {name="Skewed", file=[[Interface\Addons\HealBot\Images\bar12.tga]]},
    [13]= {name="Marble", file=[[Interface\Addons\HealBot\Images\bar13.tga]]},
    [14]= {name="HealBot 14", file=[[Interface\Addons\HealBot\Images\bar14.tga]]},
    [15]= {name="Healbot", file=[[Interface\Addons\HealBot\Images\Bar15.tga]]},
    [16]= {name="Tukui", file=[[Interface\Addons\HealBot\Images\normTex.tga]]},----Tukui-----
    [17]= {name="Tukui2", file=[[Interface\Addons\HealBot\Images\DsmV1.tga]]},-----Tukui-----
    [18]= {name="Tukui4", file=[[Interface\Addons\HealBot\Images\tukuibar.tga]]},----TUKUI----
};
HealBot_Default_Sounds={
    [1]= {name="Tribal Bass Drum", file="Sound\\Doodad\\BellTollTribal.wav"},
    [2]= {name="Thorns", file="Sound\\Spells\\Thorns.wav"},
    [3]= {name="Elf Bell Toll", file="Sound\\Doodad\\BellTollNightElf.wav"},
};
HealBot_Default_Font= "Friz Quadrata TT";
HealBot_Font_Outline={
    [1]= "",
    [2]= "OUTLINE",
    [3]= "THICKOUTLINE",
};

HealBot_ConfigDefaults = {
  Version = HEALBOT_VERSION,
  ShowDebuffWarning = 1,
  SoundDebuffWarning = 0,
  SoundDebuffPlay = HealBot_Default_Sounds[1].name,
  CDCMonitor = 1,
  BuffWatch = 0,
  BuffWatchInCombat = 0,
  DebuffWatch = 1,
  DebuffWatchInCombat = 1,
  IgnoreClassDebuffs = 1,
  IgnoreMovementDebuffs = 1,
  IgnoreFastDurDebuffs = 1,
  IgnoreOnCooldownDebuffs = 0,
  IgnoreNonHarmfulDebuffs = 1,
  IgnoreFriendDebuffs = 1,
  HealBot_Custom_Defuffs_All = {
        [HEALBOT_DISEASE_en] = 0,
        [HEALBOT_MAGIC_en]   = 0,
        [HEALBOT_POISON_en]  = 0,
        [HEALBOT_CURSE_en]   = 0,
    },
  ShortBuffTimer=10,
  LongBuffTimer=120,
  ShowDebuffIcon=1,
  IgnoreFastDurDebuffsSecs=2,
  CDCshownHB=1,
  CDCshownAB=0,
  CurrentSpec=9,
  HealBot_BuffWatchGUID={},
  Skin_ID = -1,
  ButtonCastMethod = 2,
  MacroUse10 = 0,
  HealBot_CDCWarnRange_Bar=3,
  HealBot_CDCWarnRange_Aggro=2,
  HealBot_CDCWarnRange_Screen=2,
  HealBot_CDCWarnRange_Sound=3,
  CrashProt=0,
  CrashProtMacroName="hbCrashProt",
  CrashProtStartTime=2,
  LastVersionSkinUpdate="1.0.0",
  DisableHealBot=0,
  DisableSolo=0,
  DisabledNow=0,
  NoAuraWhenRested=0,
  hbMountsReported={},
  CDCBarColour = {
    [HEALBOT_DISEASE_en] = { R = 0.55, G = 0.19, B = 0.7, },
    [HEALBOT_MAGIC_en] = { R = 0.26, G = 0.33, B = 0.83, },
    [HEALBOT_POISON_en] = { R = 0.12, G = 0.46, B = 0.24, },
    [HEALBOT_CURSE_en] = { R = 0.83, G = 0.43, B = 0.09, },
  },
  SkinDefault = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  EnabledKeyCombo=nil,
  EnabledSpellTarget={},
  EnabledSpellTrinket1={},
  EnabledSpellTrinket2={},
  DisabledKeyCombo = nil,
  DisabledSpellTarget={},
  DisabledSpellTrinket1={},
  DisabledSpellTrinket2={},
  EnableHealthy = 1,
  ActionVisible = 0,
  HealBotDebuffText={},
  HealBotBuffText={},
  HealBotBuffDropDown={},
  HealBotDebuffDropDown={},
  HealBotDebuffPriority={[HEALBOT_DISEASE_en] = 15,
                         [HEALBOT_MAGIC_en] = 13,
                         [HEALBOT_POISON_en] = 16,
                         [HEALBOT_CURSE_en] = 14,
                         [HEALBOT_CUSTOM_en] = 10,
                        },
  HealBotBuffColR={},
  HealBotBuffColG={},
  HealBotBuffColB={},

};

HealBot_Class_En = { 
                [HEALBOT_CLASSES_ALL]="ALL",
                [HEALBOT_DRUID]="DRUI",
                [HEALBOT_HUNTER]="HUNT",
                [HEALBOT_MAGE]="MAGE",
                [HEALBOT_PALADIN]="PALA",
                [HEALBOT_PRIEST]="PRIE",
                [HEALBOT_ROGUE]="ROGU",
                [HEALBOT_SHAMAN]="SHAM",
                [HEALBOT_WARLOCK]="WARL",
                [HEALBOT_WARRIOR]="WARR",
                [HEALBOT_DEATHKNIGHT]="DEAT",
                [HEALBOT_MONK]="MONK",
}

HealBot_GlobalsDefaults = {
    HoTindex=1,
    HoTname=HEALBOT_GUARDIAN_SPIRIT,
    TopRole="TANK",
    TargetBarRestricted=0,
    ResLagDuration=3,
    ByPassLock=0,
    ShowTooltip = 1,
    TooltipUpdate = 0,
    Tooltip_ShowSpellDetail = 0,
    Tooltip_ShowTarget = 1,
    Tooltip_ShowMyBuffs = 0,
    Tooltip_Recommend = 0,
    UseGameTooltip=0,
    Tooltip_ShowHoT=0,
    Tooltip_ShowCD=0,
    ttalpha=0.8,
    DisableToolTipInCombat=0,
    HideOptions = 0,
    ProtectPvP = 0,
    RightButtonOptions = 0,
    SmartCast = 1,
    SmartCastDebuff = 1,
    SmartCastBuff = 1,
    SmartCastHeal = 0,
    SmartCastRes = 1,
    RangeCheckFreq=0.2,
    HealBot_ButtonRadius=78,
    HealBot_ButtonPosition=300,
    ButtonShown=1,
    noTestTanks=3,
    noTestTargets=5,
    noTestPets=4,
    noTestBars=25,
    EmergencyFClass = 4,
    MacroSuppressSound = 1,
    MacroSuppressError = 1,
    AcceptSkins = 1,
    ShowWSicon = 1,
    HealBot_Enable_MouseWheel=1,
    PowerChargeTxtSizeMod=7,
    FocusMonitor = {},
    UpdateMsg=true,
    preloadOptions=1,
    dislikeMount={},
    mapScale={},
    scaleCaliStats={},
    rangeCalibrationWeight = 1,
    aggro2pct=55,
    aggro3pct=100,
    QueryTalents=1,
    EnLibQuickHealth=1,
    HealBot_MouseWheelIndex={ ["AltUp"]=2, ["AltDown"]=3 },
    HealBot_MouseWheelTxt={ ["AltUp"]=HEALBOT_BLIZZARD_MENU, ["AltDown"]=HEALBOT_HB_MENU },
    EmergIncRange = {
        [HEALBOT_DRUID]    = 0, [HEALBOT_HUNTER]   = 1, [HEALBOT_MAGE]     = 1,
        [HEALBOT_PALADIN]  = 0, [HEALBOT_PRIEST]   = 0, [HEALBOT_ROGUE]    = 0,
        [HEALBOT_SHAMAN]   = 0, [HEALBOT_WARLOCK]  = 1, [HEALBOT_WARRIOR]  = 0, 
        [HEALBOT_MONK]     = 0, [HEALBOT_DEATHKNIGHT] = 0, [HEALBOT_MONK]  = 0,
    },
    EmergIncMelee = {
        [HEALBOT_DRUID]    = 0, [HEALBOT_HUNTER]   = 0, [HEALBOT_MAGE]     = 0,
        [HEALBOT_PALADIN]  = 0, [HEALBOT_PRIEST]   = 0, [HEALBOT_ROGUE]    = 1,
        [HEALBOT_SHAMAN]   = 0, [HEALBOT_WARLOCK]  = 0, [HEALBOT_WARRIOR]  = 1, 
        [HEALBOT_MONK]     = 0, [HEALBOT_DEATHKNIGHT] = 1, [HEALBOT_MONK]  = 0,
    },
    EmergIncHealers = {
        [HEALBOT_DRUID]    = 1, [HEALBOT_HUNTER]   = 0, [HEALBOT_MAGE]     = 0,
        [HEALBOT_PALADIN]  = 0, [HEALBOT_PRIEST]   = 1, [HEALBOT_ROGUE]    = 0,
        [HEALBOT_SHAMAN]   = 0, [HEALBOT_WARLOCK]  = 0, [HEALBOT_WARRIOR]  = 0, 
        [HEALBOT_MONK]     = 1, [HEALBOT_DEATHKNIGHT] = 0, [HEALBOT_MONK]  = 0,
    },
    EmergIncCustom = {
        [HEALBOT_DRUID]    = 1, [HEALBOT_HUNTER]   = 0, [HEALBOT_MAGE]     = 1,
        [HEALBOT_PALADIN]  = 1, [HEALBOT_PRIEST]   = 1, [HEALBOT_ROGUE]    = 0,
        [HEALBOT_SHAMAN]   = 1, [HEALBOT_WARLOCK]  = 1, [HEALBOT_WARRIOR]  = 0, 
        [HEALBOT_MONK]     = 1, [HEALBOT_DEATHKNIGHT] = 0, [HEALBOT_MONK]  = 0,
    },
    CDCBarColour = {
        [HEALBOT_CUSTOM_en] = { R = 0.45, G = 0, B = 0.26, }, -- added by Diacono
    },
    HealBot_Custom_Debuffs_RevDur={},
    HealBot_Custom_Debuffs_ShowBarCol={},
    IgnoreCustomDebuff={},
    FilterCustomDebuff={},
    HealBot_Custom_Debuffs = {
        -- Karazhan
        [HEALBOT_DEBUFF_ICE_TOMB]         = 10, -- Karazhan - Ice Tomb
        [HEALBOT_DEBUFF_SACRIFICE]        = 10, -- Illhoof - Sacrifice
        -- Hyjal    
        [HEALBOT_DEBUFF_ICEBOLT]          = 10, -- Rage Winterchill - Icebolt
        [HEALBOT_DEBUFF_DOOMFIRE]         = 10, -- Archimonde - Doomfire
        -- Black Temple    
        [HEALBOT_DEBUFF_IMPALING_SPINE]   = 10, -- Naj'entus - Impaling Spine
        [HEALBOT_DEBUFF_FEL_RAGE]         = 10, -- Bloodboil - Fel Rage
        [HEALBOT_DEBUFF_FEL_RAGE2]        = 10, -- Bloodboil - Fel Rage 2
        [HEALBOT_DEBUFF_FATAL_ATTRACTION] = 10, -- Mother Shahraz - Fatal Attraction
        [HEALBOT_DEBUFF_AGONIZING_FLAMES] = 10, -- Illidan - Agonizing Flames
        [HEALBOT_DEBUFF_DARK_BARRAGE]     = 10, -- Illidan - Dark Barrage
        [HEALBOT_DEBUFF_PARASITIC_SHADOWFIEND] = 10, -- Illidan - Parasitic Shadowfiend
        -- Zul'Aman    
        [HEALBOT_DEBUFF_GRIEVOUS_THROW]    = 10, -- Zul'jin - Grievous Throw
        -- Sunwell    
        [HEALBOT_DEBUFF_BURN]              = 10, -- Brutallus - Burn
        [HEALBOT_DEBUFF_ENCAPSULATE]       = 10, -- Felymyst - Encapsulate
        [HEALBOT_DEBUFF_FLAME_SEAR]        = 10, -- Warlock Alythess - Flame Sear        
        [HEALBOT_DEBUFF_FIRE_BLOOM]        = 10, -- Kil'jaeden - Fire Bloom
        -- WotLK Dungeons    
        [HEALBOT_DEBUFF_GRIEVOUS_BITE]     = 10, -- Drak'Tharon Keep - Grievous Bite
        [HEALBOT_DEBUFF_FROST_TOMB]        = 10, -- Utgarde Keep - Frost Tomb
        -- Naxxramas    
        [HEALBOT_DEBUFF_WEB_WRAP]          = 10, -- Maexxna - Web Wrap
        [HEALBOT_DEBUFF_JAGGED_KNIFE]      = 10, -- Razuvious - Jagged Knife        
        [HEALBOT_DEBUFF_FROST_BLAST]       = 10, -- Kel'Thuzad - Frost Blast
        -- Ulduar
        [HEALBOT_DEBUFF_SLAG_POT]          = 10, -- Ignis - Slag Pot
        [HEALBOT_DEBUFF_GRAVITY_BOMB]      = 10, -- XT-002 - Gravity Bomb       
        [HEALBOT_DEBUFF_STONE_GRIP]        = 10, -- Kologarn - Stone Grip
        [HEALBOT_DEBUFF_FERAL_POUNCE]      = 10, -- Auriaya - Feral Pounce      
        [HEALBOT_DEBUFF_NAPALM_SHELL]      = 10, -- Mimiron - Napalm Shell
        [HEALBOT_DEBUFF_IRON_ROOTS]        = 10, -- Freya - Iron Roots
        [HEALBOT_DEBUFF_SARA_BLESSING]     = 10, -- Yogg-Saron - Sara's Blessing
        -- Trial of the Crusader
        [HEALBOT_DEBUFF_IMPALE]            = 10, -- Northrend Beasts - Impale
        [HEALBOT_DEBUFF_SNOBOLLED]         = 10, -- Northrend Beasts - Snobolled!
        [HEALBOT_DEBUFF_FIRE_BOMB]         = 10, -- Northrend Beasts - Fire Bomb
        [HEALBOT_DEBUFF_BURNING_BILE]      = 10, -- Northrend Beasts - Burning Bile
        [HEALBOT_DEBUFF_PARALYTIC_TOXIN]   = 10, -- Northrend Beasts - Paralytic Toxin
        [HEALBOT_DEBUFF_INCINERATE_FLESH]  = 10, -- Lord Jaraxxus - Incinerate Flesh
        [HEALBOT_DEBUFF_LEGION_FLAME]      = 10, -- Lord Jaraxxus - Legion Flame
        [HEALBOT_DEBUFF_MISTRESS_KISS]     = 10, -- Lord Jaraxxus - Mistress' Kiss
        [HEALBOT_DEBUFF_SPINNING_PAIN_SPIKE] = 10, -- Lord Jaraxxus - Spinning Pain Spike
        [HEALBOT_DEBUFF_TOUCH_OF_LIGHT]    = 10, -- Twin Val'kyr - Touch of Light
        [HEALBOT_DEBUFF_TOUCH_OF_DARKNESS] = 10, -- Twin Val'kyr - Touch of Darkness
        [HEALBOT_DEBUFF_PENETRATING_COLD]  = 10, -- Anub'arak - Penetrating Cold
        [HEALBOT_DEBUFF_ACID_DRENCHED_MANDIBLES] = 10, -- Anub'arak - Acid-Drenched Mandibles
        [HEALBOT_DEBUFF_EXPOSE_WEAKNESS]   = 10, -- Anub'arak - Expose Weakness
        -- Icecrown Citadel - Lower Spire
        [HEALBOT_DEBUFF_IMPALED]           = 10, -- Lord Marrowgar - Impaled
        [HEALBOT_DEBUFF_NECROTIC_STRIKE]   = 10, -- Lady Deathwhisper - Necrotic Strike
        [HEALBOT_DEBUFF_FALLEN_CHAMPION]   = 10, -- Deathbringer Saurfang - Mark of the Fallen Champion
        [HEALBOT_DEBUFF_BOILING_BLOOD]     = 10, -- Deathbringer Saurfang - Boiling Blood
        [HEALBOT_DEBUFF_RUNE_OF_BLOOD]     = 10, -- Deathbringer Saurfang - Rune of Blood
        -- Icecrown Citadel - The Plagueworks
        [HEALBOT_DEBUFF_VILE_GAS]          = 10, -- Festergut - Vile Gas
        [HEALBOT_DEBUFF_GASTRIC_BLOAT]     = 10, -- Festergut - Gastric Bloat   
        [HEALBOT_DEBUFF_GAS_SPORE]         = 10, -- Festergut - Gas Spore        
        [HEALBOT_DEBUFF_MUTATED_INFECTION] = 10, -- Rotface - Mutated Infection
        [HEALBOT_DEBUFF_GASEOUS_BLOAT]     = 10, -- Professor Putricide - Gaseous Bloat
        [HEALBOT_DEBUFF_VOLATILE_OOZE]     = 10, -- Professor Putricide - Volatile Ooze Adhesive
        [HEALBOT_DEBUFF_MUTATED_PLAGUE]    = 10, -- Professor Putricide - Mutated Plague
        -- Icecrown Citadel - The Crimson Hall
        [HEALBOT_DEBUFF_GLITTERING_SPARKS] = 10, -- Blood Prince Council - Glittering Sparks
        [HEALBOT_DEBUFF_SHADOW_PRISON]     = 10, -- Blood Prince Council - Shadow Prison
        [HEALBOT_DEBUFF_SWARMING_SHADOWS]  = 10, -- Queen Lana'thel - Swarming Shadows
        [HEALBOT_DEBUFF_PACT_DARKFALLEN]   = 10, -- Queen Lana'thel - Pact of the Darkfallen
        [HEALBOT_DEBUFF_ESSENCE_BLOOD_QUEEN] = 10, -- Queen Lana'thel - Essence of the Blood Queen
        [HEALBOT_DEBUFF_DELIRIOUS_SLASH]   = 10, -- Queen Lana'thel - Delirious Slash
        -- Icecrown Citadel - Frostwing Halls
        [HEALBOT_DEBUFF_CORROSION]         = 10, -- Valithiria Dreamwalker - Corrosion
        [HEALBOT_DEBUFF_GUT_SPRAY]         = 10, -- Valithiria Dreamwalker - Gut Spray
        [HEALBOT_DEBUFF_ICE_TOMB]          = 10, -- Sindragosa - Ice Tomb
        [HEALBOT_DEBUFF_FROST_BEACON]      = 10, -- Sindragosa - Frost Beacon
        [HEALBOT_DEBUFF_CHILLED_BONE]      = 10, -- Sindragosa - Chilled to the Bone
        [HEALBOT_DEBUFF_INSTABILITY]       = 10, -- Sindragosa - Instability
        [HEALBOT_DEBUFF_MYSTIC_BUFFET]     = 10, -- Sindragosa - Mystic Buffet
        [HEALBOT_DEBUFF_FROST_BREATH]      = 10, -- Sindragosa - Frost Breath
        -- Icecrown Citadel - The Frozen Throne
        [HEALBOT_DEBUFF_INFEST]            = 10, -- Lich King - Infest
        [HEALBOT_DEBUFF_NECROTIC_PLAGUE]   = 10, -- Lich King - Necrotic Plague
        [HEALBOT_DEBUFF_DEFILE]            = 10, -- Lich King - Defile
        [HEALBOT_DEBUFF_HARVEST_SOUL]      = 10, -- Lich King - Harvest Soul 
        -- Ruby Sanctum
        [HEALBOT_DEBUFF_CONFLAGRATION]     = 10, -- Saviana Ragefire - Conflagration
        [HEALBOT_DEBUFF_FIERY_COMBUSTION]  = 10, -- Halion - Fiery Combustion
        [HEALBOT_DEBUFF_COMBUSTION]        = 10, -- Halion (heroic) - Combustion
        [HEALBOT_DEBUFF_SOUL_CONSUMPTION]  = 10, -- Halion - Soul Consumption
        [HEALBOT_DEBUFF_CONSUMPTION]       = 10, -- Halion (heroic) - Consumption
        -- Throne of the Four Winds
        [HEALBOT_DEBUFF_TOXIC_SPORES]      = 10, -- Conclave of Wind - Toxic Spores
        [HEALBOT_DEBUFF_LIGHTNING_ROD]     = 10, -- Al'Akir - Lightning Rod
        -- Blackwing Descent
        [HEALBOT_DEBUFF_PARASITIC_INFECT]  = 10, -- Magmaw - Parasitic Infection
        [HEALBOT_DEBUFF_CONSUMING_FLAMES]  = 10, -- Maloriak - Consuming Flames
        [HEALBOT_DEBUFF_FLASH_FREEZE]      = 10, -- Maloriak - Flash Freeze
        [HEALBOT_DEBUFF_EXPLOSIVE_CINDERS] = 10, -- Nefarian - Explosive Cinders
        -- Bastion of Twilight
        [HEALBOT_DEBUFF_WATERLOGGED]       = 10, -- Ascendant Council - Waterlogged
        [HEALBOT_DEBUFF_GRAVITY_CORE]      = 10, -- Ascendant Council (heroic) - Gravity Core
        [HEALBOT_DEBUFF_GRAVITY_CRUSH]     = 10, -- Ascendant Council - Gravity Crush
    },
    Custom_Debuff_Categories=HEALBOT_CUSTOM_DEBUFF_CATS;
    HoTReserve = {
        ["DRUI"] = {[1] = 1, [2] = 1, [3] = 1, [4] = 1},
        ["HUNT"] = {[1] = 1, [2] = 1, [3] = 1, [4] = 1},
        ["MAGE"] = {[1] = 1, [2] = 1, [3] = 1, [4] = 1},
        ["PALA"] = {[1] = 1, [2] = 1, [3] = 1, [4] = 1},
        ["PRIE"] = {[1] = 1, [2] = 1, [3] = 1, [4] = 1},
        ["ROGU"] = {[1] = 1, [2] = 1, [3] = 1, [4] = 1},
        ["SHAM"] = {[1] = 1, [2] = 1, [3] = 1, [4] = 1},
        ["WARL"] = {[1] = 1, [2] = 1, [3] = 1, [4] = 1},
        ["WARR"] = {[1] = 1, [2] = 1, [3] = 1, [4] = 1},
        ["DEAT"] = {[1] = 1, [2] = 1, [3] = 1, [4] = 1},
        ["MONK"] = {[1] = 1, [2] = 1, [3] = 1, [4] = 1},
    },
    WatchHoT = {
        ["DRUI"] = {
            [HEALBOT_REJUVENATION]=2,
            [HEALBOT_LIVING_SEED]=2,
            [HEALBOT_CENARION_WARD]=3,
            [HEALBOT_REGROWTH]=2,
            [HEALBOT_LIFEBLOOM]=2,
            [HEALBOT_WILD_GROWTH]=2,
            [HEALBOT_TRANQUILITY]=2,
            [HEALBOT_ENRAGED_REGEN]=2,
            [HEALBOT_BARKSKIN]=4,
            [HEALBOT_IRONBARK]=2,
            [HEALBOT_HARMONY]=2,
            [HEALBOT_SURVIVAL_INSTINCTS]=2,
            [HEALBOT_FRENZIED_REGEN]=2,
            [HEALBOT_NATURES_GRASP]=2,
            [HEALBOT_NATURE_SWIFTNESS]=2,
        },
        ["HUNT"] = {
            [HEALBOT_MENDPET]=2,
        }, 
        ["MAGE"] = {
            [HEALBOT_EVOCATION]=2,
        },
        ["PALA"] = {
            [HEALBOT_FLASH_OF_LIGHT]=2,
            [HEALBOT_BEACON_OF_LIGHT]=2,
			[HEALBOT_GUARDED_BY_THE_LIGHT]=3,
            [HEALBOT_WORD_OF_GLORY]=2,
            [HEALBOT_HAND_OF_FREEDOM]=3,
            [HEALBOT_LIGHT_BEACON]=3,
            [HEALBOT_HAND_OF_SALVATION]=3,
            [HEALBOT_DIVINE_SHIELD]=3,
            [HEALBOT_HAND_OF_SACRIFICE]=3,
            [HEALBOT_INFUSION_OF_LIGHT]=2,
            [HEALBOT_SPEED_OF_LIGHT]=2,
            [HEALBOT_DAY_BREAK]=2,
            [HEALBOT_SACRED_SHIELD]=3,
            [HEALBOT_HAND_OF_PURITY]=3,
            [HEALBOT_DIVINE_PURPOSE]=2,
            [HEALBOT_ETERNAL_FLAME]=3,
            [HEALBOT_HOLY_SHIELD]=2,
            [HEALBOT_ILLUMINATED_HEALING]=2,
            [HEALBOT_ARDENT_DEFENDER]=2,
            [HEALBOT_DENOUNCE]=2,
            [HEALBOT_DIVINE_PROTECTION]=4,
        },
        ["PRIE"] = {
            [HEALBOT_GUARDIAN_SPIRIT]=3,
            [HEALBOT_PAIN_SUPPRESSION]=3,
            [HEALBOT_POWER_INFUSION]=3,
            [HEALBOT_RENEW]=2,
            [HEALBOT_DIVINE_HYMN]=2,
            [HEALBOT_POWER_WORD_SHIELD]=3,
            [HEALBOT_SPIRIT_SHELL]=3,
            [HEALBOT_POWER_WORD_BARRIER]=3,
            [HEALBOT_PRAYER_OF_MENDING]=3,
            [HEALBOT_ECHO_OF_LIGHT]=3,
			[HEALBOT_GRACE]=2,
            [HEALBOT_LIGHTWELL_RENEW]=2,
            [HEALBOT_DIVINE_AEGIS]=2,
            [HEALBOT_EVANGELISM]=2,
            [HEALBOT_ARCHANGEL]=2,
            [HEALBOT_DIVINE_INSIGHT]=2,
            [HEALBOT_FEAR_WARD]=3,
            [HEALBOT_BLESSED_HEALING]=2,
            [HEALBOT_INNER_FOCUS]=2,
            [HEALBOT_SERENDIPITY]=2,
        },
        ["ROGU"] = {
            [HEALBOT_VANISH]=2,
        },
        ["SHAM"] = {
            [HEALBOT_RIPTIDE]=2,
            [HEALBOT_EARTHLIVING_WEAPON]=2,
            [HEALBOT_EARTH_SHIELD]=3,
            [HEALBOT_WATER_SHIELD]=2,
            [HEALBOT_LIGHTNING_SHIELD]=2,
            [HEALBOT_CHAINHEALHOT]=2,
            [HEALBOT_EARTHLIVING]=2,
            [HEALBOT_UNLEASHED_FURY]=2,
            [HEALBOT_TIDAL_WAVES]=2,
            [HEALBOT_NATURE_SWIFTNESS]=2,
			[HEALBOT_HEALING_RAIN]=2,
        },
        ["WARL"] = {
            [HEALBOT_DARK_INTENT]=2,
        }, 
        ["WARR"] = {
            [HEALBOT_VIGILANCE]=3,
            [HEALBOT_LAST_STAND]=4,
            [HEALBOT_SHIELD_WALL]=4,
            [HEALBOT_SHIELD_BLOCK]=2,
        }, 
        ["DEAT"] = {
            [HEALBOT_ICEBOUND_FORTITUDE]=4,
            [HEALBOT_ANTIMAGIC_SHELL]=4,
            [HEALBOT_ARMY_OF_THE_DEAD]=2,
            [HEALBOT_LICHBORNE]=2,
            [HEALBOT_ANTIMAGIC_ZONE]=2,
            [HEALBOT_VAMPIRIC_BLOOD]=2,
            [HEALBOT_BONE_SHIELD]=2,
        },
        ["MONK"] = {
            [HEALBOT_VIGILANCE]=3,
            [HEALBOT_ENVELOPING_MIST]=2,
            [HEALBOT_ZEN_SPHERE]=2,
            [HEALBOT_LIFE_COCOON]=3,
            [HEALBOT_THUNDER_FOCUS_TEA]=2,
            [HEALBOT_SERPENT_ZEAL]=2,
            [HEALBOT_MANA_TEA]=2,
            [HEALBOT_ZEN_MEDITATION]=2,
            [HEALBOT_SOOTHING_MIST]=2,
            [HEALBOT_RENEWING_MIST]=2,
        },
        ["ALL"] = {
            [HEALBOT_GIFT_OF_THE_NAARU]=1,
            [HEALBOT_GUARDIAN_ANCIENT_KINGS]=2,
        },
    },
};

HealBot_Config_SkinsDefaults = {
  Skin_ID = 1,
  Current_Skin = HEALBOT_SKINS_STD,
  Skins = {HEALBOT_SKINS_STD, HEALBOT_OPTIONS_GROUPHEALS, HEALBOT_OPTIONS_EMERGENCYHEALS, HEALBOT_ZONE_AV},
  numcols = {[HEALBOT_SKINS_STD] = 2, [HEALBOT_OPTIONS_GROUPHEALS] = 3, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 4, [HEALBOT_ZONE_AV] = 3,},
  btexture = {[HEALBOT_SKINS_STD] = HealBot_Default_Textures[8].name, [HEALBOT_OPTIONS_GROUPHEALS] = HealBot_Default_Textures[16].name, 
              [HEALBOT_OPTIONS_EMERGENCYHEALS] = HealBot_Default_Textures[7].name, [HEALBOT_ZONE_AV] = HealBot_Default_Textures[9].name,},
  bcspace = {[HEALBOT_SKINS_STD] = 2, [HEALBOT_OPTIONS_GROUPHEALS] = 4, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 2, [HEALBOT_ZONE_AV] = 1,},
  brspace = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 2, [HEALBOT_ZONE_AV] = 1,},
  bwidth =  {[HEALBOT_SKINS_STD] = 144, [HEALBOT_OPTIONS_GROUPHEALS] = 158, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 95, [HEALBOT_ZONE_AV] = 72,},
  bheight = {[HEALBOT_SKINS_STD] = 25, [HEALBOT_OPTIONS_GROUPHEALS] = 28, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 18, [HEALBOT_ZONE_AV] = 17,},
  btextenabledcolr = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  btextenabledcolg = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  btextenabledcolb = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 0,},
  btextenabledcola = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  btextdisbledcolr = {[HEALBOT_SKINS_STD] = 0.5, [HEALBOT_OPTIONS_GROUPHEALS] = 0.5, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.5, [HEALBOT_ZONE_AV] = 0.4,},
  btextdisbledcolg = {[HEALBOT_SKINS_STD] = 0.5, [HEALBOT_OPTIONS_GROUPHEALS] = 0.5, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.5, [HEALBOT_ZONE_AV] = 0.4,},
  btextdisbledcolb = {[HEALBOT_SKINS_STD] = 0.5, [HEALBOT_OPTIONS_GROUPHEALS] = 0.5, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.5, [HEALBOT_ZONE_AV] = 0.4,},
  btextdisbledcola = {[HEALBOT_SKINS_STD] = 0.4, [HEALBOT_OPTIONS_GROUPHEALS] = 0.4, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.25, [HEALBOT_ZONE_AV] = 0.08,},
  btextcursecolr = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  btextcursecolg = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  btextcursecolb = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  btextcursecola = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  backcola = {[HEALBOT_SKINS_STD] = 0.05, [HEALBOT_OPTIONS_GROUPHEALS] = 0.25, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.02, [HEALBOT_ZONE_AV] = 0.01,},
  Barcola    = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 0.98, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.92, [HEALBOT_ZONE_AV] = 0.88,},
  BarcolaInHeal = {[HEALBOT_SKINS_STD] = 0.12, [HEALBOT_OPTIONS_GROUPHEALS] = 0.5, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.12, [HEALBOT_ZONE_AV] = 0.12,},
  backcolr = {[HEALBOT_SKINS_STD] = 0.1, [HEALBOT_OPTIONS_GROUPHEALS] = 0.1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.1, [HEALBOT_ZONE_AV] = 0.2,},
  backcolg = {[HEALBOT_SKINS_STD] = 0.1, [HEALBOT_OPTIONS_GROUPHEALS] = 0.1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.1, [HEALBOT_ZONE_AV] = 0.2,},
  backcolb = {[HEALBOT_SKINS_STD] = 0.1, [HEALBOT_OPTIONS_GROUPHEALS] = 0.5, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.7, [HEALBOT_ZONE_AV] = 0.2,},
  borcolr = {[HEALBOT_SKINS_STD] = 0.2, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 0.2,},
  borcolg = {[HEALBOT_SKINS_STD] = 0.2, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 0.2,},
  borcolb = {[HEALBOT_SKINS_STD] = 0.2, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 0.2,},
  borcola = {[HEALBOT_SKINS_STD] = 0.2, [HEALBOT_OPTIONS_GROUPHEALS] = 0.5, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.04, [HEALBOT_ZONE_AV] = 0.5,},
  btextfont = {[HEALBOT_SKINS_STD] = HealBot_Default_Font, [HEALBOT_OPTIONS_GROUPHEALS] = HealBot_Default_Font, 
               [HEALBOT_OPTIONS_EMERGENCYHEALS] = HealBot_Default_Font, [HEALBOT_ZONE_AV] = HealBot_Default_Font,},
  btextheight = {[HEALBOT_SKINS_STD] = 10, [HEALBOT_OPTIONS_GROUPHEALS] = 10, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 9, [HEALBOT_ZONE_AV] = 10,},
  btextoutline = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  bardisa = {[HEALBOT_SKINS_STD] = 0.22, [HEALBOT_OPTIONS_GROUPHEALS] = 0.01, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.12, [HEALBOT_ZONE_AV] = 0.05,},
  bareora = {[HEALBOT_SKINS_STD] = 0.52, [HEALBOT_OPTIONS_GROUPHEALS] = 0.7, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.35, [HEALBOT_ZONE_AV] = 0.3,},
  bar2size = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 0,},
  ShowHeader = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 0,},
  headbarcolr = {[HEALBOT_SKINS_STD] = 0.1, [HEALBOT_OPTIONS_GROUPHEALS] = 0.1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.1, [HEALBOT_ZONE_AV] = 0.1,},
  headbarcolg = {[HEALBOT_SKINS_STD] = 0.7, [HEALBOT_OPTIONS_GROUPHEALS] = 0.1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.1, [HEALBOT_ZONE_AV] = 0.1,},
  headbarcolb = {[HEALBOT_SKINS_STD] = 0.1, [HEALBOT_OPTIONS_GROUPHEALS] = 0.1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.1, [HEALBOT_ZONE_AV] = 0.1,},
  headbarcola = {[HEALBOT_SKINS_STD] = 0.4, [HEALBOT_OPTIONS_GROUPHEALS] = 0.25, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.25, [HEALBOT_ZONE_AV] = 0,},
  headtxtcolr = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  headtxtcolg = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  headtxtcolb = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 0.1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.1, [HEALBOT_ZONE_AV] = 0.1,},
  headtxtcola = {[HEALBOT_SKINS_STD] = 0.74, [HEALBOT_OPTIONS_GROUPHEALS] = 0.7, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.55, [HEALBOT_ZONE_AV] = 0.4,},
  headtexture = {[HEALBOT_SKINS_STD] = HealBot_Default_Textures[10].name, [HEALBOT_OPTIONS_GROUPHEALS] = HealBot_Default_Textures[11].name, 
                 [HEALBOT_OPTIONS_EMERGENCYHEALS] = HealBot_Default_Textures[12].name, [HEALBOT_ZONE_AV] = HealBot_Default_Textures[12].name,},
  headwidth   = {[HEALBOT_SKINS_STD] = 0.7, [HEALBOT_OPTIONS_GROUPHEALS] = 0.9, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.9, [HEALBOT_ZONE_AV] = 0.9,},
  headtextfont = {[HEALBOT_SKINS_STD] = HealBot_Default_Font, [HEALBOT_OPTIONS_GROUPHEALS] = HealBot_Default_Font, 
                  [HEALBOT_OPTIONS_EMERGENCYHEALS] = HealBot_Default_Font, [HEALBOT_ZONE_AV] = HealBot_Default_Font,},
  headtextheight = {[HEALBOT_SKINS_STD] = 9, [HEALBOT_OPTIONS_GROUPHEALS] = 10, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 9, [HEALBOT_ZONE_AV] = 9,},
  headtextoutline = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  ShowAggro = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  ShowAggroBars = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 0,},
  ShowAggroText = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  ShowAggroBarsPct = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 0,},
  ShowAggroTextPct = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 0,},
  UseFluidBars = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 0,},
  BarFreq = {[HEALBOT_SKINS_STD] = 7, [HEALBOT_OPTIONS_GROUPHEALS] = 8, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 8, [HEALBOT_ZONE_AV] = 8,},
  ShowHoTicons = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 0,},
  ShowRaidIcon = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  ShowDebuffIcon = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  HoTonBar = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  HoTposBar = {[HEALBOT_SKINS_STD] = 2, [HEALBOT_OPTIONS_GROUPHEALS] = 2, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 2, [HEALBOT_ZONE_AV] = 2,},
  HoTx2Bar = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  ShowClassOnBar = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 0,},
  ShowClassType = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  ShowNameOnBar = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  ShowHealthOnBar = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 0,},
  BarHealthIncHeals = {[HEALBOT_SKINS_STD] = 2, [HEALBOT_OPTIONS_GROUPHEALS] = 2, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 2, [HEALBOT_ZONE_AV] = 2,},
  BarHealthNumFormat1 = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  BarHealthNumFormat2 = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 3, [HEALBOT_ZONE_AV] = 1,},
  BarHealthNumFormatAggro = {[HEALBOT_SKINS_STD] = 3, [HEALBOT_OPTIONS_GROUPHEALS] = 3, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 5, [HEALBOT_ZONE_AV] = 3,},
  BarHealthType = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 3, [HEALBOT_ZONE_AV] = 3,},
  SetClassColourText = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 0,},
  IncHealBarColour = {[HEALBOT_SKINS_STD] = 4, [HEALBOT_OPTIONS_GROUPHEALS] = 4, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 4, [HEALBOT_ZONE_AV] = 4,},
  HlthBarColour = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  HlthBackColour = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 2, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  barcolr = {[HEALBOT_SKINS_STD] = 0.4, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.2, [HEALBOT_ZONE_AV] = 0,},
  barcolg = {[HEALBOT_SKINS_STD] = 0.4, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.4, [HEALBOT_ZONE_AV] = 0.2,},
  barcolb = {[HEALBOT_SKINS_STD] = 0.7, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.4, [HEALBOT_ZONE_AV] = 0.2,},
  ihbarcolr = {[HEALBOT_SKINS_STD] = 0.2, [HEALBOT_OPTIONS_GROUPHEALS] = 0.4, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.2, [HEALBOT_ZONE_AV] = 0,},
  ihbarcolg = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.8, [HEALBOT_ZONE_AV] = 0.5,},
  ihbarcolb = {[HEALBOT_SKINS_STD] = 0.2, [HEALBOT_OPTIONS_GROUPHEALS] = 0.4, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.2, [HEALBOT_ZONE_AV] = 0,},
  barbackcolr = {[HEALBOT_SKINS_STD] = 0.4, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.2, [HEALBOT_ZONE_AV] = 0,},
  barbackcolg = {[HEALBOT_SKINS_STD] = 0.4, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.4, [HEALBOT_ZONE_AV] = 0.2,},
  barbackcolb = {[HEALBOT_SKINS_STD] = 0.7, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.4, [HEALBOT_ZONE_AV] = 0.2,},
  barbackcola = {[HEALBOT_SKINS_STD] = 0.1, [HEALBOT_OPTIONS_GROUPHEALS] = 0.5, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.1, [HEALBOT_ZONE_AV] = 0,},
  ShowIconTextCount = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  ShowIconTextCountSelfCast = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 0,},
  ShowIconTextDuration = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 0,},
  ShowIconTextDurationSelfCast = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  IconScale = {[HEALBOT_SKINS_STD] = 0.7, [HEALBOT_OPTIONS_GROUPHEALS] = 0.55, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.75, [HEALBOT_ZONE_AV] = 0.5,},
  IconTextScale = {[HEALBOT_SKINS_STD] = 0.75, [HEALBOT_OPTIONS_GROUPHEALS] = 0.75, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.6, [HEALBOT_ZONE_AV] = 0.55,},
  AggroBarSize = {[HEALBOT_SKINS_STD] = 2, [HEALBOT_OPTIONS_GROUPHEALS] = 2, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 2, [HEALBOT_ZONE_AV] = 1,},
  DoubleText = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 0,},
  TextAlignment = {[HEALBOT_SKINS_STD] = 2, [HEALBOT_OPTIONS_GROUPHEALS] = 2, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 2, [HEALBOT_ZONE_AV] = 2,},
  HighLightActiveBar = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 0,},
  HighLightActiveBarInCombat = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 0,},
  highcolr = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  highcolg = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  highcolb = {[HEALBOT_SKINS_STD] = 0.7, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  HighLightTargetBar = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 0,},
  HighLightTargetBarInCombat = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 0,},
  targetcolr = {[HEALBOT_SKINS_STD] = 0.8, [HEALBOT_OPTIONS_GROUPHEALS] = 0.8, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.8, [HEALBOT_ZONE_AV] = 0.8,},
  targetcolg = {[HEALBOT_SKINS_STD] = 0.8, [HEALBOT_OPTIONS_GROUPHEALS] = 0.8, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.8, [HEALBOT_ZONE_AV] = 0.8,},
  targetcolb = {[HEALBOT_SKINS_STD] = 0.7, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  PanelAnchorY = {[HEALBOT_SKINS_STD] = GetScreenHeight()/2, [HEALBOT_OPTIONS_GROUPHEALS] = GetScreenHeight()/2, 
                  [HEALBOT_OPTIONS_EMERGENCYHEALS] = GetScreenHeight()/2, [HEALBOT_ZONE_AV] = GetScreenHeight()/2,},
  PanelAnchorX = {[HEALBOT_SKINS_STD] = GetScreenWidth()/2, [HEALBOT_OPTIONS_GROUPHEALS] = GetScreenWidth()/2, 
                  [HEALBOT_OPTIONS_EMERGENCYHEALS] = GetScreenWidth()/2, [HEALBOT_ZONE_AV] = GetScreenWidth()/2,},
  GroupsPerCol = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 0,},
  headhight = {[HEALBOT_SKINS_STD] = 0.5, [HEALBOT_OPTIONS_GROUPHEALS] = 0.8, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.5, [HEALBOT_ZONE_AV] = 0.4,},
  SelfHeals = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 0,},
  SelfPet = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 0,},
  PetHeals = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  GroupHeals = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  TankHeals = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 0,},
  MainAssistHeals = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 0,},
  SelfPet = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 0,},
  EmergencyHeals = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  SetFocusBar = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  VehicleHeals = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 0,},
  ShowMyTargetsList = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 0,},
  TargetHeals = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 0,},
  TargetIncSelf = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 0,},
  TargetIncGroup = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 0,},
  TargetIncRaid = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 0,},
  TargetIncPet = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 0,},
  TargetBarAlwaysShow = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 0,},
  FocusBarAlwaysShow = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 0,},
  GroupPetsBy5 = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  AlertLevel = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 0.98, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.88, [HEALBOT_ZONE_AV] = 0.75,},
  HidePartyFrames = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 0,},
  HidePlayerTarget = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 0,},
  CastNotify = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  NotifyChan = {[HEALBOT_SKINS_STD] = "", [HEALBOT_OPTIONS_GROUPHEALS] = "", [HEALBOT_OPTIONS_EMERGENCYHEALS] = "", [HEALBOT_ZONE_AV] = "",},
  NotifyOtherMsg = {[HEALBOT_SKINS_STD] = HEALBOT_NOTIFYOTHERMSG, [HEALBOT_OPTIONS_GROUPHEALS] = HEALBOT_NOTIFYOTHERMSG, 
                    [HEALBOT_OPTIONS_EMERGENCYHEALS] = HEALBOT_NOTIFYOTHERMSG, [HEALBOT_ZONE_AV] = HEALBOT_NOTIFYOTHERMSG,},
  CastNotifyResOnly = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  EmergIncMonitor = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  ExtraOrder = {[HEALBOT_SKINS_STD] = 3, [HEALBOT_OPTIONS_GROUPHEALS] = 3, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 3, [HEALBOT_ZONE_AV] = 3,},
  ExtraSubOrder = {[HEALBOT_SKINS_STD] = 5, [HEALBOT_OPTIONS_GROUPHEALS] = 5, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  SubSortIncGroup = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  SubSortIncPet = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  SubSortIncVehicle = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  SubSortIncTanks = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  SubSortIncMyTargets = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 0,},
  Panel_Anchor = {[HEALBOT_SKINS_STD] = 3, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  Bars_Anchor = {[HEALBOT_SKINS_STD] = 3, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  ExtraIncGroup = {[HEALBOT_SKINS_STD] = {[1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true},
                   [HEALBOT_OPTIONS_GROUPHEALS] = {[1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true},
                   [HEALBOT_OPTIONS_EMERGENCYHEALS] = {[1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true},
                   [HEALBOT_ZONE_AV] = {[1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true},
                  },
  ActionLocked = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 0,},
  AutoClose = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 0,},
  PanelSounds = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 0,},
  ShowRaidIconStar = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  ShowRaidIconCircle = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  ShowRaidIconDiamond = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  ShowRaidIconTriangle = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  ShowRaidIconMoon = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  ShowRaidIconSquare = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  ShowRaidIconCross = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  ShowRaidIconSkull = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  ReadyCheck = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 0,},
  SubSortPlayerFirst = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 0,},
  AggroAlertLevel = {[HEALBOT_SKINS_STD] = 2, [HEALBOT_OPTIONS_GROUPHEALS] = 2, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 2, [HEALBOT_ZONE_AV] = 2,},
  AggroIndAlertLevel = {[HEALBOT_SKINS_STD] = 2, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 2, [HEALBOT_ZONE_AV] = 3,},
  AggroColr =  {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  AggroColg =  {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 0,},
  AggroColb =  {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 0,},
  AggroBarsMaxAlpha = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  AggroBarsMinAlpha = {[HEALBOT_SKINS_STD] = 0.2, [HEALBOT_OPTIONS_GROUPHEALS] = 0.2, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.2, [HEALBOT_ZONE_AV] = 0.2,},
  AggroBarsFreq = {[HEALBOT_SKINS_STD] = 0.03, [HEALBOT_OPTIONS_GROUPHEALS] = 0.03, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0.03, [HEALBOT_ZONE_AV] = 0.03,},
  IconTextDurationShow = {[HEALBOT_SKINS_STD] = 9, [HEALBOT_OPTIONS_GROUPHEALS] = 9, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 9, [HEALBOT_ZONE_AV] = 9,},
  IconTextDurationWarn = {[HEALBOT_SKINS_STD] = 3, [HEALBOT_OPTIONS_GROUPHEALS] = 3, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 3, [HEALBOT_ZONE_AV] = 3,},
  CrashProt = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 0,},
  CombatProt = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 0,},
  CombatProtParty = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 1,},
  CombatProtRaid = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  PowerCounter = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  HideBars = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 1,},
  HideIncTank = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 0,},
  HideIncGroup = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 1,},
  HideIncFocus = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 0,},
  HideIncMyTargets = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 0,},
  DisableHealBot = {[HEALBOT_SKINS_STD] = 0, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 0,},
  TooltipPos = {[HEALBOT_SKINS_STD] = 5, [HEALBOT_OPTIONS_GROUPHEALS] = 5, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 5, [HEALBOT_ZONE_AV] = 5,},
  FrameScale = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  ShowAggroInd  = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 0, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 0, [HEALBOT_ZONE_AV] = 0,},
  LowManaInd  = {[HEALBOT_SKINS_STD] = 2, [HEALBOT_OPTIONS_GROUPHEALS] = 3, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 2, [HEALBOT_ZONE_AV] = 1,},
  LowManaIndIC  = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  ShowRole  = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
};

HealBot_Config = {};
HealBot_Globals = {};
Healbot_Config_Skins = {};

HealBot_UnitDebuff = {};
HealBot_UnitBuff = {};
HealBot_EmergInc = {}
HealBot_OtherSpells = {};
HealBot_Spells = {};
HealBot_DebuffSpell = {};
HealBot_IsFighting = nil;

HealBot_Action_TooltipUnit=nil;
Delay_RecalcParty=0;
HealBot_PlayerClass=nil;
HealBot_PlayerClassEN=nil;
HealBot_PlayerClassTrim=nil;
HealBot_PlayerRace=nil;
HealBot_PlayerRaceEN=nil;
HealBot_UnitName = {};
HealBot_UnitID = {};
HealBot_UnitSpec = {};
HealBot_UnitRole = {};
HealBot_PlayerName=nil;
HealBot_PlayerGUID=nil;
HealBot_UnitTime={}
HealBot_Unit_Button={};
HealBot_HoT_Active_Button={};
HealBot_InspectUnit=false
