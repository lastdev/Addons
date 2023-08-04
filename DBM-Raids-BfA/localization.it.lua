if GetLocale() ~= "itIT" then return end
local L

---------------------------
-- Taloc the Corrupted --
---------------------------
L= DBM:GetModLocalization(2168)

L:SetMiscLocalization({
	Aggro	 =	"Ha l'Aggro"
})

---------------------------
-- MOTHER --
---------------------------
--L= DBM:GetModLocalization(2167)

---------------------------
-- Fetid Devourer --
---------------------------
L= DBM:GetModLocalization(2146)

L:SetWarningLocalization({
	addsSoon		= "Scarico aperto - Add a Breve"
})

L:SetTimerLocalization({
	chuteTimer		= "Prossimo Scarico (%s)"
})

L:SetOptionLocalization({
	addsSoon		= "Mostra preavviso all'apertura scarichi e inizio evocazione add",
	chuteTimer		= "Mostra temporizzatore apertura Scarichi"
})

---------------------------
-- Zek'vhozj --
---------------------------
L= DBM:GetModLocalization(2169)

L:SetTimerLocalization({
	timerOrbLands	= "Sfera (%s) Atterrata"
})

L:SetOptionLocalization({
	timerOrbLands	 =	"Mostra temporizzatore all'Atterraggio della Sfera della Corruzione",
	EarlyTankSwap	 =	"Mostra avviso cambio tank immediatamente dopo Frantumazione, anziché attendere la 2^ Sferzata del Vuoto"
})

L:SetMiscLocalization({
	CThunDisc	 =	"Accesso al disco effettuato. Caricamento dati di C'thun.",
	YoggDisc	 =	"Accesso al disco effettuato. Caricamento dati di Yogg-Saron.",
	CorruptedDisc =	"Accesso al disco effettuato. Caricamento dati corrotti."
})

---------------------------
-- Vectis --
---------------------------
L= DBM:GetModLocalization(2166)

L:SetOptionLocalization({
	ShowHighestFirst3	 =	"Ordina riquadro info Infezione Persistente dal più alto numero di debuff (anziché dal più basso). Applicabile solo se non impostato solo per il tuo gruppo.",
	ShowOnlyParty		 =	"Mostra Infezione Persistente solo per il tuo gruppo. L'opzione ordina il riquadro per ordine gruppo.",
	SetIconsRegardless	 =	"Imposta icone indipendentemente dall'assist o meno dell'utente con BW (Avanzate)"
})

L:SetMiscLocalization({
	BWIconMsg			 =	"DBM ha passato la marcatura icone a un utente promosso con BW nell'incursione per evitare conflitti. Assicurarsi di abilitare la marcatura, o degradarlo per abilitare ma marcatura DBM, o abilitare l'opzione di esclusione nelle opzioni di Vectis"
})

---------------
-- Mythrax the Unraveler --
---------------
--L= DBM:GetModLocalization(2194)

---------------------------
-- Zul --
---------------------------
L= DBM:GetModLocalization(2195)

L:SetTimerLocalization({
	timerCallofCrawgCD		= "Prossima Pozza Crog (%s)",
	timerCallofHexerCD 		= "Prossima Pozza Sanguemalefico (%s)",
	timerCallofCrusherCD	= "Prossima Pozza Frantumatrice (%s)",
	timerAddIncoming		= DBM_COMMON_L.INCOMMING
})

L:SetOptionLocalization({
	timerCallofCrawgCD		= "Mostra temporizzatore alla formazione delle pozze Crog",
	timerCallofHexerCD 		= "Mostra temporizzatore alla formazione delle pozze Sanguemalefico",
	timerCallofCrusherCD	= "Mostra temporizzatore alla formazione delle pozze Frantumatrici",
	timerAddIncoming		= "Mostra temporizzatore all'attaccabilità dell'add in arrivo",
	TauntBehavior			= "Imposta funzionamento scambi tra tank",
	TwoHardThreeEasy		= "Scambio a 2 stack in eroico/mitico, 3 stack nelle altre difficoltà", -- Default
	TwoAlways				= "Scambia sempre a 2 stack indipendentemente dalla difficoltà",
	ThreeAlways				= "Scambia sempre a 3 stack indipendentemente dalla difficoltà"
})

