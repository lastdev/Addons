local L

---------------------------
--  Shriekwing --
---------------------------
--L= DBM:GetModLocalization(2393)

---------------------------
--  Altimor the Huntsman --
---------------------------
--L= DBM:GetModLocalization(2429)

---------------------------
--  Hungering Destroyer --
---------------------------
L= DBM:GetModLocalization(2428)

L:SetOptionLocalization({
	SortDesc 				= "Sort $spell:334755 Infoframe by highest debuff stack (instead of lowest).",
	ShowTimeNotStacks		= "Show time remaining on $spell:334755 Infoframe instead of stack count."
})

---------------------------
--  Artificer Xy'Mox --
---------------------------
--L= DBM:GetModLocalization(2418)

---------------------------
--  Sun King's Salvation/Kael'thas --
---------------------------
--L= DBM:GetModLocalization(2422)

---------------------------
--  Lady Inerva Darkvein --
---------------------------
L= DBM:GetModLocalization(2420)

L:SetTimerLocalization{
	timerDesiresContainer		= "Desires full",
	timerBottledContainer		= "Bottled full",
	timerSinsContainer			= "Sins full",
	timerConcentrateContainer	= "Concentrate full"
}

L:SetOptionLocalization({
	timerContainers2			= "Show timer that will show container fill progress and time remaining until full"
})

---------------------------
--  The Council of Blood --
---------------------------
--L= DBM:GetModLocalization(2426)

---------------------------
--  Sludgefist --
---------------------------
--L= DBM:GetModLocalization(2394)

---------------------------
--  Stoneborne Generals --
---------------------------
L= DBM:GetModLocalization(2425)

L:SetOptionLocalization({
	ExperimentalTimerCorrection	= "Automatically adjust timers when abilities get spell queued by other abilities",
	BladeMarking				= "Set marking behavior for raid (If raid leader, overrides raid)",
	SetOne						= "DBM Default",
	SetTwo						= "BigWigs Default"
})

L:SetMiscLocalization({
	DBMConfigMsg	= "Marking icons configuration set to %s to match raid leaders configuration."
})

---------------------------
--  Sire Denathrius --
---------------------------
--L= DBM:GetModLocalization(2424)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("CastleNathriaTrash")

L:SetGeneralLocalization({
	name =	"Castle Nathria Trash"
})

---------------------------
--  The Tarragrue --
---------------------------
L= DBM:GetModLocalization(2435)

L:SetOptionLocalization({
	warnRemnant	= "Announce personal Remnant debuff stacks"
})

L:SetMiscLocalization({
	Remnant			= "Remnant",
	PortalRP		= "Secure the area! Fortify our perimeter!"
})

---------------------------
--  The Eye of the Jailer --
---------------------------
L= DBM:GetModLocalization(2442)

L:SetOptionLocalization({
	ContinueRepeating	= "Continue repeating icon yells for Scorn and Ire until debuffs are gone"
})

---------------------------
--  The Nine --
---------------------------
L= DBM:GetModLocalization(2439)

L:SetMiscLocalization({
	Fragment		= "Fragment ",--Space is intentional, leave a space to add a number after it
	PrePull			= "Fools. You fight a battle you cannot win."
})

---------------------------
--  Remnant of Ner'zhul --
---------------------------
--L= DBM:GetModLocalization(2444)

---------------------------
--  Soulrender Dormazain --
---------------------------
--L= DBM:GetModLocalization(2445)

---------------------------
--  Painsmith Raznal --
---------------------------
--L= DBM:GetModLocalization(2443)

---------------------------
--  Guardian of the First Ones --
---------------------------
L= DBM:GetModLocalization(2446)

L:SetOptionLocalization({
	IconBehavior	= "Set marking behavior for raid (If raid leader, overrides raid)",
	TypeOne			= "DBM Default (Melee > Ranged)",
	TypeTwo			= "BW Default (Combatlog order)"
})

L:SetMiscLocalization({
	Dissection	= "Dissection!",
	Dismantle	= "Dismantle"
})

---------------------------
--  Fatescribe Roh-Kalo --
---------------------------
--L= DBM:GetModLocalization(2447)

---------------------------
--  Kel'Thuzad --
---------------------------
L= DBM:GetModLocalization(2440)

L:SetMiscLocalization({
	WallRP	= "How fitting that we should face one another here, upon the precipice of Death's victory."
})

---------------------------
--  Sylvanas Windrunner --
---------------------------
L= DBM:GetModLocalization(2441)

