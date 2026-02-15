if GetLocale() ~= "esES" then return end -- Spanish

local _, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Lockit
local Lockit = DelveCompanion.Lockit
-- ====================== NO ADDON DATA BELOW, ONLY LOCKIT ===================================================

-- Common

Lockit.UI_COMMON_BOUNTIFUL_DELVE_TITLE = "Profundidad pródiga:"
Lockit.UI_COMMON_MISSING_ADDON_TITLE = "Falta el complemento necesario: %s" -- `%s`: name of the missing AddOn, e.g. DelveCompanion

-- Delves List

Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_CLICK_INSTRUCTION = "<Shift click para establecer puntos de referencia en la profundidad>"
Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_CURRENT_TEXT = "Punto de referencia establecido."
Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_CLEAR_INSTRUCTION = "<Shift click para borrar el punto de referencia>"
Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_CLEAR_MPE = "Por favor utiliza MapPinEnhanced Tracker para eliminar el punto de referencia."

-- Delves UI

Lockit.UI_GILDED_STASH_CANNOT_RETRIEVE_DATA = "Visita las zonas de Khaz Algar para ver"
Lockit.UI_GILDED_STASH_BOUNTIFUL_NOTE = "Aparece sólo en el |cnNORMAL_FONT_COLOR:Nivel 11|r de las profundidades pródigas|A:delves-bountiful:16:16|a."
Lockit.UI_NO_ACTIVE_BOUNTIFUL = "No hay profundidades pródigas activas"
Lockit.UI_LOOT_INFO_BUTTON_TOOLTIP_INSTRUCTION = "<Click para mostrar información sobre el botín de las profundidades.>"

-- Loot Info

Lockit.UI_LOOT_INFO_DESCRIPTION = "Tabla de botín de las profundidades:"

-- Tooltips Extension

Lockit.UI_BOUNTIFUL_KEYS_COUNT_CACHES_PREFIX = "Llaves de cofres"

-- Compartment (these are shown hovering over the addon in the corresponding dropdown menu)

Lockit.UI_COMPARTMENT_DESCRIPTION_LEFT_CLICK = "|cnGREEN_FONT_COLOR:Click|r para mostrar la ventana de información."
Lockit.UI_COMPARTMENT_DESCRIPTION_RIGHT_CLICK = "|cnGREEN_FONT_COLOR:Click derecho|r para acceder a las opciones del complemento."

-- Settings

Lockit.UI_SETTINGS_SECTION_TITLE_ACCOUNT = "A nivel de cuenta"
Lockit.UI_SETTING_DELVE_PROGRESS_WIDGETS_NAME = "Información sobre el progreso de profundidades"
Lockit.UI_SETTING_DELVE_PROGRESS_WIDGETS_TOOLTIP = "Lista de profundidades: Mostrar el progreso de los logros para cada profundidad (Historias y Cofres)."
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_NAME = "Tipo de seguimiento de puntos de referencia"
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_START = "Selecciona qué tipo de puntos de referencia se utilizan para la navegación.\n\nPosibles opciones:"
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_BLIZZARD = "- Marca de mapa de Blizzard (La navegación predeterminada dentro del juego)."
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_TOMTOM = "- TomTom Waypoints."
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_MPE = "- MapPinEnhanced Waypoints."
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_TOMTOM_UNAVAILABLE_FORMAT = "%s (%s)."
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_BLIZZARD_NAME = "Blizzard"
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_BLIZZARD_DESCRIPTION = "Utilizar marca de mapa de Blizzard."
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_TOMTOM_NAME = "TomTom"
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_TOMTOM_DESCRIPTION = "Utilizar puntos de referencia de TomTom."
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_MPE_NAME = "MapPinEnhanced"
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_MPE_DESCRIPTION = "Utilizar puntos de referencia de MapPinEnhanced."

Lockit.UI_SETTINGS_SECTION_TITLE_CHARACTER = "A nivel de personaje"
Lockit.UI_SETTING_TOOLTIP_EXTENSION_NAME = "Información adicional en las descripciones emergentes"
Lockit.UI_SETTING_TOOLTIP_EXTENSION_TOOLTIP = "Muestra información adicional en las descripciones emergentes (ej:, el número de |cnITEM_EPIC_COLOR:Llaves de arcas restauradas|r recibidas esta semana)."
Lockit.UI_SETTING_COMPANION_CONFIG_NAME = "Widget de configuración del compañero"
Lockit.UI_SETTING_COMPANION_CONFIG_TOOLTIP = "Profundidades UI: Activa un widget que muestra la especialización y habilidades actuales del compañero.\nSe puede utilizar para modificar la configuración directamente desde Profundidades UI.\nNota: el tipo de diseño no afecta a la funcionalidad, solo a la disposición visual."
Lockit.UI_SETTING_COMPANION_CONFIG_OPTION_HORIZONTAL_NAME = "Disposición horizontal"
Lockit.UI_SETTING_COMPANION_CONFIG_OPTION_HORIZONTAL_DESCRIPTION = "Un diseño compacto con los botones dispuestos horizontalmente. Se muestra el modelo Companion."
Lockit.UI_SETTING_COMPANION_CONFIG_OPTION_VERTICAL_NAME = "Disposición vertical"
Lockit.UI_SETTING_COMPANION_CONFIG_OPTION_VERTICAL_DESCRIPTION = "Un diseño más detallado con los botones dispuestos verticalmente. El modelo Companion está oculto."
Lockit.UI_SETTING_GV_DETAILS_NAME = "Gran cámara personalizada"
Lockit.UI_SETTING_GV_DETAILS_TOOLTIP = "Profundidades UI: Muestra las recompensas y el progreso de la Gran cámara (relevante para profundidades) directamente en la Profundidades UI."
Lockit.UI_SETTING_DASHBOARD_OVERVIEW_NAME = "Sección de descripción general de Profundidades"
Lockit.UI_SETTING_DASHBOARD_OVERVIEW_TOOLTIP = "Profundidades UI: Muestra una sección de descripción general adicional. Contiene información sobre Alijo dorados, Profundidades pródigas disponibles y consumibles relacionados con las profundidades."

Lockit.UI_SETTINGS_TRANSLATION_TITLE = "Agradecimiento especial por contribuir en la traducción para:"

Lockit.UI_SETTINGS_LINKS_TITLE = "Enlaces:"
Lockit.UI_SETTINGS_ADDON_LINK_TOOLTIP_CURSEFORGE = "Click para copiar la URL de la página del complemento en |cnNORMAL_FONT_COLOR:CurseForge|r."
Lockit.UI_SETTINGS_ADDON_LINK_TOOLTIP_WAGO = "Click para copiar la URL de la página del complemento en |cnNORMAL_FONT_COLOR:Wago.io|r."
Lockit.UI_SETTINGS_ADDON_LINK_TOOLTIP_WOWINT = "Click para copiar la URL de la página del complemento en |cnNORMAL_FONT_COLOR:WoW Interface|r."
Lockit.UI_SETTINGS_ADDON_LINK_TOOLTIP_GITHUB = "Click para copiar la URL de la página del complemento en |cnNORMAL_FONT_COLOR:GitHub|r.\n\nComparte tus comentarios, solicita nuevas funciones o informa de un error. ¡Esto ayuda a mejorar aún más el complemento!"
Lockit.UI_SETTINGS_ADDON_LINK_POPUP_TEXT = "|cnGREEN_FONT_COLOR:Ctrl + C|r para copiar |cnNORMAL_FONT_COLOR:%s|r URL." -- `%s`: website name, e.g. CurseForge.
