local ADDON_NAME = ...
local L = LibStub("AceLocale-3.0"):NewLocale(ADDON_NAME, "koKR")

if not L then return end

-- translated using chatgpt

-- Globals
L["Khamuls Collections for Krowi's Achievement Filter"] = "Krowi의 업적 필터를 위한 Khamul의 컬렉션"
L["Khamul's Meta-Expansion Achievement List"] = "Khamul의 메타 탈것 컬렉션"
L["Khamul's House Decor Achievement List"] = "Khamul의 장식 컬렉션"
L["Khamul's Campsite Achievement List"] = "Khamul의 야영지 컬렉션"
L["Khamul's Battle Pet Achievement List"] = "Khamul의 전투 애완동물 컬렉션"

-- Special categories
L["Cross-Expansion"] = "확장팩 공통"

-- Missing category titles
L["Hard"] = "어려움"
L["Nightmare"] = "악몽"

-- Tooltips
L["Tt_ACM_15035"] = "메타 업적을 완료하려면 4개만 필요합니다"
L["Tt_UseMetaAchievementPlugin"] = "\"{1}\"에 대한 자세한 개요를 보려면 \"Khamul의 메타 탈것 컬렉션\" 범주를 사용하세요."

-- Messages
L["Krowi's Achievement Filter Addon not loaded!"] = "Krowi의 업적 필터 애드온이 로드되지 않았습니다!"

-- Options
L["Show List for Expansion Meta Achievements"] = "메타 탈것 컬렉션 표시"
L["If enabled, a list with all achievements required for expansion meta achievements will be shown"] = "활성화하면 확장팩 메타 업적에 필요한 모든 업적이 포함된 컬렉션이 표시됩니다."
L["Show List for Achievements with decors as reward"] = "보상으로 장식을 제공하는 업적 컬렉션 표시"
L["If enabled, a list with all achievements, which have a decor as reward, will be shown"] = "활성화하면 보상으로 장식을 제공하는 모든 업적이 포함된 컬렉션이 표시됩니다."
L["Show List for Achievements with warband campsites as reward"] = "보상으로 전투부대 야영지를 제공하는 업적 컬렉션 표시"
L["If enabled, a list with all achievements, which have a warband campsite as reward, will be shown"] = "활성화하면 보상으로 전투부대 야영지를 제공하는 모든 업적이 포함된 컬렉션이 표시됩니다."
L["Show List for Achievements with battle pets as reward"] = "보상으로 전투 애완동물을 제공하는 업적 컬렉션 표시"
L["If enabled, a list with all achievements, which have a battle pet as reward, will be shown"] = "활성화하면 보상으로 전투 애완동물을 제공하는 모든 업적이 포함된 컬렉션이 표시됩니다."
L["Krowi AchievementFilter status: "] = "Krowi AchievementFilter 상태: "
L["detected"] = "감지됨"
L["not detected"] = "감지되지 않음"
L["Decor Collection Settings"] = "장식 컬렉션 설정"
L["Meta-Mount Collection Settings"] = "메타 탈것 컬렉션 설정"
L["Campsite Collection Settings"] = "야영지 컬렉션 설정"
L["Pet Collection Settings"] = "애완동물 컬렉션 설정"
L["Flatten collection structure"] = "컬렉션 구조 단순화"
L["The collections depth will be flatten and all achievements will be displayed in the expansions category"] = "컬렉션 깊이가 단순화되며 모든 업적이 확장팩 범주에 표시됩니다."
L["Include Child Achievements"] = "하위 업적 포함"
L["If an Achievement has other Achievements as requirement, they will be shown in an extra category."] = "업적에 다른 업적이 요구 사항으로 있을 경우, 추가 범주에 표시됩니다."
L["Changing any option on this page, requires a reload to take affect."] = "이 페이지의 옵션을 변경하면 적용을 위해 인터페이스를 다시 불러와야 합니다."
L["Include Battle-Pet related rewards"] = "전투 애완동물 관련 보상 포함"
L["This will include Achievements with Pet-Battle rewards like daily quests unlock, costumes and toys"] = "일일 퀘스트 해금, 의상, 장난감 등 전투 애완동물 보상을 제공하는 업적이 포함됩니다"