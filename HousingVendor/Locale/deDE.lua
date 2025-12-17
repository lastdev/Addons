-- German (Germany) Localization
if not HousingVendorLocales then
    HousingVendorLocales = {}
end

local L = {}

-- Main UI Strings
L["HOUSING_VENDOR_TITLE"] = "Wohnungsdekoration Standorte"
L["HOUSING_VENDOR_SUBTITLE"] = "Durchsuchen Sie alle Wohnungsdekorationen von Verkäufern in ganz Azeroth"

-- Filter Labels
L["FILTER_SEARCH"] = "Suche:"
L["FILTER_EXPANSION"] = "Erweiterung:"
L["FILTER_VENDOR"] = "Verkäufer:"
L["FILTER_ZONE"] = "Zone:"
L["FILTER_TYPE"] = "Typ:"
L["FILTER_CATEGORY"] = "Kategorie:"
L["FILTER_FACTION"] = "Fraktion:"
L["FILTER_SOURCE"] = "Quelle:"
L["FILTER_PROFESSION"] = "Beruf:"
L["FILTER_CLEAR"] = "Filter löschen"
L["FILTER_ALL_EXPANSIONS"] = "Alle Erweiterungen"
L["FILTER_ALL_VENDORS"] = "Alle Verkäufer"
L["FILTER_ALL_ZONES"] = "Alle Zonen"
L["FILTER_ALL_TYPES"] = "Alle Typen"
L["FILTER_ALL_CATEGORIES"] = "Alle Kategorien"
L["FILTER_ALL_SOURCES"] = "Alle Quellen"
L["FILTER_ALL_FACTIONS"] = "Alle Fraktionen"

-- Column Headers
L["COLUMN_ITEM"] = "Gegenstand"
L["COLUMN_ITEM_NAME"] = "Gegenstandsname"
L["COLUMN_SOURCE"] = "Quelle"
L["COLUMN_LOCATION"] = "Standort"
L["COLUMN_PRICE"] = "Preis"
L["COLUMN_COST"] = "Kosten"
L["COLUMN_VENDOR"] = "Verkäufer"
L["COLUMN_TYPE"] = "Typ"

-- Buttons
L["BUTTON_SETTINGS"] = "Einstellungen"
L["BUTTON_STATISTICS"] = "Statistiken"
L["BUTTON_BACK"] = "Zurück"
L["BUTTON_CLOSE"] = "Schließen"
L["BUTTON_WAYPOINT"] = "Wegpunkt festlegen"
L["BUTTON_SAVE"] = "Speichern"
L["BUTTON_RESET"] = "Zurücksetzen"

-- Settings Panel
L["SETTINGS_TITLE"] = "Wohnungs Addon Einstellungen"
L["SETTINGS_GENERAL_TAB"] = "Allgemein"
L["SETTINGS_COMMUNITY_TAB"] = "Gemeinschaft"
L["SETTINGS_MINIMAP_SECTION"] = "Minikarten Symbol"
L["SETTINGS_SHOW_MINIMAP_BUTTON"] = "Minikarten Symbol anzeigen"
L["SETTINGS_UI_SCALE_SECTION"] = "UI Skalierung"
L["SETTINGS_UI_SCALE"] = "UI Skalierung"
L["SETTINGS_FONT_SIZE"] = "Schriftgröße"
L["SETTINGS_RESET"] = "Zurücksetzen"
L["SETTINGS_RESET_DEFAULTS"] = "Auf Standard zurücksetzen"
L["SETTINGS_PROGRESS_TRACKING"] = "Fortschrittsverfolgung"
L["SETTINGS_SHOW_COLLECTED"] = "Gesammelte Gegenstände anzeigen"
L["SETTINGS_WAYPOINT_NAVIGATION"] = "Wegpunkt Navigation"
L["SETTINGS_USE_PORTAL_NAVIGATION"] = "Intelligente Portalnavigation verwenden"

-- Tooltips
L["TOOLTIP_SETTINGS"] = "Einstellungen"
L["TOOLTIP_SETTINGS_DESC"] = "Addon Optionen konfigurieren"
L["TOOLTIP_WAYPOINT"] = "Wegpunkt festlegen"
L["TOOLTIP_WAYPOINT_DESC"] = "Zu diesem Verkäufer navigieren"
L["TOOLTIP_PORTAL_NAVIGATION_ENABLED"] = "Intelligente Portalnavigation aktiviert"
L["TOOLTIP_PORTAL_NAVIGATION_DESC"] = "Verwendet automatisch das nächstgelegene Portal beim Wechsel zwischen Zonen"
L["TOOLTIP_DIRECT_NAVIGATION"] = "Direkte Navigation aktiviert"
L["TOOLTIP_DIRECT_NAVIGATION_DESC"] = "Wegpunkte zeigen direkt zu den Verkäuferstandorten (nicht empfohlen für die Navigation zwischen Zonen)"

