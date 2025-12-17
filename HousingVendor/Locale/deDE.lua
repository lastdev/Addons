-- Localization for HousingVendor addon - German (Germany)
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
L["BUTTON_BACK"] = "← Zurück"
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

-- Make the locale table globally available
_G["HousingVendorLocale"] = L