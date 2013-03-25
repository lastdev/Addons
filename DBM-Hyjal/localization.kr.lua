if GetLocale() ~= "koKR" then return end
local L

------------------------
--  Rage Winterchill  --
------------------------
L = DBM:GetModLocalization("Rage")

L:SetGeneralLocalization{
	name = "격노한 윈터칠"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	IceBoltIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(31249)
}

L:SetMiscLocalization{
}

-----------------
--  Anetheron  --
-----------------
L = DBM:GetModLocalization("Anetheron")

L:SetGeneralLocalization{
	name = "아네테론"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
}

----------------
--  Kazrogal  --
----------------
L = DBM:GetModLocalization("Kazrogal")

L:SetGeneralLocalization{
	name = "카즈로갈"
}

L:SetWarningLocalization{
	WarnMark = "카즈로갈의 징표 (%d)"
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	WarnMark = "$spell:31447 경고 보기"
}

L:SetMiscLocalization{
}

---------------
--  Azgalor  --
---------------
L = DBM:GetModLocalization("Azgalor")

L:SetGeneralLocalization{
	name = "아즈갈로"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	DoomIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(31347)
}

L:SetMiscLocalization{
}

------------------
--  Archimonde  --
------------------
L = DBM:GetModLocalization("Archimonde")

L:SetGeneralLocalization{
	name = "아키몬드"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	YellOnBurst	= "$spell:32014 주문의 영향을 받은 경우 대화로 알리기",
	BurstIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(32014)
}

L:SetMiscLocalization{
	YellBurst	= "나에게 대기 파열!"
}

----------------
-- WaveTimers --
----------------
L = DBM:GetModLocalization("HyjalWaveTimers")

L:SetGeneralLocalization{
	name 		= "하이잘 일반구간"
}

L:SetWarningLocalization{
	WarnWave	= "%s",
	WarnWaveSoon= "곧 다음 공격"
}

L:SetTimerLocalization{
	TimerWave	= "다음 공격"
}

L:SetOptionLocalization{
	WarnWave		= "다음 공격 알림 보기",
	WarnWaveSoon	= "다음 공격 사전 알림 보기",
	DetailedWave	= "다음 공격 알림시 몬스터 조합까지 자세히 보기",
	TimerWave		= "다음 공격 바 표시"
}

L:SetMiscLocalization{
	HyjalZoneName	= "하이잘 정상",
	Thrall			= "스랄",
	Jaina			= "제이나 프라우드무어",
	RageWinterchill	= "격노한 윈터칠",
	Anetheron		= "아네테론",
	Kazrogal		= "카즈로갈",
	Azgalor			= "아즈갈로",
	WaveCheck		= "현재 공격 = (%d+)/8",
	WarnWave_0		= "공격 %s/8",
	WarnWave_1		= "공격 %s/8 - %s %s",
	WarnWave_2		= "공격 %s/8 - %s %s, %s %s",
	WarnWave_3		= "공격 %s/8 - %s %s, %s %s, %s %s",
	WarnWave_4		= "공격 %s/8 - %s %s, %s %s, %s %s, %s %s",
	WarnWave_5		= "공격 %s/8 - %s %s, %s %s, %s %s, %s %s, %s %s",
	RageGossip		= "제 동료와 저는 프라우드무어님, 당신과 함께 하겠습니다.",
	AnetheronGossip	= "아키몬드가 어떤 군대를 보내던 우리는 준비가 되어 있습니다, 프라우드무어 님.",
	KazrogalGossip	= "당신과 함께 하겠습니다, 대족장님.",
	AzgalorGossip	= "두려워할 것은 아무것도 없습니다.",
	Ghoul			= "구울",
	Abomination		= "누더기골렘",
	Necromancer		= "강령술사",
	Banshee			= "밴시",
	Fiend			= "지하마귀",
	Gargoyle		= "가고일",
	Wyrm			= "서리고룡",
	Stalker			= "지옥사냥개",
	Infernal		= "지옥불정령"
}
