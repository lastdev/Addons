-- Translations missing or inaccurate? Visit http://wow.curseforge.com/addons/fatality/localization/ to see if you can help!
if GetLocale() ~= "koKR" then return end

local L = Fatality_Locales

-- Welcome Messages
L.welcome1 = "최신 버전으로 업데이트해 주셔서 고맙습니다!"
L.welcome2 = "|cffff9900/fatality|r 혹은 |cffff9900/fat|r 를 입력하면, 다음에도 이 메뉴를 열어 설정을 바꿀 수 있어요."
L.welcome3 = "|cffff0000[Note]|r 이 메시지는 캐릭터 당 한 번만 표시됩니다."

-- Addon
L.addon_enabled = "|cff00ff00활성|r"
L.addon_disabled = "|cffff0000비활성|r"

-- Damage
L.damage_overkill = "오버킬: %s"
L.damage_resist = "저항: %s"
L.damage_absorb = "흡수: %s"
L.damage_block = "방어: %s"

-- Error Messages
L.error_report = "(%s) 255 글자를 넘는 바람에 보고를 못했네요 ㅜㅜ. 이를 고치려면, /fatality 를 입력한 뒤 '이벤트 히스토리' 옵션을 낮추거나, '보고할 곳'을 자신으로 설정하세요."
L.error_options = "|cffFF9933Fatality_Options|r 을 읽지 못했습니다."

-- Configuration: Title
L.config_promoted = "승격"
L.config_lfr = "공격대 찾기"
L.config_raid = "공격대"
L.config_party = "파티"
L.config_overkill = "오버킬"
L.config_resist = "저항"
L.config_absorb = "흡수"
L.config_block = "방어"
L.config_icons = "아이콘"
L.config_school = "속성"
L.config_source = "Source"
L.config_short = "줄임"
L.config_limit10 = "보고 제한 (10인)"
L.config_limit25 = "보고 제한 (25인)"
L.config_history = "이벤트 히스토리"
L.config_threshold = "피해 최소량"
L.config_output_raid = "보고할 곳 (공격대 던전에서)"
L.config_output_party = "보고할 곳 (파티 던전에서)"

-- Configuration: Description
L.config_promoted_desc = "승격했을 때만 알림 ["..RAID_LEADER.."/"..RAID_ASSISTANT.."]"
L.config_lfr_desc = "공격대 찾기에서 활성화"
L.config_raid_desc = "공격대 던전에서 활성화"
L.config_party_desc = "파티 던전에서 활성화"
L.config_overkill_desc = "오버킬 포함"
L.config_resist_desc = "저항한 피해를 포함"
L.config_absorb_desc = "흡수한 피해를 포함"
L.config_block_desc = "방어한 피해를 포함"
L.config_icons_desc = "공격대 아이콘 포함"
L.config_school_desc = "피해 속성을 포함"
L.config_source_desc = "Include source of damage"
L.config_short_desc = "숫자를 간단히 표시 [9431 = 9.4k]"
L.config_limit_desc = "한 전투에서 보고할 죽음의 최대 횟수는?"
L.config_history_desc = "한 사람 당 보고할 피해 이벤트의 최대 횟수는?"
L.config_threshold_desc = "기록할 피해량의 최소값은?"
L.config_channel_default = "<채널 이름>"
L.config_whisper_default = "<캐릭터 이름>"