
if GetLocale() ~= "koKR" then return end
local _, tbl = ...
local L = tbl.locale

L["add"] = "추가"
L["autoLootMethod"] = "참가한 그룹이 있을 때 자동으로 전리품 획득 방식을 설정합니다." -- Needs review
L["autoLootMethodDesc"] = "파티나 공격대에 참여 시 자동으로 전리품 획득 방식을 oRA3을 통해 설정합니다." -- Needs review
L["average"] = "평균"
L["barSettings"] = "바 설정"
L["battleResLockDesc"] = "모니터 잠금 토글. 제목 문자, 배경을 숨기고 이동을 방지합니다." -- Needs review
L["battleResShowDesc"] = "모니터 표시 또는 숨기기 토글" -- Needs review
L["battleResTitle"] = "전투 부활 모니터" -- Needs review
L["blizzMainTank"] = "블리자드 방어 전담" -- Needs review
L["broken"] = "파손"
L["byGuildRank"] = "길드 등급별"
L["center"] = "중앙"
L["checks"] = "체크"
L["cooldowns"] = "재사용 대기시간"
L["cooldownSettings"] = "재사용 대기시간 설정"
L["customColor"] = "사용자 색상"
L["deleteButtonHelp"] = "방어 전담 목록에서 삭제합니다. 삭제 후엔 현재 세션에서 수동으로 다시 추가하기 전까지 다시 추가되지 않습니다." -- Needs review
L["demoteEveryone"] = "모두 강등"
L["demoteEveryoneDesc"] = "현재 그룹의 모두를 강등시킵니다." -- Needs review
L["disbandGroup"] = "그룹 해산" -- Needs review
L["disbandGroupDesc"] = [=[그룹의 모든 사람을 추방하여 현재 파티 또는 공격대를 해산합니다.

이것은 잠재적으로 매우 파괴적이기 때문에, 당신에게 확인 대화창이 표시됩니다. 컨트롤 키를 누른 상태에선 이 대화창을 무시합니다.]=] -- Needs review
L["disbandGroupWarning"] = "정말로 당신의 파티/공격대를 해산하겠습니까?"
L["disbandingGroupChatMsg"] = "파티를 해산합니다."
L["durability"] = "내구도"
L["duration"] = "지속 시간"
L["durationTextSettings"] = "지속시간 문자 설정" -- Needs review
L["ensureRepair"] = "공격대에서 현재 모든 등급에 대해 길드 수리가 활성화 되어있는지 확인"
L["ensureRepairDesc"] = "당신이 만약 길드장이며 공격대에 합류하였고 공격대장 또는 부공격대장이면, 공격대에 있는 동안 길드원의 수리비에 대해 길드 수리비(최대 300골드)를 지원하도록 설정 가능합니다. |cffff4411당신이 공격대를 떠나면 원래 상태로 돌아가니 파산등의 걱정은 하지마세요 :)|r" -- Needs review
L["font"] = "글꼴" -- Needs review
L["fontSize"] = "글꼴 크기" -- Needs review
L["gear"] = "장비" -- Needs review
L["growUpwards"] = "성장 방향"
L["guildKeyword"] = "길드 키워드"
L["guildKeywordDesc"] = "귓속말로 키워드를 보낸 길드원을 자동으로 즉시 파티에 초대됩니다." -- Needs review
L["guildRankInvites"] = "길드 등급 초대"
L["guildRankInvitesDesc"] = "아래 버튼을 클릭하면 선택한 등급 이상의 모든 사람을 그룹에 초대합니다. 예를 들어, 3번째 버튼을 클릭하면 등급 1,2,3의 모두를 초대합니다. 실제 초대가 이루어지기 전에 길드 또는 관리자 대화에 메시지를 먼저 보내고 길드원들이 그들의 그룹에서 떠날 수 있도록 10초의 시간을 줍니다." -- Needs review
L["height"] = "높이"
L["hideInCombat"] = "전투 시 숨김" -- Needs review
L["hideInCombatDesc"] = "전투 중일 경우, 전투 준비 확인창을 자동으로 숨깁니다." -- Needs review
L["hideReadyPlayers"] = "준비된 플레이어 숨김"
L["hideReadyPlayersDesc"] = "창에 준비가 된 플레이어를 표시 하지 않습니다." -- Needs review
L["hideWhenDone"] = "완료 시 창 닫기" -- Needs review
L["hideWhenDoneDesc"] = "전투 준비 확인 완료 시 자동으로 창을 닫습니다." -- Needs review
L["home"] = "사용자" -- Needs review
L["icon"] = "아이콘"
L["individualPromotions"] = "개별적 승급"
L["individualPromotionsDesc"] = "이름은 대소문자를 구분합니다. 플레이어를 추가하려면, 아래의 상자에 플레이어 이름을 입력하고 엔터키를 누르거나 팝업 버튼을 클릭하세요. 자동 승급 중인 플레이어를 제거하려면, 아래의 드롭다운에서 그의 이름을 클릭하면 됩니다." -- Needs review
L["invite"] = "초대"
L["inviteDesc"] = "아래 키워드로 사람들이 당신에게 귓속말시에 자동으로 당신의 파티에 초대됩니다. 만약 당신이 파티중이며 5명일경우 자동으로 공격대로 전환됩니다. 공격대가 40명이 찰경우에는 키워드 작동이 더이상되지 않습니다."
L["inviteGuild"] = "길드원 초대"
L["inviteGuildDesc"] = "길드 내 최고 레벨의 모든 길드원을 공격대에 초대합니다." -- Needs review
L["inviteGuildRankDesc"] = "%s 등급 이상인 모든 길드원을 공격대에 초대합니다."
L["inviteInRaidOnly"] = "공격대 구성 중일 때 키워드로만 초대하기" -- Needs review
L["invitePrintGroupIsFull"] = "죄송합니다. 공격대의 정원이 찼습니다."
L["invitePrintMaxLevel"] = "10초 동안 최고 레벨 길드원들을 공격대에 초대합니다. 파티에서 나와 주세요." -- Needs review
L["invitePrintRank"] = "10초 동안 %s 등급 이상인 길드원들을 공격대에 초대합니다. 파티에서 나와 주세요."
L["invitePrintZone"] = "10초 동안 %s에 있는 모든 길드원을 공격대에 초대합니다. 파티에서 나와 주세요." -- Needs review
L["inviteZone"] = "지역 초대"
L["inviteZoneDesc"] = "현재 지역 내의 모든 길드원을 공격대에 초대합니다."
L["itemLevel"] = "아이템 레벨" -- Needs review
L["keyword"] = "키워드"
L["keywordDesc"] = "설정된 키워드로 귓속말을 하면 즉시 자동으로 자신의 공격대로 초대합니다."
L["labelAlign"] = "Label 정렬"
L["labelTextSettings"] = "라벨 문자 설정" -- Needs review
L["latency"] = "지연시간" -- Needs review
L["left"] = "좌측"
L["lockMonitor"] = "모니터 잠금"
L["lockMonitorDesc"] = "크기를 조정하거나 바에 대한 표시 옵션을 엽니다. 재사용 대기시간 모니터의 제목을 드래그로 이동 가능하며 모니터 잠금시 제목을 숨깁니다."
L["makeLootMaster"] = "자신이 담당자 획득이면 비워 둡니다."
L["massPromotion"] = "집단 승급"
L["minimum"] = "최소"
L["missingEnchants"] = "누락된 마법부여" -- Needs review
L["missingGems"] = "누락된 보석" -- Needs review
L["monitorSettings"] = "모니터 설정"
L["moveTankUp"] = "탱커를 위로 이동하려면 클릭하세요."
L["name"] = "이름"
L["neverShowOwnSpells"] = "자신의 기술을 표시하지 않음"
L["neverShowOwnSpellsDesc"] = "자신의 재사용 대기시간을 표시하지 않도록 전환합니다. 예를 들면 자신의 재사용 대기시간을 위한 다른 표시 애드온을 사용 할 때 사용합니다." -- Needs review
L["noResponse"] = "응답 없음"
L["notReady"] = "준비 안됨"
L["offline"] = "오프라인"
L["onlyMyOwnSpells"] = "자신의 기술만 표시"
L["onlyMyOwnSpellsDesc"] = "자신의 재사용 대기시간만 표시하도록 전환합니다. 보통의 재사용 대기시간 표시 애드온의 역할을 합니다." -- Needs review
L["openMonitor"] = "모니터 열기"
L["options"] = "옵션"
L["outline"] = "외곽선" -- Needs review
L["printToRaid"] = "준비 확인 결과를 공격대 대화창으로 알림"
L["printToRaidDesc"] = "당신이 공격대장 또는 부공격대장일 경우에 전투 준비 확인 결과를 공격대 대화창으로 출력하도록 합니다. 한 사람만 활성화 할 수 있도록 해주세요." -- Needs review
L["profile"] = "프로필"
L["promote"] = "승급"
L["promoteEveryone"] = "모든 사람"
L["promoteEveryoneDesc"] = "자동적으로 모든 사람을 승급합니다."
L["promoteGuild"] = "길드"
L["promoteGuildDesc"] = "자동적으로 모든 길드원을 승급합니다."
L["ready"] = "준비 완료"
L["readyCheckSeconds"] = "전투 준비 (%d 초)" -- Needs review
L["readyCheckSound"] = "전투 준비 요청이 왔을 때 전투 준비 소리를 Master 소리 채널로 재생합니다. \"효과음\"이 꺼져있을 때도 더 높은 볼륨으로 소리를 재생합니다." -- Needs review
L["remove"] = "삭제"
L["repairEnabled"] = "이 공격대에서 %s 에 대해 길드 수리를 활성화합니다."
L["right"] = "우측"
L["rightClick"] = "옵션 설정은 우-클릭!"
L["save"] = "저장"
L["saveButtonHelp"] = "개인적인 탱커 목록을 저장합니다. 언제든 이 플레이어와 같은 그룹이 되면 개인적인 탱커 목록으로 지정됩니다." -- Needs review
L["scale"] = "크기"
L["selectClass"] = "직업 선택"
L["selectClassDesc"] = "선택한 주문에 대한 재사용 대기시간을 표시합니다."
L["shortSpellName"] = "짧은 주문 이름"
L["show"] = "표시"
L["showButtonHelp"] = "이 탱커를 개인 탱커 화면에 정렬하도록 표시합니다. 이 옵션은 당신에게만 적용되며 그룹에서 다른 사람의 탱커가 변경되지 않습니다." -- Needs review
L["showHelpTexts"] = "인터페이스 도움말 보기"
L["showHelpTextsDesc"] = "oRA3 패널창에서 도움말을 표시합니다."
L["showMonitor"] = "모니터 표시"
L["showMonitorDesc"] = "게임 환경안에 재사용 대기시간 바를 표시하거나 숨깁니다."
L["showRoleIcons"] = "공격대 패널에 역할 아이콘 표시하기" -- Needs review
L["showRoleIconsDesc"] = "블리자드 공격대 패널에 역할 아이콘과 역할 별 총 인원 수를 표시합니다. 이 설정을 적용하려면 공격대 패널을 다시 열어야 합니다." -- Needs review
L["showWindow"] = "창 표시"
L["showWindowDesc"] = "전투 준비 확인시 창을 표시합니다."
L["slashCommands"] = [=[
oRA3는 레이드 진행 중 빠른 도움을 주기 위해 다양한 슬래쉬 명령어를 제공합니다. 구 CTRA 시절에 머물지 않으려면, 여기를 참고하세요. 모든 슬래쉬 명령어는 축약형이며 때로는 깁니다, 편의성을 위해, 일부의 경우 더 서술적입니다.

|cff44ff44/radur|r - 내구도 목록 열기.
|cff44ff44/ragear|r - 장비 체크 목록 열기.
|cff44ff44/ralag|r - 지연시간 목록 열기.
|cff44ff44/razone|r - 지역 목록 열기.
|cff44ff44/radisband|r - 확인 절차 없이 공격대 즉시 해체.
|cff44ff44/raready|r - 전투 준비 실행하기.
|cff44ff44/rainv|r - 그룹에 길드 전체 초대하기.
|cff44ff44/razinv|r - 같은 지역에 있는 길드원 초대하기.
|cff44ff44/rarinv <등급 이름>|r - 주어진 등급의 길드원 초대하기.
]=] -- Needs review
L["slashCommandsHeader"] = "슬래쉬 명령어" -- Needs review
L["sort"] = "정렬"
L["spawnTestBar"] = "테스트 바 표시"
L["spellName"] = "주문 이름"
L["tankButtonHelp"] = "여기 탱커를 블리자드 방어 전담으로 전환합니다." -- Needs review
L["tankHelp"] = [=[위의 목록에 있는 사람들은 당신이 개인적으로 정렬시킨 탱커들입니다. 그들을 공격대원과 공유하지 않으며 각 공격대원들은 자신이 원하는 탱커를 지정하여 개인적인 목록을 가질수 있습니다. 하단의 목록에서 이름을 클릭하면 개인 탱커 목록에 추가됩니다.

방패 아이콘을 클릭하면 블리자드 방어 전담으로 지정합니다. 블리자드 방어 전담으로 지정시 모든 공격대원에게 공유됩니다.

목록에 표시되는 탱커는 다른 사람이 블리자드 방어 전담으로 지정한 후 블리자드 방어 전담이 해제되면 목록에서 제거됩니다.

녹색 체크 표시를 사용하여 탱커를 저장합니다. 다음번에 당신이 그 사람과 함께 공격대에 참여할 시 그는 개인적인 탱커로 자동으로 설정됩니다.]=] -- Needs review
L["tanks"] = "탱커"
L["tankTabTopText"] = "하단의 목록에서 플레이어를 클릭하여 개인적인 탱커를 지정합니다. 만약에 옵션에 대한 도움이 필요하다면 물음표 표시에 마우스를 올려놓으세요."
L["texture"] = "텍스쳐"
L["thick"] = "두껍게" -- Needs review
L["thin"] = "얇게" -- Needs review
L["togglePane"] = "oRA3 패널 전환"
L["toggleWithRaid"] = "공격대 패널과 함께 열기"
L["toggleWithRaidDesc"] = "공격대 패널을 열거나 닫을때 oRA3 패널도 같이 열거나 닫히도록 합니다. 따로 |cff44ff44/radur|r 같은 슬래쉬 명령어나 단축키 지정으로도 열수 있습니다." -- Needs review
L["unitName"] = "유닛 이름"
L["unknown"] = "알 수 없음" -- Needs review
L["useClassColor"] = "직업 색상 사용"
L["whatIsThis"] = "이것 모두 무엇입니까?"
L["world"] = "서버" -- Needs review
L["zone"] = "지역"
