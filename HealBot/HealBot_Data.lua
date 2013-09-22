HealBot_lastVerSkinUpdate="5.3.0.0"

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
  LastVersionSkinUpdate=HealBot_lastVerSkinUpdate,
  CurrentSpec=9,
  HealBot_BuffWatchGUID={},
  Skin_ID = -1,
  MacroUse10 = 0,
  CrashProtMacroName="hbCrashProt",
  CrashProtStartTime=2,
  DisableHealBot=0,
  DisableSolo=0,
  DisabledNow=0,
  SkinDefault = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  ActionVisible = {[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[8]=0,[9]=0,[10]=0},
  EnableHealthy = 1,
  Profile=1,
};

HealBot_Config_SpellsDefaults = {
  EnabledKeyCombo=nil,
  EnabledSpellTarget={},
  EnabledSpellTrinket1={},
  EnabledSpellTrinket2={},
  EnabledAvoidBlueCursor={},
  DisabledKeyCombo = nil,
  DisabledSpellTarget={},
  DisabledSpellTrinket1={},
  DisabledSpellTrinket2={},
  DisabledAvoidBlueCursor={},
  EnemyKeyCombo=nil,
  EnemySpellTarget={},
  EnemySpellTrinket1={},
  EnemySpellTrinket2={},
  EnemyAvoidBlueCursor={},
  ButtonCastMethod = 2,
};

HealBot_Config_BuffsDefaults = {
  BuffWatch = 1,
  BuffWatchInCombat = 0,
  ShortBuffTimer=10,
  LongBuffTimer=120,
  BuffWatchWhenGrouped = 1,
  NoAuraWhenRested=0,
  HealBotBuffText={},
  HealBotBuffDropDown={},
  HealBotBuffColR={},
  HealBotBuffColG={},
  HealBotBuffColB={},
};

HealBot_Config_CuresDefaults = {
  SoundDebuffWarning = 0,
  DebuffWatch = 1,
  IgnoreClassDebuffs = 1,
  IgnoreNonHarmfulDebuffs = 1,
  IgnoreFastDurDebuffs = 1,
  IgnoreFastDurDebuffsSecs=2,
  IgnoreOnCooldownDebuffs = 0,
  IgnoreMovementDebuffs = 1,
  IgnoreFriendDebuffs = 1,
  SoundDebuffPlay = HealBot_Default_Sounds[1].name,
  DebuffWatchInCombat = 1,
  DebuffWatchWhenGrouped = 0,
  ShowDebuffWarning = 1,
  CDCshownHB=1,
  CDCshownAB=0,
  HealBot_CDCWarnRange_Bar=3,
  HealBot_CDCWarnRange_Aggro=2,
  HealBot_CDCWarnRange_Screen=2,
  HealBot_CDCWarnRange_Sound=3,
  HealBotDebuffText={},
  HealBotDebuffDropDown={},
  HealBotDebuffPriority={
    [HEALBOT_DISEASE_en] = 15,
    [HEALBOT_MAGIC_en] = 13,
    [HEALBOT_POISON_en] = 16,
    [HEALBOT_CURSE_en] = 14,
    [HEALBOT_CUSTOM_en] = 10,
  },
  CDCBarColour = {
    [HEALBOT_DISEASE_en] = { R = 0.55, G = 0.19, B = 0.7, },
    [HEALBOT_MAGIC_en] = { R = 0.26, G = 0.33, B = 0.83, },
    [HEALBOT_POISON_en] = { R = 0.12, G = 0.46, B = 0.24, },
    [HEALBOT_CURSE_en] = { R = 0.83, G = 0.43, B = 0.09, },
  },
  HealBot_Custom_Defuffs_All = {
    [HEALBOT_DISEASE_en] = 0,
    [HEALBOT_MAGIC_en]   = 0,
    [HEALBOT_POISON_en]  = 0,
    [HEALBOT_CURSE_en]   = 0,
  },
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

HEALBOT_OPTIONS_SELFHEALS_en = HEALBOT_OPTIONS_SELFHEALS
HEALBOT_OPTIONS_TANKHEALS_en = HEALBOT_OPTIONS_TANKHEALS
HEALBOT_CLASSES_HEALERS_en = HEALBOT_CLASSES_HEALERS
HEALBOT_OPTIONS_GROUPHEALS_en = HEALBOT_OPTIONS_GROUPHEALS
HEALBOT_OPTIONS_MYTARGET_en = HEALBOT_OPTIONS_MYTARGET
HEALBOT_FOCUS_en = HEALBOT_FOCUS
HEALBOT_OPTIONS_EMERGENCYHEALS_en = HEALBOT_OPTIONS_EMERGENCYHEALS
HEALBOT_OPTIONS_PETHEALS_en = HEALBOT_OPTIONS_PETHEALS
HEALBOT_VEHICLE_en = HEALBOT_VEHICLE
HEALBOT_OPTIONS_TARGETHEALS_en = HEALBOT_OPTIONS_TARGETHEALS
HEALBOT_CUSTOM_CASTBY_ENEMY_en = HEALBOT_CUSTOM_CASTBY_ENEMY

HealBot_HealGroupsTrans = { [HEALBOT_OPTIONS_SELFHEALS_en] = HEALBOT_OPTIONS_SELFHEALS,
                            [HEALBOT_OPTIONS_TANKHEALS_en] = HEALBOT_OPTIONS_TANKHEALS,
                            [HEALBOT_CLASSES_HEALERS_en] = HEALBOT_CLASSES_HEALERS,
                            [HEALBOT_OPTIONS_GROUPHEALS_en] = HEALBOT_OPTIONS_GROUPHEALS,
                            [HEALBOT_OPTIONS_MYTARGET_en] = HEALBOT_OPTIONS_MYTARGET,
                            [HEALBOT_FOCUS_en] = HEALBOT_FOCUS,
                            [HEALBOT_OPTIONS_EMERGENCYHEALS_en] = HEALBOT_OPTIONS_EMERGENCYHEALS,
                            [HEALBOT_OPTIONS_PETHEALS_en] = HEALBOT_OPTIONS_PETHEALS,
                            [HEALBOT_VEHICLE_en] = HEALBOT_VEHICLE,
                            [HEALBOT_OPTIONS_TARGETHEALS_en] = HEALBOT_OPTIONS_TARGETHEALS,
                            [HEALBOT_CUSTOM_CASTBY_ENEMY_en] = HEALBOT_CUSTOM_CASTBY_ENEMY,
                            }

HealBot_MapScaleDefaults = {                   
    zScale={},
}

HealBot_GlobalsDefaults = {
    HoTindex=1,
    HoTname=HEALBOT_GUARDIAN_SPIRIT,
    TopRole="TANK",
    TargetBarRestricted=0,
    ResLagDuration=3,
    ByPassLock=0,
    ShowTooltip = 1,
    TooltipUpdate = 1,
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
    TestBars={["BARS"]=25,["PETS"]=4,["TARGETS"]=5,["HEALERS"]=3,["TANKS"]=2,["PROFILE"]=3},
    EmergencyFClass = 4,
    MacroSuppressSound = 1,
    MacroSuppressError = 1,
    AcceptSkins = 1,
    ShowIconTxt2 = {},
    HealBot_Enable_MouseWheel=1,
    PowerChargeTxtSizeMod=7,
    FocusMonitor = {},
    OneTimeMsg={},
    preloadOptions=1,
    dislikeMount={},
    excludeMount={},
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
		--Updated 5.3 by Ariá - Silvermoon EU 
		--World Bosses
		--Oondasta
		[HEALBOT_DEBUFF_CRUSH]             = 10, -- Oondasta    
		--Nalak, the Storm Lord
	    [HEALBOT_DEBUFF_LIGHTNING_TETHER]  = 10, -- Nalak, the Storm Lord      
	    [HEALBOT_DEBUFF_STORMCLOUD]        = 10, -- Nalak, the Storm Lord        
		--Throne of Thunder
		[HEALBOT_DEBUFF_WOUNDING_STRIKE]   = 10, -- Trash
		[HEALBOT_DEBUFF_STORM_ENERGY]      = 10, -- Trash
		[HEALBOT_DEBUFF_ANCIENT_VENOM]     = 10, -- Trash
		[HEALBOT_DEBUFF_TORMENT]           = 10, -- Trash
		[HEALBOT_DEBUFF_CRUSH_ARMOR]       = 10, -- Trash
		[HEALBOT_DEBUFF_STORMCLOUD]        = 10, -- Trash
		[HEALBOT_DEBUFF_SLASHING_TALONS]   = 10, -- Trash
		[HEALBOT_DEBUFF_SHALE_SHARDS]      = 10, -- Trash
		[HEALBOT_DEBUFF_CHOKING_MISTS]     = 10, -- Trash
		[HEALBOT_DEBUFF_CORROSIVE_BREATH]  = 10, -- Trash
		[HEALBOT_DEBUFF_COCOON]            = 10, -- Trash   
		[HEALBOT_DEBUFF_CHOKING_GAS]       = 10, -- Trash
		[HEALBOT_DEBUFF_GNAWED_UPON]       = 10, -- Trash
		[HEALBOT_DEBUFF_STATIC_WOUND]      = 10, -- Jin'rokh the Breaker
		[HEALBOT_DEBUFF_THUNDERING_THROW]  = 10, -- Jin'rokh the Breaker
		[HEALBOT_DEBUFF_FOCUSED_LIGHTNING] = 10, -- Jin'rokh the Breaker
		[HEALBOT_DEBUFF_TRIPLE_PUNCTURE]   = 10, -- Horridon
		[HEALBOT_DEBUFF_RENDING_CHARGE]    = 10, -- Horridon
        [HEALBOT_DEBUFF_FRIGID_ASSAULT]    = 10, -- Council of Elders 
		[HEALBOT_DEBUFF_FRIGID_ASSAULT]    = 10, -- Council of Elders
		[HEALBOT_DEBUFF_BITING_COLD]       = 10, -- Council of Elders    
		[HEALBOT_DEBUFF_FROSTBITE]         = 10, -- Council of Elders  
		[HEALBOT_DEBUFF_BODY_HEAT]         = 10, -- Council of Elders Heroic
		[HEALBOT_DEBUFF_MARKED_SOUL]       = 10, -- Council of Elders
		[HEALBOT_DEBUFF_SOUL_FRAGMENT]     = 10, -- Council of Elders Heroic
		[HEALBOT_DEBUFF_SHADOWED_SOUL]     = 10, -- Council of Elders Heroic
        [HEALBOT_DEBUFF_CRYSTAL_SHELL]     = 10, -- Tortos
		[HEALBOT_DEBUFF_CRYSTAL_SHELL_FULL_CAPACITY] = 10, -- Tortos 
		[HEALBOT_DEBUFF_IGNITE_FLESH]      = 10, -- Megaera  
		[HEALBOT_DEBUFF_ARCTIC_FREEZE]     = 10, -- Megaera  
		[HEALBOT_DEBUFF_ARCTIC_FREEZE]     = 10, -- Megaera 
		[HEALBOT_DEBUFF_ROT_ARMOR]         = 10, -- Megaera 
		[HEALBOT_DEBUFF_TORRENT_OF_ICE]    = 10, -- Megaera
        [HEALBOT_DEBUFF_ICY_GROUND]        = 10, -- Megaera  		
		[HEALBOT_DEBUFF_TALON_RAKE]        = 10, -- Ji-Kun
		[HEALBOT_DEBUFF_INFECTED_TALONS]   = 10, -- ji-Kun
		[HEALBOT_DEBUFF_FEED_POOL]         = 10, -- ji-Kun
		[HEALBOT_DEBUFF_SLIMED]            = 10, -- ji-Kun
		[HEALBOT_DEBUFF_DAEDALIAN_WINGS]   = 10, -- ji-Kun      
	    [HEALBOT_DEBUFF_LESSONS_OF_ICARUS] = 10, -- ji-Kun       
	    [HEALBOT_DEBUFF_FLIGHT]            = 10, -- ji-Kun       
		[HEALBOT_DEBUFF_PRIMAL_NUTRIMENT]  = 10, -- ji-Kun Buff
		[HEALBOT_DEBUFF_MALFORMED_BLOOD]   = 10, -- Primordius
		[HEALBOT_DEBUFF_VOLATILE_PATHOGEN] = 10, -- Primordius
		[HEALBOT_DEBUFF_CRIMSON_WAKE]      = 10, -- Dark Animus
		[HEALBOT_DEBUFF_EXPLOSIVE_SLAM]    = 10, -- Dark Animus
		[HEALBOT_DEBUFF_ANIMA_FONT]        = 10, -- Dark Animus
		[HEALBOT_DEBUFF_ANIMA_RING]        = 10, -- Dark Animus
		[HEALBOT_DEBUFF_TOUCH_OF_ANIMUS]   = 10, -- Dark Animus
		[HEALBOT_DEBUFF_IMPALE]            = 10, -- Iron Qon
		[HEALBOT_DEBUFF_SCORCHED]          = 10, -- Iron Qon
		[HEALBOT_DEBUFF_ARCING_LIGHTNING]  = 10, -- Iron Qon
		[HEALBOT_DEBUFF_FREEZE]            = 10, -- Iron Qon
		[HEALBOT_STORM_CLOUD]              = 10, -- Iron Qon
		[HEALBOT_DEAD_ZONE]                = 10, -- Iron Qon
		[HEALBOT_DEBUFF_SERIOUS_WOUND]     = 10, -- Durumu the Forgotten
		[HEALBOT_DEBUFF_ARTERIAL_CUT]      = 10, -- Durumu the Forgotten
		[HEALBOT_DEBUFF_LINGERING_GAZE]    = 10, -- Durumu the Forgotten
		[HEALBOT_DEBUFF_LINGERING_GAZE]    = 10, -- Durumu the Forgotten
		[HEALBOT_DEBUFF_LIFE_DRAIN]        = 10, -- Durumu the Forgotten
		[HEALBOT_DEBUFF_BLUE_RAY_TRACKING] = 10, -- Durumu the Forgotten       
	    [HEALBOT_DEBUFF_BLUE_RAYS]         = 10, -- Durumu the Forgotten       
	    [HEALBOT_DEBUFF_INFRARED_TRACKING] = 10, -- Durumu the Forgotten       
	    [HEALBOT_DEBUFF_INFRARED_LIGHT]    = 10, -- Durumu the Forgotten       
	    [HEALBOT_DEBUFF_BRIGHT_LIGHT]      = 10, -- Durumu the Forgotten       
		[HEALBOT_DEBUFF_FAN_OF_FLAMES]     = 10, -- Twin Consorts 
		[HEALBOT_DEBUFF_FLAMES_OF_PASSION] = 10, -- Twin Consorts
		[HEALBOT_DEBUFF_BEAST_OF_NIGHTMARES] = 10, -- Twin Consorts
		[HEALBOT_DEBUFF_BEAST_OF_NIGHTMARES] = 10, -- Twin Consorts
		[HEALBOT_DEBUFF_DECAPITATE]        = 10, -- Lei Shen 
   		[HEALBOT_DEBUFF_CRASHING_THUNDER]  = 10, -- Lei Shen
		[HEALBOT_DEBUFF_STATIC_SHOCK]      = 10, -- Lei Shen
		[HEALBOT_DEBUFF_OVERCHARGED]       = 10, -- Lei Shen
		[HEALBOT_DEBUFF_HELM_OF_COMMAND]   = 10, -- Lei Shen Heroic
		[HEALBOT_DEBUFF_DISCHARGED_ENERGY] = 10, -- Lei Shen
		[HEALBOT_DEBUFF_ELECTRICAL_SHOCK]  = 10, -- Lei Shen 
		[HEALBOT_DEBUFF_WINDBURN]          = 10, -- Lei Shen
		[HEALBOT_UNSTABLE_VITA]            = 10, -- Ra-Den
		[HEALBOT_VITA_SENSITIVITY]         = 10, -- Ra-Den
		--Updated 5.4 by Ariá - Silvermoon EU 
		--World Bosses
		--Ordos
		[HEALBOT_DEBUFF_BURNING_SOUL]      = 10, --Ordos            
	    [HEALBOT_DEBUFF_POOL_OF_FIRE]      = 10, --Ordos       
	    [HEALBOT_DEBUFF_ANCIENT_FLAME]     = 10, --Ordos        
		-- Siege of Orgrimmar
	    [HEALBOT_DEBUFF_LESSER_SHA_RESIDUE]= 10, -- Trash Buff
		[HEALBOT_DEBUFF_GROWING_OVERCONFIDENCE] = 10, -- Trash   
	    [HEALBOT_DEBUFF_JEALOUSY]          = 10, -- Trash                 
		[HEALBOT_DEBUFF_LOCKED_ON]         = 10, -- Trash 
		[HEALBOT_DEBUFF_RESONATING_AMBER]  = 10, -- Trash
		[HEALBOT_DEBUFF_CORROSIVE_BLAST]   = 10, -- Immerseus
		[HEALBOT_DEBUFF_SHA_SPLASH]        = 10, -- Immerseus
		[HEALBOT_DEBUFF_PURIFIED_RESIDUE]  = 10, -- Immerseus Buff      
	    [HEALBOT_DEBUFF_SHA_RESIDUE]       = 10, -- Immerseus Buff       
		[HEALBOT_DEBUFF_MEDITATIVE_FIELD]  = 10, -- The Fallen Protectors        
		[HEALBOT_DEBUFF_CORRUPTED_BREW]    = 10, -- The Fallen Protectors
		[HEALBOT_DEBUFF_DEFILED_GROUND]    = 10, -- The Fallen Protectors                  
	    [HEALBOT_DEBUFF_VENGEFUL_STRIKES]  = 10, -- The Fallen Protectors     
	    [HEALBOT_DEBUFF_CORRUPTION_KICK]   = 10, -- The Fallen Protectors    
	    [HEALBOT_DEBUFF_GARROTE]           = 10, -- The Fallen Protectors     
	    [HEALBOT_DEBUFF_GOUGE]             = 10, -- The Fallen Protectors    
	    [HEALBOT_DEBUFF_MARK_OF_ANGUISH]   = 10, -- The Fallen Protectors    
	    [HEALBOT_DEBUFF_SHADOWED_WEAKNESS] = 10, -- The Fallen Protectors    
	    [HEALBOT_DEBUFF_DEBILITATION]      = 10, -- The Fallen Protectors    
	    [HEALBOT_DEBUFF_SHA_SEAR]          = 10, -- The Fallen Protectors    
		[HEALBOT_DEBUFF_CORRUPTION]        = 10, -- Norushen   
		[HEALBOT_DEBUFF_SELF_DOUBT]        = 10, -- Norushen
		[HEALBOT_DEBUFF_ICY_FEAR]          = 10, -- Norushen     
		[HEALBOT_DEBUFF_BOTTOMLESS_PIT]    = 10, -- Norushen
		[HEALBOT_DEBUFF_DISHEARTENING_LAUGH] = 10, -- Norushen
		[HEALBOT_DEBUFF_PURIFIED]          = 10, -- Norushen
		[HEALBOT_DEBUFF_WOUNDED_PRIDE]     = 10, -- Sha of Pride
		[HEALBOT_DEBUFF_CORRUPTED_PRISON]  = 10, -- Sha of Pride
		[HEALBOT_DEBUFF_GIFT_OF_THE_TITANS] = 10, -- Sha of Pride Buff
		[HEALBOT_DEBUFF_POWER_OF_THE_TITANS] = 10, -- Sha of Pride Buff    
		[HEALBOT_DEBUFF_BANISHMENT]        = 10, -- Sha of Pride Heroic
        [HEALBOT_DEBUFF_WEAKENED_RESOLVE]  = 10, -- Sha of Pride Heroic 
	    [HEALBOT_DEBUFF_OVERCOME]          = 10, -- Sha of Pride              
	    [HEALBOT_DEBUFF_AURA_OF_PRIDE]     = 10, -- Sha of Pride        		
		[HEALBOT_DEBUFF_FRACTURE]          = 10, -- Galakras
		[HEALBOT_DEBUFF_FLAME_ARROWS]      = 10, -- Galakras
		[HEALBOT_DEBUFF_POISON_CLOUD]      = 10, -- Galakras
		[HEALBOT_DEBUFF_FLAMES_OF_GALAKROND] = 10, -- Galakras
		[HEALBOT_DEBUFF_LASER_BURN]        = 10, -- Iron Juggernaut
		[HEALBOT_DEBUFF_IGNITE_ARMOUR]     = 10, -- Iron Juggernaut
		[HEALBOT_DEBUFF_EXPLOSIVE_TAR]     = 10, -- Iron Juggernaut
		[HEALBOT_DEBUFF_CUTTER_LASER_TARGET] = 10, -- Iron Juggernaut
		[HEALBOT_DEBUFF_REND]              = 10, -- Kor'kron Dark Shaman
		[HEALBOT_DEBUFF_FROSTSTORM_STRIKE] = 10, -- Kor'kron Dark Shaman
		[HEALBOT_DEBUFF_TOXIC_MIST]        = 10, -- Kor'kron Dark Shaman
		[HEALBOT_DEBUFF_FOUL_GEYSER]       = 10, -- Kor'kron Dark Shaman
		[HEALBOT_DEBUFF_IRON_PRISON]       = 10, -- Kor'kron Dark Shaman Heroic
		[HEALBOT_DEBUFF_IRON_TOMB]         = 10, -- Kor'kron Dark Shaman Heroic
		[HEALBOT_DEBUFF_TOXICITY]          = 10, -- Kor'kron Dark Shaman
		[HEALBOT_DEBUFF_SUNDERING_BLOW]    = 10, -- General Nazgrim
		[HEALBOT_DEBUFF_BONECRACKER]       = 10, -- General Nazgrim
		[HEALBOT_DEBUFF_ASSASSINS_MARK]    = 10, -- General Nazgrim
		[HEALBOT_DEBUFF_HUNTERS_MARK]      = 10, -- General Nazgrim Heroic
		[HEALBOT_DEBUFF_FATAL_STRIKE]      = 10, -- Malkorok             
	    [HEALBOT_DEBUFF_LANGUISH]          = 10, -- Malkorok               
	    [HEALBOT_DEBUFF_ANCIENT_MIASMA]    = 10, -- Malkorok       
	    [HEALBOT_WEEK_ANCIENT_BARRIER]     = 10, -- Malkorok       
		[HEALBOT_ANCIENT_BARRIER]          = 10, -- Malkorok       
		[HEALBOT_STRONG_ANCIENT_BARRIER]   = 10, -- Malkorok     
		[HEALBOT_DEBUFF_SET_TO_BLOW]       = 10, -- Spoils of Pandaria
		[HEALBOT_DEBUFF_CARNIVOROUS_BITE]  = 10, -- Spoils of Pandaria
		[HEALBOT_DEBUFF_ENCAPSULATED_PHEROMONES] = 10, -- Spoils of Pandaria
	    [HEALBOT_DEBUFF_KEG_TOSS]          = 10, -- Spoils of Pandaria
        [HEALBOT_DEBUFF_GUSTING_BOMB]      = 10, -- Spoils of Pandaria
		[HEALBOT_DEBUFF_PANIC]             = 10, -- Thok the Bloodthirsty      
	    [HEALBOT_DEBUFF_TAIL_LASH]         = 10, -- Thok the Bloodthirsty     
	    [HEALBOT_DEBUFF_FIXATE]            = 10, -- Thok the Bloodthirsty     
	    [HEALBOT_DEBUFF_ACID_BREATH]       = 10, -- Thok the Bloodthirsty     
	    [HEALBOT_DEBUFF_FREEZING_BREATH]   = 10, -- Thok the Bloodthirsty     
	    [HEALBOT_DEBUFF_ICY_BLOOD]         = 10, -- Thok the Bloodthirsty     
	    [HEALBOT_DEBUFF_SCORCHING_BREATH]  = 10, -- Thok the Bloodthirsty    
	    [HEALBOT_DEBUFF_BURNING_BLOOD]     = 10, -- Thok the Bloodthirsty    
		[HEALBOT_DEBUFF_ELECTROSTATIC_CHARGE] = 10, --Siegecrafter Blackfuse
	    [HEALBOT_DEBUFF_OVERLOAD]          = 10, -- Siegecrafter Blackfuse           
	    [HEALBOT_DEBUFF_PATTERN_RECOGNITION] = 10, -- Siegecrafter Blackfuse  
	    [HEALBOT_DEBUFF_SUPERHEATED]       = 10, -- Siegecrafter Blackfuse          
	    [HEALBOT_DEBUFF_MAGNETIC_CRUSH]    = 10, -- Siegecrafter Blackfuse       
		[HEALBOT_DEBUFF_EXPOSED_VEINS]     = 10, -- Paragons of the Klaxxi 
		[HEALBOT_DEBUFF_GOUGE]             = 10, -- Paragons of the Klaxxi 
	    [HEALBOT_DEBUFF_CAUSTIC_BLOOD]     = 10, -- Paragons of the Klaxxi 
		[HEALBOT_DEBUFF_TENDERZING_STRIKES] = 10, -- Paragons of the Klaxxi 
		[HEALBOT_DEBUFF_MEZMERIZE]         = 10, -- Paragons of the Klaxxi 
		[HEALBOT_DEBUFF_SHIELD_BASH]       = 10, -- Paragons of the Klaxxi 
		[HEALBOT_DEBUFF_CAUSTIC_AMBER]     = 10, -- Paragons of the Klaxxi 
		[HEALBOT_DEBUFF_HEWN]              = 10, -- Paragons of the Klaxxi 
		[HEALBOT_DEBUFF_GENETIC_ALTERATION] = 10, -- Paragons of the Klaxxi
		[HEALBOT_DEBUFF_INJECTION]         = 10, -- Paragons of the Klaxxi 
		[HEALBOT_DEBUFF_AIM]               = 10, -- Paragons of the Klaxxi 
		[HEALBOT_DEBUFF_WHIRLING]          = 10, -- Paragons of the Klaxxi
        [HEALBOT_DEBUFF_HUNGER]            = 10, -- Paragons of the Klaxxi
        [HEALBOT_DEBUFF_FIERY_EDGE]        = 10, -- Paragons of the Klaxxi 		
		--Garrosh Hellscream
		[HEALBOT_DEBUFF_HAMSTRING]         = 10, -- Garrosh Hellscream
	    [HEALBOT_EMBODIED_DOUBT]           = 10, -- Garrosh Hellscream
	    [HEALBOT_DEBUFF_ULTIMATE_DESPAIR]  = 10, -- Garrosh Hellscream
        [HEALBOT_DEBUFF_WHIRLING_CORRUPTION] = 10, -- Garrosh Hellscream 
        [HEALBOT_DEBUFF_TOUCH_OF_YSHAARJ]  = 10, -- Garrosh Hellscream 
        [HEALBOT_DEBUFF_EMPOWERED_TOUCH_OF_YSHAARJ] = 10, -- Garrosh Hellscream 
        [HEALBOT_DEBUFF_GRIPPING_DESPAIR]  = 10, -- Garrosh Hellscream
        [HEALBOT_DEBUFF_EMPOWERED_GRIPPING_DESPAIR] = 10, -- Garrosh Hellscream 
        [HEALBOT_DEBUFF_EXPLOSIVE_DESPAIR] = 10, -- Garrosh Hellscream     		
        [HEALBOT_DEBUFF_MARK_OF_ARROGANCE] = 10, -- Sha of Pride
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
            [HEALBOT_SAVAGE_DEFENCE]=4,
        },
        ["HUNT"] = {
            [HEALBOT_MENDPET]=2,
            [HEALBOT_DETERRENCE]=4,
        }, 
        ["MAGE"] = {
            [HEALBOT_EVOCATION]=2,
            [HEALBOT_TEMPORAL_SHIELD]=4,
            [HEALBOT_ICE_BARRIER]=4,
            [HEALBOT_INCANTERS_WARD]=4,
            [HEALBOT_ICE_BLOCK]=4,
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
            [HEALBOT_ETERNAL_FLAME]=4,
            [HEALBOT_HOLY_SHIELD]=2,
            [HEALBOT_ILLUMINATED_HEALING]=2,
            [HEALBOT_ARDENT_DEFENDER]=2,
            [HEALBOT_DENOUNCE]=2,
            [HEALBOT_DIVINE_PROTECTION]=4,
        },
        ["PRIE"] = {
            [HEALBOT_GUARDIAN_SPIRIT]=3,
            [HEALBOT_HOLY_WORD_SERENITY]=2,
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
            [HEALBOT_TWIST_OF_FATE]=2,
            [HEALBOT_ANGELIC_BULWARK]=4,
            [HEALBOT_DISPERSION]=4,
        },
        ["ROGU"] = {
            [HEALBOT_VANISH]=4,
            [HEALBOT_FEINT]=4,
            [HEALBOT_CLOAK_OF_SHADOWS]=4,
        },
        ["SHAM"] = {
            [HEALBOT_RIPTIDE]=2,
            [HEALBOT_EARTH_SHIELD]=3,
            [HEALBOT_WATER_SHIELD]=2,
            [HEALBOT_LIGHTNING_SHIELD]=2,
            [HEALBOT_EARTHLIVING]=2,
            [HEALBOT_UNLEASHED_FURY]=2,
            [HEALBOT_TIDAL_WAVES]=2,
            [HEALBOT_ANACESTRAL_SWIFTNESS]=2,
            [HEALBOT_ANACESTRAL_VIGOR]=2,
            [HEALBOT_EMPOWER]=2,
            [HEALBOT_ANACESTRAL_GUIDANCE]=2,
            [HEALBOT_ASCENDANCE]=2,
            [HEALBOT_UNLEASH_LIFE]=2,
            [HEALBOT_UNLEASH_FLAME]=2,
            [HEALBOT_ASTRAL_SHIFT]=2,
            [HEALBOT_SHAMANISTIC_RAGE]=2,
            [HEALBOT_ELEMENTAL_MASTERY]=2,
            [HEALBOT_HEALING_RAIN]=2,
            [HEALBOT_SPIRITWALKERS_GRACE]=2,
        },
        ["WARL"] = {
            [HEALBOT_DARK_INTENT]=2,
            [HEALBOT_DARK_BARGAIN]=4,
            [HEALBOT_TWILIGHT_WARD]=4,
            [HEALBOT_UNENDING_RESOLVE]=4,
        }, 
        ["WARR"] = {
            [HEALBOT_VIGILANCE]=3,
            [HEALBOT_LAST_STAND]=4,
            [HEALBOT_SHIELD_WALL]=4,
            [HEALBOT_SHIELD_BLOCK]=2,
            [HEALBOT_SHIELD_BARRIER]=4,
            [HEALBOT_SAFEGUARD]=4,
        }, 
        ["DEAT"] = {
            [HEALBOT_ICEBOUND_FORTITUDE]=4,
            [HEALBOT_ANTIMAGIC_SHELL]=4,
            [HEALBOT_ARMY_OF_THE_DEAD]=2,
            [HEALBOT_LICHBORNE]=2,
            [HEALBOT_ANTIMAGIC_ZONE]=2,
            [HEALBOT_VAMPIRIC_BLOOD]=4,
            [HEALBOT_BONE_SHIELD]=4,
            [HEALBOT_DANCING_RUNE_WEAPON]=4,
			[HEALBOT_SHROUD_OF_PURGATORY]=4,
        },
        ["MONK"] = {
            [HEALBOT_VIGILANCE]=3,
            [HEALBOT_ENVELOPING_MIST]=3,
            [HEALBOT_ZEN_SPHERE]=2,
            [HEALBOT_LIFE_COCOON]=3,
            [HEALBOT_THUNDER_FOCUS_TEA]=2,
            [HEALBOT_SERPENT_ZEAL]=2,
            [HEALBOT_MANA_TEA]=2,
            [HEALBOT_ZEN_MEDITATION]=2,
            [HEALBOT_SOOTHING_MIST]=2,
            [HEALBOT_ALT_RENEWING_MIST]=3,
            [HEALBOT_ELUSIVE_BREW]=4,
            [HEALBOT_FORTIFYING_BREW]=4,
            [HEALBOT_DAMPEN_HARM]=4,
            [HEALBOT_DIFFUSE_MAGIC]=4,
            [HEALBOT_AVERT_HARM]=4,
            [HEALBOT_GUARD]=4,
        },
        ["ALL"] = {
            [HEALBOT_GIFT_OF_THE_NAARU]=1,
            [HEALBOT_GUARDIAN_ANCIENT_KINGS]=2,
        },
    },
};

