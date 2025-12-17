-- Russian Localization
if not HousingVendorLocales then
    HousingVendorLocales = {}
end

local L = {}

-- Main UI Strings
L["HOUSING_VENDOR_TITLE"] = "Расположение предметов декора жилища"
L["HOUSING_VENDOR_SUBTITLE"] = "Просмотр всех предметов декора жилища у продавцов по всей Азероту"

-- Filter Labels
L["FILTER_SEARCH"] = "Поиск:"
L["FILTER_EXPANSION"] = "Дополнение:"
L["FILTER_VENDOR"] = "Продавец:"
L["FILTER_ZONE"] = "Зона:"
L["FILTER_TYPE"] = "Тип:"
L["FILTER_CATEGORY"] = "Категория:"
L["FILTER_FACTION"] = "Фракция:"
L["FILTER_SOURCE"] = "Источник:"
L["FILTER_PROFESSION"] = "Профессия:"
L["FILTER_CLEAR"] = "Очистить фильтры"
L["FILTER_ALL_EXPANSIONS"] = "Все дополнения"
L["FILTER_ALL_VENDORS"] = "Все продавцы"
L["FILTER_ALL_ZONES"] = "Все зоны"
L["FILTER_ALL_TYPES"] = "Все типы"
L["FILTER_ALL_CATEGORIES"] = "Все категории"
L["FILTER_ALL_SOURCES"] = "Все источники"
L["FILTER_ALL_FACTIONS"] = "Все фракции"

-- Column Headers
L["COLUMN_ITEM"] = "Предмет"
L["COLUMN_ITEM_NAME"] = "Название предмета"
L["COLUMN_SOURCE"] = "Источник"
L["COLUMN_LOCATION"] = "Расположение"
L["COLUMN_PRICE"] = "Цена"
L["COLUMN_COST"] = "Стоимость"
L["COLUMN_VENDOR"] = "Продавец"
L["COLUMN_TYPE"] = "Тип"

-- Buttons
L["BUTTON_SETTINGS"] = "Настройки"
L["BUTTON_STATISTICS"] = "Статистика"
L["BUTTON_BACK"] = "Назад"
L["BUTTON_CLOSE"] = "Закрыть"
L["BUTTON_WAYPOINT"] = "Установить путевую точку"
L["BUTTON_SAVE"] = "Сохранить"
L["BUTTON_RESET"] = "Сброс"

-- Settings Panel
L["SETTINGS_TITLE"] = "Настройки аддона жилища"
L["SETTINGS_GENERAL_TAB"] = "Общие"
L["SETTINGS_COMMUNITY_TAB"] = "Сообщество"
L["SETTINGS_MINIMAP_SECTION"] = "Кнопка миникарты"
L["SETTINGS_SHOW_MINIMAP_BUTTON"] = "Показать кнопку миникарты"
L["SETTINGS_UI_SCALE_SECTION"] = "Масштаб интерфейса"
L["SETTINGS_UI_SCALE"] = "Масштаб интерфейса"
L["SETTINGS_FONT_SIZE"] = "Размер шрифта"
L["SETTINGS_RESET"] = "Сброс"
L["SETTINGS_RESET_DEFAULTS"] = "Сбросить на значения по умолчанию"
L["SETTINGS_PROGRESS_TRACKING"] = "Отслеживание прогресса"
L["SETTINGS_SHOW_COLLECTED"] = "Показать собранные предметы"
L["SETTINGS_WAYPOINT_NAVIGATION"] = "Навигация по путевым точкам"
L["SETTINGS_USE_PORTAL_NAVIGATION"] = "Использовать умную навигацию через порталы"

-- Tooltips
L["TOOLTIP_SETTINGS"] = "Настройки"
L["TOOLTIP_SETTINGS_DESC"] = "Настроить параметры аддона"
L["TOOLTIP_WAYPOINT"] = "Установить путевую точку"
L["TOOLTIP_WAYPOINT_DESC"] = "Перейти к этому продавцу"
L["TOOLTIP_PORTAL_NAVIGATION_ENABLED"] = "Умная навигация через порталы включена"
L["TOOLTIP_PORTAL_NAVIGATION_DESC"] = "Автоматически будет использовать ближайший портал при переходе между зонами"
L["TOOLTIP_DIRECT_NAVIGATION"] = "Прямая навигация включена"
L["TOOLTIP_DIRECT_NAVIGATION_DESC"] = "Путевые точки будут указывать прямо на местоположения продавцов (не рекомендуется для путешествий между зонами)"

