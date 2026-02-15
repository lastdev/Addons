local ADDON_NAME, DTH = ...;

local L = {
    enUS = {
        -- Options
        AUTO_ACCEPT = "Auto-Accept Quest",
        AUTO_TURNIN = "Auto Turn-In Quest",
        TOOLTIP_TEXT = "Click to configure auto-accept and auto turn-in settings",
        AUTO_ACCEPT_ENABLED = "Auto-Accept has been |cnGREEN_FONT_COLOR:enabled|r.",
        AUTO_ACCEPT_DISABLED = "Auto-Accept has been |cnRED_FONT_COLOR:disabled|r.",
        AUTO_TURNIN_ENABLED = "Auto Turn-In has been |cnGREEN_FONT_COLOR:enabled|r.",
        AUTO_TURNIN_DISABLED = "Auto Turn-In has been |cnRED_FONT_COLOR:disabled|r.",

        -- Main Addon
        QUEST_ACCEPTED = "Quest automatically accepted.",
        QUEST_TURNIN = "Quest automatically turned in.",
        QUEST_PROGRESS = "You have now completed |cnNORMAL_FONT_COLOR:%d|r of |cnNORMAL_FONT_COLOR:%d|r quests on |cnNORMAL_FONT_COLOR:%s|r.",
        WAYPOINT_SET = "Waypoint set to treasure location.",
    },

    deDE = {
        -- Options
        AUTO_ACCEPT = "Quest automatisch annehmen",
        AUTO_TURNIN = "Quest automatisch abgeben",
        TOOLTIP_TEXT = "Klicken um automatisches Annehmen und Abgeben zu konfigurieren",
        AUTO_ACCEPT_ENABLED = "Automatisches Annehmen wurde |cnGREEN_FONT_COLOR:aktiviert|r.",
        AUTO_ACCEPT_DISABLED = "Automatisches Annehmen wurde |cnRED_FONT_COLOR:deaktiviert|r.",
        AUTO_TURNIN_ENABLED = "Automatisches Abgeben wurde |cnGREEN_FONT_COLOR:aktiviert|r.",
        AUTO_TURNIN_DISABLED = "Automatisches Abgeben wurde |cnRED_FONT_COLOR:deaktiviert|r.",

        -- Main Addon
        QUEST_ACCEPTED = "Quest automatisch angenommen.",
        QUEST_TURNIN = "Quest automatisch abgegeben.",
        QUEST_PROGRESS = "Du hast nun |cnNORMAL_FONT_COLOR:%d|r von |cnNORMAL_FONT_COLOR:%d|r Quests auf |cnNORMAL_FONT_COLOR:%s|r abgeschlossen.",
        WAYPOINT_SET = "Wegpunkt zum Schatzfundort gesetzt.",
    },

    esES = {
        -- Opciones
        AUTO_ACCEPT = "Aceptar misión automáticamente",
        AUTO_TURNIN = "Entregar misión automáticamente",
        TOOLTIP_TEXT = "Haz clic para configurar la aceptación y entrega automática de misiones",
        AUTO_ACCEPT_ENABLED = "La aceptación automática ha sido |cnGREEN_FONT_COLOR:activada|r.",
        AUTO_ACCEPT_DISABLED = "La aceptación automática ha sido |cnRED_FONT_COLOR:desactivada|r.",
        AUTO_TURNIN_ENABLED = "La entrega automática ha sido |cnGREEN_FONT_COLOR:activada|r.",
        AUTO_TURNIN_DISABLED = "La entrega automática ha sido |cnRED_FONT_COLOR:desactivada|r.",

        -- Addon principal
        QUEST_ACCEPTED = "Misión aceptada automáticamente.",
        QUEST_TURNIN = "Misión entregada automáticamente.",
        QUEST_PROGRESS = "Has completado |cnNORMAL_FONT_COLOR:%d|r de |cnNORMAL_FONT_COLOR:%d|r misiones en |cnNORMAL_FONT_COLOR:%s|r.",
        WAYPOINT_SET = "Punto de ruta establecido en la ubicación del tesoro.",
    },

    zhCN = {
        -- Options
        AUTO_ACCEPT = "自动接受任务",
        AUTO_TURNIN = "自动完成任务",
        TOOLTIP_TEXT = "点击设置自动接受与自动完成任务",
        AUTO_ACCEPT_ENABLED = "自动接受任务已 |cnGREEN_FONT_COLOR：启用|r。",
        AUTO_ACCEPT_DISABLED = "自动接受任务已 |cnRED_FONT_COLOR：禁用|r。",
        AUTO_TURNIN_ENABLED = "自动完成任务已 |cnGREEN_FONT_COLOR：启用|r。",
        AUTO_TURNIN_DISABLED = "自动完成任务已 |cnRED_FONT_COLOR：禁用|r。",

        -- Main Addon
        QUEST_ACCEPTED = "已自动接受任务。",
        QUEST_TURNIN = "已自动完成任务。",
        QUEST_PROGRESS = "目前已完成任务：|cnNORMAL_FONT_COLOR:%d|r/|cnNORMAL_FONT_COLOR:%d|r，宝藏位置：|cnNORMAL_FONT_COLOR:%s|r。",
        WAYPOINT_SET = "已地图标记宝藏位置。",
    },

    ruRU = {
        -- Options
        -- Translation ZamestoTV
        AUTO_ACCEPT = "Автопринятие заданий",
        AUTO_TURNIN = "Автосдача заданий",
        TOOLTIP_TEXT = "Кликните, чтобы настроить автопринятие и автосдачу заданий",
        AUTO_ACCEPT_ENABLED = "Автопринятие заданий |cnGREEN_FONT_COLOR:включено|r.",
        AUTO_ACCEPT_DISABLED = "Автопринятие заданий |cnRED_FONT_COLOR:отключено|r.",
        AUTO_TURNIN_ENABLED = "Автосдача заданий |cnGREEN_FONT_COLOR:включена|r.",
        AUTO_TURNIN_DISABLED = "Автосдача заданий |cnRED_FONT_COLOR:отключена|r.",

        -- Main Addon
        QUEST_ACCEPTED = "Задание автоматически принято.",
        QUEST_TURNIN = "Задание автоматически сдано.",
        QUEST_PROGRESS = "Вы выполнили |cnNORMAL_FONT_COLOR:%d|r из |cnNORMAL_FONT_COLOR:%d|r заданий на |cnNORMAL_FONT_COLOR:%s|r.",
        WAYPOINT_SET = "Путевая точка установлена к месту сокровища.",
    }
};

DTH.L = L[GetLocale()] or L["enUS"];
