if GetLocale() ~= "koKR" then return end
local L

---------------------------
-- Taloc the Corrupted --
---------------------------
L= DBM:GetModLocalization(2168)

L:SetMiscLocalization({
	Aggro	 =	"어그로 수치"
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
	addsSoon		= "쓰레기 처리 장치 열림 - 곧 쫄 등장"
})

L:SetTimerLocalization({
	chuteTimer		= "다음 쓰레기 처리 장치 (%s)"
})

L:SetOptionLocalization({
	addsSoon		= "쓰레기 처리 장치가 열리고 쫄 생성이 시작되면 사전 경고 보기",
	chuteTimer		= "쓰레기 처리 장치 열림 타이머 보기"
})

---------------------------
-- Zek'vhozj --
---------------------------
L= DBM:GetModLocalization(2169)

L:SetTimerLocalization({
	timerOrbLands	= "구슬 (%s) 떨어짐"
})

L:SetOptionLocalization({
	timerOrbLands	 =	"타락의 보주가 나오면 타이머 바 보기",
	EarlyTankSwap	 =	"산산조각을 맞으면 2번째 공허의 채찍을 기다리지 않고 바로 탱커 교대 경고 보기"
})

L:SetMiscLocalization({
	CThunDisc	 =	"원반 접속 완료. 크툰 데이터를 불러옵니다.",
	YoggDisc	 =	"원반 접속 완료. 요그사론 데이터를 불러옵니다.",
	CorruptedDisc =	"원반 접속 완료. 오염된 데이터를 불러옵니다."
})

---------------------------
-- Vectis --
---------------------------
L= DBM:GetModLocalization(2166)

L:SetOptionLocalization({
	ShowHighestFirst3	 =	"중첩이 높은 순서대로 정보 창에 잔존하는 감염 대상자를 정렬합니다. (중첩 낮은순 대신) 파티원만 보기 설정을 껐을때만 적용됩니다.",
	ShowOnlyParty		 =	"내 파티원의 잔존하는 감염 중첩만 표시합니다. 정보 창이 항상 파티원 순서대로 정렬됩니다.",
	SetIconsRegardless	 =	"빅윅 사용자 승급 여부에 관계없이 공격대 징표 설정 기능 사용 (고급 사용자용)"
})

L:SetMiscLocalization({
	BWIconMsg			 =	"징표 충돌을 방지하기 위해 DBM의 징표 기능을 권한이 있는 공격대 내 빅윅 사용자에게 넘겨줬습니다. 빅윅 사용자가 징표 기능을 켰는지 확인하시고 DBM의 징표 기능을 활성화하고 싶을땐 빅윅 사용자의 등급을 내리면 됩니다. 또는 벡티스 설정에서 빅윅 사용자 무시 옵션을 사용할 수도 있습니다."
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
	timerCallofCrawgCD		= "다음 크로그 웅덩이 (%s)",
	timerCallofHexerCD 		= "다음 혈사술사 웅덩이 (%s)",
	timerCallofCrusherCD	= "다음 분쇄자 웅덩이 (%s)",
})

L:SetOptionLocalization({
	timerCallofCrawgCD		= "크로그 웅덩이가 형성되기 시작하면 타이머 바 보기",
	timerCallofHexerCD 		= "혈사술사 웅덩이가 형성되기 시작하면 타이머 바 보기",
	timerCallofCrusherCD	= "분쇄자 웅덩이가 형성되기 시작하면 타이머 바 보기",
	timerAddIncoming		= "쫄이 공격 가능해지면 타이머 바 보기",
	TauntBehavior			= "탱커 교대 도발 알림 설정",
	TwoHardThreeEasy		= "영웅/신화에서 2중첩마다 교대, 그 외 난이도에선 3중첩시 교대",--Default
	TwoAlways				= "난이도에 관계없이 항상 2중첩마다 교대",
	ThreeAlways				= "난이도에 관계없이 항상 3중첩마다 교대"
})

L:SetMiscLocalization({
	Crusher			=	"분쇄자",
	Bloodhexer		=	"혈사술사",
	Crawg			=	"크로그"
})

------------------
-- G'huun --
------------------
L= DBM:GetModLocalization(2147)