L:SetMiscLocalization({
	Crusher			=	"Frantumatrice",
	Bloodhexer		=	"Sanguemalefico",
	Crawg			=	"Crog"
})

------------------
-- G'huun --
------------------
L= DBM:GetModLocalization(2147)

L:SetWarningLocalization({
	warnMatrixFail		= "Matrice d'Alimentazione caduta"
})

L:SetOptionLocalization({
	warnMatrixFail		= "Mostra avviso alla caduta della Matrice d'Alimentazione."
})

L:SetMiscLocalization({
	CurrentMatrix		=	"Matrice Attuale:", -- Mitico
	NextMatrix			=	"Prossima Matrice:", -- Mitico
	CurrentMatrixLong	=	"Matrice Attuale (%s):", -- Non Mitico
	NextMatrixLong		=	"Prossima Matrice (%s):" -- Non Mitico
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("UldirTrash")

L:SetGeneralLocalization({
	name =	"Scartini Uldir"
})

---------------------------
--  Ra'wani Kanae/Frida Ironbellows (Both) --
-- Same exact enoucnter, diff names
---------------------------
--L= DBM:GetModLocalization(2344)--Ra'wani Kanae (Alliance)

--L= DBM:GetModLocalization(2333)--Frida Ironbellows (Horde)

---------------------------
--  King Grong/Grong the Revenant (Both) --
---------------------------
--L= DBM:GetModLocalization(2325)--King Grong (Horde)

--L= DBM:GetModLocalization(2340)--Grong the Revenant (Alliance)

---------------------------
--  Grimfang and Firecaller/Flamefist and the Illuminated (Both) --
-- Same exact enoucnter, diff names
---------------------------
--L= DBM:GetModLocalization(2323)--Grimfang and Firecaller (Alliance)

--L= DBM:GetModLocalization(2341)--Flamefist and the Illuminated (Horde)

---------------------------
--  Opulence (Alliance) --
---------------------------
L= DBM:GetModLocalization(2342)

L:SetMiscLocalization({
	Bulwark =	"Protettore",
	Hand	=	"Mano"
})

---------------------------
--  Loa Council (Alliance) --
---------------------------
L= DBM:GetModLocalization(2330)

L:SetMiscLocalization({
	BwonsamdiWrath =	"Well, if ya so eager for death, ya shoulda come see me sooner!", -- TODO
	BwonsamdiWrath2 =	"Sooner or later... everybody serves me!", -- TODO
	Bird			 =	"Uccello" -- TODO
})

---------------------------
--  King Rastakhan (Alliance) --
---------------------------
L= DBM:GetModLocalization(2335)

L:SetOptionLocalization({
	AnnounceAlternatePhase	= "Mostra avvisi generali per le fasi in cui non ti trovi (i temporizzatori verranno comunque sempre mostrati)"
})

---------------------------
-- High Tinker Mekkatorgue (Horde) --
---------------------------
--L= DBM:GetModLocalization(2332)

---------------------------
--  Sea Priest Blockade (Horde) --
---------------------------
--L= DBM:GetModLocalization(2337)

---------------------------
--  Jaina Proudmoore (Horde) --
---------------------------
L= DBM:GetModLocalization(2343)

L:SetOptionLocalization({
	ShowOnlySummary2	= "Nascondi giocatori nel distanziometro inverso e mostra solo info sommarie (totale giocatori vicini)",
	InterruptBehavior	= "Imposta comportamento interruzione elementale (Sovrascriverà ogni impostazione altrui se capogruppo)",
	Three				= "rotazione a 3 persone ",--Default
	Four				= "rotazione a 4 persone ",
	Five				= "rotazione a 5 persone",
	SetWeather			= "Imposta densità effetti climatici al minimo all'ingaggio del boss e ripristina al termine",
})

L:SetMiscLocalization({
	Port			=	"lato porto",
	Starboard		=	"lato tribordo",
	Freezing		=	"Congelamento tra %s"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ZuldazarRaidTrash")

L:SetGeneralLocalization({
	name =	"Scartini Dazar'alor"
})

---------------------------
--  The Restless Cabal --
---------------------------
L= DBM:GetModLocalization(2328)

L:SetMiscLocalization({
	Zaxasj = "Zaxasj",
	Fathuul = "Fa'thuul"
})

---------------------------
-- Uu'nat, Harbinger of the Void --
---------------------------
L= DBM:GetModLocalization(2332)

L:SetOptionLocalization({
	UnstableBehavior2	= "Imposta comportamento Risonanza per l'incursione (Se capoincursione, sovrascrive incursione)",
	SetOne				= "Pietra del Vuoto (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Tridente/Oceano (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t), Tempesta (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t)",
	SetTwo				= "Pietra del Vuoto (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Tridente/Oceano (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t), Tempesta (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t)",--Default
	SetThree			= "Pietra del Vuoto (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Tridente/Oceano (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t), Tempesta (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:0:16|t)",
	SetFour				= "Pietra del Vuoto (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Tridente/Oceano (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t), Tempesta (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:0:16|t)",
	SetFive				= "Pietra del Vuoto (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Tridente/Oceano (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t), Tempesta (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:16:32|t)",
	SetSix				= "Pietra del Vuoto (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Tridente/Oceano (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t), Tempesta (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:16:32|t)"
})

L:SetMiscLocalization({
	Ocean = "Tridente/Oceano",
	Storm = "Richiamo della Tempesta",
	Void = "Pietra del Vuoto",
	Lunacy = "Pazzia",
	DBMConfigMsg	= "Configurazione Risonanza Instabile impostata a %s come da configurazione capoincursione."
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("CrucibleofStormsTrash")

L:SetGeneralLocalization({
	name =	"Scartini Crogiolo"
})

---------------------------
--  Abyssal Commander Sivara --
---------------------------
--L= DBM:GetModLocalization(2352)

---------------------------
--  Rage of Azshara --
---------------------------
--L= DBM:GetModLocalization(2353)

---------------------------
--  Underwater Monstrosity --
---------------------------
--L= DBM:GetModLocalization(2347)

---------------------------
--  Lady Priscilla Ashvane --
---------------------------
--L= DBM:GetModLocalization(2354)

---------------------------
--  Orgozoa --
---------------------------
--L= DBM:GetModLocalization(2351)

---------------------------
--  The Queen's Court --
---------------------------
L= DBM:GetModLocalization(2359)

L:SetMiscLocalization({
	Circles =	"Cerchi tra 3s"
})

---------------------------
-- Za'qul --
---------------------------
L= DBM:GetModLocalization(2349)

L:SetMiscLocalization({
	Phase3	= "Le lacrime di Za'qul aprono la via al Reame del Delirio!",
	Tear	= "Lacrima"
})

---------------------------
--  Queen Azshara --
---------------------------
L= DBM:GetModLocalization(2361)

L:SetTimerLocalization{
	timerStageThreeBerserk		= "Furia degli Add"
}

L:SetOptionLocalization({
	SortDesc 				= "Mostra gli stack di debuff in ordine discendente nel riquadro informativo per $spell:298569 (anziché ascendente).",
	ShowTimeNotStacks		= "Usa il riquadro informativo per tempo rimanente di $spell:298569 anziché il conta-stack.",
	timerStageThreeBerserk	= "Mostra temporizzatore furia degli add nella Fase 3"
})

L:SetMiscLocalization({
	SoakOrb 			= "Entra nella Sfera",
	AvoidOrb 			= "Schiva la Sfera",
	GroupUp 			= "Raggruppati",
	Spread 				= "Spargiti",
	Move				= "Muoviti",
	DontMove 			= "Fermati",
	--For Yells
	HelpSoakMove		= "{rt3}HELP SOAK MOVE{rt3}", -- Purple Diamond
	HelpSoakStay		= "{rt6}HELP SOAK STAY{rt6}", -- Blue Square
	HelpSoak			= "{rt3}HELP SOAK{rt3}", -- Purple Diamond
	HelpMove			= "{rt4}HELP MOVE{rt4}", -- Green Triangle
	HelpStay			= "{rt7}HELP STAY{rt7}", -- Red X
	SoloSoak 			= "SOLO SOAK",
	Solo 				= "SOLO",
	--Not currently used Yells
	SoloMoving			= "SOLO MOVE",
	SoloStay			= "SOLO STAY",
	SoloSoakMove		= "SOLO SOAK MOVE",
	SoloSoakStay		= "SOLO SOAK STAY"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("EternalPalaceTrash")

L:SetGeneralLocalization({
	name =	"Scartini Palazzo Eterno"
})
