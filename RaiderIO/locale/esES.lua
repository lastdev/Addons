local _, ns = ...

if ns:IsSameLocale("esES") then
	local L = ns.L or ns:NewLocale()

	L.LOCALE_NAME = "esES"

L["ALLOW_IN_LFD"] = "Permitir en buscador de mazmorras"
L["ALLOW_IN_LFD_DESC"] = "Click derecho en los grupos o aplicantes en el buscador de mazmorras para copiar la URL de su perfil de Raider.IO"
L["ALLOW_ON_PLAYER_UNITS"] = "Permitir en marcos de jugador"
L["ALLOW_ON_PLAYER_UNITS_DESC"] = [=[Click derecho en el marco de un jugador para copiar la URL de su perfil de Raider.IO
]=]
L["ALWAYS_SHOW_EXTENDED_INFO"] = "Mostrar las puntuaciones de Rol siempre"
L["ALWAYS_SHOW_EXTENDED_INFO_DESC"] = [=[Manten presionado (shift / ctrl / alt) para mostrar la puntuacion por Rol del jugador en la nota. Si habilitas esta opción, las notas siempre incluiran puntuaciones por Rol
]=]
L["API_DEPRECATED"] = "|cffFF0000¡Atención!|r El addon |cffFFFFFF%s|r está usando una función RaiderIO obsoleta.%s. Esta función será eliminada en futuras versiones. Por favor, anima al autor de %s a actualizar su addon. Pila de llamadas: %s"
L["API_DEPRECATED_UNKNOWN_ADDON"] = [=[<AddOn desconocido>
]=]
L["API_DEPRECATED_UNKNOWN_FILE"] = [=[<Archivo de AddOn desconocido>
]=]
L["API_DEPRECATED_WITH"] = [=[| cffFF0000"Aviso! | r El complemento | cffFFFFFF% s | r está llamando a una función obsoleta RaiderIO.% s. Esta función se eliminará en futuras versiones. Anime al autor de% s a actualizar a la nueva API RaiderIO.% S en su lugar. Pila de llamadas:% s
]=]
L["API_INVALID_DATABASE"] = [=[| cffFF0000 ¡Advertencia! | r Se detectó una base de datos Raider.IO no válida en | cffffffff% s | r. Actualice todas las regiones y facciones en el cliente Raider.IO, o reinstale el complemento manualmente.
]=]
L["BEST_FOR_DUNGEON"] = "Mejor en esta mazmorra"
L["BEST_RUN"] = "Mejor mazmorra"
L["BEST_SCORE"] = "Mejor puntuacion M + (% s)"
L["CANCEL"] = "Cancelar"
L["CHANGES_REQUIRES_UI_RELOAD"] = "Los cambios se han guardado, pero debes recargar la interfaz para que surtan efecto. ¿Quieres recargar ahora?"
L["CHECKBOX_DISPLAY_WEEKLY"] = [=[Mostrar semanal
]=]
L["CHOOSE_HEADLINE_HEADER"] = "Título del tooltip de míticas+"
L["CONFIG_SHOW_TOOLTIPS_HEADER"] = [=[Notas de miticas+ y bandas
]=]
L["CONFIG_WHERE_TO_SHOW_TOOLTIPS"] = "Dónde mostrar el progreso de míticas+ y bandas"
L["CONFIRM"] = "Confirmar"
L["COPY_RAIDERIO_PROFILE_URL"] = "Copiar URL de Raider.IO"
L["COPY_RAIDERIO_URL"] = "Copiar la URL de Raider.IO"
L["CURRENT_MAINS_SCORE"] = "Puntuación actual de M+ del Personaje Principal"
L["CURRENT_SCORE"] = [=[Actual puntuación M+
]=]
L["DISABLE_DEBUG_MODE_RELOAD"] = "Estás desactivando el modo Debug. Al hacer clic en Confirmar se cargará de nuevo su interfaz."
L["DPS"] = "DPS"
L["DPS_SCORE"] = "Puntuación de DPS"
L["DUNGEON_SHORT_NAME_AD"] = "Atal'Dazar"
L["DUNGEON_SHORT_NAME_ARC"] = "Arquería"
L["DUNGEON_SHORT_NAME_BRH"] = "Torreón"
L["DUNGEON_SHORT_NAME_COEN"] = "Catedral"
L["DUNGEON_SHORT_NAME_COS"] = "Corte"
L["DUNGEON_SHORT_NAME_DHT"] = "Arboleda"
L["DUNGEON_SHORT_NAME_EOA"] = "Ojo"
L["DUNGEON_SHORT_NAME_FH"] = "Fuerte Libre"
L["DUNGEON_SHORT_NAME_HOV"] = "Valor"
L["DUNGEON_SHORT_NAME_KR"] = "Reposo "
L["DUNGEON_SHORT_NAME_LOWR"] = "Kara-I"
L["DUNGEON_SHORT_NAME_ML"] = "Veta Madre"
L["DUNGEON_SHORT_NAME_MOS"] = "Fauce"
L["DUNGEON_SHORT_NAME_NL"] = "Guarida"
L["DUNGEON_SHORT_NAME_SEAT"] = "Trono"
L["DUNGEON_SHORT_NAME_SIEGE"] = "Asedio"
L["DUNGEON_SHORT_NAME_SOTS"] = "Altar "
L["DUNGEON_SHORT_NAME_TD"] = "Tol Dagor"
L["DUNGEON_SHORT_NAME_TM"] = "Veta Madre"
L["DUNGEON_SHORT_NAME_TOS"] = "Templo "
L["DUNGEON_SHORT_NAME_UNDR"] = "Catacumbas"
L["DUNGEON_SHORT_NAME_UPPR"] = "Kara-S"
L["DUNGEON_SHORT_NAME_VOTW"] = "Celadoras"
L["DUNGEON_SHORT_NAME_WM"] = "Mansión "
L["DUNGEON_SHORT_NAME_WORK"] = "Taller"
L["DUNGEON_SHORT_NAME_YARD"] = "Desguace"
L["ENABLE_AUTO_FRAME_POSITION"] = "Posicionar automáticamente el marco de perfil de RaiderIO"
L["ENABLE_AUTO_FRAME_POSITION_DESC"] = "Fija la ventana emergente de perfil de M+ junto al marco del buscador de grupos o la ventana emergente de jugador."
L["ENABLE_DEBUG_MODE_RELOAD"] = "Estás activando el modo depuración. Esto es solo para fines de pruebas y desarrollo, y puede incurrir en un aumento del uso de memoria. Haz clic en confirmar para recargar la interfaz."
L["ENABLE_LOCK_PROFILE_FRAME"] = "Bloquear el marco de perfil de RaiderIO"
L["ENABLE_LOCK_PROFILE_FRAME_DESC"] = "Evita que se pueda desplazar el marco de perfil de M+. No tiene efecto si el marco de perfil de M+ está configurado para posicionarse automáticamente."
L["ENABLE_NO_SCORE_COLORS"] = "Desactivar colores de puntuación"
L["ENABLE_NO_SCORE_COLORS_DESC"] = "Desactiva los colores de las puntuaciones. Todas las puntuaciones se mostrarán de color blanco."
L["ENABLE_RAIDERIO_CLIENT_ENHANCEMENTS"] = "Habilitar mejoras del cliente de RaiderIO"
L["ENABLE_RAIDERIO_CLIENT_ENHANCEMENTS_DESC"] = "Permite ver información detallada del cliente de RaiderIO de tus personajes confirmados."
L["ENABLE_SIMPLE_SCORE_COLORS"] = "Usar colores de puntuación simples"
L["ENABLE_SIMPLE_SCORE_COLORS_DESC"] = "Muestra las puntuaciones usando solo los colores estándar de calidad de objeto. Facilita la distinción de puntuaciones para personas con defectos de visión cromática."
L["EXPORTJSON_COPY_TEXT"] = "Copia este texto y pégalo en |cff00C8FFhttps://raider.io|r para ver información de todos los jugadores."
L["GENERAL_TOOLTIP_OPTIONS"] = "Opciones generales del tooltip"
L["GUILD_BEST_SEASON"] = "Hermandad: mejor de la temporada"
L["GUILD_BEST_TITLE"] = "Récords de hermandad"
L["GUILD_BEST_WEEKLY"] = "Mejores de la semana"
L["HEALER"] = "Sanador"
L["HEALER_SCORE"] = "Puntuación de sanador"
L["HIDE_OWN_PROFILE"] = "Ocultar ventana emergente de perfil personal de RaiderIO"
L["HIDE_OWN_PROFILE_DESC"] = "Oculta la ventana emergente de tu perfil personal de RaiderIO. No afecta a las ventanas emergentes de otros jugadores."
L["INVERSE_PROFILE_MODIFIER"] = "Invertir modificador de marco de perfil"
L["INVERSE_PROFILE_MODIFIER_DESC"] = "Invierte el comportamiento del modificador del marco de perfil (mayús/ctrl/alt) para que muestre por defecto el perfil del líder del grupo."
L["KEYSTONE_COMPLETED_10"] = "+10-14 (en tiempo)"
L["KEYSTONE_COMPLETED_15"] = "+15 (en tiempo)"
L["KEYSTONE_COMPLETED_5"] = "+5-9 (en tiempo)"
L["LEGION_MAIN_SCORE"] = "Puntuación de personaje principal en Legion"
L["LEGION_SCORE"] = "Puntuación en Legion"
L["LOCKING_PROFILE_FRAME"] = "RaiderIO: bloqueando el marco de perfil de M+."
L["MAINS_BEST_SCORE_BEST_SEASON"] = "Mejor puntuación en M+ con el personaje principal (%s)"
L["MAINS_RAID_PROGRESS"] = "Progreso de personaje principal"
L["MAINS_SCORE"] = "Puntuación de personaje principal"
L["MAINS_SCORE_COLON"] = "Puntuación de personaje principal:"
L["MODULE_AMERICAS"] = "América"
L["MODULE_EUROPE"] = "Europa"
L["MODULE_KOREA"] = "Corea"
L["MODULE_TAIWAN"] = "Taiwan"
L["MY_PROFILE_TITLE"] = "Perfil personal de M+"
L["MYTHIC_PLUS_DB_MODULES"] = "Módulos de la base de datos"
L["MYTHIC_PLUS_SCORES"] = "Puntuaciones de M+"
L["NO_GUILD_RECORD"] = "No hay récords de hermandad"
L["OPEN_CONFIG"] = "Abrir configuración"
L["OUT_OF_SYNC_DATABASE_S"] = "|cffFFFFFF%s|r tiene datos de facción sin sincronizar. Por favor, actualiza tu configuración del cliente de RaiderIO para sincronizar ambas facciones."
L["OUTDATED_DATABASE"] = "Estas puntuaciones son de hace %d día(s)"
L["OUTDATED_DATABASE_HOURS"] = "Estas puntuaciones son de hace %d hora(s)"
L["OUTDATED_DATABASE_S"] = "|cffFFFFFF%s|r está usando datos de hace |cffFF6666%d|r día(s). Por favor, actualiza el addon para disponer de las puntuaciones de M+ más recientes."
--[[Translation missing --]]
--[[ L["OUTDATED_DOWNLOAD_LINK"] = ""--]] 
--[[Translation missing --]]
--[[ L["OUTDATED_EXPIRED_ALERT"] = ""--]] 
--[[Translation missing --]]
--[[ L["OUTDATED_EXPIRED_TITLE"] = ""--]] 
--[[Translation missing --]]
--[[ L["OUTDATED_EXPIRES_IN_DAYS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OUTDATED_EXPIRES_IN_HOURS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OUTDATED_PROFILE_TOOLTIP_MESSAGE"] = ""--]] 
L["PLAYER_PROFILE_TITLE"] = "Perfil de M+"
L["PREV_SEASON_SUFFIX"] = "(*)"
L["PREVIOUS_SCORE"] = "Puntuación M+ anterior (%s)"
L["PROFILE_BEST_RUNS"] = "Mejor de cada mazmorra"
--[[Translation missing --]]
--[[ L["PROVIDER_NOT_LOADED"] = ""--]] 
L["RAID_ABBREVIATION_ULD"] = "Uldir"
L["RAID_BOSS_ABT_1"] = "Rompemundos"
L["RAID_BOSS_ABT_10"] = "Aggramar"
L["RAID_BOSS_ABT_11"] = "Argus"
L["RAID_BOSS_ABT_2"] = "Canes"
L["RAID_BOSS_ABT_3"] = "Hasabel"
L["RAID_BOSS_ABT_4"] = "Alto Mando"
L["RAID_BOSS_ABT_5"] = "Eonar"
L["RAID_BOSS_ABT_6"] = "Imonar"
L["RAID_BOSS_ABT_7"] = "Kin'garoth"
L["RAID_BOSS_ABT_8"] = "Varimathras"
L["RAID_BOSS_ABT_9"] = "Aquelarre"
L["RAID_BOSS_BOD_1"] = "Campeona de la Luz"
L["RAID_BOSS_BOD_2"] = "Grong"
L["RAID_BOSS_BOD_3"] = "Maestros Fuego de Jade"
L["RAID_BOSS_BOD_4"] = "Opulencia"
L["RAID_BOSS_BOD_5"] = "Cónclave de los Elegidos"
L["RAID_BOSS_BOD_6"] = "Rey Rastakhan"
L["RAID_BOSS_BOD_7"] = "Manitas mayor Mekkatorque"
L["RAID_BOSS_BOD_8"] = "Bloqueo de la tormenta"
L["RAID_BOSS_BOD_9"] = "Lady Jaina Valiente"
L["RAID_BOSS_EP_1"] = "Comandante abisal Sivara"
L["RAID_BOSS_EP_2"] = "Behemoth de Aguasnegras"
L["RAID_BOSS_EP_3"] = "Radiancia de Azshara"
L["RAID_BOSS_EP_4"] = "Lady Gobernalle"
L["RAID_BOSS_EP_5"] = "Orgozoa"
L["RAID_BOSS_EP_6"] = "Corte de la reina"
L["RAID_BOSS_EP_7"] = "Za'qul"
L["RAID_BOSS_EP_8"] = "Reina Azshara"
--[[Translation missing --]]
--[[ L["RAID_BOSS_NYA_1"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAID_BOSS_NYA_10"] = ""--]] 
L["RAID_BOSS_NYA_11"] = "Caparazón"
--[[Translation missing --]]
--[[ L["RAID_BOSS_NYA_12"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAID_BOSS_NYA_2"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAID_BOSS_NYA_3"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAID_BOSS_NYA_4"] = ""--]] 
L["RAID_BOSS_NYA_5"] = "Mente"
--[[Translation missing --]]
--[[ L["RAID_BOSS_NYA_6"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAID_BOSS_NYA_7"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAID_BOSS_NYA_8"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAID_BOSS_NYA_9"] = ""--]] 
L["RAID_BOSS_ULD_1"] = "Taloc"
L["RAID_BOSS_ULD_2"] = "MADRE"
L["RAID_BOSS_ULD_3"] = "Devorador fétido"
L["RAID_BOSS_ULD_4"] = "Zek'voz"
L["RAID_BOSS_ULD_5"] = "Vectis"
L["RAID_BOSS_ULD_6"] = "Zul el Renacido"
L["RAID_BOSS_ULD_7"] = "Mythrax"
L["RAID_BOSS_ULD_8"] = "G'huun"
L["RAID_DIFFICULTY_NAME_HEROIC"] = "Heroico"
L["RAID_DIFFICULTY_NAME_MYTHIC"] = "Mítico"
L["RAID_DIFFICULTY_NAME_NORMAL"] = "Normal"
L["RAID_DIFFICULTY_SUFFIX_HEROIC"] = "H"
L["RAID_DIFFICULTY_SUFFIX_MYTHIC"] = "M"
L["RAID_DIFFICULTY_SUFFIX_NORMAL"] = "N"
L["RAID_ENCOUNTERS_DEFEATED_TITLE"] = "Encuentros de banda derrotados"
L["RAID_PROGRESS_TITLE"] = "Progreso de banda"
L["RAIDERIO_AVERAGE_PLAYER_SCORE"] = "Puntuación media de +%s en tiempo"
L["RAIDERIO_BEST_RUN"] = "Raider.IO Mejor resultado en M+"
L["RAIDERIO_CLIENT_CUSTOMIZATION"] = "Personalización del cliente de RaiderIO"
L["RAIDERIO_MP_BASE_SCORE"] = "Puntuación de M+ base"
L["RAIDERIO_MP_BEST_SCORE"] = "Raider.IO Puntuación M+ (%s)"
L["RAIDERIO_MP_SCORE"] = "Puntuación de M+"
L["RAIDERIO_MP_SCORE_COLON"] = "Puntuación de M+:"
L["RAIDERIO_MYTHIC_OPTIONS"] = "Opciones de Raider.IO Mythic Plus"
L["RAIDING_DATA_HEADER"] = "Progreso de banda de Raider.IO"
L["RAIDING_DB_MODULES"] = "Módulos de la base de datos de bandas"
L["RELOAD_LATER"] = "La reiniciaré más tarde"
L["RELOAD_NOW"] = "Reiniciarla ahora"
L["SEASON_LABEL_1"] = "T1"
L["SEASON_LABEL_2"] = "T2"
L["SEASON_LABEL_3"] = "T3"
L["SEASON_LABEL_4"] = "T4"
L["SHOW_AVERAGE_PLAYER_SCORE_INFO"] = "Mostrar puntuación media de M+ en tiempo"
L["SHOW_AVERAGE_PLAYER_SCORE_INFO_DESC"] = "Muestra la puntuación media de M+ en tiempo de los miembros de un grupo. Aparece en las descripciones emergentes de piedras angulares y jugadores en el buscador de grupos."
L["SHOW_BEST_MAINS_SCORE"] = "Mostrar puntuación de M+ del personaje principal de la mejor temporada"
L["SHOW_BEST_MAINS_SCORE_DESC"] = "Muestra la puntuación conseguida con el personaje principal en la mejor temporada de míticas+ y bandas en el tooltip. Los jugadores deben haberse registrado en Raider.IO y haber declarado un personaje como personaje principal."
L["SHOW_BEST_RUN"] = "Mostrar la mejor mítica+ realizada en el título"
L["SHOW_BEST_RUN_DESC"] = "Muestra la mejor mítica+ realizada por el jugador en la temporada actual como título del tooltip."
L["SHOW_BEST_SEASON"] = "Mostrar la mejor puntuación de la temporada de Míticas+ como título"
L["SHOW_BEST_SEASON_DESC"] = "Muestra la mejor puntuación de la temporada de Míticas+ del jugador como título del tooltip. Si la puntuación es de una temporada anterior, la temporada se indicará en el título del tooltip."
L["SHOW_CLIENT_GUILD_BEST"] = "Mostrar mejores puntuaciones de mazmorra en el buscador de grupos"
L["SHOW_CLIENT_GUILD_BEST_DESC"] = "Muestra las cinco mejores puntuaciones de tu hermandad (tanto de temporada como semanales) en la pestaña 'Piedra angular mítica' de la ventana del buscador de grupos."
L["SHOW_CURRENT_SEASON"] = "Mostrar la puntuación actual de la temporada de Míticas+ como título"
L["SHOW_CURRENT_SEASON_DESC"] = "Muestra la puntuación actual de la temporada de Míticas+ del jugador como título del tooltip."
L["SHOW_IN_FRIENDS"] = "Mostrar en la lista de amigos"
L["SHOW_IN_FRIENDS_DESC"] = "Muestra la puntuación de M+ de tus amigos cuando pasas el ratón por encima."
L["SHOW_IN_LFD"] = "Mostrar en el buscador de grupos"
L["SHOW_IN_LFD_DESC"] = "Muestra la puntuación de M+ cuando pasas el ratón por encima de grupos ya creados del buscador o jugadores que soliciten unirse a tu grupo."
L["SHOW_IN_SLASH_WHO_RESULTS"] = "Mostrar en resultados de /who"
L["SHOW_IN_SLASH_WHO_RESULTS_DESC"] = "Muestra la puntuación de M+ cuando usas \"/who\" con un jugador específico."
L["SHOW_IN_WHO_UI"] = "Mostrar en la interfaz de ¿Quién?"
L["SHOW_IN_WHO_UI_DESC"] = "Muestra la puntuación de M+ cuando pasas el ratón por encima de los resultados de la ventana ¿Quién?"
L["SHOW_KEYSTONE_INFO"] = "Mostrar información de piedras angulares"
L["SHOW_KEYSTONE_INFO_DESC"] = "Muestra la puntuación base de cada piedra angular en su descripción emergente. También muestra la mejor M+ de esa mazmorra de cada jugador en tu grupo."
L["SHOW_LEADER_PROFILE"] = "Habilitar modificador del marco de perfil"
L["SHOW_LEADER_PROFILE_DESC"] = "Permite mantener pulsado un modificador (mayús/ctrl/alt) para alternar el marco de perfil entre el personal y el del líder del grupo."
L["SHOW_MAINS_SCORE"] = "Mostrar puntuación de personaje principal"
L["SHOW_MAINS_SCORE_DESC"] = "Muestra la puntuación en la temporada actual del personaje principal del jugador inspeccionado. El jugador en cuestión debe estar registrado en Raider.IO y haber seleccionado su personaje principal."
L["SHOW_ON_GUILD_ROSTER"] = "Mostrar en lista de hermandad"
L["SHOW_ON_GUILD_ROSTER_DESC"] = "Muestra la puntuación de M+ de los miembros de tu hermandad cuando pasas el ratón por encima de ellos en la lista de hermandad."
L["SHOW_ON_PLAYER_UNITS"] = "Mostrar en marcos de jugador"
L["SHOW_ON_PLAYER_UNITS_DESC"] = "Muestra la puntuación de M+ de los jugadores en su ventana emergente cuando pasas el ratón sobre ellos."
L["SHOW_RAID_ENCOUNTERS_IN_PROFILE"] = "Mostrar encuentros de banda en la ventana emergente de perfil"
L["SHOW_RAID_ENCOUNTERS_IN_PROFILE_DESC"] = "Muestra el progreso de banda en la ventana emergente de perfil de RaiderIO."
--[[Translation missing --]]
--[[ L["SHOW_RAIDERIO_BESTRUN_FIRST"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_RAIDERIO_BESTRUN_FIRST_DESC"] = ""--]] 
L["SHOW_RAIDERIO_PROFILE"] = "Mostrar marco de perfil en el buscador de grupos"
L["SHOW_RAIDERIO_PROFILE_DESC"] = "Muestra el marco de perfil de Raider.IO en el buscador de grupos."
L["SHOW_ROLE_ICONS"] = "Mostrar iconos de rol en el tooltip"
L["SHOW_ROLE_ICONS_DESC"] = "Cuando está activado, se muestran los mejores roles del jugador en míticas+ en el tooltip."
L["SHOW_SCORE_IN_COMBAT"] = "Mostrar puntuación en combate"
L["SHOW_SCORE_IN_COMBAT_DESC"] = "Desactiva esta opción para mejorar el rendimiento al pasar el ratón por encima de jugadores cuando estás en combate."
L["TANK"] = "Tanque"
L["TANK_SCORE"] = "Puntuación de tanque"
L["TIMED_10_RUNS"] = "+10-14 en tiempo"
L["TIMED_15_RUNS"] = "+15 en tiempo"
L["TIMED_20_RUNS"] = "+20 en tiempo"
L["TIMED_5_RUNS"] = "+5-9 en tiempo"
L["TOOLTIP_CUSTOMIZATION"] = "Personalización de ventanas emergentes"
L["TOOLTIP_PROFILE"] = "Personalización del marco de perfil"
L["TOTAL_MP_SCORE"] = "Puntuación de M+"
L["TOTAL_RUNS"] = "Total en BfA"
L["UNKNOWN_SCORE"] = "Desconocida"
L["UNKNOWN_SERVER_FOUND"] = "|cffFFFFFF%s|r ha encontrado un nuevo servidor. Por favor, apunta esta información |cffFF9999{|r |cffFFFFFF%s|r |cffFF9999,|r |cffFFFFFF%s|r |cffFF9999}|r y envíasela a los desarrolladores. ¡Gracias!"
L["UNLOCKING_PROFILE_FRAME"] = "RaiderIO: desbloqueando el marco de perfil de M+."
L["USE_ENGLISH_ABBREVIATION"] = "Forzar abreviaturas en inglés para mazmorras"
L["USE_ENGLISH_ABBREVIATION_DESC"] = "Cuando está activado, se sustituyen las abreviaturas usadas para referirse a las mazmorras por sus versiones en inglés, en vez de usar las de tu idioma actual."
L["WARNING_DEBUG_MODE_ENABLE"] = "|cffFFFFFF%s|r El modo depuración está activado. Puedes desactivarlo escribiendo |cffFFFFFF/raiderio debug|r."
L["WARNING_LOCK_POSITION_FRAME_AUTO"] = "RaiderIO: primero debes deshabilitar el posicionamiento automático del marco de perfil de RaiderIO."


	ns.L = L
end
