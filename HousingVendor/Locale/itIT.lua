-- Italian Localization
if not HousingVendorLocales then
    HousingVendorLocales = {}
end

local L = {}

-- Main UI Strings
L["HOUSING_VENDOR_TITLE"] = "Posizioni delle Decorazioni dell'Abitazione"
L["HOUSING_VENDOR_SUBTITLE"] = "Sfoglia tutte le decorazioni dell'abitazione dei venditori in tutta Azeroth"

-- Filter Labels
L["FILTER_SEARCH"] = "Ricerca:"
L["FILTER_EXPANSION"] = "Espansione:"
L["FILTER_VENDOR"] = "Venditore:"
L["FILTER_ZONE"] = "Zona:"
L["FILTER_TYPE"] = "Tipo:"
L["FILTER_CATEGORY"] = "Categoria:"
L["FILTER_FACTION"] = "Fazione:"
L["FILTER_SOURCE"] = "Fonte:"
L["FILTER_PROFESSION"] = "Professione:"
L["FILTER_CLEAR"] = "Cancella Filtri"
L["FILTER_ALL_EXPANSIONS"] = "Tutte le Espansioni"
L["FILTER_ALL_VENDORS"] = "Tutti i Venditori"
L["FILTER_ALL_ZONES"] = "Tutte le Zone"
L["FILTER_ALL_TYPES"] = "Tutti i Tipi"
L["FILTER_ALL_CATEGORIES"] = "Tutte le Categorie"
L["FILTER_ALL_SOURCES"] = "Tutte le Fonti"
L["FILTER_ALL_FACTIONS"] = "Tutte le Fazioni"

-- Column Headers
L["COLUMN_ITEM"] = "Oggetto"
L["COLUMN_ITEM_NAME"] = "Nome Oggetto"
L["COLUMN_SOURCE"] = "Fonte"
L["COLUMN_LOCATION"] = "Posizione"
L["COLUMN_PRICE"] = "Prezzo"
L["COLUMN_COST"] = "Costo"
L["COLUMN_VENDOR"] = "Venditore"
L["COLUMN_TYPE"] = "Tipo"

-- Buttons
L["BUTTON_SETTINGS"] = "Impostazioni"
L["BUTTON_STATISTICS"] = "Statistiche"
L["BUTTON_BACK"] = "Indietro"
L["BUTTON_CLOSE"] = "Chiudi"
L["BUTTON_WAYPOINT"] = "Imposta Punto di Riferimento"
L["BUTTON_SAVE"] = "Salva"
L["BUTTON_RESET"] = "Reimposta"

-- Settings Panel
L["SETTINGS_TITLE"] = "Impostazioni dell'Addon dell'Abitazione"
L["SETTINGS_GENERAL_TAB"] = "Generale"
L["SETTINGS_COMMUNITY_TAB"] = "Comunità"
L["SETTINGS_MINIMAP_SECTION"] = "Pulsante della Minimappa"
L["SETTINGS_SHOW_MINIMAP_BUTTON"] = "Mostra Pulsante della Minimappa"
L["SETTINGS_UI_SCALE_SECTION"] = "Scala dell'Interfaccia"
L["SETTINGS_UI_SCALE"] = "Scala dell'Interfaccia"
L["SETTINGS_FONT_SIZE"] = "Dimensione Carattere"
L["SETTINGS_RESET"] = "Reimposta"
L["SETTINGS_RESET_DEFAULTS"] = "Reimposta ai Predefiniti"
L["SETTINGS_PROGRESS_TRACKING"] = "Tracciamento dei Progressi"
L["SETTINGS_SHOW_COLLECTED"] = "Mostra Oggetti Raccolti"
L["SETTINGS_WAYPOINT_NAVIGATION"] = "Navigazione tramite Punti di Riferimento"
L["SETTINGS_USE_PORTAL_NAVIGATION"] = "Usa Navigazione Intelligente tramite Portali"

-- Tooltips
L["TOOLTIP_SETTINGS"] = "Impostazioni"
L["TOOLTIP_SETTINGS_DESC"] = "Configura le opzioni dell'addon"
L["TOOLTIP_WAYPOINT"] = "Imposta Punto di Riferimento"
L["TOOLTIP_WAYPOINT_DESC"] = "Naviga verso questo venditore"
L["TOOLTIP_PORTAL_NAVIGATION_ENABLED"] = "Navigazione Intelligente tramite Portali Abilitata"
L["TOOLTIP_PORTAL_NAVIGATION_DESC"] = "Userà automaticamente il portale più vicino quando si attraversano le zone"
L["TOOLTIP_DIRECT_NAVIGATION"] = "Navigazione diretta abilitata"
L["TOOLTIP_DIRECT_NAVIGATION_DESC"] = "I punti di riferimento punteranno direttamente alle posizioni dei venditori (non consigliato per i viaggi tra zone)"

