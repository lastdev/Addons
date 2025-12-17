-- Localization for HousingVendor addon - Korean
local L = {}

-- Main UI Strings
L["HOUSING_VENDOR_TITLE"] = "주택 장식 위치"
L["HOUSING_VENDOR_SUBTITLE"] = "아제로스 전역의 판매자들로부터 모든 주택 장식 찾아보기"

-- Filter Labels
L["FILTER_SEARCH"] = "검색:"
L["FILTER_EXPANSION"] = "확장팩:"
L["FILTER_VENDOR"] = "판매자:"
L["FILTER_ZONE"] = "지역:"
L["FILTER_TYPE"] = "유형:"
L["FILTER_CATEGORY"] = "분류:"
L["FILTER_FACTION"] = "진영:"
L["FILTER_SOURCE"] = "출처:"
L["FILTER_PROFESSION"] = "전문기술:"
L["FILTER_CLEAR"] = "필터 지우기"
L["FILTER_ALL_EXPANSIONS"] = "모든 확장팩"
L["FILTER_ALL_VENDORS"] = "모든 판매자"
L["FILTER_ALL_ZONES"] = "모든 지역"
L["FILTER_ALL_TYPES"] = "모든 유형"
L["FILTER_ALL_CATEGORIES"] = "모든 분류"
L["FILTER_ALL_SOURCES"] = "모든 출처"
L["FILTER_ALL_FACTIONS"] = "모든 진영"

-- Column Headers
L["COLUMN_ITEM"] = "아이템"
L["COLUMN_ITEM_NAME"] = "아이템 이름"
L["COLUMN_SOURCE"] = "출처"
L["COLUMN_LOCATION"] = "위치"
L["COLUMN_PRICE"] = "가격"
L["COLUMN_COST"] = "비용"
L["COLUMN_VENDOR"] = "판매자"
L["COLUMN_TYPE"] = "유형"

-- Buttons
L["BUTTON_SETTINGS"] = "설정"
L["BUTTON_STATISTICS"] = "통계"
L["BUTTON_BACK"] = "← 뒤로"
L["BUTTON_CLOSE"] = "닫기"
L["BUTTON_WAYPOINT"] = "웨이포인트 설정"
L["BUTTON_SAVE"] = "저장"
L["BUTTON_RESET"] = "초기화"

-- Settings Panel
L["SETTINGS_TITLE"] = "주택 애드온 설정"
L["SETTINGS_GENERAL_TAB"] = "일반"
L["SETTINGS_COMMUNITY_TAB"] = "커뮤니티"
L["SETTINGS_MINIMAP_SECTION"] = "미니맵 버튼"
L["SETTINGS_SHOW_MINIMAP_BUTTON"] = "미니맵 버튼 표시"
L["SETTINGS_UI_SCALE_SECTION"] = "UI 크기 조절"
L["SETTINGS_UI_SCALE"] = "UI 크기 조절"
L["SETTINGS_FONT_SIZE"] = "글꼴 크기"
L["SETTINGS_RESET"] = "초기화"
L["SETTINGS_RESET_DEFAULTS"] = "기본값으로 재설정"
L["SETTINGS_PROGRESS_TRACKING"] = "진행 상황 추적"
L["SETTINGS_SHOW_COLLECTED"] = "수집한 아이템 표시"
L["SETTINGS_WAYPOINT_NAVIGATION"] = "웨이포인트 탐색"
L["SETTINGS_USE_PORTAL_NAVIGATION"] = "스마트 포털 탐색 사용"

-- Tooltips
L["TOOLTIP_SETTINGS"] = "설정"
L["TOOLTIP_SETTINGS_DESC"] = "애드온 옵션 구성"
L["TOOLTIP_WAYPOINT"] = "웨이포인트 설정"
L["TOOLTIP_WAYPOINT_DESC"] = "이 판매자에게 이동"
L["TOOLTIP_PORTAL_NAVIGATION_ENABLED"] = "스마트 포털 탐색 활성화됨"
L["TOOLTIP_PORTAL_NAVIGATION_DESC"] = "지역 간 이동 시 자동으로 가장 가까운 포털을 사용합니다"
L["TOOLTIP_DIRECT_NAVIGATION"] = "직접 탐색 활성화됨"
L["TOOLTIP_DIRECT_NAVIGATION_DESC"] = "웨이포인트가 판매자 위치를 직접 가리킵니다 (지역 간 이동에는 권장되지 않음)"

-- Messages
L["MESSAGE_PORTAL_NAV_ENABLED"] = "스마트 포털 탐색이 활성화되었습니다. 지역 간 이동 시 웨이포인트가 자동으로 가장 가까운 포털을 사용합니다."
L["MESSAGE_DIRECT_NAV_ENABLED"] = "직접 탐색이 활성화되었습니다. 웨이포인트가 판매자 위치를 직접 가리킵니다 (지역 간 이동에는 권장되지 않음)."

-- Community Section
L["COMMUNITY_TITLE"] = "커뮤니티 및 지원"
L["COMMUNITY_INFO"] = "팁을 공유하고, 버그를 신고하며, 새로운 기능을 제안하려면 커뮤니티에 참여하세요!"
L["COMMUNITY_DISCORD"] = "디스코드 서버"
L["COMMUNITY_GITHUB"] = "GitHub"
L["COMMUNITY_REPORT_BUG"] = "버그 신고"
L["COMMUNITY_SUGGEST_FEATURE"] = "기능 제안"

-- Preview Panel
L["PREVIEW_TITLE"] = "아이템 미리보기"
L["PREVIEW_NO_SELECTION"] = "상세 정보를 보려면 아이템을 선택하세요"

-- Status Bar
L["STATUS_ITEMS_DISPLAYED"] = "%d개 아이템 표시됨 (총 %d개)"

-- Errors
L["ERROR_ADDON_NOT_INITIALIZED"] = "주택 애드온이 초기화되지 않았습니다"
L["ERROR_UI_NOT_AVAILABLE"] = "HousingVendor UI를 사용할 수 없습니다"
L["ERROR_CONFIG_PANEL_NOT_AVAILABLE"] = "구성 패널을 사용할 수 없습니다"

-- Statistics UI
L["STATS_TITLE"] = "통계 대시보드"
L["STATS_COLLECTION_PROGRESS"] = "수집 진행률"
L["STATS_ITEMS_BY_SOURCE"] = "출처별 아이템"
L["STATS_ITEMS_BY_FACTION"] = "진영별 아이템"
L["STATS_COLLECTION_BY_EXPANSION"] = "확장팩별 수집"
L["STATS_COLLECTION_BY_CATEGORY"] = "분류별 수집"
L["STATS_COMPLETE"] = "%d%% 완료 - %d / %d개 아이템 수집됨"

-- Footer
L["FOOTER_COLOR_GUIDE"] = "색상 가이드:"
L["FOOTER_WAYPOINT_INSTRUCTION"] = "%s가 있는 아이템을 클릭하여 웨이포인트 설정"

-- Main UI
L["MAIN_SUBTITLE"] = "주택 카탈로그"

-- Common Strings
L["COMMON_FREE"] = "무료"
L["COMMON_UNKNOWN"] = "알 수 없음"
L["COMMON_NA"] = "해당 없음"
L["COMMON_GOLD"] = "골드"
L["COMMON_ITEM_ID"] = "아이템 ID:"

-- Miscellaneous
L["MINIMAP_TOOLTIP"] = "주택 판매자 브라우저"
L["MINIMAP_TOOLTIP_DESC"] = "왼쪽 클릭으로 주택 판매자 브라우저 전환"

-- Make the locale table globally available
_G["HousingVendorLocale"] = L