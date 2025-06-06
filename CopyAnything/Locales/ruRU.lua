local L = LibStub("AceLocale-3.0"):NewLocale("CopyAnything", "ruRU")
if not L then return end

L["copyAnything"] = "Копировать всё"
L["copyFrame"] = "Копировать фрейм"
L["fastCopy"] = "Быстрое копирование"
L["fastCopyDesc"] = "Автоматически скрывать фрейм копирования после нажатия CTRL+C."
L["fontStrings"] = "Строки шрифта"
L["general"] = "Общие"
L["invalidSearchType"] = "Неверный тип поиска '%s'. Проверьте настройки."
L["mouseFocus"] = "Фокус мыши"
L["noTextFound"] = "Текст не найден."
L["parentFrames"] = "Родительские фреймы"
L["profiles"] = "Профили"
L["searchType"] = "Тип поиска"
L["searchTypeDesc"] = "Метод поиска фреймов под курсором."
L["searchTypeDescExtended"] = [=[Строки шрифта (по умолчанию) - Поиск отдельных строк шрифта под курсором.
Родительские фреймы - Поиск верхнеуровневых фреймов под курсором и копирование всего текста из их дочерних элементов.
Фокус мыши - Копирование текста из фрейма, находящегося в фокусе мыши. Работает только с фреймами, зарегистрированными для событий мыши.]=]
L["show"] = "Показать"
L["tooManyFontStrings"] = "Найдено более %d строк шрифта. Копирование отменено, чтобы предотвратить зависание игры на длительное время."