-- Info Panel Tooltips
L["TOOLTIP_INFO_EXPANSION"] = "L'espansione di World of Warcraft da cui proviene questo oggetto"
L["TOOLTIP_INFO_FACTION"] = "Quale fazione può acquistare questo oggetto dal venditore"
L["TOOLTIP_INFO_VENDOR"] = "Venditore PNG che vende questo oggetto"
L["TOOLTIP_INFO_VENDOR_WITH_COORDS"] = "Venditore PNG che vende questo oggetto\n\nPosizione: %s\nCoordinate: %s"
L["TOOLTIP_INFO_ZONE"] = "Zona in cui si trova questo venditore"
L["TOOLTIP_INFO_ZONE_WITH_COORDS"] = "Zona in cui si trova questo venditore\n\nCoordinate: %s"
L["TOOLTIP_INFO_REPUTATION"] = "Requisito di reputazione per acquistare questo oggetto dal venditore"
L["TOOLTIP_INFO_RENOWN"] = "Livello di fama richiesto con una fazione principale per sbloccare questo oggetto"
L["TOOLTIP_INFO_PROFESSION"] = "La professione richiesta per creare questo oggetto"
L["TOOLTIP_INFO_PROFESSION_SKILL"] = "Livello di abilità richiesto in questa professione per creare l'oggetto"
L["TOOLTIP_INFO_PROFESSION_RECIPE"] = "Il nome della ricetta o schema per creare questo oggetto"
L["TOOLTIP_INFO_EVENT"] = "Evento speciale o festività in cui questo oggetto è disponibile"
L["TOOLTIP_INFO_CLASS"] = "Questo oggetto può essere usato solo da questa classe"
L["TOOLTIP_INFO_RACE"] = "Questo oggetto può essere usato solo da questa razza"

-- Messages
L["MESSAGE_PORTAL_NAV_ENABLED"] = "Navigazione intelligente tramite portali abilitata. I punti di riferimento useranno automaticamente il portale più vicino quando si attraversano le zone."
L["MESSAGE_DIRECT_NAV_ENABLED"] = "Navigazione diretta abilitata. I punti di riferimento punteranno direttamente alle posizioni dei venditori (non consigliato per i viaggi tra zone)."

-- Community Section
L["COMMUNITY_TITLE"] = "Comunità e Supporto"
L["COMMUNITY_INFO"] = "Unisciti alla nostra comunità per condividere consigli, segnalare bug e suggerire nuove funzionalità!"
L["COMMUNITY_DISCORD"] = "Server Discord"
L["COMMUNITY_GITHUB"] = "GitHub"
L["COMMUNITY_REPORT_BUG"] = "Segnala Bug"
L["COMMUNITY_SUGGEST_FEATURE"] = "Suggerisci Funzionalità"

-- Preview Panel
L["PREVIEW_TITLE"] = "Anteprima Oggetto"
L["PREVIEW_NO_SELECTION"] = "Seleziona un oggetto per visualizzare i dettagli"

-- Status Bar
L["STATUS_ITEMS_DISPLAYED"] = "%d oggetti visualizzati (%d totali)"

-- Errors
L["ERROR_ADDON_NOT_INITIALIZED"] = "Addon dell'abitazione non inizializzato"
L["ERROR_UI_NOT_AVAILABLE"] = "Interfaccia utente di HousingVendor non disponibile"
L["ERROR_CONFIG_PANEL_NOT_AVAILABLE"] = "Pannello di configurazione non disponibile"

-- Statistics UI
L["STATS_TITLE"] = "Dashboard Statistiche"
L["STATS_COLLECTION_PROGRESS"] = "Progresso Collezione"
L["STATS_ITEMS_BY_SOURCE"] = "Oggetti per Fonte"
L["STATS_ITEMS_BY_FACTION"] = "Oggetti per Fazione"
L["STATS_COLLECTION_BY_EXPANSION"] = "Collezione per Espansione"
L["STATS_COLLECTION_BY_CATEGORY"] = "Collezione per Categoria"
L["STATS_COMPLETE"] = "%d%% Completato - %d / %d oggetti raccolti"

-- Footer
L["FOOTER_COLOR_GUIDE"] = "Guida Colori:"
L["FOOTER_WAYPOINT_INSTRUCTION"] = "Clicca su un oggetto con %s per impostare un punto di riferimento"

