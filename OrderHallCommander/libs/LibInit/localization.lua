local LibStub=LibStub
local MAJOR_VERSION="LibInit"
local libinit,MINOR_VERSION = LibStub("LibInit")
if not libinit then return end
local me=MAJOR_VERSION .. MINOR_VERSION
local l=LibStub("AceLocale-3.0")
local L=l:NewLocale(me,"enUS",true,true)
if L then
L["Configuration"] = "Configuration"
L["Description"] = "Description"
L["Libraries"] = "Libraries"
L["Profile"] = "Profile"
L["Purge_Desc"] = "You can delete all unused profiles with just one click"
L["Purge1"] = "Delete unused profiles"
L["Purge2"] = "Deletes all profiles that are not used by a character"
L["Release Notes"] = "Release Notes"
L["Toggles"] = "Toggles"
L["UseDefault_Desc"] = "You can force all your characters to use the \"%s\" profile in order to manage a single configuration"
L["UseDefault1"] = "Switch all characters to \"%s\" profile"
L["UseDefault2"] = "Uses the \"%s\" profiles for all your toons"
end
L=l:NewLocale(me,'ptBR')
if L then
L["Configuration"] = "configura\195\167\195\163o"
L["Description"] = "Descri\195\167\195\163o"
L["Libraries"] = "bibliotecas"
L["Profile"] = "Perfil"
L["Purge_Desc"] = "Voc\195\170 pode apagar todos os perfis n\195\163o utilizados com apenas um clique"
L["Purge1"] = "Excluir perfis n\195\163o utilizados"
L["Purge2"] = "Exclui todos os perfis que n\195\163o s\195\163o utilizados por um personagem"
L["Release Notes"] = "Notas de Lan\195\167amento"
L["Toggles"] = "Alterna"
L["UseDefault_Desc"] = "Voc\195\170 pode for\195\167ar todos os seus personagens para usar a \"% s\" perfil a fim de gerir uma \195\186nica configura\195\167\195\163o"
L["UseDefault1"] = "Mudar todos os caracteres para \"% s\" perfil"
L["UseDefault2"] = "Usa a \"% s\" perfis para todos os seus personagens"
end
L=l:NewLocale(me,'frFR')
if L then
L["Configuration"] = "configuration"
L["Description"] = "description"
L["Libraries"] = "biblioth\195\168ques"
L["Profile"] = "Profil"
L["Purge_Desc"] = "Vous pouvez supprimer tous les profils inutilis\195\169s en un seul clic"
L["Purge1"] = "Supprimer les profils inutilis\195\169s"
L["Purge2"] = "Supprime tous les profils qui ne sont pas utilis\195\169s par un caract\195\168re"
L["Release Notes"] = "notes de version"
L["Toggles"] = "Bascule"
L["UseDefault_Desc"] = "Vous pouvez forcer tous vos personnages \195\160 utiliser le profil du \"%s\" dans le but de g\195\169rer une configuration unique"
L["UseDefault1"] = "Mettez tous les caract\195\168res au profil \"%s\""
L["UseDefault2"] = "Utilise les profils du \"%s\" pour tous vos personnages"
end
L=l:NewLocale(me,'deDE')
if L then
L["Configuration"] = "Konfiguration"
L["Description"] = "Beschreibung"
L["Libraries"] = "Bibliotheken"
L["Profile"] = "Profil"
L["Purge_Desc"] = "Sie k\195\182nnen mit nur einem Klick alle nicht verwendeten Profile l\195\182schen"
L["Purge1"] = "L\195\182schen Sie nicht ben\195\182tigte Profile"
L["Purge2"] = "L\195\182scht alle Profile, die nicht von einem Charakter benutzt werden"
L["Release Notes"] = "Versionshinweise"
L["Toggles"] = "Schaltet"
L["UseDefault_Desc"] = "Sie k\195\182nnen alle Ihre Charaktere dazu zwingen, das Profil \"%s\" zu verwenden, um eine einzelne Konfiguration zu verwalten"
L["UseDefault1"] = "Alle Charaktere auf das Profil \"%s\" umschalten"
L["UseDefault2"] = "Verwendet die Profile \"%s\" f\195\188r alle Toons"
end
L=l:NewLocale(me,'itIT')
if L then
L["Configuration"] = "Configurazione"
L["Description"] = "Descrizione"
L["Libraries"] = "Librerie"
L["Profile"] = "Profilo"
L["Purge_Desc"] = "Puoi cancellare tutti i profili inutilizzati con un singolo click"
L["Purge1"] = "Cancella i profili inutilizzati"
L["Purge2"] = "Cancella tutti i profili che non sono usati da un personaggio"
L["Release Notes"] = "Note di rilascio"
L["Toggles"] = "Interruttori"
L["UseDefault_Desc"] = "Puoi far usare a tutti i tuoi personaggi il profilo \"%s\""
L["UseDefault1"] = "Imposta il profilo \"%s\" su tutti i personaggi"
L["UseDefault2"] = "Usa il profilo '%s\" per tutti i personaggi"
end
L=l:NewLocale(me,'koKR')
if L then
L["Configuration"] = "\234\181\172\236\132\177"
L["Description"] = "\236\132\164\235\170\133"
L["Libraries"] = "\235\157\188\236\157\180\235\184\140\235\159\172\235\166\172"
L["Profile"] = "\236\156\164\234\179\189"
L["Purge_Desc"] = "\235\139\185\236\139\160\236\157\128 \237\149\156 \235\178\136\236\157\152 \237\129\180\235\166\173\236\156\188\235\161\156 \235\170\168\235\147\160 \236\130\172\236\154\169\235\144\152\236\167\128 \236\149\138\236\157\128 \237\148\132\235\161\156\237\149\132\236\157\132 \236\130\173\236\160\156\237\149\160 \236\136\152 \236\158\136\236\138\181\235\139\136\235\139\164"
L["Purge1"] = "\236\130\172\236\154\169\237\149\152\236\167\128 \236\149\138\235\138\148 \237\148\132\235\161\156\237\149\132\236\157\132 \236\130\173\236\160\156"
L["Purge2"] = "\235\172\184\236\158\144\234\176\128 \236\130\172\236\154\169\235\144\152\236\167\128 \236\149\138\236\157\128 \235\170\168\235\147\160 \237\148\132\235\161\156\237\140\140\236\157\188\236\157\132 \236\130\173\236\160\156\237\149\169\235\139\136\235\139\164"
L["Release Notes"] = "\235\166\180\235\166\172\236\138\164 \235\133\184\237\138\184"
L["Toggles"] = "\236\160\132\237\153\152"
L["UseDefault_Desc"] = "\235\139\168\236\157\188 \234\181\172\236\132\177\236\157\132 \234\180\128\235\166\172\237\149\152\234\184\176 \236\156\132\237\149\180 \"% s\"\237\148\132\235\161\156\237\140\140\236\157\188\236\157\132 \236\130\172\236\154\169\237\149\152\236\151\172 \235\170\168\235\147\160 \235\172\184\236\158\144\235\165\188 \234\176\149\236\160\156"
L["UseDefault1"] = "\"%s\"\237\148\132\235\161\156\237\149\132\236\151\144 \235\170\168\235\147\160 \235\172\184\236\158\144\235\165\188 \236\160\132\237\153\152"
L["UseDefault2"] = "\235\170\168\235\147\160 \235\172\184\236\158\144\236\151\144 \235\140\128\237\149\180 \"%s\"\237\148\132\235\161\156\237\140\140\236\157\188\236\157\132 \236\130\172\236\154\169\237\149\152\236\151\172"
end
L=l:NewLocale(me,'esMX')
if L then
L["Configuration"] = "Configuraci\195\179n,"
L["Description"] = "Descripci\195\179n,"
L["Libraries"] = "bibliotecas,"
L["Profile"] = "Perfil,"
L["Purge_Desc"] = "Puede eliminar todos los perfiles utilizados con s\195\179lo un clic"
L["Purge1"] = "Eliminar los perfiles no utilizados"
L["Purge2"] = "Elimina todos los perfiles que no sean utilizadas por un personaje"
L["Release Notes"] = "Notas de la versi\195\179n"
L["Toggles"] = "Alterna"
L["UseDefault_Desc"] = "Puede forzar a todos tus personajes para usar el perfil \"%s\" con el fin de administrar una sola configuraci\195\179n"
L["UseDefault1"] = "Cambiar todos los caracteres de perfil \"%s\""
L["UseDefault2"] = "Utiliza los perfiles de la \"%s\" para todos sus caracteres"
end
L=l:NewLocale(me,'ruRU')
if L then
L["Configuration"] = "\208\154\208\190\208\189\209\132\208\184\208\179\209\131\209\128\208\176\209\134\208\184\209\143,"
L["Description"] = "\208\158\208\191\208\184\209\129\208\176\208\189\208\184\208\181,"
L["Libraries"] = "\208\145\208\184\208\177\208\187\208\184\208\190\209\130\208\181\208\186\208\184,"
L["Profile"] = "\208\159\209\128\208\190\209\132\208\184\208\187\209\140,"
L["Purge_Desc"] = "\208\156\208\190\208\182\208\189\208\190 \209\131\208\180\208\176\208\187\208\184\209\130\209\140 \208\178\209\129\208\181 \208\189\208\181\208\184\209\129\208\191\208\190\208\187\209\140\208\183\209\131\208\181\208\188\209\139\208\181 \208\191\209\128\208\190\209\132\208\184\208\187\208\184 \209\129 \208\191\208\190\208\188\208\190\209\137\209\140\209\142 \208\178\209\129\208\181\208\179\208\190 \208\190\208\180\208\189\208\190\208\179\208\190 \208\186\208\187\208\184\208\186\208\176"
L["Purge1"] = "\208\163\208\180\208\176\208\187\208\181\208\189\208\184\208\181 \208\189\208\181\208\184\209\129\208\191\208\190\208\187\209\140\208\183\209\131\208\181\208\188\209\139\209\133 \208\191\209\128\208\190\209\132\208\184\208\187\208\181\208\185"
L["Purge2"] = "\208\163\208\180\208\176\208\187\209\143\208\181\209\130 \208\178\209\129\208\181 \208\191\209\128\208\190\209\132\208\184\208\187\208\184, \208\186\208\190\209\130\208\190\209\128\209\139\208\181 \208\189\208\181 \208\184\209\129\208\191\208\190\208\187\209\140\208\183\209\131\209\142\209\130\209\129\209\143 \208\191\208\181\209\128\209\129\208\190\208\189\208\176\208\182\208\181\208\188"
L["Release Notes"] = "\208\159\209\128\208\184\208\188\208\181\209\135\208\176\208\189\208\184\209\143 \208\186 \208\178\209\139\208\191\209\131\209\129\208\186\209\131"
L["Toggles"] = "\208\146\208\186\208\187\209\142\209\135\208\181\208\189\208\184\208\181 \208\184\208\187\208\184 \208\178\209\139\208\186\208\187\209\142\209\135\208\181\208\189\208\184\208\181"
L["UseDefault_Desc"] = "\208\146\209\139 \208\188\208\190\208\182\208\181\209\130\208\181 \208\183\208\176\209\129\209\130\208\176\208\178\208\184\209\130\209\140 \208\178\209\129\208\181 \209\129\208\184\208\188\208\178\208\190\208\187\209\139 \208\184\209\129\208\191\208\190\208\187\209\140\208\183\208\190\208\178\208\176\209\130\209\140 \"%s\" \208\191\209\128\208\190\209\132\208\184\208\187\209\140 \208\180\208\187\209\143 \209\130\208\190\208\179\208\190, \209\135\209\130\208\190\208\177\209\139 \209\131\208\191\209\128\208\176\208\178\208\187\209\143\209\130\209\140 \208\190\208\180\208\189\208\190\208\185 \208\186\208\190\208\189\209\132\208\184\208\179\209\131\209\128\208\176\209\134\208\184\208\184"
L["UseDefault1"] = "\208\146\208\186\208\187\209\142\209\135\208\184\209\130\208\181 \208\178\209\129\208\181 \209\129\208\184\208\188\208\178\208\190\208\187\209\139 \"%s\" \208\191\209\128\208\190\209\132\208\184\208\187\209\140"
L["UseDefault2"] = "\208\152\209\129\208\191\208\190\208\187\209\140\208\183\209\131\208\181\209\130 \"%s\" \208\191\209\128\208\190\209\132\208\184\208\187\208\184 \208\180\208\187\209\143 \208\178\209\129\208\181\209\133 \208\178\208\176\209\136\208\184\209\133 \208\191\208\181\209\128\209\129\208\190\208\189\208\176\208\182\208\181\208\185"
end
L=l:NewLocale(me,'zhCN')
if L then
L["Configuration"] = "\231\187\132\230\128\129\239\188\140"
L["Description"] = "\230\143\143\232\191\176\239\188\140"
L["Libraries"] = "\229\155\190\228\185\166\233\166\134\239\188\140"
L["Profile"] = "\228\184\170\228\186\186\232\181\132\230\150\153\239\188\140"
L["Purge_Desc"] = "\230\130\168\229\143\175\228\187\165\229\136\160\233\153\164\230\137\128\230\156\137\230\156\170\228\189\191\231\148\168\231\154\132\233\133\141\231\189\174\230\150\135\228\187\182\239\188\140\229\143\170\233\156\128\231\130\185\229\135\187\228\184\128\228\184\139"
L["Purge1"] = "\229\136\160\233\153\164\230\156\170\228\189\191\231\148\168\231\154\132\233\133\141\231\189\174\230\150\135\228\187\182"
L["Purge2"] = "\229\136\160\233\153\164\230\156\170\228\189\191\231\148\168\231\154\132\229\173\151\231\172\166\230\137\128\230\156\137\233\133\141\231\189\174\230\150\135\228\187\182"
L["Release Notes"] = "\229\143\145\232\161\140\232\175\180\230\152\142"
L["Toggles"] = "\229\136\135\230\141\162"
L["UseDefault_Desc"] = "\230\130\168\229\143\175\228\187\165\229\188\186\229\136\182\230\137\128\230\156\137\232\167\146\232\137\178\228\189\191\231\148\168\226\128\156\239\188\133s\226\128\157\231\154\132\228\184\170\228\186\186\232\181\132\230\150\153\239\188\140\228\187\165\231\174\161\231\144\134\228\184\128\228\184\170\229\141\149\228\184\128\231\154\132\233\133\141\231\189\174"
L["UseDefault1"] = "\228\186\164\230\141\162\230\156\186\231\154\132\230\137\128\230\156\137\229\173\151\231\172\166\226\128\156\239\188\133s\226\128\157\231\154\132\228\184\170\228\186\186\232\181\132\230\150\153"
L["UseDefault2"] = "\228\189\191\231\148\168\226\128\156\239\188\133s\226\128\157\230\155\178\231\186\191\231\154\132\230\137\128\230\156\137\232\167\146\232\137\178"
end
L=l:NewLocale(me,'esES')
if L then
L["Configuration"] = "Configuraci\195\179n,"
L["Description"] = "Descripci\195\179n,"
L["Libraries"] = "bibliotecas,"
L["Profile"] = "Perfil,"
L["Purge_Desc"] = "Puede eliminar todos los perfiles utilizados con s\195\179lo un clic"
L["Purge1"] = "Eliminar los perfiles no utilizados"
L["Purge2"] = "Elimina todos los perfiles que no sean utilizadas por un personaje"
L["Release Notes"] = "Notas de la versi\195\179n"
L["Toggles"] = "Alterna"
L["UseDefault_Desc"] = "Puede forzar a todos tus personajes para usar el perfil \"%s\" con el fin de administrar una sola configuraci\195\179n"
L["UseDefault1"] = "Cambiar todos los caracteres de perfil \"%s\""
L["UseDefault2"] = "Utiliza los perfiles de la \"%s\" para todos sus caracteres"
end
L=l:NewLocale(me,'zhTW')
if L then
L["%1$d%% lower than %2$d%%. Lower %s"] = "%1$d%% è inferiore a %2$d%%. Abbassa %s"
--[[Translation missing --]]
L["%s for a wowhead link popup"] = "%s for a wowhead link popup"
--[[Translation missing --]]
L["%s start the mission without even opening the mission page. No question asked"] = "%s start the mission without even opening the mission page. No question asked"
--[[Translation missing --]]
L["%s starts missions"] = "%s starts missions"
--[[Translation missing --]]
L["%s to actually start mission"] = "%s to actually start mission"
L["%s to blacklist"] = "Clicca col destro per mettere in blacklist"
L["%s to remove from blacklist"] = "Clicca col destro per rimuovere dalla blacklist"
--[[Translation missing --]]
L[ [=[%s, please review the tutorial
(Click the icon to dismiss this message and start the tutorial)]=] ] = [=[%s, please review the tutorial
(Click the icon to dismiss this message and start the tutorial)]=]
--[[Translation missing --]]
L["%s, please review the tutorial\\n(Click the icon to dismiss this message)"] = "%s, please review the tutorial\\n(Click the icon to dismiss this message)"
--[[Translation missing --]]
L["Allow to start a mission directly from the mission list page (no single mission page shown)"] = "Allow to start a mission directly from the mission list page (no single mission page shown)"
L["Always counter increased resource cost"] = "Contrasta sempre incremento risorse"
L["Always counter increased time"] = "Contrasta sempre incremento durata"
L["Always counter kill troops (ignored if we can only use troops with just 1 durability left)"] = "Contrasta sempre morte milizie (ignorato tutte le milizie hanno solo una vita rimanente)"
L["Always counter no bonus loot threat"] = "Contrasta sempre il \"no bonus\""
--[[Translation missing --]]
L["and then by:"] = "and then by:"
L["Artifact shown value is the base value without considering knowledge multiplier"] = "Il valore mostrato è quello base, senza considerare il moltiplicatore dalla conoscenza"
L["Attempting %s"] = "Provo %s"
L["Base Chance"] = "Percentuale base"
L["Better parties available in next future"] = "Ci sono combinazioni migliori nel futuro"
L["Blacklisted"] = "In blacklist"
L["Blacklisted missions are ignored in Mission Control"] = "Le missioni in blacklist vengono ignorate negli automatismi"
L["Bonus Chance"] = "Percentuale globale"
L["Building Final report"] = "Sto preparando il rapporto finale"
L["but using troops with just one durability left"] = "ma uso truppe con solo un punto vita rimasto"
L["Capped %1$s. Spend at least %2$d of them"] = "%1$s ha un limite. Spendine almeno %2%d"
L["Changes the sort order of missions in Mission panel"] = "Cambia l'ordine delle mission nel Pannello Missioni"
L["Combat ally is proposed for missions so you can consider unassigning him"] = "Viene proposto l'alleato, per poter valutare se rimuoverlo dalla missione di scorta"
L["Complete all missions without confirmation"] = "Completa tutte le missioni senza chiedere conferma"
L["Configuration for mission party builder"] = "Configurazioni per il generatore di gruppi"
L["Cost reduced"] = "Costo ridotto"
L["Could not fulfill mission, aborting"] = "Non riesco a completare il party per la missione, rinuncio"
L["Counter kill Troops"] = "Contrasta \"Uccide le truppe\""
--[[Translation missing --]]
L["Customization options (non mission related)"] = "Customization options (non mission related)"
L["Disables warning: "] = "Disabilita l'avviso:"
L["Dont use this slot"] = "Non usare questo slot"
L["Don't use troops"] = "Non usare truppe"
L["Duration reduced"] = "Durata ridotta"
L["Duration Time"] = "Durata"
--[[Translation missing --]]
L["Elite: Prefer overcap"] = "Elite: Prefer overcap"
L["Elites mission mode"] = "Modalità missioni \"elite\""
L["Empty missions sorted as last"] = "Le missioni senza campioni vengono ordinate come ultime"
L["Empty or 0% success mission are sorted as last. Does not apply to \"original\" method"] = "Le missioni senza campioni o con lo 0% o meno di possibilità di successo vengono ordinate come ultime. Non si applica all'ordinamento originale Blizzard"
L["Equipped by following champions:"] = "Usato da questi campioni:"
L["Expiration Time"] = "Scadenza"
L["Favours leveling follower for xp missions"] = "Preferisci i campioni che devono livellare"
--[[Translation missing --]]
L["For elite missions, tries hard to not go under 100% even at cost of overcapping"] = "For elite missions, tries hard to not go under 100% even at cost of overcapping"
L["General"] = "Generale"
L["Global approx. xp reward"] = "Approssimativi PE globali"
L["Global approx. xp reward per hour"] = "Approssimativi PE globali per ora"
L["HallComander Quick Mission Completion"] = "OrderHallCommander Completamento rapido"
L["If %1$s is lower than this, then we try to achieve at least %2$s without going over 100%%. Ignored for elite missions."] = "Se %1$s è inferiore a questa, allora cerchiamo di raggiungere almeno %2$s senza superare il 100%%. Viene ignorato nelle missioni elite."
L["If not checked, inactive followers are used as last chance"] = "Se non attivo, visualizzerà seguaci inattivi pur di riempire la missione"
L[ [=[If you %s, you will lose them
Click on %s to abort]=] ] = "Se %s le perderai. Clicca su %s per interrompere"
L["Ignore busy followers"] = "Ignora i seguaci occupati"
L["Ignore inactive followers"] = "Ignora i seguaci inattivi"
L["Keep cost low"] = "Mantieni il costo basso"
L["Keep extra bonus"] = "Ottieni il bonus aggiuntivo"
L["Keep time short"] = "Riduci la durata"
L["Keep time VERY short"] = "Riduci MOLTO la durata"
--[[Translation missing --]]
L[ [=[Launch the first filled mission with at least one locked follower.
Keep %s pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = [=[Launch the first filled mission with at least one locked follower.
Keep %s pressed to actually launch, a simple click will only print mission name with its followers list]=]
--[[Translation missing --]]
L[ [=[Launch the first filled mission with at least one locked follower.
Keep SHIFT pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = [=[Launch the first filled mission with at least one locked follower.
Keep SHIFT pressed to actually launch, a simple click will only print mission name with its followers list]=]
L["Level"] = "Livello"
L["Lock all"] = "Riserva tutti"
L["Lock this follower"] = "Riserva questo seguace"
L["Locked follower are only used in this mission"] = "I seguaci riservati saranno usati solo in questa missione"
L["Make Order Hall Mission Panel movable"] = "Rendi spostabile il pannello missioni"
L["Makes sure that no troops will be killed"] = "Si accerta che nessuna truppa venga uccisa"
L["Max champions"] = "Campioni massimi"
L["Maximize xp gain"] = "Massimizza il guadagno di PE"
L["Mission duration reduced"] = "Durata missione ridotta"
L["Mission was capped due to total chance less than"] = "La percentuale di success è stata ridotta perché era comunque inferiore a"
L["Missions"] = "Missioni"
L["Never kill Troops"] = "Non uccidere mai le truppe"
L["No follower gained xp"] = "Nessun campione ha guaagnato PE"
L["No suitable missions. Have you reserved at least one follower?"] = "Nessuna missione valida. Hai riservato almeno un seguace?"
L["Not blacklisted"] = "Non blacklistata"
L["Nothing to report"] = "Niente da segnalare"
L["Notifies you when you have troops ready to be collected"] = "Notificami quando ho truppe pronte per essere raccolte"
L["Only accept missions with time improved"] = "Accetta solo missioni con bonus durata ridotta"
L["Only consider elite missions"] = "Visualizza solo missioni elite"
--[[Translation missing --]]
L["Only need %s instead of %s to start a mission from mission list"] = "Only need %s instead of %s to start a mission from mission list"
L["Only use champions even if troops are available"] = "Usa solo campioni anche se ci sono truppe disponibili"
--[[Translation missing --]]
L["Open configuration"] = "Open configuration"
L[ [=[OrderHallCommander overrides GarrisonCommander for Order Hall Management.
 You can revert to GarrisonCommander simply disabling OrderhallCommander.
If instead you like OrderHallCommander remember to add it to Curse client and keep it updated]=] ] = [=[OrderHallCommander sostituisce l'interfaccia di GarrisonComamnder per le missioni di classe
Disabilitalo se preferisci GarrisonCommander.
Se invece ti piace, aggiungilo al client Curse e tienilo aggiornato]=]
L["Original method"] = "Metodo originale"
L["Position is not saved on logout"] = "La posizione non è salvata alla disconnessione"
L["Prefer high durability"] = "Alta durabilità preferita"
L["Quick start first mission"] = "Avvio rapido prima missione"
L["Remove no champions warning"] = "Rimuovi avviso campioni insufficienti"
--[[Translation missing --]]
L["Restart tutorial from beginning"] = "Restart tutorial from beginning"
--[[Translation missing --]]
L["Resume tutorial"] = "Resume tutorial"
L["Resurrect troops effect"] = "Resurrezione truppe possibile"
L["Reward type"] = "Tipo ricompensa"
--[[Translation missing --]]
L["Sets all switches to a very permissive setup. Very similar to 1.4.4"] = "Sets all switches to a very permissive setup. Very similar to 1.4.4"
--[[Translation missing --]]
L["Show tutorial"] = "Show tutorial"
L["Show/hide OrderHallCommander mission menu"] = "Mostra/ascondi il menu di missione di OrderHallCommander"
L["Sort missions by:"] = "Ordina le missioni per:"
L["Started with "] = "Avviata con"
L["Success Chance"] = "Percentuale di successo"
L["Troop ready alert"] = "Avviso truppe pronte"
L["Unable to fill missions, raise \"%s\""] = "Non riesco ad assegnare seguaci alle mission, incrementa \"%s\""
L["Unable to fill missions. Check your switches"] = "Impossibile riempire le missioni. Controlla le opzioni scelte"
L["Unable to start mission, aborting"] = "Non riesco a far partire la missione, rinuncio"
L["Unlock all"] = "Libera tutti"
L["Unlock this follower"] = "Libera questo seguace"
L["Unlocks all follower and slots at once"] = "Libera tutti i seguaci riservati e gli slot vietati in un colpo solo"
--[[Translation missing --]]
L["Unsafe mission start"] = "Unsafe mission start"
L["Upgrading to |cff00ff00%d|r"] = "Incremento a |cff00ff00%d|r"
L["URL Copy"] = "Copia la URL"
L["Use at most this many champions"] = "Usa al massimo questo numero di campioni"
L["Use combat ally"] = "Usa l'alleato"
L["Use this slot"] = "Usa questo slot"
L["Uses troops with the highest durability instead of the ones with the lowest"] = "Sceglie la truppe con durabilità residua piu' alta anziché quelle con durabilità residua piu' bassa"
L["When no free followers are available shows empty follower"] = "Quando non ci sono seguaci disponibili mostra le caselle vuote"
L["When we cant achieve the requested %1$s, we try to reach at least this one without (if possible) going over 100%%"] = "Se non è possibile raggiungere la percentuale di successo globale, si cerca di raggiungere almeno questa senza superare il 100%"
L["Would start with "] = "Avvierei con"
L["You are wasting |cffff0000%d|cffffd200 point(s)!!!"] = "Stai sprecando |cffff0000%d|cffffd200 punti!!"
--[[Translation missing --]]
L[ [=[You need to close and restart World of Warcraft in order to update this version of OrderHallCommander.
Simply reloading UI is not enough]=] ] = [=[You need to close and restart World of Warcraft in order to update this version of OrderHallCommander.
Simply reloading UI is not enough]=]
--[[Translation missing --]]
L["You now need to press both %s and %s to start mission"] = "You now need to press both %s and %s to start mission"

L["Configuration"] = "\231\181\132\230\133\139\239\188\140"
L["Description"] = "\230\143\143\232\191\176\239\188\140"
L["Libraries"] = "\229\156\150\230\155\184\233\164\168\239\188\140"
L["Profile"] = "\229\128\139\228\186\186\232\179\135\230\150\153\239\188\140"
L["Purge_Desc"] = "\230\130\168\229\143\175\228\187\165\229\136\170\233\153\164\230\137\128\230\156\137\230\156\170\228\189\191\231\148\168\231\154\132\233\133\141\231\189\174\230\150\135\228\187\182\239\188\140\229\143\170\233\156\128\233\187\158\230\147\138\228\184\128\228\184\139"
L["Purge1"] = "\229\136\170\233\153\164\230\156\170\228\189\191\231\148\168\231\154\132\233\133\141\231\189\174\230\150\135\228\187\182"
L["Purge2"] = "\229\136\170\233\153\164\230\156\170\228\189\191\231\148\168\231\154\132\229\173\151\231\172\166\230\137\128\230\156\137\233\133\141\231\189\174\230\150\135\228\187\182"
L["Release Notes"] = "\231\153\188\232\161\140\232\170\170\230\152\142"
L["Toggles"] = "\229\136\135\230\143\155"
L["UseDefault_Desc"] = "\230\130\168\229\143\175\228\187\165\229\188\183\229\136\182\230\137\128\230\156\137\232\167\146\232\137\178\228\189\191\231\148\168\226\128\156\239\188\133s\226\128\157\231\154\132\229\128\139\228\186\186\232\179\135\230\150\153\239\188\140\228\187\165\231\174\161\231\144\134\228\184\128\229\128\139\229\150\174\228\184\128\231\154\132\233\133\141\231\189\174"
L["UseDefault1"] = "\228\186\164\230\143\155\230\169\159\231\154\132\230\137\128\230\156\137\229\173\151\231\172\166\226\128\156\239\188\133s\226\128\157\231\154\132\229\128\139\228\186\186\232\179\135\230\150\153"
L["UseDefault2"] = "\228\189\191\231\148\168\226\128\156\239\188\133s\226\128\157\230\155\178\231\183\154\231\154\132\230\137\128\230\156\137\232\167\146\232\137\178"
end
libinit:_SetLocalization(l:GetLocale(me,true))

