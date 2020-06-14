local _, ns = ...

if ns:IsSameLocale("itIT") then
	local L = ns.L or ns:NewLocale()

	L.LOCALE_NAME = "itIT"

L["ALLOW_IN_LFD"] = "Abilita in Ricerca delle Incursioni"
L["ALLOW_IN_LFD_DESC"] = "Fai clic con il pulsante destro del mouse su gruppi o candidati in Ricerca delle Incusioni per copiare l'URL del Profilo Raider.IO"
L["ALLOW_ON_PLAYER_UNITS"] = "Consenti su Frame Unità Giocatore"
L["ALLOW_ON_PLAYER_UNITS_DESC"] = "Fare clic con il tasto destro del mouse sulla finestra di un Giocatore per Copiare l'URL del Profilo Raider.IO."
L["ALWAYS_SHOW_EXTENDED_INFO"] = "Mostra sempre Punteggi di Ruolo"
L["ALWAYS_SHOW_EXTENDED_INFO_DESC"] = "Tenere premuto un tasto (maiusc / ctrl / alt) per mostrare i Punteggi del Ruolo del Giocatore nel Tooltip. Se abiliti questa Opzione, le Descrizioni Comandi includeranno sempre i Punteggi del Ruolo."
L["API_DEPRECATED"] = "| cffFF0000Warning! | r L'addon | cffFFFFFF% s | r sta chiamando una funzione deprecata RaiderIO.% s. Questa funzione verrà rimossa nelle versioni future. Si prega di incoraggiare l'autore di% s per aggiornare il loro addon. Stack di chiamata:% s"
L["API_DEPRECATED_UNKNOWN_ADDON"] = "<AddOn Sconosciuto>"
L["API_DEPRECATED_UNKNOWN_FILE"] = "<File AddOn Sconosciuto>"
L["API_DEPRECATED_WITH"] = "| cffFF0000Warning! | r L'addon | cffFFFFFF% s | r sta chiamando una funzione deprecata RaiderIO.% s. Questa funzione verrà rimossa nelle versioni future. Si prega di incoraggiare l'autore di% s ad aggiornare alla nuova API RaiderIO.% S invece. Stack di chiamata:% s"
L["API_INVALID_DATABASE"] = "| cffFF0000Warning! | r Rilevato un database RaiderIO non valido in | cffffffff% s | r. Si prega di aggiornare tutte le regioni e le fazioni nel client RaiderIO o reinstallare manualmente l'addon."
L["BEST_FOR_DUNGEON"] = "Migliore Questa Spedizione"
L["BEST_RUN"] = "Miglior Spedizione"
L["BEST_SCORE"] = "Miglior punteggio M+"
L["CANCEL"] = "Annulla"
L["CHANGES_REQUIRES_UI_RELOAD"] = [=[Le tue modifiche sono state salvate, ma devi ricaricare la tua interfaccia affinché abbiano effetto.

Vuoi farlo ora?]=]
L["CHECKBOX_DISPLAY_WEEKLY"] = "Visualizza Settimanale"
--[[Translation missing --]]
--[[ L["CHOOSE_HEADLINE_HEADER"] = ""--]] 
L["CONFIG_SHOW_TOOLTIPS_HEADER"] = "Mythic+ e Raid Tooltips"
L["CONFIG_WHERE_TO_SHOW_TOOLTIPS"] = "Dove mostrare il progresso di Mitiche+ e Incursioni"
L["CONFIRM"] = "Conferma"
L["COPY_RAIDERIO_PROFILE_URL"] = "Copia URL Raider.IO"
L["COPY_RAIDERIO_URL"] = "Copia URL Raider.IO"
L["CURRENT_MAINS_SCORE"] = "Punteggio M+ PG Principale"
L["CURRENT_SCORE"] = "Punteggio M+ Corrente"
L["DISABLE_DEBUG_MODE_RELOAD"] = "Stai disabilitando Debug Mode. Premere Conferma ricaricherà l'interfaccia"
L["DPS"] = "DPS"
L["DPS_SCORE"] = "Punteggio DPS"
L["DUNGEON_SHORT_NAME_AD"] = "AD"
L["DUNGEON_SHORT_NAME_ARC"] = "ARC"
L["DUNGEON_SHORT_NAME_BRH"] = "FC"
L["DUNGEON_SHORT_NAME_COEN"] = "CDNE"
L["DUNGEON_SHORT_NAME_COS"] = "CDS"
L["DUNGEON_SHORT_NAME_DHT"] = "BC"
L["DUNGEON_SHORT_NAME_EOA"] = "ODA"
L["DUNGEON_SHORT_NAME_FH"] = "CDL"
L["DUNGEON_SHORT_NAME_HOV"] = "SDV"
L["DUNGEON_SHORT_NAME_KR"] = "RDR"
L["DUNGEON_SHORT_NAME_LOWR"] = "KINF"
L["DUNGEON_SHORT_NAME_ML"] = "VM"
L["DUNGEON_SHORT_NAME_MOS"] = "FDA"
L["DUNGEON_SHORT_NAME_NL"] = "ADN"
L["DUNGEON_SHORT_NAME_SEAT"] = "SDT"
L["DUNGEON_SHORT_NAME_SIEGE"] = "ADB"
L["DUNGEON_SHORT_NAME_SOTS"] = "SDT"
L["DUNGEON_SHORT_NAME_TD"] = "TD"
L["DUNGEON_SHORT_NAME_TM"] = "VM"
L["DUNGEON_SHORT_NAME_TOS"] = "TDS"
L["DUNGEON_SHORT_NAME_UNDR"] = "GRO"
L["DUNGEON_SHORT_NAME_UPPR"] = "KSUP"
L["DUNGEON_SHORT_NAME_VOTW"] = "SDC"
L["DUNGEON_SHORT_NAME_WM"] = "MDC"
--[[Translation missing --]]
--[[ L["DUNGEON_SHORT_NAME_WORK"] = ""--]] 
--[[Translation missing --]]
--[[ L["DUNGEON_SHORT_NAME_YARD"] = ""--]] 
L["ENABLE_AUTO_FRAME_POSITION"] = "Posiziona Automaticamente la Cornice del Profilo RaiderIO"
L["ENABLE_AUTO_FRAME_POSITION_DESC"] = "Abilitando questa Opzione manterrai la Descrizione del Profilo M+ accanto Finestra della Ricerca delle Incursioni o al Tooltip del Giocatore."
L["ENABLE_DEBUG_MODE_RELOAD"] = "Stai abilitando la modalità Debug. Questa modalità è indicata solo per test e sviluppatori e richiederà un ulteriore utilizzo di memoria. Premere Conferma farà ricaricare l'interfaccia"
L["ENABLE_LOCK_PROFILE_FRAME"] = "Blocca Finestra del Profilo RaiderIO"
L["ENABLE_LOCK_PROFILE_FRAME_DESC"] = "Impedisce il Trascinamento della Finestra del Profilo M+. Questo non ha alcun Effetto se la Finestra del Profilo M+ è impostata per essere Posizionata Automaticamente."
L["ENABLE_NO_SCORE_COLORS"] = "Disabilita Colori Punteggio"
L["ENABLE_NO_SCORE_COLORS_DESC"] = "Disabilita la Colorizzazione dei Punteggi. Tutti i Punteggi verranno visualizzati in Bianco."
L["ENABLE_RAIDERIO_CLIENT_ENHANCEMENTS"] = "Consenti Miglioramenti del client RaiderIO"
L["ENABLE_RAIDERIO_CLIENT_ENHANCEMENTS_DESC"] = "Abilitare questa opzione ti permetterà di visualizzare i in maniera dettagliata i dati del Profilo RaiderIO scaricati per i tuoi Personaggi."
L["ENABLE_SIMPLE_SCORE_COLORS"] = [=[Usa i Colori dei Punteggi Semplici
]=]
L["ENABLE_SIMPLE_SCORE_COLORS_DESC"] = [=[Mostra i Punteggi solo con Colori Standard utilizzati per gli Oggetti. Ciò può rendere più facile per chi ha problemi di visione dei colori a distinguere i livelli di punteggio.
]=]
L["EXPORTJSON_COPY_TEXT"] = "Copia quanto segue e ncollalo ovunque su | cff00C8FFhttps: //raider.io | r per Cercare tutti i Giocatori."
L["GENERAL_TOOLTIP_OPTIONS"] = "opzioni generali Tooltip"
L["GUILD_BEST_SEASON"] = "Gilda: Stagionale"
L["GUILD_BEST_TITLE"] = "Raider.IO Records"
L["GUILD_BEST_WEEKLY"] = "Gilda: Settimanale"
L["HEALER"] = "Curatore"
L["HEALER_SCORE"] = "Punteggio Curatore"
L["HIDE_OWN_PROFILE"] = "Nascondi Informazioni Personali dal Tooltip"
L["HIDE_OWN_PROFILE_DESC"] = "Quando impostato, questo non mostrerà la propria descrizione del profilo RaiderIO, ma potrebbe mostrare quello di un altro giocatore se ne ha uno."
L["INVERSE_PROFILE_MODIFIER"] = "Inverti il ​​modificatore del tooltip del profilo RaiderIO"
L["INVERSE_PROFILE_MODIFIER_DESC"] = "Abilitando questo si inverte il comportamento del modificatore del tooltip profilo RaiderIO (shift / ctrl / alt): tieni premuto per alternare la visualizzazione tra profilo personale / leader o profilo leader / personale."
L["KEYSTONE_COMPLETED_10"] = "+10-14(COMP)"
L["KEYSTONE_COMPLETED_15"] = "+15(COMP)"
L["KEYSTONE_COMPLETED_5"] = "+5-9(COMP)"
L["LEGION_MAIN_SCORE"] = "Punteggio PG Principale \"Legion\""
L["LEGION_SCORE"] = "Punteggio \"Legion\""
L["LOCKING_PROFILE_FRAME"] = "RaiderIO: Blocco della finestra Profilo M+."
L["MAINS_BEST_SCORE_BEST_SEASON"] = "miglior punteggio M+ del PG principale (%s)"
L["MAINS_RAID_PROGRESS"] = "Progresso PG Principale"
L["MAINS_SCORE"] = "Punteggio PG Principale"
L["MAINS_SCORE_COLON"] = "Punteggio PG Principale:"
L["MODULE_AMERICAS"] = "America"
L["MODULE_EUROPE"] = "Europa"
L["MODULE_KOREA"] = "Korea"
L["MODULE_TAIWAN"] = "Taiwan"
L["MY_PROFILE_TITLE"] = "Profilo RaiderIO"
L["MYTHIC_PLUS_DB_MODULES"] = "Mythic+ Moduli Database"
L["MYTHIC_PLUS_SCORES"] = "Mythic+ Tooltip Punteggio"
L["NO_GUILD_RECORD"] = "Nessun Record di Gilda"
L["OPEN_CONFIG"] = "Apri Configurazione"
L["OUT_OF_SYNC_DATABASE_S"] = "| cffFFFFFF% s | r ha dati di fazione di Orda / Alleanza che non sono sincronizzati. Aggiorna le impostazioni del client RaiderIO per sincronizzare entrambe le fazioni."
L["OUTDATED_DATABASE"] = "Punteggi aggiornati a %d Giorni fa."
L["OUTDATED_DATABASE_HOURS"] = "Punteggi aggiornati a %d Ore fa."
L["OUTDATED_DATABASE_S"] = "| cffFFFFFF% s | r sta utilizzando dati | cffFF6666% d | r giorni precedenti. Si prega di aggiornare l'addon per risultati più accurati di Mitiche Chiavi del Potere."
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
L["PLAYER_PROFILE_TITLE"] = "Profilo M+ Giocatore"
L["PREV_SEASON_SUFFIX"] = "(*)"
L["PREVIOUS_SCORE"] = "Punteggio M+ precedente"
L["PROFILE_BEST_RUNS"] = "Miglior Corsa per Spedizione"
L["PROVIDER_NOT_LOADED"] = "| cffFF0000Warning: | r | cffFFFFFF% s | r non riesce a trovare i dati per la fazione corrente. Controllare le impostazioni | cffFFFFFF / raiderio | r e abilitare i dati del tooltip per | cffFFFFFF% s | r."
L["RAID_ABBREVIATION_ULD"] = "ULD"
L["RAID_BOSS_ABT_1"] = "Garothi"
L["RAID_BOSS_ABT_10"] = "Aggramar"
L["RAID_BOSS_ABT_11"] = "Argus"
L["RAID_BOSS_ABT_2"] = "Vilsegugi"
L["RAID_BOSS_ABT_3"] = "Guardiana dei Portali"
L["RAID_BOSS_ABT_4"] = "Alto Comando"
L["RAID_BOSS_ABT_5"] = "Eonar"
L["RAID_BOSS_ABT_6"] = "Imonar"
L["RAID_BOSS_ABT_7"] = "Kin'garoth"
L["RAID_BOSS_ABT_8"] = "Varimathras"
L["RAID_BOSS_ABT_9"] = "Congrega delle Shivarra"
L["RAID_BOSS_BOD_1"] = "Campionessa della Luce"
L["RAID_BOSS_BOD_2"] = "Grong"
L["RAID_BOSS_BOD_3"] = "Maestri Giadafulgida"
L["RAID_BOSS_BOD_4"] = "Opulenza"
L["RAID_BOSS_BOD_5"] = "Conclave dei Prescelti"
L["RAID_BOSS_BOD_6"] = "Re Rastakhan"
L["RAID_BOSS_BOD_7"] = "Gran Meccanista Meccatork"
L["RAID_BOSS_BOD_8"] = "Blocco Navale Frangitempeste"
L["RAID_BOSS_BOD_9"] = "Dama Jaina Marefiero"
L["RAID_BOSS_EP_1"] = "Comandante Abissale Sivara"
L["RAID_BOSS_EP_2"] = "Behemoth Acquanera"
L["RAID_BOSS_EP_3"] = "Radiosità di Azshara"
L["RAID_BOSS_EP_4"] = "Dama Bracescura"
L["RAID_BOSS_EP_5"] = "Orgozoa"
L["RAID_BOSS_EP_6"] = "Corte della Regina"
L["RAID_BOSS_EP_7"] = "Za'qul"
L["RAID_BOSS_EP_8"] = "Regina Azshara"
--[[Translation missing --]]
--[[ L["RAID_BOSS_NYA_1"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAID_BOSS_NYA_10"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAID_BOSS_NYA_11"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAID_BOSS_NYA_12"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAID_BOSS_NYA_2"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAID_BOSS_NYA_3"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAID_BOSS_NYA_4"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAID_BOSS_NYA_5"] = ""--]] 
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
L["RAID_BOSS_ULD_3"] = "Divoratore Fetido"
L["RAID_BOSS_ULD_4"] = "Zek'voz"
L["RAID_BOSS_ULD_5"] = "Vectis"
L["RAID_BOSS_ULD_6"] = "Zul, Rinato"
L["RAID_BOSS_ULD_7"] = "Mythrax"
L["RAID_BOSS_ULD_8"] = "G'huun"
L["RAID_DIFFICULTY_NAME_HEROIC"] = "Eroica"
L["RAID_DIFFICULTY_NAME_MYTHIC"] = "Mitica"
L["RAID_DIFFICULTY_NAME_NORMAL"] = "Normale"
L["RAID_DIFFICULTY_SUFFIX_HEROIC"] = "HC"
L["RAID_DIFFICULTY_SUFFIX_MYTHIC"] = "M"
L["RAID_DIFFICULTY_SUFFIX_NORMAL"] = "NM"
L["RAID_ENCOUNTERS_DEFEATED_TITLE"] = "Boss Incursione Sconfitti"
L["RAID_PROGRESS_TITLE"] = "Progresso Incursione"
L["RAIDERIO_AVERAGE_PLAYER_SCORE"] = "Media Punteggio per +%s in Tempo"
L["RAIDERIO_BEST_RUN"] = "Raider.IO migliore scorreria M+"
L["RAIDERIO_CLIENT_CUSTOMIZATION"] = "Personalizzazione del client RaiderIO"
L["RAIDERIO_MP_BASE_SCORE"] = "Raider.IO M+ Punteggio Base"
L["RAIDERIO_MP_BEST_SCORE"] = "punteggio M+ Raider.IO"
L["RAIDERIO_MP_SCORE"] = "Raider.IO Punteggio M+"
L["RAIDERIO_MP_SCORE_COLON"] = "Raider.IO Punteggio M+:"
L["RAIDERIO_MYTHIC_OPTIONS"] = "Raider.IO Opzioni Addon"
L["RAIDING_DATA_HEADER"] = "Raider.IO Progresso Incursione"
L["RAIDING_DB_MODULES"] = "Moduli Database Incursione"
L["RELOAD_LATER"] = "Ricaricherò Più Tardi"
L["RELOAD_NOW"] = "Ricarica Ora"
--[[Translation missing --]]
--[[ L["SEASON_LABEL_1"] = ""--]] 
--[[Translation missing --]]
--[[ L["SEASON_LABEL_2"] = ""--]] 
--[[Translation missing --]]
--[[ L["SEASON_LABEL_3"] = ""--]] 
--[[Translation missing --]]
--[[ L["SEASON_LABEL_4"] = ""--]] 
L["SHOW_AVERAGE_PLAYER_SCORE_INFO"] = "Visualizza il Punteggio Medio Per Corse In Tempo"
L["SHOW_AVERAGE_PLAYER_SCORE_INFO_DESC"] = "Mostra il punteggio medio Raider.IO visualizzato sui membri delle Spedizioni finite in tempo. Questo è visibile nel Tooltip della Chiava del Potere e nelle descrizioni dei giocatori nella finestra Ricerca delle Incursioni."
L["SHOW_BEST_MAINS_SCORE"] = "Mostra miglior punteggio Mythic+ del PG principale della precedente stagione"
--[[Translation missing --]]
--[[ L["SHOW_BEST_MAINS_SCORE_DESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_BEST_RUN"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_BEST_RUN_DESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_BEST_SEASON"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_BEST_SEASON_DESC"] = ""--]] 
L["SHOW_CLIENT_GUILD_BEST"] = "Mostra i Record nella Ricerca Gruppi per Spedizioni Mitiche"
L["SHOW_CLIENT_GUILD_BEST_DESC"] = "Abilitando questa Opzione verranno visualizzate le 5 migliori Corse della tua Gilda (Stagionale o Settimanale) nella Scheda Spedizioni Mitiche della finestra di Ricerca Gruppi."
--[[Translation missing --]]
--[[ L["SHOW_CURRENT_SEASON"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_CURRENT_SEASON_DESC"] = ""--]] 
L["SHOW_IN_FRIENDS"] = "Mostra in Elenco Amici"
L["SHOW_IN_FRIENDS_DESC"] = "Mostra il Punteggio M+ quando passi il Mouse sopra i tuoi Amici"
L["SHOW_IN_LFD"] = "Mostra in Ricerca delle Spedizioni"
L["SHOW_IN_LFD_DESC"] = "Mostra il Punteggio M+ quando passi il mouse sopra gruppi o candidati."
L["SHOW_IN_SLASH_WHO_RESULTS"] = "Mostra nei risultati del comando /chi"
L["SHOW_IN_SLASH_WHO_RESULTS_DESC"] = "Mostra il Punteggio M+ quando esegui il comendo /chi su un personaggio specifico."
L["SHOW_IN_WHO_UI"] = "Mostra nell'interfaccia \"CHI\""
L["SHOW_IN_WHO_UI_DESC"] = [=[Mostra il Punteggio M+ quando passo il mouse sull'elenco dei giocatori risultanti da una ricerca 
del comando /chi.]=]
L["SHOW_KEYSTONE_INFO"] = "Mostra Informazioni Chiave del Potere"
L["SHOW_KEYSTONE_INFO_DESC"] = "Aggiunge il punteggio Raider.IO di base per le Chiavi nei loro Tooltip. Per ogni giocatore nel tuo gruppo mostra la migliore chiave fatta per la specifica Spedizione."
L["SHOW_LEADER_PROFILE"] = "Permetti il ​​modificatore del Tooltip del profilo RaiderIO"
L["SHOW_LEADER_PROFILE_DESC"] = "Tenere premuto un modificatore (shift/ctlr/alt) per alternare la descrizione del profilo tra Profilo Personale/Profilo Leader."
L["SHOW_MAINS_SCORE"] = "Mostra Punteggio del Personaggio Principale e Progresso Incursione"
L["SHOW_MAINS_SCORE_DESC"] = "Mostra il punteggio del PG Principale del giocatore e i Progressi dell'Incursione sul tooltip. I giocatori devono essere registrati sul sito Raider.IO ed impostare un personaggio come principale."
L["SHOW_ON_GUILD_ROSTER"] = "Mostra nell'elenco Membri di Gilda"
L["SHOW_ON_GUILD_ROSTER_DESC"] = "Mostra il Punteggio M+ quando passi il mouse sopra l'elenco dei giocatori di Gilda."
L["SHOW_ON_PLAYER_UNITS"] = "Mostra sula Finestra del Giocatore"
L["SHOW_ON_PLAYER_UNITS_DESC"] = "Mostra il Punteggio M+ quando passi il mouse sopra un Giocatore."
L["SHOW_RAID_ENCOUNTERS_IN_PROFILE"] = "Mostra i progressi delle Incursioni nel Tooltip del Profilo."
L["SHOW_RAID_ENCOUNTERS_IN_PROFILE_DESC"] = "Quando impostato, mostrerà i progressi delle Incursioni nel Tooltip di RaiderIO."
--[[Translation missing --]]
--[[ L["SHOW_RAIDERIO_BESTRUN_FIRST"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_RAIDERIO_BESTRUN_FIRST_DESC"] = ""--]] 
L["SHOW_RAIDERIO_PROFILE"] = "Mostra il Tooltip del Profilo RaiderIO"
L["SHOW_RAIDERIO_PROFILE_DESC"] = "Mostra il Popup del Profilo RaiderIO"
--[[Translation missing --]]
--[[ L["SHOW_ROLE_ICONS"] = ""--]] 
L["SHOW_ROLE_ICONS_DESC"] = "Quando abilitata, il miglior ruolo del giocatore nelle Mitiche+ verrà mostrato nel tooltip"
L["SHOW_SCORE_IN_COMBAT"] = "Mostra Punteggio in Combattimento"
L["SHOW_SCORE_IN_COMBAT_DESC"] = "Disabilita per minimizzare l'impatto sulle prestazioni mentre si passa il mouse sopra i giocatori durante il combattimento."
L["TANK"] = "Difensore"
L["TANK_SCORE"] = "Punteggio Difensore"
L["TIMED_10_RUNS"] = "+10-14 In Tempo"
L["TIMED_15_RUNS"] = "15+ In Tempo"
L["TIMED_20_RUNS"] = "20+ In Tempo"
L["TIMED_5_RUNS"] = "+5-9 In Tempo"
L["TOOLTIP_CUSTOMIZATION"] = "Personalizzazione Finestra Tooltip"
L["TOOLTIP_PROFILE"] = "Personalizzazione Finestra Tooltip del Profilo RaiderIO"
L["TOTAL_MP_SCORE"] = "Punteggio Mythic+"
L["TOTAL_RUNS"] = "Corse Totali in \"BFA\""
L["UNKNOWN_SCORE"] = "Sconosciuto"
L["UNKNOWN_SERVER_FOUND"] = "| cffFFFFFF% s | r ha rilevato un nuovo server. Si prega di scrivere queste informazioni | cffFF9999 {| r | cffFFFFFF% s | r | cffFF9999, | r | cffFFFFFF% s | r | cffFF9999} | r e segnalarlo agli sviluppatori. Grazie!"
L["UNLOCKING_PROFILE_FRAME"] = "RaiderIO: Sblocco della Finetra Profilo M+"
L["USE_ENGLISH_ABBREVIATION"] = "Forza Abbreviazioni dei Dungeon in Inglese"
L["USE_ENGLISH_ABBREVIATION_DESC"] = "Quando selezionato, verranno usate le abbreviazioni per i nomi dei dungeon in Inglese, al posto della lingua corrente."
L["WARNING_DEBUG_MODE_ENABLE"] = "|cffFFFFFF%s|r La modalità Debug è abilitata. Per disabilitarla digita /raiderio debug|r"
L["WARNING_LOCK_POSITION_FRAME_AUTO"] = "RaiderIO: Devi prima Disabilitare \"Posizionamento Automatico\" per il Profilo RaiderIO."


	ns.L = L
end
