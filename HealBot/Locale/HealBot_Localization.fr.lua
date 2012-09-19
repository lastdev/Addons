-- French version (by Kubik of Vol'Jin) 2010-11-17 / V. 4.0.3.0
-- à = \195\160
-- â = \195\162
-- ç = \195\167
-- è = \195\168
-- é = \195\169
-- ê = \195\170
-- î = \195\174
-- ï = \195\175
-- ô = \195\180
-- û = \195\187
-- espace avant ':' (?) = \194\160

if (GetLocale() == "frFR") then

-------------------
-- Compatibility --
-------------------

-- Class
HEALBOT_DRUID   = "Druide";
HEALBOT_HUNTER  = "Chasseur";
HEALBOT_MAGE    = "Mage";
HEALBOT_PALADIN = "Paladin";
HEALBOT_PRIEST  = "Pr\195\170tre";
HEALBOT_ROGUE   = "Voleur";
HEALBOT_SHAMAN  = "Chaman";
HEALBOT_WARLOCK = "D\195\169moniste";
HEALBOT_WARRIOR = "Guerrier";
HEALBOT_DEATHKNIGHT = "Chevalier de la mort";

HEALBOT_DISEASE            = "Maladie";
HEALBOT_MAGIC              = "Magie";
HEALBOT_CURSE              = "Mal\195\169diction";
HEALBOT_POISON             = "Poison";
HEALBOT_DISEASE_en                      = "Disease";  -- Do NOT localize this value.
HEALBOT_MAGIC_en                        = "Magic";  -- Do NOT localize this value.
HEALBOT_CURSE_en                        = "Curse";  -- Do NOT localize this value.
HEALBOT_POISON_en                       = "Poison";  -- Do NOT localize this value.
HEALBOT_CUSTOM_en                       = "Custom";  -- Do NOT localize this value. 

-- Debuffs
HEALBOT_DEBUFF_ANCIENT_HYSTERIA = "Hyst\195\169rie ancienne";
HEALBOT_DEBUFF_IGNITE_MANA      = "Enflammer le mana";
HEALBOT_DEBUFF_TAINTED_MIND     = "Esprit corrompu";
HEALBOT_DEBUFF_VIPER_STING      = "Morsure de vip\195\168re";
HEALBOT_DEBUFF_SILENCE          = "Silence";
HEALBOT_DEBUFF_MAGMA_SHACKLES   = "Entraves de magma";
HEALBOT_DEBUFF_FROSTBOLT        = "Eclair de givre";
HEALBOT_DEBUFF_HUNTERS_MARK     = "Marque du chasseur";
HEALBOT_DEBUFF_SLOW             = "Lent";
HEALBOT_DEBUFF_ARCANE_BLAST     = "D\195\169flagration des arcanes";
HEALBOT_DEBUFF_IMPOTENCE        = "Mal\195\169diction d'impuissance";
HEALBOT_DEBUFF_DECAYED_STR      = "Force diminu\195\169e";
HEALBOT_DEBUFF_DECAYED_INT      = "Intelligence diminu\195\169e";
HEALBOT_DEBUFF_CRIPPLE          = "Estropi\195\169";
HEALBOT_DEBUFF_CHILLED          = "Gel\195\169";
HEALBOT_DEBUFF_CONEOFCOLD       = "C\195\180ne de froid";
HEALBOT_DEBUFF_CONCUSSIVESHOT   = "Fl\195\168che de dispersion";
HEALBOT_DEBUFF_THUNDERCLAP      = "Coup de tonnerre";
HEALBOT_DEBUFF_HOWLINGSCREECH   = "Etreinte vampirirque";
HEALBOT_DEBUFF_DAZED            = "h\195\169b\195\169t\195\169";
HEALBOT_DEBUFF_UNSTABLE_AFFL    = "Affliction instable";
HEALBOT_DEBUFF_DREAMLESS_SLEEP  = "Sommeil sans r\195\170ve";
HEALBOT_DEBUFF_GREATER_DREAMLESS = "Sommeil sans r\195\170ve sup\195\169rieur";
HEALBOT_DEBUFF_MAJOR_DREAMLESS  = "Sommeil sans r\195\170ve majeure";
HEALBOT_DEBUFF_FROST_SHOCK      = "Horion de givre"

HB_TOOLTIP_MANA                      = "^Mana : (%d+)$";
HB_TOOLTIP_INSTANT_CAST              = "Incantation imm\195\169diate";
HB_TOOLTIP_CAST_TIME                 = "Incantation (%d+.?%d*) sec";
HB_TOOLTIP_CHANNELED                 = "Canalis\195\169"
HB_TOOLTIP_OFFLINE                   = "Hors ligne";
HB_OFFLINE                			 = "hors ligne"; -- has gone offline msg
HB_ONLINE                	         = "en ligne"; -- has come online msg

-----------------
-- Translation --
-----------------

HEALBOT_ADDON                 = "HealBot " .. HEALBOT_VERSION;
HEALBOT_LOADED                = " charg\195\169.";

HEALBOT_ACTION_OPTIONS        = "Options";

HEALBOT_OPTIONS_TITLE         = HEALBOT_ADDON;
HEALBOT_OPTIONS_DEFAULTS      = "D\195\169faut";
HEALBOT_OPTIONS_CLOSE         = "Fermer";
HEALBOT_OPTIONS_HARDRESET     = "ReloadUI";
HEALBOT_OPTIONS_SOFTRESET     = "ResetHB";
HEALBOT_OPTIONS_INFO          = "Infos";
HEALBOT_OPTIONS_TAB_GENERAL   = "G\195\169n\195\169ral";
HEALBOT_OPTIONS_TAB_SPELLS    = "Sorts";
HEALBOT_OPTIONS_TAB_HEALING   = "Soins";
HEALBOT_OPTIONS_TAB_CDC       = "Gu\195\169rison";
HEALBOT_OPTIONS_TAB_SKIN      = "Skin";
HEALBOT_OPTIONS_TAB_TIPS      = "Affich.";
HEALBOT_OPTIONS_TAB_BUFFS     = "Buffs"

HEALBOT_OPTIONS_BARALPHA      = "OPACITE : Barres";
HEALBOT_OPTIONS_BARALPHAINHEAL= "Sorts en cours";
HEALBOT_OPTIONS_BARALPHAEOR   = "Joueurs hors d\'atteinte";
HEALBOT_OPTIONS_ACTIONLOCKED  = "Verr. la position";
HEALBOT_OPTIONS_AUTOSHOW      = "Fermer auto.";
HEALBOT_OPTIONS_PANELSOUNDS   = "Son \195\160 l\'ouverture";
HEALBOT_OPTIONS_HIDEOPTIONS   = "Masquer \'options\'";
HEALBOT_OPTIONS_PROTECTPVP    = "Eviter le passage en JcJ";
HEALBOT_OPTIONS_HEAL_CHATOPT  = "Options de chat";

HEALBOT_OPTIONS_FRAMESCALE    = "Echelle du cadre"
HEALBOT_OPTIONS_SKINTEXT      = "Skin"
HEALBOT_SKINS_STD             = "Standard"
HEALBOT_OPTIONS_SKINTEXTURE   = "Texture"
HEALBOT_OPTIONS_SKINHEIGHT    = "Hauteur"
HEALBOT_OPTIONS_SKINWIDTH     = "Largeur"
HEALBOT_OPTIONS_SKINNUMCOLS   = "Nb de colonnes"
HEALBOT_OPTIONS_SKINNUMHCOLS  = "Nb d\'en-t\195\170tes par col."
HEALBOT_OPTIONS_SKINBRSPACE   = "Espacement rang\195\169es"
HEALBOT_OPTIONS_SKINBCSPACE   = "Espacement col."
HEALBOT_OPTIONS_EXTRASORT     = "Trier les barres de raid par"
HEALBOT_SORTBY_NAME           = "Nom"
HEALBOT_SORTBY_CLASS          = "Classe"
HEALBOT_SORTBY_GROUP          = "Groupe"
HEALBOT_SORTBY_MAXHEALTH      = "Vie max."
HEALBOT_OPTIONS_NEWDEBUFFTEXT = "Nveau d\195\169buff"
HEALBOT_OPTIONS_DELSKIN       = "Supprimer"
HEALBOT_OPTIONS_NEWSKINTEXT   = "Nveau nom"
HEALBOT_OPTIONS_SAVESKIN      = "Sauver"
HEALBOT_OPTIONS_SKINBARS      = "Options des barres"
HEALBOT_SKIN_ENTEXT           = "Activ\195\169"
HEALBOT_SKIN_DISTEXT          = "Hors combat"
HEALBOT_SKIN_DEBTEXT          = "D\195\169buff"
HEALBOT_SKIN_BACKTEXT         = "Arri\195\168re plan"
HEALBOT_SKIN_BORDERTEXT       = "Bordure"
HEALBOT_OPTIONS_SKINFONT      = "Police"
HEALBOT_OPTIONS_SKINFHEIGHT   = "Taille des caract\195\168res"
HEALBOT_OPTIONS_SKINFOUTLINE            = "Contour de police"
HEALBOT_OPTIONS_BARALPHADIS   = "Hors combat"
HEALBOT_OPTIONS_SHOWHEADERS   = "Afficher les en-t\195\170tes"

HEALBOT_OPTIONS_ITEMS  = "Objets";

HEALBOT_OPTIONS_COMBOCLASS    = "Combinaison de touche pour";
HEALBOT_OPTIONS_CLICK         = "Clic";
HEALBOT_OPTIONS_SHIFT         = "Maj";
HEALBOT_OPTIONS_CTRL          = "Ctrl";
HEALBOT_OPTIONS_ENABLEHEALTHY = "Tjrs util. cfg. 'en combat'";

HEALBOT_OPTIONS_CASTNOTIFY1         = "Pas de messages";
HEALBOT_OPTIONS_CASTNOTIFY2         = "Avertir soi-m\195\170me";
HEALBOT_OPTIONS_CASTNOTIFY3         = "Avertir la cible";
HEALBOT_OPTIONS_CASTNOTIFY4         = "Avertir le groupe";
HEALBOT_OPTIONS_CASTNOTIFY5         = "Avertir le raid";
HEALBOT_OPTIONS_CASTNOTIFY6         = "Sur canal";
HEALBOT_OPTIONS_CASTNOTIFYRESONLY   = "Avertir uniquement de la r\195\169surrection";

HEALBOT_OPTIONS_CDCBARS             = "Couleur";
HEALBOT_OPTIONS_CDCSHOWHBARS        = "Sur la barre de vie";
HEALBOT_OPTIONS_CDCSHOWABARS        = "Sur la barre d\'aggro";
HEALBOT_OPTIONS_CDCWARNINGS         = "Alertes d\195\169buffs";
HEALBOT_OPTIONS_SHOWDEBUFFICON      = "Aff. les d\195\169buffs";
HEALBOT_OPTIONS_SHOWDEBUFFWARNING   = "Afficher une alerte de d\195\169buff";
HEALBOT_OPTIONS_SOUNDDEBUFFWARNING  = "Son pour les d\195\169buffs";
HEALBOT_OPTIONS_SOUND	            = "Son"

HEALBOT_OPTIONS_HEAL_BUTTONS    = "Barres de soins:"
HEALBOT_OPTIONS_SELFHEALS       = "soi-m\195\170me"
HEALBOT_OPTIONS_PETHEALS        = "Familiers"
HEALBOT_OPTIONS_GROUPHEALS      = "Groupe";
HEALBOT_OPTIONS_TANKHEALS       = "Tank principal";
HEALBOT_OPTIONS_MAINASSIST      = "Assist principal";
HEALBOT_OPTIONS_PRIVATETANKS    = "Main Tanks perso.";
HEALBOT_OPTIONS_TARGETHEALS     = "Cibles";
HEALBOT_OPTIONS_EMERGENCYHEALS  = "Raid";
HEALBOT_OPTIONS_ALERTLEVEL      = "Niveau d'alerte";
HEALBOT_OPTIONS_EMERGFILTER     = "Barre pour";
HEALBOT_OPTIONS_EMERGFCLASS     = "Config. classes pour";
HEALBOT_OPTIONS_COMBOBUTTON     = "Bouton";
HEALBOT_OPTIONS_BUTTONLEFT      = "Gauche";
HEALBOT_OPTIONS_BUTTONMIDDLE    = "Milieu";
HEALBOT_OPTIONS_BUTTONRIGHT     = "Droite";
HEALBOT_OPTIONS_BUTTON4         = "Bouton4";
HEALBOT_OPTIONS_BUTTON5         = "Bouton5";
HEALBOT_OPTIONS_BUTTON6         = "Bouton6";
HEALBOT_OPTIONS_BUTTON7         = "Bouton7";
HEALBOT_OPTIONS_BUTTON8         = "Bouton8";
HEALBOT_OPTIONS_BUTTON9         = "Bouton9";
HEALBOT_OPTIONS_BUTTON10        = "Bouton10";
HEALBOT_OPTIONS_BUTTON11        = "Bouton11";
HEALBOT_OPTIONS_BUTTON12        = "Bouton12";
HEALBOT_OPTIONS_BUTTON13        = "Bouton13";
HEALBOT_OPTIONS_BUTTON14        = "Bouton14";
HEALBOT_OPTIONS_BUTTON15        = "Bouton15";


HEALBOT_CLASSES_ALL     = "Toutes les classes";
HEALBOT_CLASSES_MELEE   = "Corps \195\160 corps";
HEALBOT_CLASSES_RANGES  = "A distance";
HEALBOT_CLASSES_HEALERS = "Soigneurs";
HEALBOT_CLASSES_CUSTOM  = "Personnalis\195\169";

HEALBOT_OPTIONS_SHOWTOOLTIP     = "Montrer infos";
HEALBOT_OPTIONS_SHOWDETTOOLTIP  = "Montrer le d\195\169tail des sorts";
HEALBOT_OPTIONS_SHOWCDTOOLTIP   = "Montrer le CD des sorts";
HEALBOT_OPTIONS_SHOWUNITTOOLTIP = "Montrer infos sur la cible";
HEALBOT_OPTIONS_SHOWRECTOOLTIP  = "Montrer le soin HoT recommand\195\169";
HEALBOT_TOOLTIP_POSDEFAULT      = "Par d\195\169faut";
HEALBOT_TOOLTIP_POSLEFT         = "A gauche de Healbot";
HEALBOT_TOOLTIP_POSRIGHT        = "A droite de Healbot";
HEALBOT_TOOLTIP_POSABOVE        = "Au dessus de Healbot";
HEALBOT_TOOLTIP_POSBELOW        = "Au dessous de Healbot";
HEALBOT_TOOLTIP_POSCURSOR       = "Pr\195\170t du Curseur";
HEALBOT_TOOLTIP_RECOMMENDTEXT   = "Soin HoT recommand\195\169";
HEALBOT_TOOLTIP_NONE            = "Non disponible";
HEALBOT_TOOLTIP_CORPSE          = "Cadavre de ";
HEALBOT_TOOLTIP_CD              = " (CD ";
HEALBOT_TOOLTIP_SECS            = "s)";
HEALBOT_WORDS_SEC               = "sec";
HEALBOT_WORDS_CAST              = "lancer";
HEALBOT_WORDS_UNKNOW            = "inconnu";
HEALBOT_WORDS_YES               = "Oui";
HEALBOT_WORDS_NO                = "Non";
HEALBOT_WORDS_THIN              = "Fin";
HEALBOT_WORDS_THICK             = "Epais";

HEALBOT_WORDS_NONE                  = "Aucun";
HEALBOT_OPTIONS_ALT                 = "Alt";
HEALBOT_DISABLED_TARGET             = "Cible"
HEALBOT_OPTIONS_SHOWCLASSONBAR      = "Afficher la classe";
HEALBOT_OPTIONS_SHOWHEALTHONBAR     = "Afficher la vie";
HEALBOT_OPTIONS_BARHEALTHINCHEALS   = "Inclure les soins en cours";
HEALBOT_OPTIONS_BARHEALTHSEPHEALS   = "Montant des soins en cours";
HEALBOT_OPTIONS_BARHEALTH1          = "en \195\169cart";
HEALBOT_OPTIONS_BARHEALTH2          = "en pourcentage";
HEALBOT_OPTIONS_TIPTEXT             = "Bulle d\'info";
HEALBOT_OPTIONS_POSTOOLTIP          = "Position";
HEALBOT_OPTIONS_SHOWNAMEONBAR       = "Afficher le nom";
HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR1 = "Coul. des noms par classe";
HEALBOT_OPTIONS_EMERGFILTERGROUPS   = "Inclure groupes";

HEALBOT_ONE                             = "1";
HEALBOT_TWO                             = "2";
HEALBOT_THREE                           = "3";
HEALBOT_FOUR                            = "4";
HEALBOT_FIVE                            = "5";
HEALBOT_SIX                             = "6";
HEALBOT_SEVEN                           = "7";
HEALBOT_EIGHT                           = "8";

HEALBOT_OPTIONS_SETDEFAULTS      = "R\195\169g. par d\195\169faut";
HEALBOT_OPTIONS_SETDEFAULTSMSG   = "R\195\169-initialise toutes les options par d\195\169faut";
HEALBOT_OPTIONS_RIGHTBOPTIONS    = "Clic droit ouvre les options";

HEALBOT_OPTIONS_HEADEROPTTEXT    = "Options des titres";
HEALBOT_OPTIONS_ICONOPTTEXT      = "Options d\'ic\195\180nes";
HEALBOT_SKIN_HEADERBARCOL        = "Couleur des barres";
HEALBOT_SKIN_HEADERTEXTCOL       = "Couleur du texte";
HEALBOT_OPTIONS_BUFFSTEXT1       = "Type de buff";
HEALBOT_OPTIONS_BUFFSTEXT2       = "V\195\169rifier membres";
HEALBOT_OPTIONS_BUFFSTEXT3       = "Couleur";
HEALBOT_OPTIONS_BUFF             = "Buff ";
HEALBOT_OPTIONS_BUFFSELF         = "sur soi";
HEALBOT_OPTIONS_BUFFPARTY        = "sur le groupe";
HEALBOT_OPTIONS_BUFFRAID         = "sur le raid";
HEALBOT_OPTIONS_MONITORBUFFS     = "Afficher les buffs manquants";
HEALBOT_OPTIONS_MONITORBUFFSC    = "\195\169galement en combat";
HEALBOT_OPTIONS_ENABLESMARTCAST  = "Sorts intelligents hors combat";
HEALBOT_OPTIONS_SMARTCASTSPELLS  = "Inclure les sorts";
HEALBOT_OPTIONS_SMARTCASTDISPELL = "Enlever les d\195\169buffs";
HEALBOT_OPTIONS_SMARTCASTBUFF    = "Ajouter les buffs";
HEALBOT_OPTIONS_SMARTCASTHEAL    = "Sorts de soin";
HEALBOT_OPTIONS_BAR2SIZE         = "Taille de la barre de mana";
HEALBOT_OPTIONS_SETSPELLS        = "Conf. sorts pour";
HEALBOT_OPTIONS_ENABLEDBARS      = "Barres en combat";
HEALBOT_OPTIONS_DISABLEDBARS     = "Barres hors combat";
HEALBOT_OPTIONS_MONITORDEBUFFS   = "Afficher les d\195\169buffs";
HEALBOT_OPTIONS_DEBUFFTEXT1      = "Sort pour retirer les d\195\169buffs";

HEALBOT_OPTIONS_IGNOREDEBUFF         = "Ignorer d\195\169buffs:";
HEALBOT_OPTIONS_IGNOREDEBUFFCLASS    = "Par classe";
HEALBOT_OPTIONS_IGNOREDEBUFFMOVEMENT = "Ralentissement";
HEALBOT_OPTIONS_IGNOREDEBUFFDURATION = "Dur\195\169e courte";
HEALBOT_OPTIONS_IGNOREDEBUFFNOHARM   = "Non nocifs";

HEALBOT_OPTIONS_RANGECHECKFREQ       = "Fr\195\169quence de v\195\169rif. de la distance, des auras et de l\'aggro";

HEALBOT_OPTIONS_HIDEPARTYFRAMES      = "Masquer avatars";
HEALBOT_OPTIONS_HIDEPLAYERTARGET     = "Y compris joueur & Cible";
HEALBOT_OPTIONS_DISABLEHEALBOT       = "D\195\169sactiver HealBot";

HEALBOT_OPTIONS_CHECKEDTARGET        = "V\195\169rifi\195\169";

HEALBOT_ASSIST                       = "Assist";
HEALBOT_FOCUS                        = "Focus";
HEALBOT_MENU                         = "Menu";
HEALBOT_MAINTANK                     = "MainTank";
HEALBOT_MAINASSIST                   = "MainAssist";
HEALBOT_STOP                         = "Stop";
HEALBOT_TELL                         = "Dire";

HEALBOT_TITAN_SMARTCAST              = "Sorts intelligents";
HEALBOT_TITAN_MONITORBUFFS           = "Afficher les Buffs";
HEALBOT_TITAN_MONITORDEBUFFS         = "Afficher les d\195\169buffs"
HEALBOT_TITAN_SHOWBARS               = "Afficher barres pour";
HEALBOT_TITAN_EXTRABARS              = "Barres suppl.";
HEALBOT_BUTTON_TOOLTIP               = "Clic gauche : options HealBot\nClic-drag droit : d\195\169placer mini bouton";
HEALBOT_TITAN_TOOLTIP                = "Clic gauche : options HealBot";
HEALBOT_OPTIONS_SHOWMINIMAPBUTTON    = "Aff. le bouton sur la minicarte";
HEALBOT_OPTIONS_BARBUTTONSHOWHOT     = "Aff. les HoT";
HEALBOT_OPTIONS_BARBUTTONSHOWRAIDICON = "Afficher les ic\195\180nes de raid";
HEALBOT_OPTIONS_HOTONBAR             = "Sur barre";
HEALBOT_OPTIONS_HOTOFFBAR            = "Hors barre";
HEALBOT_OPTIONS_HOTBARRIGHT          = "Droite";
HEALBOT_OPTIONS_HOTBARLEFT           = "Gauche";

HEALBOT_ZONE_AB = "Bassin d\'Arathi"; 
HEALBOT_ZONE_AV = "Vall\195\169e d\'Alterac";   
HEALBOT_ZONE_ES = "Oeil du cyclone";
HEALBOT_ZONE_IC = "Ile des conqu\195\169rants";
HEALBOT_ZONE_SA = "Rivage des anciens";
HEALBOT_ZONE_WG = "Goulet des Chanteguerres";

HEALBOT_OPTION_AGGROTRACK     = "Moniteur d'aggro"
HEALBOT_OPTION_AGGROBAR       = "Barre"
HEALBOT_OPTION_AGGROTXT       = ">> Texte <<"
HEALBOT_OPTION_BARUPDFREQ     = "Fr\195\169quence de mise \195\160 jour des barres"
HEALBOT_OPTION_USEFLUIDBARS   = "Barres fluides"
HEALBOT_OPTION_CPUPROFILE     = "Aff. utilisation CPU des addons (intensif pour le CPU !)"
HEALBOT_OPTIONS_RELOADUIMSG   = "Requiert un re-chargement de l\'UI, charger maintenant ?"

HEALBOT_SELF_PVP              = "Self PvP"
HEALBOT_OPTIONS_ANCHOR        = "Ancre du cadre"
HEALBOT_OPTIONS_BARSANCHOR    = "Ancre des barres"
HEALBOT_OPTIONS_TOPLEFT       = "Haut \195\160 gauche"
HEALBOT_OPTIONS_BOTTOMLEFT    = "Bas \195\160 gauche"
HEALBOT_OPTIONS_TOPRIGHT      = "Haut \195\160 droite"
HEALBOT_OPTIONS_BOTTOMRIGHT   = "Bas \195\160 droite"
HEALBOT_OPTIONS_TOP           = "Haut"
HEALBOT_OPTIONS_BOTTOM        = "Bas"

HEALBOT_PANEL_BLACKLIST       = "BlackList"

HEALBOT_WORDS_REMOVEFROM      = "Retirer de";
HEALBOT_WORDS_ADDTO           = "Ajouter \195\160";
HEALBOT_WORDS_INCLUDE         = "Inclure";

HEALBOT_OPTIONS_TTALPHA       = "Opacit\195\169"
HEALBOT_TOOLTIP_TARGETBAR     = "Barre de cible"
HEALBOT_OPTIONS_MYTARGET      = "Mes cibles"

HEALBOT_DISCONNECTED_TEXT			= "<DC>"
HEALBOT_OPTIONS_SHOWUNITBUFFTIME    = "Montrer mes buffs";
HEALBOT_OPTIONS_TOOLTIPUPDATE       = "M\195\160J permanente";
HEALBOT_OPTIONS_BUFFSTEXTTIMER      = "Pr\195\169venir de la fin des buffs avant expiration";
HEALBOT_OPTIONS_SHORTBUFFTIMER      = "Buffs courts"
HEALBOT_OPTIONS_LONGBUFFTIMER       = "Buffs longs"

HEALBOT_BALANCE       = "Equilibre"
HEALBOT_FERAL         = "Feral"
HEALBOT_RESTORATION   = "Restauration"
HEALBOT_SHAMAN_RESTORATION = "Restauration"
HEALBOT_ARCANE        = "Arcane"
HEALBOT_FIRE          = "Feu"
HEALBOT_FROST         = "Givre"
HEALBOT_DISCIPLINE    = "Discipline"
HEALBOT_HOLY          = "Sacr\195\169"
HEALBOT_SHADOW        = "Ombre"
HEALBOT_ASSASSINATION = "Assassinat"
HEALBOT_COMBAT        = "Combat"
HEALBOT_SUBTLETY      = "Finesse"
HEALBOT_ARMS          = "Armes"
HEALBOT_FURY          = "Fureur"
HEALBOT_PROTECTION    = "Protection"
HEALBOT_BEASTMASTERY  = "Ma\195\175trise des b\195\170tes"
HEALBOT_MARKSMANSHIP  = "Pr\195\169cision"
HEALBOT_SURVIVAL      = "Survie"
HEALBOT_RETRIBUTION   = "Restauration"
HEALBOT_ELEMENTAL     = "El\195\169mentaire"
HEALBOT_ENHANCEMENT   = "Am\195\169lioration"
HEALBOT_AFFLICTION    = "Affliction"
HEALBOT_DEMONOLOGY    = "D\195\169monologie"
HEALBOT_DESTRUCTION   = "Destruction"
HEALBOT_BLOOD         = "Sang"
HEALBOT_UNHOLY        = "Impie"

HEALBOT_OPTIONS_VISIBLERANGE = "D\195\169sactiver la barre si au-del\195\160 de 100m"
HEALBOT_OPTIONS_NOTIFY_HEAL_MSG  = "Message de soin"
HEALBOT_OPTIONS_NOTIFY_OTHER_MSG = "Autre Message"
HEALBOT_WORDS_YOU                = "vous";
HEALBOT_NOTIFYHEALMSG            = "Incante #s pour soigner #n de #h pv";
HEALBOT_NOTIFYOTHERMSG           = "Incante #s sur #n";

HEALBOT_OPTIONS_HOTPOSITION     = "Position ic\195\180ne"
HEALBOT_OPTIONS_HOTSHOWTEXT     = "Texte de l\'ic\195\180ne"
HEALBOT_OPTIONS_HOTTEXTCOUNT    = "D\195\169compte"
HEALBOT_OPTIONS_HOTTEXTDURATION = "Dur\195\169e"
HEALBOT_OPTIONS_ICONSCALE       = "Echelle de l\'ic\195\180ne"
HEALBOT_OPTIONS_ICONTEXTSCALE   = "Echelle du texte de l\'ic\195\180ne"

HEALBOT_SKIN_FLUID              = "Fluide"
HEALBOT_SKIN_VIVID              = "Vif"
HEALBOT_SKIN_LIGHT              = "Lumi\195\168re"
HEALBOT_SKIN_SQUARE             = "Carr\195\169"
HEALBOT_OPTIONS_AGGROBARSIZE    = "Taille de la barre d\'aggro"
HEALBOT_OPTIONS_TARGETBARMODE   = "Limiter la barre de cible aux r\195\169glages pr\195\169d\195\169finis"
HEALBOT_OPTIONS_DOUBLETEXTLINES = "Texte sur deux lignes"
HEALBOT_OPTIONS_TEXTALIGNMENT   = "Alignement du texte"
HEALBOT_OPTIONS_ENABLELIBQH     = "Activer HealBot fastHealth"
HEALBOT_VEHICLE                 = "V\195\169hicules"
HEALBOT_OPTIONS_UNIQUESPEC      = "Enreg. des sorts en fonction de la sp\195\169cialisation"
HEALBOT_WORDS_ERROR             = "Erreur"
HEALBOT_SPELL_NOT_FOUND	        = "Sort pas trouv\195\169"
HEALBOT_OPTIONS_DISABLETOOLTIPINCOMBAT = "Cacher les infos durant les combats"

HEALBOT_OPTIONS_BUFFNAMED       = "Nom du joueur \195\160 surveiller\n\n"
HEALBOT_WORD_ALWAYS             = "Toujours";
HEALBOT_WORD_SOLO               = "En solo";
HEALBOT_WORD_NEVER              = "Jamais";
HEALBOT_SHOW_CLASS_AS_ICON      = "Ic\195\180ne";
HEALBOT_SHOW_CLASS_AS_TEXT      = "Texte";

HEALBOT_SHOW_INCHEALS           = "Montrer les soins entrants";
HEALBOT_D_DURATION              = "Dur\195\169e des sorts directs ";
HEALBOT_H_DURATION              = "Dur\195\169e des HoT ";
HEALBOT_C_DURATION 				= "Dur\195\169e des sorts canalis\195\169s ";

HEALBOT_HELP={ 
    [1] = "[HealBot] /hb h -- Afficher l\'aide",
    [2] = "[HealBot] /hb o -- Bascule options",
    [3] = "[HealBot] /hb ri -- R\195\160Z HealBot",
    [4] = "[HealBot] /hb t -- Bascule Healbot activ\195\169/d\195\169sactiv\195\169",
    [5] = "[HealBot] /hb bt -- Bascule moniteur de Buffs activ\195\169/d\195\169sactiv\195\169", 
    [6] = "[HealBot] /hb dt -- Bascule moniteur de D\195\169buffs activ\195\169/d\195\169sactiv\195\169",
    [7] = "[HealBot] /hb skin <skinName> -- Changer de Skin",
    [8] = "[HealBot] /hb hs -- Afficher les commandes slash suppl\195\169mentaires",
}

HEALBOT_HELP2={ 
    [1] = "[HealBot] /hb d -- R\195\160Z des options",
    [2] = "[HealBot] /hb ui -- Recharger UI (reloadui)",
    [3] = "[HealBot] /hb ri -- R\195\160Z HealBot",
    [4] = "[HealBot] /hb tr <Role> -- D\195\169termine le r\195\180le prioritaire pour le sous-tri par r\195\180le. Les r\195\180les valides sont 'TANK', 'HEALER' ou 'DPS'",
    [5] = "[HealBot] /hb use10 -- Utilisation auto. du slot 10 d\'ing\195\169nieur",
    [6] = "[HealBot] /hb pcs <n> -- Ajuste la taille de l\indicateur de charge de Puissance Sacr\195\169e \195\160 <n>, valeur par d\195\169faut : 7 ",
    [7] = "[HealBot] /hb info -- Afficher la fen\195\170tre d\'information",
    [8] = "[HealBot] /hb spt -- Bascule Self Pet",
    [9] = "[HealBot] /hb ws -- Bascule l\'affichage de l\'ic\195\180ne d\'Ame affaiblie au lieu de MdP : Bouclier avec un -",
    [10] = "[HealBot] /hb flb -- Toggle frame lock bypass (frame always moves with Ctrl+Alt+Left click)",
    [11] = "[HealBot] /hb rtb -- Bascule restriction barre de cible sur bt gauche=SmartCast et bt droit=ajouter/enlever de 'Mes cibles'",
}
              
HEALBOT_OPTION_HIGHLIGHTACTIVEBAR   = "Surbrillance au mouseover"
HEALBOT_OPTION_HIGHLIGHTTARGETBAR   = "Surbrillance cible"
HEALBOT_OPTIONS_TESTBARS            = "Barres de test"
HEALBOT_OPTION_NUMBARS              = "Nombre de barres"
HEALBOT_OPTION_NUMTANKS             = "Nombre de tanks"
HEALBOT_OPTION_NUMMYTARGETS         = "Nombre de cibles"
HEALBOT_OPTION_NUMPETS              = "Nombre de familiers"
HEALBOT_WORD_TEST                   = "Test";
HEALBOT_WORD_OFF                    = "Off";
HEALBOT_WORD_ON                     = "On";

HEALBOT_OPTIONS_TAB_PROTECTION          = "Protection"
HEALBOT_OPTIONS_TAB_CHAT            = "Chat"
HEALBOT_OPTIONS_TAB_HEADERS         = "En-t\195\170tes"
HEALBOT_OPTIONS_TAB_BARS            = "Barres"
HEALBOT_OPTIONS_TAB_ICONS           = "Ic\195\180nes"
HEALBOT_OPTIONS_TAB_WARNING             = "Attention"
HEALBOT_OPTIONS_SKINDEFAULTFOR      = "Skin par d\195\169faut pour"
HEALBOT_OPTIONS_INCHEAL             = "Heals entrants"
HEALBOT_WORD_ARENA                  = "Ar\195\170ne"
HEALBOT_WORD_BATTLEGROUND           = "Champ de bataille"
HEALBOT_OPTIONS_TEXTOPTIONS         = "Options de texte"
HEALBOT_WORD_PARTY                  = "Groupe"
HEALBOT_OPTIONS_COMBOAUTOTARGET     = "Cible Auto"
HEALBOT_OPTIONS_COMBOAUTOTRINKET    = "Trinket Auto"
HEALBOT_OPTIONS_GROUPSPERCOLUMN     = "Groupes (en-t\195\170tes) par colonne"

HEALBOT_OPTIONS_MAINSORT            = "Cl\195\169 principale"
HEALBOT_OPTIONS_SUBSORT             = "Cl\195\169 secondaire"
HEALBOT_OPTIONS_SUBSORTINC          = "Trier par cl\195\169 sec. :"

HEALBOT_OPTIONS_BUTTONCASTMETHOD    = "Incanter quand"
HEALBOT_OPTIONS_BUTTONCASTPRESSED   = "press\195\169"
HEALBOT_OPTIONS_BUTTONCASTRELEASED  = "relach\195\169"

HEALBOT_INFO_INCHEALINFO            = "== Informations sur les heal entrants =="
HEALBOT_INFO_ADDONCPUUSAGE          = "== Utilisation CPU en sec. =="
HEALBOT_INFO_ADDONCOMMUSAGE         = "== Comm. des addons =="
HEALBOT_WORD_HEALER                 = "Healer"
HEALBOT_WORD_VERSION                = "Version"
HEALBOT_WORD_CLIENT                 = "Client"
HEALBOT_WORD_ADDON                  = "Addon"
HEALBOT_INFO_CPUSECS                = "CPU Sec."
HEALBOT_INFO_MEMORYKB               = "M\195\169moire Ko"
HEALBOT_INFO_COMMS                  = "Comm. Ko"

HEALBOT_WORD_STAR                   = "\195\169toile"
HEALBOT_WORD_CIRCLE                 = "cercle"
HEALBOT_WORD_DIAMOND                = "diamant"
HEALBOT_WORD_TRIANGLE               = "triangle"
HEALBOT_WORD_MOON                   = "lune"
HEALBOT_WORD_SQUARE                 = "carr\195\169"
HEALBOT_WORD_CROSS                  = "croix"
HEALBOT_WORD_SKULL                  = "cr\195\162ne"

HEALBOT_OPTIONS_ACCEPTSKINMSG       = "Accepter skin [HealBot] : "
HEALBOT_OPTIONS_ACCEPTSKINMSGFROM   = " de "
HEALBOT_OPTIONS_BUTTONSHARESKIN     = "Partager avec"

HEALBOT_CHAT_ADDONID                = "[HealBot]  "
HEALBOT_CHAT_NEWVERSION1            = "Une version plus r\195\169cente est disponible"
HEALBOT_CHAT_NEWVERSION2            = "sur http://healbot.alturl.com"
HEALBOT_CHAT_SHARESKINERR1          = " Skin pas trouv\195\169e pour le partage"
HEALBOT_CHAT_SHARESKINERR3          = " pas trouv\195\169e pour le partage de skin"
HEALBOT_CHAT_SHARESKINACPT          = "Partage de skin accept\195\169 de "
HEALBOT_CHAT_CONFIRMSKINDEFAULTS    = "Skins par d\195\169faut"
HEALBOT_CHAT_CONFIRMCUSTOMDEFAULTS  = "RaZ Debuffs personnalis\195\169s"
HEALBOT_CHAT_CHANGESKINERR1         = "Skin inconnu: /hb skin "
HEALBOT_CHAT_CHANGESKINERR2         = "Skins valides:  "
HEALBOT_CHAT_CONFIRMSPELLCOPY       = "Sort actuel copi\195\169 pour toutes les sp\195\169."
HEALBOT_CHAT_UNKNOWNCMD             = "Commande slash inconnue: /hb "
HEALBOT_CHAT_ENABLED                = "Entr\195\169e en mode combat"
HEALBOT_CHAT_DISABLED               = "Entr\195\169e en mode hors combat"
HEALBOT_CHAT_SOFTRELOAD             = "Reload healbot demand\195\169"
HEALBOT_CHAT_HARDRELOAD             = "Reload UI demand\195\169"
HEALBOT_CHAT_CONFIRMSPELLRESET      = "RaZ des sorts"
HEALBOT_CHAT_CONFIRMCURESRESET      = "RaZ des gu\195\169risons"
HEALBOT_CHAT_CONFIRMBUFFSRESET      = "RaZ des buffs"
HEALBOT_CHAT_POSSIBLEMISSINGMEDIA   = "Impossible de recevoir les r\195\169glages de Skin - Possible absence de SharedMedia, voir HealBot/Docs/readme.html pour les liens"
HEALBOT_CHAT_MACROSOUNDON           = "Son pas supprim\195\169 \195\160 l\'utilisation auto d\'un trinket"
HEALBOT_CHAT_MACROSOUNDOFF          = "Son supprim\195\169 \195\160 l\'utilisation auto d\'un trinket"
HEALBOT_CHAT_MACROERRORON           = "Erreurs pas supprim\195\169es \195\160 l\'utilisation auto d\'un trinket"
HEALBOT_CHAT_MACROERROROFF          = "Erreurs supprim\195\169es \195\160 l\'utilisation auto d\'un trinket"
HEALBOT_CHAT_TITANON                = "Titan panel - MaJ on"
HEALBOT_CHAT_TITANOFF               = "Titan panel - MaJ off"
HEALBOT_CHAT_ACCEPTSKINON           = "Partage de skin actif - Afficher une fen\195\170tre de confirmation avant d'accepter un skin"
HEALBOT_CHAT_ACCEPTSKINOFF          = "Partage de Skin inactif - Ignorer les propositions de skin"
HEALBOT_CHAT_USE10ON                = "Trinket auto - Use10 est actif - Vous devez activer un auto trinket existant pour que use10 fonctionne"
HEALBOT_CHAT_USE10OFF               = "Trinket auto - Use10 est inactif"
HEALBOT_CHAT_SKINREC                = " skin re\195\167u de "

HEALBOT_OPTIONS_SELFCASTS           = "Seulement mes sorts"
HEALBOT_OPTIONS_HOTSHOWICON         = "Afficher ic\195\180ne"
HEALBOT_OPTIONS_ALLSPELLS           = "Tous les sorts"
HEALBOT_OPTIONS_DOUBLEROW           = "Sur deux lignes"
HEALBOT_OPTIONS_HOTBELOWBAR         = "Sous la barre"
HEALBOT_OPTIONS_OTHERSPELLS         = "Autres sorts"
HEALBOT_WORD_MACROS                 = "Macros"
HEALBOT_WORD_SELECT                 = "S\195\169lection"
HEALBOT_OPTIONS_QUESTION            = "?"
HEALBOT_WORD_CANCEL                 = "Annuler"
HEALBOT_WORD_COMMANDS               = "Commandes"
HEALBOT_OPTIONS_BARHEALTH3          = "pv totaux";
HEALBOT_SORTBY_ROLE                 = "R\195\180le"
HEALBOT_WORD_DPS                    = "DPS"
HEALBOT_CHAT_TOPROLEERR             = " r\195\180le non valide - utiliser 'TANK', 'DPS' ou 'HEALER'"
HEALBOT_CHAT_NEWTOPROLE             = "Le r\195\180le prioritaire est "
HEALBOT_CHAT_SUBSORTPLAYER1         = "Joueur en premier dans le sous-tri"
HEALBOT_CHAT_SUBSORTPLAYER2         = "Joueur tri\195\169 avec les autres"
HEALBOT_OPTIONS_SHOWREADYCHECK      = "Afficher l\'appel Raid";
HEALBOT_OPTIONS_SUBSORTSELFFIRST    = "Soi en premier"
HEALBOT_WORD_FILTER                 = "Filtre"
HEALBOT_OPTION_AGGROPCTBAR          = "Bouger la barre" ---- ??????????????????
HEALBOT_OPTION_AGGROPCTTXT          = "Aff. texte"
HEALBOT_OPTION_AGGROPCTTRACK        = "Suivre pourcent."
HEALBOT_OPTIONS_ALERTAGGROLEVEL1    = "1 - Menace basse"
HEALBOT_OPTIONS_ALERTAGGROLEVEL2    = "2 - Menace haute"
HEALBOT_OPTIONS_ALERTAGGROLEVEL3    = "3 - Tanking"
HEALBOT_OPTIONS_AGGROALERT          = "Barre : niveau d\'alerte"
HEALBOT_OPTIONS_TOOLTIPSHOWHOT      = "Montrer les d\195\169tails des HoT suivis"
HEALBOT_WORDS_MIN                   = "min"
HEALBOT_WORDS_MAX                   = "max"
HEALBOT_WORDS_R                     = "R"
HEALBOT_WORDS_G                     = "G"
HEALBOT_WORDS_B                     = "B"
HEALBOT_CHAT_SELFPETSON             = "Auto Pet activ\195\169"
HEALBOT_CHAT_SELFPETSOFF            = "Auto Pet d\195\169sactiv\195\169"
HEALBOT_WORD_PRIORITY               = "Priorit\195\169"
HEALBOT_VISIBLE_RANGE               = "Dans les 100 yards"
HEALBOT_SPELL_RANGE                 = "A port\195\169e de sorts"
HEALBOT_CUSTOM_CATEGORY                 = "Cat\195\169gorie"
HEALBOT_CUSTOM_CAT_CUSTOM               = "Personnalis\195\169"
HEALBOT_CUSTOM_CAT_CLASSIC              = "Classique"
HEALBOT_CUSTOM_CAT_TBC_OTHER            = "BC - Autre"
HEALBOT_CUSTOM_CAT_TBC_BT               = "BC - Le temple noir"
HEALBOT_CUSTOM_CAT_TBC_SUNWELL          = "BC - Plateau du Puits de Soleil"
HEALBOT_CUSTOM_CAT_LK_OTHER             = "WotLK - Autre"
HEALBOT_CUSTOM_CAT_LK_ULDUAR            = "WotLK - Ulduar"
HEALBOT_CUSTOM_CAT_LK_TOC               = "WotLK - L\'Epreuve du crois\195\169"
HEALBOT_CUSTOM_CAT_LK_ICC_LOWER         = "WotLK - ICC L\'entr\195\169e de la citadelle"
HEALBOT_CUSTOM_CAT_LK_ICC_PLAGUEWORKS   = "WotLK - ICC La pesterie"
HEALBOT_CUSTOM_CAT_LK_ICC_CRIMSON       = "WotLK - ICC La salle cramoisie"
HEALBOT_CUSTOM_CAT_LK_ICC_FROSTWING     = "WotLK - ICC L\'aile de givre"
HEALBOT_CUSTOM_CAT_LK_ICC_THRONE        = "WotLK - ICC Le tr\195\180ne de glace"
HEALBOT_CUSTOM_CAT_LK_RS_THRONE         = "WotLK - Sanctum Rubis"
HEALBOT_CUSTOM_CAT_CATA_OTHER           = "Cata - Autre"
HEALBOT_CUSTOM_CAT_CATA_PARTY           = "Cata - Groupe"
HEALBOT_CUSTOM_CAT_CATA_RAID            = "Cata - Raid"
HEALBOT_WORD_RESET                  = "R\195\160Z"
HEALBOT_HBMENU                      = "menuHB"
HEALBOT_ACTION_HBFOCUS              = "Bouton gauche\npour focus la cible"
HEALBOT_WORD_CLEAR                  = "Effacer"
HEALBOT_WORD_SET                    = "R\195\169gler"
HEALBOT_WORD_HBFOCUS                = "Focus HealBot"
HEALBOT_WORD_OUTSIDE                    = "En ext\195\169rieur"
HEALBOT_WORD_ALLZONE                    = "Toutes les zones"
HEALBOT_WORD_OTHER                      = "Autre"
HEALBOT_OPTIONS_TAB_ALERT           = "Alerte"
HEALBOT_OPTIONS_TAB_SORT            = "Tri"
HEALBOT_OPTIONS_TAB_AGGRO           = "Aggro"
HEALBOT_OPTIONS_TAB_ICONTEXT        = "Aff. ic\195\180nes"
HEALBOT_OPTIONS_TAB_TEXT            = "Aff. barres"
HEALBOT_OPTIONS_AGGRO3COL           = "Barre d\'Aggror\ncouleur"
HEALBOT_OPTIONS_AGGROFLASHFREQ      = "Fr\195\169quence flash"
HEALBOT_OPTIONS_AGGROFLASHALPHA     = "Opacit\195\169 flash"
HEALBOT_OPTIONS_SHOWDURATIONFROM    = "Montrer la dur\195\169e de"
HEALBOT_OPTIONS_SHOWDURATIONWARN    = "Dur\195\169e de l\'alerte de"
HEALBOT_CMD_RESETCUSTOMDEBUFFS      = "R\195\160Z d\195\169buffs personnalis\195\169s"
HEALBOT_CMD_RESETSKINS              = "R\195\160Z skins"
HEALBOT_CMD_CLEARBLACKLIST          = "Effacer blackList"
HEALBOT_CMD_TOGGLEACCEPTSKINS       = "Bascule accepter Skins des autres"
HEALBOT_CMD_COPYSPELLS              = "Copier les sorts pour toutes les sp\195\169cialisations"
HEALBOT_CMD_RESETSPELLS             = "R\195\160Z sorts"
HEALBOT_CMD_RESETCURES              = "R\195\160Z gu\195\169risons"
HEALBOT_CMD_RESETBUFFS              = "R\195\160Z buffs"
HEALBOT_CMD_RESETBARS               = "R\195\160Z position des barres"
HEALBOT_CMD_TOGGLETITAN             = "Bascule M\195\160J Titan"
HEALBOT_CMD_SUPPRESSSOUND           = "Bascule son pour trinket auto"
HEALBOT_CMD_SUPPRESSERRORS          = "Bascule messages d\'erreurs pour trinket auto"
HEALBOT_OPTIONS_COMMANDS            = "Commandes HealBot"
HEALBOT_WORD_RUN                    = "Ex\195\169cuter"
HEALBOT_OPTIONS_MOUSEWHEEL          = "Utiliser la roue de souris"
HEALBOT_OPTIONS_MOUSEUP             = "Vers le haut"
HEALBOT_OPTIONS_MOUSEDOWN           = "Vers le bas"
HEALBOT_CMD_DELCUSTOMDEBUFF10       = "Effacer les d\195\169buffs personnalis\195\169s de priorit\195\169 10"
HEALBOT_ACCEPTSKINS                 = "Accepter les Skins des autres joueurs"
HEALBOT_SUPPRESSSOUND               = "Auto Trinket : Supprimer le son"
HEALBOT_SUPPRESSERROR               = "Auto Trinket : Supprimer les erreurs"
HEALBOT_OPTIONS_CRASHPROT           = "Protection anti-Crash"
HEALBOT_CP_MACRO_LEN                = "Le nom de la macro doit avoir 1 \195\160 14 caract\195\168res"
HEALBOT_CP_MACRO_BASE               = "hbMacro"
HEALBOT_CP_MACRO_SAVE               = "Derni\195\168re sauvegarde: "
HEALBOT_CP_STARTTIME                = "Dur\195\169e de la protection \195\160 la connexion"
HEALBOT_WORD_RESERVED               = "R\195\169serv\195\169"
HEALBOT_OPTIONS_COMBATPROT          = "Protection en combat "
HEALBOT_COMBATPROT_PARTYNO          = "barres r\195\169serv\195\169es pour le groupe"
HEALBOT_COMBATPROT_RAIDNO           = "barres r\195\169serv\195\169es pour le raid"

HEALBOT_WORD_HEALTH                     = "Vie"
HEALBOT_OPTIONS_DONT_SHOW               = "Ne pas montrer"
HEALBOT_OPTIONS_SAME_AS_HLTH_CURRENT    = "Comme la vie (vie actuelle)"
HEALBOT_OPTIONS_SAME_AS_HLTH_FUTURE     = "Comme la vie (vie \195\160 venir)"
HEALBOT_OPTIONS_FUTURE_HLTH             = "Vie \195\160 venir"
HEALBOT_SKIN_HEALTHBARCOL_TEXT          = "Couleur de la barre de vie";
HEALBOT_SKIN_INCHEALBARCOL_TEXT         = "Couleur des soins entrants";
HEALBOT_OPTIONS_ALWAYS_SHOW_TARGET      = "Cible: Toujours montrer"
HEALBOT_OPTIONS_ALWAYS_SHOW_FOCUS       = "Focus: Toujours montrer"
HEALBOT_OPTIONS_GROUP_PETS_BY_FIVE      = "Familiers : Groupes de cinq"
HEALBOT_OPTIONS_USEGAMETOOLTIP          = "Utiliser le tooltip du jeu"
HEALBOT_OPTIONS_SHOWPOWERCOUNTER 		= "Afficher le compteur de puissance"
HEALBOT_OPTIONS_SHOWPOWERCOUNTER_PALA 	= "Afficher la puissance sacr\195\169e"

HEALBOT_BLIZZARD_MENU                   = "Menu Blizzard"
HEALBOT_HB_MENU                         = "Menu Healbot"
HEALBOT_FOLLOW                          = "Suivre"
HEALBOT_TRADE                           = "Echanger"
HEALBOT_PROMOTE_RA                      = "Nommer assistant raid"
HEALBOT_DEMOTE_RA                       = "D\195\169grader"
HEALBOT_TOGGLE_ENABLED                  = "Bascule \'activ\195\169s\'"
HEALBOT_TOGGLE_MYTARGETS                = "Bascule \'Mes cibles\'"
HEALBOT_TOGGLE_PRIVATETANKS             = "Bascule \'Tanks perso.\'"
HEALBOT_RESET_BAR                       = "R\195\160Z barres"
HEALBOT_HIDE_BARS                       = "Cacher les barres si au del\195\160 de 100 m"

HEALBOT_RANDOMMOUNT                     = "Monture al\195\169atoire"
HEALBOT_RANDOMGOUNDMOUNT                = "Monture terrestre al\195\169atoire"
HEALBOT_RANDOMPET                       = "Mascotte al\195\169atoire"
HEALBOT_ZONE_AQ40                       = "Ahn\'Qiraj"
HEALBOT_ZONE_THEOCULUS                  = "L\'Oculus"
HEALBOT_RESLAG_INDICATOR                = "Dur\195\169e d\'affichage du nom en vert apr\195\168s rez"
HEALBOT_RESLAG_INDICATOR_ERROR          = "Dur\195\169e d\'affichage du nom en vert apr\195\168s rez entre 1 et 30"
HEALBOT_FRAMELOCK_BYPASS_OFF            = "Bouger le cadre malgr\195\169 le verrouillage : inactif"
HEALBOT_FRAMELOCK_BYPASS_OFF            = "Bouger le cadre malgr\195\169 le verrouillage : actif  (Ctl+Alt+Gauche)"
HEALBOT_RESTRICTTARGETBAR_ON            = "Restriction barre de cible Active"
HEALBOT_RESTRICTTARGETBAR_OFF           = "Restriction barre de cible Inactive"
HEALBOT_PRELOADOPTIONS_ON               = "Pr\195\169chargement des options actif"
HEALBOT_PRELOADOPTIONS_OFF              = "Pr\195\169chargement des options inactif"
HEALBOT_OPTIONS_CUSTOMDEBUFF_REVDUR     = "Dur\195\169e invers\195\169e"
HEALBOT_OPTIONS_DISABLEHEALBOTSOLO      = "seulement en solo"

HEALBOT_OPTIONS_AGGROINDALERT           = "Indicateur de niveau d\'alerte"
HEALBOT_OPTION_AGGROIND                 = "Indicateur"
HEALBOT_AGGRO2_ERROR_MSG                = "Pour r\195\169gler le niveau 2 d\'aggro, le pourcentage de menace doit \195\170tre entre 25 et 95"
HEALBOT_AGGRO3_ERROR_MSG                = "Pour r\195\169gler le niveau 3 d\'aggro, le pourcentage de menace doit \195\170tre entre 75 et 100"
HEALBOT_AGGRO2_SET_MSG                  = "Pourcentage de menace du niveau 2 d\'aggro r\195\169gl\195\169 sur "
HEALBOT_AGGRO3_SET_MSG                  = "Pourcentage de menace du niveau 3 d\'aggro r\195\169gl\195\169 sur "
HEALBOT_WORD_THREAT                     = "Menace"
HEALBOT_AGGRO_ERROR_MSG                 = "Niveau d\'aggro non valable - utiliser 2 ou 3"

HEALBOT_OPTIONS_QUERYTALENTS            = "Requ\195\170te infos talent"       
HEALBOT_OPTIONS_LOWMANAINDICATOR        = "Indicateur de Mana faible"
HEALBOT_OPTIONS_LOWMANAINDICATOR1       = "Ne pas afficher"
HEALBOT_OPTIONS_LOWMANAINDICATOR2       = "*10% / **20% / ***30%"
HEALBOT_OPTIONS_LOWMANAINDICATOR3       = "*15% / **30% / ***45%"
HEALBOT_OPTIONS_LOWMANAINDICATOR4       = "*20% / **40% / ***60%"
HEALBOT_OPTIONS_LOWMANAINDICATOR5       = "*25% / **50% / ***75%"
HEALBOT_OPTIONS_LOWMANAINDICATOR6       = "*30% / **60% / ***90%"

HEALBOT_OPTION_IGNORE_AURA_RESTED       = "Ignorer les  Buffs/D\195\169buffs... pendant le repos"

HEALBOT_WORD_ENABLE                     = "Activer"
HEALBOT_WORD_DISABLE                    = "D\195\169sactiver"

end
