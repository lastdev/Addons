-- French (France) Localization
if not HousingVendorLocales then
    HousingVendorLocales = {}
end

local L = {}

-- Main UI Strings
L["HOUSING_VENDOR_TITLE"] = "Emplacements des décorations d'hôtel"
L["HOUSING_VENDOR_SUBTITLE"] = "Parcourir toutes les décorations d'hôtel des vendeurs à travers Azeroth"

-- Filter Labels
L["FILTER_SEARCH"] = "Recherche:"
L["FILTER_EXPANSION"] = "Extension:"
L["FILTER_VENDOR"] = "Vendeur:"
L["FILTER_ZONE"] = "Zone:"
L["FILTER_TYPE"] = "Type:"
L["FILTER_CATEGORY"] = "Catégorie:"
L["FILTER_FACTION"] = "Faction:"
L["FILTER_SOURCE"] = "Source:"
L["FILTER_PROFESSION"] = "Métier:"
L["FILTER_CLEAR"] = "Effacer les filtres"
L["FILTER_ALL_EXPANSIONS"] = "Toutes les extensions"
L["FILTER_ALL_VENDORS"] = "Tous les vendeurs"
L["FILTER_ALL_ZONES"] = "Toutes les zones"
L["FILTER_ALL_TYPES"] = "Tous les types"
L["FILTER_ALL_CATEGORIES"] = "Toutes les catégories"
L["FILTER_ALL_SOURCES"] = "Toutes les sources"
L["FILTER_ALL_FACTIONS"] = "Toutes les factions"

-- Column Headers
L["COLUMN_ITEM"] = "Objet"
L["COLUMN_ITEM_NAME"] = "Nom de l'objet"
L["COLUMN_SOURCE"] = "Source"
L["COLUMN_LOCATION"] = "Emplacement"
L["COLUMN_PRICE"] = "Prix"
L["COLUMN_COST"] = "Coût"
L["COLUMN_VENDOR"] = "Vendeur"
L["COLUMN_TYPE"] = "Type"

-- Buttons
L["BUTTON_SETTINGS"] = "Paramètres"
L["BUTTON_STATISTICS"] = "Statistiques"
L["BUTTON_BACK"] = "Retour"
L["BUTTON_CLOSE"] = "Fermer"
L["BUTTON_WAYPOINT"] = "Définir un point de repère"
L["BUTTON_SAVE"] = "Enregistrer"
L["BUTTON_RESET"] = "Réinitialiser"

-- Settings Panel
L["SETTINGS_TITLE"] = "Paramètres de l'addon d'hôtel"
L["SETTINGS_GENERAL_TAB"] = "Général"
L["SETTINGS_COMMUNITY_TAB"] = "Communauté"
L["SETTINGS_MINIMAP_SECTION"] = "Bouton de la minicarte"
L["SETTINGS_SHOW_MINIMAP_BUTTON"] = "Afficher le bouton de la minicarte"
L["SETTINGS_UI_SCALE_SECTION"] = "Échelle de l'interface"
L["SETTINGS_UI_SCALE"] = "Échelle de l'interface"
L["SETTINGS_FONT_SIZE"] = "Taille de la police"
L["SETTINGS_RESET"] = "Réinitialiser"
L["SETTINGS_RESET_DEFAULTS"] = "Réinitialiser aux valeurs par défaut"
L["SETTINGS_PROGRESS_TRACKING"] = "Suivi des progrès"
L["SETTINGS_SHOW_COLLECTED"] = "Afficher les objets collectés"
L["SETTINGS_WAYPOINT_NAVIGATION"] = "Navigation par points de repère"
L["SETTINGS_USE_PORTAL_NAVIGATION"] = "Utiliser la navigation intelligente par portail"

-- Tooltips
L["TOOLTIP_SETTINGS"] = "Paramètres"
L["TOOLTIP_SETTINGS_DESC"] = "Configurer les options de l'addon"
L["TOOLTIP_WAYPOINT"] = "Définir un point de repère"
L["TOOLTIP_WAYPOINT_DESC"] = "Naviguer vers ce vendeur"
L["TOOLTIP_PORTAL_NAVIGATION_ENABLED"] = "Navigation intelligente par portail activée"
L["TOOLTIP_PORTAL_NAVIGATION_DESC"] = "Utilisera automatiquement le portail le plus proche lors du franchissement des zones"
L["TOOLTIP_DIRECT_NAVIGATION"] = "Navigation directe activée"
L["TOOLTIP_DIRECT_NAVIGATION_DESC"] = "Les points de repère pointeront directement vers les emplacements des vendeurs (non recommandé pour les déplacements entre zones)"

