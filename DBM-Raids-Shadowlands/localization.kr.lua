if GetLocale() ~= "koKR" then return end
local L

---------------------------
--  Shriekwing --
---------------------------
--L= DBM:GetModLocalization(2393)

--L:SetOptionLocalization({
--})

--L:SetMiscLocalization({
--})

---------------------------
--  Altimor the Huntsman --
---------------------------
--L= DBM:GetModLocalization(2429)

---------------------------
--  Hungering Destroyer --
---------------------------
L= DBM:GetModLocalization(2428)

L:SetOptionLocalization({
	SortDesc 				= "디버프 중첩이 높은 순서대로 정보 창에 $spell:334755 대상자를 정렬합니다. (중첩 낮은순 대신)",
	ShowTimeNotStacks		= "정보 창에 $spell:334755의 중첩 대신 남은 시간을 표시합니다."
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
	timerDesiresContainer		= "욕망의 용기 가득참",
	timerBottledContainer		= "병에 담긴 용기 가득참",
	timerSinsContainer			= "죄악의 용기 가득참",
	timerConcentrateContainer	= "농축된 용기 가득참"
}

L:SetOptionLocalization({
	timerContainers2			= "용기가 채워지고 있는 상황과 가득찰때까지 남은 시간을 표시하는 타이머 보기"
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
	ExperimentalTimerCorrection	= "다른 스킬에 의해 대기중인 스킬의 타이머를 자동으로 조정",
	BladeMarking				= "징표 설정 방식 (공대장일 경우 공격대 전체에 적용됨)",
	SetOne						= "DBM 기본값",
	SetTwo						= "BigWigs 기본값"
})

L:SetMiscLocalization({
	DBMConfigMsg	= "공대장의 설정에 맞추기 위해 징표 설정 방식을 %s으로 설정합니다."
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
	name =	"나스리아 성채 일반몹"
})

---------------------------
--  The Tarragrue --
---------------------------
L= DBM:GetModLocalization(2435)

L:SetOptionLocalization({
	warnRemnant	= "자신의 잔재 디버프 중첩 알림"
})

L:SetMiscLocalization({
	Remnant	= "잔재"
})

---------------------------
--  The Eye of the Jailer --
---------------------------
L= DBM:GetModLocalization(2442)

L:SetOptionLocalization({
	ContinueRepeating	= "경멸과 분노 디버프에 걸리면 끝날때까지 지정된 공격대 징표 말풍선 알림"
})

---------------------------
--  The Nine --
---------------------------
L= DBM:GetModLocalization(2439)

L:SetMiscLocalization({
	Fragment		= "조각 "--Space is intentional, leave a space to add a number after it
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
	IconBehavior	= "공격대 징표 방식 설정 (공대장이면 설정이 공격대 전체에 적용)",
	TypeOne			= "DBM 기본값 (근접 > 원거리)",
	TypeTwo			= "BW 기본값 (전투기록상 순서)"
})

L:SetMiscLocalization({
	Dissection	= "해부를 시작합니다!",
	Dismantle	= "분해 실시!"
})

---------------------------
--  Fatescribe Roh-Kalo --
---------------------------
--L= DBM:GetModLocalization(2447)

---------------------------
--  Kel'Thuzad --
---------------------------
--L= DBM:GetModLocalization(2440)

---------------------------
--  Sylvanas Windrunner --
---------------------------
--L= DBM:GetModLocalization(2441)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SanctumofDomTrash")

L:SetGeneralLocalization({
	name =	"지배의 성소 일반몹"
})

---------------------------
--  Vigilant Guardian --
---------------------------
--L= DBM:GetModLocalization(2458)

--L:SetOptionLocalization({

--})

--L:SetMiscLocalization({

--})

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
	RitualistIconSetting	= "의식술사 징표 방식을 설정합니다. 공대장이 DBM을 사용한다면 공대장의 설정을 사용합니다",
	SetOne					= "씨앗/밤의 사냥꾼 각자 다르게 (충돌 없음) |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:16:32|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:16:32|t",--5-8 (Default)
	SetTwo					= "씨앗/밤의 사냥꾼 동일하게 (씨앗과 의식술사가 같이 나올시 충돌) |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:0:16|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:0:16|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:0:16|t"-- 1-4
--	SetThree				= "씨앗/밤의 사냥꾼 동일하게 (충돌은 없으나 모든 징표를 보려면 확장 공격대 징표 텍스쳐를 설치해야 함) |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:32:48|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:32:48|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:32:48|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:32:48|t"--9-12
})

L:SetMiscLocalization({
	Deathtouch		= "죽음의 손길",
	Dispel			= "해제",
	ExtendReset		= "의식술사 징표 드롭다운 설정이 이전에 확장 공격대 징표를 사용했었으나 더이상 사용하지 않아서 초기화됐습니다,"
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
	timerComboCD		= "~탱커 연속 공격 (%d)"
}

L:SetOptionLocalization({
	timerComboCD		= "탱커 연속 공격 쿨타임 타이머 바 표시"
})

---------------------------
--  Halondrus the Reclaimer --
---------------------------
L= DBM:GetModLocalization(2463)

L:SetMiscLocalization({
	Mote		= "티끌"
})

---------------------------
--  Anduin Wrynn --
---------------------------
L= DBM:GetModLocalization(2469)

L:SetOptionLocalization({
	PairingBehavior		= "신성 모독의 모드 작동 방식을 설정합니다. 공대장이 DBM을 사용한다면 공대장의 설정을 사용합니다",
	Auto				= "'당신이 걸림' 경고시 자동으로 짝이 지정됩니다. 같은 짝끼리 고유 상징이 말풍선으로 표시됩니다",
	Generic				= "'당신이 걸림' 경고시 짝을 지정하지 않습니다. 2종류 디버프에 각각 별도의 상징이 말풍선으로 표시됩니다",--Default
	None				= "'당신이 걸림' 경고시 짝을 지정하지 않습니다. 말풍선도 나오지 않습니다"
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
	warnHealAzeroth		= "아제로스 치유 (%s)",
	warnDispel			= "해제 (%s)"
})

L:SetTimerLocalization{
	timerPits			= "구덩이 열림",
	timerHealAzeroth	= "아제로스 치유 (%s)",
	timerDispels		= "해제 (%s)"
}

L:SetOptionLocalization({
	timerPits			= "구덩이가 열리며 뛰어들 수 있는 구멍이 노출되는 때의 타이머 바를 봅니다.",
	warnHealAzeroth		= "신화 난이도에서 아제로스를 치유(전투 방식을 통해서)해야 할 때 경고를 봅니다. Echo 공략 기반",
	warnDispel			= "신화 난이도에서 사형 선고 해제를 해야할 때 경고를 봅니다. Echo 공략 기반",
	timerHealAzeroth	= "신화 난이도에서 아제로스를 치유(전투 방식을 통해서)해야 할 때의 타이머 바를 봅니다. Echo 공략 기반",
	timerDispels		= "신화 난이도에서 사형 선고 해제를 해야할 때의 타이머 바를 봅니다. Echo 공략 기반"
})

L:SetMiscLocalization({
	Pylon		= "수정탑",
	AzerothSoak			= "아제로스 바닥 맞기"--Short Text for Desolation
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SepulcherTrash")

L:SetGeneralLocalization({
	name =	"매장터 일반몹"
})

-----------------------
-- <<< Fated Raid Affixes >>> --
-----------------------
L = DBM:GetModLocalization("FatedAffixes")

L:SetGeneralLocalization({
	name =	"운명의 공격대 어픽스"
})

