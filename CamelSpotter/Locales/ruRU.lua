if (GAME_LOCALE or GetLocale()) ~= "ruRU" then
    return
end

local addOn = select(2,...)
local L = addOn.L

L["[Click Here]"] = "[Нажмите здесь]"
L["[Set Closest Waypoint when needed]"] = "[Установить ближайшую точку маршрута при необходимости]"
L["Add TomTom Waypoints - /cs way"] = "Добавить точки маршрута в TomTom - /cs way"
L["Automatically take a screenshot disabled."] = "Автоматический снимок экрана выключен."
L["Automatically take a screenshot enabled."] = "Автоматический снимок экрана включен."
L["Export History as CSV - /cs export"] = "Экспортировать статистику в формате CSV - /cs export"
L["Fake Camel Figurine"] = "Фальшивая фигурка верблюда"
L["Figurine has been up for"] = "Время жизни фигурки"
L["for TomTom waypoints."] = "для создания точек маршрута в TomTom."
L["Friendly nameplates have been activated for this zone."] = "Включено отображение индикаторов здоровья союзников в этой зоне."
L["Left-click to drag and move."] = "Удерживайте левой кнопкой мышки для перемещения."
L["Mysterious Camel Figurine"] = "Странная Фигурка Верблюда"
L["Mysterious Camel Figurine last seen:"] = "Прошло времени после последнего обнаружения фигурки:"
L["Real Camel Figurine"] = "Настоящая фигурка верблюда"
L["Right-click to close."] = "Щелкните правой кнопкой мышки чтобы закрыть окно."
L["Toggle Auto Screenshot - /cs screenshot (Default: Disabled)"] = "Включить автоматический снимок экрана - /cs screenshot (По умолчанию: Выключено)"
L["Waypoints added to"] = "Добавлены точки маршрута на карту"
L["You need TomTom for this feature."] = "Необходимо установить аддон TomTom или аналог"
