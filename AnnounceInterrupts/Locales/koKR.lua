-- koKR (Korean) translation
if GetLocale() ~= "koKR" then return end

local L = AnnounceInterrupts_Locales

L.enable_addon = "에드온 활성화"

L.active_raid = "공격대 인스턴스에서 사용"
L.active_party = "5인 던전에서 사용"
L.active_BG = "전장에서 사용"
L.active_arena = "투기장에서 사용"
L.active_scenario = "시나리오에서 사용"
L.active_outdoors = "야외에서 사용"

L.include_pet_interrupts = "소환수의 차단 포함하기"
L.channel = "채널:"

L.channel_say = "일반"
L.channel_raid = "공격대"
L.channel_party = "파티"
L.channel_instance = "인스턴스"
L.channel_yell = "외치기"
L.channel_self = "나에게만 보이기"
L.channel_emote = "감정표현"
L.channel_whisper = "귓속말"
L.channel_custom = "사용자 채널"

L.output = "출력 방식:"

L.hint = "힌트:\n%t 대상의 이름 표시\n%sl 차단한 주문의 링크 표시\n%sn 차단한 주문의 이름 표시\n%sc 차단한 주문의 마법 계열 표시\n%ys 주문 차단에 사용한 자신의 스킬 이름 표시"

L.defualt_message = "%t의 %sl 차단!"

L.welcome_message = "Announce Interrupts를 설치해 주셔서 감사합니다! 애드온의 설정을 위해서는 /ai를 채팅장에 입력해주세요."

L.smart_channel = "스마트 채널 선택"

L.smart_details = "만약 선택한 채널이 비활성화 상태이면\n애드온에서 자동으로 다른 채널을 선택합니다."
