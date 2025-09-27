local L

---------------------------
-- Taloc the Corrupted --
---------------------------
L= DBM:GetModLocalization(2168)

L:SetMiscLocalization({
	Aggro	 =	"Has Aggro"
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
	addsSoon		= "Chute has opened - Adds Soon"
})

L:SetTimerLocalization({
	chuteTimer		= "Next Chute (%s)"
})

L:SetOptionLocalization({
	addsSoon		= "Show pre warning for when chutes open and start spawning adds",
	chuteTimer		= "Show timer for when Chutes open"
})

---------------------------
-- Zek'vhozj --
---------------------------
L= DBM:GetModLocalization(2169)

L:SetTimerLocalization({
	timerOrbLands	= "Orb (%s) Lands"
})

L:SetOptionLocalization({
	timerOrbLands	 =	"Show timer for when Orb of Corruption Lands",
	EarlyTankSwap	 =	"Show tank swap warning immediately after Shatter, instead of waiting for 2nd Void Lash"
})

L:SetMiscLocalization({
	CThunDisc	 =	"Disc accessed. C'thun data loading.",
	YoggDisc	 =	"Disc accessed. Yogg-Saron data loading.",
	CorruptedDisc =	"Disc accessed. Corrupted data loading."
})

---------------------------
-- Vectis --
---------------------------
L= DBM:GetModLocalization(2166)

L:SetOptionLocalization({
	ShowHighestFirst3	 =	"Sort Lingering Infection Infoframe by highest debuff stack (instead of lowest). Only applies if not set to party only.",
	ShowOnlyParty		 =	"Show Lingering Infection only for your party. This option always sorts the frame by party order.",
	SetIconsRegardless	 =	"Set icons regardless of whether or not a BW user has assist (Advanced)"
})

L:SetMiscLocalization({
	BWIconMsg			 =	"DBM's has passed icon marking to a promoted BW user in raid to avoid icon conflicts. Make sure they have marking enabled, or demote them to enable DBM marking, or enable the override option in Vectis options"
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
	timerCallofCrawgCD		= "Next Crawg Pool (%s)",
	timerCallofHexerCD 		= "Next Hexer Pool (%s)",
	timerCallofCrusherCD	= "Next Crusher Pool (%s)",
	timerAddIncoming		= DBM_COMMON_L.INCOMING
})

L:SetOptionLocalization({
	timerCallofCrawgCD		= "Show timer for when Crawg pools begin to form",
	timerCallofHexerCD 		= "Show timer for when Hexer pools begin to form",
	timerCallofCrusherCD	= "Show timer for when Crusher pools begin to form",
	timerAddIncoming		= "Show timer for when incoming add is attackable",
	TauntBehavior			= "Set taunt behavior for tank swaps",
	TwoHardThreeEasy		= "Swap at 2 stacks on heroic/mythic, 3 stacks on other difficulties",--Default
	TwoAlways				= "Always swap at 2 stacks regardless of difficulty",
	ThreeAlways				= "Always swap at 3 stacks regardless of difficulty"
})

L:SetMiscLocalization({
	Crusher			=	"Crusher",
	Bloodhexer		=	"Hexer",
	Crawg			=	"Crawg"
})

------------------
-- G'huun --
------------------
L= DBM:GetModLocalization(2147)

L:SetWarningLocalization({
	warnMatrixFail		= "Power Matrix dropped"
})

L:SetOptionLocalization({
	warnMatrixFail		= "Show warning when Power Matrix is dropped."
})