-- Main UI
L["MAIN_SUBTITLE"] = "Catalogo Abitazione"

-- Common Strings
L["COMMON_FREE"] = "Gratis"
L["COMMON_UNKNOWN"] = "Sconosciuto"
L["COMMON_NA"] = "N/D"
L["COMMON_GOLD"] = "oro"
L["COMMON_ITEM_ID"] = "ID Oggetto:"

-- Miscellaneous
L["MINIMAP_TOOLTIP"] = "Browser dei Venditori dell'Abitazione"
L["MINIMAP_TOOLTIP_DESC"] = "Clic sinistro per attivare/disattivare il browser dei venditori dell'abitazione"

-- Expansion Names
L["EXPANSION_CLASSIC"] = "Classico"
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
L["EXPANSION_MIDNIGHT"] = "Mezzanotte"

-- Faction Names
L["FACTION_ALLIANCE"] = "Alleanza"
L["FACTION_HORDE"] = "Orda"
L["FACTION_NEUTRAL"] = "Neutrale"

-- Source Types
L["SOURCE_VENDOR"] = "Venditore"
L["SOURCE_ACHIEVEMENT"] = "Impresa"
L["SOURCE_QUEST"] = "Missione"
L["SOURCE_DROP"] = "Bottino"
L["SOURCE_PROFESSION"] = "Professione"
L["SOURCE_REPUTATION"] = "Reputazione"

-- Quality Names
L["QUALITY_POOR"] = "Scadente"
L["QUALITY_COMMON"] = "Comune"
L["QUALITY_UNCOMMON"] = "Non comune"
L["QUALITY_RARE"] = "Raro"
L["QUALITY_EPIC"] = "Epico"
L["QUALITY_LEGENDARY"] = "Leggendario"

-- Collection Status
L["COLLECTION_COLLECTED"] = "Raccolto"
L["COLLECTION_UNCOLLECTED"] = "Non raccolto"

-- Requirement Types
L["REQUIREMENT_NONE"] = "Nessuno"
L["REQUIREMENT_ACHIEVEMENT"] = "Impresa"
L["REQUIREMENT_QUEST"] = "Missione"
L["REQUIREMENT_REPUTATION"] = "Reputazione"
L["REQUIREMENT_RENOWN"] = "Fama"
L["REQUIREMENT_PROFESSION"] = "Professione"

-- Common Category/Type Names
L["CATEGORY_FURNITURE"] = "Mobili"
L["CATEGORY_DECORATIONS"] = "Decorazioni"
L["CATEGORY_LIGHTING"] = "Illuminazione"
L["CATEGORY_PLACEABLES"] = "Posizionabili"
L["CATEGORY_ACCESSORIES"] = "Accessori"
L["CATEGORY_RUGS"] = "Tappeti"
L["CATEGORY_PLANTS"] = "Piante"
L["CATEGORY_PAINTINGS"] = "Dipinti"
L["CATEGORY_BANNERS"] = "Stendardi"
L["CATEGORY_BOOKS"] = "Libri"
L["CATEGORY_FOOD"] = "Cibo"
L["CATEGORY_TOYS"] = "Giocattoli"

-- Type Names
L["TYPE_CHAIR"] = "Sedia"
L["TYPE_TABLE"] = "Tavolo"
L["TYPE_BED"] = "Letto"
L["TYPE_LAMP"] = "Lampada"
L["TYPE_CANDLE"] = "Candela"
L["TYPE_RUG"] = "Tappeto"
L["TYPE_PAINTING"] = "Dipinto"
L["TYPE_BANNER"] = "Stendardo"
L["TYPE_PLANT"] = "Pianta"
L["TYPE_BOOKSHELF"] = "Libreria"
L["TYPE_CHEST"] = "Cassa"
L["TYPE_WEAPON_RACK"] = "Rastrelliera per armi"

-- Filter Options
L["FILTER_HIDE_VISITED"] = "Nascondi visitati"
L["FILTER_ALL_QUALITIES"] = "Tutte le qualità"
L["FILTER_ALL_REQUIREMENTS"] = "Tutti i requisiti"

-- UI Theme Names
L["THEME_MIDNIGHT"] = "Mezzanotte"
L["THEME_ALLIANCE"] = "Alleanza"
L["THEME_HORDE"] = "Orda"
L["THEME_SLEEK_BLACK"] = "Nero elegante"
L["SETTINGS_UI_THEME"] = "Tema interfaccia"

-- Make the locale table globally available
HousingVendorLocales["itIT"] = L