-- Info Panel Tooltips
L["TOOLTIP_INFO_EXPANSION"] = "L'extension World of Warcraft dont provient cet objet"
L["TOOLTIP_INFO_FACTION"] = "Quelle faction peut acheter cet objet auprès du vendeur"
L["TOOLTIP_INFO_VENDOR"] = "Vendeur PNJ qui vend cet objet"
L["TOOLTIP_INFO_VENDOR_WITH_COORDS"] = "Vendeur PNJ qui vend cet objet\n\nEmplacement: %s\nCoordonnées: %s"
L["TOOLTIP_INFO_ZONE"] = "Zone où se trouve ce vendeur"
L["TOOLTIP_INFO_ZONE_WITH_COORDS"] = "Zone où se trouve ce vendeur\n\nCoordonnées: %s"
L["TOOLTIP_INFO_REPUTATION"] = "Exigence de réputation pour acheter cet objet auprès du vendeur"
L["TOOLTIP_INFO_RENOWN"] = "Niveau de renom requis auprès d'une faction majeure pour débloquer cet objet"
L["TOOLTIP_INFO_PROFESSION"] = "La profession requise pour fabriquer cet objet"
L["TOOLTIP_INFO_PROFESSION_SKILL"] = "Niveau de compétence requis dans cette profession pour fabriquer l'objet"
L["TOOLTIP_INFO_PROFESSION_RECIPE"] = "Le nom de la recette ou du patron pour fabriquer cet objet"
L["TOOLTIP_INFO_EVENT"] = "Événement spécial ou fête pendant lequel cet objet est disponible"
L["TOOLTIP_INFO_CLASS"] = "Cet objet ne peut être utilisé que par cette classe"
L["TOOLTIP_INFO_RACE"] = "Cet objet ne peut être utilisé que par cette race"

-- Messages
L["MESSAGE_PORTAL_NAV_ENABLED"] = "Navigation intelligente par portail activée. Les points de repère utiliseront automatiquement le portail le plus proche lors du franchissement des zones."
L["MESSAGE_DIRECT_NAV_ENABLED"] = "Navigation directe activée. Les points de repère pointeront directement vers les emplacements des vendeurs (non recommandé pour les déplacements entre zones)."

-- Community Section
L["COMMUNITY_TITLE"] = "Communauté et assistance"
L["COMMUNITY_INFO"] = "Rejoignez notre communauté pour partager des astuces, signaler des bogues et suggérer de nouvelles fonctionnalités!"
L["COMMUNITY_DISCORD"] = "Serveur Discord"
L["COMMUNITY_GITHUB"] = "GitHub"
L["COMMUNITY_REPORT_BUG"] = "Signaler un bogue"
L["COMMUNITY_SUGGEST_FEATURE"] = "Suggérer une fonctionnalité"

-- Preview Panel
L["PREVIEW_TITLE"] = "Aperçu de l'objet"
L["PREVIEW_NO_SELECTION"] = "Sélectionnez un objet pour afficher les détails"

-- Status Bar
L["STATUS_ITEMS_DISPLAYED"] = "%d objets affichés (%d au total)"

-- Errors
L["ERROR_ADDON_NOT_INITIALIZED"] = "Addon d'hôtel non initialisé"
L["ERROR_UI_NOT_AVAILABLE"] = "Interface utilisateur de HousingVendor non disponible"
L["ERROR_CONFIG_PANEL_NOT_AVAILABLE"] = "Panneau de configuration non disponible"

-- Statistics UI
L["STATS_TITLE"] = "Tableau de bord des statistiques"
L["STATS_COLLECTION_PROGRESS"] = "Progression de la collection"
L["STATS_ITEMS_BY_SOURCE"] = "Objets par source"
L["STATS_ITEMS_BY_FACTION"] = "Objets par faction"
L["STATS_COLLECTION_BY_EXPANSION"] = "Collection par extension"
L["STATS_COLLECTION_BY_CATEGORY"] = "Collection par catégorie"
L["STATS_COMPLETE"] = "%d%% Terminé - %d / %d objets collectés"

-- Footer
L["FOOTER_COLOR_GUIDE"] = "Guide des couleurs:"
L["FOOTER_WAYPOINT_INSTRUCTION"] = "Cliquez sur un objet avec %s pour définir un point de repère"

-- Main UI
L["MAIN_SUBTITLE"] = "Catalogue d'hôtel"

-- Common Strings
L["COMMON_FREE"] = "Gratuit"
L["COMMON_UNKNOWN"] = "Inconnu"
L["COMMON_NA"] = "N/D"
L["COMMON_GOLD"] = "or"
L["COMMON_ITEM_ID"] = "ID de l'objet:"

-- Miscellaneous
L["MINIMAP_TOOLTIP"] = "Navigateur de vendeurs d'hôtel"
L["MINIMAP_TOOLTIP_DESC"] = "Clic gauche pour basculer le navigateur de vendeurs d'hôtel"