L:SetMiscLocalization({
	CurrentMatrix		=	"Current Matrix:",--Mythic
	NextMatrix			=	"Next Matrix:",--Mythic
	CurrentMatrixLong	=	"Current Matrix (%s):",--Non Mythic
	NextMatrixLong		=	"Next Matrix (%s):"--Non Mythic
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("UldirTrash")

L:SetGeneralLocalization({
	name =	"Uldir Trash"
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
	Bulwark =	"Bulwark",
	Hand	=	"Hand"
})

---------------------------
--  Loa Council (Alliance) --
---------------------------
L= DBM:GetModLocalization(2330)

L:SetMiscLocalization({
	BwonsamdiWrath =	"Well, if ya so eager for death, ya shoulda come see me sooner!",
	BwonsamdiWrath2 =	"Sooner or later... everybody serves me!",
	Bird			 =	"Bird"
})

---------------------------
--  King Rastakhan (Alliance) --
---------------------------
L= DBM:GetModLocalization(2335)

L:SetOptionLocalization({
	AnnounceAlternatePhase	= "Show general warnings for phase you aren't in as well (timers will always be shown regardless of this option)"
})

---------------------------
-- High Tinker Mekkatorgue (Horde) --
---------------------------
L= DBM:GetModLocalization(2334)

L:SetMiscLocalization({
	WallRP	= "The High Tinker fought bravely"--. But in the end... it wasn't enough. Thank the tides he had one last trick up his sleeve to carry him to safety!
})

---------------------------
--  Sea Priest Blockade (Horde) --
---------------------------
--L= DBM:GetModLocalization(2337)

---------------------------
--  Jaina Proudmoore (Horde) --
---------------------------
L= DBM:GetModLocalization(2343)

L:SetOptionLocalization({
	ShowOnlySummary2	= "Hide player names on reverse range check and show only the summary info (the total nearby player count)",
	InterruptBehavior	= "Set elemental interrupt behavior (Will override everyone elses setting if you are raid leader)",
	Three				= "3 person rotation ",--Default
	Four				= "4 person rotation ",
	Five				= "5 person rotation ",
	SetWeather			= "Automatically turn weather density setting to lowest when boss is engaged and restore on combat end",
})

L:SetMiscLocalization({
	Port			=	"port side",
	Starboard		=	"starboard side",
	Freezing		=	"Freezing in %s",
	PrePull			=	"All hands on deck! Time to make de daughter of de sea pay for trespassing in our waters!",
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ZuldazarRaidTrash")

L:SetGeneralLocalization({
	name =	"Dazar'alor Trash"
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
	UnstableBehavior2	= "Set Resonance yell behavior for raid (If raid leader, overrides raid)",
	SetOne				= "Void Stone (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Trident/Ocean (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t), Tempest/Storm (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t)",
	SetTwo				= "Void Stone (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Trident/Ocean (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t), Tempest/Storm (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t)",--Default
	SetThree			= "Void Stone (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Trident/Ocean (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t), Tempest/Storm (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:0:16|t)",
	SetFour				= "Void Stone (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Trident/Ocean (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t), Tempest/Storm (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:0:16|t)",
	SetFive				= "Void Stone (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Trident/Ocean (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t), Tempest/Storm (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:16:32|t)",
	SetSix				= "Void Stone (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Trident/Ocean (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t), Tempest/Storm (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:16:32|t)"
})

L:SetMiscLocalization({
	Ocean = "Trident/Ocean",
	Storm = "Tempest Caller",
	Void = "Void Stone",
	Lunacy = "Lunacy",
	DBMConfigMsg	= "Unstable Resonance configuration set to %s to match raid leaders configuration."
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("CrucibleofStormsTrash")

L:SetGeneralLocalization({
	name =	"Crucible Trash"
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
	Circles =	"Circles in 3s"
})

---------------------------
-- Za'qul --
---------------------------
L= DBM:GetModLocalization(2349)

L:SetMiscLocalization({
	Phase3	= "Za'qul tears open the pathway to Delirium Realm!",
	Tear	= "Tear"
})

---------------------------
--  Queen Azshara --
---------------------------
L= DBM:GetModLocalization(2361)

L:SetTimerLocalization{
	timerStageThreeBerserk		= "Adds Berserk"
}

L:SetOptionLocalization({
	SortDesc 				= "Sort $spell:298569 Infoframe by highest debuff stack (instead of lowest).",
	ShowTimeNotStacks		= "Show time remaining on $spell:298569 Infoframe instead of stack count.",
	timerStageThreeBerserk	= "Show timer for when the Stage 3 adds go Berserk"
})

L:SetMiscLocalization({
	SoakOrb 			= "Soak Orb",
	AvoidOrb 			= "Avoid Orb",
	GroupUp 			= "Group Up",
	Spread 				= "Spread",
	Move				= "Keep Moving",
	DontMove 			= "Stop Moving",
	--For Yells
	HelpSoakMove		= "{rt3}HELP SOAK MOVE{rt3}",--Purple Diamond
	HelpSoakStay		= "{rt6}HELP SOAK STAY{rt6}",--Blue Square
	HelpSoak			= "{rt3}HELP SOAK{rt3}",--Purple Diamond
	HelpMove			= "{rt4}HELP MOVE{rt4}",--Green Triangle
	HelpStay			= "{rt7}HELP STAY{rt7}",--Red X
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
	name =	"Eternal Palace Trash"
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
	InterruptBehavior	= "Set Terror Wave interrupt behavior (Will override everyone elses setting if you are raid leader)",
	Four				= "4 person rotation ",--Default
	Five				= "5 person rotation ",
	Six					= "6 person rotation ",
	NoReset				= "endless increment "
})

L:SetMiscLocalization({
	ObeliskSpawn	= "Obelisks of shadow, rise!"--Only as backup, in case the NPC target check stops working
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
	OnlyParentBondMoves		= "Only show special warning for Charged Bonds if you are the parent point"
})

L:SetMiscLocalization({
	Furthest	= "Furthest Target",
	Closest		= "Closest Target"
})

---------------------------
--  Il'gynoth, Corruption Reborn --
---------------------------
L= DBM:GetModLocalization(2374)

L:SetOptionLocalization({
	SetIconOnlyOnce		= "Set icon only once, per lowest health ooze scan, then disable until at least one dies",
	InterruptBehavior	= "Set Pumping Blood interrupt behavior (Will override everyone elses setting if you are raid leader)",
	Two					= "2 person rotation ",--Default
	Three				= "3 person rotation ",
	Four				= "4 person rotation ",
	Five				= "5 person rotation "
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
	InterruptBehavior	= "Set Mind Wrack interrupt behavior (Will override everyone elses setting if you are raid leader)",
	Four				= "4 person rotation ",
	Five				= "5 person rotation ",--Default
	Six					= "6 person rotation ",
	NoReset				= "endless increment ",
	ArrowOnGlare		= "Show left/right arrow for direction of $spell:317874",
	HideDead			= "Hide dead players from the InfoFrame on non-mythic difficulty"
})

L:SetMiscLocalization({
	ExitMind		= "Exit Mind",
	Gate			= "Gate"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("NyalothaTrash")

L:SetGeneralLocalization({
	name =	"Ny'alotha Trash"
})