-- Info Panel Tooltips
L["TOOLTIP_INFO_EXPANSION"] = "Дополнение World of Warcraft, из которого этот предмет"
L["TOOLTIP_INFO_FACTION"] = "Какая фракция может купить этот предмет у продавца"
L["TOOLTIP_INFO_VENDOR"] = "NPC-продавец, который продает этот предмет"
L["TOOLTIP_INFO_VENDOR_WITH_COORDS"] = "NPC-продавец, который продает этот предмет\n\nМестоположение: %s\nКоординаты: %s"
L["TOOLTIP_INFO_ZONE"] = "Зона, где находится этот продавец"
L["TOOLTIP_INFO_ZONE_WITH_COORDS"] = "Зона, где находится этот продавец\n\nКоординаты: %s"
L["TOOLTIP_INFO_REPUTATION"] = "Требование репутации для покупки этого предмета у продавца"
L["TOOLTIP_INFO_RENOWN"] = "Требуемый уровень известности с основной фракцией для разблокировки этого предмета"
L["TOOLTIP_INFO_PROFESSION"] = "Профессия, необходимая для создания этого предмета"
L["TOOLTIP_INFO_PROFESSION_SKILL"] = "Уровень навыка, необходимый в этой профессии для создания предмета"
L["TOOLTIP_INFO_PROFESSION_RECIPE"] = "Название рецепта или выкройки для создания этого предмета"
L["TOOLTIP_INFO_EVENT"] = "Особое событие или праздник, когда этот предмет доступен"
L["TOOLTIP_INFO_CLASS"] = "Этот предмет может использовать только этот класс"
L["TOOLTIP_INFO_RACE"] = "Этот предмет может использовать только эта раса"

-- Messages
L["MESSAGE_PORTAL_NAV_ENABLED"] = "Умная навигация через порталы включена. Путевые точки будут автоматически использовать ближайший портал при переходе между зонами."
L["MESSAGE_DIRECT_NAV_ENABLED"] = "Прямая навигация включена. Путевые точки будут указывать прямо на местоположения продавцов (не рекомендуется для путешествий между зонами)."

-- Community Section
L["COMMUNITY_TITLE"] = "Сообщество и поддержка"
L["COMMUNITY_INFO"] = "Присоединяйтесь к нашему сообществу, чтобы делиться советами, сообщать об ошибках и предлагать новые функции!"
L["COMMUNITY_DISCORD"] = "Сервер Discord"
L["COMMUNITY_GITHUB"] = "GitHub"
L["COMMUNITY_REPORT_BUG"] = "Сообщить об ошибке"
L["COMMUNITY_SUGGEST_FEATURE"] = "Предложить функцию"

-- Preview Panel
L["PREVIEW_TITLE"] = "Предварительный просмотр предмета"
L["PREVIEW_NO_SELECTION"] = "Выберите предмет для просмотра деталей"

-- Status Bar
L["STATUS_ITEMS_DISPLAYED"] = "%d предметов отображается (%d всего)"

-- Errors
L["ERROR_ADDON_NOT_INITIALIZED"] = "Аддон жилища не инициализирован"
L["ERROR_UI_NOT_AVAILABLE"] = "Пользовательский интерфейс HousingVendor недоступен"
L["ERROR_CONFIG_PANEL_NOT_AVAILABLE"] = "Панель конфигурации недоступна"

-- Statistics UI
L["STATS_TITLE"] = "Панель статистики"
L["STATS_COLLECTION_PROGRESS"] = "Прогресс коллекции"
L["STATS_ITEMS_BY_SOURCE"] = "Предметы по источнику"
L["STATS_ITEMS_BY_FACTION"] = "Предметы по фракции"
L["STATS_COLLECTION_BY_EXPANSION"] = "Коллекция по дополнению"
L["STATS_COLLECTION_BY_CATEGORY"] = "Коллекция по категории"
L["STATS_COMPLETE"] = "%d%% Завершено - %d / %d предметов собрано"

-- Footer
L["FOOTER_COLOR_GUIDE"] = "Цветовая схема:"
L["FOOTER_WAYPOINT_INSTRUCTION"] = "Нажмите на предмет с %s, чтобы установить путевую точку"

-- Main UI
L["MAIN_SUBTITLE"] = "Каталог жилища"

-- Common Strings
L["COMMON_FREE"] = "Бесплатно"
L["COMMON_UNKNOWN"] = "Неизвестно"
L["COMMON_NA"] = "Н/Д"
L["COMMON_GOLD"] = "золото"
L["COMMON_ITEM_ID"] = "ID предмета:"

-- Miscellaneous
L["MINIMAP_TOOLTIP"] = "Браузер продавцов жилища"
L["MINIMAP_TOOLTIP_DESC"] = "Левый клик для переключения браузера продавцов жилища"