L:SetMiscLocalization({
	PrePull	= "Azeroth's champions. You've arrived at last."
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SanctumofDomTrash")

L:SetGeneralLocalization({
	name =	"SoD Trash"
})

---------------------------
--  Vigilant Guardian --
---------------------------
--L= DBM:GetModLocalization(2458)

---------------------------
--  Dausegne, the Fallen Oracle --
---------------------------
--L= DBM:GetModLocalization(2459)

---------------------------
--  Artificer Xy'mox --
---------------------------
--L= DBM:GetModLocalization(2470)

---------------------------
--  Prototype Pantheon --
---------------------------
L= DBM:GetModLocalization(2460)

L:SetOptionLocalization({
	RitualistIconSetting	= "Set Ritualist icon setting behavior. Raid Leaders preference is used if they're using DBM",
	SetOne					= "Differ from seeds/Night Hunter (no conflicts) |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:16:32|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:16:32|t",--5-8 (Default)
	SetTwo					= "Match seeds/Night Hunter (but conflicts if seeds and ritualists at same time) |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:0:16|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:0:16|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:0:16|t"-- 1-4
--	SetThree				= "Match seeds/Night Hunter (no conflicts, but requires raid members having extended icons properly installed to see them) |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:32:48|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:32:48|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:32:48|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:32:48|t"--9-12
})

L:SetMiscLocalization({
	Deathtouch		= "Deathtouch",
	Dispel			= "Dispel",
	ExtendReset		= "Your Ritualist icon dropdown setting has been reset due to fact you were using extended icons before, but aren't any longer"
})

---------------------------
--  Lihuvim, Principal Architect --
---------------------------
--L= DBM:GetModLocalization(2461)

---------------------------
--  Skolex, the Insatiable Ravener --
---------------------------
L= DBM:GetModLocalization(2465)

L:SetTimerLocalization{
	timerComboCD		= "~Tank Combo (%d)"
}

L:SetOptionLocalization({
	timerComboCD		= "Show timer (with count) for tank combo cooldown"
})

---------------------------
--  Halondrus the Reclaimer --
---------------------------
L= DBM:GetModLocalization(2463)

L:SetMiscLocalization({
	Mote		= "Mote"
})

---------------------------
--  Anduin Wrynn --
---------------------------
L= DBM:GetModLocalization(2469)

L:SetOptionLocalization({
	PairingBehavior		= "Set mod behavior for Blasphemy. Raid Leaders preference is used if they're using DBM",
	Auto				= "'on you' alert with auto assigned partner. Chat bubbles show unique symbols for matchups",
	Generic				= "'on you' alert with no assignments. Chat bubbles show generic symbols for two debuffs",--Default
	None				= "'on you' alert with no assignments. No Chat bubbles"
})

L:SetMiscLocalization({
	PrePull				= "It is done. The final chamber of the Sepulcher opens before me."
})

---------------------------
--  Lords of Dread --
---------------------------
--L= DBM:GetModLocalization(2457)

---------------------------
--  Rygelon --
---------------------------
--L= DBM:GetModLocalization(2467)

---------------------------
--  The Jailer --
---------------------------
L= DBM:GetModLocalization(2464)

L:SetWarningLocalization({
	warnHealAzeroth		= "Heal Azeroth (%s)",
	warnDispel			= "Dispel (%s)"
})

L:SetTimerLocalization{
	timerPits			= "Pits Open",
	timerHealAzeroth	= "Heal Azeroth (%s)",
	timerDispels		= "Dispels (%s)"
}

L:SetOptionLocalization({
	timerPits			= "Show timer for when the floor pits open up and expose holes you can fall into.",
	warnHealAzeroth		= "Show warning for when you need to heal azeroth (via fight mechanics) on mythic difficulty, based on Echo's strategy",
	warnDispel			= "Show warning for when you need to dispel Death Sentence on mythic difficulty, based on Echo's strategy",
	timerHealAzeroth	= "Show timer for when you need to heal azeroth (via fight mechanics) on mythic difficulty, based on Echo's strategy",
	timerDispels		= "Show timer for when you need to dispel Death Sentence on mythic difficulty, based on Echo's strategy"
})

L:SetMiscLocalization({
	Pylon				= "Pylon",
	AzerothSoak			= "Azeroth Soak"--Short Text for Desolation
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SepulcherTrash")

L:SetGeneralLocalization({
	name =	"Sepulcher Trash"
})

-----------------------
-- <<< Fated Raid Affixes >>> --
-----------------------
L = DBM:GetModLocalization("FatedAffixes")

L:SetGeneralLocalization({
	name =	"Fated Affixes"
})