L:SetWarningLocalization({
	warnMatrixFail		= "동력 매트릭스 배달 실패"
})

L:SetOptionLocalization({
	warnMatrixFail		= "동력 매트릭스가 바닥에 떨어졌을 때 경고를 표시합니다."
})

L:SetMiscLocalization({
	CurrentMatrix		=	"현재 매트릭스:",--Mythic
	NextMatrix			=	"다음 매트릭스:",--Mythic
	CurrentMatrixLong	=	"현재 매트릭스 (%s):",--Non Mythic
	NextMatrixLong		=	"다음 매트릭스 (%s):"--Non Mythic
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("UldirTrash")

L:SetGeneralLocalization({
	name =	"울디르 일반몹"
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
	Bulwark =	"보루",
	Hand	=	"손"
})

---------------------------
--  Loa Council (Alliance) --
---------------------------
L= DBM:GetModLocalization(2330)

L:SetMiscLocalization({
	BwonsamdiWrath =	"그렇게 죽고 싶었으면, 더 일찍 날 찾아왔어야지!",
	BwonsamdiWrath2 =	"히히, 어차피 언젠간... 모두 날 섬기게 돼 있지!",
	Bird			 =	"새"
})

---------------------------
--  King Rastakhan (Alliance) --
---------------------------
L= DBM:GetModLocalization(2335)

L:SetOptionLocalization({
	AnnounceAlternatePhase	= "다른 세계의 일반 경고도 같이 보기 (타이머는 이 옵션과 상관없이 항상 표시됩니다)"
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
	ShowOnlySummary2	= "반전 거리 검사시 플레이어 이름을 숨기고 요약된 정보만 표시 (근처에 있는 플레이어의 수)",
	InterruptBehavior	= "물정령 차단 알림 설정 (공대장일 경우 다른 사람의 설정을 무시함)",
	Three				= "3인 로테이션 ",--Default
	Four				= "4인 로테이션 ",
	Five				= "5인 로테이션 ",
	SetWeather			= "보스 전투를 시작하면 자동으로 날씨 효과가 낮음으로 설정되고 전투가 끝나면 이전 설정으로 복구",
})

L:SetMiscLocalization({
	Port			=	"좌현",
	Starboard		=	"우현",
	Freezing		=	"얼음 %s초 전"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ZuldazarRaidTrash")

L:SetGeneralLocalization({
	name =	"다자알로 전투 일반몹"
})

---------------------------
--  The Restless Cabal --
---------------------------
L= DBM:GetModLocalization(2328)

L:SetMiscLocalization({
	Zaxasj = "작사아즈",
	Fathuul = "파두울"
})

---------------------------
-- Uu'nat, Harbinger of the Void --
---------------------------
L= DBM:GetModLocalization(2332)

L:SetOptionLocalization({
	UnstableBehavior2	= "공격대 전체의 공명 말풍선 작동 방식 설정 (공대장일 경우 공격대 전체 설정을 통제)",
	SetOne				= "공허의 돌 (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), 삼지창/바다 (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t), 폭풍우/폭풍 (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t)",
	SetTwo				= "공허의 돌 (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), 삼지창/바다 (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t), 폭풍우/폭풍 (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t)",--Default
	SetThree			= "공허의 돌 (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), 삼지창/바다 (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t), 폭풍우/폭풍 (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:0:16|t)",
	SetFour				= "공허의 돌 (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), 삼지창/바다 (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t), 폭풍우/폭풍 (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:0:16|t)",
	SetFive				= "공허의 돌 (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), 삼지창/바다 (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t), 폭풍우/폭풍 (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:16:32|t)",
	SetSix				= "공허의 돌 (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), 삼지창/바다 (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t), 폭풍우/폭풍 (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:16:32|t)"
})

L:SetMiscLocalization({
	Ocean = "삼지창/바다",
	Storm = "폭풍우 소환기",
	Void = "공허의 돌",
	Lunacy = "광기",
	DBMConfigMsg	= "불안정한 공명 설정이 공대장의 설정대로 %s이 되었습니다."
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("CrucibleofStormsTrash")

L:SetGeneralLocalization({
	name =	"폭풍의 용광로 일반몹"
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
	Circles =	"3초 후 동그라미"
})

---------------------------
-- Za'qul --
---------------------------
L= DBM:GetModLocalization(2349)

L:SetMiscLocalization({
	Phase3	= "자쿨이 착란의 영역으로 통하는 길을 엽니다!",
	Tear =	"균열"
})

---------------------------
--  Queen Azshara --
---------------------------
L= DBM:GetModLocalization(2361)

L:SetTimerLocalization{
	timerStageThreeBerserk		= "쫄 광폭화"
}

L:SetOptionLocalization({
	SortDesc 			= "정보 창에 $spell:298569 디버프 중첩을 높은 순으로 정렬합니다. (낮은순 대신)",
	ShowTimeNotStacks	= "정보 창에 $spell:298569 디버프 중첩 대신 남은 시간을 표시합니다.",
	timerStageThreeBerserk	= "3단계 쫄이 광폭화 상태에 들어가면 타이머 바 보기"
})

L:SetMiscLocalization({
	SoakOrb =	"구슬 먹기",
	AvoidOrb =	"구슬 안먹기",
	GroupUp =	"뭉치기",
	Spread =	"산개",
	Move	 =	"계속 이동",
	DontMove =	"이동 중지",
	--For Yells
	HelpSoakMove	= "{rt3}같이 먹기 이동{rt3}",--Purple Diamond
	HelpSoakStay	= "{rt6}같이 먹기 제자리{rt6}",--Blue Square
	HelpSoak		= "{rt3}같이 먹기{rt3}",--Purple Diamond
	HelpMove		= "{rt4}같이 이동{rt4}",--Green Triangle
	HelpStay		= "{rt7}같이 멈춰{rt7}",--Red X
	SoloSoak 		= "혼자 먹기",
	Solo =			"혼자",
	--Not currently used Yells
	SoloMoving		= "혼자 이동",
	SoloStay		= "혼자 제자리",
	SoloSoakMove	= "혼자 맞기 이동",
	SoloSoakStay	= "혼자 맞기 제자리"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("EternalPalaceTrash")

L:SetGeneralLocalization({
	name =	"영원한 궁전 일반몹"
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
	InterruptBehavior	= "공포의 물결 차단 방식 설정 (공대장일 경우 다른 사람의 설정보다 우선 적용)",
	Four				= "4인 로테이션 ",--Default
	Five				= "5인 로테이션 ",
	Six					= "6인 로테이션 ",
	NoReset				= "로테이션 없음 "
})

L:SetMiscLocalization({
	ObeliskSpawn	= "솟아나라, 어둠의 방첨탑이여!"--Only as backup, in case the NPC target check stops working
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
	OnlyParentBondMoves		= "충전된 결속의 기준점이 될 때만 특별 경고 표시"
})

L:SetMiscLocalization({
	Furthest	= "제일 먼 대상",
	Closest		= "가장 가까운 대상"
})

---------------------------
--  Il'gynoth, Corruption Reborn --
---------------------------
L= DBM:GetModLocalization(2374)

L:SetOptionLocalization({
	SetIconOnlyOnce		= "가장 생명력이 낮은 쫄을 탐지해서 징표를 한번만 지정하고 죽을때까지 징표 유지",
	InterruptBehavior	= "혈류 공급 차단 방식 설정 (공대장일 경우 다른 사람의 설정보다 우선 적용)",
	Two				= "2인 로테이션 ",--Default
	Three				= "3인 로테이션 ",
	Four				= "4인 로테이션 ",
	Five				= "5인 로테이션 "
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
	InterruptBehavior	= "정신학대 차단 방식 설정 (공대장일 경우 다른 사람의 설정보다 우선 적용)",
	Four				= "4인 로테이션 ",
	Five				= "5인 로테이션 ",--Default
	Six					= "6인 로테이션 ",
	NoReset				= "로테이션 없음 ",
	ArrowOnGlare		= "$spell:317874을 피할 방향을 좌우 화살표로 표시",
	HideDead			= "신화 이외 난이도에서 죽은 공대원은 정보 창에서 제외"
})

L:SetMiscLocalization({
	ExitMind		= "정신세계 출구",
	Gate			= "관문"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("NyalothaTrash")

L:SetGeneralLocalization({
	name =	"나이알로사 일반몹"
})