-- Expansion Names
L["EXPANSION_CLASSIC"] = "Classique"
L["EXPANSION_THEBURNINGCRUSADE"] = "The Burning Crusade"
L["EXPANSION_WRATHOFTHELLICHKING"] = "Wrath of the Lich King"
L["EXPANSION_CATACLYSM"] = "Cataclysm"
L["EXPANSION_MISTSOFPANDARIA"] = "Mists of Pandaria"
L["EXPANSION_WARLORDSOF DRAENOR"] = "Warlords of Draenor"
L["EXPANSION_LEGION"] = "Legion"
L["EXPANSION_BATTLEFORAZEROTH"] = "Battle for Azeroth"
L["EXPANSION_SHADOWLANDS"] = "Shadowlands"
L["EXPANSION_DRAGONFLIGHT"] = "Dragonflight"
L["EXPANSION_THEWARWITHIN"] = "The War Within"
L["EXPANSION_MIDNIGHT"] = "Minuit"

-- Faction Names
L["FACTION_ALLIANCE"] = "Alliance"
L["FACTION_HORDE"] = "Horde"
L["FACTION_NEUTRAL"] = "Neutre"

-- Source Types
L["SOURCE_VENDOR"] = "Vendeur"
L["SOURCE_ACHIEVEMENT"] = "Haut fait"
L["SOURCE_QUEST"] = "Quête"
L["SOURCE_DROP"] = "Butin"
L["SOURCE_PROFESSION"] = "Métier"
L["SOURCE_REPUTATION"] = "Réputation"

-- Quality Names
L["QUALITY_POOR"] = "Médiocre"
L["QUALITY_COMMON"] = "Commun"
L["QUALITY_UNCOMMON"] = "Peu commun"
L["QUALITY_RARE"] = "Rare"
L["QUALITY_EPIC"] = "Épique"
L["QUALITY_LEGENDARY"] = "Légendaire"

-- Collection Status
L["COLLECTION_COLLECTED"] = "Collecté"
L["COLLECTION_UNCOLLECTED"] = "Non collecté"

-- Requirement Types
L["REQUIREMENT_NONE"] = "Aucun"
L["REQUIREMENT_ACHIEVEMENT"] = "Haut fait"
L["REQUIREMENT_QUEST"] = "Quête"
L["REQUIREMENT_REPUTATION"] = "Réputation"
L["REQUIREMENT_RENOWN"] = "Renom"
L["REQUIREMENT_PROFESSION"] = "Métier"

-- Common Category/Type Names
L["CATEGORY_FURNITURE"] = "Mobilier"
L["CATEGORY_DECORATIONS"] = "Décorations"
L["CATEGORY_LIGHTING"] = "Éclairage"
L["CATEGORY_PLACEABLES"] = "Plaçables"
L["CATEGORY_ACCESSORIES"] = "Accessoires"
L["CATEGORY_RUGS"] = "Tapis"
L["CATEGORY_PLANTS"] = "Plantes"
L["CATEGORY_PAINTINGS"] = "Peintures"
L["CATEGORY_BANNERS"] = "Bannières"
L["CATEGORY_BOOKS"] = "Livres"
L["CATEGORY_FOOD"] = "Nourriture"
L["CATEGORY_TOYS"] = "Jouets"

-- Type Names
L["TYPE_CHAIR"] = "Chaise"
L["TYPE_TABLE"] = "Table"
L["TYPE_BED"] = "Lit"
L["TYPE_LAMP"] = "Lampe"
L["TYPE_CANDLE"] = "Bougie"
L["TYPE_RUG"] = "Tapis"
L["TYPE_PAINTING"] = "Peinture"
L["TYPE_BANNER"] = "Bannière"
L["TYPE_PLANT"] = "Plante"
L["TYPE_BOOKSHELF"] = "Bibliothèque"
L["TYPE_CHEST"] = "Coffre"
L["TYPE_WEAPON_RACK"] = "Râtelier d'armes"

-- Filter Options
L["FILTER_HIDE_VISITED"] = "Masquer visités"
L["FILTER_ALL_QUALITIES"] = "Toutes les qualités"
L["FILTER_ALL_REQUIREMENTS"] = "Toutes les exigences"

-- UI Theme Names
L["THEME_MIDNIGHT"] = "Minuit"
L["THEME_ALLIANCE"] = "Alliance"
L["THEME_HORDE"] = "Horde"
L["THEME_SLEEK_BLACK"] = "Noir élégant"
L["SETTINGS_UI_THEME"] = "Thème de l'interface"

-- Make the locale table globally available
HousingVendorLocales["frFR"] = L