-- Info Panel Tooltips
L["TOOLTIP_INFO_EXPANSION"] = "Die World of Warcraft-Erweiterung, aus der dieser Gegenstand stammt"
L["TOOLTIP_INFO_FACTION"] = "Welche Fraktion kann diesen Gegenstand beim Verkäufer kaufen"
L["TOOLTIP_INFO_VENDOR"] = "NPC-Verkäufer, der diesen Gegenstand verkauft"
L["TOOLTIP_INFO_VENDOR_WITH_COORDS"] = "NPC-Verkäufer, der diesen Gegenstand verkauft\n\nOrt: %s\nKoordinaten: %s"
L["TOOLTIP_INFO_ZONE"] = "Zone, in der sich dieser Verkäufer befindet"
L["TOOLTIP_INFO_ZONE_WITH_COORDS"] = "Zone, in der sich dieser Verkäufer befindet\n\nKoordinaten: %s"
L["TOOLTIP_INFO_REPUTATION"] = "Rufanforderung zum Kauf dieses Gegenstands beim Verkäufer"
L["TOOLTIP_INFO_RENOWN"] = "Erforderliche Ruhmesstufe bei einer Hauptfraktion, um diesen Gegenstand freizuschalten"
L["TOOLTIP_INFO_PROFESSION"] = "Der Beruf, der zum Herstellen dieses Gegenstands erforderlich ist"
L["TOOLTIP_INFO_PROFESSION_SKILL"] = "Erforderliche Fertigkeitsstufe in diesem Beruf, um den Gegenstand herzustellen"
L["TOOLTIP_INFO_PROFESSION_RECIPE"] = "Das Rezept oder Muster zum Herstellen dieses Gegenstands"
L["TOOLTIP_INFO_EVENT"] = "Besonderes Ereignis oder Feiertag, an dem dieser Gegenstand verfügbar ist"
L["TOOLTIP_INFO_CLASS"] = "Dieser Gegenstand kann nur von dieser Klasse verwendet werden"
L["TOOLTIP_INFO_RACE"] = "Dieser Gegenstand kann nur von diesem Volk verwendet werden"

-- Messages
L["MESSAGE_PORTAL_NAV_ENABLED"] = "Intelligente Portalnavigation aktiviert. Wegpunkte verwenden automatisch das nächstgelegene Portal beim Wechsel zwischen Zonen."
L["MESSAGE_DIRECT_NAV_ENABLED"] = "Direkte Navigation aktiviert. Wegpunkte zeigen direkt zu den Verkäuferstandorten (nicht empfohlen für die Navigation zwischen Zonen)."

-- Community Section
L["COMMUNITY_TITLE"] = "Gemeinschaft & Unterstützung"
L["COMMUNITY_INFO"] = "Treten Sie unserer Gemeinschaft bei, um Tipps auszutauschen, Fehler zu melden und neue Funktionen vorzuschlagen!"
L["COMMUNITY_DISCORD"] = "Discord Server"
L["COMMUNITY_GITHUB"] = "GitHub"
L["COMMUNITY_REPORT_BUG"] = "Fehler melden"
L["COMMUNITY_SUGGEST_FEATURE"] = "Funktion vorschlagen"

-- Preview Panel
L["PREVIEW_TITLE"] = "Gegenstandsvorschau"
L["PREVIEW_NO_SELECTION"] = "Wählen Sie einen Gegenstand aus, um Details anzuzeigen"

-- Status Bar
L["STATUS_ITEMS_DISPLAYED"] = "%d Gegenstände angezeigt (%d insgesamt)"

-- Errors
L["ERROR_ADDON_NOT_INITIALIZED"] = "Wohnungs Addon nicht initialisiert"
L["ERROR_UI_NOT_AVAILABLE"] = "HousingVendor Benutzeroberfläche nicht verfügbar"
L["ERROR_CONFIG_PANEL_NOT_AVAILABLE"] = "Konfigurationsfenster nicht verfügbar"

-- Statistics UI
L["STATS_TITLE"] = "Statistik-Dashboard"
L["STATS_COLLECTION_PROGRESS"] = "Sammlungsfortschritt"
L["STATS_ITEMS_BY_SOURCE"] = "Gegenstände nach Quelle"
L["STATS_ITEMS_BY_FACTION"] = "Gegenstände nach Fraktion"
L["STATS_COLLECTION_BY_EXPANSION"] = "Sammlung nach Erweiterung"
L["STATS_COLLECTION_BY_CATEGORY"] = "Sammlung nach Kategorie"
L["STATS_COMPLETE"] = "%d%% Abgeschlossen - %d / %d Gegenstände gesammelt"

