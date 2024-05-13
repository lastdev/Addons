if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

------------
-- Taloc  --
------------
L= DBM:GetModLocalization(2168)

L:SetMiscLocalization({
	Aggro	 =	"tiene amenaza"
})

-----------
-- MADRE --
-----------
--L= DBM:GetModLocalization(2167)

----------------------
-- Devorador fétido --
----------------------
L= DBM:GetModLocalization(2146)

L:SetWarningLocalization({
	addsSoon		= "Esclusa abierta - ¡esbirros en breve!"
})

L:SetOptionLocalization({
	addsSoon		= "Mostrar aviso previo cuando las esclusas se abran en preparación para la aparición de esbirros"
})

--------------------------------
-- Zek'voz, Heraldo de N'Zoth --
--------------------------------
L= DBM:GetModLocalization(2169)

L:SetTimerLocalization({
	timerOrbLands	= "Orbe (%s) aterriza"
})

L:SetOptionLocalization({
	timerOrbLands	 =	"Mostrar temporizador para el momento en que $spell:267334 toca el suelo",
	EarlyTankSwap	 =	"Mostrar avisos de cambio de tanque inmediatamente tras $spell:265248 en lugar de esperar al segundo $spell:265264"
})

L:SetMiscLocalization({
	CThunDisc	 =	"Acceso al disco. Cargando datos de C'Thun.",
	YoggDisc	 =	"Acceso al disco. Cargando datos de Yogg-Saron.",
	CorruptedDisc =	"Acceso al disco. Cargando datos corruptos."
})

------------
-- Vectis --
------------
L= DBM:GetModLocalization(2166)

L:SetOptionLocalization({
	ShowHighestFirst3	 =	"Ordenar marco de información de $spell:265127 de mayor a menor cantidad de acumulaciones (en lugar de menor a mayor)",
	ShowOnlyParty		 =	"Mostrar solo las acumulaciones de $spell:265127 de tu grupo",
	SetIconsRegardless	 =	"Poner iconos independientemente de si un jugador con permisos de ayudante tiene BigWigs (avanzado)"
})

L:SetMiscLocalization({
	BWIconMsg			 =	"DBM ha relevado la colocación de iconos a un ayudante con BigWigs para evitar conflictos de iconos. Asegúrate de que el jugador en cuestión tiene la colocación de iconos activada. En caso contrario, quítale los permisos de ayudante para rehabilitar la colocación de iconos de DBM o habilita en la configuración de Vectis la opción de ignorar si un ayudante tiene BigWigs."
})

------------------------------
-- Mythrax el Desintegrador --
------------------------------
--L= DBM:GetModLocalization(2194)

---------------------
-- Zul el Renacido --
---------------------
L= DBM:GetModLocalization(2195)

L:SetTimerLocalization({
	timerCallofCrawgCD		= "Tragadones (%s)",
	timerCallofHexerCD 		= "Aojasangres (%s)",
	timerCallofCrusherCD	= "Trituradora (%s)",
	timerAddIncoming		= DBM_COMMON_L.INCOMING
})

L:SetOptionLocalization({
	timerCallofCrawgCD		= "Mostrar temporizador para cuando las siluetas de los tragadones comiencen a formarse",
	timerCallofHexerCD 		= "Mostrar temporizador para cuando las siluetas de las aojasangres comiencen a formarse",
	timerCallofCrusherCD	= "Mostrar temporizador para cuando la silueta de la trituradora comience a formarse",
	timerAddIncoming		= "Mostrar temporizador para cuando los esbirros se vuelvan atacables",
	TauntBehavior			= "Patrón de cambios de tanque",
	TwoHardThreeEasy		= "Cambiar a tres acumulaciones en LFR/normal y dos en heroico/mítico",--Default
	TwoAlways				= "Cambiar siempre a dos acumulaciones independientemente de la dificultad",
	ThreeAlways				= "Cambiar siempre a tres acumulaciones independientemente de la dificultad"
})

L:SetMiscLocalization({
	Crusher			=	"Trituradora",
	Bloodhexer		=	"Aojasangre",
	Crawg			=	"Tragadón"
})

------------
-- G'huun --
------------
L= DBM:GetModLocalization(2147)

L:SetWarningLocalization({
	warnMatrixFail		= "Una matriz de poder ha caído al suelo"
})

L:SetOptionLocalization({
	warnMatrixFail		= "Mostrar aviso cuando una $spell:263372 caiga al suelo"
})

