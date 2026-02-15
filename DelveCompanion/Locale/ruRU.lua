if GetLocale() ~= "ruRU" then return end -- Russian

local _, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Lockit
local Lockit = DelveCompanion.Lockit
-- ====================== NO ADDON DATA BELOW, ONLY LOCKIT ===================================================

-- Общие

Lockit.UI_COMMON_BOUNTIFUL_DELVE_TITLE = "Многообещающая Вылазка"
Lockit.UI_COMMON_MISSING_ADDON_TITLE = "Отсутствует необходимый аддон: %s" -- `%s`: Имя аддона. Например, DelveCompanion

-- Список вылазок

Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_CLICK_INSTRUCTION = "<[Shift + ЛКМ] - установить точку маршрута к вылазке>"
Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_CURRENT_TEXT = "Точка маршрута установлена."
Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_CLEAR_INSTRUCTION = "<[Shift + ЛКМ] - сбросить точку маршрута>"
Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_CLEAR_MPE = "Для удаления точек маршрута используйте MapPinEnhanced Tracker."

-- Интерфейс вылазок

Lockit.UI_GILDED_STASH_CANNOT_RETRIEVE_DATA = "Посетите Каз Алгар, чтобы увидеть прогресс"
Lockit.UI_GILDED_STASH_BOUNTIFUL_NOTE = "Появляется только на |cnNORMAL_FONT_COLOR:11-м Уровне|r Многообещающих Вылазок|A:delves-bountiful:16:16|a."
Lockit.UI_NO_ACTIVE_BOUNTIFUL = "Нет активных Вылазок"
Lockit.UI_LOOT_INFO_BUTTON_TOOLTIP_INSTRUCTION = "<Нажмите, чтобы отобразить информацию о добыче Вылазок>"

-- Информация о добыче

Lockit.UI_LOOT_INFO_DESCRIPTION = "Завершите Вылазку, чтобы получить:"

-- Информация о ключах

Lockit.UI_BOUNTIFUL_KEYS_COUNT_CACHES_PREFIX = "Ключей из тайников"

-- Отделение для аддонов

Lockit.UI_COMPARTMENT_DESCRIPTION_LEFT_CLICK = "|cnGREEN_FONT_COLOR:ЛКМ|r - открыть информационное окно."
Lockit.UI_COMPARTMENT_DESCRIPTION_RIGHT_CLICK = "|cnGREEN_FONT_COLOR:ПКМ|r - изменить параметры."

-- Настройки

Lockit.UI_SETTINGS_SECTION_TITLE_ACCOUNT = "Параметры аккаунта"
Lockit.UI_SETTING_DELVE_PROGRESS_WIDGETS_NAME = "Информация о прогрессе Вылазок"
Lockit.UI_SETTING_DELVE_PROGRESS_WIDGETS_TOOLTIP = "Список вылазок: Отображать прогресс достижений (истории и сундуки)."
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_NAME = "Тип отслеживания точек маршрута"
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_START = "Выберите, какой тип путевых точек используется для навигации.\n\nВозможные варианты:"
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_BLIZZARD = "- Отметка на карте Blizzard (стандартная внутриигровая навигация)"
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_TOMTOM = "- Точки маршрута TomTom"
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_MPE = "- Точки маршрута MapPinEnhanced."
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_TOMTOM_UNAVAILABLE_FORMAT = "%s (%s)."
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_BLIZZARD_NAME = "Blizzard"
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_BLIZZARD_DESCRIPTION = "Использовать отметки на карте Blizzard."
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_TOMTOM_NAME = "TomTom"
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_TOMTOM_DESCRIPTION = "Использовать точки маршрута TomTom."
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_MPE_NAME = "MapPinEnhanced"
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_MPE_DESCRIPTION = "Использовать точки маршрута MapPinEnhanced."

