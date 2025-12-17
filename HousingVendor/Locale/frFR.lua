-- Localization for HousingVendor addon - French (France)
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
L["BUTTON_BACK"] = "← Retour"
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

-- Make the locale table globally available
_G["HousingVendorLocale"] = L