-- Footer
L["FOOTER_COLOR_GUIDE"] = "Farbenlegende:"
L["FOOTER_WAYPOINT_INSTRUCTION"] = "Klicken Sie auf einen Gegenstand mit %s, um einen Wegpunkt festzulegen"

-- Main UI
L["MAIN_SUBTITLE"] = "Wohnungskatalog"

-- Common Strings
L["COMMON_FREE"] = "Kostenlos"
L["COMMON_UNKNOWN"] = "Unbekannt"
L["COMMON_NA"] = "N/V"
L["COMMON_GOLD"] = "Gold"
L["COMMON_ITEM_ID"] = "Gegenstands-ID:"

-- Miscellaneous
L["MINIMAP_TOOLTIP"] = "Wohnungsverkäufer Browser"
L["MINIMAP_TOOLTIP_DESC"] = "Linksklick zum Umschalten des Wohnungsverkäufer Browsers"

-- Expansion Names
L["EXPANSION_CLASSIC"] = "Classic"
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
L["EXPANSION_MIDNIGHT"] = "Midnight"

-- Faction Names
L["FACTION_ALLIANCE"] = "Allianz"
L["FACTION_HORDE"] = "Horde"
L["FACTION_NEUTRAL"] = "Neutral"

-- Source Types
L["SOURCE_VENDOR"] = "Verkäufer"
L["SOURCE_ACHIEVEMENT"] = "Erfolg"
L["SOURCE_QUEST"] = "Quest"
L["SOURCE_DROP"] = "Beute"
L["SOURCE_PROFESSION"] = "Beruf"
L["SOURCE_REPUTATION"] = "Ruf"

-- Quality Names
L["QUALITY_POOR"] = "Schlecht"
L["QUALITY_COMMON"] = "Gewöhnlich"
L["QUALITY_UNCOMMON"] = "Ungewöhnlich"
L["QUALITY_RARE"] = "Selten"
L["QUALITY_EPIC"] = "Episch"
L["QUALITY_LEGENDARY"] = "Legendär"

-- Collection Status
L["COLLECTION_COLLECTED"] = "Gesammelt"
L["COLLECTION_UNCOLLECTED"] = "Nicht gesammelt"

-- Requirement Types
L["REQUIREMENT_NONE"] = "Keine"
L["REQUIREMENT_ACHIEVEMENT"] = "Erfolg"
L["REQUIREMENT_QUEST"] = "Quest"
L["REQUIREMENT_REPUTATION"] = "Ruf"
L["REQUIREMENT_RENOWN"] = "Ruhm"
L["REQUIREMENT_PROFESSION"] = "Beruf"

-- Common Category/Type Names
L["CATEGORY_FURNITURE"] = "Möbel"
L["CATEGORY_DECORATIONS"] = "Dekorationen"
L["CATEGORY_LIGHTING"] = "Beleuchtung"
L["CATEGORY_PLACEABLES"] = "Platzierbar"
L["CATEGORY_ACCESSORIES"] = "Accessoires"
L["CATEGORY_RUGS"] = "Teppiche"
L["CATEGORY_PLANTS"] = "Pflanzen"
L["CATEGORY_PAINTINGS"] = "Gemälde"
L["CATEGORY_BANNERS"] = "Banner"
L["CATEGORY_BOOKS"] = "Bücher"
L["CATEGORY_FOOD"] = "Essen"
L["CATEGORY_TOYS"] = "Spielzeug"

-- Type Names
L["TYPE_CHAIR"] = "Stuhl"
L["TYPE_TABLE"] = "Tisch"
L["TYPE_BED"] = "Bett"
L["TYPE_LAMP"] = "Lampe"
L["TYPE_CANDLE"] = "Kerze"
L["TYPE_RUG"] = "Teppich"
L["TYPE_PAINTING"] = "Gemälde"
L["TYPE_BANNER"] = "Banner"
L["TYPE_PLANT"] = "Pflanze"
L["TYPE_BOOKSHELF"] = "Bücherregal"
L["TYPE_CHEST"] = "Truhe"
L["TYPE_WEAPON_RACK"] = "Waffenständer"

-- Filter Options
L["FILTER_HIDE_VISITED"] = "Besuchte ausblenden"
L["FILTER_ALL_QUALITIES"] = "Alle Qualitäten"
L["FILTER_ALL_REQUIREMENTS"] = "Alle Anforderungen"

-- UI Theme Names
L["THEME_MIDNIGHT"] = "Mitternacht"
L["THEME_ALLIANCE"] = "Allianz"
L["THEME_HORDE"] = "Horde"
L["THEME_SLEEK_BLACK"] = "Elegantes Schwarz"
L["SETTINGS_UI_THEME"] = "UI-Design"

-- Make the locale table globally available
HousingVendorLocales["deDE"] = L