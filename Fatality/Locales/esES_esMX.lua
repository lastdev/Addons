-- Translations missing or inaccurate? Visit http://wow.curseforge.com/addons/fatality/localization/ to see if you can help!
if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L = Fatality_Locales

-- Welcome Messages
L.welcome1 = "Gracias por actualizar a la \195\186ltima versi\195\179n!"
L.welcome2 = "En lo sucesivo, para acceder a este men\195\186 y configurar los par\195\161metros de cada jugador, teclea o |cffff9900/fatality|r o |cffff9900/fat|r."
L.welcome3 = "|cffff0000[Nota]|r Este mensaje aparecer\195\161 una vez por personaje."

-- Addon
L.addon_enabled = "|cff00ff00Activado|r"
L.addon_disabled = "|cffff0000Desactivado|r"

-- Damage
L.damage_overkill = "E: %s"
L.damage_resist = "R: %s"
L.damage_absorb = "A: %s"
L.damage_block = "B: %s"

-- Error Messages
L.error_report = "(%s) No se puede enviar el informe porque excede el m\195\161ximo de 255 caracteres. Para corregir esto, teclea |cffff9900/fatality|r y ajusta tu configuraci\195\179n. Otra forma alternativa es hacer |cfffdcf00'Salida' o 'Self'|r."
L.error_options = "|cffFF9933Fatality_Options|r no ha podido cargarse."

-- Configuration: Title
L.config_promoted = "Ayudante"
L.config_lfr = "BdB"
L.config_raid = "Banda"
L.config_party = "Mazmorras"
L.config_overkill = "Exceso de da\195\177o"
L.config_resist = "Resistencias"
L.config_absorb = "Absorber"
L.config_block = "Bloqueo"
L.config_icons = "Iconos"
L.config_school = "Escuelas"
L.config_source = "Origen"
L.config_short = "Abreviar"
L.config_limit10 = "L\195\173mite de Informe (10 jugadores)"
L.config_limit25 = "Informar L\195\173mite (25 jugadores)"
L.config_history = "Historial de eventos"
L.config_threshold = "Umbral de da\195\177o"
L.config_output_raid = "Salida (Bandas)"
L.config_output_party = "Salida (Mazmorras)"

-- Configuration: Description
L.config_promoted_desc = "Anunciar s\195\179lo si eres ayudante ["..RAID_LEADER.."/"..RAID_ASSISTANT.."]"
L.config_lfr_desc = "Activar dentro de Buscador de Banda"
L.config_raid_desc = "Activar dentro de Bandas"
L.config_party_desc = "Activar dentro de mazmorras"
L.config_overkill_desc = "Incluir exceso de da\195\177o"
L.config_resist_desc = "Incluir da\195\177o resistido"
L.config_absorb_desc = "Incluir da\195\177o absorbido"
L.config_block_desc = "Incluir da\195\177o bloqueado"
L.config_icons_desc = "Incluir iconos de banda"
L.config_school_desc = "Incluir escuelas de da\195\177o"
L.config_source_desc = "Incluir qui\195\169n caus\195\179 el da\195\177o"
L.config_short_desc = "Abreviar n\195\186meros [9431 = 9.4k]"
L.config_limit_desc = "Cu\195\161ntas muertes deben mostrarse por sesi\195\179n de combate?"
L.config_history_desc = "Cu\195\161ntos eventos de da\195\177o se mostrar\195\161n por persona?"
L.config_threshold_desc = "Cu\195\161l ser\195\161 la cantidad m\195\173nima de da\195\177o a registrar?"
L.config_channel_default = "<Nombre de Canal>"
L.config_whisper_default = "<Nombre de Jugador>"