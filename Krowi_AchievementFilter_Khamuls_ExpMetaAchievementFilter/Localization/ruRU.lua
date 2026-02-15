local ADDON_NAME = ...
local L = LibStub("AceLocale-3.0"):NewLocale(ADDON_NAME, "ruRU")

if not L then return end

-- translated using chatgpt

-- Globals
L["Khamuls Collections for Krowi's Achievement Filter"] = "Коллекции Хамула для фильтра достижений Крови"
L["Khamul's Meta-Expansion Achievement List"] = "Коллекция мета-маунтов Хамула"
L["Khamul's House Decor Achievement List"] = "Коллекция декора Хамула"
L["Khamul's Campsite Achievement List"] = "Коллекция лагерей Хамула"
L["Khamul's Battle Pet Achievement List"] = "Коллекция боевых питомцев Хамула"

-- Special categories
L["Cross-Expansion"] = "Между дополнениями"

-- Missing category titles
L["Hard"] = "Сложный"
L["Nightmare"] = "Кошмар"

-- Tooltips
L["Tt_ACM_15035"] = "Для завершения мета-достижения требуется только 4"
L["Tt_UseMetaAchievementPlugin"] = "Используйте категорию «Коллекция мета-маунтов Хамула», чтобы получить подробный обзор для «{1}»."

-- Messages
L["Krowi's Achievement Filter Addon not loaded!"] = "Аддон «Фильтр достижений Крови» не загружен!"

-- Options
L["Show List for Expansion Meta Achievements"] = "Показать коллекцию мета-маунтов"
L["If enabled, a list with all achievements required for expansion meta achievements will be shown"] = "Если включено, будет показана коллекция со всеми достижениями, необходимыми для мета-достижений дополнений."
L["Show List for Achievements with decors as reward"] = "Показать коллекцию достижений с декором в награду"
L["If enabled, a list with all achievements, which have a decor as reward, will be shown"] = "Если включено, будет показана коллекция всех достижений, в награду за которые даётся декор."
L["Show List for Achievements with warband campsites as reward"] = "Показать коллекцию достижений с лагерями боевой группы в награду"
L["If enabled, a list with all achievements, which have a warband campsite as reward, will be shown"] = "Если включено, будет показана коллекция всех достижений, в награду за которые даётся лагерь боевой группы."
L["Show List for Achievements with battle pets as reward"] = "Показать коллекцию достижений с боевыми питомцами в награду"
L["If enabled, a list with all achievements, which have a battle pet as reward, will be shown"] = "Если включено, будет показана коллекция всех достижений, в награду за которые даётся боевой питомец."
L["Krowi AchievementFilter status: "] = "Статус Krowi AchievementFilter: "
L["detected"] = "обнаружен"
L["not detected"] = "не обнаружен"
L["Decor Collection Settings"] = "Настройки коллекции декора"
L["Meta-Mount Collection Settings"] = "Настройки коллекции мета-маунтов"
L["Campsite Collection Settings"] = "Настройки коллекции лагерей"
L["Pet Collection Settings"] = "Настройки коллекции питомцев"
L["Flatten collection structure"] = "Упростить структуру коллекции"
L["The collections depth will be flatten and all achievements will be displayed in the expansions category"] = "Глубина коллекции будет упрощена, и все достижения будут отображаться в категории дополнения."
L["Include Child Achievements"] = "Включить зависимые достижения"
L["If an Achievement has other Achievements as requirement, they will be shown in an extra category."] = "Если для достижения требуются другие достижения, они будут показаны в дополнительной категории."
L["Changing any option on this page, requires a reload to take affect."] = "Изменение любого параметра на этой странице требует перезагрузки интерфейса для применения изменений."
L["Include Battle-Pet related rewards"] = "Включить награды, связанные с боевыми питомцами"
L["This will include Achievements with Pet-Battle rewards like daily quests unlock, costumes and toys"] = "Сюда будут включены достижения с наградами за бои питомцев, такими как открытие ежедневных заданий, костюмы и игрушки"