L:SetMiscLocalization({
	CurrentMatrix		=	"Matriz actual:",--Mythic
	NextMatrix			=	"Siguiente matriz:",--Mythic
	CurrentMatrixLong	=	"Matriz actual (%s):",--Non Mythic
	NextMatrixLong		=	"Siguiente matriz (%s):"--Non Mythic
})

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("UldirTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

------------------------
-- Campeona de la Luz --
------------------------
--L= DBM:GetModLocalization(2344)--Ra'wani Kanae (Alianza)

--L= DBM:GetModLocalization(2333)--Frida Fuelleférreo (Horda)

-----------
-- Grong --
-----------
--L= DBM:GetModLocalization(2325)--Rey Grong (Horda)

--L= DBM:GetModLocalization(2340)--Grong el Resucitado (Alianza)

----------------------------
-- Maestros Fuego de Jade --
----------------------------
--L= DBM:GetModLocalization(2323)--Ma'ra Colmillosiniestro y Anathos Clamafuegos (Alianza)

--L= DBM:GetModLocalization(2341)--Manceroy Puñoígneo y Mestrah la Iluminada (Horda)

---------------
-- Opulencia --
---------------
L= DBM:GetModLocalization(2342)

L:SetMiscLocalization({
	Bulwark =	"Baluarte",
	Hand	=	"Mano"
})

------------------------------
-- Cónclave de los Elegidos --
------------------------------
L= DBM:GetModLocalization(2330)

L:SetMiscLocalization({
	BwonsamdiWrath =	"Si tantah ganah tieneh de morir, ¡deberíah haber venido anteh!",
	BwonsamdiWrath2 =	"Anteh o dehpuéh... ¡todoh me sirven!",
	Bird			 =	"Pa'ku"
})

-------------------
-- Rey Rastakhan --
-------------------
L= DBM:GetModLocalization(2335)

L:SetOptionLocalization({
	AnnounceAlternatePhase	= "Mostrar avisos generales del reino de la muerte si te encuentras en el de los vivos, y viceversa (esta opción no afecta a los temporizadores, los cuales se muestran siempre)"
})

-------------------------------
-- Manitas mayor Mekkatorque --
-------------------------------
--L= DBM:GetModLocalization(2332)

----------------------------
-- Bloqueo de la tormenta --
----------------------------
--L= DBM:GetModLocalization(2337)

-------------------------
-- Lady Jaina Valiente --
-------------------------
L= DBM:GetModLocalization(2343)

L:SetOptionLocalization({
	ShowOnlySummary2	= "Mostrar solo la cantidad de jugadores cercanos en la comprobación de distancia en lugar de listar sus nombres",
	InterruptBehavior	= "Patrón de interrupción para el elemental (sobrescribe la configuración del resto de jugadores si eres el líder de banda)",
	Three				= "Rotación de tres jugadores",--Default
	Four				= "Rotación de cuatro jugadores",
	Five				= "Rotación de cinco jugadores",
	SetWeather			= "Bajar automáticamente la densidad del clima al mínimo al iniciar el encuentro (se restaurará a su configuración anterior al terminar el combate)"
})

L:SetMiscLocalization({
	Port			=	"babor",
	Starboard		=	"estribor",
	Freezing		=	"Congelación en %s"
})

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("ZuldazarRaidTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

---------------------------
-- La Cábala Infatigable --
---------------------------
L= DBM:GetModLocalization(2328)

L:SetMiscLocalization({
	Zaxasj = "Zaxasj",
	Fathuul = "Fa'thuul"
})

----------------------------------
-- Uu'nat, Presagista del Vacío --
----------------------------------
L= DBM:GetModLocalization(2332)

L:SetOptionLocalization({

})

L:SetMiscLocalization({

})

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("CrucibleofStormsTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"--Naming conflict?
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
	Circles =	"Círculos en 3 segundos"
})

---------------------------
-- Za'qul --
---------------------------
L= DBM:GetModLocalization(2349)

L:SetMiscLocalization({
	Phase3	= "¡Za'qul abre el camino hacia el reino del delirio!",
	Tear	= "Rasgadura"
})

---------------------------
--  Queen Azshara --
---------------------------
L= DBM:GetModLocalization(2361)

L:SetTimerLocalization{
	timerStageThreeBerserk		= "Rabia de esbirros"
}

L:SetOptionLocalization({
	SortDesc 				= "Ordenar el marco de información de $spell:298569 de mayor a menor cantidad de acumulaciones (en lugar de de menor a mayor)",
	ShowTimeNotStacks		= "Mostrar el tiempo restante de $spell:298569 en el marco de información en lugar de la cantidad de acumulaciones",
	timerStageThreeBerserk	= "Mostrar temporizador para la Rabia de los esbirros de Fase 3"
})

L:SetMiscLocalization({
	SoakOrb 			= "Absorbe un orbe",
	AvoidOrb 			= "Evita absorber orbes",
	GroupUp 			= "En grupo",
	Spread 				= "Separado",
	Move				= "No dejes de moverte",
	DontMove 			= "No te muevas",
	--For Yells
	HelpSoakMove		= "{rt3}ORBE EN GRUPO - CORRER{rt3}",--Purple Diamond
	HelpSoakStay		= "{rt6}ORBE EN GRUPO - QUIETO{rt6}",--Blue Square
	HelpSoak			= "{rt3}ORBE EN GRUPO{rt3}",--Purple Diamond
	HelpMove			= "{rt4}CORRER EN GRUPO{rt4}",--Green Triangle
	HelpStay			= "{rt7}QUIETO EN GRUPO{rt7}",--Red X
	SoloSoak 			= "ORBE SOLO",
	Solo 				= "SOLO",
	--Not currently used Yells
	SoloMoving			= "CORRER SOLO",
	SoloStay			= "QUIETO SOLO",
	SoloSoakMove		= "ORBE SOLO - CORRER",
	SoloSoakStay		= "ORBE SOLO - QUIETO"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("EternalPalaceTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

---------------------------
--  Wrathion, the Black Emperor --
---------------------------
--L= DBM:GetModLocalization(2368)

---------------------------
--  Maut --
---------------------------
--L= DBM:GetModLocalization(2365)

---------------------------
--  The Prophet Skitra --
---------------------------
--L= DBM:GetModLocalization(2369)

---------------------------
--  Dark Inquisitor Xanesh --
---------------------------
L= DBM:GetModLocalization(2377)

L:SetOptionLocalization({
	InterruptBehavior	= "Patrón de interrupción de Ola de terror (sobrescribe al resto si eres el líder)",
	Four				= "Cuatro jugadores",--Default
	Five				= "Cinco jugadores",
	Six					= "Seis jugadores",
	NoReset				= "Incremento infinito"
})

L:SetMiscLocalization({
	ObeliskSpawn	= "¡Alzaos, obeliscos de la sombra!"--Only as backup, in case the NPC target check stops working --Translator's Note: may have changed since when I tested it on the PTR
})

---------------------------
--  The Hivemind --
---------------------------
--L= DBM:GetModLocalization(2372)

---------------------------
--  Shad'har the Insatiable --
---------------------------
--L= DBM:GetModLocalization(2367)

---------------------------
-- Drest'agath --
---------------------------
--L= DBM:GetModLocalization(2373)

---------------------------
--  Vexiona --
---------------------------
--L= DBM:GetModLocalization(2370)

---------------------------
--  Ra-den the Despoiled --
---------------------------
L= DBM:GetModLocalization(2364)

L:SetOptionLocalization({
	OnlyParentBondMoves		= "Mostrar aviso especial para Vínculos cargados únicamente si eres el objetivo principal"
})

L:SetMiscLocalization({
	Furthest	= "Objetivo más lejano",
	Closest		= "Objetivo más cercano"
})

---------------------------
--  Il'gynoth, Corruption Reborn --
---------------------------
L= DBM:GetModLocalization(2374)

L:SetOptionLocalization({
	SetIconOnlyOnce		= "Poner icono a la Sangre de Ny'alotha con la salud más baja solo cuando una muera (de lo contrario cambia constantemente a la más baja)",
	InterruptBehavior	= "Patrón de interrupción de Sangre bombeante (sobrescribe al resto si eres el líder)",
	Two					= "Dos jugadores",--Default
	Three				= "Tres jugadores",
	Four				= "Cuatro jugadores",
	Five				= "Cinco jugadores"
})

---------------------------
--  Carapace of N'Zoth --
---------------------------
--L= DBM:GetModLocalization(2366)

---------------------------
--  N'Zoth, the Corruptor --
---------------------------
L= DBM:GetModLocalization(2375)

L:SetOptionLocalization({
	InterruptBehavior	= "Patrón de interrupción de Suplicio mental (sobrescribe al resto si eres el líder)",
	Four				= "Cuatro jugadores",
	Five				= "Cinco jugadores",--Default
	Six					= "Seis jugadores",
	NoReset				= "Incremento infinito",
	ArrowOnGlare		= "Mostrar flechas para la dirección de $spell:317874",
	HideDead			= "Ocultar a los jugadores muertos del marco de información en dificultades inferiores a mítico"
})

L:SetMiscLocalization({
	ExitMind		= "Sal de la mente",
	Gate			= "Portal"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("NyalothaTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})
