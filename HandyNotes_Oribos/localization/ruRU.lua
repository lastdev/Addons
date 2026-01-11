local L = LibStub("AceLocale-3.0"):NewLocale("HandyNotes_Oribos", "ruRU", false, true)

if not L then return end
-- Russian localization by Werloz ( https://www.curseforge.com/members/werloz ) and Hollicsh ( https://www.curseforge.com/members/hollicsh )
if L then
----------------------------------------------------------------------------------------------------
-----------------------------------------------CONFIG-----------------------------------------------
----------------------------------------------------------------------------------------------------

L["config_plugin_name"] = "Oribos"
L["config_plugin_desc"] = "Показывает на карте мира и миникарте расположение НИПов и достопримечательности в Орибосе."

L["config_tab_general"] = "Общие"
L["config_tab_scale_alpha"] = "Масштаб / прозрачность"
--L["config_scale_alpha_desc"] = "PH"
L["config_icon_scale"] = "Масштаб значков"
L["config_icon_scale_desc"] = "Изменяет размер значков"
L["config_icon_alpha"] = "Прозрачность значков"
L["config_icon_alpha_desc"] = "Изменяет прозрачность значков"
L["config_what_to_display"] = "Что отображать?"
L["config_what_to_display_desc"] = "Эти настройки определяют, какие типы значков будут отображаться."

L["config_auctioneer"] = "Аукционист"
L["config_auctioneer_desc"] = "Показать местонахождение аукциониста."

L["config_banker"] = "Банкир"
L["config_banker_desc"] = "Показать местонахождение банкира."

L["config_barber"] = "Парикмахер"
L["config_barber_desc"] = "Показать местонахождение парикмахера."

L["config_guildvault"] = "Хранилище гильдии"
L["config_guildvault_desc"] = "Показать расположение хранилища гильдии."

L["config_innkeeper"] = "Хозяин таверны"
L["config_innkeeper_desc"] = "Показать местонахождение хозяина таверны."

L["config_mail"] = "Почтовый ящик"
L["config_mail_desc"] = "Показать расположение почтовых ящиков."

L["config_portal"] = "Портал"
L["config_portal_desc"] = "Показать расположение портала."

L["config_portaltrainer"] = "Мастер порталов"
L["config_portaltrainer_desc"] = "Показать местонахождение мастера порталов."

L["config_tpplatform"] = "Платформа телепортации"
L["config_tpplatform_desc"] = "Показать расположение платформы телепортации."

L["config_travelguide_note"] = "|cFFFF0000*Уже активно в HandyNotes: TravelGuide.|r"

L["config_reforge"] = "Улучшение предметов"
L["config_reforge_desc"] = "Показать расположение улучшения предметов."

L["config_stablemaster"] = "Смотритель стойл"
L["config_stablemaster_desc"] = "Показать местонахождение смотрителя стойл."

L["config_trainer"] = "Учитель профессии"
L["config_trainer_desc"] = "Показать местонахождение учителя профессии."

L["config_transmogrifier"] = "Трансмогрификатор"
L["config_transmogrifier_desc"] = "Показать местонахождение трансмогрификатора."

L["config_vendor"] = "Торговцы"
L["config_vendor_desc"] = "Показать местонахождение торговцев."

L["config_zonegateway"] = "Переходы в зоны"
L["config_zonegateway_desc"] = "Показать расположение перехода в зону."

L["config_others"] = "Другие"
L["config_others_desc"] = "Показать все остальные достопримечательности."

L["config_onlymytrainers"] = "Показывать только учителей и торговцев моих профессий"
L["config_onlymytrainers_desc"] = [[
Действует только на учителей и торговцев основных профессий.

|cFFFF0000ПРИМЕЧАНИЕ: Действует только при изучении двух основных профессий.|r
]]

L["config_fmaster_waypoint"] = "Точка маршрута распорядителя полетов"
L["config_fmaster_waypoint_desc"] = "Автоматически устанавливает точку маршрута для распорядителя полетов, когда Вы входите в Кольцо Перенаправления."

L["config_easy_waypoints"] = "Упрощённые точки маршрута"
L["config_easy_waypoints_desc"] = "Активирует упрощённое создание точки маршрута.\nПозволяет установить точку маршрута, щелкнув ПКМ, и получить доступ к дополнительным параметрам, щелкнув ПКМ и удерживая клавишу CTRL."

L["config_waypoint_dropdown"] = "Выбор"
L["config_waypoint_dropdown_desc"] = "Выберите способ создания точки маршрута."
L["Blizzard"] = true
L["TomTom"] = true
L["Both"] = "Оба"

L["config_picons"] = "Показывать значки профессий для:"
L["config_picons_trainer_desc"] = "Показывать значки профессий вместо значков учителей."
L["config_picons_vendor_desc"] = "Показывать значки профессий вместо значков торговцев."
L["config_use_old_picons"] = "Использовать старые значки профессий"
L["config_use_old_picons_desc"] = "Показывать старые значки профессий вместо новых (которые появились с выходом Dragonflight)."

L["config_restore_nodes"] = "Восстановить скрытые значки"
L["config_restore_nodes_desc"] = "Восстановить все значки, которые были скрыты через контекстное меню."
L["config_restore_nodes_print"] = "Все скрытые значки были восстановлены"

----------------------------------------------------------------------------------------------------
-------------------------------------------------DEV------------------------------------------------
----------------------------------------------------------------------------------------------------

L["dev_config_tab"] = "РАЗРАБОТЧИКАМ"

L["dev_config_force_nodes"] = "Принудительно показать"
L["dev_config_force_nodes_desc"] = "Принудительное отображение всех значков независимо от класса, фракции или ковенанта."

L["dev_config_show_prints"] = "Показать print()"
L["dev_config_show_prints_desc"] = "Показывать сообщения print() в окне чата."

----------------------------------------------------------------------------------------------------
-----------------------------------------------HANDLER----------------------------------------------
----------------------------------------------------------------------------------------------------

--==========================================CONTEXT_MENU==========================================--

L["handler_context_menu_addon_name"] = "HandyNotes: Oribos"
L["handler_context_menu_add_tomtom"] = "Добавить в TomTom"
L["handler_context_menu_add_map_pin"] = "Установить точку маршрута на карте"
L["handler_context_menu_hide_node"] = "Скрыть этот значок"

--============================================TOOLTIPS============================================--

L["handler_tooltip_requires"] = "Требуется"
L["handler_tooltip_data"] = "ПОЛУЧЕНИЕ ДАННЫХ..."
L["handler_tooltip_quest"] = "Открывается с помощью задания"

----------------------------------------------------------------------------------------------------
----------------------------------------------DATABASE----------------------------------------------
----------------------------------------------------------------------------------------------------

L["Portal to Orgrimmar"] = "Портал в Оргриммар"
L["Portal to Stormwind"] = "Портал в Штормград"
L["To Ring of Transference"] = "В Кольцо Перенаправления"
L["To Ring of Fates"] = "В Кольцо Судеб"
L["Into the Maw"] = "В Утробу"
L["To Keeper's Respite"] = "В Приют Хранителя"
L["Portal to Zereth Mortis"] = "В Зерет Мортис"
L["Mailbox"] = "Почтовый ящик"

end
