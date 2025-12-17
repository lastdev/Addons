-- Spanish (Mexico/Latin America) Localization
if not HousingVendorLocales then
    HousingVendorLocales = {}
end

local L = {}

-- Main UI Strings
L["HOUSING_VENDOR_TITLE"] = "Ubicaciones de Decoración de Viviendas"
L["HOUSING_VENDOR_SUBTITLE"] = "Explora todas las decoraciones de viviendas de los vendedores en toda Azeroth"

-- Filter Labels
L["FILTER_SEARCH"] = "Buscar:"
L["FILTER_EXPANSION"] = "Expansión:"
L["FILTER_VENDOR"] = "Vendedor:"
L["FILTER_ZONE"] = "Zona:"
L["FILTER_TYPE"] = "Tipo:"
L["FILTER_CATEGORY"] = "Categoría:"
L["FILTER_FACTION"] = "Facción:"
L["FILTER_SOURCE"] = "Fuente:"
L["FILTER_PROFESSION"] = "Profesión:"
L["FILTER_CLEAR"] = "Limpiar filtros"
L["FILTER_ALL_EXPANSIONS"] = "Todas las expansiones"
L["FILTER_ALL_VENDORS"] = "Todos los vendedores"
L["FILTER_ALL_ZONES"] = "Todas las zonas"
L["FILTER_ALL_TYPES"] = "Todos los tipos"
L["FILTER_ALL_CATEGORIES"] = "Todas las categorías"
L["FILTER_ALL_SOURCES"] = "Todas las fuentes"
L["FILTER_ALL_FACTIONS"] = "Todas las facciones"

-- Column Headers
L["COLUMN_ITEM"] = "Objeto"
L["COLUMN_ITEM_NAME"] = "Nombre del objeto"
L["COLUMN_SOURCE"] = "Fuente"
L["COLUMN_LOCATION"] = "Ubicación"
L["COLUMN_PRICE"] = "Precio"
L["COLUMN_COST"] = "Costo"
L["COLUMN_VENDOR"] = "Vendedor"
L["COLUMN_TYPE"] = "Tipo"

-- Buttons
L["BUTTON_SETTINGS"] = "Configuración"
L["BUTTON_STATISTICS"] = "Estadísticas"
L["BUTTON_BACK"] = "Atrás"
L["BUTTON_CLOSE"] = "Cerrar"
L["BUTTON_WAYPOINT"] = "Establecer punto de ruta"
L["BUTTON_SAVE"] = "Guardar"
L["BUTTON_RESET"] = "Restablecer"

-- Settings Panel
L["SETTINGS_TITLE"] = "Configuración del complemento de vivienda"
L["SETTINGS_GENERAL_TAB"] = "General"
L["SETTINGS_COMMUNITY_TAB"] = "Comunidad"
L["SETTINGS_MINIMAP_SECTION"] = "Botón del minimapa"
L["SETTINGS_SHOW_MINIMAP_BUTTON"] = "Mostrar botón del minimapa"
L["SETTINGS_UI_SCALE_SECTION"] = "Escala de interfaz"
L["SETTINGS_UI_SCALE"] = "Escala de interfaz"
L["SETTINGS_FONT_SIZE"] = "Tamaño de fuente"
L["SETTINGS_RESET"] = "Restablecer"
L["SETTINGS_RESET_DEFAULTS"] = "Restablecer valores predeterminados"
L["SETTINGS_PROGRESS_TRACKING"] = "Seguimiento de progreso"
L["SETTINGS_SHOW_COLLECTED"] = "Mostrar objetos coleccionados"
L["SETTINGS_WAYPOINT_NAVIGATION"] = "Navegación por puntos de ruta"
L["SETTINGS_USE_PORTAL_NAVIGATION"] = "Usar navegación inteligente por portal"

-- Tooltips
L["TOOLTIP_SETTINGS"] = "Configuración"
L["TOOLTIP_SETTINGS_DESC"] = "Configurar opciones del complemento"
L["TOOLTIP_WAYPOINT"] = "Establecer punto de ruta"
L["TOOLTIP_WAYPOINT_DESC"] = "Navegar a este vendedor"
L["TOOLTIP_PORTAL_NAVIGATION_ENABLED"] = "Navegación inteligente por portal habilitada"
L["TOOLTIP_PORTAL_NAVIGATION_DESC"] = "Usará automáticamente el portal más cercano al cambiar entre zonas"
L["TOOLTIP_DIRECT_NAVIGATION"] = "Navegación directa habilitada"
L["TOOLTIP_DIRECT_NAVIGATION_DESC"] = "Los puntos de ruta apuntarán directamente a las ubicaciones de los vendedores (no recomendado para viajes entre zonas)"

