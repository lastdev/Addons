-- Russian translator required

------------
-- RUSSIAN --
------------
--Last update: 21.03.2011 - 11:15
--
--
-- (http://www.wowwiki.com/Localizing_an_addon)
--
-- If you want to translate for this region, please first confirm by email:  healbot@outlook.com
-- Include your registered username on the healbot website and the region you’re interested in taking responsibility for.
--
--





function HealBot_Lang_ruRU()

-----------------
-- Translation --
-----------------

-- Class
    HEALBOT_DRUID                           = "Друид";
    HEALBOT_HUNTER                          = "Охотник";
    HEALBOT_MAGE                            = "Маг";
    HEALBOT_PALADIN                         = "Паладин";
    HEALBOT_PRIEST                          = "Жрец";
    HEALBOT_ROGUE                           = "Разбойник";
    HEALBOT_SHAMAN                          = "Шаман";
    HEALBOT_WARLOCK                         = "Чернокнижник";
    HEALBOT_WARRIOR                         = "Воин";
    HEALBOT_DEATHKNIGHT                     = "Рыцарь cмерти";
HEALBOT_MONK                            = "Monk";

    HEALBOT_DISEASE                         = "Болезнь";
    HEALBOT_MAGIC                           = "Магия";
    HEALBOT_CURSE                           = "Проклятие";
    HEALBOT_POISON                          = "Яд";

    HB_TOOLTIP_OFFLINE                      = PLAYER_OFFLINE;
    HB_OFFLINE                              = PLAYER_OFFLINE; -- has gone offline msg
    HB_ONLINE                               = GUILD_ONLINE_LABEL; -- has come online msg

    HEALBOT_HEALBOT                         = "HealBot";
    HEALBOT_ADDON                           = HEALBOT_HEALBOT .. " " .. HEALBOT_VERSION;
    HEALBOT_LOADED                          = " загружен.";

    HEALBOT_ACTION_OPTIONS                  = "Настройки";

    HEALBOT_OPTIONS_TITLE                   = HEALBOT_ADDON;
    HEALBOT_OPTIONS_DEFAULTS                = "Стандарт";
    HEALBOT_OPTIONS_CLOSE                   = "Закрыть";
    HEALBOT_OPTIONS_HARDRESET               = "Перез.UI"
    HEALBOT_OPTIONS_SOFTRESET               = "СбросHB"
    HEALBOT_OPTIONS_TAB_GENERAL             = "Общее";
    HEALBOT_OPTIONS_TAB_SPELLS              = "Заклинания";
    HEALBOT_OPTIONS_TAB_HEALING             = "Исцеление";
    HEALBOT_OPTIONS_TAB_CDC                 = "Излечение";
    HEALBOT_OPTIONS_TAB_SKIN                = "Шкурки";
    HEALBOT_OPTIONS_TAB_TIPS                = "Tips";
    HEALBOT_OPTIONS_TAB_BUFFS               = "Бафы";

    HEALBOT_OPTIONS_BARALPHA                = "Прозрач-ть включеных";
    HEALBOT_OPTIONS_BARALPHAINHEAL          = "Прозр-ть вход-го исцеления";
HEALBOT_OPTIONS_BARALPHABACK            = "Background bar opacity";
    HEALBOT_OPTIONS_BARALPHAEOR             = "Прозр-ть 'Вне досягаемости'";
    HEALBOT_OPTIONS_ACTIONLOCKED            = "Закрепить позиции";
    HEALBOT_OPTIONS_AUTOSHOW                = "Авто закрыть";
    HEALBOT_OPTIONS_PANELSOUNDS             = "Звук при открытии";
    HEALBOT_OPTIONS_HIDEOPTIONS             = "Скрыть кнопку настроек";
    HEALBOT_OPTIONS_PROTECTPVP              = "Избегать случайного PvP";
    HEALBOT_OPTIONS_HEAL_CHATOPT            = "Настройки чата";

    HEALBOT_OPTIONS_FRAMESCALE              = "Масштаб фрейма"
    HEALBOT_OPTIONS_SKINTEXT                = "Шкурка";
    HEALBOT_SKINS_STD                       = "Стандарт";
    HEALBOT_OPTIONS_SKINTEXTURE             = "Текстура";
    HEALBOT_OPTIONS_SKINHEIGHT              = "Высота";
    HEALBOT_OPTIONS_SKINWIDTH               = "Ширина";
    HEALBOT_OPTIONS_SKINNUMCOLS             = "Колонок";
    HEALBOT_OPTIONS_SKINNUMHCOLS            = "Заголовки/колонки";
    HEALBOT_OPTIONS_SKINBRSPACE             = "Промежуток строк";
    HEALBOT_OPTIONS_SKINBCSPACE             = "Промежуток рядов";
    HEALBOT_OPTIONS_EXTRASORT               = "Сорт панелей";
    HEALBOT_SORTBY_NAME                     = "Имя";
    HEALBOT_SORTBY_CLASS                    = "Класс";
    HEALBOT_SORTBY_GROUP                    = "Группа";
    HEALBOT_SORTBY_MAXHEALTH                = "Макс здоровья";
    HEALBOT_OPTIONS_NEWDEBUFFTEXT           = "Нов.Дебаф"
    HEALBOT_OPTIONS_DELSKIN                 = "Удалить";
    HEALBOT_OPTIONS_NEWSKINTEXT             = "Нов.Шкурка";
    HEALBOT_OPTIONS_SAVESKIN                = "Сохранить";
    HEALBOT_OPTIONS_SKINBARS                = "Опции панели";
    HEALBOT_SKIN_ENTEXT                     = "Включить";
    HEALBOT_SKIN_DISTEXT                    = "Выключить";
    HEALBOT_SKIN_DEBTEXT                    = "Дебаф";
    HEALBOT_SKIN_BACKTEXT                   = "Фон";
    HEALBOT_SKIN_BORDERTEXT                 = "Края";
    HEALBOT_OPTIONS_SKINFONT                = "Шрифт"
    HEALBOT_OPTIONS_SKINFHEIGHT             = "Размер шрифта";
    HEALBOT_OPTIONS_SKINFOUTLINE            = "Контур шрифта"
    HEALBOT_OPTIONS_BARALPHADIS             = "Прозрачностьть откл.";
    HEALBOT_OPTIONS_SHOWHEADERS             = "Заголовки";

    HEALBOT_OPTIONS_ITEMS                   = "Предметы";

    HEALBOT_OPTIONS_COMBOCLASS              = "Клавиши для";
    HEALBOT_OPTIONS_CLICK                   = "Клик";
    HEALBOT_OPTIONS_SHIFT                   = "Shift";
    HEALBOT_OPTIONS_CTRL                    = "Ctrl";
    HEALBOT_OPTIONS_ENABLEHEALTHY           = "Всегда включено";

    HEALBOT_OPTIONS_CASTNOTIFY1             = "Не сообщать";
    HEALBOT_OPTIONS_CASTNOTIFY2             = "Только себе";
    HEALBOT_OPTIONS_CASTNOTIFY3             = "Извещать цель";
    HEALBOT_OPTIONS_CASTNOTIFY4             = "Группа";
    HEALBOT_OPTIONS_CASTNOTIFY5             = "Рейд";
    HEALBOT_OPTIONS_CASTNOTIFY6             = "В канал";
    HEALBOT_OPTIONS_CASTNOTIFYRESONLY       = "Извещать только воскрешение";

    HEALBOT_OPTIONS_CDCBARS                 = "Цвета полос";
    HEALBOT_OPTIONS_CDCSHOWHBARS            = "На полосе здоровья";
    HEALBOT_OPTIONS_CDCSHOWABARS            = "На полосе угрозы";
    HEALBOT_OPTIONS_CDCWARNINGS             = "Предупреждения о дебафах";
    HEALBOT_OPTIONS_SHOWDEBUFFICON          = "Иконки дебафов";
    HEALBOT_OPTIONS_SHOWDEBUFFWARNING       = "Сообщения о дебафах";
    HEALBOT_OPTIONS_SOUNDDEBUFFWARNING      = "Звук при дебафе";
    HEALBOT_OPTIONS_SOUND                   = "Звук";

    HEALBOT_OPTIONS_HEAL_BUTTONS            = "Панели исцелений";
    HEALBOT_OPTIONS_SELFHEALS               = "Себя";
    HEALBOT_OPTIONS_PETHEALS                = "Питомцев";
    HEALBOT_OPTIONS_GROUPHEALS              = "Группу";
    HEALBOT_OPTIONS_TANKHEALS               = "Главных танков";
    HEALBOT_OPTIONS_MAINASSIST              = "Наводчик";
    HEALBOT_OPTIONS_PRIVATETANKS            = "Личных Гл. танков";
    HEALBOT_OPTIONS_TARGETHEALS             = "Цели";
    HEALBOT_OPTIONS_EMERGENCYHEALS          = "Рейд";
    HEALBOT_OPTIONS_ALERTLEVEL              = "Тревога";
    HEALBOT_OPTIONS_EMERGFILTER             = "Экстра полосы для";
    HEALBOT_OPTIONS_EMERGFCLASS             = "Настройка классов для";
    HEALBOT_OPTIONS_COMBOBUTTON             = "Кнопка";
    HEALBOT_OPTIONS_BUTTONLEFT              = "Левая";
    HEALBOT_OPTIONS_BUTTONMIDDLE            = "Средняя";
    HEALBOT_OPTIONS_BUTTONRIGHT             = "Правая";
    HEALBOT_OPTIONS_BUTTON4                 = "Кнопка4";
    HEALBOT_OPTIONS_BUTTON5                 = "Кнопка5";
    HEALBOT_OPTIONS_BUTTON6                 = "Кнопка6";
    HEALBOT_OPTIONS_BUTTON7                 = "Кнопка7";
    HEALBOT_OPTIONS_BUTTON8                 = "Кнопка8";
    HEALBOT_OPTIONS_BUTTON9                 = "Кнопка9";
    HEALBOT_OPTIONS_BUTTON10                = "Кнопка10";
    HEALBOT_OPTIONS_BUTTON11                = "Кнопка11";
    HEALBOT_OPTIONS_BUTTON12                = "Кнопка12";
    HEALBOT_OPTIONS_BUTTON13                = "Кнопка13";
    HEALBOT_OPTIONS_BUTTON14                = "Кнопка14";
    HEALBOT_OPTIONS_BUTTON15                = "Кнопка15";

    HEALBOT_CLASSES_ALL                     = "Все классы";
    HEALBOT_CLASSES_MELEE                   = "Ближние";
    HEALBOT_CLASSES_RANGES                  = "Дальние";
    HEALBOT_CLASSES_HEALERS                 = "Целители";
    HEALBOT_CLASSES_CUSTOM                  = "Клиентские";

    HEALBOT_OPTIONS_SHOWTOOLTIP             = "Подсказки";
    HEALBOT_OPTIONS_SHOWDETTOOLTIP          = "Инфо о заклинании";
    HEALBOT_OPTIONS_SHOWCDTOOLTIP           = "Восстановление заклинания";
    HEALBOT_OPTIONS_SHOWUNITTOOLTIP         = "Инфо о цели";
    HEALBOT_OPTIONS_SHOWRECTOOLTIP          = "Рекомендации Исцеления За Время";
    HEALBOT_TOOLTIP_POSDEFAULT              = "По умолчанию";
    HEALBOT_TOOLTIP_POSLEFT                 = "Слева Healbotа";
    HEALBOT_TOOLTIP_POSRIGHT                = "Справа Healbotа";
    HEALBOT_TOOLTIP_POSABOVE                = "Вверху Healbotа";
    HEALBOT_TOOLTIP_POSBELOW                = "Внизу Healbotа";
    HEALBOT_TOOLTIP_POSCURSOR               = "Под курсором";
    HEALBOT_TOOLTIP_RECOMMENDTEXT           = "Рекомендации Исцеления За Время";
    HEALBOT_TOOLTIP_NONE                    = "нет доступных";
    HEALBOT_TOOLTIP_CORPSE                  = "Труп ";
    HEALBOT_TOOLTIP_CD                      = " (CD ";
    HEALBOT_TOOLTIP_SECS                    = "с)";
    HEALBOT_WORDS_SEC                       = "сек";
    HEALBOT_WORDS_CAST                      = "Применение";
    HEALBOT_WORDS_UNKNOWN                   = "неизвестно";
    HEALBOT_WORDS_YES                       = "Да";
    HEALBOT_WORDS_NO                        = "Нет";
    HEALBOT_WORDS_THIN                      = "Тонкий";
    HEALBOT_WORDS_THICK                     = "Толстый";

    HEALBOT_WORDS_NONE                      = "Нету";
    HEALBOT_OPTIONS_ALT                     = "Alt";
    HEALBOT_DISABLED_TARGET                 = "Цель"
    HEALBOT_OPTIONS_SHOWCLASSONBAR          = "Классы на панели";
    HEALBOT_OPTIONS_SHOWHEALTHONBAR         = "Здоровье на панели";
    HEALBOT_OPTIONS_BARHEALTHINCHEALS       = "Входящее исцеление";
    HEALBOT_OPTIONS_BARHEALTHSEPHEALS       = "Разделять вход. исцеление";
    HEALBOT_OPTIONS_BARHEALTH1              = "в цифрах";
    HEALBOT_OPTIONS_BARHEALTH2              = "в процентах";
    HEALBOT_OPTIONS_TIPTEXT                 = "Информация в подсказке";
    HEALBOT_OPTIONS_POSTOOLTIP              = "Подсказка";
    HEALBOT_OPTIONS_SHOWNAMEONBAR           = "Имена";
    HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR1     = "Текст по цвету класса";
    HEALBOT_OPTIONS_EMERGFILTERGROUPS       = "Группы";

    HEALBOT_ONE                             = "1";
    HEALBOT_TWO                             = "2";
    HEALBOT_THREE                           = "3";
    HEALBOT_FOUR                            = "4";
    HEALBOT_FIVE                            = "5";
    HEALBOT_SIX                             = "6";
    HEALBOT_SEVEN                           = "7";
    HEALBOT_EIGHT                           = "8";

    HEALBOT_OPTIONS_SETDEFAULTS             = "Стандарт";
    HEALBOT_OPTIONS_SETDEFAULTSMSG          = "Сброс всех настроек на стандартные";
    HEALBOT_OPTIONS_RIGHTBOPTIONS           = "ПКМ открывает настройки";

    HEALBOT_OPTIONS_HEADEROPTTEXT           = "Заголовки";
    HEALBOT_OPTIONS_ICONOPTTEXT             = "Опции иконки";
    HEALBOT_SKIN_HEADERBARCOL               = "Цвета панелей";
    HEALBOT_SKIN_HEADERTEXTCOL              = "Цвета текста";
    HEALBOT_OPTIONS_BUFFSTEXT1              = "Заклинание";
    HEALBOT_OPTIONS_BUFFSTEXT2              = "Проверка";
    HEALBOT_OPTIONS_BUFFSTEXT3              = "Цвета панелей";
    HEALBOT_OPTIONS_BUFF                    = "Баф";
    HEALBOT_OPTIONS_BUFFSELF                = "на себя";
    HEALBOT_OPTIONS_BUFFPARTY               = "на группу";
    HEALBOT_OPTIONS_BUFFRAID                = "на рейд";
    HEALBOT_OPTIONS_MONITORBUFFS            = "Монитор пропущенных бафов";
    HEALBOT_OPTIONS_MONITORBUFFSC           = "также в бою";
    HEALBOT_OPTIONS_ENABLESMARTCAST         = "БыстроеЧтение когда в не боя";
    HEALBOT_OPTIONS_SMARTCASTSPELLS         = "Заклинания";
    HEALBOT_OPTIONS_SMARTCASTDISPELL        = "Расс-ть дебаф";
    HEALBOT_OPTIONS_SMARTCASTBUFF           = "Добавить баф";
    HEALBOT_OPTIONS_SMARTCASTHEAL           = "Исцеления";
    HEALBOT_OPTIONS_BAR2SIZE                = "Размер полосы маны";
    HEALBOT_OPTIONS_SETSPELLS               = "Заклинания";
    HEALBOT_OPTIONS_ENABLEDBARS             = "Включить панели";
    HEALBOT_OPTIONS_DISABLEDBARS            = "Отключить панели когда в не боя";
    HEALBOT_OPTIONS_MONITORDEBUFFS          = "Монитор снятия дебафов";
    HEALBOT_OPTIONS_DEBUFFTEXT1             = "Зак-ние снимающее дебафы";

    HEALBOT_OPTIONS_IGNOREDEBUFF            = "Игнорировать:";
    HEALBOT_OPTIONS_IGNOREDEBUFFCLASS       = "По классам";
    HEALBOT_OPTIONS_IGNOREDEBUFFMOVEMENT    = "Замедления";
    HEALBOT_OPTIONS_IGNOREDEBUFFDURATION    = "Срок действия";
    HEALBOT_OPTIONS_IGNOREDEBUFFNOHARM      = "Не вредные";
HEALBOT_OPTIONS_IGNOREDEBUFFCOOLDOWN    = "When cure spell CoolDown > 1.5 secs (GCD)";
HEALBOT_OPTIONS_IGNOREDEBUFFFRIEND      = "When caster is known as friend";

    HEALBOT_OPTIONS_RANGECHECKFREQ          = "Проверка досягаемости";

    HEALBOT_OPTIONS_HIDEPARTYFRAMES         = "Скрыть окна группы";
    HEALBOT_OPTIONS_HIDEPLAYERTARGET        = "Включая игрока и цель";
    HEALBOT_OPTIONS_DISABLEHEALBOT          = "Отключить HealBot";

    HEALBOT_ASSIST                          = "Assist";
    HEALBOT_FOCUS                           = "Focus";
    HEALBOT_MENU                            = "Меню";
    HEALBOT_MAINTANK                        = "Г.Танк";
    HEALBOT_MAINASSIST                      = "Г.Помощник";
    HEALBOT_STOP                            = "Стоп";
    HEALBOT_TELL                            = "Сказать";

    HEALBOT_TITAN_SMARTCAST                 = "БыстроеЧтение";
    HEALBOT_TITAN_MONITORBUFFS              = "Монитор бафов";
    HEALBOT_TITAN_MONITORDEBUFFS            = "Монитор дебафов";
    HEALBOT_TITAN_SHOWBARS                  = "Панели для";
    HEALBOT_TITAN_EXTRABARS                 = "Доп. панели";
    HEALBOT_BUTTON_TOOLTIP                  = "ЛКМ переключает окно настроек HealBotа\nПКМ (Удерживая) для перемещения";
    HEALBOT_TITAN_TOOLTIP                   = "ЛКМ переключает окно настроек HealBotа";
    HEALBOT_OPTIONS_SHOWMINIMAPBUTTON       = "Показ кнопки у мини-карты";
    HEALBOT_OPTIONS_BARBUTTONSHOWHOT        = "Показ иконки ИзВ";
    HEALBOT_OPTIONS_BARBUTTONSHOWRAIDICON   = "Показ иконки рейда";
    HEALBOT_OPTIONS_HOTONBAR                = "Внутри";
    HEALBOT_OPTIONS_HOTOFFBAR               = "Снаружи";
    HEALBOT_OPTIONS_HOTBARRIGHT             = "Справа";
    HEALBOT_OPTIONS_HOTBARLEFT              = "Слева";

    HEALBOT_ZONE_AB                         = "Низина Арати";
    HEALBOT_ZONE_AV                         = "Альтеракская долина";
    HEALBOT_ZONE_ES                         = "Око Бури";
    HEALBOT_ZONE_IC                         = "Остров Завоеваний";
    HEALBOT_ZONE_SA                         = "Берег Древних";

    HEALBOT_OPTION_AGGROTRACK               = "Монитор агрессии";
    HEALBOT_OPTION_AGGROBAR                 = "Мигание";
    HEALBOT_OPTION_AGGROTXT                 = ">> Показ текста <<";
HEALBOT_OPTION_AGGROIND                 = "Indicator"
    HEALBOT_OPTION_BARUPDFREQ               = "Частота обновления";
    HEALBOT_OPTION_USEFLUIDBARS             = "Исп текучие полосы";
    HEALBOT_OPTION_CPUPROFILE               = "Использовать профайлер CPU (Инфо о нагрузке CPU )";
    HEALBOT_OPTIONS_RELOADUIMSG             = "Для того чтобы настройки вступили бы в силу необходима перезагрузка интерфейса, Готовы?";

    HEALBOT_BUFF_PVP                        = "PvP"
    HEALBOT_BUFF_PVE						= "PvE"
    HEALBOT_OPTIONS_ANCHOR                  = "Якорь фрейма";
    HEALBOT_OPTIONS_BARSANCHOR              = "Якорь полос"
    HEALBOT_OPTIONS_TOPLEFT                 = "Вверху слева";
    HEALBOT_OPTIONS_BOTTOMLEFT              = "Внизу слева";
    HEALBOT_OPTIONS_TOPRIGHT                = "Вверху справа";
    HEALBOT_OPTIONS_BOTTOMRIGHT             = "Внизу справа";
    HEALBOT_OPTIONS_TOP                     = "Вверху";
    HEALBOT_OPTIONS_BOTTOM                  = "Внизу";

    HEALBOT_PANEL_BLACKLIST                 = "Чёрный-Список";

    HEALBOT_WORDS_REMOVEFROM                = "Снять с";
    HEALBOT_WORDS_ADDTO                     = "Наложить на";
    HEALBOT_WORDS_INCLUDE                   = "Включая";

    HEALBOT_OPTIONS_TTALPHA                 = "Прозрачность";
    HEALBOT_TOOLTIP_TARGETBAR               = "Панель цели";
    HEALBOT_OPTIONS_MYTARGET                = "Моя цель";

    HEALBOT_DISCONNECTED_TEXT               = "<ОФФ>"
    HEALBOT_OPTIONS_SHOWUNITBUFFTIME        = "Показ.мои бафы";
    HEALBOT_OPTIONS_TOOLTIPUPDATE           = "Постоянно обновлять";
    HEALBOT_OPTIONS_BUFFSTEXTTIMER          = "Показ баф перед окончанием";
    HEALBOT_OPTIONS_SHORTBUFFTIMER          = "Короткие бафы";
    HEALBOT_OPTIONS_LONGBUFFTIMER           = "Длинные бафы";

    HEALBOT_OPTIONS_NOTIFY_MSG              = "Cообщения";
    HEALBOT_WORDS_YOU                       = "вы";
    HEALBOT_NOTIFYOTHERMSG                  = "Применяется #s на #n";

    HEALBOT_OPTIONS_HOTPOSITION             = "Позиция иконки";
    HEALBOT_OPTIONS_HOTSHOWTEXT             = "Текст иконки";
    HEALBOT_OPTIONS_HOTTEXTCOUNT            = "Подсчёт";
    HEALBOT_OPTIONS_HOTTEXTDURATION         = "Длительность";
    HEALBOT_OPTIONS_ICONSCALE               = "Масштаб";
    HEALBOT_OPTIONS_ICONTEXTSCALE           = "Масштаб текста иконки";

    HEALBOT_OPTIONS_AGGROBARSIZE            = "Размер полосы угрозы";
    HEALBOT_OPTIONS_DOUBLETEXTLINES         = "Текст в 2 строки";
    HEALBOT_OPTIONS_TEXTALIGNMENT           = "Выравнивание текста";
    HEALBOT_VEHICLE                         = "Транспорт";
    HEALBOT_WORDS_ERROR				        = "Ошибка";
    HEALBOT_SPELL_NOT_FOUND			        = "Заклинание не найдено";
    HEALBOT_OPTIONS_DISABLETOOLTIPINCOMBAT  = "Скрыть подсказки в бою";
    HEALBOT_OPTIONS_ENABLELIBQH             = "Включить fastHealth"

    HEALBOT_OPTIONS_BUFFNAMED               = "Для наблюдения, введите имя игрока:\n\n";
    HEALBOT_WORD_ALWAYS                     = "Всегда";
    HEALBOT_WORD_SOLO                       = "В одиночку";
    HEALBOT_WORD_NEVER                      = "Никогда";
    HEALBOT_SHOW_CLASS_AS_ICON              = "как иконку";
    HEALBOT_SHOW_CLASS_AS_TEXT              = "как текст";
HEALBOT_SHOW_ROLE                       = "show role when set";

    HEALBOT_SHOW_INCHEALS                   = "Входящее исцеление";

HEALBOT_HELP={ [1] = "[HealBot] /hb h -- показать справку",
               [2] = "[HealBot] /hb o -- переключение настроек",
               [3] = "[HealBot] /hb ri -- сбросить HealBot",
               [4] = "[HealBot] /hb t -- переключения Healbot из состояния включен в выключен и обратно",
               [5] = "[HealBot] /hb bt -- переключения мониторинга бафов из состояния включен в выключен и обратно",
               [6] = "[HealBot] /hb dt -- переключения мониторинга дебафов из состояния включен в выключен и обратно",
               [7] = "[HealBot] /hb skin <skinName> -- сменить шкурку",
               [8] = "[HealBot] /hb ui -- перезагрузить UI",
               [9] = "[HealBot] /hb hs -- показать дополнительные слэш команды",
              }
              
HEALBOT_HELP2={ [1] = "[HealBot] /hb d -- сброс настроек на стандартные значения",
                [2] = "[HealBot] /hb aggro 2 <n> -- Set aggro level 2 on threat percentage <n>",
                [3] = "[HealBot] /hb aggro 3 <n> -- Set aggro level 3 on threat percentage <n>",
                [4] = "[HealBot] /hb tr <Role> -- установите наивысший приоритет по роли для под-сортировке по роли. Дествующие роли 'TANK', 'HEALER' или 'DPS'",
                [5] = "[HealBot] /hb use10 -- австоматически использовать Инженерный слот 10",
                [6] = "[HealBot] /hb pcs <n> -- регулировка размера индикатора заряда энергии света на <n>, Значение по умолчанию 7 ",
                [7] = "[HealBot] /hb spt -- переключение своего питомца",
                [8] = "[HealBot] /hb ws -- переключение сокрытия/показа иконки Ослабленная душа вместо СС:Щ с -",
                [9] = "[HealBot] /hb rld <n> -- In seconds, how long the players name stays green after a res",
                [10] = "[HealBot] /hb flb -- Toggle frame lock bypass (frame always moves with Ctrl+Alt+Left click)",
                [11] = "[HealBot] /hb rtb -- Toggle restrict target bar to Left=SmartCast and Right=add/remove to/from My Targets",
              }
              
    HEALBOT_OPTION_HIGHLIGHTACTIVEBAR       = "Выделять активную полосу";
    HEALBOT_OPTION_HIGHLIGHTTARGETBAR       = "Выделять цель";
    HEALBOT_OPTIONS_TESTBARS                = "Тест полос";
    HEALBOT_OPTION_NUMBARS                  = "Количество полос";
    HEALBOT_OPTION_NUMTANKS                 = "Количество танков";
    HEALBOT_OPTION_NUMMYTARGETS             = "Количество моих целей";
    HEALBOT_OPTION_NUMPETS                  = "Количество питов";
    HEALBOT_WORD_TEST                       = "Тест";
    HEALBOT_WORD_OFF                        = "Выкл";
    HEALBOT_WORD_ON                         = "Вкл";

    HEALBOT_OPTIONS_TAB_PROTECTION          = "Защита";
    HEALBOT_OPTIONS_TAB_CHAT                = "Чат";
    HEALBOT_OPTIONS_TAB_HEADERS             = "Заголовки";
    HEALBOT_OPTIONS_TAB_BARS                = "Полосы";
    HEALBOT_OPTIONS_TAB_ICONS               = "Иконки";
    HEALBOT_OPTIONS_TAB_WARNING             = "Оповещения";
    HEALBOT_OPTIONS_SKINDEFAULTFOR          = "Стандарт. шкурка для";
    HEALBOT_OPTIONS_INCHEAL                 = "Вхд. исцеление";
    HEALBOT_WORD_ARENA                      = "Арена";
    HEALBOT_WORD_BATTLEGROUND               = "Поля боя";
    HEALBOT_OPTIONS_TEXTOPTIONS             = "Опции текста";
    HEALBOT_WORD_PARTY                      = "Группа";
    HEALBOT_OPTIONS_COMBOAUTOTARGET         = "Авто цель";
    HEALBOT_OPTIONS_COMBOAUTOTRINKET        = "Авто аксессуар";
    HEALBOT_OPTIONS_GROUPSPERCOLUMN         = "Исп. группы на колонку";

    HEALBOT_OPTIONS_MAINSORT                = "Гл. сорт";
    HEALBOT_OPTIONS_SUBSORT                 = "Доп. сорт";
    HEALBOT_OPTIONS_SUBSORTINC              = "Также доп сорт:";

    HEALBOT_OPTIONS_BUTTONCASTMETHOD        = "Применить\nкогда";
    HEALBOT_OPTIONS_BUTTONCASTPRESSED       = "Нажата";
    HEALBOT_OPTIONS_BUTTONCASTRELEASED      = "Отпущена";

    HEALBOT_INFO_ADDONCPUUSAGE              = "== Исп. CPU аддоном в секундах ==";
    HEALBOT_INFO_ADDONCOMMUSAGE             = "== Исп. коммуникации аддоном ==";
    HEALBOT_WORD_HEALER                     = "Лекарь";
HEALBOT_WORD_DAMAGER                    = "Damager"
HEALBOT_WORD_TANK                       = "Tank"
HEALBOT_WORD_LEADER                     = "Leader"
    HEALBOT_WORD_VERSION                    = "Версия";
    HEALBOT_WORD_CLIENT                     = "Клиент";
    HEALBOT_WORD_ADDON                      = "Аддон";
    HEALBOT_INFO_CPUSECS                    = "CPU сек";
    HEALBOT_INFO_MEMORYKB                   = "Память КБ";
    HEALBOT_INFO_COMMS                      = "Связь КБ";

    HEALBOT_WORD_STAR                       = "Звезда";
    HEALBOT_WORD_CIRCLE                     = "Круг";
    HEALBOT_WORD_DIAMOND                    = "Ромб";
    HEALBOT_WORD_TRIANGLE                   = "Треугольник";
    HEALBOT_WORD_MOON                       = "Луна";
    HEALBOT_WORD_SQUARE                     = "Квадрат";
    HEALBOT_WORD_CROSS                      = "Крест";
    HEALBOT_WORD_SKULL                      = "Череп";

    HEALBOT_OPTIONS_ACCEPTSKINMSG           = "Принять шкурку [HealBot]: ";
    HEALBOT_OPTIONS_ACCEPTSKINMSGFROM       = " от ";
    HEALBOT_OPTIONS_BUTTONSHARESKIN         = "Поделиться с";

    HEALBOT_CHAT_ADDONID                    = "[HealBot]  ";
    HEALBOT_CHAT_NEWVERSION1                = "Доступна новая версия";
    HEALBOT_CHAT_NEWVERSION2                = "на "..HEALBOT_ABOUT_URL
HEALBOT_CHAT_SHARESKINERR1              = " Skin not found for Sharing"
HEALBOT_CHAT_SHARESKINERR3              = " not found for Skin Sharing"
HEALBOT_CHAT_SHARESKINACPT              = "Share Skin accepted from "
    HEALBOT_CHAT_CONFIRMSKINDEFAULTS        = "Шкурка по умолчанию";
    HEALBOT_CHAT_CONFIRMCUSTOMDEFAULTS      = "Пользовательский дебаф сброшен";
    HEALBOT_CHAT_CHANGESKINERR1             = "неизвестная шкурка: /hb skin ";
    HEALBOT_CHAT_CHANGESKINERR2             = "Действительные шкурки:  ";
    HEALBOT_CHAT_CONFIRMSPELLCOPY           = "Текущее заклинания скопировано на все наборы талантов";
    HEALBOT_CHAT_UNKNOWNCMD                 = "Неизвестная слэш команда: /hb ";
HEALBOT_CHAT_ENABLED                    = "Entering enabled state"
HEALBOT_CHAT_DISABLED                   = "Entering disabled state"
HEALBOT_CHAT_SOFTRELOAD                 = "Reload healbot requested"
HEALBOT_CHAT_HARDRELOAD                 = "Reload UI requested"
    HEALBOT_CHAT_CONFIRMSPELLRESET          = "Заклинания сброшены";
    HEALBOT_CHAT_CONFIRMCURESRESET          = "Лечения сброшены";
    HEALBOT_CHAT_CONFIRMBUFFSRESET          = "Бафы сброшены";
HEALBOT_CHAT_POSSIBLEMISSINGMEDIA       = "Unable to receive all Skin settings - Possibly missing SharedMedia, download from curse.com"
HEALBOT_CHAT_MACROSOUNDON               = "Sound not suppressed when using auto trinkets"
HEALBOT_CHAT_MACROSOUNDOFF              = "Sound suppressed when using auto trinkets"
HEALBOT_CHAT_MACROERRORON               = "Errors not suppressed when using auto trinkets"
HEALBOT_CHAT_MACROERROROFF              = "Errors suppressed when using auto trinkets"
HEALBOT_CHAT_ACCEPTSKINON               = "Share Skin - Show accept skin popup when someone shares a skin with you"
HEALBOT_CHAT_ACCEPTSKINOFF              = "Share Skin - Always ignore share skins from everyone"
HEALBOT_CHAT_USE10ON                    = "Auto Trinket - Use10 is on - You must enable an existing auto trinket for use10 to work";
HEALBOT_CHAT_USE10OFF                   = "Auto Trinket - Use10 is off";
    HEALBOT_CHAT_SKINREC                    = " получена шкурка от ";

    HEALBOT_OPTIONS_SELFCASTS               = "Только личные применения";
    HEALBOT_OPTIONS_HOTSHOWICON             = "Иконка";
    HEALBOT_OPTIONS_ALLSPELLS               = "Все заклинания";
    HEALBOT_OPTIONS_DOUBLEROW               = "Двойной ряд";
    HEALBOT_OPTIONS_HOTBELOWBAR             = "Ниже полосы";
    HEALBOT_OPTIONS_OTHERSPELLS             = "Другие заклинания";
    HEALBOT_WORD_MACROS                     = "Макрос";
    HEALBOT_WORD_SELECT                     = "Выбрать";
    HEALBOT_OPTIONS_QUESTION                = "?";
    HEALBOT_WORD_CANCEL                     = "Отмена";
    HEALBOT_WORD_COMMANDS                   = "Команды"
    HEALBOT_OPTIONS_BARHEALTH3              = "как здоровье";
    HEALBOT_SORTBY_ROLE                     = "Роль";
    HEALBOT_WORD_DPS                        = "DPS"
    HEALBOT_CHAT_TOPROLEERR                 = " роль не действительна в данном контексте - используйте 'TANK', 'DPS' или 'HEALER'";
HEALBOT_CHAT_NEWTOPROLE                 = "Highest top role is now "
HEALBOT_CHAT_SUBSORTPLAYER1             = "Player will be set to first in SubSort"
HEALBOT_CHAT_SUBSORTPLAYER2             = "Player will be sorted normally in SubSort"
    HEALBOT_OPTIONS_SHOWREADYCHECK          = "Проверка готовности";
    HEALBOT_OPTIONS_SUBSORTSELFFIRST        = "Сначало вы";
    HEALBOT_WORD_FILTER                     = "Фильтр";
    HEALBOT_OPTION_AGGROPCTBAR              = "Двигать";
    HEALBOT_OPTION_AGGROPCTTXT              = "Показ. текст";
    HEALBOT_OPTION_AGGROPCTTRACK            = "Следить в %";
    HEALBOT_OPTIONS_ALERTAGGROLEVEL1        = "1 - имея высокую угрозу и ничего не танкуя";
    HEALBOT_OPTIONS_ALERTAGGROLEVEL2        = "2 - опасное танкования, не наивысшая угроза на существе";
    HEALBOT_OPTIONS_ALERTAGGROLEVEL3        = "3 - безопасное танкованин по крайней мере одно существо";
    HEALBOT_OPTIONS_AGGROALERT              = "Уровент сигнала об угрозе";
HEALBOT_OPTIONS_AGGROINDALERT           = "Indicator alert level"
    HEALBOT_OPTIONS_TOOLTIPSHOWHOT          = "Показать подробности о наблюдаемом ИзВ";
    HEALBOT_WORDS_MIN                       = "мин";
    HEALBOT_WORDS_MAX                       = "макс";
HEALBOT_CHAT_SELFPETSON                 = "Self Pet switched on"
HEALBOT_CHAT_SELFPETSOFF                = "Self Pet switched off"
    HEALBOT_WORD_PRIORITY                   = "Приоритет";
    HEALBOT_VISIBLE_RANGE                   = "В пределах 100 метров";
    HEALBOT_SPELL_RANGE                     = "В пределах действия заклинания";
    HEALBOT_WORD_RESET                      = "Сброс";
    HEALBOT_HBMENU                          = "HBmenu";
    HEALBOT_ACTION_HBFOCUS                  = "Левый клик - установить\nфокус на цель";
    HEALBOT_WORD_CLEAR                      = "Очистить";
    HEALBOT_WORD_SET                        = "Установить";
    HEALBOT_WORD_HBFOCUS                    = "Фокус HealBot";
    HEALBOT_WORD_OUTSIDE                    = "Внешний мир";
    HEALBOT_WORD_ALLZONE                    = "Все зоны";
    HEALBOT_OPTIONS_TAB_ALERT               = "Тревога";
    HEALBOT_OPTIONS_TAB_SORT                = "Сорт";
    HEALBOT_OPTIONS_TAB_HIDE                = "Скрыть"
    HEALBOT_OPTIONS_TAB_AGGRO               = "Угроза";
    HEALBOT_OPTIONS_TAB_ICONTEXT            = "Текст иконки";
    HEALBOT_OPTIONS_TAB_TEXT                = "Текст панели";
    HEALBOT_OPTIONS_AGGRO3COL               = "Безопастное\nтанкование";
    HEALBOT_OPTIONS_AGGROFLASHFREQ          = "Частота сверкания";
    HEALBOT_OPTIONS_AGGROFLASHALPHA         = "Прозрачность сверкания";
    HEALBOT_OPTIONS_SHOWDURATIONFROM        = "Длительность от";
    HEALBOT_OPTIONS_SHOWDURATIONWARN        = "Оповещение длительности от";
    HEALBOT_CMD_RESETCUSTOMDEBUFFS          = "Сброс своих дебафов";
    HEALBOT_CMD_RESETSKINS                  = "Сброс шкурок";
    HEALBOT_CMD_CLEARBLACKLIST              = "Очистить черный список";
    HEALBOT_CMD_TOGGLEACCEPTSKINS           = "Переключение приёма шкурок от других";
HEALBOT_CMD_TOGGLEDISLIKEMOUNT          = "Toggle Dislike Mount"
HEALBOT_OPTION_DISLIKEMOUNT_ON          = "Now Dislike Mount"
HEALBOT_OPTION_DISLIKEMOUNT_OFF         = "No longer Dislike Mount"
    HEALBOT_CMD_COPYSPELLS                  = "Копировать данное заклинание во все наборы";
    HEALBOT_CMD_RESETSPELLS                 = "Сброс заклинаний";
    HEALBOT_CMD_RESETCURES                  = "Сброс лечений";
    HEALBOT_CMD_RESETBUFFS                  = "Сброс бафов";
    HEALBOT_CMD_RESETBARS                   = "Сброс позицый панелей";
    HEALBOT_CMD_SUPPRESSSOUND               = "Переключение сдерживания звука когда используется авто аксессуар";
    HEALBOT_CMD_SUPPRESSERRORS              = "Переключение сдерживания ошибок когда используется авто аксессуар";
    HEALBOT_OPTIONS_COMMANDS                = "Команды HealBot";
    HEALBOT_WORD_RUN                        = "Пуск";
    HEALBOT_OPTIONS_MOUSEWHEEL              = "Включит меню на колесике мыши";
    HEALBOT_OPTIONS_MOUSEUP                 = "Колёсик вверх"
    HEALBOT_OPTIONS_MOUSEDOWN               = "Колёсик вниз"
HEALBOT_CMD_DELCUSTOMDEBUFF10           = "Delete custom debuffs on priority 10"
    HEALBOT_ACCEPTSKINS                     = "Принемать шкурки от других";
    HEALBOT_SUPPRESSSOUND                   = "Авто-Аксессуар: Подавлять звуки";
    HEALBOT_SUPPRESSERROR                   = "Авто-Аксессуар: Подавлять ошибки";
HEALBOT_OPTIONS_CRASHPROT               = "Crash Protection"
HEALBOT_CP_MACRO_LEN                    = "Macro name must be between 1 and 14 characters"
HEALBOT_CP_MACRO_BASE                   = "Base macro name"
HEALBOT_CP_MACRO_SAVE                   = "Last saved at: "
HEALBOT_CP_STARTTIME                    = "Protect duration on logon"
HEALBOT_WORD_RESERVED                   = "Reserved"
HEALBOT_OPTIONS_COMBATPROT              = "Combat Protection"
HEALBOT_COMBATPROT_PARTYNO              = "bars Reserved for Party"
HEALBOT_COMBATPROT_RAIDNO               = "bars Reserved for Raid"

    HEALBOT_WORD_HEALTH                     = "Здоровье";
    HEALBOT_OPTIONS_DONT_SHOW               = "Не показывать";
HEALBOT_OPTIONS_SAME_AS_HLTH_CURRENT    = "Same as health (current health)"
HEALBOT_OPTIONS_SAME_AS_HLTH_FUTURE     = "Same as health (future health)"
HEALBOT_OPTIONS_FUTURE_HLTH             = "Future health"
    HEALBOT_SKIN_HEALTHBARCOL_TEXT          = "Цвет полосы здоровья";
HEALBOT_SKIN_HEALTHBACKCOL_TEXT         = "Background bar";
    HEALBOT_SKIN_INCHEALBARCOL_TEXT         = "Цвет входящего исцеления";
    HEALBOT_OPTIONS_ALWAYS_SHOW_TARGET      = "Цель: всегда показ.";
    HEALBOT_OPTIONS_ALWAYS_SHOW_FOCUS       = "Фокус: всегда показ.";
    HEALBOT_OPTIONS_GROUP_PETS_BY_FIVE      = "Питомцы: группы из 5и"
    HEALBOT_OPTIONS_USEGAMETOOLTIP          = "Исп. игровую подсказку";
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER        = "Показ. знач. энергии";
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_PALA   = "Показ. энергию света";
HEALBOT_OPTIONS_SHOWPOWERCOUNTER_MONK   = "Show chi power"
HEALBOT_OPTIONS_CUSTOMDEBUFF_REVDUR     = "Reverse Duration"
HEALBOT_OPTIONS_DISABLEHEALBOTSOLO      = "only when solo"
HEALBOT_OPTIONS_CUSTOM_ALLDISEASE       = "All Disease"
HEALBOT_OPTIONS_CUSTOM_ALLMAGIC         = "All Magic"
HEALBOT_OPTIONS_CUSTOM_ALLCURSE         = "All Curse"
HEALBOT_OPTIONS_CUSTOM_ALLPOISON        = "All Poison"
HEALBOT_OPTIONS_CUSTOM_CASTBY           = "Cast By"

    HEALBOT_BLIZZARD_MENU                   = "Меню Blizzard"
    HEALBOT_HB_MENU                         = "Меню Healbot"
    HEALBOT_FOLLOW                          = "Следовать"
    HEALBOT_TRADE                           = "Обмен"
    HEALBOT_PROMOTE_RA                      = "Назначить помощником"
    HEALBOT_DEMOTE_RA                       = "Разжаловать помощника"
    HEALBOT_TOGGLE_ENABLED                  = "Переключениен включения"
    HEALBOT_TOGGLE_MYTARGETS                = "Перекл. моих целей"
    HEALBOT_TOGGLE_PRIVATETANKS             = "Перекл. личных танков"
    HEALBOT_RESET_BAR                       = "Сброс панели"
    HEALBOT_HIDE_BARS                       = "Скрыть полосы дальше 100 метров"
    HEALBOT_RANDOMMOUNT                     = "Случайный транспорт"
    HEALBOT_RANDOMGOUNDMOUNT                = "Случ. наземн. транспорт"
    HEALBOT_RANDOMPET                       = "Случайный спутник"
    HEALBOT_ZONE_AQ40                       = "Ан'Кираж"
    HEALBOT_ZONE_VASHJIR1                   = "Лес Келп’тар"
    HEALBOT_ZONE_VASHJIR2                   = "Мерцающий простор"
    HEALBOT_ZONE_VASHJIR3                   = "Бездонные глубины"
    HEALBOT_ZONE_VASHJIR                    = "Вайш'ир"
HEALBOT_RESLAG_INDICATOR                = "Keep name green after res set to" 
HEALBOT_RESLAG_INDICATOR_ERROR          = "Keep name green after res must be between 1 and 30" 
HEALBOT_FRAMELOCK_BYPASS_OFF            = "Frame lock bypass turned Off"
HEALBOT_FRAMELOCK_BYPASS_ON             = "Frame lock bypass (Ctl+Alt+Left) turned On"
HEALBOT_RESTRICTTARGETBAR_ON            = "Restrict Target bar turned On"
HEALBOT_RESTRICTTARGETBAR_OFF           = "Restrict Target bar turned Off"
HEALBOT_PRELOADOPTIONS_ON               = "PreLoad Options turned On"
HEALBOT_PRELOADOPTIONS_OFF              = "PreLoad Options turned Off"
HEALBOT_AGGRO2_ERROR_MSG                = "To set aggro level 2, threat percentage must be between 25 and 95"
HEALBOT_AGGRO3_ERROR_MSG                = "To set aggro level 3, threat percentage must be between 75 and 100"
HEALBOT_AGGRO2_SET_MSG                  = "Aggro level 2 set at threat percentage "
HEALBOT_AGGRO3_SET_MSG                  = "Aggro level 3 set at threat percentage "
HEALBOT_WORD_THREAT                     = "Threat"
HEALBOT_AGGRO_ERROR_MSG                 = "Invalid aggro level - use 2 or 3"

HEALBOT_OPTIONS_QUERYTALENTS            = "Query talent data"       
HEALBOT_OPTIONS_LOWMANAINDICATOR        = "Low Mana indicator"
HEALBOT_OPTIONS_LOWMANAINDICATOR1       = "Don't show"
HEALBOT_OPTIONS_LOWMANAINDICATOR2       = "*10% / **20% / ***30%"
HEALBOT_OPTIONS_LOWMANAINDICATOR3       = "*15% / **30% / ***45%"
HEALBOT_OPTIONS_LOWMANAINDICATOR4       = "*20% / **40% / ***60%"
HEALBOT_OPTIONS_LOWMANAINDICATOR5       = "*25% / **50% / ***75%"
HEALBOT_OPTIONS_LOWMANAINDICATOR6       = "*30% / **60% / ***90%"

HEALBOT_OPTION_IGNORE_AURA_RESTED       = "Ignore aura events when resting"

HEALBOT_WORD_ENABLE                     = "Enable"
HEALBOT_WORD_DISABLE                    = "Disable"

HEALBOT_OPTIONS_MYCLASS                 = "My Class"

HEALBOT_OPTIONS_CONTENT_ABOUT           = "        About"
HEALBOT_OPTIONS_CONTENT_GENERAL         = "        " .. HEALBOT_OPTIONS_TAB_GENERAL
HEALBOT_OPTIONS_CONTENT_SPELLS          = "        " .. HEALBOT_OPTIONS_TAB_SPELLS
HEALBOT_OPTIONS_CONTENT_SKINS           = "        " .. HEALBOT_OPTIONS_TAB_SKIN
HEALBOT_OPTIONS_CONTENT_CURE            = "        " .. HEALBOT_OPTIONS_TAB_CDC
HEALBOT_OPTIONS_CONTENT_BUFFS           = "        " .. HEALBOT_OPTIONS_TAB_BUFFS
HEALBOT_OPTIONS_CONTENT_TIPS            = "        " .. HEALBOT_OPTIONS_TAB_TIPS
HEALBOT_OPTIONS_CONTENT_MOUSEWHEEL      = "        Mouse Wheel"
HEALBOT_OPTIONS_CONTENT_TEST            = "        Test"
HEALBOT_OPTIONS_CONTENT_USAGE           = "        Usage"
HEALBOT_OPTIONS_REFRESH                 = "Refresh"

    HEALBOT_CUSTOM_CATEGORY                 = "Категория";
    HEALBOT_CUSTOM_CAT_CUSTOM               = "Свой";
HEALBOT_CUSTOM_CAT_02                   = "A - B"   -- ****************************************************
HEALBOT_CUSTOM_CAT_03                   = "C - D"   -- Custom Debuff Categories can be translated
HEALBOT_CUSTOM_CAT_04                   = "E - F"   -- 
HEALBOT_CUSTOM_CAT_05                   = "G - H"   -- If translating into a language with a completely different alphabet,
HEALBOT_CUSTOM_CAT_06                   = "I - J"   -- the descriptions of HEALBOT_CUSTOM_CAT_02 - HEALBOT_CUSTOM_CAT_14 can be changed.
HEALBOT_CUSTOM_CAT_07                   = "K - L"   -- Just ensure all 13 variables are used
HEALBOT_CUSTOM_CAT_08                   = "M - N"   -- 
HEALBOT_CUSTOM_CAT_09                   = "O - P"   -- Setting debuffs in HEALBOT_CUSTOM_DEBUFF_CATS,
HEALBOT_CUSTOM_CAT_10                   = "Q - R"   -- The only rule is the category number needs to match the last digits of the variable names, for example:
HEALBOT_CUSTOM_CAT_11                   = "S - T"   -- If HEALBOT_DEBUFF_AGONIZING_FLAMES starts with an T in a different region
HEALBOT_CUSTOM_CAT_12                   = "U - V"   -- the category would be 11, simply change the 2 to 11.
HEALBOT_CUSTOM_CAT_13                   = "W - X"   --
HEALBOT_CUSTOM_CAT_14                   = "Y - Z"   -- ****************************************************

HEALBOT_CUSTOM_CASTBY_EVERYONE          = "Everyone"
HEALBOT_CUSTOM_CASTBY_ENEMY             = "Enemy"
HEALBOT_CUSTOM_CASTBY_FRIEND            = "Friend"

HEALBOT_CUSTOM_DEBUFF_CATS = {
        [HEALBOT_DEBUFF_ACID_DRENCHED_MANDIBLES] = 2,
        [HEALBOT_DEBUFF_AGONIZING_FLAMES]      = 2,
        [HEALBOT_DEBUFF_BOILING_BLOOD]         = 2,
        [HEALBOT_DEBUFF_BURN]                  = 2,
        [HEALBOT_DEBUFF_BURNING_BILE]          = 2,
        [HEALBOT_DEBUFF_CHILLED_BONE]          = 3,
        [HEALBOT_DEBUFF_COMBUSTION]            = 3,
        [HEALBOT_DEBUFF_CONFLAGRATION]         = 3,
        [HEALBOT_DEBUFF_CONSUMING_FLAMES]      = 3,
        [HEALBOT_DEBUFF_CONSUMPTION]           = 3,
        [HEALBOT_DEBUFF_CORROSION]             = 3,
        [HEALBOT_DEBUFF_DARK_BARRAGE]          = 3,
        [HEALBOT_DEBUFF_DEFILE]                = 3,
        [HEALBOT_DEBUFF_DELIRIOUS_SLASH]       = 3,
        [HEALBOT_DEBUFF_DOOMFIRE]              = 3,
        [HEALBOT_DEBUFF_ENCAPSULATE]           = 4,
        [HEALBOT_DEBUFF_ESSENCE_BLOOD_QUEEN]   = 4,
        [HEALBOT_DEBUFF_EXPLOSIVE_CINDERS]     = 4,
        [HEALBOT_DEBUFF_EXPOSE_WEAKNESS]       = 4,
        [HEALBOT_DEBUFF_FATAL_ATTRACTION]      = 4,
        [HEALBOT_DEBUFF_FEL_RAGE]              = 4,
        [HEALBOT_DEBUFF_FEL_RAGE2]             = 4,
        [HEALBOT_DEBUFF_FERAL_POUNCE]          = 4, 
        [HEALBOT_DEBUFF_FIERY_COMBUSTION]      = 4,
        [HEALBOT_DEBUFF_FIRE_BLOOM]            = 4,
        [HEALBOT_DEBUFF_FIRE_BOMB]             = 4,
        [HEALBOT_DEBUFF_FLAME_SEAR]            = 4, 
        [HEALBOT_DEBUFF_FLASH_FREEZE]          = 4,
        [HEALBOT_DEBUFF_FROST_BEACON]          = 4,
        [HEALBOT_DEBUFF_FROST_BLAST]           = 4,
        [HEALBOT_DEBUFF_FROST_BREATH]          = 4,
        [HEALBOT_DEBUFF_FROST_TOMB]            = 4,
        [HEALBOT_DEBUFF_GAS_SPORE]             = 5,
        [HEALBOT_DEBUFF_GASEOUS_BLOAT]         = 5,
        [HEALBOT_DEBUFF_GASTRIC_BLOAT]         = 5,
        [HEALBOT_DEBUFF_GLITTERING_SPARKS]     = 5,
        [HEALBOT_DEBUFF_GRAVITY_BOMB]          = 5,
        [HEALBOT_DEBUFF_GRAVITY_CORE]          = 5,
        [HEALBOT_DEBUFF_GRAVITY_CRUSH]         = 5,
        [HEALBOT_DEBUFF_GRIEVOUS_BITE]         = 5,         
        [HEALBOT_DEBUFF_GRIEVOUS_THROW]        = 5,
        [HEALBOT_DEBUFF_GUT_SPRAY]             = 5,
        [HEALBOT_DEBUFF_HARVEST_SOUL]          = 5,
        [HEALBOT_DEBUFF_ICEBOLT]               = 6,
        [HEALBOT_DEBUFF_ICE_TOMB]              = 6,
        [HEALBOT_DEBUFF_IMPALE]                = 6,
        [HEALBOT_DEBUFF_IMPALED]               = 6,
        [HEALBOT_DEBUFF_IMPALING_SPINE]        = 6,
        [HEALBOT_DEBUFF_INCINERATE_FLESH]      = 6,
        [HEALBOT_DEBUFF_INFEST]                = 6,
        [HEALBOT_DEBUFF_INSTABILITY]           = 6,
        [HEALBOT_DEBUFF_IRON_ROOTS]            = 6,
        [HEALBOT_DEBUFF_JAGGED_KNIFE]          = 6, 
        [HEALBOT_DEBUFF_LEGION_FLAME]          = 7, 
        [HEALBOT_DEBUFF_LIGHTNING_ROD]         = 7,
        [HEALBOT_DEBUFF_FALLEN_CHAMPION]       = 8,
        [HEALBOT_DEBUFF_MISTRESS_KISS]         = 8,
        [HEALBOT_DEBUFF_MUTATED_INFECTION]     = 8,
        [HEALBOT_DEBUFF_MUTATED_PLAGUE]        = 8,
        [HEALBOT_DEBUFF_MYSTIC_BUFFET]         = 8,
        [HEALBOT_DEBUFF_NAPALM_SHELL]          = 8,
        [HEALBOT_DEBUFF_NECROTIC_PLAGUE]       = 8,
        [HEALBOT_DEBUFF_NECROTIC_STRIKE]       = 8,
        [HEALBOT_DEBUFF_PACT_DARKFALLEN]       = 9,
        [HEALBOT_DEBUFF_PARALYTIC_TOXIN]       = 9,
        [HEALBOT_DEBUFF_PARASITIC_INFECT]      = 9,
        [HEALBOT_DEBUFF_PARASITIC_SHADOWFIEND] = 9,
        [HEALBOT_DEBUFF_PENETRATING_COLD]      = 9,
        [HEALBOT_DEBUFF_RUNE_OF_BLOOD]         = 10,
        [HEALBOT_DEBUFF_SACRIFICE]             = 11,
        [HEALBOT_DEBUFF_SARA_BLESSING]         = 11,
        [HEALBOT_DEBUFF_SHADOW_PRISON]         = 11,
        [HEALBOT_DEBUFF_SLAG_POT]              = 11,
        [HEALBOT_DEBUFF_SNOBOLLED]             = 11,
        [HEALBOT_DEBUFF_SOUL_CONSUMPTION]      = 11,
        [HEALBOT_DEBUFF_SPINNING_PAIN_SPIKE]   = 11,
        [HEALBOT_DEBUFF_STONE_GRIP]            = 11,
        [HEALBOT_DEBUFF_SWARMING_SHADOWS]      = 11,
        [HEALBOT_DEBUFF_TOUCH_OF_DARKNESS]     = 11,
        [HEALBOT_DEBUFF_TOUCH_OF_LIGHT]        = 11,
        [HEALBOT_DEBUFF_TOXIC_SPORES]          = 11,
        [HEALBOT_DEBUFF_VILE_GAS]              = 12,
        [HEALBOT_DEBUFF_VOLATILE_OOZE]         = 12,
        [HEALBOT_DEBUFF_WATERLOGGED]           = 13,
        [HEALBOT_DEBUFF_WEB_WRAP]              = 13,
    }

HEALBOT_ABOUT_DESC1                    = "Add a panel with skinable bars for healing, decursive, buffing, ressing and aggro tracking"
HEALBOT_ABOUT_WEBSITE                  = "Website:"
HEALBOT_ABOUT_AUTHORH                  = "Author:"
HEALBOT_ABOUT_AUTHORD                  = "Strife"
HEALBOT_ABOUT_EMAILH                   = "Email:"
HEALBOT_ABOUT_EMAILD                   = "healbot@outlook.com"
HEALBOT_ABOUT_CATH                     = "Category:"
HEALBOT_ABOUT_CATD                     = "Unit Frames, Buffs and Debuffs, Combat:Healer"
HEALBOT_ABOUT_CREDITH                  = "Credits:"
HEALBOT_ABOUT_CREDITD                  = "Acirac, Kubik, Von, Aldetal, Brezza"  -- Anyone taking on translations (if required), feel free to add yourself here.
HEALBOT_ABOUT_LOCALH                   = "Localizations:"
HEALBOT_ABOUT_LOCALD                   = "deDE, enUK, esES, frFR, huHU, itIT, koKR, poBR, ruRU, zhCN, zhTW"
HEALBOT_ABOUT_FAQH                     = "Frequently Asked Questions"
HEALBOT_ABOUT_FAQ_QUESTION             = "Question"
HEALBOT_ABOUT_FAQ_ANSWER               = "Answer"

HEALBOT_ABOUT_FAQ_QUESTIONS = {   [1]   = "Buffs - All the bars are White, what happened",
                                  [2]   = "Casting - Sometimes the cursor turns blue and I can't do anything",
                                  [3]   = "Macros - Do you have any cooldown examples",
                                  [4]   = "Macros - Do you have any spell casting examples",
                                  [5]   = "Mouse - How do I use my mouseover macros with the mouse wheel",
                                  [6]   = "Options - Can bars be sorted by groups, for example have 2 groups per column",
                                  [7]   = "Options - Can I hide all the bars and only show those needing a debuff removed",
                                  [8]   = "Options - Can I hide the incoming heals",
                                  [9]   = "Options - Healbot does not save my options when i logout/logon",
                                  [10]   = "Options - How do I always use enabled settings",
                                  [11]  = "Options - How do I disable healbot automatically",
                                  [12]  = "Options - How do I make the bars grow a different direction",
                                  [13]  = "Options - How do I setup 'My Targets'",
                                  [14]  = "Options - How do I setup 'Private Tanks'",
                                  [15]  = "Options - Will Healbot create a bar for an NPC",
                                  [16]  = "Range - I can't see when people are out of range, how do I fix this",
                                  [17]  = "Spells - Healbot casts a different spell to my setup",
                                  [18]  = "Spells - I can no longer cast heals on unwounded targets",
                              }

HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01       = "This is due to options set on the Spells tab \n" ..
                                          "try changing the following and testing: \n\n" ..
                                          "     1: On the spells tab: Turn on Always Use Enabled \n" ..
                                          "     2: On the spells tab: Turn off SmartCast \n\n" ..
                                          "Note: It is expected that most users will want to \n"..
                                          "          turn SmartCast back on \n\n" ..
                                          "Note: It is expected that experienced users will want to \n" ..
                                          "          turn off Always Use Enabled  \n" ..
                                          "          and set the spells for disabled bars"
                                          
HEALBOT_ABOUT_FAQ_ANSWERS = {     [1]   = "You are monitoring for missing buffs \n\n" .. 
                                          "This can be turned off on the buffs tab \n" ..
                                          "Alternatively click on the bar and cast the buff",
                                  [2]   = "This is blizzard functionality, not Healbot \n\n" .. 
                                          "Using the standard blizzard frames, \n" ..
                                          "try casting a spell thats on Cooldown \n" ..
                                          "Notice how the cursor turns blue. \n\n" ..
                                          "Note: Nothing can be done to prevent this while \n" ..
                                          "in combat, since WoW 2.0 Blizzard has locked down \n" ..
                                          "the ui while in combat stopping all addons from \n" ..
                                          "changing spells or targets from what has been predefined \n\n" ..
                                          "It may help to monitor the spell cooldown in the tooltips",
                                  [3]   = "Yes \n\n"..
                                          "Paladin Hand of Salvation cooldown macro example: \n\n" ..
                                          "    #show Hand of Salvation \n" ..
                                          '    /script local n=UnitName("hbtarget"); ' .. "\n" ..
                                          '    if GetSpellCooldown("Hand of Salvation")==0 then ' .. " \n" ..
                                          '        SendChatMessage("Hand of Salvation on "..n,"YELL") ' .. "\n" ..
                                          '        SendChatMessage("Hand of Salvation!","WHISPER",nil,n) ' .. "\n" ..
                                          "    end; \n" ..
                                          "    /cast [@hbtarget] Hand of Salvation",
                                  [4]   = "Yes \n\n"..
                                          "Preist Flash Heal, example using both trinkets: \n\n" ..
                                          "    #show Flash Heal \n" ..
                                          "    /script UIErrorsFrame:Hide() \n" ..
                                          "    /console Sound_EnableSFX 0 \n" ..
                                          "    /use 13 \n" ..
                                          "    /use 14 \n" ..
                                          "    /console Sound_EnableSFX 1 \n" ..
                                          "    /cast [@hbtarget] Flash Heal \n" ..
                                          "    /script UIErrorsFrame:Clear(); UIErrorsFrame:Show()",
                                  [5]   = "1: On the Mouse Wheel tab: Turn off Use Mouse Wheel \n" ..
                                          "2: Bind your macros to blizzard's bindings with [@mouseover] \n\n\n" ..
                                          "Eample macro: \n\n" ..
                                          "    #showtooltip Flash Heal \n" ..
                                          "    /cast [@mouseover] Flash Heal \n",
                                  [6]   = "Yes \n\n\n"..
                                          "With Headers: \n" ..
                                          "     1: On the Skins>Headers tab, switch on Show Headers \n" ..
                                          "     2: On the Skins>Bars tab, set Number of Groups per column \n\n" ..
                                          "Without Headers: \n" ..
                                          "     1: On the Skins>Bars tab, switch on Use Groups per Column \n" ..
                                          "     2: On the Skins>Bars tab, set Number of Groups per column ",
                                  [7]   = "Yes \n\n"..
                                          "1: On the Skins>Healing>Alert tab, set Alert Level to 0 \n" ..
                                          "2: On the Skins>Aggro tab, turn off the Aggro Monitor \n" .. 
                                          "3: On the Skins>Bars tab, set Disabled opacity to 0 \n" ..
                                          "4: On the Skins>Bars tab, set Background opacity to 0 \n" ..
                                          "5: On the Skins>Bar Text tab, click on the bar Disabled \n" ..
                                          "     and set the Disabled text opacity to 0 \n" ..
                                          "6: On the Skins>General tab, click on the bar Background \n" ..
                                          "     and set the Background opacity to 0 \n" ..
                                          "7: On the Cure tab, Turn on debuff monitoring",
                                  [8]   = "Yes \n\n"..
                                          "1: On the Skins>Bars tab, set Incoming Heals to Dont Show \n" ..
                                          "2: On the Skins>Bar Text tab, \n" ..
                                          "          set Show Health on Bar to No Incoming Heals",
                                  [9]   = "This has been present since a change in WoW 3.2, \n" ..
                                          "it can affects characters with weird letters in their name \n\n" ..
                                          "If your on Vista or Win7, try the follow: \n"..
                                          "     change system locale to English (for non-unicode programs) \n" ..
                                          "     in Control Panel > Region and Language > Administrative Tab",

                                  [10]   = "On the spells tab turn on Always Use Enabled \n\n" ..
                                          "Some my also want to set the Alert Level to 100 \n" ..
                                          "This can be done on the Skins>Healing>Alert tab",
                                  [11]  = "Disable for a character: \n\n" ..
                                          "     1: Open the General tab \n" ..
                                          "     2: Turn on the Disable option \n\n\n" ..
                                          "Disable when solo: \n\n" ..
                                          "     1: Open the General tab \n" ..
                                          "     2: To the right of the Disable option, Select only when solo \n" ..
                                          "     3: Turn on the Disable option",
                                  [12]  = "Change the Bars Anchor setting on the Skins>General tab  \n\n" ..
                                          "     Top Right:        the bars will grow Down and Left \n" ..
                                          "     Top Left:          the bars will grow Down and Right \n" ..
                                          "     Bottom Right:  the bars will grow Up and Left \n" ..
                                          "     Bottom Left:     the bars will grow Up and Right",
                                  [13]  = "My Targets allows you to create a list of Targets you want to \n" ..
                                          "group separately from others, similar to the MT group \n\n" ..
                                          "The following options are available for \n" .. 
                                          "adding/removing people to/from the My Targets group \n\n" ..
                                          "     - Shift+Ctrl+Alt+Right click on the bar \n" ..
                                          '     - Use the Healbot Menu, enter "hbmenu" on the spells tab ' .. "\n" ..
                                          "     - Use the Mouse Wheel, set on the Mouse Wheel tab",
                                  [14]  = "Private Tanks can be added to the Main Tanks list, \n" ..
                                          "the Private tanks are only visible in your Healbot \n" ..
                                          "and do not affect other players or addons \n\n" ..
                                          "The following options are available for \n" ..
                                          "adding/removing people to/from the Tanks list \n\n" ..
                                          '     - Use the Healbot Menu, enter "hbmenu" on the spells tab ' .. "\n" ..
                                          "     - Use the Mouse Wheel, set on the Mouse Wheel tab",
                                  
                                  [15]  = "Yes \n\n"..
                                          "     1: On the Skins>Healing tab, turn on Focus \n" ..
                                          "     2: set your focus on the NPC (or PC not in raid/party) \n" ..
                                          "          Healbot will create a bar in your My Targets list \n\n" ..
                                          "Note: If in a combat situation where you zone in and out while \n" ..
                                          "          in combat and need to reset focus on an NPC \n" ..
                                          "          on the Skins>Healing tab set Focus: always show to on \n" ..
                                          "          This will keep the bar available during combat. \n\n" ..
                                          "Note: The HealBot Menu has the option 'Set HealBot Focus' \n" ..
                                          "          This can make setting focus easy on NPC's and \n" ..
                                          "          serves as a reminder to set focus. \n\n" ..
                                          "          Enter 'hbmenu' on the spells tab to use HealBot Menu \n" ..
                                          "          or use the Mouse Wheel tab to and set HealBot Menu",
                                  [16]  = "1:  On the Skins>Bars tab, adjust the disabled bar opacity \n" ..
                                          "2:  On the Skins>Bars Text tab, adjust the disabled text opacity \n" ..
                                          "       To do this click on the bar labeled Disabled. \n\n" ..
                                          "Some my also want to set the Alert Level to 100 \n" ..
                                          "This can be done on the Skins>Healing>Alert tab",
                                  [17]  = "Actually Healbot is casting exacly as the setup. \n\n" .. HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01,
                                  [18]  = HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01,
                              }

HEALBOT_OPTIONS_SKINAUTHOR              = "Skin Author:"
HEALBOT_OPTIONS_AVOIDBLUECURSOR         = "Avoid\nBlue Cursor"
HEALBOT_PLAYER_OF_REALM                 = "of"
    
    HEALBOT_OPTIONS_LANG                    = "Language"
    HEALBOT_OPTIONS_LANG_ZHCN               = "Chinese (zhCN - by Ydzzs)"
    HEALBOT_OPTIONS_LANG_ENUK               = "English (enUK - by Strife)"
    HEALBOT_OPTIONS_LANG_ENUS               = "English (enUS - by Strife)"
    HEALBOT_OPTIONS_LANG_FRFR               = "French (frFR - by Kubik)"
    HEALBOT_OPTIONS_LANG_DEDE               = "German (deDE - translator required)"
    HEALBOT_OPTIONS_LANG_HUHU               = "Hungarian (huHU - by Von)"
    HEALBOT_OPTIONS_LANG_ITIT               = "Italian (itIT - by Brezza)"
    HEALBOT_OPTIONS_LANG_KRKR               = "Korean (krKR - translator required)"
    HEALBOT_OPTIONS_LANG_PTBR               = "Portuguese (ptBR - by aldetal)"
    HEALBOT_OPTIONS_LANG_RURU               = "Russian (ruRU - translator required)"
    HEALBOT_OPTIONS_LANG_ESES               = "Spanish (esES - translator required)"
    HEALBOT_OPTIONS_LANG_TWTW               = "Taiwanese (twTW - translator required)"
    
    HEALBOT_OPTIONS_LANG_ADDON_FAIL1        = "Failed to load addon for localization"
    HEALBOT_OPTIONS_LANG_ADDON_FAIL2        = "Reason for failure is:"
    HEALBOT_OPTIONS_LANG_ADDON_FAIL3        = "Note in the current verison, this is the only warning for"
    
    HEALBOT_OPTIONS_ADDON_FAIL              = "Failed to load headbot addon"
    
    HEALBOT_OPTIONS_CONTENT_SKINS_GENERAL   = "        " .. HEALBOT_OPTIONS_TAB_GENERAL
    HEALBOT_OPTIONS_CONTENT_SKINS_HEALING   = "        " .. HEALBOT_OPTIONS_TAB_HEALING
    HEALBOT_OPTIONS_CONTENT_SKINS_HEADERS   = "        " .. HEALBOT_OPTIONS_TAB_HEADERS
    HEALBOT_OPTIONS_CONTENT_SKINS_BARS      = "        " .. HEALBOT_OPTIONS_TAB_BARS
    HEALBOT_OPTIONS_CONTENT_SKINS_ICONS     = "        " .. HEALBOT_OPTIONS_TAB_ICONS
    HEALBOT_OPTIONS_CONTENT_SKINS_AGGRO     = "        " .. HEALBOT_OPTIONS_TAB_AGGRO
    HEALBOT_OPTIONS_CONTENT_SKINS_PROT      = "        " .. HEALBOT_OPTIONS_TAB_PROTECTION
    HEALBOT_OPTIONS_CONTENT_SKINS_CHAT      = "        " .. HEALBOT_OPTIONS_TAB_CHAT
    HEALBOT_OPTIONS_CONTENT_SKINS_TEXT      = "        " .. HEALBOT_OPTIONS_TAB_TEXT
    HEALBOT_OPTIONS_CONTENT_SKINS_ICONTEXT  = "        " .. HEALBOT_OPTIONS_TAB_ICONTEXT

    HEALBOT_OPTIONS_CONTENT_CURE_DEBUFF     = "        " .. HEALBOT_SKIN_DEBTEXT
    HEALBOT_OPTIONS_CONTENT_CURE_CUSTOM     = "        " .. HEALBOT_CLASSES_CUSTOM
    HEALBOT_OPTIONS_CONTENT_CURE_WARNING    = "        " .. HEALBOT_OPTIONS_TAB_WARNING
end
