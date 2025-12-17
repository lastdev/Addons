--[[
    Copyright (C) 2024 GurliGebis

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
]]

local addonName, _ = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "ruRU")
if not L then return end

L["%s wants to share a paste with you. Do you want to accept it?"] = "%s хочет поделиться с вами вставкой.|nВы хотите принять её?"
L["/pasteng config - Open the configuration"] = "/pasteng config - Открыть настройки"
L["/pasteng minimap - Toggle the minimap icon"] = "/pasteng minimap - Отобразить значок на миникарте"
L["/pasteng send Saved Paste name - Send a save paste to the default channel"] = "/pasteng send \\\"Имя сохранённой вставки\\\" - Отправить сохранённую вставку в канал по умолчанию"
L["/pasteng send Saved Paste name channel - Send a save paste to a specific channel"] = "/pasteng send \\\"Имя сохранённой вставки\\\" канал - Отправить сохранённую вставку в указанный канал"
L["/pasteng show - Show the pasteng dialog"] = "/pasteng show - Показать диалог PasteNG"
L["Battle.net friend not found."] = "Друг Battle.net не найден."
L["characters"] = "персонажи"
L["Clear"] = "Очистить"
L["Command-V"] = "Command-V"
L["Control-V"] = "Control-V"
L["Copy the export data below and save it to a file:"] = "Скопируйте указанные ниже данные экспорта и сохраните их в файл:"
L["Create a key binding to open the PasteNG window"] = "Создать привязку клавиши для открытия окна PasteNG"
L["Delete"] = "Удалить"
L["Disable announcements"] = "Отключить объявления"
L["Disable announcing presence to party/raid members when joining groups"] = "Отключить оповещение участников группы/рейда о своем присутствии при присоединении к группам"
L["Do you want to delete the %s paste?"] = "Вы хотите удалить вставку \"%s\"?"
L["Enable Minimap Icon"] = "Включить значок на миникарте"
L["Enable sharing with party / raid members"] = "Включить общий доступ для участников группы/рейда"
L["Export"] = "Экспорт"
L["Export Saved Pastes"] = "Экспорт сохраненных вставок"
L["Failed to import pastes:"] = "Не удалось импортировать вставки:"
L["General"] = "Общие"
L["General settings for PasteNG"] = "Общие настройки для PasteNG"
L["Import"] = "Импорт"
L["Left Click"] = "ЛКМ"
L["lines"] = "строк"
L["Load"] = "Загрузить"
L["No pastes to export"] = "Нет вставок для экспорта"
L["Open the PasteNG window"] = "Открыть окно PasteNG"
L["Paste"] = "Вставить"
L["Paste and Close"] = "Вставить и закрыть"
L["Paste the export data below to import pastes:"] = "Вставьте экспортные данные ниже, чтобы импортировать вставки:"
L["Paste to:"] = "Вставить в:"
L["PasteNG isn't compatible with the Paste addon (including the old PasteNG version). Please uninstall or delete the Paste addon folder."] = "PasteNG несовместим с аддоном Paste (включая старую версию PasteNG). Пожалуйста, удалите или деактивируйте папку аддона Paste."
L["PasteNG Usage:"] = "Использование PasteNG:"
L["Player %s does not have PasteNG. Whisper sent."] = "У игрока %s нет PasteNG. Шёпот отправлен."
L["Please enter import data"] = "Пожалуйста, введите данные импорта"
L["Please enter the name of your paste:"] = "Пожалуйста, введите имя вашей вставки:"
L["Please install or update the PasteNG addon to receive shared pastes."] = "Пожалуйста, установите или обновите аддон PasteNG, чтобы получать общие вставки."
L["Positions and coordinates"] = "Позиции и координаты"
L["Reset window size and position"] = "Сбросить размер и положение окна"
L["Resets the window size and position on screen to the default"] = "Сбрасывает размер и положение окна на экране до значений по умолчанию"
L["Right Click"] = "ПКМ"
L["Save"] = "Сохранить"
L["Select paste to delete"] = "Выберите вставку для удаления"
L["Select paste to load"] = "Выберите вставку для загрузки"
L["Select target to send to"] = "Выберите цель для отправки"
L["Send the paste with Shift-Enter"] = "Отправить вставку с помощью Shift-Enter"
L["Share"] = "Поделиться"
L["Sharing"] = "Поделиться"
L["Sharing with party / raid members"] = "Распространение среди участников группы/рейда"
L["Shift-Enter to Send"] = "Shift-Enter для отправки"
L["Successfully imported %d pastes"] = "Успешно импортировано %d вставок"
L["System paste shortcut"] = "ваш системный ярлык для вставки"
L["This will overwrite an existing saved paste, are you sure?"] = "Это перезапишет существующую сохранённую вставку, вы уверены?"
L["to open options"] = "для открытия настроек"
L["to show window"] = "для показа окна"
L["Toggle the minimap icon"] = "Отобразить значок на миникарте"
L["Unknown error"] = "Неизвестная ошибка"
L["Use %s to paste the clipboard into this box"] = "Используйте %s, чтобы вставить содержимое буфера обмена в это поле"
L["When in a group, allow sending and recieving pastes from group members"] = "Находясь в группе, разрешайте отправлять и получать сообщения от участников группы."
L["Window size and position has been reset."] = "Размер и положение окна сброшены."
L["Your PasteNG version is out of date! A newer version is available."] = "Ваша версия PasteNG устарела! Доступна более новая версия."