local defaultAuthor = "Monti of Terenas"
HealBot_Config_SkinsDefaults = {
  Skin_ID = 1,
  Current_Skin = HEALBOT_SKINS_STD,
  Skins = {HEALBOT_SKINS_STD, HEALBOT_OPTIONS_GROUPHEALS, HEALBOT_OPTIONS_EMERGENCYHEALS, HEALBOT_ZONE_AV},
  Author = {[HEALBOT_SKINS_STD] = defaultAuthor, [HEALBOT_OPTIONS_GROUPHEALS] = defaultAuthor, 
              [HEALBOT_OPTIONS_EMERGENCYHEALS] = defaultAuthor, [HEALBOT_ZONE_AV] = defaultAuthor,},
  EmergIncMonitor = {[HEALBOT_SKINS_STD] = 1, [HEALBOT_OPTIONS_GROUPHEALS] = 1, [HEALBOT_OPTIONS_EMERGENCYHEALS] = 1, [HEALBOT_ZONE_AV] = 1,},
  ExtraIncGroup = {[HEALBOT_SKINS_STD] = {[1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true},
                   [HEALBOT_OPTIONS_GROUPHEALS] = {[1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true},
                   [HEALBOT_OPTIONS_EMERGENCYHEALS] = {[1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true},
                   [HEALBOT_ZONE_AV] = {[1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true},
                  },
  Chat =    {[HEALBOT_SKINS_STD]               = {["NOTIFY"]=1,["CHAN"]="",["MSG"]=HEALBOT_NOTIFYOTHERMSG,["RESONLY"]=1},
             [HEALBOT_OPTIONS_GROUPHEALS]      = {["NOTIFY"]=1,["CHAN"]="",["MSG"]=HEALBOT_NOTIFYOTHERMSG,["RESONLY"]=1},
             [HEALBOT_OPTIONS_EMERGENCYHEALS]  = {["NOTIFY"]=1,["CHAN"]="",["MSG"]=HEALBOT_NOTIFYOTHERMSG,["RESONLY"]=1},
             [HEALBOT_ZONE_AV]                 = {["NOTIFY"]=1,["CHAN"]="",["MSG"]=HEALBOT_NOTIFYOTHERMSG,["RESONLY"]=1},},
  Sort =    {[HEALBOT_SKINS_STD]               = {["RAIDORDER"]=3,["SUBORDER"]=5,["SUBIG"]=1,["SUBIP"]=1,["SUBIV"]=1,["SUBIT"]=1,["SUBIMT"]=0,["SUBPF"]=1},
             [HEALBOT_OPTIONS_GROUPHEALS]      = {["RAIDORDER"]=3,["SUBORDER"]=5,["SUBIG"]=1,["SUBIP"]=1,["SUBIV"]=1,["SUBIT"]=1,["SUBIMT"]=0,["SUBPF"]=1},
             [HEALBOT_OPTIONS_EMERGENCYHEALS]  = {["RAIDORDER"]=3,["SUBORDER"]=1,["SUBIG"]=1,["SUBIP"]=1,["SUBIV"]=1,["SUBIT"]=1,["SUBIMT"]=0,["SUBPF"]=1},
             [HEALBOT_ZONE_AV]                 = {["RAIDORDER"]=3,["SUBORDER"]=1,["SUBIG"]=1,["SUBIP"]=1,["SUBIV"]=1,["SUBIT"]=1,["SUBIMT"]=0,["SUBPF"]=1},},
  General = {[HEALBOT_SKINS_STD]               = {["HIDEPARTYF"]=0,["HIDEPTF"]=0,["HIDEBOSSF"]=0,["HIDERAIDF"]=1,["FLUIDBARS"]=0,["FLUIDFREQ"]=3,["LOWMANA"]=2,["LOWMANACOMBAT"]=1},
             [HEALBOT_OPTIONS_GROUPHEALS]      = {["HIDEPARTYF"]=0,["HIDEPTF"]=0,["HIDEBOSSF"]=0,["HIDERAIDF"]=1,["FLUIDBARS"]=1,["FLUIDFREQ"]=3,["LOWMANA"]=3,["LOWMANACOMBAT"]=1},
             [HEALBOT_OPTIONS_EMERGENCYHEALS]  = {["HIDEPARTYF"]=0,["HIDEPTF"]=0,["HIDEBOSSF"]=0,["HIDERAIDF"]=1,["FLUIDBARS"]=0,["FLUIDFREQ"]=3,["LOWMANA"]=2,["LOWMANACOMBAT"]=1},
             [HEALBOT_ZONE_AV]                 = {["HIDEPARTYF"]=0,["HIDEPTF"]=0,["HIDEBOSSF"]=0,["HIDERAIDF"]=1,["FLUIDBARS"]=0,["FLUIDFREQ"]=3,["LOWMANA"]=1,["LOWMANACOMBAT"]=1},},
  Healing = {[HEALBOT_SKINS_STD]               = {["ALERTIC"]=1,["ALERTOC"]=0.95,["GROUPPETS"]=1,["SELFPET"]=0,["TINCSELF"]=0,["TINCGROUP"]=1,["TINCRAID"]=1,
                                                  ["TINCPET"]=0,["TALWAYSSHOW"]=0,["FALWAYSSHOW"]=0,["TONLYFRIEND"]=0,["FONLYFRIEND"]=0},
             [HEALBOT_OPTIONS_GROUPHEALS]      = {["ALERTIC"]=1,["ALERTOC"]=0.95,["GROUPPETS"]=1,["SELFPET"]=0,["TINCSELF"]=0,["TINCGROUP"]=1,["TINCRAID"]=1,
                                                  ["TINCPET"]=0,["TALWAYSSHOW"]=0,["FALWAYSSHOW"]=0,["TONLYFRIEND"]=0,["FONLYFRIEND"]=0},
             [HEALBOT_OPTIONS_EMERGENCYHEALS]  = {["ALERTIC"]=0.98,["ALERTOC"]=0.9,["GROUPPETS"]=1,["SELFPET"]=0,["TINCSELF"]=0,["TINCGROUP"]=1,["TINCRAID"]=1,
                                                  ["TINCPET"]=0,["TALWAYSSHOW"]=0,["FALWAYSSHOW"]=0,["TONLYFRIEND"]=0,["FONLYFRIEND"]=0},
             [HEALBOT_ZONE_AV]                 = {["ALERTIC"]=0.95,["ALERTOC"]=0.8,["GROUPPETS"]=1,["SELFPET"]=0,["TINCSELF"]=0,["TINCGROUP"]=1,["TINCRAID"]=1,
                                                  ["TINCPET"]=0,["TALWAYSSHOW"]=0,["FALWAYSSHOW"]=0,["TONLYFRIEND"]=0,["FONLYFRIEND"]=0},},
  Highlight = {[HEALBOT_SKINS_STD]               = {["CBAR"]=1,["CBARCOMBAT"]=0,["TBAR"]=0,["TBARCOMBAT"]=0,["CR"]=1,["CG"]=1,["CB"]=0.7,["TR"]=0.8,["TG"]=0.8,["TB"]=0.7},
               [HEALBOT_OPTIONS_GROUPHEALS]      = {["CBAR"]=1,["CBARCOMBAT"]=0,["TBAR"]=0,["TBARCOMBAT"]=0,["CR"]=1,["CG"]=1,["CB"]=0.7,["TR"]=0.8,["TG"]=0.8,["TB"]=0.7},
               [HEALBOT_OPTIONS_EMERGENCYHEALS]  = {["CBAR"]=1,["CBARCOMBAT"]=0,["TBAR"]=0,["TBARCOMBAT"]=0,["CR"]=1,["CG"]=1,["CB"]=0.7,["TR"]=0.8,["TG"]=0.8,["TB"]=0.7},
               [HEALBOT_ZONE_AV]                 = {["CBAR"]=1,["CBARCOMBAT"]=0,["TBAR"]=0,["TBARCOMBAT"]=0,["CR"]=1,["CG"]=1,["CB"]=0.7,["TR"]=0.8,["TG"]=0.8,["TB"]=0.7},},
  Aggro = {[HEALBOT_SKINS_STD]                   = {["ALERT"]=3,["ALERTIND"]=2,["R"]=1,["G"]=0,["B"]=0,["MAXA"]=1,["MINA"]=0.2,["FREQ"]=0.03,["SHOW"]=1,["SHOWIND"]=1,
                                                    ["SHOWBARS"]=1,["SHOWTEXT"]=0,["SHOWBARSPCT"]=0,["SHOWTEXTPCT"]=1,["TEXTFORMAT"]=3},
           [HEALBOT_OPTIONS_GROUPHEALS]          = {["ALERT"]=3,["ALERTIND"]=2,["R"]=1,["G"]=0,["B"]=0,["MAXA"]=1,["MINA"]=0.2,["FREQ"]=0.03,["SHOW"]=1,["SHOWIND"]=1,
                                                    ["SHOWBARS"]=1,["SHOWTEXT"]=0,["SHOWBARSPCT"]=0,["SHOWTEXTPCT"]=1,["TEXTFORMAT"]=3},
           [HEALBOT_OPTIONS_EMERGENCYHEALS]      = {["ALERT"]=3,["ALERTIND"]=2,["R"]=1,["G"]=0,["B"]=0,["MAXA"]=1,["MINA"]=0.2,["FREQ"]=0.03,["SHOW"]=1,["SHOWIND"]=1,
                                                    ["SHOWBARS"]=1,["SHOWTEXT"]=0,["SHOWBARSPCT"]=0,["SHOWTEXTPCT"]=1,["TEXTFORMAT"]=3},  
           [HEALBOT_ZONE_AV]                     = {["ALERT"]=3,["ALERTIND"]=2,["R"]=1,["G"]=0,["B"]=0,["MAXA"]=1,["MINA"]=0.2,["FREQ"]=0.03,["SHOW"]=1,["SHOWIND"]=1,
                                                    ["SHOWBARS"]=1,["SHOWTEXT"]=0,["SHOWBARSPCT"]=0,["SHOWTEXTPCT"]=1,["TEXTFORMAT"]=3},},                                         
  Protection = {[HEALBOT_SKINS_STD]              = {["CRASH"]=0,["COMBAT"]=0,["COMBATPARTY"]=1,["COMBATRAID"]=2},
                [HEALBOT_OPTIONS_GROUPHEALS]     = {["CRASH"]=0,["COMBAT"]=0,["COMBATPARTY"]=1,["COMBATRAID"]=2},
                [HEALBOT_OPTIONS_EMERGENCYHEALS] = {["CRASH"]=0,["COMBAT"]=0,["COMBATPARTY"]=1,["COMBATRAID"]=2},
                [HEALBOT_ZONE_AV]                = {["CRASH"]=0,["COMBAT"]=0,["COMBATPARTY"]=1,["COMBATRAID"]=2},},
  BarsHide = {[HEALBOT_SKINS_STD]                = {["STATE"]=0,["INCTANK"]=0,["INCGROUP"]=0,["INCFOCUS"]=0,["INCMYTARGETS"]=0},
              [HEALBOT_OPTIONS_GROUPHEALS]       = {["STATE"]=0,["INCTANK"]=0,["INCGROUP"]=0,["INCFOCUS"]=0,["INCMYTARGETS"]=0},
              [HEALBOT_OPTIONS_EMERGENCYHEALS]   = {["STATE"]=0,["INCTANK"]=0,["INCGROUP"]=0,["INCFOCUS"]=0,["INCMYTARGETS"]=0},
              [HEALBOT_ZONE_AV]                  = {["STATE"]=1,["INCTANK"]=0,["INCGROUP"]=1,["INCFOCUS"]=0,["INCMYTARGETS"]=0},},
  FrameAlias = {[HEALBOT_SKINS_STD]              = {[1] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [2] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [3] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [4] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [5] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [6] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [7] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [8] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [9] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [10] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},},
                [HEALBOT_OPTIONS_GROUPHEALS]     = {[1] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [2] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [3] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [4] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [5] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [6] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [7] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [8] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [9] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [10] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},},
                [HEALBOT_OPTIONS_EMERGENCYHEALS] = {[1] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [2] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [3] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [4] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [5] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [6] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [7] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [8] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [9] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [10] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},},
                [HEALBOT_ZONE_AV]                = {[1] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [2] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [3] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [4] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [5] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [6] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [7] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [8] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [9] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},
                                                    [10] = {["NAME"]="",["SHOW"]=0,["FONT"]=HealBot_Default_Font,["SIZE"]=12,["OUTLINE"]=1,["OFFSET"]=10,["R"]=1,["G"]=1,["B"]=1,["A"]=1},},
                },
  Frame = {[HEALBOT_SKINS_STD]               = {[1] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.1,["BACKG"]=0.1,
                                                       ["BACKB"]=0.1,["BACKA"]=0.05,["BORDERR"]=0.2,["BORDERG"]=0.2,["BORDERB"]=0.2,["BORDERA"]=0.2},
                                                [2] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.1,["BACKG"]=0.1,
                                                       ["BACKB"]=0.1,["BACKA"]=0.05,["BORDERR"]=0.2,["BORDERG"]=0.2,["BORDERB"]=0.2,["BORDERA"]=0.2},
                                                [3] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.1,["BACKG"]=0.1,
                                                       ["BACKB"]=0.1,["BACKA"]=0.05,["BORDERR"]=0.2,["BORDERG"]=0.2,["BORDERB"]=0.2,["BORDERA"]=0.2},
                                                [4] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.1,["BACKG"]=0.1,
                                                       ["BACKB"]=0.1,["BACKA"]=0.05,["BORDERR"]=0.2,["BORDERG"]=0.2,["BORDERB"]=0.2,["BORDERA"]=0.2},
                                                [5] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.1,["BACKG"]=0.1,
                                                       ["BACKB"]=0.1,["BACKA"]=0.05,["BORDERR"]=0.2,["BORDERG"]=0.2,["BORDERB"]=0.2,["BORDERA"]=0.2},
                                                [6] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.1,["BACKG"]=0.1,
                                                       ["BACKB"]=0.1,["BACKA"]=0.05,["BORDERR"]=0.2,["BORDERG"]=0.2,["BORDERB"]=0.2,["BORDERA"]=0.2},
                                                [7] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.1,["BACKG"]=0.1,
                                                       ["BACKB"]=0.1,["BACKA"]=0.05,["BORDERR"]=0.2,["BORDERG"]=0.2,["BORDERB"]=0.2,["BORDERA"]=0.2},
                                                [8] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.1,["BACKG"]=0.1,
                                                       ["BACKB"]=0.1,["BACKA"]=0.05,["BORDERR"]=0.2,["BORDERG"]=0.2,["BORDERB"]=0.2,["BORDERA"]=0.2},
                                                [9] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.1,["BACKG"]=0.1,
                                                       ["BACKB"]=0.1,["BACKA"]=0.05,["BORDERR"]=0.2,["BORDERG"]=0.2,["BORDERB"]=0.2,["BORDERA"]=0.2},
                                               [10] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.1,["BACKG"]=0.1,
                                                       ["BACKB"]=0.1,["BACKA"]=0.05,["BORDERR"]=0.2,["BORDERG"]=0.2,["BORDERB"]=0.2,["BORDERA"]=0.2},},
           [HEALBOT_OPTIONS_GROUPHEALS]      = {[1] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.1,["BACKG"]=0.1,
                                                       ["BACKB"]=0.5,["BACKA"]=0.2,["BORDERR"]=0.1,["BORDERG"]=0.1,["BORDERB"]=0.1,["BORDERA"]=0.5},
                                                [2] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.1,["BACKG"]=0.1,
                                                       ["BACKB"]=0.5,["BACKA"]=0.2,["BORDERR"]=0.1,["BORDERG"]=0.1,["BORDERB"]=0.1,["BORDERA"]=0.5},
                                                [3] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.1,["BACKG"]=0.1,
                                                       ["BACKB"]=0.5,["BACKA"]=0.2,["BORDERR"]=0.1,["BORDERG"]=0.1,["BORDERB"]=0.1,["BORDERA"]=0.5},
                                                [4] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.1,["BACKG"]=0.1,
                                                       ["BACKB"]=0.5,["BACKA"]=0.2,["BORDERR"]=0.1,["BORDERG"]=0.1,["BORDERB"]=0.1,["BORDERA"]=0.5},
                                                [5] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.1,["BACKG"]=0.1,
                                                       ["BACKB"]=0.5,["BACKA"]=0.2,["BORDERR"]=0.1,["BORDERG"]=0.1,["BORDERB"]=0.1,["BORDERA"]=0.5},
                                                [6] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.1,["BACKG"]=0.1,
                                                       ["BACKB"]=0.5,["BACKA"]=0.2,["BORDERR"]=0.1,["BORDERG"]=0.1,["BORDERB"]=0.1,["BORDERA"]=0.5},
                                                [7] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.1,["BACKG"]=0.1,
                                                       ["BACKB"]=0.5,["BACKA"]=0.2,["BORDERR"]=0.1,["BORDERG"]=0.1,["BORDERB"]=0.1,["BORDERA"]=0.5},
                                                [8] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.1,["BACKG"]=0.1,
                                                       ["BACKB"]=0.5,["BACKA"]=0.2,["BORDERR"]=0.1,["BORDERG"]=0.1,["BORDERB"]=0.1,["BORDERA"]=0.5},
                                                [9] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.1,["BACKG"]=0.1,
                                                       ["BACKB"]=0.5,["BACKA"]=0.2,["BORDERR"]=0.1,["BORDERG"]=0.1,["BORDERB"]=0.1,["BORDERA"]=0.5},
                                               [10] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.1,["BACKG"]=0.1,
                                                       ["BACKB"]=0.5,["BACKA"]=0.2,["BORDERR"]=0.1,["BORDERG"]=0.1,["BORDERB"]=0.1,["BORDERA"]=0.5},},
           [HEALBOT_OPTIONS_EMERGENCYHEALS]  = {[1] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.1,["BACKG"]=0.1,
                                                       ["BACKB"]=0.7,["BACKA"]=0.1,["BORDERR"]=0.1,["BORDERG"]=0.1,["BORDERB"]=0.1,["BORDERA"]=0.04},
                                                [2] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.1,["BACKG"]=0.1,
                                                       ["BACKB"]=0.7,["BACKA"]=0.1,["BORDERR"]=0.1,["BORDERG"]=0.1,["BORDERB"]=0.1,["BORDERA"]=0.04},
                                                [3] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.1,["BACKG"]=0.1,
                                                       ["BACKB"]=0.7,["BACKA"]=0.1,["BORDERR"]=0.1,["BORDERG"]=0.1,["BORDERB"]=0.1,["BORDERA"]=0.04},
                                                [4] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.1,["BACKG"]=0.1,
                                                       ["BACKB"]=0.7,["BACKA"]=0.1,["BORDERR"]=0.1,["BORDERG"]=0.1,["BORDERB"]=0.1,["BORDERA"]=0.04},
                                                [5] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.1,["BACKG"]=0.1,
                                                       ["BACKB"]=0.7,["BACKA"]=0.1,["BORDERR"]=0.1,["BORDERG"]=0.1,["BORDERB"]=0.1,["BORDERA"]=0.04},
                                                [6] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.1,["BACKG"]=0.1,
                                                       ["BACKB"]=0.7,["BACKA"]=0.1,["BORDERR"]=0.1,["BORDERG"]=0.1,["BORDERB"]=0.1,["BORDERA"]=0.04},
                                                [7] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.1,["BACKG"]=0.1,
                                                       ["BACKB"]=0.7,["BACKA"]=0.1,["BORDERR"]=0.1,["BORDERG"]=0.1,["BORDERB"]=0.1,["BORDERA"]=0.04},
                                                [8] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.1,["BACKG"]=0.1,
                                                       ["BACKB"]=0.7,["BACKA"]=0.1,["BORDERR"]=0.1,["BORDERG"]=0.1,["BORDERB"]=0.1,["BORDERA"]=0.04},
                                                [9] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.1,["BACKG"]=0.1,
                                                       ["BACKB"]=0.7,["BACKA"]=0.1,["BORDERR"]=0.1,["BORDERG"]=0.1,["BORDERB"]=0.1,["BORDERA"]=0.04},
                                               [10] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.1,["BACKG"]=0.1,
                                                       ["BACKB"]=0.7,["BACKA"]=0.1,["BORDERR"]=0.1,["BORDERG"]=0.1,["BORDERB"]=0.1,["BORDERA"]=0.04},},
           [HEALBOT_ZONE_AV]                 = {[1] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.2,["BACKG"]=0.2,
                                                       ["BACKB"]=0.2,["BACKA"]=0.1,["BORDERR"]=0.2,["BORDERG"]=0.2,["BORDERB"]=0.2,["BORDERA"]=0.5},
                                                [2] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.2,["BACKG"]=0.2,
                                                       ["BACKB"]=0.2,["BACKA"]=0.1,["BORDERR"]=0.2,["BORDERG"]=0.2,["BORDERB"]=0.2,["BORDERA"]=0.5},
                                                [3] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.2,["BACKG"]=0.2,
                                                       ["BACKB"]=0.2,["BACKA"]=0.1,["BORDERR"]=0.2,["BORDERG"]=0.2,["BORDERB"]=0.2,["BORDERA"]=0.5},
                                                [4] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.2,["BACKG"]=0.2,
                                                       ["BACKB"]=0.2,["BACKA"]=0.1,["BORDERR"]=0.2,["BORDERG"]=0.2,["BORDERB"]=0.2,["BORDERA"]=0.5},
                                                [5] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.2,["BACKG"]=0.2,
                                                       ["BACKB"]=0.2,["BACKA"]=0.1,["BORDERR"]=0.2,["BORDERG"]=0.2,["BORDERB"]=0.2,["BORDERA"]=0.5},
                                                [6] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.2,["BACKG"]=0.2,
                                                       ["BACKB"]=0.2,["BACKA"]=0.1,["BORDERR"]=0.2,["BORDERG"]=0.2,["BORDERB"]=0.2,["BORDERA"]=0.5},
                                                [7] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.2,["BACKG"]=0.2,
                                                       ["BACKB"]=0.2,["BACKA"]=0.1,["BORDERR"]=0.2,["BORDERG"]=0.2,["BORDERB"]=0.2,["BORDERA"]=0.5},
                                                [8] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.2,["BACKG"]=0.2,
                                                       ["BACKB"]=0.2,["BACKA"]=0.1,["BORDERR"]=0.2,["BORDERG"]=0.2,["BORDERB"]=0.2,["BORDERA"]=0.5},
                                                [9] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.2,["BACKG"]=0.2,
                                                       ["BACKB"]=0.2,["BACKA"]=0.1,["BORDERR"]=0.2,["BORDERG"]=0.2,["BORDERB"]=0.2,["BORDERA"]=0.5},
                                               [10] = {["TIPLOC"]=5,["AUTOCLOSE"]=0,["OPENSOUND"]=0,["LOCKED"]=0,["SCALE"]=1,["BACKR"]=0.2,["BACKG"]=0.2,
                                                       ["BACKB"]=0.2,["BACKA"]=0.1,["BORDERR"]=0.2,["BORDERG"]=0.2,["BORDERB"]=0.2,["BORDERA"]=0.5},},
           },
  HealGroups = {[HEALBOT_SKINS_STD]              = {[1] = {["NAME"]=HEALBOT_OPTIONS_SELFHEALS_en,["STATE"]=0,["FRAME"]=1}, 
                                                    [2] = {["NAME"]=HEALBOT_OPTIONS_TANKHEALS_en,["STATE"]=1,["FRAME"]=1},
                                                    [3] = {["NAME"]=HEALBOT_CLASSES_HEALERS_en,["STATE"]=0,["FRAME"]=1}, 
                                                    [4] = {["NAME"]=HEALBOT_OPTIONS_GROUPHEALS_en,["STATE"]=1,["FRAME"]=1}, 
                                                    [5] = {["NAME"]=HEALBOT_OPTIONS_MYTARGET_en,["STATE"]=1,["FRAME"]=1}, 
                                                    [6] = {["NAME"]=HEALBOT_FOCUS_en,["STATE"]=0,["FRAME"]=1}, 
                                                    [7] = {["NAME"]=HEALBOT_OPTIONS_EMERGENCYHEALS_en,["STATE"]=1,["FRAME"]=1}, 
                                                    [8] = {["NAME"]=HEALBOT_OPTIONS_PETHEALS_en,["STATE"]=0,["FRAME"]=1},
                                                    [9] = {["NAME"]=HEALBOT_VEHICLE_en,["STATE"]=0,["FRAME"]=1},
                                                   [10] = {["NAME"]=HEALBOT_OPTIONS_TARGETHEALS_en,["STATE"]=1,["FRAME"]=1},
                                                   [11] = {["NAME"]=HEALBOT_CUSTOM_CASTBY_ENEMY_en,["STATE"]=0,["FRAME"]=5}},
                [HEALBOT_OPTIONS_GROUPHEALS]     = {[1] = {["NAME"]=HEALBOT_OPTIONS_SELFHEALS_en,["STATE"]=0,["FRAME"]=1}, 
                                                    [2] = {["NAME"]=HEALBOT_OPTIONS_TANKHEALS_en,["STATE"]=1,["FRAME"]=1},
                                                    [3] = {["NAME"]=HEALBOT_CLASSES_HEALERS_en,["STATE"]=0,["FRAME"]=1}, 
                                                    [4] = {["NAME"]=HEALBOT_OPTIONS_GROUPHEALS_en,["STATE"]=1,["FRAME"]=1}, 
                                                    [5] = {["NAME"]=HEALBOT_OPTIONS_MYTARGET_en,["STATE"]=1,["FRAME"]=1}, 
                                                    [6] = {["NAME"]=HEALBOT_FOCUS_en,["STATE"]=0,["FRAME"]=1}, 
                                                    [7] = {["NAME"]=HEALBOT_OPTIONS_EMERGENCYHEALS_en,["STATE"]=0,["FRAME"]=1}, 
                                                    [8] = {["NAME"]=HEALBOT_OPTIONS_PETHEALS_en,["STATE"]=1,["FRAME"]=1},
                                                    [9] = {["NAME"]=HEALBOT_VEHICLE_en,["STATE"]=0,["FRAME"]=1},
                                                   [10] = {["NAME"]=HEALBOT_OPTIONS_TARGETHEALS_en,["STATE"]=1,["FRAME"]=1},
                                                   [11] = {["NAME"]=HEALBOT_CUSTOM_CASTBY_ENEMY_en,["STATE"]=0,["FRAME"]=5}},
                [HEALBOT_OPTIONS_EMERGENCYHEALS] = {[1] = {["NAME"]=HEALBOT_OPTIONS_SELFHEALS_en,["STATE"]=0,["FRAME"]=1}, 
                                                    [2] = {["NAME"]=HEALBOT_OPTIONS_TANKHEALS_en,["STATE"]=1,["FRAME"]=1},
                                                    [3] = {["NAME"]=HEALBOT_CLASSES_HEALERS_en,["STATE"]=1,["FRAME"]=1}, 
                                                    [4] = {["NAME"]=HEALBOT_OPTIONS_GROUPHEALS_en,["STATE"]=1,["FRAME"]=2}, 
                                                    [5] = {["NAME"]=HEALBOT_OPTIONS_MYTARGET_en,["STATE"]=1,["FRAME"]=1}, 
                                                    [6] = {["NAME"]=HEALBOT_FOCUS_en,["STATE"]=1,["FRAME"]=1}, 
                                                    [7] = {["NAME"]=HEALBOT_OPTIONS_EMERGENCYHEALS_en,["STATE"]=1,["FRAME"]=2}, 
                                                    [8] = {["NAME"]=HEALBOT_OPTIONS_PETHEALS_en,["STATE"]=0,["FRAME"]=2},
                                                    [9] = {["NAME"]=HEALBOT_VEHICLE_en,["STATE"]=0,["FRAME"]=1},
                                                   [10] = {["NAME"]=HEALBOT_OPTIONS_TARGETHEALS_en,["STATE"]=1,["FRAME"]=1},
                                                   [11] = {["NAME"]=HEALBOT_CUSTOM_CASTBY_ENEMY_en,["STATE"]=0,["FRAME"]=5}},
                [HEALBOT_ZONE_AV]                = {[1] = {["NAME"]=HEALBOT_OPTIONS_SELFHEALS_en,["STATE"]=1,["FRAME"]=1}, 
                                                    [2] = {["NAME"]=HEALBOT_OPTIONS_TANKHEALS_en,["STATE"]=1,["FRAME"]=1},
                                                    [3] = {["NAME"]=HEALBOT_CLASSES_HEALERS_en,["STATE"]=1,["FRAME"]=1}, 
                                                    [4] = {["NAME"]=HEALBOT_OPTIONS_GROUPHEALS_en,["STATE"]=1,["FRAME"]=1}, 
                                                    [5] = {["NAME"]=HEALBOT_OPTIONS_MYTARGET_en,["STATE"]=1,["FRAME"]=1}, 
                                                    [6] = {["NAME"]=HEALBOT_FOCUS_en,["STATE"]=1,["FRAME"]=1}, 
                                                    [7] = {["NAME"]=HEALBOT_OPTIONS_EMERGENCYHEALS_en,["STATE"]=1,["FRAME"]=1}, 
                                                    [8] = {["NAME"]=HEALBOT_OPTIONS_PETHEALS_en,["STATE"]=0,["FRAME"]=1},
                                                    [9] = {["NAME"]=HEALBOT_VEHICLE_en,["STATE"]=0,["FRAME"]=1},
                                                   [10] = {["NAME"]=HEALBOT_OPTIONS_TARGETHEALS_en,["STATE"]=0,["FRAME"]=1},
                                                   [11] = {["NAME"]=HEALBOT_CUSTOM_CASTBY_ENEMY_en,["STATE"]=0,["FRAME"]=5}},
            },
  Anchors = {[HEALBOT_SKINS_STD]                 = {[1] = {["FRAME"]=3,["BARS"]=3,["GROW"]=2,["X"]=50,["Y"]=50}, 
                                                    [2] = {["FRAME"]=3,["BARS"]=3,["GROW"]=2,["X"]=51,["Y"]=51}, 
                                                    [3] = {["FRAME"]=3,["BARS"]=3,["GROW"]=2,["X"]=52,["Y"]=52}, 
                                                    [4] = {["FRAME"]=3,["BARS"]=3,["GROW"]=2,["X"]=53,["Y"]=53}, 
                                                    [5] = {["FRAME"]=3,["BARS"]=3,["GROW"]=2,["X"]=54,["Y"]=54}, 
                                                    [6] = {["FRAME"]=3,["BARS"]=3,["GROW"]=2,["X"]=55,["Y"]=55}, 
                                                    [7] = {["FRAME"]=3,["BARS"]=3,["GROW"]=2,["X"]=56,["Y"]=56}, 
                                                    [8] = {["FRAME"]=3,["BARS"]=3,["GROW"]=2,["X"]=57,["Y"]=57}, 
                                                    [9] = {["FRAME"]=3,["BARS"]=3,["GROW"]=2,["X"]=58,["Y"]=58}, 
                                                   [10] = {["FRAME"]=3,["BARS"]=3,["GROW"]=2,["X"]=59,["Y"]=59},},
                [HEALBOT_OPTIONS_GROUPHEALS]     = {[1] = {["FRAME"]=1,["BARS"]=1,["GROW"]=2,["X"]=50,["Y"]=50}, 
                                                    [2] = {["FRAME"]=1,["BARS"]=1,["GROW"]=2,["X"]=51,["Y"]=51}, 
                                                    [3] = {["FRAME"]=1,["BARS"]=1,["GROW"]=2,["X"]=52,["Y"]=52}, 
                                                    [4] = {["FRAME"]=1,["BARS"]=1,["GROW"]=2,["X"]=53,["Y"]=53}, 
                                                    [5] = {["FRAME"]=1,["BARS"]=1,["GROW"]=2,["X"]=54,["Y"]=54}, 
                                                    [6] = {["FRAME"]=1,["BARS"]=1,["GROW"]=2,["X"]=55,["Y"]=55}, 
                                                    [7] = {["FRAME"]=1,["BARS"]=1,["GROW"]=2,["X"]=56,["Y"]=56}, 
                                                    [8] = {["FRAME"]=1,["BARS"]=1,["GROW"]=2,["X"]=57,["Y"]=57}, 
                                                    [9] = {["FRAME"]=1,["BARS"]=1,["GROW"]=2,["X"]=58,["Y"]=58}, 
                                                   [10] = {["FRAME"]=1,["BARS"]=1,["GROW"]=2,["X"]=59,["Y"]=59},},
                [HEALBOT_OPTIONS_EMERGENCYHEALS] = {[1] = {["FRAME"]=1,["BARS"]=1,["GROW"]=2,["X"]=50,["Y"]=50}, 
                                                    [2] = {["FRAME"]=1,["BARS"]=1,["GROW"]=2,["X"]=51,["Y"]=51}, 
                                                    [3] = {["FRAME"]=1,["BARS"]=1,["GROW"]=2,["X"]=52,["Y"]=52}, 
                                                    [4] = {["FRAME"]=1,["BARS"]=1,["GROW"]=2,["X"]=53,["Y"]=53}, 
                                                    [5] = {["FRAME"]=1,["BARS"]=1,["GROW"]=2,["X"]=54,["Y"]=54}, 
                                                    [6] = {["FRAME"]=1,["BARS"]=1,["GROW"]=2,["X"]=55,["Y"]=55}, 
                                                    [7] = {["FRAME"]=1,["BARS"]=1,["GROW"]=2,["X"]=56,["Y"]=56}, 
                                                    [8] = {["FRAME"]=1,["BARS"]=1,["GROW"]=2,["X"]=57,["Y"]=57}, 
                                                    [9] = {["FRAME"]=1,["BARS"]=1,["GROW"]=2,["X"]=58,["Y"]=58}, 
                                                   [10] = {["FRAME"]=1,["BARS"]=1,["GROW"]=2,["X"]=59,["Y"]=59},},
                [HEALBOT_ZONE_AV]                = {[1] = {["FRAME"]=1,["BARS"]=1,["GROW"]=2,["X"]=50,["Y"]=50}, 
                                                    [2] = {["FRAME"]=1,["BARS"]=1,["GROW"]=2,["X"]=51,["Y"]=51}, 
                                                    [3] = {["FRAME"]=1,["BARS"]=1,["GROW"]=2,["X"]=52,["Y"]=52}, 
                                                    [4] = {["FRAME"]=1,["BARS"]=1,["GROW"]=2,["X"]=53,["Y"]=53}, 
                                                    [5] = {["FRAME"]=1,["BARS"]=1,["GROW"]=2,["X"]=54,["Y"]=54}, 
                                                    [6] = {["FRAME"]=1,["BARS"]=1,["GROW"]=2,["X"]=55,["Y"]=55}, 
                                                    [7] = {["FRAME"]=1,["BARS"]=1,["GROW"]=2,["X"]=56,["Y"]=56}, 
                                                    [8] = {["FRAME"]=1,["BARS"]=1,["GROW"]=2,["X"]=57,["Y"]=57}, 
                                                    [9] = {["FRAME"]=1,["BARS"]=1,["GROW"]=2,["X"]=58,["Y"]=58}, 
                                                   [10] = {["FRAME"]=1,["BARS"]=1,["GROW"]=2,["X"]=59,["Y"]=59},},
            },
    HeadBar = {[HEALBOT_SKINS_STD]               = {[1] = {["SHOW"]=1,["TEXTURE"]=HealBot_Default_Textures[10].name,["WIDTH"]=0.7,["HEIGHT"]=0.5,["R"]=0.1,["G"]=0.7,["B"]=0.1,["A"]=0.4},
                                                    [2] = {["SHOW"]=1,["TEXTURE"]=HealBot_Default_Textures[10].name,["WIDTH"]=0.7,["HEIGHT"]=0.5,["R"]=0.1,["G"]=0.7,["B"]=0.1,["A"]=0.4},
                                                    [3] = {["SHOW"]=1,["TEXTURE"]=HealBot_Default_Textures[10].name,["WIDTH"]=0.7,["HEIGHT"]=0.5,["R"]=0.1,["G"]=0.7,["B"]=0.1,["A"]=0.4},
                                                    [4] = {["SHOW"]=1,["TEXTURE"]=HealBot_Default_Textures[10].name,["WIDTH"]=0.7,["HEIGHT"]=0.5,["R"]=0.1,["G"]=0.7,["B"]=0.1,["A"]=0.4},
                                                    [5] = {["SHOW"]=1,["TEXTURE"]=HealBot_Default_Textures[10].name,["WIDTH"]=0.7,["HEIGHT"]=0.5,["R"]=0.1,["G"]=0.7,["B"]=0.1,["A"]=0.4},
                                                    [6] = {["SHOW"]=1,["TEXTURE"]=HealBot_Default_Textures[10].name,["WIDTH"]=0.7,["HEIGHT"]=0.5,["R"]=0.1,["G"]=0.7,["B"]=0.1,["A"]=0.4},
                                                    [7] = {["SHOW"]=1,["TEXTURE"]=HealBot_Default_Textures[10].name,["WIDTH"]=0.7,["HEIGHT"]=0.5,["R"]=0.1,["G"]=0.7,["B"]=0.1,["A"]=0.4},
                                                    [8] = {["SHOW"]=1,["TEXTURE"]=HealBot_Default_Textures[10].name,["WIDTH"]=0.7,["HEIGHT"]=0.5,["R"]=0.1,["G"]=0.7,["B"]=0.1,["A"]=0.4},
                                                    [9] = {["SHOW"]=1,["TEXTURE"]=HealBot_Default_Textures[10].name,["WIDTH"]=0.7,["HEIGHT"]=0.5,["R"]=0.1,["G"]=0.7,["B"]=0.1,["A"]=0.4},
                                                   [10] = {["SHOW"]=1,["TEXTURE"]=HealBot_Default_Textures[10].name,["WIDTH"]=0.7,["HEIGHT"]=0.5,["R"]=0.1,["G"]=0.7,["B"]=0.1,["A"]=0.4},},
               [HEALBOT_OPTIONS_GROUPHEALS]      = {[1] = {["SHOW"]=0,["TEXTURE"]=HealBot_Default_Textures[11].name,["WIDTH"]=0.9,["HEIGHT"]=0.8,["R"]=0.1,["G"]=0.1,["B"]=0.1,["A"]=0.25},
                                                    [2] = {["SHOW"]=0,["TEXTURE"]=HealBot_Default_Textures[11].name,["WIDTH"]=0.9,["HEIGHT"]=0.8,["R"]=0.1,["G"]=0.1,["B"]=0.1,["A"]=0.25},
                                                    [3] = {["SHOW"]=0,["TEXTURE"]=HealBot_Default_Textures[11].name,["WIDTH"]=0.9,["HEIGHT"]=0.8,["R"]=0.1,["G"]=0.1,["B"]=0.1,["A"]=0.25},
                                                    [4] = {["SHOW"]=0,["TEXTURE"]=HealBot_Default_Textures[11].name,["WIDTH"]=0.9,["HEIGHT"]=0.8,["R"]=0.1,["G"]=0.1,["B"]=0.1,["A"]=0.25},
                                                    [5] = {["SHOW"]=0,["TEXTURE"]=HealBot_Default_Textures[11].name,["WIDTH"]=0.9,["HEIGHT"]=0.8,["R"]=0.1,["G"]=0.1,["B"]=0.1,["A"]=0.25},
                                                    [6] = {["SHOW"]=0,["TEXTURE"]=HealBot_Default_Textures[11].name,["WIDTH"]=0.9,["HEIGHT"]=0.8,["R"]=0.1,["G"]=0.1,["B"]=0.1,["A"]=0.25},
                                                    [7] = {["SHOW"]=0,["TEXTURE"]=HealBot_Default_Textures[11].name,["WIDTH"]=0.9,["HEIGHT"]=0.8,["R"]=0.1,["G"]=0.1,["B"]=0.1,["A"]=0.25},
                                                    [8] = {["SHOW"]=0,["TEXTURE"]=HealBot_Default_Textures[11].name,["WIDTH"]=0.9,["HEIGHT"]=0.8,["R"]=0.1,["G"]=0.1,["B"]=0.1,["A"]=0.25},
                                                    [9] = {["SHOW"]=0,["TEXTURE"]=HealBot_Default_Textures[11].name,["WIDTH"]=0.9,["HEIGHT"]=0.8,["R"]=0.1,["G"]=0.1,["B"]=0.1,["A"]=0.25},
                                                   [10] = {["SHOW"]=0,["TEXTURE"]=HealBot_Default_Textures[11].name,["WIDTH"]=0.9,["HEIGHT"]=0.8,["R"]=0.1,["G"]=0.1,["B"]=0.1,["A"]=0.25},},
               [HEALBOT_OPTIONS_EMERGENCYHEALS]  = {[1] = {["SHOW"]=1,["TEXTURE"]=HealBot_Default_Textures[12].name,["WIDTH"]=0.9,["HEIGHT"]=0.5,["R"]=0.1,["G"]=0.1,["B"]=0.1,["A"]=0.25},
                                                    [2] = {["SHOW"]=1,["TEXTURE"]=HealBot_Default_Textures[12].name,["WIDTH"]=0.9,["HEIGHT"]=0.5,["R"]=0.1,["G"]=0.1,["B"]=0.1,["A"]=0.25},
                                                    [3] = {["SHOW"]=1,["TEXTURE"]=HealBot_Default_Textures[12].name,["WIDTH"]=0.9,["HEIGHT"]=0.5,["R"]=0.1,["G"]=0.1,["B"]=0.1,["A"]=0.25},
                                                    [4] = {["SHOW"]=1,["TEXTURE"]=HealBot_Default_Textures[12].name,["WIDTH"]=0.9,["HEIGHT"]=0.5,["R"]=0.1,["G"]=0.1,["B"]=0.1,["A"]=0.25},
                                                    [5] = {["SHOW"]=1,["TEXTURE"]=HealBot_Default_Textures[12].name,["WIDTH"]=0.9,["HEIGHT"]=0.5,["R"]=0.1,["G"]=0.1,["B"]=0.1,["A"]=0.25},
                                                    [6] = {["SHOW"]=1,["TEXTURE"]=HealBot_Default_Textures[12].name,["WIDTH"]=0.9,["HEIGHT"]=0.5,["R"]=0.1,["G"]=0.1,["B"]=0.1,["A"]=0.25},
                                                    [7] = {["SHOW"]=1,["TEXTURE"]=HealBot_Default_Textures[12].name,["WIDTH"]=0.9,["HEIGHT"]=0.5,["R"]=0.1,["G"]=0.1,["B"]=0.1,["A"]=0.25},
                                                    [8] = {["SHOW"]=1,["TEXTURE"]=HealBot_Default_Textures[12].name,["WIDTH"]=0.9,["HEIGHT"]=0.5,["R"]=0.1,["G"]=0.1,["B"]=0.1,["A"]=0.25},
                                                    [9] = {["SHOW"]=1,["TEXTURE"]=HealBot_Default_Textures[12].name,["WIDTH"]=0.9,["HEIGHT"]=0.5,["R"]=0.1,["G"]=0.1,["B"]=0.1,["A"]=0.25},
                                                   [10] = {["SHOW"]=1,["TEXTURE"]=HealBot_Default_Textures[12].name,["WIDTH"]=0.9,["HEIGHT"]=0.5,["R"]=0.1,["G"]=0.1,["B"]=0.1,["A"]=0.25},},
               [HEALBOT_ZONE_AV]                 = {[1] = {["SHOW"]=0,["TEXTURE"]=HealBot_Default_Textures[12].name,["WIDTH"]=0.9,["HEIGHT"]=0.4,["R"]=0.1,["G"]=0.1,["B"]=0.1,["A"]=0.2},
                                                    [2] = {["SHOW"]=0,["TEXTURE"]=HealBot_Default_Textures[12].name,["WIDTH"]=0.9,["HEIGHT"]=0.4,["R"]=0.1,["G"]=0.1,["B"]=0.1,["A"]=0.2},
                                                    [3] = {["SHOW"]=0,["TEXTURE"]=HealBot_Default_Textures[12].name,["WIDTH"]=0.9,["HEIGHT"]=0.4,["R"]=0.1,["G"]=0.1,["B"]=0.1,["A"]=0.2},
                                                    [4] = {["SHOW"]=0,["TEXTURE"]=HealBot_Default_Textures[12].name,["WIDTH"]=0.9,["HEIGHT"]=0.4,["R"]=0.1,["G"]=0.1,["B"]=0.1,["A"]=0.2},
                                                    [5] = {["SHOW"]=0,["TEXTURE"]=HealBot_Default_Textures[12].name,["WIDTH"]=0.9,["HEIGHT"]=0.4,["R"]=0.1,["G"]=0.1,["B"]=0.1,["A"]=0.2},
                                                    [6] = {["SHOW"]=0,["TEXTURE"]=HealBot_Default_Textures[12].name,["WIDTH"]=0.9,["HEIGHT"]=0.4,["R"]=0.1,["G"]=0.1,["B"]=0.1,["A"]=0.2},
                                                    [7] = {["SHOW"]=0,["TEXTURE"]=HealBot_Default_Textures[12].name,["WIDTH"]=0.9,["HEIGHT"]=0.4,["R"]=0.1,["G"]=0.1,["B"]=0.1,["A"]=0.2},
                                                    [8] = {["SHOW"]=0,["TEXTURE"]=HealBot_Default_Textures[12].name,["WIDTH"]=0.9,["HEIGHT"]=0.4,["R"]=0.1,["G"]=0.1,["B"]=0.1,["A"]=0.2},
                                                    [9] = {["SHOW"]=0,["TEXTURE"]=HealBot_Default_Textures[12].name,["WIDTH"]=0.9,["HEIGHT"]=0.4,["R"]=0.1,["G"]=0.1,["B"]=0.1,["A"]=0.2},
                                                   [10] = {["SHOW"]=0,["TEXTURE"]=HealBot_Default_Textures[12].name,["WIDTH"]=0.9,["HEIGHT"]=0.4,["R"]=0.1,["G"]=0.1,["B"]=0.1,["A"]=0.2},},
               },
    HeadText = {[HEALBOT_SKINS_STD]              = {[1] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=1,["A"]=0.74},
                                                    [2] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=1,["A"]=0.74},
                                                    [3] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=1,["A"]=0.74},
                                                    [4] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=1,["A"]=0.74},
                                                    [5] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=1,["A"]=0.74},
                                                    [6] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=1,["A"]=0.74},
                                                    [7] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=1,["A"]=0.74},
                                                    [8] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=1,["A"]=0.74},
                                                    [9] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=1,["A"]=0.74},
                                                   [10] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=1,["A"]=0.74},},
               [HEALBOT_OPTIONS_GROUPHEALS]      = {[1] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=0.1,["A"]=0.7},
                                                    [2] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=0.1,["A"]=0.7},
                                                    [3] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=0.1,["A"]=0.7},
                                                    [4] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=0.1,["A"]=0.7},
                                                    [5] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=0.1,["A"]=0.7},
                                                    [6] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=0.1,["A"]=0.7},
                                                    [7] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=0.1,["A"]=0.7},
                                                    [8] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=0.1,["A"]=0.7},
                                                    [9] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=0.1,["A"]=0.7},
                                                   [10] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=0.1,["A"]=0.7},},
               [HEALBOT_OPTIONS_EMERGENCYHEALS]  = {[1] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=0.1,["A"]=0.55},
                                                    [2] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=0.1,["A"]=0.55},
                                                    [3] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=0.1,["A"]=0.55},
                                                    [4] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=0.1,["A"]=0.55},
                                                    [5] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=0.1,["A"]=0.55},
                                                    [6] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=0.1,["A"]=0.55},
                                                    [7] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=0.1,["A"]=0.55},
                                                    [8] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=0.1,["A"]=0.55},
                                                    [9] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=0.1,["A"]=0.55},
                                                   [10] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=0.1,["A"]=0.55},},
               [HEALBOT_ZONE_AV]                 = {[1] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=0.1,["A"]=0.4},
                                                    [2] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=0.1,["A"]=0.4},
                                                    [3] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=0.1,["A"]=0.4},
                                                    [4] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=0.1,["A"]=0.4},
                                                    [5] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=0.1,["A"]=0.4},
                                                    [6] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=0.1,["A"]=0.4},
                                                    [7] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=0.1,["A"]=0.4},
                                                    [8] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=0.1,["A"]=0.4},
                                                    [9] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=0.1,["A"]=0.4},
                                                   [10] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["OUTLINE"]=1,["R"]=1,["G"]=1,["B"]=0.1,["A"]=0.4},},
               }, 
    HealBar = {[HEALBOT_SKINS_STD]               = {[1] = {["TEXTURE"]=HealBot_Default_Textures[8].name,["WIDTH"]=144,["HEIGHT"]=25,["RMARGIN"]=1,["CMARGIN"]=2,
                                                           ["NUMCOLS"]=2,["AGGROSIZE"]=2,["GRPCOLS"]=0,["POWERSIZE"]=0,["POWERCNT"]=1},
                                                    [2] = {["TEXTURE"]=HealBot_Default_Textures[8].name,["WIDTH"]=144,["HEIGHT"]=25,["RMARGIN"]=1,["CMARGIN"]=2,
                                                           ["NUMCOLS"]=2,["AGGROSIZE"]=2,["GRPCOLS"]=0,["POWERSIZE"]=0,["POWERCNT"]=1},
                                                    [3] = {["TEXTURE"]=HealBot_Default_Textures[8].name,["WIDTH"]=144,["HEIGHT"]=25,["RMARGIN"]=1,["CMARGIN"]=2,
                                                           ["NUMCOLS"]=2,["AGGROSIZE"]=2,["GRPCOLS"]=0,["POWERSIZE"]=0,["POWERCNT"]=1},
                                                    [4] = {["TEXTURE"]=HealBot_Default_Textures[8].name,["WIDTH"]=144,["HEIGHT"]=25,["RMARGIN"]=1,["CMARGIN"]=2,
                                                           ["NUMCOLS"]=2,["AGGROSIZE"]=2,["GRPCOLS"]=0,["POWERSIZE"]=0,["POWERCNT"]=1},
                                                    [5] = {["TEXTURE"]=HealBot_Default_Textures[8].name,["WIDTH"]=144,["HEIGHT"]=25,["RMARGIN"]=1,["CMARGIN"]=2,
                                                           ["NUMCOLS"]=2,["AGGROSIZE"]=2,["GRPCOLS"]=0,["POWERSIZE"]=0,["POWERCNT"]=1},
                                                    [6] = {["TEXTURE"]=HealBot_Default_Textures[8].name,["WIDTH"]=144,["HEIGHT"]=25,["RMARGIN"]=1,["CMARGIN"]=2,
                                                           ["NUMCOLS"]=2,["AGGROSIZE"]=2,["GRPCOLS"]=0,["POWERSIZE"]=0,["POWERCNT"]=1},
                                                    [7] = {["TEXTURE"]=HealBot_Default_Textures[8].name,["WIDTH"]=144,["HEIGHT"]=25,["RMARGIN"]=1,["CMARGIN"]=2,
                                                           ["NUMCOLS"]=2,["AGGROSIZE"]=2,["GRPCOLS"]=0,["POWERSIZE"]=0,["POWERCNT"]=1},
                                                    [8] = {["TEXTURE"]=HealBot_Default_Textures[8].name,["WIDTH"]=144,["HEIGHT"]=25,["RMARGIN"]=1,["CMARGIN"]=2,
                                                           ["NUMCOLS"]=2,["AGGROSIZE"]=2,["GRPCOLS"]=0,["POWERSIZE"]=0,["POWERCNT"]=1},
                                                    [9] = {["TEXTURE"]=HealBot_Default_Textures[8].name,["WIDTH"]=144,["HEIGHT"]=25,["RMARGIN"]=1,["CMARGIN"]=2,
                                                           ["NUMCOLS"]=2,["AGGROSIZE"]=2,["GRPCOLS"]=0,["POWERSIZE"]=0,["POWERCNT"]=1},
                                                   [10] = {["TEXTURE"]=HealBot_Default_Textures[8].name,["WIDTH"]=144,["HEIGHT"]=25,["RMARGIN"]=1,["CMARGIN"]=2,
                                                           ["NUMCOLS"]=2,["AGGROSIZE"]=2,["GRPCOLS"]=0,["POWERSIZE"]=0,["POWERCNT"]=1},},
               [HEALBOT_OPTIONS_GROUPHEALS]      = {[1] = {["TEXTURE"]=HealBot_Default_Textures[16].name,["WIDTH"]=158,["HEIGHT"]=28,["RMARGIN"]=0,["CMARGIN"]=4,
                                                           ["NUMCOLS"]=4,["AGGROSIZE"]=2,["GRPCOLS"]=1,["POWERSIZE"]=2,["POWERCNT"]=1},
                                                    [2] = {["TEXTURE"]=HealBot_Default_Textures[16].name,["WIDTH"]=158,["HEIGHT"]=28,["RMARGIN"]=0,["CMARGIN"]=4,
                                                           ["NUMCOLS"]=4,["AGGROSIZE"]=2,["GRPCOLS"]=1,["POWERSIZE"]=2,["POWERCNT"]=1},
                                                    [3] = {["TEXTURE"]=HealBot_Default_Textures[16].name,["WIDTH"]=158,["HEIGHT"]=28,["RMARGIN"]=0,["CMARGIN"]=4,
                                                           ["NUMCOLS"]=4,["AGGROSIZE"]=2,["GRPCOLS"]=1,["POWERSIZE"]=2,["POWERCNT"]=1},
                                                    [4] = {["TEXTURE"]=HealBot_Default_Textures[16].name,["WIDTH"]=158,["HEIGHT"]=28,["RMARGIN"]=0,["CMARGIN"]=4,
                                                           ["NUMCOLS"]=4,["AGGROSIZE"]=2,["GRPCOLS"]=1,["POWERSIZE"]=2,["POWERCNT"]=1},
                                                    [5] = {["TEXTURE"]=HealBot_Default_Textures[16].name,["WIDTH"]=158,["HEIGHT"]=28,["RMARGIN"]=0,["CMARGIN"]=4,
                                                           ["NUMCOLS"]=4,["AGGROSIZE"]=2,["GRPCOLS"]=1,["POWERSIZE"]=2,["POWERCNT"]=1},
                                                    [6] = {["TEXTURE"]=HealBot_Default_Textures[16].name,["WIDTH"]=158,["HEIGHT"]=28,["RMARGIN"]=0,["CMARGIN"]=4,
                                                           ["NUMCOLS"]=4,["AGGROSIZE"]=2,["GRPCOLS"]=1,["POWERSIZE"]=2,["POWERCNT"]=1},
                                                    [7] = {["TEXTURE"]=HealBot_Default_Textures[16].name,["WIDTH"]=158,["HEIGHT"]=28,["RMARGIN"]=0,["CMARGIN"]=4,
                                                           ["NUMCOLS"]=4,["AGGROSIZE"]=2,["GRPCOLS"]=1,["POWERSIZE"]=2,["POWERCNT"]=1},
                                                    [8] = {["TEXTURE"]=HealBot_Default_Textures[16].name,["WIDTH"]=158,["HEIGHT"]=28,["RMARGIN"]=0,["CMARGIN"]=4,
                                                           ["NUMCOLS"]=4,["AGGROSIZE"]=2,["GRPCOLS"]=1,["POWERSIZE"]=2,["POWERCNT"]=1},
                                                    [9] = {["TEXTURE"]=HealBot_Default_Textures[16].name,["WIDTH"]=158,["HEIGHT"]=28,["RMARGIN"]=0,["CMARGIN"]=4,
                                                           ["NUMCOLS"]=4,["AGGROSIZE"]=2,["GRPCOLS"]=1,["POWERSIZE"]=2,["POWERCNT"]=1},
                                                   [10] = {["TEXTURE"]=HealBot_Default_Textures[16].name,["WIDTH"]=158,["HEIGHT"]=28,["RMARGIN"]=0,["CMARGIN"]=4,
                                                           ["NUMCOLS"]=4,["AGGROSIZE"]=2,["GRPCOLS"]=1,["POWERSIZE"]=2,["POWERCNT"]=1},},
               [HEALBOT_OPTIONS_EMERGENCYHEALS]  = {[1] = {["TEXTURE"]=HealBot_Default_Textures[17].name,["WIDTH"]=75,["HEIGHT"]=32,["RMARGIN"]=2,["CMARGIN"]=2,
                                                           ["NUMCOLS"]=2,["AGGROSIZE"]=2,["GRPCOLS"]=1,["POWERSIZE"]=2,["POWERCNT"]=1},
                                                    [2] = {["TEXTURE"]=HealBot_Default_Textures[17].name,["WIDTH"]=75,["HEIGHT"]=32,["RMARGIN"]=2,["CMARGIN"]=2,
                                                           ["NUMCOLS"]=2,["AGGROSIZE"]=2,["GRPCOLS"]=1,["POWERSIZE"]=2,["POWERCNT"]=1},
                                                    [3] = {["TEXTURE"]=HealBot_Default_Textures[17].name,["WIDTH"]=75,["HEIGHT"]=32,["RMARGIN"]=2,["CMARGIN"]=2,
                                                           ["NUMCOLS"]=2,["AGGROSIZE"]=2,["GRPCOLS"]=1,["POWERSIZE"]=2,["POWERCNT"]=1},
                                                    [4] = {["TEXTURE"]=HealBot_Default_Textures[17].name,["WIDTH"]=75,["HEIGHT"]=32,["RMARGIN"]=2,["CMARGIN"]=2,
                                                           ["NUMCOLS"]=2,["AGGROSIZE"]=2,["GRPCOLS"]=1,["POWERSIZE"]=2,["POWERCNT"]=1},
                                                    [5] = {["TEXTURE"]=HealBot_Default_Textures[17].name,["WIDTH"]=75,["HEIGHT"]=32,["RMARGIN"]=2,["CMARGIN"]=2,
                                                           ["NUMCOLS"]=2,["AGGROSIZE"]=2,["GRPCOLS"]=1,["POWERSIZE"]=2,["POWERCNT"]=1},
                                                    [6] = {["TEXTURE"]=HealBot_Default_Textures[17].name,["WIDTH"]=75,["HEIGHT"]=32,["RMARGIN"]=2,["CMARGIN"]=2,
                                                           ["NUMCOLS"]=2,["AGGROSIZE"]=2,["GRPCOLS"]=1,["POWERSIZE"]=2,["POWERCNT"]=1},
                                                    [7] = {["TEXTURE"]=HealBot_Default_Textures[17].name,["WIDTH"]=75,["HEIGHT"]=32,["RMARGIN"]=2,["CMARGIN"]=2,
                                                           ["NUMCOLS"]=2,["AGGROSIZE"]=2,["GRPCOLS"]=1,["POWERSIZE"]=2,["POWERCNT"]=1},
                                                    [8] = {["TEXTURE"]=HealBot_Default_Textures[17].name,["WIDTH"]=75,["HEIGHT"]=32,["RMARGIN"]=2,["CMARGIN"]=2,
                                                           ["NUMCOLS"]=2,["AGGROSIZE"]=2,["GRPCOLS"]=1,["POWERSIZE"]=2,["POWERCNT"]=1},
                                                    [9] = {["TEXTURE"]=HealBot_Default_Textures[17].name,["WIDTH"]=75,["HEIGHT"]=32,["RMARGIN"]=2,["CMARGIN"]=2,
                                                           ["NUMCOLS"]=2,["AGGROSIZE"]=2,["GRPCOLS"]=1,["POWERSIZE"]=2,["POWERCNT"]=1},
                                                   [10] = {["TEXTURE"]=HealBot_Default_Textures[17].name,["WIDTH"]=75,["HEIGHT"]=32,["RMARGIN"]=2,["CMARGIN"]=2,
                                                           ["NUMCOLS"]=2,["AGGROSIZE"]=2,["GRPCOLS"]=1,["POWERSIZE"]=2,["POWERCNT"]=1},},
               [HEALBOT_ZONE_AV]                 = {[1] = {["TEXTURE"]=HealBot_Default_Textures[9].name,["WIDTH"]=72,["HEIGHT"]=20,["RMARGIN"]=1,["CMARGIN"]=1,
                                                           ["NUMCOLS"]=3,["AGGROSIZE"]=1,["GRPCOLS"]=0,["POWERSIZE"]=0,["POWERCNT"]=1},
                                                    [2] = {["TEXTURE"]=HealBot_Default_Textures[9].name,["WIDTH"]=72,["HEIGHT"]=20,["RMARGIN"]=1,["CMARGIN"]=1,
                                                           ["NUMCOLS"]=3,["AGGROSIZE"]=1,["GRPCOLS"]=0,["POWERSIZE"]=0,["POWERCNT"]=1},
                                                    [3] = {["TEXTURE"]=HealBot_Default_Textures[9].name,["WIDTH"]=72,["HEIGHT"]=20,["RMARGIN"]=1,["CMARGIN"]=1,
                                                           ["NUMCOLS"]=3,["AGGROSIZE"]=1,["GRPCOLS"]=0,["POWERSIZE"]=0,["POWERCNT"]=1},
                                                    [4] = {["TEXTURE"]=HealBot_Default_Textures[9].name,["WIDTH"]=72,["HEIGHT"]=20,["RMARGIN"]=1,["CMARGIN"]=1,
                                                           ["NUMCOLS"]=3,["AGGROSIZE"]=1,["GRPCOLS"]=0,["POWERSIZE"]=0,["POWERCNT"]=1},
                                                    [5] = {["TEXTURE"]=HealBot_Default_Textures[9].name,["WIDTH"]=72,["HEIGHT"]=20,["RMARGIN"]=1,["CMARGIN"]=1,
                                                           ["NUMCOLS"]=3,["AGGROSIZE"]=1,["GRPCOLS"]=0,["POWERSIZE"]=0,["POWERCNT"]=1},
                                                    [6] = {["TEXTURE"]=HealBot_Default_Textures[9].name,["WIDTH"]=72,["HEIGHT"]=20,["RMARGIN"]=1,["CMARGIN"]=1,
                                                           ["NUMCOLS"]=3,["AGGROSIZE"]=1,["GRPCOLS"]=0,["POWERSIZE"]=0,["POWERCNT"]=1},
                                                    [7] = {["TEXTURE"]=HealBot_Default_Textures[9].name,["WIDTH"]=72,["HEIGHT"]=20,["RMARGIN"]=1,["CMARGIN"]=1,
                                                           ["NUMCOLS"]=3,["AGGROSIZE"]=1,["GRPCOLS"]=0,["POWERSIZE"]=0,["POWERCNT"]=1},
                                                    [8] = {["TEXTURE"]=HealBot_Default_Textures[9].name,["WIDTH"]=72,["HEIGHT"]=20,["RMARGIN"]=1,["CMARGIN"]=1,
                                                           ["NUMCOLS"]=3,["AGGROSIZE"]=1,["GRPCOLS"]=0,["POWERSIZE"]=0,["POWERCNT"]=1},
                                                    [9] = {["TEXTURE"]=HealBot_Default_Textures[9].name,["WIDTH"]=72,["HEIGHT"]=20,["RMARGIN"]=1,["CMARGIN"]=1,
                                                           ["NUMCOLS"]=3,["AGGROSIZE"]=1,["GRPCOLS"]=0,["POWERSIZE"]=0,["POWERCNT"]=1},
                                                   [10] = {["TEXTURE"]=HealBot_Default_Textures[9].name,["WIDTH"]=72,["HEIGHT"]=20,["RMARGIN"]=1,["CMARGIN"]=1,
                                                           ["NUMCOLS"]=3,["AGGROSIZE"]=1,["GRPCOLS"]=0,["POWERSIZE"]=0,["POWERCNT"]=1},},
                },
    BarCol =  {[HEALBOT_SKINS_STD]               = {[1] = {["HLTH"]=1,["HR"]=0.4,["HG"]=0.4,["HB"]=0.7,["HA"]=1,["ORA"]=0.4,["DISA"]=0.1,["BACK"]=1,["BR"]=0.4,["BG"]=0.4,["BB"]=0.7,["BA"]=0,["BOUT"]=2},
                                                    [2] = {["HLTH"]=1,["HR"]=0.4,["HG"]=0.4,["HB"]=0.7,["HA"]=1,["ORA"]=0.4,["DISA"]=0.1,["BACK"]=1,["BR"]=0.4,["BG"]=0.4,["BB"]=0.7,["BA"]=0,["BOUT"]=2},
                                                    [3] = {["HLTH"]=1,["HR"]=0.4,["HG"]=0.4,["HB"]=0.7,["HA"]=1,["ORA"]=0.4,["DISA"]=0.1,["BACK"]=1,["BR"]=0.4,["BG"]=0.4,["BB"]=0.7,["BA"]=0,["BOUT"]=2},
                                                    [4] = {["HLTH"]=1,["HR"]=0.4,["HG"]=0.4,["HB"]=0.7,["HA"]=1,["ORA"]=0.4,["DISA"]=0.1,["BACK"]=1,["BR"]=0.4,["BG"]=0.4,["BB"]=0.7,["BA"]=0,["BOUT"]=2},
                                                    [5] = {["HLTH"]=1,["HR"]=0.4,["HG"]=0.4,["HB"]=0.7,["HA"]=1,["ORA"]=0.4,["DISA"]=0.1,["BACK"]=1,["BR"]=0.4,["BG"]=0.4,["BB"]=0.7,["BA"]=0,["BOUT"]=2},
                                                    [6] = {["HLTH"]=1,["HR"]=0.4,["HG"]=0.4,["HB"]=0.7,["HA"]=1,["ORA"]=0.4,["DISA"]=0.1,["BACK"]=1,["BR"]=0.4,["BG"]=0.4,["BB"]=0.7,["BA"]=0,["BOUT"]=2},
                                                    [7] = {["HLTH"]=1,["HR"]=0.4,["HG"]=0.4,["HB"]=0.7,["HA"]=1,["ORA"]=0.4,["DISA"]=0.1,["BACK"]=1,["BR"]=0.4,["BG"]=0.4,["BB"]=0.7,["BA"]=0,["BOUT"]=2},
                                                    [8] = {["HLTH"]=1,["HR"]=0.4,["HG"]=0.4,["HB"]=0.7,["HA"]=1,["ORA"]=0.4,["DISA"]=0.1,["BACK"]=1,["BR"]=0.4,["BG"]=0.4,["BB"]=0.7,["BA"]=0,["BOUT"]=2},
                                                    [9] = {["HLTH"]=1,["HR"]=0.4,["HG"]=0.4,["HB"]=0.7,["HA"]=1,["ORA"]=0.4,["DISA"]=0.1,["BACK"]=1,["BR"]=0.4,["BG"]=0.4,["BB"]=0.7,["BA"]=0,["BOUT"]=2},
                                                   [10] = {["HLTH"]=1,["HR"]=0.4,["HG"]=0.4,["HB"]=0.7,["HA"]=1,["ORA"]=0.4,["DISA"]=0.1,["BACK"]=1,["BR"]=0.4,["BG"]=0.4,["BB"]=0.7,["BA"]=0,["BOUT"]=2},},
               [HEALBOT_OPTIONS_GROUPHEALS]      = {[1] = {["HLTH"]=1,["HR"]=1,["HG"]=1,["HB"]=1,["HA"]=0.98,["ORA"]=0.35,["DISA"]=0.05,["BACK"]=1,["BR"]=1,["BG"]=1,["BB"]=1,["BA"]=0.1,["BOUT"]=2},
                                                    [2] = {["HLTH"]=1,["HR"]=1,["HG"]=1,["HB"]=1,["HA"]=0.98,["ORA"]=0.35,["DISA"]=0.05,["BACK"]=1,["BR"]=1,["BG"]=1,["BB"]=1,["BA"]=0.1,["BOUT"]=2},
                                                    [3] = {["HLTH"]=1,["HR"]=1,["HG"]=1,["HB"]=1,["HA"]=0.98,["ORA"]=0.35,["DISA"]=0.05,["BACK"]=1,["BR"]=1,["BG"]=1,["BB"]=1,["BA"]=0.1,["BOUT"]=2},
                                                    [4] = {["HLTH"]=1,["HR"]=1,["HG"]=1,["HB"]=1,["HA"]=0.98,["ORA"]=0.35,["DISA"]=0.05,["BACK"]=1,["BR"]=1,["BG"]=1,["BB"]=1,["BA"]=0.1,["BOUT"]=2},
                                                    [5] = {["HLTH"]=1,["HR"]=1,["HG"]=1,["HB"]=1,["HA"]=0.98,["ORA"]=0.35,["DISA"]=0.05,["BACK"]=1,["BR"]=1,["BG"]=1,["BB"]=1,["BA"]=0.1,["BOUT"]=2},
                                                    [6] = {["HLTH"]=1,["HR"]=1,["HG"]=1,["HB"]=1,["HA"]=0.98,["ORA"]=0.35,["DISA"]=0.05,["BACK"]=1,["BR"]=1,["BG"]=1,["BB"]=1,["BA"]=0.1,["BOUT"]=2},
                                                    [7] = {["HLTH"]=1,["HR"]=1,["HG"]=1,["HB"]=1,["HA"]=0.98,["ORA"]=0.35,["DISA"]=0.05,["BACK"]=1,["BR"]=1,["BG"]=1,["BB"]=1,["BA"]=0.1,["BOUT"]=2},
                                                    [8] = {["HLTH"]=1,["HR"]=1,["HG"]=1,["HB"]=1,["HA"]=0.98,["ORA"]=0.35,["DISA"]=0.05,["BACK"]=1,["BR"]=1,["BG"]=1,["BB"]=1,["BA"]=0.1,["BOUT"]=2},
                                                    [9] = {["HLTH"]=1,["HR"]=1,["HG"]=1,["HB"]=1,["HA"]=0.98,["ORA"]=0.35,["DISA"]=0.05,["BACK"]=1,["BR"]=1,["BG"]=1,["BB"]=1,["BA"]=0.1,["BOUT"]=2},
                                                   [10] = {["HLTH"]=1,["HR"]=1,["HG"]=1,["HB"]=1,["HA"]=0.98,["ORA"]=0.35,["DISA"]=0.05,["BACK"]=1,["BR"]=1,["BG"]=1,["BB"]=1,["BA"]=0.1,["BOUT"]=2},},
               [HEALBOT_OPTIONS_EMERGENCYHEALS]  = {[1] = {["HLTH"]=2,["HR"]=0.2,["HG"]=0.4,["HB"]=0.4,["HA"]=0.95,["ORA"]=0.3,["DISA"]=0.12,["BACK"]=2,["BR"]=0.2,["BG"]=0.4,["BB"]=0.4,["BA"]=0.05,["BOUT"]=1},
                                                    [2] = {["HLTH"]=2,["HR"]=0.2,["HG"]=0.4,["HB"]=0.4,["HA"]=0.95,["ORA"]=0.3,["DISA"]=0.12,["BACK"]=2,["BR"]=0.2,["BG"]=0.4,["BB"]=0.4,["BA"]=0.05,["BOUT"]=1},
                                                    [3] = {["HLTH"]=2,["HR"]=0.2,["HG"]=0.4,["HB"]=0.4,["HA"]=0.95,["ORA"]=0.3,["DISA"]=0.12,["BACK"]=2,["BR"]=0.2,["BG"]=0.4,["BB"]=0.4,["BA"]=0.05,["BOUT"]=1},
                                                    [4] = {["HLTH"]=2,["HR"]=0.2,["HG"]=0.4,["HB"]=0.4,["HA"]=0.95,["ORA"]=0.3,["DISA"]=0.12,["BACK"]=2,["BR"]=0.2,["BG"]=0.4,["BB"]=0.4,["BA"]=0.05,["BOUT"]=1},
                                                    [5] = {["HLTH"]=2,["HR"]=0.2,["HG"]=0.4,["HB"]=0.4,["HA"]=0.95,["ORA"]=0.3,["DISA"]=0.12,["BACK"]=2,["BR"]=0.2,["BG"]=0.4,["BB"]=0.4,["BA"]=0.05,["BOUT"]=1},
                                                    [6] = {["HLTH"]=2,["HR"]=0.2,["HG"]=0.4,["HB"]=0.4,["HA"]=0.95,["ORA"]=0.3,["DISA"]=0.12,["BACK"]=2,["BR"]=0.2,["BG"]=0.4,["BB"]=0.4,["BA"]=0.05,["BOUT"]=1},
                                                    [7] = {["HLTH"]=2,["HR"]=0.2,["HG"]=0.4,["HB"]=0.4,["HA"]=0.95,["ORA"]=0.3,["DISA"]=0.12,["BACK"]=2,["BR"]=0.2,["BG"]=0.4,["BB"]=0.4,["BA"]=0.05,["BOUT"]=1},
                                                    [8] = {["HLTH"]=2,["HR"]=0.2,["HG"]=0.4,["HB"]=0.4,["HA"]=0.95,["ORA"]=0.3,["DISA"]=0.12,["BACK"]=2,["BR"]=0.2,["BG"]=0.4,["BB"]=0.4,["BA"]=0.05,["BOUT"]=1},
                                                    [9] = {["HLTH"]=2,["HR"]=0.2,["HG"]=0.4,["HB"]=0.4,["HA"]=0.95,["ORA"]=0.3,["DISA"]=0.12,["BACK"]=2,["BR"]=0.2,["BG"]=0.4,["BB"]=0.4,["BA"]=0.05,["BOUT"]=1},
                                                   [10] = {["HLTH"]=2,["HR"]=0.2,["HG"]=0.4,["HB"]=0.4,["HA"]=0.95,["ORA"]=0.3,["DISA"]=0.12,["BACK"]=2,["BR"]=0.2,["BG"]=0.4,["BB"]=0.4,["BA"]=0.05,["BOUT"]=1},},
               [HEALBOT_ZONE_AV]                 = {[1] = {["HLTH"]=1,["HR"]=0,["HG"]=0.2,["HB"]=0.2,["HA"]=0.88,["ORA"]=0.25,["DISA"]=0.04,["BACK"]=1,["BR"]=0,["BG"]=0.2,["BB"]=0.2,["BA"]=0,["BOUT"]=0},
                                                    [2] = {["HLTH"]=1,["HR"]=0,["HG"]=0.2,["HB"]=0.2,["HA"]=0.88,["ORA"]=0.25,["DISA"]=0.04,["BACK"]=1,["BR"]=0,["BG"]=0.2,["BB"]=0.2,["BA"]=0,["BOUT"]=0},
                                                    [3] = {["HLTH"]=1,["HR"]=0,["HG"]=0.2,["HB"]=0.2,["HA"]=0.88,["ORA"]=0.25,["DISA"]=0.04,["BACK"]=1,["BR"]=0,["BG"]=0.2,["BB"]=0.2,["BA"]=0,["BOUT"]=0},
                                                    [4] = {["HLTH"]=1,["HR"]=0,["HG"]=0.2,["HB"]=0.2,["HA"]=0.88,["ORA"]=0.25,["DISA"]=0.04,["BACK"]=1,["BR"]=0,["BG"]=0.2,["BB"]=0.2,["BA"]=0,["BOUT"]=0},
                                                    [5] = {["HLTH"]=1,["HR"]=0,["HG"]=0.2,["HB"]=0.2,["HA"]=0.88,["ORA"]=0.25,["DISA"]=0.04,["BACK"]=1,["BR"]=0,["BG"]=0.2,["BB"]=0.2,["BA"]=0,["BOUT"]=0},
                                                    [6] = {["HLTH"]=1,["HR"]=0,["HG"]=0.2,["HB"]=0.2,["HA"]=0.88,["ORA"]=0.25,["DISA"]=0.04,["BACK"]=1,["BR"]=0,["BG"]=0.2,["BB"]=0.2,["BA"]=0,["BOUT"]=0},
                                                    [7] = {["HLTH"]=1,["HR"]=0,["HG"]=0.2,["HB"]=0.2,["HA"]=0.88,["ORA"]=0.25,["DISA"]=0.04,["BACK"]=1,["BR"]=0,["BG"]=0.2,["BB"]=0.2,["BA"]=0,["BOUT"]=0},
                                                    [8] = {["HLTH"]=1,["HR"]=0,["HG"]=0.2,["HB"]=0.2,["HA"]=0.88,["ORA"]=0.25,["DISA"]=0.04,["BACK"]=1,["BR"]=0,["BG"]=0.2,["BB"]=0.2,["BA"]=0,["BOUT"]=0},
                                                    [9] = {["HLTH"]=1,["HR"]=0,["HG"]=0.2,["HB"]=0.2,["HA"]=0.88,["ORA"]=0.25,["DISA"]=0.04,["BACK"]=1,["BR"]=0,["BG"]=0.2,["BB"]=0.2,["BA"]=0,["BOUT"]=0},
                                                   [10] = {["HLTH"]=1,["HR"]=0,["HG"]=0.2,["HB"]=0.2,["HA"]=0.88,["ORA"]=0.25,["DISA"]=0.04,["BACK"]=1,["BR"]=0,["BG"]=0.2,["BB"]=0.2,["BA"]=0,["BOUT"]=0},},
              },
    BarIACol =  {[HEALBOT_SKINS_STD]             = {[1] = {["IC"]=4,["IR"]=0.2,["IG"]=1,["IB"]=0.2,["IA"]=0.82,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.78},
                                                    [2] = {["IC"]=4,["IR"]=0.2,["IG"]=1,["IB"]=0.2,["IA"]=0.82,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.78},
                                                    [3] = {["IC"]=4,["IR"]=0.2,["IG"]=1,["IB"]=0.2,["IA"]=0.82,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.78},
                                                    [4] = {["IC"]=4,["IR"]=0.2,["IG"]=1,["IB"]=0.2,["IA"]=0.82,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.78},
                                                    [5] = {["IC"]=4,["IR"]=0.2,["IG"]=1,["IB"]=0.2,["IA"]=0.82,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.78},
                                                    [6] = {["IC"]=4,["IR"]=0.2,["IG"]=1,["IB"]=0.2,["IA"]=0.82,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.78},
                                                    [7] = {["IC"]=4,["IR"]=0.2,["IG"]=1,["IB"]=0.2,["IA"]=0.82,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.78},
                                                    [8] = {["IC"]=4,["IR"]=0.2,["IG"]=1,["IB"]=0.2,["IA"]=0.82,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.78},
                                                    [9] = {["IC"]=4,["IR"]=0.2,["IG"]=1,["IB"]=0.2,["IA"]=0.82,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.78},
                                                   [10] = {["IC"]=4,["IR"]=0.2,["IG"]=1,["IB"]=0.2,["IA"]=0.82,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.78},},
               [HEALBOT_OPTIONS_GROUPHEALS]      = {[1] = {["IC"]=4,["IR"]=0.4,["IG"]=1,["IB"]=0.4,["IA"]=0.75,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.7},
                                                    [2] = {["IC"]=4,["IR"]=0.4,["IG"]=1,["IB"]=0.4,["IA"]=0.75,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.7},
                                                    [3] = {["IC"]=4,["IR"]=0.4,["IG"]=1,["IB"]=0.4,["IA"]=0.75,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.7},
                                                    [4] = {["IC"]=4,["IR"]=0.4,["IG"]=1,["IB"]=0.4,["IA"]=0.75,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.7},
                                                    [5] = {["IC"]=4,["IR"]=0.4,["IG"]=1,["IB"]=0.4,["IA"]=0.75,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.7},
                                                    [6] = {["IC"]=4,["IR"]=0.4,["IG"]=1,["IB"]=0.4,["IA"]=0.75,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.7},
                                                    [7] = {["IC"]=4,["IR"]=0.4,["IG"]=1,["IB"]=0.4,["IA"]=0.75,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.7},
                                                    [8] = {["IC"]=4,["IR"]=0.4,["IG"]=1,["IB"]=0.4,["IA"]=0.75,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.7},
                                                    [9] = {["IC"]=4,["IR"]=0.4,["IG"]=1,["IB"]=0.4,["IA"]=0.75,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.7},
                                                   [10] = {["IC"]=4,["IR"]=0.4,["IG"]=1,["IB"]=0.4,["IA"]=0.75,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.7},},
               [HEALBOT_OPTIONS_EMERGENCYHEALS]  = {[1] = {["IC"]=4,["IR"]=0.2,["IG"]=0.8,["IB"]=0.2,["IA"]=0.58,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.5},
                                                    [2] = {["IC"]=4,["IR"]=0.2,["IG"]=0.8,["IB"]=0.2,["IA"]=0.58,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.5},
                                                    [3] = {["IC"]=4,["IR"]=0.2,["IG"]=0.8,["IB"]=0.2,["IA"]=0.58,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.5},
                                                    [4] = {["IC"]=4,["IR"]=0.2,["IG"]=0.8,["IB"]=0.2,["IA"]=0.58,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.5},
                                                    [5] = {["IC"]=4,["IR"]=0.2,["IG"]=0.8,["IB"]=0.2,["IA"]=0.58,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.5},
                                                    [6] = {["IC"]=4,["IR"]=0.2,["IG"]=0.8,["IB"]=0.2,["IA"]=0.58,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.5},
                                                    [7] = {["IC"]=4,["IR"]=0.2,["IG"]=0.8,["IB"]=0.2,["IA"]=0.58,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.5},
                                                    [8] = {["IC"]=4,["IR"]=0.2,["IG"]=0.8,["IB"]=0.2,["IA"]=0.58,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.5},
                                                    [9] = {["IC"]=4,["IR"]=0.2,["IG"]=0.8,["IB"]=0.2,["IA"]=0.58,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.5},
                                                   [10] = {["IC"]=4,["IR"]=0.2,["IG"]=0.8,["IB"]=0.2,["IA"]=0.58,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.5},},
               [HEALBOT_ZONE_AV]                 = {[1] = {["IC"]=4,["IR"]=0,["IG"]=0.5,["IB"]=0,["IA"]=0.52,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.4},
                                                    [2] = {["IC"]=4,["IR"]=0,["IG"]=0.5,["IB"]=0,["IA"]=0.52,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.4},
                                                    [3] = {["IC"]=4,["IR"]=0,["IG"]=0.5,["IB"]=0,["IA"]=0.52,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.4},
                                                    [4] = {["IC"]=4,["IR"]=0,["IG"]=0.5,["IB"]=0,["IA"]=0.52,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.4},
                                                    [5] = {["IC"]=4,["IR"]=0,["IG"]=0.5,["IB"]=0,["IA"]=0.52,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.4},
                                                    [6] = {["IC"]=4,["IR"]=0,["IG"]=0.5,["IB"]=0,["IA"]=0.52,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.4},
                                                    [7] = {["IC"]=4,["IR"]=0,["IG"]=0.5,["IB"]=0,["IA"]=0.52,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.4},
                                                    [8] = {["IC"]=4,["IR"]=0,["IG"]=0.5,["IB"]=0,["IA"]=0.52,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.4},
                                                    [9] = {["IC"]=4,["IR"]=0,["IG"]=0.5,["IB"]=0,["IA"]=0.52,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.4},
                                                   [10] = {["IC"]=4,["IR"]=0,["IG"]=0.5,["IB"]=0,["IA"]=0.52,["AC"]=3,["AR"]=1,["AG"]=1,["AB"]=1,["AA"]=0.4},},
                 },
    BarText  =  {[HEALBOT_SKINS_STD]             = {[1] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=1,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=1},
                                                    [2] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=1,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=1},
                                                    [3] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=1,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=1},
                                                    [4] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=1,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=1},
                                                    [5] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=1,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=1},
                                                    [6] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=1,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=1},
                                                    [7] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=1,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=1},
                                                    [8] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=1,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=1},
                                                    [9] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=1,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=1},
                                                   [10] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=1,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=1},},
               [HEALBOT_OPTIONS_GROUPHEALS]      = {[1] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=1,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=1},
                                                    [2] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=1,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=1},
                                                    [3] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=1,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=1},
                                                    [4] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=1,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=1},
                                                    [5] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=1,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=1},
                                                    [6] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=1,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=1},
                                                    [7] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=1,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=1},
                                                    [8] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=1,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=1},
                                                    [9] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=1,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=1},
                                                   [10] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=1,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=1},},
               [HEALBOT_OPTIONS_EMERGENCYHEALS]  = {[1] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=0,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=3},
                                                    [2] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=0,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=3},
                                                    [3] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=0,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=3},
                                                    [4] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=0,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=3},
                                                    [5] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=0,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=3},
                                                    [6] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=0,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=3},
                                                    [7] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=0,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=3},
                                                    [8] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=0,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=3},
                                                    [9] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=0,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=3},
                                                   [10] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=10,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=0,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=3},},
               [HEALBOT_ZONE_AV]                 = {[1] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=0,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=3},
                                                    [2] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=0,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=3},
                                                    [3] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=0,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=3},
                                                    [4] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=0,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=3},
                                                    [5] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=0,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=3},
                                                    [6] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=0,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=3},
                                                    [7] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=0,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=3},
                                                    [8] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=0,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=3},
                                                    [9] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=0,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=3},
                                                   [10] = {["FONT"]=HealBot_Default_Font,["HEIGHT"]=9,["CLASSTYPE"]=1,["SHOWROLE"]=1,["CLASSONBAR"]=0,["NAMEONBAR"]=1,["HLTHONBAR"]=1,["CLASSCOL"]=0,
                                                           ["ALIGN"]=2,["DOUBLE"]=1,["INCHEALS"]=2,["NUMFORMAT1"]=1,["NUMFORMAT2"]=1,["OUTLINE"]=1,["HLTHTYPE"]=3},},
                  },
    BarTextCol  =  {[HEALBOT_SKINS_STD]          = {[1] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.5,["DG"]=0.5,["DB"]=0.5,["DA"]=0.4,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                    [2] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.5,["DG"]=0.5,["DB"]=0.5,["DA"]=0.4,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                    [3] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.5,["DG"]=0.5,["DB"]=0.5,["DA"]=0.4,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                    [4] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.5,["DG"]=0.5,["DB"]=0.5,["DA"]=0.4,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                    [5] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.5,["DG"]=0.5,["DB"]=0.5,["DA"]=0.4,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                    [6] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.5,["DG"]=0.5,["DB"]=0.5,["DA"]=0.4,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                    [7] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.5,["DG"]=0.5,["DB"]=0.5,["DA"]=0.4,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                    [8] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.5,["DG"]=0.5,["DB"]=0.5,["DA"]=0.4,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                    [9] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.5,["DG"]=0.5,["DB"]=0.5,["DA"]=0.4,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                   [10] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.5,["DG"]=0.5,["DB"]=0.5,["DA"]=0.4,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},},
               [HEALBOT_OPTIONS_GROUPHEALS]      = {[1] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.5,["DG"]=0.5,["DB"]=0.5,["DA"]=0.4,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                    [2] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.5,["DG"]=0.5,["DB"]=0.5,["DA"]=0.4,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                    [3] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.5,["DG"]=0.5,["DB"]=0.5,["DA"]=0.4,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                    [4] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.5,["DG"]=0.5,["DB"]=0.5,["DA"]=0.4,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                    [5] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.5,["DG"]=0.5,["DB"]=0.5,["DA"]=0.4,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                    [6] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.5,["DG"]=0.5,["DB"]=0.5,["DA"]=0.4,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                    [7] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.5,["DG"]=0.5,["DB"]=0.5,["DA"]=0.4,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                    [8] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.5,["DG"]=0.5,["DB"]=0.5,["DA"]=0.4,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                    [9] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.5,["DG"]=0.5,["DB"]=0.5,["DA"]=0.4,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                   [10] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.5,["DG"]=0.5,["DB"]=0.5,["DA"]=0.4,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},},
               [HEALBOT_OPTIONS_EMERGENCYHEALS]  = {[1] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.5,["DG"]=0.5,["DB"]=0.5,["DA"]=0.25,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                    [2] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.5,["DG"]=0.5,["DB"]=0.5,["DA"]=0.25,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                    [3] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.5,["DG"]=0.5,["DB"]=0.5,["DA"]=0.25,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                    [4] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.5,["DG"]=0.5,["DB"]=0.5,["DA"]=0.25,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                    [5] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.5,["DG"]=0.5,["DB"]=0.5,["DA"]=0.25,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                    [6] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.5,["DG"]=0.5,["DB"]=0.5,["DA"]=0.25,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                    [7] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.5,["DG"]=0.5,["DB"]=0.5,["DA"]=0.25,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                    [8] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.5,["DG"]=0.5,["DB"]=0.5,["DA"]=0.25,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                    [9] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.5,["DG"]=0.5,["DB"]=0.5,["DA"]=0.25,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                   [10] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.5,["DG"]=0.5,["DB"]=0.5,["DA"]=0.25,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},},
               [HEALBOT_ZONE_AV]                 = {[1] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.4,["DG"]=0.4,["DB"]=0.4,["DA"]=0.08,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                    [2] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.4,["DG"]=0.4,["DB"]=0.4,["DA"]=0.08,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                    [3] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.4,["DG"]=0.4,["DB"]=0.4,["DA"]=0.08,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                    [4] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.4,["DG"]=0.4,["DB"]=0.4,["DA"]=0.08,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                    [5] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.4,["DG"]=0.4,["DB"]=0.4,["DA"]=0.08,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                    [6] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.4,["DG"]=0.4,["DB"]=0.4,["DA"]=0.08,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                    [7] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.4,["DG"]=0.4,["DB"]=0.4,["DA"]=0.08,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                    [8] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.4,["DG"]=0.4,["DB"]=0.4,["DA"]=0.08,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                    [9] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.4,["DG"]=0.4,["DB"]=0.4,["DA"]=0.08,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},
                                                   [10] = {["ER"]=1,["EG"]=1,["EB"]=0,["EA"]=1,["DR"]=0.4,["DG"]=0.4,["DB"]=0.4,["DA"]=0.08,["CR"]=1,["CG"]=1,["CB"]=1,["CA"]=1},},
                  }, 
    Icons  =  {[HEALBOT_SKINS_STD]               = {[1] = {["SHOWBUFF"]=1,["SHOWDEBUFF"]=1,["SHOWRC"]=1,["ONBAR"]=1,["DOUBLE"]=0,["SCALE"]=0.7,["I15EN"]=1,["POSITION"]=2},
                                                    [2] = {["SHOWBUFF"]=1,["SHOWDEBUFF"]=1,["SHOWRC"]=1,["ONBAR"]=1,["DOUBLE"]=0,["SCALE"]=0.7,["I15EN"]=1,["POSITION"]=2},
                                                    [3] = {["SHOWBUFF"]=1,["SHOWDEBUFF"]=1,["SHOWRC"]=1,["ONBAR"]=1,["DOUBLE"]=0,["SCALE"]=0.7,["I15EN"]=1,["POSITION"]=2},
                                                    [4] = {["SHOWBUFF"]=1,["SHOWDEBUFF"]=1,["SHOWRC"]=1,["ONBAR"]=1,["DOUBLE"]=0,["SCALE"]=0.7,["I15EN"]=1,["POSITION"]=2},
                                                    [5] = {["SHOWBUFF"]=1,["SHOWDEBUFF"]=1,["SHOWRC"]=1,["ONBAR"]=1,["DOUBLE"]=0,["SCALE"]=0.7,["I15EN"]=1,["POSITION"]=2},
                                                    [6] = {["SHOWBUFF"]=1,["SHOWDEBUFF"]=1,["SHOWRC"]=1,["ONBAR"]=1,["DOUBLE"]=0,["SCALE"]=0.7,["I15EN"]=1,["POSITION"]=2},
                                                    [7] = {["SHOWBUFF"]=1,["SHOWDEBUFF"]=1,["SHOWRC"]=1,["ONBAR"]=1,["DOUBLE"]=0,["SCALE"]=0.7,["I15EN"]=1,["POSITION"]=2},
                                                    [8] = {["SHOWBUFF"]=1,["SHOWDEBUFF"]=1,["SHOWRC"]=1,["ONBAR"]=1,["DOUBLE"]=0,["SCALE"]=0.7,["I15EN"]=1,["POSITION"]=2},
                                                    [9] = {["SHOWBUFF"]=1,["SHOWDEBUFF"]=1,["SHOWRC"]=1,["ONBAR"]=1,["DOUBLE"]=0,["SCALE"]=0.7,["I15EN"]=1,["POSITION"]=2},
                                                   [10] = {["SHOWBUFF"]=1,["SHOWDEBUFF"]=1,["SHOWRC"]=1,["ONBAR"]=1,["DOUBLE"]=0,["SCALE"]=0.7,["I15EN"]=1,["POSITION"]=2},},
               [HEALBOT_OPTIONS_GROUPHEALS]      = {[1] = {["SHOWBUFF"]=1,["SHOWDEBUFF"]=1,["SHOWRC"]=1,["ONBAR"]=1,["DOUBLE"]=0,["SCALE"]=0.65,["I15EN"]=1,["POSITION"]=2},
                                                    [2] = {["SHOWBUFF"]=1,["SHOWDEBUFF"]=1,["SHOWRC"]=1,["ONBAR"]=1,["DOUBLE"]=0,["SCALE"]=0.65,["I15EN"]=1,["POSITION"]=2},
                                                    [3] = {["SHOWBUFF"]=1,["SHOWDEBUFF"]=1,["SHOWRC"]=1,["ONBAR"]=1,["DOUBLE"]=0,["SCALE"]=0.65,["I15EN"]=1,["POSITION"]=2},
                                                    [4] = {["SHOWBUFF"]=1,["SHOWDEBUFF"]=1,["SHOWRC"]=1,["ONBAR"]=1,["DOUBLE"]=0,["SCALE"]=0.65,["I15EN"]=1,["POSITION"]=2},
                                                    [5] = {["SHOWBUFF"]=1,["SHOWDEBUFF"]=1,["SHOWRC"]=1,["ONBAR"]=1,["DOUBLE"]=0,["SCALE"]=0.65,["I15EN"]=1,["POSITION"]=2},
                                                    [6] = {["SHOWBUFF"]=1,["SHOWDEBUFF"]=1,["SHOWRC"]=1,["ONBAR"]=1,["DOUBLE"]=0,["SCALE"]=0.65,["I15EN"]=1,["POSITION"]=2},
                                                    [7] = {["SHOWBUFF"]=1,["SHOWDEBUFF"]=1,["SHOWRC"]=1,["ONBAR"]=1,["DOUBLE"]=0,["SCALE"]=0.65,["I15EN"]=1,["POSITION"]=2},
                                                    [8] = {["SHOWBUFF"]=1,["SHOWDEBUFF"]=1,["SHOWRC"]=1,["ONBAR"]=1,["DOUBLE"]=0,["SCALE"]=0.65,["I15EN"]=1,["POSITION"]=2},
                                                    [9] = {["SHOWBUFF"]=1,["SHOWDEBUFF"]=1,["SHOWRC"]=1,["ONBAR"]=1,["DOUBLE"]=0,["SCALE"]=0.65,["I15EN"]=1,["POSITION"]=2},
                                                   [10] = {["SHOWBUFF"]=1,["SHOWDEBUFF"]=1,["SHOWRC"]=1,["ONBAR"]=1,["DOUBLE"]=0,["SCALE"]=0.65,["I15EN"]=1,["POSITION"]=2},},
               [HEALBOT_OPTIONS_EMERGENCYHEALS]  = {[1] = {["SHOWBUFF"]=1,["SHOWDEBUFF"]=1,["SHOWRC"]=1,["ONBAR"]=1,["DOUBLE"]=1,["SCALE"]=1,["I15EN"]=1,["POSITION"]=2},
                                                    [2] = {["SHOWBUFF"]=1,["SHOWDEBUFF"]=1,["SHOWRC"]=1,["ONBAR"]=1,["DOUBLE"]=1,["SCALE"]=1,["I15EN"]=1,["POSITION"]=2},
                                                    [3] = {["SHOWBUFF"]=1,["SHOWDEBUFF"]=1,["SHOWRC"]=1,["ONBAR"]=1,["DOUBLE"]=1,["SCALE"]=1,["I15EN"]=1,["POSITION"]=2},
                                                    [4] = {["SHOWBUFF"]=1,["SHOWDEBUFF"]=1,["SHOWRC"]=1,["ONBAR"]=1,["DOUBLE"]=1,["SCALE"]=1,["I15EN"]=1,["POSITION"]=2},
                                                    [5] = {["SHOWBUFF"]=1,["SHOWDEBUFF"]=1,["SHOWRC"]=1,["ONBAR"]=1,["DOUBLE"]=1,["SCALE"]=1,["I15EN"]=1,["POSITION"]=2},
                                                    [6] = {["SHOWBUFF"]=1,["SHOWDEBUFF"]=1,["SHOWRC"]=1,["ONBAR"]=1,["DOUBLE"]=1,["SCALE"]=1,["I15EN"]=1,["POSITION"]=2},
                                                    [7] = {["SHOWBUFF"]=1,["SHOWDEBUFF"]=1,["SHOWRC"]=1,["ONBAR"]=1,["DOUBLE"]=1,["SCALE"]=1,["I15EN"]=1,["POSITION"]=2},
                                                    [8] = {["SHOWBUFF"]=1,["SHOWDEBUFF"]=1,["SHOWRC"]=1,["ONBAR"]=1,["DOUBLE"]=1,["SCALE"]=1,["I15EN"]=1,["POSITION"]=2},
                                                    [9] = {["SHOWBUFF"]=1,["SHOWDEBUFF"]=1,["SHOWRC"]=1,["ONBAR"]=1,["DOUBLE"]=1,["SCALE"]=1,["I15EN"]=1,["POSITION"]=2},
                                                   [10] = {["SHOWBUFF"]=1,["SHOWDEBUFF"]=1,["SHOWRC"]=1,["ONBAR"]=1,["DOUBLE"]=1,["SCALE"]=1,["I15EN"]=1,["POSITION"]=2},},
               [HEALBOT_ZONE_AV]                 = {[1] = {["SHOWBUFF"]=0,["SHOWDEBUFF"]=1,["SHOWRC"]=0,["ONBAR"]=1,["DOUBLE"]=0,["SCALE"]=0.75,["I15EN"]=1,["POSITION"]=2},
                                                    [2] = {["SHOWBUFF"]=0,["SHOWDEBUFF"]=1,["SHOWRC"]=0,["ONBAR"]=1,["DOUBLE"]=0,["SCALE"]=0.75,["I15EN"]=1,["POSITION"]=2},
                                                    [3] = {["SHOWBUFF"]=0,["SHOWDEBUFF"]=1,["SHOWRC"]=0,["ONBAR"]=1,["DOUBLE"]=0,["SCALE"]=0.75,["I15EN"]=1,["POSITION"]=2},
                                                    [4] = {["SHOWBUFF"]=0,["SHOWDEBUFF"]=1,["SHOWRC"]=0,["ONBAR"]=1,["DOUBLE"]=0,["SCALE"]=0.75,["I15EN"]=1,["POSITION"]=2},
                                                    [5] = {["SHOWBUFF"]=0,["SHOWDEBUFF"]=1,["SHOWRC"]=0,["ONBAR"]=1,["DOUBLE"]=0,["SCALE"]=0.75,["I15EN"]=1,["POSITION"]=2},
                                                    [6] = {["SHOWBUFF"]=0,["SHOWDEBUFF"]=1,["SHOWRC"]=0,["ONBAR"]=1,["DOUBLE"]=0,["SCALE"]=0.75,["I15EN"]=1,["POSITION"]=2},
                                                    [7] = {["SHOWBUFF"]=0,["SHOWDEBUFF"]=1,["SHOWRC"]=0,["ONBAR"]=1,["DOUBLE"]=0,["SCALE"]=0.75,["I15EN"]=1,["POSITION"]=2},
                                                    [8] = {["SHOWBUFF"]=0,["SHOWDEBUFF"]=1,["SHOWRC"]=0,["ONBAR"]=1,["DOUBLE"]=0,["SCALE"]=0.75,["I15EN"]=1,["POSITION"]=2},
                                                    [9] = {["SHOWBUFF"]=0,["SHOWDEBUFF"]=1,["SHOWRC"]=0,["ONBAR"]=1,["DOUBLE"]=0,["SCALE"]=0.75,["I15EN"]=1,["POSITION"]=2},
                                                   [10] = {["SHOWBUFF"]=0,["SHOWDEBUFF"]=1,["SHOWRC"]=0,["ONBAR"]=1,["DOUBLE"]=0,["SCALE"]=0.75,["I15EN"]=1,["POSITION"]=2},},
                  },
    RaidIcon =  {[HEALBOT_SKINS_STD]             = {[1] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                    [2] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                    [3] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                    [4] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                    [5] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                    [6] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                    [7] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                    [8] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                    [9] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                   [10] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},},
               [HEALBOT_OPTIONS_GROUPHEALS]      = {[1] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                    [2] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                    [3] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                    [4] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                    [5] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                    [6] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                    [7] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                    [8] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                    [9] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                   [10] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},},
               [HEALBOT_OPTIONS_EMERGENCYHEALS]  = {[1] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                    [2] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                    [3] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                    [4] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                    [5] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                    [6] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                    [7] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                    [8] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                    [9] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                   [10] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},},
               [HEALBOT_ZONE_AV]                 = {[1] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                    [2] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                    [3] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                    [4] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                    [5] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                    [6] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                    [7] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                    [8] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                    [9] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},
                                                   [10] = {["SHOW"]=1,["STAR"]=1,["CIRCLE"]=1,["DIAMOND"]=1,["TRIANGLE"]=1,["MOON"]=1,["SQUARE"]=1,["CROSS"]=1,["SKULL"]=1},},
              },
    IconText  =  {[HEALBOT_SKINS_STD]            = {[1] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=1,["SSDUR"]=1,["SCALE"]=0.75,["DURTHRH"]=9,["DURWARN"]=3},
                                                    [2] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=1,["SSDUR"]=1,["SCALE"]=0.75,["DURTHRH"]=9,["DURWARN"]=3},
                                                    [3] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=1,["SSDUR"]=1,["SCALE"]=0.75,["DURTHRH"]=9,["DURWARN"]=3},
                                                    [4] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=1,["SSDUR"]=1,["SCALE"]=0.75,["DURTHRH"]=9,["DURWARN"]=3},
                                                    [5] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=1,["SSDUR"]=1,["SCALE"]=0.75,["DURTHRH"]=9,["DURWARN"]=3},
                                                    [6] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=1,["SSDUR"]=1,["SCALE"]=0.75,["DURTHRH"]=9,["DURWARN"]=3},
                                                    [7] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=1,["SSDUR"]=1,["SCALE"]=0.75,["DURTHRH"]=9,["DURWARN"]=3},
                                                    [8] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=1,["SSDUR"]=1,["SCALE"]=0.75,["DURTHRH"]=9,["DURWARN"]=3},
                                                    [9] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=1,["SSDUR"]=1,["SCALE"]=0.75,["DURTHRH"]=9,["DURWARN"]=3},
                                                   [10] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=1,["SSDUR"]=1,["SCALE"]=0.75,["DURTHRH"]=9,["DURWARN"]=3},},
               [HEALBOT_OPTIONS_GROUPHEALS]      = {[1] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=1,["SSDUR"]=1,["SCALE"]=0.75,["DURTHRH"]=9,["DURWARN"]=3},
                                                    [2] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=1,["SSDUR"]=1,["SCALE"]=0.75,["DURTHRH"]=9,["DURWARN"]=3},
                                                    [3] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=1,["SSDUR"]=1,["SCALE"]=0.75,["DURTHRH"]=9,["DURWARN"]=3},
                                                    [4] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=1,["SSDUR"]=1,["SCALE"]=0.75,["DURTHRH"]=9,["DURWARN"]=3},
                                                    [5] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=1,["SSDUR"]=1,["SCALE"]=0.75,["DURTHRH"]=9,["DURWARN"]=3},
                                                    [6] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=1,["SSDUR"]=1,["SCALE"]=0.75,["DURTHRH"]=9,["DURWARN"]=3},
                                                    [7] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=1,["SSDUR"]=1,["SCALE"]=0.75,["DURTHRH"]=9,["DURWARN"]=3},
                                                    [8] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=1,["SSDUR"]=1,["SCALE"]=0.75,["DURTHRH"]=9,["DURWARN"]=3},
                                                    [9] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=1,["SSDUR"]=1,["SCALE"]=0.75,["DURTHRH"]=9,["DURWARN"]=3},
                                                   [10] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=1,["SSDUR"]=1,["SCALE"]=0.75,["DURTHRH"]=9,["DURWARN"]=3},},
               [HEALBOT_OPTIONS_EMERGENCYHEALS]  = {[1] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=1,["SSDUR"]=1,["SCALE"]=0.7,["DURTHRH"]=9,["DURWARN"]=3},
                                                    [2] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=1,["SSDUR"]=1,["SCALE"]=0.7,["DURTHRH"]=9,["DURWARN"]=3},
                                                    [3] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=1,["SSDUR"]=1,["SCALE"]=0.7,["DURTHRH"]=9,["DURWARN"]=3},
                                                    [4] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=1,["SSDUR"]=1,["SCALE"]=0.7,["DURTHRH"]=9,["DURWARN"]=3},
                                                    [5] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=1,["SSDUR"]=1,["SCALE"]=0.7,["DURTHRH"]=9,["DURWARN"]=3},
                                                    [6] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=1,["SSDUR"]=1,["SCALE"]=0.7,["DURTHRH"]=9,["DURWARN"]=3},
                                                    [7] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=1,["SSDUR"]=1,["SCALE"]=0.7,["DURTHRH"]=9,["DURWARN"]=3},
                                                    [8] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=1,["SSDUR"]=1,["SCALE"]=0.7,["DURTHRH"]=9,["DURWARN"]=3},
                                                    [9] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=1,["SSDUR"]=1,["SCALE"]=0.7,["DURTHRH"]=9,["DURWARN"]=3},
                                                   [10] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=1,["SSDUR"]=1,["SCALE"]=0.7,["DURTHRH"]=9,["DURWARN"]=3},},
               [HEALBOT_ZONE_AV]                 = {[1] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=0,["SSDUR"]=1,["SCALE"]=0.6,["DURTHRH"]=9,["DURWARN"]=3},
                                                    [2] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=0,["SSDUR"]=1,["SCALE"]=0.6,["DURTHRH"]=9,["DURWARN"]=3},
                                                    [3] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=0,["SSDUR"]=1,["SCALE"]=0.6,["DURTHRH"]=9,["DURWARN"]=3},
                                                    [4] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=0,["SSDUR"]=1,["SCALE"]=0.6,["DURTHRH"]=9,["DURWARN"]=3},
                                                    [5] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=0,["SSDUR"]=1,["SCALE"]=0.6,["DURTHRH"]=9,["DURWARN"]=3},
                                                    [6] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=0,["SSDUR"]=1,["SCALE"]=0.6,["DURTHRH"]=9,["DURWARN"]=3},
                                                    [7] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=0,["SSDUR"]=1,["SCALE"]=0.6,["DURTHRH"]=9,["DURWARN"]=3},
                                                    [8] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=0,["SSDUR"]=1,["SCALE"]=0.6,["DURTHRH"]=9,["DURWARN"]=3},
                                                    [9] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=0,["SSDUR"]=1,["SCALE"]=0.6,["DURTHRH"]=9,["DURWARN"]=3},
                                                   [10] = {["SCNT"]=1,["SSCNT"]=0,["SDUR"]=0,["SSDUR"]=1,["SCALE"]=0.6,["DURTHRH"]=9,["DURWARN"]=3},},
              },
       Enemy  =  {[HEALBOT_SKINS_STD]              = {["INCSELF"]=0,["INCTANKS"]=1,["INCMYTAR"]=0,["NUMBOSS"]=2,["HIDE"]=1,["EXISTSHOWPTAR"]=0,["EXISTSHOWBOSS"]=1},
                  [HEALBOT_OPTIONS_GROUPHEALS]     = {["INCSELF"]=0,["INCTANKS"]=1,["INCMYTAR"]=0,["NUMBOSS"]=2,["HIDE"]=1,["EXISTSHOWPTAR"]=0,["EXISTSHOWBOSS"]=1},
                  [HEALBOT_OPTIONS_EMERGENCYHEALS] = {["INCSELF"]=0,["INCTANKS"]=1,["INCMYTAR"]=0,["NUMBOSS"]=2,["HIDE"]=1,["EXISTSHOWPTAR"]=0,["EXISTSHOWBOSS"]=1},
                  [HEALBOT_ZONE_AV]                = {["INCSELF"]=0,["INCTANKS"]=1,["INCMYTAR"]=0,["NUMBOSS"]=2,["HIDE"]=1,["EXISTSHOWPTAR"]=0,["EXISTSHOWBOSS"]=1},
               },
};



HealBot_Config = {};
HealBot_Globals = {};
Healbot_Config_Skins = {};
HealBot_Config_Spells = {};
HealBot_Config_Buffs = {};
HealBot_Config_Cures = {};
HealBot_Class_Spells = {};
HealBot_Class_Buffs = {};
HealBot_Class_Cures = {};
HealBot_MapScale = {};

HealBot_Data={  ["TIPUNIT"] = "NONE",
                ["TIPTYPE"] = "NONE",
                ["TIPUSE"] = "NO",
                ["UILOCK"] = "NO",
                ["PCLASSTRIM"] = "",
                ["PRACETRIM"] = "",
                ["PNAME"] = "",
                ["PGUID"] = false,
                ["INSPECT"] = false,
                ["REFRESH"] = 1,
};
HealBot_UnitData={};
HealBot_UnitGUID={};
HealBot_Spells = {};
HealBot_Unit_Button={};                          
                                                                   
