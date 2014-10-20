-- Translations missing or inaccurate? Visit http://wow.curseforge.com/addons/fatality/localization/ to see if you can help!
if GetLocale() ~= "ruRU" then return end

local L = Fatality_Locales

-- Welcome Messages
L.welcome1 = "Спасибо за обновление до последней версии!"
L.welcome2 = "В дальнейшем для доступа к этому меню и отдельной настройки каждого персонажа наберите |cffff9900/fatality|r или |cffff9900/fat|r."
L.welcome3 = "|cffff0000[Note]|r Это сообщение будет отображено 1 раз для каждого персонажа."

-- Addon
L.addon_enabled = "|cff00ff00Выкл|r"
L.addon_disabled = "|cffff0000Вкл|r"

-- Damage
L.damage_overkill = "И: %s"
L.damage_resist = "С: %s"
L.damage_absorb = "П: %s"
L.damage_block = "Б: %s"

-- Error Messages
L.error_report = "(%s) Отчет не смог быть отправлен, т.к. его длина превышает 255 символов. Чтобы исправить это наберите |cffff9900/fatality|r и откорректируйте настройки соответствующим образом. Или Вы можете изменить канал для вывода информации на 'Себе'."
L.error_options = "|cffFF9933Fatality_Options|r не может быть загружено."

-- Configuration: Title
L.config_promoted = "Назначить"
L.config_lfr = "Поиск Рейда"
L.config_raid = "Рейд"
L.config_party = "Группа"
L.config_overkill = "Избыток"
L.config_resist = "Сопротивление"
L.config_absorb = "Поглощение"
L.config_block = "Блок"
L.config_icons = "Метки"
L.config_school = "Школы магии"
L.config_source = "Источник"
L.config_short = "Сокращенно"
L.config_limit10 = "Лимит сообщений (10 чел.)"
L.config_limit25 = "Лимит сообщений (25 чел.)"
L.config_history = "История событий"
L.config_threshold = "Минимальный урон"
L.config_output_raid = "Канал (Рейд)"
L.config_output_party = "Канал (Группа)"

-- Configuration: Description
L.config_promoted_desc = "Объявлять только если назначен ["..RAID_LEADER.."/"..RAID_ASSISTANT.."]"
L.config_lfr_desc = "Использовать при Поиске Рейда"
L.config_raid_desc = "Использовать в Рейде"
L.config_party_desc = "Использовать в Группе"
L.config_overkill_desc = "Включать избыточный урон"
L.config_resist_desc = "Включать \"сопротивленный\" урон"
L.config_absorb_desc = "Учитывать поглощенный урон"
L.config_block_desc = "Учитывать блокированный урон"
L.config_icons_desc = "Использовать метки рейда"
L.config_school_desc = "Включать урон различными школами магии"
L.config_source_desc = "Включать источник дамага"
L.config_short_desc = "Сокращенно [9431 = 9.4k]"
L.config_limit_desc = "О скольких смертях сообщать за бой?"
L.config_history_desc = "Сколько последних событий получения урона сообщать для персонажа?"
L.config_threshold_desc = "Какое минимальное значение урона следует сохранять?"
L.config_channel_default = "<Имя канала>"
L.config_whisper_default = "<Имя Персонажа>"