-- Info Panel Tooltips
L["TOOLTIP_INFO_EXPANSION"] = "La expansión de World of Warcraft de la que proviene este objeto"
L["TOOLTIP_INFO_FACTION"] = "Qué facción puede comprar este objeto del vendedor"
L["TOOLTIP_INFO_VENDOR"] = "Vendedor PNJ que vende este objeto"
L["TOOLTIP_INFO_VENDOR_WITH_COORDS"] = "Vendedor PNJ que vende este objeto\n\nUbicación: %s\nCoordenadas: %s"
L["TOOLTIP_INFO_ZONE"] = "Zona donde se encuentra este vendedor"
L["TOOLTIP_INFO_ZONE_WITH_COORDS"] = "Zona donde se encuentra este vendedor\n\nCoordenadas: %s"
L["TOOLTIP_INFO_REPUTATION"] = "Requisito de reputación para comprar este objeto del vendedor"
L["TOOLTIP_INFO_RENOWN"] = "Nivel de renombre requerido con una facción principal para desbloquear este objeto"
L["TOOLTIP_INFO_PROFESSION"] = "La profesión requerida para fabricar este objeto"
L["TOOLTIP_INFO_PROFESSION_SKILL"] = "Nivel de habilidad requerido en esta profesión para fabricar el objeto"
L["TOOLTIP_INFO_PROFESSION_RECIPE"] = "El nombre de la receta o patrón para fabricar este objeto"
L["TOOLTIP_INFO_EVENT"] = "Evento especial o festividad cuando este objeto está disponible"
L["TOOLTIP_INFO_CLASS"] = "Este objeto solo puede ser usado por esta clase"
L["TOOLTIP_INFO_RACE"] = "Este objeto solo puede ser usado por esta raza"

-- Messages
L["MESSAGE_PORTAL_NAV_ENABLED"] = "Navegación inteligente por portal habilitada. Los puntos de ruta usarán automáticamente el portal más cercano al cambiar entre zonas."
L["MESSAGE_DIRECT_NAV_ENABLED"] = "Navegación directa habilitada. Los puntos de ruta apuntarán directamente a las ubicaciones de los vendedores (no recomendado para viajes entre zonas)."

-- Community Section
L["COMMUNITY_TITLE"] = "Comunidad y Soporte"
L["COMMUNITY_INFO"] = "¡Únete a nuestra comunidad para compartir consejos, informar errores y sugerir nuevas funciones!"
L["COMMUNITY_DISCORD"] = "Servidor de Discord"
L["COMMUNITY_GITHUB"] = "GitHub"
L["COMMUNITY_REPORT_BUG"] = "Informar error"
L["COMMUNITY_SUGGEST_FEATURE"] = "Sugerir función"

-- Preview Panel
L["PREVIEW_TITLE"] = "Vista previa del objeto"
L["PREVIEW_NO_SELECTION"] = "Selecciona un objeto para ver detalles"

-- Status Bar
L["STATUS_ITEMS_DISPLAYED"] = "%d objetos mostrados (%d en total)"

-- Errors
L["ERROR_ADDON_NOT_INITIALIZED"] = "Complemento de vivienda no inicializado"
L["ERROR_UI_NOT_AVAILABLE"] = "Interfaz de HousingVendor no disponible"
L["ERROR_CONFIG_PANEL_NOT_AVAILABLE"] = "Panel de configuración no disponible"

-- Statistics UI
L["STATS_TITLE"] = "Panel de estadísticas"
L["STATS_COLLECTION_PROGRESS"] = "Progreso de la colección"
L["STATS_ITEMS_BY_SOURCE"] = "Objetos por fuente"
L["STATS_ITEMS_BY_FACTION"] = "Objetos por facción"
L["STATS_COLLECTION_BY_EXPANSION"] = "Colección por expansión"
L["STATS_COLLECTION_BY_CATEGORY"] = "Colección por categoría"
L["STATS_COMPLETE"] = "%d%% Completado - %d / %d objetos coleccionados"

-- Footer
L["FOOTER_COLOR_GUIDE"] = "Guía de colores:"
L["FOOTER_WAYPOINT_INSTRUCTION"] = "Haz clic en un objeto con %s para establecer un punto de ruta"

-- Main UI
L["MAIN_SUBTITLE"] = "Catálogo de vivienda"

-- Common Strings
L["COMMON_FREE"] = "Gratis"
L["COMMON_UNKNOWN"] = "Desconocido"
L["COMMON_NA"] = "N/D"
L["COMMON_GOLD"] = "oro"
L["COMMON_ITEM_ID"] = "ID del objeto:"

-- Miscellaneous
L["MINIMAP_TOOLTIP"] = "Explorador de vendedores de vivienda"
L["MINIMAP_TOOLTIP_DESC"] = "Haz clic izquierdo para alternar el explorador de vendedores de vivienda"