Lockit.UI_SETTINGS_SECTION_TITLE_CHARACTER = "Параметры персонажа"
Lockit.UI_SETTING_TOOLTIP_EXTENSION_NAME = "Дополнительная информация в подсказках"
Lockit.UI_SETTING_TOOLTIP_EXTENSION_TOOLTIP = "Отображение дополнительной информации во всплывающих подсказках (например, количество |cnITEM_EPIC_COLOR:Отреставрированных ключей от сундука|r, полученных на этой неделе)."
Lockit.UI_SETTING_COMPANION_CONFIG_NAME = "Виджет конфигурации Компаньона"
Lockit.UI_SETTING_COMPANION_CONFIG_TOOLTIP = "Интерфейс Вылазок: Включить виджет, отображающий текущую специализацию и способности Компаньона.\nЕго можно использовать для изменения конфигурации непосредственно из интерфейса Вылазок."
Lockit.UI_SETTING_COMPANION_CONFIG_OPTION_HORIZONTAL_NAME = "Горизонтальная расположение"
Lockit.UI_SETTING_COMPANION_CONFIG_OPTION_HORIZONTAL_DESCRIPTION = "Компактный макет с горизонтальным расположением кнопок. Модель Компаньона остаётся нетронутой."
Lockit.UI_SETTING_COMPANION_CONFIG_OPTION_VERTICAL_NAME = "Вертикальное расположение"
Lockit.UI_SETTING_COMPANION_CONFIG_OPTION_VERTICAL_DESCRIPTION = "Более подробный макет с вертикальным расположением кнопок. Модель Компаньона скрыта."
Lockit.UI_SETTING_GV_DETAILS_NAME = "Индивидуальное Великое Хранилище"
Lockit.UI_SETTING_GV_DETAILS_TOOLTIP = "Интерфейс Вылазок: Отображение наград и прогресса Великого Хранилища (актуально для Вылазок) непосредственно в интерфейсе Вылазок."
Lockit.UI_SETTING_DASHBOARD_OVERVIEW_NAME = "Раздел Вылазок"
Lockit.UI_SETTING_DASHBOARD_OVERVIEW_TOOLTIP = "Интерфейс Вылазок: Отображение дополнительного раздела 'Обзор'. Он содержит информацию о Позолоченных тайниках, доступных Многообещающих Вылазках, валютах, а также ​​предметах, которые связаны с Вылазками."

Lockit.UI_SETTINGS_TRANSLATION_TITLE = "Особая благодарность за помощь с переводом:"

Lockit.UI_SETTINGS_LINKS_TITLE = "Ссылки"
Lockit.UI_SETTINGS_ADDON_LINK_TOOLTIP_CURSEFORGE = "Нажмите, чтобы скопировать ссылку на страницу аддона |cnNORMAL_FONT_COLOR:CurseForge|r."
Lockit.UI_SETTINGS_ADDON_LINK_TOOLTIP_WAGO = "Нажмите, чтобы скопировать ссылку на страницу аддона |cnNORMAL_FONT_COLOR:Wago.io|r."
Lockit.UI_SETTINGS_ADDON_LINK_TOOLTIP_WOWINT = "Нажмите, чтобы скопировать ссылку на страницу аддона |cnNORMAL_FONT_COLOR:WoW Interface|r."
Lockit.UI_SETTINGS_ADDON_LINK_TOOLTIP_GITHUB = "Нажмите, чтобы скопировать ссылку на страницу аддона |cnNORMAL_FONT_COLOR:GitHub|r.\n\nПоделитесь отзывами, предложите новые функции или сообщите об ошибке. Это поможет сделать аддон еще лучше!"
Lockit.UI_SETTINGS_ADDON_LINK_POPUP_TEXT = "|cnGREEN_FONT_COLOR:Ctrl + C|r, чтобы скопировать |cnNORMAL_FONT_COLOR:%s|r ссылку." -- `%s`: название веб-сайта, например CurseForge.