-- Expansion Names
L["EXPANSION_CLASSIC"] = "Классическая"
L["EXPANSION_THEBURNINGCRUSADE"] = "The Burning Crusade"
L["EXPANSION_WRATHOFTHELLICHKING"] = "Wrath of the Lich King"
L["EXPANSION_CATACLYSM"] = "Cataclysm"
L["EXPANSION_MISTSOFPANDARIA"] = "Mists of Pandaria"
L["EXPANSION_WARLORDSOF DRAENOR"] = "Warlords of Draenor"
L["EXPANSION_LEGION"] = "Legion"
L["EXPANSION_BATTLEFORAZEROTH"] = "Battle for Azeroth"
L["EXPANSION_SHADOWLANDS"] = "Shadowlands"
L["EXPANSION_DRAGONFLIGHT"] = "Dragonflight"
L["EXPANSION_THEWARWITHIN"] = "The War Within"
L["EXPANSION_MIDNIGHT"] = "Полуночь"

-- Faction Names
L["FACTION_ALLIANCE"] = "Альянс"
L["FACTION_HORDE"] = "Орда"
L["FACTION_NEUTRAL"] = "Нейтральный"

-- Source Types
L["SOURCE_VENDOR"] = "Продавец"
L["SOURCE_ACHIEVEMENT"] = "Достижение"
L["SOURCE_QUEST"] = "Задание"
L["SOURCE_DROP"] = "Добыча"
L["SOURCE_PROFESSION"] = "Профессия"
L["SOURCE_REPUTATION"] = "Репутация"

-- Quality Names
L["QUALITY_POOR"] = "Низкое"
L["QUALITY_COMMON"] = "Обычное"
L["QUALITY_UNCOMMON"] = "Необычное"
L["QUALITY_RARE"] = "Редкое"
L["QUALITY_EPIC"] = "Эпическое"
L["QUALITY_LEGENDARY"] = "Легендарное"

-- Collection Status
L["COLLECTION_COLLECTED"] = "Собрано"
L["COLLECTION_UNCOLLECTED"] = "Не собрано"

-- Requirement Types
L["REQUIREMENT_NONE"] = "Нет"
L["REQUIREMENT_ACHIEVEMENT"] = "Достижение"
L["REQUIREMENT_QUEST"] = "Задание"
L["REQUIREMENT_REPUTATION"] = "Репутация"
L["REQUIREMENT_RENOWN"] = "Слава"
L["REQUIREMENT_PROFESSION"] = "Профессия"

-- Common Category/Type Names
L["CATEGORY_FURNITURE"] = "Мебель"
L["CATEGORY_DECORATIONS"] = "Украшения"
L["CATEGORY_LIGHTING"] = "Освещение"
L["CATEGORY_PLACEABLES"] = "Размещаемые"
L["CATEGORY_ACCESSORIES"] = "Аксессуары"
L["CATEGORY_RUGS"] = "Ковры"
L["CATEGORY_PLANTS"] = "Растения"
L["CATEGORY_PAINTINGS"] = "Картины"
L["CATEGORY_BANNERS"] = "Знамена"
L["CATEGORY_BOOKS"] = "Книги"
L["CATEGORY_FOOD"] = "Еда"
L["CATEGORY_TOYS"] = "Игрушки"

-- Type Names
L["TYPE_CHAIR"] = "Стул"
L["TYPE_TABLE"] = "Стол"
L["TYPE_BED"] = "Кровать"
L["TYPE_LAMP"] = "Лампа"
L["TYPE_CANDLE"] = "Свеча"
L["TYPE_RUG"] = "Ковер"
L["TYPE_PAINTING"] = "Картина"
L["TYPE_BANNER"] = "Знамя"
L["TYPE_PLANT"] = "Растение"
L["TYPE_BOOKSHELF"] = "Книжная полка"
L["TYPE_CHEST"] = "Сундук"
L["TYPE_WEAPON_RACK"] = "Стойка для оружия"

-- Filter Options
L["FILTER_HIDE_VISITED"] = "Скрыть посещенные"
L["FILTER_ALL_QUALITIES"] = "Все качества"
L["FILTER_ALL_REQUIREMENTS"] = "Все требования"

-- UI Theme Names
L["THEME_MIDNIGHT"] = "Полуночь"
L["THEME_ALLIANCE"] = "Альянс"
L["THEME_HORDE"] = "Орда"
L["THEME_SLEEK_BLACK"] = "Черный элегантный"
L["SETTINGS_UI_THEME"] = "Тема интерфейса"

-- Make the locale table globally available
HousingVendorLocales["ruRU"] = L