-- Expansion Names
L["EXPANSION_CLASSIC"] = "Clásico"
L["EXPANSION_THEBURNINGCRUSADE"] = "La Cruzada Ardiente"
L["EXPANSION_WRATHOFTHELLICHKING"] = "Ira del Rey Exánime"
L["EXPANSION_CATACLYSM"] = "Cataclismo"
L["EXPANSION_MISTSOFPANDARIA"] = "Nieblas de Pandaria"
L["EXPANSION_WARLORDSOF DRAENOR"] = "Señores de la Guerra de Draenor"
L["EXPANSION_LEGION"] = "Legión"
L["EXPANSION_BATTLEFORAZEROTH"] = "Batalla por Azeroth"
L["EXPANSION_SHADOWLANDS"] = "Shadowlands"
L["EXPANSION_DRAGONFLIGHT"] = "Dragonflight"
L["EXPANSION_THEWARWITHIN"] = "La Guerra Interior"
L["EXPANSION_MIDNIGHT"] = "Medianoche"

-- Faction Names
L["FACTION_ALLIANCE"] = "Alianza"
L["FACTION_HORDE"] = "Horda"
L["FACTION_NEUTRAL"] = "Neutral"

-- Source Types
L["SOURCE_VENDOR"] = "Vendedor"
L["SOURCE_ACHIEVEMENT"] = "Logro"
L["SOURCE_QUEST"] = "Misión"
L["SOURCE_DROP"] = "Botín"
L["SOURCE_PROFESSION"] = "Profesión"
L["SOURCE_REPUTATION"] = "Reputación"

-- Quality Names
L["QUALITY_POOR"] = "Pobre"
L["QUALITY_COMMON"] = "Común"
L["QUALITY_UNCOMMON"] = "Poco común"
L["QUALITY_RARE"] = "Raro"
L["QUALITY_EPIC"] = "Épico"
L["QUALITY_LEGENDARY"] = "Legendario"

-- Collection Status
L["COLLECTION_COLLECTED"] = "Coleccionado"
L["COLLECTION_UNCOLLECTED"] = "No coleccionado"

-- Requirement Types
L["REQUIREMENT_NONE"] = "Ninguno"
L["REQUIREMENT_ACHIEVEMENT"] = "Logro"
L["REQUIREMENT_QUEST"] = "Misión"
L["REQUIREMENT_REPUTATION"] = "Reputación"
L["REQUIREMENT_RENOWN"] = "Renombre"
L["REQUIREMENT_PROFESSION"] = "Profesión"

-- Common Category/Type Names
L["CATEGORY_FURNITURE"] = "Muebles"
L["CATEGORY_DECORATIONS"] = "Decoraciones"
L["CATEGORY_LIGHTING"] = "Iluminación"
L["CATEGORY_PLACEABLES"] = "Colocables"
L["CATEGORY_ACCESSORIES"] = "Accesorios"
L["CATEGORY_RUGS"] = "Alfombras"
L["CATEGORY_PLANTS"] = "Plantas"
L["CATEGORY_PAINTINGS"] = "Pinturas"
L["CATEGORY_BANNERS"] = "Estandartes"
L["CATEGORY_BOOKS"] = "Libros"
L["CATEGORY_FOOD"] = "Comida"
L["CATEGORY_TOYS"] = "Juguetes"

-- Type Names
L["TYPE_CHAIR"] = "Silla"
L["TYPE_TABLE"] = "Mesa"
L["TYPE_BED"] = "Cama"
L["TYPE_LAMP"] = "Lámpara"
L["TYPE_CANDLE"] = "Vela"
L["TYPE_RUG"] = "Alfombra"
L["TYPE_PAINTING"] = "Pintura"
L["TYPE_BANNER"] = "Estandarte"
L["TYPE_PLANT"] = "Planta"
L["TYPE_BOOKSHELF"] = "Estantería"
L["TYPE_CHEST"] = "Cofre"
L["TYPE_WEAPON_RACK"] = "Perchero de armas"

-- Filter Options
L["FILTER_HIDE_VISITED"] = "Ocultar visitados"
L["FILTER_ALL_QUALITIES"] = "Todas las calidades"
L["FILTER_ALL_REQUIREMENTS"] = "Todos los requisitos"

-- UI Theme Names
L["THEME_MIDNIGHT"] = "Medianoche"
L["THEME_ALLIANCE"] = "Alianza"
L["THEME_HORDE"] = "Horda"
L["THEME_SLEEK_BLACK"] = "Negro elegante"
L["SETTINGS_UI_THEME"] = "Tema de interfaz"

-- Make the locale table globally available
HousingVendorLocales["esMX"] = L