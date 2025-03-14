﻿-------------------------------------------------------------------------------
-- Russian localization by Dr. Jet Cheshirsky (don't  blame me for lame OFFICIAL translations though =~_^=)
-------------------------------------------------------------------------------

if (GetLocale() == "ruRU") then

-- credits
SMARTBUFF_CREDITS = "|cffffffff"
  .."Версия Shadowlands от Codermik. Пожалуйста, сообщайте о любых проблемах на CurseForge или в моем разногласии по адресу:\n\n"
  .."|cff00e0ffhttps://discord.gg/R6EkZ94TKK\n\n"
  .."|cffffffffЕсли вы цените объем проделанной работы и время, затраченное на создание этих различных дополнений, пожалуйста, поддержите меня:\n\n"
  .."|cffffffffTwitch: |cff00e0ffhttps://www.twitch.tv/codermik\n"
  .."|cffffffffPayPal.Me: |cff00e0ffhttps://paypal.me/codermik\n\n"
;

-- Weapon types
SMARTBUFF_WEAPON_STANDARD = {"Кинжалы", "топоры", "мечи", "дробящее", "Посохи", "Кистевое", "Древковое", "Метательное", "Щит"};
SMARTBUFF_WEAPON_BLUNT = {"дробящее", "Посохи", "Кистевое"};
SMARTBUFF_WEAPON_BLUNT_PATTERN = "грузик$";
SMARTBUFF_WEAPON_SHARP = {"Кинжалы", "топоры", "мечи", "Древковое"};
SMARTBUFF_WEAPON_SHARP_PATTERN = "точило$";

-- Creature type
SMARTBUFF_HUMANOID  = "Гуманоид";
SMARTBUFF_DEMON     = "Демон";
SMARTBUFF_BEAST     = "Животное";
SMARTBUFF_ELEMENTAL = "Дух стихии";
SMARTBUFF_DEMONTYPE = "Бес";
SMARTBUFF_UNDEAD    = "Undead";

-- Classes
SMARTBUFF_CLASSES = {"Друид", "Охотник", "Маг", "Паладин", "Жрец", "Разбойник", "Шаман", "Чернокнижник", "Воин", "Рыцарь смерти", "Монах", "Охотник на демонов", "Эвокер", "Питомец Охотника", "Прислужник Чернокнижника", "DK Pet", "танка", "целителя", "Бойцы"};

-- Templates and Instances
SMARTBUFF_TEMPLATES = {"Соло", "Группа", "Рейд", "Поле битвы", "Арена", "ЦЛК", "Ик", "Ульдуар", "ОБ", "Оня", "ЛКТ", "Накс", "АК", "ЗГ", "Своё 1", "Своё 2", "Своё 3", "Своё 4", "Своё 5"};
SMARTBUFF_INSTANCES = {"Цитадель Ледяной Короны", "Испытание крестоносца", "Ульдуар", "Огненная Бездна", "Логово Ониксии", "Логово Крыла Тьмы", "Наксрамас", "Ан'Кираж", "Зул'Гуруб"};

-- Mount
SMARTBUFF_MOUNT = "Увеличивает скорость на (%d+)%%.";

-- Bindings
BINDING_NAME_SMARTBUFF_BIND_TRIGGER = "Триггер";
BINDING_NAME_SMARTBUFF_BIND_TARGET  = "Цель";
BINDING_NAME_SMARTBUFF_BIND_OPTIONS = "Меню опций";
BINDING_NAME_SMARTBUFF_BIND_RESETBUFFTIMERS = "Сбросить таймеры баффов";

-- Options Frame Text

-- experimental feature - for testing.
SMARTBUFF_OFT_FIXBUFF        = "Исправить кастинг"
SMARTBUFF_OFTT_FIXBUFF       = "Отметьте, если применение баффа не удается."

SMARTBUFF_OFT                = "Вкл/Выкл";
SMARTBUFF_OFT_MENU           = "Меню опций";
SMARTBUFF_OFT_AUTO           = "Напоминалка";
SMARTBUFF_OFT_AUTOTIMER      = "Проверка таймера";
SMARTBUFF_OFT_AUTOCOMBAT     = "в бою";
SMARTBUFF_OFT_AUTOCHAT       = "Чат";
SMARTBUFF_OFT_AUTOSPLASH     = "Всплеск";
SMARTBUFF_OFT_AUTOSOUND      = "Звук";
SMARTBUFF_OFT_AUTOREST       = "Запретить в городе";
SMARTBUFF_OFT_HUNTERPETS     = "Баффать питомцев охотника";
SMARTBUFF_OFT_WARLOCKPETS    = "Баффать питомцев чернокнижника";
SMARTBUFF_OFT_ARULES         = "Расширенные правила";
SMARTBUFF_OFT_GRP            = "Баффать подгруппы рейда";
SMARTBUFF_OFT_SUBGRPCHANGED  = "Открыть меню опций";
SMARTBUFF_OFT_BUFFS          = "Баффы/Умения";
SMARTBUFF_OFT_TARGET         = "Баффать выбраную цель";
SMARTBUFF_OFT_DONE           = "Готово";
SMARTBUFF_OFT_APPLY          = "Применить";
SMARTBUFF_OFT_GRPBUFFSIZE    = "Без групбаффа";
SMARTBUFF_OFT_CLASSBUFFSIZE  = "Без групбаффа";
SMARTBUFF_OFT_MESSAGES       = "Запретить сообщения";
SMARTBUFF_OFT_MSGNORMAL      = "обычные";
SMARTBUFF_OFT_MSGWARNING     = "предупреждения";
SMARTBUFF_OFT_MSGERROR       = "ошибки";
SMARTBUFF_OFT_HIDEMMBUTTON   = "Спрятать кнопку у карты";
SMARTBUFF_OFT_INCLUDETOYS    = "Включить игрушки";
SMARTBUFF_OFT_REBUFFTIMER    = "Таймер ребаффа";
SMARTBUFF_OFT_AUTOSWITCHTMP  = "Менять настройки";
SMARTBUFF_OFT_SELFFIRST      = "Сначала себя";
SMARTBUFF_OFT_SCROLLWHEELUP  = "Баффать по колесу вверх";
SMARTBUFF_OFT_SCROLLWHEELDOWN= "вниз";
SMARTBUFF_OFT_TARGETSWITCH   = "смена цели";
SMARTBUFF_OFT_BUFFTARGET     = "Баффать цель";
SMARTBUFF_OFT_BUFFPVP        = "Баффать в PvP";
SMARTBUFF_OFT_AUTOSWITCHTMPINST = "Подземелья";
SMARTBUFF_OFT_CHECKCHARGES   = "Проверять заряды";
SMARTBUFF_OFT_RBT            = "Сброс БТ";
SMARTBUFF_OFT_BUFFINCITIES   = "Баффать в городе";
SMARTBUFF_OFT_UISYNC         = "Синхронизация UI";
SMARTBUFF_OFT_BLDURATION     = "Ч.список";
SMARTBUFF_OFT_COMPMODE       = "Комп.режим";
SMARTBUFF_OFT_MINIGRP        = "Мини-группа";
SMARTBUFF_OFT_ANTIDAZE       = "Анти-стоп";
SMARTBUFF_OFT_HIDESABUTTON   = "Спрятать кнопку действия";
SMARTBUFF_OFT_INCOMBAT       = "в бою";
SMARTBUFF_OFT_SMARTDEBUFF    = "SmartDebuff";
SMARTBUFF_OFT_INSHAPESHIFT   = "Shapeshift";
SMARTBUFF_OFT_LINKGRPBUFFCHECK  = "Grp link";
SMARTBUFF_OFT_LINKSELFBUFFCHECK = "Self link";
SMARTBUFF_OFT_RESETALL       = "Reset All";
SMARTBUFF_OFT_RESETLIST      = "Reset List";
SMARTBUFF_OFT_RESETBUFFS     = "Reset Buffs";
SMARTBUFF_OFT_PURGE_BUFFS    = "New Version, reset ALL SmartBuff buff data?\nThis will reset all buff profiles!";
SMARTBUFF_OFT_YES            = "Да";
SMARTBUFF_OFT_NO             = "Нет";
SMARTBUFF_OFT_OKAY           = "Продолжать"
SMARTBUFF_OFT_PURGE_DATA     = "Вы уверены, что хотите сбросить ВСЕ данные SmartBuff?\nЭто действие приведет к перезагрузке пользовательского интерфейса!";
SMARTBUFF_OFT_REQ_RELOAD     = "Новые версии требуют перезагрузки графического интерфейса.\nНажмите «Продолжить», когда будете готовы.";

-- Options Frame Tooltip Text
SMARTBUFF_OFTT               = "Включает-выключает SmartBuff.";
SMARTBUFF_OFTT_AUTO          = "Включает-выключает напоминалку.";
SMARTBUFF_OFTT_AUTOTIMER     = "Задержка в секундах между двумя проверками.";
SMARTBUFF_OFTT_AUTOCOMBAT    = "Запускать провеку во время боя.";
SMARTBUFF_OFTT_AUTOCHAT      = "Показывать недостающие баффы в чате.";
SMARTBUFF_OFTT_AUTOSPLASH    = "Показывать недостающие баффы всплывающим сообщением в центре экрана.";
SMARTBUFF_OFTT_AUTOSOUND     = "Проигрывать звук при отсутствии нужных баффов.";
SMARTBUFF_OFTT_AUTOREST      = "Запретить напоминалку при нахождении в городе.";
SMARTBUFF_OFTT_HUNTERPETS    = "Баффать питомцев Охотника наравне с прочими.";
SMARTBUFF_OFTT_WARLOCKPETS   = "Баффать питомцев Чернокнижника, за исключением " .. SMARTBUFF_DEMONTYPE .. ".";
SMARTBUFF_OFTT_ARULES        = "Не кастовать:\n- Шипы на Магов, Жрецов и Чернокнижников\n- Чародейский интеллект на тех, у кого нет маны\n- Божественный дух на тех, у кого нет маны";
SMARTBUFF_OFTT_SUBGRPCHANGED = "Автоматически открывать меню опций SmartBuff,\nкогда вы меняете подгруппу.";
SMARTBUFF_OFTT_GRPBUFFSIZE   = "Сколько игроков без группового баффа должно\nбыть в группе, чтобы кастовать групповой бафф.";
SMARTBUFF_OFTT_HIDEMMBUTTON  = "Спрятать кнопку SmartBuff рядом с мини-картой.";
SMARTBUFF_OFTT_INCLUDETOYS   = "Включите в список игрушки вместе с вашими заклинаниями и едой.";
SMARTBUFF_OFTT_REBUFFTIMER   = "За сколько секунд до спадения баффа,\nнапоминака должна предупреждать.\n0 = Отключить";
SMARTBUFF_OFTT_SELFFIRST     = "Баффать сначала себя, потом других.";
SMARTBUFF_OFTT_SCROLLWHEELUP = "Баффать, когда вы прокручиваете\nколесо мыши вперёд.";
SMARTBUFF_OFTT_SCROLLWHEELDOWN = "Баффать, когда вы прокручиваете\nколесо мыши назад.";
SMARTBUFF_OFTT_TARGETSWITCH  = "Баффать при смене цели.";
SMARTBUFF_OFTT_BUFFTARGET    = "Сначала баффать цель,\nесли она дружественная.";
SMARTBUFF_OFTT_BUFFPVP       = "Баффать игроков с PvP флагом,\nдаже если на вас нет PvP флага.";
SMARTBUFF_OFTT_AUTOSWITCHTMP = "Автоматически менять набор настроек,\nесли меняется тип группы.";
SMARTBUFF_OFTT_AUTOSWITCHTMPINST = "Автоматически менять набор настроек,\nесли меняется подземелье.";
SMARTBUFF_OFTT_CHECKCHARGES  = "Показывать нехватку зарядов баффа\nпри падении ниже этого числа.\n0 = Отключить";
SMARTBUFF_OFTT_BUFFINCITIES  = "Баффать даже при нахождении в городе.\nЕсли на вас PvP флаг, баффает в любом случае.";
SMARTBUFF_OFTT_UISYNC        = "Активировать синхронизацию с UI\nчтобы получать оставшееся время баффов\nот других игроков.";
SMARTBUFF_OFTT_BLDURATION    = "Сколько секунд игрок держится в чёрном списке.\n0 = Отключить";
SMARTBUFF_OFTT_COMPMODE      = "Режим совместимости.\nВнимание!!!\nИспользуйте этот режим только если\nу вас проблемы с обкастом себя самого.";
SMARTBUFF_OFTT_MINIGRP       = "Показывать выбор подгрупп рейда\nв отдельной маленькой рамке.";
SMARTBUFF_OFTT_ANTIDAZE      = "Автоматически прерывать\nДух Гепарда/Стаи\nесли на ком-то из группы\nповисло замедление.";
SMARTBUFF_OFTT_SPLASHSTYLE   = "Изменить шрифт сообщений о баффах.";
SMARTBUFF_OFTT_HIDESABUTTON  = "Спрятать кнопку действия SmartBuff.";
SMARTBUFF_OFTT_INCOMBAT      = "At the moment it only works on yourself.\nThe first buff you mark as in combat,\nwill set on the button before combat\nand you can use it in combat.\nWarning! All logic is disabled in combat!";
SMARTBUFF_OFTT_SMARTDEBUFF   = "Shows the SmartDebuff frame.";
SMARTBUFF_OFTT_SPLASHDURATION= "Сколько секунд будут отображаться\nвсплывающие сообщения.";
SMARTBUFF_OFTT_INSHAPESHIFT  = "Cast buffs also if you\nare shapeshifted.";
SMARTBUFF_OFTT_LINKGRPBUFFCHECK  = "Checks if a buff of an other\nclass with similar effect\nis already active.";
SMARTBUFF_OFTT_LINKSELFBUFFCHECK = "Checks if a self buff is active,\nwhose only one can be\nactive at a time.";
SMARTBUFF_OFTT_SOUNDSELECT   = "Выберите звук всплеска.";


-- Buffsetup Frame Text
SMARTBUFF_BST_SELFONLY       = "Только себя";
SMARTBUFF_BST_SELFNOT        = "Кроме себя";
SMARTBUFF_BST_COMBATIN       = "В бою";
SMARTBUFF_BST_COMBATOUT      = "Вне боя";
SMARTBUFF_BST_MAINHAND       = "Правая рука";
SMARTBUFF_BST_OFFHAND        = "Левая рука";
SMARTBUFF_BST_RANGED         = "Метательное";
SMARTBUFF_BST_REMINDER       = "Напоминалка";
SMARTBUFF_BST_MANALIMIT      = "При уровне\nманы не ниже";

-- Buffsetup Frame Tooltip Text
SMARTBUFF_BSTT_SELFONLY      = "Баффать только себя любимого.";
SMARTBUFF_BSTT_SELFNOT       = "Баффать все выбранные классы,\nкроме себя самого.";
SMARTBUFF_BSTT_COMBATIN      = "Баффать если вы в бою.";
SMARTBUFF_BSTT_COMBATOUT     = "Баффать если вы не в бою.";
SMARTBUFF_BSTT_MAINHAND      = "Бафф на оружие правой руки.";
SMARTBUFF_BSTT_OFFHAND       = "Бафф на оружие левой руки.";
SMARTBUFF_BSTT_RANGED        = "Buffs the ranged slot.";
SMARTBUFF_BSTT_REMINDER      = "Показывать окошко напоминалки.";
SMARTBUFF_BSTT_REBUFFTIMER   = "За сколько секунд до спадения баффа,\nнапоминалка должна предупредить.\n0 = общий таймер проверки";
SMARTBUFF_BSTT_MANALIMIT     = "Уровень Маны/Ярости/Энергии. \nЕсли он окажется ниже,\nто баффа не будет.";

-- Playersetup Frame Tooltip Text
SMARTBUFF_PSTT_RESIZE        = "Свернуть/развернуть\nосновное окно опций";

-- Messages
SMARTBUFF_MSG_LOADED         = "загружен";
SMARTBUFF_MSG_NEWVER1        = "|cff00e0ffSmartbuff : |cffffffff Доступна новая версия, вы используете |cffFFFF00";
SMARTBUFF_MSG_NEWVER2        = "|cffffffff и ревизия |cffFFFF00r"
SMARTBUFF_MSG_NEWVER3        = "|cffffffff в настоящее время доступен для скачивания. Присоединяйтесь к Discord для получения всей последней информации на https://discord.gg/R6EkZ94TKK.";
SMARTBUFF_MSG_DISABLED       = "SmartBuff отключен!";
SMARTBUFF_MSG_SUBGROUP       = "Вы присоединились к новой группе, проверьте опции!";
SMARTBUFF_MSG_NOTHINGTODO    = "Нечего делать";
SMARTBUFF_MSG_BUFFED         = "- бафф наложен";
SMARTBUFF_MSG_OOR            = "вне зоны действия баффа!";
SMARTBUFF_MSG_CD             = "Глобальный кулдаун!";
SMARTBUFF_MSG_CHAT           = "невозможно в режиме чата!";
SMARTBUFF_MSG_SHAPESHIFT     = "Нельзя колдовать в звероформе!";
SMARTBUFF_MSG_NOACTIONSLOT   = "требуется слот в панели действий для правильной работы!";
SMARTBUFF_MSG_GROUP          = "Группа";
SMARTBUFF_MSG_NEEDS          = "нуждается в баффе:";
SMARTBUFF_MSG_OOM            = "Не хватает маны/ярости/энергии!";
SMARTBUFF_MSG_STOCK          = "Имеющийся запас";
SMARTBUFF_MSG_NOREAGENT      = "Нехватка реагента:";
SMARTBUFF_MSG_DEACTIVATED    = "деактивировано!";
SMARTBUFF_MSG_REBUFF         = "Реббафф";
SMARTBUFF_MSG_LEFT           = "осталось";
SMARTBUFF_MSG_CLASS          = "Класс";
SMARTBUFF_MSG_CHARGES        = "зарядов";
SMARTBUFF_MSG_SOUNDS         = "Выбранный звук всплеска: "
SMARTBUFF_MSG_SPECCHANGED    = "Spec changed (%s), loading buff templates...";

-- Support
SMARTBUFF_MINIMAP_TT         = "Левой кнопкой: меню опций\nПравой кнопкой: Вкл/Выкл\nAlt+Левой Кнопкой: SmartDebuff\nТащить с Shift-ом: Двигать кнопку";
SMARTBUFF_TITAN_TT           = "Левой кнопкой: меню опций\nПравой кнопкой: Вкл/Выкл\nAlt+Левой Кнопкой: SmartDebuff";
SMARTBUFF_FUBAR_TT           = "Левой кнопкой: меню опций\nShift+Левой кнопкой: Вкл/Выкл\nAlt+Левой Кнопкой: SmartDebuff";

SMARTBUFF_DEBUFF_TT          = "Shift+тащить: Двигать рамку\n|cff20d2ff- S button -|r\nЛевой кнопкой: Показать по классам\nShift+левой кнопкой: Классовые цвета\nAlt+Левой кнопкой: Подсветить L/R\n|cff20d2ff- P button -|r\nЛевой кнопкой: Спрятать петов (да/нет)";

end
